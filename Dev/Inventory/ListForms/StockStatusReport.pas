// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //12/05/05  1.00.01  BJ  Variable group entries added into the list

unit StockStatusReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, wwcheckbox, MyAccess,ERPdbComponents,
  MemDS, DBAccess, wwdbdatetimepicker,
  BaseInputForm,
  //ERP
  MessageConst, ProgressDialog,  Shader, kbmMemTable, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockStatusReportGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    qryMainID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainformName: TWideStringField;
    qryMainStockmovementEntryglobalref: TWideStringField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainTransactionNo: TLargeintField;
    qryMainProduct: TWideStringField;
    qryMainQty: TFloatField;
    qryMainTotalCost: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainPeriod: TWideStringField;
    qryMainPeriodtoOrder: TDateField;
    qryMainProductPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure FormShow(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
  private
    fstablename :String;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    Procedure SetGridColumns;override;
  public
  end;

implementation

uses pqalib, FastFuncs,
  AppEnvironment, CommonLib, ProductQtyLib, Dateutils,
  busobjStockMovement, BusobjStockAdjustEntry, busobjstockTransferentry,
  FormFactory, MySQLConst, CommonDbLib, tcDataUtils;
{$R *.dfm}

{ TStockStatusReportGUI }

procedure TStockStatusReportGUI.RefreshQuery;
begin
  // Mode Number
  //    0 - Day
  //    1 - Weekday
  //    2 - Week
  //    3 - Month
  //    4 - Quarter
  //    5 - Year

  Qrymain.DisableControls;
  Try
    if Qrymain.active then Qrymain.close;
    with CommonDbLib.TempMyScript do try
      connection := qrymain.Connection;
      SQL.Add('truncate '+fstablename +';');
      SQL.Add('insert into '+fstablename +'(`Trans Type`,formName,StockmovementEntryglobalref,Firstcolumn,Secondcolumn,Thirdcolumn,TransactionNo,Product,ProductPrintName,Qty,`Total Cost`,ClassName,Period)'); //,PeriodtoOrder)');
      SQL.Add('Select ');
      SQL.Add('if(ifnull(SMTT.Description,"")<> "" ,SMTT.Description, ');
      SQL.Add('if(ifnull(TT.Description,"") = "" , PQA.TransType , TT.Description)) as "Trans Type",');
      SQL.Add('TT.FormName as formName,');
      SQL.Add('SM.StockmovementEntryglobalref,');
      SQL.Add(Firstcolumn + ' AS Firstcolumn,');
      SQL.Add(Secondcolumn + ' AS Secondcolumn,');
      SQL.Add(Thirdcolumn + ' AS Thirdcolumn,');
      if grpFilters.itemindex = 0 then SQL.Add('PQA.TransID as "TransactionNo",')
      else SQL.Add('0 as "TransactionNo",');
      SQL.Add('P.PartName as Product,');
      SQL.Add('P.ProductPrintName as ProductPrintName,');
      SQL.Add(SQL4Qty(tTransQty) + ' as Qty,');
      SQL.Add('P.AvgCost* ' + SQL4Qty(tTransQty) +' as "Total Cost",');
      SQL.Add('PC.ClassName as ClassName,');
      case grpFilters.ItemIndex of
        0:SQL.Add('Date_Format(PQA.TransDate,"%d-%m-%Y") as Period');
        1:SQL.Add('Date_Format(PQA.TransDate,"%W")       as Period');
        2:SQL.Add('Date_Format(PQA.TransDate,"%U")       as Period');
        3:SQL.Add('Date_Format(PQA.TransDate,"%M")       as Period');
        4:SQL.Add('QUARTER(PQA.TransDate)               as Period');
        5:SQL.Add('Date_Format(PQA.TransDate,"%Y")       as Period');
      end;
      SQL.Add('FROM ' + ProductTables(tsummary, False , true));
      SQL.Add('LEFt JOIN tblStockMovement SM on SM.StockmovementId = PQA.TransId and PQA.TransType = ' + QuotedStr(TStockMovementLines.classname));
      SQL.Add('LEFt JOIN tblpqatranstypes as SMTT on SM.StockmovementEntryType = SMTT.TransType');


      SQL.Add('WHERE P.Active ="T" and PQA.Active = "T"');
      if chkAllClass.checked = False then
        SQL.Add(' AND PC.ClassId = ' + IntToStr(cboClassQry.fieldByname('ClassID').asInteger));
      SQL.Add('AND PQA.TransDate between ' + QuotedStr(FormatDateTime(MysqlDateFormat , dtFrom.date)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat , incDay(dtTo.date))));
      SQL.Add('group by ' );
      case grpFilters.ItemIndex of
        0:SQL.Add('Date(PQA.TransDate),');
        1:SQL.Add('WEEKDAY(PQA.TransDate),');
        2:SQL.Add('WEEK(PQA.TransDate,3), ');
        3:SQL.Add('MONTH(PQA.TransDate),  ');
        4:SQL.Add('QUARTER(PQA.TransDate),');
        5:SQL.Add('YEAR(PQA.TransDate) ,  ');
      end;
      SQL.Add('TT.Description , P.PartName ,');
      if grpFilters.ItemIndex=0 then SQL.Add('PQA.TransID,');
      SQL.Add('PC.ClasSName');
      SQL.Add('Order by ');
      case grpFilters.ItemIndex of
        0:SQL.Add('Date(PQA.TransDate),');
        1:SQL.Add('WEEKDAY(PQA.TransDate),');
        2:SQL.Add('WEEK(PQA.TransDate,3), ');
        3:SQL.Add('MONTH(PQA.TransDate),  ');
        4:SQL.Add('QUARTER(PQA.TransDate),');
        5:SQL.Add('YEAR(PQA.TransDate) ,  ');
      end;
      SQL.Add('P.PartNAme ,');
      if grpFilters.ItemIndex=0 then SQL.Add('PQA.TransID,');
      SQL.Add('PC.className ,TT.Description');
      Execute;
    finally
        Free;
    end;
    inherited;
    qryMain.FieldByName('TRansactionno').DisplayLabel           := 'Transaction Number';
    TFloatField(qryMain.FieldByName('Total Cost')).DisplayFormat:= AppEnv.RegionalOptions.CurrencySymbol+'#,###,##0.00';
  finally
    qrymain.EnableControls;
  end;
end;

procedure TStockStatusReportGUI.FormCreate(Sender: TObject);
begin
  fstablename := CommonDbLib.CreateUserTemporaryTable('tmp_SSR');
  qrymain.SQl.text := StringReplace(Qrymain.SQL.text , 'tmp_SSR' , fsTablename, [rfIgnoreCase]);
  inherited;
  RefreshOrignalSQL;
  if not ErrorOccurred then begin
    cboClassQry.Connection := qryMain.Connection;
  end;
end;

procedure TStockStatusReportGUI.RefreshTotals;
var
  Qtys, ACosts: double;
begin
  Qtys := 0.00;
  ACosts := 0.00;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      Qtys := Qtys + qryMain.FieldByName('Qty').AsCurrency;
      ACosts := ACosts + qryMain.FieldByName('Total Cost').AsCurrency;
      Next;
    end;
  end;

  qryMain.EnableControls;
  qryMain.First;
  grdMain.ColumnByName('Qty').FooterValue := FloatToStrF(Qtys, ffFixed, 15, 2);
  grdMain.ColumnByName('Total Cost').FooterValue := FloatToStrF(ACosts, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TStockStatusReportGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TStockStatusReportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    RefreshQuery;
  end;
end;

procedure TStockStatusReportGUI.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  inherited;
  if not ErrorOccurred then begin
    cboClassQry.Open;
    RefreshQuery;
  end;
end;

procedure TStockStatusReportGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TStockStatusReportGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;

  RefreshQuery;
end;

procedure TStockStatusReportGUI.grdMainDblClick(Sender: TObject);
begin
       if (Sysutils.SameText((*qryMain.FieldByname('Trans Type')*)qryMainTransType.asString , TStockAdjustEntry.Transtype))   then SubsequentID := Chr(95) + AdjustType(TStockMovement.TransactionID(Qrymain.fieldbyname('TransactionNo').asInteger))   +  qryMain.Fields.FieldByName('Type').AsString
  else if (Sysutils.SameText((*qryMain.FieldByname('Trans Type')*)qryMainTransType.asString , TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(TStockMovement.TransactionID(Qrymain.fieldbyname('TransactionNo').asInteger)) +  qryMain.Fields.FieldByName('Type').AsString
  else SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Trans Type').AsString;

  if qryMain.FieldByName('TransactionNo').AsInteger <> 0 then begin
    inherited;
  end;
end;

procedure TStockStatusReportGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText((*qryMain.FieldByname('Trans Type')*)qryMainTransType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText((*qryMain.FieldByname('Trans Type')*)qryMainTransType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := TStockMovement.TransactionID(Qrymain.fieldbyname('TransactionNo').asInteger);
  end;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TStockStatusReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('id');
  RemoveFieldfromGrid('PeriodtoOrder');
  RemoveFieldfromGrid('FormName');
  RemoveFieldfromGrid('StockmovementEntryglobalref');
end;

procedure TStockStatusReportGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

initialization
  RegisterClassOnce(TStockStatusReportGUI);
end.
