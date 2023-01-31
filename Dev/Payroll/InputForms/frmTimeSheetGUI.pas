unit frmTimeSheetGUI;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/02/06  1.00.01 DSP  Adjusted button's size and their font size and changed
                        the button's anchor to just akBottom being true.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, ExtCtrls,
  DNMPanel, ActnList, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton,
  wwdblook, wwdbdatetimepicker, DBAccess, MyAccess,ERPdbComponents, MemDS, kbmMemTable,
  DataState, ImgList, BusObjTimeSheet, Menus, AdvMenus, Shader, Mask,
  CommonLib,wwdbedit, busobjbase, CustomerJobRepairSelection, ERPDbLookupCombo,
  ProgressDialog;

const
  MSG_PerformCalculations = WM_USER + 100;
  MSG_GrdFieldFocus       = WM_USER + 101;

type
  TfrmTimeSheet = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    grdTimesheets: TwwDBGrid;
    ActionList1: TActionList;
    actSave: TAction;
    qryTimesheets: TERPQuery;
    DSTimesheet: TDataSource;
    DSJobs: TDataSource;
    DSEmployee: TDataSource;
    qryEmployee: TERPQuery;
    dtServiceDate: TwwDBDateTimePicker;
    cboName: TwwDBLookupCombo;
    cboJobs: TERPDBLookupCombo;
    qryTimesheetsTotal: TFloatField;
    qryTimesheetsJob: TWideStringField;
    qryTimesheetsEmployeeName: TWideStringField;
    qryTimesheetsLabourCost: TFloatField;
    cboClass: TwwDBLookupCombo;
    qryClasses: TERPQuery;
    dsClasses: TDataSource;
    qryTimesheetsClassName: TWideStringField;
    qryTimesheetsID: TAutoIncField;
    qryTimesheetsJobID: TIntegerField;
    qryTimesheetsEmployeeID: TIntegerField;
    qryTimesheetsClassID: TIntegerField;
    qryTimesheetsRosterID: TIntegerField;
    actDelRecord: TAction;
    grdTimesheetsIButton: TwwIButton;
    qryTimesheetsGlobalRef: TWideStringField;
    qryTimesheetsHours: TFloatField;
    btnServices: TDNMSpeedButton;
    qryTimesheetsServiceID: TIntegerField;
    qryTimesheetsServiceName: TWideStringField;
    qryTimesheetsChargeRate: TFloatField;
    cboServices: TwwDBLookupCombo;
    DSServices: TDataSource;
    qryServices: TERPQuery;
    qryServicesID: TAutoIncField;
    qryServicesServiceName: TWideStringField;
    qryServicesEmployeeID: TIntegerField;
    qryServicesRate: TFloatField;
    qryTimesheetsPartID: TIntegerField;
    qryTimesheetsPartName: TWideStringField;
    qryServicesPartID: TIntegerField;
    qryServicesPartName: TWideStringField;
    qryPayRates: TERPQuery;
    qryTimesheetsPayRateTypeName: TWideStringField;
    qryTimesheetsPayRateTypeID: TIntegerField;
    cboRateType: TwwDBLookupCombo;
    qryTimesheetsHourlyRate: TFloatField;
    qryTimesheetsSuperInc: TWideStringField;
    qryTimesheetsSuperAmount: TFloatField;
    qryJobs: TERPQuery;
    qryTimesheetsActive: TWideStringField;
    qryTimesheetsUseTimeCost: TWideStringField;
    qryTimesheetsSalesID: TIntegerField;
    imgPopup: TImageList;
    qryTimesheetsServiceDate: TDateField;
    qryTimesheetsQty: TFloatField;
    qryTimesheetsTax: TFloatField;
    qryTimesheetsPartsDescription: TWideStringField;
    qryTimesheetsSaleLineID: TIntegerField;
    qryMaster: TERPQuery;
    DSMaster: TDataSource;
    qryTimesheetsTimesheetEntryID: TIntegerField;
    qryTimesheetsAllowEdit: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkDontShowMsgs: TCheckBox;
    Label1: TLabel;
    qryTimesheetstimesheetDate: TDateTimeField;
    qryMasterGlobalRef: TWideStringField;
    qryMasterTimesheetEntryID: TIntegerField;
    qryMasterEntryDate: TDateTimeField;
    qryMasterType: TWideStringField;
    qryMasterTypeID: TIntegerField;
    qryMasterWhoEntered: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    pnlfooter: TDNMPanel;
    pnlHeader: TDNMPanel;
    edtType: TwwDBEdit;
    lblType: TLabel;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    btnAccept: TDNMSpeedButton;
    qryrepairequip: TERPQuery;
    qryrepairequipCustomerEquipmentID: TIntegerField;
    qryrepairequipEquipmentName: TWideStringField;
    qryrepairequipRepairID: TIntegerField;
    cboEquipmentname: TwwDBLookupCombo;
    qryTimesheetscustomerEquipmentID: TIntegerField;
    qryrepairequipSerialno: TWideStringField;
    qryrepairequipManufacture: TWideStringField;
    qryrepairequipmodel: TWideStringField;
    qryrepairequipRegistration: TWideStringField;
    qryrepairequipWarantyPeriod: TFloatField;
    qryrepairequipWarantyFinishDate: TDateTimeField;
    qryTimesheetsRepairID: TIntegerField;
    qryTimesheetsEquipment: TWideStringField;
    qryTimesheetsTotalServicecharge: TFloatField;
    qryrepairequipQuantity: TFloatField;
    qryrepairequipClientID: TIntegerField;
    btnLoadRoster: TDNMSpeedButton;
    qryrepairequipRepairNo: TWideStringField;
    qryRepairLookup: TERPQuery;
    qryRepairLookupRepairDocNo: TWideStringField;
    qryRepairLookupCustomerName: TWideStringField;
    qryRepairLookupRepairID: TIntegerField;
    qryTimesheetsRepairDocNo: TStringField;
    cboRepairDocNo: TwwDBLookupCombo;
    qryTimesheetsNotes: TWideMemoField;
    qryTimesheetsInvoiceNotes: TWideMemoField;
    btnAllocatetoRepair: TDNMSpeedButton;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    qryTimesheetsArea: TWideStringField;
    lblTmrMsg: TLabel;
    qryTimesheetsOverheadRate: TFloatField;
    qryEmployeeEmployeeID: TIntegerField;
    qryEmployeeEmployeeName: TWideStringField;
    qryEmployeeOverheadRate: TFloatField;
    qryTimesheetsTotalAdjusted: TFloatField;
    qryTimesheetsApproved: TWideStringField;
    qryTimesheetsDone: TWideStringField;
    qryTimesheetsDoneStatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSaveExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cboNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboJobsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actSaveUpdate(Sender: TObject);
    procedure qryTimesheetsAfterOpen(DataSet: TDataSet);
    procedure dtServiceDateExit(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actDelRecordExecute(Sender: TObject);
    procedure grdTimesheetsRowChanged(Sender: TObject);
    procedure grdTimesheetsColExit(Sender: TObject);
    procedure btnServicesClick(Sender: TObject);
    procedure cboServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboServicesNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure grdTimesheetsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure cboJobsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboRateTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdTimesheetsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont;
      ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure cboJobsExit(Sender: TObject);
    procedure qryJobsAfterOpen(DataSet: TDataSet);
    procedure qryTimesheetsDateChange(Sender: TField);
    procedure btnAcceptClick(Sender: TObject);
    procedure grdTimesheetsCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cboEquipmentnameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdTimesheetsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdTimesheetsUpdateFooter(Sender: TObject);
    procedure grdTimesheetsColEnter(Sender: TObject);
    procedure grdTimesheetsEnter(Sender: TObject);
    procedure cboEquipmentnameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboEquipmentnameDblClick(Sender: TObject);
    procedure btnLoadRosterClick(Sender: TObject);
    procedure cboServicesDropDown(Sender: TObject);
    procedure cboRepairDocNoCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboEquipmentnameBeforeDropDown(Sender: TObject);
    procedure cboRepairDocNoExit(Sender: TObject);
    procedure grdTimesheetsDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAllocatetoRepairClick(Sender: TObject);

  private
    { Private declarations }
    //dtLastDate: TDateTime;
    fbClosingDown: boolean;
    fbDontAcceptServiceCloseUp: boolean;
    fiReadOnly: boolean;
    fbCustomerJobState: boolean;
    IsAccepted: boolean;
    fTimeSheetEntry :TTimesheetEntry;
    fiTimeSheetEntryTransID: Integer;
    fsTimesheetEntryType: String;
//    CustomerJobRepairObj: TCustomerJobRepairObj;
    fbHideCustomerJob: Boolean;
    fPassedConnection:TERPConnection;
    fbchangingServices:Boolean;
    RosterList :TObject;
    procedure SetReadonly(AEnable: Boolean);
    function GetEmployeeHourlyRate(EmployeeID: integer):double;
//     function GetEmployeeNormalHourlyRate(EmployeeID: integer):double;
//    function CheckLastDate(const TestDate: TDateTime; const EmployeeID: integer): TDateTime;
    procedure SetGrdFieldFocus(var Message: TMessage); message MSG_GrdFieldFocus;

    procedure setTimeSheetEntry(const Value: TTimesheetEntry);
    procedure NewTimeSheetEntry;
    Procedure SetGridColumns;
//    Procedure InitCustJobRepairSelection;
    Procedure showFootervalue;
    Procedure Loadroster(Const ds:TDataset);
    Function GridDataset:TERPQuery;
    Function Formcolor:Tcolor;
    function SaveTimesheet: Boolean;
  Protected
  public
    { Public declarations }
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    property ReadOnlyMode           : boolean read fiReadOnly              write fiReadOnly;
    Property TimesheetEntryType     : String  read fsTimesheetEntryType    Write fsTimesheetEntryType ;
    Property TimeSheetEntryTransID  : Integer REad fiTimeSheetEntryTransID Write fiTimeSheetEntryTransID;
    Property TimeSheetEntry         : TTimesheetEntry Read fTimeSheetEntry Write setTimeSheetEntry;
    Property HideCustomerJob        : Boolean   REad fbHideCustomerJob write fbHideCustomerJob;
    property PassedConnection       :TERPConnection read fPassedConnection write fPassedConnection;
    class function  createtimesheet(AOwner:TComponent; fTimesheetEntry:TTimesheetEntry;
                                    fTimesheetEntryType:String; fTimeSheetEntryTransID:Integer;
                                    readonly :Boolean = False ; readonlymsg:String = ''):TfrmTimeSheet;
    Class Procedure CreateTimeSheetforRosters(Sender:TObject);
  end;

implementation

uses
  CommonDbLib, FormFactory, DNMLib, DNMExceptions,
  frmPayrollServices,
  PayCommon, frmInvoice,
  //PayObj, PayFunctionObj,
  //PayPayRatesObj,
   AppEnvironment,
  FastFuncs,BusObjPaybase,tcTypes, BusObjConst, frmRepairs, tcDataUtils,
  tcConst, RosterListForTimeSheet, FrmShowImage, MemoDialog, RosterBreakList;

{$R *.dfm}

procedure TfrmTimeSheet.FormCreate(Sender: TObject);
begin
//  InitCustJobRepairSelection;
  fbchangingServices := False;
  fbHideCustomerJob := False;
  RosterList :=nil;

  AllowCustomiseGrid:= True;//not(Self.classnameis('TfmWorkOrdertimeSheet'));
  inherited;
  UserLock.Enabled := True;
  fbTabSettingEnabled:= true;

  fbDontAcceptServiceCloseUp := false;
  //dtLastDate := Now;
  fbClosingDown := false;
  fbCustomerJobState := true;
  ReadOnlyMode := False;
  if Self.CallingClassName = 'TJobAnalysisReportGUI' then begin
    ReadOnlyMode := true;
  end;

  if Self.CallingClassName = 'TfrmEmployeePay' then begin
    Self.MyConnection := PassedConnection;
  end;
  fiTimeSheetEntryTransID:=0;
  fsTimesheetEntryType:='Payroll';
  fTimeSheetEntry:= nil;
  edtType.Visible := Devmode;
  lblType.Visible := Devmode;


end;

procedure TfrmTimeSheet.SetReadOnly(AEnable: Boolean);
begin
  cboClass.ReadOnly           := AEnable;
  cboName.ReadOnly            := AEnable;
  DTServiceDate.ReadOnly      := AEnable;
  cboJobs.ReadOnly            := AEnable;
  cboServices.ReadOnly        := AEnable;
  grdTimesheets.ReadOnly      := AEnable;
  btnServices.Enabled         := not AEnable;
  btnAccept.Enabled           := not AEnable;
  btnAllocatetoRepair.Enabled := not AEnable;
  //qryTimeSheets.Readonly      := AEnable;
end;

procedure TfrmTimeSheet.FormShow(Sender: TObject);
var
  frmInv: TComponent;
  QueryNamesNotToOpen: array of string;
begin
  GuiPrefs.AddreadonlyField('RepairID' , (*qryTimesheets*)GridDataset);
  //GuiPrefs.AddFieldPair('LineCost', 'LineCostInc', tblDetails);
  GuiPrefs.Active := True;

  DisableForm;
  try
    try
      closedb(grdTimesheets.datasource.dataset); // for personal tab
      inherited;

      if not Assigned(ftimesheetEntry) then begin
        ftimesheetEntry             := TTimeSheetEntry.Create(nil);
        fTimeSheetEntry.Connection  := TMyDacDataConnection.Create(fTimeSheetEntry);
        fTimeSheetEntry.Connection.connection := Self.MyConnection;
        fTimeSheetEntry.BusObjEvent :=DoBusinessObjectEvent;
      end;
      qryServices.ParamByName('xEmpID').asInteger := 0;
      qryServices.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryPayRates.Connection := CommonDbLib.GetSharedMyDacConnection;

      ///////////////////////////////////////////////////////
      // If we are to process this as read only mode
      // then it is because it was drilled by a list
      // and therefore we need to see everything in the list.
      // To do this, we will need to remove the WHERE clause
      // from the SQL statement.
      ///////////////////////////////////////////////////////

      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'qrymaster';
      QueryNamesNotToOpen[1] := 'qryTimesheets';
      OpenQueries(QueryNamesNotToOpen);

      timesheetEntry.Load(KeyID);

      if (KeyID <> 0) and (timesheetEntry.TypeName = 'Repair') and (TimesheetEntryType <> timesheetEntry.TypeName ) then begin
            AccessLevel := 5;// read only
            Timesheetentry.accessmanager.accesslevel := 5;// read only
            CommonLib.MessageDlgXP_Vista('This is a repair timesheet and can be only edited within the repairs record.'+NL+NL +
                                          'Access will be changed to read-only.', mtWarning, [mbOK], 0);
            SetReadOnly(True);
      end else begin
          // Put our Database Connection into transaction mode.
          BeginTransaction;
          Timesheetentry.Timesheet.EditDB;
      end;

      NewTimeSheetEntry;


      if Self.CallingClassName = 'TJobAnalysisReportGUI' then begin
        if Timesheetentry.Timesheet.UseTimeCost then begin
          if CommonLib.MessageDlgXP_Vista('This timesheet entry has been used against an invoice and this record cannot be changed!'#13#10#13#10 +
            'would you like to see this invoice now?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
            frmInv:=  GetComponentByClassName('TInvoiceGUI');
            if assigned(frmInv) then begin
                TInvoiceGUI(frmInv).KeyID := Timesheetentry.Timesheet.SalesID;
                TInvoiceGUI(frmInv).FormStyle := fsMDIChild;
                TInvoiceGUI(frmInv).BringToFront;
            end;
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
          end;
        end else if not Timesheetentry.Timesheet.Active then begin
          CommonLib.MessageDlgXP_Vista('This timesheet entry has been loaded into ' +
            Timesheetentry.Timesheet.EmployeeName + ' payroll sheet!' + #13#10#13#10 +
            'This record cannot be further changed!', mtWarning, [mbOK], 0);
        end else begin
          SetReadOnly(True);
        end;
      end;


      //////////////////////////////////////////////
      // Load in our last date used if the timesheet
      // has 1 or more records.
      //////////////////////////////////////////////
      if Timesheetentry.Timesheet.Count > 0 then begin
        Timesheetentry.Timesheet.dataset.Last;
       // dtLastDate := CheckLastDate(qryTimesheets.FieldByName('TimesheetDate').AsDateTime,
  //        qryTimesheets.FieldByName('EmployeeID').AsInteger);
        //dtLastDate := qryTimesheets.FieldByName('TimesheetDate').AsDateTime;
        Timesheetentry.Timesheet.dataset.First;
      end;



     SetGridcolumns;

     if assigned(fTimesheetEntry) then TimesheetEntry.CalcTimesheetTotal;   
        showFootervalue;

     if Assigned(RosterList) and (RosterList is TRosterBreakListGUI) then begin
      TRosterBreakListGUI(RosterList).Loadroster := Loadroster;
      try
        TRosterBreakListGUI(RosterList).CreateTimeSheetforRosters;
      finally
        TRosterBreakListGUI(RosterList).Loadroster := nil;
      end;
        //Loadroster(TRosterBreakListGUI(RosterList).Qrymain);
        RosterList := nil;
     end;

     SetControlFocus(grdTimesheets);
      // Exception Handler


    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmTimeSheet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fbClosingDown := true;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;
 
end;

procedure TfrmTimeSheet.actSaveExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      // Ensure our connection is in transaction mode.
      fbClosingDown := true;
      if accesslevel = 5 then begin
        timesheetentry.CancelDB;
        timesheetentry.timesheet.CancelDB;
        timesheetentry.connection.RollbackTransaction;
      end else begin
        if not SaveTimeSheet then exit;
        timesheetentry.connection.CommitTransaction;
      end;
    except
      // Failed! Rollback Transaction and Cancel
      RollbackTransaction;
    end;

    // We are now done, close down the form.
    if Sender <> btnAccept then begin
      if Self.FormState = [fsModal] then begin
        Self.ModalResult := mrOk;
      end else begin
        Close;
      end;
    end;
  finally
    EnableForm;
  end;
end;
function TfrmTimeSheet.SaveTimesheet:Boolean;
begin
      result:= False;
      // Verify these entries to ensure they are valid.
      fTimeSheetEntry.timeSheet.first;
      if not fTimeSheetEntry.ValidateData then begin
        fbClosingDown := false;
        IsAccepted := false;
        Exit;
      end;
      timesheetentry.PostDB;
      timesheetentry.timesheet.postdb;
      REsult:= True;
end;
procedure TfrmTimeSheet.btnCloseClick(Sender: TObject);
begin
  inherited;
  // Close the form.
  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;

procedure TfrmTimeSheet.btnLoadRosterClick(Sender: TObject);
var
  form:TComponent;
begin
  inherited;
  form := GetComponentByClassName('TRosterListForTimeSheetGUI');
  if not assigned(Form) then exit;
  TRosterListForTimeSheetGUI(Form).LoadRoster:= LoadRoster;
  Closedb(TRosterListForTimeSheetGUI(Form).Qrymain);
  // to reflect the selection
  TRosterListForTimeSheetGUI(Form).Qrymain.connection := TERPconnection(timesheetentry.timesheet.connection.connection);
  TRosterListForTimeSheetGUI(Form).showmodal;
end;

procedure TfrmTimeSheet.cboNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified = false then Exit;

    FillTable.Edit;
    FillTable.FieldByName('HourlyRate').AsFloat := GetEmployeeHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger);
    FillTable.FieldByName('PayRateTypeID').AsInteger := PayCommon.GetPayRateID(FillTable.FieldByName('PayRateTypeName').AsString);
    FillTable.FieldByName('OverheadRate').Value := qryEmployeeOverheadRate.Value; // @@@
    if FillTable.FieldByName('PayRateTypeID').AsInteger = 0 then begin
      FillTable.FieldByName('LabourCost').AsFloat := GetEmployeeHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger);
    end else begin
      FillTable.FieldByName('LabourCost').AsFloat := GetEmployeeHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger) *
        qryPayRates.FieldByName('Multiplier').AsFloat;
      FillTable.FieldByName('Total').AsFloat := GetEmployeeHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger) *
        FillTable.FieldByName('Hours').AsFloat;
    end;

  if cboClass.Text = '' then begin
    FillTable.FieldByName('ClassName').AsString := AppEnv.DefaultClass.DefaultClassName;
    FillTable.FieldByName('ClassID').AsInteger  := AppEnv.DefaultClass.ClassID;
  end else begin
    FillTable.FieldByName('ClassName').AsString := cboClass.Text;
    FillTable.FieldByName('ClassID').AsInteger  := GetDeptID(cboClass.Text);
  end;

  // Now initialise our Services Query.
  qryServices.Close;
  qryServices.ParamByName('xEmpID').AsInteger := GetEmployeeID(cboName.Text);
  qryServices.Open;
end;

procedure TfrmTimeSheet.cboJobsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not modified then Exit;
//  CustomerJobRepairObj.JobCustomerSetUpCloseUp(sender, LookupTable, FillTable, Modified );
end;

procedure TfrmTimeSheet.actSaveUpdate(Sender: TObject);
begin
  inherited;
  // If we have no time sheet records then
  // do not allow transaction
  if Timesheetentry.Timesheet.dataset.Active then begin
    if (Self.CallingClassName <> 'TJobAnalysisReportGUI') and ((Timesheetentry.Timesheet.Count < 1) or
      (ReadOnlyMode){ or (not HasPayrollAccess)}) then begin
      btnSave.Enabled := false;
      btnAccept.Enabled := false;
    end else begin
      btnSave.Enabled := true;
      //btnAccept.Enabled := true;
    end;
  end;
end;

procedure TfrmTimeSheet.qryTimesheetsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // We do this so we dont get locking errors.
  // Do not need to move it to TTimeSheet object {AL}
end;

procedure TfrmTimeSheet.dtServiceDateExit(Sender: TObject);
begin
  inherited;
  try
    // Get our Last Selected Date.
   // dtLastDate := CheckLastDate(DTServiceDate.DateTime, qryEmployee.FieldByName('EmployeeID').AsInteger);
    //dtLastDate := DTServiceDate.DateTime;
  except
  end;
end;

procedure TfrmTimeSheet.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if Modified = false then Exit;
  inherited;
  FillTable.Edit;
  FillTable.FieldByName('ClassID').AsInteger := GetDeptID(cboClass.Text);
end;

procedure TfrmTimeSheet.actDelRecordExecute(Sender: TObject);
begin
  inherited;
  fbClosingDown := true;
  Timesheetentry.Timesheet.Delete;
  Timesheetentry.Timesheet.EditDB;
  fbClosingDown := false;
end;

procedure TfrmTimeSheet.grdTimesheetsRowChanged(Sender: TObject);
var
  sServiceField: string;
begin
  inherited;
  SetReadOnly(Timesheetentry.Timesheet.Approved);
  if fbchangingServices  then exit;
  if fbClosingDown then Exit;
//  CustomerJobRepairObj.rowchanged;
  // Get the contents of the ServiceName field before refreshing query
  sServiceField := Timesheetentry.Timesheet.ServiceName;

  if qryServices.ParamByName('xEmpID').AsInteger <> GetEmployeeID(cboName.Text) then begin
    qryServices.Close;
    qryServices.ParamByName('xEmpID').AsInteger := GetEmployeeID(cboName.Text);
    qryServices.Open;
  end;
  // Restore the Service Name
    if cboServices.Text <> sServiceField then cboServices.Text := sServiceField;
    showFooterValue;
end;

procedure TfrmTimeSheet.grdTimesheetsColExit(Sender: TObject);
begin
  inherited;
  if fbClosingDown then Exit;
end;

procedure TfrmTimeSheet.grdTimesheetsDblClick(Sender: TObject);
begin
  inherited;
  if Sametext(TField(grdTimesheets.GetActiveField).fieldname , 'SignatureMemo') then begin
    if TField(grdTimesheets.GetActiveField).Value <> null then
      ShowImage(Self, Formcolor , grdTimesheets.DataSource, 'Signature' ,
                TimesheetEntryType +' # ' + inttostr(TimeSheetEntryTransID), 'Signature' , timesheetEntry.TimeSheet.ServideDescription ,
                'Signed : ' + formatDatetime(FormatSettings.shortDateFormat +' ' +FormatSettings.shorttimeFormat , timesheetEntry.TimeSheet.SignatureTime) )
    else MessageDlgXP_Vista('Signture is not provided.', mtWarning, [mbOK], 0);
  end else if Sametext(TField(grdTimesheets.GetActiveField).fieldname , qryTimesheetsInvoiceNotes.fieldname) then begin
    DoDBMemoDialog( grdTimesheets.datasource.dataset.fieldbyname('InvoiceNotes').AsString,
                    grdTimesheets.datasource.dataset.fieldbyname('InvoiceNotes').DisplayLabel,
                    grdTimesheets.datasource.dataset.fieldbyname('InvoiceNotes'));
  end else if Sametext(TField(grdTimesheets.GetActiveField).fieldname , qryTimesheetsNotes.fieldname) then begin
    DoDBMemoDialog( grdTimesheets.datasource.dataset.fieldbyname('Notes').AsString,
                    grdTimesheets.datasource.dataset.fieldbyname('Notes').DisplayLabel,
                    grdTimesheets.datasource.dataset.fieldbyname('Notes'));
  end;
end;

procedure TfrmTimeSheet.btnServicesClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent:=GetComponentByClassName('TfrmPayrollServicesGUI');
    if not assigned(tmpComponent) then exit;
    with TfrmPayrollServicesGUI(tmpComponent) do begin
      if grdTimesheets.Datasource.dataset.findfield('employeeID') <> nil then
        KeyId := grdTimesheets.Datasource.dataset.fieldbyname('employeeID').asInteger;
      Position  := poDefault;
      FormStyle := fsNormal;
      // Show Services Form.
      ShowModal;
    end;
    qryServices.Close;
    qryServices.ParamByName('xEmpID').AsInteger := GetEmployeeID(cboName.Text);
    qryServices.Open;
  finally
    EnableForm;
  end;
end;

procedure TfrmTimeSheet.cboServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if Modified = false then Exit;
  if fbchangingServices then Exit;
  fbchangingServices := True;
  try
    inherited;
    if fbDontAcceptServiceCloseUp then begin
      fbDontAcceptServiceCloseUp := false;
      Exit;
    end;
    FillTable.Edit;
    FillTable.FieldByName('ServiceID').AsInteger := LookupTable.FieldByName('ID').AsInteger;
    FillTable.FieldByName('ChargeRate').AsFloat := LookupTable.FieldByName('Rate').AsFloat;
    FillTable.FieldByName('PartID').AsInteger := LookupTable.FieldByName('PartID').AsInteger;
    FillTable.FieldByName('PartName').AsString := LookupTable.FieldByName('PartName').AsString;
    FillTable.FieldByName('ServiceName').AsString := LookupTable.FieldByName('ServiceName').AsString;
  finally
    fbchangingServices:= False;
  end;
end;

procedure TfrmTimeSheet.cboServicesDropDown(Sender: TObject);
begin
  inherited;
  timesheetentry.timesheet.Editdb;
end;

procedure TfrmTimeSheet.cboServicesNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  sTemp: string;
  iResult: integer;
  tmpComponent:TComponent;
begin
  Accept := true;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in List, Create New?', mtInformation, [mbOK, mbCancel], 0) = mrOk then begin
    sTemp := NewValue;

    tmpComponent:= GetComponentByClassName('TfrmPayrollServicesGUI');
    if assigned(tmpComponent) then begin
      TfrmPayrollServicesGUI(tmpComponent).Position := poScreenCenter;
      TfrmPayrollServicesGUI(tmpComponent).FormStyle := fsNormal;
      TfrmPayrollServicesGUI(tmpComponent).KeyID := GetEmployeeID(cboName.Text);
      TfrmPayrollServicesGUI(tmpComponent).iEmployeeID := GetEmployeeID(cboName.Text);
      TfrmPayrollServicesGUI(tmpComponent).NewServiceName := sTemp;
      iResult := TfrmPayrollServicesGUI(tmpComponent).ShowModal;

      if iResult = 2 then begin
        qryServices.Close;
        qryServices.ParamByName('xEmpID').asInteger := GetEmployeeID(cboName.Text);
        qryServices.Open;

        if qryServices.Locate('ServiceName', sTemp, [loCaseInsensitive]) then begin
          Timesheetentry.Timesheet.ServiceName := sTemp;
          Timesheetentry.Timesheet.ServiceID:= qryServices.FieldByName('ID').AsInteger;
          Timesheetentry.Timesheet.ChargeRate:= qryServices.FieldByName('Rate').AsFloat;
          Timesheetentry.Timesheet.PartID:= qryServices.FieldByName('PartID').AsInteger;
          Timesheetentry.Timesheet.PartName:= qryServices.FieldByName('PartName').AsString;
          Timesheetentry.Timesheet.PostDB;
          Timesheetentry.Timesheet.EditDB;
          cboServices.Text := sTemp;
          fbDontAcceptServiceCloseUp := true;
        end;
      end else begin
        Accept := false;
      end;
    end;
  end else begin
    Timesheetentry.Timesheet.ServiceName := '';
    Timesheetentry.Timesheet.ServiceID:= 0;
    cboServices.Text := '';
  end;
end;

procedure TfrmTimeSheet.grdTimesheetsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited;
  if not Assigned(Timesheetentry.Timesheet.dataset.FindField(AFieldName)) then
    exit;
//  if (Sysutils.SameText(AFieldName , CustomerJobRepairObj.Jobnamefield))  then begin
//    CustomerJobRepairObj.JobCustomerSetUp;
//  end else begin
    if (Timesheetentry.Timesheet.dataset.FieldByName(AFieldName).FieldKind <> fkLookup) and
      (Timesheetentry.Timesheet.dataset.FieldByName(AFieldName).FieldKind <> fkCalculated) and
      (AFieldName <> JOBNUMBER_FIELDNAME) then begin
      if FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', Timesheetentry.Timesheet.dataset.IndexFieldNames) <> 0 then begin
        Timesheetentry.Timesheet.dataset.IndexFieldNames := '[' + AFieldName + ']' + ' DESC';
      end else begin
        Timesheetentry.Timesheet.dataset.IndexFieldNames := '[' + AFieldName + ']' + ' ASC';
      end;
    end;
//  end;
end;

procedure TfrmTimeSheet.cboJobsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TfrmTimeSheet.cboRateTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if Modified = false then Exit;
  inherited;
  //qryTimesheets.FieldByName('LabourCost').AsFloat := GetEmployeeHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger);
//  If qryTimesheets.FieldByName('LabourCost').AsFloat=0.00 then Begin
//    FillTable.Edit;
//    FillTable.FieldByName('PayRateTypeID').AsInteger := qryPayRates.FieldByName('RateID').AsInteger;
//    FillTable.FieldByName('LabourCost').AsFloat := GetEmployeeNormalHourlyRate(qryEmployee.FieldByName('EmployeeID').AsInteger) * qryPayRates.FieldByName('Multiplier').AsFloat;
//    FillTable.FieldByName('Total').AsFloat := FillTable.FieldByName('LabourCost').AsFloat * FillTable.FieldByName('Hours').AsFloat;
//  end;
end;


procedure TfrmTimeSheet.cboRepairDocNoCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
//  TwwDBLookupCombo(Sender).Text:=
//    TwwDBLookupCombo(Sender).LookupTable.FieldByName(TwwDBLookupCombo(Sender).LookupField).AsString;
  EditDB((*qryTimesheets*)GridDataset);
  self.(*qryTimesheets*)GridDataset.Fieldbyname('RepairID').AsInteger:= qryRepairLookupRepairID.AsInteger;
  PostDB((*qryTimesheets*)GridDataset);
  EditDB((*qryTimesheets*)GridDataset);


end;

procedure TfrmTimeSheet.cboRepairDocNoExit(Sender: TObject);
begin
  if cboRepairDocNo.Text = '' then begin
    EditDB((*qryTimesheets*)GridDataset);
    self.(*qryTimesheets*)GridDataset.fieldbyname('RepairID').AsInteger:= 0;
    PostDB((*qryTimesheets*)GridDataset);
    EditDB((*qryTimesheets*)GridDataset);
  end;
  inherited;
end;

// function TfrmTimeSheet.GetEmployeeNormalHourlyRate(EmployeeID: integer):double;
// var
//   qry: TERPQuery;
//   qryRate: TERPQuery;
//   PayRatesObj :TPayRatesObj;
// begin
//   qry := TERPQuery.Create(Self);
//   qryRate := TERPQuery.Create(Self);
//   PayRatesObj :=  TPayRatesObj.Create(nil);
//   try
//     qry.Options.FlatBuffers := True;
//     qryRate.Options.FlatBuffers := True;
//     qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//     qryRate.Connection := CommonDbLib.GetSharedMyDacConnection;
// 
//     with qryRate do begin
//       SQL.Clear;
//       SQL.Add('SELECT Description,RateID FROM tblpayrates WHERE Description = "Normal Hours";' );
//       Open;
//     end;
// 
//     with qry do begin
//       SQL.Clear;
//       SQL.Add('SELECT * FROM tblemployeepayrates WHERE EmployeeID = '+IntToStr(EmployeeID));
//       Open;
//     end;
// 
//     PayRatesObj.DataSet := qry;
//     PayRatesObj.ReCalc;
// 
//     Result := PayRatesObj.HourlyRate;
//   finally
//     FreeAndNil(qry);
//     FreeAndNil(qryRate);
//   end;
// end;


function TfrmTimeSheet.GetEmployeeHourlyRate(EmployeeID: integer):double;
begin
  Result := TimeSheetEntry.Timesheet.EmployeePayRateForNormalHours;
end;

procedure TfrmTimeSheet.cboJobsExit(Sender: TObject);
begin
  inherited;
  if Empty(cboJobs.Text) then begin
    Timesheetentry.Timesheet.JobID:= 0;
    Timesheetentry.Timesheet.Job:= '';
  end;
end;

procedure TfrmTimeSheet.qryJobsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryJobs.IndexFieldNames := QuotedStr('Company') + ' ASC CIS';
end;


//function TfrmTimeSheet.CheckLastDate(const TestDate: TDateTime; const EmployeeID: integer): TDateTime;
//var
//  LastPayDate: TDateTime;
//begin
//  Result := TestDate;
//  if (EmployeeID <> 0) then begin
//    LastPayDate := GetLastPayDate(EmployeeID) + 1;
//    if TestDate < LastPayDate then Result := LastPayDate;
//  end;
//end;

procedure TfrmTimeSheet.qryTimesheetsDateChange(Sender: TField);
begin
  inherited;
  if Timesheetentry.Timesheet.TimesheetDate < GetLastPayDate(qryEmployee.FieldByName('EmployeeID').AsInteger) then
  begin
    if not chkDontShowMsgs.Checked then begin
      CommonLib.MessageDlgXP_Vista('You Cannot Select a Date Before The Employee''s Last Pay Date', mtWarning, [mbOK], 0);
    end;
    PostMessage(Self.Handle, MSG_GrdFieldFocus, 0, 0);
  end;
end;

procedure TfrmTimeSheet.SetGrdFieldFocus(var Message: TMessage);
begin
  grdTimesheets.SetActiveField('TimesheetDate');
end;

procedure TfrmTimeSheet.btnAcceptClick(Sender: TObject);
begin
  inherited;
  Timesheetentry.Timesheet.Approved := True;
//  IsAccepted := true;
//  actSaveExecute(Sender);
//  if IsAccepted = false then Exit;
//  // Clear this as this is now irrelevant!
//  Self.CallingClassName := '';
//  // Perform OnShow Event / Reinitialise
//  FormShow(Sender);
end;

procedure TfrmTimeSheet.grdTimesheetsCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field.FieldName <> TS_JOBNUMBER_FIELDNAME then begin
    if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', Timesheetentry.Timesheet.dataset.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 0;
    end else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', Timesheetentry.Timesheet.dataset.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 1;
    end else begin
      TitleImageAttributes.ImageIndex := -1;
    end;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TfrmTimeSheet.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  fbClosingDown := true;
end;

function TfrmTimeSheet.Formcolor: Tcolor;
var
  obj:TWincontrol;
begin
  REsult:= Self.color;
  obj := parent;
  While (obj <> nil ) do begin
    if obj is TDNMpanel and (TDNMpanel(Obj).transparent or TDNMpanel(Obj).Parentcolor) then
    else if obj is TDNMpanel  then
      REsult:= TDNMpanel(obj).color
    else if obj is TForm  then
      REsult:= TForm(obj).color;
    obj := obj.parent;
  end;
end;

procedure TfrmTimeSheet.FormDestroy(Sender: TObject);
begin
  fbClosingDown := true;
//  Freeandnil(CustomerJobRepairObj);
  Self.MyConnection := nil;
  inherited;
end;

procedure TfrmTimeSheet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (Self.Parent  is TDNMPanel)  then Begin
      Key := 0;
  end else inherited;
end;

procedure TfrmTimeSheet.btnAllocatetoRepairClick(Sender: TObject);
begin
  inherited;
  if not SaveTimesheet then exit;

  timesheetentry.connection.CommitTransaction;
  try
    if KeyID =0 then KeyID := timesheetentry.ID;
    if MessageDlgXP_Vista('All timesshet(s) linked to any repairs will be allocated to the relevant ''Repair'' record.' +NL+
                          'If timesheet has a different ''Customer/Job'' selected, it will be overwriten by the Repair''s Customer/Job.'+NL+NL+
                          'It is not possible to revert this once applied.'+NL+NL+
                          'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
    timesheetentry.connection.BeginTransaction;
    try
      timesheetentry.allocatetoRepair;
      timesheetentry.connection.CommitTransaction;
    Except
      on E:Exception do begin
         timesheetentry.connection.RollbackTransaction;
      end;
    end;
  finally
    if timesheetEntry.ID<> KeyId then begin
      timesheetEntry.closeDB;
      timesheetEntry.Load(KeyID);
      timesheetEntry.TimeSheet;
    end;
    timesheetentry.connection.BeginTransaction;
  end;
end;

procedure TfrmTimeSheet.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTimesheetEntry    then TTimesheetEntry(Sender).DataSet     := qrymaster;
        if Sender is TTimesheet         then TTimesheet(Sender).DataSet := qryTimesheets;
    end else if (EventType =BusObjEvent_Change) and (Value = BusObjEventVal_Total) then begin
        if assigned(fTimesheetEntry) then TimesheetEntry.CalcTimesheetTotal;
        showFootervalue;
    end;

end;

procedure TfrmTimeSheet.setTimeSheetEntry(const Value: TTimesheetEntry);
begin
  fTimeSheetEntry := Value;
  grdTimesheets.Datasource.dataset := value.Timesheet.Dataset;
  {to force personal tabstop}

  { CAN NOT DO THIS - Results in read-only dataset when Timesheetentry.Timesheet.EditDB called in form show }
//  fTimeSheetEntry.timesheet.closedb;
//  fTimeSheetEntry.closedb;

end;

procedure TfrmTimeSheet.NewTimeSheetEntry;
begin
  if accesslevel >2 then exit;
  if ftimesheetEntry.count = 0 then begin
    ftimesheetEntry.New;
    ftimesheetEntry.TypeName  := fsTimesheetEntryType;
    ftimesheetEntry.EntryDate := Now;
    ftimesheetEntry.WhoEntered:= AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
    ftimesheetEntry.TypeID    := fiTimeSheetEntryTransID;
    ftimesheetEntry.PostDB;
  end;
end;
procedure TfrmTimeSheet.SetGridColumns;
begin
//      if not hideCustomerjob then CustomerJobRepairObj.JobCustomerSetUp else CustomerJobRepairObj.SetUpRepair;

      if not HasPayrollAccess() then begin
        GuiPrefs.DbGridElement[grdTimeSheets].HideField('LabourCost');
        GuiPrefs.DbGridElement[grdTimeSheets].HideField('Total');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('LabourCost');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('Total');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('Hours');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('OverheadRate');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('OverheadCost');
        TimerMsg(lblTmrMsg , 'Payroll Fields (Hours and Cost) are Disabled as you don''t have Enough Rights');
      end;
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('CustomerEquipmentID');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('TimesheetentryId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('Globalref');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('ID');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('EmployeeId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('ClassId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('jobid');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('ServiceID');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('PartId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('PayrateTypeId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('SalesID');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('SaleLineId');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('AllowEdit');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('UseTimecost');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('ETADate');
      GuiPrefs.DbGridElement[grdTimeSheets].HideField('Linecost');

      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('CustomerEquipmentID');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('TimesheetentryId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('Globalref');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('ID');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('EmployeeId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('ClassId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('jobid');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('ServiceID');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('PartId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('PayrateTypeId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('SalesID');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('SaleLineId');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('AllowEdit');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('UseTimecost');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('ETADate');
      GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('Linecost');
      if hideCustomerJob then begin
//        GuiPrefs.DbGridElement[grdTimeSheets].HideField(CustomerJobRepairObj.Jobnamefield);
//        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField(CustomerJobRepairObj.Jobnamefield);
        GuiPrefs.DbGridElement[grdTimeSheets].HideField('CustomerJob');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('CustomerJob');
      end;
      if sametext(TimesheetEntryType , 'Repair') then begin
          grdTimesheets.AddField('SignatureMemo');
          guiprefs.DbGridElement[grdTimesheets].UnHideField('SignatureMemo');
          grdTimesheets.ColumnByName('SignatureMemo').DisplayLabel := 'Signature';
          grdTimesheets.ColumnByName('SignatureMemo').Displaywidth := 1;
          
          grdTimesheets.AddField('SignatureTime');
          guiprefs.DbGridElement[grdTimesheets].UnHideField('SignatureTime');
          grdTimesheets.ColumnByName('SignatureTime').DisplayLabel := 'Signed At';

          grdTimesheets.AddField('ContactName');
          guiprefs.DbGridElement[grdTimesheets].UnHideField('ContactName');
          grdTimesheets.ColumnByName('ContactName').DisplayLabel := 'Name';

          if HasPayrollAccess() then begin
            grdTimesheets.AddField('OverheadRate');
            guiprefs.DbGridElement[grdTimesheets].UnHideField('OverheadRate');
            grdTimesheets.ColumnByName('OverheadRate').DisplayLabel := 'Overhead~Rate, %';
            grdTimesheets.ColumnByName('OverheadRate').Index := 8;

            grdTimesheets.AddField('OverheadCost');
            guiprefs.DbGridElement[grdTimesheets].UnHideField('OverheadCost');
            grdTimesheets.ColumnByName('OverheadCost').DisplayLabel := 'Overhead~Cost';
            grdTimesheets.ColumnByName('OverheadCost').Index := 9;
            TFloatField(grdTimesheets.DataSource.DataSet.FieldByName('OverheadCost')).DisplayFormat := '$#######0.00';
            TFloatField(grdTimesheets.DataSource.DataSet.FieldByName('OverheadCost')).currency := True;
          end;

      end else begin
        GuiPrefs.DbGridElement[grdTimeSheets].HideField('SignatureMemo');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('SignatureMemo');

        GuiPrefs.DbGridElement[grdTimeSheets].HideField('SignatureTime');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('SignatureTime');

        GuiPrefs.DbGridElement[grdTimeSheets].HideField('ContactName');
        GuiPrefs.DbGridElement[grdTimeSheets].RemoveField('ContactName');
      end;
      grdTimesheets.AddField('TotalAdjusted');
      guiprefs.DbGridElement[grdTimesheets].UnHideField('TotalAdjusted');
      grdTimesheets.ColumnByName('TotalAdjusted').DisplayLabel := 'Total~Adjusted';
      if grdTimesheets.selected.count>10 then grdTimesheets.ColumnByName('TotalAdjusted').Index := 10 else grdTimesheets.ColumnByName('TotalAdjusted').Index := grdTimesheets.selected.count-1;
      TFloatField(grdTimesheets.DataSource.DataSet.FieldByName('TotalAdjusted')).DisplayFormat := '$#######0.00';
      TFloatField(grdTimesheets.DataSource.DataSet.FieldByName('TotalAdjusted')).currency := True;

end;

class function TfrmTimeSheet.createtimesheet(AOwner: TComponent;fTimesheetEntry:TTimesheetEntry;
                                            fTimesheetEntryType:String; fTimeSheetEntryTransID:Integer;
                                            readonly: Boolean;readonlymsg: String): TfrmTimeSheet;
var
  form: TfrmTimeSheet;

  Procedure addEquipLookup4repair;
  begin
    if AOwner is TRepairsGUI then begin
      if form.qryrepairequip.active then form.qryrepairequip.close;
//      Form.CustomerJobRepairObj.REpairID:=fTimeSheetEntryTransID;
      form.qryrepairequip.connection :=  Form.timesheetentry.connection.connection;
      form.HideCustomerJob := True;
    End;
  end;

begin
  Form := TfrmTimeSheet(GetComponentByClassName('TfrmTimeSheet' , false, AOwner, False));
  Form.tag := 99;
  Form.TimesheetEntryType    := fTimesheetEntryType;
  Form.TimeSheetEntryTransID := fTimeSheetEntryTransID;
  Form.CallingClassName      := AOwner.classname;
  Form.timesheetentry        := fTimesheetEntry;
  addEquipLookup4repair;
  if readonly then begin
     Form.AccessLevel := 5;
     form.Caption := Readonlymsg
  end;
  Result := Form;
end;

class procedure TfrmTimeSheet.CreateTimeSheetforRosters(Sender: TObject);
var
  RosterList :TRosterBreakListGUI;
  timesheetform : TfrmTimeSheet;
begin
  if not (Sender is TRosterBreakListGUI) then exit;
  RosterList := TRosterBreakListGUI(Sender);
  if not assigned(RosterList) then exit;
  if RosterList.SelectedRecords = 0 then exit;
  timesheetform := TfrmTimeSheet(getcomponentbyclassname('TfrmTimeSheet'));
  if not(Assigned(timesheetform)) then exit;
  //timesheetform.formstyle := fsMdichild;
  //timesheetform.Loadroster(RosterList.Qrymain);
  timesheetform.RosterList:= RosterList;
  timesheetform.ShowModal;
end;

procedure TfrmTimeSheet.cboEquipmentnameBeforeDropDown(Sender: TObject);
begin
  inherited;
  qryrepairequip.ParamByName('RepairID').AsInteger:= (*qryTimesheets*)GridDataset.fieldbyname('RepairID').AsInteger;
  qryrepairequip.Refresh;
end;

procedure TfrmTimeSheet.cboEquipmentnameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
//  CustomerJobRepairObj.RepairCloseUp(sender, LookupTable, FillTable, Modified );
  EditDb((*qryTimesheets*)GridDataset);
  (*qryTimesheets*)GridDataset.Fieldbyname('CustomerEquipmentID').AsInteger:= LookupTable.FieldByName('CustomerEquipmentID').AsInteger;
  (*qryTimesheets*)GridDataset.Fieldbyname('RepairID').AsInteger:= LookupTable.FieldByName('RepairID').AsInteger;
//  cboEquipmentName.Text:= LookupTable.FieldByName('EquipmentName').AsString;
  PostDb((*qryTimesheets*)GridDataset);
  EditDb((*qryTimesheets*)GridDataset);
end;
procedure TfrmTimeSheet.grdTimesheetsCalcTitleAttributes(Sender: TObject; AFieldName: string;
  AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if self.owner.classnameis(TRepairsGUI.classname) then
  else
//  if (Sysutils.SameText(AFieldName ,CustomerJobRepairObj.Jobnamefield))  then begin
  if (Sysutils.SameText(AFieldName , 'CustomerJob'))  then begin
    ABrush.Color := clBtnFace;
  end;
end;
//procedure TfrmTimeSheet.InitCustJobRepairSelection;
//begin
//  CustomerJobRepairObj:= TCustomerJobRepairObj.create;
//  CustomerJobRepairObj.grid                := grdTimesheets;
//  CustomerJobRepairObj.Jobcombo            := cboJobs;
//  CustomerJobRepairObj.JobIDField          := 'jobId';
//  CustomerJobRepairObj.JobnameField        := 'Job';
//  CustomerJobRepairObj.ClassNameField      :=  'Classname';
//  CustomerJobRepairObj.ClassIdField        :=  'ClassID';
//  CustomerJobRepairObj.curSelection        := tnone;
//  CustomerJobRepairObj.RepairCombo         := cboEquipmentname;
//  CustomerJobRepairObj.RepairIdField       :='RepairID';
//  CustomerJobRepairObj.CustomerEquipIDField:='customerEquipmentID';
//  CustomerJobRepairObj.EquipmentNameField   :=  'Equipment';
//  CustomerJobRepairObj.REpairID        :=0;
//  CustomerJobRepairObj.ClientID        :=0;
//end;
procedure TfrmTimeSheet.Loadroster(const ds: TDataset);
begin
  Timesheetentry.Timesheet.New;
  timesheetentry.timesheet.Notes              := 'From Roster';
  timesheetentry.timesheet.RosterID           := ds.fieldbyname('RosterID').asInteger;
  timesheetentry.timesheet.TimeSheetDate      := ds.Fieldbyname('date').asDatetime;
  timesheetentry.timesheet.EmployeeName       := ds.Fieldbyname('EmployeeName').asString;
  timesheetentry.timesheet.EmployeeID         := ds.Fieldbyname('EmployeeID').asInteger;
  cboNameCloseUp(cboName , cboName.lookuptable, cboName.datasource.dataset ,  True);
  if qryServices.recordcount > 0 then begin
    qryServices.first;
    timesheetentry.timesheet.ServiceName :=qryServicesServiceName.asString;
    timesheetentry.timesheet.ServiceID :=qryServicesID.asInteger;
  end;
  timesheetentry.timesheet.TimeSheetClassID   := ds.Fieldbyname('ClassId').asInteger;
  timesheetentry.timesheet.ServiceDate        := ds.Fieldbyname('date').asDatetime;
  timesheetentry.timesheet.Quantity           := ds.Fieldbyname('Hours').asFloat;
  timesheetentry.timesheet.Hours              := ds.Fieldbyname('Hours').asFloat;
  timesheetentry.timesheet.Active             := True;
  timesheetentry.PostDB;
end;
procedure TfrmTimeSheet.grdTimesheetsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryTimeSheets.FieldByName('Approved').AsString = 'T' then begin
     ABrush.Color := clBtnFace;
     exit;
  end;
  if Sysutils.SameText(Field.Fieldname , 'total') then ABrush.color := clInactiveBorder;
  if Sysutils.SameText(Field.Fieldname , 'TotalServicecharge') then ABrush.color := clInactiveBorder;
  //if Sysutils.SameText(Field.Fieldname , 'SignatureMemo') then afont.Size := 12;
end;
procedure TfrmTimeSheet.showFootervalue;
begin
  try
    if assigned(fTimesheetEntry) then begin
      grdTimesheets.Columnbyname('Hours').FooterValue := FloatToStrF(TimesheetEntry.totalHours, ffNumber, 15, 2);
      grdTimesheets.Columnbyname('Total').FooterValue := FloatToStrF(TimesheetEntry.Totalamount, ffCurrency, 15, CurrencyRoundPlaces);
      grdTimesheets.Columnbyname('qty').FooterValue := FloatToStrF(TimesheetEntry.totalQy, ffNumber, 15, 2);
      grdTimesheets.Columnbyname('TotalServicecharge').FooterValue := FloatToStrF(TimesheetEntry.totalServiceCharges, ffCurrency, 15, CurrencyRoundPlaces);
      grdTimesheets.Columnbyname('TotalAdjusted').FooterValue := FloatToStrF(TimesheetEntry.TotalAdjusted, ffCurrency, 15, CurrencyRoundPlaces);

    end;
  Except
      //kill the exception
  end;
end;
procedure TfrmTimeSheet.grdTimesheetsUpdateFooter(Sender: TObject);
begin
  inherited;
  showFootervalue;
end;

function TfrmTimeSheet.GridDataset: TERPQuery;
begin
  REsult:=   TERPQuery(grdTimesheets.datasource.dataset);
end;

procedure TfrmTimeSheet.grdTimesheetsColEnter(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(grdTimesheets.GetActiveField.FieldName , 'EmployeeName') then else
    if TimeSheetEntry.timesheet.EmployeeName = '' then
      grdTimesheets.SetActiveField('EmployeeName');
end;

procedure TfrmTimeSheet.grdTimesheetsEnter(Sender: TObject);
begin
  inherited;
    if TimeSheetEntry.timesheet.EmployeeName = '' then
      grdTimesheets.SetActiveField('EmployeeName');
end;


procedure TfrmTimeSheet.cboEquipmentnameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
//don;t delete, to skip the not inlist event from baseinput
end;

procedure TfrmTimeSheet.cboEquipmentnameDblClick(Sender: TObject);
begin
  inherited;
//don;t delete, to skip the ondblclick event from baseinput
end;



initialization
  RegisterClassOnce(TFrmTimesheet);
  FormFact.RegisterMe(TfrmTimeSheet, 'TfrmPayTimesheet_*=TimesheetEntryID');
  FormFact.RegisterMe(TfrmTimeSheet, 'TJobAnalysisReportGUI_*_JobAnalysisDetails=ID');
end.
