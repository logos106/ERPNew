unit ModuleDbUtils;

interface
uses
  MyAccess;

function MySQLDriveFreeSpaceGigaBytes(aMySQLServer: string): double;
function MySQLDriveFreeSpace(aMySQLServer: string): Int64;
procedure InitialiseConnection(Conn: TMyConnection; aServer: string = ''; aDatabase: string = '');


implementation

uses
  DbConst, sysutils, MySQLUtils;

function MySQLDriveFreeSpaceGigaBytes(aMySQLServer: string): double;
var
  bytesFree: Int64;
begin
  bytesFree:= MySQLDriveFreeSpace(aMySQLServer);
  if bytesFree <> -1 then
    result:= Round((bytesFree / (1024*1024*1024))  * 100) / 100
  else
   result:= -1;
end;


function MySQLDriveFreeSpace(aMySQLServer: string): Int64;
var
  Conn: TMyConnection;
  qry: TMyQuery;
  MySQLDriveLetter: string;
  MySQLDriveNumber: integer;
begin
  result:= -1;
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  try
    InitialiseConnection(Conn,aMySQLServer,MYSQL_DATABASE);
    qry.Connection:= Conn;
    try
      conn.Connect;
      qry.SQL.Text:= 'show global variables like "basedir"';
      qry.Open;
      if qry.RecordCount = 1 then begin
        MySQLDriveLetter:= qry.FieldByName('Value').AsString;
        MySQLDriveLetter:= Uppercase(ExtractFileDrive(MySQLDriveLetter));
        if not Ord(MySQLDriveLetter[1]) in [Ord('A')..Ord('Z')] then
          exit;
      end
      else begin
        { cant get mysql directory so exit }
        exit;
      end;

    except
    end;
  finally
    Conn.Free;
    qry.Free;
  end;

  MySQLDriveNumber:= Ord(MySQLDriveLetter[1]) - ORD('A') + 1;
  { DiskFree returns the number of free bytes on the specified drive number,
    where 0 = Current, 1 = A, 2 = B, etc. DiskFree returns -1 if the drive
    number is invalid. }
  result:= DiskFree(MySQLDriveNumber);
end;

procedure InitialiseConnection(Conn: TMyConnection; aServer: string = ''; aDatabase: string = '');
begin
  MySQLUtils.SetConnectionProps(Conn,aDatabase,aServer);

//  Conn.LoginPrompt:= false;
//  Conn.Port:= SERVER_PORT;
//  Conn.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
//  Conn.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
//  Conn.Username:= SYSDB_USER;
//  Conn.Password:= SYSDB_PASS;
//  if aServer <> '' then
//    Conn.Server:= aServer;
//  if aDatabase <> '' then
//    Conn.Database:= aDatabase;
end;


end.
