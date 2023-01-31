unit utServerTask;

interface

uses
  JsonObject;

type
  TServerTaskRec = class(TObject)
  private
    fServer: string;
    fComplete: boolean;
    fID: integer;
    fTaskStatus: string;
    fTaskType: string;
    fStatusMessage: string;
    fData: TJsonObject;
    procedure CheckDb;
    function GetAsJson: string;
  public
    constructor Create(const aServer: string = '');
    destructor Destroy; override;
    property ID: integer read fID write fID;
    property TaskType: string read fTaskType write fTaskType;
    property Complete: boolean read fComplete write fComplete;
    property StatusMessage: string read fStatusMessage write fStatusMessage;
    property TaskStatus: string read fTaskStatus write fTaskStatus;
    property Data: TJsonObject read fData;
    procedure Save;
    procedure Load;
    property AsJson: string read GetAsJson;
    class function New(const aType: string; aServer: string = ''): TServerTaskRec;
    class function Get(const aID: integer; aServer: string = ''): TServerTaskRec;
  end;

implementation

uses
  Classes, ERPDbComponents, MySQLUtils, dbConst, SysUtils;

const

  tblServerTask_SQL =
    'CREATE TABLE tblServerTask ( ' +
  	'ID INT(11) NOT NULL AUTO_INCREMENT, ' +
	  'TaskType VARCHAR(255) NULL DEFAULT NULL, ' +
	  'Complete ENUM("T","F") NOT NULL DEFAULT "F", '+
	  'TaskStatus VARCHAR(255) NULL DEFAULT NULL, ' +
    'StatusMessage VARCHAR(255) null default NULL, ' +
	  'Data MEDIUMTEXT NULL, ' +
    'PRIMARY KEY (ID), ' +
	  'INDEX TaskTypeIdx (TaskType) ' +
	  ') ' +
	  'ENGINE=InnoDB COMMENT="TableVersion 1";';


{ TServerTaskRec }

procedure TServerTaskRec.CheckDb;
var
  sl: TStringList;
  fConn: TErpConnection;
begin
  fConn := TErpConnection.Create(nil);
  sl:= TStringList.Create;
  try
    SetConnectionProps(fConn, MYSQL_DATABASE, fServer);
    fConn.Connect;
    fConn.GetDatabaseNames(sl);
    if sl.IndexOf(SERVICES_DATABASE) < 0 then begin
      fConn.ExecSQL('create database ' + SERVICES_DATABASE,[]);
      fConn.Disconnect;
      fConn.Database:= SERVICES_DATABASE;
      fConn.Connect;
      fConn.ExecSQL(tblServerTask_SQL,[]);
    end
    else begin
      fConn.Disconnect;
      fConn.Database:= SERVICES_DATABASE;
      fConn.Connect;
      fConn.GetTableNames(sl);
      if sl.IndexOf('tblServerTask') < 0 then begin
        fConn.ExecSQL(tblServerTask_SQL,[]);
      end
      else begin
        CheckUpdateTable('tblServerTask',tblServerTask_SQL,fConn);
      end;
    end;
    fConn.Disconnect;
  finally
    fConn.Free;
    sl.Free;
  end;
end;

constructor TServerTaskRec.Create(const aServer: string);
begin
  fData := JO;
  if aServer <> '' then fServer := aServer
  else fServer := 'localhost';
  fComplete := false;
  CheckDb;
end;

destructor TServerTaskRec.Destroy;
begin
  fData.Free;
  inherited;
end;

class function TServerTaskRec.Get(const aID: integer; aServer: string): TServerTaskRec;
begin
  result := TServerTaskRec.Create(aServer);
  result.ID := aID;
  result.Load;
end;

function TServerTaskRec.GetAsJson: string;
var
  Json: TJsonObject;
begin
  Json := JO;
  try
    Json.I['ID'] := ID;
    Json.S['TaskType'] := TaskType;
    Json.B['Complete'] := Complete;
    Json.S['StatusMessage'] := StatusMessage;
    Json.S['TaskStatus'] := TaskStatus;
    Json.O['Data'].Assign(Data);
    result := Json.AsString;
  finally
    Json.Free;
  end;
end;

procedure TServerTaskRec.Load;
var
  Conn: TErpConnection;
  qry: TErpQuery;
begin
  Conn := TErpConnection.Create(nil);
  qry := TErpQuery.Create(nil);
  try
    SetConnectionProps(Conn, SERVICES_DATABASE, fServer);
    Conn.Connect;
    qry.Connection := Conn;
    qry.SQL.Text := 'select * from tblServerTask where ID = ' + IntToStr(ID);
    qry.Open;
    TaskType := qry.FieldByName('TaskType').AsString;
    Complete := qry.FieldByName('Complete').AsBoolean;
    TaskStatus := qry.FieldByName('TaskStatus').AsString;
    StatusMessage := qry.FieldByName('StatusMessage').AsString;
    Data.AsString := qry.FieldByName('Data').AsString;
    qry.Close;
  finally
    qry.Free;
    Conn.Free;
  end;
end;

class function TServerTaskRec.New(const aType: string; aServer: string): TServerTaskRec;
begin
  result := TServerTaskRec.Create(aServer);
  result.TaskType := aType;
  result.ID := 0;
  result.Save;
end;

procedure TServerTaskRec.Save;
var
  Conn: TErpConnection;
  qry: TErpQuery;
begin
  Conn := TErpConnection.Create(nil);
  qry := TErpQuery.Create(nil);
  try
    SetConnectionProps(Conn, SERVICES_DATABASE, fServer);
    Conn.Connect;
    qry.Connection := Conn;
    qry.SQL.Text := 'select * from tblServerTask where ID = ' + IntToStr(ID);
    qry.Open;
    if qry.IsEmpty then
      qry.Insert
    else
      qry.Edit;
    qry.FieldByName('TaskType').AsString := TaskType;
    qry.FieldByName('Complete').AsBoolean := Complete;
    qry.FieldByName('TaskStatus').AsString := TaskStatus;
    qry.FieldByName('StatusMessage').AsString := StatusMessage;
    qry.FieldByName('Data').AsString := Data.AsString;
    qry.Post;
    ID := qry.FieldByName('ID').AsInteger;
    qry.Close;
  finally
    qry.Free;
    Conn.Free;
  end;
end;

end.
