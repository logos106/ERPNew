unit ValueFields;

interface

uses
  classes, contnrs, db;

type

  TValueBaseClass = class of TValueBase;
  TValueBase = class
  private
    fDirty: boolean;
    fCompareOnSet: boolean;
  protected
    fIsNull: boolean;
    function GetAsFloat: double; virtual;
    function GetAsInteger: integer; virtual;
    function GetAsString: string; virtual;
    procedure SetAsFloat(const aValue: double); virtual;
    procedure SetAsInteger(const aValue: integer); virtual;
    procedure SetAsString(const aValue: string); virtual;
    function GetAsBoolean: boolean; virtual;
    procedure SetAsBoolean(const aValue: boolean); virtual;
    function GetOldAsBoolean: boolean; virtual;
    function GetOldAsFloat: double; virtual;
    function GetOldAsInteger: integer; virtual;
    function GetOldAsString: string; virtual;
  public
    constructor Create; virtual;
    procedure Clear; virtual;
    property IsNull: boolean read fIsNull;
    property Dirty: boolean read fDirty write fDirty;
    property CompareOnSet: boolean read fCompareOnSet write fCompareOnSet;
    procedure LoadFromField(aField: TField); virtual;
    procedure SaveToField(aField: TField); virtual;
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    procedure Assign(source: TValueBase); virtual;
    property OldAsString: string read GetOldAsString;
    property OldAsInteger: integer read GetOldAsInteger;
    property OldAsFloat: double read GetOldAsFloat;
    property OldAsBoolean: boolean read GetOldAsBoolean;
  end;

  TStringValue = class(TValueBase)
  private
    fValue: string;
    fOldValue: string;
    procedure SetValue(const Value: string);
  protected
    function GetAsFloat: double; override;
    function GetAsInteger: integer; override;
    function GetAsString: string; override;
    procedure SetAsFloat(const aValue: double); override;
    procedure SetAsInteger(const aValue: integer); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsBoolean: boolean; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    function GetOldAsBoolean: boolean; override;
    function GetOldAsFloat: double; override;
    function GetOldAsInteger: integer; override;
    function GetOldAsString: string; override;
  public
    procedure Clear; override;
    property Value: string read fValue write SetValue;
    property OldValue: string read fOldValue;
    procedure LoadFromField(aField: TField); override;
    procedure SaveToField(aField: TField); override;
    procedure Assign(source: TValueBase); override;
  end;

  TIntegerValue = class(TValueBase)
  private
    fValue: integer;
    fOldValue: integer;
    procedure SetValue(const Value: integer);
  protected
    function GetAsFloat: double; override;
    function GetAsInteger: integer; override;
    function GetAsString: string; override;
    procedure SetAsFloat(const aValue: double); override;
    procedure SetAsInteger(const aValue: integer); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsBoolean: boolean; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    function GetOldAsBoolean: boolean; override;
    function GetOldAsFloat: double; override;
    function GetOldAsInteger: integer; override;
    function GetOldAsString: string; override;
  public
    procedure Clear; override;
    property Value: integer read fValue write SetValue;
    property OldValue: integer read fOldValue;
    procedure LoadFromField(aField: TField); override;
    procedure SaveToField(aField: TField); override;
    procedure Assign(source: TValueBase); override;
  end;

  TFloatValue = class(TValueBase)
  private
    fValue: double;
    fOldValue: double;
    procedure SetValue(const Value: double);
  protected
    function GetAsFloat: double; override;
    function GetAsInteger: integer; override;
    function GetAsString: string; override;
    procedure SetAsFloat(const aValue: double); override;
    procedure SetAsInteger(const aValue: integer); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsBoolean: boolean; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    function GetOldAsBoolean: boolean; override;
    function GetOldAsFloat: double; override;
    function GetOldAsInteger: integer; override;
    function GetOldAsString: string; override;
  public
    procedure Clear; override;
    property Value: double read fValue write SetValue;
    property OldValue: double read fOldValue;
    procedure LoadFromField(aField: TField); override;
    procedure SaveToField(aField: TField); override;
    procedure Assign(source: TValueBase); override;
  end;

  TBooleanValue = class(TValueBase)
  private
    fValue: boolean;
    fOldValue: boolean;
    procedure SetValue(const Value: boolean);
  protected
    function GetAsFloat: double; override;
    function GetAsInteger: integer; override;
    function GetAsString: string; override;
    procedure SetAsFloat(const aValue: double); override;
    procedure SetAsInteger(const aValue: integer); override;
    procedure SetAsString(const aValue: string); override;
    function GetAsBoolean: boolean; override;
    procedure SetAsBoolean(const aValue: boolean); override;
    function GetOldAsBoolean: boolean; override;
    function GetOldAsFloat: double; override;
    function GetOldAsInteger: integer; override;
    function GetOldAsString: string; override;
  public
    procedure Clear; override;
    property Value: boolean read fValue write SetValue;
    property OldValue: boolean read fOldValue;
    procedure LoadFromField(aField: TField); override;
    procedure SaveToField(aField: TField); override;
    procedure Assign(source: TValueBase); override;
  end;

  TDateTimeValue = class(TFloatValue)
  end;

  TBlobValue = class(TValueBase)
  private
    fValue: TMemoryStream;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Clear; override;
    property Value: TMemoryStream read fValue;
    procedure LoadFromStream(source: TStream);
    procedure LoadFromField(aField: TField); override;
    procedure SaveToField(aField: TField); override;
    procedure Assign(source: TValueBase); override;
  end;

  TValueField = class
  private
    fName: string;
    fData: TValueBase;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read fName write fName;
    property Data: TValueBase read fData write fData;
    property Dirty: boolean read GetDirty write SetDirty;
  end;

  TValueFieldList = class
  private
    fList: TObjectList;
    fIdFieldName: string;
    function GetCount: integer;
    function GetField(idx: integer): TValueField;
    function GetFieldByName(aName: string): TValueField;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Fields[idx: integer]: TValueField read GetField; default;
    property FieldByName[aName: string]: TValueField read GetFieldByName;
    procedure Clear;
    function Add(aField: TValueField): integer; overload;
    function Add(): TValueField; overload;
    function Add(aFieldName: string; aFieldList: TValueFieldList): TValueField; overload;
    property Dirty: boolean read GetDirty write SetDirty;
    procedure LoadFromDataset(dataset: TDataSet);
    procedure SaveToDataset(dataset: TDataSet);
    property IdFieldName: string read fIdFieldName write fIdFieldName;
  end;

implementation

uses
  SysUtils, LogThreadLib, MyAccess, StreamUtils;

{ general functions ... }

function FieldTypeToClass(aFieldType: TFieldType): TValueBaseClass;
begin
  case aFieldType of
    ftFixedChar,                        // Fixed character field
    ftWideString,               	// Wide string field
    ftFmtMemo,                  	// Formatted text memo field
    ftMemo,                     	// Text memo field
    ftString:   result:= TStringValue;	// Character or string field
    ftSmallint,                 	// 16-bit integer field
    ftWord,                     	// 16-bit unsigned integer field
    ftAutoInc,                  	// Auto-incrementing 32-bit integer counter field
    ftLargeInt,                 	// Large integer field
    ftInteger:  result:= TIntegerValue;	// 32-bit integer field
    ftCurrency,                 	// Money field
    ftBCD,                      	// Binary-Coded Decimal field
    ftFloat:    result:= TFloatValue;	// Floating-point numeric field
    ftDate,                     	// Date field
    ftTime,                     	// Time field
    ftDateTime: result:= TDateTimeValue;// Date and time field
    ftBoolean:  result:= TBooleanValue;	// Boolean field
    ftBlob:     result:= TBlobValue;	// Binary Large OBject field
    ftBytes,	                        // Fixed number of bytes (binary storage)
    ftVarBytes,	                        // Variable number of bytes (binary storage)
    ftGraphic,	                        // Bitmap field
    ftParadoxOle,                       // Paradox OLE field
    ftDBaseOle,	                        // dBASE OLE field
    ftTypedBinary,	                // Typed binary field
    ftCursor,	                        // Output cursor from an Oracle stored procedure (TParam only)
    ftADT,	                        // Abstract Data Type field
    ftArray,	                        // Array field
    ftReference,	                // REF field
    ftDataSet,	                        // DataSet field
    ftOraBlob,	                        // BLOB fields in Oracle 8 tables
    ftOraClob,	                        // CLOB fields in Oracle 8 tables
    ftVariant,	                        // Data of unknown or undetermined type
    ftInterface,	                // References to interfaces (IUnknown)
    ftIDispatch,	                // References to IDispatch interfaces
    ftGuid,	                        // globally unique identifier (GUID) values
    ftUnknown:  result:= nil;	        // Unknown or undetermined
    else result:= nil;
  end;
end;

{ TValueBase }

procedure TValueBase.Assign(source: TValueBase);
begin
  raise Exception.Create('Not implemented');
end;

procedure TValueBase.Clear;
begin
  fIsNull:= true;
  fDirty:= true;
end;

constructor TValueBase.Create;
begin
  fCompareOnSet:= true;
  Clear;
  fDirty:= false;
end;

function TValueBase.GetAsBoolean: boolean;
begin
  raise Exception.Create('Not implemented');
end;

function TValueBase.GetAsFloat: double;
begin
  raise Exception.Create('Not implemented');
end;

function TValueBase.GetAsInteger: integer;
begin
  raise Exception.Create('Not implemented');
end;

function TValueBase.GetAsString: string;
begin
  raise Exception.Create('Not implemented');
end;

function TValueBase.GetOldAsBoolean: boolean;
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

function TValueBase.GetOldAsFloat: double;
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

function TValueBase.GetOldAsInteger: integer;
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

function TValueBase.GetOldAsString: string;
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

procedure TValueBase.LoadFromField(aField: TField);
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

procedure TValueBase.SaveToField(aField: TField);
begin
  raise Exception.Create('TValueBase.LoadFromField - Not implemented');
end;

procedure TValueBase.SetAsBoolean(const aValue: boolean);
begin
  raise Exception.Create('Not implemented');
end;

procedure TValueBase.SetAsFloat(const aValue: double);
begin
  raise Exception.Create('Not implemented');
end;

procedure TValueBase.SetAsInteger(const aValue: integer);
begin
  raise Exception.Create('Not implemented');
end;

procedure TValueBase.SetAsString(const aValue: string);
begin
  raise Exception.Create('Not implemented');
end;

{ TStringValue }

procedure TStringValue.Assign(source: TValueBase);
begin
  if source.IsNull then Clear
  else Value:= source.AsString;
end;

procedure TStringValue.Clear;
begin
  if not IsNull then begin
    inherited;
    fValue:= '';
  end;
end;

function TStringValue.GetAsBoolean: boolean;
begin
  result:= LowerCase(Value) = 'true';
end;

function TStringValue.GetAsFloat: double;
begin
  result:= StrToFloatDef(Value,0);
end;

function TStringValue.GetAsInteger: integer;
begin
  result:= StrToIntDef(Value,0);
end;

function TStringValue.GetAsString: string;
begin
  result:= Value;
end;

function TStringValue.GetOldAsBoolean: boolean;
begin
  result:= Lowercase(OldValue) = 'true';
end;

function TStringValue.GetOldAsFloat: double;
begin
  result:= StrToFloatDef(OldValue,0);
end;

function TStringValue.GetOldAsInteger: integer;
begin
  result:= StrToIntDef(OldValue,0);
end;

function TStringValue.GetOldAsString: string;
begin
  result:= OldValue;
end;

procedure TStringValue.LoadFromField(aField: TField);
begin
  if aField.IsNull then begin
    if not self.IsNull then begin
      fOldValue:= fValue;
      Clear;
      fDirty:= true;
    end;
  end    
  else
    Value:= aField.AsString;
end;

procedure TStringValue.SaveToField(aField: TField);
begin
  if self.IsNull then
    aField.Clear
  else
    aField.AsString:= Value;
end;

procedure TStringValue.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 'true'
  else Value:= 'false';
end;

procedure TStringValue.SetAsFloat(const aValue: double);
begin
  Value:= FloatToStr(aValue);
end;

procedure TStringValue.SetAsInteger(const aValue: integer);
begin
  Value:= IntToStr(aValue);
end;

procedure TStringValue.SetAsString(const aValue: string);
begin
  Value:= aValue;
end;

procedure TStringValue.SetValue(const Value: string);
begin
  if fCompareOnSet then begin
    if fValue <> Value then begin
      fOldValue:= fValue;
      fValue := Value;
      Dirty:= true;
    end;
  end
  else begin
    fOldValue:= fValue;
    fValue := Value;
    Dirty:= true;
  end;
  fIsNull:= false;
end;

{ TIntegerValue }

procedure TIntegerValue.Assign(source: TValueBase);
begin
  if source.IsNull then Clear
  else Value:= source.AsInteger;
end;

procedure TIntegerValue.Clear;
begin
  if not IsNull then begin
    inherited;
    fValue:= 0;
  end;
end;

function TIntegerValue.GetAsBoolean: boolean;
begin
  result:= not (Value = 0);
end;

function TIntegerValue.GetAsFloat: double;
begin
  result:= Value;
end;

function TIntegerValue.GetAsInteger: integer;
begin
  result:= Value;
end;

function TIntegerValue.GetAsString: string;
begin
  result:= IntToStr(Value);
end;

function TIntegerValue.GetOldAsBoolean: boolean;
begin
  result:= not (OldValue = 0);
end;

function TIntegerValue.GetOldAsFloat: double;
begin
  result:= OldValue;
end;

function TIntegerValue.GetOldAsInteger: integer;
begin
  result:= OldValue;
end;

function TIntegerValue.GetOldAsString: string;
begin
  result:= IntToStr(OldValue);
end;

procedure TIntegerValue.LoadFromField(aField: TField);
begin
  if aField.IsNull then begin
    if not self.IsNull then begin
      fOldValue:= fValue;
      Clear;
      fDirty:= true;
    end;
  end
  else
    Value:= aField.AsInteger;
end;

procedure TIntegerValue.SaveToField(aField: TField);
begin
  if self.IsNull then
    aField.Clear
  else
    aField.AsInteger:= Value;
end;

procedure TIntegerValue.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 1
  else Value:= 0;
end;

procedure TIntegerValue.SetAsFloat(const aValue: double);
begin
  Value:= Trunc(aValue);
end;

procedure TIntegerValue.SetAsInteger(const aValue: integer);
begin
  Value:= aValue;
end;

procedure TIntegerValue.SetAsString(const aValue: string);
begin
  Value:= StrToIntDef(aValue,0);
end;

procedure TIntegerValue.SetValue(const Value: integer);
begin
  if fCompareOnSet then begin
    if fValue <> Value then begin
      fOldValue:= fValue;
      fValue := Value;
      Dirty:= true;
    end;
  end
  else begin
    fOldValue:= fValue;
    fValue := Value;
    Dirty:= true;
  end;
  fIsNull:= false;
end;

{ TFloatValue }

procedure TFloatValue.Assign(source: TValueBase);
begin
  if source.IsNull then Clear
  else Value:= source.AsFloat;
end;

procedure TFloatValue.Clear;
begin
  if not IsNull then begin
    inherited;
    fValue:= 0;
  end;  
end;

function TFloatValue.GetAsBoolean: boolean;
begin
  result:= not (Value = 0);
end;

function TFloatValue.GetAsFloat: double;
begin
  result:= VAlue;
end;

function TFloatValue.GetAsInteger: integer;
begin
  result:= Trunc(Value);
end;

function TFloatValue.GetAsString: string;
begin
  result:= FloatToStr(Value);
end;

function TFloatValue.GetOldAsBoolean: boolean;
begin
  result:= not (OldValue = 0);
end;

function TFloatValue.GetOldAsFloat: double;
begin
  result:= OldValue;
end;

function TFloatValue.GetOldAsInteger: integer;
begin
  result:= Trunc(OldValue);
end;

function TFloatValue.GetOldAsString: string;
begin
  result:= FloatToStr(OldValue);
end;

procedure TFloatValue.LoadFromField(aField: TField);
begin
  if aField.IsNull then begin
    if not self.IsNull then begin
      fOldValue:= fValue;
      Clear;
      fDirty:= true;
    end;
  end
  else
    Value:= aField.AsFloat;
end;

procedure TFloatValue.SaveToField(aField: TField);
begin
  if self.IsNull then
    aField.Clear
  else
    aField.AsFloat:= Value;
end;

procedure TFloatValue.SetAsBoolean(const aValue: boolean);
begin
  if aValue then Value:= 1
  else Value:= 0;
end;

procedure TFloatValue.SetAsFloat(const aValue: double);
begin
  Value:= aValue;
end;

procedure TFloatValue.SetAsInteger(const aValue: integer);
begin
  Value:= aValue;
end;

procedure TFloatValue.SetAsString(const aValue: string);
begin
  Value:= StrToFloatDef(aVAlue,0);
end;

procedure TFloatValue.SetValue(const Value: double);
begin
  if fCompareOnSet then begin
    if fValue <> Value then begin
      fOldValue:= fValue;
      fValue := Value;
      Dirty:= true;
    end;
  end
  else begin
    fOldValue:= fValue;
    fValue := Value;
    Dirty:= true;
  end;
  fIsNull:= false;
end;

{ TBooleanValue }

procedure TBooleanValue.Assign(source: TValueBase);
begin
  if source.IsNull then Clear
  else Value:= source.AsBoolean;
end;

procedure TBooleanValue.Clear;
begin
  if not IsNull then begin
    inherited;
    fValue:= false;
  end;
end;

function TBooleanValue.GetAsBoolean: boolean;
begin
  result:= Value;
end;

function TBooleanValue.GetAsFloat: double;
begin
  if Value then result:= 1
  else result:= 0;
end;

function TBooleanValue.GetAsInteger: integer;
begin
  if Value then result:= 1
  else result:= 0;
end;

function TBooleanValue.GetAsString: string;
begin
  if Value then result:= 'true'
  else result:= 'false';
end;

function TBooleanValue.GetOldAsBoolean: boolean;
begin
  result:= OldValue;
end;

function TBooleanValue.GetOldAsFloat: double;
begin
  if OldValue then result:= 1
  else result:= 0;
end;

function TBooleanValue.GetOldAsInteger: integer;
begin
  if OldValue then result:= 1
  else result:= 0;
end;

function TBooleanValue.GetOldAsString: string;
begin
  if OldValue then result:= 'true'
  else result:= 'false';
end;

procedure TBooleanValue.LoadFromField(aField: TField);
begin
  if aField.IsNull then begin
    if not self.IsNull then begin
      fOldValue:= fValue;
      Clear;
      fDirty:= true;
    end;
  end
  else
    Value:= aField.AsBoolean;
end;

procedure TBooleanValue.SaveToField(aField: TField);
begin
  if self.IsNull then
    aField.Clear
  else
    aField.AsBoolean:= Value;
end;

procedure TBooleanValue.SetAsBoolean(const aValue: boolean);
begin
  Value:= aValue;
end;

procedure TBooleanValue.SetAsFloat(const aValue: double);
begin
  Value:= not (aValue = 0);
end;

procedure TBooleanValue.SetAsInteger(const aValue: integer);
begin
  Value:= not (aValue = 0);
end;

procedure TBooleanValue.SetAsString(const aValue: string);
begin
  Value:=  LowerCase(aValue) = 'true';
end;

procedure TBooleanValue.SetValue(const Value: boolean);
begin
  if fCompareOnSet then begin
    if fValue <> Value then begin
      fOldValue:= fValue;
      fValue := Value;
      Dirty:= true;
    end;
  end
  else begin
    fOldValue:= fValue;
    fValue := Value;
    Dirty:= true;
  end;
  fIsNull:= false;
end;

{ TBlobValue }

procedure TBlobValue.Assign(source: TValueBase);
var
  src: TBlobValue;
begin
  if source is TBlobValue then begin
    src:= TBlobValue(source);
    if not Assigned(fValue) then
      fValue:= TMemoryStream.Create;
    Value.LoadFromStream(src.Value);
  end
  else
    raise Exception.Create('TBlobValue.Assign - Source is not a Blob type value.');
end;

procedure TBlobValue.Clear;
begin
  if not IsNull then begin
    inherited;
    if Assigned(fValue) then
      fValue.Clear;
  end;
end;

constructor TBlobValue.Create;
begin
  inherited;
  fValue:= TMemoryStream.Create;
end;

destructor TBlobValue.Destroy;
begin
  fValue.Free;
  inherited;
end;

procedure TBlobValue.LoadFromField(aField: TField);
begin
  if aField.IsNull then begin
    if not self.IsNull then begin
      Clear;
      fDirty:= true;
    end;
  end    
  else
    TBlobField(aField).SaveToStream(Value);
end;

procedure TBlobValue.LoadFromStream(source: TStream);
begin
  if fCompareOnSet then begin
    if (not StreamsAreEqual(fValue,source)) then begin
      fValue.LoadFromStream(source);
      fIsNull:= false;
      Dirty:= true;
    end;
  end
  else begin
    fValue.LoadFromStream(source);
    fIsNull:= false;
    Dirty:= true;
  end;
end;

procedure TBlobValue.SaveToField(aField: TField);
begin
  if self.IsNull then
    aField.Clear
  else
    TBlobField(aField).LoadFromStream(Value);
end;

{ TValueField }

constructor TValueField.Create;
begin

end;

destructor TValueField.Destroy;
begin
  fData.Free;
  inherited;
end;

function TValueField.GetDirty: boolean;
begin
  if Assigned(fData) then
    result:= fData.Dirty
  else
    result:= false;
end;

procedure TValueField.SetDirty(const Value: boolean);
begin
  if Assigned(fData) then
    fData.Dirty:= Value;
end;

{ TValueFieldList }

function TValueFieldList.Add(aField: TValueField): integer;
begin
  result:= fList.Add(aField);
end;

function TValueFieldList.Add: TValueField;
begin
  result:= TValueField.Create;
  fList.Add(result);
end;

function TValueFieldList.Add(aFieldName: string;
  aFieldList: TValueFieldList): TValueField;
var
  srcField: TValueField;
begin
  result:= nil;
  if not Assigned(FieldByName[aFieldName]) then begin
    srcField:= aFieldList.FieldByName[aFieldName];
    if Assigned(srcField) then begin
      result:= TValueField.Create;
      result.Name:= aFieldName;
      result.Data:= TValueBase(srcField.Data.ClassType.Create);
      fList.Add(result);
    end;
  end;
end;

procedure TValueFieldList.Clear;
begin
  fList.Clear;
end;

constructor TValueFieldList.Create;
begin
  fIdFieldName:= '';
  fList:= TObjectList.Create(true);
end;

destructor TValueFieldList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TValueFieldList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TValueFieldList.GetDirty: boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to Count-1 do begin
    if Fields[x].Dirty then begin
      result:= true;
      break;
    end;  
  end;
end;

function TValueFieldList.GetField(idx: integer): TValueField;
begin
  result:= TValueField(fList[idx]);
end;

function TValueFieldList.GetFieldByName(aName: string): TValueField;
var
  x: integer;
  fieldName: string;
begin
  result:= nil;
  fieldName:= Lowercase(aName);
  for x:= 0 to count -1 do begin
    if Lowercase(Fields[x].Name) = fieldName then begin
      result:= Fields[x];
      break;
    end;
  end;
end;

procedure TValueFieldList.LoadFromDataset(dataset: TDataSet);
var
  idx: integer;
  fld: TValueField;
  fldClass: TValueBaseClass;
begin
  for idx:= 0 to dataset.FieldCount -1 do begin
    fld:= self.FieldByName[dataset.Fields[idx].FieldName];
    if not Assigned(fld) then begin
      fld:= self.Add;
      fld.Name:= Lowercase(dataset.Fields[idx].FieldName);
    end;
    fldClass:= FieldTypeToClass(dataset.Fields[idx].DataType);
    if not Assigned(fldClass) then
      raise Exception.Create('TValueFieldList.LoadFromDataset - Unknown field type for field "' + fld.Name + '"');
    if Assigned(fld.Data) and (fld.Data.ClassType <> fldClass) then
      fld.Data.Free;
    try
//      if dataset.Fields[idx].FieldName = 'EmpPicture' then
//        beep;
      fld.Data:= fldClass.Create;
      fld.Data.LoadFromField(dataset.Fields[idx]);
    except
      on e: exception do begin
        raise Exception.Create('LoadFromDataset - Error loading field "' +
          dataset.Fields[idx].FieldName + '" with message: ' + e.Message);

      end;
    end;
  end;
  Dirty:= False;
end;

procedure TValueFieldList.SaveToDataset(dataset: TDataSet);
var
  idx: integer;
  fld: TField;
begin
//  TLogger.Inst.Log('Saving dataset: ' + TMyQuery(dataset).SQL.Text);
//  TLogger.Inst.Log('-----------------------------------');
//  TLogger.Inst.Log('Dirty Fields: ');
  for idx:= 0 to Count -1 do begin
    if Fields[idx].Name <> self.IdFieldName then begin
      if Fields[idx].Dirty then begin
        fld:= dataset.FindField(Fields[idx].Name);
//        TLogger.Inst.Log('    ' + fld.FieldName);
        if Assigned(fld) then begin
          if Assigned(Fields[idx].Data) then begin
            if not (fld.Required and Fields[idx].Data.IsNull) then
              Fields[idx].Data.SaveToField(fld);
          end;
        end;
      end;
    end;
  end;
  Dirty:= false;
end;

procedure TValueFieldList.SetDirty(const Value: boolean);
var
  x: integer;
begin
  for x:= 0 to Count-1 do begin
    Fields[x].Dirty:= Value;
  end;
end;

end.
