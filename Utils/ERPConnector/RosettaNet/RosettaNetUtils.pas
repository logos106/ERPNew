unit RosettaNetUtils;

interface

uses
  XMLIntf;


{ Purchase Order }
{ See: RosettaNetConst.GlobalPartnerClassificationCode }
function GetProductIdentifier(aProdLineItemNode: IXMLNode; aTypeCode: string): string;
function GetShopperProductIdentifier(aProdLineItemNode: IXMLNode): string;
function GetRetailerProductIdentifier(aProdLineItemNode: IXMLNode): string;

implementation

uses
  SysUtils, XMLHelperUtils;

function GetProductIdentifier(aProdLineItemNode: IXMLNode; aTypeCode: string): string;
var
  x: integer;
  ProdId: IXMLNode;
begin
  result := '';
  ProdId := GetNode(aProdLineItemNode, 'ProductIdentification');
  if not Assigned(ProdId) then exit;

  for x := 0 to  ProdId.ChildNodes.Count -1 do begin
    if SameText(ProdId.ChildNodes[x].NodeName, 'PartnerProductIdentification') then begin
      if SameText(GetNodeVal(ProdId.ChildNodes[x], 'GlobalPartnerClassificationCode'),aTypeCode) then begin
        result := GetNodeVal(ProdId.ChildNodes[x], 'ProprietaryProductIdentifier');
        exit;
      end;
    end;
  end;
end;

function GetShopperProductIdentifier(aProdLineItemNode: IXMLNode): string;
begin
  result := GetProductIdentifier(aProdLineItemNode, 'Shopper');
end;

function GetRetailerProductIdentifier(aProdLineItemNode: IXMLNode): string;
begin
  result := GetProductIdentifier(aProdLineItemNode, 'Retailer');
end;

end.
