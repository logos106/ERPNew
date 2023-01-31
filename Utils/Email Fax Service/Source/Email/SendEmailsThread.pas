unit SendEmailsThread;

{$I EmailFaxServerSrv.inc}

interface

uses
  Classes,IdMessage,IdEMailAddress,IdSMTP, IdAntiFreezeBase, IdAntiFreeze, MyAccess,DB;

type
  TSendEmailsThread = class(TThread)
  private
    { Private declarations }
    FDatabase: String;
    DBConnection: TMyConnection;
    EmailQueList: TList;
    procedure LoadEmailQue;
    procedure DeleteEmailQue;
    procedure SendEmails;
    Function GetSMTPHost: String;
    Function GetSMTPPort: Integer;
    Function GetSMTPAuthenticate: Boolean;
    Function GetSMTPUsername: String;
    Function GetSMTPPassword: String;
    procedure DeleteSuccessful;
    procedure DeleteUnsuccessful;
    procedure CheckThreadError(ErrCode: Integer); overload;
    procedure CheckThreadError(Success: Boolean); overload;
  protected
    procedure Execute; Override;
  public
    constructor Create(Const CreateSuspended: Boolean);
    destructor Destroy; Override;
    property Database: string read FDatabase write FDatabase;
    function WaitFor: LongWord; reintroduce;
  end;

implementation
Uses SysUtils,EmailFaxServerLib,EmailFaxServerUnit, ExcMagic, Windows, Forms,
  FastFuncs;

type
  TEmailQueRec = class(TObject)
  private  
  public
    EmailID:      Integer;
    EmailBody:    TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

{ EmailQueRec }

constructor TEmailQueRec.Create;
begin
  inherited;
  EmailBody:= TStringList.Create;
end;

destructor TEmailQueRec.Destroy;
begin
  SysUtils.FreeAndNil(EmailBody);
  inherited;
end;

{ TSendEmailsThread }
constructor TSendEmailsThread.Create(const CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
end;

destructor TSendEmailsThread.Destroy;
begin
  inherited;

end;


procedure TSendEmailsThread.DeleteEmailQue;
begin
  while EmailQueList.Count > 0 do begin
    TEmailQueRec(EmailQueList[0]).Free;
    EmailQueList.Delete(0);
    EmailQueList.Pack;
    EmailQueList.Capacity := EmailQueList.Count;
  end;
end;

procedure TSendEmailsThread.DeleteSuccessful;
var
  qryTemp: TMyCommand;
begin
  qryTemp := TMyCommand.Create(nil);
  try
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Add('DELETE FROM tblEmailQueue WHERE Success = "T";');
    qryTemp.Execute;
  finally
    SysUtils.FreeAndNil(qryTemp);
  end;
end;

procedure TSendEmailsThread.DeleteUnsuccessful;
var
  qryTemp: TMyCommand;
  tmpRowsAffected: Integer;
begin
  qryTemp := TMyCommand.Create(nil);
  try
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Add('DELETE FROM tblEmailQueue WHERE Success = "F" AND queueDate < ' +
                    QuotedStr(FormatDateTime('yyyy-mm-dd' ,Now - FastFuncs.StrToInt(EmailFaxServer.INI_Options.TryForDays))));
    qryTemp.Execute;
    tmpRowsAffected := qryTemp.RowsAffected;
    If tmpRowsAffected>0 then LogsLib.AddLogBoth('Deleted ('+IntToStr(tmpRowsAffected)+') Unsuccessful Emails');
  finally
    SysUtils.FreeAndNil(qryTemp);
  end;
end;


procedure TSendEmailsThread.Execute;
begin
  inherited;
  DBConnection := CreateDBConnection(nil, FDatabase);
  if not Assigned(DBConnection) then Exit;
  EmailQueList := TList.Create;
  Try
    DeleteUnsuccessful;
    LoadEmailQue;
    If EmailQueList.Count > 0 then
      SendEmails;
    DeleteSuccessful;
    DBConnection.Disconnect;
  Finally
    DeleteEmailQue;
    SysUtils.FreeAndNil(EmailQueList);
    SysUtils.FreeAndNil(DBConnection);
  end;
end;

function TSendEmailsThread.GetSMTPAuthenticate: Boolean;
var
  qryHost: TMyQuery;
begin
  qryHost := TMyQuery.Create(nil);
  try
    qryHost.Options.FlatBuffers := True;
    qryHost.Connection := DBConnection;
    qryHost.SQL.Add('SELECT PrefId,FieldValue FROM `tbldbpreferences` WHERE `Name` = "EmailUseAuthentication";');
    qryHost.Open;
    If qryHost.FieldByName('FieldValue').AsString = 'T' then
      Result := True
    else
      Result := False;
  finally
    SysUtils.FreeAndNil(qryHost);
  end;
end;

function TSendEmailsThread.GetSMTPHost: String;
var
  qryHost: TMyQuery;
begin
  qryHost := TMyQuery.Create(nil);
  try
    qryHost.Options.FlatBuffers := True;
    qryHost.Connection := DBConnection;
    qryHost.SQL.Add('SELECT PrefId,FieldValue FROM `tbldbpreferences` WHERE `Name` = "EmailSMTPHost";');
    qryHost.Open;
    Result := qryHost.FieldByName('FieldValue').AsString;
  finally
    SysUtils.FreeAndNil(qryHost);
  end;
end;

function TSendEmailsThread.GetSMTPPassword: String;
var
  qryHost: TMyQuery;
begin
  qryHost := TMyQuery.Create(nil);
  try
    qryHost.Options.FlatBuffers := True;
    qryHost.Connection := DBConnection;
    qryHost.SQL.Add('SELECT PrefId,FieldValue FROM `tbldbpreferences` WHERE `Name` = "EmailAuthPassword";');
    qryHost.Open;
    Result := qryHost.FieldByName('FieldValue').AsString;
  finally
    SysUtils.FreeAndNil(qryHost);
  end;
end;

function TSendEmailsThread.GetSMTPPort: Integer;
var
  qryPort: TMyQuery;
begin
  qryPort := TMyQuery.Create(nil);
  try
    qryPort.Options.FlatBuffers := True;
    qryPort.Connection := DBConnection;
    qryPort.SQL.Add('SELECT PrefId,FieldValue FROM `tbldbpreferences` WHERE `Name` = "EmailSMTPPort";');
    qryPort.Open;
    Result := StrtoIntDef(qryPort.FieldByName('FieldValue').AsString,25);
  finally
    SysUtils.FreeAndNil(qryPort);
  end;
end;

function TSendEmailsThread.GetSMTPUsername: String;
var
  qryHost: TMyQuery;
begin
  qryHost := TMyQuery.Create(nil);
  try
    qryHost.Options.FlatBuffers := True;
    qryHost.Connection := DBConnection;
    qryHost.SQL.Add('SELECT PrefId,FieldValue FROM `tbldbpreferences` WHERE `Name` = "EmailAuthUserID";');
    qryHost.Open;
    Result := qryHost.FieldByName('FieldValue').AsString;
  finally
    SysUtils.FreeAndNil(qryHost);
  end;
end;

procedure TSendEmailsThread.LoadEmailQue;
var
  Rec: TEmailQueRec;
  qryQue: TMyQuery;
begin
  qryQue := TMyQuery.Create(nil);
  Try
    qryQue.Connection := DBConnection;
    qryQue.Options.FlatBuffers := True;
    qryQue.Close;
    qryQue.SQL.Clear;
    qryQue.SQL.Add('SELECT * FROM tblEmailQueue Where EmailID=0;');
    qryQue.Open;
    If (qryQue.FindField('Active')=nil) Then Exit;

    //first mark any old unsuccesfull emails
    qryQue.Close;
    qryQue.SQL.Clear;
    qryQue.SQL.Add('UPDATE tblEmailQueue SET Active= "F" WHERE Success = "F" AND queueDate < ' +
                   QuotedStr(FormatDateTime('yyyy-mm-dd' ,Now - FastFuncs.StrToInt(EmailFaxServer.INI_Options.TryForDays))));
    qryQue.Execute;
    //Load
    qryQue.Close;
    qryQue.SQL.Clear;
    qryQue.SQL.Add('SELECT * FROM tblEmailQueue WHERE Success = "F" AND Active = "T" ');
    qryQue.SQL.Add('AND (Length(TotalEmail)<'+IntToStr(MaxEmailSize)+') ');
    qryQue.Open;
    qryQue.First;
    LogsLib.AddLogBoth('('+InttoStr(qryQue.Recordcount)+') Emails to Send');
    with qryQue do begin
      while not eof do begin
        Rec := TEmailQueRec.Create;
        Rec.EmailID := FieldByName('EmailID').AsInteger;
        Rec.EmailBody.Add(FieldByName('EmailBody').AsString);
        EmailQueList.Add(Rec);
        Next;
      end;
    end;
  finally
    SysUtils.FreeAndNil(qryQue);
  end;
end;

procedure TSendEmailsThread.SendEmails;
var
  SMTP: TIdSMTP;
  MailMessage:TIdMessage;
  qryQue: TMyQuery;
  i: integer;
  MS: TMemoryStream;
  IdAntiFreeze: TIdAntiFreeze;
begin
  MailMessage:= TIdMessage.Create(nil);
  SMTP :=  TIdSMTP.Create(nil);
  IdAntiFreeze := TIdAntiFreeze.Create(nil);
  qryQue := TMyQuery.Create(nil);
  MS := TMemoryStream.Create;
  try
    IdAntiFreeze.Active := True;
    SMTP.Host := GetSMTPHost;
    SMTP.Port := GetSMTPPort;

    If GetSMTPAuthenticate then Begin
      SMTP.AuthenticationType := atLogin;
      SMTP.Username := GetSMTPUsername;
      SMTP.Password := GetSMTPPassword;
    end;

    qryQue.Connection := DBConnection;
    qryQue.Options.FlatBuffers := True;
    try
    {$IFNDEF NOSENDEMAIL}
     if not SMTP.Connected then SMTP.Connect(1000);
    {$ENDIF}
      for i := 0 to EmailQueList.Count - 1 do begin
        LogsLib.AddLogBoth('Attempting to Send Email '+IntToStr(i+1)+' of '+FastFuncs.IntToStr(EmailQueList.Count));
        qryQue.Close;
        qryQue.SQL.Clear;
        qryQue.SQL.Add('SELECT * FROM tblEmailQueue WHERE EmailID = ' + FastFuncs.IntToStr(TEmailQueRec(EmailQueList[i]).EmailID));
        qryQue.Open;
        If (qryQue.RecordCount>0) then Begin
          MS.Clear;
          TBlobField(qryQue.FieldByName('TotalEmail')).SaveToStream(MS);
          ExcMagic.ExceptionHook.LogEnabled := False;
          Try
            Try
              MS.Position := 0;
              MailMessage.Clear;
              MailMessage.LoadFromStream(TStream(MS));
              MailMessage.ProcessHeaders;
              MailMessage.Body.Text := TEmailQueRec(EmailQueList[i]).EmailBody.Text;
            except
              on E: Exception do Begin
                LogsLib.AddLogBoth('FAILED to Send Email '+IntToStr(i+1)+' of '+IntToStr(EmailQueList.Count));
                if qryQue.Locate('EmailID',TEmailQueRec(EmailQueList[i]).EmailID,[loCaseInsensitive]) then begin
                  qryQue.Edit;
                  qryQue.FieldByName('Success').AsString := 'T';
                  qryQue.Post;
                  LogsLib.AddLogBoth('SEND ERROR - Database ~ `'+FDatabase+'` : To:'+qryQue.FieldByName('EmailTo').AsString +
                                     ' Subject: '+ qryQue.FieldByName('EmailSubject').AsString);
                  LogsLib.AddLogBoth('Errors on :- '+E.Message);
                  Continue;
                end;
              end;
            end;
            try
            {$IFNDEF NOSENDEMAIL}
              if not SMTP.Connected then Exit;
              SMTP.Send(MailMessage);
            {$ENDIF}
            except
               on E: Exception do Begin
                  LogsLib.AddLogBoth('FAILED to Send Email '+IntToStr(i+1)+' of '+IntToStr(EmailQueList.Count));
                  LogsLib.AddLogBoth('SEND ERROR - Database ~ `'+FDatabase+'` : To:'+MailMessage.Recipients.EMailAddresses +' Subject: '+MailMessage.Subject);
                  LogsLib.AddLogBoth('Errors on :- '+Trim(E.Message));
                  Continue;
               end;
            end;
          Finally
            ExcMagic.ExceptionHook.LogEnabled := True;
          end;

          if qryQue.Locate('EmailID',TEmailQueRec(EmailQueList[i]).EmailID,[loCaseInsensitive]) then begin
            qryQue.Edit;
            qryQue.FieldByName('Success').AsString := 'T';
            qryQue.Post;
          end;
          LogsLib.AddLogBoth('Sending Email '+IntToStr(i+1)+' of '+IntToStr(EmailQueList.Count));
        end;
      end;
    except
      // No SMTP Server
      on E: Exception do Begin
        LogsLib.AddLogBoth('Database ~ `'+FDatabase+'` : Send Email Error (' + E.Message +')');
      end;
    end;
  finally
    if SMTP.Connected then SMTP.Disconnect;
    SysUtils.FreeAndNil(MailMessage);
    SysUtils.FreeAndNil(SMTP);
    SysUtils.FreeAndNil(qryQue);
    SysUtils.FreeAndNil(MS);
    SysUtils.FreeAndNil(IdAntiFreeze);
  end;
end;

function TSendEmailsThread.WaitFor: LongWord;
var
  H: THandle;
  WaitResult: Cardinal;
  Msg: TMsg;
begin
  H := Self.Handle;
  if GetCurrentThreadID = MainThreadID then
  begin
    WaitResult := 0;
    repeat
      Application.ProcessMessages;
      if WaitResult = WAIT_OBJECT_0 + 1 then
        PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE);
      Sleep(0);
      Application.ProcessMessages;
      CheckSynchronize;
      Application.ProcessMessages;
      WaitResult := MsgWaitForMultipleObjects(1, H, False, 1, QS_SENDMESSAGE);
      Application.ProcessMessages;
      {$WARN SYMBOL_PLATFORM OFF}
      Win32Check(WaitResult <> WAIT_FAILED);
    until WaitResult = WAIT_OBJECT_0;
  end else WaitForSingleObject(H, INFINITE);
  CheckThreadError(GetExitCodeThread(H, Result));
end;

procedure TSendEmailsThread.CheckThreadError(ErrCode: Integer);
begin
  Inherited;
end;

procedure TSendEmailsThread.CheckThreadError(Success: Boolean);
begin
  Inherited;
end;

end.
 