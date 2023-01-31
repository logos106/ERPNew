unit TrafficMonitoringSummaryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker,
  //ERP
  MessageConst, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TTrafficMonitoringSummaryGUI = class(TBaseListingGUI)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
  private
    { Private declarations }
//    PrevDateTo: TDateTime;
//    PrevDateFrom: TDateTime;
    SQLString: string;    
    function GetUserTempTrafficSummaryName: string;
    procedure CreateTempTrafficSummaryTable;
    procedure AddDataToTempTrafficSummaryTable;
    procedure DeleteTempTrafficSummaryTable;
    procedure DeleteDataTrafficSummaryTable;


  protected
    procedure RefreshQuery; override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
  public
    { Public declarations }
  end;

var
  TrafficMonitoringSummaryGUI: TTrafficMonitoringSummaryGUI;

implementation

uses FastFuncs,CommonDbLib, CommonLib, MySQLConst;

{$R *.dfm}

{ TTrafficMonitoringSummaryGUI }

procedure TTrafficMonitoringSummaryGUI.RefreshQuery;
var
  PeriodField: string;
  PeriodName: string;
  GroupByField: string;
  OrderByField: string;
begin
  // Mode Number
  //    0 - Day
  //    1 - Weekday
  //    2 - Week
  //    3 - Month
  //    4 - Quarter
  //    5 - Year

  case grpFilters.ItemIndex of
    0: 
      begin {Day}
        PeriodField := 'FilterDate';
        PeriodName := 'Date';
        GroupByField := 'FilterDate';
        OrderByField := 'FilterDate,Hour,Branch';
      end;
    1: 
      begin {Weekday}
        PeriodField := 'FilterWeekday';
        PeriodName := 'Weekday';
        GroupByField := 'FilterWeekdayNumber';
        OrderByField := 'Hour,FilterWeekdayNumber';
      end;
    2: 
      begin {Week}
        PeriodField := 'FilterWeekNumber';
        PeriodName := 'Week Number';
        GroupByField := 'FilterWeekNumber';
        OrderByField := 'Hour,FilterWeekNumber';
      end;
    3: 
      begin {Month}
        PeriodField := 'FilterMonthName';
        PeriodName := 'Month';
        GroupByField := 'FilterMonthNumber';
        OrderByField := 'Hour,FilterMonthNumber';
      end;
    4: 
      begin {Quarter}
        PeriodField := 'FilterQuarterNumber';
        PeriodName := 'Quarter';
        GroupByField := 'FilterQuarterNumber';
        OrderByField := 'Hour,FilterQuarterNumber';
      end;
    5: 
      begin {Year}
        PeriodField := 'FilterYEAR';
        PeriodName := 'Year';
        GroupByField := 'FilterYEAR';
        OrderByField := 'Hour,FilterYEAR';
      end;
  end;
  qryMain.Close;
  qryMain.SQL.Text :=
    'SELECT ' + ' ' + PeriodField + ' as Period, ' + 'Hour,Branch, BranchDescription,Sum(Count) as Count ' +
    'FROM ' + GetUserTempTrafficSummaryName + ' ' + ' GROUP BY ' + GroupByField + ',Branch,Hour ' +
    ' ORDER By ' + OrderByField + ';';
  SQLString := qryMain.SQL.Text;
  inherited;
  qryMain.FieldByName('Period').DisplayLabel := PeriodName;
  RefreshTotals;
end;

procedure TTrafficMonitoringSummaryGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DeleteTempTrafficSummaryTable;
  TrafficMonitoringSummaryGUI := nil;
end;

procedure TTrafficMonitoringSummaryGUI.FormCreate(Sender: TObject);
begin
  //fbIgnoreAccessLevels:=True;
  CreateTempTrafficSummaryTable;
  qryMain.SQL.Text :=
    'SELECT ' + 'Date as Period, ' + 'Hour,Branch, BranchDescription,Sum(Count) as Count ' +
    'FROM ' + GetUserTempTrafficSummaryName + ' ' + ' GROUP BY FilterDate,Branch,Hour ' + ' ORDER By FilterDate;';
  SQLString := qryMain.SQL.Text;
  inherited;
end;

function TTrafficMonitoringSummaryGUI.GetUserTempTrafficSummaryName: string;
begin
  Result := 'tmp_trafficsummary_' + GetMachineIdentification(true, true, true, true);
end;

procedure TTrafficMonitoringSummaryGUI.AddDataToTempTrafficSummaryTable;
var
  InsertSQL: string;
  qryTemp: TERPQuery;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + GetUserTempTrafficSummaryName + ' (Date,Branch,BranchDescription,Recorder,Hour,Count, ' +
    'FilterDate,FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber,FilterMonthName,' +
    'FilterQuarterNumber,FilterYEAR )';

  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    //Data
    DeleteDataTrafficSummaryTable;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add(InsertSQL);
    qryTemp.Sql.Add('SELECT Min(Date) as Date, ');
    qryTemp.Sql.Add('Branch,SiteDesc as BranchDescription, Recorder, Hour, Count,');
    qryTemp.Sql.Add('Date as FilterDate,');
    qryTemp.Sql.Add('DAYNAME(Date) as FilterWeekday,');
    qryTemp.Sql.Add('WEEKDAY(Date) as FilterWeekdayNumber,');
    qryTemp.Sql.Add('WEEK(Date,3)  AS FilterWeekNumber,');
    qryTemp.Sql.Add('MONTH(Date) as FilterMonthNumber,');
    qryTemp.Sql.Add('MONTHNAME(Date) as FilterMonthName,');
    qryTemp.Sql.Add('QUARTER(Date) AS FilterQuarterNumber,');
    qryTemp.Sql.Add('YEAR(Date) AS FilterYEAR ');
    qryTemp.Sql.Add('FROM tbltraffic ');
    qryTemp.Sql.Add('LEFT JOIN tblmsbackendid on SiteCode=Branch ');
    qryTemp.Sql.Add('WHERE Date Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '" ');
    qryTemp.Sql.Add('GROUP BY TrafficID ;');
    //qryTemp.Prepared := true;
    qryTemp.Sql.Text;
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTrafficMonitoringSummaryGUI.CreateTempTrafficSummaryTable;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempTrafficSummaryName + ' ');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + GetUserTempTrafficSummaryName + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`Branch` varchar(255) default NULL,');
    qryTemp.Sql.Add('`BranchDescription` varchar(255) default NULL,');
    qryTemp.Sql.Add('`Recorder` int(11) default NULL,');
    qryTemp.Sql.Add('`Date` date default NULL, ');
    qryTemp.Sql.Add('`Hour` int(11) default NULL,');
    qryTemp.Sql.Add('`Count` int(11) default NULL,');
    qryTemp.Sql.Add('`FilterDate` date default NULL,');
    qryTemp.Sql.Add('`FilterWeekday` varchar(255) default NULL,');
    qryTemp.Sql.Add('`FilterWeekdayNumber` int(11) default NULL,');
    qryTemp.Sql.Add('`FilterWeekNumber` int(11) default NULL,');
    qryTemp.Sql.Add('`FilterMonthNumber` int(11) default NULL,');
    qryTemp.Sql.Add('`FilterMonthName` varchar(255) default NULL,');
    qryTemp.Sql.Add('`FilterQuarterNumber` int(11) default NULL,');
    qryTemp.Sql.Add('`FilterYEAR` int(11) default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`) ');
    qryTemp.Sql.Add(') ENGINE=MyISAM;');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTrafficMonitoringSummaryGUI.DeleteDataTrafficSummaryTable;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + GetUserTempTrafficSummaryName + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTrafficMonitoringSummaryGUI.DeleteTempTrafficSummaryTable;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempTrafficSummaryName + ' ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTrafficMonitoringSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  qryMain.Close;
  case grpFilters.ItemIndex of
    0: 
      begin {Day}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
    1: 
      begin {Weekday}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
    2: 
      begin {Week}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
    3: 
      begin {Month}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
    4: 
      begin {Quarter}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
    5: 
      begin {Year}
        AddDataToTempTrafficSummaryTable;
        qryMain.Active := true;
      end;
  end;
  inherited;
  RefreshQuery;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

//function TTrafficMonitoringSummaryGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtFrom.DateTime = PrevDateFrom) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateFrom := dtFrom.DateTime;
//end;

//function TTrafficMonitoringSummaryGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtTo.DateTime = PrevDateTo) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateTo := dtTo.DateTime;
//end;

procedure TTrafficMonitoringSummaryGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    AddDataToTempTrafficSummaryTable;
    RefreshQuery;
  end;
end;

procedure TTrafficMonitoringSummaryGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
end;

procedure TTrafficMonitoringSummaryGUI.btnCustomizeClick(Sender: TObject);
begin
  inherited;
{TODO :Customise is broken as qrymain's SQL is changed based on the grpFilters's selection}
end;

initialization
  RegisterClassOnce(TTrafficMonitoringSummaryGUI); 
end.
