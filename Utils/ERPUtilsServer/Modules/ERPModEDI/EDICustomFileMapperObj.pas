unit EDICustomFileMapperObj;

interface

uses
  JsonObject, LogThreadBase, Classes, LogMessageTypes, ERPDBComponents,
  EDIMapConfigObj, Types;

type
  TERPFileMapperErrorType = (meNone, meFatal, meTransient);

  TEDICustomFileMapper = class(TObject)
  private
    fConfig: TEDIMapConfig;
    fOnLog: TOnLogEvent;
    fConnection: TERPConnection;
    fERPPass: string;
    fERPUser: string;
    fErrors: TStringList;
  protected
    fLastErrorType: TERPFileMapperErrorType;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    procedure Err(const msg: string; ErrorType: TERPFileMapperErrorType = meFatal);
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property Connection: TERPConnection read fConnection write fConnection;
    property Config: TEDIMapConfig read fConfig; // write fConfig;
    property ERPUser: string read fERPUser write fERPUser;
    property ERPPass: string read fERPPass write fERPPass;
    function ProcessFile(stream: TStream; aMapName: string): boolean; overload; virtual;
    function ProcessFile(aFileName: string; aMapName: string): boolean; overload; virtual;
    property LastErrorType: TERPFileMapperErrorType read fLastErrorType;
    property Errors: TStringList read fErrors;
  end;



implementation

{ TEDICustomFileMapper }

constructor TEDICustomFileMapper.Create;
begin
  fLastErrorType := meNone;
  fConfig := TEDIMapConfig.Create;
  fErrors := TStringList.Create;
end;

destructor TEDICustomFileMapper.Destroy;
begin
  fConfig.Free;
  fErrors.Free;
end;

procedure TEDICustomFileMapper.Err(const msg: string;
  ErrorType: TERPFileMapperErrorType);
begin
  fLastErrorType := ErrorType;
  if Errors.Count > 0 then Errors.Add('');
  Errors.Add(msg);
  Log(msg,ltError);
end;

procedure TEDICustomFileMapper.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLog) then fOnLog(msg,LogMessageType);
end;

function TEDICustomFileMapper.ProcessFile(aFileName, aMapName: string): boolean;
begin
  result := false;
end;

function TEDICustomFileMapper.ProcessFile(stream: TStream;
  aMapName: string): boolean;
begin
  result := false;
end;

end.
