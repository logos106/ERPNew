unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RosettaNetConectorObj, LogThreadLib, StdCtrls;

type
  TfmMain = class(TForm)
    memLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Connector: TRosettaNetConnector;
    fLogger: TLogger;
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.DoLogEvent(Sender: TObject; const Event, Value: string);
begin
  memLog.Lines.Add(Value);
  while memLog.Lines.Count > 2000 do
    memLog.Lines.Delete(0);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fLogger:= TLogger.Create(nil);
  fLogger.LogAllTypes;
  fLogger.Events.AddMultiEvent(DoLogEvent);

//  Connector:= TRosettaNetConnector.Create(fLogger);

end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Connector.Free;
  fLogger.Free;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  Connector:= TRosettaNetConnector.Create(fLogger);

end;

end.
