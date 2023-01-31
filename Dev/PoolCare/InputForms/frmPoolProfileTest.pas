unit frmPoolProfileTest;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //23/03/05  1.00.00  BJ  Initial verson.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  Wwdatsrc, MemDS, wwdblook, Mask, wwdbedit, ActnList, PoolData, BaseAlgae,
  BaseDefault, BaseMetalMSA, BaseResults, BaseOtherDefaults, MAth,
  Wwdotdot, Wwdbcomb, ComCtrls, DBCtrls, PrintDAT, Menus, AdvMenus, Shader;


type
  TfmPoolProfileTest = class(TBaseInputGUI)
    qryPoolProfileTests: TMyQuery;
    dsPoolProfileTests: TwwDataSource;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    actCustomer: TAction;
    acTests: TAction;
    qryAlgaetype: TMyQuery;
    qryAlgaetypeAlgaeDefaultID: TIntegerField;
    qryAlgaetypeAlgaeName: TStringField;
    actReset: TAction;
    actProcess: TAction;
    qryPoolProfileTestsAlgaeDefaultID: TIntegerField;
    qryPoolProfileTestsPoolProfileID: TIntegerField;
    qryPoolProfileTestsDateOfTest: TDateField;
    qryPoolProfileTestsActive: TStringField;
    qryPoolProfileTestsNotes: TStringField;
    qryPoolProfileTestsGlobalRef: TStringField;
    qryPoolProfileTestsSI: TFloatField;
    qryPoolProfileTestsNewSI: TFloatField;
    qryPoolProfileTestsAlgae1P: TStringField;
    qryPoolProfileTestsAlgae2P: TStringField;
    qryPoolProfileTestsCalciumP: TStringField;
    qryPoolProfileTestsTotalAlkP: TStringField;
    qryPoolProfileTestsStabilizerP: TStringField;
    qryPoolProfileTestsSaltP: TStringField;
    qryPoolProfileTestsTurbidityP: TStringField;
    qryPoolProfileTestsPhosphatesP: TStringField;
    qryPoolProfileTestsPhP: TStringField;
    qryPoolProfileTestsMSAP: TStringField;
    qryPoolProfileTestsMetals1P: TStringField;
    qryPoolProfileTestsMetals2P: TStringField;
    qryPoolProfileTestsAlgae1Q: TFloatField;
    qryPoolProfileTestsAlgae2Q: TFloatField;
    qryPoolProfileTestsPoolVol: TFloatField;
    qryPoolProfileTestsCalciumQ: TFloatField;
    qryPoolProfileTestsTotalAlkQ: TFloatField;
    qryPoolProfileTestsStabilizerQ: TFloatField;
    qryPoolProfileTestsSaltQ: TFloatField;
    qryPoolProfileTestsTurbidityQ: TFloatField;
    qryPoolProfileTestsPhosphatesQ: TFloatField;
    qryPoolProfileTestsPhQ: TFloatField;
    qryPoolProfileTestsMSAQ: TFloatField;
    qryPoolProfileTestsMetals1Q: TFloatField;
    qryPoolProfileTestsMetals2Q: TFloatField;
    qryPoolProfileTestsTurbidity: TStringField;
    qryPoolProfileTestsTemperature: TFloatField;
    qryPoolProfileTestsTDS: TIntegerField;
    qryPoolProfileTestsStabilizerLevel: TFloatField;
    qryPoolProfileTestsTotalSanitizer: TFloatField;
    qryPoolProfileTestsFreeSanitizer: TFloatField;
    qryPoolProfileTestspH: TFloatField;
    qryPoolProfileTestsAlkalineDemand: TFloatField;
    qryPoolProfileTestsTotalAlkalinity: TFloatField;
    qryPoolProfileTestsCalciumHardness: TFloatField;
    qryPoolProfileTestsMetals: TFloatField;
    qryPoolProfileTestsPhosphate: TFloatField;
    qryPoolProfileTestsSalt: TFloatField;
    qryPoolProfileTestsPoolTestsID: TIntegerField;
    qryPoolProfileTestsSanitizerP: TStringField;
    qryPoolProfileTestsSanitizerQ: TFloatField;
    dlgPrint: TPdtPrintDAT;
    qryParts: TMyQuery;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    edtCompany: TEdit;
    edtAddress: TMemo;
    edtPhone: TEdit;
    edtFax: TEdit;
    Label1: TLabel;
    Bevel2: TBevel;
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    BitBtn1: TDNMSpeedButton;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    edtSanitizer: TEdit;
    edtConstruction: TEdit;
    edtConstructName: TEdit;
    edtSanitName: TEdit;
    edtLocation: TEdit;
    edtVolume: TEdit;
    edtSanitizerLvl: TEdit;
    Label10: TLabel;
    Bevel1: TBevel;
    pgMain: TPageControl;
    tabPoolReading: TTabSheet;
    tabTestResults: TTabSheet;
    DNMPanel6: TDNMPanel;
    Memo1: TMemo;
    tabTestResultFields: TTabSheet;
    lblTemperature: TLabel;
    lblTDS: TLabel;
    lblStabilizerLevel: TLabel;
    lblTotalSanitizer: TLabel;
    lblFreeSanitizer: TLabel;
    lblMetals: TLabel;
    lblCalciumHardness: TLabel;
    lblTotalAlkalinity: TLabel;
    lblAlkalineDemand: TLabel;
    lblpH: TLabel;
    Label5: TLabel;
    lblAlgaeType: TLabel;
    lblPhosphate: TLabel;
    lblSalt: TLabel;
    edtTemperatute: TwwDBEdit;
    edtTDS: TwwDBEdit;
    edtStabilizerLevel: TwwDBEdit;
    edtFreeSanitizer: TwwDBEdit;
    edtTotalSanitizer: TwwDBEdit;
    edtMetals: TwwDBEdit;
    edtCalciumHArdness: TwwDBEdit;
    edtTotalAlkalinity: TwwDBEdit;
    edtAlkalineDemand: TwwDBEdit;
    edtPH: TwwDBEdit;
    chkTurbidity: TwwCheckBox;
    cboAlgaeType: TwwDBLookupCombo;
    edtPhosphate: TwwDBEdit;
    edtSalt: TwwDBEdit;
    Bevel3: TBevel;
    edtNotes: TDBMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label33: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label30: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    Label35: TLabel;
    edtAlgae1P: TwwDBEdit;
    edtAlgae1: TEdit;
    edtAlgae2: TEdit;
    edtAlgae2P: TwwDBEdit;
    edtCalciumP: TwwDBEdit;
    edtCalcium: TEdit;
    edtTotAlkP: TwwDBEdit;
    edtTotAlk: TEdit;
    edtStabilizerP: TwwDBEdit;
    edtsaltrequiredP: TwwDBEdit;
    edtStabilizer: TEdit;
    edtSaltpname: TEdit;
    edtAlgae1Q: TwwDBEdit;
    edtAlgae2Q: TwwDBEdit;
    edtCalciumQ: TwwDBEdit;
    edtTotAlkQ: TwwDBEdit;
    edtStabilizerQ: TwwDBEdit;
    edtsaltrequiredQ: TwwDBEdit;
    edtTurbP: TwwDBEdit;
    edtSanitP: TwwDBEdit;
    edtPhospP: TwwDBEdit;
    edtPhRequiredP: TwwDBEdit;
    edtMsaP: TwwDBEdit;
    edtMetal1P: TwwDBEdit;
    edtMetal2P: TwwDBEdit;
    edtTurb: TEdit;
    edtSanit: TEdit;
    edtPhos: TEdit;
    edtPhPname: TEdit;
    edtMsa: TEdit;
    edtMetals1: TEdit;
    edtMetals2: TEdit;
    edtTurbQ: TwwDBEdit;
    edtSanitQ: TwwDBEdit;
    edtPhospQ: TwwDBEdit;
    edtPhRequiredQ: TwwDBEdit;
    edtMsaQ: TwwDBEdit;
    edtMetal1Q: TwwDBEdit;
    edtMetal2Q: TwwDBEdit;
    Bevel4: TBevel;
    Label11: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    edtPoolVol: TwwDBEdit;
    edtNewSI: TwwDBEdit;
    Label4: TLabel;
    edtSI: TwwDBEdit;
    cbxSpa: TCheckBox;
    cbxMSA: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure actMainCancelExecute(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure pgMainChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    StrData: string;
    StrFields: string;
    fiPoolProfileId: integer;
    PoolReadings: TPoolData;
    Algae: TBaseAlgae;
    DissolvedSolids: TBaseDefault;
    pHLevel: TBaseDefault;
    Turbidity: TBaseDefault;
    Salt: TBaseDefault;
    Phosphates: TBaseDefault;
    TotalAlkaline: TBaseDefault;
    CalciumHardness: TBaseDefault;
    Sanitizer: TBaseDefault;
    Stabilizer: TBaseDefault;
    Metals: TBaseMetalMSA;
    MSA: TBaseMetalMSA;
    OtherDefaults: TOtherDefaults;
    TestResults: TResults;

    function SaveData: boolean;
    function ValidateFormData: boolean;
    procedure CreateTestData;
    procedure LoadInputData;
    procedure DisplayResults(PoolTestResults: TResults);
    function getPartName(const PartId: string): string;
  public
    { Public declarations }
    property PoolProfileId: integer read fiPoolProfileId write fiPoolProfileId;
  end;


implementation

uses FastFuncs,WaterTest, BaseCalcResult, PrintTemplateObj, CommonLib;

{$R *.dfm}


function TfmPoolProfileTest.getPartName(Const PartId: string): string;
var
  intPartNo: integer;
begin
  Result := '';
  if FastFuncs.Trim(PartId) = '' then Exit;
  intPartNo := FastFuncs.StrToInt(PartID);
  with qryParts do begin
    if Active = false then Open;
    if Locate('PartsID', intPartNo, [loCaseInsensitive]) then Result := FieldByName('PartName').AsString;
  end;
end;

procedure TfmPoolProfileTest.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;
  Algae := TBaseAlgae.Create;  
end;

function TfmPoolProfileTest.ValidateFormData: boolean;
begin
  Result := false;
  if cboAlgaeType.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Algae Type cannot be blank.', mtError, [mbOK], 0);
    pgMain.ActivePage := tabPoolReading;
    SetControlFocus(cboAlgaeType);
    Exit;
  end;
  Result := true;
end;

function TfmPoolProfileTest.SaveData: boolean;
begin
  Result := true;
  if not (qryPoolProfileTests.State in [dsinsert, dsEdit]) then Exit;

  Result := false;
  if qryPoolProfileTests.State in [dsinsert, dsEdit] then if ValidateFormData then begin
      with qryPoolProfileTests do begin
        if State = dsInsert then FieldByName('DateOfTest').AsDateTime := Date;
        Post;
        KeyId := qryPoolProfileTests.FieldByName('PoolTestsID').AsInteger;
      end;
    end else Exit;
  Result := true;
end;

procedure TfmPoolProfileTest.FormDestroy(Sender: TObject);
begin
  If Assigned(Algae) then FreeAndNil(Algae);
  inherited;
end;

procedure TfmPoolProfileTest.FormShow(Sender: TObject);
begin
  inherited;
  if qryAlgaetype.Active = false then qryAlgaetype.Open;
  with qryPoolProfileTests do begin
    if Active then Close;
    Parambyname('PoolTestsID').AsInteger := KeyId;
    Active := true;
    if RecordCount = 0 then begin
      Insert;
      qryPoolProfileTests.FieldByName('PoolProfileID').AsInteger := fiPoolProfileId;
    end;                    
  end;

  {edtStabilizerLevel.Enabled :=  not ((edtLocation.Text = 'Indoor') or (edtLocation.Text = 'Spa') or
    (edtSanitizer.Text = 'Bromine') or (edtSanitizer.Text = 'Ozone'));}

  DataState.Activate;
  pgMain.ActivePageIndex := 0;
  pgMain.Pages[1].Visible := false;
end;

procedure TfmPoolProfileTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
  CloseQueries;
end;

procedure TfmPoolProfileTest.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if (DataState.Dirty) then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveData then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
  CanClose := true;
end;

procedure TfmPoolProfileTest.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPoolProfileTest.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if qryPoolProfileTests.State in [dsEdit, dsInsert] then begin
    if not SaveData then Exit;
    CommitTransaction;
    Notify;
    DataState.Dirty := false;
    KeyId           := qryPoolProfileTests.FieldByName('PoolTestsId').AsInteger;
  end;
  Self.Close;
end;

procedure TfmPoolProfileTest.actMainNewExecute(Sender: TObject);
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;
  KeyID := 0;
  qryPoolProfileTests.Insert;
  qryPoolProfileTests.FieldByName('PoolProfileID').AsInteger := PoolProfileId;
  DataState.Dirty := false;
  SetControlFocus(edtTemperatute);
end;

procedure TfmPoolProfileTest.actProcessExecute(Sender: TObject);
var
  PoolTest: TWaterTest;
begin
  //  actMainSaveExecute(sender);
  {
  do each step in the sequence of testing process
  1. Algae test
  2. Total Disolved Solids
  3. Saturation Index
  4. Calcium Hardness
  5. Total Alkalinity
  6. Stabilizer
  7. Metal/MSA
  8. Salt
  9. Turbulence
  10. Sanitizer
  11. pH
  12. Phosphate
  13. Check low pH
  14. Check new SI
  }
  PoolReadings := TPoolData.Create;
  TestResults := TResults.Create;

  LoadInputData;
  CreateTestData;


  if FastFuncs.UpperCase(PoolReadings.Sanitizer) = 'SALT' then begin
    Salt.TargetValue := PoolReadings.SanitizerLvl;
    Salt.Minimum     := Salt.TargetValue;
  end;

  PoolTest := TWaterTest.Create;
  try
    if FastFuncs.UpperCase(PoolReadings.Algae) <> 'NONE' then begin
      TestResults.TestResults[TR_ALGAESTEP1] := PoolTest.AlgaeStep1(PoolReadings.Volume, Algae);
      TestResults.TestResults[TR_ALGAESTEP2] := PoolTest.AlgaeStep2(PoolReadings.Volume, Algae);
    end;

    if PoolReadings.TDS > DissolvedSolids.Maximum then begin
      TestResults.VolumeReductionPerc := PoolTest.TotalDissolvedSolids(PoolReadings, DissolvedSolids);
      TestResults.TDSReduction := true;
    end;

    // calculate Saturation Index
    TestResults.SaturationIndex := PoolTest.CalculateSaturationIndex(PoolReadings);

    // calcium hardness test
    if PoolReadings.CalciumHardness > CalciumHardness.Maximum then begin
      // drop the volume
      TestResults.VolumeReductionPerc := Max(TestResults.VolumeReductionPerc,
        PoolTest.CalciumHardnessReduction(PoolReadings, CalciumHardness));
      TestResults.CalciumHardnessReduction := true;
    end else TestResults.TestResults[TR_CALCIUMHARDNESS] :=
        PoolTest.CalciumHardness(PoolReadings, CalciumHardness, OtherDefaults);

    // total alkalinity test
    TestResults.TestResults[TR_TOTALALKALINITY] := PoolTest.TotalAlkalinity(PoolReadings, TotalAlkaline, OtherDefaults);

    // stabilizer test
    if PoolTest.DoStabilizerTest(PoolReadings) then begin
      if PoolReadings.StabilizerLvl > Stabilizer.Maximum then begin
        // drop the volume
        TestResults.VolumeReductionPerc := Max(TestResults.VolumeReductionPerc,
          PoolTest.StabilizerReduction(PoolReadings, Stabilizer));
        TestResults.StabilizerReduction := true;
      end else TestResults.TestResults[TR_STABILIZER] :=
          PoolTest.Stabilizer(PoolReadings, Stabilizer);
    end;


    // metal / MSA test(s)
    if PoolReadings.MSAUsed then begin
      //
      if (PoolReadings.Metals >= 1.0) then begin
        TestResults.VolumeReductionPerc := Max(TestResults.VolumeReductionPerc, PoolTest.MSAReduction(PoolReadings, MSA));
        TestResults.CopperReduction := true;
      end else TestResults.TestResults[TR_MSA] := PoolTest.MSA(PoolReadings, MSA);
    end else begin
      if PoolReadings.Metals > 0 then begin
        // remove the metals from the water
        TestResults.TestResults[TR_METALSTEP1] := PoolTest.MetalStep1(PoolReadings, Metals);
        TestResults.TestResults[TR_METALSTEP2] := PoolTest.MetalStep2(PoolReadings, Metals);
      end;
    end;

    // salt level test for salt pools only
    if FastFuncs.UpperCase(PoolReadings.Sanitizer) = 'SALT' then begin
      TestResults.TestResults[TR_SALT] := PoolTest.SaltWater(PoolReadings, Salt);
    end;

    // turbulance test
    if PoolReadings.Turbidity then begin
      TestResults.TestResults[TR_TURBIDITY] := PoolTest.Turbidity(PoolReadings, Turbidity);
    end;

    // sanitizer test
    if PoolTest.DoSanitizerTest(PoolReadings, Sanitizer) then TestResults.TestResults[TR_SANITIZER] :=
        PoolTest.Sanitizer(PoolReadings, Sanitizer);

    // pH test
    if not PoolTest.AcidUsed then begin
      if PoolTest.DopHLevelTest(PoolReadings) then TestResults.TestResults[TR_PH] :=
          PoolTest.pHLevel(PoolReadings, pHLevel);
    end;

    // phosphate test
    if (PoolReadings.Phosphate > 0) then TestResults.TestResults[TR_PHOSPHATES] :=
        PoolTest.Phosphate(PoolReadings, Phosphates);

    // check pH test
    if PoolTest.DoLowpHLevelTest(PoolReadings) then begin
      if TestResults.HasTestResult(TR_PH) then TestResults.DeleteTestResult(TR_PH);
    end;

    // check new SI

    TestResults.NewSaturationIndex :=
      PoolTest.CalculateNewSaturationIndex(PoolReadings, TestResults);


    // show what's happened
    TestResults.ClearNullResults;
    DisplayResults(TestResults);

  finally
    FreeAndNil(PoolTest);
  end;
end;

procedure TfmPoolProfileTest.CreateTestData;
begin
  DissolvedSolids := TBaseDefault.Create;
  DissolvedSolids.LoadFromDatabase('Common', 'Diss. Solid');

  pHLevel := TBaseDefault.Create;
  pHLevel.LoadFromDatabase('Common', 'pH Level');

  Turbidity := TBaseDefault.Create;
  Turbidity.LoadFromDatabase('Common', 'Turbidity');

  Salt := TBaseDefault.Create;
  Salt.LoadFromDatabase('Common', 'Salt');
  Salt.Maximum := MaxSingle;

  Phosphates := TBaseDefault.Create;
  Phosphates.LoadFromDatabase('Common', 'Phosphate');

  TotalAlkaline := TBaseDefault.Create;
  TotalAlkaline.LoadFromDatabase(PoolReadings.ConstructionType, 'Total Alk.');

  CalciumHardness := TBaseDefault.Create;
  CalciumHardness.LoadFromDatabase(PoolReadings.ConstructionType, 'Cal Hardness');

  // for salt
  Sanitizer := TBaseDefault.Create;
  Sanitizer.LoadFromDatabase(PoolReadings.Sanitizer, 'Sanitizer');

  Stabilizer := TBaseDefault.Create;
  Stabilizer.LoadFromDatabase(PoolReadings.Sanitizer, 'Stabilizer');

  Metals := TBaseMetalMSA.Create;
  Metals.LoadFromDatabase(PoolReadings.Sanitizer, 'Metal');

  MSA := TBaseMetalMSA.Create;
  MSA.LoadFromDatabase(PoolReadings.Sanitizer, 'MSA');

  OtherDefaults := TOtherDefaults.Create;
  OtherDefaults.LoadFromDatabase;
end;

procedure TfmPoolProfileTest.LoadInputData;
begin
  if FastFuncs.Trim(edtVolume.Text) = '' then edtVolume.Text := '0';
  if FastFuncs.Trim(edtSanitizerLvl.Text) = '' then edtSanitizerLvl.Text := '0';
  if FastFuncs.Trim(edtTemperatute.Text) = '' then edtTemperatute.Text := '0';
  if FastFuncs.Trim(edtTDS.Text) = '' then edtTDS.Text := '0';
  if FastFuncs.Trim(edtStabilizerLevel.Text) = '' then edtStabilizerLevel.Text := '0';
  if FastFuncs.Trim(edtTotalSanitizer.Text) = '' then edtTotalSanitizer.Text := '0';
  if FastFuncs.Trim(edtFreeSanitizer.Text) = '' then edtFreeSanitizer.Text := '0';
  if FastFuncs.Trim(edtPH.Text) = '' then edtPH.Text := '0';
  if FastFuncs.Trim(edtAlkalineDemand.Text) = '' then edtAlkalineDemand.Text := '0';
  if FastFuncs.Trim(edtTotalAlkalinity.Text) = '' then edtTotalAlkalinity.Text := '0';
  if FastFuncs.Trim(edtCalciumHArdness.Text) = '' then edtCalciumHArdness.Text := '0';
  if FastFuncs.Trim(edtMetals.Text) = '' then edtMetals.Text := '0';
  if FastFuncs.Trim(edtPhosphate.Text) = '' then edtPhosphate.Text := '0';
  if FastFuncs.Trim(edtSalt.Text) = '' then edtSalt.Text := '0';

  PoolReadings.Volume := FastFuncs.StrToInt(edtVolume.Text);
  PoolReadings.Location := FastFuncs.Trim(edtLocation.Text);
  PoolReadings.ConstructionType := FastFuncs.Trim(edtConstruction.Text);
  PoolReadings.Sanitizer := FastFuncs.Trim(edtSanitizer.Text);
  PoolReadings.SanitizerLvl := FastFuncs.StrToInt(edtSanitizerLvl.Text);
  PoolReadings.MSAUsed := cbxMSA.Checked;
  PoolReadings.IsSpa := cbxSpa.Checked;

  PoolReadings.Temperature := StrToFloat(edtTemperatute.Text);
  PoolReadings.TDS := FastFuncs.StrToInt(edtTDS.Text);
  PoolReadings.StabilizerLvl := StrToFloat(edtStabilizerLevel.Text);
  PoolReadings.TotalSanitizer := StrToFloat(edtTotalSanitizer.Text);
  PoolReadings.FreeSanitizer := StrToFloat(edtFreeSanitizer.Text);
  PoolReadings.pH := StrToFloat(edtPH.Text);
  PoolReadings.AlkalineDemand := StrToFloat(edtAlkalineDemand.Text);
  PoolReadings.TotalAlkaline := StrToFloat(edtTotalAlkalinity.Text);
  PoolReadings.CalciumHardness := StrToFloat(edtCalciumHArdness.Text);
  PoolReadings.Metals := StrToFloat(edtMetals.Text);
  PoolReadings.Turbidity := true;//cbxTurbidity.Checked;
  PoolReadings.Algae := FastFuncs.Trim(cboAlgaeType.Text);
  PoolReadings.Phosphate := StrToFloat(edtPhosphate.Text);
  PoolReadings.Salt := FastFuncs.StrToInt(edtSalt.Text);
  if FastFuncs.Trim(edtVolume.Text) = '0' then edtVolume.Text := ' ';
  if FastFuncs.Trim(edtSanitizerLvl.Text) = '0' then edtSanitizerLvl.Text := ' ';
  if FastFuncs.Trim(edtTemperatute.Text) = '0' then edtTemperatute.Text := ' ';
  if FastFuncs.Trim(edtTDS.Text) = '0' then edtTDS.Text := ' ';
  if FastFuncs.Trim(edtStabilizerLevel.Text) = '0' then edtStabilizerLevel.Text := ' ';
  if FastFuncs.Trim(edtTotalSanitizer.Text) = '0' then edtTotalSanitizer.Text := ' ';
  if FastFuncs.Trim(edtFreeSanitizer.Text) = '0' then edtFreeSanitizer.Text := ' ';
  if FastFuncs.Trim(edtPH.Text) = '0' then edtPH.Text := ' ';
  if FastFuncs.Trim(edtAlkalineDemand.Text) = '0' then edtAlkalineDemand.Text := ' ';
  if FastFuncs.Trim(edtTotalAlkalinity.Text) = '0' then edtTotalAlkalinity.Text := ' ';
  if FastFuncs.Trim(edtCalciumHArdness.Text) = '0' then edtCalciumHArdness.Text := ' ';
  if FastFuncs.Trim(edtMetals.Text) = '0' then edtMetals.Text := ' ';
  if FastFuncs.Trim(edtPhosphate.Text) = '0' then edtPhosphate.Text := ' ';
  if FastFuncs.Trim(edtSalt.Text) = '0' then edtSalt.Text := ' ';
end;

procedure TfmPoolProfileTest.DisplayResults(PoolTestResults: TResults);
var
  TestResult: TCalculationResult;
begin
  Memo1.Clear;
  strData := '';
  StrFields := '';

  if not (qryPoolProfileTests.State in [dsInsert, dsEdit]) then qryPoolProfileTests.Edit;
  TestResult := PoolTestResults.TestResults[TR_ALGAESTEP1];
  with qryPoolProfileTests do begin
    edtAlgae1.Text     := '';
    edtAlgae2.Text     := '';
    edtCalcium.Text    := '';
    edtTotAlk.Text     := '';
    edtStabilizer.Text := '';
    edtSaltpname.Text  := '';
    edtTurb.Text       := '';
    edtSanit.Text      := '';
    edtPhos.Text       := '';
    edtPhPname.Text    := '';
    edtMsa.Text        := '';
    edtMetals1.Text    := '';
    edtMetals2.Text    := '';
    if Assigned(TestResult) then begin
      FieldByName('Algae1P').AsString := TestResult.PartNo;
      FieldByName('Algae1Q').AsFloat := Roundto(TestResult.ActualQty, - 2);
      edtAlgae1.Text := getPartName(TestResult.PartNo);
      Memo1.Lines.Add('Algae, Step1: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStr(TestResult.ActualQty));
    end;

    TestResult := PoolTestResults.TestResults[TR_ALGAESTEP2];
    if Assigned(TestResult) then begin
      FieldByName('Algae2P').AsString := TestResult.PartNo;
      edtAlgae2.Text := getPartName(TestResult.PartNo);
      FieldByName('Algae2Q').AsFloat := RoundTo(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Algae, Step2: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStr(TestResult.ActualQty));
    end;

    if PoolTestResults.VolumeReductionPerc > 0 then begin
      FieldByName('PoolVol').AsFloat := RoundTo(PoolTestResults.VolumeReductionPerc, - 2);
      Memo1.Lines.Add('Reduce pool volume by ' + FloatToStr(PoolTestResults.VolumeReductionPerc) + '% and refill');
    end;

    FieldByName('SI').AsFloat := RoundTo(PoolTestResults.SaturationIndex, - 2);
    Memo1.Lines.Add('Langelier Saturation Index = ' + FloatToStrF(PoolTestResults.SaturationIndex, ffFixed, 4, 2));

    TestResult := PoolTestResults.TestResults[TR_CALCIUMHARDNESS];
    if Assigned(TestResult) then begin
      FieldByName('CalciumP').AsString := TestResult.PartNo;
      edtCalcium.Text := getPartName(TestResult.PartNo);
      FieldByName('CalciumQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Calcium Hardness: Use Part No:' + TestResult.PartNo + ', Qty = ' +
        FloatToStrF(TestResult.ActualQty, ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_TOTALALKALINITY];
    if Assigned(TestResult) then begin
      FieldByName('TotalAlkP').AsString := TestResult.PartNo;
      edtTotAlk.Text := getPartName(TestResult.PartNo);
      FieldByName('TotalAlkQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Total Alkalinity: Use Part No:' + TestResult.PartNo + ', Qty = ' +
        FloatToStrF(TestResult.ActualQty, ffFixed, 4, 2));
    end;
    TestResult := PoolTestResults.TestResults[TR_STABILIZER];
    if Assigned(TestResult) then begin
      FieldByName('StabilizerP').AsString := TestResult.PartNo;
      edtStabilizer.Text := getPartName(TestResult.PartNo);
      FieldByName('StabilizerQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Stabilizer: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty,
        ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_SALT];
    if Assigned(TestResult) then begin
      FieldByName('SaltP').AsString := TestResult.PartNo;
      edtSaltpname.Text := getPartName(TestResult.PartNo);
      FieldByName('SaltQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Salt: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty, ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_TURBIDITY];
    if Assigned(TestResult) then begin
      FieldByName('TurbidityP').AsString := TestResult.PartNo;
      edtTurb.Text := getPartName(TestResult.PartNo);
      FieldByName('TurbidityQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Turbidity: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty,
        ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_SANITIZER];
    if Assigned(TestResult) then begin
      FieldByName('SanitizerP').AsString := TestResult.PartNo;
      edtSanit.Text := getPartName(TestResult.PartNo);
      FieldByName('SanitizerQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Sanitizer: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty,
        ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_PHOSPHATES];
    if Assigned(TestResult) then begin
      FieldByName('PhosphatesP').AsString := TestResult.PartNo;
      edtPhos.Text := getPartName(TestResult.PartNo);
      FieldByName('PhosphatesQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Phosphates: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty,
        ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_PH];
    if Assigned(TestResult) then begin
      FieldByName('PhP').AsString := TestResult.PartNo;
      edtPhPname.Text := getPartName(TestResult.PartNo);
      FieldByName('PhQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('pH: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty, ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_MSA];
    if Assigned(TestResult) then begin
      FieldByName('MSAP').AsString := TestResult.PartNo;
      edtMsa.Text := getPartName(TestResult.PartNo);
      FieldByName('MSAQ').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('MSA: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStrF(TestResult.ActualQty, ffFixed, 4, 2));
    end;

    TestResult := PoolTestResults.TestResults[TR_METALSTEP1];
    if Assigned(TestResult) then begin
      FieldByName('Metals1P').AsString := TestResult.PartNo;
      edtMetals1.Text := getPartName(TestResult.PartNo);
      FieldByName('Metals1Q').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Metals, Step1: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStr(TestResult.ActualQty));
    end;
    TestResult := PoolTestResults.TestResults[TR_METALSTEP2];
    if Assigned(TestResult) then begin
      FieldByName('Metals2P').AsString := TestResult.PartNo;
      edtMetals2.Text := getPartName(TestResult.PartNo);
      FieldByName('Metals2Q').AsFloat := Roundto(TestResult.ActualQty, - 2);
      Memo1.Lines.Add('Metals, Step2: Use Part No:' + TestResult.PartNo + ', Qty = ' + FloatToStr(TestResult.ActualQty));
    end;
    FieldByName('NewSI').AsFloat := Roundto(PoolTestResults.NewSaturationIndex, - 2);
    Memo1.Lines.Add('New Langelier Saturation Index = ' + FloatToStrF(PoolTestResults.NewSaturationIndex, ffFixed, 4, 2));
    DataState.Dirty := true;
  end;
end;

procedure TfmPoolProfileTest.pgMainChange(Sender: TObject);
begin
  inherited;
  if (TPageControl(Sender).ActivePage = tabTestResults) or (TPageControl(Sender).ActivePage = tabTestResultFields) then
    actProcessExecute(Sender);
end;

procedure TfmPoolProfileTest.BitBtn1Click(Sender: TObject);
var
  SQLSelect: string;
begin
  inherited;
  SQLSelect := '~|||~WHERE tblpooltests.PoolTestsID = ' + FastFuncs.IntToStr(KeyID);
  PrintTemplate.PrintTemplateReport('Pool Test Results', SQLSelect, false, 1);
end;

initialization
  RegisterClassOnce(TfmPoolProfileTest);

end.
