unit PbxExtensionsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid, SelectionDialog, AppEvnts, DB,  DBAccess,
  MyAccess, DataState, MemDS, Mask, wwdbedit, Wwdotdot, Wwdbcomb, etLine,
  Menus, AdvMenus, Shader;

type
  TPbxExtensionsGUI = class(TBaseInputGUI)
    grdExtensions: TwwDBGrid;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryExtensions: TMyQuery;
    dsExtensions: TDataSource;
    qryExtensionsExtID: TAutoIncField;
    qryExtensionsExtension: TStringField;
    qryExtensionsPC: TStringField;
    qryExtensionsUser: TStringField;
    qryExtensionsActive: TStringField;
    grdExtensionsIButton: TwwIButton;
    lblMonitorSettings: TLabel;
    lblDialingSettings: TLabel;
    grdDialingSettings: TwwDBGrid;
    qryDialingSettings: TMyQuery;
    dsDialingSettings: TDataSource;
    qryDialingSettingsDialingSettingsID: TIntegerField;
    qryDialingSettingsDeviceName: TStringField;
    qryDialingSettingsDeviceAddressID: TWordField;
    qryDialingSettingsPrefix: TStringField;
    qryDialingSettingsUserPCName: TStringField;
    cboDeviceName: TwwDBComboBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grdExtensionsIButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure qryDialingSettingsDeviceAddressIDSetText(Sender: TField; const Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  DnmExceptions, AuditObj,  DNMLib,
  MAIN, CommonLib;

{$R *.dfm}


procedure TPbxExtensionsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TPbxExtensionsGUI.FormShow(Sender: TObject);
begin
  try
    fbTabSettingEnabled := false;
    inherited;
    if qryExtensions.Active then begin
      if not (qryExtensions.State in [dsBrowse]) then begin
        qryExtensions.Post;
        Notify;
      end;
      CloseQueries;
    end;
    qryExtensions.Connection := MainForm.PbxConnection;
    qryExtensions.Open;
    qryDialingSettings.Open;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TPbxExtensionsGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  try
    with qryExtensions do try
        if State <> dsBrowse then begin
          Post;
        end;
      except
        raise;
      end;

    with qryDialingSettings do try
        if State <> dsBrowse then begin
          Post;
        end;
      except
        raise;
      end;

  except
    on e: Exception do begin
      Audit.AddEntry(e, Self);
      raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
    end;
  end;
  Notify;
  self.Close;
end;

procedure TPbxExtensionsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TPbxExtensionsGUI.grdExtensionsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryExtensions);
end;

procedure TPbxExtensionsGUI.FormCreate(Sender: TObject);
Var line : TetLine;
begin
  inherited;
  line := TetLine.Create(self);
  Try
    Line.About.SerialNumber := '301d-o14q-zp1u-46h0';
    Line.Enabled := true;
    cboDeviceName.Items := line.Device.List;
  Finally
    FreeandNil(line);
  end;
end;

procedure TPbxExtensionsGUI.FormDblClick(Sender: TObject);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista(GetPCName, mtInformation , [mbOK], 0);
end;

procedure TPbxExtensionsGUI.qryDialingSettingsDeviceAddressIDSetText(Sender: TField; const Text: String);
begin
  inherited;
  If (StrValue(Text)>65535) then
    Sender.asInteger := 65535
  else
    Sender.asInteger := Trunc(StrValue(Text));
end;

Initialization
  RegisterClassOnce(TPbxExtensionsGUI);

end.
