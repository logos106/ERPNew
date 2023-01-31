unit SalesDashboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoard, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, wwdblook, wwdbdatetimepicker, Shader,
  Menus, SelectionDialog;

type
  TSalesDashboardGUI = class(TDashboardGUI)
    qryEmployees: TERPQuery;
    DNMPanel2: TDNMPanel;
    dtTo: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblFrom: TLabel;
    Bevel1: TBevel;
    cboEmployee: TwwDBLookupCombo;
    chkAllEmployees: TCheckBox;
    Bevel2: TBevel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkIgnoreDates: TCheckBox;
    btnRequery: TDNMSpeedButton;
    lblREfreshInfo: TLabel;
    procedure btnRequeryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboEmployeeChange(Sender: TObject);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
  private
    function EmployeeID: Integer;

  Protected
    function DateFrom: TDateTime;override;
    function Dateto: TDateTime;override;
    Procedure MakeCustomizeObj;override;
    Procedure RefreshQuery(const Dashboardform:TComponent);override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure RefreshScreen; override;

  public
    { Public declarations }
  end;


implementation

uses DashBoardObj, Commonlib,systemlib, AppEnvironment, dateutils,
  DashBoardBase, MySQLConst, XMLFuncLib;

{$R *.dfm}

{ TDashboardGUI1 }

procedure TSalesDashboardGUI.MakeCustomizeObj;
begin
  inherited;
  customiseobj:= TSalesDashBoardobj.create(Self, Self.ClassName);
end;
procedure TSalesDashboardGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
//  dt:TDateTime;
begin
(*  chkIgnoreDates.checked  :=  TSalesDashBoardobj(customiseobj).Ignoredate;
  chkAllEmployees.checked :=  TSalesDashBoardobj(customiseobj).Allemployees;*)
  if GuiPrefs.Node.Exists('Options.IgnoreDates') then
    chkIgnoreDates.checked := GuiPrefs.Node['Options.IgnoreDates'].asBoolean
  else chkIgnoreDates.checked  :=  TSalesDashBoardobj(customiseobj).Ignoredate;

  if GuiPrefs.Node.Exists('Options.AllEmployees') then
    chkAllEmployees.checked := GuiPrefs.Node['Options.AllEmployees'].asBoolean
  else chkAllEmployees.checked :=  TSalesDashBoardobj(customiseobj).Allemployees;

  x := TSalesDashBoardobj(customiseobj).employeeId;
  if x<> 0 then
    Qryemployees.Locate('EmployeeID' , x , [])
  else if chkAllEmployees.checked = False then
    Qryemployees.Locate('EmployeeID' , Appenv.Employee.EmployeeID , []);
  cboEmployee.Text := Qryemployees.fieldbyname('employeename').asString;
  (*
  dt:=TSalesDashBoardobj(customiseobj).DateFrom;
  if dt<> 0 then dtFrom.date := dt else if appEnv.Employee.ListDaysPast <> 0 then   dtFrom.Date := Date - appEnv.Employee.ListDaysPast;

  dt:=TSalesDashBoardobj(customiseobj).Dateto;
  if dt<> 0 then dtTo.Date := dt else if appEnv.Employee.ListDaysFuture <> 0 then   dtTo.Date :=  Date + appEnv.Employee.ListDaysFuture;
  *)

  if appEnv.Employee.ListDaysPast <> 0 then
    dtFrom.Date := Date - appEnv.Employee.ListDaysPast
  else if TSalesDashBoardobj(customiseobj).DateFrom <> 0 then
    dtFrom.Date := TSalesDashBoardobj(customiseobj).DateFrom
  else
    dtFrom.Date := Date - 358;

  if appEnv.Employee.ListDaysFuture <> 0 then
    dtTo.Date := Date + appEnv.Employee.ListDaysFuture
  else if TSalesDashBoardobj(customiseobj).DateTo <> 0 then
    dtTo.Date := TSalesDashBoardobj(customiseobj).DateTo
  else
    dtTo.Date := Date + 7;

  if GuiPrefs.Node.Exists('Options.DateFrom') then
    dtFrom.Date :=  GuiPrefs.Node['Options.DateFrom'].asDatetime;

  if GuiPrefs.Node.Exists('Options.DateTo') then
    dtTo.Date :=  GuiPrefs.Node['Options.DateTo'].asDatetime;

  if dtFrom.Date> dtTo.Date then
    dtFrom.Date := dtTo.Date - appEnv.Employee.ListDaysPast;

  TSalesDashBoardobj(customiseobj).DateFrom := dtFrom.Date;
  TSalesDashBoardobj(customiseobj).DateTo := dtTo.Date;

end;

procedure TSalesDashboardGUI.RefreshQuery(const Dashboardform: TComponent);
begin
  if Dashboardform is TDashBoardBaseGUI then TDashBoardBaseGUI(Dashboardform).RefreshQuery(EmployeeID, DateFrom, Dateto, chkIgnoreDates.Checked);
end;
procedure TSalesDashboardGUI.RefreshScreen;
begin
  inherited;
  //shapehint.Visible := False;
   lblREfreshInfo.Visible := False;
end;


procedure TSalesDashboardGUI.WriteGuiPrefExtra;
begin
  customiseobj.ExtraPrefXML := '<Options>' +
                               '<Ignoredate>'      + booleanToStr(chkIgnoreDates.checked)                       + '</Ignoredate>' +
                               '<Allemployees>'    + booleanToStr(chkAllEmployees.checked)                      + '</Allemployees>' +
                               '<employeeId>'      + inttostr(Qryemployees.FieldByname('EmployeeID').asInteger) + '</employeeId>' +
                               '<DateFrom>'        + ReplaceNonAlphaNumeric(dateTostr(dtFrom.DateTime))         + '</DateFrom>'+
                               '<Dateto>'          + ReplaceNonAlphaNumeric(dateTostr(dtTo.DateTime))           + '</Dateto>' +
                               '</Options>';

    GuiPrefs.Node['Options.DateFrom'].asDatetime := dtFrom.Date;
    GuiPrefs.Node['Options.DateTo'].asDatetime := dtTo.Date;
    GuiPrefs.Node['Options.IgnoreDates'].asBoolean := chkIgnoreDates.checked;
    GuiPrefs.Node['Options.AllEmployees'].asBoolean := chkAllEmployees.checked;
end;

Function TSalesDashboardGUI.EmployeeID:Integer;
begin
  if chkAllEmployees.checked then result := 0
  else result:=  qryEmployees.FieldByName('EmployeeID').AsInteger;
end;

procedure TSalesDashboardGUI.FormCreate(Sender: TObject);
begin
  inherited;
  dtTo.Date   := Date;
  dtFrom.Date := Date - appenv.employee.ListDaysPast;
end;

procedure TSalesDashboardGUI.btnRequeryClick(Sender: TObject);
begin
  inherited;
  RefreshScreen;
end;


Function TSalesDashboardGUI.DateFrom:TDateTime;
begin
  Result := dateof(dtFrom.DateTime);
  if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= 0;
end;
Function TSalesDashboardGUI.Dateto:TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
  if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= incyear(Date , 20);
end;
procedure TSalesDashboardGUI.dtFromChange         (Sender: TObject);
begin
  inherited;
  lblREfreshInfo.Visible := True; (*HighlightControl(btnRequery);*)
end;
procedure TSalesDashboardGUI.dtToChange           (Sender: TObject);begin  inherited; lblREfreshInfo.Visible := True; (*HighlightControl(btnRequery);*)end;
procedure TSalesDashboardGUI.cboEmployeeChange    (Sender: TObject);begin  inherited; lblREfreshInfo.Visible := True; (*HighlightControl(btnRequery);*)end;
procedure TSalesDashboardGUI.chkAllEmployeesClick (Sender: TObject);begin  inherited; lblREfreshInfo.Visible := True; (*HighlightControl(btnRequery);*)end;
procedure TSalesDashboardGUI.chkIgnoreDatesClick  (Sender: TObject);
begin
  inherited;
  lblREfreshInfo.Visible := True; (*HighlightControl(btnRequery);*)
  dtFrom.Enabled := not chkIgnoreDates.Checked;
  dtTo.Enabled := not chkIgnoreDates.Checked;
end;

initialization
  RegisterClassOnce(TSalesDashboardGUI);

end.

