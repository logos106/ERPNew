unit CustomProcessObj;

interface

uses
  JsonObject, LogThreadBase, LogMessageTypes, ConTnrs;

type

  TCustomProcessItem = class(TObject)
  private
    fConfig: TJsonObject;
    FNextScheduleTime: TDateTime;
    FLogger: TLoggerBase;
    function GetConfigString: string;
    function GetName: string;
    procedure SetConfigString(const Value: string);
    procedure SetNextScheduleTime(const Value: TDateTime);
    procedure CalcNextScheduleTime;
    procedure SetLogger(const Value: TLoggerBase);
    procedure Log(const msg: string; LogMessageType: TLogMessageType = ltBlank);
  public
    constructor Create;
    destructor Destroy; override;
    property ConfigString: string read GetConfigString write SetConfigString;
    property Name: string read GetName;
    property NextScheduleTime: TDateTime read FNextScheduleTime write SetNextScheduleTime;
    procedure RunProcess;
    property Logger: TLoggerBase read FLogger write SetLogger;
  end;

  TCustomProcessList = class(TObject)
  private
    fList: TObjectList;
    FLogger: TLoggerBase;
    fLastConfigDownloadTime: TDateTime;
    fFirstCheckTime: TDateTime;
    procedure SetLogger(const Value: TLoggerBase);
    procedure UpdateFromConfig(config: TJsonObject);
    procedure Log(const msg: string; LogMessageType: TLogMessageType = ltBlank);
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read FLogger write SetLogger;
    procedure CheckCustomProcs;
  end;



implementation

uses
  SysUtils, FileDownLoadFuncs, InstallConst, UpdaterConst, AppRunUtils,
  JsonToObject;

{ TCustomProcessItem }

procedure TCustomProcessItem.CalcNextScheduleTime;
var
  x: integer;
  item: TJsonObject;
  dt, newDt: TDateTime;
begin
  newDt := 0;
  for x:= 0 to fConfig.A['Schedule'].Count - 1 do begin
    item := fConfig.A['Schedule'].Items[x].AsObject;
    dt:= FNextScheduleTime;
    if dt = 0 then dt := now
    else begin
      dt := dt + (item.O['Frequency'].I['Days']);
      dt := dt + (item.O['Frequency'].I['Hours'] * (1/24));
      dt := dt + (item.O['Frequency'].I['Mins'] * (1/24/60));
    end;
    if ((item.DT['DateFrom'] = 0) or (dt >= item.DT['DateFrom'])) and
       ((item.DT['DateTo'] = 0) or (dt <= item.DT['DateTo'])) then begin
      if SameText(item.S['DaysOfWeek'], 'All') or
        (Pos(Lowercase(FormatDateTime('ddd',dt)),Lowercase(item.S['DaysOfWeek'])) > 0) then begin
        if (Frac(dt) >= Frac(item.DT['TimeFrom'])) and (Frac(dt) <= Frac(item.DT['TimeTo'])) then begin
          if (newDt = 0) or (dt < newDt) then
            newDt := dt;
        end;
      end;
    end;
  end;
  FNextScheduleTime := newDt;
end;

constructor TCustomProcessItem.Create;
begin
  fConfig := JO;
  FNextScheduleTime := 0;
end;

destructor TCustomProcessItem.Destroy;
begin
  fConfig.Free;
  inherited;
end;

function TCustomProcessItem.GetConfigString: string;
begin
  result := fConfig.AsString;
end;

function TCustomProcessItem.GetName: string;
begin
  result := fConfig.S['Name'];
end;

procedure TCustomProcessItem.Log(const msg: string;
  LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg, LogMessageType);
end;

procedure TCustomProcessItem.RunProcess;
var
  aDownloadResult: TFileDownloadResult;
begin
    ForceDirectories(ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath']);
    if TFileDownloader.DownloadFile(WebUpdatesURL + fConfig.S['URL'] + fConfig.S['File'],
                                    ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File'], aDownloadResult, frReplaceIfNewer, false) then begin
      if aDownloadResult = drFileReplaced then
        Log('Downloaded new version of ' + ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File'], ltInfo);
    end
    else begin
      case aDownloadResult of
        drNone:;
        drConnectFailed: Log('Connection failed while downloading ' + WebUpdatesURL + fConfig.S['URL'] + fConfig.S['File'],ltError);
        drReplaceNotRequired:;
        drDownloadFailed: Log('Download failed while downloading ' + WebUpdatesURL + fConfig.S['URL'] + fConfig.S['File'],ltError);
        drFileReplaced:;
        drDownloadCancelled:;
      end;
    end;
    if FileExists(ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File']) then begin
      try
        if fConfig.S['RunParams'] <> '' then
          ExecNewProcess(ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File'] + ' ' + fConfig.S['RunParams'])
        else
          ExecNewProcess(ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File']);
        Log('Started process.', ltInfo);
      except
        on e: exception do begin
          Log('Error while running ' + ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File'] + ', with error: ' + e.Message, ltError);
        end;
      end;
    end
    else begin
      Log('Unable to run ' + ERP_SERVER_ROOT_DIR + fConfig.S['LocalPath'] + fConfig.S['File'] + ', file does not exist.', ltError);
    end;
end;

procedure TCustomProcessItem.SetConfigString(const Value: string);
begin
  fConfig.AsString := Value;
  CalcNextScheduleTime;
end;

procedure TCustomProcessItem.SetLogger(const Value: TLoggerBase);
begin
  FLogger := Value;
end;

procedure TCustomProcessItem.SetNextScheduleTime(const Value: TDateTime);
begin
  FNextScheduleTime := Value;
end;

{ TCustomProcessList }

procedure TCustomProcessList.CheckCustomProcs;
var
  json: TJsonObject;
  x: integer;
  item: TCustomProcessItem;
begin
  if now < fFirstCheckTime then exit;

  if now >= fLastConfigDownloadTime then begin
    { only check this every hour }
    fLastConfigDownloadTime := now + (1 /24);
    if TFileDownloader.DownloadFile(WebUpdatesURL + CustomProcConfigFile, ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + CustomProcConfigFile) then begin
      Log('Configuration file on the web has changed so downloading new copy.',ltInfo);
      json := JO;
      try
        EncryptedFileToJson(json, ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + CustomProcConfigFile);
        UpdateFromConfig(json);
      finally
        json.Free;
      end;
    end;
  end;
  if fList.Count = 0 then begin
    if FileExists(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + CustomProcConfigFile) then begin
      Log('Reading Custom Proc Configuration file.', ltDetail);
      json := JO;
      try
        EncryptedFileToJson(json, ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + CustomProcConfigFile);
        UpdateFromConfig(json);
      finally
        json.Free;
      end;
    end;
  end;
  if fList.Count = 0 then exit;
  for x := 0 to fList.Count -1 do begin
    item := TCustomProcessItem(fList[x]);
    if now >= item.FNextScheduleTime then begin
      try
        Log('Custom process ' + item.Name + ' needs to be run ..', ltInfo);
        item.RunProcess;


        item.CalcNextScheduleTime;
      except
      end;
    end;
  end;

end;

constructor TCustomProcessList.Create;
begin
  fList:= TObjectList.Create;
  fLastConfigDownloadTime := 0;
  fFirstCheckTime := now + ((1/24/60) * 5); // wait 5 mins
end;

destructor TCustomProcessList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TCustomProcessList.Log(const msg: string;
  LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg, LogMessageType);
end;

procedure TCustomProcessList.SetLogger(const Value: TLoggerBase);
begin
  FLogger := Value;
end;

procedure TCustomProcessList.UpdateFromConfig(config: TJsonObject);
var
  x: integer;
  item: TCustomProcessItem;
begin
  fList.Clear;
  for x := 0 to config.A['list'].Count -1 do begin
    item := TCustomProcessItem.Create;
    item.Logger := fLogger;
    item.ConfigString := config.A['list'].Items[x].AsObject.AsString;
    fList.Add(item);
  end;
end;

end.
