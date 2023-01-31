unit InvoicesSQL;



interface

uses
   classes, SalesnPOSQL;

Type

   TInvoiceList = class(TSalesnPOList)
   Private
    fbIncludeSO: boolean;
   Protected
   Public
      constructor Create; Override;
      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
   Published
    Property IncludeSO: boolean read fbIncludeSO write fbIncludeSO;
   end;

implementation

uses UtilsLib;

constructor TInvoiceList.Create;
begin
  inherited;
  IncludeSO      := False;
end;

function TInvoiceList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
    Result := PopulateSalesnPOSQL(SQL, msg, 'tblsales',
                                            'tblsaleslines',
                                            'SaleID',
                                            'SaleDate',
                                            'IsInvoice' + iif(IncludeSO, ',IsSalesOrder', ''));
end;

initialization

   RegisterClass(TInvoiceList);

end.
