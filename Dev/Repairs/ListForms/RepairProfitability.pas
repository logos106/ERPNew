unit RepairProfitability;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
  BJ :report copied from TRepairProfitabilityGUI
  and changed as the f5,f6,f7 was not working in TRepairProfitabilityGUI
}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MyAccess,ERPdbComponents, kbmMemTable,
  DBAccess, MemDS, wwdbdatetimepicker, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  Wwkeycb, wwdblook, ActnMan, ProgressDialog,  Shader,
  PlatformDefaultStyleActnCtrls, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TRepairProfitabilityGUI = class(TBaseListingGUI)
    qryMainCompanyName: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainTransactionNo: TWideStringField;
    qryMainCostEx: TFloatField;
    qryMainIncomeEx: TFloatField;
    QrymainDiffIncome_Cost: TFloatField;
    qrymainPercentDiffIncomebyCost: TFloatField;
    qryMainTransactionType: TWideStringField;
    qryMainBackorders: TFloatField;
    qryMainProfitPercent: TFloatField;
    qryMainQuotedEx: TFloatField;
    qrymainDiffIncome_Quote: TFloatField;
    qrymainPercentDiffIncomebyQuote: TFloatField;
    qryMainAccountName: TWideStringField;
    qryMainCreditEx: TFloatField;
    qryMainDebitEx: TFloatField;
    qryMainDepartment: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainArea: TWideStringField;

    Label4: TLabel;
    chkAllClients: TCheckBox;
    qryCustomers: TERPQuery;
    cboClients: TwwDBLookupCombo;
    btnSwapClass: TDNMSpeedButton;
    ActionManager1: TActionManager;
    Label5: TLabel;
    cboClass: TwwDBLookupCombo;
    qryClass: TERPQuery;
    actSwapDepartment: TAction;
    ApplyDtfilteron: TRadioGroup;
    lblApplyDate: TLabel;
    qryMainLandedCost: TFloatField;
    qryMainLatestcost: TFloatField;
    qryMainDiffIncome_Landedcost: TFloatField;
    qryMainPercentDiffIncomebyLandedcost: TFloatField;
    qryMainDiffIncome_Latestcost: TFloatField;
    qryMainPercentDiffIncomebyLatestcost: TFloatField;
    FieldDetails1: TMenuItem;
    btnFieldDetails: TDNMSpeedButton;
    qryMainQtyOrdered: TFloatField;
    qryMainQtyShipped: TFloatField;
    qryMainQtyBackOrder: TFloatField;
    qryMainSaleID: TLargeintField;
    qryMainLineID: TLargeintField;
    qryMainDetails: TLargeintField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainJobNumber: TLargeintField;
    qryMainProfitDollars: TFloatField;
    qryMainContractValue: TFloatField;
    qryMainSuggestedSalesAmount: TFloatField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure chkAllClientsClick(Sender: TObject);
    procedure actSwapDepartmentUpdate(Sender: TObject);
    procedure actSwapDepartmentExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure ApplyDtfilteronClick(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure FieldDetails1Click(Sender: TObject);
    procedure btnFieldDetailsClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsTablename:String;
    fiClientID: Integer;
    fiMaxDetails :Integer;

    { Private declarations }
    (*procedure UpdateTotals;*)
    procedure setclientID(const Value: Integer);
    procedure Showformhints;
    function reporthint: String;
    Procedure ShowReportHint;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure CalcFooter;override;
    //procedure DeleteContentsFromTemporaryTable;
    procedure CreateTemporaryRepairProfitTable;
    procedure DestroyTemporaryRepairProfitTable;
    (*procedure SaveMemoryTableToDataset(mem: TKbmMemTable);*)
    procedure SetGridColumns; Override;
    procedure SetupFormInPanel; Override;
    procedure SetMainQuery;
  public
    Property ClientID :Integer read fiClientID write setclientID;
  end;

implementation

{$R *.dfm}

uses
  Math, CommonDbLib, frmInvoice, frmBill,
  frmPurchaseOrders, frmRefund, frmCashSale, frmQuote, {frmTimeSheetGUI,}
  CommonLib, Forms,  AppEnvironment, FastFuncs, ProductQtyLib, tcConst, MySQLConst, MemoDialog,
  LogLib, DbSharedObjectsObj;

const
  csSummary = 0;
  csDetails = 1;
  csExtraDetails = 2;

procedure TRepairProfitabilityGUI.grdMainDblClick(Sender: TObject);
begin
  if grpFilters.ItemIndex > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('TransactionType').AsString;
    inherited;
  end else if issubform then begin
    inherited;
  end;
end;

procedure TRepairProfitabilityGUI.RefreshQuery;
  Procedure Adddatefilter(const Filterfieldname :STring);
  begin
        ScriptMain.SQL.Add('AND '+Filterfieldname +'  BETWEEN '+
            QuotedStr(formatDatetime(MysqlDateTimeFormat , filterDateFrom) ) +
            ' AND '+QuotedStr(formatDatetime(MysqlDateTimeFormat , FilterDateto) ) +'');
  end;

  Procedure AddSales;
  begin
    ScriptMain.SQL.Add('/*SALES*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('0                                AS Details,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +'  AS CompanyName,');
    ScriptMain.SQL.Add('C.JobName                        as JobName, ');
    ScriptMain.SQL.Add('C.JobNumber                      AS JobNumber, ');
    ScriptMain.SQL.Add('s.SaleID                         as SaleID,');
    ScriptMain.SQL.Add(ProductQtyLib.SaleType +       '  as "TransactionType",');
    ScriptMain.SQL.Add('s.ClientID                       as ClientID, ');
    ScriptMain.SQL.Add('InvoiceDocNumber                 as TransactionNo,');
    ScriptMain.SQL.Add('If(s.IsInvoice="T" , Sum(sl.LineCost * Shipped), IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.LineCost * Shipped), Sum(0.00))) AS "CostEx",');
    ScriptMain.SQL.Add('IF(s.IsInvoice="T" , Sum(sl.TotalLineAmount)   , IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.TotalLineAmount)   , Sum(0.00))) as "IncomeEx",');
    ScriptMain.SQL.Add('IF(s.IsQuote="T"   , Sum(sl.TotalLineAmount)   , Sum(0.00)) as "Quotedex",');
    ScriptMain.SQL.Add('0.00                             AS "DebitEx",');
    ScriptMain.SQL.Add('0.00                             AS "CreditEx",');
    ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") ,  Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)                                   '+',IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"'+',      Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)                                   '+', Sum(0.00))) as "DiffIncome_Cost",');
    ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") ,if(ifnull(sl.LineCost,0)=0,100, ((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100)'+',IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"'+',      if(ifnull(sl.LineCost,0)=0,100,((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100)'+', Sum(0.00))) as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00                             as "DiffQuote_Cost",');
    ScriptMain.SQL.Add('0.00                             as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('Sum(IF(sl.Invoiced = "F", sl.QtySold, 0.00)) As "Backorders", ');
    ScriptMain.SQL.Add('0.00                             AS "ProfitPercent", ');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('sl.SaleLineID                    AS LineID,');
    ScriptMain.SQL.Add('SPACE(255)                       AS Department,');
    ScriptMain.SQL.Add('SPACE(60)                        AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "Area",');
    ScriptMain.SQL.Add('SPACE(40) AS "RepairStatus",'); //@@@
    ScriptMain.sql.Add('0.0 AS ContractValue,');
    ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
    ScriptMain.SQL.Add('0.0 as EstimatedCost,');
    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblSales s '+
                'INNER JOIN tblSalesLines sl on (s.SaleID = sl.SaleID) '+
                'INNER JOIN tblclients C on C.ClientID = s.ClientID');
    ScriptMain.SQL.Add('WHERE (IsRefund="T" or IsInvoice="T" or IsCashSale="T" or s.IsQuote="T")  '+
                'AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")');
    AdddateFilter('s.SaleDate');
    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND s.ClientID=' + QryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP By s.ClientID, s.IsInvoice, s.IsQuote');
  end;


  Procedure AddPOs;
  begin
    ScriptMain.SQL.Add('/*PURCHASES*/');
    ScriptMain.SQL.Add('SELECT STRAIGHT_JOIN 0, ');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
    ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
    ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber as InvoiceNo,');
    ScriptMain.SQL.Add('Sum(TotalLineAmount) as "CostEx",');
    ScriptMain.SQL.Add('0.00 as "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(TotalLineAmount)-Sum(0.00) as "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(TotalLineAmount)-Sum(0.00))/Sum(0.00)*100 as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('Sum(PL.Backorder) AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('PL.PurchaseLineID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('SPACE(40) AS "RepairStatus",'); //@@@
    ScriptMain.sql.Add('0.0 AS ContractValue,');
    ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
    ScriptMain.SQL.Add('0.0 as EstimatedCost,');
    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpurchaseorders P');
    ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
    ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T" or IsCredit="T" or IsCheque="T") AND NOT ISNULL(Company) AND P.Deleted <> "T" And UseTimeCost <> "T"');

    if ApplyDtfilteron.ItemIndex = 0 then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY  CompanyName, jobname');
  end;
  Procedure AddPays;
  begin
    ScriptMain.SQL.Add('/*PAYS*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, "Payroll" AS "TransactionType",');
    ScriptMain.SQL.Add('PL.ClientID, 0 AS InvoiceNo, Sum(LineTotal) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(LineTotal) - Sum(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(LineTotal) - Sum(0.00)) / Sum(0.00) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('PL.PaysPayRateID,');
    ScriptMain.SQL.Add('PL.ClassName AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('SPACE(40) AS "RepairStatus",'); //@@@
    ScriptMain.sql.Add('0.0 AS ContractValue,');
    ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
    ScriptMain.SQL.Add('0.0 as EstimatedCost,');
    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpays P');
    ScriptMain.SQL.Add('INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")');
    //ScriptMain.SQL.Add('INNER JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');
    ScriptMain.SQL.Add('LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID)');

    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.ClientID');
    ScriptMain.SQL.Add('WHERE (Paid = "T") AND P.Deleted="F" ');
    ScriptMain.SQL.Add('and ((IfNull(PL.TimeSheetId,0) = 0) or ((T.SalesId < 1) OR ISNULL(T.SalesId)))');
    Adddatefilter('P.DatePaid');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND PL.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY C.ClientID');
  end;

  Procedure AddTimesheets;
  begin
    ScriptMain.SQL.Add('/*TIMESHEETS*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber,P.ID, ');
    ScriptMain.SQL.Add(' #P.EmployeeID,');
    ScriptMain.SQL.Add(' "Timesheet" AS "TransactionType",');
    ScriptMain.SQL.Add('P.JobID, 0 AS InvoiceNo, IF(P.JobID > 0, Sum(P.Total), Sum(0.00)) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(Total) - Sum(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(Total) - Sum(0.00)) / Sum(0.00) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('P.ID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('SPACE(40) AS "RepairStatus",'); //@@@
    ScriptMain.sql.Add('0.0 AS ContractValue,');
    ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
    ScriptMain.SQL.Add('0.0 as EstimatedCost,');
    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('FROM tbltimesheets P');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = P.JobID');
    ScriptMain.SQL.Add('WHERE (P.Active = "T" AND P.JobID > 0)');
    Adddatefilter('P.ServiceDate');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND P.JobID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY P.JobID');
  end;
  Procedure Addrepairs;
  begin
    ScriptMain.SQL.Add('/*REPAIRS*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('0 AS Details,' +Splitfield('C' , 'Company',1) +' ,C.JobName,');
    ScriptMain.SQL.Add('C.JobNumber,R.RepairID,"Repairs" AS "TransactionType",');
    ScriptMain.SQL.Add('R.CusID,R.RepairDocno AS transactionno,sum(RP.Linecost*RP.Qty) AS "Cost(Ex)",');
    ScriptMain.SQL.Add('Sum(RP.PriceEx*RP.Qty) as "Income(Ex)",0 as "DebitEx" , 0 as "CreditEx", ');
    ScriptMain.SQL.Add('sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty)  as "DiffIncome_Cost",');
    ScriptMain.SQL.Add(' ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100,');
    ScriptMain.SQL.Add(' ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100 as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost",0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0 As "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('RP.RepairPartsID AS LineID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('Status AS "RepairStatus",'); //@@@
    ScriptMain.sql.Add('R.ContractValue AS ContractValue,');
    ScriptMain.SQL.Add('R.SuggestedSalesAmount as SuggestedSalesAmount,');
    ScriptMain.SQL.Add('R.EstimatedCost as EstimatedCost,');
    ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
    ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
    ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblrepairs AS R');
    ScriptMain.SQL.Add('Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID');
    ScriptMain.SQL.Add('Inner Join tblclients C ON  R.CusID = C.ClientID');
    ScriptMain.SQL.Add('WHERE R.converted = "F"');
    Adddatefilter('RP.PartIssuedON');
    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND R.CusId=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP By R.CusId');
  end;
  Procedure AddSalesextraDetails;
  begin
    (*ScriptMain.SQL.clear;*)
    ScriptMain.SQL.Add('INSERT HIGH_PRIORITY INTO `' + fsTablename +
            '` (Details, SaleID,LineID, TransactionNo, JobNumber, JobName, ClientID, `TransactionType`, CompanyName, Department, AccountName, `DebitEx`, `CreditEx`)');
    ScriptMain.SQL.Add('SELECT 2 AS Details, s.SaleID, sl.SaleLineId, s.SaleID, C.JobNumber,');
    ScriptMain.SQL.Add('JobName, s.ClientID,"Account Details" ,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add(' s.Class AS Department, sl.INCOMEACCNT , 0 , sl.totallineAmount');
    ScriptMain.SQL.Add('FROM tblSales s');
    ScriptMain.SQL.Add('INNER JOIN tblSalesLines sl on s.SaleID = sl.SaleID');
    ScriptMain.SQL.Add('INNER JOIN tblparts tp on tp.PartsID = sl.ProductID');
    ScriptMain.SQL.Add('LEFT JOIN tblclients C on C.ClientID = s.ClientID');
    ScriptMain.SQL.Add('WHERE (((s.IsInvoice="T" )  or (s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"))) ');
    ScriptMain.SQL.Add('AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")');
    Adddatefilter('s.SaleDate');
    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND s.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add(';');
    (*ScriptMain.execute;*)
  end;
  Procedure AddsalesDetails;
  begin
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('1 AS Details,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, s.SaleID,');
          ScriptMain.SQL.Add(SaleType + ' as "TransactionType",');
          ScriptMain.SQL.Add('s.ClientID, InvoiceDocNumber AS TransactionNo,');

          ScriptMain.SQL.Add('IF(s.IsInvoice="T" , sl.LineCost * Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.LineCost * Shipped, 0.00)) AS "CostEx",');
          ScriptMain.SQL.Add('IF(s.IsInvoice="T" , sl.TotalLineAmount, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount, 0.00)) as "IncomeEx",');
          ScriptMain.SQL.Add('IF(s.IsQuote="T" , sl.TotalLineAmount, 0.00) as "Quotedex",');

          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") , sl.TotalLineAmount-sl.LineCost*Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount-sl.LineCost*Shipped, 0.00)) as "DiffIncome_Cost",');
          ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") , ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100,');
          ScriptMain.SQL.Add('IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100, 0.00)) as "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('IF(s.IsQuote="T" , sl.TotalLineAmount-sl.LineCost*Shipped, 0.00) AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('IF(s.IsQuote="T" , ((sl.TotalLineAmount-sl.LineCost*Shipped) / (sl.LineCost*Shipped))*100, 0.00) AS "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');

          ScriptMain.SQL.Add('IF(sl.Invoiced = "F" AND s.IsInvoice="T" , sl.QtySold, 0) AS "Backorders",');
          ScriptMain.SQL.Add('0.00 AS "ProfitPercent",');
          ScriptMain.SQL.Add('0.00 as ProfitDollars,');
          ScriptMain.SQL.Add('sl.SaleLineID AS LineID,');
          ScriptMain.SQL.Add('s.Class AS Department,');
          ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
          ScriptMain.SQL.Add('sl.ProductId as ProductID,');
          ScriptMain.SQL.Add('sl.QtySold as QtyOrdered,');
          ScriptMain.SQL.Add('sl.Shipped as QtyShipped,');
          ScriptMain.SQL.Add('sl.BackOrder as QtyBackOrder,');
          ScriptMain.SQL.Add(Firstcolumn('tp') + ' AS FirstColumn, ');
          ScriptMain.SQL.Add(Secondcolumn('tp')+ ' AS SecondColumn, ');
          ScriptMain.SQL.Add(Thirdcolumn('tp') + ' AS ThirdColumn, ');
          ScriptMain.SQL.Add('tp.Area AS "Area",');
          ScriptMain.SQL.Add('"" AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('0.0 AS ContractValue,');
          ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('0.0 as EstimatedCost,');
          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('FROM tblSales s');
          ScriptMain.SQL.Add('INNER JOIN tblSalesLines sl on s.SaleID = sl.SaleID');
          ScriptMain.SQL.Add('INNER JOIN tblparts tp on tp.PartsID = sl.ProductID');
          ScriptMain.SQL.Add('LEFT JOIN tblclients C on C.ClientID = s.ClientID');
          ScriptMain.SQL.Add
          ('WHERE (IsRefund="T" or IsInvoice="T" or IsCashSale="T" or s.IsQuote="T") AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")');
          Adddatefilter('s.SaleDate');

          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND s.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
          end;
  end;
    Procedure AddPOextraDetails;
    begin
          (*ScriptMain.SQL.clear;*)
          ScriptMain.SQL.Add('INSERT HIGH_PRIORITY INTO `' + fsTablename +
            '` (Details, SaleID, LineID, TransactionNo, JobNumber, JobName, ClientID, `TransactionType`, CompanyName, Department, AccountName, `DebitEx`, `CreditEx`)');
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('STRAIGHT_JOIN 2,P.PurchaseOrderID,PL.PurchaseLineID,P.PurchaseOrderID,');
          ScriptMain.SQL.Add(' C.JobNumber, JobName,  PL.CustomerJobID,"Account Details" ,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('PL.Class AS Department,');
          ScriptMain.SQL.Add('AccountName, if(P.ISCredit="T" , 0.00, LineCost) , if(P.ISCredit="T" , linecost,0.00)');
          ScriptMain.SQL.Add('FROM tblpurchaseorders P');
          ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
          ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
          ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND NOT ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"');
          if ApplyDtfilteron.ItemIndex = 0 then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString);
          end;
          ScriptMain.SQL.Add(';');
  end;
  Procedure AddPODetails;
  begin
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('STRAIGHT_JOIN 1,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
          (* ScriptMain.SQL.Add(ProductQtyLib.POType + ' as "TransactionType",'); *)
          ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
          ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,');
          ScriptMain.SQL.Add('TotalLineAmount AS "CostEx",');
          ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
          ScriptMain.SQL.Add('0.00 AS "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('TotalLineAmount AS "DiffIncome_Cost",');
          ScriptMain.SQL.Add('TotalLineAmount AS "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('PL.Backorder AS "Backorders", 0.00 AS "ProfitPercent",');
          ScriptMain.SQL.Add('0.00 as ProfitDollars,');
          ScriptMain.SQL.Add('PL.PurchaseLineID,');
          ScriptMain.SQL.Add('PL.Class AS Department,');
          ScriptMain.SQL.Add('PL.ProductName AS "ProductName",');
          ScriptMain.SQL.Add('Pl.ProductId as ProductID,');
          ScriptMain.SQL.Add('Pl.QtySold as QtyOrdered,');
          ScriptMain.SQL.Add('Pl.Shipped as QtyShipped,');
          ScriptMain.SQL.Add('Pl.BackOrder as QtyBackOrder,');
          ScriptMain.SQL.Add(Firstcolumn('tp') + ' AS FirstColumn, ');
          ScriptMain.SQL.Add(Secondcolumn('tp')+ ' AS SecondColumn, ');
          ScriptMain.SQL.Add(Thirdcolumn('tp') + ' AS ThirdColumn, ');
          ScriptMain.SQL.Add('tp.Area AS "Area",');
          ScriptMain.SQL.Add('"" AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('0.0 AS ContractValue,');
          ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('0.0 as EstimatedCost,');
          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('FROM tblpurchaseorders P');
          ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
          ScriptMain.SQL.Add('INNER JOIN tblparts tp on tp.PartsID = PL.ProductID');
          ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
          ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND NOT ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"');
          if ApplyDtfilteron.ItemIndex = 0 then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString);
          end;
          ScriptMain.SQL.Add('UNION ALL');
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('STRAIGHT_JOIN 0,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
          (* ScriptMain.SQL.Add(ProductQtyLib.POType + ' as "TransactionType",'); *)
          ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
          ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,');
          ScriptMain.SQL.Add('TotalLineAmount AS "CostEx",');
          ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
          ScriptMain.SQL.Add('0.00 AS "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('TotalLineAmount AS "DiffIncome_Cost",');
          ScriptMain.SQL.Add('TotalLineAmount AS "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('PL.Backorder AS "Backorders", 0.00 AS "ProfitPercent",');
          ScriptMain.SQL.Add('0.00 as ProfitDollars,');
          ScriptMain.SQL.Add('PL.PurchaseLineID,');
          ScriptMain.SQL.Add('PL.Class AS Department,');
          ScriptMain.SQL.Add('PL.ProductName AS "ProductName",');
          ScriptMain.SQL.Add('Pl.ProductId as ProductID,');
          ScriptMain.SQL.Add('Pl.QtySold as QtyOrdered,');
          ScriptMain.SQL.Add('Pl.Shipped as QtyShipped,');
          ScriptMain.SQL.Add('Pl.BackOrder as QtyBackOrder,');
          ScriptMain.SQL.Add('"" AS "FirstColumn",');
          ScriptMain.SQL.Add('"" AS "SecondColumn",');
          ScriptMain.SQL.Add('"" AS "ThirdColumn",');
          ScriptMain.SQL.Add('"" AS "Area",');
          ScriptMain.SQL.Add('"" AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('0.0 AS ContractValue,');
          ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('0.0 as EstimatedCost,');
          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('FROM tblpurchaseorders P');
          ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
          ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
          ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"');
          if ApplyDtfilteron.ItemIndex = 0 then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');

          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString);
          end;
  end;
  Procedure AddPayDetails;
  begin
          ScriptMain.SQL.Add('SELECT 1,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, "Payroll" AS "TransactionType", PL.ClientID, P.PayID AS InvoiceNo,');
          ScriptMain.SQL.Add('LineTotal AS "CostEx",');
          ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
          ScriptMain.SQL.Add('0.00 AS "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('LineTotal AS "DiffIncome_Cost",');
          ScriptMain.SQL.Add('LineTotal AS "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
          ScriptMain.SQL.Add('0.00 as ProfitDollars,');
          ScriptMain.SQL.Add('PL.PaysPayRateID,');
          ScriptMain.SQL.Add('PL.ClassName AS Department,');
          ScriptMain.SQL.Add('"" AS "ProductName",');
          ScriptMain.SQL.Add('null AS ProductId,');
          ScriptMain.SQL.Add('null AS QtyOrdered,');
          ScriptMain.SQL.Add('null AS QtyShipped,');
          ScriptMain.SQL.Add('null AS QtyBackOrder,');
          ScriptMain.SQL.Add('"" AS "FirstColumn",');
          ScriptMain.SQL.Add('"" AS "SecondColumn",');
          ScriptMain.SQL.Add('"" AS "ThirdColumn",');
          ScriptMain.SQL.Add('"" AS "Area",');
          ScriptMain.SQL.Add('"" AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('0.0 AS ContractValue,');
          ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('0.0 as EstimatedCost,');
          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('FROM tblpays P');
          ScriptMain.SQL.Add('INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")');
          //ScriptMain.SQL.Add('INNER JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');
          ScriptMain.SQL.Add('LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');          
          ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.ClientID');
          ScriptMain.SQL.Add('WHERE (Paid = "T") AND P.Deleted="F" ');
          Adddatefilter('P.DatePaid');
          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND PL.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
          end;
  end;
  Procedure AddtimesheetDetails;
  begin
          ScriptMain.SQL.Add('SELECT DISTINCT 1,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, P.ID, "Timesheet" AS "TransactionType",');

          ScriptMain.SQL.Add('P.JobID, 0 AS InvoiceNo,');
          ScriptMain.SQL.Add('Total AS "CostEx",');
          ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
          ScriptMain.SQL.Add('0.00 AS "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('Total AS "DiffIncome_Cost",');
          ScriptMain.SQL.Add('Total AS "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
          ScriptMain.SQL.Add('0.00 as ProfitDollars,');
          ScriptMain.SQL.Add('P.ID,');
          ScriptMain.SQL.Add('P.ClassName,');
          ScriptMain.SQL.Add('"" AS "ProductName",');
          ScriptMain.SQL.Add('null AS ProductId,');
          ScriptMain.SQL.Add('null AS QtyOrdered,');
          ScriptMain.SQL.Add('null AS QtyShipped,');
          ScriptMain.SQL.Add('null AS QtyBackOrder,');
          ScriptMain.SQL.Add('"" AS "FirstColumn",');
          ScriptMain.SQL.Add('"" AS "SecondColumn",');
          ScriptMain.SQL.Add('"" AS "ThirdColumn",');
          ScriptMain.SQL.Add('"" AS "Area",');
          ScriptMain.SQL.Add('"" AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('0.0 AS ContractValue,');
          ScriptMain.SQL.Add('0.0 as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('0.0 as EstimatedCost,');
          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('FROM tbltimesheets P');
          ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = P.JobID');
          { removed the following .. makes no sense }
          //ScriptMain.SQL.Add('LEFT JOIN tblPays PH on PH.EmployeeID = P.EmployeeID');
          //ScriptMain.SQL.Add('WHERE (P.Active = "T" OR (P.Active = "F" AND PH.IsTimesheet = "T" AND PH.Paid = "F" AND PH.Deleted="F"))');
          //Adddatefilter('PH.PayDate');
          ScriptMain.SQL.Add('WHERE (P.Active = "T" AND P.JobID > 0)');
          Adddatefilter('P.ServiceDate');


          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND P.JobID = ' + qryCustomers.FieldByName('ClientID').AsString);
          end;

  end;
  Procedure AddrepairDetails;
  begin
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('1 AS Details,');
          ScriptMain.SQL.Add('Left(SUBSTRING_INDEX(C.Company,"^",1),255) AS CompanyName,');
          ScriptMain.SQL.Add('C.JobName,  C.JobNumber, R.RepairID, "Repairs" as "TransactionType",');
          ScriptMain.SQL.Add('R.CusID, R.RepairDocno  AS TransactionNo, RP.Linecost*RP.Qty  as "CostEx",');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty as "IncomeEx", R.QuotedAmount as "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx", 0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty as "DiffIncome_Cost",');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as PercentDiffIncomeByCost,');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as  "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('0 as BackOrders, 0.00 as ProfitPercent, 0.00 as ProfitDollars, RepairPartsId as LineId,');
          ScriptMain.SQL.Add('RP.ClassName, RP.PartName, RP.PartsID as ProductID,');
          ScriptMain.SQL.Add('null as QtyOrdered, null as QtyShipped, null as QtyBackOrder,');
          ScriptMain.SQL.Add('Left(SUBSTRING_INDEX(P.ProductGroup,"^",1),255) AS FirstColumn,');
          ScriptMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",2),char_length(substring_index(P.ProductGroup,"^",1))+2),255) AS SecondColumn,');
          ScriptMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",3),char_length(substring_index(P.ProductGroup,"^",2))+2),255) AS ThirdColumn,');
          ScriptMain.SQL.Add('P.Area,');
          ScriptMain.SQL.Add('R.Status AS "RepairStatus",'); //@@@
          ScriptMain.sql.Add('R.ContractValue AS ContractValue,');
          ScriptMain.SQL.Add('R.SuggestedSalesAmount as SuggestedSalesAmount,');
          ScriptMain.SQL.Add('R.EstimatedCost as EstimatedCost,');
          ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
          ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
          ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
          ScriptMain.SQL.Add('FROM');
          ScriptMain.SQL.Add('tblrepairs AS R');
          ScriptMain.SQL.Add('Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID');
          ScriptMain.SQL.Add('Inner Join tblparts AS P ON RP.PartsID = P.PARTSID');
          ScriptMain.SQL.Add('Inner Join tblclients AS C ON R.CusID = C.ClientID');
          ScriptMain.SQL.Add('Where R.converted = "F"');
          Adddatefilter('RP.PartIssuedOn');

          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND R.CusId=' + qryCustomers.FieldByName('ClientID').AsString);
          end;

  end;
begin
  (*if (ScriptMainMain.Active) and (ScriptMainMain.RecordCount > 0) then DeleteContentsFromTemporaryTable;*)

  qryMain.DisableControls;
  qryMain.Close;

  Processingcursor(True);
  try
    (*qry.Connection := CommonDbLib.GetSharedMyDacConnection;*)
    ScriptMain.SQL.Clear;
    ScriptMain.SQL.add('truncate table ' +fstablename +';');

    case grpFilters.ItemIndex of
      csSummary:
        begin
          ScriptMain.SQL.add('insert into ' +fstablename +
                ' (Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,'+
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,'+
                'DiffQuote_Cost,PercentDiffQuotebyCost,Backorders,ProfitPercent, ProfitDollars, LineID,Department,'+
                'ProductName,FirstColumn,SecondColumn,ThirdColumn,Area,RepairStatus, ContractValue, SuggestedSalesAmount, EstimatedCost, ' +
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15) ');
          Addsales      ; ScriptMain.SQL.add(' UNION ALL ' );
          AddPOs        ; ScriptMain.SQL.add(' UNION ALL ' );
          AddPays       ; ScriptMain.SQL.add(' UNION ALL ' );
          Addtimesheets ; ScriptMain.SQL.add(' UNION ALL ' );
          AddRepairs    ; ScriptMain.SQL.add(' ;');
        end;

      csExtraDetails :
        begin
          ScriptMain.SQL.add('insert into ' +fstablename +
                ' (Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,'+
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,'+
                'DiffIncome_Quote,PercentDiffIncomebyQuote,DiffQuote_Cost,PercentDiffQuotebyCost,'+
                'Backorders,ProfitPercent, ProfitDollars, LineID,Department,ProductName,ProductID, QtyOrdered, QtyShipped, QtyBackOrder, FirstColumn,SecondColumn,ThirdColumn,Area,RepairStatus, '  +
                'ContractValue, SuggestedSalesAmount, EstimatedCost,' +
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15) ');
           AddSalesDetails       ;ScriptMain.SQL.add(' UNION ALL ' );
           AddPODetails         ;ScriptMain.SQL.add(' UNION ALL ' );
           AddPayDetails        ;ScriptMain.SQL.add(' UNION ALL ' );
           AddtimesheetDetails  ;ScriptMain.SQL.add(' UNION ALL ' );
          AddrepairDetails      ;ScriptMain.SQL.add(' ;');
        end;
      csDetails :
        begin
          ScriptMain.SQL.add('insert into ' +fstablename +
                ' (Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,'+
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,'+
                'DiffIncome_Quote,PercentDiffIncomebyQuote,DiffQuote_Cost,PercentDiffQuotebyCost,'+
                'Backorders,ProfitPercent,ProfitDollars,LineID,Department,ProductName,ProductID, QtyOrdered, QtyShipped,QtyBackOrder, FirstColumn,SecondColumn,ThirdColumn,Area,RepairStatus, ' +
                'ContractValue, SuggestedSalesAmount,EstimatedCost,'+
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15) ');
           AddSalesDetails      ;ScriptMain.SQL.add(' UNION ALL ' );
           AddPODetails         ;ScriptMain.SQL.add(' UNION ALL ' );
           AddPayDetails        ;ScriptMain.SQL.add(' UNION ALL ' );
           AddtimesheetDetails  ;ScriptMain.SQL.add(' UNION ALL ' );
          AddrepairDetails      ;ScriptMain.SQL.add(' ;');
        end;
    end;

    ScriptMain.SQL.text := AppEnv.RegionalOptions.ChangeStr(ScriptMain.SQL.Text);

    ScriptMain.SQL.add('update ' +fstablename +' set ProfitPercent = (IncomeEx - CostEx)/ IncomeEx * 100.0;');
    ScriptMain.SQL.add('update ' +fstablename +' set ProfitDollars = (IncomeEx - CostEx);');
    ScriptMain.SQL.add('update ' +fstablename +' set TransactionNo = null where details = 0;');

    if grpFilters.ItemIndex > csSummary then begin
      ScriptMain.SQL.add( ' update ' +fstablename +' set DiffIncome_Cost = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
      ScriptMain.SQL.add( ' update ' +fstablename +' set PercentDiffIncomebyCost  = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    end else begin
      ScriptMain.SQL.add( ' update ' +fstablename +' set DiffIncome_Cost = IncomeEx-CostEx where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
      ScriptMain.SQL.add( ' update ' +fstablename +' set PercentDiffIncomebyCost  = (IncomeEx-CostEx)/if(ifnull(CostEx,0)=0,IncomeEx,CostEx)*100 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    end;

    ScriptMain.SQL.add( '   update ' +fstablename +' T inner join tblparts P on T.productID  = P.partsID set T.LandedCost        = P.LandedCost * T.QtyShipped, T.LatestCost = P.LatestCost * T.QtyShipped where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS");');
    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffIncome_Landedcost    = IncomeEx-LandedCost        where ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffIncome_Latestcost    =IncomeEx-Latestcost        where ifnull(ProductID,0)<> 0 and  TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffIncomebyLandedcost =  (IncomeEx-LandedCost)/if(ifnull(LandedCost,0)=0,IncomeEx,LandedCost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffIncomebyLatestcost = (IncomeEx-Latestcost)/if(ifnull(Latestcost,0)=0,IncomeEx,Latestcost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffQuote_Cost           =IncomeEx-Quotedex                where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffQuotebyCost =  (IncomeEx-Quotedex)/if(ifnull(Quotedex,0)=0,IncomeEx,Quotedex)*100 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    ScriptMain.SQL.add( '   update ' +fstablename +' set TransactionType ="Quote" where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0 and Details >0;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffIncome_Cost =IncomeEx-CostEx where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffIncomebyCost= (IncomeEx-CostEx)/if(ifnull(CostEx,0)=0,IncomeEx,CostEx)*100     where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');

    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffQuote_Cost =0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffQuotebyCost =0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set CostEx =0 where TransactionType = "Quote";');
    ScriptMain.SQL.add( '   update ' +fstablename +' set DiffIncome_Cost =0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');
    ScriptMain.SQL.add( '   update ' +fstablename +' set PercentDiffIncomebyCost=0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');


    ScriptMain.Execute;
    LogText(ScriptMain.SQLtext);

    qryMain.EnableControls;

    inherited;

    SetMainQuery;
    LogText(qryMain.SQL.Text);

    qryMain.Open;

    case grpFilters.ItemIndex of
      csSummary, csExtraDetails:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS';
        end;

      csDetails:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS';
        end;
    end;

    qryMain.First;


  finally
    Self.PopulateFilterCombo;
    Processingcursor(False);
  end;
end;


(*procedure TRepairProfitabilityGUI.DeleteContentsFromTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := qryMain.Connection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM ' + fsTablename + ' WHERE ID <> 0;');
    qry.Execute;

  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;*)

procedure TRepairProfitabilityGUI.CreateTemporaryRepairProfitTable;
begin
  DestroyTemporaryRepairProfitTable;
  (*qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;*)
  with Scriptmain do begin
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + fsTablename + ' (');
    SQL.Add('ID                       int(11) NOT NULL AUTO_INCREMENT,');
    SQL.Add('Details                  INT(11)     DEFAULT 0,');
    SQL.Add('CompanyName              VARCHAR(255),');
    SQL.Add('Department               VARCHAR(255),');
    SQL.Add('JobName                  VARCHAR(255),');
    SQL.Add('JobNumber                INT(11)     DEFAULT 0,');
    SQL.Add('SaleID                   INT(11)  NULL   DEFAULT 0,'); //@@
    SQL.Add('LineID                   INT(11)     DEFAULT 0,');
    SQL.Add('AccountName              VARCHAR(255),');
    SQL.Add('CreditEx                 DOUBLE      DEFAULT 0,');
    SQL.Add('DebitEx                  DOUBLE      DEFAULT 0,');
    SQL.Add('TransactionType          VARCHAR(255),');
    SQL.Add('ClientID                 INT(11)     DEFAULT 0,');
    SQL.Add('TransactionNo            VARCHAR(30),');
    SQL.Add('CostEx                   DOUBLE      DEFAULT 0,');
    SQL.Add('IncomeEx                 DOUBLE      DEFAULT 0,');
    SQL.Add('Quotedex                 DOUBLE      DEFAULT 0,');
    SQL.Add('DiffIncome_Cost         DOUBLE      DEFAULT 0,');
    SQL.Add('PercentDiffIncomebyCost  DOUBLE      DEFAULT 0,');
    SQL.Add('DiffQuote_Cost          DOUBLE      DEFAULT 0,');
    SQL.Add('DiffIncome_Quote        DOUBLE      DEFAULT 0,');
    SQL.Add('PercentDiffIncomebyQuote DOUBLE      DEFAULT 0,');
    SQL.Add('PercentDiffQuotebyCost   DOUBLE      DEFAULT 0,');
    SQL.Add('Backorders               DOUBLE      DEFAULT 0,');
    SQL.Add('ProfitPercent            DOUBLE      DEFAULT 0,');
    SQL.Add('ProfitDollars            DOUBLE      DEFAULT 0,');
    SQL.Add('ProductName              VARCHAR(60),');
    SQL.Add('ProductID                INT(11)     DEFAULT 0,');
    SQL.Add('QtyOrdered               DOUBLE      DEFAULT 0,');
    SQL.Add('QtyShipped               DOUBLE      DEFAULT 0,');
    SQL.Add('QtyBackOrder             DOUBLE      DEFAULT 0,');
    SQL.Add('LandedCost               DOUBLE      DEFAULT 0,');
    SQL.Add('Latestcost               DOUBLE      DEFAULT 0,');
    SQL.Add('DiffIncome_Landedcost   DOUBLE      DEFAULT 0,');
    SQL.Add('DiffIncome_Latestcost   DOUBLE      DEFAULT 0,');
    SQL.Add('PercentDiffIncomebyLandedcost      DOUBLE      DEFAULT 0,');
    SQL.Add('PercentDiffIncomebyLatestcost      DOUBLE      DEFAULT 0,');
    SQL.Add('FirstColumn              VARCHAR(255),');
    SQL.Add('SecondColumn             VARCHAR(255),');
    SQL.Add('ThirdColumn              VARCHAR(255),');
    SQL.Add('Area                     VARCHAR(255),');
    SQL.Add('RepairStatus varchar(40),');  //@@@
    SQL.Add('ContractValue DOUBLE DEFAULT 0,');
    sql.Add('SuggestedSalesAmount DOUBLE DEFAULT 0,');
    SQL.Add('EstimatedCost DOUBLE DEFAULT 0,');
  	SQL.Add('CUSTFLD1 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD2 VARCHAR(255) NULL DEFAULT NULL,');
  	SQL.Add('CUSTFLD3 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD4 VARCHAR(255) NULL DEFAULT NULL,');
    SQL.Add('CUSTFLD5 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD6 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD7 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD8 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD9 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD10 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD11 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD12 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD13 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD14 VARCHAR(255) NULL DEFAULT NULL,');
	  SQL.Add('CUSTFLD15 VARCHAR(255) NULL DEFAULT NULL,');
    SQL.Add('INDEX    CompanyNameIndex (CompanyName),');
    SQL.Add('INDEX    SaleIDIndex (SaleID),');
    SQL.Add('INDEX    LineIDIndex (LineID),');
    SQL.Add('INDEX    TransactionTypeIndex (TransactionType),');
    SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM;');

    SQL.Text := AppEnv.RegionalOptions.ChangeStr(SQL.Text);
    Execute;
  end;
end;

procedure TRepairProfitabilityGUI.DestroyTemporaryRepairProfitTable;
begin
  commondblib.DestroyUserTemporaryTable(fsTablename);
end;

procedure TRepairProfitabilityGUI.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryRepairProfitTable;
  inherited;
end;

procedure TRepairProfitabilityGUI.FieldDetails1Click(Sender: TObject);
begin
  inherited;
  ShowReportHint;
end;

procedure TRepairProfitabilityGUI.FormCreate(Sender: TObject);
begin
    fsTablename := GetUserTemporaryTableName('RepairProfitabilityCustomer');
    qryMain.SQL.Clear;
    SetMainQuery;
    inherited;

      Addcalccolumn('CostEx', true);
      Addcalccolumn('IncomeEx', true);
      Addcalccolumn('Quotedex', true);
      Addcalccolumn('LandedCost', true);
      Addcalccolumn('Latestcost', true);
      Addcalccolumn('DebitEx', true);
      Addcalccolumn('CreditEx', true);
      Addcalccolumn('DiffIncome_Cost', true);
      Addcalccolumn('DiffQuote_Cost', true);
      Addcalccolumn('DiffQuote_Cost', true);
      Addcalccolumn('DiffQuote_Cost', true);
      Addcalccolumn('DiffIncome_Landedcost', true);
      Addcalccolumn('DiffIncome_Latestcost', true);
      AddCalcColumn('ProfitDollars', true);


  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Open;
  qryClass.Open;
  CreateTemporaryRepairProfitTable;

  
end;

procedure TRepairProfitabilityGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  inherited;
  if grpFilters.ItemIndex = csSummary then
  begin
    cboClass.Text := '';
    cboClass.Enabled := false;
    qryMain.Filtered := false;
  end
  else
  begin
    cboClass.Enabled := true;
    if cboClass.Text <> '' then
    begin
      qryMain.Filter := 'Department=''' + cboClass.Text + '''';
      qryMain.Filtered := true;
    end;
  end;
  if Sender = grpFilters then
    RefreshQuery;
end;

procedure TRepairProfitabilityGUI.qryMainBeforeOpen(DataSet: TDataSet);
var
  qry: TERPQuery;
begin
  inherited;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text :='Select max(Details) as Details from ' + fstablename;
    Qry.open;
    fiMaxDetails := Qry.fieldbyname('Details').asInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TRepairProfitabilityGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  (*if (grpFilters.ItemIndex = csDetails) or (grpFilters.ItemIndex = csExtraDetails ) then begin
    if qryMainDetails.AsInteger > fiMaxDetails then AFont.Style := [fsBold]
  end else if grpFilters.ItemIndex = csSummary then AFont.Style := [fsBold]
  else    AFont.Style := [];*)
  if qryMainDetails.AsInteger > fiMaxDetails then AFont.Style := [fsBold];

       if (field is TFloatField   ) and (Field.asfloat   = 0) then AFont.color := ABrush.color
  else if (field is TLargeintField) and (Field.asInteger = 0) then AFont.color := ABrush.color;
end;

procedure TRepairProfitabilityGUI.chkAllClientsClick(Sender: TObject);
begin
  inherited;
  if chkAllClients.Checked then begin
    cboClients.Enabled := False;
  end else begin
    cboClients.Enabled := True;
    if cboClients.Text = '' then begin
      cboClients.Text := qryCustomers.FieldByName('Company').AsString;
    end;
  end;

  RefreshQuery;
end;

procedure TRepairProfitabilityGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl <> chkIgnoreDates then exit;
  ApplyDtfilteron.Enabled     := not(chkIgnoreDates.Checked);
  lblApplyDate.Enabled        := not(chkIgnoreDates.Checked);
  if chkIgnoreDates.Checked then ApplyDtfilteron.ItemIndex   := -1 else ApplyDtfilteron.ItemIndex   := 0;
  RefreshQuery;
end;

procedure TRepairProfitabilityGUI.actSwapDepartmentUpdate(Sender: TObject);
begin
  inherited;
//  if (grdMain.SelectedList.Count = 0) or (grpFilters.ItemIndex < 1) or (cboClass.Text = '') then begin
  if (grdMain.SelectedList.Count = 0) or (grpFilters.ItemIndex = csSummary) or (cboClass.Text = '') then begin
    btnSwapClass.Enabled := False;
  end else begin
    btnSwapClass.Enabled := True;
  end;
end;

procedure TRepairProfitabilityGUI.actSwapDepartmentExecute(Sender: TObject);
var
  iX: integer;
  frmInv: TInvoiceGUI;
  frmBill: TBillGUI;
  frmPO: TPurchaseGUI;
  frmRefund: TRefundGUI;
  frmCash: TCashSaleGUI;
  frmQuote: TQuoteGUI;
begin
  inherited;
  for iX := 0 to grdMain.SelectedList.Count - 1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList.Items[iX]);
    if qryMain.FieldByName('TransactionType').AsString = 'Invoice' then begin
      frmInv := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
      If Assigned(frmInv) then Begin
        frmInv.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmInv.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmInv.tblMaster.Edit;
        frmInv.tblMaster.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
        frmInv.tblMaster.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
        frmInv.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassID').AsInteger, [loCaseInsensitive]);
        frmInv.cboClassCloseUp(TObject(frmInv.cboClass), frmInv.cboClassQry, frmInv.tblMaster, True);
        frmInv.tblMaster.Post;
        frmInv.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end else if qryMain.FieldByName('TransactionType').AsString = 'Quote' then begin
      frmQuote := TQuoteGUI(GetComponentByClassName('TQuoteGUI'));
      If Assigned(frmQuote) then Begin
        frmQuote.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmQuote.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmQuote.tblMaster.Edit;
        frmQuote.tblMaster.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
        frmQuote.tblMaster.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
        frmQuote.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassID').AsInteger, [loCaseInsensitive]);
        frmQuote.cboClassCloseUp(TObject(frmQuote.cboClass), frmQuote.cboClassQry, frmQuote.tblMaster, True);
        frmQuote.tblMaster.Post;
        frmQuote.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end else if qryMain.FieldByName('TransactionType').AsString = 'Bill' then begin
      frmBill := TBillGUI(GetComponentByClassName('TBillGUI(TBillGUI'));
      If Assigned(frmBill) then Begin
        frmBill.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmBill.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmBill.tblDetails.First;
        while not frmBill.tblDetails.Eof do begin
          frmBill.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassName').AsString, [loCaseInsensitive]);
          frmBill.tblDetails.Edit;
          frmBill.tblDetails.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
          frmBill.tblDetails.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
          frmBill.cboClassCloseUp(TObject(frmBill.cboClass), frmBill.cboClassQry, frmBill.tblDetails, True);
          frmBill.tblDetails.Post;

          frmBill.tblDetails.Next;
        end;
        frmBill.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end else if qryMain.FieldByName('TransactionType').AsString = 'Purchase Order' then begin
      frmPO := TPurchaseGUI(GetComponentByClassName('TPurchaseGUI'));
      If Assigned(frmPO) then Begin
        frmPO.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmPO.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmPO.tblDetails.First;
        while not frmPO.tblDetails.Eof do begin
          frmPO.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassName').AsString, [loCaseInsensitive]);
          frmPO.tblDetails.Edit;
          frmPO.tblDetails.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
          frmPO.tblDetails.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
          frmPO.cboClassCloseUp(TObject(frmPO.cboClass), frmPO.cboClassQry, frmPO.tblDetails, True);
          frmPO.tblDetails.Post;
          frmPO.tblDetails.Next;
        end;
        frmPO.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end else if qryMain.FieldByName('TransactionType').AsString = 'Refund' then begin
      frmRefund := TRefundGUI(GetComponentByClassName('TRefundGUI'));
      If Assigned(frmRefund) then Begin
        frmRefund.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmRefund.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmRefund.tblMaster.Edit;
        frmRefund.tblMaster.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
        frmRefund.tblMaster.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
        frmRefund.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassID').AsInteger, [loCaseInsensitive]);
        frmRefund.tblMaster.Post;
        frmRefund.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end else if qryMain.FieldByName('TransactionType').AsString = 'Cash Sale' then begin
      frmCash := TCashSaleGUI(GetComponentByClassName('TCashSaleGUI'));
      If Assigned(frmCash) then Begin
        frmCash.KeyID := qryMain.FieldByName('SaleID').AsInteger;
        frmCash.FormStyle := fsMDIChild;
        Application.ProcessMessages;
        frmCash.tblMaster.Edit;
        frmCash.tblMaster.FieldByName('ClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
        frmCash.tblMaster.FieldByName('Class').AsString := qryClass.FieldByName('ClassName').AsString;
        frmCash.cboClassQry.Locate('ClassID', qryClass.FieldByName('ClassID').AsInteger, [loCaseInsensitive]);
        frmCash.tblMaster.Post;
        frmCash.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end;
    qryMain.Next;
  end;
  grdMain.UnselectAll;
  qryMain.First;
end;

procedure TRepairProfitabilityGUI.FormShow(Sender: TObject);
begin
  if Self.Parent is TDNMPanel then begin
    Self.AccessLevel := 1;
  end;
(*  if Self.Parent is TDNMPanel then begin
    chkIgnore.Visible := False;
    lblFrom.Visible   := False;
    dtFrom.Visible    := False;
    lblTo.Visible     := False;
    dtTo.Visible      := False;
  end;*)

  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'SaleId,ClientId,LineId');

  inherited;
  showFormHints;
end;

Function TRepairProfitabilityGUI.reporthint:String;
begin
  result:=  NL+' (1): ' + qrymaincostEx.DisplayLabel +'        =  Total cost for the Transaction Quantity from the transaction' +NL+
                  ' (2): ' + QrymainlandedCost.DisplayLabel +'       =  Product''s Landed Cost from product Card X the Transaction Quantity from the transaction' +NL+
                  ' (3): ' + QrymainlatestCost.DisplayLabel +'     =  Product''s Latest Cost from product Card X the Transaction Quantity from the transaction' +NL+
                  ' (4): ' + Qrymainincomeex.DisplayLabel +'    =  Total Price for the Transaction Quantity from the transaction' +NL+
                  ' (5): ' + Qrymainquotedex.DisplayLabel +'    =  Total Price for the Transaction Quantity from the transaction ONLY for ''Quote''' +NL+  NL+

                  ' (6): Income - Cost --> ONLY for ''Invoice'', ''Quote'', ''Refund'' , Cash Sale'' and ''POS'' ' +NL+
                  ' (7):        ' + QrymainDiffIncome_Cost.DisplayLabel +'  = (4) - (1) ' +NL +
                  ' (8):        ' + qrymainPercentDiffIncomebyCost.DisplayLabel +' = (  (4)-(1) )  /  (1)  ' +NL +NL +

                  ' (9): Income - Landed Cost --> ONLY for ''Invoice'', ''Quote'', ''Refund'' , Cash Sale'' and ''POS'' ' +NL +
                  '(10):        ' + qryMainDiffIncome_Landedcost.DisplayLabel +'  = (4) - (2) ' +NL +
                  '(11):        ' + qryMainPercentDiffIncomebyLandedcost.DisplayLabel +' = (  (4)-(2) )  /  (2)   ' +NL +NL +

                  '(12): Income - Latest Cost --> ONLY for ''Invoice'', ''Quote'', ''Refund'' , Cash Sale'' and ''POS'' ' +NL+
                  '(13):        ' + qryMainDiffIncome_Latestcost.DisplayLabel +'  = (4) - (3) ' +NL +
                  '(14):        ' + qryMainPercentDiffIncomebyLatestcost.DisplayLabel +' = (  (4)-(3) )  /  (3)   ' +NL +NL +

                  '(15): ' + qryMainProfitPercent.DisplayLabel +' (4) - (1) / (4)' +NL ;

end;


Procedure TRepairProfitabilityGUI.Showformhints;
begin
  Showcontrolhint(ApplyDtfilteron,' When ''PO Invoice Date'' Selected, the date filter will be applied to the purchase order''s Invoice Date' +NL +
                          ' When ''PO Order Date'' Selected, the date filter will be applied to the purchase order''s Order Date' +NL );
  grdmain.showhint := True;
  Showcontrolhint(grpfilters , 'Summary : Transactions Grouped for Each Customer( Or Job) ' + NL+
                              ' Details : Transactions Grouped for Each Customer( Or Job) and Transaction Type ' + NL+
                              ' Extra Details : No Grouping - List of all Transactions'+NL);
end;
procedure TRepairProfitabilityGUI.ShowReportHint;
begin
  DoMemoDialogOntop(self, self.Caption, Reporthint);
end;

procedure TRepairProfitabilityGUI.setclientID(const Value: Integer);
begin
  fiClientID := Value;
  openDb(qryCustomers);
  chkAllClients.Checked:= not(qryCustomers.Locate('ClientID' , Value , []));
end;

procedure TRepairProfitabilityGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
end;

procedure TRepairProfitabilityGUI.SetMainQuery;
var
  HasLimit : boolean;
  likeStatement : string;
  lPos : integer;
begin
    if (qryMain.SQL.Count > 0) and (pos('LIMIT 0', qryMain.SQL.Text) > 0) then
      hasLimit := true
    else
      hasLimit := false;
    likeStatement := '';
    if pos('LIKE ''', qrymain.SQL.Text) > 0 then
    begin
      for lPos := qryMain.SQL.Count - 1 downto 0 do
        if pos('LIKE ''', qrymain.SQL[lPos]) > 0 then
        begin
          likeStatement := qrymain.SQL[lPos];
          break;
        end;
    end;
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT');
    qryMain.SQL.Add('cast(Max(Details)+1 as signed) as Details,');
    qryMain.SQL.Add('cast(0  as Signed) as LineID,');
    qryMain.SQL.Add('CompanyName as CompanyName,');
    qryMain.SQL.Add('"" as Department ,');
    qryMain.SQL.Add('JobName,');
//  qryMain.SQL.Add('"" as JobNumber ,');
    qryMain.SQL.Add('cast(0  as Signed) as JobNumber,');
    qryMain.SQL.Add('"" as TransactionType ,');
    qryMain.SQL.Add('"" as TransactionNo,');
    qryMain.SQL.Add('AccountName as AccountName,');
    qryMain.SQL.Add('Round(Sum(DebitEx), 2) as DebitEx,');
    qryMain.SQL.Add('Round(Sum(CreditEx), 2) as CreditEx,');
    qryMain.SQL.Add('Round(Sum(Backorders), 2) as Backorders,');
    qryMain.SQL.Add('Round(Avg(ProfitPercent), 2) as ProfitPercent,');
    qryMain.SQL.Add('Round(Sum(ProfitDollars), 2) as ProfitDollars,');
    qryMain.SQL.Add('0 as SaleId,');
    qryMain.SQL.Add('ClientID as ClientID,');
    qryMain.SQL.Add('Round(Sum(CostEx), 2) as CostEx ,');
    qryMain.SQL.Add('Round(Sum(IncomeEx), 2) as IncomeEx ,');
    qryMain.SQL.Add('Round(Sum(Quotedex), 2) as Quotedex ,');
    qryMain.SQL.Add('Round(Sum(DiffIncome_Cost), 2) as DiffIncome_Cost ,');
    qryMain.SQL.Add('Round(Sum(DiffQuote_Cost), 2) as DiffQuote_Cost ,');
    qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyCost), 2) as PercentDiffIncomebyCost ,');
    qryMain.SQL.Add('Round(Avg(PercentDiffQuotebyCost), 2) as PercentDiffQuotebyCost ,');
    qryMain.SQL.Add('Round(Sum(LandedCost), 2) as LandedCost,');
    qryMain.SQL.Add('Round(Sum(Latestcost), 2) as Latestcost,');
    qryMain.SQL.Add('Round(Sum(DiffIncome_Landedcost), 2) as DiffIncome_Landedcost,');
    qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLandedcost), 2)  as PercentDiffIncomebyLandedcost,');
    qryMain.SQL.Add('Round(Sum(DiffIncome_Latestcost), 2) as DiffIncome_Latestcost,');
    qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLatestcost), 2)  as PercentDiffIncomebyLatestcost,');
    qryMain.SQL.Add('"" as ProductName,');
    qryMain.SQL.Add('"" as FirstColumn ,');
    qryMain.SQL.Add('"" as SecondColumn ,');
    qryMain.SQL.Add('"" as ThirdColumn ,');
    qryMain.SQL.Add('"" as Area,');
    qryMain.SQL.Add('"" as RepairStatus,');
    qryMain.SQL.Add('Round(Sum(ContractValue), 2) as ContractValue,');
    qryMain.SQL.Add('Round(Sum(SuggestedSalesAmount), 2) as SuggestedSalesAmount,');
    qryMain.SQL.Add('Round(Sum(EstimatedCost), 2) as EstimatedCost,');
    qryMain.SQL.Add('Round(Sum(QtyOrdered), 2) as QtyOrdered,');
    qryMain.SQL.Add('Round(Sum(QtyShipped), 2) as QtyShipped,');
    qryMain.SQL.Add('Round(Sum(QtyBackOrder), 2) as QtyBackOrder,');
    qryMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
    qryMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
    qryMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    qryMain.SQL.Add('FROM ' + fsTablename);
    if likeStatement <> '' then
      qryMain.SQL.Add(likeStatement);
    qryMain.SQL.Add('group by ClientId');
  case grpFilters.ItemIndex of
      csSummary :  begin// SUMMARY
        // summary outside if
      end;
      csExtraDetails: begin// Details
        qryMain.SQL.Add('UNION ALL');
        qryMain.SQL.Add('SELECT');
        qryMain.SQL.Add('cast(Details as signed)        as Details, ');
        qryMain.SQL.Add('cast(LineID  as Signed)        as LineID, ');
        qryMain.SQL.Add('CompanyName                    as CompanyName, ');
        qryMain.SQL.Add('Department                     as Department , ');
        qryMain.SQL.Add('JobName                        as JobName, ');
        qryMain.SQL.Add('Cast(JobNumber as Signed)      as JobNumber , ');
        qryMain.SQL.Add('TransactionType                as TransactionType , ');
        qryMain.SQL.Add('TransactionNo as TransactionNo,');// 'TransactionNo                  as TransactionNo,');
        qryMain.SQL.Add('AccountName                    as AccountName, ');
        qryMain.SQL.Add('DebitEx                        as DebitEx, ');
        qryMain.SQL.Add('CreditEx                       as CreditEx,');
        qryMain.SQL.Add('Backorders                     as Backorders, ');
        qryMain.SQL.Add('ProfitPercent                  as ProfitPercent, ');
        qryMain.SQL.Add('ProfitDollars                  as ProfitDollars, ');
        qryMain.SQL.Add('cast(SaleID as signed)         as SaleID, ');
        qryMain.SQL.Add('ClientID                       as ClientID,');
        qryMain.SQL.Add('(CostEx)                       as CostEx , ');
        qryMain.SQL.Add('(IncomeEx)                     as IncomeEx ,');
        qryMain.SQL.Add('(Quotedex)                     as Quotedex ,');
        qryMain.SQL.Add('(DiffIncome_Cost)             as DiffIncome_Cost , ');
        qryMain.SQL.Add('(DiffQuote_Cost)              as DiffQuote_Cost ,');
        qryMain.SQL.Add('(PercentDiffIncomebyCost)      as PercentDiffIncomebyCost , ');
        qryMain.SQL.Add('(PercentDiffQuotebyCost)       as PercentDiffQuotebyCost ,');
        qryMain.SQL.Add('LandedCost                     as LandedCost,');
        qryMain.SQL.Add('Latestcost                     as Latestcost,');
        qryMain.SQL.Add('DiffIncome_Landedcost         as DiffIncome_Landedcost,');
        qryMain.SQL.Add('PercentDiffIncomebyLandedcost  as PercentDiffIncomebyLandedcost,');
        qryMain.SQL.Add('DiffIncome_Latestcost         as DiffIncome_Latestcost,');
        qryMain.SQL.Add('PercentDiffIncomebyLatestcost  as PercentDiffIncomebyLatestcost,');
        qryMain.SQL.Add('ProductName                    as ProductName,');
        qryMain.SQL.Add('FirstColumn                    as FirstColumn ,');
        qryMain.SQL.Add('SecondColumn                   as SecondColumn ,');
        qryMain.SQL.Add('ThirdColumn                    as ThirdColumn ,');
        qryMain.SQL.Add('Area                           as Area,');
        qryMain.SQL.Add('RepairStatus as RepairStatus,');   // @@@
        qryMain.sql.Add('ContractValue AS ContractValue,');
        qryMain.SQL.Add('SuggestedSalesAmount as SuggestedSalesAmount,');
        qryMain.SQL.Add('EstimatedCost as EstimatedCost,');
        qryMain.SQL.Add('QtyOrdered                     as QtyOrdered,');
        qryMain.SQL.Add('QtyShipped                     as QtyShipped,');
        qryMain.SQL.Add('QtyBackOrder                   as QtyBackOrder,');
        qryMain.SQL.Add('CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,');
        qryMain.SQL.Add('CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,');
        qryMain.SQL.Add('CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
        qryMain.SQL.Add('FROM ' + fsTablename);
        if likeStatement <> '' then qryMain.SQL.Add(likeStatement);
      end;
      csDetails: begin// Extra details
        qryMain.SQL.Add('UNION ALL');
        qryMain.SQL.Add('SELECT');
        qryMain.SQL.Add('Details as Details,');
        qryMain.SQL.Add('0 as LineId,');
        qryMain.SQL.Add('CompanyName                    as CompanyName,');
        qryMain.SQL.Add('Department                     as Department ,');
        qryMain.SQL.Add('IFNULL(JobName, "")            as JobName,');
        qryMain.SQL.Add('JobNumber                      as JobNumber ,');
        qryMain.SQL.Add('TransactionType                as TransactionType ,');
        qryMain.SQL.Add('NULL  as TransactionNo,');
        qryMain.SQL.Add('AccountName                    as AccountName,');
        qryMain.SQL.Add('Round(Sum(DebitEx), 2)         as DebitEx,');
        qryMain.SQL.Add('Round(sum(CreditEx),2)         as CreditEx,');
        qryMain.SQL.Add('Backorders                     as Backorders,');
        qryMain.SQL.Add('Round(Avg(ProfitPercent),2)    as ProfitPercent,');
        qryMain.SQL.Add('Round(Sum(ProfitDollars),2) as ProfitDollars,');
        qryMain.SQL.Add('cast(SaleID as signed)         as SaleID,');
        qryMain.SQL.Add('ClientID                       as ClientID,');
        qryMain.SQL.Add('Round(Sum(CostEx),2)           as CostEx ,');
        qryMain.SQL.Add('Round(Sum(IncomeEx),2)         as IncomeEx ,');
        qryMain.SQL.Add('Round(Sum(Quotedex),2)         as Quotedex ,');
        qryMain.SQL.Add('Round(Sum(DiffIncome_Cost),2)  as DiffIncome_Cost ,');
        qryMain.SQL.Add('Round(Sum(DiffQuote_Cost),2)   as DiffQuote_Cost ,');
        qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyCost),2)      as PercentDiffIncomebyCost ,');
        qryMain.SQL.Add('Round(Avg(PercentDiffQuotebyCost),2)        as PercentDiffQuotebyCost ,');
        qryMain.SQL.Add('Round(Sum(LandedCost),2)       as LandedCost,');
        qryMain.SQL.Add('Round(Sum(Latestcost),2)       as Latestcost,');
        qryMain.SQL.Add('Round(Sum(DiffIncome_Landedcost),2) as DiffIncome_Landedcost,');
        qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLandedcost),2)   as PercentDiffIncomebyLandedcost,');
        qryMain.SQL.Add('Round(Sum(DiffIncome_Latestcost),2)          as DiffIncome_Latestcost,');
        qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLatestcost),2)   as PercentDiffIncomebyLatestcost,');
        qryMain.SQL.Add('ProductName                    as ProductName,');
        qryMain.SQL.Add('FirstColumn                    as FirstColumn ,');
        qryMain.SQL.Add('SecondColumn                   as SecondColumn ,');
        qryMain.SQL.Add('ThirdColumn                    as ThirdColumn ,');
        qryMain.SQL.Add('Round(Avg(Area),2)             as Area,');
        qryMain.SQL.Add('IFNULL(RepairStatus, "") as RepairStatus,');
        qryMain.sql.Add('ContractValue,');
        qryMain.SQL.Add('SuggestedSalesAmount,');
        qryMain.SQL.Add('EstimatedCost,');
        qryMain.SQL.Add('Round(Sum(QtyOrdered),2)       as QtyOrdered,');
        qryMain.SQL.Add('Round(Sum(QtyShipped),2)       as QtyShipped,');
        qryMain.SQL.Add('Round(Sum(QtyBackOrder),2)     as QtyBackOrder,');
        qryMain.SQL.Add('CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,');
        qryMain.SQL.Add('CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,');
        qryMain.SQL.Add('CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
        qryMain.SQL.Add('FROM ' + fsTablename);
        if likeStatement <> '' then
          qryMain.SQL.Add(likeStatement);
        qryMAin.SQL.Add(' Group by CompanyName, JobNumber, TransactionType'); //SaleId'); //TransactionNo');
      end;
  end;
  qryMain.SQL.Add('order by companyname, JobNumber, details desc');

  if hasLimit then qryMain.SQL.Add('LIMIT 0');
end;

procedure TRepairProfitabilityGUI.SetupFormInPanel;
begin
  inherited;
  btnFieldDetails.Visible:= false;
end;

procedure TRepairProfitabilityGUI.cboClassCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then exit;
  inherited;
  //
  if cboClass.Text <> '' then
  begin
    qryMain.Filter := 'Department=''' + cboClass.Text + '''';
    qryMain.Filtered := true;
  end;
  RefreshQuery;
end;

procedure TRepairProfitabilityGUI.cboClientsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;


procedure TRepairProfitabilityGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  //UpdateTotals;
end;


procedure TRepairProfitabilityGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  //UpdateTotals;
end;

procedure TRepairProfitabilityGUI.ApplyDtfilteronClick(Sender: TObject);
begin
  inherited;
    RefreshQuery;
end;

procedure TRepairProfitabilityGUI.btnFieldDetailsClick(Sender: TObject);
begin
  inherited;
  ShowReportHint;
end;

procedure TRepairProfitabilityGUI.CalcFooter;
var
  ctr: integer;
begin
  if grpFilters.ItemIndex <> csDetails then
  begin
    inherited;
    exit;
  end;

  for ctr := low(FooterCalcfields) to high(FooterCalcfields) do
    if (qryMain.FindField(FooterCalcfields[ctr].fieldname) <> nil) and
       (qryMainDetails.AsInteger <> 2) then
      FooterCalcfields[ctr].Total := FooterCalcfields[ctr].Total + qryMain.FindField(FooterCalcfields[ctr].fieldname).asfloat;
end;

procedure TRepairProfitabilityGUI.RefreshTotals;
begin
  inherited;
  Calcnshowfooter;
  grdMain.ColumnByName('PercentDiffIncomebyCost').FooterValue := FloatToStrF(DivZer((Fieldtotal('IncomeEx') - Fieldtotal('CostEx')  ), Fieldtotal('CostEx')  ) * 100, ffNumber, 15, 2) + '%';
  grdMain.ColumnByName('PercentDiffQuotebyCost').FooterValue  := FloatToStrF(DivZer((Fieldtotal('IncomeEx') - fieldTotal('Quotedex')), fieldTotal('Quotedex')) * 100, ffNumber, 15, 2) + '%';
  grdMain.ColumnByName('PercentDiffIncomebyLandedcost').FooterValue := FloatToStrF(DivZer((Fieldtotal('IncomeEx') - Fieldtotal('LandedCost')  ), Fieldtotal('LandedCost')  ) * 100, ffNumber, 15, 2) + '%';
  grdMain.ColumnByName('PercentDiffIncomebyLatestcost').FooterValue := FloatToStrF(DivZer((Fieldtotal('IncomeEx') - Fieldtotal('Latestcost')  ), Fieldtotal('Latestcost')  ) * 100, ffNumber, 15, 2) + '%';
  grdMain.ColumnByName('ProfitPercent').FooterValue           := FloatToStrF(DivZer((Fieldtotal('IncomeEx') - Fieldtotal('CostEx')  ), Fieldtotal('IncomeEx')) * 100, ffNumber, 15, 2) + '%';
//  UpdateTotals;
end;


initialization
  RegisterClassOnce(TRepairProfitabilityGUI);
end.


