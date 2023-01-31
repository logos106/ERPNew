unit frmAwardsfrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 RM  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImageScroll, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
  DNMSpeedButton, StdCtrls, wwcheckbox, DataSourcePrefs, MessageConst,
  wwradiogroup, Mask, wwdbedit, Wwdotdot, Wwdbcomb, jpeg, GraphUtil, Shader,
  BusObjBase,BusObjAwards, MemDS,
  wwdbdatetimepicker, DBCtrls, AdvPicture, ImgList, ProgressDialog;



type
  TfrmAwards = class(TBaseInputGUI)
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    sbPrefs: TScrollBox;
    ImageScroll: TImageScroll;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    cboSearch: TwwDBComboBox;
    Label2: TLabel;
    imgPrefs: TImage;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    AdvPicture1: TAdvPicture;
    qryawardclassificationdetails: TERPQuery;
    qryawardclassificationdetailsGlobalRef: TWideStringField;
    qryawardclassificationdetailsClassificationID: TAutoIncField;
    qryawardclassificationdetailsAwardID: TIntegerField;
    qryawardclassificationdetailsClassification: TWideStringField;
    qryawardclassificationdetailsType: TWideStringField;
    qryawardclassificationdetailsFullTime: TFloatField;
    qryawardclassificationdetailsPartTime: TFloatField;
    qryawardclassificationdetailsCasual: TFloatField;
    qryawardclassificationdetailsCasualLoading: TFloatField;
    qryawardclassificationdetailsAdvanceIDName: TWideStringField;
    qryawardclassificationdetailsAdvanceID: TIntegerField;
    qryawardclassificationdetailsFTHourlyRate: TFloatField;
    qryawardclassificationdetailsPTHourlyRate: TFloatField;
    qryawardclassificationdetailsCHourlyRate: TFloatField;
    qryawardclassificationdetailsEditedFlag: TWideStringField;
    qryawardclassificationdetailsAdvanceToClassification: TWideStringField;
    qryclassificationallowances: TERPQuery;
    qryclassificationallowancesGlobalRef: TWideStringField;
    qryclassificationallowancesAllowanceID: TAutoIncField;
    qryclassificationallowancesClassificationID: TIntegerField;
    qryclassificationallowancesAllowID: TIntegerField;
    qryclassificationallowancesAmount: TFloatField;
    qryclassificationallowancesCalcBy: TWideStringField;
    qryclassificationallowancesBasedOnID: TIntegerField;
    qryclassificationallowancesEditedFlag: TWideStringField;
    qryclassificationallowancesAwardID: TIntegerField;
    qryclassificationallowanceslookupAllowance: TWideStringField;
    qryclassificationallowanceslookupBasedOn: TWideStringField;
    qryAllowances: TERPQuery;
    qryAllowancesDescription: TWideStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesSuperInc: TWideStringField;
    qryAllowancesTaxExempt: TWideStringField;
    qryAllowancesPayrollTaxExempt: TWideStringField;
    qryAllowancesWorkcoverExempt: TWideStringField;
    qryAllowancesDisplayIn: TWideStringField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesCalcBy: TWideStringField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesActive: TWideStringField;
    qryBasedOn: TERPQuery;
    qryClassificationDeductions: TERPQuery;
    qryClassificationDeductionsAmount: TFloatField;
    qryClassificationDeductionsCalcBy: TWideStringField;
    qryClassificationDeductionsGlobalRef: TWideStringField;
    qryClassificationDeductionsDeductionID: TIntegerField;
    qryClassificationDeductionsClassificationID: TIntegerField;
    qryClassificationDeductionsDeductID: TIntegerField;
    qryClassificationDeductionsBasedOnID: TIntegerField;
    qryClassificationDeductionsEditedFlag: TWideStringField;
    qryClassificationDeductionsAwardID: TIntegerField;
    qryClassificationDeductionsDeductionLookup: TWideStringField;
    qryClassificationDeductionsBasedOnLookup: TWideStringField;
    qryDeductions: TERPQuery;
    qryDeductionsDescription: TWideStringField;
    qryDeductionsGlobalRef: TWideStringField;
    qryDeductionsDeductionID: TAutoIncField;
    qryDeductionsTaxExempt: TWideStringField;
    qryDeductionsUnionFees: TWideStringField;
    qryDeductionsEditedFlag: TWideStringField;
    qryDeductionsActive: TWideStringField;
    qryDeductionsDisplayIn: TWideStringField;
    qryDeductionsAmount: TFloatField;
    qryDeductionsBasedOnID: TIntegerField;
    qryDeductionsCalcBy: TWideStringField;
    qryClassificationExtraPayRates: TERPQuery;
    qryClassificationExtraPayRatesRateID: TAutoIncField;
    qryClassificationExtraPayRatesClassificationID: TIntegerField;
    qryClassificationExtraPayRatesPayRate: TIntegerField;
    qryClassificationExtraPayRatesTypeID: TIntegerField;
    qryClassificationExtraPayRatesPayRateType: TWideStringField;
    qryClassificationExtraPayRatesWorked: TFloatField;
    qryClassificationExtraPayRatesAmount: TFloatField;
    qryClassificationExtraPayRatesSuperInc: TWideStringField;
    qryClassificationExtraPayRatesExtraPayRate: TWideStringField;
    qryClassificationExtraPayRatesAwardID: TIntegerField;
    qryClassificationExtraPayRatesEditedFlag: TWideStringField;
    qryPayRateType: TERPQuery;
    qryExtraPayRates: TERPQuery;
    qryAwardLeave: TERPQuery;
    qryAwardLeaveGlobalRef: TWideStringField;
    qryAwardLeaveLeaveID: TAutoIncField;
    qryAwardLeaveAwardID: TIntegerField;
    qryAwardLeaveType: TWideStringField;
    qryAwardLeaveAccrueAfterNo: TFloatField;
    qryAwardLeaveAccrueAfterPeriod: TWideStringField;
    qryAwardLeaveAccrueNo: TFloatField;
    qryAwardLeaveAccruePeriod: TWideStringField;
    qryAwardLeaveAccrueHours: TFloatField;
    qryAwardLeaveEditedFlag: TWideStringField;
    qryAwardLeaveAwardStartDate: TDateField;
    qryAwardLeaveAwardEndDate: TDateField;
    qryAwardLeaveUseStartEndDates: TWideStringField;
    qryAwardLeaveLeaveLoading: TFloatField;
    qryAwards: TERPQuery;
    qryAwardsAwardID: TAutoIncField;
    qryAwardsAwardName: TWideStringField;
    qryAwardsArea: TWideStringField;
    qryAwardsClassID: TIntegerField;
    qryAwardsPayPeriod: TWideStringField;
    qryAwardsSuperType: TWideStringField;
    qryAwardsAnnualLeaveLoading: TFloatField;
    qryAwardsActive: TWideStringField;
    qryAwardsEditedFlag: TWideStringField;
    qryAwardsSuperValue: TFloatField;
    qryAwardsMealBreakHours: TFloatField;
    qryAwardsMealBreakThreshold: TFloatField;
    qryAwardsPaySuperOnLeaveLoading: TWideStringField;
    qryAwardsUseCompanySuperThreshold: TWideStringField;
    qryAwardsSuperThresholdAmount: TFloatField;
    qryAwardsSickLeaveDaysThreshold: TIntegerField;
    qryAwardShifts: TERPQuery;
    qryAwardShiftsPayRate: TWideStringField;
    qryAwardShiftsStartDay: TWideStringField;
    qryAwardShiftsStartTime: TDateTimeField;
    qryAwardShiftsEndDay: TWideStringField;
    qryAwardShiftsEndTime: TDateTimeField;
    qryAwardShiftsRate1AfterHours: TFloatField;
    qryAwardShiftsRate1PayRate: TIntegerField;
    qryAwardShiftsRate2AfterHours: TFloatField;
    qryAwardShiftsRate2PayRate: TIntegerField;
    qryAwardShiftsSuperInc: TWideStringField;
    qryAwardShiftsShiftID: TIntegerField;
    qryAwardShiftsAwardID: TIntegerField;
    qryAwardShiftsPayRateID: TIntegerField;
    qryAwardShiftsPayRate1: TWideStringField;
    qryPayRates: TERPQuery;
    qryPayRatesDescription: TWideStringField;
    qryPayRatesRateID: TAutoIncField;
    qryPayRatesMultiplier: TFloatField;
    chkActive: TwwCheckBox;
    Label4: TLabel;
    DSAwards: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    SelectedEmployees: TStrings;
    fNewAward:Boolean;
    GeneralAward:TAward;
    fSingleButtonCaption: string;
    fTextSearch: string;
    fFocusControlName: string;
    fSourceForm: TForm;
    fPreventFinish: Boolean;
    fPanelColor: TColor;
    fbAwardChangeOccured :Boolean;
    ButtonCtr :Integer;
    Selectedbutton:TObject;
    procedure SetupActiveFrmBusObjs;
    procedure PostIfDirty;
    procedure UpdateSelectedEmployeesWithAward;
    procedure ShowSubForm(Const ButtonName:String;Const FormIndex:integer);

    procedure HandleActiveFormChange(Sender: TObject);
    procedure AddButton(const ButtonCaption: string; const ButtonTop: Integer);
    procedure AddMainButtons;
    procedure LoadPanels;
    procedure MainButtonClick(Sender: TObject);
    function GetFormClassName(const ButtonCaption: string): string;
    procedure ClearScrollBox;
    procedure SetScrollBarIncrement;
//    procedure HandleCriticalMissingDataErrors;
    procedure SetupConnections;
//    procedure BuildSearchList;
    function FindMainButton(const Caption: string): TDNMSpeedButton;
    procedure CancelFinish(var Msg: TMessage); message TX_CancelFinish;
    procedure PerformTextSearch(var Msg: TMessage); message TX_PerformTextSearch;
    function ValidateCriticalAwardDetails:Boolean;
    function ValidateCurrentSubForm:Boolean;
    procedure OfferToUpdateEmployees;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;

  public
    Procedure AfterTranslate; Override;
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = '');
    property SingleButtonCaption: string read fSingleButtonCaption write fSingleButtonCaption;
    property TextSearch: string read fTextSearch write fTextSearch;
    property FocusControlName: string read fFocusControlName write fFocusControlName;
  end;

implementation

uses
  CommonLib, DNMLib, StrUtils,FormFactory,tcTypes,BusObjEmployeePay,
  CommonDBLib, AppEnvironment,frmEmployeeSelectionFrm,BusObjPayUtils,
  AwardDetailsFrm,AwardClassificationsFrm,AwardLeavesFrm,AwardTimesheetFrm,
  FastFuncs, BusObjConst, BusobjAwardClassificationDetail,
  BusObjClassificationAllowances , BusObjClassificationDeductions, BusObjClassificationExtraPayrates,
  BusObjAwardShifts, BusObjAwardsLeave,PayCommon, tcConst, ImagesLib;

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cMainButtonTopStart = 5;
  cFormCount = 3;
  cMaxRange = 6000;
  cButtonCaptions: array[1..cFormCount] of string = ('Classification',
                                                     'Leaves',
                                                     'Standard Details'
                                                   //  'Timesheet'
                                                     );

  cFormClassNames: array[1..cFormCount] of string = ('TfrmAwardClassifications',
                                                     'TfrmAwardLeaves',
                                                     'TfrmAwardDetails'
                                                   //  'TfrmAwardTimesheet'
                                                     );

{$R *.dfm}

procedure TfrmAwards.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedbutton:=nil;
  ButtonCtr:= 0;
  UserLock.Enabled := True;
  SelectedEmployees := TStringList.Create;
  fbTabSettingEnabled := False;
  fTextSearch := '';
  fFocusControlName := '';
  fSingleButtonCaption := '';
  fSourceForm := nil;
  fPreventFinish := False;
  (*sbPrefs.DoubleBuffered := True;*)
  fPanelColor := Self.color; //ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, False);
  pnlButtons.Color := fPanelColor;
  (*Shader1.FromColor := GetGradientColor(Self.ClassName).Color;
  Shader1.ToColorMirror := Shader1.FromColor;*)
  Self.Color := fPanelColor;
end;


procedure TfrmAwards.SetupActiveFrmBusObjs;
begin
  if fSourceform.ClassName = 'TfrmAwardDetails' then begin
    with TfrmAwardDetails(fSourceForm) do begin
      SubAward := GeneralAward;
      DSAwards.DataSet := SubAward.Dataset;
      qryDepartments.Open;
      QryAreaCodes.Open;
    end;
  end;   

  if fSourceform.ClassName = 'TfrmAwardTimesheet' then begin
    with TfrmAwardTimesheet(fSourceForm) do begin
      SubAward := GeneralAward;
      DSAwardShifts.DataSet := SubAward.AwardShifts.Dataset;
      qryPayratesOnly.Open;
   //   qryLimitedPayRates.Open;
      qryPayRates.Open;   
    end;
  end;

  if fSourceform.ClassName = 'TfrmAwardLeaves' then begin
    with TfrmAwardLeaves(fSourceForm) do begin
      //Award := TAward.Create(nil,Self.MyConnection) ;
//      Award.AwardLeaves.Dataset  := qryAwardLeave;
//      Award.Load(Self.KeyID);
      SubAward := GeneralAward;
      DSLeave.DataSet := SubAward.AwardLeaves.Dataset;
      qryLeaveTypes.Open;
      SubAward.BusObjEvent := DoBusinessObjectEvent;


    end;
  end;

  if fSourceform.ClassName = 'TfrmAwardClassifications' then begin
    with TfrmAwardClassifications(fSourceForm) do begin
      SubAward := GeneralAward;
      DSClassificationDetails.DataSet := SubAward.AwardClassifications.Dataset;
      SubAward.BusObjEvent := DoBusinessObjectEvent;
      TfrmAwardClassifications(fSourceForm).AddMainButtons;
      TfrmAwardClassifications(fSourceForm).KeyID := Self.KeyID;
      TfrmAwardClassifications(fSourceForm).MyConnection1 := Self.MyConnection; //pass connection to 1 sub form

      qryAwardAdvance.Open;
      qryPayRateType.Open;

      qryNextClassifications.params.ParamByName('xAwardID').AsInteger := GeneralAward.Id;
      qryNextClassifications.params.ParamByName('xClassificationID').AsInteger := GeneralAward.AwardClassifications.Id;

      qryNextClassifications.Open;
    end;
  end;
end;
procedure TfrmAwards.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TAward                      then TAward(Sender).DataSet                        := qryAwards
        else if Sender is Tawardclassificationdetails   then Tawardclassificationdetails(Sender).DataSet    := qryAwardClassificationDetails
        else if Sender is Tclassificationallowances     then Tclassificationallowances(Sender).DataSet      := qryClassificationAllowances
        else if Sender is Tclassificationdeductions     then Tclassificationdeductions(Sender).DataSet      := qryClassificationDeductions
        else if Sender is Tclassificationextrapayrates  then Tclassificationextrapayrates(Sender).DataSet   := qryClassificationExtraPayRates
        else if Sender is TAwardLeaves                  then TAwardLeaves(Sender).DataSet                   := qryAwardLeave
        else if Sender is Tawardshifts                  then Tawardshifts(Sender).DataSet                   := qryAwardShifts;
    end;
    if fSourceForm is TfrmAwardClassifications then
      TfrmAwardClassifications(fSourceForm).DoAwardClassificationBusinessObjectEvent(Sender, eventType, Value);
end;
procedure TfrmAwards.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    BeginTransaction;
    qryAllowances.Open;
    qryBasedOn.Open;
    qryDeductions.Open;
    qryPayRateType.Open;
    qryExtraPayRates.Open;
    qryPayRates.Open;
    GeneralAward := TAward.Create(nil,Self.MyConnection) ;
    GeneralAward.BusObjEvent :=DoBusinessObjectEvent;
    (*GeneralAward.AwardClassifications.Dataset := qryAwardClassificationDetails;
    GeneralAward.AwardClassifications.ClassificationAllowances.Dataset := qryClassificationAllowances;
    GeneralAward.AwardClassifications.ClassificationDeductions.Dataset := qryClassificationDeductions;
    GeneralAward.AwardClassifications.ClassificationExtraPayrates.Dataset := qryClassificationExtraPayRates;
    GeneralAward.AwardLeaves.Dataset := qryAwardLeave;
    GeneralAward.Dataset := qryAwards;
    GeneralAward.AwardShifts.Dataset := qryAwardShifts;*)

    if Self.KeyID <> 0 then GeneralAward.Load(Self.KeyID)
    else begin
      fNewAward := True;
      GeneralAward.New;
      GeneralAward.PostDb;
      Self.KeyID := GeneralAward.Id;
      GeneralAward.Load(Self.KeyID);
      GeneralAward.Supervalue := AppEnv.PayPrefs.DefaultSuperRate;
    end;

  //  BuildSearchList;

    if (SingleButtonCaption <> '') and (AccessLevel <> 1) then begin
      AddButton(SingleButtonCaption, cMainButtonTopStart);
      fSourceForm := TForm(Makeform(GetFormClassName(SingleButtonCaption)));
      pnlActiveForm.Caption := GeneralAward.Awardname + ': ' + SingleButtonCaption;
    end
    else begin
      AddMainButtons;

      if TextSearch = '' then begin
        fSourceForm := TForm(Makeform(cFormClassNames[3]));
        pnlActiveForm.Caption := GeneralAward.Awardname + ': ' + cButtonCaptions[3];
      end;
    end;

    if Assigned(fSourceForm) then begin
      SetClassLabels(fSourceForm);
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;

      SetupActiveFrmBusObjs;

      LoadPanels;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
      //if fSourceForm.ClassName = 'TfrmAwardClassifications' then TfrmAwardClassifications(fSourceForm).Initialise;
    end;

    Screen.OnActiveFormChange := HandleActiveFormChange;
    Self.WindowState := wsNormal; //in case the form was previously minimised
    Self.Position := poDefault;
  finally
    EnableForm;
  end;  
end;

procedure TfrmAwards.HandleActiveFormChange(Sender: TObject);
begin
  if (Screen.ActiveForm = Self) and (ImageScroll.Enabled = False) then begin
    Update;
    ImageScroll.Image := imgPrefs;
    ImageScroll.ScrollBox := sbPrefs;
    ImageScroll.Enabled := True;
    SetScrollBarIncrement;

    if TextSearch <> '' then begin
      SearchForText(TextSearch, FocusControlName);
      TextSearch := '';
    end;
  end;
end;

procedure TfrmAwards.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  ClearScrollBox;
  GeneralAward.Free;
  if Assigned(SelectedEmployees) then FreeAndNil(SelectedEmployees);
  inherited;
end;

procedure TfrmAwards.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfrmAwards.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
  Increment: Integer;
begin
  inherited;
  Handled := True;
  Increment := sbPrefs.VertScrollBar.Increment;

  if WheelDelta < 0 then begin
    if (ImageScroll.ImagePosition + Increment) > imgPrefs.ClientHeight then
      ImageScroll.PerformScroll(imgPrefs.ClientHeight)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition + Increment);
  end
  else begin
    if (ImageScroll.ImagePosition - Increment) < 0 then
      ImageScroll.PerformScroll(0)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition - Increment)
  end;
end;

procedure TfrmAwards.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart;

  for ButtonIndex := 1 to cFormCount do begin
    AddButton(cButtonCaptions[ButtonIndex], ButtonTop);
    ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
  end;
end;

procedure TfrmAwards.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption;

end;

procedure TfrmAwards.LoadPanels;
var
  TmpPanel: TDNMPanel;
  CurrentTop: Integer;
  PanelIndex: Integer;
  PanelList: TList;
  Bitmap: TBitmap;
  BitmapName: string;

  function GetPanel(Order: Integer): TDNMPanel;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := 0;

    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is TDNMPanel) and
         (TDNMPanel(fSourceForm.Controls[Index]).TabOrder = Order) then
        Result := TDNMPanel(fSourceForm.Controls[Index])
      else
        Inc(Index);
    end;
  end;

  procedure SetPanelProperties(const Panel: TDNMPanel);
  begin
    Panel.BevelOuter := bvNone;
    Panel.Transparent := False;
    Panel.Color := fPanelColor;
    Panel.Left := 0;
    Panel.Top := CurrentTop;
    (*Panel.DoubleBuffered := True;*)
    Panel.Parent := sbPrefs;
  end;
begin
  PanelList := TList.Create;
  Bitmap := TBitmap.Create;

  try
    if FileExists(BitmapName) then
      Bitmap.LoadFromFile(BitmapName);

    PanelIndex := 0;
    TmpPanel := GetPanel(PanelIndex);

    while Assigned(TmpPanel) do begin
      PanelList.Add(TmpPanel);

      Inc(PanelIndex);
      TmpPanel := GetPanel(PanelIndex);
    end;

    PanelIndex := 0;
    CurrentTop := 0;

    while PanelIndex < PanelList.Count do begin
      TmpPanel := TDNMPanel(PanelList[PanelIndex]);
      SetPanelProperties(TmpPanel);
      CurrentTop := CurrentTop + TmpPanel.Height;
      Inc(PanelIndex);
    end;
  finally
    FreeAndNil(PanelList);
    FreeAndNil(Bitmap);
  end;
end;


//function TfrmAwards.ValidatePay:Boolean;
//begin
//  try
// //   if GeneralPay.Dataset.RecordCount = 0 then GeneralPay.Load(Self.KeyID);
// //   GeneralPay.RefreshAllDBs;
//
////    Result := GeneralPay.ValidateCriticalData;
//    Result := True;
//  except
//    on e: Exception do begin
//      raise Exception.Create(e.message);
//    end;
//  end;
//end;

procedure TfrmAwards.PostIfDirty;
begin

  if fSourceform.ClassName = 'TfrmAwardDetails' then begin
    with TfrmAwardDetails(fSourceForm) do begin
      if SubAward.Dirty then begin
        SubAward.PostDb;
        fbAwardChangeOccured := true;
      end;  
    end;
  end;
  if fSourceform.ClassName = 'TfrmAwardClassifications' then begin
    with TfrmAwardClassifications(fSourceForm) do begin
      if SubAward.AwardClassifications.Dirty then begin
        SubAward.AwardClassifications.PostDb;
        fbAwardChangeOccured := true;
      end;
      TfrmAwardClassifications(fSourceForm).PostIfDirty;
    end;
  end;

  if fSourceform.ClassName = 'TfrmAwardLeaves' then begin
    with TfrmAwardLeaves(fSourceForm) do begin
      if SubAward.AwardLeaves.Dirty then begin
        SubAward.AwardLeaves.PostDb;
        fbAwardChangeOccured := true;
      end;
    end;
  end;

end;

function TfrmAwards.ValidateCurrentSubForm:boolean;
begin
  //VALIDATE FIELDS ON INDIVIDUAL FORMS so can force data entry before form change or Save
  Result := False;

  if fSourceform.ClassName = 'TfrmAwardDetails' then begin
    with TfrmAwardDetails(fSourceform).SubAward do begin
      DataSet.First;
      while not Dataset.Eof do begin
        if not ValidateData then begin
          TfrmAwardDetails(fSourceform).HandleAwardDetailErrors;
          exit;
        end;
        Dataset.Next;
      end;
    end;
  end;
  if fSourceform.ClassName = 'TfrmAwardClassifications' then begin
    with TfrmAwardClassifications(fSourceform).SubAward.AwardClassifications do begin
      RefreshDB;
      Dataset.Last;
      while not Dataset.Bof do begin
        if not ValidateData then begin
          TfrmAwardClassifications(fSourceform).HandleAwardClassificationErrors;
          exit;
        end;
        DataSet.Prior;
      end;
    end;
  end;

  if fSourceform.ClassName = 'TfrmAwardLeaves' then begin
    with TfrmAwardLeaves(fSourceform).SubAward.AwardLeaves do begin
      Dataset.Last;
      while not Dataset.Bof do begin
        if not ValidateData then begin
          TfrmAwardLeaves(fSourceform).HandleAwardLeaveErrors;
          exit;
        end;
        DataSet.Prior;
      end;
    end;
  end;

  Result := True;
end;

procedure TfrmAwards.MainButtonClick(Sender: TObject);
begin
  if Sender is TDNMSpeedButton then begin
    if not Sysutils.SameText( GeneralAward.Awardname + ': ' + EnglishCaption(TDNMSpeedButton(Sender)), pnlActiveForm.Caption) then begin
      Selectedbutton:= sender;
      PostIfDirty;

       //if not AwardClassificationExists then begin
//         grdClassification.SetActiveField('Classification');
//         SetControlFocus(edClassification);
//         exit;
//       end;

      if fSourceform.ClassName = 'TfrmAwardClassifications' then begin
        if GeneralAward.AwardClassifications.dataset.recordcount = 0 then begin
          CommonLib.MessageDlgXP_Vista('Classification must contain at least one record .', mtWarning, [mbOK], 0);
          exit;
        end;
      end; 

      if not ValidateCurrentSubForm then exit;

      ClearScrollBox;

      if not fPreventFinish then begin
        sbPrefs.VertScrollBar.Visible := True;
        fSourceForm := TForm(Makeform(GetFormClassName(EnglishCaption(TDNMSpeedButton(Sender)))));

        AppEnv.RegionalOptions.ChangeForm(fSourceForm);
        SetupConnections;

        SetupActiveFrmBusObjs;

        if fNewAward then GeneralAward.RefreshDB;
        pnlActiveForm.Caption :=  GeneralAward.Awardname + ': ' + EnglishCaption(TDNMSpeedButton(Sender));
        LoadPanels;
        sbPrefs.Refresh;
        ImageScroll.Enabled := False;
        imgPrefs.Picture.Graphic := nil;
        ImageScroll.Enabled := True;
        SetScrollBarIncrement;
        SendMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
        if fSourceForm.ClassName = 'TfrmAwardClassifications' then TfrmAwardClassifications(fSourceForm).Initialise;
        if fSourceForm is TBaseInputGUI then begin
          TBaseInputGUI(fSourceForm).CallHookupComboEvents;
        end;
      end
      else
        fPreventFinish := False;
    end;
  end;
end;
function TfrmAwards.GetFormClassName(const ButtonCaption: string): string;
var
  Index: Integer;
begin
  Index := 1;
  Result := '';

  while (Index <= cFormCount) and (Result = '') do begin
    if cButtonCaptions[Index] = ButtonCaption then
      Result := cFormClassNames[Index]
    else
      Inc(Index);
  end;
end;

procedure TfrmAwards.ClearScrollBox;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    if fSourceform.ClassName = 'TfrmAwardClassifications' then begin
      TfrmAwardClassifications(fSourceForm).ClearScrollBox;
    end;

     if not fPreventFinish then begin
      for Index := sbPrefs.ControlCount - 1 downto 0 do
        sbPrefs.Controls[Index].Parent := fSourceForm;

    //  TsourceFormBase(fSourceForm).DestroyBusObjs;

      fSourceForm.Release;
      fSourceForm := nil;
    end;
  end;
end;

procedure TfrmAwards.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    ClearScrollBox;

    if fPreventFinish then begin
      fPreventFinish := False;
      Action := caNone;
    end
    else begin
      RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
    end;
  end;
end;

//procedure TfrmAwards.PostCurrentSubForm;
//begin
//  if fSourceForm.ClassName = 'TfrmAwardClassifications' then begin
//    TfrmAwardClassifications(fSourceForm).PostIfDirty;
//  end;
//end;

procedure TfrmAwards.OfferToUpdateEmployees;
var
  frm:TComponent;
  i:integer;
begin
  if CommonLib.MessageDlgXP_Vista('Do you want to update employees on this award?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    if FormStillOpen('TfrmEmployeeSelection') then
      TfrmEmployeeSelection(FindExistingComponent('TfrmEmployeeSelection')).Close;

    frm := Makeform('TfrmEmployeeSelection');
    if Assigned(frm) then begin
      with TfrmEmployeeSelection(frm) do begin
        GetEmployees(GeneralAward.Id);
        if chkEmployees.Count = 0 then begin
          CommonLib.MessageDlgXP_Vista('There are no Employees on this award.', mtInformation, [mbOK], 0);
          Exit;
        end;

        if ShowModal = mrOk then begin
          SelectedEmployees.Clear;

        //  get employees from chkList
          for i := 0 to chkEmployees.Count - 1 do begin
            if chkEmployees.Checked[i] then begin
              SelectedEmployees.Add(chkEmployees.Items.Strings[i]);
            end;
          end;
          UpdateSelectedEmployeesWithAward;
          if chkEmployees.SelCount > 0 then CommonLib.MessageDlgXP_Vista('Selected Employees have been updated.', mtInformation, [mbOK], 0);
        end else begin
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmAwards.UpdateSelectedEmployeesWithAward;
var
  EmpPay:TemployeePay;
  i:integer;
  PayUtils :Tpayutils;
  FatalStatusItem: TResultStatusItem;
begin
  EmpPay := TemployeePay.Create(nil,Self.MyConnection);
  PayUtils := Tpayutils.Create(nil,Self.MyConnection);
  try
    doshowProgressbar(SelectedEmployees.Count  , WAITMSG);
    try
      for i := 0 to SelectedEmployees.Count - 1 do begin
        if not UserLock.Lock('tblemployees',GetEmployeeID(SelectedEmployees[i]),'Update Employees Award') then begin
          CommonLib.MessageDlgXP_Vista('Currently the User "' + UserLock.LockInfo.Username + '" is Editing the Employee ['+SelectedEmployees[i]+']. Cannot Update this Employee.', mtWarning, [mbOK], 0);
          Continue;
        end;
        EmpPay.Load(GetEmployeeID(SelectedEmployees[i]));
        EmpPay.UpdateEmployeeWithAward;
        //if employee has an unprocessed pay
        if PayCommon.UnprocessedPayExists(GetEmployeeID(SelectedEmployees[i])) > 0 then
          PayUtils.CreateNewPay(EmpPay.EmployeeDetails.Id,False,True, FatalStatusItem);
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;
  finally
    EmpPay.Free;
    PayUtils.Free;
  end;

end;

procedure TfrmAwards.btnOKClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PostIfDirty;

    if not ValidateCurrentSubForm then exit;

    if not ValidateCriticalAwardDetails then begin
   //   HandleCriticalMissingDataErrors;
      exit;
    end;

    if (fbAwardChangeOccured = True) and (fNewAward = False) then OfferToUpdateEmployees;

    ClearScrollBox;

    if not fPreventFinish then begin
      CommitTransaction;

      if fsModal in FormState then
        ModalResult := mrOK
      else
        Release;
    end
    else
      fPreventFinish := False;
  finally
    EnableForm;
  end;    
end;

Function TfrmAwards.ValidateCriticalAwardDetails:Boolean;
begin
  Result := True;
  if GeneralAward.AwardClassifications.Dataset.RecordCount = 0 then begin
    Result := False;
    CommonLib.MessageDlgXP_Vista('Classification must contain at least one record .', mtWarning, [mbOK], 0);
    if  FastFuncs.PosEx('Classification', pnlActiveForm.Caption) = 0  then
      ShowSubForm('Classification',1);
    exit;
  end;
end;


procedure TfrmAwards.ShowSubForm(Const ButtonName:String;Const FormIndex:integer);
begin
  ClearScrollBox;

  SetControlFocus(FindMainButton(ButtonName));

  if not fPreventFinish then begin
    sbPrefs.VertScrollBar.Visible := True;
    fSourceForm := TForm(Makeform(cFormClassNames[FormIndex]));

    if Assigned(fSourceForm) then begin

      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;
      SetupActiveFrmBusObjs;

      pnlActiveForm.Caption :=  GeneralAward.Awardname + ': ' + ButtonName;
      LoadPanels;
      sbPrefs.Refresh;
      ImageScroll.Enabled := False;
      imgPrefs.Picture.Graphic := nil;
      ImageScroll.Enabled := True;
      SetScrollBarIncrement;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
    end;
  end else  fPreventFinish := False;  
end;

procedure TfrmAwards.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

procedure TfrmAwards.SetupConnections;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TERPQuery then begin
        TERPQuery(fSourceForm.Components[Index]).Connection := Self.MyConnection;
      end;
    end;
  end;
end;

function TfrmAwards.FindMainButton(const Caption: string): TDNMSpeedButton;
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TDNMSpeedButton) and (TDNMSpeedButton(Components[Index]).Caption = Caption) then begin
      Result := TDNMSpeedButton(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TfrmAwards.cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  Update;

  if not fPreventFinish then
    SearchForText(cboSearch.Text);
end;

procedure TfrmAwards.AddButton(const ButtonCaption: string; const ButtonTop: Integer);
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);

  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    OnClick := MainButtonClick;
    inc(ButtonCtr);
    name := 'mainbutton'+inttostr(ButtonCtr);
  end;
end;

procedure TfrmAwards.SearchForText(const SearchStr: string; const FocusControlName: string = '');
var
  ControlIndex: Integer;
  PanelIndex: Integer;
  FoundControl: Boolean;
  Panel: TPanel;
  ControlTop: Integer;
  ControlHeight: Integer;
  MainButton: TDNMSpeedButton;
  NewPosition: Integer;
  IndexOfText: Integer;
  ControlCaption: string;
  SearchText: string;
  DelimiterPos: Integer;
  TmpControl: TWinControl;
begin
  IndexOfText := cboSearch.Items.IndexOf(SearchStr);

  if IndexOfText >= 0 then begin
    DelimiterPos := FastFuncs.PosEx('|', SearchStr);
    SearchText := Copy(SearchStr, 1, DelimiterPos - 2);

    with cboSearch do
      MainButton := FindMainButton(Copy(SearchStr, DelimiterPos + 2, char_length(SearchStr) - DelimiterPos - 1));

    if Assigned(MainButton) then
      MainButton.Click;

    PanelIndex := 0;
    FoundControl := False;
    ImageScroll.PerformScroll(0);

    while (PanelIndex < sbPrefs.ControlCount) and (not FoundControl) do begin
      Panel := TPanel(sbPrefs.Controls[PanelIndex]);
      ControlIndex := 0;

      while (ControlIndex < Panel.ControlCount) and (not FoundControl) do begin
        if Panel.Controls[ControlIndex] is TLabel then
          ControlCaption := Trim(TLabel(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TwwRadioGroup then
          ControlCaption := Trim(TwwRadioGroup(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TDNMSpeedButton then
          ControlCaption := Trim(TDNMSpeedButton(Panel.Controls[ControlIndex]).Caption)
        else
          ControlCaption := '';

        if ControlCaption <> '' then begin
          if Sysutils.SameText(ControlCaption, SearchText) then begin
            ControlTop := Panel.Top + Panel.Controls[ControlIndex].Top;
            ControlHeight := Panel.Controls[ControlIndex].Height;
            NewPosition := System.Round((ControlTop - ((sbPrefs.ClientHeight - ControlHeight) / 2)) / ImageScrollHeightFactor(ImageScroll));

            if NewPosition > imgPrefs.ClientHeight then
              ImageScroll.PerformScroll(imgPrefs.ClientHeight)
            else if NewPosition > 0 then
              ImageScroll.PerformScroll(NewPosition);

            FoundControl := True;
          end
          else
            Inc(ControlIndex);
        end
        else
          Inc(ControlIndex);
      end;

      Inc(PanelIndex);
    end;

    if FoundControl and (FocusControlName <> '') then begin
      TmpControl := TWinControl(fSourceForm.FindComponent(FocusControlName));

      if Assigned(TmpControl) then
        SetControlFocus(TmpControl);
    end;
  end;
end;

procedure TfrmAwards.PerformTextSearch(var Msg: TMessage);
begin
  SearchForText('Default Accounts Receivables Account | Sales', 'cboDefaultSales');
end;

procedure TfrmAwards.CancelFinish(var Msg: TMessage);
begin
  fPreventFinish := True;
end;

initialization
  RegisterClassOnce(TfrmAwards);
  FormFact.RegisterMe(TfrmAwards, 'TfrmAwardsList_*=AwardID');
  FormFact.RegisterControl(TfrmAwards, 'TfrmEmployee_cboAward=AwardID');
end.




