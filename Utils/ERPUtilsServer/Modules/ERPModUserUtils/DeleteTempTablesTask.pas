unit DeleteTempTablesTask;

interface

uses
  ServerModuleThreadTask;

type

  TDeleteTempTablesTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses ERPDbComponents, ERPDbListObj , Classes , LogMessageTypes, sysutils,
  MySQLConst;



{ TDeleteTempTablesTask }


procedure TDeleteTempTablesTask.DoWork;
var
  dbList: TERPDbList;
  qry: TERPQuery;
  SQLList:TStringlist;
  fdTransactionTableLastUpdated: TDatetime;
begin
  try
    Log('Starting Delete Temp Tables check ...',ltDetail);
    dbList := TERPDbList.Create(MySQLServer);
    try
     if dbList.First then begin
       repeat
           self.StatusMessage := 'Checking ' + dbList.Connection.Database;
           qry := TERPQuery.Create(nil);
           try
              qry.Connection := dbList.Connection;
              Qry.SQl.text := 'SELECT fieldvalue  FROM tbldbpreferences  WHERE NAME = "TransactionTableLastUpdated"';
              Qry.open;
              //fdTransactionTableLastUpdated:= Qry.fieldbyname('fieldvalue').asDatetime;
              fdTransactionTableLastUpdated:= Qry.fieldbyname('fieldvalue').asVariant;
              Qry.close;
              Qry.SQl.text := 'SELECT DISTINCT table_name, ' +
                            ' CREATE_TIME, table_rows ' +
                            ' FROM information_schema.`TABLES` ' +
                            ' WHERE table_name LIKE "tmp_%" AND LOCATE("_", SUBSTRING(table_name, 5)) > 0 AND SUBSTRING(table_name, 1, 18) <> "tmp_vs1_dashboard_" ' +
                            ' AND table_name not IN (SELECT table_name from information_schema.`TABLES` WHERE Table_schema = "erpnewdb" ) ' +
                            ' AND TABLE_SCHEMA =  ' + QuotedStr(dbList.connection.Database) +
                            ' AND CREATE_TIME < ' + QuotedStr(FormatDateTime(mysqldatetimeformat, fdTransactionTableLastUpdated)) +
                            ' ORDER BY CREATE_TIME DESC  ';
              Qry.Open;
              Log('Checking for temporary tables in database ' + Quotedstr(dbList.connection.database) + ' Created Before the Last Update Batch ' + FormatDateTime('dd-mm-yyyy hh:nn:ss am/pm' ,fdTransactionTableLastUpdated) ,ltDetail);
              if Qry.RecordCount > 0 then begin
                Log('Deleting ' + IntToStr(Qry.RecordCount) +' temporary tables from database ' + Quotedstr(dbList.connection.database), ltDetail);
                SQLList := TStringlist.Create;
                try
                  Qry.First;
                  while Qry.EOF = False do begin
                    SQLList.Add('DROP TABLE IF EXISTS ' + Qry.fieldbyname('table_name').AsString + ';');
                    Log('    ' + Qry.fieldbyname('table_name').AsString );
                    Qry.Next;
                  end;
                  if SQLList.Count > 0 then begin
                    if Qry.active then Qry.Close;
                    Qry.SQL.Text := SQLList.TExt;
                    Qry.Execute;
                  end;
                finally
                  FreeAndNil(SQLList);
                end;
              end;
           finally
             if qry.Active then qry.Close;
             FreeAndNil(Qry);
           end;
        until not dbList.Next;
     end;
    finally
      dbList.Free;
      Log('Finished Delete Temp Tables check.',ltDetail);
    end;
  except
    on e: exception do begin
      Log('Error Delete Temp Tables check: ' + e.Message,ltError);
    end;
  end;
end;

constructor TDeleteTempTablesTask.Create;
begin
  inherited;

end;

end.
