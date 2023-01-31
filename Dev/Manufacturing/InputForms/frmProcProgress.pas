unit frmProcProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  BusObjEmployee, DNMSpeedButton ,   BusObjBase, AdvGlowButton, Mask, busobjsales,
  busobjProcProgress,ImageDLLLib, Grids, Wwdbigrd, Wwdbgrid, ActnList, DNMAction , BusobjProctree , BusobjTemplateOptions , JSONObject , CorrespondenceObj, busobjPQA, IntegerListObj , ProcProgressReport, procProgressLib;

type

  TBarCodeStage = (bsNone =0, bsEmployee =1 , bsSale=2, bsBatch=3);
  TBarcodeProcessStatus = (bpsNone =0, bpsDone=1, bpsFailed=2);


  TfmProcProgress = class(TBaseInputGUI)
    QrySO: TERPQuery;
    dsSO: TDataSource;
    qrysaleslines: TERPQuery;
    dssaleslines: TDataSource;
    qryemp: TERPQuery;
    dsemp: TDataSource;
    TmrIndicator: TTimer;
    pnlDetails: TDNMPanel;
    pnlSO: TDNMPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Shape2: TShape;
    DBText1: TDBEdit;
    edtQtyRemaining: TEdit;
    edtUnitofMeasureShipped: TDBEdit;
    DBText7: TDBEdit;
    DBText8: TDBEdit;
    pnlEmp: TDNMPanel;
    Label3: TLabel;
    Shape1: TShape;
    DBText2: TDBEdit;
    pnlBatch: TDNMPanel;
    Shape3: TShape;
    pnlBarcode: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    lblOptions: TLabel;
    edtBarcode: TEdit;
    AdvGlowButton1: TAdvGlowButton;
    btnGreen: TAdvGlowButton;
    btnRed: TAdvGlowButton;
    dsManQty: TDataSource;
    QryBatchQty: TERPQuery;
    QryBatchQtyBatchno: TWideStringField;
    QryBatchQtyAllocatedqty: TFloatField;
    QryBatchQtyallocateduomQty: TFloatField;
    QryBatchQtySeqno: TLargeintField;
    QryBatchQtyPartsID: TLargeintField;
    QryBatchQtyUOM: TWideStringField;
    dsBatchQty: TDataSource;
    Actions: TActionList;
    actPrint: TDNMAction;
    actHold: TDNMAction;
    actWaste: TDNMAction;
    actSave: TDNMAction;
    actclose: TDNMAction;
    actFinalise: TDNMAction;
    actRePrint: TDNMAction;
    QryBatchQtyqty: TFloatField;
    QryBatchQtyuomQty: TFloatField;
    QryBatchQtytotUOMQty: TFloatField;
    DBText5: TDBEdit;
    Label6: TLabel;
    edtAvailable: TDBEdit;
    actsales: TDNMAction;
    actBatches: TDNMAction;
    actReport: TDNMAction;
    actOnHold: TDNMAction;
    QrySerialNumber: TERPQuery;
    WideStringField1: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    LargeintField1: TLargeintField;
    LargeintField2: TLargeintField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    WideStringField2: TWideStringField;
    FloatField5: TFloatField;
    dsSerialNumber: TDataSource;
    actPQAList: TDNMAction;
    actOpenSO: TDNMAction;
    actAllocation: TDNMAction;
    dsPPG_SN_forBuildStatus: TDataSource;
    qryPPG_SN_forBuildStatus: TERPQuery;
    Label9: TLabel;
    edtAllocated: TDBEdit;
    DBEdit3: TDBEdit;
    actRemBatch: TDNMAction;
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    actHelp: TDNMAction;
    Label7: TLabel;
    Label10: TLabel;
    edtsaledatetime: TDBEdit;
    Label11: TLabel;
    pnlButtons: TDNMPanel;
    pnlFooter: TDNMPanel;
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure TmrIndicatorTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actPrintUpdate(Sender: TObject);
    procedure DoSomething(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure QryBatchQtyCalcFields(DataSet: TDataSet);
    procedure qrysaleslinesAfterOpen(DataSet: TDataSet);
    procedure QrySOAfterOpen(DataSet: TDataSet);
    procedure actsalesExecute(Sender: TObject);
    procedure actBatchesExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actOnHoldExecute(Sender: TObject);
    procedure actPQAListExecute(Sender: TObject);
    procedure actOpenSOExecute(Sender: TObject);
    procedure actAllocationExecute(Sender: TObject);
    procedure actRemBatchExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure edtQtyRemainingDblClick(Sender: TObject);
    procedure edtUnitofMeasureShippedDblClick(Sender: TObject);
  private
    SalesOrder: TSalesOrder;
    Employee  : TEmployee;
    fiEmployeeId: Integer;
    fiSaleID: Integer;
    fiSaleLineId: Integer;
    fiProctreeId: Integer;
    fsBarcode: String;
    stBarCode: TStringList;
    fsBatchno: String;
    fbProcessingBarcode:Boolean;
    fbShowreport :Boolean;
    fbShowOptions :Boolean;
    ProcProgressReportform : TProcProgressReportGUI;

    btn_save : TERPMainSwitchButton;
    btn_OnHold : TERPMainSwitchButton;
    btn_Wastage : TERPMainSwitchButton;
    btn_Print : TERPMainSwitchButton;
    btn_close : TERPMainSwitchButton;
    btn_Finalize : TERPMainSwitchButton;
    btn_RePrint : TERPMainSwitchButton;
    btn_openSO: TERPMainSwitchButton;
    btn_AllocSN: TERPMainSwitchButton;
    btn_sales : TERPMainSwitchButton;
    btn_Help : TERPMainSwitchButton;
    btn_Batches : TERPMainSwitchButton;
    btn_RemBatch : TERPMainSwitchButton;
    btn_Report : TERPMainSwitchButton;
    btn_OnHoldList : TERPMainSwitchButton;
    btn_PQAList : TERPMainSwitchButton;
    fiSNProctreeId: Integer;
    fsReportSQL:String;
    fbHasAccessForSalesOrder :Boolean;
    fbhasacessforAllowFinaliseFromProgressbuild :Boolean;
    fbHideWastage :Boolean;

    procedure NewBusObjinstance;
    procedure ChooseSale;
    procedure ChooseBatch;
    procedure OnSaleSelect(Sender: TwwDbGrid);

    procedure SetEmployeeId(const Value: Integer);
    procedure SetSaleID(const Value: Integer);
    procedure SetSaleLineId(const Value: Integer);
    procedure setProctreeId(const Value: Integer);

    procedure WarnMsg(const Value: String; btn: TWincontrol =nil; interval :Integer = 0);
    Procedure RefreshIt;
    function BarCodeStage : TBarCodeStage;
    procedure setBarCode(const Value: String);
    Procedure OnBarCodeEmployeeSelect (stBarCode :TStringList);
    Procedure OnBarCodesalesSelect    (stBarCode :TStringList);
    Procedure OnBarCodePQABatchSelect (stBarCode :TStringList);
    Procedure OnBarCodePQASNSelect    (stBarCode :TStringList);
    procedure DoOnBarCodePQABatchSelect;
    Procedure OnBarcodeProcess(BarcodeProcessStatus : TBarcodeProcessStatus);
    Procedure RefreshProcProgressReport;
    Procedure Re_RefreshProcProgressReport;
    procedure initProcProgressReport(Sender: TObject);
    procedure OnProcProgressReport(Sender: TObject);
    Procedure MakeButtons;
    Procedure OnDoneAQty(DoneQtytype : tDoneQtytype);
    Procedure OnSaveSelect;
    procedure BuildAQty(ParentProctree:TProctree;  SNProcTreeID:Integer; aSerialnumber :String;DoneQtytype : tDoneQtytype; var fdManufacturcost:Double);
    procedure LocatebatchofRowMaterialinUse;
    procedure OnbatchSelect(Sender: TwwDbGrid);
    procedure initBatches(Sender: TObject);
    procedure Batchesafteshow(Sender: TObject);
    procedure ReadGuiprefs;
    procedure WriteGuiprefs;
    procedure setshowreport(const Value: Boolean);
    procedure SetShowOptions(const Value: Boolean);
    Procedure ChoosenFinaliseOnHold;
    Procedure FinaliseOnHold(aProcTreePArtId , aProcProgressID:Integer; alloctype:String;  DoneQtytype: tDoneQtytype);
    procedure reSetbuttons;
    procedure SetSNProctreeId(const Value: Integer);
    procedure initsalelineId(Sender: TObject);
    procedure SalesPQAListByCategoryReport(Sender: TObject);
    procedure PPG_SN_forBuildStatus(var Qry: TERPQuery; const abuildstatus: String; SNProductOnly :Boolean = True);
    Function FinaliseIfanySNStarted(DoneQtytype : tDoneQtytype) :Boolean;
    Function IsanySNStarted(Const ShowMsg:Boolean = False; ExtraMsg:String='') :Boolean;
    function LockSale:Boolean;
    Procedure UnlockSale;
    procedure InitSalesList(Sender: TObject);
    procedure LocateLine(Sender: TObject);
    Procedure ShowStatus;Reintroduce;
    function SerialNumberinstock(fiProductID: Integer;aSerialnumber: String): Boolean;
    procedure MakeQryBatchQty(const fiproductId :Integer ;const sBatchno:String);
    procedure SetBatchno(const Value: String);
    function ChooseBatchestoRemove(PQABatch : TPQABatch; var BatchIds: TIntegerList):Boolean;
    procedure Logpositions;
    Procedure PPGLog(Const Value:String);
    Function ChecknConvert(Confirmbeforeconvert :Boolean):Boolean;
    procedure OncloseProcProgressReport(Sender: TObject);
    procedure SetActions;
    Function isOkToSelectSale(const aSaleID:Integer):Boolean;
    function UnlockSaleProgress(const aSaleID: Integer): Boolean;
    procedure Printreport;
    Procedure DoReprint;
    procedure DoPPGErrorEmail(const ErrorMsg, aProductname, aSerialnumber:String);


  Protected
    function GetReportTypeID: integer; override;
    Procedure AfterFormShow; override;
    procedure initPrintTemplateOptionsReport(Sender: TTemplateOptions;
                                                       var  ssql:String;
                                                       var  MasterDetailLink: TJsonObject;
                                                       var  ShowCancelPreviewBtninReportPreview :Boolean); Override;
    procedure initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions;var  OutGoingFileName:String;var Corres: TCorrespondenceGui);Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property EmployeeId :Integer read fiEmployeeId write SetEmployeeId;
    Property SaleID :Integer read fiSaleID write SetSaleID;
    Property SaleLineId :Integer read fiSaleLineId write SetSaleLineId;
    Property ProctreeId :Integer read fiProctreeId write setProctreeId;
    Property BarCode :String read fsBarcode write setBarCode;
    Property Batchno :String read fsBatchno write SetBatchno;
    Property showreport : Boolean read fbshowreport write setshowreport;
    Property ShowOptions : Boolean read fbShowOptions write SetShowOptions;
    Property SNProctreeId :Integer read fiSNProctreeId Write SetSNProctreeId;
    Function PrintBuildReport(InId: Integer; DoneQtytype : tDoneQtytype):Boolean ;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, TimedHint, tcDataUtils,
  CommonFormLib, FastFuncs, Barcodeconst, ProductQtyLib, LogLib,
  sndkey32, PQALib, DbSharedObjectsObj,
  CommonDbLib,  EmployeeAccesses, frmSimpleTypes, tcconst,
  frmMessageWithList,  frmMessageBase,
  SalesPQAListByCategory, MAIN, BOMSalesList, frmBOMAllocation, frmSalesOrder , Vista_MessageDlg,
  commonGuiLib, frmMessageWithGrid, DocReaderObj, SalesBuildStatus,
  ProcProgressAllocationReport , dateutils, MySQLConst, ProcessDataUtils,
  FrmProcProgressBarcodes , math, ERPErrorEmailUtils, AppDatabase,
  BusObjProcTreePart, BusObjProcPrefs, ERPVersionConst, BOMLib, ProductBatches;

{$R *.dfm}
procedure TfmProcProgress.ChooseSale;
begin
  OpenERPListFormModal('TBOMSalesListGUI' ,OnSaleSelect,InitSalesList);
end;
procedure TfmProcProgress.InitSalesList(Sender: TObject);
begin
  if not(Sender is TBOMSalesListGUI) then exit;
  TBOMSalesListGUI(Sender).filterString := 'Converted = ' +quotedstr('F');
  if  not(Appenv.Companyprefs.ResetSaleDateWhenBuilt)  then begin
    TBOMSalesListGUI(Sender).filterString := TBOMSalesListGUI(Sender).filterString + ' and Saledatetime < ' + Quotedstr(formatdateTime(MySQLdateTimeformat , now));
    TBOMSalesListGUI(Sender).ListTimerMsg('According to the Prefernce (Manufacture->General->Reset Sales Order Date When Built).  This is the List of Pending Jobs where Date < Current Date');

  end;
end;
procedure TfmProcProgress.OnSaleSelect(Sender: TwwDbGrid);
begin
  TForm(Sender.owner).hide;
  if Assigned(Sender.Datasource) then
    if Assigned(Sender.Datasource.Dataset) then
      if (Sender.Datasource.Dataset.Findfield('SaleId')<> nil) and (Sender.Datasource.Dataset.Findfield('SalelineID')<> nil)  then
          BarCode := 'S-'+trim(inttostr(Sender.Datasource.Dataset.Findfield('SaleId').asInteger))+'-'+trim(inttostr(Sender.Datasource.Dataset.Findfield('SalelineID').asInteger));
end;



procedure TfmProcProgress.actPQAListExecute(Sender: TObject);
begin
  inherited;
  if salelineId =0 then exit;
  OpenERPListForm('TSalesPQAListByCategoryGUI' ,initsalelineId , SalesPQAListByCategoryReport);
end;
procedure TfmProcProgress.SalesPQAListByCategoryReport(Sender: TObject);
begin
  if sender is TSalesPQAListByCategoryGUI then begin
    TSalesPQAListByCategoryGUI(Sender).Left := Self.Left +100;
    TSalesPQAListByCategoryGUI(Sender).Top := 0;
    Self.BringToFront;
  end else if sender is TSalesBuildStatusGUI then begin
    TSalesBuildStatusGUI(Sender).Left := 10;
    TSalesBuildStatusGUI(Sender).Top := 0;
    TSalesBuildStatusGUI(Sender).BringToFront;
    TSalesBuildStatusGUI(Sender).Qrymain.first;
    TSalesBuildStatusGUI(Sender).grdmain.setactivefield(TSalesBuildStatusGUI(Sender).qrymaintobebuilt.fieldname);
    Setcontrolfocus(TSalesBuildStatusGUI(Sender).grdmain);
  end else if sender is TProcProgressAllocationReportGUI then begin
    TProcProgressAllocationReportGUI(Sender).Left := 10;
    TProcProgressAllocationReportGUI(Sender).Top := 0;
    TProcProgressAllocationReportGUI(Sender).BringToFront;
    Setcontrolfocus(TProcProgressAllocationReportGUI(Sender).grdmain);
  end;
end;

procedure TfmProcProgress.initsalelineId(Sender: TObject);
begin
  if Sender is  TSalesPQAListByCategoryGUI then begin
    TSalesPQAListByCategoryGUI(Sender).SaleLineId := salelineId;
  end else if Sender is  TSalesBuildStatusGUI then begin
    TSalesBuildStatusGUI(Sender).SaleLineId := salelineId;
  end else if Sender is  TProcProgressAllocationReportGUI then begin
    TProcProgressAllocationReportGUI(Sender).SaleLineId := salelineId;
  end;
end;
function TfmProcProgress.IsanySNStarted(Const ShowMsg:Boolean = False; ExtraMsg:String='') :Boolean;
begin
  REsult := False;
      PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'B');
      if qryPPG_SN_forBuildStatus.RecordCount >0 then begin
        REsult := True;
        if ShowMsg then
          MessageDlgLargefont('You have Already Started with Serial Number ' +quotedStr(qryPPG_SN_forBuildStatus.fieldbyname('Serialnumber').asString)+'.' +  ExtraMsg,''  ,  mtWarning, [mbOK], 0);
      end;
end;

procedure TfmProcProgress.actPrintUpdate(Sender: TObject);
begin
    //
end;



function TfmProcProgress.BarCodeStage: TBarCodeStage;
begin
       if (Batchno <> '')                          then result := bsBatch
  else if (SaleID    >0) and (SalesOrder.count >0) and (SalesOrder.lines.count > 0) then result := bsSale
  else if (EmployeeID >0) and (Employee.count   >0) then result := bsEmployee
  else result := bsNone;
end;
procedure TfmProcProgress.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmProcProgress.SetBatchno(const Value: String);
begin
  fsBatchno := Value;
  MakeQryBatchQty(SalesOrder.lines.Rootproctree.Children.PartsId , fsBatchno);
  RefreshProcProgressReport;
  pnlBatch.visible := CanShowBatchetailsinProgressBuild and (QryBatchQty.active) and ( QryBatchQty.recordcount >0);
  Refreshit;
end;

procedure TfmProcProgress.SetEmployeeId  (const Value: Integer);
begin
  if fiEmployeeId <> Value then begin
    fiSaleID := 0;
    fiSaleLineId := 0;
    fiEmployeeId := Value;
    Employee.load(Value)  ;
    pnlemp.visible := Employee.Count >0;
    pnlSO.visible := False;
    try Freeandnil(ProcProgressReportform); Except end;
    if (Value>0) and (Employee.Count=0) then WarnMsg( 'Invalid Employee Selection');
    fbHasAccessForSalesOrder := EmployeeHasAccess('TSalesOrderGUI');
    fbhasacessforAllowFinaliseFromProgressbuild := Employeehasaccess('AllowFinaliseFromProgressbuild');
    fbHideWastage := False;

  end;
end;
procedure TfmProcProgress.setProctreeId(const Value: Integer);
begin
  if fiProctreeId <> Value then begin
    fiProctreeId := Value;
    SalesOrder.Lines.Rootproctree;
    if SalesOrder.Lines.Rootproctree.Children.Count >0 then
      While SalesOrder.Lines.Rootproctree.Children.Eof = false do begin
        if SalesOrder.Lines.Rootproctree.Children.Batch then begin
          LocatebatchofRowMaterialinUse;
          RefreshProcProgressReport;
          Exit;
        end;
        SalesOrder.Lines.Rootproctree.Children.Next;
      end;
  end;
end;

procedure TfmProcProgress.SetSaleID     (const Value: Integer);
var
  dt:TDatetime;
begin
  if employeeId =0 then begin
    WarnMsg( 'Please scan Employee Card');
    exit;
  end;
  if IsSaleConverted(Value) then begin
    WarnMsg( 'This Sale # '+inttostr(Value) +' is Already Converted.  It is not Possible to do Progress Build Any more.'+iif(devmode , NL+NL+'Sale Selected in DEVMODE, to VIEW only','') );
    if not devmode then exit;
  end;
  if fiSaleId <> Value then begin
    try
         if (fiSaleId <> 0) and not(Appenv.Companyprefs.ResetSaleDateWhenBuilt) then begin
            dt:= SalesSaleDatetime(fiSaleId) ;
            if dt>= now then begin
              WarnMsg( 'According to the Preference (Manufacture->General->Reset Sales Order Date When Built),'+NL+
                        'Future Dated Sales Orders Cannot be built.  This Sales Order #'+inttostr(fiSaleId)+' is Dated '+ FormatDateTime(FormatSettings.shortDateformat +' HH:NN:SS Am/PM' , dt)+'.'+NL+
                        'Please Choose Another Sales Order.' , edtsaledatetime, 30);
              exit;
            end;
         end;

      if (fiSaleId <> 0) then UnlockSaleProgress(fiSaleId);

      fiSaleLineId:=0;
      fiProcTreeID :=0;
      fsbatchno := '';
      fiSaleId := 0;
      lblOptions.REfresh;
      SalesOrder.Load(0);
      REfreshIt;
      if fbShowoptions then lblOptions.caption := '(   F9 to Hide Options )' else lblOptions.caption := '(   F9 For Options )';
      if isOkToSelectSale(Value) = false then exit;
      fiSaleId := Value;
      SalesOrder.Load(Value);
      pnlSO.visible := SalesOrder.Count >0;
      if fiSaleId =0 then else
      if (SalesOrder.Count=0) or (SalesOrder.Lines.Count=0) then WarnMsg( 'Invalid Sales Order  Selection')
      else  if SalesOrder.Lines.LineCompletelyBuilt   then begin
            WarnMsg( 'This Product is Completely Built');
            SalelineId := SalesOrder.Lines.ID;
            exit;
      end else begin
        SalesOrder.Lines.first;
        While SalesOrder.Lines.EOF = false do begin
            if SalesOrder.Lines.IsTreeItem then begin
              SalelineId := SalesOrder.Lines.ID;
              Exit;
            end;
            SalesOrder.Lines.next;
        end;

      end;
    finally
        Re_RefreshProcProgressReport; // kill the form and show again to reinitialise the saleId
    end;
  end;
end;

procedure TfmProcProgress.SetSaleLineId(const Value: Integer);
var
  fi:Integer;
begin
  if fiSaleLineId <> Value then begin
    fiSaleLineId := Value;
    fi:=SaleIDofLine(Value);

    if (saleId =0) or (SalesOrder.count=0) or (SalesOrder.ID <> fi) then saleId :=fi;


    if SalesOrder.count >0 then
              if not SalesOrder.Lines.locate('salelineId' , Value , []) then WarnMsg( 'Invalid Sales Order  Selection')
        else  if not(SalesOrder.Lines.IsTreeItem) or (SalesOrder.Lines.Rootproctree.count =0) then WarnMsg( 'Selected Product is not getting Manufactured')
        else ProctreeId := SalesOrder.Lines.Rootproctree.ID;
    fbHideWastage := SalesOrder.Lines.Product.HideWastage;
  end;
end;

procedure TfmProcProgress.SetShowOptions(const Value: Boolean);
begin
  fbShowOptions := Value;
  pnlButtons.visible := Value;
  if value then width := 900 else width := 750;
  if Value then resetbuttons;
  Setcontrolfocus(edtBarcode);
  if value then lblOptions.caption := '(   F9 to Hide Options )' else lblOptions.caption := '(   F9 For Options )';
end;

procedure TfmProcProgress.setshowreport(const Value: Boolean);
begin
    fbshowreport := Value;
    if value then RefreshProcProgressReport;
end;

procedure TfmProcProgress.SetSNProctreeId(const Value: Integer);
begin
  fiSNProctreeId := Value;

end;

procedure TfmProcProgress.ShowStatus;
begin
  if (SalesOrder.count =0) or (SalesOrder.lines.count =0) then  begin
     if pnlButtons.visible then   lblOptions.caption := '(   F9 to Hide Options )' else lblOptions.caption := '(   F9 For Options )';
     lblOptions.REfresh;
      Exit;
  end;
  if SalesOrder.Lines.LineCompletelyBuilt  then begin
    lblOptions.caption := 'This Product is Completely Built.';
    lblOptions.REfresh;
    Exit;
  end;
  PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'B');
  if (qryPPG_SN_forBuildStatus.recordcount >0)and (qryPPG_SN_forBuildStatus.fieldbyname('Serialnumber').asString <> '') then begin
    lblOptions.caption := Quotedstr(qryPPG_SN_forBuildStatus.fieldbyname('ProductName').asString )+'''s Serial Number ' +Quotedstr(qryPPG_SN_forBuildStatus.fieldbyname('Serialnumber').asString )+NL+
                                  ' In Progress.  Choose ''PRINT'' to Finish It';
    lblOptions.REfresh;
    Exit;
  end;

  PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'H');
  if (qryPPG_SN_forBuildStatus.recordcount >0)and (qryPPG_SN_forBuildStatus.fieldbyname('Serialnumber').asString <> '') then begin
    lblOptions.caption := 'There are ' + inttostr(qryPPG_SN_forBuildStatus.recordcount) +' Product(s) on Hold.  ' +
                          'Please Choose ' + NL+ '''On Hold Product(s)'' to Finish, OR Start a New Product';
    lblOptions.REfresh;
    Exit;
  end;

      if SalesOrder.Lines.RootprocTree.IsAnychildrenSNTracking then
        lblOptions.caption :='Scan Serial Number to Start the Next Product'
      else if SalesOrder.Lines.RootprocTree.IsAnychildrenBatchTracking and (QryBatchQty.fieldbyname('AllocateduomQty').asfloat <= 0) then
        lblOptions.caption :='Please Choose the Batch for Raw Materials'
      else
        lblOptions.caption :='Please Choose PRINT to Finish the Next Product';
      lblOptions.REfresh;
      Exit;
  
  if pnlButtons.visible then   lblOptions.caption := '(   F9 to Hide Options )' else lblOptions.caption := '(   F9 For Options )';
  lblOptions.REfresh;
end;

procedure TfmProcProgress.TmrIndicatorTimer(Sender: TObject);
begin
  inherited;
  btnRed.Visible := False;
  btngreen.Visible := False;
  TmrIndicator.Enabled := false;
end;


procedure TfmProcProgress.WarnMsg(const Value: String;  btn: TWincontrol=nil; interval :Integer = 0);
begin
  if not IsFormshown then exit;
  if btn = nil then btn := btnred;
  btn.Visible := TRue;
  TmrIndicator.Enabled := TRue;
  if interval =0 then interval := TmrIndicator.interval else interval := MilliSeconds(interval);
  ShowTimedHint(btn ,Value, False ,interval);

end;

procedure TfmProcProgress.WriteGuiprefs;
begin
  GuiPrefs.Node['Options.Showreport'].asBoolean := Showreport;
  GuiPrefs.Node['Options.ShowOptions'].asBoolean := ShowOptions;
end;

procedure TfmProcProgress.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;

end;

procedure TfmProcProgress.edtUnitofMeasureShippedDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProcProgressAllocationReportGUI' ,initsalelineId , SalesPQAListByCategoryReport);
end;

procedure TfmProcProgress.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  Procedure RefreshRemainingQty(proctreeRoot : TproctreeRoot);
  begin
      edtQtyRemaining.text := FloattoStrF(proctreeRoot.TotalQty -  proctreeRoot.ManufacturedUOMQty, ffGeneral ,15,2);
  end;
begin
     inherited;
     if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_BeforeOpen) then begin
      Logtime(inttostr(integer(sender)) +'(Before Open):' + sender.heirarchyname);
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
      Logtime(inttostr(integer(sender))+'(After Open):' + inttostr(sender.count) + ':' +sender.sql +sender.heirarchyname);
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterClose) then begin
      Logtime(inttostr(integer(sender))+'(After Close)' );
     end;

     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TSalesOrder     then TSalesOrder(Sender).Dataset      := QrySO
        else if Sender is TSalesOrderLine then TSalesOrderLine(Sender).Dataset  := qrysaleslines
        else if Sender is TEmployee       then TEmployee(Sender).Dataset        := qryEmp;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen ) then begin
             if Sender is TproctreeRoot   then begin
              dsManQty.DataSet :=  TproctreeRoot(Sender).dataset;
              TFloatfield(TproctreeRoot(Sender).dataset.fieldbyname('ManufacturedUOMQty')).Alignment := taLeftJustify;
              RefreshRemainingQty(TproctreeRoot(Sender));
             end;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost ) then begin
             if Sender is TproctreeRoot   then begin
                RefreshRemainingQty(TproctreeRoot(Sender));
             end;
    end else if (Eventtype = BusobjEvent_Event) and (Sender.IsdataIdchangeEvent(Value) ) then begin
             if Sender is TproctreeRoot   then begin
                RefreshRemainingQty(TproctreeRoot(Sender));
             end;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusObjEventVal_OnAfterSave  ) then begin
      if sender is TPRocProgress then begin
      end;
    end;
end;

procedure TfmProcProgress.edtBarcodeKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_f9) then begin
    ShowOptions := not(ShowOptions);
  end;
end;

procedure TfmProcProgress.edtBarcodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not fbProcessingBarcode then
    Try
      fbProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;
        Barcode := Uppercase(edtBarcode.Text);
        edtBarcode.Text := '';
        Setcontrolfocus(edtBarcode);
      end;
    Finally
      fbProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then Key := #0;

end;

procedure TfmProcProgress.edtQtyRemainingDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesBuildStatusGUI' ,initsalelineId , SalesPQAListByCategoryReport);
end;

function TfmProcProgress.FinaliseIfanySNStarted(DoneQtytype : tDoneQtytype) :Boolean;
begin
  REsult := False;
      PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'B' , False);
      try
        if qryPPG_SN_forBuildStatus.RecordCount >0 then begin
          if not Locksale then Exit;
          try
            qryPPG_SN_forBuildStatus.First;
            Salesorder.Connection.beginTransaction;
            try
              While qryPPG_SN_forBuildStatus.Eof = False do begin
                FinaliseOnHold(qryPPG_SN_forBuildStatus.fieldbyname('ProcTreePArtId').asInteger ,  qryPPG_SN_forBuildStatus.fieldbyname('ProcProgressID').asInteger , qryPPG_SN_forBuildStatus.fieldbyname('Alloctype').asString , DoneQtytype);
                qryPPG_SN_forBuildStatus.Next;
              end;
              Salesorder.Connection.CommitTransaction;
              RefreshProcProgressReport;
             Except
              on E:Exception do begin
                  Salesorder.Connection.RollbackTransaction;
              end;
             end;
          finally
            UnlockSale;
          end;
          REsult := True;
        end;
      finally
        PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'B' , True);
      end;
end;

procedure TfmProcProgress.FinaliseOnHold(aProcTreePArtId , aProcProgressID:Integer; alloctype:String;DoneQtytype: tDoneQtytype);
var
  ProcProgress : TProcProgress;
Function  RemoveManufacturedSerialnumber(aProctree:TProctree; aSerialNumber: String):Boolean ;
begin
    result := False;
    if aSerialNumber = '' then exit;

        if aProcTreePArtId = aProctree.ProctreePart.ID then begin
               if (aProctree is TproctreeRoot)  and (aProctree.ProctreePart.PQA.pqasn.locate('Value' , aSerialnumber , [])) then aProctree.ProctreePart.PQA.pqasn.Delete
          else if (not (aProctree is TproctreeRoot)  ) and (aProctree is Tproctree)      and (aProctree.ProctreePart.SubNodeManufcaturePQA.pqasn.locate('Value' , aSerialnumber , [])) then
            aProctree.ProctreePart.SubNodeManufcaturePQA.pqasn.Delete;
          aProctree.ManufactureduomQty := aProctree.ManufactureduomQty-1;
          aProctree.PostDB;
          aProctree.ProctreePart.ManufactureduomQty := aProctree.ProctreePart.ManufactureduomQty -1;
          aProctree.ProctreePart.PostDB;
          Result := True;
          exit;
        end;

    if aProctree.Children.count =0 then exit;
    aProctree.Children.First;
    While aProctree.Children.EOF = False do begin
      if  RemoveManufacturedSerialnumber(aProctree.Children , aSerialnumber) then begin
        REsult := True;
        exit;
      end;
      aProctree.Children.next;
    end;
end;
begin
  if Alloctype ='IN' then
    ProcProgress := TProcProgressIN.create(Self)
  else ProcProgress := TProcProgressOut.create(Self);
  try
    ProcProgress.Connection := SalesOrder.Connection;

    ProcProgress.load(aProcProgressID);
    if ProcProgress.count>0 then begin

          if (DoneQtytype = dqtWastage) and (aProcTreePArtId <> 0) and (Alloctype ='IN') then begin
             RemoveManufacturedSerialnumber(SalesOrder.Lines.Rootproctree , ProcProgress.PQA.PQASN.Serialnumber);
          end;

          ProcProgress.BuildStatus :=DoneQtytypetoStr(DoneQtytype) ;
          ProcProgress.PostDB;
          if (ProcProgress.alloctype ='IN') and (DoneQtytype in [dqtOk,dqtHold]) and (ProcProgress.PQA.PQASN.count>0) then  begin
            PrintBuildReport(ProcProgress.Id , dqtOk );
            MessageDlgLargefont('Serial Number ' + Quotedstr(ProcProgress.PQA.PQASN.Serialnumber) +' of ' + Quotedstr(getProduct(ProcProgress.ProductID)) + ' is Put into Stock', '', mtInformation, [mbOK], 0);
          end else if (ProcProgress.alloctype ='IN') and (DoneQtytype in [dqtWastage])  and (ProcProgress.PQA.PQASN.count>0) then  begin
            ProcProgress.ReasonID := TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_BOM_WastageReason, true, true);
            ProcProgress.PostDB;
            PrintBuildReport(ProcProgress.Id , dqtWastage );
          end;
    end;
  finally
    Freeandnil(ProcProgress);
  end;
end;

procedure TfmProcProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  WriteGuiprefs;
end;

procedure TfmProcProgress.FormCreate(Sender: TObject);
begin
  fsReportSQL:='';
  showreport := False;
  ShowOptions := False;
  inherited;
  fbProcessingBarcode := False;
  NewBusObjinstance;
  stBarCode         := TStringList.Create;
  MakeButtons;
  edtAvailable.Visible := Devmode;
  fbHasAccessForSalesOrder := False;
  fbhasacessforAllowFinaliseFromProgressbuild := False;
end;
procedure TfmProcProgress.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stBarCode);
  FreeandNil(salesOrder);
  FreeandNil(Employee);
  inherited;
end;

procedure TfmProcProgress.reSetbuttons;
begin
  inherited;
  if not(IsFormshown) then exit;

  btn_save.visible    := False;

  btn_Batches.visible   := SalelineID >0;
  btn_RemBatch.visible  := SalelineID >0;
  btn_OnHoldList.visible:= SalelineID >0;
  btn_Report.visible    := SalelineID >0;
  btn_Help.visible      := True;
  btn_sales.visible     := True;
  btn_PQAList.visible   := devmode and (SalelineID >0);
  btn_AllocSN.visible   := devmode ;
  btn_openSO.visible    := devmode ;

  btn_PQAList.top     := 0;
  btn_OnHoldList.top  := 0;
  btn_Report.top      := 0;
  btn_RemBatch.top    := 0;
  btn_Batches.top     := 0;
  btn_Help.top        := 0;
  btn_sales.top       := 0;

  ImageDLLLib.AlignbuttonTopnHeight(self, pnlButtons , true);
  ImageDLLLib.AlignbuttonLeftnWidth(self, pnlFooter , true);
end;

procedure TfmProcProgress.Re_RefreshProcProgressReport;
begin
      if showreport then begin
        try
          Freeandnil(ProcProgressReportform);
        Except
          // kill the form if form is not created yet
        end;
        RefreshProcProgressReport;
      end;
end;

procedure TfmProcProgress.FormShow(Sender: TObject);
begin
  inherited;
  OnBarcodeProcess(bpsNone);
  EmployeeId := appenv.Employee.EmployeeID;
  RefreshIt;
  ReadGuiprefs;
  if not(userlock.Enabled) then userlock.Enabled := True;
  Logpositions;
  SetActions;
end;
Procedure TfmProcProgress.Logpositions;
begin

end;
function TfmProcProgress.GetReportTypeID: integer;
begin
  REsult := 158;
end;

procedure TfmProcProgress.NewBusObjinstance;
begin
  Employee := TEmployee.CreateWithNewConn(Self);
  Employee.Connection.connection := Self.MyConnection;
  Employee.BusObjEvent := DoBusinessObjectEvent;

  SalesOrder := TSalesOrder.Create(Self);
  SalesOrder.Connection := Employee.Connection;
  SalesOrder.BusObjEvent := DoBusinessObjectEvent;



end;


procedure TfmProcProgress.ReadGuiprefs;
begin
  Showreport:= False;
  ShowOptions:= GuiPrefs.Node['Options.ShowOptions'].asBoolean;
end;

procedure TfmProcProgress.RefreshIt;
var
  fBarCodeStage : TBarCodeStage;
  fiheight :Integer;
begin
  fiheight:=0;
  try
    fBarCodeStage :=BarCodeStage;
    fiheight := pnltop.height +pnlBarcode.height +pnlEmp.height +pnlFooter.height;
    try
      if fBarCodeStage >= bsEmployee  then fiheight := fiheight +  pnlemp.Height;
      if fBarCodeStage >= bssale      then fiheight := fiheight +  pnlSO.Height;
      if (fBarCodeStage >= bsBatch) and CanShowBatchetailsinProgressBuild    then fiheight := fiheight +  pnlBatch.Height;
      pnlBatch.visible := CanShowBatchetailsinProgressBuild and (QryBatchQty.active) and ( QryBatchQty.recordcount >0) and (fBarCodeStage >= bsBatch);
      Showstatus;
    finally
      if fiheight <> self.height then self.height := fiheight;
      reSetbuttons;
    end;
    SetcontrolFocus(edtBarcode);
  Except
    on E:EXception do begin
      if fiheight <> self.height then self.height := fiheight;
    end;
  end;
end;
procedure TfmProcProgress.setBarCode(const Value: String);
begin
try
DoShowProgressbar(10, WAITMSG);
try
  ProgressPostionRelatetoform(Self, ppRightBottom); // to move it away from the messages if any
    try
      try
        btnRed.Visible := False;
        Hidehint(btnRed);
        Hidehint(btngreen);
        fsBarcode := Value;

        stBarCode.Clear;
        if Value ='' then exit;
        fastfuncs.Split(Value,Barcode_SepChar,stBarCode);
        if stBarCode.Count =0 then exit;
                 if sametext(stBarCode[0] , Barcode_Prefix_Employee) then begin OnBarCodeEmployeeSelect (stBarCode);
        end else if sametext(stBarCode[0] , Barcode_Prefix_Sale    ) then begin OnBarCodesalesSelect    (stBarCode);
        end else if sametext(stBarCode[0] , Barcode_Prefix_PQABATCH) then begin OnBarCodePQABatchSelect (stBarCode);
        end else if sametext(stBarCode[0] , Barcode_Prefix_PQASN   ) then begin OnBarCodePQASNSelect    (stBarCode);
        end else if sametext(stBarCode[0] , Barcode_Prefix_PQACOMB ) then begin
        end else if sametext(stBarCode[0] , actClose.caption       ) then begin Self.close                            ;Exit;
        end else if sametext(stBarCode[0] , actFinalise.caption    ) then begin ChecknConvert(False)                  ;Exit;
        end else if sametext(stBarCode[0] , actRePrint.caption     ) then begin DoReprint                             ;Exit;
        end else if sametext(stBarCode[0] , actSave.caption        ) then begin OnSaveSelect;
        end else if sametext(stBarCode[0] , actHOld.caption        ) then begin OnDoneAQty(dqtHold);
        end else if sametext(stBarCode[0] , actWaste.caption       ) then begin OnDoneAQty(dqtWastage);
        end else if sametext(stBarCode[0] , actPrint.caption       ) then begin OnDoneAQty(dqtOk);
        end;
        ChecknConvert(true);
      Except
        on E:Exception do begin
        end;
      end;
    finally
      Refreshit;
    end;
finally
  DoHideProgressbar;
end;
finally
  SetActions;
end;
end;
Procedure TfmProcProgress.SetActions;
var
  ctr:Integer;
begin
  for ctr := 0 to componentcount -1 do
    if components[ctr] is TDnmAction then
           if (components[ctr] = actclose) then
      else if (components[ctr] = actsales) then
      else if (components[ctr] = actHelp) then
      else TDnmAction(components[ctr]).Enabled := (BarCodeStage >= bssale) ;

    if (fiSaleLineID=0) OR (fbHideWastage) then actWaste.Enabled := False;
    if (fiSaleLineID=0) then actReprint.Enabled := False;
    if (SaleID=0) OR (fbHasAccessForSalesOrder=False) then actOpenSO.Enabled := False;
    if not(fbhasacessforAllowFinaliseFromProgressbuild) then actFinalise.Enabled := False
    else if (fiSaleID=0) OR (fbHasAccessForSalesOrder=False) then actFinalise.Enabled := False
    else actFinalise.Enabled := TRue;
end;
Procedure TfmProcProgress.Printreport;
begin
  if CanShowProgressBuildReport then begin
    actReportExecute (actReport);
    if ProcProgressReportform <> nil then begin
      ProcProgressReportform.Printreport;
    end;
  end;

end;
Function TfmProcProgress.ChecknConvert(Confirmbeforeconvert :Boolean):Boolean;
var
  SOList:TIntegerList;
  msg:String;
  fbConvertCurrent :Boolean;
  opt:Word;
  fSalesRelatedObj:TSalesRelated;
  Function SalesRelatedObj: TSalesRelated;
  begin
    fSalesRelatedObj:= TSalesRelated.Create(Self);
    REsult := fSalesRelatedObj;
  end;
begin

  fbConvertCurrent :=False;
  Result := False;
  if not(fbhasacessforAllowFinaliseFromProgressbuild) then exit;
  if not (Assigned(SalesOrder)) or (SalesOrder.Count =0) then exit;
  if SalesOrder.converted then exit;
  if Confirmbeforeconvert then begin
    if not SalesOrder.allBuilt then exit;
    if MessageDlgXP_Vista('This Order is completely Built. Do You Wish To Finalise and Convert? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  end else if not SalesOrder.allBuilt then begin
    Opt:= MessageDlgXP_Vista('This Order is NOT completely Built. Do You Wish To Finalise and Convert? ', mtConfirmation, [], 0 , nil , '' , '' , False, nil ,
        iif(AllowFullconvertofIncompleteOrder, 'Finalise n Convert,', '')+ 'Convert Built Stock,Cancel');

      if AllowFullconvertofIncompleteOrder then begin
          if opt = 100 then fbConvertCurrent :=False
          else if opt = 101 then fbConvertCurrent :=true
          else exit;
      end else begin
        if opt = 100 then fbConvertCurrent :=true
        else exit;
      end;
  end;

  if fbConvertCurrent then
    if MessageDlgXP_Vista('Do You Wish To Print a Report Before Finalize?', mtWarning, [mbYes, mbNo], 0) = mryes then
      Printreport;

  SOList:= TIntegerList.create;
  try
      SOList.add(SalesORder.ID);
      BeginTransaction;
      try
        UnlockSaleProgress(saleID);
        try
          try
              if ProcessDataUtils.CompleteAndConvertOrders(SalesRelatedObj.DoConfirmQtysOnfinalise, SOList, TERPConnection(SalesORder.Connection.Connection), msg, true , fbConvertCurrent) then begin
                logtext('23');
                Salesorder.Connection.CommitTransaction;
                logtext('24');
                MessageDlgXP_Vista('Sales Order #' +inttostr(Salesorder.ID) +' Is Finalised.' , mtInformation, [mbOK], 0);
                SaleId :=0;
              end else begin
                Salesorder.Connection.RollbackTransaction;
                if msg <> '' then MessageDlgXP_Vista('Finalising Sales Order #' +inttostr(Salesorder.ID) +' Failed.' + Nl +  msg + Nl+NL+'It is not possible to finalise this build.', mtWarning, [mbOK], 0);
                result := False;
                Exit;
              end;
          finally
            FreeandNil(fSalesRelatedObj);
          end;
        finally
          if saleID <> 0 then isOkToSelectSale(saleID);
        end;
      finally
        CommitTransaction;
      end;

  finally
      freeandnil(soList);
  end;
end;
Procedure TfmProcProgress.OnBarCodeEmployeeSelect (stBarCode :TStringList);
begin
  if stBarCode.count >= 2 then EmployeeId :=  strtoint(stBarCode[1]);
end;
Procedure TfmProcProgress.OnBarCodesalesSelect    (stBarCode :TStringList);
begin
        if (stBarCode.count >= 3) and (isinteger(stBarCode[2])) then saleLineID :=  strtoint(stBarCode[2])
  else  if (stBarCode.count >= 2) and (isinteger(stBarCode[1])) then saleID     :=  strtoint(stBarCode[1]);
end;
Procedure TfmProcProgress.OnBarCodePQABatchSelect (stBarCode :TStringList);
var
  fiProductId:Integer;
  ctr:Integer;
begin
  if stBarCode.Count <3 then begin
    WarnMsg( 'Invalid Batch Format');
    exit;
  end;

  if (saleId =0) or (SalelineID =0) or (ProcTreeId =0) then begin
    WarnMsg( 'Please Choose the JOB');
    exit;
  end;

  fiProductId:=0;
  if stBarCode.count >= 2 then fiProductId :=  strtoint(stBarCode[1]);

  if SalesOrder.Lines.RootprocTree.Children.locate('PartsId' ,fiProductId , []) = false then begin
      WarnMsg( 'Invalid Product-Batch Selection');
      exit;
  end;
  if SalesOrder.Lines.RootprocTree.Children.batch = False then begin
      WarnMsg( 'Product ' + Quotedstr(SalesOrder.Lines.RootprocTree.Children.ProcTreePart.ProductName)+' is not using Batch');
      exit;
  end;

  fsBatchno :=  '';
  if stBarCode.count >= 3 then
    for ctr:= 2 to stBarCode.count-1 do begin
      if fsBatchno <> '' then fsBatchno :=  fsBatchno +'-';
      fsBatchno :=  fsBatchno +stBarCode[ctr];
    end;




  MakeQryBatchQty(fiproductId , fsBatchno);


      if  (QryBatchQtySeqno.asinteger = 1) and (QryBatchQtyQty.AsFloat >0) then begin
        DoOnBarCodePQABatchSelect;
        RefreshProcProgressReport;
      end;
    pnlBatch.visible := CanShowBatchetailsinProgressBuild and (QryBatchQty.active) and ( QryBatchQty.recordcount >0);
end;
Procedure TfmProcProgress.MakeQryBatchQty(const fiproductId :Integer; const sBatchno:String);
begin
  closedb(QryBatchQty);
    QryBatchQty.SQl.text := SQL4ProductQty(0,SalesOrder.Lines.RootprocTree.Children.ProcTreePart.UnitOfMeasure, tDetails , fiproductId,SalesOrder.SaleClassId,Batchno,0, '', '','',tAvailable, '','', 0,True, True, true,true,true) ;
    QryBatchQty.SQl.text := replacestr(QryBatchQty.SQl.text , 'SELECT P.PartsID,  ' , 'SELECT 1 as Seqno ,P.PartsID,' );
    QryBatchQty.SQl.add('union all  ' +
                    ' SELECT 2 as Seqno,  P.PartsID,  P.PARTNAME , null as PreferredLevel, ' +
                        ' PQA.UOM, ' +
                        ' PQA.DepartmentID,null as ClassName, ' +
                        ' PQABatch.Value as Batchno, ' +
                        ' PQABatch.ExpiryDate , ' +
                        ' PQABatch.TruckLoadNo , ' +
                        ' Sum(PQABatch.qty) as Qty, ' +
                        ' Sum(PQABatch.uomqty) as UOMQty ' +
                        '  FROM `tblParts` as P ' +
                        ' inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID and PQA.transId = ' + inttostr(SalesOrder.Id) +
                                                                                  ' and PQA.transLineId = ' + inttostr(SalesOrder.Lines.RootprocTree.Children.ProcTreePart.ID) + // if there are more than 1 instance of the product.. need to do
                                                                                  ' and PQA.transtype = "TProcTreePart"  ' +
                                                                                  ' and PQA.alloctype ="OUT" ' +
                        ' inner join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  ' +
                        iif(sBatchno <> '' , ' and PQABatch.Value =' +Quotedstr(sBatchno)+'' , '')) ;
    QryBatchQty.SQl.text := 'Select 1 as Seqno  ,PartsID , UOM,  Batchno , '+
                            ' sum(if(Seqno=1, qty,0)) as qty , sum(if(Seqno=2, qty,0)) as Allocatedqty ,  '+
                            ' sum(if(Seqno=1, uomQty,0)) as uomQty , sum(if(Seqno=2, uomQty,0)) as AllocateduomQty  '+
                            ' from (' + QryBatchQty.SQl.text +') details';
    QryBatchQty.SQl.add('union all  ' +
                    ' SELECT 2  as seqno , 0 as PartsID ,"" as UOM,'+
                    ' ' +quotedstr(batchno) +' as Batchno, '+
                    '0 as Qty, 0 as  Allocatedqty , '+
                    '0 as UOMQty , 0 as AllocateduomQty' +
                    ' order by seqno limit 1');
   Opendb(QryBatchQty);
end;

procedure TfmProcProgress.DoOnBarCodePQABatchSelect;
var
  fdQty1 , fdQty2 :Double;
begin
  if not LockSale then exit;
  try
    try
      if SalesOrder.Lines.RootprocTree.Children.Count = 0 then exit;
      fdQty1 := Round(QryBatchQtyQty.AsFloat , SalesOrder.RoundPlacesGeneral);
      fdQty2 := 0;
      SalesOrder.Lines.RootprocTree.Children.First;
      {}while SalesOrder.Lines.RootprocTree.Children.Eof = False do begin
    {--}if (SalesOrder.Lines.RootprocTree.Children.PartsId = QryBatchQtyPartsID.AsInteger)   then begin
            try
              fdQty2 := Round(SalesOrder.Lines.RootprocTree.Children.TotalQty, SalesOrder.RoundPlacesGeneral);
              fdQty2 :=  Round(fdQty2 - SalesOrder.Lines.RootprocTree.Children.ManufacturingQty, SalesOrder.RoundPlacesGeneral){already built};
              SalesOrder.Lines.RootprocTree.Children.Proctreepart.PQA.PQABatch.Closedb;// to refresh the object
              fdQty2 :=  Round(fdQty2 - SalesOrder.Lines.RootprocTree.Children.Proctreepart.PQA.PQABatch.TotalAllocated , SalesOrder.RoundPlacesGeneral){allocated batch - not used};
            except
              on E:Exception do begin
                if devmode then MessageDlgLargefont(e.message, '', mtWarning, [mbOK], 0);
              end;
            end;
            if fdQty2 >0 then begin
              SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.postdb;
              if (SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.batchno <> QryBatchQtyBatchno.asString) and (SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.locate('Value' , QryBatchQtyBatchno.asString , []) = false) then begin
                  SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.New;
                  SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.BatchNo :=QryBatchQtyBatchno.asString ;
                  SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.postdb;
              end;
              if fdQty2 > fdQty1 then begin
                SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.Qty := SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.Qty + fdQty1;
                fdQty2 := round(fdQty2 - fdQty1, SalesOrder.RoundPlacesGeneral);
                fdQty1 := round(fdQty1 - fdQty1, SalesOrder.RoundPlacesGeneral);
              end else begin
                SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.Qty := SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.Qty + fdQty2;
                fdQty1 := round(fdQty1 - fdQty2, SalesOrder.RoundPlacesGeneral);
                fdQty2 := 0;
              end;
              SalesOrder.Lines.RootprocTree.Children.ProctreePart.PQA.pqabatch.PostDB;
            end;
    {--}end;
        if fdQty1 <=0 then break;
        SalesOrder.Lines.RootprocTree.Children.Next;
    {}end;
   Except
    on E:Exception do begin
        Salesorder.Connection.RollbackTransaction;
    end;
   end;
  finally
    Unlocksale;
    LocatebatchofRowMaterialinUse;
  end;
end;

procedure TfmProcProgress.DoSomething(Sender: TObject);
var
  Key: Char;
begin
  inherited;
  if sender is TDNMAction then begin
    edtBarcode.text := replacestr(TDNMAction(Sender).Caption ,'&&' , '&');
    key :=Chr(VK_RETURN);
    edtBarcodeKeyPress(edtBarcode, key);
  end;
end;
Function TfmProcProgress.SerialNumberinstock(fiProductID:Integer ; aSerialnumber:String):Boolean;
var
  qry :TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.Text:= SQL4ProductQty( 0,'', tDetailswithSno , fiproductId,Salesorder.SaleClassId,'',0, '','',aSerialnumber, tAvailable, '','', 0,True, True, true,true,true) ;
    qry.Open;
    result := (qry.recordcount >0) and (qry.fieldbyname('uomQty').AsFloat >=1);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Procedure TfmProcProgress.OnBarCodePQASNSelect    (stBarCode :TStringList);
var
  fiProductId:Integer;
  ctr:Integer;
  aSerialNumber:String;
  parentProcTree, SNProctree:TProctree;
  abort :boolean;
  fdBuiltcost :Double;

Function AddSerialNumbertoOrder(aProctree:TProctree;  fiProductID:Integer ; aSerialnumber:String; var abort :Boolean):Boolean;
var
  fdQty2:Double;
begin
  Result := False;
  if aSerialnumber = '' then exit;

  if aProctree.Children.Count >0 then begin
    aProctree.Children.First;
    while aProctree.Children.Eof = False do begin
      if AddSerialNumbertoOrder(aProctree.Children , fiProductId , aSerialnumber , abort) then begin
        if not abort then parentProcTree:= aProctree;
        abort := TRue;
        REsult := TRue;
        Exit;
      end else if abort then begin
        Exit;
      end;
      aProctree.Children.next;
    end;
  end else if aProctree.Proctreepart.ProductID =  fiProductID then begin
    if aProctree.Proctreepart.Product.SNTracking then begin
              fdQty2 := aProctree.TotalQty;
              fdQty2 :=  fdQty2 - aProctree.ManufacturingQty{already built};
              fdQty2 :=  fdQty2 + aProctree.WastageQty{Wasted Qty};
              fdQty2 :=  fdQty2 - aProctree.Proctreepart.PQA.PQASN.TotalAllocated {allocated batch - not used};

      if fdQty2 >= 1 then begin
          if MessageDlgLargefont('This Serial Number ' +quotedstr(aSerialnumber)+' of Product ' +Quotedstr(aProctree.Proctreepart.Productname)+
                                                  ' is not Assigned to the Order # ' + inttostr(Salesorder.ID)+' Yet.' +NL+NL+
                                                  'Do You Want to Assign it? ', '', mtConfirmation, [mbYes, mbNo], 0) = 100 then begin
            aProctree.Proctreepart.PQA.PQASN.New;
            aProctree.Proctreepart.PQA.PQASN.Serialnumber := aSerialnumber;
            aProctree.Proctreepart.PQA.PQASN.uomqty := 1;
            aProctree.Proctreepart.PQA.PQASN.PostDb;
            SNProctree := aProctree;
            Result := True;
            Exit;
          end else begin
            abort:= True;
          end;
      end else begin
        MessageDlgLargefont('Raw Materials are Completely Allocated. This Serial Number is not found in the BOM', '', mtWarning, [mbok], 0);
        abort:= True;
      end;
    end;
  end;

end;
  function SearchSerialnumber(Proctree:TProctree; aSerialNumber: String): boolean;
  begin
    Result := False;
    if Proctree.Children.count =0 then exit;

    Proctree.Children.First;
    While Proctree.Children.EOF = False do begin
      with Proctree.Children.ProctreePart do begin
        if (Product.Id = fiProductId) and  ISInvProduct(Product.ProductType) then
          if PQA.PQASN.Locate('Value' , aSerialnumber, []) then begin
            Result := True;
            SNProctree := Proctree.Children;
            parentProcTree:= Proctree;
            Exit;
          end else if IsSubNodeParent and SubNodeManufcaturePQA.PQASN.Locate('Value' , aSerialnumber, []) then begin
            Result := True;
            SNProctree := Proctree.Children;
            parentProcTree:= Proctree;
            Exit;
          end else begin
            if ManufacturedProgress.count>0 then begin {check all the Progress Build}
              ManufacturedProgress.First;
              While ManufacturedProgress.EOF = False do begin
                if ManufacturedProgress.PQA.PQASN.Locate('Value' , aSerialnumber, []) then begin

                  {Search if already processed}
                  if ManufacturingProgress.count>0 then begin {check all the Progress Build}
                    ManufacturingProgress.First;
                    While ManufacturingProgress.EOF = False do begin
                      if ManufacturingProgress.PQA.PQASN.Locate('Value' , aSerialnumber, []) then begin
                        MessageDlgLargefont('This Serial number ' +quotedstr(aSerialnumber)+' of Product ' +Quotedstr(Proctree.Proctreepart.Productname)+
                                                  ' is Already Done ', '', mtInformation, [mbok], 0);
                        abort := True; // just to exit the searh with no futher msg
                        Exit;
                      end;
                     ManufacturingProgress.Next;
                    end;
                  end;
                  Result := True;
                  SNProctree := Proctree.Children;
                  parentProcTree:= Proctree;
                  Exit;
                end;
                ManufacturedProgress.Next;
              end;
            end;

          end;
      end;
      Proctree.Children.next;
    end;

    Proctree.Children.First;
    While Proctree.Children.EOF = False do begin
      if  SearchSerialnumber(Proctree.Children , aSerialnumber) then begin
        REsult := True;
        exit;
      end;
      Proctree.Children.next;
    end;
  end;
begin
  if IsanySNStarted(True ,NL+'Please Finalise this Serial Number So You Can Start Another Process') then begin
    Exit;
  end;
  if stBarCode.Count <3 then begin
    WarnMsg( 'Invalid Batch Format');
    exit;
  end;

  if (saleId =0) or (SalelineID =0) or (ProcTreeId =0) then begin
    WarnMsg( 'Please Choose the JOB');
    exit;
  end;

  fiProductId:=0;
  if stBarCode.count >= 2 then fiProductId :=  strtoint(stBarCode[1]);

  if getProduct(fiProductId ) = '' then begin
      WarnMsg( 'Invalid Product-Serial Number Selection');
      exit;
  end;

  aSerialNumber :=  '';
  if stBarCode.count >= 3 then
    for ctr:= 2 to stBarCode.count-1 do begin
      if aSerialNumber <> '' then aSerialNumber :=  aSerialNumber +'-';
      aSerialNumber :=  aSerialNumber +stBarCode[ctr];
    end;
  if aSerialNumber ='' then exit;
    abort := False;
    if SearchSerialnumber(SalesOrder.Lines.Rootproctree , aSerialnumber) or
      (SerialNumberinstock(fiProductId  , aSerialNumber) and AddSerialNumbertoOrder(SalesOrder.Lines.Rootproctree, fiProductId  , aSerialNumber, abort)) then begin
      if not LockSale then exit;
      try
         try
          ClearLogList(Self);
          try
              buildAQty(parentProcTree , SNProctree.ID ,aSerialnumber , dqtBuilding, fdBuiltcost);
          finally
            ClearLogList(Self);
          end;
         Except
          on E:Exception do begin
              Salesorder.Connection.RollbackTransaction;
          end;
         end;
      finally
        UnlockSale;
      end;
      RefreshProcProgressReport;
      Exit;
    end else if not(abort) then begin
      MessageDlgLargefont('Serial Number ' + quotedstr(aSerialnumber)+' not Found in this BOM Or Already Used.', '', mtWarning, [mbOK], 0);
    end;
end;
Procedure TfmProcProgress.OnBarcodeProcess(BarcodeProcessStatus : TBarcodeProcessStatus);
begin
  btnGreen.Visible                :=  BarcodeProcessStatus =  bpsDone;
  btnRed.Visible                  :=  BarcodeProcessStatus =  bpsFailed;
end;
procedure TfmProcProgress.RefreshProcProgressReport;
var
  fsSizeMode :String;
begin
  fsSizeMode:= SizeMode;
  try
    if salelineid =0 then exit;
    if not CanShowProgressBuildReport then exit;
    if Showreport then
    try
      try
        SetcontrolFocus(TProcProgressReportGUI(FindComponent('ProcProgressReportGUI')).edtSearch);
        SendKeys('{F5}',true);
      except
        on E:Exception do begin
        end;
      end;
    finally
        SetcontrolFocus(edtBarcode);
    end;
  finally
    SizeMode := fsSizeMode;
  end;
end;
procedure TfmProcProgress.OnProcProgressReport(Sender: TObject);
begin
  if not(sender is TProcProgressReportGUI) then exit;
  TProcProgressReportGUI(Sender).Left := 10;
  TProcProgressReportGUI(Sender).Top := 2;
  TProcProgressReportGUI(Sender).height := mainform.clientHeight-90;
  try
    Self.left :=mainform.width - self.width - 30 ;
  except
  end;
  Self.BringToFront;
end;

procedure TfmProcProgress.QryBatchQtyCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryBatchQtytotUOMQty.asFloat := QryBatchQtyallocateduomQty.asFloat +QryBatchQtyuomQty.asFloat;
end;

procedure TfmProcProgress.qrysaleslinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatfield(qrySalesLines.fieldbyname('UnitofMeasureShipped')).Alignment := taLeftJustify;
end;

procedure TfmProcProgress.QrySOAfterOpen(DataSet: TDataSet);
begin
  inherited;
//
end;
procedure TfmProcProgress.OncloseProcProgressReport(Sender: TObject);
begin
  if not(sender is TProcProgressReportGUI) then exit;
  ProcProgressReportform :=nil;
end;
procedure TfmProcProgress.initProcProgressReport(Sender: TObject);
begin
  if sender is TFmProcProgressBarcodes then begin
    TFmProcProgressBarcodes(Sender).saleLineId := SaleLineID;
    TFmProcProgressBarcodes(Sender).EmployeeId := EmployeeId;
    TFmProcProgressBarcodes(Sender).ProcessEmployeeId := EmployeeId;
    Self.InsertComponent(TFmProcProgressBarcodes(Sender));// change owner to close the report when the form si closed
  end else if sender is TProcProgressReportGUI then begin
    ProcProgressReportform :=TProcProgressReportGUI(Sender);
    TProcProgressReportGUI(Sender).saleLineId := SaleLineID;
    TProcProgressReportGUI(Sender).EmployeeId := EmployeeId;
    Self.InsertComponent(TProcProgressReportGUI(Sender));// change owner to close the report when the form si closed
  end;
end;
procedure TfmProcProgress.LocatebatchofRowMaterialinUse;
var
  Qry:TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQl.text := ' SELECT PQA.productId, PQA.UOM,  PQABatch.Value as Batchno, ' +
                    ' PQABatch.qty as Qty, ' +
                    ' PQABatch.uomqty as UOMQty ' +
                    '  FROM tblproctree PT ' +
                    '  inner join  tblprocTreePart PTP on PT.ProctreeId = PTP.proctreeId  and PT.TotalQty - PT.ManufacturingQty  >0 ' +
                    '  inner join `tblPQA` as PQA on PQA.transLineId = PTP.ProctreePartID ' +
                    '       and PQA.transtype = "TProcTreePart" ' +
                    '      and PQA.alloctype ="OUT" ' +
                    ' inner join tblparts P on P.partsId = PQa.productId and p.batch ="T" ' +
                    ' inner join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch" and PQABatch.Qty>0 ' +
                    ' where Pt.parentId =' + inttostr(ProctreeID) ;
    Opendb(qry);
    if qry.RecordCount =0 then begin
      closedb(qry);
      qry.SQl.text := ' SELECT PQA.productId, PQA.UOM,  PQABatch.Value as Batchno, ' +
                      ' PQABatch.qty as Qty, ' +
                      ' PQABatch.uomqty as UOMQty ' +
                      '  FROM tblproctree PT ' +
                      '  inner join  tblprocTreePart PTP on PT.ProctreeId = PTP.proctreeId  and PT.TotalQty - PT.ManufacturingQty  >0 ' +
                      '  inner join `tblPQA` as PQA on PQA.transLineId = PTP.ProctreePartID ' +
                      '       and PQA.transtype = "TProcTreePart" ' +
                      '      and PQA.alloctype ="OUT" ' +
                      ' inner join tblparts P on P.partsId = PQa.productId and p.batch ="T" ' +
                      ' Left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch" ' +
                      ' where Pt.parentId =' + inttostr(ProctreeID) +' order by Batchno limit 1';
      Opendb(qry);
    end;
    if (qry.RecordCount >0) then
      if (Qry.FieldByName('Batchno').AsString <> '') then begin
        SalesOrder.lines.Rootproctree.Children.Locate('PartsID' ,Qry.FieldByName('ProductID').asInteger , []);
        Batchno :=Qry.FieldByName('Batchno').AsString;
      end else begin
        closedb(QryBatchQty);
        QryBatchQty.SQl.text :=     ' SELECT 2  as seqno , ' +
                                    inttostr(Qry.fieldbyname('productId').asInteger)+' as PartsID , ' +
                                    Quotedstr(Qry.fieldbyname('UOM').asString)+' as UOM,'+
                                    ' ' +quotedstr(batchno) +' as Batchno, '+
                                    '0.0 as Qty, 0.0 as  Allocatedqty , '+
                                    '0.0 as UOMQty , 0.0 as AllocateduomQty' ;
        Opendb(QryBatchQty);
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;


Procedure TfmProcProgress.MakeButtons;
var
  btnSize :Integer;
  Procedure MakeButton(Button  : TERPMainSwitchButton; btnname :String; aAction :TDnmAction; aParentPanel :TDnmPanel; aAlign :  TAlign = alright);
  begin
    With Button do begin
      Name      := MakeName(Self,btnname);
      Parent    := aParentPanel;
      DnmAction := aACtion;
      align     := aAlign;
      width     := btnSize;
      height    := btnSize;
      AlignwithMargins:= True;
      Margins.Left    := 3;
      Margins.right   := 3;
      Margins.top     := 3;
      Margins.bottom  := 3;
      Parentfont      := True;
      Wordwrap        := True;
    end;
  end;
begin
  btnSize := trunc(pnlFooter.Width/iif(devmode , 6, 4))-6;
  btn_close	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_close   ,'btn_close'   , actclose      , pnlFooter);
  btn_Finalize  := TERPMainSwitchButton.create(Self);  MakeButton(btn_Finalize,'btn_Finalize', actFinalise   , pnlFooter);
  btn_RePrint   := TERPMainSwitchButton.create(Self);  MakeButton(btn_RePrint ,'btn_RePrint' , actRePrint    , pnlFooter);
  btn_openSO    := TERPMainSwitchButton.create(Self);  MakeButton(btn_openSO  ,'btn_openSO'  , actOpenSO     , pnlFooter);
  btn_AllocSN   := TERPMainSwitchButton.create(Self);  MakeButton(btn_AllocSN ,'btn_AllocSN' , actAllocation , pnlFooter);
  btn_Print	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_Print   ,'btn_Print'   , actPrint      , pnlFooter);
  btn_Wastage	  := TERPMainSwitchButton.create(Self);  MakeButton(btn_Wastage ,'btn_Wastage' , actWaste      , pnlFooter);
  btn_OnHold	  := TERPMainSwitchButton.create(Self);  MakeButton(btn_OnHold  ,'btn_OnHold'  , actHold       , pnlFooter);
  btn_save	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_save    ,'btn_save'    , actSave       , pnlFooter);
  btn_OnHold.align := alclient;
  if not(fbhasacessforAllowFinaliseFromProgressbuild) then AddDisablescontrolforHint(pnlFooter , btn_finalize , 'You Do not have Enough Rights to Finalise the Build');//showcontrolhint(btn_Finalize, 'You Do not have Enough Rights to Finalise the Build');
  btn_AllocSN.visible := False;
  btn_openSO.visible  := Devmode;
  btn_AllocSN.visible := Devmode;
  pnlButtons.Width    := btnSize+6;

  btnSize := trunc((self.height- pnltop.height)/iif(devmode , 7, 6))-6;
  btn_PQAList   := TERPMainSwitchButton.create(Self);  MakeButton(btn_PQAList     ,'btn_PQAList'    ,actPQAList   , pnlButtons , albottom);
  btn_OnHoldList:= TERPMainSwitchButton.create(Self);  MakeButton(btn_OnHoldList  ,'btn_OnHoldList' ,actOnHold    , pnlButtons , albottom);
  btn_Report	  := TERPMainSwitchButton.create(Self);  MakeButton(btn_Report      ,'btn_Report'     ,actreport    , pnlButtons , albottom);
  btn_RemBatch	:= TERPMainSwitchButton.create(Self);  MakeButton(btn_RemBatch    ,'btn_RemBatch'   ,actRemBatch  , pnlButtons , albottom);
  btn_Batches	  := TERPMainSwitchButton.create(Self);  MakeButton(btn_Batches     ,'btn_Batches'    ,actBatches   , pnlButtons , albottom);
  btn_Help	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_Help        ,'btn_Help'       ,actHelp      , pnlButtons , albottom);
  btn_sales	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_sales       ,'btn_sales'      ,actSales     , pnlButtons , albottom);
  btn_sales.align := alclient;
  btn_PQAList.visible := Devmode;

  pnlFooter.height := btnSize+40;

end;
Procedure TfmProcProgress.OnDoneAQty(DoneQtytype : tDoneQtytype);
var
  fdBuiltcost :Double;
begin
  if (SaleID=0) or (salelineID =0) or (ProctreeId =0) then begin
    WarnMsg( 'Please Choose the Sale');
    exit;
  end;

  if  FinaliseIfanySNStarted(DoneQtytype) then exit;

  if SalesOrder.Lines.LineCompletelyBuilt  then begin
    WarnMsg( 'This Product is Completely Built');
    exit;
  end;

  if DoneQtytype = dqtWastage then
    if MessageDlgXP_Vista('Do You Wish to Waste 1 of '+ quotedstr(SalesOrder.Lines.RootprocTree.caption), mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;


  if not LockSale then exit;
  try
     try
      ClearLogList(Self);
      try
          buildAQty(SalesOrder.Lines.RootprocTree , 0 , '' , DoneQtytype , fdBuiltcost );
      finally
        ClearLogList(Self);
      end;
      closedb(QryBatchQty);Opendb(QryBatchQty);
     Except
      on E:Exception do begin
          Salesorder.Connection.RollbackTransaction;
      end;
     end;
  finally
     UnlockSale;
     LocatebatchofRowMaterialinUse;
  end;
  RefreshProcProgressReport;
end;

Procedure TfmProcProgress.BuildAQty(ParentProctree:TProctree;  SNProcTreeID:Integer; aSerialnumber :String;DoneQtytype : tDoneQtytype; var fdManufacturcost:Double);
var
    InId:Integer;
    fdBuiltcost:Double;

    function MaterialAvailable  :Boolean;
    begin
      result := True;
      if AppEnv.Companyprefs.EnforceAllocationValidation or AppEnv.Companyprefs.ValidateAllocation then
        if ParentProctree.children.count >0 then begin
          ParentProctree.children.First;
          While ParentProctree.children.EOF = False do begin
            if ParentProctree.children.Quantity >0 then
              if ParentProctree.children.ProctreePart.Product.batch  then
                if ParentProctree.children.ProctreePart.PQA.CheckforAllocation(ParentProctree.children.Quantity ) = False  then begin
                  if ParentProctree.children.ProctreePart.Product.sntracking then begin
                        MessageDlgLargefont('Please Scan the Serial Number to Start the Next Product', '', mtInformation, [mbOK], 0);
                        lblOptions.caption :='Please Scan the Serial Number to Start the Next Product';
                  end else  begin
                        MessageDlgLargefont( ParentProctree.children.ProctreePart.Product.Productname + ' - Not Enough Quantity Allocated to Start the Process.'+NL+'Please Choose Another Batch', '', mtInformation, [mbOK], 0);
                        lblOptions.caption :=ParentProctree.children.ProctreePart.Product.Productname + ' - Not Enough Quantity Allocated to Start the Process.  Please Choose Another Batch';
                  end;
                  lblOptions.REfresh;
                  ParentProctree.children.ProctreePart.Resultstatus.clear;
                  REsult := False;
                  Exit;
                end else begin
                  if ParentProctree.children.ProctreePart.PQA.ResultStatus.HasWarning then
                    MessageDlgLargefont( ParentProctree.children.ProctreePart.PQA.ResultStatus.Messages, '',  mtInformation , [mbok], 0);
                end;
              ParentProctree.children.Next;
          end;
        end;
    end;
begin

  InId:= 0;
      if ParentProctree.IsAnychildrenSNTracking then
        if aSerialnumber = '' then begin
           MessageDlgLargefont('Scan Serial Number to Start the Next Product' , '', mtInformation, [mbOK], 0);
           Exit;
        end;

      if (DoneQtytype in [dqtWastage]) then
        if ( aSerialnumber <>'') and (SNProcTreeID=ParentProctree.children.Id) then
        else if (QryBatchQty.fieldbyname('AllocateduomQty').asfloat > 0) then else begin
           MessageDlgLargefont('Nothing Selected to ' + iif(DoneQtytype =dqtWastage , 'Waste' , 'Build') , '', mtInformation, [mbOK], 0);
          exit;
        end;


            try
              try
                  InId :=0;
                  if ParentProctree.ManufactureQty- ParentProctree.ManufacturedQty + ParentProctree.WastageQty >=1 then begin
                    if aSerialnumber = '' then if not MaterialAvailable then exit;

                        if (DoneQtytype = dqtOk) or (DoneQtytype = dqtHold) or (DoneQtytype = dqtBuilding)  then begin
                          ParentProctree.ManufacturedUOMQty := ParentProctree.ManufacturedUOMQty +1;
                          ParentProctree.PostDB;
                        end;

                        ParentProctree.ProcTreePart.ManufacturedUOMQty :=ParentProctree.ManufacturedUOMQty ; ParentProctree.ProcTreePart.PostDB;
                        ParentProctree.ProcTreePart.ManufacturedProgress.New;
                        ParentProctree.ProcTreePart.ManufacturedProgress.EmployeeId := EmployeeId;
                        ParentProctree.ProcTreePart.ManufacturedProgress.Progressdate := Now;
                        ParentProctree.ProcTreePart.ManufacturedProgress.Alloctype := 'IN';
                        if (DoneQtytype = dqtOk) or (DoneQtytype = dqtHold) or (DoneQtytype = dqtBuilding) then begin
                          ParentProctree.ProcTreePart.ManufacturedProgress.UOMQty := 1;
                          ParentProctree.ProcTreePart.ManufacturedProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);
                        end else begin
                          ParentProctree.ProcTreePart.ManufacturedProgress.UOMQty := 1;
                          ParentProctree.ProcTreePart.ManufacturedProgress.BuildStatus := 'W';
                          if DoneQtytype = dqtWastage then ParentProctree.ProcTreePart.ManufacturedProgress.ReasonID := TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_BOM_WastageReason, true, true);
                        end;
                        ParentProctree.ProcTreePart.ManufacturedProgress.PostDB;
                        ParentProctree.ProcTreePart.ManufacturedProgress.Save;
                        InId:= ParentProctree.ProcTreePart.ManufacturedProgress.ID;

                      if (DoneQtytype = dqtOk) or (DoneQtytype = dqtHold)  or (DoneQtytype = dqtBuilding)  then

                        if ISInvProduct(ParentProctree.Product.ProductType)  and ParentProctree.ProcTreePart.Product.snTracking then begin {TO DO - as finishing stuff for steel main, assuming that the product is only serialised, not bin / batch}
                            ParentProctree.ProcTreePart.ManufacturedProgress.PQA.PQASN.New;
                            if (SNProcTreeID<>0) and ( aSerialnumber <>'') then begin
                              ParentProctree.ProcTreePart.ManufacturedProgress.PQA.PQASN.Serialnumber :=aSerialnumber;
                            end else begin
                              ParentProctree.ProcTreePart.ManufacturedProgress.PQA.PQASN.Serialnumber := ParentProctree.ProcTreePart.ManufacturedProgress.PQA.MakeNextSearialnumberWithTransId;
                            end;
                            ParentProctree.ProcTreePart.ManufacturedProgress.PQA.PQASN.Postdb;

                            if (Appenv.Companyprefs.ResetSaleDateWhenBuilt) and (SalesOrder.Lines.PQA.Transdate > ParentProctree.ProcTreePart.ManufacturedProgress.PQA.Transdate) then begin
                            WarnMsg( 'According to the Preference (Manufacture->General->Reset Sales Order Date When Built),'+NL+
                                    'Future Dated Sales Orders'' Date will be Changed to Match the Build Date.  '+NL+
                                    'This Sales Order #'+inttostr(fiSaleId)+' is Dated '+ FormatDateTime(FormatSettings.shortDateformat +' HH:NN:SS Am/PM' , SalesOrder.saledatetime)+'.'+
                                    ' - Changing it to be Prior to the Build Date '+ FormatDateTime(FormatSettings.shortDateformat +' HH:NN:SS Am/PM' , incSecond(ParentProctree.ProcTreePart.ManufacturedProgress.PQA.Transdate , -1))+'.', edtsaledatetime, 30);
                              SalesOrder.saledatetime := incSecond(ParentProctree.ProcTreePart.ManufacturedProgress.PQA.Transdate , -1);
                              SalesOrder.PostDB;
                            end;

                            if ParentProctree = SalesOrder.Lines.RootprocTree then begin
                              SalesOrder.Lines.PQA.PQASN.new;
                              SalesOrder.Lines.PQA.PQASN.Serialnumber := ParentProctree.ProcTreePart.ManufacturedProgress.PQA.PQASN.Serialnumber;
                              SalesOrder.Lines.PQA.PQASN.PostDB;
                            end else begin
                              if ParentProctree.ProcTreePart.IsSubNodeParent then begin // ParentProctree has to be a subnode parent when this is not root
                                with ParentProctree.ProcTreePart.SubNodeManufcaturePQA do begin
                                  PQASN.new;
                                  if aSerialnumber <> '' then PQASN.Serialnumber := aSerialnumber else PQASN.Serialnumber := ParentProctree.ProcTreePart.ManufacturedProgress.PQA.MakeNextSearialnumberWithTransId;
                                  PQASN.PostDB;
                                end;
                              end else begin // this should never ever be not a parent
                                with ParentProctree.ProcTreePart.PQA do begin
                                  PQASN.new;
                                  if aSerialnumber <> '' then PQASN.Serialnumber := aSerialnumber else PQASN.Serialnumber := ParentProctree.ProcTreePart.ManufacturedProgress.PQA.MakeNextSearialnumberWithTransId;
                                  PQASN.PostDB;
                                end;

                              end;
                            end;
                        end;
                    fdManufacturcost:=0;
                    if ParentProctree.children.count >0 then begin                                                                                                                            PPGLog('1->'+ inttostr(ParentProctree.ID) +',' + ParentProctree.caption +':' +inttostr(ParentProctree.children.count));
                      fdManufacturcost :=0;
                      ParentProctree.children.First;                                                                                                                                          PPGLog('2->'+ inttostr(ParentProctree.children.ID) +',' + ParentProctree.children.caption );
                      While ParentProctree.children.EOF = FAlse do begin                                                                                                                      PPGLog('3->'+ inttostr(ParentProctree.children.ID) +',' + ParentProctree.children.caption );
                          {Binny : All children except the Serialised product should allocate all its sub objects.
                          The serialised product is already built and assigned into stock - this is the requirement for steelmain}
                          fdBuiltcost := 0;
                          if ParentProctree.children.Children.count >0 then begin                                                                                                             PPGLog('5->'+ inttostr(ParentProctree.children.ID) +',' + ParentProctree.children.caption +':' +inttostr(ParentProctree.children.Children.count));
                            if ( aSerialnumber <>'') then begin
                              if ParentProctree.children.ProcTreePart.IsSerialNumberAllocated(aSerialnumber) then else begin
                                BuildaQty(ParentProctree.children  , 0, '', DoneQtytype , fdBuiltcost); // serial number not applicable for the next level
                                if ParentProctree.children.ProcTreePart.Product.sntracking then
                                    DoPPGErrorEmail('Error :1 ' , ParentProctree.children.ProcTreePart.Product.Productname, aSerialnumber);
                              end;
                            end else begin
                              DoPPGErrorEmail('Error :2 ' , ParentProctree.children.ProcTreePart.Product.Productname, aSerialnumber);
                            end;
                          end;

                          if ParentProctree.children.Quantity >0 then   begin
                            if (DoneQtytype = dqtOk)   or (DoneQtytype = dqtHold ) or (DoneQtytype = dqtBuilding) then begin                                                                  PPGLog('7->'+ inttostr(ParentProctree.children.ID) +',' + ParentProctree.children.caption +',' +floattostr(ParentProctree.children.ManufacturingQty )+'+'+Floattostr(ParentProctree.children.Quantity));
                              ParentProctree.children.ManufacturingQty := ParentProctree.children.ManufacturingQty +ParentProctree.children.Quantity;
                              ParentProctree.children.PostDB;                                                                                                                                 PPGLog('8->'+ inttostr(ParentProctree.children.ID) +',' + ParentProctree.children.caption +',' +floattostr(ParentProctree.children.ManufacturingQty )+'+'+Floattostr(ParentProctree.children.Quantity));
                            end;
                                if (DoneQtytype = dqtOk)  or (DoneQtytype = dqtHold) or (DoneQtytype = dqtBuilding)  then begin                                                               PPGLog('9->'+ inttostr(ParentProctree.children.ProcTreePart.ID) +',' + floattostr(ParentProctree.children.ProcTreePart.ManufacturingQty ));
                                  ParentProctree.children.ProcTreePart.ManufacturingQty := ParentProctree.children.ManufacturingQty;
                                  ParentProctree.children.ProcTreePart.PostDB;                                                                                                                PPGLog('10->'+ inttostr(ParentProctree.children.ProcTreePart.ID) +',' + floattostr(ParentProctree.children.ProcTreePart.ManufacturingQty ));
                                end;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.New;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.EmployeeId := EmployeeId;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.InProcProgressId := ParentProctree.ProcTreePart.ManufacturedProgress.ID;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.Progressdate := Now;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.Alloctype := 'OUT';
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.Qty := ParentProctree.children.Quantity;
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);
                                  ParentProctree.children.ProcTreePart.ManufacturingProgress.PostDB;                                                                                          PPGLog('11->'+ inttostr(ParentProctree.children.ProcTreePart.ManufacturingProgress.ID) +',Created');
                                  if ISInvProduct(ParentProctree.children.Product.ProductType)   then begin
                                      if ( aSerialnumber <>'') and (SNProcTreeID=ParentProctree.children.Id) then begin
                                              if ParentProctree.children.ProcTreePart.PQA.PQASN.Locate('Value' , aSerialnumber , []) then begin                                                   PPGLog('13->'+ inttostr(ParentProctree.children.ProcTreePart.PQA.PQASN.ID) +',' + quotedstr(aSerialnumber) +',Delete Serial Number');
                                                    ParentProctree.children.ProcTreePart.PQA.PQASN.Delete;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.New;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.serialnumber :=aSerialnumber;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.PostDB;                                                                  PPGLog('14->'+ inttostr(ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.ID)  +',' + quotedstr(aSerialnumber) +',' +'create');
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PostDB;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.Save;
                                              end else if (ParentProctree.children.ProcTreePart.IsSubNodeParent) and (ParentProctree.children.ProcTreePart.SubNodeManufcaturePQA.PQASN.Locate('Value' , aSerialnumber , [])) then begin
                                                    ParentProctree.children.ProcTreePart.SubNodeManufcaturePQA.PQASN.Delete; {delete serial number from TProctreePartIN - IN}
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.InProcProgressId := inID;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.Progressdate := Now;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PostDB;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.Save;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.New; {Add serial number TProcProgressOUT - IN}
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.serialnumber :=aSerialnumber;
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.PostDB;                                                                  PPGLog('15->'+ inttostr(ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.ID)  +',' + quotedstr(aSerialnumber) +',' +'create');
                                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);
                                              end else begin
                                                if ParentProctree.children.Proctreepart.ManufacturedProgress.count >0 then begin
                                                  ParentProctree.children.Proctreepart.ManufacturedProgress.First;                                                                                PPGLog('16-> loop for ' + inttostr(ParentProctree.children.Proctreepart.ManufacturedProgress.count) +' MandProgresses of ProctreePart -'+ inttostr(ParentProctree.children.Proctreepart.ID) );
                                                  While ParentProctree.children.Proctreepart.ManufacturedProgress.Eof = False do begin
                                                    if (ParentProctree.children.Proctreepart.ManufacturedProgress.PQA.PQASN.Locate('Value' , aSerialnumber , [])) then begin
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.InProcProgressId := inID;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.Progressdate := Now;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.PostDB;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.Save;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.New; {Add serial number TProcProgressOUT - IN}
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.serialnumber :=aSerialnumber;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.PostDB;
                                                          ParentProctree.children.ProcTreePart.ManufacturingProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);                                PPGLog('17-> ' + inttostr(ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA.PQASN.ID) +',' + quotedstr(aSerialnumber) );
                                                          break;
                                                    end;
                                                    ParentProctree.children.Proctreepart.ManufacturedProgress.Next;
                                                  end;
                                                end;
                                              end;
                                      end else begin
                                        if (DoneQtytype in [dqtWastage]) and (ParentProctree.children.PartsId = QryBatchQty.fieldbyname('PartsId').asInteger) and (QryBatchQty.fieldbyname('AllocateduomQty').asfloat > ParentProctree.children.Quantity) then begin
                                          if MessageDlgLargefont('Do You wish to Waste the Correct Selection of ' +   FloattostrF(ParentProctree.children.Quantity  , ffGeneral , 15, 2)+ ' ' +QryBatchQtyUOM.asString +
                                                                   ' from ' + Quotedstr(QryBatchQty.fieldbyname('Batchno').asString) + NL +
                                                                        'Or All of the Batch '+ Quotedstr(QryBatchQty.fieldbyname('Batchno').asString)+'?' ,'' , mtConfirmation , [] ,0, 'All,Current') = 100 then begin
                                            try

                                              ParentProctree.children.ProcTreePart.PQA.PQABatch.filter := ' Value =' + Quotedstr(BatchNo);
                                              ParentProctree.children.ProcTreePart.PQA.PQABatch.filtered := true;

                                              if ParentProctree.children.ProcTreePart.PQA.PQABatch.count >0 then begin
                                                ParentProctree.children.ProcTreePart.ManufacturingProgress.Qty := ParentProctree.children.ProcTreePart.PQA.PQABatch.Qty;
                                                ParentProctree.children.ProcTreePart.ManufacturingProgress.PostDB;
                                                ParentProctree.children.ProcTreePart.ManufacturingProgress.Save;
                                                ParentProctree.children.ProcTreePart.MoveAllocation(ParentProctree.children.ProcTreePart.PQA.PQABatch.TotalAllocated  , ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA);
                                              end;
                                            finally
                                              ParentProctree.children.ProcTreePart.PQA.PQABatch.closedb;
                                              ParentProctree.children.ProcTreePart.PQA.PQABatch.filtered := False;
                                              ParentProctree.children.ProcTreePart.PQA.PQABatch.filter := ' ';
                                            end;
                                          end else begin
                                            ParentProctree.children.ProcTreePart.MoveAllocation(ParentProctree.children.Quantity  , ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA);
                                          end;
                                        end else begin
                                          ParentProctree.children.ProcTreePart.MoveAllocation(ParentProctree.children.Quantity  , ParentProctree.children.ProcTreePart.ManufacturingProgress.PQA);
                                        end;
                                      end;
                                  end else begin

                                    if fdBuiltcost <> 0 then
                                         ParentProctree.children.ProcTreePart.ManufacturingProgress.ProductUnitcost :=fdBuiltcost
                                    else ParentProctree.children.ProcTreePart.ManufacturingProgress.ProductUnitCost := ParentProctree.children.Productunitcost;

                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.Postdb;
                                    ParentProctree.children.ProcTreePart.ManufacturingProgress.Save;
                                  end;
                          end;

                          fdManufacturcost := fdManufacturcost + ParentProctree.children.ProcTreePart.ManufacturingProgress.ProductUnitCost *
                                                                ParentProctree.children.ProcTreePart.ManufacturingProgress.Qty;



                        ParentProctree.children.Next;
                      end;
                      if ProcPrefs.UseCurrentCostforProgressBuild then begin
                        ParentProctree.ProcTreePart.ManufacturedProgress.ProductUnitCost :=fdManufacturcost;
                        ParentProctree.ProcTreePart.ManufacturedProgress.PostDB;
                        ParentProctree.ProcTreePart.ManufacturedProgress.Save; // binny:  this save is to force the avg cost calculation with the correct Build cost.
                      end;
                  end;

                  end;
              finally
                if (inId<> 0) then
                  PrintBuildReport(InId , DoneQtytype );
              end;
            Except
              on E:Exception do begin
                MessageDlgLargefont(e.message, '', mtWarning, [mbOK], 0);
                DoPPGErrorEmail('Error :3 '+ E.message , ParentProctree.children.ProcTreePart.Product.Productname, aSerialnumber);
              end;
            end;
end;

function TfmProcProgress.ChooseBatchestoRemove(PQABatch: TPQABatch; var BatchIds: TIntegerList):Boolean ;
begin
  BatchIds.Clear;
  InitMsgParams;
  PopupMsgParams.Msgcaption   := 'Confirmation';
  PopupMsgParams.Msgds        := PQABatch.Dataset;
  PopupMsgParams.fieldnames   := 'Value,UOMQty';
  PopupMsgParams.displayLabels:= '"Batch Number","Quantity"';
  PopupMsgParams.Displaywidths:= '50, 15';
  PopupMsgParams.Custombuttons:= 'Remove,Cancel';
  PopupMsgParams.Msg1         := 'Confirmation';
  PopupMsgParams.Msg2         := NL+'Choose Batch(es) to Remove';
  PopupMsgParams.MsgColor     := Self.Color;
  PopupMsgParams.Largefont    := true;
  PopupMsgParams.Idfieldname  := 'PQADetailID';
  result := (TfmMessageWithGrid.MsgDlg(BatchIds) = 100) and (BatchIds.count>0);
end;
Procedure TfmProcProgress.OnSaveSelect;
begin
  CommitTransaction;
  Self.Close;
end;
procedure TfmProcProgress.ChooseBatch;
begin
    if SalesOrder.Lines.RootprocTree.Children.count =0 then exit;
    if not SalesOrder.Lines.RootprocTree.Children.product.batch  then begin
        SalesOrder.Lines.RootprocTree.Children.first;
        while SalesOrder.Lines.RootprocTree.Children.Eof = False do
          if SalesOrder.Lines.RootprocTree.Children.product.batch then begin
            break;
          end else SalesOrder.Lines.RootprocTree.Children.Next;
    end;
    if SalesOrder.Lines.RootprocTree.Children.product.Batch  then  begin
      OpenERPListFormSingleselect('TProductBatchesGUI' , OnbatchSelect , initBatches, Batchesafteshow);
    end;
end;

procedure TfmProcProgress.PPGLog(const Value: String);
begin
  StepProgressbar(Value);
  exit; // turn it on o debug
  Logtext(Value);
end;

Procedure TfmProcProgress.PPG_SN_forBuildStatus(var Qry:TERPQuery;const abuildstatus :String; SNProductOnly :Boolean = True);
begin
  closedb(qry);
  qry.SQL.clear;
  qry.SQL.add('Select PTP.ProcTreePArtId ,  ' +
                    ' PTP.Productname, ' +
                    ' PPG.ProcProgressID , '+
                    ' PPG.Progressdate as  Progressdate , ' +
                    ' pqasn.Value as Serialnumber , ' +
                    ' E.EmployeeName as EmployeeName , pqa.alloctype  ' );
  qry.SQL.add('from tblsales S ' );
  qry.SQL.add('inner join tblsaleslines SL on S.saleId =SL.saleId ' );
  qry.SQL.add('inner join tblprocTree PT on PT.MasterId = SL.saleLineID and PT.masterType <> "mtProduct" ' );
  qry.SQL.add('inner join  tblProctreePart PTP on PT.proctreeId = PTP.proctreeId ' );
  qry.SQL.add('inner join tblprocprogress PPG on PTP.ProcTreePartId = PPG.ProcTreePartID and PPG.BuildStatus= ' +Quotedstr(abuildstatus) +' and PPG.EmployeeId =' + inttostr(EmployeeID) );
  qry.SQL.add(iif(SNProductOnly , ' inner ' , ' Left ' ) +' join tblpqa pqa on PPG.ProcProgressID = pqa.TransLineID and Pqa.transtype in ("TProcProgressIn" , "TProcProgressOUT") ' );
  qry.SQL.add(iif(SNProductOnly , ' inner ' , ' Left ' ) +' join tblpqadetails pqasn on pqa.pqaid = pqasn.PQAID and pqasn.PQAType ="SN" ' );
  qry.SQL.add('inner join tblemployees E on E.EmployeeID = PPG.EmployeeId ' );
  qry.SQL.add('Where s.converted ="F"  and SL.saleLineId = ' + inttostr(SaleLineID));
  qry.SQL.add('  Order  by PT.sequencedown');
  Opendb(qry);
end;

procedure TfmProcProgress.ChoosenFinaliseOnHold;
var
  Qry:TERPQuery;
begin
  if SaleLineID = 0 then begin
    MessageDlgLargefont('Pleas Choose a Job', '', mtWarning, [mbOK], 0);
    Exit;
  end;
    PPG_SN_forBuildStatus(qryPPG_SN_forBuildStatus , 'H');
    if qryPPG_SN_forBuildStatus.RecordCount =0 then begin
      MessageDlgLargefont('There is Nothing On Hold from this Build', '', mtWarning, [mbOK], 0);
    end else begin
      qryPPG_SN_forBuildStatus.Filter := 'Alloctype = ' +quotedstr('IN');
      qryPPG_SN_forBuildStatus.Filtered:= True;
      InitMsgParams;
            PopupMsgParams.Msgcaption   := 'Confirmation';
            PopupMsgParams.Msgds        := qryPPG_SN_forBuildStatus;
            PopupMsgParams.fieldnames   := 'employeename,Progressdate,Serialnumber';
            PopupMsgParams.displayLabels:= 'Employee,On Hold Since,Serial Number';
            PopupMsgParams.Displaywidths:= '100,150,150';
            PopupMsgParams.Custombuttons:= 'Finalise,Cancel';
            PopupMsgParams.Msg1         := 'Confirmation';
            PopupMsgParams.Msg2         := NL+'Choose Serial Number On Hold to Finalise ';
            PopupMsgParams.MsgColor     := Self.Color;
            PopupMsgParams.Largefont    := true;
            if TfmMessageWithList.MsgDlg = 100 then begin
            if not Locksale then Exit;
            try
              Salesorder.Connection.beginTransaction;
              try
                FinaliseOnHold(qryPPG_SN_forBuildStatus.fieldbyname('ProcTreePArtId').asInteger ,  qryPPG_SN_forBuildStatus.fieldbyname('ProcProgressID').asInteger,  qryPPG_SN_forBuildStatus.fieldbyname('alloctype').asString, dqtOk);
                qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
                try
                  qry.SQL.text :='Select * from tblprocprogress where InProcProgressId = ' + inttostr(qryPPG_SN_forBuildStatus.fieldbyname('ProcProgressID').asInteger);
                  qry.open;
                  if qry.recordcount >0 then begin
                    qry.First;
                    While qry.Eof = False do begin
                      FinaliseOnHold(qryPPG_SN_forBuildStatus.fieldbyname('ProcTreePArtId').asInteger ,  qry.fieldbyname('ProcProgressID').asInteger,  qry.fieldbyname('alloctype').asString, dqtOk);
                      qry.Next;
                    end;
                  end;

                finally
                   DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
                end;
                Salesorder.Connection.CommitTransaction;
                RefreshProcProgressReport;
             Except
              on E:Exception do begin
                  Salesorder.Connection.RollbackTransaction;
              end;
             end;
          finally
            UnlockSale;
          end;
            end;
    end;
end;

procedure TfmProcProgress.OnbatchSelect(Sender: TwwDbGrid);
begin
  if Assigned(Sender.Datasource) then
    if Assigned(Sender.Datasource.Dataset) then
      if (Sender.Datasource.Dataset.Findfield('Batchno')<> nil) and (Sender.Datasource.Dataset.Findfield('PartsID')<> nil)  then
          BarCode := Barcode_Prefix_PQABATCH+'-'+trim(inttostr(Sender.Datasource.Dataset.Findfield('PartsID').asInteger))+'-'+trim(Sender.Datasource.Dataset.Findfield('Batchno').asString);
end;
procedure TfmProcProgress.initBatches(Sender:TObject);
begin
  if not(Sender is TProductBatchesGUI) then exit;
  TProductBatchesGUI(Sender).HaveDateRangeSelection := False;
  TProductBatchesGUI(Sender).productId := SalesOrder.Lines.RootprocTree.Children.product.ID;
  TProductBatchesGUI(Sender).ClasSId :=   Salesorder.Saleclassid;
(*  TProductBatchesGUI(Sender).HighlightBatcheswithQty := True;*)
end;
procedure TfmProcProgress.Batchesafteshow(Sender:TObject);
begin
  if not(Sender is TProductBatchesGUI) then exit;
(*  TProductBatchesGUI(Sender).grpOptions.itemindex := 0;*)
  TProductBatchesGUI(Sender).grpOptions.itemindex := 0;
end;
procedure TfmProcProgress.actsalesExecute  (Sender: TObject);begin  ChooseSale           ;end;
procedure TfmProcProgress.AfterFormShow;
begin
  inherited;
  reSetbuttons;
end;

procedure TfmProcProgress.actAllocationExecute(Sender: TObject);
begin
  inherited;
    if (SaleId =0) or ( SaleLineId =0) then exit;
    UnlockSaleProgress(saleID);
    try
      TfmBOMAllocation.DoAllocation(SaleId, SaleLineId, nil);
    finally
       isOkToSelectSale(saleID);
    end;
end;

procedure TfmProcProgress.actBatchesExecute(Sender: TObject);begin  chooseBatch          ;end;
procedure TfmProcProgress.actHelpExecute(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Pipe Creation');
end;

procedure TfmProcProgress.actOnHoldExecute (Sender: TObject);begin  ChoosenFinaliseOnHold;end;
procedure TfmProcProgress.actOpenSOExecute(Sender: TObject);
begin
  inherited;
  if SaleId =0 then exit;
  OpenERPForm('TSalesOrderGUI' ,SaleId , LocateLine);
  Self.close;
end;
procedure TfmProcProgress.LocateLine(Sender: TObject);
begin
  if not(Sender is TSalesOrderGUI) then exit;
  TSalesOrderGUI(Sender).SalesOrder.Lines.Locate('salelineId' , salelineId , []);
end;
procedure TfmProcProgress.actRemBatchExecute(Sender: TObject);
var
  iBAtchIds :TIntegerList;
  ctr:Integer;
begin
  inherited;
  if SalesOrder.lines.Rootproctree.Children.count =0 then exit;

  While SalesOrder.lines.Rootproctree.Children.EOF = False do begin
    if SalesOrder.lines.Rootproctree.Children.ProcTreEPart.Product.batch  then begin
      if (SalesOrder.lines.Rootproctree.Children.ProcTreEPart.PQA.PQABatch.Count>0) then begin
        iBAtchIds := TIntegerList.Create;
        try
          ChooseBatchestoRemove(SalesOrder.lines.Rootproctree.Children.ProcTreEPart.PQA.PQABatch , iBAtchIds);
            if iBAtchIds.count >0 then begin
              for ctr:= 0 to iBAtchIds.count-1 do begin
                if SalesOrder.lines.Rootproctree.Children.ProcTreEPart.PQA.PQABatch.Locate(SalesOrder.lines.Rootproctree.Children.ProcTreEPart.PQA.PQABatch.IDFieldName  , iBAtchIds[ctr] , []) then begin
                  SalesOrder.lines.Rootproctree.Children.ProcTreEPart.PQA.PQABatch.Delete;
                end;
              end;
              RefreshProcProgressReport;
            end;
          finally
            Freeandnil(iBAtchIds);
          end;
      end else begin
        MessageDlgLargefont('No Batch Allocated for ' + quotedstr(SalesOrder.lines.Rootproctree.Children.ProcTreEPart.Productname) +'.' ,''  ,  mtWarning, [mbOK], 0);
      end;
        Exit;
    end;
    SalesOrder.lines.Rootproctree.Children.Next;
  end;

end;

procedure TfmProcProgress.actReportExecute (Sender: TObject);
begin
  inherited;
  if CanShowProgressBuildReport then begin
      try
        if ProcProgressReportform <> nil then begin
          SetcontrolFocus(TProcProgressReportGUI(FindComponent('ProcProgressReportGUI')).edtSearch);
          SendKeys('{F5}',true);
          fbshowreport  := true;
        end;
      except
        on E:Exception do begin
          ProcProgressReportform := nil;
        end;
      end;
      if ProcProgressReportform = nil then begin
          OpenERPListForm('TProcProgressReportGUI' ,initProcProgressReport,OnProcProgressReport , False, OncloseProcProgressReport);
          fbshowreport  := true;
      end;
  end
  else MessageDlgLargefont('You don''t Have Enough Rights to View the Report', '', mtInformation, [mbOK], 0);
end;
function TfmProcProgress.LockSale: Boolean;
begin
      REsult := True;
      Userlock.AllowDuplicateLockFromSameForm := true;
      if not userlock.Lock('tblsales' , SaleID, 'Process BarCode') then begin
        WarnMsg( replacestr(UserLock.LockMessage  , 'Unable to update data.', 'It is not Possible To Update Sales Order #' + inttostr(SaleId)));
        REsult := False;
        Exit;
      end;
      Salesorder.Connection.beginTransaction;
end;

procedure TfmProcProgress.UnlockSale;
begin
  userlock.unLock('tblsales' , SaleID, 'Process BarCode') ;
  Salesorder.Connection.CommitTransaction;
  Userlock.AllowDuplicateLockFromSameForm := False;
end;


Function TfmProcProgress.PrintBuildReport(InId:Integer;DoneQtytype : tDoneQtytype):Boolean ;
begin
  Result := False;
  fsReportSQL:= '~|||~Where PPG.ProcProgressID = ' + inttostr(INId)+' ~|||~Where PPG.InProcProgressId = ' + inttostr(INId);
  try
         if (DoneQtytype = dqtOK) or (DoneQtytype = dqtHold) then Result := TTemplateOptions.DoPrintreports(self, 'Progress Build'      ,'', PrintTemplateOptionsReport)
    else if DoneQtytype = dqtwastage                         then Result := TTemplateOptions.DoPrintreports(self, 'ProcProgressBuildWastae','', PrintTemplateOptionsReport)
    else exit;
  finally
    fsReportSQL:= '';
  end;
end;
procedure TfmProcProgress.initPrintTemplateOptionsReport(Sender: TTemplateOptions;
                                                   var  ssql:String;
                                                   var  MasterDetailLink: TJsonObject;
                                                   var  ShowCancelPreviewBtninReportPreview :Boolean);
begin
  fbReportSQLSupplied := False;
  ssql:=fsReportSQL;
end;
procedure TfmProcProgress.initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions;var  OutGoingFileName:String;var Corres: TCorrespondenceGui);
begin
  inherited;
  OutGoingFileName := getOutGoingFileName('',' ' + inttostr(Sender.typeID) + ' #' + SalesOrder.DocNumber, '.PDF');
                              Corres.CustomerId := SalesOrder.CustomerID;
                              Corres.Subject := 'ProgressBuild';
                              Corres.RecipientList := SalesOrder.Employee.Email;
                              Corres.MessageText := 'Progress Build Attached';
                              Corres.CCList := GetSalesEmails;

end;
function TfmProcProgress.UnlockSaleProgress(const aSaleID: Integer): Boolean;
begin
  Result := true;
  Userlock.AllowDuplicateLockFromSameForm := true;
  try
    Userlock.unLock('tblsales' , aSaleID , '', self.classname) ;
  finally
    Userlock.AllowDuplicateLockFromSameForm := False;
  end;
end;

function TfmProcProgress.isOkToSelectSale(const aSaleID: Integer): Boolean;
begin
  Userlock.AllowDuplicateLockFromSameForm := true;
  try
    Result := Userlock.Lock('tblsales' , aSaleID) ;
    if not result then
      MessageDlgLargefont(replacestr(replacestr(UserLock.LockMessage  , 'Unable to update data.', 'It is not Possible To Choose' + NL+'Sales Order # ' + inttostr(aSaleID)) , 'in use since' , 'in use' + NL+' Since'), '', mtInformation, [mbOK], 0);
  finally
    Userlock.AllowDuplicateLockFromSameForm := False;
  end;
end;
procedure TfmProcProgress.DoReprint;
begin
  OpenERPFormModal('TFmProcProgressBarcodes', 0, initProcProgressReport);
end;
Procedure TfmProcProgress.DoPPGErrorEmail(const ErrorMsg, aProductname, aSerialnumber:String);
begin
  SendEmailtoErp('Progressbuild-SNMissing',
                '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
                '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
                '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) +
                '    Version     :' + TABLE_VERSION + chr(13) +chr(13) +
                '    Product : ' + aProductname+chr(13) +
                '    Serialnumber : ' + aSerialnumber + chr(13) +
               ErrorMsg ,'emaillog', '', ProcPrefs.PPErrorEmailToEmail);
  if ProcPrefs.PPErrorEmailToEmail <> '' then
    SendEmailtoErp('Progressbuild-SNMissing',
                  '    (Error Email Copied to the Employee Chosen :' +Quotedstr(ProcPrefs.PPErrorEmailTo) +')'+chr(13)+chr(13)+
                  '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
                  '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
                  '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) +
                  '    Version     :' + TABLE_VERSION + chr(13) +chr(13) +
                  '    Product : ' + aProductname+chr(13) +
                  '    Serialnumber : ' + aSerialnumber + chr(13) +
                  ErrorMsg ,'emaillog', '', ProcPrefs.PPErrorEmailToEmail);
end;
initialization
  RegisterClassOnce(TfmProcProgress);

end.

