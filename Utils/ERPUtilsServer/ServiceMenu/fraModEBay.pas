unit fraModEBay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  JSONObject, Dialogs, fraUtilsConfigBase, DNMSpeedButton, StdCtrls, ExtCtrls,
  ComCtrls, DB, DBAccess, MyAccess, wwcheckbox, DNMPanel;

type
  TfrModEbay = class(TfrUtilsConfigBase)
    Bevel1: TBevel;
    lblModuleName: TLabel;
    btnShowLog: TDNMSpeedButton;
    btnAddSite: TButton;
    btnEditSite: TButton;
    btnDeleteSite: TButton;
    lvIntegrationConfig: TListView;
    btnHelp: TDNMSpeedButton;
    btnTestAccount: TDNMSpeedButton;
    chkShowEbayonMainMenubyDefault: TwwCheckBox;
    pnlShowEbayonMainMenubyDefault: TDNMPanel;
    Shape1: TShape;
    Label1: TLabel;
    chkActive: TwwCheckBox;
    procedure btnShowLogClick(Sender: TObject);
    procedure btnAddSiteClick(Sender: TObject);
    procedure btnEditSiteClick(Sender: TObject);
    procedure btnDeleteSiteClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnTestAccountClick(Sender: TObject);
    procedure chkShowEbayonMainMenubyDefaultClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    procedure LoadAccountList;
    {$HINTS OFF}
    function searchAccount(const AccName: String): TJSONObject;
    {$HINTS ON}
    procedure AddAccount;
    procedure EditSelectedAccount;
    procedure DeleteSelectedAccount;
  Protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
//    function GetModuleConfig: boolean; override;
//    function SetModuleConfig(var msg: string): boolean; Override;
//    function VerifyAndSetModuleConfig: boolean; Override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ShowERPMainmenu(const Value: Boolean);
  Published
  end;

var
  frModEbay: TfrModEbay;

implementation

uses
  LogMessageTypes, dateutils, ERPdbComponents, MySQLUtils, DbConst,
  frmIntegrationEbayConfig,Vista_MessageDlg, frmEbayConfigurationSteps,
  eBayConfig, DialogUtils;


{$R *.dfm}

{ TfrModEbay }

procedure TfrModEbay.AfterGetModuleConfig;
begin
  inherited;
  LoadAccountList;
  chkActive.Checked := Config.B['Active'];
  //chkShowEbayonMainMenubyDefault.Checked := AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault;
end;

procedure TfrModEbay.btnAddSiteClick(Sender: TObject);
begin
  inherited;
  AddAccount;
end;
procedure TfrModEbay.btnDeleteSiteClick(Sender: TObject);
begin
  inherited;
  DeleteSelectedAccount;
end;

procedure TfrModEbay.btnEditSiteClick(Sender: TObject);
begin
  inherited;
  EditSelectedAccount;
end;

procedure TfrModEbay.btnHelpClick(Sender: TObject);
begin
  inherited;
  With TfmEbayConfigurationSteps.create(Self) do try
    Showmodal;
  finally
    free;
  end;
end;

procedure TfrModEbay.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModEbay.btnTestAccountClick(Sender: TObject);
var
  NewAccount: TJsonObject;
begin
  inherited;
  if  lvIntegrationConfig.items.count =0 then begin
    NewAccount:= TJsonObject.Create;
    NewAccount.DT['NextSyncTime'] := inchour(now , 1);
    NewAccount.S['Name']          := 'Test';
    NewAccount.S['UserTocken']    := ebayUserTocken;
    NewAccount.S['AppId']         := ebayAppId;
    NewAccount.S['DevId']         := ebayDevId;
    NewAccount.S['CertId']        := ebayCertId;
    NewAccount.S['ReqVersion']    := ebayReqVersion;
    NewAccount.S['Database']      := Conn_Databse;
    NewAccount.B['SingleCustomer']:= False;
    NewAccount.DT['SyncDatefrom'] := 0;
    NewAccount.B['Active']        := True;
    NewAccount.I['LogginLevel']   := 1;
    With TfmIntegrationEbayConfig.Create(Self) do try
        UtilsClient:= Self.UtilsClient;
        if DoConfig(NewAccount, config, UtilsClient) then begin
          config.A['Accounts'].Add(NewAccount);
          LoadAccountList;
          VerifyAndSetModuleConfig;
        end else NewAccount.Free;
    finally
      Free;
    end;

  end;
end;

constructor TfrModEbay.Create(aOwner: TComponent);
begin
  inherited;
  btnTestAccount.visible := False;
  ShowERPMainmenu(False);
end;

Procedure TfrModEbay.ShowERPMainmenu(const Value:Boolean);
begin
  if not value then begin
    chkShowEbayonMainMenubyDefault.Visible := False;
    pnlShowEbayonMainMenubyDefault.Visible := False;
    lvIntegrationConfig.Height :=264;
    lvIntegrationConfig.top := 38;
  end else begin
    chkShowEbayonMainMenubyDefault.Visible := True;
    pnlShowEbayonMainMenubyDefault.Visible := True;
    lvIntegrationConfig.Height :=215;
    lvIntegrationConfig.top := 87;
  end;
end;

function TfrModEbay.GetModuleName: string;
begin
  result := 'ERPModEbay';
end;

procedure TfrModEbay.chkActiveClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;

  if TwwCheckBox(Sender).Checked then begin
    if not UtilsClient.LicenceOptionEnabled('EBay') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if not self.SetModuleProperty('Active',chkActive.Checked,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Active" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

procedure TfrModEbay.chkShowEbayonMainMenubyDefaultClick(Sender: TObject);
begin
  inherited;
  //AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault := chkShowEbayonMainMenubyDefault.Checked;
end;

procedure TfrModEbay.LoadAccountList;
var
  x: integer;
  Account: TJsonObject;
  listItem: TListItem;
begin
  lvIntegrationConfig.Clear;
  for x := 0 to Config.A['Accounts'].Count -1 do begin
    Account:= Config.A['Accounts'].Items[x].AsObject;
    listItem:= lvIntegrationConfig.Items.Add;
    listItem.Caption:= Account.S['Name'];
    if Account.B['Active'] then
      listItem.SubItems.Add('Active')
    else
      listItem.SubItems.Add('Inactive');
    listItem.SubItems.Add(Account.S['Database']);
  end;
end;

Function TfrModEbay.searchAccount(const AccName:String): TJSONObject;
var
  ctr:Integer;
begin
  Result:= nil;
  for ctr := 0 to Config.A['Accounts'].Count -1 do begin
    if Config.A['Accounts'].Items[ctr].asObject.S['Name'] = AccName then begin
      result:= Config.A['Accounts'].Items[ctr].asObject;
      Exit;
    end;
  end;
end;

procedure TfrModEbay.AddAccount;
var
  NewAccount: TJsonObject;
begin
  NewAccount:= TJsonObject.Create;
  NewAccount.DT['NextSyncTime'] := inchour(now , 1);
  NewAccount.S['Name']          := '';
  NewAccount.S['UserTocken']    := '';
  NewAccount.S['AppId']         := '';
  NewAccount.S['DevId']         := '';
  NewAccount.S['CertId']        := '';
  NewAccount.S['ReqVersion']    := ebayReqVersion;
  NewAccount.S['Database']      := '';
  NewAccount.B['SingleCustomer']:= False;
  NewAccount.DT['SyncDatefrom'] := 0;
  NewAccount.B['Active']        := True;
  NewAccount.I['LogginLevel']   := 1;
  With TfmIntegrationEbayConfig.Create(Self) do try
      UtilsClient:= Self.UtilsClient;
      if DoConfig(NewAccount, config, UtilsClient) then begin
        config.A['Accounts'].Add(NewAccount);
        LoadAccountList;
        VerifyAndSetModuleConfig;
      end else NewAccount.Free;
  finally
    Free;
  end;
end;

procedure TfrModEbay.EditSelectedAccount;
var
  listItem: TListItem;
  Account: TJsonObject;
  x: integer;
begin
  listItem:= lvIntegrationConfig.Selected;
  if Assigned(listItem) then begin
    for x := 0 to config.A['Accounts'].Count -1 do begin
      Account:= config.A['Accounts'].Items[x].AsObject;
      if SameText(Account.S['Name'],listItem.Caption) then begin
        With TfmIntegrationEbayConfig.Create(Self) do try
            UtilsClient:= Self.UtilsClient;
            if DoConfig(Account, config, UtilsClient) then begin
              LoadAccountList;
              VerifyAndSetModuleConfig;
            end;
        finally
          Free;
        end;
      end;
    end;
  end;
end;

procedure TfrModEbay.FrameResize(Sender: TObject);
begin
  inherited;
  lvIntegrationConfig.Top := 86;
  lvIntegrationConfig.Height := Height - lvIntegrationConfig.Top - 10;
end;

procedure TfrModEbay.DeleteSelectedAccount;
var
  listItem: TListItem;
  Account: TJsonObject;
  x: integer;
begin
  listItem:= lvIntegrationConfig.Selected;
  if Assigned(listItem) then begin
    if Vista_MessageDlg.MessageDlgXP_Vista('Are your sure you want to permently delete "' + listItem.Caption + '"?',mtConfirmation,[mbNo,mbYes],0) = mrYes then begin
      for x:= 0 to Config.A['Accounts'].Count -1 do begin
        Account:= Config.A['Accounts'].Items[x].AsObject;
        if SameText(listItem.Caption,Account.S['Name']) then begin
          Config.A['Accounts'].Delete(x);
          LoadAccountList;
          VerifyAndSetModuleConfig;
          exit;
        end;
      end;
    end;
  end;
end;

end.

