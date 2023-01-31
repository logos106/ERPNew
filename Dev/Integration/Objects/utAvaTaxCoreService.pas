unit utAvaTaxCoreService;

interface

uses
  JsonObject, utBaseCoreService;

type
  TAvaTaxCoreService = class(TBaseCoreService)
  private
    fsBaseURL     : String;
    fsAccountType : String;
    fbIsProduction: Boolean;
    fbIsSandBox   : Boolean;
    fsPassword    : String;
    fsCompanyID   : String;
    fsCompanyCode : String;
    fsUsername    : String;
    fbEnableAvaTax: Boolean;
    fbAutosynchList: Boolean;
  Protected
    Class function GetServiceName: string; override;
    procedure InitRequestParams(areq :TJsonObject);override;
    constructor Create; overload;Override;
    constructor Create(aCoreEDI: TObject); overload;Override;
  Public
    Property Username     : String    read fsUsername      write fsUsername;
    Property Password     : String    read fsPassword      write fsPassword;
    Property BaseURL      : String    read fsBaseURL       write fsBaseURL;
    Property CompanyID    : String    read fsCompanyID     write fsCompanyID;
    Property CompanyCode  : String    read fsCompanyCode   write fsCompanyCode;
    Property AccountType  : String    read fsAccountType   write fsAccountType;
    Property IsSandBox    : Boolean   read fbIsSandBox     write fbIsSandBox;
    Property IsProduction : Boolean   read fbIsProduction  write fbIsProduction;
    Property EnableAvaTax : Boolean   read fbEnableAvaTax  write fbEnableAvaTax;
    Property AutosynchList: Boolean   read fbAutosynchList write fbAutosynchList;
    function Initialize   : boolean; override;
    function SendAvaTaxDoc(aERPDoc: TJsonObject): boolean;


  Published
  end;


implementation

uses
  SysUtils, utCoreEDIConst, AppEnvironment, LogLib, CommonLib, dialogs, controls;

{ TAvaTaxCoreService }

constructor TAvaTaxCoreService.Create;
begin
  inherited;
  Timeout := 60*1000;
end;

constructor TAvaTaxCoreService.Create(aCoreEDI: TObject);
begin
  inherited Create(aCoreEDI);
  Timeout := 60*1000;
end;

class function TAvaTaxCoreService.GetServiceName: string;
begin
  result := Servicename_AvaTax;
end;

function TAvaTaxCoreService.Initialize: boolean;
var
  req: TJsonObject;
begin
  Username     := Appenv.CompanyPrefs.AvaTax_Username;
  Password     := Appenv.CompanyPrefs.AvaTax_Password;
  BaseURL      := Appenv.CompanyPrefs.AvaTax_BaseURL;
  CompanyID    := Appenv.CompanyPrefs.AvaTax_CompanyID;
  CompanyCode  := Appenv.CompanyPrefs.AvaTax_CompanyCode;
  AccountType  := Appenv.CompanyPrefs.AvaTax_AccountType;
  IsSandBox    := Appenv.CompanyPrefs.isAvaTaxSandBox;
  IsProduction := Appenv.CompanyPrefs.isAvaTaxProduction;

  if devmode then
    if IsProduction then begin
      IsProduction := MessageDlgXP_Vista('This is using a Prduction AvaTax Account. It is not possible to delete Transaction created in Avalara. Would you like to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mryes;
      IsSandBox := not(IsProduction);
    end;

  EnableAvaTax := Appenv.CompanyPrefs.EnableAvaTax;
  AutosynchList:= Appenv.CompanyPrefs.AvaTax_AutosynchList;
  Logtext('TAvaTaxCoreService.Command = Initialize');
  req := JO;
  try
    req.S['Command'] := 'Initialize';
    InitRequestParams(req);
    Logtext('WriteAndWait');
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

procedure TAvaTaxCoreService.InitRequestParams(areq: TJsonObject);
begin
  inherited;
    areq.FormatOutput := false;
    areq.O['Params'].S['Username']     := Appenv.CompanyPrefs.AvaTax_Username;
    areq.O['Params'].S['Password']     := Appenv.CompanyPrefs.AvaTax_Password;
    areq.O['Params'].S['BaseURL']      := Appenv.CompanyPrefs.AvaTax_BaseURL;
    areq.O['Params'].S['CompanyID']    := Appenv.CompanyPrefs.AvaTax_CompanyID;
    areq.O['Params'].S['CompanyCode']  := Appenv.CompanyPrefs.AvaTax_CompanyCode;
    areq.O['Params'].S['AccountType']  := Appenv.CompanyPrefs.AvaTax_AccountType;
    areq.O['Params'].B['IsSandBox']    := Appenv.CompanyPrefs.isAvaTaxSandBox;
    areq.O['Params'].B['IsProduction'] := Appenv.CompanyPrefs.isAvaTaxProduction;
    areq.O['Params'].B['EnableAvaTax'] := Appenv.CompanyPrefs.EnableAvaTax;
    areq.O['Params'].B['AutosynchList']:= Appenv.CompanyPrefs.AvaTax_AutosynchList;
end;

function TAvaTaxCoreService.SendAvaTaxDoc(aERPDoc: TJsonObject): boolean;
begin
  result := AddERPObject(aERPDoc);
end;

end.
