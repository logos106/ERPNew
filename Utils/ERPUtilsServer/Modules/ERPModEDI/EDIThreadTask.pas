// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit EDIThreadTask;

interface

uses
  ServerModuleThreadTask, Classes, LogThreadBase, LogMessageTypes, EDIConfigObj,
//  ScktComp, SBTypes, SBUtils,
  // If SBIdSFTP is not found, add <SecureBlackbox>\Classes\IndySftp\Client
  // directory to Directories\Search Path in the project options
//  SBIdSFTP,
//  SBSftpCommon,
//  SBSSHConstants, SBSSHKeyStorage,
  StdCtrls, ImgList,
//  IdComponent, IdGlobal, IdTcpClient, IdFTPList, busobjOrders, XMLIntf,
  JsonObject, ERPDbComponents;

type

//  TSFTPClient = class;
  TEDIThreadTask = class(TServerModuleThreadTask)
  private
//    FSFTPClient: TSFTPClient;
//    FFtpSite: string;
//    FERPDatabase: string;
//    FERPPassword: string;
//    FFtpCertificate: string;
//    FFtpPassword: string;
//    FERPUser: string;
//    FFtpUserName: string;
//    fPercentDone: integer;
//    fSupplierName: string;
//    fProcessedStatus: string;
//    fStatusToProcess: string;
//    PO: TPurchaseOrder;
//    XMLDoc: IXMLDocument;
    fGLN: string;
    fPOOutputDir: string;
//    function SFTPClient: TSFTPClient;
//    function FTPParamsOk: boolean;
//    function RequirementsOk: boolean;
    procedure CheckForTriggers;
    procedure CheckForData(cfg: TEDIConfig; trig: TJsonObject; conn: TERPConnection);
    function IncFileNo(aFileName: string): string;
  protected
    procedure DoWork; override;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltNone); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
//    property FtpSite: string read FFtpSite write FFtpSite;
//    property FtpUserName: string read FFtpUserName write FFtpUserName;
//    property FtpPassword: string read FFtpPassword write FFtpPassword;
//    property FtpCertificate: string read FFtpCertificate write FFtpCertificate;
//    property ERPDatabase: string read FERPDatabase write FERPDatabase;
//    property ERPUser: string read FERPUser write FERPUser;
//    property ERPPassword: string read FERPPassword write FERPPassword;
//    property SupplierName: string read fSupplierName write fSupplierName;
//    property StatusToProcess: string read fStatusToProcess write fStatusToProcess;
//    property ProcessedStatus: string read fProcessedStatus write fProcessedStatus;
//    property GLN: string read fGLN write fGLN; { Global Location Number }
//    property POOutputDir: string read fPOOutputDir write fPOOutputDir;
  end;

//  TSFTPClient = class
//  private
//    FSFTPClient : TElIdSFTPClient;
//    FKeyStorage: TElSSHMemoryKeyStorage;
//    FFtpSite: string;
//    FFtpCertificate: string;
//    FFtpPassword: string;
//    FFtpUserName: string;
//    Processed : integer;
//    ToProcess : integer;
//    fPercentDone: integer;
//    fOnLog: TThreadTaskLogEvent;
//    procedure SftpClientWork(Sender: TObject; AWorkMode: TWorkMode; {$ifdef INDY90}const{$endif} AWorkCount: {$ifdef INDY90}Integer{$else}Int64{$endif});
//    procedure SftpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode; {$ifdef INDY90}const{$endif} AWorkCountMax: {$ifdef INDY90}Integer{$else}Int64{$endif});
//    procedure SftpClientAuthenticationFailed(Sender: TObject;
//      AuthenticationType: Integer);
//    procedure SftpClientAuthenticationSuccess(Sender: TObject);
//    procedure SftpClientCloseConnection(Sender: TObject);
//    procedure SftpClientError(Sender: TObject; ErrorCode: Integer);
//    procedure SftpClientKeyValidate(Sender: TObject; ServerKey: TElSSHKey;
//      var Validate: Boolean);
//    function Client: TElIdSFTPClient;
//    procedure Log(const msg: string; const aType: TLogMessageType = ltNone);
//  public
//    DirList : TIdSFTPListItems;
//    constructor Create;
//    destructor Destroy; override;
//    property FtpSite: string read FFtpSite write FFtpSite;
//    property FtpUserName: string read FFtpUserName write FFtpUserName;
//    property FtpPassword: string read FFtpPassword write FFtpPassword;
//    property FtpCertificate: string read FFtpCertificate write FFtpCertificate;
//    function Connect: boolean;
//    procedure Disconnect;
//    function ChangeDir(const newDir: string): boolean;
//    function GetFileList: boolean;
//    function GetFile(FileName: string; stream: TStream): boolean;
//    property OnLog: TThreadTaskLogEvent read fOnLog write fOnLog;
//  end;

implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLDoc, XMLHelperUtils, Math,
  BusObjStock, AppEnvironment,
//  ActiveX,
  BusObjClient, BusObjUOM,
  EmailUtilsSimple, CommonLib, BusObjCommon, DB, BusObjConst,
  ERPDbListObj, IOUtils,
  EDIConst,
  EDICustomFileMapperObj,
  ERPFileMapperObj,
  EDIDAFuelMapperObj;

//const
//  Ftp_File_Location = '/outbound';

{ TPerecorpThreadTask }

constructor TEDIThreadTask.Create;
begin
  inherited;

end;

destructor TEDIThreadTask.Destroy;
begin
//  XMLDoc := nil;
//  PO.Free;
//  FSFTPClient.Free;
  inherited;
end;

procedure TEDIThreadTask.DoWork;
var
  stream: TFileStream;
begin
  inherited;

  JsonToObj(Params,Self);
  CheckForTriggers;

end;


//function TEDIThreadTask.FTPParamsOk: boolean;
//var
//  KeyFileName: string;
//begin
//  result := false;
//  if self.ERPDatabase = '' then begin
//    Log('ERP Database has not been specified.', ltError);
//    exit;
//  end;
//  if self.FFtpSite = '' then begin
//    Log('FTP Site has not been specified.', ltError);
//    exit;
//  end;
//  if self.FFtpPassword = '' then begin
//    Log('FTP Password has not been specified.', ltError);
//    exit;
//  end;
//  if self.FFtpUserName = '' then begin
//    Log('FTP User Name has not been specified.', ltError);
//    exit;
//  end;
//  if self.FFtpCertificate = '' then begin
//    Log('FTP Certificate has not been specified.', ltError);
//    exit;
//  end;
//  KeyFileName := ModuleFileNameUtils.GetCurrentModulePath + self.FFtpCertificate;
//  if not FileExists(KeyFileName) then begin
//    Log('FTP Certificate File not found.', ltError);
//    exit;
//  end;
//  if self.ERPDatabase = '' then begin
//    Log('ERP Database has not been specified.', ltError);
//    exit;
//  end;
//  if self.ERPUser = '' then begin
//    Log('ERP User Name has not been specified.', ltError);
//    exit;
//  end;
//  if self.ERPPassword = '' then begin
//    Log('ERP User Password has not been specified.', ltError);
//    exit;
//  end;
//
//  result := true;
//end;

procedure TEDIThreadTask.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  inherited;
  self.ProgressTime := now;
end;

function TEDIThreadTask.IncFileNo(aFileName: string): string;
var
  name, ext: string;
  fileNo, I: integer;
  fileNoStr, fileBaseName: string;
  found: boolean;
begin
  fileNoStr := '';
  fileBaseName := '';
  name := ChangeFileExt(aFileName,'');
  ext := ExtractFileExt(aFileName);
  found := false;
  for I := Length(name) downto 1 do begin
    if found then begin
      fileBaseName := name[I] + fileBaseName;
    end
    else begin
      if CharInSet(name[I],['0'..'9'])  then
        fileNoStr := name[I] + fileNoStr
      else begin
        found := true;
        fileBaseName := name[I] + fileBaseName;
      end;
    end;
  end;
  if fileNoStr = '' then
    result := fileBaseName + '_1' + ext
  else begin
    fileNo := StrToInt(fileNoStr);
    Inc(fileNo);
    result := fileBaseName + IntToStr(fileNo) + ext;
  end;
end;

procedure TEDIThreadTask.CheckForData(cfg: TEDIConfig; trig: TJsonObject; conn: TERPConnection);
var
  list: TStringDynArray;
  Mapper: TEDICustomFileMapper;
  x, i: integer;
  fName: string;
begin
  if SameText(trig.S['Type'],'File') then begin
    if trig.S['FileMask'] <> '' then
      list := TDirectory.GetFiles(trig.S['FilePath'], trig.S['FileMask'])
    else
      list := TDirectory.GetFiles(trig.S['FilePath']);
    if Length(list) = 0 then exit;

    if SameText(trig.S['MapName'],Map_DAFuel) then
      Mapper := TERPDAFuelMapper.Create
    else
      Mapper := TERPFileMapper.Create;
    try
      Mapper.OnLog := Log;
      Mapper.Connection := Conn;
      Mapper.ERPUser := cfg.ERPUser;
      Mapper.ERPPass := cfg.ERPPass;
      for x := Low(list) to High(list) do begin

        if Mapper.ProcessFile(list[x],trig.S['MapName']) then begin
          { all ok so move file to processed }
          if trig.StringExists('ProcessedPath') then begin
            try
              ForceDirectories(trig.S['ProcessedPath']);
              fName := IncludeTrailingPathDelimiter(trig.S['ProcessedPath']) + ExtractFileName(list[x]);
              while FileExists(fname) do begin
                fName := IncFileNo(fName);
              end;
              TFile.Copy(list[x],fName);
            except
              on e: exception do begin
                Log('Error copying processed file: ' + e.Message,ltError);
              end;
            end;
          end;

          if trig.B['EmailOnSuccess'] and (trig.S['EmailAddress'] <> '') then begin
            SendEmail(trig.S['EmailAddress'],
              'TrueERP EDI - Success ' + ExtractFileName(list[x]),
              'Successfully processed file: ' + ExtractFileName(list[x]) + #13#10 +
              'Using Map: ' + trig.S['MapName']);
          end;
        end
        else begin
          { failed }
          if Mapper.LastErrorType = meTransient then begin
            { a transient error, try again later }
            if trig.B['EmailOnError'] and (trig.S['EmailAddress'] <> '') then begin
              SendEmail(trig.S['EmailAddress'],
                'TrueERP EDI - Retry ' + ExtractFileName(list[x]),
                'Transient error processing file: ' + ExtractFileName(list[x]) + #13#10 +
                'EDI will try and process this file again shortly.' + #13#10 +
                'Using Map: ' + trig.S['MapName'] + #13#10 + #13#10 + Mapper.Errors.Text);
            end;
          end
          else begin
            { move the file }
            if trig.StringExists('FailPath') then begin
              try
                ForceDirectories(trig.S['FailPath']);
                fName := IncludeTrailingPathDelimiter(trig.S['FailPath']) + ExtractFileName(list[x]);
                while FileExists(fname) do begin
                  fName := IncFileNo(fName);
                end;
                TFile.Copy(list[x],fName);
                { save out a copy of the errors }
                Mapper.Errors.SaveToFile(ChangeFileExt(fName,'_err.txt'));
              except
                on e: exception do begin
                  Log('Error copying processed file: ' + e.Message,ltError);
                end;
              end;
            end;
            if trig.B['EmailOnError'] and (trig.S['EmailAddress'] <> '') then begin
              SendEmail(trig.S['EmailAddress'],
                'TrueERP EDI - Error ' + ExtractFileName(list[x]),
                'Error processing file: ' + ExtractFileName(list[x]) + #13#10 +
                'Using Map: ' + trig.S['MapName'] + #13#10 + #13#10 + Mapper.Errors.Text);
            end;

          end;
        end;

        try
          DeleteFile(list[x]);
        except
          on e: exception do begin
            Log('Error deleting processed file: ' + e.Message,ltError);
          end;
        end;
      end;

    finally
      Mapper.Free;
    end;

  end;
end;

procedure TEDIThreadTask.CheckForTriggers;
var
  dbList: TERPDbList;
  qry: TERPQuery;
  stream: TMemoryStream;
  msg: string;
  report, DeptList: TStringList;
  reportOnly: boolean;
  FileNeedsProcessing: boolean;
  EDIConfig: TEDIConfig;
  trig: TJsonObject;
  x: integer;

const
  One_Hour = 1 / 24;
  One_Minute = One_Hour / 60;

  function CheckDue(obj: TJsonObject): boolean;
  begin
    result := false;
    try
      if (now >= obj.DT['NextCheckTime']) or (obj.DT['NextCheckTime'] = 0) then
        result := true;
    except
      result := true;
    end;
  end;

  procedure SetNextCheckTime(obj: TJsonObject);
  var
    hr,min: integer;
  begin
    { Interval format = hh:mm }
    hr := StrToIntDef(Copy(obj.S['Interval'],1,2),0);
    min := StrToIntDef(Copy(obj.S['Interval'],4,2),0);
    if (hr = 0) and (min = 0) then
      min := 2;
    obj.DT['NextCheckTime'] := now + (hr * One_Hour) + (min * One_Minute);
    EDIConfig.Save(dbList.Connection);
  end;

begin
  Log('Checking for data that need to be processed ..', ltInfo);
//  if not RequirementsOk then exit;
  try
//    CoInitialize(nil);
//    try
      dbList := TERPDbList.Create('localhost');
      EDIConfig := TEDIConfig.Create;
      try

        if dbList.First then begin
          repeat
            EDIConfig.Load(dbList.Connection);
            if (EDIConfig.Count > 0) and EDIConfig.Active then begin
              Log('Checking EDI for database ' + dbList.Connection.Database,ltDetail);
              for x := 0 to EDIConfig.Triggers.Count -1 do begin
                trig := EDIConfig.Triggers.Items[x].AsObject;
                if CheckDue(trig.O['CheckFrequency']) then begin
                  try
                    CheckForData(EDIConfig, trig, dbList.Connection);
                  finally
                    SetNextCheckTime(trig.O['CheckFrequency']);
                  end;
                end;
              end;
            end;
          until not dbList.Next;
        end;
      finally
        dbList.Free;
        EDIConfig.Free;
      end;



//      try
//        AppEnv.AppDb.Database := ERPDatabase;
//        AppEnv.AppDb.ConnectUser(ERPUser, ERPPassword);
//      except
//        on eusr: exception do begin
//          Log('Error connecting to ERP: ' + eusr.Message,ltError);
//          exit;
//        end;
//      end;
//      try
//        if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',ERPDatabase,ERPUser,'','',true) then begin
//          Log('Could not connect to ERP. ' + msg,ltError);
//          exit;
//        end;
//        try
////          qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
////          try
////            qry.SQL.Add('select * from tblpurchaseorders where IsPo = "T"');
////            qry.SQL.Add('and SupplierName = ' + QuotedStr(SupplierName));
////            qry.SQL.Add('and OrderStatus = ' + QuotedStr(StatusToProcess));
////            qry.SQL.Add('and Deleted = "F"');
////
////            qry.Open;
////
////            if qry.RecordCount > 0 then begin
////              Log('Found ' + IntToStr(qry.RecordCount) + ' orders that need to be sent.', ltInfo);
////              while not qry.Eof do begin
////
//////                ProcessOrder(qry.FieldByName('PurchaseOrderID').AsInteger);
////
////                qry.Next;
////              end;
////            end
////            else begin
////              Log('No new orders found to process',ltInfo);
////            end;
////
////
////
////
////          finally
////            DbSharedObj.ReleaseObj(qry);
////          end;
//
//        finally
//          AppEnv.UtilsClient.Disconnect;
//        end;
//
//      finally
//        AppEnv.AppDb.TransConnection.Disconnect;
//        AppEnv.AppDb.Connection.Disconnect;
//      end;
//    finally
//      CoUninitialize;
//    end;
  finally
    Log('Finished checking for data that need to be processed', ltInfo);
  end;
end;

//function TEDIThreadTask.RequirementsOk: boolean;
//begin
//  result := false;
//  if SupplierName = '' then begin
//    Log('There is no Supplier Name selected to process orders for.',ltError);
//    exit;
//  end;
//  if StatusToProcess = '' then begin
//    Log('There is no Order Status selected to process orders for.',ltError);
//    exit;
//  end;
//  if ProcessedStatus = '' then begin
//    Log('There is no Order Status selected to change order Status to once processed.',ltError);
//    exit;
//  end;
//  if GLN = '' then begin
//    Log('There is no GLN (Global Location Number) specified.',ltError);
//    exit;
//  end;
//  if POOutputDir = '' then begin
//    Log('There is no directory specified for the output files.',ltError);
//    exit;
//  end;
//  if (POOutputDir <> '') and (not DirectoryExists(POOutputDir)) then begin
//    if not ForceDirectories(POOutputDir) then begin
//      Log('Could not create specified directory for output files (' + POOutputDir + ')' ,ltError);
//      exit;
//    end;
//  end;
//
//
//  result := true;
//end;
//
//function TEDIThreadTask.SFTPClient: TSFTPClient;
//begin
//  if not Assigned(FSFTPClient) then begin
//    FSFTPClient := TSFTPClient.Create;
//    FSFTPClient.FFtpSite := FtpSite;
//    FSFTPClient.FFtpCertificate := FtpCertificate;
//    FSFTPClient.FFtpPassword := FtpPassword;
//    FSFTPClient.FFtpUserName := FtpUserName;
//    FSFTPClient.OnLog := self.Log;
//  end;
//  result := FSFTPClient;
//end;

{ TSFTPClient }

//function TSFTPClient.ChangeDir(const newDir: string): boolean;
//begin
//  result := false;
//  if not Client.Connected then begin
//    try
//      Client.Connect;
//    except
//      Log('Could not connect to FTP site', ltError);
//      exit;
//    end;
//  end;
//  try
//    Client.ChangeDir(newDir);
//    result := true;
//  except
//    Log('Could not change FTP directory to: ' + newDir, ltError);
//    exit;
//  end;
//end;
//
//function TSFTPClient.Client: TElIdSFTPClient;
//var
//  Key : TElSSHKey;
//  KeyFileName: string;
//begin
//  if not Assigned(FSFTPClient) then begin
//    FSFTPClient := TElIdSFTPClient.Create(nil);
//    FKeyStorage := TElSSHMemoryKeyStorage.Create(nil);
//    FSFTPClient.OnAuthenticationFailed := SftpClientAuthenticationFailed;
//    FSFTPClient.OnAuthenticationSuccess := SftpClientAuthenticationSuccess;
//    FSFTPClient.OnWork := SftpClientWork;
//    FSFTPClient.OnWorkBegin := SftpClientWorkBegin;
//    FSFTPClient.OnCloseConnection := SftpClientCloseConnection;
//    FSFTPClient.OnError := SftpClientError;
//    FSFTPClient.OnKeyValidate := SftpClientKeyValidate;
//
//
//    FSFTPClient.KeyStorage := FKeyStorage;
//    FSFTPClient.OnKeyValidate := SftpClientKeyValidate;
//
//    FSFTPClient.OnWork := SftpClientWork;
//    FSFTPClient.OnWorkBegin := SftpClientWorkBegin;
//
//    FSFTPClient.Host := Self.FFtpSite;
//    FSFTPClient.Port := 22;
//
//    FSFTPClient.Versions := [sbSFTP0, sbSFTP1, sbSFTP2, sbSFTP3, sbSFTP4, sbSFTP5, sbSFTP6];
//    FSFTPClient.Username := self.FFtpUserName;
//    FSFTPClient.Password := self.FFtpPassword;
//
//    FKeyStorage.Clear;
//    KeyFileName := ModuleFileNameUtils.GetCurrentModulePath + self.FFtpCertificate;
//    Key := TElSSHKey.Create;
//    try
//      Key.LoadPrivateKey(KeyFileName);
//      FKeyStorage.Add(Key);
//      FSFTPClient.AuthenticationTypes := FSFTPClient.AuthenticationTypes or SSH_AUTH_TYPE_PUBLICKEY;
//    finally
//      Key.Free;
//    end;
//    FSFTPClient.AuthenticationTypes := FSFTPClient.AuthenticationTypes or SSH_AUTH_TYPE_KEYBOARD;
//
//    Log('Connecting to ' + FSFTPClient.Address, ltDetail);
//
//    try
//      FSFTPClient.Connect;
//    except
//      on E: Exception do begin
//        Log('Sftp connection failed with message [' + E.Message + ']', ltDetail);
//      end;
//    end;
//    Log('Sftp connection established', ltDetail);
//
//  end;
//  result := FSFTPClient;
//end;
//
//function TSFTPClient.Connect: boolean;
//begin
//  result := false;
//  DirList.Clear;
//  if not Client.Connected then begin
//    try
//      Client.Connect;
//    except
//      Log('Could not connect to FTP site', ltError);
//      exit;
//    end;
//  end;
//  result := true;
//end;
//
//constructor TSFTPClient.Create;
//begin
//  DirList := TIdSFTPListItems.Create;
//  AppEnv.AppDb.Server:= 'localhost';
//  AppEnv.UtilsClient.OnLog := Log;
//end;
//
//destructor TSFTPClient.Destroy;
//begin
//  FSFTPClient.Free;
//  DirList.Free;
//  FKeyStorage.Free;
//
//  inherited;
//end;
//
//procedure TSFTPClient.Disconnect;
//begin
//  if Assigned(FSFTPClient) and FSFTPClient.Connected then
//    FSFTPClient.Disconnect;
//end;
//
//function TSFTPClient.GetFile(FileName: string; stream: TStream): boolean;
//begin
//  result := false;
//  if not Connect then exit;
//  try
//    Client.Get(FileName,stream);
//    result := true;
//  except
//    on e: exception do begin
//      Log('Error downloading file [' + FileName + ']: ' + e.Message, ltError);
//    end;
//  end;
//end;
//
//function TSFTPClient.GetFileList: boolean;
//begin
//  result := false;
//  DirList.Clear;
//  if not Client.Connected then begin
//    try
//      Client.Connect;
//    except
//      Log('Could not connect to FTP site', ltError);
//      exit;
//    end;
//  end;
//  try
//    Client.List(DirList);;
//    result := true;
//  except
//    Log('Could not get list of files from FTP site', ltError);
//    exit;
//  end;
//end;
//
//procedure TSFTPClient.Log(const msg: string; const aType: TLogMessageType);
//begin
//  if Assigned(fOnLog) then
//    fOnLog(msg, aType);
//end;
//
//procedure TSFTPClient.SftpClientAuthenticationFailed(Sender: TObject;
//  AuthenticationType: Integer);
//begin
//  Log('Authentication type [' + IntToStr(AuthenticationType) + '] failed', ltError);
//end;
//
//procedure TSFTPClient.SftpClientAuthenticationSuccess(Sender: TObject);
//begin
//  Log('Authentication succeeded', ltDetail);
//end;
//
//procedure TSFTPClient.SftpClientCloseConnection(Sender: TObject);
//begin
//  Log('Sftp connection closed', ltDetail);
//end;
//
//procedure TSFTPClient.SftpClientError(Sender: TObject; ErrorCode: Integer);
//begin
//  Log('Error ' + IntToStr(ErrorCode), ltError);
//end;
//
//procedure TSFTPClient.SftpClientKeyValidate(Sender: TObject;
//  ServerKey: TElSSHKey; var Validate: Boolean);
//begin
//  Log('Server key [' + DigestToStr(ServerKey.FingerprintMD5) + '] received', ltDetail);
//  Validate := true;
//end;
//
//procedure TSFTPClient.SftpClientWork(Sender: TObject; AWorkMode: TWorkMode;
//  AWorkCount: Int64);
//var
//  Percent: integer;
//begin
//  Processed := AWorkCount;
//  Percent := System.Round((Processed / ToProcess) * 100);
//  if Frac(Percent / 10) = 0 then begin
//    if fPercentDone <> Percent then begin
//      fPercentDone := Percent;
//      Log('Downloaded: ' + IntToStr(Percent) + ' %', ltInfo);
//    end;
//  end;
//end;
//
//procedure TSFTPClient.SftpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
//  AWorkCountMax: Int64);
//begin
//  ToProcess := AWorkCountMax;
//  Processed := 0;
//  Log('File size: ' + IntToStr(AWorkCountMax), ltDetail);
//end;


end.
