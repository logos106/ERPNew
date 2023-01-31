unit frmBarCodeManufacturing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Shader, StdCtrls, ExtCtrls, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, BusObjBase, BusObjEmployeeDetails, BusObjSales,
  IntegerListObj, Grids, Wwdbigrd, Wwdbgrid, DBCtrls, DNMSpeedButton, Buttons,
  datManufacturingAddin,BusObjProcessPart, wwdbdatetimepicker, ActnList, DNMAction,
  BusObjRoster, ProgressDialog , ImageDLLLib, AdvSplitter, wwcheckbox;

const
    SCHEDULE	          = 'SCHEDULE';
    QnA                 = 'Q & A';
    START	              = 'START';
    STOP                = 'STOP';
    STOPALL             = 'STOP ALL';
    LOGOFF              = 'LOG OFF';
    HISTORY             = 'HISTORY';
    COMPLETE	          = 'COMPLETE';
    UNSCHEDULE          = 'UNSCHEDULE';
    OPENSALE	          = 'OPEN SALE';
    PRODUCTTREE	        = 'OPEN TREE';
    TREECOMMENTS        = 'COMMENTS';
    PRINTPICKING        = 'PICKING';
    ALLOCATION          = 'ALLOCATION';
    PRODUCTIONWORKSHEET	= 'WORKSHEET';
    COMPLETEINVOICE	    = 'FINALIZE';//'INVOICE';
    ROSTERBREAK         = 'BREAK';
    PARTIALINVOCICE     = 'PARTIAL INVOICE';
    //PARTIALINVOCICEOLD  = 'PARTIAL INVOICE OLD';
    OPENDOCPATH         = 'OPEN DOC PATH';
type
{$WARNINGS OFF}
{$HINTS OFF}

  TProcessBarCodeProc = Procedure (PPT:TProcessPartTimesheet;  ProcessPartID:Integer) of Object;
  TfmBarCodeManufacturing = class(TBaseInputGUI)
    QryJobs: TERPQuery;
    pnlJobs: TDNMPanel;
    grdJobs: TwwDBGrid;
    dsjobs: TDataSource;
    QryJobsProductId: TIntegerField;
    QryJobsSaleLineId: TIntegerField;
    QryJobsLineProductName: TWideStringField;
    QryJobsLineProductDescription: TWideStringField;
    QryJobsLineQty: TFloatField;
    QryJobsLineShipDate: TDateTimeField;
    QryJobsProcTreeId: TIntegerField;
    QryJobsComplete: TWideStringField;
    QryJobsProcess: TWideStringField;
    QryJobsStatus: TWideStringField;
    QryJobsDuration: TFloatField;
    QryJobsSetupDuration: TFloatField;
    QryJobsBreakdownDuration: TFloatField;
    QryJobsProcessStepSeq: TIntegerField;
    QrySales: TERPQuery;
    dsSales: TDataSource;
    QryEmployee: TERPQuery;
    dsEmployee: TDataSource;
    QrySalesSaleID: TIntegerField;
    QrySalesInvoiceDocNumber: TWideStringField;
    QrySalesCustomerName: TWideStringField;
    QrySalesSaleDate: TDateField;
    QrySalesClass: TWideStringField;
    QrySalesShipDate: TDateField;
    QryEmployeeTitle: TWideStringField;
    QryEmployeeFirstName: TWideStringField;
    QryEmployeeMiddleName: TWideStringField;
    QryEmployeeLastName: TWideStringField;
    QryEmployeePhone: TWideStringField;
    QryEmployeeMobile: TWideStringField;
    QryEmployeePosition: TWideStringField;
    QryEmployeeEmployeeNo: TIntegerField;
    QryEmployeeEmployeeName: TWideStringField;
    DNMPanel1: TDNMPanel;
    pnlButtons: TDNMPanel;
    QryJobscStatus: TWideStringField;
    QryJobsID: TIntegerField;
    QryJobsInvoiceDocNumber: TWideStringField;
    QryJobscustomername: TWideStringField;
    QryJobsSaleDate: TDateField;
    QryJobsclass: TWideStringField;
    QryJobsTimestart: TDateTimeField;
    QryJobsTimeEnd: TDateTimeField;
    QryEmployeeEmployeeID: TIntegerField;
    QryJobsName: TWideStringField;
    QryJobsSaleID: TIntegerField;
    QryJobsTreeRootId: TIntegerField;
    QryJobsProcessStepId: TIntegerField;
    QryJobsProcesstimeStart: TDateTimeField;
    pnlOptions: TDNMPanel;
    lbltimesheethint: TLabel;
    btnClose: TDNMSpeedButton;
    c: TActionList;
    actEmployees: TDNMAction;
    actJobs: TDNMAction;
    actStart: TDNMAction;
    actSchedule: TDNMAction;
    actStop: TDNMAction;
    actStopAll: TDNMAction;
    actComplete: TDNMAction;
    actUnschedule: TDNMAction;
    actOpenSale: TDNMAction;
    actTree: TDNMAction;
    actPicking: TDNMAction;
    actWorksheet: TDNMAction;
    actInvoice: TDNMAction;
    actPrintcontrolcodes: TDNMAction;
    actSelectall: TDNMAction;
    actQA: TDNMAction;
    actAllocation: TDNMAction;
    QryJobsPartiallyinvoiced: TFloatField;
    QryJobsQtyToBeinvoiced: TFloatField;
    DNMPanel3: TDNMPanel;
    grdEmployees: TwwDBGrid;
    wwIButton1: TwwIButton;
    actLogOff: TDNMAction;
    DNMPanel4: TDNMPanel;
    grdSales: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    actBreak: TDNMAction;
    DNMPanel5: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Shader1: TShader;
    titleLabel: TLabel;
    Label4: TLabel;
    edtBarcodeInput: TEdit;
    actHistory: TDNMAction;
    actComments: TDNMAction;
    QryJobsinfo: TWideMemoField;
    pnlextrabuttons: TDNMPanel;
    btnControlBarCodes: TDNMSpeedButton;
    btnSelectall: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    lblMsg: TLabel;
    btnCustomise: TDNMSpeedButton;
    actPInvoice: TDNMAction;
    actPInvoiceold: TDNMAction;
    actopenDocPath: TDNMAction;
    QryJobsComment: TWideStringField;
    splComments: TAdvSplitter;
    pnlComments: TDNMPanel;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    qryMaincomment: TWideStringField;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    qryMaintimestart: TDateTimeField;
    chkHidecomments: TwwCheckBox;
    QryJobsPPTID: TLargeintField;
    QryJobspptid1: TLargeintField;
    QryJobsmanufactureduomqty: TFloatField;
    QryJobstotalqty: TFloatField;
    QryJobsisroot: TWideStringField;
    QryJobsisinternalorder: TWideStringField;
    QryJobsQtyToBeBuilt: TFloatField;
    QryJobsManufacturingUOMQty: TFloatField;
    QryJobsManufactureUOMQty: TFloatField;
    QryJobsIsSubBOM: TWideStringField;
    QryJobstobeused: TFloatField;
    QryJobscaption: TWideStringField;
    QryJobsIsJoboftheCurrentsale: TWideStringField;
    QryJobsrownum: TLargeintField;

    procedure edtBarcodeInputExit(Sender: TObject);
    procedure edtBarcodeInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QryEmployeeCalcFields(DataSet: TDataSet);
    procedure grdJobsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryJobsCalcFields(DataSet: TDataSet);
    procedure ExitSalesGridOnEnter(Sender: TObject);
    procedure SelectFirstJob(DataSet: TDataSet);
    procedure ClearSelectedJobs(DataSet: TDataSet);
    procedure grdJobsKeyPress(Sender: TObject; var Key: Char);
    procedure DoSomething(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actEmployeesExecute(Sender: TObject);
    procedure actJobsExecute(Sender: TObject);
    procedure actSelectallExecute(Sender: TObject);
    procedure actPrintcontrolcodesExecute(Sender: TObject);
    procedure actLogOffUpdate(Sender: TObject);
    procedure actBreakUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actHistoryUpdate(Sender: TObject);
    procedure actCommentsUpdate(Sender: TObject);
    procedure grdJobsDblClick(Sender: TObject);
    procedure btnSelectallClick(Sender: TObject);
    procedure lblMsgDblClick(Sender: TObject);
    procedure lblMsgClick(Sender: TObject);
    procedure btnCustomiseClick(Sender: TObject);
    procedure grdJobsColEnter(Sender: TObject);
    procedure grdJobsColExit(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure QryJobsAfterScroll(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkHidecommentsClick(Sender: TObject);
    procedure QryJobsAfterPost(DataSet: TDataSet);
  private
    ProcessingBarcode:Boolean;
    fEmployee:TEmployeeDetails;
    fSalesOrder :TSalesOrder;
    timestart :TDateTime;
    fbCanStopanyManufacturingJob:Boolean;
    sEmployeeName: string;
    fClockedRoster : TClockedRoster;


    btn_1  : TERPMainSwitchButton;
    btn_2  : TERPMainSwitchButton;
    btn_3  : TERPMainSwitchButton;
    btn_4  : TERPMainSwitchButton;
    btn_5  : TERPMainSwitchButton;
    btn_6  : TERPMainSwitchButton;
    btn_7  : TERPMainSwitchButton;
    btn_8  : TERPMainSwitchButton;
    btn_9  : TERPMainSwitchButton;
    btn_10 : TERPMainSwitchButton;
    btn_11 : TERPMainSwitchButton;
    btn_12 : TERPMainSwitchButton;
    btn_13 : TERPMainSwitchButton;
    btn_14 : TERPMainSwitchButton;
    btn_15 : TERPMainSwitchButton;
    //btn_16 : TERPMainSwitchButton;

    BtnTop_1 : TERPMainSwitchButton;
    BtnTop_2 : TERPMainSwitchButton;
    BtnTop_3 : TERPMainSwitchButton;
    BtnTop_4 : TERPMainSwitchButton;
    BtnTop_5 : TERPMainSwitchButton;
    BtnTop_6 : TERPMainSwitchButton;



    procedure ProcessBarcode(const codeStr: string);
    Procedure ProcessEmployee(EmployeeID:String);
    Procedure ProcessSales(saleID:String);
    Procedure LoadJobs;
    function Employee(EmployeeID:Integer=0) :TEmployeeDetails;
    function SalesOrder(SaleSId:Integer=0) :TSalesOrder;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure ProcessBarcodeSchedule;

    Procedure ProcessBarcodeQnA;Overload;
    procedure ProcessBarcodeQnA(PPT: TProcessPartTimesheet; ProcessPartID: Integer);Overload;

    Procedure ProcessBarcodeStart; Overload;
    Procedure ProcessBarCodeStart(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);Overload;

    Procedure ProcessBarcodeStop; Overload;
    Procedure ProcessBarcodeStop(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);Overload;

    Procedure ProcessBarcodeStopAll; Overload;
    Procedure ProcessBarcodeStopAll(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);Overload;
    Procedure ProcessBarcodeStopAllnLogoff;
    Procedure ShowHistory;


    Procedure ProcessBarcodeComplete;Overload;
    Procedure ProcessBarcodeComplete(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);Overload;
    Procedure ProcessBarcodeUNSchedule;Overload;
    Procedure ProcessBarcodeUNSchedule(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);Overload;
    Procedure RefreshQuery;
    Procedure SetUpbuttons;


    Procedure ProcessBarcodeDoOpenSale;
    Procedure ProcessBarcodePrintProductTree(const Columnno:Integer = -1);
    Procedure DoTreeComments;
    Procedure ProcessBarcodedoPrintPicking;
    Procedure ProcessBarcodePrintProductionworkSheet;
    Procedure ProcessBarcodedoPrintAllocation;
    Procedure ProcessBarcodeDoCompleteAndInvoice;
    Procedure ProcessBarcodePartialInvoice;
    Procedure ProcessBarcodePartialInvoiceOld;
    Procedure DoOpenDocPath;
    procedure CreateemployeeObj;
    procedure CreateSalesObj;
    Procedure ProcessBarcodeChangeStatus(Status: String; fProcessBarCodeStart :TProcessBarCodeProc);
    Procedure ProcessBarcodePrint(Status: String);
    Procedure DoPrintPick(IL:TIntegerList);
    Procedure DoProductionWorksheet(IL, SaleLineIDList:TIntegerList);
    Procedure DoPrintAllocation(SaleId , SaleslinesID:Integer);
    function CanStopanyManufacturingJob(Const EmployeeID:Integer):boolean;
    Procedure OnJobSelect(Sender: TwwDbGrid);
    Procedure OnEmployeeSelect(Sender: TwwDbGrid);
    procedure DoAllocation;
    Procedure doRosterBreak;
    function ClockedRoster : TClockedRoster;
    procedure ShowRosterStatus(const EventValue: string='');
    procedure Beforeshowlistform(Sender: TObject);
    procedure BeforeShowJobSelect(Sender: TObject);
    procedure AfterShowJobSelect(Sender: TObject);
    Procedure AlignButtons;
    Procedure Readguiprefs;
    Procedure Writeguiprefs;
    Procedure MakeButtons;
    procedure initSalesorderInvoice(Sender: TObject);
    procedure OnSalesOrderInvoiceCreate(Sender: TObject);

    procedure UpdateComment;
    procedure UpdateComments;
    procedure ShowAllComments;
    procedure Refreshcomments;
    function QryjobsSQL: String;
    procedure SetGridColumns;

  public
    Class Procedure  OpenForsale(const fsaleID:Integer);
(*    procedure AssignIamge(objdatamodule: TdtmManufacturingAddin);*)
  end;

implementation

uses FastFuncs, CommonLib, BusObjConst, AppEnvironment,
  ProcCapacityPlanningObj, CommonDbLib, ProcessUtils, Barcodeconst, DNMLib,
  frmProcTreeEdit,TreeFrame,ProcessDataUtils, CommonFormLib ,
  frmProcCapacityPlanningPick, frmProcCapacityPlanningWork, JobtimeSheets,
  frmEmployeeListFrm, ReportTemplates,
  BaseGUIDatamodule, GlobalEventsObj, frmBOMAllocation, tcDataUtils,
  dateutils, BusRosterBreaks, tcconst,
  RosterBreakList, frmSimpleTypes, DbSharedObjectsObj,
  frmBarCodeManufacturingCustomise,
  frmBarCodeManufacturingSalesorderInvoice, ButtonsLib, frmListnLookupLarge,
  BOMLib, docPathLib, ProcessParttimesheetList, GridLib, FrmPartialBuild,
  LogLib, BOMSalesList;

{$R *.dfm}
const
  ButtonsCount = 15;

procedure TfmBarCodeManufacturing.CreateemployeeObj;
begin
  if (not(Assigned(fEmployee))) then begin
    fEmployee:=TEmployeeDetails.Create(Self);
    fEmployee.connection := TMyDacDataConnection.create(fEmployee);
    fEmployee.connection.connection := MyConnection;
    fEmployee.BusObjEvent := DoBusinessObjectEvent;
  end;
end;
procedure TfmBarCodeManufacturing.ShowHistory;
begin
  if not Assigned(fEmployee) or  (fEmployee.ID=0) then exit;
  OpenERPListFormModal('TRosterBreakListGUI' ,nil,  Beforeshowlistform);
end;
Procedure TfmBarCodeManufacturing.Beforeshowlistform(Sender:TObject);
begin
  if Sender is TRosterBreakListGUI  then begin
    TRosterBreakListGUI(Sender).employeeId :=fEmployee.ID;
  end else if Sender is TProcessParttimesheetListGUI  then begin
    TProcessParttimesheetListGUI(Sender).ppid :=qryjobsid.asInteger;
    TProcessParttimesheetListGUI(Sender).PPTID :=qryjobspptid.asInteger;
  end;
end;
procedure TfmBarCodeManufacturing.lblMsgClick(Sender: TObject);
begin
  inherited;
  lblMsg.Visible := False;
end;

procedure TfmBarCodeManufacturing.lblMsgDblClick(Sender: TObject);
begin
  inherited;
  lblMsg.Visible := False;
end;

Procedure TfmBarCodeManufacturing.ShowRosterStatus(const EventValue: string='');
begin
      if not Appenv.companyprefs.AutoclockOnemployeeOnjob  then exit;

      if (ClockedRoster.CurrentRosterBreak.count=0) then begin
      end else if (ClockedRoster.CurrentRosterBreak.Starttime >0) and (ClockedRoster.CurrentRosterBreak.endtime =0) then begin
        TimerMsg(lblMsg, fEmployee.EmployeeName +' is on ' + ClockedRoster.CurrentRosterBreak.RosterBreaktype +' since '+ formatDateTime(shortDateformat +' hh:nn am/pm' , ClockedRoster.CurrentRosterBreak.starttime));
        Exit;
      end else if (ClockedRoster.CurrentRosterBreak.Starttime >0) and (ClockedRoster.CurrentRosterBreak.endtime >0) then begin
        if EventValue <> BusObjEventDataset_AfterOpen then TimerMsg(lblMsg,  fEmployee.EmployeeName +' finished ' + ClockedRoster.CurrentRosterBreak.RosterBreaktype );
        Exit;
      end;
      if  (ClockedRoster.count >0) and (ClockedRoster.Starttime >0) and (ClockedRoster.endtime =0) then begin
          TimerMsg(lblMsg, fEmployee.EmployeeName +' is Clocked-on since ' +  Quotedstr(formatDatetime(shortdateformat +' hh:nn am/pm' , ClockedRoster.starttime)));
      end;
end;

procedure TfmBarCodeManufacturing.UpdateComment;
var
  qry : TERPQuery;
  id : integer;
begin
  id := qryJobs.FieldByName('PPTID').asInteger;
  if id = 0 then
    id := qryJobs.FieldByName('PPTID1').asInteger;
  if id > 0 then
  begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := qryJobs.Connection;
      qry.SQL.Text := 'select * from tblProcessParttimesheet where ID = ' + IntToStr(id);
      qry.Open;
      if qry.RecordCount = 1 then begin
        if qryJobs.FieldByName('Comment').AsString <> '' then begin
          qry.Edit;
          qry.FieldByName('Comment').AsString := qryJobs.FieldByName('Comment').AsString;
          qry.Post;
        end;
      end;
    finally
      qry.Free;
    end;
  end;
end;

procedure TfmBarCodeManufacturing.UpdateComments;
var
  qry : TERPQuery;
  id : integer;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := qryJobs.Connection;
    qryJobs.First;
    while not qryJobs.eof do
    begin
      id := qryJobs.FieldByName('PPTID').asInteger;
      if id = 0 then
        id := qryJobs.FieldByName('PPTID1').asInteger;
      if id > 0 then
      begin
        qry.SQL.Text := 'select * from tblProcessParttimesheet where ID = ' + IntToStr(id);
        qry.Open;
        if qry.RecordCount = 1 then
        begin
          if qryJobs.FieldByName('Comment').AsString <> '' then begin
            qry.Edit;
            qry.FieldByName('Comment').AsString := qryJobs.FieldByName('Comment').AsString;
            qry.Post;
          end;
          qry.Close;
        end;
      end;
      qryJobs.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfmBarCodeManufacturing.Writeguiprefs;
var
  ctr:Integer;
begin
  GuiPrefs.Node['Options.pnlComments.width'].asInteger := pnlComments.width;
  GuiPrefs.Node['Options.hideComments'].asBoolean := chkHidecomments.Checked ;
  GuiPrefs.Node['Options.timestart'].asInteger := qryMaintimestart.displaywidth;
  GuiPrefs.Node['Options.comment'].asInteger := qryMaincomment.displaywidth;
  for ctr:= 0 to ComponentCount-1 do
    if components[ctr] is TERPMainSwitchButton then
      if (TERPMainSwitchButton(components[ctr]).Parent = pnlOptions) or
         (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel3) or
         (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel4) then
//      if TERPMainSwitchButton(components[ctr]).Parent = pnlOptions then
          GuiPrefs.Node['Options.' + TERPMainSwitchButton (components[ctr]).Name+'.visible'].asBoolean := TERPMainSwitchButton(components[ctr]).visible;
  fbIsLocalPrefChanged := True;
end;

procedure TfmBarCodeManufacturing.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TEmployeeDetails then TEmployeeDetails(Sender).Dataset := QryEmployee
        else if Sender is TSalesOrder then TSalesOrder(Sender).Dataset := QrySales;
  end else if (Eventtype = BusobjEvent_Event) and ((Value =BusObjEventDataset_AfterPost ) or (Value = BusObjEventDataset_AfterOpen) )  then begin
    if Sender is TCurrentRosterBreak then begin
      showrosterStatus(Value);
    end;
  end;
end;

procedure TfmBarCodeManufacturing.edtBarcodeInputExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBarcodeInputKeyPress(edtBarcodeInput, keyChar);
  end;

end;

procedure TfmBarCodeManufacturing.edtBarcodeInputKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtBarcodeInput.Modified:= true;
end;

procedure TfmBarCodeManufacturing.edtBarcodeInputKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not ProcessingBarcode then
    Try
      ProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;   // eat VK_RETURN
        ProcessBarcode(Uppercase(edtBarcodeInput.Text));
        edtBarcodeInput.Text := '';
      end;
    Finally
      ProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then
    Key := #0;

end;

function TfmBarCodeManufacturing.Employee(EmployeeID:Integer): TEmployeeDetails;
var
  dtClockTime:TDateTime;
begin
  dtClockTime := now;
  CreateEmployeeObj;
  if EmployeeID <> 0 then begin
      sEmployeeName := GetEmployeeName(EmployeeID);
        if not(fEmployee.DatasetAssigned) or ((fEmployee.id<> EmployeeID) and (EmployeeID <> 0)) or (fEmployee.Dataset.active =False) then begin
          fEmployee.Load(EmployeeID);
          if Appenv.companyprefs.AutoclockOnemployeeOnjob then begin
              if (ClockedRoster.count =0)  then begin
                  ClockedRoster.New;
                  ClockedRoster.EmployeeID := EmployeeId;
                  ClockedRoster.RosterType := 'Clocked';
                  ClockedRoster.ClassID    := AppEnv.DefaultClass.ClassID;
                  ClockedRoster.Date       := dtClockTime;
                  ClockedRoster.StartTime  := dtClockTime;
                  ClockedRoster.EndTime    := 0;//IncMinute(dtClockTime, 10);
              end;
              if ClockedRoster.TypeCatagory <> rtBOMClocked then ClockedRoster.TypeCatagory := rtBOMClocked;
              ClockedRoster.PostDB;
              ClockedRoster.CurrentRosterBreak;
          end;
          CreateSalesObj;
          fSalesOrder.Load(0);
        end;
  end;
  result := fEmployee;
end;

procedure TfmBarCodeManufacturing.FormCreate(Sender: TObject);
begin
  ExcludeGridfromcustomize(grdEmployees);
  ExcludeGridfromcustomize(grdSales);
  ExcludeGridfromcustomize(grdMain);
  AllowCustomiseGrid := true;
  inherited;
  ProcessingBarcode:= False;
  CreateemployeeObj;
  CreateSalesObj;
  fbCanStopanyManufacturingJob:=False;
  fClockedRoster := nil;
  Widerform(1250);
  MakeButtons;
End;

procedure TfmBarCodeManufacturing.FormDestroy(Sender: TObject);
begin
  if Assigned(fClockedRoster) then freeandnil(fClockedRoster);
  inherited;

end;

procedure TfmBarCodeManufacturing.ProcessBarcode(const codeStr: string);
var
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    fastfuncs.Split(codeStr,Barcode_SepChar,sl);
    if sl.Count > 1 then begin
      if sl[0] = Barcode_Prefix_Employee then begin
        ProcessEmployee(sl[1]);
      end else if sl[0] = Barcode_Prefix_Sale then begin
        if Employee.ID= 0 then begin
          CommonLib.MessageDlgXP_Vista('Please Scan employee Card.' , mtWarning, [mbOk], 0);
          Exit;
        end;
        ProcessSales(sl[1]);
      end;
    end else if codeStr = ROSTERBREAK         then begin doRosterBreak;
    end else if CodeStr = LOGOFF              then begin ProcessBarcodeStopAllnLogoff;
    end else if CodeStr = HISTORY             then begin ShowHistory;
    end else begin
      if Employee.id = 0 then begin
        CommonLib.MessageDlgXP_Vista('Please Select an Employee' , mtWarning, [mbOk], 0);
        Exit;
      end;
      if Qryjobs.recordcount = 0 then begin
          CommonLib.MessageDlgXP_Vista('Please Select a Sales Order' , mtWarning, [mbOk], 0);
          Exit;
      end;
      if (QryJobsisroot.asBoolean and (QryJobsQtyToBeinvoiced.AsFloat =0)) then
        if  (codeStr = SCHEDULE)    or (codeStr = QnA) or (codeStr = START   ) or
            (codeStr = UNSCHEDULE ) or (codeStr = ALLOCATION ) then begin
          TimerMsg(lbltimesheethint ,QryJobsLineProductName.AsString +' is completely Invoiced');
          Exit;
      end;
      if (not(QryJobsisroot.asBoolean) and (QryJobsQtyToBeBuilt.AsFloat =0) and (QryJobsIsSubBOM.asBoolean)) then
        if  (codeStr = SCHEDULE)    or (codeStr = QnA) or (codeStr = START   ) or
            (codeStr = UNSCHEDULE ) or (codeStr = ALLOCATION ) then begin
          TimerMsg(lbltimesheethint ,QryJobsLineProductName.AsString +' is completely Built');
          Exit;
      end;

      if (not(QryJobsisroot.asBoolean) and (QryJobstobeused.AsFloat =0) and (not(QryJobsIsSubBOM.asBoolean))) then
        if  (codeStr = SCHEDULE)    or (codeStr = QnA) or (codeStr = START   ) or
            (codeStr = UNSCHEDULE ) or (codeStr = ALLOCATION ) then begin
          TimerMsg(lbltimesheethint ,QryJobsLineProductName.AsString +' is completely Used');
          Exit;
      end;
               if codeStr = SCHEDULE            then begin ProcessBarcodeSchedule;
      end else if codeStr = QnA                 then begin ProcessBarcodeQnA;
      end else if codeStr = START               then begin ProcessBarcodeStart;
      end else if codeStr = STOP                then begin ProcessBarcodeStop;
      end else if codeStr = STOPALL             then begin ProcessBarcodeStopAll;
      end else if codeStr = COMPLETE            then begin ProcessBarcodeComplete;
      end else if codeStr = UNSCHEDULE          then begin ProcessBarcodeUNSchedule;
      end else if codeStr = OPENSALE            then begin ProcessBarcodeDoOpenSale;
      end else if codeStr = PRODUCTTREE         then begin ProcessBarcodePrintProductTree;
      end else if codeStr = TREECOMMENTS        then begin DoTreeComments;
      end else if codeStr = PRINTPICKING        then begin ProcessBarcodedoPrintPicking;
      end else if codeStr = ALLOCATION          then begin ProcessBarcodedoPrintAllocation;
      end else if codeStr = PRODUCTIONWORKSHEET then begin ProcessBarcodePrintProductionworkSheet;
      end else if codeStr = COMPLETEINVOICE     then begin ProcessBarcodeDoCompleteAndInvoice;
      end else if codeStr = PARTIALINVOCICE     then begin ProcessBarcodePartialInvoice;
      //end else if codeStr = PARTIALINVOCICEOLD  then begin ProcessBarcodePartialInvoiceOld;
      end else if codeStr = OPENDOCPATH         then begin DoOpenDocPath;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfmBarCodeManufacturing.ProcessEmployee(EmployeeID:String);
begin
  if ISInteger(EmployeeID) then begin
    Employee(strToInt(EmployeeID));
    showrosterStatus;
    LoadJobs;
    fbCanStopanyManufacturingJob:= CanStopanyManufacturingJob(Employee.ID);
  end;
end;
procedure TfmBarCodeManufacturing.ProcessSales(saleID: String);
begin
  if ISInteger(SaleId) then begin
    SalesOrder(strToInt(SaleID));
    LoadJobs;
    if SalesOrder.ID <> 0 then
      if (QryJobs.Recordcount =0) or (QryJobs.locate('saleId' , SalesOrder.ID, []) = False) then
        MessageDlgXP_Vista('Sale #' + IntToStr(SalesOrder.ID) +' Has No Process.' , mtInformation , [mbOk] , 0);
  end;
end;


function TfmBarCodeManufacturing.SalesOrder(SaleSId: Integer): TSalesOrder;
begin
  CreateSalesObj;
  if not(fSalesOrder.DatasetAssigned) or ((fSalesOrder.ID<> salesID) and (SalesID<>0)) or (fSalesOrder.Dataset.active =False) then begin
    fSalesOrder.Load(SalesID);
    //if fSalesOrder is TSales then TSales(fSalesOrder).InstantiateAllTrees; // load the trees to copy
  end;
  result := fSalesOrder;
end;

procedure TfmBarCodeManufacturing.CreateSalesObj;
begin
  if (not(Assigned(fSalesOrder))) then begin
    fSalesOrder:=TSalesOrder.Create(Self);
    fSalesOrder.connection := TMyDacDataConnection.create(fSalesOrder);
    fSalesOrder.connection.connection := MyConnection;
    fSalesOrder.BusObjEvent := DoBusinessObjectEvent;
  end;
end;

procedure TfmBarCodeManufacturing.FormShow(Sender: TObject);
begin
  inherited;
  lblMsg.Height := pnlextrabuttons.Height;
  lblMsg.visible := False;
  lblMsg.Caption := '';
  fEmployee.Load(0);
  fsalesOrder.Load(0);
  SetControlFocus(edtBarcodeInput);
  LoadJobs;
  Readguiprefs;

  grdSales.titlecolor := self.color;
  grdSales.Footercolor := Self.Color;
  grdEmployees.titlecolor := self.color;
  grdEmployees.Footercolor := Self.Color;
  actbreak.visible := appenv.CompanyPrefs.AutoclockOnemployeeOnjob;
  SetGridColumns;
end;


procedure TfmBarCodeManufacturing.LoadJobs;
begin
  closedb(QryJobs);
  qryjobs.sql.text := QryjobsSQL;
  opendb(QryJobs);
end;

procedure TfmBarCodeManufacturing.MakeButtons;
const
  btnWidth = (*70;//*)77;
  btnheight = 75;
var
  btnTop  :Integer;
begin
    btnTop :=  trunc((pnlOptions.height -btnheight)/2);
    btn_1	    := TERPMainSwitchButton.create(Self);  With btn_1  do begin  Name := MakeName(Self,'btn_1'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,1, pnlOptions);Top := btnTop;HelpContext := 753011;  DnmAction := actWorksheet  ;(*iLeft := iLeft +Width+1;*)end;
    btn_2	    := TERPMainSwitchButton.create(Self);  With btn_2  do begin  Name := MakeName(Self,'btn_2'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,2, pnlOptions);Top := btnTop;HelpContext := 753015;  DnmAction := actPicking    ;(*iLeft := iLeft +Width+1;*)end;
    btn_3	    := TERPMainSwitchButton.create(Self);  With btn_3  do begin  Name := MakeName(Self,'btn_3'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,3, pnlOptions);Top := btnTop;HelpContext := 753119;  DnmAction := actAllocation ;(*iLeft := iLeft +Width+1;*)end;
    btn_4	    := TERPMainSwitchButton.create(Self);  With btn_4  do begin  Name := MakeName(Self,'btn_4'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,4, pnlOptions);Top := btnTop;HelpContext := 753007;  DnmAction := actSchedule   ;(*iLeft := iLeft +Width+1;*)end;
    btn_5	    := TERPMainSwitchButton.create(Self);  With btn_5  do begin  Name := MakeName(Self,'btn_5'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,5, pnlOptions);Top := btnTop;HelpContext := 753013;  DnmAction := actUnschedule ;(*iLeft := iLeft +Width+1;*)end;
    btn_6	    := TERPMainSwitchButton.create(Self);  With btn_6  do begin  Name := MakeName(Self,'btn_6'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,6, pnlOptions);Top := btnTop;HelpContext := 753008;  DnmAction := actStart      ;(*iLeft := iLeft +Width+1;*)end;
    btn_7	    := TERPMainSwitchButton.create(Self);  With btn_7  do begin  Name := MakeName(Self,'btn_7'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,7, pnlOptions);Top := btnTop;HelpContext := 753081;  DnmAction := actStop       ;(*iLeft := iLeft +Width+1;*)end;
    btn_8	    := TERPMainSwitchButton.create(Self);  With btn_8  do begin  Name := MakeName(Self,'btn_8'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,8, pnlOptions);Top := btnTop;HelpContext := 753016;  DnmAction := actStopAll    ;(*iLeft := iLeft +Width+1;*)end;
    btn_9	    := TERPMainSwitchButton.create(Self);  With btn_9  do begin  Name := MakeName(Self,'btn_9'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,9, pnlOptions);Top := btnTop;HelpContext := 753118;  DnmAction := actQA         ;(*iLeft := iLeft +Width+1;*)end;
    btn_10	  := TERPMainSwitchButton.create(Self);  With btn_10 do begin  Name := MakeName(Self,'btn_10');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,10,pnlOptions);Top := btnTop;HelpContext := 753009;  DnmAction := actComplete   ;(*iLeft := iLeft +Width+1;*)end;
    btn_11	  := TERPMainSwitchButton.create(Self);  With btn_11 do begin  Name := MakeName(Self,'btn_11');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,11,pnlOptions);Top := btnTop;HelpContext := 753010;  DnmAction := actTree       ;(*iLeft := iLeft +Width+1;*)end;
    btn_12	  := TERPMainSwitchButton.create(Self);  With btn_12 do begin  Name := MakeName(Self,'btn_12');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,12,pnlOptions);Top := btnTop;HelpContext := 753012;  DnmAction := actOpenSale   ;(*iLeft := iLeft +Width+1;*)end;
    btn_13	  := TERPMainSwitchButton.create(Self);  With btn_13 do begin  Name := MakeName(Self,'btn_13');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,13,pnlOptions);Top := btnTop;HelpContext := 753014;  DnmAction := actInvoice    ;(*iLeft := iLeft +Width+1;*)end;
    btn_14	  := TERPMainSwitchButton.create(Self);  With btn_14 do begin  Name := MakeName(Self,'btn_14');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,14,pnlOptions);Top := btnTop;HelpContext := 753018;  DnmAction := actPInvoice   ;(*iLeft := iLeft +Width+1;*)end;
    btn_15	  := TERPMainSwitchButton.create(Self);  With btn_15 do begin  Name := MakeName(Self,'btn_15');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,15,pnlOptions);Top := btnTop;HelpContext := 753018;  DnmAction := actopenDocPath;(*iLeft := iLeft +Width+1;*)end;
    //btn_16	  := TERPMainSwitchButton.create(Self);  With btn_16 do begin  Name := MakeName(Self,'btn_16');Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,16,pnlOptions);Top := btnTop;HelpContext := 753018;  DnmAction := actPInvoiceold;(*iLeft := iLeft +Width+1;*)end;

    BtnTop_1	:= TERPMainSwitchButton.create(Self);  With BtnTop_1  do begin Name := MakeName(Self,'BtnTop_1'); Parent := DNMPanel3;  Left := 5;Top := 3;Width := 83;Height := 75;HelpContext := 753077;  visible := true;DnmAction := actEmployees;end;
    BtnTop_2	:= TERPMainSwitchButton.create(Self);  With BtnTop_2  do begin Name := MakeName(Self,'BtnTop_2'); Parent := DNMPanel3;  Left := 91;Top := 3;Width := 83;Height := 75;HelpContext := 753111;  visible := true;DnmAction := actLogOff;end;
    BtnTop_3	:= TERPMainSwitchButton.create(Self);  With BtnTop_3  do begin Name := MakeName(Self,'BtnTop_3'); Parent := DNMPanel3;  Left := 176;Top := 3;Width := 83;Height := 75;HelpContext := 753112;  visible := true;DnmAction := actBreak;end;
    BtnTop_4	:= TERPMainSwitchButton.create(Self);  With BtnTop_4  do begin Name := MakeName(Self,'BtnTop_4'); Parent := DNMPanel3;  Left := 261;Top := 3;Width := 83;Height := 75;HelpContext := 753113;  visible := true;DnmAction := actHistory;end;

    BtnTop_5	:= TERPMainSwitchButton.create(Self);  With BtnTop_5  do begin Name := MakeName(Self,'BtnTop_5'); Parent := DNMPanel4;  Left := 24;Top := 3;Width := 83;Height := 75;HelpContext := 753078;  DnmAction := actJobs;end;
    BtnTop_6	:= TERPMainSwitchButton.create(Self);  With BtnTop_6  do begin Name := MakeName(Self,'BtnTop_6'); Parent := DNMPanel4;  Left := 132;Top := 3;Width := 83;Height := 75;HelpContext := 753115;  DnmAction := actComments;end;
end;

procedure TfmBarCodeManufacturing.QryEmployeeCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryEmployeeEmployeeName.asString := Trim(replaceStr(QryEmployeeTitle.asString +' ' +
                                      QryEmployeeFirstName.asString +' ' +
                                      QryEmployeeMiddleName.asString +' ' +
                                      QryEmployeeLastName.asString,'  ' , ' '))
end;
procedure TfmBarCodeManufacturing.grdJobsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (Sysutils.SameText(Field.fieldName , 'TimeStart')) or
     (Sysutils.SameText(Field.fieldName , 'TimeEnd')) then begin
     if TDateTimeField(Field).AsDateTime = 0 then AFont.Color := ABrush.Color;
  end;
  if QryJobsPPTID.asInteger <> 0 then begin
    AFont.Color  := clRed;
    lbltimesheethint.Caption := 'Lines in Red Colour are Started by the Employee Currently Logged in (' +  QryEmployeeEmployeeName.asString +')';
    lbltimesheethint.Visible := True;
  end;
  if Highlight then begin
    Abrush.color := clGradientActiveCaption;
    if QryJobsPPTID.asInteger = 0 then
      AFont.Color  := clnavy;
  end;
  if QryJobsTimestart.asDateTime <= 1 then
      if (SameText(Field.fieldname , QryJobsTimestart.fieldname)) then AFont.Color :=ABrush.Color ;
  if QryJobsTimeend.asDateTime <= 1 then
      if (SameText(Field.fieldname , QryJobsTimeend.fieldname)) then AFont.Color :=ABrush.Color ;

  {hide sales line fields if not the root node}
  //if not QryJobsisroot.asBoolean then begin
  if QryJobsrownum.asInteger >1 then begin
    if sametext(Field.fieldname , QryJobsLineQty.fieldname) or
       sametext(Field.fieldname , QryJobsLineProductName.fieldname) or
       sametext(Field.fieldname , QryJobsLineShipDate.fieldname) or
       sametext(Field.fieldname , QryJobsLineProductDescription.fieldname) or
       sametext(Field.fieldname , QryJobsSaleDate.fieldname) or
       sametext(Field.fieldname , QryJobscustomername.fieldname) or
       sametext(Field.fieldname , QryJobsSaleDate.fieldname) or
       sametext(Field.fieldname , QryJobsclass.fieldname) or
       sametext(Field.fieldname , QryJobsInvoiceDocNumber.fieldname) or
       sametext(Field.fieldname , QryJobsSaleID.fieldname) or
       sametext(Field.fieldname , QryJobsPartiallyinvoiced.fieldname) or
       sametext(Field.fieldname , QryJobsQtyToBeinvoiced.fieldname) then
            Afont.color := ABrush.color;
      {Started Processes of the sales other than the currently selected sale, should show the saleId}
(*      if QryJobsIsJoboftheCurrentsale.AsBoolean then begin
           if sametext(Field.fieldname , QryJobsInvoiceDocNumber.fieldname) or
              sametext(Field.fieldname , QryJobsSaleID.fieldname) then
                Afont.color := ABrush.color;
      end;*)
  end;


  {internal order - root node should show the qty built into stock}
  if QryJobsisroot.asBoolean and QryJobsisinternalorder.asBoolean then begin
    if sametext(Field.fieldname , QryJobsPartiallyinvoiced.fieldname) or
       sametext(Field.fieldname , QryJobsQtyToBeinvoiced.fieldname) then
            Afont.color := ABrush.color;
  end;

  {root node should hide manufacturing and tobeused qtys }
  if QryJobsisroot.asBoolean  then begin
    if sametext(Field.fieldname , QryJobstobeused.fieldname) or
       sametext(Field.fieldname , QryJobsManufacturingUOMQty.fieldname) then
            Afont.color := ABrush.color;
  end;

  {root node of internal order should show builtintostock}
  if ((QryJobsisroot.asBoolean) and not(QryJobsisinternalorder.asBoolean)) or
        not (QryJobsIsSubBOM.asBoolean) then begin
    if sametext(Field.fieldname , QryJobsmanufactureduomqty.fieldname) or
       sametext(Field.fieldname , QryJobsQtyToBeBuilt.fieldname) then
            Afont.color := ABrush.color;
  end;

end;


procedure TfmBarCodeManufacturing.grdJobsColEnter(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmBarCodeManufacturing.grdJobsColExit(Sender: TObject);
begin       inherited;
  if (qryJobs.State in [dsInsert, dsEdit]) and
     (SameText(TwwDBGrid(Sender).SelectedField.FieldName, 'Comment')) and
     (qryJobs.FieldByName('SaleId').asInteger > 0) then
    UpdateComment;
//    qryJobs.Post;
//
end;
procedure TfmBarCodeManufacturing.ShowAllComments;
begin
  if not qryjobsid.asinteger =0 then exit;
  OpenERPListFormModal('TProcessParttimesheetListGUI' ,nil,  Beforeshowlistform);
end;
procedure TfmBarCodeManufacturing.grdJobsDblClick(Sender: TObject);
begin
  inherited;
  if QryJobsSaleId.asInteger =0 then exit;
  if  sametext(ActiveFieldName(grdJobs) , qryJobscomment.Fieldname) then begin
    ShowAllComments;
    Exit;
  end;
  ProcessSales(QryJobsSaleId.asString);
end;

procedure TfmBarCodeManufacturing.Readguiprefs;
var
  ctr:Integer;
begin
  SetUpbuttons;
  if GuiPrefs.Node.Exists('Options.hideComments') then
      chkHidecomments.Checked :=GuiPrefs.Node['Options.hideComments'].asBoolean;
  if GuiPrefs.Node.Exists('Options.pnlComments.width') then
    pnlComments.width := GuiPrefs.Node['Options.pnlComments.width'].asInteger
  else pnlComments.width := 150;
  if guiprefs.Active=False then guiprefs.active := true;
  for ctr:= 0 to ComponentCount-1 do
    if components[ctr] is TERPMainSwitchButton then
//      if TERPMainSwitchButton (components[ctr]).Parent = pnlOptions then
      if (TERPMainSwitchButton(components[ctr]).Parent = pnlOptions) or
         (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel3) or
         (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel4) then
          if GuiPrefs.Node.Exists('Options.' + TERPMainSwitchButton (components[ctr]).Name+'.visible') then
            TERPMainSwitchButton(components[ctr]).visible := GuiPrefs.Node['Options.' + TERPMainSwitchButton (components[ctr]).Name+'.visible'].asBoolean
          else TERPMainSwitchButton(components[ctr]).visible := True;

  AlignButtons;
end;

procedure TfmBarCodeManufacturing.RefreshQuery;
begin
  CloseDB(QryJobs);
  OpenDB(QryJobs);
end;


procedure TfmBarCodeManufacturing.doRosterBreak;
var
  s:String;
begin
  if not Appenv.CompanyPrefs.AutoclockOnemployeeOnjob then exit;
  if not Assigned(femployee) or (femployee.ID =0) then exit;
  if ClockedRoster.Count =0 then exit;
  if ClockedRoster.CurrentRosterBreak.Count >0 then begin
    ClockedRoster.CurrentRosterBreak.endtime := now;
    ClockedRoster.CurrentRosterBreak.PostDB;
    ClockedRoster.CurrentRosterBreak.REfreshDB;
  end else begin
    s := GetSimpleType(TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_RosterBreaks, true));
    if s<> '' then begin
      ClockedRoster.CurrentRosterBreak.New;
      ClockedRoster.CurrentRosterBreak.EmployeeID := femployee.ID;
      ClockedRoster.CurrentRosterBreak.RosterBreaktype := s;
      ClockedRoster.CurrentRosterBreak.Starttime := now;
      ClockedRoster.CurrentRosterBreak.PostDB;
    end;
  end;
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeSchedule;
var
  conn :TERPConnection;
  count :Integer;
  msg: string;
begin
      conn := CommonDbLib.GetNewMyDacConnection(Self);
      Try
        conn.StartTransaction;
        Try
          if AutoScheduleProduction(msg, count, Conn, userlock, IntToStr(Salesorder.SaleID)) then begin
            if count > 0 then begin
              conn.Commit;
              RefreshQuery;
            end else
              conn.Rollback;
          end;
        Except
          conn.Rollback;
        end;
      Finally
          Freeandnil(conn);
      end;
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeStart;
begin
  if QryJobsPPTID.asInteger = 0 then
    TimerMsg(lbltimesheethint ,'You (' +  QryEmployeeEmployeeName.asString +') just started on ' + QuotedStr(QryJobsProcess.asString) +' of ' +  Quotedstr(QryJobsLineProductName.asString));
  ProcessBarcodeChangeStatus(PS_STARTED, ProcessBarCodeStart);
end;

Procedure TfmBarCodeManufacturing.ProcessBarCodeStart(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);
begin
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID)+
                    ' and  EmployeeID = ' + IntToStr(Employee.ID)+
                    ' and ifnull(Timeend,0) = 0 and Active ="T"');
  if PPT.count =0 then begin
    PPT.Connection.BeginNestedTransaction;
     PPT.New;
     PPT.ProcessPartID :=ProcessPartID;
     PPT.EmployeeId := Employee.ID;
     PPt.TimeStart := timestart;
     if PPt.Save then begin
      PPt.GetNewDataSet('update  tblProcessPart ' +
        ' Set Status = ' + QuotedStr(PS_STARTED)+ ',' +
        ' TimeStart  = ' + QuotedStr(ConvertCurrentDateToMySQLDateTime(Timestart)) +
        ' where ID   = ' + IntToStr(ProcessPartID), true);
      PPT.Connection.CommitNestedTransaction;
     end else PPT.Connection.RollbackNestedTransaction;

  end;
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeQnA;
begin
  ProcessBarcodeChangeStatus(PS_QUALITYASSURANCE, ProcessBarcodeQnA);
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeQnA(PPT: TProcessPartTimesheet; ProcessPartID: Integer);
var
  Alldone:Boolean;
begin
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID)+
                    ' and  EmployeeID = ' + IntToStr(Employee.ID)+
                    ' and ifnull(Timeend,0) = 0 and Active ="T"');
  if PPT.count =0 then begin
     PPT.Connection.BeginNestedTransaction;
     PPT.New;
     PPT.ProcessPartID :=ProcessPartID;
     PPT.EmployeeId := Employee.ID;
     PPt.TimeStart := timestart;
     if PPt.Save then begin
      PPT.Connection.CommitNestedTransaction;
     end else begin
      PPT.Connection.RollbackNestedTransaction;
      Exit;
     end;
  end;
  PPt.GetNewDataSet('update  tblProcessPart ' +
        ' Set Status = ' + QuotedStr(PS_QUALITYASSURANCE)+
        ' where ID   = ' + IntToStr(ProcessPartID), true);
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeComplete;
begin
  ProcessBarcodeChangeStatus(PS_COMPLETE, ProcessBarcodeComplete);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeComplete(PPT: TProcessPartTimesheet; ProcessPartID: Integer);
var
  Alldone:Boolean;
begin
  Alldone := true;
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID));
  if PPT.count >0 then begin
    PPT.First;
    While PPT.EOF = False do begin
      PPT.Connection.BeginNestedTransaction;
       PPt.TimeEnd := timestart;
       if PPt.Save then begin
        PPT.Connection.CommitNestedTransaction;
       end else begin
        PPT.Connection.RollbackNestedTransaction;
        Alldone := False;
       end;
       PPT.Next;
    end;
  end;
  if Alldone then
    PPt.GetNewDataSet('update  tblProcessPart ' +
    ' Set Status  = ' + QuotedStr(PS_COMPLETE)+
    ' where ID    = ' + IntToStr(ProcessPartID), true)
  else
    MessageDlgXP_Vista('Open TimeSheet Entries Exists For This Job.' , mtWarning, [mbOk],0);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeUNSchedule;
begin
  ProcessBarcodeChangeStatus(PS_NOTSCHEDULED, ProcessBarcodeUNSchedule);
end;
Procedure TfmBarCodeManufacturing.ProcessBarcodeUNSchedule(PPT:TProcessPartTimesheet;  ProcessPartID:Integer);
var
  Alldone:Boolean;
begin
  Alldone:= false;
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID));
  if PPT.count >0 then begin
    PPT.First;
    Alldone := true;
    While PPT.EOF = False do begin
        PPT.Connection.BeginNestedTransaction;
        if PPt.TimeEnd = 0 then PPt.TimeEnd := timestart;
        PPt.Active := False;
        if PPt.Save then begin
          PPT.Connection.CommitNestedTransaction;
        end else begin
          PPT.Connection.RollbackNestedTransaction;
          Alldone := False;
        end;
       PPT.Next;
    end;
  end;
  if Alldone then   begin
    PPt.GetNewDataSet('update  tblprocesstime ' +
                          ' Set TimeStart=0,' +
                          ' TimeEnd     = 0, Duration =0'+
                          ' where ProcessPartId    = ' + IntToStr(ProcessPartID)+';'+
                      'update  tblProcessPart ' +
                          ' Set Status  = ' + QuotedStr(PS_NOTSCHEDULED)+ ',' +
                          ' Timeend     = 0, timeStart =0'+
                          ' where ID    = ' + IntToStr(ProcessPartID), true);
  end else
    MessageDlgXP_Vista('Open TimeSheet Entries Exists For This Job.' , mtWarning, [mbOk],0);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeDoCompleteAndInvoice;
begin
  ProcessBarcodeChangeStatus(PS_COMPLETENINVOICE, ProcessBarcodeComplete);
end;

Procedure TfmBarCodeManufacturing.DoAllocation;
begin
  if QryJobsSaleID.AsInteger =0 then exit;
  if not UserLock.Lock('tblsales' , QryJobsSaleID.AsInteger) then begin
    MessageDlgXP_Vista(replacestr(userlock.lockMessage , 'Unable to update data.' , 'Unable to Lock Sales Order for allocation.'), mtWarning, [mbOK], 0);
    Exit;
  end;
  Try

  Finally
    UserLock.UnLock('tblsales', QryJobsSaleID.AsInteger);
  End;

end;
procedure TfmBarCodeManufacturing.ProcessBarcodePartialInvoice;
begin
  if QryJobsSaleLineId.AsInteger =0 then begin
    MessageDlgXP_vista('Please choose the Job', mtInformation, [mbOK], 0);
    exit;
  end;
  //OpenERPFormModal('TfmBarCodeManufacturingSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
  OpenERPFormModal('TFmPartialBuild' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate) ;
  LoadJobs;
end;
procedure TfmBarCodeManufacturing.ProcessBarcodePartialInvoiceOld;
begin
  if QryJobsSaleLineId.AsInteger =0 then begin
    MessageDlgXP_vista('Please choose the Job', mtInformation, [mbOK], 0);
    exit;
  end;
  OpenERPFormModal('TfmBarCodeManufacturingSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
end;
Procedure TfmBarCodeManufacturing.DoOpenDocPath;
var
  qry: TERPQuery;
begin
  if (QryJobsSaleId.AsInteger =0) or (QryJobsSaleLineId.AsInteger =0) or (QryJobsProductId.AsInteger =0) then begin
     MessageDlgXP_Vista('Please Choose the Sale', mtInformation, [mbOK], 0);
     Exit;
  end;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.Sql.Text := 'select PartsId, Partname,  DocumentPath from tblparts where partsId = ' +   inttostr(QryJobsProductId.AsInteger);
    qry.open;
    DocPathlib.OpenDocPath(Qry);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
procedure TfmBarCodeManufacturing.initSalesorderInvoice(Sender: TObject);
begin
  if sender is   TfmBarCodeManufacturingSalesorderInvoice then  begin
    TfmBarCodeManufacturingSalesorderInvoice(Sender).saleID     := QryJobsSaleId.AsInteger;
    TfmBarCodeManufacturingSalesorderInvoice(Sender).SaleLineID := QryJobsSaleLineId.AsInteger;
    TfmBarCodeManufacturingSalesorderInvoice(Sender).Callingformname := Self.classname;
  end else if sender is TFmPartialBuild then begin
    TFmPartialBuild(Sender).SaleLineID := QryJobsSaleLineId.AsInteger;
    TFmPartialBuild(Sender).ProctreeId := QryJobsProctreeid.AsInteger;
    TFmPartialBuild(Sender).EmployeeID := Employee.id;
  end;
end;
procedure TfmBarCodeManufacturing.OnSalesOrderInvoiceCreate(Sender:TObject);
begin
  if sender is TfmBarCodeManufacturingSalesorderInvoice then begin
    if TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrder.isinternalOrder  then
      timerMsg(lbltimesheethint ,'Quantity Selected is now in stock for Sales Order # ' + inttostr(TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrderID)+'.')
    else if TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId <> 0 then
      timerMsg(lbltimesheethint ,'Invoice #' + inttostr(TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId ) +' is Created. ');
  end;
end;

Procedure TfmBarCodeManufacturing.ProcessBarcodePrint(Status: String);
var
  i:Integer;
  IL:TIntegerList;
  SaleLineIDList:TIntegerList;
  function isToPrintProductionWorksheet:boolean;
  begin
      Result := Sysutils.SameText(Status, PRODUCTIONWORKSHEET);
  end;
  function isToPrintPick:boolean;
  begin
      Result := Sysutils.SameText(Status , PRINTPICKING) ;
  end;
  function isToPrintallocation:Boolean;
  begin
      Result := Sysutils.SameText(Status , ALLOCATION) ;
  end;
begin
  IL:=TIntegerList.Create;
  SaleLineIDList:=TIntegerList.Create;
  try

    if grdjobs.SelectedList.Count > 0 then begin
      for i := 0 to grdjobs.SelectedList.Count - 1 do begin
        QryJobs.GotoBookmark(grdjobs.SelectedList.Items[i]);
        if isToPrintPick  then begin
            IL.AddIfNotInList(QryJobsProcTreeId.asInteger);
        end else if  isToPrintProductionWorksheet then begin
            SaleLineIDList.AddIfNotInList(QryJobsSaleLineId.asInteger);
            IL.AddIfNotInList(QryJobsProcessStepId.asInteger);
        end else if  isToPrintallocation then begin
            SaleLineIDList.AddIfNotInList(QryJobsSaleLineId.asInteger);
        end;
      end;

      if isToPrintPick then begin
          DoPrintPick(IL);
      end else if isToPrintProductionWorksheet then begin
          DoProductionWorksheet(IL, SaleLineIDList);
      end else if  isToPrintallocation then begin
          QryJobs.GotoBookmark(grdjobs.SelectedList.Items[0]);
          if (SaleLineIDList.Count = 1) or ((SaleLineIDList.Count >1) and
                                              (MessageDlgXP_Vista('You have selected multiple Items. Allocation can be done for one item at a time. '+
                                                                  'Do you like to continue with the first Item Selected - ' + Quotedstr(QryJobs.FieldbyName('LineProductName').asString)+'?', mtConfirmation, [mbYes, mbNo], 0)= mryes)) then begin
                DoPrintAllocation(QryJobs.FieldbyName('SaleID').AsInteger, QryJobs.FieldbyName('SaleLineId').AsInteger);
          end;
      end;
    end;
  finally
    FreeandNil(  IL);
    FreeandNil(  SaleLineIDList);

  end;
end;

Procedure TfmBarCodeManufacturing.ProcessBarcodeChangeStatus(Status:String; fProcessBarCodeStart :TProcessBarCodeProc);
var
  i:Integer;
  IL:TIntegerList;

  PPT:TProcessPartTimesheet;
  Msg:String;

  function IsTonOkToStart :Boolean;
  begin
    REsult := False;
    if Sysutils.SameText(QryJobsStatus.asString , PS_NOTSCHEDULED) then begin
      TimerMsg(lbltimesheethint ,'This job ' + QuotedStr(QryJobsProcess.asString) +' of ' +  Quotedstr(QryJobsLineProductName.asString)+' is not Scheduled Yet.') ;
      Exit;
    end;
    if not(Sysutils.SameText(Status , PS_STARTED)) then Exit;
    if Sysutils.SameText(QryJobsStatus.asString , PS_SCHEDULED)then result := True{just scheduled}
    else if (Sysutils.SameText(QryJobsStatus.asString , PS_STARTED)) and
          (QryJobsPPTID.asInteger = 0{not started by this employee}) then result := true;{started by some one else}
  end;

  function IsTonOktoStopAll:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , STOPALL)) then exit;
        if fbCanStopanyManufacturingJob then
          result := true;
  end;
  function IsTonOktoStop:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , PS_STOPPED)) then exit;
    if (Sysutils.SameText(QryJobsStatus.asString , PS_QUALITYASSURANCE)) or
      (Sysutils.SameText(QryJobsStatus.asString , PS_STARTED)) then begin
        if (QryJobsPPTID.asInteger <> 0{started by same employee}) then result := true;
    end;
  end;

  function IsTonOktoComplete:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , PS_COMPLETE)) then exit;
    if (Sysutils.SameText(QryJobsStatus.asString , PS_SCHEDULED)) or
        (Sysutils.SameText(QryJobsStatus.asString , PS_QUALITYASSURANCE)) or
       (Sysutils.SameText(QryJobsStatus.asString , PS_STARTED))  then result := true;
  end;
  function IsTonOktoqa:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , PS_QUALITYASSURANCE)) then exit;
    if  (Sysutils.SameText(QryJobsStatus.asString , PS_STARTED))  then result := true
    else if (Sysutils.SameText(QryJobsStatus.asString , PS_QUALITYASSURANCE)) and
          (QryJobsPPTID.asInteger = 0{not started by this employee}) then result := true;{started by some one else}
  end;
  function IsTonOktoInvoice:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , PS_COMPLETENINVOICE)) then exit;
    if  (Sysutils.SameText(QryJobsStatus.asString , PS_STARTED)) or
    (Sysutils.SameText(QryJobsStatus.asString , PS_SCHEDULED)) or
    (Sysutils.SameText(QryJobsStatus.asString , PS_NOTSCHEDULED)) or
    (Sysutils.SameText(QryJobsStatus.asString , PS_QUALITYASSURANCE)) or
        (Sysutils.SameText(QryJobsStatus.asString , PS_COMPLETE))  then result := true;
  end;
  function ConfirmtoInvoice:Boolean;
  begin
    Result := true;
    if not (Sysutils.SameText(Status , PS_COMPLETENINVOICE) or Sysutils.SameText(Status , PS_COMPLETE)) then exit;
    if CommonLib.MessageDlgXP_Vista('This Will Stop All Active Events On This Job.  Do You Wish To Continue?' , mtConfirmation, [mbyes, mbno] , 0) = mrno then result := False;
  end;
  function IsTonOktoUnSchedule:Boolean;
  begin
    Result := False;
    if not (Sysutils.SameText(Status , PS_NOTSCHEDULED)) then exit;
    result := true;
  end;

  function ConfirmtoUnSchedule:Boolean;
  begin
    Result := true;
    if not (Sysutils.SameText(Status , PS_NOTSCHEDULED)) then exit;
    if CommonLib.MessageDlgXP_Vista('This Will Make All Active Events Inactive On This Job.  Do You Wish To Continue?' , mtConfirmation, [mbyes, mbno] , 0) = mrno then result := False;
  end;



begin
  timestart := Now;
  IL:=TIntegerList.Create;
  try
    if grdjobs.SelectedList.Count > 0 then begin
       if not(ConfirmtoInvoice) or not(ConfirmtoUnSchedule) then exit;

      for i := 0 to grdjobs.SelectedList.Count - 1 do begin
        QryJobs.GotoBookmark(grdjobs.SelectedList.Items[i]);
        if  IsTonOkToStart           or
            IsTonOktoStop             or
            IsTonOktoStopAll       or
            IsTonOktoComplete     or
            IsTonOktoqa  OR
            IsTonOktoInvoice       or
            IsTonOktoUnSchedule then begin
            IL.AddIfNotInList(QryJobsID.asInteger);
        end;
      end;
      if IL.count > 0 then begin
        {lock the whole table - just for update and unlock after that}
        if not((UserLock.Lock('tblProcessParttimesheet' , 0)) and
                    (UserLock.Lock('tblProcessPart' , 0))) then begin
           MessageDlgXP_Vista('Update Failed.  Please Try Again'+chr(13) +UserLock.LockMessage, mtWarning, [mbok],0);
           UserLock.UnLock('tblProcessParttimesheet', 0);
           UserLock.UnLock('tblProcessPart'         , 0);
        end;
        try
          PPT:=TProcessPartTimesheet.create(Self);
          TRy
            PPT.connection := TMyDacDataConnection.Create(PPT);
            PPT.connection.connection := Self.Myconnection;
            if assigned(fProcessBarCodeStart) then begin
              PPT.connection.BeginTransaction;
              Try
                for i := 0 to IL.count -1 do begin
                   fProcessBarCodeStart(PPT, IL[i] );
                end;
                PPT.connection.CommitTransaction;
              Except
                  PPT.connection.RollbackTransaction;
              end;
            end;
          finally
            Freeandnil(PPT);
          end;
        finally
           UserLock.UnLock('tblProcessParttimesheet' , 0);
           UserLock.UnLock('tblProcessPart' , 0);
        end;
        if IsTonOktoInvoice then begin
          IL.clear;
          for i := 0 to grdjobs.SelectedList.Count - 1 do begin
            QryJobs.GotoBookmark(grdjobs.SelectedList.Items[i]);
            if IsTonOktoInvoice then
              IL.AddIfNotInList(QryJobsSaleID.asInteger);
          end;
          if IL.count>0 then begin
                  if DoJobComplete(IL, false, msg) then begin
                    if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
                    RefreshQuery;
                  end else if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
          end;
        end else RefreshQuery;
      end;
    end;
  Finally
      FreeandNil(  IL);
  end;
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeDoOpenSale;
begin
    OpenERPForm('TSalesOrderGUI' , QryJobsSaleID.asInteger ,nil ,nil  )
end;

procedure TfmBarCodeManufacturing.ProcessBarcodedoPrintPicking;
begin
  ProcessBarcodePrint(PRINTPICKING);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodePrintProductionworkSheet;
begin
  ProcessBarcodePrint(PRODUCTIONWORKSHEET);
end;
Procedure TfmBarCodeManufacturing.ProcessBarcodedoPrintAllocation;
begin
  ProcessBarcodePrint(ALLOCATION);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodePrintProductTree(const Columnno:Integer =-1);
var
  TreeForm: TfmProcTreeEdit;
begin
  inherited;
  TreeForm:= TfmProcTreeEdit.Create(self);
  try
    { does not use this but set here to stop "read-only" message from poping up }
    TreeForm.KeyID:= 1;
    { need all of the following to allow editing and saving of Info column in tree }
    TreeForm.TransConnection:= TreeForm.MyConnection;
    TreeForm.TransConnection.Connect;
    TreeForm.Tree.TransConnection:= TreeForm.TransConnection;
    TreeForm.Tree.ProcessTreeID:= QryJobsTreeRootId.asInteger;
    TreeForm.Tree.TreeMode:= tmTemplate;
    TreeForm.Tree.vstProcessPart.Visible:= true;
    TreeForm.TreeColumn :=Columnno;
    //TreeForm.AccessLevel:= 5;
    TreeForm.ShowModal;
  finally
    TreeForm.Free;
  end;

end;





procedure TfmBarCodeManufacturing.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Writeguiprefs;
  UpdateComments;
  inherited;
  Action := caFree;
end;

procedure TfmBarCodeManufacturing.QryJobsAfterPost(DataSet: TDataSet);
begin
  inherited;
  UpdateComment;
end;

procedure TfmBarCodeManufacturing.QryJobsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Refreshcomments;
end;
procedure TfmBarCodeManufacturing.Refreshcomments;
begin
  closedb(qrymain);
  Qrymain.parambyname('ppid').asInteger := qryjobsid.asInteger;
  opendb(qrymain);
  pnlComments.visible := not(chkHidecomments.checked) and qryMain.active;
  splComments.visible := not(chkHidecomments.checked) and qryMain.active;
  splComments.left :=pnlComments.left -10;
end;

procedure TfmBarCodeManufacturing.QryJobsCalcFields(DataSet: TDataSet);
begin
  inherited;
       if QryJobsStatus.asString= ProcessPartStatusToStr(psNotScheduled) then QryjobsCStatus.asString := PS_STR_NOTSCHEDULED
  else if QryJobsStatus.asString= ProcessPartStatusToStr(psQualityAssurance) then QryjobsCStatus.asString := PS_STR_QualityAssurance
  else if QryJobsStatus.asString= ProcessPartStatusToStr(psScheduled)    then QryjobsCStatus.asString := PS_STR_SCHEDULED
  else if QryJobsStatus.asString= ProcessPartStatusToStr(psStarted)      then QryjobsCStatus.asString := PS_STR_STARTED
  else if QryJobsStatus.asString= ProcessPartStatusToStr(psComplete)     then QryjobsCStatus.asString := PS_STR_COMPLETE
  else QryjobsCStatus.asString := PS_STR_UNKNOWN ;
  if QryJobsisroot.asBoolean then QryJobsQtyToBeinvoiced.AsFloat := QryJobsLineQty.AsFloat  - QryJobsPartiallyinvoiced.AsFloat;
  QryJobsQtyToBeBuilt.asFloat := QryJobsManufactureUOMQty.asfloat -   QryJobsmanufactureduomqty.asfloat;
  QryJobstobeused.asFloat :=QryJobsTotalQty.asfloat - QryJobsManufacturingUOMQty.asFloat;
end;

procedure TfmBarCodeManufacturing.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.timestart') then  qryMaintimestart.displaywidth := GuiPrefs.Node['Options.timestart'].asInteger;
  if GuiPrefs.Node.Exists('Options.comment') then  qryMaincomment.displaywidth := GuiPrefs.Node['Options.comment'].asInteger;
end;

procedure TfmBarCodeManufacturing.ExitSalesGridOnEnter(Sender: TObject);
begin
  inherited;
  SetControlFocus(grdJobs);
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeStop;
begin
  TimerMsg(lbltimesheethint ,'You (' +  QryEmployeeEmployeeName.asString +') just stopped ' + QuotedStr(QryJobsProcess.asString) +' of ' +  Quotedstr(QryJobsLineProductName.asString));
  ProcessBarcodeChangeStatus(PS_STOPPED, ProcessBarcodeStop);
  DoTreeComments;
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeStop(PPT: TProcessPartTimesheet; ProcessPartID: Integer);
begin
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID)+
                    ' and  EmployeeID = ' + IntToStr(Employee.ID)+
                    ' and ifnull(Timeend,0) = 0');
  if PPT.count =1 then begin
    PPT.Connection.BeginNestedTransaction;
     PPt.Timeend := timestart;
     if PPt.Save then begin
      PPT.Connection.CommitNestedTransaction;
     end else PPT.Connection.RollbackNestedTransaction;
  end;
end;

procedure TfmBarCodeManufacturing.SelectFirstJob(DataSet: TDataSet);
begin
  inherited;
  lbltimesheethint.Visible := False;
  Refreshcomments;
  if Qryjobs.RecordCount = 0 then exit;
  Qryjobs.First;
  grdJobs.SelectRecord;
  SetGridColumns;
end;
procedure TfmBarCodeManufacturing.SetGridColumns;
begin
  GuiPrefs.DbGridElement[grdjobs].RemoveField(qryjobsProductId.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsSaleLineId.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsProcTreeId.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsProcessStepSeq.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsID.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsTreeRootId.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsProcessStepId.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsPPTID.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobspptid1.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsisroot.fieldname);
  GuiPrefs.DbGridElement[grdjobs].RemoveField(QryJobsrownum.fieldname);

end;
procedure TfmBarCodeManufacturing.ClearSelectedJobs(DataSet: TDataSet);
begin
  inherited;
  grdJobs.UnselectAll;
  closedb(qrymain);
end;


function TfmBarCodeManufacturing.ClockedRoster: TClockedRoster;
begin
  if fClockedRoster = nil then begin
    fClockedRoster :=  TClockedRoster.create(self);
    fClockedRoster.BusObjEvent := DoBusinessObjectEvent;
    fClockedRoster.connection := fEmployee.connection;
  end;
  fClockedRoster.LoadSelect('EmployeeID = ' + IntToStr(fEmployee.ID) + ' AND  Type = "Clocked" AND  ClockedOff <> "T" AND IsClocked ="T"');
  result := fClockedRoster;
end;

procedure TfmBarCodeManufacturing.grdJobsKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {
  if ((Key >= 'A') and (Key <= 'Z')) or
      ((Key >= 'a') and (Key <= 'z')) then begin
  }
  if not SameText(grdJobs.SelectedField.FieldName, 'Comment') or
     (((qryJobs.FieldByName('PPTID').asInteger <= 0) or (qryJobs.FieldByName('PPTID').IsNull)) and
     ((qryJobs.FieldByName('PPTID1').asInteger <= 0) or (qryJobs.FieldByName('PPTID1').IsNull))) then
//         SameText(qryJobs.FieldByName('Status').AsString, 'psNotScheduled') then
  begin
    if CharInSet(Key, ['a'..'z', 'A'..'Z']) then
    begin
        if (edtBarcodeInput.visible) and (edtBarcodeInput.enabled) then begin
          edtBarcodeInput.text := Key;
          SetControlfocus(edtBarcodeInput);
          edtBarcodeInput.SelStart:= 1;
          edtBarcodeInput.SelLength:= 0;
        end;
    end;
  end;

end;

procedure TfmBarCodeManufacturing.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if QryJobsSaleId.asInteger =0 then exit;
  ShowAllComments;
end;

procedure TfmBarCodeManufacturing.DoPrintPick(IL: TIntegerList);
var
  sql: string;
  TempTableName: string;
begin
  DisableForm;
  try
    inherited;
    sql:= '';
    TempTableName:= GetUserTemporaryTableName('ProductionPickListBarcode');
    ProcessDataUtils.BuildProductionRequirementsList(TempTableName , 0 , IL.commatext);
    sql:=
      '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City,  ' +
      ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,  ' +
      ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
      ' FROM tblCompanyInformation AS CO ' +
      ' ~|||~{ProcessParts} ' +
      ' SELECT  pp.*, p.* FROM ' + TempTableName + ' pp, tblParts p ' +
      ' WHERE pp.ProcItemPartsId = p.PartsId ' +
      ' AND pp.ProcItemPartsId > 0 AND pp.ProcItemRoot = "F" ' +
      ' AND pp.ProcItemPartType = "INV"';
      sql:= sql + ' order by pp.ProcItemPartsId';
    fbReportSQLSupplied:= true;
    self.PrintTemplateReport('Production Picking Slip',sql, not(appenv.Employee.ShowPreview),1);
  finally
    EnableForm;
  end;

end;
Procedure TfmBarCodeManufacturing.DoPrintAllocation(saleId, SaleslinesID:Integer);
begin
  if SaleslinesID =0 then exit;
  (*if SalesProductPartiallyShipped(SalesLinesID) then begin
    MessageDlgXP_Vista('This product is being partially/fully shipped. It is not possible to do allocation from here. Do the Partial shipment for doing the allocation.', mtInformation, [mbOK], 0);
    Exit;
  end;*)
  TfmBOMAllocation.DoAllocation(SaleId, SaleslinesID, nil);
end;
procedure TfmBarCodeManufacturing.DoProductionWorksheet(IL, SaleLineIDList: TIntegerList);
var
  form: TfmProcCapacityPlanningWork;
  ctr:Integer;
begin
    form:= TfmProcCapacityPlanningWork.Create(nil);
    form.CallingFormname := Self.classname;
    form.IncludeUnScheduled :=true;
    form.ProcesstepIdList.Clear;  for ctr:= 0 to IL.Count-1             do form.ProcesstepIdList.AddIfNotInList(IL[ctr]);
    form.SaleLineIDList.Clear;    for ctr:= 0 to SaleLineIDList.Count-1 do form.SaleLineIDList.AddIfNotInList(SaleLineIDList[ctr]);

    if form.ProcesstepIdList.IsEmpty then begin
      MessageDlgXP_Vista('Nothing selected.',mtInformation,[mbOk],0);
      form.Free;
    end else begin
      form.hideDates:=True;
      form.ShowModal;
    end;

(*var
  ReportName, SQLStr: string;
  TempTable: string;
  function ReportType:String;
  begin
    if chkIncludeAllocation.checked then result := 'Production Work Sheet with allocation' else result := 'Production Work Sheet';
  end;
begin
  DisableForm;
  try
    inherited;
      if IL.Count > 0 then begin
        PopulateProductionWorkSheetTable(TempTable,IL,0,0, SaleLineIDList, true , true);
        if not TReportTemplates.GetDefaultReportSQL('Production Work Sheet with allocation',ReportName,SQLStr) then begin
          CommonLib.MessageDlgXP_Vista('There is no default Production Work Sheet template defined.',mtInformation,[mbOk],0);
          exit;
        end;
        SQLStr:= StringReplace(SQLStr,'tmp_productionworksheet',TempTable,[rfReplaceAll, rfIgnoreCase]);

        fbReportSQLSupplied:= true;
        PrintTemplateReport(ReportName, SQLStr, not(appenv.Employee.ShowPreview), 1);
      end;
  finally
    EnableForm;
  end;*)
end;

procedure TfmBarCodeManufacturing.DoSomething(Sender: TObject);
var
  Key: Char;
begin
  inherited;
  if sender is TDNMAction then begin
    edtBarcodeInput.text := replacestr(TDNMAction(Sender).Caption ,'&&' , '&');
    key :=Chr(VK_RETURN);
    edtBarcodeInputKeyPress(edtBarcodeInput, key);
  end;
end;


procedure TfmBarCodeManufacturing.DoTreeComments;
var
  s:String;
  Scr :TERPScript;
begin
  //ProcessBarcodePrintProductTree(cInfoColumn);
  if QryJobsProcTreeId.AsInteger =0 then exit;
  if not UserLock.Lock('tblsales' , QryJobsSaleID.AsInteger) then begin
    MessageDlgXP_Vista(replacestr(userlock.lockMessage , 'Unable to update data.' , 'Unable to Lock Sales Order.'), mtWarning, [mbOK], 0);
    Exit;
  end;
  Try
      s := InputBox('Tree Comments ', 'Comments for Sale #' + inttostr(QryJobsSaleID.AsInteger) +' ' + QryJobsLineProductName.AsString + '.' + QryJobsName.AsString + '.' +QryJobsProcess.AsString ,QryJobsinfo.AsString);
      if not(Sametext(QryJobsinfo.AsString , s)) then begin
        Scr := DbSharedObj.GetScript(Self.MyConnection);
        try
          scr.SQL.Text := 'update tblproctree set info = ' +quotedstr(s)+' where proctreeId = ' + inttostr(QryJobsProcTreeId.AsInteger);
          scr.Execute;
          QryJobs.Refresh;
        finally
          DbSharedObj.ReleaseObj(scr);
        end;
      end;
  Finally
    //UserLock.UnLock('tblsales', QryJobsSaleID.AsInteger);
  End;

end;

function TfmBarCodeManufacturing.CanStopanyManufacturingJob(const EmployeeID: Integer): boolean;
begin
 Result := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanStopAnyManufacturingJob', EmployeeID) = 1;
end;


procedure TfmBarCodeManufacturing.chkHidecommentsClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkhideComments then
    Refreshcomments;
end;

procedure TfmBarCodeManufacturing.AlignButtons;
var
  ctr,x:Integer;
  fW:Integer;
  fbuttons:Integer;
  fbw, fbg (*, fbLeft*):Integer;
begin
  fW:= pnlOptions.Width;
  fbuttons := 0;
  fbw :=0;
  //fbLeft :=0;
  for ctr:= 0 to ComponentCount-1 do
    if components[ctr] is TERPMainSwitchButton then
      if TERPMainSwitchButton (components[ctr]).Parent = pnlOptions then
        if TERPMainSwitchButton (components[ctr]).visible then begin
          fbuttons := fbuttons +1;
          if fbw =0 then fbw := TERPMainSwitchButton (components[ctr]).Width;
        end;
  if fbuttons =0 then exit;

  fbg := trunc((trunc(pnlOptions.Width / fbuttons) - fbw)/2);
  if fbg <0 then fbg := 1;
  //fbLeft := fbg;
  x:= 0;
  for ctr:= 0 to ComponentCount-1 do
    if components[ctr] is TERPMainSwitchButton then
      if TERPMainSwitchButton (components[ctr]).Parent = pnlOptions then
        if TERPMainSwitchButton (components[ctr]).visible then begin
          x:= x+1;
          TERPMainSwitchButton (components[ctr]).top :=1;
          TERPMainSwitchButton (components[ctr]).Height := pnlOptions.Height-2;
          TERPMainSwitchButton (components[ctr]).Width := fbw;
          TERPMainSwitchButton (components[ctr]).Left := btnleft(ButtonsCount, fbw ,x,pnlOptions);;
          //fbLeft := fbLeft + fbw+fbg+fbg;
          TERPMainSwitchButton (components[ctr]).Invalidate;
        end;
end;

procedure TfmBarCodeManufacturing.SetUpbuttons;
begin
    btn_1.Caption  := PRODUCTIONWORKSHEET;
    btn_2.Caption  := PRINTPICKING       ;
    btn_3.Caption  := ALLOCATION	          ;
    btn_4.Caption  := SCHEDULE	          ;
    btn_5.Caption  := UNSCHEDULE         ;
    btn_6.Caption  := START	            ;
    btn_7.Caption  := STOP               ;
    btn_8.Caption  := STOPALL	  ;
    btn_9.Caption  := QnA	  ;
    btn_10.Caption := COMPLETE	          ;
    btn_11.Caption := PRODUCTTREE	      ;
    btn_12.Caption := OPENSALE	          ;
    btn_13.Caption := COMPLETEINVOICE	  ;
    btn_14.Caption := PARTIALINVOCICE;
    btn_15.Caption := OPENDOCPATH;
    //btn_16.Caption := PARTIALINVOCICEOLD;


    btn_1.Hint := 'Print The Production Worksheet'+NL;
    btn_2.Hint := 'Print The Picking Slip'+NL;
    btn_3.Hint := 'Open Allocation Form'+NL;
    btn_4.Hint := 'Open Auto-Schedule Form'+NL;
    btn_5.Hint := 'Unschedule The Selected Process'+NL;
    btn_6.Hint := 'Start The Selected Process' + NL+'Processes Scheduled and not started by you can be started'+NL;
    btn_7.Hint := 'Stop The Selected Process If Started By The Employee Currently Logged In'+NL;
    btn_8.Hint := 'Stop The Selected Process Started by Anybody(Only if the logged in User has access to Do it)'+NL;
    btn_9.Hint := 'Start Quality Assurance for  the selected Processes.' + NL +'Processes Started / Scheduled and not "Quality Assurance" by you can start the Quality Assurance' +NL;
    btn_10.Hint := 'Complete The Selected Process. This will Stop All Started Jobs'+NL;
    btn_11.Hint := 'Print The Product Tree'+NL;
    btn_12.Hint := 'Open The Sales Record. Sales Record Will Be Opened In Read-Only Mode'+NL;
    btn_13.Hint := 'Complete and Convert The Sales Order of Selected Process To Invoice'+NL;
    btn_14.Hint := 'Make a Partial Invoice for The Sales Order of Selected Process'+NL;

    btn_1.ShowHint := True;
    btn_2.ShowHint := True;
    btn_3.ShowHint := True;
    btn_4.ShowHint := True;
    btn_5.ShowHint := True;
    btn_6.ShowHint := True;
    btn_7.ShowHint := True;
    btn_8.ShowHint := True;
    btn_9.ShowHint := True;
    btn_10.ShowHint := True;
    btn_11.ShowHint := True;
    btn_12.showhint := True;
    btn_13.showhint := True;
    btn_14.showhint := True;


end;
Procedure TfmBarCodeManufacturing.ProcessBarcodeStopAllnLogoff;
var
  //ClockedRoster : TClockedRoster;
  dHours :Double;
  dtClockTime:TDateTime;
begin
  dtClockTime:=now;
  if not(Assigned(fEmployee)) or (fEmployee.ID=0) then exit;
  if QryJobs.RecordCount> 0  then begin
      grdJobs.selectAll;
      ProcessBarcodeStop;
  end;

  if Appenv.companyprefs.AutoclockOnemployeeOnjob then begin
      if (ClockedRoster.count >0) then begin
          if ClockedRoster.CurrentRosterBreak.Count >0 then begin
            ClockedRoster.CurrentRosterBreak.endtime := now;
            ClockedRoster.CurrentRosterBreak.PostDB;
          end;
          dHours := HourSpan(dtClockTime, ClockedRoster.StartTime);
          ClockedRoster.EndTime:= dtClockTime;
          ClockedRoster.Hours := Round(dHours,4);
          ClockedRoster.PostDB;
          TimerMsg(lblMsg , sEmployeename + ' is logged out');
      end;
  end;
  fEmployee.Load(0);
  ClockedRoster;
  edtBarcodeInput.text := '';
  SetControlfocus(edtBarcodeInput);
end;
procedure TfmBarCodeManufacturing.ProcessBarcodeStopAll;
begin
  if not fbCanStopanyManufacturingJob then begin
      Commonlib.MessageDlgXP_Vista('You Are Not Given Access To ''Stop Any Manufacturing Job'' ' , mtInformation , [mbok] , 0);
  end;
  ProcessBarcodeChangeStatus(STOPALL, ProcessBarcodeStopAll);
end;

procedure TfmBarCodeManufacturing.ProcessBarcodeStopAll(  PPT: TProcessPartTimesheet; ProcessPartID: Integer);
begin
  PPt.LoadSelect(' ProcessPartID = ' +IntToStr(ProcessPartID)+
                    ' and ifnull(Timeend,0) = 0');
  if PPT.count >=1 then begin
    PPT.First;
    While PPT.Eof = False do begin
      PPT.Connection.BeginNestedTransaction;
      PPt.Timeend := timestart;
      if PPt.Save then begin
        PPT.Connection.CommitNestedTransaction;
      end else PPT.Connection.RollbackNestedTransaction;
      PPT.Next;
    end;
  end;

end;

procedure TfmBarCodeManufacturing.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmBarCodeManufacturing.btnCustomiseClick(Sender: TObject);
var
  form : TfmBarCodeManufacturingCustomise;
begin
  inherited;
    form := TfmBarCodeManufacturingCustomise.Create(Self);
    try
      form.ShowModal;
      if form.ModalResult = mrok then
        AlignButtons;
    finally
      freeandNil(form);
    end;

end;

procedure TfmBarCodeManufacturing.btnSelectallClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TClockedOnListGUI' ,OnEmployeeSelect);
end;
procedure TfmBarCodeManufacturing.OnJobSelect(Sender: TwwDbGrid);
begin
  if Assigned(Sender.Datasource) then
    if Assigned(Sender.Datasource.Dataset) then
      if Sender.Datasource.Dataset.Findfield('SaleId')<> nil then
        ProcessSales(Sender.Datasource.Dataset.Findfield('SaleId').asString);
end;

procedure TfmBarCodeManufacturing.OnEmployeeSelect(Sender: TwwDbGrid);
begin
  if Assigned(Sender.Datasource) then
    if Assigned(Sender.Datasource.Dataset) then
      if Sender.Datasource.Dataset.Findfield('EmployeeID')<> nil then
        ProcessEmployee(Sender.Datasource.Dataset.Findfield('EmployeeID').asString);

end;

class procedure TfmBarCodeManufacturing.OpenForsale(const fsaleID: Integer);
var
  form :TfmBarCodeManufacturing;
begin
  form := TfmBarCodeManufacturing(GetComponentByClassName('TfmBarCodeManufacturing' , true));
  if not(Assigned(Form)) then exit;
  if form.Visible then begin
    MessageDlgXP_Vista(form.titleLabel.Caption+' Is Already Opened.  Please Close This To Open For Sale#' +IntToStr(fSaleID) +'.' , mtWarning, [mbok],0);
    Form.BringToFront;
    Exit;
  end;
  form.FormStyle := fsMDIChild;
  form.BringToFront;
  form.ProcessEmployee(IntToStr(appenv.Employee.employeeId));
  form.Processsales(IntToStr(fSaleID));
  Setcontrolfocus(form.edtBarcodeInput);
end;

procedure TfmBarCodeManufacturing.actBreakUpdate(Sender: TObject);
begin
  inherited;
  actbreak.Enabled := Assigned(fEmployee) and (fEmployee.ID>0);
end;

procedure TfmBarCodeManufacturing.actCommentsUpdate(Sender: TObject);
begin
  inherited;
  actComments.Enabled := Assigned(fSalesOrder) and (fSalesOrder.ID>0);
end;

procedure TfmBarCodeManufacturing.actEmployeesExecute(Sender: TObject);
begin
  inherited;
  TfmListnLookupLarge.MakeListnLookup('TEmployeeExpresslistGUI' , 'EmployeeshortName' , nil ,nil , OnEmployeeSelect);
  //TfrmEmployeeList.ShowLookuplist(OnEmployeeSelect);
end;

procedure TfmBarCodeManufacturing.actHistoryUpdate(Sender: TObject);
begin
  inherited;
  actHistory.Enabled := Assigned(fEmployee) and (fEmployee.ID>0);
end;

procedure TfmBarCodeManufacturing.actJobsExecute(Sender: TObject);
begin
  inherited;
  //TBOMSalesListGUI.ShowLookuplist(OnJobSelect);
  //OpenERPListFormSingleselect('TBOMSalesListGUI' , OnJobSelect ,BeforeShowJobSelect,  AfterShowJobSelect);
  TfmListnLookupLarge.MakeListnLookup('TBOMSalesListGUI' , 'SaleID' ,BeforeShowJobSelect, AfterShowJobSelect , OnJobSelect );
end;
procedure TfmBarCodeManufacturing.BeforeShowJobSelect(Sender: TObject);
begin
  if not(Sender is TBOMSalesListGUI) then exit;
  TBOMSalesListGUI(Sender).chkIgnoreDates.checked:= true;
  TBOMSalesListGUI(Sender).DtFrom.Date := TBOMSalesListGUI(Sender).filterdateFrom;
  TBOMSalesListGUI(Sender).DtTo.Date := TBOMSalesListGUI(Sender).filterdateTo;
  TBOMSalesListGUI(Sender).fbDateRangeSupplied := True;
end;
procedure TfmBarCodeManufacturing.AfterShowJobSelect(Sender: TObject);
begin
  if not(Sender is TBOMSalesListGUI) then exit;
  TBOMSalesListGUI(Sender).FilterString := 'Converted =' +Quotedstr('F')+' and not( Status =' +QuotedStr('psComplete')+')';
  if Appenv.Companyprefs.OnlyshowScheduledJobsForBarCodeMan then begin
    TBOMSalesListGUI(Sender).grpFilters.Enabled := False;
    TBOMSalesListGUI(Sender).ListTimerMsg('List is Only Showing The Scheduled Jobs. Please Change the Preferance to See All Jobs' ,nil,  30);
    TBOMSalesListGUI(Sender).FilterString := TBOMSalesListGUI(Sender).FilterString +' and  Status like' +QuotedStr('%psScheduled%');
  end else begin
    TBOMSalesListGUI(Sender).grpFilters.Enabled := True;
    TBOMSalesListGUI(Sender).ListTimerMsg('List is Showing All Jobs. ie: Scheduled, Unshceduled and Completed.'+NL+'Please Change the Preferance to show Only Scheduled Jobs', nil, 30);
  end;

(*  TBOMSalesListGUI(Sender).chkIgnoreDates.checked:= true;
  TBOMSalesListGUI(Sender).SearchMode := smFullList;
  TBOMSalesListGUI(Sender).RefreshQuery;*)

end;
procedure TfmBarCodeManufacturing.actLogOffUpdate(Sender: TObject);
begin
  inherited;
  actLogOff.Enabled := Assigned(fEmployee) and (fEmployee.ID>0);
end;

procedure TfmBarCodeManufacturing.actSelectallExecute(Sender: TObject);
begin
  inherited;
  grdJobs.SelectAll;
  SetControlFocus(edtBarcodeInput);

end;

procedure TfmBarCodeManufacturing.actPrintcontrolcodesExecute(
  Sender: TObject);
var
  strSQL:string;
begin
  inherited;
  DisableForm;
  try
    inherited;
    strSQL:= '{compinfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
              'CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber,  ' +
              'CO.FaxNumber AS FaxNumber, CO.ABN  ' +
              'FROM tblCompanyInformation AS CO   ' +
              '~|||~{Barcodes}  ' +
              ' Select ' +quotedStr(SCHEDULE)           +'  as BarCode union ' +
              ' Select ' +quotedStr(START)              +'  as BarCode union ' +
              ' Select ' +quotedStr(STOP)               +'  as BarCode union ' +
              ' Select ' +quotedStr(STOPALL)            +'  as BarCode union ' +
              ' Select ' +quotedStr(COMPLETE)           +'  as BarCode union ' +
              ' Select ' +quotedStr(UNSCHEDULE)         +'  as BarCode union ' +
              ' Select ' +quotedStr(OPENSALE)           +'  as BarCode union ' +
              ' Select ' +quotedStr(PRODUCTTREE)        +'  as BarCode union ' +
              ' Select ' +quotedStr(PRINTPICKING)       +'  as BarCode union ' +
              ' Select ' +quotedStr(PRODUCTIONWORKSHEET)+'  as BarCode union ' +
              ' Select ' +quotedStr(COMPLETEINVOICE)    +'  as BarCode ';
    fbReportSQLSupplied := True;
    PrintTemplateReport(GetReportNameForTypeName('Barcodes(Manufacturing)'), strSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
    fbReportSQLSupplied := False;
  finally
    EnableForm;
  end;

end;
Function TfmBarCodeManufacturing.QryjobsSQL:String;
begin
Result := 'SELECT  distinct '+NL+
          ' S.isinternalorder, '+NL+
          ' S.SaleID, '+NL+
          ' S.InvoiceDocNumber, '+NL+
          ' S.customername, '+NL+
          ' S.SaleDate, '+NL+
          ' S.class, '+NL+
          ' pp.ID, '+NL+
          ' SL.ProductId, '+NL+
          ' TreeNodeCaption(pt.Level, pt.Caption) AS caption, '+NL+
          ' pt.caption Name, '+NL+
          ' PT.info , '+NL+
          ' sl.SaleLineId, '+NL+
          ' sl.ProductName as LineProductName, '+NL+
          ' sl.Product_Description as LineProductDescription, '+NL+
          ' sl.UnitOfMeasureShipped as LineQty, '+NL+
          ' IFNULL((Select SUM(ifnull(SOIL.uomQty,0))  '+
                    ' FROM tblsalesOrderInvoices SOI '+
                    ' INNER JOIN  tblsalesOrderInvoiceLines SOIL on SOIL.SOInvoiceID = SOI.SOINvoiceID '+
                    ' WHERE S.saleId = SOI.salesorderID  and SOIL.SalesorderLineID = SL.SaleLineID) ,0) +   '+NL+
          ' IFNULL((SELECT SUM(invl.UnitOfMeasureShipped) '+
                    ' FROM tblsales inv '+
                    ' INNER JOIN tblsaleslines invl ON inv.saleId = invl.saleId '+
                    ' WHERE trim(ifnull(inv.salesorderglobalref,"")) = trim(S.globalref)),0) as Partiallyinvoiced, ' +NL+
          ' pt.ManufacturingUOMQty, '+NL+
          ' pt.ManufactureUOMQty, '+NL+
          ' pt.manufactureduomqty, '+NL+
          ' pt.totalqty, '+NL+
          ' sl.ShipDate as LineShipDate, '+NL+
          ' pt.ProcTreeId ,'+NL+
          ' PT.Complete , '+NL+
          ' Ps.Description as Process, '+NL+
          ' if(ifnull(pp.Status,"") = "" , "From Stock" , pp.status) as Status, '+NL+
          ' pp.Duration , '+NL+
          ' pp.SetupDuration , '+NL+
          ' pp.BreakdownDuration, '+NL+
          ' convert(if(ifnull(ppt.ID,0) = 0 , pp.TimeStart, ppt.timestart),DateTime) as Timestart, '+NL+
          ' convert(if(if(ifnull(pp.Status,"") = "" , "From Stock" , pp.status)="psComplete" , '+
                    ' (Select Max(TimeEnd) '+
                    ' from tblProcessParttimesheet xppt '+
                    ' where xppt.ProcessPartID = pp.Id and xppt.Active = "T"),0),DateTime)  as TimeEnd, '+NL+
          ' pp.ProcessStepSeq, '+NL+
          ' ppt.ID as PPTID, '+NL+
          ' pt.TreeRootId ,  '+NL+
          ' PP.ProcessStepId, '+NL+
          ' if (pt.TreeRootId =pt.proctreeID, "T" , "F") AS isroot, '+NL+
          ' (Select min(Timestart)  '+
                ' from tblProcesstime PPt  '+
                ' where PPt.ProcessPartId = pp.ID) as ProcesstimeStart, '+NL+
          ' ppt1.Comment, '+NL+
          ' ppt1.id as pptid1, '+NL+
          ' if(ifnull(cpt.proctreeid,0)<> 0 , "T", "F") IsSubBOM, '+NL+
          ' if(S.saleID = ' + inttostr(Salesorder.ID) +', "T", "F") as IsJoboftheCurrentsale '+NL+
          ' FROM  tblSales s '+NL+
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId and (SL.BOMGroupedLine ="F" or SL.BOMProductionLine ="T" ) '+NL+
          ' inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId '+NL+
          ' LEFT JOIN tblProcTree cpt ON pt.proctreeid = cpt.parentId '+NL+
          ' and pt.MasterType = "mtSalesOrder" '+NL+
          ' Inner join tblProcessPart pp on pp.ProcTreeId = Pt.ProcTreeId '+NL+
          ' Inner join tblProcessStep Ps on Ps.Id = PP.ProcessStepId '+NL+
          ' LEFT join tblProcessParttimesheet ppt  on ppt.ProcessPartID  = pp.Id and ppt.employeeId  = ' + inttostr(Employee.ID) +' and ifnull(PPT.TimeEnd,0) = 0 and ppt.Active = "T" '+NL+
          ' LEFT JOIN tblProcessParttimesheet ppt1 on ppt1.ProcessPartID = pp.Id and ppt1.employeeId = ' + inttostr(Employee.ID) +' and ppt1.Active = "T" '+NL+
          ' where S.converted = "F" and (s.saleid = ' + inttostr(Salesorder.ID) +' or ppt.employeeId = ' + inttostr(Employee.ID) +') and pt.totalQty<>0 '+NL+
          ' order by sl.SaleLineId, pt.ProcTreeId , pp.ProcessStepSeq';

REsult :=  'Select '+NL+
          '  CONVERT( @rownum:=if(@SaleLineId <> details.SaleLineId,  @rownum:= 1 ,  @rownum+1), unsigned) rownum  ,'+NL+
          '  @SaleLineId := details.SaleLineId,'+NL+
          '  details.*'+NL+
          '  from ('+result +') as Details ' ;

    clog(Result);
end;
{$WARNINGS ON}
{$HINTS ON}

initialization

  RegisterClassOnce(TfmBarCodeManufacturing);

end.





