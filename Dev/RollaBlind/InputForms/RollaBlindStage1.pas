unit RollaBlindStage1;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, StdCtrls, wwdblook, DB, MemDS, DBAccess,
  MyAccess, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,  DBCtrls,
  DNMSpeedButton, ExtCtrls, DNMPanel, wwcheckbox, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, Forms;

type
  TRollaBlindStage1GUI = class(TBaseRollaBlindWizardGUI)
    qryLeadNumber: TMyQuery;
    qryProfileType: TMyQuery;
    StringField1: TStringField;
    qryLeadNumberClientID: TIntegerField;
    Label8: TLabel;
    cboLeadNumber: TwwDBLookupCombo;
    Label9: TLabel;
    cboProfileType: TwwDBLookupCombo;
    Label11: TLabel;
    cboInstallationType: TwwDBComboBox;
    Label12: TLabel;
    cboSubInstallationType: TwwDBComboBox;
    Label13: TLabel;
    cboGuideType: TwwDBComboBox;
    chkArchBar: TwwCheckBox;
    Label14: TLabel;
    chkMoveBy50: TwwCheckBox;
    Label15: TLabel;
    chkPerforated: TwwCheckBox;
    Label10: TLabel;
    Label16: TLabel;
    edtShutterNumber: TwwDBEdit;
    Label17: TLabel;
    edtOpeningHeight: TwwDBEdit;
    Label18: TLabel;
    edtOpeningWidth: TwwDBEdit;
    Label19: TLabel;
    edtMapReference: TwwDBEdit;
    Label20: TLabel;
    qryLeadNumberFirstName: TStringField;
    qryLeadNumberLastName: TStringField;
    edtInstallDate: TMaskEdit;
    procedure cboLeadNumberCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboProfileTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboInstallationTypeCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboSubInstallationTypeCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboGuideTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure edtOpeningWidthExit(Sender: TObject);
    procedure edtShutterNumberExit(Sender: TObject);
    procedure edtOpeningHeightExit(Sender: TObject);
    procedure chkArchBarClick(Sender: TObject);
    procedure edtMapReferenceExit(Sender: TObject);
    procedure edtInstallDateExit(Sender: TObject);
    procedure chkPerforatedClick(Sender: TObject);
    procedure chkMoveBy50Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, FastFuncs;

const
  cSubTypeList1 = 'Eave' + #10 + 'Surface';
  cSubTypeList2 = 'Reveal' + #10 + 'Partial Eave' + #10 + 'Heavy Duty';
  cSubTypeList3 = 'Surface' + #10 + 'Partial Eave' + #10 + 'Partial Reveal' + #10 + 'Heavy Duty';
  cSubTypeList4 = 'Offset' + #10 + 'Reveal' + #10 + 'Surface';
  cGuideTypeList1 = 'Reveal' + #10 + 'Commercial';
  cGuideTypeList2 = 'Surface' + #10 + 'Reveal' + #10 + 'Commercial';

procedure TRollaBlindStage1GUI.cboLeadNumberCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if not Empty(cboLeadNumber.Text) then begin
    qryHeading.Close;
    qryHeading.ParamByName('ClientID').AsString := LookupTable.FieldByName('ClientID').AsString;
    qryHeading.Open;

    if InitialSetup then begin
      DataChanged := True;
      cboProfileType.Enabled := True;
      cboProfileType.DropDown;
    end;
  end;
end;

procedure TRollaBlindStage1GUI.FormCreate(Sender: TObject);
var
  WizardConnection: TMyConnection;
begin
  inherited;
  NextFormClassName := 'TRollaBlindStage2GUI';
  WizardConnection := GetWizardConnection;

  if not WizardConnection.InTransaction then
    WizardConnection.StartTransaction;
end;

procedure TRollaBlindStage1GUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    qryMain.Insert;
    qryMain.Post;
    qryMain.Edit;
    cboProfileType.Enabled := False;
    cboInstallationType.Enabled := False;
    cboSubInstallationType.Enabled := False;
    cboGuideType.Enabled := False;
    chkPerforated.Enabled := False;
    chkArchBar.Enabled := False;
    chkMoveBy50.Enabled := False;
    edtShutterNumber.Enabled := False;
    edtOpeningHeight.Enabled := False;
    edtOpeningWidth.Enabled := False;
    edtMapReference.Enabled := False;
    edtInstallDate.Enabled := False;
    SetControlFocus(cboLeadNumber);
  end;
end;

procedure TRollaBlindStage1GUI.cboProfileTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if FastFuncs.SameText(cboProfileType.Text, 'Rollamesh Std') or FastFuncs.SameText(cboProfileType.Text, 'Rollamesh Rev') or
     FastFuncs.SameText(cboProfileType.Text, 'Rollalock') or FastFuncs.SameText(cboProfileType.Text, 'Rollamite Std') or
     FastFuncs.SameText(cboProfileType.Text, 'Rollamite Rev') then begin

    if not (qryMain.State in [dsEdit, dsInsert]) then
      qryMain.Edit;

    qryMain.FieldByName('Perforated').AsString := 'T';
    chkPerforated.Enabled := False;
  end
  else begin
    chkPerforated.Enabled := True;
  end;

  if InitialSetup and (not Empty(cboProfileType.Text)) then begin
    cboInstallationType.Enabled := True;
    cboInstallationType.DropDown;
  end;
end;

procedure TRollaBlindStage1GUI.cboInstallationTypeCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  NextFormClassName := 'TRollaBlindStage2GUI';

  if FastFuncs.SameText(cboInstallationType.Text, 'Rollavault') then begin
    if not (qryMain.State in [dsEdit, dsInsert]) then
      qryMain.Edit;

    qryMain.FieldByName('SubInstallType').AsString := 'Reveal';
    cboGuideType.Items.Text := cGuideTypeList2;

    if InitialSetup then begin
      cboGuideType.Enabled := True;
      cboGuideType.DropDown;
    end;
  end
  else if FastFuncs.SameText(cboInstallationType.Text, 'Surface') then begin
    cboSubInstallationType.Items.Text := cSubTypeList3;
    cboSubInstallationType.Enabled := True;

    if InitialSetup then
      cboSubInstallationType.DropDown;
  end
  else if FastFuncs.SameText(cboInstallationType.Text, 'Curtain Replacement') then begin
    NextFormClassName := 'TRollaBlindStage2crGUI';
    edtShutterNumber.Enabled := True;

    if InitialSetup and chkPerforated.Enabled then
      SetControlFocus(chkPerforated);
  end
  else begin
    if FastFuncs.SameText(cboInstallationType.Text, 'Casement') then
      cboSubInstallationType.Items.Text := cSubTypeList1
    else if FastFuncs.SameText(cboInstallationType.Text, 'Reveal') then
      cboSubInstallationType.Items.Text := cSubTypeList2
    else if FastFuncs.SameText(cboInstallationType.Text, 'Eave') then
      cboSubInstallationType.Items.Text := cSubTypeList4;

    chkArchBar.Checked := False;
    chkMoveBy50.Checked := False;
    chkArchBar.Enabled := False;
    chkMoveBy50.Enabled := False;
    cboSubInstallationType.Enabled := True;

    if InitialSetup then
      cboSubInstallationType.DropDown;
  end;
end;

procedure TRollaBlindStage1GUI.cboSubInstallationTypeCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
var
  SkipDropDown: Boolean;
begin
  inherited;
  SkipDropDown := False;

  if FastFuncs.SameText(cboSubInstallationType.Text, 'Heavy Duty') then begin
    cboGuideType.Items.Text := 'Heavy Duty';
    cboGuideType.Field.Value := 'Heavy Duty';
    edtShutterNumber.Enabled := True;

    if InitialSetup then begin
      SkipDropDown := True;
      SetControlFocus(edtShutterNumber);
    end;
  end
  else if FastFuncs.SameText(cboSubInstallationType.Items.Text, cSubTypeList3) then begin
    cboGuideType.Items.Text := cGuideTypeList2;
  end
  else if FastFuncs.SameText(cboSubInstallationType.Items.Text, cSubTypeList2) then begin
    cboGuideType.Items.Text := cGuideTypeList1;
  end
  else if FastFuncs.SameText(cboSubInstallationType.Items.Text, cSubTypeList1) then begin
    cboGuideType.Items.Text := 'Reveal';
    cboGuideType.Field.Value := 'Reveal';
    edtShutterNumber.Enabled := True;

    if InitialSetup then begin
      SkipDropDown := True;
      SetControlFocus(edtShutterNumber);
    end;
  end
  else if FastFuncs.SameText(cboInstallationType.Text, 'Eave') and
     (FastFuncs.SameText(cboSubInstallationType.Text, 'Offset') or FastFuncs.SameText(cboSubInstallationType.Text, 'Reveal')) then begin
    cboGuideType.Items.Text := cGuideTypeList1;
  end
  else begin
    cboGuideType.Items.Text := cGuideTypeList2;
  end;

  if not Empty(cboSubInstallationType.Text) then begin
    cboGuideType.Enabled := True;

    if InitialSetup and (not SkipDropDown) then
      cboGuideType.DropDown;
  end;
end;

procedure TRollaBlindStage1GUI.cboGuideTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if FastFuncs.SameText(cboInstallationType.Text, 'Surface') then
    chkArchBar.Enabled := True;

  if InitialSetup and (not Empty(cboGuideType.Text)) then begin
    edtShutterNumber.Enabled := True;

    if chkPerforated.Enabled then
      SetControlFocus(chkPerforated)
    else if chkArchBar.Enabled then
      SetControlFocus(chkArchBar)
    else
      SetControlFocus(edtShutterNumber);
  end;
end;

procedure TRollaBlindStage1GUI.edtOpeningWidthExit(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    edtMapReference.Enabled := True;
    SetControlFocus(edtMapReference);
  end;
end;

procedure TRollaBlindStage1GUI.edtShutterNumberExit(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    edtOpeningHeight.Enabled := True;
    SetControlFocus(edtOpeningHeight);
  end;
end;

procedure TRollaBlindStage1GUI.edtOpeningHeightExit(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    edtOpeningWidth.Enabled := True;
    SetControlFocus(edtOpeningWidth);
  end;
end;

procedure TRollaBlindStage1GUI.chkArchBarClick(Sender: TObject);
begin
  inherited;
  chkMoveBy50.Checked := False;
  chkMoveBy50.Enabled := chkArchBar.Checked;

  if InitialSetup then begin
    if chkMoveBy50.Enabled then
      SetControlFocus(chkMoveBy50)
    else
      SetControlFocus(edtShutterNumber);
  end;
end;

procedure TRollaBlindStage1GUI.edtMapReferenceExit(Sender: TObject);
begin
  inherited;

  if InitialSetup and (not (fsShowing in FormState)) then begin
    edtInstallDate.Enabled := True;
    SetControlFocus(edtInstalldate);
  end;
end;

procedure TRollaBlindStage1GUI.edtInstallDateExit(Sender: TObject);
var
  DateTime: TDateTime;
begin
  inherited;

  if (Sender is TMaskEdit) and (not FastFuncs.SameText(TMaskEdit(Sender).Text, '  /  /    ')) then begin
    if TryStrToDate(TMaskEdit(Sender).Text, DateTime) then begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('InstallDate').AsDateTime := DateTime;
      InitialSetup := False;
      btnNext.Enabled := True;
      SetControlFocus(btnNext);
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Invalid date entered.', mtWarning, [mbOK], 0);
      SetControlFocus(edtInstallDate);
    end;
  end
  else begin
    if not (qryMain.State in [dsEdit, dsInsert]) then
      qryMain.Edit;

    qryMain.FieldByName('InstallDate').AsVariant := NULL;
    InitialSetup := False;
    btnNext.Enabled := True;
    SetControlFocus(btnNext);
  end;
end;

procedure TRollaBlindStage1GUI.chkPerforatedClick(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    if chkArchBar.Enabled then
      SetControlFocus(chkArchBar)
    else
      SetControlFocus(edtShutterNumber);
  end;
end;

procedure TRollaBlindStage1GUI.chkMoveBy50Click(Sender: TObject);
begin
  inherited;

  if InitialSetup then
    SetControlFocus(edtShutterNumber);
end;

initialization
  RegisterClassOnce(TRollaBlindStage1GUI);
finalization
  UnRegisterClass(TRollaBlindStage1GUI);
end.
