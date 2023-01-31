unit fraUtilsConfigBase;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UserUtilsClientObj, JsonObject, StdCtrls, wwclearbuttongroup,
  wwradiogroup;

type
  TShowLogEvent = procedure (Sender: TComponent; ModuleName, ServerName: string) of object;


  TfrUtilsConfigBase = class(TFrame)
  private
    fUtilsClient: TUserUtilsClient;
    fModuleName: string;
  protected
    Config,
    ConfigClean: TJsonObject;
    Loading: boolean;
    fOnShowLog: TShowLogEvent;
    Encrypted: boolean;
    ValidateConfig: boolean;
    function GetModuleName: string; virtual;
    procedure SetModuleName(const Value: string); virtual;
    procedure SetUtilsClient(const Value: TUserUtilsClient); virtual;
    function GetModuleConfig: boolean; virtual;
    function SetModuleConfig(var msg: string): boolean; virtual;
    function SetModuleProperty(const aPropName: string; aValue: string; var msg: string): boolean; overload;
    function SetModuleProperty(const aPropName: string; aValue: double; var msg: string): boolean; overload;
    function SetModuleProperty(const aPropName: string; aValue: integer; var msg: string): boolean; overload;
    function SetModuleProperty(const aPropName: string; aValue: boolean; var msg: string): boolean; overload;
    function VerifyAndSetModuleConfig: boolean; virtual;
    procedure AfterGetModuleConfig; virtual;
    procedure ShowLog;
    function ConfigHasChanged(newConfig, cleanConfig: TJsonObject): boolean; virtual;
    Procedure InitForDevmode;Virtual;
  public
    SeverModuleInfo: TJsonObject;
    property UtilsClient: TUserUtilsClient read fUtilsClient write SetUtilsClient;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property ModuleName: string read GetModuleName write SetModuleName;
  published
    property OnShowLog: TShowLogEvent read fOnShowLog write fOnShowLog;
  end;

implementation

{$R *.dfm}

uses
  Vista_MessageDlg, CipherUtils, PreferancesLib, ServiceMenuLib;

{ TfrUtilsConfigBase }

procedure TfrUtilsConfigBase.AfterGetModuleConfig;
begin

end;

function TfrUtilsConfigBase.ConfigHasChanged(newConfig,
  cleanConfig: TJsonObject): boolean;
begin
  result := not SameText(newConfig.AsString, cleanConfig.AsString);
end;

constructor TfrUtilsConfigBase.Create(aOwner: TComponent);
begin
  inherited;
  Encrypted := false;
  fModuleName := '';
  Loading:= false;
  Config := TJsonObject.Create;
  SeverModuleInfo := TJsonObject.Create;
  ConfigClean := TJsonObject.Create;
  ValidateConfig := true;
  InitForDevmode;
end;

destructor TfrUtilsConfigBase.Destroy;
begin
  Config.Free;
  ConfigClean.Free;
  SeverModuleInfo.Free;
  inherited;
end;

function TfrUtilsConfigBase.GetModuleConfig: Boolean;
var
  j: TJsonObject;
  meth: string;
begin
  Result := False;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetConfig';
  j := UtilsClient.Client.SendRequest(meth, nil);
  if Assigned(j) then begin
    try
      if j.ObjectExists('result') then begin
        if j.O['result'].BooleanExists('Encrypted') and j.O['result'].B['Encrypted'] then begin
          Config.AsString := CipherUtils.DecryptString(j.O['result'].S['Data']);
          Encrypted := true;
        end
        else
          Config.Assign(j.O['result']);
        ConfigClean.Assign(Config);
        result := True;
        Loading := True;
        try
          AfterGetModuleConfig;
        finally
          Loading := False;
        end;
      end;
    finally
      j.Free;
    end;
  end
  else begin
    if ModuleName <> '' then
      Vista_MessageDlg.MessageDlgXP_Vista('No response received from Module: '+ ModuleName, mtInformation,[mbOk],0)
    else
      Vista_MessageDlg.MessageDlgXP_Vista('No response received from ERP Utilities Service', mtInformation,[mbOk],0);
  end;
end;

function TfrUtilsConfigBase.GetModuleName: string;
begin
  Result := fModuleName;
end;

procedure TfrUtilsConfigBase.InitForDevmode;
var
  comp :Tcomponent;
begin
 {$IFDEF DevMode}
  comp := ServiceMenuLib.FindComponentByName(Self,'rgLoggingLevel',True,'');
  if comp <> nil then
    if comp is TwwRadioGroup then begin
      if TwwRadioGroup(Comp).items.indexof('Debud') <0 then begin
      TwwRadioGroup(Comp).items.Add('Debug');
      TwwRadioGroup(Comp).columns := TwwRadioGroup(Comp).columns +1;
      end;
    end;
 {$ENDIF}
end;

function TfrUtilsConfigBase.SetModuleConfig(var msg: string): boolean;
var
  j, obj: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetConfig';
  obj:= JO;
  if Encrypted then begin
    obj.B['Encrypted'] := true;
    obj.S['Data'] := CipherUtils.EncryptString(Config.AsString)
  end
  else
    obj.Assign(Config);
  j := UtilsClient.Client.SendRequest(meth,obj);
  if Assigned(j) then begin
    try
      if j.Exists('error') then begin
        result := false;
        if j.ObjectExists('error') then
          msg:= j.O['error'].S['message'];
      end;
    finally
      j.Free;
    end;
  end;
  if result then
    ConfigClean.Assign(Config);
end;

procedure TfrUtilsConfigBase.SetModuleName(const Value: string);
begin
  fModuleName := Value;
end;

function TfrUtilsConfigBase.SetModuleProperty(const aPropName: string; aValue: string;
  var msg: string): boolean;
var
  j, obj, o: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetModuleProperty';
  obj:= JO;
  if Encrypted then begin
    obj.B['Encrypted'] := true;
    o := JO;
    try
      o.S[aPropName] := aValue;
      obj.S['Data'] := CipherUtils.EncryptString(o.AsString);
      PreferancesLib.DoPrefAuditTrail;
    finally
      o.Free;
    end;
  end
  else
    obj.S[aPropName] := aValue;
  j := UtilsClient.Client.SendRequest(meth,obj);
  if Assigned(j) then begin
    try
      if j.Exists('error') then begin
        result := false;
        if j.ObjectExists('error') then
          msg:= j.O['error'].S['message'];
      end;
    finally
      j.Free;
    end;
  end;
end;

function TfrUtilsConfigBase.SetModuleProperty(const aPropName: string;
  aValue: double; var msg: string): boolean;
var
  j, obj, o: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetModuleProperty';
  obj:= JO;
  if Encrypted then begin
    obj.B['Encrypted'] := true;
    o := JO;
    try
      o.F[aPropName] := aValue;
      obj.S['Data'] := CipherUtils.EncryptString(o.AsString);
    finally
      o.Free;
    end;
  end
  else
    obj.F[aPropName] := aValue;
  j := UtilsClient.Client.SendRequest(meth,obj);
  if Assigned(j) then begin
    try
      if j.Exists('error') then begin
        result := false;
        if j.ObjectExists('error') then
          msg:= j.O['error'].S['message'];
      end;
    finally
      j.Free;
    end;
  end;
end;

function TfrUtilsConfigBase.SetModuleProperty(const aPropName: string;
  aValue: boolean; var msg: string): boolean;
var
  j, obj, o: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetModuleProperty';
  obj:= JO;
  if Encrypted then begin
    obj.B['Encrypted'] := true;
    o := JO;
    try
      o.B[aPropName] := aValue;
      obj.S['Data'] := CipherUtils.EncryptString(o.AsString);
    finally
      o.Free;
    end;
  end
  else
    obj.B[aPropName] := aValue;
  j := UtilsClient.Client.SendRequest(meth,obj);
  if Assigned(j) then begin
    try
      if j.Exists('error') then begin
        result := false;
        if j.ObjectExists('error') then
          msg:= j.O['error'].S['message'];
      end;
    finally
      j.Free;
    end;
  end;
end;

function TfrUtilsConfigBase.SetModuleProperty(const aPropName: string;
  aValue: integer; var msg: string): boolean;
var
  val: double;
begin
  val := aValue;
  result := SetModuleProperty(aPropName,val,msg);
end;

procedure TfrUtilsConfigBase.SetUtilsClient(const Value: TUserUtilsClient);
begin
  fUtilsClient := Value;
  if not GetModuleConfig then
    self.Enabled := false;
end;

procedure TfrUtilsConfigBase.ShowLog;
begin
  if Assigned(fOnShowLog) and Assigned(fUtilsClient) then
    fOnShowLog(Self, GetModuleName, fUtilsClient.Client.ServerName);
end;

function TfrUtilsConfigBase.VerifyAndSetModuleConfig: boolean;
var
  j, o: TJsonObject;
  meth: string;
  msg: string;
begin
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetConfig';
  j := UtilsClient.Client.SendRequest(meth,nil);
  if Assigned(j) then begin
    o := JO;
    try
      if j.ObjectExists('result') then begin
        if j.O['result'].BooleanExists('Encrypted') and j.O['result'].B['Encrypted'] then begin
          o.AsString := CipherUtils.DecryptString(j.O['result'].S['Data']);
          Encrypted := true;
        end
        else
          o.Assign(j.O['result']);

        if ValidateConfig and ConfigHasChanged(o,ConfigClean) then begin
          Vista_MessageDlg.MessageDlgXP_Vista('The configuration has been changed (possibly by another user), the new configuration will be loaded and your changes will need to be re-applied.',mtInformation,[mbOk],0);
          result := GetModuleConfig;
        end
        else begin
          result := SetModuleConfig(msg);
          if not result then begin
            if msg <> '' then
              Vista_MessageDlg.MessageDlgXP_Vista('Error sending config info to server: '+ msg,mtInformation,[mbOk],0)
            else
              Vista_MessageDlg.MessageDlgXP_Vista('Error sending config info to server.',mtInformation,[mbOk],0);
          end;
        end;
      end
      else begin
       Vista_MessageDlg.MessageDlgXP_Vista('No response received from ERP Server.',mtInformation,[mbOk],0);
       result := false;
      end;
    finally
      j.Free;
      o.Free;
    end;
  end
  else begin
    Vista_MessageDlg.MessageDlgXP_Vista('No response received from ERP Server.',mtInformation,[mbOk],0);
    result := false;
  end;
end;

end.
