program ErpMySqlIniUpdater;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  InstallConst,
  MySQLIniFile in '..\..\Common\MySQLIniFile.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\Common\DbConst.pas';

var
  ini: TMySqlIniFile;
  iniFileName: string;
  NeedsUpdating: boolean;
  s: string;

begin
//  TLogger.Inst.LoggAllTypes;
  NeedsUpdating:= false;
  try
    iniFileName:= GetMySQLConfigFileName;
    ini:= TMySqlIniFile.Create(iniFileName);
    try
      s:= ini.ReadString('mysqld','max_connections');
      if s = '' then
        NeedsUpdating:= true
      else begin
        if (StrToIntDef(s,0) < 300) then
          NeedsUpdating:= true;
      end

    finally
      ini.Free;
    end;

    if NeedsUpdating then begin
      if ServiceStop('',MySQL_ERP_SERVICE,5*60*1000) then begin
        ini:= TMySqlIniFile.Create(iniFileName);
        try
          ini.WriteString('mysqld','max_connections','300');
          ini.SaveFile;
        finally
          ini.Free;
        end;
        ServiceStart('',MySQL_ERP_SERVICE);
      end
      else begin
        { failed to stop mysql service }


      end;
    end;
//    Halt(ExitCode);
//    exitcode:= 51;
//    showmessage(inttostr(exitcode));
  except
//    on E: Exception do
//      TLogger.Inst.Log('Exception - ' + E.ClassName +': ' + E.Message,ltError);
  end;
end.
