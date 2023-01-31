unit utSynchItemList;

interface

uses
  Classes;

type
  TSynchItemList = class(TObject)
  public
    class procedure GetDownSynchList(List: TStrings);
    class procedure GetUpSynchList(List: TStrings);
  end;

implementation

{ TSynchItemList }

class procedure TSynchItemList.GetDownSynchList(List: TStrings);
begin
  { NOTE: these are case sensitive and must match exactly the object name in the tablet! }

  List.Add('TColumnHeadings');
  List.Add('TUser');
  List.Add('TERPForm');
  List.Add('TEmployeeFormAccess');
  List.Add('TProduct');
  List.Add('TUnitOfMeasure');
  List.Add('TDeptClass');
  List.Add('TProductClass');
  List.Add('TProductClassQuantity');
  List.Add('TProductBin');
  List.Add('TProductPicture');
  List.Add('TProductBarcode');
  List.Add('TEquipment');
//  List.Add('TStockAdjustEntry');
  List.Add('TAccountType');
  List.Add('TAccount');
  List.Add('TERPPreference');
  List.Add('TERPAccountPref');
  List.Add('TTerms');
  List.Add('TTaxCode');
  List.Add('TRegionalOptions');
  List.Add('TSalesCategory');
  List.Add('TLeadStatusType');
  List.Add('TShippingMethod');
  List.Add('TCustomer');
  List.Add('TQuote');
  List.Add('TSalesOrder');
  List.Add('TInvoice');
  List.Add('TBusObjPrintDoc');
  List.Add('TDeletedItem');
  List.Add('TPQAFlat');
  List.Add('TPQADetailsFlat');
  List.Add('TPQASNLastTransDate');
end;

class procedure TSynchItemList.GetUpSynchList(List: TStrings);
begin
  { NOTE: these are case sensitive and must match exactly the object name in the tablet! }
  List.Add('TStockAdjustEntry');
  List.Add('TQuote');
  List.Add('TSalesOrder');
  List.Add('TInvoice');
end;

end.
