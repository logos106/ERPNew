unit PrintSpoolThreadObj;

interface

uses
  Classes;

type
  TPrintSpoolThread = class(TThread)
  private
    { Private declarations }
    index: integer;
    iCount: integer;
    procedure OpenPort;
    procedure ClosePort;
    procedure PrintLine;
    procedure SetCount;
    procedure ClearInProgressFlag;
  protected
    procedure Execute; override;
  end;

implementation

uses
  Main, FastFuncs;

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TPrintSpoolThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TPrintSpoolThread }

procedure TPrintSpoolThread.ClearInProgressFlag;
begin
  MainForm.fbSpoolPrintInProgress := false;
end;

procedure TPrintSpoolThread.ClosePort;
begin
  MainForm.foRcptPrn.ClosePort;
end;

procedure TPrintSpoolThread.Execute;
var
  i: integer;
begin
  FreeOnTerminate := true;
  synchronize(OpenPort);
  synchronize(SetCount);
  for i := 0 to iCount - 1 do begin
    index := i;
    if Terminated then Break;
    synchronize(PrintLine);
  end;
  synchronize(ClosePort);
  synchronize(ClearInProgressFlag);
end;

procedure TPrintSpoolThread.OpenPort;
begin
  MainForm.foRcptPrn.OpenPort;
end;

procedure TPrintSpoolThread.PrintLine;
var
  sText: string;
  Len: integer;
begin
  sText := MainForm.flstReceipt.Strings[index];
  Len := Length(sText);
  if (Len > 1) and (sText[1] = '~') then begin
    if (Len > 2) and (sText[2] = 'F') then begin
      MainForm.foRcptPrn.Format(sText[3]);
    end else if (Len > 1) and (sText[2] = 'C') then begin
      MainForm.foRcptPrn.FeedPaperForCut;
    end else begin
      MainForm.foRcptPrn.Print(sText);
    end;
  end else begin
    MainForm.foRcptPrn.Print(sText);
  end;
end;

procedure TPrintSpoolThread.SetCount;
begin
  iCount := MainForm.flstReceipt.Count
end;

end.
