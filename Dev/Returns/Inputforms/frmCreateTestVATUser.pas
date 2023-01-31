unit frmCreateTestVATUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, JsonObject;

type
  TfmCreateTestVATUser = class(TBaseForm)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    memData: TMemo;
    btnUpdateRegoNo: TDNMSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnUpdateRegoNoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Data: TJsonObject;
    procedure CreateTestUser;
    procedure DoCreateTestUser;
  public
    { Public declarations }
  end;

var
  fmCreateTestVATUser: TfmCreateTestVATUser;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, CommonLib, utGovUK_API,
  JsonObjectUtils, SystemLib;

procedure TfmCreateTestVATUser.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmCreateTestVATUser.btnCompletedClick(Sender: TObject);
begin
  inherited;
  CreateTestUser;
end;

procedure TfmCreateTestVATUser.btnUpdateRegoNoClick(Sender: TObject);
begin
  inherited;
  if Data.S['vrn'] = '' then begin
    CommonLib.MessageDlgXP_Vista('VAT Registration Number not found',mtWarning,[mbOk],0);
   exit;
  end;

  AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber := Data.S['vrn'];
  AppEnv.CompanyPrefs.HMRC_APIConfig.Save(CommonDbLib.GetSharedMyDacConnection);

end;

procedure TfmCreateTestVATUser.CreateTestUser;
var
  msg: string;
  RequiresRefresh: boolean;
begin
  memData.Clear;
  if not AppEnv.CompanyPrefs.HMRC_APIConfig.Validate(msg) then begin
    CommonLib.MessageDlgXP_Vista(msg, mtInformation,[mbOk],0);
    exit;
  end;


  TGovUK_API.Inst.SandboxClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID;
  TGovUK_API.Inst.SandboxClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret;
  TGovUK_API.Inst.ProductionClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID;
  TGovUK_API.Inst.ProductionClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret;
  TGovUK_API.Inst.VATRegistrationNumber := AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber;
  TGovUK_API.Inst.SandboxMode := AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode;

  TGovUK_API.Inst.AuthSuccessMessage := 'Click on "Create" to create the test VAT customer.';
  if TGovUK_API.Inst.CheckToken(Scope_VAT,RequiresRefresh) then begin
    if RequiresRefresh then begin
      if CommonLib.MessageDlgXP_Vista('User validation required, continue?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        TGovUK_API.Inst.RefreshToken(Scope_VAT);
        exit;
      end
      else begin
        exit;
      end;
    end;

  end
  else begin
    CommonLib.MessageDlgXP_Vista(TGovUK_API.Inst.ErrorList.FormattedErrors, mtInformation,[mbOk],0);
    exit;
  end;

  DoCreateTestUser;

end;

procedure TfmCreateTestVATUser.DoCreateTestUser;
var
  obj: TJsonObject;
  ScopeRequiringRefresh: string;
begin
  obj := JO('{"serviceNames": [' +
    '"corporation-tax",' +
    '"paye-for-employers",' +
    '"submit-vat-returns",' +
    '"national-insurance",' +
    '"self-assessment",' +
    '"mtd-income-tax",' +
    '"mtd-vat",' +
    '"lisa",' +
    '"secure-electronic-transfer",' +
    '"relief-at-source",' +
    '"customs-services"'+
    ']}');
  try
//    obj.A['ServiceNames'].Add('submit-vat-returns');
//    obj.A['ServiceNames'].Add('mtd-vat');
//    obj.A['ServiceNames'].Add('secure-electronic-transfer');

    if TGovUK_API.Inst.CreateTestOrganisation(obj, Data, ScopeRequiringRefresh) then begin
      if ScopeRequiringRefresh <> '' then begin
        CommonLib.MessageDlgXP_Vista('User validation needs refreshing.',mtInformation,[mbOk],0);
      end
      else begin
        { All good }
        memData.Text := JsonToStrFormat(Data);

        ForceDirectories(GetMyDocumentsDir + 'Test VAT Users\');
        JsonToFileFormated(Data, GetMyDocumentsDir + 'Test VAT Users\' + Data.S['userFullName'] + '.json');


//        CommonLib.MessageDlgXP_Vista('VAT Submision Complete.',mtInformation,[mbOk],0);
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista(TGovUK_API.Inst.ErrorList.FormattedErrors,mtInformation,[mbOk],0);
    end;
  finally
    obj.Free;
  end;
end;

procedure TfmCreateTestVATUser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCreateTestVATUser.FormCreate(Sender: TObject);
begin
  inherited;
  Data := JO;
end;

procedure TfmCreateTestVATUser.FormDestroy(Sender: TObject);
begin
  inherited;
  Data.Free;
end;

initialization
  RegisterClass(TfmCreateTestVATUser);

end.
