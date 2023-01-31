unit dbfUtils;

interface

uses
  db;

  {  Table Levels
       3 dBase III +
       4 dBase IV
       7 Visual dBase VII
       25 FoxPro compatible
  }



const
  Level_dBase3 = 3;
  Level_dBase4 = 4;
  Level_Visual_dBase7 = 7;
  Level_FoxPro = 25;

  procedure ExportDatasetToDbf(aFileName: string; ds: TDataset; TableLevel: integer = Level_dBase4);

implementation

uses
  dbf, dbf_lang, sysutils, LogThreadLib;

procedure ExportDatasetToDbf(aFileName: string; ds: TDataset; TableLevel: integer = Level_dBase4);
var
  x, i: integer;
  dBase: TDbf;
  FieldDef: TFieldDef;
  dataset: TDataset;
  field: TField;
begin
  dBase:= TDbf.Create(nil);
  try
    dBase.TableLevel:= TableLevel;
//    dbase.LanguageID:= DbfLangId_ENG_437; //FoxLangId_Windows_1252;
    for x := 0 to ds.FieldDefs.Count -1 do begin
      FieldDef:= ds.FieldDefs[x];

      case TableLevel of
        Level_dBase3, Level_dBase4,
        Level_Visual_dBase7:
          begin
            case FieldDef.DataType of
              ftString, ftMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
                begin
                  if FieldDef.Size <= 254 then
                    dBase.FieldDefs.Add(FieldDef.Name,ftString,FieldDef.Size)
                  else
                    dBase.FieldDefs.Add(FieldDef.Name,ftMemo,FieldDef.Size);

                end;
              ftSmallint, ftInteger, ftWord, ftLongWord, ftShortint, ftAutoInc:
                begin
                  dBase.FieldDefs.Add(FieldDef.Name,ftFloat,0);
                end;
              ftBoolean:
                begin

                end;
              ftFloat, ftCurrency, ftBCD,ftExtended, ftSingle:
                begin
                  dBase.FieldDefs.Add(FieldDef.Name,ftFloat,0);
                end;
              ftDate, ftTime, ftDateTime, ftTimeStamp:
                begin

                end;
              ftBytes,
              ftVarBytes,
              ftBlob,
              ftUnknown,
              ftGraphic,
              ftFmtMemo,
              ftParadoxOle,
              ftDBaseOle,
              ftTypedBinary,
              ftCursor,
              ftLargeint,
              ftADT,
              ftArray,
              ftReference,
              ftDataSet,
              ftOraBlob,
              ftOraClob,
              ftVariant,
              ftInterface,
              ftIDispatch,
              ftGuid,
              ftFMTBcd,
              ftOraTimeStamp,
              ftOraInterval,
              ftByte,
              ftConnection,
              ftParams,
              ftStream,
              ftTimeStampOffset,
              ftObject: ; { ignore }

            end;



          end;
        Level_FoxPro:
          begin


          end;
      end;



    end;
    dBase.OpenMode:= omAutoCreate;
    dbase.TableName:= aFileName;
    dBase.Open;
    ds.First;
    while not ds.Eof do begin
      dBase.Insert;
      for i := 0 to dBase.Fields.Count -1 do begin
        field:= ds.FieldByName(dBase.Fields[i].FieldName);
        if not field.IsNull then begin
          try
            dBase.Fields[i].Value:= field.Value;

          except
            on e: exception do begin
              TLogger.Inst.Log('Error mapping field ' + field.FieldName +
                ' of DataType ' + IntToStr(Ord(field.DataType)) + ' ' + ds.Fields[i].ClassName +
                ' to DataType ' + IntToStr(Ord(dBase.Fields[i].DataType)) + ' ' + dBase.Fields[i].ClassName +
                ' with value ' + field.AsString);

            end;

          end;
        end;
      end;
      dBase.Post;
      dataset.Next;
    end;
    dBase.Close;
  finally
    dBase.Free;
  end;
end;

end.
