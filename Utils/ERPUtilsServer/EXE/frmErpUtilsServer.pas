unit frmErpUtilsServer;

interface

uses
  LogThreadLib, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UtilsServerObj, StdCtrls, ExtCtrls;

type
  TfmErpUtilsServer = class(TForm)
    memLog: TMemo;
    UpdateTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Server: TUtilsServer;
    fLastUpdateTime: TDateTime;
    fLogger: TLogger;
    procedure DoOnLog(msg: string);
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  public

  end;

var
  fmErpUtilsServer: TfmErpUtilsServer;

implementation

uses
  MOduleFunctions, JsonToObject, ModuleUtils, LogMessageTypes,
  JsonObject, UpdaterCallUtils;

const
  OneMin = 1/24/60;

{$R *.dfm}


procedure TfmErpUtilsServer.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  DoOnLog(Value);
end;

procedure TfmErpUtilsServer.DoOnLog(msg: string);
begin
  while memLog.Lines.Count > 300 do
    memLog.Lines.Delete(0);

  memLog.Lines.Add(msg);
end;

procedure TfmErpUtilsServer.FormCreate(Sender: TObject);
begin
  inherited;
  fLogger:= TLogger.Create(nil);
  fLogger.LogAllTypes; //  LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  fLogger.Events.AddMultiEvent(DoLogEvent);
  Server:= TUtilsServer.Create(fLogger);
//  Server.OnLog:= DoOnLog;
//  Server.Logger:= TLogger.Inst;
  fLastUpdateTime:= now;
  UpdateTimer.Enabled:= true;
end;

procedure TfmErpUtilsServer.FormDestroy(Sender: TObject);
begin
//  Server.Logger:= nil;
  Server.Free;
//  fLogger.Events.RemoveMultiEvent(DoLogEvent);
//  fLogger.Active:= false;
  try
    fLogger.Free;
  except

  end;
  inherited;
end;

procedure TfmErpUtilsServer.FormShow(Sender: TObject);
begin
  Server.Active:= true;
end;

end.
