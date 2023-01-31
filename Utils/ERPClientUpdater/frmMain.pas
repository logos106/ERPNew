unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvProgressBar, StdCtrls, jpeg,
  LogMessageTypes, JsonRpcTcpClient, DNMSpeedButton;

type
  TfmMain = class(TForm)
    pnlTop: TPanel;
    Image1: TImage;
    lblProgress: TLabel;
    ProgressBar1: TAdvProgressBar;
    ProgressBar2: TAdvProgressBar;
    lblMessage: TLabel;
    Timer1: TTimer;
    btnClose: TDNMSpeedButton;
    lblError: TLabel;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    Path: string;
    Client: TJsonRpcTcpClient;
    StartTime: TDateTime;
    UpdateDone: boolean;
    procedure Log(const msg: string; aLogType: TLogMessageType);
    procedure DoUpdate;
    procedure DoError(const msg: string);
    procedure DoMainProgress(const msg: string; stepNo, stepCount: integer);
//    procedure DoOnDataTransferProgress(percent: integer);
    procedure EditConnectionINI(const aPath, aServerName, aDatabaseName: string);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  JsonObject, LogThreadLib, ModuleConst, SystemLib,
  InstallConst, strutils, ModuleUtils, CipherUtils, inifiles, ShellAPI,
  UpdateStoreObj, db;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function ExecAndWait(const Filename, Params: string;
                     WindowState: word; Wait: boolean = true): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
  WaitResult: integer;
begin
  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(NIL, PChar(CmdLine), NIL, NIL, FALSE,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS, NIL,
                          PChar(ExtractFilePath(Filename)),
                          SUInfo, ProcInfo);
  if Wait then begin
    { Wait for it to finish. }
    if Result then begin
      repeat
        Application.ProcessMessages;
        WaitResult:= WaitForSingleObject(ProcInfo.hProcess, 200);
      until WaitResult <> WAIT_TIMEOUT;
    end;
  end;
end;

function GetInnoLogAppName(aInnoLogFile: string): string;
var
  stream: TFileStream;
  ch: Char;
  x: integer;
begin
  result:= '';
  stream:= TFileStream.Create(aInnoLogFile,fmOpenRead);
  try
    stream.Position:= 64;
    for x:= 0 to 63 do begin
      stream.Read(ch,1);
      if Ord(ch) <> 0 then
        result:= result + ch;
    end;
  finally
    stream.Free;
  end;
  result:= Trim(result);
end;

{ will search aDir for innosetup log files (eg unins000.dat) and
  find the one that belongs to aAppName then if found
  run the coresponding uninstaller (eg unins000.exe) }
procedure UninstallApp(const aDir, aAppName: string);
var
  sr: TSearchRec;
  uninstFile: string;
begin
  if DirectoryExists(aDir) then begin
    uninstFile:= '';
    if FindFirst(aDir + 'unins???.dat', faAnyFile, sr) = 0 then begin
      repeat
        if GetInnoLogAppName(aDir + sr.Name) = aAppName then begin
          uninstFile:= sr.Name;
          Break;
        end;
      until FindNext(sr) <> 0;
    end;
    if uninstFile <> '' then begin
      uninstFile:= ChangeFileExt(uninstFile,'.exe');
      { run the uninstaller and wait }
      ExecNewProcess(aDir + uninstFile + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART', true);
    end;
  end;
end;

{Example Usage
 Path = c:\Temp\  Mask=*.tmp}
procedure DeleteFiles(const Path, Mask: string);
var
  lpFileOp: TSHFileOpStruct;
begin
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  // The + #0 is required
  lpFileOp.pFrom := PChar(Path + Mask + #0);
  lpFileOp.pTo := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  //Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;



{$R *.dfm}

procedure TfmMain.DoUpdate;
var
  config, configPart, o, resp: TJsonObject;
  partIdx: integer;
  sourceFile, destFile, destFile2: string;
  ServerUpdateBaseDir: string;
  msg: string;
  runParams: string;
  stepNo, stepCount: integer;
  partCount: integer;
  iniSave: TStringList;
  UpdateStore: TUpdateStore;

begin
  try
    config:= TJsonObject.Create;
    iniSave:= TStringList.Create;
    try
      stepCount:= 4;
      stepNo:= 1;
      DoMainProgress('Getting Update Info',stepNo,stepCount);
      Log('ERP Client Updater Started',ltInfo);
      if FileExists(Path + 'UpdateConfig.txt') then
        config.LoadFromFile(Path + 'UpdateConfig.txt')
      else
        config.LoadFromFile(SystemLib.WinTempDir + 'UpdateConfig.txt');


      if not config.StringExists('installpath') then begin
        DoError('Missing "installpath" information in configuration file.');
        exit;
      end;
      if FileExists(config.S['installpath'] + 'connection.ini') then
        iniSave.LoadFromFile(config.S['installpath'] + 'connection.ini');

      if not FileExists(Path + 'UpdateConfig.txt') then begin
        DoError('Could not find update configuration file: "' +
          Path + 'UpdateConfig.txt"');
        exit;
      end;
      Client.ServerName:= config.S['servername'];
      try
        Client.Connected:= true;
      except
      end;
      if not Client.Connected then begin
        DoError('Could not connect to ERP Utils Server: "' + config.S['servername'] + '"');
        exit;
      end;
      o:= JO;
      o.S['sessiontype']:= 'client';
      o.S['username']:= ERP_ADMIN_USER;
      resp:= Client.SendRequest('UserUtils.StartSession',o);
      if Assigned(resp) then begin
        try
          if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin

          end
          else begin
            { failed to establisg a session }
            DoError('Could not connect to ERP Utils Server: "' + config.S['servername'] + '"');
            exit;
          end;
        finally
          resp.Free;
        end;
      end
      else begin
        DoError('Could not connect to ERP Utils Server: "' + config.S['servername'] + '"');
        exit;
      end;

      { now process the updates }
      partCount:= config.O['update'].O['parts'].Count;
      if partCount = 0 then begin
        DoError('There where no update parts found in config file to process.');
        exit;
      end;
      stepCount:= (partCount * 2) + 2;
      for partIdx:= 0 to config.O['update'].O['parts'].Count -1 do begin
        Inc(StepNo);
        DoMainProgress('Processing Update',stepNo,stepCount);
        configPart:= config.O['update'].O['parts'].Items[partIdx].Value.AsObject;
        if configPart.S['type'] = 'innosetup' then begin
          { get the file }
          //ServerUpdateBaseDir:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\';
          ServerUpdateBaseDir := ERP_UPDATES_DIR;
          sourceFile:= ServerUpdateBaseDir + config.S['softwarereleasetype'] + '\' +
            configPart.S['file'];
          sourceFile:= AnsiReplaceStr(sourceFile,'/','\');
          Log('    Source file: "' + sourceFile + '"',ltInfo);
          destFile:= Path + ExtractFileName(sourceFile);
          Log('    Destination file: "' + destFile + '"',ltInfo);
          DoMainProgress('Downloading Update File',stepNo,stepCount);
          UpdateStore:= TUpdateStore.Create;
          try
            try
              UpdateStore.Server:= config.S['servername'];
              with UpdateStore.VersionUpdates(config.S['module'],config.S['version'],config.O['update'].O['parts'].Items[partIdx].Name) do begin
                if RecordCount = 0 then begin
                  DoError('Error - update not found on server for Module: "' + config.S['module'] +
                    '"  Version: "' + config.S['version'] + '" Part: " ' + config.O['update'].O['parts'].Items[partIdx].Name + '"');
                  exit;
                end;
                TBlobField(FieldByName('File')).SaveToFile(destFile);
              end;
            except
              on e: exception do begin
                DoError('Error getting update file from server: ' + e.Message);
                exit;
              end;
            end;
          finally
            UpdateStore.Free;
          end;
          try
            Inc(StepNo);
            DoMainProgress('Preparing Update',stepNo,stepCount);
            Application.ProcessMessages;
            destfile2:= ChangeFileExt(destFile,'.exe');
            CipherUtils.DecryptInThread(destFile, DestFile2);

            runParams:= ' /VERYSILENT /NORESTART';
            runParams:= runParams + ' /DIR="' + config.S['installpath'] + '"';
            if configPart.StringExists('installpassword') then
              runParams:= runParams + ' /PASSWORD=' + configPart.S['installpassword'];
  //          runParams:= runParams + ' /LOG="' + ChangeFileExt(destfile2,'.log') + '"';
            DoMainProgress('Installing Update',stepNo,stepCount);
            if not ExecAndWait(destFile2,runParams,SW_HIDE,true) then begin
              DoError('An error occured while installing the update.');
              exit;
            end;
            { if this is the user install (ie erp.exe) need to
              check if it needs to renamed }
            if Copy(Lowercase(ExtractFileName(destFile2)),1,4) = 'user' then begin
              if config.StringExists('erpfilename') and (Lowercase(config.S['erpfilename']) <> 'erp.exe') then begin
                DeleteFile(config.S['installpath'] + config.S['erpfilename']);
                if RenameFile(config.S['installpath'] + 'erp.exe',config.S['installpath'] + config.S['erpfilename']) then begin
                  DeleteFile(config.S['installpath'] + 'erp.exe');
                end;
              end;
            end;
          finally
            DeleteFile(destFile);
            DeleteFile(destFile2);
          end;
        end
        else begin
          Inc(StepNo);
        end;
      end;

      { clean up and restart }
      { restore the saved connection info }
      if FileExists(config.S['installpath'] + 'connection.ini') then
        iniSave.SaveToFile(config.S['installpath'] + 'connection.ini');

      { make sure we are looking at reight db for restart of erp }
      EditConnectionINI(config.S['installpath'],config.S['servername'],config.S['databasename']);


      {  tempory code to uninstall old client updater }
      if FileExists('C:\ERP Software\User Updater\UsrUpdater.exe') then begin
        UninstallApp('C:\ERP Software\User Updater\','ERP Software User Updater');
      end;

      if DirectoryExists('C:\ERP Software\User Updater') then begin
        DeleteFiles('C:\ERP Software\User Updater\','*.*');
        RemoveDirectory('C:\ERP Software\User Updater');
      end;


      Timer1.Enabled:= false;
      ProgressBar2.Position:= 0;
      DoMainProgress('All Done!',stepCount,stepCount);
      Application.ProcessMessages;
      Sleep(1000);

      { restart new erp version}
      ExecAndWait(config.S['installpath'] + config.S['erpfilename'],'',SW_NORMAL,false);

    finally
      iniSave.Free;
      Client.Connected:= false;
      config.Free;
      Log('ERP Client Updater Finished',ltInfo);
    end;
  except
    on e: exception do begin
      DoError('Error: ' + e.Message);
    end;
  end;
  Close;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position > 0 then begin
    if ProgressBar2.Position = 100 then
      ProgressBar2.Position:= 1
    else
      ProgressBar2.Position:= ProgressBar2.Position + 1;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  TLogger.Inst.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  Path:= ExtractFilePath(GetModuleNameStr);
  Client:= TJsonRpcTcpClient.Create;
  lblError.Caption:= '';
  btnClose.Enabled:= false;
  UpdateDone:= false;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;

procedure TfmMain.Log(const msg: string; aLogType: TLogMessageType);
begin
  TLogger.Inst.Log(msg,aLogType);
  Application.ProcessMessages;
end;

procedure TfmMain.DoError(const msg: string);
begin
  Timer1.Enabled:= false;
  Log(msg,ltError);
  lblError.Caption:= msg;
  btnClose.Enabled:= true;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  StartTime:= now;
end;

procedure TfmMain.Timer2Timer(Sender: TObject);
const
  OneSec = 1/24/60/60;
begin
  if (not UpdateDone) and ((StartTime + (OneSec)) > now) then begin
    UpdateDone:= true;
    DoUpdate;
  end;
end;

procedure TfmMain.DoMainProgress(const msg: string; stepNo,
  stepCount: integer);
begin
  Log(msg,ltInfo);
  lblProgress.Caption:= msg;
  ProgressBar1.Position:= Round((StepNo/stepCount) * 100);
end;

//procedure TfmMain.DoOnDataTransferProgress(percent: integer);
//begin
//  ProgressBar2.Position:= percent;
//end;

procedure TfmMain.EditConnectionINI(const aPath, aServerName,aDatabaseName: string);
var
  ini: TIniFile;
begin
  { make sure connection.ini is pointing to right database for restart }
  ini:= TIniFile.Create(Path + 'connection.ini');
  try
    ini.WriteString('Last_Database','Server',aServerName);
    ini.WriteString('Last_Database','Database',aDatabaseName);
  finally
    ini.Free;
  end;  
end;

end.
