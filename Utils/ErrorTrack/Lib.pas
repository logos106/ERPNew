unit Lib;

interface

uses
  db;

  function DownloadEmail(Const ExtractFolderPath:String):Integer;
  procedure LoadFileToDB(Const FilePath:String; Const Dataset: TDataset);

implementation

uses
  idpop3, idmessage, ProgressDialog, sysutils, forms, classes, IdAttachment,
  ERPServerDetailsObj, Dialogs;
(*
const
  POP3Host = 'mail.erpaustralia.com.au';
  POP3Port = 110;
  POP3Username = 'erplog@erpaustralia.com.au';
  POP3Password = 'catforpetesdinner';
*)

//{$DEFINE DevMode}

var
  POP3Host: string;
  POP3Port: integer;
  POP3Username: string;
  POP3Password: string;

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
      POP3.Port :=  POP3Port ;
      POP3.Username := POP3Username;
      POP3.Password := POP3Password;
      Try
        POP3.Connect();
        MsgCount := POP3.CheckMessages;
      except
        on e: Exception do begin
          showmessage('Error: ' + e.Message);
        end;
      end;

      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := MsgCount;
      ProgressDialog.Step := 1;
      ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.Message := 'Downloading 1 of '+ IntToStr(ProgressDialog.MaxValue);
      If Application.MainForm.Visible then ProgressDialog.Execute;

      for i := 1 to MsgCount do begin
        MailMessage.Clear;
        inc(Mailcount);
        POP3.Retrieve(i, MailMessage) ;
        for p := 0 to MailMessage.MessageParts.Count - 1 do Begin
          if MailMessage.MessageParts.Items[p] is TidAttachment then begin
            FileName := TidAttachment(MailMessage.MessageParts.Items[p]).FileName;
            if FileName = '' then
              FileName:= 'Unknown.txt';
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
        ProgressDialog.Message := 'Downloading '+ IntToStr(ProgressDialog.Value)+
          ' of '+ IntToStr(ProgressDialog.MaxValue);
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


procedure LoadFileToDB(Const FilePath:String; Const Dataset: TDataset);
var
  FileStr: TStringList;
  s: string;
//  TmpStrLine,TmpStrLine1: String;
//  ExceptionID,TmpLineNo: Integer;
//  ExceptionEmailRec: TExceptionEmailRec;

  function GetString(section: string): string;
  var x: integer;
  begin
    result:= '';
    for x:= 0 to FileStr.Count -1 do begin
      if Pos(section,FileStr[x]) > 0 then begin
        result:= Trim(Copy(FileStr[x],Length(section) + 1, Length(FileStr[x])));
        break;
      end;
    end;
  end;


begin
  If Not FileExists(FilePath) then Exit;
  FileStr := TStringList.Create;
  Try
    FileStr.LoadFromFile(FilePath);
    If FileStr.Count=0 then Exit;
    Try
      Dataset.Append;
      {Version}
      s:= GetString('ERP Version:');
      if s <> '' then
        Dataset.FieldByName('VersionNo').AsString:= s;

      {DateTime}
      s:= GetString('---------------------------');
      if s <> '' then begin
        s:= StringReplace(s,'-','',[rfReplaceAll]);
        Dataset.FieldByName('DateTime').AsDateTime:= now;
//        try
//          Dataset.FieldByName('DateTime').AsString:= s;
//        except
//          Dataset.FieldByName('DateTime').AsDateTime:= now;
//        end;
      end;

      {Company}
      s:= GetString('Company:');
      if s <> '' then
        Dataset.FieldByName('Company').AsString:= s;

      {User}
      s:= GetString('User:');
      if s <> '' then
        Dataset.FieldByName('User').AsString:= s;

      {PC Name}
      s:= GetString('PC Name:');
      if s <> '' then
        Dataset.FieldByName('PCName').AsString:= s;

      {Focused Form}
      s:= GetString('Focused Form:');
      if s <> '' then
        Dataset.FieldByName('FocusedForm').AsString:= s;

      {Focused Control}
      s:= GetString('Focused Control:');
      if s <> '' then
        Dataset.FieldByName('FocusedControl').AsString:= s;

      {ExceptionName}
      s:= GetString('Exception');
      if s <> '' then
        Dataset.FieldByName('ExceptionName').AsString:= s;

      {Module}
      s:= GetString('Module:');
      if s <> '' then
        Dataset.FieldByName('ModuleName').AsString:= s;

      {Error Type}
      s:= GetString('Error Type:');
      if s <> '' then
        Dataset.FieldByName('ErrorType').AsString:= s;

      {ErrorText}
      Dataset.FieldByName('ErrorText').AsString := FileStr.Text;

      Dataset.Post;

    Except
      Dataset.Cancel;
      raise;
    end;
  finally
    FileStr.Free;
  end;
end;

initialization
  POP3Host := ERPServerDetails.O['erplog_email'].S['Host'];
  POP3Port := ERPServerDetails.O['erplog_email'].I['POPPort'];
  POP3Username := ERPServerDetails.O['erplog_email'].S['Username'];
  POP3Password := ERPServerDetails.O['erplog_email'].S['Password'];

//  POP3Port := 110;

 end.
