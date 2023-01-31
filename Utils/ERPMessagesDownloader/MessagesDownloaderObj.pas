unit MessagesDownloaderObj;

interface

uses
  LogThreadLib, LogMessageTypes, CipherUtils, AbBase, AbBrowse, AbZBrows,
  AbZipper, AbZipKit, JsonObject, MyAccess, ERPMessagesDb, LogThreadBase;


type

  TMessagesDownloader = class(TObject)
  private
//    Zipper: TAbZipper;
    AbZipKit: TAbZipKit;
    Json: TJsonObject;
    db: TERPMessagesDb;
    cmd: TMyCommand;
    fAssignedLogger: TLoggerBase;
    fOwnedLogger: TLoggerBase;
    procedure Log(const msg: string; const LogMessageType: TLogmessageType);
    procedure ProcessFile(aFile: string);
    function GetLogger: TLoggerBase;
    procedure SetLogger(const Value: TLoggerBase);
  public
    property Logger: TLoggerBase read GetLogger write SetLogger;
    constructor Create;
    destructor Destroy; override;
    procedure DownloadAndProcess;
  end;

implementation

uses
  FileDownloadFuncs, TrueERPMessagesConst, SysUtils, SystemLib, AbArcTyp,
  MySQLUtils, DbConst, Windows;

{ TMessagesDownloader }

constructor TMessagesDownloader.Create;
begin
//  Zipper := TAbZipper.Create(nil);
  AbZipKit := TAbZipKit.Create(nil);
  AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
  AbZipKit.BaseDirectory:= MessagesDir;
  Json := JO;
  db := TERPMessagesDb.Create;
  db.Server := 'localhost';
  cmd := TMyCommand.Create(nil);
  cmd.Connection := db.Connection;
end;

destructor TMessagesDownloader.Destroy;
begin
  Json.Free;
  AbZipKit.Free;
  db.Free;
  fOwnedLogger.Free;
  inherited;
end;

procedure TMessagesDownloader.DownloadAndProcess;
var
  fileId: integer;
  aDownloadResult: TFileDownloadResult;
begin
  Log('Message Downloader - Starting check for new messages.',ltDetail);
  fileId := 1;
  ForceDirectories(MessagesDir);
  while TFileDownloader.DownloadFile(MessagesURL + MessagesFilePrefix + IntToStr(fileId) + '.dat',
    MessagesDir + MessagesFilePrefix + IntToStr(fileId) + '.dat', aDownloadResult) do begin
    if aDownloadResult = drFileReplaced then
      ProcessFile(MessagesDir + MessagesFilePrefix + IntToStr(fileId) + '.dat');
    Inc(fileId);
  end;
  Log('Message Downloader - Finished.',ltDetail);
end;

function TMessagesDownloader.GetLogger: TLoggerBase;
begin
  if Assigned(fAssignedLogger) then
    result := fAssignedLogger
  else begin
    if not Assigned(fOwnedLogger) then begin
      fOwnedLogger := TLogger.Create(nil);
      fOwnedLogger.LogAllTypes;
    end;
    result := fOwnedLogger;
  end;
end;

procedure TMessagesDownloader.Log(const msg: string;
  const LogMessageType: TLogmessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
end;

procedure TMessagesDownloader.ProcessFile(aFile: string);
var
  zipFileName, textFileName: string;
  item: TJsonObject;
  x: integer;
begin
  Log('Processing Messages File: ' + aFile, ltDetail);
  zipFileName := ChangeFileExt(aFile, '.zip');
  textFileName := ChangeFileExt(aFile, '.txt');
  try
    Decrypt(aFile,zipFileName);
    AbZipKit.OpenArchive(zipFileName);
    AbZipKit.ExtractFiles('*.*');
//    AbZipKit.DeleteFiles('*.*');
    AbZipKit.CloseArchive;
    Json.LoadFromFile(textFileName);
    for x := 0 to Json.A['list'].Count -1 do begin
      item := Json.A['list'].Items[x].AsObject;
      cmd.SQL.Text := 'insert ignore into tblerpmessages (OrigId,MessageType,VersionNo,CreatedOn,Subject,Details) ' +
        ' Values (';
      cmd.SQL.Add(IntToStr(item.I['ID']));
      cmd.SQL.Add(',"ERP"');
      cmd.SQL.Add(',' + QuotedStr(item.S['VersionNo']));
      cmd.SQL.Add(',' + QuotedStr(FormatDateTime('yyyy-mm-yy hh:nn:ss',item.DT['CreatedOn'])));
      cmd.SQL.Add(',' + QuotedStr(item.S['Subject']));
      cmd.SQL.Add(',' + QuotedStr(item.S['Details'])+ ');');
      cmd.Execute;
    end;
  finally
    SysUtils.DeleteFile(zipFileName);
    SysUtils.DeleteFile(textFileName);
  end;
end;

procedure TMessagesDownloader.SetLogger(const Value: TLoggerBase);
begin

end;

end.
