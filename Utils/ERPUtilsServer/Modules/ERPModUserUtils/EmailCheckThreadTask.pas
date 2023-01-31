unit EmailCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj, MailREaderObj;

type

  TEmailCheckThreadTask = class(TServerModuleThreadTask)
  private
    MailReader: TMailReader;
    procedure DoOnEmailProgress(const msg: string; var Continue: boolean);
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  ERPDbListObj, ERPDbComponents, LogMessageTypes, SysUtils;

{ TEmailCheckThreadTask }

constructor TEmailCheckThreadTask.Create;
begin
  inherited;
  self.RemoveWhenComplete := false;
end;

procedure TEmailCheckThreadTask.DoOnEmailProgress(const msg: string;
  var Continue: boolean);
begin
  Continue := not Terminated;
  if Continue then begin
    self.ProgressTime := now;
    Log(MailReader.Connection.Database + ' ' + MailReader.EmailAddress + ' ' + msg, ltDetail);
  end
  else begin
    Log(ClassName + ' terminated, aborting email check during OnProgress event.',ltDetail);
  end;
end;

procedure TEmailCheckThreadTask.DoWork;
var
  dbList: TERPDbList;
  qry: TERPQuery;
  msg: string;
begin
  try
    Log('Starting email check ...',ltDetail);
    dbList := TERPDbList.Create(MySQLServer);
    try
     if dbList.First then begin
       qry := TERPQuery.Create(nil);
       MailReader := TMailReader.Create;
       MailReader.OnProgress := DoOnEmailProgress;
       MailReader.OnLog := Log;
       try
         qry.SQL.Add('select tblEmailConfig.* from tblEmailConfig');
         qry.SQL.Add('left join tblEmployees on tblEmailConfig.EntityName <> "Company" and tblEmailConfig.EntityName = tblEmployees.EmployeeName');
         qry.SQL.Add('left join tblCompanyInformation on tblEmailConfig.EntityName = "Company"');
         qry.SQL.Add('where ConfigValid = "T"');
         qry.SQL.Add('and (IfNull(tblEmployees.TrackEmails,"F") = "T" or IfNull(tblCompanyInformation.TrackEmails,"F") = "T")');
         repeat
           if Terminated then begin
             Log(ClassName + ' terminated, aborting email check.',ltDetail);
             exit;
           end;
           qry.Connection := dbList.Connection;
           qry.Open;
           try
             while not qry.Eof do begin
               if Terminated then begin
                 Log(ClassName + ' terminated, aborting email check.',ltDetail);
                 exit;
               end;
               MailReader.Connection := dbList.Connection;
               MailReader.Config.AsString := qry.FieldByName('ConfigJSON').AsString;
               MailReader.EmailAddress := qry.FieldByName('EmailAddress').AsString;

               if not MailReader.GetMail(msg) then
                 Log('Error checking emails for ' + MailReader.Connection.Database + ' ' + MailReader.EmailAddress + ': ' + msg,ltError);
               qry.Next;
             end;

           finally
             qry.Close;
           end;
         until not dbList.Next;
       finally
         qry.Free;
         MailReader.Free;
       end;
     end;
    finally
      dbList.Free;
      Log('Finished email check.',ltDetail);
    end;
  except
    on e: exception do begin
      Log('Error checking emails: ' + e.Message,ltError);
    end;
  end;
end;

end.
