unit frmSalesLineBOMTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, Mask, wwdbedit,
  DNMSpeedButton, DBCtrls, Shader, DNMPanel, ActnList, DNMAction;

type
  TfmSalesLineBOMTree = class(TBaseInputGUI)
    dsMain: TDataSource;
    qryMain: TERPQuery;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DBText1: TDBText;
    chkShowSalesDetails: TCheckBox;
    pnlBottom: TDNMPanel;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btncancel: TDNMSpeedButton;
    pnlSalesDetails: TDNMPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    Label1: TLabel;
    wwDBEdit4: TwwDBEdit;
    DBText2: TDBText;
    qryMainID: TIntegerField;
    qryMainProctreeId: TIntegerField;
    qryMainRowno1: TIntegerField;
    qryMainParentId: TIntegerField;
    qryMainPPID: TIntegerField;
    qryMainPSID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainShipDate: TDateTimeField;
    qryMainKeyStr: TWideStringField;
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainCaptionIntend: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainProcessStepSeq: TIntegerField;
    qryMainBuildingBlockQty: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainQuantity: TFloatField;
    qryMainDuration: TWideStringField;
    qryMainSingleDuration: TWideStringField;
    qryMaintotalDuration: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainSalesCaption: TStringField;
    qryMainIsScheduled: TWideStringField;
    qryMainIsSalesconverted: TWideStringField;
    qryMainIsInternalOrder: TWideStringField;
    qryMainQtyBuilt: TFloatField;
    qryMainCleanQtyBuilt: TFloatField;
    qryMainWastageQty: TFloatField;
    qryMainCleanWastageQty: TFloatField;
    lblMsg: TLabel;
    qryMaincIsScheduled: TWideStringField;
    qryMaincIsSalesconverted: TWideStringField;
    qryMaincIsInternalOrder: TWideStringField;
    DBText3: TDBText;
    DBText4: TDBText;
    Label2: TLabel;
    wwDBEdit5: TwwDBEdit;
    cmdPrint: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    DBText5: TDBText;
    btnAutoSchedule: TDNMSpeedButton;
    ActionList: TActionList;
    actPrintJobDetails: TDNMAction;
    actPrintWorkSheets: TAction;
    actCancel: TAction;
    actSave: TAction;
    actOpenSale: TAction;
    actProductTree: TAction;
    actAutoSchedule: TAction;
    actPrintPickingSlip: TAction;
    actInvoice: TAction;
    actOrderStatus: TDNMAction;
    actStowAway: TDNMAction;
    actPQAllocation: TDNMAction;
    actallocPickingSlip: TDNMAction;
    actPartialInvoice: TDNMAction;
    ActChoosesalesLines: TDNMAction;
    MnuGridPopup: TAdvPopupMenu;
    PrintJobDetails1: TMenuItem;
    ProductionWorkSheets1: TMenuItem;
    mnuGoodOrderStatus: TMenuItem;
    N1: TMenuItem;
    OpenSale1: TMenuItem;
    ProductTree1: TMenuItem;
    BinBatchSerialNoPickingSlip1: TMenuItem;
    N5: TMenuItem;
    PQAAllocation1: TMenuItem;
    StowAways1: TMenuItem;
    N4: TMenuItem;
    CompleteandInvoice1: TMenuItem;
    N6: TMenuItem;
    OrderStatus1: TMenuItem;
    N3: TMenuItem;
    mnuPartialInvoice: TMenuItem;
    mnuPartialShipments: TMenuItem;
    N7: TMenuItem;
    SelectAll1: TMenuItem;
    UnSelectAll1: TMenuItem;
    Image1: TImage;
    procedure chkShowSalesDetailsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ChooseSalesLine(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actPrintJobDetailsExecute(Sender: TObject);
    procedure actPrintWorkSheetsExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actOpenSaleExecute(Sender: TObject);
    procedure actProductTreeExecute(Sender: TObject);
    procedure actAutoScheduleExecute(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actOrderStatusExecute(Sender: TObject);
    procedure actStowAwayExecute(Sender: TObject);
    procedure actPQAllocationExecute(Sender: TObject);
    procedure actallocPickingSlipExecute(Sender: TObject);
    procedure actPartialInvoiceExecute(Sender: TObject);
    procedure actPartialInvoiceUpdate(Sender: TObject);
  private
    fiSaleLineId: Integer;
    tablename :String;
    procedure SetSaleLineId(const Value: Integer);
    procedure OnSelectsalesLine(Sender: TwwDbGrid);

    function SaveChanges: Boolean;
    procedure initProductionOrders(Sender: TObject);
    procedure Initform;
    procedure initSalesorderInvoice(Sender: TObject);
    procedure OnSalesOrderInvoiceCreate(Sender: TObject);
    function SelectedProcessPartIDs :String;
    Function isJobSelected(MsgWhenNoneSelected:String =''):Boolean;
    procedure beforeopenBOMOrderStatus(sender: TObject);
  Protected
  public
    Property SaleLineID:Integer read fiSaleLineId write SetSaleLineId;
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj, tcConst, ImageDLLLib,
  CommonFormLib, ProductionOrders, tcDataUtils, SystemLib, AppEnvironment,
  MySQLConst, LogLib, frmPrintWorkOrders, WorkOrderLib,
  frmBarCodeManufacturingSalesorderInvoice, ProcCapacityPlanningObj,
  ManufactureGuiLib, TempTableUtils, frmProcCapacityPlanningWork , IntegerListObj,
  ProcessDataUtils, BOMOrderStatus, frmStowAway, frmBOMAllocation,
  ManufactureLib, BOMLib;

{$R *.dfm}
{ TfmSalesLineBOMTree }

procedure TfmSalesLineBOMTree.actallocPickingSlipExecute(Sender: TObject);
var
  strSQL:String;
  Tablename :String;
begin
  inherited;
  if not isJobSelected then exit;

  if qryMainIsSalesconverted.AsBoolean then exit;

  if (QrymainSaleId.AsInteger =0) or ( QrymainSaleLineId.AsInteger =0) then exit;
  tablename := GetUserTemporaryTableName('BOMPickingslip');
  MakeBOMPickingTable(inttostr(QrymainSaleLineId.AsInteger), tablename);

  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, '+
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
            ' ~|||~{details}Select * from '+tablename +' order by SeqID ';

  ReportToPrint :=tcdatautils.GetDefaultReport('BOM Picking Slip');
  fbReportSQLSupplied := True;
  fbTemplateUsesNonFormConnection := true;
  try
    PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
  finally
    fbTemplateUsesNonFormConnection := false;
  end;
  //CommonDbLib.DestroyUserTemporaryTable(Tablename);
  TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + Tablename + ';');
end;

procedure TfmSalesLineBOMTree.actAutoScheduleExecute(Sender: TObject);
var
  Msg:String;
  Count:Integer;
begin
  inherited;
  if not(Savechanges) then exit;
  CommitTransaction;
  Try

    if AutoScheduleProduction(msg, count, MyConnection, userlock) then begin
      if count > 0 then begin
        self.CommitTransaction;
        Closedb(qryMain);
        SetSaleLineId(SaleLineID);
        Initform;
      end;
    end else begin
      MessageDlgXP_Vista('Auto Production Scheduling failed with the following message: ' + CRLF + msg,mtWarning,[mbOk],0);
    end;


  Finally
    BeginTransaction;
  End;
end;

procedure TfmSalesLineBOMTree.actCancelExecute(Sender: TObject);
begin
  inherited;
  Self.Close;

end;

procedure TfmSalesLineBOMTree.actInvoiceExecute(Sender: TObject);
var
  IdList:TIntegerList;
  Msg:String;
begin
  inherited;

  if not isJobSelected then exit;

  if not(Savechanges) then exit;

  CommitTransaction;
  Try

    IdList:=TIntegerList.Create;
    try
      IdList.Add(QrymainsaleId.AsInteger);
          if DoJobComplete(IdList, false, msg) then begin
            if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
            Self.Close;
            Exit;
          end;
    finally
      Freeandnil(IDList);
    end;
  Finally
    BeginTransaction;
  End;
end;

procedure TfmSalesLineBOMTree.actOpenSaleExecute(Sender: TObject);
begin
  inherited;
  openERPForm('TSalesOrderGUI' , QrymainsaleId.AsInteger);
end;

procedure TfmSalesLineBOMTree.actOrderStatusExecute(Sender: TObject);
begin
  inherited;
  if not isJobSelected then exit;
  OpenERpListform('TBOMOrderStatusGUI' , beforeopenBOMOrderStatus )
end;
procedure TfmSalesLineBOMTree.beforeopenBOMOrderStatus(sender:TObject);
begin
  if not(sender is TBOMOrderStatusGUI) then Exit;
  TBOMOrderStatusGUI(Sender).SaleId     := QrymainsaleID.asInteger;
  TBOMOrderStatusGUI(Sender).SaleLineId := QrymainSaleLineId.asInteger;

end;

procedure TfmSalesLineBOMTree.actPartialInvoiceExecute(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmBarCodeManufacturingSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
(*  if not isJobSelected then exit;
  self.CommitTransaction;
  try
    Userlock.UnlockAllCurrentInstance;

    OpenERPFormModal('TfmSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
  finally
    SetSaleLineId(SaleLineID);
    LockCapacityplanner;
  end;*)

end;
procedure TfmSalesLineBOMTree.actPartialInvoiceUpdate(Sender: TObject);
begin
  inherited;
  if qryMainIsInternalOrder.asBoolean then actPartialInvoice.caption := 'Place Into Stock' else actPartialInvoice.caption := 'Invoice';
end;

procedure TfmSalesLineBOMTree.OnSalesOrderInvoiceCreate(Sender:TObject);
begin
  (*if sender is TfmSalesorderInvoice then begin
        if TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrder.isinternalOrder  then
          MessageDlgXP_vista('Quantity Selected is now in stock for Sales Order # ' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrderID)+'.', mtConfirmation, [mbOK], 0)
        else if TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId <> 0 then
              if MessageDlgXP_vista('Invoice #' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId ) +' is Created. '+
                                      'Do you want to see the invoice? ' , mtConfirmation, [mbyes,mbno], 0) = mryes then
                  OpenERPForm('TInvoiceGUI' , TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId);
  end else *)if sender is TfmBarCodeManufacturingSalesorderInvoice then begin
        if TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrder.isinternalOrder  then
          timerMsg(lblMsg ,'Quantity Selected is now in stock for Sales Order # ' + inttostr(TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrderID)+'.')
        else if TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId <> 0 then
          timerMsg(lblMsg ,'Invoice #' + inttostr(TfmBarCodeManufacturingSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId ) +' is Created. ');
  end;

end;
procedure TfmSalesLineBOMTree.initSalesorderInvoice(Sender: TObject);
begin
  (*if sender is TfmSalesorderInvoice then begin
      TfmSalesorderInvoice(Sender).saleID     := QrymainsaleId.AsInteger;
      TfmSalesorderInvoice(Sender).SaleLineID := QrymainsalelineID.AsInteger;
  end else   *)if Sender is   TfmBarCodeManufacturingSalesorderInvoice then begin
      TfmBarCodeManufacturingSalesorderInvoice(Sender).saleID     := QrymainsaleId.AsInteger;
      TfmBarCodeManufacturingSalesorderInvoice(Sender).SaleLineID := QrymainsalelineID.AsInteger;
      qryMain.first;
      TfmBarCodeManufacturingSalesorderInvoice(Sender).QtyBuilt := qryMainQtyBuilt.asFloat;
      TfmBarCodeManufacturingSalesorderInvoice(Sender).Callingformname := Self.classname;
  end;
end;

procedure TfmSalesLineBOMTree.actPQAllocationExecute(Sender: TObject);
begin
  inherited;
  if not isJobSelected then exit;

  if qryMainIsSalesconverted.AsBoolean then exit;

  if (QrymainSaleId.AsInteger =0) or ( QrymainSaleLineId.AsInteger =0) then exit;
  TfmBOMAllocation.DoAllocation(QrymainSaleId.AsInteger, QrymainSaleLineId.AsInteger, nil);

end;

procedure TfmSalesLineBOMTree.actPrintJobDetailsExecute(Sender: TObject);
var
  StrSQL:String;
  fsTablename :String;
begin
  inherited;
  if not isJobSelected then exit;

    if (QrymainsaleLineId.asInteger =0) or ( qrymainPPId.AsInteger =0) or (qryMainUnitofMeasureShipped.AsFloat =0) then exit;
    fsTablename := commondblib.GetUserTemporaryTableName('CPProductDetailreport');
    StrSQL :=ProductJobDEtailsSQL(fsTablename,  QrymainsaleLineId.asInteger,  qrymainPPId.AsInteger,qryMainTotalQty.AsFloat);

  fbReportSQLSupplied := True;
  PrintTemplateReport('Product Job Details' , strSQL , False, 1);
  TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + fstablename + ';');
end;

procedure TfmSalesLineBOMTree.actPrintWorkSheetsExecute(Sender: TObject);
var
  Form : TfmPrintWorkOrders;
  tmp_main :String;
begin
  if not qryMainIsScheduled.AsBoolean then begin
    MessageDlgXP_Vista('Selected job #'+inttostr(QrymainsaleId.asInteger)+' is not Scheduled', mtInformation, [mbOK], 0);
    Exit;
  end;
  if qryMainIsSalesconverted.AsBoolean then begin
    MessageDlgXP_Vista('Selected job #'+inttostr(QrymainsaleId.asInteger)+' is Already Converted', mtInformation, [mbOK], 0);
    Exit;
  end;
    tmp_main :=CommonDbLib.GetUserTemporaryTablename('EMP_WO' );
    try
      PopulateWorkOrderReportTable(tmp_main , 0, 0, SaleLineId);
      form := TfmPrintWorkOrders.Create(Self);
      form.tmp_EmpWorkOrder := tmp_main;
      form.tmp_SimpeWorkOrder := tablename ;
      form.CallingFormname := Self.classname;
      form.ProcessPartIDs := SelectedProcessPartIDs;
      form.dateFrom := 0;
      form.DateTo := 0;
      form.FormStyle := fsStayonTop;
      form.ShowModal;
    finally
      //DestroyUserTemporaryTable(tmp_main);
      TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + tmp_main + ';');
      TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + tmp_main + '_1;');
      TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + tmp_main + '_2;');
    end;
(*var
  form: TfmProcCapacityPlanningWork;
  x,i: integer;
begin
  inherited;
  if not isJobSelected then exit;

  CommitTransaction;
  try

    form:= TfmProcCapacityPlanningWork.Create(nil);
    form.CallingFormname := Self.classname;
    Qrymain.First;
    form.SaleLineIDList.AddIfNotInList(QrymainsaleLineID.asInteger);
    While Qrymain.Eof =False do begin
      form.ProcesstepIdList.AddIfNotInList(QrymainPSID.asInteger);
      Qrymain.Next;
    end;
    if form.ProcesstepIdList.IsEmpty then begin
      MessageDlgXP_Vista('No Process found.', '',mtInformation,[mbOk],0);
      form.Free;
    end else begin
      form.ShowModal;
    end;
  finally
    BeginTransaction;
  end;*)
end;

procedure TfmSalesLineBOMTree.actProductTreeExecute(Sender: TObject);
begin
  inherited;
  if not isJobSelected then exit;

  if qryMainIsSalesconverted.AsBoolean=False then
      ManufactureGuiLib.OpenTree(Self ,  TreeRootIDofPP(QrymainPPID.AsInteger) , QrymainSaleID.AsInteger , Userlock, self.Caption)
  else MessageDlgXP_Vista('The Selected job #'+inttostr(QrymainsaleId.asInteger)+' is Already Converted', mtInformation, [mbOK], 0);
end;

procedure TfmSalesLineBOMTree.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not(Savechanges) then exit;
  CommitTransaction;
  Self.close;

end;

procedure TfmSalesLineBOMTree.actStowAwayExecute(Sender: TObject);
var
  msg:String;
begin
  inherited;
  if not isJobSelected then exit;

  if qryMainIsSalesconverted.asBoolean then exit;

  if not TfmStowAway.DoStow(TreeRootIDofPP(Qrymainppid.AsInteger) , msg) then
    MessageDLGXP_Vista(QrymainProductName.AsString+   ' Can''t Stow Away :' +Msg, mtWarning, [mbok],0);
end;

function TfmSalesLineBOMTree.SaveChanges:Boolean;
var
  st:TStringlist;
begin
  inherited;
  Result := False;
  BeginTransaction;
  try
      st:= tStringlist.create;
      try
        St.Clear;


        Qrymain.first;
        While Qrymain.eof = False do begin
          St.Add('update tblprocesspart Set BuildingBlockQty ='     + floattostr(qryMainBuildingBlockQty.AsFloat)+' where ID =' + inttostr(QrymainPPId.asInteger)+' and ifnull(BuildingBlockQty,0) <>'      + floattostr(qryMainBuildingBlockQty.AsFloat)+' ;');
          St.Add('update tblprocesspart Set ProcessStepExtraInfo  ='+ quotedstr(qryMainNotes.asString)           +' where ID =' + inttostr(QrymainPPId.asInteger)+' and ifnull(ProcessStepExtraInfo,"") <>' + Quotedstr(qryMainNotes.AsString)           +' ;');
          Qrymain.Next;
        end;
        St.add('insert ignore into tblprocesspartqty (ProcessPartID , BuildDate , QtyBuilt , BuiltEmployeeId) '+
                                                    ' Select PPId , '+Quotedstr(Formatdatetime(MySQLDatetimeformat , Now))+' , QtyBuilt , ' + inttostr(Appenv.Employee.EmployeeID) +
                                                    ' from '+ Tablename +' where ifnull(QtyBuilt,0)>0;');

        St.add('Update tblproctree Pt inner join  '+ Tablename +' T on PT.ProctreeId = T.ProctreeId Set Pt.totalQty = Pt.totalQty  + T.WastageQty where ifnull(T.WastageQty,0)<> 0;');

        if St.count >0 then ExecuteSQLinconnection(st.text);
        REsult := TRue;
      finally
        Freeandnil(st);
      end;
  Except
    on E:Exception do begin
      RollbackTransaction;
    end;
  end;
end;


procedure TfmSalesLineBOMTree.chkShowSalesDetailsClick(Sender: TObject);
begin
  inherited;
  pnlSalesDetails.visible := chkShowSalesDetails.checked ;
  (*if chkShowSalesDetails.checked  then begin
    //pnlTop.Height := 190;
    pnlSalesDetails.visible := true;
  end else begin
    pnlTop.Height := 90;
    //pnlSalesDetails.visible := False;;
  end;*)
end;

procedure TfmSalesLineBOMTree.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.showSalesDetails'].asBoolean:= chkShowSalesDetails.checked;
  inherited;
  action := caFree;
end;

procedure TfmSalesLineBOMTree.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  TableName := GetUserTemporaryTableName('BOMtreeEdit');
  Qrymain.SQL.Text := 'select * from '+tablename ;
  Self.fbIgnoreAccessLevels := true;
  inherited;
  SaleLineId := 0;
  With TERPMainSwitchButton.create(Self)do begin
    Name := MakeName(Self,'btn_1');
    Parent := pnlTop;
    Align := alRight;
    width := 75;
    DnmAction := ActChoosesalesLines;
    AlignWithMargins := True;
    Margins.Left:= 2;Margins.right:= 2;Margins.top:= 1;Margins.bottom:= 1;
    Left := 0;
  end;

end;
procedure TfmSalesLineBOMTree.ChooseSalesLine(Sender: TObject);
begin
  if SaleLineID <> 0 then
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:begin
          if not(Savechanges) then exit;
          CommitTransaction;
        end;
      mrNo: begin
            end;
      mrCancel:
        begin
          Exit;
        end;
    end;
    OpenERPListFormSingleselectModal('TProductionOrdersGUI' , OnSelectsalesLine  , initProductionOrders);
end;
function TfmSalesLineBOMTree.isJobSelected(  MsgWhenNoneSelected: String): Boolean;
begin
  REsult := True;
  if QrymainsaleID.AsInteger=0 then begin
    REsult := False;
    if MsgWhenNoneSelected ='' then MsgWhenNoneSelected := 'Please Choose a Job';
    MessageDlgXP_Vista(MsgWhenNoneSelected, mtWarning, [mbOK], 0);
  end;

end;

procedure TfmSalesLineBOMTree.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(Tablename);
  inherited;
end;
procedure TfmSalesLineBOMTree.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and (ssAlt in Shift) then begin
         if (Key = vk_RIGHT) then Self.width := Self.width + 5
    else if (Key = vk_LEFT) then Self.width := Self.width - 5
    else if (Key = vk_UP) then Self.width := Self.width +2
    else if (Key = vk_DOWN) then Self.width := Self.width -2;
  end;
end;

procedure TfmSalesLineBOMTree.OnSelectsalesLine(Sender: TwwDbGrid);
begin
  if not(Assigned(Sender.Owner)) then exit;
  if not(Sender.Owner  is TProductionOrdersGUI) then exit;
  SaleLineID := TProductionOrdersGUI(Sender.Owner).QrymainSaleLineID.asInteger;
  Initform;

end;
procedure TfmSalesLineBOMTree.initProductionOrders(Sender: TObject);
begin
  if not(Sender  is TProductionOrdersGUI) then exit;
  TProductionOrdersGUI(Sender).timedMsgOnshow := 'Please Choose A Job for Work Order';
  (*TProductionOrdersGUI(Sender).imgGridWatermark.picture.Assign(Image1.Picture);
  //TProductionOrdersGUI(Sender).grdMain.OnBeforePaint := TProductionOrdersGUI(Sender).grdMainBeforePaint;
  TProductionOrdersGUI(Sender).ShowSearchModeWaterMark;*)
  (*TProductionOrdersGUI(Sender).ShowWaterMark(Image1);*)
end;

procedure TfmSalesLineBOMTree.FormShow(Sender: TObject);
begin
  inherited;
  if SalelineId = 0 then
    OpenERPListFormSingleselectModal('TProductionOrdersGUI' , OnSelectsalesLine , initProductionOrders);

  chkShowSalesDetails.checked :=  GuiPrefs.Node['Options.showSalesDetails'].asBoolean;
  chkShowSalesDetailsClick(chkShowSalesDetails);

  Initform;
end;

Procedure TfmSalesLineBOMTree.Initform;
begin
  OpenQueries;
  if not Userlock.lock('tblsales', QrymainsaleId.asInteger) then begin
      Accesslevel:= 5;
      CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + NL+NL+
                                  'Access will be changed to read-only.', mtWarning, [mbOK], 0);
  end;
  //if qryMainIsInternalOrder.asBoolean then btnInvoice.caption := 'Place Into Stock' else btnInvoice.caption := 'Invoice';
  //btnAutoSchedule.enabled := not(tcDatautils.AnyProcessScheduled(QrymainsaleId.asInteger));
end;
procedure TfmSalesLineBOMTree.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  (*if sametext(Field.FieldName , qryMainBuildingBlockQty.FieldName) or
    sametext(Field.FieldName , qryMainnotes.FieldName) then
  else begin
    AFont.Color := GridColBrushInactive;
  end;*)
  if Field.Readonly then ABrush.Color := GridColBrushInactive;
end;

procedure TfmSalesLineBOMTree.grdMainCalcTitleAttributes(Sender: TObject;AFieldName: string; AFont: TFont; ABrush: TBrush;var ATitleAlignment: TAlignment);
begin
  inherited;
  (*if sametext(aFieldName , qryMainBuildingBlockQty.FieldName) or
    sametext(aFieldName , qryMainnotes.FieldName) then
  else begin
    AFont.Color := GridColBrushInactive;
  end;*)
  if Qrymain.findfield(AFieldname).Readonly then ABrush.Color := GridColBrushInactive;
  if Sametext(Afieldname, qryMaintotalDuration.fieldname ) then ATitleAlignment := taRightJustify;

(*  if  sametext(aFieldName , qryMainBuildingBlockQty.FieldName) then
      Afont.size := 12;*)

end;

procedure TfmSalesLineBOMTree.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainID.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainProctreeId.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainRowno1.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainParentId.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainPPID.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainPSID.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainKeyStr.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainsaleLineId.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainQuantity.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainDuration.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainSingleDuration.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainIsScheduled.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainIsSalesconverted.FieldName);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainIsInternalOrder.FieldName);



    qryMainCustomerName.ReadOnly := True;
    qryMainSaleDate.ReadOnly := True;
    qryMainShipDate.ReadOnly := True;
    qryMainsaleId.ReadOnly := True;
    qryMainproductName.ReadOnly := True;
    qryMainUOM.ReadOnly := True;
    qryMainUnitofMeasureQtySold.ReadOnly := True;
    qryMainUnitofMeasureShipped.ReadOnly := True;
    qryMainUnitofMeasureBackorder.ReadOnly := True;
    qryMainCaptionIntend.ReadOnly := True;
    qryMaindescription.ReadOnly := True;
    qryMainProcessStepSeq.ReadOnly := True;
    qryMainTotalQty.ReadOnly := True;
    qryMaintotalDuration.ReadOnly := True;
    qryMainSalesCaption.ReadOnly := True;
    qryMainCleanQtyBuilt.ReadOnly := TRue;
    qryMainCleanWastageQty.ReadOnly := TRue;


    qryMainBuildingBlockQty.ReadOnly := qryMainIsScheduled.AsBoolean or qryMainIsSalesconverted.AsBoolean;

    qryMainNotes.ReadOnly := qryMainIsSalesconverted.AsBoolean;
    qryMainQtyBuilt.ReadOnly := qryMainIsSalesconverted.AsBoolean;
    qryMainWastageQty.ReadOnly := qryMainIsSalesconverted.AsBoolean;

    if (QrymainsaleID.asInteger<> 0) then  Showcontrolhint(btnAutoSchedule ,'Selcted Job #' + inttostr(QrymainsaleID.asInteger)+' is ' + qryMaincIsScheduled.asString+NL+
                                                                                                              'Choose to Schedule Any Pending Job')
    else Showcontrolhint(btnAutoSchedule ,'Choose to Schedule Any Pending Job');


    (*timerMsg (lblMsg , 'Sales Orer #' + inttostr(QrymainSaleID.asInteger) +' -> ' +
              iif(qryMainIsSalesconverted.AsBoolean , 'Converted', 'Not converted') +' and ' +
              iif(qryMainIsScheduled.AsBoolean , 'Scheduled', 'Not Scheduled'));*)
end;

procedure TfmSalesLineBOMTree.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainSalesCaption.asSTring      := 'Sales Order # ' + inttostr(qryMainsaleId.asInteger);
  qryMaincIsScheduled.AsString      := iif(qryMainIsScheduled.AsBoolean , 'Scheduled', 'Not Scheduled');
  qryMaincIsSalesconverted.AsString := iif(qryMainIsSalesconverted.AsBoolean , 'Converted', 'Not Converted');
  qryMaincIsInternalOrder.AsString := iif(qryMainIsInternalOrder.AsBoolean , 'Internal Order', '');
end;

function TfmSalesLineBOMTree.SelectedProcessPartIDs: String;
begin
  Result :=SelectedIDs(grdMain , 'PPID', true);
end;

procedure TfmSalesLineBOMTree.SetSaleLineId(const Value: Integer);
var
  qry: TERPQuery;
begin
  inherited;
  fiSaleLineId := Value;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.MyConnection);
  try
    qry.SQL.clear;
    qry.SQL.add('Drop table if exists '+ tablename +';');
    qry.SQL.add('CREATE TABLE '+ tablename +' ( '+
                '  ID                     INT(11) NOT NULL AUTO_INCREMENT, '+
                '  Rowno1                 INT(11) NOT NULL  DEFAULT 0 , '+
                '  Rowno2                 INT(11) NOT NULL  DEFAULT 0 , '+
                '  ProctreeId             INT(11) NOT NULL  DEFAULT 0 , '+
                '  ParentId               INT(11)           DEFAULT NULL, '+
                '  PPID                   INT(11)           DEFAULT 0 , '+
                '  CustomerName           VARCHAR (255)      DEFAULT NULL, '+
                '  SaleDate               date              DEFAULT NULL, '+
                '  ShipDate               datetime          DEFAULT NULL, '+
                '  KeyStr                 VARCHAR (255)      DEFAULT NULL, '+
                '  saleId                 INT(11)           DEFAULT 0 , '+
                '  saleLineId             INT(11) NOT NULL  DEFAULT 0 , '+
                '  productName            VARCHAR (60)       DEFAULT NULL, '+
                '  UOM                    VARCHAR (255)      DEFAULT NULL, '+
                '  UnitofMeasureQtySold   double NOT NULL   DEFAULT 0 , '+
                '  UnitofMeasureShipped   double NOT NULL   DEFAULT 0 , '+
                '  UnitofMeasureBackorder double NOT NULL   DEFAULT 0 , '+
                '  CaptionIntend          VARCHAR (255) , '+
                '  PSID                   INT(11)           DEFAULT 0 , '+
                '  description            VARCHAR (255)      DEFAULT " ", '+
                '  ProcessStepSeq         INT(11)           DEFAULT 0 , '+
                '  BuildingBlockQty       double            DEFAULT 1, '+
                '  TotalQty               double NOT NULL   DEFAULT 0 , '+
                '  Quantity               double NOT NULL   DEFAULT 0 , '+
                '  Duration               VARCHAR (255) , '+
                '  SingleDuration         VARCHAR (255) , '+
                '  totalDuration          VARCHAR (255) , '+
                '  Notes                  VARCHAR (255)      DEFAULT " " ,'+
                '  IsScheduled            ENum("T","F") DEfault "F" , '+
                '  IsSalesconverted       ENum("T","F") DEfault "F" , '+
                '  IsInternalOrder        ENum("T","F") DEfault "F" , '+
                '  QtyBuilt               double NOT NULL   DEFAULT 0 , '+
                '  CleanQtyBuilt          double NOT NULL   DEFAULT 0 , '+
                '  WastageQty             double NOT NULL   DEFAULT 0 , '+
                '  CleanWastageQty        double NOT NULL   DEFAULT 0 , '+
                ' FormulaId           int(11) default 0,'+
                ' FormulaName         varchar(255),'+
                ' formula             varchar(255),'+
                ' formulaDetails      varchar(255),'+
                ' FormulaQty1         Double, '+
                ' FormulaQty2         Double, '+
                ' FormulaQty3         Double, '+
                ' FormulaQty4         Double, '+
                ' FormulaQty5         Double, '+
                '	PRIMARY KEY (`ID`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
    qry.SQL.add('insert ignore into  '+ tablename +
                ' (	Rowno1 , Rowno2,ProctreeId,ParentId,PPID,CustomerName,SaleDate,ShipDate,KeyStr,saleId,saleLineId,productName,UOM,UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,	'+
                ' CaptionIntend, PSID, description ,ProcessStepSeq ,BuildingBlockQty ,TotalQty ,Quantity ,Duration ,SingleDuration ,totalDuration ,Notes,IsSalesconverted ,IsInternalOrder)'+
                ' Select distinct '+
                ' @rownum:=if(@ProctreeID <> PT.ProcTreeId,  @rownum:= 1 ,  @rownum+1) rownum , @ProctreeID := PT.ProcTreeId,'+
                '  PT.ProctreeId, PT.ParentId, '+
                ' PP.ID as PPID, '+
                ' S.CustomerName, '+
                ' S.SaleDate, '+
                ' SL.ShipDate, '+
                ' concat_ws(",",S.saleID,SL.saleLineId, PT.ProctreeId, PP.ID) as KeyStr, '+
                ' SL.saleId, SL.saleLineId, SL.productName, concat(SL.UnitofMeasureSaleLines ,  "(" , SL.UnitofMeasureMultiplier,")" ) as UOM, '+
                ' SL.UnitofMeasureQtySold, SL.UnitofMeasureShipped, SL.UnitofMeasureBackorder , '+
                ' replace(Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)),"," , "\n") CaptionIntend, '+
                'PS.ID, PS.description , PP.ProcessStepSeq,PP.BuildingBlockQty, '+
                ' PT.TotalQty,PT.Quantity,  '+
                ' FormatSecondsTotime(ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0))    Duration,  '+
                ' FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * PT.quantity) SingleDuration,  '+
                ' FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * PT.totalQty) as totalDuration,' +
                ' PP.ProcessStepExtraInfo as Notes , S.converted, S.IsInternalOrder'+
                ' From '+
                ' tblsales S '+
                ' inner join tblsaleslines SL on SL.saleId = S.SaleId '+
                ' inner join tblproctree PT on SL.saleLineId = PT.MasterId and PT.MasterType <> "mtProduct" '+
                ' Left join tblProcessPart PP on PT.ProcTreeId = PP.ProctreeId '+
                ' Left join tblProcessStep PS on PP.ProcessStepId = PS.ID '+
                ',(SELECT @rownum:=0) r , (SELECT @ProctreeID:=0) s'+
                ' Where SL.SaleLineID =  '+inttostr(Value)+
                ' Order by SaleId, SaleLineId , Sequencedown  , PP.ProcessStepSeq;');

    qry.SQL.add('update  '+ tablename + ' T inner join  tblsaleslines SL on SL.salelineId = T.saleLineid'+
            ' inner join tblfesaleslines SLFE on T.SaleLineId = SLFE.SaleLineId and ifnull(T.parentId,0)=0' +
            ' inner join tblfeformula FEF on SLFE.FormulaID = FEF.FormulaID ' +
            ' set T.FormulaId    = SLFE.FormulaID, '+
            ' T.FormulaName    = FEF.FormulaName ,'+
            ' T.formula        = FEF.Formula,'+
            ' T.formulaDetails = DescribeFormula( FEF.Formula),'+
            ' T.FormulaQty1    = SLFE.Field1, '+
            ' T.FormulaQty2    = SLFE.Field2, '+
            ' T.FormulaQty3    = SLFE.Field3, '+
            ' T.FormulaQty4    = SLFE.Field4, '+
            ' T.FormulaQty5    = SLFE.Field5; ');


    qry.SQL.add('update  '+ tablename + ' T inner join  tblsaleslines SL on SL.salelineId = T.saleLineid'+
            ' inner join tblproctree PT on PT.proctreeId = T.proctreeId  and ifnull(T.parentId,0)<>0' +
            ' inner join tblfeformula FEF on PT.FormulaID = FEF.FormulaID ' +
            ' set T.FormulaId    = PT.FormulaID, '+
            ' T.FormulaName    = FEF.FormulaName ,'+
            ' T.formula        = FEF.Formula,'+
            ' T.formulaDetails = DescribeFormula( FEF.Formula),'+
            ' T.FormulaQty1    = PT.FormulaQtyValue1, '+
            ' T.FormulaQty2    = PT.FormulaQtyValue2, '+
            ' T.FormulaQty3    = PT.FormulaQtyValue3, '+
            ' T.FormulaQty4    = PT.FormulaQtyValue4, '+
            ' T.FormulaQty5    = PT.FormulaQtyValue5; ');


    qry.SQL.add('update  '+ tablename + ' set IsScheduled =' + quotedstr(BooleantoStr(IsSalesLineScheduled(Value)))+';');
    qry.SQL.add('Drop table if exists  '+ tablename + '1;');
    qry.SQL.add('Create table   '+ tablename + '1 Select PP.ProcessPArtID PPID, sum(PP.QtyBuilt) as QtyBuilt From tblprocesspartqty PP inner join '+tablename +' T on PP.ProcessPartID = T.PPID group by PP.ProcessPArtID ;');
    qry.SQL.add('update '+ tablename + ' T inner join  '+ tablename + '1 as T1 on T.PPID = T1.PPID Set T.CleanQtyBuilt = T1.QtyBuilt;');

    qry.SQL.add('Drop table if exists  '+ tablename + '1;');
    qry.SQL.add('Create table   '+ tablename + '1 Select PT.ProctreeId , PTC.totalQty - PT.totalQty WastageQty from '+Tablename +' PT inner join tblproctreeclean PTC on PT.procTreeId = PTC.procTreeID;');
    qry.SQL.add('update '+ tablename + ' T inner join  '+ tablename + '1 as T1 on T.ProctreeId = T1.ProctreeId Set T.CleanWastageQty = T1.WastageQty;');
    clog(qry.sql.text);
    qry.Execute;
    closeDB(Qrymain);
    if Value >0 then
        Repeat
          closedb(Qry);
          Qry.SQL.clear;
          Qry.SQL.add('Drop table if exists '+Tablename +'2;');
          Qry.SQL.add('create table '+Tablename +'2 select distinct ParentID from '+Tablename +';');
          Qry.SQL.add('Delete from '+Tablename +' where ifnull(description , "") ="" and ProctreeId not in (select ParentId from '+Tablename +'2);');
          Qry.SQL.add('select count(ProctreeID) ctr from '+Tablename +' where ifnull(description , "") ="" and ProctreeId not in (select ParentId from '+Tablename +');');
          Qry.Open;
        Until Qry.fieldbyname('ctr').asInteger =0;
(*    closeDB(Qry);
    Qry.sql.text :='Drop table if exists '+ tablename +'1;' +NL+
                   'Create table '+ tablename +'1 like  '+ tablename +';'+NL+
                   'insert into  '+ tablename +'1 select * from  '+ tablename +';';
    Qry.Execute;*)
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;


initialization
  RegisterClass(TfmSalesLineBOMTree);

end.
