unit frmEDIJobLogDetails;

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
  TfmEDIJobLogDetailsList = class(TBaseListingGUI)
    memTableConnections: TkbmMemTable;
    memTableConnectionsLogText: TStringField;
    memTableConnectionsLogDate: TDateTimeField;
    memTableConnectionsLogId: TIntegerField;
    memTableConnectionsid: TIntegerField;
    memTableConnectionsKeyId: TIntegerField;
    memTableConnectionsKeyTable: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
  public
    SummaryId : integer;
    wsClient  : TsgcWebSocketClient;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CoreEDIUtils;

procedure TfmEDIJobLogDetailsList.FormCreate(Sender: TObject);
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

procedure TfmEDIJobLogDetailsList.FormShow(Sender: TObject);
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
  sJSON   := BuildJSON('GetJobDetails',0, 0, Self.SummaryId);
  sResult := wsClient.WriteAndWaitData(sJSON);
  memTableConnections.Close;
  memTableConnections.Open;
  JObject     := JO(sResult);
  JSubObject  := JO(JObject.S['Content']);
  JArray      := JSubObject.A['JobDetails'];

  for idx := 0 to JArray.Count -1 do begin
    With memTableConnections do begin
      Append;
      FieldByName('LogText').AsString       := TJSONObject(JArray[idx]).S['LogText'];
      FieldByName('LogSummaryId').AsInteger := TJSONObject(JArray[idx]).I['LogSummaryId'];
      FieldByName('KeyId').AsInteger        := TJSONObject(JArray[idx]).I['KeyId'];
      FieldByName('Id').AsInteger           := TJSONObject(JArray[idx]).I['Id'];
      FieldByName('KeyObject').AsString     := TJSONObject(JArray[idx]).S['KeyObject'];
      FieldByName('LogDate').AsDateTime     := TJSONObject(JArray[idx]).DT['LogDate'];
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

procedure TfmEDIJobLogDetailsList.RefreshQuery;
begin
//  inherited;
  if not memTableConnections.Active then memTableConnections.Active := True;
  memTableConnections.First;
  lblTotal.Caption         := IntToStr(memTableConnections.RecordCount);
end;

initialization
  RegisterClass(TfmEDIJobLogDetailsList);

end.
