unit SalesnPOSQL;

interface
uses
   classes, ReportBaseObj;
Type
   TSalesnPOList = class(TReportWithDateRangeBase)
   Private
    fbIncludeShipped: Boolean;
    fbIncludeLines: Boolean;
    fbIncludeBO: Boolean;
   Protected
    function PopulateSalesnPOSQL(SQL: TStrings; var msg: string; Header, Lines, IDfield, datefield, transtypes :String): boolean;
   Public
      constructor Create; Override;
   Published
     Property  IncludeBO : Boolean read fbIncludeBO write fbIncludeBO;
     Property  IncludeShipped : Boolean read fbIncludeShipped write fbIncludeShipped;
     Property  IncludeLines : Boolean read fbIncludeLines write fbIncludeLines;
   end;

implementation

uses sysutils;

{ TSalesnPOList }

constructor TSalesnPOList.Create;
begin
   inherited;
   DateFrom       := MinDateTime;
   DateTo         := MaxDateTime;
   IncludeBO      := False;
   IncludeShipped := True;
   IncludeLines   := False;
end;

function TSalesnPOList.PopulateSalesnPOSQL(SQL: TStrings; var msg: string; Header, Lines, IDfield, datefield, transtypes :String): Boolean;
var
  st: TStringList;
  ctr: Integer;

  Function POHeaderFields:String;
  begin
    Result := 'TransHeader.PurchaseOrderNumber,'+
              'TransHeader.Account,'+
              'TransHeader.SupplierName,'+
              'TransHeader.ClientID,'+
              'TransHeader.OrderTo,'+
              'TransHeader.ShipTo,'+
              'TransHeader.OrderDate,'+
              'TransHeader.TotalTax,'+
              'TransHeader.TotalAmount,'+
              'TransHeader.TotalAmountInc,'+
              'TransHeader.EmployeeName,'+
              'TransHeader.InvoiceNumber,'+
              'TransHeader.RefNo,'+
              'TransHeader.ETADate,'+
              'TransHeader.DueDate,'+
              'TransHeader.Comments,'+
              'TransHeader.SalesComments,'+
              'TransHeader.Terms,'+
              'TransHeader.Paid,'+
              'TransHeader.Balance,'+
              'TransHeader.Payment,'+
              'TransHeader.IsPO,'+
              'TransHeader.IsRA,'+
              'TransHeader.IsBill,'+
              'TransHeader.IsCredit,'+
              'TransHeader.IsCheque,'+
              'TransHeader.IsRefundCheque,'+
              'TransHeader.IsPOCredit,'+
              'TransHeader.InvoiceDate,'+
              'TransHeader.EnteredBy,'+
              'TransHeader.ConNote,'+
              'TransHeader.CustPONumber,'+
              'TransHeader.ForeignExchangeCode,'+
              'TransHeader.ForeignExchangeRate,'+
              'TransHeader.ForeignTotalAmount,'+
              'TransHeader.ForeignPaidAmount,'+
              'TransHeader.ForeignBalanceAmount,'+
              'TransHeader.Approved,'+
              'TransHeader.APNotes,'+
              'TransHeader.ExpenseClaimEmployee,'+
              'TransHeader.ContactName,'+
              'TransHeader.TotalDiscount,'+
              'TransHeader.Area,'+
              'TransHeader.OrderStatus,'+
              'TransHeader.FuturePO,'+
              'TransHeader.PickupFromDesc,';
  end;

  Function POLinesfields:String;
  begin
    Result := 'TransLines.PurchaseLineID,'+
              'TransLines.PARTTYPE,'+
              'TransLines.INCOMEACCNT,'+
              'TransLines.ASSETACCNT,'+
              'TransLines.COGSACCNT,'+
              'TransLines.ProductGroup,'+
              'TransLines.ProductName,'+
              'TransLines.ProductPrintName,'+
              'TransLines.Product_Description,'+
              'TransLines.LineDescription,'+
              'TransLines.LineTaxRate,'+
              'TransLines.LineCost,'+
              'TransLines.LineCostInc,'+
              'TransLines.LineTaxCode,'+
              'TransLines.LineTax,'+
              'TransLines.QtySold,'+
              'TransLines.UnitofMeasureQtySold,'+
              'TransLines.Shipped,'+
              'TransLines.UnitofMeasureShipped,'+
              'TransLines.BackOrder,'+
              'TransLines.UnitofMeasureBackorder,'+
              'TransLines.UnitofMeasurePOLines,'+
              'TransLines.UnitofMeasureMultiplier,'+
              'TransLines.Invoiced,'+
              'TransLines.Class,'+
              'TransLines.CustomerJob,'+
              'TransLines.TotalLineAmount,'+
              'TransLines.TotalLineAmountInc,'+
              'TransLines.ForeignCurrencyLineCost,'+
              'TransLines.ForeignTotalLineAmount,'+
              'TransLines.ReceivedDate,'+
              'TransLines.ETADate,'+
              'TransLines.LineNotes,'+
              'TransLines.EquipmentName,'+
              'TransLines.SupplierProductCode,'+
              'TransLines.SupplierProductName,'+
              'TransLines.DiscountPercent,'+
              'TransLines.DiscountAmount,'+
              'TransLines.GeneralNotes,';
  end;

  Function SalesHeaderFields:String;
  begin
    Result := 'TransHeader.InvoiceDocNumber,'+
              'TransHeader.Account,'+
              'TransHeader.CustomerName,'+
              'TransHeader.InvoiceTo,'+
              'TransHeader.ShipTo,'+
              'TransHeader.PickupFrom,'+
              'TransHeader.SaleDate,'+
              'TransHeader.TotalTax,'+
              'TransHeader.TotalAmount,'+
              'TransHeader.TotalAmountInc,'+
              'TransHeader.TotalMarkup,'+
              'TransHeader.TotalDiscount,'+
              'TransHeader.EmployeeName,'+
              'TransHeader.Class,'+
              'TransHeader.OrderNumber,'+
              'TransHeader.PONumber,'+
              'TransHeader.ChequeNo,'+
              'TransHeader.ShipDate,'+
              'TransHeader.FutureSO,'+
              'TransHeader.DueDate,'+
              'TransHeader.ConNote,'+
              'TransHeader.Comments,'+
              'TransHeader.Shipping,'+
              'TransHeader.Terms,'+
              'TransHeader.PayMethod,'+
              'TransHeader.PayDueDate,'+
              'TransHeader.Paid,'+
              'TransHeader.Balance,'+
              'TransHeader.Payment,'+
              'TransHeader.IsPOS,'+
              'TransHeader.IsRefund,'+
              'TransHeader.IsCashSale,'+
              'TransHeader.IsInvoice,'+
              'TransHeader.IsQuote,'+
              'TransHeader.IsSalesOrder,'+
              'TransHeader.IsVoucher,'+
              'TransHeader.IsLayby,'+
              'TransHeader.IsLaybyTOS,'+
              'TransHeader.IsLaybyPayment,'+
              'TransHeader.IsCustomerReturn,'+
              'TransHeader.HoldSale,'+
              'TransHeader.Converted,'+
              'TransHeader.EnteredBy,'+
              'TransHeader.QuoteStatus,'+
              'TransHeader.ForeignExchangeCode,'+
              'TransHeader.ForeignExchangeRate,'+
              'TransHeader.ForeignTotalAmount,'+
              'TransHeader.ForeignPaidAmount,'+
              'TransHeader.ForeignBalanceAmount,'+
              'TransHeader.IsInternalOrder,'+
              'TransHeader.ContactName,'+
              'TransHeader.Medtype,'+
              'TransHeader.SalesCategory,'+
              'TransHeader.SaleCustField1, ' +
              'TransHeader.SaleCustField2, ' +
              'TransHeader.SaleCustField3, ' +
              'TransHeader.SaleCustField4, ' +
              'TransHeader.SaleCustField5, ' +
              'TransHeader.SaleCustField6, ' +
              'TransHeader.SaleCustField7, ' +
              'TransHeader.SaleCustField8, ' +
              'TransHeader.SaleCustField9, ' +
              'TransHeader.SaleCustField10, ' +
              'TransHeader.AppointID, ' +
              'TransHeader.ReferenceNo,';

  end;

  Function SalesLinesfields:String;
  begin
    Result := 'TransLines.SaleLineID,'+
              'TransLines.PARTTYPE,'+
              'TransLines.INCOMEACCNT,'+
              'TransLines.ASSETACCNT,'+
              'TransLines.COGSACCNT,'+
              'TransLines.ProductName,'+
              'TransLines.Product_Description,'+
              'TransLines.Product_Description_Memo,'+
              'TransLines.LinePrice,'+
              'TransLines.LinePriceInc,'+
              'TransLines.LineTaxRate,'+
              'TransLines.LineCost,'+
              'TransLines.LineCostInc,'+
              'TransLines.LineTaxCode,'+
              'TransLines.LineTax,'+
              'TransLines.QtySold,'+
              'TransLines.UnitofMeasureQtySold,'+
              'TransLines.Shipped,'+
              'TransLines.UnitofMeasureShipped,'+
              'TransLines.BackOrder,'+
              'TransLines.UnitofMeasureBackorder,'+
              'TransLines.UnitofMeasureSaleLines,'+
              'TransLines.UnitofMeasureMultiplier,'+
              'TransLines.Invoiced,'+
              'TransLines.Discounts,'+
              'TransLines.Markup,'+
              'TransLines.Margin,'+
              'TransLines.MarkupPercent,'+
              'TransLines.DiscountPercent,'+
              'TransLines.MarginPercent,'+
              'TransLines.TotalLineAmount,'+
              'TransLines.TotalLineAmountInc,'+
              'TransLines.RefundQty,'+
              'TransLines.ForeignCurrencyLinePrice,'+
              'TransLines.ForeignTotalLineAmount,'+
              'TransLines.ShipDate,'+
              'TransLines.ETDDate,'+
              'TransLines.ReferenceNo,';

  end;

  Function IsPOList:Boolean;
  begin
    Result := sametext(Header , 'tblpurchaseorders');
  end;
begin
  Result := inherited PopulateReportSQL(SQL, msg);
  SQL.Clear;
  st := TStringList.Create;
  try
    st.CommaText := Transtypes;
    for ctr := 0 to st.Count - 1 do begin
      if ctr > 0 then SQL.Add('UNION ');
       SQL.Add('SELECT DISTINCT ');

       if IsPOList then SQL.Add(POHeaderFields) else SQL.Add(SalesHeaderFields);

       if includeLines then
        if IsPOList then SQL.Add(POLinesfields) else SQL.Add(SalesLinesfields);
       SQL.Add('TransHeader.' + IDfield);

       SQL.Add(' FROM ' + Header + ' TransHeader ');
       SQL.Add(' INNER JOIN ' + Lines + ' TransLines ON TransHeader.' + IDfield + ' = TransLines.' + IDfield + '');
       SQL.Add(' WHERE TransHeader.' + st[ctr] + ' = "T" ');
       if not IsPOList then SQL.Add(' AND TransHeader.Converted="F" ');
       if IncludeBO and includeshipped then
       else if IncludeBO      then SQL.Add(' AND IFNULL(TransHeader.BOID, '''') = ''''  AND IFNULL(TransLines.shipped,0)=0')
       else if includeshipped then SQL.Add(' AND IFNULL(TransLines.shipped,0) <> 0')
       else SQL.Add(' AND TransHeader.' + IDfield + '=0'); // just to make the list blank as both options are disabled
       SQL.Add(' AND TransHeader.' + datefield + ' BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
    end;
  finally
    Freeandnil(st);
  end;
  if not (OrderBy = '') then SQL.Add('ORDER BY ' + OrderBy);
end;

end.
