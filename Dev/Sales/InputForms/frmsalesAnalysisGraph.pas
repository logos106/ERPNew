unit frmsalesAnalysisGraph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, DNMSpeedButton, Shader, DNMPanel, Mask, wwdbedit,
  TeEngine, TeePyramid, TeeProcs, Chart, DBChart, jpeg, DBCtrls, wwdblook,
  pngimage, frmEmployeeListfrm, BaseListingForm;

type
  TfmsalesAnalysisGraph = class(TBaseInputGUI)
    qryMain: TERPQuery;
    dsMain: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryMainNewVisits: TLargeintField;
    qryMainContacts: TLargeintField;
    qryMainFirstDemo: TLargeintField;
    qryMainsecondDemos: TLargeintField;
    qryMainQuotes: TLargeintField;
    qryMainSalesOrders: TLargeintField;
    qryMainSales: TLargeintField;
    cmdCancel: TDNMSpeedButton;
    qryMaincNewVisits: TWideStringfield;
    qryMaincContacts: TWideStringfield;
    qryMaincFirstDemo: TWideStringfield;
    qryMaincsecondDemos: TWideStringfield;
    qryMaincQuotes: TWideStringfield;
    qryMaincSalesOrders: TWideStringfield;
    qryMaincSales: TWideStringfield;
    qrySoruce: TERPQuery;
    qrySoruceMediatype: TWideStringField;
    qrySoruceMedtypeID: TIntegerField;
    qrySoruceActive: TWideStringField;
    qryActionType: TERPQuery;
    qryActionTypeName: TWideStringField;
    qryActionTypeId: TIntegerField;
    qryActionTypeTypeCode: TWideStringField;
    qryActionTypeActive: TWideStringField;
    dsSoruce: TDataSource;
    dsActionType: TDataSource;
    pnlFilter: TDNMPanel;
    lblTo: TLabel;
    lblFrom: TLabel;
    cboEmployee: TwwDBLookupCombo;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    btnRequery: TDNMSpeedButton;
    grdSoruce: TwwDBGrid;
    btnGrid: TwwIButton;
    grdActionType: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryEmployees: TERPQuery;
    chksource: TCheckBox;
    chkactiontypes: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    chkHideInactiveSource: TCheckBox;
    chkhideinactiveactiontype: TCheckBox;
    dsEmpcount: TDataSource;
    QryEmpcount: TERPQuery;
    QryEmpcountNewVisits: TLargeintField;
    QryEmpcountcontacts: TLargeintField;
    QryEmpcountFirstDemo: TLargeintField;
    QryEmpcountSecondDemos: TLargeintField;
    QryEmpcountQuotes: TLargeintField;
    QryEmpcountSalesorders: TLargeintField;
    QryEmpcountSales: TLargeintField;
    QryEmpcountcNewVisits: TWideStringField;
    QryEmpcountccontacts: TWideStringField;
    QryEmpcountcFirstDemos: TWideStringField;
    QryEmpcountcSecondDemos: TWideStringField;
    QryEmpcountcQuotes: TWideStringField;
    QryEmpcountcSalesOrders: TWideStringField;
    QryEmpcountcSales: TWideStringField;
    QryEmpcounTSalesAnalysisManualCtr: TLargeintField;
    pnlEmpcountgraph: TDNMPanel;
    Image2: TImage;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    splmain: TSplitter;
    splempcount: TSplitter;
    pnlWarning: TPanel;
    Shader1: TShader;
    Label1: TLabel;
    optOptions: TRadioGroup;
    pnllGraph: TDNMPanel;
    Image1: TImage;
    edtNewvisits: TDBText;
    edtcontacts: TDBText;
    edtFirstDemo: TDBText;
    edtSecondDemo: TDBText;
    edtQuotes: TDBText;
    edtSalesorder: TDBText;
    edtSales: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cmdPrint: TDNMSpeedButton;
    QryEmpcountColdCalls: TLargeintField;
    QryEmpcountcColdCalls: TStringField;
    btnContacts: TDNMSpeedButton;
    Label5: TLabel;
    procedure btnRequeryClick(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure edtNewvisitsDblClick(Sender: TObject);
    procedure edtcontactsDblClick(Sender: TObject);
    procedure edtFirstDemoDblClick(Sender: TObject);
    procedure edtSecondDemoDblClick(Sender: TObject);
    procedure edtQuotesDblClick(Sender: TObject);
    procedure edtSalesorderDblClick(Sender: TObject);
    procedure edtSalesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkHideInactiveSourceClick(Sender: TObject);
    procedure chkhideinactiveactiontypeClick(Sender: TObject);
    procedure chkactiontypesClick(Sender: TObject);
    procedure chksourceClick(Sender: TObject);
    procedure grdSoruceDblClick(Sender: TObject);
    procedure grdActionTypeDblClick(Sender: TObject);
    procedure grdSoruceExit(Sender: TObject);
    procedure grdActionTypeExit(Sender: TObject);
    procedure QryEmpcountCalcFields(DataSet: TDataSet);
    procedure QryEmpcountAfterOpen(DataSet: TDataSet);
    procedure optOptionsClick(Sender: TObject);
    procedure opensalesAnalysisManualdata(Sender: TObject);
    procedure btnContactsClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    NewVisitIds:String;
    LeadIds:String;
    firstDemosIDs  :String;
    SecondDemosIDs :String;
    QuotesIDs      :String;
    SOsIDs         :String;
    SalesIDs       :String;
    Tablename :String;
    function getFilterDateFrom: TDateTime; virtual;
    function getFilterdateto: TDateTime; virtual;
    Procedure RefreshQuery;
    Procedure ReadExtraGuipref;
    Procedure WriteExtraGuiPref;
    function SourceIDs: String;
    function ActionIDs: String;
    Procedure MakeQuery;
    function Datefilter(Fieldname:String): String;
    function employeeID:Integer;
    procedure openQueries;
    procedure BeforeShowColdCalls(Sender: TObject);
    procedure BeforeshowContactList(Sender: TObject);
    procedure BeforeshowFirstDemo(Sender: TObject);
    procedure BeforeshowsecondDemo(Sender: TObject);
    procedure BeforeshowQuoteList(Sender: TObject);
    procedure BeforeshowSOList(Sender: TObject);
    procedure BeforeshowSalesList(Sender: TObject);
    Procedure MakeContactTable(fSQL:String);
    procedure SalesAnalysisManualBeforeshow(Sender: TObject);
    procedure InitEmployeeList(Sender : TObject);
    Procedure UpdateFromEmpList(Sender: TwwDbGrid);
  Protected
    SelectedEmployees : string;
    oldMultiSelect : boolean;
    oldId : integer;
    empAfterOpen : TDataSetNotifyEvent;
    empOnActivate : TNotifyEvent;
    empListForm : TfrmEmployeeList;
    procedure EmployeeListAfterOpen(DataSet: TDataSet);
    procedure EmployeeListActivate(Sender : TObject);
  public
    Procedure UpdateMe(Const Cancelled: Boolean;Const aObject: TObject = Nil); Override;
  end;

implementation

uses Dateutils, CommonLib, tcConst, CommonDbLib, MySQLConst,
  CommonFormLib, SalesAnalysisGraphDrilldown, frmSimpleTypes,
  SalesAnalysisManual, AppEnvironment;

{$R *.dfm}

function TfmsalesAnalysisGraph.ActionIDs: String;
begin
  //if chksource.Checked  then grdActionType.SelectAll;
  result:= SelectedIDs(grdActionType , 'Id',true);
  if result = '' then result := '-1';
end;

procedure TfmsalesAnalysisGraph.btnContactsClick(Sender: TObject);
begin
  // Note: Multiselect we do here, not using Open..MultiSelect
  OpenERPListFormSingleselectModal('TfrmEmployeeList', UpdateFromEmpList, InitEmployeeList );
end;

procedure TfmsalesAnalysisGraph.btnRequeryClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmsalesAnalysisGraph.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  oldId := EmployeeId;
end;

procedure TfmsalesAnalysisGraph.chkactiontypesClick(Sender: TObject);
begin
  inherited;
  if chkactiontypes.checked then
    with grdActionType do begin
      UnselectAll;
      SelectAll;
    end;
end;
procedure TfmsalesAnalysisGraph.chksourceClick(Sender: TObject);
begin
  inherited;
  if chksource.checked then
    With grdSoruce do begin
      UnselectAll;
      SelectAll;
    end;
end;
procedure TfmsalesAnalysisGraph.chkhideinactiveactiontypeClick(Sender: TObject);
begin
  inherited;
  grdActiontype.UnselectAll;
  qryActiontype.filtered :=  chkHideInactiveSource.checked;
  if chkactiontypes.checked then grdActiontype.SelectAll;
end;

procedure TfmsalesAnalysisGraph.chkHideInactiveSourceClick(Sender: TObject);
begin
  inherited;
  grdSoruce.UnselectAll;
  qrySoruce.filtered :=  chkHideInactiveSource.checked;
  if chksource.checked then grdSoruce.SelectAll;
end;

procedure TfmsalesAnalysisGraph.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmsalesAnalysisGraph.dtFromCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmsalesAnalysisGraph.dtToCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmsalesAnalysisGraph.BeforeShowColdCalls(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= NewVisitIds;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Cold Calls';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Cold Calls';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;

procedure TfmsalesAnalysisGraph.BeforeshowContactList(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= Leadids;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Contacts';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Contacts';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;

procedure TfmsalesAnalysisGraph.BeforeshowFirstDemo(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= firstDemosIDs;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'First Demo List';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'First Demo List';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;
procedure TfmsalesAnalysisGraph.BeforeshowsecondDemo(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= SecondDemosIDs;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Second Demo List';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Second Demo List';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;
procedure TfmsalesAnalysisGraph.BeforeshowQuoteList(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= QuotesIDs;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Quote List';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Quote List';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;
procedure TfmsalesAnalysisGraph.BeforeshowSOList(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= SOsIDs;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Sales Order List';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Sales Order List';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;
procedure TfmsalesAnalysisGraph.BeforeshowSalesList(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisGraphDrilldownGUI) then exit;
  TSalesAnalysisGraphDrilldownGUI(Sender).IdsTofilter:= SalesIDs;
  TSalesAnalysisGraphDrilldownGUI(Sender).Caption := 'Invoice List';
  TSalesAnalysisGraphDrilldownGUI(Sender).TitleLabel.Caption := 'Invoice List';
  TSalesAnalysisGraphDrilldownGUI(Sender).contactTablename := Tablename;
end;

procedure TfmsalesAnalysisGraph.edtNewvisitsDblClick  (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownColdCallsGUI' ,nil, BeforeShowColdCalls);end;
procedure TfmsalesAnalysisGraph.edtcontactsDblClick   (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownColdCallsGUI' ,nil, BeforeshowContactList);end;
procedure TfmsalesAnalysisGraph.edtFirstDemoDblClick  (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownapptsGUI' ,nil, BeforeshowFirstDemo);end;
procedure TfmsalesAnalysisGraph.edtSecondDemoDblClick (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownapptsGUI' ,nil, BeforeshowSecondDemo);end;
procedure TfmsalesAnalysisGraph.edtQuotesDblClick     (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownSalesGUI' ,nil, BeforeshowQuoteList);end;
procedure TfmsalesAnalysisGraph.edtSalesorderDblClick (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownSalesGUI' ,nil, BeforeshowSOList);end;
procedure TfmsalesAnalysisGraph.edtSalesDblClick      (Sender: TObject);begin  OpenERPListFormModal('TSalesAnalysisGraphDrilldownSalesGUI' ,nil, BeforeshowSalesList);end;


procedure TfmsalesAnalysisGraph.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  WriteExtraGuiPref;
  Action := caFree;
end;
procedure TfmsalesAnalysisGraph.FormCreate(Sender: TObject);
begin
  inherited;
  Tablename := commondblib.GetUserTemporaryTableName('salesanalysisgraph');
//  dtFrom.date:= incMonth(date,-1);
//  dtTo.date:= date;
  dtFrom.Date := Date - AppEnv.Employee.ListDaysPast;
  dtTo.Date := Date + AppEnv.Employee.ListDaysFuture;

end;

procedure TfmsalesAnalysisGraph.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TfmsalesAnalysisGraph.openQueries;
var
  iIndex: integer;
begin
  iIndex        := 0;
  try
      try
        ProcessingCursor;
        while iIndex < Self.ComponentCount do begin
          if Self.Components[iIndex] is TCustomMyDataSet then begin
            with Self.Components[iIndex] as TCustomMyDataSet do begin
              connection := MyConnection;
              Open;
            end;
          end;
          Inc(iIndex);
        end;
      finally
        ProcessingCursor(False);
      end;
  Except
      on E:Exception do begin
        raise Exception.Create('Error:' +self.Classname +'.OpenQueries->' +
          uppercase(Self.Components[iIndex].Name) + '  Message: ' + E.message);
      end;
  end;

end;
procedure TfmsalesAnalysisGraph.opensalesAnalysisManualdata(Sender: TObject);
begin
  inherited;
  openERPListform('TSalesAnalysisManualGUI' ,SalesAnalysisManualBeforeshow);
end;
procedure TfmsalesAnalysisGraph.SalesAnalysisManualBeforeshow(Sender: TObject);
begin
  if not(Sender is TSalesAnalysisManualGUI) then exit;
  TSalesAnalysisManualGUI(Sender).dtFrom.date := 0;
  TSalesAnalysisManualGUI(Sender).DtTo.date := getfilterDateTo;
  TSalesAnalysisManualGUI(Sender).dtFrom.date := getfilterDateFrom;
  TSalesAnalysisManualGUI(Sender).fbDateRangeSupplied  := True;
end;
procedure TfmsalesAnalysisGraph.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.Active := True;

  openQueries;
  try
    ReadExtraGuipref;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;

  try
    RefreshQuery;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

function TfmsalesAnalysisGraph.getFilterDateFrom: TDateTime;
begin
  Result := dateof(dtFrom.DateTime);
end;

function TfmsalesAnalysisGraph.getFilterdateto: TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
end;

procedure TfmsalesAnalysisGraph.grdActionTypeDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit('LeadActiontype' , qryActionTypeName.asString, Self);
end;

procedure TfmsalesAnalysisGraph.grdActionTypeExit(Sender: TObject);
begin
  inherited;
  chkactiontypes.checked :=qryactiontype.RecordCount = grdactiontype.SelectedList.Count;
end;

procedure TfmsalesAnalysisGraph.grdSoruceDblClick(Sender: TObject);
begin
  inherited;
  if qrySoruceMedtypeID.AsInteger <> 0 then
    if OpenERPFormModal('TfrmSource' ,qrySoruceMedtypeID.AsInteger ) >=0  then begin
      qrySoruce.Refresh;
    end;
end;

procedure TfmsalesAnalysisGraph.grdSoruceExit(Sender: TObject);
begin
  inherited;
  chksource.checked :=qrySoruce.RecordCount = grdSoruce.SelectedList.Count;
end;


procedure TfmsalesAnalysisGraph.InitEmployeeList(Sender: TObject);
begin
  if not(Sender is TfrmEmployeeList) then exit;
  empListForm := Sender as TfrmEmployeeList;
  empListForm.SearchMode := smFullList;

  empListForm.CloseOnRecSelect := true;
  oldMultiSelect := dgMultiSelect in empListForm.grdMain.Options;
  // To Refresh list - so that selected are visible
  empOnACtivate := empListForm.OnActivate;
  empListForm.OnActivate := EmployeeListActivate;
  // To set selected employees
  empAfterOpen := empListForm.qryMain.AfterOpen;
  empListForm.qryMain.AfterOpen := EmployeeListAfterOpen;
  empListForm.grdMain.Options := empListForm.grdMain.Options + [dgMultiSelect];
end;

procedure TfmsalesAnalysisGraph.MakeContactTable(fSQL: String);
begin
  with TempMyScript do try
    SQL.Add('drop table if exists ' +tablename +';');
    SQL.Add('create table ' +Tablename +'  ' + fSQL);
    Execute;
  finally
    Free;
  end;
end;

procedure TfmsalesAnalysisGraph.MakeQuery;
var
  fiNewVisits : Integer;
  fiContacts:Integer;
  fiLeads:Integer;
  fifirstDemos:Integer;
  fiSecondDemos:Integer;
  fiQuotes:Integer;
  fiSOs:Integer;
  fiSales:Integer;

  contactIDs:String;
  fssourceIDs:String;
  fsActionIDs:String;
  fiEmployeeID:Integer;

  contactSQL :String;
  Qry:TERPQuery;
begin
  fiNewVisits   := 0;
  fiContacts    := 0;
  fiLeads       := 0;
  fifirstDemos  := 0;
  fiSecondDemos := 0;
  fiQuotes      := 0;
  fiSOs         := 0;
  fiSales       := 0;
  NewVisitIds   := '';
  LeadIds       := '';
  firstDemosIDs := '';
  SecondDemosIDs:= '';
  QuotesIDs     := '';
  SOsIDs        := '';
  SalesIDs      := '';

  fssourceIDs:= sourceIds;
  fsActionIDs:= ActionIDs;
//  fiEmployeeID := EmployeeID;
  if SelectedEmployees = '' then
    fiEmployeeID := EmployeeID
  else
    fiEmployeeID := 0;





  contactSQL:= 'select MC.Id, MC.ClientID , MLL.Leadid,MLL.employeeId, MLL.EmployeeName, ' +
                ' min(MLL.ActionDate) firstfollowupdate , ' +
                ' min(if(MLL.IsLead="T" , MLL.actiondate , 0)) firstLeadDate ,  ' +
                ' MC.source , S.MedTypeID as sourceId, MLL.Actiontype FollowupAction  ' +
                ' from tblmarketingleadlines MLL ' +
                ' inner join tblmarketingleads ML on ML.LeadID = MLL.LeadID ' +
                ' inner join tblmarketingcontacts Mc on ML.MarketingContactID = MC.ID ' +
                ' Left join tblsource S on MC.source = S.MediaType ' +
                ' where ifnull(actiondate,0)<> 0 ' +
                ' group by Leadid ' +
                ' order by followupdate';

  DoShowProgressbar(10 , WaitMSG);
  try


    Qry:=TempMyQuery;
    try
        with Qry do begin
            try
          {====================1--Google New visits====================}
              DoStepProgressbar('New Visits');
              if active then close;
              SQL.Clear;
              SQL.Add('select Cast(sum(ifnull(vtblTGaDataSum.NewVisits,0)) as Signed)   NewVisits '+
                      ' from vtblTGaDataSum ' +
                      ' where ' +DateFilter('vtblTGaDataSum.Date'));
              open;
              fiNewVisits := Fieldbyname('NewVisits').AsInteger;


          {====================2--first Telemarketing records created within the perios====================}
              DoStepProgressbar('Contacts');
              if active then close;
              SQL.Clear;
              SQL.Add('Select * from ( ' + contactSQL +') contacts where ' +datefilter('ifnull(firstfollowupdate,0) ') );
              (*
              if  fiEmployeeID <> 0  then SQL.Add(' and EmployeeID = ' + inttostr(fiEmployeeID));
              *)
              if  fiEmployeeID <> 0  then
                SQL.Add(' and EmployeeID = ' + inttostr(fiEmployeeID))
              else if SelectedEmployees <> '' then
                SQL.Add(' AND EmployeeId in (' + SelectedEmployees + ')');

              if  fssourceIDs  <> '' then SQL.Add(' and sourceId in (' + fsSourceIDs+')' );
              if  fsActionIds  <> '' then SQL.Add(' and FollowupAction in (' +fsActionIDs+')');
              open;
              MakecontactTable(SQL.Text);
              fiContacts := recordcount;
              contactIDs:= GroupConcat('ID');
                  {IDs for the drill down report}
                  NewVisitIds:=GroupConcat('ID');
          {====================3-- Leads====================}
              DoStepProgressbar('Leads');
              filter := 'firstLeadDate <> null and ' +' firstLeadDate <>0';
              //filter := 'not(isnull(firstLeadDate))  and firstLeadDate <>0';
              filtered := true;
              fiLeads := recordcount;
              {IDs for the drill down report}
                  LeadIds:= GroupConcat('ID');

              filter := '';
              filtered := False;

              if contactIDs = '' then begin
              end else begin
          {====================4-- first Demo====================}
                DoStepProgressbar('First Demo');
                if active then close;
                SQL.Clear;
                SQL.Add('Select count(*) ctr from ( ' +
                          ' Select A.cusId, Min(A.AppDate) FirstAppdate ' +
                          ' from tblmarketingcontacts MC ' +
                          ' inner join tblclients C on C.ClientID = MC.ClientID and (C.OtherContact="T" or C.Customer="T") ' +
                          ' inner join tblappointments A on C.ClientID = A.CusID ' +
                          ' where MC.Id in (' + contactIDs +') ' +
                          ' group by A.CusID ' +
                          ' having   ' + DateFilter('FirstAppdate')+
                          ' ) appts');
                Open;
                fifirstDemos :=  fieldByname('ctr').AsInteger;
                      {IDs for the drill down report}
                      if active then close;
                      SQL.Clear;
                      SQL.Add('Select AppointID  from ( ' +
                                ' Select A.cusId, Min(A.AppDate) FirstAppdate, A.AppointID ' +
                                ' from tblmarketingcontacts MC ' +
                                ' inner join tblclients C on C.ClientID = MC.ClientID and (C.OtherContact="T" or C.Customer="T") ' +
                                ' inner join tblappointments A on C.ClientID = A.CusID ' +
                                ' where MC.Id in (' + contactIDs +') ' +
                                ' group by A.CusID ' +
                                ' having   ' + DateFilter('FirstAppdate')+
                                ' ) appts');
                      open;
                      firstDemosIDs:= GroupConcat('AppointID');


          {====================5-- Second Demo====================}
                DoStepProgressbar('Second Demo');
                if Active then close;
                SQL.Clear;
                SQL.Add('Select count(*) ctr from ( ' +
                          ' Select A.cusId, sum( if(' +datefilter('AppDate')+' , 1, 0)) Appts, if(' +datefilter('AppDate')+'  , AppDate, null) appdate ' +
                          ' from tblmarketingcontacts MC ' +
                          ' inner join tblclients C on C.ClientID = MC.ClientID and (C.OtherContact="T" or C.Customer="T") ' +
                          ' inner join tblappointments A on C.ClientID = A.CusID  ' +
                          ' where MC.Id in (' + contactIDs +') ' +
                          ' group by A.CusID ' +
                          ' having  ' +datefilter('Min(A.AppDate)')+'' +
                          ' and ' +datefilter('AppDate')+' ' +
                          ' and Appts>=2 ) appts');
                Open;
                fiSecondDemos :=  fieldByname('ctr').AsInteger;
                          {IDs for the drill down report}
                          if Active then close;
                          SQL.Clear;
                          SQL.Add('Select AppointID  from ( ' +
                                    ' Select A.cusId,'+
                                    ' sum( if(' +datefilter('AppDate')+' , 1, 0)) Appts, '+
                                    ' if(' +datefilter('AppDate')+'  , AppDate, null) appdate, ' +
                                    ' if(' +datefilter('AppDate')+'  , AppointID, null) AppointID ' +
                                    ' from tblmarketingcontacts MC ' +
                                    ' inner join tblclients C on C.ClientID = MC.ClientID and (C.OtherContact="T" or C.Customer="T") ' +
                                    ' inner join tblappointments A on C.ClientID = A.CusID  ' +
                                    ' where MC.Id in (' + contactIDs +') ' +
                                    ' group by A.CusID ' +
                                    ' having  ' +datefilter('Min(A.AppDate)')+'' +
                                    ' and ' +datefilter('AppDate')+' ' +
                                    ' and Appts>=2 ) appts');
                          Open;
                          SecondDemosIDs  := GroupConcat('AppointID');

          {====================6-- Quotes====================}
                DoStepProgressbar('Quotes');
                if Active then close;
                SQL.Clear;
                SQL.Add('Select count(distinct s.OriginalNo) ctr ' +
                          'from tblmarketingcontacts MC ' +
                          'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                          'inner join tblSales s on S.clientId = C.clientiD and S.isquote ="T" and ' + Datefilter('S.saleDate')+
                          ' where S.deleted ="F" and S.cancelled ="F" and  MC.Id in (' + contactIDs +') ' );
                Open;
                fiQuotes :=  fieldByname('ctr').AsInteger;

                            {IDs for the drill down report}
                            if Active then close;
                            SQL.Clear;
                            SQL.Add('Select distinct s.OriginalNo ' +
                                      'from tblmarketingcontacts MC ' +
                                      'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                                      'inner join tblSales s on S.clientId = C.clientiD and S.isquote ="T" and ' + Datefilter('S.saleDate')+
                                      ' where S.deleted ="F" and S.cancelled ="F" and  MC.Id in (' + contactIDs +') ' );
                            Open;
                            QuotesIDs:= groupconcat('OriginalNo', '' , false , ',' , '' , '' , True);

          {====================7-- Sales Orders====================}
                DoStepProgressbar('Sales Orders');
                if Active then close;
                SQL.Clear;
                SQL.Add('Select count(distinct s.OriginalNo) ctr ' +
                          'from tblmarketingcontacts MC ' +
                          'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                          'inner join tblSales s on S.clientId = C.clientiD and S.IsSalesOrder ="T" and ' + Datefilter('S.saleDate')+
                          ' where S.deleted ="F" and S.cancelled ="F" and  MC.Id in (' + contactIDs +') ' );
                Open;
                fiSOs :=  fieldByname('ctr').AsInteger;


                            {IDs for the drill down report}
                            if Active then close;
                            SQL.Clear;
                            SQL.Add('Select distinct s.OriginalNo ' +
                                      'from tblmarketingcontacts MC ' +
                                      'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                                      'inner join tblSales s on S.clientId = C.clientiD and S.IsSalesOrder ="T" and ' + Datefilter('S.saleDate')+
                                      ' where S.deleted ="F" and S.cancelled ="F" and MC.Id in (' + contactIDs +') ' );
                            Open;
                            SOsIDs:= groupconcat('OriginalNo', '' , false , ',' , '' , '' , True);

          {====================8-- Sales====================}
                DoStepProgressbar('Sales');
                if Active then close;
                SQL.Clear;
                SQL.Add('Select count(distinct s.OriginalNo) ctr ' +
                          'from tblmarketingcontacts MC ' +
                          'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                          'inner join tblSales s on S.clientId = C.clientiD and (S.ISInvoice ="T"  or S.IsCashSale="T") and ' + Datefilter('S.saleDate')+
                          ' where S.deleted ="F" and S.cancelled ="F" and MC.Id in (' + contactIDs +') ' );
                Open;
                fiSales :=  fieldByname('ctr').AsInteger;

                            {IDs for the drill down report}
                            if Active then close;
                            SQL.Clear;
                            SQL.Add('Select distinct s.OriginalNo ' +
                                      'from tblmarketingcontacts MC ' +
                                      'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
                                      'inner join tblSales s on S.clientId = C.clientiD and (S.ISInvoice ="T"  or S.IsCashSale="T") and ' + Datefilter('S.saleDate')+
                                      ' where S.deleted ="F" and S.cancelled ="F" and MC.Id in (' + contactIDs +') ' );
                            Open;
                            SalesIDs:= groupconcat('OriginalNo', '' , false , ',' , '' , '' , True);
          {==================== ====================}
              end;
            Except
              on E:Exception do begin
                MessageDlgXP_Vista('Report failed' +nl +nl+ E.Message, mtWarning, [mbOK], 0);
              end;
            end;
        end;
        finally
          Qry.closenFree;
        end;
  finally
    DoHideProgressbar;
  end;
  if NewVisitIds    = '' then NewVisitIds     := '-1';
  if LeadIds        = '' then LeadIds         := '-1';
  if firstDemosIDs  = '' then firstDemosIDs   := '-1';
  if SecondDemosIDs = '' then SecondDemosIDs  := '-1';
  if QuotesIDs      = '' then QuotesIDs       := '-1';
  if SOsIDs         = '' then SOsIDs          := '-1';
  if SalesIDs       = '' then SalesIDs        := '-1';

  closeDB(qrymain);
  Qrymain.SQL.Clear;
  (*Qrymain.SQL.Add('Select   ' +
      inttostr(fiNewvisits+fiContacts)    +' as  NewVisits,'+
      inttostr(fiLeads)       +' as Contacts,'+
      inttostr(fifirstDemos)  +' as FirstDemo,'+
      inttostr(fiSecondDemos )+' as secondDemos ,' +
      inttostr(fiQuotes)      +' as Quotes ,'+
      inttostr(fiSOs)         +' as SalesOrders,'+
      inttostr(fiSales)       +' as Sales,'+
      Quotedstr('Cold Calls'    + NL+ inttostr(fiNewvisits+fiContacts)) +' as  cNewVisits,'+
      Quotedstr('Contacts'       + NL+ inttostr(fiLeads))                +' as cContacts,'+
      Quotedstr('First Demo'    + NL+ inttostr(fifirstDemos))           +' as cFirstDemo,'+
      Quotedstr('Second Demo'   + NL+ inttostr(fiSecondDemos ))         +' as csecondDemos ,' +
      Quotedstr('Quotes'        + NL+ inttostr(fiQuotes))               +' as cQuotes ,'+
//    Quotedstr('Sales Orders'  + NL+ inttostr(fiSOs))                  +' as cSalesOrders,'+
      Quotedstr('Sales'         + NL+ inttostr(fiSales))                +' as cSales' +
      ',Concat(''Sales Orders'#13',(sum(RLines.SalesOrders), '' ('', Round((Sum(RLines.Sales)/sum(RLines.SalesOrders)) * 100, 2), ''%)'') cSalesOrders');
*)
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add(inttostr(fiNewvisits+fiContacts)    +' as  NewVisits,');
  Qrymain.SQL.Add(inttostr(fiLeads)       +' as Contacts,');
  Qrymain.SQL.Add(inttostr(fifirstDemos)  +' as FirstDemo,');
  Qrymain.SQL.Add(inttostr(fiSecondDemos )+' as secondDemos ,');
  Qrymain.SQL.Add(inttostr(fiQuotes)      +' as Quotes ,');
  Qrymain.SQL.Add(inttostr(fiSOs)         +' as SalesOrders,');
  Qrymain.SQL.Add(inttostr(fiSales)       +' as Sales,');
  Qrymain.SQL.Add(Quotedstr('Cold Calls'    + NL+ inttostr(fiNewvisits+fiContacts)) +' as  cNewVisits,');
  Qrymain.SQL.Add(Quotedstr('Contacts'       + NL+ inttostr(fiLeads))                +' as cContacts,');
  Qrymain.SQL.Add(Quotedstr('First Demo'    + NL+ inttostr(fifirstDemos))           +' as cFirstDemo,');
  Qrymain.SQL.Add(Quotedstr('Second Demo'   + NL+ inttostr(fiSecondDemos ))         +' as csecondDemos ,');
  Qrymain.SQL.Add(Quotedstr('Quotes'        + NL+ inttostr(fiQuotes))               +' as cQuotes ,');
  Qrymain.SQL.Add(Quotedstr('Sales Orders'  + NL+ inttostr(fiSOs))                  +' as cSalesOrders,');
(*
  if fiSOs = 0 then
    QryMain.SQL.Add('''Sales Orders'#13'0 (100%)'' as cSalesOrders,' )
  else
    QryMain.SQL.Add(Format('''Sales Orders'''#13'%d (%3.2f%)'' as cSalesOrders,', [fiSOs, (fiSales/fiSos)* 100] ));
*)
  Qrymain.SQL.Add(Quotedstr('Sales'         + NL+ inttostr(fiSales))                +' as cSales');
//  Qrymain.SQL.Add('Concat(''Sales Orders'#13',(sum(RLines.SalesOrders), '' ('', Round((Sum(RLines.Sales)/sum(RLines.SalesOrders)) * 100, 2), ''%)'') cSalesOrders');
  openDB(Qrymain);

  closeDB(QryEmpcount);
  QryEmpcount.SQL.Clear;
  QryEmpcount.SQL.Add('select Count(R.Id) ReportingCtr,' );
//  QryEmpcount.SQL.Add('Convert(Sum(R.Googlevisitcount) + Sum(RLines.NewVisits) , unsigned) NewVisits,   ' );
  QryEmpcount.SQL.Add('Convert(Sum(R.Googlevisitcount) , unsigned) NewVisits,   ' );
  QryEmpcount.SQL.Add('Convert(Sum(RLines.ColdCalls) , unsigned) ColdCalls,   ' );
  QryEmpcount.SQL.Add('Convert(sum(RLines.Contact) , unsigned) Contacts,  ' );
  QryEmpcount.SQL.Add('Convert(Sum(RLines.FirstDemo) , unsigned) FirstDemo ,  ' );
  QryEmpcount.SQL.Add('Convert(Sum(RLines.SecondDemo) , unsigned) SecondDemos,  ' );
  QryEmpcount.SQL.Add('Convert(Sum(RLines.Quotes) , unsigned) Quotes ,  ' );
  QryEmpcount.SQL.Add('Convert(sum(RLines.SalesOrders) , unsigned) SalesOrders,  ' );
  QryEmpcount.SQL.Add('Convert(Sum(RLines.Sales) , unsigned) Sales ' );
  QryEmpcount.SQL.Add('from tblSalesAnalysisManual R ' );
  QryEmpcount.SQL.Add('Left join ( ' );
            QryEmpcount.SQL.Add('Select RL.SalesAnalysisID ,  ' );
            QryEmpcount.SQL.Add('Sum(RL.ColdCalls) ColdCalls,  ' );
            QryEmpcount.SQL.Add('sum(RL.Contact) Contact,  ' );
            QryEmpcount.SQL.Add('Sum(RL.FirstDemo) FirstDemo ,  ' );
            QryEmpcount.SQL.Add('Sum(RL.SecondDemo) SecondDemo,  ' );
            QryEmpcount.SQL.Add('Sum(RL.Quotes) Quotes ,  ' );
            QryEmpcount.SQL.Add('sum(RL.SalesOrders) SalesOrders,  ' );
            QryEmpcount.SQL.Add('Sum(RL.Sales) Sales  ' );
            QryEmpcount.SQL.Add('from tblSalesAnalysisManualLines RL   ' );
//            if employeeID <> 0 then QryEmpcount.SQL.Add('Where RL.employeeId = ' + inttostr(EmployeeID));
            if  fiEmployeeID <> 0  then
              QryEmpcount.SQL.Add(' where RL.EmployeeId=' + inttostr(fiEmployeeID))
            else if SelectedEmployees <> '' then
              QryEmpcount.SQL.Add(' where RL.EmployeeId in (' + SelectedEmployees + ')');
            QryEmpcount.SQL.Add('group by RL.SalesAnalysisID) as RLines on RLines.SalesAnalysisID = R.ID ' );
  QryEmpcount.SQL.Add(' Where R.DateFrom between ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat ,getFilterDateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat , getFilterDateTo)) +
                      ' and R.DateTo between ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat ,getFilterDateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat , getFilterDateTo)) );
  openDB(QryEmpcount);
end;

procedure TfmsalesAnalysisGraph.QryEmpcountAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pnlWarning.Visible :=(QryEmpcount.RecordCount =0) or (QryEmpcounTSalesAnalysisManualCtr.asInteger =0);
end;

procedure TfmsalesAnalysisGraph.QryEmpcountCalcFields(DataSet: TDataSet);
var
  fiSales : integer;

  function FormatLine(const aName : string; aSales : integer; aValue : integer) : string;
  var
    lStr : string;
    lPos : integer;
  begin
    if aValue = 0 then
    begin
      if aSales = 0 then
        Result  := aName + #13'0 (0%)'
      else
        Result  := aName + #13'0 (100%)'
    end
    else
    begin
      lStr := trim(Format('%3.2f', [(aSales/aValue)* 100])) + '%';
      lPos := pos('.00%', lStr);
      if lPos > 0 then
        lStr := Copy(lStr, 1, lPos-1) + '%';
      Result  := Format('%s'#13'%d (%s)', [aName, aValue, lStr] );
    end;
  end;
begin
  inherited;
  fiSales := QryEmpcountSales.AsInteger;
  // QryEmpcountcNewVisits.AsString    := 'New Visits'   +NL+ inttoStr(QryEmpcountNewVisits.AsInteger);
  QryEmpcountcNewVisits.AsString    := FormatLine('New Visits', fiSales, QryEmpcountNewVisits.AsInteger);
//    QryEmpcountcColdCalls.AsString    := 'Cold Calls'   +NL+ inttoStr(QryEmpcountColdCalls.AsInteger);
  QryEmpcountcColdCalls.AsString    := FormatLine('Cold Calls', fiSales, QryEmpcountColdCalls.AsInteger);
//    QryEmpcountccontacts.AsString     := 'Contacts'     +NL+ inttoStr(QryEmpcountContacts.AsInteger);
  QryEmpcountccontacts.AsString     := FormatLine('Contacts', fiSales, QryEmpcountContacts.AsInteger);
//    QryEmpcountcFirstDemos.AsString   := 'First Demo'   +NL+ inttoStr(QryEmpcountFirstDEmo.AsInteger);
  QryEmpcountcFirstDemos.AsString   := FormatLine('First Demo', fiSales, QryEmpcountFirstDEmo.AsInteger);
//    QryEmpcountcSecondDemos.AsString  := 'Second Demo'  +NL+ inttoStr(QryEmpcountSecondDemos.AsInteger);
  QryEmpcountcSecondDemos.AsString  := FormatLine('Second Demo', fiSales, QryEmpcountSecondDemos.AsInteger);
//    QryEmpcountcQuotes.AsString       := 'Quotes'       +NL+ inttoStr(QryEmpcountQuotes.AsInteger);
  QryEmpcountcQuotes.AsString       := FormatLine('Quotes', fiSales, QryEmpcountQuotes.AsInteger);
//    QryEmpcountcSalesOrders.AsString  := 'Sales Orders' +NL+ inttoStr(QryEmpcountSalesOrders.AsInteger);
  QryEmpcountcSalesOrders.AsString  := FormatLine('Sales Orders', fiSales, QryEmpcountSalesOrders.AsInteger);
  QryEmpcountcSales.AsString        := 'Sales'        +NL+ inttoStr(QryEmpcountSales.AsInteger);
end;
procedure TfmsalesAnalysisGraph.optOptionsClick(Sender: TObject);
begin
  inherited;
  pnlEmpcountgraph.Align:= alRight;
  if optoptions.ItemIndex = 0 then begin
    pnlFilter.Visible:= TRue;
    pnllGraph.Visible:= TRue;
    pnlEmpcountgraph.Visible:= TRue;
    pnlFilter.Width := 451;
    pnlEmpcountgraph.width := trunc((Self.ClientWidth -pnlFilter.Width)/2);
  end else if optoptions.ItemIndex = 1 then begin
    pnlFilter.Visible:= False;
    pnllGraph.Visible:= TRue;
    pnlEmpcountgraph.Visible:= TRue;
    pnlFilter.Width := 0;
    pnlEmpcountgraph.width := trunc((Self.ClientWidth -pnlFilter.Width)/2);
  end else if optoptions.ItemIndex = 2 then begin
    pnlFilter.Visible:= True;
    pnllGraph.Visible:= False;
    pnlEmpcountgraph.Visible:= TRue;
    pnlFilter.Width := 451;
    //pnlEmpcountgraph.width := Self.ClientWidth -pnlFilter.Width;
    pnlEmpcountgraph.Align:= alclient;
  end else if optoptions.ItemIndex = 3 then begin
    pnlFilter.Visible:= True;
    pnllGraph.Visible:= true;
    pnlEmpcountgraph.Visible:= False;
    pnlFilter.Width := 451;
    pnlEmpcountgraph.width := 0;
  end;
  splempcount.Visible := pnlEmpcountgraph.visible;
  splmain.Visible     := pnlFilter.visible;
end;

procedure TfmsalesAnalysisGraph.ReadExtraGuipref;
var
  st:TStringlist;
  ctr:Integer;
  Ids:String;
begin
  if GuiPrefs.Node.Exists('General') then begin
//    chkAllEmployees.Checked := GuiPrefs.Node['General.Allemployees'].AsBoolean;
    chksource.Checked       := GuiPrefs.Node['General.Allsources'].AsBoolean;
    chkactiontypes.Checked  := GuiPrefs.Node['General.AllActionTypes'].AsBoolean;
    chkHideInactiveSource.Checked     := GuiPrefs.Node['General.HideInactivesource'].AsBoolean;
    chkhideinactiveactiontype.Checked := GuiPrefs.Node['General.HideInactiveActiontype'].AsBoolean;

    ctr:=GuiPrefs.Node['General.PnlOption'].asInteger;
    if ctr<>0 then     optOptions.ItemIndex := ctr else optOptions.ItemIndex:= 0;

    ctr:=GuiPrefs.Node['General.EmpcountPanel.width'].asInteger;
    if ctr<>0 then     pnlEmpcountgraph.Width := ctr;

    ctr:=GuiPrefs.Node['General.mainpanel.width'].asInteger;
    if ctr<>0 then     pnllGraph.Width := ctr;

    ctr:=GuiPrefs.Node['General.filterPanel.width'].asInteger;
    if ctr<>0 then     pnlFilter.Width := ctr;

    if GuiPrefs.Node['General.EmployeeID'].AsInteger <> 0 then begin
      opendb(qryEmployees);
      if qryEmployees.Locate('employeeId' , GuiPrefs.Node['General.EmployeeID'].AsInteger , []) then
        cboEmployee.Text :=qryEmployees.FieldByName('employeeName').AsString;
    end;
//    dtFrom.Date :=GuiPrefs.Node['General.DateFrom'].AsDateTime;
//    dtTo.Date := GuiPrefs.Node['General.Dateto'].AsDateTime;
    st:= tstringlist.Create;
    try
      Ids:= GuiPrefs.Node['General.sources'].AsString;
      if Ids<>'' then begin
        st.CommaText:= Ids;
        for ctr := 0 to st.Count-1 do begin
          if qrySoruce.Locate('MedtypeID' , strtoint(st[ctr]) , []) then
            grdSoruce.SelectRecord;
        end;
        st.clear;
      end;

      Ids:= GuiPrefs.Node['General.Actiontypes'].AsString;
      if Ids<>'' then begin
        st.CommaText:= Ids;
        for ctr := 0 to st.Count-1 do begin
          if qryActionType.Locate('id' , strtoint(st[ctr]) , []) then
            grdActionType.SelectRecord;
        end;
      end;
    finally
      Freeandnil(st);
    end;
  end else begin
    dtFrom.date:= incMonth(date,-1);
    dtTo.date:= date;
  end;
end;


procedure TfmsalesAnalysisGraph.RefreshQuery;
begin
  MakeQuery;
end;

function TfmsalesAnalysisGraph.SourceIDs: String;
begin
  //if chksource.Checked  then grdSoruce.SelectAll;
  result:= SelectedIDs(grdSoruce , 'MedtypeID',true);
  if result = '' then result := '-1';
end;

procedure TfmsalesAnalysisGraph.UpdateFromEmpList(Sender: TwwDbGrid);
begin
  SelectedEmployees:= SelectedIDs(Sender , 'EmployeeId', true);

  if pos(',', SelectedEmployees) = 0 then
  begin
    // selected one employee - so no need to use the list
    oldId := StrToInt(SelectedEmployees);
    SelectedEmployees := '';
  end;

  if SelectedEmployees <> '' then
  begin
    if qryEmployees.Locate('EmployeeId', 0, []) then
      cboEmployee.Text := qryEmployees.FieldByName('EmployeeName').asString
  end
  else
  begin
    if qryEmployees.Locate('EmployeeId', oldId, []) then
      cboEmployee.Text := qryEmployees.FieldByName('EmployeeName').asString;
  end;

  if not OldMultiSelect then
    Sender.Options := Sender.Options - [dgMultiSelect];

  empListForm.OnActivate := empOnACtivate;
  empListForm.qryMain.AfterOpen := empAfterOpen;
  empListForm := nil;

  RefreshQuery;
end;

procedure TfmsalesAnalysisGraph.UpdateMe(const Cancelled: Boolean;  const aObject: TObject);
begin
  inherited;
  If Cancelled Then Begin
  End Else Begin
    qryActionType.Refresh;
  End;
end;

procedure TfmsalesAnalysisGraph.WriteExtraGuiPref;
begin
//  GuiPrefs.Node['General.Allemployees'].AsBoolean   := chkAllEmployees.Checked;
  GuiPrefs.Node['General.EmployeeID'].AsInteger     := qryEmployees.FieldByName('EmployeeID').AsInteger;
  GuiPrefs.Node['General.Allsources'].AsBoolean     := chksource.Checked;
  GuiPrefs.Node['General.AllActionTypes'].AsBoolean := chkactiontypes.Checked;
  GuiPrefs.Node['General.DateFrom'].AsDateTime      := dtFrom.Date;
  GuiPrefs.Node['General.Dateto'].AsDateTime        := dtTo.Date;
  GuiPrefs.Node['General.sources'].AsString         := SourceIds;
  GuiPrefs.Node['General.Actiontypes'].AsString     := ActionIDs;
  GuiPrefs.Node['General.HideInactivesource'].AsBoolean     := chkHideInactiveSource.Checked;
  GuiPrefs.Node['General.HideInactiveActiontype'].AsBoolean := chkhideinactiveactiontype.Checked;
  GuiPrefs.Node['General.EmpcountPanel.width'].asInteger    := pnlEmpcountgraph.Width;
  GuiPrefs.Node['General.mainpanel.width'].asInteger        := pnllGraph.Width;
  GuiPrefs.Node['General.filterPanel.width'].asInteger      := pnlFilter.Width;
  GuiPrefs.Node['General.PnlOption'].asInteger              := OptOptions.ItemIndex;
  GuiPrefs.SavePrefs;
end;

function TfmsalesAnalysisGraph.Datefilter(Fieldname:String):String;
begin
  result:=fieldname +' between ' +quotedstr(formatDateTime(MysqlDateTimeFormat , getFilterDateFrom)) +' and ' + quotedstr(formatDateTime(MysqlDateTimeFormat , getFilterDateto));
end;

function TfmsalesAnalysisGraph.employeeID: Integer;
begin
  result:= 0;
//  if chkAllEmployees.Checked then exit;
  if cboEmployee.Text = '' then exit;
  if not qryEmployees.Locate('EmployeeName' , cboEmployee.Text  , []) then exit;
  REsult := qryEmployees.FieldByName('EmployeeId').AsInteger;
end;

procedure TfmsalesAnalysisGraph.EmployeeListActivate(Sender: TObject);
begin
  if assigned(empOnActivate) then
    empOnActivate(Sender);
  empListForm.actRefreshQryExecute(self);
end;

procedure TfmsalesAnalysisGraph.EmployeeListAfterOpen(DataSet: TDataSet);
var
 qry : TERPQuery;
 lStr : string;
 lId : string;
 lPos : integer;
begin
  if assigned(empAfterOpen) then
    empAfterOpen(DataSet);

  if not assigned(empListForm) then
    exit;

  lStr := SelectedEmployees;
  if lStr = '' then
    if employeeId > 0 then
      lStr := IntToStr(employeeId)
    else
      exit;
  qry := empListForm.qryMain;

  while lStr <> '' do
  begin
    lPos := pos(',', lStr);
    if lPos > 0 then
    begin
      lId := copy(lStr, 1, lPos - 1);
      lStr := copy(lStr, lPos+1, length(lStr));
    end
    else
    begin
      lId := lStr;
      lStr := '';
    end;
    if qry.Locate('EmployeeId', StrToInt(lId), []) then
      empListForm.grdMain.SelectRecord;
  end;
end;

initialization
  RegisterClassOnce(TfmsalesAnalysisGraph);
end.

