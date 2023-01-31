unit BusObjPensionBase;
interface
uses
  BusObjBase,Classes;
type
   TPensionBase = class(TMSBusObj)
   private
   public
     procedure CalcContributions; //virtual;  //descendants  in BusObjUKNics and .... To Do
   end;
implementation

uses
  CommonLib;

procedure TPensionBase.CalcContributions; begin end;



initialization
RegisterClassOnce(TPensionBase);
end.
