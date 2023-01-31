unit ERPFileMapperObj;

interface

uses
  JsonObject, LogThreadBase, Classes, LogMessageTypes, ERPDBComponents,
  EDIMapConfigObj, Types, EDICustomFileMapperObj;

type

//  TERPFileMapperErrorType = (meNone, meFatal, meTransient);

  TERPFileMapper = class(TEDICustomFileMapper)
  private
//    fConfig: TEDIMapConfig;
//    fOnLog: TOnLogEvent;
//    fConnection: TERPConnection;
//    fERPPass: string;
//    fERPUser: string;
//    fLastErrorType: TERPFileMapperErrorType;
//    fErrors: TStringList;
//    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function ProcessCSVFile(reader: TStreamReader): boolean;
    function FieldValid(fieldData: string; colConfig: TJsonObject): boolean;
    function FieldOk(data: TStringDynArray; Columns: TJsonObject; ColNo, RowNo: integer; var msg: string): boolean;
    function LineOk(data: TStringDynArray; Columns: TJsonObject; RowNo: integer; var msg: string): boolean;
    function AddLineData(LineArray: TJsonArray; line: TStringDynArray; Columns: TJsonObject; RowNo: integer; var msg: string): boolean;
    function ImportData(data: TJsonArray; Mapping: TJsonObject; var msg: string): boolean;
    function MapToERP(data: TJsonArray; Mapping: TJsonObject; var msg: string): boolean;
    function IsNewRec(DataLine, PriorDataLine: TJsonObject; NewRecordOn: TJsonObject): boolean;
//    procedure Err(const msg: string; ErrorType: TERPFileMapperErrorType = meFatal);
    function StringToCurrency(val: string; colDef: TJsonObject): double;
  public
//    constructor Create;
//    destructor Destroy;
//    property OnLog: TOnLogEvent read fOnLog write fOnLog;
//    property Connection: TERPConnection read fConnection write fConnection;
//    property Config: TEDIMapConfig read fConfig; // write fConfig;
//    property ERPUser: string read fERPUser write fERPUser;
//    property ERPPass: string read fERPPass write fERPPass;
    function ProcessFile(stream: TStream; aMapName: string): boolean; overload; override;
    function ProcessFile(aFileName: string; aMapName: string): boolean; overload; override;
//    property LastErrorType: TERPFileMapperErrorType read fLastErrorType;
//    property Errors: TStringList read fErrors;
  end;

implementation

uses
  sysutils, StringUtils, DateTimeUtils, ActiveX,
  AppEnvironment, BusObjBase, TypInfo, StrUtils, JsonToObject;

{ TERPFileMapper }

function TERPFileMapper.AddLineData(LineArray: TJsonArray; line: TStringDynArray;
  Columns: TJsonObject; RowNo: integer; var msg: string): boolean;
var
  x: integer;
  colNo: integer;
  rec, def: TJsonObject;
  s: string;
begin
  result := false;
  colNo := 0;
  try
    rec := JO;
    rec.I['RowNumber'] := RowNo;
    for x := Low(line) to High(line) do begin
      ColNo := x +1;
      s := StringUtils.StripQuotes(Trim(line[x]));
      if Columns.ObjectExists(IntToStr(x+1)) then begin
        def := Columns.O[IntToStr(x+1)];
        if SameText(def.S['DataType'],'DateTime') then begin
          rec.DT[IntToStr(x+1)] := DateTimeUtils.StrToDateTimeFmt(def.S['DateFormat'],def.S['TimeFormat'],s);
        end
        else if SameText(def.S['DataType'],'Integer') then begin
          rec.I[IntToStr(x+1)] := StrToIntDef(s,0);
        end
        else if SameText(def.S['DataType'],'Float') then begin
          rec.F[IntToStr(x+1)] := StrToFloatDef(s,0);
        end
        else if SameText(def.S['DataType'],'Currency') then begin
          rec.F[IntToStr(x+1)] := StringToCurrency(s,def);
        end
        else begin
          { else its a string }
          rec.S[IntToStr(x+1)] := s;
        end;
      end
      else begin
        { assume string }
        rec.S[IntToStr(x+1)] := s;
      end;
    end;

    LineArray.Add(rec);
  except
    on e: exception do begin
      if ColNo > 0 then
        msg := 'Error loading data for Row Number ' + IntToStr(RowNo) + ' and Column Number '+IntToStr(ColNo)+': ' + e.Message
      else
        msg := 'Error loading data for Row Number ' + IntToStr(RowNo) + ': ' + e.Message;
      exit;
    end;
  end;
  result := true;
end;

//constructor TERPFileMapper.Create;
//begin
//  fLastErrorType := meNone;
//  fConfig := TEDIMapConfig.Create;
//  fErrors := TStringList.Create;
//end;
//
//destructor TERPFileMapper.Destroy;
//begin
//  fConfig.Free;
//  fErrors.Free;
//end;

//procedure TERPFileMapper.Err(const msg: string;
//  ErrorType: TERPFileMapperErrorType);
//begin
//  fLastErrorType := ErrorType;
//  if Errors.Count > 0 then Errors.Add('');
//  Errors.Add(msg);
//  Log(msg,ltError);
//end;

function TERPFileMapper.FieldOk(data: TStringDynArray; Columns: TJsonObject; ColNo,
  RowNo: integer; var msg: string): boolean;
var
  s: string;
  def: TJsonObject;
  dt: TDateTime;

  function ColName: string;
  begin
    if def.StringExists('Name') then
      result := '"' + def.S['Name'] + '"'
    else
      result := '"Column ' + IntToStr(ColNo) + '"'
  end;


begin
  result := false;
  if Columns.ObjectExists(IntToStr(ColNo)) then begin
    def := Columns.O[IntToStr(ColNo)];
    s := StringUtils.StripQuotes(Trim(data[ColNo-1]));
    if def.B['Required'] and (s= '') then begin
      msg := 'Row Number ' + IntToStr(RowNo) + ' - Required data missing for Column ' + ColName;
      exit;
    end;
    if SameText(def.S['DataType'],'DateTime') then begin
      if s <> '' then begin
        try
          dt := DateTimeUtils.StrToDateTimeFmt(def.S['DateFormat'],def.S['TimeFormat'],s);
          if dt = 0 then begin
            msg := 'Row Number ' + IntToStr(RowNo) + ' - Invalid Date/Time Value for Column ' + ColName;
            exit;
          end;
        except
          on e: exception do begin
            msg := 'Row Number ' + IntToStr(RowNo) + ' - Invalid Date/Time Value for Column ' + ColName;
            exit;
          end;
        end;
      end;
    end;
    if SameText(def.S['DataType'],'Integer') then begin
      if s <> '' then begin
        if not StringUtils.StringIsInteger(s) then begin
          msg := 'Row Number ' + IntToStr(RowNo) + ' - Invalid Integer Number Value for Column ' + ColName;
          exit;
        end;
      end;
    end;
    if SameText(def.S['DataType'],'Float') then begin
      if s <> '' then begin
        if not StringUtils.StringIsNumber(s) then begin
          msg := 'Row Number ' + IntToStr(RowNo) + ' - Invalid Decimal Number Value for Column ' + ColName;
          exit;
        end;
      end;
    end;
    if SameText(def.S['DataType'],'Currency') then begin
      if s <> '' then begin
        try
          StringToCurrency(s,def);
        except
          on e: exception do begin
            msg := 'Row Number ' + IntToStr(RowNo) + ' - Invalid Currency Value for Column "' + ColName + '" with error:' + e.Message;
            exit;
          end;
        end
      end;
    end;
  end;

  result := true;
end;

function TERPFileMapper.FieldValid(fieldData: string;
  colConfig: TJsonObject): boolean;
var
  data: string;
  dt: TDateTime;
begin
  { return true if the data is valid using the column config data }
  result := false;
  data := StringUtils.StripQuotes(Trim(fieldData));
  { if its required and its blank then not valid }
  if colConfig.B['Required'] and (data = '') then exit;
  if SameText(colConfig.S['DataType'],'DateTime') then begin
    { check for valid date tim data .. }
    try
      dt := DateTimeUtils.StrToDateTimeFmt(colConfig.S['DateFormat'],colConfig.S['TimeFormat'],data);
      if dt = 0 then
        exit;
    except
      exit;
    end;
  end;
  result := true;
end;

function TERPFileMapper.ImportData(data: TJsonArray; Mapping: TJsonObject;
  var msg: string): boolean;
var
  MapNo: integer;
  Map: TJsonObject;
begin
  result := true;
  for MapNo := 0 to Mapping.Count -1 do begin
    Map := Mapping.Items[MapNo].Value.AsObject;
    Log('Processing Mapping for ' + Mapping.Items[MapNo].Name,ltInfo);
    if not MapToERP(data,Map,msg) then begin
      { save error and continue }
      result := false;
      Errors.Insert(0,'');
      Errors.Insert(0,'An error(s) occured while processing mapping for: ' + Mapping.Items[MapNo].Name);
    end;
  end;
end;

function TERPFileMapper.IsNewRec(DataLine, PriorDataLine,
  NewRecordOn: TJsonObject): boolean;
var
  x: integer;
  ColNo: integer;
begin
  result := true;
  if not Assigned(PriorDataLine) then exit;
  if SameText(NewRecordOn.S['ChangeType'],'Row') then exit;
  result := false;
  if SameText(NewRecordOn.S['ChangeType'],'Column') then begin
    { some combinations of columns must change }
    for x := 0 to NewRecordOn.O['Params'].A['Columns'].Count -1 do begin
      ColNo := NewRecordOn.O['Params'].A['Columns'].Items[x].AsInteger;
      if SameText(DataLine.ItemByName[IntToStr(ColNo)].Value.AsString,
                  PriorDataLine.ItemByName[IntToStr(ColNo)].Value.AsString) then begin
        { column data is the same }
        if SameText(NewRecordOn.O['Params'].S['Relationship'],'and') then begin
          { they all have to change .. }
          result := false;
          exit;
        end;
      end
      else begin
        { column data has changed }
        if SameText(NewRecordOn.O['Params'].S['Relationship'],'or') then begin
          { we only need one to change .. }
          result := true;
          exit;
        end;
      end;
    end;

  end;
  { else unknown change type }
end;

function TERPFileMapper.LineOk(data: TStringDynArray; Columns: TJsonObject;
  RowNo: integer; var msg: string): boolean;
var
  x: integer;
begin
  result := true;
  for x := Low(data) to High(data) do begin
    if not FieldOk(data,Columns,x+1,RowNo,msg) then begin
      result := false;
      exit;
    end;
  end;
end;

//procedure TERPFileMapper.Log(const msg: string;
//  const LogMessageType: TLogMessageType);
//begin
//  if Assigned(fOnLog) then fOnLog(msg,LogMessageType);
//end;

function TERPFileMapper.MapToERP(data: TJsonArray; Mapping: TJsonObject;
  var msg: string): boolean;
//type
//  TColDataChangeRelationship = (crNONE, crOR, crAND);
var
  Target: TJsonObject;
  Map: TJsonArray;
  ResourceClass: TPersistentClass;
  BusObj: TBusObj;
  x, y: integer;
  DataLine, PriorDataLine: TJsonObject;
  obj: TObject;
  MapItem: TJsonObject;
  SourcePair: TJsonValuePair;
  ReplaceFlags: TReplaceFlags;
  PropInfo: PPropInfo;
  s: string;
  bigint: int64;
  json: TJsonObject;
  LinesPropName: string;
  fInInTrans: boolean;
  lineCount: integer;
  StartRowNo: integer;

  function Lines: TBusObj;
  var
    aObj: TObject;
    aLinesPropName: string;
  begin
    result := nil;
    { get the lines object }
    if Target.ObjectExists('Line') then begin
      aLinesPropName := 'Lines';
      if Target.O['Line'].StringExists('PropertyName') then
        aLinesPropName := Target.O['Line'].S['PropertyName'];
      aObj := TypInfo.GetObjectProp(BusObj,aLinesPropName);
      if not Assigned(aObj) then begin
        exit;
      end;
      if aObj.InheritsFrom(TBusObj) then begin
        result := TBusObj(aObj);
      end
    end;
  end;

  function ObjInst(aPropName: string): TObject;
  var
    arr: TStringDynArray;
    i: integer;
  begin
    result := BusObj;
    arr := SplitString(aPropName,'.');
    if Length(arr) = 1 then exit;
    for i := Low(arr) to High(arr)-1 do
      result := GetObjectProp(result,arr[i]);
  end;

  function FieldName(aTarget: TJsonObject): string;
  var
    arr: TStringDynArray;
    i: integer;
  begin
    arr := SplitString(aTarget.S['Field'],'.');
    result := arr[High(arr)];
  end;

  function StrToControl(str: string): string;
  begin
    result := StringReplace(str,'\r',#13,[rfReplaceAll]);
    result := StringReplace(result,'\n',#11,[rfReplaceAll]);
  end;

  procedure BeginTrans;
  begin
    if not fInInTrans then begin
      fInInTrans := true;
      if Assigned(BusObj) then
        BusObj.Connection.BeginNestedTransaction;
    end;
  end;

  procedure CommitTrans;
  begin
    if fInInTrans then begin
      fInInTrans := false;
      if Assigned(BusObj) then
        BusObj.Connection.CommitNestedTransaction;
    end;
  end;

  procedure RollbackTrans;
  begin
    if fInInTrans then begin
      fInInTrans := false;
      if Assigned(BusObj) then
        BusObj.Connection.RollbackNestedTransaction;
    end;
  end;

begin
  result := true;
  fInInTrans := false;
  try
    Target := Mapping.O['Target'];
    Map := Mapping.A['Map'];
    ResourceClass:= GetClass(Target.S['ERPClassName']);
    if not Assigned(ResourceClass) then begin
      msg := 'Could not find ERP Target Object (' + Target.S['ERPClassName'] + ') to Map Data to';
      if Errors.Count > 0 then Errors.Add('');
      Errors.Add(msg);
      result := false;
      exit;
    end;
    if ResourceClass.InheritsFrom(TBusObj) then begin // InheritsFrom(TBusObj) then begin
      BusObj:= TBusObjClass(ResourceClass).Create(nil);
      BusObj.Connection := TMyDacDataConnection.Create(BusObj);
      BusObj.Connection.Connection := AppEnv.AppDb.TransConnection;
      BusObj.SilentMode := true;
      BusObj.Load(0);

    end
    else begin
      msg := 'ERP Target Object (' + Target.S['ERPClassName'] + ') not supported';
      result := false;
      if Errors.Count > 0 then Errors.Add('');
      Errors.Add(msg);
      exit;
    end;

    { check the lines settings }
    if Target.ObjectExists('Line') then begin
      LinesPropName := 'Lines';
      if Target.O['Line'].StringExists('PropertyName') then
        LinesPropName := Target.O['Line'].S['PropertyName'];
      obj := TypInfo.GetObjectProp(BusObj,LinesPropName);
      if not Assigned(Obj) then begin
        result := false;
        msg := 'ERP Target Object Line not found for Property Name "' + LinesPropName + '"';
        if Errors.Count > 0 then Errors.Add('');
        Errors.Add(msg);
        exit;
      end;
      if obj.InheritsFrom(TBusObj) then begin

      end
      else begin
        result := false;
        msg := 'ERP Target Lines Object (' + obj.ClassName + ') not supported';
        if Errors.Count > 0 then Errors.Add('');
        Errors.Add(msg);
        exit;
      end;
    end;

    PriorDataLine := nil;
    lineCount := 0;
    StartRowNo := 0;
    for x := 0 to data.Count -1 do begin
      Log('Processing record ' + IntToStr(x+1) + ' of ' + IntToStr(data.count) + ' ..',ltDetail);
      { MAIN data loop }
      DataLine := data.Items[x].AsObject;
      if x > 0 then
        PriorDataLine := data.Items[x-1].AsObject;
      if x = 0 then
        StartRowNo := DataLine.I['RowNumber'];

      { is this a new record ... }
      if IsNewRec(DataLine, PriorDataLine,Target.O['NewRecordOn']) then begin
        if BusObj.Count > 0 then begin
//          BusObj.PostDb;
          if not BusObj.Save then begin
            result := false;
            msg := BusObj.ResultStatus.Messages + ' Current Imput File Row Range is: ' + IntToStr(StartRowNo) + ' to '  + IntToStr(DataLine.I['RowNumber']);
            if Errors.Count > 0 then Errors.Add('');
            Errors.Add('An error occurred when saving ' + BusObj.XMLNodeName);
            Errors.Add(BusObj.ResultStatus.Messages);
            Errors.Add('Error located between input file row number ' + IntToStr(StartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
            RollbackTrans;
          end
          else begin
//            if Assigned(Lines) and (lineCount > 0) and (Lines.Count <> lineCount) then begin
//              result := false;
//              msg := 'Line count does not match added lines. Current Imput File Row Number is: ' + IntToStr(DataLine.I['RowNumber']);
//              if Errors.Count > 0 then Errors.Add('');
//              Errors.Add('An error occurred when saving ' + BusObj.XMLNodeName);
//              Errors.Add('Line count does not match added lines.');
//              Errors.Add('Current Imput File Row Number is: ' + IntToStr(DataLine.I['RowNumber']));
//              RollbackTrans;
//              continue;
//            end;
            CommitTrans;
            Log('Saved ' + BusObj.BusObjectTypeDescription + ', Id: ' + IntToStr(BusObj.ID),ltDetail);
          end;
        end;
        BusObj.Load(0);
        BusObj.New;
        lineCount := 0;
        BeginTrans;
      end;
      if Lines <> nil then begin
        if IsNewRec(DataLine, PriorDataLine,Target.O['Line'].O['NewRecordOn']) then begin
          if Lines.Count > 0 then Lines.PostDb;
          Lines.New;
          Inc(lineCount);
          StartRowNo := DataLine.I['RowNumber'];
        end;
      end;

      { map the line ... }
      for y := 0 to Map.Count -1 do begin
        { MAIN COLUMN loop }
        MapItem := Map.Items[y].AsObject;
        SourcePair := nil;
        if MapItem.O['Source'].Exists('ColumnNumber') then begin
          { we are mapping from an input file column }
          SourcePair := DataLine.ItemByName[IntToStr(MapItem.O['Source'].I['ColumnNumber'])];
        end
        else if MapItem.O['Source'].Exists('Value') then begin
          { we are mapping from a fixed value }
          SourcePair := MapItem.O['Source'].ItemByName['Value'];
        end;
        if Assigned(SourcePair) then begin
          { check for any source conditions ..  }
          if MapItem.O['Source'].Exists('StringReplace') then begin
            ReplaceFlags := [];
            if MapItem.O['Source'].O['StringReplace'].B['ReplaceAll'] then
              ReplaceFlags := ReplaceFlags + [rfReplaceAll];
            if MapItem.O['Source'].O['StringReplace'].B['IgnoreCase'] then
              ReplaceFlags := ReplaceFlags + [rfIgnoreCase];
            SourcePair.Value.AsString :=
              StringReplace(SourcePair.Value.AsString,
                MapItem.O['Source'].O['StringReplace'].S['SearchString'],
                MapItem.O['Source'].O['StringReplace'].S['ReplaceString'],ReplaceFlags);
          end;
          if MapItem.O['Source'].B['MapWhenNotBlank'] then begin
            if (SourcePair.Value.AsString = '') or (SourcePair.Value.AsString = '0') then
              continue;
          end;
          if MapItem.O['Source'].O['Defailt'].B['UseDefaultWhenBlank'] then begin
            if SourcePair.Value.IsBlank then
              SourcePair.Value.AsString := MapItem.O['Source'].O['Defailt'].S['DefaultValue'];
          end;
          { any other source condions go here! }

          { now the target .. }
          if MapItem.O['Target'].Exists('Field') then begin
            { we are mapping to an object field }
            { data types }
            PropInfo := TypInfo.GetPropInfo(ObjInst(MapItem.O['Target'].S['Field']),FieldName(MapItem.O['Target']));
            if not Assigned(PropInfo) then begin
              Msg := 'Could not find the specified property "' + MapItem.O['Target'].S['Field'] +
                '" for ERP Business Object';
              exit;
            end;
            case PropInfo^.PropType^.Kind of
              tkChar,
              tkWChar,
              tkString,
              tkUString,
              tkLString,
              tkWString:
                begin
                  if MapItem.O['Target'].Exists('Separator') then begin
                    s := GetStrProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo);
                    if s <> '' then
                      s := s + StrToControl(MapItem.O['Target'].S['Separator']) +
                        SourcePair.Value.AsString
                    else
                      s := SourcePair.Value.AsString;
                    SetStrProp(ObjInst(MapItem.O['Target'].S['Field']),FieldName(MapItem.O['Target']),s);
                  end;
                  SetStrProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,SourcePair.Value.AsString);
                end;
              tkFloat:
                begin
                  if PropInfo.PropType^.Name = 'TDateTime' then begin
                    SetFloatProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,SourcePair.Value.AsDateTime);
                  end
                  else begin
                    SetFloatProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,SourcePair.Value.AsFloat);
                  end;
                end;
              tkInteger:
                begin
                  SetOrdProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,SourcePair.Value.AsInteger);
                end;
              tkInt64:
                begin
                  bigint:= StrToInt64(SourcePair.Value.AsString);
                  SetInt64Prop(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,bigint);
                end;
              tkEnumeration:
                begin
                  if PropInfo^.PropType^.Name = 'Boolean' then begin
                    if SourcePair.Value.AsBoolean then
                      SetEnumProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,'True')
                    else
                      SetEnumProp(ObjInst(MapItem.O['Target'].S['Field']),PropInfo,'False');
                  end;
                end;
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
              tkProcedure:; {ignore}
            end;
          end;
        end;
      end;
    end;
    { End of data }
    if not BusObj.Save then begin
      result := false;
      msg := BusObj.ResultStatus.Messages;
      if Errors.Count > 0 then Errors.Add('');
      Errors.Add('An error occurred when saving ' + BusObj.XMLNodeName);
      Errors.Add(BusObj.ResultStatus.Messages);
      if Assigned(DataLine) then
        Errors.Add('Error located between input file row number ' + IntToStr(StartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
      exit;
    end
    else begin
//      if Assigned(Lines) and (lineCount > 0) and (Lines.Count <> lineCount) then begin
//        result := false;
//        msg := 'Line count does not match added lines. Current Imput File Row Number is: ' + IntToStr(DataLine.I['RowNumber']);
//        if Errors.Count > 0 then Errors.Add('');
//        Errors.Add('An error occurred when saving ' + BusObj.XMLNodeName);
//        Errors.Add('Line count does not match added lines.');
//        if Assigned(DataLine) then
//          Errors.Add('Current Imput File Row Number is: ' + IntToStr(DataLine.I['RowNumber']));
//        RollbackTrans;
//        exit;
//      end;
      CommitTrans;
      Log('Saved ' + BusObj.BusObjectTypeDescription + ', Id: ' + IntToStr(BusObj.ID),ltDetail);
    end;

  except
    on e: exception do begin
      result := false;
      msg := 'Error while Mapping Data: ' + e.Message;
      if Errors.Count > 0 then Errors.Add('');
      Errors.Add(msg);
      RollbackTrans;
    end;
  end;
end;

function TERPFileMapper.ProcessCSVFile(reader: TStreamReader): boolean;
var
  line: TStringDynArray;
  lineNo: integer;
  x: integer;
  filter: TJsonObject;
  colNo: integer;
  loadLine: boolean;
  data: TJsonObject;
  msg: string;

begin
  result := false;
  if Config.O['InputFile'].O['DataFormatParams'].S['FieldSep'] = '' then begin
    raise Exception.Create(ClassName + ' Error - Field Separator missing from Mapping Configuration');
    exit;
  end;
//  line := TStringList.Create;
  data := JO;
  try
//    line.Delimiter := Config.O['InputFile'].O['DataFormatParams'].S['FieldSep'][1];
    lineNo := 0;
    while not reader.EndOfStream do begin
      Inc(LineNo);
      SetLength(line,0);
      { split up columns }
      if Config.O['InputFile'].O['DataFormatParams'].B['QuotedStrings'] then
        line := StringUtils.SplitString(reader.ReadLine,Config.O['InputFile'].O['DataFormatParams'].S['FieldSep'],'"')
      else
        line := StringUtils.SplitString(reader.ReadLine,Config.O['InputFile'].O['DataFormatParams'].S['FieldSep']);
//      line.DelimitedText := reader.ReadLine;
      if Length(line) <> Config.O['InputFile'].O['DataFormatParams'].I['NumberOfColumns'] then begin
        Err(ClassName + ' The number of columns for Row Number ' + IntToStr(lineNo) +
          ' (' + IntToStr(Length(line)) +
          ' columns) does not match the Number of Columns specifide in the Mapping Configuration ' +
          '(' + IntToStr(Config.O['InputFile'].O['DataFormatParams'].I['NumberOfColumns']) +
          ' columns)');
        exit;
      end;
      loadLine := true;
      { check filters }
      for x := 0 to Config.O['InputFile'].A['Filters'].Count -1 do begin
        filter := Config.O['InputFile'].A['Filters'].Items[x].AsObject;
        if SameText(filter.S['SelectWhen'],'DataValid') then begin
          if  Config.O['InputFile'].O['Columns'].ObjectExists(IntToStr(filter.I['ColumnNumber'])) and
            (not FieldValid(line[filter.I['ColumnNumber']-1],Config.O['InputFile'].O['Columns'].O[IntToStr(filter.I['ColumnNumber'])])) then
            loadLine := false;
        end;
      end;
      if loadLine then begin
        { check for errors }
        if not LineOk(line,Config.O['InputFile'].O['Columns'],lineNo,msg) then begin
          Err(msg);
          exit;
        end;
        if not AddLineData(data.A['Lines'],line,Config.O['InputFile'].O['Columns'],lineNo,msg) then begin
          Err(msg);
          exit;
        end;
      end;
    end;

    if data.A['Lines'].Count = 0 then begin
      Err('No data found in input file to process');
      exit;
    end;

    { we now have lines we need to process loaded intp data.A['Lines'] }
    { now map it }

    CoInitialize(nil);
    try
      try
        AppEnv.AppDb.Database := Connection.Database;
        AppEnv.AppDb.ConnectUser(ERPUser, ERPPass);
      except
        on eusr: exception do begin
          msg := 'Error connecting to ERP: ' + eusr.Message;
          Err(msg,meTransient);
          exit;
        end;
      end;
      try
        if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',Connection.Database,ERPUser,'','',true) then begin
          msg := 'Could not connect to ERP. ' + msg;
          Err(msg,meTransient);
          exit;
        end;
        try

          AppEnv.AppDb.TransConnection.StartTransaction;

          if ImportData(data.A['Lines'],Config.O['Mapping'],msg) then begin
            AppEnv.AppDb.TransConnection.Commit;
          end
          else begin
            Err(msg);
            AppEnv.AppDb.TransConnection.Rollback;
            exit;
          end;

        finally
          AppEnv.UtilsClient.Disconnect;
        end;

      finally
        AppEnv.AppDb.TransConnection.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;
      end;

    finally
      CoUninitialize;
    end;

  finally
//    line.Free;
    data.Free;
  end;
  result := true;
end;

function TERPFileMapper.ProcessFile(aFileName, aMapName: string): boolean;
var
  stream: TFileStream;
begin
  Log('Processing file: ' + aFileName,ltDetail);
  fLastErrorType := meNone;
  result := false;
  try
    try
      stream := TFileStream.Create(aFileName,fmOpenRead);
      result := ProcessFile(stream,aMapName);
    finally
      stream.Free;
    end;
  except
    on e: exception do begin
      result := false;
      if Pos('Cannot open file',e.Message) > 0 then
        Err(e.Message,meTransient)
      else
        Err(e.Message);
    end;
  end;
end;

function TERPFileMapper.StringToCurrency(val: string;
  colDef: TJsonObject): double;
var
  fmt: TFormatSettings;
  s: string;
begin
  result := 0;
  if Trim(val) = '' then exit;

  fmt := TFormatSettings.Create;
  if colDef.StringExists('ThousandSeparator') then fmt.ThousandSeparator := colDef.S['ThousandSeparator'][1];
  if colDef.StringExists('DecimalSeparator') then fmt.DecimalSeparator := colDef.S['DecimalSeparator'][1];
  if colDef.StringExists('CurrencyString') then fmt.CurrencyString := colDef.S['CurrencyString'];
  s := val;
  if fmt.ThousandSeparator <> #0 then
    s := StringReplace(s,fmt.ThousandSeparator,'',[rfReplaceAll]);
  if fmt.CurrencyString <> '' then
    s := StringReplace(s,fmt.CurrencyString,'',[rfReplaceAll,rfIgnoreCase]);
  result := StrToFloat(s,fmt);
end;

function TERPFileMapper.ProcessFile(stream: TStream; aMapName: string): boolean;
var
  reader: TStreamReader;
begin
  fLastErrorType := meNone;
  try
    Config.Name := aMapName;
    Config.Load(Connection);
    reader := TStreamReader.Create(stream);
    try
      if SameText(Config.O['InputFile'].S['DataType'],'CSV') then
        result := ProcessCSVFile(reader)
      else begin
        result := false;
        Err('Could not process file, unknown file type: "' +
          Config.O['InputFile'].S['DataType'] + '"');
      end;

    finally
      reader.Free;
    end;
  except
    on e: exception do begin
      Err('Error processing file: ' + e.Message);
    end;
  end;
end;

end.
