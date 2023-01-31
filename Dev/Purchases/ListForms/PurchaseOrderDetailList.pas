{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/04/05  1.00.01 BJ    P/O no shows the PUrchaseOrderNumber of the original PO
                         along with a sequence no for the back orders.
 20/07/05  1.00.02 BJ   The Purchase order now allows to keep an item with a blank ordered
                        Quantity. The list was only showing the records where the received
                        quantity is greater than 0(BOQty >0 goes into the back Order list)
                        The SQl changed to include the POs with Ordered quantity = 0.
                        Note: if a PO contains Products with quantity ordered = 0 and boQty > 0
                        the PO will appear in both PLIST as well as BOLIST.
 31/01/06  1.00.03 IJB  Added "Only Show Negative PO's" check box and logic.
 14/04/07  1.00.04 IJB  Added CustomerJob field
}
unit PurchaseOrderDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, wwdblook,
  wwcheckbox, kbmMemTable,  Shader, DAScript, MyScript, BaseListDetails,CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPurchaseOrderDetailListGUI = class(TBaseListDetailsGUI)
    btnBOList: TDNMSpeedButton;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainLineNotes: TWideMemofield;
    qryMainProduct_Description: TWideStringField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainClass: TWideStringField;
    cboClassQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label5: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    qryMainCustomerJob: TWideStringField;
    qryMainDisplayCat: TLargeintField;
    qryMainOrderDate: TDateTimeField;
    qryMainReceivedDate: TDateField;
    qryMainShipToCustomer: TWideStringField;
    chkPOCredits: TCheckBox;
    grdPOOptions: TwwRadioGroup;
    qryMainLandedCostsPerItem: TFloatField;
    qryMainLandedCostsPercentage: TFloatField;
    qryMainLandedCostsTotal: TFloatField;
    qryMainOrderLineCustomField1: TWideStringField;
    qryMainOrderLineCustomField2: TWideStringField;
    qryMainOrderLineCustomField3: TWideStringField;
    qryMainOrderLineCustomField4: TWideStringField;
    qryMainOrderLineCustomField5: TWideStringField;
    qryMainOrderLineCustomField6: TWideStringField;
    qryMainOrderLineCustomField7: TWideStringField;
    qryMainOrderLineCustomField8: TWideStringField;
    qryMainOrderLineCustomField9: TWideStringField;
    qryMainOrderLineCustomField10: TWideStringField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure btnBOListClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure chkPOCreditsClick(Sender: TObject);
    procedure grdPOOptionsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkAllClassClick(Sender: TObject);
  private
    procedure beforeshowList(Sender: TObject);
    procedure AftershowList(Sender: TObject);
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Function ExpressDetailListName:String;Override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

//var
//  PurchaseOrderListGUI: TPurchaseOrderListGUI;

implementation

uses FastFuncs,frmPurchaseOrders, BackOrderPurchaseListForm, CommonLib,
  PurchaseOrderListForm, MySQLConst, dateUtils, Busobjcustomfields,
  CommonFormLib;

{$R *.dfm}

procedure TPurchaseOrderDetailListGUI.RefreshQuery;
begin
    if cboclassQry.Active = False then cboclassQry.Open;
  if QryMain.Active then Qrymain.close;
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('SELECT 2 as DisplayCat , ');
  Qrymain.SQL.Add('tblPurchaseOrders.PurchaseOrderID as PurchaseOrderID, ');
  Qrymain.SQL.Add('tblPurchaseOrders.ShipToCustomer as ShipToCustomer, ');
  Qrymain.SQL.Add('If(tblPurchaseOrders.IsPO="T","Purchase Order", If(tblPurchaseOrders.IsPOCredit="T","PO Credit","")) as Type, ');
  Qrymain.SQL.Add('tblPurchaseOrders.ClientID as ClientID, ');
  Qrymain.SQL.Add('tblPurchaseOrders.SupplierName as Company, ');
  Qrymain.SQL.Add('tblPurchaseOrders.OriginalNo as OriginalNo, ');
  Qrymain.SQL.Add('"     "  as "P/O Num", ');
  Qrymain.SQL.Add('tblPurchaseOrders.OrderDate as OrderDate, ');
  Qrymain.SQL.Add('tblPurchaseOrders.InvoiceNumber as InvoiceNumber, ');
  Qrymain.SQL.Add('tblPurchaseLines.TotalLineAmount, ');
  Qrymain.SQL.Add('tblPurchaseLines.TotalLineAmountInc, ');
  Qrymain.SQL.Add('tblPurchaseLines.ProductName, ');
  Qrymain.SQL.Add('tblPurchaseLines.LineNotes as LineNotes, ');
  Qrymain.SQL.Add('tblPurchaseLines.Product_Description, ');
  Qrymain.SQL.Add('tblPurchaseLines.UnitofMeasurePOLines, ');
  Qrymain.SQL.Add('tblPurchaseLines.UnitofMeasureQtySold, ');
  Qrymain.SQL.Add('tblPurchaseLines.UnitofMeasureShipped, ');
  Qrymain.SQL.Add('tblPurchaseLines.Class, ');
  Qrymain.SQL.Add('tblPurchaseLines.CustomerJob as CustomerJob, ');
  //Qrymain.SQL.Add('tblpurchaselines.ReceivedDate as ReceivedDate,');
  Qrymain.SQL.Add('date(tblpurchaselines.ReceivedDate) as ReceivedDate,');
  Qrymain.SQL.Add('tblPurchaseLines.LandedCostsPerItem, tblPurchaseLines.LandedCostsPercentage, tblPurchaseLines.LandedCostsTotal,'); // @@@@
  Qrymain.SQL.Add('tblPurchaseLines.CustomField1 as OrderLineCustomField1,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField2 as OrderLineCustomField2,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField3 as OrderLineCustomField3,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField4 as OrderLineCustomField4,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField5 as OrderLineCustomField5,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField6 as OrderLineCustomField6,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField7 as OrderLineCustomField7,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField8 as OrderLineCustomField8,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField9 as OrderLineCustomField9,');
  Qrymain.SQL.Add('tblPurchaseLines.CustomField10 as OrderLineCustomField10');
  Qrymain.SQL.Add('FROM tblPurchaseOrders ');
  Qrymain.SQL.Add('LEFT JOIN tblPurchaseLines ON  (tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID) ');
  Qrymain.SQL.Add('Where tblPurchaseLines.Invoiced = "T" and ');
  Qrymain.SQL.Add('(tblPurchaseOrders.IsPO="T" OR tblPurchaseOrders.IsPOCredit="T") ');
  Qrymain.SQL.Add('AND tblPurchaseOrders.OrderDate between ' + qUOTEDsTR(FormatDateTime(MysqlDateFormat, filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat, incDay(Filterdateto,1))) );
  if chkallClass.checked = False then
    Qrymain.SQL.Add('AND tblPurchaseLines.ClassId  = ' + IntToStr(cboClassQry.fieldByname('ClassId').asInteger) );
  Qrymain.SQL.Add('union All ');
  Qrymain.SQL.Add('SELECT 1 as DisplayCat, ');
  Qrymain.SQL.Add('tblPurchaseOrders.PurchaseOrderID as PurchaseOrderID, ');
  Qrymain.SQL.Add('tblPurchaseOrders.ShipToCustomer as ShipToCustomer, ');
  Qrymain.SQL.Add('If(tblPurchaseOrders.IsPO="T","Purchase Order", If(tblPurchaseOrders.IsPOCredit="T","PO Credit","")) as Type, ');
  Qrymain.SQL.Add('tblPurchaseOrders.ClientID as ClientID, ');
  Qrymain.SQL.Add('tblPurchaseOrders.SupplierName as Company, ');
  Qrymain.SQL.Add('tblPurchaseOrders.OriginalNo as OriginalNo, ');
  Qrymain.SQL.Add('if (original.PurchaseOrderId = tblPurchaseOrders.PurchaseOrderId ,  ');
  Qrymain.SQL.Add('if (ifnull(tblPurchaseOrders.PurchaseOrderNumber ,"-") = "-" , tblPurchaseOrders.PurchaseOrderId , tblPurchaseOrders.PurchaseOrderNumber),  ');
  Qrymain.SQL.Add('concat_ws("",tblPurchaseOrders.PurchaseOrderNumber, "(" , original.PurchaseOrderNumber , "_" , tblPurchaseOrders.SeqNo, ")"))  as "P/O Num", ');
  Qrymain.SQL.Add('tblPurchaseOrders.OrderDate as OrderDate, ');
  Qrymain.SQL.Add('tblPurchaseOrders.InvoiceNumber as InvoiceNumber, ');
  Qrymain.SQL.Add('tblPurchaseOrders.TotalAmount as TotalAmount, ');
  Qrymain.SQL.Add('Round(tblPurchaseOrders.TotalAmountInc,'+intToStr(CurrencyRoundPlaces)+') as TotalAmountInc , ');
  Qrymain.SQL.Add('"   " as ProductName, ');
  Qrymain.SQL.Add('"   " as LineNotes, ');
  Qrymain.SQL.Add('"   " as Product_Description, ');
  Qrymain.SQL.Add('"   " as UnitofMeasurePOLines, ');
  Qrymain.SQL.Add('0 as UnitofMeasureQtySold, ');
  Qrymain.SQL.Add('0 as UnitofMeasureShipped, ');
  Qrymain.SQL.Add('"   " as Class, ');
  Qrymain.SQL.Add('"   " as CustomerJob, ');
  Qrymain.SQL.Add('NULL as ReceivedDate,');
  qryMain.SQL.Add('null as LandedCostsPerItem, null LasndedCostsPercentage, null as LandedCostsTotal,'); //@@@
  Qrymain.SQL.Add('null as OrderLineCustomField1,');
  Qrymain.SQL.Add('null as OrderLineCustomField2,');
  Qrymain.SQL.Add('null as OrderLineCustomField3,');
  Qrymain.SQL.Add('null as OrderLineCustomField4,');
  Qrymain.SQL.Add('null as OrderLineCustomField5,');
  Qrymain.SQL.Add('null as OrderLineCustomField6,');
  Qrymain.SQL.Add('null as OrderLineCustomField7,');
  Qrymain.SQL.Add('null as OrderLineCustomField8,');
  Qrymain.SQL.Add('null as OrderLineCustomField9,');
  Qrymain.SQL.Add('null as OrderLineCustomField10');
  Qrymain.SQL.Add('FROM tblPurchaseOrders ');
  Qrymain.SQL.Add('LEFT JOIN tblPurchaseLines ON  (tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID) ');
  Qrymain.SQL.Add('LEFT Join tblPurchaseOrders as original  on original.GlobalRef =  tblPurchaseOrders.OriginalNo ');
  Qrymain.SQL.Add('Where tblPurchaseLines.Invoiced = "T" and ');
  Qrymain.SQL.Add('(tblPurchaseOrders.IsPO="T" OR tblPurchaseOrders.IsPOCredit="T") ');
  Qrymain.SQL.Add('AND tblPurchaseOrders.OrderDate between ' + QuotedStr(FormatDateTime(MysqlDateFormat, Filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat, incDay(Filterdateto,1))) );
  if chkallClass.checked = False then
    Qrymain.SQL.Add('AND tblPurchaseLines.ClassId  = ' + IntToStr(cboClassQry.fieldByname('ClassId').asInteger) );
  Qrymain.SQL.Add('GROUP BY tblPurchaseOrders.PurchaseOrderID ');
  Qrymain.SQL.Add('Order by OrderDate desc , PurchaseOrderID desc , DisplayCat ');
  inherited;
end;

procedure TPurchaseOrderDetailListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  PurchaseOrderListGUI := nil;
end;

procedure TPurchaseOrderDetailListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:begin
        GroupFilterString := 'InvoiceNumber = NULL'; //  AND (IsPO = ''T'')';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalLineAmountInc < 0';
      end;
    1:begin
        GroupFilterString := 'InvoiceNumber <> NULL'; // AND IsPO = ''T'')';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalLineAmountInc < 0';
      end;
    2:begin
        GroupFilterString := 'ShipToCustomer="T"'; // AND IsPO = ''T'')';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalLineAmountInc < 0';
      end;
    3:begin
        if chkPOCredits.Checked then
          GroupFilterString:= 'TotalLineAmountInc < 0';
      end;
  end;
  inherited;
end;

procedure TPurchaseOrderDetailListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  tmpComponent := GetComponentByClassName('TPurchaseGUI');
  If not Assigned(tmpComponent) then Exit;
  with TPurchaseGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TPurchaseOrderDetailListGUI.ExpressDetailListName: String;
begin
  REsult := 'TPurchaseOrderListExpressGUI';
end;

procedure TPurchaseOrderDetailListGUI.btnBOListClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if not FormStillOpen('TBackOrderPurchaseListGUI') then begin
    tmpComponent := GetComponentByClassName('TBackOrderPurchaseListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TBackOrderPurchaseListGUI(tmpComponent) do begin
      FormStyle :=fsMDIChild;
    end;
  end else begin
    TBackOrderPurchaseListGUI(FindExistingComponent('TBackOrderPurchaseListGUI')).show;
  end;
  Self.Close;
end;

procedure TPurchaseOrderDetailListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TPurchaseOrderDetailListGUI.RefreshTotals;
var
  TotalInc, TotalEx: double;
  bm: TBookmark;
begin
  TotalInc := 0.00;
  TotalEx := 0.00;
  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
        if qryMainDisplayCat.AsInteger = 1 then begin
            TotalEx := TotalEx + qryMainTotalLineAmount.AsCurrency;
            TotalInc := TotalInc + qryMainTotalLineAmountInc.AsCurrency;
        end;
        Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;

  grdMain.ColumnByName('TotalAmountInc').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalAmount').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TPurchaseOrderDetailListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields(
    'OrderLineCustomField1,OrderLineCustomField2,OrderLineCustomField3,' +
    'OrderLineCustomField4,OrderLineCustomField5,OrderLineCustomField6,' +
    'OrderLineCustomField7,OrderLineCustomField8,OrderLineCustomField9,' +
    'OrderLineCustomField10', ltOrderLines);
end;

procedure TPurchaseOrderDetailListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
end;

procedure TPurchaseOrderDetailListGUI.chkPOCreditsClick(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;
procedure TPurchaseOrderDetailListGUI.beforeshowList(Sender: TObject);
begin
  copyParamsto(Sender);
end;
procedure TPurchaseOrderDetailListGUI.AftershowList(Sender: TObject);
begin
  TPurchaseOrderListGUI(Sender).grdPOOptions.ItemIndex := 0;
end;

procedure TPurchaseOrderDetailListGUI.grdPOOptionsClick(Sender: TObject);
begin
  OpenERpListForm('TPurchaseOrderListGUI', beforeshowList , AftershowList);
  CloseWait;
end;

procedure TPurchaseOrderDetailListGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin

  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
    if Qrymain.fieldbyname('DisplayCat').asInteger = 2 then begin
        (*if (Field.FieldName ='Type' ) or
            (Field.FieldName ='Company' ) or
            (Field.FieldName ='OriginalNo' ) or
            (Field.FieldName ='PONum' ) or
            (Field.FieldName ='OrderDate' ) or
            (Field.FieldName ='InvoiceNumber') then
                AFont.Color := ABrush.color;*)
    end else begin
        if (Field.FieldName ='ProductName' ) or
            (Field.FieldName ='Product_Description' ) or
            (Field.FieldName ='UnitofMeasurePOLines' ) or
            (Field.FieldName ='UnitofMeasureQtySold' ) or
            (Field.FieldName ='UnitofMeasureShipped' ) then
                AFont.Color := ABrush.color;
(*        if (Field.FieldName ='TotalLineAmount' ) or
            (Field.FieldName ='TotalLineAmountInc' ) then*)
                grdMain.Canvas.Font.Style := grdMain.Canvas.Font.Style + [fsBold];
    end;
end;

procedure TPurchaseOrderDetailListGUI.actExecuteFilterExecute(
  Sender: TObject);
begin
  inherited;
    Qrymain.Filtered := False;
    if Qrymain.filter <> '' then Qrymain.filter := '(' + Qrymain.filter + ') or ( DisplayCat=1)';
    Qrymain.Filtered := True;
end;

procedure TPurchaseOrderDetailListGUI.cboClassCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
   chkAllclass.Checked := False;
  RefreshQuery;
end;

procedure TPurchaseOrderDetailListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked then cboClass.Text := '';
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TPurchaseOrderDetailListGUI);

end.
