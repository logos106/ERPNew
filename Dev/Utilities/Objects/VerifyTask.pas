unit VerifyTask;


interface

uses Classes, ProgressDialog, MyAccess, DB;

type
  TTaskParams  = record
    Name: String;
    Description: String;
    CorrectSQL: String;
    CorrectSQLParms: String;
    CorrectFields: String;
    ExistingSQL: String;
    ExistingParmsField: String;
    ExistingFields: String;
    ExecuteSQL: String;
    ExecuteParmsField: String;
    ProgressDialog: Boolean;
    LogMessage: Boolean;
    LockDownDate: Boolean;
    UseEmptyCorrectValues: Boolean;
  end;

type
  TVerifyTask = class(TComponent)
  private
    ProgressDialog: TProgressDialog;
    ErrorLog: TextFile;
    iAllCount, iCount: integer;
    procedure AddLogMessage(const MessageText: string);
    procedure ResetProgressBar(const Dialog: TProgressDialog; Const Max: Integer);
    procedure SetUpQuery(const Qry: TMyQuery; Const SQL: String);
    function DelimCounter(const TestString: string): Integer;    
  public
    constructor Create(Const AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    procedure ExecuteTask(Const TaskParams: TTaskParams);
    property AllCount: Integer read iAllCount write iAllCount;
  end;

implementation

uses FastFuncs,SysUtils, CommonDbLib,  DNMLib ,Dialogs, AppEnvironment, CommonLib;

Const
  LOGSPATH = 'C:\Platinum1\Logs\';

{ TVerifyTask }

constructor TVerifyTask.Create(const AOwner: TComponent);
begin
  inherited Create(AOwner);
  ProgressDialog := TProgressDialog.Create(Self);
  // Error Log
  AssignFile(ErrorLog, LOGSPATH + 'Platinum1Verify_'+FormatDateTime('dd-mm-yyyy hh.nn.ss', Now) + '.log');
  {$I-}
  Rewrite(ErrorLog);
  {$I+}
  if IOResult = 0 then;
  // Reset Counters
  iAllCount := 0;
  iCount := 0;
end;

destructor TVerifyTask.Destroy;
begin
  FreeAndNil(ProgressDialog);
  Try
    {$I-}
    Flush(ErrorLog);
    CloseFile(ErrorLog);
    {$I+}
     if IOResult = 0 then;    
  except
    on   EInOutError do;
  end;
  inherited;
end;

procedure TVerifyTask.AddLogMessage(const MessageText: string);
begin
 {$I-}
  Writeln(ErrorLog, MessageText);
  Flush(ErrorLog);
 {$I+}
 if IOResult = 0 then;
end;

function TVerifyTask.DelimCounter(const TestString: string): Integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to 200 do begin
    S := FastFuncs.PosEx('{}', TempStr);
    if S > 0 then begin
      Delete(TempStr, S,FastFuncs.StrLength('{}'));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

procedure TVerifyTask.ResetProgressBar(const Dialog: TProgressDialog; Const Max: Integer);
begin
  Dialog.CloseDialog;
  Dialog.Step := 1; 
  Dialog.MinValue := 0;
  Dialog.MaxValue := Max;
  Dialog.Value := Dialog.MinValue;
  Dialog.Execute;
end;

procedure TVerifyTask.SetUpQuery(const Qry: TMyQuery; const SQL: String);
begin
  Qry.Close;
  Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  Qry.Options.StrictUpdate := False;
  Qry.SQL.Clear;
  Qry.SQL.Text := SQL;
end;

procedure TVerifyTask.ExecuteTask(const TaskParams: TTaskParams);
Var
  I,ParamsCount:Integer;
  qryExisting: TMyQuery;
  qryCorrect: array of TMyQuery;
begin
  ParamsCount := DelimCounter(TaskParams.CorrectFields);
  SetLength(qryCorrect, ParamsCount);
  qryExisting := TMyQuery.Create(Self);
  qryExisting.Options.FlatBuffers := True;
  for I := 0 to ParamsCount-1 do Begin
    qryCorrect[I] := TMyQuery.Create(Self);
    qryCorrect[I].Options.FlatBuffers := True;
  end;
  
  Try
    iCount := iCount + 1;
    If TaskParams.ProgressDialog then ResetProgressBar(ProgressDialog,1);
    ProgressDialog.Message := 'Preparing Data -';
    SetUpQuery(qryExisting,TaskParams.ExistingSQL);
    ProgressDialog.Message := 'Preparing Data -  -';

    // Lock Down Date
    If TaskParams.LockDownDate then
      qryExisting.Params.ParamByName('LockDownDate').AsString := FormatDateTime('yyyy-mm-dd',AppEnv.CompanyPrefs.VerifyLockdownDate);
    qryExisting.Open;
    ProgressDialog.Message := 'Preparing Data -  -  -';
    ProgressDialog.Message := 'Verifying Data ('+FastFuncs.IntToStr(iCount)+' of '+FastFuncs.IntToStr(iAllCount)+')';
    If TaskParams.ProgressDialog then ResetProgressBar(ProgressDialog,qryExisting.RecordCount + 1);
    ProgressDialog.StepIt;

    // Compare Queries
    qryExisting.First;
    while not qryExisting.Eof do begin
      for I := 0 to ParamsCount-1 do Begin
        SetUpQuery(qryCorrect[I],DNMLib.ExtractStrPortion(TaskParams.CorrectSQL,'{}',I+1));
        qryCorrect[I].Params.ParamByName(DNMLib.ExtractStrPortion(TaskParams.CorrectSQLParms,'{}',I+1)).AsString :=
          qryExisting.FieldByName(DNMLib.ExtractStrPortion(TaskParams.ExistingParmsField,'{}',I+1)).AsString;
        qryCorrect[I].Open;


        if (Not FastFuncs.SameText(qryExisting.FieldByName(DNMLib.ExtractStrPortion(TaskParams.ExistingFields,'{}',I+1)).AsString,
           qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).AsString) AND
           (Not Empty(qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).AsString)) OR

            (TaskParams.UseEmptyCorrectValues AND

            (Empty(qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).AsString) OR
            qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).Isnull) ))

         then begin

          // Error Log
          If TaskParams.LogMessage then AddLogMessage('Error !');

          qryExisting.Edit;
          case qryExisting.FieldByName(DNMLib.ExtractStrPortion(TaskParams.ExistingFields,'{}',I+1)).DataType of
            ftLargeInt, ftInteger: Begin
                                    qryExisting.FieldByName(DNMLib.ExtractStrPortion(TaskParams.ExistingFields,'{}',I+1)).AsInteger :=
                                      qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).AsInteger;
                                   end;
          else
            qryExisting.FieldByName(DNMLib.ExtractStrPortion(TaskParams.ExistingFields,'{}',I+1)).AsVariant :=
              qryCorrect[I].FieldByName(DNMLib.ExtractStrPortion(TaskParams.CorrectFields,'{}',I+1)).AsVariant;
          end;

          try
            qryExisting.Post;
          except
          end;
        end;
      end;
      ProgressDialog.StepIt;
      qryExisting.Next;
    end;
  finally
    FreeAndNil(qryExisting);
    for I := 0 to ParamsCount-1 do
      FreeAndNil(qryCorrect[I]);
  end;
end;

initialization
  RegisterClassOnce(TVerifyTask);
end.
 
 
 
