unit GoogleAnalytic_Keyword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton, StdCtrls,
  AnalyticReport;

type
  TGoogleAnalytic_KeywordGUI = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TGoogleAnalytic_KeywordGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportClassname := 'TGoogleAnalysisReport_KeywordGUI';
  Chartname := 'Google Chart - Keyword';
  Reprottitle := 'Keyword';
end;
initialization
  RegisterClassOnce(TGoogleAnalytic_KeywordGUI);

end.

