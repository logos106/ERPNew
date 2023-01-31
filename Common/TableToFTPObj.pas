unit TableToFTPObj;

interface

uses
  LogThreadBase, LogMessageTypes, ERPDbComponents, IdFTP, Classes, Contnrs,
  AbZipper, AbZipKit, AbBase, AbBrowse, AbZBrows, AbArcTyp, IdHTTP,FiletoFTP;

type

  TFieldList = class;

  TTableToFTP = class(TFileToFTP)
  private
    fConnection: TERPConnection;
    AbZipKit: TAbZipKit;
    fileList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    property Connection: TERPConnection read fConnection write fConnection;
    function Upload(aTableName: string; sqlSelect: string = ''; SingleFile: boolean = false): boolean;
    function Download(aTableName: string; sqlSelect: string = ''): boolean;
  end;

  TBasicFieldType = (ftString, ftInteger, ftFloat, ftBool, ftDateTime, ftDate, ftTime);

  TFieldListRec = class(TObject)
  private
    fName: string;
    fBasicType: TBasicFieldType;
  public
    property Name: string read fName write fName;
    property BasicType: TBasicFieldType read fBasicType write fBasicType;
  end;

  TFieldList = class(TObject)
  private
    fLIst: TObjectList;
    function GetCount: integer;
    function GetItem(idx: integer): TFieldListRec;
    function GetFieldCommaList: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[idx: integer]: TFieldListRec read GetItem; default;
    procedure Add(aFieldName: string; aMySQLFieldType: string);
    property FieldCommaList: string read GetFieldCommaList;
  end;

implementation

uses
  SysUtils, StringUtils, DateUtils, DbSharedObjectsObj, JsonObject,
  JsonToDatasetFuncs, CipherUtils, SystemLib, IdFtpCommon, Windows, DB,
  UpdaterConst, ERPFTPConst, HTTPConst;

  { NOTE: File name formar: [TableName]_yyyymmddhhnnss.[ext] }

function NameToDateTime(aFileName: string): TDateTime;
var
  s: string;
  dtStr: string;
  x: integer;
begin
  result := 0;
  dtStr := '';
  s:= ChangeFileExt(ExtractFileNAme(aFileName), '');
  for x := Length(s) downto 1 do begin
    if CharInSet(s[x], ['0'..'9']) then
      dtStr := s[x] + dtStr
    else
      break;
  end;
  if Length(dtStr) <> 14 then
    exit;
  { yyyymmddhhnnss }
  result := EncodeDateTime(
    StrToInt(Copy(dtStr,1,4)),
    StrToInt(Copy(dtStr,5,2)),
    StrToInt(Copy(dtStr,7,2)),

    StrToInt(Copy(dtStr,9,2)),
    StrToInt(Copy(dtStr,11,2)),
    StrToInt(Copy(dtStr,13,2)),
    0);
end;


{ TTableToFTP }

constructor TTableToFTP.Create;
begin
  fileList := TStringList.Create;
end;

destructor TTableToFTP.Destroy;
begin
  fileList.Free;
  AbZipKit.Free;
  inherited;
end;

function TTableToFTP.Download(aTableName, sqlSelect: string): boolean;
var
  DispName: string;
  x, y, z: integer;
  dt, FtpMaxDt, TableMaxDt: TDateTime;
  qry, qryIdx: TERPQuery;
  FieldList: TFieldList;
  json, rec: TJsonObject;
  fileName: string;
  Stream: TFileStream;
  UpdateFieldList: TStringList;
  InsertVals, UpdateVals: string;
  IsUpdateField: boolean;
  pair: TJsonValuePair;
  sl: TStringList;
begin
  result := true;
  DispName := aTableName;
  if Pos('tbl',Lowercase(DispName)) = 1 then
    DispName := Copy(DispName,4,Length(DispName));
  DispName := SeparateWords(DispName);
  Log('Checking ' + DispName + ' for downloading ..',ltInfo);
  if not Assigned(Http) then begin
    Http := TIdHTTP.Create(nil);
    Http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  end;
  try
    try
      qry := DbSharedObj.GetQuery(Connection);
      qryIdx := DbSharedObj.GetQuery(Connection);
      json := JO;
      UpdateFieldList := TStringList.Create;
      FieldList := TFieldList.Create;
      sl := TStringList.Create;
      try
        { get the most recent update time .. }
        qry.SQL.Text := 'select Convert(Max(msTimeStamp),DateTime) as MaxMsTimeStamp from ' + aTableName;
        qry.Open;
        TableMaxDt := qry.FieldByName('MaxMsTimeStamp').AsDateTime;
        qry.Close;

        { find new files on ftp site }
        FtpMaxDt:= 0;
        fileList.Clear;
        sl.Text := Http.Get(TRUEERP_HTTP_SITE + FTP_DOCUMENT_PATH + 'list.php');
        for x := 0 to sl.Count -1 do begin
          if Pos(Lowercase(aTableName+'_'), Lowercase(sl[x])) > 0 then begin
            dt := NameToDateTime(sl[x]);
            if dt > TableMaxDt then
              fileList.Add(sl[x]);
          end;
        end;

        if fileList.Count > 0 then
          Log('Found ' + IntToStr(fileList.Count) + ' files to download',ltInfo)
        else begin
          Log('No new files found to download',ltInfo);
          exit;
        end;

        { we only want non-blob fields }
        qry.SQL.Text := 'describe ' + aTableName;
        qry.Open;
        qryIdx.SQL.Text := 'show indexes from  ' + aTableName;
        qryIdx.Open;
        while not qry.Eof do begin
          if Pos('blob',qry.FieldByName('Type').AsString) = 0 then begin
            FieldList.Add(qry.FieldByName('Field').AsString,qry.FieldByName('Type').AsString);
            if (not qryIdx.Locate('Column_name',qry.FieldByName('Field').AsString,[loCaseInsensitive])) or
               (qryIdx.FieldByName('Non_unique').AsInteger = 1) then
              UpdateFieldList.Add(qry.FieldByName('Field').AsString);
          end;
          qry.Next;
        end;
        qry.Close;
        qryIdx.Close;

        if not Assigned(AbZipKit) then begin
          AbZipKit := TAbZipKit.Create(nil);
          AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
          AbZipKit.BaseDirectory:= WinTempDir;
        end;

        { process the files .. }
        for x := 0 to FileList.Count -1 do begin
          Log('Downloading file ' + FileList[x], ltInfo);
          Stream := TFileStream.Create(WinTempDir + FileList[x], fmCreate);
          try
            Http.Get(TRUEERP_HTTP_SITE + FTP_DOCUMENT_PATH + FileList[x], Stream);
          finally
            Stream.Free;
          end;
          Log('File downloaded ..',ltInfo);
          Decrypt(WinTempDir + FileList[x], WinTempDir + ChangeFileExt(FileList[x],'.zip'));
          Log('File decrypted ..',ltInfo);
          SysUtils.DeleteFile(WinTempDir + FileList[x]);
          AbZipKit.OpenArchive(WinTempDir + ChangeFileExt(FileList[x],'.zip'));
          AbZipKit.ExtractFiles('*.*');
          Log('Archive extracted ..',ltInfo);
          AbZipKit.CloseArchive;
          SysUtils.DeleteFile(WinTempDir + ChangeFileExt(FileList[x],'.zip'));

          json.LoadFromFile(WinTempDir + ChangeFileExt(FileList[x],'.txt'));
          Log('File contains ' + IntToStr(json.A['list'].Count) + ' records to process', ltInfo);
//          Log('Database: '  + qry.Connection.Database, ltInfo);
          for y := 0 to json.A['list'].Count -1 do begin
            rec := json.A['list'].Items[y].AsObject;
            InsertVals := '';
            UpdateVals := '';
            for z := 0 to FieldList.Count -1 do begin
              pair := rec.ItemByName[FieldList[z].Name];
//              if not Assigned(pair) then
//                Continue;
              if InsertVals <> '' then InsertVals := InsertVals + ',';
              if UpdateFieldList.IndexOf(FieldList[z].Name) > -1 then begin
                IsUpdateField := true;
                if UpdateVals <> '' then UpdateVals := UpdateVals + ',';
              end
              else
                IsUpdateField := false;
              if Assigned(pair) then begin
                case FieldList[z].BasicType of
                  ftString:
                    begin
                      InsertVals := InsertVals + QuotedStr(pair.Value.AsString);
                      if IsUpdateField then
                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(pair.Value.AsString);
                    end;
                  ftInteger,
                  ftFloat:
                    begin
                      InsertVals := InsertVals + pair.Value.AsString;
                      if IsUpdateField then
                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + pair.Value.AsString;
                    end;
                  ftBool:
                    begin
                      if pair.Value.AsBoolean or SameText(pair.Value.AsString,'T') then begin
                        { true }
                        InsertVals := InsertVals + '"T"';
                        if IsUpdateField then
                          UpdateVals := UpdateVals + '`' + pair.Name + '`' + '="T"';
                      end
                      else begin
                        { false }
                        InsertVals := InsertVals + '"F"';
                        if IsUpdateField then
                          UpdateVals := UpdateVals + '`' + pair.Name + '`' + '="F"';
                      end;
                    end;
                  ftDateTime:
                    begin
                      InsertVals := InsertVals + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',pair.Value.AsDateTime));
                      if IsUpdateField then
                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',pair.Value.AsDateTime));
                    end;
                  ftDate:
                    begin
                      InsertVals := InsertVals + QuotedStr(FormatDateTime('yyyy-mm-dd',pair.Value.AsDateTime));
                      if IsUpdateField then
                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('yyyy-mm-dd',pair.Value.AsDateTime));
                    end;
                  ftTime:
                    begin
                      InsertVals := InsertVals + QuotedStr(FormatDateTime('hh:nn:ss',pair.Value.AsDateTime));
                      if IsUpdateField then
                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('hh:nn:ss',pair.Value.AsDateTime));
                    end;
                end;
              end
              else begin
                { not data found in json }
                InsertVals := InsertVals + 'null';
                if IsUpdateField then
                  UpdateVals := UpdateVals + '`' + FieldList[z].Name + '`' + '=' + 'null';
              end;


            end;
            try
              qry.SQL.Clear;
              qry.SQL.Add('insert into ' + aTableName);
              qry.SQL.Add('(' + FieldList.FieldCommaList + ')');
              qry.SQL.Add('values (' + InsertVals + ')');
              qry.SQL.Add('on duplicate key update ' + UpdateVals);
              Log('Record number ' + IntToStr(y),ltInfo);
  //            Log(qry.SQL.Text,ltInfo);
              qry.Execute;
            except
              on e: exception do begin
                Log('Error inserting data into table' {+ qry.SQL.Text}, ltError);
                raise;
              end;

            end;
          end;


          SysUtils.DeleteFile(WinTempDir + ChangeFileExt(FileList[x],'.txt'));
        end;

        Log('Finished ' + DispName + ' downloading.',ltInfo);
      finally
        sl.Free;
        json.Free;
        UpdateFieldList.Free;
        FieldList.Free;
        DbSharedObj.ReleaseObj(qry);
        DbSharedObj.ReleaseObj(qryIdx);
      end;

    except
      on e: exception do begin
        result := false;
        Log('Error processing ' + DispName + ' for downloading: '+ e.Message, ltError);
      end;
    end;
  finally
    if Assigned(Ftp) then
      Ftp.Disconnect;
    fileList.Clear;
  end;
end;


//function TTableToFTP.Download(aTableName, sqlSelect: string): boolean;
//var
//  DispName: string;
//  x, y, z: integer;
//  dt, FtpMaxDt, TableMaxDt: TDateTime;
//  qry, qryIdx: TERPQuery;
//  FieldList: TFieldList;
//  json, rec: TJsonObject;
//  fileName: string;
//  Stream: TFileStream;
//  UpdateFieldList: TStringList;
//  InsertVals, UpdateVals: string;
//  IsUpdateField: boolean;
//  pair: TJsonValuePair;
//begin
//  result := true;
//  DispName := aTableName;
//  if Pos('tbl',Lowercase(DispName)) = 1 then
//    DispName := Copy(DispName,4,Length(DispName));
//  DispName := SeparateWords(DispName);
//  Log('Checking ' + DispName + ' for downloading ..',ltInfo);
//  if not Assigned(Ftp) then begin
//    Ftp := TIdFTP.Create(nil);
//    Ftp.Passive := true;
//    Ftp.TransferType := ftBinary;
//  end;
//  try
//    try
//      qry := DbSharedObj.GetQuery(Connection);
//      qryIdx := DbSharedObj.GetQuery(Connection);
//      json := JO;
//      UpdateFieldList := TStringList.Create;
//      FieldList := TFieldList.Create;
//      try
//        { get the most recent update time .. }
//        qry.SQL.Text := 'select Max(msTimeStamp) as MaxMsTimeStamp from ' + aTableName;
//        qry.Open;
//        TableMaxDt := qry.FieldByName('MaxMsTimeStamp').AsDateTime;
//        qry.Close;
//
//        Ftp.Host := FTPServer;
//        Ftp.Username := FTPUserName;
//        Ftp.Password := FTPPassword;
//        Ftp.Connect;
//        if FTPPath <> '' then
//          Ftp.ChangeDir(FTPPath);
//
//        { find new files on ftp site }
//        FtpMaxDt:= 0;
//        fileList.Clear;
//        FTP.List;
//        for x := 0 to Ftp.DirectoryListing.Count -1 do begin
//          if Pos(Lowercase(aTableName+'_'), Lowercase(Ftp.DirectoryListing.Items[x].FileName)) > 0 then begin
//            dt := NameToDateTime(Ftp.DirectoryListing.Items[x].FileName);
//            if dt > TableMaxDt then
//              fileList.Add(Ftp.DirectoryListing.Items[x].FileName);
//          end;
//        end;
//
//        if fileList.Count > 0 then
//          Log('Found ' + IntToStr(fileList.Count) + ' files to download',ltInfo)
//        else begin
//          Log('No new files found to download',ltInfo);
//          exit;
//        end;
//
//        { we only want non-blob fields }
//        qry.SQL.Text := 'describe ' + aTableName;
//        qry.Open;
//        qryIdx.SQL.Text := 'show indexes from  ' + aTableName;
//        qryIdx.Open;
//        while not qry.Eof do begin
//          if Pos('blob',qry.FieldByName('Type').AsString) = 0 then begin
//            FieldList.Add(qry.FieldByName('Field').AsString,qry.FieldByName('Type').AsString);
//            if (not qryIdx.Locate('Column_name',qry.FieldByName('Field').AsString,[loCaseInsensitive])) or
//               (qryIdx.FieldByName('Non_unique').AsInteger = 1) then
//              UpdateFieldList.Add(qry.FieldByName('Field').AsString);
//          end;
//          qry.Next;
//        end;
//        qry.Close;
//        qryIdx.Close;
//
//        if not Assigned(AbZipKit) then begin
//          AbZipKit := TAbZipKit.Create(nil);
//          AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
//          AbZipKit.BaseDirectory:= WinTempDir;
//        end;
//
//        { process the files .. }
//        for x := 0 to FileList.Count -1 do begin
//          Log('Downloading file ' + FileList[x], ltInfo);
//          Stream := TFileStream.Create(WinTempDir + FileList[x], fmCreate);
//          try
//            Ftp.Get(FileList[x], Stream, false);
//          finally
//            Stream.Free;
//          end;
//          Log('File downloaded ..',ltInfo);
//          Decrypt(WinTempDir + FileList[x], WinTempDir + ChangeFileExt(FileList[x],'.zip'));
//          Log('File decrypted ..',ltInfo);
//          SysUtils.DeleteFile(WinTempDir + FileList[x]);
//          AbZipKit.OpenArchive(WinTempDir + ChangeFileExt(FileList[x],'.zip'));
//          AbZipKit.ExtractFiles('*.*');
//          Log('Archive extracted ..',ltInfo);
//          AbZipKit.CloseArchive;
//          SysUtils.DeleteFile(WinTempDir + ChangeFileExt(FileList[x],'.zip'));
//
//          json.LoadFromFile(WinTempDir + ChangeFileExt(FileList[x],'.txt'));
//          Log('File contains ' + IntToStr(json.A['list'].Count) + ' records to process', ltInfo);
////          Log('Database: '  + qry.Connection.Database, ltInfo);
//          for y := 0 to json.A['list'].Count -1 do begin
//            rec := json.A['list'].Items[y].AsObject;
//            InsertVals := '';
//            UpdateVals := '';
//            for z := 0 to FieldList.Count -1 do begin
//              pair := rec.ItemByName[FieldList[z].Name];
//              if not Assigned(pair) then
//                Continue;
//              if InsertVals <> '' then InsertVals := InsertVals + ',';
//              if UpdateFieldList.IndexOf(pair.Name) > -1 then begin
//                IsUpdateField := true;
//                if UpdateVals <> '' then UpdateVals := UpdateVals + ',';
//              end
//              else
//                IsUpdateField := false;
//              case FieldList[z].BasicType of
//                ftString:
//                  begin
//                    InsertVals := InsertVals + QuotedStr(pair.Value.AsString);
//                    if IsUpdateField then
//                      UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(pair.Value.AsString);
//                  end;
//                ftInteger,
//                ftFloat:
//                  begin
//                    InsertVals := InsertVals + pair.Value.AsString;
//                    if IsUpdateField then
//                      UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + pair.Value.AsString;
//                  end;
//                ftBool:
//                  begin
//                    if pair.Value.AsBoolean or SameText(pair.Value.AsString,'T') then begin
//                      { true }
//                      InsertVals := InsertVals + '"T"';
//                      if IsUpdateField then
//                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '="T"';
//                    end
//                    else begin
//                      { false }
//                      InsertVals := InsertVals + '"F"';
//                      if IsUpdateField then
//                        UpdateVals := UpdateVals + '`' + pair.Name + '`' + '="F"';
//                    end;
//                  end;
//                ftDateTime:
//                  begin
//                    InsertVals := InsertVals + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',pair.Value.AsDateTime));
//                    if IsUpdateField then
//                      UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',pair.Value.AsDateTime));
//                  end;
//                ftDate:
//                  begin
//                    InsertVals := InsertVals + QuotedStr(FormatDateTime('yyyy-mm-dd',pair.Value.AsDateTime));
//                    if IsUpdateField then
//                      UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('yyyy-mm-dd',pair.Value.AsDateTime));
//                  end;
//                ftTime:
//                  begin
//                    InsertVals := InsertVals + QuotedStr(FormatDateTime('hh:nn:ss',pair.Value.AsDateTime));
//                    if IsUpdateField then
//                      UpdateVals := UpdateVals + '`' + pair.Name + '`' + '=' + QuotedStr(FormatDateTime('hh:nn:ss',pair.Value.AsDateTime));
//                  end;
//              end;
//
//
//            end;
//            qry.SQL.Clear;
//            qry.SQL.Add('insert into ' + aTableName);
//            qry.SQL.Add('(' + FieldList.FieldCommaList + ')');
//            qry.SQL.Add('values (' + InsertVals + ')');
//            qry.SQL.Add('on duplicate key update ' + UpdateVals);
//            Log('Record number ' + IntToStr(y),ltInfo);
////            Log(qry.SQL.Text,ltInfo);
//            qry.Execute;
//          end;
//
//
//          SysUtils.DeleteFile(WinTempDir + ChangeFileExt(FileList[x],'.txt'));
//        end;
//
//        Log('Finished ' + DispName + ' downloading.',ltInfo);
//      finally
//        json.Free;
//        UpdateFieldList.Free;
//        FieldList.Free;
//        DbSharedObj.ReleaseObj(qry);
//        DbSharedObj.ReleaseObj(qryIdx);
//      end;
//
//    except
//      on e: exception do begin
//        result := false;
//        Log('Error processing ' + DispName + ' for downloading: '+ e.Message, ltError);
//      end;
//    end;
//  finally
//    Ftp.Disconnect;
//    fileList.Clear;
//  end;
//end;


function TTableToFTP.Upload(aTableName: string; sqlSelect: string; SingleFile: boolean): boolean;
var
  DispName: string;
  x: integer;
  dt, FtpMaxDt, TableMaxDt: TDateTime;
  qry: TERPQuery;
  fieldList: string;
  json, rec: TJsonObject;
  fileName: string;
begin
  result := true;
  DispName := aTableName;
  if Pos('tbl',Lowercase(DispName)) = 1 then
    DispName := Copy(DispName,4,Length(DispName));
  DispName := SeparateWords(DispName);
  Log('Checking ' + DispName + ' for uploading ..',ltInfo);
  CreateFTP;
  try
    try
      initFTP;
      { find the max date time of files on ftp site }
      FtpMaxDt:= 0;
      FileList.Clear;
      FTP.List;
      for x := 0 to Ftp.DirectoryListing.Count -1 do begin
        if Pos(Lowercase(aTableName+'_'), Lowercase(Ftp.DirectoryListing.Items[x].FileName)) > 0 then begin
          FileList.Add(Ftp.DirectoryListing.Items[x].FileName);
          dt := NameToDateTime(Ftp.DirectoryListing.Items[x].FileName);
          if dt > FtpMaxDt then
            FtpMaxDt := dt;
        end;
      end;

      { we only want non-blob fields }
      qry := DbSharedObj.GetQuery(Connection);
      json := JO;
      try
//        if SingleFile then begin
//          { single table so we are not interested in max mstimestamp eg video and videopages do not update the mstimestamp }
//          TableMaxDt := now;
//        end
//        else begin
          { only do this where we are sending updates }
          qry.SQL.Text := 'select Max(msTimeStamp) as MaxMsTimeStamp from ' + aTableName;
          qry.Open;
          TableMaxDt := qry.FieldByName('MaxMsTimeStamp').AsDateTime;
          if TableMaxDt <= FtpMaxDt then begin
            Log('No new records found to upload.',ltInfo);
            exit;
          end;
          qry.Close;
//        end;

        qry.SQL.Text := 'describe ' + aTableName;
        qry.Open;
        fieldList := '';
        while not qry.Eof do begin
          if Pos('blob',qry.FieldByName('Type').AsString) = 0 then begin
            if fieldList <> '' then fieldList := fieldList + ',';
            fieldList := fieldList + qry.FieldByName('Field').AsString;
          end;
          qry.Next;
        end;
        qry.Close;

        qry.SQL.Clear;
        qry.SQL.Add('select ' + fieldList + ' from ' + aTableName);
        if SingleFile then begin
          if sqlSelect <> '' then
            qry.SQL.Add('where ' + sqlSelect);
        end
        else begin
          { multiple files }
          qry.SQL.Add('where msTimeStamp > ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',FtpMaxDt)));
          qry.SQL.Add('and msTimeStamp <= ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',TableMaxDt)));
          if sqlSelect <> '' then
            qry.SQL.Add('and ' + sqlSelect);
        end;
        qry.Open;
        Log('Found ' + IntToStr(qry.RecordCount) + ' record to upload',ltInfo);
        while not qry.Eof do begin
          rec := JO;
          DatasetToJson(qry,rec);
          json.A['list'].Add(rec);
          qry.Next;
        end;

        fileName := aTableName + '_' + FormatDateTime('yyyymmddhhnnss', TableMaxDt);
        SysUtils.DeleteFile(WinTempDir + aTableName + '.txt');
        json.SaveToFile(WinTempDir + fileName + '.txt');

        if not Assigned(AbZipKit) then begin
          AbZipKit := TAbZipKit.Create(nil);
          AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
          AbZipKit.BaseDirectory:= WinTempDir;
        end;
        AbZipKit.FileName := WinTempDir + fileName + '.zip';
        AbZipKit.AddFiles(WinTempDir + fileName + '.txt', faAnyFile);
        AbZipKit.CloseArchive;
        SysUtils.DeleteFile(WinTempDir + fileName + '.txt');
        Encrypt(WinTempDir + fileName + '.zip', WinTempDir + fileName + '.dat');
        SysUtils.DeleteFile(WinTempDir + fileName + '.zip');

        UploadFile(WinTempDir + fileName + '.dat', true);

        InitFTP;
        if SingleFile then begin
         { delete older file from ftp site }
          for x := 0 to FileList.Count -1 do
            Ftp.Delete(FileList[x]);
        end;

        Log('Finished ' + DispName + ' uploading.',ltInfo);
      finally
        json.Free;
        DbSharedObj.ReleaseObj(qry);
      end;

    except
      on e: exception do begin
        result := false;
        Log('Error processing ' + DispName + ' for uploading: '+ e.Message, ltError);
      end;
    end;
  finally
    FileList.Clear;
    if Assigned(Ftp) then
      Ftp.Disconnect;
  end;
end;

{ TFieldList }

procedure TFieldList.Add(aFieldName, aMySQLFieldType: string);
var
  rec: TFieldListRec;
begin
  rec := TFieldListRec.Create;
  rec.Name := aFieldName;
  if Pos('enum', Lowercase(aMySQLFieldType)) = 1 then begin
    if SameText(aMySQLFieldType,'enum(''T'',''F'')') then
      rec.BasicType := ftBool
    else
      rec.BasicType := ftString;
  end
  else if Pos('double', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftFloat
  else if Pos('float', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftFloat
  else if Pos('decimal', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftFloat
  else if Pos('int', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else if Pos('tinyint', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else if Pos('smallint', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else if Pos('mediumint', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else if Pos('bigint', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else if Pos('varchar', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('char', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('tinytext', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('text', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('mediumtext', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('longtext', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftString
  else if Pos('date', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftDate
  else if Pos('datetime', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftDateTime
  else if Pos('timestamp', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftDateTime
  else if Pos('time', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftTime
  else if Pos('year', Lowercase(aMySQLFieldType)) = 1 then
    rec.BasicType := ftInteger
  else
    rec.BasicType := ftString;

  fList.Add(rec);
end;

constructor TFieldList.Create;
begin
  fList := TObjectlist.Create;
end;

destructor TFieldList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TFieldList.GetCount: integer;
begin
  result := fList.Count;
end;

function TFieldList.GetFieldCommaList: string;
var
  x: integer;
begin
  result := '';
  for x := 0 to Count -1 do begin
    if x > 0 then result := result + ',';
    result := result + '`' + Item[x].Name + '`';
  end;
end;

function TFieldList.GetItem(idx: integer): TFieldListRec;
begin
  result := TFieldListRec(fList[idx]);
end;

end.
