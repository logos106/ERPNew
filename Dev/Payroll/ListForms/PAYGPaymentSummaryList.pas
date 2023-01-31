unit PAYGPaymentSummaryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DateUtils, MyAccess,ERPdbComponents, MemDS,
  DBAccess, wwdbdatetimepicker, wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg, ProgressDialog;

type
  TPAYGPaymentSummaryListGUI = class(TBaseListingGUI)
    qryMainEmployeeID: TAutoIncField;
    qryMainEmployeeName: TWideStringField;
    qryMainTotalTaxWithheld: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainOther: TFloatField;
    qryMainCDEP: TFloatField;
    qryMainGrossPayments: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainWorkPlacegiving: TFloatField;
    qryMainUnionFees: TFloatField;
    qryMainLumpA: TFloatField;
    qryMainLumpB: TFloatField;
    qryMainLumpD: TFloatField;
    qryMainLumpE: TFloatField;
    Label4: TLabel;
    cboYear: TComboBox;
    btnSummary: TDNMSpeedButton;
    btnGroupCerts: TDNMSpeedButton;
    Label7: TLabel;
    qryMainGlobalRef: TWideStringField;
    qryMainUnionDescription: TWideStringField;
    qryMainSalarySacrifice: TFloatField;
    qryMainReportableEmployerSuper: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure cboYearCloseUp(Sender: TObject);
    procedure btnSummaryClick(Sender: TObject);
    procedure btnGroupCertsClick(Sender: TObject);

    //function GetUserTempPAYGPaymentSummaryName: string;
    procedure CreateTempPAYGPaymentSummaryTable;
    procedure AddDataToTempPAYGPaymentSummaryTable;
    procedure CreateSQL;
    procedure cmdPrintClick(Sender: TObject);
    procedure actAddToFilterUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
    fsTablename: string;
    dtStartFinancial, dtEndFinancial, dtTest: TDateTime;
    wYear: word;
    fPAYGTable: string;
    function GetPAYGAllowanceSQL(const Year:String; const EmployeeID: integer; IncludeCoInfo: boolean = true):String;
    function EmployeeHasTaxableAllowances(const EmployeeID:integer):Boolean;
    function PAYGTable: string;
    procedure PopulatePAYGTable(const iYear: word; const iEmpID: integer);
    function PAYGSummarySheet: String;
  protected
    procedure RefreshQuery; override;
    function GetReportTypeID: integer; override;

  public
    { Public declarations }
  end;


implementation

uses
  CommonDbLib, PayCommon, DNMLib,  Forms, AppEnvironment, CommonLib,
  FastFuncs,tcTypes, MySQLConst, PayListFrm, frmCustomerFrm,
  BusObjPaysSuperannuation, BusObjEmployee, DbSharedObjectsObj, LogLib, tcConst;


{$R *.dfm}

procedure TPAYGPaymentSummaryListGUI.FormCreate(Sender: TObject);
var
  dtTest: TDateTime;
  wYearEnd, wYear, wMonth, wDay: word;
  iX: integer;
begin
  fPAYGTable := '';
  fsTablename := GetUserTemporaryTableName('PAYGPaymentSummary');

  dtTest := Now;
  DecodeDate(dtTest, wYear, wMonth, wDay);
  cboYear.Items.Clear;
  iX := wMonth;
  if iX <= 6 then begin
    cboYear.Text := IntToStr(wYear);
  end else begin
    cboYear.Text := IntToStr(wYear + 1);
  end;

  wYear := wYear - 15;
  wYearEnd := wYear + 30;
  for iX := wYear to wYearEnd do begin
    cboYear.Items.Add(IntToStr(iX));
  end;

  PopulateReportTable;
  CreateTempPAYGPaymentSummaryTable;
  AddDataToTempPAYGPaymentSummaryTable;
  CreateSQL;

  inherited;
end;


procedure TPAYGPaymentSummaryListGUI.PopulatePAYGTable(const iYear: word; const iEmpID: integer);
var
  cmd: TERPCommand;
  qry: TERPQuery;
  dtStartFringeDate, dtEndFringeDate: TDateTime;
  dtStartFinancial, dtEndFinancial, dtTest: TDateTime;
  dTotalFringes: double;
begin
  // Set our ending date of Fringe Benefit Tax Year.
  dtStartFringeDate := EncodeDate(iYear, 3, 31);

  // Start of Fringe Benefits Tax Year is 1 April  ref ATO http://www.ato.gov.au/businesses/content.asp?doc=/content/52006.htm
  dtEndFringeDate := EncodeDate(iYear - 1, 4, 1);

  dtStartFinancial := EncodeDate(iYear - 1, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
  if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 2 then begin
    dtEndFinancial := EncodeDate(iYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 28);
  end else if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 0 then begin
    dtEndFinancial := EncodeDate(iYear - 1, 12, 31);
  end else begin
    dtTest := EncodeDate(iYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 1);
    dtEndFinancial := EncodeDate(iYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, DaysInMonth(dtTest));
  end;

  dTotalFringes := GetTotalOfReportableFringeBenefits(iEmpID, dtStartFringeDate, dtEndFringeDate);


  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    cmd.SQL.Text := 'truncate ' + PAYGTable;
    logtext(cmd.SQL.text);
    cmd.Execute;

    cmd.SQL.Clear;

    cmd.SQL.Add('insert into ' + PAYGTable);
    cmd.SQL.Add('(EmployeeId,');
    cmd.SQL.Add('MoneyWords,');
    cmd.SQL.Add('YearEnding,');
    cmd.SQL.Add('DateStarted,');
    cmd.SQL.Add('DateFinished,');
    cmd.SQL.Add('TotalTaxWithheld,');
    cmd.SQL.Add('Allowances,');
    cmd.SQL.Add('Other,');
    cmd.SQL.Add('CDEP,');
    cmd.SQL.Add('Commission,');
    cmd.SQL.Add('GrossPayments,');
    cmd.SQL.Add('Deductions,');
    cmd.SQL.Add('WorkPlacegiving,');
    cmd.SQL.Add('UnionFees,');
    cmd.SQL.Add('UnionDescription,');
    cmd.SQL.Add('Fringe,');
    cmd.SQL.Add('LumpA,');
    cmd.SQL.Add('LumpB,');
    cmd.SQL.Add('LumpD,');
    cmd.SQL.Add('LumpE,');
    cmd.SQL.Add('SalarySacrifice,');
    cmd.SQL.Add('ReportableEmployerSuper,');
    cmd.SQL.Add('EmployeeFederalTax,');
    cmd.SQL.Add('CompanyFederalTax,');
    cmd.SQL.Add('EmployeeStateTax,');
    cmd.SQL.Add('CompanyStateTax,');
    cmd.SQL.Add('EmployeeOtherTax,');
    cmd.SQL.Add('CompanyOtherTax,');
    cmd.SQL.Add('EmployeeMedicareTax,');
    cmd.SQL.Add('CompanyMedicareTax,');
    cmd.SQL.Add('EmployeeSocialSecurityTax,');
    cmd.SQL.Add('CompanySocialSecurityTax)');

    cmd.SQL.Add('SELECT');
    cmd.SQL.Add('tmpGroupCert.EmployeeID as EmployeeID,');
    cmd.SQL.Add('"" as MoneyWords,');
    cmd.SQL.Add(IntToStr(iYear) + ' as YearEnding,');
    cmd.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, dtStartFinancial)) + ' as DateStarted,');
    cmd.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, dtEndFinancial)) + ' as DateFinished,');


    cmd.SQL.Add('Sum(tmpGroupCert.TotalTaxWithheld) AS TotalTaxWithheld,');
    cmd.SQL.Add('Sum(tmpGroupCert.Allowances) AS Allowances,');
    cmd.SQL.Add('Sum(tmpGroupCert.Other) AS Other,');
    cmd.SQL.Add('Sum(tmpGroupCert.CDEP) AS CDEP,');
    cmd.SQL.Add('Sum(tmpGroupCert.Commission) As Commission,');
    cmd.SQL.Add('Sum(tmpGroupCert.GrossPayments) AS GrossPayments,');
    cmd.SQL.Add('Sum(tmpGroupCert.Deductions) AS Deductions,');
    cmd.SQL.Add('Sum(tmpGroupCert.WorkPlacegiving) AS WorkPlacegiving,');
    cmd.SQL.Add('Sum(tmpGroupCert.UnionFees) AS UnionFees,');
    cmd.SQL.Add('Max(tmpGroupCert.UnionDescription) AS UnionDescription,');
    cmd.SQL.Add(FloatToStr(dTotalFringes) + ' AS Fringe,');
    cmd.SQL.Add('Sum(tmpGroupCert.LumpA) AS LumpA,');
    cmd.SQL.Add('Sum(tmpGroupCert.LumpB) AS LumpB,');
    cmd.SQL.Add('Sum(tmpGroupCert.LumpD) AS LumpD,');
    cmd.SQL.Add('Sum(tmpGroupCert.LumpE) AS LumpE,');
    cmd.SQL.Add('Sum(tmpGroupCert.SalarySacrifice) AS SalarySacrifice,');
    cmd.SQL.Add('Sum(tmpGroupCert.ReportableEmployerSuper) AS ReportableEmployerSuper');

    cmd.SQL.Add(',(select sum(pt1.Amount) from tblpaytax pt1 inner join tblPayTaxConfig ptc1 on pt1.PayTaxConfigId = ptc1.ID ' +
                  'and ptc1.TaxType = "Employee" and ptc1.GroupType = "Federal"  where pt1.PayId = tmpGroupCert.PayId) as EmployeeFederalTax');
    cmd.SQL.Add(',(select sum(pt2.Amount) from tblpaytax pt2 inner join tblPayTaxConfig ptc2 on pt2.PayTaxConfigId = ptc2.ID ' +
                  'and ptc2.TaxType = "Company" and ptc2.GroupType = "Federal"  where pt2.PayId = tmpGroupCert.PayId) as CompanyFederalTax');

    cmd.SQL.Add(',(select sum(pt3.Amount) from tblpaytax pt3 inner join tblPayTaxConfig ptc3 on pt3.PayTaxConfigId = ptc3.ID ' +
                  'and ptc3.TaxType = "Employee" and ptc3.GroupType = "State"  where pt3.PayId = tmpGroupCert.PayId) as EmployeeStateTax');
    cmd.SQL.Add(',(select sum(pt4.Amount) from tblpaytax pt4 inner join tblPayTaxConfig ptc4 on pt4.PayTaxConfigId = ptc4.ID ' +
                  'and ptc4.TaxType = "Company" and ptc4.GroupType = "State"  where pt4.PayId = tmpGroupCert.PayId) as CompanyStateTax');

    cmd.SQL.Add(',(select sum(pt5.Amount) from tblpaytax pt5 inner join tblPayTaxConfig ptc5 on pt5.PayTaxConfigId = ptc5.ID ' +
                  'and ptc5.TaxType = "Employee" and ptc5.GroupType = "Other"  where pt5.PayId = tmpGroupCert.PayId) as EmployeeOtherTax');
    cmd.SQL.Add(',(select sum(pt6.Amount) from tblpaytax pt6 inner join tblPayTaxConfig ptc6 on pt6.PayTaxConfigId = ptc6.ID ' +
                  'and ptc6.TaxType = "Company" and ptc6.GroupType = "Other"  where pt6.PayId = tmpGroupCert.PayId) as CompanyOtherTax');

    cmd.SQL.Add(',(select sum(pt7.Amount) from tblpaytax pt7 inner join tblPayTaxConfig ptc7 on pt7.PayTaxConfigId = ptc7.ID ' +
                  'and ptc7.TaxType = "Employee" and ptc7.GroupType = "Medicare"  where pt7.PayId = tmpGroupCert.PayId) as EmployeeMedicareTax');
    cmd.SQL.Add(',(select sum(pt8.Amount) from tblpaytax pt8 inner join tblPayTaxConfig ptc8 on pt8.PayTaxConfigId = ptc8.ID ' +
                  'and ptc8.TaxType = "Company" and ptc8.GroupType = "Medicare"  where pt8.PayId = tmpGroupCert.PayId) as CompanyMedicareTax');

    cmd.SQL.Add(',(select sum(pt9.Amount) from tblpaytax pt9 inner join tblPayTaxConfig ptc9 on pt9.PayTaxConfigId = ptc9.ID ' +
                  'and ptc9.TaxType = "Employee" and ptc9.GroupType = "SocialSecurity"  where pt9.PayId = tmpGroupCert.PayId) as EmployeeSocialSecurityTax');
    cmd.SQL.Add(',(select sum(pt10.Amount) from tblpaytax pt10 inner join tblPayTaxConfig ptc10 on pt10.PayTaxConfigId = ptc10.ID ' +
                  'and ptc10.TaxType = "Company" and ptc10.GroupType = "SocialSecurity"  where pt10.PayId = tmpGroupCert.PayId) as CompanySocialSecurityTax');

    cmd.SQL.Add('FROM ' + fsTablename + ' as tmpGroupCert');
//    cmd.SQL.Add('inner join tblemployees E on E.EmployeeID = tmpGroupCert.EmployeeID');

    { 2016-07-20 NOTE Changed to DatePaid from PayDate as ATO requires actual payment date }
    cmd.SQL.Add('WHERE DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
      + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' ');
    if iEmpID > 0 then
      cmd.SQL.Add('AND tmpGroupCert.EmployeeID =' + IntToStr(iEmpID) + ' ');
    cmd.SQL.Add('GROUP BY tmpGroupCert.EmployeeID');
    logtext(cmd.SQL.text);
    cmd.Execute;

    if iEmpId > 0  then begin
      qry.SQL.Text := 'select * from ' + PAYGTable + ' where EmployeeId = ' + IntToStr(iEmpId);
      qry.Open;
      if not qry.IsEmpty then begin
        qry.Edit;
        qry.FieldByName('MoneyWords').AsString := MoneyWords(qry.FieldByName('TotalTaxWithheld').AsFloat);
        if qry.FieldByName('MoneyWords').AsString = '' then
          qry.FieldByName('MoneyWords').AsString := 'Zero Dollars.';
        qry.Post;
      end;
    end;

  finally
    DbSharedObj.ReleaseObj(cmd);
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPAYGPaymentSummaryListGUI.RefreshQuery;
begin
  if cboYear.Text <> '' then begin
    wYear := FastFuncs.StrToInt(cboYear.Text);
    dtStartFinancial := EncodeDate(wYear - 1, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
    if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 2 then begin
      dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 28);
    end else if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 0 then begin
      dtEndFinancial := EncodeDate(wYear - 1, 12, 31);
    end else begin
      dtTest := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 1);
      dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, DaysInMonth(dtTest));
    end;
  end;
  qryMain.Params.ParamByName('txtfrom').AsDateTime :=  dtStartFinancial;
  qryMain.Params.ParamByName('txtto').AsDateTime :=  dtEndFinancial;
  inherited;
end;

function TPAYGPaymentSummaryListGUI.PAYGTable: string;
begin
  if fPAYGTable = '' then
    fPAYGTable := 'tmp_PAYGReport';
  result := fPAYGTable;
end;

procedure TPAYGPaymentSummaryListGUI.cboYearCloseUp(Sender: TObject);
var
  wYear, wMonth, wDay: word;
begin
  inherited;
  DecodeDate(Now(), wYear, wMonth, wDay);
  try
    FastFuncs.StrToInt(cboYear.Text);
  except
    cboYear.Text := IntToStr(wYear);
  end;

  RefreshQuery;
end;

procedure TPAYGPaymentSummaryListGUI.btnSummaryClick(Sender: TObject);
//var
//  SQL: string;
begin
  DisableForm;
  try
    // No financial year specified, then bounce em!
    if cboYear.Text = '' then Exit;

    PopulatePAYGTable(StrToInt(cboYear.Text),0);

    Self.PrintTemplateReport(PAYGSummarySheet, '', not chkPreview.Checked, 1);
  finally
    EnableForm;
  end;
end;
Function TPAYGPaymentSummaryListGUI.PAYGSummarySheet :String;
begin
  if (AppEnv.RegionalOptions.RegionType = rUSA ) then Begin
    result := 'USA W-2 Summary Statement';
  end else begin
    result := 'PAYG Summary Statement';
  End;
end;
procedure TPAYGPaymentSummaryListGUI.btnGroupCertsClick(Sender: TObject);
var
  bm: TBookMark;
  iX: integer;
  GroupCertReport: string;
  ReportSQL: string;
begin
  DisableForm;
  try
    if grdMain.SelectedList.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('Please Select which Employees To Print/Preview', mtInformation, [mbOK], 0);
      Exit;
    end;

    // No financial year specified, then bounce em!
    if cboYear.Text = '' then Exit;

    GroupCertReport := self.ReportName;

    // Record record position.
    bm := qryMain.GetBookmark;
    try
      // Iterate through all selected items.
//      ReportSQLSupplied := true;
      ReportSQLSupplied := false;
      for iX := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[iX]);

        if TEmployee.TFNForEmployeeID(self.qryMainEmployeeID.AsInteger) = '' then begin
          if CommonLib.MessageDlgXP_Vista('File Number is missing for ' + self.qryMainEmployeeName.Text +
            ', do you still wish to print for this person?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
          continue;
        end;
        PopulatePAYGTable(StrToInt(cboYear.Text), qryMain.FieldByName('EmployeeID').AsInteger);
//        Self.PrintTemplateReport('PAYG Payment Summary', PopulatePAYGSummaryTable(FastFuncs.StrToInt(cboYear.Text),
//          qryMain.FieldByName('EmployeeID').AsInteger), not chkPreview.Checked, 1);
        self.ReportSQLSupplied := True;
//        Self.PrintTemplateReport(GroupCertReport, '', not chkPreview.Checked, 1);

        if GroupCertReport = 'USA Payroll Form W-2 2022' then begin
          ReportSQL := '{Company} ' +
                      ' SELECT c.CompanyName, c.ABN AS EIN, CONCAT(c.Address, " ", c.Address2) AS Address,' +
                      ' CONCAT(c.City, ", ", c.State, ", ", c.Country, ", ", c.PostCode) AS Address1' +
                      ' FROM tblcompanyinformation c';
          ReportSQL := ReportSQL + ' ~|||~ {Employee}' +
                      ' SELECT e.FirstName, e.LastName, e.TFN AS SSN, CONCAT(e.Street, " ", e.Street2) AS Address,' +
                      ' CONCAT(e.Suburb, ", ", e.State, ", ", e.Country, ", ", e.PostCode) AS Address1, p.EmployeeFederalTax AS EFT,' +
                      ' p.EmployeeStateTax AS EST, p.EmployeeMedicareTax AS EMT, p.EmployeeSocialSecurityTax AS ESST, p.GrossPayments AS Wage,' +
                      ' IF(p.GrossPayments < 147000, 14700, GrossPayments) AS SSWage' +
                      ' FROM tmp_paygreport AS p INNER JOIN tblemployees AS e ON p.EmployeeID=e.EmployeeID' +
                      ' WHERE e.EmployeeID=' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger);
          ReportSQL := ReportSQL + ' ~|||~ {Box1}' +
                      ' SELECT SUM(ed.Amount) AS Amount, bc.Code AS BCode' +
                      ' FROM tblemployeedeductions ed LEFT JOIN tbldeductions d ON ed.DeductionID=d.DeductionID' +
                      ' LEFT JOIN tblbox12codes bc ON d.box12codeId=bc.CodeID' +
                      ' WHERE d.Box12CodeID <> 0 AND ed.EmployeeID=' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger) +
                      ' GROUP BY d.box12codeID LIMIT 0, 1';
          ReportSQL := ReportSQL + ' ~|||~ {Box2}' +
                      ' SELECT SUM(ed.Amount) AS Amount, bc.Code AS BCode' +
                      ' FROM tblemployeedeductions ed LEFT JOIN tbldeductions d ON ed.DeductionID=d.DeductionID' +
                      ' LEFT JOIN tblbox12codes bc ON d.box12codeId=bc.CodeID' +
                      ' WHERE d.Box12CodeID <> 0 AND ed.EmployeeID=' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger) +
                      ' GROUP BY d.box12codeID LIMIT 1, 1';
          ReportSQL := ReportSQL + ' ~|||~ {Box3}' +
                      ' SELECT SUM(ed.Amount) AS Amount, bc.Code AS BCode' +
                      ' FROM tblemployeedeductions ed LEFT JOIN tbldeductions d ON ed.DeductionID=d.DeductionID' +
                      ' LEFT JOIN tblbox12codes bc ON d.box12codeId=bc.CodeID' +
                      ' WHERE d.Box12CodeID <> 0 AND ed.EmployeeID=' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger) +
                      ' GROUP BY d.box12codeID LIMIT 2, 1';
          ReportSQL := ReportSQL + ' ~|||~ {Box4}' +
                      ' SELECT SUM(ed.Amount) AS Amount, bc.Code AS BCode' +
                      ' FROM tblemployeedeductions ed LEFT JOIN tbldeductions d ON ed.DeductionID=d.DeductionID' +
                      ' LEFT JOIN tblbox12codes bc ON d.box12codeId=bc.CodeID' +
                      ' WHERE d.Box12CodeID <> 0 AND ed.EmployeeID=' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger) +
                      ' GROUP BY d.box12codeID LIMIT 3, 1';
        end
        else begin
          self.ReportSQLSupplied := False;
          ReportSQL := '';
        end;

        PrintTemplateReport(GroupCertReport, ReportSQL, not chkPreview.Checked, 1);

        ReportSQLSupplied := true;
        if EmployeeHasTaxableAllowances(qryMain.FieldByName('EmployeeID').AsInteger) then
          Self.PrintTemplateReport('PAYG Summary Allowances', GetPAYGAllowanceSQL(cboYear.Text,
            qryMain.FieldByName('EmployeeID').AsInteger), not chkPreview.Checked, 1);
      end;
      ReportSQLSupplied := false;
      // Restore original position.
    Finally
      qryMain.GotoBookmark(bm);
      qryMain.FreeBookmark(bm);
    end;
  finally
    EnableForm;
  end;  
end;

function TPAYGPaymentSummaryListGUI.EmployeeHasTaxableAllowances(const EmployeeID:integer):Boolean;
var
  qry:TERPQuery;
begin
  Result := False;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add(GetPAYGAllowanceSQL(cboYear.Text,EmployeeID,false));
    qry.Open;
    if qry.RecordCount > 0 then Result := True;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

function TPAYGPaymentSummaryListGUI.GetPAYGAllowanceSQL(const Year:String; const EmployeeID: integer; IncludeCoInfo: boolean = true):String;
begin
  Result := 'SELECT P.PayID,Sum(PA.MoneyAmount) as MoneyAmount,A.Description,P.PayDate, E.EmployeeName ' +
    'FROM tblpays AS P ' +
    'INNER JOIN tblpaysallowances As PA on PA.PayID = P.PayID and PA.DisplayIn = "Allowances" ' +
    'INNER JOIN tblallowances AS A on PA.AllowanceID = A.AllowanceID ' +
    'INNER JOIN tblemployees as E on P.EmployeeID = E.EmployeeID ' +
    'WHERE P.Paid = "T" AND P.Deleted = "F" ' +
    //AND PA.TaxExempt = "F" ' +
    'AND  P.EmployeeID = ' + IntToStr(EmployeeID) +
    { 2016-07-20 NOTE Changed to DatePaid from PayDate as ATO requires actual payment date }
    ' AND P.DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial))
      + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ' Group by A.Description;' ;
  if IncludeCoInfo then
    Result := Result + '~|||~{companyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, '+
             ' CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, '+
             ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
end;

function TPAYGPaymentSummaryListGUI.GetReportTypeID: integer;
begin
  if Appenv.RegionalOptions.RegionType = RUSA then
       result := GetReportTypeIDForTypeName('USAPAYG')
  else result := GetReportTypeIDForTypeName('PAYG');
end;

procedure TPAYGPaymentSummaryListGUI.AddDataToTempPAYGPaymentSummaryTable;
var
  //qryTemp: TERPCommand;
  InsertSQL: string;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + fsTablename +
    '(GlobalRef, PayID,PayDate,DatePaid,EmployeeID,EmployeeName,EmployeeTFN,EmployeeABN, TotalTaxWithheld,Allowances,Other,' +
    'CDEP,GrossPayments,Commission,Deductions,WorkPlacegiving,UnionFees,UnionDescription,LumpA,LumpB,LumpD,LumpE,'+
    'SalarySacrifice,ReportableEmployerSuper)';

  With Scriptmain do begin
    Processingcursor(True);
    try
      SQL.Clear;
        //#Pays
        SQL.Clear;
        SQL.Add('DELETE FROM  ' + fsTablename + '; ');

        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add('P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('P.Tax AS TotalTaxWithheld, ');
        SQL.Add('P.Allowances AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('Sum(P.CDEPGross) AS CDEP,');
        SQL.Add('Sum(P.Wages) - Sum(P.CDEPGross) + Sum(P.Commission) + (Sum(P.Allowances) - Sum(P.GrossExcludeAllowances)) AS GrossPayments, ');
        SQL.Add('P.Commission, ');
        SQL.Add('0.00 AS Deductions, ');
        SQL.Add('0.00 AS WorkPlacegiving, ');
        SQL.Add('0.00 AS UnionFees, ');
        SQL.Add('null AS UnionDescription, ');
        SQL.Add('P.LumpA AS LumpA, ');
        SQL.Add('P.LumpB AS LumpB, ');
        SQL.Add('P.LumpD AS LumpD, ');
        SQL.Add('P.LumpE AS LumpE, ');
        SQL.Add('0.00 AS SalarySacrifice, ');
        SQL.Add('0.00 AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees AS E ');
        SQL.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F"');
        SQL.Add('GROUP BY PayID;');


        SQL.Add('update ' + fsTablename + ' T');
        SQL.Add('set T.Allowances = (select Sum(PA.MoneyAmount) from tblpaysallowances PA where T.PayID = PA.PayID and PA.DisplayIn = "Allowances");');

        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add(' P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('0.00 AS TotalTaxWithheld, ');
        SQL.Add('0.00 AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('0.00 AS CDEP, ');
        SQL.Add('-PD.Amount AS GrossPayments, ');
        SQL.Add('0.00 AS Commission, ');
        SQL.Add('PD.Amount AS Deductions, ');
        SQL.Add('0.00 AS WorkPlacegiving, ');
        SQL.Add('0.00 AS UnionFees, ');
        SQL.Add('null AS UnionDescription, ');
        SQL.Add('0.00 AS LumpA, ');
        SQL.Add('0.00 AS LumpB, ');
        SQL.Add('0.00 AS LumpD, ');
        SQL.Add('0.00 AS LumpE, ');
        SQL.Add('0.00 AS SalarySacrifice, ');
        SQL.Add('0.00 AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees AS E ');
        SQL.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        SQL.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        SQL.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND PD.TaxExempt = "T" and PD.IsWorkPlacegiving="F" ; ');


        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add(' P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('0.00 AS TotalTaxWithheld, ');
        SQL.Add('0.00 AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('0.00 AS CDEP, ');
        SQL.Add('0.00 AS GrossPayments, ');
        SQL.Add('0.00 AS Commission, ');
        SQL.Add('PD.MoneyAmount AS Deductions, ');
        SQL.Add('0.0 AS WorkPlacegiving, ');
        SQL.Add('IF(PD.UnionFees = "T", PD.Amount, 0) AS UnionFees, ');
        SQL.Add('IF(PD.UnionFees = "T", D.Description, "") AS UnionDescription, ');
        SQL.Add('0.00 AS LumpA, ');
        SQL.Add('0.00 AS LumpB, ');
        SQL.Add('0.00 AS LumpD, ');
        SQL.Add('0.00 AS LumpE, ');
        SQL.Add('0.00 AS SalarySacrifice, ');
        SQL.Add('0.00 AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees AS E ');
        SQL.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        SQL.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        SQL.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND PD.TaxExempt = "F" and PD.IsWorkPlacegiving="F" ; ');

        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add(' P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('0.00 AS TotalTaxWithheld, ');
        SQL.Add('0.00 AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('0.00 AS CDEP, ');
        SQL.Add('0.00 AS GrossPayments, ');
        SQL.Add('0.00 AS Commission, ');
        SQL.Add('0.0 AS Deductions, ');
        SQL.Add('PD.MoneyAmount AS WorkPlacegiving, ');
        SQL.Add('IF(PD.UnionFees = "T", PD.Amount, 0) AS UnionFees, ');
        SQL.Add('IF(PD.UnionFees = "T", D.Description, "") AS UnionDescription, ');
        SQL.Add('0.00 AS LumpA, ');
        SQL.Add('0.00 AS LumpB, ');
        SQL.Add('0.00 AS LumpD, ');
        SQL.Add('0.00 AS LumpE, ');
        SQL.Add('0.00 AS SalarySacrifice, ');
        SQL.Add('0.00 AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees AS E ');
        SQL.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID ');
        SQL.Add('INNER JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID ');
        SQL.Add('INNER JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F" and PD.IsWorkPlacegiving="T" ; ');

        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add(' P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('0.00 AS TotalTaxWithheld, ');
        SQL.Add('0.00 AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('0.00 AS CDEP, ');
        SQL.Add('- PS.AmountPaid AS GrossPayments, ');
        SQL.Add('0.00 AS Commission, ');
        SQL.Add('0.00 AS Deductions, ');
        SQL.Add('0.00 AS WorkPlacegiving, ');
        SQL.Add('0.00 AS UnionFees, ');
        SQL.Add('Null AS UnionDescription, ');
        SQL.Add('0.00 AS LumpA, ');
        SQL.Add('0.00 AS LumpB, ');
        SQL.Add('0.00 AS LumpD, ');
        SQL.Add('0.00 AS LumpE, ');
        SQL.Add('PS.AmountPaid AS SalarySacrifice, ');
        SQL.Add('0.00 AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees E ');
        SQL.Add('INNER JOIN tblPays P USING(EmployeeID) ');
        SQL.Add('INNER JOIN tblpayssuperannuation PS USING(PayID) ');
        SQL.Add('INNER JOIN tblsupertype ST USING(SuperTypeID) ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F" AND ST.Description="Salary Sacrifice"; ');


        SQL.Add(InsertSQL);
        SQL.Add('SELECT ');
        SQL.Add(' P.GlobalRef, P.PayID, ');
        SQL.Add('P.PayDate, ');
        SQL.Add('P.DatePaid, ');
        SQL.Add('E.EmployeeID, ');
        SQL.Add('E.EmployeeName, ');
        SQL.Add('E.TFN, ');
        SQL.Add('E.ABN, ');
        SQL.Add('0.00 AS TotalTaxWithheld, ');
        SQL.Add('0.00 AS Allowances, ');
        SQL.Add('0.00 AS Other, ');
        SQL.Add('0.00 AS CDEP, ');
        SQL.Add('0.00 AS GrossPayments, ');
        SQL.Add('0.00 AS Commission, ');
        SQL.Add('0.00 AS Deductions, ');
        SQL.Add('0.00 AS WorkPlacegiving, ');
        SQL.Add('0.00 AS UnionFees, ');
        SQL.Add('Null AS UnionDescription, ');
        SQL.Add('0.00 AS LumpA, ');
        SQL.Add('0.00 AS LumpB, ');
        SQL.Add('0.00 AS LumpD, ');
        SQL.Add('0.00 AS LumpE, ');
        SQL.Add('0.0 AS SalarySacrifice, ');
        SQL.Add('PS.AmountPaid AS ReportableEmployerSuper ');
        SQL.Add('FROM tblemployees E ');
        SQL.Add('INNER JOIN tblPays P USING(EmployeeID) ');
        SQL.Add('INNER JOIN tblpayssuperannuation PS USING(PayID) ');
        SQL.Add('INNER JOIN tblsupertype ST USING(SuperTypeID) ');
        SQL.Add('WHERE P.Paid = "T" AND P.Deleted="F"');
        SQL.Add(' and ST.IncludeInEmployeereportableContribution ="T";');

      ShowProgressbar(WAITMSG, 10);
      try
        clog(SQL.text);
        Execute
      finally
        HideProgressbar;
      end;
  finally
    Processingcursor(False);
    Application.ProcessMessages;
  end;
  end;

end;


procedure TPAYGPaymentSummaryListGUI.CreateTempPAYGPaymentSummaryTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + fsTablename + ' ');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + fsTablename + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`PayID` int(11) NOT NULL default "0", ');
    qryTemp.Sql.Add('`GlobalRef` varchar(255) , ');
    qryTemp.Sql.Add('`PayDate` date default NULL, ');
    qryTemp.Sql.Add('`DatePaid` dateTime default NULL, ');
    qryTemp.Sql.Add('`EmployeeID` int(11) NOT NULL default "0", ');
    qryTemp.Sql.Add('`EmployeeName` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`EmployeeTFN` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`EmployeeABN` varchar(255) default NULL, ');
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
    qryTemp.Sql.Add('`SalarySacrifice` double default "0", ');
    qryTemp.Sql.Add('ReportableEmployerSuper double default "0", ');
    qryTemp.Sql.Add('`SocialSecurityNumber` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`EIN` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`StateTax` double default NULL, ');
    qryTemp.Sql.Add('`FederalTax` double default NULL, ');
    qryTemp.Sql.Add('`MedicareCompanyTax` double default NULL, ');
    qryTemp.Sql.Add('`MedicareEmployeeTax` double default NULL, ');
    qryTemp.Sql.Add('`SocialSecurityCompanyTax` double default NULL, ');
    qryTemp.Sql.Add('`SocialSecurityEmployeeTax` double default NULL, ');
    qryTemp.Sql.Add('`OtherCompanyTax` double default NULL, ');
    qryTemp.Sql.Add('`OtherEmployeeTax` double default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPAYGPaymentSummaryListGUI.CreateSQL;
begin
  if cboYear.Text <> '' then begin
    wYear := FastFuncs.StrToInt(cboYear.Text);
    dtStartFinancial := EncodeDate(wYear - 1, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
    if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 2 then begin
      dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 28);
    end else if GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1 = 0 then begin
      dtEndFinancial := EncodeDate(wYear - 1, 12, 31);
    end else begin
      dtTest := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, 1);
      dtEndFinancial := EncodeDate(wYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts) - 1, DaysInMonth(dtTest));
    end;
  end;

  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT  GlobalRef,');
  qryMain.SQL.Add('EmployeeID as EmployeeID,');
  qryMain.SQL.Add('EmployeeName as EmployeeName,');
  qryMain.SQL.Add('Sum(TotalTaxWithheld) AS TotalTaxWithheld,');
  qryMain.SQL.Add('Sum(Allowances) AS Allowances,');
  qryMain.SQL.Add('Sum(Other) AS Other,');
  qryMain.SQL.Add('Sum(CDEP) AS CDEP,');
  //qryMain.SQL.Add('Sum(GrossPayments) + Sum(Commission) AS GrossPayments,');
  qryMain.SQL.Add('Sum(GrossPayments) AS GrossPayments,');
  qryMain.SQL.Add('Sum(Deductions) AS Deductions,');
  qryMain.SQL.Add('Sum(WorkPlacegiving) AS WorkPlacegiving,');
  qryMain.SQL.Add('Sum(UnionFees) AS UnionFees,');
  qryMain.SQL.Add('Max(UnionDescription) AS UnionDescription,');
  qryMain.SQL.Add('Sum(LumpA) AS LumpA,');
  qryMain.SQL.Add('Sum(LumpB) AS LumpB,');
  qryMain.SQL.Add('Sum(LumpD) AS LumpD,');
  qryMain.SQL.Add('Sum(LumpE) AS LumpE, ');
  qryMain.SQL.Add('Sum(SalarySacrifice) AS SalarySacrifice, ');
  qryMain.SQL.Add('Sum(ReportableEmployerSuper) AS ReportableEmployerSuper ');

  qryMain.SQL.Add('FROM ' + fsTablename + ' as tmpGroupCert');
    { 2016-07-20 NOTE Changed to DatePaid from PayDate as ATO requires actual payment date }
  qryMain.SQL.Add('WHERE DatePaid BETWEEN :txtfrom AND :txtto ');
  qryMain.SQL.Add('GROUP BY EmployeeID ');
  qryMain.SQL.Add('ORDER BY EmployeeID;');
end;

procedure TPAYGPaymentSummaryListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    if not chkAdvancedPrinting.Checked then inherited;
  finally
    EnableForm;
  end;  
end;

procedure TPAYGPaymentSummaryListGUI.actAddToFilterUpdate(Sender: TObject);
begin
  inherited;
  cmdPrint.Enabled := not chkAdvancedPrinting.Checked;
  btnGroupCerts.Enabled := chkAdvancedPrinting.Checked;
  btnSummary.Enabled := chkAdvancedPrinting.Checked;  
end;

procedure TPAYGPaymentSummaryListGUI.FormDestroy(Sender: TObject);
begin
  //DeleteTempPAYGPaymentSummaryTable;
  DestroyUserTemporaryTable(fstablename);
  inherited;
end;

procedure TPAYGPaymentSummaryListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPAYGPaymentSummaryListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPAYGPaymentSummaryListGUI.FormShow(Sender: TObject);
begin
  inherited;
  Self.LblNote.Caption := '';
end;

procedure TPAYGPaymentSummaryListGUI.grdMainDblClick(Sender: TObject);
var
  frm:TComponent;
  iEmployeeID:integer;
begin
 // inherited;
  iEmployeeId := qryMain.FieldByName('EmployeeID').AsInteger;
  if FormStillOpen('TPayListingGUI') then TForm(FindExistingComponent('TPayListingGUI')).Close;
  Application.ProcessMessages;
  Frm := GetComponentByClassName('TPayListingGUI');
  if Assigned(Frm) then begin
    with TPayListingGUI(Frm) do begin
      FilterString := '[Employee ID] = ' + IntToStr(iEmployeeId)+' AND [Deleted] ="F"';
      ShowModal;
    end;
  end; 
end;

initialization
  RegisterClassOnce(TPAYGPaymentSummaryListGUI);

end.
