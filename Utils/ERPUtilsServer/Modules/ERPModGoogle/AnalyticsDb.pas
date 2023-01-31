unit AnalyticsDb;

interface

uses
  ErpDbComponents, JsonObject;

procedure GetList(aClassName: string; List: TJsonArray; DbConn: TErpConnection; FilterSql: string = '');
procedure GetObject(aClassName: string; obj: TJsonObject; DbConn: TErpConnection; FilterSql: string = '');
procedure Save(obj: TJsonObject; DbConn: TErpConnection; ParentObj: TJsonObject = nil);
procedure InsertUpdate(obj: TJsonObject; DbConn: TErpConnection);
function GetDbPref(PrefType, PrefName: string; DbConn: TErpConnection): Variant;
function GetCompanyPref(PrefName: string; DbConn: TErpConnection): Variant;
Function lastDatechecked(DbConn: TErpConnection;ProfileId:String):TDateTime;
procedure MakeAdward(DbConn: TErpConnection;AccountID, CampaignId, AdwordID, Adword: String);
procedure MakeCampaign(DbConn: TErpConnection;AccountID, CampaignId, Campaign: String);


implementation

uses
  db, sysutils,dateutils;


procedure PopulateObject(obj: TJsonObject; Dataset: TDataset; DbConn: TErpConnection);
var
  x: integer;
  fld: TField;
  Props: TJsonObject;
begin
  Props:= obj.O['fields'];
  Props.Clear;
  for x := 0 to Dataset.FieldCount -1 do begin
    fld:= Dataset.Fields[x];
    case fld.DataType of
      ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
        begin
          if (fld.Size = 1) and (SameText(fld.AsString,'T') or SameText(fld.AsString,'F')) then
            Props.B[fld.FieldName]:= fld.AsBoolean
          else if Pos('Array_',fld.AsString) = 1 then begin
            if not Dataset.IsEmpty then
              GetList(Copy(fld.AsString,7,Length(fld.AsString)),Props.A[fld.FieldName],DbConn,'where Ref_' + obj.S['type'] + ' = ' + Dataset.FieldByName('UId').AsString);
          end
          else
            Props.S[fld.FieldName]:= fld.AsString;
        end;
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftLongWord, ftShortint:
        begin
          Props.I[fld.FieldName]:= fld.AsInteger;
        end;
      ftFloat, ftCurrency, ftExtended, ftSingle:
        begin
          Props.F[fld.FieldName]:= fld.AsFloat;
        end;
      ftDate, ftTime, ftDateTime:
        begin
          Props.DT[fld.FieldName]:= fld.AsDateTime;
        end;
      ftBoolean:
        begin
          Props.B[fld.FieldName]:= fld.AsBoolean;
        end;
      ftUnknown, ftBCD,  ftBytes, ftVarBytes, ftBlob,
      ftGraphic, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor,
      ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
      ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp,
      ftFMTBcd, ftOraTimeStamp, ftOraInterval, ftByte,ftConnection,
      ftParams, ftStream, ftTimeStampOffset, ftObject:;
    end;

  end;
end;
Function lastDatechecked(DbConn: TErpConnection;ProfileId:String):TDateTime;
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select Date from tbltgaChecks where ProfileID = ' +quotedstr(ProfileID));
    qry.Open;
    result := qry.fieldByname('Date').AsDateTime;
    if result= 0 then result := incday(date,-7);
  finally
    qry.Free;
  end;

end;

procedure GetList(aClassName: string; List: TJsonArray; DbConn: TErpConnection; FilterSql: string = '');
var
  qry: TErpQuery;
  obj: TJsonObject;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select * from tbl' + aClassName);
    if FilterSql <> '' then
      qry.SQL.Add(FilterSQL);
    List.Clear;
    qry.Open;
    while not qry.Eof do begin
      obj:= JO;
      obj.S['type']:= aClassName;
      List.Add(obj);
      PopulateObject(obj,qry,DbConn);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure GetObject(aClassName: string; obj: TJsonObject; DbConn: TErpConnection; FilterSql: string = '');
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select * from tbl' + aClassName);
    if FilterSql <> '' then
      qry.SQL.Add(FilterSQL);
    try
      qry.Open;
    except
      on e: exception do begin
        raise Exception.Create('GetObject Error: ' + e.Message + ' SQL: ' + qry.SQL.Text);
      end;
    end;
    obj.S['type']:= aClassName;
    PopulateObject(obj,qry,DbConn);
  finally
    qry.Free;
  end;
end;

procedure Save(obj: TJsonObject; DbConn: TErpConnection; ParentObj: TJsonObject = nil);
var
  qry: TErpQuery;
  x, i: integer;
  fld: TField;
  Props: TJsonObject;
  pair: TJsonValuePair;
  List: TJsonArray;
  ArrayValue: TJSONValue;
begin
  Props:= obj.O['fields'];
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select * from tbl' + obj.S['type'] + ' where Uid = ' + IntToStr(Props.I['UId']));
    qry.Open;
    if qry.IsEmpty then
      qry.Insert
    else
      qry.Edit;
    try
      for x := 0 to Props.Count -1 do begin
        pair:= Props.Items[x];
        if SameText(pair.Name,'UId') then
          continue;
        case pair.ValueType of
          valNone:;
          valString:
            begin
              fld:= qry.FieldByName(pair.Name);
              if fld.DataType in [ftDate, ftTime, ftDateTime] then
                fld.AsDateTime:= pair.Value.AsDateTime
              else
                fld.AsString:= pair.Value.AsString;
            end;
          valNumber:
            begin
              fld:= qry.FieldByName(pair.Name);
              if fld.DataType in [ftFloat, ftCurrency, ftExtended, ftSingle] then
                fld.AsFloat:= pair.Value.AsFloat
              else
                fld.AsInteger:= pair.Value.AsInteger;
            end;
          valObject: ;
          valArray: { do nothing this pass };
          valNull: qry.FieldByName(pair.Name).Clear;
          valBoolean: qry.FieldByName(pair.Name).AsBoolean:= pair.Value.AsBoolean;
        end;
      end;
      { check for ref fields }
      if Assigned(ParentObj) then begin
        for x := 0 to qry.FieldCount -1 do begin
          fld:= qry.Fields[x];
          if Pos('Ref_',fld.FieldName) = 1 then begin
            if SameText(Copy(fld.FieldName,5,Length(fld.FieldName)),ParentObj.S['type']) then begin
               fld.AsInteger:= ParentObj.O['fields'].I['UId'];
            end;
          end;
        end;
      end;
    finally
      qry.Post; { so we get an id }
      Props.I['UId']:= qry.FieldByName('UId').AsInteger;
    end;
    { now do arrays }
    for x := 0 to Props.Count -1 do begin
      pair:= Props.Items[x];
      case pair.ValueType of
        valObject: ;
        valArray:
          begin
            List:= TJSONArray(pair.Value);
            for i := 0 to List.Count-1 do begin
              ArrayValue:= List.Items[i];
              if ArrayValue.ValueType = valObject then begin
                Save(ArrayValue.AsObject,DbConn,obj);
              end;
            end;
          end;
      end;
    end;

  finally
    qry.Free;
  end;
end;

procedure InsertUpdate(obj: TJsonObject; DbConn: TErpConnection);
var
  cmd: TErpCommand;
  fields,values,update: string;
  x: integer;
  pair: TJsonValuePair;
begin
  cmd:= TErpCommand.Create(nil);
  try
    cmd.Connection:= DbConn;
    cmd.SQL.Add('insert into tbl' + obj.S['type']);
    fields:= '';
    values:= '';
    update:= '';
    for x := 0 to obj.O['fields'].Count -1 do begin
      pair:= obj.O['fields'].Items[x];
      if not SameText(pair.Name,'UId') then begin
        if fields <> '' then begin
          fields:= fields + ',';
          values:= values + ',';
          update:= update + ',';
        end;
        fields:= fields + pair.Name;
        case pair.ValueType of
          valNone:
            begin
              values:= values + 'NULL';
              update:= update + pair.Name + ' = NULL';
            end;
          valString:
            begin
              values:= values + '"' + pair.Value.AsString + '"';
              update:= update + pair.Name + ' = ' + '"' + pair.Value.AsString + '"';
            end;
          valNumber:
            begin
              values:= values + pair.Value.AsString;
              update:= update + pair.Name + ' = ' + pair.Value.AsString;
            end;
          valObject:
            begin
              values:= values + 'NULL';
              update:= update + pair.Name + ' = NULL';
            end;
          valArray:
            begin
              values:= values + 'NULL';
              update:= update + pair.Name + ' = NULL';
            end;
          valNull:
            begin
              values:= values + 'NULL';
              update:= update + pair.Name + ' = NULL';
            end;
          valBoolean:
            begin
              if pair.Value.AsBoolean then begin
                values:= values + '"T"';
                update:= update + pair.Name + ' = ' + '"T"';
              end
              else begin
                values:= values + '"F"';
                update:= update + pair.Name + ' = ' + '"F"';
              end;
            end;
        end;
      end;
    end;
    cmd.SQL.Add('(' + fields + ')');
    cmd.SQL.Add('values (' + values + ')');
    cmd.SQL.Add('on duplicate key update ' + update);
//    cmd.SQL.SaveToFile('c:\temp\temp.sql');
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

function GetDbPref(PrefType, PrefName: string; DbConn: TErpConnection): Variant;
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select FieldValue from tbldbpreferences');
    qry.SQL.Add('where PrefType = "' + PrefType + '"');
    qry.SQL.Add('and Name = "' + PrefName + '"');
    qry.Open;
    result:= qry.FieldByName('FieldValue').AsVariant;
  finally
    qry.Free;
  end;
end;

function GetCompanyPref(PrefName: string; DbConn: TErpConnection): Variant;
begin
  result:= GetDbPref('ptCompany',PrefName,DbConn);
end;

procedure MakeAdward(DbConn: TErpConnection;AccountID, CampaignId, AdwordID, Adword: String);
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select * from tbltgacampaignadwards');
    qry.SQL.Add('where CampaignID = "' + CampaignId + '"');
    qry.SQL.Add('and  AccountID = "' + AccountID + '"');
    qry.SQL.Add('and  AdwordID = "' + Adword + '"');
    qry.SQL.Add('and Adword = "' + Adword + '"');
    qry.Open;
    if qry.recordcount =0 then begin
      qry.Append;
      qry.Fieldbyname('CampaignID').asString := CampaignId;
      qry.Fieldbyname('AccountID').asString := AccountID ;
      qry.Fieldbyname('AdwordID').asString := Adword ;
      qry.Fieldbyname('Adword').asString := Adword ;
      qry.Post;
    end;
  finally
    qry.Free;
  end;
end;
procedure MakeCampaign(DbConn: TErpConnection;AccountID, CampaignId, Campaign: String);
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= DbConn;
    qry.SQL.Add('select * from tbltgacampaigns');
    qry.SQL.Add('where CampaignID = "' + CampaignId + '"');
    qry.SQL.Add('and  AccountID = "' + AccountID + '"');
    qry.SQL.Add('and Campaign = "' + Campaign + '"');
    qry.Open;
    if qry.recordcount =0 then begin
      qry.Append;
      qry.Fieldbyname('CampaignID').asString := CampaignId;
      qry.Fieldbyname('AccountID').asString := AccountID ;
      qry.Fieldbyname('Campaign').asString := Campaign ;
      qry.Post;
    end;
  finally
    qry.Free;
  end;
end;

end.
