unit frmEmployeeTerminate;

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
  BusObjPayUtils,MemDS,
  wwdbdatetimepicker, DBCtrls, AdvPicture,BusObjBase, wwdblook,BusObjTermination,
  ImgList, ProgressDialog;



type
  TfrmEmployeeTerminateGUI = class(TBaseInputGUI)
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
    qryPays: TERPQuery;
    DSPays: TDataSource;
    AdvPicture1: TAdvPicture;
    qryPaysPayID: TIntegerField;
    qryPaysEmployeeID: TIntegerField;
    qryPaysPayDate: TDateField;
    qryPaysDatePaid: TDateTimeField;
    qryPaysPayPeriods: TWordField;
    qryPaysWages: TFloatField;
    qryPaysCommission: TFloatField;
    qryPaysDeductions: TFloatField;
    qryPaysAllowances: TFloatField;
    qryPaysAllowancesBeforeTax: TFloatField;
    qryPaysSundries: TFloatField;
    qryPaysSuperannuation: TFloatField;
    qryPaysGross: TFloatField;
    qryPaysGrossTaxable: TFloatField;
    qryPaysTax: TFloatField;
    qryPaysNet: TFloatField;
    qryPaysPay: TWideStringField;
    qryPaysPaid: TWideStringField;
    qryPaysEditedFlag: TWideStringField;
    qryPaysPrinted: TWideStringField;
    qryPaysEmpName: TWideStringField;
    qryPaysLeaveLoading: TFloatField;
    qryPaysClassID: TIntegerField;
    qryPaysClass: TWideStringField;
    qryPaysIsTimesheet: TWideStringField;
    qryPaysPayPeriod: TWideStringField;
    qryPaysAnnualLeaveRate: TFloatField;
    qryPaysCDEPGross: TFloatField;
    qryPaysLumpA: TFloatField;
    qryPaysLumpB: TFloatField;
    qryPaysLumpD: TFloatField;
    qryPaysLumpE: TFloatField;
    qryPaysETP: TFloatField;
    qryPaysManualTax: TWideStringField;
    qryPaysDeleted: TWideStringField;
    qryPaysIsNewTypePay: TWideStringField;
    qryPaysmsTimeStamp: TDateTimeField;
    qryPaysPaySuperOnLeaveLoading: TWideStringField;
    qryPaysPayVersion: TIntegerField;
    qryPaysPayNotes: TWideMemoField;
    qryPaysUKTaxCodeUsed: TWideStringField;
    qryPaysPrepared: TWideStringField;
    qryPaysUKNICsClass1: TFloatField;
    qryPaysIsContractedOut: TWideStringField;
    qryPaysUKNICsOther: TFloatField;
    qryPaysUKEmployerNICsClass1: TFloatField;
    qryPaysUKEmployerNICsOther: TFloatField;
    qryPaysRegion: TWideStringField;
    qryPaysIsContractedOut2: TWideStringField;
    qryEmpTerminate: TERPQuery;
    qryEmpTerminateTerminationID: TIntegerField;
    qryEmpTerminateEmployeeID: TIntegerField;
    qryEmpTerminateGlobalRef: TWideStringField;
    qryEmpTerminateEmployeeName: TWideStringField;
    qryEmpTerminateETPpre071983: TFloatField;
    qryEmpTerminateETPpost061983Untaxed: TFloatField;
    qryEmpTerminateETPpost061994Component: TFloatField;
    qryEmpTerminateETPEarlyRetirement: TFloatField;
    qryEmpTerminateETPInvalidity: TFloatField;
    qryEmpTerminateETPRedundancy: TFloatField;
    qryEmpTerminateETPUnusedRDOs: TFloatField;
    qryEmpTerminateETPDeath: TFloatField;
    qryEmpTerminateETPPayInLieu: TFloatField;
    qryEmpTerminateETPGoldenHandshake: TFloatField;
    qryEmpTerminateETPJobLossComp: TFloatField;
    qryEmpTerminateETPUnusedSick: TFloatField;
    qryEmpTerminateETPOther: TFloatField;
    qryEmpTerminateETPTotal: TFloatField;
    qryEmpTerminateETPRollover: TFloatField;
    qryEmpTerminateStartDate: TDateTimeField;
    qryEmpTerminateEndDate: TDateTimeField;
    qryEmpTerminateDaysServicePre01071983: TIntegerField;
    qryEmpTerminateDaysServicePost30061983: TIntegerField;
    qryEmpTerminateGrossTermination: TFloatField;
    qryEmpTerminateTaxWithheld: TFloatField;
    qryEmpTerminateETPAssessable: TFloatField;
    qryEmpTerminateDeathBenefit: TWideStringField;
    qryEmpTerminateTypeOfDeathBenefit: TWideStringField;
    qryEmpTerminateLumpSumA: TFloatField;
    qryEmpTerminateLumpSumB: TFloatField;
    qryEmpTerminateLumpSumD: TFloatField;
    qryEmpTerminateLumpSumE: TFloatField;
    qryEmpTerminateReasonLeft: TWideStringField;
    qryEmpTerminateGrossETP: TFloatField;
    qryEmpTerminateCDEP: TFloatField;
    qryEmpTerminateReportableFB: TFloatField;
    qryEmpTerminateTotalAllowances: TFloatField;
    qryEmpTerminatemsTimeStamp: TDateTimeField;
    qryEmpTerminateDeathBeneficiaryHasTFN: TWideStringField;
    qryEmpTerminateIsPayEntitled: TWideStringField;
    qryEmpTerminateIsETPEntitled: TWideStringField;
    qryEmpTerminateIsManualLongService: TWideStringField;
    qryEmpTerminateIsManualAnnualLeave: TWideStringField;
    qryEmpTerminateOtherPaymentType: TWideStringField;
    qryEmpTerminateLongServicePre16081978: TFloatField;
    qryEmpTerminateLongServicePost16081978: TFloatField;
    qryEmpTerminateLongServicePost17081993: TFloatField;
    qryEmpTerminateAnnualLeavePre18081993: TFloatField;
    qryEmpTerminateAnnualLeavePost17081993: TFloatField;
    qryEmpTerminateAnnLeaveLoadingPre18081993: TFloatField;
    qryEmpTerminateAnnLeaveLoadingPost17081993: TFloatField;
    qryEmpTerminateOtherPaymentAmount: TFloatField;
    qryEmpTerminateGross: TFloatField;
    qryEmpTerminateTax: TFloatField;
    qryEmpTerminateNet: TFloatField;
    qryEmpTerminateTotalLumpSums: TFloatField;
    qryEmpTerminatePayID: TIntegerField;
    qryEmpTerminateLumpSumC: TFloatField;
    DNMPanel2: TDNMPanel;
    chkPrint: TCheckBox;
    Label51: TLabel;
    chkDeleted: TwwCheckBox;
    Label19: TLabel;
    qryEmpTerminateETPtaxfree: TFloatField;
    qryEmpTerminateDeleted: TWideStringField;
    DSTerminations: TDataSource;
    qryEmpTerminatePayGross: TFloatField;
    qryEmpTerminateComplete: TWideStringField;
    qryEmpTerminateData: TWideMemoField;
    btnHold: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnPrior: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure chkDeletedClick(Sender: TObject);
    procedure btnHoldClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
  private
//    fEmployeeID :Integer;
    fLoadingBusObj: Boolean;
    fWasDeleted:Boolean;
    fDisableControls:Boolean;
    fEmployeeName: String;
    ms:TMemoryStream;
    fSingleButtonCaption: string;
    fTextSearch: string;
    fFocusControlName: string;
    fSourceForm: TForm;
    fPreventFinish: Boolean;
    fPanelColor: TColor;

    fbPayChangeOccured:boolean;
    PayUtils:Tpayutils;
    LastStepButton: TDNMSpeedButton;
    ButtonCtr:Integer;
    Selectedbutton:TObject;
    procedure GoToNextStep;
    procedure GoToPriorStep;

    function OfferToModifyPay:Boolean;
    function ValidatePay:Boolean;
    procedure SetupActiveFrmBusObjs;
    procedure PostIfDirty;
    procedure PopulateETPTable;
    procedure PopulatePreETPTable;
    procedure PopulateETPRolloverTable;
    function PopulatePAYGSummaryTable: string;
    function GetUserETPTempName: string;
    function GetUserPreETPTempName: string;
    function GetUserETPRolloverTempName: string;
    procedure CreateETPTable;
    procedure CreatePreETPTable;
    procedure CreateETPRolloverTable;
    procedure DeleteETPTable;
    procedure DeletePreETPTable;
    procedure DeleteETPRolloverTable;

//    procedure ShowSubForm(const ButtonName:String;const FormIndex:integer);

    procedure HandleActiveFormChange(Sender: TObject);
    procedure AddButton(const ButtonCaption: string; const ButtonTop: Integer);
    procedure AddMainButtons;
    procedure DestroyMainButtons;
    procedure LoadPanels;
    procedure MainButtonClick(Sender: TObject);
    function GetFormClassName(const ButtonCaption: string): string;
    procedure ClearScrollBox;
    procedure SetScrollBarIncrement;
    procedure HandleCriticalMissingDataErrors;
    procedure SetupConnections;
    procedure DisablefrmSourceControls;
    procedure BuildSearchList;

    function FindMainButton(const Caption: string): TDNMSpeedButton;
    procedure CancelFinish(var Msg: TMessage); message TX_CancelFinish;
    procedure PerformTextSearch(var Msg: TMessage); message TX_PerformTextSearch;
    function IsButtonShown(const ButtonIndex: Integer): Boolean;
    function ValidateCriticalTerminationDetails:Boolean;
    function ValidateCurrentSubForm:Boolean;
    Procedure CallbackSetAccuralsToZero(const Sender: TBusObj; var Abort: Boolean);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;

  public

    Terminate: Temployeeterminations;
    Procedure AfterTranslate; Override;
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = '');
    property SingleButtonCaption: string read fSingleButtonCaption write fSingleButtonCaption;
    property TextSearch: string read fTextSearch write fTextSearch;
    property FocusControlName: string read fFocusControlName write fFocusControlName;
    procedure PrintETPPrePaymentStatement(Preview: boolean = true);
    procedure PrintETPPaymentSummary(Preview: boolean = true);
    procedure PrintETPRoloverStatement(Preview: boolean = true);
  end;

implementation

uses
  CommonLib, DNMLib, StrUtils,FormFactory,tcTypes,BusObjConst,
  CommonDBLib, AppEnvironment,TerminateDetailsFrm,TerminatePayFrm,TerminateLongServiceFrm,
  TerminateAnnualLeaveFrm,TerminateOtherFrm,TerminateETPFrm,TerminateSummaryFrm,
  TerminateETPDetailsFrm,BusObjTerminationAUS,BusObjEmployeeLeave,frmEmployeefrm,
  BusObjEmployeeDetails, BusObjPayBase,DateUtils,FastFuncs,PayCommon, MySQLConst,
  ImagesLib;

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cMainButtonTopStart = 5;
  cFormCount = 8;
  cMaxRange = 6000;

  cFormClassNames: array[1..cFormCount] of string = ('TfrmTerminateDetails',
                                                     'TfrmTerminatePay',
                                                     'TfrmTerminateLongService',
                                                     'TfrmTerminateAnnualLeave',
                                                     'TfrmTerminateOther',
                                                     'TfrmTerminateETP',
                                                     'TfrmTerminateETPDetails',
                                                     'TfrmTerminateSummary'
                                                     );

var
  cButtonCaptions: array[1..cFormCount] of string;
{$R *.dfm}


procedure TfrmEmployeeTerminateGUI.DoBusinessObjectEvent(  const Sender: TDatasetBusObj; const EventType, Value: string);
var
  frm:TComponent;
  begin
  inherited DoBusinessObjectEvent(Sender, eventtype , Value);
  if Eventtype = BusobjEventVal_TerminateETPFldchanged then begin
    DestroyMainButtons;
    AddMainButtons;
  end;

  if Eventtype = BusobjEventVal_TerminateEmpNamechanged then begin
    fEmployeeName := Terminate.Employeename;
    pnlActiveForm.Caption :=  Terminate.EmployeeName;
  end;
  if Eventtype = BusobjEventVal_HandleDeleteDialog then begin
    case CommonLib.MessageDlgXP_Vista('This will delete the termination and the associated pay. It will not do a reversal in the EFT screen. Go ahead?',mtConfirmation,[mbYes,mbNo],0)of
      mrYes: begin
               Terminate.DoDelete := True;
            end;
      mrNo: begin
              Terminate.DoDelete := False;
              btnOK.Enabled := False;
           //   Terminate.Deleted  := False;
            end;
    end;
  end;

  if Eventtype = BusobjEventVal_HandleDeletedTermination then begin
    CommonLib.MessageDlgXP_Vista('Termination Deleted.', mtInformation , [mbOK], 0);
    Self.MyConnection.Commit;
    Close;
  end;

  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_NoUnprocessedPay) then begin
    if CommonLib.MessageDlgXP_Vista('This employee does not have a pay set up. Do you wish to do this now? ', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
      frm:= TfrmEmployee(GetComponentByClassName('TfrmEmployee',true));
      if not assigned(frm) then exit;

      TfrmEmployee(frm).KeyID := Terminate.EmployeeID;
      TfrmEmployee(frm).FormStyle := fsmdiChild;   
      TfrmEmployee(frm).BringToFront;;
      Self.Close;
    end else begin
      Terminate.IsPayEntitled := False;
      if fSourceform.ClassName = 'TfrmTerminatePay' then begin
        with TfrmTerminatePay(fSourceForm) do begin
          ResettingForm := True;
          rgPayStatus.Itemindex := 1;
          btnPrepare.Enabled := False;
          ResettingForm := False;
        end;
      end;
    end;
  end;
end;


procedure TfrmEmployeeTerminateGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedbutton:=nil;
  ButtonCtr:= 0;
  LastStepButton:= nil;
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
  Shader1.ToColorMirror := Shader1.FromColor;
  Self.Color := fPanelColor;*)

  PayUtils := TPayUtils.Create(Self,Self.MyConnection);
  CreateETPTable;
  CreatePreETPTable;
  CreateETPRolloverTable;
end;


procedure TfrmEmployeeTerminateGUI.SetupActiveFrmBusObjs;
begin
  if fSourceform.ClassName = 'TfrmTerminateETP' then begin
    with TfrmTerminateETP(fSourceForm) do begin
      SubTerminate := Temployeeterminations.Create(nil,Self.MyConnection) ;
      SubTerminate.BusObjEvent := DoBusinessObjectEvent;
      SubTerminate.Dataset := qryEmpTerminate;   
      SubTerminate.Load(Self.KeyID);
      Initialise;
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateLongService' then begin
    with TfrmTerminateLongService(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate; 
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateAnnualLeave' then begin
    with TfrmTerminateAnnualLeave(fSourceForm) do begin 
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateOther' then begin
    with TfrmTerminateOther(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateETPDetails' then begin
    with TfrmTerminateETPDetails(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;


      if Terminate.Reasonleft = 'Early Retirement' then begin
        edtEarlyRetire.Enabled := True;
        edtRedundancy.Enabled := False;
        edtInvalidity.Enabled := False;
      end;
      if Terminate.Reasonleft = 'Redundancy' then begin
        edtRedundancy.Enabled := True;
        edtEarlyRetire.Enabled := False;
        edtInvalidity.Enabled := False;
      end;
      if Terminate.Reasonleft = 'Invalidity' then begin
        edtInvalidity.Enabled := True;
        edtRedundancy.Enabled := False;
        edtEarlyRetire.Enabled := False;
      end;  
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateSummary' then begin
    with TfrmTerminateSummary(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;
      if not Terminate.Complete then begin
        SubTerminate.Pay.RecalcAll;  // just in case the pay was edited calc again
        SubTerminate.LoadTerminationToPay; { calls DoFinalCalcs }
      end;
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminatePay' then begin
    with TfrmTerminatePay(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;
      Connection := Self.MyConnection;
    end;
  end;

  if fSourceform.ClassName = 'TfrmTerminateDetails' then begin
    with TfrmTerminateDetails(fSourceForm) do begin
      DSEmpTerminate.DataSet := qryEmpTerminate;
      SubTerminate := Terminate;

      qryEmp.Open;
      fEmployeeName := SubTerminate.EmployeeName;

      if (SubTerminate.Reasonleft = 'Death')
      then begin
        lblDeath.Visible            := True;
        cboDeathPaidTo.Visible      := True;
        chkTFN.Visible              := True;
      end;
      if Terminate.Employeename <> '' then begin
        cboName.ReadOnly := True;
      end;
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    inherited;
    Setlength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0] := 'qryPays';
    QueryNamesNotToOpen[1] := 'qryEmpTerminate';
    OpenQueries(QueryNamesNotToOpen);

    ms := TMemoryStream.Create;

    cButtonCaptions[1] :=  'Step 1: Details';
    cButtonCaptions[2] :=  'Step 2: Pay';

    Self.MyConnection.StartTransaction;

     Terminate := TTerminationAUS.Create(nil,Self.MyConnection) ;

     cButtonCaptions[3] :=  'Step 3: Long Service';
     cButtonCaptions[4] :=  'Step 4: Annual Leave';
     cButtonCaptions[5] :=  'Step 5: Other';
     cButtonCaptions[6] :=  'Step 6: ETP';
     cButtonCaptions[7] :=  'Step 6: ETP Details';
     cButtonCaptions[8] :=  'Step 7: Summary';

    //cFormClassNames[8] := 'TfrmTerminateSummary';
    AppEnv.RegionalOptions.LoadFlagPicture(AdvPicture1.Picture);

    Terminate.Dataset := qryEmpTerminate;
    Terminate.BusObjEvent := DoBusinessObjectEvent;
    Terminate.IgnoreAccesslevel := True;
    BeginTransaction;
    fLoadingBusObj := True;
    Terminate.Load(Self.KeyID);
    fLoadingBusObj := False;
    if Self.KeyID = 0 then begin
      Terminate.New;
      Terminate.PostDb;
      Self.KeyID := Terminate.Id;
    end else begin
      {if looking at a completed termination disable controls }
      if Terminate.Complete then begin
        btnOk.Enabled := False;
        fDisableControls := True;
        DisablefrmSourceControls;
        btnHold.Enabled:= false;
      end;  
    end;
     fLoadingBusObj := True;
     Terminate.Load(Self.KeyID);
     fLoadingBusObj := False;
     fWasDeleted := Terminate.Deleted;
     if Terminate.Deleted then chkDeleted.Enabled := False;

    BuildSearchList;

    if (SingleButtonCaption <> '') and (AccessLevel <> 1) then begin
      AddButton(SingleButtonCaption, cMainButtonTopStart);
      fSourceForm := TForm(GetComponentByClassName(GetFormClassName(SingleButtonCaption)));
   //   pnlActiveForm.Caption := GeneralPay.Empname + ': ' + SingleButtonCaption;
      pnlActiveForm.Caption := Terminate.Employeename + ': ' +  SingleButtonCaption;
    end
    else begin
      AddMainButtons;

  //    if TextSearch = '' then begin
        fSourceForm := TForm(GetComponentByClassName(cFormClassNames[1]));
        pnlActiveForm.Caption := Terminate.Employeename + ': ' + cButtonCaptions[1];
  //    end;
        Terminate.AddDoneStep('Step1')
    end;

    if Assigned(fSourceForm) then begin
      SetClassLabels(fSourceForm);
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;
      SetupActiveFrmBusObjs;
      LoadPanels;

      if fDisableControls then  DisablefrmSourceControls;

      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
    end;

    Screen.OnActiveFormChange := HandleActiveFormChange;
  finally
    EnableForm;
  end;  
end;

procedure TfrmEmployeeTerminateGUI.DisablefrmSourceControls;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TwwDBEdit then begin
        TwwDBEdit(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwDBLookupCombo then begin
        TwwDBLookupCombo(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwDBDateTimePicker then begin
        TwwDBDateTimePicker(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwDBCombobox then begin
        TwwDBCombobox(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwCheckbox then begin
        TwwCheckbox(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TCheckbox then begin
        TCheckbox(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwDBCombobox then begin
        TwwDBCombobox(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TwwRadioGroup then begin
        TwwRadioGroup(fSourceForm.Components[Index]).Enabled := False;
      end;
      if fSourceForm.Components[Index] is TDNMSpeedButton then begin
        TDNMSpeedButton(fSourceForm.Components[Index]).Enabled := False;
      end;
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.HandleActiveFormChange(Sender: TObject);
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

procedure TfrmEmployeeTerminateGUI.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  ClearScrollBox;
  PayUtils.Free;
  Terminate.Free;
  if Assigned(ms) then FreeAndNil(ms);
  DeleteETPTable;
  DeletePreETPTable;
  DeleteETPRolloverTable;
  inherited;  
end;

procedure TfrmEmployeeTerminateGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  if not Terminate.Deleted then  RollbackTransaction;
  Close;
end;

procedure TfrmEmployeeTerminateGUI.FormMouseWheel(Sender: TObject;
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

procedure TfrmEmployeeTerminateGUI.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart;

  for ButtonIndex := 1 to cFormCount do begin
    if IsButtonShown(ButtonIndex) then begin
      AddButton(cButtonCaptions[ButtonIndex], ButtonTop);
      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption;

end;

procedure TfrmEmployeeTerminateGUI.LoadPanels;
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

function TfrmEmployeeTerminateGUI.OfferToModifyPay:Boolean;
begin
  Result := False;
  case CommonLib.MessageDlgXP_Vista('This will modify this employees existing pay. Continue?',mtConfirmation,[mbYes,mbNo],0) of
    mrYes: begin
      if not ValidatePay then exit;
    end;
    mrNo: begin
      exit;
    end;
  end;
  Result := True;
end;

function TfrmEmployeeTerminateGUI.ValidatePay:Boolean;
begin
  try
 //   if GeneralPay.Dataset.RecordCount = 0 then GeneralPay.Load(Self.KeyID);
 //   GeneralPay.RefreshAllDBs;

 //   Result := GeneralPay.ValidateCriticalData;
    Result := True;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.PostIfDirty;
begin
  if Terminate.Dirty then begin
    Terminate.PostDb;
  end;

 // if fSourceform.ClassName = 'TfrmTerminatePay' then begin
//    with TfrmTerminatePay(fSourceForm) do begin
//      if SubTerminate.Dirty then begin
//        SubTerminate.PostDb;
//      end;
//    end;
//  end;

  //if fSourceform.ClassName = 'TfrmTerminateLongService' then begin
//    with TfrmTerminateLongService(fSourceForm) do begin
//      if SubTerminate.Dirty then begin
//        SubTerminate.PostDb;
//        Terminate.RefreshDB;
//    //    SubTerminate.PostDb;
//      end;
//    end;
//  end;


  //if fSourceform.ClassName = 'TfrmTerminateDetails' then begin
//    with TfrmTerminateDetails(fSourceForm) do begin
//      if SubTerminate.Dirty then begin
//        SubTerminate.PostDb;
//        //Terminate.RefreshDB;
//      end;
//    end;
//  end;
  if fSourceform.ClassName = 'TfrmTerminateETP' then begin
    with TfrmTerminateETP(fSourceForm) do begin
      if SubTerminate.Dirty then begin
        SubTerminate.PostDb;
      end;
    end;
  end;

end;

function TfrmEmployeeTerminateGUI.ValidateCurrentSubForm:boolean;
begin
  //VALIDATE FIELDS ON INDIVIDUAL FORMS so can force data entry before form change or Save
  Result := False;

  if fSourceform.ClassName = 'TfrmTerminateDetails' then begin
    with TfrmTerminateDetails(fSourceform) do begin
      if not SubTerminate.ValidateDetails then begin
        TfrmTerminateDetails(fSourceform).HandleTerminateDetailErrors;
        exit;
      end;
    end;
  end;

  Result := True;
end;

procedure TfrmEmployeeTerminateGUI.MainButtonClick(Sender: TObject);
begin
  if Sender is TDNMSpeedButton then begin
    LastStepButton:= TDNMSpeedButton(Sender);
    if GetFormClassName(EnglishCaption(TDNMSpeedButton(Sender))) <> fSourceForm.ClassName then begin
      Selectedbutton:= sender;
      PostIfDirty;
      if not ValidateCurrentSubForm then exit;

      ClearScrollBox;

      if not fPreventFinish then begin
        sbPrefs.VertScrollBar.Visible := True;
        fSourceForm := TForm(GetComponentByClassName(GetFormClassName(EnglishCaption(TDNMSpeedButton(Sender)))));

        AppEnv.RegionalOptions.ChangeForm(fSourceForm);
        SetupConnections;

        SetupActiveFrmBusObjs;

        if Pos('Step 1',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step1')
        else if Pos('Step 2',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step2')
        else if Pos('Step 3',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step3')
        else if Pos('Step 4',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step4')
        else if Pos('Step 5',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step5')
        else if Pos('Step 6',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step6')
        else if Pos('Step 7',EnglishCaption(TDNMSpeedButton(Sender))) > 0 then Terminate.AddDoneStep('Step7');

        pnlActiveForm.Caption :=  Terminate.EmployeeName + ': ' + EnglishCaption(TDNMSpeedButton(Sender));
        LoadPanels;
        if fDisableControls then  DisablefrmSourceControls;
        sbPrefs.Refresh;
        ImageScroll.Enabled := False;
        imgPrefs.Picture.Graphic := nil;
        ImageScroll.Enabled := True;
        SetScrollBarIncrement;
        PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
      end
      else
        fPreventFinish := False;
    end;
  end;
end;

function TfrmEmployeeTerminateGUI.GetFormClassName(const ButtonCaption: string): string;
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

procedure TfrmEmployeeTerminateGUI.ClearScrollBox;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
     if not fPreventFinish then begin
      for Index := sbPrefs.ControlCount - 1 downto 0 do
        sbPrefs.Controls[Index].Parent := fSourceForm;

      if fSourceForm.ClassName = 'TfrmTerminateETP' then begin
        if Assigned(TfrmTerminateETP(fSourceForm).SubTerminate) then TfrmTerminateETP(fSourceForm).SubTerminate.Free;
      end;

      fSourceForm.Release;
      fSourceForm := nil;
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmEmployeeTerminateGUI.PrintETPPaymentSummary(
  Preview: boolean);
begin
  Self.fbReportSQLSupplied := true;
  try
    PopulateETPTable;
    Self.PrintTemplateReport('ETP Payment Summary', 'SELECT * FROM ' + GetUserETPTempName, not Preview, 1);
  finally
    Self.fbReportSQLSupplied := false;
  end;
end;

procedure TfrmEmployeeTerminateGUI.PrintETPPrePaymentStatement(
  Preview: boolean);
begin
  Self.fbReportSQLSupplied := true;
  try
    PopulatePreETPTable;
    Self.PrintTemplateReport('ETP Pre-Payment Statement', 'SELECT * FROM ' + GetUserPreETPTempName,
      not Preview, 1);
  finally
    Self.fbReportSQLSupplied := false;
  end;
end;

procedure TfrmEmployeeTerminateGUI.PrintETPRoloverStatement(
  Preview: boolean);
begin
  Self.fbReportSQLSupplied := true;
  try
    PopulateETPRolloverTable;
    Self.PrintTemplateReport('ETP Rollover Statement', 'SELECT * FROM ' + GetUserETPRolloverTempName,
      not Preview, 1);
  finally
    Self.fbReportSQLSupplied := false;
  end;
end;

procedure TfrmEmployeeTerminateGUI.btnOKClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PostIfDirty;

    if (not Terminate.Complete) and Terminate.Deleted then begin
      Self.MyConnection.Commit;
      Notify;
      if fsModal in FormState then
        ModalResult := mrOK
      else
        Release;
      exit;  
    end;


    if not ValidateCurrentSubForm then exit;

    if not self.Terminate.StepsDone('Step1,Step2,Step3,Step4,Step5,Step6,Step7') then begin
      if CommonLib.MessageDlgXP_Vista('Not all steps have been reviewed, ' +
        'do you wish to continue with termination anyway?',mtInformation,[mbYes,mbNo],0) = mrNo then
        exit;
    end;

    if not ValidateCriticalTerminationDetails then begin
      HandleCriticalMissingDataErrors;
      exit;
    end;

    if fbPayChangeOccured = True then
      if not OfferToModifyPay then begin
        HandleCriticalMissingDataErrors;
        exit;
      end;

    try
      if Terminate.LumpSumC <> 0 then begin
        if chkPrint.Checked then begin
          PrintETPPrePaymentStatement(AppEnv.Employee.ShowPreview);

          PrintETPPaymentSummary(AppEnv.Employee.ShowPreview);

          PrintETPRoloverStatement(AppEnv.Employee.ShowPreview);
        end;
      end;
    finally
    end;
    Terminate.Pay.Paynotes := 'Termination Pay.';
    Terminate.Pay.PostDb;
    Terminate.TerminateEmployee;

    if chkPrint.Checked then begin
      Self.fbReportSQLSupplied := true;

      Self.PrintTemplateReport('PAYG Payment Summary', PopulatePAYGSummaryTable(), not AppEnv.Employee.ShowPreview, 1);
      Self.fbReportSQLSupplied := false;
    end;
    // set all leave accruals for this employee to zero

    Terminate.Pay.EmployeeLeave.IterateRecords(CallbackSetAccuralsToZero);



    ClearScrollBox;

    if not fPreventFinish then begin
      Terminate.Complete:= true;
      Terminate.PostDb;
      Self.MyConnection.Commit;
      Notify;
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

Procedure TfrmEmployeeTerminateGUI.CallbackSetAccuralsToZero(const Sender: TBusObj; var Abort: Boolean);
begin
  Tleave(Sender).Accruedhours := 0;
end;

Function TfrmEmployeeTerminateGUI.ValidateCriticalTerminationDetails:Boolean;
begin
  Result := True;  {stub - maybe use later}

end;

procedure TfrmEmployeeTerminateGUI.HandleCriticalMissingDataErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    FatalStatusItem := Terminate.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
    //  case FatalStatusItem.Code of
        //BOR_PayPayrates_Err_NoDepartment     : begin
//                                                 if not (fSourceForm is TfrmPayHours) then ShowSubForm('Hours',5);
//                                                 TfrmPayHours(fSourceForm).grdHours.SetActiveField('ClassName');
//                                                 SetControlFocus(TfrmPayHours(fSourceForm).PayDepartment);
//                                                 exit;
//                                               end;
//        BOR_PayPayrates_Err_NoQty            : begin
//                                                 if not (fSourceForm is TfrmPayHours) then ShowSubForm('Hours',5);
//                                                 TfrmPayHours(fSourceForm).grdHours.SetActiveField('Qty');
//                                                 SetControlFocus(TfrmPayHours(fSourceForm).edtQty);
//                                                 exit;
//                                               end;
//        BOR_PayPayrates_Err_NoType           : begin
//                                                 if not (fSourceForm is TfrmPayHours) then ShowSubForm('Hours',5);
//                                                 TfrmPayHours(fSourceForm).grdHours.SetActiveField('RateType');
//                                                 SetControlFocus(TfrmPayHours(fSourceForm).PayType);
//                                                 exit;
//                                               end;
//        BOR_PayPayrates_Err_NoRate           : begin
//                                                 if not (fSourceForm is TfrmPayHours) then ShowSubForm('Hours',5);
//                                                 TfrmPayHours(fSourceForm).grdHours.SetActiveField('PayRate');
//                                                 SetControlFocus(TfrmPayHours(fSourceForm).PayRate);
//                                                 exit;
//                                               end;
 //     end;
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

//procedure TfrmEmployeeTerminateGUI.ShowSubForm(const ButtonName:String; const FormIndex:integer);
//begin
//  try
//
//    ClearScrollBox;
//
//    SetControlFocus(FindMainButton(ButtonName));
//
//    if not fPreventFinish then begin
//      sbPrefs.VertScrollBar.Visible := True;
//      fSourceForm := TSourceFormBase(GetComponentByClassName(cFormClassNames[FormIndex]));
//
//      if Assigned(fSourceForm) then begin
//        SetClassLabels(fSourceForm);
//        AppEnv.RegionalOptions.ChangeForm(fSourceForm);
//        SetupConnections;
//        SetupActiveFrmBusObjs;
//
//        pnlActiveForm.Caption := Terminate.EmployeeName + ': ' + ButtonName;
//        LoadPanels;
//        sbPrefs.Refresh;
//        ImageScroll.Enabled := False;
//        imgPrefs.Picture.Graphic := nil;
//        ImageScroll.Enabled := True;
//        SetScrollBarIncrement;
//        PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
//      end;
//    end else  fPreventFinish := False;
//  except
//    on e: Exception do begin
//      raise Exception.Create(e.message);
//    end;
//  end;
//end;

procedure TfrmEmployeeTerminateGUI.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

procedure TfrmEmployeeTerminateGUI.SetupConnections;
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

procedure TfrmEmployeeTerminateGUI.BuildSearchList;
var
  Form: TForm;
  FormIndex: Integer;

  procedure AddCaptionsForForm(const Form: TForm; const FormID: string);
  var
    Index: Integer;
  begin
    for Index := 0 to Form.ComponentCount - 1 do begin
      if (Form.Components[Index] is TLabel) and (TLabel(Form.Components[Index]).Name <> 'lblWidth') and
         (not Sysutils.SameText(Copy(TLabel(Form.Components[Index]).Name, 1, 9), 'lblIgnore')) then
        cboSearch.Items.Add(Trim(TLabel(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TwwRadioGroup) and (Trim(TwwRadioGroup(Form.Components[Index]).Caption) <> '') then
        cboSearch.Items.Add(Trim(TwwRadioGroup(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TDNMSpeedButton) and (Trim(TDNMSpeedButton(Form.Components[Index]).Caption) <> '') then
        cboSearch.Items.Add(Trim(TDNMSpeedButton(Form.Components[Index]).Caption) + ' | ' + FormID);
    end;
  end;
begin
  cboSearch.Clear;

  if (SingleButtonCaption = '') or (AccessLevel = 1) then begin
    for FormIndex := 1 to cFormCount do begin
      if IsButtonShown(FormIndex) then begin
        Form := TForm(GetComponentByClassName(cFormClassNames[FormIndex]));

        try
          if Assigned(Form) then begin
            SetClassLabels(Form);
            AppEnv.RegionalOptions.ChangeForm(Form);
            AddCaptionsForForm(Form, cButtonCaptions[FormIndex]);
          end;
        finally
          FreeAndNil(Form);
        end;
      end;
    end;
  end
  else begin
    Form := TForm(GetComponentByClassName(GetFormClassName(SingleButtonCaption)));

    try
      if Assigned(Form) then begin
        SetClassLabels(Form);
        AppEnv.RegionalOptions.ChangeForm(Form);
        AddCaptionsForForm(Form, SingleButtonCaption);
      end;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

function TfrmEmployeeTerminateGUI.FindMainButton(const Caption: string): TDNMSpeedButton;
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

procedure TfrmEmployeeTerminateGUI.cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  Update;

  if not fPreventFinish then
    SearchForText(cboSearch.Text);
end;

procedure TfrmEmployeeTerminateGUI.DestroyMainButtons;
var
  Index:integer;
begin
  for Index := pnlButtons.ControlCount - 1 downto 0 do
    if pnlButtons.Controls[Index] is  TDNMSpeedButton then begin
      pnlButtons.Controls[Index].Free;
    end;

  //if not fPreventFinish then begin
//      for Index := sbPrefs.ControlCount - 1 downto 0 do
//        sbPrefs.Controls[Index].Parent := fSourceForm;
//
//
//      fSourceForm.Release;
//      fSourceForm := nil;
//    end;
end;

procedure TfrmEmployeeTerminateGUI.AddButton(const ButtonCaption: string; const ButtonTop: Integer);
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

procedure TfrmEmployeeTerminateGUI.SearchForText(const SearchStr: string; const FocusControlName: string = '');
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

procedure TfrmEmployeeTerminateGUI.PerformTextSearch(var Msg: TMessage);
begin
  SearchForText('Default Accounts Receivables Account | Sales', 'cboDefaultSales');
end;

procedure TfrmEmployeeTerminateGUI.CancelFinish(var Msg: TMessage);
begin
  fPreventFinish := True;
end;

function TfrmEmployeeTerminateGUI.IsButtonShown(const ButtonIndex: Integer): Boolean;
begin
  Result := True;

  if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Step 6: ETP Details') then begin
    if Terminate.IsETPEntitled = False then Result := False;

    if Assigned(fSourceform) then begin
      if fSourceform.ClassName = 'TfrmTerminateETP' then begin
        with TfrmTerminateETP(fSourceForm) do begin
          if not SubTerminate.IsETPEntitled then Result := False else Result := True;
        end;
      end;
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.chkDeletedClick(Sender: TObject);
begin
  inherited;
  if fLoadingBusObj then exit;

  Terminate.DoDelete := True;
         //This is a work around to force the check box to behave as it should ///////////////////
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
  chkPrint.Checked := False;

  if not fWasDeleted then btnOK.Enabled := True;

end;


procedure TfrmEmployeeTerminateGUI.PopulateETPTable;
var
  qry: TERPQuery;
  qryInfo: TERPQuery;
  wYear, wMonth, wDay: word;
  //?  dtTestDate, dtEndOfFY: TDateTime;
begin
  qry := nil;
  qryInfo := nil;
  try
    qryInfo := TERPQuery.Create(nil);
    qryInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryInfo.SQL.Clear;
    qryInfo.SQL.Add('SELECT * FROM tblcompanyinformation');
    qryInfo.Open;

    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM ' + GetUserETPTempName);
    qry.Open;

    // Ensure empty.
    while not qry.Eof do begin
      qry.Delete;
    end;


    qry.Insert;
    qry.FieldByName('PayeeFirstname').AsString  := Terminate.Pay.EmployeeDetails.Firstname;
    qry.FieldByName('PayeeSurname').AsString    := Terminate.Pay.EmployeeDetails.Lastname;
    qry.FieldByName('PayeeMiddleName').AsString := Terminate.Pay.EmployeeDetails.Middlename;
    qry.FieldByName('PayeeAddress').AsString    := Terminate.Pay.EmployeeDetails.Street;
    qry.FieldByName('PayeeAddress2').AsString   := Terminate.Pay.EmployeeDetails.Street2;
    qry.FieldByName('TFN').AsString             := Terminate.Pay.EmployeeDetails.Tfn;
    qry.FieldByName('PayeeSuburb').AsString     := Terminate.Pay.EmployeeDetails.Suburb;
    qry.FieldByName('PayeeState').AsString      := Terminate.Pay.EmployeeDetails.State;
    qry.FieldByName('PayeePostcode').AsString   := Terminate.Pay.EmployeeDetails.Postcode;

    DecodeDate(Terminate.Startdate, wYear, wMonth, wDay);
    qry.FieldByName('DateStartedDay').AsInteger   := wDay;
    qry.FieldByName('DateStartedMonth').AsInteger := wMonth;
    qry.FieldByName('DateStartedYear').AsInteger  := wYear;

    DecodeDate(Terminate.Pay.EmployeeDetails.DOB, wYear, wMonth, wDay);
    qry.FieldByName('DOBDay').AsInteger   := wDay;
    qry.FieldByName('DOBMonth').AsInteger := wMonth;
    qry.FieldByName('DOBYear').AsInteger  := wYear;

    DecodeDate(Terminate.Enddate, wYear, wMonth, wDay);     //ET.DatePaid, wYear, wMonth, wDay);
    qry.FieldByName('DateOfPaymentDay').AsInteger   := wDay;
    qry.FieldByName('DateOfPaymentMonth').AsInteger := wMonth;
    qry.FieldByName('DateOfPaymentYear').AsInteger  := wYear;

    qry.FieldByName('NumDaysBefore1July1983').AsInteger := Terminate.Daysservicepre01071983;
    qry.FieldByName('NumDaysAfter30June1983').AsInteger := Terminate.Daysservicepost30061983;
    //DaysBetween(dtTestDate,dtEndOfFY) - 2;

    // Store ETP values.                                 
    qry.FieldByName('PreJuly1983').AsFloat   := Terminate.Etppre071983;
    qry.FieldByName('PostJune1983').AsFloat  := Terminate.Etppost061983untaxed;
    qry.FieldByName('PostJune1994').AsFloat  := Terminate.Etppost061994component;
    qry.FieldByName('GrossETP').AsFloat      := Terminate.Grossetp;
    qry.FieldByName('AssessableAmt').AsFloat := system.Round(Terminate.Etppost061983untaxed + (Terminate.Etppre071983 * 0.05));
    qry.FieldByName('ETPTaxWithheld').AsFloat :=  Terminate.Tax;

    // Did this employee die?
    if Terminate.Reasonleft = 'Death' then begin
      // Yes, then tick appropriate death benefit.
      qry.FieldByName('DeathBenefitYes').AsString := 'X';
      qry.FieldByName('DeathBenefitNo').AsString := ' ';
      if Terminate.Typeofdeathbenefit = 'Trustee' then begin
        qry.FieldByName('DBTrustee').AsString := 'X';
        qry.FieldByName('DBNonDependant').AsString := ' ';
      end else begin
        qry.FieldByName('DBTrustee').AsString := ' ';
        qry.FieldByName('DBNonDependant').AsString := 'X';
      end;
    end else begin
      qry.FieldByName('DeathBenefitYes').AsString := ' ';
      qry.FieldByName('DeathBenefitNo').AsString := 'X';
      qry.FieldByName('DBTrustee').AsString := ' ';
      qry.FieldByName('DBNonDependant').AsString := ' ';
    end;

    qry.FieldByName('CompanyABN').AsString    := qryInfo.FieldByName('ABN').AsString;
    qry.FieldByName('PayerName').AsString     := qryInfo.FieldByName('CompanyName').AsString;
    qry.FieldByName('PayerAddress').AsString  := qryInfo.FieldByName('Address').AsString;
    qry.FieldByName('PayerAddress2').AsString := qryInfo.FieldByName('Address2').AsString;
    qry.FieldByName('PayerSuburb').AsString   := qryInfo.FieldByName('City').AsString;
    qry.FieldByName('PayerState').AsString    := qryInfo.FieldByName('State').AsString;
    qry.FieldByName('PayerPostcode').AsString := qryInfo.FieldByName('Postcode').AsString;
    qry.FieldByName('PayerPhone').AsString    := qryInfo.FieldByName('PhoneNumber').AsString;
    qry.Post;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryInfo) then FreeandNil(qryInfo);
  end;
end;

procedure TfrmEmployeeTerminateGUI.PopulatePreETPTable;
var
  qry: TERPQuery;
  qryInfo: TERPQuery;
  wYear, wMonth, wDay: word;
  //  dtTestDate, dtEndOfFY: TDateTime;
begin
  qry := nil;
  qryInfo := nil;
  try
    qryInfo := TERPQuery.Create(nil);
    qryInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryInfo.SQL.Clear;
    qryInfo.SQL.Add('SELECT * FROM tblcompanyinformation');
    qryInfo.Open;

    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM ' + GetUserPreETPTempName);
    qry.Open;

    // Ensure there is no records here.
    while not qry.Eof do begin
      qry.Delete;
    end;

    qry.Insert;
    qry.FieldByName('EmployeeName').AsString  := Terminate.Pay.EmployeeDetails.Firstname +
      ' ' + Terminate.Pay.EmployeeDetails.Lastname;
    qry.FieldByName('PayeeAddress').AsString  := Terminate.Pay.EmployeeDetails.Street;
    qry.FieldByName('PayeeAddress2').AsString := Terminate.Pay.EmployeeDetails.Street2;
    qry.FieldByName('PayeeSuburb').AsString   := Terminate.Pay.EmployeeDetails.Suburb;
    qry.FieldByName('PayeeState').AsString    := Terminate.Pay.EmployeeDetails.State;
    qry.FieldByName('PayeePostcode').AsString := Terminate.Pay.EmployeeDetails.Postcode;

    DecodeDate(Terminate.Startdate, wYear, wMonth, wDay);
    qry.FieldByName('DateStartedDay').AsInteger   := wDay;
    qry.FieldByName('DateStartedMonth').AsInteger := wMonth;
    qry.FieldByName('DateStartedYear').AsInteger  := wYear;

    DecodeDate(Terminate.Pay.EmployeeDetails.Dob, wYear, wMonth, wDay);
    qry.FieldByName('DOBDay').AsInteger   := wDay;
    qry.FieldByName('DOBMonth').AsInteger := wMonth;
    qry.FieldByName('DOBYear').AsInteger  := wYear;

    DecodeDate(Now, wYear, wMonth, wDay);            //ET.DatePaid, wYear, wMonth, wDay);
    qry.FieldByName('DateOfPaymentDay').AsInteger   := wDay;
    qry.FieldByName('DateOfPaymentMonth').AsInteger := wMonth;
    qry.FieldByName('DateOfPaymentYear').AsInteger  := wYear;

    qry.FieldByName('NumDaysBefore1July1983').AsInteger := Terminate.Daysservicepre01071983;
    qry.FieldByName('NumDaysAfter30June1983').AsInteger := Terminate.Daysservicepost30061983;

    // Store ETP values.
    qry.FieldByName('PreJuly1983').AsFloat  := 0;//empTermination.ETPpreJul1983;//ET.PreJuly1983;
    qry.FieldByName('PostJune1983').AsFloat := 0;//empTermination.ETPpostJun1983;  //ET.PostJune1983;
    qry.FieldByName('PostJune1994').AsFloat := 0;//empTermination.ETPpostJun1994; //ET.PostJune1994;
    qry.FieldByName('GrossETP').AsFloat     := 0;//empTermination.TaxableETPAmt;      //ET.TaxableETPAmt;

    qry.FieldByName('ContactName').AsString   := qryInfo.FieldByName('Contact').AsString;
    qry.FieldByName('CompanyABN').AsString    := qryInfo.FieldByName('ABN').AsString;
    qry.FieldByName('PayerName').AsString     := qryInfo.FieldByName('CompanyName').AsString;
    qry.FieldByName('PayerAddress').AsString  := qryInfo.FieldByName('Address').AsString;
    qry.FieldByName('PayerAddress2').AsString := qryInfo.FieldByName('Address2').AsString;
    qry.FieldByName('PayerSuburb').AsString   := qryInfo.FieldByName('City').AsString;
    qry.FieldByName('PayerState').AsString    := qryInfo.FieldByName('State').AsString;
    qry.FieldByName('PayerPostcode').AsString := qryInfo.FieldByName('Postcode').AsString;
    qry.FieldByName('PayerPhone').AsString    := qryInfo.FieldByName('PhoneNumber').AsString;
    qry.Post;
  finally
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryInfo) then FreeandNil(qryInfo);
    
  end;
end;

procedure TfrmEmployeeTerminateGUI.PopulateETPRolloverTable;
var
  qry: TERPQuery;
  qryInfo: TERPQuery;
  wYear, wMonth, wDay: word;
  dtTestDate, dtEndOfFY: TDateTime;
  dRemainder:double;
  ETPpreJul1983RollOver,ETPpostJun1983RollOver,ETPpostJun1994RollOver:double;
begin
  qry := nil;
  qryInfo := nil;
  try
    qryInfo := TERPQuery.Create(nil);
    qryInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryInfo.SQL.Clear;
    qryInfo.SQL.Add('SELECT * FROM tblcompanyinformation');
    qryInfo.Open;

    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM ' + GetUserETPRolloverTempName);
    qry.Open;

    // Ensure there is no records here.
    while not qry.Eof do begin
      qry.Delete;
    end;
    qry.Insert;
    qry.FieldByName('PayeeFirstname').AsString  := Terminate.Pay.EmployeeDetails.Firstname;
    qry.FieldByName('PayeeSurname').AsString    := Terminate.Pay.EmployeeDetails.Lastname;
    qry.FieldByName('PayeeMiddleName').AsString := Terminate.Pay.EmployeeDetails.Middlename;
    qry.FieldByName('PayeeTitle').AsString      := Terminate.Pay.EmployeeDetails.Title;
    qry.FieldByName('PayeeAddress').AsString    := Terminate.Pay.EmployeeDetails.Street;
    qry.FieldByName('PayeeAddress2').AsString   := Terminate.Pay.EmployeeDetails.Street2;
    qry.FieldByName('PayeeSuburb').AsString     := Terminate.Pay.EmployeeDetails.Suburb;
    qry.FieldByName('PayeeState').AsString      := Terminate.Pay.EmployeeDetails.State;
    qry.FieldByName('PayeePostcode').AsString   := Terminate.Pay.EmployeeDetails.Postcode;

    DecodeDate(Terminate.Startdate, wYear, wMonth, wDay);
    qry.FieldByName('DateStartedDay').AsInteger   := wDay;
    qry.FieldByName('DateStartedMonth').AsInteger := wMonth;
    qry.FieldByName('DateStartedYear').AsInteger  := wYear;

    DecodeDate(Terminate.Pay.EmployeeDetails.Dob, wYear, wMonth, wDay);
    qry.FieldByName('DOBDay').AsInteger   := wDay;
    qry.FieldByName('DOBMonth').AsInteger := wMonth;
    qry.FieldByName('DOBYear').AsInteger  := wYear;

    dtTestDate := EncodeDate(1983, 7, 1);
    if Terminate.Startdate < dtTestDate then begin
      qry.FieldByName('NumDaysBefore1July1983').AsInteger := DaysBetween(dtTestDate,
        Terminate.Startdate) - 1;
    end else begin
      qry.FieldByName('NumDaysBefore1July1983').AsInteger := 0;
    end;

    dtTestDate := EncodeDate(1983, 6, 30);
    dtEndOfFY  := GetCurrentFiscalYearStart(Now);
    DecodeDate(dtEndOfFY, wYear, wMonth, wDay);
    wYear     := wYear + 1;
    wDay      := 1;
    dtEndOfFY := EncodeDate(wYear, wMonth, wDay);
    dtEndOfFY := dtEndOfFY - 1.0;
    if Terminate.Startdate < dtTestDate then begin
      qry.FieldByName('NumDaysAfter30June1983').AsInteger := DaysBetween(dtTestDate, dtEndOfFY) - 2;
    end else begin
      qry.FieldByName('NumDaysAfter30June1983').AsInteger := DaysBetween(Terminate.Startdate,
        dtEndOfFY) - 2;
    end;
    // Store ETP values.

    //apportion the rollover
   ETPpreJul1983RollOver  := 0;
   ETPpostJun1983RollOver := 0;
   ETPpostJun1994RollOver := 0;


   if Terminate.Etppre071983 = 0 then begin
     if Terminate.Etppre071983 = 0 then begin
       ETPpostJun1983RollOver := Terminate.ETPRollover;
     end;
   end;

   if Terminate.Etppre071983 > 0 then begin     {todo rewrite and test this section}
     if Terminate.Etppre071983 < Terminate.ETPRollover then begin
       ETPpreJul1983RollOver  := Terminate.Etppre071983;
       dRemainder := Terminate.ETPRollover - Terminate.Etppre071983;
       if dRemainder < Terminate.Etppost061983untaxed then begin
         ETPpostJun1983RollOver := dRemainder;
       end else
         ETPpostJun1983RollOver := Terminate.ETPRollover - Terminate.Etppre071983 - Terminate.Etppost061983untaxed;
     end else begin


     end;
   end;

    qry.FieldByName('PreJuly1983').AsFloat  := ETPpreJul1983RollOver;//Terminate.ETPpreJul1983RollOver;
    qry.FieldByName('PostJune1983').AsFloat := ETPpostJun1983RollOver; //empTermination.ETPpostJun1983RollOver;
    qry.FieldByName('PostJune1994').AsFloat := ETPpostJun1994RollOver;//empTermination.ETPpostJun1994RollOver;
    qry.FieldByName('GrossETP').AsFloat     := Terminate.ETPRollover;//empTermination.RollOver;

    qry.FieldByName('ContactName').AsString := qryInfo.FieldByName('Contact').AsString;
    qry.FieldByName('CompanyABN').AsString  := qryInfo.FieldByName('ABN').AsString;
    qry.FieldByName('PayerName').AsString   := qryInfo.FieldByName('CompanyName').AsString;
    qry.FieldByName('PayerPhone').AsString  := qryInfo.FieldByName('PhoneNumber').AsString;
    qry.Post;
  finally
    // Free our allocated objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryInfo) then FreeandNil(qryInfo);
  end;
end;

function TfrmEmployeeTerminateGUI.GetUserETPTempName: string;
begin
  Result := 'tmp_payrolletpstatement_' + GetMachineIdentification(true, true, true, true);
end;

function TfrmEmployeeTerminateGUI.GetUserPreETPTempName: string;
begin
  Result := 'tmp_payrollpreetpstatement_' + GetMachineIdentification(true, true, true, true);
end;

function TfrmEmployeeTerminateGUI.GetUserETPRolloverTempName: string;
begin
  Result := 'tmp_payrolletprolloverstatement_' + GetMachineIdentification(true, true, true, true);
end;

procedure TfrmEmployeeTerminateGUI.CreateETPTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserETPTempName + '`');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `' + GetUserETPTempName + '` (');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`PreJuly1983` double default ''0'',');
    qry.SQL.Add('`PostJune1983` double default ''0'',');
    qry.SQL.Add('`PostJune1994` double default ''0'',');
    qry.SQL.Add('`GrossETP` double default ''0'',');
    qry.SQL.Add('`ETPTaxWithheld` double default ''0'',');
    qry.SQL.Add('`AssessableAmt` double default ''0'',');
    qry.SQL.Add('`DeathBenefitNo` char(1) default ''N'',');
    qry.SQL.Add('`DeathBenefitYes` char(1) default ''N'',');
    qry.SQL.Add('`NumDaysBefore1July1983` int(11) default ''0'',');
    qry.SQL.Add('`NumDaysAfter30June1983` int(11) default ''0'',');
    qry.SQL.Add('`DateStartedDay` int(11) default NULL,');
    qry.SQL.Add('`DateStartedMonth` int(11) default NULL,');
    qry.SQL.Add('`DateStartedYear` int(11) default ''0'',');
    qry.SQL.Add('`DateOfPaymentDay` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentMonth` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentYear` int(11) default NULL,');
    qry.SQL.Add('`DOBDay` int(11) default NULL,');
    qry.SQL.Add('`DOBMonth` int(11) default NULL,');
    qry.SQL.Add('`DOBYear` int(11) default NULL,');
    qry.SQL.Add('`TFN` varchar(9) default NULL,');
    qry.SQL.Add('`PayeeSurname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeFirstname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeMiddleName` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeState` varchar(255) default NULL,');
    qry.SQL.Add('`PayeePostcode` varchar(255) default NULL,');
    qry.SQL.Add('`CompanyABN` varchar(15) default NULL,');
    qry.SQL.Add('`PayerName` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayerSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayerState` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPostcode` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPhone` varchar(255) default NULL,');
    qry.SQL.Add('`DBTrustee` char(1) default NULL,');
    qry.SQL.Add('`DBNonDependant` char(1) default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
 //   qry.SQL.Add('UNIQUE KEY `ID` (`ID`),');
    qry.SQL.Add('KEY `ID_2` (`ID`)');
    qry.SQL.Add(') ENGINE=InnoDB COMMENT=''ETP Payment Statement''');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmEmployeeTerminateGUI.CreatePreETPTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserPreETPTempName + '`');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `' + GetUserPreETPTempName + '` (');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`PreJuly1983` double default ''0'',');
    qry.SQL.Add('`PostJune1983` double default ''0'',');
    qry.SQL.Add('`PostJune1994` double default ''0'',');
    qry.SQL.Add('`GrossETP` double default ''0'',');
    qry.SQL.Add('`NumDaysBefore1July1983` int(11) default ''0'',');
    qry.SQL.Add('`NumDaysAfter30June1983` int(11) default ''0'',');
    qry.SQL.Add('`DateStartedDay` int(11) default NULL,');
    qry.SQL.Add('`DateStartedMonth` int(11) default NULL,');
    qry.SQL.Add('`DateStartedYear` int(11) default ''0'',');
    qry.SQL.Add('`DateOfPaymentDay` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentMonth` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentYear` int(11) default NULL,');
    qry.SQL.Add('`DOBDay` int(11) default NULL,');
    qry.SQL.Add('`DOBMonth` int(11) default NULL,');
    qry.SQL.Add('`DOBYear` int(11) default NULL,');
    qry.SQL.Add('`ContactName` varchar(255) default NULL,');
    qry.SQL.Add('`EmployeeName` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeState` varchar(255) default NULL,');
    qry.SQL.Add('`PayeePostcode` varchar(255) default NULL,');
    qry.SQL.Add('`CompanyABN` varchar(15) default NULL,');
    qry.SQL.Add('`PayerName` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayerSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayerState` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPostcode` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPhone` varchar(255) default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
 //   qry.SQL.Add('UNIQUE KEY `ID` (`ID`),');
    qry.SQL.Add('KEY `ID_2` (`ID`)');
    qry.SQL.Add(') ENGINE=InnoDB COMMENT=''ETP Pre-Payment Statement''');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmEmployeeTerminateGUI.CreateETPRolloverTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserETPRolloverTempName + '`');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `' + GetUserETPRolloverTempName + '` (');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`PreJuly1983` double default ''0'',');
    qry.SQL.Add('`PostJune1983` double default ''0'',');
    qry.SQL.Add('`PostJune1994` double default ''0'',');
    qry.SQL.Add('`GrossETP` double default ''0'',');
    qry.SQL.Add('`NumDaysBefore1July1983` int(11) default ''0'',');
    qry.SQL.Add('`NumDaysAfter30June1983` int(11) default ''0'',');
    qry.SQL.Add('`DateStartedDay` int(11) default NULL,');
    qry.SQL.Add('`DateStartedMonth` int(11) default NULL,');
    qry.SQL.Add('`DateStartedYear` int(11) default ''0'',');
    qry.SQL.Add('`DOBDay` int(11) default NULL,');
    qry.SQL.Add('`DOBMonth` int(11) default NULL,');
    qry.SQL.Add('`DOBYear` int(11) default NULL,');
    qry.SQL.Add('`PayeeTitle` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeSurname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeFirstname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeMiddleName` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeState` varchar(255) default NULL,');
    qry.SQL.Add('`PayeePostcode` varchar(255) default NULL,');
    qry.SQL.Add('`CompanyABN` varchar(15) default NULL,');
    qry.SQL.Add('`PayerName` varchar(255) default NULL,');
    qry.SQL.Add('`ContactName` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPhone` varchar(255) default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
 //   qry.SQL.Add('UNIQUE KEY `ID` (`ID`),');
    qry.SQL.Add('KEY `ID_2` (`ID`)');
    qry.SQL.Add(') ENGINE=InnoDB COMMENT=''ETP Rollover Statement''');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TfrmEmployeeTerminateGUI.PopulatePAYGSummaryTable: string;
var
  qryInfo: TERPQuery;
  qryPays: TERPQuery;
  wYear, wMonth, wDay, wYearEnding: word;
  sMoneyWords: string;
  dtStartFringeDate, dtEndFringeDate: TDateTime;
  dtStartFinancial, dtEndFinancial, dtFinished: TDateTime;
  dDeductions, dTotalFringes, dTax, dGross, dCDEP, dAllowances, dOther, dUnionFees: double;

begin
  qryInfo := nil;
  qryPays := nil;
  try
    qryInfo := TERPQuery.Create(nil);
    qryInfo.Connection := TERPConnection(TMyDacDataConnection(Terminate.Connection).MyDacConnection ); //  CommonDbLib.GetSharedMyDacConnection;
    qryInfo.SQL.Clear;
    qryInfo.SQL.Add('SELECT * FROM tblcompanyinformation');
    qryInfo.Open;

    dtFinished := Now;
    DecodeDate(Now(), wYear, wMonth, wDay);

    // Set our ending date of Fringe Benefit Tax Year.
    dtStartFringeDate := EncodeDate(wYear, 3, 31);

    // Start of Fringe Benefits Tax Year is 1 April ????
    dtEndFringeDate := EncodeDate(wYear - 1, 4, 1);

    //   dtEndFinancial := EncodeDate(wYear, 6, 30);
    //    if wMonth > 6 then Inc(wYear);
    //    dtStartFinancial := EncodeDate(wYear-1, 7, 1);
    if wMonth > 6 then begin
      dtStartFinancial := EncodeDate(wYear, 7, 1);
      dtEndFinancial := EncodeDate(wYear + 1, 6, 30);
      wYearEnding := wYear + 1;
    end else begin
      dtStartFinancial := EncodeDate(wYear - 1, 7, 1);
      dtEndFinancial := EncodeDate(wYear , 6, 30);
      wYearEnding := wYear;
    end;

    qryPays := TERPQuery.Create(nil);
    qryPays.Connection := TERPConnection(TMyDacDataConnection(Terminate.Connection).MyDacConnection );// CommonDbLib.GetSharedMyDacConnection;
    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT');
    qryPays.SQL.Add('Sum(P.Tax) AS TotalTaxWithheld, Sum(P.Allowances) AS Allowances, Sum(P.Commission + P.Sundries) AS Other,');
    qryPays.SQL.Add('Sum(P.CDEPGross) AS CDEP, Sum(P.Wages) - Sum(P.CDEPGross) - Sum(P.Deductions) AS GrossPayments, Sum(IF(PD.UnionFees = ''F'', PD.Amount, 0)) AS Deductions,');
    qryPays.SQL.Add('Sum(IF(PD.UnionFees = ''T'', PD.Amount, 0)) AS UnionFees, Max(D.Description) AS UnionDescription,');

    qryPays.SQL.Add('Sum(P.LumpA) As LumpA,Sum(P.LumpB) as LumpB,Sum(P.LumpD) as LumpD,Sum(P.LumpE) as LumpE,Sum(P.ETP) as ETP');

    qryPays.SQL.Add('FROM tblemployees AS E');
    qryPays.SQL.Add('INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID');
    qryPays.SQL.Add('LEFT JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID');
    qryPays.SQL.Add('LEFT JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID');
    qryPays.SQL.Add('WHERE P.Paid = ''T'' AND P.Deleted = ''F'' AND E.EmployeeID = ' + IntToStr(Terminate.Employeeid) +
      ' AND (P.DatePaid BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial)) + ' AND ' +
      QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ')');
    qryPays.SQL.Add('GROUP BY E.EmployeeID');
    qryPays.Open;

    // Get Totals
    dTax        := qryPays.FieldByName('TotalTaxWithheld').AsFloat;
    dCDEP       := qryPays.FieldByName('CDEP').AsFloat;
    dGross      := qryPays.FieldByName('GrossPayments').AsFloat - qryPays.FieldByName('LumpA').AsFloat - qryPays.FieldByName('LumpB').AsFloat - qryPays.FieldByName('LumpD').AsFloat - qryPays.FieldByName('LumpE').AsFloat - qryPays.FieldByName('ETP').AsFloat;
    dAllowances := qryPays.FieldByName('Allowances').AsFloat;
    dOther      := qryPays.FieldByName('Other').AsFloat;
    dDeductions := qryPays.FieldByName('Deductions').AsFloat;
    dUnionFees  := qryPays.FieldByName('UnionFees').AsFloat;

    // Now convert these amounts to whole dollars.
    dTax        := RemoveCents(dTax);
    dCDEP       := RemoveCents(dCDEP);
    dGross      := RemoveCents(dGross);
    dAllowances := RemoveCents(dAllowances);
    dOther      := RemoveCents(dOther);
    dDeductions := RemoveCents(dDeductions);
    dUnionFees  := RemoveCents(dUnionFees);
    sMoneyWords := MoneyWords(dTax);
    if sMoneyWords = '' then begin
      sMoneyWords := 'Zero Dollars';
    end;

    Result := '';
    dTotalFringes := GetTotalOfReportableFringeBenefits(Terminate.Employeeid, dtStartFringeDate, dtEndFringeDate);
    Result := Result + '{Main}SELECT';
    Result := Result + ' '+QuotedStr(sMoneyWords) + ' AS MoneyWords, ';
    Result := Result + ' '+IntToStr(wYearEnding) + ' AS YearEnding, ';
    Result := Result + ' E.EmployeeID, E.FirstName, E.MiddleName, E.LastName, E.TFN, E.Street, E.Street2, ';
    Result := Result + ' E.State, E.Postcode, E.Suburb,E.DateStarted AS DateStarted, ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtFinished)) + ' AS DateFinished, E.DOB, ';
    Result := Result + ' '+QuotedStr(qryInfo.FieldByName('CompanyName').AsString) + ' AS PayersName, ';
    Result := Result + ' '+QuotedStr(qryInfo.FieldByName('ABN').AsString) + ' AS ABN, ';
    Result := Result + ' '+FloatToStr(dTax) + ' AS TotalTaxWithheld, ' + FloatToStr(dAllowances) + ' AS Allowances, ' + FloatToStr(dOther) + ' AS Other,';
    Result := Result + ' '+FloatToStr(dCDEP) + ' AS CDEP, ' + FloatToStr(dGross) + ' AS GrossPayments, ' +      FloatToStr(dDeductions) + ' AS Deductions,';
    Result := Result + ' '+FloatToStr(dUnionFees) + ' AS UnionFees, Max(D.Description) AS UnionDescription,';
    Result := Result + ' '+FloatToStr(dTotalFringes) + ' AS Fringe, ';
    Result := Result + ' '+FloatToStr(RemoveCents(Terminate.LumpSumA)) + ' AS LumpA, ' +      FloatToStr(RemoveCents(Terminate.LumpSumB)) + ' AS LumpB, ' + FloatToStr(RemoveCents(Terminate.LumpSumD)) +      ' AS LumpD, ';
    Result := Result + ' '+FloatToStr(RemoveCents(Terminate.LumpSumE)) + ' AS LumpE, ';
    Result := Result + ' '+QuotedStr(AppEnv.Employee.EmployeeName) + ' AS AuthorisedPerson';
    Result := Result + ' FROM tblemployees AS E';
    Result := Result + ' INNER JOIN tblPays AS P on E.EmployeeID = P.EmployeeID';
    Result := Result + ' LEFT JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID';
    Result := Result + ' LEFT JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID';
    Result := Result + ' WHERE P.Paid = ''T'' AND E.EmployeeID = ' + IntToStr(Terminate.EmployeeID) + ' AND (P.DatePaid BETWEEN ' +
      QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtStartFinancial)) + ' AND ' +
      QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtEndFinancial)) + ')';
    Result := Result + ' GROUP BY E.EmployeeID';
    REsult := REsult + '~|||~{companyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, ';
    Result := Result + ' CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ';
    Result := Result + ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';

  finally
    // Free our allocated objects.
    if Assigned(qryInfo) then FreeandNil(qryInfo);
    if Assigned(qryPays) then FreeandNil(qryPays);
  end;
end;

procedure TfrmEmployeeTerminateGUI.DeleteETPTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserETPTempName + '`');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmEmployeeTerminateGUI.DeleteETPRolloverTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserETPRolloverTempName + '`');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmEmployeeTerminateGUI.DeletePreETPTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetUserPreETPTempName + '`');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;


procedure TfrmEmployeeTerminateGUI.btnHoldClick(Sender: TObject);
begin
  inherited;
  PostIfDirty;
  Self.MyConnection.Commit;
  Notify;
  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TfrmEmployeeTerminateGUI.GoToNextStep;
var
  x, idx: integer;
begin
  if pnlButtons.ControlCount = 0 then exit;
  if Assigned(self.LastStepButton) then begin
    for x:= 0 to pnlButtons.ControlCount -1 do begin
      if pnlButtons.Controls[x] = LastStepButton then begin
        idx:= x;
        if idx < (pnlButtons.ControlCount -1) then Inc(idx);
//        else idx:= 0;
        if pnlButtons.Controls[idx] is TDNMSpeedButton then begin
          MainButtonClick(TDNMSpeedButton(pnlButtons.Controls[idx]));
          SetControlFocus(TDNMSpeedButton(pnlButtons.Controls[idx]));
        end;
        break;
      end;
    end;
  end
  else begin
    if pnlButtons.Controls[0] is TDNMSpeedButton then begin
      MainButtonClick(TDNMSpeedButton(pnlButtons.Controls[0]));
      SetControlFocus(TDNMSpeedButton(pnlButtons.Controls[0]));
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.GoToPriorStep;
var
  x, idx: integer;
begin
  if pnlButtons.ControlCount = 0 then exit;
  if Assigned(self.LastStepButton) then begin
    for x:= 0 to pnlButtons.ControlCount -1 do begin
      if pnlButtons.Controls[x] = LastStepButton then begin
        idx:= x;
        if idx > 0 then Dec(idx);
//        else idx:= pnlButtons.ControlCount -1;
        if pnlButtons.Controls[idx] is TDNMSpeedButton then begin
          MainButtonClick(TDNMSpeedButton(pnlButtons.Controls[idx]));
          SetControlFocus(TDNMSpeedButton(pnlButtons.Controls[idx]));
        end;
        break;
      end;
    end;
  end
  else begin
    if pnlButtons.Controls[0] is TDNMSpeedButton then begin
      MainButtonClick(TDNMSpeedButton(pnlButtons.Controls[0]));
      SetControlFocus(TDNMSpeedButton(pnlButtons.Controls[0]));
    end;
  end;
end;

procedure TfrmEmployeeTerminateGUI.btnNextClick(Sender: TObject);
begin
  inherited;
  GoToNextStep;
end;

procedure TfrmEmployeeTerminateGUI.btnPriorClick(Sender: TObject);
begin
  inherited;
  GoToPriorStep;
end;

initialization
  RegisterClassOnce(TfrmEmployeeTerminateGUI);
  with FormFact do begin
    RegisterMe(TfrmEmployeeTerminateGUI, 'TfrmEmployeeTerminationList_*=TerminationID');
  end;

finalization
  UnregisterClass(TfrmEmployeeTerminateGUI);
end.



