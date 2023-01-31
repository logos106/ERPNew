unit AnalyticReport;
 {Analyticreport
    |-- GoogleAnalytic_Base
    |    |-- GoogleAnalytic_Browser       ReportClassname --> GoogleAnalysisReport_Browser   Chartname --> Google Chart - Browser
    |    |-- GoogleAnalytic_Campaign      ReportClassname --> GoogleAnalysisReport_Campaign  Chartname --> Google Chart - Campaign
    |    |-- GoogleAnalytic_DayofWeek     ReportClassname --> GoogleAnalysisReport_DayofWeek Chartname --> Google Chart - Day of the Week
    |    |-- GoogleAnalytic_Keyword       ReportClassname --> GoogleAnalysisReport_Keyword   Chartname --> Google Chart - Keyword
    |    |-- GoogleAnalytic_Language      ReportClassname --> GoogleAnalysisReport_Language  Chartname --> Google Chart - Language
    |    |-- GoogleAnalytic_Location      ReportClassname --> GoogleAnalysisReport_Location  Chartname --> Google Chart - Location
    |--TfmGoogleAnalytic_Summary}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  BaseListingForm, ListChartView,Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, GuiPrefsObj, DNMPanel;

type
  TAnalyticReportGUI = class(TBaseForm)
    pnlbottom: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTitle: TLabel;
    Horizontal1: TSplitter;
    pnlgraph: TDNMPanel;
    pnlList: TDNMPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
  private
    fsReportclassname: String;
    fschartname: String;
    fsReprottitle: String;
    procedure DeletenReInitPref;

  Protected
    Listform :TBaseListingGUI ;
    ChartForm : TListChartView;
    GuiPrefs: TFormGuiPrefs;
    procedure OpenChart; Virtual;
    procedure ReadnApplyGuiPref;Virtual;
    procedure WriteGuiPref;Virtual;
    procedure makelistform;virtual;
    Procedure DoExtraTranslation;Override;
  public
    constructor Create(AOwner: TComponent); override;
    Property Reportclassname:String read fsReportclassname write fsReportclassname;
    Property chartname :String read fschartname write fschartname;
    Property Reprottitle:String read fsReprottitle write fsReprottitle;
    Procedure Refreshreport;virtual;
    Class Procedure ViewAnalyticreport(rReportclassname, rChartName:String);
  end;


implementation

uses   CommonLib, CommonFormLib , MessageInterface, AppEnvironment,
  BusObjPreference, MAIN;

{$R *.dfm}

procedure TAnalyticReportGUI.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TAnalyticReportGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  if Assigned(ListForm) then Listform.close;
  inherited;
  Action := caFree;
end;

procedure TAnalyticReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  ChartForm := nil;
  Listform :=nil;
  fsReportclassname := '';
  fschartname :='';
  fsReprottitle := '';
end;

procedure TAnalyticReportGUI.FormShow(Sender: TObject);
begin
  if fsReprottitle <> '' then Self.Caption := 'Analytic Summary -' + fsReprottitle;
  inherited;

  if not GuiPrefs.Active then
  try
    GuiPrefs.Active:= true;
  Except
    on E:Exception do begin
      DeletenReInitPref;
    end;
  end;
  if fsReprottitle <> '' then  lblTitle.Caption :=  fsReprottitle;
  Refreshreport;
  ReadnApplyGuiPref;
  Makeitcentralized;
end;
procedure TAnalyticReportGUI.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if Assigned(listform) then Listform.cmdPrint.Click;
  if Assigned(chartform) then
    if MessageDlgXP_Vista('Do you wish to print the chart?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      chartform.ChartPrintOptions.BPrint.Click;
end;

constructor TAnalyticReportGUI.Create(AOwner: TComponent);
begin
  //
  inherited;

end;

procedure TAnalyticReportGUI.DeletenReInitPref;
var
  msg: string;
begin
  TPreference.DeleteUserPrefs(AppEnv.Employee.EmployeeID,msg,Listform.Qrymain.Connection);
  GuiPrefs.Active := False;
  GuiPrefs.Active := TRue;
end;
procedure TAnalyticReportGUI.DoExtraTranslation;
begin
  inherited;
  Guiprefs.DoTranslate;
end;

Procedure TAnalyticReportGUI.makelistform;
begin
  if Listform = nil then  begin
    CreateHistorylistform(fsReportclassname ,Self, Listform,'');
    if Assigned(Listform) then Self.Color := Listform.Color;
  end;
end;
procedure TAnalyticReportGUI.Refreshreport;
begin
  MakeListForm;
  if Assigned(Listform) then begin
    Listform.Parent := pnlList;
    Listform.BorderStyle := bsNone;
    Listform.fbIgnoreQuerySpeed := true;
    Listform.Show;
  end;
  Listform.CustomChartToView := chartname;
  OpenChart;
end;
class procedure TAnalyticReportGUI.ViewAnalyticreport(rReportclassname,  rChartName: String);
var
  form :Tcomponent;
begin
  if trim(rReportclassname) = '' then begin
    MessageDlgXP_Vista('Invalid List name', mtWarning, [mbOK], 0);
    exit;
  end;
  if trim(rChartName)='' then begin
    MessageDlgXP_Vista('Invalid Chart name', mtWarning, [mbOK], 0);
    exit;
  end;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('TAnalyticReportGUI') <> 1) then begin
    MessageDlgXP_Vista('You don''t have access to view the Analytical reports', mtWarning, [mbOK], 0);
    exit;
  end;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel(rReportclassname) <> 1) then begin
    MessageDlgXP_Vista('You don''t have access to view the ' + AppEnv.AccessLevels.GetFormDescription(rReportclassname), mtWarning, [mbOK], 0);
    exit;
  end;

  form := FindExistingComponent('TAnalyticReportGUI');
  if Assigned(Form) then begin
    TAnalyticReportGUI(Form).BringToFront;
    Exit;
  end;
  form := GetComponentByClassName('TAnalyticReportGUI');
  TAnalyticReportGUI(form).reportclassname := rReportclassname;
  TAnalyticReportGUI(form).Chartname := rChartname;
  TAnalyticReportGUI(form).FormStyle := fsMdiChild;
  TAnalyticReportGUI(form).BringToFront;
end;

procedure TAnalyticReportGUI.OpenChart;
begin
  inherited;
    if Assigned(Listform) then begin
        if Listform.SearchMode <> smFullList then begin
          Listform.SearchMode := smFullList;
          if not Listform.qryMain.Active then Listform.DoRefreshQuery;
        end;
    if ChartForm = nil then begin
      ChartForm := TListChartView(GetComponentByClassName('TListChartView', False , Self , False));
      ChartForm.hint := 'Double click on List Data to Edit chart';
      ChartForm.showhint := TRue;
    end;
    ChartForm.ShowChartView(Listform.Qrymain, chartName, pnlgraph, Reportclassname);
  end;
end;
procedure TAnalyticReportGUI.WriteGuiPref;
begin
    GuiPrefs.Node['Options.ChartHeight'].asInteger := pnlgraph.height;
end;

procedure TAnalyticReportGUI.ReadnApplyGuiPref;
var
  x:Integer;
begin
    if GuiPrefs.Node.Exists('Options') then begin
      x := GuiPrefs.Node['Options.ChartHeight'].asInteger;
      if x > 0 then pnlgraph.height := x;
    end;
end;
end.

