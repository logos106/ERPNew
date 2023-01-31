unit BusObjPayPayRatesAUS;

interface
uses
  BusObjPaysPayRatesBASE,Classes,BusObjBase;
type
   TPayPayRatesAUS = class(Tpayspayrates)
   private
     fdTotalIncludedInSuper     :double;
     fdTotalCDEPAmount          :double;

     procedure CallBackTotalIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
     procedure CallbackCalcNonAccumLeave(const Sender: TBusObj; var Abort: Boolean);
     procedure CallbackCalcCDEP(const Sender: TBusObj; var Abort: Boolean);

   public
     property TotalIncludedInSuper:double read fdTotalIncludedInSuper write fdTotalIncludedInSuper;
     property TotalCDEP: double read fdTotalCDEPAmount;

     procedure RecalcAUS;
   end;
implementation
uses
  PayCommon, SysUtils, CommonLib;


procedure TPayPayRatesAUS.RecalcAUS;
begin
  Recalc; //Base

  fdTotalCDEPAmount := 0.00;
  fdTotalIncludedInSuper := 0.00;

  //Get Non accum leave
  self.Dataset.Filtered := False;
  Self.IterateRecords(CallbackCalcNonAccumLeave,False);

  //Get CDEP
  self.Dataset.Filter := GetBasedOnFilter(GetBasedOnID('CDEP Payment'));
  Self.Dataset.Filtered := True;
  self.IterateRecords(CallbackCalcCDEP,False);
  self.Dataset.Filtered := False;

  //Get total included in super
  Self.IterateRecords(CallBackTotalIncludedInSuper,False);
end;

procedure TPayPayRatesAUS.CallbackCalcCDEP(const Sender: TBusObj; var Abort: Boolean);
begin
  if GetPayTypeDescription(PayRateID)  = 'CDEP' then  fdTotalCDEPAmount := fdTotalCDEPAmount + LineTotal;
end;

procedure TPayPayRatesAUS.CallbackCalcNonAccumLeave(const Sender: TBusObj; var Abort: Boolean);
begin
  if GetPayTypeDescription(PayRateID)  = 'Pay without leave' then  fdTotalNonAccumLeaveHrs := fdTotalNonAccumLeaveHrs + Qty;
end;

procedure TPayPayRatesAUS.CallBackTotalIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
begin
  if SuperInc then fdTotalIncludedInSuper := fdTotalIncludedInSuper + LineTotal;
end;

initialization
  RegisterClassOnce(TPayPayRatesAUS);
end.
