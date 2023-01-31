unit IntegrationPrefsEDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton;

type
  TItegrationPrefsEDIGUI = class(TForm)
    pnlEDIConfig: TDNMPanel;
    Bevel8: TBevel;
    chkShowEDIOnMainMenuByDefault: TwwCheckBox;
    btnHelp: TDNMSpeedButton;
    Label4: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblTitle: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    chkAutoSynchFromList: TwwCheckBox;
    chkAutoSynchFromSalesList: TwwCheckBox;
    edtSaleshippedStatus: TEdit;
    edtPOShippedStatus: TEdit;
    edtPOAcknowledgementStatus: TEdit;
    edtPOSentStatus: TEdit;
    edtPOReadyStatus: TEdit;
    edtDocSenderCode: TEdit;
    chkEnableEDI: TwwCheckBox;
    chkEnableSalesEDI: TwwCheckBox;
    edtSalesDocSenderCode: TEdit;
    edtSalesReadyStatus: TEdit;
    edtSalesSentStatus: TEdit;
    edtSalesAcknowledgementStatus: TEdit;
    procedure edtChange(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);

  private
    { Private declarations }
  public
    procedure Load;
    procedure Save;
  end;

implementation

uses
  AppEnvironment, CommonDbLib, DocReaderObj;

{$R *.dfm}

{ TItegrationPrefsEDIGUI }

procedure TItegrationPrefsEDIGUI.Load;
begin
  chkEnableEDI.Checked                  := AppEnv.CompanyPrefs.EDIConfig.EnableEDI;
  chkShowEDIOnMainMenuByDefault.Checked := AppEnv.CompanyPrefs.EDIConfig.ShowEDIOnMainMenuByDefault;
  chkAutoSynchFromList.Checked          := AppEnv.CompanyPrefs.EDIConfig.AutoSynchFromList;

  edtPOReadyStatus.Text                 := AppEnv.CompanyPrefs.EDIConfig.POReadyStatus;
  edtPOSentStatus.Text                  := AppEnv.CompanyPrefs.EDIConfig.POSentStatus;
  edtPOAcknowledgementStatus.Text       := AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus;
  edtPOShippedStatus.Text               := AppEnv.CompanyPrefs.EDIConfig.POShippedStatus;
  edtDocSenderCode.Text                 := AppEnv.CompanyPrefs.EDIConfig.DocSenderCode;

  chkEnableSalesEDI.Checked             := AppEnv.CompanyPrefs.EDIConfig.EnableSalesEDI;
  chkAutoSynchFromSalesList.Checked     := AppEnv.CompanyPrefs.EDIConfig.AutoSynchFromSalesList;
  edtSalesDocSenderCode.Text            := AppEnv.CompanyPrefs.EDIConfig.SalesDocSenderCode;
  edtSalesReadyStatus.Text              := AppEnv.CompanyPrefs.EDIConfig.SalesReadyStatus;
  edtSalesSentStatus.Text               := AppEnv.CompanyPrefs.EDIConfig.SalesSentStatus;
  edtSalesAcknowledgementStatus.Text    := AppEnv.CompanyPrefs.EDIConfig.SalesAcknowledgementStatus;
  edtSaleshippedStatus.Text             := AppEnv.CompanyPrefs.EDIConfig.SalesShippedStatus;
end;

procedure TItegrationPrefsEDIGUI.Save;
begin
  AppEnv.CompanyPrefs.EDIConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

procedure TItegrationPrefsEDIGUI.btnHelpClick(Sender: TObject);
begin
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'X12 EDI');
end;

procedure TItegrationPrefsEDIGUI.CheckBoxClick(Sender: TObject);
begin
  if not (Sender is TwwCheckBox) then Exit;
  if not TwwCheckBox(Sender).Focused then exit;

       if Sender = chkEnableEDI                   then AppEnv.CompanyPrefs.EDIConfig.EnableEDI                  := TwwCheckBox(Sender).Checked
  else if Sender = chkShowEDIOnMainMenuByDefault  then AppEnv.CompanyPrefs.EDIConfig.ShowEDIOnMainMenuByDefault := TwwCheckBox(Sender).Checked
  else if Sender = chkAutoSynchFromList           then AppEnv.CompanyPrefs.EDIConfig.AutoSynchFromList          := TwwCheckBox(Sender).Checked
  else if Sender = chkEnableSalesEDI              then AppEnv.CompanyPrefs.EDIConfig.EnableSalesEDI             := TwwCheckBox(Sender).Checked
  else if Sender = chkAutoSynchFromSalesList      then AppEnv.CompanyPrefs.EDIConfig.AutoSynchFromSalesList  := TwwCheckBox(Sender).Checked
end;

procedure TItegrationPrefsEDIGUI.edtChange(Sender: TObject);
begin
  if not (Sender is TEdit) then Exit;
  if not TEdit(Sender).Focused then exit;

         if Sender = edtPOReadyStatus               then AppEnv.CompanyPrefs.EDIConfig.POReadyStatus              := TEdit(Sender).Text
    else if Sender = edtPOSentStatus                then AppEnv.CompanyPrefs.EDIConfig.POSentStatus               := TEdit(Sender).Text
    else if Sender = edtPOAcknowledgementStatus     then AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus    := TEdit(Sender).Text
    else if Sender = edtPOShippedStatus             then AppEnv.CompanyPrefs.EDIConfig.POShippedStatus            := TEdit(Sender).Text
    else if Sender = edtDocSenderCode               then AppEnv.CompanyPrefs.EDIConfig.DocSenderCode              := TEdit(Sender).Text
    else if Sender = edtSalesDocSenderCode          then AppEnv.CompanyPrefs.EDIConfig.SalesDocSenderCode         := TEdit(Sender).Text
    else if Sender = edtSalesReadyStatus            then AppEnv.CompanyPrefs.EDIConfig.SalesReadyStatus           := TEdit(Sender).Text
    else if Sender = edtSalesSentStatus             then AppEnv.CompanyPrefs.EDIConfig.SalesSentStatus            := TEdit(Sender).Text
    else if Sender = edtSalesAcknowledgementStatus  then AppEnv.CompanyPrefs.EDIConfig.SalesAcknowledgementStatus := TEdit(Sender).Text
    else if Sender = edtSaleshippedStatus           then AppEnv.CompanyPrefs.EDIConfig.SalesShippedStatus         := TEdit(Sender).Text

end;



end.
