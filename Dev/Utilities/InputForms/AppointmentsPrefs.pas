unit AppointmentsPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls, MessageConst,
  Mask, wwdbedit, ExtCtrls, DNMPanel, MemDS, wwcheckbox, Wwdbspin,
  wwclearbuttongroup, wwradiogroup, DBCtrls, frmBase, BasePrefs, wwdblook, Menus,
  DNMSpeedButton, AdvScrollBox, Wwdotdot, Wwdbcomb, ErpTimeCombo;

type
  TAppointmentsPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryPhoneSupport: TERPQuery;
    dsPhoneSupport: TDataSource;
    qryPhoneSupportPhoneSupportPeriodNo1: TWideStringField;
    qryPhoneSupportPhoneSupportAmountNo1: TFloatField;
    qryPhoneSupportPhoneSupportPeriodNo2: TWideStringField;
    qryPhoneSupportPhoneSupportAmountNo2: TFloatField;
    qryPhoneSupportPhoneSupportPeriodNo3: TWideStringField;
    qryPhoneSupportPhoneSupportAmountNo3: TFloatField;
    qryPhoneSupportPhoneSupportPeriodNo4: TWideStringField;
    qryPhoneSupportPhoneSupportAmountNo4: TFloatField;
    qrymodules: TERPQuery;
    DNMPanel1: TDNMPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    DNMPanel2: TDNMPanel;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    wwCheckBox2: TwwCheckBox;
    wwDBEdit9: TwwDBEdit;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label12: TLabel;
    wwCheckBox4: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label13: TLabel;
    wwCheckBox6: TwwCheckBox;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label14: TLabel;
    lblCallsIn: TLabel;
    lblDaysTrigger: TLabel;
    lblPopupMessage: TLabel;
    Label15: TLabel;
    sdtSupportNumOfCalls: TwwDBSpinEdit;
    sdtSupportPeriodInDays: TwwDBSpinEdit;
    chkSupportPopup: TwwCheckBox;
    memoPopupMessage: TDBMemo;
    wwCheckBox5: TwwCheckBox;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwCheckBox7: TwwCheckBox;
    chkUseSupportEmail: TwwCheckBox;
    btnEmailConfig: TDNMSpeedButton;
    bntEmailTasks: TDNMSpeedButton;
    btnEmailGoLive: TDNMSpeedButton;
    QryProduct: TERPQuery;
    pnlDefaultApptSettings: TDNMPanel;
    Bevel6: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    txtStartTime: TErpDbTimeCombo;
    txtEndTime: TErpDbTimeCombo;
    cboDefaultApptDuration: TwwDBComboBox;
    cboShowApptDurationin: TwwDBComboBox;
    wwDBLookupCombo2: TwwDBLookupCombo;
    Label18: TLabel;
    Start_Time_Label: TLabel;
    End_Time_Label: TLabel;
    Label21: TLabel;
    Bevel7: TBevel;
    chkSunday: TwwCheckBox;
    chkWednesday: TwwCheckBox;
    chkSaturday: TwwCheckBox;
    chkMonday: TwwCheckBox;
    chkThursday: TwwCheckBox;
    chkTuesday: TwwCheckBox;
    chkFriday: TwwCheckBox;
    lblRoundApptDurationTo: TLabel;
    cboRoundApptDurationTo: TwwDBComboBox;
    procedure chkSupportPopupClick(Sender: TObject);
    procedure btnEmailConfigClick(Sender: TObject);
    procedure chkUseSupportEmailClick(Sender: TObject);
    procedure bntEmailTasksClick(Sender: TObject);
    procedure btnEmailGoLiveClick(Sender: TObject);
    procedure qryPhoneSupportAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
    procedure StartupProcess(var Msg: TMessage); Override;
    procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, BusObjEmailConfig, CommonDbLib, frmEmailConfig2, frmExtraEmails,
  PreferancesLib;

{ TAppointmentsPrefsGUI }


procedure TAppointmentsPrefsGUI.qryPhoneSupportAfterPost(DataSet: TDataSet);
begin
  inherited;
  PreferancesLib.DoPrefAuditTrail;
end;


procedure TAppointmentsPrefsGUI.bntEmailTasksClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfmExtraEmails');

  if not Assigned(tmpComponent) then
    Exit;

  TfmExtraEmails(tmpComponent).Title := 'Tasks Extra Emails';
  TfmExtraEmails(tmpComponent).Task := 'Tasks';
  with TForm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TAppointmentsPrefsGUI.btnEmailConfigClick(Sender: TObject);
var
  Config: TEmailConfig;
begin
  inherited;
  Config := TEmailConfig.CreateWithNewConn(nil);
  try
    Config.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    Config.LoadSelect('EntityName = "Support"');
    if Config.Count = 0 then begin
      Config.New;
      Config.EntityName := 'Support';
      Config.PostDb;
    end;

    if frmEmailConfig2.DoEmailConfig(Config) then begin
//      if not SameText(edtEmail.Text,Config.EmailAddress) then
//        edtEmail.Text := Config.EmailAddress;
//      if not Config.ConfigValid then
//        chkTrackEmails.Checked := false;
    end;
  finally
    Config.Free;
  end;
end;

procedure TAppointmentsPrefsGUI.btnEmailGoLiveClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfmExtraEmails');

  if not Assigned(tmpComponent) then
    Exit;

  TfmExtraEmails(tmpComponent).Title := 'GoLive Extra Emails';
  TfmExtraEmails(tmpComponent).Task := 'GoLive';
  with TForm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TAppointmentsPrefsGUI.chkSupportPopupClick(Sender: TObject);
begin
  sdtSupportNumOfCalls.Enabled := chkSupportPopup.Checked;
  lblCallsIn.Enabled := chkSupportPopup.Checked;
  sdtSupportPeriodInDays.Enabled := chkSupportPopup.Checked;
  lblDaysTrigger.Enabled := chkSupportPopup.Checked;
  lblPopupMessage.Enabled := chkSupportPopup.Checked;
  memoPopupMessage.Enabled := chkSupportPopup.Checked;
end;

procedure TAppointmentsPrefsGUI.chkUseSupportEmailClick(Sender: TObject);
begin
  inherited;
  btnEmailConfig.Enabled := chkUseSupportEmail.Checked;
end;
procedure TAppointmentsPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TAppointmentsPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  btnEmailConfig.Enabled := chkUseSupportEmail.Checked;
end;
procedure TAppointmentsPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TAppointmentsPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryPhoneSupport.State in [dsEdit, dsInsert] then
    qryPhoneSupport.Post;
end;

procedure TAppointmentsPrefsGUI.FormCreate(Sender: TObject);
Procedure Populatehourscombo(cbo: TwwDBComboBox);
var
  ctr:Integer;
  fd :Double;
begin
  with cbo do begin
    Items.clear;
    for ctr:= 1 to 24 do begin
      fd:=round(ctr/2,1);
      Items.add(FloattostrF(fd, ffGeneral, 15,2)+' Hour(s)'#9+''+inttostr(trunc(fd*60))+'');
    end;
  end;
end;
begin
  inherited;
  Populatehourscombo(cboDefaultApptDuration);
  Populatehourscombo(cboRoundApptDurationTo);
  Populatehourscombo(cboShowApptDurationin);
end;

initialization
  RegisterClassOnce(TAppointmentsPrefsGUI);
finalization
  UnRegisterClass(TAppointmentsPrefsGUI);
end.
