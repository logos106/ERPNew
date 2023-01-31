unit frmBarcodePicking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Grids,
  Wwdbigrd, Wwdbgrid, Shader, AdvEdit, DNMPanel, BusObjEmployeeDetails, BusObjPickingAssembly, BusObjBase, IntegerListObj,
  wwcheckbox, Buttons;

const
    Barcode_Prefix_Pick = 'PICK';
    Barcode_Prefix_Pack = 'PACK';
    Barcode_Prefix_Dispatch = 'D'; {ie: P-START or P-[SaleID]-[PackNo]}
    Barcode_Start       = 'START';
    Barcode_Stop        = 'STOP';
    Barcode_NewPack     = 'NEWPACK';

type
  TPickingState =(tNew=0,tLoggedin=1,tPackingfinished=2,tSaleSelected=3,tPickingStarted=4,tPickingfinished=5,tPackingStarted=6,tDispatchStarted=7,tDispatchFinished=8);

  TFickingFormMode = (fmPickPack, fmDispatch);

  TfmBarcodePicking = class(TBaseInputGUI)
    dspickingassemblyentry: TDataSource;
    Qrypickingassemblyentry: TERPQuery;
    QrypickingassemblyentryGlobalRef: TWideStringField;
    QrypickingassemblyentryPickingAssemblyEntryID: TIntegerField;
    QrypickingassemblyentrySaleID: TIntegerField;
    QrypickingassemblyentryBarcode: TWideStringField;
    QrypickingassemblyentryPickingEmployeeID: TIntegerField;
    QrypickingassemblyentryStartPicking: TWideStringField;
    QrypickingassemblyentryStartPickingTime: TDateTimeField;
    QrypickingassemblyentryFinishedPicking: TWideStringField;
    QrypickingassemblyentryFinishedPickingTime: TDateTimeField;
    QrypickingassemblyentryPackingEmployeeID: TIntegerField;
    QrypickingassemblyentryStartPacking: TWideStringField;
    QrypickingassemblyentryStartPackingTime: TDateTimeField;
    QrypickingassemblyentryFinishedPacking: TWideStringField;
    QrypickingassemblyentryFinishedPackingTime: TDateTimeField;
    QrypickingassemblyentryEditedFlag: TWideStringField;
    QrypickingassemblyentrymsTimeStamp: TDateTimeField;
    QrypickingassemblyentrymsUpdateSiteCode: TWideStringField;
    dspickingassemblyentrylines: TDataSource;
    Qrypickingassemblyentrylines: TERPQuery;
    QrypickingassemblyentrylinesGlobalRef: TWideStringField;
    QrypickingassemblyentrylinesPickingAssemblyentrylinesID: TIntegerField;
    QrypickingassemblyentrylinesPickingAssemblyEntryID: TIntegerField;
    QrypickingassemblyentrylinesProductID: TIntegerField;
    QrypickingassemblyentrylinesProductName: TWideStringField;
    QrypickingassemblyentrylinesDescription: TWideStringField;
    QrypickingassemblyentrylinesQty: TFloatField;
    QrypickingassemblyentrylinesQtyMultiplier: TFloatField;
    QrypickingassemblyentrylinesUOM: TWideStringField;
    QrypickingassemblyentrylinesUOMID: TIntegerField;
    QrypickingassemblyentrylinesPackNumber: TIntegerField;
    QrypickingassemblyentrylinesEditedFlag: TWideStringField;
    QrypickingassemblyentrylinesmsTimeStamp: TDateTimeField;
    QrypickingassemblyentrylinesmsUpdateSiteCode: TWideStringField;
    pnlMaster: TDNMPanel;
    lblEmployee: TLabel;
    lblEmployeeName: TLabel;
    Label1: TLabel;
    lblSale: TLabel;
    Label3: TLabel;
    lbPickStart: TLabel;
    lblPickStart: TLabel;
    lbPickfinish: TLabel;
    lblPickFinish: TLabel;
    lbPackstart: TLabel;
    lblPackStart: TLabel;
    lbPackfinish: TLabel;
    lblPackFinish: TLabel;
    lblSale2: TLabel;
    imgProduct: TImage;
    Label2: TLabel;
    Label4: TLabel;
    lblLastProduct: TLabel;
    lblCountSummary: TLabel;
    edtBarcodeInput: TEdit;
    edtQty: TAdvEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlDetail: TDNMPanel;
    pnlButtons: TDNMPanel;
    Label7: TLabel;
    btnStartNewPicking: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnConNote: TDNMSpeedButton;
    btnControlBarCodes: TDNMSpeedButton;
    dsSalesSummary: TDataSource;
    QrySalesSummary: TERPQuery;
    QrySalesSummaryproductId: TIntegerField;
    QrySalesSummaryproductname: TWideStringField;
    QrySalesSummaryProductDescription: TWideStringField;
    QrySalesSummarytotalshipped: TFloatField;
    QrySalesSummaryQtyBackorder: TFloatField;
    QrySalesSummaryQtyPacked: TFloatField;
    QrySalesSummaryUOM: TWideStringField;
    QrySalesSummaryUOMId: TIntegerField;
    lblStatus: TLabel;
    QrySalesSummaryUOMMultiplier: TFloatField;
    QrypickingassemblyentrylinesSaleID: TIntegerField;
    QrySalesSummaryQtyRequired: TFloatField;
    btnCompleted: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    QrypickingassemblyentryCreatedOn: TDateTimeField;
    cmdPrint: TDNMSpeedButton;
    btnPickingStatusreport: TDNMSpeedButton;
    pnlSummary: TDNMPanel;
    grdSalesSummary: TwwDBGrid;
    pnlSummaryHeader: TDNMPanel;
    Label5: TLabel;
    lblPacknoCaption: TLabel;
    lblPackno: TLabel;
    lblPackSummaryClickInstructions: TLabel;
    Splitter1: TSplitter;
    QrypickingassemblyentryDispatchingEmployeeID: TIntegerField;
    QrypickingassemblyentryStartDispatch: TWideStringField;
    QrypickingassemblyentryStartDispatchTime: TDateTimeField;
    QrypickingassemblyentryFinishedDispatch: TWideStringField;
    QrypickingassemblyentryFinishedDispatchTime: TDateTimeField;
    lbDispatchStart: TLabel;
    lblDispatchStart: TLabel;
    lbDispatchFinish: TLabel;
    lblDispatchFinish: TLabel;
    qryToBeDispatched: TERPQuery;
    dsToBeDispatched: TDataSource;
    grdToBeDispatched: TwwDBGrid;
    dsDispatched: TDataSource;
    qryDispatched: TERPQuery;
    rgScanSummary: TRadioGroup;
    QrypickingassemblyentrylinesDispatched: TWideStringField;
    pnlPacked: TDNMPanel;
    grdpickingassemblyentrylines: TwwDBGrid;
    grdDispatched: TwwDBGrid;
    chkAutoPopUpBarcodePickingOptions: TwwCheckBox;
    grdpickingassemblyentrylinesIButton: TwwIButton;
    procedure edtBarcodeInputExit(Sender: TObject);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtBarcodeInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdSalesSummaryDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartNewPickingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtQtyExit(Sender: TObject);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtyEnter(Sender: TObject);
    procedure grdpickingassemblyentrylinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DevmodeBtnclick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure grdSalesSummaryCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdpickingassemblyentrylinesEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure QrypickingassemblyentrylinesAfterInsert(DataSet: TDataSet);
    procedure btnControlBarCodesClick(Sender: TObject);
    procedure QrypickingassemblyentrylinesAfterOpen(DataSet: TDataSet);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnPickingStatusreportClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConNoteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QrypickingassemblyentrylinesAfterPost(DataSet: TDataSet);
    procedure rgScanSummaryClick(Sender: TObject);
    procedure grdToBeDispatchedDblClick(Sender: TObject);
    procedure pnlPackedResize(Sender: TObject);
    procedure pnlSummaryResize(Sender: TObject);
    procedure chkAutoPopUpBarcodePickingOptionsClick(Sender: TObject);
    procedure grdpickingassemblyentrylinesIButtonClick(Sender: TObject);
  private
    ProcessingBarcode:Boolean;
    PickAssemEntry : TPickAssemEntry;
    CurrentEmployee: TEmployeeDetails;
    fiSaleID :Integer;
    fiEmployeeId :Integer;
    fiPackNumber:Integer;
    Status: String;
    AllLinesOk :Boolean;
    Qtypacked:double;
    ConvertedSOInvoiceID :Integer;
    fpickingstate :Tpickingstate;
    fbShowingPickQtyonEdit :Boolean;
    fiSaleIDToPick : Integer;
    fiLinesID:Integer;
    ProductsSelected : TIntegerlist;
    fFormMode: TFickingFormMode;
    procedure ProcessBarcode(const codeStr: string);
    procedure NewPickAssembly(const EmployeeID: Integer =0);
    function Savechanges: Boolean;
    procedure SetEmployeeID(const Value: Integer);
    procedure setsaleID(const Value: Integer);
    procedure setPackNumber(const Value: Integer);
    procedure UpdateDisplay;
    function Savencommit(Doconifrm:Boolean = False;Printwhennotdirty :boolean =False): Boolean;
    Procedure InitForm;
    procedure EnablePick(const Value: Boolean);
    procedure ShowPickQtyonEdit(const Movefocus :Boolean = true; const initdone:boolean =True);
    Procedure ProcessQty;
    procedure ProcessQuantity(const fdQty: double);
    function AllPickingDone: boolean;
    procedure PickingDonecheckCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure setpickingstate(const Value: Tpickingstate);
    procedure RefreshLines;
    function AllPickedforSaleProduct: Boolean;
    procedure ReadnApplyGuiPrefExtra;
    Procedure WriteGuiPrefExtra;
    Procedure checkRecordAccess;
    procedure initSalesPickedQtyreport(sender: TObject);
    Procedure DostartNew(EmpID:Integer);
    function GetNextPickingSlipSaleID: integer;
    Procedure DoPrintsale;
    Procedure DoPrintPick;
    procedure PrintDeliveryDocket;
    procedure PrintPickingConNote;
    function ModifySale: boolean;
    procedure PrintInvoice(const SaleID: integer);
    function ConvertedSale(const Value: Integer): Boolean;
    procedure SetFormMode(const Value: TFickingFormMode);
    property FormMode: TFickingFormMode read fFormMode write SetFormMode;
    procedure PrintDispatchLables;
    function PrintReports: boolean;
  Protected
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure AfterFinishProcess(Printsale, PrintDeldocket, PrintCNode, printPick, printDispatch: Boolean);
    Property EmployeeID :Integer read fiEmployeeId write SetEmployeeID;
    Property SaleId :Integer read fiSaleID write setsaleID;
    Property PackNumber:Integer read fiPackNumber Write setPackNumber;
    Property pickingstate :TPickingState read fpickingstate Write setpickingstate;
    Property SaleIDToPick :Integer read fiSaleIDToPick write fiSaleIDToPick;
  end;

implementation

uses CommonLib, BusObjConst, FastFuncs, Barcodeconst, AppEnvironment,Dateutils,
  tcDataUtils, BusObjSales, BusObjStock, tcConst, frmBarcodeAfterPacked,
  FormFactory, CommonFormLib, SalesPickedQty, CommonDbLib,
  frmBarcodePickingConNoteEdit, frmPrintPickingSlips, ProductQtyLib,
  frmREportingOptions, BusObjUOM, JSONObject, PreferancesLib,
  PrintPickingSlipsLib;

{$R *.dfm}
function TfmBarcodePicking.AllPickingDone: boolean;
begin
  AllLinesOk:= True;
  PickAssemEntry.SalesSummaryLineForPacking.IterateRecords(PickingDonecheckCallback);
  Result:=AllLinesOk;
end;
function TfmBarcodePicking.AllPickedforSaleProduct:Boolean;
begin
    Qtypacked:= 0;
    PickAssemEntry.Lines.IterateRecords(PickingDonecheckCallback);
    result :=Qtypacked = (PickAssemEntry.SalesSummaryLineForPacking.QtyRequired + PickAssemEntry.SalesSummaryLineForPacking.QtyPacked);
end;
procedure TfmBarcodePicking.PickingDonecheckCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TSalesSummaryLineForPackingforGUI then begin
    if not(AllPickedforSaleProduct) then begin
      Abort := True;
      AllLinesOk:= False;
    end;
  end else if sender is TPickAssemEntrylines then begin
    if (TPickAssemEntrylines(Sender).productId =   PickAssemEntry.SalesSummaryLineForPacking.ProductId) and (TPickAssemEntrylines(Sender).SaleID =   PickAssemEntry.SaleID) then
      Qtypacked:= Qtypacked + TPickAssemEntrylines(Sender).Qty;
  end;
end;
procedure TfmBarcodePicking.pnlPackedResize(Sender: TObject);
begin
  inherited;
  grdDispatched.Height := grdDispatched.Parent.Height Div 2;
  grdToBeDispatched.Height := grdToBeDispatched.Parent.Height Div 2;
end;

procedure TfmBarcodePicking.pnlSummaryResize(Sender: TObject);
begin
  inherited;
  grdDispatched.Height := grdDispatched.Parent.Height Div 2;
  grdToBeDispatched.Height := grdToBeDispatched.Parent.Height Div 2;
end;

procedure TfmBarcodePicking.btnCancelClick(Sender: TObject);
begin
  inherited;
  self.AddFlag('Canceling');
  try
    self.Close
  finally
    self.RemoveFlag('Canceling');
  end;
end;

procedure TfmBarcodePicking.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(Savencommit) then exit;
  Self.close;
end;

procedure TfmBarcodePicking.btnConNoteClick(Sender: TObject);
begin
  inherited;
  if Assigned(PickAssemEntry.Sale) then begin
    self.BeginTransaction;
    if UpdateSaleConsignmentDetails(PickAssemEntry.Sale) then begin
      PickAssemEntry.Sale.PostDB;
      self.CommitTransaction;
    end
    else begin
      self.RollbackTransaction;
    end;
  end;
  edtBarcodeInput.SetFocus;
end;

procedure TfmBarcodePicking.btnControlBarCodesClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    inherited;
    PrintTemplateReport('Pick and Pack Control Barcodes', '', not(appEnv.Employee.PreviewAllreport), 1);
  finally
    EnableForm;
  end;
end;

procedure TfmBarcodePicking.btnDeleteClick(Sender: TObject);
var
  fAccesslevel:Integer;
begin
  inherited;
  if MessageDlgXP_vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  fAccesslevel:= Accesslevel;
  try
    Accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
    if accesslevel <> 1 then begin
      MessageDlgXP_Vista('You don''t have access to delete', mtWarning, [mbOK], 0);
      Exit;
    end;
    if PickAssemEntry.count >0 then begin
      PickAssemEntry.connection.beginnestedTransaction;
      if not PickAssemEntry.Delete then begin
        PickAssemEntry.connection.RollbacknestedTransaction;
        exit;
      end else PickAssemEntry.connection.commitnestedTransaction;
      PickAssemEntry.connection.CommitTransaction;
    end;
  finally
    Accesslevel := fAccesslevel;
  end;

  PickAssemEntry.connection.beginTransaction;
  KeyId :=0;
  initform;
  SetcontrolFocus(edtBarcodeInput);
end;

procedure TfmBarcodePicking.btnPickingStatusreportClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
       OpenERPListFormModal('TSalesPickedQtyGUI' , nil, initSalesPickedQtyreport)
  else OpenERPListForm('TSalesPickedQtyGUI' , initSalesPickedQtyreport);
end;
Procedure TfmBarcodePicking.initSalesPickedQtyreport(sender :TObject);
begin
  if not(Sender is TSalesPickedQtyGUI) then exit;
  TSalesPickedQtyGUI(Sender).SaleId :=  PickAssemEntry.saleID;
end;

procedure TfmBarcodePicking.btnStartNewPickingClick(Sender: TObject);
var
  i :Integer;
begin
  inherited;
  if not Savencommit(true) then exit;
  i := fiEmployeeID;
  KeyID := 0;
  initform;
  SetcontrolFocus(edtBarcodeInput);
  if i =0 then begin
    MessageDlgXP_vista('Please do the Employee Login', mtWarning, [mbOK], 0);
    Exit;
  end;
  DoStartNew(i);
end;

procedure TfmBarcodePicking.checkRecordAccess;
begin
  if PickAssemEntry.ID>0 then begin
    if ((not AppEnv.CompanyPrefs.UseBarcodeDispatch) and PickAssemEntry.finishedPacking) or
      (AppEnv.CompanyPrefs.UseBarcodeDispatch and PickAssemEntry.finishedDispatch) then begin
      Accesslevel := 5;
      MessageDlgXP_Vista('This is already finished packing.'+NL+NL+'Access is changed to Read-Only', mtWarning, [mbok] , 0);
    end else if  PickAssemEntry.Converted then begin
      Accesslevel := 5;
      MessageDlgXP_Vista('This Sale Record is already converted.'+NL+NL+'Access is changed to Read-Only', mtWarning, [mbok] , 0);
    end else if not PickAssemEntry.lock then begin
      Accesslevel := 5;
      MessageDlgXP_Vista( replacestr(PickAssemEntry.Userlock.LockMessage , 'Unable to update data.', 'Unable to Pick ' + PickAssemEntry.Sale.xmlnodename +'#' + inttostr(PickAssemEntry.SaleID)+'.')+NL+NL+'Access is changed to Read-Only', mtWarning, [mbok] , 0);
    end else begin
      Accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
      if AccessLevel = 3 then begin
        if KeyID = 0 then begin
          AccessLevel := 2;
        end else begin
          AccessLevel := 5;
        end;
      end;
    end;
  end else begin
      Accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
      if AccessLevel = 3 then begin
        if KeyID = 0 then begin
          AccessLevel := 2;
        end else begin
          AccessLevel := 5;
        end;
      end;
  end;
    btnStartNewPicking.Enabled :=AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName)<=3 ;
    btnCompleted.Enabled := accesslevel <=2;
    edtBarcodeInput.readonly := accesslevel > 2;
    edtQty.readonly := accesslevel > 2;
         if (accesslevel<=2) and (PickAssemEntry.lines.count>0) then Setcontrolfocus(edtQty)
    else if (accesslevel<=2) and (PickAssemEntry.SalesSummaryLineForPacking.count>0) then Setcontrolfocus(grdSalesSummary)
    else if (KeyId =0) and (accesslevel<=2)  then Setcontrolfocus(edtBarcodeInput)
    else if btnStartNewPicking.Enabled Then Setcontrolfocus(btnStartNewPicking);
    pnlSummary.visible := accesslevel <=2;
    Splitter1.visible := accesslevel <=2;
end;

procedure TfmBarcodePicking.chkAutoPopUpBarcodePickingOptionsClick(
  Sender: TObject);
begin
  inherited;
  if chkAutoPopUpBarcodePickingOptions.Focused then begin
    AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions := chkAutoPopUpBarcodePickingOptions.Checked;
    PreferancesLib.DoPrefAuditTrail;
  end;
end;

procedure TfmBarcodePicking.cmdPrintClick(Sender: TObject);
begin
  inherited;

  PrintReports;

end;

procedure TfmBarcodePicking.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TPickAssemEntry                     then TPickAssemEntry(Sender).Dataset                  := Qrypickingassemblyentry
    else if Sender is TPickAssemEntrylines                then TPickAssemEntrylines(Sender).Dataset             := Qrypickingassemblyentrylines
    else if Sender is TSalesSummaryLineForPackingforGUI   then TSalesSummaryLineForPackingforGUI(Sender).Dataset:= QrySalesSummary;
  end else if Eventtype = BusObjEvent_Error then begin
    if devmode then MessageDlgXP_vista(Value, mtWarning, [mbOK], 0);
  end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and not(sametext(value , BusObjEventDataset_dataIdchange_dcClose)) and (Sender is TPickAssemEntrylines) then begin
//    ShowPickQtyonEdit(true , False);
      ShowPickQtyonEdit(false , False);
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_closeBarcodeSummary) then begin
    closedb(QrySalesSummary);
  end;
end;

procedure TfmBarcodePicking.ShowPickQtyonEdit(const Movefocus :Boolean = true; const initdone:boolean =True);
begin
  if fbShowingPickQtyonEdit then exit;
  fbShowingPickQtyonEdit := True;
  try
    if (AppEnv.CompanyPrefs.UseBarcodeDispatch and PickAssemEntry.finishedPacking) then exit;

    edtQty.text := FloatTostrF(PickAssemEntry.Lines.Qty , ffGeneral, 15,2);
    fiLinesID:= PickAssemEntry.Lines.ID;
    if fiLinesID >0 then begin
      edtQty.hint := 'This is the Qty picking on the selected Line. ' +
                      'Please change to Pick a different Quantity.';
      if Appenv.companyprefs.AllowToPickFromOthersalesIntheGroup  then
        edtQty.hint :=  edtQty.hint + NL +'If the Quantity given is more than the ''shipped Quantity'' of the Sales Line, the rest of the Quantity will be picked from the other sales of the group';
      if Appenv.companyprefs.AllowtoshipnPickFromBackorderinthegroup then
        edtQty.hint :=  edtQty.hint + NL +'If the Quantity given is more than the total of ''shipped Quantity'' of all the Sales of the group for the product, and if any backorder exists for the product, it will be shipped and picked from the backorder';
      edtQty.hint :=  edtQty.hint + NL ;
      edtQty.showhint := true;
    end else begin
      edtQty.showhint := False;
    end;

    if Movefocus then Setcontrolfocus(edtQty);
  finally
    fbShowingPickQtyonEdit := False;
  end;
end;
procedure TfmBarcodePicking.edtBarcodeInputExit(Sender: TObject);
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

procedure TfmBarcodePicking.edtBarcodeInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtBarcodeInput.Modified:= true;
end;

procedure TfmBarcodePicking.edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
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

procedure TfmBarcodePicking.edtQtyEnter(Sender: TObject);
begin
  inherited;
  if PickAssemEntry.Lines.id =0 then Setcontrolfocus(edtBarcodeInput);
end;


function ISValidQuantity(s: string): boolean;
begin
  result := Length(s) < 7;
  if result then begin
    try
      StrToFloat(s);
    except
      result := false;
    end;
  end;
end;

procedure TfmBarcodePicking.edtQtyExit(Sender: TObject);
begin
  inherited;
  if edtQty.Modified then begin
    if not ISValidQuantity(edtQty.Text) then begin
      edtQty.Modified := false;
      edtBarcodeInput.Text := edtQty.Text;
      edtBarcodeInput.Modified := true;
      edtBarcodeInput.OnExit(edtBarcodeInput);
      exit;
    end;

    edtQty.Modified:= false;
    ProcessQty;
  end;
end;

procedure TfmBarcodePicking.edtQtyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtQty.Modified:= true;

end;

procedure TfmBarcodePicking.edtQtyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
    Key := #0;   // eat VK_RETURN
    ProcessQty;
    Key := #0;
  end;
end;

procedure TfmBarcodePicking.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TfmBarcodePicking.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPrefExtra;
  inherited;
  action := cafree;
end;

procedure TfmBarcodePicking.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  canclose := Savencommit(true);
end;

procedure TfmBarcodePicking.FormCreate(Sender: TObject);
begin
  ProductsSelected := TIntegerlist.create;
  inherited;
  fiLinesID:=0;
  lblLastProduct.Caption:= '';
  Self.WindowState := wsMaximized;
  PickAssemEntry := TPickAssemEntry.Create(self);
  PickAssemEntry.Connection := TMyDacDataConnection.Create(PickAssemEntry);
  PickAssemEntry.Connection.Connection := Self.MyConnection;
  PickAssemEntry.BusObjEvent := DoBusinessObjectEvent;
  CurrentEmployee:= TEmployeeDetails.Create(self);
  fbShowingPickQtyonEdit := False;
  SaleIDToPick := 0;
  edtQty.showhint := False;
  lblCountSummary.caption := '';
  lblStatus.caption := '';
  lblEmployeeName.caption := '';
  lblSale.caption := '';
  lblSale2.caption := '';
  lblPickStart.caption := '';
  lblPackStart.caption := '';
  lblPickFinish.caption := '';
  lblPackFinish.caption := '';
  lblDispatchStart.caption := '';
  lblDispatchFinish.caption := '';
  if not AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    lbDispatchStart.Visible := false;
    lbDispatchFinish.Visible := false;
  end;
  rgScanSummary.Visible := False;


  lblLastProduct.caption := '';
  chkAutoPopUpBarcodePickingOptions.Checked :=
    AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions;
end;

procedure TfmBarcodePicking.FormDestroy(Sender: TObject);
begin
  Freeandnil(ProductsSelected);
  inherited;

end;

procedure TfmBarcodePicking.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (btnStartNewPicking.Enabled) then begin
    btnStartNewPickingClick(btnStartNewPicking);
  end;
end;

procedure TfmBarcodePicking.FormShow(Sender: TObject);
begin
  inherited;
  initform;
  GuiPrefs.Active := True;

  if AppEnv.CompanyPrefs.UseBarcodeDispatch and (PickAssemEntry.ID > 0) and PickAssemEntry.FinishedPacking then
    FormMode := fmDispatch
  else
    FormMode := fmPickPack;

  ReadnApplyGuiPrefExtra;
end;

procedure TfmBarcodePicking.grdpickingassemblyentrylinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;

  if grdpickingassemblyentrylines.Enabled and (accesslevel <=2)  then  else  AFont.Color := clGray;

  if QrypickingassemblyentrylinesQty.AsFloat <> 0 then  Abrush.Color := $00A8FFA8;
  if (fiLinesID =  PickAssemEntry.Lines.ID) and (fiLinesID<>0) then  Abrush.Color := $000080FF;

  if (PickAssemEntry.Lines.SaleId <> PickAssemEntry.saleId) and (PickAssemEntry.Lines.SaleId <> 0) then
    if (sametext(field.fieldname , 'SaleID')) then
        Abrush.Color := $00CECEFF;

end;

procedure TfmBarcodePicking.grdpickingassemblyentrylinesEnter(Sender: TObject);
begin
  inherited;
  ShowPickQtyonEdit(false, false);
end;

procedure TfmBarcodePicking.grdpickingassemblyentrylinesIButtonClick(
  Sender: TObject);
begin
  inherited;
  try
      if PickAssemEntry.Lines.count =0 then exit;
      if PickAssemEntry.Lines.Dispatched then begin
        MessageDlgXP_Vista('This Product ' +quotedStr(PickAssemEntry.Lines.Productname)+' is Already Dispatched.  You Cannot Delete This Item' ,mtInformation, [mbok] , 0);
        Exit;
      end;
      if MessageDlgXP_Vista('Do You wish to Delete ' +quotedStr(PickAssemEntry.Lines.Productname)+' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        PickAssemEntry.Lines.Qty := 0;
        PickAssemEntry.Lines.PostDB;
      end;
  finally
    SetcontrolFocus(edtBarcodeInput);
  end;
end;

procedure TfmBarcodePicking.grdSalesSummaryCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if grdSalesSummary.Enabled and (accesslevel <=2)  then  begin
    AFont.Color := clblack ;
//    if ProductsSelected.indexof(QrySalesSummaryProductID.asInteger)>=0 then
    if AllPickedforSaleProduct then // (QrySalesSummaryQtyRequired.asFloat = self.PickAssemEntry.   QrySalesSummaryQtyPacked.asFloat) then
      Abrush.Color := $00A8FFA8
    else
      Abrush.Color := grdSalesSummary.TitleColor;
  end else  AFont.Color := clGray;

end;

procedure TfmBarcodePicking.grdSalesSummaryDblClick(Sender: TObject);
begin
  inherited;
  if accesslevel >2 then exit;
  PickAssemEntry.PicksalesQty(sametext(grdSalesSummary.GetActiveField.fieldname , QrySalesSummaryQtyBackorder.fieldname),inttostr(PackNumber));
  ShowPickQtyonEdit;
  UpdateDisplay;
end;

procedure TfmBarcodePicking.grdToBeDispatchedDblClick(Sender: TObject);
var
  Key: Char;
begin
  inherited;
  if accesslevel >2 then exit;
  edtBarcodeInput.Text := qryToBeDispatched.FieldByName('PackBarcode').AsString;
  edtBarcodeInput.Modified:= true;
  Key :=chr(VK_RETURN);
  edtBarcodeInputKeyPress(Sender, Key);
end;

procedure TfmBarcodePicking.InitForm;
begin
  Status:= 'Waiting For Input';
  fiLinesID := 0;
  edtQty.showhint := False;
  edtQty.Text := '';
  lblLastProduct.caption := '';
  fiEmployeeID:= 0;
  ProcessingBarcode:= False;
  PickAssemEntry.Load(KeyID);
  PickAssemEntry.connection.BeginTransaction;
  if (keyId=0) and (AccessLevel <=2) then
    NewPickAssembly(appenv.Employee.EmployeeID);
  checkRecordAccess;
  if PickAssemEntry.PackingEmployeeId <> 0 then fiemployeeID :=PickAssemEntry.PackingEmployeeId
  else fiemployeeID :=PickAssemEntry.PickingEmployeeID;

  PickAssemEntry.Lines;
  if PickAssemEntry.PackingEmployeeId <> 0 then CurrentEmployee.Load(PickAssemEntry.PackingEmployeeId)
  else CurrentEmployee.Load(PickAssemEntry.PickingEmployeeID);
  //CurrentEmployee.Load(PickAssemEntry.PickingEmployeeID);
  PickAssemEntry.SalesSummaryLineForPacking;
  openqueries;
  UpdateDisplay;
  PickAssemEntry.dirty := False;
  SetcontrolFocus(edtBarcodeInput);

end;

function TfmBarcodePicking.ModifySale: boolean;
var
  MainId: integer;
begin
  result:= true;
  ConvertedSOInvoiceID := 0;
    { If sales order, do we need to convert to invoice .. }
    if PickAssemEntry.Sale.IsSalesOrder and (PickAssemEntry.Sale.Converted =False) and
      AppEnv.CompanyPrefs.AutoConvertSOtoInvoiceBarcodePick then begin
      if TSalesOrder(PickAssemEntry.Sale).IsBO then
        MainId:= TSalesOrder(PickAssemEntry.Sale).GetBackOrderMainSOId
      else
        MainId:= TSalesOrder(PickAssemEntry.Sale).Id;

      PickAssemEntry.Sale.ResultStatus.Clear;
      {ConvertedSOInvoiceID:= TSalesOrder(PickAssemEntry.Sale).CopySalesOrderToInvoice(MainId);}
      ConvertedSOInvoiceID:= TSalesOrder(PickAssemEntry.Sale).CopyToInvoice(MainID, false, PickAssemEntry.USerlock, PickAssemEntry.LockGroupName);
      if not PickAssemEntry.Sale.ResultStatus.OperationOk then begin
        CommonLib.MessageDlgXP_Vista('Could not convert sales order to invoice: '+
          PickAssemEntry.Sale.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        result:= false;
        exit;
      end;
    end;
end;



function TfmBarcodePicking.Savechanges:Boolean;
begin
    result:= False;
    if not(PickAssemEntry.dirty)  then begin
      REsult := TRue;
      Exit;
    end;
    if not(PickAssemEntry.save) then exit;
    PickAssemEntry.dirty := True;
    REsult := TRue;
end;
procedure TfmBarcodePicking.DevmodeBtnclick(Sender: TObject);
var
  Key: Char;
begin
  inherited;
  if not Devmode then exit;
        if Sender = lbPickStart   then edtBarcodeInput.Text :=   Barcode_Prefix_Pick + Barcode_SepChar + Barcode_Start
  else  if Sender = lbPackstart   then edtBarcodeInput.Text :=   Barcode_Prefix_Pack + Barcode_SepChar + Barcode_Start
  else  if Sender = lbDispatchStart   then edtBarcodeInput.Text :=   Barcode_Prefix_Dispatch + Barcode_SepChar + Barcode_Start
  else  if Sender = lbPickfinish  then edtBarcodeInput.Text :=   Barcode_Prefix_Pick + Barcode_SepChar + Barcode_Stop
  else  if Sender = lbPackfinish  then edtBarcodeInput.Text :=   Barcode_Prefix_Pack + Barcode_SepChar + Barcode_Stop
  else  if Sender = lbDispatchfinish  then edtBarcodeInput.Text :=   Barcode_Prefix_Dispatch + Barcode_SepChar + Barcode_Stop
  else exit;
  edtBarcodeInput.Modified:= true;
  Key :=chr(VK_RETURN);
  edtBarcodeInputKeyPress(Sender, Key);
end;

function TfmBarcodePicking.Savencommit(Doconifrm:Boolean = False;Printwhennotdirty :boolean =False):Boolean;
(*var
  Saved: Boolean;*)
begin
  //Saved:= False;
  REsult:= False;
    if accesslevel > 2 then begin
        PickAssemEntry.Cancel;
        PickAssemEntry.connection.RollbackTransaction;
        PickAssemEntry.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        REsult:= True;
        if Printwhennotdirty then
            if PickAssemEntry.FinishedPacking then begin
               //TfmBarcodeAfterPacked(commonlib.GetComponentByClassName('TfmBarcodeAfterPacked' , true , self)).ShowModal
               if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then PrintReports;
            end
            else MessageDlgXP_vista('Only finished Picking can be printed', mtWarning, [mbOK], 0);
    end else if not(PickAssemEntry.dirty)  then begin
        PickAssemEntry.Cancel;
        PickAssemEntry.connection.RollbackTransaction;
        PickAssemEntry.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        REsult:= True;
        if Printwhennotdirty then
            if PickAssemEntry.FinishedPacking then begin
               //TfmBarcodeAfterPacked(commonlib.GetComponentByClassName('TfmBarcodeAfterPacked' , true , self)).ShowModal
               if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then PrintReports;
            end
            else MessageDlgXP_vista('Only finished Picking can be printed', mtWarning, [mbOK], 0);
    end else begin
      Try
        if Doconifrm then begin
          case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
              mrYes: begin
                  if Savechanges then REsult:= True;
                  //Saved:= True;
                end;
              mrNo:
                begin
                  PickAssemEntry.Cancel;
                  PickAssemEntry.connection.RollbackTransaction;
                  PickAssemEntry.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
                  if self.IsFlag('Canceling') then
                    result := true
                  else
                    result:= false;
                end;
              mrCancel:
                begin
                  REsult:= False;
                  Exit;
                end;
          end;
        end else begin
          if not Savechanges then Exit;
          REsult:= True; //Saved:= True;
        end;
        if result then begin
          if (AppEnv.CompanyPrefs.AutoEditInvoiceBarcodePick and PickAssemEntry.FinishedDispatch) or
             ((not AppEnv.CompanyPrefs.AutoEditInvoiceBarcodePick) and PickAssemEntry.FinishedPacking) then begin
            if AppEnv.CompanyPrefs.AutoEditInvoiceBarcodePick then begin
              if not ModifySale then begin
                result := False;
                exit;
              end;
            end;
          end;
        end;

        PickAssemEntry.connection.CommitTransaction;
        PickAssemEntry.Dirty := False;

      finally
//        if result and Saved and PickAssemEntry.FinishedPacking then
//          TfmBarcodeAfterPacked(commonlib.GetComponentByClassName('TfmBarcodeAfterPacked' , true , self)).ShowModal;
      end;
    end;
  PickAssemEntry.connection.BeginTransaction;
end;
procedure TfmBarcodePicking.SetEmployeeID(const Value: Integer);
begin
  fiEmployeeId := Value;
  if CurrentEmployee.Id <> Value then begin
    if PickAssemEntry.ID <> 0 then begin
      if PickAssemEntry.FinishedPicking and not(PickAssemEntry.StartPacking) then begin
        PickAssemEntry.PackingEmployeeID := Value;
        CurrentEmployee.Load(Value);
        PickAssemEntry.PostDB;
        Exit;
      end;
    end;
    if not(savencommit) then exit;
    if CurrentEmployee.Id > 0 then begin
      NewPickAssembly(Value);
      fiSaleID:= 0;
    end;
    { select new employee }
    CurrentEmployee.Load(Value);
    Status:= 'Employee Selected';
    pickingstate := tLoggedin;
    PickAssemEntry.dirty := False;
    if SaleIDToPick <> 0 then SaleId := SaleIDToPick;
  end;
  UpdateDisplay;
end;

procedure TfmBarcodePicking.SetFormMode(const Value: TFickingFormMode);
begin
  fFormMode := Value;
  if fFormMode = fmPickPack then begin
    rgScanSummary.Visible := False;
//    grdSalesSummary.Align := alClient;
//    grdSalesSummary.BringToFront;

//    grdpickingassemblyentrylines.Align := alClient;
//    grdpickingassemblyentrylines.BringToFront;

    grdDispatched.Visible := false;
    grdToBeDispatched.Visible := false;
  end
  else if fFormMode = fmDispatch then begin
    lblPackSummaryClickInstructions.Caption := 'Double Click on ''Pack Barcode'' to process Pack';
//    rgScanSummary.Visible := true;
    qryToBeDispatched.ParamByName('ID').AsInteger := PickAssemEntry.ID;
    qryToBeDispatched.Refresh;

    qryDispatched.ParamByName('ID').AsInteger := PickAssemEntry.ID;
    qryDispatched.Refresh;

//    if rgScanSummary.ItemIndex = 0 then begin
//      grdDispatched.Align := alClient;
//      grdDispatched.BringToFront;
//    end
//    else begin
//      lblPackSummaryClickInstructions.Caption := 'Double Click on ''Back Order Qty'' to Pick Total';
//      grdpickingassemblyentrylines.Align := alClient;
//      grdpickingassemblyentrylines.BringToFront;
//    end;

//    grdDispatched.Align := alTop;
//    grdDispatched.Height := grdDispatched.Parent.Height Div 2;
    grdDispatched.Visible := true;
    //grdDispatched.BringToFront;
//    grdToBeDispatched.Align := altop;
//    grdToBeDispatched.Height := grdToBeDispatched.Parent.Height Div 2;
    grdToBeDispatched.Visible := true;
    //grdToBeDispatched.BringToFront;

    grdpickingassemblyentrylines.Enabled := false;
    grdSalesSummary.Enabled := false;

  end;
  grdDispatched.Height := grdDispatched.Parent.Height Div 2;
  grdToBeDispatched.Height := grdToBeDispatched.Parent.Height Div 2;
end;

procedure TfmBarcodePicking.setPackNumber(const Value: Integer);
begin
  fiPackNumber := Value;
  lblPackno.Caption := IntToStr(Value);
end;

procedure TfmBarcodePicking.setpickingstate(const Value: Tpickingstate);
begin
  fpickingstate := Value;
end;

function TfmBarcodePicking.ConvertedSale(const Value: Integer):Boolean;
begin
  With   PickAssemEntry.getNewdataset('Select saleId, converted from tblsales where saleId = ' + inttostr(Value), true) do try
    REsult := fieldbyname('converted').asBoolean;
  finally
    if active then close;
    Free;
  end;
end;

procedure TfmBarcodePicking.setsaleID(const Value: Integer);
var
  Editable:Boolean;
  ErrMsg:String;
begin
  Editable:=true;
  if ConvertedSale(Value) then begin
    MessageDlgXP_Vista('Sale # '+inttostr(Value)+' is already converted. It is not possible to pick', mtWarning, [mbOK], 0);
    exit;
  end;
  fiSaleID := Value;
  try
    PickAssemEntry.LoadSelect('SaleId = ' + IntToStr(Value)+' and PickingEmployeeID = ' + inttostr(EmployeeID)+' and finishedPacking ="F"');
    checkRecordAccess;
    if (PickAssemEntry.Id = 0) and (Accesslevel<=2) then begin
      NewPickAssembly(appenv.Employee.EmployeeID);
      PickAssemEntry.PickingEmployeeID := CurrentEmployee.ID;
      PickAssemEntry.SaleID:= Value;
      PickAssemEntry.Barcode:=  AppEnv.Branch.SiteCode + '-' + IntToStr(Value);
      if not Savechanges then exit;
      Status:= 'New Picking';
      pickingstate:=tSaleSelected;
      PickAssemEntry.PostDB;
      checkRecordAccess;
    end;
    if PickAssemEntry.StartPacking then begin
        if PackNumber = 0 then PackNumber:= PickAssemEntry.MaxLinePackNumber;
        if PackNumber = 0 then PackNumber:= 1;
        CurrentEmployee.Load(PickAssemEntry.PackingEmployeeID);
        pickingstate:=tPackingStarted;
    end else if PickAssemEntry.StartPicking then begin
        CurrentEmployee.Load(PickAssemEntry.PickingEmployeeID);
        pickingstate:=tPickingStarted;
    end;

    PickAssemEntry.SalesSummaryLineForPacking;
    UpdateDisplay;
    if (not AppEnv.CompanyPrefs.UseBarcodeDispatch) and (not (PickAssemEntry.HasAnytopick(true))) then
      MessageDlgXP_Vista(PickAssemEntry.Sale.XMLNodeName +' # ' + inttostr(PickAssemEntry.Sale.ID) + ' is completely Picked, Please choose another sale to be picked', mtWarning, [mbOK], 0);
  finally
    if not editable then begin
      EnablePick(False);
    end else if not(PickAssemEntry.sale.locktrans(ErrMsg)) then begin
      MessageDlgXP_Vista( replacestr(ErrMsg  , 'Unable to update data.' , 'Unable to Pick for ' +PickAssemEntry.sale.XMLNodename +'#' + inttostr(PickAssemEntry.sale.ID)+'.'), mtWarning, [mbOK], 0);
      EnablePick(False);
      Accesslevel := 5;
    end else begin
      EnablePick(true);
    end;
  end;
end;

Procedure TfmBarcodePicking.EnablePick(const Value:Boolean);
begin
  if not(Value) then Setcontrolfocus(edtBarcodeInput);
  edtQty.Enabled                      := Value and (AccessLevel <= 2);
  grdpickingassemblyentrylines.Enabled:= Value and (AccessLevel <= 2);
  grdSalesSummary.Enabled             := Value and (AccessLevel <= 2) and (PickAssemEntry.StartPacking);
  grdSalesSummary.Repaint;
  lblPackno.visible         := pickingstate = tPackingStarted;
  lblPacknoCaption.visible  := pickingstate = tPackingStarted;
//  cmdPrint.enabled := pickingstate in [tPackingfinished];
  btnPickingStatusreport.enabled := PickAssemEntry.saleID<>0;
end;
Procedure TfmBarcodePicking.NewPickAssembly(const EmployeeID:Integer =0);
begin
    PickAssemEntry.New;
    PickAssemEntry.PickingEmployeeID := 0;//EmployeeID;
    PickAssemEntry.CreatedOn := Now;
    PickAssemEntry.PostDb;
    PickAssemEntry.Lines;
end;
procedure TfmBarcodePicking.ProcessBarcode(const codeStr: string);
var
  sl: TStringList;
  Id: integer;

  Procedure ProcessEmployee;
  begin
        Id:= 0;
        if (sl.Count > 1) then Id:= StrToIntDef(sl[1],0);
        if (Id > 0) then begin
          if PickAssemEntry.ID <> 0 then begin
            if PickAssemEntry.StartPacking and not(PickAssemEntry.FinishedPacking) then begin
               CommonLib.MessageDlgXP_Vista(CurrentEmployee.employeename+ ' has already started packing and not finished. You cannot login.',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
               exit;
            end;
            if PickAssemEntry.StartPicking and not(PickAssemEntry.FinishedPicking) then begin
               CommonLib.MessageDlgXP_Vista(CurrentEmployee.employeename+ ' has already started picking and not finished. You cannot login.',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
               exit;
            end;
          end;
          EmployeeID := ID;
          if self.SaleId > 0 then begin
            if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then PrintReports;
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('Invalid Employee Scan',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

  end;
  Procedure Processsales;
  begin
        Id:= 0;
        if EmployeeID = 0 then begin
          CommonLib.MessageDlgXP_Vista('Employee should login first',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
        if (sl.Count > 1) then Id:= StrToIntDef(sl[1],0);
        if (Id > 0) then begin
          SaleId:= Id;
          enablePick(True);
          if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then PrintReports;
        end else begin
          CommonLib.MessageDlgXP_Vista('Invalid sale Id scan',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;

  function StartPacking: Boolean;
  begin
    result:= true;
    if PickAssemEntry.StartPacking then exit;

      if not PickAssemEntry.StartPicking then begin
        PickAssemEntry.StartPickingTime:= now;
        PickAssemEntry.PickingEmployeeID:= CurrentEmployee.Id;
        PickAssemEntry.StartPicking:= true;
      end;
      if not PickAssemEntry.FinishedPicking then begin
        PickAssemEntry.FinishedPickingTime:= now;
        PickAssemEntry.FinishedPicking:= true;
      end;
      PickAssemEntry.StartPacking:= true;
      PickAssemEntry.StartPackingTime:= now;
      PickAssemEntry.PackingEmployeeID:=  CurrentEmployee.Id;
      //PackNumber:= 1;
      PickAssemEntry.PostDB;
      result:= true;
      pickingstate := tPackingStarted;
  end;

  Procedure ProcessUOM;
  var
    LineId,UOMId, fSaleID:Integer;
  begin
        LineId:= 0;
        UOMId:= 0;
        if (sl.Count = 3) then begin
          UOMId:= StrToIntDef(sl[1],0);
          LineId:= StrToIntDef(sl[2],0);
        end;

        if (UOMId = 0) or (LineId = 0) then begin
          CommonLib.MessageDlgXP_Vista('Invalid sale line scan: "' + codeStr + '"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

        fSaleID:= tcDataUtils.GetSaleIdForSaleLineId(LineId);
        if fSaleID =0 then begin
          CommonLib.MessageDlgXP_Vista('Invalid sale line scan: "' + codeStr + '"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

        if EmployeeID = 0 then begin
          CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

        if (PickAssemEntry.SaleID = fSaleID) then else begin
          if not(Savencommit) then exit;
          SaleID := fSaleID;
        end;

        if PickAssemEntry.FinishedPicking then begin

        end else if not StartPacking then begin

        end else begin
          Status:= PickAssemEntry.StatusText;
          pickingstate:= tPackingStarted;
        end;

        { get product ID from sales line }
        if not PickAssemEntry.Sale.Lines.Dataset.Locate('SaleLineId',LineId,[]) then begin
            CommonLib.MessageDlgXP_Vista('Could not locate this line on sale',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
        end;
        if not(PickAssemEntry.Sale.Lines.Product.UOMList.LocateByID(UOMID)) then begin
              CommonLib.MessageDlgXP_Vista('Unit of Measure ID on sale line does not match scanned Unit of Measure ID',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
              exit;
        end;
        //PickAssemEntry.PicksalesQty(TSalesLine(PickAssemEntry.Sale.Lines));
        PickAssemEntry.PickQty(TSalesLine(PickAssemEntry.Sale.Lines), 1, False, IntToStr(PackNumber));
        enablePick(True);
        SetcontrolFocus(edtBarcodeInput);
  end;

  Procedure ProcessPicking;
  var
    s:String;
  begin
    { Picking }
        s:= '';
        if (sl.Count > 1) then s:= sl[1];
        if (s = '') then begin
          CommonLib.MessageDlgXP_Vista('Invalid pick bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
        if PickAssemEntry.Id = 0 then begin
            CommonLib.MessageDlgXP_Vista('No sale selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
        end;
        if CurrentEmployee.Id = 0 then begin
          CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

        { starting or stopping picking }
        if s = Barcode_Start then begin
              if PickAssemEntry.StartPicking then begin
                CommonLib.MessageDlgXP_Vista('Can not start picking: ' + PickAssemEntry.StatusText,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                exit;
              end;
              PickAssemEntry.StartPicking:= true;
              PickAssemEntry.StartPickingTime:= now;
              PickAssemEntry.PickingEmployeeID:= CurrentEmployee.Id;
              pickingstate := tPickingStarted;
              if not Savechanges then exit;
              Status:= PickAssemEntry.StatusText;
        end else if s = Barcode_Stop then begin
              if not PickAssemEntry.StartPicking then begin
                CommonLib.MessageDlgXP_Vista('Can not finish picking: ' + PickAssemEntry.StatusText,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                exit;
              end;
              if not PickAssemEntry.StartPicking then begin
                  PickAssemEntry.PickingEmployeeID:= CurrentEmployee.Id;
                  PickAssemEntry.StartPickingTime:= now;
                  PickAssemEntry.StartPicking:= true;
              end;
              PickAssemEntry.FinishedPicking:= true;
              PickAssemEntry.FinishedPickingTime:= now;
              pickingstate := tPickingfinished;
              if not Savechanges then exit;
              Status:= PickAssemEntry.StatusText;
        end;
  end;

  Function finishPacking:Boolean;
  begin
    result := False;
      if not PickAssemEntry.FinishedPacking then begin
        if  (not AllPickingDone) then
          if CommonLib.MessageDlgXP_Vista('All items on this order have not been packed, '+NL+'Are you sure you want to complete packing?',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;


        PickAssemEntry.ResultStatus.Clear;
        if not PickAssemEntry.ValidateData then exit;
        if not PickAssemEntry.Save then exit;


        PickAssemEntry.PackingEmployeeID := CurrentEmployee.Id;
        PickAssemEntry.FinishedPacking:= true;
        PickAssemEntry.FinishedPackingTime:= now;
        PickAssemEntry.PostDB;
        Result := Savechanges;
        if result then begin
          PickAssemEntry.Dirty := True;
          if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then begin
            if PrintReports then begin
              if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
                KeyId :=0;
                initform;
              end;
            end;
          end
          else begin
            if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
              KeyId :=0;
              initform;
            end;
          end;
          Status:= PickAssemEntry.StatusText;
        end;
      end;
  end;

  function ProcessPacking:Boolean;
  var
    s:String;
  begin
{ Packing }
        result := true;
        s:= '';
        if (sl.Count > 1) then s:= sl[1];
        if (s = '') then begin
          CommonLib.MessageDlgXP_Vista('Invalid pack bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
        if CurrentEmployee.Id = 0 then begin
          CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
        { starting or stopping packing }
        if PickAssemEntry.saleId = 0 then begin
            CommonLib.MessageDlgXP_Vista('No sale selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
        end;

        if s = Barcode_Start then begin
          if not StartPacking then exit;
        end else if s = Barcode_Stop then begin
          Result := FinishPacking;
        end else if s = Barcode_NewPack then begin
          PackNumber:= PickAssemEntry.MaxLinePackNumber;
          PackNumber:= PackNumber +1;
          pickingstate := tPackingStarted;
        end;
  end;

  function DoStartDispatch: boolean;
  begin
    result:= true;
    if PickAssemEntry.StartDispatch then exit;

//    if not PickAssemEntry.StartDispatch then begin
//      PickAssemEntry.StartDispatchTime:= now;
//      PickAssemEntry.DispatchingEmployeeID:= CurrentEmployee.Id;
//      PickAssemEntry.StartDispatch:= true;
//    end;
//    if not PickAssemEntry.FinishedPacking then begin
//      PickAssemEntry.FinishedPackingTime:= now;
//      PickAssemEntry.FinishedPacking:= true;
//    end;
    PickAssemEntry.StartDispatch:= true;
    PickAssemEntry.StartDispatchTime:= now;
    PickAssemEntry.DispatchingEmployeeID:=  CurrentEmployee.Id;
    //PackNumber:= 1;
    PickAssemEntry.PostDB;
//    result:= true;
    PickingState := tDispatchStarted;
  end;

  function FinishDispatch: boolean;
  begin
    result := False;
    if not AppEnv.CompanyPrefs.UseBarcodeDispatch then exit;

    if not PickAssemEntry.FinishedDispatch then begin
      if qryToBeDispatched.RecordCount > 0 then begin
        CommonLib.MessageDlgXP_Vista('Not all packs on this order have been processed.',mtInformation,[mbOK],0);
        exit;
      end;

      PickAssemEntry.ResultStatus.Clear;
      if not PickAssemEntry.ValidateData then exit;
      if not PickAssemEntry.Save then exit;

      PickAssemEntry.DispatchingEmployeeID := CurrentEmployee.Id;
      PickAssemEntry.FinishedDispatch:= true;
      PickAssemEntry.FinishedDispatchTime:= now;
      PickAssemEntry.PostDB;
      Result := Savechanges;
      if result then begin
        PickAssemEntry.Dirty := True;
        if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then begin
          if PrintReports then begin
            KeyId :=0;
            initform;
          end;
        end;
        KeyId :=0;
        initform;
        Status:= PickAssemEntry.StatusText;
      end;
    end;
  end;

  function ProcessDispatch: Boolean;
  var
    s:String;
  begin
  { Packing }
      result := false;
      s:= '';
      if not PickAssemEntry.FinishedPacking then begin
        CommonLib.MessageDlgXP_Vista('Can''t dispatch goods, packing has not been finished yet.',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
      if (sl.Count > 1) then s:= sl[1];
      if (s = '') then begin
        CommonLib.MessageDlgXP_Vista('Invalid dispatch bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
      if CurrentEmployee.Id = 0 then begin
        CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
      { starting or stopping packing }
      if PickAssemEntry.saleId = 0 then begin
          CommonLib.MessageDlgXP_Vista('No sale selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
      end;

      if s = Barcode_Start then begin
        if (not DoStartDispatch) then
          exit;
        result := true;
      end else if s = Barcode_Stop then begin
        Result := FinishDispatch;
      end
      else begin
        if sl.Count <> 3 then begin
          CommonLib.MessageDlgXP_Vista('Invalid dispatch bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
        if (not PickAssemEntry.StartDispatch) then begin
          if (not DoStartDispatch) then
            exit;
        end;
        if PickAssemEntry.FinishedDispatch then begin
          CommonLib.MessageDlgXP_Vista('Dispatch has not allready been finished.',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

        if PickAssemEntry.FlagAsDispatched(StrToIntDef(sl[2],0)) then begin
          PickAssemEntry.Lines.PostDb;

          qryToBeDispatched.Refresh;
          qryDispatched.Refresh;
//          qryToBeDispatched.Close;
//          qryToBeDispatched.Open;
//          qryDispatched.Close;
//          qryDispatched.Open;
          result := true;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Invalid dispatch bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;

      end;
  end;


  Procedure ProcessBarCode;
  var
    ProdId: Integer;
    UOMID: integer;
    UnitOfMeasureInfo: TUnitOfMeasureInfo;
  begin
{ check for product barcode }
      ProdId:= TProduct.ProductIdForBarcode(codeStr, UOMId);
      if ProdId = 0 then begin
        CommonLib.MessageDlgXP_Vista('Unknown bar code: "'+ codeStr +'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
      if PickAssemEntry.Id = 0 then begin
          CommonLib.MessageDlgXP_Vista('No sale selected' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
      end;
      if PickAssemEntry.SalesSummaryLineForPacking.Locate('ProductId',ProdId,[]) = false then begin
        CommonLib.MessageDlgXP_Vista('Product is not on sale' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;

      if EmployeeID = 0 then begin
        CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;

      if StartPacking and (not PickAssemEntry.FinishedPacking)  then begin
            Status:= PickAssemEntry.StatusText;
            pickingstate:= tPackingStarted;
            if UOMID < 1 then begin
              if not PickAssemEntry.Sale.Lines.Dataset.Locate('ProductID',ProdID,[]) then begin
                  CommonLib.MessageDlgXP_Vista('Could not locate this Product on sale',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                  exit;
              end;
              UnitOfMeasureInfo := TUnitOfMeasure.GetUOMInfo(PickAssemEntry.Sale.Lines.UnitOfMeasureID);
            end
            else begin
              { Barcode has UOM associated ... }
              UnitOfMeasureInfo := TUnitOfMeasure.GetUOMInfo(UOMID);
              if not PickAssemEntry.Sale.Lines.Dataset.Locate('ProductID;UnitOfMeasureID',VarArrayOf([ProdID,UOMID]),[]) then begin
                  CommonLib.MessageDlgXP_Vista('Could not locate this Product for unit '+UnitOfMeasureInfo.Name+' on sale',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                  exit;
              end;
            end;
            PickAssemEntry.PickQty(TSalesLine(PickAssemEntry.Sale.Lines), UnitOfMeasureInfo.Multiplier, true, IntToStr(PackNumber));
            enablePick(True);
            SetcontrolFocus(edtBarcodeInput);
      end else begin
        CommonLib.MessageDlgXP_Vista('Can only change quantity while order is being packed' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
  end;

begin
  if accesslevel >2 then exit;

  if codeStr = '' then exit;
  lblLastProduct.Caption:= '';
  lblCountSummary.Caption:= '';
  sl:= TStringList.Create;
  try
    fastfuncs.Split(codeStr,Barcode_SepChar,sl);
    if sl.Count > 1 then begin
      if SameText(codeStr,Barcode_StartNew) then begin
        Savencommit(true);
//        i := fiEmployeeID;
        KeyID := 0;
        initform;
        SetcontrolFocus(edtBarcodeInput);
      end
      else if sl[0] = Barcode_Prefix_Employee then begin
        ProcessEmployee;
        enablePick(False);
      end  else if sl[0] = Barcode_Prefix_UOMSalesLine then begin
        if accesslevel <= 2 then ProcessUOM;
      end else if (sl[0] = Barcode_Prefix_Sale) then begin
        Processsales;
      end else if sl[0] = Barcode_Prefix_Pick then begin
        if accesslevel <= 2 then ProcessPicking;
      end else if sl[0] = Barcode_Prefix_Pack then begin
        if accesslevel <= 2 then if not ProcessPacking then exit;
      end
      else if sl[0] = Barcode_Prefix_Dispatch then begin
        if accesslevel <= 2 then if not ProcessDispatch then exit;
      end
    end
    else begin
      ProcessBarCode;
    end;
    SaleIDToPick := 0;
    UpdateDisplay;
    EnablePick(true);
  finally
    sl.Free;
  end;
end;

procedure TfmBarcodePicking.ProcessQuantity(const fdQty:double);
begin
  if fdQty =PickAssemEntry.Lines.Qty then exit;

  PickAssemEntry.AdjustPicksalesQty(fdQty);
  ShowPickQtyonEdit;
end;

procedure TfmBarcodePicking.QrypickingassemblyentrylinesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if PackNumber <> 0 then  PickAssemEntry.Lines.PackNumber := PackNumber;

end;

procedure TfmBarcodePicking.QrypickingassemblyentrylinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  PackNumber:= PickAssemEntry.MaxLinePackNumber;
  if PackNumber = 0 then PackNumber:= 1;
  ProductsSelected.commatext := Qrypickingassemblyentrylines.GroupConcat('ProductID', 'Qty <> 0' , False, ',' , '','', False, TRue);
end;

procedure TfmBarcodePicking.QrypickingassemblyentrylinesAfterPost(DataSet: TDataSet);
begin
  inherited;
  ProductsSelected.commatext := Qrypickingassemblyentrylines.GroupConcat('ProductID', 'Qty <> 0' , False, ',' , '','', False, TRue);
end;

procedure TfmBarcodePicking.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  if pnlSummary.Visible then begin
    x := GuiPrefs.Node['Summary.Height'].asInteger;
    if x<=0 then x:= 152;
    pnlSummary.Height := x;
    if pnlDetail.height < 152 then
      pnlSummary.Height  := pnlSummary.Height - (152- pnlDetail.height);
  end;
end;

Procedure TfmBarcodePicking.RefreshLines;
var
  bm:TBookmark;
  fbFlag:Boolean;
begin
  try
    fbFlag:=PickAssemEntry.Dirty;
    bm := PickAssemEntry.Lines.dataset.getbookmark;
    try
      PickAssemEntry.Lines.RefreshDB;
    finally
      PickAssemEntry.Lines.dataset.gotobookmark(bm);
      PickAssemEntry.Lines.dataset.FreeBookmark(bm);
      PickAssemEntry.Dirty:= fbFlag;
    end;
  Except
    on E:exception do begin
      if devmode then
        MessageDlg('Error while locating bookmark -> ' + E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmBarcodePicking.rgScanSummaryClick(Sender: TObject);
begin
  inherited;
  FormMode := FormMode;
end;

procedure TfmBarcodePicking.ProcessQty;
begin
    ProcessQuantity(edtQty.FloatValue);
    RefreshLines;
    edtQty.Text:= '';
    edtBarcodeInput.SetFocus;
end;

procedure TfmBarcodePicking.UpdateDisplay;
begin
  lblStatus.Caption:= Status;
  lblEmployeeName.Caption:= CurrentEmployee.Employeename;

  if Assigned(PickAssemEntry.Sale) then begin
    if PickAssemEntry.Sale.IsInvoice then begin
      lblSale.Caption:= 'Invoice ' + PickAssemEntry.Sale.GlobalRef;
      lblSale2.Caption:= PickAssemEntry.Sale.CustomerName;
    end
    else if PickAssemEntry.Sale.IsSalesOrder then begin
      lblSale.Caption:= 'Sales Order ' + PickAssemEntry.Sale.GlobalRef;
      lblSale2.Caption:= PickAssemEntry.Sale.CustomerName;
    end
  end
  else begin
    lblSale.Caption:= '';
    lblSale2.Caption:= '';
  end;

  if PickAssemEntry.StartPickingTime > 0 then lblPickStart.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.StartPickingTime)
  else lblPickStart.Caption:= '';

  if PickAssemEntry.FinishedPickingTime > 0 then lblPickFinish.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.FinishedPickingTime)
  else lblPickFinish.Caption:= '';

  if PickAssemEntry.StartPackingTime > 0 then lblPackStart.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.StartPackingTime)
  else lblPackStart.Caption:= '';

  if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    if PickAssemEntry.FinishedDIspatchTime > 0 then lblDispatchFinish.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.FinishedDispatchTime)
    else lblDispatchFinish.Caption:= '';

    if PickAssemEntry.StartDispatchTime > 0 then lblDispatchStart.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.StartDispatchTime)
    else lblDispatchStart.Caption:= '';
  end;


  if PickAssemEntry.FinishedPackingTime > 0 then lblPackFinish.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssemEntry.FinishedPackingTime)
  else lblPackFinish.Caption:= '';
  if (not AppEnv.CompanyPrefs.UseBarcodeDispatch) or (AppEnv.CompanyPrefs.UseBarcodeDispatch and (not PickAssemEntry.finishedPacking)) then begin
    if PickAssemEntry.SalesSummaryLineForPacking.locate('ProductId' , PickAssemEntry.Lines.ProductId , []) then
      lblLastProduct.Caption:= PickAssemEntry.Lines.Productname;
  end
  else begin
    lblLastProduct.Caption:= '';
  end;

  if AppEnv.CompanyPrefs.UseBarcodeDispatch and (PickAssemEntry.ID > 0) and PickAssemEntry.FinishedPacking then
    FormMode := fmDispatch
  else
    FormMode := fmPickPack;
  if PickAssemEntry.FinishedPacking then
    edtQty.Enabled := false;


//  if devmode then begin
    HighlightControl(nil);
    if (PickAssemEntry.saleID=0) or (EmployeeId=0) then HighlightControl(edtBarcodeInput)
    else if (accesslevel <= 2) and (PickAssemEntry.saleID>0) and ((PickAssemEntry.lines.Count=0) or AppEnv.CompanyPrefs.UseBarcodeDispatch) then
           if not PickAssemEntry.startPicking then HighlightControl(lbPickStart)
      else if not PickAssemEntry.finishedPicking then HighlightControl(lbPickfinish)
      else if not PickAssemEntry.startPacking then HighlightControl(lbPackstart)
      else if {(not AppEnv.CompanyPrefs.UseBarcodeDispatch) and} (not PickAssemEntry.finishedPacking) and (PickAssemEntry.SalesSummaryLineForPacking.count >0) then HighlightControl(grdSalesSummary)
      else if AppEnv.CompanyPrefs.UseBarcodeDispatch and (not PickAssemEntry.StartDispatch) then HighlightControl(lbDispatchStart)
      else if AppEnv.CompanyPrefs.UseBarcodeDispatch and (not PickAssemEntry.FinishedDispatch) and (qryToBeDispatched.RecordCount > 0) then HighlightControl(grdToBeDispatched)
      else if AppEnv.CompanyPrefs.UseBarcodeDispatch and (not PickAssemEntry.FinishedDispatch) and (qryToBeDispatched.RecordCount = 0) then HighlightControl(lbDispatchFinish)
//  end;

end;

procedure TfmBarcodePicking.WriteGuiPrefExtra;
begin
  if pnlSummary.Visible then begin
    GuiPrefs.Node['Summary.Height'].asInteger := pnlSummary.Height;
  end;
end;
procedure TfmBarcodePicking.DostartNew(EmpID:Integer);
var
  TempSaleID :Integer;
begin
  inherited;
    TempSaleID := GetNextPickingSlipSaleID;
    if TempSaleID = 0 then begin
      CommonLib.MessageDlgXP_Vista('No New Picking Slips To Pick',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      SetControlFocus(edtBarcodeInput);
    end else begin
      EmployeeId := EmpID;
      SaleId := TempSaleID;
      pickingstate:=tSaleSelected;
      if AppEnv.CompanyPrefs.AutoPopUpBarcodePickingOptions then
        PrintReports;
    end;
    UpdateDisplay;
end;

function TfmBarcodePicking.GetNextPickingSlipSaleID: integer;
var
  qry: TERPQuery;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT tblSales.SaleID,PickingPriority,SaleDate FROM tblSales');
    qry.SQL.Add('INNER JOIN tblClients ON tblClients.ClientID= tblSales.ClientID');
    qry.SQL.Add('LEFT JOIN tblpickingassembly ON tblSales.SaleID=tblpickingassembly.SaleID');
    qry.SQL.Add('WHERE IsBarcodePicking="T" AND BarcodePickingDone <> "T"');
    if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
      qry.SQL.Add('AND (IsSalesOrder = "T")');
      qry.SQL.Add('AND (tblSales.Converted = "F")');
    end
    else
      qry.SQL.Add('AND (IsInvoice = "T")');
    { only include sales that have at least one line with a shipped qty <> 0}
    qry.SQL.Add('AND tblSales.SaleID in');
    qry.SQL.Add('(select distinct s.saleId  from tblSales s, tblSalesLines sl');
    qry.SQL.Add('where s.SaleId = sl.SaleId');
    if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
      qry.SQL.Add('and s.IsSalesOrder = "T"');
      qry.SQL.Add('AND (s.Converted = "F")');
    end
    else
      qry.SQL.Add('and s.IsInvoice = "T"');
    qry.SQL.Add('and s.IsBarcodePicking="T" AND s.BarcodePickingDone <> "T"');
    qry.SQL.Add('and (sl.shipped <> 0 or (sl.shipped=0 and sl.backorder<>0 and ifnull(S.boid,"")="")))');

    qry.SQL.Add('AND ISNULL(tblpickingassembly.SaleID)');
    qry.SQL.Add('Order by PickingPriority Desc, SaleDate;');
    qry.Open;
    result:= qry.FieldByName('SaleId').AsInteger;
  finally
    qry.Free;
  end;
end;
procedure TfmBarcodePicking.DoPrintsale;
var
  sSQL: string;
begin
  fbReportSQLSupplied := false;
  sSQL := '~|||~Where PAE.PickingAssemblyEntryID = ' + IntToStr(PickAssemEntry.ID) +
    ' GROUP BY S.saleId, PAL.productId  ORDER BY s.saleId, PAL.PackNumber, PAL.ProductId;';
  PrintTemplateReport('Picking Sale', sSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
  if ConvertedSOInvoiceID<> 0 then PrintInvoice(ConvertedSOInvoiceID);
  ConvertedSOInvoiceID := 0;
end;
procedure TfmBarcodePicking.PrintInvoice(const SaleID: integer);
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
  sSQL := ' AND d2.SaleID=' + IntToStr(SaleID) + ';';
  PrintTemplateReport(tcdatautils.GetDefaultReport(11), sSQL, not(appEnv.Employee.PreviewAllreport), 1);
end;

procedure TfmBarcodePicking.DoPrintPick;
var
  sSQL: string;
  reportname:String;
  Json: TJsonObject;
begin
  reportName := 'Pick Slip with Barcodes';
  DisableForm;
  try
    fbReportSQLSupplied := true;
    With PickAssemEntry.getnewdataset('select distinct saleId  from tblpickingassemblyentry where pickingAssemblyEntryId = ' + inttostr(PickAssemEntry.ID) , true) do try
      if recordcount =0 then exit;
      first;
      DoShowProgressbar(recordcount , WAITMSG);
      try
        while Eof = False do begin
          DoStepProgressbar('Printing Picking slip for Sale #' + inttostr(Fieldbyname('SaleID').AsInteger));
          sSQL := '{UOMs}SELECT ' +
              ' SL.SaleLineID, uom.UnitId, uom.UnitName, uom.UnitDescription,   CONCAT("USL-",uom.UnitId,"-",SL.SaleLineId) as LineUnitsBarcode ' +
              '  FROM tblsaleslines AS SL /*inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID */' +
              ' left join tblUnitsOfMeasure uom on (uom.PartId = SL.ProductId /*or uom.PartId = 0*/) ' +
              ' WHERE  (SL.saleId = ' +IntToStr(fieldByname('SaleID').AsInteger) + ') order by Unitname';
          sSQL :=PrintPickingSlipsLib.SQL4PickingSlipreport(reportName,json, IntToStr(fieldByname('SaleID').AsInteger), SalesTransTypes, '', sSQL);
          PrintTemplateReport(reportname, sSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1 , json );
          Next;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      Free;
    end;
  finally
    EnableForm;
  end;
end;
procedure TfmBarcodePicking.PrintDeliveryDocket;
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
  sSQL := '~|||~Where PAE.PickingAssemblyEntryID = ' + IntToStr(PickAssemEntry.ID) +
    ' GROUP BY S.saleId, PAL.productId   ' +
    ' ORDER BY s.saleId, PAL.PackNumber, PAL.ProductId;';
  PrintTemplateReport('Picking Delivery Docket', sSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
end;
procedure TfmBarcodePicking.PrintDispatchLables;
var
  sSQL: string;
begin
  sSQL := ' where PickingAssemblyEntryID = ' + IntToStr(PickAssemEntry.ID);
  PrintTemplateReport('Picking Dispatch Lables', sSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
end;

procedure TfmBarcodePicking.PrintPickingConNote;
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
//  sSQL := '~|||~Where PAE.PickingAssemblyEntryID = ' + IntToStr(PickAssemEntry.ID) +
  sSQL := 'Where PA.PickingAssemblyEntryID = ' + IntToStr(PickAssemEntry.ID) +
    ' ORDER BY s.saleId, PAL.PackNumber, PAL.ProductId;';
  PrintTemplateReport('Picking ConNote', sSQL, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
end;

function TfmBarcodePicking.PrintReports: boolean;
var
//  OptsForm: TfmReportingOptions;
  PrintForm: TfmBarcodeAfterPacked;
begin
  result := false;
  if PickAssemEntry.ID < 1 then exit;

  if not(Savencommit(false, false)) then exit;

  PrintForm := TfmBarcodeAfterPacked(commonlib.GetComponentByClassName('TfmBarcodeAfterPacked' , true , self));
  try
    PrintForm.actPrintPick.Enabled := false;
    PrintForm.actPrintsale.Enabled := false;
    PrintForm.actPrintDespatchBarcode.Enabled := false;
    PrintForm.actPrintDeldocket.Enabled := false;
    PrintForm.actPrintCNote.Enabled := false;

    PrintForm.chkPrintPick.Checked := false;
    PrintForm.chkPrintsale.Checked := false;
    PrintForm.chkPrintBarcode.Checked := false;
    PrintForm.chkPrintDeldocket.Checked := false;
    PrintForm.chkPrintCNote.Checked := false;

//    if PickAssemEntry.FinishedPicking  and (PickAssemEntry.Lines.Count > 0) then begin
      PrintForm.actPrintPick.Enabled := true;
//    end;

    if not PickAssemEntry.StartPicking then
      PrintForm.chkPrintPick.Checked := true;


    if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
      if PickAssemEntry.FinishedDispatch then begin
        PrintForm.actPrintDeldocket.Enabled := true;
        PrintForm.actPrintCNote.Enabled := true;
        PrintForm.actPrintsale.Enabled := true;
        PrintForm.chkPrintsale.Checked := true;
        PrintForm.chkPrintDeldocket.Checked := true;
        PrintForm.chkPrintCNote.Checked := true;
      end
      else if PickAssemEntry.FinishedPacking then begin
        PrintForm.actPrintsale.Enabled := true;
        PrintForm.actPrintDespatchBarcode.Enabled := true;
        PrintForm.chkPrintBarcode.Checked := true;
      end;
    end
    else begin
      { not using dispatch }
      if PickAssemEntry.FinishedPacking then begin
        PrintForm.actPrintsale.Enabled := true;
        PrintForm.actPrintDeldocket.Enabled := true;
        PrintForm.actPrintCNote.Enabled := true;
        PrintForm.chkPrintsale.Checked := true;
        PrintForm.chkPrintDeldocket.Checked := true;
        PrintForm.chkPrintCNote.Checked := true;
      end;
    end;

    if not PrintForm.actPrintPick.Enabled then PrintForm.chkPrintPick.Checked := false;
    if not PrintForm.actPrintsale.Enabled then PrintForm.chkPrintsale.Checked := false;
    if not PrintForm.actPrintDespatchBarcode.Enabled then PrintForm.chkPrintBarcode.Checked := false;
    if not PrintForm.actPrintDeldocket.Enabled then PrintForm.chkPrintDeldocket.Checked := false;
    if not PrintForm.actPrintCNote.Enabled then PrintForm.chkPrintCNote.Checked := false;

    PrintForm.chkPrintPick.Enabled := PrintForm.actPrintPick.Enabled;
    PrintForm.chkPrintsale.Enabled := PrintForm.actPrintsale.Enabled;
    PrintForm.chkPrintBarcode.Enabled := PrintForm.actPrintDespatchBarcode.Enabled;
    PrintForm.chkPrintDeldocket.Enabled := PrintForm.actPrintDeldocket.Enabled;
    PrintForm.chkPrintCNote.Enabled := PrintForm.actPrintCNote.Enabled;

//  OptsForm := TfmReportingOptions.Create(nil);
//  try
//    if PickAssemEntry.FinishedPicking  and (PickAssemEntry.Lines.Count > 0) then begin
//      OptsForm.ActionList.Add('Print Picking','Print picking slip',DoPrintPick,true,true);
//    end;
//
//    if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
//      if PickAssemEntry.FinishedPacking then begin
//        OptsForm.ActionList.Add('Print Sale','Print sale details',DoPrintSale,true,true);
//        OptsForm.ActionList.Add('Dispatch Lables','Print dispatch barcode lables',PrintDispatchLables,true,true);
//      end;
//      if PickAssemEntry.FinishedDispatch then begin
//        OptsForm.ActionList.Add('Delivery Docket','Print delivery docket',PrintDeliveryDocket,true,true);
//        OptsForm.ActionList.Add('Consignment Note','Print consignment note',PrintPickingConNote,true,true);
//      end;
//    end
//    else begin
//      { not using dispatch }
//      if PickAssemEntry.FinishedPacking then begin
//        OptsForm.ActionList.Add('Print Sale','Print sale details',DoPrintSale,true,true);
//        OptsForm.ActionList.Add('Delivery Docket','Print delivery docket',PrintDeliveryDocket,true,true);
//        OptsForm.ActionList.Add('Consignment Note','Print consignment note',PrintPickingConNote,true,true);
//      end;
//    end;
//
//    if OptsForm.ActionList.Count = 0 then exit;
//
//    result := OptsForm.ShowModal = mrOk;
      result := PrintForm.ShowModal = mrOk;

  finally
//    OptsForm.Free;
    PickAssemEntry.connection.BeginTransaction;
  end;
end;

procedure TfmBarcodePicking.AfterFinishProcess(Printsale, PrintDeldocket, PrintCNode , printPick, printDispatch: Boolean);
begin
  DoShowProgressbar(3 , WAITMSG);
  try
    if Printsale then begin
       DoStepProgressbar('Printing Transaction ...');
       DoPrintSale;
    end;
    if PrintDeldocket then begin
      DoStepProgressbar('Printing Delivery Docket ...');
      PrintDeliveryDocket;
    end;
    if PrintCNode then begin
      DoStepProgressbar('Printing Consignment Note ...');
      PrintPickingConNote;
    end;
    if printPick then begin
      DoStepProgressbar('Printing Consignment Note ...');
      doPrintPick;
    end;
    if printDispatch then begin
      DoStepProgressbar('Printing Dispatch Barcode ...');
      PrintDispatchLables;
    end;
  finally
    DohideProgressbar
  end;
end;

initialization
  RegisterClassOnce(TfmBarcodePicking);
  FormFact.RegisterMe(TfmBarcodePicking, 'TBarcodePickListGUI_*=PickingAssemblyEntryID');
end.

