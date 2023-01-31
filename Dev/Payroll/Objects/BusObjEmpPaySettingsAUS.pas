unit BusObjEmpPaySettingsAUS;

interface
uses
  BusObjEmployeePaySettings,Classes;
type
   TEmpPaySettingsAUS = class(Temployeepaysettings)
   private

   public
     Constructor  Create(AOwner: TComponent);                             override;
     Destructor   Destroy;                                                override;
   end;
implementation

uses
  CommonLib;


constructor TEmpPaySettingsAUS.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
end;

destructor TEmpPaySettingsAUS.Destroy;
begin
   inherited;
end;


initialization
RegisterClassOnce(TEmpPaySettingsAUS);

end.
