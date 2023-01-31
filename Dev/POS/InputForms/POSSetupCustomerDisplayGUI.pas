unit POSSetupCustomerDisplayGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, MemDS, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, wwdbedit,
  Wwdotdot, Wwdbcomb, Mask, DBCtrls, wwcheckbox, Wwdbspin, ActnList,
  DataState, Menus, AdvMenus, Shader;

type
  TSetupCustomerDisplayGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryTills: TERPQuery;
    EnableCustDisplay: TwwCheckBox;
    EnableCustDisplaylbl: TLabel;
    EnablePPSaver: TwwCheckBox;
    EnablePPlbl: TLabel;
    DSTills: TDataSource;
    pnlPPSettings: TDNMPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label69: TLabel;
    Label6: TLabel;
    txtPath: TDBEdit;
    cbxTransitionEffect: TwwDBComboBox;
    cbxTransitionSpeed: TwwDBComboBox;
    SpeedButton1: TDNMSpeedButton;
    Label7: TLabel;
    edtAdvanceTime: TwwDBSpinEdit;
    IdleWait: TwwDBSpinEdit;
    Label8: TLabel;
    SaveDialog1: TSaveDialog;
    ActionList1: TActionList;
    DisplayRefresh: TAction;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DisplayRefreshUpdate(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshSetupDisplay;
  public
    { Public declarations }
        
  end;

var
  SetupCustomerDisplayGUI: TSetupCustomerDisplayGUI;

implementation
  
uses CommonLib, Forms;
{$R *.dfm}

procedure TSetupCustomerDisplayGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSetupCustomerDisplayGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if (qryTills.FieldByName('EnablePPScreenSaver').AsString = 'F') or
    ((qryTills.FieldByName('EnablePPScreenSaver').AsString = 'T') and FileExists(qryTills.FieldByName('PPPathFileName').AsString)) then
  begin
    if (qryTills.FieldByName('EnablePPScreenSaver').AsString = 'F') or
      ((qryTills.FieldByName('EnablePPScreenSaver').AsString = 'T') and (qryTills.FieldByName('IdleWait').AsInteger > 0)) then
    begin
      if (qryTills.FieldByName('EnablePPScreenSaver').AsString = 'F') or
        ((qryTills.FieldByName('EnablePPScreenSaver').AsString = 'T') and (qryTills.FieldByName('PPSlideCycle').AsInteger > 0)) then
      begin
        qryTills.Post;
        Self.ModalResult := mrOk;
      end else begin
        CommonLib.MessageDlgXP_Vista('Cannot Be Zero(0) !', mtWarning, [mbOK], 0);
        SetControlFocus(edtAdvanceTime);
        Exit;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Cannot Be Zero(0) !', mtWarning, [mbOK], 0);
      SetControlFocus(IdleWait);
      Exit;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('PowerPoint File Does Not Exist !', mtWarning, [mbOK], 0);
    SetControlFocus(txtPath);
    Exit;      
  end;
end;

procedure TSetupCustomerDisplayGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryTills.Close;
    qryTills.Params.ParamByName('xTillID').AsInteger := KeyID;
    qryTills.Open;
    qryTills.Edit;
  finally
    EnableForm;
  end;  
end;

procedure TSetupCustomerDisplayGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TSetupCustomerDisplayGUI.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if SaveDialog1.Execute then begin
    qryTills.FieldByName('PPPathFileName').AsString := SaveDialog1.FileName;
  end;
end;

procedure TSetupCustomerDisplayGUI.RefreshSetupDisplay;
begin
  EnableCustDisplay.Enabled := true;
  EnablePPSaver.Enabled := EnableCustDisplay.Checked;
  EnablePPlbl.Enabled := EnablePPSaver.Enabled;
  pnlPPSettings.Enabled := EnablePPSaver.Checked;
  Label7.Enabled := EnablePPSaver.Checked;
  IdleWait.Enabled := EnablePPSaver.Checked;
  Label8.Enabled := EnablePPSaver.Checked;
  Label1.Enabled := EnablePPSaver.Checked;
  cbxTransitionEffect.Enabled := EnablePPSaver.Checked;
  Label4.Enabled := EnablePPSaver.Checked;
  cbxTransitionSpeed.Enabled := EnablePPSaver.Checked;
  Label6.Enabled := EnablePPSaver.Checked;
  edtAdvanceTime.Enabled := EnablePPSaver.Checked;
  Label3.Enabled := EnablePPSaver.Checked;
  Label69.Enabled := EnablePPSaver.Checked;
  txtPath.Enabled := EnablePPSaver.Checked;
  SpeedButton1.Enabled := EnablePPSaver.Checked;
end;

procedure TSetupCustomerDisplayGUI.DisplayRefreshUpdate(Sender: TObject);
begin
  inherited;
  RefreshSetupDisplay;
end;

initialization
  RegisterClassOnce(TSetupCustomerDisplayGUI);

end.
