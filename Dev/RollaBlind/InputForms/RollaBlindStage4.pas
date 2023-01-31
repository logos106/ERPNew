unit RollaBlindStage4;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 02/06/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DBCtrls, ExtCtrls,
  DNMSpeedButton, StdCtrls, DNMPanel, wwdblook, Mask, wwdbedit, wwcheckbox,
  Wwdotdot, Wwdbcomb, Forms;

type
  TRollaBlindStage4GUI = class(TBaseRollaBlindWizardGUI)
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Bevel4: TBevel;
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
    Label9: TLabel;
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
    chkSillRequired: TwwCheckBox;
    Label41: TLabel;
    Label42: TLabel;
    edtSillLength: TwwDBEdit;
    qrySillMaterial: TMyQuery;
    Label43: TLabel;
    cboSillMaterial: TwwDBLookupCombo;
    qrySillMaterialDescription: TStringField;
    qrySillColour: TMyQuery;
    Label44: TLabel;
    cboSillColour: TwwDBLookupCombo;
    qrySillColourColourCode: TStringField;
    qrySillColourDescription: TStringField;
    qrySillMaterialItemNumber: TStringField;
    chkGuideCaps: TwwCheckBox;
    Label45: TLabel;
    Label46: TLabel;
    cboStopsType: TwwDBComboBox;
    qrySillColourItemID: TIntegerField;
    qrySillMaterialItemID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure cboSillMaterialCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chkSillRequiredClick(Sender: TObject);
    procedure edtSillLengthExit(Sender: TObject);
    procedure cboSillColourCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboStopsTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib;

procedure TRollaBlindStage4GUI.FormCreate(Sender: TObject);
begin
  inherited;
  DataChanged := True;
  NextFormClassName := 'TRollaBlindStage5GUI';
  BackFormClassName := 'TRollaBlindStage3GUI';
end;

procedure TRollaBlindStage4GUI.cboSillMaterialCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  qrySillColour.Close;
  qrySillColour.ParamByName('ItemID').AsString := LookupTable.FieldByName('ItemID').AsString;
  qrySillColour.Open;

  if InitialSetup and (not Empty(cboSillMaterial.Text)) then begin
    cboSillColour.Enabled := True;
    cboSillColour.DropDown;
  end;
end;

procedure TRollaBlindStage4GUI.FormShow(Sender: TObject);
begin
  inherited;

  if InitialSetup then begin
    qryMain.Close;
    QueryLoad.Execute('AddSheet1k', SheetID);
    qryMain.Open;
    qryMain.Locate('SheetID', SheetID, [loCaseInsensitive]);
    edtSillLength.Enabled := False;
    cboSillMaterial.Enabled := False;
    cboSillColour.Enabled := False;
    SetControlFocus(chkSillRequired);
  end;
end;

procedure TRollaBlindStage4GUI.chkSillRequiredClick(Sender: TObject);
begin
  inherited;

  if qryMain.Active and (not (fsShowing in FormState)) then begin
    if not (qryMain.State in [dsEdit, dsInsert]) then
      qryMain.Edit;

    if chkSillRequired.Checked then begin
      edtSillLength.Enabled := True;
      cboSillMaterial.Enabled := True;
      qryMain.FieldByName('GuideCapsRequired').AsString := 'F';
      chkGuideCaps.Enabled := False;

      if InitialSetup then
        cboSillMaterial.DropDown
      else
        cboSillColour.Enabled := True;
    end
    else begin
      qryMain.FieldByName('SillMaterial').AsString := '';
      qryMain.FieldByName('SillColour').AsString := '';
      edtSillLength.Enabled := False;
      cboSillMaterial.Enabled := False;
      cboSillColour.Enabled := False;
      chkGuideCaps.Enabled := True;
    end;
  end;  
end;

procedure TRollaBlindStage4GUI.edtSillLengthExit(Sender: TObject);
begin
  inherited;

  if InitialSetup and (not Empty(edtSillLength.Text)) then begin
    cboSillMaterial.Enabled := True;
    cboSillMaterial.DropDown;
  end;
end;

procedure TRollaBlindStage4GUI.cboSillColourCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if InitialSetup and (not Empty(cboSillColour.Text)) then begin
    cboStopsType.Enabled := True;
    cboStopsType.DropDown;
  end;
end;

procedure TRollaBlindStage4GUI.cboStopsTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;

  if not Empty(cboStopsType.Text) then begin
    InitialSetup := False;
    btnNext.Enabled := True;
    SetControlFocus(btnNext);
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindStage4GUI);
finalization
  UnRegisterClass(TRollaBlindStage4GUI);
end.
