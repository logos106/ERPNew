unit frmLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frmBase;

type
  TfmLog = class(TfmBase)
    memLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    fMaxLines: integer;
    { Private declarations }
  public
    procedure Log(msg: string);
    property MaxLines: integer read fMaxLines write fMaxLines;
    class function Inst: TfmLog;
    class function LogOpen: boolean;
  end;

var
  fmLog: TfmLog;

implementation

{$R *.dfm}

var
  LogInst: TfmLog;

{ TfmLog }

procedure TfmLog.FormCreate(Sender: TObject);
begin
  inherited;
  fMaxLines:= 1000;
end;

procedure TfmLog.Log(msg: string);
begin
  if memLog.Lines.Count > fMaxLines + 20 then begin
    while memLog.Lines.Count > fMaxLines do
      memLog.Lines.Delete(0);
  end;
  memLog.Lines.Add(msg);
end;

procedure TfmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  inherited;
end;

class function TfmLog.Inst: TfmLog;
begin
  if not Assigned(LogInst) then
    LogInst:= TfmLog.Create(Application);
  result:= LogInst;
end;

procedure TfmLog.FormDestroy(Sender: TObject);
begin
  inherited;
  LogInst:= nil;
end;

class function TfmLog.LogOpen: boolean;
begin
  result:= Assigned(LogInst);
end;

end.
