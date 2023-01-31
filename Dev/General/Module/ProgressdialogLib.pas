unit ProgressdialogLib;

interface

Uses
  Classes, ProgressDialog;

procedure DoShowProgressbar(Inst: TComponent;ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = '';IsPercenage:boolean =true;aTimerUpdate :Boolean = False; aAllowCancel:Boolean = False);
procedure DoStepProgressbar(Inst: TComponent;const ProgressBarMessage:String = '');
procedure DoHideProgressbar(Inst: TComponent);


implementation

procedure DoShowProgressbar(Inst: TComponent;ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = '';IsPercenage:boolean =true;aTimerUpdate :Boolean = False; aAllowCancel:Boolean = False);
begin
  Try
      if not(Assigned(Inst)) or (not (Inst is TProgressDialog)) then exit;
      if ProgressBarCaption <> '' then     TProgressDialog(Inst).Caption := ProgressBarCaption;
      if ProgressBarMessage <> '' then     TProgressDialog(Inst).Message:= ProgressBarMessage;
      TProgressDialog(Inst).MaxValue := ProgressCount;
      TProgressDialog(Inst).minValue:= 0;
      TProgressDialog(Inst).Step := 1;
      TProgressDialog(Inst).ShowPercent := IsPercenage;
      TProgressDialog(Inst).TimerUpdate := aTimerUpdate;
      TProgressDialog(Inst).AllowCancel :=aAllowCancel;
      TProgressDialog(Inst).Execute;
  Except
  End;
end;
procedure DoStepProgressbar(Inst: TComponent;const ProgressBarMessage:String = '');
begin
  Try
    if not(Assigned(Inst)) or (not (Inst is TProgressDialog)) then exit;
    TProgressDialog(Inst).StepIt;
    if ProgressBarMessage <> '' then
      TProgressDialog(Inst).Message :=ProgressBarMessage
  Except
  End;
end;
procedure DoHideProgressbar(Inst: TComponent);
begin
  Try
    if not(Assigned(Inst)) or (not (Inst is TProgressDialog)) then exit;
    TProgressDialog(Inst).OnCancel := nil;
    TProgressDialog(Inst).CloseDialog;
  Except
  End;
end;

end.
