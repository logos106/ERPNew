unit InternetConnectivityUtils;

interface

  function InternetAccessOk(showProgress: boolean = true): boolean;
  function ERPHeadOfficeAccessOk(showProgress: boolean = true): boolean;

implementation

uses
  SysUtils, IdIcmpClient, IdHttp, classes, windows, ProgressDialog,
  JsonRpcBase, JsonRpcTcpClient, JsonObject, JsonRpcConst, ModuleConst,
  dialogs, Wininet, HTTPConst;


type
  TPingChecker = class
  private
    IcmpClient: TIdIcmpClient;
    IdHttp: TIdHttp;
    PingList: TStringList;
    DataReceived: boolean;
    PingDone: boolean;
    fShowProgress: boolean;
    procedure DoOnReplyEvent(ASender: TComponent; const AReplyStatus: TReplyStatus);
  public
    constructor Create;
    destructor Destroy; override;
    function AccessOk: boolean;
    property ShowProgress: boolean read fShowProgress write fShowProgress;
  end;

{ following function does not recognise when net cable unplugged }
//function IsConnected: boolean;
//const
//  // local system uses a modem to connect to the Internet.
//  INTERNET_CONNECTION_MODEM      = 1;
//  // local system uses a local area network to connect to the Internet.
//  INTERNET_CONNECTION_LAN        = 2;
//  // local system uses a proxy server to connect to the Internet.
//  INTERNET_CONNECTION_PROXY      = 4;
//  // local system's modem is busy with a non-Internet connection.
//  INTERNET_CONNECTION_MODEM_BUSY = 8;
//
//var
//  dwConnectionTypes : DWORD;
//begin
//  dwConnectionTypes := INTERNET_CONNECTION_MODEM +
//                       INTERNET_CONNECTION_LAN +
//                       INTERNET_CONNECTION_PROXY;
//  Result := InternetGetConnectedState(@dwConnectionTypes,0);
//end;


function InternetAccessOk(showProgress: boolean = true): boolean;
var
  pc: TPingChecker;
begin
  try
    pc:= TPingChecker.Create;
    try
      pc.ShowProgress:= showProgress;
      result:= pc.AccessOk;
    finally
      pc.Free;
    end;
  except
    result:= false;
  end;
end;

{ TPingChecker }

function TPingChecker.AccessOk: boolean;
var
  x: integer;
  pg: TProgressDialog;
begin
  result:= false;
//  if not IsConnected then
//    exit;
  pg:= nil;
  if fShowProgress then begin
    pg:= TProgressDialog.Create(nil);
    pg.Caption:= 'Checking Internet Access';
    pg.Message:= 'Please wait ...';
    pg.MaxValue:= PingList.Count + 1;
    pg.Value:= 1;
    pg.MinValue:= 1;
    pg.Step:= 1;
    pg.Execute;
  end;
  try
  //  try
  //    try
  //      for x:= 0 to PingList.Count -1 do begin
  //        IcmpClient.Host:= PingList[x];
  //        PingDone:= false;
  //        if Assigned(pg) then pg.StepIt;
  //        try
  //          IcmpClient.Ping();
  //          while not PingDone do
  //            Sleep(50);
  //          if DataReceived then begin
  //            result:= true;
  //            exit;
  //          end;
  //        except
  //        end;
  //      end;
  //    finally
  //      FreeAndNil(pg);
  //    end;
  //  except
  //    result:= false;
  //  end;
    if not result then begin
      for x:= 0 to PingList.Count -1 do begin
        try
          IdHttp.Head('http://' + PingList[x]);
          if IdHttp.Response.ResponseCode = 200 then begin
            result:= true;
            exit;
          end;
        except
          on e: exception do begin
//            showmessage(e.ClassName + ' ' + e.Message);

          end;
        end;
        if Assigned(pg) then
          pg.StepIt;
      end;
    end;
  finally
    FreeAndNil(pg);
  end;
end;

constructor TPingChecker.Create;
begin
  DataReceived:= false;
  IcmpClient:= TIdIcmpClient.Create(nil);
  IcmpClient.OnReply:= DoOnReplyEvent;
//  IcmpClient.ReceiveTimeout := 20;
  IdHttp:= TIdHttp.Create(nil);
  IdHttp.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  IdHttp.ReadTimeout := 2000;
  IdHttp.ConnectTimeout := 2000;
  PingList:= TStringList.Create;
  PingList.Add('www.trueerp.com');
  PingList.Add('www.google.com');
  PingList.Add('www.yahoo.com');
end;

destructor TPingChecker.Destroy;
begin
  PingList.Free;
  IcmpClient.Free;
  IdHttp.Free;
  inherited;
end;

procedure TPingChecker.DoOnReplyEvent(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
begin
  if AReplyStatus.BytesReceived > 0 then
    DataReceived:= true
  else
    DataReceived:= false;
  PingDone:= true;

//  case AReplyStatus.ReplyStatusType of
//    rsEcho:;                  // An Echo was received.
//    rsError:;                 // An error has occurred.
//    rsTimeOut:;               // Timeout occurred before a response was received.
//    rsErrorUnreachable:;      // The address for the ICMP message is not available.
//    rsErrorTTLExceeded:;      // Time-To-Live exceeded for an ICMP response.
//  end;
end;

function ERPHeadOfficeAccessOk(showProgress: boolean = true): boolean;
var
  client: TJsonRpcTcpClient;
  JsonReq, JsonRslt: TJsonObject;
  pg: TProgressDialog;
begin
  result:= false;
  try
    pg:= nil;
    try
      if ShowProgress then begin
        pg:= TProgressDialog.Create(nil);
        pg.Caption:= 'Checking ERP Head Office Access';
        pg.Message:= 'Please wait ...';
        pg.MaxValue:= 2;
        pg.Value:= 1;
        pg.MinValue:= 0;
        pg.Step:= 1;
        pg.Execute;
      end;
      client:= TJsonRpcTcpClient.Create;
      try
        client.Port:= DEFAULT_TCP_PORT;
        if ParamCount = 1 then
          client.ServerName:= ParamStr(1)
        else
        client.ServerName:= ERP_HEAD_OFFICE_SERVER_NAME_DEFAULT;
        try
          client.Connected:= true;
          JsonReq:= JO('{"sender":"ERPHeadOfficeAccessOk"}');
          JsonRslt:= client.SendRequest('getversion',JsonReq);
          if Assigned(JsonRslt) then begin
            if JsonRslt.StringExists('result') and (JsonRslt.AsString <> '') then
              result:= true;

            JsonRslt.Free;
          end;
        except
        end;

        if not result then begin
          { ERP internal network  }
          try
            client.Connected:= false;
            client.ServerName:= 'erp-svr1';
            client.Connected:= true;
            JsonReq:= JO('{"sender":"ERPHeadOfficeAccessOk"}');
            JsonRslt:= client.SendRequest('getversion',JsonReq);
            if Assigned(JsonRslt) then begin
              if JsonRslt.StringExists('result') and (JsonRslt.AsString <> '') then
                result:= true;

              JsonRslt.Free;
            end;
          except
          end;
        end;

        if not result then begin
          { ERP internal network  }
          try
            client.Connected:= false;
            client.ServerName:= 'Server1';
            client.Connected:= true;
            JsonReq:= JO('{"sender":"ERPHeadOfficeAccessOk"}');
            JsonRslt:= client.SendRequest('getversion',JsonReq);
            if Assigned(JsonRslt) then begin
              if JsonRslt.StringExists('result') and (JsonRslt.AsString <> '') then
                result:= true;

              JsonRslt.Free;
            end;
          except
          end;
        end;

      finally
        client.Free;
      end;
    finally
      pg.Free;
    end;
  except
    result:= false;
  end;
end;


end.
