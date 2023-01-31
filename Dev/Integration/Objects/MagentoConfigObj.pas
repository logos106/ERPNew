unit MagentoConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

type
  TMagentoConfig =  class(TJsonDbPefConfig)
    Private
    fdAuthTokenGeneratedAt: TDateTime;
    fdTokenExpireTime: TDateTime;

    Function GetEnableMagento         : Boolean;
    Function GetShowMagentoOnMainMenu : Boolean;
    Function GetAutosynchList         : Boolean;
    function getAPI_Base_URL          : String;
    function getConsumer_Key          : String;
    function getConsumer_Secret       : String;
    function getAccess_Token          : String;
    function getAccess_Token_Secret   : String;
    function getAdminUserName         : String;
    function getAdminPassword         : String;
    function getAuth_token            : String;
    function getMagento_SalesType     : String;
    function getMagento_CustomerID    : String;
    function getMagento_ProductName   : String;
    Function getMagento_SynchPageSize : Integer;
    function getCompanyid             : String;
    Function GetMagento_PrintNameToShortDesc: Boolean;
    Function GetMagento_CopyProductinfoToERP: Boolean;

    Procedure SetEnableMagento        (Const Value: Boolean);
    Procedure SetShowMagentoOnMainMenu(Const Value: Boolean);
    Procedure SetAutosynchList        (Const Value: Boolean);
    procedure SetAPI_Base_URL         (const Value: String);
    procedure SetConsumer_Key         (const Value: String);
    procedure SetConsumer_Secret      (const Value: String);
    procedure SetAccess_Token         (const Value: String);
    procedure SetAccess_Token_Secret  (const Value: String);
    procedure SetAdminUserName        (const Value: String);
    procedure SetAdminPassword        (const Value: String);
    procedure SetAuth_token           (const Value: String);
    procedure SetMagento_SalesType    (const Value: String);
    procedure SetMagento_CustomerID   (const Value: String);
    procedure SetMagento_ProductName  (const Value: String);
    Procedure SetMagento_SynchPageSize(Const Value: Integer);
    procedure SetCompanyid            (const Value: String);
    Procedure SetMagento_PrintNameToShortDesc (Const Value: Boolean);
    Procedure SetMagento_CopyProductinfoToERP (Const Value: Boolean);

    Protected
    Public
      constructor Create; override;
      procedure Load(connection: TMyConnection); overload; override;
      procedure Load(ds: TDataset); overload; override;

      Property EnableMagento        : Boolean   read getEnableMagento           Write SetEnableMagento;
      Property ShowMagentoOnMainMenu: Boolean   read getShowMagentoOnMainMenu   Write SetShowMagentoOnMainMenu;
      Property AutosynchList        : Boolean   read getAutosynchList           Write SetAutosynchList;
      Property API_Base_URL         : String    read getAPI_Base_URL            write SetAPI_Base_URL;
      Property Consumer_Key         : String    read getConsumer_Key            write SetConsumer_Key;
      Property Consumer_Secret      : String    read getConsumer_Secret         write SetConsumer_Secret;
      Property Access_Token         : String    read getAccess_Token            write SetAccess_Token;
      Property Access_Token_Secret  : String    read getAccess_Token_Secret     write SetAccess_Token_Secret;
      Property AdminUserName        : String    read getAdminUserName           write SetAdminUserName;
      Property AdminPassword        : String    read getAdminPassword           write SetAdminPassword;
      Property Auth_token           : String    read getAuth_token              write SetAuth_token;
      Property AuthTokenGeneratedAt : TDateTime read fdAuthTokenGeneratedAt     write fdAuthTokenGeneratedAt;
      Property TokenExpireTime      : TDateTime read fdTokenExpireTime          write fdTokenExpireTime;
      Property Magento_SalesType    : String    read getMagento_SalesType       write SetMagento_SalesType;
      Property Magento_CustomerID   : String    read getMagento_CustomerID      write SetMagento_CustomerID;
      Property Magento_ProductName  : String    read getMagento_ProductName     write SetMagento_ProductName;
      Property Magento_SynchPageSize:Integer    read getMagento_SynchPageSize   Write SetMagento_SynchPageSize;
      Property Companyid            : String    read getCompanyid               write SetCompanyid;
      Property Magento_PrintNameToShortDesc  : Boolean   read getMagento_PrintNameToShortDesc    Write SetMagento_PrintNameToShortDesc;
      Property Magento_CopyProductinfoToERP  : Boolean   read getMagento_CopyProductinfoToERP    Write SetMagento_CopyProductinfoToERP;

    Published

  end;

implementation

{ TMagentoConfig }

procedure TMagentoConfig.Load(connection: TMyConnection);
begin
  inherited;

end;


procedure TMagentoConfig.Load(ds: TDataset);
begin
  inherited;
end;
constructor TMagentoConfig.Create;
begin
  inherited;
  Auth_token           :='';
  AuthTokenGeneratedAt :=0;
  TokenExpireTime   :=0;
end;

Function TMagentoConfig.GetEnableMagento        : Boolean;begin result := B['EnableMagento']         ;end;
Function TMagentoConfig.GetShowMagentoOnMainMenu: Boolean;begin result := B['ShowMagentoOnMainMenu'] ;end;
Function TMagentoConfig.GetAutosynchList        : Boolean;begin result := B['AutosynchList']         ;end;
function TMagentoConfig.getAPI_Base_URL         : String ;begin result := S['API_Base_URL']          ;end;
function TMagentoConfig.getConsumer_Key         : String ;begin result := S['Consumer_Key']          ;end;
function TMagentoConfig.getConsumer_Secret      : String ;begin result := S['Consumer_Secret']       ;end;
function TMagentoConfig.getAccess_Token         : String ;begin result := S['Access_Token']          ;end;
function TMagentoConfig.getAccess_Token_Secret  : String ;begin result := S['Access_Token_Secret']   ;end;
function TMagentoConfig.getAdminUserName        : String ;begin result := S['AdminUserName']         ;end;
function TMagentoConfig.getCompanyid            : String ;begin result := S['Companyid']             ; if result ='' then Result := 'Magento'; end;
function TMagentoConfig.getAdminPassword        : String ;begin result := S['AdminPassword']         ;end;
function TMagentoConfig.getAuth_token           : String ;begin result := S['Auth_token']            ;end;
function TMagentoConfig.getMagento_SalesType    : String ;begin result := S['Magento_SalesType']     ;if result ='' then result := 'Sales Order'; end;
function TMagentoConfig.getMagento_CustomerID   : String ;begin result := S['Magento_CustomerID']    ;if result ='' then result := 'CustomerName'; end;
function TMagentoConfig.getMagento_ProductName  : String ;begin result := S['Magento_ProductName']   ;if result ='' then result := 'ProductName'; end;
function TMagentoConfig.getMagento_SynchPageSize: Integer;begin result := I['Magento_SynchPageSize'] ;if result = 0 then result := 100; end;
Function TMagentoConfig.GetMagento_PrintNameToShortDesc : Boolean;begin result := B['Magento_PrintNameToShortDesc']         ;end;
Function TMagentoConfig.GetMagento_CopyProductinfoToERP : Boolean;begin result := B['Magento_CopyProductinfoToERP']         ;end;

Procedure TMagentoConfig.SetEnableMagento         (Const Value: Boolean); begin B['EnableMagento']        := Value ; end;
Procedure TMagentoConfig.SetShowMagentoOnMainMenu (Const Value: Boolean); begin B['ShowMagentoOnMainMenu']:= Value ; end;
Procedure TMagentoConfig.SetAutosynchList         (Const Value: Boolean); begin B['AutosynchList']        := Value ; end;
procedure TMagentoConfig.SetAPI_Base_URL          (const Value: String);  begin S['API_Base_URL']         := Value ; end;
procedure TMagentoConfig.SetConsumer_Key          (const Value: String);  begin S['Consumer_Key']         := Value ; end;
procedure TMagentoConfig.SetConsumer_Secret       (const Value: String);  begin S['Consumer_Secret']      := Value ; end;
procedure TMagentoConfig.SetAccess_Token          (const Value: String);  begin S['Access_Token']         := Value ; end;
procedure TMagentoConfig.SetAccess_Token_Secret   (const Value: String);  begin S['Access_Token_Secret']  := Value ; end;
procedure TMagentoConfig.SetAdminUserName         (const Value: String);  begin S['AdminUserName']        := Value ; end;
procedure TMagentoConfig.SetCompanyid             (const Value: String);  begin S['Companyid']            := Value ; end;
procedure TMagentoConfig.SetAdminPassword         (const Value: String);  begin S['AdminPassword']        := Value ; end;
procedure TMagentoConfig.SetAuth_token            (const Value: String);  begin S['Auth_token']           := Value ; end;
procedure TMagentoConfig.SetMagento_SalesType     (const Value: String);  begin S['Magento_SalesType']    := Value ; end;
procedure TMagentoConfig.SetMagento_CustomerID    (const Value: String);  begin S['Magento_CustomerID']   := Value ; end;
procedure TMagentoConfig.SetMagento_ProductName   (const Value: String);  begin S['Magento_ProductName']  := Value ; end;
procedure TMagentoConfig.SetMagento_SynchPageSize (const Value: Integer); begin I['Magento_SynchPageSize']:= Value ; end;
Procedure TMagentoConfig.SetMagento_PrintNameToShortDesc(Const Value: Boolean); begin B['Magento_PrintNameToShortDesc']:= Value ; end;
Procedure TMagentoConfig.SetMagento_CopyProductinfoToERP(Const Value: Boolean); begin B['Magento_CopyProductinfoToERP']:= Value ; end;

end.
