unit frmServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, datXMLServer, StdCtrls, ExtCtrls;

type
  TfmServer = class(TForm)
    pnlTop: TPanel;
    Button1: TButton;
    Button2: TButton;
    lblStatus: TLabel;
    memLog: TMemo;
    memEvents: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Server: TdmXMLServer;
    procedure DoEvent(Sender: TObject; const Event, Value : string);
    procedure DoQueuedEvent(Sender: TObject; const Event, Value : string);

  public
    { Public declarations }
  end;

var
  fmServer: TfmServer;

implementation

{$R *.dfm}

uses
  LogThreadLib, LogMessageTypes, AppVarsObj;

procedure TfmServer.FormCreate(Sender: TObject);
begin
  inherited;
    AppVars:= TAppVars.Create;
    AppVars.EncryptFile:= true;
    AppVars.SaveOnChange:= true;
    AppVars.LoadFromFile();

    AppVars.SetDefault('ServerControlPort','9011');

    AppVars.SetDefault('ServerPort','9009');
  TLogger.Inst.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail];


  Server:= TdmXMLServer.Create(self);
  Server.EventQueue.AddMultiEvent(DoQueuedEvent);
//  TLogger.Inst.LogToEvent:= false;

end;

procedure TfmServer.FormDestroy(Sender: TObject);
begin
  Server.Active:= false;
  Server.EventQueue.RemoveMultiEvent(DoQueuedEvent);
  TLogger.Inst.Events.RemoveMultiEvent(DoEvent);
  inherited;
end;


procedure TfmServer.Button1Click(Sender: TObject);
begin
  Server.Active:= true;
  if Server.Active then
    lblStatus.Caption:= 'Running'
  else
    lblStatus.Caption:= 'Stopped';
end;

procedure TfmServer.Button2Click(Sender: TObject);
begin
  Server.Active:= false;
  if Server.Active then
    lblStatus.Caption:= 'Running'
  else
    lblStatus.Caption:= 'Stopped';
end;

procedure TfmServer.DoEvent(Sender: TObject; const Event, Value : string);
begin
  if event = 'Log' then begin
    if memLog.Lines.Count > 850 then begin
      while memLog.Lines.Count > 800 do
        memLog.Lines.Delete(0);
    end;
    memLog.Lines.Add(value);
  end;
end;

procedure TfmServer.FormShow(Sender: TObject);
begin
  TLogger.Inst.Events.AddMultiEvent(DoEvent);
  Button1Click(Button1);
end;

procedure TfmServer.DoQueuedEvent(Sender: TObject; const Event,
  Value: string);
begin
  memEvents.Lines.Add(Sender.ClassName + '  ' + Event + '  ' + Value);
end;

end.
