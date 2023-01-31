unit MainDashboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoard, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, SelectionDialog, Menus,
  wwdbdatetimepicker, wwcheckbox, Shader;

type
  TMainDashboardGUI = class(TDashboardGUI)
    HeaderPanel: TPanel;
    lblFrom: TLabel;
    lblTo: TLabel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    chkIgnoreDates: TCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    lblREfreshInfo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
  private
  Protected
    procedure RefreshCaption;
    function DateFrom: TDateTime;override;
    function Dateto: TDateTime;override;
    Procedure MakeCustomizeObj;override;
    procedure RefreshScreen; override;
    Procedure RefreshQuery(const Dashboardform:TComponent);override;
  public

  end;


implementation

uses
  DashBoardObj, CommonLib, AppEnvironment,dateutils, DashboardBase;

{$R *.dfm}

{ TDashboardGUI2 }

procedure TMainDashboardGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  lblRefreshInfo.Visible := true;
   dtFrom.Enabled := not chkIgnoreDates.Checked;
  dtTo.Enabled := not chkIgnoreDates.Checked;
end;

function TMainDashboardGUI.DateFrom: TDateTime;
begin
//  REsult:=   IncDay(AppEnv.CompanyPrefs.ClosingDate);
  Result := dateof(dtFrom.DateTime);
  if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= 0;
end;

function TMainDashboardGUI.Dateto: TDateTime;
begin
//  result:= date;
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
  if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= incyear(Date , 20);
end;

procedure TMainDashboardGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  RefreshScreen;
end;

procedure TMainDashboardGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  lblRefreshInfo.Visible := true;
end;

procedure TMainDashboardGUI.dtToChange(Sender: TObject);
begin
  inherited;
  lblRefreshInfo.Visible := true;
end;

procedure TMainDashboardGUI.FormShow(Sender: TObject);
begin

  (*
  dtFrom.Date := IncDay(AppEnv.CompanyPrefs.ClosingDate);
  dtTo.Date := Date;
  *)
  if appEnv.Employee.ListDaysPast <> 0 then
    dtFrom.Date := Date - appEnv.Employee.ListDaysPast
  else
    dtFrom.Date := IncDay(AppEnv.CompanyPrefs.ClosingDate);

  if appEnv.Employee.ListDaysFuture <> 0 then
    dtTo.Date := Date + appEnv.Employee.ListDaysFuture
  else
    dtTo.Date := Date;


  inherited;
  RefreshCaption;
//  Self.Caption := 'Dashboard  - Reports shown From ' +
//        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, IncDay(AppEnv.CompanyPrefs.ClosingDate)) + ' to ' +
//        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Date);
end;

procedure TMainDashboardGUI.MakeCustomizeObj;
begin
  inherited;
  customiseobj:= TMainDashBoardobj.create(Self, Self.ClassName);
end;
procedure TMainDashboardGUI.RefreshCaption;
begin
  Self.Caption := 'Dashboard  - Reports shown From ' +
        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, DateFrom()) + ' to ' +
        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, DateTo);
end;


procedure TMainDashboardGUI.RefreshQuery(const Dashboardform: TComponent);
begin
  if Dashboardform is TDashBoardBaseGUI then
    TDashBoardBaseGUI(Dashboardform).RefreshQuery(0,  DateFrom, Dateto, chkIgnoreDates.Checked);
  inherited;
end;

procedure TMainDashboardGUI.RefreshScreen;
begin
  lblRefreshInfo.Visible := False;
  RefreshCaption;
  inherited;
end;

initialization
  RegisterClassOnce(TMainDashboardGUI);

end.

