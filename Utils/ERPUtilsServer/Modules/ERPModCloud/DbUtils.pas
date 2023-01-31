unit DbUtils;

interface

uses
  MyAccess, ConTnrs, SyncObjs;

type

  TConnectionPool = class(TObject)
  private
    fUsableList: TObjectList;
    fBusyList: TObjectList;
    fLock: TCriticalSection;
    fMaxConnections: integer;
    fActive: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Borrow(const aServerName, aDatabaseName: string; TimeoutSecs: integer = 0): TMyConnection;
    procedure Release(conn: TMyConnection);
    property MaxConnections: integer read fMaxConnections write fMaxConnections;
    property Active: boolean read fActive write fActive;
  end;

//  TConnectionRec = class(TObject)
//  public
//    property Connection: TMyConnection read fConnection;
//    property InUse: boolean read fInUse write fInUse;
//    property LastTime: TDateTime read fLastTime write fLastTime;
//    constructor Create(const aServerName, aDatabaseName);
//    destructor Destroy; override;
//  end;

implementation

uses
  SysUtils, DateUtils, MySQLUtils;

{ TConnectionPool }

constructor TConnectionPool.Create;
begin
  fUsableList := TObjectList.Create;;
  fBusyList := TObjectList.Create;;
  fLock := TCriticalSection.Create;
  fMaxConnections := 0;
  fActive := true;
end;

destructor TConnectionPool.Destroy;
var
  dt: TDateTime;
  cnt: integer;
begin
  Active := false;
  dt := now;
  while (now < (dt + (60 * OneSecond))) do begin
    fLock.Acquire;
    try
      cnt := fBusyList.Count;
    finally
      fLock.Release;
    end;
    if cnt > 0 then Sleep(50)
    else break;
  end;
  fUsableList.Free;
  fBusyList.Free;
  fLock.Free;
  inherited;
end;

function TConnectionPool.Borrow(const aServerName, aDatabaseName: string;
  TimeoutSecs: integer): TMyConnection;
var
  dt: TDateTime;
begin
  result := nil;
  dt := now;
  while (TimeoutSecs = 0) or (now < (dt + (TimeOutSecs * OneSecond))) do begin
    fLock.Acquire;
    try
      if fUsableList.Count > 0 then
        result := TMyConnection(fUsableList.Extract(fUsableList[0]))
      else if (fMaxConnections = 0) or ((fUsableList.Count + fBusyList.Count) < fMaxConnections) then begin
        result := TMyConnection.Create(nil);
        SetConnectionProps(result,aDatabaseName,aServerName);
        fBusyList.Add(result);
      end;
    finally
      fLock.Release;
    end;
    if Assigned(result) then begin
      result.Server := aServerName;
      result.Database := aDatabaseName;
      try
        result.Connect;
      except
      end;
      break;
    end
    else
      Sleep(20);
  end;
end;

procedure TConnectionPool.Release(conn: TMyConnection);
var
  obj: TObject;
begin
  fLock.Acquire;
  try
    if conn.Connected then conn.Disconnect;
    obj := fBusyList.Extract(conn);
    fUsableList.Add(obj);
  finally
    fLock.Release;
  end;
end;

end.
