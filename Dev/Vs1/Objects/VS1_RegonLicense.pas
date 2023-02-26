unit VS1_RegonLicense;

interface

uses  JSONObject, BusObjVS1_Cloud,classes,ERPDbComponents,LogThreadBase, BusObjRegionalOptions, WebAPILib, BusObjBase;

Type
  TVS1_RegoModules = Class(TComponent)
  Private
    fsModulename          : String;
    fdPrice               : Double;
    fdDiscountedPrice     : Double;
    fdDiscountAmt         : Double;
    fdRenewPrice        : Double;
    fdRenewDiscountedPrice: Double;
    fdRenewDiscountAmt    : Double;
    fiModuleID            : Integer;
    fsDiscountDesc        : String;
    fsRenewDiscountDesc   : String;

  Protected
  Public
    Property ModuleID             : Integer read fiModuleID             write fiModuleID;
    Property Modulename           : String  read fsModulename           write fsModulename;
    Property Price                : Double  read fdPrice                write fdPrice;
    Property DiscountedPrice      : Double  read fdDiscountedPrice      write fdDiscountedPrice;
    Property DiscountAmt          : Double  read fdDiscountAmt          write fdDiscountAmt;
    Property RenewPrice         : Double  read fdRenewPrice         write fdRenewPrice;
    Property RenewDiscountedPrice : Double  read fdRenewDiscountedPrice write fdRenewDiscountedPrice;
    Property RenewDiscountAmt     : Double  read fdRenewDiscountAmt     write fdRenewDiscountAmt;
    Property DiscountDesc         : String  read fsDiscountDesc         write fsDiscountDesc;
    Property RenewDiscountDesc    : String  read fsRenewDiscountDesc    write fsRenewDiscountDesc;
  End;

  TVS1_RegoModulesArray = Array of TVS1_RegoModules;

  TVS1_Rego = Class(TComponent)
  Private
    fsClientName              : String;
    (*fsERPDBServerName         : String;
    fsERPDBDatabaseName       : String;
    fiERPDBPortnumber         : Integer;
    fbERPDBIsPortHttps        : Boolean;*)
    fiLicenseLevel            : Integer;
    fsLicenseLevelDesc        : String;
    fsCloudUserName           : String;
    fsPhoneNumber             : String;
    fsCloudSampleDBUserName   : String;
    fsCloudPassword           : String;
    fsCloudSampleDBPassword   : String;
    fsFirstName               : String;
    fsLastName                : String;
    fsSex                     : String;
    fdDateStarted             : TDateTime;
    fdDOB                     : TDateTime;
    fsRegionName              : String;
    fsCreditCardType          : String;
    fsCreditCardCardHolderName: String;
    fsCreditCardNumber        : String;
    fsCreditCardNotes         : String;
    fsCreditCardCVC           : String;
    fdLicenseExtensionTo      : TDateTime;
    fsDatabaseName            : String;
    //ArrExtraModules           : Array of String;
    //ArrExtramoduleIDs         : Array of Integer;
    fVS1_RegoModules          : TVS1_RegoModulesArray ;
    fiCreditCardExpiryYear    : Integer;
    fiCreditCardExpiryMonth   : Integer;
    fdPaymentamount           : Double;
    fdPrice                   : Double;
    fdDiscountedPrice         : Double;
    fdDiscountAmt             : Double;
    fdRenewPrice            : Double;
    fdRenewDiscountAmt        : Double;
    fdRenewDiscountedPrice    : Double;
    fsDiscountDesc            : String;
    fsRenewDiscountDesc       : String;
    fsPayMethod               : String;
    fsRegisterErr             : String;
    fsCreateNewDB             : String;
    fsLicenseRenewDurationType: String;
    fiLicenseRenewDuration    : Integer;
    fsLicenseExtensionDesc    : String;
    fbAdjustmentExtension     : Boolean;

    fsDbName, fsSampledbname, fsServerName: String;
    fiVs1_ClientID, fiInvoiceID , fiCustpaymentID , fiCustPrepaymentID:Integer;
    fconn: TERPConnection;
    fRegionalOption: TRegionalOptions;
    fVS1_ClientDbServers: TVS1_ClientDbServerSearch;
    fVS1_database: tVS1_databases;
    fbMakingExtraDB: Boolean;
    fbIsSampleDB: Boolean;
    //fdTotalPrice, fdDiscountedPrice:Double;
    fiLicenseMonths: Integer;
    fbEnableStS: Boolean;
    fsStSSupplier: String;
    fsStSDefaultClass: String;
    fsStSStockAccount: String;
    fsStSPlantTagProduct: String;
    fbStSUsesBins: Boolean;
    fsStSPackageTagProduct: String;
    fsStSDefaultWeightUOM: String;
    fbStSSimpleMode: Boolean;
    fbStSInitWithDefaults: Boolean;

    function MakeNewdatabseForRegion(VS1_Database :TVS1_databases;aOnEvent:TEventProc) :Boolean;
    function MakeNewSampledatabseForRegion(VS1_Database :TVS1_databases;aOnEvent:TEventProc) :Boolean;
    function GetVS1_ClientDbServers: TVS1_ClientDbServerSearch;
    function getVS1_database(aServername, adbname, aWhere:String): tVS1_databases;
    function RegionalOption(aWhere:String ='') :TRegionalOptions;
    Function FormatAmtForRegion(Const Value:Double):String;
    function getDateStarted: Tdatetime;
    function getDOB: Tdatetime;
    function getSex: String;
    function getLicenseRenewDuration: Integer;
    procedure SetLicenseRenewDuration(const Value: Integer);
    function getLicenseRenewDurationType: String;
    procedure SetLicenseRenewDurationType(const Value: String);
    Function LicenseRenewDurationTypeDesc:String;
    function MakeinvnApplyPayment(  VS1_Clients :TVS1_Clients;aOnEvent:TEventProc; (*fdTotalPrice,fdDiscountedPrice:double ;*)aPaymentamount :Double; aDateFrom, aDateto:TDateTime; conn : TMyDAcDataconnection; jsModules:TJsonObject; istoUpdateDate :boolean = TRue; aLogger : TLoggerBase=nil):Boolean;
    //procedure CalcuModuleTotalsCallback(const Sender: TBusObj;var Abort: Boolean);
    function VerifyModulestoAdd(Conn: TMyDAcDataconnection): boolean;
    function AddVS1_Modules(VS1_Clients: TVS1_Clients; jsModules:TJsonObject; aDBName: String): Boolean;
    procedure AddVS1_Module(VS1_Clients: TVS1_Clients; jsModules: TJsonObject;amoduleID: Integer; aVS1_RegoModule:TVS1_RegoModules; aDBName: String);
    Function DoEnableStS(aVS1_ClientUsers:TVS1_ClientUsers; var fsREsponse :String):Boolean;
    Function VS1_InitNewDatabase(aOnEvent: TEventProc; aVS1_Db :TVS1_databases;IsVS1Database:Boolean; Vs1_RegoJson:String; var fsResponse:String):Boolean;
    procedure LogConn(aOnEvent: TEventProc; fconn: TMyDAcDataconnection);
    (*procedure ClientModulesUsageCallback(const Sender: TBusObj;var Abort: Boolean);*)
  Protected
  Public
     Procedure VS1_NewRego(aOnEvent:TEventProc; aLogger : TLoggerBase);
     function VS1_AddModules(aOnEvent:TEventProc; aLogger : TLoggerBase):Boolean;
     Procedure VS1_Renew(aOnEvent:TEventProc; aLogger : TLoggerBase);
     Constructor Create(AOwner :TComponent ;  aconn : TERPConnection); overload;
     (*Function AddExtraModule(const Value: STring):Boolean;*)
     Property ClientName              : String  read fsClientName               write fsClientName;
     (*Property ERPDBServerName         : String  read fsERPDBServerName          write fsERPDBServerName;
     Property ERPDBDatabaseName       : String  read fsERPDBDatabaseName        write fsERPDBDatabaseName;
     Property ERPDBPortnumber         : Integer read fiERPDBPortnumber          write fiERPDBPortnumber;
     Property ERPDBIsPortHttps        : Boolean read fbERPDBIsPortHttps         write fbERPDBIsPortHttps;*)
     Property LicenseLevel            : Integer read fiLicenseLevel             write fiLicenseLevel;
     Property LicenseLevelDesc        : String  read fsLicenseLevelDesc         write fsLicenseLevelDesc;
     Property CloudUserName           : String  read fsCloudUserName            write fsCloudUserName;
     Property PhoneNumber             : String  read fsPhoneNumber              write fsPhoneNumber;
     Property CloudSampleDBUserName   : String  read fsCloudSampleDBUserName    write fsCloudSampleDBUserName;
     Property CloudPassword           : String  read fsCloudPassword            write fsCloudPassword;
     Property CloudSampleDBPassword   : String  read fsCloudSampleDBPassword    write fsCloudSampleDBPassword;
     Property FirstName               : String  read fsFirstName                write fsFirstName;
     Property LastName                : String  read fsLastName                 Write fsLastName;
     Property Sex                     : String  read getSex                     Write fsSex;
     Property DateStarted             : Tdatetime read getDateStarted           write fdDateStarted;
     Property DOB                     : Tdatetime read getDOB                   write fdDOB;
     Property RegionName              : String  read fsRegionName               Write fsRegionName;
     Property CreditCardType          : String  read fsCreditCardType           Write fsCreditCardType;
     Property CreditCardCardHolderName: String  read fsCreditCardCardHolderName Write fsCreditCardCardHolderName;
     Property CreditCardNumber        : String  read fsCreditCardNumber         Write fsCreditCardNumber;
     Property CreditCardNotes         : String  read fsCreditCardNotes          Write fsCreditCardNotes;
     Property CreditCardCVC           : String  read fsCreditCardCVC            Write fsCreditCardCVC;
     Property CreditCardExpiryMonth   : Integer read fiCreditCardExpiryMonth    write fiCreditCardExpiryMonth;
     Property CreditCardExpiryYear    : Integer read fiCreditCardExpiryYear     write fiCreditCardExpiryYear;
     Property Paymentamount           : double  read fdPaymentamount            write fdPaymentamount;
     Property Price                   : double  read fdPrice                    write fdPrice;
     Property DiscountedPrice         : double  read fdDiscountedPrice          write fdDiscountedPrice;
     Property DiscountAmt             : double  read fdDiscountAmt              write fdDiscountAmt;
     Property RenewPrice              : double  read fdRenewPrice               write fdRenewPrice;
     Property RenewDiscountAmt        : double  read fdRenewDiscountAmt         write fdRenewDiscountAmt;
     Property RenewDiscountedPrice    : double  read fdRenewDiscountedPrice     write fdRenewDiscountedPrice;
     Property DiscountDesc            : String  read fsDiscountDesc             write fsDiscountDesc;
     Property RenewDiscountDesc       : String  read fsRenewDiscountDesc        write fsRenewDiscountDesc;
     Property PayMethod               : String  read fsPayMethod                write fsPayMethod;
     Property CreateNewDB             : String  read fsCreateNewDB              Write fsCreateNewDB;
     Property LicenseRenewDurationType: String  read getLicenseRenewDurationType Write SetLicenseRenewDurationType;
     Property LicenseExtensionDesc    : String  read fsLicenseExtensionDesc     Write fsLicenseExtensionDesc;
     Property AdjustmentExtension     : Boolean read fbAdjustmentExtension      write fbAdjustmentExtension;
     Property LicenseRenewDuration    : Integer read getLicenseRenewDuration    write SetLicenseRenewDuration;
     Property RegisterErr             : String  read fsRegisterErr              Write fsRegisterErr;
     Property MakingExtraDB           : Boolean read fbMakingExtraDB            write fbMakingExtraDB;
     Property IsSampleDB              : Boolean read fbIsSampleDB               write fbIsSampleDB;
     Property LicenseExtensionTo      : Tdatetime read fdLicenseExtensionTo     write fdLicenseExtensionTo;
     Property DatabaseName            : String  read fsDatabaseName             write fsDatabaseName;

     Property VS1_RegoModules : TVS1_RegoModulesArray read fVS1_RegoModules;
     Procedure InitVS1_RegoModules(Params:TJsonObject);

     {StS Defaults}
     Property StSInitWithDefaults     : Boolean read fbStSInitWithDefaults      write fbStSInitWithDefaults;
     Property StSPackageTagProduct    : String  read fsStSPackageTagProduct     write fsStSPackageTagProduct;
     Property StSPlantTagProduct      : String  read fsStSPlantTagProduct       write fsStSPlantTagProduct;
     Property StSSupplier             : String  read fsStSSupplier              write fsStSSupplier;
     Property StSStockAccount         : String  read fsStSStockAccount          write fsStSStockAccount;
     Property StSDefaultClass         : String  read fsStSDefaultClass          write fsStSDefaultClass;
     Property StSDefaultWeightUOM     : String  read fsStSDefaultWeightUOM      write fsStSDefaultWeightUOM;
     Property StSUsesBins             : Boolean read fbStSUsesBins              write fbStSUsesBins;
     Property StSSimpleMode           : Boolean read fbStSSimpleMode            write fbStSSimpleMode;

     Property VS1_ClientDbServers     : TVS1_ClientDbServerSearch read GetVS1_ClientDbServers;
     Property VS1_database[aServername, adbname, aWhere:String] : tVS1_databases Read getVS1_database;
     Function Vs1_RegoJson:String;Overload;
     Procedure Vs1_RegoJson(Js :TJsonObject);Overload;
     (*Procedure CalcModuleTotals(VS1_Clients:TVS1_Clients);*)

  End;

implementation

uses utServerTask, WebApiConst, sysutils, RandomUtils,
  utVS1Const, BusObjClient, LogMessageTypes,
  busobjcompinfo, BusObjEmployee, VS1Lib, DateUtils, variants, BusObjSales,
  tcConst, BusObjPayments, busobjPrepayments, CommonLib, AppEnvironment,
  utCloudconst, utGTConst, cloudLib, StSConst;

{ TVS1_Rego }
Function TVS1_Rego.MakeNewSampledatabseForRegion(VS1_Database :TVS1_databases;aOnEvent:TEventProc ) :Boolean;
var
  fiCreatedbTaskID:Integer;
  OutJson :TJsonObject;
  TaskRec: TServerTaskRec;
  JsResultStr:String;
begin

  TaskRec := TServerTaskRec.New(TASK_VS1_NewRego, fConn.Server);
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  AddEventdata(aOnEvent,'Creating Sample Database','');
  AddEventdata(aOnEvent,'TaskID',inttostr(TaskRec.ID), true);
  try
    IsSampleDB := True;
    try
        if VS1Lib.MakeNewdatabseForRegion(self,JsResultStr, true, fsSampledbname, fsServername) then begin
//          VS1_Database.New;
          VS1_Database.New;
          VS1_Database.DatabaseName := fsSampledbname;
          VS1_Database.ServerName   := fsServername;
          VS1_Database.Regionname   := fsRegionName;
          VS1_Database.Status       := VS1_DB_Status_Available;
          VS1_Database.CreatedOn    := Date;
          VS1_Database.APIPort      := Self.VS1_ClientDbServers.APIPort;
          VS1_Database.IsHttps      := Self.VS1_ClientDbServers.IsHttps;
          VS1_Database.PostDB;
          result := true;
       end;
    finally
      IsSampleDB:= False;
    end;

  finally
    TaskRec.Free;
  end;

end;
(*Function  TVS1_Rego.AddExtraModule(const Value: STring):Boolean;
var
  ctr:Integer;
begin
  REsult := False;
  if value = '' then exit;

  if length(ArrExtraModules)>0 then
    for ctr := low(ArrExtraModules) to high(ArrExtraModules) do
      if sametext(ArrExtraModules[ctr] , Value) then exit;

  SetLength(ArrExtraModules, length(ArrExtraModules)+1);
  ArrExtraModules[high(ArrExtraModules)] := Value;
  Result := true;
  if sametext(Value , STS_CAPTION) then
    fbEnableStS := True;
end;*)

(*procedure TVS1_Rego.CalcModuleTotals(VS1_Clients:TVS1_Clients);
begin
                     fdTotalPrice := 0;
                     fdDiscountedPrice :=0;
                     fiLicenseMonths:= VS1_Clients.LicenseMonths;
                     VS1_Clients.ClientModules.IterateRecords(CalcuModuleTotalsCallback);
end;
procedure TVS1_Rego.CalcuModuleTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TVS1_ClientModules then begin

     TVS1_ClientModules(Sender).ModulePriceID  := Tvs1_moduleprice.PriceIDForLicenseLevel(TVS1_ClientModules(Sender).LicenseLevel ); {TODOVS1 - Datefrom and date to not implemented}
     TVS1_ClientModules(Sender).PostDB;

     if (TVS1_ClientModules(Sender).Price=0) then // free module , eg: extra user
     else begin TVS1_ClientModules(Sender).CalcPrice;

                 TVS1_ClientModules(Sender).Price           := commonlib.Round(TVS1_ClientModules(Sender).Price,RegionalOption.DecimalPlaces);
                 TVS1_ClientModules(Sender).DiscountedPrice := commonlib.Round(TVS1_ClientModules(Sender).DiscountedPrice,RegionalOption.DecimalPlaces);
                 fdTotalPrice      := fdTotalPrice     + (TVS1_ClientModules(Sender).Price           * fiLicenseMonths);
                 fdDiscountedPrice := fdDiscountedPrice+ (TVS1_ClientModules(Sender).DiscountedPrice * fiLicenseMonths);
     end;
  end;
end;*)

constructor TVS1_Rego.Create(AOwner: TComponent; aconn: TERPConnection);
begin
  Create (AOwner);
  fconn := aconn;
  //SetLength(ArrExtraModules,0);
  //SetLength(ArrExtramoduleIDs,0);
  fVS1_database := nil;
  MakingExtraDB := False;
  IsSampleDB := False;
  fRegionalOption := nil;
  fbEnableStS := False;
  SetLength(fVS1_RegoModules, 0);
end;

function TVS1_Rego.FormatAmtForRegion(const Value: Double): String;
begin
  Result := RegionalOption.CurrencySymbol + SysUtils.FloatToStrF(Value, ffGeneral, 15,RegionalOption.DecimalPlaces);
end;

function TVS1_Rego.getDateStarted : Tdatetime ;begin   Result := fdDateStarted;   if result <=0 then result := date; end;
function TVS1_Rego.getDOB         : Tdatetime ;begin   Result := fdDOB;           if result <=0 then result := date; end;
function TVS1_Rego.getLicenseRenewDuration: Integer;
begin
  if fiLicenseRenewDuration<1 then fiLicenseRenewDuration := 1;
  Result := fiLicenseRenewDuration;
end;

function TVS1_Rego.getLicenseRenewDurationType: String;
begin
  result := fsLicenseRenewDurationType;
  if (result<>'M') and (result<>'Y') then Result := 'M';
end;

function TVS1_Rego.getSex         : String    ;begin   Result := fsSex;           if result ='' then result := 'F' ; end;

function TVS1_Rego.getVS1_database(aServername, adbname, aWhere:String): tVS1_databases;
var
  fsSelect :String;
begin
  if fVS1_database = nil then begin
    fVS1_database:= tVS1_databases.Create(Self);
    fVS1_database.Load(0);
  end;
  fsSelect :='';
  if adbname <> '' then  fsSelect :='DatabaseName = '+quotedstr(adbname);
  if aServername <> '' then begin
     if fsSelect <> '' then fsSelect := fsSelect +' and ';
     fsSelect := fsSelect +'  ServerName=' + quotedstr(aServername);
  end;
  if aWhere <> '' then begin
     if fsSelect <> '' then fsSelect := fsSelect +' and ';
     fsSelect := fsSelect + '(' + aWhere+')';
  end;

  if not(sametext(fVS1_database.SQLSelect , fsSelect)) then
     fVS1_database.LoadSelect( fsSelect);
  result := fVS1_database;
end;

procedure TVS1_Rego.InitVS1_RegoModules(Params: TJsonObject);
var
  ctr : Integer;

  function  AddExtraModule(const Value: STring) : Boolean;
  var
    fi:Integer;
  begin
    Result := False;
    if Value = '' then Exit;

    if Length(fVS1_RegoModules) > 0 then
      for fi := Low(fVS1_RegoModules) to High(VS1_RegoModules) do
        if SameText(fVS1_RegoModules[fi].ModuleName, Value) then Exit;

    SetLength(fVS1_RegoModules, Length(fVS1_RegoModules) + 1);
    fVS1_RegoModules[High(fVS1_RegoModules)] := TVS1_RegoModules.Create(Self);
    VS1_RegoModules[High(VS1_RegoModules)].ModuleName := Value;

    Result := True;
    if SameText(Value, STS_CAPTION) then
      fbEnableStS := True;
  end;
begin
  SetLength(fVS1_RegoModules, 0);
  if Params.Exists(VS1_TAG_ExtraModules) and (Params.A[VS1_TAG_ExtraModules].count > 0) then
    for ctr := 0 to Params.A[VS1_TAG_ExtraModules].count - 1 do begin
      if AddExtraModule((Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).S[VS1_TAG_ModuleName]) then begin
        fVS1_RegoModules[High(fVS1_RegoModules)].Price                := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_Price];
        fVS1_RegoModules[High(fVS1_RegoModules)].DiscountedPrice      := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_DiscountedPrice];
        fVS1_RegoModules[High(fVS1_RegoModules)].DiscountAmt          := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_DiscountedAmt];
        fVS1_RegoModules[High(fVS1_RegoModules)].RenewPrice           := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_Renew_Price];
        fVS1_RegoModules[High(fVS1_RegoModules)].RenewDiscountedPrice := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_Renew_DiscountedPrice];
        fVS1_RegoModules[High(fVS1_RegoModules)].RenewDiscountAmt     := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).F[VS1_TAG_Renew_DiscountedAmt];
        fVS1_RegoModules[High(fVS1_RegoModules)].DiscountDesc         := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).S[VS1_TAG_DiscountDesc];
        fVS1_RegoModules[High(fVS1_RegoModules)].RenewDiscountDesc    := (Params.A[VS1_TAG_ExtraModules].Items[ctr].asObject).S[VS1_TAG_Renew_DiscountDesc];
      end;
    end;
end;

function TVS1_Rego.LicenseRenewDurationTypeDesc: String;
begin
  if LicenseRenewDurationType ='Y' then result := 'Y' else REsult := 'Month';
end;

function TVS1_Rego.GetVS1_ClientDbServers: TVS1_ClientDbServerSearch;
var
  aSQL:String;
begin
  aSQL := 'RegionId = ' + IntToStr(TRegionaloptions.IDToggle(RegionName)) + ' OR RegionId = 0';

  if fVS1_ClientDbServers = nil then begin
    fVS1_ClientDbServers := TVS1_ClientDbServerSearch.CreateWithNewConn(self);
    fVS1_ClientDbServers.Load(0)
  end;

  if (fVS1_ClientDbServers.count = 0) or
    not(Sametext(fVS1_ClientDbServers.SQL, aSQL)) or
    not(fVS1_ClientDbServers.RegionId in [0, TRegionaloptions.IDToggle(RegionName)]) then begin
    fVS1_ClientDbServers.LoadSelect(aSQL);
  end;

  Result := fVS1_ClientDbServers;
end;

function TVS1_Rego.MakeNewdatabseForRegion(VS1_Database: TVS1_databases; aOnEvent: TEventProc): Boolean;
var
  fiCreatedbTaskID: Integer;
  OutJson: TJsonObject;
  TaskRec: TServerTaskRec;
  JsResultStr: String;
begin
  TaskRec := TServerTaskRec.New(TASK_VS1_NewRego, fConn.Server);
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  AddEventdata(aOnEvent, 'Creating database', '');
  AddEventdata(aOnEvent, 'TaskID', IntToStr(TaskRec.ID), True);
  try
    IsSampleDB := False;
    if VS1Lib.MakeNewdatabseForRegion(Self, JsResultStr, False, fsDbName, fsServername) then begin
//      VS1_Database.New;
      VS1_Database.New;
      VS1_Database.DatabaseName := fsDbName;
      VS1_Database.ServerName   := fsServerName;
      VS1_Database.Regionname   := fsRegionName;
      VS1_Database.Status       := VS1_DB_Status_Available;
      VS1_Database.CreatedOn    := Date;
      VS1_Database.APIPort      := Self.VS1_ClientDbServers.APIPort;
      VS1_Database.IsHttps      := Self.VS1_ClientDbServers.IsHttps;
      VS1_Database.PostDB;
      Result := True;
    end else begin
      AddEventdata(aOnEvent, 'MakeNewdatabseResponse', JsResultStr, True);
    end;

  finally
    TaskRec.Free;
  end;
end;

procedure TVS1_Rego.LogConn(aOnEvent:TEventProc; fconn : TMyDAcDataconnection);
begin
    Exit; // remove for debugging

    if fconn = nil then exit;
    AddEventdata(aOnEvent ,TAG_ResponseTask     , '========', true);
    AddEventdata(aOnEvent ,TAG_ResponseTask     ,'Connection :' + inttostr(Integer(fconn)));
    if fconn.Connected then  AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Connected', true) else AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Not Connected', true);
    AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Server: ' +fconn.Connection.Server, true);
    AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Database: ' +fconn.Connection.Database, true);
    AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Username: ' +fconn.Connection.Username, true);
    AddEventdata(aOnEvent ,TAG_ResponseTask     , 'Password: ' +fconn.Connection.Password, true);
    if fconn.Connected then  AddEventdata(aOnEvent ,TAG_ResponseTask     , appenv.Employee.EmployeeName);

    AddEventdata(aOnEvent ,TAG_ResponseTask     , '========', true);
end;

Function TVS1_Rego.MakeinvnApplyPayment(VS1_Clients: TVS1_Clients; aOnEvent: TEventProc; (*fdTotalPrice,fdDiscountedPrice:double ;*)aPaymentamount: Double; aDateFrom, aDateto: TDateTime; conn: TMyDAcDataconnection; jsModules: TJsonObject; istoUpdateDate: Boolean = True; aLogger: TLoggerBase = nil): Boolean;
  function MakeInvoice: Integer;
  begin
    LogConn(aOnEvent, conn);
    Result := VS1Lib.Makeinvoice(conn, Paymentamount, VS1_Clients,
                                 'License from ' + quotedstr(formatdatetime(shortdateformat, aDatefrom)) + ' to ' + quotedstr(formatdatetime(shortdateformat, aDateto)) + NL +
                                 'For ' + inttostr(LicenseRenewDuration) + ' ' + LicenseRenewDurationTypeDesc + '(s)', 0, 0,
                                 Date, fsRegisterErr, aOnEvent, jsModules, AdjustmentExtension, LicenseExtensionDesc);
  end;

  function MakePayment: Integer;
  begin
    Result := VS1Lib.MakePayment(conn, VS1_Clients, fiInvoiceID, (*fdDiscountedPrice,*)aPaymentamount, PayMethod, fsRegisterErr, aOnEvent, fiCustpaymentID, fiCustPrepaymentID);
    if Result <> 0 then begin
      try
        VS1_Clients.ClientPayments.Payment := Paymentamount;
        VS1_Clients.ClientPayments.Paidon := Date;
        VS1_Clients.ClientPayments.PayMethod := PayMethod;
        VS1_Clients.ClientPayments.PostDB;
      except
        on E:Exception do begin
          try aLogger.Log('MakePayment Error :' + E.message, ltInfo); except end;
        end;
      end;
    end;
  end;
begin
  Result := False;
  AddEventdata(aOnEvent, VS1_TAG_Invoice + '-ClientName', VS1_Clients.ClientName, True);
  (*AddEventdata(aOnEvent,VS1_TAg_TotalPrice     ,Floattostr(fdTotalPrice),true);
  AddEventdata(aOnEvent,VS1_TAG_DiscountedPrice ,Floattostr(fdDiscountedPrice)  , true);*)
  AddEventdata(aOnEvent, VS1_TAg_TotalPrice, Floattostr(aPaymentamount), True);
  fiInvoiceID := MakeInvoice;
  if fiInvoiceID = 0 then begin
    AddEventdata(aOnEvent, VS1_TAG_Invoice + '-' + TAG_ResponseInfo, 'Creation of invoice Failed', True);
    Exit;
  end;

  (* if (fdDiscountedPrice > Paymentamount) then begin
    AddEventdata(aOnEvent,VS1_TAG_Invoice+'-'+TAG_ResponseError, 'Incomplete Payment, License will not be Active Until fully Paid. To be paid :'+FormatAmtForRegion(fdDiscountedPrice)+', and Paid :' + FormatAmtForRegion(Paymentamount)       , true);
  end else if (fdDiscountedPrice < Paymentamount) then begin
    AddEventdata(aOnEvent,VS1_TAG_Invoice+'-'+TAG_ResponseInfo, 'Payment is more than Invoice Amout. Remaining will ke Kept as a Credit.  To be paid :'+FormatAmtForRegion(fdDiscountedPrice)+', and Paid :' + FormatAmtForRegion(Paymentamount)       , true);
  end;*)
  if Paymentamount <> 0 then begin
    MakePayment;
  end;

  if istoUpdateDate then begin
    if fdDiscountedPrice <= Paymentamount then begin
    end else begin
      aDateFrom := incday(aDateFrom, -1);
      aDateto := aDateFrom;
    end;
    VS1_Clients.LicenseFrom             := aDateFrom;
    VS1_Clients.LicenseUntil            := aDateTo;
    VS1_Clients.PostDB;

    VS1_Clients.ClientPayments.DateFrom := aDateFrom;
    VS1_Clients.ClientPayments.DateTo   := aDateTo;
    VS1_Clients.ClientPayments.PostDB;

    //VS1_Clients.ClientModules.Iteraterecords(ClientModulesUsageCallback);
    VS1_Clients.ClientModules.First;
    While VS1_Clients.ClientModules.EOF = False do begin
      VS1_Clients.ClientModules.LicenseFrom    := aDateFrom;
      VS1_Clients.ClientModules.LicenseUntil   := aDateTo;
      VS1_Clients.ClientModules.LicenseExtensionDesc := LicenseExtensionDesc;
      VS1_Clients.ClientModules.PostDB;
      VS1_Clients.ClientModules.Next;
    end;
  end;

  if VS1_Clients.Save then begin
    Result := True;
  end;
end;
(*Procedure TVS1_Rego.ClientModulesUsageCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TVS1_ClientModules then begin
    if TVS1_ClientModules(Sender).ClientModulesUsage.count =0 then begin
      //TVS1_ClientModules(Sender).ClientModulesUsage.New;
      If TVS1_ClientModules(Sender).CloneBusObj('ClientModuleID', TVS1_ClientModules(Sender).ID, False, '') <> Nil Then Begin

      End;

    end;
  end;
end;*)

function TVS1_Rego.VS1_AddModules(aOnEvent: TEventProc; aLogger: TLoggerBase): Boolean ;
var
  conn : TMyDacDataConnection;
  aVS1_ClientUsers : TVS1_ClientUsers;
  jsModules : TJsonObject;
  fiUsersIncluded : Integer;
  fsEnableStSStatus : String;

  //fiUsersCtr:Integer;
begin
  Result := False;
  conn := TMyDAcDataconnection.Create(nil);
  try
    try
      conn.Connection := fconn;
      try
        aVS1_ClientUsers := TVS1_ClientUsers.Create(Self);
        try
          aVS1_ClientUsers.Connection := TMyDacDataConnection.Create(aVS1_ClientUsers);
          aVS1_ClientUsers.Connection.Connection := fConn;
          aVS1_ClientUsers.LoadSelect('EmailId=' + QuotedStr(CloudUserName)(*+' and Password =' + quotedstr(CloudPassword)*));
          if aVS1_ClientUsers.Count = 0 then begin
            AddEventdata(aOnEvent, TAG_ResponseNo, VS1_HTTP_Failed_STRCode, True);
            AddEventdata(aOnEvent, TAG_ResponseStatus, 'User Credentials Invalid', True);
            AddEventdata(aOnEvent, TAG_ResponseError, 'User Credentials Invalid', True);
            Exit;
          end;

          if LicenseLevel = 0 then begin
            LicenseLevel  := aVS1_ClientUsers.VS1_Client.LicenseLevel;
            LicenseLevelDesc := TVS1_LicenseLevels.DescriptionforLevel(aVS1_ClientUsers.VS1_Client.LicenseLevel);
          end;

          if not VerifyModulestoAdd(conn) then begin
            AddEventdata(aOnEvent, TAG_ResponseNo, VS1_HTTP_Failed_STRCode, True);
            if registererr <> '' then
              AddEventdata(aOnEvent, TAG_ResponseStatus, 'Error: ' + registererr, True);
            Exit;
          end;

          aVS1_ClientUsers.Connection.BeginTransaction;

          try
            try
              //fdTotalPrice := 0;
              //fdDiscountedPrice := 0;
              jsModules := JO;

              try
                {if LicenseLevelchanged}
                if (LicenseLevel <> 0) then
                  if (LicenseLevel < aVS1_ClientUsers.VS1_Client.LicenseLevel) then begin
                    AddEventdata(aOnEvent, TAG_ResponseStatus, 'It is not possible to Change the License from a' +
                                                                    ' Higher Level(' + TVS1_LicenseLevels.DescriptionforLevel(aVS1_ClientUsers.VS1_Client.LicenseLevel) +
                                                                    ' to a Lower level (' + TVS1_LicenseLevels.DescriptionforLevel(LicenseLevel) + '.', True);
                    LicenseLevel := aVS1_ClientUsers.VS1_Client.LicenseLevel;
                    //if length(ArrExtraModuleIds)=0 then begin
                    if Length(VS1_RegoModules) = 0 then begin
                      Result := True;
                      Exit; // license level cannot be changed and there is no module to add
                    end;
                  end else if (LicenseLevel > aVS1_ClientUsers.VS1_Client.LicenseLevel) then begin
                    fiUsersIncluded := aVS1_ClientUsers.VS1_Client.VS1_licenselevels.UsersIncluded;
                    aVS1_ClientUsers.VS1_Client.LicenseLevel := LicenseLevel;
                    aVS1_ClientUsers.VS1_Client.PostDB;
                    AddVS1_Module(aVS1_ClientUsers.VS1_Client, jsModules, 0, nil, DatabaseName);

                    //If LicenseLevel is changed , then check for the number paid users included and make them non-payable if applicable
                    // this will be applied only from the renewal
                    if fiUsersIncluded < aVS1_ClientUsers.VS1_Client.VS1_licenselevels.UsersIncluded then begin
                      if aVS1_ClientUsers.VS1_Client.ClientUsers.count > fiUsersIncluded then begin

{----------------------------loop to count included free users}
                        if aVS1_ClientUsers.VS1_Client.ClientModules.count >0 then begin
                          aVS1_ClientUsers.VS1_Client.ClientModules.First;
                          fiUsersIncluded := 1; // registered main user is free user , so initalise with 1
                          while aVS1_ClientUsers.VS1_Client.ClientModules.EOF = False do begin
                            if aVS1_ClientUsers.VS1_Client.ClientModules.ModuleId = TVS1_Modules.IDToggle(VS1_MODULE_Add_Extra_User) then begin
                              if aVS1_ClientUsers.VS1_Client.ClientModules.Price =0 then begin
                                fiUsersIncluded:= fiUsersIncluded +1;
                              end;
                            end;
                            aVS1_ClientUsers.VS1_Client.ClientModules.Next;
                          end;
                        end;

{----------------------------Make Paid users free - if more free users allowed in the new level}
                        if (fiUsersIncluded < aVS1_ClientUsers.VS1_Client.ClientUsers.count) and
                           (fiUsersIncluded < aVS1_ClientUsers.VS1_Client.VS1_licenselevels.UsersIncluded ) then begin
                          AddEventdata(aOnEvent ,TAG_ResponseStatus , 'Paid Users are Changed to Free as the New Level Selected has More Users Included.' , true);
                          aVS1_ClientUsers.VS1_Client.ClientModules.First;
                          while (aVS1_ClientUsers.VS1_Client.ClientModules.EOF = False) and (fiUsersIncluded <  aVS1_ClientUsers.VS1_Client.VS1_licenselevels.UsersIncluded  ) do begin
                            if (aVS1_ClientUsers.VS1_Client.ClientModules.ModuleId = TVS1_Modules.IDToggle(VS1_MODULE_Add_Extra_User)) then begin
                              //fiUsersCtr := fiUsersCtr +1;
                              if (aVS1_ClientUsers.VS1_Client.ClientModules.Price<>0) then begin
                                if fiUsersIncluded < aVS1_ClientUsers.VS1_Client.VS1_licenselevels.UsersIncluded then begin
                                  aVS1_ClientUsers.VS1_Client.ClientModules.Price           := 0;
                                  aVS1_ClientUsers.VS1_Client.ClientModules.DiscountedPrice := 0;
                                  aVS1_ClientUsers.VS1_Client.ClientModules.DiscountAmt     := 0;
                                  aVS1_ClientUsers.VS1_Client.ClientModules.PostDB;
                                  fiUsersIncluded := fiUsersIncluded+1;
                                end;
                              end;
                            end;
                            aVS1_ClientUsers.VS1_Client.ClientModules.Next;
                          end;
                        end;
                      end;
                    end;
{------------------------- Change LicenseLevel in modules}
                    aVS1_ClientUsers.VS1_Client.ClientModules.First;
                    while (aVS1_ClientUsers.VS1_Client.ClientModules.EOF = False) do begin
                      aVS1_ClientUsers.VS1_Client.ClientModules.LicenseLevel := LicenseLevel;
                      aVS1_ClientUsers.VS1_Client.ClientModules.PostDB;
                      fiUsersIncluded := fiUsersIncluded + 1;
                      aVS1_ClientUsers.VS1_Client.ClientModules.Next;
                    end;
                  end;

                  if not AddVS1_Modules(aVS1_ClientUsers.VS1_Client, jsModules, DatabaseName) then Exit;
                  AddEventdata(aOnEvent, TAG_Obj, jsModules.asString, True, 'VS1 Modules');

                  if MakeInvnApplyPayment(aVS1_ClientUsers.VS1_Client, aOnEvent,(*fdPrice,fdDiscountedPrice, *)Paymentamount , aVS1_ClientUsers.VS1_Client.LicenseFrom, aVS1_ClientUsers.VS1_Client.Licenseuntil, conn, jsModules, false, aLogger ) then begin
                    Conn.CommitTransaction;
                    AddEventdata(aOnEvent,TAG_ResponseNo,VS1_HTTP_Success_STRCode, true);
                    AddEventdata(aOnEvent,TAG_ResponseStatus,'OK', true);
                    Result := True;
                  end;
              finally
                jsModules.Free;
              end;
            except
              on E:Exception do begin
                aVS1_ClientUsers.connection.RollbackTransaction;
                AddEventdata(aOnEvent, TAG_ResponseError, E.message);
              end;
            end;
          finally
            aVS1_ClientUsers.connection.RollbackTransaction;
            if Result then
              if DoEnableStS(aVS1_ClientUsers, fsEnableStSStatus) then begin
                AddEventdata(aOnEvent, TAG_ResponseStatus, 'Database is initialialised with Seed To Sale Defaults' , true);
              end;
          end;

        except
          on E:Exception do begin
            aVS1_ClientUsers.connection.Rollbacktransaction;
            AddEventdata(aOnEvent, TAG_ResponseError, E.message);
          end;
        end;
      finally
        FreeAndNil(aVS1_ClientUsers);
      end;
    except
      on E: Exception do begin
        RegisterErr := E.message;
      end;
    end;
  finally
    FreeAndNil(conn);
  end;
end;

Function TVS1_Rego.VS1_InitNewDatabase(aOnEvent: TEventProc; aVS1_Db: TVS1_Databases; IsVS1Database: Boolean; Vs1_RegoJson: String; var fsResponse:String): Boolean;
var
  params, js: TJsonObject;
  fsURL: String;
  JsResultStr: String;
begin
  AddEventdata(aOnEvent, 'Progress', 'VS1_InitNewDatabase ' + aVS1_Db.Servername + '.' + aVS1_Db.DatabaseName);
  params := JO(Vs1_RegoJson);
  try
    js := JO;
    try
      params.S['Name']                := TASK_VS1_InitNewDatabase;
      params.S[VS1_TAG_DatabaseName]  := aVS1_Db.DatabaseName;
      params.S[VS1_TAG_ServerName]    := aVS1_Db.Servername;
      params.B[VS1_TAG_IsVS1Database] := IsVS1Database;
      params.S[VS1_TAG_RegionName]    := RegionName               ;
      params.S[TAG_ERPUserName]       := ERP_VS1CLOUD_ADMIN_USERFirstName; //ERP_VS1CLOUD_DEFAULT_USER;
      params.S[TAG_ERPPassword]       := 'admin';                          //ERP_VS1CLOUD_DEFAULT_TOKEN;

      fsURL := VS1_ClientDbServers.WebAPIURL(VS1_Cloud_Task + '/Method?Name="VS1_InitNewDatabase"');;
      if DoHTTPPOST(fsURL,
                     aVS1_Db.DatabaseName,
                     ERP_VS1CLOUD_ADMIN_USERFirstName,
                     'admin',
                     Params,
                     JsResultStr) = VS1_HTTP_Success_Code then begin
        js.AsString := JsResultStr;
        fsResponse := js.asString;
        Result := True;
      end else begin
        js.AsString := JsResultStr;
        fsResponse := js.asString;
        Result := False;
      end;
    finally
      js.Free;
    end;
  finally
    params.Free;
  end;
end;

Function TVS1_Rego.DoEnableStS(aVS1_ClientUsers:TVS1_ClientUsers; var fsResponse :String) :Boolean;
var
   fsURL :String;
   js, jsparam:TJSONObject;
   JsResultStr:String;
begin
      result := False;
      if not fbEnableStS then Exit;

      js:= Jo;
      try
        js.O[TAG_JsonIN].S[TAG_MethodName] :=TASK_GT_InitDBForStS;//'GT_InitDBForStS';
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].B[GT_TAG_StSUseSeedtoSale]     := true;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].B[GT_TAG_StSInitWithDefaults]  := StSInitWithDefaults;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSPackageTagProduct] := StSPackageTagProduct;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSPlantTagProduct]   := StSPlantTagProduct;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSSupplier]          := StSSupplier;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSStockAccount]      := StSStockAccount;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].B[GT_TAG_StSUsesBins]          := StSUsesBins;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].B[GT_TAG_StSSimpleMode]        := StSSimpleMode;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSDefaultClass]      := StSDefaultClass;
        js.O[TAG_JsonIN].O[TAG_CLOUD_Params].S[GT_TAG_StSDefaultWeightUOM]  := StSDefaultWeightUOM;


        fsURL:=aVS1_ClientUsers.VS1_Client.(*vs1_clientdbserver.*)WebAPIURL('GT_Cloud_Task/Method?Name="GT_InitDBForStS"');
        if  DoHTTPPost(fsURL,
                       aVS1_ClientUsers.VS1_Client.databasename,
                       aVS1_ClientUsers.emailID,
                       aVS1_ClientUsers.password,
                       js,
                       JsResultStr) =VS1_HTTP_Success_Code then begin
            js.AsString := JsResultStr;
            fsResponse :=js.asString;
            Result := True;
        end else begin
            js.AsString := JsResultStr;
            fsResponse :=js.asString;
            Result := False;
        end;
      finally
        js.Free;
      end;
end;

procedure TVS1_Rego.AddVS1_Module(VS1_Clients: TVS1_Clients; jsModules: TJsonObject; amoduleID: Integer; aVS1_RegoModule: TVS1_RegoModules; aDBName: String);
var
  jsModule: TJsonObject;
  //fdPrice, fdDPrice :Double;
  procedure InitModule;
  begin
    VS1_Clients.ClientModules.LicenseLevel   := LicenseLevel;
    VS1_Clients.ClientModules.ModuleId       := amoduleID;
    VS1_Clients.ClientModules.LicenseFrom    := VS1_Clients.Licensefrom;// aDateFrom;
    VS1_Clients.ClientModules.LicenseUntil   := VS1_Clients.LicenseUntil;//aDateFrom;//aDateTo;
    VS1_Clients.ClientModules.DatabaseName   := aDBName;
    VS1_Clients.ClientModules.PostDB;

    //VS1_Clients.ClientModules.CalcPrice;
    if amoduleID = 0 then begin
      VS1_Clients.ClientModules.Price               := Price                    ;
      VS1_Clients.ClientModules.DiscountedPrice     := DiscountedPrice          ;
      VS1_Clients.ClientModules.DiscountAmt         := DiscountAmt              ;
      VS1_Clients.ClientModules.RenewPrice          := RenewPrice               ;
      VS1_Clients.ClientModules.RenewDiscountedPrice:= RenewDiscountedPrice     ;
      VS1_Clients.ClientModules.RenewDiscountAmt    := RenewDiscountAmt         ;
      VS1_Clients.ClientModules.DiscountDesc        := DiscountDesc             ;
      VS1_Clients.ClientModules.RenewDiscountDesc   := RenewDiscountDesc        ;
    end else if aVS1_RegoModule <> nil then begin
      VS1_Clients.ClientModules.Price               := aVS1_RegoModule.Price                    ;
      VS1_Clients.ClientModules.DiscountedPrice     := aVS1_RegoModule.DiscountedPrice          ;
      VS1_Clients.ClientModules.DiscountAmt         := aVS1_RegoModule.DiscountAmt              ;
      VS1_Clients.ClientModules.RenewPrice          := aVS1_RegoModule.RenewPrice               ;
      VS1_Clients.ClientModules.RenewDiscountedPrice:= aVS1_RegoModule.RenewDiscountedPrice     ;
      VS1_Clients.ClientModules.RenewDiscountAmt    := aVS1_RegoModule.RenewDiscountAmt         ;
      VS1_Clients.ClientModules.DiscountDesc        := aVS1_RegoModule.DiscountDesc             ;
      VS1_Clients.ClientModules.RenewDiscountDesc   := aVS1_RegoModule.RenewDiscountDesc        ;
    end;

    (*VS1_Clients.ClientModules.Price           := commonlib.Round(VS1_Clients.ClientModules.Price,RegionalOption.DecimalPlaces);
    VS1_Clients.ClientModules.DiscountedPrice := commonlib.Round(VS1_Clients.ClientModules.DiscountedPrice,RegionalOption.DecimalPlaces);*)
    VS1_Clients.ClientModules.LicenseRenewDurationType := VS1_Clients.LicenseRenewDurationType;
    VS1_Clients.ClientModules.LicenseExtensionDesc     := LicenseExtensionDesc;
    VS1_Clients.ClientModules.LicenseRenewDuration     := VS1_Clients.LicenseRenewDuration;
    VS1_Clients.ClientModules.ClientPaymentId          := VS1_Clients.ClientPayments.ID;

    VS1_Clients.ClientModules.PostDB;
  end;
begin
  if VS1_Clients.ClientModules.Locate('LicenseLevel;ModuleId', vararrayof([LicenseLevel, amoduleID]), []) then Exit;
  {changing license level gets charges only the following month - but adding modules gets charged straight away }
  if (amoduleID = 0) and (VS1_Clients.ClientModules.Locate('ModuleId', 0, [])) and (VS1_Clients.ClientModules.LicenseLevel <> LicenseLevel) then begin
      //fdPrice :=  VS1_Clients.ClientModules.Price;
      //fdDPrice := VS1_Clients.ClientModules.DiscountedPrice;
    InitModule;
    jsModule := JO;
    jsModule.S[VS1_TAG_ModuleName]     :=  TVS1_LicenseLevels.IDtoggle(VS1_Clients.ClientModules.LicenseLevel);
    jsModule.I[VS1_TAG_ModuleID]       :=  VS1_Clients.ClientModules.ID;

    jsModule.F[VS1_TAG_Price]          :=  (VS1_Clients.ClientModules.Price           (*- fdPrice*));
    jsModule.F[VS1_TAG_DiscountedPrice]:=  (VS1_Clients.ClientModules.DiscountedPrice (*- fdDPrice*)) ;
    jsModule.F[VS1_TAG_LinePrice]          :=  (VS1_Clients.ClientModules.Price           (*- fdPrice*)); // charge the differnece only when License level is changed
    jsModule.F[VS1_TAG_LineDiscountedPrice]:=  (VS1_Clients.ClientModules.DiscountedPrice (*- fdDPrice*)) ;
    jsModule.S[VS1_TAG_PriceDescription]:= 'Upgrade to ' + TVS1_LicenseLevels.IDtoggle(VS1_Clients.ClientModules.LicenseLevel) +NL +
                                          trim(VS1_Clients.ClientModules.discountdescription +NL)+
                                           ' for the full License Period of  ' + inttostr(VS1_Clients.LicenseRenewDuration)+' '+ VS1_Clients.LicenseRenewDurationTypeDesc+'(s)';
  end else if not VS1_Clients.ClientModules.Locate('LicenseLevel;ModuleId', vararrayof([LicenseLevel, amoduleID]), []) then begin
    VS1_Clients.ClientModules.New;
    InitModule;
    jsModule := jo;
    jsModule.S[VS1_TAG_ModuleName]     :=  TVS1_Modules.IDtoggle(VS1_Clients.ClientModules.ID);
    jsModule.I[VS1_TAG_ModuleID]       :=  VS1_Clients.ClientModules.ID;
    jsModule.F[VS1_TAG_Price]          :=  VS1_Clients.ClientModules.Price*VS1_Clients.LicenseMonths;
    jsModule.F[VS1_TAG_DiscountedPrice]:=  VS1_Clients.ClientModules.DiscountedPrice*VS1_Clients.LicenseMonths;
    jsModule.F[VS1_TAG_LinePrice]          :=  VS1_Clients.ClientModules.Price;
    jsModule.F[VS1_TAG_LineDiscountedPrice]:=  VS1_Clients.ClientModules.DiscountedPrice;
  end;

  jsModules.A[VS1_TAG_Modules].Add(jsModule);
  //fdTotalPrice       := fdTotalPrice +jsModule.F[VS1_TAG_Price];
  //fdDiscountedPrice  := fdDiscountedPrice +jsModule.F[VS1_TAG_DiscountedPrice];
end;

function TVS1_Rego.AddVS1_Modules(VS1_Clients: TVS1_Clients; jsModules: TJsonObject; aDBName: String) : Boolean;
var
  ctr : Integer;
begin
  Result := False;

  if Length(VS1_RegoModules) > 0 then begin
    for ctr := Low(VS1_RegoModules) to High(VS1_RegoModules) do begin
      AddVS1_Module(VS1_Clients, jsModules, VS1_RegoModules[ctr].ModuleID, VS1_RegoModules[ctr], aDBName);
    end;
  end;

  Result := True;
end;

function TVS1_Rego.VerifyModulestoAdd(Conn : TMyDAcDataconnection) : Boolean;
var
  aVS1_Modules : TVS1_Modules;
  ctr : Integer;
begin
  Result := False;
        (*SetLength(ArrExtraModuleIds,0);
        if length(ArrExtramodules)>0 then begin
          aVS1_Modules := TVS1_Modules.create(Self);
          try
            aVS1_Modules.Connection := conn;
            for ctr := low(ArrExtramodules) to high(ArrExtramodules) do begin
              aVS1_Modules.Closedb;
              aVS1_Modules.LoadSelect('ModuleName = ' +quotedstr( ArrExtramodules[ctr]));
              if aVS1_Modules.count =0 then begin
                RegisterErr := 'Module ' + quotedstr(ArrExtramodules[ctr])+' doesn''t Exists';
                Exit;
              end;

              if aVS1_Modules.LicenseLevel = 0 then begin
                RegisterErr := 'Module ' + quotedstr(ArrExtramodules[ctr])+' is not a Module to Purchase';
                Exit;
              end;
              if (aVS1_Modules.LicenseLevel> Self.LicenseLevel) then begin
                RegisterErr := 'Module ' + quotedstr(ArrExtramodules[ctr])+' is not available for the Currently Selected License Level ' + Quotedstr(LicenseLevelDesc)+'.  Upgrade to Next Level to Enable  ' + quotedstr(ArrExtramodules[ctr])+'.';
                Exit;
              end;
              if not aVS1_Modules.IsExtra then Continue; // this is an included module

              SetLength(ArrExtraModuleIds,length(ArrExtraModuleIds)+1);
              ArrExtraModuleIds[high(ArrExtraModuleIds)] := aVS1_Modules.ID;
            end;
            Result := True;
          finally
            Freeandnil(aVS1_Modules);
          end;
        end else begin
          REsult := TRue;
        end;*)
  if Length(VS1_RegoModules) > 0 then begin
    aVS1_Modules := TVS1_Modules.create(Self);
    try
      aVS1_Modules.Connection := conn;
      for ctr := Low(VS1_RegoModules) to High(VS1_RegoModules) do begin
        aVS1_Modules.Closedb;
        aVS1_Modules.LoadSelect('ModuleName = ' + quotedstr( VS1_RegoModules[ctr].ModuleName));
        if aVS1_Modules.count = 0 then begin
          RegisterErr := 'Module ' + quotedstr(VS1_RegoModules[ctr].ModuleName) + ' doesn''t Exists';
          Exit;
        end;

        if aVS1_Modules.LicenseLevel = 0 then begin
          RegisterErr := 'Module ' + quotedstr(VS1_RegoModules[ctr].ModuleName) + ' is not a Module to Purchase';
          Exit;
        end;

        if (aVS1_Modules.LicenseLevel > Self.LicenseLevel) then begin
          RegisterErr := 'Module ' + quotedstr(VS1_RegoModules[ctr].ModuleName)+' is not available for the Currently Selected License Level ' + Quotedstr(LicenseLevelDesc) + '.  Upgrade to Next Level to Enable ' + quotedstr(VS1_RegoModules[ctr].ModuleName) + '.';
          Exit;
        end;

        if not aVS1_Modules.IsExtra then Continue; // this is an included module
        VS1_RegoModules[ctr].ModuleID := aVS1_Modules.ID;
      end;

      Result := True;
    finally
      FreeAndNil(aVS1_Modules);
    end;
  end else begin
    Result := True;
  end;
end;

procedure TVS1_Rego.VS1_NewRego(aOnEvent:TEventProc; aLogger : TLoggerBase);
var
  VS1_Clients: TVS1_Clients;
  VS1_ClientUsers: TVS1_ClientUsers;
  VS1_Database: tVS1_databases;
  VS1_Sampledb: tVS1_databases;
  Customer: TCustomer;
  Conn: TMyDAcDataconnection;
  ctr: Integer;
  aDatefrom, aDateTo: TDatetime;
  jsModules, jsModule, jsnewUser: TJsonObject;
  JsResultStr: String;
  fsEnableStSStatus: String;
  fiVS1EmployeeID: Integer;
  CustomerExists: Boolean;
  UserExists: Boolean;

  procedure Log(const Value:STring; valuetype:TLogMessageType = ltInfo);
  begin
    try aLogger.Log(Value, valuetype); except end;
  end;

  function NeedSampleDB: Boolean;
  begin
    {dene doesn't need the sample company at the moment }
    Result := False;
    Exit;
    Result := (CloudSampleDBUserName <> '') and (CloudSampleDBPassword <> '');
  end;

  procedure MakeExtraDB;
  var
    VS1_Extra_Db: tVS1_databases;
    res:  String;
  begin
    MakingExtraDB := True;
    try
      Log('MakeExtraDB');
      VS1_Extra_Db := TVS1_Databases.Create(Self);
      VS1_Extra_Db.Connection := conn;
      try
         VS1_Extra_Db.LoadSelect('DatabaseName LIKE "' + ERP_API_DB_PREFIX + 'DB_' + '%" AND RegionName = ' + QuotedStr(RegionName) + ' AND Status = ' + QuotedStr(VS1_DB_Status_Available) + ' LIMIT 2');
         Log('Blank DBs Available to Assign :' + IntToStr(VS1_Extra_Db.Count));
         while VS1_Extra_Db.Count < 2 do begin
           if not MakeNewDatabseForRegion(VS1_Extra_Db, aOnEvent) then begin
            RegisterErr := 'Failed to Create a New Extra Database';
            Exit;
           end;
           Log(VS1_Extra_Db.DatabaseName + ' Created and is avalable');
           VS1_Extra_Db.Closedb;
           VS1_Extra_Db.Opendb;
         end;

         if NeedSampleDB then begin
           VS1_Extra_Db.Closedb;
           VS1_Extra_Db.LoadSelect('DatabaseName LIKE "' + ERP_API_DB_PREFIX + 'SampleDB_' + '%" AND RegionName = ' + quotedstr(RegionName)+' AND Status =' + QuotedStr(VS1_DB_Status_Available) + ' LIMIT 2');
           Log('Blank Sample DBs Available to Assign :' + IntToStr(VS1_Extra_Db.Count));
           While VS1_Extra_Db.count < 2 do begin
             if not MakeNewSampledatabseForRegion(VS1_Extra_Db, aOnEvent) then begin
              RegisterErr := 'Failed to Create a New Extra Database';
              Exit;
             end;
             Log(VS1_Extra_Db.DatabaseName + ' Created and is avalable');
             VS1_Extra_Db.Closedb;
             VS1_Extra_Db.Opendb;
            Log('Blank Sample DBs Available to Assign :' + IntToStr(VS1_Extra_Db.count));
           end;
         end;
      finally
        Freeandnil(VS1_Extra_Db);
      end;
    finally
      MakingExtraDB := False;
    end;
  end;

  function MakeVS1Customer: Integer;
  begin
    Result := 0;
    Customer.LoadSelect('Company =' + QuotedStr(clientname));
    if Customer.count = 0 then begin
     Conn.BeginnestedTransaction;
     try
       Customer.New;
       Customer.ClientName                := clientname;
       Customer.Firstname                 := Firstname;
       Customer.LastName                  := LastName;
       Customer.Phone                     := Phonenumber;
       Customer.CreditCardType            := CreditCardType;
       Customer.CreditCardHolderName      := CreditCardCardHolderName;
       Customer.CreditCardNumber          := CreditCardNumber;
       Customer.CreditCardExpiryDate      := Formatdatetime('yyyy-mm-dd', EndOfTheMonth(EncodeDate(CreditCardExpiryYear, CreditCardExpiryMonth, 1)));
       Customer.CreditCardCVC             := CreditCardCVC;
       Customer.CreditCardNotes           := CreditCardNotes;
       Customer.LicenseRenewDuration      := LicenseRenewDuration;
       Customer.LicenseRenewDurationType  := LicenseRenewDurationType;
       if not Customer.Save then begin
        RegisterErr := 'Failed to Create VS1 Customer ';
        Exit;
       end;
       AddEventdata(aOnEvent,VS1_TAG_CustomerName,Customer.clientName, true);
       Conn.CommitNestedTransaction;
       Log(inttostr(Customer.ID)+':' + Customer.clientName);
     Except
      on E:Exception do begin
        Conn.RollbackNestedTransaction;
        Exit;
      end;
     end;
    end;
    Result := Customer.ID;
  end;

begin
  aDatefrom := Date;
  try
    RegisterErr := '';
    try
      Log('Checking Parameters for New Rego');

      if ClientName = '' then begin
        RegisterErr := 'Client Name should not be Blank';
        Exit;
      end;

      if LicenseLevelDesc <> '' then LicenseLevel := Tvs1_licenselevels.idtoggle(LicenseLevelDesc)
      else if LicenseLevel <> 0 then LicenseLevelDesc := Tvs1_licenselevels.idtoggle(LicenseLevel);

      if (LicenseLevel = 0) or (LicenseLevelDesc = '') then begin
        if LicenseLevelDesc <> '' then RegisterErr := QuotedStr(LicenseLevelDesc) + ' is not a Valid License Level'
        else RegisterErr := 'License Level should not be Blank';
        Exit;
      end;

      if CloudUserName = '' then begin
        RegisterErr := 'User Name should not be Blank';
        Exit;
      end;

      if CloudPassword = '' then begin
        RegisterErr := 'Password Should not be Blank';
        Exit;
      end;

      if FirstName = '' then begin
        RegisterErr := ' First Name should not be Blank';
        Exit;
      end;

      if LastName = '' then begin
        RegisterErr := 'Last Name Should not be Blank';
        Exit;
      end;

      if RegionName = '' then begin
        RegisterErr := 'Region Name Should not be Blank';
        Exit;
      end;

      if (Paymentamount = 0) and (PayMethod ='') then begin
        RegisterErr := 'Payment Method is not Provided';
        Exit;
      end;

      conn := TMyDAcDataconnection.Create(nil);
      try
        Log('Connection :' + InttoStr(Integer(conn)));
        conn.Connection := fconn;
        if not VerifyModulestoAdd(conn) then Exit;

        VS1_Clients     := TVS1_Clients.Create(Self)    ; VS1_Clients.Connection      := conn;
        VS1_ClientUsers := TVS1_ClientUsers.Create(Self); VS1_ClientUsers.Connection  := conn;
        VS1_Database    := tVS1_databases.Create(Self)  ; VS1_Database.Connection     := conn;
        VS1_Sampledb    := tVS1_databases.Create(Self)  ; VS1_Sampledb.Connection     := conn;

        Customer        := TCustomer.Create(Self)       ;
        try
          Customer.Connection := conn;
          Customer.IgnoreAccesslevel := True;
          conn.BeginTransaction;
          try
            CustomerExists := False;
            Customer.LoadSelect('Company = ' + QuotedStr(ClientName));
            if Customer.Count > 0 then begin
              CustomerExists := True;
              fiVs1_ClientID := Customer.ID;
              VS1_Clients.LoadSelect('ClientName = ' + QuotedStr(ClientName));
//              RegisterErr := QuotedStr(ClientName) + ' Already Exists';
//              Exit;
            end;

            UserExists := False;
            aDateTo := LicenseMonthEnd(aDatefrom, VS1_Clients.LicenseMonths);
            VS1_ClientUsers.LoadSelect('EmailId = ' + QuotedStr(CloudUserName));
            if VS1_ClientUsers.Count > 0 then begin
              UserExists := True;
//              RegisterErr := QuotedStr(CloudUserName) + ' Already Exists for Another Client';
//              Exit;
            end;

            if NeedSampleDB then begin
              VS1_ClientUsers.LoadSelect('EmailId = ' + QuotedStr(CloudSampleDBUserName));
              if VS1_ClientUsers.Count > 0 then begin
                RegisterErr := QuotedStr(CloudSampleDBUserName) + ' Already Exists for Another Client';
                Exit;
              end;
            end;

            fsDbName := '';
            fsSampledbname := '';
            fsServername := fconn.server;

            if not CustomerExists then begin
              fiVs1_ClientID := MakeVS1Customer;
              if fiVs1_ClientID = 0 then begin
                RegisterErr := 'Failed to Create VS1 Customer ';
                Log(RegisterErr);
                Exit;
              end;
            end;

            if VS1_ClientDbServers.Count = 0 then begin
              RegisterErr := 'No Server Assigned for Region ' + QuotedStr(Regionname);
              Exit;
            end;

            { TODO : Lock database record on reading , so that another request cant access it }
            VS1_Database.LoadSelect('Regionname = ' + QuotedStr(RegionName) +
                         ' AND Status = "Available"' +
                         ' AND DatabaseName LIKE "' + NewcloudDBName(False, True) + '%"'+
                         ' AND Servername = ' + QuotedStr(VS1_ClientDbServers.ServerName));

            if (CreateNewDB = 'T' ) or (VS1_Database.Count < 1) then begin
              Log('Creating A New Database ');
              if not MakeNewdatabseForRegion(VS1_Database, aOnEvent) then begin
                RegisterErr := 'Failed to Create a New Database';
                Exit;
              end;

              Log('Databse Created :' + VS1_Database.DatabaseName);
            end else begin
              fsServername := VS1_Database.ServerName;

//              //if ERPDBServerName = '' then // if existing database is used, do not initialise it
//              if not VS1_InitNewDatabase(aOnEvent, VS1_Database, True, Vs1_RegoJson, JsResultStr) then begin
//                RegisterErr := 'Failed to Assign Available Database ' + VS1_Database.Servername + ':' + VS1_Database.Databasename + NL + JsResultStr;
//                Exit;
//              end;

              Log('Using Existing Databse : ' + VS1_Database.DatabaseName);

              jsnewUser := JO;
              try
                jsnewUser.S[VS1_TAG_VS1UserName] := CloudUserName;
                jsnewUser.S[VS1_TAG_VS1Password] := CloudPassword;
                jsnewUser.S[VS1_TAG_ModuleName] := VS1_MODULE_Add_Extra_User;
                jsnewUser.F[VS1_TAG_Paymentamount] := 0;
                jsnewUser.S[VS1_TAG_PayMethod] := '';
                jsnewUser.O[VS1_TAG_EmployeeDetails]:= JO;
                jsnewUser.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_FirstName]   := Firstname;
                jsnewUser.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_LastName]    := Lastname;
                jsnewUser.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_PhoneNumber] := PhoneNumber              ;
                jsnewUser.O[VS1_TAG_EmployeeDetails].DT[VS1_TAG_DateStarted]:= DateStarted;
                //jsnewUser.O[VS1_TAG_EmployeeDetails].DT[VS1_TAG_LicenseExtensionTo]:= LicenseExtensionTo;
                jsnewUser.O[VS1_TAG_EmployeeDetails].DT[VS1_TAG_DOB]        := DOB;
                jsnewUser.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_Sex]         := Sex;
                jsnewUser.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_Country]     := RegionName;
                jsnewUser.S[VS1_TAG_ClientName] := ClientName;
              (* jsnewUser.S[VS1_TAG_ERPDBServerName] := ERPDBServerName;
                jsnewUser.S[VS1_TAG_ERPDBDatabaseName] := ERPDBDatabaseName;
                jsnewUser.I[VS1_TAG_ERPDBPortnumber] := ERPDBPortnumber;
                jsnewUser.B[VS1_TAG_ERPDBIsPortHttps] := ERPDBIsPortHttps;*)
                jsnewUser.S[VS1_TAG_DatabaseName] := VS1_Database.DatabaseName;
                jsnewUser.S[VS1_TAG_ServerName] := VS1_Database.ServerName;
                jsnewUser.O[VS1_TAG_ERPLoginDetails] := JO;
                jsnewUser.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName] := utVS1Const.ERP_VS1CLOUD_DEFAULT_USER;
                jsnewUser.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPPassword] := utVS1Const.ERP_VS1CLOUD_DEFAULT_TOKEN;
                fiVS1EmployeeID := ClientEmployeeID(VS1_Database, jsnewUser, JsResultStr);
                if fiVS1EmployeeID = 0 then begin
                  RegisterErr := 'Failed to Create User / Employee. ' + JsResultStr;
                  Exit;
                end;
              finally
                jsnewUser.free;
              end;
            end;  // Database exists

            VS1_Database.Status := VS1_DB_Status_Used;
            VS1_Database.UsedOn := aDateFrom;
            VS1_Database.Vs1_ClientID := fiVs1_ClientID;
            VS1_Database.ClientID := VS1_Clients.ID;
            VS1_Database.PostDB;

            if NeedSampleDB then begin
              VS1_Sampledb.LoadSelect('Regionname = ' + QuotedStr(RegionName) +
                         ' and  Status = "Available"' +
                         ' and DatabaseName LIKE "' +  NewcloudDBName(True, True) + '%"' +
                         ' and Servername =' + QuotedStr(VS1_ClientDbServers.Servername));

              if (CreateNewDB = 'T' ) or (VS1_Sampledb.Count < 1 ) then begin
                if not MakeNewSampledatabseForRegion(VS1_Sampledb, aOnEvent) then begin
                  RegisterErr := 'Failed to Create a New Database';
                  Exit;
                end;
                Log('Sample Databse created :' + VS1_Sampledb.DatabaseName);
              end else begin
                Log('Using Existing Sample Databse :' + VS1_Sampledb.DatabaseName);
              end;

              VS1_Sampledb.Status := VS1_DB_Status_Used;
              VS1_Sampledb.UsedOn := aDateFrom;
              VS1_Sampledb.PostDB;
              VS1_Sampledb.Vs1_ClientID := VS1_Database.Vs1_ClientID;
              VS1_Sampledb.PostDB;
            end;

            if not CustomerExists then begin
              Log('Make Vs1 License For : ' + ClientName);

              VS1_Clients.New;
              VS1_Clients.ClientName                := ClientName;
              VS1_Clients.RegistrationDate          := aDateFrom;
              VS1_Clients.VS1ClientName             := Clientname;
              VS1_Clients.Vs1ClientID               := VS1_Database.Vs1_ClientID ;
              VS1_Clients.CreditCardType            := CreditCardType;
              VS1_Clients.CreditCardCardHolderName  := CreditCardCardHolderName;
              VS1_Clients.CreditCardNumber          := CreditCardNumber;
              VS1_Clients.CreditCardExpirymonth     := CreditCardExpirymonth;
              VS1_Clients.CreditCardExpiryyear      := CreditCardExpiryyear;
              VS1_Clients.CreditCardCVC             := CreditCardCVC;
              VS1_Clients.CreditCardNotes           := CreditCardNotes;
              VS1_Clients.ServerName                := fsServername;
              VS1_Clients.DatabaseID                := VS1_Database.ID;
              VS1_Clients.ApiPort                   := VS1_Database.APIPort;
              VS1_Clients.IsHttps                   := VS1_Database.IsHttps;
              VS1_Clients.Databasename              := VS1_Database.Databasename;
              VS1_Clients.SampleDatabaseID          := VS1_Sampledb.ID;
              VS1_Clients.Sampledatabasename        := VS1_Sampledb.Databasename;
              VS1_Clients.RegionName                := RegionName;
              VS1_Clients.Active                    := True;
              VS1_Clients.LicenseRenewDuration      := LicenseRenewDuration;
              VS1_Clients.LicenseRenewDurationtype  := LicenseRenewDurationType;
              VS1_Clients.PostDB;

              // Store he ClientID in VS1_DB
              VS1_Database.ClientID := VS1_Clients.ID;
              VS1_Database.PostDB;

              aDateTo := LicenseMonthEnd(aDatefrom, VS1_Clients.LicenseMonths);
              VS1_Clients.ClientUsers.New;
              VS1_Clients.ClientUsers.DatabaseName  := VS1_Clients.Databasename;
              VS1_Clients.ClientUsers.EmailId       := CloudUserName;
              VS1_Clients.ClientUsers.Phone         := PhoneNumber;
              VS1_Clients.ClientUsers.Password      := CloudPassword;
              VS1_Clients.ClientUsers.Firstname     := Firstname;
              VS1_Clients.ClientUsers.LastName      := LastName;
              VS1_Clients.ClientUsers.Active        := True;
              VS1_Clients.ClientUsers.IsAdminUser   := True;
              VS1_Clients.ClientUsers.VS1EmployeeID := fiVS1EmployeeID;
              VS1_Clients.LicenseFrom               := aDateFrom;
              VS1_Clients.LicenseUntil              := aDateFrom; //aDateTo;
              VS1_Clients.LicenseLevel              := LicenseLevel;
              VS1_Clients.ClientUsers.PostDB;
            end;

            if DoEnableStS(VS1_Clients.ClientUsers , fsEnableStSStatus) then begin
              AddEventdata(aOnEvent, TAG_ResponseStatus, 'Database is initialialised with Seed To Sale Defaults', True);
            end;

            VS1_Clients.ClientPayments.New;
            VS1_Clients.ClientPayments.DateFrom := aDateFrom;
            VS1_Clients.ClientPayments.DateTo   := aDateFrom;//aDateTo;
            VS1_Clients.ClientPayments.PostDB;

            //fdTotalPrice := 0;
            //DiscountedPrice :=0;
            if NeedSampleDB then begin
              VS1_Clients.ClientUsers.New;
              VS1_Clients.ClientUsers.DatabaseName := VS1_Clients.Sampledatabasename;
              VS1_Clients.ClientUsers.EmailId      := CloudSampleDBUserName;
              VS1_Clients.ClientUsers.Password     := CloudSampleDBPassword;
              VS1_Clients.ClientUsers.Active       := True;
              VS1_Clients.ClientUsers.IsAdminUser  := True;
              VS1_Clients.ClientUsers.PostDB;
              if DoEnableStS(VS1_Clients.ClientUsers , fsEnableStSStatus) then begin
                AddEventdata(aOnEvent, TAG_ResponseStatus, 'Database is initialialised with Seed To Sale Defaults', true);
              end;
            end;

            jsModules := JO;
            try
              AddVS1_Module(VS1_Clients, jsModules, 0, nil, VS1_Database.Databasename);
              AddVS1_Modules(VS1_Clients, jsModules, VS1_Database.Databasename);
              AddEventdata(aOnEvent, TAG_Obj, jsModules.AsString, True, 'VS1 Modules');
            finally
              jsModules.Free;
            end;

            if MakeinvnApplyPayment(VS1_Clients, aOnEvent, Paymentamount (*fdPrice,fdDiscountedPrice *), aDateFrom, aDateto, conn, nil, True, alogger) then begin
              Conn.CommitTransaction;
              AddEventdata(aOnEvent,VS1_TAG_ServerName  ,VS1_ClientDbServers.ServerName       , True);
              AddEventdata(aOnEvent,VS1_TAG_APIPort     ,inttostr(VS1_ClientDbServers.APIPort), True);
              AddEventdata(aOnEvent,VS1_TAG_DatabaseName,VS1_Database.DatabaseName                  , True);
              if NeedSampleDB then begin
                AddEventdata(aOnEvent,VS1_TAG_SampleDatabaseName, VS1_Clients.Sampledatabasename, True);
              end;
              AddEventdata(aOnEvent,TAG_ResponseNo,VS1_HTTP_Success_STRCode, true);
              AddEventdata(aOnEvent,TAG_ResponseStatus, 'OK', true);

              Sleep(200);
              MakeExtraDB;

              Log('New Registration Finished for : ' + ClientName);
              if Assigned(aOnEvent) then aOnEvent('ThreadEvent', 'OnVS1_NewRegocomplete');

            end;
          except
            on E:Exception do begin
              Log('Erorr In New Registration: ' + E.message);
              Conn.RollbackTransaction;
            end;
          end;
        finally
          if Conn.connection.intransaction then begin
            // this is when there is a invalid parameter and exit
            Conn.RollbackTransaction;
          end;
          FreeandNil(Customer);
          FreeandNil(VS1_ClientUsers);
          FreeandNil(VS1_Clients);
          FreeandNil(VS1_Database);
          FreeandNil(VS1_Sampledb);
          Log('Free Objects');
        end;
      except
        on E:Exception do begin
          Log('Erorr In New Registration: ' + E.message);
          RegisterErr := E.message;
        end;
      end;
    finally
      FreeandNil(conn);
    end;
  finally
    if Trim(RegisterErr) <> '' then begin
      AddEventdata(aOnEvent, TAG_ResponseNo, VS1_HTTP_Failed_STRCode, True);
      AddEventdata(aOnEvent, TAG_ResponseError, RegisterErr, True);
    end;
  end;
end;

function TVS1_Rego.RegionalOption(aWhere:String =''): TRegionalOptions;
var
  fsSelect :String;
begin
  if fRegionalOption = nil then begin
    fRegionalOption:= TRegionalOptions.Create(Self);
    fRegionalOption.Load(0);
  end;
  fsSelect :='Region = ' +quotedstr(RegionName);
  if aWhere <> '' then begin
     if fsSelect <> '' then fsSelect := fsSelect +' and ';
     fsSelect := fsSelect + '(' +aWhere +')';
  end;

  if not(sametext(fRegionalOption.SQLSelect , fsSelect)) then
     fRegionalOption.LoadSelect( fsSelect);
  result := fRegionalOption;
end;

procedure TVS1_Rego.SetLicenseRenewDuration(const Value: Integer);
begin
  fiLicenseRenewDuration := Value;
  if fiLicenseRenewDuration <1 then fiLicenseRenewDuration := 1;
end;

procedure TVS1_Rego.SetLicenseRenewDurationType(const Value: String);
begin
  fsLicenseRenewDurationType := Value;
  if (Value <>'M') and (Value <> 'Y') then fsLicenseRenewDurationType := 'M';
end;

Procedure TVS1_Rego.Vs1_RegoJson(Js: TJsonObject);
begin
     Js.S[VS1_TAG_ClientName]               := ClientName               ;
     (*Js.S[VS1_TAG_ERPDBServerName]          := ERPDBServerName          ;
     Js.S[VS1_TAG_ERPDBDatabaseName]        := ERPDBDatabaseName        ;
     Js.I[VS1_TAG_ERPDBPortnumber]          := ERPDBPortnumber          ;
     Js.B[VS1_TAG_ERPDBIsPortHttps]         := ERPDBIsPortHttps         ;*)
     Js.I[VS1_TAG_LicenseLevel]             := LicenseLevel             ;
     Js.S[VS1_TAG_LicenseLevelDesc]         := LicenseLevelDesc         ;
     Js.S[VS1_TAG_CloudUserName]            := CloudUserName            ;
     Js.S[VS1_TAG_PhoneNumber]              := PhoneNumber              ;
     Js.DT[VS1_TAG_DateStarted]             := DateStarted              ;
     Js.DT[VS1_TAG_LicenseExtensionTo]      := LicenseExtensionTo       ;
     Js.DT[VS1_TAG_DOB]                     := DOB                      ;
     Js.S[VS1_TAG_CloudSampleDBUserName]    := CloudSampleDBUserName    ;
     Js.S[VS1_TAG_CloudPassword]            := CloudPassword            ;
     Js.S[VS1_TAG_CloudSampleDBPassword]    := CloudSampleDBPassword    ;
     Js.S[VS1_TAG_FirstName]                := FirstName                ;
     Js.S[VS1_TAG_LastName]                 := LastName                 ;
     Js.S[VS1_TAG_Sex]                      := Sex                      ;
     Js.S[VS1_TAG_RegionName]               := RegionName               ;
     Js.S[VS1_TAG_CreditCardType]           := CreditCardType           ;
     Js.S[VS1_TAG_CreditCardCardHolderName] := CreditCardCardHolderName ;
     Js.S[VS1_TAG_CreditCardNumber]         := CreditCardNumber         ;
     Js.S[VS1_TAG_CreditCardNotes]          := CreditCardNotes          ;
     Js.S[VS1_TAG_CreditCardCVC]            := CreditCardCVC            ;
     Js.I[VS1_TAG_CreditCardExpiryMonth]    := CreditCardExpiryMonth    ;
     Js.I[VS1_TAG_LicenseRenewDuration]     := LicenseRenewDuration     ;
     JS.F[VS1_TAG_Paymentamount]            := Paymentamount            ;
     JS.S[VS1_TAG_PayMethod]                := PayMethod            ;
     Js.I[VS1_TAG_CreditCardExpiryYear]     := CreditCardExpiryYear     ;
     Js.S[VS1_TAG_CreateNewDB]              := CreateNewDB              ;
     Js.S[VS1_TAG_LicenseRenewDurationType] := LicenseRenewDurationType ;
     Js.S[VS1_TAG_LicenseExtensionDesc]     := LicenseExtensionDesc     ;
     Js.B[VS1_TAG_AdjustmentExtension]      := AdjustmentExtension;
     Js.I[VS1_TAG_LicenseRenewDuration]     := LicenseRenewDuration     ;
     Js.B[VS1_TAG_MakingExtraDB]            := MakingExtraDB            ;
     Js.B[VS1_TAG_IsSampleDB]               := IsSampleDB               ;
end;
procedure TVS1_Rego.VS1_Renew(aOnEvent: TEventProc; aLogger: TLoggerBase);
var
  aVS1_ClientUsers :TVS1_ClientUsers;
  fiInvoiceID: Integer;
  fiCustpaymentID: Integer;
  fdDateFrom, fdDateTo:TDatetime;
  Conn : TMyDAcDataconnection;

begin
    AddEventdata(aOnEvent ,TAG_ResponseTask     , 'VS1 Renew');
      conn := TMyDAcDataconnection.Create(nil);
      try
        conn.Connection := fconn;

      try
        aVS1_ClientUsers:= TVS1_ClientUsers.Create(self);
        try
            aVS1_ClientUsers.connection := TMyDAcDataconnection.Create(aVS1_ClientUsers);
            aVS1_ClientUsers.connection.connection := fConn;
            aVS1_ClientUsers.LoadSelect('EmailId =' + quotedstr(CloudUserName));
            if aVS1_ClientUsers.count =0 then begin
              AddEventdata(aOnEvent ,TAG_ResponseNo     , VS1_HTTP_Failed_STRCode   , true);
              AddEventdata(aOnEvent ,TAG_ResponseStatus , 'User Credentials Invalid', true);
              AddEventdata(aOnEvent ,TAG_ResponseError  , 'User Credentials Invalid', true);
              Exit;
            end;
            aVS1_ClientUsers.connection.begintransaction;
            try
              if aVS1_ClientUsers.VS1_Client.LicenseUntil =0 then fdDateFrom := date
              else fdDateFrom := incday(aVS1_ClientUsers.VS1_Client.LicenseUntil, 1);
              if (LicenseExtensionTo<>0) and (LicenseExtensionTo>fdDateFrom) then
                    fdDateTo := LicenseExtensionTo
              else  fdDateTo :=LicenseMonthEnd(fdDateFrom , aVS1_ClientUsers.VS1_Client.LicenseMonths );

              //CalcModuleTotals(aVS1_ClientUsers.VS1_Client);
              aVS1_ClientUsers.VS1_Client.CopyModulesToHistory;

              if MakeinvnApplyPayment(aVS1_ClientUsers.VS1_Client, aOnEvent,(*fdPrice,fdDiscountedPrice, *)Paymentamount , fdDateFrom, fdDateTo, conn, nil, true, aLogger) then begin
                Conn.CommitTransaction;
              end;
          Except
            on E:Exception do begin
              aVS1_ClientUsers.connection.Rollbacktransaction;
              AddEventdata(aOnEvent ,TAG_ResponseError     , E.message, true);
            end;
          end;
        finally
          freeandnil(aVS1_ClientUsers);
        end;
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent ,TAG_ResponseError     , E.message, true);
        end;
      end;
    finally
      FreeandNil(conn);
    end;
end;

function TVS1_Rego.VS1_RegoJson: String;
var
  Js: TJsonObject;
begin
  Js := JO;
  try
     VS1_RegoJson(Js);
     Result := Js.AsString;
  finally
    Js.Free;
  end;

end;

end.
