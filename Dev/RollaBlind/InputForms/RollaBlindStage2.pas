unit RollaBlindStage2;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  ExtCtrls, DBCtrls, StdCtrls,
  DNMSpeedButton, DNMPanel, Mask, wwdbedit, wwdblook, Wwdotdot, Wwdbcomb,
  Forms;

type
  TRollaBlindStage2GUI = class(TBaseRollaBlindWizardGUI)
    Bevel4: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    txtProfileType: TDBText;
    txtPerforated: TDBText;
    txtStandard: TDBText;
    Label10: TLabel;
    Bevel8: TBevel;
    Label12: TLabel;
    Label14: TLabel;
    Label36: TLabel;
    txtInstallationType: TDBText;
    txtSubInstallationType: TDBText;
    txtGuideType: TDBText;
    Label15: TLabel;
    Bevel5: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    txtShutterNumber: TDBText;
    txtOpeningHeight: TDBText;
    txtOpeningWidth: TDBText;
    Label19: TLabel;
    Bevel6: TBevel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    txtContractNumber: TDBText;
    txtMapReference: TDBText;
    txtInstallationDate: TDBText;
    Label23: TLabel;
    Bevel7: TBevel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    txtHousingType: TDBText;
    txtHiddenProfiles: TDBText;
    txtHiddenProfileHeight: TDBText;
    Label27: TLabel;
    edtDrop: TwwDBEdit;
    Label28: TLabel;
    edtDMG: TwwDBEdit;
    Label29: TLabel;
    edtShutterWeight: TwwDBEdit;
    Label30: TLabel;
    cboMechanismType: TwwDBLookupCombo;
    qryMechanismType: TMyQuery;
    qryMechanismTypeDescription: TStringField;
    qryMechanismTypeHeavyDuty: TStringField;
    Label31: TLabel;
    cboCableRoller: TwwDBComboBox;
    Label32: TLabel;
    cboWinchPosition: TwwDBComboBox;
    procedure FormShow(Sender: TObject);
    procedure cboMechanismTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboCableRollerCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboWinchPositionCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure ProcessCalculationQueries;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, FastFuncs;

procedure TRollaBlindStage2GUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    ProcessCalculationQueries;
    qryMechanismType.Close;

    if FastFuncs.SameText(qryMain.FieldByName('GuideType').AsString, 'Heavy Duty') then
      qryMechanismType.ParamByName('HeavyDuty').AsString := 'T'
    else
      qryMechanismType.ParamByName('HeavyDuty').AsString := 'F';

    qryMechanismType.Open;
    cboCableRoller.Enabled := False;
    cboWinchPosition.Enabled := False;
    SetControlFocus(cboMechanismType);
  end;
end;

procedure TRollaBlindStage2GUI.ProcessCalculationQueries;
var
  InstallType: string;
  SubInstallType: string;
  GuideType: string;
  ArchBar: string;
  MoveBy50: string;
begin
  qryMain.Locate('SheetID', SheetID, [loCaseInsensitive]);
  InstallType := qryMain.FieldByName('InstallType').AsString;
  SubInstallType := qryMain.FieldByName('SubInstallType').AsString;
  GuideType := qryMain.FieldByName('GuideType').AsString;
  ArchBar := qryMain.FieldByName('ArchBar').AsString;
  MoveBy50 := qryMain.FieldByName('MoveBy50').AsString;
  qryMain.Close;

  if ArchBar = 'F' then begin
    if FastFuncs.SameText(InstallType, 'Eave') and FastFuncs.SameText(SubInstallType, 'Offset') then begin
      QueryLoad.Execute('AddSheet1l', SheetID);
      QueryLoad.Execute('AddSheet1c', SheetID);
      QueryLoad.Execute('AddSheet1m', SheetID);
      QueryLoad.Execute('AddSheet1d', SheetID);
    //  QueryLoad.Execute('AddSheet1e', SheetID));
      QueryLoad.Execute('AddSheet1f', SheetID);
      QueryLoad.Execute('AddSheet1h', SheetID);
    end
    else if FastFuncs.SameText(GuideType, 'Heavy Duty') then begin
      QueryLoad.Execute('AddSheet1c', SheetID);
      QueryLoad.Execute('AddSheet1d', SheetID);
  //    QueryLoad.Execute('AddSheet1e', SheetID);
      QueryLoad.Execute('AddSheet1f', SheetID);
      QueryLoad.Execute('AddSheet1g', SheetID);
      QueryLoad.Execute('AddSheet1h', SheetID);
      QueryLoad.Execute('AddSheet1s', SheetID);
    end
    else begin
      QueryLoad.Execute('AddSheet1c', SheetID);
      QueryLoad.Execute('AddSheet1d', SheetID);
  //    QueryLoad.Execute('AddSheet1e', SheetID);
      QueryLoad.Execute('AddSheet1f', SheetID);
      QueryLoad.Execute('AddSheet1g', SheetID);
      QueryLoad.Execute('AddSheet1h', SheetID);
      QueryLoad.Execute('AddSheet1r', SheetID);
      QueryLoad.Execute('AddSheet1t', SheetID);
    end;

    if FastFuncs.SameText(InstallType, 'Eave') and (not FastFuncs.SameText(SubInstallType, 'Offset')) then
      QueryLoad.Execute('AddSheet1x', SheetID);
  end
  else if FastFuncs.SameText(MoveBy50, 'T') then begin
    QueryLoad.Execute('AddSheet1l', SheetID);
    QueryLoad.Execute('AddSheet1c', SheetID);
    QueryLoad.Execute('AddSheet1m', SheetID);
    QueryLoad.Execute('AddSheet1d', SheetID);
//    QueryLoad.Execute('AddSheet1e', SheetID);
    QueryLoad.Execute('AddSheet1f', SheetID);
    QueryLoad.Execute('AddSheet1h', SheetID);
  end
  else begin
    QueryLoad.Execute('AddSheet1c', SheetID);
    QueryLoad.Execute('AddSheet1d', SheetID);
//    QueryLoad.Execute('AddSheet1e', SheetID);
    QueryLoad.Execute('AddSheet1f', SheetID);
    QueryLoad.Execute('AddSheet1g', SheetID);
    QueryLoad.Execute('AddSheet1h', SheetID);
  end;

  qryMain.Open;
  qryMain.Locate('SheetID', SheetID, [loCaseInsensitive]);
end;

procedure TRollaBlindStage2GUI.cboMechanismTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboMechanismType.Text)) then begin
    if FastFuncs.SameText(cboMechanismType.Text, 'Winch') then begin
      cboCableRoller.Enabled := True;
      cboCableRoller.DropDown;
    end
    else if FastFuncs.SameText(cboMechanismType.Text, 'Motor') then begin
      cboWinchPosition.Enabled := True;
      cboWinchPosition.DropDown;
    end
    else begin
      InitialSetup := False;
      btnNext.Enabled := True;
      SetControlFocus(btnNext);
    end;
  end;
end;

procedure TRollaBlindStage2GUI.cboCableRollerCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboCableRoller.Text)) then begin
    cboWinchPosition.Enabled := True;
    cboWinchPosition.DropDown;
  end;
end;

procedure TRollaBlindStage2GUI.cboWinchPositionCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if InitialSetup and (not Empty(cboWinchPosition.Text)) then begin
    InitialSetup := False;
    btnNext.Enabled := True;
    SetControlFocus(btnNext);
  end;
end;

procedure TRollaBlindStage2GUI.FormCreate(Sender: TObject);
begin
  inherited;
  DataChanged := True;
  NextFormClassName := 'TRollaBlindStage3GUI';
  BackFormClassName := 'TRollaBlindStage1GUI';
end;

initialization
  RegisterClassOnce(TRollaBlindStage2GUI);
finalization
  UnRegisterClass(TRollaBlindStage2GUI);
end.
