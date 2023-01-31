unit HireLib;

interface

Function HireEquipAvailabilityCheckSQL(ActualHirefrom, ActualHireto, HireFrom, HireTo:TDateTime; ProductID:Integer; EquipmentID:Integer;HireLineID:Integer):string;

implementation

uses SysUtils, MySQLConst, LogLib;

Function HireEquipAvailabilityCheckSQL(ActualHirefrom, ActualHireto, HireFrom, HireTo:TDateTime; ProductID:Integer; EquipmentID:Integer;HireLineID:Integer):string;
const
  AF ='HL.ActualHireFrom';
  AT ='HL.ActualHireTo';
  F  ='HL.HireFrom';
  T  ='HL.HireTo';

var
  dtFrom , dtTo:TDateTime;

  Function FromSQL:String; begin REsult := Quotedstr(FormatdateTime(MysqlDateTimeFormat , dtFrom)); end;
  Function ToSQL  :String; begin REsult := Quotedstr(FormatdateTime(MysqlDateTimeFormat , dtTo  )); end;
begin

if (ActualHirefrom <> 0) and (ActualHireto<>0) then begin
    dtFrom := ActualHireFrom ;
    dtTo:= ActualHireTo;
  end else if (HireFrom <> 0) and (Hireto<> 0) then begin
    dtFrom := HireFrom ;
    dtTo:= HireTo;
  end else begin
    Exit;
  end;
        Result:='Select HL.HireLineID ,HL.EquipmentID ,HL.AssetProductId,  '+
                       ' if(ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 ,'+AF+','+F+') as DateFrom, '+
                       ' if(ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 ,'+AT+','+T+') as DateTo, '+
                       ' HL.hireQty from tblhirelines HL ';

        Result:=Result + ' where HL.HireLineID <> '+ inttostr(HireLineID)+
                         ' and ( (ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0) or (ifnull('+F+' ,0)<> 0 and ifnull('+T+',0)<> 0))';

        if ProductID      <> 0 then Result:=Result + ' and HL.AssetProductId = '+ inttostr(ProductID);
        if EquipmentId    <> 0 then Result:=Result + ' and HL.EquipmentId = '   + inttostr(EquipmentId);

        Result:=Result + ' and  (  '+  ' ((ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 and (ifnull('+AF+' ,0) <='+ FromSQL +' and ifnull('+AT+' ,0) >='+ ToSQL +'  )) or '+
                                       '  (ifnull('+AF+' ,0) = 0 OR  ifnull('+AT+',0) = 0 and (ifnull('+ F+' ,0) <='+ FromSQL +' and ifnull('+ T+' ,0) >='+ ToSQL +'  )) ) '+
                                '  OR  ' +
                                       ' ((ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 and (ifnull('+AF+' ,0) >='+ FromSQL +' and ifnull('+AT+' ,0) <='+ ToSQL +'  )) or '+
                                       '  (ifnull('+AF+' ,0) = 0 OR  ifnull('+AT+',0) = 0 and (ifnull('+ F+' ,0) >='+ FromSQL +' and ifnull('+ T+' ,0) <='+ ToSQL +'  )) ) '+
                                '  OR  ' +
                                       ' ((ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 and (ifnull('+AF+' ,0) <='+ FromSQL +' and ifnull('+AT+' ,0) >='+ FromSQL +'  )) or '+
                                       '  (ifnull('+AF+' ,0) = 0 OR  ifnull('+AT+',0) = 0 and (ifnull('+ F+' ,0) <='+ FromSQL +' and ifnull('+ T+' ,0) >='+ FromSQL +'  )) ) '+
                                '  OR  ' +
                                       ' ((ifnull('+AF+' ,0)<> 0 and ifnull('+AT+',0)<> 0 and (ifnull('+AF+' ,0) <='+ ToSQL +' and ifnull('+AT+' ,0) >='+ ToSQL +'  )) or '+
                                       '  (ifnull('+AF+' ,0) = 0 OR  ifnull('+AT+',0) = 0 and (ifnull('+ F+' ,0) <='+ ToSQL +' and ifnull('+ T+' ,0) >='+ ToSQL +'  )) ) '+
                                ') Order by DateFrom ';
        Result := ' Select HireLineID , EquipmentID , AssetProductId , DateFrom HireDate, "F" IntoStock, HireQty from ('+Result+') as Main Where DateFrom between '+ FromSQL +' and '+ TOSQL +
                  ' UNION ' +
                  ' Select HireLineID , EquipmentID , AssetProductId , DateTo HireDate, "T" IntoStock, HireQty from ('+Result+') as Main Where DateTo between '+ FromSQL +' and '+ TOSQL +
                  ' Order by HireDate ';
        cLog(Result);
end;
end.
