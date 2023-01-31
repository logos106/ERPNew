unit frmSMSMasterAccountInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, JsonObject,
  AdvEdit, wwdblook;

type

  TSMSConfigMaster = class;

  TfmSMSMasterAccountInfo = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label10: TLabel;
    edtSMSUserName: TEdit;
    Label11: TLabel;
    edtSMSPassword: TEdit;
    Label16: TLabel;
    edtMargin: TAdvEdit;
    Label17: TLabel;
    edtMinOut: TAdvEdit;
    Label18: TLabel;
    edtMinIn: TAdvEdit;
    cboProduct: TwwDBLookupCombo;
    Label1: TLabel;
    qryProductLookup: TERPQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtSMSUserNameChange(Sender: TObject);
    procedure edtSMSPasswordChange(Sender: TObject);
    procedure edtMarginChange(Sender: TObject);
    procedure edtMinOutChange(Sender: TObject);
    procedure edtMinInChange(Sender: TObject);
    procedure cboProductChange(Sender: TObject);
  private
    ConfigMaster: TSMSConfigMaster;
  public
    { Public declarations }
  end;

  TSMSConfigMaster = class(TJsonObject)
  private
    function GetSMSPass: string;
    function GetSMSUser: string;
    procedure SetSMSPass(const Value: string);
    procedure SetSMSUser(const Value: string);
    function GetPriceMargin: double;
    function GetPriceMinInbound: double;
    function GetPriceMinOutbound: double;
    procedure SetPriceMargin(const Value: double);
    procedure SetPriceMinInbound(const Value: double);
    procedure SetPriceMinOutbound(const Value: double);
    function GetSMSChargeProduct: string;
    procedure SetSMSChargeProduct(const Value: string);
  public
    procedure Load(connection: TMyConnection);
    procedure Save(connection: TMyConnection);
    property SMSUser: string read GetSMSUser write SetSMSUser;
    property SMSPass: string read GetSMSPass write SetSMSPass;
    property PriceMargin: double read GetPriceMargin write SetPriceMargin;
    property PriceMinInbound: double read GetPriceMinInbound write SetPriceMinInbound;
    property PriceMinOutbound: double read GetPriceMinOutbound write SetPriceMinOutbound;
    property SMSChargeProduct: string read GetSMSChargeProduct write SetSMSChargeProduct;
  end;


var
  fmSMSMasterAccountInfo: TfmSMSMasterAccountInfo;

implementation

{$R *.dfm}

uses
  DNMExceptions;

procedure TfmSMSMasterAccountInfo.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSMSMasterAccountInfo.btnSaveClick(Sender: TObject);
begin
  inherited;
  ConfigMaster.Save(MyConnection);
  self.CommitTransaction;
  Close;
end;

procedure TfmSMSMasterAccountInfo.cboProductChange(Sender: TObject);
begin
  inherited;
  if TwwDBLookupCombo(Sender).Focused then begin
    ConfigMaster.SMSChargeProduct := TwwDBLookupCombo(Sender).Text;
  end;
end;

procedure TfmSMSMasterAccountInfo.edtMarginChange(Sender: TObject);
begin
  inherited;
  if TAdvEdit(Sender).Focused then begin
    ConfigMaster.PriceMargin := TAdvEdit(Sender).FloatValue;
  end;
end;

procedure TfmSMSMasterAccountInfo.edtMinInChange(Sender: TObject);
begin
  inherited;
  if TAdvEdit(Sender).Focused then begin
    ConfigMaster.PriceMinInbound := TAdvEdit(Sender).FloatValue;
  end;
end;

procedure TfmSMSMasterAccountInfo.edtMinOutChange(Sender: TObject);
begin
  inherited;
  if TAdvEdit(Sender).Focused then begin
    ConfigMaster.PriceMinOutbound := TAdvEdit(Sender).FloatValue;
  end;
end;

procedure TfmSMSMasterAccountInfo.edtSMSPasswordChange(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Focused then begin
    ConfigMaster.SMSPass := edtSMSPassword.Text;
  end;
end;

procedure TfmSMSMasterAccountInfo.edtSMSUserNameChange(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Focused then begin
    ConfigMaster.SMSUser := edtSMSUserName.Text;
  end;
end;

procedure TfmSMSMasterAccountInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmSMSMasterAccountInfo.FormCreate(Sender: TObject);
begin
  inherited;
  ConfigMaster := TSMSConfigMaster.Create;
end;

procedure TfmSMSMasterAccountInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  ConfigMaster.Free;
end;

procedure TfmSMSMasterAccountInfo.FormShow(Sender: TObject);
begin
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

//      qryClient.ParamByName('ClientID').AsInteger := KeyId;
//      qryServers.ParamByName('ClientID').AsInteger := KeyId;
//      self.OpenQueries;
      ConfigMaster.Load(MyConnection);

      self.OpenQueries;

      edtSMSUserName.Text := ConfigMaster.SMSUser;
      edtSMSPassword.Text := ConfigMaster.SMSPass;
      cboProduct.Text := ConfigMaster.SMSChargeProduct;

      //DataState.Activate;

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

{ TSMSConfigMaster }

function TSMSConfigMaster.GetPriceMargin: double;
begin
  result := F['PriceMargin'];
end;

function TSMSConfigMaster.GetPriceMinInbound: double;
begin
  result := F['PriceMinInbound'];
end;

function TSMSConfigMaster.GetPriceMinOutbound: double;
begin
  result := F['PriceMinOutbound'];
end;

function TSMSConfigMaster.GetSMSChargeProduct: string;
begin
  result := S['SMSChargeProduct'];
end;

function TSMSConfigMaster.GetSMSPass: string;
begin
  result := S['SMSPass'];
end;

function TSMSConfigMaster.GetSMSUser: string;
begin
  result := S['SMSUser'];
end;

procedure TSMSConfigMaster.Load(connection: TMyConnection);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := connection;
    qry.SQL.Add('select * from tbldbpreferences');
    qry.SQL.Add('where PrefType = '+ QuotedStr(self.ClassName));
    qry.SQL.Add('and Name = "Config"');
    qry.Open;
    self.AsString := qry.FieldByName('FieldValue').AsString;
  finally
    qry.Free;
  end;
end;

procedure TSMSConfigMaster.Save(connection: TMyConnection);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := connection;
    qry.SQL.Add('select * from tbldbpreferences');
    qry.SQL.Add('where PrefType = '+ QuotedStr(self.ClassName));
    qry.SQL.Add('and Name = "Config"');
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('PrefType').AsString := self.ClassName;
      qry.FieldByName('Name').AsString := 'Config';
      qry.FieldByName('RefType').AsString := 'None';
      qry.FieldByName('LocalPref').AsString := 'F';
      qry.FieldByName('FieldType').AsString := 'ftString';
      qry.FieldByName('FieldSize').AsInteger := 0;
    end
    else
      qry.Edit;
    qry.FieldByName('FieldValue').AsString:= self.AsString;
    qry.Post;
  finally
    qry.Free;
  end;
end;

procedure TSMSConfigMaster.SetPriceMargin(const Value: double);
begin
  F['PriceMargin'] := Value;
end;

procedure TSMSConfigMaster.SetPriceMinInbound(const Value: double);
begin
  F['PriceMinInbound'] := Value;
end;

procedure TSMSConfigMaster.SetPriceMinOutbound(const Value: double);
begin
  F['PriceMinOutbound'] := Value;
end;

procedure TSMSConfigMaster.SetSMSChargeProduct(const Value: string);
begin
  S['SMSChargeProduct'] := Value;
end;

procedure TSMSConfigMaster.SetSMSPass(const Value: string);
begin
  S['SMSPass'] := Value;
end;

procedure TSMSConfigMaster.SetSMSUser(const Value: string);
begin
  S['SMSUser'] := Value;
end;

initialization
  RegisterClass(TfmSMSMasterAccountInfo);

end.
