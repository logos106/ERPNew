unit frmCoreEDITest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, CoreEDIObj,
  LogMessageTypes, utQuickbooksCoreService, JsonObject, ErpSynchObj;

type
  TfmCoreEDITest = class(TBaseForm)
    btnSendInvToQB: TButton;
    memLog: TMemo;
    edtInvNo: TEdit;
    btnGetQBInv: TButton;
    edtQBInv: TEdit;
    btnConnect: TButton;
    Button1: TButton;
    btnGetCustId: TButton;
    edtCustName: TEdit;
    btnSynch: TButton;
    btnStopSynch: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSendInvToQBClick(Sender: TObject);
    procedure btnGetQBInvClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnGetCustIdClick(Sender: TObject);
    procedure btnSynchClick(Sender: TObject);
    procedure btnStopSynchClick(Sender: TObject);
  private
    //CoreEdiServer: string;
    Synch: TErpSynch;
    CoreEDI: TCoreEDI;
    QB: TQuickbooksCoreService;
    procedure DoOnLogEvent(const msg: string; const LogMessageType: TLogMessageType);
    procedure Log(msg: string);
    procedure DoOnQuickbooksCoreServiceEvent(Sender: TObject; const EventName: string; Data: TJsonObject);
    procedure DoErpSynchProgEvent(Sender: TErpSynch; var Continue: boolean; msg: string);
    procedure DoOnError(Sender: TObject);
  public
    { Public declarations }
  end;

var
  fmCoreEDITest: TfmCoreEDITest;

implementation

uses
  BusObjSales, JsonToObject, CommonDbLib, ShellAPI,
  ObjectSerialiser, JsonObjectUtils, AppEnvironment;

{$R *.dfm}


procedure TfmCoreEDITest.btnConnectClick(Sender: TObject);
begin
  inherited;
  CoreEDI.Connect;
end;

procedure TfmCoreEDITest.btnGetCustIdClick(Sender: TObject);
var
  ID, s: string;
begin
  inherited;
   QB.IdForName('Customer',edtCustName.Text);
   Id := QB.ResultData.S['ID'];
   Log('Id: ' + ID);
   QB.GetObject('Customer', Id);
   s := JsonToStrFormat(QB.ResultData.O['Data']);
   Log(s);
end;

procedure TfmCoreEDITest.btnGetQBInvClick(Sender: TObject);
var
  Json: TJsonObject;
  msg: string;
begin
  inherited;
  Json := JO;
  try
//    if CoreEDI.Get('quickbooks','invoice/' + edtQBInv.Text, Json, msg) then begin
//
//
//    end
//    else begin
//
//
//    end;
  finally
    Json.Free;
  end;
end;

procedure TfmCoreEDITest.btnSendInvToQBClick(Sender: TObject);
var
  Invoice: TInvoice;
  Json: TJsonObject;
  JSONSerialiser: TJSONSerialiser;
begin
  inherited;
  Invoice := TInvoice.CreateWithNewConn(nil);
  Json := nil;
  try
    Invoice.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    Invoice.Load(StrToInt(edtInvNo.Text), true);
    JSONSerialiser := TJSONSerialiser.Create;
    try
      //ObjToJson(Invoice, Json);
      Json := JSONSerialiser.SerialiseObject(Invoice);
    except
      on e: exception do begin
        Log(e.Message);
      end;

    end;
    //memLog.Lines.Add(JsonToStrFormat(Json));
    //CoreEDI.Send(JsonToStrFormat(Json));

  finally
    Invoice.Free;
    Json.Free;
  end;
end;

procedure TfmCoreEDITest.btnStopSynchClick(Sender: TObject);
begin
  inherited;
  Synch.Active := false;
end;

procedure TfmCoreEDITest.btnSynchClick(Sender: TObject);
begin
  Synch.SynchData('Invoice');
end;

procedure TfmCoreEDITest.Button1Click(Sender: TObject);
//var
//  UserMsg, ResultType: string;

begin
  inherited;
  if not QB.Initialize then begin

    memLog.Lines.Add(QB.ResultData.S['UserMessage']);

    if SameText(QB.ResultData.S['ReturnCode'], 'UserAuthRequired') then begin
      ShowMessage(QB.ResultData.S['UserMessage']);
      ShellExecute(0, 'OPEN', PChar(QB.ResultData.S['AuthURL']), '', '', SW_SHOWNORMAL);
    end;

  end
  else
   memLog.Lines.Add('Quickbooks initialized')
end;

procedure TfmCoreEDITest.DoErpSynchProgEvent(Sender: TErpSynch;
  var Continue: boolean; msg: string);
var
  s: string;
begin
  s := Sender.CoreService.ServiceName + ' ' + Sender.SynchType + ' ' +
    IntToStr(Sender.CurrentSynchItemNo) + ' of ' + IntToStr(Sender.TotalItemsToSynch) + ' (Id: '+IntToStr(Sender.CurrentSynchId)+')';
  if msg <> '' then
    s := s + ' ' + msg;
  Log(s);
end;

procedure TfmCoreEDITest.DoOnError(Sender: TObject);
var
  json: TJsonObject;
begin
  if Synch.CoreService.ResultData.S['CurrentTask'] <> '' then
    memLog.Lines.Add('Task: ' + Synch.CoreService.ResultData.S['CurrentTask']);
  if Synch.APIMessage <> '' then begin
    json := JO;
    try
      json.AsString := Synch.APIMessage;
      memLog.Lines.Add(JsonToStrFormat(json));

    finally
      json.Free;
    end;

  end
  else
    memLog.Lines.Add(Synch.UserMessage);

end;

procedure TfmCoreEDITest.DoOnLogEvent(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  memLog.Lines.Add(LogMessageTypeToStr(LogMessageType) + ' ' + msg);
  Application.ProcessMessages;
end;

procedure TfmCoreEDITest.DoOnQuickbooksCoreServiceEvent(Sender: TObject;
  const EventName: string; Data: TJsonObject);
//var
//  url: string;
begin
//  if EventName = 'AuthUser' then begin
//    ShowMessage('You must log into your Intuit account, a brwser window will now be opened to take you to the Intuit Logon Page');
//    url := Data.S['AuthURL'];
//    ShellExecute(0, 'OPEN', PChar(url), '', '', SW_SHOWNORMAL);

//  end;

end;

procedure TfmCoreEDITest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCoreEDITest.FormCreate(Sender: TObject);
begin
  inherited;
 // CoreEdiServer := 'https://erpclientserver.dyndns.org:8445';
  CoreEDI := TCoreEDI.Create;
  CoreEDI.OnLog := DoOnLogEvent;
  //CoreEDI.CoreEDIServerURL := 'https://erpclientserver.dyndns.org:8445';
  CoreEDI.CoreEDIUser := 'ian@erpoz.com';
  CoreEDI.CoreEDIPassword := '12345';
  { hard code .. else it will do a lookup }
//  CoreEDI.CoreEDIServer := 'erpclientserver.dyndns.org:8445';

  QB := TQuickbooksCoreService.Create;
  CoreEDI.AddService(QB);
  QB.SandboxMode := true;
  QB.CompanyRegion := AppEnv.RegionalOptions.Region;
  //QB.CompanyID := '4620816365012546930'; { USA Company }
  QB.CompanyID := '193514849245064'; { AUS Company }
  QB.ClientID := 'ABfnfxoO22t4bPpFNP0B1lb6OrFq8Gx1xXLNjz3JUR1U1Nk2zu';
  QB.ClientSecret := 'bEqKoKPjnubU9KI3vtnNuhVvI9UaPqYCNOaY77ye';
  QB.OnEvent := DoOnQuickbooksCoreServiceEvent;

  Synch := TErpSynch.Create;
  Synch.OnSynchProgress := DoErpSynchProgEvent;
  Synch.OnSynchError := DoOnError;
  Synch.CoreService := QB;

end;

procedure TfmCoreEDITest.FormDestroy(Sender: TObject);
begin
  inherited;
  if Synch.Active then begin
    Synch.Active := false;
    Sleep(2000);
  end;
  Synch.Free;
  CoreEDI.Free;
end;

procedure TfmCoreEDITest.Log(msg: string);
begin
  memLog.Lines.Add(msg);
end;

initialization

  RegisterClass(TfmCoreEDITest);

end.
