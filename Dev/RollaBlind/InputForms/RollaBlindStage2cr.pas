unit RollaBlindStage2cr;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DBCtrls, ExtCtrls,
  DNMSpeedButton, StdCtrls, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwcheckbox, Forms;

type
  TRollaBlindStage2crGUI = class(TBaseRollaBlindWizardGUI)
    Label11: TLabel;
    cboGuideMeasurement: TwwDBComboBox;
    Label43: TLabel;
    cboLockType: TwwDBComboBox;
    Label46: TLabel;
    cboStopsType: TwwDBComboBox;
    Label39: TLabel;
    cboStarterLink: TwwDBComboBox;
    Label35: TLabel;
    edtHiddenProfileNumber: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboGuideMeasurementCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboLockTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboStopsTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboStarterLinkCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure edtHiddenProfileNumberExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib;

procedure TRollaBlindStage2crGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DataChanged := True;
  NextFormClassName := 'TRollaBlindStage6GUI';
  BackFormClassName := 'TRollaBlindStage1GUI';
end;

procedure TRollaBlindStage2crGUI.btnNextClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName(NextFormClassName);

  if Assigned(TmpComp) then begin
    TBaseRollaBlindWizardGUI(TmpComp).BackFormClassName := 'TRollaBlindStage2crGUI';
    TBaseRollaBlindWizardGUI(TmpComp).Caption := 'Cut-out Sheet - Step 3';
    TBaseRollaBlindWizardGUI(TmpComp).TitleLabel.Caption := 'Cut-out Sheet - Step 3';
  end;
end;

procedure TRollaBlindStage2crGUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    edtHiddenProfileNumber.Enabled := False;
    cboLockType.Enabled := False;
    cboStopsType.Enabled := False;
    cboStarterLink.Enabled := False;
  end;
end;

procedure TRollaBlindStage2crGUI.cboGuideMeasurementCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;

  if not Empty(cboGuideMeasurement.Text) then begin
    edtHiddenProfileNumber.Enabled := True;

    if InitialSetup then
      SetControlFocus(edtHiddenProfileNumber);
  end;
end;

procedure TRollaBlindStage2crGUI.cboLockTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if not Empty(cboLockType.Text) then begin
    cboStopsType.Enabled := True;

    if InitialSetup then
      cboStopsType.DropDown;
  end;
end;

procedure TRollaBlindStage2crGUI.cboStopsTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if not Empty(cboStopsType.Text) then begin
    cboStarterLink.Enabled := True;

    if InitialSetup then
      cboStarterLink.DropDown;
  end;
end;

procedure TRollaBlindStage2crGUI.cboStarterLinkCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboStarterLink.Text)) then begin
    InitialSetup := False;
    btnNext.Enabled := True;
    SetControlFocus(btnNext);
  end;
end;

procedure TRollaBlindStage2crGUI.edtHiddenProfileNumberExit(
  Sender: TObject);
begin
  inherited;

  if not Empty(edtHiddenProfileNumber.Text) then begin
    cboLockType.Enabled := True;

    if InitialSetup then
      cboLockType.DropDown;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindStage2crGUI);
finalization
  UnRegisterClass(TRollaBlindStage2crGUI);
end.
