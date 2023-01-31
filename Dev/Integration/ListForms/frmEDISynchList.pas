unit frmEDISynchList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPEDIListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, utBaseCoreService,
  ERPEDIOBJ, utEDIService, ERPEDIBase;

type
  TfmEDISynchList = class(TERPEDIListBaseGUI)
    pnlExtraButtons: TDNMPanel;
    lblExporttoWalmart: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkShowProduct: TwwCheckBox;
    btnSynchTransactions: TDNMSpeedButton;
    btnDev: TDNMSpeedButton;
    qryMainID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainSynchStatus: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainX12_ConfigStr: TWideMemoField;
    procedure btnSynchTransactionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnDevClick(Sender: TObject);
  private
    Synch: TERPEDI;
    EDI: TEDIService;
  protected
    procedure StopSynch; Overload;
    function SynchTransactions: boolean;
    Function HasEDICredentials :Boolean ; Override;
    Function MakeCoreServiceObj: TBaseCoreService; Override;
    function InitializeCoreEDIObj: Boolean; Override;

    function Autocheck: boolean; Override;
    function ModuleCaption: string; Override;
    Function CheckOrdersInterval: Integer; Override;
    Procedure DoEDIAutocheck(Sender: TObject); override;
    procedure RefreshQuery; override;
    Procedure InitCodeEDI; Override;
    function CreateERPEDISynchObj: TERPEDIBase; override;
  public
    procedure OpenPreferance; override;
  end;

var
  fmEDISynchList: TfmEDISynchList;

implementation

{$R *.dfm}

uses
  Preferences, AppEnvironment, frmEDIAutocheckProgress, tcConst,
  BusObjSimpleTypes, DbSharedObjectsObj, CommonDbLib, CommonLib,
  CommonFormLib, CoreEDILib;


{ TfmEDISynchList }

function TfmEDISynchList.Autocheck: boolean;
begin
  result := Appenv.Companyprefs.EDIConfig.AutoSynchFromList;
end;

procedure TfmEDISynchList.btnDevClick(Sender: TObject);
begin
  inherited;
  if not InitializeCoreEDIObj then exit;
  synch.GetPOEDIDocList('37055');
end;

procedure TfmEDISynchList.btnSynchTransactionsClick(Sender: TObject);
begin
  inherited;
  if not Appenv.companyprefs.MagentoEnabled then DoEDICheckEvent;
end;

function TfmEDISynchList.CheckOrdersInterval: Integer;
begin
  result := inherited;
end;

function TfmEDISynchList.CreateERPEDISynchObj: TERPEDIBase;
begin
  result := TERPEDI.Create;
end;

procedure TfmEDISynchList.DoEDIAutocheck(Sender: TObject);
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

procedure TfmEDISynchList.FormCreate(Sender: TObject);
begin
  inherited;
  Synch := nil;
  (*CoreEDI := nil;*)
  if Appenv.companyprefs.EDIConfig.AutoSynchFromList then
    lblListHint.caption := lblListHint.caption + '  The List will Automatically check for EDI documents every 10 Minutes.';
  lblListHint.visible := True;
  lblListHint.refresh;
  btnDev.visible := devmode;
end;

procedure TfmEDISynchList.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := true;
  ShowLogAutomessage := false;
  TfmEDIAutocheckProgress(fEDIAutocheckProgress).lblhint.Caption :=
    'Preference to "Auto Synch from List" is Disabled.' + NL +
      'This can be Changed from Preferences(EDI)'
end;

procedure TfmEDISynchList.grdMainDblClick(Sender: TObject);
begin
  if SameText(qryMainTransType.AsString, 'Purchase Order') then begin
    OpenERPForm('TPurchaseGUI', qryMainID.AsInteger);
  end
  else begin
    inherited;
  end;
end;

function TfmEDISynchList.HasEDICredentials: Boolean;
begin
  Result := inherited HasEDICredentials;
end;

procedure TfmEDISynchList.InitCodeEDI;
var
  s: string;
begin
  CoreEDI.CoreEDIServer := '';
  inherited;
  if CoreEDI.CoreEDIServer <> '' then exit;
(*//  CoreEDI.CoreEDIServer := 'erpclientserver.dyndns.org:8445';
  if DevMode then begin
    s := InputBox('CoreEDI Server','localhost:8445','localhost:8445');
    if s <> '' then
      CoreEDI.CoreEDIServer := s;
  end;*)
  CoreEDiLib.InitCodeEDI(CoreEDI);
end;

function TfmEDISynchList.InitializeCoreEDIObj: Boolean;
begin
  result := inherited InitializeCoreEDIObj;
  Synch := TERPEDI(SynchObj);
end;

function TfmEDISynchList.MakeCoreServiceObj: TBaseCoreService;
begin
   Result := TEDIService.Create;
   EDI:=TEDIService(Result);
end;

function TfmEDISynchList.ModuleCaption: string;
begin

end;

procedure TfmEDISynchList.OpenPreferance;
begin
  OpenPrefForm('EDI and Integration' ,  'chkAutoSynchFromList', 0 , True, 'EDI (X12)' , 'pnlEDIConfig' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TfmEDISynchList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParamByName('ReadyStatus').AsString       := AppEnv.CompanyPrefs.EDIConfig.POReadyStatus;
  qryMain.ParamByName('SentStatus').AsString        := AppEnv.CompanyPrefs.EDIConfig.POSentStatus;
  qryMain.ParamByName('AcknowlgedStatus').AsString  := AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus;
  qryMain.ParamByName('ShippedStatus').AsString     := AppEnv.CompanyPrefs.EDIConfig.POShippedStatus;

  qryMain.ParamByName('SalesReadyStatus').AsString      := AppEnv.CompanyPrefs.EDIConfig.SalesReadyStatus;
  qryMain.ParamByName('SalesSentStatus').AsString       := AppEnv.CompanyPrefs.EDIConfig.SalesSentStatus;
  qryMain.ParamByName('SalesAcknowlgedStatus').AsString := AppEnv.CompanyPrefs.EDIConfig.SalesAcknowledgementStatus;
  qryMain.ParamByName('SalesShippedStatus').AsString    := AppEnv.CompanyPrefs.EDIConfig.SalesShippedStatus;

  inherited;

end;

procedure TfmEDISynchList.StopSynch;
begin
  StopSynch(btnSynchTransactions);
end;

function TfmEDISynchList.SynchTransactions: boolean;
var
  qry: TERPQuery;
begin
  result := false;
  LoginList('Starting Synch ...' + #13#10);

  if qryMain.RecordCount > 0 then begin
    if not TOrderStatus.NameExistsAndActive(AppEnv.CompanyPrefs.EDIConfig.POSentStatus) then begin
      LoginList('The Sent Status from EDI Preferences is either blank, does not exist in the Order Status List or the Order Status is not Active.');
      LoginList('Stopping Order Send Process.');
      StopSynch;
      exit;
    end;

    LoginList('Found ' + IntToStr(qryMain.RecordCount) + ' transactions that need to be processed.');
    try
      while not qryMain.Eof do begin
        if not Synch.Active then begin
          StopSynch;
          exit;
        end;

        if SameText(qryMain.FieldByName('TransType').AsString, 'Purchase Order') then begin
         // Synch.DoSynchInvoice(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount)
          if SameText(qryMain.FieldByName('SynchStatus').AsString, AppEnv.CompanyPrefs.EDIConfig.POReadyStatus) then begin
            synch.Send_X12_PurchaseOrder(qryMain.FieldByName('ID').AsInteger);
          end;
        end else if SameText(qryMain.FieldByName('TransType').AsString, 'Invoice') then begin
         // Synch.DoSynchInvoice(qryMain.FieldByName('Id').AsInteger, qryMain.RecNo, qryMain.RecordCount)
          if SameText(qryMain.FieldByName('SynchStatus').AsString, AppEnv.CompanyPrefs.EDIConfig.SalesReadyStatus) then begin
            synch.Send_X12_Invoice(qryMain.FieldByName('ID').AsInteger);
          end;
        end;

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
  LoginList('Checking for Purchase Order Acknowledgements ...' + #13#10);
  if not TOrderStatus.NameExistsAndActive(AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus) then begin
    LoginList('The Acknowledgement Status from EDI Preferences ('+ Quotedstr(AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus) +') is either blank, does not exist in the Order Status List or the Order Status is not Active.');
    LoginList('Stopping Order Acknowledgement Check Process.');
    StopSynch;
    exit;
  end;
  if not TOrderStatus.NameExistsAndActive(AppEnv.CompanyPrefs.EDIConfig.POShippedStatus) then begin
    LoginList('The Shipped Status from EDI Preferences  ('+ Quotedstr(AppEnv.CompanyPrefs.EDIConfig.POShippedStatus) +') is either blank, does not exist in the Order Status List or the Order Status is not Active.');
    LoginList('Stopping Order Acknowledgement Check Process.');
    StopSynch;
    exit;
  end;

  // Synch.SynchPaymentsFromRemote;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select cfg.ClientID, c.PrintName from tblCoreEDIConfig cfg');
    qry.SQL.Add('inner join tblclients c on c.ClientID = cfg.ClientId');
    qry.SQL.Add('where cfg.X12_POSendActive = "T"');
    qry.Open;
    (*while not qry.Eof do begin
      if not Synch.Active then
        break;
      LoginList('Checking ' + qry.FieldByName('PrintName').AsString);
      synch.GetPOEDIDocList(qry.FieldByName('ClientID').AsInteger);
      qry.Next;
    end;*)
    synch.GetPOEDIDocList(qry.GroupConcat('ClientID'));

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

(*  // Synch.SynchPaymentsFromRemote;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select cfg.ClientID, c.PrintName from tblCoreEDIConfig cfg');
    qry.SQL.Add('inner join tblclients c on c.ClientID = cfg.ClientId');
    qry.SQL.Add('where cfg.X12_SalesSendActive = "T"');
    qry.Open;
    while not qry.Eof do begin
      if not Synch.Active then
        break;
      LoginList('Checking ' + qry.FieldByName('PrintName').AsString);
      synch.GetInvoiceEDIDocList(qry.FieldByName('ClientID').AsInteger);
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;*)


  LoginList('Finished.');
  result := true;
end;

initialization
  commonlib.RegisterClassOnce(TfmEDISynchList);

end.
