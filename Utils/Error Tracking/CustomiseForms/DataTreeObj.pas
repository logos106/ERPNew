unit DataTreeObj;

interface

uses Classes, MyAccess;

type

  TDataTreeNode = class;
  TDataTreeNodeEvent  = procedure (Sender: TDataTreeNode) of object;
  TOnNodeChange = TDataTreeNodeEvent;
  TOnBeforeNodeGetValue = TDataTreeNodeEvent;

  TDataTreeDbStorer = class;
  TDataTreeNode = class(Tobject)
  private
    ChildNodes: TList;
    fNodeName: string;
    fValue: string;
    fParent: TDataTreeNode;
    fDirty: boolean;
    fOnNodeChange: TDataTreeNodeEvent;
    fOnBeforeNodeGetValue: TDataTreeNodeEvent;
    IsLoading: boolean;
    fStorer: TDataTreeDbStorer;
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetAsString: string;
    function GetCount: integer;
    function GetItemByName(Const NamePath: string): TDataTreeNode;
    function GetItems(Const Index: integer): TDataTreeNode;
    function GetNodeName: string;
    function GetValue: string;
    function GetXML: string;
    function GetRawXML: string;
    procedure SetNodeName(const aValue: string);
    procedure SetValue(const aValue: string);
    procedure SetXML(const aValue: string);
    function GetParent: TDataTreeNode;
    function GetNodePath: string;
    function GetRootNode: TDataTreeNode;
    function GetStorer: TDataTreeDbStorer;
    procedure SetAsBoolean(const aValue: boolean);
    procedure SetAsDateTime(const aValue: TDateTime);
    procedure SetAsFloat(const aValue: double);
    procedure SetAsInteger(const aValue: integer);
    procedure SetAsString(const aValue: string);
    function GetIndex: integer;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Const Index: integer]: TDataTreeNode read GetItems;
    property ItemByName[Const NamePath: string]: TDataTreeNode read GetItemByName; default;
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
    function AddNode(Const NodeName: string): TDataTreeNode;
    function InsertNode(Const NodeName: string; Const position: integer): TDataTreeNode;
    property Parent: TDataTreeNode read GetParent;
    property NodePath: string read GetNodePath;
    property RootNode: TDataTreeNode read GetRootNode;
    procedure SaveToFile(Const aFileName: string);
    procedure LoadFromFile(Const aFileName: string);
    function FindItemByName(Const NamePath: string; Const CreateNodes: boolean = false): TDataTreeNode;
    function Exists(Const NamePath: string): boolean;
    procedure Clear;
    procedure Delete(Const Index: integer);
    procedure DeleteByName(Const NamePath: string);
    property Index: integer read GetIndex;
    property OnNodeChange: TDataTreeNodeEvent read fOnNodeChange write fOnNodeChange;
    property OnBeforeNodeGetValue: TDataTreeNodeEvent read fOnBeforeNodeGetValue write fOnBeforeNodeGetValue;
    property Dirty: boolean read GetDirty write SetDirty;
    property Storer: TDataTreeDbStorer read GetStorer ;
  end;

  TDataTree = class(TDataTreeNode)
  private
  protected
  public
  end;

  TDataTreeDbStorer = class(TObject)
  private
    fUserID: integer;
    fPrefGroup,
    fPrefName: string;
    fTreeNode: TDataTreeNode;
    fLastUpdated: TDateTime;
    qry: TMyQuery;
    fAutoUpdate: boolean;
    procedure SetTreeNode(const Value: TDataTreeNode);
    function GetConnection: TCustomMyConnection;
    procedure SetConnection(const Value: TCustomMyConnection);
  protected
  public
    constructor Create; overload;
    constructor Create(const DataTree: TDataTreeNode; const UserID: integer; const PrefGroup, PrefName: string); overload;
    destructor Destroy; override;
    property Connection: TCustomMyConnection read GetConnection write SetConnection;
    property UserId: integer read fUserId write fUserId;
    property TreeNode: TDataTreeNode read fTreeNode write SetTreeNode;
    procedure DoBeforeNodeGetData(Sender: TDataTreeNode);
    property AutoUpdate: boolean read fAutoUpdate write fAutoUpdate;
    function Load: boolean; overload;
    function Load(const UserID: integer;
                  const PrefGroup, PrefName: string): boolean; overload;
    procedure Refresh;
    procedure Save; overload;
    procedure Save(const UserID: integer;
                   const PrefGroup, PrefName: string); overload;
  end;

implementation

uses
  SysUtils, LibXmlParser,BaseDataMod,FuncLib, FastFuncs;

const
  SepChar = '.';


function StrToXMLNodeName(const aString: string): string;
begin
  result:= FuncLib.ReplaceNonAlphaNumeric(aString);
end;

function XMLNodeNameToStr(const aNodeName: string): string;
begin
  result:= FuncLib.ReinstateNonAlphaNumeric(aNodeName);
end;

{ TDataTreeNode }

constructor TDataTreeNode.Create;
begin
  IsLoading:= false;
  fStorer:= nil;
  fDirty:= false;
  ChildNodes:= TList.Create;
  fParent:= nil;
end;

destructor TDataTreeNode.Destroy;
begin
  if Assigned(fStorer) then
    fStorer.Free;
  while ChildNodes.Count > 0 do begin
    TDataTreeNode(ChildNodes[0]).Free;
    ChildNodes.Delete(0);
  end;
  ChildNodes.Free;
  inherited;
end;

function TDataTreeNode.AddNode(Const NodeName: string): TDataTreeNode;
begin
  result:= TDataTreeNode.Create;
  result.NodeName:= NodeName;
  result.fParent:= self;
  ChildNodes.Add(result);
  if (not IsLoading) then begin
    if assigned(fOnNodeChange) then
      fOnNodeChange(self);
    if Assigned(RootNode.fOnNodeChange) then
     RootNode.fOnNodeChange(self);
  end;
  fDirty:= true;
end;

function TDataTreeNode.GetAsBoolean: boolean;
begin
  if Value = 'True' then
    result:= true
  else
    result:= false;
end;

function TDataTreeNode.GetAsDateTime: TDateTime;
begin
  if Value <> '' then
    result:= StrToDateTime(Value)
  else
    result:= 0.0;
end;

function TDataTreeNode.GetAsFloat: double;
begin
  if Value <> '' then begin
    try
      result:= StrToFloat(Value);
    except
      result:= 0.0;
    end;
  end
  else
    result:= 0.0;
end;

function TDataTreeNode.GetAsInteger: integer;
begin
  if Value <> '' then begin
    try
      result:= StrToInt(Value);
    except
      result:= 0;
    end;
  end
  else
    result:= 0;
end;

function TDataTreeNode.GetAsString: string;
begin
  result:= Value;
end;

function TDataTreeNode.GetCount: integer;
begin
  result:= ChildNodes.Count;
end;

function TDataTreeNode.FindItemByName(Const NamePath: string; Const CreateNodes: boolean = false): TDataTreeNode;
var
  sl: TStringList;
  PathPos, x: integer;
  Node: TDataTreeNode;
  found: boolean;
begin
  result:= nil;
  if NamePath <> '' then begin
    sl:= TStringList.Create;
    try
      FuncLib.Split(NamePath, SepChar, sl);
      Node:= self;
      found:= false;
      for PathPos:= 0 to sl.Count-1 do begin
        found:= false;
        for x:= 0 to Node.Count-1 do begin
          found:= false;
          if Node.Items[x].NodeName = sl[PathPos] then begin
            found:= true;
            Node:= Node.Items[x];
            Break;
          end;
        end;
        if not found then begin
          if CreateNodes then begin
            Node:= Node.AddNode(sl[PathPos]);
            found:= true;
          end
          else
            Break;
        end;
      end;
      if not found then begin
        if CreateNodes then begin
          Node:= Node.AddNode(sl[PathPos]);
          found:= true;
        end;
      end;
      if found then
        result:= Node;
    finally
      sl.Free;
    end;
  end;
end;

function TDataTreeNode.GetItemByName(Const NamePath: string): TDataTreeNode;
begin
  result:= FindItemByName(NamePath, true);
end;

function TDataTreeNode.Exists(Const NamePath: string): boolean;
begin
  result:= Assigned(FindItemByName(NamePath, false));
end;

function TDataTreeNode.GetItems(Const Index: integer): TDataTreeNode;
begin
  result:= TDataTreeNode(ChildNodes[index]);
end;

function TDataTreeNode.GetNodeName: string;
begin
  result:= fNodeName;
end;

function TDataTreeNode.GetParent: TDataTreeNode;
begin
  result:= fParent;
end;

function TDataTreeNode.GetValue: string;
begin
  if (not IsLoading) then begin
    if assigned(fOnBeforeNodeGetValue) then
      fOnBeforeNodeGetValue(self);
    if Assigned(RootNode.fOnBeforeNodeGetValue) then
     RootNode.fOnBeforeNodeGetValue(self);
  end;
  result:= fValue;
end;

function TDataTreeNode.GetXML: string;
begin
  result:= '<?xml version="1.0" encoding="UTF-8" ?>' +
    RawXML;
end;

function TDataTreeNode.GetRawXML: string;
var
  x: integer;
begin
  result:= '<' + StrToXMLNodeName(fNodeName) + '>' + fValue;
  for x:= 0 to Count-1 do
    result:= result + Items[x].RawXML;
  result:= result + '</' + StrToXMLNodeName(fNodeName) + '>';
end;

function TDataTreeNode.InsertNode(Const NodeName: string; Const position: integer): TDataTreeNode;
begin
  result:= TDataTreeNode.Create;
  result.NodeName:= NodeName;
  result.fParent:= self;
  ChildNodes.Insert(position, result);
  if (not IsLoading) then begin
    if assigned(fOnNodeChange) then
      fOnNodeChange(self);
    if Assigned(RootNode.fOnNodeChange) then
     RootNode.fOnNodeChange(self);
  end;
  fDirty:= true;
end;

procedure TDataTreeNode.SetNodeName(const aValue: string);
begin
  if fNodeName <> aValue then begin
    fNodeName:= aValue;
    if (not IsLoading) then begin
      if assigned(fOnNodeChange) then
        fOnNodeChange(self);
      if Assigned(RootNode.fOnNodeChange) then
       RootNode.fOnNodeChange(self);
    end;
  end;
  fDirty:= true;
end;

procedure TDataTreeNode.SetValue(const aValue: string);
begin
  if fValue <> aValue then begin
    fValue:= aValue;
    fDirty:= true;
    if (not IsLoading) then begin
      if assigned(fOnNodeChange) then
        fOnNodeChange(self);
      if Assigned(RootNode.fOnNodeChange) then
       RootNode.fOnNodeChange(self);
    end;
  end;
end;

procedure TDataTreeNode.SetXML(const aValue: string);
var
  XMLParser: TXmlParser;
  nl: TStringList;
begin
  XMLParser:= TXmlParser.Create;
  nl:= TStringList.Create;
  IsLoading:= true;
  try
    XMLParser.LoadFromBuffer(PChar(aValue));
    XMLParser.StartScan;
    while XMLParser.Scan do
      case XMLParser.CurPartType of
        ptNone:            // Nothing
          begin
          end;
        ptXmlProlog:       // XML Prolog                  XmlSpec 2.8 / 4.3.1
          begin
          end;
        ptComment:         // Comment                     XmlSpec 2.5
          begin
          end;
        ptPI:              // Processing Instruction      XmlSpec 2.6
          begin
          end;
        ptDtdc:            // Document Type Declaration   XmlSpec 2.8
          begin
          end;
        ptStartTag:        // Start Tag                   XmlSpec 3.1
          begin
            if nl.Count = 0 then begin
              // root node
              self.NodeName:= XMLNodeNameToStr(XMLParser.CurName);
              nl.AddObject(self.NodeName, self);
            end
            else begin
              nl.AddObject(XMLParser.CurName,TDataTreeNode(nl.Objects[nl.Count-1]).AddNode(XMLNodeNameToStr(XMLParser.CurName)));
            end;
          end;
        ptEmptyTag:        // Empty-Element Tag           XmlSpec 3.1
          begin
          end;
        ptEndTag:          // End Tag                     XmlSpec 3.1
          begin
            // finished this node so move down to prior one
            if nl.Count > 1 then // in case we get an end tag with no begin tag
              nl.Delete(nl.Count-1);
          end;
        ptContent:         // Text Content between Tags
          begin
            TDataTreeNode(nl.Objects[nl.Count-1]).Value:= XMLParser.CurContent;
          end;
        ptCData:          // CDATA Section               XmlSpec 2.7
          begin
          end;
      end;
  finally
    XMLParser.Free;
    nl.Free;
    IsLoading:= false;
  end;
end;

function TDataTreeNode.GetNodePath: string;
var
  P: TDataTreeNode;
begin
  result:= fNodeName;
  p:= Parent;
  while Assigned(p) do begin
    result:= p.NodeName + SepChar + result;
    p:= p.Parent;
  end;
end;

function TDataTreeNode.GetRootNode: TDataTreeNode;
begin
  result:= self;
  while Assigned(result.Parent) do
    result:= result.Parent;
end;

procedure TDataTreeNode.LoadFromFile(Const aFileName: string);
var
  sl: TStringList;
begin
  Clear;
  sl:= TStringList.Create;
  try
    sl.LoadFromFile(aFileName);
    SetXML(sl.Text);
  finally
    sl.Free;
  end;
  Dirty:= false;
end;

procedure TDataTreeNode.SaveToFile(Const aFileName: string);
var
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    sl.Text:= self.XML;
    sl.SaveToFile(aFileName);
  finally
    sl.Free;
  end;
  Dirty:= false;
end;

procedure TDataTreeNode.Clear;
begin
  while ChildNodes.Count > 0 do begin
    TDataTreeNode(ChildNodes[0]).Free;
    ChildNodes.Delete(0);
  end;
  NodeName:= '';
  Value:= '';
end;

function TDataTreeNode.GetStorer: TDataTreeDbStorer;
begin
  if not Assigned(fStorer) then begin
    fStorer:= TDataTreeDbStorer.Create;
    fStorer.TreeNode := self;
  end;
  result:= fStorer;  
end;

procedure TDataTreeNode.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 'True'
  else Value:= 'False';
end;

procedure TDataTreeNode.SetAsDateTime(const aValue: TDateTime);
begin
  Value:= DateTimeToStr(aValue);
end;

procedure TDataTreeNode.SetAsFloat(const aValue: double);
begin
  Value:= FloatToStr(aValue);
end;

procedure TDataTreeNode.SetAsInteger(const aValue: integer);
begin
  Value:= FastFuncs.IntToStr(aValue);
end;

procedure TDataTreeNode.SetAsString(const aValue: string);
begin
  Value:= aValue;
end;

procedure TDataTreeNode.Delete(Const Index: integer);
begin
  TDataTreeNode(ChildNodes[Index]).Free;
  ChildNodes.Delete(Index);
  if assigned(fOnNodeChange) then
    fOnNodeChange(self);
  if Assigned(RootNode.fOnNodeChange) then
    RootNode.fOnNodeChange(self);
  fDirty:= true;
end;

//------------------------------------------------------------------------------
{ TDataTreeDbStorer }
//------------------------------------------------------------------------------

constructor TDataTreeDbStorer.Create(const DataTree: TDataTreeNode; const UserID: integer; const PrefGroup, PrefName: string);
begin
  fTreeNode:= TreeNode;
  fTreeNode.OnBeforeNodeGetValue:= DoBeforeNodeGetData;
  fUserID:= UserID;
  fPrefGroup:= PrefGroup;
  fPrefName:= PrefName;
  inherited Create;
end;

constructor TDataTreeDbStorer.Create;
begin
  inherited;
  fLastUpdated:= 0;
  fAutoUpdate:= false;
  qry:= TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
end;

destructor TDataTreeDbStorer.Destroy;
begin
  fTreeNode.OnBeforeNodeGetValue:= nil;
  qry.Free;
  inherited;
end;

procedure TDataTreeDbStorer.DoBeforeNodeGetData(Sender: TDataTreeNode);
begin
  if AutoUpdate then Refresh;
end;

function TDataTreeDbStorer.Load: boolean;
begin
  if not Assigned(qry.Connection) then
    qry.Connection:= BaseDataModule.NonTransDBConnection;
  fTreeNode.Clear;
  result:= false;
  if (not Assigned(fTreeNode)) or (fPrefName = '') then exit;
  qry.SQL.Text:= 'SELECT * FROM guipreferences WHERE' +
                 ' UserId = ' + FastFuncs.IntToStr(fUserID) +
                 ' AND PrefGroup = ' + QuotedStr(fPrefGroup) +
                 ' AND PrefName = ' + QuotedStr(fPrefName);
  qry.Open;
  if not qry.IsEmpty then begin
    fTreeNode.XML:= qry.FieldByName('PrefValue').AsString;
    fTreeNode.Dirty:= false;
    fLastUpdated:= qry.FieldByName('msTimeStamp').AsDateTime;
    result:= true;
  end;
  qry.Close;
end;

function TDataTreeDbStorer.GetConnection: TCustomMyConnection;
begin
  result:= qry.Connection;
end;

function TDataTreeDbStorer.Load(const UserID: integer; const PrefGroup, PrefName: string): boolean;
begin
  fUserID:= UserID;
  fPrefGroup:= PrefGroup;
  fPrefName:= PrefName;
  result:= Load;
end;

procedure TDataTreeDbStorer.Refresh;
var
  NeedsLoading: boolean;
begin
  if (not Assigned(fTreeNode)) or (fPrefName = '') then exit;
  if not Assigned(qry.Connection) then
    qry.Connection:= BaseDataModule.NonTransDBConnection;
  NeedsLoading:= false;
  qry.SQL.Text:= 'SELECT msTimeStamp FROM guipreferences WHERE' +
                 ' UserId = ' + FastFuncs.IntToStr(fUserID) +
                 ' AND PrefGroup = ' + QuotedStr(fPrefGroup) +
                 ' AND PrefName = ' + QuotedStr(fPrefName);
  qry.Open;
  if (not qry.IsEmpty) and
     (qry.FieldByName('msTimeStamp').AsDateTime > fLastUpdated) then
    NeedsLoading:= true;
  qry.Close;
  if NeedsLoading then Load;
end;

procedure TDataTreeDbStorer.Save;
begin
  if (not Assigned(fTreeNode)) or (fPrefName = '') then exit;
  if not Assigned(qry.Connection) then
    qry.Connection:= BaseDataModule.NonTransDBConnection;
  qry.SQL.Text:= 'SELECT * FROM guipreferences WHERE' +
                 ' UserId = ' + FastFuncs.IntToStr(fUserID) +
                 ' AND PrefGroup = ' + QuotedStr(fPrefGroup) +
                 ' AND PrefName = ' + QuotedStr(fPrefName);
  qry.Open;
  if not qry.IsEmpty then begin
    qry.Edit;
    qry.FieldByName('PrefValue').AsString:= fTreeNode.XML;
    qry.Post;
    fLastUpdated:= qry.FieldByName('msTimeStamp').AsDateTime;
  end
  else begin
    qry.Insert;
    qry.FieldByName('UserId').AsInteger:= fUserID;
    qry.FieldByName('PrefGroup').AsString:= fPrefGroup;
    qry.FieldByName('PrefName').AsString:= fPrefName;
    qry.FieldByName('PrefValue').AsString:= fTreeNode.XML;
    qry.Post;
    fLastUpdated:= qry.FieldByName('msTimeStamp').AsDateTime;
  end;
  qry.Close;
  self.fTreeNode.Dirty:= false;
end;

procedure TDataTreeDbStorer.Save(const UserID: integer;
  const PrefGroup, PrefName: string);
begin
  fUserID:= UserID;
  fPrefGroup:= PrefGroup;
  fPrefName:= PrefName;
  Save;
end;

procedure TDataTreeDbStorer.SetConnection(const Value: TCustomMyConnection);
begin
  qry.Connection := Value;
end;

procedure TDataTreeDbStorer.SetTreeNode(const Value: TDataTreeNode);
begin
  fTreeNode := Value;
  fTreeNode.OnBeforeNodeGetValue:= DoBeforeNodeGetData;
end;

procedure TDataTreeNode.DeleteByName(Const NamePath: string);
var
  node: TDataTreeNode;
  x: integer;
begin
  node:= self.FindItemByName(NamePath, false);

  if Assigned(node) and Assigned(node.Parent) then begin
    x:= node.Index;
    if x > -1 then
      node.Parent.Delete(x);
  end;
end;

function TDataTreeNode.GetIndex: integer;
begin
  result:= -1;
  if Assigned(parent) then
    result:= parent.ChildNodes.IndexOf(self);
end;

function TDataTreeNode.GetDirty: boolean;
var
  x: integer;
begin
  result:= false;
  if fDirty then
    result:= true
  else begin
    for x:= 0 to Count-1 do begin
      result:= Items[x].Dirty;
      if result then Break;
    end;
  end;
end;

procedure TDataTreeNode.SetDirty(const Value: boolean);
var
  x: integer;
begin
  if Value = true then fDirty:= true
  else begin
    fDirty:= false;
    for x:= 0 to Count-1 do begin
      Items[x].Dirty:= false;
    end;
  end;
end;

end.
