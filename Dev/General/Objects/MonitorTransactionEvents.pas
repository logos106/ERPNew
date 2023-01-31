unit MonitorTransactionEvents;

interface

uses ERPdbComponents, classes;

Type
    TransactionEvents = Class(TComponent)
      Private
      public
        class Function EventsInOtherTransactions(ERPConnection :TERPConnection):String;
        class Procedure DeleteAllTransactionEvents(const LogPriorto:TDatetime =0);
    end;
implementation

uses CommonDbLib, SysUtils, FastFuncs, MySQLConst, AppEnvironment;

{ TransactionEvents }

class procedure TransactionEvents.DeleteAllTransactionEvents(const LogPriorto:TDatetime =0);
begin
  With commonDBLib.TempMyQuery do try
    if LogPriorto = 0 then begin
      Sql.add('Delete from   debuglog ;');
      Sql.add('Delete from   debuglogdetails ;');
    end else begin
      Sql.add('Delete from   debuglogdetails  Where `Logtime` <' + QuotedStr(FormatDatetime(MysqlDateTimeFormat ,LogPriorto)) +';');
      Sql.add('Delete from   debuglog  Where `TransStartedAt` < ' + QuotedStr(FormatDatetime(MysqlDateTimeFormat ,LogPriorto)) +' and LogId not in (SELECT `LogID` FROM `debuglogdetails` AS `DD` Where `DD`.`Logtime` >' + QuotedStr(FormatDatetime(MysqlDateTimeFormat ,LogPriorto)) +');');
      Sql.add('Delete from   debuglogdetails  Where LogId in (SELECT `D`.`LogID` FROM `debuglog` AS `D` where user = ' + QuotedStr(AppEnv.Employee.EmployeeName) +');');
      Sql.add('Delete from   debuglog  where user = ' + QuotedStr(AppEnv.Employee.EmployeeName) +';');
    end;
    Execute;
  finally
    if active then close;
    free;
  end;
end;

class function TransactionEvents.EventsInOtherTransactions(ERPConnection: TERPConnection): String;
begin
  REsult := '';
  With commonDBLib.TempMyQuery do try
         SQL.add('select if(debuglog.connectionId = ' +intToStr(integer(ERPConnection))+ ' , "T" , " ") as ErrorItem, ');
         SQL.add('debuglogdetails.connectionId , debuglog.PCNAme,  debuglog.User, debuglog.Formname, debuglog.TransStartedAt,' );
         SQL.add('debuglogdetails.Logtime, debuglogdetails.Objectname, ' );
         SQL.add('debuglogdetails.eventname, debuglogdetails.QuerySQL ,' );
         SQL.add('debuglogdetails.Error , debuglogdetails.IsError' );
         SQL.add('from debuglog' );
         SQL.add('inner join debuglogdetails on debuglogdetails.connectionId = debuglog.connectionID' );
         SQL.add('Where debuglog.connectionId <> ' +intToStr(integer(ERPConnection))+ ' or IsError ="T" ');
         SQL.add('Order by ErrorItem Desc, debuglogdetails.Logtime');
         Open;
         if recordcount = 0 then exit;
         first;
         while Eof = False do begin
          if fieldByname('ErrorItem').asString  =  'T' then
            REsult := result + #13#10 +'---------------------------Exception generated by----------------------';
          Result := result + #13#10 +'#' +IntToStr(Recno)+#13#10 +
            #9+'PC NAME               :' +Trim(Fieldbyname('PCName').asString) +  #13#10 +
            #9+'USER                  :' +Trim(Fieldbyname('User').asString) +  #13#10 +
            #9+'FORM                  :' +Trim(fieldbyname('formname').asString) +  #13#10 +
            #9+'OBJECT                :' +Trim(fieldbyname('Objectname').asString) +  #13#10 +
            #9+'EVENT                 :' +Trim(fieldbyname('EventName').asString) +  #13#10 +
            #9+'TIME                  :' +DateTimeToStr(fieldByname('Logtime').asDateTime) +   #13#10 +
            #9+'TRANSACTION STARTED AT:' +DateTimeToStr(fieldByname('TransStartedAt').asDateTime) +  #13#10 +
            #9+'SQL                   :' +Trim(fieldbyname('QuerySQL').asString) ;
            if Trim(fieldbyname('Error').asString) <> '' then
              result := result +   #13#10 + #9+'ERROR                 :' +Trim(fieldbyname('Error').asString) ;
          if fieldByname('ErrorItem').asString  =  'T' then
            REsult :=result + #13#10 +'-----------------------------------------------------------------------';           
          Next;
         end;
    if active then close;
    SQl.clear;
    Sql.add('Delete from   debuglog where connectionId = '+intToStr(integer(ERPConnection))+';');
    Sql.add('Delete from   debuglogdetails where connectionId = '+intToStr(integer(ERPConnection))+';');
    Execute;
  finally
    if active then close;
    free;
  end;

end;

end.
