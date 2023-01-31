unit RollaBlindStage3;

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
  DNMSpeedButton, StdCtrls, DNMPanel, wwdblook, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, Forms;

type
  TRollaBlindStage3GUI = class(TBaseRollaBlindWizardGUI)
    Label8: TLabel;
    Label9: TLabel;
    Bevel4: TBevel;
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
    Bevel9: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    txtShutterWeight: TDBText;
    txtDrop: TDBText;
    txtDMG: TDBText;
    Label31: TLabel;
    Bevel10: TBevel;
    Label32: TLabel;
    txtMechType: TDBText;
    Label33: TLabel;
    cboSelectedType: TwwDBLookupCombo;
    qrySelectedType: TMyQuery;
    qrySelectedTypeDescription: TStringField;
    qrySelectedTypeMechType: TStringField;
    Label34: TLabel;
    edtMechanismType: TwwDBEdit;
    Label35: TLabel;
    edtShutterWeight: TwwDBEdit;
    Label38: TLabel;
    cboWinchBracket: TwwDBLookupCombo;
    qryWinchBracket: TMyQuery;
    qryWinchBracketDescription: TStringField;
    Label39: TLabel;
    cboStarterLink: TwwDBComboBox;
    Label40: TLabel;
    cboSidePlateColour: TwwDBLookupCombo;
    qryColour: TMyQuery;
    qryColourDescription: TStringField;
    cboAlumExtColour: TwwDBLookupCombo;
    Label41: TLabel;
    qrySidePlateSize: TMyQuery;
    Label42: TLabel;
    cboSidePlateSize: TwwDBLookupCombo;
    qrySidePlateSizeCategory: TStringField;
    Label43: TLabel;
    cboLockType: TwwDBComboBox;
    qryWinchBracketItemNumber: TStringField;
    qryColourColourCode: TStringField;
    qryWinchBracketLength: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboSelectedTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboWinchBracketCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboStarterLinkCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboSidePlateColourCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboAlumExtColourCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboSidePlateSizeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboLockTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    procedure ProcessCalculationQueries;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, FastFuncs;

procedure TRollaBlindStage3GUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    ProcessCalculationQueries;
    qrySelectedType.Close;
    qrySelectedType.ParamByName('MechType').AsString := qryMain.FieldByName('MechType').AsString;
    qrySelectedType.Open;
    qryColour.Close;

    if FastFuncs.SameText(qryMain.FieldByName('GuideType').AsString, 'Heavy Duty') then
      qryColour.ParamByName('HeavyDuty').AsString := 'T'
    else
      qryColour.ParamByName('HeavyDuty').AsString := 'F';

    qryColour.Open;
    cboWinchBracket.Enabled := False;
    cboStarterLink.Enabled := False;
    cboSidePlateColour.Enabled := False;
    cboAlumExtColour.Enabled := False;
    cboSidePlateSize.Enabled := False;
    cboLockType.Enabled := False;

    if FastFuncs.SameText(edtMechanismType.Text, 'Motor') then begin
      cboStarterLink.Enabled := True;
      cboStarterLink.DropDown;
    end
    else if FastFuncs.SameText(edtMechanismType.Text, 'Winch') then begin
      cboWinchBracket.Enabled := True;
      cboWinchBracket.DropDown;
    end
    else begin
      cboStarterLink.Enabled := True;
      cboStarterLink.DropDown;
    end;

    if not (qryMain.State in [dsEdit, dsInsert]) then
      qryMain.Edit;
      
    if FastFuncs.SameText(qryMain.FieldByName('GuideType').AsString, 'Heavy Duty') then begin
      QryMain.FieldByName('HiddenProfileType').AsString := 'Heavy Duty';
      QryMain.FieldByName('Housing').AsString := 'Heavy Duty';
    end
    else if FastFuncs.SameText(qryMain.FieldByName('InstallType').AsString, 'Casement') then begin
      QryMain.FieldByName('HiddenProfileType').AsString := 'Std';
      QryMain.FieldByName('Housing').AsString := 'Std';
    end;
  end;
end;

procedure TRollaBlindStage3GUI.FormCreate(Sender: TObject);
begin
  inherited;
  DataChanged := True;
  NextFormClassName := 'TRollaBlindStage4GUI';
  BackFormClassName := 'TRollaBlindStage2GUI';
end;

procedure TRollaBlindStage3GUI.ProcessCalculationQueries;
begin
  qryMain.Close;
  QueryLoad.Execute('AddSheet1i', SheetID);
  qryMain.Open;
  qryMain.Locate('SheetID', SheetID, [loCaseInsensitive]);
end;

procedure TRollaBlindStage3GUI.cboSelectedTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboSelectedType.Text)) then begin
    edtShutterWeight.Enabled := True;

    if FastFuncs.SameText(edtMechanismType.Text, 'Winch') then begin
      cboWinchBracket.Enabled := True;
      cboWinchBracket.DropDown;
    end
    else begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('WBMaterial').AsString := 'None';
      cboStarterLink.Enabled := True;
      cboStarterLink.DropDown;
    end;
  end;
end;

procedure TRollaBlindStage3GUI.cboWinchBracketCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if not Empty(cboWinchBracket.Text) then begin
    if not FastFuncs.SameText(cboWinchBracket.Text, 'None') then begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('WBItemNo').AsString := qryWinchBracket.FieldByName('ItemNumber').AsString;
      qryMain.FieldByName('WBLength').AsString := qryWinchBracket.FieldByName('Length').AsString;
    end;  

    if InitialSetup then begin
      cboStarterLink.Enabled := True;
      cboStarterLink.DropDown;
    end;
  end;
end;

procedure TRollaBlindStage3GUI.cboStarterLinkCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboStarterLink.Text)) then begin
    cboSidePlateColour.Enabled := True;
    cboSidePlateColour.DropDown;
  end;
end;

procedure TRollaBlindStage3GUI.cboSidePlateColourCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboSidePlateColour.Text)) then begin
    cboAlumExtColour.Enabled := True;
    cboAlumExtColour.DropDown;
  end;
end;

procedure TRollaBlindStage3GUI.cboAlumExtColourCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  
  if InitialSetup and (not Empty(cboAlumExtColour.Text)) then begin
    cboSidePlateSize.Enabled := True;
    cboLockType.Enabled := True;
    cboLockType.DropDown;
  end;
end;

procedure TRollaBlindStage3GUI.cboSidePlateSizeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboSidePlateSize.Text)) then begin
    cboLockType.Enabled := True;
    cboLockType.DropDown;
  end;
end;

procedure TRollaBlindStage3GUI.cboLockTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  InitialSetup := False;
  btnNext.Enabled := True;
  SetControlFocus(btnNext);
end;

initialization
  RegisterClassOnce(TRollaBlindStage3GUI);
finalization
  UnRegisterClass(TRollaBlindStage3GUI);
end.
