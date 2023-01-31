unit SalesListSQL;

interface

uses
  classes, ReportBaseObj;

Type

  TSalesList = class(TReportWithDateRangeBase)

  Private

    fPaid                     : Boolean;
    fUnPaid                   : Boolean;

    fbIncludeIsCashSale       : Boolean;
    fbIncludeIsPOS            : Boolean;
    fbIncludeIsRefund         : Boolean;
    fbIncludeIsQuote          : Boolean;
    fbIncludeIsLaybyPayment   : Boolean;
    fbIncludeIslayby          : Boolean;
    fbIncludeIsInvoice        : Boolean;
    fbIncludeIsVoucher        : Boolean;
    fbIncludeIsCustomerReturn : Boolean;
    fbIncludeISSalesOrder     : Boolean;
    fbIsDetailReport          : Boolean;
    ficlientId                : integer;
    fiClassId                 : integer;
    fiEmployeeId              : integer;
    fbByEmployee              : Boolean;
    fbByCustomer              : Boolean;
  Protected
    Function SalestypeFilter:String;


  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published

    property Paid: boolean read fPaid write fPaid;
    property Unpaid: boolean read fUnpaid write fUnpaid;

    property IncludeIsCashSale      : Boolean   read fbIncludeIsCashSale   Write fbIncludeIsCashSale ;
    property IncludeIsPOS           : Boolean   read fbIncludeIsPOS        Write fbIncludeIsPOS  ;
    property IncludeIsRefund        : Boolean   read fbIncludeIsRefund     Write fbIncludeIsRefund ;
    property IncludeIsQuote         : Boolean   read fbIncludeIsQuote      Write fbIncludeIsQuote ;
    property IncludeIsLaybyPayment  : Boolean   read fbIncludeIsLaybyPayment  Write fbIncludeIsLaybyPayment ;
    property IncludeIslayby         : Boolean   read fbIncludeIslayby         Write fbIncludeIslayby  ;
    property IncludeIsInvoice       : Boolean   read fbIncludeIsInvoice       Write fbIncludeIsInvoice ;
    property IncludeIsVoucher       : Boolean   read fbIncludeIsVoucher       Write fbIncludeIsVoucher ;
    property IncludeIsCustomerReturn: Boolean   read fbIncludeIsCustomerReturn  Write fbIncludeIsCustomerReturn ;
    property IncludeISSalesOrder    : Boolean   read fbIncludeISSalesOrder     Write fbIncludeISSalesOrder ;

    Property IsDetailReport         : Boolean   write fbIsDetailReport ;
(*    property DateFrom               : TDateTime write fDateFrom ;
    property DateTo                 : TDateTime write fDateTo ;*)
    Property ClientId               : Integer   write ficlientId;
    Property ClassId                : Integer   write fiClassId;
    Property EmployeeId             : Integer   write fiEmployeeId;
    property ByEmployee             : Boolean   Write fbByEmployee  ;
    property ByCustomer             : Boolean   Write fbByCustomer  ;

  end;



implementation

uses sysutils, ProductQtyLib, Dialogs;

{ TSalesList }

constructor TSalesList.Create;
begin
  inherited;
  DateFrom             := MinDateTime;
  DateTo               := MaxDateTime;
  ficlientId            := 0;
  fiClassId             := 0;
  fiEmployeeId          := 0;
  fbByEmployee          := False;
  fbByCustomer          := False;

  fPaid := true;
  fUnPaid := true;

  fbIncludeIsRefund        := True;
  fbIncludeIsInvoice       := True;
  fbIncludeISSalesOrder    := True;
  fbIncludeIsQuote         := False;

//  fbIncludeIsPOS           := False;
//  fbIncludeIsCashSale      := False;
//  fbIncludeIsLaybyPayment  := False;
//  fbIncludeIslayby         := False;
//  fbIncludeIsVoucher       := False;
//  fbIncludeIsCustomerReturn:= False;
//  fbIsDetailReport         := False;

  fbIncludeIsPOS           := True;
  fbIncludeIsCashSale      := True;
  fbIncludeIsLaybyPayment  := True;
  fbIncludeIslayby         := True;
  fbIncludeIsVoucher       := True;
  fbIncludeIsCustomerReturn:= True;
  fbIsDetailReport         := True;


end;


(*function TSalesList.DateFromSQL: string;
begin
  REsult := DateSQL(fDateFrom, 'DateFrom');
end;
function TSalesList.DateToSQL: string;
begin
  REsult := DateSQL(fDateTo, 'DateTo');
end;*)


function TSalesList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

  SQL.Clear;
  result := inherited;

  SQL.Add('Select Distinct ');
  SQL.Add('S.SaleId                     AS SaleId,');
  SQL.Add('S.clientid                   AS ClientId,');
  SQL.Add('S.InvoiceDocNumber           AS Saleno,');
  SQL.Add('S.BOID                       AS BORef,');
  SQL.Add('S.Customername               AS CustomerName,');
  SQL.Add('S.ClientPrintName            AS PrintName,');
  SQL.Add(SaleType                   +' AS Type,');
  SQL.Add('S.totalAmountinc             AS TotalAmountinc,');
  SQL.Add('S.TotalTax                   AS TotalTax,');
  SQL.Add('S.totalAmount                AS TotalAmount,');
  SQL.Add('S.Payment                    AS Payment,');
  SQL.Add('S.Paid                       AS Paid,');
  SQL.Add('S.balance                    AS Balance,');
  SQL.Add('S.SaleDate                   AS SaleDate,');
  SQL.Add('S.Converted                  AS Converted,');
  SQL.Add('S.futureSo                   AS futureSo,');
  SQL.Add('S.Deleted                    AS Done,');
  SQL.Add('S.QuoteStatus                AS Status,');
  SQL.Add('S.ShipDate                   AS shipdate,');
  SQL.Add('S.HoldSale                   AS held,');
  SQL.Add('S.PONumber                   AS PONumber,');
  SQL.Add('S.terms                      AS terms,');
  SQL.Add('S.Comments                   AS Comments,');
  SQL.Add('S.Class                      AS ClassName,');
  SQL.Add('S.dueDate                    AS dueDate,');
  SQL.Add('S.employeename               AS employeename ,');
  SQL.Add('S.employeeid                 AS employeeid,');
  SQL.Add('S.IsCashSale                 AS IsCashSale,');
  SQL.Add('S.IsPOS                      AS IsPOS ,');
  SQL.Add('S.IsRefund                   AS IsRefund,');
  SQL.Add('S.ISSalesOrder               AS ISSalesOrder,');
  SQL.Add('S.IsQuote                    AS IsQuote,');
  SQL.Add('S.IsLaybyPayment             AS IsLaybyPayment,');
  SQL.Add('S.Islayby                    AS Islayby ,');
  SQL.Add('S.IsInvoice                  AS IsInvoice,');
  SQL.Add('S.IsVoucher                  AS IsVoucher,');
  SQL.Add('S.IsCustomerReturn           AS IsCustomerReturn,');
  SQL.Add('S.SaleCustField1             AS SaleCustField1,');
  SQL.Add('S.SaleCustField2             AS SaleCustField2,');
  SQL.Add('S.SaleCustField3             AS SaleCustField3,');
  SQL.Add('S.SaleCustField4             AS SaleCustField4,');
  SQL.Add('S.SaleCustField5             AS SaleCustField5,');
  SQL.Add('S.SaleCustField6             AS SaleCustField6,');
  SQL.Add('S.SaleCustField7             AS SaleCustField7,');
  SQL.Add('S.SaleCustField8             AS SaleCustField8,');
  SQL.Add('S.SaleCustField9             AS SaleCustField9,');
  SQL.Add('S.SaleCustField10            AS SaleCustField10,');

  if fbIsDetailReport  then begin
    SQL.Add('SL.ProductID               AS ProductId,');
    SQL.Add('SL.ProductName             AS Productname,');
    SQL.Add('SL.UnitofMeasureQtySold    AS UnitofMeasureQtySold,');
    SQL.Add('SL.UnitofMeasureShipped    AS UnitofMeasureShipped,');
    SQL.Add('SL.UnitofMeasureBackorder  AS UnitofMeasureBackorder,');
    SQL.Add('SL.TotalLineAmount         AS TotalLineAmount,');
    SQL.Add('SL.TotalLineAmountInc      AS TotalLineAmountInc,');
    SQL.Add('concat(SL.UnitofMeasureSaleLines , "(", SL.UnitofMeasureMultiplier,")")      AS UOM,');
  end;

  if fbIsDetailReport  then
     SQL.Add('if((S.ISSalesOrder="T" OR S.isinvoice="T") AND SL.Invoiced ="F", "T" , "F")  AS isbackOrder')
  else
     SQL.Add('if((S.ISSalesOrder="T" OR S.isinvoice="T"), "T" , "F")  AS isbackOrder')
  ;

  SQL.Add('From tblSales S');

  if fbIsDetailReport  then
     SQL.Add('inner join tblsaleslines SL on S.saleID = SL.SaleId  and SL.Deleted ="F" ');

  SQL.Add('WHERE S.Deleted ="F" and S.Cancelled ="F" and  S.saleDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
  if ficlientID   <> 0 then SQL.add('AND (S.clientId ='  +inttostr(ficlientID)  +')');
  if fiClassId    <> 0 then SQL.add('AND (S.ClassID ='  +inttostr(fiClassId)  +')');
  if fiEmployeeId <> 0 then SQL.add('AND (S.EmployeeId ='+inttostr(fiEmployeeId)+')');
  SQL.Add('AND (S.converted ="F" or (S.ISSalesOrder="T" and S.IsInternalOrder ="T"))');


   if Paid and Unpaid then
   begin
      SQL.Add(' AND (S.Paid = "T" OR S.Paid = "F")')
   end
   else
   begin
      if Paid or not Unpaid then
         SQL.Add(' AND S.Paid = "T"')
      else
         SQL.Add(' AND S.Paid = "F"');

//      if Unpaid then
//         SQL.Add(' AND S.Paid = "F" ')
//      else
//         SQL.Add(' AND S.Paid = "T" ');
   end;


//  if ficlientId <> 0 then
//      SQL.Add('AND (S.clientId = ' + IntToStr(ficlientId) + ')');



    SQL.Add(SalestypeFilter);

//     ShowMessage('Search ' + Search);

    if not (Search = '') then
      SQL.Add('AND ' + Search);

  if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


//  if fbByEmployee then SQL.Add('Order by S.employeename,  S.saleId desc')
//  else if fbByCustomer then SQL.Add('Order by S.CustomerName,  S.saleId desc')
//  else SQL.Add('Order by S.saleId desc');

end;


function TSalesList.SalestypeFilter: String;
begin

  if not(fbIncludeIsCashSale      ) then Result := Result +' and S.IsCashSale      = "F"';
  if not(fbIncludeIsPOS           ) then Result := Result +' and S.IsPOS           = "F"';
  if not(fbIncludeIsRefund        ) then Result := Result +' and S.IsRefund        = "F"';
  if not(fbIncludeIsQuote         ) then Result := Result +' and S.IsQuote         = "F"';
  if not(fbIncludeIsLaybyPayment  ) then Result := Result +' and S.IsLaybyPayment  = "F"';
  if not(fbIncludeIslayby         ) then Result := Result +' and S.Islayby         = "F"';
  if not(fbIncludeIsInvoice       ) then Result := Result +' and S.IsInvoice       = "F"';
  if not(fbIncludeIsVoucher       ) then Result := Result +' and S.IsVoucher       = "F"';
  if not(fbIncludeIsCustomerReturn) then Result := Result +' and S.IsCustomerReturn= "F"';
  if not(fbIncludeISSalesOrder    ) then Result := Result +' and S.IsSalesOrder    = "F"';

end;



initialization

  RegisterClass(TSalesList);

end.
