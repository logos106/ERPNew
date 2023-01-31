unit PanelTreeObj;

interface

uses
  Forms, Controls, Classes, ExtCtrls, ConTnrs, JsonObject, fraTreeFrameBase;

type
  TTreePanelNode = class;

  TFrameClass = class of TFrame;

  TPanelTree = class(TScrollBox)
  private
    function GetDirty: boolean;
  published
  public
    constructor Create (aOwner: TComponent); override;
    function AddNode(aFrameClass: TfrTreeFrameBaseClass; NodeData: TJsonObject; aParentNode: TTreePanelNode = nil): TTreePanelNode;
    property Dirty: boolean read GetDirty;
    procedure Clear;
  end;

  TTreePanelNode = class(TCustomControl)
  var
    fPaintBox: TPaintBox;
  private
    FParentNode: TTreePanelNode;
    FExpanded: boolean;
    fFrame: TfrTreeFrameBase;
    function GetIndent: integer;
    procedure SetExpanded(const Value: boolean);
    procedure SetParentNode(const Value: TTreePanelNode);
  protected
    procedure Paint; override;
  public
    ChildNodes: TObjectList;
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
    property Expanded: boolean read FExpanded write SetExpanded;
    property ParentNode: TTreePanelNode read FParentNode write SetParentNode;
    property Indent: integer read GetIndent;
    property Expander: TPaintBox read fPaintBox;
    property Frame: TfrTreeFrameBase read fFrame write fFrame;
  end;

implementation

{ TPanelTree }

function TPanelTree.AddNode(aFrameClass: TfrTreeFrameBaseClass; NodeData: TJsonObject;
  aParentNode: TTreePanelNode): TTreePanelNode;
var
  NewNode: TTreePanelNode;
  NewFrame: TfrTreeFrameBase;
  y: integer;
  x: integer;
  MaxWidth: integer;
begin
  MaxWidth:= 0;
  NewNode := TTreePanelNode.Create(self);
  NewFrame := aFrameClass.Create(NewNode);
  NewNode.Frame := NewFrame;
  NewFrame.Parent := NewNode;
  NewNode.Height := NewFrame.Height;
  NewFrame.Align := alClient;
  NewFrame.TreeNode := NewNode;
  if Assigned(aParentNode) then begin
    NewNode.ParentNode := aParentNode;
    aParentNode.ChildNodes.Add(NewNode);
  end;

  NewNode.Expander.Width := NewNode.Indent * 15;
  NewNode.Width := NewNode.Expander.Width + NewFrame.Width;

  NewNode.Left := 0;
  if self.ControlCount = 0 then begin
    NewNode.Top := 0;
  end
  else begin
    y := 0;
    for x := 0 to self.ControlCount -1 do begin
      y:= y + self.Controls[x].Height;
      if self.Controls[x].Width > MaxWidth then
        MaxWidth := self.Controls[x].Width;
    end;
    NewNode.Top := y;
    for x := 0 to self.ControlCount -1 do
      self.Controls[x].Width := MAxWidth;
  end;
  NewNode.Parent := self;
  NewFrame.Data := NodeData;
  result := NewNode;
end;

procedure TPanelTree.Clear;
begin
  while self.ComponentCount > 0 do
    self.Components[0].Free;
end;

constructor TPanelTree.Create(aOwner: TComponent);
begin
  inherited;
  self.VertScrollBar.Tracking := true;
end;

function TPanelTree.GetDirty: boolean;
var
  x: integer;
begin
  result := false;
  for x := 0 to self.ControlCount -1 do begin
    if Controls[x] is TTreePanelNode then begin
      if TTreePanelNode(Controls[x]).Frame.Bindings.Dirty then begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{ TTreePanelNode }

constructor TTreePanelNode.Create(aOwner: TComponent);
begin
  inherited;
  ChildNodes := TObjectList.Create(false);
  fExpanded:= true;
  fPaintBox := TPaintBox.Create(self);
  fPaintBox.Width:= self.Indent * 15;
  fPaintBox.Parent:= self;
  fPaintBox.Align := alLeft;
end;

destructor TTreePanelNode.Destroy;
begin

  inherited;
end;

function TTreePanelNode.GetIndent: integer;
var
  obj: TTreePanelNode;
begin
  result := 1;
  obj := self;
  while Assigned(obj.ParentNode) do begin
    Inc(result);
    obj := obj.ParentNode;
  end;
end;

procedure TTreePanelNode.Paint;
begin
  inherited;
end;

procedure TTreePanelNode.SetExpanded(const Value: boolean);
begin
  FExpanded := Value;
end;

procedure TTreePanelNode.SetParentNode(const Value: TTreePanelNode);
begin
  FParentNode := Value;
end;

end.
