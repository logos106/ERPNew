unit UtilitiesPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/08/06  1.00.01 DSP  First version.

}

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, Wwdbspin, MemDS, wwdbdatetimepicker, CheckLst, frmBase, DBCtrls, BasePrefs,
  wwclearbuttongroup, wwradiogroup, Menus, AdvEdit, DBAdvEd, Grids, Wwdbigrd,
  Wwdbgrid, AdvScrollBox,FrmStsPreference,FrmVS1Preference,FrmERPUtilsPreferences;

const
  MAXPRINTERBUFFER = 8000;
  MAXPRINTERNAME   = 500;
  MAXPRINTERINFO   = 50;  

type
  TPrinterBuffer = array[0..MAXPRINTERBUFFER - 1] of Char;

  TUtilitiesPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    qryexporttables: TERPQuery;
    dsexporttables: TDataSource;
    DNMPanel2: TDNMPanel;
    Bevel7: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    wwDBEdit1: TwwDBEdit;
    DBMemo1: TDBMemo;
    pnlEnabledModules: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    ModulesCheckList: TCheckListBox;
    DNMPanel3: TDNMPanel;
    Bevel9: TBevel;
    Label2: TLabel;
    Bevel12: TBevel;
    Label11: TLabel;
    wwCheckBox4: TwwCheckBox;
    chkUseAuditTrail: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    chkUseWord: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    cbPostcodeFormatting: TwwCheckBox;
    chkBankAccountFormatting: TwwCheckBox;
    chkshowDashboard: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox10: TwwCheckBox;
    wwRadioGroup1: TwwRadioGroup;
    chkSchedulereportsEnabled: TwwCheckBox;
    chkAusEParcel: TwwCheckBox;
    btnSpelling: TDNMSpeedButton;
    chkBackupAfterUpdateCheck: TwwCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    btnHowto: TDNMSpeedButton;
    wwCheckBox1: TwwCheckBox;
    wwDBGrid1: TwwDBGrid;
    chkGenerateEmployeeno: TwwCheckBox;
    chkShowToDoNotifications: TwwCheckBox;
    DNMPanel6: TDNMPanel;
    Bevel8: TBevel;
    Label12: TLabel;
    chkLogchangingDetailsonServicePadFeedback: TwwCheckBox;
    chkLogchangingDetailsonchequecomments: TwwCheckBox;
    chkLogchangingDetailsonCashsAleComments: TwwCheckBox;
    chkLogchangingDetailsonSupportPricingNotes: TwwCheckBox;
    chkLogchangingDetailsonSupplierfollowupNotes: TwwCheckBox;
    chkLogchangingDetailsonchequeInternalcomments: TwwCheckBox;
    chkLogchangingDetailsonCustPayComments: TwwCheckBox;
    chkLogchangingDetailsonDepositEntryNotes: TwwCheckBox;
    chkLogchangingDetailsonDepositNotes: TwwCheckBox;
    chkLogchangingDetailsonSuppPayNotes: TwwCheckBox;
    chkLogchangingDetailsonCustomerfollowupNotes: TwwCheckBox;
    btnDisableLogchangingDetails: TDNMSpeedButton;
    btnEnableLogchangingDetails: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Bevel11: TBevel;
    Label19: TLabel;
    Label24: TLabel;
    wwCheckBox3: TwwCheckBox;
    wwDBComboBox2: TwwDBComboBox;
    wwCheckBox2: TwwCheckBox;
    pnlDayWeekInfo: TDNMPanel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label8: TLabel;
    lblHours: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    wwDBSpinEdit2: TwwDBSpinEdit;
    pnlAuditTrail: TDNMPanel;
    Bevel10: TBevel;
    Label20: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    chkAutoPurgeAuditTrail: TwwCheckBox;
    edtAuditPurgeMonths: TwwDBEdit;
    DNMPanel4: TDNMPanel;
    Bevel5: TBevel;
    Label26: TLabel;
    Label27: TLabel;
    txtDBPrimaryPrinter: TwwDBComboBox;
    pnlNewDatabaseDefaultData: TDNMPanel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label10: TLabel;
    Label13: TLabel;
    chkCopyDataOnNew: TwwCheckBox;
    chkCopyAccess: TwwCheckBox;
    chkCopyCompany: TwwCheckBox;
    chkCopyEmployee: TwwCheckBox;
    chkCopyProduct: TwwCheckBox;
    chkCopyCOA: TwwCheckBox;
    chkCopyClients: TwwCheckBox;
    chkCopyMarketingContacts: TwwCheckBox;
    pnlPassword: TDNMPanel;
    Bevel13: TBevel;
    Shape1: TShape;
    lblUserPassword: TLabel;
    lblLoginExpireDays: TLabel;
    lblLoginExpireDays2: TLabel;
    lblPassExpireDate: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    lblLoginExpireDayshint: TLabel;
    edtLoginExpireDays: TDBAdvEdit;
    edtPassExpireDate: TwwDBDateTimePicker;
    edtMinPasswordChars: TAdvEdit;
    chkIncludeUppercaseChar: TwwCheckBox;
    chkIncludeLowercaseChar: TwwCheckBox;
    chkIncludeNumber: TwwCheckBox;
    chkIncludeSpecialChar: TwwCheckBox;
    chkCopyOutstandingTxn: TwwCheckBox;
    procedure btnPCCPathSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkCopyDataOnNewClick(Sender: TObject);
    procedure ModulesCheckListClickCheck(Sender: TObject);
    procedure btnSpellingClick(Sender: TObject);
    procedure EnabledisableLogchangeDetails(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure wwDBDateTimePicker1Change(Sender: TObject);
    procedure btnHowtoClick(Sender: TObject);
    procedure edtLoginExpireDaysChange(Sender: TObject);
    procedure edtPassExpireDateChange(Sender: TObject);
    procedure edtMinPasswordCharsChange(Sender: TObject);
    procedure chkIncludeUppercaseCharClick(Sender: TObject);
    procedure chkIncludeLowercaseCharClick(Sender: TObject);
    procedure chkIncludeNumberClick(Sender: TObject);
    procedure chkIncludeSpecialCharClick(Sender: TObject);
    procedure qryexporttablesAfterPost(DataSet: TDataSet);
    procedure OnCopyOptionclick(Sender: TObject);
    procedure chkCopyEmployeeExit(Sender: TObject);
    procedure chkCopyOutstandingTxnClick(Sender: TObject);

  private
    fFormShown: Boolean;
    fPrinterNames: TStringList;
    fRestartRequired: Boolean;
    PerformingFinish: boolean;
    fStsPreference: TFmStsPreference;
    fERPUtilsPreferences: TFmERPUtilsPreferences;
    fVS1Preference: TFmVS1Preference;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure GetPrinterNames;
    function ParseNames(const NameBuffer: TPrinterBuffer; var StartPos: integer): string;
    procedure LoadModulesCheckList;
    procedure SaveModulesCheckList;
    function CopyOptionHint(Sender: TObject; initinghint:Boolean =False):String;
    procedure ShowSts;
    procedure ShowVS1;
    procedure ShowERPUtilconfig;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

{$WARN UNIT_PLATFORM OFF}

uses
  {$WARNINGS OFF}FileCtrl{$WARNINGS ON}, CommonLib,  CommonDbLib,  AppEnvironment, tcTypes, dmMainGUI,
  Vista_MessageDlg, Preferences, tcConst, datSpelling, DNMLib, JsonObject,
  UpdateStoreObj, SystemLib, tcdatautils , DateUtils, DocReaderObj,
  PreferancesLib;

{$R *.dfm}

{ TUtilitiesPrefsGUI }


procedure TUtilitiesPrefsGUI.qryexporttablesAfterPost(DataSet: TDataSet);
begin
  inherited;
  PreferancesLib.DoPrefAuditTrail;
end;


procedure TUtilitiesPrefsGUI.btnHowtoClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Setting up Offsite Backups');
end;

procedure TUtilitiesPrefsGUI.btnPCCPathSelectClick(Sender: TObject);
var
  OpenDlg: TOpenDialog;
begin
  inherited;
  OpenDlg := TOpenDialog.Create(nil);

  try
    if OpenDlg.Execute then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('PCCPathToVisualConsole').AsString := OpenDlg.FileName;
    end;
  finally
    FreeandNil(OpenDlg);
  end;
end;



procedure TUtilitiesPrefsGUI.GetPrinterNames;
var
  Buffer: TPrinterBuffer;
  CurrPos: integer;
  PrinterName: string;
begin
  fPrinterNames := TStringList.Create;

  try
    if GetProfileString(PChar('PrinterPorts'), nil, '', Buffer, MAXPRINTERBUFFER) > 0 then begin;
      CurrPos := 0;

      while True do begin
        PrinterName := ParseNames(Buffer, CurrPos);

        if PrinterName <> '' then begin;
          txtDBPrimaryPrinter.Items.Add(PrinterName);
        end
        else
          Break;
      end;
    end;
  finally
    FreeandNil(fPrinterNames);
  end;
end;

function TUtilitiesPrefsGUI.ParseNames(const NameBuffer: TPrinterBuffer; var StartPos: Integer): string;
var
  i, j, NameLength: integer;
  Str: string;
begin;
  Result := '';

  if (StartPos > High(NameBuffer)) or (NameBuffer[StartPos] = Chr(0)) then
    Exit;

  for i := StartPos to High(NameBuffer) do begin
    if NameBuffer[i] = Chr(0) then begin
      NameLength := i - StartPos;
      Setlength(Str, NameLength);

      for j := 0 to NameLength - 1 do
        Str[j + 1] := NameBuffer[StartPos + j];

      Result := Str;
      StartPos := i + 1;
      Break;
    end;
  end;
end;

procedure TUtilitiesPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fFormShown := False;
  fPrinterNames := nil;
  PerformingFinish:= false;
  lblLoginExpireDayshint.caption := '"Password Never Expires"'+NL+'  on Employee Card '+NL+'  Overrides these '+NL+'  Preferences';
  chkLogchangingDetailsonServicePadFeedback.Caption     := DnMLib.GetFormDescription('TfmPadRepairs')          +' Feedback';
  chkLogchangingDetailsonSupportPricingNotes.Caption    := DnMLib.GetFormDescription('TfrmPhSupportPrintout')  +' Notes';
  chkLogchangingDetailsonSupplierfollowupNotes.Caption  := DnMLib.GetFormDescription('TfmSupplier')           +' Followup Notes';
  chkLogchangingDetailsonchequecomments.Caption         := DnMLib.GetFormDescription('TfmCheque')             +' Comments';
  chkLogchangingDetailsonchequeInternalcomments.Caption := DnMLib.GetFormDescription('TfmCheque')             +' Internal Comments';
  chkLogchangingDetailsonCustPayComments.Caption        := DnMLib.GetFormDescription('TfmCustPayments')        +' Comments';
  chkLogchangingDetailsonDepositEntryNotes.Caption      := DnMLib.GetFormDescription('TDepositEntryGUI')       +' Notes';
  chkLogchangingDetailsonDepositNotes.Caption           := DnMLib.GetFormDescription('TDepositGUI')            +' Notes';
  chkLogchangingDetailsonSuppPayNotes.Caption           := DnMLib.GetFormDescription('TfmSuppPayments')        +' Notes';
  chkLogchangingDetailsonCashsAleComments.Caption       := DnMLib.GetFormDescription('TCashSaleGUI')           +' Comments';
  chkLogchangingDetailsonCustomerfollowupNotes.Caption  := DnMLib.GetFormDescription('TfrmCustomer')           +' Followup Notes';
  ShowSts;
  ShowVS1;
  ShowERPUtilconfig;
  (*  lblLogchangingDetailsonRepairsFeedback.Caption        := GetFormDescription('TRepairsGUI')            +'.Feedback';
  lblLogchangingDetailsonRepairsNotes.Caption           := GetFormDescription('TRepairsGUI')            +'.Notes';
  lblLogchangingDetailsonRepairNotes.Caption            := GetFormDescription('TRepairsGUI')            +'.Notes';
  lblLogchangingDetailsonRepairFeedbackNotes.Caption    := GetFormDescription('TRepairsGUI')            +'.Feedback Notes';  *)
end;
Procedure TUtilitiesPrefsGUI.ShowSts;
begin
  fStsPreference:= TFmStsPreference.Create (self);
  fStsPreference.pnlStSConfig.Parent := sbPanels;
  fStsPreference.pnlStSConfig.taborder:= pnlEnabledModules.taborder+1;
  fStsPreference.pnlStSConfig.Anchors := [akleft,aktop];
  fStsPreference.pnlStSConfig.Left:=0;
  fStsPreference.pnlStSConfig.Height :=  570;
end;
Procedure TUtilitiesPrefsGUI.ShowVS1;
begin
  fVS1Preference:= TFmVS1Preference.Create (self);
  fVS1Preference.pnlVS1config.Parent := sbPanels;
  fVS1Preference.pnlVS1config.taborder:= pnlEnabledModules.taborder+1;
  fVS1Preference.pnlVS1config.Anchors := [akleft,aktop];
  fVS1Preference.pnlVS1config.Left:=0;
  fVS1Preference.pnlVS1config.Height :=  180;
end;
Procedure TUtilitiesPrefsGUI.ShowERPUtilconfig;
begin
  fERPUtilsPreferences:= TFmERPUtilsPreferences.Create (self);
  fERPUtilsPreferences.pnlUtilsconf.Parent := sbPanels;
  fERPUtilsPreferences.pnlUtilsconf.taborder:= pnlEnabledModules.taborder+1;
  fERPUtilsPreferences.pnlUtilsconf.Anchors := [akleft,aktop];
  fERPUtilsPreferences.pnlUtilsconf.Left:=0;
  fERPUtilsPreferences.pnlUtilsconf.Color := Self.color;
  //fERPUtilsPreferences.pnlUtilsconf.Height :=  410;
end;
(*procedure TUtilitiesPrefsGUI.btnRecordingDirClick(Sender: TObject);
var
  sDir: string;
  sRoot: string;
begin
  inherited;
  sRoot := '';
  sDir := '';

  if SelectDirectory('Recording Path', sRoot, sDir) then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('RecordingDirectory').AsString := sDir;
  end;
end;*)

procedure TUtilitiesPrefsGUI.btnSpellingClick(Sender: TObject);
begin
  inherited;
  Spelling.AddictSpell.Setup;
end;

procedure TUtilitiesPrefsGUI.chkCopyDataOnNewClick(Sender: TObject);
begin
  chkCopyEmployee.Enabled := chkCopyDataOnNew.Checked;
  chkCopyCompany.Enabled := chkCopyDataOnNew.Checked;
  chkCopyAccess.Enabled := chkCopyDataOnNew.Checked;
  chkCopyProduct.Enabled := chkCopyDataOnNew.Checked;
  chkCopyCOA.Enabled := chkCopyDataOnNew.Checked;
  chkCopyClients.Enabled := chkCopyDataOnNew.Checked;
  chkCopyMarketingContacts.Enabled := chkCopyDataOnNew.Checked;
  chkCopyOutstandingTxn.Enabled := chkCopyDataOnNew.Checked;
end;


procedure TUtilitiesPrefsGUI.chkCopyEmployeeExit(Sender: TObject);
begin
  inherited;
  TPreferencesGUI(Preferenceform).lblMsg.alignment := taCenter;
  HideTimerMsg;
end;

procedure TUtilitiesPrefsGUI.chkCopyOutstandingTxnClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TUtilitiesPrefsGUI.chkIncludeLowercaseCharClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.PasswordConfig.IncludeLowercaseChar :=  TwwCheckBox(Sender).Checked;
end;

procedure TUtilitiesPrefsGUI.chkIncludeNumberClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.PasswordConfig.IncludeNumber :=  TwwCheckBox(Sender).Checked;
end;

procedure TUtilitiesPrefsGUI.chkIncludeSpecialCharClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.PasswordConfig.IncludeSpecialChar :=  TwwCheckBox(Sender).Checked;
end;

procedure TUtilitiesPrefsGUI.chkIncludeUppercaseCharClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.PasswordConfig.IncludeUppercaseChar :=  TwwCheckBox(Sender).Checked;
end;

procedure TUtilitiesPrefsGUI.DNMSpeedButton1Click(Sender: TObject);
var
  UpdateStore: TUpdateStore;
  ds: TDataSet;
  msg: string;
  path: string;
  Params, Cfg, J: TJsonObject;
  meth: string;
  obj: TJsonObject;
begin
  inherited;
  UpdateStore := TUpdateStore.Create;
  Params := JO;
  Cfg := JO;
  try
    meth := 'ERPModUserUtils';
    if meth <> '' then
      meth := meth + '.';
    meth := meth + 'GetConfig';
    j := AppEnv.UtilsClient.Client.SendRequest(meth,nil);
    if Assigned(j) then begin
      try
        if j.ObjectExists('result') then begin
          Cfg.Assign(j.O['result']);
        end;
      finally
        j.Free;
      end;
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista('Could not read configuration from ERP utilities Service.',mtWarning,[mbOk],0);
      exit;
    end;
    Params.S['OffsiteBackupConfigText'] := Cfg.S['OffsiteBackupConfigText'];
    Params.S['OffsiteRestoreConfigText'] := Cfg.S['OffsiteRestoreConfigText'];
    Params.S['ERPUtilsServer'] := AppEnv.UtilsClient.Client.ServerName;

    path := ExtractFilePath(Application.ExeName);
    if Assigned(owner) and Assigned(Owner.Owner) and (Owner.Owner is TForm) then begin
      Params.I['color'] := TForm(Owner.Owner).Color;
      Params.O['Position'].I['left'] := TForm(Owner.Owner).Left;
      Params.O['Position'].I['top'] := TForm(Owner.Owner).top;
    end;

    Params.SaveToFile(Path + 'OffSiteBackupConfig_Params.txt');
    UpdateStore.Server := AppEnv.UtilsClient.Client.ServerName;
    ds := UpdateStore.VersionUpdates('OffsiteBackupConfig','','');
    TBlobField(ds.FieldByName('File')).SaveToFile(path +'OffsiteBackupConfig.exe');
    ExecNewWinProcess(path +'OffsiteBackupConfig.exe', true, msg);
    if Assigned(owner) and Assigned(Owner.Owner) and (Owner.Owner is TForm) then begin
      TForm(Owner.Owner).BringToFront;
      TForm(Owner.Owner).SetFocus;
    end;

    { read back results when user has closed config form }
    Params.LoadFromFile(Path + 'OffSiteBackupConfig_Params.txt');
    if Params.I['ModalResult'] = mrOk then begin

      Cfg.S['OffsiteBackupConfigText'] := Params.S['OffsiteBackupConfigText'];
      Cfg.S['OffsiteRestoreConfigText'] := Params.S['OffsiteRestoreConfigText'];

      meth := 'ERPModUserUtils';
      if meth <> '' then
        meth := meth + '.';
      meth := meth + 'SetConfig';
      obj:= JO;
      obj.Assign(Cfg);
      j := AppEnv.UtilsClient.Client.SendRequest(meth,obj);
      if Assigned(j) then begin
        try
          if j.Exists('error') then begin
            if j.ObjectExists('error') then
              msg:= j.O['error'].S['message'];
            Vista_MessageDlg.MessageDlgXP_Vista('Could not update configuration on ERP utilities Service '+ msg,mtWarning,[mbOk],0);
          end;
        finally
          j.Free;
        end;
      end;

    end;

  finally
    UpdateStore.Free;
    Params.Free;
    Cfg.Free;
  end;
end;

procedure TUtilitiesPrefsGUI.edtLoginExpireDaysChange(Sender: TObject);
begin
  inherited;
  if not edtLoginExpireDays.Focused then exit;

  if edtLoginExpireDays.IntValue > 0 then begin
    edtPassExpireDate.Clear;
    edtPassExpireDate.DataSource.DataSet.FieldByName(edtPassExpireDate.DataField).AsDateTime := 0;
  end;
end;

procedure TUtilitiesPrefsGUI.edtMinPasswordCharsChange(Sender: TObject);
begin
  inherited;
  if not TAdvEdit(Sender).Focused then exit;
  AppEnv.CompanyPrefs.PasswordConfig.MinimumCharacters := TAdvEdit(Sender).IntValue;
end;

procedure TUtilitiesPrefsGUI.edtPassExpireDateChange(Sender: TObject);
begin
  inherited;
  if not edtPassExpireDate.Focused then exit;


  if edtPassExpireDate.Date > 0 then
    edtLoginExpireDays.IntValue := 0;
end;

procedure TUtilitiesPrefsGUI.EnabledisableLogchangeDetails(Sender: TObject);
begin
  inherited;
  CheckBoxEdit(chkLogchangingDetailsonCashsAleComments      , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonchequecomments        , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonchequeInternalcomments, Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonCustomerfollowupNotes , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonCustPayComments       , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonDepositEntryNotes     , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonDepositNotes          , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonServicePadFeedback    , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonSupplierfollowupNotes , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonSupportPricingNotes   , Sender = btnEnableLogchangingDetails);
  CheckBoxEdit(chkLogchangingDetailsonSuppPayNotes          , Sender = btnEnableLogchangingDetails);
end;

procedure TUtilitiesPrefsGUI.ModulesCheckListClickCheck(Sender: TObject);
begin
  if ModulesCheckList.ItemIndex = ModulesCheckList.Items.IndexOf('Workflow') then begin
    MessageDlgXP_Vista('You cannot disable the workflow', mtWarning, [mbOK], 0);
    ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Workflow')] := True;
    Exit;
  end;
  if (Vista_MessageDlg.MessageDlgXP_Vista('Enabling / Disabling any Modules requires'+#13+#10+
     'Application Restart (Log off / Log on).'+#13+#10+''+#13+#10+
     'Do You Wish To Proceed ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    SaveModulesCheckList;
  end else begin
    LoadModulesCheckList;
  end;
end;

procedure TUtilitiesPrefsGUI.OnCopyOptionclick(Sender: TObject);
begin
  CopyOptionHint(Sender);
end;

Function TUtilitiesPrefsGUI.CopyOptionHint(Sender: TObject; initinghint:Boolean =False):String;
var
  fs:String;
  function CheckBoxCaption(chk:TwwCheckbox):String;
  begin
    Result := trim(chk.Caption);
    if sametext(copy(result,1,4),'copy') then
      result := trim(copy(result,5,length(result)));
  end;
begin
    if not (Sender is TwwCheckbox) then exit;
    if (screen.activecontrol <> TwwCheckbox(sender))  and not(initinghint)  then Exit;
    try
      Result := '';
      fs:= '';
      if  ( (TwwCheckbox(Sender ) = chkCopyOutstandingTxn) and (chkCopyOutstandingTxn.checked OR initinghint )) then begin
        fs := 'Selecting ' +quotedstr(CheckBoxCaption(chkCopyOutstandingTxn))+' will copy the following as well ' +NL+
              ' "Chart Of Accounts" ,'+
              ' "Outstanding Transactions like invoice, purchase order and bill" ,' + NL;
        if chkCopyCOA.checked = False then chkCopyCOA.checked := True;

        if chkCopyClients.checked = False then chkCopyClients.checked := True;
      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyProduct) and  (chkCopyProduct.checked OR initinghint )) then begin
        fs := 'Selecting ' +quotedstr(CheckBoxCaption(chkCopyProduct))+' will copy the following as well ' +NL+
              ' "Product" ,'+
              ' "Chart Of Accounts" ,'+
              ' "'+Appenv.DefaultClass.classheading+'" ,'+
              ' "Taxcodes" ,'+
              ' "UOM" ,'+
              ' "Formula Entries" ,'+
              ' "Attribute Products" ,'+
              ' "Barcodes" ,'+
              ' "BOM Producsts"'+NL;
          if chkCopyCOA.checked = False then chkCopyCOA.checked := True;
      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyAccess) and  (chkCopyAccess.checked OR initinghint )) then begin
        fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyAccess))+' will copy the following as well ' +NL+
              '"Employees"'+NL;
      end;
      if   (TwwCheckbox(Sender ) = chkCopyCOA) and  (not(chkCopyCOA.checked)) then begin
        if chkCopyProduct.checked or chkCopyClients.checked then begin
          fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyClients))+' or ' +quotedstr(CheckBoxCaption(chkCopyProduct))+' will copy  ' +quotedstr(CheckBoxCaption(chkCopyCOA))+' as well ' ;
          chkCopyCOA.checked := True;
        end;
      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyClients) and  (chkCopyClients.checked OR initinghint )) then begin
        fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyClients))+' will copy the following as well ' +NL+
              '"Chart Of Accounts" ,'+
              ' "Employees" ,'+
              ' "Templates" ,'+
              ' "Simple Types" ,'+
              ' "Shipping Address" ,'+
              ' "Payment Methods" ,'+
              ' "Bank Codes" ,'+
              ' "Manufactueres" ,'+
              ' "Shipping Agents" ,'+
              ' "Terms" ,'+
              ' "'+Appenv.DefaultClass.classheading+'" ,'+
              ' "Taxcodes"';
          if chkCopyCOA.checked = False then chkCopyCOA.checked := True;
      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyCompany) and  (chkCopyCompany.checked OR initinghint )) then begin
        fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyCompany))+' will copy the following as well ' +NL+
                ' "Company Information"';

      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyMarketingContacts) and  (chkCopyMarketingContacts.checked OR initinghint )) then begin
        fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyMarketingContacts))+' will copy the following as well ' +NL+
                ' "Employees" ,'+
              ' "Templates" ,'+
              ' "Employees"';
      end;
      if  ( (TwwCheckbox(Sender ) = chkCopyMarketingContacts) and  (chkCopyMarketingContacts.checked OR initinghint )) then begin
        fs := fs+'Selecting ' +quotedstr(CheckBoxCaption(chkCopyMarketingContacts))+' will copy the following as well ' +NL+
              ' "Employees"';
      end;
      if fs<> '' then
        if (sender <> nil) AND (screen.activecontrol = sender) then begin
          ShowTimerMsg(fs);
        end;
    finally
      result := fs;
    end;
end;

procedure TUtilitiesPrefsGUI.LoadModulesCheckList;
begin
//  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Assessment')]          := dsPrefs.DataSet.FieldByName('UseAssessment').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Hire')]                  := dsPrefs.DataSet.FieldByName('UseHire').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Budget')]                := dsPrefs.DataSet.FieldByName('UseBudget').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Google Analytics')]      := dsPrefs.DataSet.FieldByName('UseGoogleAnalytics').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('CRM / Marketing')]       := dsPrefs.DataSet.FieldByName('UseCRM').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Delivery')]              := dsPrefs.DataSet.FieldByName('UseDelivery').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Fixed Assets')]          := dsPrefs.DataSet.FieldByName('UseFixedAssets').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Manufacturing')]         := dsPrefs.DataSet.FieldByName('UseManufacturing').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Workshop')]              := dsPrefs.DataSet.FieldByName('UseWorkShop').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Workflow')]              := dsPrefs.DataSet.FieldByName('UseWorkflow').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('EDI & Integration')]     := dsPrefs.DataSet.FieldByName('ShowEdiIntegration').AsBoolean;

  If ModulesCheckList.Items.IndexOf('Payroll') <> -1 then
    ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Payroll')]             := dsPrefs.DataSet.FieldByName('UsePayroll').AsBoolean;
  ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Price Schemes')]         := dsPrefs.DataSet.FieldByName('UsePriceSchemes').AsBoolean;

end;

procedure TUtilitiesPrefsGUI.SaveModulesCheckList;
begin
  fRestartRequired := True;
  dsPrefs.DataSet.Edit;
//  dsPrefs.DataSet.FieldByName('UseAssessment').AsBoolean    :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Assessment')];
  dsPrefs.DataSet.FieldByName('UseBudget').AsBoolean          :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Budget')];
  dsPrefs.DataSet.FieldByName('UseHire').AsBoolean            :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Hire')];
  dsPrefs.DataSet.FieldByName('UseGoogleAnalytics').AsBoolean :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Google Analytics')];
  dsPrefs.DataSet.FieldByName('UseCRM').AsBoolean             :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('CRM / Marketing')];
  dsPrefs.DataSet.FieldByName('UseDelivery').AsBoolean        :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Delivery')];
  dsPrefs.DataSet.FieldByName('UseFixedAssets').AsBoolean     :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Fixed Assets')];
  dsPrefs.DataSet.FieldByName('UseManufacturing').AsBoolean   :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Manufacturing')];
  If ModulesCheckList.Items.IndexOf('Payroll') <> -1 then
    dsPrefs.DataSet.FieldByName('UsePayroll').AsBoolean       :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Payroll')];
  dsPrefs.DataSet.FieldByName('UsePriceSchemes').AsBoolean    :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Price Schemes')];
  dsPrefs.DataSet.FieldByName('UseWorkShop').AsBoolean        :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Workshop')];
  dsPrefs.DataSet.FieldByName('UseWorkflow').AsBoolean        :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('Workflow')];
  dsPrefs.DataSet.FieldByName('ShowEdiIntegration').AsBoolean :=ModulesCheckList.Checked[ModulesCheckList.Items.IndexOf('EDI & Integration')];
end;

procedure TUtilitiesPrefsGUI.wwDBDateTimePicker1Change(Sender: TObject);
begin
  inherited;
  lblHours.caption := 'Day Duration : ' + FormatSeconds(secondsBetween(wwDBDateTimePicker2.time , wwDBDateTimePicker1.time ));
  lblHours.visible := devmode;
end;
procedure TUtilitiesPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
  Showcontrolhint( chkCopyEmployee,         CopyOptionHint(chkCopyEmployee         ,True ));
  Showcontrolhint( chkCopyCompany,          CopyOptionHint(chkCopyCompany          ,True ));
  Showcontrolhint( chkCopyAccess,           CopyOptionHint(chkCopyAccess           ,True ));
  Showcontrolhint( chkCopyProduct,          CopyOptionHint(chkCopyProduct          ,True ));
  Showcontrolhint( chkCopyCOA,              CopyOptionHint(chkCopyCOA              ,True ));
  Showcontrolhint( chkCopyClients,          CopyOptionHint(chkCopyClients          ,True ));
  Showcontrolhint( chkCopyMarketingContacts,CopyOptionHint(chkCopyMarketingContacts,True ));
end;

procedure TUtilitiesPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  GetPrinterNames;
  closedb(qryexporttables);
  qryexporttables.connection := qryPersonalPreferences.connection;
  opendb(qryexporttables);

  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAuditTrail') <> 1) then begin
    chkUseAuditTrail.Enabled := False;
  end;


  chkCopyEmployee.Enabled := chkCopyDataOnNew.Checked;
  chkCopyCompany.Enabled := chkCopyDataOnNew.Checked;
  chkCopyAccess.Enabled := chkCopyDataOnNew.Checked;
  chkCopyProduct.Enabled := chkCopyDataOnNew.Checked;
  chkCopyCOA.Enabled := chkCopyDataOnNew.Checked;

  LoadModulesCheckList;
  fRestartRequired := False;
  fFormShown := True;
  wwDBDateTimePicker1Change(nil);

  edtMinPasswordChars.IntValue := AppEnv.CompanyPrefs.PasswordConfig.MinimumCharacters;
  chkIncludeUppercaseChar.Checked := AppEnv.CompanyPrefs.PasswordConfig.IncludeUppercaseChar;
  chkIncludeLowercaseChar.Checked := AppEnv.CompanyPrefs.PasswordConfig.IncludeLowercaseChar;
  chkIncludeSpecialChar.Checked := AppEnv.CompanyPrefs.PasswordConfig.IncludeSpecialChar;
  chkIncludeNumber.Checked := AppEnv.CompanyPrefs.PasswordConfig.IncludeNumber;
  fStsPreference.Load;
  fVS1Preference.Load;
  fERPUtilsPreferences.Load;
end;
procedure TUtilitiesPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(msg);
end;
procedure TUtilitiesPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if PerformingFinish then exit;
  PerformingFinish:= true;
  try
    if qryPersonalPreferences.State in [dsEdit, dsInsert] then
      qryPersonalPreferences.Post;
    fFormShown := False;
    If fRestartRequired then Begin
      if owner is TPreferencesGUI then
        TPreferencesGUI(Owner).RestartRequired:= fRestartRequired;
    end;
    AppEnv.CompanyPrefs.PasswordConfig.Save(dsPrefs.Connection);
  finally
    PerformingFinish:= false;
  end;
  PostDB(qryexporttables);
  fStsPreference.Save;
  fVS1Preference.Save;
  fERPUtilsPreferences.Save;
end;
initialization
  RegisterClassOnce(TUtilitiesPrefsGUI);
finalization
  UnRegisterClass(TUtilitiesPrefsGUI);
end.
