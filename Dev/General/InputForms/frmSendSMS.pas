unit frmSendSMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel;

type
  TfmSendSMS = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSend: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtPhoneNumber: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtMessage: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    function ValidateData: boolean;
  public
    { Public declarations }
  end;

var
  fmSendSMS: TfmSendSMS;

implementation

uses
  CommonLib, BusObjCorrespondence, BusObjBase;

{$R *.dfm}


procedure TfmSendSMS.btnCancelClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfmSendSMS.btnSendClick(Sender: TObject);
var
  Corres: TCorrespondence;
begin
  inherited;
  if not ValidateData then exit;
  Corres:= TCorrespondence.Create(nil);
  try
    Corres.Connection := TMyDacDataConnection.Create(Corres);
    Corres.Connection.Connection := MyConnection;
    self.BeginTransaction;
    try
      Corres.Load(0);
      Corres.New;
      Corres.Ref_Type := 'SMS';
      Corres.Ref_Date := now;
      Corres.MessageTo := edtPhoneNumber.Text;
      Corres.ReferenceTxt := Copy(edtMessage.Text,1,50);
      Corres.Status := 'Waiting';
      Corres.SMS.Format := 'SMS';
      Corres.SMS.Status := 'Waiting';
      Corres.SMS.PhoneNumber := edtPhoneNumber.Text;
      Corres.SMS.Content := edtMessage.Text;

      if Corres.Save then begin
        self.CommitTransaction;
        Close;
      end
      else begin
        CommonLib.MessageDlgXP_Vista(Corres.ResultStatus.Messages,mtInformation,[mbOk],0);
        exit;
      end;
    finally
      Self.RollbackTransaction;
    end;

  finally
    Corres.Free;
  end;
end;

procedure TfmSendSMS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TfmSendSMS.ValidateData: boolean;
begin
  result := false;
  if edtPhoneNumber.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a phone number to send the message to.',mtInformation,[mbOk],0);
    exit;
  end;
  if edtMessage.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a message.',mtInformation,[mbOk],0);
    exit;
  end;
  result := true;
end;

initialization
  RegisterClass(TfmSendSMS)

end.
