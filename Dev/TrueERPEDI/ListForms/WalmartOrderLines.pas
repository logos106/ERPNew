unit WalmartOrderLines;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WalmartListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, AdvCircularProgress, ComCtrls,
  AdvProgr, HTMLUn2, HtmlView , utBaseCoreService;

type
  TWalmartOrderLinesGUI = class(TWalmartListBaseGUI)
    qryMainOrderId: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainpurchaseOrderId: TWideStringField;
    qryMaincustomerOrderId: TWideStringField;
    qryMaincustomerEmailId: TWideStringField;
    qryMainorderDate: TDateTimeField;
    qryMainBuyerId: TIntegerField;
    qryMainMart: TWideStringField;
    qryMainIsGuest: TWideStringField;
    qryMainShippingphone: TWideStringField;
    qryMainestimatedDeliveryDate: TDateTimeField;
    qryMainestimatedShipDate: TDateTimeField;
    qryMainPostalAddressName: TWideStringField;
    qryMainPostalAddressAddress1: TWideStringField;
    qryMainPostalAddressAddress2: TWideStringField;
    qryMainPostalAddressCity: TWideStringField;
    qryMainPostalAddressstate: TWideStringField;
    qryMainPostalAddressPostcode: TWideStringField;
    qryMainPostalAddressCountry: TWideStringField;
    qryMainPostalAddressAddresstype: TWideStringField;
    qryMainERPSalesRef: TWideStringField;
    qryMainOrderLineId: TIntegerField;
    qryMainLinenumber: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainsku: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainstatusDate: TDateTimeField;
    qryMainoriginalCarrierMethod: TWideStringField;
    qryMainValidateOrderStatusCode: TIntegerField;
    qryMainorderstatus: TWideStringField;
    btnSynchOrders: TDNMSpeedButton;
    btnAcknowledgeOrders: TDNMSpeedButton;
    btnCancelOrders: TDNMSpeedButton;
    qryMainInvoiceref: TWideStringField;
    btnShipOrders: TDNMSpeedButton;
    chkshowSynchLog: TCheckBox;
    qryMainID: TIntegerField;
    qryMainPreviousStatuses: TWideMemoField;
    qryMainIsRefunded: TWideStringField;
    qryMainRefundChargeID: TIntegerField;
    qryMainRefundID: TIntegerField;
    qryMainRefundLineID: TIntegerField;
    qryMainRefundReason: TWideStringField;
    qryMainRefundChargetype: TWideStringField;
    qryMainRefundChargeName: TWideStringField;
    qryMainRefundChargeAmount: TFloatField;
    qryMainRefundChargeCurrency: TWideStringField;
    qryMainRefundtaxName: TWideStringField;
    qryMainRefundTaxCurrency: TWideStringField;
    qryMainRefundTaxAmount: TFloatField;
    qryMainERPRefundRef: TWideStringField;
    btnMakeERPOrders: TDNMSpeedButton;
    btnrefund: TDNMSpeedButton;
    procedure btnSynchOrdersClick(Sender: TObject);
    procedure btnAcknowledgeOrdersClick(Sender: TObject);
    procedure btnMakeERPOrdersClick(Sender: TObject);
    procedure btnCancelOrdersClick(Sender: TObject);
    procedure btnShipOrdersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    //procedure tmrcheckOrderstrackTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure chkshowSynchLogClick(Sender: TObject);
    //procedure tmrAutocheckforOrdersinListTimer(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure btnrefundClick(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
  private
    fdSearch:TDateTime;
    fsTablename :String;
    procedure DocheckforOrders;
    //procedure initTimers(Doenable:boolean);
    procedure Populatedata;
    procedure openSOShipmentDEtails(Sender: TObject);
    procedure DoAutoShipmentDetails(Sender: TObject);
    Procedure RefreshQuery(const OrderID:Integer); Overload;
    Procedure UpdateWalmartproductQty;
    Procedure OnwalmartOrderReturn(Sender :TObject);
    function SynchTransactions: boolean;

  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    Procedure DoEDIAutocheck(Sender:TObject);Override;
    Function Autocheck :boolean; Override;
    Function ModuleCaption :String;Override;
    Function CheckOrdersInterval:Integer;Override;
    procedure StopSynch;Overload;
    Function MakeCoreServiceObj :TBaseCoreService; Override;
    Function HasEDICredentials :Boolean ; Override;
    Procedure initCodeEDI;Override;
  public
    Procedure RefreshQuery;Overload;Override;
    procedure LoginList(const Value: String; const ShowinList :Boolean = True);Override;
  end;

implementation

uses CommonLib, CK_DLL_WalmartLib, LogLib, Walmart_PO_Lib, tcConst, BusobjWalmartOrders,
  ShellAPI,  ck_JsonObject, BusobjProduct , CkString, MySQLConst, CommonDbLib,
  DbSharedObjectsObj, BusObjBase, Walmart_Cancel_Lib, Walmart_Shipment_Lib,
  Walmart_Inventory_Lib, BusObjSales, tcDataUtils, AppEnvironment,
  CommonFormLib, frmSalesOrder, CK_DLL_Const, BusobjCash, InventoryFeed,
  SystemLib, utWalmartService, ErpSynchWalmart, CoreEDILib;
const
  ipnUnSelectConverted = 1;
        ipnDoMakeERPSOForWalmart = 2;
  ipnDoAcknowldgeOrder = 3;
      ipnDoCancelOrder = 4;
        ipnDoShipOrder = 5;

{$R *.dfm}

{ TWalmartOrderLinesGUI }


procedure TWalmartOrderLinesGUI.btnAcknowledgeOrdersClick(Sender: TObject);
begin
  inherited;
  initTimers(False);
  try
    if SelectedRecords =0 then exit;
    if MessageDlgXP_vista('This will Acknowledge Selected Order.  Do you Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

    AcknowledgeWO(CurRecPurchaseOrderID(True));
    RefreshQuery(qrymainorderId.AsInteger);
  finally
    initTimers(True);
  end;
end;

procedure TWalmartOrderLinesGUI.btnCancelOrdersClick(Sender: TObject);
var
  fs:String;
  cancelOption : Word;
  Conn : TMyDAcDataconnection;
  errMsg:String;

  Function CancellationReason :String;
  begin
         if cancelOption = 100 then result := CUSTOMER_REQUESTED_SELLER_TO_CANCEL
    else if cancelOption = 101 then result := SELLER_CANCEL_OUT_OF_STOCK
    else if cancelOption = 102 then result := SELLER_CANCEL_CUSTOMER_DUPLICATE_ORDER
    else if cancelOption = 103 then result := SELLER_CANCEL_CUSTOMER_CHANGE_ORDER
    else if cancelOption = 104 then result := SELLER_CANCEL_CUSTOMER_INCORRECT_ADDRESS
    else if cancelOption = 105 then result := SELLER_CANCEL_FRAUD_STOP_SHIPMENT
    else if cancelOption = 106 then result := SELLER_CANCEL_PRICING_ERROR
    else result := WalmartOrderStatus_Cancelled;
  end;
begin
  inherited;
  initTimers(False);
  try
    if qrymainorderstatus.asString ='Cancelled' then begin
      MessageDlgXP_Vista('This Order is Already Cancelled. It is not Possible to Cancel Again', mtWarning, [mbOK], 0);
      Exit;
    end;
    cancelOption := MessageDlgXP_vista('This will Cancel Selected Order ('+inttostr(WalmartOrderLinecount(QrymainOrderId.asInteger))+' Products).  '+
                                       'Please Choose Cancellation Reason.', mtConfirmation, [mbcancel], 0 , nil , '' , '' , False, nil ,
                                       {100} sCUSTOMER_REQUESTED_SELLER_TO_CANCEL       +','+
                                       {101} sSELLER_CANCEL_OUT_OF_STOCK                +','+
                                       {102} sSELLER_CANCEL_CUSTOMER_DUPLICATE_ORDER    +','+
                                       {103} sSELLER_CANCEL_CUSTOMER_CHANGE_ORDER       +','+
                                       {104} sSELLER_CANCEL_CUSTOMER_INCORRECT_ADDRESS  +','+
                                       {105} sSELLER_CANCEL_FRAUD_STOP_SHIPMENT         +','+
                                       {106} sSELLER_CANCEL_PRICING_ERROR );
    if cancelOption = mrCancel then exit;


      Conn:= TMyDAcDataconnection.Create(Self);
      try
        Conn.Connection := GetNewMyDacConnection(self);
        Conn.begintransaction;
        try
            with WalmartorderToCancelXML(QrymainOrderId.asInteger, nil, CancellationReason , conn) do try
              if devmode then begin
                  fs:='i:\temp\to be deleted\'+inttostr(QrymainOrderId.asInteger)+'.xml';
                  clog(XML, fs);
                  ShellExecute(0, nil, 'explorer.exe', PChar(fs), nil,  SW_SHOWNORMAL);
              end;
              if CancelWalmartOrder(qryMainpurchaseOrderId.AsString,  XML , errMsg , LoginList) then begin
                  WalmartOrderToUpdateInvXML(QrymainOrderId.asInteger,'', conn , LoginList );
                  Conn.CommitTransaction;
                  Exit;
              end;

              Conn.RollbackTransaction;
            finally
              OpenLogFile;
            end;
        Except
          on E:Exception do begin
            Conn.RollbackTransaction;
          end;
        end;
      finally
        Freeandnil(Conn);
      end;
  finally
    initTimers(true);
  end;
end;

procedure TWalmartOrderLinesGUI.btnMakeERPOrdersClick(Sender: TObject);
begin
  inherited;
  initTimers(False);
  try
    if qryMainERPSalesRef.asString <> '' then begin
      if MessageDlgXP_Vista('ERP Sales Record is already Created. Do you want to See the ERP Sales Record?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        OpenERPForm('TSalesOrderGUI' , TSaleSOrder.IDToggle(qryMainERPSalesRef.asString));
      end;
      Exit;
    end;
    if qryMainorderstatus.asString = WalmartOrderStatus_Cancelled then begin
      MessageDlgXP_Vista('This is a Cancelled Order.  It is not Possible to Make ERP Sale for this.', mtWarning, [mbOK], 0);
      Exit;
    end;

    if MessageDlgXP_vista('This will Create an ERP Sales order for Selected Order.  Do you Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

    if MakeERPSOForWalmart(CurRecPurchaseOrderID(False)) then begin
      RefreshQuery(qrymainorderId.AsInteger);
      OpenERPForm('TSalesOrderGUI' , TSaleSOrder.IDToggle(qryMainERPSalesRef.asString) ,openSOShipmentDEtails );
    end;
  finally
    initTimers(True);
  end;
end;
procedure TWalmartOrderLinesGUI.openSOShipmentDEtails(Sender: TObject);
begin
  if sender is  TSalesOrderGUI then
    if TSalesOrderGUI(Sender).KeyID>0 then
      TSalesOrderGUI(Sender).DoShipmentafterformshow;
end;
procedure TWalmartOrderLinesGUI.btnrefundClick(Sender: TObject);
begin
  inherited;
  initTimers(False);
  try
    if qryMainERPRefundRef.asString <> '' then begin
      if MessageDlgXP_Vista('ERP Refund Record is already Created. Do you want to See the ERP Refund  Record?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        OpenERPForm('TRefundGUI' , TRefundSale.IDToggle(qryMainERPRefundRef.asString));
      end;
      Exit;
    end;
    if qryMainInvoiceref.asString ='' then begin
      MessageDlgXP_Vista('This Order is not Invoiced Yet.  It is not Possible to Refund an Uninvoiced sale', mtWarning, [mbOK], 0);
      Exit;
    end;
    if not(qryMainIsrefunded.asBoolean) then begin
      MessageDlgXP_Vista('This is not Refunded at Walmart, Cant Refund in ERP until Walmart Creates the Refund.', mtWarning, [mbOK], 0);
      Exit;
    end;

    if MessageDlgXP_vista('This will Create an ERP Refund order for Selected Order.  Do you Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

    if MakeERPREfund(qryMainRefundLineID.asInteger ) then begin
      RefreshQuery(qrymainorderId.AsInteger);
      OpenERPForm('TRefundGUI' , TRefundSale.IDToggle(qryMainERPRefundRef.asString) );
    end;
  finally
    initTimers(True);
  end;

end;

procedure TWalmartOrderLinesGUI.DoAutoShipmentDetails(Sender:TObject);
begin
  if sender is  TSalesOrderGUI then
    if TSalesOrderGUI(Sender).KeyID>0 then
      TSalesOrderGUI(Sender).DoAutoShipmentafterformshow;
      //TSalesOrderGUI(Sender).btnShipment.Click;
      //TSalesOrderGUI(Sender).btnShipmentDetails.Click;
end;
procedure TWalmartOrderLinesGUI.btnShipOrdersClick(Sender: TObject);
var
  Conn: TMyDAcDataconnection;
  fs, errMsg:String;
//  st :TStringList;
//  fsFilter:String;
begin
  inherited;
  initTimers(False);
  try
    if qryMainorderstatus.asString = WalmartOrderStatus_Shipped then begin
      MessageDlgXP_vista('This is a Shipped Order.  It is not Possible to Ship This order', mtWarning, [mbOK], 0);
      Exit;
    end;
    if qryMainorderstatus.asString = WalmartOrderStatus_Cancelled then begin
      MessageDlgXP_vista('This is a Cancelled Order.  It is not Possible to Ship This order', mtWarning, [mbOK], 0);
      Exit;
    end;
    if QrymainERPSalesref.asString ='' then begin
      ListTimerMsg('Making ERP Order...');
      try
          if not MakeERPSOForWalmart(CurRecPurchaseOrderID(False)) then begin
            MessageDlgXP_vista('Failed to Create Order in ERP.  It is not Possible to Ship the Order', mtWarning, [mbOK], 0);
            Exit;
          end else begin
            RefreshQuery(qrymainorderId.AsInteger);
            OpenERPForm('TSalesOrderGUI' , TSaleSOrder.IDToggle(qryMainERPSalesRef.asString) ,DoAutoShipmentDetails );
            Exit;
          end;
      finally
        HidetimerMsg;
      end;
    end;
    if WalmartOrderhasshipmentinfo(qrymainorderID.AsInteger,conn) = False then begin
        if MessageDlgXP_vista('Missing Shipping Details.  It is not Possible to Ship the order without Shiping Details.'+NL+NL+
                               'Please Fill in the Shipping Details for ERP Order # '+ inttostr(TSalesOrder.IDToggle(QrymainERPSalesref.asString)), mtWarning, [mbOK], 0 , nil, '', '' , FAlse, nil , 'Open Sales Order' ) = 100 then
          OpenERPForm('TSalesOrderGUI' , TSaleSOrder.IDToggle(qryMainERPSalesRef.asString) ,openSOShipmentDEtails);
        Exit;
    end;

    if MessageDlgXP_vista('This will Ship Selected Order.  Do you Wish to Continue?' ,mtconfirmation, [mbyes,mbno], 0) =mrno then exit;

      Conn:= TMyDAcDataconnection.Create(Self);
      try
        Conn.Connection := GetNewMyDacConnection(self);
        Conn.begintransaction;
        try
            ListTimerMsg('Shipping the Order and Invoicing...');
            ProcessingCursor(true);
            try
                with WalmartorderToShiplXML(qrymainorderID.AsInteger, nil, '',  conn) do try
                  if devmode then begin
                      fs:='i:\temp\to be deleted\'+inttostr(qrymainorderID.AsInteger)+'.xml';
                      clog(XML, fs);
                      ShellExecute(0, nil, 'explorer.exe', PChar(fs), nil,  SW_SHOWNORMAL);
                  end;
                  if ShipWalmartOrder(PurchaseOrderID(qrymainorderID.AsInteger) ,  XML , errMsg , LoginList) then begin
                    ListTimerMsg('Shipped  Order # ' + inttostr(qrymainorderID.AsInteger));
                    LoginList('Shipped  Order # ' + inttostr(qrymainorderID.AsInteger));
                  end else begin
                    Conn.RollbackTransaction;
                    exit;
                  end;
                finally
                  //free;
                end;
                TSalesOrder.MakeInvoice(WOIdtoSaleID(qrymainorderID.AsInteger) , Conn);
                ListTimerMsg('Shipped and Invoiced Order # ' + inttostr(qrymainorderID.AsInteger));
                LoginList('Shipped and Invoiced Order # ' + inttostr(qrymainorderID.AsInteger));
                Conn.CommitTransaction;
                RefreshQuery(qrymainorderID.AsInteger);
            finally
              HidetimerMsg;
              ProcessingCursor(False);
            end;
        Except
          on E:Exception do begin
            Conn.RollbackTransaction;
          end;
        end;
      finally
        Freeandnil(Conn);
      end;
  finally
    initTimers(true);
  end;
end;

procedure TWalmartOrderLinesGUI.btnSynchOrdersClick(Sender: TObject);
begin
  showProgressbar(WAITMSG, 10);
  try
    ListTimerMsg('Checking for Orders at Walmart');
    DocheckforOrders;
  finally
    HideProgressbar;
  end;
end;
procedure TWalmartOrderLinesGUI.chkshowSynchLogClick(Sender: TObject);
begin
  inherited;
  LoginList('');
end;

procedure TWalmartOrderLinesGUI.DocheckforOrders;
begin
  InitTimers(false);
  if SameText(btnSynchOrders.Caption, fsSynchCaption) then begin
    if not InitializeCoreEDIObj then exit;
    btnSynchOrders.Caption := 'Stop Synch';
    SynchTransactions;
    StopSynch;
  end else begin
    StopSynch;
  end;

(*var
  sOrders:String;
  errMsg:String;
  fsnextcursor:String;
begin
  inherited;
  DisableForm;
  try
    fsnextcursor:='';


          ListTimerMsg('Synchronizing with Walmart. Please Wait......');
          try
            //fsIteraterecordsMsgs := '';
            showProgressbar('Synchronizing with Walmart', 10);
            try
                stepProgressbar('Checking for New Walmart Orders');
                Processingcursor(True);
                try
                  {New Orders}
                        LoginList('Synchronizing with Walmart : ' +FormatDatetime('hh:nn AM/PM', now ));

                        repeat
                          sOrders:=GetWallMartOrders(0 , errMsg, LoginList ,fsnextcursor );
                          if sorders = '' then break;
                          if errmsg <> '' then begin
                            MessageDlgXP_vista('Walmart Orders synch Caused Error - ' + Errmsg, mtWarning, [mbOK], 0);
                            Exit;
                          end;
                          stepProgressbar;
                          SetWalmartOrder(sOrders , AcknowledgeWO , fsnextcursor);
                        until fsnextcursor = '';

                        fsnextcursor := '';
                        repeat
                          sOrders:=GetWallMartReturns(0 , errMsg, LoginList ,fsnextcursor );
                          if sorders = '' then break;
                          if errmsg <> '' then begin
                            MessageDlgXP_vista('Walmart Orders synch Caused Error - ' + Errmsg, mtWarning, [mbOK], 0);
                            Exit;
                          end;
                          stepProgressbar;
                          SetWalmartReturns(Self, sOrders ,OnwalmartOrderReturn,  fsnextcursor);
                        until fsnextcursor = '';


                  if Appenv.companyprefs.WALMART_AutoUpdateProductQty then UpdateWalmartproductQty;
                  RefreshQuery;
                finally
                  Processingcursor(False);
                  LoginList('=========================================');
                end;
            finally
              HideProgressbar;
            end;




          finally
            hideTimerMsg;
          end;



  finally
    EnableForm;
  end;*)
end;


procedure TWalmartOrderLinesGUI.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('WO');
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from ' + fsTablename );
  Qrymain.sql.add('order by orderDate desc, PurchaseOrderID, linenumber ');
  inherited;
  fdSearch := 0;

  lblListHint.caption := 'This is a List of Walmart Orders.';
  if Appenv.companyprefs.WALMART_AutocheckforOrdersinList then
    lblListHint.caption := lblListHint.caption + '  The List Automatically Synchronized with Walmart every 10 Minutes.';
  lblListHint.visible := True;
  lblListHint.refresh;
  fsSynchCaption:=btnSynchOrders.caption;
end;

procedure TWalmartOrderLinesGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TWalmartOrderLinesGUI.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := true;
end;

procedure TWalmartOrderLinesGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(Activefield.Fieldname ,qryMainERPSalesRef.Fieldname) and (qryMainERPSalesRef.asString <> '') then begin
      OpenERPForm('TSalesOrderGUI' , TSaleSOrder.IDToggle(qryMainERPSalesRef.asString));
      Exit;
  end;
  if sametext(Activefield.Fieldname ,qryMainInvoiceref.Fieldname) and (qryMainInvoiceref.asString <> '') then begin
      OpenERPForm('TInvoiceGUI' , TInvoice.IDToggle(qryMainInvoiceref.asString));
      Exit;
  end;
  if sametext(Activefield.Fieldname ,qryMainERPRefundRef.Fieldname) and (qryMainERPRefundRef.asString <> '') then begin
      OpenERPForm('TRefundGUI' , TRefundsale.IDToggle(qryMainERPRefundRef.asString));
      Exit;
  end;

  inherited;
end;

procedure TWalmartOrderLinesGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(qryMainorderstatus.fieldname  , [WalmartOrderStatus_Acknowledged,WalmartOrderStatus_Cancelled,WalmartOrderStatus_ERPSOCreated, WalmartOrderStatus_Shipped ,WalmartOrderStatus_Invoiced, '']);
  inherited;
end;

function TWalmartOrderLinesGUI.HasEDICredentials: Boolean;
begin
    Result := Appenv.companyprefs.HasWalmartCredentials;
end;

procedure TWalmartOrderLinesGUI.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
 if sametext(src, 'MakeERPOrders') then begin
    btnMakeERPOrders.click;
    Exit;
 end;
  if sametext(src, 'WalmartSalesOrders') then begin
    OpenERPListForm('TWalmartSalesOrdersGUI');
    Exit;
 end;
end;

procedure TWalmartOrderLinesGUI.initCodeEDI;
begin
  inherited;

  //CoreEDI.CoreEDIServer := 'localhost:8445';
end;

procedure TWalmartOrderLinesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  //grdmain.PaintOptions.AlternatingRowColor := clNone;
  if GuiPrefs.Node.Exists('Options.showSynchLog') then
      chkshowSynchLog.checked :=  GuiPrefs.Node['Options.showSynchLog'].asBoolean;
end;

procedure TWalmartOrderLinesGUI.RefreshQuery(const OrderID: Integer);
begin
            RefreshQuery;
            if qrymain.Locate('OrderId' , OrderID, []) then Exit;
            if (grpfilters.Itemindex <> grpfilters.Items.count-1) then begin
              grpfilters.Itemindex := grpfilters.items.count-1;
              if qrymain.Locate('OrderId' , OrderID, []) then Exit;
            end;
            MessageDlgXP_vista('Failed to Locate the Order # '+ inttostr(OrderID), mtWarning, [mbOK], 0);
end;
procedure TWalmartOrderLinesGUI.RefreshQuery;
begin
  //InitDateFromnDateto;
  Processingcursor(True);
  try
    Populatedata;
    inherited;
  finally
    Processingcursor(False);
  end;
end;
procedure TWalmartOrderLinesGUI.Populatedata;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.add('Drop TABLE if exists '+ fsTablename +';');
    SQL.add('CREATE TABLE '+ fsTablename +' ( ' +
	                        ' ID        INT(11) NOT NULL AUTO_INCREMENT, ' +
	                        ' OrderId   INT(11) NOT NULL DEFAULT 0 , ' +
	                        ' GlobalRef       VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' EmployeeName    VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' purchaseOrderId VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' customerOrderId VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' customerEmailId VARCHAR(255) NULL DEFAULT "", ' +
	                        ' orderDate       DATETIME NULL DEFAULT NULL, ' +
	                        ' BuyerId         INT(11) NULL DEFAULT NULL, ' +
	                        ' Mart            VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' IsGuest         ENUM("T","F") NULL DEFAULT "F", ' +
	                        ' Shippingphone   VARCHAR(100) NULL DEFAULT "", ' +
	                        ' estimatedDeliveryDate DATETIME NULL DEFAULT NULL, ' +
	                        ' estimatedShipDate     DATETIME NULL DEFAULT NULL, ' +
	                        ' PostalAddressName     VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressAddress1 VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressAddress2 VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressCity     VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressstate    VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressPostcode VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressCountry  VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' PostalAddressAddresstype  VARCHAR(50) NULL DEFAULT NULL COMMENT "eg : RESIDENTIAL", ' +
	                        ' ERPSalesRef               VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' OrderLineId     INT(11) NOT NULL DEFAULT 0 , ' +
	                        ' Linenumber      VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' ProductName     VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' sku             VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' QtySold         DOUBLE NOT NULL DEFAULT 0 , ' +
	                        ' UOM             VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' statusDate      DATETIME NULL DEFAULT NULL, ' +
	                        ' originalCarrierMethod   VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' ValidateOrderStatusCode INT(11) NULL DEFAULT NULL, ' +
	                        ' orderstatus             VARCHAR(100) NULL DEFAULT "", ' +
	                        ' PreviousStatuses        Text NULL DEFAULT NULL, ' +
	                        ' Invoiceref              VARCHAR(255) NULL DEFAULT NULL, ' +
	                        ' IsRefunded              ENUM("T","F") NULL DEFAULT "F", ' +
	                        ' RefundChargeID          INT(11) NOT NULL ,' +
	                        ' RefundID                INT(11) NULL DEFAULT 0,' +
                          ' RefundLineID            INT(11) NULL DEFAULT 0,' +
	                        ' RefundReason            VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' RefundChargetype        VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' RefundChargeName        VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' RefundChargeAmount      DOUBLE NULL DEFAULT NULL,' +
	                        ' RefundChargeCurrency    CHAR(100) NULL DEFAULT NULL,' +
	                        ' RefundtaxName           VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' RefundTaxCurrency       VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' RefundTaxAmount         DOUBLE NOT NULL DEFAULT 0,' +
	                        ' ERPRefundRef            VARCHAR(255) NULL DEFAULT NULL,' +
	                        ' PRIMARY KEY (ID)) COLLATE="utf8_general_ci" ENGINE=MyISAM;');
    SQL.add('ALTER TABLE '+fsTablename+' 	ADD INDEX OrderId (OrderId), 	ADD INDEX OrderLineId (OrderLineId);');
    SQL.add('insert ignore into '+ fsTablename +
                               ' (OrderId,GlobalRef,EmployeeName,purchaseOrderId,customerOrderId,customerEmailId,orderDate,BuyerId,Mart,IsGuest,Shippingphone,estimatedDeliveryDate,estimatedShipDate,' +
                               ' PostalAddressName,PostalAddressAddress1,PostalAddressAddress2,PostalAddressCity,PostalAddressstate,PostalAddressPostcode,PostalAddressCountry,' +
                               ' PostalAddressAddresstype,ERPSalesRef,OrderLineId,Linenumber,ProductName,sku,QtySold,UOM,originalCarrierMethod,ValidateOrderStatusCode) ' +
                               ' select ' +
                               ' WO.OrderId as OrderId, ' +
                               ' WO.GlobalRef as GlobalRef, ' +
                               ' WO.EmployeeName as EmployeeName, ' +
                               ' WO.purchaseOrderId as purchaseOrderId, ' +
                               ' WO.customerOrderId as customerOrderId, ' +
                               ' WO.customerEmailId as customerEmailId, ' +
                               ' WO.orderDate as orderDate, ' +
                               ' WO.BuyerId as BuyerId, ' +
                               ' WO.Mart as Mart, ' +
                               ' WO.IsGuest as IsGuest, ' +
                               ' WO.Shippingphone as Shippingphone, ' +
                               ' WO.estimatedDeliveryDate as estimatedDeliveryDate, ' +
                               ' WO.estimatedShipDate as estimatedShipDate, ' +
                               ' WO.PostalAddressName as PostalAddressName, ' +
                               ' WO.PostalAddressAddress1 as PostalAddressAddress1, ' +
                               ' WO.PostalAddressAddress2 as PostalAddressAddress2, ' +
                               ' WO.PostalAddressCity as PostalAddressCity, ' +
                               ' WO.PostalAddressstate as PostalAddressstate, ' +
                               ' WO.PostalAddressPostcode as PostalAddressPostcode, ' +
                               ' WO.PostalAddressCountry as PostalAddressCountry, ' +
                               ' WO.PostalAddressAddresstype as PostalAddressAddresstype, ' +
                               ' WO.ERPSalesRef as ERPSalesRef, ' +
                               ' WOL.OrderLineId as OrderLineId, ' +
                               ' WOL.Linenumber as Linenumber, ' +
                               ' WOL.ProductName as ProductName, ' +
                               ' WOL.sku as sku, ' +
                               ' WOL.QtySold as QtySold, ' +
                               ' WOL.UOM as UOM, ' +
                               ' WOL.originalCarrierMethod as originalCarrierMethod, ' +
                               ' WOL.ValidateOrderStatusCode as ValidateOrderStatusCode ' +
                               ' from tblwalmartorders WO inner join tblwalmartorderlines WOL on WO.OrderId = WOL.OrderId ' +
                               ' Where WO.Orderdate between '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , filterDateFrom))+' and '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , filterdateTo)) +
                               ' group by WOL.OrderLineId ' +
                               ' order by orderDate , orderid desc , linenumber;');
    {status = invoiced if already invoiced}
    SQL.add('update '+ fsTablename +' T inner join tblsales S on T.ERPSalesRef = S.GlobalRef  ' +
                               ' inner join tblsales inv on S.GlobalRef = Inv.salesorderGlobalref and inv.isinvoice ="T"  ' +
                               ' Set T.Invoiceref = Inv.globalref, T.orderstatus ='+quotedstr(WalmartOrderStatus_Invoiced)+' ,  T.StatusDate = Inv.saledate;');
    {looking for latest status - can be walmart status / erp status. ie: when s sales order is created, walmart is not updates}
    SQL.add('drop table if exists '+ fsTablename +'1;');
    SQL.add('create table '+ fsTablename +'1 ' +
                               ' select ' +
                               ' T.OrderId , T.OrderLineId , WOLS1.orderstatus , WOLS1.mstimestamp ' +
                               ' from '+ fsTablename +' T inner join ' +
                               ' tblwalmartorderlinestatus WOLS1 on T.OrderLineId = WOLS1.OrderLineId ' +
                               ' and WOLS1.OrderLineStatusID in ( Select max(sWOLS1.OrderLineStatusID) from tblwalmartorderlinestatus sWOLS1 ' +
                               ' where sWOLS1.OrderLineId = T.OrderLineId) ' +
                               ' union all ' +
                               ' select ' +
                               ' T.OrderId , T.OrderLineId , WOLS1.Status orderstatus, WOLS1.mstimestamp ' +
                               ' from '+ fsTablename +' T inner join ' +
                               ' tblwalmartorderstatus_erp WOLS1 on T.OrderLineId = WOLS1.WOLineID ' +
                               ' and WOLS1.ID in ( Select max(sWOLS1.ID) from tblwalmartorderstatus_erp sWOLS1 ' +
                               ' where sWOLS1.WOLineID = T.OrderlineID);');
    SQL.add('ALTER TABLE '+fsTablename+'1 	ADD INDEX OrderId (OrderId), 	ADD INDEX OrderLineId (OrderLineId);');
    SQL.add('update '+ fsTablename +' T1 inner join ' +
                               ' (select distinct t2.* from '+ fsTablename +'1 T2 where mstimestamp in (select max(mstimestamp) from '+ fsTablename +'1 sT2 where sT2.orderlineId = T2.OrderLineID)) TS ' +
                               ' on T1.OrderId  = TS.orderID ' +
                               ' and  T1.OrderlineId  = TS.orderlineID ' +
                               ' Set T1.orderstatus = TS.orderstatus , T1.StatusDate = TS.mstimestamp' +
                               ' where  T1.Orderstatus = "";');
    {Previous Statuses}
    SQL.add('drop table if exists '+ fsTablename +'1;');
    SQL.add('create table '+ fsTablename +'1  ' +
                               ' select  T.OrderId , T.OrderLineId , WOLS1.orderstatus , WOLS1.mstimestamp   ' +
                               ' from '+ fsTablename +' T  ' +
                               ' inner join  tblwalmartorderlinestatus WOLS1 on T.OrderLineId = WOLS1.OrderLineId  and WOLS1.OrderLineStatusID not in  ' +
                                           ' ( Select max(sWOLS1.OrderLineStatusID) from tblwalmartorderlinestatus sWOLS1   ' +
                                             ' where sWOLS1.OrderLineId = T.OrderLineId)   ' +
                              ' union all  select  T.OrderId , T.OrderLineId , WOLS1.Status orderstatus, WOLS1.mstimestamp   ' +
                              ' from '+ fsTablename +' T  ' +
                              ' inner join  tblwalmartorderstatus_erp WOLS1 on T.OrderLineId = WOLS1.WOLineID  and WOLS1.ID not in  ' +
                                             ' ( Select max(sWOLS1.ID) from tblwalmartorderstatus_erp sWOLS1   ' +
                                             ' where sWOLS1.WOLineID = T.OrderlineID);');

    SQL.add('ALTER TABLE '+fsTablename+'1 	ADD INDEX OrderId (OrderId), 	ADD INDEX OrderLineId (OrderLineId);');

    SQL.add('drop table if exists '+ fsTablename +'2;');
    SQL.add('create table  '+ fsTablename +'2 select OrderId, orderLineID , GROUP_CONCAT(Orderstatus) as Orderstatuses from  '+ fsTablename +'1 group by OrderId, orderLineID ;');
    SQL.add('ALTER TABLE '+fsTablename+'2 	ADD INDEX OrderId (OrderId), 	ADD INDEX OrderLineId (OrderLineId);');
    SQL.add('update  '+ fsTablename +' T1 inner join   '+ fsTablename +'2 T2 on t1.orderId = t2.orderId and t1.orderlineid = t2.orderlineId set T1.previousstatuses = T2.Orderstatuses;');
    SQL.add('drop table if exists '+ fsTablename +'1;');
    SQL.add('drop table if exists '+ fsTablename +'2;');
      SQL.add('update  '+ fsTablename +' WO  '+
            ' inner join tblwalmartrefunds WR on WO.customerOrderId = WR.customerOrderId '+
            ' inner join tblwalmartrefundlines WRL on WR.ID = WRL.RefundId and WRL.salesOrderLineNumber = WO.Linenumber '+
            ' inner join tblwalmartrefundlinechargestotals WRCT on WRCT.RefundLineID = WRL.ID and WRCT.chargeTotalsname = "lineTotal" '+
            ' left join tblwalmartrefundlinechargestotals WRCTX on WRCTX.RefundLineID = WRL.ID and WRCTX.chargeTotalsname = "lineTotalTaxes" '+
            ' set  WO.IsRefunded="T",  '+
                  'WO.RefundID             = WR.ID , '+
                  'WO.RefundLineID         = WRL.ID, '+
                  'WO.RefundReason         = WRL.returnReason , '+
                  'WO.RefundChargeName     = WRCT.chargeTotalsname , '+
                  'WO.RefundChargeAmount   = WRCT.chargeTotalsValue, '+
                  'WO.RefundChargeCurrency = WRCT.chargeTotalsCurrency , '+
                  'WO.RefundtaxName        = WRCTX.chargeTotalsname  , '+
                  'WO.RefundTaxCurrency    = WRCTX.chargeTotalsCurrency , '+
                  'WO.RefundTaxAmount      = WRCTX.ChargeTotalsValue, '+
                  'WO.ERPRefundRef         = WRL.ERPRefundRef;');
    //clog(SQL.text);
    showProgressbar(WAITMSG, SQL.count);
    try
      Execute;
    finally
      HideProgressbar;
    end;
  end;
end;
procedure TWalmartOrderLinesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainOrderLineId.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainOrderID.fieldname);
  RemoveFieldfromGrid(qryMainRefundChargeID.fieldname);
  RemoveFieldfromGrid(qryMainRefundID.fieldname);
end;

procedure TWalmartOrderLinesGUI.StopSynch;
begin
  StopSynch(btnSynchOrders);
end;

procedure TWalmartOrderLinesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.showSynchLog'].asBoolean := chkshowSynchLog.checked;
end;

procedure TWalmartOrderLinesGUI.LoginList(const Value: String;const ShowinList: Boolean);
begin
  inherited LoginList(Value , chkshowSynchLog.checked and ShowinList );
end;


procedure TWalmartOrderLinesGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainorderDate.displayformat := FormatSettings.ShortDateformat;
  qryMainestimatedDeliveryDate.displayformat := FormatSettings.ShortDateformat;
  qryMainestimatedShipDate.displayformat := FormatSettings.ShortDateformat;
  qryMainstatusDate.displayformat := FormatSettings.ShortDateformat;
end;
procedure TWalmartOrderLinesGUI.OnwalmartOrderReturn(Sender: TObject);
begin
//
end;

procedure TWalmartOrderLinesGUI.UpdateWalmartproductQty;
var
  fs, errMsg:String;
  qry: TERPQuery;
  InventoryFeed : IXMLInventoryFeed;
  aInventory :IXMLInventory;
begin
  if not Appenv.companyprefs.Walmart_EnableInvFeed then exit;
  InventoryFeed := NewInventoryFeed;
  with InventoryFeed.InventoryHeader do begin
      Version := '1.4';
  end;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQl.text := 'select ID, sku , Availabilitycode, ' +
                    '  ifnull(UOM , '+ Quotedstr(DefaultWalmartUOM)+') as UOM , ' +
                    '  ERPProductID , UOMMUlt , fulfillmentLagTime, ' +
                    '  MinfulfillmentLagTime ' +
                    '    from tblwalmartitems ' ;

    Qry.open;
    if Qry.recordcount =0 then exit;
    Qry.first;
    LoginList('Checking for Walmart Inventory');
    While Qry.Eof  = false do begin
        LoginList('SKU : ' + Qry.fieldbyname('Sku').asString);
        aInventory:= InventoryFeed.Inventory.Add;
        with aInventory do begin
            Sku         := Qry.fieldbyname('Sku').asString;
            AvailabilityCode := Qry.fieldbyname('AvailabilityCode').asString;
            Quantity.unit_ := uppercase(Qry.fieldbyname('uom').asString);


                  Quantity.amount :=  //FloattostrF(ProductAvailableQty(qry.FieldByname('ERPProductId').asInteger), ffgeneral, 15,2); // FloattostrF(Twalmartitemqtyupdatelines(Sender).NewQty, ffgeneral, 15,2);
                                    FloattostrF(divZer(ProductAvailableQty(Qry.fieldbyname('ERPProductId').asInteger , '') ,
                                                               Qry.fieldbyname('UOMMult').asFloat), ffgeneral, 15,2);


            if (Qry.fieldbyname('fulfillmentLagTime').asInteger =0) and DevMode then fulfillmentLagTime := 1
            else fulfillmentLagTime := Qry.fieldbyname('fulfillmentLagTime').asInteger;

            if (Qry.fieldbyname('MinfulfillmentLagTime').asInteger =0) and DevMode then MinfulfillmentLagTime := 1
            else MinfulfillmentLagTime := Qry.fieldbyname('MinfulfillmentLagTime').asInteger;
            clog(aInventory.xml);
        end;
        Qry.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  LoginList('Synchronizing Walmart Inventory');
  with InventoryFeed do begin
      fs:=SystemLib.ExeDir+'WalmartProducts.xml';
      clog(XML, fs);
      WalmartProductUpdate(XML, fs, errmsg, LoginList );
  end;
  LoginList('Done - Synchronizing');
end;
procedure TWalmartOrderLinesGUI.DoEDIAutocheck(Sender: TObject);
begin
  inherited;
  DocheckforOrders;
end;
function TWalmartOrderLinesGUI.SynchTransactions: boolean;
begin
  result := true;
  LogInList('Synch Sales From Walmart...' );
  TErpSynchWalmart(SynchObj).SynchOrders;
end;

function TWalmartOrderLinesGUI.MakeCoreServiceObj: TBaseCoreService;
begin
  result := TWalmartCoreService.Create;
end;
function TWalmartOrderLinesGUI.Autocheck: boolean; begin    result := Appenv.companyprefs.WALMART_AutocheckforOrdersinList; end;
function TWalmartOrderLinesGUI.ModuleCaption: String; begin   Result := 'Walmart'; end;
function TWalmartOrderLinesGUI.CheckOrdersInterval: Integer; begin result := WALMART_CHECKORDERSINTERVAL; end;

initialization
  RegisterClassOnce(TWalmartOrderLinesGUI);

end.
