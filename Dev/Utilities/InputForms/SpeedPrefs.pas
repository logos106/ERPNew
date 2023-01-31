unit SpeedPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, ExtCtrls, DNMPanel, DataSourcePrefs,
  MessageConst, Mask, wwdbedit, frmBase, tcClasses, BasePrefs, Menus,
  AdvScrollBox;

type
  TSpeedPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label7: TLabel;
    chkPOSSummarise: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    wwRadioGroup1: TwwRadioGroup;
    wwRadioGroup2: TwwRadioGroup;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label8: TLabel;
    lblIgnore: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtSaleLinesToDisableCalcs: TwwDBEdit;
    edtOrderLinesToDisableCalcs: TwwDBEdit;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label9: TLabel;
    wwCheckBox5: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label3: TLabel;
    wwCheckBox1: TwwCheckBox;
    lblhintExpenseLinesToDisableCalcs: TLabel;
    edtExpenseLinesToDisableCalcs: TwwDBEdit;
    lblExpenseLinesToDisableCalcs: TLabel;
    lblhintCustPayLinesToDisableCalcs: TLabel;
    edtCustPayLinesToDisableCalcs: TwwDBEdit;
    lblCustPayLinesToDisableCalcs: TLabel;
    lblhintSuppPayLinesToDisableCalcs: TLabel;
    edtSuppPayLinesToDisableCalcs: TwwDBEdit;
    lblSuppPayLinesToDisableCalcs: TLabel;
    procedure chkPOSSummariseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fFormShown: Boolean;
    Flags: TSimpleFlags;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure SetCheckBox(var Msg: TMessage); message TX_SetCheckBox;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  DNMLib,  CommonDbLib,  CommonLib, AppEnvironment;

{$R *.dfm}

{ TSpeedPrefsGUI }


procedure TSpeedPrefsGUI.chkPOSSummariseClick(Sender: TObject);
begin
  if (Sender is TwwCheckBox) and fFormShown then begin
     if (not TwwCheckBox(Sender).Checked) and (not IsPosEOPDoneAndNoSummariseSalesExist) then begin
        CommonLib.MessageDlgXP_Vista('Cannot Turn Off Summarised Sales Until ' + #13 + #10 + 'POS End of Period Has Been Done!',
                   mtInformation, [mbOK], 0);
        PostMessage(Handle, TX_SetCheckBox, 0, 0);
     end;
  end;
end;

procedure TSpeedPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fFormShown := False;
  Flags:= TSimpleFlags.Create;
end;

procedure TSpeedPrefsGUI.SetCheckBox(var Msg: TMessage);
begin
  chkPOSSummarise.Checked := True;
end;

procedure TSpeedPrefsGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  Flags.Free;
end;
procedure TSpeedPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TSpeedPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  fFormShown := True;
end;

procedure TSpeedPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TSpeedPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryPersonalPreferences.State in [dsEdit, dsInsert] then
    qryPersonalPreferences.Post;

  fFormShown := False;
end;

initialization
  RegisterClassOnce(TSpeedPrefsGUI);
finalization
  UnRegisterClass(TSpeedPrefsGUI);
end.
