unit frmQuickPOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CashSaleBase, DataState, DB, DBAccess, MyAccess, ERPdbComponents,
  ProgressDialog, ImgList, AdvMenus, DNMAction, ActnList, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, MemDS, DBCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, ERPDbLookupCombo, Shader, wwdbedit, StdCtrls, Mask,
  wwdbdatetimepicker, wwdblook, DNMSpeedButton, DNMPanel,  ImageDLLLib,
  AdvGlowButton, CustomInputBox, BusObjBase , BusObjPosTill ,ReceiptPrinterObj , frmPOSCancelDialog;

type
  TfmQuickPOS = class(TCashSaleBaseGUI)
    edtPOSMemo: TMemo;
    dlgPassword: TCustomInputBox;
    Bevel5: TShader;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lblTillHead: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    pnlFnKeyBtns: TDNMPanel;
    DNMPanel1: TDNMPanel;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    Shader1: TShader;
    pnltotal: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    pnlNumericKeyPad: TDNMPanel;
    btnNum2: TDNMSpeedButton;
    btnNum3: TDNMSpeedButton;
    btnNum4: TDNMSpeedButton;
    btnNum5: TDNMSpeedButton;
    btnNumDot: TDNMSpeedButton;
    btnNum6: TDNMSpeedButton;
    btnNum7: TDNMSpeedButton;
    btnNum8: TDNMSpeedButton;
    btnNum9: TDNMSpeedButton;
    btnNum0: TDNMSpeedButton;
    btnNumBS: TDNMSpeedButton;
    btnNum1: TDNMSpeedButton;
    DBMemo1: TDBMemo;
    tblDetailsLineDetails: TStringField;
    pnlCustomer: TShader;
    Label7: TLabel;
    Label8: TLabel;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    Label13: TLabel;
    wwDBEdit8: TwwDBEdit;
    DNMPanel3: TDNMPanel;
    btnSalesPerson: TAdvGlowButton;
    btnProductList: TAdvGlowButton;
    btnCustomer: TAdvGlowButton;
    DNMPanel4: TDNMPanel;
    DNMPanel6: TDNMPanel;
    DNMPanel7: TDNMPanel;
    btnQty: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    btnnoSale: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
    btnCheque: TAdvGlowButton;
    btncreditcard: TAdvGlowButton;
    btneftpos: TAdvGlowButton;
    btncash: TAdvGlowButton;
    btnRefund: TAdvGlowButton;
    btnPrintA4: TAdvGlowButton;
    btnNew: TAdvGlowButton;
    actSalesPerson: TDNMAction;
    actProductList: TDNMAction;
    actCustomer: TDNMAction;
    actPrintReceipt: TDNMAction;
    actQty: TDNMAction;
    actPrice: TDNMAction;
    actRefund: TDNMAction;
    actcancel: TDNMAction;
    actcheque: TDNMAction;
    actCreditCard: TDNMAction;
    actEFTPos: TDNMAction;
    actCash: TDNMAction;
    actNoSale: TDNMAction;
    actNewSale: TDNMAction;
    actPrintA4Report: TDNMAction;
    btnPrintPOS: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    actUOM: TDNMAction;
    lbldone: TLabel;
    procedure edtPOSMemoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnNumPadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure tblDetailsAfterInsert(DataSet: TDataSet);
    procedure actSalesPersonExecute(Sender: TObject);
    procedure actProductListExecute(Sender: TObject);
    procedure actCustomerExecute(Sender: TObject);
    procedure actPrintReceiptExecute(Sender: TObject);
    procedure actQtyExecute(Sender: TObject);
    procedure actPriceExecute(Sender: TObject);
    procedure actRefundExecute(Sender: TObject);
    procedure actcancelExecute(Sender: TObject);
    procedure actchequeExecute(Sender: TObject);
    procedure actCreditCardExecute(Sender: TObject);
    procedure actEFTPosExecute(Sender: TObject);
    procedure actCashExecute(Sender: TObject);
    procedure actNoSaleExecute(Sender: TObject);
    procedure actPrintA4ReportExecute(Sender: TObject);
    procedure actPrintA4ReportUpdate(Sender: TObject);
    procedure disableOnSave(Sender: TObject);
    procedure EnableOnSave(Sender: TObject);
    procedure actNewSaleExecute(Sender: TObject);
    procedure actUOMUpdate(Sender: TObject);
    procedure actUOMExecute(Sender: TObject);
  private
    TillID:Integer;
    IsToclearMemo:Boolean;
    bOkToOpenCashDrawer:boolean;
    fPosTill :TPosTillDetails;
    oCashDrawer: TReceiptPrinter;
    oRcptPrn: TReceiptPrinter;
    TransSaved:Boolean;

    procedure BarcodeFn;
    procedure Selectemployee(Grid: TwwDbGrid);
    procedure SelectProducts(grid: TWWDBGrid);
    procedure SelectCustomer(grid: TWWDBGrid);
    procedure SelectUOM(grid: TWWDBGrid);


    //procedure beforeshowProductList(Sender: TObject);
    procedure POSKeyDown(const wKey: word; const Shift: TShiftState);
    procedure AddDigitToViewer(const cDigit: char);
    function GetTillForPOS: integer;
    procedure showCompletedpic;
    function SavePOS(PayType: String; isCC :Boolean ;Addingnew:boolean=False):boolean; Overload;
    procedure OpenCashDrawer;
    function PosTill :TPosTillDetails;
    procedure CerateReceiptPrinte;
    function IsUsingReceiptPrinter: boolean;
    function MemoInput(const memoCaption: String; var sResult: String; Required: boolean = false):Boolean;
    function CancelnNew: Boolean;
    function LoadRefundSale(const SalesGlobalRef: String): boolean;
    procedure PrintSaleinA4;
    procedure InitEmpList(Sender: TObject);
    procedure initUOMlist(Sender: TObject);

    function POSMsg(Msg: String; PosMsgButtons: TPosMsgButtons): TModalResult;

  Protected
    procedure NewTransBusObjinstance;override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure DoFormSize(ChangeSize:Boolean);Override;
    Function SaveCashSale :Boolean;Override;
    procedure OnClearGridBedorePait(Grid:TwwDBGrid);Override;
    procedure PaintTimerTimeout(Sender: TObject);Override;
    function SaveTrans:Boolean ; Overload;Override;

  public
  end;


implementation

uses CommonLib, AppEnvironment, BusObjPOSSale, BusobjCash, tcConst, BusObjStock,
  tcDataUtils, CommonFormLib, ProductListExpressForm, BusObjConst, FastFuncs,
  MAIN, dmMainGUI, POSConst, POSGetTillGUI, DNMLib, busobjPaymethods,
  POSLIB, CommonDbLib, RemotePrnObj, PrintReceiptLib,
  POSChequeGUI, DbSharedObjectsObj, TemplateReportsLib, frmEmployeeListFrm,
  UnitOfMeasureforProduct, dateutils;

{$R *.dfm}

{ TfmQuickPOS }



procedure TfmQuickPOS.edtPOSMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  IF (Key >=96) and (Key <=105) then Key := key - 48;    // to handle the nnumeric pad when numlock is on

       if Key in [106     ,// '*' on num pad
                 107      ,// '+' on num pad
                 109      ,// '-' on num pad
                 110      ,// DEL on num pad
                 111      ,// '/' on num pad
                 VK_END   ,{1}
                 VK_DOWN  ,{2}
                 VK_PRIOR ,{3}
                 VK_LEFT  ,{4}
                 VK_CLEAR ,{5}
                 VK_RIGHT ,{6}
                 VK_HOME  ,{7}
                 VK_UP    ,{8}
                 VK_NEXT  ,{9}
                 VK_INSERT ] then Key :=0;



  if IsToclearMemo then begin
    edtPOSMemo.Clear;
    IsToclearMemo := false;
  end;
  case Key of
          VK_RETURN: BarcodeFn;
          else if (Key <=127)  then AddDigitToViewer(char(Key))
          else key := 0;
  end;
end;
procedure TfmQuickPOS.EnableOnSave(Sender: TObject);
begin
  inherited;
    TDnmAction(Sender).Enabled := TransSaved and (Cashbase.Lines.Count >0);
end;

procedure TfmQuickPOS.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
  Self.Menu := nil;
  MainForm.Menu := nil;
end;

procedure TfmQuickPOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  MainForm.Menu := dtmMainGUI.MainMenu;
  MainForm.MainToolBar.Visible := true;
  MainForm.StatusBar.Visible := true;
end;

procedure TfmQuickPOS.FormCreate(Sender: TObject);
begin
  TransSaved := False;
  fPosTill := nil;
  IsToclearMemo:=True;
  AllowCustomiseGrid := False;
  inherited;
  SaveWithoutconfirmationOnNew := True;
  TillID :=  GetTillForPOS;
  bOkToOpenCashDrawer := OkToOpenCashDrawer(TillID);
  CerateReceiptPrinte;
  fPaintTimer.OnTimer := nil;
  lbldone.Visible := DEvmode;
end;
Procedure TfmQuickPOS.CerateReceiptPrinte;
begin

  if PosTill.IsPrintSpooler or PosTill.UsePrintSpooler then begin
    try
      oRcptPrn := TRemotePrn.Create(TillID, PosTill.RemoteTillID, CommonDbLib.GetSharedMyDacConnection);
    Except
        on E:Exception do begin
          POSMsg('Print Failed - unable to connect to the remote printer.' , bOk);
          Exit;
        end;
    end;
    TRemotePrn(oRcptPrn).SetFlushTrigger('TAX INVOICE', 3); // buffer will be flushed if more than 3 receipts
    // local cash drawer - may or may not use
    oCashDrawer := ReceiptPrinterList.CreatePrinter(PosTill.ReceiptPrinterType, PosTill.USBPrinterName);
    oCashDrawer.SetDevice(PosTill.ReceiptPrinterPort);
    oCashDrawer.Initialize;
  end else begin
    // local printer and cash drawer
    oRcptPrn := ReceiptPrinterList.CreatePrinter(PosTill.ReceiptPrinterType, PosTill.USBPrinterName);
    oRcptPrn.SetDevice(PosTill.ReceiptPrinterPort);
    oRcptPrn.Initialize;
    oCashDrawer := oRcptPrn;
  end;
  oRcptPrn.Printercharset := edtPOSMemo.font.Charset;
end;
procedure TfmQuickPOS.disableOnSave(Sender: TObject);
begin
  inherited;
  TDnmAction(Sender).Enabled := not(TransSaved);
end;

procedure TfmQuickPOS.FormDestroy(Sender: TObject);
begin
  if POSTill.IsPrintSpooler or POSTill.UsePrintSpooler then begin
    try
      ReceiptPrinterList.FreePrinter(oCashDrawer);
    Except
    end;
  end;
  Freeandnil(fPosTill);
  inherited;

end;

procedure TfmQuickPOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    if Cashbase.dirty then begin
      POSMsg('POS Transaction is not Complete.'+NL+'You can not Exit' , bOk);
      Exit;
    end;
  inherited;
end;

procedure TfmQuickPOS.FormShow(Sender: TObject);
begin
  inherited;
  grdtransactions.Options := grdtransactions.Options - [dgEditing];
  grdtransactions.Options := grdtransactions.Options - [dgRowLines];
  grdtransactions.Options := grdtransactions.Options - [dgcolLines];
  grdTransactions.font.size := 12;
  grdtransactions.KeyOptions := [];
  grdtransactions.ControlType.Clear;
  edtPOSMemo.lines[0] :='';
  edtPOSMemo.lines[1] :='';
  MainForm.MainToolBar.Visible := false;  // make the toolbar disapear
  MainForm.StatusBar.Visible := false;
  grdTransactions.PopupMenu := nil;
  btnRefund.enabled := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnRefund', Cashbase.EmployeeID) = 1;
end;

procedure TfmQuickPOS.grdTransactionsEnter(Sender: TObject);
begin
  //inherited; : this is to hide the watermark display and price lockng etc

end;



procedure TfmQuickPOS.AddDigitToViewer(const cDigit: char);
var
  sTemp: string;
begin
  if cDigit = '.' then begin
    if FastFuncs.PosEx('.', edtPOSMemo.Lines[0]) <> 0 then Exit
    else edtPOSMemo.Lines[0] := edtPOSMemo.Lines[0] + '.';
  end else if cDigit = char(VK_Back) then begin
    sTemp := edtPOSMemo.Lines[0];
    Setlength(sTemp, char_length(sTemp) - 1);
    edtPOSMemo.Lines[0] := sTemp;
  end else edtPOSMemo.Lines[0] := edtPOSMemo.Lines[0] + cDigit;
  if char_length(edtPOSMemo.Lines[0]) = 0 then begin
    edtPOSMemo.Clear;
  end;

end;

procedure TfmQuickPOS.BarcodeFn;
var
  s:String;
  PartsId :Integer;
  UomID:Integer;
begin
  s:= Trim(edtPOSMemo.Lines[0]);
  if s = '' then exit;
  PartsId := TProduct.ProductIdForBarcode(s, UOMID);
  if PartsId <> 0 then begin
    Cashbase.lines.New;
    Cashbase.lines.ProductId := PartsID;
    if UOMID <> 0 then Cashbase.lines.UnitOfMeasureID := UOMID;
    Cashbase.lines.UOMQtySold := 1;
    Cashbase.lines.UOMQtyShipped := 1;
  end else begin
    POSMsg('Product not found for barcode' , bOk);
  end;
  edtPOSMemo.Clear;
end;

procedure TfmQuickPOS.NewTransBusObjinstance;
begin
  Freeandnil(CashBase);
  if AppEnv.CompanyPrefs.POSSummarise then begin
    CashBase := TCashSale(TPOSSale.Create(self));
    CashBase.Name:= 'PosSummarised';
  end else begin
    CashBase := TCashSale(TPOSCashSale.Create(self));
    CashBase.Name:= 'POS';
  end;
  CashBase.LogChangesOnSave := not(Appenv.CompanyPrefs.DisableAuditTrialinQuickPOS);
  if Appenv.CompanyPrefs.DisableAuditTrialinQuickPOS then
    Self.Caption := 'Quick POS   - **** Audit Trial Disabled ****';

  inherited;
end;

procedure TfmQuickPOS.OnClearGridBedorePait(Grid: TwwDBGrid);
begin
  inherited;
  //edtPOSMemo.Clear;
end;

procedure TfmQuickPOS.tblDetailsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  IsToclearMemo := false;
end;

procedure TfmQuickPOS.tblDetailsCalcFields(DataSet: TDataSet);
begin
//  inherited;
  tbldetailslineDetails.asString := CashBase.lines.Productname +' : ' + FloattostrF(CashBase.lines.UOMQtyShipped, ffGeneral, 15,2) + ' - ' +
                                    CashBase.lines.UnitOfMeasure +'(' + Floattostrf(CashBase.lines.UOMMultiplier, ffGeneral, 15,2)+')'+chr(13)+chr(10)+
                                    CashBase.lines.ProductDescription;
end;

function TfmQuickPOS.SaveCashSale: Boolean;
begin
  result := Inherited;
  if result then begin
    if Cashbase.paymethod = PAY_CASH then begin
      OpenCashDrawer;
      edtPOSMemo.clear;
      edtPOSMemo.text := 'Cash Tendered : ' + FloatToStrf(Cashbase.totalAmountinc , ffCurrency , 15,2) + Chr(13)+chr(10) +
                '       Change               : ' + FloatToStrf(0, ffCurrency , 15,2) ;

    end;
    if IsUsingReceiptPrinter and Postill.ReceiptPrinterToggled then
      PrintReceipt(oRcptPrn , POSTill , TPosSale(Cashbase));
    if appenv.Companyprefs.POSPrintAfterSave then
      if POSMsg('Do You Wish To Print The Transaction To A4 Printer?' , bYesNo) = mrYes then
        PrintSaleinA4;
  end;
end;

function TfmQuickPOS.SaveTrans: Boolean;
begin
  result :=SavePOS(PAY_CASH   , False);
end;

function TfmQuickPOS.IsUsingReceiptPrinter: boolean;
begin
  Result := true;
  if AppEnv.CompanyPrefs.MultiTills then begin
        if POSTill.count >0 then begin
          if not POSTill.UseDefaultPrinter  then begin
            Result := (POSTill.ReceiptPrinterOn and not(POSTill.UseCashDrawerOnly));
          end else begin
            Result := (AppEnv.CompanyPrefs.ReceiptPrinterOn and not AppEnv.CompanyPrefs.POSUseCashDrawerOnly);
          end;
        end;
  end else begin
    Result := (AppEnv.CompanyPrefs.ReceiptPrinterOn and not AppEnv.CompanyPrefs.POSUseCashDrawerOnly);
  end;
end;
procedure TfmQuickPOS.SelectCustomer(grid: TWWDBGrid);
begin
  if not(assigned(grid.DataSource.DataSet)) or (grid.DataSource.DataSet.FindField('ClientId') = nil) or (grid.DataSource.DataSet.FindField('ClientId').AsInteger =0) then exit;
  Cashbase.customerId :=grid.DataSource.DataSet.FindField('ClientId').asInteger;
  Cashbase.PostDB;
end;

Procedure  TfmQuickPOS.Selectemployee(Grid: TwwDbGrid);
begin
    if assigned(grid.DataSource.DataSet) and (grid.DataSource.DataSet.FindField('EmployeeId') <> nil) then
      if grid.DataSource.DataSet.FindField('EmployeeId').AsInteger <> 0 then
        Cashbase.EmployeeId :=grid.DataSource.DataSet.FindField('EmployeeId').AsInteger
      else
         POSMsg('Invalid Employee ID' , bOk);
end;
procedure TfmQuickPOS.actcancelExecute(Sender: TObject);
begin
  inherited;
  if CancelnNew then   begin
    ShowCompletedpic;
    TransSaved := True;
  end;
end;

procedure TfmQuickPOS.actCashExecute      (Sender: TObject);begin  inherited;SavePOS(PAY_CASH   , False);end;
procedure TfmQuickPOS.actchequeExecute    (Sender: TObject);begin  inherited;SavePOS(CHEQUE     , False);end;
procedure TfmQuickPOS.actCreditCardExecute(Sender: TObject);begin  inherited;SavePOS(CREDITCARD , True );end;
procedure TfmQuickPOS.actEFTPosExecute    (Sender: TObject);begin  inherited;SavePOS(EFT        , True );end;

procedure TfmQuickPOS.actCustomerExecute(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TCustomerExpressListGUI' , nil , SelectCustomer)
end;


procedure TfmQuickPOS.actNewSaleExecute(Sender: TObject);
begin
  inherited;
  if not TransSaved then  begin
    if not SavePOS('', False, true) then exit;
  end else begin
    PaintTimerTimeout(fPaintTimer);
  end;
  btnnext.click;

end;

procedure TfmQuickPOS.actNoSaleExecute(Sender: TObject);
begin
  inherited;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnNoSale', Cashbase.EmployeeId) = 1 then begin
    btnCancel.click;
    //OpenCashDrawer;
  end else begin
    POSMsg('You don''t have rights to to a ''No Sale''' , bOk);
  end;
end;

procedure TfmQuickPOS.actPriceExecute(Sender: TObject);
begin
  inherited;
  if Cashbase.Lines.ProductId =0 then exit;
  if not IsNumber(Trim(edtPOSMemo.lines.text)) then begin
    POSMsg('Entered Value is not Valid Price' , bOk);
    Exit;
  end;

  Cashbase.Lines.linePriceInc:=strToFloat(Trim(edtPOSMemo.lines.text));
  Cashbase.Lines.PostDB;
  Cashbase.Lines.CalcLineTotals;
  Cashbase.DoCalcOrderTotals;
  edtPOSMemo.clear;

end;

procedure TfmQuickPOS.actPrintA4ReportExecute(Sender: TObject);
begin
  inherited;
  if not TransSaved then begin
    POSMsg('You have to Complete the Transaction to Print' , bOk);
    Exit;
  end;
  PrintSaleinA4;

end;

procedure TfmQuickPOS.actPrintA4ReportUpdate(Sender: TObject);
begin
  inherited;
  TDnmAction(Sender).Enabled := TransSaved;
end;

procedure TfmQuickPOS.actPrintReceiptExecute(Sender: TObject);
begin
  inherited;
  if not TransSaved then begin
    POSMsg('You have to Complete the Transaction to Print' , bOk);
    Exit;
  end;
  if IsUsingReceiptPrinter and Postill.ReceiptPrinterToggled then
      PrintReceipt(oRcptPrn , POSTill , Cashbase, '***** TRANSACTION NOT SAVED ******');
end;

procedure TfmQuickPOS.actProductListExecute(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , SelectProducts)
end;

procedure TfmQuickPOS.actQtyExecute(Sender: TObject);
begin
  inherited;
  if Cashbase.Lines.ProductId =0 then exit;
  if not IsNumber(Trim(edtPOSMemo.lines.text)) then begin
    POSMsg('Entered Value is not Valid Quantity' , bOk);
    Exit;
  end;
  CAshbase.InternalQuantityChange:= True;
  try
    Cashbase.Lines.UOMQtySold:=strToFloat(Trim(edtPOSMemo.lines.text));
    Cashbase.Lines.UOMQtyShipped := Cashbase.Lines.UOMQtySold;
  Cashbase.Lines.PostDB;
  finally
    CAshbase.InternalQuantityChange:= False;
  end;
  edtPOSMemo.clear;

end;

procedure TfmQuickPOS.actRefundExecute(Sender: TObject);
var
  sGblRef:String;
begin
  inherited;
  if not CancelnNew then Exit;

  MemoInput('Enter Receipt Number:', sGblRef, false);
  if sGblRef = '' then exit;

  if (char_length(sGblRef) <= 3) then begin
    POSMsg('You must enter a valid Receipt Number (eg DEF1057)' , bOk);
    Exit;
  end;

  if not LoadRefundSale(sGblRef) then begin
    POSMsg('Cannot locate this Sale' , bOk);
    CancelnNew;
  end;
end;

procedure TfmQuickPOS.actSalesPersonExecute(Sender: TObject);
var
  id:Integer;
  sPwd:String;
begin
  sPwd := '';
  ID:= 0;

  if AppEnv.CompanyPrefs.MultiSalesPerson AND AppEnv.CompanyPrefs.POSPassword  then begin
    if dlgPassword.Execute then
      sPwd := dlgPassword.InputResult;

    if not Empty(sPwd) then
      ID:= EmployeeIdforPassWord(sPwd , False);

    if id =0 then
      POSMsg('Invalid Password' , bOk)
    else Cashbase.EmployeeId := Id;
  end else begin
    OpenERPListFormSingleselectModal('TfrmEmployeeList' , Selectemployee , InitEmpList, false);
  end;

  end;
procedure TfmQuickPOS.actUOMExecute(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TUnitOfMeasureforProductGUI' , initUOMlist , SelectUOM)
end;

procedure TfmQuickPOS.actUOMUpdate(Sender: TObject);
begin
  inherited;
  TDNMAction(Sender).Enabled := not(TransSaved) and (CashBase.Lines.ProductID <>0);
end;

procedure TfmQuickPOS.InitEmpList(Sender: TObject);
begin
   if Sender is TfrmEmployeeList then begin
    TfrmEmployeeList(Sender).grpFilters.ItemIndex := 0;
    TfrmEmployeeList(Sender).grpFilters.enabled := False;
   end;
end;

procedure TfmQuickPOS.initUOMlist(Sender: TObject);
begin
   if Sender is TUnitOfMeasureforProductGUI then begin
    TUnitOfMeasureforProductGUI(Sender).ProductId := Cashbase.lines.ProductID;
   end;
end;

procedure TfmQuickPOS.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert ) and (Sender = CashBase) then begin
    CashBase.Customername := CLIENT_CASH;
    Cashbase.PayMethod := PAY_CASH;
    Cashbase.tillId :=TillID;
    Cashbase.SaleClassname := GetClassName(tcDatautils.GetTillClassID(TillID));
  end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value) ) and (Sender = CashBase.Lines) then begin
    Setcontrolfocus( edtPOSMemo);
  end;
end;

procedure TfmQuickPOS.DoFormSize(ChangeSize: Boolean);
begin
  //inherited;
  Self.WindowState := wsMaximized;
  SizeMode := 'M';
end;

function TfmQuickPOS.SavePOS(PayType:String; isCC :Boolean ;Addingnew:boolean=false):boolean ;
var
  t:TdateTime;
begin
  t:= now;
  try
      Result := False;
      DisableForm;
      try
        if PayType <> '' then begin
          TPaymentMethod.AddNewifnotExsist(PayType , isCC , Cashbase.connection.connection);
          Cashbase.PayMethod := PayType;
        end;
        if SaveCashSale then begin
          CommitAndNotify;
          CashBase.Dirty := false;
          if not Addingnew then begin
            TransSaved := True;
            ShowCompletedpic;
          end;
          Result := True;

        end;
      finally
        EnableForm;
      end;
  finally
      lbldone.Caption := inttostr(SecondsBetween(now(),t));
      lbldone.Refresh;
  end;
end;

procedure TfmQuickPOS.btnDeleteClick(Sender: TObject);
begin
//  inherited;
   if Cashbase.Lines.dataset.State in [dsInsert] then
     Cashbase.Lines.CancelDb
   else
     Cashbase.Lines.Delete;
   Cashbase.DoCalcOrderTotals;
end;



procedure TfmQuickPOS.btnNumPadClick(Sender: TObject);
var
  btn: TDNMSpeedButton;
begin
  inherited;
  if Sender is TDNMSpeedButton then begin
  try
    if IsToclearMemo then begin
      edtPOSMemo.Clear;
      IsToclearMemo := false;
    end;
    btn := TDNMSpeedButton(Sender);
    if btn = btnNumBS then begin
      POSKeyDown(word(VK_BACK), [ssMiddle]); // used ssMiddle cuz there is no ssNone ???
    end else if btn = btnNumDot then begin
      POSKeyDown(word(VK_DECIMAL), [ssMiddle]);
    end else if btn = btnNum1 then begin
      POSKeyDown(word('1'), [ssMiddle]);
    end else if btn = btnNum2 then begin
      POSKeyDown(word('2'), [ssMiddle]);
    end else if btn = btnNum3 then begin
      POSKeyDown(word('3'), [ssMiddle]);
    end else if btn = btnNum4 then begin
      POSKeyDown(word('4'), [ssMiddle]);
    end else if btn = btnNum5 then begin
      POSKeyDown(word('5'), [ssMiddle]);
    end else if btn = btnNum6 then begin
      POSKeyDown(word('6'), [ssMiddle]);
    end else if btn = btnNum7 then begin
      POSKeyDown(word('7'), [ssMiddle]);
    end else if btn = btnNum8 then begin
      POSKeyDown(word('8'), [ssMiddle]);
    end else if btn = btnNum9 then begin
      POSKeyDown(word('9'), [ssMiddle]);
    end else if btn = btnNum0 then begin
      POSKeyDown(word('0'), [ssMiddle]);
    end;
    finally
        SetControlFocus(grdTransactions);
    end;
  end;

end;

procedure TfmQuickPOS.PrintSaleinA4;
var
  s:String;
  templName:String;
begin
      s:= companyInfoSQL+
        ' ~|||~{Details} SELECT S.*, SL.* '+
        ' FROM `tblsales` AS `S` '+
        ' Inner Join `tblsaleslines` AS `SL` ON `S`.`SaleID` = `SL`.`SaleID` '+
        ' left join tblrelatedparts RP on RP.ProductID = SL.productId and RP.ParentID = SL.RelatedParentProductID ' +
        ' where Sl.ProductName <> ' +quotedStr(PART_ROUNDING) +' and   S.saleid ='+IntToStr(CashBase.SaleId) + '  and (ifnull(RP.RelatedID,0)=0 or RP.IsHidden ="F")'+
        '~|||~SELECT C.CommentsID,C.Comments  FROM tblComments C  inner join tbltranscomments TC on C.CommentsID = TC.CommentID  Where TC.Transtype ="POS" and TC.TransId ='+IntToStr(CashBase.SaleId) ;
      if AppEnv.CompanyPrefs.POSSummarise then begin
        s:= replacestr(s, '`tblsales`' , 'tblsales_POS ');
        s:= replacestr(s, '`tblsaleslines`' , 'tblsaleslines_POS ');
      end;

      fbReportSQLSupplied := true;
      try
       templName := TillA4templateID(Cashbase.TillID);
       if templName = '' then templName:='POSSale';
       PrintTemplateReport(templName,s , not(devmode) , 1);
      finally
        fbReportSQLSupplied := False;
      end;
end;

function TfmQuickPOS.POSMsg(Msg:String ; PosMsgButtons : TPosMsgButtons):TModalResult;
var
  CustomDialog : TfrmPOSDialog;
begin
    CustomDialog := TfrmPOSDialog.Create(nil);
    try
      CustomDialog.Position := poScreenCenter;
      CustomDialog.DialogMsg := Msg;
      CustomDialog.PosMsgButtons := PosMsgButtons;
      Result := CustomDialog.ShowModal
    finally
      FreeandNil(CustomDialog);
    end;
end;

Function TfmQuickPOS.CancelnNew:Boolean;
begin
  REsult := false;
  if CashBase.Dirty then begin
      if POSMsg('Do you wish to Cancel?' , bYesNo) = mrYes then begin
          RollbackTransaction;
          CashBase.Dirty := false;
          edtPOSMemo.clear;
          btnNext.Click;
          Result := true;
      end else begin
        Exit;
      end;
  end else begin
    Result := True;
  end;
end;
function TfmQuickPOS.LoadRefundSale(const SalesGlobalRef:String): boolean;
var
  strSQL :String;
  Qry :TERPQuery;
begin
  result:= false;
  strSQL := 'SELECT S.SaleID , S.ClientId, S.ISInvoice, S.iscashsale, S.isrefund, S.issalesorder, S.isquote,   '+
                    ' SL.SaleLineID, SL.ProductID , SL.Product_Description, SL.LinePrice,SL.QtySold,SL.UnitOfMeasureID , SL.UnitofMeasureMultiplier ,'+
                  ' SL.shipped - ifnull((Select 0 - Sum(Shipped) refunded from tblsaleslines inner join tblsales using (SaleID) where RefundedSalesLineID= SL.saleLineID and converted ="F"),0) as  qtytorefund  '+
                  ' FROM tblSales  S inner join tblSalesLines  SL  on S.saleId = SL.saleId WHERE  S.Globalref = ' + QuotedStr(SalesGlobalRef)+' having qtytorefund >0';

  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.active then Qry.Close;
    Qry.SQL.Text :=strSQL;
    Qry.open;
    if Qry.recordcount > 0 then begin
           if Qry.fieldbyname('issalesorder').asBoolean then POSMsg('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Sales Order'' and cannot be refunded' , bOk)
      else if Qry.fieldbyname('isrefund').asBoolean     then POSMsg('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Refund''      and cannot be refunded' , bOk)
      else if Qry.fieldbyname('isquote').asBoolean      then POSMsg('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Quote''       and cannot be refunded' , bOk)
      else if not(Qry.fieldbyname('ISInvoice').asBoolean) and not(Qry.fieldbyname('iscashsale').asBoolean) then POSMsg('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is not an ''Invoice'' or ''Cash sale'' and cannot be refunded' , bOk)
      else begin
          Cashbase.clientId := Qry.Fieldbyname('clientID').AsInteger;
          Cashbase.PostDB;
          Qry.First;
          while Qry.Eof = False do begin
              Cashbase.Lines.New;
              Cashbase.Lines.ProductId            := Qry.FieldByName('ProductId').AsInteger;
              Cashbase.Lines.Product_Description  := Qry.FieldByName('Product_Description').asString;
              Cashbase.Lines.LinePrice            := Qry.FieldByName('LinePrice').asfloat;
              Cashbase.Lines.UnitOfMeasureID      := Qry.FieldByName('UnitOfMeasureID').asInteger;
              Cashbase.Lines.UOMMultiplier        := Qry.FieldByName('UnitofMeasureMultiplier').asfloat;
              Cashbase.Lines.UOMQtySold           := 0-Qry.FieldByName('qtytorefund').asfloat;
              Cashbase.Lines.UOMQtyShipped        := 0-Qry.FieldByName('qtytorefund').asfloat;
              Cashbase.Lines.RefundedSalesLineID  := Qry.FieldByName('SaleLineID').AsInteger;
              Cashbase.Lines.PostDb;
              Result := True;
              Qry.Next;
          end;
      end;
    end;
    if result then
      edtPOSMemo.Text := 'Refund Receipt:   ' + SalesGlobalRef;
  finally
        DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TfmQuickPOS.SelectProducts(grid: TWWDBGrid);
var
  i:Integer;
begin
  if not(assigned(grid.DataSource.DataSet)) or (grid.DataSource.DataSet.FindField('PartsId') = nil) then exit;

  showProgressbar(WAITMSG, grid.Selected.Count);
  try
    if grid.SelectedList.Count > 0 then begin
      for i := 0 to grid.SelectedList.Count - 1 do begin
        grid.datasource.dataset.GoToBookmark(grid.SelectedList.Items[i]);
        if grid.DataSource.DataSet.FindField('PartsId').AsInteger <> 0 then begin
          Cashbase.Lines.New;
          Cashbase.Lines.ProductId :=grid.DataSource.DataSet.FindField('PartsId').AsInteger;
          Cashbase.lines.UOMQtySold := 1;
          Cashbase.lines.UOMQtyShipped := 1;
          Cashbase.Lines.PostDB;
        end;
        stepProgressbar;
      end;
      edtPOSmemo.clear;
      edtPOSmemo.Text := Cashbase.Lines.ProductDescription +chr(13)+chr(10)+
                         FloattoStrF(Cashbase.Lines.LinePriceinc , ffCurrency, 15,2);
      IsToclearMemo := True;
    end;
  finally
    HideProgressbar;
  end;


end;

procedure TfmQuickPOS.SelectUOM(grid: TWWDBGrid);
begin
  if not(assigned(grid.DataSource.DataSet)) or (grid.DataSource.DataSet.FindField('UnitID') = nil) or (grid.DataSource.DataSet.FindField('UnitID').AsInteger =0) then exit;
  Cashbase.Lines.UnitOfMeasureID :=grid.DataSource.DataSet.FindField('UnitID').asInteger;
  Cashbase.Lines.PostDB;
end;

procedure TfmQuickPOS.showCompletedpic;
begin
  grdTransactions.OnBeforePaint :=GridBeforePaint;
  grdTransactions.PaintOptions.AlternatingRowColor := clNone;
end;

(*procedure TfmQuickPOS.beforeshowProductList(Sender:TObject);
begin
   if not(Sender is TProductListExpressGUI) then exit;
   TProductListExpressGUI(Sender).OnGridDataSelect := SelectProducts;
   TProductListExpressGUI(Sender).grpfilters.ItemIndex := 0;
   TProductListExpressGUI(Sender).grpfilters.enabled:= False;
   TProductListExpressGUI(Sender).GrpfilterSupplied := TRue;
end;*)


procedure TfmQuickPOS.PaintTimerTimeout(Sender: TObject);
begin
  inherited;
  grdTransactions.PaintOptions.AlternatingRowColor := 13041663
end;

procedure TfmQuickPOS.POSKeyDown(const wKey: word; const Shift: TShiftState);
begin
  AddDigitToViewer(char(wKey))
end;

function TfmQuickPOS.PosTill: TPosTillDetails;
begin
  if fPosTill = nil then begin
    fPosTill:= TPosTillDetails.CreateWithNewConn(Self);
    fPosTill.Load(tillID);
  end;
  if fPosTill.ID <> tillId then
    fPosTill.Load(tillID);
  Result := fPosTill;
end;


function TfmQuickPOS.GetTillForPOS: integer;
begin
  if AppEnv.CompanyPrefs.MultiTills then begin
    Result := GetAssignedTillID(getPCName());
    if Result = 0 then begin
      with TPOSGetTillPopUp.Create(Self) do try
          ShowModal;
          Result := fiTillID;
          if Result <= 0 then begin
            Result := DEFAULT_TILL;
          end;
        finally
          Free;
        end;
    end;
  end else begin
    Result := DEFAULT_TILL;
  end;
end;
procedure TfmQuickPOS.OpenCashDrawer;
begin
  if bOkToOpenCashDrawer then begin
    if POSTill.IsPrintSpooler or (POSTill.EnableKickRemoteDrawer and POSTill.UsePrintSpooler)   then begin
      POSTill.KickRemoteDrawer := True;
      POSTill.PostDB;
    end else begin
      oCashDrawer.OpenCashDrawer;
    end;
  end;
end;
Function  TfmQuickPOS.MemoInput(const memoCaption: String; var sResult: String; Required: boolean = false):Boolean;
begin
    Result := False;
    with TPOSChequePopUp.Create(Self) do try
        TitleLabel.Caption    := memoCaption;
        OKBtn.Default         := false;
        if Required then
          CancelBtn.Enabled:= false;
        if ShowModal = mrOk then begin
          sResult := edtInput1.Text;
          result := true;
        end;
    finally
        Free;
    end;
end;
initialization
  RegisterClass(TfmQuickPOS);


end.
