unit HireProjectPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DataSourcePrefs, DBAccess, MyAccess, StdCtrls, wwcheckbox,
  ExtCtrls, DNMPanel, Mask, wwdbedit, MemDS, DNMSpeedButton, wwdblook,
  MessageConst;

type
  THireProjectPrefsGUI = class(TForm)
    lblWidth: TLabel;
    MyConnection: TMyConnection;
    dsPrefs: TDataSourcePrefs;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label4: TLabel;
    Label40: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label5: TLabel;
    wwDBEdit2: TwwDBEdit;
    lblIgnore: TLabel;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TMyQuery;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    Label9: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit6: TwwDBEdit;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    wwCheckBox3: TwwCheckBox;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    btnHireTemplate: TDNMSpeedButton;
    Label16: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label17: TLabel;
    edtHireDescription: TwwDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    btnDefaultHireInvoiceDesc: TDNMSpeedButton;
    DNMPanel6: TDNMPanel;
    Bevel6: TBevel;
    Label18: TLabel;
    cboSpaceRent: TwwDBLookupCombo;
    qryPartOther: TMyQuery;
    procedure btnHireTemplateClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnDefaultHireInvoiceDescClick(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib,  tcConst, CommonDbLib, AppEnvironment,
  FastFuncs;

{$R *.dfm}

procedure THireProjectPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
end;

procedure THireProjectPrefsGUI.PerformFinish(var Msg: TMessage);
begin
 if qryPersonalPreferences.State in [dsEdit, dsInsert] then
   qryPersonalPreferences.Post;
end;

procedure THireProjectPrefsGUI.btnHireTemplateClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmHireTemplate');

  if not Assigned(tmpComponent) then
    Exit;

  with TForm(tmpComponent) do begin
    FormStyle := fsNormal;
    ShowModal;
  end;
end;

procedure THireProjectPrefsGUI.DNMSpeedButton1Click(Sender: TObject);
var
  HireNo, Desc: string;
begin
  inherited;

  if FastFuncs.PosEx(MASK_HIRE_NO, edtHireDescription.Text) = 0 then
    CommonLib.MessageDlgXP_Vista('No parameter specified', mtInformation, [mbOK], 0)
  else begin
    HireNo := InputBox('Enter test Hire No', 'Hire No', '100');

    if HireNo <> '' then begin
      Desc := FastFuncs.AnsiStringReplace(edtHireDescription.Text, MASK_HIRE_NO, HireNo,[rfReplaceAll,rfIgnoreCase]);
      CommonLib.MessageDlgXP_Vista('Invoice generated from hire will have item description of' + #13 + #10 +
                 Format('"%s".', [Desc]), mtInformation, [mbOK], 0);
    end
    else
      CommonLib.MessageDlgXP_Vista('No Hire No specified.', mtInformation, [mbOK], 0);
  end;
end;

procedure THireProjectPrefsGUI.btnDefaultHireInvoiceDescClick(Sender: TObject);
begin
  edtHireDescription.Field.AsString := DEFAULT_HIRE_DESC;
end;

initialization
  RegisterClassOnce(THireProjectPrefsGUI);
finalization
  UnRegisterClass(THireProjectPrefsGUI);
end.
