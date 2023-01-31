unit DataTreeBaseObj;

interface

uses Classes;

type

  TDataTreeNodeBase = class;
  TDataTreeNodeEvent    = procedure(Sender: TDataTreeNodeBase) of object;
  TOnNodeChange         = TDataTreeNodeEvent;
  TOnBeforeNodeGetValue = TDataTreeNodeEvent;

  { return < 0 if node1 is less than node2,
      0 if they are equal and
      > 0 if node1 is greater than node2 }
  TDataTreeNodeSortCompare = function (node1, node2: TDataTreeNodeBase): integer;

  TDataTreeNodeBase     = class(TObject)
  private
    ChildNodes: TList;
    fNodeName: string;
    fValue: string;
    fIsCData: boolean;
    fParent: TDataTreeNodeBase;
    fDirty: boolean;
    fOnNodeChange: TDataTreeNodeEvent;
    fOnBeforeNodeGetValue: TDataTreeNodeEvent;
    IsLoading: boolean;
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetAsString: string;
    function GetCount: integer;
    function GetItemByName(const NamePath: string): TDataTreeNodeBase;
    function GetItems(const Index: integer): TDataTreeNodeBase;
    function GetNodeName: string;
    function GetValue: string;
    function GetXML: string;
    function GetRawXML: string;
    procedure SetNodeName(const aValue: string);
    procedure SetValue(const aValue: string);
    procedure SetXML(const aValue: string);
    function GetParent: TDataTreeNodeBase;
    function GetNodePath: string;
    function GetRootNode: TDataTreeNodeBase;
    procedure SetAsBoolean(const aValue: boolean);
    procedure SetAsDateTime(const aValue: TDateTime);
    procedure SetAsFloat(const aValue: double);
    procedure SetAsInteger(const aValue: integer);
    procedure SetAsString(const aValue: string);
    function GetIndex: integer;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
    function GetCData: string;
    procedure SetCData(const aValue: string);
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Items[const Index: integer]: TDataTreeNodeBase read GetItems;
    property ItemByName[const NamePath: string]: TDataTreeNodeBase read GetItemByName; default;
    property Value: string read GetValue write SetValue;
    property NodeName: string read GetNodeName write SetNodeName;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property RawXML: string read GetRawXML;
    property XML: string read GetXML write SetXML;
    property Count: integer read GetCount;
    function AddNode(const NodeName: string): TDataTreeNodeBase;
    function InsertNode(const NodeName: string; const Position: integer): TDataTreeNodeBase;
    property Parent: TDataTreeNodeBase read GetParent;
    property NodePath: string read GetNodePath;
    property RootNode: TDataTreeNodeBase read GetRootNode;
    procedure SaveToFile(const aFileName: string);
    procedure LoadFromFile(const aFileName: string);
    function FindItemByName(const NamePath: string; const CreateNodes: boolean = false): TDataTreeNodeBase;
    function Exists(const NamePath: string): boolean;
    procedure Clear;
    procedure Delete(const Index: integer);
    procedure DeleteChildren;
    procedure DeleteByName(const NamePath: string);
    property Index: integer read GetIndex;
    property OnNodeChange: TDataTreeNodeEvent read fOnNodeChange write fOnNodeChange;
    property OnBeforeNodeGetValue: TDataTreeNodeEvent read fOnBeforeNodeGetValue write fOnBeforeNodeGetValue;
    property Dirty: boolean read GetDirty write SetDirty;
    procedure Sort(CompareFunc: TDataTreeNodeSortCompare; Ascending: boolean = true);
    property IsCData: boolean read fIsCData write fIsCData;
    property CData: string read GetCData write SetCData;
  end;

  TDataTreeBase = class(TDataTreeNodeBase)
  private
  protected
  public
  end;

  function StrToXMLNodeName(const aString: string): string;
  function XMLNodeNameToStr(const aNodeName: string): string;

implementation

uses
  SysUtils, {LibXmlParser,} XMLFuncLib, Dialogs, Types, strUtils, XMLIntf, XMLDoc, variants;

const
  SepChar = '.';

function StrToXMLNodeName(const aString: string): string;
begin
  Result := XMLFuncLib.ReplaceNonAlphaNumeric(aString);
end;

function XMLNodeNameToStr(const aNodeName: string): string;
begin
  Result := XMLFuncLib.ReinstateNonAlphaNumeric(aNodeName);
end;

{ TDataTreeNode }

constructor TDataTreeNodeBase.Create;
begin
  Inherited;
  IsLoading := false;
  fIsCData:= false;
  fDirty := false;
  ChildNodes := TList.Create;
  fParent := nil;
end;

destructor TDataTreeNodeBase.Destroy;
begin
  while ChildNodes.Count > 0 do begin
    TDataTreeNodeBase(ChildNodes[0]).Free;
    ChildNodes.Delete(0);
  end;
  FreeandNil(ChildNodes);
  inherited;
end;

function TDataTreeNodeBase.AddNode(const NodeName: string): TDataTreeNodeBase;
begin
  Result := TDataTreeNodeBase.Create;
  Result.NodeName := NodeName;
  Result.fParent := self;
  ChildNodes.Add(Result);
  if (not IsLoading) then begin
    if Assigned(fOnNodeChange) then fOnNodeChange(self);
    if Assigned(RootNode.fOnNodeChange) then RootNode.fOnNodeChange(self);
  end;
  fDirty := true;
end;

function TDataTreeNodeBase.GetAsBoolean: boolean;
begin
  if Value = 'True' then Result := true
  else Result := false;
end;

function TDataTreeNodeBase.GetAsDateTime: TDateTime;
begin
  if Value <> '' then Result := StrToDateTime(Value)
  else Result := 0.0;
end;

function TDataTreeNodeBase.GetAsFloat: double;
begin
  if Value <> '' then begin
    try
      Result := StrToFloat(Value);
    except
      Result := 0.0;
    end;
  end else Result := 0.0;
end;

function TDataTreeNodeBase.GetAsInteger: integer;
begin
  if Value <> '' then begin
    try
      Result := StrToInt(Value);
    except
      Result := 0;
    end;
  end else Result := 0;
end;

function TDataTreeNodeBase.GetAsString: string;
begin
  Result := Value;
end;

function TDataTreeNodeBase.GetCount: integer;
begin
  if Assigned(ChildNodes) then
    Result := ChildNodes.Count
  else
    result:= 0;
end;

function TDataTreeNodeBase.FindItemByName(const NamePath: string; const CreateNodes: boolean = false): TDataTreeNodeBase;
var
  PathPos, x: integer;
  lNode: TDataTreeNodeBase;
  found: boolean;
  strArray: TStringDynArray;
begin
  Result := nil;
  if NamePath <> '' then begin
    try
      strArray:= SplitString(NamePath, SepChar);

      lNode := self;
      found := false;

      for PathPos := Low(strArray) to High(strArray) do begin

        found := false;
        for x := 0 to lNode.Count - 1 do begin
          found := false;
          if SameText(lNode.Items[x].NodeName,strArray[PathPos]) then begin
            found := true;
            lNode := lNode.Items[x];
            Break;
          end;
        end;
        if not found then begin
          if CreateNodes then begin
            lNode := lNode.AddNode(strArray[PathPos]);
            found := true;
          end else Break;
        end;
      end;
      if not found then begin
        if CreateNodes then begin
          lNode := lNode.AddNode(strArray[PathPos]);
          found := true;
        end;
      end;
      if found then Result := lNode;
    finally

    end;
  end;
end;

function TDataTreeNodeBase.GetItemByName(const NamePath: string): TDataTreeNodeBase;
begin
  Result := FindItemByName(NamePath, true);
end;

function TDataTreeNodeBase.Exists(const NamePath: string): boolean;
begin
  Result := Assigned(FindItemByName(NamePath, false));
end;

function TDataTreeNodeBase.GetItems(const Index: integer): TDataTreeNodeBase;
begin
  Result := TDataTreeNodeBase(ChildNodes[index]);
end;

function TDataTreeNodeBase.GetNodeName: string;
begin
  Result := fNodeName;
end;

function TDataTreeNodeBase.GetParent: TDataTreeNodeBase;
begin
  Result := fParent;
end;

function TDataTreeNodeBase.GetValue: string;
begin
  if (not IsLoading) then begin
    if Assigned(fOnBeforeNodeGetValue) then fOnBeforeNodeGetValue(self);
    if Assigned(RootNode.fOnBeforeNodeGetValue) then RootNode.fOnBeforeNodeGetValue(self);
  end;
  If Pos(Lowercase('_x' + IntToHex(163, 2) + '_'),Lowercase(fValue))>0 then
    Result := ReinstateNonAlphaNumeric(fValue)
  else
    Result := fValue;
end;

function TDataTreeNodeBase.GetXML: string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8" ?>' + RawXML;
end;

function TDataTreeNodeBase.GetRawXML: string;
var
  x: integer;
begin
  if fIsCData then
    Result := '<' + StrToXMLNodeName(fNodeName) + '><![CDATA[' + fValue
  else
    Result := '<' + StrToXMLNodeName(fNodeName) + '>' + StrToXMLNodeName(fValue);
  for x := 0 to Count - 1 do Result := Result + Items[x].RawXML;
  if fIsCData then
    Result := Result + ']]></' + StrToXMLNodeName(fNodeName) + '>'
  else
    Result := Result + '</' + StrToXMLNodeName(fNodeName) + '>';
end;

function TDataTreeNodeBase.InsertNode(const NodeName: string; const Position: integer): TDataTreeNodeBase;
begin
  Result := TDataTreeNodeBase.Create;
  Result.NodeName := NodeName;
  Result.fParent := self;
  ChildNodes.Insert(Position, Result);
  if (not IsLoading) then begin
    if Assigned(fOnNodeChange) then fOnNodeChange(self);
    if Assigned(RootNode.fOnNodeChange) then RootNode.fOnNodeChange(self);
  end;
  fDirty := true;
end;

procedure TDataTreeNodeBase.SetNodeName(const aValue: string);
begin
  if fNodeName <> aValue then begin
    fNodeName := aValue;
    if (not IsLoading) then begin
      if Assigned(fOnNodeChange) then fOnNodeChange(self);
      if Assigned(RootNode.fOnNodeChange) then RootNode.fOnNodeChange(self);
    end;
  end;
  fDirty := true;
end;

procedure TDataTreeNodeBase.SetValue(const aValue: string);
var
  tmpValue: String;
begin
(*  If Pos('£',aValue)>0 then
    tmpValue := ReplaceNonAlphaNumeric(aValue)
  else*)
    tmpValue := aValue;
  if (fValue <> tmpValue) then begin
    fValue := tmpValue;
    fDirty := true;
    if (not IsLoading) then begin
      if Assigned(fOnNodeChange) then fOnNodeChange(self);
      if Assigned(RootNode.fOnNodeChange) then RootNode.fOnNodeChange(self);
    end;
  end;
end;

procedure TDataTreeNodeBase.SetXML(const aValue: string);
var
//  XMLParser: TXmlParser;
//  nl: TStringList;
  doc: IXMLDocument;
  rootCount: integer;

  function IsCdata(node: IXMLNode): boolean;
  begin
    result:= (node.ChildNodes.Count = 1) and
      (node.ChildNodes[0].NodeType = ntCData);
  end;

  procedure GetNodes(node: IXMLNode; treeNode: TDataTreeNodeBase);
  var
    x: integer;
    subTreeNode: TDataTreeNodeBase;
  begin
    if node.IsTextElement or node.HasChildNodes  then begin
      subTreeNode:= treeNode.AddNode(XMLNodeNameToStr(node.NodeName));
      if node.IsTextElement or IsCData(node) then
        if node.NodeValue = Null then
             subTreeNode.AsString:= ''
        else subTreeNode.AsString:= XMLNodeNameToStr(node.NodeValue);
      if IsCData(node) then
        subTreeNode.IsCData:= true
      else begin
        for x := 0 to node.ChildNodes.Count-1 do begin
          GetNodes(node.ChildNodes[x],subTreeNode);
        end;
      end;
    end;
  end;

begin
  self.Clear;
  if aValue = '' then exit;
  doc:= TXmlDocument.Create(nil);
  doc.LoadFromXML(aValue);
  doc.Active:= true;
  IsLoading:= true;
  try
    self.NodeName:= doc.DocumentElement.NodeName;
    for rootCount := 0 to doc.DocumentElement.ChildNodes.Count -1 do begin
      GetNodes(doc.DocumentElement.ChildNodes[rootCount],self);
    end;
  finally
    IsLoading:= false;
  end;

//  XMLParser := TXmlParser.Create;
//  nl := TStringList.Create;
//  IsLoading := true;
//  try
//    self.Clear;
//    XMLParser.LoadFromBuffer(PAnsiChar(AnsiString(aValue)));
//    XMLParser.StartScan;
//    while XMLParser.Scan do case XMLParser.CurPartType of
//        ptNone:            // Nothing
//          begin
//          end;
//        ptXmlProlog:       // XML Prolog                  XmlSpec 2.8 / 4.3.1
//          begin
//          end;
//        ptComment:         // Comment                     XmlSpec 2.5
//          begin
//          end;
//        ptPI:              // Processing Instruction      XmlSpec 2.6
//          begin
//          end;
//        ptDtdc:            // Document Type Declaration   XmlSpec 2.8
//          begin
//          end;
//        ptStartTag:        // Start Tag                   XmlSpec 3.1
//          begin
//            if nl.Count = 0 then begin
//              // root node
//              self.NodeName := XMLNodeNameToStr(String(XMLParser.CurName));
//              nl.AddObject(self.NodeName, self);
//            end else begin
//              nl.AddObject(String(XMLParser.CurName), TDataTreeNodeBase(nl.Objects[nl.Count - 1]).AddNode(XMLNodeNameToStr(String(XMLParser.CurName))));
//            end;
//          end;
//        ptEmptyTag:        // Empty-Element Tag           XmlSpec 3.1
//          begin
//          end;
//        ptEndTag:          // End Tag                     XmlSpec 3.1
//          begin
//            // finished this node so move down to prior one
//            if nl.Count > 1 then // in case we get an end tag with no begin tag
//              nl.Delete(nl.Count - 1);
//          end;
//        ptContent:         // Text Content between Tags
//          begin
//            TDataTreeNodeBase(nl.Objects[nl.Count - 1]).Value := String(XMLParser.CurContent);
//          end;
//        ptCData:          // CDATA Section               XmlSpec 2.7
//          begin
//            TDataTreeNodeBase(nl.Objects[nl.Count - 1]).fValue := String(XMLParser.CurContent);
//            TDataTreeNodeBase(nl.Objects[nl.Count - 1]).fIsCData:= true;
//          end;
//      end;
//  finally
//    FreeandNil(XMLParser);
//    FreeandNil(nl);
//    IsLoading := false;
//  end;
end;

function TDataTreeNodeBase.GetNodePath: string;
var
  P: TDataTreeNodeBase;
begin
  Result := fNodeName;
  p := Parent;
  while Assigned(p) do begin
    Result := p.NodeName + SepChar + Result;
    p      := p.Parent;
  end;
end;

function TDataTreeNodeBase.GetRootNode: TDataTreeNodeBase;
begin
  Result := self;
  while Assigned(Result.Parent) do Result := Result.Parent;
end;

procedure TDataTreeNodeBase.LoadFromFile(const aFileName: string);
var
  sl: TStringList;
begin
  Clear;
  sl := TStringList.Create;
  try
    sl.LoadFromFile(aFileName);
    SetXML(sl.Text);
  finally
    FreeandNil(sl);
  end;
  Dirty := false;
end;

procedure TDataTreeNodeBase.SaveToFile(const aFileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Text := self.XML;
    sl.SaveToFile(aFileName);
  finally
    FreeandNil(sl);
  end;
  Dirty := false;
end;

procedure TDataTreeNodeBase.Clear;
begin
  while ChildNodes.Count > 0 do begin
    TDataTreeNodeBase(ChildNodes[0]).Free;
    ChildNodes.Delete(0);
  end;
  NodeName := '';
  Value := '';
end;

procedure TDataTreeNodeBase.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value := 'True'
  else Value           := 'False';
end;

procedure TDataTreeNodeBase.SetAsDateTime(const aValue: TDateTime);
begin
  Value := DateTimeToStr(aValue);
end;

procedure TDataTreeNodeBase.SetAsFloat(const aValue: double);
begin
  Value := FloatToStr(aValue);
end;

procedure TDataTreeNodeBase.SetAsInteger(const aValue: integer);
begin
  Value := IntToStr(aValue);
end;

procedure TDataTreeNodeBase.SetAsString(const aValue: string);
begin
  Value := aValue;
end;

procedure TDataTreeNodeBase.Delete(const Index: integer);
begin
  TDataTreeNodeBase(ChildNodes[Index]).Free;
  ChildNodes.Delete(Index);
  if Assigned(fOnNodeChange) then fOnNodeChange(self);
  if Assigned(RootNode.fOnNodeChange) then RootNode.fOnNodeChange(self);
  fDirty := true;
end;

procedure TDataTreeNodeBase.DeleteByName(const NamePath: string);
var
  node: TDataTreeNodeBase;
  x: integer;
begin
  node := self.FindItemByName(NamePath, false);

  if Assigned(node) and Assigned(node.Parent) then begin
    x := node.Index;
    if x > -1 then node.Parent.Delete(x);
  end;
end;

function TDataTreeNodeBase.GetIndex: integer;
begin
  Result := -1;
  if Assigned(Parent) then Result := Parent.ChildNodes.IndexOf(self);
end;

function TDataTreeNodeBase.GetDirty: boolean;
var
  x: integer;
begin
  Result := false;
  if fDirty then Result := true
  else begin
    for x := 0 to Count - 1 do begin
      Result := Items[x].Dirty;
      if Result then Break;
    end;
  end;
end;

procedure TDataTreeNodeBase.SetDirty(const Value: boolean);
var
  x: integer;
begin
  if Value = true then fDirty := true
  else begin
    fDirty := false;
    for x := 0 to Count - 1 do begin
      Items[x].Dirty := false;
    end;
  end;
end;

procedure TDataTreeNodeBase.DeleteChildren;
begin
  while self.Count > 0 do
    self.Delete(0);
end;

{ 2 way bubble sort }
procedure TDataTreeNodeBase.Sort(CompareFunc: TDataTreeNodeSortCompare;
  Ascending: boolean = true);
var
  x, CompareResult: integer;
  posChanged, ScanForward: boolean;
begin
  if ChildNodes.Count < 2 then
    exit;
  posChanged:= true;
  ScanForward:= false;
  while posChanged do begin
    posChanged:= false;
    ScanForward:= not ScanForward;
    if ScanForward then x:= 1
    else x:= ChildNodes.Count -2;
    while (ScanForward and (x <  ChildNodes.Count)) or ((not ScanForward) and (x >= 0)) do begin
      if ScanForward then
        CompareResult:= CompareFunc(Items[x-1], Items[x])
      else
        CompareResult:= CompareFunc(Items[x], Items[x+1]);
      if Ascending and (CompareResult > 0) then begin
        if ScanForward then ChildNodes.Exchange(x-1,x)
        else ChildNodes.Exchange(x,x+1);
        posChanged:= true;
      end
      else if (not Ascending) and (CompareResult < 0) then begin
        if ScanForward then ChildNodes.Exchange(x-1,x)
        else ChildNodes.Exchange(x,x+1);
        posChanged:= true;
      end;

      if ScanForward then Inc(x)
      else Dec(x);
    end;
  end;
end;

function TDataTreeNodeBase.GetCData: string;
begin
  result:= fValue;
end;

procedure TDataTreeNodeBase.SetCData(const aValue: string);
begin
  fValue:= aValue;
  IsCData:= true;
  fDirty:= True;
end;

end.

