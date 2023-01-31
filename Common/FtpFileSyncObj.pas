unit FtpFileSyncObj;

interface

uses
  Classes, LogThreadBase, LogMessageTypes, IdFTP;

type

  TFtpFileSync = class
  private
    fFTPPass: string;
    fFTPHost: string;
    fFileMaskList: TStringList;
    fFTPUser: string;
    fOnLog: TOnLogEvent;
    fFTPPath: string;
    fLocalPath: string;
    function UploadCheckFile(aName: string): boolean;
    procedure Log(const aMsg: string; aType: TLogmessageType);
    function ChangeDirectory(ftp: TIdFTP; aPath: string; CreateIfNotFound: boolean = true): boolean;
    function GetLocalPath: string;
  public
    constructor Create;
    destructor Destroy; override;
    property FTPHost: string read fFTPHost write fFTPHost;
    property FTPPath: string read fFTPPath write fFTPPath;
    property FTPUser: string read fFTPUser write fFTPUser;
    property FTPPass: string read fFTPPass write fFTPPass;
    property FileMaskList: TStringList read fFileMaskList;
    property LocalPath: string read GetLocalPath write fLocalPath;
    function UploadCheckFiles: boolean;
    procedure DownloadCheckFiles;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
  end;

const
  ControlFileName = 'erp_ftp_control_file_do_not_remove.txt';

implementation

uses
  StrUtils, windows, SysUtils, JsonObject, types, IDReplyRFC, IdFTPList,
  SystemLib, IDGlobalProtocols;

//function IsFileInUse(fName : string) : boolean;
//var
//  HFileRes : HFILE;
//  Res: string[6];
//
//  function CheckAttributes(FileNam: string; CheckAttr: string): Boolean;
//  var
//    fa: Integer;
//  begin
//    fa := GetFileAttributes(PChar(FileNam)) ;
//    Res := '';
//    if (fa and FILE_ATTRIBUTE_NORMAL) <> 0 then begin
//      Result := False;
//      Exit;
//    end;
//    if (fa and FILE_ATTRIBUTE_ARCHIVE) <> 0 then Res := Res + 'A';
//    if (fa and FILE_ATTRIBUTE_COMPRESSED) <> 0 then Res := Res + 'C';
//    if (fa and FILE_ATTRIBUTE_DIRECTORY) <> 0 then Res := Res + 'D';
//    if (fa and FILE_ATTRIBUTE_HIDDEN) <> 0 then Res := Res + 'H';
//    if (fa and FILE_ATTRIBUTE_READONLY) <> 0 then Res := Res + 'R';
//    if (fa and FILE_ATTRIBUTE_SYSTEM) <> 0 then Res := Res + 'S';
//    Result := AnsiContainsText(String(Res), CheckAttr) ;
//  end; (*CheckAttributes*)
//
//  procedure SetAttr(fName: string);
//  var
//    Attr: Integer;
//  begin
//    Attr := 0;
//    if AnsiContainsText(String(Res), 'A') then Attr := Attr + FILE_ATTRIBUTE_ARCHIVE;
//    if AnsiContainsText(String(Res), 'C') then Attr := Attr + FILE_ATTRIBUTE_COMPRESSED;
//    if AnsiContainsText(String(Res), 'D') then Attr := Attr + FILE_ATTRIBUTE_DIRECTORY;
//    if AnsiContainsText(String(Res), 'H') then Attr := Attr + FILE_ATTRIBUTE_HIDDEN;
//    if AnsiContainsText(String(Res), 'S') then Attr := Attr + FILE_ATTRIBUTE_SYSTEM;
//    SetFileAttributes(PChar(fName), Attr) ;
//  end; (*SetAttr*)
//
//begin //IsFileInUse
////  if CheckAttributes(fName, 'R') then begin
////    Result := False;
////    if not FileExists(fName) then exit;
////    if MessageDlg(ExtractFileName(fName) + ' is a READ-ONLY file.' + #13#10 + 'Do you wish to clear the READ-ONLY flag???', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
////      Result := True;
////      Exit;
////    end;
////  end;
//  SetFileAttributes(PChar(fName), FILE_ATTRIBUTE_NORMAL);
//  SetAttr(fName) ;
//  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0) ;
//  Result := (HFileRes = INVALID_HANDLE_VALUE) ;
//  if not Result then CloseHandle(HFileRes) ;
//end; //IsFileInUse


{ TFtpFileSync }

function TFtpFileSync.ChangeDirectory(ftp: TIdFTP; aPath: string; CreateIfNotFound: boolean = true): boolean;
var
  arr: TStringDynArray;
  x: integer;
begin
  result := true;
  if aPath = '' then exit;

  if Pos('/',aPath) > 0 then
    arr := SplitString(aPath, '/')
  else
    arr := SplitString(aPath, '\');
  for x := Low(arr) to High(arr) do begin
    try
      ftp.ChangeDir(arr[x]);
    except
      on e: exception do begin
        if e is EIdReplyRFCError then begin
          if (EIdReplyRFCError(e).ErrorCode = 550) and CreateIfNotFound then begin
            { probably does not exist so try creating it .. }
            try
              ftp.MakeDir(arr[x]);
              ftp.ChangeDir(arr[x]);
            except
              on e: exception do begin
                result := false;
                Log('Error while creating Directory ' + arr[x] + ' on FTP Server with message: ' + e.Message, ltError);
                exit;
              end;
            end;
          end
          else begin
            result := false;
            Log('Error while trying to change Directory on the FTP Server to ' + arr[x] + ' with message: ' + e.Message, ltError);
            exit;
          end;
        end
        else begin
          result := false;
          Log('Error while trying to change Directory on the FTP Server to ' + arr[x] + ' with message: ' + e.Message, ltError);
          exit;
        end;
      end;
    end;
  end;
end;

function TFtpFileSync.UploadCheckFile(aName: string): boolean;
var
//  aPath: string;
  SR: TSearchRec;
  matchList: TStringList;
  controlFile: TJsonObject;
  x: integer;
  FileName: string;
  FileTS: TDateTime;
  ftp: TIdFTP;
  dtStart: TDateTime;

  function FileNeedsSending(aFileName: string; aFileTS: TDateTime): boolean;
  var
    i: integer;
    o: TJsonObject;
  begin
    result := true;
    for i := 0 to controlFile.A['LocalFiles'].Count -1 do begin
      o := controlFile.A['LocalFiles'].Items[i].AsObject;
      if SameText(aFileName,o.S['FileName']) then begin
        if aFileTS <= o.DT['TimeStamp'] then
          result := false;
        break;
      end;
    end;
  end;

  function UpdateControllFileLocal(aFileName: string; aFileTS: TDateTime): boolean;
  var
    i: integer;
    o: TJsonObject;
  begin
    result := true;
    try
      for i := 0 to controlFile.A['LocalFiles'].Count -1 do begin
        o := controlFile.A['LocalFiles'].Items[i].AsObject;
        if SameText(aFileName,o.S['FileName']) then begin
          o.DT['TimeStamp'] := aFileTS;
          controlFile.SaveToFile(LocalPath + ControlFileName);
          exit;
        end;
      end;
      o := JO;
      o.S['FileName'] := aFileName;
      o.DT['TimeStamp'] := aFileTS;
      controlFile.A['LocalFiles'].Add(o);
      controlFile.SaveToFile(LocalPath + ControlFileName);
    except
      on e: exception do begin
        result := false;
        Log('The following error occured when trying to update and save the controll file.',ltError);
      end;
    end;
  end;

  procedure RemoveDeletedLocalFromControl;
  var
    i: integer;
    o: TJsonObject;
    updated: boolean;
  begin
    try
      updated := false;
      i := 0;
      while i < controlFile.A['LocalFiles'].Count do begin
        o := controlFile.A['LocalFiles'].Items[i].AsObject;
        if not FileExists(LocalPath + o.S['FileName']) then begin
          DeleteFile(LocalPath + o.S['FileName']);
          controlFile.A['LocalFiles'].Delete(i);
          updated := true;
        end
        else
          Inc(i);
      end;
      if updated then
        controlFile.SaveToFile(LocalPath + ControlFileName);
    except
      on e: exception do begin
        Log('The following error occured when trying to delet entries from the controll file.',ltError);
      end;
    end;
  end;

  function UpdateControllFileRemote(aFileName: string): boolean;
  var
    i: integer;
    o: TJsonObject;
    item: TIdFTPListItem;
  begin
    result := true;
    try
      item := nil;
      for i := 0 to ftp.DirectoryListing.Count -1 do begin
        if SameText(ftp.DirectoryListing.Items[i].FileName,aFileName) then begin
          item := ftp.DirectoryListing.Items[i];
          break;
        end;
      end;
      if not Assigned(item) then
        exit;

      for i := 0 to controlFile.A['RemoteFiles'].Count -1 do begin
        o := controlFile.A['RemoteFiles'].Items[i].AsObject;
        if SameText(aFileName,o.S['FileName']) then begin
          o.DT['TimeStamp'] := item.ModifiedDate;
          controlFile.SaveToFile(LocalPath + ControlFileName);
          exit;
        end;
      end;
      o := JO;
      o.S['FileName'] := aFileName;
      o.DT['TimeStamp'] := item.ModifiedDate;
      controlFile.A['RemoteFiles'].Add(o);
      controlFile.SaveToFile(LocalPath + ControlFileName);
    except
      on e: exception do begin
        result := false;
        Log('The following error occured when trying to update and save the controll file: ' + e.Message,ltError);
      end;
    end;
  end;

begin
  result := true;
//  aPath := ExtractFilePath(aName);
  matchList := TStringList.Create;
  ftp := TIdFTP.Create;
  try
    ftp.Host := self.fFTPHost;
    ftp.Username := self.FTPUser;
    ftp.Password := self.FTPPass;
    if FindFirst(LocalPath + ExtractFileName(aName), faAnyFile, SR) = 0 then begin
      repeat
        if (SR.Name <> '.') and (SR.Name <> '..') and (SR.Name <> ControlFileName) then
          matchList.Add(SR.Name); //Fill the list
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

    if matchList.Count = 0 then exit;
    controlFile:= JO;
    try
      if fileExists(LocalPath + ControlFileName) then
        controlFile.LoadFromFile(LocalPath + ControlFileName);
      for x := 0 to matchList.Count -1 do begin
        FileName := matchList[x];
      {$WARNINGS OFF}
        FileTS := FileDateToDateTime(FileAge(LocalPath + FileName));
      {$WARNINGS ON}
        if FileNeedsSending(FileName,FileTS) then begin
          if not ftp.Connected then begin
            { first try connecting .. }
            try
              ftp.Connect;
            except
              on e: exception do begin
                Log('Could not connect to FTP Server ' + ftp.Host + ' with error: ' + e.Message,ltError);
                result := false;
                exit;
              end;
            end;
            { new set directory we are going to send file to }
            if self.FTPPath <> '' then begin
              if not ChangeDirectory(ftp,self.FTPPath) then begin
                result := false;
                exit;
              end;
            end;
          end;
          if not IsFileInUse(LocalPath + FileName) then begin
            { Delete it it is already there }
            try
              ftp.Delete(FileName);
            except
            end;
            { now send it }
            try
              dtStart := now;
              ftp.Put(LocalPath + FileName, FileName, false);
              Log('Uploaded file ' + FileName + ' to FTP Server. Upload took ' +
                FormatDateTime('hh',now - dtStart) + ' hours, ' +
                FormatDateTime('nn',now - dtStart) + ' minutes and ' +
                FormatDateTime('ss',now - dtStart) + ' seconds.', ltInfo);
              ftp.List(FileName,true);
              if not UpdateControllFileRemote(FileName) then
                result := false;
            except
              on e: exception do begin
                Log('Error uploading file to FTP Server ' + FileName + ' with message: ' + e.Message, ltError);
                result := false;
                Continue;
              end;
            end;
            { update the local controll file }
            if not UpdateControllFileLocal(FileName,FileTS) then
              result := false;
          end
          else begin
            { file is in use so cant upload }
            result := false;
          end;
        end;
      end;

      { now remove remove any files from the controll list that are no longer exist in the directory }
      RemoveDeletedLocalFromControl;


    finally
      controlFile.Free;
    end;
    if ftp.Connected then
      ftp.Disconnect;
  finally
    matchList.Free;
    ftp.Free;
  end;
end;

function TFtpFileSync.UploadCheckFiles: boolean;
var
  x: integer;
begin
  result := true;
  for x := 0 to FileMaskLIst.Count -1 do begin
    if not UploadCheckFile(FileMaskList[x]) then
      result := false;
  end;
end;

constructor TFtpFileSync.Create;
begin
  fFileMaskList := TStringList.Create;
end;

destructor TFtpFileSync.Destroy;
begin
  fFileMaskList.Free;
  inherited;
end;

procedure TFtpFileSync.DownloadCheckFiles;
var
  ftp: TIdFTP;
  x, y: integer;
  item: TIdFTPListItem;
  controlFile: TJsonObject;
  dtStart: TDateTime;

  function FileNeedsDownloading: boolean;
  var
    i: integer;
    o: TJsonObject;
  begin
    result := true;
    for i := 0 to controlFile.A['RemoteFiles'].Count -1 do begin
      o := controlFile.A['RemoteFiles'].Items[i].AsObject;
      if SameText(item.FileName,o.S['FileName']) then begin
        if item.ModifiedDate <= o.DT['TimeStamp'] then
          result := false;
        break;
      end;
    end;
  end;

  procedure UpdateConfigFile;
  var
    i: integer;
    o: TJsonObject;
    found: boolean;
  begin
    found := false;
    for i := 0 to controlFile.A['RemoteFiles'].Count -1 do begin
      o := controlFile.A['RemoteFiles'].Items[i].AsObject;
      if SameText(item.FileName,o.S['FileName']) then begin
        found := true;
        o.DT['TimeStamp'] := item.ModifiedDate;
        break;
      end;
    end;
    if not found then begin
      o := JO;
      o.S['FileName'] := item.FileName;
      o.DT['TimeStamp'] := item.ModifiedDate;
      controlFile.A['RemoteFiles'].Add(o);
    end;

    found := false;
    for i := 0 to controlFile.A['LocalFiles'].Count -1 do begin
      o := controlFile.A['RemoteFiles'].Items[i].AsObject;
      if SameText(item.FileName,o.S['FileName']) then begin
        found := true;
      {$WARNINGS OFF}
        o.DT['TimeStamp'] := FileDateToDateTime(FileAge(LocalPath + item.FileName));
      {$WARNINGS ON}
        break;
      end;
    end;
    if not found then begin
      o := JO;
      o.S['FileName'] := item.FileName;
      {$WARNINGS OFF}
      o.DT['TimeStamp'] := FileDateToDateTime(FileAge(LocalPath + item.FileName));
      {$WARNINGS ON}
      controlFile.A['RemoteFiles'].Add(o);
    end;
    controlFile.SaveToFile(LocalPath + ControlFileName);
  end;

  function FileNameInList(aFileName: string): boolean;
  var
    i: integer;
  begin
    result := false;
    for i := 0 to ftp.DirectoryListing.Count -1 do begin
      if SameText(aFileName, ftp.DirectoryListing.Items[i].FileName) then begin
        result := true;
        exit;
      end;
    end;
  end;

  procedure RemoveDeletedRemoteFromControl;
  var
    i: integer;
    o: TJsonObject;
    updated: boolean;
  begin
    ftp.List;
    i := 0;
    updated := false;
    while i < controlFile.A['RemoteFiles'].Count do begin
      o := controlFile.A['RemoteFiles'].Items[i].AsObject;
      if not FileNameInList(o.S['FileName']) then begin
        controlFile.A['RemoteFiles'].Delete(i);
        updated := true;
      end
      else
        Inc(i);
    end;
    if updated then
      controlFile.SaveToFile(LocalPath + ControlFileName);
  end;

begin
  try
    ftp := TIdFTP.Create(nil);
    controlFile := JO;
    try
      if fileExists(LocalPath + ControlFileName) then
        controlFile.LoadFromFile(LocalPath + ControlFileName);
      ftp.Host := self.fFTPHost;
      ftp.Username := self.FTPUser;
      ftp.Password := self.FTPPass;
      try
        ftp.Connect;
      except
        on e: exception do begin
          Log('Error connecting to FTP Server ' + e.Message, ltError);
          exit;
        end;
      end;
      if not ChangeDirectory(ftp,self.FTPPath,false) then exit;
      for x := 0 to self.FileMaskList.Count -1 do begin
//        ftp.List(FileMaskList[x],true);
        ftp.List('*.*',true);
        for y := 0 to ftp.DirectoryListing.Count -1 do begin
          item := ftp.DirectoryListing.Items[y];
          if Pos(FileMaskList[x],Lowercase(item.FileName)) <> 1 then
            continue;

          if FileNeedsDownloading then begin
            try
              dtStart := now;
              ftp.Get(item.FileName,self.LocalPath + item.FileName,true);
              Log('Dounloaded file ' + item.FileName + ' from FTP Server. Download took ' +
                FormatDateTime('hh',now - dtStart) + ' hours, ' +
                FormatDateTime('nn',now - dtStart) + ' minutes and ' +
                FormatDateTime('ss',now - dtStart) + ' seconds.', ltInfo);
            except
              on e: exception do begin
                if FileExists(self.LocalPath + item.FileName) then begin
                  if item.SizeAvail and (FileSizeByName(self.LocalPath + item.FileName) = item.Size) then begin
                    { we actually have the whole file .. all good }
                  end
                  else begin
                    DeleteFile(self.LocalPath + item.FileName);
                    Log('Error downloading file ' + item.FileName + ' with message: ' + e.Message,ltError);
                    continue;
                  end;
                end
                else begin
                  { nothing downloaded }
                  Log('Error downloading file ' + item.FileName + ' with message: ' + e.Message,ltError);
                  continue;
                end;
              end;
            end;
            UpdateConfigFile;
          end;
        end;
      end;

      if controlFile.A['RemoteFiles'].Count > 100 then
        RemoveDeletedRemoteFromControl;

      if ftp.Connected then
        ftp.Disconnect;
    finally
      ftp.Free;
      controlFile.Free;
    end;
  except
    on e: exception do begin
      Log('Error downloading from FTP Server: ' + e.Message, ltError);
    end;
  end;
end;

function TFtpFileSync.GetLocalPath: string;
begin
  if fLocalPath = '' then
    Result := fLocalPath
  else
    {$WARNINGS OFF}
    result := SysUtils.IncludeTrailingBackslash(fLocalPath);
    {$WARNINGS ON}
end;

procedure TFtpFileSync.Log(const aMsg: string; aType: TLogmessageType);
begin
  if Assigned(fOnLog) then
    fOnLog(aMsg,aType);
end;

end.
