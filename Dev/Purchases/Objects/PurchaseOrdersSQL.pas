unit PurchaseOrdersSQL;



interface

uses
   classes, SalesnPOSQL;

Type
   TPurchaseOrderList = class(TSalesnPOList)
     Private
     Protected
     Public
        function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
     Published
   end;



implementation


function TPurchaseOrderList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := PopulateSalesnPOSQL(SQL, msg, 'tblpurchaseorders',
                                          'tblpurchaselines',
                                          'PurchaseOrderID',
                                          'OrderDate',
                                          'IsPO');
end;

initialization

   RegisterClass(TPurchaseOrderList);

end.
