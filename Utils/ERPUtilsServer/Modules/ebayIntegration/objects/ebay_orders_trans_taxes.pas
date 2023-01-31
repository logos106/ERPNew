unit ebay_orders_trans_taxes;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ,ebay_orders_trans_taxes_taxdetails;


type
  Tebay_orders_trans_taxes = class(TeBayObjBase)
  private
    ftaxdetails :Tebay_orders_trans_taxes_taxdetails;
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    function getTotalTaxamount: Double;
    function getTotalTaxamountCurCode: String;
    procedure setTotalTaxamount(const Value: Double);
    procedure setTotalTaxamountCurCode(const Value: String);
    Function getTaxDetails :Tebay_orders_trans_taxes_taxdetails;

  public
    constructor  Create(AOwner: TComponent);                            override;
    Property TaxDetails :Tebay_orders_trans_taxes_taxdetails read getTaxDetails;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    Property TotalTaxamount : Double read getTotalTaxamount write setTotalTaxamount;
    Property TotalTaxamountCurCode :String read getTotalTaxamountCurCode write setTotalTaxamountCurCode;

  end;


implementation

uses sysutils;





  {Tebay_orders_trans_taxes}

constructor Tebay_orders_trans_taxes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_taxes';
end;


{Property Functions}
function  Tebay_orders_trans_taxes.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_taxes.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function Tebay_orders_trans_taxes.getTaxDetails: Tebay_orders_trans_taxes_taxdetails;
begin


  if (fTaxdetails = nil) then begin
    fTaxdetails:= Tebay_orders_trans_taxes_taxdetails.Create(self, 'tblebay_orders_trans_taxes_taxdetails',
                        ' OrderID = ' + inttostr(OrderID) +' and ' +
                        ' Orders_Trans_Id   = ' + inttostr(Orders_Trans_Id) +' and   ' +
                        ' Orders_Trans_Taxes_Id = ' + inttostr(ID));
  end;
  fTaxdetails.SQLWhere := ' OrderID = ' + inttostr(OrderID) +' and  ' +
                          ' Orders_Trans_Id   = ' + inttostr(Orders_Trans_Id) +' and   ' +
                          ' Orders_Trans_Taxes_Id = ' + inttostr(ID);
  fTaxdetails.Dataset;
  result:= fTaxdetails;

end;

function Tebay_orders_trans_taxes.getTotalTaxamount: Double;begin result := GetfieldValue('TotalTaxamount');end;
function Tebay_orders_trans_taxes.getTotalTaxamountCurCode: String;begin result := GetFieldValue('TotalTaxamountCurCode');end;
procedure Tebay_orders_trans_taxes.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_taxes.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_taxes.setTotalTaxamount(const Value: Double);begin SetfieldValue('TotalTaxamount' , Value);end;
procedure Tebay_orders_trans_taxes.setTotalTaxamountCurCode(const Value: String); begin SetFieldValue('TotalTaxamountCurCode' , Value); end;
initialization
  RegisterClass(Tebay_orders_trans_taxes);


end.
