unit VS1Lib;

interface

uses JSONObject , classes,VS1_RegonLicense, BusObjVS1_Cloud, BusObjBase , WebAPILib;

Function NewcloudDBName(IsSampleDB:Boolean; JustPrefix:boolean):String;
function DropDatabase(aVS1_Database : TVS1_Databases;aDBNameToDrop, aAdminDB, aAdminUser, aAdminPass:String):Boolean;Overload;
function DropDatabase(IsHttps:Boolean; APIPort:Integer; ServerName,aDBNameToDrop, aAdminDB, aAdminUser, aAdminPass:String):Boolean;Overload;
Function MakeNewdatabseForRegion(aVS1_Rego:TVS1_Rego;var JsResultStr:String;IsSampleDB:Boolean; var fsdbname, fsservername:String) :Boolean;Overload;
Function ClientEmployeeID(aVS1_Database : TVS1_Databases;Params :TJsonObject;var JsResultStr:String; Readforname:Boolean = False):Integer;
Function ClientEmployeeAccessLevel(aVS1_ClientUsers :TVS1_ClientUsers; var JsResultStr:String; aOnEvent:TEventProc):boolean;
Function MakeUSer(aVS1_Database : TVS1_Databases;aEmployeeID:Integer;aEmployeeLogonName,aEmployeeLogonPassword,aDatabaseName,aUserName,aPassword:String):Integer;
Function MakeInvoice(aconn : TMydacdataconnection; aPaymentamount:Double;aVS1_Clients:TVS1_Clients; acomments :String; amoduleID,aclientModuleID:Integer; aDateFrom:TDateTime; var fsMsg:String; aOnEvent:TEventProc;jsModules:TJsonObject;AdjustmentExtension:Boolean=False;ExtensionDesc:String='') :Integer;
function MakePayment(aconn : TMydacdataconnection; aVS1_Clients:TVS1_Clients;fiInvoiceID:Integer; (*aDiscountedPrice, *)aPaymentamount:Double;aPayMethod :String ; var fsMsg:String; aOnEvent:TEventProc; var fiCustpaymentID:Integer ; var fiCustPrepaymentID:Integer):Integer;
function WebAPIURL(IsHttps:Boolean; APIPort:Integer; ServerName:String; ERPClassname: String): String;

implementation

uses  sysutils, DateUtils,
  WebApiConst, BusObjRegionalOptions, utVS1Const, CommonLib, dialogs,
  RandomUtils, BusObjSales, tcConst, BusObjPayments,
  busobjPrepayments, Variants , AppEnvironment, math, utCloudconst, cloudLib,
  LogLib;

function WebAPIURL(IsHttps:Boolean; APIPort:Integer; ServerName:String;ERPClassname: String): String;
begin
  Result := '';
  if IsHttps then Result := 'https' else Result := 'http';
  Result := Result + '://' + ServerName + ':' + IntTostr(APIPort) + '/erpapi';
  if ERPClassname <> '' then Result := Result + '/' + ERPClassname;

end;

Function NewcloudDBName(IsSampleDB:Boolean; JustPrefix:boolean):String;
begin
  if IsSampleDB then
    Result := ERP_API_DB_PREFIX + 'SampleDB_'
  else Result := ERP_API_DB_PREFIX + 'DB_' ;

  if not JustPrefix then
    Result := Result + CharDate + '_' + MakeRandomString(6);
end;

Function ClientEmployeeAccessLevel(aVS1_ClientUsers :TVS1_ClientUsers; var JsResultStr:String; aOnEvent:TEventProc):boolean;
var
   fsURL :String;
   js, jsa:TJSONObject;
   jsERPForms, jsaERPForm:TJSONObject;
   fiEmployeeID:Integer;
   ctr:Integer;
   fbHasNoAccess:boolean;
begin
  result := False;
  fiEmployeeID := 0;
  JsResultStr := '';
  fbHasNoAccess:=False;
  //if aVS1_ClientUsers.VS1_Client.vs1_clientdbserver.Count = 0  then Exit;

  //fsURL:=aVS1_ClientUsers.VS1_Client.vs1_clientdbserver.WebAPIURL(TASK_VS1_Dashboard);
  fsURL:=aVS1_ClientUsers.VS1_Client.WebAPIURL(TASK_VS1_Dashboard);
  if DoHTTPGET(fsURL,
               aVS1_ClientUsers.VS1_Client.DatabaseName,
               aVS1_ClientUsers.EmailId,
               aVS1_ClientUsers.Password,
               JsResultStr) then begin
    AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel:' + JsResultStr);
    result := True;
  end else begin
     AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel Failed: ' + JsResultStr);
  end;



(*  fsURL:=aVS1_ClientUsers.VS1_Client.vs1_clientdbserver.WebAPIURL(VS1_Class_User+'?SELECT=['+VS1_TAG_Logon_name+'] ="'+ aVS1_ClientUsers.EmailId+'"'+
                                                                                                        '&PropertyList=EmployeeId,EmployeeName');
  //AddEventdata(aOnEvent ,'URL'     , 'ClientEmployeeAccessLevel-1: ' + fsURL);
  if DoHTTPGET(fsURL,
               aVS1_ClientUsers.VS1_Client.DatabaseName,
               aVS1_ClientUsers.EmailId,
               aVS1_ClientUsers.Password,
               JsResultStr) then begin
    AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel : ' +JsResultStr);
    js:= Jo;
    try
      js.AsString := JsResultStr;
      if js.Exists(VS1_Class_User) then
        if js.A[VS1_Class_User].Count>0 then begin
          //fiEmployeeID :=TjsonObject(js.A[VS1_Class_User].items[0]).I[VS1_TAG_ID];
          fiEmployeeID :=TjsonObject(js.A[VS1_Class_User].items[0]).I[VS1_TAG_EmployeeId];
        end;
    finally
      js.Free;
    end;
  end else begin
     AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel Failed: ' +JsResultStr);
  end;
  AddEventdata(aOnEvent ,'Employeeid'     , '= '+ inttostr(fiEmployeeID));

  if fiEmployeeID =0  then begin
    exit;
  end;

  JsResultStr := '';
  fsURL:=aVS1_ClientUsers.VS1_Client.vs1_clientdbserver.WebAPIURL(VS1_Class_EmployeeFormAccessDt+'?SELECT=['+VS1_TAG_EmployeeId+'] ='+ inttostr(fiEmployeeID)+
                                                                                                        ' and ['+VS1_TAG_TabGroup+']=26'+
                                                                                                        '&PropertyList=FormId,EmployeeId,FormName,Description,TabGroup,IsForm,AccessLevels,SkinsGroup,AccessLevel,AccessLevelName');
  //AddEventdata(aOnEvent ,'URL'     , 'ClientEmployeeAccessLevel-2: ' + fsURL);
  if DoHTTPGET(fsURL,
               aVS1_ClientUsers.VS1_Client.DatabaseName,
               aVS1_ClientUsers.EmailId,
               aVS1_ClientUsers.Password,
               JsResultStr) then begin
    //AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel-2 : ' +JsResultStr);
    js:= Jo;
    try
      js.AsString := JsResultStr;
      //AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel-2 : ' +inttostr(js.A[VS1_Class_EmployeeFormAccessDt].Count));
      if js.A[VS1_Class_EmployeeFormAccessDt].count =0 then begin
        fbHasNoAccess:=true;
      end else begin
        Result := True;
      end;
    finally
      js.Free;
    end;
  end else begin
    //AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel-2 Failed: ' +JsResultStr);
  end;

  //employee has no access - then add access for dashboard

  if fbHasNoAccess then begin
        JsResultStr := '';
        fsURL:=aVS1_ClientUsers.VS1_Client.vs1_clientdbserver.WebAPIURL(VS1_Class_TERPForm+'?SELECT=['+VS1_TAG_TabGroup+']=26'+
                                                                                                              '&PropertyList=FormId,FormName,Description,TabGroup,IsForm,AccessLevels,SkinsGroup');
        //AddEventdata(aOnEvent ,'URL'     , 'ClientEmployeeAccessLevel-2: ' + fsURL);
        if DoHTTPGET(fsURL,
                     aVS1_ClientUsers.VS1_Client.DatabaseName,
                     aVS1_ClientUsers.EmailId,
                     aVS1_ClientUsers.Password,
                     JsResultStr) then begin
          js:= Jo;
          jsERPForms:= jo;
          try
            js.AsString := JsResultStr;
            //AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel-2 : ' +inttostr(js.A[VS1_Class_TERPForm].Count));
            if js.A[VS1_Class_TERPForm].count =0 then begin
            end else begin
              for ctr:= 0 to js.A[VS1_Class_TERPForm].count-1 do begin
                jsaERPForm := JO;
                jsaERPForm.I[VS1_TAG_EmployeeId]  := fiEmployeeID;
                jsa :=js.A[VS1_Class_TERPForm].items[ctr].AsObject;
                jsaERPForm.I[VS1_TAG_FormID]      := jsa.I[VS1_TAG_FormID];
                jsaERPForm.S[VS1_TAG_FormName]    := jsa.S[VS1_TAG_FormName];
                jsaERPForm.S[VS1_TAG_Description] := jsa.S[VS1_TAG_Description];
                jsaERPForm.I[VS1_TAG_TabGroup]    := jsa.I[VS1_TAG_TabGroup];
                jsaERPForm.B[VS1_TAG_IsForm]      := jsa.B[VS1_TAG_IsForm];
                jsaERPForm.B[VS1_TAG_AccessLevels]:= jsa.B[VS1_TAG_AccessLevels];
                jsaERPForm.S[VS1_TAG_SkinsGroup] := jsa.S[VS1_TAG_SkinsGroup];
                if sametext(jsaERPForm.S[VS1_TAG_FormName] , 'FnCloudDashboard') or
                   sametext(jsaERPForm.S[VS1_TAG_FormName] , 'FnMobSales') then begin
                  jsaERPForm.I['AccessLevel'] :=1;
                  jsaERPForm.S['AccessLevelName'] := ACC_LVL_MSG_1;
                end else begin
                  jsaERPForm.I['AccessLevel'] :=0;
                  jsaERPForm.S['AccessLevelName'] := ACC_LVL_MSG_6;
                end;
                jsERPForms.A[VS1_Class_EmployeeFormAccessDt].add(jsaERPForm)
              end;
              JsResultStr :=jsERPForms.asString;
              Result := True;
            end;
          finally
            js.Free;
            jsERPForms.Free;
          end;
        end else begin
          //AddEventdata(aOnEvent ,'Result'     , 'ClientEmployeeAccessLevel-2 Failed: ' +JsResultStr);
        end;
  end;*)
end;

Function MakeUSer(aVS1_Database : TVS1_Databases;aEmployeeID:Integer;aEmployeeLogonName,aEmployeeLogonPassword,aDatabaseName,aUserName,aPassword:String):Integer;
var
   jsRequest, ajs :TJSONObject;
   fsURL, JsResultStr:String;
begin
  jsRequest:= jo;
  try
        jsRequest.S[VS1_TAG_type] := VS1_Class_User;
        jsRequest.O[VS1_TAG_Fields].I[VS1_TAG_EmployeeID]:=aEmployeeId;
        jsRequest.O[VS1_TAG_Fields].B[VS1_TAG_VS1User] := True;
        jsRequest.O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := aEmployeeLogonName;
        jsRequest.O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := aEmployeeLogonPassword;
        fsURL:=aVS1_Database.WebAPIURL(VS1_Class_User);
        if  DoHTTPGet(fsURL+'?Logon_name='+quotedstr(aEmployeeLogonName),
                       aDatabaseName,
                       aUserName,
                       aPassword,
                       JsResultStr)  then begin
            ajs:= Jo;
            try
              ajs.AsString := JsResultStr;
              if ajs.Exists(VS1_Class_User) then
                if ajs.A[VS1_Class_User].Count>0 then begin
                  result :=TjsonObject(ajs.A[VS1_Class_User].items[0]).I[VS1_TAG_ID];
                  jsRequest.O[VS1_TAG_Fields].I[VS1_TAG_ID] := result;
                end;
            finally
              ajs.Free;
            end;

        end;

        if  DoHTTPPost(fsURL,
                       aDatabaseName,
                       aUserName,
                       aPassword,
                       jsRequest,
                       JsResultStr) =VS1_HTTP_Success_Code then begin
            if jsRequest.Exists(VS1_TAG_type) and sametext(jsRequest.S[VS1_TAG_type], VS1_Class_User) then
                if jsRequest.Exists(VS1_TAG_Fields) then
                  result :=jsRequest.O[VS1_TAG_Fields].I[VS1_TAG_ID];

        end;
  finally
    jsRequest.Free;
  end;
end;

Function ClientEmployeeID(aVS1_Database: TVS1_Databases; Params: TJsonObject; var JsResultStr: String; Readforname: Boolean = False): Integer;
var
  fsURL: String;
  jsRequest, jsparam: TJSONObject;
  aUserName, aPassword: String;
begin
  Result := 0;

  if not Params.Exists(VS1_TAG_EmployeeDetails) then Exit;

  jsparam := JO(Params.O[VS1_TAG_EmployeeDetails].AsString);
  if Params.Exists(VS1_TAG_ModuleName) and (SameText(Params.S[VS1_TAG_ModuleName], VS1_Module_Add_Extra_User)) then begin
    (*jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := Params.S[VS1_TAG_VS1UserName];
    jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := Params.S[VS1_TAG_VS1Password];*)
    aUserName:= Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName];
    aPassword:= Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPPassword];

(*  // link to external database
  end else if Params.Exists(VS1_TAG_VS1UserName) then begin
          aUserName:= Params.S[VS1_TAG_VS1UserName];
          aPassword:= Params.S[VS1_TAG_VS1Password];*)
  end else begin
    (*jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName];//Params.S[VS1_TAG_VS1UserName];
    jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_NewPassword];//Params.S[VS1_TAG_VS1Password];*)
    aUserName := Params.S[VS1_TAG_VS1UserName];
    aPassword := Params.S[VS1_TAG_VS1Password];
  end;

  if Readforname then begin
    if not jsparam.O[VS1_TAG_Fields].Exists(VS1_TAG_Middlename) then jsparam.O[VS1_TAG_Fields].S[VS1_TAG_Middlename] := '';
    if not(jsparam.Exists(VS1_TAG_firstname)) or not(jsparam.Exists(VS1_TAG_lastname)) or not(Params.Exists(VS1_TAG_ERPLoginDetails)) then Exit;
    if not(jsparam.Exists(VS1_TAG_EmployeeName)) then jsparam.S[VS1_TAG_EmployeeName] := Trim(jsparam.S[VS1_TAG_firstname]) + ' ' + Trim(jsparam.S[VS1_TAG_lastname]);

    fsURL := aVS1_Database.WebAPIURL(VS1_Class_Employee + '?SELECT=[Firstname]="'+ Trim(jsparam.S[VS1_TAG_firstname]) + '"' +
                                                         iif(trim(jsparam.S[VS1_TAG_Middlename])<> '', ' AND [Middlename]="' + Trim(jsparam.S[VS1_TAG_Middlename]) + '"', '') +
                                                         ' AND [Lastname]="' + Trim(jsparam.S[VS1_TAG_lastname]) + '"');

    if DoHTTPGET(fsURL,
                 Params.S[VS1_TAG_DatabaseName],
                 aUserName,
                 aPassword,
                 JsResultStr) then begin
      jsRequest := JO;
      try
        jsRequest.AsString := JsResultStr;
        if jsRequest.Exists(VS1_Class_Employee) then
          if jsRequest.A[VS1_Class_Employee].Count > 0 then begin
            Result := TjsonObject(jsRequest.A[VS1_Class_Employee].items[0]).I[VS1_TAG_ID];
            if jsparam.Exists(TAG_ERPUserName) then begin
              try MakeUSer(aVS1_Database, result, jsparam.S[TAG_ERPUserName], jsparam.S[TAG_ERPPassword], Params.S[VS1_TAG_DatabaseName], aUserName, aPassword); Except end;
            end;
            if Params.Exists(VS1_TAG_ModuleName) and (SameText(Params.S[VS1_TAG_ModuleName], VS1_Module_Add_Extra_User)) then begin
              //try MakeUSer(aVS1_Database, result ,  jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName], jsparam.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword],Params.S[VS1_TAG_DatabaseName],aUserName,aPassword); Except end;
              try MakeUSer(aVS1_Database, result,  Params.S[VS1_TAG_VS1UserName], Params.S[VS1_TAG_VS1Password], Params.S[VS1_TAG_DatabaseName], aUserName, aPassword); Except end;
            end;
          end;
      finally
        jsRequest.Free;
      end;
    end else begin
      Result := 0;
    end;
  end else begin
    jsRequest := JO;
    try
      jsRequest.S[VS1_TAG_type] := VS1_Class_Employee;
      jsRequest.O[VS1_TAG_Fields]:= JO(jsparam.AsString);
      if jsRequest.O[VS1_TAG_Fields].Exists(VS1_TAG_firstname)   then
        if not jsRequest.O[VS1_TAG_Fields].Exists(VS1_TAG_Middlename) then jsRequest.O[VS1_TAG_Fields].S[VS1_TAG_Middlename] := '';
      if jsRequest.O[VS1_TAG_Fields].Exists(VS1_TAG_firstname)     and (jsRequest.O[VS1_TAG_Fields].s[VS1_TAG_firstname]    = VS1_STRVALUE_TO_IGNORE) then jsRequest.O[VS1_TAG_Fields].delete(VS1_TAG_firstname);
      if jsRequest.O[VS1_TAG_Fields].Exists(VS1_TAG_lastname)      and (jsRequest.O[VS1_TAG_Fields].s[VS1_TAG_lastname]     = VS1_STRVALUE_TO_IGNORE) then jsRequest.O[VS1_TAG_Fields].delete(VS1_TAG_lastname);
      if jsRequest.O[VS1_TAG_Fields].Exists(VS1_TAG_EmployeeName)  and (jsRequest.O[VS1_TAG_Fields].s[VS1_TAG_EmployeeName] = VS1_STRVALUE_TO_IGNORE) then jsRequest.O[VS1_TAG_Fields].delete(VS1_TAG_EmployeeName);

      jsRequest.O[VS1_TAG_Fields].O['User'].S[VS1_TAG_type] := VS1_Class_User;
      jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields]:= JO;
      jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].B[VS1_TAG_VS1User] := True;
      if jsparam.Exists(TAG_ERPUserName) then begin
        jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := jsparam.S[TAG_ERPUserName];
        jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := Params.S[TAG_ERPPassword];
      end else if Params.Exists(VS1_TAG_ERPLoginDetails) and  Params.O[VS1_TAG_ERPLoginDetails].Exists(TAG_ERPUserName) and Params.O[VS1_TAG_ERPLoginDetails].Exists(VS1_TAG_NewPassword) and (Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_NewPassword] <>'') and
        params.O[VS1_TAG_EmployeeDetails].Exists('ID') and (params.O[VS1_TAG_EmployeeDetails].I['ID'] <> 0)  then begin
        (*jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName];
        jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_NewPassword];*)
        result:=params.O[VS1_TAG_EmployeeDetails].I['ID'];
        try MakeUSer(aVS1_Database, result, params.O[VS1_tag_erpLoginDetails].S[TAG_ERPUSERNAME], params.O[VS1_tag_erpLoginDetails].S[VS1_TAG_NewPassword],Params.S[VS1_TAG_DatabaseName],aUserName,aPassword); Except end;
        Exit;
      end else begin
        jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonName] := Params.S[VS1_TAG_VS1UserName];
        jsRequest.O[VS1_TAG_Fields].O['User'].O[VS1_TAG_Fields].S[VS1_TAG_LogonPassword] := Params.S[VS1_TAG_VS1Password];
      end;

      fsURL := aVS1_Database.(*vs1_clientdbserver.*)WebAPIURL(VS1_Class_Employee);

      if jsRequest.O[VS1_TAG_Fields].Exists(TAG_ERPUserName)  then jsRequest.O[VS1_TAG_Fields].delete(TAG_ERPUserName);
      if jsRequest.O[VS1_TAG_Fields].Exists(TAG_ERPPassword)  then jsRequest.O[VS1_TAG_Fields].delete(TAG_ERPPassword);

      if  DoHTTPPost(fsURL,
                     Params.S[VS1_TAG_DatabaseName],
                     aUserName,
                     aPassword,
                     jsRequest,
                     JsResultStr) =VS1_HTTP_Success_Code then begin
          jsRequest.AsString := JsResultStr;
          if jsRequest.Exists(VS1_TAG_type) and sametext(jsRequest.S[VS1_TAG_type], VS1_Class_Employee) then
              if jsRequest.Exists(VS1_TAG_Fields) then
                Result := jsRequest.O[VS1_TAG_Fields].I[VS1_TAG_ID];
      end else begin
        if not (Params.O[VS1_TAG_ERPLoginDetails].Exists(VS1_TAG_NewPassword)) or (Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_NewPassword] ='') then
          Result := ClientEmployeeID(aVS1_Database,Params,JsResultStr, true)
        else Result := 0;
      end;
    finally
      jsRequest.Free;
    end;
  end;
end;

function DropDatabase(IsHttps:Boolean; APIPort:Integer; ServerName,aDBNameToDrop, aAdminDB, aAdminUser, aAdminPass:String):Boolean;
var
   fsURL :String;
   JsVS1DBDrop:TJSONObject;
   JsResultStr:String;
begin
  Result := False;
  JsVS1DBDrop:= Jo;
  try
    JsVS1DBDrop.S['Name']:= 'DropDatabase';
    JsVS1DBDrop.O[TAG_CLOUD_Params].S[VS1_TAG_DatabaseName]:= aDBNameToDrop;
    //JsVS1DBDrop.S[VS1_TAG_DatabaseName]:= aDBNameToDrop;
    //fsURL:=aVS1_Database.WebAPIURL('system/method?Name="DropDatabase"');
    fsURL:=WebAPIURL(IsHttps, APIPort, Servername, 'system/method?Name="DropDatabase"');
    if  DoHTTPPost(fsURL, aAdminDB, aAdminUser,aAdminPass, JsVS1DBDrop,JsResultStr) =VS1_HTTP_Success_Code then begin
          Result := True;
          Exit;
    end else begin
        REsult := False;
    end;
  finally
    JsVS1DBDrop.Free;
  end;

end;

function DropDatabase(aVS1_Database : TVS1_Databases;aDBNameToDrop, aAdminDB, aAdminUser, aAdminPass:String):Boolean;
begin
  REsult := DropDatabase(aVS1_Database.IsHttps, aVS1_Database.APIPort, aVS1_Database.Servername,aDBNameToDrop, aAdminDB, aAdminUser, aAdminPass);
(*var
   fsURL :String;
   JsVS1DBDrop:TJSONObject;
   JsResultStr:String;
begin
  Result := False;
  JsVS1DBDrop:= Jo;
  try
    JsVS1DBDrop.S['Name']:= 'DropDatabase';
    JsVS1DBDrop.S[VS1_TAG_DatabaseName]:= aDBNameToDrop;
    fsURL:=aVS1_Database.WebAPIURL('system/method?Name="DropDatabase"');
    if  DoHTTPPost(fsURL, aAdminDB, aAdminUser,aAdminPass, JsVS1DBDrop,JsResultStr) =VS1_HTTP_Success_Code then begin
          Result := True;
          Exit;
    end;
  finally
    JsVS1DBDrop.Free;
  end;*)

end;

function MakeNewdatabseForRegion(aVS1_Rego: TVS1_Rego; var JsResultStr: String; IsSampleDB: Boolean; var fsDbName, fsServerName: String):Boolean;
var
  fsURL: String;
  JsVS1DBcreate: TJSONObject;
begin
  fsDbName := NewcloudDBName(IsSampleDB, False);

  JsVS1DBcreate := JO;
  try
    JsVS1DBcreate.S['Name'] := 'CreateDatabase';
    JsVS1DBcreate.S[VS1_TAG_DatabaseName] := fsDbName;
    JsVS1DBcreate.S[VS1_TAG_RegionName] := aVS1_Rego.RegionName;
    JsVS1DBcreate.B[VS1_TAG_IsVS1Database] := True;
    aVS1_Rego.Vs1_RegoJson(JsVS1DBcreate);
    //JsVS1DBcreate.O['Vs1_Reg']:= jo(aVS1_Rego.Vs1_RegoJson);
    fsservername := aVS1_Rego.VS1_ClientDbServers.ServerName;
    fsURL := aVS1_Rego.VS1_ClientDbServers.WebAPIURL('system/method?Name="CreateDatabase"');
    if DoHTTPPost(fsURL, aVS1_Rego.VS1_ClientDbServers.AdminDB, aVS1_Rego.VS1_ClientDbServers.AdminUser, aVS1_Rego.VS1_ClientDbServers.AdminPass, JsVS1DBcreate, JsResultStr) = VS1_HTTP_Success_Code then begin
      Result := True;
      Exit;
    end;
  finally
    JsVS1DBcreate.Free;
  end;
end;

function MakeInvoice(aconn: TMydacdataconnection; aPaymentamount:Double;aVS1_Clients:TVS1_Clients; acomments: String; amoduleID, aclientModuleID:Integer; aDateFrom:TDateTime; var fsMsg:String; aOnEvent:TEventProc;jsModules:TJsonObject;AdjustmentExtension:Boolean=False;ExtensionDesc: String=''): Integer;
var
  Invoice :TInvoice;
  ctr:Integer;

  procedure UpdatePricefromRenewalJson(fiModuleID: Integer);
  var
    fi:Integer;
    fbPricechanged :Boolean;
    fbFound:boolean;
  begin
      if jsModules = nil then exit;
      if not jsModules.exists(VS1_TAG_Modules) then exit;
      fbPricechanged := False;
      fbFound := False;
      for fi := 0 to jsModules.A[VS1_TAG_Modules].Count-1 do begin
        if TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).I[VS1_TAG_ModuleID] = fiModuleID then begin
            fbFound:= True;
            if Invoice.ForeignExchangeCode = Appenv.RegionalOptions.ForeignExDefault then begin
                if not(Samevalue(Invoice.Lines.LinePriceinc , TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice])) then begin
                  if TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice] =0 then begin
                    Invoice.Lines.Deleted := true;
                  end else begin
                    Invoice.Lines.LinePriceinc := TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice];
                    fbPricechanged := True;
                  end;
                end;
            end else begin
                if not(Samevalue(Invoice.Lines.ForeignLinePrice , TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice])) then begin
                  if TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice] =0 then begin
                    Invoice.Lines.Deleted := true;
                  end else begin
                    Invoice.Lines.ForeignLinePrice := TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).F[VS1_TAG_DiscountedPrice];
                    fbPricechanged := True;
                  end;
                end;
            end;
            if fbPricechanged  and (trim(TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).S[VS1_TAG_PriceDescription]) <> '') then
              Invoice.Lines.ProductDescription:= trim(trim(TjsonObject(jsModules.A[VS1_TAG_Modules].Items[fi]).S[VS1_TAG_PriceDescription]) + NL+trim(Invoice.Lines.ProductDescription));
            break;
        end;
      end;
      if not fbFound then begin
        // renewal - this module is already Paid
        Invoice.Lines.LinePriceinc := 0;
        Invoice.Lines.Deleted := True;
      end;
  end;
begin
   aConn.beginnestedTransaction;
   try
          AddEventdata(aOnEvent,VS1_TAG_Invoice,aVS1_Clients.ClientName );
          Invoice := TInvoice.create(aVS1_Clients)       ;
          try
            Invoice.connection       := aconn;
            Invoice.Load(0);
            Invoice.IgnoreAccesslevel := true;
            Invoice.SilentMode := true;
            Invoice.New;

            //Invoice.ClientID         := Customer.ID;
            Invoice.CustomerName     := aVS1_Clients.ClientName;
            AddEventdata(aOnEvent,VS1_TAG_Invoice,Invoice.CustomerName +', ' + inttostr(Invoice.ClientID));
            Invoice.ForeignExchangeCode := aVS1_Clients.ForeignExchangeCode(*aVS1_Clients.RegionalOption.ForeignExDefault*);
            Invoice.SaleClassId         := aVS1_Clients.RegionalOption.DeptClassID;
            Invoice.SaleDate  := aDateFrom;
            Invoice.TermsName := TERMS_ON_RCPT;
            Invoice.Duedate   := aDateFrom;
            Invoice.comments := acomments ;
            Invoice.PostDB;
            AddEventdata(aOnEvent,VS1_TAG_Invoice,Invoice.CustomerName +', ' + inttostr(Invoice.ClientID));
            aVS1_Clients.ClientModules.First;
            if (amoduleID=0) then begin
              if aVS1_Clients.ClientModules.Locate('ModuleId',0,[]) then begin
                Invoice.Lines.New;
                with aVS1_Clients.ClientModules.Product do begin
                  //Invoice.Lines.ProductId := ID;
                  Invoice.Lines.ProductName := ProductName;
                end;
                Invoice.Lines.QtySold := 1*aVS1_Clients.LicenseMonths;
                Invoice.Lines.QtyShipped := 1*aVS1_Clients.LicenseMonths;
                if aVS1_Clients.ClientModules.DiscountedPrice =0 then begin
                  Invoice.Lines.LinePriceinc        := 0;
                  Invoice.Lines.OriginalLinePrice   := 0;
                  Invoice.Lines.ForeignLinePrice    := 0;
                end else if Invoice.ForeignExchangeCode = Appenv.RegionalOptions.ForeignExDefault then begin
                  Invoice.Lines.LinePriceinc :=aVS1_Clients.ClientModules.DiscountedPrice;
                end else begin
                  Invoice.Lines.ForeignLinePrice :=aVS1_Clients.ClientModules.DiscountedPrice;
                end;
                Invoice.Lines.ProductDescription := aVS1_Clients.ClientModules.Discountdescription;
                UpdatePricefromRenewalJson(aVS1_Clients.ClientModules.ID);
                Invoice.Lines.PostDB;
              end;
            end;
            aVS1_Clients.ClientModules.First;
            while aVS1_Clients.ClientModules.Eof =  False do begin
              if ((amoduleID =0) and (aVS1_Clients.ClientModules.ModuleId<>0)) or
                  ((amoduleID<>0) and (aVS1_Clients.ClientModules.ModuleId =amoduleID) and (aclientModuleID<>0) and (aclientModuleID = aVS1_Clients.ClientModules.ID))  then begin
                Invoice.Lines.New;
                with aVS1_Clients.ClientModules.Product do begin
                  //Invoice.Lines.ProductId := ID;
                  Invoice.Lines.ProductName := ProductName;
                end;
                Invoice.Lines.QtySold := 1*aVS1_Clients.LicenseMonths;
                Invoice.Lines.QtyShipped := 1*aVS1_Clients.LicenseMonths;
                if aVS1_Clients.ClientModules.DiscountedPrice =0 then begin
                  Invoice.Lines.LinePriceinc :=0;
                end else if Invoice.ForeignExchangeCode = Appenv.RegionalOptions.ForeignExDefault then begin
                  Invoice.Lines.LinePriceinc :=aVS1_Clients.ClientModules.DiscountedPrice;
                end else begin
                  Invoice.Lines.ForeignLinePrice :=aVS1_Clients.ClientModules.DiscountedPrice;
                end;
                Invoice.Lines.ProductDescription := aVS1_Clients.ClientModules.Discountdescription;
                UpdatePricefromRenewalJson(aVS1_Clients.ClientModules.ID);
                Invoice.Lines.PostDB;
                if amoduleID <> 0 then break;// only one module
              end;
              aVS1_Clients.ClientModules.Next;
            end;
            Invoice.PostDB;
            Invoice.CalcOrdertotals;
            Invoice.PostDB;
            AddEventdata(aOnEvent,VS1_TAG_Invoice,Invoice.CustomerName +', ' + inttostr(Invoice.ClientID));

              {Free extension from Headoffice}
              if AdjustmentExtension and (Invoice.Lines.count>0) then begin
                if Invoice.Totalamountinc-aPaymentamount <> 0 then begin

                  Invoice.InitToNoTax; // Free adjustment  has no tax

                  Invoice.Lines.New;
                  Invoice.Lines.Productname := PART_MEMO;
                  Invoice.Lines.ProductDescription := ExtensionDesc;
                  Invoice.Lines.QtySold := 1;
                  Invoice.Lines.QtyShipped := 1;
                  if Invoice.ForeignExchangeCode =  Appenv.RegionalOptions.ForeignExDefault then
                        Invoice.Lines.LinePriceinc     := Round(0-(Invoice.Totalamountinc-aPaymentamount),CurrencyRoundPlaces)
                  else  Invoice.Lines.ForeignLinePrice := Round(0-(Invoice.ForeignTotalAmount-aPaymentamount),CurrencyRoundPlaces);
                  Invoice.Lines.PostDB;
                  Invoice.Lines.CalcLineTotals;
                  Invoice.Lines.PostDB;
                  Invoice.CalcOrdertotals;
                  Invoice.PostDB;
                end;
              end;
              {if the total amount paid doesn't match with the sum of module prices}
              if  ((Invoice.ForeignExchangeCode =  Appenv.RegionalOptions.ForeignExDefault) and not(Samevalue(aPaymentamount, Invoice.Totalamountinc    ))) OR
                  ((Invoice.ForeignExchangeCode <> Appenv.RegionalOptions.ForeignExDefault) and not(Samevalue(aPaymentamount, Invoice.ForeignTotalAmount))) then begin
                  Invoice.Lines.New;
                  Invoice.Lines.Productname := PART_MEMO;
                  Invoice.Lines.ProductDescription := 'Amount Variance Adjustment';
                  Invoice.Lines.QtySold := 1;
                  Invoice.Lines.QtyShipped := 1;
                  if Invoice.ForeignExchangeCode =  Appenv.RegionalOptions.ForeignExDefault then
                        Invoice.Lines.LinePriceinc     :=Round(aPaymentamount-Invoice.Totalamountinc,CurrencyRoundPlaces)
                  else  Invoice.Lines.ForeignLinePrice :=Round(aPaymentamount-Invoice.ForeignTotalAmount,CurrencyRoundPlaces);
                  Invoice.Lines.PostDB;
                  Invoice.Lines.CalcLineTotals;
                  Invoice.Lines.PostDB;
                  Invoice.CalcOrdertotals;
                  Invoice.PostDB;
              end;

            AddEventdata(aOnEvent,VS1_TAG_Invoice,'lines.count :' + inttostr(Invoice.Lines.count));
            if not Invoice.ValidateData then begin
              fsMsg :=  'Failed to Validate Invoice :' + Invoice.REsultStatus.Allmessages;
              AddEventdata(aOnEvent,VS1_TAG_Invoice,'Failed to Validate Invoice :' + Invoice.REsultStatus.Allmessages);
              Exit;
            end else begin
              AddEventdata(aOnEvent,VS1_TAG_Invoice,'Invoice Validated');
            end;
            try
            if not Invoice.Save then begin
              fsMsg :=  'Failed to Save Invoice :' + Invoice.REsultStatus.Allmessages;
              AddEventdata(aOnEvent,VS1_TAG_Invoice,'Failed to Save Invoice :' + Invoice.REsultStatus.Allmessages);
              Exit;
            end else begin
              AddEventdata(aOnEvent,VS1_TAG_Invoice,'Invoice Saved');
            end;
            Except
              on E:Exception do begin
                AddEventdata(aOnEvent,VS1_TAG_Invoice,'Failed to SAve Invoice :' + E.Message);
              end;
            end;
            AddEventdata(aOnEvent,VS1_TAG_Invoice,'Invoice #' + inttostr(Invoice.Id) +' created', true);
            aConn.CommitNestedTransaction;
            REsult :=Invoice.ID;
          finally
            Freeandnil(Invoice);
          end;
   Except
      on E:Exception do begin
        aConn.RollbackNestedTransaction;
        Exit;
      end;
   end;
end;

function MakePayment(aconn : TMydacdataconnection; aVS1_Clients:TVS1_Clients; fiInvoiceID: Integer; (*aDiscountedPrice, *)aPaymentamount:Double;aPayMethod :String ; var fsMsg:String; aOnEvent:TEventProc; var fiCustpaymentID:Integer ; var fiCustPrepaymentID:Integer): Integer;
var
  CustPayments: TCustPayments;
  CustPrePayments: TCustPrePayments;
begin
  Result := 0;
  if aPaymentamount = 0 then Exit;
  if aPayMethod = '' then Exit;

  aConn.BeginnestedTransaction;
  try
    CustPayments := TCustPayments.Create(aVS1_Clients);
    try
      CustPayments.Connection := aconn;
      CustPayments.Load(0);
      CustPayments.IgnoreAccesslevel := True;
      CustPayments.SilentMode := True;
      CustPayments.New;
      CustPayments.CompanyName        := aVS1_Clients.ClientName;
      CustPayments.DeptClassName      := aVS1_Clients.RegionalOption.DeptClassName;
      CustPayments.ForeignExchangeCode :=aVS1_Clients.ForeignExchangeCode(*aVS1_Clients.RegionalOption.ForeignExDefault*);
      CustPayments.PayMethodName := aPayMethod;
      CustPayments.PostDB;
      if CustPayments.GUILines.Locate('Type;SaleID', vararrayof(['Invoice', fiInvoiceID]), []) = False then begin
        CustPayments.GUILines.New;
        CustPayments.GUILines.TransType := 'Invoice';
        CustPayments.GUILines.TransId :=  fiInvoiceID;
        CustPayments.GUILines.Applied  := true;
      end;
      if CustPayments.ForeignExchangeCode = Appenv.RegionalOptions.ForeignExDefault then begin
        (*if aDiscountedPrice >= aPaymentamount then CustPayments.GUILines.Payment := aDiscountedPrice
        else *)CustPayments.GUILines.Payment := aPaymentamount;
      end else begin
        (*if aDiscountedPrice >= aPaymentamount then CustPayments.GUILines.ForeignPayment := aDiscountedPrice
        else *)CustPayments.GUILines.ForeignPayment := aPaymentamount;
      end;
      CustPayments.GUILines.Paid := (CustPayments.GUILines.ForeignPayment <> 0) or (CustPayments.GUILines.Payment <> 0);
      CustPayments.GUILines.PostDB;
      if not CustPayments.Save then begin
        fsMsg := 'Failed to Create Payment';
        Exit;
      end;
      AddEventdata(aOnEvent,VS1_TAG_CustPayments,'CustPayments #' + inttostr(CustPayments.Id) +' created', true);
      aConn.CommitNestedTransaction;
      REsult :=CustPayments.ID;
      fiCustpaymentID:=CustPayments.ID;
    finally
      Freeandnil(CustPayments);
    end;
   Except
      on E:Exception do begin
        aConn.RollbackNestedTransaction;
        Exit;
      end;
   end;
  {Make customer prePayment for the credit}
  (*if aDiscountedPrice < aPaymentamount then begin
   aConn.beginnestedTransaction;
   try
          CustPrepayments := TCustPrepayments.create(aVS1_Clients)       ;
          try
            CustPrepayments.connection       := aconn;
            CustPrepayments.Load(0);
            CustPrepayments.New;
            CustPrepayments.CompanyName :=  aVS1_Clients.ClientName;
            CustPrepayments.DeptClassName := aVS1_Clients.RegionalOption.DeptClassName;
            CustPrepayments.ForeignExchangeCode :=aVS1_Clients.ForeignExchangeCode{aVS1_Clients.RegionalOption.ForeignExDefault};
            CustPrepayments.Paymethodname := aPayMethod;
            if CustPrepayments.ForeignExchangeCode = Appenv.RegionalOptions.ForeignExDefault then begin
              CustPrepayments.PayAmount := aPaymentamount- aDiscountedPrice;
            end else begin
              CustPrepayments.ForeignPayAmount := aPaymentamount- aDiscountedPrice;
            end;
            CustPrepayments.PostDB;
            if not CustPrepayments.Save then begin
              fsMsg := 'Failed to Create Pre-Payment';
              Exit;
            end;
            aConn.CommitNestedTransaction;
            fiCustPrepaymentID := CustPrepayments.ID;
          finally
            Freeandnil(CustPrepayments);
          end;
   Except
      on E:Exception do begin
        aConn.RollbackNestedTransaction;
        Exit;
      end;
   end;
  end;*)
end;

end.

