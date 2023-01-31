unit SynchronizerThread;

interface

uses
  Classes, SyncConfigObj, DBUtils, JSONObject;

type

  TDataSyncThread = class(TThread)
  private
    Schema: TJSONObject;
    Config: TSyncDatabaseConfig;
    ServerName: string;
  protected
    procedure Execute; override;
  public
//    constructor Create(CreateSuspended: Boolean); override;
    constructor Create(aServerName, ConfigStr, SchemaStr: string); reintroduce;
    destructor Destroy; override;
  end;

implementation

//procedure

{ TDataSyncThread }

constructor TDataSyncThread.Create(aServerName, ConfigStr, SchemaStr: string);
begin
  inherited Create(false);
  ServerName:= aServerName;
  Schema:= TJSONObject.Create;
  Schema.AsString:= SchemaStr;
  Config:= TSyncDatabaseConfig.Create(nil);

end;

destructor TDataSyncThread.Destroy;
begin
  Schema.Free;
  Config.Free;
  inherited;
end;

procedure TDataSyncThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
    except
    end;
  end;
end;

end.
