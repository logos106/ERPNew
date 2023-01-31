unit SalesOrderLib;

interface

uses classes , busobjPQA;

type
  TDoProductallocation = Function (Const LineObj :TProdQty) : Boolean of Object;

function  IsOkToconvert(SOID:Integer;var errMsg:String):boolean;
Function ConvertSo(SOID:Integer;AOwner:Tcomponent; DoProductallocation: TDoProductallocation ):Integer;

implementation

uses AppEnvironment, CommonDbLib, erpdbcomponents, sysutils, ProcessDataUtils,
  BusObjSales;

function  IsOkToconvert(SOID:Integer;var errMsg:String):boolean;
var
  QrySO:TERPQuery;
begin
  errMsg := '';
  REsult := False;

  QrySO := TempMyQuery;
  try
    QrySO.SQL.add('select S.saleId, S.QuoteStatus,S.Converted,s.IsInternalOrder , S.RepairID, S.IsLayby,  Count(SL.SaleLineid) ctr' +
      ' from tblSales S inner join tblSaleslines SL on s.SaleId = Sl.SaleId where S.SaleId = ' +inttostr(SOID)+
      ' group by S.SaleId' );
    QrySO.open;
    if  (Appenv.Companyprefs.StatustoMakeInvoice<> '') then
        if not (SameText(Appenv.Companyprefs.StatustoMakeInvoice ,QrySo.fieldbyname('QuoteStatus').asString)) then begin
          ErrMsg:= 'Sales Order #' + inttostr(SOID) +' has Status ' +Quotedstr(QrySo.fieldbyname('QuoteStatus').asString)+
                    ' and can be Converted to Invoice Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice)+'.';
          Exit;
        end;
    if QrySo.fieldbyname('converted').asBoolean then begin
       ErrMsg:= 'Sales Order #' + inttostr(SOID) +' is already converted and Cannot convert again.';
       Exit;
    end;
    if QrySo.fieldbyname('IsInternalOrder').asBoolean then begin
       ErrMsg:= 'Sales Order #' + inttostr(SOID) +' is an Internal Order and Cannot convert.';
       Exit;
    end;
    if QrySo.fieldbyname('IsLayby').asBoolean then begin
       ErrMsg:= 'Sales Order #' + inttostr(SOID) +' is a Layby record and Cannot convert.';
       Exit;
    end;
    if QrySo.fieldbyname('RepairID').asInteger <> 0 then begin
       ErrMsg:= 'Sales Order #' + inttostr(SOID) +' is a Repair Sales Order and Cannot convert.';
       Exit;
    end;
    if QrySo.fieldbyname('ctr').asInteger =0  then begin
       ErrMsg:= 'Sales Order #' + inttostr(SOID) +' has no lines.';
       Exit;
    end;
    if SaleContainsManufacturing(SOID , QrySo.connection) then begin
         ErrMsg:= 'Sales Order #' + inttostr(SOID) +' Can not convert to Invoice as this sale contains production items.';
         exit;
    end;
    Result := True;
  finally
    QrySO.ClosenFree;
  end;
end;


Function ConvertSo(SOID:Integer;AOwner:Tcomponent; DoProductallocation: TDoProductallocation ):Integer;
var
    SalesOrder:TSalesOrder;
    firstSOID:Integer;
begin
    result := 0;
    SalesOrder := TsalesOrder.CreateWithNewConn(AOwner);
    Try
      SalesOrder.Load(SOID);
      if SalesOrder is TSales then TSales(SalesOrder).InstantiateAllTrees; // load the trees to copy
      if SalesOrder.count =0 then exit; if Salesorder.Converted then exit;
      SalesOrder.Connection.BeginTransaction;
      SalesOrder.DoProductallocation := DoProductallocation;
      firstSOID := SalesOrder.GetBackOrderMainSOId;
      Result := SalesOrder.CopyToInvoice(FirstSOId) ;
      if Result =0 then
        SalesOrder.connection.RollbackTransaction
      else
        SalesOrder.connection.CommitTransaction;
    Finally
      FreeandNil(Salesorder);
    End;
end;

end.

