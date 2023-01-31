unit MultisiteUtils;

interface

uses
  MyAccess, MyScript, MultisiteConst, DbUtils;

function CreateMSChangeLogTable(conn: TMyConnection;  var msg: string): boolean; overload;
function CreateMSChangeLogTable(aServer, aDatabase: string;  var msg: string): boolean; overload;
function CheckCreateMSTriggers(conn: TMyConnection;  var msg: string): boolean; overload;
function CheckCreateMSTriggers(aServer, aDatabase: string;  var msg: string): boolean; overload;
function CheckRemoteSite(SrcConn, DestConn: TMyConnection; SyncType: TDataSynchronizeType; var msg: string): boolean;


implementation

uses
  SysUtils, frmMultisiteSchema, JsonObject, classes;

function CreateMSChangeLogTable(aServer, aDatabase: string;  var msg: string): boolean;
var  conn: TMyConnection;
begin
  conn:= DbUtils.GetNewDbConnection(aServer,aDatabase);
  try
    try
      conn.Connect;
    except
      on e: exception do begin
        result:= false;
        msg:= 'The following exception error ocured while creating the ' + MS_Change_Log_Table + ' table: ' + e.Message;
        exit;
      end;
    end;
    result:= CreateMSChangeLogTable(conn,msg);
  finally
    conn.Free;
  end;
end;


function CreateMSChangeLogTable(conn: TMyConnection;  var msg: string): boolean;
var
  cmd: TMyCommand;

  function IndexExists(tblName, idxName: string): boolean;
  var q: TMyQuery;
  begin
    q:= TMyQuery.Create(nil);
    try
      q.Connection:= conn;
      q.SQL.Text:= 'show index from ' + tblName + ' where `Key_name` = ' + QuotedStr(idxName);
      q.Open;
      result:= not q.IsEmpty;
    finally
      q.Free;
    end;
  end;

begin
  result:= true;
  msg:= '';
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= conn;
    cmd.SQL.Add('create table if not exists ' + MS_Change_Log_Table + ' (');
    cmd.SQL.Add('TableName varchar(50),');
    cmd.SQL.Add('TableId int(11),');
    cmd.SQL.Add('GlobalRef varchar(255),');
    cmd.SQL.Add('SiteCode varchar(10),');
    cmd.SQL.Add('EditVersion bigint,');
    cmd.SQL.Add('UTCTimeStamp timestamp,');
    cmd.SQL.Add('unique MSChangePrimaryIdx (TableName, TableId)');
    cmd.SQL.Add(') engine MyISAM;');
    try
      cmd.Execute;
    except
      on e: exception do begin
        result:= false;
        msg:= 'The following exception error occured while creating the ' + MS_Change_Log_Table + ' table: ' + e.Message;
        exit;
      end;
    end;
    if not IndexExists(MS_Change_Log_Table,'MsChangeSiteCodeIdx') then begin
      cmd.SQL.Text:= 'alter table '+MS_Change_Log_Table+' add index MsChangeSiteCodeIdx (SiteCode);';
      cmd.Execute;
    end;
    if not IndexExists(MS_Change_Log_Table,'MsChangeEditVersionIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+MS_Change_Log_Table+' add index MsChangeEditVersionIdx (EditVersion);';
      cmd.Execute;
    end;
    if not IndexExists(MS_Change_Log_Table,'MsChangeTimeStampIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+MS_Change_Log_Table+' add index MsChangeTimeStampIdx (UTCTimeStamp);';
      cmd.Execute;
    end;
    if not IndexExists(MS_Change_Log_Table,'MsChangeGlobalRefIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+MS_Change_Log_Table+' add index MsChangeGlobalRefIdx (GlobalRef);';
      cmd.Execute;
    end;

    cmd.SQL.Clear;
    cmd.SQL.Add('create table if not exists ' + Remote_MS_Change_Log_Table + ' (');
    cmd.SQL.Add('TableName varchar(50),');
    cmd.SQL.Add('TableId int(11),');
    cmd.SQL.Add('GlobalRef varchar(255),');
    cmd.SQL.Add('SiteCode varchar(10),');
    cmd.SQL.Add('EditVersion bigint,');
    cmd.SQL.Add('UTCTimeStamp timestamp,');
    cmd.SQL.Add('GroupId int(11),');
    cmd.SQL.Add('unique MSChangePrimaryIdx (TableName, TableId)');
    cmd.SQL.Add(') engine MyISAM;');
    try
      cmd.Execute;
    except
      on e: exception do begin
        result:= false;
        msg:= 'The following exception error occured while creating the ' + Remote_MS_Change_Log_Table + ' table: ' + e.Message;
        exit;
      end;
    end;
    if not IndexExists(Remote_MS_Change_Log_Table,'RemoteMsChangeSiteCodeIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+Remote_MS_Change_Log_Table+' add index RemoteMsChangeSiteCodeIdx (SiteCode);';
      cmd.Execute;
    end;
    if not IndexExists(Remote_MS_Change_Log_Table,'RemoteMsChangeEditVersionIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+Remote_MS_Change_Log_Table+' add index RemoteMsChangeEditVersionIdx (EditVersion);';
      cmd.Execute;
    end;
    if not IndexExists(Remote_MS_Change_Log_Table,'RemoteMsChangeTimeStampIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+Remote_MS_Change_Log_Table+' add index RemoteMsChangeTimeStampIdx (UTCTimeStamp);';
      cmd.Execute;
    end;
    if not IndexExists(Remote_MS_Change_Log_Table,'RemoteMsChangeGlobalRefIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+Remote_MS_Change_Log_Table+' add index RemoteMsChangeGlobalRefIdx (GlobalRef);';
      cmd.Execute;
    end;
    if not IndexExists(Remote_MS_Change_Log_Table,'RemoteMsChangeGroupIdIdx') then begin
      cmd.SQL.Text:= 'alter ignore table '+Remote_MS_Change_Log_Table+' add index RemoteMsChangeGroupIdIdx (GroupId);';
      cmd.Execute;
    end;
  finally
    cmd.Free;
  end;
end;

function CheckCreateMSTriggers(aServer, aDatabase: string;  var msg: string): boolean;
var  conn: TMyConnection;
begin
  conn:= DbUtils.GetNewDbConnection(aServer,aDatabase);
  try
    try
      conn.Connect;
    except
      on e: exception do begin
        result:= false;
        msg:= 'The following exception error ocured while creating the Multisite table triggers: ' + e.Message;
        exit;
      end;
    end;
    result:= CheckCreateMSTriggers(conn,msg);
  finally
    conn.Free;
  end;
end;

function CheckCreateMSTriggers(conn: TMyConnection;  var msg: string): boolean;
var
  qry: TMyQuery;
  Json: TJsonObject;
  TriggerList: TStringList;
  x: integer;

  function ActualClassName(aName: string): string;
  var obj: TJSONObject;
  begin
    result:= aName;
    obj:= Json.O[aName];
    while Assigned(obj) and obj.Exists('InheritsFrom') do begin
      result:= obj.S['InheritsFrom'];
      obj:= Json.O[result];
    end;
  end;

  procedure CheckObject(const aObjectName: string);
  var
    tblName, idFieldName, insertTrigName, updateTrigName, deleteTrigName: string;
    y: integer;
  begin
    tblName:= Json.O[aObjectName].S['tableName'];
    if tblName = '' then
      raise Exception.Create('Error reading schema data, table name is blank for: '+ aObjectName);
    idFieldName:= Json.O[aObjectName].S['IdFieldName'];
    insertTrigName:= tblName + 'InsertMsTrig';
    updateTrigName:= tblName + 'UpdateMsTrig';
    deleteTrigName:= tblName + 'DeleteMsTrig';
    if TriggerList.IndexOf(insertTrigName) < 0 then begin
      qry.SQL.Clear;
      qry.SQL.Add('drop trigger if exists ' + insertTrigName + ';');
      qry.Execute;
      qry.SQL.Clear;
      qry.SQL.Add('create trigger ' + insertTrigName + ' AFTER INSERT on ' + tblName);
      qry.SQL.Add('for each row begin');
      qry.SQL.Add('insert into '+MS_Change_Log_Table+' (tableName,TableId,SiteCode,EditVersion,UTCTimeStamp)');
      qry.SQL.Add('values ('+QuotedStr(tblName)+',NEW.'+idFieldName+',(select SiteCode from tblmsbackendid where BEDefault = "T"),1,utc_timestamp());');
      qry.SQL.Add('end;');
      qry.Execute;
      TriggerList.Add(insertTrigName);
    end;
    if TriggerList.IndexOf(updateTrigName) < 0 then begin
      qry.SQL.Clear;
      qry.SQL.Add('drop trigger if exists ' + updateTrigName + ';');
      qry.Execute;
      qry.SQL.Clear;
      qry.SQL.Add('create trigger ' + updateTrigName + ' AFTER UPDATE on ' + tblName);
      qry.SQL.Add('for each row begin');
      qry.SQL.Add('insert into '+MS_Change_Log_Table+' (tableName,TableId,SiteCode,EditVersion,UTCTimeStamp)');
      qry.SQL.Add('values ('+QuotedStr(tblName)+',NEW.'+idFieldName+',(select SiteCode from tblmsbackendid where BEDefault = "T"),1,utc_timestamp())');
      qry.SQL.Add('on duplicate key update EditVersion = EditVersion + 1, UTCTimeStamp = utc_timestamp();');
      qry.SQL.Add('end;');
      qry.Execute;
      TriggerList.Add(updateTrigName);
    end;
    if TriggerList.IndexOf(deleteTrigName) < 0 then begin
      qry.SQL.Clear;
      qry.SQL.Add('drop trigger if exists ' + deleteTrigName + ';');
      qry.Execute;
      qry.SQL.Clear;
      qry.SQL.Add('create trigger ' + deleteTrigName + ' BEFORE DELETE on ' + tblName);
      qry.SQL.Add('for each row begin');
      qry.SQL.Add('delete from '+MS_Change_Log_Table);
      qry.SQL.Add('where ' + MS_Change_Log_Table + '.TableName = "' +  tblName + '"');
      qry.SQL.Add('and ' + MS_Change_Log_Table + '.TableId = OLD.'+idFieldName + ';');
      qry.SQL.Add('end;');
      qry.Execute;
      TriggerList.Add(updateTrigName);
    end;
    if Json.O[aObjectName].ObjectExists('Objects') then begin
      for y := 0 to Json.O[aObjectName].O['Objects'].Count -1 do begin
        CheckObject(ActualClassName(Json.O[aObjectName].O['Objects'].Items[y].Value.AsObject.S['ClassName']));
      end;
    end;
  end;

begin
  result:= true;
  try
    qry:= TMyQuery.Create(nil);
    Json:= TJsonObject.Create;
    TriggerList:= TStringList.Create;

    try
      qry.Connection:= conn;
      qry.SQL.Text:= 'show triggers';
      qry.Open;
      while not qry.Eof do begin
        TriggerList.Add(qry.FieldByName('Trigger').AsString);
        qry.Next;
      end;
      qry.Close;
      Json.AsString:= TMultisiteSchema.SchemaText;
      for x:= 0 to Json.O['ObjectsToSync'].Count -1 do begin
        CheckObject(ActualClassName(Json.O['ObjectsToSync'].Items[x].Name));
      end;

    finally
      qry.Free;
      Json.Free;
      TriggerList.Free;;
    end;
  except
    on e: exception do begin
      result:= false;
      msg:= 'The following exception error ocured while creating the Multisite table triggers: ' + e.Message;
    end;
  end;
end;

function CheckRemoteSite(SrcConn, DestConn: TMyConnection; SyncType: TDataSynchronizeType; var msg: string): boolean;
var
  RemoteSiteConn: TMyConnection;
  qry: TMyQuery;
begin
  result:= true;
  if SyncType = dstReadFromRemote then
    RemoteSiteConn:= SrcConn
  else
    RemoteSiteConn:= DestConn;
  try
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= RemoteSiteConn;
      qry.SQL.Add('select * from tbldbpreferences');
      qry.SQL.Add('where Name = "RemoteSite" and PrefType = "ptCompany"');
      qry.Open;
      if qry.IsEmpty then begin
        qry.Insert;
        qry.FieldByName('PrefType').AsString:= 'ptCompany';
        qry.FieldByName('Name').AsString:= 'RemoteSite';
        qry.FieldByName('FieldType').AsString:= 'ftBoolean';
        qry.FieldByName('FieldSize').AsInteger:= 0;
        qry.FieldByName('FieldValue').AsString:= 'T';
        qry.Post;
      end
      else if qry.FieldByName('FieldValue').AsString <> 'T' then begin
        qry.Edit;
        qry.FieldByName('FieldValue').AsString:= 'T';
        qry.Post;
      end;
    finally
      qry.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      msg:= 'Error while checking remote database (' + RemoteSiteConn.Server + '  ' +
        RemoteSiteConn.Database + ') is set as "RemoteSite" with exception: ' + e.Message;
    end;
  end;
end;

end.
