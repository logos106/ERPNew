unit frmForeignSalesList;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 18/05/05  1.00.00 IJB  Initial version.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ForeignExchangeObj, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfmForeignSalesList = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainQtyShipped: TFloatField;
    qryMainQtyBackOrder: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLinePriceForeign: TFloatField;
    qryMainLineTotal: TFloatField;
    qryMainLineTotalInc: TFloatField;
    qryMainCurrentLineTotal: TFloatField;
    qryMainForeignExchangeRate: TFloatField;
    qryMainCurrentExchangeRate: TFloatField;
    qryMainForeignExchangeCode: TWideStringField;
    qryMainLineTotalForeign: TFloatField;
    qryMainLineTotalForeignHedged: TFloatField;
    qryMainLineTotalCurrencyVariation: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainTotalCurrencyVariation: TFloatField;
    qryMainDetailType: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override; 
  private
    TempTableName: string;
    TempTableIsCreated: boolean;
    FXObj: TForeignExchangeObj;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
    procedure PopulateTemporaryTable;
    procedure SetFilter;
    procedure SetColumns;
    function InvoiceIsForeign(SaleId: integer): boolean;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib, FastFuncs, MySQLConst, AppEnvironment;

procedure TfmForeignSalesList.FormCreate(Sender: TObject);
begin
  //fbIgnoreAccessLevels := true;
  inherited;
  TempTableIsCreated := false;
  DefaultMaxGridColumnWidth := 40;
  TempTableName := GetUserTemporaryTableName('ForeignSales');
  FXObj := TForeignExchangeObj.Create;
  CreateTemporaryTable;
  qryMain.SQL.Text :=
    ' SELECT' + ' 1 as DetailType, SaleId, SaleDate, InvoiceDocNumber, CustomerName,' +
    ' ProductName, QtySold, QtyShipped, QtyBackOrder,' + ' LinePrice, LinePriceInc, LinePriceForeign,' +
    ' LineTotal, LineTotalInc, CurrentLineTotal,' + ' ForeignExchangeRate, CurrentExchangeRate, ForeignExchangeCode,' +
    ' LineTotalForeign, LineTotalForeignHedged, LineTotalCurrencyVariation,' +
    ' IF(1,null,TotalAmount) as "TotalAmount", IF(1,null,TotalTax) as "TotalTax", IF(1,null,TotalAmountInc) as "TotalAmountInc",' +
    ' IF(1,null,LineTotalCurrencyVariation) as "TotalCurrencyVariation"' + ' FROM ' + TempTableName +
    ' UNION ALL' + ' SELECT' + ' 0, SaleId, SaleDate, InvoiceDocNumber, CustomerName,' +
    ' SPACE(30), null, null, null,' + ' null, null, null,' + ' null, null, null,' + ' null, null, null,' +
    ' null, null, null,' + ' TotalAmount, TotalTax, TotalAmountInc,' + ' SUM(LineTotalCurrencyVariation)' +
    ' FROM ' + TempTableName + ' GROUP BY SaleId' + ' ORDER BY SaleId, DetailType';
  RefreshOrignalSQL;
end;

procedure TfmForeignSalesList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;

procedure TfmForeignSalesList.FormDestroy(Sender: TObject);
begin
  if TempTableIsCreated then
    DestroyTemporaryTable;
  FreeandNil(FXObj);
  inherited;
end;

procedure TfmForeignSalesList.RefreshQuery;
begin
  CreateTemporaryTable;
  qryMain.Close;
  inherited;
  SetFilter;
end;

procedure TfmForeignSalesList.CreateTemporaryTable;
var
  qry: TERPQuery;
begin
  if TempTableIsCreated then Exit;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   :=
      'CREATE TABLE IF NOT EXISTS ' + TempTableName + '(' + ' `ID` int(11) NOT NULL auto_increment,' +
      ' `SaleId` INT(11) DEFAULT 0,' + ' `SaleDate` Date,' + ' `InvoiceDocNumber` varchar(255),' +
      ' `CustomerName` varchar(255),' + ' `TotalAmount` double,' + ' `TotalTax` double,' +
      ' `TotalAmountInc` double,' + ' `ProductName` varchar(255),' + ' `QtySold` double,' +
      ' `QtyShipped` double,' + ' `QtyBackOrder` double,' + ' `LinePrice` double,' + ' `LinePriceInc` double,' +
      ' `ForeignExchangeRate` double,' + '	`CurrentExchangeRate` double,' + ' `ForeignExchangeCode` varchar(3),' +
      ' `LinePriceForeign` double,' + ' `LineTotal` double,' + ' `CurrentLineTotal` double,' +
      ' `LineTotalInc` double,' + ' `LineTotalForeign` double,' + '	`UseHedging` ENUM("T","F") DEFAULT "F",' +
      ' `LineTotalForeignHedged` double,' + ' `LineTotalCurrencyVariation` double,' + ' PRIMARY KEY (`ID`)) ENGINE=MyISAM';
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
  PopulateTemporaryTable;
  TempTableIsCreated := true;
end;

procedure TfmForeignSalesList.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TfmForeignSalesList.PopulateTemporaryTable;
var
  qry, qryInsert: TERPQuery;
  //cmd: TERPCommand;
  Progress: TProgressDialog;
  BuyRate, SellRate: double;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qryInsert := TERPQuery.Create(nil);
  qryInsert.Options.FlatBuffers := True;
  //cmd:= TERPCommand.Create(nil);
  Progress := TProgressDialog.Create(nil);
  try
    qry.Connection       := CommonDbLib.GetSharedMyDacConnection;
    qryInsert.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text         := 'TRUNCATE TABLE ' + TempTableName;
    qry.Execute;

    qry.SQL.Text :=
      'SELECT S.SaleId, S.InvoiceDocNumber, S.CustomerName, S.SaleDate,' +
      ' S.TotalTax, S.TotalAmount, S.TotalAmountInc,' + ' SL.ProductName, SL.LinePrice, SL.LinePriceInc,' +
      ' SL.QtySold, SL.Shipped, SL.BackOrder,' + ' SL.ForeignCurrencyLinePrice, SL.ForeignExchangeSellRate,' +
      ' SL.ForeignExchangeSellCode, SL.UseHedging,' + ' SL.TotalLineAmount, SL.TotalLineAmountInc, SL.LineTax, SL.LineTaxCode' +
      ' FROM tblSales S, tblSalesLines SL' + ' WHERE S.SaleId = SL.SaleId' + ' AND S.Paid <> "T"' + ' AND S.IsInvoice = "T"';
    qry.Open;

    Progress.Caption  := 'Fetching Sales Data .....';
    Progress.MinValue := 0;
    Progress.MaxValue := qry.RecordCount - 1;
    Progress.Step     := 1;
    Progress.Value    := Progress.MinValue;
    Progress.Execute;

    while not Qry.Eof do begin
      if self.InvoiceIsForeign(qry.FieldByName('SaleId').AsInteger) then begin
        qryInsert.SQL.Text := 'SELECT * FROM ' + TempTableName;
        qryInsert.Open;
        qryInsert.Insert;
        qryInsert.FieldByName('SaleId').AsInteger := qry.FieldByName('SaleId').AsInteger;
        qryInsert.FieldByName('SaleDate').AsDateTime := qry.FieldByName('SaleDate').AsDateTime;
        qryInsert.FieldByName('InvoiceDocNumber').AsString := qry.FieldByName('InvoiceDocNumber').AsString;
        qryInsert.FieldByName('CustomerName').AsString := qry.FieldByName('CustomerName').AsString;
        qryInsert.FieldByName('TotalAmount').AsFloat := qry.FieldByName('TotalAmount').AsFloat;
        qryInsert.FieldByName('TotalAmountInc').AsFloat := qry.FieldByName('TotalAmountInc').AsFloat;
        qryInsert.FieldByName('TotalTax').AsFloat := qry.FieldByName('TotalTax').AsFloat;
        qryInsert.FieldByName('ProductName').AsString := qry.FieldByName('ProductName').AsString;
        qryInsert.FieldByName('QtySold').AsFloat := qry.FieldByName('QtySold').AsFloat;
        qryInsert.FieldByName('QtyShipped').AsFloat := qry.FieldByName('Shipped').AsFloat;
        qryInsert.FieldByName('QtyBackOrder').AsFloat := qry.FieldByName('BackOrder').AsFloat;
        qryInsert.FieldByName('LinePrice').AsFloat := qry.FieldByName('LinePrice').AsFloat;
        qryInsert.FieldByName('LinePriceInc').AsFloat := qry.FieldByName('LinePriceInc').AsFloat;
        qryInsert.FieldByName('LinePriceForeign').AsFloat := qry.FieldByName('ForeignCurrencyLinePrice').AsFloat;
        qryInsert.FieldByName('LineTotal').AsFloat := qry.FieldByName('TotalLineAmount').AsFloat;
        qryInsert.FieldByName('LineTotalInc').AsFloat := qry.FieldByName('TotalLineAmountInc').AsFloat;
        if qry.FieldByName('ForeignExchangeSellCode').AsString <> '' then begin
          qryInsert.FieldByName('ForeignExchangeRate').AsFloat := qry.FieldByName('ForeignExchangeSellRate').AsFloat;
          qryInsert.FieldByName('ForeignExchangeCode').AsString := qry.FieldByName('ForeignExchangeSellCode').AsString;
          FXObj.GetForeignExchangeRatesForDate(qry.FieldByName('ForeignExchangeSellCode').AsString,
            qry.FieldByName('SaleDate').AsDateTime,
            BuyRate, SellRate);
          qryInsert.FieldByName('CurrentExchangeRate').AsFloat := BuyRate;
          qryInsert.FieldByName('LineTotalForeign').AsFloat :=
            CommonLib.Round(qry.FieldByName('ForeignCurrencyLinePrice').AsFloat * qry.FieldByName('Shipped').AsFloat, CurrencyRoundPlaces);
          if qry.FieldByName('UseHedging').AsBoolean then begin
            qryInsert.FieldByName('UseHedging').AsBoolean := true;
            qryInsert.FieldByName('LineTotalForeignHedged').AsFloat :=
              CommonLib.Round(FXObj.GetHedgedAmountForRate(qryInsert.FieldByName('LineTotalForeign').AsFloat,
              qryInsert.FieldByName('ForeignExchangeCode').AsString, BuyRate), CurrencyRoundPlaces);
            qryInsert.FieldByName('CurrentLineTotal').AsFloat :=
              CommonLib.ForeignToLocal(qryInsert.FieldByName('LineTotalForeignHedged').AsFloat,
              qryInsert.FieldByName('CurrentExchangeRate').AsFloat, CurrencyRoundPlaces);
          end else begin
            qryInsert.FieldByName('LineTotalForeignHedged').AsFloat := qryInsert.FieldByName('LineTotalForeign').AsFloat;
            qryInsert.FieldByName('CurrentLineTotal').AsFloat :=
              CommonLib.ForeignToLocal(qryInsert.FieldByName('LineTotalForeign').AsFloat,
              qryInsert.FieldByName('CurrentExchangeRate').AsFloat, CurrencyRoundPlaces);
          end;
          qryInsert.FieldByName('LineTotalCurrencyVariation').AsFloat :=
            qryInsert.FieldByName('LineTotal').AsFloat - qryInsert.FieldByName('CurrentLineTotal').AsFloat;
        end;

        qryInsert.Post;
      end;
      Qry.Next;
      Progress.StepIt;
    end;
    qryInsert.Close;

  finally
    FreeAndNil(qry);
    FreeandNil(qryInsert);
    FreeandNil(Progress);
  end;
end;

procedure TfmForeignSalesList.actRefreshQryExecute(Sender: TObject);
begin
  PopulateTemporaryTable;
  inherited;
end;

procedure TfmForeignSalesList.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainDetailType.AsInteger = 0 then AFont.Style := [fsBold]
  else AFont.Style := [];
end;

procedure TfmForeignSalesList.grpFiltersClick(Sender: TObject);
begin
  SetFilter;
  inherited;
end;

procedure TfmForeignSalesList.SetFilter;
var
  s: string;
begin
  GroupFilterString := '';
  if grpFilters.ItemIndex = 0 then begin
    s := 'DetailType = 0 ';
  end else begin
    s := '';
  end;
  if not chkIgnoreDates.Checked then begin
    if s <> '' then s := s + ' and ';
    s := s + '(SaleDate >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) + ')' +
      ' AND (SaleDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)) + ')';
  end;
  GroupFilterString := s;
  SetColumns;
  ApplyQueryFilter;
end;

procedure TfmForeignSalesList.SetColumns;
begin
  if grpFilters.ItemIndex = 0 then begin
    grdMain.RemoveField('ProductName');
    grdMain.RemoveField('QtySold');
    grdMain.RemoveField('QtyShipped');
    grdMain.RemoveField('LinePrice');
    grdMain.RemoveField('LinePriceInc');
    grdMain.RemoveField('LinePriceForeign');
    grdMain.RemoveField('LineTotal');
    grdMain.RemoveField('LineTotalInc');
    grdMain.RemoveField('CurrentLineTotal');
    grdMain.RemoveField('ForeignExchangeRate');
    grdMain.RemoveField('CurrentExchangeRate');
    grdMain.RemoveField('ForeignExchangeCode');
    grdMain.RemoveField('LineTotalForeign');
    grdMain.RemoveField('LineTotalForeignHedged');
    grdMain.RemoveField('LineTotalCurrencyVariation');
  end else begin
    grdMain.AddField('ProductName');
    grdMain.AddField('QtySold');
    grdMain.AddField('QtyShipped');
    grdMain.AddField('LinePrice');
    grdMain.AddField('LinePriceInc');
    grdMain.AddField('LinePriceForeign');
    grdMain.AddField('LineTotal');
    grdMain.AddField('LineTotalInc');
    grdMain.AddField('CurrentLineTotal');
    grdMain.AddField('ForeignExchangeRate');
    grdMain.AddField('CurrentExchangeRate');
    grdMain.AddField('ForeignExchangeCode');
    grdMain.AddField('LineTotalForeign');
    grdMain.AddField('LineTotalForeignHedged');
    grdMain.AddField('LineTotalCurrencyVariation');
  end;
end;


procedure TfmForeignSalesList.RefreshTotals;
var
  SumLineTotalForeign, SumLineTotal, SumLineTotalInc, SumCurrentLineTotal, SumLineTotalCurrencyVariation,
  SumTotalAmount, SumTotalAmountInc, SumTotalCurrencyVariation, SumLineTotalForeignHedged: double;
begin
  inherited;
  qryMain.DisableControls;
  try
    qryMain.First;
    SumLineTotalForeign := 0;
    SumLineTotal        := 0;
    SumLineTotalInc     := 0;
    SumCurrentLineTotal := 0;
    SumLineTotalForeignHedged := 0;
    SumLineTotalCurrencyVariation := 0;
    SumTotalAmount      := 0;
    SumTotalAmountInc   := 0;
    SumTotalCurrencyVariation := 0;
    while not qryMain.Eof do begin
      SumLineTotalForeign := SumLineTotalForeign + qryMainLineTotalForeign.AsFloat;
      SumLineTotal := SumLineTotal + qryMainLineTotal.AsFloat;
      SumLineTotalInc := SumLineTotalInc + qryMainLineTotalInc.AsFloat;
      SumCurrentLineTotal := SumCurrentLineTotal + qryMainCurrentLineTotal.AsFloat;
      SumLineTotalForeignHedged := SumLineTotalForeignHedged + qryMainLineTotalForeignHedged.AsFloat;
      SumLineTotalCurrencyVariation := SumLineTotalCurrencyVariation + qryMainLineTotalCurrencyVariation.AsFloat;
      SumTotalAmount := SumTotalAmount + qryMainTotalAmount.AsFloat;
      SumTotalAmountInc := SumTotalAmountInc + qryMainTotalAmountInc.AsFloat;
      SumTotalCurrencyVariation := SumTotalCurrencyVariation + qryMainTotalCurrencyVariation.AsFloat;

      // Fetch next record.
      qryMain.Next;
    end;

    grdMain.ColumnByName('LineTotalForeign').FooterValue := FloatToStrF(SumLineTotalForeign, ffNumber, 15, 2);
    grdMain.ColumnByName('LineTotal').FooterValue        := FloatToStrF(SumLineTotal, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('LineTotalInc').FooterValue     := FloatToStrF(SumLineTotalInc, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('CurrentLineTotal').FooterValue := FloatToStrF(SumCurrentLineTotal, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('LineTotalForeignHedged').FooterValue := FloatToStrF(SumLineTotalForeignHedged, ffNumber, 15, 2);
    grdMain.ColumnByName('LineTotalCurrencyVariation').FooterValue :=
      FloatToStrF(SumLineTotalCurrencyVariation, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalAmount').FooterValue      := FloatToStrF(SumTotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalAmountInc').FooterValue   := FloatToStrF(SumTotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalCurrencyVariation').FooterValue := FloatToStrF(SumTotalCurrencyVariation, ffCurrency, 15, CurrencyRoundPlaces);
  finally
    qryMain.EnableControls;
  end;
end;


var
  InvoiceIsForeign_Last_SaleId: integer = 0;
  InvoiceIsForeign_Last_Result: boolean = true;

function TfmForeignSalesList.InvoiceIsForeign(SaleId: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'SELECT SaleId,ForeignExchangeCode FROM tblSales  WHERE' + ' SaleId = ' + IntToStr(SaleId) +
      ' AND ForeignExchangeCode IS NOT NULL' + ' AND ForeignExchangeCode <> ""' + ' AND ForeignExchangeCode <> '+Quotedstr(Appenv.RegionalOptions.ForeignExDefault);
    qry.Open;
    Result := not qry.IsEmpty;
  finally
    FreeAndNil(qry);
  end;
end;

initialization
  RegisterClassOnce(TfmForeignSalesList);
end.
