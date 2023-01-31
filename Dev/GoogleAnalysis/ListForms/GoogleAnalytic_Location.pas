unit GoogleAnalytic_Location;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalytic_Base, ExtCtrls, Shader, DNMPanel, DNMSpeedButton, StdCtrls,
  AnalyticReport;

type
  TGoogleAnalytic_LocationGUI = class(TGoogleAnalytic_BaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TGoogleAnalytic_LocationGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportClassname := 'TGoogleAnalysisReport_LocationGUI';
  Chartname := 'Google Chart - Location';
  Reprottitle := 'Location';
end;
initialization
  RegisterClassOnce(TGoogleAnalytic_LocationGUI);

end.

