unit frmEDIJobLogs;

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
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket;

type
  TfmEDIJobLogsList = class(TBaseListingGUI)
    memTableConnections: TkbmMemTable;
    memTableConnectionsLogText: TStringField;
    memTableConnectionsLogDate: TDateTimeField;
    memTableConnectionsJobId: TIntegerField;
    memTableConnectionsLogId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    procedure SetJobDetailFilter(Sender: TObject);
  protected
    procedure RefreshQuery; override;
  public
    JobId       : integer;
    wsClient    : TsgcWebSocketClient;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CoreEDIUtils, frmEDIJobLogDetails;

procedure TfmEDIJobLogsList.FormCreate(Sender: TObject);
begin
  //AllowCustomiseGrid         := true;

  inherited;
  chkAdvancedPrinting.Visible := False;
  cmdExport.Visible           := True;
  cmdPrint.Visible            := False;
  cmdNew.Visible              := False;
  lblCustomReport.Visible     := False;
  cboCustomReports.Visible    := False;
end;

procedure TfmEDIJobLogsList.FormShow(Sender: TObject);
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
  sJSON   := BuildJSON('GetJobSummary',0, Self.JobId);
  sResult := wsClient.WriteAndWaitData(sJSON);
  memTableConnections.Close;
  memTableConnections.Open;
  JObject     := JO(sResult);
  JSubObject  := JO(JObject.S['Content']);
  JArray      := JSubObject.A['JobSummary'];

  for idx := 0 to JArray.Count -1 do begin
    With memTableConnections do begin
      Append;
      FieldByName('LogText').AsString    := TJSONObject(JArray[idx]).S['LogText'];
      FieldByName('LogId').AsInteger     := TJSONObject(JArray[idx]).I['LogId'];
      FieldByName('JobId').AsInteger     := TJSONObject(JArray[idx]).I['JobId'];
      FieldByName('LogDate').AsDateTime  := TJSONObject(JArray[idx]).DT['LogDate'];
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

procedure TfmEDIJobLogsList.grdMainDblClick(Sender: TObject);
begin
  OpenERPListFormModal('TfmEDIJobLogDetailsList' , Nil, SetJobDetailFilter);
end;

procedure TfmEDIJobLogsList.SetJobDetailFilter(Sender: TObject);
begin
  if not(Sender is TfmEDIJobLogDetailsList) then exit;
  TfmEDIJobLogDetailsList(Sender).SummaryId     := memTableConnections.FieldByName('LogId').AsInteger;
  TfmEDIJobLogDetailsList(Sender).WsClient      := WsClient;
end;

procedure TfmEDIJobLogsList.RefreshQuery;
begin
//  inherited;
  if not memTableConnections.Active then memTableConnections.Active := True;
  memTableConnections.First;
  lblTotal.Caption         := IntToStr(memTableConnections.RecordCount);
end;

initialization
  RegisterClass(TfmEDIJobLogsList);

end.
