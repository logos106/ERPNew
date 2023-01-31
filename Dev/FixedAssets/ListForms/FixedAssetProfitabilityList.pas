unit FixedAssetProfitabilityList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, kbmMemTable, ProgressDialog, CustomInputBox, wwdblook,
  Shader;

type
  TfrmFixedAssetProfitabilityList = class(TBaseListingGUI)
    qryTemp: TMyQuery;
    qryMainID: TSmallintField;
    qryMainAssetID: TIntegerField;
    qryMainAssetName: TStringField;
    qryMainIncome: TFloatField;
    qryMainExpense: TFloatField;
    qryMainDiff: TFloatField;
    qryMainDiff2: TFloatField;
    qryMainProfit: TFloatField;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    function GetTemporaryTableName: string;
    procedure CreateTemporaryTable;
    procedure ClearTemporaryTable;
    procedure DropTemporaryTable;
    procedure PopulateTemporaryTable;

  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib,   AppEnvironment,
  CommonLib;

{ TfrmFixedAssetJobProfitabilityList }

procedure TfrmFixedAssetProfitabilityList.FormCreate(Sender: TObject);
begin
  CreateTemporaryTable;

  inherited;

end;

procedure TfrmFixedAssetProfitabilityList.FormDestroy(Sender: TObject);
begin
  DropTemporaryTable;
  inherited;
end;

function TfrmFixedAssetProfitabilityList.GetTemporaryTableName: string;
begin
  Result := 'tmp_fixedassetjobprofitability' + GetMachineIdentification(true, true, true, true);
end;

procedure TfrmFixedAssetProfitabilityList.CreateTemporaryTable;
var
  qry: TMyQuery;
begin
  // Drop the temporary table if it exists.. It shouldnt be there
  // but ya never know .. ie .. system crashed etc.
  DropTemporaryTable;
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + GetTemporaryTableName + '` ');
    qry.SQL.Add('(`ID` INT (11) NOT NULL AUTO_INCREMENT,');
    qry.SQL.Add('`AssetID` INT (11) DEFAULT 0, `AssetName` VARCHAR (255),');
    qry.SQL.Add('`Income` DOUBLE DEFAULT 0, `Expense` DOUBLE, `Diff` DOUBLE DEFAULT 0, ');
    qry.SQL.Add('`Diff%` DOUBLE DEFAULT 0, `Profit` DOUBLE DEFAULT 0, PRIMARY KEY(`ID`))  TYPE = InnoDB');

    // Create temporary table.
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmFixedAssetProfitabilityList.RefreshTotals;
var
  mem: TKbmMemTable;
  dIncome, dExpense: double;
begin
  mem := TKbmMemTable.Create(nil);
  try
    mem.LoadFromDataSet(qryMain, [mtcpoStructure, mtcpoProperties]);
    dIncome  := 0;
    dExpense := 0;
    while not mem.Eof do begin
      // Accumulate totals.
      dIncome := dIncome + mem.FieldByName('Income').AsFloat;
      dExpense := dExpense + mem.FieldByName('Expense').AsFloat;

      // Fetch next record.
      mem.Next;
    end;

    // Now work out the remaining figures.
    grdMain.ColumnByName('Expense').FooterValue := FloatToStrF(dExpense, ffCurrency, 15, 2);
    grdMain.ColumnByName('Income').FooterValue  := FloatToStrF(dIncome, ffCurrency, 15, 2);
    grdMain.ColumnByName('Diff').FooterValue   := FloatToStrF((dIncome - dExpense), ffCurrency, 15, 2);
    grdMain.ColumnByName('Diff%').FooterValue   := FloatToStrF((DivZer((dIncome - dExpense), dExpense) * 100),
      ffFixed, 15, 2) + '%';
    grdMain.ColumnByName('Profit').FooterValue  := FloatToStrF((DivZer((dIncome - dExpense), dIncome) * 100),
      ffFixed, 15, 2) + '%';

  finally
    // Free our used objects.
    if Assigned(mem) then
      FreeandNil(mem);
  end;
end;

procedure TfrmFixedAssetProfitabilityList.RefreshQuery;
begin
  { NOTE: This query has been modified to remove the income from hire for now.
          We currently can't select amounts that have been invoiced out by date
          for the hire of an asset.

          Also this query does not cater for serial numbers ... so this needs
          to be addressed. }
  qryMain.DisableControls;
  Try
    // Setup SQL Statement
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '` ORDER BY AssetName;');

    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT');
    qryTemp.SQL.Add('0 AS Details, FA.AssetID, FA.AssetName, FA.AssetType,');
    //qryTemp.SQL.Add('Sum(H.TotalAmountInc) AS "Income",');
    qryTemp.SQL.Add('0.00 AS "Income",');      // temp change
    qryTemp.SQL.Add('0.00 AS "Expenses",');
    qryTemp.SQL.Add('0.00 AS "Depreciation"');
    qryTemp.SQL.Add('FROM tblfixedassets AS FA');

    qryTemp.SQL.Add('INNER JOIN tblhirelines AS HL on FA.PartsID = HL.ProductID');
    qryTemp.SQL.Add('INNER JOIN tblhire AS H on H.HireID = HL.HireID');
    qryTemp.SQL.Add('WHERE FA.Active = "T"');
    qryTemp.SQL.Add('GROUP BY FA.PartsID');

    qryTemp.SQL.Add('UNION ALL');

    qryTemp.SQL.Add('SELECT');
    qryTemp.SQL.Add('1 AS Details, FA.AssetID, FA.AssetName, FA.AssetType,');
    qryTemp.SQL.Add('0.00 AS "Income",');
    qryTemp.SQL.Add('Sum(RP.LineTotalEx) AS "Expenses",');
    qryTemp.SQL.Add('0.00 AS "Depreciation"');

    qryTemp.SQL.Add('FROM tblfixedassets AS FA');
    //qryTemp.SQL.Add('LEFT JOIN tblrepairs AS R on FA.PartsID = R.AssetProductID AND R.Converted = "T"');
    qryTemp.SQL.Add(
      'LEFT JOIN tblrepairs AS R on FA.PartsID = R.AssetProductID AND R.CreationDate >= :RepairCreationStart AND R.CreationDate <= :RepairCreationEnd');
    qryTemp.SQL.Add('LEFT JOIN tblrepairparts AS RP on R.RepairID = RP.RepairID');
    qryTemp.SQL.Add('WHERE FA.Active = "T"');
    qryTemp.SQL.Add('GROUP BY FA.PartsID');

    qryTemp.SQL.Add('UNION ALL');

    qryTemp.SQL.Add('SELECT');
    qryTemp.SQL.Add('2 AS Details, FA.AssetID, FA.AssetName, FA.AssetType,');
    qryTemp.SQL.Add('0.00 AS "Income",');
    qryTemp.SQL.Add('0.00 AS "Expenses",');
    qryTemp.SQL.Add('Sum(FADD.Depreciation) AS "Depreciation"');

    qryTemp.SQL.Add('FROM tblfixedassets AS FA');

    if (AppEnv.CompanyPrefs.DepreciationForTransactions = 2) then begin
      //qryTemp.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 FADD on (FA.AssetID = FADD.AssetID AND FADD.Date <= ' + QuotedStr(ConvertCurrentDateToMySQLDate) + ')');
      qryTemp.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails2 FADD on (FA.AssetID = FADD.AssetID AND FADD.Date <= :FADate)');
    end else begin
      //qryTemp.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails FADD on (FA.AssetID = FADD.AssetID AND FADD.Date <= ' + QuotedStr(ConvertCurrentDateToMySQLDate) + ')');
      qryTemp.SQL.Add('INNER JOIN tblfixedassetsdepreciationdetails FADD on (FA.AssetID = FADD.AssetID AND FADD.Date <= :FADate)');
    end;
    qryTemp.SQL.Add('WHERE FA.Active = "T"');
    qryTemp.SQL.Add('GROUP BY FA.PartsID');
    qryTemp.ParamByName('RepairCreationStart').AsDateTime := dtFrom.Date;
    qryTemp.ParamByName('RepairCreationEnd').AsDateTime := dtTo.Date;
    qryTemp.ParamByName('FADate').AsDateTime := dtTo.Date;
    qryTemp.Open;
    PopulateTemporaryTable;
  finally
    qryMain.EnableControls;
  end;

  inherited;

  grdMain.ColumnByName('Diff').DisplayLabel := 'Diff '+ AppEnv.RegionalOptions.CurrencySymbol;  

end;

procedure TfrmFixedAssetProfitabilityList.PopulateTemporaryTable;
var
  dIncome, dExpense: double;

begin
  ClearTemporaryTable;
  qryMain.Close;
  qryMain.Open;

  qryTemp.First;
  while not qryTemp.Eof do begin
    if not qryMain.Locate('AssetId', qryTemp.FieldByName('AssetID').AsInteger, []) then begin
      qryMain.Append;
      qryMain.FieldByName('AssetID').AsInteger := qryTemp.FieldByName('AssetID').AsInteger;
      qryMain.FieldByName('AssetName').AsString := qryTemp.FieldByName('AssetName').AsString;
    end;

    if not (qryMain.State in [dsInsert, dsEdit]) then qryMain.Edit;

    case qryTemp.FieldByName('Details').AsInteger of
      0: 
        begin // income from hire
          qryMain.FieldByName('Income').AsFloat := qryTemp.FieldByName('Income').AsFloat;
        end;
      1: 
        begin // repair expenses
          qryMain.FieldByName('Expense').AsFloat := qryTemp.FieldByName('Expenses').AsFloat;
        end;
      2: 
        begin // depreciation expenses
          qryMain.FieldByName('Expense').AsFloat := qryMain.FieldByName('Expense').AsFloat +
            qryTemp.FieldByName('Depreciation').AsFloat;
        end;
    end;

    if (qryMain.FieldByName('Income').AsFloat <> 0) or (qryMain.FieldByName('Expense').AsFloat <> 0) then begin
      // Now calculate the profitability details.
      dIncome := qryMain.FieldByName('Income').AsFloat;
      dExpense := qryMain.FieldByName('Expense').AsFloat;

      qryMain.FieldByName('Diff').AsFloat := dIncome - dExpense;
      qryMain.FieldByName('Diff%').AsFloat := DivZer((dIncome - dExpense), dExpense) * 100;
      qryMain.FieldByName('Profit').AsFloat := DivZer((dIncome - dExpense), dIncome) * 100;
    end;
    qryMain.Post;

    qryTemp.Next;
  end;
end;

procedure TfrmFixedAssetProfitabilityList.DropTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmFixedAssetProfitabilityList.ClearTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetTemporaryTableName + '` WHERE ID <> 0;');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmFixedAssetProfitabilityList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmFixedAssetProfitabilityList.grdMainDblClick(Sender: TObject);
begin
  // Dont accept drill downs if we are previewing a history area.
  if not (Parent is TDNMPanel) then begin
    inherited;
  end;
end;

procedure TfrmFixedAssetProfitabilityList.dtFromCloseUp(Sender: TObject);
begin
  inherited;
  Self.RefreshQuery;
end;

procedure TfrmFixedAssetProfitabilityList.dtToCloseUp(Sender: TObject);
begin
  inherited;
  Self.RefreshQuery;
end;
procedure TfrmFixedAssetProfitabilityList.FormShow(Sender: TObject);
begin
  inherited;
  grdMain.ColumnByName('Diff').DisplayLabel := 'Diff '+ AppEnv.RegionalOptions.CurrencySymbol;
end;

initialization
  RegisterClassOnce(TfrmFixedAssetProfitabilityList);
end.
