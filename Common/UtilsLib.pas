unit UtilsLib;
{$I ERP.inc}
interface

uses ERPdbComponents, myaccess;
 // function versionToint(Const Versionno :String):Integer;
Procedure DoProcessScriptExecteError(const Value:String);
function IsGUI: boolean;
function TableHasFCRate(const Tablename :String; const FCRateFieldname:String):boolean;
function TempMyQuery(Connection:TERPConnection=nil): TERPQuery;
function GetQuery(Connection: TERPConnection = nil): TERPQuery;
procedure ReleaseDbObj(aDbObj: TObject);
Function iif(const cond :boolean ; trueValue, falseValue:Variant):Variant;
function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
function GetCurrentFiscalYearStart(const CurrentDate: TDateTime): TDateTime;
Procedure ExecuteSQL(SQL:String);
function HasVS1data(fConnection : TCustomMyconnection) :Boolean;

implementation

uses classes, sysutils, Math , AppEnvironmentVirtual , Vista_MessageDlg,
  dialogs , Forms, DbSharedObjectsObj, dateutils, DateTimeUtils, utVS1Const(*{$IFDEF DevMode},loglib{$ENDIF}*);

Procedure ExecuteSQL(SQL:String);
var
  cmd :TERPCommand;
begin
  cmd := DbSharedObj.Getcommand(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
  try
    cmd.SQL.TExt := SQL;
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

//function VersionComp(Const Version1, Version2 :String):Integer;
//var
//  iVersion1, iVersion2:Integer;
//begin
//  result:= 0;
//  {Return value  Condition
//    -1         Version1 sorts before Version2.
//    0          Version1 Same as Version2.
//    1          Version1 sorts After Version2.}
//
//  iVersion1:=versionToint(Version1);
//  iVersion2:=versionToint(Version2);
//
//  if iVersion1 < iVersion2 then result := -1
//  else if iVersion1 = iVersion2 then result := 0
//  else if iVersion1 > iVersion2 then result := 1;
//end;

//function versionToint(Const Versionno :String):Integer;
//var
//  st:TStringlist;
//  ctr:Integer;
//  multiplier:Integer;
//begin
//  st:=TStringlist.create;
//  try
//    st.Delimiter := '.';
//    st.DelimitedText := Versionno;
//    Result :=0;
//    Multiplier := 1;
//    for ctr := st.count-1 downto 0 do begin
//      result := result + strtoint(st[ctr])*(10*multiplier );
//      multiplier:= multiplier *10;
//    end;
//  finally
//    FreeandNil(st);
//  end;
//end;
Function iif(const cond :boolean ; trueValue, falseValue:Variant):Variant;
begin
  if cond then result := TrueValue else result := FalseValue;
end;

Procedure DoProcessScriptExecteError(const Value:String);
var
  s:String;
  sErr:String;
function ExchangeCode:String;
begin
  result:= sErr;
  result:= copy(result, pos('Unknown column ''', result) + length('Unknown column ''') , length(result));
  result:= copy(result , 1,pos('_FCRate'' in ''field list''', result )-1);
end;
begin
    //AppEnvVirt.LogTextLoge(Value);
      sErr:= Value;
      if (pos('Duplicate column', sErr )   <> 0) then // ignore it as its for the Foreign currency rate
      else if (pos('Unknown column ', sErr )   <> 0) and (pos('_FCRate'' in ''field list''', sErr )   <> 0) then begin
          s:=trim(ExchangeCode);
          if s<> '' then s :='You have reactivated an inactive Exchange Rate : '+ Quotedstr(s) +'.'
          else s :='You have reactivated an inactive ''Exchange Rate''.';
          s:= s + chr(13)+chr(10) +chr(13)+chr(10) +'Please Run the ''Closing Date Refresh'' before running the report';
          Vista_MessageDlg.MessageDlgXP_Vista(s , mtInformation , [mbok], 0);
      end else begin
        if AppEnvVirt.Bool['CommonLib.DevMode'] and IsGUI then begin
          if Pos( 'Unknown column ''GlobalRef'' in ''where clause''', sErr)=0 then
            if Pos( 'Unknown column ''msUpdateSiteCode'' in ''where clause''', sErr)=0 then
              Vista_MessageDlg.MessageDlgXP_Vista('TTransactionTableObj.MyScriptError:' +sErr (*+chr(13)+ SQL*) , mtInformation , [mbok], 0);

        end;
      end;
end;

function IsGUI: boolean;
begin
  result := Assigned(Application.MainForm);
end;

function TableHasFCRate(const Tablename :String; const FCRateFieldname:String):boolean;
begin
  With TempMyQuery do try
    SQL.add('Desc ' + Tablename);
    open;
    result := Locate(fields[0].fieldname , FCRateFieldname , []);
  finally
    closenfree;
  end;
end;

function TempMyQuery(Connection: TERPConnection): TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  if assigned(Connection) then Result.Connection := Connection else Result.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;

function GetQuery(Connection: TERPConnection = nil): TERPQuery;
begin
  if Assigned(Connection) then
    result := DbSharedObj.GetQuery(Connection)
  else
    result := DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
end;

procedure ReleaseDbObj(aDbObj: TObject);
begin
  DbSharedObj.ReleaseObj(aDbObj);
end;
function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
var
  iMonth: integer;
  iQuater: integer;
  iStartMonth: integer;
begin
  iMonth := MonthOfTheYear(dtDate);
  iQuater := (iMonth - 1) div 3 + 1;
  iStartMonth := (iQuater - 1) * 3 + 1;
  Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
end;
function GetCurrentFiscalYearStart(const CurrentDate: TDateTime): TDateTime;
begin
  result := DateTimeUtils.FiscalYearStart(CurrentDate, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']);
end;

function HasVS1data(fConnection : TCustomMyconnection) :Boolean;
var
  qry:TERPQuery;
  fiEmployeeId:Integer;
begin
  Result := False;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection:= fConnection;

    if qry.Active then qry.Close;
    qry.SQl.Text := 'SELECT * FROM tblemployees WHERE FirstName=' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName) + ' AND LastName=' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERLastName);
    qry.Open;
    (*{$IFDEF DevMode}LogQuerySQL(qry);{$ENDIF}*)
    if (qry.RecordCount = 0) then Exit;

    fiEmployeeId :=qry.fieldbyname('EmployeeID').asInteger;
    (*{$IFDEF DevMode}logtext('EmployeeID ' + inttostr(fiEmployeeId));{$ENDIF}*)

    {full access to cloud and Access levels in ERP}
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblpassword where EmployeeId = '+ inttostr(fiEmployeeId));
    qry.Open;
    (*{$IFDEF DevMode}LogQuerySQL(qry);{$ENDIF}*)
    if (qry.RecordCount = 0)  then Exit;

    REsult := (qry.FieldByname('Logon_name').AsString = ERP_VS1CLOUD_DEFAULT_USER);
    (*{$IFDEF DevMode}logtext('Logon_name ' + qry.FieldByname('Logon_name').asString);{$ENDIF}*)
    (*{$IFDEF DevMode}logtext('VS1 Logon_name ' + ERP_VS1CLOUD_DEFAULT_USER);{$ENDIF}*)
  finally
    Freeandnil(qry);
  end;

end;

end.

