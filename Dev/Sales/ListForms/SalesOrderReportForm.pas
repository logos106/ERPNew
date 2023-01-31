unit SalesOrderReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwdbdatetimepicker, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents, ProgressDialog,
  busobjPQA, wwdblook, kbmMemTable, Shader, DNMAction, IntegerListObj,
  DAScript, MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TSalesOrderReportGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainTransactionType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainProductType: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainType: TWideStringField;
    qryMainManufacturer: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainLinePriceEx: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainLineTax: TFloatField;
    qryMainShipped: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainCustomerType: TWideStringField;
    qryMainLineTotalEx: TFloatField;
    qryMainLineTotalInc: TFloatField;
    qryMainPreferedSupplier: TWideStringField;
    qryMainSalesOrderNumber: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainWarrantyPeriod: TWideStringField;
    qryMainWarrantyEndsOn: TDateField;
    qryMainConverted: TWideStringField;
    qryMainLineShipDate: TDateTimeField;
    qryMainContainerName: TWideStringField;
    qryMainContainerETD: TDateField;
    qryMainContainerETA: TDateField;
    qryMainShippingContainerID: TIntegerField;
    qryMaincustfld1: TWideStringField;
    qryMaincustfld2: TWideStringField;
    qryMaincustfld3: TWideStringField;
    qryMaincustfld4: TWideStringField;
    qryMaincustfld5: TWideStringField;
    qryMaincustfld6: TWideStringField;
    qryMaincustfld7: TWideStringField;
    qryMaincustfld8: TWideStringField;
    qryMaincustfld9: TWideStringField;
    qryMaincustfld10: TWideStringField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainHeight: TFloatField;
    qryMainWidth: TFloatField;
    qryMainLength: TFloatField;
    qryMainWeight: TFloatField;
    qryMainVolume: TFloatField;
    qryMainQtySold: TFloatField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainFutureSO: TWideStringField;
    btnMergeToInvoice: TDNMSpeedButton;
    qryMainStatus: TWideStringField;
    ActionList1: TActionList;
    actInvoice: TDNMAction;
    qryMainProductPrintName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure btnMergeToInvoiceClick(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
    procedure SetGridColumns; override;
  private
    invIdsList:TIntegerList;
    saleId:Integer;
    Function  DoProductallocation(const LineObj :TProdQty):Boolean ;
    procedure ValidateSelectionforConversion;
    procedure Convertso;

  public
    { Public declarations }
  end;

implementation

uses FastFuncs,  frmSalesOrder, CommonLib, Forms,
  AppEnvironment, tcConst, BusObjSales,  frmInvoice, frmAllocation, CommonDbLib,
  BusObjBase, ProcessDataUtils, SalesOrderLib, Busobjcustomfields;

{$R *.dfm}

procedure TSalesOrderReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Converted <> ' + QuotedStr('T');
    1:  GroupFilterString := 'FutureSo  =  ' + QuotedStr('T');
    2:  GroupFilterString := 'Converted =  ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TSalesOrderReportGUI.RefreshQuery;
begin
  //qryMain.Params.ParseSQL(qryMain.SQL.Text, true);
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
  (*qryMain.FieldByName('Product Name').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  qryMainDepartment.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  qryMainType.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  qryMainManufacturer.DisplayLabel := AppEnv.DefaultClass.FirstColumn;

  grdMain.columnbyName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
  grdMain.columnbyName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
  grdMain.columnbyName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;*)
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib2Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRate');

    {Showing/hiding the warranty fields based on the preference
  change the caption of the warranty fields based on the Preference}
  if AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn = false then grdMain.RemoveField('WarrantyEndsOn');
  if AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod = false then grdMain.RemoveField('WarrantyPeriod');
  if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then grdMain.ColumnByName('WarrantyEndsOn').DisplayLabel := Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption)
  else grdMain.ColumnByName('WarrantyEndsOn').DisplayLabel := 'Warranty Ends On';
  if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then grdMain.ColumnByName('WarrantyPeriod').DisplayLabel := Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption)
  else grdMain.ColumnByName('WarrantyPeriod').DisplayLabel := 'Warranty Period';
  RefreshTotals;
end;
procedure TSalesOrderReportGUI.Convertso;
var
  SaleIDs:String;
  invId:Integer;
begin
  SaleIDs:= selectedIds('SaleId' , true);
  if SaleIds= '' then exit;
  with TempMyQuery do try
    SQL.add('Select SaleID from tblSales where saleId in (' +SaleIds+')');
    open;
    if recordcount =0 then exit;
    first;
    invIdsList:= TIntegerList.create;
    try
      while Eof = False do begin
        invId:= SalesOrderlib.ConvertSo(QrymainSaleID.asInteger, self , DoProductallocation);
        if invId<> 0 then invIdsList.add(invId);
        Next;
      end;
    finally
      if invIdsList.count>0 then
        MessageDlgXP_Vista('Invoice(s) Created for ' + inttostr(invIdsList.count)+ ' Sales Order(s).', mtInformation, [mbOK], 0);
      FreeandNil(invIdsList);
    end;

  finally
    ClosenFree;
  end;
end;
procedure TSalesOrderReportGUI.ValidateSelectionforConversion;
var
  SaleIDs:String;
  errMsg:String;
begin
  SaleIDs:= selectedIds('SaleId' , true);
  if SaleIds= '' then exit;
  with TempMyQuery do try
    SQL.add('Select SaleID from tblSales where saleId in (' +SaleIds+')');
    open;
    if recordcount =0 then exit;
    first;
    while Eof = False do begin
        saleId:=fieldbyname('SaleId').asInteger;
        if not  SalesorderLib.IsOkToconvert(saleId, errMsg) then begin
          if errMsg<> '' then MessageDlgXP_Vista(ErrMsg, mtWarning, [mbOK], 0);
          IterateProcNo := 3;
          IterateselectedRecordsReverse(true, WaitMsg);
        end;
        Next;
    end;
  finally
    ClosenFree;
  end;
end;
procedure TSalesOrderReportGUI.actInvoiceExecute(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    if grdMain.SelectedList.Count < 1 then begin
        CommonLib.MessageDlgXP_Vista(
                'You must at least pick one sales order before converting to an invoice.  Hold down the Ctrl Key and left click with your mouse to choose orders',
                mtInformation, [mbOK], 0);
        Exit;
    end;
    ValidateSelectionforConversion;
    if grdMain.SelectedList.Count < 1 then exit;
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert all selected sales Order(s) to invoice(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;
    Convertso;
  finally
    EnableForm;
  end;
end;
procedure TSalesOrderReportGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
    if IterateProcNo = 3 then begin
      if QrymainSaleId.asInteger = SAleId then grdmain.unselectrecord;
    end;
end;

procedure TSalesOrderReportGUI.btnMergeToInvoiceClick(Sender: TObject);
begin
(* var
  SalesIDs: String;
  SalesOrder :TSalesOrder;
  InvoiceID :Integer;
  frm : TInvoiceGUI;
begin
  DisableForm;
  try
    if grdmain.selectedlist.count = 1 then
      if SaleContainsManufacturing(QrymainSaleId.asInteger , Qrymain.connection) then begin
         MessageDlgXP_Vista('Can not convert to Invoice as this sale contains production items.',mtInformation,[mbOk],0);
         exit;
      end;
    if grdMain.SelectedList.Count < 1 then begin
        CommonLib.MessageDlgXP_Vista(
                'You must at least pick one sales order before converting to an invoice.  Hold down the Ctrl Key and left click with your mouse to choose orders',
                mtInformation, [mbOK], 0);
        Exit;
    end;

    if CommonLib.MessageDlgXP_Vista(
      'Are you sure you want to convert to an invoice?',mtInformation, [mbYes,mbNo], 0) = mrNo then
      Exit;


    SalesIDs     := '';
    qryMain.DisableControls;
    try
        qryMain.First;
        while not qryMain.Eof do begin
            if grdMain.IsSelectedRecord then begin
                if SalesIDs <> '' then SalesIDs := SalesIDs +',' ;
                SalesIDs:= SalesIDs + qryMain.FieldByName('SaleID').AsString;
            end;
            Qrymain.next;
        end;
    finally
        Qrymain.EnableControls;
    end;

    SalesOrder := TSalesOrder.Create(Self);
    Try
        SalesOrder.DoProductallocation:= DoProductallocation;
        SalesOrder.connection := Tmydacdataconnection.create(SalesOrder);
        SalesOrder.connection.connection := commondblib.GetNewMyDacConnection(self);
        InvoiceID := SalesOrder.MergeSalesOrders(SalesIDs);
    finally
        FreeandNil(SalesOrder);
    end;
    if InvoiceID <> 0 then begin
        frm := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
        If Assigned(frm) then Begin
            frm.KeyID     := InvoiceID;
            frm.FormStyle := fsMDIChild;
            frm.Bringtofront;
        end;
    end;
  finally
    EnableForm;
  end; *)
end;

procedure TSalesOrderReportGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TSalesOrderGUI');
  if not Assigned(tmpComponent) then Exit;
  with TSalesOrderGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TSalesOrderReportGUI.DoProductallocation(const LineObj: TProdQty): Boolean;
begin
  LineObj.postdb;
  Result := TfmAllocation.DoBinBatchform(LineObj.PQA, nil );
end;

procedure TSalesOrderReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Transaction Type').AsString);
  inherited;
end;

procedure TSalesOrderReportGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;  Selecting: Boolean; var Accept: Boolean);
begin
(* var
  iSelectedID: integer;
  iActiveRow: integer;
begin
  inherited;
  iSelectedID := qryMain.FieldByName('ClientID').AsInteger;
  iActiveRow := grdMain.GetActiveRow;

  if (qryMain.FieldByName('Converted').AsString = 'T') then begin
    //Removed Message Because DblClick on Converted SO Showed This Message Before Openning, Stopping DblClick
    //CommonLib.MessageDlgXP_Vista('You cannot multi select converted sales orders.', mtInformation, [mbOK], 0);
    Accept := false;
    grdMain.SetActiveRow(iActiveRow);
    Exit;
  end else begin
    Accept := true;
  end;

  if grdMain.SelectedList.Count > 0 then begin
    qryMain.DisableControls;
    qryMain.GotoBookmark(grdMain.SelectedList.Items[0]);
    if (iSelectedID <> qryMain.FieldByName('ClientID').AsInteger) then begin
      Accept := false;
      CommonLib.MessageDlgXP_Vista('Can''t merge two different Customers into one Invoice!', mtInformation, [mbOK], 0);
    end else begin
      if SaleContainsManufacturing(QrymainSaleId.asInteger , Qrymain.connection) then begin
         MessageDlgXP_Vista('Can not convert to Invoice as this sale contains production items.',mtInformation,[mbOk],0)
      end else begin
        Accept := true;
        grdMain.SetActiveRow(iActiveRow);
      end;
    end;
    qryMain.EnableControls;
  end; *)
end;

procedure TSalesOrderReportGUI.RefreshTotals;
var
  TotalEx, TotalInc, Tax, TotalShipped: double;
begin
  TotalEx := 0;
  TotalShipped:= 0;
  TotalInc := 0;
  Tax := 0;

  with qryMain do begin
    First;
    while not Eof do begin
      TotalEx := TotalEx + qryMainLineTotalEx.AsCurrency;
      TotalShipped := TotalShipped + qryMainShipped.asfloat;
      TotalInc := TotalInc + qryMainLineTotalInc.AsCurrency;
      Tax := Tax + qryMainLineTax.AsCurrency;
      Next;
    end;
  end;
  grdMain.ColumnByName('Line Total (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Line Total (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Line Tax').FooterValue := FloatToStrF(Tax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Shipped').FooterValue := FloatToStrF(TotalShipped, ffGeneral, 15, 2);
end;

procedure TSalesOrderReportGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('custfld1,custfld2,custfld3,custfld4,custfld5,custfld6,custfld7,custfld8,custfld9,custfld10',
    ltSaleslines);
end;

procedure TSalesOrderReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TSalesOrderReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ShippingContainerID');
end;

initialization
  RegisterClassOnce(TSalesOrderReportGUI);
end.
