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
              Qry.SQl.text := 'select distinct table_name , '+
                            ' CREATE_TIME ,table_rows  '+
                            ' from information_schema.`TABLES`  '+
                            ' where ( (table_name  like "tmp_%" and  LOCATE("_" , SUBSTRING(table_name,5) )>0 ) )  '+
                            ' and table_name not in (Select table_name from information_schema.`TABLES` where Table_schema = "erpnewdb" )  '+
                            ' and TABLE_SCHEMA =  '+ quotedstr(dbList.connection.Database) +
                            ' and CREATE_TIME  <  '+ quotedstr(formatDatetime(mysqldatetimeformat , fdTransactionTableLastUpdated))+
                            ' order by CREATE_TIME desc  ';
              Qry.open;
              Log('Checking for  Temporary  Tables in database ' + Quotedstr(dbList.connection.database) +' Created Before the Last Update Batch ' + FormatDateTime('dd-mm-yyyy hh:nn:ss am/pm' ,fdTransactionTableLastUpdated) ,ltDetail);
              if Qry.recordcount >0 then begin
                    Log('Deleting ' +  inttostr(Qry.recordcount) +' Temporary  Tables from database ' + Quotedstr(dbList.connection.database) ,ltDetail);
                    SQLList:= TStringlist.Create;
                    try
                      Qry.first;
                      while Qry.eof = False do begin
                        SQLList.add('Drop table if exists ' + Qry.fieldbyname('table_name').AsString +';');
                        Log('    ' +Qry.fieldbyname('table_name').AsString );
                        Qry.Next;
                      end;
                      if SQLList.Count >0 then begin
                        if Qry.active then Qry.Close;
                        Qry.SQL.Text := SQLList.TExt;
                        Qry.Execute;
                      end;
                    finally
                      Freeandnil(SQLList);
                    end;
              end;
           finally
             if qry.active then qry.close;
             FreeandNil(Qry);
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
