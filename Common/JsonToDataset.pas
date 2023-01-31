unit JsonToDataset;

interface

uses
  DB, JsonObject;

  procedure DatasetToJson(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = '');
  procedure JsonToDataset(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = '');

implementation

uses
  SysUtils;

procedure DatasetToJson(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = '');
var
  x: integer;
  field: TField;
begin
  for x := 0 to Dataset.FieldCount -1 do begin
    field := Dataset.Fields[x];
    if Pos(Lowercase(field.FieldName),Lowercase(ExcludeFields)) > 0 then
      continue;
    case field.DataType of
      ftUnknown: ;
      ftString:
        begin
          if (field.Size = 1) and ((field.AsString = 'T') or (field.AsString = 'F')) then
            Json.B[field.FieldName]:= field.AsBoolean
          else
            Json.S[field.FieldName] := field.AsString;
        end;
      ftSmallint: Json.I[field.FieldName] := field.AsInteger;
      ftInteger: Json.I[field.FieldName] := field.AsInteger;
      ftWord: Json.I[field.FieldName] := field.AsInteger;
      ftBoolean: Json.B[field.FieldName] := field.AsBoolean;
      ftFloat: Json.F[field.FieldName] := field.AsFloat;
      ftCurrency: Json.F[field.FieldName] := field.AsFloat;
      ftBCD: ;
      ftDate: Json.DT[field.FieldName] := field.AsDateTime;
      ftTime: Json.DT[field.FieldName] := field.AsDateTime;
      ftDateTime: Json.DT[field.FieldName] := field.AsDateTime;
      ftBytes: ;
      ftVarBytes: ;
      ftAutoInc: Json.I[field.FieldName] := field.AsInteger;
      ftBlob: ;
      ftMemo: Json.S[field.FieldName] := field.AsString;
      ftGraphic: ;
      ftFmtMemo: ;
      ftParadoxOle: ;
      ftDBaseOle: ;
      ftTypedBinary: ;
      ftCursor: ;
      ftFixedChar: Json.S[field.FieldName] := field.AsString;
      ftWideString: Json.S[field.FieldName] := field.AsString;
      ftLargeint: Json.I[field.FieldName] := field.AsInteger;
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
      ftTimeStamp: Json.DT[field.FieldName] := field.AsDateTime;
      ftFMTBcd: ;
      ftFixedWideChar: ;
      ftWideMemo: Json.S[field.FieldName] := field.AsString;
      ftOraTimeStamp: ;
      ftOraInterval: ;
      ftLongWord: Json.I[field.FieldName] := field.AsInteger;
      ftShortint: Json.I[field.FieldName] := field.AsInteger;
      ftByte: Json.I[field.FieldName] := field.AsInteger;
      ftExtended: Json.F[field.FieldName] := field.AsFloat;
      ftConnection: ;
      ftParams: ;
      ftStream: ;
      ftTimeStampOffset: ;
      ftObject: ;
      ftSingle: Json.F[field.FieldName] := field.AsFloat;
    end;
  end;
end;

procedure JsonToDataset(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = '');
begin

end;

end.
