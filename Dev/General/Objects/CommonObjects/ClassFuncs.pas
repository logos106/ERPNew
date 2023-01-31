unit ClassFuncs;

interface

uses
  TypInfo, Db, Variants;

procedure SetObjectPropertiesFromDataSet(Obj: TObject; DS: TDataSet);
procedure ClearPropertyValues(Obj: TObject);


implementation

procedure SetObjectPropertiesFromDataSet(Obj: TObject; DS: TDataSet);
var
  count, x: integer;
  PropList: PPropList;
  field: TField;

  procedure SetObjectsProperty;
  begin
    if Field.IsNull then begin
      { clear the objects property }
      case PropList[x].PropType^.Kind of
        tkInteger, tkFloat, tkInt64:
          SetPropValue(Obj,String(PropList[x].Name), 0);
        tkChar, tkString, tkWChar, tkLString, tkWString:
          SetPropValue(Obj, String(PropList[x].Name), '');
        tkEnumeration:
          SetPropValue(Obj, String(PropList[x].Name), 0);
        tkVariant:
          SetPropValue(Obj, String(PropList[x].Name), Null);
//        tkUnknown, tkSet, tkClass, tkMethod,
//        tkArray, tkRecord, tkInterface, tkDynArray: { these are not set here };
      end;
    end
    else begin
      SetPropValue(Obj, String(PropList[x].Name), Field.AsVariant);
    end;
  end;

begin
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      try
      field:= Ds.FindField(String(PropList[x].Name));
      if Assigned(field) then begin
        if (field is TDateTimeField) or (field is TDateField) or (field is TTimeField) then
          SetFloatProp(Obj, String(PropList[x].Name), field.AsDateTime)
        else if (field is TWideStringField) then begin
          if PropList[x].PropType^.Kind = tkEnumeration then begin
            if (field.AsString = 'T') then SetEnumProp(Obj,String(PropList[x].Name),'True')
            else if (field.AsString = 'F') then SetEnumProp(Obj,String(PropList[x].Name),'False')
            else if (field.AsString <> '') then SetObjectsProperty;
          end
          else
            SetObjectsProperty;
        end
        else
          SetObjectsProperty;
      end;
      except
          // kill the exception
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

procedure ClearPropertyValues(Obj: TObject);
var
  count, x: integer;
  PropList: PPropList;
begin
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      if (PropList[x].SetProc <> nil) then begin
        case PropList[x].PropType^.Kind of
          tkInteger, tkFloat, tkInt64:  SetPropValue(Obj, String(PropList[x].Name), 0);
          tkChar, tkString, tkWChar, tkLString, tkWString:  SetPropValue(Obj, String(PropList[x].Name), '');
          tkEnumeration: SetPropValue(Obj, String(PropList[x].Name), 0);
          tkVariant:  SetPropValue(Obj, String(PropList[x].Name), Null);
//          tkUnknown, tkSet, tkClass, tkMethod,
//          tkArray, tkRecord, tkInterface, tkDynArray: { these are not set here };
        end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;


end.
