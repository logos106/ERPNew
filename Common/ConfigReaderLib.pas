unit ConfigReaderLib;

interface

const
  EbayConfigName = 'ERPModEbay_Config';

function EbayConfigSQL:string;
function HasEbayforDB(aDBName:String): Boolean;
function StatusUpdatedUntilForDB(aDBName:String): TDateTime;

implementation

uses   ConfigDbObj, CommonDbLib, AppEnvironment,
  MySQLConst, ERPdbComponents, tcConst, DbSharedObjectsObj, sysutils, JSONObject,
  SystemLib, eBayConfig;

function HasEbayforDB(aDBName:String): Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'Select * from ('+EbayConfigSQL+') as  EbayConfig ';
    Qry.sql.add(' where Databasename = ' + quotedstr(aDBName)+' and active ="T"');
    Qry.open;
    result := Qry.recordcount >0;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
function StatusUpdatedUntilForDB(aDBName:String): TDateTime;
var
  qry: TERPQuery;
  s:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'Select * from ('+EbayConfigSQL+') as  EbayConfig ';
    Qry.sql.add(' where Databasename = ' + quotedstr(aDBName)+' and active ="T"');
    Qry.open;
    try
      result := Qry.fieldbyname('StatusUpdatedUntil').asDateTime;
    Except
      on E:Exception do begin
        //if e.message = '''''1899-12-30 00:00:00'''' is not a valid date and time' then
        REsult := 1;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function EbayConfigSQL:string;
var
  ConfigDb: TConfigDb;
  Configobj :TJsonObject;
  x:Integer;
  Account: TJsonObject;
begin
 ConfigDb:= TConfigDb.Create(EbayConfigName ,AppEnv.appdb.server) ;
 Configobj := nil;
 try
    result:= '';
    Configobj := JO;
    Configobj.AsString :=ConfigDb.Value;
    for x := 0 to Configobj.A['Accounts'].Count -1 do begin
      Account:= Configobj.A['Accounts'].Items[x].AsObject;
      if result <> '' then result := result +' union ';
      result:= result+'Select ' +
            'Convert(' +Quotedstr(FormatdateTime(MysqlDateTimeFormat, Account.DT['NextSyncTime']))+', DateTime) as NextSyncTime,'+NL+
            Quotedstr(Account.S['Name'])+' as Name,'+NL+
            Quotedstr(Account.S['UserTocken'])+' as UserTocken,'+NL+
            Quotedstr(Account.S['AppId'])+' as AppId,'+NL+
            Quotedstr(Account.S['DevId'])+' as DevId,'+NL+
            Quotedstr(Account.S['CertId'])+' as CertId,'+NL+
            Quotedstr(ebayReqVersion)+' as ReqVersion,'+NL+
            Quotedstr(Account.S['Database'])+' as Databasename,'+NL+
            Quotedstr(Account.S['EbayCustomer'])+' as EbayCustomer,'+NL+
            Quotedstr(BooleanToStr(Account.B['SingleCustomer']))+' as SingleCustomer,'+NL+
            Quotedstr(FormatdateTime(MysqlDateTimeFormat, Account.DT['SyncDatefrom']))+' as SyncDatefrom,'+NL+
            Quotedstr(FormatdateTime(MysqlDateTimeFormat, Account.DT['StatusUpdatedUntil']))+' as StatusUpdatedUntil,'+NL+
            Quotedstr(BooleantoStr(Account.B['Active']))+' as Active,'+NL+
            inttostr(Account.I['LogginLevel'])+' as LogginLevel,'+NL+
            inttostr(Account.I['LoggingLevel'])+' as LoggingLevel'+NL;
    end;
 finally
  if result ='' then
    result := 'Select ' +
            'Convert('+Quotedstr(FormatdateTime(MysqlDateTimeFormat, 0))+', dateTime) as NextSyncTime,'+NL+
            Quotedstr('')+' as Name,'+NL+
            Quotedstr('')+' as UserTocken,'+NL+
            Quotedstr('')+' as AppId,'+NL+
            Quotedstr('')+' as DevId,'+NL+
            Quotedstr('')+' as CertId,'+NL+
            Quotedstr(ebayReqVersion)+' as ReqVersion,'+NL+
            Quotedstr('')+' as Databasename,'+NL+
            Quotedstr('')+' as EbayCustomer,'+NL+
            Quotedstr('F')+' as SingleCustomer,'+NL+
            Quotedstr(FormatdateTime(MysqlDateTimeFormat, 0))+' as SyncDatefrom,'+NL+
            Quotedstr('F')+' as Active,'+NL+
            inttostr(0)+' as LogginLevel,'+NL+
            inttostr(0)+' as LoggingLevel';
  FreeandNil(ConfigDb);
  Configobj.Free;
 end;
end;

end.
