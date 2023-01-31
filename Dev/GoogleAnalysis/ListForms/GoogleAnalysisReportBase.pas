unit GoogleAnalysisReportBase;

interface
{this is the base form for all 6 categories of google analysis report
Qrymain.SQL is not changed in the subforms and the field names are changed dynamically in the form create for each category}
Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup ;

type
  TGoogleAnalysisReportBaseGUI = class(TBaseListingGUI)
    QryAccountname: TERPQuery;
    pnlOptions: TDNMPanel;
    lblTitle: TLabel;
    lblAccount: TLabel;
    chktitles: TCheckBox;
    cbotitle: TwwDBLookupCombo;
    cboAccountname: TwwDBLookupCombo;
    chkAccountname: TCheckBox;
    qryMainDescription: TWideStringField;
    qryMainVisits: TFloatField;
    qryMainNewvisits: TFloatField;
    qryMainPageviews: TFloatField;
    qryMainTimeonSite: TFloatField;
    QryTGaProfile: TERPQuery;
    qryMainFTimeonSite: TWideMemoField;
    procedure chkAccountnameClick(Sender: TObject);
    procedure chktitlesClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);
    procedure cbotitleCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;modified: Boolean);
    procedure cboAccountnameCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
  private
    formshown:boolean;
    fonRefreshQuery: TGeneralProc;
    function GARName: String;
    procedure beforeShowlist(sender: TObject);
    function GARField: String;
    { Private declarations }
  Protected
    GAR_Category :String;
    Procedure RefreshQuery; override;

    procedure SetupFormInPanel; Override;
    Procedure RefreshTotals;Override;
    procedure SetGridColumns; Override;
    procedure readGridfooterValue(columnname: String; Value: Double);Override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    totalvisits :double;
    function ListDescription:String;Override;
    Property onRefreshQuery :TGeneralProc read fonRefreshQuery write fonRefreshQuery;

  end;


implementation

uses CommonLib, GoogleAnalysisReport_Browser, GoogleAnalysisReport_Campaign,
  GoogleAnalysisReport_DayofWeek, GoogleAnalysisReport_Keyword,
  GoogleAnalysisReport_Language, GoogleAnalysisReport_Location, CommonFormLib,
  ListLib;

{$R *.dfm}

{ TGoogleAnalysisReportBaseGUI }

procedure TGoogleAnalysisReportBaseGUI.cboAccountnameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if screen.activecontrol <> cboAccountname then exit;
  chkAccountname.Checked  :=  cboAccountname.Text = '';
  RefreshQuery;
end;

procedure TGoogleAnalysisReportBaseGUI.cbotitleCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if screen.ActiveControl<> cbotitle then exit;
  chktitles.Checked       :=  cbotitle.Text = '';
  RefreshQuery;
end;

procedure TGoogleAnalysisReportBaseGUI.chkAccountnameClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl <> chkAccountname then exit;
  if chkAccountname.Checked then cboAccountname.Text := '';
  RefreshQuery;
end;

procedure TGoogleAnalysisReportBaseGUI.chktitlesClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <> chktitles then exit;
  if chktitles.Checked then cbotitle.Text := '';
  RefreshQuery;
end;
function  TGoogleAnalysisReportBaseGUI.GARField:String;
begin
  //if SameText(GAR_Category , 'DayofWeek') then result :='cast(WeekDayname(GDC.DayofWeek) AS CHAR(20))'
  if SameText(GAR_Category , 'DayofWeek') then result :='WeekDayname(GDC.DayofWeek) '
  else result := 'GDC.' +GAR_Category;
end;
procedure TGoogleAnalysisReportBaseGUI.FormCreate(Sender: TObject);
begin
  totalvisits:= 0;
  Qrymaindescription.DisplayLabel := GARName;
  Qrymain.SQL.text := replacestr(Qrymain.SQL.text , 'GDC.GAR_Category' , GARfield);
  Self.Caption := 'Google Analytics Report' (*+' (By ' + GARName+')'*);
  inherited;
  (*FilterOptionSupplied*)GrpfilterSupplied   := true;
       if Self is TGoogleAnalysisReport_LanguageGUI  then grpfilters.Itemindex := 0
  else if Self is TGoogleAnalysisReport_LocationGUI  then grpfilters.Itemindex := 1
  else if Self is TGoogleAnalysisReport_BrowserGUI   then grpfilters.Itemindex := 2
  else if Self is TGoogleAnalysisReport_CampaignGUI  then grpfilters.Itemindex := 3
  else if Self is TGoogleAnalysisReport_KeywordGUI   then grpfilters.Itemindex := 4
  else if Self is TGoogleAnalysisReport_DayofWeekGUI then grpfilters.Itemindex := 5;
  AddCalcColumn(qryMainVisits.Fieldname, False, fctAvg);
  AddCalcColumn(qryMainNewvisits.Fieldname, False, fctAvg);
  AddCalcColumn(qryMainPageviews.Fieldname, False, fctAvg);
end;
procedure TGoogleAnalysisReportBaseGUI.FormShow(Sender: TObject);
begin
  chktitles.Checked       :=  cbotitle.Text = '';
  chkAccountname.Checked  :=  cboAccountname.Text = '';
  inherited;
  if GARName <> '' then
    if sametext(GARName, 'Summary') then TitleLabel.Caption := GARName
    else TitleLabel.Caption := 'By ' +GARName;
  formshown := True;
end;

function TGoogleAnalysisReportBaseGUI.GARName:String;
begin
  if SameText(GAR_Category , 'DayofWeek') then result :='Day of the Week'
  else result := GAR_Category;
end;
procedure TGoogleAnalysisReportBaseGUI.grpFiltersClick(Sender: TObject);
var
  formname :String;
begin
  inherited;
  if not(formshown) then exit;
       if grpfilters.ItemIndex =0 then formname:='TGoogleAnalysisReport_LanguageGUI'
  else if grpfilters.ItemIndex =1 then formname:='TGoogleAnalysisReport_LocationGUI'
  else if grpfilters.ItemIndex =2 then formname:='TGoogleAnalysisReport_BrowserGUI'
  else if grpfilters.ItemIndex =3 then formname:='TGoogleAnalysisReport_CampaignGUI'
  else if grpfilters.ItemIndex =4 then formname:='TGoogleAnalysisReport_KeywordGUI'
  else if grpfilters.ItemIndex =5 then formname:='TGoogleAnalysisReport_DayofWeekGUI'
  else exit;
  if Self.ClassNameIs(formname) then exit;
  OpenERPListForm(formname , beforeShowlist);
  Self.Close;
end;
function TGoogleAnalysisReportBaseGUI.ListDescription: String;
begin
    result := 'Google Analytics Report' +' (By ' + GARName+')';
end;

procedure TGoogleAnalysisReportBaseGUI.beforeShowlist(sender:TObject);
begin
  if not(Sender is TGoogleAnalysisReportBaseGUI) then exit;
  TGoogleAnalysisReportBaseGUI(SendeR).chktitles.Checked      := chktitles.Checked;
  TGoogleAnalysisReportBaseGUI(SendeR).chkAccountname.Checked := chkAccountname.Checked;
  TGoogleAnalysisReportBaseGUI(SendeR).cbotitle.Text          := cbotitle.Text;
  TGoogleAnalysisReportBaseGUI(SendeR).cboAccountname.Text    := cboAccountname.Text;
  TGoogleAnalysisReportBaseGUI(SendeR).dtFrom.Date            := dtfrom.Date;
  TGoogleAnalysisReportBaseGUI(SendeR).dtTo.Date              := dtTo.Date;
  TGoogleAnalysisReportBaseGUI(SendeR).fbDateRangeSupplied    := True;
end;
procedure TGoogleAnalysisReportBaseGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  closedb(QryTGaProfile);
  closedb(QryAccountname);
  QryAccountname.connection := Qrymain.connection;
  QryTGaProfile.connection := Qrymain.Connection;
  OpenDB(QryTGaProfile);
  OpenDB(QryAccountname);
end;


procedure TGoogleAnalysisReportBaseGUI.readGridfooterValue(columnname: String;  Value: Double);
begin
  inherited;
  if sameText(columnname , 'Newvisits') then totalvisits := Value;
end;

procedure TGoogleAnalysisReportBaseGUI.RefreshQuery;
begin

  if (Qrymain.Params.FindParam('DateFrom') <> nil) and (Qrymain.Params.FindParam('DateTo') <> nil) then
    InitDateFromnDateto('DateFrom' , 'DateTo');

  if (Qrymain.Params.FindParam('AccountName') <> nil) then
    if (chkAccountname.checked) or (cboaccountname.text = '') then
      Qrymain.Parambyname('AccountName').asString := ''
    else Qrymain.Parambyname('AccountName').asString := cboaccountname.text;

  if (Qrymain.Params.FindParam('Title') <> nil) then
    if (chktitles.checked) or (cbotitle.text = '') then
      Qrymain.Parambyname('Title').asString := ''
    else Qrymain.Parambyname('Title').asString := cbotitle.text;

  inherited;
end;

procedure TGoogleAnalysisReportBaseGUI.RefreshTotals;
begin
    CalcnShowFooter;
    if Assigned(fonRefreshQuery) then fonRefreshQuery;
end;

procedure TGoogleAnalysisReportBaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainTimeonSite.fieldname);
end;

procedure TGoogleAnalysisReportBaseGUI.SetupFormInPanel;
begin
  inherited;
  pnlOptions.Align    := altop;
  pnlOptions.height := 30;
  HeaderPanel.Height  := HeaderPanel.Height  +pnlOptions.height;
  pnlOptions.visible := True;
  lblAccount.Left     := chktitles.Left + chktitles.Width +10;
  cboAccountname.Left := lblAccount.Left +lblAccount.Width +10;
  chkAccountname.Left :=cboAccountname.Left + cboAccountname.width +10;
  lblcustomReport.Visible    := False;
  cboCustomReports.Visible   := False;


  SetOnsameLineOneafterOther(cboFilter,lblSearchoptions);
  SetOnsameLineOneafterOther(lblSearchoptions,edtSearch,2 );
  SetOnsameLineOneafterOther(edtSearch,lblFrom, 5);
  SetOnsameLineOneafterOther(lblFrom , dtFrom,5);
  SetOnsameLineOneafterOther(dtFrom, lblto, 5);
  SetOnsameLineOneafterOther(lblto, dtto,5);

  lblTitle.Left := 1;
  lblTitle.Top := 1;
  lblTitle.height :=cbotitle.Height;
  lblTitle.Left :=lblFilter.Left ;
  SetOnsameLineOneafterOther(lblTitle , cbotitle,10);
  SetOnsameLineOneafterOther(cbotitle , chktitles,10);
  SetOnsameLineOneafterOther(chktitles, lblAccount, 50);
  SetOnsameLineOneafterOther(lblAccount , cboAccountname,10);
  SetOnsameLineOneafterOther(cboAccountname, chkAccountname,10);
end;

procedure TGoogleAnalysisReportBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['Options.Alltitles'].asBoolean  := chktitles.Checked;
    GuiPrefs.Node['Options.AllAccount'].asBoolean := chkAccountname.Checked;
    GuiPrefs.Node['Options.Title'].asString       := cbotitle.Text;
    GuiPrefs.Node['Options.Accountname'].asString := cboAccountname.Text;
end;
procedure TGoogleAnalysisReportBaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options') then begin
      cbotitle.Text           :=  GuiPrefs.Node['Options.Title'].asString;
      cboAccountname.text     :=  GuiPrefs.Node['Options.Accountname'].asString;
      chktitles.Checked       :=  GuiPrefs.Node['Options.Alltitles'].AsBoolean;
      chkAccountname.Checked  :=  GuiPrefs.Node['Options.AllAccount'].AsBoolean;
  end;
end;

end.

