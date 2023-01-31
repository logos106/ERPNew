unit GoogleAnalytic_Summary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AnalyticReport, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls , ListChartView;

type
  TGoogleAnalytic_SummaryGUI = class(TAnalyticReportGUI)
    pnlSubgraph: TDNMPanel;
    lblGraph: TLabel;
    report1n2: TSplitter;
    optcharts: TRadioGroup;
    pnlSeries: TDNMPanel;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure optchartsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Subchartform :TListChartView;
    curSubchart:String;
  Protected
    procedure ReadnApplyGuiPref;Override;
    procedure WriteGuiPref;Override;
    Procedure OpenChart;override;
  public

  end;


implementation

uses CommonLib;


{$R *.dfm}


procedure TGoogleAnalytic_SummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  reportclassname := 'TGoogleAnalysisReport_SummaryGUI';
  Chartname := 'Google Chart - Summary';
  Reprottitle := 'Summary';
  curSubchart:='';
end;

procedure TGoogleAnalytic_SummaryGUI.FormShow(Sender: TObject);
begin
  inherited;
  {since the list form's width is based on preference in 'ReadnApplyGuiPref', resize the options }
  if Assigned(Listform) then begin
    Listform.Repositionheaderwithinpanel;
    Listform.SetOnsameLineOneafterOther(Listform.cboFilter,Listform.lblSearchoptions);
    Listform.SetOnsameLineOneafterOther(Listform.lblSearchoptions,Listform.edtSearch );
    Listform.SetOnsameLineOneafterOther(Listform.edtSearch,Listform.lblFrom);
    Listform.SetOnsameLineOneafterOther(Listform.lblFrom , Listform.dtFrom);
    Listform.SetOnsameLineOneafterOther(Listform.dtFrom, Listform.lblto);
    Listform.SetOnsameLineOneafterOther(Listform.lblto, Listform.dtto);
  end;
end;

procedure TGoogleAnalytic_SummaryGUI.OpenChart;
begin
  inherited;
  if Assigned(chartForm) then begin
    chartForm.ChartDesigner.ChartListBox1.Parent := pnlSeries;
    chartForm.ChartDesigner.ChartListBox1.Align:= alclient;
    chartForm.ChartDesigner.ChartListBox1.OnDblClickSeries := nil;
  end;
end;

procedure TGoogleAnalytic_SummaryGUI.optchartsClick(Sender: TObject);
var
  Subchart:String;
begin
  inherited;
  if OptchartS.itemindex <0 then exit;
  if not(Assigned(Listform))or (ChartForm = nil) then openchart;

       if OptchartS.ItemIndex = 0 then Subchart := 'Google Chart Summary - Visits'
  else if OptchartS.ItemIndex = 1 then Subchart := 'Google Chart Summary - New Visits'
  else if OptchartS.ItemIndex = 2 then Subchart := 'Google Chart Summary - Pageviews'
  else if OptchartS.ItemIndex = 3 then Subchart := 'Google Chart Summary - Impressions'
  else if OptchartS.ItemIndex = 4 then Subchart := 'Google Chart Summary - Avg Duration'
  else if OptchartS.ItemIndex = 5 then Subchart := 'Google Chart Summary - Bounce Rate'
  else if OptchartS.ItemIndex = 6 then Subchart := 'Google Chart Summary - Pages / Visit'
  else exit;
  if curSubchart = Subchart then exit;
  freeandNil(Subchartform);
  Subchartform := TListChartView(GetComponentByClassName('TListChartView', False , Self , False));
  Subchartform.ShowChartView(Listform.Qrymain, Subchart, pnlSubgraph, Reportclassname);
  curSubchart := Subchart;
end;

procedure TGoogleAnalytic_SummaryGUI.ReadnApplyGuiPref;
var
  x:Integer;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options') then begin
      x := GuiPrefs.Node['Options.SubchartWidth'].asInteger;
      if x > 0 then pnlSubgraph.Width := x;
      x := GuiPrefs.Node['Options.serieswidth'].asInteger;
      if x > 0 then pnlSeries.Width := x;
      x := GuiPrefs.Node['Options.SelectedchartIndex'].asInteger;
      if x >= 0 then optcharts.ItemIndex :=x else optcharts.ItemIndex:=0;
  end;
end;

procedure TGoogleAnalytic_SummaryGUI.WriteGuiPref;
begin
  inherited;
  GuiPrefs.Node['Options.SubchartWidth'].asInteger := pnlSubgraph.Width;
  GuiPrefs.Node['Options.SelectedchartIndex'].asInteger := optcharts.ItemIndex;
  GuiPrefs.Node['Options.serieswidth'].asInteger:= pnlSeries.Width;
  //chartForm.SaveChart;
end;

initialization
  RegisterClassOnce(TGoogleAnalytic_SummaryGUI);

end.

