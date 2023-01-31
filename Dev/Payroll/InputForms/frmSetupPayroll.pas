unit frmSetupPayroll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, frmBaseSetup;

type
  TfmSetupPayroll = class(TfmBaseSetup)
    pnlTaxScales: TDNMPanel;
    lblTaxScalesNotes: TLabel;
    Label4: TLabel;
    pnlTaxScalesWF: TDNMPanel;
    Shader2: TShader;
    lblWorkFlow: TLabel;
    pnlTaxScalesAction: TDNMPanel;
    Shader5: TShader;
    lblGoThere: TLabel;
    pnlSetupEmployee: TDNMPanel;
    lblSetupEmployeeNotes: TLabel;
    Label6: TLabel;
    pnlSetupPayrollWF: TDNMPanel;
    Shader1: TShader;
    Label7: TLabel;
    pnlSetupEmployeeAction: TDNMPanel;
    Shader3: TShader;
    Label8: TLabel;
    pnlPayroll: TDNMPanel;
    lblPayrollNotes: TLabel;
    Label14: TLabel;
    pnlPayrollWF: TDNMPanel;
    Shader7: TShader;
    Label15: TLabel;
    pnlPayrollAction: TDNMPanel;
    Shader8: TShader;
    Label16: TLabel;
    pnlPayrollAccounts: TDNMPanel;
    lblPayrollAccountsNotes: TLabel;
    Label2: TLabel;
    pnlPayrollAccountsWF: TDNMPanel;
    Shader4: TShader;
    Label3: TLabel;
    pnlPayrollAccountsAction: TDNMPanel;
    Shader6: TShader;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lblGoThereClick(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure lblWorkFlowClick(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  private
  protected
  public
    { Public declarations }
  end;

implementation

uses
  CommonFormLib, Preferences, tcDataUtils, CommonLib, frmWorkflowPlay;

{$R *.dfm}

procedure TfmSetupPayroll.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSetupPayroll.FormCreate(Sender: TObject);
begin
  inherited;
  Height := Height - mem_Note.Height;
  InitDescLabel(pnlTaxScales , pnlTaxScalesAction, pnlTaxScalesWF, lblTaxScalesNotes ,'Check that you have the necessary tax scales to suit all your employees and the figures are correct for the current financial year.  Double click on a scale to open it or click New to create a new Scale.',true);
  InitDescLabel(pnlPayroll, pnlPayrollaction, pnlPayrollwf, lblPayrollNotes, 'Check that you have the necessary tax types to suit your region. Double click to edit/view existing tax''s. Click on the New button to create a new Tax. ',true);
  InitDescLabel(pnlPayrollAccounts, pnlPayrollAccountsaction, pnlPayrollAccountswf, lblPayrollAccountsNotes , 'Assign the appropriate GL Account to each of the Payroll Accounts.',true);
  InitDescLabel(pnlSetupEmployee, pnlSetupEmployeeAction, pnlSetupPayrollWF, lblSetupEmployeeNotes , 'Setup Payroll for each Employee.',true);
end;

procedure TfmSetupPayroll.Label15Click(Sender: TObject);
begin
  inherited;
  Playworkflow('Setup Payroll Tax');
end;

procedure TfmSetupPayroll.Label16Click(Sender: TObject);
begin
  inherited;
  OpenPrefform('Payroll' ,  'pnlAccounts', 0 , True , 'Tax Accounts');
end;

procedure TfmSetupPayroll.Label7Click(Sender: TObject);
begin
  inherited;
  Playworkflow('Setup Payroll Tax Accounts');
end;

procedure TfmSetupPayroll.Label8Click(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmEmployeeSetup',0);
end;

procedure TfmSetupPayroll.Label5Click(Sender: TObject);
begin
  inherited;
  OpenPrefform('Payroll' ,  'pnlAccounts', 0 , True , 'Gross Wages');
end;

procedure TfmSetupPayroll.lblGoThereClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TTaxScaleList');
end;

procedure TfmSetupPayroll.lblWorkFlowClick(Sender: TObject);
begin
  inherited;
  Playworkflow('Setup Tax Scales');
end;


initialization
  RegisterClass(TfmSetupPayroll);

end.
