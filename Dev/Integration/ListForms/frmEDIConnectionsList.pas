unit frmEDIConnectionsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, JSONObject,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg,
  CommonformLib, sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket, ComCtrls,
  AdvProgr;

type
  TfmEDIConnectionsList = class(TBaseListingGUI)
    qryCreateTempTable: TERPQuery;
    qrySynch: TERPQuery;
    qryLogCheck: TERPQuery;
    wsClient: TsgcWebSocketClient;
    JobTimer: TTimer;
    pnlEDIAutocheckProgress: TPanel;
    lblNextJobHint: TLabel;
    pbRequery: TAdvProgress;
    ProgressBarTimer: TTimer;
    lblListHint: TLabel;
    Label1: TLabel;
    wsJobClient: TsgcWebSocketClient;
    memTableConnections: TkbmMemTable;
    memTableConnectionsAccountingSoftware: TStringField;
    memTableConnectionsConnectingSoftware: TStringField;
    memTableConnectionsId: TIntegerField;
    memTableConnectionsLastSchRunDate: TDateTimeField;
    memTableConnectionsNextSchRunDate: TDateTimeField;
    memTableConnectionsLastPaychexCheckDate: TDateTimeField;
    memTableConnectionsSelected: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure JobTimerTimer(Sender: TObject);
    procedure wsClientException(Connection: TsgcWSConnection; E: Exception);
    procedure FormShow(Sender: TObject);
    procedure ProgressBarTimerTimer(Sender: TObject);
    procedure wsJobClientMessage(Connection: TsgcWSConnection;
      const Text: string);
    procedure grdMainDblClick(Sender: TObject);
  private
    FErrorMessage : string;
    FConnected    : Boolean;
    procedure GetConnectionList;
    procedure ShowTimeDiff(const StartDate: TDateTime; var Days, Hours, Mins, Secs: integer);
    procedure SetQueueFilter(Sender: TObject);
  protected
    procedure RefreshQuery; override;
  public

  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonLib, LogDialog, DateUtils, frmEDIJobsQueue, coreEDIUtils ;

procedure TfmEDIConnectionsList.SetQueueFilter(Sender: TObject);
begin
  if not(Sender is TfmEDIJobsQueueList) then exit;
  TfmEDIJobsQueueList(Sender).ConnectionId         := MemTableConnections.FieldByName('id').AsInteger;
  TfmEDIJobsQueueList(Sender).AccountingSoftware   := MemTableConnections.FieldByName('AccountingSoftware').AsString;
  TfmEDIJobsQueueList(Sender).ConnectingSoftware   := MemTableConnections.FieldByName('ConnectingSoftware').AsString;
  TfmEDIJobsQueueList(Sender).WsClient             := WsClient;
end;

procedure TfmEDIConnectionsList.cmdNewClick(Sender: TObject);
var
  sJSON : string;
begin
  LogToDialog('Monitoring job status');
  LogToDialog('=====================');
  Application.ProcessMessages;
  wsJobClient.Active  := False;
  wsJobClient.Host   := AppEnv.CompanyPrefs.CoreEDIServiceHost;
  wsJobClient.Port   := AppEnv.CompanyPrefs.CoreEDIServicePort;
  wsJobClient.Active := True;
  sleep(1000);
  With memTableConnections do begin
    try
      First;
      while not EOF do begin
        if FieldByName('Selected').AsString = 'T' then begin
          sJSON := BuildJSON('JOB', FieldByName('id').AsInteger);
          wsJobClient.WriteData(sJSON);
        end;
        Edit;
        FieldByName('Selected').AsString := 'F';
        Post;
        Next;
      end;
    finally
      Refresh;
    end;
  end;
  Application.ProcessMessages;
end;

procedure TfmEDIConnectionsList.GetConnectionList;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  JSubObject        : TJSONObject;
  JArray            : TJSONArray;
  idx               : Integer;
begin
  if not wsClient.Active then exit;
  sJSON   := BuildJSON('GetConnections');
  sResult := wsClient.WriteAndWaitData(sJSON);
  memTableConnections.Close;
  memTableConnections.Open;
  JObject := JO(sResult);
  JSubObject  := JO(JObject.S['Content']);
  JArray      := JSubObject.A['Connections'];

  for idx := 0 to JArray.Count -1 do begin
    With memTableConnections do begin
      Append;
      FieldByName('AccountingSoftware').AsString := TJSONObject(JArray[idx]).S['AccountingSoftware'];
      FieldByName('ConnectingSoftware').AsString := TJSONObject(JArray[idx]).S['ConnectingSoftware'];
      FieldByName('Selected').AsString           := 'F';
      FieldByName('Id').AsInteger                := TJSONObject(JArray[idx]).I['ConnectionId'];
      FieldByName('LastSchRunDate').AsDateTime   := TJSONObject(JArray[idx]).DT['LastRunAt'];
      FieldByName('NextSchRunDate').AsDateTime   := TJSONObject(JArray[idx]).DT['NextRunAt'];
      Post;
    end;
  end;
  if JArray.Count <> 0 then begin
    Panel2.Height       := 52;
  end else begin
    lblListHint.Caption := 'There are no connections defined. Please contact CoreEDI.';
    Panel2.Height       := 20;
  end;
end;

procedure TfmEDIConnectionsList.grdMainDblClick(Sender: TObject);
begin
  OpenERPListFormModal('TfmEDIJobsQueueList' , Nil, SetQueueFilter);
end;

procedure TfmEDIConnectionsList.FormCreate(Sender: TObject);
begin
  inherited;
  FErrorMessage       := '';
  lblListHint.visible := True;
  wsClient.Host       := AppEnv.CompanyPrefs.CoreEDIServiceHost;
  wsClient.Port       := AppEnv.CompanyPrefs.CoreEDIServicePort;
  if ((AppEnv.CompanyPrefs.CoreEDIServiceUserName <> '') and (AppEnv.CompanyPrefs.CoreEDIServicePassword <> '')) then begin
    wsClient.Active     := True;
    sleep(1000);
    FConnected          := True;
    Panel2.Height       := 52;
  end else begin
    lblListHint.Caption := 'Connection to CoreEDI is not possible since your username/password is empty. Please contact CoreEDI.';
    FConnected          := False;
    Panel2.Height       := 20;
  end;

  chkAdvancedPrinting.Visible := False;
  cmdExport.Visible           := True;
  cmdExport.Enabled           := FConnected;
  cmdPrint.Visible            := False;
  cmdNew.Caption              := 'Synch';
  cmdNew.Enabled              := FConnected;
  lblNextJobHint.Visible      := FConnected;
  pbRequery.Visible           := FConnected;
  lblCustomReport.Visible     := False;
  cboCustomReports.Visible    := False;
end;

procedure TfmEDIConnectionsList.FormShow(Sender: TObject);
begin
  inherited;
  setlength(buttons, 4);
  buttons[0]                 := btnCustomize.Name;
  buttons[1]                 := cmdExport.Name;
  buttons[2]                 := cmdNew.Name;
  buttons[3]                 := cmdClose.Name;

  CentraliseButtons(FooterPanel,0,0,4);
  if not FConnected then exit;
  if FerrorMessage <> '' then begin
    MessageDlgXP_vista('Could not connect to CoreEDI. ' + #13#10
    + 'Please confirm user name, password, host and port are correct. ' + #13#10 +
    'If this problem persists please contact CoreEDI directly with this message : ' + #13#10
    + FerrorMessage, mtError, [mbOK], 0);
    exit;
  end;
  GetConnectionList;

  RefreshQuery;
end;

procedure TfmEDIConnectionsList.JobTimerTimer(Sender: TObject);
begin
  inherited;
  JobTimer.Enabled         := False;
  pbRequery.Position       := 0;
  ProgressBarTimer.Enabled := False;
  GetConnectionList;
  RefreshQuery;
  JobTimer.Enabled         := True;
  ProgressBarTimer.Enabled := True;
  Application.ProcessMessages;
end;

procedure TfmEDIConnectionsList.ProgressBarTimerTimer(Sender: TObject);
begin
  inherited;
  pbRequery.Position := pbReQuery.Position + 8;
  lblListHint.caption := 'This List will automatically check for new scheduled jobs every minute. (' + IntToStr(60 - Trunc(pbRequery.Position * 5 / 8)) + ' secs.)';
  Application.ProcessMessages;
end;

procedure TfmEDIConnectionsList.wsClientException(Connection: TsgcWSConnection;
  E: Exception);
begin
  inherited;
  FErrorMessage := E.Message;
  FConnected    := False;
end;

procedure TfmEDIConnectionsList.wsJobClientMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  JSONResp: TJSONObject;
begin
  inherited;
  JSONResp := JO(Text);
  if JSONResp.B['Error'] then LogToDialog('Error : ' + JSONResp.S['ErrorMessage']) else
  LogToDialog(JSONResp.S['ErrorMessage']);
  if JSONResp.S['ErrorMessage'] = 'Finished' then begin
    LogToDialog('==================================');
  end;
end;

procedure TfmEDIConnectionsList.RefreshQuery;
var Days, Hours, Mins, Secs: integer;
begin
//  inherited;
  lblTotal.Caption         := '0';
  if not FConnected then exit;
  if not memTableConnections.Active then memTableConnections.Active := True;
  memTableConnections.First;
  ShowTimeDiff(memTableConnections.FieldByName('nextschrundate').AsDateTime, Days, Hours, Mins, Secs);
  lblNextJobHint.Caption := 'Next scheduled job "' + memTableConnections.FieldByName('AccountingSoftware').AsString + ' with '+
  memTableConnections.FieldByName('ConnectingSoftware').AsString + '" will be synched in ' +
  Format('%d days, %d hours, %d mins, %d secs', [Days, Hours, Mins, Secs]);

  Application.ProcessMessages;
  JobTimer.Enabled         := True;
  ProgressBarTimer.Enabled := True;
  lblTotal.Caption         := IntToStr(memTableConnections.RecordCount);
end;

procedure TfmEDIConnectionsList.ShowTimeDiff(const StartDate: TDateTime; var Days, Hours, Mins, Secs: integer);
begin
  Days  := DaysBetween(StartDate, Now());
  Hours := HoursBetween(Now(), StartDate) mod 24;
  Mins  := MinutesBetween(StartDate, Now()) mod 60;
  Secs  := SecondsBetween(StartDate, Now()) mod 60;
end;

initialization
  RegisterClass(TfmEDIConnectionsList);

end.
