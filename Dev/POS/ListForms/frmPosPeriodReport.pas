unit frmPosPeriodReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TfmPosPeriodReport = class(TBaseListingGUI)
    qryMainTillName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainSaleMonth: TWideStringField;
    qryMainSaleWeekOfYear: TLargeintField;
    qryMainSaleDayName: TWideStringField;
    qryMainCash: TFloatField;
    qryMainEFTPOS: TFloatField;
    qryMainDebitCard: TFloatField;
    qryMainCheque: TFloatField;
    qryMainDinersClub: TFloatField;
    qryMainMasterCard: TFloatField;
    qryMainVISA: TFloatField;
    qryMainAmex: TFloatField;
    qryMainAmericanExpress: TFloatField;
    qryMainBankCard: TFloatField;
    qryMainCreditCard: TFloatField;
    qryMainDirectDebt: TFloatField;
    qryMainDirectDeposit: TFloatField;
    qryMainMoneyOrder: TFloatField;
    qryMainLayby: TFloatField;
    qryMainVoucher: TFloatField;
    qryMainVoucherReversal: TFloatField;
    qryMainInvoice: TFloatField;
    qryMainTotals: TFloatField;
    qryMainSaleQuarter: TLargeintField;
    qryMainSaleYear: TLargeintField;
  private
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

var
  fmPosPeriodReport: TfmPosPeriodReport;

implementation

{$R *.dfm}


{ TfmPosPeriodReport }

procedure TfmPosPeriodReport.ApplyQueryFilter;
begin
  inherited;
  RefreshQuery;
end;

procedure TfmPosPeriodReport.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('Select');
  qryMain.SQL.Add('tblPosTills.TillName,');
  qryMain.SQL.Add('S.SaleDate,');
  qryMain.SQL.Add('Convert(Year(S.SaleDate),Unsigned) as SaleYear,');
  qryMain.SQL.Add('Convert(Quarter(S.SaleDate),Unsigned) as SaleQuarter,');
  qryMain.SQL.Add('MonthName(S.SaleDate) as SaleMonth,');
  qryMain.SQL.Add('Convert(WeekOfYear(S.SaleDate),Unsigned) as SaleWeekOfYear,');
  qryMain.SQL.Add('DATE_FORMAT(S.SaleDate, "%W") as SaleDayName,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Cash"),SP.Amount,0.00)) as Cash,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("E.F.T."),SP.Amount,0.00)) as EFTPOS,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Debit Card"),SP.Amount,0.00)) as DebitCard,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Cheque"),SP.Amount,0.00)) as Cheque,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Diners Club"),SP.Amount,0.00)) as DinersClub,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Master Card"),SP.Amount,0.00)) as MasterCard,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("VISA"),SP.Amount,0.00)) as VISA,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Amex"),SP.Amount,0.00)) as Amex,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("American Express"),SP.Amount,0.00)) as AmericanExpress,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("BankCard"),SP.Amount,0.00)) as BankCard,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Credit Card"),SP.Amount,0.00)) as CreditCard,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Direct Debt"),SP.Amount,0.00)) as DirectDebt,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Direct Deposit"),SP.Amount,0.00)) as DirectDeposit,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Money Order"),SP.Amount,0.00)) as MoneyOrder,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Layby"),SP.Amount,0.00)) as Layby,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Voucher"),SP.Amount,0.00)) as Voucher,');
  qryMain.SQL.Add('Sum(If(UCase(SP.Paymethod)=UCase("Voucher Reversal"),SP.Amount,0.00)) as VoucherReversal,');
  qryMain.SQL.Add('Sum(If(not ISNULL(SP.PaymentId), 0.00, S.TotalAmountInc)) as Invoice,');
  qryMain.SQL.Add('Sum(If(not ISNULL(SP.PaymentId), SP.Amount, S.TotalAmountInc)) as Totals');
  qryMain.SQL.Add('From tblSales S');
  qryMain.SQL.Add('Left Join tblsalespayments SP Using(SaleID)');
  qryMain.SQL.Add('left join tblPosTills on tblPosTills.TillId = S.TillId');
  qryMain.SQL.Add('WHERE (S.IsInvoice="T" OR S.IsPOS="T")');
  qryMain.SQL.Add('AND IfNull(S.TillId,0) <> 0');
  qryMain.SQL.Add('AND S.SaleDate Between :dtFrom And :dtTo');
  qryMain.SQL.Add('Group By S.TillId');
  case grpFilters.ItemIndex of
    0: begin
         qryMain.SQL.Add(',Year(S.SaleDate),DayOfYear(S.SaleDate)'); { Day }
//         GuiPrefs.DbGridElement[grdMain].AddFields('SaleQuarter,SaleMonth,SaleWeekOfYear,SaleDayName');
       end;
    1: begin
         qryMain.SQL.Add(',Year(S.SaleDate),WeekOfYear(S.SaleDate)'); { Week }
//         GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleDayName');
//         GuiPrefs.DbGridElement[grdMain].AddFields('SaleQuarter,SaleMonth,SaleWeekOfYear');
       end;
    2: begin
         qryMain.SQL.Add(',Year(S.SaleDate),Month(S.SaleDate)'); { Month }
//         GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleDayName,SaleWeekOfYear');
//         GuiPrefs.DbGridElement[grdMain].AddFields('SaleQuarter,SaleMonth');
       end;
    3: begin
         qryMain.SQL.Add(',Year(S.SaleDate),Quarter(S.SaleDate)'); { Quarter }
//         GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleDayName,SaleWeekOfYear,SaleMonth');
//         GuiPrefs.DbGridElement[grdMain].AddFields('SaleQuarter');
       end;
    4: begin
         qryMain.SQL.Add(',Year(S.SaleDate)'); { Quarter }
//         GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleDayName,SaleWeekOfYear,SaleMonth,SalesQuarter');
       end;
  end;
  qryMain.SQL.Add('Order By tblPosTills.TillName, S.SaleDate');
  qryMain.ParamByName('dtFrom').AsDate:= dtFrom.Date;
  qryMain.ParamByName('dtTo').AsDate:= dtTo.Date;
  RefreshOrignalSQL;

  inherited;

end;

initialization
  RegisterClass(TfmPosPeriodReport);


end.
