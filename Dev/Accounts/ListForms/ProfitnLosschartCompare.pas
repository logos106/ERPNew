unit ProfitnLosschartCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitnLosschartBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TProfitnLosschartCompareGUI = class(TProfitnLosschartBaseGUI)
    qryMainPreviousPeriod: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
  private
    fbformshown:Boolean;
    procedure InitListCaption;
    function ReportFromDate:TDateTime;
    { Private declarations }
  Protected
    Function PeriodSumData(FromDate, ToDate:TDateTime;Columnname:String):String;Override;
    Function CharttoView:String;Override;
    procedure Setcharttolaunch(const Value: string); override;
    function getFilterDateFrom: TDateTime; Override;
    function getFilterdateto: TDateTime; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
  public
    procedure RefreshAll;Override;
    procedure showGraph;Override;
  end;


implementation

uses CommonLib, dateutils, MySQLConst,ReportSQLProfitAndLossPeriod, DNMLib;

{$R *.dfm}
{ TProfitnLosschartCompareGUI }

function TProfitnLosschartCompareGUI.CharttoView: String;
begin
       if grpGraph.itemindex = 0 then Result := 'Gross Profit Comparison'
  else if grpgraph.ItemIndex = 1 then  result := 'Net Income Comparison'
  else REsult:= 'Revenue comparison';
end;

procedure TProfitnLosschartCompareGUI.dtFromChange(Sender: TObject);
begin
  inherited;
 (* if (sender = dtFrom) and (Screen.ActiveControl = dtFrom) then
         if grpFilters.itemindex = 2 then dtFrom.Date := StartOfTheYear(dtFrom.Date)
    else if grpFilters.itemindex = 1 then dtFrom.Date := StartOfTheQuarter(dtFrom.Date)
    else if grpFilters.itemindex = 0 then dtFrom.Date := StartOfTheMonth(dtFrom.Date);*)
end;

procedure TProfitnLosschartCompareGUI.dtToChange(Sender: TObject);
begin
  inherited;
  (*if (sender = dtTo) and (Screen.ActiveControl = dtTo) then
         if grpFilters.itemindex = 2 then dtTo.Date := EndOfTheYear(dtTo.Date)
    else if grpFilters.itemindex = 1 then dtTo.Date := EndOfTheQuarter(dtTo.Date)
    else if grpFilters.itemindex = 0 then dtTo.Date := EndOfTheMonth(dtTo.Date);*)
end;

procedure TProfitnLosschartCompareGUI.FormCreate(Sender: TObject);
begin
  InitListCaption;
  fbformshown:= False;
  fReportSQLObj := TReportSQLProfitAndLossPeriodCompare.Create(Self);
  Tablename := ReportSQLObj.Temptablename ;
  inherited;

end;

procedure TProfitnLosschartCompareGUI.FormShow(Sender: TObject);
begin
  inherited;
  InitListCaption;
  fbformshown:=True;
end;

function TProfitnLosschartCompareGUI.getFilterDateFrom: TDateTime;
begin
  result := inherited getFilterDateFrom;
  if result <> 0 then result := incyear(result , -1); // this is to get the previous yr data
(*       if grpFilters.itemindex = 2 then Result := StartOfTheYear(REsult)
  else if grpFilters.itemindex = 1 then Result := StartOfTheQuarter(result)
  else if grpFilters.itemindex = 0 then Result := StartOfTheMonth(result);*)
end;

function TProfitnLosschartCompareGUI.getFilterdateto: TDateTime;
begin
  result := inherited getFilterdateto;
(*       if grpFilters.itemindex = 2 then Result := EndOfTheYear(REsult)
  else if grpFilters.itemindex = 1 then Result := EndOfTheQuarter(result)
  else if grpFilters.itemindex = 0 then Result := EndOfTheMonth(result);*)
end;

procedure TProfitnLosschartCompareGUI.grpFiltersClick(Sender: TObject);
begin
  lblREfreshInfo.visible := False;
  inherited;
  lblREfreshInfo.visible := False;
  if fbformshown then begin
    RefreshAll;
  end;
  InitListCaption;
end;
procedure TProfitnLosschartCompareGUI.InitListCaption;
var
  s:String;
begin

  s:= '';
       if (grpFilters.ItemIndex =0) and (grpGraph.itemindex =0) then s:= 'Monthly Gross Profit Comparison'
  else if (grpFilters.ItemIndex =0) and (grpGraph.itemindex =1) then s:= 'Monthly Net Income Comparison'
  else if (grpFilters.ItemIndex =0) and (grpGraph.itemindex =2) then s:= 'Monthly Revenue Comparison'
  else if (grpFilters.ItemIndex =1) and (grpGraph.itemindex =0) then s:= 'Quarterly Gross Profit Comparison'
  else if (grpFilters.ItemIndex =1) and (grpGraph.itemindex =1) then s:= 'Quarterly Net Income Comparison'
  else if (grpFilters.ItemIndex =1) and (grpGraph.itemindex =2) then s:= 'Quarterly Revenue Comparison'
  else if (grpFilters.ItemIndex =2) and (grpGraph.itemindex =0) then s:= 'Yearly Gross Profit Comparison'
  else if (grpFilters.ItemIndex =2) and (grpGraph.itemindex =1) then s:= 'Yearly Net Income Comparison'
  else if (grpFilters.ItemIndex =2) and (grpGraph.itemindex =2) then s:= 'Yearly Revenue Comparison';
  if s<> '' then begin
    s:= dotranslate(s);
    TitleLabel.caption := s;
    Self.caption := s;
  end;
end;



function TProfitnLosschartCompareGUI.PeriodSumData(FromDate, ToDate: TDateTime; Columnname: String): String;
var
  fdPrevdateFrom, fdPrevdateTo:TDateTime;

function PrevPeriod(const Dt:TDatetime):TDateTime;
begin
       (*if grpFilters.ItemIndex =0 then result := incmonth(Dt, -1)
  else if grpFilters.ItemIndex =1 then result := IncQuarter(Dt, -1)
  else result := incyear(Dt, -1);*)
  result :=incyear(Dt, -1);
end;
Function ThisPeriod:STring;
begin
  result := 'Current Year';
  Exit;
       if grpFilters.ItemIndex =0 then result := 'This Month' //GetMonthName(MonthOfTheYear(FromDate)) + '(' +IntToStr(YearOf(FromDate)) + ')'
  else if grpFilters.ItemIndex =1 then result := 'This Quarter'//'Quarter'+' '+ IntToStr(QuarterOf(FromDate)) + '(' +IntToStr(YearOf(FromDate)) + ')'
  else result := 'This Year' ;//'Year'+' - ' +IntToStr(YearOf(FromDate));
end;
Function PreviousPeriod:STring;
begin
  REsult:= 'Previous Year';
  exit;
       if grpFilters.ItemIndex =0 then result := 'Previous Month' //GetMonthName(MonthOfTheYear(PrevPeriod(fromDate))) + '(' +IntToStr(YearOf(PrevPeriod(fromDate))) + ')'
  else if grpFilters.ItemIndex =1 then result := 'Previous Quarter' //'Quarter'+' '+ IntToStr(QuarterOf(PrevPeriod(fromDate))) + '(' +IntToStr(YearOf(PrevPeriod(fromDate))) + ')'
  else result := 'Year'+' - ' +IntToStr(YearOf(PrevPeriod(fromDate)));

end;
Function PreviouscolumnName:String;
begin
      if grpFilters.ItemIndex =0 then
        result := dotranslate(GetMonthName(MonthOfTheYear(incyear(FromDate,-1)))) + '(' +IntToStr(YearOf(incyear(FromDate,-1))) + ')'
      else if grpFilters.ItemIndex = 1 then
        result := dotranslate('Quarter')+' '+ IntToStr(QuarterOf(incyear(FromDate,-1))) + '(' +IntToStr(YearOf(incyear(FromDate,-1))) + ')'
      else if grpFilters.ItemIndex =  2 then
        result := dotranslate('Year')+' - ' +IntToStr(YearOf(incyear(FromDate,-1)));
end;

begin
            result:= '';

            if (fromdate < (reportFromDate)) and (todate <reportFromDate) then exit;

            fdPrevdateFrom := PrevPeriod(Fromdate);
            fdPrevdateTo   := PrevPeriod(todate);

            REsult:= 'SELECT ' + Quotedstr(Columnname) +' as period,' ;
            REsult:= Result + Quotedstr(PreviouscolumnName) +' as PreviousPeriod, ' ;
            REsult:= Result +' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +',dateTime)  as dateFrom , ' ;
            REsult:= Result +' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , toDate   )) +',dateTime)  as dateto, ';

            REsult:= Result +' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +',dateTime)  as PrevdateFrom , ' ;
            REsult:= Result +' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , PrevPeriod(Todate  ) )) +',dateTime)  as Prevdateto, ';

            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "EXP" or AccountType  = "EXEXP") ) as Exp ,';
            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "INC" or AccountType  = "EXINC") ) as Inc,';
            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "COGS")) as Cogs,';
            REsult:= Result +' (Select sum(TotalAmountEx)      from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "COGS" or AccountType  = "INC" or AccountType  = "EXINC")) as Gross,';
            REsult:= Result +' (Select sum(TotalAmountEx)      from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and ((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")) as NetIncome,';

            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateTo )) +' and (AccountType  = "EXP" or AccountType  = "EXEXP") ) as PrevyrExp ,';
            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateTo )) +' and (AccountType  = "INC" or AccountType  = "EXINC") ) as PrevyrInc,';
            REsult:= Result +' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateTo )) +' and (AccountType  = "COGS")) as PrevyrCogs,';
            REsult:= Result +' (Select sum(TotalAmountEx)      from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateTo )) +' and (AccountType  = "COGS" or AccountType  = "INC" or AccountType  = "EXINC")) as PrevyrGross,';
            REsult:= Result +' (Select sum(TotalAmountEx)      from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateFrom )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , fdPrevdateTo )) +' and ((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")) as PrevyrNetIncome';
  FieldList := TStringList.Create;
  try
    AddGridSelectedfield(Qrymainperiod.fieldname , 15, Qrymainperiod.Displaylabel);
    AddGridSelectedfield(QrymainExp.Fieldname , 15 , ThisPeriod , 'Expenses');
    AddGridSelectedfield(QrymainPrevyrExp.Fieldname , 15 , PreviousPeriod , 'Expenses');

    AddGridSelectedfield(QrymainInc.Fieldname , 15 , ThisPeriod , 'Income');
    AddGridSelectedfield(QrymainPrevyrInc.Fieldname , 15 , PreviousPeriod , 'Income');

    AddGridSelectedfield(QrymainCogs.Fieldname , 15 , ThisPeriod , 'COGS');
    AddGridSelectedfield(QrymainPrevyrCogs.Fieldname , 15 , PreviousPeriod , 'COGS');

    AddGridSelectedfield(QrymainGross.Fieldname , 15 , ThisPeriod , 'Gross');
    AddGridSelectedfield(QrymainPrevyrGross.Fieldname , 15 , PreviousPeriod , 'Gross');

    AddGridSelectedfield(QrymainNetIncome.Fieldname , 15 , ThisPeriod , 'Net Income');
    AddGridSelectedfield(QrymainPrevyrNetIncome.Fieldname , 15 , PreviousPeriod , 'Net Income');

    grdMain.Selected := FieldList;
    grdMain.ApplySelected;


  finally
    FreeandNil(FieldList);
  end;

end;

procedure TProfitnLosschartCompareGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkIncludehistory.checked := TRue;
end;

procedure TProfitnLosschartCompareGUI.RefreshAll;
begin
  inherited;
end;

function TProfitnLosschartCompareGUI.ReportFromDate: TDateTime;
begin
  result:= inherited getFilterDateFrom;
(*       if grpFilters.itemindex = 2 then Result := StartOfTheYear(REsult)
  else if grpFilters.itemindex = 1 then Result := StartOfTheQuarter(result)
  else if grpFilters.itemindex = 0 then Result := StartOfTheMonth(result);*)
end;

procedure TProfitnLosschartCompareGUI.Setcharttolaunch(const Value: string);
begin
  inherited;
  InitListCaption;
end;

procedure TProfitnLosschartCompareGUI.showGraph;
begin
  inherited;
  if sametext(charttolaunch , 'Gross Profit Comparison')  or sametext(charttolaunch , 'Net Income Comparison') or sametext(charttolaunch,'Revenue comparison')   then  begin
    fbShowgrpGraph:= True;
  end;
  grpGraph.Visible := fbShowgrpGraph ;

end;

initialization
  RegisterClassOnce(TProfitnLosschartCompareGUI);

end.

