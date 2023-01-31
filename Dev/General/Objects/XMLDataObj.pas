unit XMLDataObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // ??/??/05  1.00.00 IJB  Initial version.
  // 27/06/05  1.00.00 IJB  Added AsString, AsFloat etc props to TXMLDataNode.

interface

uses
  SysUtils, Classes, XMLDoc, XMLIntf, xmldom, msxmldom;

type
  TXMLDataNode          = class;
  TXMLDataNodeAttribute = class(TObject)
  private
    DocNode: IXMLNode;
    AttributeName: string;
    fOnDataChange: TNotifyEvent;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: double);
    procedure SetAsInteger(const Value: integer);
  public
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    function Exists: boolean;
    procedure Delete;
    property OnDataChange: TNotifyEvent read fOnDataChange write fOnDataChange;
  end;

  TXMLData     = class;
  TXMLDataNode = class(TObject)
  private
    fXMLData: TXMLData;
    fXMLDataNodeAttribute: TXMLDataNodeAttribute;
    DocNode: IXMLNode;
    fOnDataChange: TNotifyEvent;
    function GetAttribute(const ValueName: string): TXMLDataNodeAttribute;
    function GetNodeName: string;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: double);
    procedure DoAttributeDataChange(Sender: TObject);
    //procedure SetNodeName(const Value: string);
  public
    constructor Create(Owner: TXMLData);
    destructor Destroy; override;
    property Attribute[const ValueName: string]: TXMLDataNodeAttribute read GetAttribute;
    property Att[const ValueName: string]: TXMLDataNodeAttribute read GetAttribute;
    property NodeName: string read GetNodeName; // write SetNodeName;
    property AsString: string read GetAsString write SetAsString;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property OnDataChange: TNotifyEvent read fOnDataChange write fOnDataChange;
    property XMLData: TXMLData read fXMLData;
  end;

  TXMLData = class(TDataModule)
    Doc: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    fNode: TXMLDataNode;
    fFileName: string;
    fOnDataLoad: TNotifyEvent;
    fOnDataChange: TNotifyEvent;
    function GetNode(const NodeName: string): TXMLDataNode;
    function FindNode(const NodeName: string; const Create: boolean = false): IXMLNode;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetText: string;
    procedure SetText(const Value: string);
    procedure DoNodeDataChange(Sender: TObject);
  public
    { Public declarations }
    property FileName: string read GetFileName write SetFileName;
    property Node[const NodeName: string]: TXMLDataNode read GetNode; default;
    function NodeExists(const ValueName: string): boolean;
    property Text: string read GetText write SetText;
    procedure DeleteNode(const ValueName: string);
    procedure SaveToFile(const FileName: string = '');
    procedure LoadFromFile(const FileName: string = '');
    property OnDataLoad: TNotifyEvent read fOnDataLoad write fOnDataLoad;
    property OnDataChange: TNotifyEvent read fOnDataChange write fOnDataChange;
  end;

var
  XMLData: TXMLData;

implementation

{$R *.dfm}

uses forms, Variants, FastFuncs;

  //------------------------------------------------------------------------------
  { TXMLDataNodeAttribute }
  //------------------------------------------------------------------------------

procedure TXMLDataNodeAttribute.Delete;
begin
  if DocNode.HasAttribute(Self.AttributeName) then DocNode.Attributes[Self.AttributeName] := null;
end;

function TXMLDataNodeAttribute.Exists: boolean;
begin
  Result := DocNode.HasAttribute(Self.AttributeName);
end;

function TXMLDataNodeAttribute.GetAsBoolean: boolean;
begin
  Result := GetAsString = 'True';
end;

function TXMLDataNodeAttribute.GetAsDateTime: TDateTime;
var
  StrResult: string;
begin
  StrResult := GetAsString;
  if StrResult = '' then Result := 0
  else Result := StrToFloat(StrResult);
end;

function TXMLDataNodeAttribute.GetAsFloat: double;
var
  StrResult: string;
begin
  StrResult := GetAsString;
  if StrResult = '' then Result := 0
  else Result := StrToFloat(StrResult);
end;

function TXMLDataNodeAttribute.GetAsInteger: integer;
var
  StrResult: string;
begin
  StrResult := GetAsString;
  if StrResult = '' then Result := 0
  else Result := FastFuncs.StrToInt(StrResult);
end;

function TXMLDataNodeAttribute.GetAsString: string;
begin
  if VarIsNull(DocNode.Attributes[Self.AttributeName]) then Result := ''
  else Result := DocNode.Attributes[Self.AttributeName];
end;

procedure TXMLDataNodeAttribute.SetAsBoolean(const Value: boolean);
begin
  if Value then DocNode.Attributes[Self.AttributeName] := 'True'
  else DocNode.Attributes[Self.AttributeName]          := 'False';
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNodeAttribute.SetAsDateTime(const Value: TDateTime);
begin
  DocNode.Attributes[Self.AttributeName] := FloatToStr(Value);
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNodeAttribute.SetAsFloat(const Value: double);
begin
  DocNode.Attributes[Self.AttributeName] := FloatToStr(Value);
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNodeAttribute.SetAsInteger(const Value: integer);
begin
  DocNode.Attributes[Self.AttributeName] := IntToStr(Value);
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNodeAttribute.SetAsString(const Value: string);
begin
  DocNode.Attributes[Self.AttributeName] := Value;
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

  //------------------------------------------------------------------------------
  { TXMLDataNode }
  //------------------------------------------------------------------------------

constructor TXMLDataNode.Create(Owner: TXMLData);
begin
  inherited Create; 
  fXMLData := Owner;
  fXMLDataNodeAttribute := TXMLDataNodeAttribute.Create;
  fXMLDataNodeAttribute.OnDataChange := self.DoAttributeDataChange;
end;

destructor TXMLDataNode.Destroy;
begin
  FreeAndNil(fXMLDataNodeAttribute);
  inherited;
end;

function TXMLDataNode.GetAsString: string;
begin
  Result := DocNode.Text;
end;

procedure TXMLDataNode.SetAsString(const Value: string);
begin
  DocNode.Text := Value;
end;

function TXMLDataNode.GetAttribute(const ValueName: string): TXMLDataNodeAttribute;
begin
  fXMLDataNodeAttribute.DocNode := Self.DocNode;
  fXMLDataNodeAttribute.AttributeName := ValueName;
  Result := fXMLDataNodeAttribute;
end;

function TXMLDataNode.GetNodeName: string;
begin
  Result := Self.DocNode.NodeName;
end;

  //procedure TXMLDataNode.SetNodeName(const Value: string);
  //begin
  //  Self.DocNode.NodeName:= Value;
  //end;

function TXMLDataNode.GetAsBoolean: boolean;
begin
  Result := GetAsString = 'True';
end;

function TXMLDataNode.GetAsDateTime: TDateTime;
var
  StrResult: string;
begin
  StrResult := GetAsString;
  if StrResult = '' then Result := 0
  else Result := StrToFloat(StrResult);
end;

function TXMLDataNode.GetAsFloat: double;
var
  StrResult: string;
begin
  StrResult := GetAsString;
  if StrResult = '' then Result := 0
  else Result := StrToFloat(StrResult);
end;

procedure TXMLDataNode.SetAsBoolean(const Value: boolean);
begin
  if Value then DocNode.Text := 'True'
  else DocNode.Text          := 'False';
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNode.SetAsDateTime(const Value: TDateTime);
begin
  DocNode.Text := FloatToStr(Value);
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNode.SetAsFloat(const Value: double);
begin
  DocNode.Text := FloatToStr(Value);
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

procedure TXMLDataNode.DoAttributeDataChange(Sender: TObject);
begin
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

  //------------------------------------------------------------------------------
  { TXMLData }
  //------------------------------------------------------------------------------

procedure TXMLData.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fFileName := ChangeFileExt(Application.ExeName, '_XMLData.xml'); // default file name
  Doc.XML.Text := '<Data/>';
  Doc.Active := true;
  fNode := TXMLDataNode.Create(self);
  fNode.OnDataChange := self.DoNodeDataChange;
end;

procedure TXMLData.DataModuleDestroy(Sender: TObject);
begin
  Doc.Active := false;
  If Assigned(fNode) then
    FreeAndNil(fNode);
  inherited;
end;

function TXMLData.GetNode(const NodeName: string): TXMLDataNode;
begin
  fNode.DocNode := FindNode(NodeName, true);
  Result := fNode;
end;

function TXMLData.FindNode(const NodeName: string; const Create: boolean = false): IXMLNode;
var
  x: integer;
  CurrentNode, ParentNode: IXMLNode;
  found: boolean;
  list: TStringList;
begin
  CurrentNode := nil;
  Result := nil;
  list := TStringList.Create;
  try
    FastFuncs.Split(NodeName, '.', list);
    if list.Count < 1 then raise Exception.Create('Invalid Node Name');
    ParentNode := Doc.DocumentElement;
    found      := false;
    for x := 0 to list.Count - 1 do begin
      CurrentNode := ParentNode.ChildNodes.FindNode(list[x]);
      if CurrentNode = nil then begin
        if Create then begin
          ParentNode.AddChild(list[x]);
          if Assigned(fOnDataChange) then fOnDataChange(self);
          CurrentNode := ParentNode.ChildNodes.Last;
          ParentNode := CurrentNode;
          found := true;
        end else begin
          found := false;
          Break;
        end;
      end else begin
        found := true;
        ParentNode := CurrentNode;
      end;
    end;
    if found then begin
      Result := CurrentNode;
    end;
  finally
    FreeAndNil(list);
  end;
end;

function TXMLData.GetFileName: string;
begin
  Result := fFileName;
end;

procedure TXMLData.SetFileName(const Value: string);
begin
  fFileName := Value;
end;

procedure TXMLData.LoadFromFile(const FileName: string = '');
begin
  if FileName <> '' then fFileName := FileName;
  if (fFileName <> '') and FileExists(fFileName) then begin
    Doc.Active := false;
    Doc.LoadFromFile(fFileName);
    Doc.Active := true;
    if Assigned(fOnDataLoad) then fOnDataLoad(self);
  end;
end;

procedure TXMLData.SaveToFile(const FileName: string = '');
begin
  if FileName <> '' then fFileName := FileName;
  if (fFileName <> '') then Doc.SaveToFile(fFileName);
end;

function TXMLData.NodeExists(const ValueName: string): boolean;
begin
  Result := Self.FindNode(ValueName, false) <> nil;
end;

procedure TXMLData.DeleteNode(const ValueName: string);
var
  Node: IXMLNode;
begin
  Node := Self.FindNode(ValueName, false);
  if Assigned(Node) then begin
    if Assigned(Node.ParentNode) then begin
      Node.ParentNode.ChildNodes.Delete(Node.NodeName);
      if Assigned(fOnDataChange) then fOnDataChange(self);
    end;
  end;
end;

  //function EscapeForXML(s: String): String;
  //var i: Integer;
  //  ch: String;
  //begin
  //for i := 1 to char_length(s) do
  //  begin
  //  case s[i] of
  //    '&': ch := '&amp;';
  //    '<': ch := '&lt;';
  //    '>': ch := '&gt;';
  //    '''': ch := '&apos;';
  //    '"': ch := '&quot;';
  //    else
  //      ch := s[i];
  //    end;
  //  result := result + ch;
  //  end;
  //end;

function TXMLData.GetText: string;
begin
  Result := Doc.XML.Text;
end;

procedure TXMLData.SetText(const Value: string);
begin
  Doc.Active := false;
  Doc.XML.Text := Value;
  Doc.Active := true;
  if Assigned(fOnDataLoad) then fOnDataLoad(self);
end;

procedure TXMLData.DoNodeDataChange(Sender: TObject);
begin
  if Assigned(fOnDataChange) then fOnDataChange(self);
end;

end.
