unit RollaBlindStage5;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/06/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DBCtrls, ExtCtrls,
  DNMSpeedButton, StdCtrls, DNMPanel, wwdblook, wwcheckbox, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, Forms;

type
  TRollaBlindStage5GUI = class(TBaseRollaBlindWizardGUI)
    Label8: TLabel;
    Bevel4: TBevel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    txtProfileType: TDBText;
    txtPerforated: TDBText;
    txtStandard: TDBText;
    Label10: TLabel;
    Label12: TLabel;
    Bevel8: TBevel;
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
    Label33: TLabel;
    txtMechType: TDBText;
    txtMechDescription: TDBText;
    Label34: TLabel;
    Bevel11: TBevel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    txtStarterLink: TDBText;
    txtSidePlateColour: TDBText;
    txtAlumExtColour: TDBText;
    Label39: TLabel;
    Bevel12: TBevel;
    Label40: TLabel;
    txtLockType: TDBText;
    Label41: TLabel;
    Bevel13: TBevel;
    Label42: TLabel;
    Label43: TLabel;
    txtGuideCapsRequired: TDBText;
    txtGuideCapColour: TDBText;
    Label44: TLabel;
    Bevel14: TBevel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    txtSillRequired: TDBText;
    txtSillLength: TDBText;
    txtSillMaterial: TDBText;
    Label48: TLabel;
    txtSillItemNumber: TDBText;
    Label49: TLabel;
    txtSillColour: TDBText;
    Label50: TLabel;
    Bevel15: TBevel;
    Label51: TLabel;
    txtStopsType: TDBText;
    chkPackersRequired: TwwCheckBox;
    Label52: TLabel;
    chkMoreThanOnePacker: TwwCheckBox;
    Label53: TLabel;
    chkSamePackers: TwwCheckBox;
    Label54: TLabel;
    Label55: TLabel;
    cboPackerMaterial1: TwwDBLookupCombo;
    Label56: TLabel;
    cboPackerMaterial2: TwwDBLookupCombo;
    qryPackerMaterial: TMyQuery;
    qryPackerMaterialDescription: TStringField;
    qryPackerMaterialItemNumber: TStringField;
    qryPackerColour: TMyQuery;
    Label57: TLabel;
    cboPackerColour: TwwDBLookupCombo;
    qryPackerColourColourCode: TStringField;
    qryPackerColourDescription: TStringField;
    qryPackerColourItemID: TIntegerField;
    qryPackerMaterialItemID: TIntegerField;
    chkHolePlugsRequired: TwwCheckBox;
    Label58: TLabel;
    Label59: TLabel;
    edtHolePlugNumber: TwwDBEdit;
    chkFlashingRequired: TwwCheckBox;
    Label60: TLabel;
    qryFlashingMaterial: TMyQuery;
    qryFlashingMaterialDescription: TStringField;
    qryFlashingMaterialItemNumber: TStringField;
    qryFlashingMaterialItemID: TIntegerField;
    Label61: TLabel;
    cboFlashingType: TwwDBLookupCombo;
    Label62: TLabel;
    cboCasementProfileFill: TwwDBComboBox;
    Label63: TLabel;
    edtPackerLength: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkPackersRequiredClick(Sender: TObject);
    procedure cboPackerMaterial1CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPackerMaterial2CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkMoreThanOnePackerClick(Sender: TObject);
    procedure chkHolePlugsRequiredClick(Sender: TObject);
    procedure chkFlashingRequiredClick(Sender: TObject);
    procedure cboCasementProfileFillCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboFlashingTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPackerColourCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkSamePackersClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib;

procedure TRollaBlindStage5GUI.FormCreate(Sender: TObject);
begin
  inherited;
  DataChanged := True;
  NextFormClassName := 'TRollaBlindStage6GUI';
  BackFormClassName := 'TRollaBlindStage4GUI';
end;

procedure TRollaBlindStage5GUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    chkMoreThanOnePacker.Enabled := False;
    chkSamePackers.Enabled := False;
    cboPackerMaterial1.Enabled := False;
    cboPackerMaterial2.Enabled := False;
    cboPackerColour.Enabled := False;
    edtHolePlugNumber.Enabled := False;
    chkFlashingRequired.Enabled := False;
    cboFlashingType.Enabled := False;
    cboCasementProfileFill.Enabled := False;
    SetControlFocus(chkPackersRequired);
  end;

  qryMain.Close;
  QueryLoad.Execute('AddSheet1n', SheetID);
  QueryLoad.Execute('AddSheet1o', SheetID);
  QueryLoad.Execute('AddSheet1z', SheetID);
  qryMain.Open;
  qryMain.Locate('SheetID', SheetID, [loCaseInsensitive]);
  qryMain.Edit;
end;

procedure TRollaBlindStage5GUI.chkPackersRequiredClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if chkPackersRequired.Checked then begin
      chkMoreThanOnePacker.Enabled := True;
      cboPackerMaterial1.Enabled := True;
      SetControlFocus(chkMoreThanOnePacker);

      if not InitialSetup then begin
        chkSamePackers.Enabled := True;
        cboPackerMaterial2.Enabled := True;
        cboPackerColour.Enabled := True;
      end;
    end
    else begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('PackMore').AsString := 'F';
      qryMain.FieldByName('PackSame').AsString := 'F';
      qryMain.FieldByName('PackMaterial1').AsString := '';
      qryMain.FieldByName('PackMaterial2').AsString := '';
      qryMain.FieldByName('PackColour').AsString := '';

      chkMoreThanOnePacker.Enabled := False;
      chkSamePackers.Enabled := False;
      cboPackerMaterial1.Enabled := False;
      cboPackerMaterial2.Enabled := False;
      cboPackerColour.Enabled := False;
    end;
  end;
end;

procedure TRollaBlindStage5GUI.cboPackerMaterial1CloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if not Empty(cboPackerMaterial1.Text) then begin
    qryPackerColour.Close;
    qryPackerColour.ParamByName('ItemID').AsString := LookupTable.FieldByName('ItemID').AsString;
    qryPackerColour.Open;

    if not (FillTable.State in [dsEdit, dsInsert]) then
      FillTable.Edit;

    FillTable.FieldByName('PackItemNo').AsString := LookupTable.FieldByName('ItemNumber').AsString;

    if InitialSetup then begin
      if chkMoreThanOnePacker.Checked and (not  chkSamePackers.Checked) then begin
        cboPackerMaterial2.Enabled := True;
        cboPackerMaterial2.DropDown;
      end
      else begin
        cboPackerColour.Enabled := True;
        cboPackerColour.DropDown;
      end;
    end;
  end;
end;

procedure TRollaBlindStage5GUI.cboPackerMaterial2CloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if not Empty(cboPackerMaterial2.Text) then begin
    if not (FillTable.State in [dsEdit, dsInsert]) then
      FillTable.Edit;

    FillTable.FieldByName('PackItemNo2').AsString := LookupTable.FieldByName('ItemNumber').AsString;

    if InitialSetup then begin
      cboPackerColour.Enabled := True;
      cboPackerColour.DropDown;
    end;
  end;  
end;

procedure TRollaBlindStage5GUI.chkMoreThanOnePackerClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if chkMoreThanOnePacker.Checked then begin
      chkSamePackers.Enabled := True;
      SetControlFocus(chkSamePackers);
    end
    else begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('PackLength').AsString := '';
      qryMain.FieldByName('PackSame').AsString := 'F';
      chkSamePackers.Enabled := False;
    end;
  end;
end;

procedure TRollaBlindStage5GUI.chkHolePlugsRequiredClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if chkHolePlugsRequired.Checked then begin
      edtHolePlugNumber.Enabled := True;
      chkFlashingRequired.Enabled := True;
      cboCasementProfileFill.Enabled := True;
      SetControlFocus(edtHolePlugNumber);
    end
    else begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('FlashRequired').AsString := 'F';
      qryMain.FieldByName('FlashMaterial').AsString := '';
      qryMain.FieldByName('CasementProfileFill').AsString := '';
      edtHolePlugNumber.Enabled := False;
      chkFlashingRequired.Enabled := False;
      cboFlashingType.Enabled := False;
      cboCasementProfileFill.Enabled := False;
    end;
  end;
end;

procedure TRollaBlindStage5GUI.chkFlashingRequiredClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if chkFlashingRequired.Checked then begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('CasementProfileFill').AsString := '';
      cboCasementProfileFill.Enabled := False;
      cboFlashingType.Enabled := True;
      cboFlashingType.DropDown;
    end
    else begin
      if not (qryMain.State in [dsEdit, dsInsert]) then
        qryMain.Edit;

      qryMain.FieldByName('FlashMaterial').AsString := '';
      cboFlashingType.Enabled := False;
      cboCasementProfileFill.Enabled := True;
    end;
  end;  
end;

procedure TRollaBlindStage5GUI.cboCasementProfileFillCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  InitialSetup := False;
  btnNext.Enabled := True;
  SetControlFocus(btnNext);
end;

procedure TRollaBlindStage5GUI.cboFlashingTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  InitialSetup := False;
  btnNext.Enabled := True;
  SetControlFocus(btnNext);
end;

procedure TRollaBlindStage5GUI.cboPackerColourCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  btnNext.Enabled := True;
  SetControlFocus(chkHolePlugsRequired);
end;

procedure TRollaBlindStage5GUI.chkSamePackersClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if chkSamePackers.Checked then
      cboPackerMaterial1.DropDown;
  end;    
end;

procedure TRollaBlindStage5GUI.btnNextClick(Sender: TObject);
begin
  inherited;
  InitialSetup := False;
end;

initialization
  RegisterClassOnce(TRollaBlindStage5GUI);
finalization
  UnRegisterClass(TRollaBlindStage5GUI);
end.
