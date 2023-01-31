unit utMagentoService;

interface

uses
  JSONObject, utBaseCoreService;

type
  TMagentoCoreService = class(TBaseCoreService)
  Private
    fAccess_Token_Secret: String;
    fEnableMagento      : Boolean;
    fConsumer_Key       : String;
    fConsumer_Secret    : String;
    fAdminPassword      : String;
    fAutosynchList      : Boolean;
    fAdminUserName      : String;
    fAccess_Token       : String;
    fAPI_Base_URL       : String;
    fCompanyid          : String;
    fiSynchCounter: Integer;
    Function LastMagentoOrderID:Integer;
(*    Function LastMagentoCustomerID:Integer;
    Function LastMagentoProductID:Integer;*)
    Function LastMagentoCustomerCreatedAt:TDateTime;
    Function LastMagentoProductCreatedAt:TDateTime;
  Protected
    procedure InitRequestParams(areq :TJsonObject);override;

  Public
    constructor Create(aCoreEDI: TObject); Override;
    function Initialize: boolean; override;
    Property EnableMagento        : Boolean   Read fEnableMagento          Write fEnableMagento;
    Property AutosynchList        : Boolean   Read fAutosynchList          Write fAutosynchList;
    Property API_Base_URL         : String    Read fAPI_Base_URL           Write fAPI_Base_URL;
    Property Consumer_Key         : String    Read fConsumer_Key           Write fConsumer_Key;
    Property Consumer_Secret      : String    Read fConsumer_Secret        Write fConsumer_Secret;
    Property Access_Token         : String    Read fAccess_Token           Write fAccess_Token;
    Property Access_Token_Secret  : String    Read fAccess_Token_Secret    Write fAccess_Token_Secret;
    Property AdminUserName        : String    Read fAdminUserName          Write fAdminUserName;
    Property AdminPassword        : String    Read fAdminPassword          Write fAdminPassword;
    Property Companyid            : String    Read fCompanyid              Write fCompanyid;
    Property SynchCounter         :Integer    read fiSynchCounter          write fiSynchCounter;
    Class Function Data_DatenTime(Const fdDateTime :TDateTime; const jsnRec:TJsonObject):TDatetime;
    function ExRef_Objtype_MagentoSales: String;
    function SendMagentoDoc(aERPDoc: TJsonObject): boolean;
    Class function GetServiceName: string; override;
  end;

implementation

uses AppEnvironment, LogLib, ErpSynchObj, utCoreEDIConst, MagentoLib,
  BusobjExternalXRef , SysUtils ,dateutils;

{ TMagentoCoreService }

constructor TMagentoCoreService.Create(aCoreEDI: TObject);
begin
  inherited Create(aCoreEDI);
  SynchCounter := 0;
end;

class function TMagentoCoreService.Data_DatenTime(const fdDateTime: TDateTime;  const jsnRec: TJsonObject): TDatetime;
begin
  Result :=fdDateTime;
  try
    if jsnRec.Exists('created_at') then
      if fdDateTime < jsnRec.DT['created_at'] then
        Result:= jsnRec.DT['created_at'];
  Except
    // kill the exception
  end;

  try
    if jsnRec.Exists('updated_at') then
      if fdDateTime < jsnRec.DT['updated_at'] then
        Result := jsnRec.DT['updated_at'];
  Except
    // kill the exception
  end;
end;

Class function TMagentoCoreService.GetServiceName: string;
begin
  Result := Servicename_Magento;
end;

function TMagentoCoreService.Initialize: boolean;
var
  req: TJsonObject;
begin
  Logtext('TMagentoCoreService.Command = Initialize');
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'Initialize';
    InitRequestParams(req);  // binny replacing the following code with this function as it was duplicate code. there are extra json properties in the function
    (*req.O['Params'].B['EnableMagento']      := Appenv.CompanyPrefs.Magentoconfig.EnableMagento           ;
    req.O['Params'].S['CompanyID']          := Appenv.CompanyPrefs.Magentoconfig.CompanyID              ;
    req.O['Params'].B['AutosynchList']      := Appenv.CompanyPrefs.Magentoconfig.AutosynchList           ;
    req.O['Params'].S['API_Base_URL']       := Appenv.CompanyPrefs.Magentoconfig.API_Base_URL           ;
    req.O['Params'].S['Consumer_Key']       := Appenv.CompanyPrefs.Magentoconfig.Consumer_Key           ;
    req.O['Params'].S['Consumer_Secret']    := Appenv.CompanyPrefs.Magentoconfig.Consumer_Secret        ;
    req.O['Params'].S['Access_Token']       := Appenv.CompanyPrefs.Magentoconfig.Access_Token           ;
    req.O['Params'].S['Access_Token_Secret']:= Appenv.CompanyPrefs.Magentoconfig.Access_Token_Secret    ;
    req.O['Params'].S['AdminUserName']      := Appenv.CompanyPrefs.Magentoconfig.AdminUserName          ;
    req.O['Params'].S['AdminPassword']      := Appenv.CompanyPrefs.Magentoconfig.AdminPassword          ;*)
    Logtext('WriteAndWait');

    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;

  EnableMagento        := Appenv.CompanyPrefs.Magentoconfig.EnableMagento          ;
  AutosynchList        := Appenv.CompanyPrefs.Magentoconfig.AutosynchList          ;
  API_Base_URL         := Appenv.CompanyPrefs.Magentoconfig.API_Base_URL           ;
  Consumer_Key         := Appenv.CompanyPrefs.Magentoconfig.Consumer_Key           ;
  Consumer_Secret      := Appenv.CompanyPrefs.Magentoconfig.Consumer_Secret        ;
  Access_Token         := Appenv.CompanyPrefs.Magentoconfig.Access_Token           ;
  Access_Token_Secret  := Appenv.CompanyPrefs.Magentoconfig.Access_Token_Secret    ;
  AdminUserName        := Appenv.CompanyPrefs.Magentoconfig.AdminUserName          ;
  AdminPassword        := Appenv.CompanyPrefs.Magentoconfig.AdminPassword          ;
  Companyid            := Appenv.CompanyPrefs.Magentoconfig.Companyid              ;
  Logtext('TMagentoCoreService Proeprties set fom companyprefs');
end;

procedure TMagentoCoreService.InitRequestParams(areq: TJsonObject);
begin
  inherited;
    areq.O['Params'].B['EnableMagento']         := Appenv.CompanyPrefs.EnableMagento;
    areq.O['Params'].B['AutosynchList']         := True;
    areq.O['Params'].S['API_Base_URL']          := Appenv.CompanyPrefs.Magento_API_Base_URL;
    areq.O['Params'].S['Companyid']             := Appenv.CompanyPrefs.Magento_Companyid;
    areq.O['Params'].S['Consumer_Key']          := Appenv.CompanyPrefs.Magento_Consumer_Key;
    areq.O['Params'].S['Consumer_Secret']       := Appenv.CompanyPrefs.Magento_Consumer_Secret;
    areq.O['Params'].S['Access_Token']          := Appenv.CompanyPrefs.Magento_Access_Token;
    areq.O['Params'].S['Access_Token_Secret']   := Appenv.CompanyPrefs.Magento_Access_Token_Secret;
    areq.O['Params'].S['AdminUserName']         := Appenv.CompanyPrefs.Magento_AdminUserName;
    areq.O['Params'].S['AdminPassword']         := Appenv.CompanyPrefs.Magento_AdminPassword;
    areq.O['Params'].I['SynchPageSize']         := Appenv.CompanyPrefs.Magento_SynchPageSize;
    areq.O['Params'].I['LastMagentoOrderID']    := LastMagentoOrderID     ;

    areq.O['Params'].DT['LastMagentoCustomerCreatedAt'] := LastMagentoCustomerCreatedAt  ;
    areq.O['Params'].DT['LastMagentoProductCreatedAt']  := LastMagentoProductCreatedAt   ;
    log('Checking for  Magento :' + areq.O['Params'].asString);
         if areq.O['Params'].S['QueryParams']  = GetData_Req_Type_SynchOrders    then log(' from ' + inttostr(areq.O['Params'].I['LastMagentoOrderID'] ))
    else if areq.O['Params'].S['QueryParams']  = GetData_Req_Type_SynchCustomers then log(' from ' + FormatDatetime(FormatSettings.shortdateFormat  +' HH:nn:ss AP/PM' , areq.O['Params'].DT['LastMagentoCustomerCreatedAt'] ))
    else if areq.O['Params'].S['QueryParams']  = GetData_Req_Type_SynchProducts  then log(' from ' + FormatDatetime(FormatSettings.shortdateFormat  +' HH:nn:ss AP/PM' , areq.O['Params'].DT['LastMagentoProductCreatedAt']  ));
end;
Function TMagentoCoreService.LastMagentoOrderID:Integer;
begin
  Result := TExternalXRef.LastExRefID(ServiceName ,ExRef_Objtype_MagentoSales , nil , (SynchCounter=0));
end;
(*Function TMagentoCoreService.LastMagentoCustomerID:Integer;
begin
  Result := TExternalXRef.LastExRefID(ServiceName ,ExRef_Objtype_Customer);
end;
Function TMagentoCoreService.LastMagentoProductID:Integer;
begin
  Result := TExternalXRef.LastExRefID(ServiceName ,ExRef_Objtype_Product);
end;*)
function TMagentoCoreService.SendMagentoDoc(aERPDoc: TJsonObject): boolean;
begin
  result := AddERPObject(aERPDoc);
end;

Function TMagentoCoreService.ExRef_Objtype_MagentoSales:String;
begin
  if Appenv.CompanyPrefs.IsMagentoSalestypeSO then result := ExRef_Objtype_SalesOrder else result := ExRef_Objtype_Invoice;
end;
Function TMagentoCoreService.LastMagentoCustomerCreatedAt:TDateTime;
begin
  Result := TExternalXRef.LastExRefDate(ServiceName ,ExRef_Objtype_Customer , 'ExternalTimeStamp');
  Result := incSecond(result,1);
  logtext('LastMagentoCustomerCreatedAt :' + formatdatetime('dd-mm-yyyy hh:nn:ss am/pm', result));
end;
Function TMagentoCoreService.LastMagentoProductCreatedAt:TDateTime;
begin
  Result := TExternalXRef.LastExRefDate(ServiceName ,ExRef_Objtype_Product , 'ExternalTimeStamp');
  Result := incSecond(result,1);
  logtext('LastMagentoProductCreatedAt :' + formatdatetime('dd-mm-yyyy hh:nn:ss am/pm', result));
end;

end.
