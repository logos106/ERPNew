unit ProfitnLosschart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitnLosschartBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TProfitnLosschartGUI = class(TProfitnLosschartBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    Function PeriodSumData(FromDate, ToDate:TDateTime;Columnname:String):String;Override;
    Function CharttoView:String;Override;
    procedure Setcharttolaunch(const Value: string); override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, MySQLConst, Dateutils , ReportSQLProfitAndLossPeriod;

{$R *.dfm}

{ TProfitnLosschartGUI }

function TProfitnLosschartGUI.CharttoView: String;
begin
  if grpGraph.itemindex = 0 then Result := 'Gross Profit' else if grpgraph.ItemIndex = 1 then  result := 'Net Income' else REsult:= 'Profit n Loss Chart';

end;

procedure TProfitnLosschartGUI.FormCreate(Sender: TObject);
begin
  fReportSQLObj := TReportSQLProfitAndLossPeriod.Create(Self);
  Tablename := ReportSQLObj.Temptablename ;//'tmp_PLPeriod_' + GetMachineIdentification(true, true, true, true);
  TReportSQLProfitAndLossPeriod(ReportSQLObj).QryBudgets := QryBudgets;
  inherited;
end;

function TProfitnLosschartGUI.PeriodSumData(FromDate, ToDate:TDateTime;Columnname:STring):String;
begin
            REsult:= 'SELECT ' + Quotedstr(Columnname) +' as period,' +
                   ' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +',dateTime)  as dateFrom , ' +
                   ' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , toDate   )) +',dateTime)  as dateto, '+
                   ' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +',dateTime)  as PrevdateFrom , ' +
                   ' convert(' +Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(toDate  ,-1) )) +',dateTime)  as Prevdateto, '+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "EXP" or AccountType  = "EXEXP") ) as Exp ,'+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "INC" or AccountType  = "EXINC") ) as Inc,'+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "COGS")) as Cogs,'+
                   ' (Select sum(TotalAmountEx) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and (AccountType  = "COGS" or AccountType  = "INC" or AccountType  = "EXINC")) as Gross,'+
                   ' (Select sum(TotalAmountEx) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , Fromdate )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , ToDate )) +' and ((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")) as NetIncome,'+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(ToDate,-1) )) +' and (AccountType  = "EXP" or AccountType  = "EXEXP") ) as PrevyrExp ,'+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(ToDate,-1) )) +' and (AccountType  = "INC" or AccountType  = "EXINC") ) as PrevyrInc,'+
                   ' (Select abs(sum(TotalAmountEx)) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(ToDate,-1) )) +' and (AccountType  = "COGS")) as PrevyrCogs,'+
                   ' (Select sum(TotalAmountEx) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(ToDate,-1) )) +' and (AccountType  = "COGS" or AccountType  = "INC" or AccountType  = "EXINC")) as PrevyrGross,'+
                   ' (Select sum(TotalAmountEx) from  ' +TransTableName +' where Date Between ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(Fromdate,-1) )) +' AND  ' + Quotedstr(FormatDateTime(MySQLDateTimeformat , incyear(ToDate,-1) )) +' and ((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")) as PrevyrNetIncome';
end;

procedure TProfitnLosschartGUI.Setcharttolaunch(const Value: string);
begin
  inherited;
  if SameText(Value,'Gross Profit') then
    grpGraph.ItemIndex := 0
  else if SameText(Value,'Net Income') then
    grpGraph.ItemIndex := 1
  else if SameText(Value,'Revenue Chart') or SameText(Value,'Profit n Loss Chart') then
    grpGraph.ItemIndex := 2;

end;

initialization
  RegisterClassOnce(TProfitnLosschartGUI);

end.

