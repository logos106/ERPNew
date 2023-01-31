unit RollaBlindStage6;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/06/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindWizard, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DBCtrls, ExtCtrls,
  DNMSpeedButton, StdCtrls, DNMPanel, Mask, wwdbedit, wwdblook, 
  wwcheckbox, StrUtils, Forms;

type
  PComponentGroup = ^TComponentGroup;

  TComponentGroup = record
    Number: TLabel;
    Qty: TwwDBEDit;
    ProfileType: TwwDBLookupCombo;
    Colour: TwwDBLookupCombo;
  end;

  TQueryNumber = (qnFirst, qnSecond, qnThird, qnFourth);

  TRollaBlindStage6GUI = class(TBaseRollaBlindWizardGUI)
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblNumber1: TLabel;
    lblNumber2: TLabel;
    lblNumber3: TLabel;
    lblNumber4: TLabel;
    lblNumber5: TLabel;
    lblNumber6: TLabel;
    lblNumber7: TLabel;
    lblNumber8: TLabel;
    lblNumber9: TLabel;
    lblNumber10: TLabel;
    edtQty1: TwwDBEdit;
    edtQty2: TwwDBEdit;
    edtQty3: TwwDBEdit;
    edtQty4: TwwDBEdit;
    edtQty5: TwwDBEdit;
    edtQty6: TwwDBEdit;
    edtQty7: TwwDBEdit;
    edtQty8: TwwDBEdit;
    edtQty9: TwwDBEdit;
    edtQty10: TwwDBEdit;
    cboProfileType1: TwwDBLookupCombo;
    cboProfileType2: TwwDBLookupCombo;
    cboProfileType3: TwwDBLookupCombo;
    cboProfileType4: TwwDBLookupCombo;
    cboProfileType5: TwwDBLookupCombo;
    cboProfileType6: TwwDBLookupCombo;
    cboProfileType7: TwwDBLookupCombo;
    cboProfileType8: TwwDBLookupCombo;
    cboProfileType9: TwwDBLookupCombo;
    cboProfileType10: TwwDBLookupCombo;
    cboColour1: TwwDBLookupCombo;
    cboColour2: TwwDBLookupCombo;
    cboColour3: TwwDBLookupCombo;
    cboColour4: TwwDBLookupCombo;
    cboColour5: TwwDBLookupCombo;
    cboColour6: TwwDBLookupCombo;
    cboColour7: TwwDBLookupCombo;
    cboColour8: TwwDBLookupCombo;
    cboColour9: TwwDBLookupCombo;
    cboColour10: TwwDBLookupCombo;
    qryProfileType: TMyQuery;
    qryProfileTypeProfileType: TStringField;
    qryColour: TMyQuery;
    qryColourColourCode: TStringField;
    qryColourProfileType: TStringField;
    qryColourStandard: TStringField;
    btnCalculate: TDNMSpeedButton;
    btnReset: TDNMSpeedButton;
    Label12: TLabel;
    edtLockPosition: TwwDBEdit;
    chkFingerGrips: TwwCheckBox;
    Label54: TLabel;
    qryCalc: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtQtyExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboProfileTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboColourBeforeDropDown(Sender: TObject);
    procedure cboColourCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure AllMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnResetClick(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    fColourGridID: Integer;
    fProfileType: string;
    fInstallType: string;
    fSubInstallType: string;
    fGuideType: string;
    fHeavyDuty: Boolean;
    CompList: TList;
    procedure AssignComponentsToList;
    function FindComponentGroupIndex(const Sender: TObject): Integer;
    procedure DisableControls;
    procedure CalculateColourGrid;
    function IsMechanicalSpringType: Boolean;
    procedure PerformEaveCalculations;
    procedure PerformSurfaceCalculations;
    procedure PerformRevealCalculations;
    procedure PerformHeavyDutyCalculations;
    procedure PerformCasementCalculations;
    procedure PerformCurtainOnlyCalculations;
    procedure PerformRollaVaultCalculations;
    procedure SelectCalculation;
    procedure GetMainTypes;
    procedure ExecuteCommonQueries;
    procedure SetClipQuantity;
    procedure ProcessMechanismQueries(const MechType: string; const QueryNumber: TQueryNumber = qnFirst);
    procedure AppendDescriptions(const Offset: Integer);
    procedure AppendCurtainOnlyDescriptions;
    procedure PerformEaveQueries;
    procedure PerformGeneralQueries;
    procedure PerformCurtainOnlyQueries;
    procedure PerformGroupQueries(const QueryList: TStrings);
    procedure SetMaxQtyFlag;
    procedure PerformSlatQueries;
    procedure InsertIntoAddSheet;
    procedure SidePlateCalc;
    procedure DividerPlateCalc(const MechType: string);
    procedure AxlePulleyCalc(const MechType: string);
    procedure BearingsCalc(const MechType: string);
    procedure AxleCalc(const MechType: string);
    procedure FunnelCalc;
    procedure EaveSupportCutCalc;
    procedure SidePlateBracingCalc;
    procedure StarterLinkDataCalc;
    procedure ColourGridCalc;
    procedure EndSlatSealCalc;
    procedure ClipsCalc;
    procedure ProfileStopsCalc(const MechType: string);
    procedure GuidesCalc;
    procedure PilesCalc;
    procedure LocksCalc(const LockType: string);
    procedure MechanismCalc(const MechType: string);
    procedure PackersCalc;
    procedure HolePlugsCalc;
    procedure SideRollersCalc;
    procedure SillCalc;
    procedure WinchBracketCalc;
    procedure HousingPanelsCalc;
    procedure PerformFinalQueries;
  public
    property ColourGridID: Integer read fColourGridID;
    property ProfileType: string read fProfileType;
    property InstallType: string read fInstallType;
    property SubInstallType: string read fSubInstallType;
    property GuideType: string read fGuideType;
    property HeavyDuty: Boolean read fHeavyDuty;
  end;

implementation

{$R *.dfm}

uses
  CommonLib, RollaBlindCutoutSheet,FastFuncs;

const
  cControlRowMax = 10;
  cComponentNotRequired = 'Component not required';
  cPrefixArray: array[1..21] of string = ('DP', 'Ax', 'Bearings', 'Axle', 'Funnel', 'ESC', 'SPB', 'StartLink',
                                          'EndSlatSeal', 'Clip', 'Clip2', 'ProfStops', 'Guide', 'Pile', 'PileES',
                                          'Lock1', 'Lock2', 'Lock3', 'LockClip', 'HP1', 'HP2');

procedure TRollaBlindStage6GUI.AssignComponentsToList;
var
  Index: Integer;
  CompGroup: PComponentGroup;
begin
  for Index := 1 to cControlRowMax do begin
    New(CompGroup);
    CompGroup.Number := TLabel(FindComponent('lblNumber' + FastFuncs.IntToStr(Index)));
    CompGroup.Qty := TwwDBEDit(FindComponent('edtQty' + FastFuncs.IntToStr(Index)));
    CompGroup.ProfileType := TwwDBLookupCombo(FindComponent('cboProfileType' + FastFuncs.IntToStr(Index)));
    CompGroup.Colour := TwwDBLookupCombo(FindComponent('cboColour' + FastFuncs.IntToStr(Index)));
    CompList.Add(CompGroup);
  end;
end;

procedure TRollaBlindStage6GUI.FormCreate(Sender: TObject);
begin
  inherited;
  fColourGridID := 0;
  fProfileType := '';
  fInstallType := '';
  fSubInstallType := '';
  fGuideType := '';
  fHeavyDuty := False;
  DataChanged := True;
  BackFormClassName := 'TRollaBlindStage5GUI';
  CompList := TList.Create;
  AssignComponentsToList;
end;

procedure TRollaBlindStage6GUI.FormDestroy(Sender: TObject);
begin
  while CompList.Count > 0 do begin
    Dispose(CompList.Items[0]);
    CompList.Delete(0);
  end;
  FreeandNil(CompList);
  inherited;  
end;

procedure TRollaBlindStage6GUI.edtQtyExit(Sender: TObject);
var
  GroupIndex: Integer;
  CompGroup: PComponentGroup;
begin
  inherited;

  if (Sender is TwwDBEDit) and (not Empty(TwwDBEdit(Sender).Text)) then begin
    TwwDBEdit(Sender).OnExit := nil;
    btnReset.Enabled := True;
    GroupIndex := FindComponentGroupIndex(Sender);

    if GroupIndex >= 0 then
      CompGroup := PComponentGroup(CompList.Items[GroupIndex])
    else
      CompGroup := nil;

    if Assigned(CompGroup) then begin
      CompGroup.ProfileType.Enabled := True;

      if InitialSetup then
        CompGroup.ProfileType.DropDown;
    end;
  end;
end;

function TRollaBlindStage6GUI.FindComponentGroupIndex(const Sender: TObject): Integer;
var
  Index: Integer;
  FoundGroup: Boolean;
begin
  Result := -1;
  Index := 0;
  FoundGroup := False;

  while (Index < CompList.Count) and (not FoundGroup) do begin
    if (Sender = PComponentGroup(CompList.Items[Index]).Qty) or
       (Sender = PComponentGroup(CompList.Items[Index]).ProfileType) or
       (Sender = PComponentGroup(CompList.Items[Index]).Colour) then begin
      Result := Index;
      FoundGroup := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TRollaBlindStage6GUI.FormShow(Sender: TObject);
begin
  inherited;
  DisableControls;
  qryMain.Append;
  qryMain.FieldByName('SheetID').AsInteger := SheetID;
  qryMain.Post;
  qryMain.Edit;
  fColourGridID := qryMain.FieldByName('ColourGridID').AsInteger;
  qryCalc.Close;
  qryCalc.ParamByname('SheetID').AsInteger := SheetID;
  qryCalc.Open;
  SetControlFocus(edtQty1);
end;

procedure TRollaBlindStage6GUI.cboProfileTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
var
  GroupIndex: Integer;
  CompGroup: PComponentGroup;
begin
  inherited;

  if (Sender is TwwDBLookupCombo) and (not Empty(TwwDBLookupCombo(Sender).Text)) then begin
    TwwDBLookupCombo(Sender).OnCloseUp := nil;
    GroupIndex := FindComponentGroupIndex(Sender);

    if GroupIndex >= 0 then
      CompGroup := PComponentGroup(CompList.Items[GroupIndex])
    else
      CompGroup := nil;

    if Assigned(CompGroup) then begin
      CompGroup.Colour.Enabled := True;

      if InitialSetup then
        CompGroup.Colour.DropDown;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.cboColourBeforeDropDown(Sender: TObject);
var
  GroupIndex: Integer;
  CompGroup: PComponentGroup;
begin
  inherited;

  if Sender is TwwDBLookupCombo then begin
    GroupIndex := FindComponentGroupIndex(Sender);

    if GroupIndex >= 0 then
      CompGroup := PComponentGroup(CompList.Items[GroupIndex])
    else
      CompGroup := nil;

    if Assigned(CompGroup) then begin
      qryColour.Close;
      qryColour.ParamByName('ProfileType').AsString := CompGroup.ProfileType.Text;
      qryColour.Open;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.cboColourCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
var
  GroupIndex: Integer;
  CompGroup: PComponentGroup;
begin
  inherited;

  if (Sender is TwwDBLookupCombo) and (not Empty(TwwDBLookupCombo(Sender).Text)) then begin
    TwwDBLookupCombo(Sender).OnCloseUp := nil;
    GroupIndex := FindComponentGroupIndex(Sender);
    Inc(GroupIndex);

    if GroupIndex < CompList.Count then
      CompGroup := PComponentGroup(CompList.Items[GroupIndex])
    else
      CompGroup := nil;

    if Assigned(CompGroup) then begin
      btnCalculate.Enabled := True;
      CompGroup.Qty.Enabled := True;
      SetControlFocus(CompGroup.Qty);
    end;
  end;
end;

procedure TRollaBlindStage6GUI.DisableControls;
var
  Index: Integer;
begin
  edtLockPosition.Enabled := False;
  chkFingerGrips.Enabled := False;
  cboProfileType1.Enabled := False;
  cboColour1.Enabled := False;

  for Index := 1 to CompList.Count - 1 do begin
    PComponentGroup(CompList.Items[Index]).Qty.Enabled := False;
    PComponentGroup(CompList.Items[Index]).ProfileType.Enabled := False;
    PComponentGroup(CompList.Items[Index]).Colour.Enabled := False;
  end;
end;

procedure TRollaBlindStage6GUI.AllMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if btnReset.Enabled then
    InitialSetup := False;
end;

procedure TRollaBlindStage6GUI.btnResetClick(Sender: TObject);
var
  Index: Integer;
begin
  inherited;

  if not (qryMain.State in [dsEdit, dsInsert]) then
    qryMain.Edit;

  for Index := 1 to cControlRowMax do begin
    qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(Index) + 'qty').AsVariant := NULL;
    qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(Index) + 'prof').AsString := '';
    qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(Index) + 'colour').AsString := '';
    PComponentGroup(CompList.Items[Index - 1]).Qty.OnExit := edtQtyExit;
    PComponentGroup(CompList.Items[Index - 1]).ProfileType.OnCloseUp := cboProfileTypeCloseUp;
    PComponentGroup(CompList.Items[Index - 1]).Colour.OnCloseUp := cboColourCloseUp;
  end;

  DisableControls;
  btnReset.Enabled := False;
  btnCalculate.Enabled := False;
  btnNext.Enabled := False;
  InitialSetup := True;
  SetControlFocus(edtQty1);
end;

procedure TRollaBlindStage6GUI.btnCalculateClick(Sender: TObject);
begin
  inherited;
  btnReset.Enabled := False;
  btnCalculate.Enabled := False;
  btnBack.Enabled := False;
  btnNext.Enabled := False;

  try
    CalculateColourGrid;
  finally
    btnReset.Enabled := True;
    btnCalculate.Enabled := True;
    btnBack.Enabled := True;
    btnNext.Enabled := True;
    edtLockPosition.Enabled := True;
    SetControlFocus(edtLockPosition);
  end;
end;

procedure TRollaBlindStage6GUI.btnNextClick(Sender: TObject);
var
  TmpComp: TComponent;
  WizardConnection: TMyConnection;
begin
  if qryMain.State in [dsEdit, dsInsert] then
    qryMain.Post;

  qryMain.Close;
  Enabled := False;

  try
    SelectCalculation;
    WizardConnection := GetWizardConnection;

    if WizardConnection.InTransaction then begin
      SaveData;
      WizardConnection.Commit;
    end;

    TmpComp := GetComponentByClassName('TRollaBlindCutoutSheetGUI');

    if Assigned(TmpComp) then begin
      with TRollaBlindCutoutSheetGUI(TmpComp) do begin
        LeadNumber := Self.txtLeadNumber.Field.AsString;
        SheetID := Self.SheetID;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;

    FreeAllFormsInList;
  finally
    Enabled := True;
  end;
end;

procedure TRollaBlindStage6GUI.CalculateColourGrid;
var
  RowIndex: Integer;
  RowCount: Integer;
  FoundNullQty: Boolean;
  FoundRollaLock: Boolean;
begin
  RowIndex := 1;
  FoundNullQty := False;
  FoundRollaLock := False;
  chkFingerGrips.Enabled := IsMechanicalSpringType;

  while (RowIndex < CompList.Count) and (not FoundRollaLock) do begin
    if FastFuncs.SameText(PComponentGroup(CompList.Items[RowIndex]).ProfileType.Text, 'Rollalock') then
      FoundRollaLock := True
    else
      Inc(RowIndex);
  end;

  edtLockPosition.Enabled := FoundRollaLock;
  RowIndex := 0;

  while (RowIndex < (CompList.Count - 1)) and (not FoundNullQty) do begin
    if (not Empty(PComponentGroup(CompList.Items[RowIndex]).Qty.Text)) and
       Empty(PComponentGroup(CompList.Items[RowIndex + 1]).Qty.Text) then
      FoundNullQty := True
    else
      Inc(RowIndex);
  end;

  if FoundNullQty then
    RowCount := RowIndex + 1
  else
    RowCount := cControlRowMax;

  if not (qryMain.State in [dsEdit, dsInsert]) then
    qryMain.Edit;

  qryMain.FieldByName('Fill1').AsFloat := qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(RowCount) + 'qty').AsFloat;
  qryMain.FieldByName('Fill2').AsString := qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(RowCount) + 'prof').AsString;
  qryMain.FieldByName('Fill3').AsString := qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(RowCount) + 'colour').AsString;
  qryMain.FieldByName('Fill4').AsString := qryMain.FieldByName('Lvl' + FastFuncs.IntToStr(RowCount) + 'colour_sp').AsString;
  qryMain.FieldByName('Fill5').AsString := 'Lvl' + FastFuncs.IntToStr(RowCount);
  qryMain.Post;
  qryMain.Close;

  for RowIndex := 1 to RowCount do
    QueryLoad.Execute('Colour1' + Chr(Ord('a') + RowIndex - 1), SheetID, ColourGridID);

  QueryLoad.Execute('Colour2a', SheetID, ColourGridID);
  QueryLoad.Execute('Colour2b', SheetID, ColourGridID);
  QueryLoad.Execute('Colour2c', SheetID, ColourGridID);
  QueryLoad.Execute('Colour3' + Chr(Ord('a') + RowCount - 1), SheetID, ColourGridID);
  qryMain.Open;
  qryMain.Locate('ColourGridID', ColourGridID, [loCaseInsensitive]);
end;

function TRollaBlindStage6GUI.IsMechanicalSpringType: Boolean;
var
  qrySpring: TMyQuery;
begin
  Result := False;
  qrySpring := TMyQuery.Create(nil);
  qrySpring.Options.FlatBuffers := True;
  try
    qrySpring.Connection := GetWizardConnection;
    qrySpring.SQL.Text := 'SELECT MechType FROM tblrollaaddsheet1 WHERE SheetID=' + FastFuncs.IntToStr(SheetID);
    qrySpring.Open;

    if not qrySpring.IsEmpty then
      Result := FastFuncs.SameText(qrySpring.FieldByName('MechType').AsString, 'Spring');

    qrySpring.Close;
  finally
    FreeandNil(qrySpring);
  end;
end;

procedure TRollaBlindStage6GUI.PerformCasementCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    SidePlateCalc;
    HousingPanelsCalc;
    DividerPlateCalc(MechType);
    AxlePulleyCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ColourGridCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(0);
    PerformGeneralQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformCurtainOnlyCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    ColourGridCalc;
    StarterLinkDataCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    LocksCalc(LockType);

    AppendCurtainOnlyDescriptions;
    PerformCurtainOnlyQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformEaveCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    if FastFuncs.SameText(FieldByName('ProfileType').AsString, 'Rollascreen') then
      FieldByName('ShutterClipped').AsString := 'F'
    else
      FieldByName('ShutterClipped').AsString := 'T';

    SidePlateCalc;
    DividerPlateCalc(MechType);
    AxlePulleyCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ColourGridCalc;

    FieldByName('PileES_Qty').AsFloat := 1;
    FieldByName('PileES_IN').AsString := '59.10';
    FieldByName('PileES_Length').AsFloat := FieldByName('ESC_Length').AsFloat;

    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(2);
    PerformEaveQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformHeavyDutyCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    SidePlateCalc;
    HousingPanelsCalc;
    DividerPlateCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    AxlePulleyCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(0);
    PerformGeneralQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformRevealCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    SidePlateCalc;
    HousingPanelsCalc;
    DividerPlateCalc(MechType);
    AxlePulleyCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ColourGridCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(0);
    PerformGeneralQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformRollaVaultCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    SidePlateCalc;
    DividerPlateCalc(MechType);
    AxlePulleyCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ColourGridCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(0);
    PerformGeneralQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.PerformSurfaceCalculations;
var
  MechType: string;
  LockType: string;
begin
  with qryCalc do begin
    MechType := FieldByName('MechType').AsString;
    LockType := FieldByName('LockType').AsString;

    SidePlateCalc;
    HousingPanelsCalc;
    DividerPlateCalc(MechType);
    AxlePulleyCalc(MechType);
    BearingsCalc(MechType);
    AxleCalc(MechType);
    FunnelCalc;
    EaveSupportCutCalc;
    SidePlateBracingCalc;
    StarterLinkDataCalc;
    ColourGridCalc;
    ExecuteCommonQueries;
    EndSlatSealCalc;
    ClipsCalc;
    ProfileStopsCalc(MechType);
    GuidesCalc;
    PilesCalc;
    LocksCalc(LockType);
    MechanismCalc(MechType);
    PackersCalc;
    HolePlugsCalc;
    SideRollersCalc;
    SillCalc;
    WinchBracketCalc;

    AppendDescriptions(0);
    PerformGeneralQueries;
    PerformFinalQueries;
  end;
end;

procedure TRollaBlindStage6GUI.SelectCalculation;
var
  StoredCursor: TCursor;
begin
  StoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  try
    GetMainTypes;
    fHeavyDuty := (FastFuncs.SameText(InstallType, 'Reveal') or FastFuncs.SameText(InstallType, 'Surface')) and FastFuncs.SameText(GuideType, 'Heavy Duty');

    if not (qryCalc.State = dsEdit) then
      qryCalc.Edit;

    if FastFuncs.SameText(InstallType, 'Eave') then
      PerformEaveCalculations
    else if FastFuncs.SameText(InstallType, 'Surface') and (not FastFuncs.SameText(GuideType, 'Heavy Duty')) then
      PerformSurfaceCalculations
    else if FastFuncs.SameText(InstallType, 'Reveal') and (not FastFuncs.SameText(GuideType, 'Heavy Duty')) then
      PerformRevealCalculations
    else if HeavyDuty then
      PerformHeavyDutyCalculations
    else if FastFuncs.SameText(InstallType, 'Casement') then
      PerformCasementCalculations
    else if FastFuncs.SameText(InstallType, 'Curtain Replacement') then
      PerformCurtainOnlyCalculations
    else if FastFuncs.SameText(InstallType, 'Rollavault') then
      PerformRollaVaultCalculations
  finally
    Screen.Cursor := StoredCursor;
  end;
end;

procedure TRollaBlindStage6GUI.GetMainTypes;
var
  qryGetTypes: TMyQuery;
begin
  qryGetTypes := TMyQuery.Create(nil);
  qryGetTypes.Options.FlatBuffers := True;
  try
    qryGetTypes.Connection := GetWizardConnection;
    qryGetTypes.SQL.Text := 'SELECT ProfileType, InstallType, SubInstallType, GuideType FROM tblrollaaddsheet1 WHERE SheetID=' + FastFuncs.IntToStr(SheetID);
    qryGetTypes.Open;

    if not qryGetTypes.IsEmpty then begin
      fProfileType := qryGetTypes.FieldByName('ProfileType').AsString;
      fInstallType := qryGetTypes.FieldByName('InstallType').AsString;
      fSubInstallType := qryGetTypes.FieldByName('SubInstallType').AsString;
      fGuideType := qryGetTypes.FieldByName('GuideType').AsString;
    end;

    qryGetTypes.Close;
  finally
    FreeandNil(qryGetTypes);
  end;
end;

procedure TRollaBlindStage6GUI.ExecuteCommonQueries;
var
  Index: Integer;
  LevelQty: array[1..cControlRowMax] of Double;
begin
  with qryCalc do begin
    if State in [dsEdit, dsInsert] then
      Post;

    Close;
    Open;

    for Index := 1 to cControlRowMax do
      LevelQty[Index] := FieldByName('Lvl' + FastFuncs.IntToStr(Index) + 'qty').AsFloat;

    Close;
    QueryLoad.Execute('A02b', SheetID);

    for Index := 1 to cControlRowMax do begin
      if LevelQty[Index] > 0 then begin
        QueryLoad.Execute('A03' + Chr(Ord('a') + Index - 1), SheetID, ColourGridID);
        QueryLoad.Execute('A04' + Chr(Ord('a') + Index - 1), SheetID);
      end;
    end;

    QueryLoad.Execute('A05b', SheetID);
    Open;
    Edit;
  end;
end;

procedure TRollaBlindStage6GUI.SetClipQuantity;
var
  qryClip: TMyQuery;
  ClipQty: Integer;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;
  qryClip := TMyQuery.Create(nil);
  qryClip.Options.FlatBuffers := True;
  try
    with qryClip do begin
      Connection := GetWizardConnection;
      SQL.Add('SELECT IF(MOD(SUM(racg.Qty), 2) = 0, SUM(racg.Qty), SUM(racg.Qty) + 1) AS SumOfQty ');
      SQL.Add('FROM tblrollaAddSheet1 ras ');
      SQL.Add('INNER JOIN tblrollaAddColGrid2 racg USING(SheetID)');
      SQL.Add('WHERE ras.SheetID=' + FastFuncs.IntToStr(SheetID));
      SQL.Add('GROUP BY racg.SheetID;');
      Open;

      if not IsEmpty then begin
        ClipQty := FieldByName('SumOfQty').AsInteger;
        Close;
        SQL.Clear;
        SQL.Add('UPDATE tblrollaAddSheet1 SET Clip_Qty = ' + FastFuncs.IntToStr(ClipQty) + ' WHERE SheetID=' + FastFuncs.IntToStr(SheetID));
        Execute;
      end;
    end;
  finally
    FreeandNil(qryClip);
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.ProcessMechanismQueries(const MechType: string; const QueryNumber: TQueryNumber);
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;

  try
    if FastFuncs.SameText(MechType, 'Winch') then begin
      case QueryNumber of
        qnFirst:
        begin
          QueryLoad.Execute('A07b', SheetID);
          QueryLoad.Execute('A07c', SheetID);
        end;

        qnSecond:
        begin
          QueryLoad.Execute('A07d', SheetID);
        end;

        qnThird:
        begin
          QueryLoad.Execute('A07e', SheetID);
        end;

        qnFourth:
        begin
          QueryLoad.Execute('A07f', SheetID);
        end;
      end;
    end
    else if FastFuncs.SameText(MechType, 'Belt') then begin
      QueryLoad.Execute('A08a', SheetID);
      QueryLoad.Execute('A08b', SheetID);
    end
    else  if FastFuncs.SameText(MechType, 'Spring') or FastFuncs.SameText(MechType, 'Motor') then begin
      QueryLoad.Execute('A09a', SheetID);
    end;

  finally
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.AppendDescriptions(const Offset: Integer);
var
  Index: Integer;
  QueryText: string;
  qryProcess: TMyQuery;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;
  qryProcess := TMyQuery.Create(nil);
  qryProcess.Options.FlatBuffers := True;
  try
    qryProcess.Connection := GetWizardConnection;
    QueryText := QueryLoad.GetQuery('A01a');
    qryProcess.SQL.Text := QueryText;

    if Assigned(qryProcess.FindParam('SheetID')) then
      qryProcess.ParamByName('SheetID').AsInteger := SheetID;

    qryProcess.Execute;

    for Index := Low(cPrefixArray) to  High(cPrefixArray) - Offset do begin
      qryProcess.SQL.Text := FastFuncs.AnsiStringReplace(QueryText, 'SP', cPrefixArray[Index], [rfReplaceAll, rfIgnoreCase]);

      if Assigned(qryProcess.FindParam('SheetID')) then
        qryProcess.ParamByName('SheetID').AsInteger := SheetID;

      qryProcess.Execute;
    end;
  finally
    FreeandNil(qryProcess);
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.AppendCurtainOnlyDescriptions;
var
  Index: Integer;
  QueryText: string;
  qryProcess: TMyQuery;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;
  qryProcess := TMyQuery.Create(nil);
  qryProcess.Options.FlatBuffers := True;
  try
    qryProcess.Connection := GetWizardConnection;
    QueryText := QueryLoad.GetQuery('A01a');

    for Index := 5 to 9 do begin
      qryProcess.SQL.Text := FastFuncs.AnsiStringReplace(QueryText, 'SP', cPrefixArray[Index], [rfReplaceAll, rfIgnoreCase]);

      if Assigned(qryProcess.FindParam('SheetID')) then
        qryProcess.ParamByName('SheetID').AsInteger := SheetID;

      qryProcess.Execute;
    end;

    for Index := 13 to 16 do begin
      qryProcess.SQL.Text := FastFuncs.AnsiStringReplace(QueryText, 'SP', cPrefixArray[Index], [rfReplaceAll, rfIgnoreCase]);

      if Assigned(qryProcess.FindParam('SheetID')) then
        qryProcess.ParamByName('SheetID').AsInteger := SheetID;

      qryProcess.Execute;
    end;
  finally
    FreeandNil(qryProcess);
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.PerformEaveQueries;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;

  try
//    QueryLoad.Execute('zA00', SheetID);
    QueryLoad.Execute('zA08', SheetID);
    QueryLoad.Execute('zA07', SheetID);
    QueryLoad.Execute('zA16', SheetID);
    QueryLoad.Execute('zA01', SheetID);
    QueryLoad.Execute('zA02', SheetID);
    QueryLoad.Execute('zA03', SheetID);
    QueryLoad.Execute('zA04', SheetID);
    QueryLoad.Execute('zA05', SheetID);
    QueryLoad.Execute('zA05a', SheetID);
    QueryLoad.Execute('zA06', SheetID);
    QueryLoad.Execute('zA10', SheetID);
    QueryLoad.Execute('zA30', SheetID);
    QueryLoad.Execute('zA09', SheetID);
    QueryLoad.Execute('zA11', SheetID);
    QueryLoad.Execute('zA12', SheetID);
    QueryLoad.Execute('zA13', SheetID);
    QueryLoad.Execute('zA14', SheetID);
    QueryLoad.Execute('zA15', SheetID);
    QueryLoad.Execute('zA17', SheetID);
    QueryLoad.Execute('zA18', SheetID);
    QueryLoad.Execute('zA19', SheetID);
    QueryLoad.Execute('zA21', SheetID);
    QueryLoad.Execute('zA22', SheetID);
    QueryLoad.Execute('zA23', SheetID);
    QueryLoad.Execute('zA24', SheetID);
    QueryLoad.Execute('zA25', SheetID);
    QueryLoad.Execute('zA26', SheetID);
  finally
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.PerformGroupQueries(const QueryList: TStrings);
var
  Index: Integer;
begin
  if Assigned(QueryList) then begin
    if qryCalc.State in [dsEdit, dsInsert] then
      qryCalc.Post;

    qryCalc.Close;

    try
      for Index := 0 to QueryList.Count - 1 do
        QueryLoad.Execute(QueryList.Strings[Index], SheetID);
    finally
      qryCalc.Open;
      qryCalc.Edit;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.SetMaxQtyFlag;
var
  MaxQty: Integer;
  qryMax: TMyQuery;
begin
  MaxQty := 0;
  qryMax := TMyQuery.Create(nil);
  qryMax.Options.FlatBuffers := True;
  try
    with qryMax do begin
      Connection := GetWizardConnection;
      SQL.Text := QueryLoad.GetQuery('A16b');
      ParamByName('SheetID').AsInteger := SheetID;
      Open;

      if not IsEmpty then begin
        MaxQty := FieldByName('MaxOfQty').AsInteger;
      end;

      Close;
      SQL.Text := QueryLoad.GetQuery('A16c');
      ParamByName('SheetID').AsInteger := SheetID;
      ParamByName('MaxQty').AsInteger := MaxQty;
      Execute;
    end;
  finally
    FreeandNil(qryMax);
  end;
end;

procedure TRollaBlindStage6GUI.PerformSlatQueries;
begin
  SetMaxQtyFlag;
  QueryLoad.Execute('A16d', SheetID);
  QueryLoad.Execute('A16d2', SheetID);
  QueryLoad.Execute('A16e', SheetID);
  QueryLoad.Execute('A16f', SheetID);
  QueryLoad.Execute('A16g', SheetID);
  InsertIntoAddSheet;
  QueryLoad.Execute('A16i', SheetID);
  QueryLoad.Execute('A16j', SheetID);
  QueryLoad.Execute('A16k', SheetID);
end;

procedure TRollaBlindStage6GUI.InsertIntoAddSheet;
var
  MaxQty: Integer;
  qryProcess: TMyQuery;
begin
  MaxQty := 0;
  qryProcess := TMyQuery.Create(nil);
  qryProcess.Options.FlatBuffers := True;
  try
    with qryProcess do begin
      Connection := GetWizardConnection;
      SQL.Text := QueryLoad.GetQuery('A16b2');
      ParamByName('SheetID').AsInteger := SheetID;
      Open;

      if not IsEmpty then begin
        MaxQty := FieldByName('MaxOfQty').AsInteger;
      end;

      Close;
      SQL.Text := QueryLoad.GetQuery('A16h');
      ParamByName('SheetID').AsInteger := SheetID;
      ParamByName('MaxQty').AsInteger := MaxQty;
      Execute;
    end;
  finally
    FreeandNil(qryProcess);
  end;
end;

procedure TRollaBlindStage6GUI.SidePlateCalc;
begin
  with qryCalc do begin
    if HeavyDuty then begin
      FieldByName('SP_Qty').AsFloat := 1;
      FieldByName('SPColour').AsString := FieldByName('SidePlateColour').AsString;
      FieldByName('SPSize').AsString := 'Heavy Duty';
      FieldByName('SP_IN').AsString := '10.08'
    end
    else begin
      FieldByName('SP_Qty').AsFloat := 1;

      if FastFuncs.SameText(InstallType, 'Eave') then
        FieldByName('SPColour').AsString := 'MF'
      else
        FieldByName('SPColour').AsString := FieldByName('SidePlateColour').AsString;

      FieldByName('SPSize').AsString := FieldByName('HiddenProfileType').AsString;

      if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Std') then
        FieldByName('SP_IN').AsString := '10.11'
      else if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Large') then
        FieldByName('SP_IN').AsString := '10.12'
      else if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Mini') then
        FieldByName('SP_IN').AsString := '10.13'
      else if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Micro') then
        FieldByName('SP_IN').AsString := '10.14'
      else
        FieldByName('SPSize').AsString := 'Needs information';
    end;
  end;
end;

procedure TRollaBlindStage6GUI.DividerPlateCalc(const MechType: string);
var
  SPSize: string;
begin
  with qryCalc do begin
    if FastFuncs.SameText(InstallType, 'Eave') or HeavyDuty then begin
      FieldByName('DP_IN').AsString := '-';
      FieldByName('DP_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(InstallType, 'Surface') or FastFuncs.SameText(InstallType, 'Reveal') or
            FastFuncs.SameText(InstallType, 'Casement') or FastFuncs.SameText(InstallType, 'Rollavault') then begin
      if FastFuncs.SameText(MechType, 'Spring') then begin
        FieldByName('DP_IN').AsString := '-';
        FieldByName('DP_Des').AsString := cComponentNotRequired;
      end
      else if FastFuncs.SameText(InstallType, 'Casement') then begin
        FieldByName('DP_Qty').AsFloat := 2;
        FieldByName('DP_IN').AsString := '10.70';
      end
      else begin
        FieldByName('DP_Qty').AsFloat := 2;
        SPSize := FieldByName('SPSize').AsString;

        if FastFuncs.SameText(SPSize, 'Large') then
          FieldByName('DP_IN').AsString := '10.68'
        else if FastFuncs.SameText(SPSize, 'Std') then
          FieldByName('DP_IN').AsString := '10.70'
        else if FastFuncs.SameText(SPSize, 'Mini') then
          FieldByName('DP_IN').AsString := '10.73'
        else if FastFuncs.SameText(SPSize, 'Micro') then
          FieldByName('DP_IN').AsString := '10.75';
      end;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.AxlePulleyCalc(const MechType: string);
var
  SPSize: string;
begin
  with qryCalc do begin
    SPSize := FieldByName('SPSize').AsString;

    if HeavyDuty then begin
      if FastFuncs.SameText(FieldByName('Axle_IN').AsString, '11.20') then
        FieldByName('Ax_IN').AsString := '11.29'
      else
        FieldByName('Ax_IN').AsString := '11.28';

      if FastFuncs.SameText(MechType, 'Winch') then
        FieldByName('Ax_Qty').AsFloat := 2
      else if FastFuncs.SameText(MechType, 'Motor') or FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Ax_Qty').AsFloat := 1;
    end
    else if FastFuncs.SameText(InstallType, 'Eave') or FastFuncs.SameText(InstallType, 'Surface') or
            FastFuncs.SameText(InstallType, 'Reveal') or FastFuncs.SameText(InstallType, 'Casement') or
            FastFuncs.SameText(InstallType, 'Rollavault') then begin
      if FastFuncs.SameText(InstallType, 'Casement') then
        FieldByName('Ax_IN').AsString := '11.31'
      else if FastFuncs.SameText(SPSize, 'Micro') then
        FieldByName('Ax_IN').AsString := '11.32'
      else
        FieldByName('Ax_IN').AsString := '11.31';

      if FastFuncs.SameText(MechType, 'Winch') or FastFuncs.SameText(MechType, 'Belt') then
        FieldByName('Ax_Qty').AsFloat := 2
      else if FastFuncs.SameText(MechType, 'Motor') or FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Ax_Qty').AsFloat := 1;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.BearingsCalc(const MechType: string);
begin
  with qryCalc do begin
    if HeavyDuty then begin
      if FastFuncs.SameText(MechType, 'Winch') then
        FieldByName('Bearings_Qty').AsFloat := 2
      else if FastFuncs.SameText(MechType, 'Motor') or FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Bearings_Qty').AsFloat := 1;

      FieldByName('Bearings_IN').AsString := '11.13';

      if FastFuncs.SameText(MechType, 'Winch') then
        FieldByName('BPlate').AsFloat := 2
      else if FastFuncs.SameText(MechType, 'Motor') or FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('BPlate').AsFloat := 1;
    end
    else if FastFuncs.SameText(InstallType, 'Eave') or FastFuncs.SameText(InstallType, 'Surface') or
            FastFuncs.SameText(InstallType, 'Reveal') or FastFuncs.SameText(InstallType, 'Casement') or
            FastFuncs.SameText(InstallType, 'Rollavault') then begin
      if FastFuncs.SameText(MechType, 'Winch') or FastFuncs.SameText(MechType, 'Belt') then
        FieldByName('Bearings_Qty').AsFloat := 2
      else if FastFuncs.SameText(MechType, 'Motor') or FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Bearings_Qty').AsFloat := 1;

      if FieldByName('ShutterWeight').AsFloat < 40 then
        FieldByName('Bearings_IN').AsString := '11.11'
      else
        FieldByName('Bearings_IN').AsString := '11.12';
    end;
  end;
end;

procedure TRollaBlindStage6GUI.AxleCalc(const MechType: string);
var
  SPSize: string;
  Mod1Width: Double;

  procedure SetAxleLengthValue;
  begin
    with qryCalc do begin
      if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then
        FieldByName('Axle_Length').AsFloat := Mod1Width + 35
      else if FastFuncs.SameText(GuideType, 'Commercial') then
        FieldByName('Axle_Length').AsFloat := Mod1Width + 65;
    end;
  end;

  procedure SetAxleItemNumberValue;
  begin
    with qryCalc do begin
      if FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Axle_IN').AsString := '11.22'
      else if FastFuncs.SameText(SPSize, 'Micro') then
        FieldByName('Axle_IN').AsString := '11.21'
      else
        FieldByName('Axle_IN').AsString := '11.20';
    end;
  end;
begin
  with qryCalc do begin
    SPSize := FieldByName('SPSize').AsString;
    Mod1Width := FieldByName('Mod1Width').AsFloat;

    if HeavyDuty then begin
      if FastFuncs.SameText(MechType, 'Winch') then begin
        FieldByName('Axle_IN').AsString := '11.20';
        FieldByName('Axle_Length').AsFloat := Mod1Width + 75;
      end
      else if FastFuncs.SameText(MechType, 'Motor') then begin
        FieldByName('Axle_IN').AsString := FieldByName('MotorAxleIn').AsString;
        FieldByName('Axle_Length').AsFloat := Mod1Width + 75;
      end
      else if FastFuncs.SameText(MechType, 'Spring') then begin
        FieldByName('Axle_IN').AsString := '11.19';
        FieldByName('Axle_Length').AsFloat := Mod1Width + 38;
      end;
    end
    else if FastFuncs.SameText(InstallType, 'Eave') then begin
      if FastFuncs.SameText(SubInstallType, 'Offset') then begin
        if FastFuncs.SameText(GuideType, 'Reveal') then
          FieldByName('Axle_Length').AsFloat := Mod1Width + 85
        else if FastFuncs.SameText(GuideType, 'Commercial') then
          FieldByName('Axle_Length').AsFloat := Mod1Width + 115;
      end
      else
        SetAxleLengthValue;

      SetAxleItemNumberValue;
    end
    else if FastFuncs.SameText(InstallType, 'Surface') or FastFuncs.SameText(InstallType, 'Reveal') or
            FastFuncs.SameText(InstallType, 'Rollavault') then begin
      SetAxleLengthValue;
      SetAxleItemNumberValue;
    end
    else if FastFuncs.SameText(InstallType, 'Casement') then begin
      FieldByName('Axle_Length').AsFloat := Mod1Width + 35;

      if FastFuncs.SameText(MechType, 'Spring') then
        FieldByName('Axle_IN').AsString := '11.22'
      else
        FieldByName('Axle_IN').AsString := '11.20';
    end;

    FieldByName('Axle_Qty').AsFloat := 1;
  end;
end;

procedure TRollaBlindStage6GUI.FunnelCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(GuideType, 'Commercial') then begin
      FieldByName('Funnel_IN').AsString := '-';
      FieldByName('Funnel_Des').AsString := cComponentNotRequired;
    end
    else begin
      FieldByName('Funnel_Qty').AsFloat := 1;

      if HeavyDuty then
        FieldByName('Funnel_IN').AsString := '11.81'
      else
        FieldByName('Funnel_IN').AsString := '11.80';
    end;
  end;
end;

procedure TRollaBlindStage6GUI.EaveSupportCutCalc;
var
  Mod1Width: Double;

  procedure AssignValues;
  begin
    with qryCalc do begin
      if FastFuncs.SameText(FieldByName('FlashRequired').AsString, 'T') then begin
        FieldByName('ESC_Qty').AsFloat := 1;
        FieldByName('ESC_IN').AsString := FieldByName('FlashItemNumber').AsString;
        FieldByName('ESC_Colour').AsString := FieldByName('FlashColour').AsString;
        FieldByName('ESC_Des').AsString := FieldByName('FlashMaterial').AsString;
      end
      else begin
        FieldByName('ESC_IN').AsString := '-';
        FieldByName('ESC_Des').AsString := cComponentNotRequired;
      end;
    end;  
  end;
begin
  with qryCalc do begin
    Mod1Width := FieldByName('Mod1Width').AsFloat;

    if FastFuncs.SameText(InstallType, 'Surface') or FastFuncs.SameText(InstallType, 'Reveal') or
       HeavyDuty then begin
      AssignValues;

      if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then
        FieldByName('ESC_Length').AsFloat := Mod1Width + 100
      else if FastFuncs.SameText(GuideType, 'Commercial') then
        FieldByName('ESC_Length').AsFloat := Mod1Width + 130
      else if FastFuncs.SameText(GuideType, 'Heavy Duty') then
        FieldByName('ESC_Length').AsFloat := Mod1Width + 128;

      FieldByName('PileES_IN').AsString := '-';
      FieldByName('PileES_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(InstallType, 'Casement') then begin
      if FastFuncs.SameText(SubInstallType, 'Eave') then
        FieldByName('FlashRequired').AsString := 'F';

      AssignValues;
      FieldByName('ESC_Length').AsFloat := Mod1Width + 140;
      FieldByName('PileES_IN').AsString := '-';
      FieldByName('PileES_Des').AsString := cComponentNotRequired;
    end
    else begin
      if FastFuncs.SameText(InstallType, 'Rollavault') then begin
        AssignValues;
        FieldByName('PileES_IN').AsString := '-';
        FieldByName('PileES_Des').AsString := cComponentNotRequired;

        if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then
          FieldByName('ESC_Length').AsFloat := Mod1Width + 100
        else if FastFuncs.SameText(GuideType, 'Commercial') then
          FieldByName('ESC_Length').AsFloat := Mod1Width + 130;
      end
      else begin
        if FastFuncs.SameText(SubInstallType, 'Offset') then begin
          if FastFuncs.SameText(GuideType, 'Reveal') then
            FieldByName('ESC_Length').AsFloat := Mod1Width + 100
          else if FastFuncs.SameText(GuideType, 'Commercial') then
            FieldByName('ESC_Length').AsFloat := Mod1Width + 130;
        end
        else begin
          if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then
            FieldByName('ESC_Length').AsFloat := Mod1Width + 100
          else if FastFuncs.SameText(GuideType, 'Commercial') then
            FieldByName('ESC_Length').AsFloat := Mod1Width + 130;
        end;

        FieldByName('ESC_Qty').AsFloat := 1;
        FieldByName('ESC_IN').AsString := '12.00';
        FieldByName('ESC_Colour').AsString := 'WB';
      end;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.SidePlateBracingCalc;
var
  Mod1Width: Double;
begin
  with qryCalc do begin
    Mod1Width := FieldByName('Mod1Width').AsFloat;

    if FastFuncs.SameText(InstallType, 'Eave') then begin
      if FastFuncs.SameText(SubInstallType, 'Offset') then begin
        if FastFuncs.SameText(GuideType, 'Reveal') then
          FieldByName('SPB_Length').AsFloat := Mod1Width + 138
        else if FastFuncs.SameText(GuideType, 'Commercial') then
          FieldByName('SPB_Length').AsFloat := Mod1Width + 168;
      end
      else begin
        if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then
          FieldByName('SPB_Length').AsFloat := Mod1Width + 88
        else if FastFuncs.SameText(GuideType, 'Commercial') then
          FieldByName('SPB_Length').AsFloat := Mod1Width + 118;
      end;

      FieldByName('SPB_Qty').AsFloat := 1;
      FieldByName('SPB_IN').AsString := '60.00';
      FieldByName('SPB_Colour').AsString := 'MF';
    end
    else begin
      FieldByName('SPB_IN').AsString := '-';
      FieldByName('SPB_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.StarterLinkDataCalc;
begin
  with qryCalc do begin
    if not FastFuncs.SameText(ProfileType, 'Rollascreen') then begin
      if FastFuncs.SameText(FieldByName('StarterLink').AsString, 'Standard') then
        FieldByName('StartLink_IN').AsString := '30.01'
      else if FastFuncs.SameText(FieldByName('StarterLink').AsString, 'Spring') then
        FieldByName('StartLink_IN').AsString := '30.03';
    end;
  end;
end;

procedure TRollaBlindStage6GUI.ColourGridCalc;
var
  Mod1Width: Double;
begin
  with qryCalc do begin
    Mod1Width := FieldByName('Mod1Width').AsFloat;

    if FastFuncs.SameText(ProfileType, 'Rollascreen') then begin
      if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then begin
        FieldByName('Lvl1qty').AsFloat := 1;
        FieldByName('Lvl1prof').AsString := 'Bottom Bar';
        FieldByName('Lvl1_IN').AsString := '44.52';

        if FastFuncs.SameText(InstallType, 'Eave') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + 30
        else if FastFuncs.SameText(InstallType, 'Surface') or FastFuncs.SameText(InstallType, 'Casement') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + 40
        else if FastFuncs.SameText(InstallType, 'Curtain Only') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + FieldByName('CurtainFigure').AsFloat;
      end
      else if FastFuncs.SameText(GuideType, 'Commercial') then begin
        FieldByName('Lvl1qty').AsFloat := 1;
        FieldByName('Lvl1prof').AsString := 'Bottom Bar';
        FieldByName('Lvl1_IN').AsString := '44.52';

        if FastFuncs.SameText(InstallType, 'Eave') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + 60
        else if FastFuncs.SameText(InstallType, 'Surface') or FastFuncs.SameText(InstallType, 'Casement') or FastFuncs.SameText(InstallType, 'Rollavault') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + 70
        else if FastFuncs.SameText(InstallType, 'Curtain Only') then
          FieldByName('Lvl1_Length').AsFloat := Mod1Width + FieldByName('CurtainFigure').AsFloat;
      end;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.EndSlatSealCalc;
begin
  with qryCalc do begin
    if HeavyDuty then begin
      FieldByName('EndSlatSeal_Qty').AsFloat := 1;
      FieldByName('EndSlatSeal_IN').AsString := '30.11';
      FieldByName('EndSlatSeal_Length').AsFloat := FieldByName('Mod1Width').AsFloat + 42;
    end
    else if FastFuncs.SameText(ProfileType, 'Rollascreen') then begin
      FieldByName('EndSlatSeal_Qty').AsFloat := 1;
      FieldByName('EndSlatSeal_IN').AsString := '30.12';
      FieldByName('EndSlatSeal_Length').AsFloat := FieldByName('Lvl1_Length').AsFloat;
    end
    else begin
      FieldByName('EndSlatSeal_Qty').AsFloat := 1;
      FieldByName('EndSlatSeal_IN').AsString := '30.11';
      FieldByName('EndSlatSeal_Length').AsFloat := FieldByName('Lvl1_Length').AsFloat;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.ClipsCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(ProfileType, 'Series1') or FastFuncs.SameText(ProfileType, 'Series2') or FastFuncs.SameText(ProfileType, 'Series2 Grooved') then begin
      FieldByName('Clip_IN').AsString := '32.21';
      FieldByName('Clip2_IN').AsString := '-';
      FieldByName('Clip2_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(ProfileType, 'Rollamesh Std') or FastFuncs.SameText(ProfileType, 'Rollamite Std') then begin
      FieldByName('Clip_IN').AsString := '32.23';
      FieldByName('Clip2_IN').AsString := '-';
      FieldByName('Clip2_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(ProfileType, 'Rollamesh Rev') or FastFuncs.SameText(ProfileType, 'Rollamite Rev') then begin
      FieldByName('Clip_IN').AsString := '32.23';
      FieldByName('Clip2_IN').AsString := '32.24';
    end
    else if FastFuncs.SameText(ProfileType, 'Rollasafe') then begin
      FieldByName('Clip_IN').AsString := '32.25';
      FieldByName('Clip2_IN').AsString := '-';
      FieldByName('Clip2_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(ProfileType, 'Rollalock') then begin
      FieldByName('Clip_IN').AsString := '30.51';
      FieldByName('Clip2_IN').AsString := '-';
      FieldByName('Clip2_Des').AsString := cComponentNotRequired;
    end;

    SetClipQuantity;
  end;
end;

procedure TRollaBlindStage6GUI.ProfileStopsCalc(const MechType: string);
begin
  with qryCalc do begin
    if FastFuncs.SameText(MechType, 'Motor') then begin
      FieldByName('ProfStops_IN').AsString := '-';
      FieldByName('ProfStops_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(FieldByName('StopsType').AsString, 'Standard') then begin
      FieldByName('ProfStops_Qty').AsFloat := 1;
      FieldByName('ProfStops_IN').AsString := '32.01';
    end
    else begin
      FieldByName('ProfStops_Qty').AsFloat := 1;
      FieldByName('ProfStops_IN').AsString := '32.02';
    end;
  end;
end;

procedure TRollaBlindStage6GUI.GuidesCalc;
begin
  with qryCalc do begin
    if HeavyDuty then begin
      FieldByName('Guide_Qty').AsFloat := 2;
      FieldByName('Guide_IN').AsString := '50.70';
      FieldByName('Guide_Length').AsFloat := FieldByName('Mod1Height').AsFloat + 30;
      FieldByName('Guide_Colour').AsString := FieldByName('AlExtColour').AsString;
    end
    else if FastFuncs.SameText(InstallType, 'Casement') then begin
      FieldByName('Guide_Qty').AsFloat := 2;
      FieldByName('Guide_IN').AsString := '50.66';
      FieldByName('Guide_Length').AsFloat := FieldByName('Mod1Height').AsFloat;
      FieldByName('Guide_Colour').AsString := FieldByName('AlExtColour').AsString;
    end
    else if FastFuncs.SameText(GuideType, 'Surface') then begin
      FieldByName('Guide_Qty').AsFloat := 2;
      FieldByName('Guide_IN').AsString := '50.65';
      FieldByName('Guide_Length').AsFloat := FieldByName('Mod1Height').AsFloat + 30;
      FieldByName('Guide_Colour').AsString := FieldByName('AlExtColour').AsString;
    end
    else if FastFuncs.SameText(GuideType, 'Reveal') then begin
      FieldByName('Guide_Qty').AsFloat := 2;
      FieldByName('Guide_IN').AsString := '50.66';
      FieldByName('Guide_Length').AsFloat := FieldByName('Mod1Height').AsFloat + 30;
      FieldByName('Guide_Colour').AsString := FieldByName('AlExtColour').AsString;
    end
    else if FastFuncs.SameText(GuideType, 'Commercial') then begin
      FieldByName('Guide_Qty').AsFloat := 2;
      FieldByName('Guide_IN').AsString := '50.68';
      FieldByName('Guide_Length').AsFloat := FieldByName('Mod1Height').AsFloat + 60;
      FieldByName('Guide_Colour').AsString := FieldByName('AlExtColour').AsString;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.PilesCalc;
begin
  with qryCalc do begin
    FieldByName('Pile_Qty').AsFloat := 4;
    FieldByName('Pile_IN').AsString := '59.01';
    FieldByName('Pile_Length').AsFloat := FieldByName('Guide_Length').AsFloat;
  end;
end;

procedure TRollaBlindStage6GUI.LocksCalc(const LockType: string);
begin
  with qryCalc do begin
    if FastFuncs.SameText(LockType, 'None') then begin
      FieldByName('Lock1_IN').AsString := '-';
      FieldByName('Lock2_IN').AsString := '-';
      FieldByName('Lock3_IN').AsString := '-';
      FieldByName('LockClip_IN').AsString := '-';
      FieldByName('Lock1_Des').AsString := cComponentNotRequired;
      FieldByName('Lock2_Des').AsString := cComponentNotRequired;
      FieldByName('Lock3_Des').AsString := cComponentNotRequired;
      FieldByName('LockClip_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(LockType, 'Standard') then begin
      FieldByName('Lock1_Qty').AsFloat := 1;
      FieldByName('Lock1_IN').AsString := '30.30';
      FieldByName('Lock2_Qty').AsFloat := 1;
      FieldByName('Lock2_IN').AsString := '30.40';
      FieldByName('Lock3_IN').AsString := '-';
      FieldByName('Lock3_Des').AsString := cComponentNotRequired;
      FieldByName('LockClip_Qty').AsFloat := 2;
      FieldByName('LockClip_IN').AsString := '30.51';
    end
    else if FastFuncs.SameText(LockType, 'Key') then begin
      FieldByName('Lock1_Qty').AsFloat := 1;
      FieldByName('Lock1_IN').AsString := '30.30';
      FieldByName('Lock2_Qty').AsFloat := 1;
      FieldByName('Lock2_IN').AsString := '30.40';
      FieldByName('Lock3_Qty').AsFloat := 1;
      FieldByName('Lock3_IN').AsString := '30.29';
      FieldByName('LockClip_Qty').AsFloat := 2;
      FieldByName('LockClip_IN').AsString := '30.51';
    end
    else if FastFuncs.SameText(LockType, 'Patio Bolt') then begin
      FieldByName('Lock1_Qty').AsFloat := 1;
      FieldByName('Lock1_IN').AsString := '30.28';
      FieldByName('Lock2_IN').AsString := '-';
      FieldByName('Lock2_Des').AsString := cComponentNotRequired;
      FieldByName('Lock3_IN').AsString := '-';
      FieldByName('Lock3_Des').AsString := cComponentNotRequired;
      FieldByName('LockClip_IN').AsString := '-';
      FieldByName('LockClip_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.MechanismCalc(const MechType: string);
var
  CableRoller: string;
begin
  with qryCalc do begin
    CableRoller := FieldByName('CableRoller').AsString;

    if FastFuncs.SameText(MechType, 'Winch') then begin
      ProcessMechanismQueries(MechType, qnFirst);
      FieldByName('Mech1_Des').AsString := FieldByName('MechDescription').AsString;
      FieldByName('Mech1_Qty').AsFloat := 1;
      FieldByName('Mech3_Qty').AsFloat := 1;
      FieldByName('Mech3_IN').AsString := '22.55';
      ProcessMechanismQueries(MechType, qnSecond);
      FieldByName('Mech4_Qty').AsFloat := 1;
      FieldByName('Mech4_IN').AsString := '22.70';
      FieldByName('Mech4_Length').AsFloat := (FieldByName('Mod1Height').AsFloat * 2) + 500;
      ProcessMechanismQueries(MechType, qnThird);

      if FastFuncs.SameText(CableRoller, 'Cable Roller Surface') then begin
        FieldByName('Mech5_Qty').AsFloat := 1;
        FieldByName('Mech5_IN').AsString := '22.50';
        FieldByName('Mech5_Des').AsString := CableRoller;
      end
      else if FastFuncs.SameText(CableRoller, 'Cable Roller Reveal') then begin
        FieldByName('Mech5_Qty').AsFloat := 1;
        FieldByName('Mech5_IN').AsString := '22.51';
        FieldByName('Mech5_Des').AsString := CableRoller;
      end
      else begin
        FieldByName('Mech5_Qty').AsFloat := 1;
        FieldByName('Mech5_IN').AsString := '22.52';
        FieldByName('Mech5_Des').AsString := CableRoller;
      end;

      ProcessMechanismQueries(MechType, qnFourth);
    end
    else if FastFuncs.SameText(MechType, 'Belt') then begin
      FieldByName('Mech1_Qty').AsFloat := 1;
      FieldByName('Mech1_IN').AsString := '20.35';
      FieldByName('Mech2_Qty').AsFloat := 1;
      FieldByName('Mech2_IN').AsString := '20.20';
      ProcessMechanismQueries(MechType);
      FieldByName('Mech3_IN').AsString := '-';
      FieldByName('Mech3_Des').AsString := cComponentNotRequired;
      FieldByName('Mech4_IN').AsString := '-';
      FieldByName('Mech4_Des').AsString := cComponentNotRequired;
      FieldByName('Mech5_IN').AsString := '-';
      FieldByName('Mech5_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(MechType, 'Spring') then begin
      ProcessMechanismQueries(MechType);
      FieldByName('Mech2_IN').AsString := '-';
      FieldByName('Mech2_Des').AsString := cComponentNotRequired;
      FieldByName('Mech3_IN').AsString := '-';
      FieldByName('Mech3_Des').AsString := cComponentNotRequired;
      FieldByName('Mech4_IN').AsString := '-';
      FieldByName('Mech4_Des').AsString := cComponentNotRequired;
      FieldByName('Mech5_IN').AsString := '-';
      FieldByName('Mech5_Des').AsString := cComponentNotRequired;
    end
    else if FastFuncs.SameText(MechType, 'Motor') then begin
      ProcessMechanismQueries(MechType);
      FieldByName('LockType').AsString := 'None';
      FieldByName('Mech2_IN').AsString := '21.60';
      FieldByName('Mech2_Des').AsString := 'MOTOR SWITCH - FIXED POSITION';
      FieldByName('Mech3_IN').AsString := '-';
      FieldByName('Mech3_Des').AsString := cComponentNotRequired;
      FieldByName('Mech4_IN').AsString := '-';
      FieldByName('Mech4_Des').AsString := cComponentNotRequired;
      FieldByName('Mech5_IN').AsString := '-';
      FieldByName('Mech5_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.PackersCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(FieldByName('PackRequired').AsString, 'T') then begin
      FieldByName('Pack_IN').AsString := FieldByName('PackItemNo').AsString;
      FieldByName('Pack_Des').AsString := FieldByName('PackMaterial1').AsString;
      FieldByName('Pack_Colour').AsString := FieldByName('PackColour').AsString;

      if HeavyDuty then
        FieldByName('Pack_Length').AsFloat := FieldByName('Mod1Height').AsFloat + 302
      else
        FieldByName('Pack_Length').AsFloat := FieldByName('PackLength').AsFloat;

      if FastFuncs.SameText(FieldByName('PackMore').AsString, 'F') then
        FieldByName('Pack_Qty').AsFloat := 1
      else if FastFuncs.SameText(FieldByName('PackSame').AsString, 'T') then
        FieldByName('Pack_Qty').AsFloat := 2
      else
        FieldByName('Pack_Qty').AsFloat := 1;
    end
    else begin
      FieldByName('Pack_IN').AsString := '-';
      FieldByName('Pack_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.HolePlugsCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(FieldByName('HolePlugsRequired').AsString, 'T') then begin
      FieldByName('HPlugs_Qty').AsFloat := FieldByName('HolePlugNumber').AsFloat;
      FieldByName('HPlugs_IN').AsString := '59.20';
      FieldByName('HPlugs_Des').AsString := 'HOLE PLUG - 10mm';
      FieldByName('HPlugs_Colour').AsString := FieldByName('HolePlugColour').AsString;
    end
    else begin
      FieldByName('HPlugs_IN').AsString := '-';
      FieldByName('HPlugs_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.SideRollersCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Large') then begin
      if FastFuncs.SameText(ProfileType, 'Rollamesh Rev') or FastFuncs.SameText(ProfileType, 'Rollamite Rev') or
         FastFuncs.SameText(ProfileType, 'Rollamesh Std') or FastFuncs.SameText(ProfileType, 'Rollamite Std') or
         FastFuncs.SameText(ProfileType, 'Rollalock') then begin
        FieldByName('SR_Qty').AsFloat := 1;
        FieldByName('SR_IN').AsString := '11.90';
        FieldByName('SR_Des').AsString := 'SIDE ROLLER - STANDARD';
      end;
    end
    else if FastFuncs.SameText(FieldByName('SPSize').AsString, 'Heavy Duty') then begin
      if FastFuncs.SameText(ProfileType, 'Rollamesh Rev') or FastFuncs.SameText(ProfileType, 'Rollamite Rev') or
         FastFuncs.SameText(ProfileType, 'Rollamesh Std') or FastFuncs.SameText(ProfileType, 'Rollamite Std') or
         FastFuncs.SameText(ProfileType, 'Rollalock') or FastFuncs.SameText(ProfileType, 'Rollasafe') then begin
        FieldByName('SR_Qty').AsFloat := 1;
        FieldByName('SR_IN').AsString := '11.95';
        FieldByName('SR_Des').AsString := 'SIDE ROLLER - HEAVY DUTY';
      end;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.SillCalc;
begin
  with qryCalc do begin
    if FastFuncs.SameText(InstallType, 'Casement') then begin
      FieldByName('SillRequired').AsString := 'T';
      FieldByName('Sill_Qty').AsFloat := 1;
      FieldByName('Sill_IN').AsString := '10.60';
      FieldByName('Sill_Des').AsString := 'CASEMENT SILL';
      FieldByName('Sill_Length').AsFloat := FieldByName('Mod1Width').AsFloat + 150;
      FieldByName('Sill_Colour').AsString := 'SP';
    end
    else if FastFuncs.SameText(FieldByName('SillRequired').AsString, 'T') then begin
      FieldByName('Sill_Qty').AsFloat := 1;
      FieldByName('Sill_IN').AsString := FieldByName('SillItemNumber').AsString;
      FieldByName('Sill_Des').AsString := FieldByName('SillMaterial').AsString;
      FieldByName('Sill_Length').AsFloat := FieldByName('SillLength').AsFloat;
      FieldByName('Sill_Colour').AsString := FieldByName('SillColour').AsString;
    end
    else begin
      FieldByName('Sill_IN').AsString := '-';
      FieldByName('Sill_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.WinchBracketCalc;
begin
  with qryCalc do begin
    if not FastFuncs.SameText(FieldByName('WBMaterial').AsString, 'None') then begin
      FieldByName('WB_Qty').AsFloat := 1;
      FieldByName('WB_IN').AsString := FieldByName('WBItemNo').AsString;;
      FieldByName('WB_Des').AsString := FieldByName('WBMaterial').AsString;;
      FieldByName('WB_Length').AsFloat := FieldByName('WBLength').AsFloat;
    end
    else begin
      FieldByName('WB_IN').AsString := '-';
      FieldByName('WB_Des').AsString := cComponentNotRequired;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.HousingPanelsCalc;
var
  SPSize: string;
  Mod1Width: Double;
begin
  with qryCalc do begin
    SPSize := FieldByName('SPSize').AsString;
    Mod1Width := FieldByName('Mod1Width').AsFloat;
    FieldByName('HP1_Qty').AsFloat := 1;
    FieldByName('HP1_Colour').AsString := FieldByName('SidePlateColour').AsString;
    FieldByName('HP2_Qty').AsFloat := 1;
    FieldByName('HP2_Colour').AsString := FieldByName('SidePlateColour').AsString;

    if HeavyDuty then begin
      FieldByName('HP1_IN').AsString := '10.20';
      FieldByName('HP2_IN').AsString := '10.21';
    end
    else if FastFuncs.SameText(SPSize, 'Std') then begin
      FieldByName('HP1_IN').AsString := '10.46';
      FieldByName('HP2_IN').AsString := '10.47';
    end
    else if FastFuncs.SameText(SPSize, 'Large') then begin
      FieldByName('HP1_IN').AsString := '10.42';
      FieldByName('HP2_IN').AsString := '10.43';
    end
    else if FastFuncs.SameText(SPSize, 'Mini') then begin
      FieldByName('HP1_IN').AsString := '10.48';
      FieldByName('HP2_IN').AsString := '10.49';
    end
    else if FastFuncs.SameText(SPSize, 'Micro') then begin
      FieldByName('HP1_IN').AsString := '10.54';
      FieldByName('HP2_IN').AsString := '10.55';
    end;

    if HeavyDuty then begin
      FieldByName('HP1_Length').AsFloat := Mod1Width + 128;
      FieldByName('HP2_Length').AsFloat := Mod1Width + 128;
    end
    else if FastFuncs.SameText(GuideType, 'Reveal') or FastFuncs.SameText(GuideType, 'Surface') then begin
      FieldByName('HP1_Length').AsFloat := Mod1Width + 88;
      FieldByName('HP2_Length').AsFloat := Mod1Width + 88;
    end
    else if FastFuncs.SameText(GuideType, 'Commercial') then begin
      FieldByName('HP1_Length').AsFloat := Mod1Width + 118;
      FieldByName('HP2_Length').AsFloat := Mod1Width + 118;
    end;
  end;
end;

procedure TRollaBlindStage6GUI.PerformGeneralQueries;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;

  try
//    QueryLoad.Execute('zA00', SheetID);
    QueryLoad.Execute('zA01a', SheetID);
    QueryLoad.Execute('zA01b', SheetID);
    QueryLoad.Execute('zA08', SheetID);
    QueryLoad.Execute('zA07', SheetID);
    QueryLoad.Execute('zA16', SheetID);
    QueryLoad.Execute('zA01', SheetID);
    QueryLoad.Execute('zA02', SheetID);
    QueryLoad.Execute('zA03', SheetID);
    QueryLoad.Execute('zA04', SheetID);
    QueryLoad.Execute('zA05', SheetID);
    QueryLoad.Execute('zA05a', SheetID);
    QueryLoad.Execute('zA06', SheetID);
    QueryLoad.Execute('zA10', SheetID);
    QueryLoad.Execute('zA30', SheetID);
    QueryLoad.Execute('zA09', SheetID);
    QueryLoad.Execute('zA11', SheetID);
    QueryLoad.Execute('zA12', SheetID);
    QueryLoad.Execute('zA13', SheetID);
    QueryLoad.Execute('zA14', SheetID);
    QueryLoad.Execute('zA15', SheetID);
    QueryLoad.Execute('zA17', SheetID);
    QueryLoad.Execute('zA18', SheetID);
    QueryLoad.Execute('zA19', SheetID);
    QueryLoad.Execute('zA21', SheetID);
    QueryLoad.Execute('zA22', SheetID);
    QueryLoad.Execute('zA23', SheetID);
    QueryLoad.Execute('zA24', SheetID);
    QueryLoad.Execute('zA25', SheetID);
    QueryLoad.Execute('zA26', SheetID);

    if HeavyDuty then
      QueryLoad.Execute('zA04a', SheetID)
    else if FastFuncs.SameText(InstallType, 'Casement') then
      QueryLoad.Execute('zA01c', SheetID);
  finally
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.PerformCurtainOnlyQueries;
begin
  if qryCalc.State in [dsEdit, dsInsert] then
    qryCalc.Post;

  qryCalc.Close;

  try
//    QueryLoad.Execute('zA00', SheetID);
    QueryLoad.Execute('zA05a', SheetID);
    QueryLoad.Execute('zA06', SheetID);
    QueryLoad.Execute('zA10', SheetID);
    QueryLoad.Execute('zA11', SheetID);
    QueryLoad.Execute('zA12', SheetID);
    QueryLoad.Execute('zA13', SheetID);
    QueryLoad.Execute('zA17', SheetID);
    QueryLoad.Execute('zA18', SheetID);
    QueryLoad.Execute('zA19', SheetID);
    QueryLoad.Execute('zA21', SheetID);
  finally
    qryCalc.Open;
    qryCalc.Edit;
  end;
end;

procedure TRollaBlindStage6GUI.PerformFinalQueries;
var
  MechType: string;
  QueryList: TStringList;
begin
  with qryCalc do begin
    QueryList := TStringList.Create;

    try
      if FastFuncs.SameText(InstallType, 'Curtain Replacement') then begin
        QueryList.Add('zA09');
        QueryList.Add('zA46');
        QueryList.Add('zA47');
        QueryList.Add('zA48');
      end
      else begin
        if FastFuncs.SameText(FieldByName('CableRoller').AsString, 'Cable Roller Open') then
          QueryList.Add('zA26a');

        if FastFuncs.SameText(FieldByName('PackRequired').AsString, 'T') and FastFuncs.SameText(FieldByName('PackMore').AsString, 'T') and
           FastFuncs.SameText(FieldByName('PackSame').AsString, 'F')then begin
          QueryList.Add('zA37');
        end;

        QueryList.Add('zA27');
        QueryList.Add('zA28');
        QueryList.Add('zA29');
        QueryList.Add('zA31');
        QueryList.Add('zA32');

        if FastFuncs.SameText(InstallType, 'Eave') and FastFuncs.SameText(SubInstallType, 'Offset') then begin
          QueryList.Add('zA33');
          QueryList.Add('zA34');
          QueryList.Add('zA35');
        end;

        if FastFuncs.SameText(FieldByName('GuideCapsRequired').AsString, 'T') then
          QueryList.Add('zA36');

        if FastFuncs.SameText(InstallType, 'Casement') then begin
          QueryList.Add('zA38');
          QueryList.Add('zA39');
          QueryList.Add('zA40');
          QueryList.Add('zA41');

          if FastFuncs.SameText(FieldByName('CasementProfileFill').AsString, 'Mesh') then
            QueryList.Add('zA42a')
          else if FastFuncs.SameText(FieldByName('CasementProfileFill').AsString, 'Series1') then
            QueryList.Add('zA42b')
          else if FastFuncs.SameText(FieldByName('CasementProfileFill').AsString, 'Rollascreen') then
            QueryList.Add('zA42c');

          QueryList.Add('zA43');
          QueryList.Add('zA44');

          if FastFuncs.SameText(SubInstallType, 'Surface') then
            QueryList.Add('zA45')
        end
        else if FastFuncs.SameText(InstallType, 'Rollavault') and FastFuncs.SameText(SubInstallType, 'Partial Eave') then
          QueryList.Add('zA49');

        QueryList.Add('A16a');
      end;

      PerformGroupQueries(QueryList);
      PerformSlatQueries;
      QueryList.Clear;

      if FastFuncs.SameText(FieldByName('Perforated').AsString, 'F') then begin
        QueryList.Add('A21b1');
        QueryList.Add('A21b');
      end;

      QueryList.Add('A19a');

      if FieldByName('WinchPosition').AsString <> '' then begin
        MechType := FieldByName('MechType').AsString;

        if FastFuncs.SameText(MechType, 'Winch') then
          QueryList.Add('UpdateRemarks')
        else if FastFuncs.SameText(MechType, 'Motor') then
          QueryList.Add('UpdateRemarks2')
        else if FastFuncs.SameText(MechType, 'Belt') then
          QueryList.Add('UpdateRemarks3');
      end;

      PerformGroupQueries(QueryList);
    finally
      FreeandNil(QueryList);
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindStage6GUI);
finalization
  UnRegisterClass(TRollaBlindStage6GUI);
end.
