unit BusObjEmpPaySettingsUK;

interface
uses
  BusObjEmployeePaySettings,Classes;
type
   TEmpPaySettingsUK = class(Temployeepaysettings)
   private

   public
     Constructor  Create(AOwner: TComponent);                             override;
     Destructor   Destroy;                                                override;     
   end;
implementation


constructor TEmpPaySettingsUK.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
end;

destructor TEmpPaySettingsUK.Destroy;
begin
   inherited;
end;


initialization
RegisterClass(TEmpPaySettingsUK);
end.

