unit fraModUserUtilsConfigBasic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, DNMSpeedButton, StdCtrls, wwclearbuttongroup,
  wwradiogroup, ExtCtrls, JsonObject;

type
  TfrModUserUtilsConfigBasic = class(TfrUtilsConfigBase)
    Bevel1: TBevel;
    Label9: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    btnLogFile: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
    function ConfigHasChanged(newConfig, cleanConfig: TJsonObject): boolean; override;
    function GetModuleConfig: boolean; override;
    function SetModuleConfig(var msg: string): boolean; override;
    function VerifyAndSetModuleConfig: boolean; override;
  public
    { Public declarations }
  end;

var
  frModUserUtilsConfigBasic: TfrModUserUtilsConfigBasic;

implementation

uses
  LogMessageTypes, Vista_MessageDlg, UpdateStoreObj, DB, SystemLib;

{$R *.dfm}

procedure TfrModUserUtilsConfigBasic.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
end;

procedure TfrModUserUtilsConfigBasic.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

function TfrModUserUtilsConfigBasic.ConfigHasChanged(newConfig,
  cleanConfig: TJsonObject): boolean;
begin
  result := inherited;
end;

procedure TfrModUserUtilsConfigBasic.DNMSpeedButton1Click(Sender: TObject);
var
  UpdateStore: TUpdateStore;
  ds: TDataSet;
  msg: string;
  path: string;
  Params, Cfg, J: TJsonObject;
  meth: string;
  obj: TJsonObject;
begin
  inherited;
  UpdateStore := TUpdateStore.Create;
  Params := JO;
  Cfg := JO;
  try
    meth := ModuleName;
    if meth <> '' then
      meth := meth + '.';
    meth := meth + 'GetConfig';
    j := UtilsClient.Client.SendRequest(meth,nil);
    if Assigned(j) then begin
      try
        if j.ObjectExists('result') then begin
          Cfg.Assign(j.O['result']);
        end;
      finally
        j.Free;
      end;
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista('Could not read configuration from ERP utilities Service.',mtWarning,[mbOk],0);
      exit;
    end;
    Params.S['OffsiteBackupConfigText'] := Cfg.S['OffsiteBackupConfigText'];
    Params.S['OffsiteRestoreConfigText'] := Cfg.S['OffsiteRestoreConfigText'];
    Params.S['ERPUtilsServer'] := self.UtilsClient.Client.ServerName;

    path := ExtractFilePath(Application.ExeName);
    if Assigned(owner) and Assigned(Owner.Owner) and (Owner.Owner is TForm) then begin
      Params.I['color'] := TForm(Owner.Owner).Color;
      Params.O['Position'].I['left'] := TForm(Owner.Owner).Left;
      Params.O['Position'].I['top'] := TForm(Owner.Owner).top;
    end;

    Params.SaveToFile(Path + 'OffSiteBackupConfig_Params.txt');
    UpdateStore.Server := UtilsClient.Client.ServerName;
    ds := UpdateStore.VersionUpdates('OffsiteBackupConfig','','');
    TBlobField(ds.FieldByName('File')).SaveToFile(path +'OffsiteBackupConfig.exe');
    ExecNewWinProcess(path +'OffsiteBackupConfig.exe', true, msg);
    if Assigned(owner) and Assigned(Owner.Owner) and (Owner.Owner is TForm) then begin
      TForm(Owner.Owner).BringToFront;
      TForm(Owner.Owner).SetFocus;
    end;

    { read back results when user has closed config form }
    Params.LoadFromFile(Path + 'OffSiteBackupConfig_Params.txt');
    if Params.I['ModalResult'] = mrOk then begin

      Cfg.S['OffsiteBackupConfigText'] := Params.S['OffsiteBackupConfigText'];
      Cfg.S['OffsiteRestoreConfigText'] := Params.S['OffsiteRestoreConfigText'];

      meth := ModuleName;
      if meth <> '' then
        meth := meth + '.';
      meth := meth + 'SetConfig';
      obj:= JO;
      obj.Assign(Cfg);
      j := UtilsClient.Client.SendRequest(meth,obj);
      if Assigned(j) then begin
        try
          if j.Exists('error') then begin
            if j.ObjectExists('error') then
              msg:= j.O['error'].S['message'];
            Vista_MessageDlg.MessageDlgXP_Vista('Could not update configuration on ERP utilities Service '+ msg,mtWarning,[mbOk],0);
          end;
        finally
          j.Free;
        end;
      end;

    end;

  finally
    UpdateStore.Free;
    Params.Free;
    Cfg.Free;
  end;
end;

function TfrModUserUtilsConfigBasic.GetModuleConfig: boolean;
var
  j: TJsonObject;
  meth: string;
begin
  result := false;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetLoggingLevel';

  j := UtilsClient.Client.SendRequest(meth,nil);
  if Assigned(j) then begin
    try
      if j.ObjectExists('result') then begin
        Config.Assign(j.O['result']);
        ConfigClean.Assign(j.O['result']);
        result := true;
        Loading := true;
        try
          AfterGetModuleConfig;
        finally
          Loading := false;
        end;
      end;
    finally
      j.Free;
    end;
  end;
  if not result then exit;

end;

function TfrModUserUtilsConfigBasic.GetModuleName: string;
begin
  result := 'ERPModUserUtils';
end;

procedure TfrModUserUtilsConfigBasic.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;

function TfrModUserUtilsConfigBasic.SetModuleConfig(var msg: string): boolean;
var
  j, obj: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetLoggingLevel';
  obj:= JO;
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

function TfrModUserUtilsConfigBasic.VerifyAndSetModuleConfig: boolean;
var
  j: TJsonObject;
  meth: string;
  msg: string;
begin
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetLoggingLevel';
  j := UtilsClient.Client.SendRequest(meth,nil);
  if Assigned(j) then begin
    try
      if j.ObjectExists('result') then begin
        if ConfigHasChanged(j.O['result'],ConfigClean) then begin
          Vista_MessageDlg.MessageDlgXP_Vista('The configuration has been changed (possibly by another user), the new configuration will be loaded and your changes will need to be re-applied.',mtInformation,[mbOk],0);
          result := GetModuleConfig;
        end
        else begin
          result := SetModuleConfig(msg);
          if (not result) and (msg <> '') then
            Vista_MessageDlg.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);

        end;
      end
      else begin
       result := false;
      end;
    finally
      j.Free;
    end;
  end
  else begin
    result := false;
  end;
end;

end.
