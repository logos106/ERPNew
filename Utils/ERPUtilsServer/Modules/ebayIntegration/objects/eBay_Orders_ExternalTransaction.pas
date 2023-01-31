unit eBay_Orders_ExternalTransaction;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_externaltransaction = class(TeBayObjBase)
  private
    function GetOrderID                                : Integer    ;
    function GetExternalTransactionID                  : string    ;
    function GetExternalTransactionStatus              : string    ;
    function GetFeeOrCreditAmountCurcode              : string    ;
    function GetFeeOrCreditAmount              : Double;
    function GetPaymentOrRefundAmountCurcode              : string    ;
    function GetPaymentOrRefundAmount              : Double;
    function getExternalTransactionTime                : TdateTime;
    procedure SetOrderID                                (const Value: Integer    );
    procedure SetExternalTransactionID                  (const Value: string    );
    procedure SetExternalTransactionStatus              (const Value: string    );
    procedure SetFeeOrCreditAmountCurcode              (const Value: string    );
    procedure SetFeeOrCreditAmount              (const Value: Double);
    procedure SetPaymentOrRefundAmountCurcode              (const Value: string    );
    procedure SetPaymentOrRefundAmount              (const Value: Double);
    Procedure SetExternalTransactionTime                (const Value:TDateTime);
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                 :Integer      read GetOrderID                               write SetOrderID                            ;
    property ExternalTransactionID                   :string      read GetExternalTransactionID                 write SetExternalTransactionID              ;
    property ExternalTransactionStatus               :string      read GetExternalTransactionStatus             write SetExternalTransactionStatus          ;
    property FeeOrCreditAmountCurcode               :string      read GetFeeOrCreditAmountCurcode             write SetFeeOrCreditAmountCurcode          ;
    property FeeOrCreditAmount               :Double      read GetFeeOrCreditAmount             write SetFeeOrCreditAmount          ;
    property PaymentOrRefundAmountCurcode               :string      read GetPaymentOrRefundAmountCurcode             write SetPaymentOrRefundAmountCurcode          ;
    property PaymentOrRefundAmount               :Double      read GetPaymentOrRefundAmount             write SetPaymentOrRefundAmount          ;
    Property ExternalTransactionTime                 :TDateTime   read getExternalTransactionTime               write setExternalTransactionTime;
  end;


implementation


  {Tebay_orders_externaltransaction}

constructor Tebay_orders_externaltransaction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename :='tblebay_orders_externaltransaction';
end;

{Property Functions}
function  Tebay_orders_externaltransaction.GetOrderID                            : Integer    ; begin Result := GetfieldValue('OrderID');end;
function  Tebay_orders_externaltransaction.GetExternalTransactionID              : string    ; begin Result := GetfieldValue('ExternalTransactionID');end;
function  Tebay_orders_externaltransaction.GetExternalTransactionStatus          : string    ; begin Result := GetfieldValue('ExternalTransactionStatus');end;
function  Tebay_orders_externaltransaction.GetFeeOrCreditAmountCurcode          : string    ; begin Result := GetfieldValue('FeeOrCreditAmountCurcode');end;
function  Tebay_orders_externaltransaction.GetFeeOrCreditAmount          : Double; begin Result := GetfieldValue('FeeOrCreditAmount');end;
function  Tebay_orders_externaltransaction.GetPaymentOrRefundAmountCurcode          : string    ; begin Result := GetfieldValue('PaymentOrRefundAmountCurcode');end;
function  Tebay_orders_externaltransaction.GetPaymentOrRefundAmount          : Double; begin Result := GetfieldValue('PaymentOrRefundAmount');end;
function  Tebay_orders_externaltransaction.GetExternalTransactionTime            : TDateTime; begin Result := GetfieldValue('ExternalTransactionTime');end;

procedure Tebay_orders_externaltransaction.SetOrderID                            (const Value: Integer    ); begin SetfieldValue('OrderID'                             , Value);end;
procedure Tebay_orders_externaltransaction.SetExternalTransactionID              (const Value: string    ); begin SetfieldValue('ExternalTransactionID'               , Value);end;
procedure Tebay_orders_externaltransaction.SetExternalTransactionStatus          (const Value: string    ); begin SetfieldValue('ExternalTransactionStatus'           , Value);end;
procedure Tebay_orders_externaltransaction.SetFeeOrCreditAmountCurcode          (const Value: string    ); begin SetfieldValue('FeeOrCreditAmountCurcode'           , Value);end;
procedure Tebay_orders_externaltransaction.SetFeeOrCreditAmount          (const Value: double    ); begin SetfieldValue('FeeOrCreditAmount'           , Value);end;
procedure Tebay_orders_externaltransaction.SetPaymentOrRefundAmountCurcode          (const Value: string    ); begin SetfieldValue('PaymentOrRefundAmountCurcode'           , Value);end;
procedure Tebay_orders_externaltransaction.SetPaymentOrRefundAmount          (const Value: double    ); begin SetfieldValue('PaymentOrRefundAmount'           , Value);end;
procedure Tebay_orders_externaltransaction.SetExternalTransactionTime          (const Value: TdateTime    ); begin SetfieldValue('ExternalTransactionTime'           , Value);end;


initialization
  RegisterClass(Tebay_orders_externaltransaction);


end.
