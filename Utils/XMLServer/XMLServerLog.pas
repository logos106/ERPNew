unit XMLServerLog;

interface

uses
  LogThreadLib, LogMessageTypes;

  procedure Log(const msg: string; const LogMessageType: TLogMessageType);

implementation

procedure Log(const msg: string; const LogMessageType: TLogMessageType);
begin
  TLogger.Inst.Log(msg,LogMessageType);
end;


end.
