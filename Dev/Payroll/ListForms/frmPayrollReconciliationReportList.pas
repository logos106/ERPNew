unit frmPayrollReconciliationReportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DateUtils,  MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmPayrollReconciliationReportListGUI = class(TBaseListingGUI)
    Label4: TLabel;
    cboYear: TComboBox;
    qryMainYear: TIntegerField;
    qryMainMonthNumber: TIntegerField;
    qryMainDateDescription: TWideStringField;
    qryMainGrossWages: TFloatField;
    qryMainGrossTax: TFloatField;
    qryMainNetWages: TFloatField;
    qryMainTaxPaid: TFloatField;
    qryMainLeavePaid: TFloatField;
    qryMainSuperanuationPaid: TFloatField;
    qryMainDeductionsPaid: TFloatField;
    qryMainSundryPaid: TFloatField;
    qryMainAllowancesPaid: TFloatField;
    qryMainTotalExpenses: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboYearCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
    TempTableName: string;
    procedure CreateTempReconTable;
    procedure CreateTableData;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
  end;

implementation

uses
  CommonDbLib, PayCommon,
  DNMLib,  AppEnvironment, CommonLib, FastFuncs, PayListFrm, forms,
  tcConst, PayAccounts;

{$R *.dfm}

procedure TfrmPayrollReconciliationReportListGUI.CreateTempReconTable;
begin
  TempTableName:=
    commondbLib.CreateUserTemporaryTable('tmp_payrollrecreport' , '');
  qryMain.SQL.Clear;
  qryMain.SQL.Add('select');
  qryMain.SQL.Add('Year,MonthNumber,DateDescription,');
  qryMain.SQL.Add('sum(GrossWages) as GrossWages,');
  qryMain.SQL.Add('sum(GrossTax) as GrossTax,');
  qryMain.SQL.Add('sum(NetWages) as NetWages,');
  qryMain.SQL.Add('sum(TaxPaid) as TaxPaid,');
  qryMain.SQL.Add('sum(LeavePaid) as LeavePaid,');
  qryMain.SQL.Add('sum(SuperanuationPaid) as SuperanuationPaid,');
  qryMain.SQL.Add('sum(DeductionsPaid) as DeductionsPaid,');
  qryMain.SQL.Add('sum(SundryPaid) as SundryPaid,');
  qryMain.SQL.Add('sum(AllowancesPaid) as AllowancesPaid,');
  qryMain.SQL.Add('sum(TotalExpenses) as TotalExpenses');
  qryMain.SQL.Add('from ' + TempTableName);
  qryMain.SQL.Add('group by Year,MonthNumber');
  qryMain.SQL.Add('order by Year,MonthNumber');
  RefreshOrignalSQL;
end;

procedure TfrmPayrollReconciliationReportListGUI.FormCreate(Sender: TObject);
var
  dtTest: TDateTime;
  wYearEnd, wYear, wMonth, wDay: word;
  iX: integer;
begin
  inherited;

  dtTest := Now;
  DecodeDate(dtTest, wYear, wMonth, wDay);
  cboYear.Items.Clear;
  cboYear.Text := IntToStr(wYear);
  wYear := wYear - 15;
  wYearEnd := wYear + 30;
  for iX := wYear to wYearEnd do begin
    cboYear.Items.Add(IntToStr(iX));
  end;

  CreateTempReconTable;
end;

procedure TfrmPayrollReconciliationReportListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(TempTableName);
  inherited;
end;

procedure TfrmPayrollReconciliationReportListGUI.cboYearCloseUp(Sender: TObject);
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

  // Rebuild our query and table.
  RefreshQuery;
end;

procedure TfrmPayrollReconciliationReportListGUI.CreateTableData;
var
  scr: TMyScript;
  iYear, iMonth, iDay, x: word;
  DateFieldName: string;
  DateFrom, DateTo, DateTemp: TDateTime;
begin
  if grpFilters.ItemIndex = 0 then
    DateFieldName:= 'p.datepaid'
  else
    DateFieldName:= 'p.payDate';

  iYear:= FastFuncs.StrToInt(cboYear.Text) -1;
  iMonth:= GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
  DateFrom:= EncodeDate(iYear,iMonth,1);
  DateTo:= EncodeDate(iYear+1,iMonth,1) -1;

  scr:= TMyScript.Create(nil);
  try
    scr.Connection:= CommonDbLib.GetSharedMyDacConnection;
    scr.SQL.Add('TRUNCATE ' + TempTableName + ';');
    DecodeDate(DateFrom,iYear,iMonth,iDay);
    for x:= 1 to 12 do begin
      DateTemp:= EncodeDate(iYear,iMonth,iDay);
      scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
      scr.SQL.Add('(Year,MonthNumber,DateDescription)');
      scr.SQL.Add('values('+IntToStr(iYear)+','+IntToStr(iMonth)+','+
        QuotedStr(FormatDateTime('mmmm yyyy',DateTemp))+');');
      IncAMonth(iYear,iMonth,iDay,1);
    end;
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('sum(p.gross) as GrossWages,');
    scr.SQL.Add('sum(p.tax) as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p');
    scr.SQL.Add('where p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
    scr.SQL.Add('group by Year,MonthNumber;');



    { Net }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('sum(-t.Amount) as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.NetWagesAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.NetWagesAccountIdList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    (*
    Binny : Preference PAYGExpenseAccountId is not used. ie: no GUI for the input to this field
    { Tax Paid }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('sum(-t.Amount) as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.PAYGExpenseAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.PAYGExpenseAccountIdList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');*)

    { Leave }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('sum(-t.Amount) as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.LeaveProvisionAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.LeaveProvisionAccountIdList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    { Superanuation }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('sum(-t.Amount) as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.SuperPaidAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.SuperPaidAccountIDList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    { Deductions }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('sum(-t.Amount) as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.DeductionsPaidAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.DeductionsPaidAccountIDList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    { Sundries }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('sum(-t.Amount) as SundryPaid,');
    scr.SQL.Add('0 as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.SundriesPaidAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.SundriesPaidAccountIDList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    { Allowances }
    scr.SQL.Add('INSERT INTO ' + TempTableName + ' ');
    scr.SQL.Add('(Year,MonthNumber,DateDescription,GrossWages,GrossTax,NetWages,TaxPaid,');
    scr.SQL.Add('LeavePaid,SuperanuationPaid,DeductionsPaid,SundryPaid,AllowancesPaid)');
    scr.SQL.Add('SELECT');
    scr.SQL.Add('YEAR(' +DateFieldName+ ') as Year,');
    scr.SQL.Add('MONTH(' +DateFieldName+ ') as MonthNumber,');
    scr.SQL.Add('CONCAT(MONTHNAME(' +DateFieldName+ ')," ",YEAR(' +DateFieldName+ ')) as DateDescription,');
    scr.SQL.Add('0 as GrossWages,');
    scr.SQL.Add('0 as GrossTax,');
    scr.SQL.Add('0 as NetWages,');
    scr.SQL.Add('0 as TaxPaid,');
    scr.SQL.Add('0 as LeavePaid,');
    scr.SQL.Add('0 as SuperanuationPaid,');
    scr.SQL.Add('0 as DeductionsPaid,');
    scr.SQL.Add('0 as SundryPaid,');
    scr.SQL.Add('sum(-t.Amount) as AllowancesPaid');
    scr.SQL.Add('FROM tblpays p, tblpaystransactions t');
    scr.SQL.Add('where p.payid = t.payid');
    scr.SQL.Add('and p.Paid = "T" AND p.Deleted = "F"');
    scr.SQL.Add('and (t.AccountType = "EXEXP" OR t.AccountType = "EXP")');
    scr.SQL.Add('and ' + DateFieldName + ' between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dateTo)));
//    scr.SQL.Add('and t.AccountID = ' + IntToStr(AppEnv.PayPrefs.AllowancePaidAccountID));
    scr.SQL.Add('and t.AccountID in (' + PayAccounts.AllowancePaidAccountIDList + ')');
    scr.SQL.Add('group by Year,MonthNumber;');

    scr.SQL.Add('update ' + TempTableName);
    scr.SQL.Add('set totalexpenses = (NetWages+TaxPaid+LeavePaid+SuperanuationPaid+DeductionsPaid+SundryPaid+AllowancesPaid);');

    scr.Execute;
  finally
    scr.Free;
  end;
end;

procedure TfrmPayrollReconciliationReportListGUI.RefreshQuery;
begin
  if cboYear.Text = '' then Exit;
  qryMain.Close;
  CreateTableData;
  inherited;
end;

procedure TfrmPayrollReconciliationReportListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('MonthNumber,Year,GrossWages,GrossTax');
end;

procedure TfrmPayrollReconciliationReportListGUI.grpFiltersClick(
  Sender: TObject);
begin
  inherited;
  RefreshQuery;

end;

procedure TfrmPayrollReconciliationReportListGUI.grdMainDblClick(
  Sender: TObject);
var
  DateStart, DateEnd: TDateTime;
  MonthName: string;
  PayListForm: TPayListingGUI;
begin
  MonthName:= qryMainDateDescription.AsString;
  DateStart:= EncodeDate(StrToInt(Copy(MonthName,Pos(' ',MonthName),char_length(MonthName))),qryMainMonthNumber.AsInteger,1);
  DateEnd:= EndOfTheMonth(DateStart);

  PayListForm:= TPayListingGUI(GetComponentByClassName('TPayListingGUI'));
  if Assigned(PayListForm) then begin
    PayListForm.FormStyle := fsMDIChild;
    PayListForm.BringToFront;
    PayListForm.chkIgnoreDates.Checked:= false;
    PayListForm.dtFrom.Date:= Trunc(DateStart);
    PayListForm.dtTo.Date:= Trunc(DateEnd);
    if grpFilters.ItemIndex = 0 then
      PayListForm.chkUseDatePaid.Checked:= true
    else
      PayListForm.chkUseDatePaid.Checked:= false;
    PayListForm.grpFilters.ItemIndex:= 0;
  end;
end;

procedure TfrmPayrollReconciliationReportListGUI.RefreshTotals;
var
  bm: TBookmark;
  TotalWages,TotalTax,TotalNet,TotalTaxPaid,TotalLeave,TotalSuper,TotalDeductions,
    TotalSundries,TotalAllowances,TotalExpenses: double;
begin
  inherited;
  TotalWages:= 0;
  TotalTax:= 0;
  TotalNet:= 0;
  TotalTaxPaid:= 0;
  TotalLeave:= 0;
  TotalSuper:= 0;
  TotalDeductions:= 0;
  TotalSundries:= 0;
  TotalAllowances:= 0;
  TotalExpenses:= 0;
  bm := qryMain.GetBookmark;
  Try
    qryMain.DisableControls;
    with qryMain do begin
      First;
      while not EOF do begin
          TotalWages := TotalWages + qryMainGrossWages.AsFloat;
          TotalTax := TotalTax + qryMainGrossTax.AsFloat;
          TotalNet := TotalNet + qryMainNetWages.AsFloat;
          TotalTaxPaid := TotalTaxPaid + qryMainTaxPaid.AsFloat;
          TotalLeave := TotalLeave + qryMainLeavePaid.AsFloat;
          TotalSuper := TotalSuper + self.qryMainSuperanuationPaid.AsFloat;
          TotalDeductions := TotalDeductions + self.qryMainDeductionsPaid.AsFloat;
          TotalSundries := TotalSundries + self.qryMainSundryPaid.AsFloat;
          TotalAllowances := TotalAllowances + self.qryMainAllowancesPaid.AsFloat;
          TotalExpenses := TotalExpenses + self.qryMainTotalExpenses.AsFloat;
          next;
      end;
    end;
  Finally
    try
      qryMain.GotoBookmark(bm);
    except
    end;
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('GrossWages').FooterValue := FloatToStrF(TotalWages, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('GrossTax').FooterValue := FloatToStrF(TotalTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('NetWages').FooterValue := FloatToStrF(TotalNet, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TaxPaid').FooterValue := FloatToStrF(TotalTaxPaid, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('LeavePaid').FooterValue := FloatToStrF(TotalLeave, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SuperanuationPaid').FooterValue := FloatToStrF(TotalSuper, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('DeductionsPaid').FooterValue := FloatToStrF(TotalDeductions, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SundryPaid').FooterValue := FloatToStrF(TotalSundries, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('AllowancesPaid').FooterValue := FloatToStrF(TotalAllowances, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalExpenses').FooterValue := FloatToStrF(TotalExpenses, ffCurrency, 15, CurrencyRoundPlaces);
end;

initialization
  RegisterClassOnce(TfrmPayrollReconciliationReportListGUI);

end.
