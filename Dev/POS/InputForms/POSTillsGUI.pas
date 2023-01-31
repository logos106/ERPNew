unit POSTillsGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls,
  DNMPanel, DB, MyAccess,ERPdbComponents,  wwcheckbox, wwdbedit, Wwdotdot, Wwdbcomb,
  wwdblook, Grids, DBGrids, MemDS, DBAccess, Shader, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, ImgList, ProgressDialog;

type
  TPOSTillsPopUp = class(TBaseInputGUI)
    grdTills: TDBGrid;
    dsTills: TDataSource;
    qryTills: TERPQuery;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dsPadsX: TDataSource;
    qryPads: TERPQuery;
    Label3: TLabel;
    Bevel1: TBevel;
    pnlPrinter: TDNMPanel;
    qryTillsTillID: TSmallintField;
    qryTillsTillName: TWideStringField;
    qryTillsPrimaryPadID: TWordField;
    qryTillsUseDefaultPrinter: TWideStringField;
    qryTillsReceiptPrinterOn: TWideStringField;
    qryTillsReceiptPrinterPort: TWideStringField;
    qryTillsReceiptPrinterType: TWideStringField;
    qryTillsActive: TWideStringField;
    qryTillsEditedFlag: TWideStringField;
    Label6: TLabel;
    qryTillsComputerName: TWideStringField;
    qryTillsUseCashDrawerOnly: TWideStringField;
    qryTillsIsPrintSpooler: TWideStringField;
    qryTillsRemoteTillID: TSmallintField;
    qryTillsLookup: TERPQuery;
    qryTillsUsePrintSpooler: TWideStringField;
    pnlSpooler: TDNMPanel;
    Label12: TLabel;
    chkUseSpooler: TwwCheckBox;
    pnlPrintConfig: TDNMPanel;
    Label155: TLabel;
    grpPrnPorts: TDBRadioGroup;
    cboPrinterType: TwwDBComboBox;
    pnlSpoolerTill: TDNMPanel;
    Label9: TLabel;
    cboSpooler: TwwDBLookupCombo;
    qryTillsUseLocalDrawer: TWideStringField;
    cboClassQry: TERPQuery;
    qryTillsClassID: TIntegerField;
    Label14: TLabel;
    wwCheckBox1: TwwCheckBox;
    qryTillsEnableKickRemoteDrawer: TWideStringField;
    qryTillsPOSPrintReceiptOnlyOnCompleteSale: TWideStringField;
    qryTillsPOSPrintDescriptionMultipleLines: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    Label5: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    chkUseDefault: TwwCheckBox;
    chkUsePrn: TwwCheckBox;
    chkIsSpooler: TwwCheckBox;
    chkPOSPrintReceiptOnCompleteSale: TwwCheckBox;
    chkPOSPrintMultipleLines: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    DBCheckBox2: TDBCheckBox;
    edtTitle: TDBEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    qryTillscompany: TWideStringField;
    qryTillsAddress1: TWideStringField;
    qryTillsAddress2: TWideStringField;
    qryTillsState: TWideStringField;
    qryTillsPostCode: TWideStringField;
    DNMPanel5: TDNMPanel;
    Label1: TLabel;
    DBEdit9: TDBEdit;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    Label17: TLabel;
    DBEdit1: TDBEdit;
    Label19: TLabel;
    DBEdit2: TDBEdit;
    Label20: TLabel;
    DBEdit3: TDBEdit;
    lblState: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label22: TLabel;
    lblSuburb: TLabel;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    DBEdit7: TDBEdit;
    Label23: TLabel;
    DBEdit8: TDBEdit;
    qryTillscity: TWideStringField;
    qryTillsphonenumber: TWideStringField;
    qryTillsfaxnumber: TWideStringField;
    Label10: TLabel;
    Bevel14: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    lblUSBPrinter: TLabel;
    qryTillsUSBPrinterName: TWideStringField;
    cboUSBPrinter: TDBComboBox;
    qryTillsUsePoledisplay: TWideStringField;
    qryTillsPolePort: TWideStringField;
    chkUseLocalCashDrawer: TwwCheckBox;
    Label13: TLabel;
    Bevel3: TBevel;
    chkCashDrawerOnly: TwwCheckBox;
    Label8: TLabel;
    Bevel4: TBevel;
    DNMPanel6: TDNMPanel;
    Label21: TLabel;
    wwCheckBox3: TwwCheckBox;
    cboScales: TDBComboBox;
    Label29: TLabel;
    wwCheckBox4: TwwCheckBox;
    Label30: TLabel;
    cboscanners: TDBComboBox;
    Label32: TLabel;
    lblScannerDevice: TLabel;
    qryTillsUseScale: TWideStringField;
    qryTillsUseScanner: TWideStringField;
    qryTillsScaleDeviceName: TWideStringField;
    qryTillsScannerDeviceName: TWideStringField;
    Bevel5: TBevel;
    Bevel6: TBevel;
    btnscaleDetails: TDNMSpeedButton;
    btnScannerDetails: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    lblpolePort: TLabel;
    Label28: TLabel;
    wwCheckBox2: TwwCheckBox;
    cbopolePort: TDBComboBox;
    DBComboBox1: TDBComboBox;
    qryTillsPoleDisplayName: TWideStringField;
    qryPOSTemplates: TERPQuery;
    qryTillsDefaultTemplateID: TIntegerField;
    Label31: TLabel;
    cboInvoiceTemplate: TwwDBLookupCombo;
    qryPOSTemplatesTemplID: TIntegerField;
    qryPOSTemplatesTemplName: TWideStringField;
    QryCashSaleTemplates: TERPQuery;
    WideStringField1: TWideStringField;
    IntegerField1: TIntegerField;
    Label33: TLabel;
    cboa4Template: TwwDBLookupCombo;
    qryTillsDefaultA4TemplateID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qryTillsUseDefaultPrinterChange(Sender: TField);
    procedure chkUseDefaultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAssignClick(Sender: TObject);
    procedure btnUnassignClick(Sender: TObject);
    procedure chkUsePrnClick(Sender: TObject);
    procedure chkUseSpoolerClick(Sender: TObject);
    procedure chkUseLocalCashDrawerClick(Sender: TObject);
    procedure chkIsSpoolerClick(Sender: TObject);
    procedure qryTillsBeforeScroll(DataSet: TDataSet);
    procedure qryTillsAfterScroll(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSetupCustomerDisplayClick(Sender: TObject);
    procedure qryTillsBeforePost(DataSet: TDataSet);
    procedure chkPOSPrintReceiptOnCompleteSaleClick(Sender: TObject);
    procedure chkPOSPrintMultipleLinesClick(Sender: TObject);
    procedure cboUSBPrinterDropDown(Sender: TObject);
    procedure cboPrinterTypeChange(Sender: TObject);
    procedure cbopolePortDropDown(Sender: TObject);
    procedure wwCheckBox2Click(Sender: TObject);
    procedure btnscaleDetailsClick(Sender: TObject);
    procedure btnScannerDetailsClick(Sender: TObject);
  private
    { Private declarations }
    bOrigValOfIsSpool: boolean;
    bVerbose: boolean;
    Procedure Printersetting;
    Procedure PopulateScales;
    Procedure PopulateScanners;
    procedure PopulateFromRegistry(Keyname: string; cbo: TDBComboBox);
    Procedure RegEdit(Keyname:String);
    procedure OpenQryWithSharedconnection(Qry: TERPQuery);
  Protected
    procedure EnableDisable;Override;
    procedure DoFormSize(ChangeSize: Boolean);Override;
  public
    constructor Create(AOwner:TComponent); override;
  end;


implementation

{$R *.dfm}
uses
   Forms, DNMLib, CommonDbLib,  POSSetupCustomerDisplayGUI,
   CommonLib, AppEnvironment, Printers, tcConst, RegEdit, frmRegEdit;

procedure TPOSTillsPopUp.FormCreate(Sender: TObject);
(*var
  ctr:Integer;*)
begin
  fbIgnoreAccessLevels := true;
  inherited;
  bVerbose := false;
  cboUSBPrinter.Items.Clear;
  (*cboUSBPrinter.Items.CommaText :=   Printer.Printers.CommaText;*)
  PopulatePrintertypes(cboPrinterType);
  PopulateScales;
  PopulateScanners;
  cboInvoiceTemplate.Hint := 'This template is used from ' +NL +
                             '    -> The POS when ''F4 Print'' Selected from the Top Panel' +NL+
                             '    -> A4 Receipt printed when POS transaction completed' +NL;
  cboInvoiceTemplate.showhint := True;
  cboa4Template.Hint := 'This template is used from ' +NL +
                             '    -> ''Print A4'' in POS' +NL+
                             '    -> On Completion of a Sale in POS when Company preference ''Print to the A4 Printer When Sale is Completed'' turned on' +NL;
  cboa4Template.showhint := True;
end;
procedure TPOSTillsPopUp.DoFormSize(ChangeSize: Boolean);
begin
  //inherited;
  Self.WindowState := wsNormal;
  SizeMode := 'N';
end;


procedure TPOSTillsPopUp.btnSaveClick(Sender: TObject);
var
  mrResult: integer;
begin
  inherited;
  bVerbose := false;
  if qryTills.State <> dsBrowse then begin
    if not AppEnv.CompanyPrefs.MultiTills then begin
      mrResult := CommonLib.MessageDlgXP_Vista('Changes made here will not take affect unless the ' + #13 + #10 +
        '"Multiple Tills" preference is enabled.' + #13 + #10 + 'Do you wish to enable this Preference now?',
        mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      if mrResult = mrCancel then begin
        Exit;
      end else if mrResult = mrYes then begin
        AppEnv.CompanyPrefs.MultiTills := true;
      end;
    end;
    if bOrigValOfIsSpool <> chkIsSpooler.Checked then begin
      if chkIsSpooler.Checked then begin
        CommonLib.MessageDlgXP_Vista('Restart ERP to Enable Print Spooling', mtInformation, [mbOK], 0);
      end else begin
        CommonLib.MessageDlgXP_Vista('Restart ERP to Disable Print Spooling', mtInformation, [mbOK], 0);
      end
    end else begin
      CommonLib.MessageDlgXP_Vista('These changes will take effect the next time you start POS',
        mtInformation, [mbOK], 0);
    end;
    qryTills.Post;
  end;
end;

procedure TPOSTillsPopUp.btnscaleDetailsClick(Sender: TObject);
begin
  inherited;
  regEdit('SCALE\'+cboScales.text);
end;

procedure TPOSTillsPopUp.qryTillsUseDefaultPrinterChange(Sender: TField);
begin
  inherited;
  chkUseDefaultClick(Sender);
  EnableDisable;
end;

procedure TPOSTillsPopUp.RegEdit(Keyname: String);
var
  form:TComponent;
begin
  form := GetComponentByClassName('TfmRegEdit');
  if not(assigned(form)) then exit;
  TfmRegEdit(Form).Regname:= KeyName;
  TfmRegEdit(Form).Showmodal;
end;

procedure TPOSTillsPopUp.chkUseDefaultClick(Sender: TObject);
begin
  inherited;
  if (chkUseDefault.Checked and bVerbose) then begin
    CommonLib.MessageDlgXP_Vista('The Printer Properties for the selected Till are now Set to ' + #13 + #10 +
      'the Default settings defined in the POS Tab of the Preferences Display.', mtConfirmation, [mbOK], 0);
  end;
  EnableDisable;
end;
procedure TPOSTillsPopUp.OpenQryWithSharedconnection(Qry :TERPQuery);
begin
  Closedb(Qry);
  Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  Opendb(Qry);
end;
procedure TPOSTillsPopUp.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    OpenQryWithSharedconnection(qryTills);
    qryTills.Edit;
    bVerbose := false;  // might get set by after-scroll event
    OpenQryWithSharedconnection(qryPads);
    OpenQryWithSharedconnection(qryTillsLookup);
    OpenQryWithSharedconnection(cboClassQry);
    OpenQryWithSharedconnection(qryPOSTemplates);
    OpenQryWithSharedconnection(QryCashSaleTemplates);
    chkUseDefaultClick(Sender);
    bOrigValOfIsSpool := chkIsSpooler.Checked;
    bVerbose := true;
    EnableDisable;
    grpPrnPorts.Color := Self.Color;
  finally
    EnableForm;
  end;  
end;

procedure TPOSTillsPopUp.btnAssignClick(Sender: TObject);
begin
  inherited;
  qryTills.Edit;
  qryTills.FieldByName('ComputerName').AsString := GetPCName;
end;

procedure TPOSTillsPopUp.btnUnassignClick(Sender: TObject);
begin
  inherited;
  qryTills.Edit;
  qryTills.FieldByName('ComputerName').AsString := '';
end;

procedure TPOSTillsPopUp.chkUsePrnClick(Sender: TObject);
begin
  inherited;
  if not chkUsePrn.Checked and bVerbose then begin
    CommonLib.MessageDlgXP_Vista('All Printing will be Disabled for the Selected Till', mtConfirmation, [mbOK], 0);
  end;
  EnableDisable;
end;

procedure TPOSTillsPopUp.chkUseSpoolerClick(Sender: TObject);
begin
  inherited;
  if chkUseSpooler.Checked and bVerbose then begin
    CommonLib.MessageDlgXP_Vista('The selected Till will now use a Print Spooler for Printing Receipts'#10#13 +
      'Please Select a Till to Print to.', mtConfirmation, [mbOK], 0);
  end;
  EnableDisable;
end;

procedure TPOSTillsPopUp.chkUseLocalCashDrawerClick(Sender: TObject);
begin
  inherited;
  EnableDisable;
end;

procedure TPOSTillsPopUp.chkIsSpoolerClick(Sender: TObject);
begin
  inherited;
  if chkIsSpooler.Checked and bVerbose then begin
    CommonLib.MessageDlgXP_Vista('The selected Till has been made a Print Spooler, ' + #10#13 +
      'it is now Capable of Printing Receipts from other Tills',
      mtConfirmation, [mbOK], 0);
  end;
  EnableDisable;
end;

procedure TPOSTillsPopUp.EnableDisable;
begin
  chkUseDefault.Enabled := chkUsePrn.Checked;
  chkIsSpooler.Enabled := chkUsePrn.Checked;

  EnablePanel(pnlSpooler, chkUsePrn.Checked);
  if pnlSpooler.Enabled then begin
    EnablePanel(pnlSpooler, not (chkUseDefault.Checked or chkIsSpooler.Checked));
  end;
  if pnlSpooler.Enabled then begin
    EnablePanel(pnlSpoolerTill, chkUseSpooler.Checked);
  end;

  EnablePanel(pnlPrintConfig, chkUsePrn.Checked);
  if pnlPrintConfig.Enabled then begin
    EnablePanel(pnlPrintConfig, not chkUseDefault.Checked);
  end;
  if chkUseLocalCashDrawer.Enabled and chkUseLocalCashDrawer.Checked then begin
    EnablePanel(pnlPrintConfig, true);
  end;
  if pnlPrintConfig.Enabled and chkUseSpooler.Checked and not chkUseLocalCashDrawer.Checked then begin
    EnablePanel(pnlPrintConfig, false);
  end;

  cbopolePort.enabled := qryTillsUsePoledisplay.asBoolean;
  lblpolePort.enabled := qryTillsUsePoledisplay.asBoolean;
end;

procedure TPOSTillsPopUp.qryTillsBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  bVerbose := false;
end;

procedure TPOSTillsPopUp.qryTillsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  bVerbose := true;
end;

procedure TPOSTillsPopUp.btnCancelClick(Sender: TObject);
begin
  inherited;
  bVerbose := false;
end;

procedure TPOSTillsPopUp.btnScannerDetailsClick(Sender: TObject);
begin
  inherited;
  RegEdit('SCANNER\'+cboscanners.text);
end;

procedure TPOSTillsPopUp.btnSetupCustomerDisplayClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TSetupCustomerDisplayGUI');
  If not Assigned(tmpComponent) then Exit;
  with TSetupCustomerDisplayGUI(tmpComponent) do begin
    KeyID := qryTillsTillID.AsInteger;
    ShowModal;
  end;
end;

procedure TPOSTillsPopUp.qryTillsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryTills.FieldByName('TillID').AsInteger = 1) and (qryTills.FieldByName('Active').AsString = 'F') then begin
    qryTills.Edit;
    qryTills.FieldByName('Active').AsString := 'T';
  end;
end;

procedure TPOSTillsPopUp.chkPOSPrintReceiptOnCompleteSaleClick(
  Sender: TObject);
begin
  inherited;
  if not chkPOSPrintReceiptOnCompleteSale.Checked and bVerbose then begin
    if AppEnv.CompanyPrefs.UsePCC then begin
      chkPOSPrintReceiptOnCompleteSale.Checked := true;
      CommonLib.MessageDlgXP_Vista('This Option Cannot Be Turned Off If Using PCC (Preferences -> Utilities Tab)!', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPOSTillsPopUp.chkPOSPrintMultipleLinesClick(Sender: TObject);
begin
  inherited;
  if not chkPOSPrintMultipleLines.Checked and bVerbose then begin
    if AppEnv.CompanyPrefs.UsePCC then begin
      chkPOSPrintMultipleLines.Checked := true;
      CommonLib.MessageDlgXP_Vista('This Option Cannot Be Turned Off If Using PCC (Preferences -> Utilities Tab)!', mtWarning, [mbOK], 0);
    end;
  end;
end;

constructor TPOSTillsPopUp.create(AOwner: TComponent);
var
  ctr: Integer;
begin
  inherited create(AOwner);
  for ctr := 0 to Printer.Printers.Count-1 do
    cboUSBPrinter.Items.Add(Printer.Printers[ctr]);
end;

procedure TPOSTillsPopUp.cboUSBPrinterDropDown(Sender: TObject);
begin
  inherited;
  EditDB(qryTills);
end;

procedure TPOSTillsPopUp.PopulateScales;
begin
  PopulateFromRegistry(OPOSRegPath+'SCALE',cboScales);
end;
procedure TPOSTillsPopUp.PopulateScanners;
begin
  PopulateFromRegistry(OPOSRegPath+'SCANNER',cboscanners);
end;

procedure TPOSTillsPopUp.PopulateFromRegistry(Keyname:string;cbo :TDBComboBox);
var
  i:Integer;
  fRegEdit:TRegEdit;
  RegEntries: TList;
begin
  inherited;
  fRegEdit:=TRegEdit.Create(self);
  RegEntries:=fRegEdit.ReadLocalMachineRegistry(Keyname, False)  ;
  try
    cbo.Items.Clear;
    for i := 0 to RegEntries.Count - 1 do begin
      cbo.Items.Add(pRegEntryItem(RegEntries.Items[i])^.Name);
    end;
  finally
    Freeandnil(RegEntries);
  end;
end;


procedure TPOSTillsPopUp.Printersetting;
begin
  lblUSBPrinter.enabled := IsUSBPrinter(cboPrinterType.text);
  cboUSBPrinter.enabled := IsUSBPrinter(cboPrinterType.text);
  grpPrnPorts.enabled   := not(IsUSBPrinter(cboPrinterType.text));
end;

procedure TPOSTillsPopUp.cboPrinterTypeChange(Sender: TObject);
begin
  inherited;
  Printersetting;
end;

procedure TPOSTillsPopUp.cbopolePortDropDown(Sender: TObject);
begin
  inherited;
  EditDB(qryTills);
end;

procedure TPOSTillsPopUp.wwCheckBox2Click(Sender: TObject);
begin
  inherited;
  EnableDisable;
end;



initialization
  RegisterClassOnce(TPOSTillsPopUp);

end.
