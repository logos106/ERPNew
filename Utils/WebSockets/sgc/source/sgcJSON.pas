{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}


unit sgcJSON;

interface

uses
  Classes, SysUtils, StrUtils, Contnrs;

type

  TsgcJSON = class;

  TsgcJSONtype = (sgcJSONUndefined, sgcJSONObject, sgcJSONArray, sgcJSONList, sgcJSONString, sgcJSONNumber, sgcJSONBoolean, sgcJSONNull);

  TsgcObjectJSON = class(TComponent)
  private
    FJSONType: TsgcJSONtype;
    FName: String;
    FValue: Variant;
    function GetValue: Variant;
    procedure SetValue(const Value: Variant);

  { sgcJSONObject }
  private
    FJSONObject: TsgcJSON;
    function GetCount: Integer;
    function GetJSONObject: TsgcJSON;
  public
    procedure Clear;
  public
    property JSONObject: TsgcJSON read GetJSONObject write FJSONObject;

  protected
    function GetNode(const aName: String): TsgcObjectJSON;
    procedure SetNode(const aName: String; aValue: TsgcObjectJSON);
  public
    property Node[const aName: String]: TsgcObjectJSON read GetNode write
        SetNode;
  { sgcJSONObject }

  public
    property Count: Integer read GetCount;
    property JSONType: TsgcJSONtype read FJSONType write FJSONType;
    property Name: String read FName write FName;
    property Value: Variant read GetValue write SetValue;
  end;

  TsgcObjectJSONList = class(TObjectList)
  private
    function GetNode(const aName: String): TsgcObjectJSON;
    function GetItem(i: Integer): TsgcObjectJSON;
    procedure SetNode(const aName: String; aValue: TsgcObjectJSON);
    procedure SetItem(i: Integer; aValue: TsgcObjectJSON);
  public
    property Node[const aName: String]: TsgcObjectJSON read GetNode write
        SetNode;
    property Item[i: Integer]: TsgcObjectJSON read GetItem write SetItem;

  end;

  TsgcJSON = class(TComponent)
  protected
    function DoCreateObject(var aText: String; var Pos: integer): boolean;
    function DoCreateList(var aText: String; var Pos: integer): boolean;
  { read }
  protected
    function DoReadObject(var aText: String; var Pos: integer): boolean;
    function DoReadList(var aText: String; var Pos: integer): boolean;
    function DoReadValue(var aText: String; var Pos: integer): boolean;
    function DoReadString(var aText: String; var Pos: integer): boolean;
    function DoReadChar(var aText: String; var Pos: integer): boolean;
    function DoReadInteger(var aText: String; var Pos: integer): boolean;
    function DoReadNumber(var aText: String; var Pos: integer): boolean;
  protected
    procedure DoSpaces(var aText: String; var Pos: integer);
  { read }

  { get }
  protected
    function DoGetObject(aObject: TsgcObjectJSON): String;
    function DoGetString(aObject: TsgcObjectJSON): String;
    function DoGetNumber(aObject: TsgcObjectJSON): String;
    function DoGetBoolean(aObject: TsgcObjectJSON): String;
    function DoGetNull(aObject: TsgcObjectJSON): String;
    function DoGetList(aObject: TsgcObjectJSON): String;
  protected
    function GetText: String;
  { get }

  { add }
  protected
    procedure DoAdd(const aName: String; aValue: Variant; aType: TsgcJSONtype);
  public
    procedure Add(const aName, aValue: String); overload;
    procedure Add(const aName: String; const aValue: Integer); overload;
    procedure Add(const aName: String; const aValue: Double); overload;
    procedure Add(const aName: String; const aValue: Boolean); overload;
    function Add: TsgcObjectJSON; overload;
  { add }

  { JSON object }
  private
    FJSONName: String;
    FJSONType: TsgcJSONtype;
    FJSONValue: Variant;
    procedure DoJSONStart(const aName: String);
    procedure DoJSONValue(const aValue: String);
    procedure DoJSONEnd;
  private
    FData: TsgcObjectJSONList;
    FListMode: Boolean;
    function GetCount: Integer;
    function GetData: TsgcObjectJSONList;
  protected
    property Data: TsgcObjectJSONList read GetData write FData;
  protected
    function GetNode(const aName: String): TsgcObjectJSON;
    function GetItem(i: integer): TsgcObjectJSON;
    procedure SetNode(const aName: String; aValue: TsgcObjectJSON);
    procedure SetItem(i: integer; aValue: TsgcObjectJSON);
  public
    property Count: Integer read GetCount;
    property Node[const aName: String]: TsgcObjectJSON read GetNode write
        SetNode;
    property Item[i: integer]: TsgcObjectJSON read GetItem write SetItem;
    property ListMode: Boolean read FListMode write FListMode;
  public
    procedure Clear;
  { JSON object }

  public
    procedure Read(aText: String);
    property Text: String read GetText;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation


constructor TsgcJSON.Create(aOwner: TComponent);
begin
  inherited;
  ListMode := False;
end;

destructor TsgcJSON.Destroy;
begin
  Clear;
  inherited;
end;

procedure TsgcJSON.Add(const aName, aValue: String);
begin
  if aValue[1] = '{' then
    DoAdd(aName, aValue, sgcJSONObject)
//  else if aValue[1] = '[' then
//    DoAdd(aName, aValue, sgcJsonList)
  else
    DoAdd(aName, aValue, sgcJSONString);
end;

function TsgcJSON.Add: TsgcObjectJSON;
begin
  result := TsgcObjectJSON.Create(self);
  result.JSONType := sgcJSONObject;
  Data.Add(result);
end;

procedure TsgcJSON.Add(const aName: String; const aValue: Integer);
begin
  DoAdd(aName, aValue, sgcJSONNumber);
end;

procedure TsgcJSON.Add(const aName: String; const aValue: Double);
begin
  DoAdd(aName, aValue, sgcJSONNumber);
end;

procedure TsgcJSON.Add(const aName: String; const aValue: Boolean);
begin
  DoAdd(aName, aValue, sgcJSONBoolean);
end;

procedure TsgcJSON.Clear;
begin
  FreeAndNil(FData);
end;

procedure TsgcJSON.DoAdd(const aName: String; aValue: Variant; aType:
    TsgcJSONtype);
var
  oJSON: TsgcObjectJSON;
  s : string;
  lpos : integer;
begin
  if Node[aName] = nil then
  begin
    oJSON := TsgcObjectJSON.Create(self);
    oJSON.Name := aName;
    oJSON.JSONType := aType;
    if aType = sgcJSONObject then
    begin
      if not assigned(oJSON.JSONObject) then
        oJSON.JSONObject := TsgcJson.Create(oJson);
      oJson.JSONType := aType;
      oJSON.JSONObject.Read(aValue);
    end
    else
      oJSON.Value := aValue;

    Data.Add(oJSON);
  end
  else
    Node[aName].Value := aValue;
end;

function TsgcJSON.DoCreateList(var aText: String; var Pos: integer):
    boolean;
var
  oJSON: TsgcObjectJSON;
begin
  oJSON := TsgcObjectJSON.Create(self);
  oJSON.Name := FJSONName;
  result := oJSON.JSONObject.DoReadList(aText, Pos);

  Data.Add(oJSON);
end;

function TsgcJSON.DoCreateObject(var aText: String; var Pos: integer):
    boolean;
var
  oJSON: TsgcObjectJSON;
begin
  oJSON := TsgcObjectJSON.Create(self);
  oJSON.Name := FJSONName;
  result := oJSON.JSONObject.DoReadObject(aText, Pos);

  Data.Add(oJSON);
end;

procedure TsgcJSON.DoJSONEnd;
var
  oJSON: TsgcObjectJSON;
begin
  if (FJSonType <> sgcJSONObject) then
  begin
    oJSON := TsgcObjectJSON.Create(self);
    oJSON.Name := FJSONName;
    oJSON.JSONType := FJSONType;
    oJSON.Value := FJSONValue;

    Data.Add(oJSON);
  end;
end;

function TsgcJSON.DoReadObject(var aText: String; var Pos:
    integer): boolean;
var
  vPos: Integer;
  vStart: Integer;
begin
  vPos := Pos;
  DoSpaces(aText,Pos);
  result:=False;
  if ((Pos <= Length(aText)) and (aText[Pos] = '{')) then
  begin
    inc(Pos);
    while Pos <= Length(aText) do
    begin
      DoSpaces(aText, Pos);
      if aText[Pos] = '}' then
      begin
        inc(Pos);
        result := True;
        break;
      end;
      vStart := Pos;
      if not(DoReadString(aText, Pos)) then
        break;
      DoJSONStart(Copy(aText, vStart + 1, Pos - (vStart + 1) - 1));
      DoSpaces(aText, Pos);
      if not((Pos <= Length(aText)) and (aText[Pos] = ':')) then
       break
      else
        Inc(Pos);
      DoSpaces(aText,Pos);
      if not(DoReadValue(aText,Pos)) then
        break;
      DoJSONEnd;
      DoSpaces(aText, Pos);
      if ((Pos <= Length(aText)) and (aText[Pos] = ',')) then
        Inc(Pos);
    end;
    if not(result) then
      Pos := vPos;
  end;
end;

procedure TsgcJSON.Read(aText: String);
var
  vPos: Integer;
begin
  Clear;

  vPos := 1;

  ListMode := False;
  if LeftStr(aText, 1) = '[' then
  begin
    ListMode := True;
    DoReadList(aText, vPos);
  end
  else
    DoReadObject(aText, vPos);
end;

procedure TsgcJSON.DoSpaces(var aText: String; var Pos: integer);
begin
  while Pos <= Length(aText) do
  begin
    if aText[Pos] = '#' then
    begin
      while ((Pos <= Length(aText)) and (aText[Pos] <> #10)) do
        inc(Pos)
    end
    else
    begin
      case aText[Pos] of
        ' ',#9,#12,#13,#10:
          inc(Pos);
        else
          Break;
      end;
    end;
  end;
end;

function TsgcJSON.DoReadList(var aText: String; var Pos: integer): boolean;
var
  vPos:Integer;
  i: integer;
  oJSON: TsgcObjectJSON;
begin
  i := 0;
  vPos := Pos;
  DoSpaces(aText,Pos);
  result := False;
  if ((Pos <= Length(aText)) and (aText[Pos] = '[')) then
  begin
    inc(Pos);
    while Pos <= Length(aText) do
    begin
      DoSpaces(aText, Pos);
      if aText[Pos] = ']' then
      begin
        inc(Pos);
        result := True;
        break;
      end;

      FJSONName := String(IntToStr(i));

      if not(DoReadValue(aText, Pos)) then
        break;

      if (FJSONType <> sgcJSONObject) and (FJSONType <> sgcJSONList) then
      begin
        oJSON := TsgcObjectJSON.Create(self);
        oJSON.Name := FJSONName;
        oJSON.JSONType := FJSONType;
        oJSON.Value := FJSONValue;
        Data.Add(oJSON);
        inc(i);
      end;

      DoSpaces(aText, Pos);
      if ((Pos <= Length(aText)) and (aText[Pos] = ',')) then
        Inc(Pos);
    end;
    if not(result) then
      Pos := vPos;
  end;
end;

function TsgcJSON.DoReadValue(var aText: String; var Pos:
    integer): boolean;
var
  vPos: Integer;
begin
  DoSpaces(aText, Pos);
  result := False;
  vPos := Pos;
  if Pos <= Length(aText) then
  begin
    case aText[Pos] of
                   '"': begin
                          FJSONType := sgcJSONString;
                          result := DoReadString(aText, Pos);
                          DoJSONValue(Copy(aText, vPos + 1,Pos - (vPos + 1) - 1));
                        end;
      '+','-','0'..'9': begin
                          FJSONType := sgcJSONNumber;
                          result := DoReadNumber(aText,Pos);
                          DoJSONValue(Copy(aText , vPos, Pos - vPos));
                        end;
                   '{': begin
                          FJSONType := sgcJSONObject;
                          result := DoCreateObject(aText, Pos);
                        end;
                   '[': begin
                          FJSONType := sgcJSONList;
                          result := DoCreateList(aText, Pos);
                        end;
               't','T': begin
                          FJSONType := sgcJSONBoolean;
                          result := LowerCase(Copy(String(aText), Pos, 4)) = 'true';
                          DoJSONValue('true');
                        end;
               'f','F': begin
                          FJSONType := sgcJSONBoolean;
                          result := LowerCase(Copy(String(aText), Pos, 5)) = 'false';
                          DoJSONValue('false');
                        end;
               'n','N': begin
                          FJSONType := sgcJSONNull;
                          result := LowerCase(Copy(String(aText), Pos, 4)) = 'null';
                          Pos := Pos + 4;
                          DoJSONValue('null');
                        end;
    end;
  end;
end;

function TsgcJSON.DoReadString(var aText: String; var Pos:
    integer): boolean;
var
  vPos:Integer;
begin
  vPos := Pos;
  DoSpaces(aText, Pos);
  result := False;
  if ((Pos <= Length(aText)) and (aText[Pos] = '"')) then
  begin
    inc(Pos);
    while Pos <= Length(aText) do
    begin
      if aText[Pos] = '"' then
      begin
        inc(Pos);
        result := True;
        break;
      end;
      if not(DoReadChar(aText, Pos)) then
        break;
    end;
    if not(result) then
      Pos := vPos;
  end;
end;

function TsgcJSON.DoReadChar(var aText: String; var Pos:
    integer): boolean;
var
  vPos:Integer;
begin
  vPos := Pos;
  if Pos <= Length(aText) then
  begin
    result := True;
    if aText[Pos]='\' then
    begin
      inc(Pos);
      if Pos <= Length(aText) then
      begin
        if aText[Pos]='u' then
        begin
          if Pos + 4 <= Length(aText) then
          begin
            inc(Pos, 5);
          end
          else
          begin
            result := False;
            Pos := vPos;
          end;
        end
        else
          inc(Pos);
      end
      else
      begin
        result := False;
        Pos := vPos;
      end;
    end
    else
      inc(Pos);
  end
  else
    result := False;
end;

function TsgcJSON.DoReadInteger(var aText: String; var Pos:
    integer): boolean;
begin
  result := False;
  while Pos <= Length(aText) do
  begin
    if ((aText[Pos] >= '0') and (aText[Pos] <= '9')) then
    begin
      result := True;
      inc(Pos);
    end
    else
      break;
  end;
end;

function TsgcJSON.DoReadNumber(var aText: String; var Pos:
    integer): boolean;
var
  vPos:Integer;
begin
  vPos := Pos;
  DoSpaces(aText,Pos);
  result := False;
  if Pos <= Length(aText) then
  begin
    if ((aText[Pos] = '+') or (aText[Pos] = '-')) then
      inc(Pos);
    if DoReadInteger(aText, Pos) then
    begin
      if ((Pos <= Length(aText)) and (aText[Pos] = '.')) then
      begin
        inc(Pos);
        if not(DoReadInteger(aText,Pos)) then
        begin
          Pos := vPos;
          exit;
        end;
      end;
      if ((Pos <= Length(aText)) and ((aText[Pos] = 'e') or (aText[Pos] = 'E'))) then
      begin
        inc(Pos);
        if ((Pos <= Length(aText)) and ((aText[Pos] = '+') or (aText[Pos] = '-'))) then
          inc(Pos);
        if not(DoReadInteger(aText, Pos)) then
        begin
          Pos := vPos;
          exit;
        end;
      end;
      result := True;
    end;
  end;
end;

procedure TsgcJSON.DoJSONStart(const aName: String);
begin
  FJSONName := aName;
  FJSONType := sgcJSONUndefined;
  FJSONValue := '';
end;

procedure TsgcJSON.DoJSONValue(const aValue: String);
begin
  FJSONValue := aValue;
end;

function TsgcJSON.GetText: String;
var
  i: Integer;
  oJSON: TsgcObjectJSON;
begin
  for i := 0 to Data.Count - 1 do
  begin
    if i = 0 then
    begin
      if ListMode then
        result := '['
      else
        result := '{';
    end;

    oJSON := TsgcObjectJSON(Data.Items[i]);

    case oJSON.JSONType of
      sgcJSONString:
        result := result + DoGetString(oJSON);
      sgcJSONNumber:
        result := result + DoGetNumber(oJSON);
      sgcJSONBoolean:
        result := result + DoGetBoolean(oJSON);
      sgcJSONNull:
        result := result + DoGetNull(oJSON);
      sgcJSONList:
        result := result + DoGetList(oJSON);
      sgcJSONObject:
        result := result + DoGetObject(oJSON);
    end;

    if i = Data.Count - 1 then
    begin
      if ListMode then
        result := result + ']'
      else
        result := result + '}'
    end
    else if RightStr(result, 1) <> ',' then
      result := result + ',';
  end;
end;

function TsgcJSON.DoGetBoolean(aObject: TsgcObjectJSON): String;
begin
  if ListMode then
    Result := String(aObject.Value)
  else
    Result := '"' + aObject.Name + '":' + String(aObject.Value);
end;

function TsgcJSON.DoGetList(aObject: TsgcObjectJSON): String;
begin
  if ListMode then
    Result := '["' + String(aObject.Value) + '"]'
  else
    Result := '["' + aObject.Name + '":"' + String(aObject.Value) + '"]'
end;

function TsgcJSON.DoGetNull(aObject: TsgcObjectJSON): String;
begin
  if ListMode then
    Result := String(aObject.Value)
  else
    Result := '"' + aObject.Name + '":' + String(aObject.Value);
end;

function TsgcJSON.DoGetNumber(aObject: TsgcObjectJSON): String;
var
  vFS: TFormatSettings;
begin
  vFS.DecimalSeparator := '.';
  vFS.ThousandSeparator := ',';
  if ListMode then
    Result := String(FormatFloat('0.####', aObject.Value, vFS))
  else
    Result := '"' + aObject.Name + '":' + String(FormatFloat('0.####', aObject.Value, vFS));
end;

function TsgcJSON.DoGetObject(aObject: TsgcObjectJSON): String;
begin
  if ListMode then
  begin
    if aObject.JSONObject.Text <> '' then
      Result := aObject.JSONObject.Text;
  end
  else
  begin
    if aObject.JSONObject.Text <> '' then
      Result := '"' + aObject.Name + '":' + aObject.JSONObject.Text
    else
      Result := '"' + aObject.Name + '":""';
  end;
end;

function TsgcJSON.DoGetString(aObject: TsgcObjectJSON): String;
begin
  if ListMode then
    Result := '"' + String(aObject.Value) + '"'
  else
    Result := '"' + aObject.Name + '":"' + String(aObject.Value) + '"';
end;

function TsgcJSON.GetCount: Integer;
begin
  Result := Data.Count;
end;

function TsgcJSON.GetData: TsgcObjectJSONList;
begin
  if not Assigned(FData) then
  begin
    FData := TsgcObjectJSONList.Create;
    FData.OwnsObjects := True;
  end;
  Result := FData;
end;

function TsgcJSON.GetItem(i: integer): TsgcObjectJSON;
begin
  result := Data.GetItem(i);
end;

function TsgcJSON.GetNode(const aName: String): TsgcObjectJSON;
begin
  result := Data.GetNode(aName);
end;

procedure TsgcJSON.SetItem(i: integer; aValue: TsgcObjectJSON);
begin
  Data.SetItem(i, aValue);
end;

procedure TsgcJSON.SetNode(const aName: String; aValue: TsgcObjectJSON);
begin
  Data.SetNode(aName, aValue);
end;

function TsgcObjectJSONList.GetNode(const aName: String): TsgcObjectJSON;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to Count - 1 do
  begin
    if SameText(TsgcObjectJSON(Items[i]).Name, aName) then
    begin
      result := TsgcObjectJSON(Items[i]);
      break;
    end;
  end;
end;

function TsgcObjectJSONList.GetItem(i: Integer): TsgcObjectJSON;
begin
  if i < Count then
    Result := TsgcObjectJSON(Items[i])
  else
    Result := nil;
end;

procedure TsgcObjectJSONList.SetItem(i: Integer; aValue: TsgcObjectJSON);
begin
  if i < Count then
    Items[i] := aValue;
end;

procedure TsgcObjectJSONList.SetNode(const aName: String; aValue:
    TsgcObjectJSON);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if TsgcObjectJSON(Items[i]).Name = aName then
    begin
      Items[i] := aValue;
      break;
    end;
  end;
end;

procedure TsgcObjectJSON.Clear;
begin
  FreeAndNil(FJSONObject);
end;

function TsgcObjectJSON.GetCount: Integer;
begin
  Result := 0;
  if Assigned(FJSONObject) then
    result := JSONObject.Count;  
end;

function TsgcObjectJSON.GetJSONObject: TsgcJSON;
begin
  if not Assigned(FJSONObject) then
  begin
    FJSONObject := TsgcJSON.Create(self);
    JSONType := sgcJSONObject;
  end;
  Result := FJSONObject;
end;

function TsgcObjectJSON.GetNode(const aName: String): TsgcObjectJSON;
begin
  result := JSONObject.GetNode(aName);
end;

function TsgcObjectJSON.GetValue: Variant;
begin
  Result := FValue;
end;

procedure TsgcObjectJSON.SetNode(const aName: String; aValue:
    TsgcObjectJSON);
begin
  JSONObject.SetNode(aName, aValue);
end;

procedure TsgcObjectJSON.SetValue(const Value: Variant);
begin
  FValue := Value;
end;

end.
