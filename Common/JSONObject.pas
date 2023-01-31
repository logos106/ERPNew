unit JSONObject;

{ http://www.json.org/ }

{  Notes:

   DateTime will be stored as a string in the format: yyyy-mm-dd hh:nn:ss

}

interface

uses
  contnrs, classes;

type
  TJSONValueType = (valNone, valString, valNumber, valObject, valArray, valNull, valBoolean);

  TJSONObject = class;

  TJSONValue = class
  private
    fbIgnoreNull    : Boolean;
    fDatetimeDefault: TDatetime;
    fFloatDefault   : Double;
    fStringDefault  : String;
    fIntegerDefault : Integer;
    fBooleanDefault : Boolean;
  protected
    function GetValueType: TJSONValueType; virtual;
    function GetAsBoolean: boolean; virtual;
    function GetAsFloat: double; virtual;
    function GetAsInteger: int64; virtual;
    function GetAsString: string; virtual;
    function GetAsObject: TJsonObject; virtual;
    procedure SetAsBoolean(const aValue: boolean); virtual;
    procedure SetAsFloat(const aValue: double);  virtual;
    procedure SetAsInteger(const aValue: int64); virtual;
    procedure SetAsString(const aValue: string); virtual;
    function GetAsDateTime: TDateTime; virtual;
    procedure SetAsDateTime(const Value: TDateTime); virtual;
    procedure SetAsObject(const Value: TJsonObject); virtual;
  public
    constructor Create;
    property ValueType: TJSONValueType read GetValueType;
    procedure ReadFromStream(stream: TStream); virtual;
    procedure SaveToStream(stream: TStream); virtual;
    procedure Read(Reader: TTextReader); virtual;
    procedure Write(Writer: TTextWriter); virtual;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: int64 read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsObject: TJsonObject read GetAsObject write SetAsObject;
    function IsTypeNone: boolean;
    function IsTypeString: boolean;
    function IsTypeNumber: boolean;
    function IsTypeObject: boolean;
    function IsTypeArray: boolean;
    function IsTypeNull: boolean;
    function IsTypeBoolean: boolean;
    function IsBlank: boolean;
    property IgnoreNull     :Boolean    read fbIgnoreNull      write fbIgnoreNull     ;
    Property StringDefault  :String     read fStringDefault    write fStringDefault   ;
    Property IntegerDefault :Integer    read fIntegerDefault   write fIntegerDefault  ;
    Property FloatDefault   :Double     read fFloatDefault     write fFloatDefault    ;
    Property BooleanDefault :Boolean    read fBooleanDefault   write fBooleanDefault  ;
    Property DatetimeDefault:TDatetime  read fDatetimeDefault  write fDatetimeDefault ;
  end;

  TJSONValuePair = class
  private
    function GetValueType: TJSONValueType;
    procedure SetValueType(const aValue: TJSONValueType);
  public
    Name: string;
    Value: TJSONValue;
    constructor Create(aValueType: TJSONValueType = valNull);
    destructor Destroy; override;
    procedure ReadFromStream(stream: TStream);
    procedure SaveToStream(stream: TStream);
    procedure Read(Reader: TTextReader);
    procedure Write(Writer: TTextWriter);
    property ValueType: TJSONValueType read GetValueType write SetValueType;
  end;

  { Values ... }

  TJSONString = class(TJSONValue)
  private
    fValue: string;
    function GetValue: string;
    procedure SetValue(const aValue: string);
  protected
    function GetValueType: TJSONValueType; override;
    function GetAsBoolean: boolean; override;
    function GetAsFloat: double; override;
    function GetAsInteger: int64; override;
    function GetAsString: string; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    procedure SetAsFloat(const aValue: double);  override;
    procedure SetAsInteger(const aValue: int64); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsDateTime: TDateTime; override;
    procedure SetAsDateTime(const aValue: TDateTime); override;
  public
    property Value: string read GetValue write SetValue;
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
  end;

  TJSONNumber = class(TJSONValue)
  protected
    function GetValueType: TJSONValueType; override;
    function GetAsBoolean: boolean; override;
    function GetAsFloat: double; override;
    function GetAsInteger: int64; override;
    function GetAsString: string; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    procedure SetAsFloat(const aValue: double);  override;
    procedure SetAsInteger(const aValue: int64); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsDateTime: TDateTime; override;
    procedure SetAsDateTime(const aValue: TDateTime); override;
  public
    Value: double;
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
  end;

  TJSONArray = class(TJSONValue)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(index: integer): TJSONValue;
  protected
    function GetValueType: TJSONValueType; override;
    function GetAsString: string; override;
    procedure SetAsString(const aValue: string); override;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Items[index: integer]: TJSONValue read GetItem; default;
    function Add(aValue: TJSONValue): integer; overload;
    function Add(aString: string): integer; overload;
    function AddObject: TJsonObject;
    function Extract(index: integer): TJSONValue;
    procedure Delete(index: integer); overload;
    procedure Delete(aObj: TObject); overload;
    procedure Clear;
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
    procedure Assign(source: TJSONArray);
    function ObjByPropVal(const aPropName, aPropVal: string): TJsonObject;
  end;

  TJSONObject = class(TJSONValue)
  private
    fList: TObjectList;
    fFormatOutput: boolean;

    function GetCount: integer;
    function GetItem(index: integer): TJSONValuePair;
    function GetItemByName(aName: string): TJSONValuePair;
    function GetBooleanByName(aName: string): boolean;
    function GetFloatByName(aName: string): double;
    function GetIntegerByName(aName: string): int64;
    function GetObjectByName(aName: string): TJSONObject;
    function GetStringByName(aName: string): string;
    procedure SetFloatByName(aName: string; const Value: double);
    procedure SetIntegerByName(aName: string; const Value: int64);
    procedure SetStringByName(aName: string; const Value: string);
    procedure SetBooleanByName(aName: string; const Value: boolean);
    function GetArrayByName(aName: string): TJSONArray;
    procedure SetArrayByName(aName: string; const Value: TJSONArray);
    procedure SetObjectByName(aName: string; const Value: TJSONObject);
    function GetDateTimeByName(aName: string): TDateTime;
    procedure SetDateTimeByName(aName: string; const Value: TDateTime);
    function GetValueByName(aName: string): TJSONValue;
    procedure SetFormatOutput(const Value: boolean);
  protected
    function GetValueType: TJSONValueType; override;
    function GetAsString: string; override;
    procedure SetAsString(const aValue: string); override;
    function GetAsObject: TJsonObject; override;
    procedure SetAsObject(const Value: TJsonObject); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Items[index: integer]: TJSONValuePair read GetItem; default;
    property ItemByName[aName: string]: TJSONValuePair read GetItemByName;
    property ValueByName[aName: string]: TJSONValue read GetValueByName;
    property ObjectByName[aName: string]: TJSONObject read GetObjectByName write SetObjectByName;
    property StringByName[aName: string]: string read GetStringByName write SetStringByName;
    property IntegerByName[aName: string]: int64 read GetIntegerByName write SetIntegerByName;
    property FloatByName[aName: string]: double read GetFloatByName write SetFloatByName;
    property BooleanByName[aName: string]: boolean read GetBooleanByName write SetBooleanByName;
    property ArrayByName[aName: string]: TJSONArray read GetArrayByName write SetArrayByName;
    property DateTimeByName[aName: string]: TDateTime read GetDateTimeByName write SetDateTimeByName;

    property O[aName: string]: TJSONObject read GetObjectByName write SetObjectByName;
    property S[aName: string]: string read GetStringByName write SetStringByName;
    property I[aName: string]: int64 read GetIntegerByName write SetIntegerByName;
    property F[aName: string]: double read GetFloatByName write SetFloatByName;
    property B[aName: string]: boolean read GetBooleanByName write SetBooleanByName;
    property A[aName: string]: TJSONArray read GetArrayByName write SetArrayByName;
    property DT[aName: string]: TDateTime read GetDateTimeByName write SetDateTimeByName;

    function Exists(aName: string): boolean;
    function ObjectExists(aName: string): boolean;
    function StringExists(aName: string): boolean;
    { Non-empty exists }
    function NEStringExists(aName: string): boolean;
    function IntegerExists(aName: string): boolean;
    function FloatExists(aName: string): boolean;
    function BooleanExists(aName: string): boolean;
    function ArrayExists(aName: string): boolean;

    function Add(aPair: TJSONValuePair): integer; overload;
    function Add(aName: string; aValue: TJSONValue): integer; overload;
    function Add(aName: string; aValueType: TJSONValueType): integer; overload;

    procedure Clear;
    procedure Delete(index: integer); overload;
    procedure Delete(itemName: string); overload;
    function Extract(index: integer): TJSONValuePair;
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
    procedure LoadFromFile(aFileName: string);
    procedure SaveToFile(aFileName: string);
    procedure Assign(source: TJSONObject);
    property FormatOutput: boolean read fFormatOutput write SetFormatOutput;
    class function StrToJsonObject(const aJsonStr: string): TJsonObject;
  end;

  TJSONNull = class(TJSONValue)
  protected
    function GetValueType: TJSONValueType; override;
  public
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
  end;

  TJSONBoolean = class(TJSONValue)
  protected
    function GetValueType: TJSONValueType; override;
    function GetAsBoolean: boolean; override;
    function GetAsFloat: double; override;
    function GetAsInteger: int64; override;
    function GetAsString: string; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    procedure SetAsFloat(const aValue: double);  override;
    procedure SetAsInteger(const aValue: int64); override;
    procedure SetAsString(const aValue: string); override;
  public
    Value: boolean;
    procedure ReadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;
    procedure Read(Reader: TTextReader); override;
    procedure Write(Writer: TTextWriter); override;
  end;

  function JO(const str: string = '{}'): TJSONObject;
  function EncodeString(s: string): string;
  function DecodeString(s: string): string;
  function StrIsDateTime(s: string; var dt: TDateTime): boolean;
  function FloatToString(const f: Extended): string;

//  function StrToValueType(const str: string): TJSONValueType;

const
  JsonDateTimeFormat = 'yyyy-mm-dd hh:nn:ss';

implementation

uses
  {$IfDef VER220}
  Types,
  {$Else}
  System.Types,
  {$EndIf  }
  SysUtils, StrUtils, DateUtils{, LogThreadLib};

function JO(const str: string = '{}'): TJSONObject;
begin
  result:= TJSONObject.Create;
  try
    result.AsString:= str;
  except
    raise;
  end;
end;

function Occurrences(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

{ General Functions }

function EncodeString(s: string): string;
var
  x: integer;
begin
  result:= '';
  if trim(s) ='' then begin
    result := '';
    Exit;
  end;
  try
    for x:= 1 to Length(s) do begin
      case Ord(s[x]) of
        34: result:= result + '\"';  // " char
        92: result:= result + '\\';  // \ char
        47: result:= result + '\/';  // / char
        08: result:= result + '\b';  // backspace
        12: result:= result + '\f';  // form feed
        10: result:= result + '\n';  // new line (line feed)
        13: result:= result + '\r';  // carriage return
        09: result:= result + '\t';  // horizontal tab
        else
          result:=result + s[x];
      end;
    end;
  except
    on e: exception do begin
      raise Exception.Create('Encode String exception, in string: "' + s +
      '", Length: ' + IntToStr(Length(s)) + ' Message: ' + e.Message);

    end;
  end;
end;

function DecodeString(s: string): string;
var
  x: integer;
begin
  result:= '';
  x:= 1;
  while x <= Length(s) do begin
    if s[x] = '\' then begin
      case Ord(s[x+1]) of
        34: begin
              result:= result + '"';
              Inc(x);
            end;
        92: begin
              result:= result + '\';
              Inc(x);
            end;
        47: begin
              result:= result + '/';
              Inc(x);
            end;
        98: begin                        // backspace
              result:= result + Chr(8);
              Inc(x);
            end;
        102: begin                       // form feed
              result:= result + Chr(12);
              Inc(x);
            end;
        110: begin                       // new line
              result:= result + Chr(10);
              Inc(x);
            end;
        114: begin                      // carriage return
              result:= result + Chr(13);
              Inc(x);
            end;
        116: begin                      // horizontal tab
              result:= result + Chr(09);
              Inc(x);
            end;
        else
          result:= result + s[x];
      end;
    end
    else
      result:= result + s[x];
    Inc(x);
  end;
end;

{ checks for JsonDateTimeFormat (yyyy-mm-dd hh:nn:ss) }
function StrIsDateTime(s: string; var dt: TDateTime): boolean;
var
  year, month, day, hour, min, sec: word;
begin
  result := false;
  if Length(s) <> Length(JsonDateTimeFormat) then exit;
  if s[5] <> '-' then exit;
  if s[8] <> '-' then exit;
  if s[11] <> ' ' then exit;
  if s[14] <> ':' then exit;
  if s[17] <> ':' then exit;
  try
    year := StrToInt(Copy(s,1,4));
    month := StrToInt(Copy(s,6,2));
    day := StrToInt(Copy(s,9,2));

    hour := StrToInt(Copy(s,12,2));
    min := StrToInt(Copy(s,15,2));
    sec := StrToInt(Copy(s,18,2));
    dt:= EncodeDateTime(year,month,day,hour,min,sec,0);
  except
    exit;
  end;
  result := true;
end;

function IsNumberChar(ch: Char): boolean;
begin
  result:= CharInSet(ch , ['0'..'9']);
end;

function IsLetterChar(ch: Char): boolean;
begin
  result:= CharInSet(ch , ['a'..'z', 'A'..'Z']);
end;

function IsControlChar(ch: Char): boolean;
begin
  result:= Ord(ch) < 32;
end;

function IsFormatChar(ch: Char): boolean;
begin
  result:= CharInSet(ch , [#13,#10,#9,' ']);
end;

function StringToFloat(const s: string): Extended;
var
  DecimalSep: char;
begin
  try
    result := StrToFloat(s);
  except
    on EConvertError do begin
      if FormatSettings.DecimalSeparator <> '.' then begin
        DecimalSep := FormatSettings.DecimalSeparator;
        try
          FormatSettings.DecimalSeparator := '.';
          result := StrToFloat(s);
        finally
          FormatSettings.DecimalSeparator := DecimalSep;
        end;
      end
      else
        raise;
    end
    else
      raise;
  end;
end;

function StringToFloatDef(const s: string; Default: Extended): Extended;
begin
  try
    result := StringToFloat(s);
  except
    result := Default;
  end;
end;

function FloatToString(const f: Extended): string;
var
  DecimalSep: char;
begin
  DecimalSep := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    result := FloatToStr(f);
  finally
    FormatSettings.DecimalSeparator := DecimalSep;
  end;
end;


function ReadStringValue(stream: TStream): string; Overload;
var
  StartFound, EndFound: boolean;
  ch, nextCh: Char;
begin
  result:= '';
  StartFound:= false;
  EndFound:= false;
  while stream.Position < stream.Size do begin
    if stream.Read(Ch,1) < 1 then
      Break;
    if StartFound then begin
      if IsControlChar(ch) then
        { ignore }

      else if (ch = '\') then begin
        if stream.Read(nextCh,1) = 1 then begin
          case Ord(nextCh) of
            34: result:= result + '"';
            92: result:= result + '\';
            47: result:= result + '/';
            98: result:= result + Chr(8);    // backspace
            102: result:= result + Chr(12);  // form feed
            110: result:= result + Chr(10);  // new line
            114: result:= result + Chr(13);  // carriage return
            116: result:= result + Chr(09);  // horizontal tab
            else begin
              stream.Seek(-SizeOf(ch),soFromCurrent);
              result:= result + ch;
            end;
          end
        end;
      end
      else begin
        if (ch = '"') then begin
          { end of string }
          EndFound:= true;
          Break;
        end
        else
          result:= result + Ch;
      end;
    end
    else begin
      { start not found }
      if not IsFormatChar(ch) then begin
        if ch = '"' then
          StartFound := true
        else
          { error ... must start with " }
          Break;
      end;
    end;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('String Parse Error - Invalid string format')
end;

function ReadStringValue(Reader: TTextReader): string; overload;
var
  StartFound, EndFound: boolean;
  ch: Char;
  CharAsInt, NextCharAsInt: integer;
begin
  result:= '';
  StartFound:= false;
  EndFound:= false;
  CharAsInt:= Reader.Peek;
  while CharAsInt >= 0 do begin
    CharAsInt:= Reader.Peek;
    if CharAsInt < 0 then
      break;
    ch:= Char(Reader.Read);
    if StartFound then begin
      if IsControlChar(ch) then
        { ignore }
      else if (ch = '\') then begin
        NextCharAsInt:= Reader.Peek;
        { check for escaped characters }
        if NextCharAsInt >= 0 then begin
          case NextCharAsInt of
            34: begin result:= result + '"'; Reader.Read; end;
            92: begin result:= result + '\'; Reader.Read; end;
            47: begin result:= result + '/'; Reader.Read; end;
            98: begin result:= result + Chr(8); Reader.Read; end;   // backspace
            102: begin result:= result + Chr(12); Reader.Read; end; // form feed
            110: begin result:= result + Chr(10); Reader.Read; end; // new line
            114: begin result:= result + Chr(13); Reader.Read; end; // carriage return
            116: begin result:= result + Chr(09); Reader.Read; end; // horizontal tab
            else begin
              result:= result + Char(Reader.Read);
            end;
          end
        end;
      end
      else begin
        if (ch = '"') then begin
          { end of string }
          EndFound:= true;
          break;
        end
        else
          result:= result + Ch;
      end;
    end
    else begin
      { start not found }
      if not IsFormatChar(ch) then begin
        if ch = '"' then
          StartFound := true
        else
          { error ... must start with " }
          break;
      end;
    end;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('String Parse Error - Invalid string format')
end;

function ReadNumberValue(stream: TStream): double; overload;
var
  StartFound, EndFound, decimalFound, powerFound: boolean;
  ch, prevCh: Char;
  strResult: string;
begin
  result:= 0;
  strResult:= '';
  prevCh:= ' ';
  StartFound:= false;
  EndFound:= false;
  decimalFound:= false;
  powerFound:= false;
  while stream.Position < stream.Size do begin
    if stream.Read(Ch,1) < 1 then
      Break;
    if StartFound then begin
      if IsNumberChar(ch) then
        strResult:= strResult + ch
      else if (ch = '.') then begin
        if not decimalFound then begin
          strResult:= strResult + ch;
          decimalFound:= true;
        end
        else
          raise Exception.Create('Number Parse Error - Invalid format, second decimal point found');
      end
      else if (CharInSet(ch , ['e','E'])) then begin
        if not powerFound then begin
          strResult:= strResult + ch;
          powerFound:= true;
        end
        else
          raise Exception.Create('Number Parse Error - Invalid format, scientific exponent repeated');
      end
      else if (CharInSet(ch , ['-','+'])) then begin
        if (CharInSet(prevCh,['e','E'])) then
          strResult:= strResult + ch
        else
          raise Exception.Create('Number Parse Error - Invalid number format');
      end
      else if IsFormatChar(ch) or (CharInSet(ch,[',',']','}'])) then begin
        EndFound:= true;
        stream.Seek(-SizeOf(ch), soFromCurrent);
        break;
      end;
    end
    else begin
      { start not found }
      if IsNumberChar(ch) or (CharInSet(ch,['-','.'])) then begin
        StartFound := true;
        strResult:= ch;
      end
      else if IsFormatChar(ch) then begin
        { do nothing ... ignore file formatting }
      end
      else
        raise Exception.Create('Number Parse Error - Invalid format, number not found');
    end;
    prevCh:= ch;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('Number Parse Error - Invalid number format');
  if strResult <> '' then
    result:= StringToFloat(strResult);
end;

function ReadNumberValue(Reader: TTextReader): double; overload;
var
  StartFound, EndFound, decimalFound, powerFound: boolean;
  ch, prevCh: Char;
  CharAsInt: integer;
  strResult: string;
begin
  result:= 0;
  strResult:= '';
  prevCh:= ' ';
  StartFound:= false;
  EndFound:= false;
  decimalFound:= false;
  powerFound:= false;
  CharAsInt:= Reader.Peek;
  while CharAsInt >= 0 do begin
    CharAsInt:= Reader.Peek;
    if CharAsInt < 0 then
      break;
    ch:= Char(CharAsInt);
    if StartFound then begin
      if IsNumberChar(ch) then begin
        strResult:= strResult + ch;
        Reader.Read;  { advance to next character }
      end
      else if (ch = '.') then begin
        Reader.Read;  { advance to next character }
        if not decimalFound then begin
          strResult:= strResult + ch;
          decimalFound:= true;
        end
        else
          raise Exception.Create('Number Parse Error - Invalid format, second decimal point found');
      end
      else if (CharInSet(ch , ['e','E'])) then begin
        Reader.Read;  { advance to next character }
        if not powerFound then begin
          strResult:= strResult + ch;
          powerFound:= true;
        end
        else
          raise Exception.Create('Number Parse Error - Invalid format, scientific exponent repeated');
      end
      else if (CharInSet(ch,['-','+'])) then begin
        Reader.Read;  { advance to next character }
        if (CharInSet(prevCh,['e','E'])) then
          strResult:= strResult + ch
        else
          raise Exception.Create('Number Parse Error - Invalid number format');
      end
      else if IsFormatChar(ch) or (CharInSet(ch,[',',']','}'])) then begin
        EndFound:= true;
        { dont advance to next }
        break;
      end;
    end
    else begin
      { start not found }
      Reader.Read;  { advance to next character }
      if IsNumberChar(ch) or (CharInSet(ch,['-','.'])) then begin
        StartFound := true;
        strResult:= ch;
      end
      else if IsFormatChar(ch) then begin
        { do nothing ... ignore file formatting }
      end
      else
        raise Exception.Create('Number Parse Error - Invalid format, number not found');
    end;
    prevCh:= ch;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('Number Parse Error - Invalid number format');
  if strResult <> '' then
    result:= StringToFloat(strResult);
end;

function ReadBoolNullStrValue(stream: TStream): string; overload;
var
  ch: Char;
  StartFound: boolean;
begin
  result:= '';
  StartFound:= false;
  while stream.Position < stream.Size do begin
    if stream.Read(Ch,1) < 1 then
      Break;

    if StartFound then begin
      if (CharInSet(ch,['t','r','u','e','f','a','l','s','n'])) then
        result:= result + ch
      else begin
        if CharInSet(ch,[',','}']) then
          stream.Seek(-SizeOf(ch), soFromCurrent);
        break;
      end;
    end
    else begin
      { start not found }
      if (CharInSet(ch,['t','f','n'])) then begin
        result:= ch;
        StartFound:= true;
      end
      else if IsFormatChar(ch) then begin
        { do nothing }
      end
      else
        raise Exception.Create('Value Parse Error - Invalid value');
    end;
  end;
end;

function ReadBoolNullStrValue(Reader: TTextReader): string; overload;
var
  ch: Char;
  CharAsInt: integer;
  StartFound: boolean;
begin
  result:= '';
  StartFound:= false;
  CharAsInt:= Reader.Peek;
  while CharAsInt >= 0 do begin
    CharAsInt:= Reader.Peek;
    if CharAsInt < 0 then
      Break;
    ch:= Char(CharAsInt);
    if StartFound then begin
      if (CharInSet(ch,['t','r','u','e','f','a','l','s','n'])) then begin
        result:= result + ch;
        Reader.Read; { advance to next character }
      end
      else begin
        if not (CharInSet(ch,[',','}'])) then
          Reader.Read; { advance to next character }
        break;
      end;
    end
    else begin
      { start not found }
      Reader.Read; { advance to next character }
      if (CharInSet(ch,['t','f','n'])) then begin
        result:= ch;
        StartFound:= true;
      end
      else if IsFormatChar(ch) then begin
        { do nothing }
      end
      else
        raise Exception.Create('Value Parse Error - Invalid value');
    end;
  end;
end;

procedure StrToStream(str: string; stream: TStream);
var s: string;
begin
  s:= str;
  stream.Write(s[1],Length(s));
end;

procedure StrToWriter(str: string; Writer: TTextWriter);
var
  x: integer;
begin
  for x := 1 to Length(str) do
    Writer.Write(Str[x]);
end;

{ TJSONValue }

constructor TJSONValue.Create;
begin
    fbIgnoreNull    := False;
    fStringDefault  := '';
    fIntegerDefault := 0;
    fFloatDefault   := 0;
    fBooleanDefault := False;
    fDatetimeDefault:= 0;
end;

function TJSONValue.GetAsBoolean: boolean;
begin
  raise Exception.Create(ClassName + '.GetAsBoolean - Not supported');
end;

function TJSONValue.GetAsDateTime: TDateTime;
begin
  raise Exception.Create(ClassName + '.GetAsDateTime - Not supported');
end;

function TJSONValue.GetAsFloat: double;
begin
  raise Exception.Create(ClassName + '.GetAsFloat - Not supported');
end;

function TJSONValue.GetAsInteger: int64;
begin
  raise Exception.Create(ClassName + '.GetAsInteger - Not supported');
end;

function TJSONValue.GetAsObject: TJsonObject;
begin
//  raise Exception.Create('TJSONValue.GetAsObject - Not supported');
  result:= nil;
end;

function TJSONValue.GetAsString: string;
begin
  raise Exception.Create(ClassName + '.GetAsString - Not supported');
end;

function TJSONValue.GetValueType: TJSONValueType;
begin
  result:= valNone;
end;

function TJSONValue.IsBlank: boolean;
begin
  result := false;
  case ValueType of
    valNone: result := true;
    valString: result := AsString = '';
    valNumber: result := AsFloat = 0;
    valObject: result := AsObject.Count = 0;
    valArray: result := TJsonArray(self).Count = 0;
    valNull: result := true;
    valBoolean: result := false;
  end;
end;

function TJSONValue.IsTypeArray: boolean;
begin
  result := ValueType = valArray;
end;

function TJSONValue.IsTypeBoolean: boolean;
begin
  result := ValueType = valBoolean;
end;

function TJSONValue.IsTypeNone: boolean;
begin
  result := ValueType = valNone;
end;

function TJSONValue.IsTypeNull: boolean;
begin
  result := ValueType = valNull;
end;

function TJSONValue.IsTypeNumber: boolean;
begin
  result := ValueType = valNumber;
end;

function TJSONValue.IsTypeObject: boolean;
begin
  result := ValueType = valObject;
end;

function TJSONValue.IsTypeString: boolean;
begin
  result := ValueType = valString;
end;

procedure TJSONValue.Read(Reader: TTextReader);
begin
  raise Exception.Create(ClassName + '.Read - Not supported');
end;

procedure TJSONValue.ReadFromStream(stream: TStream);
begin
  raise Exception.Create(ClassName + '.ReadFromStream - Not supported');
end;

procedure TJSONValue.SaveToStream(stream: TStream);
begin
  raise Exception.Create(ClassName + '.SaveToStream - Not supported');
end;

procedure TJSONValue.SetAsBoolean(const aValue: boolean);
begin
  raise Exception.Create(ClassName + '.SetAsBoolean - Not supported');
end;

procedure TJSONValue.SetAsDateTime(const Value: TDateTime);
begin
  raise Exception.Create(ClassName + '.SetAsDateTime - Not supported');
end;

procedure TJSONValue.SetAsFloat(const aValue: double);
begin
  raise Exception.Create(ClassName + '.SetAsFloat - Not supported');
end;

procedure TJSONValue.SetAsInteger(const aValue: int64);
begin
  raise Exception.Create(ClassName + '.SetAsFloat - Not supported');
end;

procedure TJSONValue.SetAsObject(const Value: TJsonObject);
begin
  raise Exception.Create(ClassName + '.SetAsObject - Not supported');
end;

procedure TJSONValue.SetAsString(const aValue: string);
begin
  raise Exception.Create(ClassName + '.SetAsString - Not supported');
end;

procedure TJSONValue.Write(Writer: TTextWriter);
begin
  raise Exception.Create(ClassName + '.Write - Not supported');
end;

{ TJSONString }

function TJSONString.GetAsBoolean: boolean;
begin
  result:= Value = 'true';
end;

function TJSONString.GetAsDateTime: TDateTime;
var
  ShortDateFormatSave: string;
  DateSeparatorSave: Char;
begin
  if Value = '' then
    result:= 0
  else begin
    if Occurrences('-',Value) = 2 then begin

      ShortDateFormatSave:= FormatSettings.ShortDateformat;
      DateSeparatorSave:= FormatSettings.DateSeparator;
      try
        FormatSettings.ShortDateformat:= 'yyyy-mm-dd';
        FormatSettings.DateSeparator:= '-';
        result:= StrToDateTime(Value);
      finally
        FormatSettings.ShortDateformat:= ShortDateFormatSave;
        FormatSettings.DateSeparator:= DateSeparatorSave;
      end;
    end
    else if Occurrences(':',Value) = 2 then begin
      { time part only }
      result := StrToTime(Value);
    end
    else
      result := StringToFloat(Value);
  end;
end;

function TJSONString.GetAsFloat: double;
begin
  result:= StringToFloatDef(Value,0);
end;

function TJSONString.GetAsInteger: int64;
begin
  result:= StrToIntDef(Value,0);
end;

function TJSONString.GetValue: string;
begin
  result := DecodeString(fValue);
end;

function TJSONString.GetValueType: TJSONValueType;
begin
  result:= valString;
end;

procedure TJSONString.Read(Reader: TTextReader);
begin
  Value:= ReadStringValue(Reader);
end;

procedure TJSONString.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONString.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONString.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 'true'
  else Value:= 'false';
end;

procedure TJSONString.SetAsDateTime(const aValue: TDateTime);
var
  ShortDateFormatSave, LongTimeFormatSave: string;
  DateSeparatorSave: Char;
begin
  ShortDateFormatSave:= FormatSettings.ShortDateformat;
  DateSeparatorSave:= FormatSettings.DateSeparator;
  LongTimeFormatSave:= FormatSettings.LongTimeFormat;
  try
    FormatSettings.ShortDateformat:= 'yyyy-mm-dd';
    FormatSettings.DateSeparator:= '-';
    FormatSettings.LongTimeFormat:= 'hh:nn:ss';
    Value:= DateTimeToStr(aValue);
  finally
    FormatSettings.ShortDateformat:= ShortDateFormatSave;
    FormatSettings.DateSeparator:= DateSeparatorSave;
    FormatSettings.LongTimeFormat:= LongTimeFormatSave;
  end;
end;

procedure TJSONString.SetAsFloat(const aValue: double);
begin
  Value:= FloatToString(aValue);
end;

procedure TJSONString.SetAsInteger(const aValue: int64);
begin
  Value:= IntToStr(aValue);
end;

procedure TJSONString.SetAsString(const aValue: string);
begin
  Value:= aValue;
end;

procedure TJSONString.SetValue(const aValue: string);
begin
  fVAlue := EncodeString(aValue);
end;

procedure TJSONString.Write(Writer: TTextWriter);
begin
  StrToWriter('"' + fValue + '"', Writer);
end;

function TJSONString.GetAsString: string;
begin
  result:= Value;
end;


{ TJSONNumber }

function TJSONNumber.GetAsBoolean: boolean;
begin
  if Value = 0 then result:= false
  else result:= true;
end;

function TJSONNumber.GetAsDateTime: TDateTime;
begin
  result:= Value;
end;

function TJSONNumber.GetAsFloat: double;
begin
  result:= Value;
end;

function TJSONNumber.GetAsInteger: int64;
begin
  result:= Trunc(Value);
end;

function TJSONNumber.GetAsString: string;
begin
  result:= FloatToString(Value);
end;

function TJSONNumber.GetValueType: TJSONValueType;
begin
  result:= valNumber;
end;

procedure TJSONNumber.Read(Reader: TTextReader);
begin
  Value:= ReadNumberValue(Reader);
end;

procedure TJSONNumber.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONNumber.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONNumber.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 1
  else Value:= 0;
end;

procedure TJSONNumber.SetAsDateTime(const aValue: TDateTime);
begin
  Value:= aValue;
end;

procedure TJSONNumber.SetAsFloat(const aValue: double);
begin
  Value:= aValue;
end;

procedure TJSONNumber.SetAsInteger(const aValue: int64);
begin
  Value:= aValue;
end;

procedure TJSONNumber.SetAsString(const aValue: string);
begin
  Value:= StringToFloatDef(aValue,0);
end;

procedure TJSONNumber.Write(Writer: TTextWriter);
begin
  StrToWriter(FloatToString(Value),Writer);
end;

{ TJSONObject }

function TJSONObject.Add(aName: string; aValue: TJSONValue): integer;
var
  item: TJSONValuePair;
begin
  item:= TJSONValuePair.Create;
  item.Name:= aName;
  item.Value:= aValue;
  result:= self.Add(item);
end;

function TJSONObject.Add(aPair: TJSONValuePair): integer;
begin
  result:= fList.Add(aPair);
end;

procedure TJSONObject.Assign(source: TJSONObject);
var
  stream: TMemoryStream;
begin
  stream:= TMemoryStream.Create;
  try
    source.SaveToStream(stream);
    stream.Position:= 0;
    self.Clear;
    self.ReadFromStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TJSONObject.Clear;
begin
  fList.Clear;
end;

constructor TJSONObject.Create;
begin
  fList:= TObjectList.Create(true);
  fFormatOutput := true;
  fbIgnoreNull := False;
end;



destructor TJSONObject.Destroy;
begin
  fList.Free;
  inherited;
end;

function TJSONObject.GetBooleanByName(aName: string): boolean;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if IgnoreNull and (aPair.ValueType = ValNull) then else
    if aPair.ValueType <> valBoolean then
      raise Exception.Create('TJSONObject.BooleanByName - Wrong data type for Boolean "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valBoolean);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if IgnoreNull and (aPair.ValueType = ValNull) then result := BooleanDefault
  else result:= aPair.Value.AsBoolean;
end;

function TJSONObject.GetCount: integer;
begin
  result:= fList.Count;
end;

function TJSONObject.GetDateTimeByName(aName: string): TDateTime;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if IgnoreNull and (aPair.ValueType = ValNull) then else
    if (aPair.ValueType <> valString) and (aPair.ValueType <> valNumber) then
//    if aPair.ValueType <> valString then
      raise Exception.Create('TJSONObject.DateTimeByName - Wrong data type for DateTime "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valString);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if IgnoreNull and (aPair.ValueType = ValNull) then result := DatetimeDefault
  else  result:= aPair.Value.AsDateTime;
end;

function TJSONObject.GetFloatByName(aName: string): double;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if IgnoreNull and (aPair.ValueType = ValNull) then else
    if (aPair.ValueType <> valNumber) and (aPair.ValueType <> valString) then
      raise Exception.Create('TJSONObject.FloatByName - Wrong data type for Float "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valNumber);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if IgnoreNull and (aPair.ValueType = ValNull) then result := FloatDefault
  else   if aPair.ValueType = valNumber then
    result:= aPair.Value.AsFloat
  else
    result:= aPair.Value.AsDateTime; { must be a datetime stored as a string }
end;

function TJSONObject.GetIntegerByName(aName: string): int64;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if IgnoreNull and (aPair.ValueType = ValNull) then else
    if aPair.ValueType <> valNumber then
      raise Exception.Create('TJSONObject.IntegerByName - Wrong data type for Integer "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valNumber);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if IgnoreNull and (aPair.ValueType = ValNull) then result := IntegerDefault
  else result:= aPair.Value.AsInteger;
end;

function TJSONObject.GetItem(index: integer): TJSONValuePair;
begin
  result:= TJSONValuePair(fList[index]);
end;

function TJSONObject.GetItemByName(aName: string): TJSONValuePair;
var
  x: integer;
  s: string;
begin
  result:= nil;
  s:= Lowercase(aName);
  for x:= 0 to count -1 do begin
    if Lowercase(Items[x].Name) = s then begin
      result:= Items[x];
      break;
    end;
  end;
end;

function TJSONObject.GetObjectByName(aName: string): TJSONObject;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valObject then
      raise Exception.Create('TJSONObject.ObjectByName - Wrong data type for Object "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valObject);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if Assigned(aPair) then
    result:= TJSONObject(aPair.Value)
  else
    result:= nil;

  if assigned(result) then begin
    result.IgnoreNull      := IgnoreNull      ;
    result.StringDefault   := StringDefault   ;
    result.IntegerDefault  := IntegerDefault  ;
    result.FloatDefault    := FloatDefault    ;
    result.BooleanDefault  := BooleanDefault  ;
    result.DatetimeDefault := DatetimeDefault ;
  end;
end;

function TJSONObject.GetStringByName(aName: string): string;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if IgnoreNull and (aPair.ValueType = ValNull) then else
    if aPair.ValueType <> valString then
      raise Exception.Create('TJSONObject.StringByName - Wrong data type for String "' + aName + '"');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valString);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if IgnoreNull and (aPair.ValueType = ValNull) then result := StringDefault
  else result:= aPair.Value.AsString;
end;

function TJSONObject.GetValueByName(aName: string): TJSONValue;
var
  pair: TJsonValuePair;
begin
  result := nil;
  pair := self.ItemByName[aName];
  if Assigned(pair) then
    result := pair.Value;
end;

function TJSONObject.GetValueType: TJSONValueType;
begin
  result:= valObject;
end;

procedure TJSONObject.LoadFromFile(aFileName: string);
var
  stream: TFileStream;
begin
  Clear;
  if FileExists(aFileName) then begin
    stream := TFileStream.Create(aFileName, fmOpenRead);
    try
      ReadFromStream(stream);
    finally
      stream.Free;
    end;
  end
  else
    Self.AsString:= '{}';
end;

function TJSONObject.NEStringExists(aName: string): boolean;
begin
  result := StringExists(aName) and (S[aName] <> '');
end;

procedure TJSONObject.Read(Reader: TTextReader);
var
//  StartFound, EndFound,
  Comment: boolean;
  ObjCount: integer;
  Ch: Char;
  ChAsInt: integer;
  valPair: TJSONValuePair;

  { note comments are: // comment // OR /* comment */ }
  function IsCommentStart: boolean;
  var
    ch2: Char;
    Ch2AsInt: integer;
  begin
    result:= false;
    if ch = '/' then begin
      Ch2AsInt:= Reader.Peek;
      if Ch2AsInt < 0 then
        exit;
      ch2:= Char(Ch2AsInt);
      if (ch2 = '/') or (ch2 = '*') then begin
        result:= true;
        Reader.Read; { advance to next char }
      end;
    end;
  end;

  function IsCommentEnd: boolean;
  var
    ch2: Char;
    Ch2AsInt: integer;
  begin
    result:= false;
    if CharInSet(ch,[#13,#10]) then
      result:= true
    else if (ch = '/') or (ch = '*') then begin
      Ch2AsInt:= Reader.Peek;
      if Ch2AsInt < 0 then
        exit;
      ch2:= Char(Ch2AsInt);
      if (ch2 = '/') then begin
        result:= true;
        Reader.Read; { advance to next char }
      end;
    end;
  end;

begin
  try
    Clear;
//    StartFound:= false;
//    EndFound:= false;
    ObjCount := 0;
    Comment:= false;
    ChAsInt:= Reader.Peek;
    if ChAsInt < 0 then
      exit;
    while ChAsInt >= 0 do begin
      ChAsInt:= Reader.Peek;;
      if ChAsInt < 0 then
        Break;
      Ch:= Char(ChAsInt);
      if not IsControlChar(Ch) then begin
//        if StartFound then begin
        if ObjCount > 0 then begin

          if Comment then begin
            Reader.Read; { move to next char }
            if IsCommentEnd then begin
              Comment:= false;
            end;
          end
          else begin
            if ch = '}' then begin
              Reader.Read; { move to next char }
//              EndFound:= true;
              Dec(ObjCount);
              Break;
            end
            else if IsCommentStart then begin
              Reader.Read; { move to next char }
              Comment:= true;
            end
            else begin
              { value pairs }
              if ch = ',' then begin
                Reader.Read; { move to next char }
                { value pair list }
                if self.Count = 0 then
                  raise Exception.Create('Object Parse Error - Invalid value pair list format');
              end
              else if IsFormatChar(ch) then
                Reader.Read { move to next char }
                { do nothing }
              else if IsControlChar(ch) then
                Reader.Read { move to next char }
                { do nothing }
              else if ch = '"' then begin
                valPair:= TJSONValuePair.Create;
                try
                  valPair.Read(Reader);
                  Add(valPair);
                except
                  valPair.Free;
                  raise;
                end;
              end
              else
               raise Exception.Create('Object Parse Error - Invalid character, value pair name start not found.');
            end;
          end;

        end
        else begin
          Reader.Read; { move to next char }
          { start not found }
          if ch = '{' then
//            StartFound:= true;
            Inc(ObjCount);
        end;
      end
      else begin
        Reader.Read; { move to next char }
        { is a control character  }
        if Comment then begin
          if IsCommentEnd then begin
            Comment:= false;
          end;
        end
      end;
    end;
//    if not (StartFound and EndFound) then
    if not (ObjCount = 0) then
      raise Exception.Create('Object Parse Error - Invalid object block format');
  except
    on e: exception do begin
      raise Exception.Create('Error loading JSONObject from stream with message: '
        + e.Message);
    end;
  end;
end;

procedure TJSONObject.ReadFromStream(stream: TStream);
var
  StreamReader: TStreamReader;
begin
  StreamReader:= TStreamReader.Create(stream);
  try
    Read(StreamReader);
  finally
    StreamReader.Free;
  end;
end;

procedure TJSONObject.SaveToFile(aFileName: string);
var
  stream: TFileStream;
begin
  stream:= TFileStream.Create(aFileName,fmCreate);
  try
    SaveToStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TJSONObject.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONObject.SetBooleanByName(aName: string;
  const Value: boolean);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valBoolean then
      raise Exception.Create('TJSONObject.BooleanByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valBoolean);
    aPair.Name:= aName;
    Add(aPair);
  end;
  aPair.Value.AsBoolean:= Value;
end;

procedure TJSONObject.SetDateTimeByName(aName: string; const Value: TDateTime);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if (aPair.ValueType <> valString) and (aPair.ValueType <> valNumber) then
      raise Exception.Create('TJSONObject.DateTimeByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valString);
    aPair.Name:= aName;
    Add(aPair);
  end;
  aPair.Value.AsDateTime:= Value;
end;

procedure TJSONObject.SetFloatByName(aName: string; const Value: double);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valNumber then
      raise Exception.Create('TJSONObject.FloatByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valNumber);
    aPair.Name:= aName;
    Add(aPair);
  end;
  aPair.Value.AsFloat:= Value;
end;

procedure TJSONObject.SetFormatOutput(const Value: boolean);
var
  x,y: integer;
begin
  fFormatOutput := Value;
  for x := 0 to self.Count -1 do begin
    if self.Items[x].Value is TJsonObject then
      self.Items[x].Value.AsObject.FormatOutput := Value
    else if self.Items[x].Value is TJsonArray then begin
      for y := 0 to TJsonArray(Items[x].Value).Count -1 do begin
        if TJsonArray(Items[x].Value).Items[y] is TJsonObject then
          TJsonArray(Items[x].Value).Items[y].AsObject.FormatOutput := false;
      end;
    end;
  end;
end;

procedure TJSONObject.SetIntegerByName(aName: string;
  const Value: int64);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valNumber then
      raise Exception.Create('TJSONObject.IntegerByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valNumber);
    aPair.Name:= aName;
    Add(aPair);
  end;
  aPair.Value.AsInteger:= Value;
end;

procedure TJSONObject.SetStringByName(aName: string; const Value: string);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valString then
      raise Exception.Create('TJSONObject.StringByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valString);
    aPair.Name:= aName;
    Add(aPair);
  end;
  aPair.Value.AsString:= Value;
end;

function TJSONObject.GetArrayByName(aName: string): TJSONArray;
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valArray then
      raise Exception.Create('TJSONObject.ArrayByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valArray);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if Assigned(aPair) then
    result:= TJSONArray(aPair.Value)
  else
    result:= nil;

  if assigned(result) then begin
    result.IgnoreNull      := IgnoreNull      ;
    result.StringDefault   := StringDefault   ;
    result.IntegerDefault  := IntegerDefault  ;
    result.FloatDefault    := FloatDefault    ;
    result.BooleanDefault  := BooleanDefault  ;
    result.DatetimeDefault := DatetimeDefault ;
  end;

end;

procedure TJSONObject.SetArrayByName(aName: string; const Value: TJSONArray);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valArray then
      raise Exception.Create('TJSONObject.ArrayByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valArray);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if Assigned(aPair) then
    TJSONArray(aPair.Value).AsString:= Value.AsString;
end;

function TJSONObject.GetAsString: string;
var
  s: string;
  stream: TStringStream;
begin
  stream:= TStringStream.Create(s, TEncoding.UTF8);
  try
    self.SaveToStream(stream);
    stream.Position:= 0;
    result:= stream.DataString;
  finally
    stream.Free;
  end;
end;

procedure TJSONObject.SetAsString(const aValue: string);
var
  stream: TStringStream;
begin
  stream:= TStringStream.Create(aValue, TEncoding.UTF8);
  try
    self.ReadFromStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TJSONObject.SetObjectByName(aName: string; const Value: TJSONObject);
var
  aPair: TJSONValuePair;
begin
  aPair:= self.ItemByName[aName];
  if Assigned(aPair) then begin
    if aPair.ValueType <> valObject then
      raise Exception.Create('TJSONObject.ObjectByName - Wrong data type');
  end
  else begin
    {not found}
    aPair:= TJSONValuePair.Create(valObject);
    aPair.Name:= aName;
    Add(aPair);
  end;
  if Assigned(aPair) then
  begin
    FreeAndNil(aPair.Value);
    TJSONObject(aPair.Value):= Value;
  end;
end;

function TJSONObject.Exists(aName: string): boolean;
begin
  result:= Assigned(ItemByName[aName]);
end;

function TJSONObject.Extract(index: integer): TJSONValuePair;
begin
  result := TJSONValuePair(fList.Extract(fList[index]));
end;

function TJSONObject.Add(aName: string; aValueType: TJSONValueType): integer;
var
  item: TJSONValuePair;
begin
  item:= TJSONValuePair.Create(aValueType);
  item.Name:= aName;
  result := Add(item);
end;

function TJSONObject.ArrayExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valArray) then
    result:= true;
end;

function TJSONObject.BooleanExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valBoolean) then
    result:= true;
end;

function TJSONObject.FloatExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valNumber) then
    result:= true;
end;

function TJSONObject.IntegerExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valNumber) then
    result:= true;
end;

function TJSONObject.ObjectExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valObject) then
    result:= true;
end;

function TJSONObject.StringExists(aName: string): boolean;
var item: TJSONValuePair;
begin
  result:= false;
  item:= ItemByName[aName];
  if Assigned(item) and (item.ValueType = valString) then
    result:= true;
end;

class function TJSONObject.StrToJsonObject(const aJsonStr: string): TJsonObject;
begin
  result := JO;
  result.AsString := aJsonStr;
end;

procedure TJSONObject.Write(Writer: TTextWriter);
var
  x: integer;
  eolBreak: string;
begin
  if fFormatOutput then eolBreak := #13#10
  else eolBreak := '';

  if fFormatOutput and (Writer is TStreamWriter) and (TStreamWriter(Writer).BaseStream.Size > 0) then
    StrToWriter(#13#10, Writer);
  StrToWriter('{' + eolBreak, Writer);
  for x:= 0 to Count -1 do begin
    if x > 0 then
      StrToWriter(',' + eolBreak, Writer);
    Items[x].Write(Writer);
  end;
  StrToWriter(eolBreak + '}', Writer);
end;

procedure TJSONObject.Delete(index: integer);
begin
  fList.Delete(index);
end;

procedure TJSONObject.Delete(itemName: string);
var item: TJSONValuePair;
begin
  item:= ItemByName[itemName];
  if Assigned(item) then
    fLIst.Delete(fList.IndexOf(item));
end;

function TJSONObject.GetAsObject: TJsonObject;
begin
  result:= self;
end;

procedure TJSONObject.SetAsObject(const Value: TJsonObject);
begin
  self.Assign(Value);
end;

{ TJSONArray }

function TJSONArray.Add(aValue: TJSONValue): integer;
begin
  result:= fList.Add(aValue);
end;

function TJSONArray.Add(aString: string): integer;
var
  strVal: TJSONString;
begin
  strVal:= TJSONString.Create;
  strVal.AsString:= aString;
  result:= Add(strVal);
end;

function TJSONArray.AddObject: TJsonObject;
begin
  result := JO;
  Add(result);
end;

procedure TJSONArray.Assign(source: TJSONArray);
begin
  Clear;
  AsString:= source.AsString;
end;

procedure TJSONArray.Clear;
begin
  fList.Clear;
end;

constructor TJSONArray.Create;
begin
  fList:= TObjectList.Create;
end;

procedure TJSONArray.Delete(index: integer);
begin
  if (fList.Count > 0) and (index > -1) and (index < fList.Count) then
    fList.Delete(index);
end;

procedure TJSONArray.Delete(aObj: TObject);
begin
  Delete(fList.IndexOf(aObj));
end;

destructor TJSONArray.Destroy;
begin
  fList.Free;
  inherited;
end;

function TJSONArray.Extract(index: integer): TJSONValue;
begin
  result := TJSONValue(fList.Extract(fList[index]));
end;

function TJSONArray.GetAsString: string;
var
  s: string;
  stream: TStringStream;
begin
  stream:= TStringStream.Create(s, TEncoding.UTF8);
  try
    self.SaveToStream(stream);
    stream.Position:= 0;
    result:= stream.DataString;
  finally
    stream.Free;
  end;
end;

function TJSONArray.GetCount: integer;
begin
  result:= fList.Count;
end;

function TJSONArray.GetItem(index: integer): TJSONValue;
begin
  result:= TJSONValue(fList[index]);
  if assigned(result) then begin
    result.IgnoreNull      := IgnoreNull      ;
    result.StringDefault   := StringDefault   ;
    result.IntegerDefault  := IntegerDefault  ;
    result.FloatDefault    := FloatDefault    ;
    result.BooleanDefault  := BooleanDefault  ;
    result.DatetimeDefault := DatetimeDefault ;
  end;
end;

function TJSONArray.GetValueType: TJSONValueType;
begin
  result:= valArray;
end;

function TJSONArray.ObjByPropVal(const aPropName,
  aPropVal: string): TJsonObject;
var
  x: integer;
  val: TJsonValue;
begin
  result := nil;
  for x := 0 to Count-1 do begin
    val := Items[x];
    if val is TJsonObject then begin
      if TJsonObject(val).StringExists(aPropName) then begin
        if SameText(TJsonObject(val).S[aPropName],aPropVal) then begin
          result := TJsonObject(val);
          break;
        end;
      end;
    end;
  end;
end;

procedure TJSONArray.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONArray.Read(Reader: TTextReader);
var
  StartFound, EndFound: boolean;
  Ch: Char;
  CharAsInt: Integer;
  aValue: TJSONValue;
  arrayType: TJSONValueType;
begin
  StartFound:= false;
  EndFound:= false;
  arrayType:= valNone;
  CharAsInt:= Reader.Peek;
  { use the next char from the stream without advancing stream position }
  while CharAsInt >= 0 do begin
    CharAsInt:= Reader.Peek;
    if CharAsInt < 0 then
      break;
    ch:= Char(CharAsInt);
    if StartFound then begin
      if ch = ']' then begin
        Reader.Read; { advance to next character }
        EndFound:= true;
        break;
      end
      else if ch = ',' then begin
        Reader.Read; { advance to next character }
        { element seperator }
        if count = 0 then
          raise Exception.Create('Value Parse Error - Invalid array format');
      end
      else if IsFormatChar(ch) then
        Reader.Read { advance to next character }
        { do nothing }
      else begin
        if ch = '"' then begin
          { string  ... }
          aValue:= TJSONValue(TJSONString.Create);
        end
        else if (ch = '-') or IsNumberChar(ch) then begin
          { number ... }
          aValue:= TJSONValue(TJSONNumber.Create);
        end
        else if ch = '{' then begin
          { object ... }
          aValue:= TJSONValue(TJSONObject.Create);
        end
        else if ch = '[' then begin
          { array ... }
          aValue:= TJSONValue(TJSONArray.Create);
        end
        else if CharInSet(ch,['t','f']) then begin
          { boolean ... }
          aValue:= TJSONValue(TJSONBoolean.Create);
        end
        else if ch = 'n' then begin
          { null ... }
          aValue:= TJSONValue(TJSONNull.Create);
        end
        else
          raise Exception.Create('Value Parse Error - Invalid array format, unrecognised value type');
        if Assigned(aValue) then begin
          if arrayType = valNone then begin
            if aValue.ValueType <> valNull then
              arrayType:= aValue.ValueType
          end
          else begin
            if (arrayType <> aValue.ValueType) and (aValue.ValueType <> valNull) then begin
              aValue.Free;
              raise Exception.Create('Value Parse Error - Array values not of same type');
            end;
          end ;
          aValue.Read(Reader);
          Add(aValue);
        end
        else
          Reader.Read; { advance to next character }
      end
    end
    else begin
     Reader.Read; { advance to next character }
     { start not found }
     if ch = '[' then
       StartFound:= true
     else if IsFormatChar(ch) then
       {do nothing}
     else
      raise Exception.Create('Value Parse Error - Invalid array value format');
    end;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('Value Parse Error - Invalid array value format');
end;

procedure TJSONArray.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONArray.SetAsString(const aValue: string);
var
  stream: TStringStream;
begin
  stream:= TStringStream.Create(aValue, TEncoding.UTF8);
  try
    self.ReadFromStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TJSONArray.Write(Writer: TTextWriter);
var
  x: integer;
begin
  StrToWriter('[', Writer);
  for x:= 0 to Count -1 do begin
    if x > 0 then begin
      StrToWriter(',', Writer);
    end;
    Items[x].Write(Writer);
  end;
  StrToWriter(']', Writer);
end;

{ TJSONNull }

function TJSONNull.GetValueType: TJSONValueType;
begin
  result:= valNull;
end;

procedure TJSONNull.Read(Reader: TTextReader);
begin
  if ReadBoolNullStrValue(Reader) <> 'null' then
    raise Exception.Create('Value Parse Error - Invalid null value');
end;

procedure TJSONNull.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONNull.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONNull.Write(Writer: TTextWriter);
begin
  StrToWriter('null', Writer);
end;

{ TJSONBoolean }

function TJSONBoolean.GetAsBoolean: boolean;
begin
  result:= Value;
end;

function TJSONBoolean.GetAsFloat: double;
begin
  if Value then result:= 1
  else result:= 0;
end;

function TJSONBoolean.GetAsInteger: int64;
begin
  if Value then result:= 1
  else result:= 0;
end;

function TJSONBoolean.GetAsString: string;
begin
  if Value then result:= 'true'
  else result:= 'false';
end;

function TJSONBoolean.GetValueType: TJSONValueType;
begin
  result:= valBoolean;
end;

procedure TJSONBoolean.Read(Reader: TTextReader);
begin
  Value:= ReadBoolNullStrValue(Reader) = 'true';
end;

procedure TJSONBoolean.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONBoolean.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONBoolean.SetAsBoolean(const aValue: boolean);
begin
  Value:= aValue;
end;

procedure TJSONBoolean.SetAsFloat(const aValue: double);
begin
  if aValue = 0 then Value:= false
  else Value:= true;
end;

procedure TJSONBoolean.SetAsInteger(const aValue: int64);
begin
  if aValue = 0 then Value:= false
  else Value:= true;
end;

procedure TJSONBoolean.SetAsString(const aValue: string);
begin
  if aValue = 'true' then Value:= true
  else Value:= false;
end;

procedure TJSONBoolean.Write(Writer: TTextWriter);
begin
  if Value then StrToWriter('true', Writer)
  else StrToWriter('false', Writer);
end;

{ TJSONValuePair }

constructor TJSONValuePair.Create(aValueType: TJSONValueType = valNull);
begin
  ValueType:= aValueType;
end;

destructor TJSONValuePair.Destroy;
begin
  Value.Free;
  inherited;
end;

function TJSONValuePair.GetValueType: TJSONValueType;
begin
  result:= Value.ValueType;
end;

procedure TJSONValuePair.Read(Reader: TTextReader);
var
  StartFound, EndFound: boolean;
  ch: Char;
  CharAsInt: integer;
  aValue: TJSONValue;
begin
  Name:= ReadStringValue(Reader);
  if Name = '' then
    raise Exception.Create('Object Parse Error - Invalid value pair name (empty string)');
  StartFound:= false;
  EndFound:= false;
  CharAsInt:= Reader.Peek;
  { use the next char from the stream without advancing stream position }
  while CharAsInt >= 0 do begin
    CharAsInt:= Reader.Peek;
    if CharAsInt < 0 then
      break;
    ch:= Char(CharAsInt);
    if StartFound then begin
      { looking for start of value ... }
      if not IsFormatChar(ch) then begin
        if ch = '"' then begin
          { string  ... }
          aValue:= TJSONValue(TJSONString.Create);
        end
        else if (ch = '-') or IsNumberChar(ch) then begin
          { number ... }
          aValue:= TJSONValue(TJSONNumber.Create);
        end
        else if ch = '{' then begin
          { object ... }
          aValue:= TJSONValue(TJSONObject.Create);
        end
        else if ch = '[' then begin
          { array ... }
          aValue:= TJSONValue(TJSONArray.Create);
        end
        else if CharInSet(ch,['t','f']) then begin
          { boolean ... }
          aValue:= TJSONValue(TJSONBoolean.Create);
        end
        else if ch = 'n' then begin
          { null ... }
          aValue:= TJSONValue(TJSONNull.Create);
        end
        else
          raise Exception.Create('Object Parse Error - Invalid value pair block format, unrecognised value type');
        if Assigned(aValue) then begin
          try
            aValue.Read(Reader);
          except
            on e: exception do begin
              raise Exception.Create(e.Message + ' Pair name: ' + Name + '.');
            end;
          end;
          Self.Value.Free;  //TJSONNull was set in the constructor, need to free memory
          self.Value:= aValue;
          EndFound:= true;
          break;
        end
      end
      else
        Reader.Read; { advance to next }
    end
    else begin
      { start not found }
      ch:= Char(Reader.Read);
      if ch = ':' then
        StartFound:= true
      else if not (CharInSet(ch,[#13, #10, #9, ' '])) then
        raise Exception.Create('Object Parse Error - Invalid value pair block format, missing name/value seperator for name: ' + Name + '.');
    end;
  end;
  if not (StartFound and EndFound) then
    raise Exception.Create('Object Parse Error - Invalid value pair block format');
end;

procedure TJSONValuePair.ReadFromStream(stream: TStream);
var
  Reader: TStreamReader;
begin
  Reader:= TStreamReader.Create(stream);
  try
    Read(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TJSONValuePair.SaveToStream(stream: TStream);
var
  Writer: TStreamWriter;
begin
  Writer:= TStreamWriter.Create(stream);
  try
    Write(Writer);
  finally
    Writer.Free;
  end;
end;

procedure TJSONValuePair.SetValueType(const aValue: TJSONValueType);
begin
  if Assigned(Value) and (Value.ValueType <> aValue) then
    FreeAndNil(Value);
  if not Assigned(Value) then begin
    case aValue of
      valNone: ;
      valString: Value:= TJSONString.Create;
      valNumber: Value:= TJSONNumber.Create;
      valObject: Value:= TJSONObject.Create;
      valArray: Value:= TJSONArray.Create;
      valNull: Value:= TJSONNull.Create;
      valBoolean: Value:= TJSONBoolean.Create;
    end;
  end;
end;

procedure TJSONValuePair.Write(Writer: TTextWriter);
begin
  StrToWriter('"' +  self.Name + '":', Writer);
  self.Value.Write(Writer);
end;

end.

