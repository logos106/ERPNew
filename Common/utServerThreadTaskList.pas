unit utServerThreadTaskList;

interface

uses
  ERPDbComponents;

type
  TDBServerThreadTaskList = class(TObject)
  private
    fServer: string;
    Conn: TERPConnection;
    procedure SetServer(const Value: string);
  published
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read fServer write SetServer;
  end;

implementation

uses
  MySQLUtils, DbConst;

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
	  'INDEX TaskIDIdx (TaskID) ' +
	  ') ' +
	  'ENGINE=InnoDB COMMENT="TableVersion 1";';


{ TDBServerThreadTaskList }

constructor TDBServerThreadTaskList.Create;
begin
  Conn := TERPConnection.Create(nil);

end;

destructor TDBServerThreadTaskList.Destroy;
begin
  Conn.Free;
  inherited;
end;

procedure TDBServerThreadTaskList.SetServer(const Value: string);
begin
  fServer := Value;
  SetConnectionProps(Conn,SERVICES_DATABASE,Value);
  Conn.Connect;
  CheckUpdateTable('tblServerThreadTask',tblServerThreadTask_SQL,Conn);
end;

end.
