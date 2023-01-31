unit utObjSale;

interface

uses
  utObjBase;

type
  Invoice = class(ObjBase)
  protected
    function GetSchema: SchemaBase; override;
  end;

  Invoice_Schema = class(SchemaBase)
  protected
    function GetDbFilterStr: string; override;
    function GetDbIdFieldName: string; override;
    function GetDbTableName: string; override;
  public
    constructor Create; override;
  end;

implementation

uses
  SysUtils, Classes;

var
  fInvoice_Schema: Invoice_Schema;

{ Invoice_Schema }

constructor Invoice_Schema.Create;
begin
  inherited;
  AddStringProp(  'DocumentNumber',        'InvoiceDocNumber',false, 'Optional Invoice of Document Number to identify this sale.');
  AddStringProp(  'ReceivableAccountName', 'Account',true,           'The GL Income Account for this sale');
  AddIntegerProp( 'ReceivableAccountID',   'AccountID',true,         'The GL Income Account ID for this sale');
  AddStringProp(  'CustomerName',          'CustomerName',true,      'Customer Identifier.');
  AddStringProp(  'CustomerDisplayName',   'ClientPrintName',true,   'Customers Display Name.');
  AddIntegerProp( 'CustomerID',            'ClientID',true,          'Customer ID');
  AddFloatProp(   'TotalSaleAmountInc',    'TotalAmountInc',false,   'Total of Invoice including tax');
end;

function Invoice_Schema.GetDbFilterStr: string;
begin
  result := 'IsInvoice = "T"';
end;

function Invoice_Schema.GetDbIdFieldName: string;
begin
  result := 'SaleId';
end;

function Invoice_Schema.GetDbTableName: string;
begin
  result := 'tblSales';
end;


{ Invoice }

function Invoice.GetSchema: SchemaBase;
begin
  if not Assigned(fInvoice_Schema) then
    fInvoice_Schema := Invoice_Schema.Create;
  result := fInvoice_Schema;
end;

initialization
  fInvoice_Schema := nil;
  RegisterClass(Invoice);
  RegisterClass(Invoice_Schema);

finalization
  FreeAndNil(fInvoice_Schema);

end.
