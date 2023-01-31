unit ProductPurchaseMovementList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, ComCtrls, DAScript, MyScript,
  wwcheckbox, CustomInputBox;

type
  TProductPurchaseMovementListGUI = class(TBaseListingGUI)
    dtpPurchFrom: TDateTimePicker;
    Label12: TLabel;
    Label13: TLabel;
    dtpPurchTo: TDateTimePicker;
    QryProductLookup: TERPQuery;
    QryProductLookupPARTSID: TIntegerField;
    QryProductLookupPARTNAME: TWideStringField;
    cboProduct: TwwDBLookupCombo;
    lblProduct: TLabel;
    qryMainID: TIntegerField;
    qryMainMonth_name: TWideStringField;
    qryMainTotalestimatedAmountInc: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainQtysold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainAverage: TFloatField;
    qryMainMovement: TFloatField;
    qryMainPercentage: TFloatField;
    QryTotPurchase: TERPQuery;
    QryTotPurchaseTotal: TFloatField;
    qryMainMonthno: TIntegerField;
    qryMainyearno: TIntegerField;
    procedure dtpPurchFromChange(Sender: TObject);
    procedure dtpPurchToChange(Sender: TObject);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    tablename :String;
    Calculating:boolean;
    fiProductId: Integer;
    procedure OpenProductQry;
    procedure SetProductID(const Value: Integer);
    procedure beforeshowProductPurchaseMovementDetails(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery; Override;
    Property ProductId :Integer read fiProductId write SetProductID;
  end;

implementation

uses CommonLib , Dateutils, CommonDbLib, AppEnvironment, MySQLConst, DNMLib,
   ProductPurchaseMovementDetails, CommonFormLib;

{$R *.dfm}

procedure TProductPurchaseMovementListGUI.cboProductCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductPurchaseMovementListGUI.dtpPurchFromChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductPurchaseMovementListGUI.dtpPurchToChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;
procedure TProductPurchaseMovementListGUI.OpenProductQry;
begin
  if QryProductLookup.active =False then begin
    QryProductLookup.Connection := Qrymain.Connection;
    QryProductLookup.open;
  end;
end;
procedure TProductPurchaseMovementListGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  rPrevTotAmount:Double;
  s:String;
  TotPurchase :double;
begin
  inherited;
  if Calculating then exit;
  Calculating:= True;
  try
    if Qrymain.RecordCount =0 then exit;
    s:= '';
    Qrymain.DisableControls;
    try
      Qrymain.First;
      rPrevTotAmount := 0;
      While Qrymain.Eof = False do begin

        if (rPrevTotAmount <> 0) and (qryMainTotalLineAmountInc.AsFloat <> 0) then  begin
          s:= s + 'update ' +tablename +' Set Movement = (TotalLineAmountInc- ' +FloatTostr(rPrevTotAmount) +') / TotalLineAmountInc *100 where Id = ' +inttostr(QrymainId.asInteger) +';';
        end else if qryMainTotalLineAmountInc.AsFloat <> 0 then
          s:= s + 'update ' +tablename +' Set Movement = 100   where Id = ' +inttostr(QrymainId.asInteger) +';'
        else
          s:= s + 'update ' +tablename +' Set Movement = 0  where Id = ' +inttostr(QrymainId.asInteger) +';';

        closeDB(QryTotPurchase);
        QryTotPurchase.Parambyname('dateFrom').asDateTime :=   StartOfamonth(Qrymainyearno.asInteger , QrymainMonthno.asInteger );
        QryTotPurchase.Parambyname('dateTo').asDateTime :=   incday(incmonth(QryTotPurchase.Parambyname('dateFrom').asDateTime,1), -1);
        opendb(QryTotPurchase);
        TotPurchase  := QryTotPurchaseTotal.asFloat;
        if (TotPurchase <> 0) and (qryMainTotalLineAmountInc.AsFloat <> 0) then  begin
          s:= s + 'update ' +tablename +' Set Percentage = TotalLineAmountInc / ' +floatToStr(TotPurchase) +'*100 where Id = ' +inttostr(QrymainId.asInteger) +';';
        end else if qryMainTotalLineAmountInc.AsFloat <> 0 then
          s:= s + 'update ' +tablename +' Set Movement = 100   where Id = ' +inttostr(QrymainId.asInteger) +';'
        else
          s:= s + 'update ' +tablename +' Set Movement = 0  where Id = ' +inttostr(QrymainId.asInteger) +';';


        rPrevTotAmount:=qryMainTotalLineAmountInc.AsFloat;
        Qrymain.Next;
      end;
      if s<> '' then begin
        ExecuteSQL(s);
        CloseDB(Qrymain);
        OpenDB(Qrymain);
      end;
      Qrymain.First;
    finally
      Qrymain.EnableControls
    end;
  finally
    Calculating := False;
  end;
end;

procedure TProductPurchaseMovementListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  dtpPurchFrom.Date := GuiPrefs.Node['General.DateFrom'].AsDatetime;  if dtpPurchFrom.Date <=1 then dtpPurchFrom.Date := incmonth(date , -3);
  dtpPurchTo.Date   := GuiPrefs.Node['General.DateTo'].AsDatetime;    if dtpPurchTo.Date <= 1 then dtpPurchTo.Date := incmonth(date , 1);

  if fiProductId =0 then begin
    if GuiPrefs.Node['General.ProductName'].asString <> '' then begin
      OpenProductQry;
      if QryProductLookup.RecordCount > 0 then begin
         if QryProductLookup.Locate('partname' ,GuiPrefs.Node['General.ProductName'].asString , []) then
          cboProduct.text := QryProductLookupPartname.AsString;
      end;
    end;
  end;
end;

procedure TProductPurchaseMovementListGUI.RefreshQuery;
var
  filename :String;
  s:STring;
  function DAtefield:String; begin if grpFilters.ItemIndex = 1 then result := 'OrderDate' else result := 'Invoicedate';end;
begin
  // temprary table is used as the afteropn is updating fields in qrymain.
  if cboProduct.text = '' then begin
     OpenProductQry;
     if QryProductLookup.RecordCount > 0 then begin
       QryProductLookup.First;
       cboProduct.text := QryProductLookupPartname.AsString;
     end;
  end;
  s:= ' SELECT ' +
          ' month(ifnull('+datefield+',0)) , year(ifnull(' +datefield+',0)), concat(MONTHNAME(' + DAtefield + ') , "-" , year(' + DAtefield + ')) Month_name, ' +
          ' Sum(if(ifnull(shipped,0)=0 , LineCost*QtySold , 0)) as TotalestimatedAmountInc, ' +
          ' Sum(TotalLineAmountInc) TotalLineAmountInc , ' +
          ' Sum(if(ifnull(Shipped,0)=0 , Qtysold, Shipped)) Qtysold, ' +
          ' Sum(Shipped) Shipped , ' +
          ' Sum(if(ifnull(Shipped,0)=0 , Qtysold, 0)) backorder , ' +
          ' Sum(TotalLineAmountInc) / Sum(Shipped) Average  , 0.00 as Movement , 0.00 as Percentage' +
          ' FROM tblPurchaseOrders INNER JOIN tblPurchaseLines Using(purchaseorderId) ' +
          ' WHERE IsPO="T" ' +
          ' AND ProductID = '  +inttostr(QryProductLookupPartsId.asInteger) +
          ' And  ' + DateField+' BETWEEN ' + QuotedStr(FormatDatetime(mySQLDateformat , IncMonth(Trunc(dtpPurchFrom.Date), -1)))  + ' AND ' + QuotedStr(FormatDatetime(mySQLDateformat , Trunc(dtpPurchTo.Date) ))  + ' ' +
          ' group by month(ifnull('+datefield+',0)) , year(ifnull(' +datefield+',0)) ' +
          ' order by  ' + DateField+' ';
  FileName :='';
  s:= CreateTemporaryTableusingfile('' , s ,
                         'monthno, yearno, Month_name, TotalestimatedAmountInc , TotalLineAmountInc , Qtysold, Shipped , backorder , average , Movement , Percentage' ,
                         Tablename , filename)+';';

  With TempMyQuery do try
    SQL.add('truncate ' +tablename +';');
     SQL.Add(s);
     execute;
  finally
    free;
  end;
  AppEnv.UtilsClient.DeleteServerFile(filename);
  inherited;

end;

procedure TProductPurchaseMovementListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TProductPurchaseMovementListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('monthno');
  RemoveFieldfromGrid('yearno');
end;

procedure TProductPurchaseMovementListGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  OpenProductQry;
  if QryProductLookup.RecordCount > 0 then begin
    if QryProductLookup.Locate('PartsId' ,Value, []) then
          cboProduct.text := QryProductLookupPartname.AsString;
  end;
end;

procedure TProductPurchaseMovementListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.DateFrom'].AsDatetime := dtpPurchFrom.Date;
  GuiPrefs.Node['General.DateTo'].AsDatetime := dtpPurchTo.Date;
  GuiPrefs.Node['General.ProductName'].asString := cboProduct.text;
end;

procedure TProductPurchaseMovementListGUI.FormCreate(Sender: TObject);
begin
  Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_ProductPurchsaeMovement' );
  Qrymain.SQL.Text := 'Select   * from ' +tablename ;
  Calculating:= False;
  fiProductId:= 0;
  inherited;
  AddCalcColumn(qryMainTotalLineAmountInc.FieldName, true);
  AddCalcColumn(qryMainShipped.FieldName , false);
end;

procedure TProductPurchaseMovementListGUI.FormShow(Sender: TObject);
begin
  dtpPurchTo.Date := EndOfTheMonth(Date());
  dtpPurchFrom.Date := IncYear(StartOfTheMonth(Date()), -1);
  inherited;
  OpenProductQry;

end;

procedure TProductPurchaseMovementListGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  OpenErpListform('TProductPurchaseMovementDetailsGUI', beforeshowProductPurchaseMovementDetails);
end;
procedure TProductPurchaseMovementListGUI.beforeshowProductPurchaseMovementDetails(Sender: TObject);
begin
  if not (Sender is TProductPurchaseMovementDetailsGUI) then exit;
  TProductPurchaseMovementDetailsGUI(Sender).ProductId:= QryProductLookupPartsId.asInteger;
  TProductPurchaseMovementDetailsGUI(Sender).dateFrom  :=0;
  TProductPurchaseMovementDetailsGUI(Sender).Dateto := 0;// initialise to 0 to avoid recalculating when from is greater tahn to
  TProductPurchaseMovementDetailsGUI(Sender).Dateto := EndOfTheMonth(EncodeDate(qryMainyearno.AsInteger,qryMainMonthno.AsInteger,1));
  TProductPurchaseMovementDetailsGUI(Sender).dateFrom  :=EncodeDate(qryMainyearno.AsInteger,qryMainMonthno.AsInteger,1);
  if grpFilters.itemindex = 0 then TProductPurchaseMovementDetailsGUI(Sender).BasedonDate := 'I' else TProductPurchaseMovementDetailsGUI(Sender).BasedonDate:= 'O';
  TProductPurchaseMovementDetailsGUI(Sender).fbDateRangeSupplied:= True;
  TProductPurchaseMovementDetailsGUI(Sender).GrpfilterSupplied(*FilterOptionSupplied*):= True;
end;
procedure TProductPurchaseMovementListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;
initialization
  RegisterClassOnce(TProductPurchaseMovementListGUI);

end.

