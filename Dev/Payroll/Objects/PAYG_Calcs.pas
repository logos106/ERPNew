unit PAYG_Calcs;

interface

type
  TEmpPAYG_Figures = record
    EmployeeID: integer;
    Year: word;
    Gross: Double;
    Tax: Double;
    CDEP: Double;
    Allowances: Double;
    Other: Double;
    Deductions: Double;
    WorkPlacegiving: Double;
    UnionFees: Double;
    LumpA: Double;
    LumpB: Double;
    LumpD: Double;
    LumpE: Double;
    Super :Double;
    ReportableFB: Double;
  end;

Procedure GetEmployeePAYG_Figures(var Figures: TEmpPAYG_Figures);

implementation

uses
  MyAccess,ERPdbComponents,CommonDbLib, FastFuncs,ProgressDialog,Forms,Controls,
  SysUtils,DnMLib,DateUtils,PayCommon,AppEnvironment, MySQLConst, CommonLib;

//function GetUserTempPAYGCalcSummaryName(Const Figures: TEmpPAYG_Figures): string;
//begin
//  Result := GetUserTemporaryTableName(IntToStr(Figures.EmployeeID)+'PAYGCalcSummary');
//end;

var
  fTempTableName: string = '';

function TempTableName(Const Figures: TEmpPAYG_Figures): string;
begin
  if fTempTableName = '' then
    fTempTableName := GetUserTemporaryTableName(IntToStr(Figures.EmployeeID)+'PAYGCalcSummary');
  result := fTempTableName;
end;



//procedure DeleteTempPAYGCalcSummaryTable(Const Figures: TEmpPAYG_Figures);
//var
//  qryTemp: TERPCommand;
//begin
//  qryTemp := TERPCommand.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempPAYGCalcSummaryName(Figures) + ' ');
//    qryTemp.Execute;
//  finally
//    FreeAndNil(qryTemp);
//  end;
//end;

procedure CreateTempPAYGCalcSummaryTable(Const Figures: TEmpPAYG_Figures);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
//    qryTemp.Sql.Clear;
//    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + TempTableName(Figures) + ' ');
//    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + TempTableName(Figures) + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) unsigned NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`PayID` int(11) NOT NULL default "0", ');
    qryTemp.Sql.Add('`GlobalRef` varchar(255) , ');
    qryTemp.Sql.Add('`PayDate` date default NULL, ');
    qryTemp.Sql.Add('`DatePaid` datetime default NULL, ');
    qryTemp.Sql.Add('`EmployeeID` int(11) NOT NULL default "0", ');
    qryTemp.Sql.Add('`EmployeeName` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`TotalTaxWithheld` double default NULL, ');
    qryTemp.Sql.Add('`Allowances` double default NULL, ');
    qryTemp.Sql.Add('`Other` double default NULL, ');
    qryTemp.Sql.Add('`CDEP` double default NULL, ');
    qryTemp.Sql.Add('`Commission` double default NULL, ');
    qryTemp.Sql.Add('`GrossPayments` double default NULL, ');
    qryTemp.Sql.Add('`Deductions` double default NULL, ');
    qryTemp.Sql.Add('`WorkPlacegiving` double default NULL, ');
    qryTemp.Sql.Add('`UnionFees` double default NULL, ');
    qryTemp.Sql.Add('`UnionDescription` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`LumpA` double default "0", ');
    qryTemp.Sql.Add('`LumpB` double default "0", ');
    qryTemp.Sql.Add('`LumpD` double default "0", ');
    qryTemp.Sql.Add('`LumpE` double default "0", ');
    qryTemp.Sql.Add('`Super` double default "0", ');
    qryTemp.Sql.Add('`SalarySacrifice` double default "0", ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure AddDataToTempPAYGCalcSummaryTable(Const Figures: TEmpPAYG_Figures);
var
  ProgressDialog: TProgressDialog;
  qryTemp: TERPCommand;
  InsertSQL: string;
  dtStartFinancial, dtEndFinancial, dtTest: TDateTime;
  wYear :Word;
begin


  wYear := Figures.Year;
  dtStartFinancial := EncodeDate(wYear - 1, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
  if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 2 then begin
    dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 28);
  end else if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 0 then begin
    dtEndFinancial := EncodeDate(wYear - 1, 12, 31);
  end else begin
    dtTest := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 1);
    dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, DaysInMonth(dtTest));
  end;

  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + TempTableName(Figures) +
    '(GlobalRef, PayID,PayDate,DatePaid,EmployeeID,EmployeeName, TotalTaxWithheld,Allowances,Other,' +
    'CDEP,GrossPayments,Commission,Deductions,WorkPlacegiving,UnionFees,UnionDescription,LumpA,LumpB,LumpD,LumpE,SalarySacrifice)';


  qryTemp := TERPCommand.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);
  try
    Processingcursor(True);
    try
        qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
        ProgressDialog.Caption  := 'Please Wait .......';
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := 6;
        ProgressDialog.Step     := 1;
        ProgressDialog.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

        //#Pays
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add(InsertSQL);
        qryTemp.Sql.Add('SELECT ');
        qryTemp.Sql.Add('P.GlobalRef, P.PayID, ');
        qryTemp.Sql.Add('P.PayDate, ');
        qryTemp.Sql.Add('P.DatePaid, ');
        qryTemp.Sql.Add('E.EmployeeID, ');
        qryTemp.Sql.Add('E.EmployeeName, ');
        qryTemp.Sql.Add('P.Tax AS TotalTaxWithheld, ');
        qryTemp.Sql.Add('P.Allowances AS Allowances, ');
        qryTemp.Sql.Add('0.00 AS Other, ');
        qryTemp.Sql.Add('Sum(P.CDEPGross) AS CDEP,   ');
        qryTemp.Sql.Add('Sum(P.Wages) - Sum(P.CDEPGross) AS GrossPayments, ');
        qryTemp.Sql.Add('P.Commission, ');
        qryTemp.Sql.Add('0.00 AS Deductions, ');
        qryTemp.Sql.Add('0.00 AS WorkPlacegiving, ');
        qryTemp.Sql.Add('0.00 AS UnionFees, ');
        qryTemp.Sql.Add('0.00 AS UnionDescription, ');
        qryTemp.Sql.Add('P.LumpA AS LumpA, ');
        qryTemp.Sql.Add('P.LumpB AS LumpB, ');
        qryTemp.Sql.Add('P.LumpD AS LumpD, ');
        qryTemp.Sql.Add('P.LumpE AS LumpE, ');
        qryTemp.Sql.Add('0.00 AS SalarySacrifice ');
        qryTemp.Sql.Add('FROM tblemployees AS E ');
        qryTemp.Sql.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        qryTemp.Sql.Add('WHERE P.Paid = "T" AND P.Deleted="F"');
        qryTemp.Sql.Add('AND DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
          + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
        qryTemp.Sql.Add('GROUP BY PayID');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

        qryTemp.Sql.Clear;
        qryTemp.Sql.Add('Drop table if exists ' + TempTableName(Figures) +'1;  ');
        qryTemp.Sql.Add('Create table ' + TempTableName(Figures) +'1  ');
        qryTemp.Sql.Add('Select PS.PayId ,  Sum(PS.AmountPaid ) as AmountPaid FRom ' + TempTableName(Figures) +' T  ');
        qryTemp.Sql.Add('inner join  tblpayssuperannuation PS on PS.PayId = T.PayID  ');
        qryTemp.Sql.Add('inner join tblsupertype ST on PS.SuperTypeID = ST.SuperTypeID and ST.IncludeInEmployeereportableContribution ="T" group by PS.PayId;  ');
        qryTemp.Sql.Add('update ' + TempTableName(Figures) +' T  ');
        qryTemp.Sql.Add('inner join  ' + TempTableName(Figures) +'1 T1 on T.PayId = T1.PayID  ');
        qryTemp.Sql.Add('Set T.super = T1.AmountPaid;');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

        //#Deduction Salary Sacrifice
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add(InsertSQL);
        qryTemp.Sql.Add('SELECT ');
        qryTemp.Sql.Add(' P.GlobalRef, P.PayID, ');
        qryTemp.Sql.Add('P.PayDate, ');
        qryTemp.Sql.Add('P.DatePaid, ');
        qryTemp.Sql.Add('E.EmployeeID, ');
        qryTemp.Sql.Add('E.EmployeeName, ');
        qryTemp.Sql.Add('0.00 AS TotalTaxWithheld, ');
        qryTemp.Sql.Add('0.00 AS Allowances, ');
        qryTemp.Sql.Add('0.00 AS Other, ');
        qryTemp.Sql.Add('0.00 AS CDEP, ');
        qryTemp.Sql.Add('-PD.Amount AS GrossPayments, ');
        qryTemp.Sql.Add('0.00 AS Commission, ');
        qryTemp.Sql.Add('0.00 AS Deductions, ');
        qryTemp.Sql.Add('0.00 AS WorkPlacegiving, ');
        qryTemp.Sql.Add('0.00 AS UnionFees, ');
        qryTemp.Sql.Add('0.00 AS UnionDescription, ');
        qryTemp.Sql.Add('0.00 AS LumpA, ');
        qryTemp.Sql.Add('0.00 AS LumpB, ');
        qryTemp.Sql.Add('0.00 AS LumpD, ');
        qryTemp.Sql.Add('0.00 AS LumpE, ');
        qryTemp.Sql.Add('0.00 AS SalarySacrifice ');
        qryTemp.Sql.Add('FROM tblemployees AS E ');
        qryTemp.Sql.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        qryTemp.Sql.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        qryTemp.Sql.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        qryTemp.Sql.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND PD.TaxExempt = "F" ');
        qryTemp.Sql.Add('AND DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
          + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

        //#Deduction
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add(InsertSQL);
        qryTemp.Sql.Add('SELECT ');
        qryTemp.Sql.Add(' P.GlobalRef, P.PayID, ');
        qryTemp.Sql.Add('P.PayDate, ');
        qryTemp.Sql.Add('P.DatePaid, ');
        qryTemp.Sql.Add('E.EmployeeID, ');
        qryTemp.Sql.Add('E.EmployeeName, ');
        qryTemp.Sql.Add('0.00 AS TotalTaxWithheld, ');
        qryTemp.Sql.Add('0.00 AS Allowances, ');
        qryTemp.Sql.Add('0.00 AS Other, ');
        qryTemp.Sql.Add('0.00 AS CDEP, ');
        qryTemp.Sql.Add('0.00 AS GrossPayments, ');
        qryTemp.Sql.Add('0.00 AS Commission, ');
        qryTemp.Sql.Add('PD.Amount AS Deductions, ');
        qryTemp.Sql.Add('0.00 AS WorkPlacegiving, ');
        qryTemp.Sql.Add('IF(PD.UnionFees = "T", PD.Amount, 0) AS UnionFees, ');
        qryTemp.Sql.Add('IF(PD.UnionFees = "T", D.Description, "") AS UnionDescription, ');
        qryTemp.Sql.Add('0.00 AS LumpA, ');
        qryTemp.Sql.Add('0.00 AS LumpB, ');
        qryTemp.Sql.Add('0.00 AS LumpD, ');
        qryTemp.Sql.Add('0.00 AS LumpE, ');
        qryTemp.Sql.Add('0.00 AS SalarySacrifice ');
        qryTemp.Sql.Add('FROM tblemployees AS E ');
        qryTemp.Sql.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        qryTemp.Sql.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        qryTemp.Sql.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        qryTemp.Sql.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND PD.TaxExempt = "T"  and PD.IsWorkPlacegiving ="F" ');
        qryTemp.Sql.Add('AND DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
          + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;


        //#WorkPlace giving
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add(InsertSQL);
        qryTemp.Sql.Add('SELECT ');
        qryTemp.Sql.Add(' P.GlobalRef, P.PayID, ');
        qryTemp.Sql.Add('P.PayDate, ');
        qryTemp.Sql.Add('P.DatePaid, ');
        qryTemp.Sql.Add('E.EmployeeID, ');
        qryTemp.Sql.Add('E.EmployeeName, ');
        qryTemp.Sql.Add('0.00 AS TotalTaxWithheld, ');
        qryTemp.Sql.Add('0.00 AS Allowances, ');
        qryTemp.Sql.Add('0.00 AS Other, ');
        qryTemp.Sql.Add('0.00 AS CDEP, ');
        qryTemp.Sql.Add('0.00 AS GrossPayments, ');
        qryTemp.Sql.Add('0.00 AS Commission, ');
        qryTemp.Sql.Add('0.0 AS Deductions, ');
        qryTemp.Sql.Add('PD.Amount AS WorkPlacegiving, ');
        qryTemp.Sql.Add('IF(PD.UnionFees = "T", PD.Amount, 0) AS UnionFees, ');
        qryTemp.Sql.Add('IF(PD.UnionFees = "T", D.Description, "") AS UnionDescription, ');
        qryTemp.Sql.Add('0.00 AS LumpA, ');
        qryTemp.Sql.Add('0.00 AS LumpB, ');
        qryTemp.Sql.Add('0.00 AS LumpD, ');
        qryTemp.Sql.Add('0.00 AS LumpE, ');
        qryTemp.Sql.Add('0.00 AS SalarySacrifice ');
        qryTemp.Sql.Add('FROM tblemployees AS E ');
        qryTemp.Sql.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        qryTemp.Sql.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        qryTemp.Sql.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        qryTemp.Sql.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND PD.TaxExempt = "T"  and PD.IsWorkPlacegiving ="T" ');
        qryTemp.Sql.Add('AND DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
          + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

        //#Salary Sacrifice
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add(InsertSQL);
        qryTemp.Sql.Add('SELECT ');
        qryTemp.Sql.Add(' P.GlobalRef, P.PayID, ');
        qryTemp.Sql.Add('P.PayDate, ');
        qryTemp.Sql.Add('P.DatePaid, ');
        qryTemp.Sql.Add('E.EmployeeID, ');
        qryTemp.Sql.Add('E.EmployeeName, ');
        qryTemp.Sql.Add('0.00 AS TotalTaxWithheld, ');
        qryTemp.Sql.Add('0.00 AS Allowances, ');
        qryTemp.Sql.Add('0.00 AS Other, ');
        qryTemp.Sql.Add('0.00 AS CDEP, ');
        qryTemp.Sql.Add('- PS.AmountPaid AS GrossPayments, ');
        qryTemp.Sql.Add('0.00 AS Commission, ');
        qryTemp.Sql.Add('0.00 AS Deductions, ');
        qryTemp.Sql.Add('0.00 AS WorkPlacegiving, ');
        qryTemp.Sql.Add('0.00 AS UnionFees, ');
        qryTemp.Sql.Add('Null AS UnionDescription, ');
        qryTemp.Sql.Add('0.00 AS LumpA, ');
        qryTemp.Sql.Add('0.00 AS LumpB, ');
        qryTemp.Sql.Add('0.00 AS LumpD, ');
        qryTemp.Sql.Add('0.00 AS LumpE, ');
        qryTemp.Sql.Add('PS.AmountPaid AS SalarySacrifice ');
        qryTemp.Sql.Add('FROM tblemployees E ');
        qryTemp.Sql.Add('INNER JOIN tblPays P USING(EmployeeID) ');
        qryTemp.Sql.Add('INNER JOIN tblpayssuperannuation PS USING(PayID) ');
        qryTemp.Sql.Add('INNER JOIN tblsupertype ST USING(SuperTypeID) ');
        qryTemp.Sql.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND ST.Description="Salary Sacrifice" ');
        qryTemp.Sql.Add('AND DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
          + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
        qryTemp.Execute;
        ProgressDialog.Stepit;
        Application.ProcessMessages;

      finally
        FreeAndNil(qryTemp);
        FreeAndNil(ProgressDialog);
      end;
  finally
    Processingcursor(False);
    Application.ProcessMessages;
  end;
end;

Procedure SetResults(var Figures: TEmpPAYG_Figures);
var
  dtStartFringeDate, dtEndFringeDate: TDateTime;
  qryTemp: TERPQuery;

begin
  // Set our ending date of Fringe Benefit Tax Year.
  dtStartFringeDate := EncodeDate(Figures.Year , 3, 31);
  // Start of Fringe Benefits Tax Year is 1 April ????  Yes ref ATO http://www.ato.gov.au/businesses/content.asp?doc=/content/52006.htm
  dtEndFringeDate := EncodeDate(Figures.Year - 1, 4, 1);

  qryTemp := TERPQuery.Create(nil);
  Try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;  
    qryTemp.Options.FlatBuffers := True;
    qryTemp.SQL.Add('SELECT  GlobalRef,');
    qryTemp.SQL.Add('EmployeeID as EmployeeID,');
    qryTemp.SQL.Add('EmployeeName as EmployeeName,');
    qryTemp.SQL.Add('Sum(TotalTaxWithheld) AS TotalTaxWithheld,');
    qryTemp.SQL.Add('Sum(Allowances) AS Allowances,');
    qryTemp.SQL.Add('Sum(Other) AS Other,');
    qryTemp.SQL.Add('Sum(CDEP) AS CDEP,');
    qryTemp.SQL.Add('Sum(GrossPayments) + Sum(Commission) AS GrossPayments,');
    qryTemp.SQL.Add('Sum(Deductions) AS Deductions,');
    qryTemp.SQL.Add('Sum(WorkPlacegiving) AS WorkPlacegiving,');
    qryTemp.SQL.Add('Sum(UnionFees) AS UnionFees,');
    qryTemp.SQL.Add('Max(UnionDescription) AS UnionDescription,');
    qryTemp.SQL.Add('Sum(LumpA) AS LumpA,');
    qryTemp.SQL.Add('Sum(LumpB) AS LumpB,');
    qryTemp.SQL.Add('Sum(LumpD) AS LumpD,');
    qryTemp.SQL.Add('Sum(LumpE) AS LumpE, ');
    qryTemp.SQL.Add('Sum(Super) AS Super ');
    qryTemp.SQL.Add('FROM ' + TempTableName(Figures));
    qryTemp.SQL.Add('WHERE EmployeeID='+IntToStr(Figures.EmployeeID));
    qryTemp.SQL.Add('GROUP BY EmployeeID;');

    qryTemp.Open;

    Figures.Tax := qryTemp.FieldByName('TotalTaxWithheld').asFloat;
    Figures.Gross := qryTemp.FieldByName('GrossPayments').asFloat;
    Figures.Allowances := qryTemp.FieldByName('Allowances').asFloat;
    Figures.LumpA := qryTemp.FieldByName('LumpA').asFloat;
    Figures.LumpB := qryTemp.FieldByName('LumpB').asFloat;
    Figures.LumpD := qryTemp.FieldByName('LumpD').asFloat;
    Figures.LumpE := qryTemp.FieldByName('LumpE').asFloat;
    Figures.Super := qryTemp.FieldByName('Super').asFloat;
    Figures.CDEP := qryTemp.FieldByName('CDEP').asFloat;
    Figures.Other := qryTemp.FieldByName('Other').asFloat;
    Figures.ReportableFB := PayCommon.GetTotalOfReportableFringeBenefits(Figures.EmployeeID, dtStartFringeDate, dtEndFringeDate);
  finally
    FreeAndNil(qryTemp);
  end;
end;

Procedure GetEmployeePAYG_Figures(var Figures: TEmpPAYG_Figures);
begin
  fTempTableName := '';
  CreateTempPAYGCalcSummaryTable(Figures);
  try
    AddDataToTempPAYGCalcSummaryTable(Figures);
    SetResults(Figures);
  finally
//    DeleteTempPAYGCalcSummaryTable(Figures);
  end;
end;

initialization
  fTempTableName := '';

end.


