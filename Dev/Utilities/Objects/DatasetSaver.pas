unit DatasetSaver;

interface 

uses Windows, MyAccess, Classes, SysUtils, DB, Dialogs, Variants, ProgressDialog,   
    ALXMLDoc, KbmMemTable, Math;

type
  TDatasetFileSaver = class(TObject)
  private 
    slFilterList: TStringList;
    function TableContainActiveField(const sTableName: string): boolean;
    function FieldPresentInFilterSet(const sFieldName: string): boolean;
    function GetExportTableName(const sTableName: string): string;
    function GetActionID(const sActionName: string): integer;
  public 
    constructor Create;
    destructor Destroy; override;
    function SaveDatasetToCVS(const MyData: TDataSet; const sFilename: string): boolean;
    function SaveTableToCVS(const sTableName, sFilename: string): boolean;
    function SaveTableToXML(const sTableName, sFilename: string): boolean;
    function EncodeSpecialCharacters(const sThisString: string): string;
    function DecodeSpecialCharacters(const sThisString: string): string;
    function AdjustToDecimal(const iWholeNumber, iPrecision: integer): double;
    function ImportXMLData(const sFilename: string; const MyXML: TALXMLDocument; const MyConnection: TMyConnection): boolean;
    function ImportTemplate(const sTemplateName: string; const slMapList: TStringList; const sFilename: string): boolean;
    property FilterList: TStringList read slFilterList write slFilterList;
  end;

implementation 

uses FastFuncs,CommonDbLib, DNMLib, CommonLib, frmLogs;

const 
  LINE_BUFFER_SIZE = 8192;

resourcestring
  LineBreakStr = '---------------------------------------------------------';

destructor TDatasetFileSaver.Destroy;
begin 
  inherited;
end;

constructor TDatasetFileSaver.Create;
begin
  inherited Create;
end;

function TDatasetFileSaver.EncodeSpecialCharacters(const sThisString: string): string;
var 
  Buffer: array[0..LINE_BUFFER_SIZE] of char;
  iX: integer;
  sEncodedString: string;
begin 
  StrPCopy(Buffer, PChar(sThisString));
  sEncodedstring := '';
  for iX := 0 to FastFuncs.StrLength(sThisString) - 1 do begin 
    if (byte(Buffer[iX]) >= 127) or (byte(Buffer[iX]) = 38) or (byte(Buffer[iX]) = 34) or (byte(Buffer[iX]) = 60) or (byte(Buffer[iX]) = 62) or (byte(Buffer[iX]) = 124) or (byte(Buffer[iX]) < 32) or (byte(Buffer[iX]) = 39) then begin 
      case byte(Buffer[iX]) of 
        34:
          sEncodedString := sEncodedString + '&quot;';
        38:
          sEncodedString := sEncodedString + '&amp;';
        39:
          sEncodedString := sEncodedString + '&apos;';
        60:
          sEncodedString := sEncodedString + '&lt;';
        62:
          sEncodedString := sEncodedString + '&gt;';
        124:
          sEncodedString := sEncodedString + '&vbar;';
        else 
          sEncodedString := sEncodedString + '&#x' + IntToHex(byte(Buffer[iX]), 2) + ';';
      end;
    end else begin 
      sEncodedString := sEncodedString + char(Buffer[iX]);
    end;
  end;
  Result := sEncodedString;
end;

function TdatasetFileSaver.SaveTableToXML(const sTableName, sFilename: string): boolean;
var 
  sl: TStringList;
  iX: integer;
  sData, sType, sTemp: string;
  sWhere: string;
  qry: TMyQuery;
  ProgressDialog: TProgressDialog;
begin 
  Result := false;
  if not Assigned(FilterList) then 
    Exit;
  sl := TStringList.Create;
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  ProgressDialog := TProgressDialog.Create(nil);
  sWhere := '';
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM `' + sTableName + '`');
    if sTableName = 'tblclients' then begin 
      sWhere := sWhere + 'Customer = "T"';
    end;
    if TableContainActiveField(sTableName) then begin 
      if sWhere <> '' then begin 
        sWhere := sWhere + ' AND Active = "T"';
      end else begin 
        sWhere := 'Active = "T"';
      end;
    end;
    if sWhere <> '' then 
      qry.SQL.Add('WHERE ' + sWhere);
    sl.Add('<?xml version="1.0" encoding="UTF-8" ?>');
    sl.Add('<Platinum1XML Version="1.0" type="Single">');
    sl.Add('<TABLE name="' + GetExportTableName(sTableName) + '" >');
    sl.Add('<FIELDS>');
    qry.Open;
    for iX := 0 to qry.FieldCount - 1 do begin 
      if FieldPresentInFilterSet(qry.Fields[iX].FieldName) then 
        Continue;
      case qry.Fields[iX].DataType of 
        ftString:
          sType := 'String';
        ftWideString:
          sType := 'WideString';
        ftFixedChar:
          sType := 'FixedChar';
        ftBoolean:
          sType := 'Boolean';
        ftInteger:
          sType := 'Integer';
        ftWord:
          sType := 'Word';
        ftLargeint:
          sType := 'LargeInt';
        ftSmallint:
          sType := 'SmallInt';
        ftAutoInc:
          sType := 'AutoInc';
        ftUnknown:
          sType := 'UNKNOWN';
        ftDate:
          sType := 'Date';
        ftDateTime:
          sType := 'DateTime';
        ftMemo:
          sType := 'Memo';
        ftFloat:
          sType := 'Float';
        ftTimeStamp:
          sType := 'TimeStamp';
        ftCurrency:
          sType := 'Currency';
        ftBlob:
          sType := 'Blob';
        ftBytes:
          sType := 'Bytes';
        ftGraphic:
          sType := 'Graphic';
        ftVarBytes:
          sType := 'VarBytes';
        ftTime:
          sType := 'Time';
        ftVariant:
          sType := 'Variant';
      end;
      sData := '<FIELD name="' + qry.Fields[iX].FieldName + '" type="' + sType + '" size="' + FastFuncs.IntToStr(qry.Fields[iX].DataSize - 1) + '"/>';
      sl.Add(sData);
    end;
    sl.Add('</FIELDS>');
    sl.Add('</TABLE>');
    sl.Add('<ROWDATA>');
    qry.First;
    ProgressDialog.Caption  := 'Generating XML File ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := qry.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    while not qry.Eof do begin 
      sl.Add('<ROW>');
      for iX := 0 to qry.FieldCount - 1 do begin 
        if FieldPresentInFilterSet(qry.Fields[iX].FieldName) then 
          Continue;
        sTemp := VarToStr(qry.FieldByName(qry.Fields[iX].FieldName).AsVariant);
        if sTemp <> '' then begin 
          sTemp := EncodeSpecialCharacters(sTemp);
          sData := '<' + qry.Fields[iX].FieldName + ' V="' + sTemp + '"/>';
          sl.Add(sData);
        end;
      end;
      ProgressDialog.StepIt;
      sl.Add('</ROW>');
      qry.Next;
    end;
    sl.Add('</ROWDATA>');
    sl.Add('</Platinum1XML>');
    try 
      sl.SaveToFile(sFilename);
      Result := true;
    except 
    end;
  finally 
    if Assigned(sl) then 
      FreeandNil(sl);
    if Assigned(qry) then 
      FreeAndNil(qry);
    if Assigned(ProgressDialog) then 
      FreeandNil(ProgressDialog);
  end;
end;

function TDatasetFileSaver.SaveTableToCVS(const sTableName, sFilename: string): boolean;
var 
  sl: TStringList;
  qry: TMyQuery;
  iX: integer;
  sData: string;
  bFirst: boolean;
  ProgressDialog: TProgressDialog;
begin 
  Result := false;
  if not Assigned(FilterList) then 
    Exit;
  sl := TStringList.Create;
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  ProgressDialog := TProgressDialog.Create(nil);
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM `' + sTableName + '`');
    if TableContainActiveField(sTableName) then begin 
      qry.SQL.Add('WHERE Active = "T"');
    end;
    qry.Open;
    bFirst := true;
    for iX := 0 to qry.FieldCount - 1 do begin 
      if FieldPresentInFilterSet(qry.Fields[iX].FieldName) then 
        Continue;
      if bFirst then begin 
        sData := '"' + qry.Fields[iX].FieldName + '"';
        bFirst := false;
      end else begin 
        sData := sData + ',"' + qry.Fields[iX].FieldName + '"';
      end;
    end;
    sl.Add(sData);
    ProgressDialog.Caption  := 'Generating CSV File ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := qry.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    while not qry.Eof do begin 
      bFirst := true;
      for iX := 0 to qry.FieldCount - 1 do begin 
        if FieldPresentInFilterSet(qry.Fields[iX].FieldName) then 
          Continue;
        if bFirst then begin 
          if qry.Fields[iX].DataType = ftCurrency then begin 
            sData := '"' + FloatToStrF(qry.Fields[iX].AsFloat, ffCurrency, 15, 2) + '"';
          end else if qry.Fields[iX].DataType = ftString then begin 
            sData := '"' + qry.Fields[iX].AsString + '"';
          end else begin 
            sData := qry.Fields[iX].AsString;
          end;
          bFirst := false;
        end else begin 
          if qry.Fields[iX].DataType = ftCurrency then begin 
            sData := '"' + FloatToStrF(qry.Fields[iX].AsFloat, ffCurrency, 15, 2) + '"';
          end else if qry.Fields[iX].DataType = ftString then begin 
            sData := sData + ',"' + qry.Fields[iX].AsString + '"';
          end else begin 
            sData := sData + ',' + qry.Fields[iX].AsString;
          end;
        end;
      end;
      sl.Add(sData);
      ProgressDialog.StepIt;
      qry.Next;
    end;
    try 
      sl.SaveToFile(sFilename);
      Result := true;
    except 
      CommonLib.MessageDlgXP_Vista('Failed to save generated CSV file - Aborted!', mtWarning, [mbOK], 0);
    end;
  finally 
    if Assigned(sl) then 
      FreeandNil(sl);
    if Assigned(qry) then 
      FreeAndNil(qry);
    if Assigned(ProgressDialog) then 
      FreeandNil(ProgressDialog);
  end;
end;

function TDatasetFileSaver.FieldPresentInFilterSet(const sFieldName: string): boolean;
var 
  iX: integer;
  sField1, sField2: string;
  Buffer: array[0..256] of char;
begin 
  Result := false;
  if not Assigned(FilterList) then 
    Exit;
  StrPCopy(Buffer, PChar(sFieldName));
  sField1 := StrLower(Buffer);
  for iX := 0 to FilterList.Count - 1 do begin 
    sField2 := StrLower(PChar(FilterList.Strings[iX]));
    if sField1 = sField2 then begin 
      Result := true;
      Exit;
    end;
  end;
end;

function TDatasetFileSaver.TableContainActiveField(const sTableName: string): boolean;
var 
  qry: TMyQuery;
begin 
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT * FROM `' + sTableName + '` LIMIT 0;');
    qry.Open;
    try 
      Result := Assigned(qry.FieldByName('Active'));
      qry.Close;
    except 
      Result := false;
      qry.Close;
    end;
  finally 
    if Assigned(qry) then 
      FreeAndNil(qry);
  end;
end;

function TDatasetFileSaver.GetExportTableName(const sTableName: string): string;
var 
  qry: TMyQuery;
begin 
  Result := '';
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblImportExportFilteredTableNames WHERE TableName = ' + QuotedStr(sTableName) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin 
      Result := qry.FieldByName('ExportName').AsString;
    end;
    qry.Close;
  finally 
    if Assigned(qry) then 
      FreeAndNil(qry);
  end;
end;

function TDatasetFileSaver.ImportTemplate(const sTemplateName: string; const slMapList: TStringList; const sFilename: string): boolean;
var 
  qry, qryTemp, qryDiscounts, qryMarkups, qryExtraSell, qryParts: TMyQuery;
  memFields, memData: TKbmMemTable;
  ProgressDialog: TProgressDialog;
  iTemplateID, iX, iY, iMaxCount: integer;
  slFile, slMapData: TStringList;
  bPartFound, bPartInvFound: boolean;
  dTemp, dSellPrice1, dSellPrice2, dSellPrice3: double;
  iWhole: integer;
  sData: string;
  LogForm: TfrmLogsGUI;
  iDone, iModified, iQty1, iQty2, iQty3: integer;
  iClonePartID: integer;
  sDiscountCode, sPartName: string;
begin 
  Result := false;
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qryDiscounts := TMyQuery.Create(nil);
  qryDiscounts.Options.FlatBuffers := True;
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryParts := TMyQuery.Create(nil);
  qryParts.Options.FlatBuffers := True;
  qryMarkups := TMyQuery.Create(nil);
  qryMarkups.Options.FlatBuffers := True;
  qryExtraSell := TMyQuery.Create(nil);
  qryExtraSell.Options.FlatBuffers := True;
  memFields := TKbmMemTable.Create(nil);
  memData := TKbmMemTable.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);
  slFile := TStringList.Create;
  slMapData := TStringList.Create;
  try 
    LogForm := TfrmLogsGUI(GetComponentByClassName('TfrmLogsGUI'));
    if not Assigned(LogForm) then 
      Exit;
    iDone     := 0;
    iModified := 0;
    if slMapList.Count < 1 then begin 
      CommonLib.MessageDlgXP_Vista('You have no mapping information for this template - Cannot continue!', mtError, [mbOK], 0);
      Exit;
    end;
    try 
      slFile.LoadFromFile(sFilename);
    except
      on E: Exception do begin 
        CommonLib.MessageDlgXP_Vista('Failed to load Import Template File!'#13#10#13#10 + E.Message, mtError, [mbOK], 0);
        LogForm.AddLogEntry(LineBreakStr);
        LogForm.AddLogEntry('Template file [' + sFilename + '] could not be loaded for import!');
        LogForm.AddLogEntry(E.Message);
        LogForm.AddLogEntry(LineBreakStr);
        LogForm.ShowModal;
        Exit;
      end;
    end;
    memFields.EmptyTable;
    with memFields.FieldDefs.AddFieldDef do begin 
      Name := 'From';
      DataType := ftString;
      FieldNo := 0;
      Size := 255;
    end;
    with memFields.FieldDefs.AddFieldDef do begin 
      Name := 'To';
      DataType := ftString;
      FieldNo := 0;
      Size := 255;
    end;
    memFields.CreateTable;
    memFields.Open;
    for iX := 0 to slMapList.Count - 1 do begin 
      slMapData.Clear;
      ExtractStrings([':'], [' '], PChar(slMapList.Strings[iX]), slMapData);
      memFields.Insert;
      memFields.FieldByName('To').AsString := slMapData.Strings[0];
      memFields.FieldByName('From').AsString := slMapData.Strings[1];
      memFields.Post;
    end;
    if not memFields.Locate('To', 'PARTNAME', [loCaseInsensitive]) then begin 
      CommonLib.MessageDlgXP_Vista('The Field Mapping Data does not contain a mapping to the Platinum1 tblpartstemporary PARTNAME field - Aborted!', mtError, [mbOK], 0);
      LogForm.AddLogEntry(LineBreakStr);
      LogForm.AddLogEntry('The Field Mapping Data does not contain a mapping to the ');
      LogForm.AddLogEntry('Platinum1 tblpartstemporary PARTNAME field - Aborted!');
      LogForm.AddLogEntry(LineBreakStr);
      LogForm.ShowModal;
      Exit;
    end;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblImportExportFileTemplates WHERE TemplateName = ' + QuotedStr(sTemplateName) + ' AND Active = "T"');
    qry.Open;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM tblpartstemporary LIMIT 0;');
    qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryParts.ParamCheck := true;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('SELECT * FROM tblparts WHERE PartName = :xPart');
    qryExtraSell.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryExtraSell.ParamCheck := true;
    qryExtraSell.SQL.Clear;
    qryExtraSell.SQL.Add('SELECT * FROM tblextrapricesell WHERE PartsID = :xID');
    qryMarkups.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryMarkups.ParamCheck := true;
    qryMarkups.SQL.Clear;
    qryMarkups.SQL.Add('SELECT * FROM tblimportexportsellmarkups WHERE TemplateID = :xID');
    qryDiscounts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDiscounts.ParamCheck := true;
    qryDiscounts.SQL.Clear;
    qryDiscounts.SQL.Add('SELECT * FROM tblImportExportDiscountLines WHERE TemplateID = :xID');
    if qry.RecordCount > 0 then begin 
      iTemplateID := qry.FieldByName('ID').AsInteger;
      iClonePartID := qry.FieldByName('ClonePartID').AsInteger;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM tblImportExportFileTemplateLines WHERE TemplateID = ' + FastFuncs.IntToStr(iTemplateID));
      qry.Open;
      qryDiscounts.Params.ParamByName('xID').AsInteger := iTemplateID;
      qryDiscounts.Open;
      qryMarkups.Params.ParamByName('xID').AsInteger := iTemplateID;
      qryMarkups.Open;
      if qry.RecordCount > 0 then begin 
        try 
          qry.Last;
          if (Length(FastFuncs.Trim(slFile.Strings[0])) <> (qry.FieldByName('FieldEnd').AsInteger)) then begin
            LogForm.AddLogEntry(LineBreakStr);
            LogForm.AddLogEntry('Validation Error - Record size does not match template design.');
            LogForm.AddLogEntry(LineBreakStr);
            LogForm.ShowModal;
            Exit;
          end;
          iMaxCount := slFile.Count - 1;
          if iMaxCount > 4 then 
            iMaxCount := 4;
          for iX := 0 to iMaxCount do begin 
            if slFile.Strings[iX] = '' then begin 
              Continue;
            end;
            qry.First;
            while not qry.Eof do begin 
              iY := qry.FieldByName('FieldStart').AsInteger;
              sData := Copy(slFile.Strings[iX], iY, qry.FieldByName('FieldSize').AsInteger);
              sData := FastFuncs.Trim(sData);
              if (qry.FieldByName('FieldType').AsString = 'Decimal') and (sData <> '') then begin 
                if qry.FieldByName('APrecision').AsInteger > 0 then begin 
                  iWhole := FastFuncs.StrToInt(sdata);
                  AdjustToDecimal(iWhole, qry.FieldByName('APrecision').AsInteger);
                end else begin 
                  StrToFloat(sData);
                end;
              end else if (qry.FieldByName('FieldType').AsString = 'Integer') and (sData <> '') then begin 
                if sData <> '' then begin 
                  FastFuncs.StrToInt(sdata);
                end;
              end;
              qry.Next;
            end;
          end;
        except 
          on E: Exception do begin 
            CommonLib.MessageDlgXP_Vista('Field Conversion Error!'#13#10#13#10 + E.Message, mtError, [mbOK], 0);
            LogForm.AddLogEntry(LineBreakStr);
            LogForm.AddLogEntry('Failed to convert Source Field [' + qry.FieldByName('FieldName').AsString + '] to ' + qry.FieldByName('FieldType').AsString);
            LogForm.AddLogEntry(E.Message);
            LogForm.AddLogEntry(LineBreakStr);
            LogForm.ShowModal;
            Exit;
          end;
        end;
        ProgressDialog.Caption := 'Parsing Template Import Data ...';
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := slFile.Count;
        ProgressDialog.Step := 1;
        ProgressDialog.Value := ProgressDialog.MinValue;
        ProgressDialog.Execute;
        qryTemp.Open;
        memData.LoadFromDataset(qryTemp, [mtcpoStructure]);
        for iX := 0 to slFile.Count - 1 do begin 
          dSellPrice1 := 0;
          dSellPrice2 := 0;
          dSellPrice3 := 0;
          if Empty(slFile.Strings[iX]) then 
            Continue;
          try 
            bPartFound := false;
            bPartInvFound := false;
            sPartName := '';
            if memFields.Locate('To', 'PARTNAME', [loCaseInsensitive]) then begin 
              if qry.Locate('FieldName', memFields.FieldByName('From').AsString, [loCaseInsensitive]) then begin 
                iY := qry.FieldByName('FieldStart').AsInteger;
                sData := Copy(slFile.Strings[iX], iY, qry.FieldByName('FieldSize').AsInteger);
                sData := FastFuncs.Trim(sData);
                sPartName := sData;
                qryTemp.SQL.Clear;
                qryTemp.SQL.Add('SELECT * FROM tblpartstemporary WHERE PartName = :xPart;');
                qryTemp.Params.ParamByName('xPart').AsString := sData;
                qryTemp.Open;
                if qryTemp.RecordCount > 0 then begin 
                  bPartFound := true;
                end else begin 
                  bPartFound := false;
                end;
              end;
            end;
            if not bPartFound then begin 
              memData.Insert;
            end else begin 
              qryTemp.Edit;
            end;
            qryParts.Close;
            qryParts.Params.ParamByName('xPart').AsString := sPartName;
            qryParts.Open;
            if qryParts.RecordCount > 0 then begin 
              bPartInvFound := true;
              qryExtraSell.Close;
              qryExtraSell.Params.ParamByName('xID').AsInteger := qryParts.FieldByName('PartsID').AsInteger;
              qryExtraSell.Open;
              if qryMarkups.RecordCount > 0 then begin 
                while not qryExtraSell.Eof do begin 
                  if qryMarkups.Locate('CustomerTypeID', qryExtraSell.FieldByName('ClientTypeID').AsInteger, [loCaseInsensitive]) then begin 
                    qryExtraSell.Delete 
                  end else begin 
                    qryExtraSell.Next;
                  end;
                end;
                qryMarkups.First;
                while not qryMarkups.Eof do begin 
                  qryExtraSell.Insert;
                  qryExtraSell.FieldByName('ClientTypeID').AsInteger := qryMarkups.FieldByName('CustomerTypeID').AsInteger;
                  qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PartsID').AsInteger;
                  qryExtraSell.FieldByName('QtyPercent1').AsFloat := qryMarkups.FieldByName('PriceMarkup1').AsFloat;
                  qryExtraSell.FieldByName('QtyPercent2').AsFloat := qryMarkups.FieldByName('PriceMarkup2').AsFloat;
                  qryExtraSell.FieldByName('QtyPercent3').AsFloat := qryMarkups.FieldByName('PriceMarkup3').AsFloat;
                  qryExtraSell.FieldByName('ExtraSellDesc').AsString := GetPartName(qryParts.FieldByName('PartsID').AsInteger);
                  qryExtraSell.Post;
                  qryMarkups.Next;
                end;
              end;
            end;
            memFields.First;
            while not memFields.Eof do begin 
              if qry.Locate('FieldName', memFields.FieldByName('From').AsString, [loCaseInsensitive]) then begin 
                iY := qry.FieldByName('FieldStart').AsInteger;
                sData := Copy(slFile.Strings[iX], iY, qry.FieldByName('FieldSize').AsInteger);
                sData := FastFuncs.Trim(sData);
                if qry.FieldByName('FieldType').AsString = 'Decimal' then begin 
                  if sData = '' then 
                    sData := '0';
                  dTemp := StrToFloat(sData);
                  if Frac(dTemp) = 0 then begin 
                    if qry.FieldByName('APrecision').AsInteger > 0 then begin 
                      iWhole := Floor(dTemp);
                      dTemp := AdjustToDecimal(iWhole, qry.FieldByName('APrecision').AsInteger);
                    end;
                  end;
                  if (memFields.FieldByName('To').AsString = 'PRICE1') then begin 
                    dSellPrice1 := dTemp;
                    if not bPartFound then begin 
                      memData.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end else begin 
                      qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end;
                  end else if (memFields.FieldByName('To').AsString = 'PRICE2') then begin 
                    dSellPrice2 := dTemp;
                    if not bPartFound then begin 
                      memData.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end else begin 
                      qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end;
                  end else if (memFields.FieldByName('To').AsString = 'PRICE3') then begin 
                    dSellPrice3 := dTemp;
                    if not bPartFound then begin 
                      memData.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end else begin 
                      qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end;
                  end else if (memFields.FieldByName('To').AsString = 'COST1') or (memFields.FieldByName('To').AsString = 'COST2') or (memFields.FieldByName('To').AsString = 'COST3') then begin 
                    if (qryDiscounts.RecordCount > 0) then begin 
                      if qry.Locate('IsDiscount', 'T', [loCaseInsensitive]) then begin 
                        iY := qry.FieldByName('FieldStart').AsInteger;
                        sDiscountCode := Copy(slFile.Strings[iX], iY, qry.FieldByName('FieldSize').AsInteger);
                        if qryDiscounts.Locate('DiscountCode', sDiscountCode, [loCaseInsensitive]) then begin 
                          if (memFields.FieldByName('To').AsString = 'COST1') then begin 
                            dTemp := dTemp - (dTemp * (qryDiscounts.FieldByName('DiscPercent1').AsFloat / 100.0));
                            if not bPartFound then begin 
                              memData.FieldByName('BuyQty1').AsInteger := qryDiscounts.FieldByName('BuyQty1').AsInteger;
                            end else begin 
                              qryTemp.FieldByName('BuyQty1').AsInteger := qryDiscounts.FieldByName('BuyQty1').AsInteger;
                            end;
                          end else if (memFields.FieldByName('To').AsString = 'COST2') then begin 
                            dTemp := dTemp - (dTemp * (qryDiscounts.FieldByName('DiscPercent2').AsFloat / 100.0));
                            if not bPartFound then begin 
                              memData.FieldByName('BuyQty2').AsInteger := qryDiscounts.FieldByName('BuyQty2').AsInteger;
                            end else begin 
                              qryTemp.FieldByName('BuyQty2').AsInteger := qryDiscounts.FieldByName('BuyQty2').AsInteger;
                            end;
                          end else if (memFields.FieldByName('To').AsString = 'COST3') then begin 
                            dTemp := dTemp - (dTemp * (qryDiscounts.FieldByName('DiscPercent3').AsFloat / 100.0));
                            if not bPartFound then begin 
                              memData.FieldByName('BuyQty3').AsInteger := qryDiscounts.FieldByName('BuyQty3').AsInteger;
                            end else begin 
                              qryTemp.FieldByName('BuyQty3').AsInteger := qryDiscounts.FieldByName('BuyQty3').AsInteger;
                            end;
                          end;
                          if not bPartFound then begin 
                            memData.FieldByName('DiscountCode').AsString := sDiscountCode;
                          end else begin 
                            qryTemp.FieldByName('DiscountCode').AsString := sDiscountCode;
                          end;
                        end;
                      end;
                    end else begin 
                      if not bPartFound then begin 
                        memData.FieldByName('DiscountCode').AsString := '';
                      end else begin 
                        qryTemp.FieldByName('DiscountCode').AsString := '';
                      end;
                    end;
                    if not bPartFound then begin 
                      memData.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end else begin 
                      qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsFloat := dTemp;
                    end;
                  end;
                end else if qry.FieldByName('FieldType').AsString = 'Integer' then begin 
                  if sData = '' then 
                    sData := '0';
                  iWhole := FastFuncs.StrToInt(sdata);
                  if not bPartFound then begin 
                    memData.FieldByName(memFields.FieldByName('To').AsString).AsInteger := iWhole;
                  end else begin 
                    qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsInteger := iWhole;
                  end;
                end else begin 
                  if not bPartFound then begin 
                    memData.FieldByName(memFields.FieldByName('To').AsString).AsString := sData;
                  end else begin 
                    qryTemp.FieldByName(memFields.FieldByName('To').AsString).AsString := sData;
                  end;
                end;
              end;
              memFields.Next;
            end;
            if not bPartFound then begin 
              memData.FieldByName('Catagory').AsString := sTemplateName;
              Inc(iDone);
              memData.Post;
            end else begin 
              qryTemp.FieldByName('Catagory').AsString := sTemplateName;
              Inc(iModified);
              qryTemp.Post;
            end;
            memData.Edit;
            memData.FieldByName('TemplateID').AsInteger := iTemplateID;
            memData.FieldByName('ClonePartID').AsInteger := iClonePartID;
            memData.FieldByName('ClonePartName').AsString := GetPartName(iClonePartID);
            if memData.FieldByName('COST1').IsNull then begin 
              memData.FieldByName('COST1').AsFloat := 0;
            end;
            if memData.FieldByName('COST2').IsNull then begin 
              memData.FieldByName('COST2').AsFloat := 0;
            end;
            if memData.FieldByName('COST3').IsNull then begin 
              memData.FieldByName('COST3').AsFloat := 0;
            end;
            if memData.FieldByName('PRICE1').IsNull then begin 
              memData.FieldByName('PRICE1').AsFloat := 0;
            end;
            if memData.FieldByName('PRICE2').IsNull then begin 
              memData.FieldByName('PRICE2').AsFloat := 0;
            end;
            if memData.FieldByName('PRICE3').IsNull then begin 
              memData.FieldByName('PRICE3').AsFloat := 0;
            end;
            memData.Post;
            if (bPartInvFound) and (dSellPrice1 <> 0) and (qryMarkups.RecordCount > 0) and (qryExtraSell.Active) then begin 
              qryExtraSell.First;
              while not qryExtraSell.Eof do begin 
                qryExtraSell.Edit;
                qryTemp.Edit;
                dTemp := dSellPrice1 - (dSellPrice1 * (qryExtraSell.FieldByName('QtyPercent1').AsFloat / 100.00));
                qryExtraSell.FieldByName('Price1').AsFloat := dTemp;
                qryTemp.FieldByName('Price1').AsFloat := dSellPrice1;
                dTemp := dSellPrice2 - (dSellPrice2 * (qryExtraSell.FieldByName('QtyPercent2').AsFloat / 100.00));
                qryExtraSell.FieldByName('Price2').AsFloat := dTemp;
                qryTemp.FieldByName('Price2').AsFloat := dSellPrice2;
                dTemp := dSellPrice3 - (dSellPrice3 * (qryExtraSell.FieldByName('QtyPercent3').AsFloat / 100.00));
                qryExtraSell.FieldByName('Price3').AsFloat := dTemp;
                qryTemp.FieldByName('Price3').AsFloat := dSellPrice3;
                qryExtraSell.Post;
                qryTemp.Post;
                qryExtraSell.Next;
              end;
            end;
            ProgressDialog.StepIt;
          except 
            on E: Exception do begin 
              LogForm.AddLogEntry(LineBreakStr);
              LogForm.AddLogEntry('Cannot import line #' + FastFuncs.IntToStr(iX));
              LogForm.AddLogEntry(E.Message);
              LogForm.AddLogEntry(LineBreakStr);
              LogForm.ShowModal;
              Exit;
            end;
          end;
        end;
        qryTemp.SQL.Clear;
        qryTemp.SQL.Add('SELECT * FROM tblpartstemporary LIMIT 0;');
        qryTemp.Open;
        memData.SaveToDataset(qryTemp, []);
        Result := true;
        CommonLib.MessageDlgXP_Vista('Import Operation has now completed!'#13#10#13#10 + 'There where ' + FastFuncs.IntToStr(iDone) + ' records added.' + #13#10#13#10 + 'There where ' + FastFuncs.IntToStr(iModified) + ' records modified/updated.', mtInformation, [mbOK], 0);
      end else begin 
        CommonLib.MessageDlgXP_Vista('Template field mapping information could not be located!', mtError, [mbOK], 0);
        LogForm.AddLogEntry(LineBreakStr);
        LogForm.AddLogEntry('Template field mapping information could not be located!');
        LogForm.AddLogEntry(LineBreakStr);
        LogForm.ShowModal;
        Exit;
      end;
    end else begin 
      CommonLib.MessageDlgXP_Vista('Template Layout Design cannot be found - Import Aborted!', mtError, [mbOK], 0);
      Exit;
    end;
  finally 
    if Assigned(qry) then 
      FreeAndNil(qry);
    if Assigned(qryDiscounts) then 
      FreeandNil(qryDiscounts);
    if Assigned(qryTemp) then 
      FreeAndNil(qryTemp);
    if Assigned(qryParts) then 
      FreeandNil(qryParts);
    if Assigned(qryMarkups) then 
      FreeandNil(qryMarkups);
    if Assigned(qryExtraSell) then 
      FreeandNil(qryExtraSell);
    if Assigned(ProgressDialog) then 
      FreeandNil(ProgressDialog);
    if Assigned(memData) then 
      FreeandNil(memData);
    if Assigned(memFields) then 
      FreeandNil(memFields);
    if Assigned(slMapData) then 
      FreeandNil(slMapData);
    if Assigned(slFile) then 
      FreeandNil(slFile);
  end;
end;

function TDatasetFileSaver.ImportXMLData(const sFilename: string; const MyXML: TALXMLDocument; const MyConnection: TMyConnection): boolean;
var 
  qry, qryTableAlias, qryActions: TMyQuery;
  qrySales, qrySalesLines, qryParts, qryCustomer: TMyQuery;
  iX, iY, iZ: integer;
  slLog: TStringList;
  ProgressDialog: TProgressDialog;
  RootNode: TALXMLNode;
  RowDataNode: TALXMLNode;
  ChildNode: TALXMLNode;
  LogForm: TfrmLogsGUI;
  sErrorAction: string;
begin 
  Result := true;
  LogForm := nil;
  ProgressDialog := TProgressDialog.Create(nil);
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qrySales := TMyQuery.Create(nil);
  qrySales.Options.FlatBuffers := True;
  qrySalesLines := TMyQuery.Create(nil);
  qrySalesLines.Options.FlatBuffers := True;
  qryParts := TMyQuery.Create(nil);
  qryParts.Options.FlatBuffers := True;
  qryCustomer := TMyQuery.Create(nil);
  qryCustomer.Options.FlatBuffers := True;
  qryActions := TMyQuery.Create(nil);
  qryActions.Options.FlatBuffers := True;
  qryTableAlias := TMyQuery.Create(nil);
  qryTableAlias.Options.FlatBuffers := True;
  slLog := TStringList.Create;
  try 
    try 
      LogForm := TfrmLogsGUI(GetComponentByClassName('TfrmLogsGUI'));
      if not Assigned(LogForm) then 
        Exit;
      slLog.Clear;
      MyXML.FileName := sFilename;
      MyXML.Active := true;
      RootNode := MyXML.DocumentElement;
      if RootNode.Attributes['Operation'] <> 'Platinum1 Import' then begin 
        slLog.Add(LineBreakStr);
        slLog.Add('It appears that this is not a valid Platinum1 XML import file - Aborted!');
        slLog.Add(LineBreakStr);
        Exit;
      end;
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.ParamCheck := true;
      qry.SQL.Clear;
      qryActions.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryActions.ParamCheck := true;
      qryActions.SQL.Clear;
      qryActions.SQL.Add('SELECT * FROM tblImportAllowableActions WHERE Action = :xAction');
      qryActions.Params.ParamByName('xAction').AsString := RootNode.Attributes['Action'];
      qryActions.Open;
      if qryActions.RecordCount < 1 then begin 
        slLog.Add(LineBreakStr);
        slLog.Add('Unsupported Import Action [ ' + RootNode.Attributes['Action'] + ' ] - Aborted!');
        slLog.Add(LineBreakStr);
        Exit;
      end;
      sErrorAction := RootNode.Attributes['OnError'];
      sErrorAction := StrLower(PChar(sErrorAction));
      if not MyConnection.InTransaction then begin 
        MyConnection.StartTransaction;
      end;
      qryTableAlias.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryTableAlias.ParamCheck := true;
      qryTableAlias.SQL.Clear;
      qryTableAlias.SQL.Add('SELECT * FROM tblImportTableAliases WHERE AliasName = :xName');
      qrySales.Connection := MyConnection;
      qrySales.SQL.Clear;
      qrySales.SQL.Add('SELECT * FROM tblsales WHERE SalesID = 0;');
      qrySalesLines.Connection := MyConnection;
      qrySalesLines.SQL.Clear;
      qrySalesLines.SQL.Add('SELECT * FROM tblsaleslines WHERE SaleLineID = 0;');
      qryParts.Connection := MyConnection;
      qryParts.SQL.Clear;
      qryParts.SQL.Add('SELECT * FROM tblparts WHERE PartsID = 0;');
      qryCustomer.Connection := MyConnection;
      qryCustomer.SQL.Clear;
      qryCustomer.SQL.Add('SELECT * FROM tblclients WHERE ClientID = 0;');
      for iX := 0 to RootNode.ChildNodes.Count - 1 do begin 
        qryTableAlias.Close;
        qryTableAlias.Params.ParamByName('xName').AsString := RootNode.ChildNodes[iX].Attributes['Entity'];
        qryTableAlias.Open;
        if qryTableAlias.RecordCount < 1 then begin 
          slLog.Add(LineBreakStr);
          slLog.Add('Unauthorised Entity Name [ ' + RootNode.ChildNodes[iX].Attributes['Entity'] + ' ] - Aborted!');
          slLog.Add(LineBreakStr);
          if sErrorAction = 'stop' then begin 
            Exit;
          end else begin 
            Continue;
          end;
        end;
        if RootNode.ChildNodes[iX].NodeType = ntElement then begin 
          ChildNode := RootNode.ChildNodes[iX];
          ProgressDialog.CloseDialog;
          ProgressDialog.Caption := 'Importing ...';
          ProgressDialog.MinValue := 0;
          ProgressDialog.MaxValue := ChildNode.ChildNodes.Count - 1;
          ProgressDialog.Step := 1;
          ProgressDialog.Value := ProgressDialog.MinValue;
          ProgressDialog.Execute;
          for iY := 0 to ChildNode.ChildNodes.Count - 1 do begin 
            case GetActionID(RootNode.ChildNodes[iX].Attributes['Entity']) of 
              1:
                begin 
                  try 
                    RowDataNode := ChildNode.ChildNodes[iY];
                    for iZ := 0 to RowDataNode.ChildNodes.Count - 1 do begin 
                      sErrorAction := RowDataNode.ChildNodes[iZ].NodeValue;
                    end;
                    qry.Close;
                    qry.SQL.Clear;
                    qry.SQL.Add('SELECT * FROM `' + qryTableAlias.FieldByName('MasterTableName').AsString + '` WHERE Company = ' + QuotedStr(RowDataNode.ChildValues['Company']));
                    qry.Open;
                    if qry.RecordCount < 1 then begin 
                      qryCustomer.Open;
                      qryCustomer.Insert;
                      qryCustomer.FieldByName('Company').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Company']);
                      qryCustomer.FieldByName('Title').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Title']);
                      qryCustomer.FieldByName('FirstName').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['FirstName']);
                      qryCustomer.FieldByName('LastName').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['LastName']);
                      qryCustomer.FieldByName('State').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['State']);
                      qryCustomer.FieldByName('Street').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Street']);
                      qryCustomer.FieldByName('Country').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Country']);
                      qryCustomer.FieldByName('PostCode').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Postcode']);
                      qryCustomer.FieldByName('Suburb').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Suburb']);
                      qryCustomer.FieldByName('Phone').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Phone']);
                      qryCustomer.FieldByName('Email').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['Email']);
                      qryCustomer.FieldByName('BillStreet').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['BillStreet']);
                      qryCustomer.FieldByName('BillState').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['BillState']);
                      qryCustomer.FieldByName('BillPostCode').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['BillPostcode']);
                      qryCustomer.FieldByName('BillSuburb').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['BillSuburb']);
                      qryCustomer.FieldByName('BillCountry').AsVariant := DecodeSpecialCharacters(ChildNode.ChildNodes[iY].Attributes['BillCountry']);
                      qryCustomer.Post;
                    end;
                  except 
                    on E: Exception do begin 
                      slLog.Add(LineBreakStr);
                      slLog.Add('Error Occurred in Row Node #' + FastFuncs.IntToStr(iY + 1));
                      slLog.Add('Description: ' + E.Message);
                      slLog.Add(LineBreakStr);
                      if sErrorAction = 'stop' then begin 
                        Exit;
                      end else begin 
                        Continue;
                      end;
                    end;
                  end;
                end;
              2:
                begin 
                  qry.Close;
                end;
              3:
                begin 
                end;
            end;
          end;
        end;
      end;
      if MyConnection.InTransaction then begin 
        MyConnection.Commit;
      end;
    except 
      if MyConnection.InTransaction then begin 
        MyConnection.Rollback;
      end;
      Result := false;
    end;
  finally 
    if slLog.Count > 0 then begin 
      if sErrorAction = 'stop' then begin 
        if MyConnection.InTransaction then begin 
          MyConnection.Rollback;
        end;
      end else begin 
        if MyConnection.InTransaction then begin 
          MyConnection.Commit;
        end;
      end;
      if Assigned(LogForm) then begin 
        LogForm.LogLines := slLog;
        LogForm.ShowModal;
      end;
    end;
    if Assigned(ProgressDialog) then
      FreeandNil(ProgressDialog);
    if Assigned(qry) then
      FreeAndNil(qry);
    if Assigned(qryCustomer) then
      FreeandNil(qryCustomer);
    if Assigned(qrySales) then
      FreeandNil(qrySales);
    if Assigned(qrySalesLines) then
      FreeandNil(qrySalesLines);
    if Assigned(qryParts) then
      FreeandNil(qryParts);
    if Assigned(qryActions) then
      FreeandNil(qryActions);
    if Assigned(qryTableAlias) then
      FreeandNil(qryTableAlias);
    if Assigned(slLog) then
      FreeandNil(slLog);
    MyXML.Active := false;
  end;
end;

function TDatasetFileSaver.AdjustToDecimal(const iWholeNumber, iPrecision: integer): double;
var 
  iBase: integer;
  iX: integer;
begin 
  iBase := 1;
  for iX := 1 to iPrecision do begin 
    iBase := iBase * 10;
  end;
  Result := (iWholeNumber + 0.00) / iBase;
end;

function TDatasetFileSaver.DecodeSpecialCharacters(const sThisString: string): string;
var 
  Buffer: array[0..LINE_BUFFER_SIZE] of char;
  sHex: string;
  sData: byte;
  sStart: PChar;
  sTempString: string;
begin 
  sTempString := sThisString;
  try 
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&quot;', '"', [rfIgnoreCase, rfReplaceall]);
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&amp;', '&', [rfIgnoreCase, rfReplaceall]);
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&vbar;', '|', [rfIgnoreCase, rfReplaceall]);
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&lt;', '<', [rfIgnoreCase, rfReplaceall]);
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&gt;', '>', [rfIgnoreCase, rfReplaceall]);
    sTempString := FastFuncs.AnsiStringReplace(sTempString, '&apos;', '''', [rfIgnoreCase, rfReplaceall]);
    StrPCopy(Buffer, sTempString);
    while Assigned(StrPos(Buffer, '&#x')) do begin 
      sStart := StrPos(Buffer, '&#x');
      sHex := '';
      sHex := sHex + '$' + char(sStart + 3) + char(sStart + 4);
      sData := FastFuncs.StrToInt(sHex);
      sTempString := FastFuncs.AnsiStringReplace(sTempString, '&#x' + sHex + ';', char(sData), [rfIgnoreCase, rfReplaceall]);
      StrPCopy(Buffer, sTempString);
    end;
    Result := sTempString;
  except 
    Result := '';
  end;
end;

function TDatasetFileSaver.GetActionID(const sActionName: string): integer;
begin 
  if sActionName = 'Customers' then begin 
    Result := 1;
  end else if sActionName = 'Invoices' then begin 
    Result := 2;
  end else if sActionName = 'Orders' then begin 
    Result := 3;
  end else if sActionName = 'Products' then begin
    Result := 4;
  end else begin
    Result := 0;
  end;
end;

function TDatasetFileSaver.SaveDatasetToCVS(const MyData: TDataSet; const sFilename: string): boolean;
var
  sl: TStringList;
  iX: integer;
  sData: string;
  bFirst: boolean;
  ProgressDialog: TProgressDialog;
  bm: TBookMark;
begin
  Result := false;
  if not Assigned(FilterList) then
    Exit;
  sl := TStringList.Create;
  ProgressDialog := TProgressDialog.Create(nil);
  try
    bFirst := true;
    for iX := 0 to MyData.FieldCount - 1 do begin
      if FieldPresentInFilterSet(MyData.Fields[iX].FieldName) then
        Continue;
      if bFirst then begin
        sData := '"' + MyData.Fields[iX].FieldName + '"';
        bFirst := false;
      end else begin
        sData := sData + ',"' + MyData.Fields[iX].FieldName + '"';
      end;
    end;
    sl.Add(sData);
    ProgressDialog.Caption  := 'Generating CSV File ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := MyData.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    bm := MyData.GetBookmark;
    MyData.DisableControls;
    Try
      MyData.First;
      while not MyData.Eof do begin
        bFirst := true;
        for iX := 0 to MyData.FieldCount - 1 do begin
          if FieldPresentInFilterSet(MyData.Fields[iX].FieldName) then
            Continue;
          if bFirst then begin
            if MyData.Fields[iX].DataType = ftCurrency then begin
              sData := '"' + FloatToStrF(MyData.Fields[iX].AsFloat, ffCurrency, 15, 2) + '"';
            end else if MyData.Fields[iX].DataType = ftString then begin
              sData := '"' + MyData.Fields[iX].AsString + '"';
            end else begin
              sData := MyData.Fields[iX].AsString;
            end;
            bFirst := false;
          end else begin
            if MyData.Fields[iX].DataType = ftCurrency then begin
              sData := '"' + FloatToStrF(MyData.Fields[iX].AsFloat, ffCurrency, 15, 2) + '"';
            end else if MyData.Fields[iX].DataType = ftString then begin
              sData := sData + ',"' + MyData.Fields[iX].AsString + '"';
            end else begin
              sData := sData + ',' + MyData.Fields[iX].AsString;
            end;
          end;
        end;
        sl.Add(sData);
        ProgressDialog.StepIt;
        MyData.Next;
      end;
      try
        sl.SaveToFile(sFilename);
        Result := true;
        if MyData.BookmarkValid(bm) then begin
          MyData.GotoBookmark(bm);
        end;
        Result := true;
      except
        Result := false;
        CommonLib.MessageDlgXP_Vista('Failed to save generated CSV file - Aborted!', mtWarning, [mbOK], 0);
      end;
    finally
      MyData.FreeBookmark(bm);
      MyData.EnableControls;
    end;

  finally
    if Assigned(sl) then FreeandNil(sl);
    if Assigned(ProgressDialog) then FreeandNil(ProgressDialog);
  end;
end;

end.

