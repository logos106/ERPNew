unit datERP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseAddinModule, Menus, ActnList, BaseGUIDatamodule, ImgList,
  DNMAction, ActionsObj, ProgressDialog, frmReportSelectorFrm;

type
  TdmERP = class(TdtmGUI)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ERP1: TMenuItem;
    actClientTreeList: TDNMAction;
    actMasterSMSConfig: TDNMAction;
    actERPClientList: TDNMAction;
    actGetClientMessageData: TDNMAction;
    actClientServerLog: TDNMAction;
    actMessageCostList: TDNMAction;
    actCreateSO: TDNMAction;
    actERPOffices: TDNMAction;
    actTrainingVideoConfiguration: TDNMAction;
    actHelpDocConfiguration: TDNMAction;
    Licence1: TMenuItem;
    MasterSMSConfig1: TMenuItem;
    ClientLicenceList1: TMenuItem;
    GetClientMessageData1: TMenuItem;
    ClientServerLog1: TMenuItem;
    MessageCostList1: TMenuItem;
    Licence2: TMenuItem;
    CreateSalesOrdersforSMSCharges1: TMenuItem;
    N1: TMenuItem;
    ERPOffices1: TMenuItem;
    trainingVideosAdmin1: TMenuItem;
    HelpDocsconfiguration1: TMenuItem;
    procedure actClientListExecute(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actGetClientMessageDataExecute(Sender: TObject);
    procedure actCreateSOExecute(Sender: TObject);
  private
    fProgDlg: TProgressDialog;
    procedure GetClientMessages;
    procedure DoOnProgress(Sender: TObject);
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
    destructor Destroy; override;
  Published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

implementation

{$R *.dfm}

uses
  GlobalEventsObj, CommonLib, ERPClientMessageLogObj,
  CommonDbLib, TaskDialog, frmSMSMasterAccountInfo;

procedure TdmERP.actClientListExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TdmERP.actCreateSOExecute(Sender: TObject);
var
  Proc: TTwilioProcessor;
  dlg: TAdvInputTaskDialog;
  aDate: TDateTime;
  day, month, year: word;
  ret: integer;
  ConfigMaster: TSMSConfigMaster;

begin
  Proc := TTwilioProcessor.Create;
  Proc.Connection := CommonDbLib.GetNewMyDacConnection(nil);
  ConfigMaster := TSMSConfigMaster.Create;
  try
    Proc.OnProgress := self.DoOnProgress;
    ConfigMaster.Load(Proc.Connection);
    Proc.SMSChargeProductName := ConfigMaster.SMSChargeProduct;
    dlg := TAdvInputTaskDialog.Create(nil);
    try
      dlg.Title := 'Date Selection';
      dlg.InputType := itDate;
      dlg.Instruction := 'Select the date you wish to invoice up to (inclusive)';
      dlg.Content := 'Select date';
      DecodeDate(now,year,month,day);
      aDate:= EncodeDate(year,month,1);
      dlg.InputText := DateToStr(aDate-1);
      dlg.CommonButtons:= [cbOk,cbCancel];
      dlg.Icon := tiQuestion;
      ret := dlg.Execute;
//      showmessage('result: ' + IntToStr( ret) + ' ' + dlg.InputText);
//      exit;
      if ret <> 1 then exit;
      aDate := StrToDate(dlg.InputText)+1;
    finally
      dlg.Free;
    end;

    Proc.Connection.StartTransaction;
    if Proc.GenerateSalesOrders(aDate) then begin
      Proc.Connection.Commit;
    end
    else begin
      Proc.Connection.Rollback;

    end;

  finally
    Proc.Connection.Free;
    Proc.Free;
    FreeAndNil(fProgDlg);
    ConfigMaster.Free;
  end;
end;

procedure TdmERP.actGetClientMessageDataExecute(Sender: TObject);
begin
  inherited;
  GetClientMessages;
end;

procedure TdmERP.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin
      //ReportSelector.Add(REPORT_GROUP_BUDGET, 'Account List For Budget', 'TChartOfAccountsListGUI', 0);
    end;
end;

procedure TdmERP.DataModuleDestroy(Sender: TObject);
begin
//  GlobalEvents.DeregisterHandlers(self);
//  inherited;
end;

destructor TdmERP.Destroy;
begin
  GlobalEvents.DeregisterHandlers(self);
  inherited;
end;


procedure TdmERP.DoOnProgress(Sender: TObject);
begin
  if Assigned(fProgDlg) then begin
    fProgDlg.Caption := TTwilioProcessor(Sender).ProgressCaption;
    fProgDlg.Message := TTwilioProcessor(Sender).ProgressStep;
    fProgDlg.MaxValue := TTwilioProcessor(Sender).StepCount;
    fProgDlg.Value := TTwilioProcessor(Sender).StepNo;
  end
  else begin
    fProgDlg := TProgressDialog.Create(nil);
    fProgDlg.Caption := TTwilioProcessor(Sender).ProgressCaption;
    fProgDlg.Message := TTwilioProcessor(Sender).ProgressStep;
    fProgDlg.MaxValue := TTwilioProcessor(Sender).StepCount;
    fProgDlg.Value := TTwilioProcessor(Sender).StepNo;
    fProgDlg.Execute;
  end;

end;

procedure TdmERP.GetClientMessages;
var
  Proc: TTwilioProcessor;
begin
  Proc := TTwilioProcessor.Create;
  try
    Proc.Connection := CommonDbLib.GetSharedMyDacConnection;
    Proc.OnProgress := self.DoOnProgress;
    Proc.GetNewMessages;



  finally
    Proc.Free;
    FreeAndNil(fProgDlg);
  end;
end;

function TdmERP.GetItem(const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
    if Sysutils.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
      Result := ActionHelper.Items[I];
      Break;
    end;
end;

end.
