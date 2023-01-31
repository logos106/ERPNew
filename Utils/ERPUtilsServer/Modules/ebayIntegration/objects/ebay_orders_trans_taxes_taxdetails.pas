unit ebay_orders_trans_taxes_taxdetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_trans_taxes_taxdetails = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Taxes_Id                       : Integer   ;
    function GetImposition                                  : string    ;
    function GetTaxDescription                              : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Taxes_Id                       (const Value: Integer   );
    procedure SetImposition                                  (const Value: string    );
    procedure SetTaxDescription                              (const Value: string    );
    function gettaxonsubtotalamount: Double;
    function gettaxonsubtotalamountCurCode: String;
    procedure settaxonsubtotalamount(const Value: Double);
    procedure settaxonsubtotalamountCurCode(const Value: String);
    function getTaxAmount: Double;
    function getTaxAmountCurCode: String;
    procedure setTaxAmount(const Value: Double);
    procedure setTaxAmountCurCode(const Value: String);
    function getTaxOnShippingAmount: Double;
    function getTaxOnShippingAmountCurCode: String;
    procedure setTaxOnShippingAmount(const Value: Double);
    procedure setTaxOnShippingAmountCurCode(const Value: String);
    function getTaxOnHandlingAmount: Double;
    function getTaxOnHandlingAmountCurCode: String;
    procedure setTaxOnHandlingAmount(const Value: Double);
    procedure setTaxOnHandlingAmountCurCode(const Value: String);
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Taxes_Id                        :Integer     read GetOrders_Trans_Taxes_Id                      write SetOrders_Trans_Taxes_Id                   ;
    property Imposition                                   :string      read GetImposition                                 write SetImposition                              ;
    property TaxDescription                               :string      read GetTaxDescription                             write SetTaxDescription                          ;
    Property taxonsubtotalamount : Double read gettaxonsubtotalamount write settaxonsubtotalamount;
    Property taxonsubtotalamountCurCode :String read gettaxonsubtotalamountCurCode write settaxonsubtotalamountCurCode;
    Property TaxAmount : Double read getTaxAmount write setTaxAmount;
    Property TaxAmountCurCode :String read getTaxAmountCurCode write setTaxAmountCurCode;
    Property TaxOnShippingAmount : Double read getTaxOnShippingAmount write setTaxOnShippingAmount;
    Property TaxOnShippingAmountCurCode :String read getTaxOnShippingAmountCurCode write setTaxOnShippingAmountCurCode;
    Property TaxOnHandlingAmount : Double read getTaxOnHandlingAmount write setTaxOnHandlingAmount;
    Property TaxOnHandlingAmountCurCode :String read getTaxOnHandlingAmountCurCode write setTaxOnHandlingAmountCurCode;




  end;


implementation




  {Tebay_orders_trans_taxes_taxdetails}

constructor Tebay_orders_trans_taxes_taxdetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_taxes_taxdetails';
end;


{Property Functions}
function  Tebay_orders_trans_taxes_taxdetails.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_taxes_taxdetails.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_taxes_taxdetails.GetOrders_Trans_Taxes_Id                   : Integer   ; begin Result := GetFieldValue('Orders_Trans_Taxes_Id');end;
function  Tebay_orders_trans_taxes_taxdetails.GetImposition                              : string    ; begin Result := GetFieldValue('Imposition');end;
function  Tebay_orders_trans_taxes_taxdetails.GetTaxDescription                          : string    ; begin Result := GetFieldValue('TaxDescription');end;
procedure Tebay_orders_trans_taxes_taxdetails.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.SetOrders_Trans_Taxes_Id                   (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Taxes_Id'                    , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.SetImposition                              (const Value: string    ); begin SetFieldValue('Imposition'                               , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.SetTaxDescription                          (const Value: string    ); begin SetFieldValue('TaxDescription'                           , Value);end;
function Tebay_orders_trans_taxes_taxdetails.gettaxonsubtotalamount: Double;begin result := GetfieldValue('taxonsubtotalamount');end;
function Tebay_orders_trans_taxes_taxdetails.gettaxonsubtotalamountCurCode: String;begin result := GetFieldValue('taxonsubtotalamountCurCode');end;
procedure Tebay_orders_trans_taxes_taxdetails.settaxonsubtotalamount(const Value: Double);begin SetfieldValue('taxonsubtotalamount' , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.settaxonsubtotalamountCurCode(const Value: String); begin SetFieldValue('taxonsubtotalamountCurCode' , Value); end;
function Tebay_orders_trans_taxes_taxdetails.getTaxAmount: Double;begin result := GetfieldValue('TaxAmount');end;
function Tebay_orders_trans_taxes_taxdetails.getTaxAmountCurCode: String;begin result := GetFieldValue('TaxAmountCurCode');end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxAmount(const Value: Double);begin SetfieldValue('TaxAmount' , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxAmountCurCode(const Value: String); begin SetFieldValue('TaxAmountCurCode' , Value); end;
function Tebay_orders_trans_taxes_taxdetails.getTaxOnShippingAmount: Double;begin result := GetfieldValue('TaxOnShippingAmount');end;
function Tebay_orders_trans_taxes_taxdetails.getTaxOnShippingAmountCurCode: String;begin result := GetFieldValue('TaxOnShippingAmountCurCode');end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxOnShippingAmount(const Value: Double);begin SetfieldValue('TaxOnShippingAmount' , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxOnShippingAmountCurCode(const Value: String); begin SetFieldValue('TaxOnShippingAmountCurCode' , Value); end;
function Tebay_orders_trans_taxes_taxdetails.getTaxOnHandlingAmount: Double;begin result := GetfieldValue('TaxOnHandlingAmount');end;
function Tebay_orders_trans_taxes_taxdetails.getTaxOnHandlingAmountCurCode: String;begin result := GetFieldValue('TaxOnHandlingAmountCurCode');end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxOnHandlingAmount(const Value: Double);begin SetfieldValue('TaxOnHandlingAmount' , Value);end;
procedure Tebay_orders_trans_taxes_taxdetails.setTaxOnHandlingAmountCurCode(const Value: String); begin SetFieldValue('TaxOnHandlingAmountCurCode' , Value); end;


initialization
  RegisterClass(Tebay_orders_trans_taxes_taxdetails);


end.
