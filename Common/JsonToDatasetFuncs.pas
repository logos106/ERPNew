unit JsonToDatasetFuncs;

interface

uses
  DB, JsonObject, Classes;

  procedure DatasetToJson(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = ''); overload;
  //procedure DatasetToJson(Dataset: TDataset; Writer: TStreamWriter; ExcludeFields: string = ''; logproc:TGeneralStringProc=nil); overload;
  procedure DatasetToJson(Dataset: TDataset; Writer: TStreamWriter; ExcludeFields: string = ''); overload;
  procedure JsonToDataset(Json: TJsonObject; Dataset: TDataset; ExcludeProps: string = ''; FieldMustExist: boolean = true);
  function FieldToJsonValue(Field: TField): TJsonValue;

implementation

uses
  SysUtils;

procedure DatasetToJson(Dataset: TDataset; Json: TJsonObject; ExcludeFields: string = '');
var
  x: integer;
  field: TField;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.CommaText := ExcludeFields;
    for x := 0 to Dataset.FieldCount -1 do begin
      field := Dataset.Fields[x];
      if sl.IndexOf(field.FieldName) >= 0 then
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
        ftWideString:
          begin
            if (field.Size = 1) and ((field.AsString = 'T') or (field.AsString = 'F')) then
              Json.B[field.FieldName]:= field.AsBoolean
            else
              Json.S[field.FieldName] := field.AsString;
          end;
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
  finally
    sl.Free;
  end;
end;

//procedure DatasetToJson(Dataset: TDataset; Writer: TStreamWriter; ExcludeFields: string = ''; logproc:TGeneralStringProc=nil);
procedure DatasetToJson(Dataset: TDataset; Writer: TStreamWriter; ExcludeFields: string = '');
var
  x: integer;
  field: TField;
  sl: TStringList;
  FirstValue: boolean;

  procedure StartNewValue;
  begin
    if FirstValue then
      FirstValue := false
    else begin
      Writer.Write(',');
      Writer.WriteLine;
    end;
  end;

begin
(*  if assigned(logproc) then begin
      logproc('CurrencyString:' +formatsettings.CurrencyString);
      logproc('CurrencyFormat:' +inttostr(formatsettings.CurrencyFormat));
      logproc('CurrencyDecimals:' + inttostr(formatsettings.CurrencyDecimals));
      logproc('dateSeperator:' +formatsettings.dateSeparator);
      logproc('TimeSeperator:' +formatsettings.TimeSeparator);
      logproc('ListSeperator:' +formatsettings.ListSeparator);
      logproc('ShortDateFormat:' + formatsettings.ShortDateFormat);
      logproc('LongDateformat:' +formatsettings.LongDateformat);
      logproc('TimeAMString:' + formatsettings.TimeAMString);
      logproc('timePMString:' +formatsettings.timePMString);
      logproc('shortTimeformat:' + formatsettings.shortTimeformat);
      logproc('Longtimeformat:' + formatsettings.Longtimeformat);
      if length(formatsettings.Shortmonthnames) >0 then logproc('Shortmonthnames:'+formatsettings.Shortmonthnames[low(formatsettings.Shortmonthnames)]);
      if length(formatsettings.longMonthnames)  >0 then logproc('longMonthnames:' +formatsettings.longMonthnames[low(formatsettings.longMonthnames)]);
      if length(formatsettings.ShortdayNames)   >0 then logproc('ShortdayNames:'  +formatsettings.ShortdayNames[low(formatsettings.ShortdayNames)]);
      if length(formatsettings.LongDayNames)    >0 then logproc('LongDayNames:'   +formatsettings.LongDayNames[low(formatsettings.LongDayNames)]);
      logproc('ThousandSeparator:' + formatsettings.ThousandSeparator);
      logproc('DecimalSeparator:' + formatsettings.DecimalSeparator);
      logproc('1345678.9' + FloatToString(1345678.9));
      logproc('134567.89' + FloatToString(134567.89));
      logproc('13456.789' + FloatToString(13456.789));
      logproc('1345.6789' + FloatToString(1345.6789));
      logproc('134.56789' + FloatToString(134.56789));
      logproc('13.456789' + FloatToString(13.456789));
      logproc('1.3456789' + FloatToString(1.3456789));
      logproc('0.13456789' + FloatToString(0.13456789));
      logproc('============================================================');
  end;*)

  sl := TStringList.Create;
  try
    sl.CommaText := ExcludeFields;
    FirstValue := true;
//    Writer.WriteLine;
    Writer.Write('{');
    Writer.WriteLine;
    for x := 0 to Dataset.FieldCount -1 do begin
      try
          field := Dataset.Fields[x];
          if sl.IndexOf(field.FieldName) >= 0 then
            continue;
          case field.DataType of
            ftUnknown: ;
            ftString:
              begin
                StartNewValue;
                if (field.Size = 1) and ((field.AsString = 'T') or (field.AsString = 'F')) then begin
                  if field.AsBoolean then
                    Writer.Write('"' + field.FieldName + '":true')
                  else
                    Writer.Write('"' + field.FieldName + '":false');
                end
                else
                  Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
            ftSmallint,
            ftInteger,
            ftWord:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":' + IntToStr(field.AsInteger));
              end;
            ftBoolean:
              begin
                StartNewValue;
                if field.AsBoolean then
                  Writer.Write('"' + field.FieldName + '":true')
                else
                  Writer.Write('"' + field.FieldName + '":false');
              end;
            ftFloat,
            ftCurrency:
              begin
                StartNewValue;
    (*            if assigned(logproc) then begin
                  logproc(field.FieldName);
                  logproc(FloatToString(field.AsFloat));
                  logproc('"' + field.FieldName + '":' + FloatToString(field.AsFloat));
                  logproc('============================================================');
                end;*)
                Writer.Write('"' + field.FieldName + '":' + FloatToString(field.AsFloat));
              end;
            ftBCD: ;
            ftDate,
            ftTime,
            ftDateTime:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + FormatDateTime(JsonDateTimeFormat,field.AsDateTime) + '"');
              end;
            ftBytes: ;
            ftVarBytes: ;
            ftAutoInc:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":' + IntToStr(field.AsInteger));
              end;
            ftBlob: ;
            ftMemo:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
            ftGraphic: ;
            ftFmtMemo: ;
            ftParadoxOle: ;
            ftDBaseOle: ;
            ftTypedBinary: ;
            ftCursor: ;
            ftFixedChar:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
            ftWideString:
              begin
                StartNewValue;
                if (field.Size = 1) and ((field.AsString = 'T') or (field.AsString = 'F')) then begin
                  if field.AsBoolean then
                    Writer.Write('"' + field.FieldName + '":true')
                  else
                    Writer.Write('"' + field.FieldName + '":false');
                end
                else
                  Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
            ftLargeint:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":' + IntToStr(field.AsInteger));
              end;
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
            ftTimeStamp:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + FormatDateTime(JsonDateTimeFormat,field.AsDateTime) + '"');
              end;
            ftFMTBcd: ;
            ftFixedWideChar: ;
            ftWideMemo:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
            ftOraTimeStamp: ;
            ftOraInterval: ;
            ftLongWord,
            ftShortint,
            ftByte:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":' + IntToStr(field.AsInteger));
              end;
            ftExtended:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":' + FloatToString(field.AsFloat));
              end;
            ftConnection: ;
            ftParams: ;
            ftStream: ;
            ftTimeStampOffset: ;
            ftObject: ;
            ftSingle:
              begin
                StartNewValue;
                Writer.Write('"' + field.FieldName + '":"' + EncodeString(field.AsString) + '"');
              end;
          end;
      Except
        on E:Exception do begin
        end;
      end;
    end;
    Writer.WriteLine;
    Writer.Write('}');
  finally
    sl.Free;
  end;
end;

procedure JsonToDataset(Json: TJsonObject; Dataset: TDataset; ExcludeProps: string = ''; FieldMustExist: boolean = true);
var
  x: integer;
  pair: TJsonValuePair;
  field: TField;
//  fild: TField;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.CommaText:= ExcludeProps;
    for x := 0 to Json.Count -1 do begin
      pair := Json.Items[x];
      if sl.IndexOf(pair.Name) >= 0 then
        continue;
      field := Dataset.FindField(pair.Name);
      case pair.ValueType of
        JSONObject.valNone: ;
        JSONObject.valString:
          begin
            if Assigned(field) then begin
              if field is TDateTimeField then
                TDateTimeField(field).AsDateTime := pair.Value.AsDateTime
              else if field is TDateField then
                TDateField(field).AsDateTime := Trunc(pair.Value.AsDateTime)
              else if field is TTimeField then
                TTimeField(field).AsDateTime := Frac(pair.Value.AsDateTime)
              else
                Dataset.FieldByName(pair.Name).AsString := pair.Value.AsString;
            end
            else begin
              if FieldMustExist then
                raise Exception.Create('Error - Field ' + pair.Name + ' not found');
            end;
          end;
        JSONObject.valNumber:
          begin
            if Assigned(field) then begin
              Dataset.FieldByName(pair.Name).AsFloat := pair.Value.AsFloat;
            end
            else begin
              if FieldMustExist then
                raise Exception.Create('Error - Field ' + pair.Name + ' not found');
            end;
          end;
        JSONObject.valObject: ;
        JSONObject.valArray: ;
        JSONObject.valNull: ;
        JSONObject.valBoolean:
          begin
            if Assigned(field) then begin
              Dataset.FieldByName(pair.Name).AsBoolean := pair.Value.AsBoolean;
            end
            else begin
              if FieldMustExist then
                raise Exception.Create('Error - Field ' + pair.Name + ' not found');
            end;
          end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

function FieldToJsonValue(Field: TField): TJsonValue;
begin
  result := nil;
(*
  case field.DataType of
    ftUnknown: ;
    ftString:
      begin
        if (field.Size = 1) and ((field.AsString = 'T') or (field.AsString = 'F')) then
          with result := TJSONBoolean.Create do AsBoolean := field.AsBoolean;
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
  *)
end;

end.
