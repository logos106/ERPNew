unit SummarySheetReportSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type
  TSummarySheetReport = class(TReportBase)
  private
    fDateTo: TDateTime;
    fDateFromCustom: TDateTime;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    property DateFromCustom: TDateTime read fDateFromCustom write fDateFromCustom;
    property DateTo: TDateTime read fDateTo write fDateTo;
  end;

implementation

uses
  DateUtils, SummarySheetObj;

{ TSummarySheetReport }

constructor TSummarySheetReport.Create;
begin
  inherited;
  fDateTo := Trunc(Date);
  fDateFromCustom := IncYear(fDateTo, -2);
end;

destructor TSummarySheetReport.Destroy;
begin

  inherited;
end;

function TSummarySheetReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
var
  SSO: TSummarySheetObj;
begin
  result := inherited;
  SSO := TSummarySheetObj.Create(nil);
  try
    SSO.DateTo := DateTo;
    SSO.DateFromCustom := DateFromCustom;
    SSO.LoadValues;
    SQL.Text := 'select ' +
      FloatToStr(SSO.TotalCashInBank) + ' as CashInBank, ' +
      FloatToStr(SSO.TotalAR) + ' as AccountsReceivable, ' +
      FloatToStr(SSO.TotalAP) + ' as AccountsPayable, ' +
      FloatToStr(SSO.TotalBalanceSheet) + ' as BalanceSheet, ' +

      FloatToStr(SSO.AR_Current) + ' as AR_Current, ' +
      FloatToStr(SSO.AR_1to30) + ' as AR_1to30, ' +
      FloatToStr(SSO.AR_31to60) + ' as AR_31to60, ' +
      FloatToStr(SSO.AR_61to90) + ' as AR_61to90, ' +
      FloatToStr(SSO.AR_90Plus) + ' as AR_90Plus, ' +

      FloatToStr(SSO.AR_CurrentPercent) + ' as AR_Current_Percent, ' +
      FloatToStr(SSO.AR_1to30Percent) + ' as AR_1to30_Percent, ' +
      FloatToStr(SSO.AR_31to60Percent) + ' as AR_31to60_Percent, ' +
      FloatToStr(SSO.AR_61to90Percent) + ' as AR_61to90_Percent, ' +
      FloatToStr(SSO.AR_90PlusPercent) + ' as AR_90Plus_Percent, ' +

      FloatToStr(SSO.AP_Current) + ' as AP_Current, ' +
      FloatToStr(SSO.AP_1to30) + ' as AP_1to30, ' +
      FloatToStr(SSO.AP_31to60) + ' as AP_31to60, ' +
      FloatToStr(SSO.AP_61to90) + ' as AP_61to90, ' +
      FloatToStr(SSO.AP_90Plus) + ' as AP_90Plus, ' +

      FloatToStr(SSO.AP_CurrentPercent) + ' as AP_Current_Percent, ' +
      FloatToStr(SSO.AP_1to30Percent) + ' as AP_1to30_Percent, ' +
      FloatToStr(SSO.AP_31to60Percent) + ' as AP_31to60_Percent, ' +
      FloatToStr(SSO.AP_61to90Percent) + ' as AP_61to90_Percent, ' +
      FloatToStr(SSO.AP_90PlusPercent) + ' as AP_90Plus_Percent, ' +

      FloatToStr(SSO.Sales_Week) + ' as Sales_Week, ' +
      FloatToStr(SSO.Sales_Month) + ' as Sales_Month, ' +
      FloatToStr(SSO.Sales_Quarter) + ' as Sales_3Month, ' +
      FloatToStr(SSO.Sales_HalfYear) + ' as Sales_6Month, ' +
      FloatToStr(SSO.Sales_Year) + ' as Sales_Year, ' +
      FloatToStr(SSO.Sales_Custom) + ' as Sales_Custom, ' +

      FloatToStr(SSO.COGS_Week) + ' as COGS_Week, ' +
      FloatToStr(SSO.COGS_Month) + ' as COGS_Month, ' +
      FloatToStr(SSO.COGS_Quarter) + ' as COGS_3Month, ' +
      FloatToStr(SSO.COGS_HalfYear) + ' as COGS_6Month, ' +
      FloatToStr(SSO.COGS_Year) + ' as COGS_Year, ' +
      FloatToStr(SSO.COGS_Custom) + ' as COGS_Custom, ' +

      FloatToStr(SSO.Expenses_Week) + ' as Expenses_Week, ' +
      FloatToStr(SSO.Expenses_Month) + ' as Expenses_Month, ' +
      FloatToStr(SSO.Expenses_Quarter) + ' as Expenses_3Month, ' +
      FloatToStr(SSO.Expenses_HalfYear) + ' as Expenses_6Month, ' +
      FloatToStr(SSO.Expenses_Year) + ' as Expenses_Year, ' +
      FloatToStr(SSO.Expenses_Custom) + ' as Expenses_Custom, ' +

      FloatToStr(SSO.PnL_Week) + ' as PnL_Week, ' +
      FloatToStr(SSO.PnL_Month) + ' as PnL_Month, ' +
      FloatToStr(SSO.PnL_Quarter) + ' as PnL_3Month, ' +
      FloatToStr(SSO.PnL_HalfYear) + ' as PnL_6Month, ' +
      FloatToStr(SSO.PnL_Year) + ' as PnL_Year, ' +
      FloatToStr(SSO.PnL_Custom) + ' as PnL_Custom ' +

      'from dual';
  finally
    SSO.Free;
  end;
end;

initialization
  RegisterClass(TSummarySheetReport);

end.
