unit XMLToBusObj;

interface

uses
  XMLIntf;

  procedure ObjToXML(Obj: TObject; node: IXMLNode);
  procedure XMLToObj(node: IXMLNode; Obj: TObject);

implementation

uses
  TypInfo, SysUtils, MySQLConst, Variants, StrUtils;

procedure ObjToXML(Obj: TObject; node: IXMLNode);
var
  count, x: integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
  propName: string;
  Val: Variant;
//  oleVal: OleVariant;

  procedure AddValue(aName: string; aValue: Variant);
  var
    subNode: IXMLNode;
  begin
    subNode := Node.ChildNodes.FindNode(aName);
    if not Assigned(subNode) then
      subNode:= Node.AddChild(aName);
    subNode.NodeValue := aValue;
  end;

begin
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);

    for x := 0 to Count -1 do begin

      PropInfo:= GetPropInfo(Obj,String(PropList[x].Name));
      if Assigned(PropInfo) then begin
        if (not Assigned(PropInfo.GetProc))  then
          { this is a write-only property so skip it }
          continue;
      end;

      propName:= Lowercase(String(PropList[x].Name));
      if SameText(propName,'mstimestamp') or SameText(propName,'globalref') or SameText(propName,'msupdatesitecode') then
        continue;

      case PropList[x].PropType^.Kind of
        tkEnumeration,
        tkInteger,
        tkInt64,
        tkChar,
        tkString,
        tkWChar,
        tkLString,
        tkUString,
        tkWString:
          begin
            val := GetStrProp(obj,propName);
            AddValue(propName, val);
          end;
        tkFloat :
          begin
            if (PropList[x].PropType^.Name = 'TDateTime') then  begin
              if GetFloatProp(obj,propName) = 0 then
                Val:= ''
              else
                Val:= FormatDateTime(MysqlDateTimeFormat,GetFloatProp(obj,propName));
            end
            else
              val := GetStrProp(obj,propName);
            AddValue(propName, val);
          end;
        tkSet,
        tkMethod,
        tkVariant,
        tkArray,
        tkRecord,
        tkInterface,
        tkDynArray,
//          tkClassRef, tkPointer, tkProcedure,
        tkUnknown:
          begin
            val := GetStrProp(obj,propName);
            if not VarIsNull(Val) then
              AddValue(propName, val);
          end;
        tkClass:
          begin
            { ignore }
          end;
      end;

//      case PropList[x].PropType^.Kind of
//        tkEnumeration:
//          begin
//            if DoProps then begin
//              val:= GetPropValue(obj, propName);
//              if (PropList[x].PropType^.Name = 'Boolean') then begin
//                item.B[propName]:= (not VarIsNull(val)) and (Val = 'True');
//              end
//              else begin
//                if (not VarIsNull(val)) then begin
//                  item.S[propName]:= val;
//                end
//                else begin
//                  item.S[propName]:= '';
//                end;
//              end;
//            end;
//          end;
//        tkInteger,
//        tkInt64 : if DoProps then item.I[propName]:= GetInt64Prop(obj,propName);
//        tkFloat :
//          begin
//            if DoProps then begin
//              if (PropList[x].PropType^.Name = 'TDateTime') then  begin
//                if GetFloatProp(obj,propName) = 0 then
//                  item.S[propName]:= ''
//                else
//                  item.S[propName]:= FormatDateTime(JsonDateTimeFormat,GetFloatProp(obj,propName));
//              end
//              else
//                item.F[propName]:= GetFloatProp(obj,propName);
//            end;
//          end;
//        tkChar,
//        tkString,
//        tkWChar,
//        tkLString,
//        tkUString,
//        tkWString : if DoProps then item.S[propName]:= GetStrProp(obj,propName);
//        tkSet,
//        tkMethod,
//        tkVariant,
//        tkArray,
//        tkRecord,
//        tkInterface,
//        tkDynArray,
////          tkClassRef, tkPointer, tkProcedure,
//        tkUnknown:
//          begin
//            if DoProps then begin
//              val:= GetPropValue(obj, propName);
//              if (not VarIsNull(val)) then begin
//                item.S[propName]:= val;
//              end;
//            end;
//          end;
//        tkClass:
//          begin
//            if DoClasses then begin
//              subObj:= GetObjectProp(obj, propName);
//              subJson:= JO;
//              if Assigned(subObj) then begin
//                BusObjectToJson(subObj,subJson,true);
//              end;
//              item.O[propName]:= subJson;
//            end;
//          end;
//      end;

    end;

  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

procedure XMLToObj(node: IXMLNode; Obj: TObject);
var
  x: integer;
  subNode: IXMLNode;
  PropInfo: PPropInfo;
  dt: TDateTime;
  s, saveDateFormat, saveTimeFormat: string;
begin
  for x := 0 to node.ChildNodes.Count - 1 do begin
    subNode := node.ChildNodes[x];
    PropInfo := GetPropInfo(obj, subNode.NodeName);
    if (not Assigned(PropInfo)) or (not Assigned(Propinfo.SetProc)) then
      exit;
    if subNode.HasChildNodes and (subNode.ChildNodes[0].NodeType = ntCData) then begin
      { node has CData sub node }
      SetPropValue(Obj, subNode.NodeName, subNode.ChildNodes[0].NodeValue)
    end
    else if (not VarIsNull(subNode.NodeValue)) then begin
      if (PropInfo.PropType^.Kind = tkFloat) and (PropInfo.PropType^.Name = 'TDateTime') then begin

        saveDateFormat := FormatSettings.ShortDateformat;
        saveTimeFormat := FormatSettings.LongTimeFormat;

        FormatSettings.LongTimeFormat := MysqlTimeFormat;
        FormatSettings.LongTimeFormat := replaceStr(FormatSettings.LongTimeFormat , ':' , FormatSettings.TimeSeparator);

        FormatSettings.ShortDateformat := MysqlDateFormat;
        FormatSettings.ShortDateformat := replaceStr(FormatSettings.ShortDateformat , '-' , FormatSettings.DateSeparator);

        try
          s := subNode.NodeValue;
          s := replaceStr(s , ':' , FormatSettings.TimeSeparator);
          s := replaceStr(s , '-' , FormatSettings.DateSeparator);
          dt := StrToDateTime(s);
          SetFloatProp(Obj, subNode.NodeName, dt);
        finally
          FormatSettings.ShortDateformat := saveDateFormat;
          FormatSettings.LongTimeFormat  := saveTimeFormat;
        end;
        exit;
      end
      else if (PropInfo.PropType^.Kind = tkEnumeration) and (PropInfo.PropType^.Name = 'Boolean') then begin
        SetEnumProp(Obj, subNode.NodeName, subNode.NodeValue);
        exit;
      end;
      { all others }
      SetPropValue(Obj, subNode.NodeName, subNode.NodeValue);
    end;
  end;
end;

end.
