unit CommonDbLib;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/03/05  1.00.01 IJB  Moved GetSequenceNumber function into this lib from CommonLib.

 1/4/05    1.00.02 DJH  Implemented two new functions in the aid to prevent locking
                        of database tables.  This is still in early development and
                        will require expansion with no doubt.
 19/04/05  1.00.03 IJB  Fixed incorect column name in GetSequenceNumber func.
 25/05/05  1.00.04 BJ  'Raise exception' is changed to MessageDlg for user messages
 03/06/05  1.00.05 ISB  Moved IsClientNameUnique from Cust/Sup/Contact
 16/06/05  1.00.06 ISB  Add GetDefaultReport
 21/06/05  1.00.07 DMS  Added DBExists function
 07/07/05  1.00.08 DMS  1. Formatted unit's source code.
                        2. Modified condition in SetMyDacConnection function.
 25/07/05  1.00.09 DMS  1. Added CheckEditMode procedure that will ensure that
                           dataset is set edit mode.
                        2. Added CheckInsertMode procedure to ensure dataset is
                           in insert mode.
 28/07/05  1.00.10 IJB  Fixed GetCompanyInfo
 30/08/05  1.00.11 DSP  Added a function to check for a database version match
                        with ERPNewDB.
 19/09/05  1.00.12 IJB  Added function TempMyQuery.
 20/09/05  1.00.13 ISB  Move User Temporary Table functions From DnMlib
 06/04/06  1.00.14 AL   Added AddToPayAuthorisations used in Bill, Credit, PurchaseOrder

}
interface

uses
  MyAccess,ERPdbComponents, MyClasses, Classes, Windows, DateUtils, DB, DBTables, tcTypes,
  Graphics, GraphUtil, Math, Controls, Forms, DAScript, MyScript;

type
    TTableListProcessProc = Procedure (const Tablename:String) of Object;
    TTablefieldListProcessProc = Procedure (const Tablename,fieldname:String) of Object;

const
  { constants used for GetSequenceNumber function }
  SEQ_CustAccountNumber = 'CustomerAccountNumber';
  SEQ_JobNumber = 'JobNumber';

function BooleanToSQLStr(const Value: boolean): string;
function CreateDatabase(Const DBCreateRec: TDBCreateRec; var ErrorMsg: string): boolean;
function CreateTableFromSQL(Const TableName: string; var SQL, ErrorMsg: string; IndexDefs: string = ''): boolean;
function DBExists(const DBName: string): boolean;
function DropDatabase(const DatabaseName: string; var ErrorMsg: string): boolean;
function ExecuteDBCommand(const Command: string; var ErrorMsg: string): boolean;
function ExecuteDBStatement(const Statement: string; var ErrorMsg: string): boolean;
function ExtractConnectionStringValue(const key, from: string): string;
function GetActiveDatabaseName: string;
function GetCompanyEmail: string;
Function getEmailFrom :String;
function GetCompanyName(const Reset: boolean = false): string;
function GetCompanyDetails(const Reset: boolean = false): string;
function GetCompanyType(const ClientID: integer): string;
//function GetCurrentThreadsConnected(const DatabaseName: string): integer;
function GetNewMyDacConnection(const Owner: TComponent): TERPConnection;Overload;
function GetNewMyDacConnection(const Owner: TComponent; Databasename:string; servername:String=''): TERPConnection;Overload;
function GetNewERPLanguageConnection(const Owner: TComponent): TERPConnection;
//function GetNewERPDocumentationConnection(const Owner: TComponent): TERPConnection;
function GetNewServicesConnection(const Owner: TComponent): TERPConnection;
(*function GetSequenceNumber(const SeqName: string; const showWarnings: boolean = false; CreateSeqIfNotFound: boolean = false): string;*)
function GetSequenceNumber(const SeqName: string ; DEfaultValue:Integer =1): string;
procedure SetSequenceNumber(const SeqName: string; Value:String);
function GetSharedMyDacConnection: TERPConnection;
function SetMyDacConnection(const MyConnection: TERPConnection): boolean;

function GetTableRecordCount(const TableName: string; FilterString :String = ''): integer;
function IsClientNameUnique(const Company: string; const ClientID: integer): boolean;
function SetGlobalIsolationLevel(const AConnection: TERPConnection): boolean;
function TableExists(const TableName: string; const MyConnection: TERPConnection=nil): boolean;
function FieldExists(const TableName, Fieldname : string): boolean;
procedure CheckDataSetOpen(ADataSet: TDataSet);
procedure CheckEditMode(ADataSet: TDataSet); overload;
procedure CheckEditMode(ADataSet: TDataSet; var WasEdited: boolean); overload;
procedure CheckInsertMode(ADataSet: TDataSet);
procedure PrefixSQLWithDatabaseName(const DatabaseName: string; var SQL: string);
function AppendToWhereClause(const WhereSQL, Condition: string): string; overload;
function AppendToWhereClause(const Condition: string): string; overload;
procedure UnlockTables;
function DatabaseVersionMatch: boolean;
function IsERPDatabase(aDbName: string): boolean;
function GetClassName(const iClassID: integer): string;
function GetClientEmailAddress(const ClientID: Integer): string;
{ Creates and returnes a TERPQuery connected to shared connection,
  caller MUST free query when finished with it }
function TempMyQuery(Connection:TERPConnection=nil; AOwner:TComponent= nil): TERPQuery;
function TempMyQueryIntrans: TERPQuery;
function TempMyScript(Connection:TERPConnection=nil): TERPScript;
Procedure DeleteallusingDs(fSQL:String;Connection:TERPConnection=nil);
Procedure ExecuteSQL(const fSQL:String; const fConnection :TCustomMyConnection = nil;FBeforeExecute:TBeforeStatementExecuteEvent=NIL ;FOnError:TOnErrorEvent= nil);
procedure EnsureMyQuery(const aQuery: TDataset);

{ User Temporary Table Setup functions and procedures }
function GetTemporaryTableNameSuffix: string;
function GetUserTemporaryTableName(const Name: string; const MainTransConnection: TERPConnection = nil): string;
function GetUserTemporaryFileName(const Name: string): string;
function GetTemporaryFileName(const Name: string; extension:String ='.tmp'): string;
function CreateUserTemporaryTable(const CreateSQL: TStringList): boolean; overload; {Parameter :Create table SQL statement }
function CreateUserTemporaryTable(const TemplateTableName: string;
  const TableNameSuffix: string = '';
  const EngineName:STring = '';
  aConnection: TERPConnection = nil;
  MainTRansConnection: TERPConnection = nil): string; overload;{Parameter :Name of the template table eg: tmp_Serialnumber}
//function SQLforUserTemporaryTable(const TemplateTableName: string;var Tablename:String; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
function CreateUserTemporaryTableSQL(var Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
function CreateTableSQL(Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;

function CreateTemporaryTableusingfile(const TemplateTableName: string;
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


procedure DeleteContentsFromUserTemporaryTable(const sTableName: string);
procedure DestroyUserTemporaryTable(const sTempTableName: string);
procedure EmptyUserTemporaryTable(const sTempTableName: string);

//procedure AddToPayAuthorisations(const Connection: TCustomMyConnection; const ActionType, Who: string; const ActionDate: TDateTime; const ActionSuccess: boolean);
procedure AddToPayAuthorisations(const Connection: TCustomMyConnection; const ActionType, Who: string; const ActionDate: TDateTime; const ActionSuccess: boolean);
procedure SetupPersonalPreferences(const Query: TERPQuery; const EmployeeID: Integer);
procedure CloneDataSet(const dsSrc, dsDst: TCustomMyDataSet);

procedure GetFieldNames(const TableName: string; List: TStrings); Overload;
Function GetFieldNames(const TableName: string):String ;Overload;

function RetrieveDataset(const sTableName, sMasterKeyName: string; const MasterID: integer): TDataset; overload;
function RetrieveDataset(const sTableName, sFilter: string): TDataset; overload;
function RetrieveDataset(const SQLstr: string): TDataset; overload;

procedure PaintGradientColor(const Form: TForm; const UseDefaultColor: Boolean = False);
procedure PaintColor(const Form: TForm; ColorMapRec: TColorMapRec);
function GetGradientColor(const ClassStr: string): TColorMapRec;
function GetColourForindex(Index:integer): TColor;
function UserUpdaterPath: String;


function ViewToTmpTable(const TableName: String): String;
Procedure AddCalcField(Const ds:TDataset;Const FName :String; Const ftype :TFieldType);
Function CreateField(Const ds:TDataset;Const FName :String; Const ftype :TFieldType):TField;
Procedure AddField(Const ds:TDataset; Const fOrigin,FName :String; Const ftype :TFieldType);
Procedure AddLookupField(Const ds:TDataset; Const FName :String; Const ftype :TFieldType; Const lkds :TDataset; Const lkKeyFields, lkResultField, KeyFields  :String);
procedure EditDB(const Ds: TDataset);
procedure PostDB(const Ds: TDataset);

function GetClientIDType(Const ClientID :Integer): String;

function GetMySQLBaseDir: string;
function GetMySQLDataDir: string;
function GetMySQLTempDir: string;

Function Recordempty(ds:TDataset; Fieldnames:String):Boolean;

function RecordForIdExists(const aTableName: string; aId: integer; Connection: TCustomMyConnection = nil): boolean;

function ProductListToBig: boolean;
//Procedure ReadTableStructrue(tablename :String; tableStructure:TStringlist);overload;
//function ReadTableStructrue(tablename :String):String ;overload;
//function SQLfortemptable(tablename:String; fields:String; indexfields:String; SQLPortion:String;  var Temptablename:String; var tmpfilename:String):String;
Procedure CloseDB(Ds:TDataset);
Procedure openDB(Ds:TDataset);
Function EnglishLanguageID:Integer;
Procedure LogEmailedReport(const TransactionID:Integer;const  UserID:Integer; const  EmailDate:TDateTime; const ReportType:String; const TransactionDescription :String; IsScheduledreport:boolean =False; Status:String = 'Success');
Procedure Copyrec(dsSource, dsTarget:TERPQuery; sourcetablename, targetTablename:String);
function TablefieldListProcess(const Tablename:String; fieldnames:String;fProc : TTablefieldListProcessProc):String;
Procedure TableListProcess(fProc : TTableListProcessProc);
function Isrecordempty(Qry:TERPQuery; fieldstoIgnore:string):Boolean;
function Isrecordnotempty(Qry:TERPQuery; fieldstoCheck:string):Boolean;
function SQLToMakeERPFIXTable(Const TableName:String):String;
Function FieldDisplayWidth(Qry :TDataset;Fieldname:String):Integer;
function dsToStr(TitleLine:Boolean; Qry :TDataset; Delimeter:String=','):String;
Function NextID(const aTablename, aIDFieldname:String):Integer;
Function MakeTableSQL(const aTablename, aIDFieldname, acopyTablename:String):String;

//Function HasPrimaryContact(const clientID: Integer): Boolean;
//Procedure SetNoPrimaryContact(const clientID: Integer);



implementation

uses {FastFuncs,}CommonLib, SysUtils, Dialogs, IniFiles, tcConst, tcClasses,
     DNMLib,  AppEnvironment, Registry, DataSourcePrefs,
  StoredProcedures,MachineSignature, TempTableUtils, MySQLConst, SystemLib,
  variants, DbSharedObjectsObj,LogLib, tcDataUtils, MySQLUtils, DbConst;

var
  CompanyInfo_Initialised: boolean = false;
  CompanyInfo: TCompanyInfoRec;
  fEnglishLanguageID: integer;

function GetActiveDatabaseName: string;
begin
  Result := GetSharedMyDacConnection.Database;
end;

function GetTableRecordCount(const TableName: string; FilterString :String = ''): integer;
var
  qry:TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  //with TERPQuery.Create(nil) do try
  try
    with qry do begin
      SQL.clear;
      SQL.Add('SELECT Count(*) FROM ' + TableName);
      if FilterString <> '' then SQL.Add('where ' +FilterString);
      Open;
      Result := Fields[0].AsInteger;
    end;
  finally
      DbSharedObj.ReleaseObj(Qry);
  end;
end;  

procedure PrefixSQLWithDatabaseName(const DatabaseName: string; var SQL: string);
begin
  if DatabaseName = '' then raise Exception.Create('No database name specified');
    
  SQL := StringReplace(SQL, 'tbl', DatabaseName + '.tbl',[rfReplaceAll]);
end;

function ExecuteDBStatement(const Statement: string; var ErrorMsg: string): boolean;
var
  MySQLHelper: TMySQLHelper;
begin
  ErrorMsg := '';
  Result := false;
  MySQLHelper := TMySQLHelper.Create;
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      try
        Connection := GetSharedMyDacConnection;
        SQL.Add(Statement);
        AfterExecute := MySQLHelper.OnAfterExecute;
        Execute;
        Result := MySQLHelper.ExecuteResult;
      except
        on E: Exception do ErrorMsg := E.Message;
      end;
    finally
      Free;
      FreeandNil(MySQLHelper);
    end;
end;
  
function CreateTableFromSQL(Const TableName: string; var SQL, ErrorMsg: string; IndexDefs: string = ''): boolean;
var
  SL: TStringList;
  x: integer;
  IdxSQL: string;
begin
  if Pos('CREATE TABLE', Uppercase(SQL)) = 0 then SQL := 'CREATE TABLE ' + TableName + ' ' + SQL;
  Result := ExecuteDBStatement(SQL, ErrorMsg);
  if result and (IndexDefs <> '') then begin
    SL:= TStringList.Create;
    try
      SL.CommaText:= IndexDefs;
      for x := 0 to SL.Count-1 do begin
        IdxSQL:= 'CREATE INDEX ' + TableName + '_Idx_' + IntToStr(x) +
          ' ON ' + TableName + ' (' + SL[x] + ');';
        if not ExecuteDBStatement(IdxSQL, ErrorMsg) then begin
          result:= false;
          break;
        end;
      end;
    finally
      SL.Free;
    end;
  end;
end;

function ExecuteDBCommand(const Command: string; var ErrorMsg: string): boolean;
var
  MySQLHelper: TMySQLHelper;
begin
  ErrorMsg := '';
  Result := false;
  MySQLHelper := TMySQLHelper.Create;
  with TERPCommand.Create(nil) do try
      try
        Connection := GetSharedMyDacConnection;
        SQL.Add(Command);
        AfterExecute := MySQLHelper.OnAfterExecute;
        Execute(1);
        Result := MySQLHelper.ExecuteResult;
      except
        on E: Exception do ErrorMsg := E.Message;
      end;
    finally
      Free;
      FreeandNil(MySQLHelper);
    end;
end;

function DropDatabase(const DatabaseName: string; var ErrorMsg: string): boolean;
var
  Command: string;
begin
  Command := 'DROP DATABASE IF EXISTS ' + DatabaseName;
  Result := ExecuteDBCommand(Command, ErrorMsg);
end;

function CreateDatabase(const DBCreateRec: TDBCreateRec; var ErrorMsg: string): boolean;
var
  Command: string;
begin
  Command := DBCreateRec.DBName;
  if DBCreateRec.CreateIfNotExists then Command := DB_KEY_IF_NOT_EXISTS + ' ' + Command;
  Result := ExecuteDBCommand(Format('CREATE DATABASE %s', [Command]), ErrorMsg);
end;

procedure CheckDataSetOpen(ADataSet: TDataSet);
begin
  if not ADataSet.Active then ADataSet.Open;
end;

procedure CheckInsertMode(ADataSet: TDataSet);
begin
  if ADataSet.State <> dsInsert then begin
    if ADataSet.State = dsEdit then ADataSet.Cancel;
    ADataSet.Insert;
  end;
end;

procedure CheckEditMode(ADataSet: TDataSet);
begin
  if ADataSet.State = dsBrowse then ADataSet.Edit;
end;

procedure CheckEditMode(ADataSet: TDataSet; var WasEdited: boolean); overload;
begin
  WasEdited := ADataSet.State = dsEdit;
  CheckEditMode(ADataSet);
end;

function ExtractConnectionStringValue(const key, from: string): string;
var 
  p: integer;
begin
  Result := '';
  p := Pos(uppercase(key) + '=', uppercase(from));
  if p > 0 then begin
    p := p + char_length(key) + 1;
    while (p <= char_length(from)) and (from[p] <> ';') do begin
      Result := Result + from[p];
      Inc(p);
    end;
  end;
end;

function SetGlobalIsolationLevel(const AConnection: TERPConnection): boolean;
begin
  with TERPCommand.Create(nil) do try
      Connection := AConnection;
      SQL.Text := 'SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;';
      try
        Execute;
        Result := true;
      except
        Result := false;      
      end;
    finally
      Free;
    end;
end;

function DBExists(const DBName: string): boolean;
var
  ls: TStringList;
begin
  ls := TStringList.Create;
  try
    CommonDbLib.GetSharedMyDacConnection.GetDatabaseNames(ls);
    Result := ls.IndexOf(DBName) > -1;
  finally
    FreeandNil(ls);
  end;
end;

function SetMyDacConnection(const MyConnection: TERPConnection): boolean;
begin
  Result := true;
  try
    MyConnection.LoginPrompt      := False;
    MyConnection.Server           := GetSharedMyDacConnection.Server;
    MyConnection.Database         := GetSharedMyDacConnection.Database;
    MyConnection.Username         := GetSharedMyDacConnection.Username;
    MyConnection.Password         := GetSharedMyDacConnection.Password;
    MyConnection.Options.Compress := GetSharedMyDacConnection.Options.Compress;
    MyConnection.Options.Protocol := GetSharedMyDacConnection.Options.Protocol;
    MyConnection.Port             := GetSharedMyDacConnection.Port;
  except
    Result := false;
  end;
end;

function GetSharedMyDacConnection: TERPConnection;
begin
  result := nil;
  if Assigned(AppEnv.AppDb) then
    result:= AppEnv.AppDb.Connection;
end;

{ Returns a new MyDac connection, must be freed by caller }
function GetNewServicesConnection(const Owner: TComponent): TERPConnection;
var
  qry : TERPQuery;
begin
(*
  With TempMyQuery do begin
    SQL.add('show databases like '+quotedstr(ErpservicesDBName));
    open;
    if recordcount = 0 then begin
      SQl.clear;
      SQL.add('CREATE DATABASE if not exists '+ErpservicesDBName +' /*!40100 DEFAULT CHARACTER SET utf8 */');
      Execute;
    end;
    close;
  end;
  Result := GetNewMyDacConnection(Owner);
  result.Connected:= False;
  result.Database := ErpservicesDBName;
  result.open;
*)
  qry := TempMyQuery;
  try
    With qry do
    begin
      SQL.add('show databases like '+quotedstr(ErpservicesDBName));
      open;
      if recordcount = 0 then begin
        SQl.clear;
        SQL.add('CREATE DATABASE if not exists '+ErpservicesDBName +' /*!40100 DEFAULT CHARACTER SET utf8 */');
        Execute;
      end;
      close;
    end;
  finally
    qry.Free;
  end;
  Result := GetNewMyDacConnection(Owner);
  result.Connected:= False;
  result.Database := ErpservicesDBName;
  result.open;
end;

function GetNewERPLanguageConnection(const Owner: TComponent): TERPConnection;
var
  sl: TStringList;
begin
  result := TERPConnection.Create(Owner);
  SetConnectionProps(result, MYSQL_DATABASE, AppEnv.AppDB.Server);
  result.Connect;
  sl := TStringList.Create;
  try
    sl.CaseSensitive := false;
    result.GetDatabaseNames(sl);
    if sl.IndexOf(ErpLanguageDBName) < 0 then
      result.ExecSQL('CREATE DATABASE ' + ErpLanguageDBName, []);
  finally
    sl.Free;
  end;
  result.Close;
  result.Database := ErpLanguageDBName;
  result.Connect;
end;

function GetNewMyDacConnection(const Owner: TComponent; Databasename:string; servername:String=''): TERPConnection;
begin
  Result := TERPConnection.Create(Owner);
  with GetSharedMyDACConnection do begin
    Result.LoginPrompt      := false;
    if servername <> '' then Result.Server:=servername else Result.Server := Server;
    Result.Database         := Databasename;
    Result.Port             := Port;
    Result.Username         := Username;
    Result.Password         := Password;
    Result.Options.Compress := Options.Compress;
    Result.Options.Protocol := Options.Protocol;
    Result.Port             := Port;
    Result.Open;
  end;
end;
function GetNewMyDacConnection(const Owner: TComponent): TERPConnection;
begin
  result := GetNewMyDacConnection(Owner, GetSharedMyDACConnection.Database);
end;
procedure UnlockTables;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    qryTemp.Sql.Add('UNLOCK TABLES;');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function BooleanToSQLStr(const Value: boolean): string;
begin
  if Value then Result := '''T'''
  else Result          := '''F''';
end;

function FieldExists(const TableName, Fieldname : string): boolean;
//var
//  qryTemp: TERPQuery;
begin
  result := TempTableUtils.FieldExists(GetSharedMyDacConnection, TableName, Fieldname);
//  if TableName= '' then begin
//      REsult := False;
//      Exit;
//  end;
//  qryTemp := TERPQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
//  try
//    qryTemp.Connection := GetSharedMyDacConnection;
//    qryTemp.Sql.Add('SELECT * FROM ' +
//                  ' INFORMATION_SCHEMA.COLUMNS  ' +
//                  ' WHERE TABLE_NAME = '+ Quotedstr(Tablename) +
//                  ' AND COLUMN_NAME = '+Quotedstr(FieldName) +
//                  ' AND table_schema = '+Quotedstr(qryTemp.Connection.Database));
//    qryTemp.Open;
//    Result := not qryTemp.IsEmpty;
//    qryTemp.Close;
//  finally
//    FreeAndNil(qryTemp);
//  end;
end;

function TableExists(const TableName: string; const MyConnection: TERPConnection=nil): boolean;
//var
//  qryTemp: TERPQuery;
begin
  if MyConnection = nil then
    result := TempTableUtils.TableExists(GetSharedMyDacConnection, TableName)
  else
    result := TempTableUtils.TableExists(MyConnection, TableName);
//  if TableName= '' then begin
//      REsult := False;
//      Exit;
//  end;
//  qryTemp := TERPQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
//  try
//    qryTemp.Connection := GetSharedMyDacConnection;
//    qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(TableName));
//    qryTemp.Open;
//    Result := not qryTemp.IsEmpty;
//    qryTemp.Close;
//  finally
//    FreeAndNil(qryTemp);
//  end;
end;

function GetCompanyInfo(const Reset: boolean = false): TCompanyInfoRec;
begin
  if (not CompanyInfo_Initialised) or Reset then begin
    with TERPQuery.Create(nil) do try
        Options.FlatBuffers := True;
        Connection := GetSharedMyDacConnection;
        SQL.Text := 'Select CompanyName, Email, ' + 'Address,Address2,City,State,Postcode, ' +
          'Country,PhoneNumber,FaxNumber,ABN ' + 'From tblCompanyInformation';
        Open;
        if not IsEmpty then begin
          CompanyInfo.Name := FieldByName('CompanyName').AsString;
          CompanyInfo.Email := FieldByName('Email').AsString;
          CompanyInfo.Address := FieldByName('Address').AsString;
          CompanyInfo.Address2 := FieldByName('Address2').AsString;
          CompanyInfo.City := FieldByName('City').AsString;
          CompanyInfo.State := FieldByName('State').AsString;
          CompanyInfo.Postcode := FieldByName('Postcode').AsString;
          CompanyInfo.Country := FieldByName('Country').AsString;
          CompanyInfo.PhoneNumber := FieldByName('PhoneNumber').AsString;
          CompanyInfo.FaxNumber := FieldByName('FaxNumber').AsString;
          CompanyInfo.ABN:= FieldByName('ABN').AsString;
        end;
      finally
        Free;
        CompanyInfo_Initialised := true;
      end;
  end;
  Result := CompanyInfo;
end;



function GetCompanyEmail: string;
begin
  Result := CompanyInfo.Email;
end;

Function getEmailFrom :String;
begin
  result := '';
  if assigned(AppEnv.Employee) and (AppEnv.Employee.UseEmpEmailAsFromAddress = true) AND (AppEnv.Employee.Email <> '') then begin
    Result := AppEnv.Employee.Email;
  end else begin
    if GetCompanyEmail <> '' then begin
      Result := GetCompanyEmail;
    end
  end;
end;

function GetCompanyName(const Reset: boolean = false): string;
var
  CI: TCompanyInfoRec;
begin
  CI := GetCompanyInfo(Reset);
  Result := CI.Name;
end;

function GetCompanyType(const ClientID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT ClientID,Customer,Supplier,OtherContact,IsJob FROM tblclients ');
    qryTemp.Sql.Add('WHERE ClientID='+ IntToStr(ClientID)+';');
    qryTemp.Open;
    If (qryTemp.RecordCount=0) then Begin
      Result := 'Unknown';
      Exit;
    end;

    If qryTemp.FieldByName('Customer').AsString='T' then Begin
      Result := 'Customer';
      If qryTemp.FieldByName('IsJob').AsString='T' then
        Result := 'Job';
    end else If qryTemp.FieldByName('Supplier').AsString='T' then Begin
       Result := 'Supplier';
    end else If qryTemp.FieldByName('OtherContact').AsString='T' then Begin
       Result := 'OtherContact';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetCompanyDetails(const Reset: boolean = false): string;
var
  CI: TCompanyInfoRec;
begin
  CI := GetCompanyInfo(Reset);
  Result := 'Address : ' + CRLF + CI.Address + CRLF + CI.Address2 + CRLF + CI.State + ' ' +
    CI.Postcode + CRLF + CI.Country + CRLF + 'Email : ' + CI.Email + CRLF + 'Phone : ' + CI.PhoneNumber +
    CRLF + 'FaxNumber : ' + CI.FaxNumber + CRLF + 'ABN ' + CI.ABN;
end;

{-------------------------------------------------------------------------------
  Function to return a global sequence number from the database as
  defined in the tblseqnumbers table.

  Please define and use constants for sequence number names and add to const
  section of this unit.
-------------------------------------------------------------------------------}
function GetSequenceNumber(const SeqName: string; DEfaultValue:Integer =1): string;
var
  qry: TMyQuery;

  (*Procedure CreateSp;
  var
    scr: TMyScript;
  begin
    scr:=  TempMyScript;
    With scr do try
              SQL.add('delimiter //');
              SQL.add('CREATE FUNCTION  `GetSequenceNumber`(sSeqName VARCHAR(50), iThreadid int)  '+
                        ' RETURNS int(11)');
              SQL.add('BEGIN');
              SQL.add('/*----------------------------------------------------------------------------------------------------------- ');
              SQL.add('AS THE STORED PROCEDURED ARE DELETED WHILE BACKUP-RESTORE, COMMONDBLIB.GETSEQUENCENUMBER RECREATES THIS STOREDPROCEDURE');
              SQL.add('ANY CHANGES TO THIS PROCEDURE SHOULD BE ADDED TO COMMONDBLIB.GETSEQUENCENUMBER FUNCTION');
              SQL.add('-----------------------------------------------------------------------------------------------------------*/ ');
              SQL.add('DECLARE aresult INT;');
              SQL.add('Set aresult=0;');
              SQL.add('WHILE aresult=0 do');
              SQL.add('  INSERT INTO tblSeqNumbers (SeqName , SeqValue , Threadid) '+
                        ' VALUES (sSeqName , 1 , iThreadid )  '+
                        ' ON DUPLICATE KEY UPDATE  '+
                        ' SeqValue = ifnull(SeqValue,0)+1, Threadid=iThreadid;');
              SQL.add('  SELECT ifnull(SeqValue,0) into aresult  '+
                        ' From tblSeqNumbers  '+
                        ' where SeqName =sSeqName   and Threadid = iThreadid;');
              SQL.add('end while;');
              SQL.add('  RETURN aresult;');
              SQL.add('END//');
              SQL.add('delimiter ;');
              Try
                Execute;
              Except
                Raise;
                Exit;
              end;
          finally
              Free;
          end;
  end;*)
begin
  qry:= TempMyQuery;
  With qry do try
    SQL.add('Select ifnull(GetSequenceNumber(' +QuotedStr(SeqName)+', ' + IntToStr(Integer(connection))+','+ inttostr(DefaultValue) +'),0)  as no');
    try
      open;
      Result := FieldByname('No').asString;
      exit;
    Except
      on E:Exception do begin
        CreateSP('GetSequenceNumber');
      end;
    end;
    if active then close;
    open;
    Result := FieldByname('No').asString;
  finally
    if active then close;
    Free;
  end;
end;
Procedure SetSequenceNumber(const SeqName: string; Value:String);
var
  qry: TMyQuery;
begin
  qry:= TempMyQuery;
  With qry do try
    SQL.add('Call SetSequenceNumber(' +QuotedStr(SeqName)+', ' + Value+')');
    try
      execute;
    Except
      on E:Exception do begin
        CreateSP('SetSequenceNumber');
      end;
    end;
  finally
    Free;
  end;

end;
(*function GetSequenceNumber(const SeqName: string; const showWarnings: boolean = false; CreateSeqIfNotFound: boolean = false): string;
var
  qry: TERPQuery;
  seqValue, PadTo: integer;
begin
  Result := ''; // not found
  
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'Select * from tblSeqNumbers where SeqName = ''' + SeqName + '''';
    qry.Open;
    if qry.IsEmpty and CreateSeqIfNotFound then begin
      qry.Close;
      qry.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblSeqNumbers SET' + ' SeqName = ' + QuotedStr(SeqName) + ',' +
        ' SeqValue = 0,' + ' SeqMin = 1,' + ' SeqMax = 0,' + ' SeqStep = 1,' + ' SeqRecycle = "F"';
      qry.Execute;
      qry.Close;
      qry.SQL.Text := 'Select * from tblSeqNumbers where SeqName = ''' + SeqName + '''';
      qry.Open;
    end;
    if not qry.IsEmpty then begin
      try
        // lock table to prevent other users updating seq num during this process
        qry.LockTable(ltWrite);

        // get the next seq number
        seqValue := qry.FieldByName('SeqValue').AsInteger + qry.FieldByName('SeqStep').AsInteger;
        PadTo := qry.FieldByName('PadToDigits').AsInteger;

        // check seq has not exceed max value
        if ((qry.FieldByName('SeqMax').AsInteger > 0) and // 0 = no max
          (seqValue <= qry.FieldByName('SeqMax').AsInteger)) or
          ((qry.FieldByName('SeqMax').AsInteger = 0) and // 0 = no max
          (seqValue < High(integer))) then begin
          // update table with new value
          qry.Edit;
          qry.FieldByName('SeqValue').AsInteger := seqValue;
          qry.Post;

          if PadTo > 0 then Result := LeftPadStr(IntToStr(seqValue), PadTo, '0')
          else Result := IntToStr(seqValue);
        end else begin
          // max value exceeded
          if qry.FieldByName('SeqRecycle').AsBoolean then begin
            // if recycle ... reset to min
            seqValue := qry.FieldByName('SeqMin').AsInteger;
            qry.Edit;
            qry.FieldByName('SeqValue').AsInteger := seqValue;
            qry.Post;
            if PadTo > 0 then Result := LeftPadStr(IntToStr(seqValue), PadTo, '0')
            else Result := IntToStr(seqValue);
          end else if showWarnings then CommonLib.MessageDlgXP_Vista('The maximum range for sequence number ' + SeqName + ' has been reached.',
              mtWarning, [mbOK], 0);
        end;
      finally;
        qry.UnLockTable;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;*)

  //procedure RemoveAllUserInUseEntries(sUsername: String);
  //var
  //  qry: TERPQuery;
  //begin
  //  qry := TERPQuery.Create(nil);
  //  try
  //    qry.Connection := GetSharedMyDacConnection;
  //    qry.ParamCheck := False;
  //    qry.SQL.Clear;
  //    qry.SQL.Add('DELETE FROM tblinuse WHERE (Username = ' + QuotedStr(sUsername) + ');');
  //    qry.Execute;
  //
  //  finally
  //    // Release our used objects.
  //    if Assigned(qry) then FreeAndNil(qry);
  //  end;
  //end;
  //
  //procedure RemoveUserInUseEntry(Const Owner: TComponent; sUsername: String; iKeyID: Integer);
  //var
  //  qry: TERPQuery;
  //begin
  //  qry := TERPQuery.Create(nil);
  //  try
  //    qry.Connection := GetSharedMyDacConnection;
  //    qry.ParamCheck := False;
  //    qry.SQL.Clear;
  //    qry.SQL.Add('DELETE FROM tblinuse');
  //    qry.SQL.Add('WHERE (Username = ' + QuotedStr(sUsername) + ' AND ');
  //    qry.SQL.Add('ClassName = ' + QuotedStr(Owner.ClassName) + ');');
  //    qry.Execute;
  //
  //  finally
  //    // Release our used objects.
  //    if Assigned(qry) then FreeAndNil(qry);
  //  end;
  //end;
  //
  ///////////////////////////////////////////////////////////////////////////////
  //// This function will add the current logged in user as the owner of
  //// the current control (Form) and with a set KeyID.  This procedure
  //// at a later will be expanded to ensure we can control individual datasets
  //// to further avoid lock issues.
  ///////////////////////////////////////////////////////////////////////////////
  //procedure AddUserInUseEntry(Const Owner: TComponent; sUsername: String; iKeyID: Integer);
  //var
  //  qry: TERPQuery;
  //  dTime: TDateTime;
  //  sDate: String;
  //  wYear, wMonth, wDay, wHour, wMin, wSec, wMilli: Word;
  //
  //
  //begin
  //  // If iKeyID is 0 or less then out we go!
  //  if iKeyID = 0 then exit;
  //
  //  // Create query control.
  //  qry := TERPQuery.Create(nil);
  //
  //  try
  //    // Setup query.
  //    qry.Connection := GetSharedMyDacConnection;
  //    qry.ParamCheck := False;
  //
  //    // First we need to ensure that this record doesnt already
  //    // exist for the request control (form).  Technically it should not
  //    // unless the user has already opened an instance of a form already.
  //    // But to ensure consistency we will check to ensure it does not!
  //    qry.SQL.Clear;
  //    qry.SQL.Add('SELECT ID FROM tblinuse');
  //    qry.SQL.Add('WHERE Username = ' + QuotedStr(sUsername) +
  //                ' AND ClassName = ' + QuotedStr(Owner.ClassName) +
  //                ' AND KeyID = ' + IntToStr(iKeyID));
  //
  //    // Open query.
  //    qry.Open;
  //
  //    // Does this record already exist? If so, just exit.
  //    if qry.RecordCount > 0 then exit;
  //
  //    // Create DateTime Stamp
  //    dTime := Now;
  //    DecodeDateTime(dTime, wYear, wMonth, wDay, wHour, wMin, wSec, wMilli);
  //    sDate := IntToStr(wYear)+'-'+IntToStr(wMonth)+'-'+IntToStr(wDay)+' '+
  //             IntToStr(wHour)+':'+IntToStr(wMin)+':'+IntToStr(wSec);
  //
  //    // Great it dont, so create new user entry.
  //    qry.SQL.Clear;
  //    qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblinuse (Username, ClassName, KeyID, TimeEntered) VALUES ');
  //    qry.SQL.Add('(' + QuotedStr(sUsername) + ', ' +
  //                      QuotedStr(Owner.ClassName) + ', ' +
  //                      IntToStr(iKeyID) + ', ' + QuotedStr(sDate) + ');');
  //    // Insert Record.
  //    qry.Execute;
  //
  //  finally
  //    // Release our used objects.
  //    if Assigned(qry) then FreeAndNil(qry);
  //  end;
  //end;
  //
  ///////////////////////////////////////////////////////////////////////////////
  //// This function will clear the entire tblinuse table.  This function
  //// is called when everyone is logged out.
  ///////////////////////////////////////////////////////////////////////////////
  //procedure ClearInUseTable;
  //var
  //  qry: TERPQuery;
  //begin
  //  qry := TERPQuery.Create(nil);
  //  try
  //    qry.Connection := GetSharedMyDacConnection;
  //    qry.ParamCheck := False;
  //    qry.SQL.Clear;
  //    qry.SQL.Add('DELETE FROM tblinuse;');
  //    qry.Execute;
  //  finally
  //    // Release our used objects.
  //    if Assigned(qry) then FreeAndNil(qry);
  //  end;
  //end;
  //
  ///////////////////////////////////////////////////////////////////////////////
  //// This function checks to see if the given control with the KeyID is
  //// currently in use by any user.  The return Results are defined
  //// within the returned TInUse record structure.
  ///////////////////////////////////////////////////////////////////////////////
  //function CheckForInUse(Const Owner: TComponent; iKeyID: Integer): TInUse;
  //var
  //  qry: TERPQuery;
  //  RC: TInUse;
  //begin
  //  qry := TERPQuery.Create(nil);
  //  ZeroMemory(@RC, sizeof(RC));
  //  try
  //    qry.Connection := GetSharedMyDacConnection;
  //    qry.ParamCheck := False;
  //    qry.SQL.Clear;
  //    qry.SQL.Add('SELECT ID, Username FROM tblinuse');
  //    qry.SQL.Add('WHERE ClassName = ' + QuotedStr(Owner.ClassName) +
  //                ' AND KeyID = ' + IntToStr(iKeyID));
  //
  //    // Open query.
  //    qry.Open;
  //
  //    if qry.RecordCount > 0 then begin
  //       RC.InUse := True;
  //       RC.Username := qry.FieldByName('Username').AsString;
  //    end;
  //
  //    Result := RC;
  //
  //  finally
  //    // Release our used objects.
  //    if Assigned(qry) then FreeAndNil(qry);
  //  end;
  //end;

function IsClientNameUnique(const Company: string; const ClientID: integer): boolean;
var
  Qry: TERPQuery;
begin
  Result := true;
  if Trim(Company) = '' then Exit;
  Qry := TERPQuery.Create(nil);
  Qry.Options.FlatBuffers := True;
  try
    with Qry do begin
      Connection := GetSharedMyDacConnection;
      SQL.Clear;
//      Sql.Add('Select ClientID From tblclients Where Company =  ' + QuotedStr(Trim(Company)));
      Sql.Add('Select ClientID From tblclients Where Company =  ' + QuotedStr(StringDataForSQL(Company)));
      if ClientID <> 0 then SQL.ADD(' and ClientID <> ' + IntToStr(ClientID));
      Open;
      if RecordCount > 0 then Result := false;
    end
  finally
    FreeAndNil(qry);
  end;
end;


//function GetCurrentThreadsConnected(const DatabaseName: string): integer;
//var
//  query: TERPQuery;
//begin
//  query := TERPQuery.Create(nil);
//  query.Options.FlatBuffers := True;
//  query.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    Query.SQL.Text := 'SHOW PROCESSLIST';
//    Query.Open;
//    Result := 0;
//    Query.First;
//    while not Query.Eof do begin
//      if Sysutils.SameText(Query.FieldByName('db').AsString, dataBaseName) and not Sysutils.SameText(Query.FieldByName('db').AsString,
//        'services') and not Sysutils.SameText(Query.FieldByName('Info').AsString, 'SHOW PROCESSLIST') then Inc(Result);
//      Query.Next;
//    end;
//    Query.Close;
//  finally
//    FreeandNil(Query);
//  end;
//end;
function IsERPDatabase(aDbName: string): boolean;
begin
  result := False;

  if not AppEnv.AppDb.DatabaseExists(aDbName) then exit;

  try
    with tempMyQuery do try
      SQL.Add('show tables from ' + aDbName +' like "tblupdatedetails"') ;
      open;
      if recordcount <> 1 then exit;
      result := True;
    finally
      ClosenFree;
    end;
  except
    // on exception return as the result is set to false;
  end;
end;

function DatabaseVersionMatch: boolean;
var
  Qry: TERPQuery;
  Version: string;
begin
  Result := false;
  Qry := TERPQuery.Create(nil);
  Qry.Options.FlatBuffers := True;
  try
    Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.Text   := 'SELECT Version FROM tblupdatedetails';
    Qry.Open;

    if Qry.RecordCount > 0 then begin
      Qry.First;
      Version := Qry.FieldByName('Version').AsString;

      Qry.SQL.Text := 'SELECT Version FROM ERPNewDB.tblupdatedetails';
      Qry.Open;

      if Qry.RecordCount > 0 then begin
        Qry.First;

        if Version = Qry.FieldByName('Version').AsString then Result := true;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetClassName(const iClassID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ClassName FROM tblClass WHERE ClassID = ' + IntToStr(iClassID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('ClassName').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetClientEmailAddress(const ClientID: Integer): string;
var 
  qryEmail: TERPQuery;
begin 
  qryEmail := TERPQuery.Create(nil);
  qryEmail.Connection := GetSharedMyDacConnection;

  try 
    qryEmail.Sql.Add('SELECT Email, ClientID FROM tblClients WHERE ClientID = ' + IntToStr(ClientID));
    qryEmail.Open;

    if not qryEmail.IsEmpty then
      Result := qryEmail.FieldByName('Email').AsString
    else
      Result := '';

    qryEmail.Close;
  finally
    FreeandNil(qryEmail);
  end;
end;

{ Creates and returnes a TERPQuery connected to shared connection,
  caller MUST free query when finished with it }
function TempMyScript(Connection:TERPConnection=nil): TERPScript;
begin
  Result := TERPScript.Create(nil);
  if assigned(Connection) then Result.Connection := Connection else Result.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

Procedure DeleteallusingDs(fSQL:String;Connection:TERPConnection=nil);
begin
  with TempMyQuery(Connection) do try
    SQL.Add(fsql);
    open;
    if recordcount>0 then begin
      First;
      While Eof = False do begin
        delete;
        first;
      end;
    end;
  finally
    closenFree;
  end;
end;

function TempMyQuery(Connection:TERPConnection=nil; AOwner:TComponent= nil): TERPQuery;
begin
  Result := TERPQuery.Create(AOwner);
  Result.Options.FlatBuffers := True;
  if assigned(Connection) then
    Result.Connection := Connection
  else
    Result.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

function TempMyQueryIntrans: TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  Result.Options.FlatBuffers := True;
  Result.Connection := CommonDbLib.GetNewMyDacConnection(result , GetSharedMyDACConnection.Database);
  TERPConnection(Result.Connection).StartTransaction;
end;

Procedure ExecuteSQL(const fSQL:String; const fConnection :TCustomMyConnection = nil;FBeforeExecute:TBeforeStatementExecuteEvent=NIL;FOnError:TOnErrorEvent= nil);
var
  scr: TERPScript;
begin
  if Assigned(fConnection) then
    scr := DbSharedObj.GetScript(fConnection)
  else
    scr := DbSharedObj.GetScript(GetSharedMyDacConnection);
  try
    scr.SQL.Text := fSQL;
    scr.BeforeExecute := FBeforeExecute;
    scr.OnError := FOnError;
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure EnsureMyQuery(const aQuery: TDataset);
begin
  if not Assigned(aQuery) or not (aQuery is TERPQuery) then
    raise Exception.Create(aQuery.GetNamePath + ' is not a TERPQuery');
end;

function GetTemporaryTableNameSuffix: string;
begin
  if Assigned(AppEnv.Employee) then
    Result := TempTableUtils.GetTemporaryTableNameSuffix(AppEnv.Employee.LogonName)
  else
    Result := TempTableUtils.GetTemporaryTableNameSuffix('');

//  if Assigned(AppEnv.Employee) then Result := '_' + RemoveInvalidAlphaNumericCharacters(Trim(AppEnv.Employee.LogonName))
//      + '_' + MachineSignature.GetMachineIdentification(true, true, true, true)
//  else Result := '_' + MachineSignature.GetMachineIdentification(true, true, true, true)
end;


function CreateUserTemporaryTableSQL(var Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
begin
  result:= TempTableUtils.CreateUserTemporaryTableSQL(TableName,TemplateTableName,TableNameSuffix,EngineName);
//  tablename := TemplateTableName+ Trim(TableNameSuffix) + GetTemporaryTableNameSuffix;
//  REsult := CreateTableSQL(Tablename ,TemplateTableName,TableNameSuffix,EngineName);
end;

function CreateTableSQL(Tablename :String;const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
begin
  result:= TempTableUtils.CreateTableSQL(Tablename, TemplateTableName, TableNameSuffix, EngineName);
//  Result := 'Drop table if exists  `'+Tablename+'`  ;' +
//            ' Create table  `'+Tablename+'`  like `' + TemplateTableName + '`;' ;
//  if Sysutils.SameText(Enginename , 'Innodb')  then
//    Result := result + ' Alter table  `'+Tablename+'`  ENGINE=InnoDB;'
//  else
//    Result := result + ' Alter table  `'+Tablename+'`  ENGINE=MyISAM;' ;
end;

function CreateUserTemporaryTable(const TemplateTableName: string;
  const TableNameSuffix: string = '';
  const EngineName:STring = '';
  aConnection: TERPConnection = nil;
  MainTransConnection: TERPConnection = nil): string;
//var
//  qryTemp: TERPQuery;
//  SQLStr: string;
//  x: integer;
begin
  if Assigned(aConnection) then
    result := TempTableUtils.CreateUserTemporaryTable(aConnection, TemplateTableName, TableNameSuffix, EngineName, MainTransConnection)
  else
    result := TempTableUtils.CreateUserTemporaryTable(GetSharedmydacConnection, TemplateTableName, TableNameSuffix, EngineName, MainTransConnection);

//  result:= TemplateTableName + Trim(TableNameSuffix) + GetTemporaryTableNameSuffix;
//  { Max MySQL table name length 64 characters }
//  if Length(result) > 64 then begin
//    x:= Pos('tmp_',Lowercase(result));
//    if x = 1 then begin
//      while Length(result) > 64 do
//        result:= 'tmp_' + Copy(result,6,Length(result));
//    end
//    else begin
//      while Length(result) > 64 do
//        result:= Copy(result,2,Length(result));
//    end;
//  end;
//
//  qryTemp := TERPQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    qryTemp.Sql.Clear;
//    qryTemp.Sql.Add('SHOW CREATE TABLE ' + TemplateTableName + ';');
//    qryTemp.Open;
//    if (qryTemp.RecordCount > 0) then begin
//      SQLStr := qryTemp.Fields[1].AsString;
//      if EngineName <> '' then
//          if Sysutils.SameText(Enginename , 'Innodb') then
//            SQLStr := StringReplace(SQLStr , 'ENGINE=MyISAM' , 'ENGINE=InnoDB',[rfIgnoreCase])
//          else SQLStr := StringReplace(SQLStr , 'ENGINE=InnoDB','ENGINE=MyISAM',[rfIgnoreCase]);
//      qryTemp.Close;
//      DestroyUserTemporaryTable(result);
//      SQLStr := ReplaceStr(uppercase(SQLStr),
//                           Trim(uppercase(TemplateTableName)),
//                           uppercase(result) );
//      qryTemp.Sql.Clear;
//      qryTemp.Sql.Add(SQLStr);
//      qryTemp.Execute;
//    end;
//  finally
//    FreeAndNil(qryTemp);
//  end;
end;

(*function SQLforUserTemporaryTable(const TemplateTableName: string;var Tablename:String; const TableNameSuffix: string = ''; const EngineName:STring = ''): string;
var
  qryTemp: TERPQuery;
  SQLStr: string;
begin

  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
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
      if Tablename = '' then Tablename := TemplateTableName + Trim(TableNameSuffix) + GetTemporaryTableNameSuffix ;
      Result := 'DROP TABLE IF EXISTS `' + Tablename + '`;'+
                ReplaceStr(uppercase(SQLStr),
                           Trim(uppercase(TemplateTableName)),
                           uppercase(Tablename));
    end;
  finally
    FreeAndNil(qryTemp);
  end;

end;*)

function CreateUserTemporaryTable(const CreateSQL: TStringList): boolean;
begin
  result := TempTableUtils.CreateUserTemporaryTable(GetSharedMydacConnection, CreateSQL);
//  Result := true;
//  if CreateSQL.text = '' then Exit;
//  with TempMyScript do try
//    SQL.add(CreateSQL.text);
//    Execute;
//  finally
//    Free;
//  end;
end;


function GetUserTemporaryTableName(const Name: string; const MainTransConnection: TERPConnection = nil): string;
begin
//  Result := 'tmp_' + Name +GetTemporaryTableNameSuffix +  '_' +FormatDateTime('yymmddhhnnsszzz',now);
  result := TempTableUtils.UniqueTableName(Name, MainTransConnection);
end;

procedure DestroyUserTemporaryTable(const sTempTableName: string);
begin
  TempTableUtils.DestroyUserTemporaryTable(GetSharedMydacConnection, sTempTableName);

//  if sTempTableName = '' then Exit;
//  with TempMyScript do try
//    if TableExists(sTempTableName) then
//      SQL.add('TRUNCATE `' + sTempTableName + '`;');
//    SQL.add('DROP TABLE IF EXISTS `' + sTempTableName + '`;');
//    Execute;
//  finally
//    Free;
//  end;
end;

procedure EmptyUserTemporaryTable(const sTempTableName: string);
begin
  TempTableUtils.EmptyUserTemporaryTable(GetSharedMydacConnection, sTempTableName);
end;

procedure DeleteContentsFromUserTemporaryTable(const sTableName: string);
begin
  if sTableName = '' then Exit;
  with TempMyScript do try
    SQL.add('TRUNCATE  `' + sTableName + '`;');
    Execute;
  finally
    Free;
  end;
end;

//procedure AddToPayAuthorisations(const Connection: TCustomMyConnection; const ActionType, Who: string; const ActionDate: TDateTime; const ActionSuccess: boolean);
//var
//  qry : TERPQuery;
//begin
//  qry := TERPQuery.Create(nil);
//  try
//    qry.Connection := Connection;
//    qry.SQL.Clear;
//    qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblpaysactionauthorisations (Type, Who, Date, ActionSuccess) VALUES ');
//    qry.SQL.Add('(');
//    qry.SQL.Add('"' + ActionType + '",');
//    qry.SQL.Add('"' + Who + '",');
//    qry.SQL.Add('"' + DNMLib.ConvertCurrentDateToMySQLDateTime(ActionDate) + '",');
//    if ActionSuccess then
//      qry.SQL.Add('"T"')
//    else
//      qry.SQL.Add('"F"');
//    qry.SQL.Add(')');
//    qry.Execute;
//  finally
//    // Free used objects.
//    if Assigned(qry) then FreeAndNil(qry);
//  end;
//end;

procedure AddToPayAuthorisations(const Connection: TCustomMyConnection; const ActionType, Who: string; const ActionDate: TDateTime; const ActionSuccess: boolean);
var
  qry : TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblpaysactionauthorisations (Type, Who, Date, ActionSuccess) VALUES ');
    qry.SQL.Add('(');
    qry.SQL.Add('"' + ActionType + '",');
    qry.SQL.Add('"' + Who + '",');
    qry.SQL.Add('"' + DNMLib.ConvertCurrentDateToMySQLDateTime(ActionDate) + '",');
    if ActionSuccess then
      qry.SQL.Add('"T"')
    else
      qry.SQL.Add('"F"');
    qry.SQL.Add(')');
    qry.Execute;
  finally
    // Free used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure SetupPersonalPreferences(const Query: TERPQuery; const EmployeeID: Integer);
begin
  if Assigned(Query) then begin
    Query.Close;
    Query.ParamByName('EmployeeID').AsInteger := EmployeeID;
    Query.Open;

    if Query.IsEmpty then begin
      Query.Append;
      Query.FieldByName('EmployeeID').AsInteger := EmployeeID;
    end;
  end;
end;

procedure CloneDataSet(const dsSrc, dsDst: TCustomMyDataSet);
begin
  if Assigned(dsSrc) and Assigned(dsDst) then begin
    dsDst.Connection := dsSrc.Connection;
    dsDst.ParamCheck := dsSrc.ParamCheck;
    dsDst.SQL.Text := dsSrc.SQL.Text;
    dsDst.Open;
  end;  
end;
Function GetFieldNames(const TableName: string):String ;
var
  List: TStringList;
begin
  List:= TStringList.create;
  try
    GetFieldNames(Tablename, List);
    REsult := List.Commatext;
  finally
    Freeandnil(List);
  end;

end;
procedure GetFieldNames(const TableName: string; List: TStrings);
var
  qry: TERPQuery;
  x: integer;
begin
  qry:= TempMyQuery;
  try
    List.Clear;
    qry.SQL.Text:= 'DESCRIBE `' + TableName +'`;';
    qry.Open;
    for x:= 0 to qry.Recordcount-1 do begin
      List.Add(LowerCase(qry.Fields[0].asString));
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function RetrieveDataset(const SQLstr: string): TDataset; overload;
begin
  Result := TempMyQuery;
  with TERPQuery(Result) do begin
    SQL.Clear;
    SQL.Text := SQLstr;
    Open;
  end;
end;

function RetrieveDataset(const sTableName, sFilter: string): TDataset; overload;
begin
  Result := TempMyQuery;
  with TERPQuery(Result) do begin
    Sql.Clear;
    Sql.Add(Format('SELECT * FROM %s WHERE %s;', [sTableName, sFilter]));
    Open;
  end;
end;

function RetrieveDataset(const sTableName, sMasterKeyName: string; const MasterID: integer): TDataset;
begin
  Result := TempMyQuery;
  with TERPQuery(Result) do begin
    Sql.Clear;
    if (MasterID<>-1) then begin
      Sql.Add(Format('SELECT * FROM %s WHERE %s = %d;', [sTableName, sMasterKeyName, MasterID]));
    end else begin
      Sql.Add(Format('SELECT * FROM %s;', [sTableName]));
    end;
    Open;
  end;
end;

procedure PaintGradientColor(const Form: TForm; const UseDefaultColor: Boolean = False);
var
  ColorMapRec: TColorMapRec;
begin
   if AppEnv = nil then
     exit;
   if UseDefaultColor then begin
     ColorMapRec.Color := Default_ColourERPSingle;//cDefaultGradientColor;
     ColorMapRec.AdjLuma := 0;//cAdjustLuma;
   end else
     ColorMapRec := GetGradientColor(Form.Classname);
   PaintColor(Form, ColorMapRec);
end;

procedure PaintColor(const Form: TForm; ColorMapRec: TColorMapRec);
var
  Y: Integer;
  dr,dg,db: Extended;
  C1,C2: TColor;
  R1,R2,G1,G2,B1,B2: Byte;
  R,G,B: Byte;
  cnt: Integer;
begin
   C1 := ColorAdjustLuma(ColorMapRec.Color, ColorMapRec.AdjLuma, False);
   R1 := GetRValue(C1);
   G1 := GetGValue(C1);
   B1 := GetBValue(C1);

   C2 := ColorMapRec.Color;
   R2 := GetRValue(C2);
   G2 := GetGValue(C2);
   B2 := GetBValue(C2);

   dr := (R2 - R1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
   dg := (G2 - G1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
   db := (B2 - B1) / Form.ClientRect.Bottom-Form.ClientRect.Top;

   cnt := 0;

      R := R1;
      G := G1;
      B := B1;

   for Y := Form.ClientRect.Top to Form.ClientRect.Bottom - 1 do
   begin
   if (Appenv <> nil) and (AppEnv.Employee.UseGradBackground) then begin
      R := R1+Ceil(dr*cnt);
      G := G1+Ceil(dg*cnt);
      B := B1+Ceil(db*cnt);
   end;

      Form.Canvas.Pen.Color := RGB(R, G, B);
      Form.Canvas.MoveTo(Form.ClientRect.Left, Y);
      Form.Canvas.LineTo(Form.ClientRect.Right, Y);
      Inc(cnt);
   end;
end;
function GetColourForindex(Index:integer): TColor;
begin
    Result := AppEnv.ColourPrefs.GetColourForindex(Index);
end;
function GetGradientColor(const ClassStr: string): TColorMapRec;
var
  ColorGroup: string;
  Index: Integer;
  FoundMatch: Boolean;
begin
  Result.Name := 'Default';
  Result.Color := cDefaultGradientColor;
  Result.AdjLuma := cAdjustLuma;
  ColorGroup := AppEnv.ColourPrefs.GetSkinsGroup(ClassStr);

  if ColorGroup <> '' then begin
      Result.Name := ColorGroup;
      if AppEnv.employee.UseERPSingleColor then Result.Color :=AppEnv.Employee.ERPSingleColor
      else Result.Color := AppEnv.ColourPrefs.GetColour(ColorGroup);
      Result.AdjLuma := AppEnv.ColourPrefs.GetGradIntensity(ColorGroup);
  end;

  if (ColorGroup <> '') And (Result.Name = 'Default') then begin
    Index := 1;
    FoundMatch := False;
    while (Index <= cMaxColorMap) and (not FoundMatch) do begin
      if Sysutils.SameText(cColorMapping[Index].Name, ColorGroup) then
        FoundMatch := True
      else
        Inc(Index);
    end;

    if FoundMatch then
      Result := cColorMapping[Index];
  end;

end;

function AppendToWhereClause(const WhereSQL, Condition: string): string; overload;
begin
  if Condition = '' then
    Result := WhereSQL
  else if WhereSQL = '' then
    Result := Condition
  else
    Result := WhereSQL + ' AND ' + Condition;
end;

function AppendToWhereClause(const Condition: string): string; overload;
begin
  if Condition <> '' then
    Result := ' AND ' + Condition;
end;


function UserUpdaterPath: String;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SOFTWARE\ERP Software\ERP\User Updater', False) then begin
      Result := Reg.ReadString('InstallPath');
      Result := Result + '\UsrUpdater.exe';
    end;
  finally
    Reg.Free;
  end;
end;

function ViewToTmpTable(const TableName: String): String;
begin
  Result := GetUserTemporaryTableName(TableName);
  with TERPQuery(TempMyQuery) do Try
    Sql.Clear;
    Sql.Add('Drop table if exists `'+Result+'`;');
    Execute;
    Sql.Clear;
    Sql.Add('CREATE TABLE '+Result+' (SELECT * FROM `'+TableName+'`);');
    Execute;
  finally
    Free;
  end;
end;
function GetClientIDType(Const ClientID :Integer): String;
var
  qry: TERPQuery;
begin
  qry := TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT tblclients.ClientID,tblclients.Customer,tblclients.Supplier,tblclients.OtherContact,tblclients.IsJob ');
    qry.SQL.Add('FROM tblclients WHERE ClientID = '+ IntToStr(ClientID)+';');
    qry.Open;
    If qry.RecordCount > 0 then Begin
      If qry.FieldByName('Customer').asBoolean then Begin
        If qry.FieldByName('IsJob').asBoolean then
          Result := 'CustomerJob'
        else
          Result := 'Customer';
      end else If qry.FieldByName('Supplier').asBoolean then
        Result := 'Supplier'
      else If qry.FieldByName('OtherContact').asBoolean then
        Result := 'OtherContact'
      else
        Result := 'Unknown';
    end else
      Result := 'Unknown';

  finally
    FreeAndNil(qry);
  end;
end;
Procedure AddLookupField(Const ds:TDataset; Const FName :String; Const ftype :TFieldType; Const lkds :TDataset; Const lkKeyFields, lkResultField, KeyFields  :String);
var
    Field :TField;
begin
    Field :=CreateField(ds,fname, ftype);
    if not(Assigned(Field)) then Exit;

    Field.FieldKind := fkLookup;
    Field.FieldName := FName;
    Field.Name := ds.Name + FName;
    Field.Index := ds.FieldCount;
    Field.DataSet := ds;
    Field.LookupDataSet := lkds;
    Field.LookupKeyFields := lkKeyFields;
    Field.LookupResultField  := lkResultField ;
    Field.KeyFields   := KeyFields  ;
    (*ds.FieldDefs.Update;*)
end;
Procedure AddField(Const ds:TDataset; Const fOrigin, FName :String; Const ftype :TFieldType);
var
    Field :TField;
begin
    Field :=CreateField(ds,fname, ftype);
    if not(Assigned(Field)) then Exit;
    Field.FieldKind := fkData;
    Field.FieldName := FName;
    Field.Name := ds.Name + FName;
    Field.Index := ds.FieldCount;
    Field.Origin := fOrigin +'.'+fname;
    Field.DataSet := ds;
end;
Procedure AddCalcField(Const ds:TDataset; Const FName :String; Const ftype :TFieldType);
var
    Field :TField;
begin
    Field :=CreateField(ds,fname, ftype);
    if not(Assigned(Field)) then Exit;
    Field.FieldKind := fkCalculated;
    Field.FieldName := FName; //edtColumnName.Text;
    Field.Name := ds.Name + FName;
    Field.Index := ds.FieldCount;
    Field.DataSet := ds;
    (*ds.FieldDefs.Update;*)
end;
Function CreateField(Const ds:TDataset; Const FName :String; Const ftype :TFieldType):Tfield;
begin
    result := nil;
    if ds.findfield(fname) <> nil then exit;
    if ftype = ftString then
        REsult := TWideStringField.Create(ds.Owner)
    else if ftype = DB.ftInteger then
        REsult := TIntegerField.Create(ds.Owner)
    else if ftype = DB.ftFloat then
        REsult := TFloatField.Create(ds.Owner)
    else if ftype = db.ftDateTime then
        REsult := TDateTimeField.Create(ds.Owner);
end;
procedure PostDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if ds.state in [dsEdit , dsInsert] then ds.Post;
end;

procedure EditDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if not(ds.state in [dsEdit , dsInsert]) then ds.Edit;
end;

Function Recordempty(ds:TDataset; Fieldnames:String):Boolean;
var
  st:TStringList;
  ctr:Integer;
begin
  Result := true;
  st:= TStringList.create;
  try
    st.CommaText := fieldnames;
    if st.count = 0 then exit;
    for ctr := 0 to st.count-1 do  begin
      if ds.Findfield(st[ctr])<>nil then
        if   (ds.Findfield(st[ctr]) is TIntegerField)      then begin
              if  (TIntegerField(ds.Findfield(st[ctr])).AsInteger <> 0)   then result := false
        end else if  (ds.Findfield(st[ctr]) is TFloatField)     then begin
          if  (TFloatField(ds.Findfield(st[ctr])).asFloat<> 0)        then result := false
        end else if  (ds.Findfield(st[ctr]) is TWideStringField)    then begin
          if  (TWideStringField(ds.Findfield(st[ctr])).asString <> '')    then result := false
        end else if  (ds.Findfield(st[ctr]) is TDateTimeField)  then begin
          if  (TDateTimeField(ds.Findfield(st[ctr])).AsDateTime<>0)   then result := false
        end else if  (ds.Findfield(st[ctr]) is TDateField)      then begin
          if  (TDateField(ds.Findfield(st[ctr])).AsDateTime<>0)       then result := false
        end else if   not TField(ds.Findfield(st[ctr])).isnull then
            Result := False;
        if not result then
            Exit;
      end;
  finally
      FreeandNil(st);
  end;
end;

function GetMySQLBaseDir: string;
begin
  with TempMyQuery do begin
    try
      SQL.Text:= 'select @@basedir';
      Open;
      result:= Fields[0].AsString;
    finally
      Free;
    end;
  end;
end;

function GetMySQLDataDir: string;
begin
  with TempMyQuery do begin
    try
      SQL.Text:= 'select @@datadir';
      Open;
      result:= Fields[0].AsString;
    finally
      Free;
    end;
  end;
end;

function GetMySQLTempDir: string;
begin
  with TempMyQuery do begin
    try
      SQL.Text:= 'select @@tmpdir';
      Open;
      result:= Fields[0].AsString+'\';
    finally
      Free;
    end;
  end;
end;
Procedure InsertInToTemporaryTableusingfile(aConnection: TERPConnection;const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var SQL1:String;
                                  var SQL2:String;
                                  tmpfilename :String);
begin
  TempTableUtils.InsertInToTemporaryTableusingfile(aConnection,
                                                   TemplateTableName, sSQL, Fieldlist, SQL1,SQL2, tmpfilename);

end;
function CreateTemporaryTableusingfile(const TemplateTableName: string;
                                  const sSQL:String;
                                  const Fieldlist:String;
                                  var tablename:String;
                                  var tmpfilename:String;
                                  const TableNameSuffix: string='' ; const EngineName:STring = ''): string;
//var
//  filename :String;
begin
  result := TempTableUtils.CreateTemporaryTableusingfile(GetSharedMyDacConnection,
    TemplateTableName, sSQL, Fieldlist, tablename, tmpfilename, TableNameSuffix, EngineName);

//  if tablename = '' then
//   Result := CreateUserTemporaryTableSQL(tablename , Trim(TemplateTableName) , TableNameSuffix , EngineName)+';';
//  filename := GetTemporaryFileName(tablename );
//  tmpfilename := filename;
//  filename := replaceStr(filename , '.tmp' ,   '_' +FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now) + '.tmp');
//  REsult := result + ssQL + ' INTO OUTFILE "'+ filename +'";' +
//                ' LOAD DATA INFILE "'+ filename +'" '+
//                'INTO TABLE ' + tablename +' CHARACTER SET  UTF8 '     +
//                '('+Fieldlist +');';
end;

function GetTemporaryFileName(const Name: string; extension:String ='.tmp'): string;
begin
  result := TempTableUtils.GetTemporaryFileName(GetSharedMyDacConnection, Name, extension);
//  REsult := StringReplace(GetMySQLTempDir,'\','/',[rfReplaceAll])+
//            Name + '.tmp';
end;


function GetUserTemporaryFileName(const Name: string): string;
begin
  result := TempTableUtils.GetUserTemporaryFileName(GetSharedMydacConnection, Name);
//  REsult := StringReplace(GetMySQLTempDir,'\','/',[rfReplaceAll])+
//            Name + '_' + GetTemporaryTableNameSuffix +'.tmp';
end;

function RecordForIdExists(const aTableName: string; aId: integer; Connection: TCustomMyConnection = nil): boolean;
var
  qry: TErpQuery;
  idField: string;
begin
  qry:= TempMyQuery;
  try
    if Assigned(Connection) then qry.Connection:= Connection;
    qry.SQL.Text:= 'show columns from ' + aTableName + ' where Extra = "auto_increment"';
    qry.Open;
    idField:= qry.FieldByName('Field').AsString;
    qry.Close;
    qry.SQL.Text:= 'select ' + idField + ' from ' + aTableName +
      ' where ' + idField + ' = ' + IntToStr(aId);
    qry.Open;
    result:= not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function ProductListToBig: boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= GetSharedMyDacConnection;
    qry.SQL.Text:= 'select count(partsid) as PartCount from tblparts';
    qry.Open;
    result:= qry.FieldByName('PartCount').AsInteger > 10000;
  finally
    qry.Free;
  end;
end;

//function SQLfortemptable(tablename:String; fields:String; indexfields:String; SQLPortion:String;  var Temptablename:String; var tmpfilename:String):String;
//var
//  fieldList:TStringlist;
//  tableStructure:TStringlist;
//  x1, x2: Integer;
//  Fielddef,fieldname:String;
//  PrimaryKey :String;
//  strSQL:String;
//  FieldNames:String;
//begin
//  result := '';
//  if tablename ='' then exit;
//  if fields = '' then exit;
//  PrimaryKey := GetMysqlTablePrimaryKey(TableName);
//  if fields =PrimaryKey then exit;
//
//  Temptablename := GetUserTemporaryTableName(Temptablename);
//  fieldList:=TStringlist.create;
//  tableStructure:=TStringlist.create;
//  try
//    fieldList.commatext := fields;
//    ReadTableStructrue(tablename , tableStructure);
//    REsult := '';
//    Result := Result +' Drop table if Exists '+Temptablename+';';
//    result := Result +' CREATE TABLE `'+Temptablename +'` (';
//    REsult := result + PrimaryKey +' int(11) NOT NULL AUTO_INCREMENT,';
//    FieldNames :=PrimaryKey;
//    for x1 := 0 to fieldList.count-1 do begin
//      fieldname := uppercase(fieldList[x1]);
//      if pos('.' , fieldname)>0 then begin
//        Result := result +copy(fieldname ,pos('.' , fieldname)+1 , length(fieldname))+' VARCHAR(255), ';
//        FieldNames := FieldNames +',' +copy(fieldname ,pos('.' , fieldname)+1 , length(fieldname));
//      end else begin
//        for x2:= 0 to   tableStructure.count-1 do begin
//          Fielddef:= uppercase(trim(tableStructure[x2]));
//          if (pos(fieldname+' ' , Fielddef)= 1)  or (pos('`' +fieldname+'` ' , Fielddef)= 1) then begin
//            Result := result +tableStructure[x2];
//            FieldNames := FieldNames +',' +fieldname;
//            break;
//          end;
//        end;
//      end;
//    end;
//
//    strSQL:='Select Distinct M.'+PrimaryKey ;
//    for x1 := 0 to Fieldlist.count-1 do
//      if Pos('.' , Fieldlist[x1])<> 0 then strSQL:= strSQL +',' +Fieldlist[x1] else strSQL:= strSQL +',M.' +Fieldlist[x1];
//    strSQL:= strSQL +' from ' +tablename +' M  ';
//    if SQLPortion <> '' then strSQL := strSQL+SQLPortion;
//
//    REsult := result + ' PRIMARY KEY ( ' +PrimaryKey +')';
//    if indexfields <> '' then begin
//      fieldList.commatext := indexfields;
//      for x1 := 0 to fieldList.count-1 do
//        REsult := result +',  KEY `'+fieldList[x1] +'` (`'+fieldList[x1] +'`)';
//    end;
//    REsult := Result +');';
//
//
//    Result := Result + CreateTemporaryTableusingfile('' ,
//                      strSQL ,
//                      (*PrimaryKey+','+*)FieldNames ,
//                      Temptablename , tmpfilename);
//  finally
//    Freeandnil(fieldList);
//    Freeandnil(tableStructure);
//  end;
//end;

Procedure CloseDB(Ds:TDataset); begin if ds.Active  then ds.Close;end;

Procedure openDB(Ds:TDataset);  begin if ds.Active = False then ds.Open;end;

//Function HasPrimaryContact(const clientID: Integer): Boolean;
//var
//  strSQL: string;
//begin
//  strSQL := 'Select ContactId from tblcontacts ' + ' where ClientId = ' +
//    IntToStr(clientID);
////    ') and (ContactIsCustomer ="T" or ContactIsJob ="T" or ContactIsOtherContact ="T")) '
////    + ' Or ((SupId = ' + IntToStr(clientID) + ') and (ContactIsSupplier ="T")))'
////    + ' and isprimarycontact = "T"';
//  with getDataSet(strSQL) do
//    try
//      Result := recordcount <> 0;
//    finally
//      if Active then
//        close;
//      Free;
//    end;
//end;
//
//Procedure SetNoPrimaryContact(const clientID: Integer);
//var
//  strSQL: string;
//begin
//  strSQL := 'update tblcontacts Set isprimarycontact ="F" ' +
//    ' where ClientId = ' + IntToStr(clientID) +
//    ' and isprimarycontact = "T"';
//  with TempMyScript do
//    try
//      SQL.add(strSQL);
//      Execute;
//    finally
//      Free;
//    end;
//end;

Function EnglishLanguageID: Integer;
var
  qry: TERPQuery;
begin
  if fEnglishLanguageID = 0 then begin
    qry := TempMyQuery;
    try
      qry.Connection := GetNewERPLanguageConnection(Qry);
      qry.SQL.Text := 'select ID from languages where Language =''English'' ';
      qry.Open;
      fEnglishLanguageID := qry.fieldByname('Id').asInteger;
    finally
      qry.Free;
    end;
  end;
  result := fEnglishLanguageID;
end;

Procedure LogEmailedReport(const TransactionID:Integer;const  UserID:Integer; const  EmailDate:TDateTime; const ReportType:String; const TransactionDescription :String; IsScheduledreport:boolean =False; Status:String = 'Success');
begin
        With TempMyscript do try
          Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription , IsScheduledreport , Status) ' +
                                   'Values (' +
                                   '' + inttostr(TransactionID) +',' +
                                   '' + inttostr(UserID) +',' +
                                   Quotedstr(FormatDateTime(MysqlDateFormat,EmailDate)) + ',' +
                                   QuotedStr(ReportType)  +',' +
                                   QuotedStr(TransactionDescription) +',' +
                                   QuotedStr(BooleanToStr(IsScheduledreport))+',' +
                                   Quotedstr(Status) +  ')');
          Execute;
        finally
          Free;
        end;

end;
Procedure Copyrec(dsSource, dsTarget:TERPQuery; sourcetablename, targetTablename:String);
var
  ctr:Integer;
begin
  if (dsSource=nil) or (dsSource.Active=False) or (dsSource.RecordCount=0) then exit;

  if not TableExists(targetTablename) then
    ExecuteSQL(TempTableUtils.CreateTableSQL(targetTablename, sourcetablename));
  if dsTarget = nil then begin
    dsTarget := TEmpMyQuery;
    dsTarget.sql.text := 'Select * from ' + targetTablename +' limit 0';
  end;
  opendb(dsTarget);
  dsTarget.Append;
  for ctr:= 0 to dsSource.FieldCount-1 do begin
      if dsTarget.findfield(dsSource.fields[ctr].FieldName)<> nil then begin
        EditDB(dsTarget);
        if  dsSource.fields[ctr].value = null then
        else
        dsTarget.Fieldbyname(dsSource.fields[ctr].FieldName).AsString := dsSource.fields[ctr].asString;
      end;
  end;
  postDB(dsTarget);

end;
Procedure TableListProcess(fProc : TTableListProcessProc);
begin
  if not(Assigned(fProc)) then exit;
  with TempMyquery do try
    SQL.Text := 'show tables';
    open;
    if recordcount =0 then exit;
    First;
    while EOF = False do begin
      if pos('TBL' , uppercase(fields[0].AsString))=1 then begin
        fProc(fields[0].AsString);
      end;
      Next;
    end;
  finally
      if Active then close;
      Free;
  end;

end;

function TablefieldListProcess(const Tablename:String; fieldnames:String;fProc : TTablefieldListProcessProc):String;
var
  st:TStringlist;
  ctr:Integer;
  Qry:TERPQuery;
begin
  result := '';
  st := TStringlist.Create;
  try
    st.CommaText := fieldnames;
    if st.count =0 then exit;
     //with SharedQryobj('desc '+Tablename) do try
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.Active then Qry.Close;
      Qry.SQL.Text := 'desc '+Tablename;
      Qry.Open;
      With Qry do begin
        if recordcount =0 then exit;
        First;
        While EOF = False do begin
          for ctr := 0 to st.Count-1 do begin
            if sametext(fields[0].asString , st[ctr]) then begin
              fProc(Tablename, fields[0].asString);
            end;
          end;
          Next;
        end;
      end;
     finally
        DbSharedObj.ReleaseObj(Qry);
     end;
  finally
    freeandnil(st);
  end;
end;
function Isrecordnotempty(Qry:TERPQuery; fieldstoCheck:string):Boolean;
var
  st:TStringlist;
  ctr:Integer;
begin
  Result := False;
  if Qry.Active =False then exit;

  st:= TStringlist.Create;
  try
    st.CommaText :=  fieldstoCheck;
    st.CaseSensitive := false;
    for ctr:= 0 to qry.FieldCount-1 do begin
      if st.IndexOf(qry.Fields[ctr].FieldName)<0 then continue;
      if qry.Fields[ctr].asString <> qry.Fields[ctr].DefaultExpression then begin result :=true;break;end;
    end;
  finally
    FreeandNil(st);
  end;
end;

function Isrecordempty(Qry:TERPQuery; fieldstoIgnore:string):Boolean;
var
  st:TStringlist;
  ctr:Integer;
begin
  Result := False;
  if Qry.Active =False then exit;

  st:= TStringlist.Create;
  try
    st.CommaText :=  fieldstoIgnore;
    st.CaseSensitive := false;
    for ctr:= 0 to qry.FieldCount-1 do begin
      if st.IndexOf(qry.Fields[ctr].FieldName)>=0 then continue;
      if qry.Fields[ctr].asString <> qry.Fields[ctr].DefaultExpression then exit;
    end;
    result := True;
  finally
    FreeandNil(st);
  end;
end;

function SQLToMakeERPFIXTable(Const TableName:String):String;
begin
  result := replacestr(Appenv.AppDb.TableVersion , '.' , '');
  result := 'Create table if not exists `erpfix_' + tablename +'_'+ result+'` like '+ tablename +';' +
            'insert ignore into `erpfix_' + tablename +'_'+ result+'` select * from  '+ tablename +';'
end;
Function FieldDisplayWidth(Qry :TDataset ;Fieldname:String):Integer;
begin
  REsult := 20;
  if Qry.findfield(FieldName)<> nil then
    REsult :=Qry.findfield(FieldName).displaywidth;

end;
function dsToStr(TitleLine:Boolean; Qry :TDataset; Delimeter:String=','):String;
var
  i:Integer;
begin
  result :='';
  for i := 0 to qry.FieldCount - 1 do   begin
    if qry.Fields[i].visible then begin
      case qry.Fields[i].DataType of
                        DB.ftUnknown, DB.ftBCD,  DB.ftBytes, DB.ftVarBytes, DB.ftBlob,
                        DB.ftGraphic, DB.ftParadoxOle, DB.ftDBaseOle, DB.ftTypedBinary, DB.ftCursor,
                        DB.ftADT, DB.ftArray, DB.ftReference, DB.ftDataSet, DB.ftOraBlob, DB.ftOraClob,
                        DB.ftVariant, DB.ftInterface, DB.ftIDispatch, DB.ftGuid, DB.ftTimeStamp,
                        DB.ftFMTBcd, DB.ftOraTimeStamp, DB.ftOraInterval, DB.ftByte,DB.ftConnection,
                        DB.ftParams, DB.ftStream, DB.ftTimeStampOffset, DB.ftObject:;
      else
        if result <> '' then result := result + Delimeter;
        if TitleLine then begin
                  if trim(qry.Fields[i].Displaylabel) <> '' then Result := Result + trim(qry.Fields[i].Displaylabel)
                  else Result := Result + trim(qry.Fields[i].Fieldname);
        end else
          if VarIsNull(qry.Fields[i].value) then else
            case qry.Fields[i].DataType of
                DB.ftString, DB.ftMemo, DB.ftFmtMemo, DB.ftFixedChar, DB.ftWideString, DB.ftFixedWideChar, DB.ftWideMemo :
                      Result := Result + Quotedstr( qry.Fields[i].asString);
                DB.ftSmallint, DB.ftInteger, DB.ftWord, DB.ftAutoInc, DB.ftLargeint, DB.ftLongWord, DB.ftShortint:
                      Result := Result + Inttostr( qry.Fields[i].asInteger);
                DB.ftFloat, DB.ftCurrency, DB.ftExtended, DB.ftSingle:
                      Result := Result + Floattostr( qry.Fields[i].asfloat);
                DB.ftDate, DB.ftTime, DB.ftDateTime:
                      Result := Result + Quotedstr(formatDateTime(MySQLDatetimeformat ,qry.Fields[i].asDateTime));
                DB.ftBoolean:
                      Result := Result + BooleanToStr( qry.Fields[i].asBoolean);
                else  Result := Result + Quotedstr( qry.Fields[i].asString);
            end;
      end
    end;
  end;
end;
Function MakeTableSQL(const aTablename, aIDFieldname, acopyTablename:String):String;
var
  fiNextID :Integer;
begin
  fiNextID := NextID(atablename, aIDFieldname);
  REsult := 'Drop table if exists ' + acopyTablename +';'+
            ' Create table '+ acopyTablename +' like ' + aTablename+';' +
            ' ALTER TABLE  '+ acopyTablename +'  AUTO_INCREMENT = '+ inttostr( fiNextID+1)+';';

end;
Function NextID(const aTablename, aIDFieldname:String):Integer;
var
  qry:TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if qry.active then qry.close;
    //qry.SQL.text := 'Select max('+aIDFieldname+') as '+ aIDFieldname + ' from ' + aTablename;
    qry.SQL.text := ' SELECT AUTO_INCREMENT as CTR '+
                    ' FROM information_schema.TABLES  '+
                    ' WHERE TABLE_SCHEMA = '+quotedstr(GetActiveDatabaseName)+
                    ' AND TABLE_NAME = '+quotedstr(aTablename);
    qry.open;
    REsult :=qry.fieldbyname('CTR').asInteger;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
initialization
  fEnglishLanguageID := 0;


end.





