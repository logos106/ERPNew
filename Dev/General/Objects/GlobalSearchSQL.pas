unit GlobalSearchSQL;

interface

uses
  classes, ReportBaseObj, Types;

type
  TGlobalSearchFiltertype = (gsftString =1, gsftfloat=2);

  TGlobalSearchCategory   = (gscClients = 1,
                                  gscMC = 2,
                                 gscEmp = 3,
                       gscClientcontact = 4,
                           gscMCContact = 5,
                               gscSO_BO = 6,
                              gscInv_BO = 7,
                               gscQuote = 8,
                            gscCashSale = 9,
                                 gscPOS = 10,
                              gscRefund = 11,
                              gscRepair = 12,
                                  gscSO = 13,
                             gscInvoice = 14,
                               gscPO_BO = 15,
                                  gscPO = 16,
                              gscCredit = 17,
                              gscCheque = 18,
                                gscBill = 19,
                                  gscRA = 20,
                           gscTransName = 21,
                                 gscAmt = 22,
                          gscExtraPrice = 23,
                      gscProductBaRcode = 24,
                               gscParts = 25,
                               gsctblPO = 26,
                            gsctblSales = 27,
                               gsctblGE = 28,
                                  gscFA = 29,
                      gsctblCancelledPO = 30,
                      gsctblCancelledSL = 31,
                      gsctblCancelledRP = 32,
                                 gscCOA = 33,
                         gscStockAdjust = 34,
                       gscStockTransfer = 35);


  TGlobalSearchReport = class(TReportWithDateRangeBase)
  private
    fSearchName: String;
    fSearchType: String;
    fsSearchhint: String;
    fsSQLSearchName: String;
    fsSQLSearchType: String;
    fQuerySearchMode: String;
    function GlobalSearchCatgStrDesc(catg: TGlobalSearchCategory): String;
    function GlobalSearchCatgSQL(catg: TGlobalSearchCategory): String;
    procedure SetSearchName(const Value: String);
    procedure SetSearchType(const Value: String);
    Function GlobalSearchCatgStr(catg:TGlobalSearchCategory):String;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    Function GlobalSearchCatgNo(catg:TGlobalSearchCategory):Integer;
  published
    Property SearchName: String read fSearchName  write SetSearchName;
    Property SearchType: String read fSearchType  write SetSearchType;
    Property Searchhint :String read fsSearchhint;
    property QuerySearchMode: String read fQuerySearchMode write fQuerySearchMode;
  end;


implementation

uses
  ProductQtyLib, SysUtils, CommonLib, tcConst, AppEnvironment, FastStringFuncs, strutils;

{ TGlobalSearchReport }

constructor TGlobalSearchReport.Create;
begin
  inherited;
  fSearchName := '';
  fsSQLSearchName := '';
  fSearchType := '';
  fsSQLSearchType := '';
  fQuerySearchMode := 'smFullList';
end;

destructor TGlobalSearchReport.Destroy;
begin

  inherited;
end;

function TGlobalSearchReport.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
  function SearchString(FilterField: string; GlobalSearchFiltertype: TGlobalSearchFiltertype = gsftString ): string;
  begin
    Result := '';
    if (GlobalSearchFiltertype = gsftfloat) and (IsNumeric(fsSQLSearchName)) then begin
        Result := '((' + Filterfield + ' = ' + fsSQLSearchName + ') or Round(' + Filterfield + ') = Round(' +fsSQLSearchName + '))' ;
    end else if GlobalSearchFiltertype = gsftString then begin
      if QuerySearchMode = 'smFullList' then begin {f5}
        Result := FilterField + ' = ' + QuotedStr(fsSQLSearchName);
      end else if  QuerySearchMode = 'smSearchEngine' then begin {f6}
        Result := FilterField + ' like ' +QuotedStr(fsSQLSearchName + '%');
      end else if  QuerySearchMode = 'smSearchEngineLike' then begin {f7}
        Result := FilterField + ' like ' +QuotedStr('%'+ fsSQLSearchName + '%');
      end;
    end;
  end;

  procedure AddFilter(FilterField: string);
  var
    fs: string;
  begin
    if fSearchName = '' then Exit;
    fs := SearchString(FilterField);
    if fs <> '' then SQL.add('AND ' + fs);
  end;

  procedure AddFilters(FilterField: string; GlobalSearchFiltertype :TGlobalSearchFiltertype = gsftString);
  var
    FieldNames : TStringList;
    ctr : Integer;
    str : string;
    fs : string;
  begin
    FieldNames:= TStringList.create;
    try
      FastStringFuncs.Split(FilterField, ';', FieldNames);
      if FieldNames.count = 0 then Exit;
      str := '';
      for ctr := 0 to FieldNames.count - 1 do begin
        fs := SearchString(FieldNames[ctr], GlobalSearchFiltertype);
        if fs <> '' then begin
          if str <> '' then str := str + ' OR ';
          str := str + '(' + fs + ')';
        end;
      end;

      if str <> '' then begin
        if LowerCase(RightStr(Trim(SQL[SQL.Count - 1]), 5)) = 'WHERE' then
          SQL.Add('(' + str + ')')
        else
          SQL.Add(' AND (' + str + ')');
      end;
    finally
      FreeAndNil(FieldNames);
    end;
  end;

begin
  inherited;
  SQL.Clear;
  msg := '';
  result := true;
  fsSearchhint:='Search Includes';

  SQL.Add('SELECT * FROM (');
{-----Client}fsSearchhint := fsSearchhint + NL + '        ' + 'Client -> Name / ContactName';

            SQL.add('SELECT ');
            SQL.add(GlobalSearchCatgSQL(gscClients));
            SQL.add('clientId as ClientId, ');
            SQL.add('clientId as ID, ');
            SQL.add('company as Company, ');
            SQL.add('if(customer="T", "Customer", if(Supplier="T", "Supplier", if(Isjob="T" , "Job" , if(Othercontact="T" ,"Prospect" , "")))) as Type , ');
            SQL.add('"" as Globalref,');
            SQL.add('convert(NULL, dateTime) as TransDate,');
            SQL.add('null as TransId,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblClients');
            SQL.add('WHERE (customer="T" or Supplier = "T" or isjob = "T" or Othercontact = "T") and Active = "T"');
            Addfilter('company');

            SQL.add('UNION ');
            SQL.add('SELECT ');
            SQL.add(GlobalSearchCatgSQL(gscClientcontact));
            SQL.add('clientID, ');
            SQL.add('contactId, ');
            SQL.add('Company as Company,');
            SQL.add('"Contact", ');
            SQL.add('"" as Globalref,');
            SQL.add('convert(NULL , dateTime) as TransDate,');
            SQL.add('null as TransId,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblContacts ');
            SQL.add('WHERE Active = "T"');
            Addfilter('company');

{-----Marketing Contacts}fsSearchhint:= fsSearchhint +NL+'        '+'Marketing Contacts -> Name / Contact Name';
            SQL.add('UNION ');
            SQL.add('Select ');
            SQL.add(GlobalSearchCatgSQL(gscMC));
            SQL.add('NULL, ');
            SQL.add('ID, ');
            SQL.add('Company as Company, ');
            SQL.add('"Marketing contact" , ');
            SQL.add('"" as Globalref,');
            SQL.add('convert(NULL , dateTime) as TransDate,');
            SQL.add('null as TransId,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblmarketingcontacts ');
            SQL.add('WHERE clientID = 0 and Active = "T"');
            Addfilter('company');

            SQL.add('UNION ');
            SQL.add('SELECT ');
            SQL.add(GlobalSearchCatgSQL(gscMCContact));
            SQL.add('MarketingContactID, ');
            SQL.add('contactId, ');
            SQL.add('Company as Company, ');
            SQL.add('"Contact" , ');
            SQL.add('"" as Globalref,');
            SQL.add('convert(NULL , dateTime) as TransDate,');
            SQL.add('null as TransId,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblmarketingcontactcontacts ');
            SQL.add('WHERE Active = "T"');
            Addfilter('company');


{-----employee}fsSearchhint:= fsSearchhint +NL+'        '+'Employee -> Full name / First name/ Middle Name / Last Name / Employee No';
            SQL.add('UNION ');
            SQL.add('Select  ');
            SQL.add(GlobalSearchCatgSQL(gscEmp));
            SQL.add('NULL, ');
            SQL.add('EmployeeId, ');
            SQL.add('if(MiddleName<>Space(1),Concat_ws(Space(1),FirstName,MiddleName,LastName),Concat_ws(Space(1),FirstName,LastName)) as Company, ');
            SQL.add('"Employee" , ');
            SQL.add('"" as Globalref,');
            SQL.add('convert(NULL , dateTime) as TransDate,');
            SQL.add('null as TransId,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblEmployees');
            SQL.add('WHERE Active  = "T"');
            Addfilters('EmployeeName;EmployeeNo;MiddleName;FirstName;LastName');

{-----Sales}fsSearchhint:= fsSearchhint +NL+'        '+'Sales(Cash-Sale, Invoice, Invoice-BO, POS, Quote, Refund, Sales Order, Sales Order-BO ) -> Customer Name/globalref/ ID, Docno';

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscSO_BO));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"SO-BO" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('INNER JOIN tblSaleslines SL using (SaleID)');
            SQL.add('WHERE ISSalesorder = "T" and Sl.shipped = 0 and ifnull(S.BOID,"")  = "" ');
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscInv_BO));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"INV-BO" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('INNER JOIN tblSaleslines SL using (SaleID)');
            SQL.add('WHERE IsInvoice = "T" and Sl.shipped = 0 and ifnull(S.BOID,"")  = ""');
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscQuote));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"Quote" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE S.IsQuote = "T" ');
            (*Addfilter('customername');*)
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscCashSale));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"Cash Sale" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE S.IsCashSale = "T" and S.IsPos = "F"');
            (*Addfilter('customername');*)
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscPOS));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"POS" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE S.IsPos = "T" and (S.IsCashSale = "T" or IsLaybyPayment = "T") ');
            (*Addfilter('customername');*)
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscRefund));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername , ');
            SQL.add('"Refund" , ');
            SQL.add('S.globalref, ');
            SQL.add('convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE S.IsRefund = "T" ');
            (*Addfilter('customername');*)
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscSO));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername ,');
            SQL.add(' "Sales Order" ,');
            SQL.add(' S.globalref, ');
            SQL.add(' convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE IsSalesOrder = "T" ');
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscInvoice));
            SQL.add('S.clientId, ');
            SQL.add('S.clientId, ');
            SQL.add('S.customername ,');
            SQL.add(' "Invoice" ,');
            SQL.add(' S.globalref, ');
            SQL.add(' convert(S.saleDate, dateTime) as TransDate,');
            SQL.add('S.SaleId as TransID,');
            SQL.add('S.SaleId as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblSales S');
            SQL.add('WHERE IsInvoice = "T" ');
            Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');

           if isnumeric(fsSQLSearchName) then begin
              fsSearchhint:= fsSearchhint +',Total Amount';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gsctblSales));
              SQL.add('S.clientId, ');
              SQL.add('S.clientId, ');
              SQL.add('S.CustomerName, ');
              SQL.add(ProductQtylib.SaleType('S')+' as type, ');
              SQL.add('S.globalref, ');
              SQL.add('convert(S.SaleDate, dateTime) as TransDate,');
              SQL.add('S.saleID as TransID,');
              SQL.add('S.saleID as SaleID,');
              SQL.add('0 as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  tblsales S');
              SQL.add('WHERE deleted ="F" and Cancelled="F" ');
              Addfilters('totalamount;Totalamountinc;TotalTax', gsftFloat);
            end;


{-----Repairs}fsSearchhint:= fsSearchhint +NL+'        '+'Repair -> Customer Name/Global Ref';
            SQL.add('UNION ');
            SQL.add('SELECT ');
            SQL.add(GlobalSearchCatgSQL(gscRepair));
            SQL.add('`R`.`CusID`, ');
            SQL.add('`R`.`CusID`, ');
            SQL.add('`C`.`Company`, ');
            SQL.add('"Repairs" AS `Type`, ');
            SQL.add('`R`.`GlobalRef`, ');
            SQL.add('convert(`R`.`JobDueDate`, dateTime) as TransDate,');
            SQL.add('`R`.`RepairID` as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  `tblrepairs` AS `R` Inner Join `tblclients` AS `C` ON `C`.`ClientID` = `R`.`CusID`');
            SQL.add('WHERE R.cancelled ="F" and ifnull(C.company,"") <> ""');
            (*Addfilter('C.company');*)
            Addfilters('C.company;R.Globalref');

{-----PO}fsSearchhint:= fsSearchhint +NL+'        '+'Purchase Order(PO, PO-BO, Credit, Cheque, Bill, Return Authority) -> Supplier Name, Globalref, ID , Doc Number';

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscPO_BO));
            SQL.add('P.clientId, ');
            SQL.add('P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"PO-BO" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('INNER JOIN tblpurchaselines PL using (PurchaseOrderId)');
            SQL.add('WHERE  IsPO = "T" and PL.shipped = 0 and ifnull(P.BOID,"")  = "" ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscPO));
            SQL.add('P.clientId, ');
            SQL.add('P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"PO" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('INNER JOIN tblpurchaselines PL using (PurchaseOrderId)');
            SQL.add('WHERE (IsPO = "T"  or IsPOCredit="T") and PL.shipped <> 0 ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscCredit));
            SQL.add('P.clientId, ');
            SQL.add('P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"Credit" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('WHERE IsCredit = "T" ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscCheque));
            SQL.add(' P.clientId, ');
            SQL.add(' P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"Cheque" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('WHERE IsCheque = "T" ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscBill));
            SQL.add(' P.clientId, ');
            SQL.add(' P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"Bill" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('WHERE IsBill = "T" ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            SQL.add('UNION ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscRA));
            SQL.add(' P.clientId, ');
            SQL.add(' P.clientId, ');
            SQL.add('P.SupplierName , ');
            SQL.add('"RA" , ');
            SQL.add('P.globalref, ');
            SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
            SQL.add('P.PurchaseOrderID as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  tblPurchaseOrders P');
            SQL.add('WHERE IsRA = "T" ');
            Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');

            if isnumeric(fsSQLSearchName) then begin
              fsSearchhint:= fsSearchhint +',Total Amount';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gsctblPO));
              SQL.add('P.clientId, ');
              SQL.add('P.clientId, ');
              SQL.add('P.SupplierName , ');
              SQL.add(ProductQtylib.POType('P')+' as type, ');
              SQL.add('P.globalref, ');
              SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
              SQL.add('P.PurchaseOrderID as TransID,');
              SQL.add('0 as SaleID,');
              SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  tblPurchaseOrders P');
              SQL.add('WHERE  deleted ="F" and Cancelled="F" ');
              Addfilters('totalamount;Totalamountinc;TotalTax', gsftFloat);
            end;

{-----TblTransactions}fsSearchhint:= fsSearchhint +NL+'        '+'General Ledger.Supplier/customer Name, GlobalRef';

            SQL.add('UNION  ');
            SQL.add('SELECT distinct ');
            SQL.add(GlobalSearchCatgSQL(gscTransName));
            SQL.add('clientId, ');
            SQL.add('clientId, ');
            SQL.add('ClientName as company, ');
            SQL.add('Trans.Type as Type,');
            SQL.add('Trans.GlobalRef as GlobalRef,');
            SQL.add('convert(Trans.Date, dateTime) as TransDate,');
            SQL.add('NULL as TRansID,');
            SQL.add('Trans.SaleID as SaleID,');
            SQL.add('Trans.PurchaseOrderID as PurchaseOrderID,');
            SQL.add('Trans.PaymentID as PaymentID,');
            SQL.add('Trans.PrepaymentID as PrepaymentID,');
            SQL.add('Trans.FixedAssetID as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblTransactions as Trans');
            SQL.add('WHERE ifnull(Globalref,"") <>""');
            Addfilters('Trans.ClientName;Trans.Globalref');
            if isnumeric(fsSQLSearchName) then begin
              fsSearchhint:= fsSearchhint +',Amount Ex and Inc';
              SQL.add('UNION  ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gscAmt));
              SQL.add('clientId, ');
              SQL.add('clientId, ');
              SQL.add('ClientName as company, ');
              SQL.add('Trans.Type as Type,');
              SQL.add('Trans.GlobalRef as GlobalRef,');
              SQL.add('convert(Trans.Date, dateTime) as TransDate,');
              SQL.add('NULL as TRansID,');
              SQL.add('Trans.SaleID as SaleID,');
              SQL.add('Trans.PurchaseOrderID as PurchaseOrderID,');
              SQL.add('Trans.PaymentID as PaymentID,');
              SQL.add('Trans.PrepaymentID as PrepaymentID,');
              SQL.add('Trans.FixedAssetID as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM tblTransactions as Trans');
              SQL.add('WHERE ifnull(Globalref,"") <>""');
              if (strToFloat(fsSQLSearchName)=0) then
                SQL.add(' and ifnull(DebitsEx,0) =0 and ifnull(CreditsEx,0) =0 and ifnull(DebitsInc,0) =0 and ifnull(CreditsInc,0) =0')
              else Addfilters('DebitsEx;CreditsEx;DebitsInc;CreditsInc', gsftFloat);
            end;
{-----Product}fsSearchhint:= fsSearchhint +NL+'        '+'Product.Name,Barcode,SupplierBarCode, SupplierProductCode ';
            SQL.add('UNION  ');
            SQL.add('SELECT  ');
            SQL.add(GlobalSearchCatgSQL(gscExtraPrice));
            SQL.add('clientId, clientid, PartName as company, "Product" as Type,');
            SQL.add('"" as GlobalRef,');
            SQL.add('convert(0, DateTime) as Date,');
            SQL.add('NULL as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('PartsId,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblExtraPrice EP');
            SQL.add('INNER JOIN tblClients C on C.ClientId= EP.SupplierId');
            SQL.Add('WHERE 1=1');
            AddFilters('SupplierBarCode;SupplierProductCode');

            SQL.add('UNION  ');
            SQL.add('SELECT  ');
            SQL.add(GlobalSearchCatgSQL(gscProductBaRcode));
            SQL.add('null,');
            SQL.add('null,');
            sql.Add('PartName as Company, "Product" as Type,');
            SQL.add('"" as GlobalRef,');
            SQL.add('convert(0, DateTime)  as Date,');
            SQL.add('null as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('EP.PartsId,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM tblPartBarCodes EP');
            SQL.add('INNER JOIN tblParts P on P.PartsId = EP.PartsId');
            SQL.Add('WHERE 1=1');
            AddFilters('EP.BarCode;SupplierProductCode;ProductCode');

            SQL.add('UNION  ');
            SQL.Add('SELECT  ');
            SQL.add(GlobalSearchCatgSQL(gscParts));
            SQL.Add('null,');
            SQL.Add('null,');
            sql.Add('PartName as Company, "Product" as Type,');
            SQL.Add('"" as GlobalRef,');
            SQL.Add('convert(0, DateTime)  as Date,');
            SQL.Add('null as TransID,');
            SQL.Add('0 as SaleID,');
            SQL.Add('0 as PurchaseOrderID,');
            SQL.Add('0 as PaymentID,');
            SQL.Add('0 as PrepaymentID,');
            SQL.Add('0 as FixedAssetID,');
            SQL.Add('PartsId,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.Add('FROM tblParts P');
            SQL.Add('WHERE  PartsId not in (SELECT distinct PartsId FROM tblPartBarCodes)');
            AddFilters('Partname;BarCode;SupplierProductCode;ProductCode');

            SQL.add('UNION  ');
            SQL.Add('SELECT  ');
            SQL.add(GlobalSearchCatgSQL(gscCOA));
            SQL.Add('null,');
            SQL.Add('null,');
            sql.Add('AccountName as Company, "Account" as Type,');
            SQL.Add('"" as GlobalRef,');
            SQL.Add('convert(0, DateTime)  as Date,');
            SQL.Add('null as TransID,');
            SQL.Add('0 as SaleID,');
            SQL.Add('0 as PurchaseOrderID,');
            SQL.Add('0 as PaymentID,');
            SQL.Add('0 as PrepaymentID,');
            SQL.Add('0 as FixedAssetID,');
            SQL.Add('0 as PartsId,');
            SQL.Add('AccountID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.Add('FROM tblchartofaccounts COA');
            SQL.Add('WHERE 1=1');
            AddFilters('AccountName;Level1;Level2;Level3;Level4');




            if isnumeric(fsSQLSearchName)  then begin
{-----Journal Entry}fsSearchhint:= fsSearchhint +NL+'        '+'Journal Entry -> Total Amount';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gsctblGE));
              SQL.add('null, ');
              SQL.add('null, ');
              SQL.add('null , ');
              SQL.add('"Journal Entry" as type, ');
              SQL.add('GEDetails.globalref, ');
              SQL.add('convert(GEDetails.transactiondate, dateTime) as TransDate,');
              SQL.add('GEDetails.GJID as TransID,');
              SQL.add('GEDetails.GJID as SaleID,');
              SQL.add('0 as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  (SELECT GE.GJID, GE.globalref,GE.transactionDate,'+
                              ' sum(GED.DebitAmount) as DebitAmount , '+
                              ' Sum(GED.DebitAmountInc) as DebitAmountInc ,'+
                              ' sum(GED.CreditAmount) as CreditAmount , '+
                              ' Sum(GED.CreditAmountInc) as CreditAmountInc ,'+
                              ' GE.deleted '+
                              ' FROM  tblgeneraljournal GE '+
                              ' INNER JOIN tblgeneraljournaldetails GED on GE.GJID = GED.GJID  group by GE.GJID) GEDetails');
              SQL.add('WHERE deleted ="F" ');
              if (strToFloat(fsSQLSearchName)=0) then
                  SQL.add('and ifnull(DebitAmount,0) =0 and ifnull(DebitAmountInc,0) =0 and ifnull(CreditAmount,0) =0 and ifnull(CreditAmountInc,0) =0 ')
              else Addfilters('DebitAmount;DebitAmountInc;CreditAmount;CreditAmountInc', gsftFloat);
            end;

{-----Fixed Asset}fsSearchhint:= fsSearchhint +NL+'        '+'Fixed Asset -> Name, Description, Asset Type';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gscFA));
              SQL.add('null, ');
              SQL.add('null, ');
              SQL.add('FA.AssetName , ');
              SQL.add('"Fixed Asset" as type, ');
              SQL.add('"" as globalref, ');
              SQL.add('Null as TransDate,');
              SQL.add('FA.AssetID as TransID,');
              SQL.add('0 as SaleID,');
              SQL.add('0 as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  tblfixedassets FA');
              SQL.add('WHERE AssetName <> "" ');
              Addfilters('AssetName;Description');

{-----Cancelled Sales}fsSearchhint:= fsSearchhint +NL+'        '+'Sales(Cash-Sale, Invoice, Invoice-BO, POS, Quote, Refund, Sales Order, Sales Order-BO ) -> Customer Name/globalref/ ID, Docno';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gsctblCancelledSL));
              SQL.add('S.clientId, ');
              SQL.add('S.clientId, ');
              SQL.add('S.CustomerName, ');
              SQL.add('"Customer Name / Customer''s Sale" as type, ');
              SQL.add('S.globalref, ');
              SQL.add('convert(S.SaleDate, dateTime) as TransDate,');
              SQL.add('S.saleID as TransID,');
              SQL.add('S.saleID as SaleID,');
              SQL.add('0 as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  tblsales S');
              SQL.add('WHERE (deleted ="T" OR Cancelled="R" )');
              Addfilters('S.customername;S.Globalref;S.SaleID;S.InvoiceDocNumber');
{-----cancelled PO}fsSearchhint:= fsSearchhint +NL+'        '+'Purchase Order(PO, PO-BO, Credit, Cheque, Bill, Return Authority) -> Supplier Name, Globalref, ID , Doc Number';
              SQL.add('UNION ');
              SQL.add('SELECT distinct ');
              SQL.add(GlobalSearchCatgSQL(gsctblCancelledPO));
              SQL.add('P.clientId, ');
              SQL.add('P.clientId, ');
              SQL.add('P.SupplierName , ');
              SQL.add('CONCAT("Cancelled ", ' + ProductQtylib.POType('P', 'Purchase') + ') as `Type`, ');
              SQL.add('P.globalref, ');
              SQL.add('convert(P.OrderDate, dateTime) as TransDate,');
              SQL.add('P.PurchaseOrderID as TransID,');
              SQL.add('0 as SaleID,');
              SQL.add('P.PurchaseOrderID as PurchaseOrderID,');
              SQL.add('0 as PaymentID,');
              SQL.add('0 as PrepaymentID,');
              SQL.add('0 as FixedAssetID,');
              SQL.add('0 as PartsID,');
              SQL.add('0 as AccountsID, ');
              SQL.add('0 as StockAdjustID, ');
              SQL.add('"F" as IsProcessed');
              SQL.add('FROM  tblPurchaseOrders P');
              SQL.add('WHERE  (deleted ="T" OR Cancelled="T" )');
              Addfilters('P.Suppliername;P.Globalref;P.PurchaseOrderId;P.PurchaseOrderNumber');
{-----cancelled Repairs}fsSearchhint:= fsSearchhint +NL+'        '+'Repair -> Customer Name/Global Ref';
            SQL.add('UNION ');
            SQL.add('SELECT ');
            SQL.add(GlobalSearchCatgSQL(gsctblCancelledRP));
            SQL.add('`R`.`CusID`, ');
            SQL.add('`R`.`CusID`, ');
            SQL.add('`C`.`Company`, ');
            SQL.add('"Cancelled Repairs" AS `Type`, ');
            SQL.add('`R`.`GlobalRef`, ');
            SQL.add('convert(`R`.`JobDueDate`, dateTime) as TransDate,');
            SQL.add('`R`.`RepairID` as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('"F" as IsProcessed');
            SQL.add('FROM  `tblrepairs` AS `R` Inner Join `tblclients` AS `C` ON `C`.`ClientID` = `R`.`CusID`');
            SQL.add('WHERE  Cancelled ="T"');
            (*Addfilter('C.company');*)
            Addfilters('C.company;R.Globalref');

{-----Stock Adjust}fsSearchhint := fsSearchhint + NL + '        ' + 'Stock Adjustment -> ';
            SQL.add('UNION ');
            SQL.add('SELECT Distinct ');
            SQL.add(GlobalSearchCatgSQL(gscStockAdjust));
            SQL.add('Null as ClientID, ');
            SQL.add('A.StockAdjustEntryID  as ID, ');
            // binny : TODO - showing the serial number added to type for the time being, we should add Searching field as a value column
            //SQL.add('Null as Company, ');
            SQL.add('convert(Concat_WS("_", "Stock Adjustment", AL.Serialnumber,AL.serialnos) , CHAR(255)) AS Company,  ');
            SQL.add('"Stock Adjustment"  AS `Type`,  ');
            SQL.add('A.globalRef as GlobalRef, ');
            SQL.add('CONVERT(A.AdjustmentDate, DateTime) as TransDate,');
            SQL.add('A.StockAdjustEntryID  as TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('A.StockAdjustEntryID as StockAdjustID, ');
            SQL.add('A.Processed as IsProcessed');
            SQL.add('FROM tblStockAdjustEntryLines AL INNER JOIN tblStockAdjustEntry A ON AL.StockAdjustEntryID=A.StockAdjustEntryID');
            SQL.add('WHERE A.Deleted="F"');
            AddFilters('A.StockAdjustEntryID;AL.Serialnumber;AL.serialnos');

{-----Stock Transfer}fsSearchhint := fsSearchhint + NL + '        ' + 'Stock Transfer -> ';
            SQL.add('UNION ');
            SQL.add('SELECT Distinct ');
            SQL.add(GlobalSearchCatgSQL(gscStockAdjust));
            SQL.add('Null as ClientID, ');
            SQL.add('T.TransferEntryID as ID, ');
            // binny : TODO - showing the serial number added to type for the time being, we should add Searching field as a value column
            //SQL.add('Null as Company, ');
            SQL.add('Convert(concat_WS("-", "Stock Transfer",pqad.PQAType, pqad.Value,TL.serialnos) , CHAR(255)) AS Company,  ');
            SQL.add('"Stock Transfer" `Type`,  ');
            SQL.add('T.globalref as GlobalRef, ');
            SQL.add('CONVERT(T.DateTransferred, DateTime) as TransDate,');
            SQL.add('T.TransferEntryID AS TransID,');
            SQL.add('0 as SaleID,');
            SQL.add('0 as PurchaseOrderID,');
            SQL.add('0 as PaymentID,');
            SQL.add('0 as PrepaymentID,');
            SQL.add('0 as FixedAssetID,');
            SQL.add('0 as PartsID,');
            SQL.add('0 as AccountsID, ');
            SQL.add('0 as StockAdjustID, ');
            SQL.add('T.Processed as IsProcessed');
            SQL.add('FROM tblStockTransferEntryLines TL INNER JOIN tblStockTransferEntry T ON TL.TransferEntryID=T.TransferEntryID');
            SQL.add('LEFT JOIN tblstocktransferentrypqa pqa ON pqa.TransLineID = TL.TransferEntryLinesID');
            SQL.add('LEFT JOIN tblstocktransferentrypqadetails pqad ON pqa.pqaid = pqad.pqaid');
            SQL.add('WHERE T.Deleted="F"');
            AddFilters('T.TransferEntryID;pqad.Value;TL.serialnos');

      SQL.Add(') T');

      if (fSearchType <> '') then
        SQL.Add(' WHERE T.`Type`="' + fSearchType + '"');

      SQL.Add('ORDER BY Company, Catg, Type, TransId');

      (*      SQL.text := ChangeQuery(SQL.text);
      clog(SQL.text);*)
      //Showcontrolhint(grdmain, fsSearchhint);

end;

procedure TGlobalSearchReport.SetSearchName(const Value: String);
begin
  fSearchName := Value;
  fsSQLSearchName := StringReplace(fSearchName, '\', '\\', [rfREplaceAll]);
end;

procedure TGlobalSearchReport.SetSearchType(const Value: String);
begin
  fSearchType := Value;
  fsSQLSearchType := StringReplace(fSearchType, '\', '\\', [rfREplaceAll]);
end;

function TGlobalSearchReport.GlobalSearchCatgNo(catg: TGlobalSearchCategory): Integer;
begin
                            if catg = gscClients        then Result := 1
                       else if catg = gscMC             then Result := 2
                       else if catg = gscEmp            then Result := 3
                       else if catg = gscClientcontact  then Result := 4
                       else if catg = gscMCContact      then Result := 5
                       else if catg = gscSO_BO          then Result := 6
                       else if catg = gscInv_BO         then Result := 7
                       else if catg = gscQuote          then Result := 8
                       else if catg = gscCashSale       then Result := 9
                       else if catg = gscPOS            then Result := 10
                       else if catg = gscRefund         then Result := 11
                       else if catg = gscRepair         then Result := 12
                       else if catg = gscSO             then Result := 13
                       else if catg = gscInvoice        then Result := 14
                       else if catg = gscPO_BO          then Result := 15
                       else if catg = gscPO             then Result := 16
                       else if catg = gscCredit         then Result := 17
                       else if catg = gscCheque         then Result := 18
                       else if catg = gscBill           then Result := 19
                       else if catg = gscRA             then Result := 20
                       else if catg = gscTransName      then Result := 21
                       else if catg = gscAmt            then Result := 22
                       else if catg = gscExtraPrice     then Result := 23
                       else if catg = gscProductBaRcode then Result := 24
                       else if catg = gscParts          then Result := 25
                       else if catg = gsctblPO          then Result := 26
                       else if catg = gsctblSales       then Result := 27
                       else if catg = gsctblGE          then Result := 28
                       else if catg = gscFA             then Result := 29
                       else if catg = gsctblCancelledPO then Result := 30
                       else if catg = gsctblCancelledSL then Result := 31
                       else if catg = gsctblCancelledRP then Result := 32
                       else if catg = gscCOA            then Result := 33
                       else if catg = gscStockAdjust    then Result := 34
                       else if catg = gscStockTransfer  then Result := 35
                       else result := 0;
end;

function TGlobalSearchReport.GlobalSearchCatgStrDesc( catg: TGlobalSearchCategory): String;
begin
                            if catg = gscClients        then Result := 'Client'
                       else if catg = gscMC             then Result := 'Marketing Contact'
                       else if catg = gscEmp            then Result := 'Employee'
                       else if catg = gscClientcontact  then Result := 'Client - Contact'
                       else if catg = gscMCContact      then Result := 'Marketing Contact - Contact'
                       else if catg = gscSO_BO          then Result := 'SO - BO'
                       else if catg = gscInv_BO         then Result := 'Inv - BO'
                       else if catg = gscQuote          then Result := 'Quote'
                       else if catg = gscCashSale       then Result := 'Cash Sale'
                       else if catg = gscPOS            then Result := 'POS'
                       else if catg = gscRefund         then Result := 'Refund'
                       else if catg = gscRepair         then Result := 'Repair'
                       else if catg = gscSO             then Result := 'Sales Order'
                       else if catg = gscInvoice        then Result := 'Invoice'
                       else if catg = gscPO_BO          then Result := 'PO-BO'
                       else if catg = gscPO             then Result := 'Purchase Order'
                       else if catg = gscCredit         then Result := 'Credit'
                       else if catg = gscCheque         then Result := 'cheque'
                       else if catg = gscBill           then Result := 'Bill'
                       else if catg = gscRA             then Result := 'Return Authority'
                       else if catg = gscTransName      then Result := 'General Ledger'
                       else if catg = gscAmt            then Result := 'General Ledger Amount'
                       else if catg = gscExtraPrice     then Result := 'Extra Price'
                       else if catg = gscProductBaRcode then Result := 'Product Barcode'
                       else if catg = gscParts          then Result := 'Product'
                       else if catg = gsctblPO          then Result := 'PO Total'
                       else if catg = gsctblSales       then Result := 'Sales total'
                       else if catg = gsctblGE          then Result := 'Journal Total'
                       else if catg = gscFA             then Result := 'Fixed Asset'
                       else if catg = gsctblCancelledPO then Result := 'Cancelled PO'
                       else if catg = gsctblCancelledSL then Result := 'Cancelled Sales'
                       else if catg = gsctblCancelledRP then Result := 'Cancelled Repair'
                       else if catg = gscCOA            then Result := 'Accounts'
                       else if catg = gscStockAdjust    then Result := 'Stock Adjustment'
                       else if catg = gscStockTransfer  then Result := 'Stock Transfer'
                       else result := '';


end;

function TGlobalSearchReport.GlobalSearchCatgStr(catg: TGlobalSearchCategory): String;
begin
  result := IntToStr(GlobalSearchCatgNo(catg));
end;

Function TGlobalSearchReport.GlobalSearchCatgSQL( catg: TGlobalSearchCategory): String;
begin
    Result := GlobalSearchCatgStr(catg) + ' as Catg, ' + NL +
              Quotedstr(GlobalSearchCatgStrDesc(catg)) + ' as CatgDesc, ';
end;

initialization
  RegisterClass(TGlobalSearchReport);

end.
