unit ProductQtyLib;

interface

uses classes, controls, pqalib;

type

  TFiltertype = (tFilterNone = 0, tProductList = 1, tSummary = 2, tDetails = 3, tExtraDetails = 4,
    tDetailswithSno = 5, tSerialnoList = 6, tFtAll = 7);

Function NonStockQtySummary       (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN: Boolean = True; gLevel: integer = 1): String;
Function StockQtySummary          (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN:Boolean =True; haveActStockwithManQty :Boolean = False): String;
Function StockQtyNonAllocProducts (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0): string;
Function StockQtyDetails          (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): string;
Function StockQtyExtraDetails     (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): String;
Function StockQtyDetailswithSno   (Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; IncludeOrderBy: boolean = true; haveActStockwithManQty :Boolean = False): String;
Function Serialnumberlist         (Const ProductID: Integer = 0; const classID: Integer = 0;TransDate: TDatetime = 0; dateFrom: TDatetime = 0; Dateto: TDatetime = 0; IncludeOrderBy: boolean = true; extrafields:String =''): String;
Function SerialnumberRecord       (Const ProductID: Integer; const classID: Integer ;aSerialnumber:String):String;

Function ProductUOMSQL(const Tablename:String):String; overload;
Function ProductUOMSQL(ProductID:Integer):String;overload;
Function ProductUOMSQL:String;overload;
function TransTables(mode: TFiltertype;TranslineTableAlias, HeaderIDfield,LineIDfield, TransTypes:String;aliasSuffix:String =''):String;
function ProductTables(mode: TFiltertype; FilterAvailableSN: Boolean = True;
  IncludeTransType: Boolean = False; CurSNIDtoExclude: Integer = 0;
  ExcludeifAllocationnotmode: Boolean = True; aAsOnDAte:TDatetime =0;
  UseasOndateTime :Boolean =False): String;
function QtytypetoDesc(Qtytype: TQtytype): String;
function QtyDesctoType(Desc:String):  TQtytype;

{ Public functions }
Function StockQty(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; Const mode: TFiltertype = tSummary;
  Const TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): String;
Function SQL4ProductAvailableQty(Const asOndate: TDatetime = 0; Const fUOM: String = '';
  Const DetailType: TFiltertype = tSummary; Const fiproductID: Integer = 0;
  Const ficlassid: Integer = 0; Const fsBatchno: String = ''; Const fdExpiryDate: TDatetime = 0;
  Const fsbinlocation: String = ''; Const fsBinnumber: String = '';
  Const fsSerialnumber: String = ''; Qtytype: TQtytype = tAvailable; fExtrafields: String = '';
  fExtraWhere: String = ''; CurSNIDtoExclude: Integer = 0;
  includeDeptFields: Boolean = False;groupbyUOM:Boolean =False; SNIfhasQty:Boolean = TRue): String;
function SQL4ProductQty(Const asOndate: TDatetime = 0; Const fUOM: String = '';
  Const DetailType: TFiltertype = tSummary; Const fiproductID: Integer = 0;
  Const ficlassid: Integer = 0; Const fsBatchno: String = ''; Const fdExpiryDate: TDatetime = 0;
  Const fsbinlocation: String = ''; Const fsBinnumber: String = '';
  Const fsSerialnumber: String = ''; Qtytype: TQtytype = tAvailable; fExtrafields: String = '';
  fExtraWhere: String = ''; CurSNIDtoExclude: Integer = 0;
  includeDeptFields: Boolean = False;groupbyUOM:Boolean =False; SNIfhasQty:Boolean =  True;PQAQtyWhennotAllocated:Boolean =True; UseasOndateTime:Boolean =False): String;
function SQL4Qty(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';const SumfieldName: STring = 'PQA.QTY'): String;
function SQL4QtyAsOnDate(const AsOnDate:TDateTime; const Qtytype: TQtytype; const PQAAlias: String = 'PQA';  const SumfieldName: STring = 'PQA.QTY'): String;
function SQL4QtyField(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';
  const SumfieldName: STring = 'PQA.QTY'): String;
function DetailQtyfield(DetailType: TFiltertype; isUOMQty: Boolean = False; PQAQtyWhennotAllocated :Boolean = False): String;
Function SalesTransTypes: String;
Function PQASQLWithLinks: String;
function POTranstypes: String;
function StockMovementtypes: String;
function ManufactureTypes: String;
function PPGTypes: String;
function Repairtype:String;

Function Firstcolumn(const Parttablealias: String = 'P'): String;
Function Secondcolumn(const Parttablealias: String = 'P'): String;
Function Thirdcolumn(const Parttablealias: String = 'P'): String;
Function SplitField(Tablealias: STring; FieldName: STring; Position: Integer;  Delimeter: String = '^'; RestAll :boolean = False): String;
Function AddressSQL(TableAlias :String ; Includename :Boolean ; title,firstname,middlename, surname, Add1field, Add2Field, Add3Field, CityField, StateField, PostcodeField:String):String;
Function NameSQL(Const TableAlias, title , fistname, middleName, Surname:String) :String;
Function SaleType(const saleTablealias: String = 'S'; unknownmsg :String= 'Unknown'): string;
Function SubTaxcodeCategory(const Tablealias: String = 'STC'): string;
Function SubTaxcodeCategoryNO(const Tablealias: String = 'STC'): string;
Function TransBOType(Transtype: String; Shippedfield: String): string;
Function UOM(Unitfieldname, MultiplierFieldName: String): string;
Function POType(Const POTablealias: String = 'P'; unknownmsg :String= 'Unknown'): String;
Function StockMovementType(Const Tablealias: String = 'SM'): String;

Function ISInvoice(const SalesAlias: String = 'S'): String;
Function ISCashSale(const SalesAlias: String = 'S'): String;
Function ISSO(const SalesAlias: String = 'S'): String;
Function ISActiveSO(const SalesAlias: String = 'S'): String;
Function ISRefund(const SalesAlias: String = 'S'): String;
Function ISquote(const SalesAlias: String = 'S'): String;
Function IsLaybyPayment(const SalesAlias: String = 'S'): String;
Function IsPaidLayby(const SalesAlias: String = 'S'): String;
Function IsReverseLayBy(const SalesAlias: String = 'S'): String;
Function IsUnpaidLayby(const SalesAlias: String = 'S'): String;
Function IsLayby(const SalesAlias: String = 'S'): String;
function ProductPrintTreeSQL(const IDs: String): String;
function salesPrintTreeSQL(const IDs: String(*; tablename :String*)): String;
function ManufactureSubProductSQL(const SubProductID: Integer): String;
Function ReportSQLforBarCodeLabels: String;
function AllocationTables(pqatablename :String = 'tblpqa' ; Alloctablename :String ='tblpqadetails' ):String;
function SalesAllocationTables(pqatablename :String = 'tblpqa' ; Alloctablename :String ='tblpqadetails' ):String;
Function Ifnull(const fieldName:String ; Nullvalue:String =''):String;
Function ClientnameandAddress(Const ClientTableAlias:String ='C'):String;
implementation

uses
  SysUtils, DateUtils, MySQLConst, AppEnvironmentVirtual, tcConst;

Function Ifnull(const fieldName:String ; Nullvalue:String =''):String;
begin
  result:= 'ifnull(' +fieldName+',' +quotedstr(Nullvalue)+')';
end;
Function SplitField(Tablealias: STring; FieldName: STring; Position: Integer;
  Delimeter: String = '^'; RestAll :boolean = False): String;
begin
  if Tablealias <> '' then
    Tablealias := Tablealias + '.';
  if Position = 1 then begin
    result := 'Left(SUBSTRING_INDEX(' + Tablealias + FieldName + ',' + QuotedStr(Delimeter) +      ',1),255)';
  end
  else begin
    result := 'Left(substring(substring_index(' + Tablealias + FieldName + ',' +
      QuotedStr(Delimeter) + ',' + IntToStr(Position) + '),char_length(substring_index(' +
      Tablealias + FieldName + ',' + QuotedStr(Delimeter) + ',' + IntToStr(Position - 1) +
      '))+2),255)';
  end;
end;

Function PQASQLWithLinks: String;
begin
  result := 'SELECT ' +
    ' if (PQA.TRanstype in ('+ POTranstypes + ')  , POL.Shipped ,'+
    ' if(PQA.TRanstype in ('+ StockMovementtypes + ')  , SML.Qty ,'+
    ' if(PQA.TRanstype in ('+ SalesTransTypes + ') , SL.Shipped , '+
    ' if(PQA.TRanstype in ('+ Quotedstr('TSalesOrderInvoiceLines') + ') , SOIL.Qty , '+
    ' if(PQA.TRanstype in ('+ ManufactureTypes + ') , PTP.Qty , '+
    ' if(PQA.TRanstype in ("TProcProgressIn") , PP.Qty,0) ))) )) transqty , ' +
    ' pqa.*  ' + ' FROM tblpqa AS PQA ' +
    ' Left  Join `tblpurchaselines`       AS POL  ON PQA.TransLineID    = POL.PurchaseLineID        and PQA.TRanstype in ('+ POTranstypes + ') ' +
    ' Left  Join `tblpurchaseorders`      AS PO   ON POL.PurchaseOrderID= PO.PurchaseOrderID ' +
    ' Left  Join `tblstockmovementlines`  AS SML  ON PQA.TransLineID    = SML.StockmovementLinesID  and PQA.TRanstype in ('+ StockMovementtypes + ') ' +
    ' Left  Join `tblsaleslines`          AS SL   ON PQA.TransLineID    = SL.SaleLineID             and PQA.TRanstype in ('+ SalesTransTypes + ') ' +
    ' Left  Join `tblsales`               AS S    ON SL.SaleID          = S.SaleID ' +
    ' Left  join  tblsalesorderinvoicelines as SOIL on PQA.transLineId  = SOIL.SOInvoiceLineID  and PQA.transtype = '+quotedstr('TSalesOrderInvoiceLines') +
    ' Left  Join `tblsalesorderinvoices`    AS SOI  ON SOIL.SOInvoiceID = SOI.SOInvoiceID ' +
    ' Left  Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype in ('+ ManufactureTypes + ')'+
    ' Left  join tblprocprogress          as PP   on PP.ProcProgressID  = PQA.TransLineID           and PQA.TRanstype in ("TProcProgressIn");'
end;

Function Firstcolumn(const Parttablealias: String = 'P'): String;
begin
  result := SplitField(Parttablealias, 'ProductGroup', 1);
end;
Function ClientnameandAddress(Const ClientTableAlias:String ='C'):String;
begin
  Result := 'CONCAT_WS(CHAR(13,10),' +
                  'CONCAT_WS(" ", ' + ClientTableAlias +'.Title, ' + ClientTableAlias +'.FirstName, ' + ClientTableAlias +'.LastName), ' +
                  ClientTableAlias +'.Street, ' +
                  'IFNULL(' + ClientTableAlias +'.Street2, ""), ' +
                  'CONCAT_WS("  ", ' + ClientTableAlias +'.Suburb, ' + ClientTableAlias +'.State), ' + ClientTableAlias +'.Postcode, ' + ClientTableAlias +'.Country) ';
end;
Function Secondcolumn(const Parttablealias: String = 'P'): String;
begin
  result := SplitField(Parttablealias, 'ProductGroup', 2);
end;

Function StockMovementType(Const Tablealias: String = 'SM'): String;
begin
  result := 'If(' + Tablealias + '.StockmovementEntryType="StockAdjustEntry","Stock Adjustment",' +
            'If(' + Tablealias + '.StockmovementEntryType="StockTransferEntry","Stock Transfer","Unknown"))';

end;

function POType(const POTablealias: string = 'P'; unknownmsg: string = 'Unknown'): string;
begin
  result := 'If(' + POTablealias + '.IsPO="T", "Purchase Order",' +
            'If(' + POTablealias + '.IsRA="T", "Return Authority",' +
            'If(' + POTablealias + '.IsBill="T", "Bill",' +
            'If(' + POTablealias + '.IsCredit="T", "Credit",' +
            'If(' + POTablealias + '.IsCheque="T", "Cheque", ' + QuotedStr(unknownmsg) + ')))))';
end;

Function TransBOType(Transtype: String; Shippedfield: String): string;
begin
  result := 'if(ifnull(' + Shippedfield + ',0)=0 ,concat(' + Transtype + ',"-BO"), ' +
    Transtype + ')';
end;

Function UOM(Unitfieldname, MultiplierFieldName: String): string;
begin
  result := 'Concat(' + Unitfieldname + ', " (" ,' + MultiplierFieldName + ',")" )';
end;
Function SubTaxcodeCategory(const Tablealias: String = 'STC'): string;
begin
  REsult := 'if(STC.Category = "T" , "City" , ' +
            'if(STC.Category = "S" , "State" , ' +
            'if(STC.Category = "C" , "County" , ' +
            'if(STC.Category = "O" , "Other" ,"Un-known" ))))';
end;

Function SubTaxcodeCategoryNO(const Tablealias: String = 'STC'): string;
begin
  REsult := 'if(STC.Category = "T" , 1 , ' +
            'if(STC.Category = "S" , 2 , ' +
            'if(STC.Category = "C" , 3 , ' +
            'if(STC.Category = "O" , 4 ,5 ))))';
end;
Function SaleType(const saleTablealias: String = 'S'; unknownmsg :String= 'Unknown'): string;
begin
  result := 'If(' + saleTablealias + '.IsCashSale       ="T" And ' + saleTablealias + '.IsPOS="F", "Cash Sale",' +
            'If(' + saleTablealias + '.IsRefund         ="T" , "Refund",' +
            'If(' + saleTablealias + '.ISSalesOrder     ="T" , "Sales Order",' +
            'If(' + saleTablealias + '.IsQuote          ="T" , "Quote",' +
            'If(' + saleTablealias + '.IsCashSale       ="T" And ' + saleTablealias + '.IsPOS="T", if( ' + saleTablealias + '.IsLaybyPayment="T" ,if(  ' + saleTablealias + '.TotalAmountInc <0 , "Layby Reverse Transaction ","Layby Payment" ), "POS"),' +
            'If(' + saleTablealias + '.Islayby          ="T" And ' + saleTablealias + '.IsPOS="T", "Layby",' +
            'If(' + saleTablealias + '.IsInvoice        ="T" , "Invoice", ' +
            'If(' + saleTablealias + '.IsCustomerReturn ="T" , "Customer Return", ' +
            'If(' + saleTablealias + '.IsVoucher        ="T" , "Voucher",'+Quotedstr(unknownmsg)+'))))))))) ';
end;

Function Thirdcolumn(const Parttablealias: String = 'P'): String;
begin
  result := SplitField(Parttablealias, 'ProductGroup', 3);
end;
Function AddressSQL(TableAlias :String ; Includename :Boolean ; title,firstname,middlename, surname, Add1field, Add2Field, Add3Field, CityField, StateField, PostcodeField:String):String;
var
  sname:String;
  sAddress:String;
  SCity:String;
begin
  result:= '';
  if Includename then sname := nameSQL(Tablealias, title, firstname, middlename, surname);

  sAddress :='';
  if Add1field   <> '' then begin if sAddress <> '' then sAddress := sAddress +',' ; sAddress := sAddress + TableAlias+'.'+Add1field   ;end;
  if Add2field   <> '' then begin if sAddress <> '' then sAddress := sAddress +',' ; sAddress := sAddress + TableAlias+'.'+Add2field   ;end;
  if Add3field   <> '' then begin if sAddress <> '' then sAddress := sAddress +',' ; sAddress := sAddress + TableAlias+'.'+Add3field   ;end;

  if CityField      <> '' then begin if SCity <> '' then SCity := SCity +',' ; SCity := SCity + TableAlias+'.'+CityField    ;end;
  if StateField     <> '' then begin if SCity <> '' then SCity := SCity +',' ; SCity := SCity + TableAlias+'.'+StateField   ;end;
  if PostcodeField  <> '' then begin if SCity <> '' then SCity := SCity +',' ; SCity := SCity + TableAlias+'.'+PostcodeField;end;
  if SCity <> '' then SCity := 'concat_WS(" " , ' +SCity+')';

  REsult:= '';
  if (Sname = '') and (sAddress  = '') and (SCity = '') then exit;

  if sname    <> '' then begin if result <> '' then result := result +','; result := result + sname   ;end;
  if sAddress <> '' then begin if result <> '' then result := result +','; result := result + sAddress;end;
  if SCity    <> '' then begin if result <> '' then result := result +','; result := result + SCity   ;end;

  result := 'concat_WS("\n" , ' + result+ ')';

end;
Function NameSQL(Const TableAlias, title , fistname, middleName, Surname:String) :String;
begin
  REsult := '' ;
  if (title='') and (fistname='') and (middleName='') and (Surname='') then exit;
  if title      <> '' then result := result + TableAlias+'.'+title ;
  if fistname   <> '' then begin if result <> '' then result := result +',' ; result := result + TableAlias+'.'+fistname   ;end;
  if middleName <> '' then begin if result <> '' then result := result +',' ; result := result+ TableAlias+'.'+middleName  ; end;
  if Surname    <> '' then begin if result <> '' then result := result +',' ; result := result+ TableAlias+'.'+Surname     ; end;
  Result := 'concat_WS(" " , '+ result +')';
end;
{select
pqabatch.value as batchno , pqabatch.expirydate, pbin.binlocation, pbin.binnumber, pqasn.value serialnumber
from tblsales S
inner join tblsaleslines SL on s.saleId = SL.saleId
inner join tblparts p on p.partsid = sl.productid
inner join tblpqa pqa on SL.saleId = pqa.transId and pqa.translineId = SL.saleLineid and pqa.transtype = 'TSalesOrderLine'
inner join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"
left join `tblPqaDetails` PQABins  on PQABins.PQAId 	= PQA.PQAID  and PQABins.PQAType = "Bin" and PQABins.Active = "T" and   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"  and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))
Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID
left join `tblPqaDetails` PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T"
and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")
or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") or
ifnull(PQASN.Parentref ,"") = "" and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))
order by batchno, expirydate, binlocation, binnumber, serialnumber}
function TransTables(mode: TFiltertype;TranslineTableAlias, HeaderIDfield,LineIDfield, TransTypes:String;aliasSuffix:String =''):String;
begin
    if TranslineTableAlias = '' then
          result := 'from `tblPQA` as PQA'
    else  result := 'inner join `tblPQA` as PQA' + trim(aliasSuffix)+' on PQA' + trim(aliasSuffix)+'.TRansId = '    + TranslineTableAlias +'.' + HeaderIDfield+' and PQA' + trim(aliasSuffix)+'.transLineId  = ' + TranslineTableAlias +'.' + LineIDfield+' and PQA' + trim(aliasSuffix)+'.Transtype in (' + TransTypes +')';
    Result := Result +' inner join tblparts as  P' + trim(aliasSuffix)+' on P'   + trim(aliasSuffix)+'.partsId = PQA' + trim(aliasSuffix)+'.ProductID ';

    if mode >= tDetails then begin
        Result := Result +' left join `tblPqaDetails`  PQABatch' + trim(aliasSuffix)+'  on PQABatch' + trim(aliasSuffix)+'.PQAId 	= PQA' + trim(aliasSuffix)+'.PQAID and PQABatch' + trim(aliasSuffix)+'.PQAType = "Batch"  and PQABatch' + trim(aliasSuffix)+'.Active= "T"';
        if mode >= tExtraDetails then begin
          Result := Result +' left join `tblPqaDetails` PQABins' + trim(aliasSuffix)+'  on PQABins' + trim(aliasSuffix)+'.PQAId 	= PQA' + trim(aliasSuffix)+'.PQAID ';
          Result := Result +' and PQABins' + trim(aliasSuffix)+'.PQAType = "Bin" and PQABins' + trim(aliasSuffix)+'.Active = "T" and  ';
          Result := Result +' ( (PQABatch' + trim(aliasSuffix)+'.globalref = IFNULL(PQABins' + trim(aliasSuffix)+'.ParentRef,"") and P' + trim(aliasSuffix)+'.Batch="T" and P' + trim(aliasSuffix)+'.multiplebins = "T") '+
                        ' or (ifnull(PQABins' + trim(aliasSuffix)+'.Parentref ,"") = "" AND P' + trim(aliasSuffix)+'.Batch="F" and P' + trim(aliasSuffix)+'.multiplebins = "T"))';
          Result := Result +' Left join `tblProductBin` PBin' + trim(aliasSuffix)+'     on PBin' + trim(aliasSuffix)+'.binId 	= PQABins' + trim(aliasSuffix)+'.BinID';
          if mode >= tDetailswithSno then begin
            Result := Result +' left join `tblPqaDetails` PQASN' + trim(aliasSuffix)+'    on (PQASN' + trim(aliasSuffix)+'.PQAId 	= PQA' + trim(aliasSuffix)+'.PQAID and PQASN' + trim(aliasSuffix)+'.PQAType = "SN"   and PQASN' + trim(aliasSuffix)+'.Active = "T" and PQASN' + trim(aliasSuffix)+'.Qty <> 0';
            Result := Result +' and ((PQABatch' + trim(aliasSuffix)+'.globalref = IFNULL(PQASN' + trim(aliasSuffix)+'.ParentRef,"") and P' + trim(aliasSuffix)+'.Batch="T" and P' + trim(aliasSuffix)+'.multiplebins = "F" and P' + trim(aliasSuffix)+'.SNTracking = "T")'+
                         ' or (PQABins' + trim(aliasSuffix)+'.Globalref = IFNULL(PQASN' + trim(aliasSuffix)+'.ParentRef,"") and P' + trim(aliasSuffix)+'.Multiplebins = "T" and P' + trim(aliasSuffix)+'.SNTracking = "T") '+
                         ' or ((ifnull(PQASN' + trim(aliasSuffix)+'.Parentref ,"") = "") and P' + trim(aliasSuffix)+'.Batch="F" and P' + trim(aliasSuffix)+'.Multiplebins = "F" and P' + trim(aliasSuffix)+'.SNTracking = "T")))';
          end;
        end;
    end;
end;

Function ProductTables(mode: TFiltertype; FilterAvailableSN: Boolean = True;
  IncludeTransType: Boolean = False; CurSNIDtoExclude: Integer = 0;
  ExcludeifAllocationnotmode: Boolean = True; aAsOnDAte:TDatetime =0;
  UseasOndateTime: Boolean = False): String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('`tblParts` as P');
    if mode = tProductList then begin
      SQLList.Add('LEFT JOIN `tblProductClasses` as PC on PC.ProductID = P.PartsId');
      SQLList.Add('LEFT JOIN `tblPQA` as PQA on PQA.departmentID = PC.ClassID and PQA.ProductID =PC.ProductID ');
      SQLList.Add('LEFT JOIN `tblclass` as C on PQA.departmentID = C.ClassID ');
    end
    else if mode >= tSummary then begin
      SQLList.Add('inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID ');
      if (mode >= tDetails) and (ExcludeifAllocationnotmode) then
        SQLList.Add('and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F") OR (PQA.PQAID in (Select PQAID from `tblPQADetails`)))');
      SQLList.Add('inner join `tblclass` as C on PQA.departmentID = C.ClassID ');
      SQLList.Add('Inner join `tblProductClasses` as PC on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID');
      if mode >= tDetails then begin
        SQLList.Add('left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"');
        if mode >= tExtraDetails then begin
          SQLList.Add('left join `tblPqaDetails` PQABins  on PQABins.PQAId 	= PQA.PQAID ');
          SQLList.Add('and PQABins.PQAType = "Bin" and PQABins.Active = "T" and  ');
          SQLList.Add('( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T") '+
                        ' or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))');
          SQLList.Add('Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID');
          if mode >= tDetailswithSno then begin
            SQLList.Add('left join `tblPqaDetails` PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T" and PQASN.Qty <> 0');
            SQLList.Add('and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")'+
                         ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") '+
                         ' or ((ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T")))');

            if mode = tSerialnoList then begin
              SQLList.Add('and PQA.transDate in  (Select max(maxpqa.transDate)  ');
              SQLList.Add('from `tblPQADetails` maxpqad ');
              SQLList.Add('inner join `tblPQA` maxpqa on maxpqa.PQAID = maxpqad.PQAID ');
              SQLList.Add('where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in (' + ManufactureTypes +','+Quotedstr('TProcProgressIn')+'))   and maxpqa.ProductID = PQa.ProductId and maxpqa.DepartmentId = PQa.DepartmentId');
              if aAsOnDAte <> 0 then
                if UseasOndateTime then
                  SQLList.Add('and maxpqa.transDate< ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, IncSecond(aAsOnDAte, 1))))
                else
                  SQLList.Add('and maxpqa.transDate< ' + QuotedStr(FormatDateTime(MysqlDateFormat, IncDay(aAsOnDAte, 1))));
              SQLList.Add('and maxpqad.value =PQASN.value');
              if CurSNIDtoExclude <> 0 then
                SQLList.Add(' and maxpqad.PQADetailID <> ' + IntToStr(CurSNIDtoExclude));
              SQLList.Add(')');
              SQLList.Add(' Left join `tblfixedAssets` FA on FA.PartsId = PQA.ProducTID and FA.ClassId =PQA.DepartmentID and FA.Serial = PQASN.Value');
              SQLList.Add(' Left join `tblequipment` E on  E.ProductId = PQA.ProducTID and  ifnull(E.SerialNumber,"") = PQASN.Value');
            end else if FilterAvailableSN then begin
              SQLList.Add('and PQA.transDate in  (Select max(maxpqa.transDate)  ');
              SQLList.Add('from `tblPQADetails` maxpqad ');
              SQLList.Add('inner join `tblPQA` maxpqa on maxpqa.PQAID = maxpqad.PQAID ');
              SQLList.Add('where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and (maxpqa.Active = "T"  or  maxpqa.transtype in (' + ManufactureTypes +','+Quotedstr('TProcProgressIn')+'))   '+
                          //' /*and maxpqa.PQAID = PQa.PQAID*/ '+
                          ' and maxpqa.ProductID = PQa.ProductId  and maxpqa.DepartmentId = PQa.DepartmentId');
              if aAsOnDAte <> 0 then
                if UseasOndateTime then
                  SQLList.Add('and maxpqa.transDate< ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, IncSecond(aAsOnDAte, 1))))
                else SQLList.Add('and maxpqa.transDate< ' + QuotedStr(FormatDateTime(MysqlDateFormat, IncDay(aAsOnDAte, 1))));
              SQLList.Add('and maxpqad.value =PQASN.value');
              if CurSNIDtoExclude <> 0 then SQLList.Add(' and maxpqad.PQADetailID <> ' + IntToStr(CurSNIDtoExclude));
              SQLList.Add(')');
              SQLList.Add(' and PQASN.Value not in (Select ifnull(Serial,"")  from `tblfixedAssets` where PartsId = PQA.ProducTID and ClassId =PQA.DepartmentID)');
              SQLList.Add('and PQASN.Value not in (Select ifnull(E.SerialNumber,"") from tblequipment E where E.ProductId = PQA.ProducTID AND e.OnHire ="T") ');
            end;
          end;
        end;
      end;
      if IncludeTransType then
        SQLList.Add('LEFT JOIN `tblpqatranstypes` as TT on TT.TransType = PQA.TransType');

    end;
    Result := SQLList.Text;
  finally
    Freeandnil(SQLList);
  end;
end;

function SalesAllocationTables(pqatablename :String = 'tblpqa' ; Alloctablename :String ='tblpqadetails' ):String;
begin
  Result := AllocationTables(pqatablename ,Alloctablename);
  Result := StringReplace(result, pqatablename +' pqa ' ,
    ' tblsales S '+
    ' inner join tblsaleslines SL on S.SaleId = SL.saleID '+
    ' left join '+pqatablename+' pqa on SL.saleLineId = pqa.translineId and pqa.transtype in ('+SalesTransTypes+')',
        [rfIgnoreCase]);
end;
function AllocationTables(pqatablename :String = 'tblpqa' ; Alloctablename :String ='tblpqadetails'  ):String;
begin
  result := pqatablename +' pqa '+
              ' LEFT JOIN  tblparts P on P.partsId = PQA.productID	'+
              ' LEFT JOIN  ' + Alloctablename+'  PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"' +
              ' LEFT JOIN   ' + Alloctablename+'  PQABins  on PQABins.PQAId 	= PQA.PQAID  and PQABins.PQAType = "Bin" and PQABins.Active = "T" and  '+
                            ' ((PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"  and P.multiplebins = "T") or '+
                            ' (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))'+
              ' LEFT JOIN  `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID'+
              ' LEFT JOIN   ' + Alloctablename+'  PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T"'+
                            ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")'+
                            ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") '+
                            ' or (ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))';

end;
Function DetailQtyfield(DetailType: TFiltertype; isUOMQty: Boolean = False; PQAQtyWhennotAllocated :Boolean = False): String;
  function qtyField: String; begin if isUOMQty then result := 'UOMQty' else result := 'Qty'; end;
  function QtyfieldforNonAllocation:String; begin if PQAQtyWhennotAllocated then result :=  'PQA.' + qtyField else result := '0'; end;
begin
       if DetailType = tSummary         then result := 'PQA.' + qtyField
  else if DetailType = tDetails         then result := 'if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.' + qtyField +','+QtyfieldforNonAllocation+' )'
  else if DetailType = tExtraDetails    then result := 'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.'  + qtyField +',if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.'+ qtyField + ','+QtyfieldforNonAllocation+' ))'
  else if DetailType = tDetailswithSno  then result := 'if(ifnull(PQASN.PQAdetailID,0)   <> 0 , PQASN.'    + qtyField +',if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.' + qtyField +', if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.' + qtyField + ','+QtyfieldforNonAllocation+' )))';
end;

function SQL4ProductAvailableQty(Const asOndate: TDatetime = 0; Const fUOM: String = '';
  Const DetailType: TFiltertype = tSummary; Const fiproductID: Integer = 0;
  Const ficlassid: Integer = 0; Const fsBatchno: String = ''; Const fdExpiryDate: TDatetime = 0;
  Const fsbinlocation: String = ''; Const fsBinnumber: String = '';
  Const fsSerialnumber: String = ''; Qtytype: TQtytype = tAvailable; fExtrafields: String = '';
  fExtraWhere: String = ''; CurSNIDtoExclude: Integer = 0;
  includeDeptFields: Boolean = False;groupbyUOM:Boolean =False; SNIfhasQty:Boolean =  True): String;
begin
    result := SQL4ProductQty(asOndate,fUOM,DetailType,fiproductID,ficlassid,fsBatchno,fdExpiryDate,fsbinlocation,fsBinnumber,fsSerialnumber,
                             Qtytype,fExtrafields,fExtraWhere,CurSNIDtoExclude,includeDeptFields,groupbyUOM,SNIfhasQty,False);
end;

function SQL4ProductQty(Const asOndate: TDatetime = 0; Const fUOM: String = '';
  Const DetailType: TFiltertype = tSummary; Const fiproductID: Integer = 0;
  Const ficlassid: Integer = 0; Const fsBatchno: String = ''; Const fdExpiryDate: TDatetime = 0;
  Const fsbinlocation: String = ''; Const fsBinnumber: String = '';
  Const fsSerialnumber: String = ''; Qtytype: TQtytype = tAvailable; fExtrafields: String = '';
  fExtraWhere: String = ''; CurSNIDtoExclude: Integer = 0;
  includeDeptFields: Boolean = False;groupbyUOM:Boolean =False; SNIfhasQty:Boolean =  True;PQAQtyWhennotAllocated:Boolean =True; UseasOndateTime:Boolean =False): String;
var
  SQLList: TStringList;
  s: String;
begin
//  logtext(DetailQtyfield(DetailType,False , PQAQtyWhennotAllocated));
//  logtext(DetailQtyfield(DetailType,true , PQAQtyWhennotAllocated));
  SQLList := TStringList.Create;
  try
    SQLList.Add('SELECT P.PartsID,  P.PARTNAME , PC.PreferredLevel,');
    if (fUOM <> '') or (groupbyUOM)                               then SQLList.Add('PQA.UOM,');
    if includeDeptFields                                          then SQLList.Add('PQA.DepartmentID,PC.ClassName,');
    if (DetailType >= tDetails) or (fsBatchno <> '')              then SQLList.Add('PQABatch.Value as Batchno,');
    if (DetailType >= tDetails) or (fdExpiryDate <> 0)            then SQLList.Add('PQABatch.ExpiryDate , ');
    if (DetailType >= tDetails)                                   then SQLList.Add('PQABatch.TruckLoadNo , ');
    if (DetailType >= tExtraDetails) or (fsbinlocation <> '')     then SQLList.Add('PBin.Binlocation ,');
    if (DetailType >= tExtraDetails) or (fsBinnumber <> '')       then SQLList.Add('PBin.Binnumber ,');
    if (DetailType >= tExtraDetails)                              then SQLList.Add('PBin.binId,concat(PBin.Binlocation ,PBin.Binnumber ) as BinLocNum, ');
    if (DetailType >= tDetailswithSno) or (fsSerialnumber <> '')  then SQLList.Add('PQASN.Value as Serialnumber ,');
    SQLList.Add(SQL4Qty(Qtytype, 'PQA', DetailQtyfield(DetailType,False , PQAQtyWhennotAllocated)) + ' as Qty,');
    SQLList.Add(SQL4Qty(Qtytype, 'PQA', DetailQtyfield(DetailType, True , PQAQtyWhennotAllocated)) + ' as UOMQty');
    if trim(fExtrafields) <> ''                                   then SQLList.Add(',' + fExtrafields);
    SQLList.Add(' FROM ' + ProductTables(DetailType, DetailType >= tDetailswithSno, False, CurSNIDtoExclude, True, asOndate, UseasOndateTime));
    SQLList.Add(' Where P.active <>"F" and PC.ACtive <> "F"  '+
              //' /*and PQA.active <> "F"*/ '+
              ' ');
    if asOndate <> 0 then
      if UseasOndateTime then
           SQLList.Add('and (PQA.TransDate < ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat , incSecond(asOndate, 1))) + ' )')
      else SQLList.Add('and (PQA.TransDate < ' + QuotedStr(FormatDateTime(MysqlDateFormat, IncDay(asOndate, 1))) + ' )');

    if ficlassid <> 0   then SQLList.Add('and PQA.DepartmentID = ' + IntToStr(ficlassid));
    if fiproductID <> 0 then SQLList.Add('and PQA.ProductID =' + IntToStr(fiproductID));
    if (fUOM <> '')     then SQLList.Add('and PQA.UOM = ' + QuotedStr(fUOM));

    if (fsBatchno <> '') then begin
      s := '( PQABatch.value = ' + QuotedStr(fsBatchno);
      if (fdExpiryDate <> 0) then
        s := s + 'and PQABatch.Expirydate = ' +
          QuotedStr(FormatDateTime(MysqlDateFormat, fdExpiryDate));
      s := s + ')';
      s := '  and ((ifnull(P.Batch,"F") ="F") or (' + s + '))';
      SQLList.Add(s);
    end;
    if (fsbinlocation <> '') then begin
      s := '((ifnull(PQABins.UOMQty,0) <> 0 and PBin.binlocation = ' + QuotedStr(fsbinlocation);
      if (fsBinnumber <> '') then
        s := s + 'and PBin.binnumber = ' + QuotedStr(fsBinnumber);
      s := s + ')';
      s := '  and ((ifnull(P.Multiplebins,"F") ="F") or (' + s + ')))';
      SQLList.Add(s);
    end;
    if (fsSerialnumber <> '') then begin
      s := '(PQASN.Value <> '''' and PQASN.Value = ' + QuotedStr(fsSerialnumber) + ')';
      s := '  and ((ifnull(P.SNTracking,"F") ="F") or (' + s + '))';
      SQLList.Add(s);
    end;

    if fExtraWhere <> '' then  SQLList.Add(' and (' + fExtraWhere + ')');

    SQLList.Add('group by P.PartsID, P.PARTNAME ');
    if (fUOM <> '') or (groupbyUOM)     then SQLList.Add(',UOM');
    if includeDeptFields                then  SQLList.Add(',DepartmentID');
    if (DetailType >= tDetails)         then SQLList.Add(',IFNULL( PQABatch.Value,"")');
    if (DetailType >= tDetails)         then SQLList.Add(',IFNULL( PQABatch.TruckLoadNo,"")');
    if (DetailType >= tDetails)         then SQLList.Add(',IFNULL( PQABatch.ExpiryDate,0)  ');
    if (DetailType >= tExtraDetails)    then SQLList.Add(',IFNULL( PQABins.BinID ,"")');
    if (DetailType >= tExtraDetails)    then SQLList.Add(',IFNULL( PBin.Binlocation,"") ');
    if (DetailType >= tExtraDetails)    then SQLList.Add(',IFNULL( PBin.Binnumber ,"")');
    if (DetailType >= tDetailswithSno)  then SQLList.Add(',IFNULL( PQASN.Value,"")');

    if (DetailType >= tDetailswithSno) and SNIfhasQty  then SQLList.Add('having ifnull(Serialnumber,"") = "" or  Qty >0');

    result := SQLList.Text;
  finally
    Freeandnil(SQLList);
  end;
end;

function SQL4QtyAsOnDate(const AsOnDate:TDateTime; const Qtytype: TQtytype; const PQAAlias: String = 'PQA';  const SumfieldName: STring = 'PQA.QTY'): String;
begin
  Result := 'ROUND(SUM(IF(' + PQAAlias + '.TransDate <=' + quotedstr(formatDateTime(mysqlDatetimeformat, AsOnDate)) + ', ' + SQL4QtyField(Qtytype, PQAAlias, SumfieldName) + ', 0)), ' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) + ')';
end;

function SQL4Qty(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';  const SumfieldName: STring = 'PQA.QTY'): String;
begin
  result := 'Round(Sum(' + SQL4QtyField(Qtytype, PQAAlias, SumfieldName) + '),' +    IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) + ')';
end;

function SQL4QtyField(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';
  const SumfieldName: STring = 'PQA.QTY'): String;
begin
  result := pqalib.SQL4QtyField(Qtytype,PQAAlias,SumfieldName);
end;
Function SerialnumberRecord(Const ProductID: Integer; const classID: Integer ;aSerialnumber:String):String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('SELECT distinct ');
    SQLList.Add('P.PartsId as PartsId, ');
    SQLList.Add('PC.ClassId as DepartmentID,');
    SQLList.Add('PQA.UOMID as UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +') as UOM,');
    SQLList.Add('ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('3 as gLevel, ');
    SQLList.Add('P.PartName as ProductName ,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription as PartsDescription,');
    SQLList.Add('PC.Classname as Classname,');
    SQLList.Add('PQABatch.Value as Batchnumber, ');
    SQLList.Add('PQABatch.TruckLoadNo as TruckLoadNo, ');
    SQLList.Add('DATE_FORMAT(PQABatch.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate, ');
    SQLList.Add('PQABatch.Expirydate as BatchExpiryDate, ');
    SQLList.Add('PBin.binLocation as binLocation, ');
    SQLList.Add('PBin.Binnumber as Binnumber, ');
    SQLList.Add('PQABins.binID as binID, ');
    SQLList.Add('PQASN.Value as Serialnumber, ');
    SQLList.Add('TT.DEscription as DEscription,');
    SQLList.Add('PQA.Transdate as Transdate,  ');
    SQLList.Add('PQAAllocType(PQA.allocType,PQA.Transtype,PQASN.Qty,SM.StockmovementID,SM.StockmovementEntryType,FA.Serial , S.Converted, S.IsInternalOrder) as allocType ');
    SQLList.Add(' FROM ' + ProductTables(tSerialnoList, True, True, 0 , True , 0));
    SQLList.Add('left join tblstockmovementlines SML on PQA.transId = SML.StockmovementID and PQA.transLineId = SML.StockmovementLinesID and PQA.transType = "TStockMovementLines"');
    SQLList.Add('Left join tblstockmovement SM on SM.StockmovementID = SML.StockmovementID');
    SQLList.Add('left join tblSales  S on PQA.transId = S.saleID and PQA.transType  in ( '+ SalesTransTypes+','+ ManufactureTypes+')');
    SQLList.Add('Where  (P.SNTracking ="T")');
    if classID    <> 0 then SQLList.Add('and PQA.DepartmentID =' + IntToStr(classID));
    if ProductID  <> 0 then SQLList.Add('and PQA.ProductID =' + IntToStr(ProductID));
    SQLList.Add('and ifnull(PQASN.Value,"")= ' + Quotedstr(aSerialnumber));
    SQLList.Add('order by PQA.transdate DESC');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;
Function Serialnumberlist(Const ProductID: Integer = 0; const classID: Integer = 0;
  TransDate: TDatetime = 0; dateFrom: TDatetime = 0; Dateto: TDatetime = 0; IncludeOrderBy: boolean = true; extrafields:String =''): String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('SELECT distinct ');
    SQLList.Add('P.PartsId as PartsId, ');
    SQLList.Add('PC.ClassId as DepartmentID,');
    SQLList.Add('PQA.UOMID as UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +') as UOM,');
    SQLList.Add('ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('3 as gLevel, ');
    SQLList.Add('P.PartName as ProductName ,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription as PartsDescription,');
    SQLList.Add('PC.Classname as Classname,');
    SQLList.Add('PQABatch.Value as Batchnumber, ');
    SQLList.Add('PQABatch.TruckLoadNo as TruckLoadNo, ');
    SQLList.Add('DATE_FORMAT(PQABatch.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate, ');
    SQLList.Add('PQABatch.Expirydate as BatchExpiryDate, ');
    SQLList.Add('PBin.binLocation as binLocation, ');
    SQLList.Add('PBin.Binnumber as Binnumber, ');
    SQLList.Add('PQASN.Value as Serialnumber, ');
    SQLList.Add('TT.DEscription as DEscription,');
    SQLList.Add('PQA.Transdate as Transdate,  ');
    SQLList.Add('PQAAllocType(PQA.allocType,PQA.Transtype,PQASN.Qty,SM.StockmovementID,SM.StockmovementEntryType,FA.Serial, S.Converted, S.IsInternalOrder) as allocType ');
    if extrafields <> '' then SQLList.Add(','+extrafields);
    SQLList.Add(' FROM ' + ProductTables(tSerialnoList, True, True, 0 , True , TransDate));
    SQLList.Add('left join tblstockmovementlines SML on PQA.transId = SML.StockmovementID and PQA.transLineId = SML.StockmovementLinesID and PQA.transType = "TStockMovementLines"');
    SQLList.Add('Left join tblstockmovement SM on SM.StockmovementID = SML.StockmovementID');
    SQLList.Add('left join tblSales  S on PQA.transId = S.saleID and PQA.transType  in ( '+ SalesTransTypes+','+ ManufactureTypes+')');
    SQLList.Add('Where  (P.multiplebins = "T" or P.Batch = "T" or P.SNTracking ="T")');
    if classID    <> 0 then SQLList.Add('and PQA.DepartmentID =' + IntToStr(classID));
    if ProductID  <> 0 then SQLList.Add('and PQA.ProductID =' + IntToStr(ProductID));
    if TransDate  <> 0 then SQLList.Add('and PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat, TransDate)));
    SQLList.Add('and ifnull(PQASN.Value,"")<>""');
    if dateFrom   <> 0 then SQLList.Add('AND PQA.TransDate >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dateFrom)));
    if Dateto     <> 0 then SQLList.Add('AND PQA.TransDate < ' + QuotedStr(FormatDateTime(MysqlDateFormat, Dateto)));
    if IncludeOrderBy  then SQLList.Add('order by PQA.ProductID , PC.ClassId , ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +') ,'+
                                        'PQABatch.Value , PQABatch.TruckLoadNo ,PQABatch.Expirydate ,PBin.Binlocation,PBIN.binnumber, PQASN.value');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function StockQtyDetailswithSno(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; IncludeOrderBy: boolean = true; haveActStockwithManQty :Boolean = False): String;
var
  SQLList: TStringList;
begin
//  Logtext(DetailQtyfield(tDetailswithSno,False, False));
//  Logtext(DetailQtyfield(tDetailswithSno,true, False));
  SQLList := TStringList.Create;
  try
    SQLList.Add('SELECT distinct P.PartsId, PC.ClassId as DepartmentID,PQA.UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
      ') as UOM,ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('4 as gLevel, P.PartName as ProductName ,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('PQABatch.Value as Batchnumber, ');
    SQLList.Add('PQABatch.TruckLoadNo as TruckLoadNo, ');
    SQLList.Add('DATE_FORMAT(PQABatch.Expirydate , ' + QuotedStr('%d/%m/%Y') + ') as ExpiryDate , ');
    SQLList.Add('PQABatch.Expirydate as BatchExpiryDate, ');
    SQLList.Add('PBin.binLocation, PBin.Binnumber, ');
    SQLList.Add('PQASN.Value as Serialnumber,');
    //SQLList.Add(SQL4Qty   (tAvailable       , 'PQA', SQL4QtyField(tAvailable      ,'PQA', DetailQtyfield(tDetailswithSno,True , False)))+ ' as UOMQty,');
    SQLList.Add(SQL4Qty   (tAvailable       , 'PQA', DetailQtyfield(tDetailswithSno,True , False))+ ' as UOMQty,');
    //SQLList.Add(SQL4Qty   (tAvailable       , 'PQA', SQL4QtyField(tAvailable      ,'PQA', DetailQtyfield(tDetailswithSno,False, False)))+ ' as Qty,');
    SQLList.Add(SQL4Qty   (tAvailable       , 'PQA', DetailQtyfield(tDetailswithSno,False, False))+ ' as Qty,');
     SQLList.Add('0.0 as CUSTFLD1,');
    //SQLList.Add(SQL4Qty   (tInStock         , 'PQA', SQL4QtyField(tInStock        ,'PQA', DetailQtyfield(tDetailswithSno,true , False)))+ ' as InstockUOMQty,');
    SQLList.Add(SQL4Qty   (tInStock         , 'PQA', DetailQtyfield(tDetailswithSno,true , False))+ ' as InstockUOMQty,');
    //SQLList.Add(SQL4Qty   (tInStock         , 'PQA', SQL4QtyField(tInStock        ,'PQA', DetailQtyfield(tDetailswithSno,False, False)))+ ' as InstockQty,');
    SQLList.Add(SQL4Qty   (tInStock         , 'PQA', DetailQtyfield(tDetailswithSno,False, False))+ ' as InstockQty,');
    if IncludeSOQty then begin
      //SQLList.Add(SQL4Qty (tSO              , 'PQA', SQL4QtyField(tSO             ,'PQA', DetailQtyfield(tDetailswithSno,true , False)))+ ' as SOUOMQty,');
      SQLList.Add(SQL4Qty (tSO              , 'PQA', DetailQtyfield(tDetailswithSno,true , False))+ ' as SOUOMQty,');
      //SQLList.Add(SQL4Qty (tSO              , 'PQA', SQL4QtyField(tSO             ,'PQA', DetailQtyfield(tDetailswithSno,False, False)))+ ' as SOQty,');
      SQLList.Add(SQL4Qty (tSO              , 'PQA', DetailQtyfield(tDetailswithSno,False, False))+ ' as SOQty,');
    end;
    if haveActStockwithManQty then begin
      //SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA', SQL4QtyField(tActStockwithMan,'PQA', DetailQtyfield(tDetailswithSno,true , False)))+ ' as ActStockwithManUOMQty,');
      SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA', DetailQtyfield(tDetailswithSno,true , False))+ ' as ActStockwithManUOMQty,');
      //SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA', SQL4QtyField(tActStockwithMan,'PQA', DetailQtyfield(tDetailswithSno,False, False)))+ ' as ActStockwithManQty,');
      SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA', DetailQtyfield(tDetailswithSno,False, False))+ ' as ActStockwithManQty,');
    end;
    (*SQLList.Add('0.0 Cost, 0.0 Value');*)
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Cost,');
    SQLList.Add('Round(sum(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' + IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ')*'+
                      '('+SQL4QtyField(tInStock, 'PQA', DetailQtyfield(tDetailswithSno,False , False)) +')),' +IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');

    if IncludeSOQty then begin
      SQLList.Add(' FROM ' + StringReplace(ProductTables(tDetailswithSno, FilterAvailableSN, False, 0 , true , transdate ),
        ' and PQA.Alloctype = "IN"',
        'and (PQA.Alloctype = "IN"  or (PQA.Alloctype = "OUT"  and PQA.TransType  in ("TSalesOrderLine"  '+
              //' /*, "TSalesOrderInvoiceLines"*/ '+
              ' )))',
        [rfIgnoreCase]));
    end else begin
      SQLList.Add(' FROM ' + ProductTables(tDetailswithSno, FilterAvailableSN, False , 0, True, transdate));
    end;
    SQLList.Add ('Where  (P.multiplebins = "T" or P.Batch = "T" or (P.SNTracking ="T" and PQASN.Value <> ""))');
    if classID <> 0 then SQLList.Add('and PQA.DepartmentID =' + IntToStr(classID));
    if ProductID <> 0 then SQLList.Add('and PQA.ProductID =' + IntToStr(ProductID));
    if TransDate <> 0 then SQLList.Add('and PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat, TransDate)));

    SQLList.Add('Group by PQA.ProductID , PC.ClassId , ifNull(PQA.UOM, ' +
        QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
        ') ,PQABatch.Value , PQABatch.TruckLoadNo, PQABatch.Expirydate ,PBin.Binlocation,PBIN.binnumber, PQASN.value');

    if IncludeOrderBy then
      SQLList.Add('order by PQA.ProductID , PC.ClassId , ifNull(PQA.UOM, ' +
        QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
        ') ,PQABatch.Value , PQABatch.TruckLoadNo, PQABatch.Expirydate ,PBin.Binlocation,PBIN.binnumber, PQASN.value');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function StockQtyExtraDetails(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
//  Logtext(DetailQtyfield(tExtraDetails,False, False));
//  Logtext(DetailQtyfield(tExtraDetails,true, False));

  try
    SQLList.Add('SELECT distinct P.PartsId, PC.ClassID as DepartmentID,PQA.UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
      ') as UOM,ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('3 as gLevel, P.PartName as ProductName ,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('PQABatch.Value as Batchnumber, ');
    SQLList.Add('PQABatch.TruckLoadNo as TruckLoadNo, ');
    SQLList.Add('DATE_FORMAT(PQABatch.Expirydate , ' + QuotedStr('%d/%m/%Y') + ') as ExpiryDate, ');
    SQLList.Add('PQABatch.Expirydate as BatchExpiryDate, ');
    SQLList.Add('PBin.binLocation, PBin.Binnumber,');
    SQLList.Add(' "" as Serialnumber,');
    //SQLList.Add(SQL4Qty   (tAvailable       , 'PQA',     SQL4QtyField(tAvailable      , 'PQA', DetailQtyfield(tExtraDetails,true , False)))  + ' as UOMQty,');
    SQLList.Add(SQL4Qty   (tAvailable       , 'PQA',     DetailQtyfield(tExtraDetails,true , False))  + ' as UOMQty,');
    //SQLList.Add(SQL4Qty   (tAvailable       , 'PQA',     SQL4QtyField(tAvailable      , 'PQA', DetailQtyfield(tExtraDetails,False , False))) + ' as Qty,');
    SQLList.Add(SQL4Qty   (tAvailable       , 'PQA',     DetailQtyfield(tExtraDetails,False , False)) + ' as Qty,');
    SQLList.Add('0.0 as CUSTFLD1,');
    //SQLList.Add(SQL4Qty   (tInStock         , 'PQA',     SQL4QtyField(tInStock        , 'PQA', DetailQtyfield(tExtraDetails,true , False)))  + ' as InstockUOMQty,');
    SQLList.Add(SQL4Qty   (tInStock         , 'PQA',     DetailQtyfield(tExtraDetails,true , False))  + ' as InstockUOMQty,');
    //SQLList.Add(SQL4Qty   (tInStock         , 'PQA',     SQL4QtyField(tInStock        , 'PQA', DetailQtyfield(tExtraDetails,False , False))) + ' as InstockQty,');
    SQLList.Add(SQL4Qty   (tInStock         , 'PQA',     DetailQtyfield(tExtraDetails,False , False)) + ' as InstockQty,');
    if IncludeSOQty then begin
      //SQLList.Add(SQL4Qty (tSO              , 'PQA',     SQL4QtyField(tSO             , 'PQA', DetailQtyfield(tExtraDetails,true , False)))  + ' as SOUOMQty,');
      SQLList.Add(SQL4Qty (tSO              , 'PQA',     DetailQtyfield(tExtraDetails,true , False))  + ' as SOUOMQty,');
      //SQLList.Add(SQL4Qty (tSO              , 'PQA',     SQL4QtyField(tSO             , 'PQA', DetailQtyfield(tExtraDetails,False , False))) + ' as SOQty,');
      SQLList.Add(SQL4Qty (tSO              , 'PQA',     DetailQtyfield(tExtraDetails,False , False)) + ' as SOQty,');
    end;
    if haveActStockwithManQty then begin
      //SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA',     SQL4QtyField(tActStockwithMan, 'PQA', DetailQtyfield(tExtraDetails,true , False)))  + ' as ActStockwithManUOMQty,');
      SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA',     DetailQtyfield(tExtraDetails,true , False))  + ' as ActStockwithManUOMQty,');
      //SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA',     SQL4QtyField(tActStockwithMan, 'PQA', DetailQtyfield(tExtraDetails,False , False))) + ' as ActStockwithManQty,');
      SQLList.Add(SQL4Qty (tActStockwithMan , 'PQA',     DetailQtyfield(tExtraDetails,False , False)) + ' as ActStockwithManQty,');
    end;

(*    SQLList.Add('0.0 , 0.0');*)
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Cost,');
    SQLList.Add('Round(sum(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' + IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ')*'+
                      '('+SQL4QtyField(tInStock, 'PQA', DetailQtyfield(tExtraDetails,False , False)) +')),' +IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');

    SQLList.Add(' FROM ' + ProductTables(tExtraDetails,FilterAvailableSN, False, 0, true, TransDate));
    SQLList.Add('Where  (P.multiplebins = "T" or P.Batch = "T")');
    if classID <> 0 then
      SQLList.Add('and PQA.DepartmentID =' + IntToStr(classID));
    if ProductID <> 0 then
      SQLList.Add('and PQA.ProductID =' + IntToStr(ProductID));
    if TransDate <> 0 then
      SQLList.Add('and PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat, TransDate)));
    SQLList.Add('group by PQA.ProductID , PC.ClassId , ifNull(PQA.UOM, ' +
      QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
      ') ,PQABatch.Value , PQABatch.TruckLoadNo ,PQABatch.Expirydate ,PBin.Binlocation,PBIN.binnumber');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;
Function StockQtyNonAllocProducts(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;const classID: Integer = 0; TransDate: TDate = 0): string;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('Select distinct');
    SQLList.Add('P.PartsId, PC.ClassId as DepartmentID,PQA.UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ') as UOM,');
    SQLList.Add('ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('1 as gLevel , P.PartName as ProductName,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('"" as Batchnumber , "" as TruckLoadNo ,"" as ExpiryDate, null as BatchExpiryDate, ');
    SQLList.Add('"" as Binlocation, "" as Binnumber , "" as Serialnumber, ');
    SQLList.Add(SQL4Qty(tAvailable, 'PQA', 'PQA.UOMQty') + ' as UOMQty,');
    SQLList.Add(SQL4Qty(tAvailable) + ' as Qty,');
    SQLList.Add('0.0 as CUSTFLD1,');
    SQLList.Add(SQL4Qty(tInStock, 'PQA', 'PQA.UOMQty') + ' as InstockUOMQty,');
    SQLList.Add(SQL4Qty(tInStock) + ' as InstockQty,');
    if IncludeSOQty then begin
      SQLList.Add(SQL4Qty(tSO, 'PQA', 'ifnull(PQA.UOMQty,0)') + ' as SOUOMQty,');
      SQLList.Add(SQL4Qty(tSO, 'PQA', 'ifnull(PQA.Qty,0)') + ' as SOQty,');
    end;
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Cost,');
(*    SQLList.Add('Round(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) +
      ')*Sum(if(PQA.alloctype="IN"  , PQA.Qty, 0-PQA.Qty)),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');*)
    SQLList.Add('Round(sum(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' + IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ')*'+
                      '('+SQL4QtyField(tInStock,'ifnull(PQA.Qty,0)') +')),' +IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');
    SQLList.Add(' FROM ' + ProductTables(tProductList, False, False,0, true, transdate));
    SQLList.Add('Where  (P.Batch = "F" and P.SNTracking ="F" and P.MultipleBins="F")');
    SQLList.Add      ('and (P.Parttype = "INV") ');
    if classID <> 0 then      SQLList.Add('and (PQA.DepartmentID =' + IntToStr(classID) + ')');
    if ProductID <> 0 then      SQLList.Add('and (PQA.ProductID =' + IntToStr(ProductID) + ')');
    if TransDate <> 0 then      SQLList.Add('and (PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat,
        TransDate)) + ')');
    SQLList.Add('Group by P.PartsId, PC.ClassId, ifNull(PQA.UOM, ' +
      QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ') ');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function StockQtyDetails(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): String;
var
  SQLList: TStringList;
begin
//  Logtext(DetailQtyfield(tDetails,False, False));
//  Logtext(DetailQtyfield(tDetails,true, False));

  SQLList := TStringList.Create;
  try
    SQLList.Add('SELECT distinct P.PartsId, PC.classId as DepartmentID,PQA.UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
      ') as UOM,ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('2 as gLevel, P.PartName as Productname,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('PQABatch.Value as Batchnumber, ');
    SQLList.Add('PQABatch.TruckLoadNo as TruckLoadNo, ');
    SQLList.Add('DATE_FORMAT(PQABatch.Expirydate , ' + QuotedStr('%d/%m/%Y') + ') as ExpiryDate , ');
    SQLList.Add('PQABatch.Expirydate as BatchExpiryDate, ');
    SQLList.Add('"" as BinLocation , "" as Binnumber, "" as SerialNumber, ');
    //SQLList.Add(SQL4Qty(tAvailable        , 'PQA',      SQL4QtyField(tAvailable , 'PQA', DetailQtyfield(tDetails  ,true   , False))) + ' as UOMQty,');
    SQLList.Add(SQL4Qty(tAvailable        , 'PQA',      DetailQtyfield(tDetails  ,true   , False)) + ' as UOMQty,');
    //SQLList.Add(SQL4Qty(tAvailable        , 'PQA',      SQL4QtyField(tAvailable , 'PQA', DetailQtyfield(tDetails  ,False  , False))) + ' as Qty,');
    SQLList.Add(SQL4Qty(tAvailable        , 'PQA',      DetailQtyfield(tDetails  ,False  , False)) + ' as Qty,');
    SQLList.Add(SQL4Qty(tAvailable        , 'PQA',      'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.CUSTFLD1 ,0 )') + ' as CUSTFLD1,');
    //SQLList.Add(SQL4Qty(tInStock          , 'PQA',      SQL4QtyField(tInStock   , 'PQA', DetailQtyfield(tDetails  ,true   , False))) + ' as InstockUOMQty,');
    SQLList.Add(SQL4Qty(tInStock          , 'PQA',      DetailQtyfield(tDetails  ,true   , False)) + ' as InstockUOMQty,');
    //SQLList.Add(SQL4Qty(tInStock          , 'PQA',      SQL4QtyField(tInStock   , 'PQA', DetailQtyfield(tDetails  ,False  , False))) + ' as InstockQty,');
    SQLList.Add(SQL4Qty(tInStock          , 'PQA',      DetailQtyfield(tDetails  ,False  , False)) + ' as InstockQty,');
    if IncludeSOQty then begin
      //SQLList.Add(SQL4Qty(tSO             , 'PQA',      SQL4QtyField(tSO        , 'PQA', DetailQtyfield(tDetails  ,true   , False))) + ' as SOUOMQty,');
      SQLList.Add(SQL4Qty(tSO             , 'PQA',      DetailQtyfield(tDetails  ,true   , False)) + ' as SOUOMQty,');
      //SQLList.Add(SQL4Qty(tSO             , 'PQA',      SQL4QtyField(tSO        , 'PQA', DetailQtyfield(tDetails  ,False  , False))) + ' as SOQty,');
      SQLList.Add(SQL4Qty(tSO             , 'PQA',      DetailQtyfield(tDetails  ,False  , False)) + ' as SOQty,');
    end;
    if haveActStockwithManQty then begin
      //SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', SQL4QtyField(tActStockwithMan, 'PQA', DetailQtyfield(tDetails  ,true   , False))) + ' as ActStockwithManUOMQty,');
      SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', DetailQtyfield(tDetails  ,true   , False)) + ' as ActStockwithManUOMQty,');
      //SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', SQL4QtyField(tActStockwithMan, 'PQA', DetailQtyfield(tDetails  ,False  , False))) + ' as ActStockwithManQty,');
      SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', DetailQtyfield(tDetails  ,False  , False)) + ' as ActStockwithManQty,');
    end;
    (*SQLList.Add('0.0 , 0.0');*)
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Cost,');
    SQLList.Add('Round(sum(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' + IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ')*'+
                      '('+SQL4QtyField(tInStock, 'PQA', DetailQtyfield(tDetails,False , False))+')),' +IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');

    SQLList.Add(' FROM ' + ProductTables(tDetails, FilterAvailableSN, False , 0, true, transDate));
    SQLList.Add('Where  (P.Batch = "T")');
    if classID <> 0 then
      SQLList.Add('and PQA.DepartmentID =' + IntToStr(classID));
    if ProductID <> 0 then
      SQLList.Add('and PQA.ProductID =' + IntToStr(ProductID));
    if TransDate <> 0 then
      SQLList.Add('and PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat, TransDate)));
    SQLList.Add('group by PQA.ProductID , PC.ClassId , ifNull(PQA.UOM, ' +
      QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) +
      ') ,PQABatch.Value , PQABatch.TruckLoadNo, PQABatch.Expirydate ');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;
Function ProductUOMSQL(ProductID:Integer):String;
begin
  result:= 'select s.* from (select @IntParam:='+inttostr(ProductID)+') IntParam , ('+ ProductUOMSQL+') s';
end;
Function ProductUOMSQL:String;
begin
  REsult :=     ' select u.UnitID AS UnitID, ' +
          ' u.PartID , ' +NL+
          ' u.UnitName AS UnitName, ' +
          ' u.Multiplier AS Multiplier, ' +
          ' u.UnitDescription AS UnitDescription, ' +
          ' u.BaseUnitName AS BaseUnitName  ' +
          ' from tblunitsofmeasure u  ' +
          ' where ((u.Active = "T") and (ifnull(u.PartID,0) = :xPartsID))  ' +
    ' union all  ' +
    ' select u.UnitID AS UnitID, ' +
          ' u.PartID , ' +NL+
          ' u.UnitName AS UnitName, ' +
          ' u.Multiplier AS Multiplier, ' +
          ' u.UnitDescription AS UnitDescription, ' +
          ' u.BaseUnitName AS BaseUnitName  ' +
          ' from tblunitsofmeasure u  ' +
          ' where ((u.Active = "T")  ' +
          ' and (ifnull(u.PartID,0) = 0)  ' +
          ' and (not(u.UnitName in (select tblunitsofmeasure.UnitName  ' +
                ' from tblunitsofmeasure where (ifnull(tblunitsofmeasure.PartID,0) = :xPartsID)))))  ' +
    ' order by PartID desc, UnitID ,UnitName ';
end;
Function ProductUOMSQL(const Tablename:String):String;
begin
  REsult:= 'drop table if exists  ' + Tablename +' ; '+
           ' create table  ' + Tablename +'  Select PartsID, PArtname   from tblparts; '+
           ' alter table  ' + Tablename +'  add index PartsId (PartsID); '+
           ' alter table  ' + Tablename +'  add column PUOMId int(11), add column SUOMID int(11), add column PUOM varchar(100), '+
                        ' add column SUOM varchar(100), add column PMult double, add column SMult double; '+
           ' update  ' + Tablename +'  T  '+
                        ' inner join tblunitsofmeasure PurchdefUOM on ifnull(PurchdefUOM.PartID,0)= T.PARTSid and PurchdefUOM.PurchasesDefault = "T" and PurchdefUOM.Active = "T"    '+
                        ' Set T.PUOMID = PurchdefUOM.unitID, T.PUOM = PurchdefUOM.unitname, T.PMult = PurchdefUOM.Multiplier; '+
           ' update  ' + Tablename +'  T  '+
                        ' inner join tblunitsofmeasure SalesdefUOM on ifnull(SalesdefUOM.PartID,0)= T.PARTSid and SalesdefUOM.SalesDefault = "T" and SalesdefUOM.Active = "T"    '+
                        ' Set T.SUOMID = SalesdefUOM.unitid, T.SUOM = SalesdefUOM.unitname, T.SMult = SalesdefUOM.Multiplier; '+
           'Drop table if exists ' +tablename +'UOM;' +
           'Create table  ' +tablename +'UOM  '+
                        ' select  GenericUOM.unitID, GenericUOM.unitname, GenericUOM.Multiplier   '+
                        ' from  tblunitsofmeasure GenericUOM    '+
                        ' where   ifnull(GenericUOM.PartID,0)=0  '+
                        ' and  GenericUOM.Multiplier =1     '+
                        ' and GenericUOM.UnitName =  ' +Quotedstr(AppEnvVirt.Str['DefaultClass.DefaultUOM'])+'  '+
                        ' and (ifnull(GenericUOM.BaseunitID,GenericUOM.UnitID) = 0 or ifnull(GenericUOM.BaseunitID,GenericUOM.UnitID) = GenericUOM.UnitID);' +
           ' update  ' + Tablename +'  T  '+
                        ', ' +tablename +'UOM  GenericUOM  Set T.PUOMID = GenericUOM.unitId , T.PUOM = GenericUOM.unitname, T.PMult = GenericUOM.Multiplier where ifnull(T.PUOMID,0)=0; '+
           ' update  ' + Tablename +'  T  '+
                        ', ' +tablename +'UOM  GenericUOM  Set T.SUOMID = GenericUOM.unitId , T.PUOM = GenericUOM.unitname, T.PMult = GenericUOM.Multiplier where ifnull(T.SUOMID,0)=0; ' +
           ' Drop table if exists ' +tablename +'UOM;' ;

end;

Function StockQtySummary(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN:Boolean =True; haveActStockwithManQty :Boolean = False): String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('Select distinct');
    SQLList.Add('P.PartsId, PC.ClassId as DepartmentID,PQA.UOMID, ');
    SQLList.Add('ifNull(PQA.UOM, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ') as UOM,');
    SQLList.Add('ifnull(PQA.UOMMultiplier, 1) as UOMMultiplier,');
    SQLList.Add('1 as gLevel , P.PartName as ProductName,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('"" as Batchnumber , "" as TruckLoadNo ,"" as ExpiryDate, null as BatchExpiryDate, ');
    SQLList.Add('"" as Binlocation, "" as Binnumber , "" as Serialnumber, ');
    SQLList.Add(SQL4Qty(tAvailable, 'PQA', 'PQA.UOMQty') + ' as UOMQty,');
    SQLList.Add(SQL4Qty(tAvailable) + ' as Qty,');
    SQLList.Add('0.0 as CUSTFLD1,');
    SQLList.Add(SQL4Qty(tInStock, 'PQA', 'PQA.UOMQty') + ' as InstockUOMQty,');
    SQLList.Add(SQL4Qty(tInStock) + ' as InstockQty,');
    if IncludeSOQty then begin
      SQLList.Add(SQL4Qty(tSO, 'PQA', 'ifnull(PQA.UOMQty,0)') + ' as SOUOMQty,');
      SQLList.Add(SQL4Qty(tSO, 'PQA', 'ifnull(PQA.Qty,0)') + ' as SOQty,');
    end;
    if haveActStockwithManQty then begin
      SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', 'ifnull(PQA.UOMQty,0)') + ' as ActStockwithManUOMQty,');
      SQLList.Add(SQL4Qty(tActStockwithMan, 'PQA', 'ifnull(PQA.Qty,0)') + ' as ActStockwithManQty,');
    end;
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Cost,');

(*    SQLList.Add('Round(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) +
      ')*Sum(if(PQA.alloctype="IN"  , PQA.Qty, 0-PQA.Qty)),' +
      IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');*)

    SQLList.Add('Round(sum(Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),' + IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ')*'+
                      '('+SQL4QtyField(tInStock) +')),' +IntToStr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) + ') as Value');

    SQLList.Add(' FROM ' + ProductTables(tProductList, FilterAvailableSN, False,0, true, transdate));
    SQLList.Add
      ('Where (P.Parttype = "INV")  '+
              //' /* and ((ifnull(PQA.PQAID,0) = 0) or ((PQA.Active = "T")*/ '+
              ' ');
    if classID <> 0 then
      SQLList.Add('and (PQA.DepartmentID =' + IntToStr(classID) + ')');
    if ProductID <> 0 then
      SQLList.Add('and (PQA.ProductID =' + IntToStr(ProductID) + ')');
    if TransDate <> 0 then
      SQLList.Add('and (PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat,
        TransDate)) + ')');
    //SQLList.Add('))');
    SQLList.Add('Group by P.PartsId, PC.ClassId, ifNull(PQA.UOM, ' +
      QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ') ');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function NonStockQtySummary(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; TransDate: TDate = 0; FilterAvailableSN: Boolean = True;
  gLevel: integer = 1): String;
var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add('Select');
    SQLList.Add('P.PartsId, PC.ClassId as DepartmentID,');
    SQLList.Add('0 as UOMID,');
    SQLList.Add('"Units" as UOM,');
    SQLList.Add('1 as UOMMultiplier,');
    SQLList.Add(IntToStr(gLevel) + ' as gLevel , P.PartName as ProductName,');
    SQLList.Add(Firstcolumn + ' as ProductColumn1,');
    SQLList.Add(Secondcolumn + ' as ProductColumn2,');
    SQLList.Add(Thirdcolumn + ' as ProductColumn3,');
    SQLList.Add('PartsDescription,PC.Classname,');
    SQLList.Add('"" as Batchnumber , "" as TruckLoadNo ,"" as ExpiryDate, null as BatchExpiryDate,');
    SQLList.Add('"" as Binlocation, "" as Binnumber , "" as Serialnumber,');
    SQLList.Add('0.0 as UOMQty,');
    SQLList.Add('0.0 as Qty,');
    SQLList.Add('0.0 as CUSTFLD1,');
    SQLList.Add('0.0 as InstockUOMQty,');
    SQLList.Add('0.0 as InstockQty,');
    SQLList.Add('0.0 as SOUOMQty,');
    SQLList.Add('0.0 as SOQty,');
    SQLList.Add('Round(If(P.AvgCost=0.00,Cost1,P.AvgCost),2) as Cost,');
    SQLList.Add('0.0 as Value');
    SQLList.Add('FROM `tblParts` as P');
    SQLList.Add('Left join `tblProductClasses` as PC on PC.ProductID = P.PartsId');
    SQLList.Add('Where (P.Parttype = "NONINV")');

    if classID <> 0 then
      SQLList.Add('and (PC.ClassID =' + IntToStr(classID) + ')');
    if ProductID <> 0 then
      SQLList.Add('and (P.ProductID =' + IntToStr(ProductID) + ')');
//    if TransDate <> 0 then
//      SQLList.Add('and (PQA.TransDate <' + QuotedStr(FormatDateTime(MysqlDateFormat,
//        TransDate)) + ')');
//    SQLList.Add('Group by P.PartsId, PC.ClassId, ifNull(PQA.UOM, ' +
//      QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ') ');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function StockQty(Const IncludeSOQty: Boolean = True; Const ProductID: Integer = 0;
  const classID: Integer = 0; Const mode: TFiltertype = tSummary;
  Const TransDate: TDate = 0; FilterAvailableSN : Boolean = True; haveActStockwithManQty :Boolean = False): String;

var
  SQLList: TStringList;
begin
  SQLList := TStringList.Create;
  try
    SQLList.Add(StockQtySummary(IncludeSOQty, ProductID, classID, TransDate, FilterAvailableSN , haveActStockwithManQty));
    if (mode = tDetails) or (mode = tFtAll) then begin
      SQLList.Add('union all ');
      SQLList.Add(StockQtyDetails(IncludeSOQty, ProductID, classID, TransDate, FilterAvailableSN , haveActStockwithManQty));
    end;
    if (mode = tExtraDetails) or (mode = tFtAll) then begin
      SQLList.Add('union all ');
      SQLList.Add(StockQtyExtraDetails(IncludeSOQty, ProductID, classID, TransDate, FilterAvailableSN, haveActStockwithManQty));
    end;
    if (mode = tDetailswithSno) or (mode = tFtAll) then begin
      SQLList.Add('union all ');
      SQLList.Add(StockQtyDetailswithSno(IncludeSOQty, ProductID, classID, TransDate, FilterAvailableSN, False , haveActStockwithManQty));
    end;
    SQLList.Add
      ('order by ClassName, ProductName ,  UOM, gLevel, batchnumber, TruckLoadNo, expirydate, binlocation,binnumber');
  finally
    result := SQLList.Text;
    Freeandnil(SQLList);
  end;
end;

Function ISCashSale(const SalesAlias: String = 'S'): String;
begin
  result := '/*CashSale*/(' + 'ifnull(' + SalesAlias + '.ISCashSale,"F")="T" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ispos,"F")="F" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.Deleted,"F") ="F"' + ')';
end;

Function ISInvoice(const SalesAlias: String = 'S'): String;
begin
  result := '/*Invoice*/(' + 'ifnull(' + SalesAlias + '.ISInvoice,"F")="T" ' + ' and ' + '  ifnull('
    + SalesAlias + '.Deleted,"F") ="F"' + ')';
end;

Function ISSO(const SalesAlias: String = 'S'): String;
begin
  result := '/*SO*/(' + 'ifnull(' + SalesAlias + '.IsSalesOrder,"F")="T" ' + ' and ' + ' ifnull(' +
    SalesAlias + '.Deleted,"F") ="F"' + ')';
end;

Function ISActiveSO(const SalesAlias: String = 'S'): String;
begin
  result := '/*ActiveSo*/(' + 'ifnull(' + SalesAlias + '.IsSalesOrder,"F")="T" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.Deleted,"F") ="F"' + ' and ' + ' ifnull(' + SalesAlias +
    '.Converted,"F") ="F"' + ')';
end;

Function ISRefund(const SalesAlias: String = 'S'): String;
begin
  result := '/*Refund*/(' + 'ifnull(' + SalesAlias + '.ISrefund,"F")="T" ' + ' and ' + ' ifnull(' +
    SalesAlias + '.ispos,"F")="F" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.Deleted,"F") ="F"' + ')';
end;

Function ISquote(const SalesAlias: String = 'S'): String;
begin
  result := '/*quote*/(' + 'ifnull(' + SalesAlias + '.IsQuote,"F")="T" ' + ' and ' + ' ifnull(' +
    SalesAlias + '.Deleted,"F") ="F"' + ')';
end;

Function IsLaybyPayment(const SalesAlias: String = 'S'): String;
begin
  result := '/*LaybyPayment*/(' + 'ifnull(' + SalesAlias + '.POS,"F")="T" ' + ' and ' + ' ifnull(' +
    SalesAlias + '.IsLaybyPayment,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.ISPOS,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias + '.Deleted,"F") ="F"' + ')';
end;

Function IsReverseLayBy(const SalesAlias: String = 'S'): String;
begin
  result := '/*ReverseLayBy*/(' + 'ifnull(' + SalesAlias + '.Paymethod,"")="Layby" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISPOS,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.IsLaybyPayment,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias + '.Paid,"F")="T" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISLaybyTOS,"F") ="F"' + ')';
end;

Function IsPaidLayby(const SalesAlias: String = 'S'): String;
begin
  result := '/*PaidLayby*/(' + 'ifnull(' + SalesAlias + '.Paymethod,"")="Layby" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISPOS,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.IsLaybyPayment,"F")="F" ' + ' and ' + ' ifnull(' + SalesAlias + '.Paid,"F")="T" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISLaybyTOS,"F") ="F"' + ')';
end;

Function IsUnpaidLayby(const SalesAlias: String = 'S'): String;
begin
  result := '/*UnpaidLayby*/(' + 'ifnull(' + SalesAlias + '.Paymethod,"")="Layby" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISPOS,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.IsLaybyPayment,"F")="F" ' + ' and ' + ' ifnull(' + SalesAlias + '.Paid,"F")="F" ' + ' and ' +
    ' ifnull(' + SalesAlias + '.ISLaybyTOS,"F") ="T"' + ')';
end;

Function IsLayby(const SalesAlias: String = 'S'): String;
begin
  result := '/*Layby*/(' + 'ifnull(' + SalesAlias + '.Paymethod,"")="Layby" ' + ' and ' + ' ifnull('
    + SalesAlias + '.ISPOS,"F")="T" ' + ' and ' + ' ifnull(' + SalesAlias +
    '.IsLaybyPayment,"F")="F" ' + ')';
end;


function ProductPrintTreeSQL(const IDs: String): String;
begin
  result := 'SELECT    P.TAXCODE, P.GlobalRef,P.PARTSID, P.PARTTYPE,P.PRODUCTGROUP,' +
    ' P.PARTNAME, P.PARTSDESCRIPTION,  P.PURCHASEDESC, P.INCOMEACCNT,' +
    ' P.ASSETACCNT,P.COGSACCNT, P.BARCODE,P.PRODUCTCODE,  P.TAXCODE, ' +
    ' P.PURCHTAXCODE,P.PREFEREDSUPP,P.SpecialDiscount, P.SNTracking,  ' +
    ' P.MultipleBins,P.batch, P.AutoBatch,P.AutoReorder,P.BuyQTY1, P.BuyQTY2,  ' +
    ' P.BuyQTY3,P.COST1,P.COST2, P.COST3,P.AvgCost,P.SellQTY1,P.SellQTY2, ' +
    ' P.SellQTY3,P.PRICE1,P.PRICE2,P. PRICE3,P.WHOLESALEPRICE,P.Active,   ' +
    ' P.productcomment,  ' +
    ' PRICE1 + TC.Rate* P.PRICE1 as priceinc1, ' +
    ' PRICE2 + TC.Rate* P.PRICE2 as priceinc2, ' +
    ' PRICE3 + TC.Rate* P.PRICE3 as priceinc3, ' +
    ' ((P.PRICE1 + TC.Rate* P.PRICE1 )*1.5) as retail1, ' +
    ' ((P.PRICE2 + TC.Rate* P.PRICE2 )*1.5) as retail2, ' +
    ' ((P.PRICE3 + TC.Rate* P.PRICE3 )*1.5) as retail3    ,' +
    '  Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) as Productname,  ' +
    ' PT.Caption,PT.Description,' + ' PT.TreePartUOMQuantity as Quantity, ' +
    ' PT.TreePartUOMTotalQty as TotalQty, ' +
    ' concat(PT.TreePartUOM,"(", PT.TreePartUOMMultiplier,")") as UOM, ' + 'PT.AddToSale,' +
    ' PT.PartSource,PT.InputType,PT.Price,PT.Cost  ,' + ' PS.description  as Process,PT.ProcTreeId,'
    + ' PP.HourlyLabourRate*((ifnull(PP.Duration,0)/60/60) +(ifnull(PP.SetupDuration,0)/60/60))  *ifnull(PT.TotalQty,0) as LabourPrice,'
    + ' PP.HourlyLabourRate , ' +
    'concat(SEC_TO_TIME(ifnull(PP.Duration,0)),"   ") as Duration, ' +
    'concat(SEC_TO_TIME(ifnull(PP.SetupDuration,0)),"   ") as SetupDuration,  ' +
    '(Select cost from tblproctree PTRoot where PTRoot.mastertype ="mtProduct" and PTRoot.masterId  = PT.masterId and ifnull(PTRoot.ParentId,0)=0) as finalProductcost, ' +
    '(Select cost from tblproctree PTRoot where PTRoot.mastertype ="mtProduct" and PTRoot.masterId  = PT.masterId and ifnull(PTRoot.ParentId,0)=0) +'+
    '(Select Sum(( SPP.HourlyLabourRate*((ifnull(SPP.Duration,0)/60/60) +(ifnull(SPP.SetupDuration,0)/60/60))  *ifnull(sPT.TotalQty,0))) ' +
    'from tblproctree sPT inner join   `tblprocesspart`  SPP  on sPT.ProcTreeId = SPP.ProcTreeId where SPT.mastertype ="mtProduct" and SPT.masterId  = PT.masterId  ) as finalProductcostWithLabout,'+
    '(Select Sum(( SPP.HourlyLabourRate*((ifnull(SPP.Duration,0)/60/60) +(ifnull(SPP.SetupDuration,0)/60/60))  *ifnull(sPT.TotalQty,0))) ' +
    'from tblproctree sPT inner join   `tblprocesspart`  SPP  on sPT.ProcTreeId = SPP.ProcTreeId where SPT.mastertype ="mtProduct" and SPT.masterId  = PT.masterId  ) as totalLabour,'+
    '(Select Price from tblproctree PTRoot where PTRoot.mastertype ="mtProduct" and PTRoot.masterId  = PT.masterId and ifnull(PTRoot.ParentId,0)=0) as finalProductPrice ' +
    chr(13) + ' FROM `tblparts` P' +
    ' Inner Join `tbltaxcodes` TC ON P.TAXCODE = TC.Name and RegionID = ' +
    IntToStr(AppEnvVirt.Int['RegionalOptions.ID']) +
    ' LEFT join `tblProcTree` PT   on PT.MasterId = P.PartsID and PT.Mastertype = "mtProduct"' +
    ' LEFT join `tblprocesspart`   PP on PT.ProcTreeId = PP.ProcTreeId' +
    ' LEFT join `tblProcessStep` PS on PS.Id  = PP.ProcessStepID' +
    ' LEFT join `tblProcResourceProcess`  PRP on PRP.ProcessStepId=PS.ID' +
    ' LEFT join `tblProcResource` PR on PR.ProcResourceId = PRP.ProcResourceId';
  if IDs <> '' then
    result := result + ' where P.PartsId in (' + IDs + ')';
  result := result + ' order by P.partsID , PT.SequenceDown, PT.ParentId';
end;

function ManufactureSubProductSQL(const SubProductID: Integer): String;
begin
  result := 'SELECT    P.TAXCODE, P.GlobalRef,P.PARTSID, P.PARTTYPE,P.PRODUCTGROUP,' +
    ' P.PARTNAME, P.PARTSDESCRIPTION,  P.PURCHASEDESC, P.INCOMEACCNT,' +
    ' P.ASSETACCNT,P.COGSACCNT, P.BARCODE,P.PRODUCTCODE,  P.TAXCODE, ' +
    ' P.PURCHTAXCODE,P.PREFEREDSUPP,P.SpecialDiscount, P.SNTracking,  ' +
    ' P.MultipleBins,P.batch, P.AutoBatch,P.AutoReorder,P.BuyQTY1, P.BuyQTY2,  ' +
    ' P.BuyQTY3,P.COST1,P.COST2, P.COST3,P.AvgCost,P.SellQTY1,P.SellQTY2, ' +
    ' P.SellQTY3,P.PRICE1,P.PRICE2,P. PRICE3,P.WHOLESALEPRICE,P.Active,   ' + ' P.productcomment,  '
    + '  Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) as Productname,  ' +
    ' PT.Caption,PT.Description,' + ' PT.TreePartUOMQuantity as Quantity, ' +
    ' PT.TreePartUOMTotalQty as TotalQty, ' +
    ' concat(PT.TreePartUOM,"(", PT.TreePartUOMMultiplier,")") as UOM, ' + 'PT.AddToSale,' +
    ' PT.PartSource,ifnull(ParentPt.InputType,"itNone") as parentInputType  , PT.selected,Pt.InputType , PT.Price,PT.Cost  ,'
    + ' PS.description  as Process,PT.ProcTreeId,' +
    ' PR.HourlyLabourRate*(ifnull(PP.Duration,0) +ifnull(PP.SetupDuration,0))  *ifnull(PT.TotalQty,0) as LabourPrice,'
    + ' PR.HourlyLabourRate , ' + chr(13) +
    '/* the following will convert the duration stored as a number into hours:min*/' + chr(13) +
    ' if(ifnull(PP.Duration,0)=0,"" ,  ' +
    ' concat(SUBSTRING(concat("00" , TRuncate(ifnull(PP.Duration,0),0)) ,-2,2) , ":" , ' +
    ' SUBSTRING(concat("00" , (ifnull(PP.Duration,0) - TRuncate(ifnull(PP.Duration,0),0))*60),-2,2)))     Duration, '
    + chr(13) + ' if(ifnull(PP.SetupDuration,0)=0 , "" ,' +
    ' concat(SUBSTRING(concat("00" , TRuncate(ifnull(PP.SetupDuration,0),0)) ,-2,2) , ":" , ' +
    ' SUBSTRING(concat("00" , (ifnull(PP.SetupDuration,0) - TRuncate(ifnull(PP.SetupDuration,0),0))*60),-2,2)))     SetupDuration'
    + chr(13) + ' FROM `tblparts` P' +
    ' inner join `tblProcTree` PT   on PT.MasterId = P.PartsID and PT.Mastertype = "mtProduct"' +
    ' LEFT  join `tblProcTree` ParentPt on ParentPt.ProcTreeId = Pt.ParentID ' +
    ' LEFT join `tblprocesspart`   PP on PT.ProcTreeId = PP.ProcTreeId' +
    ' LEFT join `tblProcessStep` PS on PS.Id  = PP.ProcessStepID' +
    ' LEFT join `tblProcResourceProcess`  PRP on PRP.ProcessStepId=PS.ID' +
    ' LEFT join `tblProcResource` PR on PR.ProcResourceId = PRP.ProcResourceId' +
    ' where ifnull(pt.parentID,0) <> 0 and Pt.PartsId = ' + IntToStr(SubProductID);

end;

function salesPrintTreeSQL(const IDs: String(*; tablename :String*)): String;
begin

   result := 'SELECT    S.SaleId, SL.salelineId, Sl.Productname as LineProduct, SL.Product_Description_Memo,SL.Product_Description, SL.MemoLine , ' +
    '  Convert(TreeNodeCaption(PT.Level, PT.caption ) , char(255)) as Productname,  ' + 'P.Parttype,' +
    ' PT.Caption,PT.Description,' + ' PT.Info , PT.TreePartUOMQuantity as Quantity, ' +
    'PT.Selected , '+
    ' PT.TreePartUOMTotalQty as TotalQty, ' +
    ' concat(PT.TreePartUOM,"(", PT.TreePartUOMMultiplier,")") as UOM, ' + ' PT.AddToSale,' +
    ' PT.PartSource,PT.InputType,PT.Price,PT.Cost  ,' + ' PS.description  as Process,' +
    ' ifnull(PS.description,"No Process")  as ProcessDesc,' + ' PT.ProcTreeId,' +
    ' PR.HourlyLabourRate*(ifnull(PP.Duration,0) +ifnull(PP.SetupDuration,0))  *ifnull(PT.TotalQty,0) as LabourPrice,'
    + ' PR.HourlyLabourRate , ' + chr(13) +
    '/* the following will convert the duration stored as a number into hours:min*/' + chr(13) +
    ' if(ifnull(PP.Duration,0)=0,"" ,  ' +
    ' concat(SUBSTRING(concat("00" , TRuncate(ifnull(PP.Duration,0),0)) ,-2,2) , ":" , ' +
    ' SUBSTRING(concat("00" , (ifnull(PP.Duration,0) - TRuncate(ifnull(PP.Duration,0),0))*60),-2,2)))     Duration, '
    + chr(13) + ' if(ifnull(PP.SetupDuration,0)=0 , "" ,' +
    ' concat(SUBSTRING(concat("00" , TRuncate(ifnull(PP.SetupDuration,0),0)) ,-2,2) , ":" , ' +
    ' SUBSTRING(concat("00" , (ifnull(PP.SetupDuration,0) - TRuncate(ifnull(PP.SetupDuration,0),0))*60),-2,2)))     SetupDuration,'
    + '`PT`.`SequenceDown`,`PT`.`ParentId`, ' + chr(13) +
    'Describeformula(FE.formula) as DescFormula,' +
    'replace(replace(replace(replace(replace(FE.formula , "Field1" , PT.FormulaQtyValue1), "Field2" ,PT.FormulaQtyValue2), "Field3" , PT.FormulaQtyValue3), "Feild4" , PT.FormulaQtyValue4), "Feild5" , PT.FormulaQtyValue5) as FormulaWithValue, ' +
    Firstcolumn('P') +' as Cat1, '+
    SecondColumn('P') +' as Cat2, '+
    Thirdcolumn('P') +' as Cat3, '+
    'PT.FormulaQtyValue1 , '+
    'PT.FormulaQtyValue2 , '+
    'PT.FormulaQtyValue3 , '+
    'PT.FormulaQtyValue4 , '+
    'PT.FormulaQtyValue5 , '+
    'FE.formulaname  '+
    ' FROM `tblSales` S inner join `tblsaleslines` SL on s.SaleId = SL.SAleID' +
    ' LEFT JOIN `tblProcTree` PT   on PT.MasterId = Sl.SaleLineID and PT.Mastertype <> "mtProduct"'
    + ' LEFT JOIN `tblPArts` P on P.PartsId = PT.PartsId' +
    ' LEFT JOIN `tblprocesspart`   PP on PT.ProcTreeId = PP.ProcTreeId' +
    ' LEFT JOIN `tblProcessStep` PS on PS.Id  = PP.ProcessStepID' +
    ' LEFT JOIN `tblProcResourceProcess`  PRP on PRP.ProcessStepId=PS.ID' +
//    ' Left join tblFEFormula FE on FE.formulaId = PT.Formulaid) on RPT.ProcTreeId = PT.TreeRootId ' +
    ' Left join tblFEFormula FE on FE.formulaId = PT.Formulaid ' +
    ' LEFT JOIN `tblProcResource` PR on PR.ProcResourceId = PRP.ProcResourceId';
  if IDs <> '' then
    result := result + ' where S.SaleId  in (' + IDs + ')';
  result := result +
    ' Order by s.sAleId, Sl.SalELineID  '+
              //' /*, `PT`.`ParentId` */ '+
              ' , `PT`.`SequenceDown`  ';

end;

Function ReportSQLforBarCodeLabels: String;
begin
  result := '{CompanyInfo}SELECT   CompanyName, Address, Address2,  ' +
    ' City, State, Postcode, ABN ' + ' FROM `tblCompanyInformation`  ' +
    ' ~|||~{Details}Select    P.PARTNAME,  P.PRODUCTCODE, ' +
    ' P.BARCODE as BARCODE,  (P.Price1 + (P.Price1 * 0.10))   as PriceInc, ' +
    ' BCP.BatchNo, P.PREFEREDSUPP as SupplierName,  "N/A" as ClassName,P.*     , ' +
    'if(' +quotedstr(AppEnvVirt.str['CompanyPrefs.ProductListPriceMultiplierOn'])+' = "CI" , CostInc1*' +floatTostr(AppEnvVirt.float['CompanyPrefs.ProductListPriceMultiplier'])+' ,Cost1*' +floatTostr(AppEnvVirt.float['CompanyPrefs.ProductListPriceMultiplier'])+') as ListPrice,' +
    ' P.PARTSDESCRIPTION  as PARTSDESCRIPTION  , ' +
    ' ifnull(PDU.Unitname, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ')  as PurchaseDefaultUOM, ' +
    ' ifnull(SDU.Unitname, ' + QuotedStr(AppEnvVirt.Str['DefaultClass.DefaultUOM']) + ')  as SalesDefaultUOM,  ' +
    'CostInc1 * if(ifnull(PDU.Multiplier,0)=0,1,PDU.Multiplier)   as PurchaseDefaultUOMCostinc, ' +
    'Priceinc1* if(ifnull(SDU.Multiplier,0)=0,1,SDU.Multiplier)   as SalesDefaultUOMPriceinc, '+
    ' Concat_ws(" " , ifnull(BinLocation,"") , ifnull(BinNumber,"")) as DefaultBin , ' +
    '(P.PRICE1 + (P.PRICE1 * (PC.ClassPriceVariance/100))) + ((P.PRICE1 + (P.PRICE1 * (PC.ClassPriceVariance/100)))* ifnull(T1.Rate,0)) as VariancePriceInc,'
    + ' PC.VariantPrice ' + ' FROM `tblbarcodestoprint` as BCP ' +
    ' INNER JOIN `tblParts` as P ON P.PARTSID = BCP.ProductID ' +
    ' LEFT JOIN  `tblProductClasses` PC on Pc.ProductId = P.PartsId  and PC.classId = BCP.ClassId' +
  (* +IntToStr(Appenv.DefaultClass.ClassID) + *)
    ' LEFT JOIN  `tbltaxcodes` AS T1 ON T1.Name = P.TAXCODE AND T1.RegionID= ' +
    IntToStr(AppEnvVirt.Int['RegionalOptions.ID']) +
    ' LEFT JOIN  `tblproductbin` PB on PB.binID =PC.DefaultbinId ' +
    ' LEFT JOIN  `tblunitsofmeasure` PDU on ifnull(PDU.PartID,0)=P.PartsId and PDU.PurchasesDefault = "T" and PDU.Active = "T" '+
    ' LEFT JOIN  `tblunitsofmeasure` SDU on ifnull(SDU.PartID,0)=P.PartsId and SDU.SalesDefault = "T" and SDU.Active = "T" '+
    '~|||~{ExtraSellPrice} SELECT '+
    ' EPS.PriceID, CONCAT(uom.UnitName , "(" , uom.Multiplier , ")" ) AS uom, '+
    ' DateFrom,DateTo,ExtraSellDesc, P.PartsID , EPS.Terms , QtyPercent1,'+
    ' P.Price1  ProductPrice, EPS.Price1 specialprice '+
    ' FROM tblbarcodestoprint BP '+
    ' inner join tblparts P on BP.productId = P.partsId '+
    ' left join tblextrapricesell EPS  ON EPS.PartsID = P.partsId'+
    ' LEFT JOIN tblunitsofmeasure uom ON uom.UnitID = EPS.UOMID '+
    ' WHERE ((DateFrom <= CURDATE() AND DateTo >= CURDATE()) OR IsNull(DateFrom) OR IsNull(DateTo)) '+
    ' order by DateFrom'

end;
function QtyDesctoType(Desc:String):  TQtytype;
begin
       if	trim(desc)	=	''		            then    result :=	tqtyNone
  else if	trim(desc)	=	'In Stock'		    then    result :=	tInStock
  else if	trim(desc)	=	'Available'		    then    result :=	tAvailable
  else if	trim(desc)	=	'On Order'		    then    result :=	tPOBO
  else if	trim(desc)	=	'Invoice BO'		  then    result :=	tInvBO
  else if	trim(desc)	=	'Sales Order'		  then    result :=	tSO
  else if	trim(desc)	=	'Sales Order BO'	then    result :=	tSOBO
  else if	trim(desc)	=	'Stock'		        then    result :=	tStockQty
  else if	trim(desc)	=	'Transaction'		  then    result :=	tTransQty
  else if	trim(desc)	=	'Stock Movement'	then    result :=	tInStockMovement
  else if	trim(desc)	=	'On Build'		    then    result :=	tOnBuild
  else if	trim(desc)	=	'On Build Raw'    then    result :=	tOnBuild
  else if	trim(desc)	=	'Building'		    then    result :=	tBuilding
  else if	trim(desc)	=	'Built'		        then    REsult :=	tBuilt
  else if	trim(desc)	=	'Sub Built'		    then    REsult := tSubBuilt
  else result :=	tqtyNone;

end;

function QtytypetoDesc(Qtytype: TQtytype): String;
begin
  if Qtytype = tqtyNone then
    result := ''
  else if Qtytype = tInStock then
    result := 'In Stock'
  else if Qtytype = tAvailable then
    result := 'Available'
  else if Qtytype = tPOBO then
    result := 'On Order'
  else if Qtytype = tInvBO then
    result := 'Invoice BO'
  else if Qtytype = tSO then
    result := 'Sales Order'
  else if Qtytype = tSOBO then
    result := 'Sales Order BO'
  else if Qtytype = tStockQty then
    result := 'Stock'
  else if Qtytype = tTransQty then
    result := 'Transaction'
  else if Qtytype = tInStockMovement then
    result := 'Stock Movement'
  else if Qtytype = tOnBuild then
    result := 'On Build Raw'
  else if Qtytype = tBuilding then
    result := 'Building'
  else if Qtytype = tBuilt then
    REsult := 'Built'
  else if Qtytype = tSubBuilt then
    REsult:= 'Sub Built';

end;
function ManufactureTypes   : String;begin  result := pqalib.ManufactureTypes   ;end;
function PPGTypes           : String;begin  result := pqalib.PPGTypes           ;end;
Function RepairType         : String;begin  result := pqalib.RepairType         ;end;
function StockMovementtypes : String;begin  result := pqalib.StockMovementtypes ;end;
function POTranstypes       : String;begin  result := pqalib.POTranstypes       ;end;
Function SalesTransTypes    : STring;begin  result := pqalib.SalesTransTypes    ;end;

end.
