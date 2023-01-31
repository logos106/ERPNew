unit TempTableUtils;

interface

uses
  ERPDbComponents, Classes, RandomUtils, ConTnrs, MyAccess, DAScript, SysUtils, IntegerListObj,
  UserLockObj;

type
  TAfterTransItem = class;

  TAfterTransList = class(TObject)
  private
    fList: TObjectList;
    UserLock: TUserLock;
    procedure DoAfterCommit(Sender: TObject);
    procedure DoAfterRollback(Sender: TObject);
    function Itemforconn(Conn: TERPConnection): TAfterTransItem;
    Function LockProductQtySum(const aTryCount:Integer = 5):Boolean;
    Procedure UnLockProductQtySum;
    procedure LockProducts(aitem: TAfterTransItem);
    procedure UnlockProducts(aitem: TAfterTransItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddAfterTransSQL(Conn: TERPConnection; aSQL: string);
    procedure AddProductIDtosumQty(Conn: TERPConnection; aProductId:Integer);
    class function Inst: TAfterTransList;
  end;

  TTempTableList = class(TObject)
  private
    fList: TStringList;
    SavedBeforeDissconect: TNotifyEvent;
    procedure DoBeforeDissconnect(Sender: TObject);
    procedure OnErrorEvent(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddTable(aName: string);
    procedure DropTable(aName: string);
    procedure DropAll(Conn: TMyConnection);
    class function Inst: TTempTableList;
  end;



  TAfterTransItem = class(TObject)
  var
    fScript: TERPScript;
    fProductIDs:TIntegerList;
  private
    fSavedAfterCommit: TNotifyEvent;
    fSavedAfterRollback: TNotifyEvent;
    function GetSQL: TStrings;
    function GetConnection: TERPConnection;
    procedure SetConnection(const Value: TERPConnection);
    procedure ItemSctError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
  public
    constructor Create;
    destructor Destroy; override;
    property Script: TERPScript read fScript;
    property Connection: TERPConnection read GetConnection write SetConnection;
    property SavedAfterCommit: TNotifyEvent read fSavedAfterCommit write fSavedAfterCommit;
    property SavedAfterRollback: TNotifyEvent read fSavedAfterRollback write fSavedAfterRollback;
    property SQL: TStrings read GetSQL;
  end;



  function CreateTemporaryTableusingfile(aConnection: TERPConnection;
                                  const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var tablename:String;
                                  var tmpfilename:String;
                                  const TableNameSuffix: string='' ; const EngineName:STring = ''): string;

  Procedure InsertInToTemporaryTableusingfile(aConnection: TERPConnection;const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var SQL1:String;
                                  var SQL2:String;
                                  tmpfilename : String);


  function CreateTableSQL(Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
  function GetTemporaryTableNameSuffix(const EmployeeLogonName: string = ''): string;
  function CreateUserTemporaryTableSQL(var Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
  function CreateUserTemporaryTable(aConnection: TERPConnection; const CreateSQL: TStringList): boolean; overload; {Parameter :Create table SQL statement }
  function CreateUserTemporaryTable(aConnection: TERPConnection;
    const TemplateTableName: string;
    const TableNameSuffix: string = '';
    const EngineName: string = '';
    const MainTransConnection: TERPConnection = nil): string; overload; {Parameter :Name of the template table eg: tmp_Serialnumber}
  procedure DestroyUserTemporaryTable(aConnection: TERPConnection; const sTempTableName: string);
  function TableExists(aConnection: TERPConnection; const TableName: string): boolean;
  function FieldExists(aConnection: TERPConnection; const TableName, Fieldname : string): boolean;
  function GetTemporaryFileName(aConnection: TERPConnection; const Name: string; extension:String ='.tmp'): string;
  function GetUserTemporaryFileName(aConnection: TERPConnection; const Name: string): string;

  function UniqueTableName(const TableIdentifier: string; const MainTransConnection: TERPConnection = nil): string;
  function UniqueTempFileName(const TableIdentifier: string; Conn: TERPConnection): string;
  { NOTE: this assumes a tempory table naming convention as per the UniqueTableName function .. ie }
  {       tmp_erp_[Machine Signature]_[Table Identifier Name]_[Random Name] }
  procedure DropTemporyTables(aUniqueTableName: string; Conn: TERPConnection);
  function SQLFromTemplateTable(const TemplateTableName, TableName: string; Conn: TERPConnection; const EngineName:STring = ''): string;
  function SQLForLoadTableUsingTempFile(TemplateTableName, SQL, FieldList, TempTableName, TempFileName: string; EngineName: string = ''): string;
  function SQLForTempTable(TableName: string; fields: String; indexFields: string; SQLPortion: string;  TempTableName: string; var TempFileName: string; Conn: TERPConnection): string;
  procedure CreateTemporyTableFromTemplate(aConnection: TERPConnection; const TemplateTableName, TempTableName: string; EngineName: string = '');
  procedure EmptyUserTemporaryTable(aConnection: TERPConnection; const sTempTableName: string);
  function NewQuery(aConnection: TERPConnection;SQL: string): TERPQuery;
  function TableStructureMatch(aConnection: TERPConnection;Table1, table2:String):Boolean;

implementation

uses
  StrUtils, MachineSignature, Types, DbSharedObjectsObj,
  MySQLUtils, MySQLConst, AppEnvironmentVirtual, MyScript, SyncReportTableObj,
  (*//Comment for ERPModUserUtils
  CommonLib, ERPErrorEmailUtils, AppEnvironment, *)
  tcConst, ERPVersionConst, dialogs;
//  LogLib;

Const
  Lock_Group = 'Product Qty Sum Update for API List';

function CreateTableSQL(Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
begin
  Result := 'Drop table if exists  `'+Tablename+'`  ;' +
            ' Create table  `'+Tablename+'`  like `' + TemplateTableName + '`;' ;
  if Sysutils.SameText(Enginename , 'Innodb')  then
    Result := result + ' Alter table  `'+Tablename+'`  ENGINE=InnoDB;'
  else
    Result := result + ' Alter table  `'+Tablename+'`  ENGINE=MyISAM;' ;
end;

function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
var
  iIndex: integer;
  sNewValue: string;
begin
  sNewValue := sValue;
  for iIndex := 1 to Length(sValue) do begin
    if not CharInSet(sValue[iIndex],['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
      sNewValue := StringReplace(sNewValue, sValue[iIndex], '_', [rfReplaceAll]);
    end;
  end;
  Result := sNewValue;
end;

function GetTemporaryTableNameSuffix(const EmployeeLogonName: string = ''): string;
var
  aName: string;
begin
  if (EmployeeLogonName <> '') then begin
    { some user names (eg Arabic) will be compleatly replaced by "_" chars,
      in this case uses a random set of characters }
    aName := RemoveInvalidAlphaNumericCharacters(Trim(EmployeeLogonName));
    if ReplaceStr(aName,'_','') = '' then
      aName := MakeRandomString(6);
    Result := '_' + aName
      + '_' + MachineSignature.GetMachineIdentification(true, true, true, true);
  end
  else
    Result := '_' + MakeRandomString(6) + '_' + MachineSignature.GetMachineIdentification(true, true, true, true)
end;


function CreateUserTemporaryTableSQL(var Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
begin
  if trim(tablename) = '' then tablename := TemplateTableName+ Trim(TableNameSuffix) + GetTemporaryTableNameSuffix;
  REsult := CreateTableSQL(Tablename ,TemplateTableName,TableNameSuffix,EngineName);
end;

function GetTemporaryFileName(aConnection: TERPConnection; const Name: string; extension:String ='.tmp'): string;
begin
  REsult := StringReplace(GetMySQLTempDir(aConnection),'\','/',[rfReplaceAll])+
            Name + extension;
end;
Procedure InsertInToTemporaryTableusingfile(aConnection: TERPConnection;const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var SQL1:String;
                                  var SQL2:String;
                                  tmpfilename : String);
var
  filename:String;
begin
  filename := GetTemporaryFileName(aConnection, TemplateTableName );
  tmpfilename := filename;
  filename := replaceStr(filename , '.tmp' ,   '_' +FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now) + '.tmp');
  SQL1 := sSQL+ ' INTO OUTFILE "'+ filename +'";' ;
  SQL2:= ' LOAD DATA INFILE  "'+ filename +'" '+
                ' IGNORE INTO TABLE ' + TemplateTableName +' CHARACTER SET  UTF8 '     +
                '('+Fieldlist +');';
end;

function CreateTemporaryTableusingfile(aConnection: TERPConnection;
                                  const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var tablename:String;
                                  var tmpfilename:String;
                                  const TableNameSuffix: string='' ; const EngineName:STring = ''): string;
var
  filename :String;
begin
  if tablename = '' then
   Result := CreateUserTemporaryTableSQL(tablename , Trim(TemplateTableName) , TableNameSuffix , EngineName);
  filename := GetTemporaryFileName(aConnection, tablename );
  tmpfilename := filename;
  filename := replaceStr(filename , '.tmp' ,   '_' +FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now) + '.tmp');
  REsult := result + ssQL + ' INTO OUTFILE "'+ filename +'";' +
               // 'Select FileExists('+quotedstr(filename)+',10, 1);'+ // this is just a loop running 10 times for a second each - to force to create the file
                ' LOAD DATA INFILE  "'+ filename +'" '+
                'INTO TABLE ' + tablename +' CHARACTER SET  UTF8 '     +
                '('+Fieldlist +');';
end;


function SQLForLoadTableUsingTempFile(TemplateTableName, SQL, FieldList, TempTableName, TempFileName: string; EngineName: string = ''): string;
begin
  result := '';
  if TemplateTableName <> '' then  begin
    result := 'DROP TABLE IF EXISTS `' + TempTableName + '`; ';
    result := result + 'CREATE TABLE `' + TempTableName + '` LIKE `' + TemplateTableName + '`;';
    if Sysutils.SameText(Enginename , 'Innodb')  then
      Result := result + ' ALTER TABLE  `' + TempTableName + '`  ENGINE=InnoDB; '
    else
      Result := result + ' ALTER TABLE  `' + TempTableName + '`  ENGINE=MyISAM; ';
  end;
  result := result + SQL + ' INTO OUTFILE "' + TempFileName + '";' +
    ' LOAD DATA INFILE  "'+ TempFileName +'" '+
    ' INTO TABLE ' + TempTableName +' CHARACTER SET  UTF8 '     +
    '(' + Fieldlist + ');';
end;

function CreateUserTemporaryTable(aConnection: TERPConnection; const CreateSQL: TStringList): boolean;
begin
  Result := true;
  if CreateSQL.text = '' then Exit;
  with TERPScript.Create(nil) do try
    Connection := aConnection;
    SQL.add(CreateSQL.text);
    Execute;
  finally
    Free;
  end;
end;

procedure CreateTemporyTableFromTemplate(aConnection: TERPConnection; const TemplateTableName, TempTableName: string; EngineName: string = '');
var
  cmd: TERPCommand;
begin
  cmd := DbSharedObj.GetCommand(aConnection);
  try
    cmd.SQL.Text := CreateTableSQL(TempTableName,TemplateTableName,EngineName);
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;


function CreateUserTemporaryTable(aConnection: TERPConnection;
  const TemplateTableName: string;
  const TableNameSuffix: string = '';
  const EngineName: string = '';
  const MainTransConnection: TERPConnection = nil): string;
var
  qryTemp: TERPQuery;
  SQLStr: string;
  x: integer;
begin
  result:= 'tmp_'+TemplateTableName + Trim(TableNameSuffix) + GetTemporaryTableNameSuffix;
  { Max MySQL table name length 64 characters }
  if Length(result) > 64 then begin
    x:= Pos('tmp_',Lowercase(result));
    if x = 1 then begin
      while Length(result) > 64 do
        result:= 'tmp_' + Copy(result,6,Length(result));
    end
    else begin
      while Length(result) > 64 do
        result:= Copy(result,2,Length(result));
    end;
  end;

  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := aConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SHOW CREATE TABLE ' + TemplateTableName + ';');
    qryTemp.Open;
    if (qryTemp.RecordCount > 0) then begin
      SQLStr := qryTemp.Fields[1].AsString;
      if EngineName <> '' then
          if Sysutils.SameText(Enginename , 'Innodb') then
            SQLStr := StringReplace(SQLStr , 'ENGINE=MyISAM' , 'ENGINE=InnoDB',[rfIgnoreCase])
          else SQLStr := StringReplace(SQLStr , 'ENGINE=InnoDB','ENGINE=MyISAM',[rfIgnoreCase]);
      qryTemp.Close;
      DestroyUserTemporaryTable(aConnection, result);
      SQLStr := ReplaceStr(uppercase(SQLStr),
                           Trim(uppercase(TemplateTableName)),
                           uppercase(result) );
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add(SQLStr);
      qryTemp.Execute;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
  if Assigned(MainTransConnection) then
    TAfterTransList.Inst.AddAfterTransSQL(MainTransConnection, 'drop table if exists ' + result + ';');

end;
function NewQuery(aConnection: TERPConnection;SQL: string): TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  Result.Options.FlatBuffers := True;
  Result.Connection := aConnection;
  if SQL <> '' then begin
    Result.SQL.add(SQL);
    Result.Open;
  end;
end;
function TableStructureMatch(aConnection: TERPConnection;Table1, table2:String):Boolean;
var
    Qry1, qry2:TERPQuery;
begin
   result := False;
   if not TableExists(aConnection, Table1) then Exit;
   if not TableExists(aConnection, Table2) then Exit;
   Qry1 := NewQuery(aConnection, 'desc ' +Table1);
   Qry2 := NewQuery(aConnection, 'desc ' +Table2);
   try
    if qry1.RecordCount <> qry2.RecordCount then exit;
    qry1.First;
    qry2.First;
    while qry1.Eof = false do begin
      if not sametext(qry1.fieldbyname('Field').AsString    , qry2.fieldbyname('Field').AsString) then exit;
      if not sametext(qry1.fieldbyname('type').AsString     , qry2.fieldbyname('type').AsString) then exit;
      if not sametext(qry1.fieldbyname('null').AsString     , qry2.fieldbyname('null').AsString) then exit;
      if not sametext(qry1.fieldbyname('key').AsString      , qry2.fieldbyname('key').AsString) then exit;
      if not sametext(qry1.fieldbyname('default').AsString  , qry2.fieldbyname('default').AsString) then exit;
      if not sametext(qry1.fieldbyname('extra').AsString  , qry2.fieldbyname('extra').AsString) then exit;
      qry1.next;
      qry2.next;
    end;
    Result := true;
   finally
      Freeandnil(Qry1);
      Freeandnil(Qry2);
   end;
end;
function TableExists(aConnection: TERPConnection; const TableName: string): boolean;
var
  qryTemp: TERPQuery;
begin
  if TableName= '' then begin
      REsult := False;
      Exit;
  end;
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := aConnection;
    //qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(TableName));

    qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(TableName));
    qryTemp.Open;
    Result := not qryTemp.IsEmpty;
    if not result then exit;

    {incase if checking for a table in a differnet datanase . ie: Services.tcomputer }
    qryTemp.close;
    qryTemp.Sql.clear;
    qryTemp.Sql.Add('select * from ' + TableName+' limit 0');
    try
      qryTemp.Open;
      Result := true;
    Except
      on E:Exception do begin
        result := False;
      end;
    end;
    qryTemp.Close;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure DestroyUserTemporaryTable(aConnection: TERPConnection; const sTempTableName: string);
begin
  if sTempTableName = '' then Exit;
  with TERPScript.Create(nil) do try
    Connection := aConnection;
    if TableExists(aConnection, sTempTableName) then   begin
      SQL.add('Flush Table `' + sTempTableName + '`;');
      SQL.add('TRUNCATE `' + sTempTableName + '`;');
    end;
    SQL.add('DROP TABLE IF EXISTS `' + sTempTableName + '`;');
    try
      Execute;
    Except
      on E:Exception do begin
        // kill the exception
      end;
    end;
  finally
    Free;
  end;
end;

function FieldExists(aConnection: TERPConnection; const TableName, Fieldname : string): boolean;
var
  qryTemp: TERPQuery;
begin
  if TableName= '' then begin
      REsult := False;
      Exit;
  end;

  qryTemp := DbSharedObjectsObj.DbSharedObj.GetQuery(aConnection);
  try
    qryTemp.Sql.Add('SELECT * FROM ' +
                  ' INFORMATION_SCHEMA.COLUMNS  ' +
                  ' WHERE TABLE_NAME = '+ Quotedstr(Tablename) +
                  ' AND COLUMN_NAME = '+Quotedstr(FieldName) +
                  ' AND table_schema = '+Quotedstr(qryTemp.Connection.Database));
    qryTemp.Open;
    Result := not qryTemp.IsEmpty;
    qryTemp.Close;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTemp);
  end;

end;

function GetUserTemporaryFileName(aConnection: TERPConnection; const Name: string): string;
begin
  result := StringReplace(GetMySQLTempDir(aConnection),'\','/',[rfReplaceAll])+
            Name + '_' + GetTemporaryTableNameSuffix +'.tmp';
end;

function RandString: string;
const
  Chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  i, N: integer;
begin
  Randomize;
  result := '';
  for i := 1 to 8 do begin
    N := Random(Length(Chars)) + 1;
    result := result + Chars[N];
  end;
end;

function UniqueTableName(const TableIdentifier: string; const MainTransConnection: TERPConnection = nil): string;
begin
//  if Pos('_',TableIdentifier) > 0 then
//    raise Exception.Create('UniqueTableName - TableIdentifier can not contain underscore character!');
  result := MySQLConst.Mysql_TempTablePrefix + MachineSignature.GetMachineIdentification(true,true,true,true) + '_' + TableIdentifier + '_' + RandString;
  result := StringReplace(result, ' ', '_', [rfReplaceAll]);
  { Max MySQL table name length 64 characters }
  if Length(result) > 64 then
    raise Exception.Create('UniqueTableName - TableIdentifier is too long!');
  if Assigned(MainTransConnection) then
    TAfterTransList.Inst.AddAfterTransSQL(MainTransConnection, 'drop table if exists ' + result + ';');
  TTempTableList.Inst.AddTable(result);
end;

function UniqueTempFileName(const TableIdentifier: string; Conn: TERPConnection): string;
begin
//  if Pos('_',TableIdentifier) > 0 then
//    raise Exception.Create('UniqueTableName - TableIdentifier can not contain underscore character!');
  result := MySQLConst.Mysql_TempFilePrefix + MachineSignature.GetMachineIdentification(true,true,true,true) + '_' + TableIdentifier + '_' + RandString;
  result := StringReplace(GetMySQLTempDir(Conn),'\','/',[rfReplaceAll]) + result + '.tmp';
end;


{ NOTE: this assumes a tempory table naming convention as per the UniqueTableName function .. ie }
{       tmp_erp_[Machine Signature]_[Table Identifier Name]_[Random Name] }
procedure DropTemporyTables(aUniqueTableName: string; Conn: TERPConnection);
var
  arr: TStringDynArray;
  name: string;
  qry: TERPQuery;
  scr: TERPScript;
begin
  arr := SplitString(aUniqueTableName,'_');
  if High(arr) < 4 then raise Exception.Create('DropTemporyTables - Invalid Table Name');
  name := arr[0] + '_' + arr[1] + '_' + arr[2] + '_' + arr[3] + '_';
  qry := DbSharedObj.GetQuery(Conn);
  scr := DbSharedObj.GetScript(qry.Connection);
  try
    qry.SQL.Text := 'show tables like "' + name + '%"';
    qry.Open;
    if not qry.IsEmpty then begin
      while not qry.Eof do begin
        scr.SQL.Add('drop table ' + qry.Fields[0].AsString + ';');
        qry.Next;
      end;
      scr.Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
    DbSharedObj.ReleaseObj(scr);
  end;
end;

function SQLFromTemplateTable(const TemplateTableName, TableName: string; Conn: TERPConnection; const EngineName:STring = ''): string;
var
  qry: TERPQuery;
  SQLStr: string;
begin
  qry := DbSharedObj.GetQuery(Conn);
  try
    qry.SQL.Text := 'SHOW CREATE TABLE ' + TemplateTableName;
    qry.Open;
    if not qry.IsEmpty then begin
      SQLStr := qry.Fields[1].AsString;
      if EngineName <> '' then
          if Sysutils.SameText(Enginename , 'Innodb') then
            SQLStr := StringReplace(SQLStr , 'ENGINE=MyISAM' , 'ENGINE=InnoDB',[rfIgnoreCase])
          else SQLStr := StringReplace(SQLStr , 'ENGINE=InnoDB','ENGINE=MyISAM',[rfIgnoreCase]);
      Result := 'DROP TABLE IF EXISTS `' + Tablename + '`; ' +
        ReplaceStr(Uppercase(SQLStr), Trim(Uppercase(TemplateTableName)), Uppercase(Tablename));
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function SQLForTempTable(TableName: string; fields: String; indexFields: string; SQLPortion: string;  TempTableName: string; var TempFileName: string; Conn: TERPConnection): string;
var
  fieldList:TStringlist;
  tableStructure:TStringlist;
  x1, x2: Integer;
  Fielddef,fieldname:String;
  PrimaryKey :String;
  strSQL:String;
  FieldNames:String;
  arr: TStringDynArray;
  tableIdent: string;
  HasGlobalRef: boolean;
begin
  result := '';
  if tablename ='' then exit;
  if fields = '' then exit;
  PrimaryKey := MySQLUtils.MySQLTablePrimaryKey(TableName, Conn, HasGlobalRef);
  if fields =PrimaryKey then exit;

  if TempFileName = '' then begin
    {TempTableNAme will be somthing like:
      tmp_erp_[Machine Signature]_[Table Identifier Name]_[Random Name] or
      tmp_salesreportcust_5510C74D1 or
      'TPrintStatement1' }
    arr := SplitString(TempTableName,'_');
    if High(arr) > 3 then
      tableIdent := arr[3]
    else if High(arr) > 1 then
      tableIdent := arr[2]
    else
      tableIdent := arr[0];

    TempFileName := UniqueTempFileName(tableIdent, Conn);
  end;


  fieldList:=TStringlist.create;
  tableStructure:=TStringlist.create;
  try
    fieldList.commatext := fields;
    ReadTableStructrue(tablename , tableStructure, Conn);
    REsult := '';
    Result := Result +' Drop table if Exists '+Temptablename+';';
    result := Result +' CREATE TABLE `'+Temptablename +'` (';
    REsult := result + PrimaryKey +' int(11) NOT NULL AUTO_INCREMENT,';
    FieldNames :=PrimaryKey;
    for x1 := 0 to fieldList.count-1 do begin
      fieldname := uppercase(fieldList[x1]);
      if pos('.' , fieldname)>0 then begin
        Result := result +copy(fieldname ,pos('.' , fieldname)+1 , length(fieldname))+' VARCHAR(255), ';
        FieldNames := FieldNames +',' +copy(fieldname ,pos('.' , fieldname)+1 , length(fieldname));
      end else begin
        for x2:= 0 to   tableStructure.count-1 do begin
          Fielddef:= uppercase(trim(tableStructure[x2]));
          if (pos(fieldname+' ' , Fielddef)= 1)  or (pos('`' +fieldname+'` ' , Fielddef)= 1) then begin
            Result := result +tableStructure[x2];
            FieldNames := FieldNames +',' +fieldname;
            break;
          end;
        end;
      end;
    end;

    strSQL:='Select Distinct M.'+PrimaryKey ;
    for x1 := 0 to Fieldlist.count-1 do
      if Pos('.' , Fieldlist[x1])<> 0 then strSQL:= strSQL +',' +Fieldlist[x1] else strSQL:= strSQL +',M.' +Fieldlist[x1];
    strSQL:= strSQL +' from ' +tablename +' M  ';
    if SQLPortion <> '' then strSQL := strSQL+SQLPortion;

    REsult := result + ' PRIMARY KEY ( ' +PrimaryKey +')';
    if indexfields <> '' then begin
      fieldList.commatext := indexfields;
      for x1 := 0 to fieldList.count-1 do
        REsult := result +',  KEY `'+fieldList[x1] +'` (`'+fieldList[x1] +'`)';
    end;
    REsult := Result +');';

    Result := Result + SQLForLoadTableUsingTempFile('',
                      strSQL ,
                      FieldNames ,
                      Temptablename , TempFileName);
  finally
    Freeandnil(fieldList);
    Freeandnil(tableStructure);
  end;
end;




{ TAfterTransList }
Function TAfterTransList.Itemforconn(Conn: TERPConnection):TAfterTransItem;
var
  x: integer;
  item: TAfterTransItem;
begin
  item := nil;
  for x := 0 to fList.Count -1 do begin
    if TAfterTransItem(fList[x]).Connection = Conn then begin
      item := TAfterTransItem(fList[x]);
      break;
    end;
  end;
  if not Assigned(item) then begin
    item := TAfterTransItem.Create;
    item.Connection := Conn;
    item.SavedAfterCommit := Conn.AfterCommit;
    item.SavedAfterRollback := Conn.AfterRollback;
    Conn.AfterCommit := self.DoAfterCommit;
    Conn.AfterRollback := self.DoAfterRollback;
    fList.Add(item);
  end;
  Result := item;
end;
function TAfterTransList.LockProductQtySum(const aTryCount:Integer = 5): Boolean;
var
  ctr:Integer;
begin
  result := False;
//  Logtext('LockProductQtySum');
  for ctr := 1 to aTryCount do begin
//    Logtext(inttostr(ctr)+'  of ' + inttostr(aTryCount));
    if userlock.Lock('tblProductQtySum' , 0, Lock_Group)  then begin
//      Logtext('Locked');
      result := true;
      Exit;
    end;
    sleep(100);
  end;
//  Logtext('Lock Failed');
end;

procedure TAfterTransList.UnLockProductQtySum;
begin
  userlock.UnLock('tblProductQtySum' , 0, Lock_Group) ;
end;

procedure TAfterTransList.AddAfterTransSQL(Conn: TERPConnection; aSQL: string);
begin
  with Itemforconn(Conn) do begin
    SQL.Add(aSQL);
  end;
end;

procedure TAfterTransList.AddProductIDtosumQty(Conn: TERPConnection;aProductId: Integer);
begin

  if not (AppEnvVirt.Bool['CompanyPrefs.doUpdateProductQtySum']) then exit;
  if aProductId = 0 then Exit;


  with Itemforconn(conn) do begin
    fProductIDs.AddIfNotInList(aProductId);
  end;
    (*if fProductIDs.AddIfNotInList(aProductId) then
      AddAfterTransSQL(Conn , SyncReportObj.DoUpdateProductQtySum_SQL(aProductID));*)
end;

constructor TAfterTransList.Create;
begin
  fList := TObjectList.Create;
  UserLock := TUserLock.Create(nil);
end;

destructor TAfterTransList.Destroy;
begin
  fList.Free;
  Freeandnil(UserLock);
  inherited;
end;
procedure TAfterTransList.LockProducts(aitem: TAfterTransItem);
var
  x:Integer;
begin
  if aitem.fProductIDs.count =0 then exit;
  for x:= aitem.fProductIDs.count-1 downto 0 do begin
    if not userlock.Lock('tblparts' , aitem.fProductIDs[x], Lock_Group)  then begin
      aitem.fProductIDs.Delete(x);
    end;
  end;
end;
procedure TAfterTransList.UnlockProducts(aitem: TAfterTransItem);
var
  x:Integer;
begin
  if aitem.fProductIDs.count =0 then exit;
  for x:= aitem.fProductIDs.count-1 downto 0 do begin
    userlock.UnLock('tblparts' , aitem.fProductIDs[x], Lock_Group);
  end;
end;

procedure TAfterTransList.DoAfterCommit(Sender: TObject);
var
  x: integer;
  item: TAfterTransItem;
begin
  item := nil;
  for x := 0 to fList.Count -1 do begin
    if TAfterTransItem(fList[x]).Connection = Sender then begin
      item := TAfterTransItem(fList[x]);
      break;
    end;
  end;
  if Assigned(item) then begin
    {make SQL for the productIds need update}
    if item.fProductIDs.count >0 then begin
      LockProducts(Item);
      try
        if item.fProductIDs.count =0 then exit;
        AddAfterTransSQL(item.Connection , SyncReportObj.DoUpdateProductQtySum_SQL(item.fProductIDs.commatext));
        if LockProductQtySum then try
          item.Script.Execute;
        finally
          UnLockProductQtySum;
        end;
      finally
        UnlockProducts(Item);
      end;
    end;
    item.Connection.AfterCommit := item.SavedAfterCommit;
    item.Connection.AfterRollback := item.SavedAfterRollback;
    if assigned(item.Connection.AfterCommit) then item.Connection.AfterCommit(Sender);
    fList.Delete(fList.IndexOf(item));
  end;
end;

procedure TAfterTransList.DoAfterRollback(Sender: TObject);
var
  x: integer;
  item: TAfterTransItem;
begin
  item := nil;
  for x := 0 to fList.Count -1 do begin
    if TAfterTransItem(fList[x]).Connection = Sender then begin
      item := TAfterTransItem(fList[x]);
      break;
    end;
  end;
  if Assigned(item) then begin
    if LockProductQtySum then try
//      Logtext('DoAfterRollback: Updating Qty');
      item.Script.Execute;
//      Logtext('DoAfterRollback: Updated Qty');
    finally
      UnLockProductQtySum;
//      Logtext('DoAfterRollback: UnLockProductQtySum');
    end;
    item.Connection.AfterCommit := item.SavedAfterCommit;
    item.Connection.AfterRollback := item.SavedAfterRollback;
    if assigned(item.Connection.AfterRollback) then item.Connection.AfterRollback(Sender);
    fList.Delete(fList.IndexOf(item));
  end;
end;

var
  fAfterTransList: TAfterTransList;

class function TAfterTransList.Inst: TAfterTransList;
begin
  if not Assigned(fAfterTransList) then
    fAfterTransList := TAfterTransList.Create;
  result := fAfterTransList;
end;

procedure EmptyUserTemporaryTable(aConnection: TERPConnection; const sTempTableName: string);
begin
  if sTempTableName = '' then Exit;
  with TERPScript.Create(nil) do try
    Connection := aConnection;
    if TableExists(aConnection, sTempTableName) then begin
      SQL.add('TRUNCATE `' + sTempTableName + '`;');
      Execute;
    end;
  finally
    Free;
  end;
end;

{ TAfterTransItem }

constructor TAfterTransItem.Create;
begin
  fScript := TERPScript.Create(nil);
  fScript.Onerror := ItemSctError;
  fProductIDs:= TIntegerList.Create;;
end;

destructor TAfterTransItem.Destroy;
begin
  fScript.Free;
  freeandnil(fProductIDs);
  inherited;
end;

function TAfterTransItem.GetConnection: TERPConnection;
begin
  result := TERPConnection(fScript.Connection);
end;

function TAfterTransItem.GetSQL: TStrings;
begin
  result := fScript.SQL;
end;


procedure TAfterTransItem.ItemSctError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
(* //Comment for ERPModUserUtils
if devmode then MessageDlgXP_Vista('Please IGNORE - Silent Error, Message Shown only in Dev Mode' +NL+E.message +NL + SQL, mtWarning, [mbOK], 0)
  else SendEmailtoErp('AfterTransItem Sript.execute Error Error from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Version  : ' +TABLE_VERSION+chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+
                                        'Error :' + E.Message+chr(13) +
                                        '------------------------------------------------------------'+chr(13)+chr(13)+
                                        'Sql With error : ' + SQL+chr(13)+chr(13) +
                                        '------------------------------------------------------------'+chr(13)+chr(13)+
                                        'Complete SQL: ' + fScript.SQL.Text    , '' );*)

  Action := eaContinue ;
end;

procedure TAfterTransItem.SetConnection(const Value: TERPConnection);
begin
  fScript.Connection := Value;
end;

{ TTempTableList }

var
  fTempTableList: TTempTableList;

procedure TTempTableList.AddTable(aName: string);
begin
  fList.Add(aName);
end;

constructor TTempTableList.Create;
begin
  fList := TStringList.Create;
  fList.CaseSensitive := false;
  fList.Duplicates := dupIgnore;
  self.SavedBeforeDissconect := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']).BeforeDisconnect;
  TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']).BeforeDisconnect := self.DoBeforeDissconnect;
end;

destructor TTempTableList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TTempTableList.DoBeforeDissconnect(Sender: TObject);
begin
  DropAll(TMyConnection(Sender));
  if Assigned(SavedBeforeDissconect) then
    SavedBeforeDissconect(Sender);
end;

procedure TTempTableList.DropAll(Conn: TMyConnection);
var
  scr: TMyScript;
  aName: string;
  x: integer;
begin
  try
    scr := TMyScript.Create(nil);
    try
      scr.Connection := Conn;
      scr.OnError := OnErrorEvent;
      for x := 0 to fList.Count -1 do begin
        aName := fList[x];
        scr.SQL.Add('drop table if exists ' + aName + ';');
      end;
      scr.Execute;
      fList.Clear;
    finally
      scr.Free;
    end;
  except

  end;
end;

procedure TTempTableList.DropTable(aName: string);
var
  scr: TERPScript;
begin
  fList.Delete(fList.IndexOf(aName));
  scr := DbSharedObj.GetScript(TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
  try
    scr.SQL.Add('drop table if exists ' + QuotedStr(aName) + ';');
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

class function TTempTableList.Inst: TTempTableList;
begin
  if not Assigned(fTempTableList) then
    fTempTableList := TTempTableList.Create;
  result := fTempTableList;
end;

procedure TTempTableList.OnErrorEvent(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue;
end;

initialization
  fTempTableList := nil;
  fAfterTransList := nil;

finalization
  fAfterTransList.Free;
  fTempTableList.Free;
end.
