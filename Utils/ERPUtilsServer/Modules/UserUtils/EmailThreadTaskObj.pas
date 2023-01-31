unit EmailThreadTaskObj;

interface

uses
  ThreadTaskObj, IdMessage, ERPDbComponents;

type
  TEmailThreadTask = class(TThreadTaskBase)
  private
    Conn: TERPConnection;
//    procedure CheckMessageProc(aMessageHeader: TIdMessage; var ProcessMessage: boolean; var Continue: boolean);
//    procedure ProcessMessageProc(aMessage: TIdMessage; var DeleteMessage: boolean; var Continue: boolean);
  protected
    procedure DoWork; override;
  end;


implementation

uses
  Classes, DbConst, MySQLUtils,
  sysutils, DBUtils, MailReaderObj,
  ModuleUserUtilsObj, LogMessageTypes;

{ TEmailThreadTask }

//procedure TEmailThreadTask.CheckMessageProc(aMessageHeader: TIdMessage;
//  var ProcessMessage, Continue: boolean);
//var
//  MessageId: string;
//  qry: TERPQuery;
//begin
//  if Terminated then begin
//    Continue := false;
//    exit;
//  end;
//  ProcessMessage := true;
//  { strip off the < and > }
//  MessageId := copy(aMessageHeader.MsgId,2,Length(aMessageHeader.MsgId)-2);
//  qry := TERPQuery.Create(nil);
//  try
//    qry.Connection := Conn;
//    qry.SQL.Add('select RefId from tblreference');
//    qry.SQL.Add('where MessageId = ' + QuotedStr(MessageId));
//    qry.Open;
//    if not qry.IsEmpty then
//      ProcessMessage := false;
//  finally
//    qry.Free;
//  end;
//end;

procedure TEmailThreadTask.DoWork;
var
  UtilsModule: TModuleUserUtils;
  sl: TStringList;
  x: integer;
//  UserCount: integer;
  qryList: TERPQuery;
  MailReader: TMailReader;
begin
  inherited;
  self.fWasError := false;
  try
    UtilsModule:= TModuleUserUtils(fServerModule);

    Conn:= TERPConnection(GetNewDbConnection());
    sl:= TStringList.Create;
    qryList := TERPQuery.Create(nil);
    MailReader := TMailReader.Create;
    try

      Conn.Server := 'localhost';
      Conn.Database:= MYSQL_DATABASE;
      qryList.Connection := Conn;
      qryList.SQL.Add('select tblEmailConfig.*, tblemployees.TrackEmails');
      qryList.SQL.Add('from tblEmailConfig, tblemployees');
      qryList.SQL.Add('where tblEmailConfig.EntityName = tblemployees.EmployeeName and tblemployees.TrackEmails = "T"');
      qryList.SQL.Add('union all');
      qryList.SQL.Add('select tblEmailConfig.*, tblCompanyInformation.TrackEmails');
      qryList.SQL.Add('from tblEmailConfig, tblCompanyInformation where');
      qryList.SQL.Add('tblEmailConfig.EntityName = "Company" and tblCompanyInformation.TrackEmails = "T"');


      sl.CommaText := MySQLUtils.DatabaseList(Conn,true);
      Log('Starting email check on all databases.', ltInfo);
      for x := 0 to sl.Count -1 do begin
        if SameText(sl[x],'erpnewdb') then continue;
        Log('Starting email check on Database ' +  sl[x] + '.', ltInfo);

        qryList.Close;
        Conn.Disconnect;
        Conn.Database := sl[x];
        Conn.Connect;
        try
          qryList.Open;
          while not qryList.Eof do begin
            if qryList.FieldByName('ConfigValid').AsBoolean then begin
              try
                MailReader.Config.AsString := qryList.FieldByName('ConfigJSON').AsString;
//                MailReader.GetMail(CheckMessageProc,ProcessMessageProc);
              except
                on e: exception do begin
                  Log('Error processing mail for company ' + Conn.Database + ': ' + e.Message,ltError);
                end;
              end;

            end
            else begin
              Log('The email configuration for ' + qryList.FieldByName('EntityName').AsString +
                ' is flagged as invalid, please check and test this configuration.',ltWarning);
            end;
            if self.Terminated then
              exit;
            qryList.Next;
          end;

        except
          on e: exception do begin
            Log('Error: ' + e.Message,ltError);
            self.fStatusMessage:= 'Error: ' + e.Message;
            self.fWasError := true;
            exit;
          end;
        end;


      end;
      Log('Email check finished.', ltInfo);
      self.fStatusMessage := 'Email check finished.';
    finally
      MailReader.Free;
      qryList.Free;
      Conn.Free;
      sl.Free;
      self.fFinishTime := now;
    end;
  except
    on e: exception do begin
      Log('Email check failed: ' + e.Message, ltError);
      self.fWasError := true;
    end;
  end;
end;

//procedure TEmailThreadTask.ProcessMessageProc(aMessage: TIdMessage;
//  var DeleteMessage, Continue: boolean);
//begin
//
//end;

end.
