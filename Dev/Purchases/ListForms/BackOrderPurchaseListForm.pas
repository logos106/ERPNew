{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/04/05  1.00.01 BJ    P/O no shows the PUrchaseOrderNumber of the original PO
                         along with a sequence no for the back orders.
 26/09/05  1.00.01 ISB   Added IgnoreDates And Enable Web Search.
}
unit BackOrderPurchaseListForm;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, BaseInputForm, wwcheckbox,BackorderListBase,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type

  TBackOrderPurchaseListGUI = class(TBackorderListBaseGUI)
    CmdInvoicelist: TDNMSpeedButton;
    qryMainPartName: TWideStringField;
    qryMainLineNotes: TWideMemofield;
    qryMainPurchaseDesc: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainPartCost: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainPARTSID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainETADate: TDateField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainInvoiced: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainCustomerJob: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainPartCostAmount: TFloatField;
    qryMainLineCostAmount: TFloatField;
    qryMainPhone: TWideStringField;
    qryMainCustPONumber: TWideStringField;
    qryMainCustomField1: TWideStringField;
    qryMainCustomField2: TWideStringField;
    qryMainCustomField3: TWideStringField;
    qryMainCustomField4: TWideStringField;
    qryMainCustomField5: TWideStringField;
    qryMainCustomField6: TWideStringField;
    qryMainCustomField7: TWideStringField;
    qryMainCustomField8: TWideStringField;
    qryMainCustomField9: TWideStringField;
    qryMainCustomField10: TWideStringField;
    qryMainOriginalQty: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainApproved: TWideStringField;
    lblApproval: TLabel;
    chkShowNonApproved: TCheckBox;
    qryMainOrderDate: TDateField;
    qryMainContainerName: TWideStringField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    chkHide0LinesQty: TCheckBox;
    qryMainRepairID: TIntegerField;
    qryMainEquipmentname: TWideStringField;
    qryMainForeignTotalLineAmount: TFloatField;
    qryMainConNote: TWideStringField;
    qryMainForeignLineCostAmount: TFloatField;
    qryMainOrderStatus: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainFuturePO: TWideStringField;
    qryMainLeadDays: TLargeIntField;
    qryMainPrintName: TWideStringField;
    qryMainDaysElapsed: TIntegerField;
    qryMainShippingContainerETA: TDateField;
    procedure CmdInvoicelistClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkShowNonApprovedClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure chkHide0LinesQtyClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    procedure FindNonApproved;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    Function ExpressDetailListName:String;Override;
    procedure SetGridColumns; Override;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, PurchaseOrderListForm, frmPurchaseOrders, DateUtils,CommonDBLib,
     Forms,CommonLib, tcDataUtils, FormFactory, busobjOrders,AppEnvironment,BusObjApprovals,
  FastFuncs, ProductQtyLib, Busobjcustomfields;

{$R *.dfm}

procedure TBackOrderPurchaseListGUI.FormShow(Sender: TObject);
begin
  inherited;
  FindNonApproved ;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'PartsId,PurchaseOrderId');
  chkHide0LinesQty.checked := true;
  chkHide0LinesQtyClick(chkHide0LinesQty);
  chkShowNonApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
end;

procedure TBackOrderPurchaseListGUI.FindNonApproved;
begin
  lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
(*        if POLib.FindNonApproved(self) then begin
          lblApproval.Visible := True;
          chkShowNonApproved.Visible := True;
        end else begin
          lblApproval.Visible := False;
          chkShowNonApproved.Visible := False;
        end;*)
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


procedure TBackOrderPurchaseListGUI.CmdInvoicelistClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if not FormStillOpen('TPurchaseOrderListGUI') then begin
    tmpComponent := GetComponentByClassName('TPurchaseOrderListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TPurchaseOrderListGUI(tmpComponent) do begin
      FormStyle := fsMDIChild;
    end;  
  end else begin
    TPurchaseOrderListGUI(FindExistingComponent('TPurchaseOrderListGUI')).show;
  end;
  Self.Close;
end;

procedure TBackOrderPurchaseListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate :=  filterdateFrom;
  qryMain.Params.ParamByName('txtto').AsDate :=  FilterDateto;

  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
    else qryMain.Params.ParamByName('Approved').AsString := 'T';
  end else begin
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  inherited;
  if qryMain.Active then qryMain.First;
  FindNonApproved;
end;

procedure TBackOrderPurchaseListGUI.RefreshTotals;
var
  s: string;
begin
  CalcnShowFooter;
  // reformat foreign total
  s := grdMain.ColumnByName('ForeignLineCostAmount').FooterValue;
  if s <> '' then
    grdMain.ColumnByName('ForeignLineCostAmount').FooterValue :=
      FloatToStrF(StrToFloat(s),ffNumber,15,5);
end;

procedure TBackOrderPurchaseListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainpartsID.fieldname);
  RemoveFieldfromGrid(QrymainsmartorderID.fieldname);
  RemoveFieldfromGrid(QrymainPurchaseLineId.fieldname);
  SetUpcustomFields(
    'CustomField1,CustomField2,CustomField3,' +
    'CustomField4,CustomField5,CustomField6,' +
    'CustomField7,CustomField8,CustomField9,' +
    'CustomField10', ltOrderLines);
end;

procedure TBackOrderPurchaseListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TPurchaseGUI');
  If not Assigned(tmpComponent) then Exit;
  with TPurchaseGUI(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TBackOrderPurchaseListGUI.ExpressDetailListName: String;
begin
  result := 'TBackorderPurchaseOrderExpressGUI';
end;

procedure TBackOrderPurchaseListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('OrderDate') + ' DESC CIS ; ' + QuotedStr('PurchaseOrderID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('PurchaseOrderID') + ' DESC CIS';
end;

procedure TBackOrderPurchaseListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainDaysElapsed.AsInteger := Trunc(Now - qryMainOrderDate.AsDateTime);
end;

procedure TBackOrderPurchaseListGUI.FormCreate(Sender: TObject);
begin
  //NoDateRange := true;
  fbEnableWebSearch := true;
  if Qrymain.active then Qrymain.Close;
  Qrymain.SQL.text:=     StringReplace(StringReplace(StringReplace(Qrymain.SQL.text,
                      '" " as Firstcolumn'  ,Firstcolumn('tblParts') +' as Firstcolumn'  , [rfIgnoreCase]),
                      '" " as Secondcolumn' ,Secondcolumn('tblParts')+' as Secondcolumn' , [rfIgnoreCase]),
                      '" " as Thirdcolumn'  ,Thirdcolumn('tblParts') +' as Thirdcolumn'  , [rfIgnoreCase]);
  qryMainFirstcolumn.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  qryMainSecondcolumn.DisplayLabel:= AppEnv.DefaultClass.Secondcolumn;
  qryMainThirdcolumn.DisplayLabel := AppEnv.DefaultClass.Thirdcolumn;
  inherited;
  AddCalccolumn('BackOrder', False);
  AddCalccolumn('LineCostAmount', true);
  AddCalcColumn('ForeignLineCostAmount',false);
  ShowChartViewOnPopup := True;
end;

procedure TBackOrderPurchaseListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if  (FormFact.Identifier = 'OriginalNo') then
    Popupform.KeyID := TPurchaseOrder.IDToggle(qryMain.Fields.FieldByName(FormFact.Identifier).AsString)
  else inherited;
end;

procedure TBackOrderPurchaseListGUI.chkShowNonApprovedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TBackOrderPurchaseListGUI.grdMainDblClick(Sender: TObject);
begin
(*  if Sysutils.SameText(grdmain.GetActiveField.fieldname, 'SaleID') then
    with CommonDbLib.TempMyQuery do try
      SQL.add('select isInvoice, isSalesOrder, isQuote from tblsales where SaleId = ' + IntToStr(QrymainSaleId.asInteger));
      open;
      if fieldbyname('isInvoice').asboolean then
        SubsequentID := Chr(95) + 'Invoice'
      else if fieldbyname('isInvoice').asboolean then
        SubsequentID := Chr(95) + 'Sales Order'
      else if fieldbyname('isInvoice').asboolean then
        SubsequentID := Chr(95) + 'Quote';
    finally
        if active then close;
        Free;
    end;*)
  inherited;

end;

procedure TBackOrderPurchaseListGUI.chkHide0LinesQtyClick(Sender: TObject);
begin
  if chkHide0LinesQty.checked then GroupFilterString := 'Backorder <> 0' else GroupFilterString := '';
  inherited grpFiltersClick(grpFilters);
end;

initialization
  RegisterClassOnce(TBackOrderPurchaseListGUI);

end.
