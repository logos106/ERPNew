unit UpdaterCallUtils;

interface

uses
  JsonObject;

function StartUpdateCheck(var msg: string; Config: TJsonObject): boolean;
function GetModuleNameStr: String;

implementation

uses
  windows, sysutils,
  UpdaterConst, InternetConnectivityUtils, FileDownloadFuncs, AppRunUtils;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function StartUpdateCheck(var msg: string; Config: TJsonObject): boolean;
var
  path: string;
begin
  Result := True;
  try
    path := ExtractFilePath(GetModuleNameStr);

    { if we have internet access then check for new version of updater exe }
    if InternetAccessOk(config.B['displayprogress']) then begin
      if not TFileDownloader.DownloadFile(WebUpdatesURL + '/' + UpdaterAppName,
          path + UpdaterAppName,
          frReplaceIfNewer,config.B['displayprogress']) then begin
        Result := false;
        msg := 'Could not download the ERP Updater application from the internet.';
        Exit;
      end;
    end;

    if not FileExists(path + UpdaterAppName) then begin
      Result := False;
      msg := 'Could not check for updates as the ERP Updater application was not found (' +
        path + UpdaterAppName + ')';
      Exit;
    end;

    DeleteFile(path + UpdateControllFileName);
    { save data needed for update }
    Sleep(200);
    config.SaveToFile(path + UpdateControllFileName);
  finally
    config.Free;
  end;

  { run the updater }
  try
    ExecNewProcess(path + UpdaterAppName);
//    RunAsAdmin(path + UpdaterAppName, '');
  except
    on e: exception do begin
      Result := False;
      msg := 'An exception occurred wile running the updater with message: ' + e.Message;
    end;
  end;
end;


end.
