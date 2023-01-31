unit SendFaxesThread;
{$I EmailFaxServerSrv.inc}
interface

uses
  Forms, Classes, MyAccess, DB, AdFaxCvt, AdFax, OoMisc, AdPort, AdExcept;

type
  TSendFaxesThread = class(TThread)
  private
    { Private declarations }
    DBConnection: TMyConnection;
    TempFaxID: integer;
    FaxCount: integer;
    FaxFilePaths: TStringList;
    FaxGraphicsPaths: TStringList;
    qryFaxSpool: TMyQuery;
    qryFaxSpoolDocs: TMyQuery;
    ComPort: TApdComPort;
    FaxOutput: TApdSendFax;
    fSendingFax: boolean;
    procedure SendNextFax;
    function ConvertGraphicsFilesToFaxFiles: boolean;
    procedure SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string);
    function GetComPort: integer;
    function GetFaxName: string;
    function GetFaxNumber(const FaxSpoolID: integer): string;
    function GetCoverNoteDetails(var ClientName, EmployeeName, FaxNumber, Phone, Pages, Notes: string;const FaxSpoolID: integer): boolean;
    procedure ModifyStatus(const FaxStatus: string; const FaxSpoolID: integer);
    function ExportGraphicsFilesFromDB(const FaxSpoolID: integer): boolean;    
    function GetNextFaxID(Const IsTest: Boolean): integer;
    procedure AddToFaxLog(const LogEntry: string; const FaxSpoolID: integer);
    procedure CreateFaxTempDir;
    procedure ClearFaxFilePathsList;
    procedure ClearGraphicsFilePathsList;
    procedure DeleteFaxTempDir;
    function CoverNoteExists(const FaxSpoolID: integer): boolean;
    procedure AddToFaxCoverSheet(const FaxSpoolID: integer);
    function AddFaxDocToSpool(const FileName: string): boolean;
    procedure AddToGraphicsFilePathsList(const FilePath: string);
    procedure AddToFaxFilePathsList(const FilePath: string);
    procedure InitFaxComponents(const FaxSpoolID: integer);
    procedure SetStartedSending(const FaxSpoolID: integer);
    procedure ApplyRetry(const FaxSpoolID: integer; const TempFaxStatus: string);
    procedure FaxOutputFaxFinish(CP: TObject; ErrorCode: integer);
    procedure FaxOutputFaxError(CP: TObject; ErrorCode: Integer);
    procedure SetFinishedSending(const FaxSpoolID: integer);
    procedure SetSentOKFlag(const FaxSpoolID: integer);
    function GetRetryCount(const FaxSpoolID: integer): integer;
    procedure SetRetryCount(const FaxSpoolID: integer);
    procedure SetRetryInMins(const FaxSpoolID, Minutes: integer);
    procedure DeleteDocs(const FaxSpoolID: integer);
    procedure SendFax(const FaxSpoolID: integer);
    procedure CheckThreadError(ErrCode: Integer); overload;
    procedure CheckThreadError(Success: Boolean); overload;
  protected
    procedure Execute; override;
  public
    Database: String;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function WaitFor: LongWord; reintroduce;
  end;
implementation

Uses ActiveX, SysUtils,EmailFaxServerLib, EmailFaxServerUnit, Graphics, GR32,
  ReportTemplates, Windows, formsize, ExcMagic, FastFuncs;

{ SendFaxesThread }

procedure TSendFaxesThread.Execute;
begin
  CoInitialize(nil);
  Try
    inherited;
    fSendingFax := false;
    Try
      DBConnection := CreateDBConnection(nil, Database);
      if not Assigned(DBConnection) then Exit;
      GetNextFaxID(True);
      LogsLib.AddLogBoth('('+InttoStr(FaxCount)+') Faxes to Send');
      While (GetNextFaxID(True)<>0) AND not fSendingFax do Begin
        fSendingFax := True;
        try
          SendNextFax;
        finally
          DeleteFaxTempDir;
        end;
      end;
      DBConnection.Disconnect;
    Finally
      SysUtils.FreeAndNil(DBConnection);
    end;
  Finally
    CoUninitialize();
  end;
end;

procedure TSendFaxesThread.SendNextFax;
var
  FaxID: integer;
begin
  FaxFilePaths := TStringList.Create;
  FaxGraphicsPaths := TStringList.Create;
  CreateFaxTempDir;
  FaxID := GetNextFaxID(False);
  try
    try
      //Get Next Fax
      TempFaxID := FaxID;
      if FaxID = 0 then begin
        DeleteFaxTempDir;
        fSendingFax := false;
        Exit;
      end;
      //Create Cover Sheet
      if not CoverNoteExists(TempFaxID) then AddToFaxCoverSheet(TempFaxID);
      //Get Pages To Send
      LogsLib.AddLogBoth('----------------');
      LogsLib.AddLogBoth('Preparing to Fax - '+Fastfuncs.IntToStr(FaxID));
      AddToFaxLog('----------------', TempFaxID);
      AddToFaxLog('Preparing to Fax', FaxID);
      ClearGraphicsFilePathsList;
      ExportGraphicsFilesFromDB(FaxID);
      //Convert Pages To Fax Format
      ClearFaxFilePathsList;
      ConvertGraphicsFilesToFaxFiles;
      LogsLib.AddLogBoth('Ready To Fax');
      AddToFaxLog('Ready To Fax', FaxID);
     except
       on E: Exception do Begin
          LogsLib.AddLogBoth('Failed to Fax - '+Fastfuncs.IntToStr(FaxID)+' ~ Errors on :- '+Trim(E.Message));
          ModifyStatus('Failed', FaxID);
          AddToFaxLog('Failed', FaxID);
          fSendingFax := false;
          Exit;
       end;
    end;
    //Send it
    SendFax(FaxID);
    While FaxOutput.InProgress do Begin
      Sleep(0);  {TApdSendFax performs time-critical handshaking with the receiving fax device, where tolerance for delays is very low }
      Application.ProcessMessages;
      EmailFaxServer.ServiceThread.ProcessRequests(false);      
    end;
  finally
    ClearFaxFilePathsList;
    ClearGraphicsFilePathsList;
    FreeAndNil(FaxFilePaths);
    FreeAndNil(FaxGraphicsPaths);
  end;
end;

procedure TSendFaxesThread.CreateFaxTempDir;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)) + '\FaxTemp');
end;

procedure TSendFaxesThread.ClearFaxFilePathsList;
begin
  FaxFilePaths.Clear;
end;

procedure TSendFaxesThread.ClearGraphicsFilePathsList;
begin
  FaxGraphicsPaths.Clear;
end;

function TSendFaxesThread.GetNextFaxID(Const IsTest: Boolean): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := DBConnection;
  try
    qryTemp.Sql.Add('SELECT FaxSpoolID,Status FROM `tblfaxspool` WHERE Status="Spooled" AND  Cancelled<>"T" AND');
    qryTemp.Sql.Add('((DATE_ADD(DateStarted, INTERVAL RetryInMins MINUTE) < Now()) OR IsNull(DateStarted))');
    qryTemp.Sql.Add('Order BY Priority Desc,DateSpooled;');
    qryTemp.Active := true;
    FaxCount := qryTemp.RecordCount;
    if not qryTemp.IsEmpty then begin
      qryTemp.First;
      Result := qryTemp.FieldByName('FaxSpoolID').AsInteger;
      If not IsTest then Begin
        qryTemp.Edit;
        qryTemp.FieldByName('Status').AsString := 'Preparing to Send';
        qryTemp.Post;
      end;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TSendFaxesThread.DeleteFaxTempDir;
begin
  DeleteFiles(ExtractFilePath(ParamStr(0)), '\FaxTemp\*.BMP');
  DeleteFiles(ExtractFilePath(ParamStr(0)), '\FaxTemp\*.FAX');
  RemoveDir(ExtractFilePath(ParamStr(0)) + '\FaxTemp');
end;

procedure TSendFaxesThread.AddToFaxCoverSheet(const FaxSpoolID: integer);
var
  SQL: string;
  TempFaxDocPath, ClientName, EmployeeName, FaxNumber, Phone, Pages, Notes: string;
begin
  if GetCoverNoteDetails(ClientName, EmployeeName, FaxNumber, Phone, Pages, Notes, FaxSpoolID) then begin;
    SQL :=
      'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ,'
      + '"' + ReplaceStr(ClientName, '"', #39#39) + ' " as `To`,  "' + ReplaceStr(EmployeeName, '"',
      #39#39) + ' " as `From` ,  "' + ReplaceStr(FaxNumber, '"', #39#39) + ' " as `FaxNumber` , CURDATE() as `Date`, ' +
      '"' + ReplaceStr(Phone, '"', #39#39) + ' " as Phone  , "' + ReplaceStr(Pages, '"', #39#39) +
      ' " as Pages , "' + ReplaceStr(Notes, '"', #39#39) + ' " as Notes ' + 'FROM tblCompanyInformation AS CO;';

    SaveTemplateReport('Fax Cover Sheet', SQL, true, 'GraphicFile');

    qryFaxSpoolDocs := TMyQuery.Create(nil);
    qryFaxSpoolDocs.Connection := DBConnection;
    try
      qryFaxSpoolDocs.Sql.Add('SELECT FaxSpoolID,FaxDoc,SendOrder FROM tblfaxspooldocs limit 1;');
      qryFaxSpoolDocs.Active := true;
      TempFaxDocPath := ExtractFilePath(ParamStr(0)) + 'IMG0001.bmp';
      if FileExists(TempFaxDocPath) then begin
        qryFaxSpoolDocs.Append;
        qryFaxSpoolDocs.FieldByName('FaxSpoolID').AsInteger := FaxSpoolID;
        qryFaxSpoolDocs.FieldByName('SendOrder').AsInteger := 1;
        AddFaxDocToSpool(TempFaxDocPath);
        qryFaxSpoolDocs.Post;
      end;
    finally
      FreeAndNil(qryFaxSpoolDocs);
    end;
  end
end;

function TSendFaxesThread.CoverNoteExists(const FaxSpoolID: integer): boolean;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := DBConnection;
  try
    qryTemp.Sql.Add('SELECT tblfaxspoolDocsID FROM tblfaxspooldocs WHERE SendOrder=1 AND FaxSpoolID =' +
      IntToStr(FaxSpoolID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TSendFaxesThread.AddToFaxLog(const LogEntry: string; const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,Description FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      if Empty(qryFaxSpool.FieldByName('Description').AsString) then begin
        qryFaxSpool.FieldByName('Description').AsString := LogEntry + '-' + DateTimeToStr(Now());
      end else begin
        qryFaxSpool.FieldByName('Description').AsString := qryFaxSpool.FieldByName('Description').AsString +
          #13 + #10 + LogEntry + '-' + DateTimeToStr(Now());
      end;
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

function TSendFaxesThread.ExportGraphicsFilesFromDB(const FaxSpoolID: integer): boolean;
var
  ms: TMemoryStream;
  sFile: string;
  qryTemp: TMyQuery;
  PagesCount: integer;

  procedure RotateLandscape(Const sFilePath: String);
  var
    SrcBitmap,DstBitmap: TBitmap32;
  begin
    SrcBitmap := TBitmap32.Create;
    DstBitmap := TBitmap32.Create;
    Try
      SrcBitmap.LoadFromFile(sFilePath);
      If (SrcBitmap.Width > SrcBitmap.Height) then Begin
        SrcBitmap.Rotate90(DstBitmap);
        DstBitmap.SaveToFile(sFilePath);
      end;
    finally
      FreeAndNil(SrcBitmap);
      FreeAndNil(DstBitmap);
    end;
  end;

begin
  qryTemp := TMyQuery.Create(nil);
  try
    qryTemp.Connection := DBConnection;
    qryTemp.Sql.Add('SELECT tblfaxspoolDocsID,FaxDoc FROM `tblfaxspooldocs` WHERE FaxSpoolID = ' + IntToStr(FaxSpoolID));
    qryTemp.Sql.Add(' Order By SendOrder ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      qryTemp.First;
      PagesCount := 0;
      while not qryTemp.Eof do begin
        PagesCount := PagesCount + 1;
        ms := TMemoryStream.Create;
        try
          TBlobField(qryTemp.FieldByName('FaxDoc')).SaveToStream(ms);
          sFile := ExtractFilePath(ParamStr(0)) + 'FaxTemp\FaxPage' + IntToStr(PagesCount) + '.bmp';
          ms.SaveToFile(sFile);
          ms.Clear;          
          RotateLandscape(sFile);
          AddToGraphicsFilePathsList(sFile);
        finally
          FreeAndNil(ms);
        end;
        qryTemp.Next;
      end;
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TSendFaxesThread.ConvertGraphicsFilesToFaxFiles: boolean;
var
  GraphicToFaxConverter: TApdFaxConverter;
  I: integer;
begin
  GraphicToFaxConverter := TApdFaxConverter.Create(nil);
  try
    GraphicToFaxConverter.InputDocumentType := idBmp;
    GraphicToFaxConverter.Resolution        := frNormal;
    GraphicToFaxConverter.Width := fwNormal;
    for I := 0 to FaxGraphicsPaths.Count - 1 do begin
      GraphicToFaxConverter.DocumentFile := FaxGraphicsPaths[I];
      GraphicToFaxConverter.OutFileName := ReplaceStr(UpperCase(FaxGraphicsPaths[I]), '.BMP', '.FAX');
      GraphicToFaxConverter.ConvertToFile;
      AddToFaxFilePathsList(GraphicToFaxConverter.OutFileName);
    end;
    Result := true;
  finally
    FreeAndNil(GraphicToFaxConverter);
  end;
end;

procedure TSendFaxesThread.ModifyStatus(const FaxStatus: string; const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,Status FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('Status').AsString := FaxStatus;
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SendFax(const FaxSpoolID: integer);
begin
  ExcMagic.ExceptionHook.LogEnabled := False;
  Try
    try
      InitFaxComponents(FaxSpoolID);
      LogsLib.AddLogBoth('Fax Initialised');
      AddToFaxLog('Fax Initialised', FaxSpoolID);
      TempFaxID    := FaxSpoolID;
      FaxOutput.FaxFileList := FaxFilePaths;
      FaxOutput.PhoneNumber := GetFaxNumber(FaxSpoolID);
      ComPort.Open := true;
      LogsLib.AddLogBoth('Port Open');
      AddToFaxLog('Port Open', FaxSpoolID);
      SetStartedSending(FaxSpoolID);
      FaxOutput.StartTransmit;
      LogsLib.AddLogBoth('Sending');
      AddToFaxLog('Sending', FaxSpoolID);
      ModifyStatus('Sending', FaxSpoolID);
    except
      on E: Exception do Begin
        ApplyRetry(FaxSpoolID,'Transmit Failed');
        LogsLib.AddLogBoth('Errors on :- '+Trim(E.Message));
      end;
    end;
  Finally
    ExcMagic.ExceptionHook.LogEnabled := True;
  end;
end;

function TSendFaxesThread.GetCoverNoteDetails(var ClientName, EmployeeName, FaxNumber, Phone, Pages, Notes: string; const FaxSpoolID: integer): boolean;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := DBConnection;
  try
    qryTemp.Sql.Add('SELECT tblfaxspool.FaxSpoolID, tblfaxspool.ClientName, tblfaxspool.EmployeeName, ');
    qryTemp.Sql.Add('tblfaxspool.FaxNumber,tblclients.Phone,  Count(tblfaxspoolDocsID) as Pages,CoverSheetNotes ');
    qryTemp.Sql.Add('FROM tblfaxspool ');
    qryTemp.Sql.Add('INNER JOIN tblfaxspooldocs USING(FaxSpoolID) ');
    qryTemp.Sql.Add('INNER JOIN tblclients  ON tblfaxspool.ClientName = tblclients.Company ');
    qryTemp.Sql.Add('WHERE tblfaxspool.UseCoverSheet="T" and tblfaxspool.FaxSpoolID = ' + IntToStr(FaxSpoolID) + ' ');
    qryTemp.Sql.Add('GROUP By FaxSpoolID; ');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      ClientName := qryTemp.FieldByName('ClientName').AsString;
      EmployeeName := qryTemp.FieldByName('EmployeeName').AsString;
      FaxNumber := qryTemp.FieldByName('FaxNumber').AsString;
      Phone := qryTemp.FieldByName('Phone').AsString;
      Pages := qryTemp.FieldByName('Pages').AsString;
      Notes := qryTemp.FieldByName('CoverSheetNotes').AsString;
      Result := true;
    end else begin
      ClientName := '';
      EmployeeName := '';
      FaxNumber := '';
      Phone := '';
      Pages := '';
      Notes := '';
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TSendFaxesThread.AddFaxDocToSpool(const FileName: string): boolean;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.LoadFromFile(FileName);
    TBlobField(qryFaxSpoolDocs.FieldByName('FaxDoc')).LoadFromStream(ms);
    Result := true;
  finally
    FreeAndNil(ms);
  end;
end;

procedure TSendFaxesThread.AddToGraphicsFilePathsList(const FilePath: string);
begin
  if Assigned(FaxGraphicsPaths) then begin
    FaxGraphicsPaths.Add(FilePath);
  end;
end;

procedure TSendFaxesThread.AddToFaxFilePathsList(const FilePath: string);
begin
  if Assigned(FaxFilePaths) then begin
    FaxFilePaths.Add(FilePath);
  end;
end;

procedure TSendFaxesThread.InitFaxComponents(const FaxSpoolID: integer);
begin
  ///////////////////
  //ComPort Setup
  ComPort.BufferFull := 7372;
  ComPort.BufferResume := 819;
  ComPort.HWFlowOptions := [hwfUseRTS, hwfRequireCTS];
  ComPort.InSize := 8192;
  ComPort.OutSize := 8192;
  ComPort.ComNumber := GetComPort;

  ////////////
  //Fax Setup
  FaxOutput.DesiredBPS := 14400;
  FaxOutput.DialAttempts := 1;
  FaxOutput.DialWait := 60;
  FaxOutput.StationID := GetFaxName;
  FaxOutput.ComPort := ComPort;  
  FaxOutput.OnFaxFinish := FaxOutputFaxFinish;
  FaxOutput.OnFaxError := FaxOutputFaxError;
end;

function TSendFaxesThread.GetFaxNumber(const FaxSpoolID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := DBConnection;
  try
    qryTemp.Sql.Add('SELECT FaxSpoolID,FaxNumber FROM tblfaxspool WHERE FaxSpoolID = ' + IntToStr(FaxSpoolID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := Trim(qryTemp.FieldByName('FaxNumber').AsString);
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TSendFaxesThread.SetStartedSending(const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,DateStarted FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('DateStarted').AsDateTime := Now();
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.ApplyRetry(const FaxSpoolID: integer; const TempFaxStatus: string);
var
  Count: integer;
begin
  Count := GetRetryCount(FaxSpoolID);
  case Count of
    0:
      begin
        SetRetryCount(FaxSpoolID);
        SetRetryInMins(FaxSpoolID, 1);
        LogsLib.AddLogBoth('Attempt 1 Failed : [' + TempFaxStatus + ']');
        AddToFaxLog('Attempt 1 Failed : [' + TempFaxStatus + ']', FaxSpoolID);
        ModifyStatus('Spooled', FaxSpoolID);
        LogsLib.AddLogBoth('Respooled - Retry In 1 Min');
      end;
    1:
      begin
        SetRetryCount(FaxSpoolID);
        SetRetryInMins(FaxSpoolID, 5);
        LogsLib.AddLogBoth('Attempt 2 Failed : [' + TempFaxStatus + ']');
        AddToFaxLog('Attempt 2 Failed : [' + TempFaxStatus + ']', FaxSpoolID);
        ModifyStatus('Spooled', FaxSpoolID);
        LogsLib.AddLogBoth('Respooled - Retry In 5 Mins');
      end;
    2:
      begin
        SetRetryCount(FaxSpoolID);
        SetRetryInMins(FaxSpoolID, 15);
        LogsLib.AddLogBoth('Attempt 3 Failed : [' + TempFaxStatus + ']');
        AddToFaxLog('Attempt 3 Failed : [' + TempFaxStatus + ']', FaxSpoolID);
        ModifyStatus('Spooled', FaxSpoolID);
        LogsLib.AddLogBoth('Respooled - Retry In 15 Mins');
      end;
    3:
      begin
        LogsLib.AddLogBoth('Attempt 4 Failed : [' + TempFaxStatus + ']');
        AddToFaxLog('Attempt 4 Failed : [' + TempFaxStatus + '] ', FaxSpoolID);
        ModifyStatus('Failed', FaxSpoolID);
        LogsLib.AddLogBoth('Failed 4 Attempts');
      end;
  end;
end;

function TSendFaxesThread.GetComPort: integer;
begin
 Result := FastFuncs.StrToInt(EmailFaxServer.INI_Options.ComPort);
end;

function TSendFaxesThread.GetFaxName: string;
begin
 Result := EmailFaxServer.INI_Options.FaxName;
end;

procedure TSendFaxesThread.FaxOutputFaxError(CP: TObject; ErrorCode: Integer);
var
  TempFaxStatus: string;
begin
  TempFaxStatus := ErrorMsg(ErrorCode);
  if ErrorCode <> 0 then
    ApplyRetry(TempFaxID,TempFaxStatus);
  FaxOutput.CancelFax;
  ComPort.DonePort;
  DeleteFaxTempDir;
  fSendingFax := false;
end;

procedure TSendFaxesThread.FaxOutputFaxFinish(CP: TObject; ErrorCode: integer);
var
  TempFaxStatus: string;
begin
  TempFaxStatus := ErrorMsg(ErrorCode);
  if ErrorCode <> 0 then begin
    ApplyRetry(TempFaxID,TempFaxStatus);
  end else begin
    SetFinishedSending(TempFaxID);
    LogsLib.AddLogBoth('Sent Successfully');
    AddToFaxLog('Completed Successfully', TempFaxID);
    AddToFaxLog('----------------', TempFaxID);
    ModifyStatus('Successful', TempFaxID);
    SetSentOKFlag(TempFaxID);
    DeleteDocs(TempFaxID);
    FaxOutput.FaxFileList.Clear;
    FaxOutput.PhoneNumber := '';
  end;
  ComPort.DonePort;
  DeleteFaxTempDir;
  fSendingFax := false;
end;

function TSendFaxesThread.GetRetryCount(const FaxSpoolID: integer): integer;
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,RetryCount FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.IsEmpty then begin
      Result := qryFaxSpool.FieldByName('RetryCount').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SetRetryCount(const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,RetryCount FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('RetryCount').AsInteger := qryFaxSpool.FieldByName('RetryCount').AsInteger + 1;
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SetRetryInMins(const FaxSpoolID, Minutes: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,RetryInMins FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('RetryInMins').AsInteger := Minutes;
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SetFinishedSending(const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  try
    qryFaxSpool.Connection := DBConnection;
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,DateCompleted FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('DateCompleted').AsDateTime := Now();
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SetSentOKFlag(const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('SELECT FaxSpoolID,SentOk FROM tblfaxspool WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    qryFaxSpool.Active := true;
    if not qryFaxSpool.Eof then begin
      qryFaxSpool.Edit;
      qryFaxSpool.FieldByName('SentOk').AsString := 'T';
      qryFaxSpool.Post;
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.DeleteDocs(const FaxSpoolID: integer);
begin
  qryFaxSpool := TMyQuery.Create(nil);
  qryFaxSpool.Connection := DBConnection;
  try
    qryFaxSpool.Sql.Add('DELETE FROM tblfaxspooldocs WHERE FaxSpoolID=' + IntToStr(FaxSpoolID) + ';');
    try
    {$IFNDEF DevMode}
      qryFaxSpool.Execute;
    {$ENDIF}
    except
    end;
  finally
    FreeAndNil(qryFaxSpool);
  end;
end;

procedure TSendFaxesThread.SaveTemplateReport(const ReportName,SQLPortion: string; const DoPrint: boolean; const FileType: string);
var
  FileExt: string;
begin
  if not empty(ReportName) then begin
    with TReportTemplates.Create do try
      DBConnection := Self.DBConnection;
      with GetMyQuery(1) do begin
        Close;
        Connection := DBConnection;
        Sql.Clear;
        Sql.Add(GetSQLForReport(ReportName));
        Sql.Clear;
        ParamCheck := false;
        Sql.Add(SQLPortion);
        Open;
      end;
      ReportStream.Position := 0;
      Report.Template.LoadFromStream(ReportStream);
      Report.AllowPrintToFile := true;
      Report.ShowPrintDialog := false;
      Report.DeviceType := FileType;

      if FileType = 'HTMLFile' then FileExt := 'HTM';
      if FileType = 'GraphicFile' then FileExt := 'BMP';
      if FileType = 'PDFFile' then FileExt := 'PDF';

      Report.TextFileName := ExtractFilePath(ParamStr(0)) + 'FaxTemp\CoverSheet.' + FileExt;
      Report.Print;

    finally
      Free;
    end;
  end;
end;


constructor TSendFaxesThread.Create(CreateSuspended: Boolean);
begin
  Inherited Create(CreateSuspended);
  ComPort := TApdComPort.Create(nil);
  FaxOutput := TApdSendFax.Create(nil);
end;

destructor TSendFaxesThread.Destroy;
begin
  ComPort.DonePort;
  FreeAndNil(ComPort);
  FreeAndNil(FaxOutput);
  DBConnection.Disconnect;
  SysUtils.FreeAndNil(DBConnection);
  inherited;
end;

function TSendFaxesThread.WaitFor: LongWord;
var
  H: THandle;
  WaitResult: Cardinal;
  Msg: TMsg;
begin
  H := Self.Handle;
  if GetCurrentThreadID = MainThreadID then
  begin
    WaitResult := 0;
    repeat
      Application.ProcessMessages;
      if WaitResult = WAIT_OBJECT_0 + 1 then
        PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE);
      Sleep(0);
      Application.ProcessMessages;
      CheckSynchronize;
      Application.ProcessMessages;
      WaitResult := MsgWaitForMultipleObjects(1, H, False, 1, QS_SENDMESSAGE);
      Application.ProcessMessages;
      {$WARN SYMBOL_PLATFORM OFF}
      Win32Check(WaitResult <> WAIT_FAILED);
    until WaitResult = WAIT_OBJECT_0;
  end else WaitForSingleObject(H, INFINITE);
  CheckThreadError(GetExitCodeThread(H, Result));
end;

procedure TSendFaxesThread.CheckThreadError(ErrCode: Integer);
begin
  Inherited;
end;

procedure TSendFaxesThread.CheckThreadError(Success: Boolean);
begin
  Inherited;
end;

end.
