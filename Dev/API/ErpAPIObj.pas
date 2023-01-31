unit ErpAPIObj;

interface

uses
  IdHttpServer, JsonObject, IdContext, IdCustomHttpServer, ThreadProperty;


type
  TErpApi = class(TObject)
  private
    fHttpPort: integer;
    fHttpServer: TIdHttpServer;
    RequestJsonStr: TThreadProperty;
    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnConnect(AContext: TIdContext);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure ProcessRequest;
  public
    constructor Create;
    destructor Destroy; override;
    property HttpPort: integer read fHttpPort write fHttpPort;
    property Active: boolean read GetActive write SetActive;
    property Server:TIdHttpServer read fHttpServer;
  end;

  function ERPApi: TErpApi;

implementation

uses
  classes, Types, SysUtils, ModuleFileNameUtils, URILib,
  CommonFormLib, ERPDbComponents, CommonDbLib;

var
  fErpAPI: TErpApi;

function ERPApi: TErpApi;
begin
  if not Assigned(fErpAPI) then
    fErpAPI := TErpAPI.Create;
  result := fErpAPI;
end;

{ TErpApi }

constructor TErpApi.Create;
begin
  fHttpServer := TIdHttpServer.Create(nil);
  fHTTPServer.OnCommandGet := DoOnCommandGet;
  fHTTPServer.OnCommandOther := DoOnCommandOther;
  fHTTPServer.OnConnect := DoOnConnect;
  fHttpPort := 8088;
  RequestJsonStr := TThreadProperty.Create;
end;

destructor TErpApi.Destroy;
begin
  fHttpServer.Free;
  RequestJsonStr.Free;
  inherited;
end;

procedure TErpApi.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Stream: TMemoryStream;
  URIParts: TStringDynArray;
  dt: TDateTime;
  x: integer;
  LogStr: string;
  page: string;
  ShowLog: boolean;
  FormClassName: string;
  PersistentClass: TPersistentClass;
  KeyID: integer;
  PageBody: string;
  json: TJsonObject;

  procedure Log(const msg: string);
  begin
    LogStr := LogStr + msg + '<br>';
  end;

begin
  { GET, POST, or HEAD }
  dt := now;
  PageBody := '';
  FormClassName := '';
  KeyID := 0;
  LogStr := '<hr><p>Log</p>';
  Log('Document: ' + ARequestInfo.Document);
  Log('Params: ' + ARequestInfo.Params.Text);
  Log('Raw Headers: ' + ARequestInfo.RawHeaders.Text);

  ShowLog := false;
  AResponseInfo.ResponseNo:= 200;
//  AResponseInfo.ContentType:= 'text/plain';
  AResponseInfo.ContentType:= 'text/html';

  AResponseInfo.CharSet := 'UTF-8';

  if SameText(ARequestInfo.Document,'/favicon.ico') then begin
    AResponseInfo.ContentType:= 'image/x-icon';
    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(GetCurrentModulePath + 'erp.ico');
    Stream.Position := 0;
    AResponseInfo.ContentStream := Stream;
    exit;
  end;

  try
    try
      if Pos('trueerp',Lowercase(ARequestInfo.Document)) = 0 then begin
        PageBody := PageBody + '<p>The Link was not recognised by TrueERP</p>';
        PageBody := PageBody + '<p>Document: trueerp not found.</p>';
        exit;
      end;

      URIParts:= SplitURI(Lowercase(Copy(ARequestInfo.URI,2,Length(ARequestInfo.URI))));

      ShowLog := (ARequestInfo.Params.Count > 0) and (ARequestInfo.Params.Values['log'] = 'true');

      if (ARequestInfo.Params.Count > 0) then begin
        if ARequestInfo.Params.IndexOfName('OpenForm') > -1 then begin


          FormClassName := ARequestInfo.Params.Values['OpenForm'];
          KeyID := StrToIntDef(ARequestInfo.Params.Values['KeyID'],0);


          if FormClassName <> '' then begin
            PersistentClass := FindClass(FormClassName);
            if Assigned(PersistentClass) then begin
              //AResponseInfo.ResponseNo:= 204; // no content

              json := JO;
              try
                json.S['Command'] := 'OpenForm';
                json.S['FormClassName'] := FormClassName;
                json.I['KeyID'] := KeyID;

                RequestJsonStr.AsString := json.AsString;

                TThread.Synchronize(nil,ProcessRequest);

                json.AsString := RequestJsonStr.AsString;

                PageBody := PageBody + '<p>The following has ben opened in TrueERP</p>';
                if json.S['FormDescription'] <> '' then
                  PageBody := PageBody + '<p>' + json.S['FormDescription'] + ' for ID ' + IntToStr(KeyID) + '</p>'
                else
                  PageBody := PageBody + '<p>' + FormClassName + ' for ID ' + IntToStr(KeyID) + '</p>';
                exit;
              finally
                json.Free;
              end;
            end;
          end;
        end
        else begin
          { unknown command }
          PageBody := PageBody + '<p>The Link was not recognised by TrueERP</p>';
          PageBody := PageBody + '<p>Document: '+ARequestInfo.Document+'<br>';
          PageBody := PageBody + 'Params: '+ARequestInfo.Params.Text+'</p>';
        end;
      end;
    except
      on ex: exception do begin
        AResponseInfo.ResponseNo:= 200;
        PageBody := PageBody + '<p>The following error was returned from TrueERP:</p>';
        PageBody := PageBody + '<p>'+ex.Message+'</p>';
      end;
    end;

  finally
    if (PageBody <> '') or ShowLog then begin
      page := '<!DOCTYPE html><html><body>';

      page := page + PageBody;
      if ShowLog then begin
        AResponseInfo.ResponseNo:= 200;
        for x := Low(URIParts) to High(URIParts) do
          Log('  URI Part ' + IntToStr(x) + ': ' + URIParts[x]);
        for x := 0 to ARequestInfo.Params.Count -1 do
          Log('  Param ' + ARequestInfo.Params[x]);
        Log('Processing Time: ' + FormatDateTime('nn:ss.zzz',now-dt));
        if (LogStr <> '') then
          page := page + '<br>'+LogStr;
      end;

      page := page + '</body></html>';
      AResponseInfo.ContentText := page;
    end;

  end;

end;

procedure TErpApi.DoOnCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin

end;

procedure TErpApi.DoOnConnect(AContext: TIdContext);
begin

end;

function TErpApi.GetActive: boolean;
begin
  result := fHttpServer.Active;
end;

procedure TErpApi.ProcessRequest;
var
  json: TJsonObject;
begin
  json := JO(RequestJsonStr.AsString);
  try
    if SameText(json.S['Command'],'OpenForm') then begin

      OpenERPForm(json.S['FormClassName'],json.I['KeyID']);

      with TERPQuery.Create(nil) do begin
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Text := 'select Description from tblforms where FormName = ' + QuotedStr(json.S['FormClassName']);
        Open;
        json.S['FormDescription'] := FieldByName('Description').AsString;
        Free;
      end;

      RequestJsonStr.AsString := Json.AsString;
    end;
  finally
    json.Free;
  end;
end;

procedure TErpApi.SetActive(const Value: boolean);
begin
  if Value then begin
    fHttpServer.Active := false;
    fHttpServer.Bindings.Clear;
    fHTTPServer.Bindings.Add.Port := fHttpPort;
    fHttpServer.Active := true;
  end
  else begin
    fHttpServer.Active := false;
  end;
end;

initialization
  fErpAPI := nil;
//  fErpAPI := TErpApi.Create;
//  try
//    fErpAPI.Active := true;
//  except
//
//  end;

finalization
  fErpAPI.Free;

end.
