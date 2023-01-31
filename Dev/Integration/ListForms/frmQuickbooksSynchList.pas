unit frmQuickbooksSynchList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, ComCtrls, AdvProgr, ErpSynchObj,
  CoreEDIObj, utQuickbooksCoreService, ERPEDIListBase, utBaseCoreService;

type
  TfmQuickbooksSynchList = class(TERPEDIListBaseGUI)
    qryMainID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainNAME: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainSynchState: TWideStringField;
    pnlExtraButtons: TDNMPanel;
    lblExporttoWalmart: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkShowProduct: TwwCheckBox;
    btnSynchTransactions: TDNMSpeedButton;
    btnMakeERPOrders: TDNMSpeedButton;
    btnQuickBooksIdList: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSynchTransactionsClick(Sender: TObject);
    procedure btnQuickBooksIdListClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    Synch: TErpSynch;
    QB: TQuickbooksCoreService;
    function DoGetSynchDataEvent(const SynchType: string; var DataOk: boolean): string;
    procedure StopSynch; Overload;
    function SynchTransactions: boolean;
  protected
     {Binny - moved to Baselist }
    (*procedure DoOnSynchError(Sender: TObject);Override;*)
    (*procedure DoOnSynchProg(Sender: TErpSynch; var Continue: boolean; msg: string);Override;*)
    (*procedure DoOnLog(const msg: string; const aType: string = '');Override;*)
    (*procedure LogError(const UserMessage, APIMessage: string; CurrentTask: string = '');Override;*)

    Function HasEDICredentials :Boolean ; Override;
    Function MakeCoreServiceObj :TBaseCoreService; Override;
    function InitializeCoreEDIObj: Boolean; Override;
    (*function InitializeCoreEDI: boolean;Override;*)


    function Autocheck: boolean; Override;
    function ModuleCaption: string; Override;
    Function CheckOrdersInterval: Integer; Override;
    Procedure DoEDIAutocheck(Sender: TObject); override;
    procedure RefreshQuery; override;
    Procedure InitCodeEDI; Override;
  public
    Procedure OpenPreferance; override;
  end;

implementation

uses
  AppEnvironment, CommonLib, ShellAPI, JsonObject, JsonObjectUtils, Preferences,
  QuickbooksList, frmEDIAutocheckProgress, tcConst, utCoreEDIConst,
  CommonFormLib;

{$R *.dfm}


function TfmQuickbooksSynchList.Autocheck: boolean;
begin
  result := Appenv.companyprefs.IntuitConfig.AutoSynchFromList;
end;

procedure TfmQuickbooksSynchList.btnSynchTransactionsClick(Sender: TObject);
begin
  inherited;
  DoEDICheckEvent;
  {DoEDIAutocheck function will be called from the progress form - fEDIAutocheckProgress - Event}
(*  InitTimers(false);
  if SameText(btnSynchTransactions.Caption, fsSynchCaption) then begin
    if not InitializeCoreEDIObj then exit;
    btnSynchTransactions.Caption := 'Stop Synch';
    SynchTransactions;
    StopSynch;
  end
  else
    StopSynch;*)
end;
procedure TfmQuickbooksSynchList.DoEDIAutocheck(Sender: TObject);
begin
  InitTimers(false);
  if SameText(btnSynchTransactions.Caption, fsSynchCaption) then begin
    if not InitializeCoreEDIObj then exit;
    btnSynchTransactions.Caption := 'Stop Synch';
    SynchTransactions;
    StopSynch;
  end else begin
    StopSynch;
  end;
end;
function TfmQuickbooksSynchList.CheckOrdersInterval: Integer;
begin
  result := inherited;
end;

procedure TfmQuickbooksSynchList.btnQuickBooksIdListClick(Sender: TObject);
var
  form: TQuickBooksListGUI;
begin
  inherited;
  if not AppEnv.CompanyPrefs.IntuitConfig.EnableQuickbooks then begin
    CommonLib.MessageDlgXP_Vista('Quickbooks is not enabled in Preferences.', mtInformation, [mbOk],0);
    exit;
  end;
  form := TQuickBooksListGUI.Create(self);
  form.OnGetSynchData := DoGetSynchDataEvent;
  form.FormStyle := fsMDIChild;
  form.BringToFront;
end;

function TfmQuickbooksSynchList.DoGetSynchDataEvent(
  const SynchType: string; var DataOk: boolean): string;
var
 s: string;
begin
  s := SynchType;
  if SameText(s, 'SubTaxCode') then s := 'TaxRate';

  if not InitializeCoreEDIObj then begin
    DataOk := false;
    exit;
  end;
  LoginList('Getting Quickbooks '+s+' List ...' + #13#10);
  Application.ProcessMessages;
  if QB.GetData('select * from ' + s) then begin
//    LoginList(JsonToStrFormat(QB.ResultData.O['Data']));
    result := QB.ResultData.O['Data'].AsString;
    LoginList('Done.');
  end
  else begin
    LogError(QB.ResultData.S['UserMessage'], QB.ResultData.S['APIMessage']);
  end;
end;

(*procedure TfmQuickbooksSynchList.DoOnLog(const msg: string; const aType: string);
var
  s: string;
begin
  s := aType;
  if s <> '' then s := s + ' ';
  s := s + msg;
  LogInList(s);
end;*)

(*procedure TfmQuickbooksSynchList.DoOnSynchError(Sender: TObject);
begin
  LogError(Synch.UserMessage, Synch.APIMessage, Synch.CoreService.ResultData.S['CurrentTask']);
//  StopSynch;
end;*)

(*procedure TfmQuickbooksSynchList.DoOnSynchProg(Sender: TErpSynch;
  var Continue: boolean; msg: string);
var
  s: string;
begin
  //pbProgress.Position := System.Round((Synch.CurrentSynchItemNo / Synch.TotalItemsToSynch) * 100);
  //lblProgress.Caption :=
  s :=
    'Processing Rec ' + IntToStr(Synch.CurrentSynchItemNo) + ' of ' + IntToStr(Synch.TotalItemsToSynch) +
    ' ' + Synch.CurrentSynchItemType;
  if Synch.CurrentSynchId > 0 then
    s := s + ' Id: ' + IntToStr(Synch.CurrentSynchId);
  if msg <> '' then
    s := s + ' ' + msg;
  LoginList(s);
end;*)

procedure TfmQuickbooksSynchList.FormCreate(Sender: TObject);
begin
  inherited;
  Synch := nil;
  (*CoreEDI := nil;*)
  if Appenv.companyprefs.IntuitConfig.AutoSynchFromList then
    lblListHint.caption := lblListHint.caption + '  The List will Automatically Synchronized with Quickbooks every 10 Minutes.';
  lblListHint.visible := True;
  lblListHint.refresh;
end;

procedure TfmQuickbooksSynchList.FormDestroy(Sender: TObject);
begin
  inherited;
(*  CoreEDI.Free;
  Synch.Free;*)
end;

procedure TfmQuickbooksSynchList.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := true;
  ShowLogAutomessage := false;
  TfmEDIAutocheckProgress(fEDIAutocheckProgress).lblhint.Caption :=
    'Preference to "Auto Synch from List" is Disabled.' + NL +
      'This can be Changed from Preferences(EDI)'
end;

procedure TfmQuickbooksSynchList.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  if SameText(qryMainTransType.AsString, 'Invoice') then begin
    OpenERPForm('TInvoiceGUI', qryMainID.AsInteger);
  end
  else if SameText(qryMainTransType.AsString, 'Bill') then begin
    OpenERPForm('TBillGUI', qryMainID.AsInteger);
  end
  else if SameText(qryMainTransType.AsString, 'Purchase Order') then begin
    OpenERPForm('TPurchaseGUI', qryMainID.AsInteger);
  end;
end;

function TfmQuickbooksSynchList.HasEDICredentials: Boolean;
begin
  Result := inherited HasEDICredentials;
  if not result then exit;
    if AppEnv.CompanyPrefs.IntuitConfig.SandboxMode then begin
      if AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID = '' then begin
        CommonLib.MessageDlgXP_Vista('Sandbox Client ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
      if AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret = '' then begin
        CommonLib.MessageDlgXP_Vista('Sandbox Client Secret is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
    end
    else begin
      if AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID = '' then begin
        CommonLib.MessageDlgXP_Vista('Production Client ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
      if AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret = '' then begin
        CommonLib.MessageDlgXP_Vista('Production Client Secret is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
    end;
    if AppEnv.CompanyPrefs.IntuitConfig.CompanyID = '' then begin
      CommonLib.MessageDlgXP_Vista('Company ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    if AppEnv.CompanyPrefs.CoreEDIUSerName = '' then begin
      CommonLib.MessageDlgXP_Vista('Core EDI User is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    if AppEnv.CompanyPrefs.CoreEDIPassword = '' then begin
      CommonLib.MessageDlgXP_Vista('Core EDI Password is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    Result := True;
end;

procedure TfmQuickbooksSynchList.InitCodeEDI;
begin
  inherited;
end;

function TfmQuickbooksSynchList.InitializeCoreEDIObj: Boolean;
begin
  result := inherited InitializeCoreEDIObj;
  Synch := TErpSynch(SynchObj);
end;

Function TfmQuickbooksSynchList.MakeCoreServiceObj :TBaseCoreService;
begin
   Result := TQuickbooksCoreService.Create;
   QB:=TQuickbooksCoreService(Result);
end;
(*function TfmQuickbooksSynchList.InitializeCoreEDI: boolean;
begin
  result := false;
  if not Assigned(CoreEDI) then begin
    if AppEnv.CompanyPrefs.IntuitConfig.SandboxMode then begin
      if AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID = '' then begin
        CommonLib.MessageDlgXP_Vista('Sandbox Client ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
      if AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret = '' then begin
        CommonLib.MessageDlgXP_Vista('Sandbox Client Secret is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
    end
    else begin
      if AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID = '' then begin
        CommonLib.MessageDlgXP_Vista('Production Client ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
      if AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret = '' then begin
        CommonLib.MessageDlgXP_Vista('Production Client Secret is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
        exit;
      end;
    end;
    if AppEnv.CompanyPrefs.IntuitConfig.CompanyID = '' then begin
      CommonLib.MessageDlgXP_Vista('Company ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    if AppEnv.CompanyPrefs.IntuitConfig.CoreEDIUser = '' then begin
      CommonLib.MessageDlgXP_Vista('Core EDI User is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    if AppEnv.CompanyPrefs.IntuitConfig.CoreEDIPassword = '' then begin
      CommonLib.MessageDlgXP_Vista('Core EDI Password is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;

    CoreEDI := TCoreEDI.Create;
    //CoreEDI.OnLog := DoOnLogEvent;

    // CoreEDI.CoreEDIServer := 'erpclientserver.dyndns.org:8445';

    QB := TQuickbooksCoreService.Create;
    CoreEDI.AddService(QB);
    QB.CompanyRegion := AppEnv.RegionalOptions.Region;
    //QB.CompanyID := '4620816365012546930'; { USA Company }
    //QB.OnEvent := DoOnQuickbooksCoreServiceEvent;

    Synch := TErpSynch.Create;
    Synch.OnSynchProgress := DoOnSynchProg;
    Synch.OnSynchError := DoOnSynchError;
    Synch.CoreService := QB;
    Synch.OnLog := DoOnLog;
  end;
  if not CoreEDI.Connected then begin

    CoreEDI.CoreEDIUser := AppEnv.CompanyPrefs.IntuitConfig.CoreEDIUser;
    CoreEDI.CoreEDIPassword := AppEnv.CompanyPrefs.IntuitConfig.CoreEDIPassword;
    QB.SandboxMode := AppEnv.CompanyPrefs.IntuitConfig.SandboxMode;
    if QB.SandboxMode then begin
      QB.ClientID := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID;
      QB.ClientSecret := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret;
    end
    else begin
      QB.ClientID := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID;
      QB.ClientSecret := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret;
    end;

    QB.CompanyID := AppEnv.CompanyPrefs.IntuitConfig.CompanyID;

    try
      CoreEDI.Connect;
    except
      on e: exception do begin
//        DoMemoDialogOnTop(self, 'Error Connecting to CoreEDI Server',
//          'The following error occured while trying to connect to the CoreEDI Server:' +#13#10 +#13#10 +
//          e.Message, ssBoth);
        LoginList('The following error occured while trying to connect to the CoreEDI Server:' + #13#10 + #13#10 + e.Message);
        exit;
      end;
    end;

    if not CoreEDI.Connected then begin
      LoginList('Failed to connect to CoreEDI Server.');
      exit;
    end;

    if not QB.Initialize then begin

      if SameText(QB.ResultData.S['ReturnCode'], 'UserAuthRequired') then begin
        if CommonLib.MessageDlgXP_Vista(QB.ResultData.S['UserMessage'], mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
          ShellExecute(0, 'OPEN', PChar(QB.ResultData.S['AuthURL']), '', '', SW_SHOWNORMAL);
      end
      else begin
//        DoMemoDialogOnTop(self, 'Error Initializing the CoreEDI Quickbooks Service',
//          'The following error occured while trying to Initialize CoreEDI Quickbooks Service:' +#13#10 +#13#10 +
//          QB.ResultData.S['UserMessage'], ssBoth);
        LoginList('The following error occured while trying to Initialize CoreEDI Quickbooks Service:' + #13#10 + #13#10 +
          QB.ResultData.S['UserMessage']);
      end;

      QB.Initialized := false;
      CoreEDI.Connected := false;
      exit;
    end;

  end;

  { connected and initialized }
  Synch.Active := true;
  result := true;

end;*)

(*procedure TfmQuickbooksSynchList.LogError(const UserMessage, APIMessage: string;  CurrentTask: string);
var
  json: TJsonObject;
  s: string;
begin
  s := '';
  if CurrentTask <> '' then
    s := 'Current Task: ' + CurrentTask + #13#10;


  s := s + 'Error Returned:' + #13#10;

  if UserMessage <> '' then begin
    s := s + UserMessage;
    s := s + #13#10;
  end;


  if APIMessage <> '' then begin
    json := JO;
    try
      json.AsString := APIMessage;
      s := s + JsonToStrFormat(json);
    finally
      json.Free;
    end;
  end;
//  else begin
//    s := s + 'Error Returned:' + #13#10 + #13#10 +
//      UserMessage;
//  end;
  LoginList('Error Synchronizing Data' + #13#10 + s);
end;*)

function TfmQuickbooksSynchList.ModuleCaption: string;
begin
  result := Servicename_Quickbooks;
end;

procedure TfmQuickbooksSynchList.OpenPreferance;
begin
  OpenPrefForm('EDI and Integration' ,  'chkAutoSynchFromList', 0 , True, 'Intuit (QuickBooks)' , 'pnlIntuitConfig' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TfmQuickbooksSynchList.RefreshQuery;
//var
//  dt: TDateTime;
begin
//  dt := EncodeDate(1971,1,1);
//  if AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate > dt then
//    dt := AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate;
  qryMain.Close;
  qryMain.ParamByName('DateFrom').AsDateTime := Trunc(AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate);
  inherited;
end;

function TfmQuickbooksSynchList.SynchTransactions: boolean;
begin
  result := false;
  if not AppEnv.CompanyPrefs.IntuitConfig.EnableQuickbooks then begin
    CommonLib.MessageDlgXP_Vista('Quickbooks is not enabled in Preferences.', mtInformation, [mbOk],0);
    exit;
  end;
  if not AppEnv.UtilsClient.LicenceOptionEnabled('Quickbooks') then begin
    CommonLib.MessageDlgXP_Vista('Quickbooks Option is not enabled in your TrueERP Licence, please contact ERP Support.', mtInformation, [mbOk],0);
    exit;
  end;

  LoginList('Starting Synch ...' + #13#10);

  if qryMain.RecordCount > 0 then begin
    LoginList('Found ' + IntToStr(qryMain.RecordCount) + ' transactions that need to be sent to Quickbooks.');
    try
      while not qryMain.Eof do begin
        if not Synch.Active then begin
          StopSynch;
          exit;
        end;

        if SameText(qryMain.FieldByName('TransType').AsString, 'Invoice') then
          Synch.DoSynchInvoice(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount)
        else if SameText(qryMain.FieldByName('TransType').AsString, 'Bill') then
          Synch.DoSynchBill(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount)
        else if SameText(qryMain.FieldByName('TransType').AsString, 'Purchase Order') then
          Synch.DoSynchPurchaseOrder(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount);

        Application.ProcessMessages;
        if not Synch.Active then
          break;


        qryMain.Next;
      end;
    finally
      RefreshQuery;
    end;
  end
  else begin
    LoginList('No Transactions Found to Synch.');
  end;
  LoginList('Checking for new Payments in Quickbooks ...' + #13#10);
  Synch.SynchPaymentsFromRemote;

  LoginList('Checking for new Customers in Quickbooks ...' + #13#10);
  Synch.GetCustomersFromRemote;

  LoginList('Checking for new Suppliers (Vendors) in Quickbooks ...' + #13#10);
  Synch.GetSuppliersFromRemote;

//  LoginList('Checking for new Refunds (Credit Memo) in Quickbooks ...' + #13#10);
//  Synch.GetRefundsFromRemote;

  LoginList('Finished.');
  result := true;
end;

procedure TfmQuickbooksSynchList.StopSynch;
begin
  StopSynch(btnSynchTransactions);
(*  if CoreEDI.Connected and Synch.Active then
    Synch.Active := false;
//  pbProgress.Position := 0;
//  lblProgress.Caption := '';
  btnSynchTransactions.Caption := fsSynchCaption;*)
end;

initialization
  RegisterClass(TfmQuickbooksSynchList);

end.
