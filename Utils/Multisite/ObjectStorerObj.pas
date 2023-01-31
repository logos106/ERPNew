unit ObjectStorerObj;

interface

uses
  classes, JSONObject;

type

  TObjectStorer = class
  private
    procedure SaveToStruct(obj: TObject; struct: TJSONObject);
    procedure LoadFromStruct(obj: TObject; struct: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(obj: TObject; FileName: string);
    procedure SaveToFile(obj: TObject; FileName: string);
    procedure LoadFromString(obj: TObject; str: string);
    procedure SaveToString(obj: TObject;var str: string);
  end;

implementation

uses
  sysutils, TypInfo;

{ TObjectStorer }

constructor TObjectStorer.Create;
begin

end;

destructor TObjectStorer.Destroy;
begin

  inherited;
end;

procedure TObjectStorer.LoadFromFile(obj: TObject; FileName: string);
var
  struct: TJSONObject;
begin
  if FileExists(FileName) then begin
    struct:= TJSONObject.Create;
    try
      struct.LoadFromFile(FileName);
      LoadFromStruct(obj,struct);
    finally
      struct.Free;
    end;
  end;
end;

procedure TObjectStorer.SaveToFile(obj: TObject; FileName: string);
var
  struct: TJSONObject;
begin
  struct:= TJSONObject.Create;
  try
    SaveToStruct(obj,struct);
    struct.SaveToFile(FileName);
  finally
    struct.Free;
  end;
end;

procedure TObjectStorer.LoadFromString(obj: TObject; str: string);
var
  struct: TJSONObject;
begin
  struct:= TJSONObject.Create;
  try
    struct.AsString:= str;
    LoadFromStruct(obj,struct);
  finally
    struct.Free;
  end;
end;

procedure TObjectStorer.SaveToString(obj: TObject;var str: string);
var
  struct: TJSONObject;
begin
  struct:= TJSONObject.Create;
  try
    SaveToStruct(obj,struct);
    str:= struct.AsString;
  finally
    struct.Free;
  end;
end;

procedure TObjectStorer.SaveToStruct(obj: TObject; struct: TJSONObject);
var
  count, x, i: integer;
  PropList: PPropList;
  Val: Variant;
  SubObj: TObject;
  ListStruct, SubStruct: TJSONObject;
begin
  Count := GetPropList(Obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(Obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      if (not Assigned( PropList[x].SetProc)) and (PropList[x].PropType^.Kind <> tkClass) then continue; { read only property }
      val:= GetPropValue(obj, PropList[x].Name);
      if (PropList[x].PropType^ = TypeInfo(TDateTime)) then
        struct.FloatByName[PropList[x].Name]:= val
      else begin
        case PropList[x].PropType^.Kind of
          tkEnumeration:
            begin
              if Val = 'True' then
                struct.BooleanByName[PropList[x].Name]:= true
              else if Val = 'False' then
                struct.BooleanByName[PropList[x].Name]:= false
              else
                struct.StringByName[PropList[x].Name]:= Val;
            end;
          tkString,
          tkChar,
          tkWChar,
          tkLString,
          tkWString: struct.StringByName[PropList[x].Name]:= Val;
          tkFloat: struct.FloatByName[PropList[x].Name]:= Val;
          tkInteger,
          tkInt64: struct.IntegerByName[PropList[x].Name]:= Val;
          tkClass:
            begin
              SubObj:= GetObjectProp(Obj, PropList[x].Name);
              if Assigned(SubObj) then begin
                if SubObj is TCollection then begin
                  ListStruct:= struct.ObjectByName[PropList[x].Name];
                  for i:= 0 to TCollection(SubObj).Count -1 do begin
                    SubStruct:= ListStruct.ObjectByName[IntToStr(i)];
                    SaveToStruct(TCollection(SubObj).Items[i],SubStruct);
                  end;
                end
                else begin
                  SubStruct:= struct.ObjectByName[PropList[x].Name];
                  SaveToStruct(SubObj,SubStruct);
                end
              end;
            end;
          tkSet,
          tkUnknown,
          tkMethod,
          tkVariant,
          tkArray,
          tkRecord,
          tkInterface,
          tkDynArray: ;
        end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

procedure TObjectStorer.LoadFromStruct(obj: TObject; struct: TJSONObject);
var
  count, x, i: integer;
  PropList: PPropList;
  Val: Variant;
  SubObj, ListObj: TObject;
  ListStruct, SubStruct: TJSONObject;
begin
  Count := GetPropList(Obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(Obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      if (not Assigned( PropList[x].SetProc)) and (PropList[x].PropType^.Kind <> tkClass) then continue; { read only property }
      if (PropList[x].PropType^ = TypeInfo(TDateTime)) then
        SetFloatProp(Obj, PropList[x].Name, struct.FloatByName[PropList[x].Name])
      else begin
        case PropList[x].PropType^.Kind of
          tkEnumeration:
            begin
              Val:= GetPropValue(obj, PropList[x].Name);
              if (Val = 'True') or (Val = 'False') then begin
                if struct.BooleanByName[PropList[x].Name] then
                  SetEnumProp(Obj,PropList[x].Name,'True')
                else
                  SetEnumProp(Obj,PropList[x].Name,'False');
              end
              else
                SetEnumProp(Obj,PropList[x].Name, struct.StringByName[PropList[x].Name]);
            end;
          tkString,
          tkChar,
          tkWChar,
          tkLString,
          tkWString: SetStrProp(Obj,PropList[x].Name, struct.StringByName[PropList[x].Name]);
          tkFloat: SetFloatProp(Obj,PropList[x].Name, struct.FloatByName[PropList[x].Name]);
          tkInteger,
          tkInt64: SetOrdProp(Obj,PropList[x].Name, struct.IntegerByName[PropList[x].Name]);
          tkClass:
            begin
              SubObj:= GetObjectProp(Obj, PropList[x].Name);
              if Assigned(SubObj) then begin
                if SubObj is TCollection then begin
                  TCollection(subObj).Clear;
                  ListStruct:= struct.ObjectByName[PropList[x].Name];
                  for i:= 0 to ListStruct.Count -1 do begin
                    if ListStruct.Exists(IntToStr(i)) then begin
                      SubStruct:= ListStruct.ObjectByName[IntToStr(i)];
                      ListObj:= TCollection(subObj).Add;
                      LoadFromStruct(ListObj, SubStruct);
                    end;
                  end;
                end
                else begin
                  SubStruct:= struct.ObjectByName[PropList[x].Name];
                  LoadFromStruct(SubObj,SubStruct);
                end
              end;
            end;
          tkSet,
          tkUnknown,
          tkMethod,
          tkVariant,
          tkArray,
          tkRecord,
          tkInterface,
          tkDynArray: ;
        end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

end.
