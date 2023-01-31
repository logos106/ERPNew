unit SalesXMLUtils;

interface

uses
  XMLIntf;

  procedure RemoveXMLInvoiceNonCustomerData(InvoiceNode: IXMLNode);
  function CustomerXMLInvoiceDoc(InvoiceDoc: IXMLDocument): IXMLDocument;

implementation

uses
  XMLHelperUtils, XMLDoc, SysUtils;

procedure RemoveXMLInvoiceNonCustomerData(InvoiceNode: IXMLNode);
var
  x: integer;
  lines, line: IXMLNode;
begin
  lines := GetNode(InvoiceNode,'Lines');
  if Assigned(Lines) then begin
    for x := 0 to Lines.ChildNodes.Count -1 do begin
      line := Lines.ChildNodes[x];
      DeleteNode(line,'linecost');
      DeleteNode(line,'linecostinc');
      DeleteNode(line,'suppliername');
      DeleteNode(line,'profit');
      DeleteNode(line,'profitpercent');
      DeleteNode(line,'profitinc');
      DeleteNode(line,'profitpercentinc');
      DeleteNode(line,'grossprofitpercentinc');
    end;
  end;

end;

function CustomerXMLInvoiceDoc(InvoiceDoc: IXMLDocument): IXMLDocument;
var
  n, n2: IXMLNode;
  x, y: integer;
begin
  result := TXMLDocument.Create(nil);
  result.XML.Assign(InvoiceDoc.XML);
  result.Active := true;
  for x := 0 to RootNode(result).ChildNodes.Count -1 do begin
    n := RootNode(result).ChildNodes[x];
    if SameText(n.NodeName,'Invoice') then begin
      RemoveXMLInvoiceNonCustomerData(n);
    end
    else begin
      for y := 0 to n.ChildNodes.Count -1 do begin
        n2 := n.ChildNodes[y];
        if SameText(n2.NodeName,'Invoice') then begin
          RemoveXMLInvoiceNonCustomerData(n2);
        end;
      end;
    end;
  end;
end;


end.
