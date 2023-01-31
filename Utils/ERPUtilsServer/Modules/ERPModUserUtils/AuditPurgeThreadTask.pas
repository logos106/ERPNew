unit AuditPurgeThreadTask;

interface
uses
  ServerModuleThreadTask;

type

  TAuditPurgeThreadTask = class(TServerModuleThreadTask)
  private
    fAuditTrailPurgeProgressPercent: integer;
    procedure DoOnAuditTrailPurgeProgress(Sender: TObject);
  protected
    procedure DoWork; override;
  end;

implementation

uses
  ERPDbListObj, ERPDBComponents, AuditTrailPurgeObj, LogMessageTypes, SysUtils,
  InstallConst;

{ TAuditPurgeThreadTask }

procedure TAuditPurgeThreadTask.DoOnAuditTrailPurgeProgress(Sender: TObject);
var
  fPercent: integer;
begin
  fPercent := Trunc((TAuditTrailPurge(Sender).RecordNumber / TAuditTrailPurge(Sender).RecordCount) * 100);

  if fAuditTrailPurgeProgressPercent <> fPercent then begin
    fAuditTrailPurgeProgressPercent := fPercent;
    Log('Purging Audit Trail ' + TAuditTrailPurge(Sender).Connection.Database +
      ' to file: '  + TAuditTrailPurge(Sender).CurrentPurgeFile + ': ' + IntToStr(fPercent) + '%', ltDetail);
  end;
end;

procedure TAuditPurgeThreadTask.DoWork;
var
  dbList: TERPDbList;
  qry: TERPQuery;
  months: integer;
  atp: TAuditTrailPurge;
  dt: TDateTime;
  msg: string;
begin
  try
    dbList := TERPDbList.Create(MySQLServer);
    qry := TERPQuery.Create(nil);
    atp := TAuditTrailPurge.Create(nil);
    try
     if dbList.First then begin
       atp.OnExportProgres := DoOnAuditTrailPurgeProgress;
       repeat
         if Terminated then begin
           Log(ClassName + ' terminated, aborting email check.',ltDetail);
           exit;
         end;
         self.StatusMessage := 'Database: ' + dbList.Connection.Database;
         qry.Connection := dbList.Connection;
         atp.Connection := dbList.Connection;
         qry.SQL.Text := 'select FieldValue from tbldbpreferences where Name = "AutoPurgeAuditTrail"';
         qry.Open;
         if qry.FieldByName('FieldValue').AsString = 'T' then begin
           qry.Close;
           qry.SQL.Text := 'select FieldValue from tbldbpreferences where Name = "AutoPurgeAuditTrailMonths"';
           qry.Open;
           months:= StrToIntDef(qry.FieldByName('FieldValue').AsString,0);
           qry.Close;
           if months > 0 then begin
             Log('Started purging audit trail for ' + atp.Connection.Database, ltDetail);
             dt := Trunc(now -1);
             dt := IncMonth(dt, - months);
             msg := '';
             if not atp.ExportAndPurge(dt,ERP_SERVER_ROOT_DIR + 'AuditTrail\',msg) then begin
               Log('Error purging audit trail for ' + atp.Connection.Database + ': ' + msg, ltError);
             end
             else begin
               Log('Finished purging audit trail for ' + atp.Connection.Database, ltDetail);
             end;


           end;
         end
         else
           qry.Close;
       until not dbList.Next;

     end;
    finally
      atp.Free;
      qry.Free;
      dbList.Free;
    end;
    self.StatusMessage := '';
  except
    on e: exception do begin
      Log('Error checking audit trail purge: ' + e.Message,ltError);
    end;
  end;
end;

end.
