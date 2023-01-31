unit ErpApiDbObj;

interface

uses
  SyncObjs, MyAccess, MyScript, ConTnrs;

type

  TConnectionPool = class;
  TQueryPool = class;
  { Class used for all Api database interaction with Erp Database. }
  { Shared by all threads. }
  TErpApiDb = class(TObject)
  private
    fCritSect: TCriticalSection;
    fMapConn: TMyconnection;
    FDatabaseServer: string;
    fConnectionPool: TConnectionPool;
    fQueryPool: TQueryPool;
    procedure SetDatabaseServer(const Value: string);
    function GetMapConn: TMyConnection;
    procedure Lock;
    procedure Unlock;
  protected
    property MapConn: TMyConnection read GetMapConn;
  public
    constructor Create;
    destructor Destroy; override;
    property DatabaseServer: string read FDatabaseServer write SetDatabaseServer;
    procedure CreateObjectMapping(const aTypeName, aErpTableName, aDatabaseName: string);
    property ConnectionPool: TConnectionPool read fConnectionPool;
    property QueryPool: TQueryPool read fQueryPool;
  end;

  TConnectionPool = class(TObject)
  private
    fUsableList: TObjectList;
    fBusyList: TObjectList;
    fLock: TCriticalSection;
    fMaxConnections: integer;
    fActive: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Borrow(const aServerName, aDatabaseName: string; TimeoutSecs: integer = 0): TMyConnection;
    procedure Release(conn: TMyConnection);
    property MaxConnections: integer read fMaxConnections write fMaxConnections;
    property Active: boolean read fActive write fActive;
  end;

  TQueryPool = class(TObject)
  private
    fUsableList: TObjectList;
    fBusyList: TObjectList;
    fLock: TCriticalSection;
    function Borrow(const aClassName: string; conn: TMyConnection): TObject;
  public
    constructor Create;
    destructor Destroy; override;
    function BorrowQuery(conn: TMyConnection): TMyQuery;
    function BorrowCommand(conn: TMyConnection): TMyCommand;
    function BorrowScript(conn: TMyConnection): TMyScript;
    procedure Release(item: Tobject);
  end;

  function ApiDb: TErpApiDb;

implementation

uses
  MySQLUtils, SysUtils, DateUtils, JsonObject, Types, StrUtils, StringUtils;

const
  MappingDatabase = 'erpdocumentation';
  MappingTableCreateSQL =
    'CREATE TABLE if not exists `tblErpObjectMapping` (' +
    ' `ID` INT(11) NOT NULL AUTO_INCREMENT,' +
    ' `TypeName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `DbTableName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `DbFilter` VARCHAR(255) NULL DEFAULT "",' +
    ' `Mapping` LongText NULL DEFAULT NULL,' +
    ' `ApiEnabled` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' `ReadOnly` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' PRIMARY KEY (`ID`),' +
    ' INDEX TypeNameIdx (TypeName)' +
    ')ENGINE=MyISAM  COMMENT="TableVersion 1";';


var
  fApiDB: TErpApiDb;

function ApiDb: TErpApiDb;
begin
  if not Assigned(fApiDB) then
    fApiDB := TErpApiDb.Create;
  result := fApiDB;
end;


{ TErpApiDb }

constructor TErpApiDb.Create;
begin
  fCritSect := TCriticalSection.Create;
  fMapConn := nil;
  fConnectionPool := TConnectionPool.Create;
  fQueryPool := TQueryPool.Create;
end;

procedure TErpApiDb.CreateObjectMapping(const aTypeName, aErpTableName, aDatabaseName: string);
var
  ErpQry, MapQry: TMyQuery;
  ErpConn: TMyConnection;
  map, prop: TJsonObject;
  fldType: string;
  fldParams: TStringDynArray;

  function SplitFieldType(const aTypeStr: string; var aParams: TStringDynArray): string;
  var
    posn, y: integer;
    s: string;
  begin
    //s := aTypeStr;
    SetLength(aParams,0);
    posn := Pos('(',aTypeStr);
    if posn > 0 then begin
      s := Copy(aTypeStr,posn+1,Length(aTypeStr));
      s := copy(s,1,Length(s)-1);
      aParams := SplitString(s,',');
      for y := Low(aParams) to High(aParams) do
        aParams[y] := StripQuotes(aParams[y]);
      s := Copy(aTypeStr,1,posn-1);
    end
    else
      s := aTypeStr;
    result := s;
  end;


begin
  ErpConn := ConnectionPool.Borrow(DatabaseServer,aDatabaseName,60);
  map := JO;
  try
    ErpQry := QueryPool.BorrowQuery(ErpConn);
    MapQry := QueryPool.BorrowQuery(MapConn);
    try
      MapQry.SQL.Add('select * from tblErpObjectMapping');
      MapQry.SQL.Add('where TypeName = ' + QuotedStr(aTypeName));
      MapQry.Open;
      if not MapQry.IsEmpty then begin
        map.AsString := MapQry.FieldByName('Mapping').AsString;
      end
      else begin
        { not found .. }
        MapQry.Insert;
        MapQry.FieldByName('TypeName').AsString := aTypeName;
        MapQry.FieldByName('DbTableName').AsString := aErpTableName;
        MapQry.FieldByName('ApiEnabled').AsBoolean := false; { .. by default}
        MapQry.Post;
        map.S['ObjectName'] := aTypeName;
        map.S['DbTableName'] := aErpTableName;
      end;


      ErpQry.SQL.Add('show columns from ' + aErpTableName);
      ErpQry.Open;
      while not ErpQry.Eof do begin
        { check / map each field }
        prop := map.A['Mapping'].ObjByPropVal('Field',ErpQry.FieldByName('Field').AsString);
        if not Assigned(prop) then begin
          prop := JO;
          prop.S['Field'] := ErpQry.FieldByName('Field').AsString;
          prop.S['Prop'] := ''; { we don't know the user friendly property at this stage .. }
          prop.B['ApiEnabled'] := false; { .. by default }


          map.A['Mapping'].Add(prop);
        end;
        prop.S['DbType'] := ErpQry.FieldByName('Field').AsString;
        prop.S['DbNull'] := ErpQry.FieldByName('Null').AsString;
        prop.S['DbDefault'] := ErpQry.FieldByName('Default').AsString;
        { now update the user friendly property definitions .. }
        fldType := SplitFieldType(ErpQry.FieldByName('Type').AsString,fldParams);

        // https://www.tutorialspoint.com/mysql/mysql-data-types.htm
        { string data types .. }
        if SameText(fldType,'char') then begin
          prop.S['Type'] := 'Text';
          if Length(fldParams) > 0 then
            prop.I['Length'] := StrToInt(fldParams[0]);
        end
        else if SameText(fldType,'varchar') then begin
          prop.S['Type'] := 'Text';
          if Length(fldParams) > 0 then
            prop.I['Length'] := StrToInt(fldParams[0]);
        end
        else if SameText(fldType,'text') then begin
          prop.S['Type'] := 'Text';
          prop.I['Length'] := 65535;
        end
        else if SameText(fldType,'blob') then begin
          prop.S['Type'] := 'Binary';
          prop.I['Length'] := 65535;
        end
        else if SameText(fldType,'tinytext') then begin
          prop.S['Type'] := 'Text';
          prop.I['Length'] := 255;
        end
        else if SameText(fldType,'tinyblob') then begin
          prop.S['Type'] := 'Binary';
          prop.I['Length'] := 255;
        end
        else if SameText(fldType,'mediumtext') then begin
          prop.S['Type'] := 'Text';
          prop.I['Length'] := 16777215;
        end
        else if SameText(fldType,'mediumblob') then begin
          prop.S['Type'] := 'Binary';
          prop.I['Length'] := 16777215;
        end
        else if SameText(fldType,'longtext') then begin
          prop.S['Type'] := 'Text';
          prop.I['Length'] := 4294967295;
        end
        else if SameText(fldType,'longblob') then begin
          prop.S['Type'] := 'Binary';
          prop.I['Length'] := 4294967295;
        end
        else if SameText(fldType,'enum') then begin
          if (Length(fldParams) = 2) and (fldParams[0] = 'T') and (fldParams[0] = 'F') then begin
            prop.S['Type'] := 'Boolean';
          end
          else begin


          end;
        end
        { numeric data types .. }
        else if SameText(fldType,'int') then begin

        end
        else if SameText(fldType,'tinyint') then begin

        end
        else if SameText(fldType,'smallint') then begin

        end
        else if SameText(fldType,'mediumint') then begin

        end
        else if SameText(fldType,'bigint') then begin

        end
        else if SameText(fldType,'float') then begin

        end
        else if SameText(fldType,'double') then begin

        end
        else if SameText(fldType,'decimal') then begin

        end
        { date and time data types .. }
        else if SameText(fldType,'date') then begin
          prop.S['Type'] := 'Date';
        end
        else if SameText(fldType,'datetime') then begin
          prop.S['Type'] := 'DateTime';
        end
        else if SameText(fldType,'timestamp') then begin
          prop.S['Type'] := 'TimeStamp';
        end
        else if SameText(fldType,'time') then begin
          prop.S['Type'] := 'Time';
        end
        else if SameText(fldType,'year') then begin
          prop.S['Type'] := 'Year';
          if Length(fldParams) > 0 then
            prop.I['Length'] := StrToInt(fldParams[0]);
        end;

        ErpQry.Next;
      end;
      MapQry.Edit;
      MapQry.FieldByName('Mapping').AsString := map.AsString;
      MapQry.Post;
    finally
      QueryPool.Release(ErpQry);
      QueryPool.Release(MapQry);
    end;
  finally
    map.Free;
    ConnectionPool.Release(ErpConn);
  end;
end;

destructor TErpApiDb.Destroy;
begin
  fConnectionPool.Free;
  fQueryPool.Free;
  fMapConn.Free;
  fCritSect.Free;
  inherited;
end;

function TErpApiDb.GetMapConn: TMyConnection;
begin
  if not Assigned(fMapConn) then begin
    fMapConn := TMyConnection.Create(nil);
    MySQLUtils.SetConnectionProps(fMapConn,MappingDatabase,DatabaseServer);
    fMapConn.Connect
  end;
  result := fMapConn;
end;

procedure TErpApiDb.Lock;
begin
  fCritSect.Acquire;
end;

procedure TErpApiDb.SetDatabaseServer(const Value: string);
begin
  FDatabaseServer := Value;
end;

procedure TErpApiDb.Unlock;
begin
  fCritSect.Release;
end;

{ TConnectionPool }

function TConnectionPool.Borrow(const aServerName, aDatabaseName: string;
  TimeoutSecs: integer): TMyConnection;
var
  dt: TDateTime;
begin
  result := nil;
  dt := now;
  while (TimeoutSecs = 0) or (now < (dt + (TimeOutSecs * OneSecond))) do begin
    fLock.Acquire;
    try
      if fUsableList.Count > 0 then
        result := TMyConnection(fUsableList.Extract(fUsableList[0]))
      else if (fMaxConnections = 0) or ((fUsableList.Count + fBusyList.Count) < fMaxConnections) then begin
        result := TMyConnection.Create(nil);
        SetConnectionProps(result,aDatabaseName,aServerName);
        fBusyList.Add(result);
      end;
    finally
      fLock.Release;
    end;
    if Assigned(result) then begin
      result.Server := aServerName;
      result.Database := aDatabaseName;
      try
        result.Connect;
      except
      end;
      break;
    end
    else
      Sleep(20);
  end;
end;

constructor TConnectionPool.Create;
begin
  fUsableList := TObjectList.Create;;
  fBusyList := TObjectList.Create;;
  fLock := TCriticalSection.Create;
  fMaxConnections := 0;
  fActive := true;
end;

destructor TConnectionPool.Destroy;
var
  dt: TDateTime;
  cnt: integer;
begin
  Active := false;
  dt := now;
  while (now < (dt + (60 * OneSecond))) do begin
    fLock.Acquire;
    try
      cnt := fBusyList.Count;
    finally
      fLock.Release;
    end;
    if cnt > 0 then Sleep(50)
    else break;
  end;
  fUsableList.Free;
  fBusyList.Free;
  fLock.Free;
  inherited;
end;

procedure TConnectionPool.Release(conn: TMyConnection);
var
  obj: TObject;
begin
  fLock.Acquire;
  try
    if conn.Connected then conn.Disconnect;
    obj := fBusyList.Extract(conn);
    fUsableList.Add(obj);
  finally
    fLock.Release;
  end;
end;

{ TQueryPool }

function TQueryPool.Borrow(const aClassName: string;
  conn: TMyConnection): TObject;
var
  x: integer;
  obj: TObject;
begin
  obj := nil;
  for x := 0 to fUsableList.Count -1 do begin
    if fUsableList[x].ClassNameIs(aClassName) then begin
      obj := fUsableList.Extract(fUsableList[x]);
      if obj is TMyQuery then TMyQuery(obj).Connection := conn
      else if obj is TMyCommand then TMyCommand(obj).Connection := conn
      else if obj is TMyScript then TMyScript(obj).Connection := conn;
      break;
    end;
  end;
  if not assigned(obj) then begin
    if SameText(aClassName,'TMyQuery') then begin
      obj := TMyQuery.Create(nil);
      TMyQuery(Obj).Connection := conn;
    end
    else if SameText(aClassName,'TMyCommand') then begin
      obj := TMyCommand.Create(nil);
      TMyCommand(Obj).Connection := conn;
    end
    else if SameText(aClassName,'TMyScript') then begin
      obj := TMyScript.Create(nil);
      TMyScript(Obj).Connection := conn;
    end;
  end;
  fBusyList.Add(obj);
  result := obj;
end;

function TQueryPool.BorrowCommand(conn: TMyConnection): TMyCommand;
begin
  fLock.Acquire;
  try
    result := TMyCommand(Borrow('TMyCommand',conn));
  finally
    fLock.Release;
  end;
end;

function TQueryPool.BorrowQuery(conn: TMyConnection): TMyQuery;
begin
  fLock.Acquire;
  try
    result := TMyQuery(Borrow('TMyQuery',conn));
  finally
    fLock.Release;
  end;
end;

function TQueryPool.BorrowScript(conn: TMyConnection): TMyScript;
begin
  fLock.Acquire;
  try
    result := TMyScript(Borrow('TMyScript',conn));
  finally
    fLock.Release;
  end;
end;

constructor TQueryPool.Create;
begin
  fUsableList := TObjectList.Create;;
  fBusyList := TObjectList.Create;;
  fLock := TCriticalSection.Create;
end;

destructor TQueryPool.Destroy;
begin
  fUsableList.Free;
  fBusyList.Free;
  fLock.Free;
  inherited;
end;

procedure TQueryPool.Release(item: Tobject);
var
  obj: TObject;
begin
  fLock.Acquire;
  try
    obj := fBusyList.Extract(item);
    if Assigned(obj) then begin
      fUsableList.Add(obj);
      if obj is TMyQuery then begin
        TMyQuery(obj).Close;
        TMyQuery(obj).SQL.Clear;
        TMyQuery(obj).Connection := nil;
      end
      else if obj is TMyCommand then begin
        TMyCommand(obj).SQL.Clear;
        TMyCommand(obj).Connection := nil;
      end
      else if obj is TMyScript then begin
        TMyScript(obj).SQL.Clear;
        TMyScript(obj).Connection := nil;
      end;
    end;
  finally
    fLock.Release;
  end;
end;

initialization
  fApiDB := nil;

finalization
  fApiDB.Free;

end.
