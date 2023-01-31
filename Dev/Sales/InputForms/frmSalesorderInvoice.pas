unit frmSalesorderInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   busobjSalesorderInvoice, busobjsales , BusObjBase, Grids, Wwdbigrd, Wwdbgrid, wwdbdatetimepicker, wwdblook, Mask, wwdbedit,
  ImageDLLLib, ActnList, DNMAction;

type
  TfmSalesorderInvoice = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlDetails: TDNMPanel;
    pnlBottom: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QrySalesOrderLines: TERPQuery;
    QrySalesOrderLinesProductName: TWideStringField;
    QrySalesOrderLinesProduct_Description: TWideStringField;
    QrySalesOrderLinesUOM: TWideStringField;
    QrySalesOrderLinesUnitofMeasureQtySold: TFloatField;
    QrySalesOrderLinesUnitofMeasureShipped: TFloatField;
    QrySalesOrderLinesUnitofMeasureBackorder: TFloatField;
    QrySalesOrderLinesInvoiced: TFloatField;
    QrySalesOrderLinessaleID: TIntegerField;
    QrySalesOrderLinesSaleLineID: TIntegerField;
    QrySalesOrderLinesProductID: TIntegerField;
    dsSalesOrderLines: TDataSource;
    QrySaleSOrderInvoice: TERPQuery;
    QrySaleSOrderInvoiceSOInvoiceID: TIntegerField;
    QrySaleSOrderInvoiceGlobalRef: TWideStringField;
    QrySaleSOrderInvoiceSalesOrderID: TIntegerField;
    QrySaleSOrderInvoiceInvoicedBy: TIntegerField;
    QrySaleSOrderInvoiceInvoicedOn: TDateTimeField;
    QrySaleSOrderInvoicemstimeStamp: TDateTimeField;
    QrySaleSOrderInvoicemsUpdateSiteCode: TWideStringField;
    dsSaleSOrderInvoice: TDataSource;
    QrySaleSOrderInvoiceLines: TERPQuery;
    QrySaleSOrderInvoiceLinesProductName: TStringField;
    QrySaleSOrderInvoiceLinesProduct_Description: TStringField;
    QrySaleSOrderInvoiceLinesUOM: TStringField;
    QrySaleSOrderInvoiceLinesUOMQtySold: TFloatField;
    QrySaleSOrderInvoiceLinesUOMQtyShipped: TFloatField;
    QrySaleSOrderInvoiceLinesUOMBOQty: TFloatField;
    QrySaleSOrderInvoiceLinesInvoicedQty: TFloatField;
    QrySaleSOrderInvoiceLinesUOMQty: TFloatField;
    QrySaleSOrderInvoiceLinesSOInvoiceLineID: TIntegerField;
    QrySaleSOrderInvoiceLinesGlobalRef: TWideStringField;
    QrySaleSOrderInvoiceLinesSOInvoiceID: TIntegerField;
    QrySaleSOrderInvoiceLinesSalesOrderLineID: TIntegerField;
    QrySaleSOrderInvoiceLinesProductId: TIntegerField;
    QrySaleSOrderInvoiceLinesUOMID: TIntegerField;
    QrySaleSOrderInvoiceLinesUOMMultiplier: TFloatField;
    QrySaleSOrderInvoiceLinesQty: TFloatField;
    QrySaleSOrderInvoiceLinesmstimeStamp: TDateTimeField;
    QrySaleSOrderInvoiceLinesmsUpdateSiteCode: TWideStringField;
    dsSaleSOrderInvoiceLines: TDataSource;
    grdTransactions: TwwDBGrid;
    Label1: TLabel;
    txtComments: TDBMemo;
    QrySaleSOrderInvoiceNotes: TWideStringField;
    Label2: TLabel;
    qryEmployees: TERPQuery;
    cboEmployee: TwwDBLookupCombo;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    lblmsg: TLabel;
    tmrMsg: TTimer;
    MnuGrd: TAdvPopupMenu;
    mnuAllocation: TMenuItem;
    QrySaleSOrderInvoiceLinesPQA: TStringField;
    QrySalesOrderLinesQtytoInvoice: TFloatField;
    QrySaleSOrderInvoiceLinesQtytoInvoice: TFloatField;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    ImageList1: TImageList;
    c: TActionList;
    actclose: TDNMAction;
    actautoAlocate: TDNMAction;
    actSave: TDNMAction;
    actShipAll: TDNMAction;
    pnlButtons: TDNMPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMsgTimer(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure mnuAllocationClick(Sender: TObject);
    procedure QrySaleSOrderInvoiceLinesCalcFields(DataSet: TDataSet);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure QrySalesOrderLinesCalcFields(DataSet: TDataSet);
    procedure btnshipAllClick(Sender: TObject);
    procedure btnAutoAllocateClick(Sender: TObject);
    procedure QrySaleSOrderInvoiceLinesBeforePost(DataSet: TDataSet);
    procedure QrySaleSOrderInvoiceLinesUOMQtyChange(Sender: TField);
  private
    fiSaleLineID:Integer;
    fisaleID:Integer;
    fSalesOrder:TSalesOrder;
    OvershippedQtyMsgShown:Boolean;
    fSalesOrderInvoices: TSalesOrderInvoices;

    Procedure InitSalesOrderInvoice;
    procedure InitSalesOrderInvoiceLines(const Sender: TBusObj; var Abort: Boolean);
    function SaveRecord: Boolean;
    Procedure ShipAllCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure AutoAllocateCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure intSalesOrderinvoiceAllocation(Sender: TObject);
    function SalesorderhasAllocationforLine(const SalesLineID: Integer): Boolean;
    function Showallocationform:Boolean;
    function DoAllocate: Boolean;
  Protected
    cmdClose: TERPMainSwitchButton;
    btnAutoAllocate: TERPMainSwitchButton;
    btnshipAll: TERPMainSwitchButton;
    cmdCancel: TERPMainSwitchButton;
    function DOProductAllocate:Boolean;
    Procedure Makebuttons;Virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property SalesOrderInvoices: TSalesOrderInvoices read fSalesOrderInvoices;
    Property saleID :Integer read fisaleID write fisaleID;
    Property SaleLineID :Integer read fiSaleLineID write fiSaleLineID;
  end;


implementation

uses AdvGlowButton,CommonLib, BusObjConst, AppEnvironment, CommonFormLib, frmSalesOrderinvoiceAllocation, frmAllocation, tcDataUtils, tcConst;

{$R *.dfm}

procedure TfmSalesorderInvoice.btnAutoAllocateClick(Sender: TObject);
begin
  inherited;
  fSalesOrderInvoices.Lines.IterateRecords(AutoAllocateCallback);
end;

procedure TfmSalesorderInvoice.btnshipAllClick(Sender: TObject);
var
  fbFlag : Boolean;
begin
  inherited;
  fbFlag := fSalesOrderInvoices.Lines.DoFieldChangewhenDisabled;
  fSalesOrderInvoices.Lines.DoFieldChangewhenDisabled := True;
  try
    DoShowProgressbar(fSalesOrderInvoices.Lines.count, WAITMSG);
    try
      fSalesOrderInvoices.Lines.IterateRecords(ShipAllCallback);
    finally
      DoHideProgressbar;
    end;
  finally
    fSalesOrderInvoices.Lines.DoFieldChangewhenDisabled := fbFlag;
  end;
end;
Procedure TfmSalesorderInvoice.AutoAllocateCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  DoStepProgressbar;
  if not (Sender is TSalesOrderInvoiceLines) then exit;
  TSalesOrderInvoiceLines(Sender).PostDB;
  if TSalesOrderInvoiceLines(Sender).UOMQty =0 then exit;
  TfmSalesOrderinvoiceAllocation.AutoAllocateAll(TSalesOrderInvoiceLines(Sender));
end;

Procedure TfmSalesorderInvoice.ShipAllCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  DoStepProgressbar;
  if not (Sender is TSalesOrderInvoiceLines) then exit;
  if TSalesOrderInvoiceLines(Sender).QtytoInvoice <> 0 then begin
    TSalesOrderInvoiceLines(Sender).UOMQty := TSalesOrderInvoiceLines(Sender).QtytoInvoice;
    TSalesOrderInvoiceLines(Sender).PostDB;
    TfmSalesOrderinvoiceAllocation.AutoAllocateAll(TSalesOrderInvoiceLines(Sender));
  end;
end;

procedure TfmSalesorderInvoice.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
       Modalresult := mrCancel
  else Self.Close;
end;

Function TfmSalesorderInvoice.SaveRecord :Boolean;
begin
  result:= False;
  fSalesOrderInvoices.PostDB;
  if not(fSalesOrderInvoices.Save) then exit;
  Result:= True;

end;

procedure TfmSalesorderInvoice.tmrMsgTimer(Sender: TObject);
begin
  inherited;
  TimerMsg(lblmsg , 'Product(s) with Quantitys in Red color has Quantity alreay invoiced more than the sales order Quantity', 30);
  tmrMsg.Enabled := False;
end;

procedure TfmSalesorderInvoice.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  fSalesOrderInvoices.Connection.CommitTransaction;
  fSalesOrderInvoices.Dirty := False;
  if fsModal in FormState then
    ModalREsult := mrOk
  else begin
      if fSalesOrderInvoices.InvoiceId <> 0 then begin
        if MessageDlgXP_vista('Invoice Created. Please Check Invoice #' + inttostr(fSalesOrderInvoices.InvoiceId ) +' for details. '+
                                'Do you want to see the invoice? ' , mtConfirmation, [mbyes,mbno], 0) = mryes then
            OpenERPForm('TInvoiceGUI' , fSalesOrderInvoices.InvoiceId);
      end else if fSalesOrderInvoices.SalesOrder.isinternalOrder then
        MessageDlgXP_vista('Quantity Selected is now in stock for Sales Order # ' + inttostr(fSalesOrderInvoices.salesorderID)+'.', mtConfirmation, [mbOK], 0);
      Self.Close;
  end;
end;

procedure TfmSalesorderInvoice.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TSalesOrderInvoices     then TSalesOrderInvoices(Sender).Dataset      := QrySaleSOrderInvoice
    else if Sender is TSalesOrderInvoiceLines then TSalesOrderInvoiceLines(Sender).Dataset  := QrySaleSOrderInvoiceLines;
  end;
end;

function TfmSalesorderInvoice.DOProductAllocate: Boolean;
begin
        Result := False;
        if (fSalesOrderInvoices.lines.ProductId =0) then exit;
        if not (IsInvProduct(fSalesOrderInvoices.lines.Product.Producttype)) then begin
          MessageDlgXP_Vista(fSalesOrderInvoices.lines.productname + ' is ' + quotedstr(Producttypename(fSalesOrderInvoices.lines.product.ProductType)) +' type.  Allocation is only for inventory products', mtWarning, [mbOK], 0);
          exit;
        end;
        if (fSalesOrderInvoices.lines.product.Batch = False) and ( fSalesOrderInvoices.lines.product.Multiplebins = False) and ( fSalesOrderInvoices.lines.product.SnTracking = False) Then begin
          MessageDlgXP_Vista(fSalesOrderInvoices.lines.productname + ' has none of the allocations  - Batch / Bin / Serial Number tracking - turned on', mtWarning, [mbOK], 0);
          exit;
        end;
        if fSalesOrderInvoices.SalesOrder.hasAllocation then begin
            mnuAllocationClick(nil);
            Exit;
        end;
        result :=Showallocationform;
end;

procedure TfmSalesorderInvoice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if fsmodal in formstate then
  else action := caFree;
end;

procedure TfmSalesorderInvoice.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if fSalesOrderInvoices.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin

          RollbackTransaction;
          fSalesOrderInvoices.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmSalesorderInvoice.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := False;
  OvershippedQtyMsgShown:= False;
  inherited;
  fSalesOrderInvoices := TSalesOrderInvoices.Create(Self);
  fSalesOrderInvoices.Connection := TMyDacDataConnection.Create(fSalesOrderInvoices);
  fSalesOrderInvoices.Connection.Connection:= Self.MyConnection;
  fSalesOrderInvoices.BusObjEvent := DoBusinessObjectEvent;
  Makebuttons;
end;
procedure TfmSalesorderInvoice.FormShow(Sender: TObject);
begin
  inherited;
  fSalesOrderInvoices.Load(KeyID);
  fSalesOrderInvoices.connection.BeginTransaction;
  if KeyId = 0 then
    InitSalesOrderInvoice
  else begin
    fSalesOrderInvoices.Lines;
    if not(fSalesOrderInvoices.SalesOrder.LockSOnSOInvoices ) then begin
      Accesslevel := 5;
      MessageDlgXP_Vista(replacestr(fSalesOrderInvoices.SalesOrder.userlock.lockmessage , 'Unable to update data.' , 'Unable to Invoice Sales Order #' + inttostr(fSalesOrderInvoices.SalesOrder.Id) +'.'), mtWarning, [mbOK], 0);
    end;
    closeDB(QrySalesOrderLines);
    QrySalesOrderLines.ParamByName('SAleID').AsInteger := fSalesOrderInvoices.salesorderId;
    OpenDB(QrySalesOrderLines);
  end;
  openQueries;
  Setcontrolfocus(grdTransactions);
  fSalesOrderInvoices.Lines.first;
  if SalesOrderInvoices.SalesOrder.isinternalOrder then begin
      TitleLabel.Caption := 'Place Into Stock';
      ActSave.Caption := 'Place Into Stock';
  end else begin
      TitleLabel.Caption := 'Partial Invoicing';
      ActSave.Caption := 'Make Invoice';
  end;
end;


procedure TfmSalesorderInvoice.grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sameText(Field.fieldname , QrySaleSOrderInvoiceLinesUOMQty.FieldName) or sameText(Field.fieldname , QrySaleSOrderInvoiceLinesPQA.FieldName) then
       AFont.Style :=AFont.Style  +[fsbold]
  else begin
    ABrush.Color := $00EDF0F1;//clInactiveCaptionText;
    //AFont.Color := $00737373;
  end;
  if  QrySaleSOrderInvoiceLinesUOMQtyShipped.AsFloat < QrySaleSOrderInvoiceLinesInvoicedQty.AsFloat then
    if sameText(Field.fieldname , QrySaleSOrderInvoiceLinesUOMQtyShipped.FieldName) or
      sameText(Field.fieldname , QrySaleSOrderInvoiceLinesInvoicedQty.FieldName)  then begin
      ABrush.Color := $00B0B0FF;
      if not OvershippedQtyMsgShown then begin
        tmrMsg.Enabled := true;
        OvershippedQtyMsgShown:= True;
      end;
    end;
end;

procedure TfmSalesorderInvoice.grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if sameText(Afieldname , QrySaleSOrderInvoiceLinesUOMQty.FieldName) or sameText(Afieldname , QrySaleSOrderInvoiceLinesPQA.FieldName) then
       AFont.Style :=AFont.Style  +[fsbold]
  else begin
    ABrush.Color := $00EDF0F1;//clInactiveCaptionText;
    //AFont.Color := $00737373;
  end;
end;

procedure TfmSalesorderInvoice.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
  DoAllocate;
end;

procedure TfmSalesorderInvoice.grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button <> mbLeft then exit;
  DoAllocate;
end;

procedure TfmSalesorderInvoice.InitSalesOrderInvoice;
begin
  closeDB(QrySalesOrderLines);
  QrySalesOrderLines.ParamByName('SAleID').AsInteger := SaleID;
  OpenDB(QrySalesOrderLines);

  fSalesOrder:= TSalesOrder.Create(Self);
  Try
    fSalesOrder.Connection:= fSalesOrderInvoices.Connection;
    fSalesOrder.BusObjEvent := DoBusinessObjectEvent;
    fSalesOrder.Load(SaleID);


    fSalesOrderInvoices.New;
    fSalesOrderInvoices.InvoicedOn := Now;
    fSalesOrderInvoices.InvoicedBy := appenv.Employee.EmployeeID;
    fSalesOrderInvoices.SalesOrderID := fSalesOrder.ID;
    fSalesOrderInvoices.PostDB;
    fSalesOrderInvoices.Lines;

    fSalesOrder.Lines.IterateRecords(InitSalesOrderInvoiceLines);
  Finally
    Freeandnil(fSalesOrder);
  End;

end;

procedure TfmSalesorderInvoice.InitSalesOrderInvoiceLines(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesOrderLine) then exit;
  if not(TSalesOrderLine(Sender).isTreeItem) then exit;
  fSalesOrderInvoices.Lines.New;
  fSalesOrderInvoices.Lines.SalesOrderLineID := TSalesOrderLine(Sender).ID;
  fSalesOrderInvoices.Lines.ProductId :=TSalesOrderLine(Sender).ProductID;
  fSalesOrderInvoices.Lines.UOMID :=TSalesOrderLine(Sender).UnitOfMeasureID;
  fSalesOrderInvoices.Lines.UOMMultiplier  :=TSalesOrderLine(Sender).UOMMultiplier;
  fSalesOrderInvoices.Lines.Qty       :=0;
  fSalesOrderInvoices.Lines.PostDB;
end;

procedure TfmSalesorderInvoice.mnuAllocationClick(Sender: TObject);
begin
  inherited;
  if (not(fSalesOrderInvoices.Lines.Product.Batch) and not(fSalesOrderInvoices.Lines.Product.MultipleBins) and not(fSalesOrderInvoices.Lines.Product.SnTracking)) then begin
      MessageDlgXP_Vista(fSalesOrderInvoices.lines.productname + ' has none of the allocations  - Batch / Bin / Serial Number tracking - turned on', mtWarning, [mbOK], 0);

      Exit;
  end else if  (fSalesOrderInvoices.Lines.Qty=0) then begin
      MessageDlgXP_Vista('You haven''''t selected a Quantity for the partial shipment', mtWarning, [mbOK], 0);
      Exit;
  end else  if (not(SalesorderhasAllocationforLine(fSalesOrderInvoices.Lines.SalesOrderLineID))) then begin
      MessageDlgXP_vista('Sales Order has no allocation made yet', mtWarning, [mbOK], 0);
      exit;
  end;

  OpenERPFormModal('TfmSalesOrderinvoiceAllocation' , 0 , intSalesOrderinvoiceAllocation);
end;
function TfmSalesorderInvoice.SalesorderhasAllocationforLine(const SalesLineID:Integer):Boolean;
begin
  With fSalesOrderInvoices.GetNewdataset('Select PQAdetails.* ' +
                                        ' from tblsaleslines SL ' +
                                        ' inner join tblpqa pqa on SL.saleId = pqa.transId and pqa.translineId = SL.saleLineid and pqa.transtype = "TSalesOrderLine" ' +
                                        ' inner join `tblPqaDetails` PQAdetails  on PQAdetails .PQAId 	= PQA.PQAID and PQAdetails .Active= "T" ' +
                                        ' Where SL.saleLineId=' + inttostr(SalesLineID), true) do try
    REsult := Recordcount >0;
  finally
    if active then close;
    Free;
  end;
end;
procedure TfmSalesorderInvoice.QrySaleSOrderInvoiceLinesBeforePost(DataSet: TDataSet);
begin
  inherited;
  if abs(QrySaleSOrderInvoiceLinesUOMQty.AsFloat)   > abs(QrySaleSOrderInvoiceLinesQtytoInvoice.AsFloat) then
    QrySaleSOrderInvoiceLinesUOMQty.AsFloat:= QrySaleSOrderInvoiceLinesQtytoInvoice.AsFloat;
end;

procedure TfmSalesorderInvoice.QrySaleSOrderInvoiceLinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  if Dataset.state <> dsCalcFields then exit;
  fSalesOrderInvoices.lines.PQAllocation := '+';
end;

procedure TfmSalesorderInvoice.QrySaleSOrderInvoiceLinesUOMQtyChange(Sender: TField);
begin
  inherited;
  if abs(QrySaleSOrderInvoiceLinesUOMQty.AsFloat)   > abs(QrySaleSOrderInvoiceLinesQtytoInvoice.AsFloat) then begin
    TimerMsg(lblmsg , 'Quantity you Choose to ' + iif(SalesOrderInvoices.SalesOrder.isinternalOrder , 'Place Into Stock' , 'Invoice' ) +
                      ' (' +FloattostrF(QrySaleSOrderInvoiceLinesUOMQty.AsFloat , ffGeneral, 15,2)+') Is More Than The Total Quantity Left to be Invoiced'+
                      ' (' +FloattostrF(QrySaleSOrderInvoiceLinesQtytoInvoice.AsFloat , ffGeneral, 15,2)+').' , 30);
    QrySaleSOrderInvoiceLinesUOMQty.AsFloat:= QrySaleSOrderInvoiceLinesQtytoInvoice.AsFloat;
  end;
end;

procedure TfmSalesorderInvoice.QrySalesOrderLinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrySalesOrderLinesQtytoInvoice.AsFloat :=  QrySalesOrderLinesUnitofMeasureShipped.AsFloat - QrySalesOrderLinesInvoiced.AsFloat;
end;

procedure TfmSalesorderInvoice.intSalesOrderinvoiceAllocation(Sender: TObject);
begin
  if not (Sender is TfmSalesOrderinvoiceAllocation) then exit;
  fSalesOrderInvoices.lines.PostDB;
  TfmSalesOrderinvoiceAllocation(Sender).SalesOrderInvoiceLines := fSalesOrderInvoices.lines;
end;

procedure TfmSalesorderInvoice.Makebuttons;
begin
  cmdClose        := TERPMainSwitchButton.create(Self);with cmdClose        do begin  UseLargeIcon := False; font.size := 9;Parent := pnlButtons;  Left := 134;  Width := 100;  Height := 27;  top := trunc((pnlButtons.height - height)/2); Anchors := [akBottom];  action := actsave        ;  ParentFont := TRue;  TabOrder := 0;  picture := nil; Layout := AdvGlowButton.blGlyphLeft; Default := True; end;
  btnAutoAllocate := TERPMainSwitchButton.create(Self);with btnAutoAllocate do begin  UseLargeIcon := False; font.size := 9;Parent := pnlButtons;  Left := 292;  Width := 100;  Height := 27;  top := cmdclose.top;                          Anchors := [akBottom];  action := actautoAlocate ;  ParentFont := TRue;  TabOrder := 1;  picture := nil; Layout := AdvGlowButton.blGlyphLeft; end;
  btnshipAll      := TERPMainSwitchButton.create(Self);with btnshipAll      do begin  UseLargeIcon := False; font.size := 9;Parent := pnlButtons;  Left := 450;  Width := 100;  Height := 27;  top := cmdclose.top;                          Anchors := [akBottom];  action := actShipAll     ;  ParentFont := TRue;  TabOrder := 2;  picture := nil; Layout := AdvGlowButton.blGlyphLeft; end;
  cmdCancel       := TERPMainSwitchButton.create(Self);with cmdCancel       do begin  UseLargeIcon := False; font.size := 9;Parent := pnlButtons;  Left := 608;  Width := 100;  Height := 27;  top := cmdclose.top;                          Anchors := [akBottom];  action := actclose       ;  ParentFont := TRue;  TabOrder := 3;  picture := nil; Layout := AdvGlowButton.blGlyphLeft; ModalResult := 2;  Cancel := True;  end;
end;
function TfmSalesorderInvoice.DoAllocate:Boolean;
var
    fsFieldname :STring;
begin
Result := False;
  try
    fsFieldname := grdTransactions.GetActiveField.Fieldname;
    if Sysutils.SameText(fsFieldname , 'PQA') then begin
       result := DoProductAllocate;
    end;
  Except
    on E:EXception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

function TfmSalesorderInvoice.Showallocationform:Boolean;
begin
      REsult := True;
      try
        fSalesOrderInvoices.lines.PQAllocation := '-';
        try
          fSalesOrderInvoices.Lines.PostDB;
          TfmAllocation.DoBinBatchform(fSalesOrderInvoices.Lines.PQA, self, AccessLevel>=5, true);
        finally
            fSalesOrderInvoices.lines.PQAllocation := '+';
        End;
      Except
        on E:EXception do begin
          MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
        end;
      end;
end;

initialization
  RegisterClassOnce(TfmSalesorderInvoice);

end.

