unit SalesAnalysisManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox;

type
  TSalesAnalysisManualGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDateofReport: TDateField;
    qryMainDateFrom: TDateField;
    qryMainDateTo: TDateField;
    qryMainCreatedOn: TDateField;
    qryMaincomments: TWideMemoField;
    qryMainActive: TWideStringField;
    qryMainemployeename: TWideStringField;
    qryMainGooglevisitcount: TLargeIntField;
    qryMainColdCalls: TLargeIntField;
    qryMainContact: TLargeIntField;
    qryMainFirstDemo: TLargeIntField;
    qryMainSecondDemo: TLargeIntField;
    qryMainQuotes: TLargeIntField;
    qryMainSalesOrders: TLargeIntField;
    qryMainSales: TLargeIntField;
    qryMainRatio: TFloatField;
    qryMainCOS: TFloatField;
    qryMaindetails: TLargeintField;
    qryMainSource: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    procedure BuildMainSQL;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
procedure TSalesAnalysisManualGUI.BuildMainSQL;
const
  csMainSummary = 'select 1 as details, ID, DateOfReport, DateFrom, DateTo, CreatedOn, Comments, Active, Employeename,'#13#10 +
                  'Googlevisitcount, ColdCalls, Contact, FirstDemo, SecondDemo, Quotes, SalesOrders, Sales,'#13#10 +
                  '(ifnull(Sales, 0) * 100) / ifnull(ColdCalls, 1) as Ratio,'#13#10 +
                  'ifnull(BudgetCost, 0) / ifnull(Sales, 1) as COS, "" as Source'#13#10 +
                  'from ( Select'#13#10 +
                  'R.ID as ID,'#13#10 +
                  'R.DateofReport as DateofReport,'#13#10 +
                  'R.DateFrom as DateFrom,'#13#10 +
                  'R.DateTo as DateTo,'#13#10 +
                  'R.CreatedOn as CreatedOn,'#13#10 +
                  'R.comments as comments,'#13#10 +
                  'R.Active as Active,'#13#10 +
                  'E.employeename as employeename,'#13#10 +
                  'Convert(R.Googlevisitcount, signed) as Googlevisitcount,'#13#10 +
                  'Convert(Sum(RL.ColdCalls),signed) as ColdCalls,'#13#10 +
                  'Convert(Sum(RL.Contact),signed) as Contact ,'#13#10 +
                  'Convert(Sum(RL.FirstDemo),signed) as FirstDemo,'#13#10 +
                  'Convert(Sum(RL.SecondDemo), signed) as SecondDemo,'#13#10 +
                  'Convert(Sum(RL.Quotes),signed) as Quotes,'#13#10 +
                  'Convert(Sum(RL.SalesOrders),signed) as SalesOrders,'#13#10 +
                  'Convert(Sum(RL.Sales),signed) as Sales,'#13#10 +
                  'Convert(Sum(RL.BudgetCost), signed) as BudgetCost'#13#10 +
                  'from tblSalesAnalysisManual R'#13#10 +
                  'inner join tblSalesAnalysisManuallines RL on R.Id = RL.SalesAnalysisID'#13#10 +
                  'inner join tblemployees E on R.createdby = E.employeeID'#13#10 +
                  'Where'#13#10 +
                  '(R.DateFrom >= :dateFrom and R.DateFrom <= :DateTo) or'#13#10 +
                  '(R.Dateto >= :dateFrom and R.Dateto <= :DateTo) or'#13#10 +
                  '(R.DateFrom  <= :dateFrom and R.Dateto >= :DateTo)'#13#10 +
                  'GROUP BY R.ID) T';
  csMainDetails = #13#10'union all'#13#10 +
                  'select 2 as details, ID, DateOfReport, DateFrom, DateTo, CreatedOn, Comments, Active, Employeename,'#13#10 +
                  'Googlevisitcount, ColdCalls, Contact, FirstDemo, SecondDemo, Quotes, SalesOrders, Sales,'#13#10 +
                  '(ifnull(Sales, 0) * 100) / ifnull(ColdCalls, 1) as Ratio,'#13#10 +
                  'ifnull(BudgetCost, 0) / ifnull(Sales, 1) as COS, Source'#13#10 +
                  'from (Select'#13#10 +
                  'R.ID as ID,'#13#10 +
                  'R.DateofReport as DateofReport,'#13#10 +
                  'R.DateFrom as DateFrom,'#13#10 +
                  'R.DateTo as DateTo,'#13#10 +
                  'R.CreatedOn as CreatedOn,'#13#10 +
                  'R.comments as comments,'#13#10 +
                  'R.Active as Active,'#13#10 +
                  'RL.employeename as employeename,'#13#10 +
                  'R.Googlevisitcount as  Googlevisitcount,'#13#10 +
                  'RL.ColdCalls as ColdCalls,'#13#10 +
                  'RL.Contact as Contact ,'#13#10 +
                  'RL.FirstDemo as FirstDemo,'#13#10 +
                  'RL.SecondDemo as SecondDemo,'#13#10 +
                  'RL.Quotes as Quotes,'#13#10 +
                  'RL.SalesOrders as SalesOrders,'#13#10 +
                  'RL.Sales as Sales,'#13#10 +
                  'RL.BudgetCost as  BudgetCost,'#13#10 +
                  'RL.Source from tblSalesAnalysisManual R'#13#10 +
                  'inner join tblSalesAnalysisManuallines RL on R.Id = RL.SalesAnalysisID'#13#10 +
                  'Where'#13#10 +
                  '(R.DateFrom >= :dateFrom and R.DateFrom <= :DateTo) or'#13#10 +
                  '(R.Dateto >= :dateFrom and R.Dateto <= :DateTo) or'#13#10 +
                  '(R.DateFrom  <= :dateFrom and R.Dateto >= :DateTo) ) T'#13#10 +
                  'order by Details, DateFrom';


begin
  case grpFilters.ItemIndex of
    0 : qryMain.SQL.Text := csMainSummary + #13#10'ORDER BY DateFRom';
    1 : qryMain.SQL.Text := csMainSummary + csMainDetails;
  end;
end;

procedure TSalesAnalysisManualGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmSalesAnalysisManual' , 0);
end;

procedure TSalesAnalysisManualGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;

  if grpFilters.ItemIndex = 1 then  // Details
  begin
    if qryMainDetails.AsInteger = 1 then
      AFont.Style := [fsBold]
  end
  else if grpFilters.ItemIndex = 0 then // Summary
    AFont.Style := [fsBold]
  else
    AFont.Style := [];
end;

procedure TSalesAnalysisManualGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
//
  RefreshQuery;
end;


procedure TSalesAnalysisManualGUI.RefreshQuery;
begin
  BuildMainSQL;
  Qrymain.ParamByName('dateFrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime := FilterDateTo;
  inherited;
  if chkIgnoreDates.Checked = false then
    TimerMsg(lblDateComments , 'List refreshes the ''Sales Summary (Manual)'' records with ''Date From''  or ''Date To'' falls within the selected date range - ' + Quotedstr(formatDateTime(FormatSettings.ShortDateFormat , filterDateFrom)) +'  and ' + Quotedstr(formatDateTime(FormatSettings.ShortDateFormat , filterDateto)));
end;

initialization
  RegisterClassOnce(TSalesAnalysisManualGUI);
end.

