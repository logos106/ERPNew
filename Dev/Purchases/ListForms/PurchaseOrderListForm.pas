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
}
unit PurchaseOrderListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, wwcheckbox, BaseListDetails,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;


type
  TPurchaseOrderListGUI = class(TBaseListDetailsGUI)
    btnBOList: TDNMSpeedButton;
    qryMainPurchaseOrderID: TAutoIncField;
    qryMainType: TWideStringField;
    qryMainClientID: TAutoIncField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainContact1: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainConNote: TWideStringField;
    qryMainCustPONumber: TWideStringField;
    qryMainWarehouseNotes: TWideStringField;
    qryMainInvoiceDate: TDateField;
    chkPOCredits: TCheckBox;
    lblApproval: TLabel;
    qryMainApproved: TWideStringField;
    chkShowNonApproved: TCheckBox;
    qryMainOrderDate: TDateField;
    qryMainSaleID: TIntegerField;
    qryMainPaid: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainbaseno: TWideStringField;
    qryMainBOID: TWideStringField;
    qryMainSmartOrder: TIntegerField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainShipToCustomer: TWideStringField;
    grdPOOptions: TwwRadioGroup;
    qryMainFuturePO: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainSupplierName: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure btnBOListClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkPOCreditsClick(Sender: TObject);
    procedure grdPOOptionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkShowNonApprovedClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    procedure FindNonApproved;
    Procedure OpenTransactionSequence;
    Procedure TransactionSequenceBeforeshow(Sender: TObject);
    procedure beforeshowList(Sender: TObject);
    procedure AftershowList(Sender: TObject);

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Function ExpressDetailListName:String;Override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;


implementation

uses frmPurchaseOrders, BackOrderPurchaseListForm, CommonLib,CommonDBLib,DateUtils,
  PurchaseOrderDetailList, tcConst,tcDataUtils,AppEnvironment,BusObjApprovals,
  FastFuncs, TransactionSequence, CommonFormLib;

{$R *.dfm}
{}
procedure TPurchaseOrderListGUI.FindNonApproved;
begin
  lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
  chkShowNonApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;

  if AppEnv.CompanyPrefs.UseApprovalLevels then
  begin
    if chkShowNonApproved.Checked then
      qryMain.Params.ParamByName('Approved').AsString := 'F'
    else
      qryMain.Params.ParamByName('Approved').AsString := 'T';
  end
  else
    qryMain.Params.ParamByName('Approved').AsString := 'F';



(* var
  NonApprovedFound:Boolean;
  qry:TERPQuery;
  SQLstr:string;
  ToDate, FromDate: TDateTime;
begin
  SQLstr := qryMain.SQL.Text;
  NonApprovedFound := False;
  try
    if AppEnv.CompanyPrefs.UseApprovalLevels then begin
      ToDate   := incDay(dtto.DateTime,1);
      FromDate := dtfrom.DateTime;
      qry := CommonDbLib.TempMyQuery;
      try
        qry.SQL.Clear;
        qry.SQL.Add(SQLstr);

        qry.Params.ParamByName('txtfrom').AsDate :=  FromDate;
        qry.Params.ParamByName('txtto').AsDate :=  ToDate;
        qry.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
        qry.Params.ParamByName('Approved').AsString := 'F';
        qryMain.Params.ParamByName('EnteredBy').AsString := AppEnv.Employee.EmployeeName;
        qry.Open;
        qry.First;
        while not qry.Eof do begin
          if qry.FieldByName('Approved').AsString = 'F' then begin
            NonApprovedFound := True;
            break;
          end;
          qry.Next;
        end;

        if NonApprovedFound then begin
          lblApproval.Visible := True;
          chkShowNonApproved.Visible := True;
        end else begin
          lblApproval.Visible := False;
          chkShowNonApproved.Visible := False;
        end;
      finally
        FreeAndNil(qry);
      end;
    end;
  finally

  end; *)
end;

procedure TPurchaseOrderListGUI.FormShow(Sender: TObject);
begin
  FindNonApproved;
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientId,PurchaseOrderID');
//  grdPOOptions.Width := 155;
//  grdPOOptions.Left := btnExpressDetail.Left - 4 - grdPOOptions.Width;
  grpFilters.Width := grdPOOptions.Left - 2 - grpFilters.Left;
  Qrymain.First;
end;

procedure TPurchaseOrderListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
//  grdPOOptions.ItemIndex := GuiPrefs.Node['grdPOOptions.ItemIndex'].AsInteger;
  grpFilters.ItemIndex := GuiPrefs.Node['grpFilters.ItemIndex'].AsInteger;
end;

procedure TPurchaseOrderListGUI.RefreshQuery;
begin

  qryMain.Params.ParamByName('txtfrom').asDatetime:= FilterDateFrom;
  qryMain.Params.ParamByName('txtto').asDateTime := FilterDateTo;

  (*
  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
     else qryMain.Params.ParamByName('Approved').AsString := 'T';
    qryMain.Params.ParamByName('EmployeeApprovalValueH').AsString :=
       FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueH(AppEnv.Employee.EmployeeID,ApprovalTypePurchaseOrder));

    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsString :=
     FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueL(AppEnv.Employee.EmployeeID,ApprovalTypePurchaseOrder));

  end else begin
    qryMain.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsFloat := 0;
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  *)
    qryMain.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsFloat := 0;
//    qryMain.Params.ParamByName('Approved').AsString := 'F';
  //qryMain.Params.ParamByName('EnteredBy').AsString := AppEnv.Employee.EmployeeName;
  FindNonApproved;
  inherited;
end;

procedure TPurchaseOrderListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  PurchaseOrderListGUI := nil;
end;

procedure TPurchaseOrderListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'InvoiceNumber = NULL'; //  AND (IsPO = ''T'')';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalAmountInc < 0';
      end;
    1:
      begin
        GroupFilterString := 'InvoiceNumber <> NULL'; // AND IsPO = ''T'')';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalAmountInc < 0';
      end;
    2:
      begin
        GroupFilterString := 'ShipToCustomer="T"';
        if chkPOCredits.Checked then
          GroupFilterString:= GroupFilterString + ' AND TotalAmountInc < 0';
      end;
    3:
      begin
        if chkPOCredits.Checked then
          GroupFilterString:= 'TotalAmountInc < 0';
      end;
  end;
  inherited;
end;

procedure TPurchaseOrderListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    tmpComponent := GetComponentByClassName('TPurchaseGUI');
    If not Assigned(tmpComponent) then Exit;
    with TPurchaseGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPurchaseOrderListGUI.btnBOListClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
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
  finally
    EnableForm;
  end;  
end;

procedure TPurchaseOrderListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TPurchaseOrderListGUI.RefreshTotals;
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
      TotalEx := TotalEx + qryMainTotalAmount.AsCurrency;
      TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;

  grdMain.ColumnByName('TotalAmountInc').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalAmount').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TPurchaseOrderListGUI.SetGridColumns;
begin
  inherited;
end;

procedure TPurchaseOrderListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
end;

procedure TPurchaseOrderListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('OrderDate') + ' DESC CIS ; ' + QuotedStr('PurchaseOrderID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('PurchaseOrderID') + ' DESC CIS';
end;
{SELECT
tblPurchaseOrders.PurchaseOrderID as PurchaseOrderID,
If(tblPurchaseOrders.IsPO='T','Purchase Order', If(tblPurchaseOrders.IsPOCredit='T','PO Credit','')) as Type,
tblClients.ClientID as ClientID,
tblClients.Company as Company,
tblPurchaseOrders.GlobalRef as GlobalRef,
tblPurchaseOrders.OriginalNo as OriginalNo,
tblPurchaseOrders.PurchaseOrderNumber as "P/O Num",
tblPurchaseOrders.OrderDate as OrderDate,
tblPurchaseOrders.Comments as Comments,
tblPurchaseOrders.ConNote as ConNote,
tblClients.Contact1 as Contact,
tblPurchaseOrders.ETADate as ETADate,
tblClients.Phone as Phone,
tblPurchaseOrders.InvoiceNumber as InvoiceNumber,
tblPurchaseOrders.Deleted as Deleted,
tblPurchaseOrders.SalesComments as WarehouseNotes,
tblPurchaseOrders.TotalAmount as TotalAmount,
Round(tblPurchaseOrders.TotalAmountInc,2) as TotalAmountInc,
tblPurchaseOrders.CustPONumber,
tblPurchaseOrders.InvoiceDate as InvoiceDate
FROM tblPurchaseOrders
LEFT JOIN tblPurchaseLines ON  (tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID)
LEFT JOIN tblClients ON  (tblPurchaseOrders.SupplierName = tblClients.Company)
LEFT JOIN tblParts ON  (tblPurchaseLines.ProductName = tblParts.PARTName)
LEFT Join tblPurchaseOrders original  on Original.PurchaseOrderID =  tblPurchaseOrders.BasePONo
WHERE tblPurchaseLines.Invoiced = 'T' and (tblPurchaseOrders.IsPO='T' OR tblPurchaseOrders.IsPOCredit='T') 
AND tblPurchaseOrders.OrderDate between :txtFrom and :txtTo
GROUP BY tblPurchaseOrders.PurchaseOrderID
}

procedure TPurchaseOrderListGUI.chkPOCreditsClick(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;
procedure TPurchaseOrderListGUI.beforeshowList(Sender: TObject);
begin
  copyParamsto(Sender);
end;
procedure TPurchaseOrderListGUI.AftershowList(Sender: TObject);
begin
  TPurchaseOrderDetailListGUI(Sender).grdPOOptions.ItemIndex := 1;
end;

procedure TPurchaseOrderListGUI.grdPOOptionsClick(Sender: TObject);
begin
  OpenERpListForm('TPurchaseOrderDetailListGUI', beforeshowList , AftershowList);
  CloseWait;
end;

procedure TPurchaseOrderListGUI.chkShowNonApprovedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TPurchaseOrderListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseOrderListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseOrderListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseOrderListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenTransactionSequence;
end;

function TPurchaseOrderListGUI.ExpressDetailListName: String;
begin
  REsult := 'TPurchaseOrderListExpressGUI';
end;

procedure TPurchaseOrderListGUI.OpenTransactionSequence;
begin
  if(Qrymainbaseno.asString = '') and (Qrymainboid.asString = '') then begin 
    MessageDlgXP_Vista('PurchaseOrder # ' +IntToStr(Qrymain.Fieldbyname('PurchaseOrderID').asInteger) +' Has No BackOrder Associated with it' , mtInformation , [mbok],0);
    exit;
  end;
  if FormStillOpen('TTransactionSequenceGUI') then begin
    Try
      TTransactionSequenceGUI(GetComponentByClassName('TTransactionSequenceGUI')).BringToFront;
    Except
        // kill exception
    end;
    MessageDlgXP_Vista('Please Close the Opened Transaction Sequence to Open the Transaction Sequence of ' + 'PurchaseOrder # ' +IntToStr(Qrymain.Fieldbyname('PurchaseOrderID').asInteger) +'.' , mtwarning, [mbok], 0);
    Exit;
  end;
  CreatenOpenERPListForm('TTransactionSequenceGUI' , TransactionSequenceBeforeshow);

end;

procedure TPurchaseOrderListGUI.TransactionSequenceBeforeshow(
  Sender: TObject);
begin
   if not(Sender is TTransactionSequenceGUI) then exit;
   TTransactionSequenceGUI(Sender).Originalglobalref := Qrymain.Fieldbyname('Originalno').AsString;
   TTransactionSequenceGUI(Sender).GlobalRef := Qrymain.Fieldbyname('Globalref').AsString;
   TTransactionSequenceGUI(Sender).Transtype := 'PO'
end;

procedure TPurchaseOrderListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpFilters.ItemIndex'].AsInteger := grpFilters.ItemIndex;
end;

initialization
  RegisterClassOnce(TPurchaseOrderListGUI);

end.

