unit AvaTaxConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB, TypesLib;
const
  AvaTax_SandBox =  'Sandbox';
  AvaTax_Production =  'Production';
type
  TAvaTaxConfig =  class(TJsonDbPefConfig)
    Private
    fdAuthTokenGeneratedAt: TDateTime;
    fdTokenExpireTime: TDateTime;
    fCheckIsAvaTaxCredentialsValidated: TGeneralBooleanFunc;

    Function GetEnableAvaTax          : Boolean;
    Function GetCredentialsValidated  : Boolean;
    Function GetShowAvaTaxOnMainMenu  : Boolean;
    Function GetAutosynchList         : Boolean;
    function getUsername              : String;
    function getPassword              : String;
    function getBaseURL               : String;
    function getCompanyID             : String;
    function getAvaTaxSaleCode        : String;
    function getCompanycode           : String;
    function getAvaTax_AccountType    : String;
    function getNotaxTaxcode          : String;
    function getTaxExcemptTaxcode     : String;
    function getPickupTaxcode         : String;
    function getShippingTaxcode       : String;
    function getIsAvaTaxSandBox       : Boolean   ;
    function getIsAvaTaxProduction    : Boolean   ;

    Procedure SetEnableAvaTax         (Const Value: Boolean);
    Procedure SetCredentialsValidated (Const Value: Boolean);
    Procedure SetShowAvaTaxOnMainMenu (Const Value: Boolean);
    Procedure SetAutosynchList        (Const Value: Boolean);
    procedure SetUsername             (const Value: String);
    procedure SetPassword             (const Value: String);
    procedure SetBaseURL              (const Value: String);
    procedure SetCompanyID            (const Value: String);
    procedure SetAvaTaxSaleCode       (const Value: String);
    procedure SetCompanycode          (const Value: String);
    procedure SetAvaTax_AccountType   (const Value: String);
    procedure SetNotaxTaxcode         (const Value: String);
    procedure SetTaxExcemptTaxcode    (const Value: String);
    procedure SetPickupTaxcode        (const Value: String);
    procedure SetShippingTaxcode      (const Value: String);
    function getAccountsURL   : String;
    function getCompaniesURL  : String;
    function getItemsURL      : String;
    function getLocationsURL  : String;
    function getPingURL       : String;
    function getTaxCodesURL   : String;
    function AddToURL(aREsult, aValue: String): String;

    Protected
    Public
      constructor Create; override;
      procedure Load(connection: TMyConnection); overload; override;
      procedure Load(ds: TDataset); overload; override;

      Property EnableAvaTax         : Boolean   read getEnableAvaTax            Write SetEnableAvaTax;
      Property CredentialsValidated : Boolean   read getCredentialsValidated    Write SetCredentialsValidated;
      Property ShowAvaTaxOnMainMenu : Boolean   read getShowAvaTaxOnMainMenu    Write SetShowAvaTaxOnMainMenu;
      Property AutosynchList        : Boolean   read getAutosynchList           Write SetAutosynchList;
      Property Username             : String    read getUsername                write SetUsername;
      Property Password             : String    read getPassword                write SetPassword;
      Property BaseURL              : String    read getBaseURL                 write SetBaseURL;
      Property CompanyID            : String    read getCompanyID               write SetCompanyID;
      Property AvaTaxSaleCode       : String    read getAvaTaxSaleCode          write SetAvaTaxSaleCode;
      Property Companycode          : String    read getCompanycode             write SetCompanycode;
      Property AvaTax_AccountType   : String    read getAvaTax_AccountType      write SetAvaTax_AccountType;
      Property NotaxTaxcode         : String    read getNotaxTaxcode            write SetNotaxTaxcode;
      Property TaxExcemptTaxcode    : String    read getTaxExcemptTaxcode       write SetTaxExcemptTaxcode;
      Property PickupTaxcode        : String    read getPickupTaxcode           write SetPickupTaxcode;
      Property ShippingTaxcode      : String    read getShippingTaxcode         write SetShippingTaxcode;
      Property IsAvaTaxSandBox      : Boolean   read getIsAvaTaxSandBox         ;
      Property IsAvaTaxProduction   : Boolean   read getIsAvaTaxProduction      ;
      Property PINGURL        :String read getPingURL;
      Property CompaniesURL   :String read getCompaniesURL;
      Property AccountsURL    :String read getAccountsURL;
      Property ItemsURL       :String read getItemsURL;
      Property TaxCodesURL    :String read getTaxCodesURL;
      Property LocationsURL   :String read getLocationsURL;
      Procedure Save(connection: TMyConnection); Override;
      Property CheckIsAvaTaxCredentialsValidated : TGeneralBooleanFunc read fCheckIsAvaTaxCredentialsValidated write fCheckIsAvaTaxCredentialsValidated;


    Published

  end;

implementation

uses SysUtils;

{ TAvaTaxConfig }

procedure TAvaTaxConfig.Load(connection: TMyConnection);
begin
  inherited;

end;


procedure TAvaTaxConfig.Load(ds: TDataset);
begin
  inherited;
end;

constructor TAvaTaxConfig.Create;
begin
  inherited;
  fCheckIsAvaTaxCredentialsValidated:= nil;
end;
Function TAvaTaxConfig.AddToURL(aREsult, aValue:String):String;
begin
  REsult := trim(aREsult);
  aValue :=Trim(aValue);
  if aValue ='' then exit;
  if copy(result, length(result),1) <> '/' then if copy(avalue,1,1) <> '/' then  result := result +'/';
  if copy(result, length(result),1) =  '/' then if copy(avalue,1,1) =  '/' then  aValue := copy(aValue, 2, length(avalue));
  result := result + aValue;
end;
function TAvaTaxConfig.getBaseURL             : String ;
begin
  result := S['BaseURL']              ;
  if result = '' then
    if IsAvaTaxSandBox then result := 'https://sandbox-rest.avatax.com/api/v2'
    else result := 'https://rest.avatax.com/api/v2';
       if sametext(copy(result, length(result)-length('/api/v2/')+1,length('/api/v2/')) , '/api/v2/') then
  else if sametext(copy(result, length(result)-length('/api/v2')+1,length('/api/v2')) , '/api/v2') then else result := AddToURL(result, '/api/v2');
       if sametext(copy(result, length(result)-length('/v2/')+1    ,length('/v2/'))     , '/v2/')     then
  else if sametext(copy(result, length(result)-length('/v2')+1    ,length('/v2'))     , '/v2')     then else result := AddToURL(result, '/v2');
end;
procedure TAvaTaxConfig.Save(connection: TMyConnection);
begin
  if Assigned(fCheckIsAvaTaxCredentialsValidated) then
    CredentialsValidated:= CheckIsAvaTaxCredentialsValidated;
  inherited Save(Connection);
end;

Function TAvaTaxConfig.GetCredentialsValidated: Boolean;begin result := B['CredentialsValidated'] ;end;
Function TAvaTaxConfig.GetEnableAvaTax        : Boolean;begin result := B['EnableAvaTax']         ;end;
Function TAvaTaxConfig.GetShowAvaTaxOnMainMenu: Boolean;begin result := B['ShowAvaTaxOnMainMenu'] ;end;
Function TAvaTaxConfig.GetAutosynchList       : Boolean;begin result := B['AutosynchList']        ;end;
function TAvaTaxConfig.getUsername            : String ;begin result := S['Username']             ;end;
function TAvaTaxConfig.getPassword            : String ;begin result := S['Password']             ;end;
function TAvaTaxConfig.getCompanyID           : String ;begin result := S['CompanyID']            ;end;
function TAvaTaxConfig.getAvaTaxSaleCode      : String ;begin result := S['AvaTaxSaleCode']       ;if result = '' then result := 'TrueERP'; end;
function TAvaTaxConfig.getCompanycode         : String ;begin result := S['Companycode']          ;end;
function TAvaTaxConfig.getAvaTax_AccountType  : String ;begin result := S['AvaTax_AccountType']   ;if result = '' then result := AvaTax_SandBox; end;
function TAvaTaxConfig.getNotaxTaxcode        : String ;begin result := S['NotaxTaxcode']         ;end;
function TAvaTaxConfig.getTaxExcemptTaxcode   : String ;begin result := S['TaxExcemptTaxcode']    ;end;
function TAvaTaxConfig.getPickupTaxcode       : String ;begin result := S['PickupTaxcode']        ;end;
function TAvaTaxConfig.getShippingTaxcode     : String ;begin result := S['ShippingTaxcode']      ;end;
Function TAvaTaxConfig.getIsAvaTaxSandBox     : Boolean;begin result := Sametext(AvaTax_AccountType , AvaTax_SandBox)    ; end;
Function TAvaTaxConfig.getIsAvaTaxProduction  : Boolean;begin result := Sametext(AvaTax_AccountType , 'Production') ; end;

function TAvaTaxConfig.getPingURL     : String;begin   Result := AddToURL(BaseURL, '/utilities/ping')                   ; end;
function TAvaTaxConfig.getCompaniesURL: String;begin   Result := AddToURL(BaseURL, '/companies')                        ; end;
function TAvaTaxConfig.getAccountsURL : String;begin   Result := AddToURL(BaseURL, '/accounts')                         ; end;
function TAvaTaxConfig.getItemsURL    : String;begin   Result := AddToURL(BaseURL, '/companies/'+CompanyId+'/items')    ; end;
function TAvaTaxConfig.getTaxCodesURL : String;begin   Result := AddToURL(BaseURL, '/companies/'+CompanyId+'/taxcodes') ; end;
function TAvaTaxConfig.getLocationsURL: String;begin   Result := AddToURL(BaseURL, '/companies/'+CompanyId+'/locations'); end;

Procedure TAvaTaxConfig.SetCredentialsValidated (Const Value: Boolean); begin if B['CredentialsValidated']       = Value  then exit;B['CredentialsValidated'] := Value ; end;
Procedure TAvaTaxConfig.SetEnableAvaTax         (Const Value: Boolean); begin if B['EnableAvaTax']               = Value  then exit;B['EnableAvaTax']         := Value ; CredentialsValidated := False; end;
Procedure TAvaTaxConfig.SetShowAvaTaxOnMainMenu (Const Value: Boolean); begin if B['ShowAvaTaxOnMainMenu']       = Value  then exit;B['ShowAvaTaxOnMainMenu'] := Value ; CredentialsValidated := False; end;
Procedure TAvaTaxConfig.SetAutosynchList        (Const Value: Boolean); begin if B['AutosynchList']              = Value  then exit;B['AutosynchList']        := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetUsername             (const Value: String);  begin if SameText(S['Username']          , Value) then exit;S['Username']             := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetPassword             (const Value: String);  begin if SameText(S['Password']          , Value) then exit;S['Password']             := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetBaseURL              (const Value: String);  begin if SameText(S['BaseURL']           , Value) then exit;S['BaseURL']              := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetCompanyID            (const Value: String);  begin if SameText(S['CompanyID']         , Value) then exit;S['CompanyID']            := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetAvaTaxSaleCode       (const Value: String);  begin if SameText(S['AvaTaxSaleCode']    , Value) then exit;S['AvaTaxSaleCode']       := Value ; end;
procedure TAvaTaxConfig.SetCompanycode          (const Value: String);  begin if SameText(S['Companycode']       , Value) then exit;S['Companycode']          := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetAvaTax_AccountType   (const Value: String);  begin if SameText(S['AvaTax_AccountType'], Value) then exit;S['AvaTax_AccountType']   := Value ; CredentialsValidated := False; end;
procedure TAvaTaxConfig.SetNotaxTaxcode         (const Value: String);  begin if SameText(S['NotaxTaxcode']      , Value) then exit;S['NotaxTaxcode']         := Value ; end;
procedure TAvaTaxConfig.SetTaxExcemptTaxcode    (const Value: String);  begin if SameText(S['TaxExcemptTaxcode'] , Value) then exit;S['TaxExcemptTaxcode']    := Value ; end;
procedure TAvaTaxConfig.SetPickupTaxcode        (const Value: String);  begin if SameText(S['PickupTaxcode']     , Value) then exit;S['PickupTaxcode']        := Value ; end;
procedure TAvaTaxConfig.SetShippingTaxcode      (const Value: String);  begin if SameText(S['ShippingTaxcode']   , Value) then exit;S['ShippingTaxcode']      := Value ; end;

end.
