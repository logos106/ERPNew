unit ProductsForMagento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,JSONObject,MagentoListBase,
  sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket ;

type
  TProductsForMagentoGUI = class(TMagentoListBaseGUI)
    qryMainSynchState: TWideStringField;
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainBARCODE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSNtracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    qryMainAvailableQty: TFloatField;
    qryMainSynchDesc: TWideStringField;
    btnUpLoad: TDNMSpeedButton;
    wsJobClient: TsgcWebSocketClient;
    wsClient: TsgcWebSocketClient;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure btnUpLoadClick(Sender: TObject);
    procedure btnSynchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure wsJobClientException(Connection: TsgcWSConnection; E: Exception);
    procedure wsJobClientMessage(Connection: TsgcWSConnection;
      const Text: string);
    procedure actRefreshQryExecute(Sender: TObject);
  private
    FErrorMessage : string;
    FConnected    : Boolean;
  Protected
    procedure SynchTransactions;Override;
    Procedure SetGridColumns;Override;
    Function Autocheck :boolean; Override;
    Function CheckOrdersInterval:Integer;

    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    Procedure WriteGuiPrefExtra; override;

  public
  	procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, ErpSynchMagento, AppEnvironment, utCoreEDIConst,
  ProductQtyLib, PQALib, BusobjExternalXRef, MagentoLib, LogLib, tcConst, coreEDIUtils;

{$R *.dfm}
procedure TProductsForMagentoGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainPartsId.fieldname);
end;

procedure TProductsForMagentoGUI.SynchTransactions;
begin
//  inherited;
//  LogInList('Synch Products From Magento...' );
//  TErpSynchMagento(SynchObj).SynchProducts;
end;

procedure TProductsForMagentoGUI.btnSynchClick(Sender: TObject);
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
    AJSON.S['JOBSEGMENT'] := 'MAGENTO_SYNCH_PRODUCTS';
    AFields.Add(AJSON);
    sJSON := BuildJSON('JOB', 0, 0, 0, AFields, 'TrueERP', 'Magento');
  finally
    AFields.Free;
  end;
  wsJobClient.WriteData(sJSON);
  Application.ProcessMessages;
end;

procedure TProductsForMagentoGUI.btnUpLoadClick(Sender: TObject);
var
  i : Integer;
  oStr: TStringList;
  sJSON : string;
  AFields: TJSONArray;
  AJSON: TJSONObject;
  AJSONIds: TJSONObject;
begin
  //inherited;
  LogInList('Monitoring job status');
  LogInList('=====================');
  Application.ProcessMessages;
  if not wsJobClient.Active then begin;
    wsJobClient.Host   := AppEnv.CompanyPrefs.CoreEDIServiceHost;
    wsJobClient.Port   := AppEnv.CompanyPrefs.CoreEDIServicePort;
    wsJobClient.Active := True;
    sleep(1000);
  end;

  oStr := TStringList.Create;
  AFields := TJsonArray.Create;
  try
    if grdMain.SelectedList.Count = 0 then begin
      MessageDlgXP_vista('Please Choose The Products to Upload', mtInformation, [mbOK], 0);
      Exit;
    end;
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      oStr.Add(qryMain.FieldByName('PartsId').AsString);
    end;
    AJSON := JO;
    AJSON.S['JOBSEGMENT'] := 'MAGENTO_SYNCH_PRODUCTS_BULK';
    AFields.Add(AJSON);
    AJSONIds := JO;
    AJSONIds.S['IDS'] := oStr.CommaText;
    AFields.Add(AJSONIds);
    sJSON := BuildJSON('JOB', 0, 0, 0, AFields, 'TrueERP', 'Magento');
    wsJobClient.WriteData(sJSON);
    Application.ProcessMessages;
  finally
    oStr.Free;
    AFields.Free;
  end;
end;
procedure TProductsForMagentoGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ProductsForMagentoSQL('', Servicename_Magento, true, Qrymain.sql);
  clog(qrymain.sql.text);
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

procedure TProductsForMagentoGUI.FormShow(Sender: TObject);
begin
  inherited;
  ProductsForMagentoSQL('', ServiceName_Magento, true, Qrymain.sql);
  RefreshQuery;
	//HasEDIAutocheckProgress := True;
  HaveDateRangeSelection := False;
  EnableMultiSelect('Select Products to Upload to Magento. (Changes to an Uploaded Product will be Ignored)');
  Qrymain.First;
  if Appenv.CompanyPrefs.AutoLocateproductinList then
    if GuiPrefs.Node.Exists('Options.PartsID') then
      Qrymain.locate('PartsId',  GuiPrefs.Node['Options.PartsID'].asInteger , []);
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
//  inherited;
  HasEDIAutocheckProgress := False;
end;

procedure TProductsForMagentoGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString( qryMainSynchState.fieldname, ['T','F','']);
  inherited;

end;

procedure TProductsForMagentoGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
    With TErpSynchMagento(SynchObj) do begin
       UploadProduct(QrymainpartsID.asInteger);
    end;
end;

procedure TProductsForMagentoGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.PartsID'].asInteger         := QrymainpartsID.asInteger;
end;
procedure TProductsForMagentoGUI.wsJobClientException(
  Connection: TsgcWSConnection; E: Exception);
begin
  inherited;
  FErrorMessage := E.Message;
  FConnected    := False;
end;

procedure TProductsForMagentoGUI.wsJobClientMessage(
  Connection: TsgcWSConnection; const Text: string);
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

procedure TProductsForMagentoGUI.RefreshQuery;
begin
//  inherited;
  qryMain.close;
  qrymain.Open;
end;

procedure TProductsForMagentoGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  if not FConnected then exit;
end;

Function TProductsForMagentoGUI.Autocheck :boolean;
begin
  result := False;
end;

Function TProductsForMagentoGUI.CheckOrdersInterval:Integer;
begin
  Result := MAGENTO_CHECKPRODUCTSINTERVAL;
end;

initialization
  RegisterClass(TProductsForMagentoGUI);

end.
