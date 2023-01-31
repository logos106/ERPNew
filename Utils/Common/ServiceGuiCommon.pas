unit ServiceGuiCommon;

interface

uses
  contnrs, ALXMLDoc;

type

  TPropertyValue = class;

  TPropertyValueChangeEvent = procedure (Sender: TPropertyValue) of object;

  TPropertyValue = class(TObject)
  private
    fValue: string;
    fOnChange: TPropertyValueChangeEvent;
    procedure SetAsString(const aValue: string);
    function GeAsInteger: integer;
    function GetAsFloat: double;
    function GetAsString: string;
    procedure SetAsFloat(const aValue: double);
    procedure SetAsInteger(const aValue: integer);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const aValue: TDateTime);
    procedure SetValue(const aValue: string);
  public
    constructor Create;
    property Value: string read fValue write SetValue;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GeAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property OnChange: TPropertyValueChangeEvent read fOnChange write fOnChange;
  end;

  TRemoteMessageStatus = (msWaiting, msDone, msFail, msDelete);
  TRemoteMessageDirection = (mdOut, mdIn);

  TRemoteMessageItem = class(TObject)
  private
    FStatus: TRemoteMessageStatus;
    fResponce: TRemoteMessageItem;
    fDirection: TRemoteMessageDirection;
    fTimeQueued: TDateTime;
    function GetValuesNode: TALXMLNode;
    procedure SetDest(const Value: string);
    procedure SetFrom(const Value: string);
    procedure SetId(const Value: string);
    procedure SetStatus(const Value: TRemoteMessageStatus);
    function GetRootNode: TALXMLNode;
    procedure SetRequesterId(const Value: string);
    function GetDest: string;
    function GetFrom: string;
    function GetId: string;
    function GetRequesterId: string;
  private
    fDoc: TALXMLDocument;
    function GetValues(const Name: string): string;
    function GetXML: string;
    procedure SetXML(const Value: string);
    procedure SetValues(const Name, Value: string);
    property ValuesNode: TALXMLNode read GetValuesNode;
    property RootNode: TALXMLNode read GetRootNode;
  public
    constructor Create;
    destructor Destroy; override;
    property Direction: TRemoteMessageDirection read fDirection write fDirection;
    property Status: TRemoteMessageStatus read FStatus write SetStatus;
    property Id: string read GetId write SetId;
    property TimeQueued: TDateTime read fTimeQueued write fTimeQueued;
    property RequesterId: string read GetRequesterId write SetRequesterId;
    property Dest: string read GetDest write SetDest;
    property From: string read GetFrom write SetFrom;
    property Doc: TALXMLDocument read fDoc write fDoc;
    property XML: string read GetXML write SetXML;
    property Values[const Name: string]: string read GetValues write SetValues;
    property Responce: TRemoteMessageItem read fResponce write fResponce;
  end;

  TOnAddMessageEvent = procedure (msg: TRemoteMessageItem) of object;

  TRemoteMessageQueue = class(TObject)
  private
    List: TObjectList;
    fOnAddMessage: TOnAddMessageEvent;
    fLastID: integer;
    function GetCount: integer;
    function GetItems(const index: integer): TRemoteMessageItem;
    function GetItemById(const aId: string): TRemoteMessageItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure AddMessage(aMessage: TRemoteMessageItem);
    property OnAddMessage: TOnAddMessageEvent read fOnAddMessage write fOnAddMessage;
    procedure RemoveMessage(aMessage: TRemoteMessageItem);
    procedure RemoveDeleted;
    property Items[const index: integer]: TRemoteMessageItem read GetItems;
    property ItemById[const aId: string]: TRemoteMessageItem read GetItemById;
  end;

const

  CRLF = #13#10;

  XMLDocVersion         = '1.0';
  XMLDocEncoding        = 'UTF-8';
  XMLMsgNodeRoot        = 'message';
  XMLMsgNodeBody        = 'body';
  XMLMsgNodeParams      = 'params';
  XMLMsgNodeValues      = 'values';

implementation

uses
  ActiveX, SysUtils;


const
  PropDateFormat = 'dd/mm/yyyy';
  PropTimeFormat = 'hh:nn:ss';



{ TPropertyValue }

procedure TPropertyValue.SetAsString(const aValue: string);
begin
  Value:= aValue;
end;

constructor TPropertyValue.Create;
begin
  inherited;
  fValue:= '';
end;

function TPropertyValue.GeAsInteger: integer;
begin
  result:= StrToIntDef(fValue,0);
end;

function TPropertyValue.GetAsFloat: double;
begin
  result:= StrToFloatDef(fValue,0);
end;

function TPropertyValue.GetAsString: string;
begin
  result:= fValue;
end;

procedure TPropertyValue.SetAsFloat(const aValue: double);
begin
  Value:= FloatToStr(aValue);
end;

procedure TPropertyValue.SetAsInteger(const aValue: integer);
begin
  Value:= IntToStr(aValue)
end;

function TPropertyValue.GetAsDateTime: TDateTime;
var
  saveShortDateFormat,
  saveLongTimeFormat: string;
begin
  saveShortDateFormat:= ShortDateFormat;
  saveLongTimeFormat:= LongTimeFormat;
  ShortDateFormat:= PropDateFormat;
  LongTimeFormat:= PropTimeFormat;
  try
    if fValue <> '' then
      result:= StrToDateTime(fValue)
    else
      result:= 0;
  finally
    ShortDateFormat:= saveShortDateFormat;
    LongTimeFormat:= saveLongTimeFormat;
  end;
end;

procedure TPropertyValue.SetAsDateTime(const aValue: TDateTime);
var
  saveShortDateFormat,
  saveLongTimeFormat: string;
begin
  saveShortDateFormat:= ShortDateFormat;
  saveLongTimeFormat:= LongTimeFormat;
  ShortDateFormat:= PropDateFormat;
  LongTimeFormat:= PropTimeFormat;
  try
    Value:= DateTimeToStr(aValue);
  finally
    ShortDateFormat:= saveShortDateFormat;
    LongTimeFormat:= saveLongTimeFormat;
  end;
end;

procedure TPropertyValue.SetValue(const aValue: string);
begin
  fValue := Value;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

{ TRemoteMessageItem }

constructor TRemoteMessageItem.Create;
begin
  inherited;
  fResponce:= nil;
  FStatus:= msWaiting;
  fDirection:= mdOut;
  fdoc:= TALXMLDocument.Create(nil);
  fdoc.Active:= true;
//  fdoc.Version:= XMLDocVersion;
//  fdoc.Encoding:= XMLDocEncoding;
  {ToDo: remove the following option for production }
  fdoc.Options := fdoc.Options + [doNodeAutoIndent];
  RootNode.Attributes['dest']:= '';
  RootNode.Attributes['from']:= '';
  RootNode.Attributes['id']:= '';
  RootNode.Attributes['requesterId']:= '';
  rootNode.AddChild(XMLMsgNodeBody);
end;

destructor TRemoteMessageItem.Destroy;
begin
  fDoc.Free;
  CoUninitialize;
  inherited;
end;

function TRemoteMessageItem.GetDest: string;
begin
  result:= RootNode.AttributesAsString['dest'];
end;

function TRemoteMessageItem.GetFrom: string;
begin
  result:= RootNode.AttributesAsString['from'];
end;

function TRemoteMessageItem.GetId: string;
begin
  result:= RootNode.AttributesAsString['id'];
end;

function TRemoteMessageItem.GetRequesterId: string;
begin
  result:= RootNode.AttributesAsString['requesterId'];
end;

function TRemoteMessageItem.GetRootNode: TALXMLNode;
var
  node: TALXMLNode;
begin
  node:= fDoc.ChildNodes.FindNode(XMLMsgNodeRoot);
  if not Assigned(node) then
    node:= fdoc.AddChild(XMLMsgNodeRoot);
  result:= node;
end;

function TRemoteMessageItem.GetValues(const Name: string): string;
var
  node: TALXMLNode;
begin
  result:= '';
  node:= ValuesNode.ChildNodes.FindNode(Name);
  if Assigned(node) then
    result:= node.Text;
end;

function TRemoteMessageItem.GetValuesNode: TALXMLNode;
var
  bodyNode, valsNode: TALXMLNode;
begin
  bodyNode:= RootNode.ChildNodes.FindNode(XMLMsgNodebody);
  if not Assigned(bodyNode) then
    bodyNode:= rootNode.AddChild(XMLMsgNodeBody);
  valsNode:= bodyNode.ChildNodes.FindNode(XMLMsgNodeVAlues);
  if not Assigned(valsNode) then
    valsNode:= bodyNode.AddChild(XMLMsgNodeVAlues);
  result:= valsNode;
end;

function TRemoteMessageItem.GetXML: string;
begin
  fDoc.SaveToXML(result);
end;

procedure TRemoteMessageItem.SetDest(const Value: string);
begin
  RootNode.Attributes['dest']:= Value;
end;

procedure TRemoteMessageItem.SetFrom(const Value: string);
begin
  RootNode.Attributes['from']:= Value;
end;

procedure TRemoteMessageItem.SetId(const Value: string);
begin
  RootNode.Attributes['id']:= Value;
end;

procedure TRemoteMessageItem.SetRequesterId(const Value: string);
begin
  RootNode.Attributes['requesterId']:= Value;
end;

procedure TRemoteMessageItem.SetStatus(const Value: TRemoteMessageStatus);
begin
  FStatus := Value;
end;

procedure TRemoteMessageItem.SetValues(const Name, Value: string);
var
  node: TALXMLNode;
begin
  node:= ValuesNode.ChildNodes.FindNode(Name);
  if not Assigned(node) then
    node:= ValuesNode.AddChild(Name);
  node.Text:= Value;
end;

procedure TRemoteMessageItem.SetXML(const Value: string);
begin
  fDoc.LoadFromXML(value);
end;

{ TRemoteMessageQueue }

constructor TRemoteMessageQueue.Create;
begin
  inherited;
  List:= TObjectList.Create(true);
  fLastID:= Round(now * 1000);
end;

destructor TRemoteMessageQueue.Destroy;
begin
  List.Free;
  inherited;
end;

procedure TRemoteMessageQueue.AddMessage(aMessage: TRemoteMessageItem);
var
  reqItem: TRemoteMessageItem;
begin
  aMessage.fTimeQueued:= now;
  List.Add(aMessage);
  if (aMessage.Direction = mdOut) then begin
    { give outgoing messages an id }
    Inc(fLastID);
    aMessage.Id:= IntToStr(fLastId);
  end
  else if (aMessage.Direction = mdIn) then begin
    if (aMessage.RequesterId <> '') then begin
      reqItem:= self.ItemById[aMessage.RequesterId];
      { link this incomming message to original request }
      if Assigned(reqItem) then
        reqItem.Responce:= aMessage
      else
        { can't find a a matching request so just ditch message }
        aMessage.Status:= msDelete;
    end;
  end;
  if Assigned(fOnAddMessage) then
    fOnAddMessage(aMessage);
end;

function TRemoteMessageQueue.GetCount: integer;
begin
  result:= List.Count;
end;

function TRemoteMessageQueue.GetItems(
  const index: integer): TRemoteMessageItem;
begin
  result:= TRemoteMessageItem(List[index]);
end;

procedure TRemoteMessageQueue.RemoveDeleted;
var
  x: integer;
begin
  x:= 0;
  while x < Count do begin
    if Items[x].Status = msDelete then
      List.Delete(x)
    else
      Inc(x);  
  end;
end;

procedure TRemoteMessageQueue.RemoveMessage(aMessage: TRemoteMessageItem);
var
  x: integer;
begin
  x:= List.IndexOf(aMessage);
  if x >= 0 then
    List.Delete(x);
end;

function TRemoteMessageQueue.GetItemById(
  const aId: string): TRemoteMessageItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to count -1 do begin
    if Items[x].Id = aId then begin
      result:= Items[x];
      break;
    end;
  end;
end;

end.
