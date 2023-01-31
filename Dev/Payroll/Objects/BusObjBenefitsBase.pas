unit BusObjBenefitsBase;

interface
uses
  BusObjBase,Classes;
type
   TBenefitsBase = class(TMSBusObj)
   private
   Protected
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean; Override;
    Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean; Override;
   public
   //  Function Calc--  :double; virtual;
     procedure CalcContributions;
     procedure ReCalc; virtual;
     procedure PostToAccounts; virtual;
     procedure UnPostToAccounts; virtual;
   end;
implementation

uses
  CommonLib;

procedure TBenefitsBase.ReCalc; begin end;
procedure TBenefitsBase.CalcContributions; begin end;
procedure TBenefitsBase.PostToAccounts; begin end;
procedure TBenefitsBase.UnPostToAccounts; begin end;
Function  TBenefitsBase.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;
Function  TBenefitsBase.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

initialization
RegisterClassOnce(TBenefitsBase);
end.
