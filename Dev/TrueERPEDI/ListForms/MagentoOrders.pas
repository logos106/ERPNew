unit MagentoOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MagentoListBase, DAScript, MyScript, ERPdbComponents, DB, JSONObject,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, BaseInputForm, BusObjBase,
  sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket;

type
  TMagentoOrdersGUI = class(TMagentoListBaseGUI)
    qryMainID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainSynchState: TWideStringField;
    qryMainMagentoID: TWideStringField;
    qryMainEstimatedprice: TFloatField;
    wsJobClient: TsgcWebSocketClient;
    wsClient: TsgcWebSocketClient;
    procedure FormShow(Sender: TObject);
    procedure btnSynchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure wsJobClientException(Connection: TsgcWSConnection; E: Exception);
    procedure wsJobClientMessage(Connection: TsgcWSConnection;
      const Text: string);
  private
    FErrorMessage : string;
    FConnected    : Boolean;
  Protected
    procedure SynchTransactions;Override;
    //Procedure SetGridColumns;Override;
    Function Autocheck :boolean; Override;
    Function CheckOrdersInterval:Integer;

    procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string); override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses  CommonLib, ProductQtyLib, AppEnvironment, tcConst,  coreEDIUtils,ErpSynchMagento;



{$R *.dfm}


procedure TMagentoOrdersGUI.FormCreate(Sender: TObject);
begin
  Qrymain.sql.text := replacestr(Qrymain.sql.text , ':SaleType' , SaleType());
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

procedure TMagentoOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := False;

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
end;


procedure TMagentoOrdersGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTransType.AsString;
  inherited;
end;

procedure TMagentoOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

Function TMagentoOrdersGUI.Autocheck :boolean;
begin
  result := False; //Appenv.companyprefs.MAgentoConfig.AutosynchList;
end;

Function TMagentoOrdersGUI.CheckOrdersInterval:Integer;
begin
  Result := MAGENTO_CHECKORDERSINTERVAL;
end;
procedure TMagentoOrdersGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
end;
procedure TMagentoOrdersGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin

end;
procedure TMagentoOrdersGUI.btnSynchClick(Sender: TObject);
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
    AJSON.S['JOBSEGMENT'] := 'MAGENTO_SYNCH_ORDERS';
    AFields.Add(AJSON);
    sJSON := BuildJSON('JOB', 0, 0, 0, AFields, 'TrueERP', 'Magento');;
  finally
    AFields.Free;
  end;
  wsJobClient.WriteData(sJSON);
  Application.ProcessMessages;
end;

procedure TMagentoOrdersGUI.SynchTransactions;
var
  fbdouploadProducts:Boolean;
begin
  LogInList('Synch Customers From Magento...' );
  TErpSynchMagento(SynchObj).SynchCustomers;
  fbdouploadProducts:= False;
  if not(Devmode) or (MessageDlgXP_Vista('Upload Products? ', mtConfirmation, [mbYes, mbNo], 0) = mrok) then begin
    fbdouploadProducts := True;
    LogInList('Synch Products From ERP to Magento...' );
    TErpSynchMagento(SynchObj).UploadProducts;
  end;

  LogInList('Synch Sales From Magento...' );
  TErpSynchMagento(SynchObj).InitTosynchOrders;
  TErpSynchMagento(SynchObj).SynchOrders;

  if fbdouploadProducts then begin
    LogInList('Synch Products From ERP to Magento...' );
    TErpSynchMagento(SynchObj).UploadProducts;
  end;

  closedb(Qrymain);
  RefreshQuery;
  if FormStillOpen('TProductsForMagentoGUI') then begin
    closedb(TMagentoListBaseGUI(FindExistingComponent('TProductsForMagentoGUI')).Qrymain);
    TMagentoListBaseGUI(FindExistingComponent('TProductsForMagentoGUI')).RefreshQuery;
  end;
end;

procedure TMagentoOrdersGUI.wsJobClientException(Connection: TsgcWSConnection;
  E: Exception);
begin
  inherited;
  FErrorMessage := E.Message;
  FConnected    := False;
end;

procedure TMagentoOrdersGUI.wsJobClientMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  JSONResp: TJSONObject;
begin
  inherited;
  JSONResp := JO(Text);
  if JSONResp.B['Error'] then LogInList('Error : ' + JSONResp.S['ErrorMessage']) else
  LogInList(JSONResp.S['ErrorMessage']);
  If Pos('Completed Request', JSONResp.S['ErrorMessage']) > 0  then begin
    LogInList('==================================');
    actRefreshQryExecute(Nil);
  end;
end;

initialization
  RegisterClass(TMagentoOrdersGUI);


end.
