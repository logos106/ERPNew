unit SalesSummarybyPeriodBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;
type
  pColumnRec = ^TColumnRec;
  TColumnRec = record
    ColumnNo: integer;
    ColumnName: string;
    ColumnFrom: TDateTime;
    ColumnTo: TDateTime;
  end;


type
  TReportCategory = (rcEmployee =1, rcProduct=2);

  TSalesSummarybyPeriodBaseGUI = class(TBaseListingGUI)
    cboDepartments: TwwDBLookupCombo;
    chkAllDepartments: TCheckBox;
    Label2: TLabel;
    qryClass: TERPQuery;
    qryClassClassID: TIntegerField;
    qryClassClassName: TWideStringField;
    Label4: TLabel;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure chkAllDepartmentsClick(Sender: TObject);
  private
    fsTablename:String;
  Protected
    IsInRequery: boolean;
    LstColumn: TList;
    ReportCategory: TReportCategory;


    procedure ClearColumns;
    procedure GetColumns;
    procedure MakeQry;
    procedure CreateTempTable;
    procedure LabelChange;
    procedure SetVisibleColumns;
    procedure AddDataToTempTable;
    procedure DeleteTempTable;
    procedure DeleteDataInTable;
  public
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  end;


implementation

uses FastFuncs,Forms, DnMLib, DateUtils, CommonDbLib, PayCommon, CommonLib,
  MySQLConst;

{$R *.dfm}

{ TSalesSummarybyPeriodBaseGUI }

procedure TSalesSummarybyPeriodBaseGUI.AddDataToTempTable;
var
  InsertSQL: string;
  qryTemp, qryExec: TERPQuery;
  pColumn: pColumnRec;
  I, ColumnCount: integer;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO `' + fsTablename + '` ' ;
  if ReportCategory = rcProduct then begin
    InsertSQL := InsertSQL +  '(ProductName,SalesDesc,';
  end else begin
    InsertSQL := InsertSQL +  '(EmployeeName,SalesTarget,'
  end;

  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn   := LstColumn.Items[I];
    InsertSQL := InsertSQL + 'Amount' + IntToStr(pColumn^.ColumnNo) + 'Inc,';
    InsertSQL := InsertSQL + 'Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex,';
    InsertSQL := InsertSQL + 'Cost' + IntToStr(pColumn^.ColumnNo) + 'Inc,';
    InsertSQL := InsertSQL + 'Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex,';
  end;

  InsertSQL := InsertSQL + 'TotalAmountInc,TotalAmountEx,TotalCostInc,TotalCostEx,' +
    'FilterDate,FilterMonthNumber,FilterQuarterNumber,FilterYEAR,';
  if ReportCategory = rcProduct then begin
    InsertSQL := InsertSQL + 'ProductID,';
  end else begin
    InsertSQL := InsertSQL + 'EmployeeID,';
  end;

  InsertSQL := InsertSQL + 'SaleID) ';
  qryTemp := TempMyQuery;
  qryExec := TempMyQuery;
  try
    DeleteDataInTable;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add(InsertSQL);
    qryTemp.Sql.Add('SELECT ');

    if ReportCategory = rcProduct then begin
      qryTemp.Sql.Add('TRIM(tblSalesLines.ProductName) as ProductName, ');
      qryTemp.Sql.Add('TRIM(tblSalesLines.Product_Description) as SalesDesc, ');
    end else begin
      qryTemp.Sql.Add('TRIM(tblSales.EmployeeName) as EmployeeName, ');
      qryTemp.Sql.Add('E.SalesTarget as SalesTarget, ');
    end;
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      qryTemp.Sql.Add('If(tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,
        pColumn^.ColumnFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo) +
        '"  ,Sum(TotalLineAmountInc),0.00)   as Amount' + IntToStr(pColumn^.ColumnNo) + 'Inc ,');
      qryTemp.Sql.Add('If(tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,
        pColumn^.ColumnFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo) +
        '"  ,Sum(TotalLineAmount),0.00)   as Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex ,');
      qryTemp.Sql.Add('If(tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,
        pColumn^.ColumnFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo) +
        '"  ,Sum(Shipped*LineCostInc),0.00)   as Cost' + IntToStr(pColumn^.ColumnNo) + 'Inc ,');
      qryTemp.Sql.Add('If(tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,
        pColumn^.ColumnFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo) +
        '"  ,Sum(Shipped*LineCost),0.00)   as Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex ,');
    end;

    qryTemp.Sql.Add('Sum(TotalLineAmountInc) as TotalAmountInc, ');
    qryTemp.Sql.Add('Sum(TotalLineAmount) as TotalAmountEx, ');
    qryTemp.Sql.Add('Sum(Shipped*LineCostInc) as TotalCostInc, ');
    qryTemp.Sql.Add('Sum(Shipped*LineCost) as TotalCostEx, ');
    qryTemp.Sql.Add('tblSales.SaleDate as FilterDate, ');
    qryTemp.Sql.Add('MONTH(tblSales.SaleDate) as FilterMonthNumber, ');
    qryTemp.Sql.Add('QUARTER(tblSales.SaleDate) AS FilterQuarterNumber, ');
    qryTemp.Sql.Add('YEAR(tblSales.SaleDate) AS FilterYEAR, ');


    if ReportCategory = rcProduct then begin
      qryTemp.Sql.Add('tblSalesLines.ProductID, ');
    end else begin
      qryTemp.Sql.Add('tblSales.EmployeeID, ');
    end;

    qryTemp.Sql.Add('tblSales.SaleID ');
    qryTemp.Sql.Add('FROM tblSales ');
    qryTemp.Sql.Add('INNER JOIN tblSalesLines USING(SaleID) ');

    if ReportCategory = rcProduct then begin
    end else begin
      qryTemp.Sql.Add('LEFT JOIN tblemployees E ON E.EmployeeID=tblSales.EmployeeID ');
    end;

    qryTemp.Sql.Add('WHERE (tblSales.IsPOS ="T" OR tblSales.IsRefund ="T" OR tblSales.IsCashSale="T" OR tblSales.IsInvoice="T") ');
    qryTemp.Sql.Add('AND tblSalesLines.Invoiced="T" AND tblSales.IsLayby <>"T" AND tblSales.Deleted ="F" ');
    qryTemp.Sql.Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" ');
    qryTemp.Sql.Add('AND tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,FilterDateFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, FilterDateto) + '" ');
    if chkAllDepartments.Checked =false then qryTemp.SQL.Add('and tblSales.ClassID = ' + inttostr(qryClassClassID.asInteger));
    qryTemp.Sql.Add('GROUP BY tblSales.SaleID;');
    qryTemp.Execute;

    //Profit
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('UPDATE `' + fsTablename + '` SET ');
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      qryTemp.Sql.Add('Profit' + IntToStr(pColumn^.ColumnNo) + '=(Amount' + IntToStr(pColumn^.ColumnNo) +
        'Ex-Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex),');
    end;
    qryTemp.Sql.Add('TotalProfit=(TotalAmountEx-TotalCostEx);');
    qryTemp.Execute;

    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('SELECT ');
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      qryTemp.Sql.Add('Sum(Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex) as SumAmount' + IntToStr(pColumn^.ColumnNo) + 'Ex,');
      qryTemp.Sql.Add('Sum(Profit' + IntToStr(pColumn^.ColumnNo) + ') as SumProfit' + IntToStr(pColumn^.ColumnNo) + ',');
    end;
    qryTemp.Sql.Add('Sum(TotalAmountEx) as SumTotalAmountEx,');
    qryTemp.Sql.Add('Sum(TotalProfit) as SumTotalProfit ');
    qryTemp.Sql.Add('FROM `' + fsTablename + '`;');
    qryTemp.Open;
    if qryTemp.RecordCount > 0 then begin
      //PercentageOfSales
      qryExec.SQL.Clear;
      qryExec.Sql.Add('UPDATE `' + fsTablename + '` SET ');
      ColumnCount := LstColumn.Count - 1;
      for I := 0 to ColumnCount do begin
        pColumn := LstColumn.Items[I];
        qryExec.Sql.Add('PercentageOfSales' + IntToStr(pColumn^.ColumnNo) + '=IFNULL((Amount' +
          IntToStr(pColumn^.ColumnNo) + 'Ex / ' +
          FloatToStr(qryTemp.FieldByName('SumAmount' + IntToStr(pColumn^.ColumnNo) + 'Ex').AsFloat) + ')*100,0),');
      end;
      qryExec.Sql.Add('TotalPercentageOfSales=IFNULL((TotalAmountEx/' + FloatToStr(qryTemp.FieldByName('SumTotalAmountEx').AsFloat) +
        ')*100,0) ;');
      qryExec.Execute;

      //PercentageOfProfit
      qryExec.SQL.Clear;
      qryExec.Sql.Add('UPDATE `' + fsTablename + '` SET ');
      ColumnCount := LstColumn.Count - 1;
      for I := 0 to ColumnCount do begin
        pColumn := LstColumn.Items[I];
        qryExec.Sql.Add('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo) + '=IFNULL((Profit' +
          IntToStr(pColumn^.ColumnNo) + ' / ' +
          FloatToStr(qryTemp.FieldByName('SumProfit' + IntToStr(pColumn^.ColumnNo)).AsFloat) + ')*100,0),');
      end;
      qryExec.Sql.Add('TotalPercentageOfProfit=IFNULL((TotalProfit/' + FloatToStr(qryTemp.FieldByName('SumTotalProfit').AsFloat) +
        ')*100,0);');
      qryExec.Execute;
    end;

  finally
    FreeAndNil(qryTemp);
    FreeandNil(qryExec);
  end;
end;

procedure TSalesSummarybyPeriodBaseGUI.cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TSalesSummarybyPeriodBaseGUI.chkAllDepartmentsClick(Sender: TObject);
begin
  Label2.Enabled         := not(chkAllDepartments.Checked);
  cboDepartments.Enabled := not(chkAllDepartments.Checked);
  cboDepartments.Refresh;
  RefreshQuery;
end;

procedure TSalesSummarybyPeriodBaseGUI.ClearColumns;
var
  i: integer;
begin
  // Clear Column list
  for i := 0 to LstColumn.Count - 1 do Dispose(LstColumn.Items[i]);
  LstColumn.Clear;
end;

procedure TSalesSummarybyPeriodBaseGUI.CreateTempTable;
var
  slSQL: TStringList;
  pColumn: pColumnRec;
  I, ColumnCount: integer;
begin
  GetColumns;
  DestroyUserTemporaryTable(fsTablename);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTablename + '` (');
    slSQL.Add('`ID` INT(11) AUTO_INCREMENT,');
    if ReportCategory = rcProduct then begin
      slSQL.Add('`ProductName` Varchar(255) default NULL,');
      slSQL.Add('`SalesDesc` Varchar(255) default NULL,');
    end else begin
      slSQL.Add('`EmployeeName` Varchar(255) default NULL,');
      slSQL.Add('`SalesTarget` double default NULL,');
    end;
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      slSQL.Add('`Amount' + IntToStr(pColumn^.ColumnNo) + 'Inc` double DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`Cost' + IntToStr(pColumn^.ColumnNo) + 'Inc` double DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex` double DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex` double DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`Profit' + IntToStr(pColumn^.ColumnNo) + '` double DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`PercentageOfSales' + IntToStr(pColumn^.ColumnNo) + '` double(23,4) DEFAULT "0.00" NOT NULL,');
      slSQL.Add('`PercentageOfProfit' + IntToStr(pColumn^.ColumnNo) + '` double(23,4) DEFAULT "0.00" NOT NULL,');
    end;
    slSQL.Add('`TotalAmountEx` double DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalCostEx` double DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalAmountInc` double DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalCostInc` double DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalProfit` double DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalPercentageOfSales` double(23,4) DEFAULT "0.00" NOT NULL,');
    slSQL.Add('`TotalPercentageOfProfit` double(23,4) DEFAULT "0.00" NOT NULL,');
    if ReportCategory = rcProduct then begin
      slSQL.Add('`ProductID` int(11) default "0" NOT NULL,');
    end else begin
      slSQL.Add('`EmployeeID` int(11) default "0" NOT NULL,');
    end;
    slSQL.Add('`SaleID` int(11) DEFAULT "0" NOT NULL,');
    slSQL.Add('`FilterDate` date default NULL,');
    slSQL.Add('`FilterMonthNumber` int(11) default NULL,');
    slSQL.Add('`FilterQuarterNumber` int(11) default NULL,');
    slSQL.Add('`FilterYEAR` int(11) default NULL, ');
    slSQL.Add('PRIMARY KEY (`ID`)) ENGINE=MyISAM;');
    CreateUserTemporaryTable(slSQL);
  finally
    if Assigned(slSQL) then
      FreeandNil(slSQL);
  end;
end;
procedure TSalesSummarybyPeriodBaseGUI.FormCreate(Sender: TObject);
begin
  IsGridcustomisable:= false;
  inherited;
  LstColumn := TList.Create;
  if ReportCategory = rcProduct then
    fstablename := GetUserTemporaryTableName('ProductReportByPeriod')
  else
    fstablename := GetUserTemporaryTableName('EmployeeReportByPeriod');
end;

procedure TSalesSummarybyPeriodBaseGUI.FormDestroy(Sender: TObject);
begin
  DeleteTempTable;
  ClearColumns;
  FreeandNil(LstColumn);
  LstColumn := nil;
  inherited;
end;

procedure TSalesSummarybyPeriodBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  opendb(qryClass);
  btnCustomize.Enabled:= false;
end;

procedure TSalesSummarybyPeriodBaseGUI.GetColumns;
var
  pColumn: pColumnRec;
  TempColumnCount: integer;
  FromDate, ToDate, StartDate, EndDate: TDateTime;
  ColumnName: string;
begin
  ClearColumns;
  StartDate := dtFrom.DateTime;
  EndDate := dtTo.DateTime;
  TempColumnCount := 0;
  FromDate := StartDate;
  ToDate := EndDate; {To Remove Hint}
  //Setup Default ToDate
  case grpFilters.ItemIndex of
    0:
      begin {Month}
        ToDate := IncMonth(StartDate, TempColumnCount);
      end;
    1:
      begin {Quarter}
        ToDate := IncQuarter(StartDate, TempColumnCount);
      end;
    2:
      begin {Year}
        ToDate := IncYear(StartDate, TempColumnCount);
      end;
  end;

  while ToDate <= EndDate do begin
    TempColumnCount := TempColumnCount + 1;
    case grpFilters.ItemIndex of
      0:
        begin {Month}
          FromDate := IncSecond(ToDate);
          ToDate := EndOfTheMonth(IncMonth(StartDate, TempColumnCount - 1));
          ColumnName := GetMonthName(MonthOfTheYear(FromDate)) + ' (' + IntToStr(YearOf(FromDate)) + ')';
        end;
      1:
        begin {Quarter}
          FromDate := IncSecond(ToDate);
          ToDate := EndOfTheQuarter(IncQuarter(StartDate, TempColumnCount - 1));
          ColumnName := 'Quarter ' + IntToStr(QuarterOf(FromDate)) + ' (' + IntToStr(YearOf(FromDate)) + ')';
        end;
      2:
        begin {Year}
          FromDate := IncSecond(ToDate);
          ToDate := EndOfAYear(YearOf(IncYear(StartDate, TempColumnCount - 1)));
          ColumnName := IntToStr(YearOf(FromDate));
        end;
    end;
    New(pColumn);
    LstColumn.Add(pColumn);
    pColumn^.ColumnNo   := TempColumnCount;
    pColumn^.ColumnName := ColumnName;
    pColumn^.ColumnFrom := FromDate;
    pColumn^.ColumnTo   := ToDate
  end;
end;

procedure TSalesSummarybyPeriodBaseGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if not IsInRequery and fbFormOpenedOk then RefreshQuery;
end;

procedure TSalesSummarybyPeriodBaseGUI.LabelChange;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
begin
  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[I];
    grdMain.ColumnByName('Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex').DisplayLabel := 'Amount (Ex)';
    grdMain.ColumnByName('Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex').GroupName := pColumn^.ColumnName;
    grdMain.ColumnByName('Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex').DisplayWidth := 10;

    grdMain.ColumnByName('Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex').DisplayLabel := 'Cost (Ex)';
    grdMain.ColumnByName('Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex').GroupName    := pColumn^.ColumnName;
    grdMain.ColumnByName('Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex').DisplayWidth := 10;

    grdMain.ColumnByName('Profit' + IntToStr(pColumn^.ColumnNo)).DisplayLabel := 'Profit';
    grdMain.ColumnByName('Profit' + IntToStr(pColumn^.ColumnNo)).GroupName    := pColumn^.ColumnName;
    grdMain.ColumnByName('Profit' + IntToStr(pColumn^.ColumnNo)).DisplayWidth := 10;

    grdMain.ColumnByName('PercentageOfSales' + IntToStr(pColumn^.ColumnNo)).DisplayLabel := '% Of Sales';
    grdMain.ColumnByName('PercentageOfSales' + IntToStr(pColumn^.ColumnNo)).GroupName    := pColumn^.ColumnName;
    grdMain.ColumnByName('PercentageOfSales' + IntToStr(pColumn^.ColumnNo)).DisplayWidth := 10;

    grdMain.ColumnByName('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo)).DisplayLabel := '% Of Profit';
    grdMain.ColumnByName('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo)).GroupName    := pColumn^.ColumnName;
    grdMain.ColumnByName('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo)).DisplayWidth := 10;
  end;

  grdMain.ColumnByName('TotalAmountEx').DisplayLabel := 'Amount (Ex)';
  grdMain.ColumnByName('TotalAmountEx').GroupName := 'Totals';
  grdMain.ColumnByName('TotalAmountEx').DisplayWidth := 10;

  grdMain.ColumnByName('TotalCostEx').DisplayLabel := 'Cost (Ex)';
  grdMain.ColumnByName('TotalCostEx').GroupName := 'Totals';
  grdMain.ColumnByName('TotalCostEx').DisplayWidth := 10;

  grdMain.ColumnByName('TotalProfit').DisplayLabel := 'Profit';
  grdMain.ColumnByName('TotalProfit').GroupName := 'Totals';
  grdMain.ColumnByName('TotalProfit').DisplayWidth := 10;

  grdMain.ColumnByName('TotalPercentageOfSales').DisplayLabel := '% Of Sales';
  grdMain.ColumnByName('TotalPercentageOfSales').GroupName := 'Totals';
  grdMain.ColumnByName('TotalPercentageOfSales').DisplayWidth := 10;

  grdMain.ColumnByName('TotalPercentageOfProfit').DisplayLabel := '% Of Profit';
  grdMain.ColumnByName('TotalPercentageOfProfit').GroupName := 'Totals';
  grdMain.ColumnByName('TotalPercentageOfProfit').DisplayWidth := 10;

end;

procedure TSalesSummarybyPeriodBaseGUI.MakeQry;
var
  StringListForSQL: TStringList;
  I, ColumnCount: integer;
  pColumn: pColumnRec;
begin
  StringListForSQL := TStringList.Create;
  with StringListForSQL do try
      Add('SELECT ID, ');
      if ReportCategory = rcProduct then begin
        Add('ProductName,');
        Add('SalesDesc,');
      end else begin
        Add('EmployeeName,');
        Add('SalesTarget,');
      end;
      ColumnCount := LstColumn.Count - 1;
      for I := 0 to ColumnCount do begin
        pColumn := LstColumn.Items[I];
        Add('Sum(Amount' + IntToStr(pColumn^.ColumnNo) + 'Inc)   as Amount' + IntToStr(pColumn^.ColumnNo) + 'Inc,');
        Add('Sum(Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex)   as Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex,');
        Add('Sum(Cost' + IntToStr(pColumn^.ColumnNo) + 'Inc)   as Cost' + IntToStr(pColumn^.ColumnNo) + 'Inc,');
        Add('Sum(Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex)   as Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex,');
        Add('Sum(Profit' + IntToStr(pColumn^.ColumnNo) + ')   as Profit' + IntToStr(pColumn^.ColumnNo) + ',');
        Add('Sum(PercentageOfSales' + IntToStr(pColumn^.ColumnNo) + ')   as PercentageOfSales' +
          IntToStr(pColumn^.ColumnNo) + ',');
        Add('Sum(PercentageOfProfit' + IntToStr(pColumn^.ColumnNo) + ')   as PercentageOfProfit' +
          IntToStr(pColumn^.ColumnNo) + ',');
      end;
      Add('Sum(TotalAmountInc) as TotalAmountInc, ');
      Add('Sum(TotalAmountEx) as TotalAmountEx, ');
      Add('Sum(TotalCostInc) as TotalCostInc, ');
      Add('Sum(TotalCostEx) as TotalCostEx, ');
      Add('Sum(TotalProfit) as TotalProfit,');
      Add('Sum(TotalPercentageOfSales) as TotalPercentageOfSales,');
      Add('Sum(TotalPercentageOfProfit) as TotalPercentageOfProfit');
      Add('FROM `' + fsTablename + '` ');

      if ReportCategory = rcProduct then begin
        Add('Group By ProductID ');
        Add('Order By ProductName; ');
      end else begin
        Add('Group By EmployeeID ');
        Add('Order By EmployeeName; ');
      end;

      qryMain.SQL := StringListForSQL;
      RefreshOrignalSQL;
    finally
      FreeandNil(StringListForSQL);
    end;
end;
procedure TSalesSummarybyPeriodBaseGUI.RefreshQuery;
begin
  ProcessingCursor(True);
  try
    IsInRequery   := true;
    CreateTempTable;
    AddDataToTempTable;
    MakeQry;
    inherited;
    if ReportCategory = rcEmployee then begin
      TFloatField(qryMain.FieldByName('SalesTarget')).currency := true;
    end;
    SetVisibleColumns;
    LabelChange;
  finally
    Application.ProcessMessages;
    IsInRequery   := false;
    ProcessingCursor(False);
  end;

end;

procedure TSalesSummarybyPeriodBaseGUI.RefreshTotals;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
begin
  Setlength(FooterCalcfields, 0);
  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[I];
    AddCalccolumn('Amount'  + IntToStr(pColumn^.ColumnNo) + 'Ex', true);
    AddCalccolumn('Cost'    + IntToStr(pColumn^.ColumnNo) + 'Ex', true);
    AddCalccolumn('Profit'  + IntToStr(pColumn^.ColumnNo) , true);
  end;
  AddCalccolumn('TotalAmountEx' , true);
  AddCalccolumn('TotalCostEx' , true);
  AddCalccolumn('TotalProfit' , true);
  Calcnshowfooter;
end;

procedure TSalesSummarybyPeriodBaseGUI.SetVisibleColumns;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
  GridFieldsStrLst: TStringList;
begin
  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[I];
    TFloatField(qryMain.FieldByName('Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex')).currency := true;
    TFloatField(qryMain.FieldByName('Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex')).currency := true;
    TFloatField(qryMain.FieldByName('Profit' + IntToStr(pColumn^.ColumnNo))).currency := true;
    TFloatField(qryMain.FieldByName('PercentageOfSales' + IntToStr(pColumn^.ColumnNo))).DisplayFormat := '#0.00%';
    TFloatField(qryMain.FieldByName('PercentageOfSales' + IntToStr(pColumn^.ColumnNo))).EditFormat := '#0.00%';
    TFloatField(qryMain.FieldByName('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo))).DisplayFormat := '#0.00%';
    TFloatField(qryMain.FieldByName('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo))).EditFormat := '#0.00%';
  end;
  TFloatField(qryMain.FieldByName('TotalAmountEx')).currency := true;
  TFloatField(qryMain.FieldByName('TotalCostEx')).currency := true;
  TFloatField(qryMain.FieldByName('TotalProfit')).currency := true;
  TFloatField(qryMain.FieldByName('TotalPercentageOfSales')).DisplayFormat := '#0.00%';
  TFloatField(qryMain.FieldByName('TotalPercentageOfSales')).EditFormat := '#0.00%';
  TFloatField(qryMain.FieldByName('TotalPercentageOfProfit')).DisplayFormat := '#0.00%';
  TFloatField(qryMain.FieldByName('TotalPercentageOfProfit')).EditFormat := '#0.00%';

  //Groups
  GridFieldsStrLst := TStringList.Create;
  try
    if ReportCategory = rcProduct then begin
      GridFieldsStrLst.Add('ProductName'#9'15'#9'Product Name');
      GridFieldsStrLst.Add('SalesDesc'#9'15'#9'Sales Desc');
    end else begin
      GridFieldsStrLst.Add('EmployeeName'#9'15'#9'Employee Name');
      GridFieldsStrLst.Add('SalesTarget'#9'10'#9'Sales Target');
    end;
    GridFieldsStrLst.Add('TotalAmountEx'#9'10'#9'Amount (Ex)'#9'T'#9'Totals');
    GridFieldsStrLst.Add('TotalProfit'#9'10'#9'Profit'#9'T'#9'Totals');
    GridFieldsStrLst.Add('TotalPercentageOfSales'#9'10'#9'% Of Sales'#9'T'#9'Totals');
    GridFieldsStrLst.Add('TotalPercentageOfProfit'#9'10'#9'% Of Profit'#9'T'#9'Totals');
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      GridFieldsStrLst.Add('Amount' + IntToStr(pColumn^.ColumnNo) + 'Ex'#9'10'#9'Amount (Ex)'#9'T'#9 + pColumn^.ColumnName);
      GridFieldsStrLst.Add('Cost' + IntToStr(pColumn^.ColumnNo) + 'Ex'#9'10'#9'Cost (Ex)'#9'T'#9 + pColumn^.ColumnName);
      GridFieldsStrLst.Add('Profit' + IntToStr(pColumn^.ColumnNo) + #9'10'#9'Profit'#9'T'#9 + pColumn^.ColumnName);
      GridFieldsStrLst.Add('PercentageOfSales' + IntToStr(pColumn^.ColumnNo) + #9'10'#9'% Of Sales'#9'T'#9 +
        pColumn^.ColumnName);
      GridFieldsStrLst.Add('PercentageOfProfit' + IntToStr(pColumn^.ColumnNo) + #9'10'#9'% Of Profit'#9'T'#9 +
        pColumn^.ColumnName);
    end;
    grdMain.Selected := GridFieldsStrLst;
    grdMain.ApplySelected;
  finally
    FreeandNil(GridFieldsStrLst);
  end;
end;
procedure TSalesSummarybyPeriodBaseGUI.DeleteDataInTable;
begin
  DeleteContentsFromUserTemporaryTable(fsTablename);
end;

procedure TSalesSummarybyPeriodBaseGUI.DeleteTempTable;
begin
  DestroyUserTemporaryTable(fsTablename);
end;

end.

