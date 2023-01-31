unit StatementsLib;

interface

Type
  TStatementParams = Record
    fsRTTablename:String;   //fsRTTablename;
    fsRTDetailTablename:String;   //fsRTTablename;
    fsTablename:String; //fsTablename;
    fsTempTblName:String;//fsTempTblName;
    BalOnDaterange:Boolean; //chkBalOnDaterange.chekced;
    CurDate:TDateTime;      //dtCurDate.Date;
    includeSalesOrder:Boolean ;//chkincludeSalesOrder.checked;
    includeinvoiceBO:Boolean ; //chkincludeinvoiceBO.checked;
    includeSOBO:Boolean ; //chkincludeSOBO.checked;
    basedonoptionsIndex :Integer ; //grpbasedonoptions.ItemIndex;
    ReportDateFrom :TDateTime; //dtfrom.DateTime;
    ReportDateTo :TDateTime; //dtTo.DateTime;
    ClientID: integer;//ClientID: integer;
    GroupJobs:Boolean;//chkGroupJobs.Checked;
    RelatedCustomer:Boolean;//chkRelatedCustomer.Checked;
    showPaid: Boolean;//chkshowPaid.checked;
    AllClass: Boolean;//chkAllClass.checked;
    SelectedClass:String;//cboClass.Text;
    ClassID:Integer ;// cboClassQry.FieldByName('ClassID').asInetegr;
    OrderOptionsIndex:Integer;//grpOrderOptions.itemindex;
    ReportClassname:String;//Self.classname;

  End;
function SalesBalance(salesTableAlias:String ='S'):String;
Function DaysTostatementDate:String;
function DueDays:String;
Function SalesType :String;
Function SalestypeBO:String;
function Datetofilter :String ;
Function sFrom :String;
Function sTo:String;
function GetALLJobClientIDs(const ParentClientID: integer): String;
function Clients(TableAlias:String):String;
function CreateALLRelatedCustWhereString(const ParentRelatedClientID: integer;const TableAlias: String): String;
function CreateALLJobWhereString(const ParentClientID: integer; const TableAlias: String): String;
Function IsAllClassSelected:boolean;
function GetALLRelatedCustClientIDs(const ParentRelatedClientID: integer): String;
function getClassFilter(const fsFieldName: String): String;
Function BOType :String;
function Prepayamount(PrepayTablealias :String ='P';ResutlTupe:String ='Balance' ):String;
function TotalAmt(const aFrom, aTo : string; iscurrent, isclosingBalance: Boolean) : Double;
function ReadBalance(const aFrom, aTo : string; FromDays:Integer;todays:Integer=0; isclosingBalance:Boolean = False; isbo:Boolean = False):String;
procedure runSQL(const strSQL: String; var VarAmt: Double;fsFieldname: String; runLoop: Boolean);
function GetOverDueMsg(const sTable: String): String;
Function clientbillToAddress(TableAlias:STring):String;
function TotalForeignAmt(const sFrom, sTo : string; iscurrent,isclosingBalance: Boolean): Double;
function ReadForeignBalance(const sFrom, sTo : string; FromDays:Integer;todays:Integer=0; isclosingBalance:Boolean = False; isbo:Boolean =False):String;
Function Transactions :String;
Function TransactionsWithBO :String;



Var
  sparams: TStatementParams;

const
  DAYS_OK = 0;
  DAYS_1  = 1;
  DAYS_7  = 2;
  DAYS_14 = 3;
  DAYS_21 = 4;
  DAYS_30 = 5;
  DAYS_60 = 6;
  DAYS_90 = 7;


implementation

uses DateUtils, sysutils, DbSharedObjectsObj, ERPDbComponents, CommonDbLib,
  CommonLib,classes, tcConst, LogLib, BusObjClass, AppEnvironment, MySQLConst,
  tcDataUtils, TemplateReportsLib;

function SalesBalance(salesTableAlias:String ='S'):String;
begin
  if SParams.BalOnDaterange then
    Result := '(' + salesTableAlias +'.TotalAmountInc - ifnull( (select Sum(DL.Payment) '+
                  ' from tbldepositline DL inner join tbldeposits D on DL.PaymentID = D.PaymentID  '+
                  ' and D.Deleted="F" where d.Paymentdate <= ' +QuotedStr(FormatDateTime(MysqlDateFormat, SParams.CurDate))+' and (DL.TrnType = "Invoice" or DL.TrnType = "Refund" ) '+
                  ' and  DL.SaleID = ' + salesTableAlias +'.saleID),0))'
  else Result :='' + salesTableAlias +'.balance';
end;
Function DaysTostatementDate:String;
begin
  Result := 'TO_DAYS("' + FormatDateTime(MysqlDateFormat, SParams.CurDate) + '")';
end;
function DueDays:String;
begin
  Result := DaysTostatementDate + '-   TO_DAYS(Duedate)';
end;
Function SalesType :String;
begin
    Result:= 'isinvoice="T" or isrefund="T" ';
    if SParams.includeSalesOrder then
        Result:= Result+ ' or issalesorder="T"';
    Result := '(' +Result +')';
    Result := '(' + Result + ' and (ifnull(PayMethod,"") = ""))';
  end;
function SalestypeBO: String;
begin
  Result := '';
  if SParams.includeinvoiceBO  and sparams.includeSOBO  then Result:= ' isinvoice   ="T" Or issalesorder="T"  '
  else if SParams.includeinvoiceBO then Result:= ' isinvoice   ="T"  '
  else if sparams.includeSOBO  then Result:= ' issalesorder="T"  ';

  if Result <> '' then Result := ' and ( ' +Result +' )' ;
end;
function Datetofilter :String ;
begin
    if sparams.basedonoptionsIndex =1  then Result := 'DueDate' else Result := 'SaleDate';
end;
Function sFrom :String;
begin
  Result := FormatDateTime(MysqlDateFormat, sparams.ReportDateFrom);
end;
Function sTo:String;
begin
  Result := FormatDateTime(MysqlDateFormat, sparams.ReportDateTo);
end;
function Clients(TableAlias:String):String;
begin
    Result := '(' + CreateALLJobWhereString(sparams.ClientID,TableAlias) + ') OR (' +
                    CreateALLRelatedCustWhereString(sparams.ClientID, TableAlias) + ')';
end;
function CreateALLRelatedCustWhereString(const ParentRelatedClientID: integer;const TableAlias: String): String;
var
  tmpTableAlias: String;
begin
  if not empty(TableAlias) then begin
    tmpTableAlias := TableAlias + '.';
  end else begin
    tmpTableAlias := '';
  end;
  Result := tmpTableAlias + 'ClientID= ' + ReplaceStr(GetALLRelatedCustClientIDs(ParentRelatedClientID),
    ',', ' OR ' + tmpTableAlias + 'ClientID= ');
end;

function CreateALLJobWhereString(const ParentClientID: integer; const TableAlias: String): String;
var
  tmpTableAlias: String;
begin
  if not empty(TableAlias) then begin
    tmpTableAlias := TableAlias + '.';
  end else begin
    tmpTableAlias := '';
  end;
  Result := tmpTableAlias + 'ClientID= ' + ReplaceStr(GetALLJobClientIDs(ParentClientID), ',',
    ' OR ' + tmpTableAlias + 'ClientID= ');
end;
function GetALLJobClientIDs(const ParentClientID: integer): String;
var
  qryTemp: TERPQuery;
  TempStr: String;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qryTemp do begin
      SQL.Clear;
      SQL.Add('SELECT ClientID FROM tblClients WHERE ParentClientID = ' +
        IntToStr(ParentClientID) + ';');
      Open;

      if not IsEmpty and sparams.GroupJobs then begin
        First;
        TempStr := IntToStr(ParentClientID);
        while not Eof do begin
          TempStr := TempStr + ',' + IntToStr(FieldByName('ClientID').AsInteger);
          Next;
        end;
        Result := TempStr;
      end else begin
        Result := IntToStr(ParentClientID);
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
function GetALLRelatedCustClientIDs(const ParentRelatedClientID: integer): String;
var
  qryTemp: TERPQuery;
  TempStr: String;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qryTemp do begin
      SQL.Clear;
      SQL.Add('SELECT ClientID FROM tblClients WHERE ParentRelatedClientID = ' +
        IntToStr(ParentRelatedClientID) + ' AND ParentRelatedClientID <> 0;');
      Open;
      if not IsEmpty and sparams.RelatedCustomer then begin
        First;
        TempStr := IntToStr(ParentRelatedClientID);
        while not Eof do begin
          TempStr := TempStr + ',' + IntToStr(FieldByName('ClientID').AsInteger);
          Next;
        end;
        Result := TempStr;
      end else begin
        Result := IntToStr(ParentRelatedClientID);
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function IsAllClassSelected: Boolean;
begin
  Result := (sparams.AllClass) or (sparams.SelectedClass = '');
end;

function getClassFilter(const fsFieldName: String): String;
begin
  if not IsAllClassSelected then
    Result :=  ' AND ' + fsfieldname + ' = ' + IntToStr(sparams.ClassID)
  else
    Result := '';
end;

Function BOType :String;
begin
    Result:= 'isrefund="T" ';
    if sparams.includeSOBO      then Result:= Result+ ' or issalesorder="T"';
    if sparams.includeinvoiceBO then Result:= Result+ ' or  isinvoice="T" ';
    Result := ' AND (' +Result +')';
end;
function Prepayamount(PrepayTablealias :String ='P';ResutlTupe:String ='Balance' ):String;
begin
  if sparams.BalOnDaterange then
    Result := '(' + iif(ResutlTupe = 'Balance' , PrepayTablealias +'.PayAmount - ', '') + 'ifnull( (select Sum(DL.Payment) '+
                  ' from tbldepositline DL inner join tbldeposits D on DL.PaymentID = D.PaymentID  '+
                  ' and D.Deleted="F" where d.Paymentdate <= ' +QuotedStr(FormatDateTime(MysqlDateFormat, sParams.CurDate))+' and  DL.TrnType = "Prepayment"  '+
                  ' and  DL.PrePaymentID = ' + PrepayTablealias +'.PrePaymentID),0))'
  else Result :='' + PrepayTablealias +'.balance';
end;
function TotalAmt(const aFrom, aTo : string; iscurrent, isclosingBalance: Boolean) : Double;
var
  strSQL:String;
  amt:Double;
begin
  if iscurrent then
    strSQL:=ReadBalance(aFrom, aTo, -1, 0, isclosingBalance)
  else
    strSQL:=ReadBalance(aFrom, aTo, -1, -1);

  if (sparams.includeinvoiceBO) or (sParams.includeSOBO) then
    strSQL:= strSQL +NL+'  union ALL   ' +
  iif( iscurrent ,  ReadBalance(aFrom, aTo, -1, 0, isclosingBalance , true) ,
                    ReadBalance(aFrom, aTo, -1, -1 ,False,  true));



  strSQL:= strSQL +NL+'  union ALL   ' +
        ' SELECT "Prepayment" , 0-Sum(ifnull(Balance,0)) as amt  ' +
        ' FROM   `tblPrePayments`'+
        ' WHERE ifnull(Deleted,"F") <> "T" and Payamount<>0  ' ;
  if isclosingBalance then
    strSQL:= strSQL +'  and `PrepaymentDate` <= "' +aTo +'"'
  else
    strSQL:= strSQL +'  and `PrepaymentDate` <= "' +aFrom +'"' ;
  strSQL := strSQL + getClassfilter('ClassId');
  strSQL := strSQL + ' ANd ( ' + clients('tblPrePayments')+')';

  logtext(strSql);
  runSQL(strSql , amt, 'amt' , true);
  Result := amt;
end;
function ReadBalance(const aFrom, aTo : string; FromDays:Integer;todays:Integer=0; isclosingBalance:Boolean = False; isbo:Boolean = False):String;
begin
  Result := 'SELECT "Sales" ,  ';

  if isbo then Result := Result + 'sum(ifnull(Sl.qtysold* sl.lineprice,0))'
  else Result := Result + 'sum(ifnull('+ SalesBalance +',0))';
  Result := Result + ' as Amt ' ;

  Result := Result + ' FROM tblsales S ' ;

  if isbo then Result := Result + ' inner join tblsaleslines SL on S.saleId = Sl.saleId' ;

  Result := Result + ' WHERE  (' + clients('S') +' )  ';

  if isbo then Result := Result + ' and ifnull(S.BOID, "") ="" and ifnull(SL.shipped,0) =0';

  if isbo then Result := Result +SalestypeBO
  else Result:= Result+ ' and ' + SalesType ;

  Result := Result + getclassFilter('S.ClassID');
  Result:= Result +' and S.converted = "F"';
  if isclosingbalance then Result := Result + ' and ' + Datetofilter+'  <= ' + Quotedstr(aTo)
  else Result := Result + ' and ' + Datetofilter+'  < ' + Quotedstr(aFrom);

end;
procedure runSQL(const strSQL: String; var VarAmt: Double;fsFieldname: String; runLoop: Boolean);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.Clear;
    qry.SQL.Add(strSQL);
    qry.Open;
    qry.First;
    if runLoop = false then
      VarAmt := qry.FieldByName(fsFieldname).AsCurrency
    else begin
      VarAmt := 0.00;
      while not qry.Eof do begin
        VarAmt := VarAmt + qry.FieldByName(fsFieldname).AsCurrency;
        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function GetOverDueMsg(const sTable: String): String;
const
  DAYS_OK = 0;
  DAYS_1  = 1;
  DAYS_7  = 2;
  DAYS_14 = 3;
  DAYS_21 = 4;
  DAYS_30 = 5;
  DAYS_60 = 6;
  DAYS_90 = 7;
var
  qryTemp: TERPQuery;

  function GetAssignedMsg(ODueDays: integer): String;
  begin
    Result := AppEnv.CompanyPrefs.ODueOk;
    if (ODueDays = DAYS_1) and (not Empty(AppEnv.CompanyPrefs.ODue1Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue1Days;
    end else if (ODueDays = DAYS_7) and (not Empty(AppEnv.CompanyPrefs.ODue7Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue7Days;
    end else if (ODueDays = DAYS_14) and (not Empty(AppEnv.CompanyPrefs.ODue14Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue14Days;
    end else if (ODueDays = DAYS_21) and (not Empty(AppEnv.CompanyPrefs.ODue21Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue21Days;
    end else if (ODueDays = DAYS_30) and (not Empty(AppEnv.CompanyPrefs.ODue30Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue30Days;
    end else if (ODueDays = DAYS_60) and (not Empty(AppEnv.CompanyPrefs.ODue60Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue60Days;
    end else if (ODueDays = DAYS_90) and (not Empty(AppEnv.CompanyPrefs.ODue90Days)) then begin
      Result := AppEnv.CompanyPrefs.ODue90Days;
    end;
  end;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection           := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.ParamCheck           := false;
    qryTemp.Options.StrictUpdate := false;
    qryTemp.SQL.Add('SELECT ' +
      'SUM(`1-7 Days`) as Days1, ' +
      'SUM(`7-14 Days`) as Days7, ' +
      'SUM(`14-21 Days`) as Days14, ' +
      '( SUM(`>21 Days`)-(SUM(`30-60 Days`) + SUM(`60-90 Days`) + SUM(`>90 Days`)) ) as Days21, ' +
      'SUM(`30-60 Days`) as Days30,' +
      'SUM(`60-90 Days`) as Days60, ' +
      'SUM(`>90 Days`) as Days90 ' +
      ' FROM ' + sTable);
    qryTemp.Open;
    if qryTemp.FieldByName('Days90').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_90);
    end else if qryTemp.FieldByName('Days60').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_60);
    end else if qryTemp.FieldByName('Days30').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_30);
    end else if qryTemp.FieldByName('Days21').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_21);
    end else if qryTemp.FieldByName('Days14').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_14);
    end else if qryTemp.FieldByName('Days7').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_7);
    end else if qryTemp.FieldByName('Days1').AsCurrency > 0 then begin
      Result := GetAssignedMsg(DAYS_1);
    end else begin
      Result := GetAssignedMsg(DAYS_OK);
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
Function clientbillToAddress(TableAlias:STring):String;
var
  ctr:Integer;
  function Alias:String; begin Result :=''; if TableAlias <> '' then Result := TableAlias +'.';end;
begin
{bill to address format
street1
street2
street3
suburb  state  postcode
Country
should not leave blank lines or spaces}
  Result :='concat_ws("  ", '+ Alias+'BillSuburb, '+ Alias+'BillState, '+ Alias+'BillPostcode)';
  for ctr := 1 to 3 do Result := 'Replace(' +Result +',"    " , "  ")';
  Result := 'concat_ws("\n", '+ Alias+'Company, '+ Alias+'BillStreet , '+ Alias+'BillStreet2 , '+ Alias+'BillStreet3,'+Result + ', '+ Alias+'BillCountry)';
  for ctr := 1 to 6 do Result := 'Replace(' +Result +',"\n\n" , "\n")';
end;
function TotalForeignAmt(const sFrom, sTo : string; iscurrent,isclosingBalance: Boolean): Double;
var
  strSQL : string;
  amt : double;
begin
  if iscurrent then
    strSQL:=ReadForeignBalance(sFrom, sTo, -1, 0, isclosingBalance)
  else
    strSQL:=ReadForeignBalance(sFrom, sTo, -1, -1);

  if (sparams.includeinvoiceBO) or (sparams.includeSOBO) then
    strSQL:= strSQL +NL+'  union ALL   ' +
  iif( iscurrent ,  ReadForeignBalance(sFrom, sTo, -1, 0, isclosingBalance , true),
                    ReadForeignBalance(sFrom, sTo, -1, -1 , false , true));


  strSQL:= strSQL +'  union ALL   ' +
        ' SELECT "Prepayment" , 0-Sum(ifnull(ForeignBalance,0)) as amt  ' +
        ' FROM   `tblPrePayments`'+
        ' WHERE ifnull(Deleted,"F") <> "T" and Payamount<>0  ' ;
  if isclosingBalance then
    strSQL:= strSQL +'  and `PrepaymentDate` <= "' +sTo +'"'
  else
    strSQL:= strSQL +'  and `PrepaymentDate` <= "' +sFrom +'"' ;
  strSQL := strSQL + getClassfilter('ClassId');
  strSQL := strSQL + ' ANd ( ' + clients('tblPrePayments')+')';
  runSQL(strSql , amt, 'amt' , true);
  Result := amt;
end;
function ReadForeignBalance(const sFrom, sTo : string; FromDays:Integer;todays:Integer=0; isclosingBalance:Boolean = False; isbo:Boolean =False):String;
begin
  Result := 'SELECT "Sales" ,  ';

  if isbo then Result := Result + 'sum(ifnull(Sl.qtysold* sl.lineprice*sl.ForeignExchangeSellRate,0))'
  else Result := Result + 'sum(ifnull(S.ForeignBalanceAmount,0))';
  Result := Result + ' as Amt ' ;

  Result := Result + ' FROM tblsales S ' ;

  if isbo then Result := Result + ' inner join tblsaleslines SL on S.saleId = Sl.saleId' ;

  Result := Result + ' WHERE  (' + clients('S') +' )  ';

  if isbo then Result := Result + ' and ifnull(S.BOID, "") ="" and ifnull(SL.shipped,0) =0';

  if isbo then Result := Result +SalestypeBO
  else Result:= Result+ ' and ' + SalesType ;

  Result := Result + getclassFilter('S.ClassID');
  Result:= Result +' and S.converted = "F"';
  if isclosingbalance then Result := Result + ' and ' + Datetofilter+'  <= ' + Quotedstr(sTo)
  else Result := Result + ' and ' + Datetofilter+'  < ' + Quotedstr(SFrom);

end;
Function Transactions :String;
begin
    Result:= 'Invoice + Refund - Prepayment';
    if sParams.includeSalesOrder then Result:= Result+ ' + SalesOrder';
end;
Function TransactionsWithBO :String;
begin
    Result := Transactions;
    if sParams.includeSOBO       then Result:= Result+ ' + SalesOrder(BO)';
    if sParams.includeinvoiceBO  then Result:= Result+ ' + Invoice(BO)';
end;
end.

