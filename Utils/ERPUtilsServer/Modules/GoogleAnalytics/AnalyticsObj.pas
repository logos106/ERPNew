unit AnalyticsObj;

interface

uses
  classes, IdHttp, JsonObject, ERPDBComponents, LogThreadBase, LogMessageTypes;

type

  TDbTransType = (transNone, transSavepoint, transNormal);
  TGetTerminatedEvent = procedure (var IsTerminated: boolean) of object;


  TGoogleAnalytics = class
  private
    Client: TIdHttp;
    fAccounts: TJsonArray;
    FConnection: TERPConnection;
    FDbConn: TErpConnection;
    FDbDatabaseName: string;
    FDbServerName: string;
    FDbTransType: TDbTransType;
    fLogger: TLoggerBase;
    fOnGetTerminated: TGetTerminatedEvent;
    function GetAccounts: TJsonArray;
    procedure SetConnection(const Value: TERPConnection);
    function DBConn: TERPConnection;
    procedure SetDbDatabaseName(const Value: string);
    procedure SetDbServerName(const Value: string);
    procedure BeginDbTrans;
    procedure CommitDbTrans;
    procedure RollbackDbTrans;
    procedure Log(const msg: string;  const LogMessageType: TLogMessageType = ltBlank);
    function GetImpressions(aDate: TDateTime; Profile: TJsonObject; var msg: string): boolean;
    function GetData(aDate: TDateTime; Profile: TJsonObject; var msg: string): boolean;
    function GetDataForCharts(aDate: TDateTime; Profile: TJsonObject;var msg: string): boolean;
    function Getdatecheked(aDate: TDateTime; Profile: TJsonObject;var msg: string): boolean;
    function GetDataForSummary(aDate: TDateTime; Profile: TJsonObject; var msg: string): boolean;
    function GetdataforCost(aDate: TDateTime; Profile: TJsonObject;var msg: string): boolean;
    function GetAnalyticsEnabled: boolean;
    function GetLoggingLevel: TLoggingLevel;
    function CheckUpdateAccountAuth(Acc: TJsonObject): boolean;
    function ExtractData(GaDataIn: TJsonObject): TJsonObject;
    function Terminated: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property DbServerName: string read FDbServerName write SetDbServerName;
    property DbDatabaseName: string read FDbDatabaseName write SetDbDatabaseName;
    property Connection: TERPConnection read FConnection write SetConnection;
    property Accounts: TJsonArray read GetAccounts;
    function ProfileById(Account: TJsonObject; ProfileId: string): TJsonObject;
    function UpdateAccount(const EmailAddress, Password, AccountID: string; const Active: boolean; var msg: string): boolean;
    procedure CheckForNewData;
    property Logger: TLoggerBase read fLogger write fLogger;
    property AnalyticsEnabled: boolean read GetAnalyticsEnabled;
    property LoggingLevel: TLoggingLevel read GetLoggingLevel;
    property OnGetTerminated: TGetTerminatedEvent read fOnGetTerminated write fOnGetTerminated;
  end;


implementation

uses
  IdSSLOpenSSL, MySQLUtils, AnalyticsDb, SysUtils, Forms, Variants, dateutils,
  HTTPConst;

const
  Version = '9.0.0.2';
  UserAgent = 'TrueERP Analytics/' + Version + ' (compatible; Indy Library)';
  APIKey = 'AIzaSyC0_PSP02PRqWmjAhm0ng4if1zWzDg0FHc';   { key=APIKey }


procedure FormatJson(strings: TStrings);
var
  x: integer;
  ident: integer;
  isObj: boolean;

  function PadStr: string;
  var y: integer;
  begin
    result:= '';
    for y:= 0 to ident -1 do
      result:= result + '    ';
  end;

begin
  ident:= 0;
  for x:= 0 to strings.Count-1 do begin
    if (Pos('}',strings[x]) = 1) and (ident > 0) then
      dec(ident);
    isObj:= Pos('{',strings[x]) = 1;
    strings[x]:= PadStr + strings[x];
    if IsObj then Inc(ident);
  end;
end;

procedure FormatAndSaveJson(Json: TJsonObject; aFileName: string);
var
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    sl.Text:= Json.AsString;
    FormatJson(sl);
    sl.SaveToFile(aFileName);
  finally
    sl.Free;
  end;
end;

{ ga date format: 20110624 }
function GaDateToDate(GaDate: string): TDate;
begin
  result:= EncodeDate(StrToInt(Copy(GADate,1,4)),StrToInt(Copy(GADate,5,2)),StrToInt(Copy(GADate,7,2)));
end;

function StrToQueryStr(s: string): string;
var
  x: integer;
begin
  result:= '';
  for x:= 1 to Length(s) do begin
    case Ord(s[x]) of
      34: result:= result + '""';  // " char
      92: result:= result + '\\';  // \ char
      else
        result:=result + s[x];
    end;
  end;
end;

{ TGoogleAnalytics }

function TGoogleAnalytics.UpdateAccount(const EmailAddress, Password, AccountID: string;
  const Active: boolean; var msg: string): boolean;
var
  x, y: integer;
  Acc, Profile, obj, AccItem, ProfsObj, ProfItem: TJsonObject;
  sl, authList: TStringList;
  ProfileId: string;
  s: string;
begin
  result:= true;
  { make sure account does not already exist }
  Acc:= nil;
  if AccountID <> '' then begin
    for x := 0 to Accounts.Count -1 do begin
      Acc:= Accounts.Items[x].AsObject;
      if SameText(Acc.O['fields'].S['AccountId'],AccountID) then begin
        if SameText(Acc.O['fields'].S['Password'],Password) then begin
          { account already exists for email and password }
          { check if active changed }
          if Acc.O['fields'].B['Active'] <> Active then begin
            Acc.O['fields'].B['Active']:= Active;
          end;
        end
        else begin
          { password changed }
          Acc.O['fields'].S['Password']:= Password;
        end;
        break;
      end
      else
        Acc:= nil;
    end;
  end;

  if ((not Assigned(Acc)) or Acc.O['fields'].B['Active']) then begin

    { get Auth code }
    sl:= TStringList.Create;
    authList:= TStringList.Create;
    try
      sl.Values['accountType']:= 'GOOGLE';
      sl.Values['Email']:= EmailAddress;
      sl.Values['Passwd']:= Password;
      sl.Values['service']:= 'analytics';
      sl.Values['source']:= UserAgent;
      sl.Values['key']:= APIKey;


      try
        authList.Text := Client.Post('https://www.google.com/accounts/ClientLogin',sl);
      except
        on e: exception do begin
          result:= false;
          msg:= 'Error getting authorisation code from Google: ' +  e.Message;
          exit;
        end;
      end;

      if Assigned(Acc) then
        Acc.O['fields'].S['Auth']:= authList.Values['Auth'];

      Client.Request.CustomHeaders.AddValue('Authorization','GoogleLogin auth='+ authList.Values['Auth']);

      { get list of accounts associated with this user }
      obj:= JO;
      try
        try
          s:= Client.Get('https://www.googleapis.com/analytics/v3/management/accounts?key='+APIKey);
          obj.AsString:= s;
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error getting account information from Google: ' +  e.Message;
            exit;
          end;
        end;

        for x := 0 to obj.A['items'].Count-1 do begin
          AccItem:= obj.A['items'].Items[x].AsObject;
          if AccountID <> '' then begin
            { we are updating an existing account }
            if AccItem.S['id'] <> AccountID then
              { not the one we want }
              Continue;
          end
          else begin
            { new account }
            Acc:= JO;
            Acc.S['type']:= 'TGAAccount';
            Acc.O['fields'].B['Active']:= Active;
            Acc.O['fields'].S['EmailAddress']:= EmailAddress;
            Acc.O['fields'].S['Password']:= Password;
            Acc.O['fields'].S['AccountId']:= AccItem.S['id'];
            Acc.O['fields'].S['AccountName']:= AccItem.S['name'];
            Accounts.Add(Acc);
          end;
          { now profiles for this account }
          ProfsObj:= Jo;
          try
            try
              s:= Client.Get('https://www.googleapis.com/analytics/v3/management/accounts/' + Acc.O['fields'].S['AccountId']+ '/webproperties/~all/profiles?key='+APIKey);
              ProfsObj.AsString:= s;
            except
              on e: exception do begin
                result:= false;
                msg:= 'Error getting account profile information from Google: ' +  e.Message;
                exit;
              end;
            end;

            sl.Clear;
            for y := 0 to ProfsObj.A['items'].Count -1 do begin
              ProfItem:= ProfsObj.A['items'].Items[y].AsObject;
              ProfileId:= ProfItem.S['id'];
              if ProfileId <> '' then begin
                sl.Add(ProfileId); { keep a list of active properties }
                Profile:= ProfileById(Acc,ProfileId);
                if not Assigned(Profile) then begin
                  { this is a new profile }
                  Profile:= JO;
                  Profile.S['type']:= 'TGAProfile';
                  Profile.O['fields'].S['ProfileId']:= ProfileId;
                  Acc.O['fields'].A['Profiles'].Add(Profile);
                end;
                Profile.O['fields'].S['Title']:= ProfItem.S['name'];
                Profile.O['fields'].S['WebPropertyId']:= ProfItem.S['webPropertyId'];
                Profile.O['fields'].S['Currency']:= ProfItem.S['currency'];
                Profile.O['fields'].S['TimeZone']:= ProfItem.S['timeZone'];
                Profile.O['fields'].S['TableId']:= ''; // no longer used
                Profile.O['fields'].B['Active']:= true;
              end;
            end;
            { now flag inactive profiles }
            for y := 0 to Acc.O['fields'].A['Profiles'].Count -1 do begin
              Profile:= Acc.O['fields'].A['Profiles'].Items[y].AsObject;
              if sl.IndexOf(Profile.O['fields'].S['ProfileId']) < 0 then
                Profile.O['fields'].B['Active']:= false;
            end;
          finally
            ProfsObj.Free;
          end;
        end;

      finally
        obj.Free;
      end;
    finally
      sl.Free;
      authList.Free;
    end;
  end;
  if Assigned(Acc) then begin
    { save this account }
    self.BeginDbTrans;
    try
      try
        AnalyticsDb.Save(Acc,DbConn);
      except
        on e: exception do begin
          result:= false;
          msg:= 'Error saving account information to database: ' +  e.Message;
          self.RollbackDbTrans;
          exit;
        end;
      end;
    finally
      self.CommitDbTrans;
    end;
  end;
end;

procedure TGoogleAnalytics.BeginDbTrans;
begin
  if DbConn.InTransaction then begin
    DbConn.Savepoint(ClassName + '_' + IntToStr(Integer(self)));
    FDbTransType:= transSavepoint;
  end
  else begin
    DbConn.StartTransaction;
    fDbTransType:= transNormal;
  end;
end;
procedure TGoogleAnalytics.CheckForNewData;
var
  Acc, Profile: TJsonObject;
  AccIdx, ProfileIdx: integer;
  URL: string;
  obj, GASumm: TJsonObject;
  EntryArray: TJsonArray;
  EntryIdx: integer;
  Entry: TJsonObject;
  ga_date: string;
  aDate: TDate;
  ProfileId: string;
  msg: string;
  s: string;
  InData: TJsonObject;
  t1, t2, dt1, dt2: TDateTime;
begin
  t1 := now;
  Log('Checking for new data ..',ltInfo);
  obj:= JO;
  GASumm:= JO;
  try
    for AccIdx := 0 to Accounts.Count -1 do begin
      Acc:= Accounts.Items[AccIdx].AsObject;
      if not Acc.O['fields'].B['Active'] then
        continue;
      for ProfileIdx := 0 to Acc.O['fields'].A['Profiles'].Count -1 do begin
        Profile:= Acc.O['fields'].A['Profiles'].Items[ProfileIdx].AsObject;
        if not Profile.O['fields'].B['Active'] then  continue;
        ProfileId:= Profile.O['fields'].S['ProfileId'];

        Client.Request.CustomHeaders.AddValue('Authorization','GoogleLogin auth='+ Acc.O['fields'].S['Auth']);
        dt1:= lastDatechecked(DBConn , ProfileId);
        if dt1> incday(now, -7) then dt1 :=incday(now, -7) ; // dene wants to check for last 7 days (instead of 3)
        dt2:= now;
        {since a http query for a higher date range can cause issues, checking for 3 days at a time}
        While dt1<dt2 do begin
          if Terminated then exit;
          { grab summary data for last 3 days }
          URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
            'ids=' + 'ga:' + ProfileId + '&' +
            'metrics=ga:visits,ga:impressions' + '&' +
            'dimensions=ga:date' + '&' +
            'start-date=' + FormatDateTime('yyyy-mm-dd',(*now-2*)dt1-2) + '&' +
            'end-date=' + FormatDateTime('yyyy-mm-dd',(*now*)dt1);

          try
            s:= Client.Get(URL + '&key='+APIKey);
            obj.AsString:= s;
          except
            on e: exception do begin
  //            if Pos('token expired',Lowercase(e.Message)) > 0 then begin
                if CheckUpdateAccountAuth(Acc) then begin
                  { try again }
                  Client.Request.CustomHeaders.Values['Authorization']:= 'GoogleLogin auth='+ Acc.O['fields'].S['Auth'];
                  try
                    obj.AsString:= Client.Get(URL + '&key='+APIKey);
                  except
                    on e: exception do begin
                      Log('Error getting data from Google server for Account: ' +
                        Acc.O['fields'].S['AccountName'] + ' Profile: ' +
                        Profile.O['fields'].S['Title'] + ' message: ' + e.Message ,ltError);
                        dt1:= incday(dt1, 2);
                      continue;
                    end;
                  end;
                end;
            end;
          end;


          InData:= ExtractData(obj);
          try
            for EntryIdx := 0 to InData.A['data'].Count -1 do begin
              Entry:= InData.A['data'].Items[EntryIdx].AsObject;
              ga_date:= Trim(Entry.S['ga:date']);
              if Length(ga_date) = 8 then begin
                aDate:= GaDateToDate(ga_date);
                { get the summary for this day }
                { check for changes }

{===============> impressions }
                AnalyticsDb.GetObject('TGASumm',GASumm,DbConn, 'where ProfileId = "' + ProfileId + '" and Date = "' + FormatDateTime('yyyy-mm-dd',adate) + '"');
                if GaSumm.O['fields'].I['Impressions'] <> Entry.ItemByName['ga:impressions'].Value.AsInteger then begin
                  BeginDbTrans;
                  try
                    Log(Profile.O['fields'].S['Title'] + ' Impressions changed for ' + FormatDateTime('yyyy-mm-dd',adate)+ ': ' + Entry.S['ga:impressions'],ltDetail);
                    if GetImpressions(aDate,profile,msg) then begin
                      GaSumm.O['fields'].ItemByName['Date'].Value.AsDateTime := aDate;
                      GaSumm.O['fields'].S['ProfileId']:= ProfileId;
                      GaSumm.O['fields'].I['Impressions']:= Entry.ItemByName['ga:impressions'].Value.AsInteger;
                      AnalyticsDb.Save(GaSumm,DbConn);
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;
                  except
                    on e: exception do begin
                      Log('Error updateing Impressions summary: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;
                end;

{===============> visits }
                AnalyticsDb.GetObject('TGASumm',GASumm,DbConn,'where ProfileId = "' + ProfileId + '" and Date = "' + FormatDateTime('yyyy-mm-dd',adate) + '"');
                if GaSumm.O['fields'].I['Visits'] <> Entry.ItemByName['ga:visits'].Value.AsInteger then begin
                    { get new data }
                  Log(Profile.O['fields'].S['Title'] + ' Visits changed for ' + FormatDateTime('yyyy-mm-dd',adate)+ ': ' + Entry.S['ga:visits'],ltDetail);
                  try
                    BeginDbTrans;
                    if GetData(aDate,profile,msg) then begin
                      { update summary data }
                      GaSumm.O['fields'].ItemByName['Date'].Value.AsDateTime := aDate;
                      GaSumm.O['fields'].S['ProfileId']:= ProfileId;
                      GaSumm.O['fields'].I['Visits']:= Entry.ItemByName['ga:visits'].Value.AsInteger;
                      AnalyticsDb.Save(GaSumm,DbConn);
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;

                  except
                    on e: exception do begin
                      Log('Error updateing Visits summary: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;

{===============> Data for chart}
                  Log(Profile.O['fields'].S['Title'] + ' Visits changed for ' + FormatDateTime('yyyy-mm-dd',adate)+ ': ' + Entry.S['ga:visits'],ltDetail);
                  try
                    BeginDbTrans;
                    if GetDataForCharts(aDate,profile,msg) then begin
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;
                  except
                    on e: exception do begin
                      Log('Error updateing Data for chart: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;

{===============> Data for Cost}
                  Log(Profile.O['fields'].S['Title'] + ' Visits changed for ' + FormatDateTime('yyyy-mm-dd',adate)+ ': ' + Entry.S['ga:visits'],ltDetail);
                  try
                    BeginDbTrans;
                    if GetdataforCost(aDate,profile,msg) then begin
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;
                  except
                    on e: exception do begin
                      Log('Error updateing Data for Cost: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;

{===============> data for Summary}
                  Log(Profile.O['fields'].S['Title'] + ' Visits changed for ' + FormatDateTime('yyyy-mm-dd',adate)+ ': ' + Entry.S['ga:visits'],ltDetail);
                  try
                    BeginDbTrans;
                    if GetDataForSummary(aDate,profile,msg) then begin
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;
                  except
                    on e: exception do begin
                      Log('Error updateing data for summary: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;
{===============> date checked}
                  try
                    BeginDbTrans;
                    if Getdatecheked(aDate,profile,msg) then begin
                      CommitDbTrans;
                    end else begin
                      RollbackDbTrans;
                      Log(msg,ltError);
                    end;
                  except
                    on e: exception do begin
                      Log('Error updateing Visits summaryDate checked: ' + e.Message,ltError);
                      RollbackDbTrans;
                    end;
                  end;
                end;
              end else begin
                Log('Invalid date format in Google Dimensions data: "' + ga_date + '"',ltError);
              end;
            end;
          finally
            InData.Free;
          end;
          dt1:= incday(dt1,2);
        end;
      end;
    end;
  finally
    obj.Free;
    GASumm.Free;
  end;
  t2 := now;
  Log('Done (' + FormatDateTime('hh:nn:ss zzz',t2-t1) + ')',ltInfo);
end;

function TGoogleAnalytics.CheckUpdateAccountAuth(Acc: TJsonObject): boolean;
var
  sl, authList: TStringList;
  auth: string;
begin
  result:= true;

  { get Auth code }
  sl:= TStringList.Create;
  authList:= TStringList.Create;
  try
    sl.Values['accountType']:= 'GOOGLE';
    sl.Values['Email']:= Acc.O['fields'].S['EmailAddress'];
    sl.Values['Passwd']:= Acc.O['fields'].S['Password'];
    sl.Values['service']:= 'analytics';
    sl.Values['source']:= UserAgent;
    sl.Values['key']:= APIKey;

    try
      authList.Text := Client.Post('https://www.google.com/accounts/ClientLogin',sl);
    except
      on e: exception do begin
        result:= false;
        Log('Error getting authorisation code from Google for Account: ' +
          Acc.O['fields'].S['AccountName'] + ' message: ' + e.Message,ltError);
        exit;
      end;
    end;

    auth:= authList.Values['Auth'];
    if Acc.O['fields'].S['Auth'] <> auth then begin
      Acc.O['fields'].S['Auth']:= auth;
      { save account }
      try
        AnalyticsDb.Save(Acc,DbConn);
      except
        on e: exception do begin
          result:= false;
        Log('Error saving account information to database for Account: ' +
          Acc.O['fields'].S['AccountName'] + ' message: ' + e.Message,ltError);
          self.RollbackDbTrans;
          exit;
        end;
      end;

    end;
  finally
    sl.Free;
    authList.Free;
  end;
end;

procedure TGoogleAnalytics.CommitDbTrans;
begin
  case FDbTransType of
    transNone: ;
    transSavepoint: DbConn.ReleaseSavepoint(ClassName + '_' + IntToStr(Integer(self)));
    transNormal: DbConn.Commit;
  end;
end;

constructor TGoogleAnalytics.Create;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
//  TLogger.Inst.LogAllTypes;
  FDbDatabaseName:= 'GoogleAnalytics';
  FDbServerName:= 'localhost';
  FDbTransType:= transNone;
  Client:= TIdHTTP.Create(nil);
  Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(Client);

  Client.IOHandler:= SSLHandler;
  SSLHandler.SSLOptions.Method:= sslvSSLv3;
  SSLHandler.SSLOptions.Mode:= sslmUnassigned;
  SSLHandler.SSLOptions.VerifyMode:= [];
  SSLHandler.SSLOptions.VerifyDepth:= 2;
  Client.ProxyParams.BasicAuthentication:= false;
  Client.Request.UserAgent := UserAgent;
  Client.Request.ContentType := 'application/x-www-form-urlencoded';
  Client.Request.host := 'www.google.com/analytics';
  Client.Request.connection := 'keep-alive';
  Client.Request.Accept := 'text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2';
end;

function TGoogleAnalytics.DBConn: TERPConnection;
begin
  if Assigned(fConnection) then
    result:= fConnection
  else begin
    if not Assigned(FDbConn) then begin
      FDbConn:= TERPConnection.Create(nil);
      FDbConn.Pooling := false;
      SetConnectionProps(FDbConn,FDbDatabaseName,FDbServerName);
    end;
    if FDbConn.Server <> FDbServerName then begin
      FDbConn.Disconnect;
      FDbConn.Server := FDbServerName;
    end;
    if FDbConn.Database <> FDbDatabaseName then begin
      FDbConn.Disconnect;
      FDbConn.Database := FDbDatabaseName;
    end;
    result:= FDbConn;
  end;
  if not result.Connected then
    result.Connect;
end;

destructor TGoogleAnalytics.Destroy;
begin
  Client.Free;
  FDbConn.Free;
  inherited;
end;

function TGoogleAnalytics.ExtractData(GaDataIn: TJsonObject): TJsonObject;
var
  cols: TStringList;
  x,y: integer;
  obj: TJsonObject;
  row: TJsonArray;
begin
  result:= JO;
  cols:= TStringList.Create;
  try
    { get list of column names }
    for x := 0 to GaDataIn.A['columnHeaders'].Count -1 do begin
      cols.Add(GaDataIn.A['columnHeaders'].Items[x].AsObject.S['name']);
    end;
    { get data }
    for x := 0 to GaDataIn.A['rows'].Count -1 do begin
      row:= TJsonArray(GaDataIn.A['rows'].Items[x]);
      obj:= JO;
      for y := 0 to row.Count-1 do begin
        obj.S[cols[y]]:= row.Items[y].AsString;
      end;
      result.A['data'].Add(obj);
    end;
  finally
    cols.Free;
  end;
end;

function TGoogleAnalytics.GetAccounts: TJsonArray;
begin
  if not Assigned(fAccounts) then begin
    fAccounts:= TJsonArray.Create;
    AnalyticsDb.GetList('TGAAccount',fAccounts,DbConn);
  end;
  result:= fAccounts;
end;

function TGoogleAnalytics.GetAnalyticsEnabled: boolean;
var
  vnt: Variant;
begin
  result:= false;
  try
    if Terminated then exit;
    vnt:= GetCompanyPref('GoogleAnalyticsEnabled',DbConn);
    if (not VarIsNull(Vnt)) then
      result:= vnt = 'T';
  except
  end;
end;

function TGoogleAnalytics.GetData(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  URL: string;
  obj,GaData: TJsonObject;
  EntryIdx: integer;
  Entry: TJsonObject;
  InData: TJsonObject;
const
  OneHour = 1/24;
begin
  result:= true;
  obj:= JO;
  GaData:= JO('{"type":"TGaData"}');
  try
    URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
      'ids=' + 'ga:' + Profile.O['fields'].S['ProfileId'] + '&' +
      'metrics=ga:visits,ga:newVisits,ga:pageViews,ga:timeOnSite' + '&' +
      'dimensions=ga:date,ga:hour,ga:keyword,ga:country,ga:browser,ga:operatingSystem' + '&' +
      'start-date=' + FormatDateTime('yyyy-mm-dd',aDate) + '&' +
      'end-date=' + FormatDateTime('yyyy-mm-dd',aDate); // + '&' +  'alt=json';

    try
      obj.AsString:= Client.Get(URL + '&key='+APIKey);
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error getting Analytics data: ' + e.Message;
        exit;
      end;
    end;

//    FormatAndSaveJson(obj,'c:\temp\google\google_data_' + Profile.O['fields'].S['Title'] + '.txt');
    if Terminated then exit;

    InData:= ExtractData(obj);
    try
      for EntryIdx := 0 to InData.A['data'].Count -1 do begin
        if Terminated then exit;
        Entry:= InData.A['data'].Items[EntryIdx].AsObject;
        { impressions }
        try
          AnalyticsDb.GetObject('TGaData',GaData,DbConn,
            'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' +
            ' and DateTime = "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',aDate + (OneHour * Entry.ItemByName['ga:hour'].Value.AsInteger))+ '"' +
            ' and Keyword = "' + StrToQueryStr(Entry.S['ga:keyword']) + '"' +
            ' and country = "' + Entry.S['ga:country'] + '"' +
            ' and Browser = "' + Entry.S['ga:browser'] + '"' +
            ' and OperatingSystem = "' + Entry.S['ga:operatingSystem'] + '"');

          if GaData.O['fields'].I['UId'] = 0 then begin
            GaData.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'];
            GaData.O['fields'].DT['DateTime']:= aDate + (OneHour * Entry.ItemByName['ga:hour'].Value.AsInteger);
            GaData.O['fields'].S['Keyword']:= Entry.S['ga:keyword'];
            GaData.O['fields'].S['country']:= Entry.S['ga:country'];
            GaData.O['fields'].S['Browser']:= Entry.S['ga:browser'];
            GaData.O['fields'].S['OperatingSystem']:= Entry.S['ga:operatingSystem'];
          end;

          { get Entry data }
          GaData.O['fields'].I['Visits']:= Entry.ItemByName['ga:visits'].Value.AsInteger;
          GaData.O['fields'].I['NewVisits']:= Entry.ItemByName['ga:newVisits'].Value.AsInteger;
          GaData.O['fields'].I['PageViews']:= Entry.ItemByName['ga:pageViews'].Value.AsInteger;
          GaData.O['fields'].I['TimeOnSite']:= Trunc(Entry.ItemByName['ga:timeOnSite'].Value.AsFloat);
          AnalyticsDb.Save(GaData,DbConn);
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error saving Analytics data: ' + e.Message;
            exit;
          end;
        end;
      end;
    finally
      InData.Free;
    end;

  finally
    obj.Free;
    GaData.Free;
  end;
end;


function TGoogleAnalytics.GetdataforCost(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  URL: string;
  obj,GaData: TJsonObject;
  EntryIdx: integer;
  Entry: TJsonObject;
  InData: TJsonObject;
begin
  result:= true;
  obj:= JO;
  GaData:= JO('{"type":"TGadataforCost"}');
  try
    URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
          'ids=' + 'ga:' + Profile.O['fields'].S['ProfileId'] + '&' +
          'metrics=ga:adCost,ga:costPerTransaction,ga:costPerConversion' + '&' +
          'dimensions=ga:campaign,ga:adGroup,ga:adwordsCampaignId,ga:adwordsAdGroupId,ga:date' + '&' +
          'start-date=' + FormatDateTime('yyyy-mm-dd',aDate) + '&' +
          'end-date=' + FormatDateTime('yyyy-mm-dd',aDate); // + '&' +  'alt=json';
    try
      obj.AsString:= Client.Get(URL + '&key='+APIKey);
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error getting Analytics data: ' + e.Message;
        exit;
      end;
    end;
    if Terminated then exit;
    InData:= ExtractData(obj);
    try
      for EntryIdx := 0 to InData.A['data'].Count -1 do begin
        if Terminated then exit;
        Entry:= InData.A['data'].Items[EntryIdx].AsObject;
        try
          AnalyticsDb.GetObject('TGadataforCost',GaData,DbConn,
                                  'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' +
                                  ' and CampaignID = "' + Entry.S['ga:adwordsCampaignId'] + '"' +
                                  ' and AdwordID = "' + StrToQueryStr(Entry.S['ga:adwordsAdGroupId'])+'"') ;

          if GaData.O['fields'].I['UId'] = 0 then begin
            GaData.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'];
            GaData.O['fields'].DT['DateTime']:= aDate;
            GaData.O['fields'].S['CampaignID']:= Entry.S['ga:adwordsCampaignId'];
            GaData.O['fields'].S['Campaign']:= Entry.S['ga:Campaign'];
            GaData.O['fields'].S['Adword']:=  Entry.S['ga:adGroup'];
            GaData.O['fields'].S['AdwordID']:= Entry.S['ga:adwordsAdGroupId'];
          end;
          if (GaData.O['fields'].F['Cost'] <> Entry.ItemByName['ga:adCost'].Value.asFloat) or
              (GaData.O['fields'].F['CostPerTransaction']<> Entry.ItemByName['ga:costPerTransaction'].Value.asFloat) or
              (GaData.O['fields'].F['costPerconversion'] <> Entry.ItemByName['ga:costPerConversion'].Value.asFloat) then begin
            GaData.O['fields'].F['Cost']              := Entry.ItemByName['ga:adCost'].Value.asFloat;
            GaData.O['fields'].F['CostPerTransaction']:= Entry.ItemByName['ga:costPerTransaction'].Value.asFloat;
            GaData.O['fields'].F['costPerconversion'] := Entry.ItemByName['ga:costPerConversion'].Value.asFloat;
            GaData.O['fields'].DT['DtcostUpdated'] :=Now;
          end;
          GaData.O['fields'].DT['DtCostchecked'] :=Now;
          AnalyticsDb.Save(GaData,DbConn);
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error saving Analytics data: ' + e.Message;
            exit;
          end;
        end;
      end;
    finally
      InData.Free;
    end;
  finally
    obj.Free;
    GaData.Free;
  end;
end;


function TGoogleAnalytics.Getdatecheked(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  GaData: TJsonObject;
begin
  result:= true;
  GaData:= JO('{"type":"TGaChecks"}');
  try
    AnalyticsDb.GetObject('TGaChecks',GaData,DbConn, 'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' );
    if GaData.O['fields'].I['UId'] = 0 then begin
      GaData.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'] ;
    end;
    if GaData.O['fields'].DT['Date']<> aDate then
      GaData.O['fields'].I['CheckCount']        := 1
    else
      GaData.O['fields'].I['CheckCount']        := GaData.O['fields'].I['CheckCount']+1;
      GaData.O['fields'].DT['Date']:= aDate;
    AnalyticsDb.Save(GaData,DbConn);
  except
    on e: exception do begin
      result:= false;
      msg:= 'Error saving Analytics data: ' + e.Message;
      exit;
    end;
  end;
end;

function TGoogleAnalytics.GetDataForCharts(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  URL: string;
  obj,GaData: TJsonObject;
  EntryIdx: integer;
  Entry: TJsonObject;
  InData: TJsonObject;
begin
  result:= true;
  obj:= JO;

  GaData:= JO('{"type":"TGaDataForCharts"}');
  try
    URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
      'ids=' + 'ga:' + Profile.O['fields'].S['ProfileId'] + '&' +
      'metrics=ga:visits,ga:newVisits,ga:pageViews,ga:timeOnSite' + '&' +
      'dimensions=ga:date,ga:language,ga:country,ga:keyword,ga:dayOfWeek,ga:browser,ga:campaign' + '&' +
      'start-date=' + FormatDateTime('yyyy-mm-dd',aDate) + '&' +
      'end-date=' + FormatDateTime('yyyy-mm-dd',aDate);
    try
      obj.AsString:= Client.Get(URL + '&key='+APIKey);
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error getting Analytics data: ' + e.Message;
        exit;
      end;
    end;
    if Terminated then exit;
    InData:= ExtractData(obj);
    try
      for EntryIdx := 0 to InData.A['data'].Count -1 do begin
        if Terminated then exit;
        Entry:= InData.A['data'].Items[EntryIdx].AsObject;
        try
          AnalyticsDb.GetObject('TGaDataForCharts',GaData,DbConn,
            'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' +
            ' and DateTime = "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',aDate )+ '"' +
            ' and language = "' + Entry.S['ga:language'] + '"' +
            ' and Location = "' + Entry.S['ga:country'] + '"' +
            ' and Keyword = "' + StrToQueryStr(Entry.S['ga:keyword']) + '"' +
            ' and dayOfWeek = "' + Entry.S['ga:dayOfWeek'] + '"' +
            ' and Browser = "' + Entry.S['ga:browser'] + '"' +
            ' and Campaign = "' + Entry.S['ga:campaign'] + '"');

          if GaData.O['fields'].I['UId'] = 0 then begin
            GaData.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'];
            GaData.O['fields'].DT['DateTime']:= aDate;
            GaData.O['fields'].S['language']:= Entry.S['ga:language'];
            GaData.O['fields'].S['Location']:= Entry.S['ga:country'];
            GaData.O['fields'].S['Keyword']:=  Entry.S['ga:keyword'];
            GaData.O['fields'].S['dayOfWeek']:= Entry.S['ga:dayOfWeek'];
            GaData.O['fields'].S['Browser']:= Entry.S['ga:browser'];
            GaData.O['fields'].S['Campaign']:= Entry.S['ga:campaign'];
          end;

          GaData.O['fields'].I['Visits']            := Entry.ItemByName['ga:visits'].Value.AsInteger;
          GaData.O['fields'].I['NewVisits']         := Entry.ItemByName['ga:newVisits'].Value.AsInteger;
          GaData.O['fields'].I['PageViews']         := Entry.ItemByName['ga:pageViews'].Value.AsInteger;
          GaData.O['fields'].I['TimeOnSite']        := Trunc(Entry.ItemByName['ga:timeOnSite'].Value.AsFloat);
          AnalyticsDb.Save(GaData,DbConn);
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error saving Analytics data: ' + e.Message;
            exit;
          end;
        end;
      end;
    finally
      InData.Free;
    end;
  finally
    obj.Free;
    GaData.Free;
  end;
end;

function TGoogleAnalytics.GetDataForSummary(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  URL: string;
  obj,GaData: TJsonObject;
  EntryIdx: integer;
  Entry: TJsonObject;
  InData: TJsonObject;
begin
  result:= true;
  obj:= JO;
  GaData:= JO('{"type":"TGaDataForSummary"}');
  try
    URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
      'ids=' + 'ga:' + Profile.O['fields'].S['ProfileId'] + '&' +
      'metrics=ga:visits,ga:newVisits,ga:pageViews,ga:timeOnSite,ga:bounces,ga:visitBounceRate,ga:avgTimeOnSite,ga:pageviewsPerVisit' + '&' +
      'dimensions=ga:date' + '&' +
      'start-date=' + FormatDateTime('yyyy-mm-dd',aDate) + '&' +
      'end-date=' + FormatDateTime('yyyy-mm-dd',aDate); // + '&' +  'alt=json';
    try
      obj.AsString:= Client.Get(URL + '&key='+APIKey);
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error getting Analytics data: ' + e.Message;
        exit;
      end;
    end;
   if Terminated then exit;
    InData:= ExtractData(obj);
    try
      for EntryIdx := 0 to InData.A['data'].Count -1 do begin
        if Terminated then exit;
        Entry:= InData.A['data'].Items[EntryIdx].AsObject;
        try
          AnalyticsDb.GetObject('TGaDataForSummary',GaData,DbConn,
            'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' +
            ' and DateTime = "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',aDate )+ '"' );

          if GaData.O['fields'].I['UId'] = 0 then begin
            GaData.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'];
            GaData.O['fields'].DT['DateTime']:= aDate;
          end;
          GaData.O['fields'].I['Visits']            := Entry.ItemByName['ga:visits'].Value.AsInteger;
          GaData.O['fields'].I['NewVisits']         := Entry.ItemByName['ga:newVisits'].Value.AsInteger;
          GaData.O['fields'].I['PageViews']         := Entry.ItemByName['ga:pageViews'].Value.AsInteger;
          GaData.O['fields'].I['TimeOnSite']        := Trunc(Entry.ItemByName['ga:timeOnSite'].Value.AsFloat);
          GaData.O['fields'].I['bounces']           := Entry.ItemByName['ga:bounces'].Value.asInteger;
          GaData.O['fields'].F['visitBounceRate']   := Entry.ItemByName['ga:visitBounceRate'].Value.AsFloat;
          GaData.O['fields'].F['avgTimeOnSite']     := Entry.ItemByName['ga:avgTimeOnSite'].Value.AsFloat;
          GaData.O['fields'].F['pageviewsPerVisit'] := Entry.ItemByName['ga:pageviewsPerVisit'].Value.AsFloat;
          AnalyticsDb.Save(GaData,DbConn);
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error saving Analytics data: ' + e.Message;
            exit;
          end;
        end;
      end;
    finally
      InData.Free;
    end;
  finally
    obj.Free;
    GaData.Free;
  end;
end;


function TGoogleAnalytics.GetImpressions(aDate: TDateTime; Profile: TJsonObject;
  var msg: string): boolean;
var
  URL: string;
  obj,GaImpressions: TJsonObject;
  EntryIdx: integer;
  Entry: TJsonObject;
  InData: TJsonObject;
begin
  result:= true;
  obj:= JO;
  GaImpressions:= JO('{"type":"TGaImpressions"}');
  try
    URL:= 'https://www.googleapis.com/analytics/v3/data/ga?' +
      'ids=' + 'ga:' + Profile.O['fields'].S['ProfileId'] + '&' +
      'metrics=ga:impressions' + '&' +
      'dimensions=ga:date,ga:keyword' + '&' +
      'start-date=' + FormatDateTime('yyyy-mm-dd',aDate) + '&' +
      'end-date=' + FormatDateTime('yyyy-mm-dd',aDate);

    try
      obj.AsString:= Client.Get(URL + '&key='+APIKey);
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error getting Analytics Impressions data: ' + e.Message;
        exit;
      end;
    end;

    if Terminated then exit;

    InData:= ExtractData(obj);
    try
      for EntryIdx := 0 to InData.A['data'].Count -1 do begin
        if Terminated then exit;
        Entry:= InData.A['data'].Items[EntryIdx].AsObject;
       { impressions }
        try

          AnalyticsDb.GetObject('TGaImpressions',GaImpressions,DbConn,
            'where ProfileId = "' + Profile.O['fields'].S['ProfileId'] + '"' +
            ' and Date = "' + FormatDateTime('yyyy-mm-dd',aDate) + '"' +
            ' and Keyword = "' + StrToQueryStr(Entry.S['ga:keyword']) + '"');

//          FormatAndSaveJson(Entry,'c:\temp\Google\Impressions_' + FormatDateTime('yyyy-mm-dd',aDate) +
//            '_' +  Profile.O['fields'].S['ProfileId'] + '_' +  Entry.S['ga:keyword'] + '.txt');

          if GaImpressions.O['fields'].I['UId'] = 0 then begin
            GaImpressions.O['fields'].DT['Date'] := aDate;
            GaImpressions.O['fields'].S['ProfileId']:= Profile.O['fields'].S['ProfileId'];
            GaImpressions.O['fields'].S['Keyword']:= Entry.S['ga:keyword'];
          end;
          { get Entry data }
          GaImpressions.O['fields'].I['Impressions']:= Entry.ItemByName['ga:impressions'].Value.AsInteger;
          AnalyticsDb.Save(GaImpressions,DbConn);
        except
          on e: exception do begin
            result:= false;
            msg:= 'Error saving Analytics Impressions data: ' + e.Message;
            exit;
          end;
        end;
      end;
    finally
      InData.Free;
    end;

  finally
    obj.Free;
    GaImpressions.Free;
  end;
end;

function TGoogleAnalytics.GetLoggingLevel: TLoggingLevel;
begin
  result:= TLoggingLevel(GetCompanyPref('GoogleAnalyticsLoggingLevel',DbConn));
end;

procedure TGoogleAnalytics.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
end;

function TGoogleAnalytics.ProfileById(Account: TJsonObject; ProfileId: string): TJsonObject;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to Account.O['fields'].A['Profiles'].Count -1 do begin
    if SameText(Account.O['fields'].A['Profiles'].Items[x].AsObject.O['fields'].S['ProfileId'],ProfileId) then begin
      result:= Account.O['fields'].A['Profiles'].Items[x].AsObject;
      break;
    end;
  end;
end;

procedure TGoogleAnalytics.RollbackDbTrans;
begin
  case FDbTransType of
    transNone: ;
    transSavepoint: DbConn.RollbackToSavepoint(ClassName + '_' + IntToStr(Integer(self)));
    transNormal: DbConn.Rollback;
  end;
end;

procedure TGoogleAnalytics.SetConnection(const Value: TERPConnection);
begin
  FConnection := Value;
end;

procedure TGoogleAnalytics.SetDbDatabaseName(const Value: string);
begin
  FDbDatabaseName := Value;
  fAccounts.Free;
  fAccounts:= nil;
end;

procedure TGoogleAnalytics.SetDbServerName(const Value: string);
begin
  FDbServerName := Value;
  fAccounts.Free;
  fAccounts:= nil;
end;

function TGoogleAnalytics.Terminated: boolean;
var
  IsTerminated: boolean;
begin
  IsTerminated := false;
  if Assigned(fOnGetTerminated) then
    fOnGetTerminated(IsTerminated);
  result := IsTerminated;
end;

end.
