unit BankDepositSQL;


interface

uses
  classes, ReportBaseObj;

Type

  TBankDepositList = class(TReportWithDateRangeBase)

  Private
    fbIncludeIsCashSale       : Boolean;
    fbIncludeIsPOS            : Boolean;
    fbIncludeIsRefund         : Boolean;
    fbIncludeIsQuote          : Boolean;
    fbIncludeIsLaybyPayment   : Boolean;
    fbIncludeIslayby          : Boolean;
    fbIncludeIsInvoice        : Boolean;
    fbIncludeIsVoucher        : Boolean;
    fbIncludeIsCustomerReturn : Boolean;
(*    fDateTo                   : TDateTime;
    fDateFrom                 : TDateTime;*)
    fbIncludeISSalesOrder     : Boolean;
    fbIsDetailReport          : Boolean;

    ficlientId                : integer;
    fiClassId                 : integer;
    fiEmployeeId              : integer;

    fsEmployeeName            : string;
    fsAccountName             : string;
    fsDepositClassName        : string;

    fbByDepositID             : string;

    fbByEmployee              : Boolean;
    fbByCustomer              : Boolean;
(*    function DateFromSQL      : string;
    function DateToSQL        : string;*)

  Protected
    Function SalestypeFilter:String;


  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published
//    property IncludeIsCashSale      : Boolean   Write fbIncludeIsCashSale ;
//    property IncludeIsPOS           : Boolean   Write fbIncludeIsPOS  ;
//    property IncludeIsRefund        : Boolean   Write fbIncludeIsRefund ;
//    property IncludeIsQuote         : Boolean   Write fbIncludeIsQuote ;
//    property IncludeIsLaybyPayment  : Boolean   Write fbIncludeIsLaybyPayment ;
//    property IncludeIslayby         : Boolean   Write fbIncludeIslayby  ;
//    property IncludeIsInvoice       : Boolean   Write fbIncludeIsInvoice ;
//    property IncludeIsVoucher       : Boolean   Write fbIncludeIsVoucher ;
//    property IncludeIsCustomerReturn: Boolean   Write fbIncludeIsCustomerReturn ;
//    property IncludeISSalesOrder    : Boolean   Write fbIncludeISSalesOrder ;

//    Property IsDetailReport         : Boolean   write fbIsDetailReport ;
(*    property DateFrom               : TDateTime write fDateFrom ;
    property DateTo                 : TDateTime write fDateTo ;*)

//    Property ClientId               : Integer   write ficlientId;
//    Property ClassId                : Integer   write fiClassId;
//    Property EmployeeId             : Integer   write fiEmployeeId;
//
//    property EmployeeName           : string    read fsEmployeeName       write fsEmployeeName;
//    property AccountName            : string    read fsAccountName        write fsAccountName;
//    property ClassName              : string    read fsDepositClassName   write fsDepositClassName;
//
//    property ByDepositID            : string    write fbByDepositID  ;
//
//    property ByEmployee             : Boolean   Write fbByEmployee  ;
//    property ByCustomer             : Boolean   Write fbByCustomer  ;

  end;

implementation

uses sysutils, ProductQtyLib;

{ TSalesList }

constructor TBankDepositList.Create;
begin
  inherited;
  DateFrom             := MinDateTime;
  DateTo               := MaxDateTime;
  ficlientId            := 0;
  fiClassId             := 0;
  fiEmployeeId          := 0;
  fbByEmployee          := False;
  fbByCustomer          := False;
  fsAccountName         := 'Bank';
  fsEmployeeName        := '';
  fsDepositClassName    := '';


  fbIncludeIsRefund        := True;
  fbIncludeIsInvoice       := True;
  fbIncludeISSalesOrder    := True;
  fbIncludeIsQuote         := True;

  fbIncludeIsPOS           := False;
  fbIncludeIsCashSale      := False;
  fbIncludeIsLaybyPayment  := False;
  fbIncludeIslayby         := False;
  fbIncludeIsVoucher       := False;
  fbIncludeIsCustomerReturn:= False;
  fbIsDetailReport         := False;
end;


(*function TSalesList.DateFromSQL: string;
begin
  REsult := DateSQL(fDateFrom, 'DateFrom');
end;
function TSalesList.DateToSQL: string;
begin
  REsult := DateSQL(fDateTo, 'DateTo');
end;*)


function TBankDepositList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  Result := inherited;

  SQL.Add('SELECT tblbankdeposit.*, tblemployees.EmployeeName, tblchartofaccounts.AccountName FROM tblbankdeposit');
  SQL.Add('INNER JOIN tblemployees ON tblbankdeposit.EmployeeID = tblemployees.EmployeeId');
  SQL.Add('INNER JOIN tblchartofaccounts ON tblbankdeposit.AccountID = tblchartofaccounts.AccountId');
 //  SQL.Add('SELECT Header.* FROM tblbankdeposit as Header ' +
 //   ' inner join tblbankdepositLines as Details on Header.depositId = Details.DepositId');
  SQL.Add('WHERE tblbankdeposit.DepositDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);
  //      SQL.Add('ORDER BY tblbankdeposit.' + OrderBy);

  Exit;


   if (fbByDepositID = '') or (fbByDepositID = 'asc') then
      SQL.Add('ORDER BY tblbankdeposit.DepositID asc')
   else if fbByDepositID ='desc' then
      SQL.Add('ORDER BY tblbankdeposit.DepositID desc');

  Exit;

  SQL.Add('Select Distinct ');
  SQL.Add('S.clientid                   AS ClientId,');
  SQL.Add('S.InvoiceDocNumber           AS Saleno,');
  SQL.Add('S.SaleId                     AS SaleId,');
  SQL.Add('S.BOID                       AS BORef,');
  SQL.Add('S.Customername               AS CustomerName,');
  SQL.Add('S.ClientPrintName            AS PrintName,');
  SQL.Add(SaleType                   +' AS Type,');
  SQL.Add('S.totalAmountinc             AS TotalAmountinc,');
  SQL.Add('S.TotalTax                   AS TotalTax,');
  SQL.Add('S.totalAmount                AS TotalAmount,');
  SQL.Add('S.Payment                    AS Payment,');
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

  SQL.Add('if((S.ISSalesOrder="T" OR S.isinvoice="T") AND SL.Invoiced ="F", "T" , "F")  AS isbackOrder');
  SQL.Add('From tblSales S');
  SQL.Add('inner join tblsaleslines SL on S.saleID = SL.SaleId');
  SQL.Add('WHERE  S.saleDate Between ' + DateFromSQL + ' AND ' + DateToSQL);

  if ficlientID   <> 0 then SQL.add('AND (S.clientId ='  +inttostr(ficlientID)  +')');
  if fiClassId    <> 0 then SQL.add('AND (S.ClassID ='  +inttostr(fiClassId)  +')');
  if fiEmployeeId <> 0 then SQL.add('AND (S.EmployeeId ='+inttostr(fiEmployeeId)+')');

  SQL.Add('AND (S.converted ="F" or (S.ISSalesOrder="T" and S.IsInternalOrder ="T"))');
  SQL.Add(SalestypeFilter);

  if fbByEmployee then
    SQL.Add('Order by S.employeename,  S.saleId desc')
  else if fbByCustomer then
    SQL.Add('Order by S.CustomerName,  S.saleId desc')
  else
    SQL.Add('Order by S.saleId desc');

end;

function TBankDepositList.SalestypeFilter: String;
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

  RegisterClass(TBankDepositList);

end.
