unit eBay_Orders_CheckoutStatus;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_checkoutstatus = class(TeBayObjBase)
  private
    function GetOrderID                                : Integer    ;
    function GeteBayPaymentStatus                      : string    ;
    function GetPaymentMismatch_MismatchType           : string    ;
    function GetPaymentMismatch_AmountcurrencyID       : string    ;
    function GetMismatchType                           : string    ;
    function GetMismatchAmountCurency                  : string    ;
    function GetLastModifiedTime                       : TDateTime ;
    Function GetPaymentMismatch_Amount                 : double;
    function GetPaymentMismatch_ActionRequiredBy       : TDateTime ;
    function GetMismatchTypeActionRequiredBy           : TDateTime ;
    function GetPaymentMethod                          : string    ;
    function GetStatus                                 : string    ;
    function GetIntegratedMerchantCreditCardEnabled    : Boolean ;
    function getMismatchAmount :Double;
    procedure SetOrderID                                (const Value: Integer    );
    procedure SeteBayPaymentStatus                      (const Value: string    );
    procedure SetPaymentMismatch_MismatchType           (const Value: string    );
    procedure SetPaymentMismatch_AmountcurrencyID       (const Value: string    );
    procedure SetMismatchType                           (const Value: string    );
    procedure SetMismatchAmountCurency                  (const Value: string    );
    procedure SetLastModifiedTime                       (const Value: TDateTime );
    Procedure SetPaymentMismatch_Amount                 (const Value:Double);
    procedure SetPaymentMismatch_ActionRequiredBy       (const Value: TDateTime );
    procedure SetMismatchTypeActionRequiredBy           (const Value: TDateTime );
    procedure SetPaymentMethod                          (const Value: string    );
    procedure SetStatus                                 (const Value: string    );
    procedure SetIntegratedMerchantCreditCardEnabled    (const Value: Boolean );
    Procedure setMismatchAmount (const Value:Double);
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                  :Integer     read GetOrderID                              write SetOrderID                            ;
    property eBayPaymentStatus                        :string      read GeteBayPaymentStatus                    write SeteBayPaymentStatus                  ;
    property PaymentMismatch_MismatchType             :string      read GetPaymentMismatch_MismatchType         write SetPaymentMismatch_MismatchType       ;
    property PaymentMismatch_AmountcurrencyID         :string      read GetPaymentMismatch_AmountcurrencyID     write SetPaymentMismatch_AmountcurrencyID                  ;
    property MismatchType                             :string      read GetMismatchType                         write SetMismatchType                  ;
    property MismatchAmountCurency                    :string      read GetMismatchAmountCurency                write SetMismatchAmountCurency                  ;
    property LastModifiedTime                         :TDateTime   read GetLastModifiedTime                     write SetLastModifiedTime                   ;
    Property PaymentMismatch_Amount                   :double      read getPaymentMismatch_Amount               write setPaymentMismatch_Amount;
    property PaymentMismatch_ActionRequiredBy         :TDateTime   read GetPaymentMismatch_ActionRequiredBy     write SetPaymentMismatch_ActionRequiredBy   ;
    property MismatchTypeActionRequiredBy             :TDateTime   read GetMismatchTypeActionRequiredBy         write SetMismatchTypeActionRequiredBy                   ;
    property PaymentMethod                            :string      read GetPaymentMethod                        write SetPaymentMethod                      ;
    property Status                                   :string      read GetStatus                               write SetStatus                             ;
    property IntegratedMerchantCreditCardEnabled      :Boolean     read GetIntegratedMerchantCreditCardEnabled  write SetIntegratedMerchantCreditCardEnabled;
    Property MismatchAmount                           :double      read getMismatchAmount                       write setMismatchAmount;


  end;


implementation





  {Tebay_orders_checkoutstatus}

constructor Tebay_orders_checkoutstatus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_checkoutstatus';
end;


{Property Functions}
function  Tebay_orders_checkoutstatus.GetOrderID                            : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_checkoutstatus.GeteBayPaymentStatus                  : string    ; begin Result := GetFieldValue('eBayPaymentStatus');end;
function  Tebay_orders_checkoutstatus.GetPaymentMismatch_MismatchType       : string    ; begin Result := GetFieldValue('PaymentMismatch_MismatchType');end;
function  Tebay_orders_checkoutstatus.GetPaymentMismatch_AmountcurrencyID   : string    ; begin Result := GetFieldValue('PaymentMismatch_AmountcurrencyID');end;
function  Tebay_orders_checkoutstatus.GetMismatchType                       : string    ; begin Result := GetFieldValue('MismatchType');end;
function  Tebay_orders_checkoutstatus.GetMismatchAmountCurency              : string    ; begin Result := GetFieldValue('MismatchAmountCurency');end;
function  Tebay_orders_checkoutstatus.GetLastModifiedTime                   : TDateTime ; begin Result := GetFieldValue('LastModifiedTime');end;
Function Tebay_orders_checkoutstatus.getPaymentMismatch_Amount              : Double    ; begin Result := GetFieldValue('PaymentMismatch_Amount');end;
function  Tebay_orders_checkoutstatus.GetPaymentMismatch_ActionRequiredBy   : TDateTime ; begin Result := GetFieldValue('PaymentMismatch_ActionRequiredBy');end;
function  Tebay_orders_checkoutstatus.GetMismatchTypeActionRequiredBy       : TDateTime ; begin Result := GetFieldValue('MismatchTypeActionRequiredBy');end;
function  Tebay_orders_checkoutstatus.GetPaymentMethod                      : string    ; begin Result := GetFieldValue('PaymentMethod');end;
function  Tebay_orders_checkoutstatus.GetStatus                             : string    ; begin Result := GetFieldValue('Status');end;
function  Tebay_orders_checkoutstatus.GetIntegratedMerchantCreditCardEnabled: Boolean   ; begin Result := GetFieldValue('IntegratedMerchantCreditCardEnabled');end;
function  Tebay_orders_checkoutstatus.getMismatchAmount                     : double    ; begin result := GetFieldValue('MismatchAmount');end;
procedure Tebay_orders_checkoutstatus.SetOrderID                            (const Value: Integer   ); begin SetFieldValue('OrderID'                              , Value);end;
procedure Tebay_orders_checkoutstatus.SeteBayPaymentStatus                  (const Value: string    ); begin SetFieldValue('eBayPaymentStatus'                     , Value);end;
procedure Tebay_orders_checkoutstatus.SetPaymentMismatch_MismatchType       (const Value: string    ); begin SetFieldValue('PaymentMismatch_MismatchType'          , Value);end;
procedure Tebay_orders_checkoutstatus.SetPaymentMismatch_AmountcurrencyID   (const Value: string    ); begin SetFieldValue('PaymentMismatch_AmountcurrencyID'      , Value);end;
procedure Tebay_orders_checkoutstatus.SetMismatchType                       (const Value: string    ); begin SetFieldValue('MismatchType'                          , Value);end;
procedure Tebay_orders_checkoutstatus.SetMismatchAmountCurency              (const Value: string    ); begin SetFieldValue('MismatchAmountCurency'                 , Value);end;
procedure Tebay_orders_checkoutstatus.SetLastModifiedTime                   (const Value: TDateTime ); begin SetFieldValue('LastModifiedTime'                    , Value);end;
procedure Tebay_orders_checkoutstatus.SetPaymentMismatch_Amount             (const Value: double    ); begin SetFieldValue('PaymentMismatch_Amount'               , Value);end;
procedure Tebay_orders_checkoutstatus.SetPaymentMismatch_ActionRequiredBy   (const Value: TDateTime ); begin SetFieldValue('PaymentMismatch_ActionRequiredBy'    , Value);end;
procedure Tebay_orders_checkoutstatus.SetMismatchTypeActionRequiredBy       (const Value: TDateTime ); begin SetFieldValue('MismatchTypeActionRequiredBy'        , Value);end;
procedure Tebay_orders_checkoutstatus.SetPaymentMethod                      (const Value: string    ); begin SetFieldValue('PaymentMethod'                         , Value);end;
procedure Tebay_orders_checkoutstatus.SetStatus                             (const Value: string    ); begin SetFieldValue('Status'                                , Value);end;
procedure Tebay_orders_checkoutstatus.SetIntegratedMerchantCreditCardEnabled(const Value: boolean   ); begin SetFieldValue('IntegratedMerchantCreditCardEnabled'   , Value);end;
Procedure Tebay_orders_checkoutstatus.setMismatchAmount                     (Const Value:double     ); begin SetFieldValue('MismatchAmount'                         , value); end;

initialization
  RegisterClass(Tebay_orders_checkoutstatus);


end.
