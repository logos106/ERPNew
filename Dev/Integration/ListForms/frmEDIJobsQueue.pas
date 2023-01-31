unit frmEDIJobsQueue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, JSONObject,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg,
  CommonformLib, sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket;

type
  TfmEDIJobsQueueList = class(TBaseListingGUI)
    memTableConnections: TkbmMemTable;
    memTableConnectionsAccountingSoftware: TStringField;
    memTableConnectionsConnectingSoftware: TStringField;
    memTableConnectionsId: TIntegerField;
    memTableConnectionsjob_type: TStringField;
    memTableConnectionsstatus: TStringField;
    memTableConnectionsran_at: TDateTimeField;
    memTableConnectionscreated: TDateTimeField;
    memTableConnectionsid_connection: TIntegerField;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SetJobFilter(Sender: TObject);
  protected
    procedure RefreshQuery; override;
  public
    ConnectionId       : integer;
    AccountingSoftware : string;
    ConnectingSoftware : string;
    wsClient           : TsgcWebSocketClient;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, frmEDIJobLogs, coreEDIUtils;


procedure TfmEDIJobsQueueList.FormCreate(Sender: TObject);
begin
  //IsGridCustomisable := False;
  inherited;

  chkAdvancedPrinting.Visible := False;
  cmdExport.Visible           := True;
  cmdPrint.Visible            := False;
  cmdNew.Visible              := False;
  lblCustomReport.Visible     := False;
  cboCustomReports.Visible    := False;
end;

procedure TfmEDIJobsQueueList.FormShow(Sender: TObject);
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  JSubObject        : TJSONObject;
  JArray            : TJSONArray;
  idx               : Integer;
begin
  if wsClient = Nil then exit;
  if not wsClient.Active then exit;
  sJSON   := BuildJSON('GetJobs', Self.ConnectionId);
  sResult := wsClient.WriteAndWaitData(sJSON);
  memTableConnections.Close;
  memTableConnections.Open;
  JObject     := JO(sResult);
  JSubObject  := JO(JObject.S['Content']);
  JArray      := JSubObject.A['Jobs'];

  for idx := 0 to JArray.Count -1 do begin
    With memTableConnections do begin
      Append;
      FieldByName('AccountingSoftware').AsString := AccountingSoftware;
      FieldByName('ConnectingSoftware').AsString := ConnectingSoftware;
      FieldByName('Status').AsString             := TJSONObject(JArray[idx]).S['Status'];
      FieldByName('job_type').AsString           := TJSONObject(JArray[idx]).S['JobType'];
      FieldByName('Id_connection').AsInteger     := TJSONObject(JArray[idx]).I['ConnectionId'];
      FieldByName('Id').AsInteger                := TJSONObject(JArray[idx]).I['JobId'];
      FieldByName('ran_at').AsDateTime           := TJSONObject(JArray[idx]).DT['RanAt'];
      FieldByName('created').AsDateTime          := TJSONObject(JArray[idx]).DT['created'];
      Post;
    end;
  end;
  inherited;
  setlength(buttons, 3);
  buttons[0]                 := btnCustomize.Name;
  buttons[1]                 := cmdExport.Name;
  buttons[2]                 := cmdClose.Name;

  CentraliseButtons(FooterPanel,0,0,3);
end;

procedure TfmEDIJobsQueueList.grdMainDblClick(Sender: TObject);
begin
  OpenERPListFormModal('TfmEDIJobLogsList' , Nil, SetJobFilter);
end;

procedure TfmEDIJobsQueueList.SetJobFilter(Sender: TObject);
begin
  if not(Sender is TfmEDIJobLogsList) then exit;
  TfmEDIJobLogsList(Sender).JobId               := memTableConnections.FieldByName('id').AsInteger;
  TfmEDIJobLogsList(Sender).WsClient            := WsClient;
end;

procedure TfmEDIJobsQueueList.RefreshQuery;
begin
  //inherited;
  if not memTableConnections.Active then memTableConnections.Active := True;
  memTableConnections.First;
  lblTotal.Caption         := IntToStr(memTableConnections.RecordCount);
end;

initialization
  RegisterClass(TfmEDIJobsQueueList);

end.
