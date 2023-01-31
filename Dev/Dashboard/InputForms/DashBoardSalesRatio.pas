unit DashBoardSalesRatio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardBase, Menus, ExtCtrls, DNMPanel, ComCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, StdCtrls, DBCtrls, Grids, Wwdbigrd, Wwdbgrid,
  wwSpeedButton, wwDBNavigator, wwclearpanel, Mask, SelectionDialog;

type
  TDashBoardSalesRatioGUI = class(TDashBoardBaseGUI)
    qrymain: TERPQuery;
    dsmain: TDataSource;
    MyConnection: TERPConnection;
    pnlEmployee: TDNMPanel;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    tablename :String;
    fIgnoreDates: boolean;
  protected
    property IgnoreDates : boolean read fIgnoreDates write fIgnoreDates;
  public
    Procedure RefreshQuery; override;
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); override;
  end;

implementation

uses CommonLib, frmSalesRatioReportGUI, dateutils, AppEnvironment,
  CommonDbLib, tcConst;

{$R *.dfm}
{ TDashBoardSalesRatioGUI }

procedure TDashBoardSalesRatioGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TDashBoardSalesRatioGUI.RefreshQuery(const EmployeeID: Integer;
  DateFrom, DateTo: TDateTime; ignoreDates: Boolean);
begin
  inherited;
  Self.IgnoreDates := IgnoreDates;
  DtFrom := DateFrom;
  dtTo := DateTo;
end;

procedure TDashBoardSalesRatioGUI.RefreshQuery;
begin
  if IgnoreDates then
    tablename := TfrmSalesRatioReport.PopulateTable(IncDay(AppEnv.CompanyPrefs.ClosingDate) , Date)
  else
    tablename := TfrmSalesRatioReport.PopulateTable(dtFrom, dtTo);
  if Qrymain.active then Qrymain.close;
  qrymain.SQL.clear;
  qrymain.SQL.add('SELECT * from ' +tablename );
  Qrymain.open;
  inherited;
end;

procedure TDashBoardSalesRatioGUI.FormCreate(Sender: TObject);
begin
  inherited;
  MyConnection.Server := CommonDbLib.GetSharedMyDacConnection.Server;
  MyConnection.Username := CommonDbLib.GetSharedMyDacConnection.Username;
  MyConnection.Password := CommonDbLib.GetSharedMyDacConnection.Password;
  MyConnection.Database := CommonDbLib.GetSharedMyDacConnection.Database;
  MyConnection.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  MyConnection.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  MyConnection.connected := true;
  pnlEmployee.Parent := pnlDetails;
  IgnoreDates := false;
end;

initialization
  RegisterClassOnce(TDashBoardSalesRatioGUI);

end.
