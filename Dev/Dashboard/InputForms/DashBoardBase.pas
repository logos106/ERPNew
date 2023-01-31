
unit DashBoardBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMPanel, StdCtrls, Menus, SelectionDialog;

type
  TDashBoardBaseGUI = class(TBaseForm)
    pnlmain: TDNMPanel;
    pnlHeader: TDNMPanel;
    pnlDetails: TDNMPanel;
    Customisemenu: TPopupMenu;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    Seqno:Integer;
    dtFrom, dtTo :TDatetime;
    fiEmployeeID:Integer;
    fbignoreDates :boolean;
    Function AsCurrency(FloatValue:Double):String ;
  public
    Class function EndDate :String;
    Class Function StartDate:String;
    procedure RefreshQuery; overload;Virtual;
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload; Virtual;
    Procedure SetDashboardfilter(const Detailreportform: TComponent); virtual;
  end;
implementation

uses dateUtils, FastFuncs, MySQLConst, AppEnvironment, SalesDashBoardDetails,
  tcConst;

{$R *.dfm}
Function TDashBoardBaseGUI.AsCurrency(FloatValue:Double):String ;
begin
  Result := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, FloatValue);
end;
Class function TDashBoardBaseGUI.EndDate: String;
begin
  (*REsult := QuotedStr(FormatDateTime(MysqlDateFormat, incyear(IncDay(AppEnv.CompanyPrefs.ClosingDate))));*)
  REsult := QuotedStr(FormatDateTime(MysqlDateFormat, Date));
end;

procedure TDashBoardBaseGUI.FormCreate(Sender: TObject);
begin
  dtFrom:=0;
  dtTo:=0;
  fiEmployeeID:= 0;
  inherited;
end;

procedure TDashBoardBaseGUI.SetDashboardfilter(const Detailreportform: TComponent);
begin
  if Detailreportform is TSalesDashBoardDetailsGUI then begin
    TSalesDashBoardDetailsGUI(Detailreportform).dateFrom    := 0;
    TSalesDashBoardDetailsGUI(Detailreportform).DateTo      := dtTo;
    TSalesDashBoardDetailsGUI(Detailreportform).dateFrom    := dtFrom;
    TSalesDashBoardDetailsGUI(Detailreportform).employeeID  := fiEmployeeId;
    TSalesDashBoardDetailsGUI(Detailreportform).ignoreDateRange := fbignoreDates;
    TSalesDashBoardDetailsGUI(Detailreportform).fbDateRangeSupplied:= True;
  end;
end;

Class function TDashBoardBaseGUI.StartDate: String;
begin
  Result :=QuotedStr(FormatDateTime(MysqlDateFormat, IncDay(AppEnv.CompanyPrefs.ClosingDate)));
end;

procedure TDashBoardBaseGUI.RefreshQuery;
begin
  //descendants will override
  DoTranslateFormLanguage;
end;
Procedure TDashBoardBaseGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  dtFrom:= DateFrom;
  dtTo := DateTo;
  fiEmployeeID:= EmployeeId;
  fbIgnoreDates:= ignoreDates;
  DoTranslateFormLanguage;
end;

end.
