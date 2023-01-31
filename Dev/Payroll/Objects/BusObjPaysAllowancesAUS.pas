unit BusObjPaysAllowancesAUS;

interface
uses
  BusObjPaysAllowances,Classes;
type
   TpaysallowancesAUS = class(Tpaysallowances)
   private
   public

   end;
implementation

uses
  CommonLib;




initialization
RegisterClassOnce(TpaysallowancesAUS);
end.
