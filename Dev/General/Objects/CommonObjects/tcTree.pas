{================================================================================
Unit     : tcTree
Purpose  : To have a non-visual tree component.
Date     : 04/07/2005
Author   :
Notes    : This unit was originally based upon the work of Patrick O'Keeffe.
           It was at his request that I took the component over and rm'ified it.
================================================================================}

unit tcTree;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 04/07/05  1.00.00 IJB  Initial version.


interface

//{$I CompilerDefines.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  Contnrs;

type
  TAddMode        = (taAddFirst, taAdd, taInsert);
  TNodeAttachMode = (naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert);

  PNodeInfo = ^TNodeInfo;
  TNodeInfo = packed record
    Count: integer;
    Text: string[255];
  end;

  TtcCustomTree = class;
  TtcTreeNodes  = class;
  TtcTreeNode   = class;

  TrmHashData = class(TObject)
    Hash: longint;
    IDLength: integer;
    Node: TtcTreeNode;
  end;

  { TreeView }

  TtcTreeNode = class(TPersistent)
  private
    FOwner: TtcTreeNodes;
    FText: string;
    FData: Pointer;
    FValue: string;
    FChildList: TList;
    FDeleting: boolean;
    FParent: TtcTreeNode;
    fExpanded: boolean;
    fHashed: boolean;
    function GetLevel: integer;
    function GetParent: TtcTreeNode;
    procedure SetParent(const Value: TtcTreeNode);
    function GetChildren: boolean;
    function GetIndex: integer;
    function GetItem(const Index: integer): TtcTreeNode;
    function GetCount: integer;
    function GettcTree: TtcCustomTree;
    function IsEqual(const Node: TtcTreeNode): boolean;
    procedure ReadData(const Stream: TStream; const Info: PNodeInfo);
    procedure SetData(const Value: Pointer);
    procedure SetItem(const Index: integer; const Value: TtcTreeNode);
    procedure SetText(const S: string);
    procedure WriteData(Stream: TStream; const Info: PNodeInfo);
    function GetItemCount: integer;
    procedure RemoveHash;
    procedure RenewHash;
    property HasBeenHashed: boolean read fhashed write fhashed;
    function GetNodePath: string;
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetAsString: string;
    procedure SetAsBoolean(const aValue: boolean);
    procedure SetAsDateTime(const aValue: TDateTime);
    procedure SetAsFloat(const aValue: double);
    procedure SetAsInteger(const aValue: integer);
    procedure SetAsString(const aValue: string);
    procedure SetValue(const Value: string);
  public
    constructor Create(AOwner: TtcTreeNodes);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Delete;
    procedure DeleteChildren;
    function GetFirstChild: TtcTreeNode;
    function GetLastChild: TtcTreeNode;
    function GetNext: TtcTreeNode;
    function GetNextChild(const Value: TtcTreeNode): TtcTreeNode;
    function GetNextSibling: TtcTreeNode;
    function GetPrev: TtcTreeNode;
    function GetPrevChild(const Value: TtcTreeNode): TtcTreeNode;
    function getPrevSibling: TtcTreeNode;
    function HasAsParent(const Value: TtcTreeNode): boolean;
    function IndexOf(const Value: TtcTreeNode): integer;
    function MoveTo(const Destination: TtcTreeNode; const Mode: TNodeAttachMode): TtcTreeNode;

    property Count: integer read GetCount;
    property Data: Pointer read FData write SetData;
    property Value: string read FValue write SetValue;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property Deleting: boolean read FDeleting;
    property HasChildren: boolean read GetChildren;
    property Expanded: boolean read fExpanded write fExpanded default false;
    property Index: integer read GetIndex;
    property Item[const Index: integer]: TtcTreeNode read GetItem write SetItem; default;
    function NodeExists(const Path: string): boolean;
    function Node(const Path: string): TtcTreeNode;
    property Level: integer read GetLevel;
    property Owner: TtcTreeNodes read FOwner;
    property Parent: TtcTreeNode read GetParent write SetParent;
    property Tree: TtcCustomTree read GettcTree;
    property NodePath: string read GetNodePath;
    property Text: string read FText write SetText;
    property ItemCount: integer read GetItemCount;
    function Add(const S: string): TtcTreeNode;
  end;

  { TreeViews }

  TtcTreeNodes = class(TPersistent)
  private
    FOwner: TtcCustomTree;
    FRootNodeList: TList;
    FHashList: TObjectList;
    function GetNodeFromIndex(const Index: integer): TtcTreeNode;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    function HashValue(const St: string): longint;
    function LocateHashIndex(const Path: string): integer;
    procedure BinaryInsert(const Path: string; Node: TtcTreeNode);
    procedure RemoveHash(const Node: TtcTreeNode);
  protected
    function InternalAddObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer; const AddMode: TAddMode): TtcTreeNode;
    procedure DefineProperties(Filer: TFiler); override;
    function GetCount: integer;
    procedure SetItem(const Index: integer; const Value: TtcTreeNode);
  public
    procedure dumphash;
    constructor Create(AOwner: TtcCustomTree);
    destructor Destroy; override;
    function AddChildFirst(const Node: TtcTreeNode; const S: string): TtcTreeNode;
    function AddChild(const Node: TtcTreeNode; const S: string): TtcTreeNode;
    function AddChildObjectFirst(const Node: TtcTreeNode; const S: string; Ptr: Pointer): TtcTreeNode;
    function AddChildObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
    function AddFirst(const Node: TtcTreeNode; const S: string): TtcTreeNode;
    function Add(const Node: TtcTreeNode; const S: string): TtcTreeNode;
    function AddObjectFirst(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
    function AddObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(const Node: TtcTreeNode);
    function GetFirstNode: TtcTreeNode;
    function Insert(const Node: TtcTreeNode; const S: string): TtcTreeNode;
    function InsertObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
    function LocateNode(const Path: string): TtcTreeNode;
    property Count: integer read GetCount;
    property Item[const Index: integer]: TtcTreeNode read GetNodeFromIndex; default;
    property Owner: TtcCustomTree read FOwner;
  end;

  { TtcCustomTree }

  TtcTreeEvent = procedure(Sender: TObject; Node: TtcTreeNode) of object;
  EtcTreeError = class(Exception);

  TtcCustomTree = class(TComponent)
  private
    FMemStream: TMemoryStream;
    FTreeNodes: TtcTreeNodes;
    FOnDeletion: TtcTreeEvent;
    fOnNodeTextChanged: TtcTreeEvent;
    fOnNodeValueChanged: TtcTreeEvent;
    FSepChar: char;
    IsLoading: boolean;

    procedure SettcTreeNodes(Value: TtcTreeNodes);
    function ParentName(s: string): string;
    function ChildName(s: string): string;
    function GetXMLText: string;
    procedure SetXMLText(const aValue: string);
  protected
    function CreateNode: TtcTreeNode; 
    procedure Delete(Const Node: TtcTreeNode); 

    property SepChar: char read FSepChar write FSepChar;
    property Items: TtcTreeNodes read FTreeNodes write SettcTreeNodes;
    property OnDeletion: TtcTreeEvent read FOnDeletion write FOnDeletion;
    property OnNodeTextChanged: TtcTreeEvent read fOnNodeTextChanged write fOnNodeTextChanged;
    property OnNodeValueChanged: TtcTreeEvent read fOnNodeValueChanged write fOnNodeValueChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    function AddPathNode(Node: TtcTreeNode; Path: string): TtcTreeNode;
    function FindPathNode(const Path: string): TtcTreeNode;
    function NodeExists(const Path: string): boolean;
    function Node(const Path: string): TtcTreeNode;
    function NodePath(Node: TtcTreeNode): string;
    procedure TextSort(ParentNode: TtcTreeNode; Recursive: boolean);
    property XMLText: string read GetXMLText write SetXMLText;
    procedure LoadXMLFromFile(const FileName: string);
    procedure SaveXMLToFile(const FileName: string);
  end;

  TtcTree = class(TtcCustomTree)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property SepChar;
    property Items;
    property OnDeletion;
    property OnNodeTextChanged;
    property OnNodeValueChanged;
  end;

  Tcrc32tabletype = array[0..255] of longint;

implementation

uses FastFuncs;

var
  fcrctable: Tcrc32tabletype;

function crc32gen: Tcrc32tabletype;
var
  crc, poly: longint;
  i, j: integer;
  crc32table: Tcrc32tabletype;
begin
  FastFuncs.FillChar(crc32table, SizeOf(crc32table), Char(0));
  poly := longint($EDB88320);
  for i := 0 to 255 do begin
    crc := i;
    for j := 8 downto 1 do begin
      if (crc and 1) = 1 then crc := (crc shr 1) xor poly
      else crc := crc shr 1;
    end;
    crc32table[i] := crc;
  end;
  Result := crc32table;
end;


function GetStrCRC32(const Data: string): longint;
var
  crc: longint;
  index, datalength: integer;
begin
  crc := longint($FFFFFFFF);

  datalength := Length(Data);
  index := 1;
  while index <= datalength do begin
    crc := ((crc shr 8) and $FFFFFF) xor fcrctable[(crc xor byte(Data[index])) and $FF];
    Inc(index);
  end;
  Result := (crc xor integer($FFFFFFFF));
end;

procedure tcTreeError(const Msg: string);
begin
  raise EtcTreeError.Create(Msg);
end;

constructor TtcTreeNode.Create(AOwner: TtcTreeNodes);
begin
  inherited Create;
  FOwner := AOwner;
  FChildList := TList.Create;
  fExpanded := false;
  fHashed := false;
  fValue := '';
end;

destructor TtcTreeNode.Destroy;
begin
  FDeleting := true;
  Data := nil;
  FreeandNil(FChildList);
  inherited Destroy;
end;

function TtcTreeNode.GettcTree: TtcCustomTree;
begin
  Result := Owner.Owner;
end;

function TtcTreeNode.HasAsParent(const Value: TtcTreeNode): boolean;
begin
  if Value <> nil then begin
    if Parent = nil then Result := false
    else if Parent = Value then Result := true
    else Result := Parent.HasAsParent(Value);
  end else Result := true;
end;

procedure TtcTreeNode.SetText(const S: string);
var
  fRemoved: boolean;
begin
  fRemoved := false;

  if not (FText = '') and (FText <> S) then begin
    Self.RemoveHash;
    fRemoved := true;
  end;

  FText := S;

  if fRemoved and not (fText = '') then begin
    Self.RenewHash;
  end;

  if Assigned(Tree.OnNodeTextChanged) then Tree.OnNodeTextChanged(Tree, self);
end;

procedure TtcTreeNode.SetData(const Value: Pointer);
begin
  FData := Value;
end;

function TtcTreeNode.GetChildren: boolean;
begin
  Result := FChildList.Count > 0;
end;

function TtcTreeNode.GetParent: TtcTreeNode;
begin
  Result := FParent;
end;

procedure TtcTreeNode.SetParent(const Value: TtcTreeNode);
var
  wHashed: boolean;
begin
  wHashed := HasBeenHashed;
  if wHashed then removeHash;

  if (fParent <> nil) then fParent.FChildList.Delete(fParent.FChildList.IndexOf(self));

  if (Value <> nil) then begin
    FParent := Value;
    if fParent.FChildList.IndexOf(self) = -1 then fParent.FChildList.Add(self);
  end;

  if wHashed then RenewHash;
end;

function TtcTreeNode.GetNextSibling: TtcTreeNode;
var
  CurIdx: integer;
begin
  if Parent <> nil then begin
    CurIdx := Parent.FChildList.IndexOf(Self);
    if (CurIdx + 1) < Parent.FChildList.Count then Result := Parent.FChildList.Items[CurIdx + 1]
    else Result := nil;
  end else begin
    CurIdx := Owner.FRootNodeList.IndexOf(Self);
    if (CurIdx + 1) < Owner.FRootNodeList.Count then Result := Owner.FRootNodeList.Items[CurIdx + 1]
    else Result := nil;
  end;
end;

function TtcTreeNode.GetPrevSibling: TtcTreeNode;
var
  CurIdx: integer;
begin
  if Parent <> nil then begin
    CurIdx := Parent.FChildList.IndexOf(Self);
    if (CurIdx - 1) >= 0 then Result := Parent.FChildList.Items[CurIdx - 1]
    else Result := nil;
  end else begin
    CurIdx := Owner.FRootNodeList.IndexOf(Self);
    if (CurIdx - 1) >= Owner.FRootNodeList.Count then Result := Owner.FRootNodeList.Items[CurIdx - 1]
    else Result := nil;
  end;
end;

function TtcTreeNode.GetNextChild(const Value: TtcTreeNode): TtcTreeNode;
begin
  if Value <> nil then Result := Value.GetNextSibling
  else Result := nil;
end;

function TtcTreeNode.GetPrevChild(const Value: TtcTreeNode): TtcTreeNode;
begin
  if Value <> nil then Result := Value.GetPrevSibling
  else Result := nil;
end;

function TtcTreeNode.GetFirstChild: TtcTreeNode;
begin
  if FChildList.Count > 0 then begin
    Result := FChildList.Items[0];
  end else Result := nil;
end;

function TtcTreeNode.GetLastChild: TtcTreeNode;
begin
  if FChildList.Count > 0 then begin
    Result := FChildList.Items[FChildList.Count - 1]
  end else Result := nil;
end;

function TtcTreeNode.GetNext: TtcTreeNode;
var
  N: TtcTreeNode;
  P: TtcTreeNode;
begin
  if HasChildren then N := GetFirstChild
  else begin
    N := GetNextSibling;
    if N = nil then begin
      P := Parent;
      while P <> nil do begin
        N := P.GetNextSibling;
        if N <> nil then Break;
        P := P.Parent;
      end;
    end;
  end;
  Result := N;
end;

function TtcTreeNode.GetPrev: TtcTreeNode;
var
  Node: TtcTreeNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else Result := Parent;
end;

function TtcTreeNode.GetIndex: integer;
var
  Node: TtcTreeNode;
begin
  Result := -1;
  Node := Parent;
  if Node = nil then begin
    if fowner <> nil then FOwner.FRootNodeList.IndexOf(self)
  end else Result := Parent.FChildList.IndexOf(self);
end;

function TtcTreeNode.GetItem(const Index: integer): TtcTreeNode;
begin
  if (index >= 0) and (index < FChildList.Count) then Result := fchildlist[index]
  else begin
    Result := nil;
    tcTreeError('List Index Out of Bounds');
  end;
end;

procedure TtcTreeNode.SetItem(const Index: integer; const Value: TtcTreeNode);
begin
  item[Index].Assign(Value);
end;

function TtcTreeNode.IndexOf(const Value: TtcTreeNode): integer;
begin
  Result := fChildList.IndexOf(Value);
end;

function TtcTreeNode.MoveTo(const Destination: TtcTreeNode; const Mode: TNodeAttachMode): TtcTreeNode;
var
  AddMode: TAddMode;
  node: TtcTreeNode;
begin
  Result := nil;
  if (Destination = nil) or not Destination.HasAsParent(Self) then begin
    AddMode := taAdd;
    if (Destination <> nil) and not (Mode in [naAddChild, naAddChildFirst]) then Node := Destination.Parent
    else Node := Destination;

    case Mode of
      naAdd,
      naAddChild: AddMode := taAdd;
      naAddFirst,
      naAddChildFirst: AddMode := taAddFirst;
      naInsert:
        begin
          Node := Destination.GetPrevSibling;
          if Node = nil then AddMode := taAddFirst
          else AddMode := taInsert;
        end;
    end;
    if node <> self then begin
      Result := Owner.InternalAddObject(node, Text, Data, AddMode);
      Delete;
    end;
  end else Result := self;
end;

function TtcTreeNode.GetCount: integer;
begin
  Result := FChildList.Count;
end;

function TtcTreeNode.GetLevel: integer;
var
  Node: TtcTreeNode;
begin
  Result := 0;
  Node := Parent;
  while Node <> nil do begin
    Inc(Result);
    Node := Node.Parent;
  end;
end;

procedure TtcTreeNode.Delete;
var
  wIndex: integer;
begin
  if HasChildren then DeleteChildren;

  Owner.RemoveHash(self);
  if Parent <> nil then begin
    wIndex := Parent.FChildList.IndexOf(Self);
    Parent.FChildList.Delete(wIndex);
    Parent.FChildList.Pack;
  end else begin
    wIndex := Owner.FRootNodeList.IndexOf(Self);
    Owner.FRootNodeList.Delete(wIndex);
    Owner.FRootNodeList.Pack;
  end;
  TtcCustomTree(Owner.Owner).Delete(Self);
  Free;
end;

procedure TtcTreeNode.DeleteChildren;
var
  Node: TtcTreeNode;
begin
  Node := GetLastChild;
  while Node <> nil do begin
    Node.Delete;
    Node := GetLastChild;
  end;
end;

procedure TtcTreeNode.Assign(Source: TPersistent);
var
  Node: TtcTreeNode;
begin
  if Source is TtcTreeNode then begin
    Node := TtcTreeNode(Source);
    Text := Node.Text;
    Data := Node.Data;
  end else inherited Assign(Source);
end;

function TtcTreeNode.IsEqual(const Node: TtcTreeNode): boolean;
begin
  Result := (Text = Node.Text) and (Data = Node.Data);
end;

procedure TtcTreeNode.ReadData(const Stream: TStream; const Info: PNodeInfo);
var
  I, Size, ItemCount: integer;
  ObjType: integer;
begin
  Stream.ReadBuffer(Size, SizeOf(Size));
  Stream.ReadBuffer(Info^, Size);
  Text := Info^.Text;
  ItemCount := Info^.Count;
  Stream.ReadBuffer(ObjType, SizeOf(ObjType));
  case ObjType of
    0:
      begin
        //do nothing
      end;

    1:
      begin
        Data := Stream.ReadComponent(nil);
      end;
  end;
  for I := 0 to ItemCount - 1 do Owner.AddChild(Self, '').ReadData(Stream, Info);
end;

procedure TtcTreeNode.WriteData(Stream: TStream; const Info: PNodeInfo);
var
  I, Size, L, ItemCount, ObjType: integer;
begin
  L := Length(Text);
  if L > 255 then L := 255;
  Size := SizeOf(TNodeInfo) + L - 255;
  Info^.Text := Text;
  ItemCount := Count;
  Info^.Count := ItemCount;
  Stream.WriteBuffer(Size, SizeOf(Size));
  Stream.WriteBuffer(Info^, Size);
  if Assigned(Self.Data) then begin
    try
      TObject(self.Data).classtype;
      if (TObject(Self.Data) is TComponent) then begin
        ObjType := 1;
        Stream.WriteBuffer(ObjType, SizeOf(ObjType));
        Stream.WriteComponent(TComponent(Data));
      end else begin
        ObjType := 0;
        Stream.WriteBuffer(ObjType, SizeOf(ObjType));
      end;
    except
      ObjType := 0;
      Stream.WriteBuffer(ObjType, SizeOf(ObjType));
    end;
  end else begin
    ObjType := 0;
    Stream.WriteBuffer(ObjType, SizeOf(ObjType));
  end;
  for I := 0 to ItemCount - 1 do Item[I].WriteData(Stream, Info);
end;

{ TtcTreeNodes }

constructor TtcTreeNodes.Create(AOwner: TtcCustomTree);
begin
  inherited Create;
  FOwner := AOwner;
  FRootNodeList := TList.Create;
  FHashList := TObjectList.Create;
  FHashList.OwnsObjects := true;
end;

destructor TtcTreeNodes.Destroy;
begin
  Clear;
  FreeandNil(FRootNodeList);
  FreeandNil(FHashList);
  inherited Destroy;
end;

function TtcTreeNodes.GetCount: integer;
var
  Idx: integer;
begin
  Result := FRootNodeList.Count;
  for Idx := 0 to FRootNodeList.Count - 1 do begin
    Result := Result + TtcTreeNode(FRootNodeList[Idx]).ItemCount;
  end;
end;

procedure TtcTreeNodes.Delete(const Node: TtcTreeNode);
var
  wIndex: integer;
begin
  wIndex := LocateHashIndex(Owner.NodePath(Node));
  if wIndex > -1 then FHashList.Delete(wIndex);
  Node.Delete;
  if (not Owner.IsLoading) and Assigned(Owner.OnNodeValueChanged) then Owner.OnNodeValueChanged(Owner, nil);
end;

procedure TtcTreeNodes.Clear;
var
  N: TtcTreeNode;
begin
  N := GetFirstNode;
  while N <> nil do begin
    N.Delete;
    N := GetFirstNode;
  end;
  FHashList.Clear;
end;

function TtcTreeNodes.AddChildFirst(const Node: TtcTreeNode; const S: string): TtcTreeNode;
begin
  Result := AddChildObjectFirst(Node, S, nil);
end;

function TtcTreeNodes.AddChildObjectFirst(const Node: TtcTreeNode; const S: string; Ptr: Pointer): TtcTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, taAddFirst);
end;

function TtcTreeNodes.AddChild(const Node: TtcTreeNode; const S: string): TtcTreeNode;
begin
  Result := AddChildObject(Node, S, nil);
end;

function TtcTreeNodes.AddChildObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, taAdd);
end;

function TtcTreeNodes.AddFirst(const Node: TtcTreeNode; const S: string): TtcTreeNode;
begin
  Result := AddObjectFirst(Node, S, nil);
end;

function TtcTreeNodes.AddObjectFirst(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
Var
  tmpNode: TtcTreeNode;
begin
  tmpNode := nil;
  if Node <> nil then tmpNode := Node.Parent;
  Result := InternalAddObject(tmpNode, S, Ptr, taAddFirst);
end;

function TtcTreeNodes.Add(const Node: TtcTreeNode; const S: string): TtcTreeNode;
begin
  Result := AddObject(Node, S, nil);
end;

function TtcTreeNodes.AddObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
Var
  tmpNode: TtcTreeNode;
begin
  tmpNode := nil;
  if Node <> nil then tmpNode := Node.Parent;
  Result := InternalAddObject(tmpNode, S, Ptr, taAdd);
end;

function TtcTreeNodes.Insert(const Node: TtcTreeNode; const S: string): TtcTreeNode;
begin
  Result := InsertObject(Node, S, nil);
end;

function TtcTreeNodes.InsertObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer): TtcTreeNode;
var
  tmpNode,Parent: TtcTreeNode;
  AddMode: TAddMode;
  Target: TtcTreeNode;
begin
  tmpNode := nil;
  AddMode := taInsert;
  Target := node;
  if Node <> nil then begin
    Parent := Node.Parent;
    if Parent <> nil then tmpNode := Node.GetPrevSibling;
    if tmpNode = nil then begin
      AddMode := taAddFirst;
      target := Parent;
    end;
  end;
  Result := InternalAddObject(Target, S, Ptr, AddMode);
end;

function TtcTreeNodes.InternalAddObject(const Node: TtcTreeNode; const S: string; const Ptr: Pointer; const AddMode: TAddMode): TtcTreeNode;
var
  nvnParent: TtcTreeNode;
  nindex: integer;
begin
  Result := Owner.CreateNode;
  try
    case AddMode of
      taAddFirst:
        begin
          if Node = nil then begin
            FRootNodeList.Insert(0, Result);
            Result.Parent := nil;
          end else begin
            Node.FChildList.Insert(0, Result);
            Result.Parent := Node;
          end;
          try
            Result.Data := Ptr;
            Result.Text := S;
            BinaryInsert(Owner.NodePath(Result), Result);
          except
            raise;
          end;
        end;

      taAdd:
        begin
          if Node = nil then begin
            FRootNodeList.Add(Result);
            Result.Parent := nil;
          end else begin
            Node.FChildList.Add(Result);
            Result.Parent := Node;
          end;
          try
            Result.Data := Ptr;
            Result.Text := S;
            BinaryInsert(Owner.NodePath(Result), Result);
          except
            raise;
          end;
        end;

      taInsert:
        begin
          nvnParent := Node.Parent;
          if nvnParent = nil then begin
            if Node = nil then begin
              FRootNodeList.Insert(0, Result);
              Result.Parent := nil;
            end else begin
              nIndex := fRootNodeList.IndexOf(Node);
              if nIndex <> -1 then begin
                fRootNodeList.Insert(nIndex, Result);
                Result.Parent := nil;
              end else tcTreeError('Unable to find Node reference');
            end;
          end else begin
            nIndex := nvnParent.FChildList.IndexOf(node);
            if nIndex >= 0 then begin
              nvnParent.FChildList.Insert(nIndex, Result);
              Result.Parent := nvnParent;
            end else tcTreeError('Unable to find Node reference');
          end;

          try
            Result.Data := Ptr;
            Result.Text := S;
            BinaryInsert(Owner.NodePath(Result), Result);
          except
            raise;
          end;
        end;
    end;
  except
    raise;
  end;
end;

function TtcTreeNodes.GetFirstNode: TtcTreeNode;
begin
  if FRootNodeList.Count = 0 then Result := nil
  else Result := FRootNodeList.Items[0];
end;

function TtcTreeNodes.GetNodeFromIndex(const Index: integer): TtcTreeNode;
var
  I: integer;
begin
  Result := GetFirstNode;
  I := Index;
  while (I <> 0) and (Result <> nil) do begin
    Result := Result.GetNext;
    Dec(I);
  end;
  if Result = nil then tcTreeError('Index out of range');
end;

procedure TtcTreeNodes.SetItem(const Index: integer; const Value: TtcTreeNode);
begin
  GetNodeFromIndex(Index).Assign(Value);
end;

procedure TtcTreeNodes.Assign(Source: TPersistent);
var
  TreeNodes: TtcTreeNodes;
  MemStream: TMemoryStream;
  wNode: TtcTreeNode;
begin
  if Source is TtcTreeNodes then begin
    TreeNodes := TtcTreeNodes(Source);
    Clear;
    MemStream := TMemoryStream.Create;
    try
      TreeNodes.WriteData(MemStream);
      MemStream.Position := 0;
      ReadData(MemStream);
    finally
      FreeandNil(MemStream);
    end;

    //Now that we've assigned all the nodes
    //we need to redo that hashlist
    wNode := Self.GetFirstNode;
    while wNode <> nil do begin
      wNode.RenewHash;
      wNode := wNode.GetNextSibling;
    end;
  end else inherited Assign(Source);
end;

procedure TtcTreeNodes.DefineProperties(Filer: TFiler);

  function WriteNodes: boolean;
  var
    I: integer;
    Nodes: TtcTreeNodes;
  begin
    Nodes := TtcTreeNodes(Filer.Ancestor);
    if Nodes = nil then Result := Count > 0
    else if Nodes.Count <> Count then Result := true
    else begin
      Result := false;
      for I := 0 to Count - 1 do begin
        Result := not Item[I].IsEqual(Nodes[I]);
        if Result then Break;
      end
    end;
  end;
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
end;

procedure TtcTreeNodes.ReadData(Stream: TStream);
var
  I, Count: integer;
  Info: TNodeInfo;
begin
  Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  for I := 0 to Count - 1 do Add(nil, '').ReadData(Stream, @Info);
end;

procedure TtcTreeNodes.WriteData(Stream: TStream);
var
  I: integer;
  Node: TtcTreeNode;
  Info: TNodeInfo;
begin
  I := 0;
  Node := GetFirstNode;
  while Node <> nil do begin
    Inc(I);
    Node := Node.GetNextSibling;
  end;
  Stream.WriteBuffer(I, SizeOf(I));
  Node := GetFirstNode;
  while Node <> nil do begin
    Node.WriteData(Stream, @Info);
    Node := Node.GetNextSibling;
  end;
end;

function TtcTreeNodes.HashValue(const St: string): longint;
begin
  Result := GetStrCRC32(St);
end;

function TtcTreeNodes.LocateHashIndex(const Path: string): integer;
var
  wHash: longint;
  wData: TrmHashData;
  First, Middle, Last, Temp: longint;
  wFound: boolean;
begin
  wHash := HashValue(Path);

  Result := -1;
  First := 0;
  Last := FHashList.Count - 1;
  wFound := false;
  middle := Round((last + First) / 2);

  while (not wFound) and (First <= last) do begin
    middle := Round((last + First) / 2);
    wData  := TrmHashData(fHashlist[middle]);

    if wHash = wData.hash then wFound := true
    else begin
      if wHash < wData.hash then last := middle - 1
      else First := middle + 1;
    end;
  end;

  if wFound then begin
    Temp := middle;

    while (Middle > 0) and (Middle - 1 >= First) and (TrmHashData(FHashList[middle - 1]).Hash = wHash) do Dec(Middle);

    while (Result = -1) and (Middle < FHashList.Count) and (Middle + 1 < Last) and
      (TrmHashData(FHashList[middle + 1]).Hash = wHash) do begin
      wData := TrmHashData(FHashList[middle]);
      if (Owner.NodePath(wData.Node) = Path) then Result := middle
      else Inc(Middle);
    end;

    if Result = -1 then Result := Temp;
  end;
end;

procedure TtcTreeNodes.BinaryInsert(const Path: string; Node: TtcTreeNode);
var
  wHash: longint;
  wLen: integer;
  wData: TrmHashData;
  First, Middle, Last: longint;
  wFound: boolean;
begin
  wHash := HashValue(Path);
  wLen := Length(Path);

  First := 0;
  Last := FHashList.Count - 1;
  wFound := false;

  while (not wFound) and (First <= last) do begin
    middle := Round((last + First) / 2);
    wData  := TrmHashData(fHashlist[middle]);

    if wHash = wData.hash then wFound := true
    else begin
      if wHash < wData.hash then last := middle - 1
      else First := middle + 1;
    end;
  end;

  if wFound then begin
    middle := Round((last + First) / 2);
    wFound := false;

    while (Middle > 0) and (Middle - 1 >= First) and (TrmHashData(FHashList[middle - 1]).Hash = wHash) do Dec(Middle);

    while (not wfound) and (Middle < FHashList.Count) and (Middle + 1 < Last) and
      (TrmHashData(FHashList[middle + 1]).Hash = wHash) do begin
      wData := TrmHashData(FHashList[middle]);
      if (Owner.NodePath(wData.Node) = Path) then wFound := true
      else Inc(Middle);
    end;
    if not wFound then First := middle;
  end;

  if not wfound then begin
    wData          := TrmHashData.Create;
    wData.Hash     := wHash;
    wData.IDLength := wLen;
    wData.Node     := Node;
    fHashList.Insert(First, wData);
    Node.HasBeenHashed := true;
  end;
end;

function TtcTreeNodes.LocateNode(const Path: string): TtcTreeNode;
var
  wIndex: integer;
begin
  wIndex := LocateHashIndex(Path);
  if wIndex = -1 then Result := nil
  else Result := TrmHashData(FHashList[wIndex]).Node;
end;

procedure TtcTreeNodes.RemoveHash(const Node: TtcTreeNode);
var
  wIndex: integer;
begin
  wIndex := LocateHashIndex(Owner.NodePath(Node));
  if wIndex > -1 then begin
    FHashList.Delete(wIndex);
    Node.HasBeenHashed := false;
  end;
end;

procedure TtcTreeNodes.dumphash;
var
  fstr: TextFile;
  loop: integer;
  wdata: trmhashdata;
begin
  AssignFile(fstr, '\nvhash.txt');
  Rewrite(fstr);
  for loop := 0 to fhashlist.Count - 1 do begin
    wData := Trmhashdata(fhashlist[loop]);
    Writeln(fstr, Owner.nodepath(wdata.node));
  end;
  CloseFile(fstr);
end;

{ TtcCustomTree }

constructor TtcCustomTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  IsLoading := false;
  FSepChar := '.';
  FTreeNodes := TtcTreeNodes.Create(Self);
end;

destructor TtcCustomTree.Destroy;
begin
  FreeandNil(FTreeNodes);
  FreeandNil(FMemStream);
  inherited Destroy;
end;

procedure TtcCustomTree.SettcTreeNodes(Value: TtcTreeNodes);
begin
  Items.Assign(Value);
end;

procedure TtcCustomTree.Delete(Const Node: TtcTreeNode);
begin
  if Assigned(FOnDeletion) then FOnDeletion(Self, Node);
end;

function TtcCustomTree.CreateNode: TtcTreeNode;
begin
  Result := TtcTreeNode.Create(Items);
end;

procedure TtcCustomTree.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    FreeandNil(Stream);
  end;
end;

procedure TtcCustomTree.LoadFromStream(Stream: TStream);
begin
end;

procedure TtcCustomTree.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    FreeandNil(Stream);
  end;
end;

procedure TtcCustomTree.SaveToStream(Stream: TStream);
var
  N: TtcTreeNode;
  L: TStringList;
begin
  L := TStringList.Create;
  try
    N := Items.GetFirstNode;
    while N <> nil do begin
      L.Add(NodePath(N));
      N := N.GetNext;
    end;
    L.SaveToStream(Stream);
  finally
    FreeandNil(L);
  end;
end;

function TtcCustomTree.NodePath(Node: TtcTreeNode): string;
var
  Temp: string;
begin
  Temp := '';

  while Node <> nil do begin
    Temp := FSepChar + Node.Text + Temp;
    Node := Node.Parent;
  end;
  Result := Temp;
end;

function TtcTreeNode.GetItemCount: integer;
var
  Idx: integer;
begin
  Result := FChildList.Count;
  for Idx := 0 to FChildList.Count - 1 do begin
    Result := Result + TtcTreeNode(FChildList[Idx]).ItemCount;
  end;
end;

procedure TtcCustomTree.TextSort(ParentNode: TtcTreeNode; Recursive: boolean);
var
  Child: TtcTreeNode;
  WList, woList: TList;
  index: integer;
  found: boolean;
begin
  if ParentNode = nil then Child := FTreeNodes.GetFirstNode
  else Child := ParentNode.GetFirstChild;

  if Assigned(child) then begin
    if child.Parent = nil then woList := FTreeNodes.frootnodelist
    else woList := child.Parent.FChildList;

    wList := TList.Create;
    try
      while woList.Count > 0 do begin
        wList.add(woList[0]);
        woList.Delete(0);
      end;

      if Recursive then TextSort(TtcTreeNode(wList[0]), recursive);

      woList.add(wList[0]);
      wList.Delete(0);
      while wList.Count > 0 do begin
        if Recursive then TextSort(TtcTreeNode(wList[0]), recursive);

        index := 0;
        found := false;
        while index < woList.Count do begin
          if TtcTreeNode(wList[0]).FText > TtcTreeNode(woList[index]).fText then Inc(index)
          else begin
            woList.Insert(index, wList[0]);
            wList.Delete(0);
            found := true;
            Break;
          end;
        end;
        if not found then begin
          woList.add(wList[0]);
          wList.Delete(0);
        end;
      end;
    finally
      FreeandNil(wList);
    end;
  end;
end;

function TtcCustomTree.FindPathNode(const Path: string): TtcTreeNode;
begin
  Result := Items.LocateNode(Path);
end;

function TtcCustomTree.Node(const Path: string): TtcTreeNode;
begin
  Result := Items.LocateNode(Path);
  if Result = nil then Result := self.AddPathNode(nil, Path);
end;

function TtcCustomTree.NodeExists(const Path: string): boolean;
begin
  Result := (self.FindPathNode(Path) <> nil);
end;

function TtcCustomTree.AddPathNode(Node: TtcTreeNode; Path: string): TtcTreeNode;
var
  wNode, wParent, wChild: TtcTreeNode;
  wPName, wCName: string;
begin
  Result := nil;
  if path = '' then Exit;

  if path[1] = sepchar then path := NodePath(Node) + path
  else path := nodepath(node) + sepchar + path;

  wNode := Items.LocateNode(Path);
  if wNode = nil then begin
    wPName := ParentName(Path);
    wCName := ChildName(Path);

    if (wPName = '') and (wCName = '') then Exit;

    wParent := Items.LocateNode(wPName);
    if wParent = nil then wParent := AddPathNode(nil, wPname);
    wChild := Items.AddChild(wParent, wCName);
    Result := wChild;
  end else Result := wNode;
end;

function TtcCustomTree.ParentName(s: string): string;
var
  wLen: integer;
begin
  wLen := Length(s);
  if s[wLen] = SepChar then begin
    system.Delete(s, wLen, 1);
    Dec(wLen);
  end;
  while (wlen > 0) and (s[wLen] <> sepchar) do begin
    system.Delete(s, wLen, 1);
    Dec(wLen);
  end;
  if (wLen > 0) and (s[wLen] = SepChar) then system.Delete(s, wLen, 1);
  Result := s;
end;

function TtcCustomTree.ChildName(s: string): string;
var
  wLen: integer;
begin
  wLen := Length(s);
  if s[wLen] = SepChar then begin
    system.Delete(s, wLen, 1);
    Dec(wLen);
  end;
  while (wLen > 0) and (s[wLen] <> sepchar) do Dec(wLen);
  system.Delete(s, 1, wLen);
  Result := s;
end;

procedure TtcTreeNode.RemoveHash;
var
  wNode: TtcTreeNode;
begin
  FOwner.RemoveHash(self);
  wNode := getFirstChild;
  while wNode <> nil do begin
    wNode.RemoveHash;
    wNode := wNode.getNextSibling;
  end;
end;

procedure TtcTreeNode.RenewHash;
var
  wNode: TtcTreeNode;
begin
  FOwner.BinaryInsert(FOwner.Owner.NodePath(self), self);
  wNode := getFirstChild;
  while wNode <> nil do begin
    wNode.RenewHash;
    wNode := wNode.getNextSibling;
  end;
end;

function TtcTreeNode.GetNodePath: string;
begin
  Result := Tree.NodePath(self);
end;

function TtcTreeNode.GetAsBoolean: boolean;
begin
  if (uppercase(Value) = 'TRUE') or (uppercase(Value) = 'T') then Result := true
  else Result := false;
end;

function TtcTreeNode.GetAsDateTime: TDateTime;
begin
  if Value = '' then Result := 0.0
  else Result := StrToDateTime(Value);
end;

function TtcTreeNode.GetAsFloat: double;
begin
  if Value <> '' then begin
    try
      Result := StrToFloat(Value);
    except
      Result := 0;
    end;
  end else Result := 0;
end;

function TtcTreeNode.GetAsInteger: integer;
begin
  if Value <> '' then begin
    try
      Result := FastFuncs.StrToInt(Value);
    except
      Result := 0;
    end;
  end else Result := 0;
end;

function TtcTreeNode.GetAsString: string;
begin
  Result := Value;
end;

procedure TtcTreeNode.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value := 'True'
  else Value           := 'False';
end;

procedure TtcTreeNode.SetAsDateTime(const aValue: TDateTime);
begin
  Value := FormatDateTime('dd/mm/yyyy hh:nn:ss', aValue);
end;

procedure TtcTreeNode.SetAsFloat(const aValue: double);
begin
  Value := FloatToStr(aValue);
end;

procedure TtcTreeNode.SetAsInteger(const aValue: integer);
begin
  Value := FastFuncs.IntToStr(aValue);
end;

procedure TtcTreeNode.SetAsString(const aValue: string);
begin
  Value := aValue;
end;

procedure TtcTreeNode.SetValue(const Value: string);
begin
  FValue := Value;
  if (not Tree.IsLoading) and Assigned(Tree.OnNodeValueChanged) then Tree.OnNodeValueChanged(Tree, self);
end;

function TtcTreeNode.Node(const Path: string): TtcTreeNode;
begin
  Result := nil;
  if Assigned(Tree) then begin
    Result := Tree.Items.LocateNode(self.NodePath + Tree.SepChar + Path);
    if (Result = nil) then begin
      Result := Tree.AddPathNode(nil, self.NodePath + Tree.SepChar + Path);
      if (not Tree.IsLoading) and Assigned(Tree.OnNodeValueChanged) then Tree.OnNodeValueChanged(Tree, self);
    end;
  end;
end;

function TtcTreeNode.NodeExists(const Path: string): boolean;
begin
  Result := Tree.NodeExists(self.NodePath + Tree.SepChar + Path);
end;

function TtcCustomTree.GetXMLText: string;
var
  x: integer;

  procedure TraverseNodes(aNode: TtcTreeNode);
  var 
    x: integer;
  begin
    Result := Result + '<' + aNode.Text + '>' + aNode.Value;
    for x := 0 to aNode.Count - 1 do begin
      TraverseNodes(aNode.Item[x]);
    end;
    Result := Result + '</' + aNode.Text + '>';
  end;
begin
  self.TextSort(nil, true);
  Result := '<?xml version="1.0" encoding="UTF-8" ?><Data>';
  for x := 0 to Self.Items.Count - 1 do begin
    if Self.Items[x].Parent = nil then TraverseNodes(Self.Items[x]);
  end;
  Result := Result + '</Data>';
end;

procedure TtcCustomTree.SetXMLText(const aValue: string);
var
  Str, NodeName, NodeValue: string;
  IsNodeStart, IsNodeEnd: boolean;
  x, Pos1: integer;
  List: TStringList;

  function GetPathStr: string;
  var 
    idx: integer;
  begin
    Result := '';
    for idx := 0 to List.Count - 1 do begin
      if Result <> '' then Result := Result + FSepChar;
      Result := Result + List[idx];
    end;
  end;
begin
  self.Items.Clear;
  if aValue = '' then Exit;
  List := TStringList.Create;
  try
    isLoading := true;
    Str       := FastFuncs.Trim(aValue);
    Pos1      := FastFuncs.PosEx('<Data>', Str);
    if Pos1 < 1 then begin
      tcTreeError('Invalid XML data, root Data node not found.');
    end;
    Str         := Copy(Str, Pos1 + 6, Length(Str));
    Str         := Copy(Str, 1, Length(Str) - 7);
    NodeName    := '';
    NodeValue   := '';
    IsNodeStart := false;
    IsNodeEnd   := false;
    for x := 1 to Length(Str) do begin
      if Str[x] = '<' then begin
        IsNodeStart := true;
        if (NodeName <> '') and (List.Count > 0) then begin
          self.AddPathNode(nil, GetPathStr).Value := NodeValue;
        end;
        NodeValue := '';
        NodeName := '';
      end else if Str[x] = '>' then begin
        if IsNodeStart then begin
          IsNodeStart := false;
          if NodeName <> '' then begin
            List.Add(NodeName);
          end;
          NodeValue := '';
        end else if IsNodeEnd then begin
          if List.Count = 0 then begin
            tcTreeError('Invalid XML data, node end with no beginning.');
          end else if List[List.Count - 1] <> NodeName then begin
            tcTreeError('Invalid XML data, node end does not match beginning.');
          end else begin
            List.Delete(List.Count - 1);
            IsNodeEnd := false;
            NodeName := '';
          end;
        end;
      end else if Str[x] = '/' then begin
        if IsNodeStart then begin
          IsNodeStart := false;
          IsNodeEnd := true;
        end else begin
          NodeValue := NodeValue + Str[x];
        end;
      end else begin
        if IsNodeStart then begin
          NodeName := NodeName + Str[x];
        end else if IsNodeEnd then begin
          NodeName := NodeName + Str[x];
        end else begin
          NodeValue := NodeValue + Str[x];
        end;
      end;
    end;
  finally
    FreeandNil(List);
    IsLoading := false;
  end;
end;

procedure TtcCustomTree.LoadXMLFromFile(const FileName: string);
var 
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    IsLoading := true;
    SL.LoadFromFile(FileName);
    self.XMLText := SL.Text;
  finally
    IsLoading := false;
    FreeandNil(SL);
  end;
end;

procedure TtcCustomTree.SaveXMLToFile(const FileName: string);
var 
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text := self.XMLText;
    SL.SaveToFile(FileName);
  finally
    FreeandNil(SL);
  end;
end;

function TtcTreeNode.Add(const S: string): TtcTreeNode;
begin
  Result := nil;
  if Assigned(Tree) then begin
    Result := Tree.FindPathNode(self.NodePath + Tree.SepChar + S);
    if not Assigned(Result) then begin
      Result := Tree.AddPathNode(nil, self.NodePath + Tree.SepChar + S);
      if (not Tree.IsLoading) and Assigned(Tree.OnNodeValueChanged) then Tree.OnNodeValueChanged(Tree, self);
    end;
  end;    
end;

initialization
  fcrctable := crc32gen;

finalization
end.


