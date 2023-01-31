unit NodePropertiesLink;

interface

uses
  TypInfo, Classes, SysUtils, Controls, StdCtrls, wwradiogroup, wwdblook,
  wwcheckbox, AdvEdit, MyAccess,ERPdbComponents, BusObjProcess, db;

type
  TPropControlMapRec = record
    Name: string;
    Control: string;
    Value: string;
  end;

  TPropControlItems = array of TPropControlMapRec;

  TChangeEvent = procedure(const Sender: TObject; const BaseNode: TProcTreeNode; const NodeName, PropName, PropValue: string) of object;
  TGetPropValue = function(const Sender: TObject; const BaseNode: TProcTreeNode; const Nodename, PropName: string): string of object;

  TNodeProperties = class;

  TNodePropertiesList = class(TObject)
  private
    FName: string;
    FOnChange: TChangeEvent;
    FGetPropValue: TGetPropValue;
    FBaseTreeNode: TProcTreeNode;
    FNodePropList: TList;
    function GetNodePropsCount: Integer;
    function GetNodeProps(ListIndex: Integer): TNodeProperties;
    procedure SetBaseTreeNode(const Value: TProcTreeNode);
  public
    constructor Create(const Name: string; ChangeLink: TChangeEvent; GetLink: TGetPropValue);
    destructor Destroy; override;
    procedure DeleteNodeProp(const Index: Integer);
    property BaseTreeNode: TProcTreeNode read FBaseTreeNode write SetBaseTreeNode;
    property NodePropsCount: Integer read GetNodePropsCount;
    property NodeProps[ListIndex: Integer]: TNodeProperties read GetNodeProps; default;
  end;

  TNodePropertiesLink = class(TComponent)
  private
    FBaseTreeNode: TProcTreeNode;
    FLoading: Boolean;
    FCalculating: Boolean;
    FDisplayDialogs: Boolean;
    FItemType: string;
    FPropControlItems: TPropControlItems;
    FCurNodename:String;
    procedure SetItemType(const Value: string);
    procedure CreatePropertyObjects;
    procedure FreePropertyObjects;
    procedure SetBaseTreeNode(const Value: TProcTreeNode);
    procedure OnChangeHandler(const Sender: TObject; const BaseNode: TProcTreeNode; const NodeName, PropName, PropValue: string);
    function GetPropValue(const Sender: TObject; const BaseNode: TProcTreeNode; const NodeName, PropName: string): string;
    procedure LoadPropControlItems;
    function GetDefaultValue(const PropName: string): string;
    function CreateNewNode(const NodeName: string; const BaseTreeNode: TProcTreeNode): TProcTreeNode;
    function GetNode(const NodeName: string): TProcTreeNode;
  protected
    procedure AssignItemType; virtual; abstract;
    Property  CurNodename : String Read FCurNodename Write FCurNodename;

    function  InchTomm(Value:Double):Double;
    function  InchTom(Value:Double):Double;
    function  sqmtolmtr(Value:Double; width :double):Double;
    function  lmtrtosqm(Value:Double; width :double):Double;
    function  mmtoInch(Value:Double):Double;
    function  fttomm(Value:Double):Double;
    function  mmtoft(Value:Double):Double;
    Function getNewDataset(const s:STring):Tdataset;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PerformCalculations; virtual; abstract;
    function CalcSummaryCost: Double;
    function GetTotalCost: Double; virtual;
    procedure RefreshListNodes;
    property BaseTreeNode: TProcTreeNode read FBaseTreeNode write SetBaseTreeNode;
    property Loading: Boolean read FLoading write FLoading;
    property Calculating: Boolean read FCalculating write FCalculating;
    property DisplayDialogs: Boolean read FDisplayDialogs write FDisplayDialogs;
    property ItemType: string read FItemType write SetItemType;
    property PropControlItems: TPropControlItems read FPropControlItems write FPropControlItems;
  end;

  TNodeProperties = class(TPersistent)
  private
    FName: string;
    FBaseTreeNode: TProcTreeNode;
    FOnChange: TChangeEvent;
    FGetPropValue: TGetPropValue;
    FControlLink: TControl;
    function GetCaption: string;
    procedure SetCaption(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetValue: string;
    procedure SetValue(const Value: string);
    function GetCost: Double;
    procedure SetCost(const Value: Double);
    function GetPrice: Double;
    procedure SetPrice(const Value: Double);
    function GetDetails: string;
    procedure SetDetails(const Value: string);
    procedure CallOnChangeHandler(const NodeName, PropName, PropValue: string);
    function CallGetPropValue(const NodeName, PropName: string): string;
    procedure SetControlText(const Value: string);
  public
    constructor Create(const Name: string; ChangeLink: TChangeEvent; GetLink: TGetPropValue);
    property OnChange: TChangeEvent read FOnChange write FOnChange;
    property ControlLink: TControl read FControlLink write FControlLink;
    property BaseTreeNode: TProcTreeNode read FBaseTreeNode write FBaseTreeNode;
  published
    property Caption: string read GetCaption write SetCaption;
    property Description: string read GetDescription write SetDescription;
    property Value: string read GetValue write SetValue;
    property Cost: Double read GetCost write SetCost;
    property Price: Double read GetPrice write SetPrice;
    property Details: string read GetDetails write SetDetails;
  end;

implementation

uses
  CommonDbLib, FastFuncs;

{ TNodePropertiesList }

constructor TNodePropertiesList.Create(const Name: string; ChangeLink: TChangeEvent; GetLink: TGetPropValue);
begin
  inherited Create;
  FName := Name;
  FOnChange := ChangeLink;
  FGetPropValue := GetLink;
  FBaseTreeNode := nil;
  FNodePropList := TList.Create;
end;

procedure TNodePropertiesList.DeleteNodeProp(const Index: Integer);
begin
  if (Index >= 0) and (Index < FNodePropList.Count) then begin
    TNodeProperties(FNodePropList[Index]).Free;
    FNodePropList.Delete(Index);

    if Index < BaseTreeNode.Children.Count then begin
      BaseTreeNode.Children[Index].Delete;
      BaseTreeNode.Children[Index].Free;
    end;  
  end;
end;

destructor TNodePropertiesList.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to FNodePropList.Count - 1 do
    TNodeProperties(FNodePropList[Index]).Free;
    
  FreeAndNil(FNodePropList);
  inherited;
end;

function TNodePropertiesList.GetNodeProps(ListIndex: Integer): TNodeProperties;
var
  Index: Integer;
  Count: Integer;
  NodeName: string;
  NodeProp: TNodeProperties;
begin
  Result := nil;

  if Assigned(BaseTreeNode) and (ListIndex >= 0) then begin
    Count := FNodePropList.Count;

    if ListIndex >= Count then begin
      for Index := Count to ListIndex do begin
        NodeName := FName + '.Row' + IntToStr(Index + 1);
        NodeProp := TNodeProperties.Create(NodeName, FOnChange, FGetPropValue);
        NodeProp.BaseTreeNode := BaseTreeNode;
        FNodePropList.Add(NodeProp);
      end;
    end;

    Result := TNodeProperties(FNodePropList[ListIndex]);
  end;
end;

function TNodePropertiesList.GetNodePropsCount: Integer;
begin
  Result := FNodePropList.Count;
end;

procedure TNodePropertiesList.SetBaseTreeNode(const Value: TProcTreeNode);
var
  Index: Integer;
  NodeName: string;
  NodeProp: TNodeProperties;
begin
  if Value <> BaseTreeNode then begin
    FBaseTreeNode := Value;

    if Assigned(FBaseTreeNode) then begin
      for Index := 0 to FBaseTreeNode.Children.Count - 1 do begin
        if FNodePropList.Count <= Index then begin
          NodeName := FName + '.Row' + IntToStr(Index + 1);
          NodeProp :=  TNodeProperties.Create(NodeName, FOnChange, FGetPropValue);
          NodeProp.BaseTreeNode := FBaseTreeNode;
          NodeProp.Value :=  TProcTreeNode(FBaseTreeNode.Children[Index]).Value;
          FNodePropList.Add(NodeProp);
        end
        else begin
          NodeProp := TNodeProperties(FNodePropList[Index]);
          NodeProp.BaseTreeNode := FBaseTreeNode;
          NodeProp.Value :=  TProcTreeNode(FBaseTreeNode.Children[Index]).Value;
        end;
      end;
    end;
  end;
end;

{ TNodeProperties }

function TNodeProperties.CallGetPropValue(const NodeName, PropName: string): string;
begin
  if Assigned(FGetPropValue) then
    Result := FGetPropValue(Self, FBaseTreeNode, NodeName, PropName)
  else
    Result := '';
end;

procedure TNodeProperties.CallOnChangeHandler(const NodeName, PropName, PropValue: string);
begin
  if Assigned(FOnChange) then
    FOnChange(Self, FBaseTreeNode, NodeName, PropName, PropValue);
end;

constructor TNodeProperties.Create(const Name: string; ChangeLink: TChangeEvent; GetLink: TGetPropValue);
begin
  inherited Create;
  FName := Name;
  FBaseTreeNode := nil;
  FOnChange := ChangeLink;
  FGetPropValue := GetLink;
  FControlLink := nil;
end;

function TNodeProperties.GetCaption: string;
begin
  Result := CallGetPropValue(FName, 'Caption');
end;

function TNodeProperties.GetCost: Double;
begin
  Result := StrToFloatDef(CallGetPropValue(FName, 'Cost'), 0);
end;

function TNodeProperties.GetDescription: string;
begin
  Result := CallGetPropValue(FName, 'Description');
end;

function TNodeProperties.GetDetails: string;
begin
  Result := CallGetPropValue(FName, 'Details');
end;

function TNodeProperties.GetPrice: Double;
begin
  Result := StrToFloatDef(CallGetPropValue(FName, 'Price'), 0);
end;

function TNodeProperties.GetValue: string;
begin
  Result := CallGetPropValue(FName, 'Value');
end;

procedure TNodeProperties.SetCaption(const Value: string);
begin
  CallOnChangeHandler(FName, 'Caption', Value);
end;

procedure TNodeProperties.SetControlText(const Value: string);
begin
  if Assigned(ControlLink) then begin
    if ControlLink is TwwRadioGroup then
      TwwRadioGroup(ControlLink).ItemIndex := StrToIntDef(Value, -1)
    else if ControlLink is TAdvEdit then
      TAdvEdit(ControlLink).Text := Value
    else if ControlLink is TMemo then
      TMemo(ControlLink).Lines.Text := Value
    else if ControlLink is TwwCheckBox then begin
      if Value = 'T' then
       TwwCheckBox(ControlLink).Checked := True
      else
        TwwCheckBox(ControlLink).Checked := False;
    end
    else if ControlLink is TwwDBLookupCombo then
      TwwDBLookupCombo(ControlLink).Text := Value;
  end;
end;

procedure TNodeProperties.SetCost(const Value: Double);
begin
  CallOnChangeHandler(FName, 'Cost', FloatToStr(Value));
end;

procedure TNodeProperties.SetDescription(const Value: string);
begin
  CallOnChangeHandler(FName, 'Description', Value);
end;

procedure TNodeProperties.SetDetails(const Value: string);
begin
  CallOnChangeHandler(FName, 'Details', Value);
end;

procedure TNodeProperties.SetPrice(const Value: Double);
begin
  CallOnChangeHandler(FName, 'Price', FloatToStr(Value));
end;

procedure TNodeProperties.SetValue(const Value: string);
begin
  CallOnChangeHandler(FName, 'Value', Value);
  SetControlText(Value);
end;

{ TNodePropertiesLink }

function TNodePropertiesLink.CalcSummaryCost: Double;
var
  Index: Integer;
  PropCount: Integer;
  PropList: PPropList;
  PropName: string;
  NodePropLink: TNodePropertiesLink;
begin
  Result := 0;
  PropCount := GetPropList(ClassInfo, PropList);

  try
    for Index := 0 to PropCount - 1 do begin
      PropName := string(PropList[Index].Name);

      if GetObjectProp(Self, PropName) is TNodePropertiesLink then begin
        NodePropLink := TNodePropertiesLink(GetObjectProp(Self, PropName));
        Result := Result + NodePropLink.GetTotalCost;
      end;
    end;
  finally
    FreeMem(PropList);
  end;
end;
function  TNodePropertiesLink.InchTomm(Value:Double):Double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value *25.4;
end;
function  TNodePropertiesLink.InchTom(Value:Double):Double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value *0.02540;
end;
function  TNodePropertiesLink.lmtrtosqm(Value:Double; width :double):Double;
begin
    Result := Value * width;
end;
function  TNodePropertiesLink.sqmtolmtr(Value:Double; width:Double):Double;
begin
    REsult := Value;
    if width = 0 then exit;
    Result := Value / width;
end;
function  TNodePropertiesLink.mmtoInch(Value:Double):Double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value /25.4;
end;

function  TNodePropertiesLink.fttomm(Value:Double):Double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value *304.8 ;
end;
function  TNodePropertiesLink.mmtoft(Value:Double):Double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value /304.8 ;
end;
Function TNodePropertiesLink.getNewDataset(const s:STring):Tdataset;
begin
    REsult := RetrieveDataset(s);
end;
(*function  TNodePropertiesLink.cftTocmm(Value :Double): double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value *304.8*304.8*304.8 ;
end;
function  TNodePropertiesLink.cmmToft(Value :Double): double;
begin
    if Value = 0 then REsult := 0 else
    REsult := Value /304.8/304.8/304.8 ;
end;*)
constructor TNodePropertiesLink.Create(AOwner: TComponent);
begin
  inherited;
  FBaseTreeNode := nil;
  FLoading := False;
  FCalculating := False;
  FDisplayDialogs := False;
  FItemType := '';
  FPropControlItems := nil;
  AssignItemType;
  CreatePropertyObjects;
end;

function TNodePropertiesLink.CreateNewNode(const NodeName: string; const BaseTreeNode: TProcTreeNode): TProcTreeNode;
var
  Node: TProcTreeNode;
begin
  Node := TProcTreeNode.Create(nil);
  Node.Caption := NodeName;
  BaseTreeNode.Children.Add(Node);
  Node.Dirty := False;
  BaseTreeNode.Dirty := False;
  Result := Node;
end;

procedure TNodePropertiesLink.CreatePropertyObjects;
var
  Index: Integer;
  PropCount: Integer;
  PropList: PPropList;
  PropName: string;
  NodeProp: TNodeProperties;
begin
  PropCount := GetPropList(ClassInfo, PropList);

  try
    for Index := 0 to PropCount - 1 do begin
      PropName := string(PropList[Index].Name);

      if GetObjectPropClass(Self, PropName) = TNodeProperties then begin
        NodeProp := TNodeProperties.Create(PropName, OnChangeHandler, GetPropValue);
        SetObjectProp(Self, PropName, NodeProp);
      end
      else if GetObjectPropClass(Self, PropName) = TNodePropertiesList then
        SetObjectProp(Self, PropName, TNodePropertiesList.Create(PropName, OnChangeHandler, GetPropValue));
    end;
  finally
    FreeMem(PropList);
  end;
end;

destructor TNodePropertiesLink.Destroy;
begin
  Finalize(FPropControlItems);
  FreePropertyObjects;
  inherited;
end;

procedure TNodePropertiesLink.FreePropertyObjects;
var
  Index: Integer;
  PropCount: Integer;
  PropList: PPropList;
  PropName: string;
  PropObject: TNodeProperties;
  PropListObject: TNodePropertiesList;
begin
  PropCount := GetPropList(ClassInfo, PropList);

  try
    for Index := 0 to PropCount - 1 do begin
      PropName := string(PropList[Index].Name);

      if GetObjectPropClass(Self, PropName) = TNodeProperties then begin
        PropObject := TNodeProperties(GetObjectProp(Self, PropName));
        FreeAndNil(PropObject);
      end
      else if GetObjectPropClass(Self, PropName) = TNodePropertiesList then begin
        PropListObject := TNodePropertiesList(GetObjectProp(Self, PropName));
        FreeAndNil(PropListObject);
      end;
    end;
  finally
    FreeMem(PropList);
  end;
end;

function TNodePropertiesLink.GetDefaultValue(const PropName: string): string;
var
  Index: Integer;
  FoundMatch: Boolean;
  TmpName: string;
  SuffixPos: Integer;
begin
  Result := '';
  FoundMatch := False;
  SuffixPos := FastFuncs.PosEx('.', PropName);
  Index := Low(FPropControlItems);

  if SuffixPos > 0 then
    TmpName := FastFuncs.LeftStr(PropName, SuffixPos - 1)
  else
    TmpName := PropName;

  while (Index <= High(FPropControlItems)) and (not FoundMatch) do begin
    if Sysutils.SameText(FPropControlItems[Index].Name, TmpName) then begin
      Result := FPropControlItems[Index].Value;
      FoundMatch := True;
    end
    else
      Inc(Index);
  end;
end;

function TNodePropertiesLink.GetNode(const NodeName: string): TProcTreeNode;
begin
  Result := nil;

  if Assigned(FBaseTreeNode) then begin
    Result := FBaseTreeNode.GetChildNode(NodeName);

    if not Assigned(Result) then
      Result := CreateNewNode(NodeName, FBaseTreeNode);
  end;
end;

function TNodePropertiesLink.GetPropValue(const Sender: TObject; const BaseNode: TProcTreeNode; const NodeName, PropName: string): string;
var
  Node: TProcTreeNode;
begin
  Result := '';

  if Assigned(BaseNode) then begin
    Node := BaseNode.GetChildNode(NodeName);

    if not Assigned(Node) then begin
      Node := TProcTreeNode.Create(nil);
      Node.Caption := NodeName;

      if Sysutils.SameText(PropName, 'Value') then
        SetStrProp(Node, PropName, GetDefaultValue(NodeName));

      BaseNode.Children.Add(Node);
      Node.Dirty := False;
      BaseTreeNode.Dirty := False;
    end;

    if PropType(Node, PropName) = tkFloat then
      Result := FloatToStr(GetFloatProp(Node, PropName))
    else
      Result := GetStrProp(Node, PropName);
  end;
end;

function TNodePropertiesLink.GetTotalCost: Double;
begin
  Result := 0;
  PerformCalculations;
end;

procedure TNodePropertiesLink.LoadPropControlItems;
var
  Index: Integer;
  qryLoad: TERPQuery;
begin
  Index := 0;
  qryLoad := TERPQuery.Create(nil);

  try
    qryLoad.Connection := GetSharedMyDacConnection;
    qryLoad.SQL.Text := 'SELECT * FROM tblpropcontrolitems WHERE ItemType = ' +
                        QuotedStr(ItemType) + ' ORDER BY Sequence' ;
    qryLoad.Open;
    qryLoad.First;
    Setlength(FPropControlItems, qryLoad.RecordCount);

    while not qryLoad.Eof do begin
      FPropControlItems[Index].Name := qryLoad.FieldByName('PropName').AsString;
      FPropControlItems[Index].Control := qryLoad.FieldByName('ControlName').AsString;
      FPropControlItems[Index].Value := qryLoad.FieldByName('DefaultValue').AsString;
      qryLoad.Next;
      Inc(Index);
    end;

    qryLoad.Close;
  finally
    FreeAndNil(qryLoad);
  end;
end;

procedure TNodePropertiesLink.OnChangeHandler(const Sender: TObject; const BaseNode: TProcTreeNode; const NodeName, PropName, PropValue: string);
var
  Node: TProcTreeNode;
begin
  if Assigned(BaseNode) then begin
    Node := BaseNode.GetChildNode(NodeName);

    if not Assigned(Node) then
      Node := CreateNewNode(NodeName, BaseNode);

    if PropType(Node, PropName) = tkFloat then
      SetFloatProp(Node, PropName, StrToFloatDef(PropValue, 0))
    else
      SetStrProp(Node, PropName, PropValue);

    if Loading then
      Node.Dirty := False
    else if not Calculating then begin
      Calculating := True;

      try
        CurNodename := NodeName;
        PerformCalculations;
      finally
        Calculating := False;
      end;
    end;
  end;
end;

procedure TNodePropertiesLink.RefreshListNodes;
var
  Index: Integer;
  PropCount: Integer;
  PropList: PPropList;
  PropName: string;
  NodePropList: TNodePropertiesList;
begin
  if Assigned(FBaseTreeNode) then begin
    PropCount := GetPropList(ClassInfo, PropList);
    Loading := True;

    try
      for Index := 0 to PropCount - 1 do begin
        PropName := string(PropList[Index].Name);

        if GetObjectPropClass(Self, PropName) = TNodePropertiesList then begin
          NodePropList := TNodePropertiesList(GetObjectProp(Self, PropName));
          NodePropList.BaseTreeNode := GetNode(PropName);
        end;
      end;
    finally
      Loading := False;
      FreeMem(PropList);
    end;
  end;
end;

procedure TNodePropertiesLink.SetBaseTreeNode(const Value: TProcTreeNode);
var
  Index: Integer;
  PropCount: Integer;
  PropList: PPropList;
  PropName: string;
  NodeProp: TNodeProperties;
  PropLink: TNodePropertiesLink;
  NodePropList: TNodePropertiesList;
begin
  if Value <> FBaseTreeNode then begin
    FBaseTreeNode := Value;

    if Assigned(FBaseTreeNode) then begin
      FBaseTreeNode.Children.Clear;
      FBaseTreeNode.LoadTree(True);
      PropCount := GetPropList(ClassInfo, PropList);

      try
        for Index := 0 to PropCount - 1 do begin
          PropName := String(PropList[Index].Name);

          if GetObjectPropClass(Self, PropName) = TNodeProperties then begin
            NodeProp := TNodeProperties(GetObjectProp(Self, PropName));
            NodeProp.BaseTreeNode := FBaseTreeNode;
          end
          else if GetObjectProp(Self, PropName) is TNodePropertiesLink then begin
            PropLink := TNodePropertiesLink(GetObjectProp(Self, PropName));
            PropLink.Loading := True;
            PropLink.BaseTreeNode := GetNode(PropName);
            PropLink.Loading := False;
          end
          else if GetObjectPropClass(Self, PropName) = TNodePropertiesList then begin
            NodePropList := TNodePropertiesList(GetObjectProp(Self, PropName));
            NodePropList.BaseTreeNode := GetNode(PropName);
          end;
        end;
      finally
        FreeMem(PropList);
      end;
    end;
  end;
end;

procedure TNodePropertiesLink.SetItemType(const Value: string);
begin
  if Value <> FItemType then begin
    FItemType := Value;

    if FItemType <> '' then
      LoadPropControlItems;
  end;
end;

end.
