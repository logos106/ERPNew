unit AnalyticsGoogleSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AnalyticReport, ExtCtrls, Shader, DNMPanel, DNMSpeedButton,
  StdCtrls;

type
  TAnalyticsGoogleSummaryGUI = class(TAnalyticReportGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TAnalyticsGoogleSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  reportclassname := 'TfmAnalyticsSummaryList';
  Chartname := 'ERPOZ';
  Reprottitle := 'Google summary';
end;

initialization
  RegisterClass(TAnalyticsGoogleSummaryGUI);

end.

