unit ConfigReader;

interface

uses JSONObject;

Type
  TLogEvent = Procedure (const Value:String) of Object;

  TERP_ConfigReader = Class(TObject)
    private
      fsMySQLServer: String;
    Protected
      fLogEvent : TLogEvent;
      function getConfigName: String;Virtual; abstract;
      Procedure ReadFromJson(aJson: TJsonObject);Virtual; abstract;

    Public
     Constructor Create(aMySQLServer :String; aLogEvent:TLogEvent); virtual;
     Property ConfigName :String read getConfigName;
     Property MySQLServer :String read fsMySQLServer write fsMySQLServer;
  End;

  TERPModWebAPI_Config = Class(TERP_ConfigReader)
    Private
      fiDefaultPort       : Integer;
      fiMaxConnections    : Integer;
      fsModuleVersion     : String;
      fsModuleName        : String;
      fsModuleFileName    : String;
      fsWebUserName       : String;
      fsLoggerClassName   : String;
      fbGuiInERP          : Boolean;
      fsLoggingLevel      : String;
      fbGuiInServiceMenu  : Boolean;
      fiDefaultSSLPort    : Integer;
      fbUseSSL            : Boolean;
      fbActive            : Boolean;
      fsModuleDescription : String;
    Protected
      function getConfigName: String;Override;
    public
      Procedure ReadFromJson(aJson: TJsonObject);Override;
      constructor Create(aMySQLServer :String;aLogEvent:TLogEvent); override;
      Property Active           : Boolean Read fbActive             write fbActive            ;
      Property DefaultPort      : Integer Read fiDefaultPort        write fiDefaultPort       ;
      Property DefaultSSLPort   : Integer Read fiDefaultSSLPort     write fiDefaultSSLPort    ;
      Property GuiInERP         : Boolean Read fbGuiInERP           write fbGuiInERP          ;
      Property GuiInServiceMenu : Boolean Read fbGuiInServiceMenu   write fbGuiInServiceMenu  ;
      Property LoggerClassName  : String  Read fsLoggerClassName    write fsLoggerClassName   ;
      Property LoggingLevel     : String  Read fsLoggingLevel       write fsLoggingLevel      ;
      Property MaxConnections   : Integer Read fiMaxConnections     write fiMaxConnections    ;
      Property ModuleDescription: String  Read fsModuleDescription  write fsModuleDescription ;
      Property ModuleFileName   : String  Read fsModuleFileName     write fsModuleFileName    ;
      Property ModuleName       : String  Read fsModuleName         write fsModuleName        ;
      Property ModuleVersion    : String  Read fsModuleVersion      write fsModuleVersion     ;
      Property UseSSL           : Boolean Read fbUseSSL             write fbUseSSL            ;
      Property WebUserName      : String  Read fsWebUserName        write fsWebUserName       ;

      Class function WebApi_Active           (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean ;
      Class function WebApi_DefaultPort      (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer ;
      Class function WebApi_DefaultSSLPort   (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer ;
      Class function WebApi_GuiInERP         (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean ;
      Class function WebApi_GuiInServiceMenu (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean ;
      Class function WebApi_LoggerClassName  (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_LoggingLevel     (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_MaxConnections   (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer ;
      Class function WebApi_ModuleDescription(const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_ModuleFileName   (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_ModuleName       (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_ModuleVersion    (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function WebApi_UseSSL           (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean ;
      Class function WebApi_WebUserName      (const aMySQLServer:String;aLogEvent:TLogEvent) : String  ;
      Class function UserLoginPassword(aUserJname, aDatabasename:String): String;
  End;
implementation

uses WebApiConst , ERPDBcomponents, MySQLUtils, DbSharedObjectsObj,
  SimpleEncrypt, sysutils, SystemLib, ModuleConst, ConfigDbObj ;

{ TERP_ConfigReader }

constructor TERP_ConfigReader.Create(aMySQLServer :String;aLogEvent:TLogEvent);
var
  configFileName: string;
  ConfigDb: TConfigDb;
  aJson: TJsonObject;
begin
  fLogEvent := aLogEvent;
  MySQLServer := aMySQLServer;
  aJson:= JO;
  try
      ConfigDb := TConfigDb.Create( ConfigName + '_Config',aMySQLServer);
      try
        if not ConfigDb.Exists then begin
          if assigned(fLogEvent)  then
            fLogEvent(ConfigName + ' Config is Searched in the Services DB and doesn''t Exists');
        end;
        aJson.asString :=ConfigDb.Value;
        ReadFromJson(aJson);
      finally
          ConfigDb.Free;
      end;
    finally
      aJson.Free;;
    end;
end;



{ TERPModWebAPI_Config }

constructor TERPModWebAPI_Config.Create(aMySQLServer :String;aLogEvent:TLogEvent);
begin
  inherited Create(aMySQLServer , aLogEvent);
end;

function TERPModWebAPI_Config.getConfigName: String;
begin
//  Result := ExeDir+WebAPIConfigFile;
  Result := 'ERPModWebAPI';
end;
procedure TERPModWebAPI_Config.ReadFromJson(aJson: TJsonObject);
begin
    Active           :=aJson.B['Active'];
    DefaultPort      :=aJson.I['DefaultPort'];
    DefaultSSLPort   :=aJson.I['DefaultSSLPort'];
    GuiInERP         :=aJson.B['GuiInERP'];
    GuiInServiceMenu :=aJson.B['GuiInServiceMenu'];
    LoggerClassName  :=aJson.S['LoggerClassName'];
    LoggingLevel     :=aJson.S['LoggingLevel'];
    MaxConnections   :=aJson.I['MaxConnections'];
    ModuleDescription:=aJson.S['ModuleDescription'];
    ModuleFileName   :=aJson.S['ModuleFileName'];
    ModuleName       :=aJson.S['ModuleName'];
    ModuleVersion    :=aJson.S['ModuleVersion'];
    UseSSL           :=aJson.B['UseSSL'];
    WebUserName      :=aJson.S['WebUserName'];
end;
class function TERPModWebAPI_Config.UserLoginPassword(aUserJname,aDatabasename: String): String;
var
  fConn :TERPConnection;
  qry: TERPQuery;
begin
  result := '';
  try
      fConn :=TERPConnection.Create(nil);
      SetConnectionProps(fconn , aDatabasename);
      fConn.Connect;
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fConn);
      try
          qry.SQL.Add('SELECT Logon_Password');
          qry.SQL.Add('FROM  tblPassword p');
          qry.SQL.Add('inner join tblemployees e on e.EmployeeID = p.EmployeeID and e.Active = "T"');
          qry.SQL.Add('WHERE Logon_Name =  ' +QuotedStr(aUserJname));
          qry.Open;
          if qry.recordcount > 0 then
            result := DeCrypt(qry.Fields.FieldByName('Logon_Password').AsString, 'z');
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  Except
    // kill the exception , incase if db or user etc doesn't exists
  end;
end;

Class function TERPModWebAPI_Config.WebApi_Active           (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := Active             ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_DefaultPort      (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := DefaultPort        ; if Result =0 then Result := 88; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_DefaultSSLPort   (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := DefaultSSLPort     ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_GuiInERP         (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := GuiInERP           ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_GuiInServiceMenu (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := GuiInServiceMenu   ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_LoggerClassName  (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := LoggerClassName    ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_LoggingLevel     (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := LoggingLevel       ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_MaxConnections   (const aMySQLServer:String;aLogEvent:TLogEvent) : Integer;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := MaxConnections     ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_ModuleDescription(const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := ModuleDescription  ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_ModuleFileName   (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := ModuleFileName     ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_ModuleName       (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := ModuleName         ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_ModuleVersion    (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := ModuleVersion      ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_UseSSL           (const aMySQLServer:String;aLogEvent:TLogEvent) : Boolean;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := UseSSL             ; Finally Free; end; end;
Class function TERPModWebAPI_Config.WebApi_WebUserName      (const aMySQLServer:String;aLogEvent:TLogEvent) : String ;begin  With TERPModWebAPI_Config.create(aMySQLServer,aLogEvent) do try Result := WebUserName        ; Finally Free; end; end;


end.
