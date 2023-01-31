unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMSpeedButton, AdvScrollBox, StdCtrls, Shader, ImageScroll,
  UserUtilsClientObj, JsonObject, fraUtilsConfigBase, fraUtilsServerConfig,
  fraModUserUtilsConfig;

type
  TfmMain = class(TForm)
    Shader: TShader;
    pnlActiveForm: TLabel;
    btnClose: TDNMSpeedButton;
    imgPrefs: TImage;
    Label2: TLabel;
    sbPrefs: TAdvScrollBox;
    UtilsServerConfig: TfrUtilsServerConfig;
    ImageScroll: TImageScroll;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure InitialiseGUI;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure UtilsServerConfigdtUpdateCheckTimeExit(Sender: TObject);
  private
    SharedUtilsClient: TUserUtilsClient;
    ModuleList: TJSONArray;
    procedure SetScrollBarIncrement;
    procedure DoOnShowLog(Sender: TComponent; ModuleName, ServerName: string);
    function ModuleInModuleList(const aModuleName: string): boolean;
    function ModuleInfo(const aModuleName: string): string;
    procedure LoadModules;
    procedure DoOnLostConnection(Sender: TObject);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  ModuleConst, Vista_MessageDlg, frmModuleLog, fraModWebAPIConfig,
  fraModGoogleConfig, fraModSiteIntegrationConfig, fraModClientServerConfig,
  FileVersion, fraModEBay,
  fraModCustomConfig; { custome server module }

const
  cMaxRange = 6000;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.DoOnLostConnection(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Lost connection with ERP Utilities Service, will now close',mtWarning,[mbOk],0);
  Close;
end;

procedure TfmMain.DoOnShowLog(Sender: TComponent; ModuleName, ServerName: string);
begin
  frmModuleLog.ShowLog(Self, ModuleName, ServerName);
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  if not sbPrefs.Visible then begin
    sbPrefs.Visible := True; // To Stop Ficker on ShowForm
    Update;
    ImageScroll.Image := imgPrefs;
    ImageScroll.ScrollBox := sbPrefs;
    ImageScroll.Enabled := True;
    SetScrollBarIncrement;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  ModuleList := TJSONArray.Create;
  SharedUtilsClient := TUserUtilsClient.Create;
  SharedUtilsClient.OnLostConnection := DoOnLostConnection;
  SharedUtilsClient.Connect('localhost', ERP_ADMIN_USER);
  if not SharedUtilsClient.Connected then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Unable to connect to ERP Utilities Service', mtWarning, [mbOk], 0);
  end
  else begin
    SharedUtilsClient.GetModuleList(ModuleList);
    UtilsServerConfig.UtilsClient := SharedUtilsClient;
  end;
  LoadModules;
  imgPrefs.IncrementalDisplay := True;
  ImageScroll.Image := imgPrefs;
  ImageScroll.ScrollBox := sbPrefs;
  Caption := Caption  + ' (Ver ' + FileVersion.GetFileVersion + ')';
//  ImageScroll.Enabled := True;
//  SetScrollBarIncrement;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  SharedUtilsClient.Free;
  ModuleList.Free;
end;

procedure TfmMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Increment: Integer;
begin
  Handled := True;
  Increment := sbPrefs.VertScrollBar.Increment;

  if WheelDelta < 0 then begin
    if (ImageScroll.ImagePosition + Increment) > imgPrefs.ClientHeight then
      ImageScroll.PerformScroll(imgPrefs.ClientHeight)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition + Increment);
  end
  else begin
    if (ImageScroll.ImagePosition - Increment) < 0 then
      ImageScroll.PerformScroll(0)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition - Increment)
  end;
end;

procedure TfmMain.FormResize(Sender: TObject);
begin
//  sbPrefs.ScrollBy(-sbPrefs.VertScrollBar.Position,0);
//  sbPrefs.VertScrollBar.Position := 0;
//  sbPrefs.HorzScrollBar.Position := 0;
//  Application.ProcessMessages;
//  InitialiseGUI;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
//  if not sbPrefs.Visible then begin
//    sbPrefs.Visible := True; // To Stop Ficker on ShowForm
//    Update;
//    ImageScroll.Image := imgPrefs;
//    ImageScroll.ScrollBox := sbPrefs;
//    ImageScroll.Enabled := True;
//    SetScrollBarIncrement;
//  end;
end;

procedure TfmMain.InitialiseGUI;
var
  x: integer;
  ctl: TControl;
begin
  ctl := nil;
  for x := 0 to sbPrefs.ControlCount - 1 do begin
    if sbPrefs.Controls[x].Visible then begin
      sbPrefs.Controls[x].Enabled := SharedUtilsClient.Client.Connected;
      sbPrefs.Controls[x].Left := 0;
      sbPrefs.Controls[x].Width := sbPrefs.Controls[x].Width + 32;
      if Assigned(ctl) then
        sbPrefs.Controls[x].Top := ctl.Top + ctl.Height
      else
        sbPrefs.Controls[x].Top := 0;

      ctl := sbPrefs.Controls[x];
      if ctl is TfrUtilsConfigBase then
        TfrUtilsConfigBase(ctl).OnShowLog := DoOnShowLog;
    end;
  end;
end;

procedure TfmMain.LoadModules;
var
  lstMods: TStringList;
  x: Integer;
  modName: string;
begin
  lstMods := TStringList.Create;
  sbPrefs.Visible := False;
  try
    lstMods.CaseSensitive := false;
    { load Mod User Utils first }
    lstMods.Add('ERPModUserUtils');
    lstMods.Add('ERPWebService');  // ERPModWebAPI
    lstMods.Add('ERPModGoogle');
    lstMods.Add('ERPModSiteIntegration');
    lstMods.Add('ERPModClientServer');
    lstMods.Add('ERPModEbay');

    for x := 0 to lstMods.Count - 1 do begin
      if ModuleInModuleList(lstMods[x]) then begin
        if SameText(lstMods[x],'ERPModUserUtils') then begin
          with TfrModUserUtilsConfig.Create(self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
            { move this panel to the top }
            UtilsServerConfig.Parent:= nil;
            UtilsServerConfig.Parent := sbPrefs;
          end;
        end
        else if SameText(lstMods[x], 'ERPWebService') then begin
          with TfrModWebAPIConfig.Create(Self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
          end;
        end
        else if SameText(lstMods[x],'ERPModGoogle') then begin
          with TfrModGoogleConfig.Create(self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
          end;
        end
        else if SameText(lstMods[x],'ERPModSiteIntegration') then begin
          with TfrModSiteIntegrationConfig.Create(self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
          end;
        end
        else if SameText(lstMods[x],'ERPModClientServer') then begin
          with TfrModClientServerConfig.Create(self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
          end;
        end
        else if SameText(lstMods[x],'ERPModEbay') then begin
          with TfrModEbay.Create(self) do begin
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
            UtilsClient := SharedUtilsClient;
            OnShowLog := DoOnShowLog;
          end;
        end;
      end;

      // for WebAPI     by Wang
//      if SameText(lstMods[x], 'ERPModWebAPI') then begin
//        with TfrModWebAPIConfig.Create(self) do begin
//          Parent := sbPrefs;
//          SeverModuleInfo.AsString := ModuleInfo(lstMods[x]);
//          UtilsClient := SharedUtilsClient;
//          OnShowLog := DoOnShowLog;
//        end;
//      end

    end;

    { check for custom modules ... }
    for x := 0 to ModuleList.Count - 1 do begin
      modName := ModuleList.Items[x].AsObject.S['ModuleName'];
      if lstMods.IndexOf(modName) < 0 then begin
        { does this module have a gui for the servicemenu }
        if ModuleList.Items[x].AsObject.B['GuiInServiceMenu'] then begin
          lstMods.Add(modName);
          with TfrModCustomConfig.Create(self) do begin
            Name := 'frMod' + modName;
            Parent := sbPrefs;
            SeverModuleInfo.AsString := ModuleList.Items[x].AsObject.AsString;
            UtilsClient := SharedUtilsClient;
            Width := sbPrefs.Width -35;
            if ModuleList.Items[x].AsObject.S['LoggerClassName'] = 'TLogger' then
              OnShowLog := DoOnShowLog;
          end;
        end;
      end;
    end;

    InitialiseGUI;
    ImageScroll.Enabled := False;
    imgPrefs.Picture.Graphic := nil;
  finally
    lstMods.Free;
  end;
end;

function TfmMain.ModuleInfo(const aModuleName: string): string;
var
  x: integer;
begin
  Result := '';
  for x := 0 to ModuleList.Count - 1 do begin
    if SameText(ModuleList.Items[x].AsObject.S['ModuleName'], aModuleName) then begin
      Result := ModuleList.Items[x].AsObject.AsString;
      Exit;
    end;
  end;
end;

function TfmMain.ModuleInModuleList(const aModuleName: String): Boolean;
var
  x: Integer;
begin
  Result := False;
  for x := 0 to ModuleList.Count - 1 do begin
    if SameText(ModuleList.Items[x].AsObject.S['ModuleName'], aModuleName) then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TfmMain.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

procedure TfmMain.UtilsServerConfigdtUpdateCheckTimeExit(Sender: TObject);
begin
  UtilsServerConfig.dtUpdateCheckTimeExit(Sender);

end;

end.
