unit GoogleAnalytic_DayofWeek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton, StdCtrls,
  AnalyticReport;

type
  TGoogleAnalytic_DayofWeekGUI = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TGoogleAnalytic_DayofWeekGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportClassname := 'TGoogleAnalysisReport_DayofWeekGUI';
  Chartname := 'Google Chart - Day of the Week';
  Reprottitle := 'Day of the Week';
end;
initialization
  RegisterClassOnce(TGoogleAnalytic_DayofWeekGUI);

end.

