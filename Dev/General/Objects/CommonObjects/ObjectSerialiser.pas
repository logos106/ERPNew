unit ObjectSerialiser;

interface

uses
  JsonObject,
  TypInfo, sysutils, contnrs, classes, integerlistobj, MyAccess;

type

  TSerialiserConverter<TSerial> = class abstract
  protected
    function GetSerialisedData: TSerial; virtual; abstract;
  public
    property SerialisedData: TSerial read GetSerialisedData;
    function IsConsistent: boolean; virtual; abstract;
//    constructor Create; virtual;
    procedure Clear; virtual; abstract;
//    procedure OnRefType(TypeName: string; id: integer); virtual; abstract;
    procedure OnTypeStart(TypeName: string{; id: integer}); virtual; abstract;
    procedure OnTypeEnd(TypeName: string{; id: integer}); virtual; abstract;
    procedure OnFieldStart(FieldName: string); virtual; abstract;
    procedure OnFieldEnd(FieldName: string); virtual; abstract;
    procedure OnListStart; virtual; abstract;
    procedure OnListEnd; virtual; abstract;
    procedure OnString(Data: string); virtual; abstract;
    procedure OnNumber(Data: string); virtual; abstract;
    procedure OnBoolean(Data: boolean); virtual; abstract;
    procedure OnNull; virtual; abstract;
  end;


  TObjectSerialiser<TSerial: class> = class
  private
    FConverter: TSerialiserConverter<TSerial>;
    procedure ClearWarnings;
  protected
    class function ComposeTypeName(Data: TObject): string;
    function MarshalData(Data: TObject): boolean;
    procedure MarshalValue(PropInfo: PPropInfo; Data: TObject);
  public
    constructor Create(aConverter: TSerialiserConverter<TSerial>);
    destructor Destroy; override;
    function SerialiseObject(aObject: TObject): TSerial; virtual;
    procedure Clear;
  end;

  EConversionError = class(Exception);

  TJSONConverter = class(TSerialiserConverter<TJSONObject>)
  private
    FRoot: TJSONObject;
//    FStack: TStack<TJSONAncestor>;
    fStack: TObjectList;
    fCurrentFieldName: string;
    procedure AddValue(aValue: TJSONValue);
  protected
    function GetSerialisedData: TJSONObject; override;
//    procedure ProcessData(Data: TJSONAncestor); virtual;
//    function GetCurrent: TJSONAncestor;

//    property Current: TJSONAncestor read GetCurrent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; override;
//    procedure OnRefType(TypeName: string; id: integer); override;
    procedure OnTypeStart(TypeName: string{; id: integer}); override;
    procedure OnTypeEnd(TypeName: string{; id: integer}); override;
    procedure OnFieldStart(FieldName: string); override;
    procedure OnFieldEnd(FieldName: string); override;
    procedure OnListStart; override;
    procedure OnListEnd; override;
    procedure OnString(Data: string); override;
    procedure OnNumber(Data: string); override;
    procedure OnBoolean(Data: boolean); override;
    procedure OnNull; override;
    function IsConsistent: boolean; override;
  end;

  TJSONSerialiser = class(TObjectSerialiser<TJSONObject>)
  public
    constructor Create; overload;
    constructor Create(aConverter: TSerialiserConverter<TJsonObject>); overload;
  end;

  TReverterNameEvent = procedure(aName: string; var Continue: boolean) of object;
  TReverterStringEvent = procedure(Data: string; var Continue: boolean) of object;
  TReverterNumberEvent = procedure(Data: string; var Continue: boolean) of object;
  TReverterBooleanEvent = procedure(Data: Boolean; var Continue: boolean) of object;
  TReverterEvent = procedure(var Continue: boolean) of object;

  TSerialiserReverter<TSerial> = class
  private
  protected
    fOnTypeStart: TReverterNameEvent;
    fOnTypeEnd: TReverterNameEvent;
    fOnFieldStart: TReverterNameEvent;
    fOnFieldEnd: TReverterNameEvent;
    fOnListStart: TReverterEvent;
    fOnListEnd: TReverterEvent;
    fOnString: TReverterStringEvent;
    fOnNumber: TReverterNumberEvent;
    fOnBoolean: TReverterBooleanEvent;
    fOnNull: TReverterEvent;
    function DoOnTypeStart(TypeName: string): boolean; virtual;
    function DoOnTypeEnd(TypeName: string): boolean; virtual;
    function DoOnFieldStart(FieldName: string): boolean; virtual;
    function DoOnFieldEnd(FieldName: string): boolean; virtual;
    function DoOnListStart: boolean; virtual;
    function DoOnListEnd: boolean; virtual;
    function DoOnString(Data: String): boolean; virtual;
    function DoOnNumber(Data: String): boolean; virtual;
    function DoOnBoolean(Data: boolean): boolean; virtual;
    function DoOnNull: boolean; virtual;
    function Deserialise(Data: TSerial): boolean; virtual; abstract;
  public
    Messages: TStringList;
    constructor Create;
    destructor Destroy; override;
    property OnTypeStart: TReverterNameEvent read fOnTypeStart write fOnTypeStart;
    property OnTypeEnd: TReverterNameEvent read fOnTypeEnd write fOnTypeEnd;
    property OnFieldStart: TReverterNameEvent read fOnFieldStart write fOnFieldStart;
    property OnFieldEnd: TReverterNameEvent read fOnFieldEnd write fOnFieldEnd;
    property OnListStart: TReverterEvent read fOnListStart write fOnListStart;
    property OnListEnd: TReverterEvent read fOnListEnd write fOnListEnd;
    property OnString: TReverterStringEvent read fOnString write fOnString;
    property OnNumber: TReverterNumberEvent read fOnNumber write fOnNumber;
    property OnBoolean: TReverterBooleanEvent read fOnBoolean write fOnBoolean;
    property OnNull: TReverterEvent read fOnNull write fOnNull;
    function DeserialiseData(Data: TSerial): boolean; virtual;
    function CurrentObjectId: integer; virtual; abstract;
    function CurrentObjectGlobalRef: string; virtual; abstract;
    Function KeyStringFieldValue(KeyStringField:String):String; virtual; abstract;
  end;

  TSerialiserStack = class;
  TObjectDeserialiser<TSerial: class> = class
  private
    fRawMode: boolean;
    procedure AddInvalidTypeMessage(aFieldName, aTypeName, aDataType: string; PropInfo: PPropInfo);
  protected
//    class function ComposeTypeName(Data: TObject): string;
//    function MarshalData(Data: TObject): boolean;
//    procedure MarshalValue(PropInfo: PPropInfo; Data: TObject);
    FReverter: TSerialiserReverter<TSerial>;
    fObject: TObject;
    fStack: TSerialiserStack;
    fDatabaseConnection: TMyConnection;
    procedure DoOnTypeStart(TypeName: string; var Continue: boolean); virtual;
    procedure DoOnTypeEnd(TypeName: string; var Continue: boolean); virtual;
    procedure DoOnFieldStart(FieldName: string; var Continue: boolean); virtual;
    procedure DoOnFieldEnd(FieldName: string; var Continue: boolean); virtual;
    procedure DoOnListStart(var Continue: boolean); virtual;
    procedure DoOnListEnd(var Continue: boolean); virtual;
    procedure DoOnString(Data: string; var Continue: boolean); virtual;
    procedure DoOnNumber(Data: string; var Continue: boolean); virtual;
    procedure DoOnBoolean(Data: boolean; var Continue: boolean); virtual;
    procedure DoOnNull(var Continue: boolean); virtual;
  public
    Messages: TStringList;
    constructor Create(aReverter: TSerialiserReverter<TSerial>);
    destructor Destroy; override;
    function DeserialiseObject(Data: TSerial): TObject; virtual;
    function IsConsistent: boolean; virtual;
    property DatabaseConnection: TMyConnection read fDatabaseConnection write fDatabaseConnection;
    property RawMode: boolean read fRawMode write fRawMode;
  end;

  TJsonSerialiserReverter = class(TSerialiserReverter<TJsonObject>)
  private
    fCurrentObject: TJsonObject;
  protected
    function Deserialise(Data: TJsonObject): boolean; override;
  public
    function DeserialiseData(Data: TJsonObject): boolean; override;
    function CurrentObjectId: integer; override;
    function CurrentObjectGlobalRef: string; override;
    Function KeyStringFieldValue(KeyStringField:String):String; Override;
    property CurrentObject: TJsonObject read fCurrentObject;
  end;

  TJSONDeserialiser = class(TObjectDeserialiser<TJSONObject>)
  public
    constructor Create; overload;
    constructor Create(aReverter: TSerialiserReverter<TJsonObject>); overload;
  end;


  TSerialiserStackItem = class
  public
  end;

  TFieldStackItem= class(TSerialiserStackItem)
  public
    FieldName: string;
  end;

  TListStackItem= class(TSerialiserStackItem)
  public
    KeyValues: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TTypeStackItem= class(TSerialiserStackItem)
  public
    TypeName: string;
    Instance: TObject;
  end;

  TSerialiserStack = class
  private
    fList: TObjectList;
//    FIsEmpty: boolean;
    function GetItem(index: integer): TSerialiserStackItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Push(aItem: TSerialiserStackItem);
    procedure PushField(aFieldName: string);
    procedure PushList;
    procedure PushType(aTypeName: string; aInst: TObject);
    function Peek: TSerialiserStackItem;
    procedure Pop;
    function IsEmpty: boolean;
    function CurrentFieldName: string;
    function InList: boolean;
    function ListInstance: TObject;
    function ParentInstance: TObject;
    function CurrentInstance: TObject;
    property Items[index: integer]: TSerialiserStackItem read GetItem;
    function CurrentListStackItem: TLIstStackItem;
  end;

const
  ISODateTimeFormat = 'yyyy-mm-dd hh:nn:ss';
  ISODateFormat = 'yyyy-mm-dd';
  ISODateSeparator = '-';
  ISOTimeFormat = 'hh:nn:ss';

  STypeNotSupported = 'Internal: Type %s is not currently supported';

implementation

uses
  variants, BusObjBase, strutils, dialogs{, LogThreadLib};

{ TObjectSerialiser }

procedure TObjectSerialiser<TSerial>.Clear;
begin
  if Assigned(fConverter) then
    fConverter.Clear;
end;

procedure TObjectSerialiser<TSerial>.ClearWarnings;
begin

end;

class function TObjectSerialiser<TSerial>.ComposeTypeName(
  Data: TObject): string;
begin
  result:= Data.ClassName; //RightStr(Data.ClassName,Length(Data.ClassName)-1);
end;

constructor TObjectSerialiser<TSerial>.Create(
  aConverter: TSerialiserConverter<TSerial>);
begin

end;

destructor TObjectSerialiser<TSerial>.Destroy;
begin
  fConverter.Free;
  inherited;
end;

function TObjectSerialiser<TSerial>.MarshalData(Data: TObject): boolean;
var
  x: integer;
  PropInfo: PPropInfo;
  Count: integer;
  PropList: PPropList;
  propName: string;
  ExcludeList: TStringList;
  ImportPriorityList: TStringList;

begin
  if Data = nil then begin
    FConverter.OnNull;
  end
  else begin
    ExcludeList:= nil;
    ImportPriorityList:= nil;
    FConverter.OnTypeStart(ComposeTypeName(Data));
    Count := GetPropList(Data.ClassInfo, tkProperties, nil);
    GetMem(PropList, Count * SizeOf(PPropInfo));
    try
      GetPropList(Data.ClassInfo, tkProperties, PropList);

      PropInfo:= GetPropInfo(Data,'ImportFieldsPriorityList');
      if Assigned(PropInfo) then begin
        ImportPriorityList:= TStringList(GetObjectProp(Data, 'ImportFieldsPriorityList'));
        if Assigned(ImportPriorityList) then
          ImportPriorityList.CaseSensitive:= false;
      end;

      PropInfo:= GetPropInfo(Data,'ExportExcludeList');
      if Assigned(PropInfo) then begin
        ExcludeList:= TStringList(GetObjectProp(Data, 'ExportExcludeList'));
        if Assigned(ExcludeList) then
          ExcludeList.CaseSensitive:= false;
      end;
      try
          if Assigned(ImportPriorityList) then begin
            for x := 0 to ImportPriorityList.count -1 do begin
                propName:= String(ImportPriorityList[x]);
                   if propName = 'ExportExcludeList' then continue
              else if propName = 'ImportFieldsPriorityList'    then continue
              else if Assigned(ExcludeList)        and (ExcludeList.IndexOf(propName)        >= 0) then continue;

              PropInfo:= GetPropInfo(Data,propName);
              if (not Assigned(PropInfo.GetProc))  then
                { this is a write-only property so skip it }
                continue;

              FConverter.OnFieldStart(propName);
              try
                MarshalValue(PropInfo,Data);
              finally
                FConverter.OnFieldEnd(propName);
              end;

            end;
          end;
      Except

      end;

      for x := 0 to Count -1 do begin

        propName:= String(PropList[x].Name);

             if propName = 'ExportExcludeList' then continue
        else if propName = 'ImportFieldsPriorityList'    then continue
        else if Assigned(ExcludeList)        and (ExcludeList.IndexOf(propName)        >= 0) then continue
        else if Assigned(ImportPriorityList) and (ImportPriorityList.IndexOf(propName) >= 0) then continue;


        PropInfo:= GetPropInfo(Data,propName);
        if (not Assigned(PropInfo.GetProc))  then
          { this is a write-only property so skip it }
          continue;

        FConverter.OnFieldStart(propName);
        try
          MarshalValue(PropInfo,Data);
        finally
          FConverter.OnFieldEnd(propName);
        end;

      end;
    finally
      FConverter.OnTypeEnd(ComposeTypeName(Data));
      FreeMem(PropList, Count * SizeOf(PPropInfo));
    end;

  end;
end;

procedure TObjectSerialiser<TSerial>.MarshalValue(PropInfo: PPropInfo; Data: TObject);
var
  Val: Variant;
  SubData: TObject;
  x: integer;
begin
    try
      val:= GetPropValue(Data, PropInfo);
      if VarIsNull(val) then
        FConverter.OnNull
      else
        case PropInfo.PropType^.Kind of
          TTypeKind.tkInteger:
            FConverter.OnNumber(IntToStr(val));
          TTypeKind.tkInt64:
            FConverter.OnNumber(IntToStr(GetInt64Prop(Data,PropInfo)));
          TTypeKind.tkFloat:
            begin
              if (CompareText(string(PropInfo^.PropType^.Name),'TDateTime') = 0) then  begin
                if (GetFloatProp(Data,PropInfo) = 0) then
                  FConverter.OnString('')
                else
                  FConverter.OnString(FormatDateTime(ISODateTimeFormat,GetFloatProp(Data,PropInfo)));
              end
              else
                FConverter.OnNumber(FloatToStr(GetFloatProp(Data,PropInfo)));
            end;
          TTypeKind.tkChar:
            FConverter.OnString(GetStrProp(Data,PropInfo));
          TTypeKind.tkWChar:
            FConverter.OnString(GetStrProp(Data,PropInfo));
          TTypeKind.tkString,
          TTypeKind.tkLString,
          TTypeKind.tkWString,
          TTypeKind.tkUString:
            FConverter.OnString(GetStrProp(Data,PropInfo));
          TTypeKind.tkEnumeration:
            if (CompareText('Boolean', string(PropInfo^.PropType^.Name)) = 0) then
              FConverter.OnBoolean(val = 'True')
            else
              FConverter.OnString(val);
          TTypeKind.tkDynArray,
          TTypeKind.tkArray:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkArray']));
          TTypeKind.tkClass:
            begin
              SubData:= GetObjectProp(Data,PropInfo);
    //          showmessage(SubData.ClassName);
              if Assigned(SubData) then begin
                if (SubData is TDatasetBusObj) then begin
                  if TDatasetBusObj(SubData).Count = 0 then
                    MarshalData(nil)
                  else if (TDatasetBusObj(SubData).Count = 1) and (not TDatasetBusObj(SubData).IsList) then
                    MarshalData(SubData)
                  else begin
                    { multiple lines in record set }
                    FConverter.OnListStart;
                    TDatasetBusObj(SubData).First;
                    while not TDatasetBusObj(SubData).EOF do begin
                      MarshalData(SubData);
                      TDatasetBusObj(SubData).Next;
                    end;
                    FConverter.OnListEnd;
                  end;
                end
                else if (SubData is TObjectList) then begin
                  FConverter.OnListStart;
                  for x := 0 to TObjectList(SubData).Count -1 do
                    MarshalData(TObjectList(SubData)[x]);
                  FConverter.OnListEnd;
                end
                else
                  MarshalData(SubData);
              end
              else
                MarshalData(nil);
            end;
          TTypeKind.tkRecord:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkRecord']));
          TTypeKind.tkPointer:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkPointer']));
          TTypeKind.tkSet:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkSet']));
          TTypeKind.tkMethod:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkMethod']));
          TTypeKind.tkVariant:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkVariant']));
          TTypeKind.tkInterface:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkInterface']));
          TTypeKind.tkClassRef:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkClassRef']));
          TTypeKind.tkProcedure:
            raise EConversionError.Create(Format(STypeNotSupported, ['tkProcedure']));
          else
            raise EConversionError.Create(Format(STypeNotSupported,
                [PropInfo^.Name]));
        end;
    Except
      on E:Exception do begin
        FConverter.OnString('Error :'+ E.message)
      end;
    end;
end;

function TObjectSerialiser<TSerial>.SerialiseObject(aObject: TObject): TSerial;
begin
  // clear previous warnings
  ClearWarnings;
  try
    MarshalData(aObject);
    if FConverter.IsConsistent then
      Result := FConverter.SerialisedData
    else
      raise EConversionError.Create('Inconsistent Data')
  finally
    begin
      // clear
//      FObjectHash.Clear;
//      FPointerHash.Clear;
//      FId := 1;
//      FConverter.Clear;
    end;
  end;
end;

{ TJSONConverter }

procedure TJSONConverter.AddValue(aValue: TJSONValue);
var
  obj: TObject;
  pair: TJsonValuePair;
begin
  if not Assigned(fRoot) then begin
    if aValue is TJsonObject then begin
      fRoot:= TJsonObject(aValue);
      fStack.Add(fRoot);
    end;
  end
  else begin
    if fStack.Count > 0 then begin
      obj:= fStack[fStack.Count -1];
      if obj is TJsonObject then begin
        pair:= TJsonValuePair.Create;
        pair.Name:= fCurrentFieldName;
        pair.Value:= aValue;
        TJsonObject(obj).O['fields'].Add(pair);
      end
      else if obj is TJsonArray then begin
        TJsonArray(obj).Add(aValue);
      end;
      case aValue.ValueType of
        valObject, valArray:
          begin
            fStack.Add(aValue);
          end;
      end;
    end;
  end;
end;

procedure TJSONConverter.Clear;
begin
  fStack.Clear;
  fCurrentFieldName:= '';
  fRoot := nil;
end;

constructor TJSONConverter.Create;
begin
  FRoot:= nil;
  fCurrentFieldName:= '';
  fStack:= TObjectList.Create(false);
end;

destructor TJSONConverter.Destroy;
begin
  fStack.Free;
  inherited;
end;

function TJSONConverter.GetSerialisedData: TJSONObject;
begin
  result:= fRoot;
end;

function TJSONConverter.IsConsistent: boolean;
begin
  Result:= (FRoot <> nil);
end;

procedure TJSONConverter.OnBoolean(Data: boolean);
var
  aBool: TJSONBoolean;
begin
  aBool:= TJSONBoolean.Create;
  aBool.Value:= Data;
  AddValue(aBool);
end;

procedure TJSONConverter.OnFieldEnd(FieldName: string);
begin
end;

procedure TJSONConverter.OnFieldStart(FieldName: string);
begin
  fCurrentFieldName:= FieldName;
end;

procedure TJSONConverter.OnListEnd;
begin
  fStack.Delete(fStack.Count -1);
end;

procedure TJSONConverter.OnListStart;
var
  aArray: TJSONArray;
begin
  aArray:= TJSONArray.Create;
  AddValue(aArray);
end;

procedure TJSONConverter.OnNull;
var
  aNull: TJSONNull;
begin
  aNull:= TJSONNull.Create;
  AddValue(aNull);
end;

procedure TJSONConverter.OnNumber(Data: string);
var
  aNum: TJSONNumber;
begin
  aNum:= TJSONNumber.Create;
  aNum.AsString:= Data;
  AddValue(aNum);
end;

procedure TJSONConverter.OnString(Data: string);
var
  aString: TJSONString;
begin
  // if the string blank and has only new line character(s),
  // then trim it as json inserts a new line , not \r\n
  if  trim(data)= '' then
    data := replacestr(data, chr(13)+chr(10), '');

  aString:= TJSONString.Create;
  aString.Value:= Data;
  AddValue(aString);
end;

procedure TJSONConverter.OnTypeEnd(TypeName: string);
begin
  if fStack.Count >0 then
    fStack.Delete(fStack.Count -1);
end;

procedure TJSONConverter.OnTypeStart(TypeName: string);
var
  aObj: TJSONObject;
begin
  aObj:= TJSONObject.Create;
  aObj.S['type']:= TypeName;
  AddValue(aObj);
end;

{ TJSONSerialiser }

constructor TJSONSerialiser.Create;
begin
  Create(TJSONConverter.Create);
end;

constructor TJSONSerialiser.Create(
  aConverter: TSerialiserConverter<TJsonObject>);
begin
  FConverter:= aConverter;
  inherited;
end;


{ TObjectDeserialiser<TSerial> }

procedure TObjectDeserialiser<TSerial>.AddInvalidTypeMessage(aFieldName,
  aTypeName, aDataType: string; PropInfo: PPropInfo);
begin
  Messages.Add('The data for: ' + aTypeName + ' field: ' +
    aFieldName +
    ' is of the wrong type, where expecting ' + String(PropInfo^.PropType^.Name)+
    ' but received ' + aDataType);
end;

constructor TObjectDeserialiser<TSerial>.Create(
  aReverter: TSerialiserReverter<TSerial>);
begin
  fStack:= TSerialiserStack.Create;
  fReverter:= aReverter;
  Messages:= TStringList.Create;
  fRawMode:= false;
  fReverter.OnTypeStart:= DoOnTypeStart;
  fReverter.OnTypeEnd:= DoOnTypeEnd;
  fReverter.OnFieldStart:= DoOnFieldStart;
  fReverter.OnFieldEnd:= DoOnFieldEnd;
  fReverter.OnListStart:= DoOnListStart;
  fReverter.OnListEnd:= DoOnListEnd;
  fReverter.OnString:= DoOnString;
  fReverter.OnNumber:= DoOnNumber;
  fReverter.OnBoolean:= DoOnBoolean;
  fReverter.OnNull:= DoOnNull;
end;

function TObjectDeserialiser<TSerial>.DeserialiseObject(Data: TSerial): TObject;
var
  x: integer;
begin
  fStack.Clear;
  fObject.Free;
  fObject := nil;
  Messages.Clear;
  if Assigned(fReverter) then begin
    fReverter.DeserialiseData(Data);
    for x := 0 to fReverter.Messages.Count - 1 do
      Messages.Add(fReverter.Messages[x]);
    if not self.IsConsistent then begin
      fObject.Free;
      fObject := nil;
    end;
  end;
  Result := fObject;
end;

destructor TObjectDeserialiser<TSerial>.Destroy;
begin
  Messages.Free;
  fObject.Free;
  fStack.Free;
  inherited;
end;

procedure TObjectDeserialiser<TSerial>.DoOnBoolean(Data: boolean;
  var Continue: boolean);
var
  CurrentInst: TObject;
  PropInfo: PPropInfo;
  int: integer;
  bigint: int64;
  float: double;

begin
//  TLogger.Inst.Log('DoOnBoolean: ');
  try
    CurrentInst := fStack.CurrentInstance;
    if Assigned(CurrentInst) then begin
      PropInfo := GetPropInfo(CurrentInst, fStack.CurrentFieldName);
      if Assigned(PropInfo) then begin
        try
          if Assigned(Propinfo.SetProc) then begin
            case PropInfo^.PropType^.Kind of
              tkEnumeration:
                begin
                  if PropInfo^.PropType^.Name = 'Boolean' then begin
                    if Data then
                      SetEnumProp(CurrentInst,PropInfo, 'True')
                    else
                      SetEnumProp(CurrentInst,PropInfo, 'False');
                  end
                  else begin
                    Continue := false;
                    AddInvalidTypeMessage(fStack.CurrentFieldName, CurrentInst.ClassName, 'True/False', PropInfo);
                  end;
                end;
              tkInteger,
              tkInt64,
              tkFloat,
              tkChar,
              tkWChar,
              tkString,
              tkUString,
              tkLString,
              tkWString,
              tkUnknown,
              tkSet,
              tkClass,
              tkMethod,
              tkVariant,
              tkArray,
              tkRecord,
              tkInterface,
              tkDynArray,
              tkClassRef,
              tkPointer,
              tkProcedure:
                begin
                  Continue := false;
                  AddInvalidTypeMessage(fStack.CurrentFieldName,
                    CurrentInst.ClassName, 'True/False', PropInfo);
                end;
            end;
          end;
        except
          on e: exception do begin
            Continue:= false;
            Messages.Add('Error setting true/false field ' + fStack.CurrentFieldName +
              ' for object ' + CurrentInst.ClassName + ' with message: ' +
              e.Message);
          end;
        end;
      end
      else begin
        Continue:= true;
        Messages.Add('Could not find field ' + fStack.CurrentFieldName +
          ' for object ' + CurrentInst.ClassName);
      end;
    end
    else begin
      Continue:= false;
      Messages.Add('Missing object for field ' + fStack.CurrentFieldName);
    end;
  Except
    on E:Exception do begin
      Messages.Add('Error Setting field ' + fStack.CurrentFieldName+':' +E.message);
    end;
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnFieldEnd(FieldName: string;
  var Continue: boolean);
begin
//  TLogger.Inst.Log('DoOnFieldEnd: ' + FieldName);
  if (fStack.Peek is TFieldStackItem) and (TFieldStackItem(fStack.Peek).FieldName = FieldName) then
    fStack.Pop
  else begin
    Continue:= false;
    Messages.Add('Out of sequence data for field end for ' + FieldName);
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnFieldStart(FieldName: string;
  var Continue: boolean);
begin
//  TLogger.Inst.Log('DoOnFieldStart: ' + FieldName);
  fStack.PushField(FieldName);
end;

procedure TObjectDeserialiser<TSerial>.DoOnListEnd(var Continue: boolean);
var
  DsBusObj: TDatasetBusObj;
  deleted: boolean;
  ListObj: TObject;
begin
//  TLogger.Inst.Log('DoOnListEnd: ');
  if (fStack.Peek is TListStackItem) then begin
    if fStack.CurrentInstance is TDatasetBusObj then begin
      ListObj:= GetObjectProp(fStack.CurrentInstance,fStack.CurrentFieldName);
      if Assigned(ListObj) and (ListObj is TDatasetBusObj) then begin
        DsBusObj:= TDatasetBusObj(ListObj);
        { delete records from source that where not in the source json }
        if (DsBusObj.Count > 0) then begin
          DsBusObj.First;
          while not DsBusObj.EOF do begin
            deleted := false;
            if DsBusObj.KeyValue <> '' then begin
              {  we are using KeyValue to locate list items ... }
              if TListStackItem(fStack.Peek).KeyValues.IndexOf(DsBusObj.KeyValue) < 0 then begin
                if DsBusObj.Delete then
                  deleted := true
                else begin
                  Continue:= false;
                  Messages.Add('Failed to delete list item for object ' + fStack.CurrentInstance.ClassName);
                  break;
                end;
              end;
            end
            else if (DsBusObj is TMSBusObj) and (TMSBusObj(DsBusObj).GlobalRef <> '') then begin
              {  we are using GlobalRef to locate list items ... }
              { .. or id if there was no GlobalRef sent with json data }
              if (TListStackItem(fStack.Peek).KeyValues.IndexOf(TMSBusObj(DsBusObj).GlobalRef) < 0) and
                 (TListStackItem(fStack.Peek).KeyValues.IndexOfObject(TObject(DsBusObj.ID)) < 0) then begin
                if DsBusObj.Delete then
                  deleted := true
                else begin
                  Continue:= false;
                  Messages.Add('Failed to delete list item for object ' + fStack.CurrentInstance.ClassName);
                  break;
                end;
              end;
            end
            else if (TListStackItem(fStack.Peek).KeyValues.IndexOfObject(TObject(DsBusObj.ID)) < 0) then begin
              if DsBusObj.Delete then
                deleted := true
              else begin
                Continue:= false;
                Messages.Add('Failed to delete list item for object ' + fStack.CurrentInstance.ClassName);
                break;
              end;
            end
            else
             break;
            if not deleted then
              DsBusObj.Next;
          end;
        end;
      end;
    end;

    fStack.Pop
  end
  else begin
    Continue:= false;
    Messages.Add('Out of sequence data for list end');
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnListStart(var Continue: boolean);
begin
//  TLogger.Inst.Log('DoOnListStart: ');
  fStack.PushList;
end;

procedure TObjectDeserialiser<TSerial>.DoOnNull(var Continue: boolean);
var
  CurrentInst, SubInst: TObject;
  PropInfo: PPropInfo;
  int: integer;
  bigint: int64;
  float: double;
  PreDeleteCount: integer;

begin
  //  TLogger.Inst.Log('DoOnNull: ');
  try
    CurrentInst:= fStack.CurrentInstance;
    if Assigned(CurrentInst) then begin
      PropInfo:= GetPropInfo(CurrentInst,fStack.CurrentFieldName);
      if Assigned(PropInfo) then begin
        try
          if Assigned(Propinfo.SetProc) then begin
            case PropInfo^.PropType^.Kind of
              tkClass:
                begin
                  SubInst:= GetObjectProp(CurrentInst,PropInfo);
                  SubInst.Free;
                  SetObjectProp(CurrentInst,PropInfo, nil);
                end;
              tkInteger,
              tkInt64,
              tkFloat,
              tkChar,
              tkWChar,
              tkString,
              tkUString,
              tkLString,
              tkWString,
              tkUnknown,
              tkEnumeration,
              tkSet,
              tkMethod,
              tkVariant,
              tkArray,
              tkRecord,
              tkInterface,
              tkDynArray,
              tkClassRef,
              tkPointer,
              tkProcedure:
                begin
                  Continue:= false;
                  AddInvalidTypeMessage(fStack.CurrentFieldName,
                    CurrentInst.ClassName,'Null',PropInfo);
                end;
            end;
          end
          else begin
            { read only property }
            if PropInfo^.PropType^.Kind = tkClass then begin
              SubInst:= GetObjectProp(CurrentInst,PropInfo);
              if Assigned(SubInst) then begin
                if (SubInst is TDatasetBusObj) then begin
                  while TDatasetBusObj(SubInst).Count > 0 do begin
                    PreDeleteCount:= TDatasetBusObj(SubInst).Count;
                    if (not TDatasetBusObj(SubInst).Delete) or (PreDeleteCount = TDatasetBusObj(SubInst).Count) then begin
                      Continue:= false;
                      Messages.Add('Could not delete records for ' + fStack.CurrentFieldName +
                        ' for object ' + CurrentInst.ClassName);
                      break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        except
          on e: exception do begin
            Continue:= false;
            Messages.Add('Error setting null field ' + fStack.CurrentFieldName +
              ' for object ' + CurrentInst.ClassName + ' with message: ' +
              e.Message);
          end;
        end;
      end
      else begin
        Continue:= true;
        Messages.Add('Could not find field ' + fStack.CurrentFieldName +
          ' for object ' + CurrentInst.ClassName);
      end;
    end
    else begin
      Continue:= false;
      Messages.Add('Missing object for field ' + fStack.CurrentFieldName);
    end;
  Except
    on E:Exception do begin
      Messages.Add('Error Setting field ' + fStack.CurrentFieldName+':' +E.message);
    end;
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnNumber(Data: string;
  var Continue: boolean);
var
  CurrentInst: TObject;
  PropInfo: PPropInfo;
  int: integer;
  bigint: int64;
  float: double;

begin
  //  TLogger.Inst.Log('DoOnNumber: ');
  try
    CurrentInst:= fStack.CurrentInstance;
    if Assigned(CurrentInst) then begin
      PropInfo:= GetPropInfo(CurrentInst,fStack.CurrentFieldName);
      if Assigned(PropInfo) then begin
        try
          if Assigned(Propinfo.SetProc) then begin
            case PropInfo^.PropType^.Kind of
              tkInteger:
                begin
                  int:= StrToInt(Data);
                  SetOrdProp(CurrentInst,PropInfo,int);
                end;
              tkInt64:
                begin
                  bigint:= StrToInt64(Data);
                  SetInt64Prop(CurrentInst,PropInfo,bigint);
                end;
              tkFloat:
                begin
                  float:= StrToFloat(Data);
                  SetFloatProp(CurrentInst,PropInfo,float);
                end;
              tkChar,
              tkWChar,
              tkString,
              tkUString,
              tkLString,
              tkWString,
              tkUnknown,
              tkEnumeration,
              tkSet,
              tkClass,
              tkMethod,
              tkVariant,
              tkArray,
              tkRecord,
              tkInterface,
              tkDynArray,
              tkClassRef,
              tkPointer,
              tkProcedure:
                begin
                  Continue:= false;
                  AddInvalidTypeMessage(fStack.CurrentFieldName,
                    CurrentInst.ClassName,'Number',PropInfo);
                end;
            end;
          end;
        except
          on e: exception do begin
            Continue:= false;
            Messages.Add('Error setting number field ' + fStack.CurrentFieldName +
              ' for object ' + CurrentInst.ClassName + ' with message: ' +
              e.Message);
          end;
        end;
      end
      else begin
        Continue:= true;
        Messages.Add('Could not find field ' + fStack.CurrentFieldName +
          ' for object ' + CurrentInst.ClassName);
      end;
    end
    else begin
      Continue:= false;
      Messages.Add('Missing object for field ' + fStack.CurrentFieldName);
    end;
  Except
    on E:Exception do begin
      Messages.Add('Error Setting field ' + fStack.CurrentFieldName+':' +E.message);
    end;
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnString(Data: string;
  var Continue: boolean);
var
  CurrentInst: TObject;
  PropInfo: PPropInfo;
  datetime: TDateTime;
  fmtSettings: TFormatSettings;

begin
    //  TLogger.Inst.Log('DoOnString: ');
    try
      CurrentInst:= fStack.CurrentInstance;
      if Assigned(CurrentInst) then begin
        PropInfo:= GetPropInfo(CurrentInst,fStack.CurrentFieldName);
        if Assigned(PropInfo) then begin
          try
            if Assigned(Propinfo.SetProc) then begin
              case PropInfo^.PropType^.Kind of
                tkChar,
                tkWChar,
                tkString,
                tkUString,
                tkLString,
                tkWString:
                  begin
                    SetStrProp(CurrentInst,PropInfo,Data);
                  end;
                tkFloat:
                  begin
                    if PropInfo.PropType^.Name = 'TDateTime' then begin
                      if Data = '' then
                        datetime:= 0
                      else begin
                        fmtSettings:= TFormatSettings.Create;
                        fmtSettings.ShortDateFormat:= ISODateFormat;
                        fmtSettings.ShortTimeFormat:= ISOTimeFormat;
                        fmtSettings.DateSeparator:= ISODateSeparator;
                        datetime:= StrToDateTime(Data,fmtSettings);
                      end;
                      SetFloatProp(CurrentInst,PropInfo,datetime);
                    end
                    else begin
                      Continue:= false;
                      AddInvalidTypeMessage(fStack.CurrentFieldName,
                        CurrentInst.ClassName,'Text',PropInfo);
                    end;
                  end;
                tkUnknown,
                tkInteger,
                tkEnumeration:
                  begin
                    SetEnumProp(CurrentInst,PropInfo,Data);
                  end;
                tkSet,
                tkClass,
                tkMethod,
                tkVariant,
                tkArray,
                tkRecord,
                tkInterface,
                tkInt64,
                tkDynArray,
                tkClassRef,
                tkPointer,
                tkProcedure:
                  begin
                    Continue:= false;
                    AddInvalidTypeMessage(fStack.CurrentFieldName,
                      CurrentInst.ClassName,'Text',PropInfo);
                  end;
              end;
            end;
          except
            on e: exception do begin
              Continue:= false;
              Messages.Add('Error setting text field ' + fStack.CurrentFieldName +
                ' for object ' + CurrentInst.ClassName + ' with message: ' +
                e.Message);
            end;
          end;
        end
        else begin
          Continue:= true;
          Messages.Add('Could not find field ' + fStack.CurrentFieldName +
            ' for object ' + CurrentInst.ClassName);
        end;
      end
      else begin
        Continue:= false;
        Messages.Add('Missing object for field ' + fStack.CurrentFieldName);
      end;
    Except
      on E:Exception do begin
        Messages.Add('Error Setting field ' + fStack.CurrentFieldName+':' +E.message);
      end;
    end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnTypeEnd(TypeName: string;
  var Continue: boolean);
var
  DsBusObj: TDatasetBusObj;
  KeyPropertyValue: string;
begin
//  TLogger.Inst.Log('DoOnTypeEnd: ' + TypeName);
  if (fStack.Peek is TTypeStackItem) and (TTypeStackItem(fStack.Peek).TypeName = TypeName) then begin
    if TTypeStackItem(fStack.Peek).Instance is TDatasetBusObj then begin
      DsBusObj := TDatasetBusObj(TTypeStackItem(fStack.Peek).Instance);
      DsBusObj.PostDb;
      if fStack.InList then begin

        { keep a list of the lists KeyValues as we process them }
        KeyPropertyValue:= '';
        if DsBusObj.GetKeyStringProperty <> '' then
          KeyPropertyValue := DsBusObj.KeyValue
        else begin
          if (DsBusObj is TMSBusObj) then
            KeyPropertyValue := TMSBusObj(DsBusObj).GlobalRef;
        end;

        { include ID as object }

        fStack.CurrentListStackItem.KeyValues.AddObject(KeyPropertyValue, TObject(DsBusObj.ID));
      end;
    end;
    fStack.Pop;
  end
  else begin
    Continue:= false;
    Messages.Add('Out of sequence data for type end for ' + TypeName);
  end;
end;

procedure TObjectDeserialiser<TSerial>.DoOnTypeStart(TypeName: string;
  var Continue: boolean);
var
  TypeClass: TPersistentClass;
  DsBusObj: TDatasetBusObj;
  ObjId: integer;
  PropInfo: PPropInfo;
  obj, ParentObject: TObject;
  KeyPropertyName, KeyPropertyValue, s: string;
  found: boolean;
  GlobalRef: string;
  fsKeyStringField:string;
begin
//  TLogger.Inst.Log('DoOnTypeStart: ' + TypeName);
  if not Assigned(fObject) then begin
    { this is the root object }
    TypeClass:= FindClass(TypeName);
    if not Assigned(TypeClass) then begin
      Messages.Add('Object Class Type not found for ' + TypeName);
      continue:= false;
      exit;
    end;
    if TypeClass.InheritsFrom(TDatasetBusObj) then begin
      fObject := TDatasetBusObjClass(TypeClass).Create(nil);
      DsBusObj := TDatasetBusObj(fObject);
      DsBusObj.Connection := TMyDacDataConnection.Create(DsBusObj);
      DsBusObj.Connection.MyDacConnection := DatabaseConnection;
      DsBusObj.SilentMode := True;
      ObjId := FReverter.CurrentObjectId;
      if ObjId > 0 then
        DsBusObj.Load(ObjId)
      else begin
        found := False;
        if DsBusObj.GetKeyStringField <> '' then begin
          fsKeyStringField := FReverter.KeyStringFieldValue(DsBusObj.GetKeyStringField);
          if fsKeyStringField <> '' then begin
            DsBusObj.Loadselect(DsBusObj.GetKeyStringField + '= ' + QuotedStr(fsKeyStringField));
            if DSBusObj.Count <> 0 then begin
              found:= true;
            end;
          end;
        end;
        if not found then begin
          GlobalRef := FReverter.CurrentObjectGlobalRef;
          if GlobalRef <> '' then begin
            DsBusObj.Load(GlobalRef);
            if DSBusObj.Count = 0 then begin
              continue:= false;
              Messages.Add('Not found for GlobalRef: ' + GlobalRef);
              exit;
            end;
          end
          else
            DsBusObj.Load(ObjId); { load with 0 ID }
        end;
      end;

      if (DsBusObj.Count > 0) then begin
        { found a record }
        { now try and lock it .. }
        if not DsBusObj.Lock then begin
          continue := false;
          Messages.Add('Unable to lock object: ' + trim(DsBusObj.UserLock.LockMessage+chr(13)+ DsBusObj.LastErrorMsgFromREsultStatus));
          Exit;
        end;
      end
      else begin
        { non found }
        if (ObjId > 0) then begin
          { we should have found a record with this ID, error if not .. }
          continue:= false;
          Messages.Add('No data found for object ' + TypeName + ' with Id ' + IntToStr(objId));
          Exit;
        end
        else begin
          { not found for global ref }
          { new record .. }
          DsBusObj.New;
        end;
      end;
      DsBusObj.RawMode:= RawMode;
    end
    else
      fObject:= TypeClass.Create;
    fStack.PushType(TypeName,fObject);
  end
  else begin
    { not the root object }
    ParentObject:= fStack.ParentInstance;
    PropInfo:= GetPropInfo(ParentObject,fStack.CurrentFieldName);
    if not Assigned(PropInfo) then begin
      continue:= false;
      Messages.Add('Object property not found for field ' + fStack.CurrentFieldName);
      exit;
    end;
    if PropInfo.PropType^.Kind <> tkClass then begin
      continue:= false;
      Messages.Add('Property ' + fStack.CurrentFieldName + ' is not of expected class type');
      exit;
    end;
    obj:= GetObjectProp(ParentObject,PropInfo);
    fStack.PushType(TypeName,obj);
    if obj is TDatasetBusObj then begin
      DsBusObj:= TDatasetBusObj(obj);

      if (DsBusObj.GetKeyStringProperty <> '') and TJsonSerialiserReverter(fReverter).CurrentObject.StringExists('KeyValue') then begin
        KeyPropertyName:= 'KeyValue';
        KeyPropertyValue:= TJsonSerialiserReverter(fReverter).CurrentObject.S['KeyValue'];
      end
      else if TJsonSerialiserReverter(fReverter).CurrentObject.StringExists('GlobalRef') then begin
        KeyPropertyName:= 'GlobalRef';
        KeyPropertyValue:= TJsonSerialiserReverter(fReverter).CurrentObject.S['GlobalRef'];
      end
      else if TJsonSerialiserReverter(fReverter).CurrentObject.IntegerExists('ID') then begin
        KeyPropertyName:= 'ID';
        KeyPropertyValue:= IntToStr(TJsonSerialiserReverter(fReverter).CurrentObject.I['ID']);
      end;


      found:= false;
      if KeyPropertyValue <> '' then begin

        { now locate current key value }
        DsBusObj.First;
        while not DsBusObj.EOF do begin
          if KeyPropertyName = 'KeyValue' then
            s := DsBusObj.KeyValue
          else if SameText(KeyPropertyName,'GlobalRef') and (DsBusObj is TMSBusObj) then
            s := TMSBusObj(DsBusObj).GlobalRef
          else if SameText(KeyPropertyName,'ID') then
            s := IntToStr(DsBusObj.ID);
          if s = '' then begin
            continue:= false;
            Messages.Add('Property ' + KeyPropertyName + ' is blank in destination object');
            exit;
          end;
          if SameText(KeyPropertyValue,s) then begin
            found:= true;
            break;
          end;
          DsBusObj.Next;
        end;
      end;

      if not found then begin
        if (not DsBusObj.IsList) and (DsBusObj.Count > 0) then begin
          { if this is a non-list type item and an instance already exists then use that. }
          { ie if object is automatically created by parent .. eg TPQA }
          DsBusObj.First;
        end
        else begin
          { new ... }
          if Assigned(DsBusObj.Owner) and (DsBusObj.Owner is TDatasetBusObj) and (TDatasetBusObj(DsBusObj.Owner).ID < 1) then
            TDatasetBusObj(DsBusObj.Owner).PostDb;
          DsBusObj.New;
          DsBusObj.RawMode:= RawMode;
//          if DsBusObj.ID < 1 then
//            DsBusObj.PostDb;
        end;
      end;

    end
    else begin
      { we don't know how to deal with this class type }
      continue:= false;
      Messages.Add('Object type ' + TypeName + ' not supported for property ' + fStack.CurrentFieldName);
      exit;
    end;
  end;
end;

function TObjectDeserialiser<TSerial>.IsConsistent: boolean;
begin
  result:= Messages.Count = 0;
end;

{ TSerialiserReverter<TSerial> }

constructor TSerialiserReverter<TSerial>.Create;
begin
  Messages:= TStringList.Create;
end;

function TSerialiserReverter<TSerial>.DeserialiseData(Data: TSerial): boolean;
begin
  Messages.Clear;
  Result := Deserialise(Data);
end;

destructor TSerialiserReverter<TSerial>.Destroy;
begin
  Messages.Free;
  inherited;
end;

function TSerialiserReverter<TSerial>.DoOnBoolean(Data: boolean): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('        DoOnBoolean: ');
  if not Assigned(fOnBoolean) then
    raise EConversionError.Create('Reverter event OnBoolean not assigned');
  continue:= true;
  fOnBoolean(Data,continue);
  result:= continue;
end;

function TSerialiserReverter<TSerial>.DoOnFieldEnd(FieldName: string): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('    DoOnFieldEnd: ' + FieldName);
  if not Assigned(fOnFieldEnd) then
    raise EConversionError.Create('Reverter event OnFieldEnd not assigned');
  continue:= true;
  fOnFieldEnd(FieldName,continue);
  result:= continue;
end;

function TSerialiserReverter<TSerial>.DoOnFieldStart(
  FieldName: string): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('    DoOnFieldStart: ' + FieldName);
  if not Assigned(fOnFieldStart) then
    raise EConversionError.Create('Reverter event OnFieldStart not assigned');
  continue:= true;
  fOnFieldStart(FieldName,continue);
  result:= continue;
end;

function TSerialiserReverter<TSerial>.DoOnListEnd: Boolean;
var
  continue: Boolean;
begin
//  TLogger.Inst.Log('DoOnListEnd: ');
  if not Assigned(fOnListEnd) then
    raise EConversionError.Create('Reverter event OnListEnd not assigned');
  continue := True;
  fOnListEnd(continue);
  Result := continue;
end;

function TSerialiserReverter<TSerial>.DoOnListStart: boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('DoOnListStart: ');
  if not Assigned(fOnListStart) then
    raise EConversionError.Create('Reverter event OnListStart not assigned');
  continue := True;
  fOnListStart(continue);
  Result := continue;
end;

function TSerialiserReverter<TSerial>.DoOnNull: Boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('        DoOnNull: ');
  if not Assigned(fOnNull) then
    raise EConversionError.Create('Reverter event OnNull not assigned');
  continue:= true;
  fOnNull(continue);
  result:= continue;
end;

function TSerialiserReverter<TSerial>.DoOnNumber(Data: String): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('        DoOnNumber: ');
  if not Assigned(fOnNumber) then
    raise EConversionError.Create('Reverter event OnNumber not assigned');
  continue := true;
  fOnNumber(Data, continue);
  Result := continue;
end;

function TSerialiserReverter<TSerial>.DoOnString(Data: String): boolean;
var
  continue: boolean;
begin
  if not Assigned(fOnString) then
    raise EConversionError.Create('Reverter event OnString not assigned');
  continue := True;
  fOnString(Data, continue);
  Result := continue;
end;

function TSerialiserReverter<TSerial>.DoOnTypeEnd(TypeName: string): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('DoOnTypeEnd: ' + TypeName);
  if not Assigned(fOnTypeEnd) then
    raise EConversionError.Create('Reverter event OnTypeEnd not assigned');
  continue:= true;
  fOnTypeEnd(TypeName,continue);
  result:= continue;
end;

function TSerialiserReverter<TSerial>.DoOnTypeStart(TypeName: string): boolean;
var
  continue: boolean;
begin
//  TLogger.Inst.Log('DoOnTypeStart: ' + TypeName);
  if not Assigned(fOnTypeStart) then
    raise EConversionError.Create('Reverter event OnTypeStart not assigned');
  continue:= true;
  fOnTypeStart(TypeName,continue);
  result:= continue;
end;

{ TJsonSerialiserReverter }
Function TJsonSerialiserReverter.KeyStringFieldValue(KeyStringField:String):String;
begin
  result := '';
  if KeyStringField = '' then exit;
  if Assigned(fCurrentObject) and fCurrentObject.StringExists(KeyStringField) then begin
    result:= fCurrentObject.S[KeyStringField];
    result := AnsiDequotedStr(result,#39);
    result:= AnsiDequotedStr(result,'"');
  end;
end;
function TJsonSerialiserReverter.CurrentObjectGlobalRef: string;
begin
  result := '';
  if Assigned(fCurrentObject) and fCurrentObject.StringExists('GlobalRef') then begin
    result:= fCurrentObject.S['GlobalRef'];
    result := AnsiDequotedStr(result,#39);
    result:= AnsiDequotedStr(result,'"');
  end;
end;

function TJsonSerialiserReverter.CurrentObjectId: integer;
begin
  result:= 0;
  if Assigned(fCurrentObject) and fCurrentObject.Exists('id') then
    result:= fCurrentObject.ItemByName['id'].Value.AsInteger;
end;

function TJsonSerialiserReverter.Deserialise(Data: TJsonObject): boolean;
var
  x: integer;
  pair: TJsonValuePair;
  CurrObj: TJsonObject;

  function ProcessValue(val: TJsonValue): boolean;
  var
    i: integer;
    arr: TJsonArray;
  begin
    Result := True;
    case val.ValueType of
      JsonObject.valNone: Result := DoOnNull;
      JsonObject.valString: Result := DoOnString(val.AsString);
      JsonObject.valNumber: Result := DoOnNumber(val.AsString);
      JsonObject.valObject: Result := Deserialise(val.AsObject);
      JsonObject.valArray:
        begin
          arr := TJsonArray(val);
          Result := DoOnListStart;
          if not Result then Exit;
          for i := 0 to arr.Count - 1 do begin
            Result := ProcessValue(arr.Items[i]);
            if not Result then Exit;
          end;
          Result := DoOnListEnd;
          if not Result then Exit;
        end;
      JsonObject.valNull: Result := DoOnNull;
      JsonObject.valBoolean: Result := DoOnBoolean(val.AsBoolean);
    end;
  end;

begin
  if not Assigned(Data) then begin
    result:= DoOnNull;
  end
  else begin
    if not Data.StringExists('type') then begin
      Result := False;
      Messages.Add('Invalid JSON object structure - object type missing');
      Exit;
    end;
    if not Data.ObjectExists('fields') then begin
      Result := False;
      Messages.Add('Invalid JSON object structure - object fields missing');
      Exit;
    end;
    CurrObj := Data.O['fields'];
    fCurrentObject := CurrObj;
    Result := DoOnTypeStart(Data.S['type']);
    if not Result then Exit;
    { do simple properties first }
    for x := 0 to CurrObj.Count - 1 do begin
      pair := CurrObj.Items[x];
      if not (pair.ValueType in [valObject, valArray]) then begin
        Result := DoOnFieldStart(pair.Name);
        if not Result then Exit;
        Result := ProcessValue(pair.Value);
        if not Result then Exit;
        Result := DoOnFieldEnd(pair.Name);
        if not Result then Exit;
      end;
    end;
    { .. then sup objects and arrays }
    for x := 0 to CurrObj.Count - 1 do begin
      pair:= CurrObj.Items[x];
      if (pair.ValueType in [valObject, valArray]) then begin
        Result := DoOnFieldStart(pair.Name);
        if not Result then Exit;
        Result := ProcessValue(pair.Value);
        if not Result then Exit;
        Result := DoOnFieldEnd(pair.Name);
        if not Result then Exit;
      end;
    end;
    Result := DoOnTypeEnd(Data.S['type']);
    if not Result then Exit;
  end;
end;

function TJsonSerialiserReverter.DeserialiseData(Data: TJsonObject): boolean;
begin
  fCurrentObject:= nil;
  result:= inherited DeserialiseData(Data);
end;

{ TSerialiserStack }

procedure TSerialiserStack.Clear;
begin
  fList.Clear;
end;

constructor TSerialiserStack.Create;
begin
  fList:= TObjectList.Create(true);
end;

function TSerialiserStack.CurrentFieldName: string;
var
  x: integer;
begin
  result:= '';
  for x := fList.Count-1 downto 0 do begin
    if Items[x] is TFieldStackItem then begin
      result:= TFieldStackItem(Items[x]).FieldName;
      break;
    end;
  end;
end;

function TSerialiserStack.CurrentInstance: TObject;
var
  x: integer;
begin
  result:= nil;
  for x := fList.Count-1 downto 0 do begin
    if Items[x] is TTypeStackItem then begin
      result:= TTypeStackItem(Items[x]).Instance;
      break;
    end;
  end;
end;

function TSerialiserStack.CurrentListStackItem: TListStackItem;
var
  x: integer;
begin
  result:= nil;
  for x := fList.Count-1 downto 0 do begin
    if Items[x] is TListStackItem then begin
      result:= TListStackItem(Items[x]);
      break;
    end;
  end;
end;

destructor TSerialiserStack.Destroy;
begin
  fList.Free;
  inherited;
end;

function TSerialiserStack.GetItem(index: integer): TSerialiserStackItem;
begin
  result:= TSerialiserStackItem(fList[index]);
end;

function TSerialiserStack.InList: boolean;
var
  x: integer;
begin
  result:= false;
  for x := fList.Count-1 downto 0 do begin
    if Items[x] is TFieldStackItem then begin
      break;
    end
    else if Items[x] is TListStackItem then begin
      result:= true;
      break;
    end;
  end;
end;

function TSerialiserStack.IsEmpty: boolean;
begin
  result:= fList.Count = 0;
end;

function TSerialiserStack.ListInstance: TObject;
var
  x, y: integer;
begin
  result:= nil;
  { find the beginning of the list ... }
  for x := fList.Count-1 downto 0 do begin
    if Items[x] is TListStackItem then begin
      { now find the type instance that is the list }
      for y := x -1 downto 0 do begin
        if Items[y] is TFieldStackItem then
          { the field name of the list }
          continue
        else if Items[y] is TTypeStackItem then begin
          result:= TTypeStackItem(Items[y]).Instance;
          exit;
        end
        else
          { should be nothing eles inbetween so exit }
          exit;
      end;
    end;
  end;
end;

function TSerialiserStack.ParentInstance: TObject;
begin
  if InList then
    result:= ListInstance
  else
    result:= CurrentInstance;
end;

function TSerialiserStack.Peek: TSerialiserStackItem;
begin
  if fList.Count > 0 then
    result:= TSerialiserStackItem(fList[fList.Count -1])
  else
    result:= nil;
end;

procedure TSerialiserStack.Pop;
begin
  if fList.Count > 0 then begin
//    TLogger.Inst.Log('                        Pop ' + fList.Items[fList.Count-1].ClassName);
    fList.Delete(fList.Count-1);
  end;
end;

procedure TSerialiserStack.Push(aItem: TSerialiserStackItem);
begin
//  TLogger.Inst.Log('                Pushing ' + aItem.ClassName);
  fList.Add(aItem);
end;

procedure TSerialiserStack.PushField(aFieldName: string);
var
  FieldItem: TFieldStackItem;
begin
//  TLogger.Inst.Log('                        Push Field ' + aFieldName);
  FieldItem:= TFieldStackItem.Create;
  FieldItem.FieldName:= aFieldName;
  Push(FieldItem);
end;

procedure TSerialiserStack.PushList;
begin
//  TLogger.Inst.Log('                        Push List');
  Push(TListStackItem.Create);
end;

procedure TSerialiserStack.PushType(aTypeName: string; aInst: TObject);
var
  TypeItem: TTypeStackItem;
begin
//  TLogger.Inst.Log('                        Push Type ' + aTypeName);
  TypeItem:= TTypeStackItem.Create;
  TypeItem.TypeName:= aTypeName;
  TypeItem.Instance:= aInst;
  Push(TypeItem);
end;

{ TJSONDeserialiser }

constructor TJSONDeserialiser.Create;
begin
  Create(TJsonSerialiserReverter.Create);
end;

constructor TJSONDeserialiser.Create(
  aReverter: TSerialiserReverter<TJsonObject>);
begin
  fReverter:= aReverter;
  inherited;
end;

{ TListStackItem }

constructor TListStackItem.Create;
begin
  KeyValues:= TStringList.Create;
end;

destructor TListStackItem.Destroy;
begin
  KeyValues.Free;
  inherited;
end;

end.
