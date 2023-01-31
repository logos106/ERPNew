unit SalesSummaryReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdbdatetimepicker, MyAccess,ERPdbComponents,
  MemDS, DBAccess,
  MessageConst, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TSalesSummaryReportGUI = class(TBaseListingGUI)
    qryMainPeriod: TWideStringField;
    qryMainCostAmount1: TFloatField;
    qryMainSoldAmount1: TFloatField;
    qryMainSoldAmountEx1: TFloatField;
    qryMainSaleTax1: TFloatField;
    qryMainCostAmount2: TFloatField;
    qryMainSoldAmount2: TFloatField;
    qryMainSoldAmountEx2: TFloatField;
    qryMainSaleTax2: TFloatField;
    qryMainCostAmount3: TFloatField;
    qryMainSoldAmount3: TFloatField;
    qryMainSoldAmountEx3: TFloatField;
    qryMainSaleTax3: TFloatField;
    qryMainCostAmount4: TFloatField;
    qryMainSoldAmount4: TFloatField;
    qryMainSoldAmountEx4: TFloatField;
    qryMainSaleTax4: TFloatField;
    qryMainCostAmount5: TFloatField;
    qryMainSoldAmount5: TFloatField;
    qryMainSoldAmountEx5: TFloatField;
    qryMainSaleTax5: TFloatField;
    qryMainCostAmount6: TFloatField;
    qryMainSoldAmount6: TFloatField;
    qryMainSoldAmountEx6: TFloatField;
    qryMainSaleTax6: TFloatField;
    qryMainCostAmount7: TFloatField;
    qryMainSoldAmount7: TFloatField;
    qryMainSoldAmountEx7: TFloatField;
    qryMainSaleTax7: TFloatField;
    qryMainCostAmount8: TFloatField;
    qryMainSoldAmount8: TFloatField;
    qryMainSoldAmountEx8: TFloatField;
    qryMainSaleTax8: TFloatField;
    qryMainCostAmount9: TFloatField;
    qryMainSoldAmount9: TFloatField;
    qryMainSoldAmountEx9: TFloatField;
    qryMainSaleTax9: TFloatField;
    qryMainCostAmount10: TFloatField;
    qryMainSoldAmount10: TFloatField;
    qryMainSoldAmountEx10: TFloatField;
    qryMainSaleTax10: TFloatField;
    qryMainCostAmount11: TFloatField;
    qryMainSoldAmount11: TFloatField;
    qryMainSoldAmountEx11: TFloatField;
    qryMainSaleTax11: TFloatField;
    qryMainCostAmount12: TFloatField;
    qryMainSoldAmount12: TFloatField;
    qryMainSoldAmountEx12: TFloatField;
    qryMainSaleTax12: TFloatField;
    qryMainCostAmount13: TFloatField;
    qryMainSoldAmount13: TFloatField;
    qryMainSoldAmountEx13: TFloatField;
    qryMainSaleTax13: TFloatField;
    qryMainCostAmount14: TFloatField;
    qryMainSoldAmount14: TFloatField;
    qryMainSoldAmountEx14: TFloatField;
    qryMainSaleTax14: TFloatField;
    qryMainCostAmount15: TFloatField;
    qryMainSoldAmount15: TFloatField;
    qryMainSoldAmountEx15: TFloatField;
    qryMainSaleTax15: TFloatField;
    qryMainCostAmount16: TFloatField;
    qryMainSoldAmount16: TFloatField;
    qryMainSoldAmountEx16: TFloatField;
    qryMainSaleTax16: TFloatField;
    qryMainCostAmount17: TFloatField;
    qryMainSoldAmount17: TFloatField;
    qryMainSoldAmountEx17: TFloatField;
    qryMainSaleTax17: TFloatField;
    qryMainCostAmount18: TFloatField;
    qryMainSoldAmount18: TFloatField;
    qryMainSoldAmountEx18: TFloatField;
    qryMainSaleTax18: TFloatField;
    qryMainCostAmount19: TFloatField;
    qryMainSoldAmount19: TFloatField;
    qryMainSoldAmountEx19: TFloatField;
    qryMainSaleTax19: TFloatField;
    qryMainCostAmount20: TFloatField;
    qryMainSoldAmount20: TFloatField;
    qryMainSoldAmountEx20: TFloatField;
    qryMainSaleTax20: TFloatField;
    qryMainCostAmount21: TFloatField;
    qryMainSoldAmount21: TFloatField;
    qryMainSoldAmountEx21: TFloatField;
    qryMainSaleTax21: TFloatField;
    qryMainCostAmount22: TFloatField;
    qryMainSoldAmount22: TFloatField;
    qryMainSoldAmountEx22: TFloatField;
    qryMainSaleTax22: TFloatField;
    qryMainCostAmount23: TFloatField;
    qryMainSoldAmount23: TFloatField;
    qryMainSoldAmountEx23: TFloatField;
    qryMainSaleTax23: TFloatField;
    qryMainCostAmount24: TFloatField;
    qryMainSoldAmount24: TFloatField;
    qryMainSoldAmountEx24: TFloatField;
    qryMainSaleTax24: TFloatField;
    qryMainCostAmount25: TFloatField;
    qryMainSoldAmount25: TFloatField;
    qryMainSoldAmountEx25: TFloatField;
    qryMainSaleTax25: TFloatField;
    qryMainCostAmount26: TFloatField;
    qryMainSoldAmount26: TFloatField;
    qryMainSoldAmountEx26: TFloatField;
    qryMainSaleTax26: TFloatField;
    qryMainCostAmount27: TFloatField;
    qryMainSoldAmount27: TFloatField;
    qryMainSoldAmountEx27: TFloatField;
    qryMainSaleTax27: TFloatField;
    qryMainCostAmount28: TFloatField;
    qryMainSoldAmount28: TFloatField;
    qryMainSoldAmountEx28: TFloatField;
    qryMainSaleTax28: TFloatField;
    qryMainCostAmount29: TFloatField;
    qryMainSoldAmount29: TFloatField;
    qryMainSoldAmountEx29: TFloatField;
    qryMainSaleTax29: TFloatField;
    qryMainCostAmount30: TFloatField;
    qryMainSoldAmount30: TFloatField;
    qryMainSoldAmountEx30: TFloatField;
    qryMainSaleTax30: TFloatField;
    qryMainCostAmount31: TFloatField;
    qryMainSoldAmount31: TFloatField;
    qryMainSoldAmountEx31: TFloatField;
    qryMainSaleTax31: TFloatField;
    qryMainCostAmount32: TFloatField;
    qryMainSoldAmount32: TFloatField;
    qryMainSoldAmountEx32: TFloatField;
    qryMainSaleTax32: TFloatField;
    qryMainCostAmount33: TFloatField;
    qryMainSoldAmount33: TFloatField;
    qryMainSoldAmountEx33: TFloatField;
    qryMainSaleTax33: TFloatField;
    qryMainCostAmount34: TFloatField;
    qryMainSoldAmount34: TFloatField;
    qryMainSoldAmountEx34: TFloatField;
    qryMainSaleTax34: TFloatField;
    qryMainCostAmount35: TFloatField;
    qryMainSoldAmount35: TFloatField;
    qryMainSoldAmountEx35: TFloatField;
    qryMainSaleTax35: TFloatField;
    qryMainCostAmount36: TFloatField;
    qryMainSoldAmount36: TFloatField;
    qryMainSoldAmountEx36: TFloatField;
    qryMainSaleTax36: TFloatField;
    qryMainCostAmount37: TFloatField;
    qryMainSoldAmount37: TFloatField;
    qryMainSoldAmountEx37: TFloatField;
    qryMainSaleTax37: TFloatField;
    qryMainCostAmount38: TFloatField;
    qryMainSoldAmount38: TFloatField;
    qryMainSoldAmountEx38: TFloatField;
    qryMainSaleTax38: TFloatField;
    qryMainCostAmount39: TFloatField;
    qryMainSoldAmount39: TFloatField;
    qryMainSoldAmountEx39: TFloatField;
    qryMainSaleTax39: TFloatField;
    qryMainCostAmount40: TFloatField;
    qryMainSoldAmount40: TFloatField;
    qryMainSoldAmountEx40: TFloatField;
    qryMainSaleTax40: TFloatField;
    qryMainTotalCostAmount: TFloatField;
    qryMainTotalSoldAmount: TFloatField;
    qryMainTotalSoldAmountEx: TFloatField;
    qryMainTotalSaleTax: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
//    PrevDateTo: TDateTime;
//    PrevDateFrom: TDateTime;
    SQLString: string;
    Tablename :String;
    PeriodName: string;
    (* function GetUserTempSaleSummaryName: string; *)
    procedure CreateTempSaleSummaryTable;
    procedure AddDataToTempSaleSummaryTable;
    procedure DeleteTempSaleSummaryTable;
    procedure DeleteDataSaleSummaryTable;
    procedure ClassLabelChange;
    procedure initFooterCalcfields;
    procedure PopulateQrymain;



  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
  public
    { Public declarations }
    property ChartSQL: string read SQLString write SQLString;
  end;

implementation

uses FastFuncs,CommonDbLib, TransactionsTable, DNMLib, CommonLib, MySQLConst;

{$R *.dfm}

procedure TSalesSummaryReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DeleteTempSaleSummaryTable;
end;

procedure TSalesSummaryReportGUI.grpFiltersClick(Sender: TObject);
begin
  qryMain.Close;
  (* case grpFilters.ItemIndex of
    0:
      begin {Day}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
    1:
      begin {Weekday}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
    2:
      begin {Week}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
    3:
      begin {Month}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
    4:
      begin {Quarter}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
    5:
      begin {Year}
        AddDataToTempSaleSummaryTable;
        qryMain.Active := true;
      end;
  end; *)
  AddDataToTempSaleSummaryTable;
  inherited;
  RefreshQuery;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TSalesSummaryReportGUI.DeleteTempSaleSummaryTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + Tablename + ' ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

(* function TSalesSummaryReportGUI.GetUserTempSaleSummaryName: string;
begin
  Result := 'tmp_SalesSummary_' + GetMachineIdentification(true, true, true, true);
end; *)

procedure TSalesSummaryReportGUI.CreateTempSaleSummaryTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + Tablename + ' ');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + Tablename + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`Date` date default NULL, ');
    qryTemp.Sql.Add('`CostAmount1` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount1` double default NULL,');
    qryTemp.Sql.Add('`CostAmount2` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount2` double default NULL,');
    qryTemp.Sql.Add('`CostAmount3` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount3` double default NULL,');
    qryTemp.Sql.Add('`CostAmount4` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount4` double default NULL,');
    qryTemp.Sql.Add('`CostAmount5` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount5` double default NULL,');
    qryTemp.Sql.Add('`CostAmount6` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount6` double default NULL,');
    qryTemp.Sql.Add('`CostAmount7` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount7` double default NULL,');
    qryTemp.Sql.Add('`CostAmount8` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount8` double default NULL,');
    qryTemp.Sql.Add('`CostAmount9` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount9` double default NULL,');
    qryTemp.Sql.Add('`CostAmount10` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount10` double default NULL,');
    qryTemp.Sql.Add('`CostAmount11` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount11` double default NULL,');
    qryTemp.Sql.Add('`CostAmount12` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount12` double default NULL,');
    qryTemp.Sql.Add('`CostAmount13` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount13` double default NULL,');
    qryTemp.Sql.Add('`CostAmount14` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount14` double default NULL,');
    qryTemp.Sql.Add('`CostAmount15` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount15` double default NULL,');
    qryTemp.Sql.Add('`CostAmount16` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount16` double default NULL,');
    qryTemp.Sql.Add('`CostAmount17` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount17` double default NULL,');
    qryTemp.Sql.Add('`CostAmount18` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount18` double default NULL,');
    qryTemp.Sql.Add('`CostAmount19` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount19` double default NULL,');
    qryTemp.Sql.Add('`CostAmount20` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount20` double default NULL,');
    qryTemp.Sql.Add('`CostAmount21` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount21` double default NULL,');
    qryTemp.Sql.Add('`CostAmount22` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount22` double default NULL,');
    qryTemp.Sql.Add('`CostAmount23` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount23` double default NULL,');
    qryTemp.Sql.Add('`CostAmount24` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount24` double default NULL,');
    qryTemp.Sql.Add('`CostAmount25` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount25` double default NULL,');
    qryTemp.Sql.Add('`CostAmount26` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount26` double default NULL,');
    qryTemp.Sql.Add('`CostAmount27` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount27` double default NULL,');
    qryTemp.Sql.Add('`CostAmount28` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount28` double default NULL,');
    qryTemp.Sql.Add('`CostAmount29` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount29` double default NULL,');
    qryTemp.Sql.Add('`CostAmount30` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount30` double default NULL,');
    qryTemp.Sql.Add('`CostAmount31` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount31` double default NULL,');
    qryTemp.Sql.Add('`CostAmount32` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount32` double default NULL,');
    qryTemp.Sql.Add('`CostAmount33` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount33` double default NULL,');
    qryTemp.Sql.Add('`CostAmount34` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount34` double default NULL,');
    qryTemp.Sql.Add('`CostAmount35` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount35` double default NULL,');
    qryTemp.Sql.Add('`CostAmount36` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount36` double default NULL,');
    qryTemp.Sql.Add('`CostAmount37` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount37` double default NULL,');
    qryTemp.Sql.Add('`CostAmount38` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount38` double default NULL,');
    qryTemp.Sql.Add('`CostAmount39` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount39` double default NULL,');
    qryTemp.Sql.Add('`CostAmount40` double default NULL,');
    qryTemp.Sql.Add('`SoldAmount40` double default NULL,');
    qryTemp.Sql.Add('`TotalCostAmount` double default NULL,');
    qryTemp.Sql.Add('`TotalSoldAmount` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx1` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx10` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx11` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx12` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx13` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx14` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx15` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx16` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx17` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx18` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx19` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx2` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx20` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx21` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx22` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx23` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx24` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx25` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx26` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx27` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx28` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx29` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx3` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx30` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx31` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx32` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx33` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx34` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx35` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx36` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx37` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx38` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx39` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx4` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx40` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx5` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx6` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx7` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx8` double default NULL,');
    qryTemp.Sql.Add('`SoldAmountEx9` double default NULL,');
    qryTemp.Sql.Add('`TotalSoldAmountEx` double default NULL,');
    qryTemp.Sql.Add('`SaleTax1` double default NULL,');
    qryTemp.Sql.Add('`SaleTax10` double default NULL,');
    qryTemp.Sql.Add('`SaleTax11` double default NULL,');
    qryTemp.Sql.Add('`SaleTax12` double default NULL,');
    qryTemp.Sql.Add('`SaleTax13` double default NULL,');
    qryTemp.Sql.Add('`SaleTax14` double default NULL,');
    qryTemp.Sql.Add('`SaleTax15` double default NULL,');
    qryTemp.Sql.Add('`SaleTax16` double default NULL,');
    qryTemp.Sql.Add('`SaleTax17` double default NULL,');
    qryTemp.Sql.Add('`SaleTax18` double default NULL,');
    qryTemp.Sql.Add('`SaleTax19` double default NULL,');
    qryTemp.Sql.Add('`SaleTax2` double default NULL,');
    qryTemp.Sql.Add('`SaleTax20` double default NULL,');
    qryTemp.Sql.Add('`SaleTax21` double default NULL,');
    qryTemp.Sql.Add('`SaleTax22` double default NULL,');
    qryTemp.Sql.Add('`SaleTax23` double default NULL,');
    qryTemp.Sql.Add('`SaleTax24` double default NULL,');
    qryTemp.Sql.Add('`SaleTax25` double default NULL,');
    qryTemp.Sql.Add('`SaleTax26` double default NULL,');
    qryTemp.Sql.Add('`SaleTax27` double default NULL,');
    qryTemp.Sql.Add('`SaleTax28` double default NULL,');
    qryTemp.Sql.Add('`SaleTax29` double default NULL,');
    qryTemp.Sql.Add('`SaleTax3` double default NULL,');
    qryTemp.Sql.Add('`SaleTax30` double default NULL,');
    qryTemp.Sql.Add('`SaleTax31` double default NULL,');
    qryTemp.Sql.Add('`SaleTax32` double default NULL,');
    qryTemp.Sql.Add('`SaleTax33` double default NULL,');
    qryTemp.Sql.Add('`SaleTax34` double default NULL,');
    qryTemp.Sql.Add('`SaleTax35` double default NULL,');
    qryTemp.Sql.Add('`SaleTax36` double default NULL,');
    qryTemp.Sql.Add('`SaleTax37` double default NULL,');
    qryTemp.Sql.Add('`SaleTax38` double default NULL,');
    qryTemp.Sql.Add('`SaleTax39` double default NULL,');
    qryTemp.Sql.Add('`SaleTax4` double default NULL,');
    qryTemp.Sql.Add('`SaleTax40` double default NULL,');
    qryTemp.Sql.Add('`SaleTax5` double default NULL,');
    qryTemp.Sql.Add('`SaleTax6` double default NULL,');
    qryTemp.Sql.Add('`SaleTax7` double default NULL,');
    qryTemp.Sql.Add('`SaleTax8` double default NULL,');
    qryTemp.Sql.Add('`SaleTax9` double default NULL,');
    qryTemp.Sql.Add('`TotalSaleTax` double default NULL,');
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
procedure TSalesSummaryReportGUI.initFooterCalcfields;
begin
  AddCalccolumn('SaleTax1', true);
  AddCalccolumn('SaleTax2', true);
  AddCalccolumn('SaleTax3', true);
  AddCalccolumn('SaleTax4', true);
  AddCalccolumn('SaleTax5', true);
  AddCalccolumn('SaleTax6', true);
  AddCalccolumn('SaleTax7', true);
  AddCalccolumn('SaleTax8', true);
  AddCalccolumn('SaleTax9', true);
  AddCalccolumn('SaleTax10', true);
  AddCalccolumn('SaleTax11', true);
  AddCalccolumn('SaleTax12', true);
  AddCalccolumn('SaleTax13', true);
  AddCalccolumn('SaleTax14', true);
  AddCalccolumn('SaleTax15', true);
  AddCalccolumn('SaleTax16', true);
  AddCalccolumn('SaleTax17', true);
  AddCalccolumn('SaleTax18', true);
  AddCalccolumn('SaleTax19', true);
  AddCalccolumn('SaleTax20', true);
  AddCalccolumn('SaleTax21', true);
  AddCalccolumn('SaleTax22', true);
  AddCalccolumn('SaleTax23', true);
  AddCalccolumn('SaleTax24', true);
  AddCalccolumn('SaleTax25', true);
  AddCalccolumn('SaleTax26', true);
  AddCalccolumn('SaleTax27', true);
  AddCalccolumn('SaleTax28', true);
  AddCalccolumn('SaleTax29', true);
  AddCalccolumn('SaleTax30', true);
  AddCalccolumn('SaleTax31', true);
  AddCalccolumn('SaleTax32', true);
  AddCalccolumn('SaleTax33', true);
  AddCalccolumn('SaleTax34', true);
  AddCalccolumn('SaleTax35', true);
  AddCalccolumn('SaleTax36', true);
  AddCalccolumn('SaleTax37', true);
  AddCalccolumn('SaleTax38', true);
  AddCalccolumn('SaleTax39', true);
  AddCalccolumn('SaleTax40', true);
  AddCalccolumn('SoldAmount1', true);
  AddCalccolumn('SoldAmount2', true);
  AddCalccolumn('SoldAmount3', true);
  AddCalccolumn('SoldAmount4', true);
  AddCalccolumn('SoldAmount5', true);
  AddCalccolumn('SoldAmount6', true);
  AddCalccolumn('SoldAmount7', true);
  AddCalccolumn('SoldAmount8', true);
  AddCalccolumn('SoldAmount9', true);
  AddCalccolumn('SoldAmount10', true);
  AddCalccolumn('SoldAmount11', true);
  AddCalccolumn('SoldAmount12', true);
  AddCalccolumn('SoldAmount13', true);
  AddCalccolumn('SoldAmount14', true);
  AddCalccolumn('SoldAmount15', true);
  AddCalccolumn('SoldAmount16', true);
  AddCalccolumn('SoldAmount17', true);
  AddCalccolumn('SoldAmount18', true);
  AddCalccolumn('SoldAmount19', true);
  AddCalccolumn('SoldAmount20', true);
  AddCalccolumn('SoldAmount21', true);
  AddCalccolumn('SoldAmount22', true);
  AddCalccolumn('SoldAmount23', true);
  AddCalccolumn('SoldAmount24', true);
  AddCalccolumn('SoldAmount25', true);
  AddCalccolumn('SoldAmount26', true);
  AddCalccolumn('SoldAmount27', true);
  AddCalccolumn('SoldAmount28', true);
  AddCalccolumn('SoldAmount29', true);
  AddCalccolumn('SoldAmount30', true);
  AddCalccolumn('SoldAmount31', true);
  AddCalccolumn('SoldAmount32', true);
  AddCalccolumn('SoldAmount33', true);
  AddCalccolumn('SoldAmount34', true);
  AddCalccolumn('SoldAmount35', true);
  AddCalccolumn('SoldAmount36', true);
  AddCalccolumn('SoldAmount37', true);
  AddCalccolumn('SoldAmount38', true);
  AddCalccolumn('SoldAmount39', true);
  AddCalccolumn('SoldAmount40', true);
  AddCalccolumn('CostAmount1', true);
  AddCalccolumn('CostAmount2', true);
  AddCalccolumn('CostAmount3', true);
  AddCalccolumn('CostAmount4', true);
  AddCalccolumn('CostAmount5', true);
  AddCalccolumn('CostAmount6', true);
  AddCalccolumn('CostAmount7', true);
  AddCalccolumn('CostAmount8', true);
  AddCalccolumn('CostAmount9', true);
  AddCalccolumn('CostAmount10', true);
  AddCalccolumn('CostAmount11', true);
  AddCalccolumn('CostAmount12', true);
  AddCalccolumn('CostAmount13', true);
  AddCalccolumn('CostAmount14', true);
  AddCalccolumn('CostAmount15', true);
  AddCalccolumn('CostAmount16', true);
  AddCalccolumn('CostAmount17', true);
  AddCalccolumn('CostAmount18', true);
  AddCalccolumn('CostAmount19', true);
  AddCalccolumn('CostAmount20', true);
  AddCalccolumn('CostAmount21', true);
  AddCalccolumn('CostAmount22', true);
  AddCalccolumn('CostAmount23', true);
  AddCalccolumn('CostAmount24', true);
  AddCalccolumn('CostAmount25', true);
  AddCalccolumn('CostAmount26', true);
  AddCalccolumn('CostAmount27', true);
  AddCalccolumn('CostAmount28', true);
  AddCalccolumn('CostAmount29', true);
  AddCalccolumn('CostAmount30', true);
  AddCalccolumn('CostAmount31', true);
  AddCalccolumn('CostAmount32', true);
  AddCalccolumn('CostAmount33', true);
  AddCalccolumn('CostAmount34', true);
  AddCalccolumn('CostAmount35', true);
  AddCalccolumn('CostAmount36', true);
  AddCalccolumn('CostAmount37', true);
  AddCalccolumn('CostAmount38', true);
  AddCalccolumn('CostAmount39', true);
  AddCalccolumn('CostAmount40', true);
  AddCalccolumn('SoldAmountEx1', true);
  AddCalccolumn('SoldAmountEx2', true);
  AddCalccolumn('SoldAmountEx3', true);
  AddCalccolumn('SoldAmountEx4', true);
  AddCalccolumn('SoldAmountEx5', true);
  AddCalccolumn('SoldAmountEx6', true);
  AddCalccolumn('SoldAmountEx7', true);
  AddCalccolumn('SoldAmountEx8', true);
  AddCalccolumn('SoldAmountEx9', true);
  AddCalccolumn('SoldAmountEx10', true);
  AddCalccolumn('SoldAmountEx11', true);
  AddCalccolumn('SoldAmountEx12', true);
  AddCalccolumn('SoldAmountEx13', true);
  AddCalccolumn('SoldAmountEx14', true);
  AddCalccolumn('SoldAmountEx15', true);
  AddCalccolumn('SoldAmountEx16', true);
  AddCalccolumn('SoldAmountEx17', true);
  AddCalccolumn('SoldAmountEx18', true);
  AddCalccolumn('SoldAmountEx19', true);
  AddCalccolumn('SoldAmountEx20', true);
  AddCalccolumn('SoldAmountEx21', true);
  AddCalccolumn('SoldAmountEx22', true);
  AddCalccolumn('SoldAmountEx23', true);
  AddCalccolumn('SoldAmountEx24', true);
  AddCalccolumn('SoldAmountEx25', true);
  AddCalccolumn('SoldAmountEx26', true);
  AddCalccolumn('SoldAmountEx27', true);
  AddCalccolumn('SoldAmountEx28', true);
  AddCalccolumn('SoldAmountEx29', true);
  AddCalccolumn('SoldAmountEx30', true);
  AddCalccolumn('SoldAmountEx31', true);
  AddCalccolumn('SoldAmountEx32', true);
  AddCalccolumn('SoldAmountEx33', true);
  AddCalccolumn('SoldAmountEx34', true);
  AddCalccolumn('SoldAmountEx35', true);
  AddCalccolumn('SoldAmountEx36', true);
  AddCalccolumn('SoldAmountEx37', true);
  AddCalccolumn('SoldAmountEx38', true);
  AddCalccolumn('SoldAmountEx39', true);
  AddCalccolumn('SoldAmountEx40', true);
end;
procedure TSalesSummaryReportGUI.FormCreate(Sender: TObject);
begin
  initFooterCalcfields;
  Tablename := GetUserTemporaryTableName('tmp_SalesSummary');
  //fbIgnoreAccessLevels:=True;
  CreateTempSaleSummaryTable;
  PopulateQrymain;
  inherited;
end;


procedure TSalesSummaryReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TSalesSummaryReportGUI.AddDataToTempSaleSummaryTable;
var
  InsertSQL: string;
  qryTemp: TERPCommand;
  pClass: pClassRec;
  I: integer;
  TransactionTableObj: TTransactionTableObj;
  ClassCount: integer;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + Tablename +
    '(Date,' +
    'CostAmount1,SoldAmount1,SaleTax1,SoldAmountEx1, ' +
    'CostAmount2,SoldAmount2 ,SaleTax2,SoldAmountEx2 , ' +
    'CostAmount3 ,SoldAmount3,SaleTax3 ,SoldAmountEx3, ' +
    'CostAmount4,SoldAmount4,SaleTax4,SoldAmountEx4, ' +
    'CostAmount5,SoldAmount5,SaleTax5,SoldAmountEx5, ' +
    'CostAmount6,SoldAmount6,SaleTax6,SoldAmountEx6, ' +
    'CostAmount7,SoldAmount7,SaleTax7,SoldAmountEx7, ' +
    'CostAmount8,SoldAmount8 ,SaleTax8,SoldAmountEx8 , ' +
    'CostAmount9,SoldAmount9,SaleTax9,SoldAmountEx9, ' +
    'CostAmount10,SoldAmount10,SaleTax10,SoldAmountEx10, ' +
    'CostAmount11,SoldAmount11, SaleTax11,SoldAmountEx11,  ' +
    'CostAmount12,SoldAmount12,SaleTax12,SoldAmountEx12, ' +
    'CostAmount13,SoldAmount13, SaleTax13,SoldAmountEx13,  ' +
    'CostAmount14,SoldAmount14,SaleTax14,SoldAmountEx14, ' +
    'CostAmount15,SoldAmount15,SaleTax15,SoldAmountEx15, ' +
    'CostAmount16,SoldAmount16,SaleTax16,SoldAmountEx16, ' +
    'CostAmount17,SoldAmount17,SaleTax17,SoldAmountEx17, ' +
    'CostAmount18,SoldAmount18,SaleTax18,SoldAmountEx18, ' +
    'CostAmount19,SoldAmount19,SaleTax19,SoldAmountEx19, ' +
    'CostAmount20,SoldAmount20,SaleTax20,SoldAmountEx20, ' +
    'CostAmount21,SoldAmount21, SaleTax21,SoldAmountEx21,  ' +
    'CostAmount22,SoldAmount22,SaleTax22,SoldAmountEx22, ' +
    'CostAmount23,SoldAmount23, SaleTax23,SoldAmountEx23,  ' +
    'CostAmount24,SoldAmount24,SaleTax24,SoldAmountEx24, ' +
    'CostAmount25,SoldAmount25,SaleTax25,SoldAmountEx25, ' +
    'CostAmount26,SoldAmount26,SaleTax26,SoldAmountEx26, ' +
    'CostAmount27,SoldAmount27,SaleTax27,SoldAmountEx27, ' +
    'CostAmount28,SoldAmount28,SaleTax28,SoldAmountEx28, ' +
    'CostAmount29,SoldAmount29,SaleTax29,SoldAmountEx29, ' +
    'CostAmount30,SoldAmount30,SaleTax30,SoldAmountEx30, ' +
    'CostAmount31,SoldAmount31, SaleTax31,SoldAmountEx31,  ' +
    'CostAmount32,SoldAmount32,SaleTax32,SoldAmountEx32, ' +
    'CostAmount33,SoldAmount33, SaleTax33,SoldAmountEx33,  ' +
    'CostAmount34,SoldAmount34,SaleTax34,SoldAmountEx34, ' +
    'CostAmount35,SoldAmount35,SaleTax35,SoldAmountEx35, ' +
    'CostAmount36,SoldAmount36,SaleTax36,SoldAmountEx36, ' +
    'CostAmount37,SoldAmount37,SaleTax37,SoldAmountEx37, ' +
    'CostAmount38,SoldAmount38,SaleTax38,SoldAmountEx38, ' +
    'CostAmount39,SoldAmount39,SaleTax39,SoldAmountEx39, ' +
    'CostAmount40,SoldAmount40,SaleTax40,SoldAmountEx40, ' +
    'TotalCostAmount,TotalSoldAmount,TotalSaleTax,TotalSoldAmountEx,' +
    'FilterDate,FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber,FilterMonthName,' +
    'FilterQuarterNumber,FilterYEAR )';
  TransactionTableObj := TTransactionTableObj.Create(True);
  try
    TransactionTableObj.GetClasses;

    qryTemp := TERPCommand.Create(nil);
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      //Data
      DeleteDataSaleSummaryTable;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add(InsertSQL);
      qryTemp.Sql.Add('SELECT Min(tblSales.SaleDate) as Date, ');

      ClassCount := TransactionTableObj.LstClass.Count;

      if ClassCount > PNLMAXClassCount then ClassCount := PNLMAXClassCount;

      for I := 0 to ClassCount - 1 do begin
        pClass := TransactionTableObj.LstClass.Items[I];
        qryTemp.Sql.Add('If(ClassID=' + IntToStr(pClass^.ClassID) +
          '  ,Round(Sum(Shipped*LineCostInc),'+inttostr(CurrencyRoundPlaces)+'),0.00)   as "CostAmount' + IntToStr(I + 1) + '" ,');
        qryTemp.Sql.Add('If(ClassID=' + IntToStr(pClass^.ClassID) +
          '  ,Round(Sum(TotalLineAmountInc),'+inttostr(CurrencyRoundPlaces)+'),0.00)   as "SoldAmount' + IntToStr(I + 1) + '",');
        qryTemp.Sql.Add('If(ClassID=' + IntToStr(pClass^.ClassID) +
          '  ,Round(Sum(LineTax),'+inttostr(CurrencyRoundPlaces)+'),0.00)   as "SaleTax' + IntToStr(I + 1) + '",');
        qryTemp.Sql.Add('If(ClassID=' + IntToStr(pClass^.ClassID) +
          '  ,Round(Sum(TotalLineAmount),'+inttostr(CurrencyRoundPlaces)+'),0.00)   as "SoldAmountEx' + IntToStr(I + 1) + '",');
      end;

      for I := ClassCount to (PNLMAXClassCount - 1) do begin
        qryTemp.Sql.Add('0.00  as "CostAmount' + IntToStr(I + 1) + '" ,');
        qryTemp.Sql.Add('0.00  as "SoldAmount' + IntToStr(I + 1) + '",');
        qryTemp.Sql.Add('0.00  as "SaleTax' + IntToStr(I + 1) + '" ,');
        qryTemp.Sql.Add('0.00  as "SoldAmountEx' + IntToStr(I + 1) + '",');
      end;

      qryTemp.Sql.Add('Round(Sum(Shipped*LineCostInc),'+inttostr(CurrencyRoundPlaces)+') as TotalCostAmount , ');
      qryTemp.Sql.Add('Round(Sum(TotalLineAmountInc),'+inttostr(CurrencyRoundPlaces)+') as TotalSoldAmount,');
      qryTemp.Sql.Add('Round(Sum(LineTax),'+inttostr(CurrencyRoundPlaces)+') as TotalSaleTax , ');
      qryTemp.Sql.Add('Round(Sum(TotalLineAmount),'+inttostr(CurrencyRoundPlaces)+') as TotalSoldAmountEx,');
      qryTemp.Sql.Add('tblSales.SaleDate as FilterDate,');
      qryTemp.Sql.Add('DAYNAME(tblSales.SaleDate) as FilterWeekday,');
      qryTemp.Sql.Add('WEEKDAY(tblSales.SaleDate) as FilterWeekdayNumber,');
      qryTemp.Sql.Add('WEEK(tblSales.SaleDate,3)  AS FilterWeekNumber,');
      qryTemp.Sql.Add('MONTH(tblSales.SaleDate) as FilterMonthNumber,');
      qryTemp.Sql.Add('MONTHNAME(tblSales.SaleDate) as FilterMonthName,');
      qryTemp.Sql.Add('QUARTER(tblSales.SaleDate) AS FilterQuarterNumber,');
      qryTemp.Sql.Add('YEAR(tblSales.SaleDate) AS FilterYEAR ');
      qryTemp.Sql.Add('FROM tblSales ');
      qryTemp.Sql.Add('INNER JOIN tblSalesLines Using(SaleID) ');
      qryTemp.Sql.Add('WHERE (tblSales.IsRefund ="T" OR tblSales.IsCashSale="T" OR tblSales.IsInvoice="T"  ');
      qryTemp.Sql.Add('OR tblSales.IsPOS="T") AND tblSales.IsQuote="F"  AND tblSales.IsLayby="F" ');
      qryTemp.Sql.Add('AND tblSales.SaleDate Between "' + FormatDateTime(MysqlDateFormat,
        dtfrom.DateTime) + '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '" ');
      qryTemp.Sql.Add('GROUP BY tblSales.SaleID ;');
      qryTemp.Execute;
    finally
      FreeAndNil(qryTemp);
    end;
  finally
    FreeandNil(TransactionTableObj);
  end;
end;

procedure TSalesSummaryReportGUI.DeleteDataSaleSummaryTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + Tablename + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TSalesSummaryReportGUI.ClassLabelChange;
var
  TransactionTableObj: TTransactionTableObj;
  pClass: pClassRec;
  I: integer;
  ClassCount: integer;
begin
  TransactionTableObj := TTransactionTableObj.Create(True);
  try
    TransactionTableObj.GetClasses;

    ClassCount := TransactionTableObj.LstClass.Count;

    if ClassCount > PNLMAXClassCount then ClassCount := PNLMAXClassCount;;

    for I := 0 to ClassCount - 1 do begin
      pClass := TransactionTableObj.LstClass.Items[I];
      qryMain.FieldByName('CostAmount' + IntToStr(I + 1)).DisplayLabel := 'Cost Amount (' + pClass^.ClassName + ')';
      TCurrencyField(qryMain.FieldByName('CostAmount' + IntToStr(I + 1))).currency := true;
      qryMain.FieldByName('SoldAmount' + IntToStr(I + 1)).DisplayLabel := 'Sold Amount (' + pClass^.ClassName + ')';
      TCurrencyField(qryMain.FieldByName('SoldAmount' + IntToStr(I + 1))).currency := true;

      qryMain.FieldByName('SoldAmountEx' + IntToStr(I + 1)).DisplayLabel := 'Sold Amount Ex(' + pClass^.ClassName + ')';
      TCurrencyField(qryMain.FieldByName('SoldAmountEx' + IntToStr(I + 1))).currency := true;

      qryMain.FieldByName('SaleTax' + IntToStr(I + 1)).DisplayLabel := 'Sales Tax (' + pClass^.ClassName + ')';
      TCurrencyField(qryMain.FieldByName('SaleTax' + IntToStr(I + 1))).currency := true;
    end;

    for I := ClassCount to (PNLMAXClassCount - 1) do begin
      qryMain.FieldByName('CostAmount' + IntToStr(I + 1)).DisplayLabel := 'Cost Not Used' + IntToStr(I + 1);
      qryMain.FieldByName('CostAmount' + IntToStr(I + 1)).Visible := false;
      TCurrencyField(qryMain.FieldByName('CostAmount' + IntToStr(I + 1))).currency := true;

      qryMain.FieldByName('SoldAmount' + IntToStr(I + 1)).DisplayLabel := 'Sold Not Used' + IntToStr(I + 1);
      qryMain.FieldByName('SoldAmount' + IntToStr(I + 1)).Visible := false;
      TCurrencyField(qryMain.FieldByName('SoldAmount' + IntToStr(I + 1))).currency := true;

      qryMain.FieldByName('SaleTax' + IntToStr(I + 1)).DisplayLabel := 'Sold Not Used' + IntToStr(I + 1)+'(Tax)';
      qryMain.FieldByName('SaleTax' + IntToStr(I + 1)).Visible := false;
      TCurrencyField(qryMain.FieldByName('SaleTax' + IntToStr(I + 1))).currency := true;

      qryMain.FieldByName('SoldAmountEx' + IntToStr(I + 1)).DisplayLabel := 'Sold Not Used' + IntToStr(I + 1)+'(Ex)';
      qryMain.FieldByName('SoldAmountEx' + IntToStr(I + 1)).Visible := false;
      TCurrencyField(qryMain.FieldByName('SoldAmountEx' + IntToStr(I + 1))).currency := true;


    end;

    TCurrencyField(qryMain.FieldByName('TotalCostAmount')).currency := true;
    TCurrencyField(qryMain.FieldByName('TotalSoldAmount')).currency := true;
    TCurrencyField(qryMain.FieldByName('TotalSaleTax')).currency := true;
    TCurrencyField(qryMain.FieldByName('TotalSoldAmountEx')).currency := true;

  finally
    TransactionTableObj.ClearClasses;
    FreeandNil(TransactionTableObj);
  end;
  cboFilter.ItemIndex := 0;
end;

Procedure TSalesSummaryReportGUI.PopulateQrymain;
var
  PeriodField: string;
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
        OrderByField := 'FilterDate';
      end;
    1:
      begin {Weekday}
        PeriodField := 'FilterWeekday';
        PeriodName := 'Weekday';
        GroupByField := 'FilterWeekdayNumber,FilterYEAR';
        OrderByField := 'FilterYEAR,FilterWeekdayNumber';
      end;
    2:
      begin {Week}
        PeriodField := 'FilterWeekNumber';
        PeriodName := 'Week Number';
        GroupByField := 'FilterWeekNumber,FilterYEAR';
        OrderByField := 'FilterYEAR,FilterWeekNumber';
      end;
    3:
      begin {Month}
        PeriodField := 'FilterMonthName';
        PeriodName := 'Month';
        GroupByField := 'FilterMonthNumber,FilterYEAR';
        OrderByField := 'FilterYEAR,FilterMonthNumber';
      end;
    4:
      begin {Quarter}
        PeriodField := 'FilterQuarterNumber';
        PeriodName := 'Quarter';
        GroupByField := 'FilterQuarterNumber,FilterYEAR';
        OrderByField := 'FilterYEAR,FilterQuarterNumber';
      end;
    5:
      begin {Year}
        PeriodField := 'FilterYEAR';
        PeriodName := 'Year';
        GroupByField := 'FilterYEAR';
        OrderByField := 'FilterYEAR';
      end;
  end;
  qryMain.Close;
  qryMain.SQL.Text := 'SELECT ';
  case grpFilters.ItemIndex of
    5:
      begin {Year}
        qryMain.SQL.add('convert(' +PeriodField + ', CHAR )  as Period ,  ');
      end;
    else begin
      qryMain.SQL.add('convert(' +PeriodField + ' , CHAR )  as Period ,  ' );
      qryMain.SQL.add( '  FilterYEAR as Year , ');
    end;
  end;

  (* if not(SameText(PeriodField , 'FilterDate') then  *)Qrymain.SQL.add('NULL as FilterDate,');
  (* if not(SameText(PeriodField , 'FilterWeekday') then  *)Qrymain.SQL.add('NULL as FilterWeekday,');
  (* if not(SameText(PeriodField , 'FilterWeekNumber') then  *)Qrymain.SQL.add('NULL as FilterWeekNumber,');
  (* if not(SameText(PeriodField , 'FilterMonthName') then  *)Qrymain.SQL.add('NULL as FilterMonthName,');
  (* if not(SameText(PeriodField , 'FilterQuarterNumber') then  *)Qrymain.SQL.add('NULL as FilterQuarterNumber,');
  (* if not(SameText(PeriodField , 'FilterYEAR') then  *)Qrymain.SQL.add('NULL as FilterYEAR,');


  Qrymain.SQL.add('Sum(CostAmount1) as CostAmount1, ');
  Qrymain.SQL.add('Sum(SoldAmount1) as SoldAmount1, ');
  Qrymain.SQL.add('Sum(SoldAmountEx1) as SoldAmountEx1, ');
  Qrymain.SQL.add('Sum(SaleTax1) as SaleTax1, ');
  Qrymain.SQL.add('Sum(CostAmount2) as CostAmount2, ');
  Qrymain.SQL.add('Sum(SoldAmount2) as SoldAmount2, ');
  Qrymain.SQL.add('Sum(SoldAmountEx2) as SoldAmountEx2, ');
  Qrymain.SQL.add('Sum(SaleTax2) as SaleTax2, ');
  Qrymain.SQL.add('Sum(CostAmount3) as CostAmount3, ');
  Qrymain.SQL.add('Sum(SoldAmount3) as SoldAmount3, ');
  Qrymain.SQL.add('Sum(SoldAmountEx3) as SoldAmountEx3, ');
  Qrymain.SQL.add('Sum(SaleTax3) as SaleTax3, ');
  Qrymain.SQL.add('Sum(CostAmount4) as CostAmount4, ');
  Qrymain.SQL.add('Sum(SoldAmount4) as SoldAmount4, ');
  Qrymain.SQL.add('Sum(SoldAmountEx4) as SoldAmountEx4, ');
  Qrymain.SQL.add('Sum(SaleTax4) as SaleTax4, ');
  Qrymain.SQL.add('Sum(CostAmount5) as CostAmount5, ');
  Qrymain.SQL.add('Sum(SoldAmount5) as SoldAmount5, ');
  Qrymain.SQL.add('Sum(SoldAmountEx5) as SoldAmountEx5, ');
  Qrymain.SQL.add('Sum(SaleTax5) as SaleTax5, ');
  Qrymain.SQL.add('Sum(CostAmount6) as CostAmount6, ');
  Qrymain.SQL.add('Sum(SoldAmount6) as SoldAmount6, ');
  Qrymain.SQL.add('Sum(SoldAmountEx6) as SoldAmountEx6, ');
  Qrymain.SQL.add('Sum(SaleTax6) as SaleTax6, ');
  Qrymain.SQL.add('Sum(CostAmount7) as CostAmount7, ');
  Qrymain.SQL.add('Sum(SoldAmount7) as SoldAmount7, ');
  Qrymain.SQL.add('Sum(SoldAmountEx7) as SoldAmountEx7, ');
  Qrymain.SQL.add('Sum(SaleTax7) as SaleTax7, ');
  Qrymain.SQL.add('Sum(CostAmount8) as CostAmount8, ');
  Qrymain.SQL.add('Sum(SoldAmount8) as SoldAmount8, ');
  Qrymain.SQL.add('Sum(SoldAmountEx8) as SoldAmountEx8, ');
  Qrymain.SQL.add('Sum(SaleTax8) as SaleTax8, ');
  Qrymain.SQL.add('Sum(CostAmount9) as CostAmount9, ');
  Qrymain.SQL.add('Sum(SoldAmount9) as SoldAmount9, ');
  Qrymain.SQL.add('Sum(SoldAmountEx9) as SoldAmountEx9, ');
  Qrymain.SQL.add('Sum(SaleTax9) as SaleTax9, ');
  Qrymain.SQL.add('Sum(CostAmount10) as CostAmount10, ');
  Qrymain.SQL.add('Sum(SoldAmount10) as SoldAmount10, ');
  Qrymain.SQL.add('Sum(SoldAmountEx10) as SoldAmountEx10, ');
  Qrymain.SQL.add('Sum(SaleTax10) as SaleTax10, ');
  Qrymain.SQL.add('Sum(CostAmount11) as CostAmount11, ');
  Qrymain.SQL.add('Sum(SoldAmount11) as SoldAmount11, ');
  Qrymain.SQL.add('Sum(SoldAmountEx11) as SoldAmountEx11, ');
  Qrymain.SQL.add('Sum(SaleTax11) as SaleTax11, ');
  Qrymain.SQL.add('Sum(CostAmount12) as CostAmount12, ');
  Qrymain.SQL.add('Sum(SoldAmount12) as SoldAmount12, ');
  Qrymain.SQL.add('Sum(SoldAmountEx12) as SoldAmountEx12, ');
  Qrymain.SQL.add('Sum(SaleTax12) as SaleTax12, ');
  Qrymain.SQL.add('Sum(CostAmount13) as CostAmount13, ');
  Qrymain.SQL.add('Sum(SoldAmount13) as SoldAmount13, ');
  Qrymain.SQL.add('Sum(SoldAmountEx13) as SoldAmountEx13, ');
  Qrymain.SQL.add('Sum(SaleTax13) as SaleTax13, ');
  Qrymain.SQL.add('Sum(CostAmount14) as CostAmount14, ');
  Qrymain.SQL.add('Sum(SoldAmount14) as SoldAmount14, ');
  Qrymain.SQL.add('Sum(SoldAmountEx14) as SoldAmountEx14, ');
  Qrymain.SQL.add('Sum(SaleTax14) as SaleTax14, ');
  Qrymain.SQL.add('Sum(CostAmount15) as CostAmount15, ');
  Qrymain.SQL.add('Sum(SoldAmount15) as SoldAmount15, ');
  Qrymain.SQL.add('Sum(SoldAmountEx15) as SoldAmountEx15, ');
  Qrymain.SQL.add('Sum(SaleTax15) as SaleTax15, ');
  Qrymain.SQL.add('Sum(CostAmount16) as CostAmount16, ');
  Qrymain.SQL.add('Sum(SoldAmount16) as SoldAmount16, ');
  Qrymain.SQL.add('Sum(SoldAmountEx16) as SoldAmountEx16, ');
  Qrymain.SQL.add('Sum(SaleTax16) as SaleTax16, ');
  Qrymain.SQL.add('Sum(CostAmount17) as CostAmount17, ');
  Qrymain.SQL.add('Sum(SoldAmount17) as SoldAmount17, ');
  Qrymain.SQL.add('Sum(SoldAmountEx17) as SoldAmountEx17, ');
  Qrymain.SQL.add('Sum(SaleTax17) as SaleTax17, ');
  Qrymain.SQL.add('Sum(CostAmount18) as CostAmount18, ');
  Qrymain.SQL.add('Sum(SoldAmount18) as SoldAmount18, ');
  Qrymain.SQL.add('Sum(SoldAmountEx18) as SoldAmountEx18, ');
  Qrymain.SQL.add('Sum(SaleTax18) as SaleTax18, ');
  Qrymain.SQL.add('Sum(CostAmount19) as CostAmount19, ');
  Qrymain.SQL.add('Sum(SoldAmount19) as SoldAmount19, ');
  Qrymain.SQL.add('Sum(SoldAmountEx19) as SoldAmountEx19, ');
  Qrymain.SQL.add('Sum(SaleTax19) as SaleTax19, ');
  Qrymain.SQL.add('Sum(CostAmount20) as CostAmount20, ');
  Qrymain.SQL.add('Sum(SoldAmount20) as SoldAmount20, ');
  Qrymain.SQL.add('Sum(SoldAmountEx20) as SoldAmountEx20, ');
  Qrymain.SQL.add('Sum(SaleTax20) as SaleTax20, ');
  Qrymain.SQL.add('Sum(CostAmount21) as CostAmount21, ');
  Qrymain.SQL.add('Sum(SoldAmount21) as SoldAmount21, ');
  Qrymain.SQL.add('Sum(SoldAmountEx21) as SoldAmountEx21, ');
  Qrymain.SQL.add('Sum(SaleTax21) as SaleTax21, ');
  Qrymain.SQL.add('Sum(CostAmount22) as CostAmount22, ');
  Qrymain.SQL.add('Sum(SoldAmount22) as SoldAmount22, ');
  Qrymain.SQL.add('Sum(SoldAmountEx22) as SoldAmountEx22, ');
  Qrymain.SQL.add('Sum(SaleTax22) as SaleTax22, ');
  Qrymain.SQL.add('Sum(CostAmount23) as CostAmount23, ');
  Qrymain.SQL.add('Sum(SoldAmount23) as SoldAmount23, ');
  Qrymain.SQL.add('Sum(SoldAmountEx23) as SoldAmountEx23, ');
  Qrymain.SQL.add('Sum(SaleTax23) as SaleTax23, ');
  Qrymain.SQL.add('Sum(CostAmount24) as CostAmount24, ');
  Qrymain.SQL.add('Sum(SoldAmount24) as SoldAmount24, ');
  Qrymain.SQL.add('Sum(SoldAmountEx24) as SoldAmountEx24, ');
  Qrymain.SQL.add('Sum(SaleTax24) as SaleTax24, ');
  Qrymain.SQL.add('Sum(CostAmount25) as CostAmount25, ');
  Qrymain.SQL.add('Sum(SoldAmount25) as SoldAmount25, ');
  Qrymain.SQL.add('Sum(SoldAmountEx25) as SoldAmountEx25, ');
  Qrymain.SQL.add('Sum(SaleTax25) as SaleTax25, ');
  Qrymain.SQL.add('Sum(CostAmount26) as CostAmount26, ');
  Qrymain.SQL.add('Sum(SoldAmount26) as SoldAmount26, ');
  Qrymain.SQL.add('Sum(SoldAmountEx26) as SoldAmountEx26, ');
  Qrymain.SQL.add('Sum(SaleTax26) as SaleTax26, ');
  Qrymain.SQL.add('Sum(CostAmount27) as CostAmount27, ');
  Qrymain.SQL.add('Sum(SoldAmount27) as SoldAmount27, ');
  Qrymain.SQL.add('Sum(SoldAmountEx27) as SoldAmountEx27, ');
  Qrymain.SQL.add('Sum(SaleTax27) as SaleTax27, ');
  Qrymain.SQL.add('Sum(CostAmount28) as CostAmount28, ');
  Qrymain.SQL.add('Sum(SoldAmount28) as SoldAmount28, ');
  Qrymain.SQL.add('Sum(SoldAmountEx28) as SoldAmountEx28, ');
  Qrymain.SQL.add('Sum(SaleTax28) as SaleTax28, ');
  Qrymain.SQL.add('Sum(CostAmount29) as CostAmount29, ');
  Qrymain.SQL.add('Sum(SoldAmount29) as SoldAmount29, ');
  Qrymain.SQL.add('Sum(SoldAmountEx29) as SoldAmountEx29, ');
  Qrymain.SQL.add('Sum(SaleTax29) as SaleTax29, ');
  Qrymain.SQL.add('Sum(CostAmount30) as CostAmount30, ');
  Qrymain.SQL.add('Sum(SoldAmount30) as SoldAmount30, ');
  Qrymain.SQL.add('Sum(SoldAmountEx30) as SoldAmountEx30, ');
  Qrymain.SQL.add('Sum(SaleTax30) as SaleTax30, ');
  Qrymain.SQL.add('Sum(CostAmount31) as CostAmount31, ');
  Qrymain.SQL.add('Sum(SoldAmount31) as SoldAmount31, ');
  Qrymain.SQL.add('Sum(SoldAmountEx31) as SoldAmountEx31, ');
  Qrymain.SQL.add('Sum(SaleTax31) as SaleTax31, ');
  Qrymain.SQL.add('Sum(CostAmount32) as CostAmount32, ');
  Qrymain.SQL.add('Sum(SoldAmount32) as SoldAmount32, ');
  Qrymain.SQL.add('Sum(SoldAmountEx32) as SoldAmountEx32, ');
  Qrymain.SQL.add('Sum(SaleTax32) as SaleTax32, ');
  Qrymain.SQL.add('Sum(CostAmount33) as CostAmount33, ');
  Qrymain.SQL.add('Sum(SoldAmount33) as SoldAmount33, ');
  Qrymain.SQL.add('Sum(SoldAmountEx33) as SoldAmountEx33, ');
  Qrymain.SQL.add('Sum(SaleTax33) as SaleTax33, ');
  Qrymain.SQL.add('Sum(CostAmount34) as CostAmount34, ');
  Qrymain.SQL.add('Sum(SoldAmount34) as SoldAmount34, ');
  Qrymain.SQL.add('Sum(SoldAmountEx34) as SoldAmountEx34, ');
  Qrymain.SQL.add('Sum(SaleTax34) as SaleTax34, ');
  Qrymain.SQL.add('Sum(CostAmount35) as CostAmount35, ');
  Qrymain.SQL.add('Sum(SoldAmount35) as SoldAmount35, ');
  Qrymain.SQL.add('Sum(SoldAmountEx35) as SoldAmountEx35, ');
  Qrymain.SQL.add('Sum(SaleTax35) as SaleTax35, ');
  Qrymain.SQL.add('Sum(CostAmount36) as CostAmount36, ');
  Qrymain.SQL.add('Sum(SoldAmount36) as SoldAmount36, ');
  Qrymain.SQL.add('Sum(SoldAmountEx36) as SoldAmountEx36, ');
  Qrymain.SQL.add('Sum(SaleTax36) as SaleTax36, ');
  Qrymain.SQL.add('Sum(CostAmount37) as CostAmount37, ');
  Qrymain.SQL.add('Sum(SoldAmount37) as SoldAmount37, ');
  Qrymain.SQL.add('Sum(SoldAmountEx37) as SoldAmountEx37, ');
  Qrymain.SQL.add('Sum(SaleTax37) as SaleTax37, ');
  Qrymain.SQL.add('Sum(CostAmount38) as CostAmount38, ');
  Qrymain.SQL.add('Sum(SoldAmount38) as SoldAmount38, ');
  Qrymain.SQL.add('Sum(SoldAmountEx38) as SoldAmountEx38, ');
  Qrymain.SQL.add('Sum(SaleTax38) as SaleTax38, ');
  Qrymain.SQL.add('Sum(CostAmount39) as CostAmount39, ');
  Qrymain.SQL.add('Sum(SoldAmount39) as SoldAmount39, ');
  Qrymain.SQL.add('Sum(SoldAmountEx39) as SoldAmountEx39, ');
  Qrymain.SQL.add('Sum(SaleTax39) as SaleTax39, ');
  Qrymain.SQL.add('Sum(CostAmount40) as CostAmount40, ');
  Qrymain.SQL.add('Sum(SoldAmount40) as SoldAmount40, ');
  Qrymain.SQL.add('Sum(SoldAmountEx40) as SoldAmountEx40, ');
  Qrymain.SQL.add('Sum(SaleTax40) as SaleTax40, ');
  Qrymain.SQL.add('Sum(TotalCostAmount) as TotalCostAmount, ');
  Qrymain.SQL.add('Sum(TotalSoldAmount) as TotalSoldAmount,');
  Qrymain.SQL.add('Sum(TotalSoldAmountEx) as TotalSoldAmountEx ,');
  Qrymain.SQL.add('Sum(TotalSaleTax) as TotalSaleTax ');
  Qrymain.SQL.add(' FROM ' + Tablename  );
  Qrymain.SQL.add('GROUP BY ' +    GroupByField );
  Qrymain.SQL.add('ORDER By ' + OrderByField );
  SQLString := qryMain.SQL.Text;
end;
procedure TSalesSummaryReportGUI.RefreshQuery;
begin
  PopulateQrymain;
  inherited;
  qryMain.FieldByName('Period').DisplayLabel := PeriodName;
  ClassLabelChange;
  RefreshTotals;
end;

procedure TSalesSummaryReportGUI.RefreshTotals;
begin
  CalcnShowFooter;
(* var
  CostAmount1, SoldAmount1, CostAmount2, SoldAmount2, CostAmount3, SoldAmount3, CostAmount4,
  SoldAmount4, CostAmount5, SoldAmount5, CostAmount6, SoldAmount6, CostAmount7, SoldAmount7,
  CostAmount8, SoldAmount8, CostAmount9, SoldAmount9, CostAmount10, SoldAmount10, CostAmount11,
  SoldAmount11, CostAmount12, SoldAmount12, CostAmount13, SoldAmount13, CostAmount14, SoldAmount14,
  CostAmount15, SoldAmount15, CostAmount16, SoldAmount16, CostAmount17, SoldAmount17, CostAmount18,
  SoldAmount18, CostAmount19, SoldAmount19, CostAmount20, SoldAmount20, CostAmount21, SoldAmount21,
  CostAmount22, SoldAmount22, CostAmount23, SoldAmount23, CostAmount24, SoldAmount24, CostAmount25,
  SoldAmount25, CostAmount26, SoldAmount26, CostAmount27, SoldAmount27, CostAmount28, SoldAmount28,
  CostAmount29, SoldAmount29, CostAmount30, SoldAmount30, CostAmount31, SoldAmount31, CostAmount32,
  SoldAmount32, CostAmount33, SoldAmount33, CostAmount34, SoldAmount34, CostAmount35, SoldAmount35,
  CostAmount36, SoldAmount36, CostAmount37, SoldAmount37, CostAmount38, SoldAmount38, CostAmount39,
  SoldAmount39, CostAmount40, SoldAmount40, TotalCostAmount, TotalSoldAmount: double;
begin
  CostAmount1 := 0.00;
  SoldAmount1 := 0.00;
  CostAmount2 := 0.00;
  SoldAmount2 := 0.00;
  CostAmount3 := 0.00;
  SoldAmount3 := 0.00;
  CostAmount4 := 0.00;
  SoldAmount4 := 0.00;
  CostAmount5 := 0.00;
  SoldAmount5 := 0.00;
  CostAmount6 := 0.00;
  SoldAmount6 := 0.00;
  CostAmount7 := 0.00;
  SoldAmount7 := 0.00;
  CostAmount8 := 0.00;
  SoldAmount8 := 0.00;
  CostAmount9 := 0.00;
  SoldAmount9 := 0.00;
  CostAmount10 := 0.00;
  SoldAmount10 := 0.00;
  CostAmount11 := 0.00;
  SoldAmount11 := 0.00;
  CostAmount12 := 0.00;
  SoldAmount12 := 0.00;
  CostAmount13 := 0.00;
  SoldAmount13 := 0.00;
  CostAmount14 := 0.00;
  SoldAmount14 := 0.00;
  CostAmount15 := 0.00;
  SoldAmount15 := 0.00;
  CostAmount16 := 0.00;
  SoldAmount16 := 0.00;
  CostAmount17 := 0.00;
  SoldAmount17 := 0.00;
  CostAmount18 := 0.00;
  SoldAmount18 := 0.00;
  CostAmount19 := 0.00;
  SoldAmount19 := 0.00;
  CostAmount20 := 0.00;
  SoldAmount20 := 0.00;
  CostAmount21 := 0.00;
  SoldAmount21 := 0.00;
  CostAmount22 := 0.00;
  SoldAmount22 := 0.00;
  CostAmount23 := 0.00;
  SoldAmount23 := 0.00;
  CostAmount24 := 0.00;
  SoldAmount24 := 0.00;
  CostAmount25 := 0.00;
  SoldAmount25 := 0.00;
  CostAmount26 := 0.00;
  SoldAmount26 := 0.00;
  CostAmount27 := 0.00;
  SoldAmount27 := 0.00;
  CostAmount28 := 0.00;
  SoldAmount28 := 0.00;
  CostAmount29 := 0.00;
  SoldAmount29 := 0.00;
  CostAmount30 := 0.00;
  SoldAmount30 := 0.00;
  CostAmount31 := 0.00;
  SoldAmount31 := 0.00;
  CostAmount32 := 0.00;
  SoldAmount32 := 0.00;
  CostAmount33 := 0.00;
  SoldAmount33 := 0.00;
  CostAmount34 := 0.00;
  SoldAmount34 := 0.00;
  CostAmount35 := 0.00;
  SoldAmount35 := 0.00;
  CostAmount36 := 0.00;
  SoldAmount36 := 0.00;
  CostAmount37 := 0.00;
  SoldAmount37 := 0.00;
  CostAmount38 := 0.00;
  SoldAmount38 := 0.00;
  CostAmount39 := 0.00;
  SoldAmount39 := 0.00;
  CostAmount40 := 0.00;
  SoldAmount40 := 0.00;
  TotalCostAmount := 0.00;
  TotalSoldAmount := 0.00;

  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      CostAmount1 := CostAmount1 + qryMain.FieldByName('CostAmount1').AsCurrency;
      SoldAmount1 := SoldAmount1 + qryMain.FieldByName('SoldAmount1').AsCurrency;
      CostAmount2 := CostAmount2 + qryMain.FieldByName('CostAmount2').AsCurrency;
      SoldAmount2 := SoldAmount2 + qryMain.FieldByName('SoldAmount2').AsCurrency;
      CostAmount3 := CostAmount3 + qryMain.FieldByName('CostAmount3').AsCurrency;
      SoldAmount3 := SoldAmount3 + qryMain.FieldByName('SoldAmount3').AsCurrency;
      CostAmount4 := CostAmount4 + qryMain.FieldByName('CostAmount4').AsCurrency;
      SoldAmount4 := SoldAmount4 + qryMain.FieldByName('SoldAmount4').AsCurrency;
      CostAmount5 := CostAmount5 + qryMain.FieldByName('CostAmount5').AsCurrency;
      SoldAmount5 := SoldAmount5 + qryMain.FieldByName('SoldAmount5').AsCurrency;
      CostAmount6 := CostAmount6 + qryMain.FieldByName('CostAmount6').AsCurrency;
      SoldAmount6 := SoldAmount6 + qryMain.FieldByName('SoldAmount6').AsCurrency;
      CostAmount7 := CostAmount7 + qryMain.FieldByName('CostAmount7').AsCurrency;
      SoldAmount7 := SoldAmount7 + qryMain.FieldByName('SoldAmount7').AsCurrency;
      CostAmount8 := CostAmount8 + qryMain.FieldByName('CostAmount8').AsCurrency;
      SoldAmount8 := SoldAmount8 + qryMain.FieldByName('SoldAmount8').AsCurrency;
      CostAmount9 := CostAmount9 + qryMain.FieldByName('CostAmount9').AsCurrency;
      SoldAmount9 := SoldAmount9 + qryMain.FieldByName('SoldAmount9').AsCurrency;
      CostAmount10 := CostAmount10 + qryMain.FieldByName('CostAmount10').AsCurrency;
      SoldAmount10 := SoldAmount10 + qryMain.FieldByName('SoldAmount10').AsCurrency;
      CostAmount11 := CostAmount11 + qryMain.FieldByName('CostAmount11').AsCurrency;
      SoldAmount11 := SoldAmount11 + qryMain.FieldByName('SoldAmount11').AsCurrency;
      CostAmount12 := CostAmount12 + qryMain.FieldByName('CostAmount12').AsCurrency;
      SoldAmount12 := SoldAmount12 + qryMain.FieldByName('SoldAmount12').AsCurrency;
      CostAmount13 := CostAmount13 + qryMain.FieldByName('CostAmount13').AsCurrency;
      SoldAmount13 := SoldAmount13 + qryMain.FieldByName('SoldAmount13').AsCurrency;
      CostAmount14 := CostAmount14 + qryMain.FieldByName('CostAmount14').AsCurrency;
      SoldAmount14 := SoldAmount14 + qryMain.FieldByName('SoldAmount14').AsCurrency;
      CostAmount15 := CostAmount15 + qryMain.FieldByName('CostAmount15').AsCurrency;
      SoldAmount15 := SoldAmount15 + qryMain.FieldByName('SoldAmount15').AsCurrency;
      CostAmount16 := CostAmount16 + qryMain.FieldByName('CostAmount16').AsCurrency;
      SoldAmount16 := SoldAmount16 + qryMain.FieldByName('SoldAmount16').AsCurrency;
      CostAmount17 := CostAmount17 + qryMain.FieldByName('CostAmount17').AsCurrency;
      SoldAmount17 := SoldAmount17 + qryMain.FieldByName('SoldAmount17').AsCurrency;
      CostAmount18 := CostAmount18 + qryMain.FieldByName('CostAmount18').AsCurrency;
      SoldAmount18 := SoldAmount18 + qryMain.FieldByName('SoldAmount18').AsCurrency;
      CostAmount19 := CostAmount19 + qryMain.FieldByName('CostAmount19').AsCurrency;
      SoldAmount19 := SoldAmount19 + qryMain.FieldByName('SoldAmount19').AsCurrency;
      CostAmount20 := CostAmount20 + qryMain.FieldByName('CostAmount20').AsCurrency;
      SoldAmount20 := SoldAmount20 + qryMain.FieldByName('SoldAmount20').AsCurrency;
      CostAmount21 := CostAmount21 + qryMain.FieldByName('CostAmount21').AsCurrency;
      SoldAmount21 := SoldAmount21 + qryMain.FieldByName('SoldAmount21').AsCurrency;
      CostAmount22 := CostAmount22 + qryMain.FieldByName('CostAmount22').AsCurrency;
      SoldAmount22 := SoldAmount22 + qryMain.FieldByName('SoldAmount22').AsCurrency;
      CostAmount23 := CostAmount23 + qryMain.FieldByName('CostAmount23').AsCurrency;
      SoldAmount23 := SoldAmount23 + qryMain.FieldByName('SoldAmount23').AsCurrency;
      CostAmount24 := CostAmount24 + qryMain.FieldByName('CostAmount24').AsCurrency;
      SoldAmount24 := SoldAmount24 + qryMain.FieldByName('SoldAmount24').AsCurrency;
      CostAmount25 := CostAmount25 + qryMain.FieldByName('CostAmount25').AsCurrency;
      SoldAmount25 := SoldAmount25 + qryMain.FieldByName('SoldAmount25').AsCurrency;
      CostAmount26 := CostAmount26 + qryMain.FieldByName('CostAmount26').AsCurrency;
      SoldAmount26 := SoldAmount26 + qryMain.FieldByName('SoldAmount26').AsCurrency;
      CostAmount27 := CostAmount27 + qryMain.FieldByName('CostAmount27').AsCurrency;
      SoldAmount27 := SoldAmount27 + qryMain.FieldByName('SoldAmount27').AsCurrency;
      CostAmount28 := CostAmount28 + qryMain.FieldByName('CostAmount28').AsCurrency;
      SoldAmount28 := SoldAmount28 + qryMain.FieldByName('SoldAmount28').AsCurrency;
      CostAmount29 := CostAmount29 + qryMain.FieldByName('CostAmount29').AsCurrency;
      SoldAmount29 := SoldAmount29 + qryMain.FieldByName('SoldAmount29').AsCurrency;
      CostAmount30 := CostAmount30 + qryMain.FieldByName('CostAmount30').AsCurrency;
      SoldAmount30 := SoldAmount30 + qryMain.FieldByName('SoldAmount30').AsCurrency;
      CostAmount31 := CostAmount31 + qryMain.FieldByName('CostAmount31').AsCurrency;
      SoldAmount31 := SoldAmount31 + qryMain.FieldByName('SoldAmount31').AsCurrency;
      CostAmount32 := CostAmount32 + qryMain.FieldByName('CostAmount32').AsCurrency;
      SoldAmount32 := SoldAmount32 + qryMain.FieldByName('SoldAmount32').AsCurrency;
      CostAmount33 := CostAmount33 + qryMain.FieldByName('CostAmount33').AsCurrency;
      SoldAmount33 := SoldAmount33 + qryMain.FieldByName('SoldAmount33').AsCurrency;
      CostAmount34 := CostAmount34 + qryMain.FieldByName('CostAmount34').AsCurrency;
      SoldAmount34 := SoldAmount34 + qryMain.FieldByName('SoldAmount34').AsCurrency;
      CostAmount35 := CostAmount35 + qryMain.FieldByName('CostAmount35').AsCurrency;
      SoldAmount35 := SoldAmount35 + qryMain.FieldByName('SoldAmount35').AsCurrency;
      CostAmount36 := CostAmount36 + qryMain.FieldByName('CostAmount36').AsCurrency;
      SoldAmount36 := SoldAmount36 + qryMain.FieldByName('SoldAmount36').AsCurrency;
      CostAmount37 := CostAmount37 + qryMain.FieldByName('CostAmount37').AsCurrency;
      SoldAmount37 := SoldAmount37 + qryMain.FieldByName('SoldAmount37').AsCurrency;
      CostAmount38 := CostAmount38 + qryMain.FieldByName('CostAmount38').AsCurrency;
      SoldAmount38 := SoldAmount38 + qryMain.FieldByName('SoldAmount38').AsCurrency;
      CostAmount39 := CostAmount39 + qryMain.FieldByName('CostAmount39').AsCurrency;
      SoldAmount39 := SoldAmount39 + qryMain.FieldByName('SoldAmount39').AsCurrency;
      CostAmount40 := CostAmount40 + qryMain.FieldByName('CostAmount40').AsCurrency;
      SoldAmount40 := SoldAmount40 + qryMain.FieldByName('SoldAmount40').AsCurrency;
      TotalCostAmount := TotalCostAmount + qryMain.FieldByName('TotalCostAmount').AsCurrency;
      TotalSoldAmount := TotalSoldAmount + qryMain.FieldByName('TotalSoldAmount').AsCurrency;

      Next;
    end;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('CostAmount1').FooterValue := FloatToStrF(CostAmount1, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount2').FooterValue := FloatToStrF(CostAmount2, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount3').FooterValue := FloatToStrF(CostAmount3, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount4').FooterValue := FloatToStrF(CostAmount4, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount5').FooterValue := FloatToStrF(CostAmount5, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount6').FooterValue := FloatToStrF(CostAmount6, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount7').FooterValue := FloatToStrF(CostAmount7, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount8').FooterValue := FloatToStrF(CostAmount8, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount9').FooterValue := FloatToStrF(CostAmount9, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount10').FooterValue := FloatToStrF(CostAmount10, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount11').FooterValue := FloatToStrF(CostAmount11, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount12').FooterValue := FloatToStrF(CostAmount12, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount13').FooterValue := FloatToStrF(CostAmount13, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount14').FooterValue := FloatToStrF(CostAmount14, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount15').FooterValue := FloatToStrF(CostAmount15, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount16').FooterValue := FloatToStrF(CostAmount16, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount17').FooterValue := FloatToStrF(CostAmount17, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount18').FooterValue := FloatToStrF(CostAmount18, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount19').FooterValue := FloatToStrF(CostAmount19, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount20').FooterValue := FloatToStrF(CostAmount20, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount21').FooterValue := FloatToStrF(CostAmount21, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount22').FooterValue := FloatToStrF(CostAmount22, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount23').FooterValue := FloatToStrF(CostAmount23, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount24').FooterValue := FloatToStrF(CostAmount24, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount25').FooterValue := FloatToStrF(CostAmount25, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount26').FooterValue := FloatToStrF(CostAmount26, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount27').FooterValue := FloatToStrF(CostAmount27, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount28').FooterValue := FloatToStrF(CostAmount28, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount29').FooterValue := FloatToStrF(CostAmount29, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount30').FooterValue := FloatToStrF(CostAmount30, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount31').FooterValue := FloatToStrF(CostAmount31, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount32').FooterValue := FloatToStrF(CostAmount32, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount33').FooterValue := FloatToStrF(CostAmount33, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount34').FooterValue := FloatToStrF(CostAmount34, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount35').FooterValue := FloatToStrF(CostAmount35, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount36').FooterValue := FloatToStrF(CostAmount36, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount37').FooterValue := FloatToStrF(CostAmount37, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount38').FooterValue := FloatToStrF(CostAmount38, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount39').FooterValue := FloatToStrF(CostAmount39, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CostAmount40').FooterValue := FloatToStrF(CostAmount40, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount1').FooterValue := FloatToStrF(SoldAmount1, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount2').FooterValue := FloatToStrF(SoldAmount2, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount3').FooterValue := FloatToStrF(SoldAmount3, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount4').FooterValue := FloatToStrF(SoldAmount4, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount5').FooterValue := FloatToStrF(SoldAmount5, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount6').FooterValue := FloatToStrF(SoldAmount6, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount7').FooterValue := FloatToStrF(SoldAmount7, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount8').FooterValue := FloatToStrF(SoldAmount8, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount9').FooterValue := FloatToStrF(SoldAmount9, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount10').FooterValue := FloatToStrF(SoldAmount10, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount11').FooterValue := FloatToStrF(SoldAmount11, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount12').FooterValue := FloatToStrF(SoldAmount12, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount13').FooterValue := FloatToStrF(SoldAmount13, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount14').FooterValue := FloatToStrF(SoldAmount14, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount15').FooterValue := FloatToStrF(SoldAmount15, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount16').FooterValue := FloatToStrF(SoldAmount16, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount17').FooterValue := FloatToStrF(SoldAmount17, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount18').FooterValue := FloatToStrF(SoldAmount18, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount19').FooterValue := FloatToStrF(SoldAmount19, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount20').FooterValue := FloatToStrF(SoldAmount20, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount21').FooterValue := FloatToStrF(SoldAmount21, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount22').FooterValue := FloatToStrF(SoldAmount22, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount23').FooterValue := FloatToStrF(SoldAmount23, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount24').FooterValue := FloatToStrF(SoldAmount24, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount25').FooterValue := FloatToStrF(SoldAmount25, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount26').FooterValue := FloatToStrF(SoldAmount26, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount27').FooterValue := FloatToStrF(SoldAmount27, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount28').FooterValue := FloatToStrF(SoldAmount28, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount29').FooterValue := FloatToStrF(SoldAmount29, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount30').FooterValue := FloatToStrF(SoldAmount30, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount31').FooterValue := FloatToStrF(SoldAmount31, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount32').FooterValue := FloatToStrF(SoldAmount32, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount33').FooterValue := FloatToStrF(SoldAmount33, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount34').FooterValue := FloatToStrF(SoldAmount34, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount35').FooterValue := FloatToStrF(SoldAmount35, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount36').FooterValue := FloatToStrF(SoldAmount36, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount37').FooterValue := FloatToStrF(SoldAmount37, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount38').FooterValue := FloatToStrF(SoldAmount38, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount39').FooterValue := FloatToStrF(SoldAmount39, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SoldAmount40').FooterValue := FloatToStrF(SoldAmount40, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalCostAmount').FooterValue := FloatToStrF(TotalCostAmount, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalSoldAmount').FooterValue := FloatToStrF(TotalSoldAmount, ffCurrency, 15, CurrencyRoundPlaces); *)
end;

//function TSalesSummaryReportGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtFrom.DateTime = PrevDateFrom) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateFrom := dtFrom.DateTime;
//end;

//function TSalesSummaryReportGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtTo.DateTime = PrevDateTo) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateTo := dtTo.DateTime;
//end;

procedure TSalesSummaryReportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    AddDataToTempSaleSummaryTable;
    RefreshQuery;
  end;
end;

procedure TSalesSummaryReportGUI.grdMainDblClick(Sender: TObject);
{var
  frmList: TBaseListingGUI;}
begin
{  inherited;

    frmList := TBaseListingGUI(TSalesReportGUI.Create(Application));
    frmList.dtFrom.DateTime := self.dtFrom.DateTime;
    frmList.dtTo.DateTime := self.dtTo.DateTime;
    frmList.fbDateRangeSupplied := true;
    frmList.FormStyle := fsmdiChild; }
end;

initialization
  RegisterClassOnce(TSalesSummaryReportGUI);
end.
