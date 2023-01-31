unit PayrollPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/08/06  1.00.01 DSP  First version.

}


interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  MemDS, wwcheckbox, ExtCtrls, DNMPanel, wwdbdatetimepicker, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, DNMSpeedButton, wwdblook, frmBase, BasePrefs, Menus,
  Grids, Wwdbigrd, Wwdbgrid, DBCtrls, AdvScrollBox, Buttons;

type
  TPayrollPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    dsPrefs: TDataSourcePrefs;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    MyConnection: TERPConnection;
    qryAccount: TERPQuery;
    qryPayTaxConfig: TERPQuery;
    dsPayTaxConfig: TDataSource;
    qryPayTaxConfigGlobalRef: TWideStringField;
    qryPayTaxConfigID: TIntegerField;
    qryPayTaxConfigRegionId: TIntegerField;
    qryPayTaxConfigTaxName: TWideStringField;
    qryPayTaxConfigExpenseAccountId: TIntegerField;
    qryPayTaxConfigLiabilityAccountId: TIntegerField;
    qryPayTaxConfigTaxType: TWideStringField;
    qryPayTaxConfigPrimaryTax: TWideStringField;
    qryPayTaxConfigRoundTax: TWideStringField;
    qryPayTaxConfigActive: TWideStringField;
    qryPayTaxConfigmsTimeStamp: TDateTimeField;
    qryPayTaxConfigmsUpdateSiteCode: TWideStringField;
    qryPayTaxConfigExpenseAccount: TStringField;
    qryPayTaxConfigLiabilityAccount: TStringField;
    qryPayTaxConfigAllowanceAmount: TFloatField;
    pnlAccounts: TDNMPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    lblGrossWages: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    lblSuperannuation: TLabel;
    Label23: TLabel;
    Bevel7: TBevel;
    Label32: TLabel;
    Bevel13: TBevel;
    Bevel15: TBevel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwDBLookupCombo5: TwwDBLookupCombo;
    wwDBLookupCombo6: TwwDBLookupCombo;
    wwDBLookupCombo7: TwwDBLookupCombo;
    wwDBLookupCombo8: TwwDBLookupCombo;
    wwDBLookupCombo9: TwwDBLookupCombo;
    wwDBLookupCombo10: TwwDBLookupCombo;
    cboSuperannuationExpense: TwwDBLookupCombo;
    cboSuperannuationLiability: TwwDBLookupCombo;
    wwDBLookupCombo11: TwwDBLookupCombo;
    btnNewPayTax: TDNMSpeedButton;
    pnlTaxAccountActive: TDNMPanel;
    rbActive: TRadioButton;
    rbInactive: TRadioButton;
    rdBoth: TRadioButton;
    TaxList: TScrollBox;
    pnlJobs: TDNMPanel;
    Bevel2: TBevel;
    Label9: TLabel;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    chkDefaultSuperOnTimesheet: TwwCheckBox;
    pnlSuper: TDNMPanel;
    Bevel8: TBevel;
    Label33: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    lblIgnore8: TLabel;
    wwCheckBox18: TwwCheckBox;
    wwCheckBox22: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox26: TDBCheckBox;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit18: TwwDBEdit;
    wwCheckBox19: TwwCheckBox;
    wwCheckBox20: TwwCheckBox;
    wwDBEdit19: TwwDBEdit;
    pnlClearingAccount: TDNMPanel;
    Bevel5: TBevel;
    Label49: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    cboWages: TwwDBLookupCombo;
    pnlExtra: TDNMPanel;
    Label50: TLabel;
    Bevel14: TBevel;
    Label28: TLabel;
    lblIgnore1: TLabel;
    Label29: TLabel;
    lblIgnore2: TLabel;
    Label30: TLabel;
    lblIgnore3: TLabel;
    Label31: TLabel;
    lblIgnore4: TLabel;
    Label36: TLabel;
    lblIgnore5: TLabel;
    Label38: TLabel;
    lblIgnore6: TLabel;
    Label40: TLabel;
    lblIgnore7: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    wwDBEdit12: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    wwDBEdit17: TwwDBEdit;
    wwDBEdit20: TwwDBEdit;
    wwDBEdit21: TwwDBEdit;
    wwDBEdit22: TwwDBEdit;
    chkPaySuperOnLumpSumD: TwwCheckBox;
    pnlGeneral: TDNMPanel;
    Bevel4: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblSickLeaveDays: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtHoursPerWeek: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwCheckBox16: TwwCheckBox;
    wwCheckBox17: TwwCheckBox;
    btnImportTaxScales: TDNMSpeedButton;
    wwCheckBox21: TwwCheckBox;
    Panel1: TPanel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    pnlLoadHoures: TDNMPanel;
    Bevel3: TBevel;
    Label13: TLabel;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    pnlLeaveAccrual: TDNMPanel;
    Bevel1: TBevel;
    Bevel12: TBevel;
    Bevel9: TBevel;
    Bevel11: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    lblLeaveAccrueDuringSick: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Bevel10: TBevel;
    Label22: TLabel;
    wwCheckBox1: TwwCheckBox;
    chkRDOAccrueDuringSick: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    chkLeaveAccrueDuringSick: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    chkShowAccruedSickLeaveLiability: TwwCheckBox;
    wwCheckBox25: TwwCheckBox;
    wwCheckBox27: TwwCheckBox;
    chkShowAccruedSickLeavePaySlip: TwwCheckBox;
    wwCheckBox29: TwwCheckBox;
    pnlSingleTouchPayroll: TDNMPanel;
    Bevel16: TBevel;
    Label3: TLabel;
    Label24: TLabel;
    wwDBEdit23: TwwDBEdit;
    Label37: TLabel;
    Label39: TLabel;
    edtBusinessManagementSystemID: TwwDBEdit;
    btnGEnerateSystemID: TDNMSpeedButton;
    chkOzEDITestMode: TwwCheckBox;
    chkSTPDatesinUTCFormat: TwwCheckBox;
    pnlTaxable: TDNMPanel;
    Label41: TLabel;
    grdTaxable: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    dsTaxable: TDataSource;
    Bevel17: TBevel;
    qryTaxable: TERPQuery;
    qryTaxablePayPeriod: TWideStringField;
    qryTaxableA: TFloatField;
    qryTaxableB: TFloatField;
    qryTaxableC: TFloatField;
    Bevel18: TBevel;
    edtTaxDPercent: TwwDBEdit;
    Label66: TLabel;
    procedure btnImportTaxScalesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryPayTaxConfigBeforeOpen(DataSet: TDataSet);
    procedure grdPayTaxDblClick(Sender: TObject);
    procedure btnNewPayTaxClick(Sender: TObject);
    procedure qryPayTaxConfigAfterOpen(DataSet: TDataSet);
    procedure rbActiveClick(Sender: TObject);
    procedure rbInactiveClick(Sender: TObject);
    procedure rdBothClick(Sender: TObject);
    procedure btnGEnerateSystemIDClick(Sender: TObject);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure qryTaxableAfterPost(DataSet: TDataSet);
  private
    LoadingTaxList: boolean;
    CleanSoftwareInformationBusinessManagementSystemId: string;
    fPreferencesForm: TForm;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure CheckPayrollAccounts;
    procedure LoadTaxList;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib,  CommonDbLib, tcDataUtils, AppEnvironment, frmPayTaxConfigEdit,
  tcTypes, GridFieldsObj, fraPayTaxConfigEdit, PreferenceLib;

{$R *.dfm}

{ TPayrollPrefsGUI }



procedure TPayrollPrefsGUI.qryTaxableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if (qryTaxableA.asFloat = 0) and (qryTaxableB.asFloat = 0) and (qryTaxableC.asFloat = 0) then begin
    qryTaxable.Delete;
  end;
end;

procedure TPayrollPrefsGUI.qryPayTaxConfigAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //
end;

procedure TPayrollPrefsGUI.qryPayTaxConfigBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryPayTaxConfig.ParamByName('RegionId').AsInteger := AppEnv.RegionalOptions.ID;
//  if AppEnv.RegionalOPtions.RegionType = rAust then begin
//    TGridFieldList.RemoveFields(grdPayTax,'AllowanceAmount,TaxType');
//  end;

end;

procedure TPayrollPrefsGUI.rbActiveClick(Sender: TObject);
begin
  inherited;
  LoadTaxList;
end;

procedure TPayrollPrefsGUI.rbInactiveClick(Sender: TObject);
begin
  inherited;
  LoadTaxList;
end;

procedure TPayrollPrefsGUI.rdBothClick(Sender: TObject);
begin
  inherited;
  LoadTaxList;
end;



procedure TPayrollPrefsGUI.btnGEnerateSystemIDClick(Sender: TObject);
var
 Guid: TGUID;
 s: string;
begin
  inherited;
  if CreateGUID(Guid) = 0 then begin
    s := GUIDToString(Guid);
    s := Copy(s,2,Length(s)-2);
    edtBusinessManagementSystemID.Text := s;
    edtBusinessManagementSystemID.DataSource.DataSet.FieldByName(edtBusinessManagementSystemID.DataField).AsString := s;
    CommonLib.MessageDlgXP_Vista('A new System ID has been generated.'+ #13#10 + #13#10 +
      'Please copy this ID and store it in a safe place.',mtInformation,[mbOK],0);
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Generating new System ID Failed',mtWarning,[mbOK],0);
  end;

end;

procedure TPayrollPrefsGUI.btnImportTaxScalesClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmImportTaxScalesGUI');

  if not Assigned(tmpComponent) then
    Exit;

  with TForm(tmpComponent) do begin
    ShowModal;
  end;
end;

procedure TPayrollPrefsGUI.btnNewPayTaxClick(Sender: TObject);
begin
  inherited;
  if frmPayTaxConfigEdit.DoPayTaxConfigEdit(0,TERPConnection(qryPayTaxConfig.Connection)) then begin
    qryPayTaxConfig.Close;
    qryPayTaxConfig.Open;
    LoadTaxList;
  end;
end;

procedure TPayrollPrefsGUI.CheckPayrollAccounts;
begin
  dsPrefs.DataSet.Edit;
  if dsPrefs.DataSet.findfield('RBLThreshold')          <> nil then TFloatField(dsPrefs.DataSet.findfield('RBLThreshold')).currency          := True;
  if dsPrefs.DataSet.findfield('LumpDBaseTaxFree')      <> nil then TFloatField(dsPrefs.DataSet.findfield('LumpDBaseTaxFree')).currency      := True;
  if dsPrefs.DataSet.findfield('LumpDYearlyTaxFree')    <> nil then TFloatField(dsPrefs.DataSet.findfield('LumpDYearlyTaxFree')).currency    := True;
  if dsPrefs.DataSet.findfield('YearlyIncomeThreshold') <> nil then TFloatField(dsPrefs.DataSet.findfield('YearlyIncomeThreshold')).currency := True;
  if dsPrefs.DataSet.findfield('SuperOverGross')        <> nil then TFloatField(dsPrefs.DataSet.findfield('SuperOverGross')).currency        := True;

  if dsPrefs.DataSet.FieldByName('WageAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('WageAccountID').AsInteger := GetAccountID('Payroll Bank');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('DeductionLiabilityAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('DeductionLiabilityAccountID').AsInteger := GetAccountID('Deductions');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('LeaveLiabilityAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('LeaveLiabilityAccountID').AsInteger := GetAccountID('Leave Liability');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SuperPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SuperPaidAccountID').AsInteger := GetAccountID('Super');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SundriesPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SundriesPaidAccountID').AsInteger := GetAccountID('Sundries Paid');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('DeductionsPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('DeductionsPaidAccountID').AsInteger := GetAccountID('Deduction Paid');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SuperPayableAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SuperPayableAccountID').AsInteger := GetAccountID('Superannuation');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('WagesPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('WagesPaidAccountID').AsInteger := GetAccountID('Gross Wages');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('PAYGTaxPayableAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('PAYGTaxPayableAccountID').AsInteger := GetAccountID('PAYG Tax');
    dsPrefs.DataSet.Post;
  end;
end;

procedure TPayrollPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  pnlAccounts.Visible := true;
  if AppEnv.RegionalOptions.RegionType = rAust then begin

  end
  else begin
    pnlExtra.Visible := false;
    pnlSingleTouchPayroll.Visible := false;
  end;
  LoadingTaxList := false;
  lblSickLeaveDays.Caption                := replaceStr(lblSickLeaveDays.Caption                , 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
  lblLeaveAccrueDuringSick.Caption        := replaceStr(lblLeaveAccrueDuringSick.Caption        , 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
  chkRDOAccrueDuringSick.Caption          := replaceStr(chkRDOAccrueDuringSick.Caption          , 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
  chkLeaveAccrueDuringSick.Caption        := replaceStr(chkLeaveAccrueDuringSick.Caption        , 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
  chkShowAccruedSickLeaveLiability.Caption:= replaceStr(chkShowAccruedSickLeaveLiability.Caption, 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
  chkShowAccruedSickLeavePaySlip.Caption  := replaceStr(chkShowAccruedSickLeavePaySlip.Caption  , 'Sick Leave' ,  Appenv.RegionalOptions.SLName );
end;

procedure TPayrollPrefsGUI.grdPayTaxDblClick(Sender: TObject);
begin
  inherited;
  if frmPayTaxConfigEdit.DoPayTaxConfigEdit(TfrPayTaxConfigEdit(Sender).ID,TERPConnection(qryPayTaxConfig.Connection)) then begin
    qryPayTaxConfig.Close;
    qryPayTaxConfig.Open;
    if sender is TfrPayTaxConfigEdit then
      TfrPayTaxConfigEdit(Sender).Load;
  end;
end;

procedure TPayrollPrefsGUI.LoadTaxList;
var
  line: TfrPayTaxConfigEdit;
//  adj: integer;
begin
  if LoadingTaxList then exit;
  LoadingTaxList := true;
  try
    while TaxList.ControlCount > 0 do
      TaxList.Controls[0].Free;
    if not qryPayTaxConfig.Active then
      qryPayTaxConfig.Open;
    qryPayTaxConfig.First;
//    adj:= 0;
    while not qryPayTaxConfig.EOF do begin
      if rbActive.Checked and (not qryPayTaxConfigActive.AsBoolean) then
        qryPayTaxConfig.Next
      else if rbInactive.Checked and qryPayTaxConfigActive.AsBoolean then
        qryPayTaxConfig.Next
      else begin

        line := TfrPayTaxConfigEdit.Create(self);
        line.Name := 'frPayTaxConfigEdit_' + IntToStr(TaxList.ControlCount);
        line.Parent := TaxList;
        line.Left := 0;
        line.Width := TaxList.Width - 18;
        line.OnDblClick := grdPayTaxDblClick;
//        adj := adj + line.Height;
        line.lblTaxName.Left := lblSuperannuation.Left - TaxList.left;
        line.lblInstruct.Left := line.lblTaxName.Left + 10;
        line.lblTaxName.Width := (cboSuperannuationExpense.Left - TaxList.left -5) - line.lblTaxName.Left;
        line.cboExpense.Left:= cboSuperannuationExpense.Left - TaxList.left;
        line.cboExpense.Width:= cboSuperannuationExpense.Width;
        line.cboLiability.Left:= cboSuperannuationLiability.Left - TaxList.left;
        line.cboLiability.Width:= cboSuperannuationLiability.Width;
        line.lblType.Left := line.cboExpense.Left;
        line.cboType.Left := line.lblType.Left + line.lblType.Width + 5;
        line.lblAllowance.Left := line.cboType.Left + line.cboType.Width + 10;
        line.edtAllowanceAmount.Left := line.lblAllowance.Left + line.lblAllowance.Width + 5;
        line.lblRound.Left := line.edtAllowanceAmount.Left + line.edtAllowanceAmount.Width + 10;
        line.chkRound.Left := line.lblRound.Left + line.lblRound.Width + 5;
        line.lblInstruct.Left := line.chkRound.Left + line.chkRound.Width + 10;
        line.Bevel1.Width := self.Width - line.Bevel1.Left - 5;
        line.lblGroup.Left := line.lblTaxName.Left;
        line.cboGroup.Left := line.lblGroup.Left + line.lblGroup.Width + 5;
        line.lblExpense.left := line.cboExpense.Left;
        line.lblLiability.Left := line.cboLiability.Left;
        line.Top := (TaxList.ControlCount -1) * line.Height;
        line.Connection := TERPConnection(qryPayTaxConfig.Connection);
        line.ID := qryPayTaxConfig.FieldByName('ID').AsInteger;
        qryPayTaxConfig.Next;
      end;
    end;
//    adj := adj - TaxList.Height;
//    TaxList.Height := TaxList.Height + adj;
//    btnNewPayTax.Top := btnNewPayTax.Top + adj;
//    pnlAccounts.Height := pnlAccounts.Height + adj;
  finally
    LoadingTaxList := false;
  end;
end;

procedure TPayrollPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TPayrollPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  fPreferencesForm := TForm(FindControl(Msg.WParam));
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  CheckPayrollAccounts;
  qryPayTaxConfig.Connection := qryPersonalPreferences.Connection;

  LoadTaxList;
  btnGEnerateSystemID.Enabled := AppEnv.PayPrefs.SoftwareInformationBusinessManagementSystemId = '';
  CleanSoftwareInformationBusinessManagementSystemId := AppEnv.PayPrefs.SoftwareInformationBusinessManagementSystemId;
end;

procedure TPayrollPrefsGUI.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
// Delete
end;

procedure TPayrollPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;

procedure TPayrollPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryPersonalPreferences.State in [dsEdit, dsInsert] then
    qryPersonalPreferences.Post;

  if qryTaxable.State in [dsEdit, dsInsert] then
    qryTaxable.Post;

  qryTaxable.First;
  while not qryTaxable.EOF do begin
    if (qryTaxableA.asFloat = 0) and (qryTaxableB.asFloat = 0) and (qryTaxableC.asFloat = 0) then begin
      qryTaxable.Delete;
    end;

    qryTaxable.Next;
  end;

  if (CleanSoftwareInformationBusinessManagementSystemId <> '') and
     (CleanSoftwareInformationBusinessManagementSystemId <> dsPrefs.FieldByName('SoftwareInformationBusinessManagementSystemId').ASString) then begin

    if CommonLib.MessageDlgXP_Vista('You have changed the "System ID" in the "Single Touch Payroll" section of Payroll Preferences' + #13#10 + #13#10 +
      'The Australian Tax Office normally requires that this ID remain unchanged for a registerd ABN business, ' +
      'are you sure you want to change it?' + #13#10 + #13#10 + 'Press Yes to continue with the change or No to cancel the change.',mtConfirmation,[mbYes,mbNo],0) = mrNo then begin

      edtBusinessManagementSystemID.Text := CleanSoftwareInformationBusinessManagementSystemId;
      //edtBusinessManagementSystemID.DataSource.DataSet.FieldByName(edtBusinessManagementSystemID.DataField).AsString :=
      dsPrefs.FieldByName('SoftwareInformationBusinessManagementSystemId').ASString :=
        CleanSoftwareInformationBusinessManagementSystemId;

      SendMessage(fPreferencesForm.Handle, TX_CancelFinish, 0, 0);
    end;
  end;
end;

initialization
  RegisterClassOnce(TPayrollPrefsGUI);

  finalization
  UnRegisterClass(TPayrollPrefsGUI);
end.
