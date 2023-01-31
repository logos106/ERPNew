unit ObjectStorer;

interface

uses
  DBGen;

type
  TObjStore = class(TObject)
    class procedure SaveObject(const obj: TObject; const aTable: string; Connection: TDbConnection; IdFieldName: string = 'ID'); overload;
    class procedure SaveObject(const obj: TObject; const aTable, aDatabase, aServer: string; IdFieldName: string = 'ID'); overload;
    class procedure LoadObject(obj: TObject; const aTable, aDatabase, aServer: string; const aID: integer; IdFieldName: string = 'ID'); overload;
    class procedure LoadObject(obj: TObject; const aTable: string; connection: TDbConnection; const aID: integer; IdFieldName: string = 'ID'); overload;
    class function ERPSiteCode(const aDatabase, aServer: string): string; overload;
    class function ERPSiteCode(connection: TDbConnection): string; overload;
  end;

function GetPropByName(obj: TObject; aPropName: string): Variant;

implementation

uses
  {$IfDef VER220}
  {$Else}
  System.Rtti,
  {$EndIf}

  TypInfo, Variants, SysUtils, DB;


function GetPropByName(obj: TObject; aPropName: string): Variant;
var
  PropInfo: PPropInfo;
begin
  result := Null;
  PropInfo := GetPropInfo(obj,aPropName);
  if Assigned(PropInfo) then begin
    result := GetPropValue(obj, aPropName);
  end;
//  if IsPublishedProp(obj,aPropName) then
//    result := GetPropValue(obj, aPropName);
end;

procedure PropToField(obj: TObject; PropName: string; Field:TField); overload;
var
  PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(obj.ClassInfo,PropName);
  if Assigned(PropInfo) then begin
    if VarIsNull(GetPropValue(obj,PropInfo)) then
      Field.Clear
    else
      Field.Value := GetPropValue(obj,PropInfo);
  end;
end;

procedure PropToField(obj: TObject; Field: TField); overload;
begin
  PropToField(obj,Field.FieldName,Field);
end;

procedure SetPropByName(obj: TObject; aPropName: string; Value: Variant);
begin
  if IsPublishedProp(obj,aPropName) then
    SetPropValue(obj,aPropName,Value);
end;


{ TObjStore }

class function TObjStore.ERPSiteCode(const aDatabase, aServer: string): string;
var
  conn: TDbConnection;
begin
  conn := TDbGen.NewConnection(aDatabase,aServer);
  try
    conn.Connect;
    result := ErpSiteCode(conn);
  finally
    conn.Free;
  end;
end;

class function TObjStore.ERPSiteCode(connection: TDbConnection): string;
var
  qry: TDbQuery;
begin
  qry := TDbQuery.Create(nil);
  try
    qry.DBConnection := Connection;
    qry.SQL.Text :=
      'select SiteCode from tblclass where Active = "T" and ClassName = ' +
      '(select DefaultClass from tblcolumnheadings limit 1)';
    qry.Open;
    result := qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;

class procedure TObjStore.LoadObject(obj: TObject; const aTable, aDatabase,
  aServer: string; const aID: integer; IdFieldName: string);
var
  conn: TDbConnection;
begin
  conn := TDbGen.NewConnection(aDatabase,aServer);
  try
    conn.Connect;
    LoadObject(obj,aTable,conn,aID,IdFieldName);
  finally
    conn.Free;
  end;
end;

class procedure TObjStore.LoadObject(obj: TObject; const aTable: string;
  connection: TDbConnection; const aID: integer; IdFieldName: string);
var
  qry: TDbQuery;
  x: integer;
  field: TField;
begin
  qry := TDbQuery.Create(nil);
  try
    qry.DBConnection := Connection;

    qry.SQL.Text := 'select * from ' + aTable + ' where ' + IdFieldName + ' = ' + IntToStr(aID);
    qry.Open;
    for x := 0 to qry.FieldCount -1 do begin
      field := qry.Fields[x];
      if field.IsNull then begin
        case field.DataType of
          ftUnknown: ;
          ftString: SetPropByName(obj,field.FieldName,'');
          ftSmallint: SetPropByName(obj,field.FieldName,0);
          ftInteger: SetPropByName(obj,field.FieldName,0);
          ftWord: SetPropByName(obj,field.FieldName,0);
          ftBoolean: SetPropByName(obj,field.FieldName,false);
          ftFloat: SetPropByName(obj,field.FieldName,0);
          ftCurrency: SetPropByName(obj,field.FieldName,0);
          ftBCD: SetPropByName(obj,field.FieldName,0);
          ftDate: SetPropByName(obj,field.FieldName,0);
          ftTime: SetPropByName(obj,field.FieldName,0);
          ftDateTime: SetPropByName(obj,field.FieldName,0);
          ftBytes: ;
          ftVarBytes: ;
          ftAutoInc: ;
          ftBlob: ;
          ftMemo: SetPropByName(obj,field.FieldName,'');
          ftGraphic: ;
          ftFmtMemo: SetPropByName(obj,field.FieldName,'');
          ftParadoxOle: ;
          ftDBaseOle: ;
          ftTypedBinary: ;
          ftCursor: ;
          ftFixedChar: SetPropByName(obj,field.FieldName,'');
          ftWideString: SetPropByName(obj,field.FieldName,'');
          ftLargeint: SetPropByName(obj,field.FieldName,0);
          ftADT: ;
          ftArray: ;
          ftReference: ;
          ftDataSet: ;
          ftOraBlob: ;
          ftOraClob: ;
          ftVariant: ;
          ftInterface: ;
          ftIDispatch: ;
          ftGuid: ;
          ftTimeStamp: SetPropByName(obj,field.FieldName,0);
          ftFMTBcd: ;
          ftFixedWideChar: SetPropByName(obj,field.FieldName,'');
          ftWideMemo: ;
          ftOraTimeStamp: ;
          ftOraInterval: ;
          ftLongWord: SetPropByName(obj,field.FieldName,0);
          ftShortint: SetPropByName(obj,field.FieldName,0);
          ftByte: SetPropByName(obj,field.FieldName,0);
          ftExtended: SetPropByName(obj,field.FieldName,0);
          ftConnection: ;
          ftParams: ;
          ftStream: ;
          ftTimeStampOffset: SetPropByName(obj,field.FieldName,0);
          ftObject: ;
          ftSingle: SetPropByName(obj,field.FieldName,0);
        end;
      end
      else
        SetPropByName(obj,field.FieldName,field.Value);
    end;

  finally
    qry.Free;
  end;
end;

class procedure TObjStore.SaveObject(const obj: TObject;
  const aTable, aDatabase, aServer: string; IdFieldName: string);
var
  conn: TDbConnection;
begin
  conn := TDbGen.NewConnection(aDatabase,aServer);
  try
    conn.Connect;
    SaveObject(obj,aTable,conn,IdFieldName);
  finally
    conn.Free;
  end;
end;

class procedure TObjStore.SaveObject(const obj: TObject; const aTable: string;
  Connection: TDbConnection; IdFieldName: string);
var
  qry: TDbQuery;
  x: integer;
  field: TField;
  IsNew: boolean;
  SiteCode: string;
//  {$IfDef VER220}
//  {$Else}
//  ctx: TRttiContext;
//  objType: TRttiType;
//  Prop: TRTTIProperty;
//  Val: TValue;
//  {$EndIf}
begin
  qry := TDbQuery.Create(nil);
  try
    qry.DBConnection := Connection;
    IsNew := false;
    qry.SQL.Add('select * from ' + aTable);
//    if GetPropByName(obj,IdFieldName) <> Null then
//      qry.SQL.Add('where ' + IdFieldName + ' = ' + IntToStr(GetPropByName(obj,IdFieldName)))
//    else
//      qry.SQL.Add('where ' + IdFieldName + ' = 0');
    qry.SQL.Add('where ' + IdFieldName + ' = ' + IntToStr(GetOrdProp(obj,IdFieldName)));
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      IsNew := true;
    end
    else
      qry.Edit;

//    {$IfDef VER220}
    for x := 0 to qry.FieldCount -1 do begin
      field := qry.Fields[x];
      if SameText(field.FieldName, 'msTimeStamp') then continue
      else if SameText(field.FieldName, IdFieldName) then continue;

      //field.Value := GetPropByName(obj,field.FieldName);
      PropToField(obj,Field);
    end;
    (*
    {$Else}
    ctx := TRttiContext.Create;
    try
      objType := ctx.GetType(Obj.ClassInfo);
      for x := 0 to qry.FieldCount -1 do begin
        field := qry.Fields[x];
        if SameText(field.FieldName, 'msTimeStamp') then continue
        else if SameText(field.FieldName, IdFieldName) then continue;
        Prop := objType.GetProperty(Field.FieldName);
        if Assigned(Prop) then begin
          Val := Prop.GetValue(obj);
          if Val.IsEmpty then
            Field.Clear
          else
            Field.Value := Val.AsVariant;
        end;
      end;

    finally
      ctx.Free;
    end;
    {$EndIf}
    *)
    qry.Post;

    if IsNew then begin
      SetPropValue(obj,IdFieldName,qry.FieldByName(IdFieldName).AsVariant);
      if IsPublishedProp(obj,'GlobalRef') or IsPublishedProp(obj,'msUpdateSiteCode') then begin
        SiteCode := ERPSiteCode(Connection);
        qry.Edit;
        if IsPublishedProp(obj,'GlobalRef') then begin
          qry.FieldByName('GlobalRef').AsString := SiteCode + IntToStr(GetPropValue(obj, IdFieldName));
          SetPropValue(obj,'GlobalRef',qry.FieldByName('GlobalRef').AsString);
        end;
        if IsPublishedProp(obj,'msUpdateSiteCode') then begin
          qry.FieldByName('msUpdateSiteCode').AsString := SiteCode;
          SetPropValue(obj,'msUpdateSiteCode',qry.FieldByName('msUpdateSiteCode').AsString);
        end;
        qry.Post;
      end;
    end;
    if IsPublishedProp(obj,'msTimeStamp') then
      SetPropValue(obj,'msTimeStamp',qry.FieldByName('msTimeStamp').AsDateTime);

  finally
    qry.Free;
  end;
end;

end.
