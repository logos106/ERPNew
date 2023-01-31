unit frmReportSelectorFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/05/05  1.00.01 BJ   The form is movd from the main application to the
                        commonlib pakcage. The class function Instance is
                        raising an event to call the globalevents from The
                        main application as well as all the packages. The
                        event should be registered with the same set of params
                        from all the packages and all of them will be executed
                        in sequence.
                        The group is sorted in 'onformshow' before settting the
                        default group and report.
 30/5/05   1.00.02 BJ   Event raised for 'updatebatch' option. The procedure is
                        written in the main form which is being called thru the
                        event handler in datReports form.
 07/07/05  1.00.03 DMS  1. Formatted unit's source code.
 04/08/05  1.00.04 IJB  Modifies custom report select SQL to exclude records
                        when Report field is empty string (was just checking for
                        null). Changed Title Memo caption.
 23/08/05  1.00.05 IJB  Added Sort to memory table in form OnShow.
 12/09/05  1.00.06 IJB  Added code to delete custom reports from other groups
                        when user deletes from "My Reports" group.
 02/12/05  1.00.07 DSP  Added RegisterClass call.
 10/02/06  1.00.08  AL  Added THIS_FINANCIAL_YEAR_TO_DATE

}

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, DBGrids, DB, kbmMemTable, ExtCtrls,
  SelectionDialog, AppEvnts,  StdCtrls, Buttons, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, DNMPanel, Wwdbigrd, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, MyAccess,ERPdbComponents, DBAccess,
  DataState, Menus, AdvMenus, Shader, wwcheckbox, MemDS, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb,MessageConst, ImgList, ProgressDialog;



type
  TfrmReportSelectorGUI = class(TBaseInputGUI)
    mtReportItem: TkbmMemTable;
    dsReportItem: TDataSource;
    Panel1: TDNMPanel;
    Panel2: TDNMPanel;
    DNMPanel1: TDNMPanel;
    rgGroups: TwwRadioGroup;
    dbgReports: TwwDBGrid;
    btnDelete: TwwIButton;
    DNMPanel2: TDNMPanel;
    cboDateRange: TComboBox;
    lblFrom: TLabel;
    dtFrom: TDateTimePicker;
    lblTo: TLabel;
    dtTo: TDateTimePicker;
    Label1: TLabel;
    ChkBatchMode: TTimer;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnUpdateBatch: TDNMSpeedButton;
    DSCharts: TDataSource;
    grdGroupCharts: TwwDBGrid;
    qryDummy: TERPQuery;
    qryDummyChartName: TWideStringField;
    DNMPanel4: TDNMPanel;
    edtSearch2: TEdit;
    Label3: TLabel;
    DNMPanel5: TDNMPanel;
    Label2: TLabel;
    wwIButton1: TwwIButton;
    edtSearch: TEdit;
    cboSearch: TwwDBComboBox;
    btnSchedule: TDNMSpeedButton;
    QryEmailReports: TERPQuery;
    QryEmailReportsformID: TIntegerField;
    QryEmailReportsformname: TWideStringField;
    btnEmail: TDNMSpeedButton;
    btnEmailReport: TDNMSpeedButton;
    BevelEmail: TBevel;
    Bevelschedule: TBevel;
    procedure dbgReportsDblClick(Sender: TObject);
    procedure mtReportItemFilterRecord(DataSet: TDataSet; var Accept: boolean);
    procedure FormShow(Sender: TObject);
    procedure rgGroupsChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
    procedure cboDateRangeChange(Sender: TObject);
    procedure btnUpdateBatchClick(Sender: TObject);
    procedure ChkBatchModeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure dbgReportsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdGroupChartsDblClick(Sender: TObject);
    procedure edtSearch2Change(Sender: TObject);
    procedure wwIButton1Click(Sender: TObject);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure btnScheduleClick(Sender: TObject);
    procedure mtReportItemAfterScroll(DataSet: TDataSet);
    procedure btnEmailClick(Sender: TObject);
    procedure btnEmailReportClick(Sender: TObject);
  private
    { Private declarations }
    fChartClassList:TStringList;
    fFormOpened:Boolean;
    fChartQuery:TERPQuery;
    fsdefaultReport: string;
    fsdefaultGroup: string;
    EmpemailIDs:String;
    procedure LaunchSelectedReport;
    procedure AddCustomReports;
    procedure SortRadioGroup;
    procedure LoadChartGrid;
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = '');
    procedure PerformCustomChartDeleted(var Msg: TMessage); message SX_CustomChartDeleted;
    Function LaunchList(const sListClass: string; const iGuiID: integer):Tcomponent;
    Procedure DoExtraUpdates(ignoreifManuallyentered:Boolean);
    procedure setdefaultGroup(const Value: string);
    procedure setdefaultReport(const Value: string);
    procedure initreportName(Sender: TObject);
    procedure OnAfterEmailEvent(Sender: TObject);
    procedure InitEmployeeExpresslist(Sender: TObject);
    procedure selectEmailIds(Sender: TWWDBGrid);
    Procedure Readguiprefs;
    Procedure Writeguiprefs;
  Protected
    Procedure DoExtraTranslation;Override;
  public
    { Public declarations }
    Property defaultGroup: string read fsdefaultGroup write setdefaultGroup;
    Property defaultReport: string read fsdefaultReport write setdefaultReport;
    procedure Clear;
    procedure Add(const Group, Report: string; const OnClick: TNotifyEvent); overload;
    procedure Add(const Group, Report: string; const ClassName: string; const GuiID: integer; const ListName: string = ''); overload;

  end;

implementation

uses FastFuncs,DnMLib, BaseListingForm, BaseTreeView, CommonDbLib,  DateUtils,
  BaseClassFuncs, GlobalEventsObj,  CommonLib, AppEnvironment, tcConst,MessageInterface,
  ListChartView, AppContextObj, DebugLib, CommonFormLib, frmSchedulereports, EmployeeExpresslist, ScheduledreportObj,
  BOMCostnPriceLib, dmMainGUI, idGlobal, EmployeeAccesses, TypInfo, ERPErrorEmailUtils;

{$R *.dfm}




procedure TfrmReportSelectorGUI.PerformCustomChartDeleted(var Msg: TMessage);
begin      
  grdGroupCharts.DataSource.DataSet.Close;
  Self.MyConnection.Connected := False;
  Self.MyConnection.Connect;
  grdGroupCharts.DataSource.DataSet.Open;
  grdGroupCharts.Invalidate;
end;

procedure TfrmReportSelectorGUI.Readguiprefs;
var
  s:String;
  x:Integer;
begin
  if Guiprefs.active = False then Guiprefs.Active := True;
  x:= 0;
  s:= '';

  if devmode then begin
      if GuiPrefs.Node.Exists('ReportOptions.GoupIndex') then x := GuiPrefs.Node['ReportOptions.GoupIndex'].asInteger;
      if GuiPrefs.Node.Exists('ReportOptions.SelectedReportname') then  s := GuiPrefs.Node['ReportOptions.SelectedReportname'].asString;
      if (x = 0) or (s='') then exit;
      //else if MessageDlg('Do you wish to locate the last report' + s+'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      if rgGroups.Items.Count >= x then rgGroups.ItemIndex := x - 1;
      if mtReportItem.Locate('Report', s, [loCaseInsensitive]) then Setcontrolfocus(dbgReports);
  end;
  dtFrom.date :=  0;
  if GuiPrefs.Node.Exists('ReportOptions.dateTo')   then dtTo.date   :=  GuiPrefs.Node['ReportOptions.dateTo'].asDAtetime   else dtTo.Date   := Date + AppEnv.Employee.ListDaysFuture;
  if GuiPrefs.Node.Exists('ReportOptions.datefrom') then dtFrom.date :=  GuiPrefs.Node['ReportOptions.datefrom'].asDAtetime else dtFrom.Date := Date - AppEnv.Employee.ListDaysPast;
end;

{sorting the group in the group list }

procedure TfrmReportSelectorGUI.SortRadioGroup;
var
  iIndex, cIndex: integer;
  iData: string;
begin
  for iIndex := 0 to rgGroups.Items.Count - 1 do begin
    for cIndex := iIndex to rgGroups.Items.Count - 1 do begin
      if rgGroups.Items[iIndex] > rgGroups.Items[cIndex] then begin
        iData := rgGroups.Items[iIndex];
        rgGroups.Items[iIndex] := rgGroups.Items[cIndex];
        rgGroups.Items[cIndex] := iData;
      end;
    end;
  end;
end;

procedure TfrmReportSelectorGUI.Writeguiprefs;
begin
  GuiPrefs.Node['ReportOptions.SelectedReportname'].asString := mtReportItem.Fieldbyname('Report').AsString;
  GuiPrefs.Node['ReportOptions.GoupIndex'].asInteger :=rgGroups.ItemIndex +1;
end;

procedure TfrmReportSelectorGUI.Clear;
begin
 mtReportItem.Active:=false;
 mtReportItem.Active:=true;
end;

procedure TfrmReportSelectorGUI.Add(const Group, Report: string; const ClassName: string;
  const GuiID: integer; const ListName: string = '');
var
  sGroup, sreport:String;
begin
try
  // make sure that report group exists
  sgroup := DoTranslate(trim(Group));
  sReport := Dotranslate(Trim(Report));

  if rgGroups.Items.IndexOf(SGroup) < 0 then rgGroups.Items.Add(SGroup);
  //Log('TfrmReportSelectorGUI.Add Group: ' + Group +'    Report: ' + Report + ' ClassName: ' + ClassName, 'Debug');
  mtReportItem.Append;
  mtReportItem.FieldByName('Group').AsString := SGroup;
  mtReportItem.FieldByName('Report').AsString := SReport;
  mtReportItem.FieldByName('onClickPtr').AsInteger := 0;
  mtReportItem.FieldByName('ClassName').AsString := ClassName;
  mtReportItem.FieldByName('GuiID').AsInteger := GuiID;
  mtReportItem.FieldByName('ListName').AsString := ListName;
  opendb(QryEmailReports);
  mtReportItem.fieldbyname('Emailable').asBoolean := QryEmailReports.Locate('formname' ,mtReportItem.Fieldbyname('Classname').AsString , []);
  mtReportItem.Post;
Except
  // kill exception
end;
end;

procedure TfrmReportSelectorGUI.Add(const Group, Report: string; const OnClick: TNotifyEvent);
var
  sGroup, sreport:String;
begin
  // make sure that report group exists
  sgroup := DoTranslate(trim(Group));
  sReport := Dotranslate(Trim(Report));
  if rgGroups.Items.IndexOf(SGroup) < 0 then rgGroups.Items.Add(SGroup);

  mtReportItem.Append;
  mtReportItem.FieldByName('Group').AsString := SGroup;
  mtReportItem.FieldByName('Report').AsString := SReport;
  mtReportItem.FieldByName('onClickPtr').AsInteger := integer(@OnClick);
  mtReportItem.FieldByName('ClassName').AsString := '';
  mtReportItem.FieldByName('GuiID').AsInteger := 0;
  mtReportItem.FieldByName('ListName').AsString := '';
  mtReportItem.fieldbyname('Emailable').asBoolean := False;
  mtReportItem.Post;
end; //Add

procedure TfrmReportSelectorGUI.dbgReportsDblClick(Sender: TObject);
begin
  DisableForm;
  try
    LaunchSelectedReport;
  finally
    EnableForm;
  end;  
end;

procedure TfrmReportSelectorGUI.mtReportItemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnSchedule.Enabled := Appenv.CompanyPrefs.EnableScheduledreports and (mtReportItem.fieldbyname('Emailable').asBoolean or devmode) ;
  btnEmailReport.Enabled := mtReportItem.fieldbyname('Emailable').asBoolean;
  if btnEmailReport.enabled then
    BevelEmail.hint := 'Select to email the selected report ' + Quotedstr(mtReportItem.Fieldbyname('Report').AsString)
  else
    BevelEmail.hint := 'Email is disabled as the selected report ' + Quotedstr(mtReportItem.Fieldbyname('Report').AsString) +' is not E-mailable';

  if btnSchedule.enabled then
    Bevelschedule.hint := 'Select to Schedule the selected report ' + Quotedstr(mtReportItem.Fieldbyname('Report').AsString)
  else if Appenv.CompanyPrefs.EnableScheduledreports =False then
    Bevelschedule.hint := 'Schedule is disabled as you have turned OFF the ''Scheduled Reports '' in the preference'
  else
    Bevelschedule.hint := 'Schedule is disabled as the selected report ' + Quotedstr(mtReportItem.Fieldbyname('Report').AsString) +' is not Schedulable';

  BevelEmail.showhint       := True;    BevelSchedule.showhint := True;
  BevelEmail.parentshowhint := False;   BevelSchedule.parentshowhint := False;
end;

procedure TfrmReportSelectorGUI.mtReportItemFilterRecord(DataSet: TDataSet; var Accept: boolean);
begin
  inherited;
  Accept := rgGroups.Items[rgGroups.ItemIndex] = mtReportItem.FieldByName('Group').AsString;
end;

procedure TfrmReportSelectorGUI.FormShow(Sender: TObject);
var
  QueriesNotToOpen: array of string;
begin
  DisableForm;
  try
    inherited;
    Setlength(QueriesNotToOpen, 1);
    QueriesNotToOpen[0] := 'qryDummy';
    OpenQueries(QueriesNotToOpen);

    SortRadioGroup;
    rgGroups.ItemIndex := 0;
    mtReportItem.Filtered := false;


    mtReportItem.First;

    while not mtReportItem.Eof do begin
     cboSearch.Items.Add(mtReportItem.fieldByName('Report').AsString + ' | ' + mtReportItem.fieldByName('Group').AsString);
     mtReportItem.Next;
    end;
    mtReportItem.First;
    mtReportItem.SortDefault;
    If defaultGroup='' then defaultGroup := REPORT_GROUP_ACCOUNTS;

    if rgGroups.Items.IndexOf(defaultGroup) >= 0 then begin
      rgGroups.ItemIndex := rgGroups.Items.IndexOf(defaultGroup);
      mtReportItem.Filtered := true;
      mtReportItem.Locate('Report', defaultReport, [loCaseInsensitive]);
      rgGroups.ItemIndex := rgGroups.Items.IndexOf(defaultGroup);
    end;

    rgGroups.ItemIndex := rgGroups.Items.IndexOf(defaultGroup);

    if (rgGroups.ItemIndex < 0) then rgGroups.ItemIndex := 0;

    rgGroupsChange(nil);

    if not mtReportItem.Locate('Report', defaultReport, [loCaseInsensitive]) then begin
      mtReportItem.First;
      defaultReport := mtReportItem.FieldByName('Report').AsString;
    end;

    //dtFrom.Date := Date - AppEnv.Employee.ListDaysPast;
    //dtTo.Date := Date + AppEnv.Employee.ListDaysFuture;

    btnUpdateBatch.Enabled := not (IsBatchInProgress);

    DSCharts.DataSet := fChartQuery;
    fFormOpened := True;
    LoadChartGrid;
    SetControlFocus(cboSearch);
    btnEmail.Visible := Devmode;
    Readguiprefs;
  finally
    EnableForm;
  end;  
end;

procedure TfrmReportSelectorGUI.rgGroupsChange(Sender: TObject);
begin
  inherited;
  mtReportItem.Refresh;
  mtReportItem.First;
  btnDelete.Visible := Sysutils.SameText(Trim(rgGroups.Items[rgGroups.ItemIndex]),'My Reports');
  if not fFormOpened then begin
    exit;
  end;
  LoadChartGrid;
end;

procedure TfrmReportSelectorGUI.LoadChartGrid;
var
  i:integer;
begin
//  if mtReportItem.RecordCount > 250 then exit;
  mtReportItem.First;
  fChartClassList.Clear;
  while not mtReportItem.Eof do begin
    fChartClassList.Add(mtReportItem.fieldByName('ClassName').AsString);
    mtReportItem.Next;
  end;
  mtReportItem.First;
  fChartQuery.Close;
  fChartQuery.SQL.Clear;
  fChartQuery.SQL.Add('SELECT ID,ReportClassName,ChartName, candelete FROM tblcustomcharts WHERE (ReportClassName = ');
  If fChartClassList.Count>1 then begin
    for i := 0 to (fChartClassList.Count - 1) do begin
      fChartQuery.SQL.Add(QuotedStr(fChartClassList.Strings[i]) + ') or (ReportClassName = ');
      if i = (fChartClassList.Count - 2) then begin
        fChartQuery.SQL.Add(QuotedStr(fChartClassList.Strings[i + 1]) + ');');
        break;
      end;
    end;
  end else Begin
     fChartQuery.SQL.Add(QuotedStr(fChartClassList.Strings[0]) + ');');
  end;

  fChartQuery.Open;
  grdGroupCharts.ColumnByName('ChartName').DisplayLabel := 'All '+rgGroups.Items[rgGroups.ItemIndex] +' Charts';

end;

procedure TfrmReportSelectorGUI.btnOkClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Self.Enabled := False;
    Try
      LaunchSelectedReport;
    finally
      Self.Enabled := True;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmReportSelectorGUI.btnScheduleClick(Sender: TObject);
var
  EmailText:String;
begin
  inherited;
  if mtReportItem.fieldbyname('Emailable').asBoolean then begin
    OpenERPForm('TfmSchedulereports' , 0 , nil , initreportName);
  end else begin
    if MessageDlgXP_Vista(Quotedstr(mtReportItem.FieldByName('Report').AsString)  + ' is not configured to be scheduled.'+NL+
                          'Would you like to send a request to ERP to configure it?', mtConfirmation, [mbYes, mbNo], 0) = Mryes then begin
          EmailText:=
            'Company   : ' +AppEnv.CompanyInfo.Companyname +chr(13) +
            'User      : ' +appenv.Employee.EmployeeName +chr(13) +
            'Database  : ' + AppEnv.AppDb.Database +chr(13) +
            '================================================='+chr(13)+
            'Purpose  : ' + 'Report scheduling Request' + chr(13) +
            'Report Name   : ' + Quotedstr(mtReportItem.FieldByName('Report').AsString) + chr(13) +
            '=================================================';
          SendEmailtoErp('Report scheduling Request' ,emailtext);
          MessageDlgXP_Vista('An email is sent to ERP', mtInformation , [mbok],0);
    end;
  end;
end;
procedure TfrmReportSelectorGUI.initreportName(Sender: TObject);
begin
  if not(Sender is TfmSchedulereports ) then exit;
  TfmSchedulereports(Sender).ERPFormName :=mtReportItem.FieldByName('ClassName').AsString;
end;
procedure TfrmReportSelectorGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmReportSelectorGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPrefs;
  fChartClassList.Clear;
  FreeAndNil(fChartClassList);
  FreeAndNil(fChartQuery);
  Action := caFree;
end;

function  TfrmReportSelectorGUI.LaunchList(const sListClass: string; const iGuiID: integer):TComponent;
var
  c: TClass;
  frmList: TBaseListingGUI;
begin
  frmList:= nil;
  result := nil;
  try
    //Enforce One Instance Of List
    if FormStillOpen(sListClass,iGuiID) then begin
      with TForm(GetComponentByClassName(sListClass,True,nil,True,True,iGuiID)) do begin
          WindowState := wsNormal;
          BringToFront;
          Exit;
      end
    end;

    c := GetClass(sListClass);
    if Assigned(c) then begin
      if sListClass = 'TfrmSummarySheetGUI' then begin
          frmList :=GetBaseListingByClassName('TfrmSummarySheetGUI', true);
          if not assigned(frmList) then exit;
          with  frmList do begin
              FormStyle := fsMDIChild;
              BringToFront;
          end;
      end else begin
       if iGuiID > 0 then
         AppContext['CustomReportListing'].VarByname['Prefname']:= mtReportItem.FieldByName('Report').AsString;
       try
        frmList := TBaseListingGUI(GetComponentByClassName(sListClass,True,nil,True,True,iGuiID));

        if not Assigned(frmList) then exit;

        if not frmList.ErrorOccurred then begin
          if CommonLib.IsClassByString(frmList, 'TBaseTreeViewGUI') then begin
            TBaseTreeViewGUI(frmList).dtTo.DateTime := self.dtTo.DateTime;
            TBaseTreeViewGUI(frmList).dtFrom.DateTime := self.dtFrom.DateTime;
          end
          else begin
            if iGuiID > 0 then // This is a custom list.
              // Note: It is important to set CustomReportName as this is used
              //       when the list is displayed (onShow) to get get correct
              //       GuiPref data for the form.
              frmList.CustomReportName := mtReportItem.FieldByName('Report').AsString;
            if frmList.daterangetype = drNormal then begin
              frmList.dtTo.DateTime := self.dtTo.DateTime;
              frmList.dtFrom.DateTime := self.dtFrom.DateTime;
              frmList.fbDateRangeSupplied := true;
            end;
          end;
        end;
       Finally
           AppContext['CustomReportListing'].DeleteVar('Prefname');
       end;
        frmList.Tag := iGuiID;
        frmList.fiGuiID := iGuiID;
        if Assigned(GetPropInfo(frmList,'AddresstoEmail')) then
          frmList.AddresstoEmail := EmpemailIDs;
        frmList.FormStyle := fsmdiChild;

        if iGuiID = 0 then begin // rename everything that is not a custom list

          { if user hits escape the this ReportSelector form may be closed
            so the following try/except
            block hids the exception (this could happen on WAN installs or
            with lists that are slow to show) }

          try
            frmList.fiGuiID := iGuiID;
            //Rename List;
            if not Empty(mtReportItem.FieldByName('ListName').AsString) then begin
              if CommonLib.IsClassByString(frmList, 'TBaseTreeViewGUI') then begin
                TBaseTreeViewGUI(frmList).TitleLabel.Caption := mtReportItem.FieldByName('ListName').AsString;
                TBaseTreeViewGUI(frmList).Caption := mtReportItem.FieldByName('ListName').AsString;
              end
              else begin
                frmList.TitleLabel.Caption := mtReportItem.FieldByName('ListName').AsString;
                frmList.Caption := mtReportItem.FieldByName('ListName').AsString;
              end;
            end;
          except
          end;
        end;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('This List is not registered for Customization (' + sListClass + ')',
        mtWarning, [mbOK], 0);
    end;
  finally
    Result := frmList;
  end;
end;

procedure TfrmReportSelectorGUI.btnDeleteClick(Sender: TObject);
var
  iGuiIdToDelete: integer;
  Report, ReportClassName: string;
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('OK to Delete Report?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    iGuiIdToDelete  := mtReportItem.FieldByName('GuiID').AsInteger;
    Report          := mtReportItem.FieldByName('Report').AsString;
    ReportClassName := mtReportItem.FieldByName('ClassName').AsString;
    mtReportItem.Delete;

    // now delete the report from other group if exists
    mtReportItem.Filtered := false;
    try
      if mtReportItem.Locate('Report;ClassName', VarArrayOf([Report, ReportClassName]), [loCaseInsensitive]) then begin
        mtReportItem.Delete;
      end;
    finally
      mtReportItem.Filtered := true;
    end;

    with TERPCommand.Create(Self) do try
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Add('DELETE FROM tblCustomizedLists ' +
          'WHERE  GuiID = ' + IntToStr(iGuiIdToDelete));
        Execute;
      finally
        Free;
      end;
  end;
end;

procedure TfrmReportSelectorGUI.btnEmailClick(Sender: TObject);
begin
  inherited;
  with TScheduledreportObj.Create(Self) do try
    showProgressbar(WAITMSG , 10);
    try
      EmailAllScheduledReports(commondblib.GetSharedMyDacConnection, OnAfterEmailEvent);
      OpenERPListForm('TScheduledReportsGUI');
    finally
      HideProgressbar;
    end;
  finally
    Free;
  end;
end;
procedure TfrmReportSelectorGUI.btnEmailReportClick(Sender: TObject);
begin
  inherited;
  EmpemailIDs:='';
  try
    OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' ,InitEmployeeExpresslist, selectEmailIds );
    if EmpemailIDs <> '' then begin
      Setcontrolfocus(dbgReports);
      dbgReportsDBLClick(dbgReports);
    end;
  finally
    EmpemailIDs:= '';
  end;
end;
procedure TfrmReportSelectorGUI.InitEmployeeExpresslist(Sender: TObject);
begin
  if not(Sender is TEmployeeExpresslistGUI) then exit;
  TEmployeeExpresslistGUI(Sender).FilterString := 'Email <> ' + quotedstr('');
  try
    TEmployeeExpresslistGUI(Sender).QrymainEmail.Visible := TRue;
    TEmployeeExpresslistGUI(Sender).Grdmain.SetActiveField('Email');
  Except
  end;
  TEmployeeExpresslistGUI(Sender).TimerMsg(TEmployeeExpresslistGUI(Sender).FilterLabel ,'Select the Employees to send the email to' );
end;
procedure TfrmReportSelectorGUI.selectEmailIds(Sender: TWWDBGrid);
begin
  if not(Sender.owner is TEmployeeExpresslistGUI) then exit;
  EmpemailIDs := TEmployeeExpresslistGUI(Sender.Owner).SelectedDatas('email' ,True, ';');
end;
procedure TfrmReportSelectorGUI.OnAfterEmailEvent(Sender: TObject);
begin
    StepProgressbar;
end;

procedure TfrmReportSelectorGUI.cboDateRangeChange(Sender: TObject);
const
  // Date Range Combo values
  DEFAULT_RANGE  = 0;
  TODAY          = 1;
  YESTEDAY       = 2;
  LAST_WEEK      = 3;
  LAST_MONTH     = 4;
  LAST_QUARTER   = 5;
  LAST_12_MONTHS = 6;
  PREV_WEEK      = 7;
  PREV_MONTH     = 8;
  PREV_QUARTER   = 9;
  PREV_FINANCIAL_YEAR = 10;
  THIS_WEEK      = 11;
  THIS_MONTH     = 12;
  THIS_QUARTER   = 13;
  THIS_FINANCIAL_YEAR = 14;
  THIS_FINANCIAL_YEAR_TO_DATE = 15;  // from 1st of [Fiscal Year] ()Preference in account tab) to Today

var
  MonthsList: TStringList;
//  FiscalYearStartMonthIndex: integer;


  function StartOfTheQuarter(dtDate: TDateTime): TDateTime;
  var
    iMonth: integer;
    iQuater: integer;
    iStartMonth: integer;
  begin
    iMonth := MonthOfTheYear(dtDate);
    iQuater := (iMonth - 1) div 3 + 1;
    iStartMonth := (iQuater - 1) * 3 + 1;
    Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
  end;
begin
  inherited;
  MonthsList := TStringList.Create;
  MonthsList.Add('January');
  MonthsList.Add('February');
  MonthsList.Add('March');
  MonthsList.Add('April');
  MonthsList.Add('May');
  MonthsList.Add('June');
  MonthsList.Add('July');
  MonthsList.Add('August');
  MonthsList.Add('September');
  MonthsList.Add('October');
  MonthsList.Add('November');
  MonthsList.Add('December');
//  FiscalYearStartMonthIndex := MonthsList.IndexOf(AppEnv.CompanyPrefs.FiscalYearStarts);

  case cboDateRange.ItemIndex of
    DEFAULT_RANGE:
      begin
        dtFrom.Date := Date - AppEnv.Employee.ListDaysPast;
        dtTo.Date := Date + AppEnv.Employee.ListDaysFuture;
      end;

    TODAY:
      begin
        dtFrom.Date := Date;
        dtTo.Date := Date;
      end;
      
    YESTEDAY:
      begin
        dtFrom.Date := IncDay(Date, - 1);
        dtTo.Date := IncDay(Date, - 1);
      end;
      
    LAST_WEEK:
      begin
        dtFrom.Date := IncDay(Date, - 6);
        dtTo.Date := Date;
      end;
      
    LAST_MONTH:
      begin
        dtFrom.Date := IncDay(IncMonth(Date, - 1));
        dtTo.Date := Date;
      end;
      
    LAST_QUARTER:
      begin
        dtFrom.Date := IncDay(IncMonth(Date, - 3));
        dtTo.Date := Date;
      end;
      
    LAST_12_MONTHS:
      begin
        dtFrom.Date := IncDay(IncYear(Date, - 1));
        dtTo.Date := Date;
      end;

    PREV_WEEK:
      begin
        dtFrom.Date := IncWeek(StartOfTheWeek(Date), - 1);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;

    PREV_MONTH:
      begin
        dtFrom.Date := IncMonth(StartOfTheMonth(Date), - 1);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), - 1);
      end;

    PREV_QUARTER:
      begin
        dtFrom.Date := IncMonth(StartOfTheQuarter(Date), - 3);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), - 1);
      end;

    PREV_FINANCIAL_YEAR:
      begin
//        if MonthOfTheYear(Date) <= 6 then dtFrom.Date := IncYear(IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6), - 1)
//        else dtFrom.Date := IncYear(IncMonth(StartOfTheYear(Date), 6), - 1);
        dtFrom.Date := GetPriorFiscalYearStart;

        dtTo.Date := IncDay(IncYear(dtFrom.Date), - 1);
      end;

    THIS_WEEK:
      begin
        dtFrom.Date := StartOfTheWeek(Date);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;

    THIS_MONTH:
      begin
        dtFrom.Date := StartOfTheMonth(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), - 1);
      end;

    THIS_QUARTER:
      begin
        dtFrom.Date := StartOfTheQuarter(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), - 1);
      end;

    THIS_FINANCIAL_YEAR:
      begin
//        if MonthOfTheYear(Date) <= 6 then dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6)
//        else dtFrom.Date := IncMonth(StartOfTheYear(Date), 6);
        dtFrom.Date := GetCurrentFiscalYearStart;

        dtTo.Date := IncDay(IncYear(dtFrom.Date), - 1);
      end;

    THIS_FINANCIAL_YEAR_TO_DATE:
      begin
//        if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
//          dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, - 1)), FiscalYearStartMonthIndex);
//        end else begin
//          dtFrom.Date := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
//        end;
        dtFrom.Date := GetCurrentFiscalYearStart;
        dtTo.Date := DateUtils.Today;
      end;
  end;
end;

procedure TfrmReportSelectorGUI.btnUpdateBatchClick(Sender: TObject);
var
  BOMPriceCostUpdateOption :Word;
  Msg, Msgoptions: String;
begin
  Appenv.CompanyPrefs.DosyncSerialnumberlist := False;
  try
  //  Debuglib.RecalculateproductAvgcost;

   //Take the confirmation in the begenning of the update batch -  Dene asked

   if Appenv.Employee.RunManufacturingUpdateBatch = False then begin
      BOMPriceCostUpdateOption := 102;
   end else begin
         BOMPriceCostUpdateOption:= 0;

          Msg:= 'Would you like to recalculate the Price and Cost of BOM products and overwrite them even if manually entered?'+NL+NL+NL +
                  '''Yes'' : Will recalculate the Price and Cost of BOM products and '+NL+'         overwrite them even if manually entered ' +NL+NL +
                   '''Update if not manually entered'' :Will recalculate the  '+NL+'         Price and Cost of BOM products and overwrite them  '+NL+'         if NOT manually entered '+NL+NL+
                   '''No'' : Will NOT recalculate the Price and Cost of BOM products '+NL+NL+
                   '''Cancel'' : Don''t do ''Update Batch'' at the moment'+NL ;
          Msgoptions :={100=}'Yes,'+     {101=}'Update if not manually entered ,'+      {102=}'No,'+      {103=}'Cancel';

        While true do begin
          BOMPriceCostUpdateOption :=MessageDlgXP_Vista(Msg,mtConfirmation, [], 0 , nil , '' , '' , False, nil , Msgoptions);
          if (CanRecalculateBOMcostnPriceinUpdateBatch =False) and (BOMPriceCostUpdateOption = 100) then begin
            MessageDlgXP_vista('You don''t have access to recalculate the Price and Cost of BOM products ', mtWarning, [mbOK], 0);
            continue;
          end;
          break;
        end;

         // based on this the BOM price / cost updated
         if BOMPriceCostUpdateOption =103 then exit;

         if BOMPriceCostUpdateOption = 100 then begin
          // an extra confirmation
          Msg:= 'You have selected '+NL+'"RECALCULATE THE PRICE AND COST OF BOM PRODUCTS"'+NL+'and overwrite them even if manually entered.  Are you sure to recalculate it?'+NL+NL+NL +
                  '''Yes'' : Will recalculate the Price and Cost of BOM products and '+NL+'         overwrite them even if manually entered ' +NL+NL +
                   '''Update if not manually entered'' :Will recalculate the  '+NL+'         Price and Cost of BOM products and overwrite them  '+NL+'         if NOT manually entered '+NL+NL+
                   '''No'' : Will NOT recalculate the Price and Cost of BOM products '+NL+NL+
                   '''Cancel'' : Don''t do ''Update Batch'' at the moment'+NL ;
          BOMPriceCostUpdateOption :=MessageDlgXP_Vista(Msg,mtConfirmation, [], 0 , nil , '' , '' , False, nil , Msgoptions);
         end;
   end;

   ShowUpdateBatchHint(Self);
   try
    DisableForm;
    try
      inherited;
      GlobalEvents.Notify(btnUpdateBatch, GEVENT_ReportUpateBatch);


      if BOMPriceCostUpdateOption <> 102 then DoExtraUpdates(BOMPriceCostUpdateOption=101);

    finally
      EnableForm;
    end;
   finally
     HideERPHint(self);
   end;
  finally
    Appenv.CompanyPrefs.DosyncSerialnumberlist := True;
  end;
end;

procedure TfrmReportSelectorGUI.ChkBatchModeTimer(Sender: TObject);
begin
  inherited;
  btnUpdateBatch.Enabled := not (IsBatchInProgress);
end;

procedure TfrmReportSelectorGUI.FormCreate(Sender: TObject);
begin
  EmpemailIDs:='';
  fbIgnoreAccessLevels := true;
  inherited;
  fChartClassList := TStringList.Create;
  AddCustomReports;
  fChartQuery := CommonDbLib.TempMyQuery;
  try
    GlobalEvents.Notify(Self, GEVENT_AfterCreate);
  Except
    // kill exception
  end;
end;

procedure TfrmReportSelectorGUI.AddCustomReports;
var
  qry: TERPQuery;
  sGroup: string;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := false;
    qry.SQL.Add('SELECT GuiID, Report, ReportTab, ClassName FROM tblCustomizedLists ' +
      'WHERE ((NOT IsNull(Report)) AND (Report <> "")) AND EmployeeID = ' + 
      IntToStr(AppEnv.Employee.EmployeeID));
      
    qry.Open;
    qry.First;
    
    while not qry.Eof do begin
      sGroup := qry.FieldByName('ReportTab').AsString;
      
      if not qry.FieldByName('Report').IsNull then begin
        // add report to 'My Reports'
        Self.Add(' My Reports',
          qry.FieldByName('Report').AsString,
          qry.FieldByName('ClassName').AsString,
          qry.FieldByName('GuiID').AsInteger);
          
        if (sGroup <> '') and (not Sysutils.SameText(sGroup, 'My Reports')) then begin
          // add report to the corresponding group
          Self.Add(' ' + sGroup,
            qry.FieldByName('Report').AsString,
            qry.FieldByName('ClassName').AsString,
            qry.FieldByName('GuiID').AsInteger);
        end;
      end;
      
      qry.Next;
    end;
    
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmReportSelectorGUI.LaunchSelectedReport;
var
  p: TNotifyEvent;
begin
  if mtReportItem.FieldByName('onClickPtr').AsInteger <> 0 then begin
    p := nil;
    inherited; @p := Pointer(mtReportItem.FieldByName('onClickPtr').AsInteger);
    p(nil);
  end else begin
    LaunchList(mtReportItem.FieldByName('ClassName').AsString,
      mtReportItem.FieldByName('GuiID').AsInteger  );
  end;
end;


procedure TfrmReportSelectorGUI.edtSearchChange(Sender: TObject);
begin
  inherited;
//  dbgReports.Invalidate;
//  dsReportItem.Dataset.Locate('Report', ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', ''),[loCaseInsensitive, loPartialKey]);
end;

procedure TfrmReportSelectorGUI.dbgReportsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE; // a very light yellow rw  
begin
  inherited;
  if (not Empty(edtSearch.Text)) AND (Field.FieldName='Report') then
      if (FastFuncs.PosEx(uppercase(ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', '')),
        uppercase(Field.AsString)) = 1) then begin
        ABrush.Color := HIGHLIGHTLOCATEDEF;
      end;
  if mtReportItem.fieldbyname('Emailable').asBoolean  then
    AFont.Color := clMaroon;
end;

procedure TfrmReportSelectorGUI.grdGroupChartsDblClick(Sender: TObject);
begin
  if self.fChartQuery.RecordCount = 0 then      exit;
  dtmMainGUI.Launchchart(Sender , fChartQuery.FieldByName('ReportClassName').AsString  , grdGroupCharts.DataSource.dataset.FieldByname('ChartName').asString     , ''       , true,0);
(*var
  Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if self.fChartQuery.RecordCount = 0 then
      exit;
    Form := LaunchList(fChartQuery.FieldByName('ReportClassName').AsString,0 );
    if Assigned(Form) then begin
      TBaseListingGUI(Form).CustomChartToView:=  grdGroupCharts.DataSource.dataset.FieldByname('ChartName').asString;
      TBaseListingGUI(Form).mnuChartViewClick(nil);
      TBaseListingGUI(Form).OpenedByChart:= true;
      Application.ProcessMessages;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TfrmReportSelectorGUI.edtSearch2Change(Sender: TObject);
begin
  inherited;
  fChartQuery.Locate('ChartName', ReplaceStr(ReplaceStr(edtSearch2.Text, '%', ''), '*', ''),[loCaseInsensitive, loPartialKey]);
end;

procedure TfrmReportSelectorGUI.wwIButton1Click(Sender: TObject);
begin
  inherited;
  if fChartQuery.FieldByName('Candelete').AsBoolean =False then begin
    MessageDlgXP_Vista(Quotedstr(fChartQuery.fieldByname('chartname').asString) +' is used in the application.' + NL +' It is not possible to delete this chart.', mtInformation, [mbOK], 0);
    Exit;
  end;
  if CommonLib.MessageDlgXP_Vista('OK to Delete Chart: "' + fChartQuery.FieldByName('ChartName').AsString + '"', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    fChartQuery.Delete;
  end;
end;  


procedure TfrmReportSelectorGUI.cboSearchCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  SearchForText(cboSearch.Text);
end;

procedure TfrmReportSelectorGUI.SearchForText(const SearchStr: string; const FocusControlName: string = '');
var
  IndexOfText: Integer;
  sReport,sGroup: string;
  DelimiterPos: Integer;
begin
  IndexOfText := cboSearch.Items.IndexOf(SearchStr); 
  if IndexOfText >= 0 then begin
    DelimiterPos := FastFuncs.PosEx('|', SearchStr);
    sReport := Copy(SearchStr, 1, DelimiterPos - 2);
    sGroup  := Copy(SearchStr,DelimiterPos + 2,char_length(SearchStr));
    rgGroups.ItemIndex := rgGroups.Items.IndexOf(sGroup);

    dbgReports.Invalidate;
    dsReportItem.Dataset.Locate('Report', ReplaceStr(ReplaceStr(sReport, '%', ''), '*', ''),[loCaseInsensitive, loPartialKey]);
  end;
end;


procedure TfrmReportSelectorGUI.setdefaultGroup(const Value: string);
var
  s:string;
begin
  s:=dotranslate(trim(Value));
  if s= '' then s:= trim(Value);
  fsdefaultGroup := s;
end;

procedure TfrmReportSelectorGUI.setdefaultReport(const Value: string);
var
  s:string;
begin
  s:=dotranslate(trim(Value));
  if s= '' then s:= trim(Value);
  fsdefaultReport := s;
end;

procedure TfrmReportSelectorGUI.DoExtraTranslation;
var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to cboDateRange.Items.Count-1 do
    cboDateRange.Items[ctr] := dotranslate(cboDateRange.Items[ctr] );
  cboDateRange.text :=cboDateRange.Items[0];
end;

procedure TfrmReportSelectorGUI.DoExtraUpdates(ignoreifManuallyentered:Boolean);
begin
  RecalculateBOMcostnPrice(ignoreifManuallyentered);
end;


initialization
  RegisterClassOnce(TfrmReportSelectorGUI);
end.
