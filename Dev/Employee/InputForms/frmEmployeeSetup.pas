unit frmEmployeeSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseSetup, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DNMSpeedButton, Shader, DNMPanel, StdCtrls, ComCtrls;

type
  TfmEmployeeSetup = class(TfmBaseSetup)
    pnlPreferences: TDNMPanel;
    lblPreferencesNotes: TLabel;
    Label3: TLabel;
    pnlPreferenceswf: TDNMPanel;
    Shader2: TShader;
    lblPreferenceWorkflow: TLabel;
    pnlPreferencesaction: TDNMPanel;
    Shader5: TShader;
    lblPreferences: TLabel;
    pnlPayrollInfo: TDNMPanel;
    lblpnlPayrollInfoNote: TLabel;
    Label17: TLabel;
    pnlPayrollInfoAction: TDNMPanel;
    Shader9: TShader;
    Label18: TLabel;
    pnlpnlPayrollInfoWF: TDNMPanel;
    Shader10: TShader;
    Label19: TLabel;
    pnlPayrollSetup: TDNMPanel;
    lblPreferencesNote: TLabel;
    Label5: TLabel;
    btnPreferences: TDNMPanel;
    Shader1: TShader;
    lblPayrollSetup: TLabel;
    btnPreferencesWF: TDNMPanel;
    Shader6: TShader;
    Label11: TLabel;
    pnlEmployee: TDNMPanel;
    lblEmployeeNote: TLabel;
    Label7: TLabel;
    pnlEmployeeAction: TDNMPanel;
    Shader3: TShader;
    lblEmployee: TLabel;
    pnlEmployeeWF: TDNMPanel;
    Shader4: TShader;
    lblEmployeeWorkFlow: TLabel;
    procedure lblPreferencesClick(Sender: TObject);
    procedure lblEmployeeClick(Sender: TObject);
    procedure lblPayrollSetupClick(Sender: TObject);
    procedure lblPreferenceWorkflowClick(Sender: TObject);
    procedure lblEmployeeWorkFlowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
  private
  protected
  public
    { Public declarations }
  end;

implementation

uses
  CommonFormLib, CommonLib, tcDataUtils, Preferences, tcConst;

{$R *.dfm}

procedure TfmEmployeeSetup.FormCreate(Sender: TObject);
begin
  inherited;
  InitDescLabel(pnlEmployee , pnlEmployeeAction, pnlEmployeeWF , lblEmployeeNote ,'If you want to use TrueERP Payroll enable the Payroll module in Preferences.');
  InitDescLabel(pnlPayrollSetup , btnPreferences , btnPreferencesWF , lblPreferencesNote , 'Create a new Employee and setup basic info such as Name. Start Date, Address etc.');
  InitDescLabel(pnlPayrollInfo , pnlPayrollInfoAction , pnlpnlPayrollInfoWF , lblpnlPayrollInfoNote  , 'If you are using Payroll go to "Setup Payroll"');
  InitDescLabel(pnlPreferences,pnlPreferencesaction , pnlPreferenceswf , lblPreferencesNotes , 'Fill in the new Employee''s Payroll specific data including Banking, Taxation etc.');
  pnlPayrollInfoAction.visible := False;
end;

procedure TfmEmployeeSetup.Label11Click(Sender: TObject);begin  inherited;  Playworkflow('Setup Payroll');end;
procedure TfmEmployeeSetup.Label19Click(Sender: TObject);begin  inherited;  Playworkflow('Add Payroll Details');end;
procedure TfmEmployeeSetup.lblEmployeeClick(Sender: TObject);begin  inherited;  OpenERPForm('TfrmEmployee',0);end;
procedure TfmEmployeeSetup.lblEmployeeWorkFlowClick(Sender: TObject);begin  inherited;  Playworkflow('Setup Employee');end;
procedure TfmEmployeeSetup.lblPayrollSetupClick(Sender: TObject);begin  inherited;  OpenERPForm('TfmSetupPayroll',0);end;
procedure TfmEmployeeSetup.lblPreferencesClick(Sender: TObject);begin inherited;  OpenPrefform('Utilities' ,  'pnlEnabledModules', 0 , True , 'Payroll');end;
procedure TfmEmployeeSetup.lblPreferenceWorkflowClick(Sender: TObject);begin  inherited;  Playworkflow('Enable Payroll');end;

procedure TfmEmployeeSetup.Label18Click(Sender: TObject);
var
  Form : TComponent;
begin
  inherited;
  if FormStillOpen('TfrmEmployee') then begin
     Form :=  FindExistingComponent('TfrmEmployee');
     TForm(Form).BringtoFront;
     exit;
  end;
end;

initialization
  RegisterClass(TfmEmployeeSetup);

end.
