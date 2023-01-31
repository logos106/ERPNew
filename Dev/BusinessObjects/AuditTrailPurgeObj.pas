unit AuditTrailPurgeObj;

interface

uses
  Classes, ERPDBComponents;

type

  TAuditTrailPurge = class(TComponent)
  private
    fOnExportProgres: TNotifyEvent;
    fRecordNumber: integer;
    fConnection: TERPConnection;
    fProcessActive: boolean;
    fCurrentProcess: string;
    fRecordCount: integer;
    fCurrentPurgeFile: string;
  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;
    function ExportData(const DtFrom, dtTo: TDateTime; FileName: string; var msg: string; AppendToFile: boolean = false): boolean;
    function PurgeData(const DtFrom, dtTo: TDateTime; var msg: string): boolean;
    function ExportAndPurge(dtTo: TDateTime; FileDir: string; var msg: string): boolean;
    property RecordCount: integer read fRecordCount;
    property RecordNumber: integer read fRecordNumber;
    property CurrentProcess: string read fCurrentProcess;
    property CurrentPurgeFile: string read fCurrentPurgeFile;
    property ProcessActive : boolean read fProcessActive write fProcessActive;
    property Connection: TERPConnection read fConnection write fConnection;
    property OnExportProgres: TNotifyEvent read fOnExportProgres write fOnExportProgres;
  end;

implementation

uses
  DbSharedObjectsObj, SysUtils, MySQLConst, DateUtils;

{ TAuditTrailPurge }

constructor TAuditTrailPurge.Create(AOwner: TComponent);
begin
  inherited;
  fCurrentProcess := '';
  fCurrentPurgeFile := ''
end;

destructor TAuditTrailPurge.Destroy;
begin

  inherited;
end;

function TAuditTrailPurge.ExportAndPurge(dtTo: TDateTime; FileDir: string; var msg: string): boolean;
var
  qry: TERPQuery;
  dtStart, dtEnd: TDateTime;
  fileName: string;
begin
  result := true;
  if not ForceDirectories(FileDir) then begin
    result := false;
    msg:= 'Could not create output directory "' + FileDir + '" for audit trail purge.';
    exit;
  end;
  msg := '';
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fConnection);
  try
    qry.SQL.Add('select distinct Month(AuditDate) as `month`, Year(AuditDate) as `year` from tblaudittrail');
    qry.SQL.Add('where AuditDate < "' + FormatDateTime(MysqlDateFormat,dtTo + 1) + '"');
//    qry.SQL.Add('order by AuditDate');
    qry.Open;
    while not qry.Eof do begin
//      fConnection.StartTransaction;
      try
        dtStart := EncodeDate(qry.FieldByName('year').AsInteger, qry.FieldByName('month').AsInteger, 1);
        dtEnd := EndofAMonth(qry.FieldByName('year').AsInteger, qry.FieldByName('month').AsInteger);
        fileName := FileDir + 'AuditTrail_' + fConnection.Database + '_' + FormatDateTime('yyyy_mm',dtStart)+ '.csv';
        if not (self.ExportData(dtStart,dtEnd,fileName,msg,true) and self.PurgeData(dtStart,dtEnd,msg)) then begin
          result:= false;
          exit;
        end;
//        fConnection.Commit;
      finally
//        if fConnection.InTransaction then
//          fConnection.Rollback;
      end;
      qry.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TAuditTrailPurge.ExportData(const DtFrom, dtTo: TDateTime;
  FileName: string; var msg: string; AppendToFile: boolean = false): boolean;
var
  qry, qry2: TERPQuery;
  tf: TextFile;
  d1, d2: TDateTime;
begin
  if (not AppendToFile) and FileExists(FileName) then begin
    result:= false;
    msg:= 'File "' + FileName + '" already exists';
    exit;
  end;
  try
    fProcessActive:= true;
    fCurrentPurgeFile := FileName;
    try
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fConnection);
      qry2 := DbSharedObjectsObj.DbSharedObj.GetQuery(fConnection);
      try
        qry.SQL.Add('select');
        qry.SQL.Add('A.GlobalRef, A.AuditID, A.TransType, A.DataDescription, A.AuditDate, A.ApplicationVersion, E.EmployeeName,');
        qry.SQL.Add('AL.Description, AL.FieldName, AL.OldValue, AL.NewValue, AL.SeqNo');
        qry.SQL.Add('from tblAuditTrail A');
        qry.SQL.Add('left join tblEmployees E on A.EmployeeID = E.EmployeeID');
        qry.SQL.Add('left join tblAuditTrialLines AL on AL.AuditId = A.AuditID');
        qry.SQL.Add('where A.AuditDate between :dtFrom and :dtTo');
        qry.SQL.Add('order by A.AuditID, AL.SeqNo');
        qry2.SQL.Add('select count(*) as AuditCount');
        qry2.SQL.Add('from tblAuditTrail A');
        qry2.SQL.Add('left join tblEmployees E on A.EmployeeID = E.EmployeeID');
        qry2.SQL.Add('left join tblAuditTrialLines AL on AL.AuditId = A.AuditID');
        qry2.SQL.Add('where A.AuditDate between :dtFrom and :dtTo');
        qry2.ParamByName('dtFrom').AsDateTime:= DtFrom;
        qry2.ParamByName('dtTo').AsDateTime:= DtTo;
        qry2.Open;
        self.fRecordCount:= qry2.FieldByName('AuditCount').AsInteger;
        qry2.Close;
        qry2.SQL.Clear;
        qry2.SQL.Add('select Min(AuditDate) as MinDate');
        qry2.SQL.Add('from tblAuditTrail where AuditDate >= "' + FormatDateTime('yyyy-mm-dd',DtFrom) + '"');
        qry2.Open;
        d1:= qry2.FieldByName('MinDate').AsDateTime -8;
        qry2.Close;

        AssignFile(tf,FileName);
        fRecordNumber:= 0;
        if AppendToFile then begin
          if FileExists(FileName) then
            Append(tf)
          else
            Rewrite(tf);
        end
        else
          Rewrite(tf);
        try
          WriteLn(tf,
            'GlobalRef' + ',' +
            'AuditID' + ',' +
            'TransType' + ',' +
            'DataDescription' + ',' +
            'AuditDate' + ',' +
            'ApplicationVersion' + ',' +
            'EmployeeName' + ',' +
            'Description' + ',' +
            'FieldName' + ',' +
            'OldValue' + ',' +
            'NewValue' + ',' +
            'SeqNo'
          );
          repeat
            d1:= d1 + 8;
            d2:= d1 + 7;
            if d2 > dtTo then
              d2 := dtTo;
            if d1 > d2 then
              break;

            qry.ParamByName('dtFrom').AsDateTime:= d1;
            qry.ParamByName('dtTo').AsDateTime:= d2;
            qry.Open;
            while not qry.Eof do begin
              if not fProcessActive then begin
                result:= false;
                exit;
              end;
              Inc(fRecordNumber);
              WriteLn(tf,
                qry.FieldByName('GlobalRef').AsString + ',' +
                qry.FieldByName('AuditID').AsString + ',' +
                qry.FieldByName('TransType').AsString + ',' +
                qry.FieldByName('DataDescription').AsString + ',' +
                '"' + qry.FieldByName('AuditDate').AsString + '",' +
                qry.FieldByName('ApplicationVersion').AsString + ',' +
                '"' + qry.FieldByName('EmployeeName').AsString + '",' +
                qry.FieldByName('Description').AsString + ',' +
                qry.FieldByName('FieldName').AsString + ',' +
                '"' + qry.FieldByName('OldValue').AsString + '",' +
                '"' + qry.FieldByName('NewValue').AsString + '",' +
                qry.FieldByName('SeqNo').AsString
              );
              if Assigned(self.fOnExportProgres) then begin
                fCurrentProcess:= 'Exporting Record ' + IntToStr(fRecordNumber) + ' of ' + IntToStr(fRecordCount);
                self.fOnExportProgres(self);
              end;
              qry.Next;
            end;
            qry.Close;


          until d2 >= dtTo;
        finally
          CloseFile(tf);
        end;
        result:= true;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry2);
        fCurrentProcess:= '';
      end;
    except
      on e: exception do begin
        result:= false;
        msg:= 'Export failed: ' + e.Message;
      end;
    end;
  finally
    fProcessActive:= false;
    fCurrentPurgeFile := '';
  end;
end;

function TAuditTrailPurge.PurgeData(const DtFrom, dtTo: TDateTime;
  var msg: string): boolean;
var
  cmd: TERPCommand;
begin
  result:= true;
  fProcessActive := true;
  try
    try
      cmd := DbSharedObjectsObj.DbSharedObj.GetCommand(fConnection);
      try
        fCurrentProcess:= 'Purging Audit Trail';
        cmd.SQL.Add('delete tblAuditTrail.*, tblAuditTrialLines.* from tblAuditTrail, tblAuditTrialLines');
        cmd.SQL.Add('where tblAuditTrialLines.AuditId = tblAuditTrail.AuditID');
        cmd.SQL.Add('and tblAuditTrail.AuditDate between :dtFrom and :dtTo');
        cmd.ParamByName('dtFrom').AsDateTime:= DtFrom;
        cmd.ParamByName('dtTo').AsDateTime:= DtTo;
        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('delete from tblAuditTrail');
        cmd.SQL.Add('where tblAuditTrail.AuditDate between :dtFrom and :dtTo');
        cmd.ParamByName('dtFrom').AsDateTime:= DtFrom;
        cmd.ParamByName('dtTo').AsDateTime:= DtTo;
        cmd.Execute;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
      end;
    except
      on e: exception do begin
        result:= false;
        msg:= 'Purge failed: ' + e.Message;
      end;
    end;
  finally
    fProcessActive := false;
  end;
  fCurrentProcess:= '';
end;

end.
