unit BusObjPayCommissionsUK;

interface
uses
  BusObjPayCommissionsBASE,Classes;
type
   TPayCommissionsUK = class(Tpayscommission)
   private
 //    fNICComponent:double;

  //   function GetNIC:double;
//     procedure SetNIC(Const Value:double);
   public
     Constructor  Create(AOwner: TComponent);                             override;
     Destructor   Destroy;                                                override;
//     property NICComponent:double read GetNIC write SetNIC;

   end;
implementation

//=======================Nic=====================================

constructor TPayCommissionsUK.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
end;

destructor TPayCommissionsUK.Destroy;
begin
   inherited;
end;

//Procedure TPayCommissionsUK.SetNIC(const Value:double);
//begin
//  fNICComponent := Value;
//end;

//function TPayCommissionsUK.GetNIC:double;
//begin
//  result := GetFloatField('NICComponent');
//end;



initialization
RegisterClass(TpaycommissionsUK);
end.
