unit GoogleAnalytic_Base;
{
    |-- GoogleAnalytic_Base
    |    |-- GoogleAnalytic_Browser       ReportClassname --> GoogleAnalysisReport_Browser   Chartname --> Google Chart - Browser
    |    |-- GoogleAnalytic_Campaign      ReportClassname --> GoogleAnalysisReport_Campaign  Chartname --> Google Chart - Campaign
    |    |-- GoogleAnalytic_DayofWeek     ReportClassname --> GoogleAnalysisReport_DayofWeek Chartname --> Google Chart - Day of the Week
    |    |-- GoogleAnalytic_Keyword       ReportClassname --> GoogleAnalysisReport_Keyword   Chartname --> Google Chart - Keyword
    |    |-- GoogleAnalytic_Language      ReportClassname --> GoogleAnalysisReport_Language  Chartname --> Google Chart - Language
    |    |-- GoogleAnalytic_Location      ReportClassname --> GoogleAnalysisReport_Location  Chartname --> Google Chart - Location
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AnalyticReport, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls, GoogleLeadsummary;

type
  TGoogleAnalytic_BaseGUI = class(TAnalyticReportGUI)
    procedure FormCreate(Sender: TObject);
  private
    fGoogleLeadsummaryGUI :TGoogleLeadsummaryGUI;
    function GoogleLeadsummaryform :TGoogleLeadsummaryGUI;
    procedure onListonRefreshQuery;



  Protected
    Procedure ShowGoogleLeadsummary; Virtual;
    procedure makelistform;Override;
  public
  end;


implementation

uses CommonDbLib, GoogleAnalysisReportBase;


{$R *.dfm}

{ TGoogleAnalytic_BaseGUI }

procedure TGoogleAnalytic_BaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fGoogleLeadsummaryGUI :=nil;
end;


function TGoogleAnalytic_BaseGUI.GoogleLeadsummaryform: TGoogleLeadsummaryGUI;
begin
  result:= nil;
  if not Assigned(listform) then exit;
  if fGoogleLeadsummaryGUI =nil then begin
    fGoogleLeadsummaryGUI :=TGoogleLeadsummaryGUI.Create(self);
    fGoogleLeadsummaryGUI.pnlMain.Align := alright;
    fGoogleLeadsummaryGUI.pnlMain.Parent :=  listform.Panel1;
    fGoogleLeadsummaryGUI.pnlMain.Width := 276;
  end;
  result:= fGoogleLeadsummaryGUI;
end;


procedure TGoogleAnalytic_BaseGUI.makelistform;
begin
  if Listform = nil then  begin
    inherited;
    if ListForm is TGoogleAnalysisReportBaseGUI then TGoogleAnalysisReportBaseGUI(Listform).onRefreshQuery := onListonRefreshQuery;
  end;
end;
procedure TGoogleAnalytic_BaseGUI.onListonRefreshQuery;
begin
  ShowGoogleLeadsummary;
end;
procedure TGoogleAnalytic_BaseGUI.ShowGoogleLeadsummary;
begin
  if GoogleLeadsummaryform =nil then exit;
  With GoogleLeadsummaryform do begin
    if listform is TGoogleAnalysisReportBaseGUI then begin
      DateFrom := listform.FilterDateFrom;
      Dateto := listform.FilterDateto;
      NewVisits := TGoogleAnalysisReportBaseGUI(ListForm).totalvisits;
    end;
    RefreshData;
  end;
end;

end.

