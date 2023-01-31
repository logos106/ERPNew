unit ExportDataObj;

interface

uses
  BusObjBase, classes, CommonDbLib, JsonObject, JsonToBusObj, MyAccess,
  ErpDbComponents, db, TextFileObj, IntegerListObj;

type
  TExportProgressEvent = procedure (const desc: string; const RecNo, RecCount: integer) of object;
  TExportDataFormat = (dfJson, dfCSV);
  TDataExporter = class;
  TDataMapEvent = Procedure (const DataExporter : TDataExporter; Busobj :TMsBusobj;Map: TJsonObject;  EventValue: string) of object;

  TDataExporter = class(TObject)
  private
    fDataFormat: TExportDataFormat;
    fConnection: TErpConnection;
    fStopOnError: boolean;
    fOnProgress: TExportProgressEvent;
    fFailFileName: string;
    fActive: boolean;
    fMapping: TJsonObject;
    fColumnWidths: TIntegerList;
    fTestImport: boolean;
    fActionCanceled: boolean;
    fbImportInsertIfIdNotfound: Boolean;
    fbForceHeader: Boolean;
    fDataMapEvent: TDataMapEvent;
    fbReadNonMappedfields: Boolean;
    procedure SaveToStream(const aObjectClassName: string; TF:TTextfile;
      aID: integer = 0; ListDataset: TDataSet = nil);Overload;
    procedure SaveToStream(const aObjectClassName: string; Stream:TStream;
      aID: integer = 0; ListDataset: TDataSet = nil);Overload;
    function ImportData(Json: TJsonObject; aObjectClassName: string; msg: TStrings): boolean;
    procedure SaveJsonToStream(BusObj: TBusObjBase; json: TJsonObject;
      Cls: TPersistentClass; const aObjectclassName: string; aStream: TStream;
      aID: Integer=0; listDataset: TDataset=nil);
    function GetMapping: TJsonObject;
    procedure SetMapping(const Value: TJsonObject);
  public
    constructor Create;
    destructor Destroy; override;
    (*procedure ExportDataToStream(const aObjectClassName: string; TF:TTextfile;
      aID: integer = 0; ListDataset: TDataSet = nil);*)
    procedure ExportDataToFile(const aObjectClassName, aFileName: string;
      aID: integer = 0; ListDataset: TDataset = nil);
    function ImportDataFromFile(const aObjectClassName, aFileName: string; msg: TStrings): boolean;
    property DataFormat: TExportDataFormat read fDataFormat write fDataFormat;
    property Connection: TErpConnection read fConnection write fConnection;
    property StopOnError: boolean read fStopOnError write fStopOnError;
    property OnProgress: TExportProgressEvent read fOnProgress write fOnProgress;
    procedure DoProgress(const desc: string; const RecNo, RecCount: integer);
    property FailFileName: string read fFailFileName;
    property Mapping: TJsonObject read GetMapping write SetMapping;
    property ColumnWidths: TIntegerList read fColumnWidths;
    property Active: boolean read fActive write fActive;
    property ActionCanceled: boolean read fActionCanceled write fActionCanceled;
    property TestImport: boolean read fTestImport write fTestImport;
    Property ImportInsertIfIdNotfound :Boolean read fbImportInsertIfIdNotfound write fbImportInsertIfIdNotfound;
    Property ForceHeader : Boolean read fbForceHeader write fbForceHeader;
    Property DataMapEvent : TDataMapEvent read fDataMapEvent write fDataMapEvent;
    Property ReadNonMappedfields :Boolean read fbReadNonMappedfields write fbReadNonMappedfields;
  end;

implementation

uses
  Windows,sysutils, BusObjNDSBase,
  CSVParserObj, BusObjImportDataMap, ImportDataMappingConst, Character,
  DateTimeUtils, LogThreadLib, StringUtils, UtilsLib, BusObjConst;

const
  QUOTE_CHAR = '"';
  SEP_CHAR = ',';


(*
Mapping example:

{
  "FirstLineHeadings":true,
  "SeparationType":"Seperated",
  "SeparatorValue":",",
  "TextDelimiter":"\"",
  "Columns":[
    {
    "Width":0,
    "Example":"true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true",
    "FieldName":"Active",
    "MapToField":"Active",
    "DataType":"True/False",
    "Format":"true\/false"
    },
    {
    "Width":0,
    "Example":"\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"",
    "FieldName":"Area",
    "MapToField":"Area",
    "DataType":"Text",
    "Format":""
    },
    {
    "Width":0,
    "Example":"\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\",\"Inventory Asset\"",
    "FieldName":"AssetAccount",
    "MapToField":"AssetAccount",
    "DataType":"Text",
    "Format":""
    }
  ]
}

*)

function GetFileLineCount(const aFileName: string; var count: integer; var msg: string): boolean;
var
  f: TextFile;
  s: string;
  SaveFileMode: byte;
begin
  result:= true;
  count:= 0;
  if FileExists(aFileName) then begin
    SaveFileMode := FileMode;
    FileMode:= 1;
    AssignFile(f, aFileName);
    try
      try
        Reset(f);
      except
        on e1 : exception do begin
          try
            Reset(f);
          except
            on e2 : exception do begin
              result:= false;
              msg:= 'Unable to open the file "' + aFileName + '", check that you dont''t have it open with another program eg spread sheet';
              exit;
            end;
          end;
        end;
      end;
      while not Eof(f) do begin
        ReadLn(f,s);
        Inc(count);
      end;
    finally
      try
        CloseFile(f);
      except

      end;
      FileMode:= SaveFileMode;
    end;
  end;
end;

function ParseCSVLine(const line: string; errList, headerList: TStringList; Json: TJsonObject): boolean; overload;
var
  x: integer;
  elementNo: integer;
  inString: boolean;
  val: string;

  function AddElement(const IsString: boolean): boolean;
  var dt: TdateTime;
  begin
    result:= true;
    try
      if elementNo < headerList.Count then begin
        if IsString then begin
          Json.S[headerList[elementNo]]:= val;
        end
        else begin
          if val = '' then Json.S[headerList[elementNo]]:= ''
          else if (Lowercase(val) = 'true') then Json.B[headerList[elementNo]]:= true
          else if (Lowercase(val) = 'false') then Json.B[headerList[elementNo]]:= false
          else begin
            try
              Json.F[headerList[elementNo]]:= StrToFloat(Val);
            except
              { might be a date/time field}
              try
                dt:= StrToDateTime(val);
                Json.S[headerList[elementNo]]:= FormatDateTime(JsonDateTimeFormat,dt);
              except
                { just bring in as string (Excel strips quotes) }
                try
                  Json.S[headerList[elementNo]]:= val;
                except
                  result:= false;
                  errList.Add('Error converting column "' + headerList[elementNo] +
                    '" + containing value "' + val + '", unknown format.');
                end;
              end
            end;
          end;
        end;
      end
      else begin
        result:= false;
        errList.Add('Column position (' + IntToStr(elementNo + 1) +
          ') is greater than the total number of header columns (' +
          IntToStr(headerList.Count) + ').');
      end;
      Inc(elementNo);
    except
      on e: exception do begin
        result:= false;
        errList.Add('Error while converting column "' + headerList[elementNo] +
          '" + containing value "' + val + '" with message: ' + e.Message);

      end;
    end;
  end;

begin
  result:= true;
  if Length(line) > 0 then begin
    elementNo:= 0;
    inString:= false;
    val:= '';
    x:= 1;
    while x <= Length(line) do begin
      if inString and (line[x] = '\') then begin
       { escape char }
        case Ord(line[x+1]) of
          34: begin
                val:= val + '"';
                Inc(x,2);
              end;
          92: begin
                val:= val + '\';
                Inc(x,2);
              end;
          47: begin
                val:= val + '/';
                Inc(x,2);
              end;
          98: begin                        // backspace
                val:= val + Chr(8);
                Inc(x,2);
              end;
          102: begin                       // form feed
                val:= val + Chr(12);
                Inc(x,2);
              end;
          110: begin                       // new line
                val:= val + Chr(10);
                Inc(x,2);
              end;
          114: begin                      // carriage return
                val:= val + Chr(13);
                Inc(x,2);
              end;
          116: begin                      // horizontal tab
                val:= val + Chr(09);
                Inc(x,2);
              end;
          else
            val:= val + line[x];
        end;
      end
      else if line[x] = SEP_CHAR then begin
        if inString then begin
          val:= val + line[x];
          inc(x);
        end
        else begin
          if not AddElement(false) then begin
            result:= false;
            exit;
          end;
          val:= '';
          inc(x);
        end;
      end
      else if line[x] = QUOTE_CHAR then begin
        if inString then begin
          if not AddElement(true) then begin
            result:= false;
            exit;
          end;
          inString:= false;
          inc(x);
          val:= '';
          while (x <= Length(line)) and (line[x] <> SEP_CHAR) do
            inc(x);
          if line[x] = SEP_CHAR then
            inc(x);
        end
        else begin
          inString:= true;
          inc(x);
        end;
      end
      else begin
        val:= val + line[x];
        inc(x);
      end;
    end;
    { add the last column }
    if (elementNo < headerList.Count) then begin
      if not AddElement(false) then begin
        result:= false;
        exit;
      end;
    end;
  end;
end;

function ParseCSVLine(const line: string; Map: TJsonObject; ColWidths: TIntegerList; errList: TStringList; Json: TJsonObject; ReadNonMappedfields :Boolean): boolean; overload;
var
  values: TStringList;
  msg: string;
  x: integer;
  o: TJsonObject;
  TextDelim: string;
  val: string;
  format: string;

  function TrimTextDelim(str: string): string;
  var s: string;
  begin
    if TextDelim <> '' then  begin
      s:= Trim(str);
      if (Copy(s,1,Length(TextDelim)) = TextDelim) and (Copy(s,Length(s)-Length(TextDelim)+1,Length(TextDelim)) = TextDelim) then
        result:= Copy(s,1+Length(TextDelim),Length(s) - (2* Length(TextDelim)))
      else
      result:= str;
    end
    else
      result:= str;
  end;

  function FixMinsFormat(str: string): string;
  var
    x: integer;
    timepart: string;
  begin
    result:= str;
    x:= Pos(':',result);
    if x > 0 then begin
      Dec(x);
      if (x-1 >1) and CharInSet(ToLower(result[x-1]),['h','m','n','s']) then
        Dec(x);
      timepart:= Copy(result,x,Length(result));
      timepart:= StringReplace(timepart,'mm','nn',[rfIgnoreCase]);
      result:= Copy(result,1,x-1) + timepart;
    end;
  end;

  function StringToInt(str: string): integer;
  begin
    if str = '' then result:= 0
    else result:= StrToInt(str);
  end;

//  function StringToFloat(str: string): extended;
//  begin
//    if str = '' then result:= 0
//    else result:= StrToFloat(str);
//  end;
begin
  result:= true;
  values:= TStringList.Create;
  o:= nil;
  try
    TextDelim:= Map.S['TextDelimiter'];
    if Map.S['SeparationType'] = SeparationType_Seperated then begin
      if not CSVParserObj.ParseLine(line,Map.S['SeparatorValue'],TextDelim,values,msg,false) then begin
        errList.Add(msg);
        result:= false;
        exit;
      end;
    end
    else if Map.S['SeparationType'] = SeparationType_Fixed then begin
      if not CSVParserObj.ParseLine(line,ColWidths,values,msg) then begin
        errList.Add(msg);
        result:= false;
        exit;
      end;
    end;

    try
      { now map the values to json ... }
      for x := 0 to Map.A['Columns'].Count -1 do begin
        o:= Map.A['Columns'].Items[x].AsObject;
        val:= TrimTextDelim(values[x]);
        if (o.S['MapToField'] <> '') then begin
          { map this field }
          if o.S['DataType'] = FieldType_Text then
            Json.S[o.S['MapToField']]:= Val
          else if o.S['DataType'] = FieldType_Float then
            Json.F[o.S['MapToField']]:= StringUtils.StringToFloat(StringUtils.StripQuotes(val))
          else if o.S['DataType'] = FieldType_Integer then
            Json.I[o.S['MapToField']]:= StringToInt(StringUtils.StripQuotes(val))
          else if o.S['DataType'] = FieldType_Boolean then begin
            format:= o.S['Format'];
            if format = Format_Bool_TrueFalse then
              Json.B[o.S['MapToField']]:= Lowercase(val) = 'true'
            else if format = Format_Bool_TF then
              Json.B[o.S['MapToField']]:= Lowercase(val) = 't'
            else if format = Format_Bool_YesNo then
              Json.B[o.S['MapToField']]:= Lowercase(val) = 'yes'
            else if format = Format_Bool_YN then
              Json.B[o.S['MapToField']]:= Lowercase(val) = 'y'
            else begin
              if format = '' then
                errList.Add('Error converting field "' + o.S['MapToField'] +
                  '" + containing value "' + val + '" of type "True/False", format is blank.')
              else
                errList.Add('Error converting field "' + o.S['MapToField'] +
                  '" + containing value "' + val + '" of type "True/False", unknown format: "' + format + '".');
              result:= false;
              exit;
            end
          end
          else if o.S['DataType'] = FieldType_DateTime then begin
            format:= o.S['Format'];
            if format = '' then begin
              errList.Add('Error converting field "' + o.S['MapToField'] +
                '" + containing value "' + val + '" of type "Date/Time", format is blank.');
              result:= false;
              exit;
            end;
            if val = '' then
              Json.DT[o.S['MapToField']]:= 0
            else begin
              try
                Json.DT[o.S['MapToField']]:= StrToDateTimeFmt(FixMinsFormat(format),val);
              except
                on e: exception do begin
                  errList.Add('Error converting field "' + o.S['MapToField'] +
                    '" + containing value "' + val + '" of type "Date/Time": ' + e.Message);
                  result:= false;
                  exit;
                end;
              end;
            end;
          end;
        end else begin
          if ReadNonMappedfields then Json.S[o.S['FieldName']]:= Val
        end;
      end;
    except
      on e: exception do begin
        if Assigned(o) then
          errList.Add('Error converting field "' + o.S['MapToField'] +
            '" + containing value "' + val + '" of type "'+o.S['DataType']+'": ' + e.Message)
        else
          errList.Add('Error converting field: ' + e.Message);
        result:= false;
      end;
    end
  finally
    values.Free;
  end;
end;



function IsClassParent(const aClass, aParent: TClass): boolean;
var ClassRef: TClass;
begin
  result:= false;
  ClassRef:= aClass;
  while ClassRef <> nil do begin
    if ClassRef = aParent then begin
      result:= true;
      break;
    end;
    ClassRef:= ClassRef.ClassParent;
  end;
end;


{ TDataExporter }

constructor TDataExporter.Create;
begin
  ReadNonMappedfields := False;
  fDataMapEvent := nil;
  fDataFormat:= dfCSV;
  fActive:= false;
  fColumnWidths:= TIntegerList.Create;
  fTestImport:= false;
  fActionCanceled:= false;
  fbImportInsertIfIdNotfound := False;
  fbForceHeader := False;
end;

destructor TDataExporter.Destroy;
begin
  fColumnWidths.Free;
  inherited;
end;

procedure TDataExporter.DoProgress(const desc: string; const RecNo,
  RecCount: integer);
begin
  if Assigned(fOnProgress) then
    fOnProgress(desc,RecNo,RecCount);
end;

procedure TDataExporter.ExportDataToFile(const aObjectClassName,
  aFileName: string; aID: integer = 0; ListDataset: TDataset = nil);
var
  TF:TTextfile;
  stream: TFileStream;
begin
if DataFormat= dfJSON then begin
  fFailFileName:= '';
  if FileExists(aFileName) then
    DeleteFile(aFileName);
  stream:= TFileStream.Create(aFileName, fmCreate);
  try
    SaveToStream(aObjectClassName,stream,aID, ListDataset);
  finally
    stream.Free;
  end;
end else begin
  fFailFileName:= '';
  if FileExists(aFileName) then
    DeleteFile(aFileName);
  TF:=TTextfile.create(aFileName, tfmCreate);
  try
    SaveToStream(aObjectClassName,TF,aID, ListDataset);
  finally
    Freeandnil(TF);
  end;
end;
end;

function TDataExporter.GetMapping: TJsonObject;
begin
  result:= fMapping;
end;

(*procedure TDataExporter.ExportDataToStream(const aObjectClassName: string;
  TF:TTextfile; aID: integer = 0; ListDataset: TDataSet = nil);
begin
  SaveToStream(aObjectClassName,TF,aID, ListDataSet);
end;*)

function TDataExporter.ImportData(Json: TJsonObject;
  aObjectClassName: string; msg: TStrings): boolean;
var
  Cls: TPersistentClass;
  BusObj: TBusObjBase;
  conn, tmpConn: TERPConnection;
  SavePointName: string;
  cmd: TMyCommand;
  objUserName: string;

  procedure StartTrans;
  begin
    if Assigned(tmpConn) then tmpConn.StartTransaction
    else begin
      cmd:= TMyCommand.Create(nil);
      try
        cmd.Connection:= fConnection;
        SavePointName:= aObjectClassName + IntToStr(Integer(BusObj));
        cmd.SQL.Text:= 'SAVEPOINT ' + SavePointName;
        cmd.Execute;
      finally
        cmd.Free;
      end;
    end;
  end;

  procedure CommitTrans;
  begin
    if Assigned(tmpConn) then begin
      if TestImport then
        tmpConn.Rollback
      else
        tmpConn.Commit;
    end
    else begin
      cmd:= TMyCommand.Create(nil);
      try
        cmd.Connection:= fConnection;
        if TestImport then
          cmd.SQL.Text:= 'ROLLBACK TO SAVEPOINT ' + SavePointName
        else
          cmd.SQL.Text:= 'RELEASE SAVEPOINT ' + SavePointName;
        try
          cmd.Execute;
        except
        end;
      finally
        cmd.Free;
      end;
    end;
  end;

  procedure RollbackTrans;
  begin
    if Assigned(tmpConn) then tmpConn.Rollback
    else begin
      cmd:= TMyCommand.Create(nil);
      try
        cmd.Connection:= fConnection;
        cmd.SQL.Text:= 'ROLLBACK TO SAVEPOINT ' + SavePointName;
        try
          cmd.Execute;
        except
        end;
      finally
        cmd.Free;
      end;
    end;
  end;

begin
  result:= true;
  Conn := nil;
  try
    objUserName:= aObjectClassName;
    Cls := FindClass(aObjectClassName);
    if Assigned(Cls) then begin
      if IsClassParent(Cls, TBusObjBase) then begin
        BusObj:= TBusObjBaseClass(Cls).Create(nil);
        BusObj.SilentMode:= true;
        if BusObj is TMSBusObj then
        if Assigned(fConnection) then begin
          Conn:= fConnection;
        end
        else begin
          tmpConn:= CommonDbLib.GetNewMyDacConnection(nil);
          conn:= tmpConn;
        end;
        try
          if BusObj is TDatasetBusObj then begin
            TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
            TDatasetBusObj(BusObj).Connection.Connection:= conn;
            objUserName:= TDatasetBusObj(BusObj).ObjectUserName;
            TDatasetBusObj(BusObj).ExportExcludeList.Add('globalref');
            if Json.IntegerExists('id') and (Json.I['id'] > 0) then
            try
              TDatasetBusObj(BusObj).ExportExcludeList.Add(Lowercase(TDatasetBusObj(BusObj).GetKeyStringField));
            except
            end;
          end
          else if BusObj is TBusObjNDS then begin
            TBusObjNDS(BusObj).Storer.Connection:= conn;
            objUserName:= TBusObjNDS(BusObj).ObjectUserName;
          end;
          StartTrans;
          try
            BusObj.ResultStatus.Clear;
            if JsonToBusObject(Json,BusObj,msg, ImportInsertIfIdNotfound, ReadNonMappedfields) then begin
              if not BusObj.ResultStatus.OperationOk then begin
                result:= false;
                BusObj.ResultStatus.ReadMessages(msg);
                RollbackTrans;
                exit;
              end;
              BusObj.ResultStatus.ReadMessages(msg);
              BusObj.ResultStatus.Clear;

              if BusObj is TMSBusobj then
                if assigned(fDataMapEvent) then fDataMapEvent(Self ,TMSBusobj(BusObj) ,Json ,  BusObjEventVal_OnBeforeSave);

              if not BusObj.Save then begin
                result:= false;
                BusObj.ResultStatus.ReadMessages(msg);
                RollbackTrans;
                exit;
              end;
              BusObj.ResultStatus.ReadMessages(msg);
              CommitTrans;
            end
            else begin
              result:= false;
              RollbackTrans;
            end;
          except
            on e: exception do begin
              result:= false;
              RollbackTrans;
              msg.Add('Import failed for "' + objUserName + '" with message: ' + e.Message);
            end;
          end;
        finally
          BusObj.Free;
          if Assigned(tmpConn) then begin
            tmpConn.Free;
          end;
        end;
      end;
    end
    else begin
      result:= false;
      msg.Add('Could not find business object type "' + aObjectClassName + '".');
    end;
  except
    on e: exception do begin
      result:= false;
      msg.Add('Import failed for "' + aObjectClassName + '" with message: ' + e.Message);
    end;
  end;
end;

{$I-}
function TDataExporter.ImportDataFromFile(const aObjectClassName,
  aFileName: string; msg: TStrings): boolean;
var
  inJson, failJson: TJsonObject;
  x, i: integer;
  sl, headerList: TStringList;
  line, headerLine: string;
  failFile: TextFile;
  F: Textfile;
  failFileOpen: boolean;
  lineCount: integer;
  aMsg: string;

  procedure WriteLineToFail(const lineStr: string);
  begin
    if not failFileOpen then begin
      fFailFileName:= ChangeFileExt(aFileName, '_1' +  ExtractFileExt(aFileName));
      Assign(failFile,fFailFileName);
      Rewrite(failFile);
      if headerList.Count > 0 then
        WriteLn(failFile,headerLine);
      failFileOpen:= true;
    end;
    WriteLn(failFile,lineStr);
  end;

begin
  fActive:= true;
  fActionCanceled:= false;
  result:= true;
  failFileOpen:= false;
  fFailFileName:= '';
  sl:= TStringList.Create;
  try
    if DataFormat = dfJson then begin
      inJson:= TJsonObject.Create;
      failJson:= TJsonObject.Create;
      try
        inJson.LoadFromFile(aFileName);
        for x:= 0 to inJson.Count -1 do begin
          DoProgress('Importing ...',x+1,inJson.Count);
          sl.Clear;
          if not ImportData(inJson.Items[x].Value.AsObject,aObjectClassName, sl) then begin
            result:= false;
            msg.Add('Failed importing item  ' + IntToStr(x) + '  (' + inJson.Items[x].Name + ')');
            for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
            failJson.Add(inJson.Items[x]);
            if fStopOnError then
              exit;
          end
          else begin
            if SL.Count > 0 then begin
              msg.Add('Messages while importing item  ' + IntToStr(x) + '  (' + inJson.Items[x].Name + ')');
              for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
            end;
          end;
        end;
        if failJson.Count > 0 then begin
          failJson.SaveToFile(ChangeFileExt(aFileName, '_fail' +  ExtractFileExt(aFileName)));
        end;
      finally
        failJson.Free;
        inJson.Free;
      end;
    end
    else if DataFormat = dfCSV then begin
      inJson:= TJsonObject.Create;
      try
        if not GetFileLineCount(aFileName, linecount, aMsg) then begin
          result:= false;
          msg.Add(aMsg);
          exit;
        end;
        AssignFile(F, AFileName);
        Reset(F);
        headerList:= TStringList.Create;
        try
          headerList.Delimiter:= SEP_CHAR;
          x:= 0;
          while not EOF(F) do begin
            DoProgress('Importing ...',x+1,lineCount);
            if not fActive then begin
              fActionCanceled:= true;
              break;
            end;
            ReadLn(F, Line);
            if ((x = 0) and Assigned(Mapping) and (Mapping.B['FirstLineHeadings'])) or (not Assigned(Mapping) and  (x = 0)) then begin
              headerLine:= Line;
              headerList.DelimitedText:= headerLine;
            end
            else begin
              inJson.Clear;
              sl.Clear;
              if Assigned(Mapping) then begin
                if ParseCSVLine(Line, Mapping, ColumnWidths,  sl, inJson  , ReadNonMappedfields) then begin
                  if not ImportData(inJson,aObjectClassName, sl ) then begin
                    result:= false;
                    msg.Add('Failed importing line  ' + IntToStr(x+1));
                    for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                    WriteLineToFail(Line);
                    if fStopOnError then
                      exit;
                  end
                  else begin
                    if sl.Count > 0 then begin
                      msg.Add('Messages while importing line  ' + IntToStr(x+1));
                      for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                    end;
                  end;
                end
                else begin
                  result:= false;
                  msg.Add('Failed importing line:  ' + IntToStr(x));
                  for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                  WriteLineToFail(Line);
                  if fStopOnError then
                    exit;
                end;
              end
              else begin
                if ParseCSVLine(Line, sl, headerList, inJson) then begin
                  if not ImportData(inJson,aObjectClassName, sl) then begin
                    result:= false;
                    msg.Add('Failed importing line  ' + IntToStr(x+1));
                    for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                    WriteLineToFail(Line);
                    if fStopOnError then
                      exit;
                  end
                  else begin
                    if sl.Count > 0 then begin
                      msg.Add('Messages while importing line  ' + IntToStr(x+1));
                      for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                    end;
                  end;
                end
                else begin
                  result:= false;
                  msg.Add('Failed importing line:  ' + IntToStr(x));
                  for i:= 0 to sl.Count -1 do msg.Add('    ' + sl[i]);
                  WriteLineToFail(Line);
                  if fStopOnError then
                    exit;
                end;
              end;
            end;
            Inc(x);
          end;
        finally
          CloseFile(F);
          headerList.Free;
          if failFileOpen then
            CloseFile(failFile);
        end;
      finally
        inJson.Free;
      end;
    end;
  finally
    sl.Free;
    fActive:= false;
  end;
end;
{$I+}

Procedure TDataExporter.SaveJsonToStream(BusObj: TBusObjBase;json :TJsonObject; Cls: TPersistentClass;  const aObjectclassName:string; aStream :TStream; aID :Integer =0 ; listDataset:TDataset = nil);
var
  writer: TStreamWriter;
  ds: TDataset;
begin
  writer:= TStreamWriter.Create(aStream);
              try
              if aId > 0 then begin
                BusObj.Load(aId, true);
                BusObjectToJson(BusObj,json,fDataFormat = dfJson,self);
              end
              else if not Assigned(ListDataset) then begin
                BusObj.Load(true);
                BusObjectToJson(BusObj,json,fDataFormat = dfJson,self);
              end
              else begin
                ds:= ListDataset;
                ds.First;
                while not ds.Eof do begin
                  if not fActive then begin
                    fActionCanceled:= true;
                    break;
                  end;
                  DoProgress('Exporting ...',ds.RecNo,ds.RecordCount);
                  json.Clear;
                  BusObj.Free;
                  BusObj:= TBusObjBaseClass(Cls).Create(nil);
                  BusObj.SilentMode:= true;
                  TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
                  TDatasetBusObj(BusObj).Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
                  BusObj.Load(ds.FieldByName(TDatasetBusObj(BusObj).GetIDField).AsInteger, true);
                  BusObjectToJson(BusObj,json.O[aObjectClassName + '_' + IntToStr(ds.RecNo)],true,self);
                  ds.Next;
                end;
              end;
              json.Write(writer);
              finally
                writer.Free;
              end;
end;
procedure TDataExporter.SaveToStream(const aObjectClassName: string;
  Stream: TStream; aID: integer; ListDataset: TDataSet);
var
  Cls: TPersistentClass;
  BusObj: TBusObjBase;
  json: TJsonObject;
begin
  fActive:= true;
  fActionCanceled:= false;
  try
    Cls := FindClass(aObjectClassName);
    if Assigned(Cls) then begin
      if IsClassParent(Cls, TBusObjBase) then begin
        BusObj:= TBusObjBaseClass(Cls).Create(nil);
        try
          BusObj.SilentMode:= true;
          if BusObj is TDatasetBusObj then begin
            TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
            TDatasetBusObj(BusObj).Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
          end;
          json:= TJsonObject.Create;
          try
              SaveJsonToStream(BusObj, json, Cls , aObjectClassName,Stream, aID,ListDataset);
          finally
            json.Free;
          end;
        finally
          BusObj.Free;
        end;
      end;
    end;
  finally
    fActive:= false;
  end;
end;

procedure TDataExporter.SetMapping(const Value: TJsonObject);
var
  x: integer;
  o: TJsonObject;
begin
  fMapping:= Value;
  { get column widths }
  fColumnWidths.Clear;
  for x := 0 to Mapping.A['Columns'].Count -1 do begin
    o:= Mapping.A['Columns'].Items[x].AsObject;
    fColumnWidths.Add(o.I['Width']);
  end;

end;

procedure TDataExporter.SaveToStream(const aObjectClassName: string;
  TF:TTextfile; aID: integer = 0; ListDataset: TDataSet = nil);
var
  Cls: TPersistentClass;
  BusObj: TBusObjBase;
  json, jsonItem: TJsonObject;
  objIdx: integer;
  headerDone: boolean;
  qry: TMyQuery;
  ds: TDataset;
  SQLWhere: string;
  WherePos: integer;
  (*writer: TStreamWriter;*)

  procedure WriteHeader(Jobj: TJsonObject);
  var
    s: string;
    x: integer;
    fs:String;
  begin
    for x:= 0 to Jobj.Count -1 do begin
      if Jobj.Items[x].ValueType <> valObject then begin
        fs:=Jobj.Items[x].Name;
        if not (Sametext(fs , 'ISEmpty') or Sametext(fs , 'KeyValue') or Sametext(fs , 'MsTimeStamp') or Sametext(fs , 'MsUpdateSiteCode')) then begin
          if s <> '' then s:= s + ',';
          s:= s + fs;
        end;
      end;
    end;
    if s <> '' then (*writer.WriteLine(s)*)TF.WriteLine(s);
  end;

  procedure WriteData(Jobj: TJsonObject);
  var
    s: string;
    x: integer;
    fs:String;
  begin
    for x:= 0 to Jobj.Count -1 do begin
      fs:=Jobj.Items[x].Name;
      if  Sametext(fs , 'ISEmpty') or
          Sametext(fs , 'KeyValue') or
          Sametext(fs , 'MsTimeStamp') or
          Sametext(fs , 'MsUpdateSiteCode') then else begin
        if Jobj.Items[x].ValueType <> valObject then begin
          if s <> '' then s:= s + ',';
          case Jobj.Items[x].ValueType of
            valNone,
            valObject,
            valArray,
            valNull: ;
//            valString: s:= s + '"' + EncodeString(Jobj.Items[x].Value.AsString) + '"';
            { 2017-1-05 Removed encoding, should be right to export string as long as it is quoted }
            valString: s:= s + '"' + Jobj.Items[x].Value.AsString + '"';
            valBoolean,
            valNumber: s:= s + Jobj.Items[x].Value.AsString;
          end;
        end;
      end;
    end;
    if s <> '' then (*writer.WriteLine(s)*)TF.WriteLine(s);
  end;

begin
  fActive:= true;
  fActionCanceled:= false;
  (*writer:= TStreamWriter.Create(aStream);*)
  try
    Cls := FindClass(aObjectClassName);
    if Assigned(Cls) then begin
      if IsClassParent(Cls, TBusObjBase) then begin
        BusObj:= TBusObjBaseClass(Cls).Create(nil);
        try
          BusObj.SilentMode:= true;
          if BusObj is TDatasetBusObj then begin
            TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
            TDatasetBusObj(BusObj).Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
          end;
          json:= TJsonObject.Create;
          try
            BusObj.isreadonly := True;
            if fDataFormat = dfJson then begin
              SaveJsonToStream(BusObj, json, Cls , aObjectClassName,nil, aID,ListDataset);
            end
            else if fDataFormat = dfCSV then begin
              { write the lines out }
              if BusObj is TDatasetBusObj then begin
                qry:= TMyQuery.Create(nil);
                try
                  if Assigned(ListDataset) then
                    ds:= ListDataset
                  else begin
                    SQLWhere := '';
                    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
//                    WherePos := Pos('where', Lowercase(TDatasetBusObj(BusObj).Dataset.SQL.Text));
                    WherePos := Pos('where', Lowercase(TDatasetBusObj(BusObj).SQL));
                    if WherePos > 0 then
//                      SQLWhere := Copy(Lowercase(TDatasetBusObj(BusObj).Dataset.SQL.Text),WherePos,Length(Lowercase(TDatasetBusObj(BusObj).Dataset.SQL.Text)));
                      SQLWhere := Copy(Lowercase(TDatasetBusObj(BusObj).SQL),WherePos,Length(Lowercase(TDatasetBusObj(BusObj).SQL)));
                    if trim(TDatasetBusObj(BusObj).GetBusObjectTablename) <> '' then
                      qry.SQL.Add('select distinct ' + TDatasetBusObj(BusObj).IDFieldName +' from ' + TDatasetBusObj(BusObj).GetBusObjectTablename);
                    if aId > 0 then
                      qry.SQL.Add('where ' + TDatasetBusObj(BusObj).IDFieldName +
                        ' = ' + IntToStr(aId))
                    else if SQLWhere <> '' then
                      qry.SQL.Add(SQLWhere);

                    qry.Open;
                    ds:= qry;
                  end;
                  headerDone:= false;
                  ds.First;
                  while not(ds.EOF) or ((headerDone =False) and (forceheader)) do begin
                    if not fActive then begin
                      fActionCanceled:= true;
                      break;
                    end;
                    DoProgress('Exporting ...',ds.RecNo,ds.RecordCount);
                    json.Clear;
                    BusObj.Free;
                    BusObj:= nil;
                    BusObj:= TBusObjBaseClass(Cls).Create(nil);
                    BusObj.SilentMode:= true;
                    TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
                    if (ds is TERPQuery) and (TERPQuery(ds).connection is TERPConnection) then
                         TDatasetBusObj(BusObj).Connection.Connection:= TERPQuery(ds).connection
                    else TDatasetBusObj(BusObj).Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;

                    BusObj.Load(ds.FieldByName(TDatasetBusObj(BusObj).GetIDField).AsInteger, true);
                    BusObjectToJson(BusObj,json,fDataFormat = dfJson,self , ((headerDone =False) and (forceheader)));
                    for objIdx:= 0 to json.Count -1 do begin
                      if json.Items[objIdx].ValueType = valObject then begin
                        jsonItem:= json.Items[objIdx].Value.AsObject;
                        if not headerDone then begin
                          headerDone:= true;
                          WriteHeader(jsonItem);
                        end;
                        (*if ds.recordcount >0 then *)WriteData(jsonItem);
                      end;
                    end;
                    ds.Next;
                  end;
                finally
                  qry.Free;
                end;
              end
              else begin
                if aId > 0 then
                  BusObj.Load(aId, true)
                else
                  BusObj.Load(true);
                BusObjectToJson(BusObj,json,fDataFormat = dfJson,self);
                for objIdx:= 0 to json.Count -1 do begin
                  if json.Items[objIdx].ValueType = valObject then begin
                    jsonItem:= json.Items[objIdx].Value.AsObject;
                    if objIdx = 0 then WriteHeader(jsonItem);
                    WriteData(jsonItem);
                  end;
                end;
              end;
            end;
          finally
            json.Free;
          end;
        finally
          BusObj.Free;
        end;
      end;
    end;
  finally
    fActive:= false;
    (*writer.Free;*)
  end;
end;

end.
