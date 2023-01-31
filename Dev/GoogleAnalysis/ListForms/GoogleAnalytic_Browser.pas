unit GoogleAnalytic_Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton, StdCtrls,
  AnalyticReport;

type
  TGoogleAnalytic_BrowserGUI = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TGoogleAnalytic_BrowserGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportClassname := 'TGoogleAnalysisReport_BrowserGUI';
  Chartname := 'Google Chart - Browser';
  Reprottitle := 'Browser';
end;
initialization
  RegisterClassOnce(TGoogleAnalytic_BrowserGUI);

end.

