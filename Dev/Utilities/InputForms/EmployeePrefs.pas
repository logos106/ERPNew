unit EmployeePrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, wwdblook, wwcheckbox, ExtCtrls,
  DNMPanel, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, MessageConst, MemDS,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, frmBase, BasePrefs, AdvEdit,
  DBAdvEd, Menus, AdvScrollBox, AdvTrackBar, AdvGlowButton, AdvOfficeSelectors,
  Wwdotdot, Wwdbcomb, DBCtrls, ErpTimeCombo, Wwdbspin;

type
  TEmployeePrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryPersonalPreferences: TERPQuery;
    dsPersonalPreferences: TDataSource;
    ColorDialog: TColorDialog;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwCheckBox9: TwwCheckBox;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label9: TLabel;
    wwRadioGroup2: TwwRadioGroup;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    cbAppointments: TwwCheckBox;
    cbCustomer: TwwCheckBox;
    chkFAInsurance: TwwCheckBox;
    chkFAWarranty: TwwCheckBox;
    cbMemTrans: TwwCheckBox;
    cbContact: TwwCheckBox;
    cbQuotes: TwwCheckBox;
    cbOtherContacts: TwwCheckBox;
    chkMrktContacts: TwwCheckBox;
    edAppointmentsAppearDays: TwwDBEdit;
    cbReceivedBO: TwwCheckBox;
    cbToDo: TwwCheckBox;
    cbPendingSOAppearDays: TwwCheckBox;
    edCustomerLoyalty: TwwDBEdit;
    edInsurance: TwwDBEdit;
    edWarranty: TwwDBEdit;
    edMarketingContacts: TwwDBEdit;
    edMemTransAppearDays: TwwDBEdit;
    edOCLoyaltyProgram: TwwDBEdit;
    edOtherContactAppearDays: TwwDBEdit;
    edQuotesAppearDays: TwwDBEdit;
    edtBOAppearDays: TwwDBEdit;
    edToDoAppearDays: TwwDBEdit;
    edPendingSOAppearDays: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    cbLeads: TwwCheckBox;
    edLeadsAppearDays: TwwDBEdit;
    cGoodToReceiveReminderDays: TwwCheckBox;
    edGoodToReceiveReminderDays: TwwDBEdit;
    cbServiceLogAprearDays: TwwCheckBox;
    edServiceLogAprearDays: TwwDBEdit;
    cbEmployeeRenewal: TwwCheckBox;
    edEmployeeskill: TwwDBEdit;
    cbExpenseClaimAppearDays: TwwCheckBox;
    edExpenseClaimAppearDays: TwwDBEdit;
    btnDisableAll: TDNMSpeedButton;
    btnEnableAll: TDNMSpeedButton;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    chkShowReorder: TwwCheckBox;
    chkSupportLogLinesAppearDays: TwwCheckBox;
    edtSupportLogLinesAppearDays: TwwDBEdit;
    DNMPanel5: TDNMPanel;
    Bevel6: TBevel;
    Label16: TLabel;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox12: TwwCheckBox;
    DNMPanel6: TDNMPanel;
    Label17: TLabel;
    wwCheckBox13: TwwCheckBox;
    pnlCyTrackIntegration: TDNMPanel;
    Bevel8: TBevel;
    Label11: TLabel;
    lblCyTRackPort: TLabel;
    chkCyTrackIntegrationEnabled: TwwCheckBox;
    edtCyTrackPort: TDBAdvEdit;
    DNMPanel7: TDNMPanel;
    Bevel10: TBevel;
    Label18: TLabel;
    wwRadioGroup1: TwwRadioGroup;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    Bevel9: TBevel;
    Bevel11: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label19: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    lblexplain: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    chkLoadPOSAtLogon: TwwCheckBox;
    chkPayrollAccess: TwwCheckBox;
    chkShowPreview: TwwCheckBox;
    chkUseClientAccNoOnPayments: TwwCheckBox;
    chkOverrideClassAutoSmartOrders: TwwCheckBox;
    chkEnableClassWarning: TwwCheckBox;
    chkEmailPromptForAttachments: TwwCheckBox;
    btnListSearchColour: TDNMSpeedButton;
    chkShowVideoMenu: TwwCheckBox;
    chkManufacturePartSourceStockconfirm: TwwCheckBox;
    chkOpenTreeFromSalesOrder: TwwCheckBox;
    chkCapacityplannerSelectionOptionBeforeLoad: TwwCheckBox;
    chkShowDeliveryDetailsformonDeldocketprint: TwwCheckBox;
    chkPrintAddressLabelfromDelPrint: TwwCheckBox;
    chkShowSalesProductAutoSelectOptions: TwwCheckBox;
    chkShowManufacutresummarywhenchangedfromSales: TwwCheckBox;
    chkHideMSgonEmployeeCalendar: TwwCheckBox;
    edtMaxDiscount: TwwDBEdit;
    wwCheckBox1: TwwCheckBox;
    chkRunManufacturingUpdateBatch: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwDBEdit4: TwwDBEdit;
    edtMinimumMarginPercentage: TwwDBEdit;
    chkShowRelatedProductSelectioninSale: TwwCheckBox;
    chkGenerateEmployeeno: TwwCheckBox;
    chkShowPrintDialog: TwwCheckBox;
    cbEquipmentServiceAppearDays: TwwCheckBox;
    edEquipmentServiceAppearDays: TwwDBEdit;
    cbERPLicenseRenewalAppearDays: TwwCheckBox;
    edERPLicenseRenewalAppearDays: TwwDBEdit;
    DnmPanel1: TDNMPanel;
    DNMPanel8: TDNMPanel;
    pnlAlternatingRowColor: TPanel;
    chkAlternatingRowColor: TwwCheckBox;
    AlternatingRowColorSelector: TAdvOfficeColorSelector;
    AlternatingRowGradIntensity: TAdvTrackBar;
    pnlERPSingleColor: TPanel;
    chkERPSingleColor: TwwCheckBox;
    ERPSingleColorSelector: TAdvOfficeColorSelector;
    ERPSingleGradIntensity: TAdvTrackBar;
    pnlERPButtonColor: TPanel;
    chkERPButtonColor: TwwCheckBox;


    Bevel12: TBevel;
    Label25: TLabel;
    DNMPanel9: TDNMPanel;
    Label26: TLabel;
    ERPButtonColorSelector: TAdvOfficeColorSelector;
    ERPButtonGradIntensity: TAdvTrackBar;
    pnlERPButtonFontColor: TPanel;
    Label27: TLabel;
    ERPButtonFontColorSelector: TAdvOfficeColorSelector;
    ERPButtonFontGradIntensity: TAdvTrackBar;
    pnlERPButtonHTColor: TPanel;
    Label28: TLabel;
    ERPButtonHTColorSelector: TAdvOfficeColorSelector;
    ERPButtonHTGradIntensity: TAdvTrackBar;
    btnDefault: TDNMSpeedButton;
    btnGreenRestore: TDNMSpeedButton;
    chkShowGrossWeightnQtyCalcMsg: TwwCheckBox;
    chkUseGradBackground: TwwCheckBox;
    chkCalcnshowAvailaibityinCapacityPlanner: TwwCheckBox;
    btnColorPrefs: TDNMSpeedButton;
    pnlDefaultApptSettings: TDNMPanel;
    Label29: TLabel;
    Start_Time_Label: TLabel;
    End_Time_Label: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    txtStartTime: TErpDbTimeCombo;
    txtEndTime: TErpDbTimeCombo;
    cboDefaultApptDuration: TwwDBComboBox;
    cboShowApptDurationin: TwwDBComboBox;
    Bevel7: TBevel;
    Bevel13: TBevel;
    QryProduct: TERPQuery;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label32: TLabel;
    Label33: TLabel;
        chkSunday	: TwwCheckBox;
    chkMonday	: TwwCheckBox;
    chkTuesday	: TwwCheckBox;
    chkWednesday	: TwwCheckBox;
    chkThursday	: TwwCheckBox;
    chkFriday	: TwwCheckBox;
    chkSaturday	: TwwCheckBox;
    Label34: TLabel;
    Bevel14: TBevel;
    cboRoundApptDurationTo: TwwDBComboBox;
    lblRoundApptDurationTo: TLabel;



    procedure CheckBoxClick(Sender: TObject);
    procedure btnListSearchColourClick(Sender: TObject);
    procedure btnSoundClick(Sender: TObject);
    procedure chkCyTrackIntegrationEnabledClick(Sender: TObject);
    procedure edtCyTrackPortChange(Sender: TObject);
    procedure chkManufacturePartSourceStockconfirmClick(Sender: TObject);
    procedure chkCapacityplannerSelectionOptionBeforeLoadClick(Sender: TObject);
    procedure chkOpenTreeFromSalesOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDisableAllClick(Sender: TObject);
    procedure btnEnableAllClick(Sender: TObject);
    procedure qryPersonalPreferencesBeforePost(DataSet: TDataSet);
    procedure AlternatingRowColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure AlternatingRowGradIntensityChange(Sender: TObject);
    procedure ERPSingleGradIntensityChange(Sender: TObject);
    procedure ERPSingleColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure ERPButtonGradIntensityChange(Sender: TObject);
    procedure ERPButtonColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure ERPButtonFontGradIntensityChange(Sender: TObject);
    procedure ERPButtonFontColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure ERPButtonHTGradIntensityChange(Sender: TObject);
    procedure ERPButtonHTColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnGreenRestoreClick(Sender: TObject);
    procedure btnColorPrefsClick(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure SetAppearCheckBoxes; overload;
    procedure SetAppearCheckBoxes(const chk: TwwCheckBox; const edt: TwwDBEdit; const FieldName: string); overload;
    function CheckCyTrackComms: boolean;
    procedure SetcolorComps;
    procedure TobeRestarted;
  Protected
        procedure StartupProcess(var Msg: TMessage); Override;
        procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, CommonDbLib, AppEnvironment,
  FastFuncs,
  {$WARNINGS OFF}
  {$WARNINGS OFF}FileCtrl{$WARNINGS ON},
  {$WARNINGS ON}
  tcTypes, tcConst, CyTrackObj, Preferences , GraphUtil, ColourLib, ERPLib,
  LogLib;

{$R *.dfm}

{ TEmployeePrefsGUI }

procedure TEmployeePrefsGUI.SetcolorComps;
begin
  SetcolorComp(AlternatingRowGradIntensity, AlternatingRowColorSelector , qryPersonalPreferences, 'ColourAlternatingRow', 'GradIntensityAlternatingRow' );
  SetcolorComp(ERPSingleGradIntensity     , ERPSingleColorSelector      , qryPersonalPreferences, 'ColourERPSingle'     , 'GradIntensityERPSingle'      );
  SetcolorComp(ERPButtonGradIntensity     , ERPButtonColorSelector      , qryPersonalPreferences, 'ColourERPButton'     , 'GradIntensityERPButton'      );
  SetcolorComp(ERPButtonFontGradIntensity , ERPButtonFontColorSelector  , qryPersonalPreferences, 'ColourERPButtonFont' , 'GradIntensityERPButtonFont'  );
  SetcolorComp(ERPButtonHTGradIntensity   , ERPButtonHTColorSelector    , qryPersonalPreferences, 'ColourERPButtonHT'   , 'GradIntensityERPButtonHT'    );
end;
procedure TEmployeePrefsGUI.qryPersonalPreferencesBeforePost(DataSet: TDataSet);
begin
  DsBeforePostAuditTrail(DataSet , 'ptemployees');
(*var
  ctr:Integer;
  s1,s2:String;
begin
  inherited;
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      for ctr := 0 to qryPersonalPreferences.fieldcount-1 do begin
        try s1:=qryPersonalPreferences.fields[ctr].OldValue; Except end;
        try s2:= qryPersonalPreferences.fields[ctr].Value; except end;
        if s1 <> s2 then
          TPreferencesGUI(Preferenceform).DoOnchangedDataSave('ptemployees', qryPersonalPreferences.fields[ctr].Fieldname, s1,s2);
      end;*)
end;

procedure TEmployeePrefsGUI.CheckBoxClick(Sender: TObject);
  procedure SetAppearDays(ed: TwwDBEdit);
  begin
    if TwwCheckBox(Sender).Checked then begin
      ed.Visible := True;

      if qryPersonalPreferences.FieldByName(ed.DataField).AsInteger <= 0 then begin
        qryPersonalPreferences.Edit;
        qryPersonalPreferences.FieldByName(ed.DataField).AsInteger := 2;
      end;
    end else begin
      ed.Visible := False;
      qryPersonalPreferences.Edit;
      qryPersonalPreferences.FieldByName(ed.DataField).AsInteger := -999999999;
    end;
  end;
begin
  inherited;
       if Sender = cbAppointments             then SetAppearDays(edAppointmentsAppearDays)
  else if Sender = cbQuotes                   then SetAppearDays(edQuotesAppearDays)
  else if Sender = cbToDo                     then SetAppearDays(edToDoAppearDays)
  else if Sender = cbPendingSOAppearDays      then SetAppearDays(edPendingSOAppearDays)
  else if Sender = cbEquipmentServiceAppearDays      then SetAppearDays(edEquipmentServiceAppearDays)
  else if Sender = cbERPLicenseRenewalAppearDays     then SetAppearDays(edERPLicenseRenewalAppearDays)
  else if Sender = cbOtherContacts            then SetAppearDays(edOtherContactAppearDays)
  else if Sender = cbMemTrans                 then SetAppearDays(edMemTransAppearDays)
  else if Sender = cbCustomer                 then SetAppearDays(edCustomerLoyalty)
  else if Sender = cbContact                  then SetAppearDays(edOCLoyaltyProgram)
  else if Sender = cbEmployeeRenewal          then SetAppearDays(edEmployeeskill)
  else if Sender = chkFAInsurance             then SetAppearDays(edInsurance)
  else if Sender = chkFAWarranty              then SetAppearDays(edWarranty)
  else if Sender = chkMrktContacts            then SetAppearDays(edMarketingContacts)
  else if Sender = cbLeads                    then SetAppearDays(edLeadsAppearDays)
  else if sender = cbServiceLogAprearDays     then SetAppearDays(edServiceLogAprearDays)
  else if Sender = cGoodToReceiveReminderDays then SetAppearDays(edGoodToReceiveReminderDays)
  else if Sender = cbExpenseClaimAppearDays   then SetAppearDays(edExpenseClaimAppearDays)
  else if Sender = chkSupportLogLinesAppearDays then SetAppearDays(edtSupportLogLinesAppearDays)
  else if Sender = cbReceivedBO               then begin
    SetAppearDays(edtBOAppearDays);
    if (screen.activecontrol<> nil) and (cbReceivedBO.checked) and (Sysutils.SameText(screen.activecontrol.name , 'cbReceivedBO')) then
      commonlib.MessageDlgXP_Vista( 'This will only create reminder for received Back Ordered Purchase Orders, ' +
      'where a Sale Order or Invoice is waiting for this product.' , mtInformation , [mbOk] , 0);
  end;
end;

function TEmployeePrefsGUI.CheckCyTrackComms: boolean;
begin
  result:= false;
  if TCyTrack.Inst.CyTrackPort <> edtCyTrackPort.IntValue then begin
    TCyTrack.Inst.Active := false;
    TCyTrack.Inst.CyTrackPort := edtCyTrackPort.IntValue;
  end;
  if chkCyTRackIntegrationEnabled.Checked then begin
    try
      TCyTrack.Inst.Active := true;

      Sleep(1000);
      if not TCyTrack.Inst.Connected then begin
        Commonlib.MessageDlgXP_Vista('No connection from CyTrack detected, please make sure CyDesk is running and it is configured for the same port number.',mtWarning,[mbOk],0);
        result := false;
        chkCyTRackIntegrationEnabled.Checked := false;
        exit;
      end;
      result:= true;
    except
      on e: exception do begin
        if Pos('Address and port are already in use',e.Message) > 0 then
          Commonlib.MessageDlgXP_Vista('Could not enable CyTrack, this Port Number is already being used by another process.',mtWarning,[mbOk],0)
        else
          Commonlib.MessageDlgXP_Vista('Could not enable CyTrack: ' + e.Message,mtWarning,[mbOk],0);
        chkCyTRackIntegrationEnabled.Checked := false;
      end;
    end;
  end
  else begin
    TCyTrack.Inst.Active := false;
    result := true;
  end;
end;

procedure TEmployeePrefsGUI.chkCapacityplannerSelectionOptionBeforeLoadClick(Sender: TObject);
begin
  inherited;
  ShowHintmsg(Screen.activecontrol ,chkCapacityplannerSelectionOptionBeforeLoad);
end;

procedure TEmployeePrefsGUI.chkCyTrackIntegrationEnabledClick(Sender: TObject);
begin
  inherited;
  if chkCyTrackIntegrationEnabled.Focused then
    CheckCyTrackComms;
end;

procedure TEmployeePrefsGUI.chkManufacturePartSourceStockconfirmClick(Sender: TObject);
begin
  inherited;
  ShowHintmsg(Screen.activecontrol ,chkManufacturePartSourceStockconfirm);
end;

procedure TEmployeePrefsGUI.chkOpenTreeFromSalesOrderClick(Sender: TObject);
begin
  inherited;
  ShowHintmsg(Screen.activecontrol ,chkOpenTreeFromSalesOrder);
end;

procedure TEmployeePrefsGUI.btnColorPrefsClick(Sender: TObject);
begin
  TPreferencesGUI(Preferenceform).MainButtonClick(TPreferencesGUI(Preferenceform).FindMainButton(DoTranslate('Colours')));
  // binny: seatchForText gives access vialation / abstract error , leaving it to change page
  (*Try
    TPreferencesGUI(Preferenceform).SearchForText(DoTranslate('Images'), '' , true);
  Except
    on E:Exception do begin
      logtext('Error : -> btnColorPrefsClick'+E.message);
    end;
  End;
  Application.ProcessMessages;
*)
end;

procedure TEmployeePrefsGUI.edtCyTrackPortChange(Sender: TObject);
begin
  inherited;
  if edtCyTrackPort.Focused then
    chkCyTrackIntegrationEnabled.Checked := false;

end;

procedure TEmployeePrefsGUI.FormCreate(Sender: TObject);
Procedure Populatehourscombo(cbo: TwwDBComboBox);
var
  ctr:Integer;
  fd :Double;
begin
  with cbo do begin
    Items.clear;
    for ctr:= 1 to 24 do begin
      fd:=round(ctr/2,1);
      Items.add(FloattostrF(fd, ffGeneral, 15,2)+' Hour(s)'#9+''+inttostr(trunc(fd*60))+'');
    end;
  end;
end;
begin
  inherited;
  lblexplain.caption := (*uppercase('Maximum Percentage Discount ,') + NL +
                        uppercase('Minimum Required Markup ') + ' and ' +NL +
                        uppercase('Minimum Margin Percentage')+NL +
                        *)'These Fields can be Set'+NL+'For the Whole Database '+NL+'on the COMPANY LEVEL'+NL+'in the "Sales" page.';
  btnEnableAll.visible := Devmode;
  btnDisableAll.visible := Devmode;
  Populatehourscombo(cboDefaultApptDuration);
  Populatehourscombo(cboRoundApptDurationTo);
  Populatehourscombo(cboShowApptDurationin);
  //btnGreenRestore.visible := Devmode;
end;

procedure TEmployeePrefsGUI.SetAppearCheckBoxes;
begin
  SetAppearCheckBoxes(cbAppointments            , edAppointmentsAppearDays   , 'APPAppearDays');
  SetAppearCheckBoxes(cbQuotes                  , edQuotesAppearDays         , 'QuoteAppearDays');
  SetAppearCheckBoxes(cbToDo                    , edToDoAppearDays           , 'ToDoAppearDays');
  SetAppearCheckBoxes(cbPendingSOAppearDays     , edPendingSOAppearDays      , 'PendingSOAppearDays');
  SetAppearCheckBoxes(cbEquipmentServiceAppearDays     , edEquipmentServiceAppearDays      , 'EquipmentServiceAppearDays');
  SetAppearCheckBoxes(cbERPLicenseRenewalAppearDays    , edERPLicenseRenewalAppearDays     , 'ERPLicenseRenewalAppearDays');
  SetAppearCheckBoxes(cbOtherContacts           , edOtherContactAppearDays   , 'OthContactAppearDays');
  SetAppearCheckBoxes(cbMemTrans                , edMemTransAppearDays       , 'MemTransAppearDays');
  SetAppearCheckBoxes(cbCustomer                , edCustomerLoyalty          , 'CustomerLoyaltyAppearDays');
  SetAppearCheckBoxes(cbContact                 , edOCLoyaltyProgram         , 'ContactLoyaltyAppearDays');
  SetAppearCheckBoxes(cbEmployeeRenewal         , edEmployeeskill            , 'EmployeeskillRenewalAppearDays');
  SetAppearCheckBoxes(cbReceivedBO              , edtBOAppearDays            , 'ReceivedBOAppearDays');
  SetAppearCheckBoxes(chkFAInsurance            , edInsurance                , 'FixedAssetInsuranceExpiresAppearDays');
  SetAppearCheckBoxes(chkFAWarranty             , edWarranty                 , 'FixedAssetWarrantyExpiresAppearDays');
  SetAppearCheckBoxes(chkMrktContacts           , edMarketingContacts        , 'MarketingContactsAppearDays');
  SetAppearCheckBoxes(cbLeads                   , edLeadsAppearDays          , 'LeadsAppearDays');
  SetAppearCheckBoxes(cbServiceLogAprearDays    , edServiceLogAprearDays     , 'ServiceLogAprearDays');
  SetAppearCheckBoxes(cGoodToReceiveReminderDays, edGoodToReceiveReminderDays, 'GoodToReceiveReminderDays');
end;

procedure TEmployeePrefsGUI.SetAppearCheckBoxes(Const chk: TwwCheckBox; Const edt: TwwDBEdit; Const FieldName: string);
begin
  chk.Checked := (qryPersonalPreferences.FieldByName(FieldName).AsInteger >= 0);

  edt.Visible := chk.Checked;
end;

procedure TEmployeePrefsGUI.btnDisableAllClick(Sender: TObject);
begin
  inherited;
  cbAppointments.checked := False;
  cbCustomer.checked := False;
  chkFAInsurance.checked := False;
  chkFAWarranty.checked := False;
  cbMemTrans.checked := False;
  cbContact.checked := False;
  cbQuotes.checked := False;
  cbOtherContacts.checked := False;
  chkMrktContacts.checked := False;
  cbReceivedBO.checked := False;
  cbToDo.checked := False;
  cbLeads.checked := False;
  cGoodToReceiveReminderDays.checked := False;
  cbServiceLogAprearDays.checked := False;
  cbEmployeeRenewal.checked := False;
  cbExpenseClaimAppearDays.checked := False;
end;

procedure TEmployeePrefsGUI.btnEnableAllClick(Sender: TObject);
begin
  inherited;
  cbAppointments.checked := true;
  cbCustomer.checked := true;
  chkFAInsurance.checked := true;
  chkFAWarranty.checked := true;
  cbMemTrans.checked := true;
  cbContact.checked := true;
  cbQuotes.checked := true;
  cbOtherContacts.checked := true;
  chkMrktContacts.checked := true;
  cbReceivedBO.checked := true;
  cbToDo.checked := true;
  cbLeads.checked := true;
  cGoodToReceiveReminderDays.checked := true;
  cbServiceLogAprearDays.checked := true;
  cbEmployeeRenewal.checked := true;
  cbExpenseClaimAppearDays.checked := true;
end;

procedure TEmployeePrefsGUI.btnListSearchColourClick(Sender: TObject);
var
  TempColor: TColor;
begin
  if AppEnv.Employee.ListSelectionColour = 0 then begin
    TempColor         := $00DFFFFE;
    ColorDialog.Color := $0080FF80;
  end
  else begin
    TempColor         := AppEnv.Employee.ListSelectionColour;
    ColorDialog.Color := AppEnv.Employee.ListSelectionColour;
  end;

  inherited;

  ColorDialog.HelpContext := 85;

  if ColorDialog.Execute then begin
    TempColor := ColorDialog.Color;
  end;

  qryPersonalPreferences.Edit;
  qryPersonalPreferences.FieldByName('ListSelectionColour').AsString := IntToStr(TempColor);
end;

procedure TEmployeePrefsGUI.btnSoundClick(Sender: TObject);
var
  frm: TComponent;
begin
  inherited;
  frm := nil;

  try
    if not FormStillOpen('TfrmSoundScheme') then begin
      frm := GetComponentByClassName('TfrmSoundScheme');

      if not Assigned(frm) then
        Exit;

      with TForm(frm) do begin
        ShowModal;
      end;
    end
    else begin
      frm := GetComponentByClassName('TfrmSoundScheme');
      TForm(frm).Show;
    end;
  finally
    if Assigned(frm) then
      TForm(frm).Release;
  end;
end;

Procedure TEmployeePrefsGUI.TobeRestarted;
begin
    if owner is TPreferencesGUI then
      TPreferencesGUI(Owner).RestartRequired:= TRue;
end;
procedure TEmployeePrefsGUI.AlternatingRowGradIntensityChange(Sender: TObject);
begin
  inherited;
  GradIntensityChange(AlternatingRowGradIntensity ,AlternatingRowColorSelector);
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourAlternatingRow').AsInteger := Integer(AlternatingRowColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityAlternatingRow').AsInteger := AlternatingRowGradIntensity.Position;
  PostDB(qryPersonalPreferences);
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.ERPSingleGradIntensityChange(Sender: TObject);
begin
  inherited;
  GradIntensityChange(ERPSingleGradIntensity ,ERPSingleColorSelector);
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourERPSingle').AsInteger := Integer(ERPSingleColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPSingle').AsInteger := ERPSingleGradIntensity.Position;
  PostDB(qryPersonalPreferences);
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.ERPButtonGradIntensityChange(Sender: TObject);
begin
  inherited;
  GradIntensityChange(ERPButtonGradIntensity ,ERPButtonColorSelector);
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourERPButton').AsInteger := Integer(ERPButtonColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButton').AsInteger := ERPButtonGradIntensity.Position;
  PostDB(qryPersonalPreferences);
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.ERPButtonFontGradIntensityChange(Sender: TObject);
begin
  inherited;
  GradIntensityChange(ERPButtonFontGradIntensity ,ERPButtonFontColorSelector);
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourERPButtonFont').AsInteger := Integer(ERPButtonFontColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButtonFont').AsInteger := ERPButtonFontGradIntensity.Position;
  PostDB(qryPersonalPreferences);
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.ERPButtonHTGradIntensityChange(Sender: TObject);
begin
  inherited;
  GradIntensityChange(ERPButtonHTGradIntensity ,ERPButtonHTColorSelector);
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourERPButtonHT').AsInteger := Integer(ERPButtonHTColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButtonHT').AsInteger := ERPButtonHTGradIntensity.Position;
  PostDB(qryPersonalPreferences);
  TobeRestarted;
end;

procedure TEmployeePrefsGUI.AlternatingRowColorSelectorSelectColor  (Sender: TObject;  AColor: TColor);begin  inherited;  AlternatingRowGradIntensityChange (Sender);end;
procedure TEmployeePrefsGUI.ERPSingleColorSelectorSelectColor       (Sender: TObject;  AColor: TColor);begin  inherited;  ERPSingleGradIntensityChange      (Sender);end;
procedure TEmployeePrefsGUI.ERPButtonColorSelectorSelectColor       (Sender: TObject;  AColor: TColor);begin  inherited;  ERPButtonGradIntensityChange      (Sender);end;
procedure TEmployeePrefsGUI.ERPButtonFontColorSelectorSelectColor   (Sender: TObject;  AColor: TColor);begin  inherited;  ERPButtonFontGradIntensityChange  (Sender);end;
procedure TEmployeePrefsGUI.ERPButtonHTColorSelectorSelectColor     (Sender: TObject;  AColor: TColor);begin  inherited;  ERPButtonHTGradIntensityChange    (Sender);end;
procedure TEmployeePrefsGUI.btnDefaultClick(Sender: TObject);
begin
  inherited;
  EditDB(qryPersonalPreferences);
  qryPersonalPreferences.fieldbyname('UseAlternatingRowColor').asBoolean      := True;
  qryPersonalPreferences.fieldbyname('ColourAlternatingRow').asInteger        := Default_ColourAlternatingRow;
  qryPersonalPreferences.fieldbyname('GradIntensityAlternatingRow').asInteger := 0;

  qryPersonalPreferences.fieldbyname('UseERPSingleColor').asBoolean           := True;
  qryPersonalPreferences.fieldbyname('ColourERPSingle').asInteger             := Default_ColourERPSingle;
  qryPersonalPreferences.fieldbyname('GradIntensityERPSingle').asInteger      := 0;

  qryPersonalPreferences.fieldbyname('UseERPButtonColor').asBoolean           := True;
  qryPersonalPreferences.fieldbyname('ColourERPButton').asInteger             := Default_ColourERPButton;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButton').asInteger      := 0;

  qryPersonalPreferences.fieldbyname('ColourERPButtonFont').asInteger         := Default_ColourERPButtonFont;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButtonFont').asInteger  := 0;

  qryPersonalPreferences.fieldbyname('ColourERPButtonHT').asInteger           := Default_ColourERPButtonHT;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButtonHT').asInteger    := 0;
  PostDB(qryPersonalPreferences);
  SetcolorComps;
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.btnGreenRestoreClick(Sender: TObject);
begin
  inherited;
  EditDB(qryPersonalPreferences);
  qryPersonalPreferences.fieldbyname('UseAlternatingRowColor').asBoolean      := True;
  qryPersonalPreferences.fieldbyname('ColourAlternatingRow').asInteger        := Default_ColourAlternatingRowGreen;
  qryPersonalPreferences.fieldbyname('GradIntensityAlternatingRow').asInteger := 0;

  qryPersonalPreferences.fieldbyname('UseERPSingleColor').asBoolean           := True;
  qryPersonalPreferences.fieldbyname('ColourERPSingle').asInteger             := Default_ColourERPSingleGreen;
  qryPersonalPreferences.fieldbyname('GradIntensityERPSingle').asInteger      := 0;

  qryPersonalPreferences.fieldbyname('UseERPButtonColor').asBoolean           := True;
  qryPersonalPreferences.fieldbyname('ColourERPButton').asInteger             := Default_ColourERPButtonGreen;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButton').asInteger      := 0;

  qryPersonalPreferences.fieldbyname('ColourERPButtonFont').asInteger         := Default_ColourERPButtonFontGreen;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButtonFont').asInteger  := 0;

  qryPersonalPreferences.fieldbyname('ColourERPButtonHT').asInteger           := Default_ColourERPButtonHTGreen;
  qryPersonalPreferences.fieldbyname('GradIntensityERPButtonHT').asInteger    := 0;
  PostDB(qryPersonalPreferences);
  SetcolorComps;
  TobeRestarted;
end;
procedure TEmployeePrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TEmployeePrefsGUI.StartupProcess(var Msg: TMessage);
var
  x: integer;
begin
  inherited;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  SetAppearCheckBoxes;
  ShowcontrolHint(chkCapacityplannerSelectionOptionBeforeLoad , 'When checked' +NL +char(VK_TAB)+'Will provide an option to select to filter the data for  ''Capacity planner'' and ''Capacity Planning (Gantt Chart)''.' +NL +
                                                                                    char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Manufacture'' Page.'+NL);

  ShowcontrolHint(chkOpenTreeFromSalesOrder , 'When checked' +NL +char(VK_TAB)+'Adding a Manufature Product to Sales order will Load and open the tree.' +NL +
                                                                  char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Manufacture'' Page.'+NL);

  ShowcontrolHint(chkShowDeliveryDetailsformonDeldocketprint , 'When checked' +NL +char(VK_TAB)+'Printing an ''Invoice'' will have an option to enter the delivery details.' +NL +
                                                                                   char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Sales'' Page.'+NL);

  ShowcontrolHint(chkPrintAddressLabelfromDelPrint , 'When checked' +NL +char(VK_TAB)+'Printing a ''Delivery docket'' from ''Delivery Docket Audit'' will print the address labels if the ''no of Boxes'' are specified.' +NL +
                                                                                   char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Sales'' Page.'+NL);

  ShowcontrolHint(chkShowSalesProductAutoSelectOptions , 'When checked' +NL +char(VK_TAB)+'Selecting a Customer in the Quote / Invoice / Sales Order will popup an option to choose multiple products from the customer''s history.' +NL +
                                                                                   char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Sales'' Page.'+NL);

  ShowcontrolHint(chkShowManufacutresummarywhenchangedfromSales , 'When checked' +NL +char(VK_TAB)+'Assigning a value for ''Shipped'' Quantity for a ''Manufacturing Product'' in Sales Order will open a summary report of the allocation. ie: total Quantity , Qty to be taken form stock, Manufacturing Qty and Ordering Quantity.' +NL +
                                                                                     char(VK_TAB)+'The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);

  ShowcontrolHint(chkHideMSgonEmployeeCalendar , 'When checked' +NL +char(VK_TAB)+'''Service Pad'' will not show the hint that '+NL +
                                                                       char(VK_TAB)+'''It will ONLY show the ''Repairs'' appointments of you (Employee :' +Appenv.Employee.EmployeeName+')'+NL);


  ShowcontrolHint(chkManufacturePartSourceStockconfirm , 'When checked' +NL +char(VK_TAB)+'Adding a Manufature Product to Sales order will Confirm the product Source.' +NL +
                                                                    char(VK_TAB)+'This Option is applicable only when the company level preference is selected on the ''Manufacture'' Page.'+NL);

  ShowcontrolHint(chkShowRelatedProductSelectioninSale , 'When checked' +NL +'        Selecting a new Product in Sales will open Related Product List if the selected product has any Related Products.' +NL +
                                                                                     '        The Sales Preference will let you Disable this feature for All Employee.'+NL);
  SetcolorComps;

  pnlCyTrackIntegration.Enabled := AppEnv.CompanyPrefs.CyTrackIntegrationEnabled;
  for x := 0 to pnlCyTrackIntegration.ControlCount -1 do
    pnlCyTrackIntegration.Controls[x].Enabled := pnlCyTrackIntegration.Enabled;

  //edtMaxDiscount.Text := FloatToStrF(qryPersonalPreferences.FieldByName('MaxDiscountPercentage').AsFloat * 100, ffFixed, 7, 2) + ' %';

  ERPSingleGradIntensity.visible := devmode;
  ERPSingleColorSelector.visible := devmode;
  cbERPLicenseRenewalAppearDays.visible :=  IsERPCustomEnabled
                                        and TableExists('Services.tclientconfig')
                                        and TableExists('Services.tcomputer')
                                        and TableExists('Services.tsoftwarelicence');

  edERPLicenseRenewalAppearDays.visible := cbERPLicenseRenewalAppearDays.visible and cbERPLicenseRenewalAppearDays.checked;

  if devmode then chkERPSingleColor.caption := 'Use Single Base Color for All ERP Forms' else chkERPSingleColor.caption := 'Use White Base Color for All ERP Forms';
  btnColorPrefs.Enabled:= not(TPreferencesGUI(Preferenceform).SinglePanelMode);
end;
procedure TEmployeePrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TEmployeePrefsGUI.FinishProcess(var Msg: TMessage);
begin
  Editdb(qryPersonalPreferences);
  qryPersonalPreferences.FieldByName('ColourAlternatingRow').AsInteger := Integer(AlternatingRowColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityAlternatingRow').AsInteger := AlternatingRowGradIntensity.Position;
  qryPersonalPreferences.FieldByName('ColourERPSingle').AsInteger := Integer(ERPSingleColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPSingle').AsInteger := ERPSingleGradIntensity.Position;
  qryPersonalPreferences.FieldByName('ColourERPButton').AsInteger := Integer(ERPButtonColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButton').AsInteger := ERPButtonGradIntensity.Position;
  qryPersonalPreferences.FieldByName('ColourERPButtonFont').AsInteger := Integer(ERPButtonFontColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButtonFont').AsInteger := ERPButtonFontGradIntensity.Position;
  qryPersonalPreferences.FieldByName('ColourERPButtonHT').AsInteger := Integer(ERPButtonHTColorSelector.SelectedColor);
  qryPersonalPreferences.FieldByName('GradIntensityERPButtonHT').AsInteger := ERPButtonHTGradIntensity.Position;
  PostDB(qryPersonalPreferences);
end;

initialization
  RegisterClassOnce(TEmployeePrefsGUI);
finalization
  UnRegisterClass(TEmployeePrefsGUI);
end.
