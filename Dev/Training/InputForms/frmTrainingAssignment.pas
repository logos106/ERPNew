unit frmTrainingAssignment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseTraining, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel , BusObjBase, Grids, Wwdbigrd,
  Wwdbgrid, wwdblook, DNMSpeedButton, BaseInputForm, ComCtrls, BusobjTraining,
  frmshape, hintlist, DBCtrls, wwdbdatetimepicker, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, GradientLabel, Buttons, ProgressDialog, wwcheckbox;

type
  TfmTrainingAssignment = class(TfmBaseTraining)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnStatus: TDNMSpeedButton;
    btnEmployees: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    pgmain: TPageControl;
    tabEmployees: TTabSheet;
    DNMPanel1: TDNMPanel;
    grdTrainingEmployeeModules: TwwDBGrid;
    tabSchedule: TTabSheet;
    TrainingCalender: TMonthCalendar;
    grdTrainingSchedule: TwwDBGrid;
    Label1: TLabel;
    QryTrainingDays: TERPQuery;
    QryTrainingDaysTrainingDate: TDateField;
    QryTrainingDaysStartTime: TDateTimeField;
    QryTrainingDaysEndTime: TDateTimeField;
    QryTrainingDaysTrainingID: TLargeintField;
    QryTrainingDaysActive: TWideStringField;
    QryTrainingDaysGlobalref: TWideStringField;
    QryTrainingDaysTrainingdayID: TLargeintField;
    QryTrainingDaysmsTimeStamp: TDateTimeField;
    QryTrainingEmployeeModules: TERPQuery;
    QryTrainingEmployeeModulesEmployeeName: TWideStringField;
    QryTrainingEmployeeModulesBasicFeatures: TWideStringField;
    QryTrainingEmployeeModulesEmployee: TWideStringField;
    QryTrainingEmployeeModulesAccounts: TWideStringField;
    QryTrainingEmployeeModulesInventory_Basics: TWideStringField;
    QryTrainingEmployeeModulesFileMaintenance: TWideStringField;
    QryTrainingEmployeeModulesPurchase: TWideStringField;
    QryTrainingEmployeeModulesCRM: TWideStringField;
    QryTrainingEmployeeModulesMarketing: TWideStringField;
    QryTrainingEmployeeModulesSales: TWideStringField;
    QryTrainingEmployeeModulesPos: TWideStringField;
    QryTrainingEmployeeModulesBanking: TWideStringField;
    QryTrainingEmployeeModulesReports: TWideStringField;
    QryTrainingEmployeeModulesUtilities: TWideStringField;
    QryTrainingEmployeeModulesInventory_Advanced: TWideStringField;
    QryTrainingEmployeeModulesCustomerPayments: TWideStringField;
    QryTrainingEmployeeModulesSupplierPayments: TWideStringField;
    QryTrainingEmployeeModulesManufacturing: TWideStringField;
    QryTrainingEmployeeModulesAppointments: TWideStringField;
    QryTrainingEmployeeModulesPayroll: TWideStringField;
    QryTrainingEmployeeModulesFixedAssets: TWideStringField;
    QryTrainingEmployeeModulesWorkshop: TWideStringField;
    QryTrainingEmployeeModulesbudgets: TWideStringField;
    QryTrainingEmployeeModulesDelivery: TWideStringField;
    QryTrainingEmployeeModulesMatrix: TWideStringField;
    QryTrainingEmployeeModulesMoreTraining: TWideStringField;
    QryTrainingEmployeeModulesMoreTrainingDetails: TWideStringField;
    QryTrainingEmployeeModulesTrainingID: TLargeintField;
    QryTrainingEmployeeModulesGlobalRef: TWideStringField;
    QryTrainingEmployeeModulesTrainingEmployeeModuleID: TIntegerField;
    QryTrainingEmployeeModulesEmployeeId: TIntegerField;
    QryTrainingEmployeeModulesDateCreated: TDateTimeField;
    QryTrainingEmployeeModulesEnteredby: TIntegerField;
    QryTrainingEmployeeModulesmstimestamp: TDateTimeField;
    dsTrainingEmployeeModules: TDataSource;
    dsTrainingDays: TDataSource;
    qryTraining: TERPQuery;
    ERPQuery1GlobalRef: TWideStringField;
    ERPQuery1TrainingID: TLargeintField;
    ERPQuery1Description: TWideStringField;
    ERPQuery1TrainingDate: TDateField;
    ERPQuery1msTimeStamp: TDateTimeField;
    dsTraining: TDataSource;
    btnAutoSchedule: TDNMSpeedButton;
    BevelTrainingCalender: TBevel;
    btnTrainingModules: TDNMSpeedButton;
    MnuCalendar: TAdvPopupMenu;
    SelectDatesforTraining1: TMenuItem;
    pnlMultiSelectOption: TDNMPanel;
    Panel1: TPanel;
    rgSaturday: TRadioGroup;
    Panel2: TPanel;
    rgSunday: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    qryTrainingDay: TERPQuery;
    dsTrainingDay: TDataSource;
    qryTrainingDayID: TLargeintField;
    qryTrainingDayGlobalref: TWideStringField;
    qryTrainingDayDescription: TWideStringField;
    qryTrainingDayActive: TWideStringField;
    qryTrainingDaymsTimestamp: TDateTimeField;
    tabSetup: TTabSheet;
    DNMPanel2: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    cboDayStart: TComboBox;
    cboDayEnd: TComboBox;
    qryTrainingDayTrainingID: TIntegerField;
    wwDBGrid1: TwwDBGrid;
    cbotimefrom: TwwDBComboBox;
    cboTimeto: TwwDBComboBox;
    qryTrainingDayTimeFrom: TWideStringField;
    qryTrainingDayTimeTo: TWideStringField;
    qryTrainingDaytTimeFrom: TTimeField;
    qryTrainingDaytTimeTo: TTimeField;
    Label8: TLabel;
    qryDaysforTraining: TERPQuery;
    dsDaysforTraining: TDataSource;
    qryDaysforTrainingDays: TLargeintField;
    wwDBEdit1: TwwDBEdit;
    QryTrainingEmployeeModulesDataImport: TWideStringField;
    qryTrainingMinutesInADay: TIntegerField;
    wwDBEdit2: TwwDBEdit;
    qryTrainingHoursInADay: TWideStringField;
    Label9: TLabel;
    wwDBEdit3: TwwDBEdit;
    Label10: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    mnuautoSelectDays: TMenuItem;
    qryTrainingStartOfTheDay: TTimeField;
    qryTrainingEndOftheDay: TTimeField;
    qryTrainingTotalHours: TFloatField;
    QryTrainingEmployeeModulesERPSetup: TWideStringField;
    lblTraining: TGradientLabel;
    GradientLabel1: TGradientLabel;
    lblEmployee: TGradientLabel;
    grdTrainingScheduleIButton: TwwIButton;
    cboTraining: TwwDBLookupCombo;
    qryTrainingLookup: TERPQuery;
    WideStringField1: TWideStringField;
    LargeintField1: TLargeintField;
    WideStringField2: TWideStringField;
    DateField1: TDateField;
    DateTimeField1: TDateTimeField;
    IntegerField1: TIntegerField;
    WideStringField3: TWideStringField;
    TimeField1: TTimeField;
    TimeField2: TTimeField;
    FloatField1: TFloatField;
    Label11: TLabel;
    QryTrainingEmployeeModulesPurchase_FX: TWideStringField;
    chkIgnoreTrainingAtStartup: TwwCheckBox;
    QryTrainingEmployeeModulesFieldName: TWordField;
    QryTrainingEmployeeModulesGeneral_Templates: TWideStringField;
    QryTrainingEmployeeModulesHow_To: TWideStringField;
    QryTrainingEmployeeModulesHire: TWideStringField;
    QryTrainingEmployeeModulesmsUpdateSiteCode: TWideStringField;
    qryTrainingTotalTrainingDays: TIntegerField;
    qryTrainingmsUpdateSiteCode: TWideStringField;
    edtTotalTrainingDays: TwwDBEdit;
    Label12: TLabel;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEmployeesClick(Sender: TObject);
    procedure grdTrainingEmployeeModulesCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure btnPrintClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnScheduleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdTrainingScheduleDblClick(Sender: TObject);
    procedure TrainingCalenderDblClick(Sender: TObject);
    procedure btnAutoScheduleClick(Sender: TObject);
    procedure btnTrainingModulesClick(Sender: TObject);
    procedure QryTrainingDaysAfterPost(DataSet: TDataSet);
    procedure pgmainChange(Sender: TObject);
    procedure SelectDatesforTraining1Click(Sender: TObject);
    procedure TrainingCalenderClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdTrainingEmployeeModulesDblClick(Sender: TObject);
    procedure txtStarttimeDropDown(Sender: TObject);
    procedure cboDayStartCloseUp(Sender: TObject);
    procedure cboDayStartDropDown(Sender: TObject);
    procedure cboDayEndCloseUp(Sender: TObject);
    procedure cboDayEndDropDown(Sender: TObject);
    procedure mnuautoSelectDaysClick(Sender: TObject);
    procedure QryTrainingDaysAfterOpen(DataSet: TDataSet);
    procedure MnuCalendarPopup(Sender: TObject);
    procedure qryTrainingDayAfterPost(DataSet: TDataSet);
    procedure grdTrainingScheduleIButtonClick(Sender: TObject);
    procedure cboTrainingCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkIgnoreTrainingAtStartupClick(Sender: TObject);
  private
    st:TStringList;
    Holidays: ARRAY OF TDateTime;
    fiActivePage: Integer;
    fAfterTrainingformShow: TNotifyEvent;
    fAfterTrainingformClose: TNotifyEvent;
    fOpenGoLiveAfterSave: boolean;
    procedure AddEmployeesforTrainig(Sender: TObject);
    procedure RemoveemployeesAlreadySelected(Sender: TObject);
    procedure DoAddEmployeesforTraining(grdmain: TwwDBGrid);
    Procedure TrainingStatusForEmployee(Sender:TObject);
    Procedure HideInactiveModules(Const Sender: TBusObj; var Abort: boolean);
    procedure RefreshGrid;
    procedure AddDateForTraining(Dt: TDatetime);Overload;
    procedure AddDateForTraining;Overload;

    procedure ReadHolidays;
    procedure SelectDates;
    procedure refreshDaysforTraining;
    procedure DeleteTRainingDay;
    (*function ValidStrToTime(const S: string): TDateTime;*)
    function SaveData: boolean;
    function NeedsSaving: boolean;
    function EmployeesScheduled: boolean;
    procedure ResetcboDayStart;
    procedure ResetcboDayEnd;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    Procedure onShowERPHint(Const Value:Integer); override;
  public
//    TrainingDays: TTrainingDays;
//    TEM :TTrainingEmployeeModules;
    Training :TTraining;
    Procedure AddEmployeeforTraining(newEmployeeID:Integer);
    Property ActivePage :Integer read fiActivePage write fiActivePage;
    Property AfterTrainingformShow :TNotifyEvent read fAfterTrainingformShow write fAfterTrainingformShow;
    Property AfterTrainingformClose :TNotifyEvent read fAfterTrainingformClose write fAfterTrainingformClose;
    property OpenGoLiveAfterSave: boolean read fOpenGoLiveAfterSave write fOpenGoLiveAfterSave;
  end;



implementation

uses CommonLib, CommonDbLib, BusObjConst, CommonFormLib, BaseListingForm,
  AppEnvironment, frmTrainingStatus, EmployeeExpresslist,
  tcDataUtils, TrainingLib,DateUtils, MySQLConst, FastFuncs, timelib,
  GoLiveUtils, frmDelayMessageDlg;

{$R *.dfm}

function TfmTrainingAssignment.NeedsSaving: boolean;
begin
//  result := TEM.Dirty or (TEM.count = 0) or (not EmployeesScheduled);
  result := Training.Dirty or (Training.TrainingEmployeeModules.Count = 0) or (not EmployeesScheduled);
end;

function TfmTrainingAssignment.SaveData: boolean;
begin
  result:= false;
  if Training.dirty then begin
      if not Training.Save then exit;
  end;
  {goto employee page if none selected}
  if (Training.TrainingModules.count = 0) and (pgmain.ActivePage = tabSchedule) then begin
      pgmain.ActivePage := tabEmployees;
      Exit;
  end;

  if not EmployeesScheduled then begin
    if MessageDlgXP_Vista('Nothing is Scheduled.   Do You Wish to Auto Schedule?', mtWarning, [mbYes, mbNo], 0)  = mryes then begin
      if Training.TrainingDays.count = 0 then begin
        MessageDlgXP_Vista('Please Select the Trainings Days' , mtInformation , [mbok],0);
        pgmain.ActivePage := tabSchedule;
        exit;
      end else begin
        btnAutoSchedule.click;
        exit;
      end;
    end;
  end;

  result := true;
end;

procedure TfmTrainingAssignment.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if SaveData then begin
    self.CommitTransaction;
    Training.Dirty := false;

    if OpenGoLiveAfterSave then begin
      if GoLiveUtils.GoLiveRecordCount = 0 then
        GoLiveUtils.CreateDefaultGoLiveRecords;
      OpenErpForm('TfmProjectGoLive',0);

    end;

    Self.close;
  end;
end;

procedure TfmTrainingAssignment.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTrainingAssignment.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Training.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            self.CommitTransaction;
            Training.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          Self.RollbackTransaction;
//          TEM.Dirty := false;
          Training.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmTrainingAssignment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if assigned(fAfterTrainingformClose) then fAfterTrainingformClose(Self);
  inherited;
  (*CloseERPVideo;*)
  Action := caFree;
//  TEM := nil;
//  TrainingDays:= nil;
end;

procedure TfmTrainingAssignment.btnEmployeesClick(Sender: TObject);
begin
  inherited;
  pgmain.activepage :=tabEmployees;
  OpenERPFormModal('TEmployeeExpresslistGUI' , 0, RemoveemployeesAlreadySelected  );
  pgmainChange(pgmain);
end;

procedure TfmTrainingAssignment.AddEmployeesforTrainig(Sender: TObject);
begin
  if sender is TDNMSpeedButton then
    if Assigned(TDNMSpeedButton(SendeR).Owner) then
      if TDNMSpeedButton(SendeR).Owner is TBaseListingGUI then begin

        DoAddEmployeesforTraining(TBaseListingGUI(TDNMSpeedButton(SendeR).Owner).grdmain);
        TBaseListingGUI(TDNMSpeedButton(SendeR).Owner).Close;
      end;
end;
procedure TfmTrainingAssignment.RemoveemployeesAlreadySelected(Sender: TObject);
var
  str:String;
begin
  if sender is TEmployeeExpresslistGUI then begin
//    str:=TERPQuery(TEM.Dataset).GroupConcat('EmployeeId' , '' , False , ' and EmployeeId <> ' );
    str:=TERPQuery(Training.TrainingEmployeeModules.Dataset).GroupConcat('EmployeeId' , '' , False , ' and EmployeeId <> ' );
    if str<> '' then
    TEmployeeExpresslistGUI(Sender).FilterString := 'EmployeeId <> ' +str;
    TEmployeeExpresslistGUI(Sender).grdMain.Options:=TEmployeeExpresslistGUI(Sender).grdMain.Options + [dgMultiSelect];
    TEmployeeExpresslistGUI(Sender).grdMain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
    TEmployeeExpresslistGUI(Sender).cmdClose.OnClick :=  AddEmployeesforTrainig;
    TEmployeeExpresslistGUI(Sender).ShowERPHint := Self.ShowERPHint;
  end;
end;

procedure TfmTrainingAssignment.ResetcboDayEnd;
begin
  cboDayend.text := FormatDateTime('hh:nn:ss AM/PM' , Training.EndOftheDay);
end;

procedure TfmTrainingAssignment.ResetcboDayStart;
begin
  cboDayStart.text := FormatDateTime('hh:nn:ss AM/PM' , Training.StartOftheDay);
end;

procedure TfmTrainingAssignment.DoAddEmployeesforTraining(grdmain :TwwDBGrid);
var
  i:Integer;
  bmBookmark: TBookmark;
  Qrymain :TERPQuery;
begin
  Qrymain := TERPQuery(grdMain.Datasource.Dataset);
  bmBookmark := Qrymain.GetBookmark;
  try
    showProgressbar('Please Wait', grdMain.SelectedList.Count);
    try
      if grdMain.SelectedList.Count > 0 then begin
          for i := 0 to grdMain.SelectedList.Count - 1 do begin
            stepProgressbar;
            Qrymain.GotoBookmark(grdMain.SelectedList.Items[i]);
//            if not TEM.Locate('EmployeeID' ,Qrymain.fieldbyname('employeeID').asInteger , []) then begin
//                TEM.New;
//                TEM.EmployeeId  := Qrymain.fieldbyname('EmployeeId').asInteger ;
//                TEM.PostDB;
//            end;
            if not Training.TrainingEmployeeModules.Locate('EmployeeID' ,Qrymain.fieldbyname('employeeID').asInteger , []) then begin
                Training.TrainingEmployeeModules.New;
                Training.TrainingEmployeeModules.EmployeeId  := Qrymain.fieldbyname('EmployeeId').asInteger ;
                Training.TrainingEmployeeModules.PostDB;
                if not Training.TrainingEmployeeModules.Save then
                  raise Exception.Create('Error Creating Employee Training: ' + Training.TrainingEmployeeModules.ResultStatus.Messages);

            end;
          end;
      end;
    finally
        hideProgressbar;
    end;
  finally
    qryMain.GotoBookmark(bmBookmark);
    qryMain.FreeBookmark(bmBookmark);
    Freeandnil(Qrymain);
  end;
end;



procedure TfmTrainingAssignment.grdTrainingEmployeeModulesCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  AFont.Style := AFont.Style - [fsBold];

//  if TEM.Id = TEm.currentId then
  if Training.TrainingEmployeeModules.ID = Training.TrainingEmployeeModules.CurrentId then
    ABrush.Color := clMoneyGreen
  else ABrush.Color := grdTrainingEmployeeModules.FooterColor;
  (*if Sysutils.SameText (TEM.EmployeeName , ERPProjectManager) then AFont.coloue := clred;*)
  
end;

procedure TfmTrainingAssignment.btnPrintClick(Sender: TObject);
var
   ssql:String;
   Qry :TDataset;
   function ModulefieldName(const Seqno:Integer):String;
   begin
       Qry.Locate('Seqno' ,Seqno , []);
       result:=Qry.FieldByname('TEMFieldname').asString;
   end;
begin
{sql is dynamic to get the modules in user defined sequence}
  inherited;
//  Qry := TEM.getNewDataset('Select SeqNo, TEMFieldname from tbltrainingmodules Where trainingid = ' +IntToStr(TEM.TrainingID)+'  order by SeqNo' , true);
  Qry := Training.TrainingEmployeeModules.GetNewDataset('Select SeqNo, TEMFieldname from tbltrainingmodules Where trainingid = ' +IntToStr(Training.ID)+'  order by SeqNo' , true);
  try
     ssql := '{companyinfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
          'CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,  ' +
          'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO ' +
          '~|||~{details}Select TEM.EmployeeId, TEM.EmployeeName  , TEM.MoreTrainingDetails, ' +
          'TM1.TrainingModuleName Module1Name, TM1.TrainingHrs Module1hrs,TEM.' + ModulefieldName(1)+' as Module1, ' +
          'TM2.TrainingModuleName Module2Name, TM2.TrainingHrs Module2hrs,TEM.' + ModulefieldName(2)+' as Module2, ' +
          'TM3.TrainingModuleName Module3Name, TM3.TrainingHrs Module3hrs,TEM.' + ModulefieldName(3)+' as Module3, ' +
          'TM4.TrainingModuleName Module4Name, TM4.TrainingHrs Module4hrs,TEM.' + ModulefieldName(4)+' as Module4, ' +
          'TM5.TrainingModuleName Module5Name, TM5.TrainingHrs Module5hrs,TEM.' + ModulefieldName(5)+' as Module5, ' +
          'TM6.TrainingModuleName Module6Name, TM6.TrainingHrs Module6hrs,TEM.' + ModulefieldName(6)+' as Module6, ' +
          'TM7.TrainingModuleName Module7Name, TM7.TrainingHrs Module7hrs,TEM.' + ModulefieldName(7)+' as Module7, ' +
          'TM8.TrainingModuleName Module8Name, TM8.TrainingHrs Module8hrs,TEM.' + ModulefieldName(8)+' as Module8, ' +
          'TM9.TrainingModuleName Module9Name, TM9.TrainingHrs Module9hrs,TEM.' + ModulefieldName(9)+' as Module9, ' +
          'TM10.TrainingModuleName Module10Name, TM10.TrainingHrs Module10hrs,TEM.' + ModulefieldName(10)+' as Module10, ' +
          'TM11.TrainingModuleName Module11Name, TM11.TrainingHrs Module11hrs,TEM.' + ModulefieldName(11)+' as Module11, ' +
          'TM12.TrainingModuleName Module12Name, TM12.TrainingHrs Module12hrs,TEM.' + ModulefieldName(12)+' as Module12, ' +
          'TM13.TrainingModuleName Module13Name, TM13.TrainingHrs Module13hrs,TEM.' + ModulefieldName(13)+' as Module13, ' +
          'TM14.TrainingModuleName Module14Name, TM14.TrainingHrs Module14hrs,TEM.' + ModulefieldName(14)+' as Module14, ' +
          'TM15.TrainingModuleName Module15Name, TM15.TrainingHrs Module15hrs,TEM.' + ModulefieldName(15)+' as Module15, ' +
          'TM16.TrainingModuleName Module16Name, TM16.TrainingHrs Module16hrs,TEM.' + ModulefieldName(16)+' as Module16, ' +
          'TM17.TrainingModuleName Module17Name, TM17.TrainingHrs Module17hrs,TEM.' + ModulefieldName(17)+' as Module17, ' +
          'TM18.TrainingModuleName Module18Name, TM18.TrainingHrs Module18hrs,TEM.' + ModulefieldName(18)+' as Module18, ' +
          'TM19.TrainingModuleName Module19Name, TM19.TrainingHrs Module19hrs,TEM.' + ModulefieldName(19)+' as Module19, ' +
          'TM20.TrainingModuleName Module20Name, TM20.TrainingHrs Module20hrs,TEM.' + ModulefieldName(20)+' as Module20, ' +
          'TM21.TrainingModuleName Module21Name, TM21.TrainingHrs Module21hrs,TEM.' + ModulefieldName(21)+' as Module21, ' +
          'TM22.TrainingModuleName Module22Name, TM22.TrainingHrs Module22hrs,TEM.' + ModulefieldName(22)+' as Module22, ' +
          'TM23.TrainingModuleName Module23Name, TM23.TrainingHrs Module23hrs,TEM.' + ModulefieldName(23)+' as Module23, ' +
          'TM24.TrainingModuleName Module24Name, TM24.TrainingHrs Module24hrs,TEM.' + ModulefieldName(24)+' as Module24, ' +
          'TM25.TrainingModuleName Module25Name, TM25.TrainingHrs Module25hrs,TEM.' + ModulefieldName(25)+' as Module25, ' +
          'TM26.TrainingModuleName Module26Name, TM26.TrainingHrs Module26hrs,TEM.' + ModulefieldName(26)+' as Module26, ' +
          'TM27.TrainingModuleName Module27Name, TM27.TrainingHrs Module27hrs,TEM.' + ModulefieldName(27)+' as Module27, ' +
          'TM28.TrainingModuleName Module28Name, TM28.TrainingHrs Module28hrs,TEM.' + ModulefieldName(28)+' as Module28, ' +
          'TM28.TrainingModuleName Module28Name, TM29.TrainingHrs Module28hrs,TEM.' + ModulefieldName(29)+' as Module28, ' +
          'TM28.TrainingModuleName Module28Name, TM30.TrainingHrs Module28hrs,TEM.' + ModulefieldName(30)+' as Module28, ' +
          'TM29.TrainingModuleName Module29Name, TM31.TrainingHrs Module29hrs,TEM.' + ModulefieldName(31)+' as Module29 ' +
          'from tblTrainingEmployeeModules TEM ' +
          'inner join tbltrainingmodules TM1   on  TEM.TrainingID = TM1.TRainingID      and TM1.Seqno  =1 ' +
          'inner join tbltrainingmodules TM2   on  TEM.TrainingID = TM2.TRainingID      and TM2.Seqno  =2 ' +
          'inner join tbltrainingmodules TM3   on  TEM.TrainingID = TM3.TRainingID      and TM3.Seqno  =3 ' +
          'inner join tbltrainingmodules TM4   on  TEM.TrainingID = TM4.TRainingID      and TM4.Seqno  =4 ' +
          'inner join tbltrainingmodules TM5   on  TEM.TrainingID = TM5.TRainingID      and TM5.Seqno  =5 ' +
          'inner join tbltrainingmodules TM6   on  TEM.TrainingID = TM6.TRainingID      and TM6.Seqno  =6 ' +
          'inner join tbltrainingmodules TM7   on  TEM.TrainingID = TM7.TRainingID      and TM7.Seqno  =7 ' +
          'inner join tbltrainingmodules TM8   on  TEM.TrainingID = TM8.TRainingID      and TM8.Seqno  =8 ' +
          'inner join tbltrainingmodules TM9   on  TEM.TrainingID = TM9.TRainingID      and TM9.Seqno  =9 ' +
          'inner join tbltrainingmodules TM10  on  TEM.TrainingID = TM10.TRainingID      and TM10.Seqno =10 ' +
          'inner join tbltrainingmodules TM11  on  TEM.TrainingID = TM11.TRainingID      and TM11.Seqno =11 ' +
          'inner join tbltrainingmodules TM12  on  TEM.TrainingID = TM12.TRainingID      and TM12.Seqno =12 ' +
          'inner join tbltrainingmodules TM13  on  TEM.TrainingID = TM13.TRainingID      and TM13.Seqno =13 ' +
          'inner join tbltrainingmodules TM14  on  TEM.TrainingID = TM14.TRainingID      and TM14.Seqno =14 ' +
          'inner join tbltrainingmodules TM15  on  TEM.TrainingID = TM15.TRainingID      and TM15.Seqno =15 ' +
          'inner join tbltrainingmodules TM16  on  TEM.TrainingID = TM16.TRainingID      and TM16.Seqno =16 ' +
          'inner join tbltrainingmodules TM17  on  TEM.TrainingID = TM17.TRainingID      and TM17.Seqno =17 ' +
          'inner join tbltrainingmodules TM18  on  TEM.TrainingID = TM18.TRainingID      and TM18.Seqno =18 ' +
          'inner join tbltrainingmodules TM19  on  TEM.TrainingID = TM19.TRainingID      and TM19.Seqno =19 ' +
          'inner join tbltrainingmodules TM20  on  TEM.TrainingID = TM20.TRainingID      and TM20.Seqno =20 ' +
          'inner join tbltrainingmodules TM21  on  TEM.TrainingID = TM21.TRainingID      and TM21.Seqno =21 ' +
          'inner join tbltrainingmodules TM22  on  TEM.TrainingID = TM22.TRainingID      and TM22.Seqno =22 ' +
          'inner join tbltrainingmodules TM23  on  TEM.TrainingID = TM23.TRainingID      and TM23.Seqno =23 ' +
          'inner join tbltrainingmodules TM24  on  TEM.TrainingID = TM24.TRainingID      and TM24.Seqno =24 ' +
          'inner join tbltrainingmodules TM25  on  TEM.TrainingID = TM25.TRainingID      and TM25.Seqno =25 ' +
          'inner join tbltrainingmodules TM26  on  TEM.TrainingID = TM26.TRainingID      and TM26.Seqno =26 ' +
          'inner join tbltrainingmodules TM27  on  TEM.TrainingID = TM27.TRainingID      and TM27.Seqno =27 ' +
          'inner join tbltrainingmodules TM28  on  TEM.TrainingID = TM28.TRainingID      and TM28.Seqno =28 ' +
          'inner join tbltrainingmodules TM29  on  TEM.TrainingID = TM28.TRainingID      and TM28.Seqno =29 ' +
          'inner join tbltrainingmodules TM30  on  TEM.TrainingID = TM28.TRainingID      and TM28.Seqno =30 ' +
          'inner join tbltrainingmodules TM31  on  TEM.TrainingID = TM29.TRainingID      and TM29.Seqno =31 ' ;
  finally
      closeDb(Qry);
      freeandnil(Qry);
  end;
  fbReportSQLSupplied:= true;
  PrintTemplateReport('Training Assignment Sheet'  , ssql , not(Appenv.Employee.ShowPreview) , 1);
end;

procedure TfmTrainingAssignment.TrainingStatusForEmployee(Sender: TObject);
begin
  if not(Sender is TfmTrainingStatus) then exit;
//  TfmTrainingStatus(Sender).EmployeeId := TEM.EmployeeId;
  TfmTrainingStatus(Sender).EmployeeId := Training.TrainingEmployeeModules.EmployeeId;
  TfmTrainingStatus(Sender).TrainingID := Training.ID;
end;

procedure TfmTrainingAssignment.btnStatusClick(Sender: TObject);
begin
  inherited;
  pgmain.activepage :=tabEmployees;
//  if TEM.EmployeeId = 0 then exit;
  if Training.TrainingEmployeeModules.EmployeeId = 0 then exit;
//  if not TEM.AnyModuleAssigned then begin
  if not Training.TrainingEmployeeModules.AnyModuleAssigned then begin
//    MessageDlgXP_Vista('None of the Module assigned for ' +TEM.EmployeeName  , mtInformation , [mbok] , 0);
    MessageDlgXP_Vista('None of the Module assigned for ' + Training.TrainingEmployeeModules.EmployeeName  , mtInformation , [mbok] , 0);
    exit;
  end;
//  if (TEM.EmployeeId = AppEnv.Employee.EmployeeID) or
  if (Training.TrainingEmployeeModules.EmployeeId = AppEnv.Employee.EmployeeID) or
    (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanUpdateTrainingstatus') =1)   then begin
//    if TEM.Dirty then begin
    if NeedsSaving then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
//          if not TEM.Save then exit;
          if not SaveData then exit;
          Self.CommitTransaction;
          Training.Dirty := false;
        end;
      mrNo:
        begin
//          TEM.CancelDB;
          Training.Cancel;
          Self.RollbackTransaction;
          Training.Dirty := false;
        end;
      mrCancel:
        begin
          exit;
        end;
    end;

    end;
    OpenERPFormModal('TfmTrainingStatus' , 0 ,TrainingStatusForEmployee);
    (*  ShowERPHint(3);
      if TEM.count > 0 then
        ShowERPHint(4);*)
    pgmainChange(pgmain);

    Self.BeginTransaction;
//  end else if TEM.EmployeeId <> AppEnv.Employee.EmployeeID then begin
//      MessageDlgXP_Vista('You Don''t Have Access to ' + TEM.EmployeeName+'''s Status' , mtWarning, [mbok],0);
//  end;
  end else if Training.TrainingEmployeeModules.EmployeeId <> AppEnv.Employee.EmployeeID then begin
      MessageDlgXP_Vista('You Don''t Have Access to ' + Training.TrainingEmployeeModules.EmployeeName+'''s Status' , mtWarning, [mbok],0);
  end;
end;

procedure TfmTrainingAssignment.btnScheduleClick(Sender: TObject);
begin
  inherited;
//  if TEM.dirty then begin
//      if not TEM.Save then exit;
//  end;
  if NeedsSaving then begin
      if not SaveData then exit;
  end;
  Self.CommitTransaction;
end;


procedure TfmTrainingAssignment.FormCreate(Sender: TObject);
begin
  inherited;
  fOpenGoLiveAfterSave := false;
  Training := TTraining.Create(Self);
  Training.Connection := TMyDacDataConnection.Create(Training);
  Training.Connection.Connection := Self.MyConnection;
  Training.BusObjEvent := DoBusinessObjectEvent;
  fiActivePage := 0;
  ReadHolidays;
  fAfterTrainingformShow:= nil;
  fAfterTrainingformClose:= nil;
  chkIgnoreTrainingAtStartup.Checked := AppEnv.CompanyPrefs.IgnoreTraining;
end;

Procedure TfmTrainingAssignment.ReadHolidays;
begin
  With CommonDbLib.TempMyQuery do try
    SQL.add('SELECT Day FROM tblpublicholidays ' + 'WHERE Day >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, TrainingCalender.Date)) +
          ' AND Day <=  ' + QuotedStr(FormatDateTime(MysqlDateFormat, TrainingCalender.endDate)) );
    open;
    Setlength(Holidays, RecordCount);
    while not Eof do begin
      Holidays[RecNo - 1] := FieldByName('Day').AsDateTime;
      Next;
    end;
  finally
    if active then close;
    free;
  end;
end;

procedure TfmTrainingAssignment.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
var
  strSQL:String;
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
               if Sender is TTrainingEmployeeModules  then TTrainingEmployeeModules(Sender).Dataset := QryTrainingEmployeeModules
        else if Sender is TTraining                 then TTraining(Sender).Dataset                := qryTraining
        else if Sender is TTrainingDay              then TTrainingDay(Sender).Dataset             := qryTrainingDay
        else if Sender is TTrainingDays             then TTrainingDays(Sender).Dataset            := QryTrainingDays;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_TotalHours) then begin
        TRaining.EditDB;
        Training.PostDB;
    end else if (Eventtype = BusobjEvent_Event ) and (Value = BusObjEventDataset_AfterPost) then begin
      if sender is TTrainingDays then begin
        closedb(qryDaysforTraining);
        opendb(qryDaysforTraining);
      end;
    end else if (Eventtype = BusObjEventCall ) and (Value = BusobjEventVal_EmptyTrainingroster) then begin
      if MessageDlgXP_Vista('This Training is already started Scheduling.  Do You Wish to Delete All Existing Schedule and Reschedule? ' , mtConfirmation , [mbyes, mbno] , 0) = mrYes then begin
        strSQL:=ReplaceStr(TRaining.TrainingRoster.SQL , 'Select *' , 'Delete ');
        TRaining.GetNewDataSet(strSQL);
        self.BeginTransaction;
        Training.TrainingRoster.closeDB;
        Training.TrainingRoster;
      end;
    end;
end;


function TfmTrainingAssignment.EmployeesScheduled: boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Add('select Count(*) as Count from tblRoster');
    qry.SQL.Add('where Type = "Training"');
    qry.SQL.Add('and EmployeeID in ');
    qry.SQL.Add('(select EmployeeID from tblTrainingEmployeeModules where TrainingID = ' + IntToStr(Training.ID) + ')');
    qry.Open;
    result := qry.FieldByName('Count').AsInteger > 0;
  finally
    qry.Free;
  end;
end;

procedure TfmTrainingAssignment.FormShow(Sender: TObject);
var
  MaxRange: integer;
begin
  inherited;
  //TrainingDays:=Training.TrainingDays;(*TrainingDays.Load;*)
  (*TEM.Load;
  TrainingDays.Load;*)
  CloseDb(qryTrainingLookup);
  OpenDb(qryTrainingLookup);

  if KeyID > 0 then
    Training.Load(KEyID)
  else
    Training.Load;
  Self.BeginTransaction;
  if Training.count = 0 then begin
      Training.New;
      Training.dataset.FieldByname(Training.IDFieldName).asInteger := 1;
      Training.TrainingDate := Date;
      Training.Description := 'E R P Training';
      Training.PostDB;
      qryTrainingLookup.Refresh;
  end;
  if qryTrainingLookup.Locate('Description',Training.Description,[]) then
    cboTraining.Text := qryTrainingLookup.FieldByName('Description').AsString;
  (*txtStarttime.text:=   FormatDateTime('hh:nn AM/PM' , Appenv.CompanyPrefs.StartOfDay);
  txtEndtime.text:=   FormatDateTime('hh:nn AM/PM' , Appenv.CompanyPrefs.EndOfDay);*)

  cboDayStart.text:=   FormatDateTime('hh:nn:ss AM/PM' , training.StartOfTheDay);
  cboDayend.text:=   FormatDateTime('hh:nn:ss AM/PM' , TRaining.EndOftheDay);


//  TEM := Training.TrainingEmployeeModules;
//  TrainingDays := Training.TrainingDays;
  Training.TrainingDay;
  MaxRange := TrainingCalender.MaxSelectRange;
  try
    TrainingCalender.MaxSelectRange := High(Integer);
    if Training.TrainingDays.count = 0 then begin
      TrainingCalender.Date :=Training.TrainingDate
    end else begin
      Training.TrainingDays.First;
      TrainingCalender.Date := Training.TrainingDays.TrainingDate;
    end;
    TrainingCalender.enddate := TrainingCalender.date;
  finally
    TrainingCalender.MaxSelectRange := MaxRange;
  end;
  RefreshGrid;//Training.TrainingModules.Iteraterecords(HideInactiveModules);
  Application.ProcessMessages;

       if fiActivePage =1        then pgmain.ActivePage:= tabSetup
  else if fiActivePage =2        then pgmain.ActivePage:= tabSchedule
  else if fiActivePage =2        then pgmain.ActivePage:= tabEmployees
  else if Training.TrainingDays.count = 0 then pgmain.ActivePage:= tabSetup
  else if fiActivePage =1        then pgmain.activepage :=tabSchedule
  else pgmain.activepage :=tabEmployees;

  if Training.TotalTrainingDays = 0 then begin
    DelayMessageDlg('Please enter the the total number of training days that are required on the Setup Tab.',mtINformation,[mbOk],0);
  end;

  pgmainChange(pgmain);
  refreshDaysforTraining;
  if Assigned(fAfterTrainingformShow) then fAfterTrainingformShow(Self);
end;

procedure TfmTrainingAssignment.grdTrainingScheduleDblClick(Sender: TObject);
begin
  inherited;
  DeleteTRainingDay;
end;
procedure TfmTrainingAssignment.DeleteTRainingDay;
begin
  if Training.TrainingDays.Dataset.state = dsinsert then Training.TrainingDays.cancel
  else begin
      Training.TrainingDays.Active := False;
      Training.TrainingDays.PostDB;
  end;
end;

procedure TfmTrainingAssignment.TrainingCalenderDblClick(Sender: TObject);
begin
  AddDateForTraining(TrainingCalender.Date);
end;
procedure TfmTrainingAssignment.AddDateForTraining(Dt:TDatetime);
var
  bm:TBookmark;
  TrainingDayId:Integer;
begin
  inherited;
  TrainingDayId :=0;
  Training.TrainingDays.Dataset.DisableControls;
  try
    bm:= Training.TrainingDays.Dataset.GetBookmark;
    try
      Training.TrainingDays.Dataset.filtered := False;
      if Training.TrainingDays.locate('TrainingDate' ,Dt , []) then begin
        TrainingDayId :=Training.TrainingDays.ID;
        Training.TrainingDays.Active:= True;
        Training.TrainingDays.PostDB;
        Exit;
      end;
    finally
        Training.TrainingDays.dataset.GotoBookmark(bm);
        Training.TrainingDays.Dataset.FreeBookmark(bm);
        Training.TrainingDays.Dataset.filtered := True;
    end;
  finally
      Training.TrainingDays.Dataset.Enablecontrols;
  end;
  if TrainingDayId <> 0 then begin
    Training.TrainingDays.Locate(Training.TrainingDays.IDfieldName,TrainingDayId , []);
  end else begin
    Training.TrainingDays.New;
    Training.TrainingDays.TrainingDate := Dt;
    Training.TrainingDays.PostDB;
  end;
end;

procedure TfmTrainingAssignment.btnAutoScheduleClick(Sender: TObject);
var
  tmpResultStatus: TResultStatusItem;
begin
  inherited;
  QryTrainingEmployeeModules.Disablecontrols;
  try
    if MessageDlgXP_Vista('This Will Save Current Changes.  Do you Wish to Save and continue Auto Scheduling the Training?' , mtConfirmation , [mbyes, mbno] , 0) = mrNo then exit;

    if not Training.TrainingDays.Save then Exit;
    if not Training.TrainingEmployeeModules.Save then exit;
    Self.CommitTransaction;
    Self.BeginTransaction;

    if MessageDlgXP_Vista('Once If Auto-Scheduled, It Is Not Possible To Auto-Schedule Again. Any Changes To The Training Modules Should Be Manually Adjusted.  Do You Wish To Continue? ' , mtConfirmation , [mbyes, mbno] , 0) = mrNo then exit;

        if Training.AutoSchedule then begin
            Self.CommitTransaction;
            Training.Dirty := false;
            Self.Close;
        end else begin
          tmpResultStatus := Training.ResultStatus.GetLastStatusItem;
        if Assigned(tmpResultStatus) then
          if tmpResultStatus.Code = 2 then begin
              pgmain.activepage :=tabEmployees;
              commonlib.SetControlFocus(btnEmployees);
          end else if tmpResultStatus.Code = 3 then begin
              pgmain.ActivePage:= tabSchedule;
              commonlib.SetControlFocus(TrainingCalender);
          end;
      end;
  finally
      QryTrainingEmployeeModules.enablecontrols;
  end;
end;

procedure TfmTrainingAssignment.btnTrainingModulesClick(Sender: TObject);
begin
  inherited;
  pgmain.activepage :=tabEmployees;
  OpenERPFormModal('TfmTrainingModules' , 0 );
  pgmainChange(pgmain);
  RefreshGrid;
end;
procedure TfmTrainingAssignment.RefreshGrid;
begin
  st:=TStringList.create;
  try
    st.add('EmployeeName'+#9+'15'+#9+'Employee~(Dbl Click)'+#9+#9);
//    Training.TrainingModules.closeDB;
    Training.TrainingModules.Iteraterecords(HideInactiveModules);
    grdTrainingEmployeeModules.Selected.text := st.Text;
    grdTrainingEmployeeModules.ApplySelected;
  finally
      Freeandnil(st);
  end;
end;

procedure TfmTrainingAssignment.HideInactiveModules(const Sender: TBusObj;var Abort: boolean);
begin
  if not(Sender is TTrainingModules) then exit;
  if  (TTrainingModules(Sender).Active) then  begin
    if QryTrainingEmployeeModules.FindField(TTrainingModules(Sender).TEMFieldname) <> nil then
      st.add(TTrainingModules(Sender).TEMFieldname +#9+'10'+#9+
              QryTrainingEmployeeModules.FindField(TTrainingModules(Sender).TEMFieldname).Displaylabel+#9+#9);
  end;
end;

procedure TfmTrainingAssignment.QryTrainingDaysAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  ShowERPHint(2);
  closeDB(qryDaysforTraining);
  openDB(qryDaysforTraining);
end;

procedure TfmTrainingAssignment.pgmainChange(Sender: TObject);
begin
  inherited;
  if pgmain.activepage =tabEmployees then begin
     if Training.TrainingEmployeeModules.count = 0 then begin
      ShowERPHint(3);
     end else begin
      ShowERPHint(4);
     end;
     (*PlayERPVideo(exedir+'videos\Step 8 Employees.avi' );*)
  end else if pgmain.Activepage = tabSchedule then begin
    if Training.TrainingDays.count = 0 then begin
      ShowERPHint(1);
    end else begin
      ShowERPHint(2);
    end;
    //mnuautoSelectDays.Caption := 'Auto Select '+Training.Daysplan ;
    (*PlayERPVideo(exedir+'videos\Step 7 Schedule.avi' );*)
  end else if pgmain.ActivePage = tabsetup then begin
    ShowERPHint(11);
    (*PlayERPVideo(exedir+'videos\Step 6 Training.avi' );*)
  end;
end;

procedure TfmTrainingAssignment.onShowERPHint(const Value: Integer);
begin
       if Value in [1, 2] then HighlightControl(TrainingCalender)
  else if Value = 3 then HighlightControl(btnEmployees)
  else if Value = 4 then begin
    HighlightControl(btnAutoSchedule);
    (*HighlightextraControl1(btnCompleted);*)
  end else inherited;
end;

procedure TfmTrainingAssignment.SelectDatesforTraining1Click(Sender: TObject);
begin
  inherited;
  SelectDates;
end;
procedure TfmTrainingAssignment.SelectDates;
begin
  if TrainingCalender.date> TrainingCalender.EndDate then exit;

  if TrainingCalender.date = TrainingCalender.EndDate then
    AddDateForTraining(TrainingCalender.date)
  else begin
    AddDateForTraining;
    TrainingCalenderClick(nil);
  end;
end;

procedure TfmTrainingAssignment.AddDateForTraining;
var
dt:TDatetime;

  function IsSaturday:boolean;
  begin
    result := SysUtils.DayofWeek(dt)=7;
  end;

  function IsSunday:boolean;
  begin
    result := SysUtils.DayofWeek(dt)=1;
  end;

  function IsHoliday(dt: TDateTime): Boolean;
  var i: Integer;
  begin
      result := True;
      for i := 0 to Length(Holidays) - 1 do
        if Holidays[i] = DateOf(dt) then
          EXIT;
      result := False;
  end;

begin
  inherited;
  try
    ReadHolidays;
    Dt := TrainingCalender.Date;
    while Dt<= TrainingCalender.EndDate do begin
        if ((IsSaturday)  and (rgSaturday.itemindex =1)) or
           ((IsSunday)    and (rgSunday.itemindex   =1))   then
          dt:= incday(Dt,1)
        else if ((IsSaturday)  and (rgSaturday.itemindex =2)) or
           ((IsSunday)    and (rgSunday.itemindex   =2))   then begin
            dt:= incday(Dt,1);
            if dt>TrainingCalender.EndDate then TrainingCalender.EndDate := dt;
            continue;
        end else begin
            AddDateForTraining(dt);
            dt:= incday(Dt,1);
        end;
      end;
  finally
    TrainingCalender.EndDate := TrainingCalender.Date;
  end;
end;

procedure TfmTrainingAssignment.TrainingCalenderClick(Sender: TObject);
begin
  inherited;
  //pnlMultiSelectOption.visible:=TrainingCalender.date <>TrainingCalender.enddate;
end;

procedure TfmTrainingAssignment.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  SelectDates;
end;

procedure TfmTrainingAssignment.grdTrainingEmployeeModulesDblClick(
  Sender: TObject);
var
  Flag:boolean;
begin
  inherited;
    if Training.TrainingEmployeeModules.count = 0 then exit;
    if Training.TrainingEmployeeModules.EmployeeId = 0 then exit;
    (*if Sysutils.SameText(TEM.EmployeeName , ERPProjectManager) then exit;*)

    Flag :=
      (Training.TrainingEmployeeModules.DataImport                   =False) or
      (Training.TrainingEmployeeModules.BasicFeatures               =False) or
      (Training.TrainingEmployeeModules.Purchase_FX               =False) or
      (Training.TrainingEmployeeModules.ERPSetup               =False) or
      (Training.TrainingEmployeeModules.Employee                     =False) or
      (Training.TrainingEmployeeModules.Accounts                     =False) or
      (Training.TrainingEmployeeModules.Inventory_Basics             =False) or
      (Training.TrainingEmployeeModules.FileMaintenance              =False) or
      (Training.TrainingEmployeeModules.Purchase                     =False) or
      (Training.TrainingEmployeeModules.CRM                          =False) or
      (Training.TrainingEmployeeModules.Marketing                    =False) or
      (Training.TrainingEmployeeModules.Sales                        =False) or
      (Training.TrainingEmployeeModules.Pos                          =False) or
      (Training.TrainingEmployeeModules.CustomerPayments             =False) or
      (Training.TrainingEmployeeModules.SupplierPayments             =False) or
      (Training.TrainingEmployeeModules.Banking                      =False) or
      (Training.TrainingEmployeeModules.Reports                      =False) or
      (Training.TrainingEmployeeModules.General_Templates            =False) or
      (Training.TrainingEmployeeModules.Utilities                    =False) or
      (Training.TrainingEmployeeModules.Inventory_Advanced           =False) or
      (Training.TrainingEmployeeModules.Manufacturing                =False) or
      (Training.TrainingEmployeeModules.Appointments                 =False) or
      (Training.TrainingEmployeeModules.Payroll                      =False) or
      (Training.TrainingEmployeeModules.FixedAssets                  =False) or
      (Training.TrainingEmployeeModules.Workshop                     =False) or
      (Training.TrainingEmployeeModules.budgets                      =False) or
      (Training.TrainingEmployeeModules.Delivery                     =False) or
      (Training.TrainingEmployeeModules.How_To                     =False) or
      (Training.TrainingEmployeeModules.Hire                     =False) or
      (Training.TrainingEmployeeModules.Matrix                       =False) ;
      Training.TrainingEmployeeModules.DataImport                  := Flag;
      Training.TrainingEmployeeModules.BasicFeatures              := Flag;
      Training.TrainingEmployeeModules.Purchase_FX              := Flag;
      Training.TrainingEmployeeModules.ERPSetup              := Flag;
      Training.TrainingEmployeeModules.Employee                    := Flag;
      Training.TrainingEmployeeModules.Accounts                    := Flag;
      Training.TrainingEmployeeModules.Inventory_Basics            := Flag;
      Training.TrainingEmployeeModules.FileMaintenance             := Flag;
      Training.TrainingEmployeeModules.Purchase                    := Flag;
      Training.TrainingEmployeeModules.CRM                         := Flag;
      Training.TrainingEmployeeModules.Marketing                   := Flag;
      Training.TrainingEmployeeModules.Sales                       := Flag;
      Training.TrainingEmployeeModules.Pos                         := Flag;
      Training.TrainingEmployeeModules.CustomerPayments            := Flag;
      Training.TrainingEmployeeModules.SupplierPayments            := Flag;
      Training.TrainingEmployeeModules.Banking                     := Flag;
      Training.TrainingEmployeeModules.Reports                     := Flag;
      Training.TrainingEmployeeModules.General_Templates           := Flag;
      Training.TrainingEmployeeModules.Utilities                   := Flag;
      Training.TrainingEmployeeModules.Inventory_Advanced          := Flag;
      Training.TrainingEmployeeModules.Manufacturing               := Flag;
      Training.TrainingEmployeeModules.Appointments                := Flag;
      Training.TrainingEmployeeModules.Payroll                     := Flag;
      Training.TrainingEmployeeModules.FixedAssets                 := Flag;
      Training.TrainingEmployeeModules.Workshop                    := Flag;
      Training.TrainingEmployeeModules.budgets                     := Flag;
      Training.TrainingEmployeeModules.Delivery                    := Flag;
      Training.TrainingEmployeeModules.Matrix                      := Flag;
      Training.TrainingEmployeeModules.How_To                      := Flag;
      Training.TrainingEmployeeModules.Hire                        := Flag;
      Training.TrainingEmployeeModules.postdb;
end;


procedure TfmTrainingAssignment.AddEmployeeforTraining(
  newEmployeeID: Integer);
begin
  if not Training.TrainingEmployeeModules.Dataset.Locate('EmployeeID' , NewEmployeeId , []) then begin
    Training.TrainingEmployeeModules.NEw;
    Training.TrainingEmployeeModules.EmployeeId := newEmployeeID;
    Training.TrainingEmployeeModules.EmployeeName := tcDataUtils.getemployeeName(newEmployeeID);
    Training.TrainingEmployeeModules.BasicFeatures:=True;
    Training.TrainingEmployeeModules.PostDB;
    if not Training.TrainingEmployeeModules.Save then
      raise Exception.Create('Error Creating Employee Training: ' + Training.TrainingEmployeeModules.ResultStatus.Messages);
  end;
end;



procedure TfmTrainingAssignment.txtStarttimeDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , TDBComboBox(Sender).Text );
end;

procedure TfmTrainingAssignment.cboDayStartCloseUp(Sender: TObject);
begin
  inherited;
  if ValidStrToTime(cboDayend.text) < ValidStrToTime(cboDayStart.text) then begin
    MessageDlgXP_Vista('Day Start must be a time before Day End',mtInformation,[mbOk],0);
    Training.DoDelayObjectProcedure(ResetcboDayStart,10, Self.classname +'.ResetcboDayStart');
  end
  else begin
    Training.StartOfTheDay :=ValidStrToTime(cboDayStart.text);
    Training.TrainingDay.PostDB;
    refreshDaysforTraining;
  end;
end;

procedure TfmTrainingAssignment.cboDayStartDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , TComboBox(Sender).Text );
end;

procedure TfmTrainingAssignment.cboTrainingCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
  doChange: boolean;
begin
  inherited;
  doChange := true;
  if NeedsSaving then begin
    if cboTraining.Text <> Training.Description then begin
      case CommonLib.MessageDlgXP_Vista('Do you wish to save your changes?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes:
          begin
            if SaveData then begin
              self.CommitTransaction;
              Training.Dirty := false;
              self.BeginTransaction;
            end
            else begin
              doChange := false;
            end;
          end;
        mrNo:
          begin
            Training.Cancel;
            self.RollbackTransaction;
            Training.Dirty := false;
            self.BeginTransaction;
          end;
        mrCancel:
          begin
            doChange := false;
          end;
      end;
    end;
  end
  else begin

  end;
  if doChange then begin
    KeyID := qryTrainingLookup.FieldByName('TrainingID').AsInteger;
    FormShow(nil);
  end
  else begin
    if qryTrainingLookup.Locate('Description',Training.Description,[]) then
      cboTraining.Text := qryTrainingLookup.FieldByName('Description').AsString;
  end;
end;

procedure TfmTrainingAssignment.chkIgnoreTrainingAtStartupClick(
  Sender: TObject);
begin
  inherited;
  if not chkIgnoreTrainingAtStartup.Focused then exit;
  AppEnv.CompanyPrefs.IgnoreTraining := chkIgnoreTrainingAtStartup.Checked;
end;

procedure TfmTrainingAssignment.cboDayEndCloseUp(Sender: TObject);
begin
  inherited;
  //appenv.CompanyPrefs.endOfDay := ValidStrToTime(cboDayend.text);
  if ValidStrToTime(cboDayend.text) < ValidStrToTime(cboDayStart.text) then begin
    MessageDlgXP_Vista('Day End must be a time after Day Start',mtInformation,[mbOk],0);
    Training.DoDelayObjectProcedure(ResetcboDayEnd,10, Self.classname +'.ResetcboDayEnd');
  end
  else begin
    Training.EndOftheDay:=ValidStrToTime(cboDayend.text);
    Training.PostDB;
    refreshDaysforTraining;
  end;
end;

procedure TfmTrainingAssignment.cboDayEndDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , TComboBox(Sender).Text );
end;

procedure TfmTrainingAssignment.mnuautoSelectDaysClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  TRaining.AutoSelectDays(TrainingCalender.date);
  for ctr := low(TRaining.AutoSelectDates) to high(TRaining.AutoSelectDates) do begin
      TrainingCalender.EndDate:=TRaining.AutoSelectDates[ctr];
      TrainingCalender.Date :=TRaining.AutoSelectDates[ctr];
      TrainingCalenderDblClick(TrainingCalender);
  end;
end;

procedure TfmTrainingAssignment.QryTrainingDaysAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  closeDB(qryDaysforTraining);
  openDB(qryDaysforTraining);
  QryTrainingDaysTrainingDate.displayFormat := FormatSettings.ShortDateformat+ '  dddd';
end;

procedure TfmTrainingAssignment.MnuCalendarPopup(Sender: TObject);
begin
  inherited;
  mnuautoSelectDays.Caption := 'Auto Select '+
                                Training.Daysplan +  '(' +DayToDayName(day1) +',' +DayToDayName(day2) +',' +DayToDayName(day3)+ ',' +DayToDayName(day4) +',' +DayToDayName(day5) + ')' +
                                ' from ' +formatdatetime(FormatSettings.ShortDateformat , TrainingCalender.Date);
end;

procedure TfmTrainingAssignment.qryTrainingDayAfterPost(DataSet: TDataSet);
begin
  inherited;
  refreshDaysforTraining;
end;
Procedure TfmTrainingAssignment.refreshDaysforTraining;
begin
  lblEmployee.Caption :='Select Days For Training (Minimum '+IntToStr(Training.DaysRequiredForTraining)+' Days '+(*'- ' +FloatToStr(Training.TotalHours) +' Hrs'+*)')';
end;
procedure TfmTrainingAssignment.grdTrainingScheduleIButtonClick(
  Sender: TObject);
begin
  inherited;
   DeleteTRainingDay;
end;

initialization
  RegisterClassOnce(TfmTrainingAssignment);

end.

