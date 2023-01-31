unit PQALib;

interface
type
    TQtytype = (tqtyNone = 0,
                         tInStock = 1,
                       tAvailable = 2,
                              tPO = 3,
                            tPOBO = 4,
                             tInv = 5,
                           tInvBO = 6,
                              tSO = 7,
                            tSOBO = 8,
                        tStockQty = 9,
                        tTransQty = 10,
                 tInStockMovement = 11,
                            tOUTs = 12,
                             tINs = 13,
                         tOnBuild = 14,
                        tBuilding = 15,
                        tActStock = 16,
                 tInStocknOnorder = 17,
               tAvailablenOnorder = 18,
                           tBuilt = 19,
                        tSubBuilt = 20 ,
                    tUSedForBuild = 21 ,
                 tActStockwithMan = 22,
                        tTotSales = 23,
                     tOnTransitin = 24,
                    tOnTransitOut = 25,
                    tTotSalesExBo = 26,
                  tStockTransnAdj = 27,
                          tRA_All = 28);

Function SalesTransTypes: String;
function POTranstypes: String;
function StockMovementtypes: String;
function ManufactureTypes: String;
function PPGTypes: String;
function Repairtype:String;
function SQL4QtyField(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';  const SumfieldName: STring = 'PQA.QTY'): String;

implementation

uses sysutils;

Function SalesTransTypes: STring;
begin
{'TInvoiceLine','TSalesOrderline','TRefundSaleLine','TPOSCashSaleline','TPOSLaybylines','TCashSaleLine' }
  result := QuotedStr('TInvoiceLine') + ',' + QuotedStr('TSalesOrderline') + ',' +
    QuotedStr('TRefundSaleLine') + ',' + QuotedStr('TPOSCashSaleline') + ',' +
    QuotedStr('TPOSLaybylines') + ',' + QuotedStr('TCashSaleLine');
end;
function ManufactureTypes: String;
begin
{'TProcTreePart','TProcTreePartIN','TProcTreePartINDONE'}
  result := QuotedStr('TProcTreePart') + ',' + QuotedStr('TProcTreePartIN')+ ',' + QuotedStr('TProcTreePartINDONE');
end;
function PPGTypes: String;
begin
  result := QuotedStr('TProcProgressIn') + ',' + QuotedStr('TProcProgressOUT');
end;
Function RepairType:String;
begin
  Result := Quotedstr('TRepairParts');
end;
function StockMovementtypes: String;
begin
  result := QuotedStr('TStockMovementLines');
end;

function POTranstypes: String;
begin
  {'TPurchaseOrderLine', 'TReturnAuthorityLine'}
  result := QuotedStr('TPurchaseOrderLine') + ',' + QuotedStr('TReturnAuthorityLine');
end;

function SQL4QtyField(const Qtytype: TQtytype; const PQAAlias: String = 'PQA';  const SumfieldName: STring = 'PQA.QTY'): String;

  Function ISBOField        : String; begin result := 'ifnull(' + PQAAlias + '.IsBO , "F")' ; end;
  Function PQAActiveField   : String; begin result := PQAAlias + '.Active'                  ; end;
  function PQAAlloctypefield: String; begin REsult := PQAAlias + '.alloctype'               ; end;
  Function PQATranstypeField: String; begin Result := PQAAlias + '.TransType';              ; end;

begin
  case Qtytype of
    tOnBuild:
      result := 'if('+ PQAActiveField +' ="F" and  ' + PQAAlloctypefield +'  ="OUT" and ' + PQATranstypeField +' in (' + ManufactureTypes + '), ifnull(' + SumfieldName + ',0),0)';
    tBuilding:
      result := 'if('+ PQAActiveField +' ="F" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' + ManufactureTypes + '), ifnull(' + SumfieldName + ',0),'+
                'if(' + PQATranstypeField +' = ' +QuotedStr('TSalesOrderInvoiceLines') + ' and ' + PQAAlloctypefield +' ="IN" and '+ PQAActiveField +' ="T", 0-ifnull(' + SumfieldName + ',0),0 ))';
    tBuilt:
      result := 'if('+ PQAActiveField +' ="T" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' + QuotedStr('TProcTreePart') +','+QuotedStr('TProcProgressIn') +
                '), ifnull(' + SumfieldName + ',0),0)';
    tSubBuilt:
      result := 'if('+ PQAActiveField +' ="T" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' +
                  QuotedStr('TProcTreePart' + 'IN')+',' + QuotedStr('TProcProgressIn')  + '), ifnull(' + SumfieldName + ',0),0)';
    tUSedForBuild :
      result := 'if('+ PQAActiveField +' ="T" and  ' + PQAAlloctypefield +'  ="OUT" and ' + PQATranstypeField +' in (' + QuotedStr('TProcTreePart') +',' + QuotedStr('TProcProgressOUT') +
                '), ifnull(' + SumfieldName + ',0),0)';
    tInStock: { IN-OUT :exclude SO and BO }
      result :=' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="F" , 0,  '+
                ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0), '+
                ' if('+ PQAActiveField +' ="F" and not (' + PQATranstypeField +' in (' +QuotedStr('TPRocProgressIN') + ',' +QuotedStr('TPRocProgressOUT') + ')) , 0, '+
                ' if(' + PQATranstypeField +' =' +QuotedStr('TSalesOrderLine') + ' or '+ ISBOField +' ="T",0,'+
                ' if(' + PQATranstypeField +' =' + QuotedStr('TPOSLaybyLines') + ' and ' + PQAAlias +'.Reserved = "T" ,0 ,'+
                ' if(' + PQATranstypeField +' in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +' in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +' in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +' in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ', 0 ,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName + ',0), 0-ifnull(' + SumfieldName + ',0))))))))))))';
    tInStocknOnOrder: { IN-OUT :exclude SO and BO and POBO }
      result := ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="F" , 0, if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0), '+
                ' if('+ PQAActiveField +' ="F" , 0,  '+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TSalesOrderLine') + ' or '+ ISBOField +' ="T",0,'+
                ' if(' + PQATranstypeField +' = ' + QuotedStr('TPOSLaybyLines') + ' and ' + PQAAlias +'.Reserved = "T" ,0 ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TPurchaseOrderLine') + ' and '+ ISBOField +' ="T",ifnull(' + SumfieldName + ',0),'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ', 0 ,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName +',0), 0-ifnull(' + SumfieldName + ',0)))))))))))))';
    tActStockwithMan: { IN-OUT :exclude SO and BO and PROCTREE }
      result := ' if('+ PQAActiveField +' ="F" and not (' + PQATranstypeField +'  in (' +QuotedStr('TSalesOrderLine') + ',' + QuotedStr('TProcTreePart') + ',' + QuotedStr('TProcTreePart' + 'IN') + ')) , 0, '+
                ' if(' + PQATranstypeField +'  = ' +QuotedStr('TSalesOrderLine')  + ' or '+ ISBOField +' ="T",0,'+
                ' if(' + PQATranstypeField +' = ' + QuotedStr('TPOSLaybyLines') + ' and ' + PQAAlias +'.Reserved = "T" ,0 ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ', 0 ,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName +',0), 0-ifnull(' + SumfieldName + ',0))))))))))';
    tActStock: { IN-OUT :exclude SO and BO and PROCTREE }
      result := ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="F" , 0, if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0), '+
                ' if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'  in (' +QuotedStr('TSalesOrderLine') + ',' + QuotedStr('TProcTreePart') + ',' + QuotedStr('TProcTreePart' + 'IN') + ') or '+ ISBOField +' ="T",0,'+
                ' if(' + PQATranstypeField +' = ' + QuotedStr('TPOSLaybyLines') + ' and ' + PQAAlias +'.Reserved = "T" ,0 ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ', 0 ,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName +',0), 0-ifnull(' + SumfieldName + ',0))))))))))))';
    tStockQty: { IN-(OUT+INVBO+SO)+POBO }
      result := ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="F" , 0, if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0), '+
                ' if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQAAlloctypefield +' ="IN" , ifnull('+ SumfieldName + ',0), '+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ', 0 ,'+
                ' if(' + PQAAlloctypefield +' ="OUT" and (' + PQATranstypeField +'<>"TSalesOrderLine" or '+ ISBOField +'="F") ,0-ifnull(' + SumfieldName + ',0),0))))))';
    tAvailable: { IN-(OUT+INVBO+SO+REserve4build)+BuildingQty -RAQty}
      result := ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +' ="TSalesOrderInvoiceLines"  and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0), '+
                ' if('+ PQAActiveField +' ="F" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' +  QuotedStr('TProcProgressIn')+ '), ifnull(' + SumfieldName + ',0), ' +
                ' if('+ PQAActiveField +' ="F" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' + QuotedStr('TProcTreePart') + ',' +QuotedStr('TProcTreePart' + 'IN') + '), ifnull(' + SumfieldName + ',0), ' +
                ' if(('+ PQAActiveField +' ="F") and  (not(' + PQATranstypeField +' in (' +QuotedStr('TProcTreePart') + ',' + QuotedStr('TProcTreePart' + 'IN') + ')) OR ((' + PQATranstypeField +'=' + QuotedStr('TProcTreePart') + ') and (' + PQAAlloctypefield +'  ="IN")) ), 0, '+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ' and  '+ PQAActiveField +' ="F", 0 ,'+
                ' if( ' + PQAAlloctypefield +' ="IN" and  '+ ISBOField +'="F", ifnull(' + SumfieldName + ',0), '+
                ' if(' + PQAAlloctypefield +' ="OUT" and (' + PQATranstypeField +'<>' + QuotedStr('TSalesOrderLine') + ' or '+ ISBOField +'="F") ,0-ifnull(' + SumfieldName + ',0),0))))))))))))';
    tAvailablenOnOrder: { IN-(OUT+INVBO+SO+REserve4build-POBO)+BuildingQty -RAQty}
      result := 'if (' + PQATranstypeField +' =' +QuotedStr('TSalesOrderInvoiceLines') + ' and '+ PQAActiveField +' ="F" ,0 , ' +
                ' if('+ PQAActiveField +' ="F" and  ' + PQAAlloctypefield +'  ="IN" and ' + PQATranstypeField +' in (' + QuotedStr('TProcTreePart') + ',' +QuotedStr('TProcTreePart' + 'IN') + '), ifnull(' + SumfieldName + ',0), ' +
                ' if(('+ PQAActiveField +' ="F") and  (not(' + PQATranstypeField +' in (' +QuotedStr('TProcTreePart') + ',' + QuotedStr('TProcTreePart' + 'IN') + ')) OR ((' + PQATranstypeField +'=' + QuotedStr('TProcTreePart') + ') and (' + PQAAlloctypefield +'  ="IN")) ), 0, '+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLines")    and ' + PQAAlloctypefield +'  ="OUT" and '+ PQAActiveField +' ="T" , 0-ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ("THireLinesIN")    and ' + PQAAlloctypefield +'  ="IN" and '+ PQAActiveField +' ="T" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQAAlloctypefield +' ="IN" and  '+ ISBOField +'="F", ifnull(' + SumfieldName + ',0), '+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ' and  '+ PQAActiveField +' ="F", 0 ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TPurchaseOrderLine') + ' and '+ ISBOField +' ="T", ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'=' + QuotedStr('TReturnAuthorityLine') + ' and  '+ PQAActiveField +' ="T", ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQAAlloctypefield +' ="OUT" and (' + PQATranstypeField +'<>' + QuotedStr('TSalesOrderLine') + ' or '+ ISBOField +'="F") ,0-ifnull(' + SumfieldName + ',0),0))))))))))))';
    tSO: { SO - exclude SOBO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(((' + PQATranstypeField +' = ' +QuotedStr('TSalesOrderLine') + ') OR (' + PQATranstypeField +' = ' +QuotedStr('TPOSLaybyLines') + ' and ' + PQAAlias + '.Reserved = "T")) and ('+ ISBOField +' ="F"),ifnull(' + SumfieldName + ',0), '+
                ' if(' + PQATranstypeField +' = ' +QuotedStr('TSalesOrderInvoiceLines') + ' and ' + PQAAlloctypefield +' ="IN" , 0-ifnull(' + SumfieldName + ',0),0 )))';
    tInvBO: { INVBO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TInvoiceLine') + ' and '+ ISBOField +' ="T",ifnull(' + SumfieldName +',0),0))';

    tInv: { INVBO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TInvoiceLine') + ' and '+ ISBOField +' ="F",ifnull(' + SumfieldName +',0),0))';


    tTotSales: { all Sales }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +' in ("TInvoiceLine","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine")' + ',if(' + PQAAlloctypefield +'  ="OUT", ifnull(' + SumfieldName +',0),0-ifnull(' + SumfieldName +',0)),0))';

    tTotSalesExBo: { all Sales }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if('+ ISBOField +' ="T",0,'+
                ' if(' + PQATranstypeField +' in ("TInvoiceLine","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine")' + ',if(' + PQAAlloctypefield +'  ="OUT", ifnull(' + SumfieldName +',0),0-ifnull(' + SumfieldName +',0)),0)))';


    tPOBO: { POBO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TPurchaseOrderLine') + ' and '+ ISBOField +' ="T",ifnull(' + SumfieldName + ',0),0))';
    tPO: { PO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TPurchaseOrderLine') + ' and '+ ISBOField +' ="F",ifnull(' + SumfieldName + ',0),0))';
    tSOBO: { SOBO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TSalesOrderLine') + ' and '+ ISBOField +' ="T",ifnull(' + SumfieldName +',0),0))';
    tTransQty: { qty of the transaction }
      result := 'if('+ PQAActiveField +' ="F" , 0,'+
                ' if('+ ISBOField +' ="T",0,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName + ',0), 0-ifnull(' + SumfieldName + ',0))))';
    tInStockMovement: { IN-OUT :exclude BO }
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if('+ ISBOField +' ="T",0,'+
                ' if(' + PQAAlloctypefield +' ="IN"  , ifnull(' + SumfieldName + ',0), 0-ifnull(' + SumfieldName+ ',0))))';
    tOUTs: { OUT }
      result := 'if('+ PQAActiveField +' ="T" AND '+ ISBOField +' ="F" AND ' + PQAAlloctypefield +' ="OUT"  and ' + PQATranstypeField +'<>' + QuotedStr('TSalesOrderLine') +',  ifnull(' + SumfieldName + ',0),0 )';
    tINs: { IN }
      result := 'if('+ PQAActiveField +' ="T" AND '+ ISBOField +' ="F" AND ' + PQAAlloctypefield +' ="IN"  ,  ifnull(' + SumfieldName + ',0),0 )';
    tOnTransitin :  {un processed stock transfers}
      Result := '(Select Sum(ifnull(' + SumfieldName + ',0)) from tblstocktransferentrypqa STPQA where ProductId = P.PartsId and active ="T" and alloctype ="IN") ';
    tOnTransitout :  {un processed stock transfers}
      Result := '(Select Sum(ifnull(' + SumfieldName + ',0)) from tblstocktransferentrypqa STPQA where ProductId = P.PartsId and active ="T" and alloctype ="OUT") ';
    tStockTransnAdj :
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="IN" , ifnull(' + SumfieldName + ',0) ,'+
                ' if(' + PQATranstypeField +'  in ('+ StockMovementtypes +')  and '+ PQAActiveField +' ="T"  and '+ PQAAlloctypefield +' ="OUT" , 0-ifnull(' + SumfieldName + ',0) ,0)))';
    tRA_All : {all Status except 'Returned'}
      result := 'if('+ PQAActiveField +' ="F" , 0, '+
                ' if(' + PQATranstypeField +'=' +QuotedStr('TReturnAuthorityLine') + ' and '+ ISBOField +' ="F",ifnull(' + SumfieldName + ',0),0))';

(*                {Return Authority Status based qty}
    tRA_WaitingRANO : {Status : Awaiting RA No.}
    tRA_InTransit : {Status : In Transit}
    tRA_Returned : {Status : Returned}
    tRA_SenttoSupp : {Status : Send To Supplier}
    tRA_Testing : {Status : Testing}
    tRA_Withsupp : {Status : With Supplier}
    tRA_All : {all Status except 'Returned'}*)
  end;
end;
end.

