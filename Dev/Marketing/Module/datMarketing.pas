unit datMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  MessageInterface,Dialogs, BaseGUIDatamodule, ImgList, ActnList, DNMAction,
  Menus, AdvMenus, ActionsObj, frmReportSelectorFrm;

type
  TdtmMarketingAddin = class(TdtmGUI)
    ActionList                  : TActionList;
    actContactSelectionRange    : TDNMAction;
    actContactSelectionRangeList: TDNMAction;
    actMarketing: TDNMAction;
    actMarketingContact: TDNMAction;
    actMarketingContactList     : TDNMAction;
    actMarketingContactSummary  : TDNMAction;
    actLeadList                 : TDNMAction;
    MainMenu                    : TAdvMainMenu;
    Marketing: TMenuItem;
    RangeSelectionList1         : TMenuItem;
    ContactSelectionRange1: TMenuItem;
    LeadList1: TMenuItem;
    MarketingContactList1: TMenuItem;
    Marketing1: TMenuItem;
    MarketingContactSummary1: TMenuItem;
    MarketingContact1: TMenuItem;
    actLead: TDNMAction;
    actMarketingList: TDNMAction;
    actMarketingReports: TDNMAction;
    actReminderPrn: TDNMAction;
    actMarketingContactListDetail: TDNMAction;
    mnuMarketingActionList: TMenuItem;
    elemarketingList1: TMenuItem;
    Lead1: TMenuItem;
    About1: TMenuItem;
    About2: TMenuItem;
    About3: TMenuItem;
    About4: TMenuItem;
    SalesRatiosReport1: TMenuItem;
    About6: TMenuItem;
    PrintReminders1: TMenuItem;
    actMarketingContactProduct: TDNMAction;
    actMarketingContactcontact: TDNMAction;
    actProductProcessList: TDNMAction;
    actsalesAnalysisGraph: TDNMAction;
    SalesAnalysisChart1: TMenuItem;
    actClientnMarketingList: TDNMAction;
    actLeadActionType: TDNMAction;
    ActionTypes1: TMenuItem;
    actSalesAnalysis: TDNMAction;
    actSalesAnalysisList: TDNMAction;
    HowTo1: TMenuItem;
    CreatingandUsingLeads1: TMenuItem;
    procedure DataModuleCreate(Sender: TObject);
    procedure actMarketingReportsExecute(Sender: TObject);
    procedure actLeadActionTypeExecute(Sender: TObject);
  private
    LeadsObj: TObject;
    procedure NewAppointment(const Sender: TObject);
    procedure LoadFormWithClient(const Sender: TObject;Const aClassName: string);
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
    procedure GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);Override;
  public
  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;


implementation

uses FastFuncs, CommonLib,
  GlobalEventsObj, BusObjMarketingLeads , AppointmentLib,
  dmMainGUI, frmSimpleTypes, tcconst, MainSwitchFrm2;


{$R *.dfm}
function TdtmMarketingAddin.GetItem(
  const ActionName: string): TActionHelperItem;
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

procedure TdtmMarketingAddin.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin

        ReportSelector.Add(REPORT_GROUP_MARKETING, 'BOM Jobs'                         , 'TBOMJobsGUI'            , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Client And Markerting Contact List', 'TClientsandMarketingcontactsListGUI'               , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Feedback Report'                  , 'TFeedbackListGUI'            , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Leads'                            , 'TMarketingLeadsGUI'          , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Marketing Action List'            , 'TMarketingContactListDetailGUI'    , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Marketing Contact List'           , 'TMarketingContactGUI'    , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Marketing Contact Summary'        , 'TMarketingContactSummaryGUI'               , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Marketing Ratio Report'           , 'TfrmMarketingRatios'         , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Raw Marketing Contact List'       , 'TMarketingContactRawListGUI' , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Quote Status Report'              , 'TQuoteListGUI'               , 0,'Quote Status Report');
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Sales Pipeline Report'            , 'TfrmSalesPipelineReport'     , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Sales Ratios Report'              , 'TfrmSalesRatioReport'        , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Sales Reward Points'              , 'TfmSalesRewardPointsList'    , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Source List'                      , 'TSourceListGUI'              , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Stow Away List'                   , 'TStowAwayListGUI'              , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Telemarketing List'               , 'TMarketingGUI'               , 0);
        ReportSelector.Add(REPORT_GROUP_MARKETING, 'Unallocated Batch Sales List'     , 'TUnallocatedBatchSalesListGUI', 0);


    end;
end;

procedure TdtmMarketingAddin.GeneralHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
    inherited GeneralHandler(Sender,Event,Data);
    if (Sender is TLeads) then begin
        LeadsObj := Sender;
        if Event = GEVENT_LEAD_CREATEQUOTE then begin
            LoadFormWithClient(Sender, 'TQuoteGUI');
        end else if Event = GEVENT_LEAD_CREATEINVOICE then begin
            LoadFormWithClient(Sender, 'TInvoiceGUI');
        end else if Event = GEVENT_LEAD_CREATEAPPOINTMENT then begin
            NewAppointment(Sender);
        end else if Event = GEVENT_LEAD_CREATETODO then begin
            LoadFormWithClient(Sender,'TfrmToDo');
        end else if Event = GEVENT_LEAD_CREATESALESORDER then begin
            LoadFormWithClient(Sender,'TSalesOrderGUI');
        end;
    end;
end;

procedure TdtmMarketingAddin.LoadFormWithClient(const Sender: TObject;Const aClassName: string);
var
    MsgObj: TMsgObj;
    Form: TForm;
    fMsgHandler: TMsgHandler;
begin
    Form := TForm(GetComponentByClassName(aClassName));
    if Assigned(Form) then begin
        MsgObj := TMsgObj.Create;
        fMsgHandler := TMsgHandler.Create(Self);
        try
            MsgObj.ClassStr := aClassName;
            MsgObj.MethodStr := 'InitialiseCustomerID';
            MsgObj.SenderStr := TLeads(sender).ClassName;
            MsgObj.IntValue := TLeads(sender).ClientID;
            fMsgHandler.Send(MsgObj, MsgObj);
            Form.FormStyle := fsMDIChild;
            Form.BringToFront;
        finally
            FreeAndNil(MsgObj);
            FreeAndNil(fMsgHandler);
        end;
    end;
end;
procedure TdtmMarketingAddin.NewAppointment(const Sender: TObject);
begin
  TLeads(sender).PostDb;
  AppointmentLib.NewAppointment(TLeads(Sender).ClientID , Self , 0);

end;
procedure TdtmMarketingAddin.DataModuleCreate(Sender: TObject);
begin
  //LoadImagefromAppMainImageList := True;
  inherited;
  GlobalEvents.RegisterNameHandler(Self, 'TfmMarketingLead', '', GEVENT_LEAD_CREATEQUOTE, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfmMarketingLead', '', GEVENT_LEAD_CREATEINVOICE, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfmMarketingLead', '', GEVENT_LEAD_CREATEAPPOINTMENT, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfmMarketingLead', '', GEVENT_LEAD_CREATETODO, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfmMarketingLead', '', GEVENT_LEAD_CREATESALESORDER, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_LEAD_REFRESH, GeneralHandler);
  LeadsObj := nil;
end;

procedure TdtmMarketingAddin.actLeadActionTypeExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadActionType);
end;

procedure TdtmMarketingAddin.actMarketingReportsExecute(Sender: TObject);
begin
  inherited;
    AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_MARKETING));
end;

end.

