unit salesDashBoardPnL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardPnL, Menus, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, DashBoardBase;

type
  TsalesDashBoardPnLGUI = class(TDashBoardBaseGUI)
    a3: TLabel;
    bu3: TLabel;
    a2: TLabel;
    bu2: TLabel;
    a1: TLabel;
    bu1: TLabel;
    v3: TLabel;
    v2: TLabel;
    v1: TLabel;
    b3: TLabel;
    b2: TLabel;
    t3: TLabel;
    t2: TLabel;
    t1: TLabel;
    c3: TLabel;
    c2: TLabel;
    c1: TLabel;
    lblTotal: TLabel;
    lblBudget: TLabel;
    lblVariance: TLabel;
    bvl1: TBevel;
    b1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    Labels            :Array [1..3] of array [1..6] of TLabel ;
    Accountnames      :Array [1..3] of string ;
    procedure makeGraph(ctr: Integer; AmountEx, BudgetAmount: Double);
  public
    procedure RefreshQuery; override;
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
  end;


implementation

uses CommonLib, CommonDbLib, MySQLConst, dateutils, FastFuncs, salesAnalysisLib;

{$R *.dfm}
{ TsalesDashBoardPnLGUI }

procedure TsalesDashBoardPnLGUI.RefreshQuery;
begin
  inherited;
end;


procedure TsalesDashBoardPnLGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  Accountnames[1]:='   Income';
  Accountnames[2]:='   COGS';
  Accountnames[3]:='Gross Profit';
  for ctr := 1 to 3 do begin
    Labels[ctr, 1] := TLabel(findcomponent('c'  + Trim(IntToStr(ctr))));
    Labels[ctr, 2] := TLabel(findcomponent('t'  + Trim(IntToStr(ctr))));
    Labels[ctr, 3] := TLabel(findcomponent('b'  + Trim(IntToStr(ctr))));
    Labels[ctr, 4] := TLabel(findcomponent('v'  + Trim(IntToStr(ctr))));
    Labels[ctr, 5] := TLabel(findcomponent('a'  + Trim(IntToStr(ctr))));
    Labels[ctr, 6] := TLabel(findcomponent('bu' + Trim(IntToStr(ctr))));
  end;
end;
procedure TsalesDashBoardPnLGUI.makeGraph(ctr: Integer; AmountEx,  BudgetAmount: Double);
var
  iAmountEx,  iBudgetAmount: integer;
  tot:Integer;
begin
  iAmountEx:= system.round(AmountEx);
  iBudgetAmount := system.round(BudgetAmount);
  tot :=iAmountEx+iBudgetAmount;
  iAmountEx := system.round(iAmountEx*40/tot);
  iBudgetAmount := system.round(iBudgetAmount*40/tot);
  labels[ctr,5].width := 1+iamountEx;
  labels[ctr,6].width := 1+iBudgetAmount;
  if iamountEx < iBudgetAmount then begin
    labels[ctr,5].font.color := clmaroon;
    labels[ctr,5].color := clmaroon;
  end else begin
    labels[ctr,5].font.color := clgreen;
    labels[ctr,5].color := clgreen;
  end;
end;
procedure TsalesDashBoardPnLGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
var
  QryPnL:TERPQuery;
  QryBudget:TERPQuery;
  SaleIDs:String;

  Function Employeefilter:String;
  begin
(*    result:= '';
    if EmployeeId =0 then exit;
    result :=' and T.employeeId = ' + inttostr(EmployeeID);*)
    Result:= ' and saleid in (' + SaleIDs +')';
  end;
begin
    inherited;
    SaleIDs := EmployeeSales(DateFrom , dateTo, EmployeeID);
    if SaleIDs = '' then SaleIDs := '0';
    QryPnL:=  TempMyquery;
    QryBudget:=  TempMyquery;
    try
          QryPnL.SQL.add('           SELECT 1 as finalorder,' + QuotedStr(Accountnames[1])+' as Description ,	' +
                                          ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                          ' sum(CreditsInc - DebitsInc) as "Inc" 	 	' +
                                          ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "EXINC" ,"INC") ) ' +
                                          ' and Date between ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' AND ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo)) +
                                          Employeefilter);
          QryPnL.SQL.add('UNION ALL  SELECT 2 as finalorder,' + QuotedStr(Accountnames[2])+'as Description ,	' +
                                          ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                          ' sum(CreditsInc - DebitsInc) as "Inc" 	 	' +
                                          ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "COGS") ) ' +
                                          'and Date between ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' AND ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo)) +
                                          Employeefilter);
          QryPnL.SQL.add('UNION ALL  SELECT 3 as finalorder,' + QuotedStr(Accountnames[3])+'as Description ,	' +
                                          ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                          ' sum(CreditsInc - DebitsInc) as "Inc" 	 	' +
                                          ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "COGS",  "EXINC" ,"INC") )' +
                                          'and Date between ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' AND ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  +
                                          Employeefilter);
          QryPnL.open;
          Qrybudget.SQL.add(  ' Select sum(TL.Budgetcost) budgetcost, sum(TL.BudgetIncome) budgetincome from tblsalesanalysismanuallines TL inner join tblsalesanalysismanual t on T.Id = TL.SalesAnalysisID ' +
                              ' Where ((T.DateFrom >= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and T.DateFrom <= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ') or ' +
                              '        (T.Dateto   >= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and T.Dateto   <= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ') or ' +
                              '        (T.DateFrom <= ' +Quotedstr(formatdateTime(MySQLDateTimeformat , DateFrom)) + ' and T.Dateto   >= ' + Quotedstr(formatdateTime(MySQLDateTimeformat , DateTo))  + ')) ' );
          if EmployeeID<> 0 then Qrybudget.SQL.add(' and TL.EmployeeID = ' + inttostr(EmployeeID));
          Qrybudget.open;
      if QryPnL.Locate('Description', Accountnames[1] ,[loPartialKey]) then begin
        Labels[1,1].caption := QryPnL.fieldbyname('Description').asString;
        Labels[1,2].caption := floatToStrF(QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);

        Labels[1,3].caption := floatToStrF(Qrybudget.fieldbyname('budgetincome').asfloat, ffCurrency , 15,2);
        Labels[1,4].caption := floatToStrF(Qrybudget.fieldbyname('budgetincome').asfloat - QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);
        makeGraph(1, abs(QryPnL.fieldbyname('Ex').asfloat) , abs(Qrybudget.fieldbyname('budgetincome').asfloat));
      end else begin
        Labels[1,1].visible := False;
        Labels[1,2].visible := False;
        Labels[1,3].visible := False;
        Labels[1,4].visible := False;
      end;
      if QryPnL.Locate('Description', Accountnames[2] ,[loPartialKey]) then begin
        Labels[2,1].caption := QryPnL.fieldbyname('Description').asString;
        Labels[2,2].caption := floatToStrF(QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);

        Labels[2,3].caption := floatToStrF(Qrybudget.fieldbyname('budgetcost').asfloat, ffCurrency , 15,2);
        Labels[2,4].caption := floatToStrF(Qrybudget.fieldbyname('budgetcost').asfloat - QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);
        makeGraph(2, abs(QryPnL.fieldbyname('Ex').asfloat) , abs(Qrybudget.fieldbyname('budgetcost').asfloat));
      end else begin
        Labels[2,1].visible := False;
        Labels[2,2].visible := False;
        Labels[2,3].visible := False;
        Labels[2,4].visible := False;
      end;
      if QryPnL.Locate('Description', Accountnames[3] ,[loPartialKey]) then begin
        Labels[3,1].caption := QryPnL.fieldbyname('Description').asString;
        Labels[3,2].caption := floatToStrF(QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);

        Labels[3,3].caption := floatToStrF(Qrybudget.fieldbyname('budgetincome').asfloat- Qrybudget.fieldbyname('budgetcost').asfloat, ffCurrency , 15,2);
        Labels[3,4].caption := floatToStrF((Qrybudget.fieldbyname('budgetincome').asfloat- Qrybudget.fieldbyname('budgetcost').asfloat) - QryPnL.fieldbyname('Ex').asfloat, ffCurrency , 15,2);
        makeGraph(3, abs(QryPnL.fieldbyname('Ex').asfloat) , Qrybudget.fieldbyname('budgetincome').asfloat- Qrybudget.fieldbyname('budgetcost').asfloat);
      end else begin
        Labels[3,1].visible := False;
        Labels[3,2].visible := False;
        Labels[3,3].visible := False;
        Labels[3,4].visible := False;
      end;
    finally
       Qrypnl.close;
       freeandnil(Qrypnl);
       Qrybudget.close;
       freeandnil(Qrybudget);
    end;
end;

initialization
  RegisterClassOnce(TsalesDashBoardPnLGUI);

end.

