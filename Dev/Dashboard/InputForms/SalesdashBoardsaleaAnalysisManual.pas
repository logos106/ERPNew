unit SalesdashBoardsaleaAnalysisManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardSalesRatio, DB, DBAccess, MyAccess, ERPdbComponents, MemDS,
  Menus, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, wwSpeedButton, wwDBNavigator,
  wwclearpanel, StdCtrls, Mask, DBCtrls, ComCtrls, DNMPanel, DashBoardBase,
  SelectionDialog;

type
  TSalesdashBoardsaleaAnalysisManualGUI = class(TDashBoardBaseGUI)
    qrymain: TERPQuery;
    dsmain: TDataSource;
    DBText1: TDBText;
    lbl1: TLabel;
    DBEdit1: TDBEdit;
    lbl2: TLabel;
    DBEdit2: TDBEdit;
    lbl3: TLabel;
    DBEdit3: TDBEdit;
    lbl4: TLabel;
    DBEdit6: TDBEdit;
    lbl9: TLabel;
    lbl8: TLabel;
    DBEdit9: TDBEdit;
    lbl10: TLabel;
    DBEdit8: TDBEdit;
    bvl1: TBevel;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    lbl7: TLabel;
    DBEdit5: TDBEdit;
    lbl6: TLabel;
    DBEdit4: TDBEdit;
    lbl5: TLabel;
    DBEdit7: TDBEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
  private
    { Private declarations }
  public
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
  end;


implementation

uses CommonLib, MySQLConst, CommonDbLib;

{$R *.dfm}

{ TsalesDashBoardSalesRatioGUI }

procedure TSalesdashBoardsaleaAnalysisManualGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  inherited;
  with qrymain do try
    disablecontrols;
    if active then close;
    connection := GetSharedMyDacConnection;
    SQL.Clear;
    SQL.Add('select EmployeeName, ');
    SQL.Add('sum(coldcalls)     as coldcalls, ');
    SQL.Add('sum(contact)       as contact,');
    SQL.Add('sum(firstdemo)     as firstdemo,');
    SQL.Add('sum(seconddemo)    as seconddemo, ');
    SQL.Add('sum(quotes)        as quotes,');
    SQL.Add('sum(salesorders)   as salesorders,');
    SQL.Add('sum(sales)         as sales,');
    SQL.Add('sum(budgetincome)  as budgetincome ,');
    SQL.Add('sum(budgetcost)    as budgetcost, ');
    SQL.Add('SAL.comments  ');
    SQL.Add('from tblsalesanalysismanuallines SAL inner join tblsalesanalysismanual SA on SA.id = SAL.SalesAnalysisID');
    SQL.Add('Where ((SA.DateFrom >= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and SA.DateFrom <= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ') or ');
    SQL.Add('       (SA.Dateto   >= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and SA.Dateto   <= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ') or ' );
    SQL.Add('       (SA.DateFrom <= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and SA.Dateto   >= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ')) ' );
    if EmployeeId <> 0 then SQL.Add('and SAL.EmployeeId = ' + inttostr(EmployeeID) );
    SQL.Add('       group by SAL.employeeID');
    open;
    wwDBNavigator1.Visible := Qrymain.RecordCount>1;
  finally
    enablecontrols;
  end;
end;

initialization
  RegisterClassOnce(TSalesdashBoardsaleaAnalysisManualGUI);
end.

