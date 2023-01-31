unit frmMobileNumberInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton;

type
  TfmMobileNumberInput = class(TBaseInputGUI)
    Label1: TLabel;
    edtNumber: TEdit;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblMessage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    function ValidateData: boolean;
  public
    Conn: TMyConnection;
  end;

  function GetMobileNumberFromUser(const msg: string; number: string = ''; aConn: TMyConnection = nil): string;

implementation

uses
  AppEnvironment, SMSUtils, CommonLib;

{$R *.dfm}

function GetMobileNumberFromUser(const msg: string; number: string = ''; aConn: TMyConnection = nil): string;
var
  form: TfmMobileNumberInput;
begin
  result := '';
  form := TfmMobileNumberInput.Create(nil);
  form.Conn := aConn;
  if not Assigned(form.Conn) then
    form.Conn := form.MyConnection;
  try
    form.lblMessage.Caption := msg;
    form.edtNumber.Text := number;
    if form.ShowModal = mrOk then
      result := form.edtNumber.Text;


  finally
    form.Free;
  end;
end;

procedure TfmMobileNumberInput.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateData then
    ModalResult := mrOk;
end;

procedure TfmMobileNumberInput.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumber.Text := '+' +  IntToStr(AppEnv.RegionalOptions.ISDCode);
//  edtNumber.SelStart := Length(edtNumber.Text);
end;

function TfmMobileNumberInput.ValidateData: boolean;
begin
  result := false;
  if edtNumber.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a valid number prefixed with "+" and the country code.',mtInformation,[mbOk],0);
    exit;
  end;
  if (not SMSUtils.NumberHasPlusPrefix(edtNumber.Text)) or (not smsutils.NumberHasCountryCode(edtNumber.Text,Conn)) then begin
    CommonLib.MessageDlgXP_Vista('Please ensure the number is prefixed with "+" and the country code.',mtInformation,[mbOk],0);
    exit;
  end;

  result := true;
end;

end.
