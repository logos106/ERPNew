unit GoogleAnalytic_Language;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton, StdCtrls,
  AnalyticReport;

type
  TGoogleAnalytic_LanguageGUI = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TGoogleAnalytic_LanguageGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportClassname := 'TGoogleAnalysisReport_LanguageGUI';
  Chartname := 'Google Chart - Language';
  Reprottitle := 'Language';
end;
initialization
  RegisterClassOnce(TGoogleAnalytic_LanguageGUI);

end.

