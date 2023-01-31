unit frmGoogleAnalytic_Summary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton,
  StdCtrls, AnalyticReport;

type
  TfmGoogleAnalytic_Summary = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TfmGoogleAnalytic_Summary.FormCreate(Sender: TObject);
begin
  inherited;
  reportclassname := 'TfmAnalyticsSummaryList';
  Chartname := 'Google Analytic Summary';
  Reprottitle := 'Google Summary';
end;

initialization
  RegisterClass(TfmGoogleAnalytic_Summary);

end.

