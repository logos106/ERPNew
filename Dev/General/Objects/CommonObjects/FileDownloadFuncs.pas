unit FileDownloadFuncs;

// {$I ERP.inc}
interface

uses
  IdHttp, IdComponent, ProgressDialog;

type

  TFileReplaceOption = (frReplaceNever, frReplaceAlways, frReplaceIfNewer, frReplaceIfSizeDifferent);
  TOnDataTransferProgress = procedure (percent: integer) of object;
  TFileDownloadResult = (drNone, drConnectFailed, drReplaceNotRequired, drDownloadFailed, drFileReplaced,drDownloadCancelled);
  THttpStatus = (hsNone, hsReading, hsWriting, hsBusy);

  TFileDownloader = class
  private
    FShowProgress: boolean;
    FURL: string;
    FFileName: string;
    FFileReplaceOption: TFileReplaceOption;
    fProgressDialog: TProgressDialog;
    fOnDataTransferProgress: TOnDataTransferProgress;
    fDownloadResult: TFileDownloadResult;
    fAborted: boolean;
    http: TIdHttp;
    HttpStatus :THttpStatus;
    procedure SetFileName(const Value: string);
    procedure SetFileReplaceOption(const Value: TFileReplaceOption);
    procedure SetShowProgress(const Value: boolean);
    procedure SetURL(const Value: string);
    procedure OnCancelHttpWork(Sender:TObject);
    procedure HttpDoWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    Procedure httpWorkBegin (ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    Procedure httpWorkend(ASender: TObject; AWorkMode: TWorkMode) ;
    function DoDownloadFile(const aURL, aFileName: string;
      ReplaceOption: TFileReplaceOption = frReplaceIfNewer;
      ShowProgressDialog: boolean = true;
      OnDataTransferProgressProc: TOnDataTransferProgress = nil): boolean;

  public
    constructor Create;
    destructor Destroy; override;
    property URL: string read FURL write SetURL;
    property FileName: string read FFileName write SetFileName;
    property ShowProgress: boolean read FShowProgress write SetShowProgress;
    property FileReplaceOption: TFileReplaceOption read FFileReplaceOption write SetFileReplaceOption;
    function DoDownload: boolean;
    property DownloadResult: TFileDownloadResult read fDownloadResult;
    property OnDataTransferProgress: TOnDataTransferProgress
    read fOnDataTransferProgress write fOnDataTransferProgress;
    class function DownloadFile(const aURL, aFileName: string;
      ReplaceOption: TFileReplaceOption = frReplaceIfNewer;
      ShowProgressDialog: boolean = true;
      OnDataTransferProgressProc: TOnDataTransferProgress = nil): boolean;overload;

    class function DownloadFile(const aURL, aFileName: string;
      var aDownloadResult: TFileDownloadResult;
      ReplaceOption: TFileReplaceOption = frReplaceIfNewer;
      ShowProgressDialog: boolean = true;
      OnDataTransferProgressProc: TOnDataTransferProgress = nil): boolean;overload;
    procedure Abortdownload;
  end;

implementation

uses
  classes, sysutils
//  {$IfDef COMPILER_22_UP}
  ,IdGlobalProtocols, AnsiStrings, HTTPConst
//  {$else}
//  ,IdGlobal
//  ,FastFuncs
//  {$endif}
  ,SystemLib, dateutils, windows{, InternetConnectivityUtils};

function ExtractUrlFileName(const AUrl: string): string;
var
  i: Integer;
begin
  i := LastDelimiter('/', AUrl);
  Result := Copy(AUrl, i + 1, Length(AUrl) - (i));
end;


{ TFileDownloader }

procedure TFileDownloader.Abortdownload;
begin
  fAborted:= true;
end;

constructor TFileDownloader.Create;
begin
  FShowProgress:= false;
  FFileReplaceOption:= frReplaceIfNewer;
  fDownloadResult:= drNone;
  fAborted:= false;
  HttpStatus := hsNone;
end;

destructor TFileDownloader.Destroy;
begin

  inherited;
end;

function TFileDownloader.DoDownload: boolean;
var
  stream: TFileStream;
  doDownload: boolean;
  fileDate: TDateTime;
  fileSize: integer;
begin
  result:= false;
  fDownloadResult:= drNone;
  fAborted:= false;
  doDownload:= true;
//  if InternetConnectivityUtils.InternetAccessOk(false) = false then begin
//       fDownloadResult:= drConnectFailed;
//       Exit;
//  end;
  http:= TIdHttp.Create(nil);
  try
    http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    http.OnWorkBegin :=httpWorkBegin;
    http.OnWorkend :=httpWorkend;
    case FFileReplaceOption of
      frReplaceNever:
        begin
          if FileExists(fFileName) then
            doDownload:= false
        end;
      frReplaceAlways: ;
      frReplaceIfNewer:
        begin
          if FileExists(fFileName) then begin
            try
              http.Head(fURL);
            except
              fDownloadResult:= drConnectFailed;
              exit;
            end;
            if http.Response.ContentLength > 0 then begin
              FileAge(fFileName,fileDate,true);
              fileSize:= FileSizeByName(fFileName);
              if (http.Response.ContentLength <> fileSize) or (SecondSpan(http.Response.lastmodified ,fileDate) > 5) then
                doDownload:= true
              else begin
                doDownload:= false;
                result:= true;
                fDownloadResult:= drReplaceNotRequired;
              end
            end;
          end;
        end;
      frReplaceIfSizeDifferent:
        begin
          if FileExists(fFileName) then begin
            try
              http.Head(fURL);
            except
             fDownloadResult:= drConnectFailed;
            end;
            if http.Response.ContentLength > 0 then begin
              fileSize:= FileSizeByName(fFileName);
              if (http.Response.ContentLength <> fileSize) then
                doDownload:= true
              else begin
                doDownload:= false;
                result:= true;
                fDownloadResult:= drReplaceNotRequired;
              end
            end;
          end;
        end;
    end;
    if doDownload then begin
      stream:= TFileStream.Create(fFileName,fmCreate);
      try
        http.OnWork:= HttpDoWork;
        try
          http.Get(fURL,stream);
          if fDownloadResult= drDownloadCancelled then begin
            if FileExists(fFileName) then sysutils.DeleteFile(ffileName);
            result:= False;
            Exit;
          end;
          result:= true;
        except
          result:= false;
          fDownloadResult:= drDownloadFailed;
        end;
      finally
        stream.Free;
        FreeAndNil(fProgressDialog);
      end;
      if FileExists(fFileName) then begin
        try
          if (http.Response.ContentLength > 0) and
             (FileSizeByName(fFileName) <> http.Response.ContentLength) then begin
            result:= false;
            SysUtils.DeleteFile(fFileName);
            fDownloadResult:= drDownloadFailed;
          end
          else begin
            SetFileDate(fFileName, http.Response.lastmodified);
            fDownloadResult:= drFileReplaced;
          end;
        except
          result:= false;
          fDownloadResult:= drDownloadFailed;
        end;
      end;
    end;
  finally
    http.Free;
  end;

end;

function TFileDownloader.DoDownloadFile(const aURL, aFileName: string;
  ReplaceOption: TFileReplaceOption; ShowProgressDialog: boolean;
  OnDataTransferProgressProc: TOnDataTransferProgress): boolean;
begin
    URL:= aURL;
    FileName:= aFileName;
    FileReplaceOption:= ReplaceOption;
    ShowProgress:= ShowProgressDialog;
    OnDataTransferProgress:= OnDataTransferProgressProc;
    result:= DoDownload;
end;

class function TFileDownloader.DownloadFile(const aURL, aFileName: string;
      ReplaceOption: TFileReplaceOption = frReplaceIfNewer;
      ShowProgressDialog: boolean = true;
      OnDataTransferProgressProc: TOnDataTransferProgress = nil): boolean;
begin
   with TFileDownloader.Create do begin
    result :=  DoDownloadFile(aURL, aFileName,ReplaceOption,ShowProgressDialog,OnDataTransferProgressProc);
    Free;
  end;
end;

class function TFileDownloader.DownloadFile(const aURL, aFileName: string;
  var aDownloadResult: TFileDownloadResult;
  ReplaceOption: TFileReplaceOption; ShowProgressDialog: boolean;
  OnDataTransferProgressProc: TOnDataTransferProgress): boolean;
begin
  with TFileDownloader.Create do begin
    result := DoDownloadFile(aURL, aFileName,ReplaceOption,ShowProgressDialog,OnDataTransferProgressProc);
    aDownloadResult:= DownloadResult;
    Free;
  end;
end;
procedure TFileDownloader.OnCancelHttpWork(Sender:TObject);
begin
  if (HttpStatus = hsReading) or (HttpStatus = hsWriting) then begin
    http.Disconnect;
    fDownloadResult:= drDownloadCancelled;
  end;
end;
Procedure TFileDownloader.httpWorkBegin (ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  if AWorkMode = wmRead then
    HttpStatus := hsReading
  else
    HttpStatus := hsWriting;
end;
Procedure TFileDownloader.httpWorkend(ASender: TObject; AWorkMode: TWorkMode) ;
begin
   HttpStatus := hsNone;
end;

procedure TFileDownloader.HttpDoWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if fAborted then begin
    http.Disconnect;
    exit;
  end;

  if AWorkMode = wmRead then begin
    if self.FShowProgress then begin
      if not Assigned(fProgressDialog) then begin
        fProgressDialog:= TProgressDialog.Create(nil);
        fProgressDialog.Caption:= 'Downloading File: ' + ExtractUrlFileName(fURL) + ' ...';
        fProgressDialog.Step:= 1;
        fProgressDialog.MaxValue:= TIdHttp(Sender).Response.ContentLength;
        fProgressDialog.AllowCancel := True;
        fProgressDialog.OnCancel := OnCancelHttpWork;
        fProgressDialog.Execute;
      end;
      fProgressDialog.Value:= AWorkCount;
    end;
    if Assigned(fOnDataTransferProgress) then
      fOnDataTransferProgress(Trunc((AWorkCount/TIdHttp(Sender).Response.ContentLength) * 100));
  end;
end;

procedure TFileDownloader.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TFileDownloader.SetFileReplaceOption(
  const Value: TFileReplaceOption);
begin
  FFileReplaceOption := Value;
end;

procedure TFileDownloader.SetShowProgress(const Value: boolean);
begin
  FShowProgress := Value;
end;

procedure TFileDownloader.SetURL(const Value: string);
begin
//  {$ifdef COMPILER_22_UP}
  FURL := StringReplace(Value, ' ' , '%20' , [rfReplaceAll]);
//  {$else}
//  FURL := StringReplace(Value, ' ' , '%20' , [rfReplaceAll]);
//  {$endif}
end;

end.
