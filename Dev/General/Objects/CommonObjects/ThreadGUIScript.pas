unit ThreadGUIScript;

interface

uses classes , ThreadDataset;

procedure ExecScriptThread(sqltext:String; onProgressEvent:TNotifyEvent = nil; ShowProgress: boolean = true; sleepInterval:Integer = 25);
type
  TTreadGUIScripExecute = class(TTreadScriptExecute)

  end;
implementation

uses
  forms, ERPdbComponents , ProgressDialog,db, MyScript, MyAccess , CommonDbLib, sysutils;


procedure ExecScriptThread(sqltext:String; onProgressEvent:TNotifyEvent = nil; ShowProgress: boolean = true; sleepInterval:Integer = 25);
var
  thread: TTreadGUIScripExecute;
  ProgDlg: TProgressDialog;
  stepCount: integer;
  aScript: TERPScript;
begin
  ProgDlg:= nil;

  aScript:= TERPScript.Create(nil);
  try
      aScript.Connection := GetNewMyDacConnection(nil);

      aScript.SQL.TExt := sqltext;

      thread:= TTreadGUIScripExecute.Create(aScript);
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
end;
end.
