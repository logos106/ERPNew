unit BusObjPayLeavesAUS;

interface

uses
  BusObjPaysLeave,Classes;
type
   TpayleavesAUS = class(Tpaysleave)
   private
   public

   end;
implementation

uses
  CommonLib;




initialization
RegisterClassOnce(TpayleavesAUS);
end.
