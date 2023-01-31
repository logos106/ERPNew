unit ExceptionEmailsLib;

{$I ErrTrack.inc}

interface

Uses Forms,Classes,Controls,DB,IdPOP3,IdMessage,MyAccess,Dialogs;

  Procedure LoadFileToDB(Const FilePath:String; Const Dataset: TDataset);
  Procedure ImportExceptionEmails;

implementation

Uses SysUtils,BaseDataMod,FuncLib,ProgressDialog, FastFuncs;

Type
  TExceptionEmailRec = record
    Version: String[15];
    Company: String[150];
    User: String[100];
    ExceptionType: String[100];
    ExceptionMessage: String[255];
    Module: String[100];
    Source: String[100];
    SourceLine: Integer;
    CallStackUnit: String[100];
    CallStackLine: Integer;
    FocusedForm: String[100];
    FocusedControl: String[100];
  end;

Const
  POP3Host = 'mail.erpaustralia.com.au';
  POP3Port = 110;
  POP3Username = 'erplog@erpaustralia.com.au';
  POP3Password = 'catforpetesdinner';

function IsDuplicateEntry(Const ExceptionEmailRec: TExceptionEmailRec; Var ExceptionID:Integer):Boolean;
var
  TempQry: TMyQuery;
Begin
  Result := False;
  ExceptionID := 0;
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('Select exceptionid From exceptionbugs ');
    TempQry.SQL.Add('WHERE version='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.Version))+' ');
    TempQry.SQL.Add('AND exceptiontype='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.ExceptionType))+' ');
    If not FastFuncs.SameText(ExceptionEmailRec.ExceptionType,'EAccessViolation') then
      TempQry.SQL.Add('AND exceptionmessage='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.ExceptionMessage))+' ');
    TempQry.SQL.Add('AND focusedform='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.FocusedForm))+' ');
    TempQry.SQL.Add('AND focusedcontrol='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.FocusedControl))+' ');
    TempQry.SQL.Add('AND module='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.Module))+' ');
    TempQry.SQL.Add('AND source='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.Source))+' ');
    TempQry.SQL.Add('AND sourceLine='+ FastFuncs.IntToStr(ExceptionEmailRec.SourceLine)+' ');
    TempQry.SQL.Add('AND callstackunit='+ QuotedStr(FastFuncs.Trim(ExceptionEmailRec.CallStackUnit))+' ');
    TempQry.SQL.Add('AND callstackline='+ FastFuncs.IntToStr(ExceptionEmailRec.CallStackLine)+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
      Result := True;
      ExceptionID := TempQry.FieldbyName('ExceptionID').AsInteger;
    end;
  finally
    TempQry.Free;
  end;
end;

Procedure UpdateOccurrences(Const ExceptionID:Integer; Const FileStrList:TStringList);
var
  TempQry: TMyCommand;
Begin
  TempQry := TMyCommand.Create(nil);
  try
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('UPDATE exceptionbugs SET occurrences=occurrences+1, ');
    TempQry.SQL.Add('logfile=Concat_WS(Concat(Char(13),"~##############################~",Char(13),"~##############################~",Char(13)),');
    TempQry.SQL.Add('logfile,'+QuotedStr(FileStrList.Text)+') ');
    TempQry.SQL.Add('WHERE exceptionid='+ FastFuncs.IntToStr(ExceptionID)+';');
    TempQry.Execute;
  finally
    TempQry.Free;
  end;
end;

function LineNumber(const StrLst: TStringList; const Delim: string): Integer;
Var
  Index: Integer;
begin
  Result := -1;
  for Index := 0 to StrLst.Count - 1 do
    If FastFuncs.PosEx(FastFuncs.LowerCase(Delim), FastFuncs.LowerCase(StrLst[Index]))>0 then begin
      Result := Index;
      Break;
    end;
  if result = -1 then
//    showmessage('LineNumber Delim: ' + Delim);
end;

function GetString(const StrLst: TStringList; const Delim: string): string;
Var
  Index: Integer;
begin
  result:= '';
  for Index := 0 to StrLst.Count - 1 do
    If FastFuncs.PosEx(FastFuncs.LowerCase(Delim), FastFuncs.LowerCase(StrLst[Index]))>0 then begin
      Result := StrLst[Index];
      Break;
    end;
  if result = '' then
//    showmessage('GetString Delim: ' + Delim);
end;

function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: Integer): string;
var
  S: Integer;
  E: Integer;
  L9: Integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do
  begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then
      Delete(Src, S, FastFuncs.StrLength(Delim))
    else
      Break;
  end;
  result := '';
  if S > 0 then
  begin
    E := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

Procedure LoadFileToDB(Const FilePath:String; Const Dataset: TDataset);
Var
  FileStr: TStringList;
  TmpStrLine,TmpStrLine1: String;
  ExceptionID,TmpLineNo: Integer;
  ExceptionEmailRec: TExceptionEmailRec;
Begin
  If Not FileExists(FilePath) then Exit;
  FileStr := TStringList.Create;
  Try
    FileStr.LoadFromFile(FilePath);
    If FileStr.Count=0 then Exit;
    Try
      Dataset.Append;
      {Version}
      TmpStrLine := '';
      TmpStrLine := GetString(FileStr,'Platinum1 Version:');
      if TmpStrLine <> '' then
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Platinum1 Version:',2))
      else begin
        TmpStrLine := GetString(FileStr,'ERP Version:');
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'ERP Version:',2));
      end;
      Dataset.FieldByName('Version').AsString  := TmpStrLine;

      {Company}
      TmpStrLine := GetString(FileStr,'Company:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Company:',2));
      Dataset.FieldByName('Company').AsString  := TmpStrLine;
      {User}
      TmpStrLine := GetString(FileStr,'User:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'User:',2));
      Dataset.FieldByName('User').AsString  := TmpStrLine;
      {Focused Form}
      TmpStrLine := GetString(FileStr,'Focused Form:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Focused Form:',2));
      Dataset.FieldByName('FocusedForm').AsString  := TmpStrLine;
      {Focused Control}
      TmpStrLine := GetString(FileStr,'Focused Control:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Focused Control:',2));
      Dataset.FieldByName('FocusedControl').AsString  := TmpStrLine;
      {Date}
      TmpStrLine := GetString(FileStr,'---------------------------');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'---------------------------',2));
      Dataset.FieldByName('Date').AsString := TmpStrLine;
      {ExceptionType}
      TmpLineNo := LineNumber(FileStr,'Exception ');
      if TmpLineNo > -1 then begin
        TmpStrLine := FileStr[TmpLineNo];
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Exception ',2));
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,#39,2));
        Dataset.FieldByName('ExceptionType').AsString  := TmpStrLine;
        {ExceptionMessage}
        TmpStrLine := FileStr[TmpLineNo+1];
        Dataset.FieldByName('ExceptionMessage').AsString  := TmpStrLine;
      end;
      {Module}
      TmpStrLine := GetString(FileStr,'Module:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Module:',2));
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,', Source:',1));
      Dataset.FieldByName('Module').AsString  := TmpStrLine;
      {Source}
      TmpStrLine := GetString(FileStr,'Source:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Source:',2));
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,', Line ',1));
      Dataset.FieldByName('Source').AsString  := TmpStrLine;
      {Line}
      TmpStrLine := GetString(FileStr,', Line ');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,', Line ',2));
      Dataset.FieldByName('SourceLine').AsInteger  := Trunc(StrValue(TmpStrLine));
      {Procedure}
      TmpStrLine := GetString(FileStr,'Procedure:');
      TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,'Procedure:',2));
      Dataset.FieldByName('SourceProcedure').AsString  := TmpStrLine;
      {CallStack}
      TmpLineNo := LineNumber(FileStr,'.pas, line ');
      if TmpLineNo > -1 then begin
        TmpStrLine1 := FileStr[TmpLineNo];
        TmpStrLine1 := FastFuncs.Trim(ExtractStrPortion(TmpStrLine1,']',2));
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine1,'(',1));
        Dataset.FieldByName('CallStackProcedure').AsString  := TmpStrLine;
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine1,'(',2));
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,', line ',1));
        Dataset.FieldByName('CallStackUnit').AsString  := TmpStrLine;
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine1,'(',2));
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,', line ',2));
        TmpStrLine := FastFuncs.Trim(ExtractStrPortion(TmpStrLine,')',1));
        Dataset.FieldByName('CallStackLine').AsInteger  := Trunc(StrValue(TmpStrLine));
      end;

      {File}
      Dataset.FieldByName('LogFile').AsString := FileStr.Text;

      {Occurrences}
      Dataset.FieldByName('Occurrences').AsInteger  := 1;

      {Load Record}
      ExceptionEmailRec.Version := Dataset.FieldByName('Version').AsString;
      ExceptionEmailRec.Company := Dataset.FieldByName('Company').AsString;
      ExceptionEmailRec.User := Dataset.FieldByName('User').AsString;
      ExceptionEmailRec.ExceptionType := Dataset.FieldByName('ExceptionType').AsString;
      ExceptionEmailRec.ExceptionMessage := Dataset.FieldByName('ExceptionMessage').AsString;
      ExceptionEmailRec.Module := Dataset.FieldByName('Module').AsString;
      ExceptionEmailRec.Source := Dataset.FieldByName('Source').AsString;
      ExceptionEmailRec.SourceLine := Dataset.FieldByName('SourceLine').AsInteger;
      ExceptionEmailRec.CallStackUnit := Dataset.FieldByName('CallStackUnit').AsString;
      ExceptionEmailRec.CallStackLine := Dataset.FieldByName('CallStackLine').AsInteger;
      ExceptionEmailRec.FocusedForm := Dataset.FieldByName('FocusedForm').AsString;
      ExceptionEmailRec.FocusedControl := Dataset.FieldByName('FocusedControl').AsString;

      If IsDuplicateEntry(ExceptionEmailRec,ExceptionID) then Begin
        UpdateOccurrences(ExceptionID,FileStr);
        Dataset.Cancel;
      end else Begin
        Dataset.Post;
      end;

    Except
      Dataset.Cancel;
      raise;
    end;
  finally
    FileStr.Free;
  end;
end;

function DownloadEmail(Const ExtractFolderPath:String):Integer;
var
  POP3: TIdPOP3;
  MailMessage: TIdMessage;
  ProgressDialog: TProgressDialog;
  TargetFolder: String;
  FileName, tmpFileName: String;
  MsgCount, i,
  p, Mailcount, suffix: Integer;

begin
    POP3 := TIdPOP3.Create(nil);
    MailMessage := TIdMessage.Create(nil);
    ProgressDialog := TProgressDialog.Create(Nil);
    MsgCount:= 0;
    try
      Mailcount := 0;
      targetFolder := ExtractFolderPath+'\';
      POP3.Host := POP3Host;
      POP3.Port := POP3Port ;
      POP3.Username := POP3Username;
      POP3.Password := POP3Password;
      Try
        POP3.Connect();
        MsgCount := POP3.CheckMessages;
      except
      end;

      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := MsgCount;
      ProgressDialog.Step := 1;
      ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.Message := 'Downloading 1 of '+FastFuncs.IntToStr(ProgressDialog.MaxValue);
      If Application.MainForm.Visible then ProgressDialog.Execute;

      for i := 1 to MsgCount do begin
        MailMessage.Clear;
        inc(Mailcount);
        POP3.Retrieve(i, MailMessage) ;
        for p := 0 to MailMessage.MessageParts.Count - 1 do Begin
          if MailMessage.MessageParts.Items[p] is TidAttachment then begin
            FileName := TidAttachment(MailMessage.MessageParts.Items[p]).FileName;
            tmpFileName := targetFolder + ExtractFileName(FileName);
            suffix := 0;
            while FileExists(tmpFileName) do begin
              inc(suffix);
              tmpFileName := targetFolder + ExtractFileName(FileName) + format('_%0.2d',[suffix]);
            end;
            TidAttachment(MailMessage.MessageParts.Items[p]).SaveToFile(tmpFileName);
          end;
        end;
        {$IFNDEF DevMode}
        POP3.Delete(i);
        {$ENDIF}
        If Application.MainForm.Visible then ProgressDialog.Stepit;
        ProgressDialog.Message := 'Downloading '+FastFuncs.IntToStr(ProgressDialog.Value)+' of '+FastFuncs.IntToStr(ProgressDialog.MaxValue);
        Application.ProcessMessages;
      end;
      Result := Mailcount;
    finally
      POP3.Disconnect;
      POP3.Free;
      MailMessage.Free;
      ProgressDialog.Free;
    end;
end;


Procedure ImportExceptionEmails;
var
  sr: TSearchRec;
  fileName: string;
  TempDownloadPath:String;
  TempQry: TMyQuery;
Begin
  If assigned(CheckEmailsTimer) then
    CheckEmailsTimer.Enabled := False;
  TempQry := TMyQuery.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    TempQry.Options.FlatBuffers := True;
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('Select * From exceptionbugs Where exceptionID=0;');
    TempQry.Open;
    {$WARN SYMBOL_PLATFORM OFF}
    TempDownloadPath := ExtractFilePath(Application.ExeName) + 'Temp';
    SysUtils.ForceDirectories(TempDownloadPath);
    DownloadEmail(TempDownloadPath);
    Application.MainForm.Update;
    Application.ProcessMessages;
    if SysUtils.FindFirst(TempDownloadPath+ '\*.txt', 0, sr) = 0 then begin
      repeat
        if not (((sr.Attr and faVolumeId) <> 0) or
                ((sr.Attr and faDirectory) <> 0) or
                ((sr.Attr and faReadOnly) <> 0)) then begin
          fileName:= sr.Name;
          ExceptionEmailsLib.LoadFileToDB(TempDownloadPath+ '\'+fileName,TempQry);
          SysUtils.DeleteFile(TempDownloadPath + '\' + fileName);
        end;
      until SysUtils.FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
    end;
  finally
    TempQry.Free;
    Screen.Cursor := crDefault;
    BaseDataModule.StartCheckEmailTimer;
  end;
end;


end.
