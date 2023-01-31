unit ebay_orders_trans_taxes_totaltaxamount;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_trans_taxes_totaltaxamount = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Taxes_Id                       : Integer   ;
    function GetText                                        : Double    ;
    function GetcurrencyID                                  : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Taxes_Id                       (const Value: Integer   );
    procedure SetText                                        (const Value: Double    );
    procedure SetcurrencyID                                  (const Value: string    );
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Taxes_Id                        :Integer     read GetOrders_Trans_Taxes_Id                      write SetOrders_Trans_Taxes_Id                   ;
    property Text                                         :Double      read GetText                                       write SetText                                    ;
    property currencyID                                   :string      read GetcurrencyID                                 write SetcurrencyID                              ;
  end;


implementation



  {Tebay_orders_trans_taxes_totaltaxamount}

constructor Tebay_orders_trans_taxes_totaltaxamount.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_taxes_totaltaxamount';
end;


{Property Functions}
function  Tebay_orders_trans_taxes_totaltaxamount.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_taxes_totaltaxamount.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_taxes_totaltaxamount.GetOrders_Trans_Taxes_Id                   : Integer   ; begin Result := GetFieldValue('Orders_Trans_Taxes_Id');end;
function  Tebay_orders_trans_taxes_totaltaxamount.GetText                                    : Double    ; begin Result := GetFieldValue('Text');end;
function  Tebay_orders_trans_taxes_totaltaxamount.GetcurrencyID                              : string    ; begin Result := GetFieldValue('currencyID');end;
procedure Tebay_orders_trans_taxes_totaltaxamount.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_taxes_totaltaxamount.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_taxes_totaltaxamount.SetOrders_Trans_Taxes_Id                   (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Taxes_Id'                    , Value);end;
procedure Tebay_orders_trans_taxes_totaltaxamount.SetText                                    (const Value: Double    ); begin SetFieldValue('Text'                                     , Value);end;
procedure Tebay_orders_trans_taxes_totaltaxamount.SetcurrencyID                              (const Value: string    ); begin SetFieldValue('currencyID'                               , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_taxes_totaltaxamount);


end.
