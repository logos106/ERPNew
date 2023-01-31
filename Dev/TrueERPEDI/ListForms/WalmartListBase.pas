unit WalmartListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,ERPEDIListBase;

type
  TWalmartListBaseGUI = class(TERPEDIListBaseGUI)
    pnlExtraButtons: TDNMPanel;
    btnrecreateTable: TDNMSpeedButton;
    procedure btnCreateTablesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    fsIteraterecordsMsgs:String;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure OpenLogFile;
    procedure Alignbuttons; Override;
    function PurchaseOrderID(const aOrderID: Integer): String;
    procedure AcknowledgeWO(Sender: TObject); Overload;
    procedure AcknowledgeWO(aPOID:String);Overload;
    procedure ResponseProcessProc(const Value: Pointer);
    Function MakeERPSOForWalmart(const purchaseOrderId:String):Boolean;
    Function MakeERPREfund(const RefundLineID:Integer):Boolean;
    function CurRecPurchaseOrderID(UseDevModeNo:Boolean): String;
  public
    Procedure OpenPreferance;Override;
  Published
  end;

implementation

uses LogLib, dmMainGUI, CommonLib, DbSharedObjectsObj,
  CommonDbLib, BusobjWalmartOrders, CK_DLL_WalmartLib, tcConst, frmMessageBase,
  MAIN, LogDialog, BusObjERPWalmartRefunds, Preferences;

{$R *.dfm}
Function TWalmartListBaseGUI.CurRecPurchaseOrderID(UseDevModeNo:Boolean):String;
begin
  if devmode and UseDevModeNo then
    REsult := '999999999999'
  else result := qrymain.Fieldbyname('PurchaseOrderID').asString;
end;

Function TWalmartListBaseGUI.MakeERPREfund(const RefundLineID:Integer):Boolean;
var
  //WalmartOrderLineRefundChargeObj : TWalmartOrderLineRefundCharges;
  walmartrefundline : Twalmartrefundlines;
begin
  Result := False;
  if RefundLineID =0 then exit;

  Processingcursor(True);
  try
     LoginList('Order #' + CurRecPurchaseOrderID(False) +' Making ERP SO' , true);
      walmartrefundline := Twalmartrefundlines.createwithNewConn(Self);
      try
        walmartrefundline.Load(RefundLineID);
        if walmartrefundline.count =0 then exit;

        if walmartrefundline.MakeERPREfund then begin
          LoginList('Order #' + CurRecPurchaseOrderID(False) +' is Refunded. ERP Refund #' + walmartrefundline.ERPRefundRef );
          Result := True;
        end else begin
          LoginList('Failed to refund Order #' + CurRecPurchaseOrderID(False) +'.');
          Result := False;
        end;
      finally
        Freeandnil(walmartrefundline);
      end;
      (*WalmartOrderLineRefundChargeObj := TWalmartOrderLineRefundCharges.createwithNewConn(Self);
      try
        WalmartOrderLineRefundChargeObj.Load(RefundchargeID);
        if WalmartOrderLineRefundChargeObj.count =0 then exit;

        if WalmartOrderLineRefundChargeObj.MakeERPREfund then begin
          LoginList('Order #' + CurRecPurchaseOrderID(False) +' is Refunded. ERP Refund #' + WalmartOrderLineRefundChargeObj.ERPRefundRef );
          Result := True;
        end else begin
          LoginList('Failed to refund Order #' + CurRecPurchaseOrderID(False) +'.');
          Result := False;
        end;
      finally
        Freeandnil(WalmartOrderLineRefundChargeObj);
      end;*)
  finally
    Processingcursor(False);
  end;
end;

Function TWalmartListBaseGUI.MakeERPSOForWalmart(const purchaseOrderId:String):Boolean;
var
  WalmartOrderObj : TWalmartOrders;
begin
  Processingcursor(True);
  try
     LoginList('Order #' + purchaseOrderId +' Making ERP SO' );
      WalmartOrderObj := TWalmartOrders.createwithNewConn(Self);
      try
        WalmartOrderObj.loadselect('PurchaseorderId = ' + Quotedstr(purchaseOrderId));
        if WalmartOrderObj.CopyWOtoSO then begin
          if fsIteraterecordsMsgs <> '' then fsIteraterecordsMsgs := fsIteraterecordsMsgs + NL;
          fsIteraterecordsMsgs:= fsIteraterecordsMsgs +'ERP Sales Order ' + quotedstr(WalmartOrderObj.ERPSalesRef)+' has been created for Order #' + purchaseOrderId +'';
          LoginList('Order #' + purchaseOrderId +' =  ERP SO #' + WalmartOrderObj.ERPSalesRef );
          WalmartOrderObj.MakeERPSOForWalmartforWalmartOrder;
          Result := True;
        end else begin
          if fsIteraterecordsMsgs <> '' then fsIteraterecordsMsgs := fsIteraterecordsMsgs + NL;
          fsIteraterecordsMsgs:= fsIteraterecordsMsgs +'Failed to Create ERP Sales Order for Order #' + purchaseOrderId +' - ' + WalmartOrderObj.ValidateOrderStatusMsg;
          LoginList('Order #' + purchaseOrderId +', Failed to Create ERP Sales Order - ' + WalmartOrderObj.ValidateOrderStatusMsg );
          Result := False;
        end;
      finally
        Freeandnil(WalmartOrderObj);
      end;
  finally
    Processingcursor(False);
  end;
end;

procedure TWalmartListBaseGUI.Alignbuttons;
var
  ctr:Integer;
begin
  Inherited;
  btnrecreateTable.visible := False;
  Alignbuttons(pnlExtraButtons);
  setlength(buttons,0);
  for ctr := 0 to pnlExtraButtons.ControlCount - 1 do begin
    if pnlExtraButtons.Controls[ctr] is TDnmspeedbutton then begin
      if TDnmspeedbutton(pnlExtraButtons.Controls[ctr]).Visible then begin
        Setlength(Buttons , length(Buttons)+1);
        Buttons[high(Buttons)] := TDnmspeedbutton(pnlExtraButtons.Controls[ctr]).Name;
      end;
    end;
  end;
  Centralisebuttons(pnlExtraButtons);

  Alignbuttons(FooterPanel);
  initFooterPanelButtons;
  Centralisebuttons(FooterPanel);
  //Alignbuttons(pnlExtraButtons);
end;

procedure TWalmartListBaseGUI.btnCreateTablesClick(Sender: TObject);
begin
  inherited;
  with Scriptmain do begin
    SQL.Clear;
    SQL.LoadFromfile('C:\SQLDropbox\SQL.SQL');
    Execute;
    RefreshQuery;
    LoginList('Table Re-Populated' );
  end;

end;

procedure TWalmartListBaseGUI.FormShow(Sender: TObject);
begin
  Alignbuttons;
  inherited;
  if Assigned(CallingAction) then ;
end;

procedure TWalmartListBaseGUI.OpenLogFile;
begin
  Loglib.OpenLogFile;
end;


function TWalmartListBaseGUI.PurchaseOrderID(const aOrderID: Integer): String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    qry.SQL.text := 'select purchaseorderID from tblwalmartorders where orderId =' + inttostr(aorderID);
    opendb(qry);
    Result :=qry.fieldbyname('purchaseorderID').AsString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TWalmartListBaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;

end;

procedure TWalmartListBaseGUI.ResponseProcessProc(const Value: Pointer);
begin
end;

procedure TWalmartListBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
end;

procedure TWalmartListBaseGUI.AcknowledgeWO(aPOID:String);
var
  WalmartOrderObj : TWalmartOrders;
begin
   if aPOID ='' then exit;
   WalmartOrderObj := TWalmartOrders.createwithNewConn(Self);
   WalmartOrderObj.loadSelect('purchaseorderId =' + aPOID);
   if WalmartOrderObj.count =0 then exit;
   AcknowledgeWO(WalmartOrderObj);
end;

procedure TWalmartListBaseGUI.AcknowledgeWO(Sender: TObject);
var
  WalmartOrders : TWalmartOrders;
begin
  if not (Sender is TWalmartOrders) then exit;
  WalmartOrders := TWalmartOrders(Sender);
  with WalmartOrders do begin
    if count =0 then exit;
    if not WalmartOrders.IsAcknowledged  then begin
      LoginList('Order #' + purchaseOrderId +' Acknowledging' );
      if CK_DLL_WalmartLib.AcknowledgeWalmartOrder(purchaseOrderId,  fsIteraterecordsMsgs,  LoginList , ResponseProcessProc) then begin
          AcknowledgeWalmartOrder;
      end else begin
        Exit;
      end;
    end else begin
      LoginList('Order #' + purchaseOrderId +' Status checked' );
    end;
    //MakeERPSOForWalmart(PurchaseOrderID); // do not do this - wait for user to confirm / cancel
  end;
end;
procedure TWalmartListBaseGUI.OpenPreferance;
begin
  inherited;
  OpenPrefform('EDI and Integration' ,  'chk_AutocheckforOrdersinList', 0 , True, 'Walmart' , 'pnlWalmartOptions' ,
                    'Changes made here will not take affect unless the Application is Restarted.');

end;

end.
