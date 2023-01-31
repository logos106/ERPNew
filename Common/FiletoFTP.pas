unit FiletoFTP;

interface

uses
  LogThreadBase, LogMessageTypes, ERPDbComponents, IdFTP, Classes, Contnrs,
  AbBase, AbBrowse, AbZBrows, AbArcTyp, IdHTTP;


Type
  TFileToFTP = class(TObject)
  Private
    fOnLog: TOnLogEvent;
    fLogger: TLoggerBase;
    fFTPPassword: string;
    fFTPUserName: string;
    fFTPServer: string;
    fFTPPath: string;
    fsStatusMsg: String;
    fbIsStatusOk: Boolean;
  Protected
    Ftp: TIdFTP;
    Http: TIdHttp;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    Procedure CreateFTP;
    Procedure InitFTP;
  Public
    destructor Destroy; override;
    Constructor Create;

    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property Logger: TLoggerBase read fLogger write fLogger;
    property FTPServer: string read fFTPServer write fFTPServer;
    property FTPPath: string read fFTPPath write fFTPPath;
    property FTPUserName: string read fFTPUserName write fFTPUserName;
    property FTPPassword: string read fFTPPassword write fFTPPassword;
    Property StatusMsg : String read fsStatusMsg write fsStatusMsg;
    Property IsStatusOk :Boolean read fbIsStatusOk write fbIsStatusOk;

    function UploadFile(aFileName:String ; DeleteAfterUpload:Boolean): boolean;
  end;

  TERPDocs = class(TObject)
  Private
    fOnLog: TOnLogEvent;
    fLogger: TLoggerBase;
    FileToFTP :TFileToFTP;
    fbIsStatusOk: Boolean;
    fsStatusMsg: String;
  Protected
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  Public
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property Logger: TLoggerBase read fLogger write fLogger;
    function Uploadhelpdoc(fsfileName: String): boolean;
    Property StatusMsg : String read fsStatusMsg write fsStatusMsg;
    Property IsStatusOk :Boolean read fbIsStatusOk write fbIsStatusOk;
    destructor Destroy; override;
    Constructor Create;
  end;

implementation

uses SysUtils, IdFTPCommon, ERPFTPConst, Windows;

{ TFileToFTP }

destructor TFileToFTP.Destroy;
begin
  Ftp.Free;
  Http.Free;
  inherited;
end;

procedure TFileToFTP.InitFTP;
begin
  if Ftp.Connected and (Ftp.Host =FTPServer) and (Ftp.Username =FTPUserName) and (Ftp.Password =FTPPassword) then
  else begin
    if Ftp.Connected  then Ftp.disconnect;
      Ftp.Host := FTPServer;
      Ftp.Username := FTPUserName;
      Ftp.Password := FTPPassword;
      Ftp.Connect;
  end;
  if FTPPath <> '' then Ftp.ChangeDir(FTPPath);
end;

constructor TFileToFTP.Create;
begin
  StatusMsg := '';
  IsStatusOk := TRue;
end;

procedure TFileToFTP.CreateFTP;
begin
  if not Assigned(Ftp) then begin
    Ftp := TIdFTP.Create(nil);
//    Ftp.Port := 21;
    Ftp.Passive := true;
    Ftp.TransferType := ftBinary;
  end;
end;

procedure TFileToFTP.Log(const msg: string;const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLog) then fOnLog(msg, LogMessageType);
  if Assigned(fLogger) then fLogger.Log(msg, LogMessageType);
end;

function TFileToFTP.UploadFile(aFileName:String ; DeleteAfterUpload:Boolean): boolean;
var
  Stream: TFileStream;
begin
  result := true;
  CreateFTP;
  try
    try
      initFTP;
        Stream := TFileStream.Create(afilename, fmOpenRead);
        try
          Ftp.Put(Stream,extractfilename(afilename),false);
          IsStatusOk := true;
          StatusMsg := '';
        finally
          Stream.Free;
        end;
        if DeleteAfterUpload then
          SysUtils.DeleteFile(afilename);
    Except
      on e: exception do begin
        result := false;
        IsStatusOk := False;
        StatusMsg := E.Message;
        Log('Error Uploading ' + aFileName + '. '+ e.Message, ltError);
      end;
    end;
  finally
    if Assigned(Ftp) then
      Ftp.Disconnect;
  end;
end;

{ TERPDocs }

constructor TERPDocs.Create;
begin
  StatusMsg := '';
  IsStatusOk := TRue;
end;

destructor TERPDocs.Destroy;
begin
  FileToFTP.Free;
  inherited;
end;

procedure TERPDocs.Log(const msg: string;  const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLog) then fOnLog(msg, LogMessageType);
  if Assigned(fLogger) then fLogger.Log(msg, LogMessageType);
end;
function TERPDocs.Uploadhelpdoc(fsfileName:String): boolean;
begin
  if not Assigned(FileToFTP) then begin
    FileToFTP := TFileToFTP.Create;
    FileToFTP.OnLog := Log;
  end;
  FileToFTP := TFileToFTP.Create;
  FileToFTP.OnLog := Log;
  FileToFTP.FTPServer   := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  FileToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  FileToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  FileToFTP.FTPPath     := FTP_ERPHELPDOC_PATH;
  result := FileToFTP.UploadFile(fsfileName,False) ;
  StatusMsg :=FileToFTP.StatusMsg;
  IsStatusOk := FileToFTP.IsStatusOk;
end;

end.
