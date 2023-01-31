unit frmStandAloneConfigBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, JsonObject, UserUtilsClientObj, LogMessageTypes;

type
  TfmStandAloneConfigBase = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    fUtilsClient: TUserUtilsClient;
  protected
    Loading: boolean;
    function Validate: boolean; virtual;
    procedure Log(msg: string; aType: TLogMessageType = ltNone);
  public
    Params: TJsonObject;
    function UtilsClient: TUserUtilsClient;
    procedure LoadParams; virtual;
    procedure SaveParams; virtual;
  end;

implementation

uses
  ModuleConst, Vista_MessageDlg, FileVersion, LogThreadLib;

{$R *.dfm}

procedure TfmStandAloneConfigBase.btnCancelClick(Sender: TObject);
begin
  Params.I['ModalResult'] := mrCancel;
  SaveParams;
  Close;
end;

procedure TfmStandAloneConfigBase.btnSaveClick(Sender: TObject);
begin
  if Validate then begin
    Params.I['ModalResult'] := mrOk;
    SaveParams;
    Close;
  end;
end;

procedure TfmStandAloneConfigBase.FormCreate(Sender: TObject);
begin
  Loading := false;
  Params := JO;
  Caption := Caption + ' Ver: ' + FileVersion.GetFileVersion();
  LoadParams;
  if Params.ObjectExists('Position') then begin
    self.Left := Params.O['Position'].I['Left'];
    self.Top := Params.O['Position'].I['Top'];
  end;
  if Params.IntegerExists('Color') then
    self.Color := Params.I['Color'];
end;

procedure TfmStandAloneConfigBase.FormDestroy(Sender: TObject);
begin
  Params.Free;
  fUtilsClient.Free;
end;

procedure TfmStandAloneConfigBase.LoadParams;
var
  fileName: string;
begin
  fileName := ChangeFileExt(Application.ExeName,'_Params.txt');
  if FileExists(fileName) then
    Params.LoadFromFile(fileName);
end;

procedure TfmStandAloneConfigBase.Log(msg: string; aType: TLogMessageType);
begin
  TLogger.Inst.Log(msg,aType);
end;

procedure TfmStandAloneConfigBase.SaveParams;
var
  fileName: string;
begin
  fileName := ChangeFileExt(Application.ExeName,'_Params.txt');
  Params.SaveToFile(fileName);
end;

function TfmStandAloneConfigBase.UtilsClient: TUserUtilsClient;
begin
  if not Assigned(fUtilsClient) then begin
    fUtilsClient := TUserUtilsClient.Create;
    try
      if Params.StringExists('ERPUtilsServer') then
        fUtilsClient.Connect(Params.S['ERPUtilsServer'],ERP_ADMIN_USER)
      else
        fUtilsClient.Connect('localhost',ERP_ADMIN_USER);
    except
      on e: exception do begin
        Vista_MessageDlg.MessageDlgXP_Vista('Error connecting to the ERP Utilities Service with message: ' + e.Message,mtError,[mbOk],0);
      end;
    end;
  end;
  result := fUtilsClient;
end;

function TfmStandAloneConfigBase.Validate: boolean;
begin
  result := true;
end;

end.
