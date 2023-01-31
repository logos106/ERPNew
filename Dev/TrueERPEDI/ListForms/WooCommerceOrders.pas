unit WooCommerceOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MagentoListBase, DAScript, MyScript, ERPdbComponents, DB, JSONObject,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, sgcBase_Classes, sgcTCP_Classes,
  sgcWebSocket_Classes, sgcWebSocket_Classes_Indy, sgcWebSocket_Client,
  sgcWebSocket  ;

type
  TWooCommerceOrdersGUI = class(TMagentoListBaseGUI)
    qryMainSynchState: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainprintjobname: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCreditLimit: TFloatField;
    qryMainDefaultClass: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainclientcode: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainGracePeriod: TWordField;
    qryMainStopCredit: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainAccountNo: TWideStringField;
    wsJobClient: TsgcWebSocketClient;
    wsClient: TsgcWebSocketClient;
    procedure FormShow(Sender: TObject);
    procedure wsJobClientException(Connection: TsgcWSConnection; E: Exception);
    procedure wsJobClientMessage(Connection: TsgcWSConnection;
      const Text: string);
    procedure FormCreate(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure btnSynchClick(Sender: TObject);
  private
    FErrorMessage : string;
    FConnected    : Boolean;
  Protected
    procedure SynchTransactions;Override;
    Procedure SetGridColumns;Override;
    Function Autocheck :boolean; Override;
    Function CheckOrdersInterval:Integer;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses AppEnvironment, CommonLib, BusobjExternalXRef, ErpSynchMagento, utCoreEDIConst, coreEDIUtils, tcConst;

{$R *.dfm}
{ TMagentoCustomersGUI }

procedure TWooCommerceOrdersGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  if not FConnected then exit;
end;

procedure TWooCommerceOrdersGUI.btnSynchClick(Sender: TObject);
var
  sJSON : string;
  AFields: TJSONArray;
  AJSON: TJSONObject;
begin
  inherited;

  LogInList('Monitoring job status');
  LogInList('=====================');
  Application.ProcessMessages;
  if not wsJobClient.Active then begin;
    wsJobClient.Host   := AppEnv.CompanyPrefs.CoreEDIServiceHost;
    wsJobClient.Port   := AppEnv.CompanyPrefs.CoreEDIServicePort;
    wsJobClient.Active := True;
    sleep(1000);
  end;
  AFields := TJsonArray.Create;
  try
    AJSON := JO;
    AJSON.S['JOBSEGMENT'] := 'MAGENTO_SYNCH_CUSTOMERS';
    AFields.Add(AJSON);
    sJSON := BuildJSON('JOB', 0, 0, 0, AFields, 'TrueERP', 'Magento');;
  finally
    AFields.Free;
  end;
  wsJobClient.WriteData(sJSON);
  Application.ProcessMessages;
end;

procedure TWooCommerceOrdersGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FErrorMessage       := '';
  wsClient.Host       := AppEnv.CompanyPrefs.CoreEDIServiceHost;
  wsClient.Port       := AppEnv.CompanyPrefs.CoreEDIServicePort;
  if ((AppEnv.CompanyPrefs.CoreEDIServiceUserName <> '') and (AppEnv.CompanyPrefs.CoreEDIServicePassword <> '')) then begin
    wsClient.Active     := True;
    sleep(1000);
    FConnected          := True;
  end else begin
    FConnected          := False;
  end;

  chkAdvancedPrinting.Visible := False;
  cmdExport.Visible           := True;
  cmdExport.Enabled           := FConnected;
  cmdPrint.Visible            := False;
  cmdNew.Visible              := False;
  //lblNextJobHint.Visible      := FConnected;
  //pbRequery.Visible           := FConnected;
  lblCustomReport.Visible     := False;
  cboCustomReports.Visible    := False;
end;

procedure TWooCommerceOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not FConnected then exit;
  if FerrorMessage <> '' then begin
    MessageDlgXP_vista('Could not connect to CoreEDI. ' + #13#10
    + 'Please confirm user name, password, host and port are correct. ' + #13#10 +
    'If this problem persists please contact CoreEDI directly with this message : ' + #13#10
    + FerrorMessage, mtError, [mbOK], 0);
    exit;
  end;
  HaveDateRangeSelection := False;
  setlength(buttons, 3);
  buttons[0]                 := btnCustomize.Name;
  buttons[1]                 := cmdExport.Name;
  buttons[2]                 := cmdClose.Name;

  CentraliseButtons(FooterPanel,0,0,3);
  //inherited;
  HasEDIAutocheckProgress := False;
end;

procedure TWooCommerceOrdersGUI.RefreshQuery;
begin
  inherited;
  Qrymain.parambyname('Externaltype').asString:= Servicename_Magento; //SynchObj.CoreService.ServiceName;
  Qrymain.parambyname('ObjectType').asString:= ExRef_Objtype_Customer;
end;

procedure TWooCommerceOrdersGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientID.fieldname);
  RemoveFieldfromGrid(QrymainGlobalref.fieldname);
end;

procedure TWooCommerceOrdersGUI.SynchTransactions;
begin
//  inherited;
//  LogInList('Synch Customers From Magento...' );
//  TErpSynchMagento(SynchObj).SynchCustomers;
end;

procedure TWooCommerceOrdersGUI.wsJobClientException(
  Connection: TsgcWSConnection; E: Exception);
begin
  inherited;
  FErrorMessage := E.Message;
  FConnected    := False;
end;

procedure TWooCommerceOrdersGUI.wsJobClientMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  JSONResp: TJSONObject;
begin
  inherited;
  JSONResp := JO(Text);
  if JSONResp.B['Error'] then LogInList('Error : ' + JSONResp.S['ErrorMessage']) else
  LogInList(JSONResp.S['ErrorMessage']);
  if JSONResp.S['ErrorMessage'] = 'Completed Request' then begin
    LogInList('==================================');
    actRefreshQryExecute(Nil);
  end;
end;

Function TWooCommerceOrdersGUI.Autocheck :boolean;
begin
  result := False;
end;

Function TWooCommerceOrdersGUI.CheckOrdersInterval:Integer;
begin
  Result := MAGENTO_CHECKCUSTOMERSINTERVAL;
end;

initialization
  RegisterClass(TWooCommerceOrdersGUI);

end.
