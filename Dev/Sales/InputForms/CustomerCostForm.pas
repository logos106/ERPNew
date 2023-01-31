unit CustomerCostForm;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 03/06/05  1.00.01 IJB  Changed PopulateClientDataset to remove GST from pay
  //                        rate costs (no GST involved when paying employee).
  // 14/06/05  1.00.02 IJB  Modified to show 'Docket Number' in Products tab if
  //                        AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales enabled.
  // 18/07/05  1.00.03 IJB  Modified to record salelineID in timesheet so Job
  //                        Analysis (profitability) can use amounts from invoice.
  // 27/07/05  1.00.04 BJ   POs where the chipped qty=0 should not be listed for the costs.
  // 23/08/05  1.00.05 DSP  Added functionality to assess customer costs by
  //                        including customer costs transfers in the calculation.
  //                        A memory table is now used in place of the query table
  //                        for product costs.
  // 24/08/05  1.00.06 DSP  Now calculates value for the LineTax field using the
  //                        product quantity.
  // 30/08/05  1.00.07 DSP  Placed chkSbhowBO and Label1 on a panel so they were
  //                        positioned correctly when the form is maximised.
  // 20/09/05  1.00.07 ISB  Fixed Save With No Data
  // 23/09/05  1.00.07 ISB  cdsResults not Open ??
  // 19/12/05  1.00.08  AL   Removed "Instance", added RegisterClass  *Task306*
  // 16/03/06  1.00.09  AL  Changed qryUpdate from TERPQuery to TERPQuery to keep
  //                        all data changes in one transaction


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  DBCtrls, ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, Grids, Wwdbigrd, Wwdbgrid,
  kbmMemTable, Buttons, DNMSpeedButton, MyAccess,ERPdbComponents, DBAccess, DataState, wwcheckbox,
  Menus, AdvMenus, MemDS, Shader, Forms, ImgList, ProgressDialog;

const
  SX_CalcProductTotalsMsg   = WM_USER + 100;
  SX_CalcPerformExpensesMsg = WM_USER + 110;
  SX_CalcPerformPayrollMsg  = WM_USER + 120;

type
  TCustomerCostGUI = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlDetail: TDNMPanel;
    pnlFooter: TDNMPanel;
    pgeCosts: TPageControl;
    tabProducts: TTabSheet;
    tabExpenses: TTabSheet;
    grdProductCosts: TwwDBGrid;
    dsProducts: TDataSource;
    pnlCustomer: TPanel;
    grdCostExpenses: TwwDBGrid;
    qryExpenseCosts: TERPQuery;
    dsExpenseCosts: TDataSource;
    cdsResults: TkbmMemTable;
    cdsResultsUseTimeCost: TWideStringField;
    cdsResultsOrderDate: TDateField;
    cdsResultsProductName: TWideStringField;
    cdsResultsProductID: TIntegerField;
    cdsResultsProduct_Description: TWideStringField;
    cdsResultsShipped: TFloatField;
    cdsResultsLineCost: TFloatField;
    cdsResultsLineTax: TFloatField;
    cdsResultsLineTaxCode: TWideStringField;
    cdsResultsLineCostInc: TFloatField;
    cdsResultsTotalLineAmount: TFloatField;
    cdsResultsPurchaseLineID: TAutoIncField;
    cdsResultsSaleID_TimeCost: TIntegerField;
    cdsResultsTimeCostPrice: TFloatField;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    tabTimesheet: TTabSheet;
    dsPayrollCosts: TDataSource;
    qryPayrollCosts: TERPQuery;
    grdCostPayroll: TwwDBGrid;
    qryPayrollCostsUseTimeCost: TWideStringField;
    qryPayrollCostsType: TWideStringField;
    qryPayrollCostsDate: TDateField;
    qryPayrollCostsService: TWideStringField;
    qryPayrollCostsName: TWideStringField;
    qryPayrollCostsAmount: TFloatField;
    qryPayrollCostsCost: TFloatField;
    qryPayrollCostsID: TAutoIncField;
    qryPayrollCostsPartID: TIntegerField;
    qryPayrollCostsPartName: TWideStringField;
    cdsResultsEntryType: TWideStringField;
    btnPrint: TDNMSpeedButton;
    cdsResultsPurchaseOrderNumber: TWideStringField;
    qryPayrollCostsSalesID: TIntegerField;
    qryPayrollCostsHours: TFloatField;
    btnSelectAll: TDNMSpeedButton;
    cdsResultsDocketNumber: TWideStringField;
    cdsResultsSaleLineID: TIntegerField;
    tblProductCosts: TkbmMemTable;
    tblProductCostsPurchaseLineID: TIntegerField;
    tblProductCostsUseTimeCost: TBooleanField;
    tblProductCostsPurchaseOrderNumber: TWideStringField;
    tblProductCostsDate: TDateTimeField;
    tblProductCostsProductName: TIntegerField;
    StringField1: TWideStringField;
    tblProductCostsProductDescription: TWideStringField;
    tblProductCostsQuantity: TFloatField;
    tblProductCostsLineCost: TCurrencyField;
    tblProductCostsLineTax: TCurrencyField;
    tblProductCostsLineTaxCode: TWideStringField;
    tblProductCostsLineCostInc: TCurrencyField;
    tblProductCostsTotalLineAmount: TFloatField;
    tblProductCostsSaleID_TimeCost: TCurrencyField;
    tblProductCostsTimeCostPrice: TCurrencyField;
    tblProductCostsDocketNumber: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkShowBO: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    LookupPurchaseOrders: TERPQuery;
    LookupPurchaseOrdersPurchaseOrderNumber: TWideStringField;
    LookupPurchaseOrdersPurchaseLineID: TIntegerField;
    LookupPurchaseOrdersUseTimeCost: TWideStringField;
    LookupPurchaseOrdersType: TWideStringField;
    LookupPurchaseOrdersSupplierName: TWideStringField;
    LookupPurchaseOrdersLineCost: TFloatField;
    LookupPurchaseOrdersLineTax: TFloatField;
    LookupPurchaseOrdersLineCostInc: TFloatField;
    LookupPurchaseOrdersTotalLineAmount: TFloatField;
    LookupPurchaseOrdersSaleID_TimeCost: TIntegerField;
    LookupPurchaseOrdersTimeCostPrice: TFloatField;
    LookupPurchaseOrdersPurchaseOrderID: TIntegerField;
    qryExpenseCostsSaleID_TimeCost: TIntegerField;
    qryExpenseCostsPurchaseLineID: TIntegerField;
    qryExpenseCostsUseTimeCost: TWideStringField;
    qryExpenseCostsTimeCostPrice: TFloatField;
    qryExpenseCostsPurchaseOrderId: TIntegerField;
    qryExpenseCostsType: TWideStringField;
    qryExpenseCostsSupplierName: TWideStringField;
    qryExpenseCostsLineCost: TFloatField;
    qryExpenseCostsLineTax: TFloatField;
    qryExpenseCostsLineCostInc: TFloatField;
    qryExpenseCostsTotalLineAmount: TFloatField;
    qryExpenseCostsOrderDate: TDateTimeField;
    LookupPurchaseOrdersOrderDate: TDateTimeField;
    qryPayrollCostsEquipmentName: TWideStringField;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure chkShowBOClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pgeCostsChange(Sender: TObject);
    procedure qryExpenseCostsBeforePost(DataSet: TDataSet);
    procedure qryExpenseCostsTimeCostPriceChange(Sender: TField);
    procedure qryExpenseCostsUseTimeCostChange(Sender: TField);
    procedure qryPayrollCostsUseTimeCostChange(Sender: TField);
    procedure tblProductCostsUseTimeCostChange(Sender: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FeldSetTextDontAllowNulls(Sender: TField;const Text: String);override;
  private
    foOwner: TObject;
    fiCustomerID: integer;
    fsCustomerName: string;
    function ValidExpenseLines: boolean;
    procedure PerformExpensesCalcTotals(var Msg: TMessage); message SX_CalcPerformExpensesMsg;
    procedure PerformPayrollCalcTotals(var Msg: TMessage); message SX_CalcPerformPayrollMsg;
    procedure PerformProductsCalcTotals(var Msg: TMessage); message SX_CalcProductTotalsMsg;
    procedure PopulateClientDataset;
    procedure PopulateProductCostsTable;
    procedure SaveUseTimeCostFlags;
    procedure SetUseTimeCostFlags(const qryUpdate: TERPQuery);
    procedure ShowHideBO(ShowBO: boolean);
    function  Getconnection :TERPConnection;
  public

    property CustomerID: integer read fiCustomerID write fiCustomerID;
    property CustomerName: string read fsCustomerName write fsCustomerName;
    property CustomerCostOwner: TObject read foOwner write foOwner;
    procedure UpdateTablesFromClientDataset;
  end;

implementation

uses FastFuncs,DNMExceptions, CommonDbLib, frmInvoice,
      CommonLib, AppEnvironment, tcConst;

{$R *.dfm}

procedure TCustomerCostGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if Assigned(foOwner) then begin
        qryExpenseCosts.Connection := Getconnection;//TBaseInputGUI(foOwner).MyConnection;
        qryPayrollCosts.Connection := Getconnection;//TBaseInputGUI(foOwner).MyConnection;
      end;

      qryExpenseCosts.ParamByName('xCustomerJobID').asInteger := fiCustomerID;
      qryExpenseCosts.ParamByName('xSaleID').asInteger        := KeyID;

      LookupPurchaseOrders.ParamByName('xCustomerJobID').asInteger := fiCustomerID;
      LookupPurchaseOrders.ParamByName('xSaleID').asInteger        := KeyID;

      qryPayrollCosts.ParamByName('xJobID').asInteger := fiCustomerID;
      qryPayrollCosts.ParamByName('xJobID2').asInteger := fiCustomerID;
      qryPayrollCosts.ParamByName('xSaleID').asInteger := KeyID;

      if not AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales then begin
        grdProductCosts.RemoveField('DocketNumber');
      end;

      OpenQueries;
      pnlCustomer.Caption := fsCustomerName;
      pgeCosts.ActivePage := TTabSheet(tabProducts);
      try
        ConnectionFormReport := TInvoiceGUI(FindExistingComponent('TInvoiceGUI')).Myconnection;
      Except
      end;
      PopulateProductCostsTable;
      chkShowBO.Checked := AppEnv.CompanyPrefs.AlwaysShowBOonCustomerCost;
      tblProductCostsDate.DisplayFormat:= AppEnv.RegionalOptions.ShortDateformat;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      on e: Exception do raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TCustomerCostGUI.PerformPayrollCalcTotals(var Msg: TMessage);
var
  dCost, dTotalLineAmt: double;
  bm: TBookmark;

  procedure InitializeVariables;
  begin
    dCost := 0;
    dTotalLineAmt := 0;
  end;
begin //==>>PerformPayrollCalcTotals
  InitializeVariables;
  with qryPayrollCosts do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if FieldByName('UseTimeCost').AsBoolean then begin
        dCost := dCost + (FieldByName('Cost').AsFloat * FieldByName('Hours').AsFloat);
        dTotalLineAmt := dTotalLineAmt + (FieldByName('Amount').AsFloat * FieldByName('Hours').AsFloat);
      end;

      // Fetch next record.
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;

  grdCostPayroll.ColumnByName('Cost').FooterValue := FloatToStrF(dCost, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostPayroll.ColumnByName('Amount').FooterValue := FloatToStrF(dTotalLineAmt, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustomerCostGUI.PerformExpensesCalcTotals(var Msg: TMessage);
var
  dCostEx, dCostInc, dTax, dTotalLineAmt, dTotalPriceEx: double;
  bm: TBookmark;

  procedure InitializeVariables;
  begin
    dCostEx := 0;
    dTax := 0;
    dCostInc := 0;
    dTotalLineAmt := 0;
    dTotalPriceEx := 0;
  end;
begin //==>>PerformExpensesCalcTotals
  InitializeVariables;
  with qryExpenseCosts do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if qryExpenseCostsUseTimeCost.AsBoolean then begin
        dCostEx := dCostEx + qryExpenseCostsLineCost.AsCurrency;
        dCostInc := dCostInc + qryExpenseCostsLineCostInc.AsCurrency;
        dTotalLineAmt := dTotalLineAmt + qryExpenseCostsTotalLineamount.AsCurrency;
        dTax := dTax + qryExpenseCostsLineTax.AsCurrency;
        dTotalPriceEx := dTotalPriceEx + qryExpenseCostsTimeCostPrice.AsCurrency;
      end;
      // fetch next record.
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;

  grdCostExpenses.ColumnByName('LineCost').FooterValue := FloatToStrF(dCostEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('LineTax').FooterValue := FloatToStrF(dTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('LineCostInc').FooterValue := FloatToStrF(dCostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('TotalLineAmount').FooterValue := FloatToStrF(dTotalLineAmt, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('TimeCostPrice').FooterValue := FloatToStrF(dTotalPriceEx, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustomerCostGUI.PerformProductsCalcTotals(var Msg: TMessage);
var
  dCostEx, dCostInc, dTax, dTotalLineAmt: double;
  bm: TBookmark;

  procedure InitializeVariables;
  begin
    dCostEx := 0;
    dTax := 0;
    dCostInc := 0;
    dTotalLineAmt := 0;
  end;
begin //---->> PerformProductsCalcTotals
  InitializeVariables;
  with tblProductCosts do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if tblProductCostsUseTimeCost.AsBoolean then begin
        dCostEx := dCostEx + tblProductCostsLineCost.AsCurrency;
        dCostInc := dCostInc + tblProductCostsLineCostInc.AsCurrency;
        dTotalLineAmt := dTotalLineAmt + tblProductCostsTotalLineAmount.AsCurrency;
        dTax := dTax + tblProductCostsLineTax.AsCurrency;
      end;
      Next;
    end;

    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;

  grdProductCosts.ColumnByName('LineCost').FooterValue := FloatToStrF(dCostEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdProductCosts.ColumnByName('LineTax').FooterValue := FloatToStrF(dTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdProductCosts.ColumnByName('LineCostInc').FooterValue := FloatToStrF(dCostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdProductCosts.ColumnByName('TotalLineAmount').FooterValue := FloatToStrF(dTotalLineAmt, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustomerCostGUI.PopulateClientDataset;
var
  i: integer;
  dSumOfTotalEx, dSumOfTotalCostEx, dSumOfTotalCostInc: double;
  //dtMinDate, dtMaxDate: TDateTime;
  dTimeCostPrice, dLineCostInc, dLineCostEx, dHours: double;

  function GetTimeCostPartID: integer;
  begin
    Result := 0;
    with TERPQuery.Create(Self) do try
        Options.FlatBuffers := True;
        Connection := CommonDbLib.GetSharedMyDacConnection;
        Sql.Add('SELECT PartsID FROM tblParts WHERE PartName = "Time/Cost Exp";');
        Open;
        if not IsEmpty then begin
          Result := FieldByName('PartsID').AsInteger;
        end;
      finally
        Free;
      end;
  end;
begin //====>> TCustomerCostGUI.PopulateClientDataset;
  dSumOfTotalEx := 0;
  dSumOfTotalCostEx := 0;
  dSumOfTotalCostInc := 0;
  dTimeCostPrice := 0;
  dLineCostInc := 0;
  dLineCostEx := 0;
  dHours := 0;
  with qryPayrollCosts do begin
    First;
    while not Eof do begin
      if not AppEnv.PayPrefs.SummariseTSForInvoiceCost then begin
        if (qryPayrollCostsUseTimeCost.AsBoolean) then begin
          cdsResults.Open;
          cdsResults.Insert;
          cdsResultsEntryType.AsString := 'Timesheet';
          cdsResultsSaleID_TimeCost.AsInteger := qryPayrollCostsID.AsInteger;
          if not (qryPayrollCostsPartID.AsInteger = 0) then begin
            cdsResultsProductID.AsInteger := qryPayrollCostsPartID.AsInteger;
            cdsResultsProductName.AsString := qryPayrollCostsPartName.AsString;
          end else begin
            cdsResultsProductID.AsInteger := GetTimeCostPartID;
            cdsResultsProductName.AsString := 'Time/Cost Exp';
          end;

          cdsResultsOrderDate.AsDateTime := qryPayrollCostsDate.AsDateTime;
          cdsResultsProduct_Description.AsString := qryPayrollCostsService.AsString;
          cdsResultsTimeCostPrice.AsFloat := qryPayrollCostsAmount.AsFloat;

          if AppEnv.CompanyPrefs.UseTimesheetRateIncAsInvoiceCost then cdsResultsLineCostInc.AsFloat :=
              qryPayrollCostsAmount.AsFloat
          else cdsResultsLineCostInc.AsFloat := qryPayrollCostsCost.AsFloat;

          cdsResultsLineCost.AsFloat := qryPayrollCostsCost.AsFloat;
          cdsResultsShipped.AsFloat := qryPayrollCostsHours.AsFloat;
          cdsResults.Post;
        end;
      end else begin
        if (qryPayrollCostsUseTimeCost.AsBoolean) then begin
          dTimeCostPrice := dTimeCostPrice + (qryPayrollCostsAmount.AsFloat * qryPayrollCostsHours.AsFloat);
          dLineCostInc := dLineCostInc + (qryPayrollCostsCost.AsFloat * qryPayrollCostsHours.AsFloat);
          //             dLineCostEx := dLineCostEx + GetAmountEx((qryPayrollCostsCost.AsFloat * qryPayrollCostsHours.asFloat), GetTaxRate('GST'));
          // this is the rate we have paid to employee so there is no GST involved
          dLineCostEx := dLineCostInc;
          dHours := dHours + qryPayrollCostsHours.AsFloat;
        end;
      end;

      // Fetch next record.
      Next;
    end;
  end;

  if AppEnv.PayPrefs.SummariseTSForInvoiceCost then begin
    cdsResults.Open;
    cdsResults.Insert;
    cdsResultsEntryType.AsString        := 'Timesheet';
    cdsResultsSaleID_TimeCost.AsInteger := qryPayrollCostsID.AsInteger;
    if not (qryPayrollCostsPartID.AsInteger = 0) then begin
      cdsResultsProductID.AsInteger := qryPayrollCostsPartID.AsInteger;
      cdsResultsProductName.AsString := qryPayrollCostsPartName.AsString;
    end else begin
      cdsResultsProductName.AsString := 'Time/Cost Exp';
      cdsResultsProductID.AsInteger := GetTimeCostPartID;
    end;

    //     cdsResultsOrderDate.asDateTime := qryPayrollCostsDate.asDateTime;
    cdsResultsProduct_Description.AsString := FloatToStrF(dHours, ffFixed, 15, 2) + ' Hours: ';
    cdsResultsTimeCostPrice.AsFloat := dTimeCostPrice;
    cdsResultsLineCostInc.AsFloat := dLineCostInc;
    cdsResultsLineCost.AsFloat := dLineCostEx;
    cdsResultsShipped.AsFloat  := 1;
    cdsResults.Post;
  end;

  with tblProductCosts do begin
    First;
    while not Eof do begin
      if (tblProductCostsUseTimeCost.AsBoolean) then begin
        cdsResults.Open;
        cdsResults.Insert;
        cdsResultsEntryType.AsString := 'Products';
        for i := 0 to FieldCount - 1 do begin
          if Fields[i].FieldName <> 'PurchaseLineID' then begin
            if Fields[i].FieldName = 'Date' then
              cdsResults.FieldByName('OrderDate').asDateTime := Fields[i].asDateTime
            else if Fields[i].FieldName = 'ProductDescription' then
              cdsResults.FieldByName('Product_Description').asString := Fields[i].asString
            else if Fields[i].FieldName = 'Quantity' then
              cdsResults.FieldByName('Shipped').AsFloat := Fields[i].AsFloat
            else
              cdsResults.FieldByName(Fields[i].FieldName).AsVariant := Fields[i].AsVariant;
          end;
        end;
        cdsResults.Post;
      end;

      // Fetch next record
      Next;
    end;
  end;

  with qryExpenseCosts do begin
    First;
    while not Eof do begin
      if (qryExpenseCostsUseTimeCost.AsBoolean) then begin
        dSumOfTotalEx := dSumOfTotalEx + qryExpenseCostsTimeCostPrice.AsFloat;
        dSumOfTotalCostEx := dSumOfTotalCostEx + qryExpenseCostsLineCost.AsFloat;
        dSumOfTotalCostInc := dSumOfTotalCostInc + qryExpenseCostsLineCostInc.AsFloat;
      end;

      // Fetch next record.
      Next;
    end;

    if dSumOfTotalEx <> 0 then begin
      cdsResults.Open;
      cdsResults.Insert;
      cdsResultsEntryType.AsString := 'Expenses';
      cdsResultsProductID.AsInteger := GetTimeCostPartID;
      cdsResultsProductName.AsString := 'Time/Cost Exp';
      cdsResultsTimeCostPrice.AsFloat := dSumOfTotalEx;
      cdsResultsLineCost.AsFloat := dSumOfTotalCostEx;
      cdsResultsLineCostInc.AsFloat := dSumOfTotalCostInc;
      cdsResultsShipped.AsInteger := 1;
      cdsResults.Post;
    end;
  end;
end;

procedure TCustomerCostGUI.UpdateTablesFromClientDataset;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := qryPayrollCosts.Connection;// FormConnection;
    qry.SQL.Text   := 'UPDATE tblTimeSheets SET SaleLineId = :xSaleLineId WHERE ID = :xID';
    if not cdsResults.Active then Exit;
    cdsResults.First;
    while not cdsResults.Eof do begin
      if cdsResultsEntryType.AsString = 'Timesheet' then begin
        qry.ParamByName('xSaleLineId').AsInteger := cdsResultsSaleLineId.AsInteger;
        qry.ParamByName('xID').AsInteger := cdsResultsSaleID_TimeCost.AsInteger;
        qry.Execute;
      end;
      cdsResults.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TCustomerCostGUI.ValidExpenseLines: boolean;
begin
  Result := true;
  with qryExpenseCosts do begin
    First;
    while not Eof do begin
      if (qryExpenseCostsTimeCostPrice.AsFloat = 0.00) and
        (qryExpenseCostsUseTimeCost.AsBoolean) then begin
        Result := false;
        Break;
      end;

      // Fetch next record.
      Next;
    end;
  end;
end;

procedure TCustomerCostGUI.btnOKClick(Sender: TObject);
begin
  try
        if  qryExpenseCosts.State in [dsEdit,dsInsert] then  qryExpenseCosts.Post;
        if  qryPayrollCosts.State in [dsEdit,dsInsert] then  qryPayrollCosts.Post;
        
    SaveUseTimeCostFlags;

    if ValidExpenseLines then begin
      PopulateClientDataset;
    end else begin
      CommonLib.MessageDlgXP_Vista('Price (Ex) must be entered on every expense record.', mtWarning, [mbOK], 0);
      ModalResult := mrNone;
    end;
  except
    on EAbort do HandleEAbortException;
    on e: Exception do raise;
  end;
end;

procedure TCustomerCostGUI.qryExpenseCostsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryExpenseCostsUseTimeCost.AsBoolean then begin
    qryExpenseCostsSaleID_TimeCost.AsInteger := KeyID;
  end else begin
    qryExpenseCostsSaleID_TimeCost.Clear;
    qryExpenseCostsTimeCostPrice.AsFloat:= 0;
  end;
end;

procedure TCustomerCostGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryPayrollCosts.First;
  while not qryPayrollCosts.Eof do begin
    qryPayrollCosts.Edit;
    qryPayrollCosts.FieldByName('UseTimeCost').AsString := 'F';
    qryPayrollCosts.Post;
    qryPayrollCosts.Next;
  end;
  Self.Close;
end;

procedure TCustomerCostGUI.tblProductCostsUseTimeCostChange(Sender: TField);
begin
  inherited;
  PostMessage(Self.Handle, SX_CalcProductTotalsMsg, 0, 0);
end;

procedure TCustomerCostGUI.qryExpenseCostsUseTimeCostChange(Sender: TField);
begin
  inherited;
  PostMessage(Self.Handle, SX_CalcPerformExpensesMsg, 0, 0);
end;

procedure TCustomerCostGUI.qryExpenseCostsTimeCostPriceChange(Sender: TField);
begin
  inherited;
  PostMessage(Self.Handle, SX_CalcPerformExpensesMsg, 0, 0);
end;

procedure TCustomerCostGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  cThisKey := Chr(Key);
  if Shift = [ssCtrl] then begin
    if cThisKey = 'P' then begin
      pgeCosts.ActivePage := tabProducts;
      pgeCostsChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'E' then begin
      pgeCosts.ActivePage := tabExpenses;
      pgeCostsChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'T' then begin
      pgeCosts.ActivePage := tabTimesheet;
      pgeCostsChange(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TCustomerCostGUI.pgeCostsChange(Sender: TObject);
begin
  inherited;
  //
end;

procedure TCustomerCostGUI.qryPayrollCostsUseTimeCostChange(Sender: TField);
begin
  inherited;
  qryPayrollCosts.Edit;
  // Was the Use field checked?
  if Sender.AsString = 'T' then begin
    // Yes, set sales id.
    qryPayrollCosts.FieldByName('SalesID').AsInteger := KeyID;
  end else begin
    // No, then clear sales ID.
    qryPayrollCosts.FieldByName('SalesID').AsInteger := 0;
  end;

  // Request for Summary Calculation.
  PostMessage(Self.Handle, SX_CalcPerformPayrollMsg, 0, 0);
end;

procedure TCustomerCostGUI.btnPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    fbTemplateUsesNonFormConnection := false;

    // Setup SQL Statement
    sSQL := 'SELECT ';
    sSQL := sSQL + 'tblPurchaseOrders.PurchaseOrderNumber, ';
    sSQL := sSQL +
      'tblPurchaseLines.PurchaseLineID, tblPurchaseLines.UseTimeCost, tblPurchaseOrders.OrderDate, tblPurchaseLines.ProductName, tblPurchaseLines.ProductID, ';
    sSQL := sSQL + 'tblPurchaseLines.Product_Description, tblPurchaseLines.Shipped, tblPurchaseLines.LineCost, ';
    sSQL := sSQL + 'tblPurchaseLines.LineTax, tblPurchaseLines.LineTaxCode, tblPurchaseLines.LineCostInc, ';
    sSQL := sSQL + 'tblPurchaseLines.TotalLineAmount, tblPurchaseLines.SaleID_TimeCost, ';
    sSQL := sSQL + 'tblPurchaseLines.TimeCostPrice ';
    sSQL := sSQL + 'FROM tblPurchaseLines ';
    sSQL := sSQL + 'LEFT JOIN tblPurchaseOrders on tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ';
    sSQL := sSQL + 'WHERE (tblPurchaseOrders.IsPO = "T") AND (tblPurchaseLines.CustomerJobID = ' +
      IntToStr(fiCustomerID) + ') AND ';
    sSQL := sSQL + '(tblPurchaseLines.UseTimeCost = "T" OR tblPurchaseLines.SaleID_TimeCost = ' + IntToStr(KeyID) + ');';
    sSQL := sSQL + '~|||~{Expenses}';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'tblPurchaseOrders.PurchaseOrderNumber, ';
    sSQL := sSQL + 'tblPurchaseLines.PurchaseLineID, tblPurchaseLines.UseTimeCost, tblPurchaseOrders.OrderDate, ';
    sSQL := sSQL + 'If(tblPurchaseOrders.IsCredit="T","Credit",If(tblPurchaseOrders.IsCheque="T","Cheque","Bill")) AS Type, ';
    sSQL := sSQL + 'tblPurchaseOrders.SupplierName, ';
    sSQL := sSQL + 'If(tblPurchaseOrders.IsCredit="T",-tblPurchaseLines.LineCost,tblPurchaseLines.LineCost) as LineCost, ';
    sSQL := sSQL + 'If(tblPurchaseOrders.IsCredit="T",-tblPurchaseLines.LineTax,tblPurchaseLines.LineTax) as LineTax, ';
    sSQL := sSQL + 'If(tblPurchaseOrders.IsCredit="T",-tblPurchaseLines.LineCostInc,tblPurchaseLines.LineCostInc) as LineCostInc, ';
    sSQL := sSQL + 'If(tblPurchaseOrders.IsCredit="T",-tblPurchaseLines.TotalLineAmount,tblPurchaseLines.TotalLineAmount) as TotalLineAmount, ';
    sSQL := sSQL + 'tblPurchaseLines.SaleID_TimeCost, ';
    sSQL := sSQL + 'tblPurchaseLines.TimeCostPrice ';
    sSQL := sSQL + 'FROM tblPurchaseLines ';
    sSQL := sSQL + 'LEFT JOIN tblPurchaseOrders on tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ';
    sSQL := sSQL +
      'WHERE (tblPurchaseOrders.IsBill = "T" OR tblPurchaseOrders.IsCheque = "T" OR tblPurchaseOrders.IsCredit = "T") and (tblPurchaseLines.CustomerJobID = ' +
      IntToStr(fiCustomerID) + ') AND ';
    sSQL := sSQL + '(tblPurchaseLines.UseTimeCost = "T" or tblPurchaseLines.SaleID_TimeCost = ' + IntToStr(KeyID) + ');';
    sSQL := sSQL + '~|||~{Timesheets}';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'ID, UseTimeCost, "Timesheet" AS Type, Date AS Date, ServiceName AS Service, EmployeeName AS Name, ';
    sSQL := sSQL + 'ChargeRate AS Amount, Total AS Cost, PartID AS PartID, PartName AS PartName ';
    sSQL := sSQL + 'FROM tbltimesheets ';
    sSQL := sSQL + 'WHERE (JobID = ' + IntToStr(fiCustomerID) + ' AND UseTimeCost = "T") ';
    sSQL := sSQL + 'ORDER BY Date;';

    // Show report.
    fbReportSQLSupplied := true;
    PrintTemplateReport('Customer Costs', sSQL, false, 1);
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;   
end;

procedure TCustomerCostGUI.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  if pgeCosts.ActivePage = tabProducts then begin
    tblProductCosts.First;
    tblProductCosts.DisableControls;
    while not tblProductCosts.Eof do begin
      tblProductCosts.Edit;
      tblProductCosts.FieldByName('UseTimeCost').AsBoolean := true;
      tblProductCosts.Post;
      // Fetch next record.
      tblProductCosts.Next;
    end;

    tblProductCosts.First;
    tblProductCosts.EnableControls;
  end else if pgeCosts.ActivePage = tabExpenses then begin
    qryExpenseCosts.First;
    qryExpenseCosts.DisableControls;
    while not qryExpenseCosts.Eof do begin
      qryExpenseCosts.Edit;
      qryExpenseCosts.FieldByName('UseTimeCost').AsString := 'T';
      qryExpenseCosts.Post;
      // Fetch next record.
      qryExpenseCosts.Next;
    end;

    qryExpenseCosts.First;
    qryExpenseCosts.EnableControls;
  end else if pgeCosts.ActivePage = tabTimesheet then begin
    qryPayrollCosts.First;
    qryPayrollCosts.DisableControls;
    while not qryPayrollCosts.Eof do begin
      qryPayrollCosts.Edit;
      qryPayrollCosts.FieldByName('UseTimeCost').AsString := 'T';
      qryPayrollCosts.Post;
      // Fetch next record.
      qryPayrollCosts.Next;
    end;

    qryPayrollCosts.First;
    qryPayrollCosts.EnableControls;
  end;
end;

procedure TCustomerCostGUI.PopulateProductCostsTable;
var
  qryPurchase: TERPQuery;
  qryTransfer: TERPQuery;
  ProductQty: double;
  TotalLineAmount: double;
  TotalLineAmountInc: double;
begin
  qryPurchase := TERPQuery.Create(nil);
  qryPurchase.Options.FlatBuffers := True;
  qryTransfer := TERPQuery.Create(nil);
  qryTransfer.Options.FlatBuffers := True;

  try
    qryPurchase.Connection := Getconnection;//MyConnection;
    qryTransfer.Connection := Getconnection;//MyConnection;

    //
    // Obtain costs from purchase orders
    //
    qryPurchase.SQL.Add('SELECT po.PurchaseOrderNumber,');
    qryPurchase.SQL.Add('pl.PurchaseLineID, pl.UseTimeCost, po.OrderDate, pl.ProductName,');
    qryPurchase.SQL.Add('pl.Product_Description, pl.Shipped, pl.LineCost,');
    qryPurchase.SQL.Add('pl.LineTax, pl.LineTaxCode, pl.LineCostInc, pl.TotalLineAmount,');
    qryPurchase.SQL.Add('pl.SaleID_TimeCost, pl.TimeCostPrice, pl.DocketNumber');
    qryPurchase.SQL.Add('FROM tblpurchaselines pl');
    qryPurchase.SQL.Add('LEFT JOIN tblpurchaseorders po ON po.PurchaseOrderID=pl.PurchaseOrderID');
    qryPurchase.SQL.Add('WHERE (po.IsPO = "T") AND (pl.CustomerJobID = ' + IntToStr(fiCustomerID) + ') AND');
    qryPurchase.SQL.Add('((pl.UseTimeCost = "F") OR (pl.SaleID_TimeCost = ' + IntToStr(KeyID) + '))');
    qryPurchase.SQL.Add('AND (pl.Shipped <> 0);');

    //
    // Obtain costs from product tranfers between customers
    //
    qryTransfer.SQL.Add('SELECT cctd.TransferDetailID AS PurchaseOrderNumber, cctd.PurchaseLineID, cct.CustomerFromID,');
    qryTransfer.SQL.Add('cctl.CustomerToID, cctd.UseTimeCost, cct.TransferDate, pl.ProductName, pl.Product_Description,');
    qryTransfer.SQL.Add('cctd.TransferQty, pl.LineCost, pl.LineTax,');
    qryTransfer.SQL.Add('pl.LineTaxCode, pl.LineCostInc, pl.TotalLineAmount,');
    qryTransfer.SQL.Add('pl.SaleID_TimeCost, pl.TimeCostPrice, pl.DocketNumber');
    qryTransfer.SQL.Add('FROM tblcustomercoststransferdetails cctd');
    qryTransfer.SQL.Add('INNER JOIN tblpurchaselines pl ON cctd.PurchaseLineID=pl.PurchaseLineID');
    qryTransfer.SQL.Add('INNER JOIN tblcustomercoststransferlines cctl ON cctd.TransferLineID=cctl.TransferLineID');
    qryTransfer.SQL.Add('INNER JOIN tblcustomercoststransfer cct ON cctl.TransferID=cct.TransferID');
    qryTransfer.SQL.Add('WHERE (cct.CustomerFromID = ' + IntToStr(fiCustomerID) + ') OR');
    qryTransfer.SQL.Add('((cctl.CustomerToID = ' + IntToStr(fiCustomerID) + ') AND');
    qryTransfer.SQL.Add('((cctd.UseTimeCost = "F") OR (cctd.SaleID_TimeCost = ' + IntToStr(KeyID) + ')))');

    qryPurchase.Open;
    qryTransfer.Open;
    tblProductCosts.Open;

    qryPurchase.First;
    qryTransfer.First;

    //
    // Add cost from purchase to the memory table
    //
    while not qryPurchase.Eof do begin
      tblProductCosts.Append;
      tblProductCosts.FieldByName('PurchaseLineID').AsString := qryPurchase.FieldByName('PurchaseLineID').AsString;
      tblProductCosts.FieldByName('UseTimeCost').AsBoolean := qryPurchase.FieldByName('UseTimeCost').AsBoolean;
      tblProductCosts.FieldByName('PurchaseOrderNumber').AsString := qryPurchase.FieldByName('PurchaseOrderNumber').AsString;
      tblProductCosts.FieldByName('Date').AsString := qryPurchase.FieldByName('OrderDate').AsString;
      tblProductCosts.FieldByName('ProductName').AsString := qryPurchase.FieldByName('ProductName').AsString;
      tblProductCosts.FieldByName('ProductDescription').AsString := qryPurchase.FieldByName('Product_Description').AsString;
      tblProductCosts.FieldByName('Quantity').AsFloat := qryPurchase.FieldByName('Shipped').AsFloat;
      tblProductCosts.FieldByName('LineCost').AsCurrency := qryPurchase.FieldByName('LineCost').AsCurrency;
      tblProductCosts.FieldByName('LineTax').AsCurrency := qryPurchase.FieldByName('LineTax').AsCurrency;
      tblProductCosts.FieldByName('LineTaxCode').AsString := qryPurchase.FieldByName('LineTaxCode').AsString;
      tblProductCosts.FieldByName('LineCostInc').AsCurrency := qryPurchase.FieldByName('LineCostInc').AsCurrency;
      tblProductCosts.FieldByName('TotalLineAmount').AsCurrency := qryPurchase.FieldByName('TotalLineAmount').AsCurrency;
      tblProductCosts.Post;
      qryPurchase.Next;
    end;

    //
    // If there are any transfers related to a purchase line ID adjust the
    // product quantities in the memory table
    //
    if qryTransfer.RecordCount > 0 then begin
      while not qryTransfer.Eof do begin
        if tblProductCosts.FindKey([qryTransfer.FieldByName('PurchaseLineID').AsInteger]) then begin
          tblProductCosts.Edit;

          //
          // If a product has been moved from this customer reduce the product
          // quantity
          //
          if qryTransfer.FieldByName('CustomerFromID').AsInteger = fiCustomerID then begin
            ProductQty := tblProductCosts.FieldByName('Quantity').AsFloat - qryTransfer.FieldByName('TransferQty').AsFloat;

            //
            // Delete the record if the product quantity is reduced to zero
            // otherwise calculate costs and tax
            //
            if ProductQty > 0 then begin
              tblProductCosts.FieldByName('Quantity').AsFloat := ProductQty;
              TotalLineAmount := CommonLib.Round(tblProductCosts.FieldByName('LineCost').AsCurrency * ProductQty, CurrencyRoundPlaces);
              TotalLineAmountInc := CommonLib.Round(tblProductCosts.FieldByName('LineCostInc').AsCurrency * ProductQty, CurrencyRoundPlaces);
              tblProductCosts.FieldByName('TotalLineAmount').AsCurrency := TotalLineAmount;
              tblProductCosts.FieldByName('LineTax').AsCurrency := TotalLineAmountInc - TotalLineAmount;
              tblProductCosts.Post;
            end else tblProductCosts.Delete;
          end else begin
            //
            // If a product has been moved to this customer increase the product
            // quantity. This would only occur if this product had originated
            // with this customer, then had been moved away and then back again.
            //
            ProductQty := tblProductCosts.FieldByName('Quantity').AsFloat + qryTransfer.FieldByName('TransferQty').AsFloat;
            tblProductCosts.FieldByName('Quantity').AsFloat := ProductQty;
            TotalLineAmount := CommonLib.Round(tblProductCosts.FieldByName('LineCost').AsCurrency * ProductQty, CurrencyRoundPlaces);
            TotalLineAmountInc := CommonLib.Round(tblProductCosts.FieldByName('LineCostInc').AsCurrency * ProductQty, CurrencyRoundPlaces);
            tblProductCosts.FieldByName('TotalLineAmount').AsCurrency := TotalLineAmount;
            tblProductCosts.FieldByName('LineTax').AsCurrency := TotalLineAmountInc - TotalLineAmount;
            tblProductCosts.Post;
          end;
        end else if qryTransfer.FieldByName('CustomerToID').AsInteger = fiCustomerID then begin
          //
          // Add in any product transfers to this customer
          //
          tblProductCosts.Append;
          ProductQty := qryTransfer.FieldByName('TransferQty').AsFloat;
          tblProductCosts.FieldByName('Quantity').AsFloat := ProductQty;
          tblProductCosts.FieldByName('PurchaseLineID').AsString := qryTransfer.FieldByName('PurchaseLineID').AsString;
          tblProductCosts.FieldByName('UseTimeCost').AsBoolean := qryTransfer.FieldByName('UseTimeCost').AsBoolean;
          tblProductCosts.FieldByName('PurchaseOrderNumber').AsString :=
            qryTransfer.FieldByName('PurchaseOrderNumber').AsString;
          tblProductCosts.FieldByName('Date').AsString := qryTransfer.FieldByName('TransferDate').AsString;
          tblProductCosts.FieldByName('ProductName').AsString := qryTransfer.FieldByName('ProductName').AsString;
          tblProductCosts.FieldByName('ProductDescription').AsString :=
            qryTransfer.FieldByName('Product_Description').AsString;
          tblProductCosts.FieldByName('LineCost').AsCurrency := qryTransfer.FieldByName('LineCost').AsCurrency;
          tblProductCosts.FieldByName('LineTax').AsCurrency := qryTransfer.FieldByName('LineTax').AsCurrency;
          tblProductCosts.FieldByName('LineTaxCode').AsString := qryTransfer.FieldByName('LineTaxCode').AsString;
          tblProductCosts.FieldByName('LineCostInc').AsCurrency := qryTransfer.FieldByName('LineCostInc').AsCurrency;
          TotalLineAmount := CommonLib.Round(qryTransfer.FieldByName('LineCost').AsCurrency * ProductQty, CurrencyRoundPlaces);
          TotalLineAmountInc := CommonLib.Round(qryTransfer.FieldByName('LineCostInc').AsCurrency * ProductQty, CurrencyRoundPlaces);
          tblProductCosts.FieldByName('TotalLineAmount').AsCurrency := TotalLineAmount;
          tblProductCosts.FieldByName('LineTax').AsCurrency := TotalLineAmountInc - TotalLineAmount;
          tblProductCosts.Post;
        end;

        qryTransfer.Next;
      end;
    end;
  finally
    FreeandNil(qryPurchase);
    FreeandNil(qryTransfer);
  end;
end;

procedure TCustomerCostGUI.SaveUseTimeCostFlags;
var
  qryUpdate: TERPQuery;
begin
  if tblProductCosts.RecordCount > 0 then begin
    qryUpdate := TERPQuery.Create(nil);

    try
      qryUpdate.Connection := qryPayrollCosts.Connection; // = form connection of the owner

      //
      // Prepare for storage of UseTimeCost flags and SaleID_TimeCost in
      // tblpurchaselines
      //
      with qryUpdate do begin
        SQL.Add('SELECT tblpurchaselines.PurchaseLineID, tblpurchaselines.UseTimeCost, tblpurchaselines.SaleID_TimeCost');
        SQL.Add('FROM tblpurchaselines');
        SQL.Add('LEFT JOIN tblpurchaseorders po ON po.PurchaseOrderID=tblpurchaselines.PurchaseOrderID');
        SQL.Add('WHERE (po.IsPO = "T") AND (tblpurchaselines.CustomerJobID = ' + IntToStr(fiCustomerID) + ') AND');
        SQL.Add('((tblpurchaselines.UseTimeCost = "F") OR (tblpurchaselines.SaleID_TimeCost = ' + IntToStr(KeyID) + '))');
        SQL.Add('AND (tblpurchaselines.Shipped <> 0)');
        SQL.Add('ORDER BY PurchaseLineID');

        Open;
        First;
      end;

      SetUseTimeCostFlags(qryUpdate);

      qryUpdate.Close;
      qryUpdate.SQL.Clear;

      //
      // Prepare for storage of UseTimeCost flags and SaleID_TimeCost in
      // tblcustomercoststransferdetails
      //
      with qryUpdate do begin
        SQL.Add('SELECT cctd.PurchaseLineID, cctd.UseTimeCost, cctd.SaleID_TimeCost');
        SQL.Add('FROM tblcustomercoststransferdetails cctd');
        SQL.Add('INNER JOIN tblpurchaselines pl ON cctd.PurchaseLineID=pl.PurchaseLineID');
        SQL.Add('INNER JOIN tblcustomercoststransferlines cctl ON cctd.TransferLineID=cctl.TransferLineID');
        SQL.Add('INNER JOIN tblcustomercoststransfer cct ON cctl.TransferID=cct.TransferID');
        SQL.Add('WHERE (cctl.CustomerToID = ' + IntToStr(fiCustomerID) + ') AND');
        SQL.Add('((cctd.UseTimeCost = "F") OR (cctd.SaleID_TimeCost = ' + IntToStr(KeyID) + '))');
        SQL.Add('ORDER BY PurchaseLineID');

        Open;
        First;
      end;

      SetUseTimeCostFlags(qryUpdate);
    finally
      FreeandNil(qryUpdate);
    end;
  end;
end;

procedure TCustomerCostGUI.SetUseTimeCostFlags(const qryUpdate: TERPQuery);
var
  PurchaseLineID: integer;
begin
  with tblProductCosts do begin
    First;

    //
    // Step through the tables setting UseTimeCost flags and SaleID_TimeCost
    // values. Both tables need to be sorted in ascending order
    // by PurchaseLineID.
    //
    while not Eof do begin
      qryUpdate.First;
      PurchaseLineID := FieldByName('PurchaseLineID').AsInteger;

      //
      // Search for matching PurchaseLineID values
      //
      while (not qryUpdate.Eof) and (qryUpdate.FieldByName('PurchaseLineID').AsInteger <= PurchaseLineID) do begin
        if qryUpdate.FieldByName('PurchaseLineID').AsInteger = PurchaseLineID then begin
          EditDB(qryUpdate);
          qryUpdate.FieldByName('UseTimeCost').AsBoolean := FieldByName('UseTimeCost').AsBoolean;

          //
          // Set the value of SaleID_TimeCost to KeyID if UseTimeCost is
          // checked on the grid, otherwise clear it
          //
          if FieldByName('UseTimeCost').AsBoolean then qryUpdate.FieldByName('SaleID_TimeCost').AsInteger := KeyID
          else qryUpdate.FieldByName('SaleID_TimeCost').Clear;

          PostDB(qryUpdate);
        end;

        qryUpdate.Next;
      end;

      Next;
    end;
  end;
end;

procedure TCustomerCostGUI.ShowHideBO(ShowBO: boolean);
var
  qryPurchase: TERPQuery;
begin
  qryPurchase := TERPQuery.Create(nil);
  qryPurchase.Options.FlatBuffers := True;
  try
    qryPurchase.Connection := Getconnection;//MyConnection;
    qryPurchase.SQL.Add('SELECT po.PurchaseOrderNumber,');
    qryPurchase.SQL.Add('pl.PurchaseLineID, pl.UseTimeCost, po.OrderDate, pl.ProductName,');
    qryPurchase.SQL.Add('pl.Product_Description, pl.BackOrder as Shipped, pl.LineCost,');
    qryPurchase.SQL.Add('pl.LineTax, pl.LineTaxCode, pl.LineCostInc, pl.TotalLineAmount,');
    qryPurchase.SQL.Add('pl.SaleID_TimeCost, pl.TimeCostPrice, pl.DocketNumber');
    qryPurchase.SQL.Add('FROM tblpurchaselines pl');
    qryPurchase.SQL.Add('LEFT JOIN tblpurchaseorders po ON po.PurchaseOrderID=pl.PurchaseOrderID');
    qryPurchase.SQL.Add('WHERE (po.IsPO = "T") AND (pl.CustomerJobID = ' + IntToStr(fiCustomerID) + ') AND');
    qryPurchase.SQL.Add('((pl.UseTimeCost = "F") OR (pl.SaleID_TimeCost = ' + IntToStr(KeyID) + '))');
    qryPurchase.SQL.Add('AND (pl.Shipped = 0);');
    qryPurchase.Open;

    qryPurchase.First;

    while not qryPurchase.Eof do begin
      if showBO = false then begin
        if tblProductCosts.Locate('PurchaseLineID', qryPurchase.FieldByName('PurchaseLineID').AsString, []) then
          if tblProductCostsUseTimeCost.AsBoolean = true then begin
            if not (tblProductCosts.State in [dsEdit, dsInsert]) then tblProductCosts.Edit;
            tblProductCostsUseTimeCost.AsBoolean := false;
            tblProductCosts.Post;
          end;
        tblProductCosts.Delete;
      end else begin
        if tblProductCosts.Locate('PurchaseLineID', qryPurchase.FieldByName('PurchaseLineID').AsString, []) = false then
        begin
          tblProductCosts.Append;
          tblProductCosts.FieldByName('PurchaseLineID').AsString := qryPurchase.FieldByName('PurchaseLineID').AsString;
          tblProductCosts.FieldByName('UseTimeCost').AsBoolean := qryPurchase.FieldByName('UseTimeCost').AsBoolean;
          tblProductCosts.FieldByName('PurchaseOrderNumber').AsString :=
            qryPurchase.FieldByName('PurchaseOrderNumber').AsString;
          tblProductCosts.FieldByName('Date').AsString := qryPurchase.FieldByName('OrderDate').AsString;
          tblProductCosts.FieldByName('ProductName').AsString := qryPurchase.FieldByName('ProductName').AsString;
          tblProductCosts.FieldByName('ProductDescription').AsString :=
            qryPurchase.FieldByName('Product_Description').AsString;
          tblProductCosts.FieldByName('Quantity').AsFloat := qryPurchase.FieldByName('Shipped').AsFloat;
          tblProductCosts.FieldByName('LineCost').AsCurrency := qryPurchase.FieldByName('LineCost').AsCurrency;
          tblProductCosts.FieldByName('LineTax').AsCurrency := qryPurchase.FieldByName('LineTax').AsCurrency;
          tblProductCosts.FieldByName('LineTaxCode').AsString := qryPurchase.FieldByName('LineTaxCode').AsString;
          tblProductCosts.FieldByName('LineCostInc').AsCurrency := qryPurchase.FieldByName('LineCostInc').AsCurrency;
          tblProductCosts.Post;
        end;
      end;
      qryPurchase.Next;
    end;
  finally
    FreeandNil(qryPurchase);
  end;
end;

procedure TCustomerCostGUI.chkShowBOClick(Sender: TObject);
begin
  inherited;
  ShowHideBO(chkShowBO.Checked);
end;

procedure TCustomerCostGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//
end;

procedure TCustomerCostGUI.FormCreate(Sender: TObject);
var
  iIndex: integer;
begin
  inherited;
  if (Assigned(Self.Owner)) and (Self.Owner is TInvoiceGUI) then begin
    for iIndex := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iIndex] is TCustomMyDataSet then
        with Self.Components[iIndex] as TCustomMyDataSet do begin
            Connection := Getconnection;
          end;
        end;
    end;
end;

function TCustomerCostGUI.Getconnection: TERPConnection;
begin
  result := MyConnection;
  if Assigned(Self.Owner) then
    if Self.Owner is TBaseInputGUI then
       Result := TBaseInputGUI(Self.Owner).Myconnection;
end;

procedure TCustomerCostGUI.FeldSetTextDontAllowNulls(Sender: TField;
      const Text: String);
begin
  inherited;
  if text = '' then
    Sender.AsString:= '0'
  else
    Sender.AsString:= text;
end;


Initialization
  RegisterClassOnce(TCustomerCostGUI);

end.

