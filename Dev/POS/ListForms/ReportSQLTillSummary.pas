unit ReportSQLTillSummary;

interface

uses
  ReportSQLBase, Classes;

type

  TReportSQLTillSummary = Class(TReportSQLBase)
  private
    fClassId: integer;
  protected
    function GetTemplateSQL: String; override;
    function GetReportTypeID: integer; override;
  public
    function PrepareForReport: Boolean; override;
    constructor Create(Aowner: TComponent); override;
    Destructor Destroy; override;
    property ClassId: integer read fClassId write fClassId; { 0 = all classes }
    procedure PopulateTemporyTable;
  end;


implementation

uses
  SysUtils, TempTableUtils, ERPDbComponents, BusObjectListObj;

{ TReportSQLTillSummary }

constructor TReportSQLTillSummary.Create(Aowner: TComponent);
begin
  inherited;
  fClassId := 0; { all by default }
  TempTableName := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection,'tmp_TillSummary','');
end;

destructor TReportSQLTillSummary.Destroy;
begin

  inherited;
end;

function TReportSQLTillSummary.GetReportTypeID: integer;
begin
  result := 138;
end;

function TReportSQLTillSummary.GetTemplateSQL: String;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    SL.Add('{CompanyInfo}');
    SL.Add('SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO');
    SL.Add('~|||~{SQL}');
    SL.Add('SELECT ID,');
    SL.Add('tblPosTills.TillName,');
    SL.Add('SaleDate,');
    SL.Add('Class ,');
    SL.Add('TSR.GlobalRef,');
    SL.Add('InvoiceDocNumber,');
    SL.Add('SaleType,');
    SL.Add('TSR.Cash as Cash,');
    SL.Add('TSR.EFTPOS as EFTPOS,');
    SL.Add('TSR.DebitCard as DebitCard,');
    SL.Add('TSR.Cheque as Cheque,');
    SL.Add('TSR.DinersClub as DinersClub,');
    SL.Add('TSR.MasterCard as MasterCard,');
    SL.Add('TSR.VISA as VISA,');
    SL.Add('TSR.Amex as Amex,');
    SL.Add('TSR.AmericanExpress as AmericanExpress,');
    SL.Add('TSR.BankCard as BankCard,');
    SL.Add('TSR.CreditCard as CreditCard,');
    SL.Add('TSR.DirectDebt as DirectDebt,');
    SL.Add('TSR.DirectDeposit as DirectDeposit,');
    SL.Add('TSR.MoneyOrder as MoneyOrder,');
    SL.Add('TSR.Layby as Layby,');
    SL.Add('TSR.Voucher as Voucher,');
    SL.Add('TSR.VoucherReversal as VoucherReversal,');
    SL.Add('TSR.Invoice as Invoice,');
    SL.Add('Totals as Total,');
    SL.Add('Count(TSR.GlobalRef) as SalesCount,');
//    SL.Add('(select CAST(Sum(tblPosTillEOP.TrafficCount) as SIGNED) from tblPosTillEOP where tblPosTillEOP.TillId = TSR.TillId and tblPosTillEOP.EndDate Between :txtfrom1 AND :txtto1) as TrafficCount,');
    SL.Add('(select CAST(Sum(tblPosTillEOP.TrafficCount) as SIGNED) from tblPosTillEOP '+
                                                                    ' where tblPosTillEOP.TillId = TSR.TillId and  '+
                                                                    ' tblPosTillEOP.EndDate Between ' + DFromStr + ' AND ' + DToStr + ') as TrafficCount,');

    SL.Add('Sum(Totals)/Count(TSR.GlobalRef) as TotalsAvg,');
    SL.Add('SaleID,');
    SL.Add('EmployeeName');
    SL.Add('FROM ' + TempTableName + ' TSR');
    SL.Add('left join tblPosTills on tblPosTills.TillId = TSR.TillId');
    SL.Add('WHERE SaleDate Between ' + DFromStr + ' AND ' + DToStr);
    if ClassId > 0 then
      SL.Add('and ClassID = ' + IntToStr(ClassId));
    SL.Add('Group By PaymentID');
    SL.Add('~|||~{DateRange}select Cast('+DFromStr+' as DateTime) as DateFrom, Cast('+DToStr+' as DateTime) as DateTo');

    result := sl.Text;
  finally
    sl.Free;
  end;
end;

procedure TReportSQLTillSummary.PopulateTemporyTable;
var
  qryTemp: TERPCommand;
  InsertSQL: string;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.Text := 'truncate ' + TempTableName;
    qryTemp.Execute;

    InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + TempTableName + '(TillId,SaleDate,GlobalRef,InvoiceDocNumber,Cash,EFTPOS,DebitCard,Cheque,DinersClub,MasterCard,' + 'VISA,Amex,AmericanExpress,BankCard,CreditCard,DirectDebt,DirectDeposit,MoneyOrder,' + 'Layby,Voucher,VoucherReversal,Invoice,Totals,Class,ClassID,SaleID,PaymentID,SaleType,EmployeeName)';
    qryTemp.SQL.Clear;

    qryTemp.Sql.Add(InsertSQL);
    (*
    qryTemp.Sql.Add('Select TillId, ');
    qryTemp.Sql.Add('S.SaleDate, ');
    qryTemp.Sql.Add('S.GlobalRef, ');
    qryTemp.Sql.Add('S.InvoiceDocNumber, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Cash"),SP.Amount,0.00) as Cash, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("E.F.T."),SP.Amount,0.00) as EFTPOS, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Debit Card"),SP.Amount,0.00) as DebitCard, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Cheque"),SP.Amount,0.00) as Cheque, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Diners Club"),SP.Amount,0.00) as DinersClub, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Master Card"),SP.Amount,0.00) as MasterCard, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("VISA"),SP.Amount,0.00) as VISA, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Amex"),SP.Amount,0.00) as Amex, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("American Express"),SP.Amount,0.00) as AmericanExpress, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("BankCard"),SP.Amount,0.00) as BankCard, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Credit Card"),SP.Amount,0.00) as CreditCard, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Direct Debt"),SP.Amount,0.00) as DirectDebt, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Direct Deposit"),SP.Amount,0.00) as DirectDeposit, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Money Order"),SP.Amount,0.00) as MoneyOrder, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Layby"),SP.Amount,0.00) as Layby, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Voucher"),SP.Amount,0.00) as Voucher, ');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Voucher Reversal"),SP.Amount,0.00) as VoucherReversal, ');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), 0.00, S.TotalAmountInc) as Invoice, ');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), SP.Amount, S.TotalAmountInc) as Totals, ');
    qryTemp.Sql.Add('S.Class, ');
    qryTemp.Sql.Add('S.ClassID, ');
    qryTemp.Sql.Add('S.SaleID, ');
    qryTemp.Sql.Add('SP.PaymentID, ');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), "Till", "Invoice") as SaleType,');
    qryTemp.Sql.Add('S.EmployeeName ');
    qryTemp.Sql.Add('From tblSales S ');
    qryTemp.Sql.Add('Left Join tblsalespayments SP Using(SaleID) ');
    qryTemp.Sql.Add('WHERE (S.IsInvoice="T" OR S.IsPOS="T") ');
    qryTemp.Sql.Add('AND S.TillId > 0 ');
    qryTemp.Sql.Add('AND not Isnull(S.TillId) ');
    qryTemp.Sql.Add('AND S.SaleDate Between ' + DFromStr + ' and ' + DToStr);
    if ClassId > 0 then
      qryTemp.Sql.Add('AND S.classId = ' + inttostr(ClassId));
    qryTemp.Execute;
    *)

    qryTemp.Sql.Add('select * from (');
    qryTemp.Sql.Add('Select TillId,');
    qryTemp.Sql.Add('S.SaleDate,');
    qryTemp.Sql.Add('S.GlobalRef,');
    qryTemp.Sql.Add('S.InvoiceDocNumber,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Cash"),SP.Amount,0.00) as Cash,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("E.F.T."),SP.Amount,0.00) as EFTPOS,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Debit Card"),SP.Amount,0.00) as DebitCard,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Cheque"),SP.Amount,0.00) as Cheque,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Diners Club"),SP.Amount,0.00) as DinersClub,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Master Card"),SP.Amount,0.00) as MasterCard,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("VISA"),SP.Amount,0.00) as VISA,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Amex"),SP.Amount,0.00) as Amex,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("American Express"),SP.Amount,0.00) as AmericanExpress,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("BankCard"),SP.Amount,0.00) as BankCard,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Credit Card"),SP.Amount,0.00) as CreditCard,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Direct Debt"),SP.Amount,0.00) as DirectDebt,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Direct Deposit"),SP.Amount,0.00) as DirectDeposit,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Money Order"),SP.Amount,0.00) as MoneyOrder,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Layby"),SP.Amount,0.00) as Layby,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Voucher"),SP.Amount,0.00) as Voucher,');
    qryTemp.Sql.Add('If(UCase(SP.Paymethod)=UCase("Voucher Reversal"),SP.Amount,0.00) as VoucherReversal,');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), 0.00, S.TotalAmountInc) as Invoice,');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), SP.Amount, S.TotalAmountInc) as Totals,');
    qryTemp.Sql.Add('S.Class,');
    qryTemp.Sql.Add('S.ClassID,');
    qryTemp.Sql.Add('S.SaleID,');
    qryTemp.Sql.Add('SP.PaymentID,');
    qryTemp.Sql.Add('If(not ISNULL(SP.PaymentId), "Till", "Invoice") as SaleType,');
    qryTemp.Sql.Add('S.EmployeeName');
    qryTemp.Sql.Add('From tblSales S');
    qryTemp.Sql.Add('Left Join tblsalespayments SP Using(SaleID)');
    qryTemp.Sql.Add('WHERE (S.IsInvoice="T" OR S.IsPOS="T")');
    qryTemp.Sql.Add('AND S.TillId > 0');
    qryTemp.Sql.Add('AND not Isnull(S.TillId)');
    qryTemp.Sql.Add('AND S.SaleDate Between ' + DFromStr + ' and ' + DToStr);
    qryTemp.Sql.Add('union all');
    qryTemp.Sql.Add('SELECT');
    qryTemp.Sql.Add('TillId,');
    qryTemp.Sql.Add('S.SaleDate,');
    qryTemp.Sql.Add('S.GlobalRef,');
    qryTemp.Sql.Add('S.InvoiceDocNumber,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Cash"),DL.Payment,0.00) as Cash,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("E.F.T."),DL.Payment,0.00) as EFTPOS,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Debit Card"),DL.Payment,0.00) as DebitCard,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Cheque"),DL.Payment,0.00) as Cheque,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Diners Club"),DL.Payment,0.00) as DinersClub,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Master Card"),DL.Payment,0.00) as MasterCard,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("VISA"),DL.Payment,0.00) as VISA,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Amex"),DL.Payment,0.00) as Amex,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("American Express"),DL.Payment,0.00) as AmericanExpress,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("BankCard"),DL.Payment,0.00) as BankCard,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Credit Card"),DL.Payment,0.00) as CreditCard,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Direct Debt"),DL.Payment,0.00) as DirectDebt,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Direct Deposit"),DL.Payment,0.00) as DirectDeposit,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Money Order"),DL.Payment,0.00) as MoneyOrder,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Layby"),DL.Payment,0.00) as Layby,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Voucher"),DL.Payment,0.00) as Voucher,');
    qryTemp.Sql.Add('If(UCase(SP.Name)=UCase("Voucher Reversal"),DL.Payment,0.00) as VoucherReversal,');
    qryTemp.Sql.Add('S.TotalAmountInc as Invoice,');
    qryTemp.Sql.Add('DL.Payment as Totals,');
    qryTemp.Sql.Add('S.Class,');
    qryTemp.Sql.Add('S.ClassID,');
    qryTemp.Sql.Add('S.SaleID,');
    qryTemp.Sql.Add('D.PaymentID,');
    qryTemp.Sql.Add('"Account Payment" as SaleType,');
    qryTemp.Sql.Add('S.EmployeeName');
    qryTemp.Sql.Add('from tblSales S');
    qryTemp.Sql.Add('inner join tblDepositLine DL on DL.SaleId=S.SaleId');
    qryTemp.Sql.Add('inner join tblDeposits D on D.PaymentId= DL.PaymentId');
    qryTemp.Sql.Add('inner join tblpaymentmethods SP on SP.PayMethodID = D.Paymethodid');
    qryTemp.Sql.Add('WHERE (S.IsInvoice="T" OR S.IsPOS="T")');
    qryTemp.Sql.Add('AND S.TillId > 0');
    qryTemp.Sql.Add('AND not Isnull(S.TillId)');
    qryTemp.Sql.Add('AND S.SaleDate Between ' + DFromStr + ' and ' + DToStr);
    qryTemp.Sql.Add(') T');
    qryTemp.Sql.Add('WHERE SaleDate Between ' + DFromStr + ' and ' + DToStr);
    if ClassId > 0 then
      qryTemp.Sql.Add('AND classId = ' + inttostr(ClassId));
    qryTemp.Execute;


  finally
    FreeAndNil(qryTemp);
  end;

end;

function TReportSQLTillSummary.PrepareForReport: Boolean;
begin
  result := true;
  PopulateTemporyTable;
end;

initialization
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Till Summary','TReportSQLTillSummary','TTillSummaryReportGUI');
  Classes.RegisterClass(TReportSQLTillSummary);

end.
