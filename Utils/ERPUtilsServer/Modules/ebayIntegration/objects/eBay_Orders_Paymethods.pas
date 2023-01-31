unit eBay_Orders_Paymethods;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes,  eBayBaseObj ;


type
  Tebay_orders_paymentmethods = class(TeBayObjBase)
  private
    //function GetOrderID                                : Integer    ;
    function GetPaymentMethods                         : string    ;
    //procedure SetOrderID                                (const Value: Integer    );
    procedure SetPaymentMethods                         (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    //property OrderID                                 :Integer      read GetOrderID                               write SetOrderID                            ;
    property PaymentMethods                          :string      read GetPaymentMethods                        write SetPaymentMethods                     ;
  end;


implementation


  {Tebay_orders_paymentmethods}

constructor Tebay_orders_paymentmethods.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_paymentmethods';
end;



{Property Functions}
//function  Tebay_orders_paymentmethods.GetOrderID                            : Integer    ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_paymentmethods.GetPaymentMethods                     : string    ; begin Result := GetFieldValue('PaymentMethods');end;
//procedure Tebay_orders_paymentmethods.SetOrderID                            (const Value: Integer    ); begin SetFieldValue('OrderID'                             , Value);end;
procedure Tebay_orders_paymentmethods.SetPaymentMethods                     (const Value: string    ); begin SetFieldValue('PaymentMethods'                      , Value);end;


initialization
  RegisterClass(Tebay_orders_paymentmethods);


end.
