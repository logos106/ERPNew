unit frmConfigBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Shader, ExtCtrls, DNMPanel, DNMSpeedButton, StdCtrls , JSONObject , UserUtilsClientObj;

type
  TfmConfigBase = class(TForm)
    Label1: TLabel;
    chkActive: TCheckBox;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnSaveClick(Sender: TObject);
  private
    fUtilsClient: TUserUtilsClient;

  Protected
    ConfigObj , Config:TJsonObject;
    //function MakeinStance :TfmConfigBase;virtual;abstract;
    Procedure initIt(form :TfmConfigBase);virtual;abstract;
    Procedure SaveIt(form :TfmConfigBase);virtual;abstract;
    function ValidateData:Boolean;virtual;abstract;
  public
    property UtilsClient: TUserUtilsClient read fUtilsClient write fUtilsClient;
    function DoConfig(Obj, fconfig: TJsonObject;xUtilsClient: TUserUtilsClient): boolean; Virtual;
  end;


implementation


{$R *.dfm}

{ TfmConfigBase }

procedure TfmConfigBase.btnSaveClick(Sender: TObject);
begin
  if ValidateData then
    ModalResult:= mrOK;
end;

function TfmConfigBase.DoConfig(Obj, fconfig: TJsonObject;xUtilsClient: TUserUtilsClient): boolean;
begin
    REsult:= False;
    ConfigObj          := Obj;
    Config             := fConfig;
    UtilsClient        := xUtilsClient;
    initIt(Self);
    if ShowModal = mrOk then begin
      Result:= True;
      SaveIt(Self);
    end;
end;

end.

