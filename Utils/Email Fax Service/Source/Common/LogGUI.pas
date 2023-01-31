unit LogGUI;

interface

uses
  Windows, Forms, ExtCtrls, DNMSpeedButton, AdvMemo, Classes, Controls, AdvPanel;
type
  TLogView = class(TForm)
    AdvPanel1: TAdvPanel;
    LogMemo: TAdvMemo;
    CheckLogTimer: TTimer;
    btnSave: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckLogTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogView: TLogView;

implementation

uses
  EmailFaxServerUnit, EmailFaxServerLib;

{$R *.dfm}

procedure TLogView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TLogView.FormShow(Sender: TObject);
begin
  LogMemo.BeginUpdate;
  LogMemo.Lines.Text:= LogsLib.LogListText;
  LogMemo.EndUpdate;
  LogMemo.RefreshMemo;
  CheckLogTimer.Enabled := True;
end;

procedure TLogView.FormDestroy(Sender: TObject);
begin
  CheckLogTimer.Enabled := False;
  Application.ProcessMessages;  
  Inherited;
  LogView := Nil;
end;

procedure TLogView.btnSaveClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TLogView.CheckLogTimerTimer(Sender: TObject);
begin
  If LogsLib.LogListUpdated then begin
    LogMemo.BeginUpdate;
    LogMemo.Lines.Text:= LogsLib.LogListText;
    LogMemo.EndUpdate;
    LogMemo.RefreshMemo;
    btnSave.Invalidate;
    PerformPaints;
  end;
end;

end.



