unit frmQuickbooksExportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, ComCtrls, AdvProgr, ErpSynchObj,
  CoreEDIObj, utQuickbooksCoreService, ERPEDIListBase;

type
  TfmQuickbooksExportList = class(TERPEDIListBaseGUI)
    qryMainID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateField;
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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSynchTransactionsClick(Sender: TObject);
  private
    Synch: TErpSynch;
    CoreEDI: TCoreEDI;
    QB: TQuickbooksCoreService;
    procedure StartSynch;
    procedure StopSynch;
    procedure DoOnSynchError(Sender: TObject);
    procedure DoOnSynchProg(Sender: TErpSynch; var Continue: boolean);
  protected
    function Autocheck: boolean; Override;
    function ModuleCaption: string; Override;
    Function CheckOrdersInterval: Integer; Override;
    Procedure DoEDIAutocheck(Sender: TObject); override;
  public
    Procedure OpenPreferance; override;
  end;

implementation

uses
  AppEnvironment, CommonLib, ShellAPI, JsonObject, JsonObjectUtils, Preferences;

{$R *.dfm}


function TfmQuickbooksExportList.Autocheck: boolean;
begin
  result := Appenv.companyprefs.IntuitConfig.AutoSynchFromList;
end;

procedure TfmQuickbooksExportList.btnSynchTransactionsClick(Sender: TObject);
begin
  inherited;
  InitTimers(false);
  if SameText(btnSynchTransactions.Caption, 'Synch Transactions') then
    StartSynch
  else
    StopSynch;
end;

function TfmQuickbooksExportList.CheckOrdersInterval: Integer;
begin
  result := inherited;
end;

procedure TfmQuickbooksExportList.DoEDIAutocheck(Sender: TObject);
begin
  inherited;
  StartSynch;
end;

procedure TfmQuickbooksExportList.DoOnSynchError(Sender: TObject);
var
  json: TJsonObject;
  s: string;
begin
  s := '';
  if Synch.CoreService.ResultData.S['CurrentTask'] <> '' then
    s := 'Current Task: ' + Synch.CoreService.ResultData.S['CurrentTask'] + #13#10;

  if Synch.APIMessage <> '' then begin
    s := s + 'Error Returned:' + #13#10 +#13#10;
    json := JO;
    try
      json.AsString := Synch.APIMessage;
      s := s + JsonToStrFormat(json);
    finally
      json.Free;
    end;
  end
  else begin
    s := s + 'Error Returned:' + #13#10 + #13#10 +
      Synch.UserMessage;
  end;
//  DoMemoDialogOnTop(self, 'Error Synchronizing Data',
//    s, ssBoth);

  LoginList('Error Synchronizing Data' + #13#10 + #13#10 + s);

  StopSynch;
end;

procedure TfmQuickbooksExportList.DoOnSynchProg(Sender: TErpSynch;
  var Continue: boolean);
begin
  //pbProgress.Position := System.Round((Synch.CurrentSynchItemNo / Synch.TotalItemsToSynch) * 100);
  //lblProgress.Caption :=
  LoginList('Processing Rec ' + IntToStr(Synch.CurrentSynchItemNo) + ' of ' + IntToStr(Synch.TotalItemsToSynch) +
    ' ' + Synch.CurrentSynchItemType + ' Id: ' + IntToStr(Synch.CurrentSynchId));
end;

procedure TfmQuickbooksExportList.FormCreate(Sender: TObject);
begin
  inherited;
  Synch := nil;
  CoreEDI := nil;
  if Appenv.companyprefs.IntuitConfig.AutoSynchFromList then
    lblListHint.caption := lblListHint.caption + '  The List will Automatically Synchronized with Quickbooks every 10 Minutes.';
  lblListHint.visible := True;
  lblListHint.refresh;
end;

procedure TfmQuickbooksExportList.FormDestroy(Sender: TObject);
begin
  inherited;
  CoreEDI.Free;
  Synch.Free;
end;

procedure TfmQuickbooksExportList.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := true;
  ShowLogAutomessage := false;
end;

function TfmQuickbooksExportList.ModuleCaption: string;
begin
  result := 'Quickbooks';
end;

procedure TfmQuickbooksExportList.OpenPreferance;
begin
  OpenPrefForm('EDI and Integration' ,  'chkAutoSynchFromList', 0 , True, 'Intuit (QuickBooks)' , 'pnlIntuitConfig' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TfmQuickbooksExportList.StartSynch;
begin
  RefreshQuery;
  if qryMain.RecordCount = 0 then begin
    CommonLib.MessageDlgXP_Vista('There are no items to syncronize.', mtInformation, [mbOk], 0);
    exit;
  end;

  if not Assigned(CoreEDI) then begin
    if AppEnv.CompanyPrefs.IntuitConfig.ClientID = '' then begin
      CommonLib.MessageDlgXP_Vista('Client ID is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
    end;
    if AppEnv.CompanyPrefs.IntuitConfig.ClientSecret = '' then begin
      CommonLib.MessageDlgXP_Vista('Client Secret is not set in Intuit (Quickbooks) / EDI and Integration Preference', mtInformation, [mbOk],0);
      exit;
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
    CoreEDI.CoreEDIServer := 'erpclientserver.dyndns.org:8445';

    QB := TQuickbooksCoreService.Create;
    CoreEDI.AddService(QB);
    QB.CompanyRegion := AppEnv.RegionalOptions.Region;
    //QB.CompanyID := '4620816365012546930'; { USA Company }
    //QB.OnEvent := DoOnQuickbooksCoreServiceEvent;

    Synch := TErpSynch.Create;
    Synch.OnSynchProgress := DoOnSynchProg;
    Synch.OnSynchError := DoOnSynchError;
    Synch.CoreService := QB;
  end;
  if not CoreEDI.Connected then begin

    CoreEDI.CoreEDIUser := AppEnv.CompanyPrefs.IntuitConfig.CoreEDIUser;
    CoreEDI.CoreEDIPassword := AppEnv.CompanyPrefs.IntuitConfig.CoreEDIPassword;
    QB.SandboxMode := AppEnv.CompanyPrefs.IntuitConfig.SandboxMode;
    QB.CompanyID := AppEnv.CompanyPrefs.IntuitConfig.CompanyID;
    QB.ClientID := AppEnv.CompanyPrefs.IntuitConfig.ClientID;
    QB.ClientSecret := AppEnv.CompanyPrefs.IntuitConfig.ClientSecret;

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
  btnSynchTransactions.Caption := 'Stop Synch';
  Synch.Active := true;

  LoginList('Found ' + IntToStr(qryMain.RecordCount) + ' transactions that need to be sent to Quickbooks.');
  LoginList('Starting Synch ...' + #13#10 + #13#10);

  while not qryMain.Eof do begin
    if not Synch.Active then begin
      StopSynch;
      exit;
    end;

    if SameText(qryMain.FieldByName('TransType').AsString, 'Invoice') then begin
      Synch.DoSynchInvoice(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount);

    end;
    Application.ProcessMessages;

    qryMain.Next;
  end;
  StopSynch;
  RefreshQuery;
end;

procedure TfmQuickbooksExportList.StopSynch;
begin
  if CoreEDI.Connected and Synch.Active then
    Synch.Active := false;
//  pbProgress.Position := 0;
//  lblProgress.Caption := '';
  btnSynchTransactions.Caption := 'Synch Transactions';
end;

initialization
  RegisterClass(TfmQuickbooksExportList);

end.
