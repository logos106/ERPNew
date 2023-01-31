unit ThreadDataset;

interface

uses
  sysutils, DaScript,db, MyScript, MyAccess, classes;

type
TTreadScriptExecute = class(TThread)
  private
    fScript: TMyScript;
    fSavedOnErrorEvent: TOnErrorEvent;
    fSavedBeforeExecute: TBeforeStatementExecuteEvent;
    fSavedAfterExecute: TAfterStatementExecuteEvent;
    fBeforeExecuteSQL: string;
    fAfterExecuteSQL: string;
    fSQL: string;
    fOmit: boolean;
    fException: Exception;
    fAction: TErrorAction;
    procedure DoSavedOnError;
    procedure DoSavedBeforeExecute;
    procedure DoSavedAfterExecute;
    procedure DoOnErrorEvent(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure DoBeforeExecute(Sender: TObject; var SQL: string; var Omit: boolean);
    procedure DoAfterExecute(Sender: TObject; SQL: string);
    function getSQL: TStrings;
  protected
    procedure Execute; override;
  public
    constructor Create(aScript: TMyScript);
    Property SQL:TStrings read getSQL ;
  end;

  function OpenDatasetThread(aDataset: TDataset; ShowProgress: boolean = true): boolean;
//  procedure ExecScriptThread(sqltext:String; onProgressEvent:TNotifyEvent = nil; ShowProgress: boolean = true; sleepInterval:Integer = 25);
//  procedure ExecCommandThread(aCommand: TMyCommand; ShowProgress: boolean = true);

implementation

uses
  ERPdbComponents, forms, ProgressDialog, DbAccess(*,
  CommonDbLib*);

type
  TTreadDatasetOpen = class(TThread)
  private
    fDataset: TDataset;
    fSavedBeforeOpen: TDatasetNotifyEvent;
    fSavedAfterOpen: TDatasetNotifyEvent;
    procedure DoSavedBeforeOpen;
    procedure DoSavedAfterOpen;
    procedure DoBeforeOpen(Dataset: TDataset);
    procedure DoAfterOpen(Dataset: TDataset);
  protected
    procedure Execute; override;
  public
    constructor Create(aDataset: TDataset);
  end;

  TTreadCommandExec = class(TThread)
  private
    fCommand: TMyCommand;
    fSavedAfterExecute: TAfterExecuteEvent;
    fResult: Boolean;
    procedure DoSavedAfterExecute;
    procedure DoAfterExecute(Sender: TObject; Result: boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(aCommand: TMyCommand);
  end;



function OpenDatasetThread(aDataset: TDataset; ShowProgress: boolean = true): boolean;
var
  thread: TTreadDatasetOpen;
  ProgDlg: TProgressDialog;
  stepCount: integer;
const
  SleepInterval = 25;
begin
  Result := true;
  ProgDlg := nil;
  thread := TTreadDatasetOpen.Create(aDataset);
  if ShowProgress then begin
    ProgDlg := TProgressDialog.Create(nil);
    ProgDlg.Execute;
  end;
  try
    stepCount := 0;
    while not thread.Terminated do begin
      sleep(SleepInterval);
      if Assigned(ProgDlg) then begin
        stepCount := stepCount + SleepInterval;
        if stepCount >= 500 then begin
          stepCount := 0;
          if ProgDlg.Value = ProgDlg.MaxValue then
            ProgDlg.Value := 0;
          ProgDlg.StepIt;
        end;
      end;
      Application.ProcessMessages;
    end;
  finally
    thread.Free;
    ProgDlg.Free;
  end;
end;

(*procedure ExecScriptThread(sqltext:String; onProgressEvent:TNotifyEvent = nil; ShowProgress: boolean = true; sleepInterval:Integer = 25);
var
  thread: TTreadScriptExecute;
  ProgDlg: TProgressDialog;
  stepCount: integer;
  aScript: TERPScript;
begin
  ProgDlg:= nil;

  aScript:= TERPScript.Create(nil);
  try
      aScript.Connection := GetNewMyDacConnection(nil);

      aScript.SQL.TExt := sqltext;

      thread:= TTreadScriptExecute.Create(aScript);
      try
        if ShowProgress then begin
          ProgDlg:= TProgressDialog.Create(nil);
          ProgDlg.Execute;
        end;
        try
          stepCount:= 0;
          while not thread.Terminated do begin
            sleep(SleepInterval);

            if Assigned(ProgDlg) then begin
              stepCount:= stepCount + SleepInterval;
              if stepCount >= 500 then begin
                stepCount:= 0;
                if ProgDlg.Value = ProgDlg.MaxValue then
                  ProgDlg.Value:= 0;
                ProgDlg.StepIt;
              end;
            end;

            if Assigned(onProgressEvent) then onProgressEvent(nil);

            Application.ProcessMessages;
          end;
        finally
          thread.Free;
        end;
      finally

        if ShowProgress then begin
          ProgDlg.Free;
        end;
      end;
  finally
        aScript.Connection.Free;
        Freeandnil(aScript);
  end;
end;*)

procedure ExecCommandThread(aCommand: TMyCommand; ShowProgress: boolean = true);
var
  thread: TTreadCommandExec;
  ProgDlg: TProgressDialog;
  stepCount: integer;
const
  SleepInterval = 25;
begin
  ProgDlg:= nil;
  thread:= TTreadCommandExec.Create(aCommand);
  if ShowProgress then begin
    ProgDlg:= TProgressDialog.Create(nil);
    ProgDlg.ShowPercent:= false;
    ProgDlg.Execute;
  end;
  try
    stepCount:= 0;
    while not thread.Terminated do begin
      sleep(SleepInterval);
      if Assigned(ProgDlg) then begin
        stepCount:= stepCount + SleepInterval;
        if stepCount >= 500 then begin
          stepCount:= 0;
          if ProgDlg.Value = ProgDlg.MaxValue then
            ProgDlg.Value:= 0;
          ProgDlg.StepIt;
        end;
      end;
      Application.ProcessMessages;
    end;
  finally
    thread.Free;
    ProgDlg.Free;
  end;
end;

{ TTreadQueryOpen }

constructor TTreadDatasetOpen.Create(aDataset: TDataset);
begin
  fDataset:= aDataset;
  FreeOnTerminate:= false;
  inherited Create(false);
end;

procedure TTreadDatasetOpen.DoAfterOpen(Dataset: TDataset);
begin
  { execure dataset events in main thread }
  self.Synchronize(DoSavedAfterOpen);
end;

procedure TTreadDatasetOpen.DoBeforeOpen(Dataset: TDataset);
begin
  { execure dataset events in main thread }
  self.Synchronize(DoSavedBeforeOpen);
end;

procedure TTreadDatasetOpen.DoSavedAfterOpen;
begin
  { we are now in main thread }
  if Assigned(fSavedAfterOpen) then
    fSavedAfterOpen(fDataset);
end;

procedure TTreadDatasetOpen.DoSavedBeforeOpen;
begin
  { we are now in main thread }
  if Assigned(fSavedBeforeOpen) then
    fSavedBeforeOpen(fDataset);
end;

procedure TTreadDatasetOpen.Execute;
begin
  inherited;
  while not Terminated do begin
    fSavedBeforeOpen:= fDataset.BeforeOpen;
    fSavedAfterOpen:= fDataset.AfterOpen;
    try
      fDataset.BeforeOpen:= DoBeforeOpen;
      fDataset.AfterOpen:= DoAfterOpen;
      fDataset.Open;
    finally
      fDataset.BeforeOpen:= fSavedBeforeOpen;
      fDataset.AfterOpen:= fSavedAfterOpen;
    end;
    Terminate;
  end;
end;

{ TTreadScriptExecute }

constructor TTreadScriptExecute.Create(aScript: TMyScript);
begin
  fScript:= aScript;
  FreeOnTerminate:= false;
  inherited Create(false);
end;

procedure TTreadScriptExecute.DoAfterExecute(Sender: TObject; SQL: string);
begin
  fAfterExecuteSQL:= SQL;
  { execure dataset events in main thread }
  self.Synchronize(DoSavedAfterExecute);
end;

procedure TTreadScriptExecute.DoBeforeExecute(Sender: TObject; var SQL: string;
  var Omit: boolean);
begin
  fBeforeExecuteSQL:= SQL;
  fOmit:= Omit;
  { execure dataset events in main thread }
  self.Synchronize(DoSavedBeforeExecute);
  SQL:= fBeforeExecuteSQL;
  Omit:= fOmit;
end;

procedure TTreadScriptExecute.DoOnErrorEvent(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  fException:= E;
  fSQL:= SQL;
  fAction:= Action;
  { execure dataset events in main thread }
  self.Synchronize(DoSavedOnError);
  Action:= fAction;
end;

procedure TTreadScriptExecute.DoSavedAfterExecute;
begin
  if Assigned(fSavedAfterExecute) then
    fSavedAfterExecute(fScript,fAfterExecuteSQL);
end;

procedure TTreadScriptExecute.DoSavedBeforeExecute;
begin
  if Assigned(fSavedBeforeExecute) then
    fSavedBeforeExecute(fScript,fBeforeExecuteSQL,fOmit);

end;

procedure TTreadScriptExecute.DoSavedOnError;
begin
  if Assigned(fSavedOnErrorEvent) then
    fSavedOnErrorEvent(fScript,fException,fSQL,fAction);
end;

procedure TTreadScriptExecute.Execute;
begin
  inherited;
  (*while not Terminated do begin
    fSavedBeforeExecute:= fScript.BeforeExecute;
    fSavedAfterExecute:= fScript.AfterExecute;
    fSavedOnErrorEvent:= fScript.OnError;
    try
      fScript.BeforeExecute:= DoBeforeExecute;
      fScript.AfterExecute:= DoAfterExecute;
      fScript.OnError:= DoOnErrorEvent;
      fScript.Execute;
    finally
      fScript.BeforeExecute:= fSavedBeforeExecute;
      fScript.AfterExecute:= fSavedAfterExecute;
      fScript.OnError:= fSavedOnErrorEvent;
    end;
    Terminate;
  end;*)
  fScript.Execute;
  Terminate;
end;

function TTreadScriptExecute.getSQL: TStrings;
begin
  result := fScript.SQL;
end;

{ TTreadCommandExec }

constructor TTreadCommandExec.Create(aCommand: TMyCommand);
begin
  fCommand:= aCommand;
  FreeOnTerminate:= false;
  inherited Create(false);
end;

procedure TTreadCommandExec.DoAfterExecute(Sender: TObject; Result: boolean);
begin
  fResult:= Result;
  { execure dataset events in main thread }
  self.Synchronize(DoSavedAfterExecute);
end;

procedure TTreadCommandExec.DoSavedAfterExecute;
begin
  if Assigned(fSavedAfterExecute) then
    fSavedAfterExecute(fCommand,fResult);
end;

procedure TTreadCommandExec.Execute;
begin
  inherited;
  while not Terminated do begin
    fSavedAfterExecute:= fCommand.AfterExecute;
    try
      fCommand.AfterExecute:= DoAfterExecute;
      fCommand.Execute;
    finally
      fCommand.AfterExecute:= fSavedAfterExecute;
    end;
    Terminate;
  end;
end;

end.
