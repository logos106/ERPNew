unit frmClientsOtherPhonesGUI;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/12/05  1.00.01 AL   Initial Version
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, Grids, Wwdbigrd, Wwdbgrid,
  MemDS, StdCtrls, Buttons, DNMSpeedButton, Menus, AdvMenus, Shader,
  ProgressDialog, ImgList;

type
  TfrmClientsOtherPhone = class(TBaseInputGUI)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryOtherPhones: TERPQuery;
    dsOtherPhones: TDataSource;
    grdOtherPhones: TwwDBGrid;
    qryOtherPhonesClientsOtherPhonesID: TIntegerField;
    qryOtherPhonesPhone: TWideStringField;
    qryOtherPhonesComment: TWideStringField;
    pnlBackground: TDNMPanel;
    qryOtherPhonesClientID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure qryOtherPhonesBeforePost(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdOtherPhonesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmClientsOtherPhone: TfrmClientsOtherPhone;

implementation

uses
  CommonLib, AppEnvironment, CyTrackObj;

{$R *.dfm}

procedure TfrmClientsOtherPhone.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryOtherPhones.ParamByName('KeyID').AsInteger := KeyID;
    BeginTransaction;
    qryOtherPhones.Open;
  finally
    EnableForm;
  end;
end;

procedure TfrmClientsOtherPhone.grdOtherPhonesDblClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  if AppEnv.CompanyPrefs.CyTrackIntegrationEnabled and AppEnv.Employee.CyTrackIntegrationEnabled then begin
    if not TCyTrack.Inst.Connected then begin
      CommonLib.MessageDlgXP_Vista('ERP is not connected to CyDesk, make sure CyDesk is running and ERP CyTrack preference settings are correct.',mtInformation,[mbOk],0);
      exit;
    end;

    s := qryOtherPhonesPhone.AsString;
    s := Trim(ReplaceStr(s,'(',''));
    s := ReplaceStr(s,')','');
    s := ReplaceStr(s,' ','');
    if s <> '' then begin
      if SameText(TCyTrack.Inst.Status,'Idle') then
        TCyTrack.Inst.MakeCall(s)
      else
       CommonLib.MessageDlgXP_Vista('CyDesk is not ready to make a call, current status is "' + TCyTrack.Inst.Status + '"',mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TfrmClientsOtherPhone.qryOtherPhonesBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  qryOtherPhones.FieldByName('ClientID').AsInteger := KeyID;
end;

procedure TfrmClientsOtherPhone.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfrmClientsOtherPhone.btnOkClick(Sender: TObject);
begin
  inherited;
  if qryOtherPhones.State in [dsEdit, dsInsert] then begin
    qryOtherPhones.Post;
  end;
  CommitTransaction;
  Close;
end;

procedure TfrmClientsOtherPhone.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TfrmClientsOtherPhone);

end.
