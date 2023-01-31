unit XMLRequestUtils;

interface

uses
  ALXMLDoc, Variants, XMLRequestConst;

  function FindAddChild(Const aNode: TALXMLNode; Const ChildName: string): TALXMLNode;
  function NodeAttStr(Const aNode: TALXMLNode; Const AttributeName: string): string;
  function SubNodeStr(Const aParentNode: TALXMLNode; Const SubNodeName: string): string;
  function AddResponceNode(const outBlock: TALXMLNode;
                         const requestNode: TALXMLNode;
                         const nodeResult: string = XMLResultNone;
                         const FailReason: string = '';
                         const GlobalRef: string = '';
                         const NodeDesc: string = ''): TALXMLNode;
  function FmtRespStr(const str: string): string;
  function CopyNode(fromNode, ParentNode: TALXMLNode): TALXMLNode;

implementation

uses
  FastFuncs;

function FindAddChild(Const aNode: TALXMLNode; Const ChildName: string): TALXMLNode;
begin
  result:= aNode.ChildNodes.FindNode(ChildName);
  if not Assigned(result) then
    result:= aNode.AddChild(ChildName);
end;


function NodeAttStr(Const aNode: TALXMLNode; Const AttributeName: string): string;
begin
  result:= '';
  if aNode.HasAttribute(AttributeName) and
    (not VarIsNull(aNode.Attributes[AttributeName])) then
    result:= aNode.Attributes[AttributeName];
end;

function SubNodeStr(Const aParentNode: TALXMLNode; Const SubNodeName: string): string;
var
  subNode: TALXMLNode;
begin
  result:= '';
  subNode:= aParentNode.ChildNodes.FindNode(SubNodeName);
  if Assigned(subNode) then
    result:= subNode.Text;
end;

function AddResponceNode(const outBlock: TALXMLNode;
                       const requestNode: TALXMLNode;
                       const nodeResult: string = XMLResultNone;
                       const FailReason: string = '';
                       const GlobalRef: string = '';
                       const NodeDesc: string = ''): TALXMLNode;
begin
  result:= outBlock.AddChild(XMLNodeResponce);
  if Assigned(requestNode) then begin
    if NodeAttStr(requestNode,XMLAttCommand) <> '' then
      result.Attributes[XMLAttCommand]:= NodeAttStr(requestNode,XMLAttCommand);
    if NodeAttStr(requestNode,XMLAttClientRef) <> '' then
      result.Attributes[XMLAttClientRef]:= NodeAttStr(requestNode,XMLAttClientRef);
    if NodeAttStr(requestNode,XMLAttDataObject) <> '' then
      result.Attributes[XMLAttDataObject]:= NodeAttStr(requestNode,XMLAttDataObject);
  end;
  result.Attributes[XMLAttResult]:= nodeResult;
  if GlobalRef <> '' then
    result.Attributes[XMLAttGlobalRef]:= GlobalRef;
  if NodeDesc <> '' then
    result.AddChild(XMLNodeDesc).Text:= NodeDesc;
end;

function FmtRespStr(const str: string): string;
begin
  result:= '"' + FastFuncs.AnsiStringReplace(FastFuncs.AnsiStringReplace(str,#13,'',[]),#10,'',[]) + '"';
end;

function CopyNode(fromNode, ParentNode: TALXMLNode): TALXMLNode;
var
  x: integer;
  s: string;
begin
  result:= ParentNode.AddChild(fromNode.NodeName);
  for x:= 0 to fromNode.AttributeNodes.Count -1 do begin
    s:= fromNode.AttributeNodes[x].NodeName;
    if s <> '' then
      result.Attributes[s]:= fromNode.Attributes[s];

  end;
end;

end.
