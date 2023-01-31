unit XMLHelperUtils;

interface

uses
  XMLIntf, JsonObject;


  function GetNode(aNode: IXMLNode; aNodePath: string): IXMLNode;

  function NodeExists(aXMLNode: IXMLNode; aNodePath: string): boolean;

  function GetNodeVal(aXMLNode: IXMLNode; aNodePath: string): string; overload;
  function GetNodeVal(aXMLNode: IXMLNode): string; overload;
  function GetNodeVal(aXMLDoc: IXMLDocument; aNodePath: string): string; overload;

  procedure SetNodeVal(aXMLNode: IXMLNode; aNodePath, aValue: string; IsCDATA: boolean = false); overload;
  procedure SetNodeVal(aXMLDoc: IXMLDocument; aNodePath, aValue: string; IsCDATA: boolean = false); overload;

  procedure SetNodeCDATAVal(aXMLNode: IXMLNode; aNodePath, aValue: string); overload;
  procedure SetNodeCDATAVal(aXMLDoc: IXMLDocument; aNodePath, aValue: string); overload;

  function AttributeExists(aXMLNode: IXMLNode; aAttPath: string): boolean;
  function GetAttVal(aXMLNode: IXMLNode; aAttPath: string): string;
//  procedure SetNodeAttribute(aXMLNode: IXMLNode; aAttributeName, Value: string);
  function RootNode(xmlDoc: IXMLDocument): IXMLNode;

  procedure DeleteNode(aXMLNode: IXMLNode; aNodePath: string);

implementation

uses
  Types, StrUtils, sysutils, Variants;

function GetNode(aNode: IXMLNode; aNodePath: string): IXMLNode;
var
  StrArray: TStringDynArray;
  node: IXMLNode;
  x: integer;

  function FindNode(n: IXMLNode; aName: string): IXMLNode;
  var
    i: integer;
  begin
    result := nil;
    for i := 0 to n.ChildNodes.Count -1 do begin
      if SameText(n.ChildNodes[i].NodeName, aName) then begin
        result := n.ChildNodes[i];
        break;
      end;
    end;
  end;

begin
  result:= nil;
  if aNodePath = '' then exit;
  StrArray := SplitString(aNodePath,'.');
  node := aNode;
  for x := 0 to High(StrArray) do begin
    node := FindNode(node, StrArray[x]);
    if not Assigned(node) then
      exit;
  end;
  result:= node;
end;

function GetNodeVal(aXMLNode: IXMLNode; aNodePath: string): string;
var
  node: IXMLNode;
begin
  result := '';
  node := GetNode(aXMLNode, aNodePath);
  if Assigned(node) and (not VarIsNull(node.NodeValue)) then
    result := node.NodeValue;
end;

function GetNodeVal(aXMLNode: IXMLNode): string;
begin
  result := '';
  if Assigned(aXMLNode) and (not VarIsNull(aXMLNode.NodeValue)) then
    result := aXMLNode.NodeValue;
end;

function GetNodeVal(aXMLDoc: IXMLDocument; aNodePath: string): string;
begin
  result := GetNodeVal(RootNode(aXMLDoc), aNodePath);
end;

function NodeExists(aXMLNode: IXMLNode; aNodePath: string): boolean;
var
  StrArray: TStringDynArray;
  node: IXMLNode;
  x: integer;
begin
  result:= true;
  if aNodePath = '' then exit;
  StrArray := SplitString(aNodePath,'.');
  node := aXMLNode;
  for x := 0 to High(StrArray) do begin
    node := node.ChildNodes.FindNode(StrArray[x]);
    if not Assigned(node) then begin
      result := false;
      exit;
    end;
  end;
end;

function AttributeExists(aXMLNode: IXMLNode; aAttPath: string): boolean;
var
  StrArray: TStringDynArray;
  node: IXMLNode;
  x: integer;
begin
  result:= true;
  if aAttPath = '' then exit;
  StrArray := SplitString(aAttPath,'.');
  node:= aXMLNode;
  for x := 0 to High(StrArray)-1 do begin
    node := node.ChildNodes.FindNode(StrArray[x]);
    if not Assigned(node) then begin
      result := false;
      exit;
    end;
  end;
  result := Assigned(node.AttributeNodes.FindNode(StrArray[High(StrArray)]));
end;

function GetAttVal(aXMLNode: IXMLNode; aAttPath: string): string;
var
  StrArray: TStringDynArray;
  node: IXMLNode;
  AttName: string;
  s: string;
  x: integer;
begin
  result:= '';
  if aAttPath = '' then exit;
  StrArray := SplitString(aAttPath,'.');
  AttName := StrArray[High(StrArray)];
  if High(StrArray) > 0 then begin
    s:= '';
    for x := 0 to High(StrArray)-1 do begin
      if s <> '' then s := s + '.';
      s:= s + StrArray[x];
    end;
    node := GetNode(aXMLNode,s);
  end
  else
    node := aXMLNode;
  node := node.AttributeNodes.FindNode(AttName);
  if Assigned(node) and (not VarIsNull(node.NodeValue)) then
    result := node.NodeValue;
end;

function RootNode(xmlDoc: IXMLDocument): IXMLNode;
begin
  result := xmlDoc.DocumentElement;
  if xmlDoc.DocumentElement.ChildNodes.Count = 1 then
    result := xmlDoc.DocumentElement.ChildNodes[0];
end;


procedure SetNodeVal(aXMLNode: IXMLNode; aNodePath, aValue: string; IsCDATA: boolean = false);
var
  node: IXMLNode;
begin
  node := GetNode(aXMLNode, aNodePath);
  if Assigned(node) then begin
    if IsCDATA then begin
      if node.HasChildNodes then
        node.NodeValue := aValue
      else begin
        node.ChildNodes.Add(node.OwnerDocument.CreateNode('',ntCDATA));
        node.NodeValue := aValue;
      end;
    end
    else
      node.NodeValue := aValue;
  end;
end;

procedure SetNodeVal(aXMLDoc: IXMLDocument; aNodePath, aValue: string; IsCDATA: boolean = false);
begin
  SetNodeVal(RootNode(aXMLDoc), aNodePath, aValue, IsCDATA);
end;


procedure SetNodeCDATAVal(aXMLNode: IXMLNode; aNodePath, aValue: string);
begin
  SetNodeVal(aXMLNode, aNodePath, aValue, true);
end;

procedure SetNodeCDATAVal(aXMLDoc: IXMLDocument; aNodePath, aValue: string);
begin
  SetNodeCDATAVal(RootNode(aXMLDoc), aNodePath, aValue);
end;

procedure DeleteNode(aXMLNode: IXMLNode; aNodePath: string);
var
  n: IXMLNode;
begin
  n := GetNode(aXMLNode, aNodePath);
  if Assigned(n) then begin
    if Assigned(n.ParentNode) then
      n.ParentNode.ChildNodes.Remove(n)
    else
      n := nil;
  end;
end;


//procedure SetNodeAttribute(aXMLNode: IXMLNode; aAttributeName, Value: string);
//var
//  attNode: IXMLNode;
//begin
//  attNode := aXMLNode.AttributeNodes.FindNode(aAttributeName);
//  if not Assigned(attNode) then
//    attNode := aXMLNode.
//
//end;


end.
