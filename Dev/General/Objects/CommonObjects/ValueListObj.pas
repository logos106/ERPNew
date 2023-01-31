unit ValueListObj;

interface

uses
  classes, contnrs;

type
  TValueItemType = (vitNone, vitString, vitInteger, vitFloat, vitBoolean);

  TValueItem = class
  private
    fName: string;
    fValueType: TValueItemType;
    fBool: boolean;
    fStr: string;
    fFloat: double;
    fInt: integer;
    fIsNull: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetAsString: string;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: double);
    procedure SetAsinteger(const Value: integer);
    procedure SetAsString(const Value: string);
    function GetAsBoolean: boolean;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetName(const Value: string);
  public
    constructor Create;
    property Name: string read fName write SetName;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsinteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property ValueType: TValueItemType read fValueType;
    property IsNull: boolean read fIsNull;
    procedure Clear;
  end;

  TValueList = class
  private
    fList: TObjectList;
    function GetByName(aName: string): TValueItem;
    function GetCount: integer;
    function GetItem(idx: integer): TValueItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    property Items[idx: integer]: TValueItem read GetItem;
    property ByName[aName: string]: TValueItem read GetByName;
//    function Exists(aName: String): boolean;
  end;

implementation

uses
  sysutils;

{ TValueItem }

procedure TValueItem.Clear;
begin
  fBool:= false;
  fStr:= '';
  fFloat:= 0;
  fInt:= 0;
  fIsNull:= true;
end;

constructor TValueItem.Create;
begin
  fValueType:= vitNone;
  Clear;
end;

function TValueItem.GetAsBoolean: boolean;
begin
  case fValueType of
    vitNone:    result:= false;
    vitString:  result:= LowerCase(fStr) = 'true';
    vitInteger: result:= fInt = 1;
    vitFloat:   result:= fInt = 1;
    vitBoolean: result:= fBool;
    else        result:= false;
  end
end;

function TValueItem.GetAsDateTime: TDateTime;
begin
  result:= GetAsFloat;
end;

function TValueItem.GetAsFloat: double;
begin
  case fValueType of
    vitNone:    result:= 0;
    vitString:  result:= StrToFloatDef(fStr, 0);
    vitInteger: result:= fInt;
    vitFloat:   result:= fFloat;
    vitBoolean: if fBool then result:= 1 else result:= 0;
    else        result:= 0;
  end
end;

function TValueItem.GetAsInteger: integer;
begin
  case fValueType of
    vitNone:    result:= 0;
    vitString:  result:= StrToIntDef(fStr, 0);
    vitInteger: result:= fInt;
    vitFloat:   result:= fInt;
    vitBoolean: if fBool then result:= 1 else result:= 0;
    else        result:= 0;
  end
end;

function TValueItem.GetAsString: string;
begin
  case fValueType of
    vitNone:    result:= '';
    vitString:  result:= fStr;
    vitInteger: result:= IntToStr(fInt);
    vitFloat:   result:= FloatToStr(fFloat);
    vitBoolean: if fBool then result:= 'true' else result:= 'false';
    else        result:= '';
  end
end;

procedure TValueItem.SetAsBoolean(const Value: boolean);
begin
  case fValueType of
    vitNone:    begin
                  fValueType:= vitBoolean;
                  fBool:= value;
                end;
    vitString:  if Value then fStr:= 'true' else fStr:= 'false' ;
    vitInteger: if Value then fInt:= 1 else fInt:= 0;
    vitFloat:   if Value then fFloat:= 1 else fFloat:= 0;
    vitBoolean: fBool:= Value;
    else        raise Exception.Create('TValueItem - Inavlid value item type');
  end;
  fIsNull:= false;
end;

procedure TValueItem.SetAsDateTime(const Value: TDateTime);
begin
  SetAsFloat(Value);
end;

procedure TValueItem.SetAsFloat(const Value: double);
begin
  case fValueType of
    vitNone:    begin
                  fValueType:= vitFloat;
                  fFloat:= value;
                end;
    vitString:  fStr:= FloatToStr(Value);
    vitInteger: fInt:= Trunc(Value);
    vitFloat:   fFloat:= Value;
    vitBoolean: fBool:= Value <> 0;
    else        raise Exception.Create('TValueItem - Inavlid value item type');
  end;
  fIsNull:= false;
end;

procedure TValueItem.SetAsinteger(const Value: integer);
begin
  case fValueType of
    vitNone:    begin
                  fValueType:= vitInteger;
                  fInt:= value;
                end;
    vitString:  fStr:= IntToStr(Value);
    vitInteger: fInt:= Value;
    vitFloat:   fFloat:= Value;
    vitBoolean: fBool:= Value <> 0;
    else        raise Exception.Create('TValueItem - Inavlid value item type');
  end;
  fIsNull:= false;
end;

procedure TValueItem.SetAsString(const Value: string);
begin
  case fValueType of
    vitNone:    begin
                  fValueType:= vitString;
                  fStr:= value;
                end;
    vitString:  fStr:= Value;
    vitInteger: fInt:= StrToIntDef(Value,0);
    vitFloat:   fFloat:= StrToFloatDef(Value,0);
    vitBoolean: fBool:= LowerCase(Value) = 'true' ;
    else        raise Exception.Create('TValueItem - Inavlid value item type');
  end;
  fIsNull:= false;
end;

procedure TValueItem.SetName(const Value: string);
begin
  fName := LowerCase(Value);
end;

{ TValueList }

procedure TValueList.Clear;
begin
  fList.Clear;
end;

constructor TValueList.Create;
begin
  fList:= TObjectList.Create;
end;

destructor TValueList.Destroy;
begin
  try
    fList.Free;
    inherited;
  except

  end;
end;

function TValueList.GetByName(aName: string): TValueItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    if Items[x].Name = LowerCase(aName) then begin
      result:= Items[x];
      break;
    end;
  end;
  if not Assigned(result) then begin
    result:= TValueItem.Create;
    result.Name:= aName;
    fList.Add(result);
  end;
end;

function TValueList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TValueList.GetItem(idx: integer): TValueItem;
begin
  result:= TValueItem(fList[idx]);
end;

end.
