unit JsonXmlMappingObj;

interface

uses
  ConTnrs, XMLIntf, JsonObject;

type
  TXmlMapType = (xtUnknown, xtRosettaNet);

  TJsonXmlMapper = class
  private
    fList: TObjectList;
    FXMLMapType: TXmlMapType;
    procedure SetXMLMapType(const Value: TXmlMapType);
    function JsonSubobjet(aObj: TJsonObject; aJsonPath: string): TJsonObject;
  public
    procedure AddMapping(aJsonPath, aXmlPath: string; aOptional: boolean = false);
    function MapXmlToJson(aNode: IXMLNode; aObj: TJsonObject; var msg: string): boolean;
    constructor Create;
    destructor Destroy; override;
    property XMLMapType: TXmlMapType read FXMLMapType write SetXMLMapType;
    procedure Clear;
    function FormatRosettaAddress(aNode: IXMLNode): string;
  end;

  TMapItem = class
  public
    JsonPath,
    XmlPath: string;
    Optional: boolean;
    function NodeName: string;
    function PairName: string;
    constructor Create;
  end;

implementation

uses
  XMLHelperUtils, SysUtils, Types, StrUtils, Variants, DateTimeUtils, Classes,
  CountryCodeObj;

{ TJsonXmlMapper }

procedure TJsonXmlMapper.AddMapping(aJsonPath, aXmlPath: string; aOptional: boolean = false);
var
  MapItem: TMapItem;
begin
  MapItem := TMapItem.Create;
  MapItem.XmlPath := aXmlPath;
  MapItem.JsonPath := aJsonPath;
  MapItem.Optional := aOptional;
  fList.Add(MapItem);
end;

procedure TJsonXmlMapper.Clear;
begin
  fList.Clear;
end;

constructor TJsonXmlMapper.Create;
begin
  fList:= TObjectList.Create;
  fXMLMapType := xtUnknown;
end;

destructor TJsonXmlMapper.Destroy;
begin
  fList.Free;
  inherited;
end;

function TJsonXmlMapper.FormatRosettaAddress(aNode: IXMLNode): string;
var
  n: IXMLNode;
  s: string;
begin
  result:= '';
  n := GetNode(aNode,'postOfficeBoxIdentifier.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if result <> '' then result := result + #13#10;
    result := result + n.NodeValue;
  end;
  n := GetNode(aNode,'addressLine1.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if result <> '' then result := result + #13#10;
    result := result + n.NodeValue;
  end;
  n := GetNode(aNode,'addressLine2.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if result <> '' then result := result + #13#10;
    result := result + n.NodeValue;
  end;
  n := GetNode(aNode,'addressLine3.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if result <> '' then result := result + #13#10;
    result := result + n.NodeValue;
  end;
  s := '';
  n := GetNode(aNode,'cityName.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    s := n.NodeValue;
  end;
  n := GetNode(aNode,'regionName.FreeFormText');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if s <> '' then s := s + ' ';
    s := s + n.NodeValue;
  end;
  n := GetNode(aNode,'NationalPostalCode');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    if s <> '' then s := s + ' ';
    s := s + n.NodeValue;
  end;
  if (s <> '') then begin
    if result <> '' then result := result + #13#10;
    result := result + s;
  end;
  n := GetNode(aNode,'GlobalCountryCode');
  if Assigned(n) and n.IsTextElement and (not VarIsNull(n.NodeValue)) then begin
    s:= TCountryCode.CountryName(n.NodeValue);
    if s <> '' then begin
      if result <> '' then result := result + #13#10;
      result := result + s;
    end;
  end;
end;

function TJsonXmlMapper.JsonSubobjet(aObj: TJsonObject;
  aJsonPath: string): TJsonObject;
var
  StrArray: TStringDynArray;
  x: integer;
begin
  result := aObj;
  StrArray := SplitString(aJsonPath,'.');
  for x := 0 to High(StrArray) -1 do
    result := result.O[StrArray[x]];
end;

function TJsonXmlMapper.MapXmlToJson(aNode: IXMLNode; aObj: TJsonObject;
  var msg: string): boolean;
var
  x: integer;
  SubNode: IXMLNode;
  MapItem: TMapItem;
  s, add: string;
begin
  result := true;
  try
    for x := 0 to fList.Count -1 do begin
      MapItem := TMapItem(fList[x]);
      subNode:= GetNode(aNode,MapItem.XmlPath);
      if Assigned(subNode) then begin // and (not VarIsNull(subNode.NodeValue)) then begin
        if XMLMapType = xtRosettaNet then begin
          if subNode.IsTextElement then begin
            if not VarIsNull(subNode.NodeValue) then begin
              if SameText(subNode.NodeName,'MonetaryAmount') or
                 SameText(subNode.NodeName,'ProductQuantity') then begin
                JsonSubobjet(aObj,MapItem.JsonPath).F[MapItem.PairName] := subNode.NodeValue;
              end
              else if SameText(subNode.NodeName,'LineNumber') then begin
                JsonSubobjet(aObj,MapItem.JsonPath).I[MapItem.PairName] := subNode.NodeValue;
              end
              else if SameText(subNode.NodeName,'AffirmationIndicator') then begin
                { Yes No }
                if SameText(subNode.NodeValue,'Yes') then
                  JsonSubobjet(aObj,MapItem.JsonPath).B[MapItem.PairName] := true
                else
                  JsonSubobjet(aObj,MapItem.JsonPath).B[MapItem.PairName] := false;
              end
              else if SameText(subNode.NodeName,'DateStamp') or SameText(subNode.NodeName,'DateTimeStamp') then begin
                { ISO 8601 format eg 20090928Z }
                JsonSubobjet(aObj,MapItem.JsonPath).DT[MapItem.PairName]:= ISO8601ToDateTime(subNode.NodeValue);
              end
              else begin
                { plain text }
                s:= JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName];
                if (s <> '') and (subNode.NodeValue <> '') then begin
                  s := s + ', ' + subNode.NodeValue;
                  JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName] := s;
                end
                else
                  JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName] := subNode.NodeValue;
              end;
            end;
          end
          else begin
            { not IsTextElement }
            if SameText(subNode.NodeName,'PhysicalAddress') then begin
              add := FormatRosettaAddress(subNode);
              if add <> '' then begin
                s:= JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName];
                if s <> '' then
                  s:= s + #13#10 + add
                else
                  s := add;
                JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName] := s;
              end;
            end;
          end;
        end
        else begin
          { not RosettaNet }
            { plain text }
            s:= JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName];
            if (s <> '') and (subNode.NodeValue <> '') then begin
              s := s + #13#10 + subNode.NodeValue;
              JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName] := s;
            end
            else
              JsonSubobjet(aObj,MapItem.JsonPath).S[MapItem.PairName] := subNode.NodeValue;

        end;

      end
      else begin
        if not MapItem.Optional then begin
          result := false;
          msg := 'Node not found for ' + MapItem.XmlPath;
          exit;
        end;
      end;

    end;
  except
    on e: exception do begin
      result := false;
      msg := e.Message;
    end;

  end;
end;

procedure TJsonXmlMapper.SetXMLMapType(const Value: TXmlMapType);
begin
  FXMLMapType := Value;
end;

{ TMapItem }

constructor TMapItem.Create;
begin
  Optional := false;
end;

function TMapItem.NodeName: string;
var
  x: integer;
begin
  result:= '';
  for x := Length(XMLPath) downto 1 do begin
    if XMLPath[x] = '.' then break;
    result := XMLPath[x] + result;
  end;
end;

function TMapItem.PairName: string;
var
  x: integer;
begin
  result:= '';
  for x := Length(JsonPath) downto 1 do begin
    if JsonPath[x] = '.' then break;
    result := JsonPath[x] + result;
  end;
end;

end.
