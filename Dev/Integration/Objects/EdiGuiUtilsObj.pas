unit EdiGuiUtilsObj;

interface

uses
  JsonObject;

type

  TEdiGuiUtils = class(TObject)
  private
    fShowLog: boolean;
    procedure HandleEvent(EventName: string; Params: TJsonObject);
    procedure Log(msg: string);
  public
    constructor Create;
    property ShowLog: boolean read fShowLog write fShowLog;
    procedure DoCheckForOrders(aEdiPartyList: string = ''; aShowLog: boolean = true);
    procedure DoConfirmShipment(aEdiPartyList: string = ''; aInvoiceIdList: string = ''; aShowLog: boolean = true);
    function DoGetServiceStatus(var msg: string; StatusJson: TJsonObject; aEdiPartyList: string = ''; aShowLog: boolean = true): boolean;
    class procedure CheckForOrders(aEdiPartyList: string = ''; aShowLog: boolean = true);
    class procedure ConfirmShipment(aEdiPartyList: string = ''; aInvoiceIdList: string = ''; aShowLog: boolean = true);
    class function GetServiceStatus(var msg: string; StatusJson: TJsonObject; aEdiPartyList: string = ''; aShowLog: boolean = true): boolean;
  end;

implementation

uses
  utTrueERPModClientEDI, ModuleFileNameUtils, CommonLib, SysUtils, Dialogs,
  AppEnvironment, LogThreadLib, LogDialog, LogMessageTypes, Classes, Forms;

{ TEdiGuiUtils }



class procedure TEdiGuiUtils.CheckForOrders(aEdiPartyList: string; aShowLog: boolean);
var
  inst: TEdiGuiUtils;
begin
  inst := TEdiGuiUtils.Create;
  try
    inst.DoCheckForOrders(aEdiPartyList, aShowLog);
  finally
    inst.Free;
  end;
end;

class procedure TEdiGuiUtils.ConfirmShipment(aEdiPartyList: string;
  aInvoiceIdList: string; aShowLog: boolean);
var
  inst: TEdiGuiUtils;
begin
  inst := TEdiGuiUtils.Create;
  try
    inst.DoConfirmShipment(aEdiPartyList,aInvoiceIdList, aShowLog);
  finally
    inst.Free;
  end;
end;

constructor TEdiGuiUtils.Create;
begin
  fShowLog := true;
end;

procedure TEdiGuiUtils.DoCheckForOrders(aEdiPartyList: string; aShowLog: boolean);
var
  EdiModClient: TEdiModClient;
  msg: string;
  Params: TJsonObject;
  sl: TStringList;
  I: integer;
begin
  ShowLog := aShowLog;
  Log('Order check started ..');
  try
    Params := JO;
    EdiModClient := TEdiModClient.Create(ModuleFileNameUtils.GetCurrentModulePath + 'Bin\TrueERP_Mod_EDI.exe');
    try
      EdiModClient.OnEventMessage := HandleEvent;
      if not EdiModClient.DbConnect(AppEnv.AppDb.Server,AppEnv.AppDb.Database,AppEnv.Employee.LogonName ,AppEnv.Employee.LogonPassword,msg) then begin
        Log('Error connecting to EDI Module: Server: "' +
          AppEnv.AppDb.Server + '" Database: "' + AppEnv.AppDb.Database + '" User: "' + AppEnv.Employee.LogonName + '"');
        Log(msg);
        exit;
      end;
      if aEdiPartyList = '' then
        Params.A['EDIPartyList'].Add('All')
      else begin
        sl := TStringList.Create;
        try
          sl.CommaText := aEdiPartyList;
          for I := 0 to sl.Count -1 do
            Params.A['EDIPartyList'].Add(sl[I]);
        finally
          sl.Free;
        end;
      end;

      if EdiModClient.CheckForNewEDIMessages(Params.AsString,msg) then begin
      end
      else begin
        Log('Error checking for new EDI Orders:');
        Log(msg);
      end;
      if EdiModClient.ProcessNewEDIMessages(Params.AsString,msg) then begin

      end
      else begin
        Log('Error importing new EDI Orders:');
        Log(msg);
      end;

    finally
      EdiModClient.Free;
      Params.Free;
    end;
    Log('Order check complete.');
    Log('');
  except
    on e: exception do begin
      Log('Error connecting to EDI Module:');
      Log(e.Message);
      try
        EdiModClient.Free;
      except

      end;
    end;
  end;
end;

procedure TEdiGuiUtils.DoConfirmShipment(aEdiPartyList: string;
  aInvoiceIdList: string; aShowLog: boolean);
var
  EdiModClient: TEdiModClient;
  msg: string;
  Params: TJsonObject;
  sl: TStringList;
  I: integer;
begin
  ShowLog := aShowLog;
  if aInvoiceIdList = '' then
    Log('Started EDI Order Shipment Confirmation..')
  else
    Log('Started EDI Order Shipment ..');
  try
    Params := JO;
    Params.S['InvoiceIdList'] := aInvoiceIdList;
    EdiModClient := TEdiModClient.Create(ModuleFileNameUtils.GetCurrentModulePath + 'Bin\TrueERP_Mod_EDI.exe');
    try
      EdiModClient.OnEventMessage := HandleEvent;
      if not EdiModClient.DbConnect(AppEnv.AppDb.Server,AppEnv.AppDb.Database,AppEnv.Employee.LogonName ,AppEnv.Employee.LogonPassword,msg) then begin
        Log('Error connecting to EDI Module:');
        Log(msg);
        exit;
      end;
      if aEdiPartyList = '' then
        Params.A['EDIPartyList'].Add('All')
      else begin
        sl := TStringList.Create;
        try
          sl.CommaText := aEdiPartyList;
          for I := 0 to sl.Count -1 do
            Params.A['EDIPartyList'].Add(sl[I]);
        finally
          sl.Free;
        end;
      end;
      if EdiModClient.ConfirmShipment(Params.AsString, msg) then begin
        { Ok }

      end
      else begin
        { error }
        Log('Error Shipping EDI Orders:');
        Log(msg);
      end;

    finally
      EdiModClient.Free;
      Params.Free;
    end;
    if aInvoiceIdList = '' then
      Log('Compleated EDI Order Shipment Confirmation.')
    else
      Log('Compleated EDI Order Shipment.');
    Log('');
  except
    on e: exception do begin
      Log('Error connecting to EDI Module:');
      Log(e.Message);
      try
        EdiModClient.Free;
      except

      end;
    end;
  end;
end;

function TEdiGuiUtils.DoGetServiceStatus(var msg: string; StatusJson: TJsonObject; aEdiPartyList: string;
  aShowLog: boolean): boolean;
var
  EdiModClient: TEdiModClient;
  Params, obj: TJsonObject;
  sl: TStringList;
  I: integer;
begin
  result := true;
  ShowLog := aShowLog;
//  Log('Started Service Status Check ..');
  try
    Params := JO;
    obj := JO;
    EdiModClient := TEdiModClient.Create(ModuleFileNameUtils.GetCurrentModulePath + 'Bin\TrueERP_Mod_EDI.exe');
    try
      EdiModClient.OnEventMessage := HandleEvent;
      if not EdiModClient.DbConnect(AppEnv.AppDb.Server,AppEnv.AppDb.Database,AppEnv.Employee.LogonName ,AppEnv.Employee.LogonPassword,msg) then begin
        result := false;
        Log('Error connecting to EDI Module:');
        Log(msg);
        exit;
      end;
      if aEdiPartyList = '' then
        Params.A['EDIPartyList'].Add('All')
      else begin
        sl := TStringList.Create;
        try
          sl.CommaText := aEdiPartyList;
          for I := 0 to sl.Count -1 do
            Params.A['EDIPartyList'].Add(sl[I]);
        finally
          sl.Free;
        end;
      end;
      if EdiModClient.GetGetServiceStatus(Params.AsString, msg, obj) then begin
        { Ok }
        if Assigned(StatusJson) then
          StatusJson.Assign(obj);
      end
      else begin
        { error }
        result := false;
        Log('Error Checking Service Status:');
        Log(msg);
      end;

    finally
      EdiModClient.Free;
      Params.Free;
      obj.Free;
    end;
//    Log('Compleated Service Status Check.');
    Log('');
  except
    on e: exception do begin
      result := false;
      msg := e.Message;
      Log('Error connecting to EDI Module:');
      Log(e.Message);
      try
        EdiModClient.Free;
      except

      end;
    end;
  end;
end;

class function TEdiGuiUtils.GetServiceStatus(var msg: string; StatusJson: TJsonObject; aEdiPartyList: string;
  aShowLog: boolean): boolean;
var
  inst: TEdiGuiUtils;
begin
  inst := TEdiGuiUtils.Create;
  try
    result := inst.DoGetServiceStatus(msg, StatusJson, aEdiPartyList, aShowLog);
  finally
    inst.Free;
  end;
end;

{ Log event format .. }
{ 'Log',{"Message":"a log message","LogType":2}
procedure TEdiGuiUtils.HandleEvent(EventName: string; Params: TJsonObject);
begin
  if SameText(EventName, 'Log') then begin
    Log(Params.S['Message']);
    TLogger.Inst.Log(Params.S['Message'], TLogMessageType(Params.I['LogType']));
//    Application.ProcessMessages;
  end;
end;

procedure TEdiGuiUtils.Log(msg: string);
begin
  if self.ShowLog then
    LogToDialog(msg);
end;

end.
