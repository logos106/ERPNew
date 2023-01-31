unit utDbServerThreadTaskList;

interface

uses
  ERPDbComponents, SyncObjs;

type
  TDBServerThreadTaskList = class(TObject)
  private
    fServer: string;
    Conn: TERPConnection;
    TaskQry: TERPQuery;
    Lock: TCriticalSection;
    procedure SetServer(const Value: string);
//    function NewConnection(CheckDb: boolean = false): TERPConnection;
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read fServer write SetServer;
    procedure Write(aTaskId, aModuleName, aTaskName, aStatus: string; aStartTime: TDateTime; aComplete: boolean); overload;
    procedure Write(aTaskId, aModuleName, aStatus: string); overload;
    procedure Write(aTaskId, aModuleName: string; aComplete: boolean); overload;
    procedure Delete(aTaskId, aModuleName: string);
    procedure DeleteAllForModule(aModuleName: string);
    procedure DeleteComplete;
    procedure DoDeleteNotInList(aModuleName, KeepIdList: string);
//    class procedure DeleteNotInList(aModuleName, KeepIdList: string; Server: string = '127.0.0.1');
  end;

  function DbThreadTaskList: TDBServerThreadTaskList;

implementation

uses
  MySQLUtils, DbConst, SysUtils, Classes;

const
  tblServerThreadTask_SQL =
    'CREATE TABLE tblServerThreadTask ( ' +
  	'ID INT(11) NOT NULL AUTO_INCREMENT, ' +
    'TaskId VARCHAR(255) NULL DEFAULT NULL, ' +
    'ModuleName VARCHAR(255) NULL DEFAULT NULL, ' +
    'TaskName VARCHAR(255) NULL DEFAULT NULL, ' +
    'StatusMessage VARCHAR(255) NULL DEFAULT NULL, ' +
    'Complete ENUM("T","F") NOT NULL DEFAULT "F", ' +
    'StartTime DATETIME NULL DEFAULT NULL, ' +
    'PRIMARY KEY (ID), ' +
	  'INDEX TaskIDIdx (TaskID), ' +
	  'INDEX ModNameIdx (ModuleName) ' +
	  ') ' +
	  'ENGINE=InnoDB COMMENT="TableVersion 1";';

var
  fDbThreadTaskList: TDBServerThreadTaskList;

function DbThreadTaskList: TDBServerThreadTaskList;
begin
  if not Assigned(fDbThreadTaskList) then
    fDbThreadTaskList := TDBServerThreadTaskList.Create;
  result := fDbThreadTaskList;
end;


{ TDBServerThreadTaskList }

procedure TDBServerThreadTaskList.Write(aTaskId, aModuleName, aTaskName,
  aStatus: string; aStartTime: TDateTime; aComplete: boolean);
begin
  Lock.Acquire;
  try
    TaskQry.ParamByName('TaskId').AsString := aTaskID;
    TaskQry.ParamByName('ModuleName').AsString := aModuleName;
    TaskQry.Open;
    try
  //    Conn.StartTransaction;
      try
        if TaskQry.IsEmpty then begin
          TaskQry.Insert;
          TaskQry.FieldByName('TaskId').AsString := aTaskId;
          TaskQry.FieldByName('ModuleName').AsString := aModuleName;
          TaskQry.FieldByName('TaskName').AsString := aTaskName;
          TaskQry.FieldByName('StartTime').AsDateTime := aStartTime;
        end
        else
          TaskQry.Edit;
        TaskQry.FieldByName('StatusMessage').AsString := aStatus;
        TaskQry.FieldByName('Complete').AsBoolean := aComplete;
        TaskQry.Post;
      finally
  //      Conn.Commit;
      end;
    finally
      TaskQry.Close;
    end;
  finally
    Lock.Release;
  end;
end;

constructor TDBServerThreadTaskList.Create;
begin
  Lock := TCriticalSection.Create;
  Conn := TERPConnection.Create(nil);
  TaskQry := TERPQuery.Create(nil);
  TaskQry.Connection := Conn;
  TaskQry.SQL.Add('SELECT * FROM tblServerThreadTask');
  TaskQry.SQL.Add('WHERE TaskID = :TaskID and ModuleName = :ModuleName');
end;

procedure TDBServerThreadTaskList.Delete(aTaskId, aModuleName: string);
begin
  Lock.Acquire;
  try
    Conn.ExecSQL('delete from tblServerThreadTask where TaskId = ' + QuotedStr(aTaskId)  + ' and ModuleName = ' + QuotedStr(aModuleName), []);
  finally
    Lock.Release;
  end;
end;

procedure TDBServerThreadTaskList.DeleteAllForModule(aModuleName: string);
begin
  Lock.Acquire;
  try
    Conn.ExecSQL('delete from tblServerThreadTask where ModuleName = ' + QuotedStr(aModuleName), []);
  finally
    Lock.Release;
  end;
end;

procedure TDBServerThreadTaskList.DeleteComplete;
begin
  Lock.Acquire;
  try
    Conn.ExecSQL('delete from tblServerThreadTask where Complete = "T"', []);
  finally
    Lock.Release;
  end;
end;

//class procedure TDBServerThreadTaskList.DeleteNotInList(aModuleName, KeepIdList,
//  Server: string);
//var
//  inst: TDBServerThreadTaskList;
//begin
//  inst := TDBServerThreadTaskList.Create;
//  try
//    inst.Server := Server;
//    inst.DeleteNotInList(aModuleName, KeepIdList);
//  finally
//    inst.Free;
//  end;
//end;

procedure TDBServerThreadTaskList.DoDeleteNotInList(aModuleName,
  KeepIdList: string);
begin
  Lock.Acquire;
  try
     Conn.ExecSQL('delete from tblServerThreadTask where (ModuleName = ' +QuotedStr(aModuleName) +
        ' and not TaskID in (' + KeepIdList + ')) or Complete = "T"', []);
  finally
    Lock.Release;
  end;
end;


//function TDBServerThreadTaskList.NewConnection(CheckDb: boolean): TERPConnection;
//var
//  sl: TStringList;
//begin
//  result := TERPConnection.Create(nil);
//  SetConnectionProps(result,SERVICES_DATABASE,fServer);
//  result.Connect;
//  if CheckDb then begin
//
//    sl := TStringList.Create;
//    try
//      sl.CaseSensitive := false;
//      result.GetTableNames(sl);
//      if sl.IndexOf('tblServerThreadTask') < 0 then
//        result.ExecSQL(tblServerThreadTask_SQL, [])
//      else
//        CheckUpdateTable('tblServerThreadTask',tblServerThreadTask_SQL,result);
//
//    finally
//      sl.Free;
//    end;
//
//  end;
//end;

destructor TDBServerThreadTaskList.Destroy;
begin
  TaskQry.Free;
  Conn.Free;
  Lock.Free;
  inherited;
end;

procedure TDBServerThreadTaskList.SetServer(const Value: string);
var
  sl: TStringList;
begin
  Lock.Acquire;
  try
    if fServer = Value then exit;

    fServer := Value;
    SetConnectionProps(Conn,SERVICES_DATABASE,Value);
    Conn.Connect;
    sl := TStringList.Create;
    try
      sl.CaseSensitive := false;
      Conn.GetTableNames(sl);
      if sl.IndexOf('tblServerThreadTask') < 0 then
        Conn.ExecSQL(tblServerThreadTask_SQL, [])
      else
        CheckUpdateTable('tblServerThreadTask',tblServerThreadTask_SQL,Conn);

    finally
      sl.Free;
    end;
  finally
    Lock.Release;
  end;
end;

procedure TDBServerThreadTaskList.Write(aTaskId, aModuleName, aStatus: string);
begin
  Lock.Acquire;
  try
    TaskQry.ParamByName('TaskId').AsString := aTaskID;
    TaskQry.ParamByName('ModuleName').AsString := aModuleName;
    TaskQry.Open;
    try
      if not TaskQry.IsEmpty then begin
  //      Conn.StartTransaction;
        try
          TaskQry.Edit;
          TaskQry.FieldByName('StatusMessage').AsString := aStatus;
          TaskQry.Post;
        finally
  //        Conn.Commit;
        end;
      end;
    finally
      TaskQry.Close;
    end;
  finally
    Lock.Release;
  end;
end;

procedure TDBServerThreadTaskList.Write(aTaskId, aModuleName: string;
  aComplete: boolean);
begin
  Lock.Acquire;
  try
    TaskQry.ParamByName('TaskId').AsString := aTaskID;
    TaskQry.ParamByName('ModuleName').AsString := aModuleName;
    TaskQry.Open;
    try
      if not TaskQry.IsEmpty then begin
  //      Conn.StartTransaction;
        try
          TaskQry.Edit;
          TaskQry.FieldByName('Complete').AsBoolean := aComplete;
          TaskQry.Post;
        finally
  //        Conn.Commit;
        end;
      end;
    finally
      TaskQry.Close;
    end;
  finally
    Lock.Release;
  end;
end;

initialization
  fDbThreadTaskList := nil;
finalization
  fDbThreadTaskList.Free;

end.
