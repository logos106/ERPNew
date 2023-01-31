unit InuseFormslib;

interface


Procedure LogInuse(Instance:Integer; ClassName:String;KeyId:Integer=0);
Procedure DeleteLogInuse(Instance:Integer; ClassName:String;KeyId:Integer=0);
Procedure DeleteAllLogInuse;

implementation

uses AppEnvironment, CommonDbLib, sysutils, tcConst;

Procedure DeleteAllLogInuse;
var
  strSQL:String;
begin
  strSQL:= 'Delete from  tblinuseforms where Username = '+ Quotedstr(Appenv.Employee.LogonName) ;
  ExecuteSQL(strSQL);
end;
Procedure DeleteLogInuse(Instance:Integer; ClassName:String;KeyId:Integer=0);
var
  strSQL:String;
begin
  strSQL:= 'Delete from  tblinuseforms where Username = '+Quotedstr(Appenv.Employee.LogonName) +
          ' and  Instance = ' + inttostr(Instance) +
          ' and  ClassName = ' + Quotedstr(ClassName);
    ExecuteSQL(strSQL);
end;
Procedure LogInuse(Instance:Integer; ClassName:String; KeyId:Integer=0);
var
  strSQL:String;
begin
  strSQL:= 'INSERT  INTO tblinuseforms ' +
            ' (Username, Instance, ClassName, TimeEntered, KeyId)  ' +
            ' VALUES ('+
              Quotedstr(Appenv.Employee.LogonName)+', ' +
              inttostr(Instance)+', '+
              Quotedstr(ClassName)+', '+
              Quotedstr(formatdateTime('yyyy-mm-dd hh:nn:ss' ,Now ))+', '+
              inttostr(KeyId)+
              ') on duplicate Key update  KeyId = '+ inttostr(KeyId);
    ExecuteSQL(strSQL);
end;

end.
