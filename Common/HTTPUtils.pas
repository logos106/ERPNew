unit HTTPUtils;

interface

uses
  Classes, IdHTTP;

type

  THTTPUtils = class(TObject)
  public
    class function Get(const aURL: string; var GetResult, aErrStr: string; http: TIdHttp = nil): boolean;
  end;

  THTTPThread = class(TThread)
  private
    URL: String;
    fResultStr: string;
    fErrStr: string;
    fAssignedHttp: TIdHttp;
    fDone: boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(const aURL: string; aHTTP: TIdHTTP = nil); overload;
    property ResultStr: string read fResultStr;
    property ErrStr: string read fErrStr;
    property Done: boolean read fDone;
  end;

implementation

uses
  SysUtils, Forms;

{ THTTPThread }

constructor THTTPThread.Create(const aURL: string; aHTTP: TIdHTTP = nil);
begin
  fDone := false;
  URL := aURL;
  fResultStr := '';
  fErrStr := '';
  fAssignedHttp := aHTTP;
  FreeOnTerminate := false;
  inherited Create;
end;

procedure THTTPThread.Execute;
var
  http: TIdHttp;
begin
  inherited;

  if Assigned(fAssignedHttp) then http := fAssignedHttp
  else http := TIdHttp.Create(nil);
  try
    try
      fResultStr := http.Get(URL);
    except
      on e: exception do begin
        fErrStr := e.Message;
      end;
    end;
  finally
    if not Assigned(fAssignedHttp) then http.Free;
  end;
  fDone := true;
end;

{ THTTPUtils }

class function THTTPUtils.Get(const aURL: string; var GetResult, aErrStr: string;
  http: TIdHttp): boolean;
var
  HTTPThread: THTTPThread;
begin
  result := true;
  HTTPThread := THTTPThread.Create(aURL,http);
  try
    while not HTTPThread.Done do begin
      Application.ProcessMessages;
      Sleep(10);
    end;
    GetResult := HTTPThread.ResultStr;
    aErrStr := HTTPThread.ErrStr;
    if aErrStr <> '' then
      result := false;
  finally
    HTTPThread.Free;
  end;
end;

end.
