unit Walmart_Lib;

interface

function DatetoValue  (Const Value:TDatetime):String;
Function InttoValue   (const Value:Integer  ):string;
Function DoubletoValue(const Value:double   ):string;


Function DateValue  (Const Value: String): TDatetime;
Function Intvalue   (Const Value: String): Integer  ;
Function Doublevalue(Const Value: String): Double   ;

function  ServiceTypetoWalmartmethodCode(Provider:Integer; Servicetype:Integer):string;



implementation

uses sysutils, DateTimeUtils , ShipIntegrationTypes, DbSharedObjectsObj,
  ERPdbComponents, CommonDbLib;
function DatetoValue  (Const Value:TDatetime):String; begin Result := ''; if Value =0 then exit;     result :=  DateTimeToISO8601(LocalToUTC(Value)); (*FormatdateTime('yyyy-mm-ddThh:nn:ss:zzzz',Value); *) end;
Function InttoValue   (const Value:Integer  ):string; begin Result := inttostr  (Value);  end;
Function DoubletoValue(const Value:double   ):string; begin Result := floattostr(Value);  end;

Function DateValue  (Const Value: String): TDatetime; begin Result := 0; try Result := ISO8601ToDateTime (Value); Except { kill exception if date is not correct - which shouldn't happen } end;end;
Function Intvalue   (Const Value: String): Integer  ; begin Result := 0; try Result := strToint  (Value); Except { kill exception if date is not correct - which shouldn't happen } end;end;
Function Doublevalue(Const Value: String): Double   ; begin Result := 0; try Result := strToFloat(Value); Except { kill exception if date is not correct - which shouldn't happen } end;end;

function  ServiceTypetoWalmartmethodCode(Provider:Integer; Servicetype:Integer):string;
var
  qry: TERPQuery;
  aArray :Array of String;
  ctr:Integer;
begin
  result := '';
  try
    SetLength(aArray , 0);
    for ctr := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
      if (intToPackageProvider(Provider) in ShipServiceTypeList[ctr].Providers) then begin
        SetLength(aArray , length(aArray)+1);
        aArray[high(aArray)]:=  ShipServiceTypeList[ctr].Name;
      end;
    end;

    if high(aArray)>= Servicetype then result :=aArray[Servicetype];
(*  if Sametext(result,'FedEx Standard Overnight') Or
       Sametext(result,'UPS Standard') Or
       Sametext(result,'UPS Today Standard') Or
       Sametext(result,'USPS Standard Mail') Or
       Sametext(result,'Unspecified') then result := 'Standard'
    else if Sametext(result,'FedEx Express Saver') Or
       Sametext(result,'UPS Express') Or
       Sametext(result,'UPS Worldwide Express') Or
       Sametext(result,'UPS Express Early AM') Or
       Sametext(result,'UPS Worldwide Express Plus') Or
       Sametext(result,'UPS Express Plus') Or
       Sametext(result,'UPS Today Express') Or
       Sametext(result,'UPS Today Express Saver') Or
       Sametext(result,'UPS Worldwide Express Freight') Or
       Sametext(result,'USPS Express') Or
       Sametext(result,'USPS Global Express') Or
       Sametext(result,'USPS Express Mail International') then Result := 'Express'
    else if Sametext(result,'FedEx 1 Day Freight') Or
       Sametext(result,'UPS Next Day Air') Or
       Sametext(result,'UPS Next Day Air Saver') Or
       Sametext(result,'UPS Next Day Air Early AM') Or
       Sametext(result,'UPS Today Courrier') Or
       Sametext(result,'UPS Today Inter City') Or
       Sametext(result,'FedEx Priority Overnight') Or
       Sametext(result,'FedEx First Overnight') then Result := 'Oneday'
    else if result <> '' then Result := 'Freight';*)
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.sql.text := 'Select WalmartMethodcode from tblwalmartshippingmethods where name = ' + quotedstr(result);
      Qry.open;
      result := Qry.fieldbyname('WalmartMethodcode').asString;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
         if Sametext(result,'Standard') then
    else if Sametext(result,'Express') then
    else if Sametext(result,'Oneday') then
    else if Sametext(result,'Freight') then
    else Result := 'Standard';
  end;
end;

end.
