unit frmPCCWetStockReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, wwdblook, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, CustomInputBox, Shader, kbmMemTable, DAScript, MyScript,
  ERPdbComponents, AdvOfficeStatusBar, wwcheckbox;

type
  TPCCWetStockReport = class(TBaseListingGUI)
    qryDipReading: TMyQuery;
    qryReceipts: TMyQuery;
    qryDipReading2: TMyQuery;
    qryPumpTests: TMyQuery;
    qryTanks: TMyQuery;
    cboTankNo: TwwDBLookupCombo;
    qryTanksTankNo: TIntegerField;
    qryTanksTankDescription: TStringField;
    dsTanks: TDataSource;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cboTankNoCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    fsTablename:String;
    Procedure CreateTempTable;
    Procedure FillTempTable(TankNo : integer; DateTimeFrom, DateTimeTo : TDateTime);
    Procedure RebuildTable;
  protected
    fbReportSQLSupplied: boolean;
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  PCCWetStockReport: TPCCWetStockReport;

Const
  TempTableName = 'PCCWetstockReport';

implementation

uses FastFuncs,CommonDbLib, Forms, CommonLib;

{$R *.dfm}

{ TPCCWetStockReport }

procedure TPCCWetStockReport.CreateTempTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');

    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`DipReadingDateTime` DATETIME,');  // Day
    slSQL.Add('`OpeningStock` INT (11),');
    slSQL.Add('`Receipts` INT (11),');
    slSQL.Add('`SalesByMeter` INT (11),');
    slSQL.Add('`PumpTest` INT (11),'); //Litres
    slSQL.Add('`CummSales` INT (11),');
    slSQL.Add('`SalesByDip` INT (11),'); //OpeningStock today minus OpeningStock tomorrow
    slSQL.Add('`CummVariation` INT (11),');
    slSQL.Add('`IvoiceNo` VARCHAR (255),');
    slSQL.Add('PRIMARY KEY (`RecID`)) TYPE=MyISAM;');

    CreateUserTemporaryTable(slSQL);

  finally
    // Free used objects.
    if Assigned(slSQL) then
      FreeAndNil(slSQL);
  end;
end;

procedure TPCCWetStockReport.FillTempTable(TankNo: integer; DateTimeFrom,
  DateTimeTo: TDateTime);
Var VariationCumm : integer;
    NextOpeningStock, CummSales, PumpTest : integer;
    NextDipReadingDate : TDateTime;
    qryTemp : TMyQuery;
begin
  CummSales := 0;
  VariationCumm := 0;
  
  qryDipReading.Close;
  qryDipReading.ParamByName('DateTimeFrom').AsDateTime := DateTimeFrom;
  qryDipReading.ParamByName('DateTimeTo').AsDateTime := DateTimeTo;
  qryDipReading.ParamByName('TankNo').AsInteger := TankNo;
  qryDipReading.Open;

  qryDipReading2.Close;
  qryDipReading2.ParamByName('DateTimeFrom').AsDateTime := DateTimeFrom;
  qryDipReading2.ParamByName('DateTimeTo').AsDateTime := DateTimeTo;
  qryDipReading2.ParamByName('TankNo').AsInteger := TankNo;
  qryDipReading2.Open;

  while not qryDipReading.Eof do begin
    qryDipReading2.Next;
    if not qryDipReading2.Eof then begin //find Next Reading Values
      NextOpeningStock := qryDipReading2.FieldByName('DipReading').AsInteger;
      NextDipReadingDate := qryDipReading2.FieldByName('ReadingDateTime').AsDateTime;
    end
    else begin
      NextOpeningStock := 0;
      NextDipReadingDate := 0;
    end;

    CummSales := CummSales + qryDipReading.FieldByName('SalesByMeter').AsInteger;

    //Calculate Receipts
    qryReceipts.Close;
    qryReceipts.ParamByName('DateTimeFrom').AsDateTime := qryDipReading.FieldByName('ReadingDateTime').AsDateTime;
    qryReceipts.ParamByName('DateTimeTo').AsDateTime := NextDipReadingDate;
    qryReceipts.ParamByName('TankNo').AsInteger := TankNo;
    qryReceipts.Open;

    //Calculate Pump Tests
    qryPumpTests.Close;
    qryPumpTests.ParamByName('DateTimeFrom').AsDateTime := qryDipReading.FieldByName('ReadingDateTime').AsDateTime;
    qryPumpTests.ParamByName('DateTimeTo').AsDateTime := NextDipReadingDate;
    qryPumpTests.ParamByName('TankNo').AsInteger := TankNo;
    qryPumpTests.Open;
    if qryPumpTests.RecordCount > 0 then begin
      PumpTest := qryPumpTests.FieldByName('Volume').AsInteger;
    end
    else begin
      PumpTest := 0;
    end;

    if NextOpeningStock > 0 then
      VariationCumm := VariationCumm + qryDipReading.FieldByName('SalesByMeter').AsInteger - PumpTest - (NextOpeningStock - qryDipReading.FieldByName('DipReading').AsInteger);

    qryTemp := TMyQuery.Create(nil);
    try
      qryTemp.Options.FlatBuffers := True;
      qryTemp.Connection := GetSharedMyDacConnection;
      qryTemp.SQL.Text := 'INSERT HIGH_PRIORITY INTO ' +  fsTableName +
         '(DipReadingDateTime, OpeningStock, Receipts, SalesByMeter, PumpTest, CummSales, SalesByDip, CummVariation,IvoiceNo) ' +
         ' VALUES (';
      qryTemp.SQL.Add(QuotedStr(FormatDateTime('yyyy-mm-dd', qryDipReading.FieldByName('ReadingDateTime').asDateTime))+ ',');
      qryTemp.SQL.Add(qryDipReading.FieldByName('DipReading').AsString + ',');
      if qryReceipts.FieldByName('Volume').AsString <> '' then
        qryTemp.SQL.Add(qryReceipts.FieldByName('Volume').AsString + ',')
      else
        qryTemp.SQL.Add('0,');
      qryTemp.SQL.Add(qryDipReading.FieldByName('SalesByMeter').AsString + ',');
      qryTemp.SQL.Add(FastFuncs.IntToStr(PumpTest) + ',');
      qryTemp.SQL.Add(FastFuncs.IntToStr(CummSales) + ',');
      if NextOpeningStock > 0 then
        qryTemp.SQL.Add(FastFuncs.IntToStr(NextOpeningStock - qryDipReading.FieldByName('DipReading').AsInteger) + ',')
      else
        qryTemp.SQL.Add('0,');
      qryTemp.SQL.Add(FastFuncs.IntToStr(VariationCumm) + ',');
      qryTemp.SQL.Add(QuotedStr(qryReceipts.FieldByName('InvoiceNo').AsString));
      qryTemp.SQL.Add(')');
      qryTemp.Execute;

    finally
      FreeAndNil(qryTemp);
    end;

    qryDipReading.Next;
  end;

end;

procedure TPCCWetStockReport.RebuildTable;
var
  SavedCursor: TCursor;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  CreateTempTable;
  FillTempTable(qryTanks.FieldByName('TankNo').AsInteger, dtFrom.DateTime, dtTo.DateTime);
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('DipReadingDateTime AS DipReadingDateTime,');
  qryMain.SQL.Add('OpeningStock AS OpeningStock,');
  qryMain.SQL.Add('Receipts AS Receipts,');
  qryMain.SQL.Add('OpeningStock + Receipts As TotalStock,');
  qryMain.SQL.Add('SalesByMeter AS SalesByMeter,');
  qryMain.SQL.Add('PumpTest AS PumpTest,');
  qryMain.SQL.Add('SalesByMeter - PumpTest As NetSalesByMeter,');
  qryMain.SQL.Add('CummSales AS CummSales,');
  qryMain.SQL.Add('SalesByDip AS SalesByDip,');
  qryMain.SQL.Add('SalesByMeter - PumpTest - SalesByDip as Variation,');
  qryMain.SQL.Add('CummVariation AS CummVariation,');
  qryMain.SQL.Add('IvoiceNo AS IvoiceNo');
  qryMain.SQL.Add('FROM ' + fsTableName);
  qryMain.Open;
  //qryMain.FieldByName('DipReadingDateTime').DisplayFormat := 'dd-mm-yyyy hh:nn:ss';
  Screen.Cursor := SavedCursor;
end;

procedure TPCCWetStockReport.RefreshQuery;
begin
  RebuildTable;
  inherited;
end;

procedure TPCCWetStockReport.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName(TempTableName);
  inherited;

end;

procedure TPCCWetStockReport.FormShow(Sender: TObject);
begin
  inherited;
  qryTanks.Open;
end;

procedure TPCCWetStockReport.cboTankNoCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  RefreshQuery;
end;

procedure TPCCWetStockReport.cmdNewClick(Sender: TObject);
Var sSQL : string;
begin
  if not qryMain.Active then Exit;

  sSQL := qryMain.SQL.Text;
  ReportSQLSupplied := true;
  PrintTemplateReport('Wetstock Summary', sSQL, false, 1);
  ReportSQLSupplied := false;
end;


initialization
  RegisterClassOnce(TPCCWetStockReport);

end.
