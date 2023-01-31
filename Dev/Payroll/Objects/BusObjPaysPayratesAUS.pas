unit BusObjPaysPayratesAUS;

interface
uses
  BusObjPaysPayratesBASE,Classes,BusObjBase;
type
   TPaysPayRatesAUS = class(Tpayspayrates)
   private
     fTotalCDEP:double;
     function GetTotalCDEP:double;
     procedure CallbackTotalCDEP(const Sender: TBusObj; var Abort: Boolean);

   public
     property TotalCDEP:double read GetTotalCDEP;
   end;
implementation

uses
  PayCommon, CommonLib;

function TPaysPayRatesAUS.GetTotalCDEP:double;
begin
  fTotalCDEP := 0;
  Self.IterateRecords(CallbackTotalCDEP);
  Result := fTotalCDEP;
end;

procedure TPaysPayRatesAUS.CallbackTotalCDEP(const Sender: TBusObj; var Abort: Boolean);
begin
  if GetPayRateType(TypeID) = 'CDEP'  then fTotalCDEP := fTotalCDEP + LineTotal;
end;

initialization
  RegisterClassOnce(TPaysPayRatesAUS);
end.
