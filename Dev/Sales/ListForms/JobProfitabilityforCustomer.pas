unit JobProfitabilityforCustomer;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
  BJ :report copied from TJobProfitabilityGUI
  and changed as the f5,f6,f7 was not working in TJobProfitabilityGUI
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
  TJobProfitabilityforCustomerGUI = class(TBaseListingGUI)
    qryMainCompanyName: TWideStringField;
    qryMainSupplierName: TWideStringField;
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
    qryMainTransDate: TDateTimeField;
    btnSetup: TDNMSpeedButton;
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
    procedure cmdPrintClick(Sender: TObject);
    procedure btnSetupClick(Sender: TObject);
  private
    fsTablename:String;
    fiClientID: Integer;
    fCustomColumns: array of string;
    fFromSetup: Boolean;

    { Private declarations }
    (*procedure UpdateTotals;*)
    procedure setclientID(const Value: Integer);
    procedure Showformhints;
    function reporthint: String;
    Procedure ShowReportHint;
    procedure AddCustomFields;
    procedure AddCalcColumns;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure CalcFooter;override;
    //procedure DeleteContentsFromTemporaryTable;
    procedure CreateTemporaryJobProfitTable;
    procedure DestroyTemporaryJobProfitTable;
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
  LogLib, frmCustomSetup;

const
  csSummary = 0;
  csDetails = 1;
  csExtraDetails = 2;

procedure TJobProfitabilityforCustomerGUI.FormCreate(Sender: TObject);
var
  i: Integer;
  form: TCustomSetup;
begin
  // Read GuiPrefs of TCustomSetup
  form := TCustomSetup.Create(nil);
  with form do begin
    GuiPrefs.Active := True;
    GuiPrefs.LoadPrefs;

    SetLength(fCustomColumns, GuiPrefs.Node['Headers'].Count);

    for i := 0 to GuiPrefs.Node['Headers'].Count - 1 do begin
      fCustomColumns[i] := form.GuiPrefs.Node['Headers'].Items[i].AsString;
    end;

    Free;
  end;

  fsTablename := GetUserTemporaryTableName('jobprofitabilityCustomer');
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
  AddCalcColumns;

  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Open;
  qryClass.Open;

  CreateTemporaryJobProfitTable;
  fFromSetup := False;
end;

procedure TJobProfitabilityforCustomerGUI.grdMainDblClick(Sender: TObject);
begin
  if grpFilters.ItemIndex > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('TransactionType').AsString;
    inherited;
  end else if issubform then begin
    inherited;
  end;
end;

procedure TJobProfitabilityforCustomerGUI.RefreshQuery;
  procedure AddDateFilter(const Filterfieldname :STring);
  begin
    ScriptMain.SQL.Add('AND ' + Filterfieldname + ' BETWEEN ' +
      QuotedStr(formatDatetime(MysqlDateTimeFormat, filterDateFrom)) +
      ' AND ' + QuotedStr(formatDatetime(MysqlDateTimeFormat, FilterDateto)) + '');
  end;

  procedure AddFieldsToInsert;
  var
    K: Integer;
    ColumnList: TStringList;
    ColumnName: String;
  begin
    for K := Low(fCustomColumns) to High(fCustomColumns) do begin
      ColumnList := TStringList.Create;
      Try
        FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
        ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);
        ScriptMain.SQL.Add(', ' + ColumnName);
      Finally
        FreeandNil(ColumnList);
      End;
    end;

    ScriptMain.SQL.Add(')');
  end;

  procedure AddCustomColumns3(AField: string; AAmount: string; AIsName: bool = False);
  var
    K: Integer;
    ColumnList, ColumnList2: TStringList;
    ColumnName: String;
    AccID, AccName: string;
    StrSQL: string;
  begin
    for K := Low(fCustomColumns) to High(fCustomColumns) do begin
      ColumnList := TStringList.Create;
      ColumnList2 := TStringList.Create;
      Try
        FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
        ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);

        FastFuncs.Split(ColumnList[1], '@', ColumnList2);
        AccID := ColumnList2[0];
        AccName := ColumnList2[1];
        if not AIsName then
          StrSQL := ', IF(' + AField + '=' + AccID + ', ' + AAmount + ', 0.0) AS ' + ColumnName
        else
          StrSQL := ', IF(' + AField + '="' + AccName + '", ' + AAmount + ', 0.0) AS ' + ColumnName;

        ScriptMain.SQL.Add(StrSQL);

      Finally
        FreeandNil(ColumnList);
        FreeandNil(ColumnList2);
      End;
    end;
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
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    AddCustomColumns3('s.AccountID', 'If(s.IsInvoice="T", Sum(sl.LineCost * Shipped), IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  SUM(sl.LineCost * Shipped), SUM(0.00)))');
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
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    AddCustomColumns3('PL.AccountName', 'SUM(TotalLineAmount)', True);
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
    ScriptMain.SQL.Add(Splitfield('C', 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, IF(C.Burden > 0, CONCAT("Payroll + ", CONVERT(C.Burden, CHAR), "%"), "Payroll") AS TransactionType,');
    ScriptMain.SQL.Add('PL.ClientID, 0 AS InvoiceNo, SUM(LineTotal) * (1 + C.Burden/100) AS "CostEx",');
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
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    AddCustomColumns3('C.Account2ID', '(1 + C.Burden/100)');
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
    ScriptMain.SQL.Add('P.JobID, 0 AS InvoiceNo, ');
    ScriptMain.SQL.Add('IF(P.JobID > 0, Sum(P.Total), Sum(0.00)) AS "CostEx",');
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
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    AddCustomColumns3('C.Account2ID', 'IF(P.JobID > 0, SUM(P.Total), SUM(0.00))');
    ScriptMain.SQL.Add('FROM tbltimesheets P');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = P.JobID');
    ScriptMain.SQL.Add('WHERE (P.Active = "T" AND P.JobID > 0)');
    Adddatefilter('P.ServiceDate');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND P.JobID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY P.JobID');
  end;

  Procedure AddJournalEnties;
  begin
      ScriptMain.SQL.Add('/*JOURNALENTRIES*/');
      ScriptMain.SQL.Add('SELECT DISTINCT 0,');
      ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
      ScriptMain.SQL.Add('JobName, C.JobNumber, JED.GJID, ');
      ScriptMain.SQL.Add('"Journal entry" AS "TransactionType",');
      ScriptMain.SQL.Add('JED.ClientID,');
      ScriptMain.SQL.Add('0 as Invoiceno,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0)) AS CostEx,');
      ScriptMain.SQL.Add('0 AS IncomeEx,');
      ScriptMain.SQL.Add('0 AS Quotedex,');
      ScriptMain.SQL.Add('sum(JED.DebitAmount) AS DebitEx,');
      ScriptMain.SQL.Add('sum(JED.CreditAmount) AS CreditEx,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0))  AS DiffIncome_Cost ,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0))   as PercentDiffIncomebyCost,');
      ScriptMain.SQL.Add('0 AS DiffQuote_Cost,');
      ScriptMain.SQL.Add('0 AS PercentDiffQuotebyCost,');
      ScriptMain.SQL.Add('0 AS Backorders,');
      ScriptMain.SQL.Add('0 AS ProfitPercent,');
      ScriptMain.SQL.Add('0 AS ProfitDollars,');
      ScriptMain.SQL.Add('JED.GJDID,');
      ScriptMain.SQL.Add('JED.ClassName ,');
      ScriptMain.SQL.Add('"" AS ProductName,');
      ScriptMain.SQL.Add('"" AS FirstColumn,');
      ScriptMain.SQL.Add('"" AS SecondColumn,');
      ScriptMain.SQL.Add('"" AS ThirdColumn,');
      ScriptMain.SQL.Add('"" AS Area,');
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      AddCustomColumns3('JED.AccountID', 'IF(JED.clientID > 0, SUM(JED.CreditAmount - JED.DebitAmount), SUM(0))');
      ScriptMain.SQL.Add('FROM tblgeneraljournaldetails JED '+
                          ' INNER JOIN tblgeneraljournal JE ON JED.GJID = JE.GJID  '+
                          ' INNER JOIN tblclients C ON JED.ClientID = C.ClientID');
      ScriptMain.SQL.Add('WHERE (JED.clientID > 0)');
      Adddatefilter('JE.TransactionDate');

      if not chkAllClients.Checked then begin
        ScriptMain.SQL.Add('AND JED.clientID = ' + qryCustomers.FieldByName('ClientID').AsString);
      end;
      ScriptMain.SQL.Add('GROUP BY JED.ClientID');
  end;

  Procedure Addrepairs;
  begin
    ScriptMain.SQL.Add('/*REPAIRS*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('0 AS Details,' +Splitfield('C' , 'Company',1) +' ,C.JobName,');
    ScriptMain.SQL.Add('C.JobNumber,R.RepairID,"Repair" AS "TransactionType",');
    ScriptMain.SQL.Add('R.CusID,R.RepairID AS transactionno, sum(RP.Linecost*RP.Qty) AS "CostEx",');
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
    ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
    ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
    ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
    AddCustomColumns3('C.Account2ID', 'SUM(RP.Linecost * RP.Qty)');
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

  procedure AddStockAdjust;
  begin
    ScriptMain.SQL.Add('/*STOCKADJUST*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, s.StockAdjustEntryID, "Stock Adjustment" AS "TransactionType",');
    ScriptMain.SQL.Add('c.ClientID, 0 AS InvoiceNo, Sum(sl.Cost) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('SUM(sl.Cost) - SUM(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(SUM(sl.Cost) - SUM(0.00)) / SUM(sl.Cost) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('sl.ClassName AS Department,');
    ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    AddCustomColumns3('s.AccountID', 'SUM(sl.Cost)');
    ScriptMain.SQL.Add('FROM tblstockadjustentrylines sl');
    ScriptMain.SQL.Add('INNER JOIN tblstockadjustentry s USING(StockAdjustEntryID)');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID = sl.JobID');
    ScriptMain.SQL.Add('WHERE sl.Deleted="F" AND s.Deleted="F"');
    Adddatefilter('s.Adjustmentdate');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND c.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY c.ClientID');
  end;

  procedure AddAllowances;
  begin
    ScriptMain.SQL.Add('/*ALLOWANCES*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, a.PayAllowanceID, "Payroll-Other" AS TransactionType,');
    ScriptMain.SQL.Add('c.ClientID, 0 AS InvoiceNo, SUM(a.Qty * a.Amount) AS CostEx,');
    ScriptMain.SQL.Add('0.00 AS IncomeEx, 0.00 as Quotedex,');
    ScriptMain.SQL.Add('0.00 AS DebitEx,');
    ScriptMain.SQL.Add('0.00 AS CreditEx,');
    ScriptMain.SQL.Add('SUM(a.Qty * a.Amount) - SUM(0.00) AS DiffIncome_Cost,');
    ScriptMain.SQL.Add('(SUM(a.Qty * a.Amount) - SUM(0.00)) / SUM(a.Qty * a.Amount) * 100 AS PercentDiffIncomebyCost,');
    ScriptMain.SQL.Add('0.00 as DiffQuote_Cost, 0.00 as PercentDiffQuotebyCost,');
    ScriptMain.SQL.Add('0.00 AS Backorders, 0.00 AS ProfitPercent,');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('a.ClassName AS Department,');
    ScriptMain.SQL.Add('"" AS ProductName,');
    ScriptMain.SQL.Add('SPACE(255) AS FirstColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS SecondColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS ThirdColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS Area,');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    AddCustomColumns3('c.Account2ID', 'SUM(a.Qty * a.Amount)');
    ScriptMain.SQL.Add('FROM tblpaysallowances a');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID = a.ClientID');
    ScriptMain.SQL.Add('INNER JOIN tblpays p ON a.PayID=p.PayID');
    ScriptMain.SQL.Add('WHERE a.TaxExempt="T" AND p.Paid="T" AND p.Deleted="F"');
    AddDateFilter('p.DatePaid');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND c.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
    ScriptMain.SQL.Add('GROUP BY c.ClientID');
  end;

  {  Procedure AddSalesextraDetails;
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
  end;}
  Procedure AddsalesDetails;
  begin
      ScriptMain.SQL.Add('/*SALES DETAILS*/');
      ScriptMain.SQL.Add('SELECT');
      ScriptMain.SQL.Add('1 AS Details,S.Saledate,');
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
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      AddCustomColumns3('tp.INCOMEACCNT', 'IF(s.IsInvoice="T", sl.LineCost * Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.LineCost * Shipped, 0.00))', True);
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
{    Procedure AddPOextraDetails;
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
  end;  }

  Procedure AddPODetails;
  begin
      ScriptMain.SQL.Add('/*PURCHASE DETAILS*/');
      ScriptMain.SQL.Add('SELECT');
      ScriptMain.SQL.Add('STRAIGHT_JOIN 1,P.Orderdate,');
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
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      AddCustomColumns3('tp.COGSACCNT', 'TotalLineAmount', True);
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
      ScriptMain.SQL.Add('STRAIGHT_JOIN 0,P.OrderDate,');
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
      ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
      ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
      ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      AddCustomColumns3('PL.AccountName', 'TotalLineAmount', True);
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
          ScriptMain.SQL.Add('/*PAY DETAILS*/');
          ScriptMain.SQL.Add('SELECT 1,P.PayDate,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, IF(C.Burden > 0, CONCAT("Payroll + ", CONVERT(C.Burden, CHAR), "%"), "Payroll") AS TransactionType, ');
          ScriptMain.SQL.Add('PL.ClientID, ');
          ScriptMain.SQL.Add('P.PayID AS InvoiceNo,');
          ScriptMain.SQL.Add('LineTotal * (1 + C.Burden/100) AS "CostEx",');
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
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
          ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
          ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
          AddCustomColumns3('C.Account2ID', 'LineTotal * (1 + C.Burden/100)');
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

  Procedure AddJournalEntryDetails;
  begin
          ScriptMain.SQL.Add('/*JOURNAL DEAILS*/');
          ScriptMain.SQL.Add('SELECT DISTINCT 1,JE.TransactionDate, ');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('JobName, C.JobNumber, JED.GJID, "Journal entry" AS "TransactionType",');
          ScriptMain.SQL.Add('JED.ClientID, ');
          ScriptMain.SQL.Add('0 as Invoiceno,');
          ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount AS CostEx,');
          ScriptMain.SQL.Add('0 AS IncomeEx,');
          ScriptMain.SQL.Add('0 AS Quotedex,');
          ScriptMain.SQL.Add('JED.DebitAmount AS DebitEx,');
          ScriptMain.SQL.Add('JED.CreditAmount AS CreditEx,');
          ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount AS DiffIncome_Cost ,');
          ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount  as PercentDiffIncomebyCost,');
          ScriptMain.SQL.Add('0 AS DiffIncome_Quote,');
          ScriptMain.SQL.Add('0 AS PercentDiffIncomebyQuote,');
          ScriptMain.SQL.Add('0 AS DiffQuote_Cost,');
          ScriptMain.SQL.Add('0 AS PercentDiffQuotebyCost,');
          ScriptMain.SQL.Add('0 AS Backorders,');
          ScriptMain.SQL.Add('0 AS ProfitPercent,');
          ScriptMain.SQL.Add('0 AS ProfitDollars,');
          ScriptMain.SQL.Add('JED.GJDID,');
          ScriptMain.SQL.Add('JED.ClassName ,');
          ScriptMain.SQL.Add('"" AS ProductName,');
          ScriptMain.SQL.Add('null AS ProductId,');
          ScriptMain.SQL.Add('null AS QtyOrdered,');
          ScriptMain.SQL.Add('null AS QtyShipped,');
          ScriptMain.SQL.Add('null AS QtyBackOrder,');
          ScriptMain.SQL.Add('"" AS FirstColumn,');
          ScriptMain.SQL.Add('"" AS SecondColumn,');
          ScriptMain.SQL.Add('"" AS ThirdColumn,');
          ScriptMain.SQL.Add('"" AS Area,');
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
          ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
          ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
          AddCustomColumns3('JED.AccountID', 'JED.CreditAmount - JED.DebitAmount');
          ScriptMain.SQL.Add('FROM tblgeneraljournaldetails JED  '+
                              ' INNER JOIN tblgeneraljournal JE ON JED.GJID = JE.GJID  '+
                              ' INNER JOIN tblclients C ON JED.ClientID = C.ClientID');
          ScriptMain.SQL.Add('WHERE (JED.clientID > 0)');
          Adddatefilter('JE.TransactionDate');

          if not chkAllClients.Checked then begin
            ScriptMain.SQL.Add('AND JED.clientID = ' + qryCustomers.FieldByName('ClientID').AsString);
          end;
  end;

  Procedure AddtimesheetDetails;
  begin
          ScriptMain.SQL.Add('/*TIMESHEET DETAILS*/');
          ScriptMain.SQL.Add('SELECT DISTINCT 1,P.TimesheetDate,');
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
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
          ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
          ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
          ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
          AddCustomColumns3('C.Account2ID', 'Total');
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
  (*
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('1 AS Details,');
          ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
          ScriptMain.SQL.Add('C.JobName,');
          ScriptMain.SQL.Add('C.JobNumber,');
          ScriptMain.SQL.Add('R.RepairID,');
          ScriptMain.SQL.Add('"Repairs" as "TransactionType",');
          ScriptMain.SQL.Add('R.CusID,');
          ScriptMain.SQL.Add('R.RepairID AS TransactionNo,');
          ScriptMain.SQL.Add('RP.Linecost*RP.Qty  as "CostEx",');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty as "IncomeEx",');
          ScriptMain.SQL.Add('R.QuotedAmount as "Quotedex",');
          ScriptMain.SQL.Add('0.00 AS "DebitEx",');
          ScriptMain.SQL.Add('0.00 AS "CreditEx",');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty as "DiffIncome_Cost",');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100, ');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty) as "$ Diff (Income/Cost)",');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as "PercentDiffIncomebyCost",');
          ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty AS "DiffIncome_Quote",');
          ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as  "PercentDiffIncomebyQuote",');
          ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
          ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
          ScriptMain.SQL.Add('0 as BackOrders,');
          ScriptMain.SQL.Add('RP.ClassName,');
          ScriptMain.SQL.Add('RP.PartName,');
          ScriptMain.SQL.Add('RP.PartsID as ProductID,');
          ScriptMain.SQL.Add('null as QtyOrdered,');
          ScriptMain.SQL.Add('null as QtyShipped,');
          ScriptMain.SQL.Add('null as QtyBackOrder,');
          ScriptMain.SQL.Add(Firstcolumn +' AS FirstColumn,');
          ScriptMain.SQL.Add(SecondColumn +' AS SecondColumn,');
          ScriptMain.SQL.Add(ThirdColumn +' AS ThirdColumn, ');
          ScriptMain.SQL.Add('P.Area, ');
          ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
          ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
          ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
          ScriptMain.SQL.Add('FROM');
          ScriptMain.SQL.Add('tblrepairs AS R');
          ScriptMain.SQL.Add('Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID');
          ScriptMain.SQL.Add('Inner Join tblparts AS P ON RP.PartsID = P.PARTSID');
          ScriptMain.SQL.Add('Inner Join tblclients AS C ON R.CusID = C.ClientID');
          ScriptMain.SQL.Add('Where R.converted = "F"');
*)
          ScriptMain.SQL.Add('/*REPAIR DETAILS*/');
          ScriptMain.SQL.Add('SELECT');
          ScriptMain.SQL.Add('1 AS Details,R.UpdateDate,');
          ScriptMain.SQL.Add('Left(SUBSTRING_INDEX(C.Company,"^",1),255) AS CompanyName,');
          ScriptMain.SQL.Add('C.JobName,  C.JobNumber, R.RepairID, "Repairs" as "TransactionType",');
          ScriptMain.SQL.Add('R.CusID, R.RepairID AS TransactionNo, RP.Linecost*RP.Qty  as "CostEx",');
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
          ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
          ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
          ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
          AddCustomColumns3('C.Account2ID', 'RP.Linecost*RP.Qty');
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

  procedure AddStockAdjustDetails;
  begin
    ScriptMain.SQL.Add('/*STOCKADJUST DETAILS*/');
    ScriptMain.SQL.Add('SELECT 0, s.CreationDate,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, s.StockAdjustEntryID, "Stock Adjustment" AS "TransactionType",');
    ScriptMain.SQL.Add('c.ClientID, 0 AS TransactionNo, (sl.Cost * sl.AdjustQty) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "QuotedEx", 0.00 AS "DebitEx", 0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('(sl.Cost - 0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(sl.Cost - 0.00) / sl.Cost * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('sl.ClassName AS Department,');
    ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
    ScriptMain.SQL.Add('sl.ProductID AS ProductId,');
    ScriptMain.SQL.Add('sl.AvailableUOMQty AS QtyOrdered,');
    ScriptMain.SQL.Add('sl.FinalUOMQty AS QtyShipped,');
    ScriptMain.SQL.Add('sl.AdjustUOMQty AS QtyBackOrder,');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    AddCustomColumns3('s.AccountID', '(sl.Cost * sl.AdjustQty)');
    ScriptMain.SQL.Add('FROM tblstockadjustentrylines sl');
    ScriptMain.SQL.Add('INNER JOIN tblstockadjustentry s USING(StockAdjustEntryID)');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID=sl.JobID');
    ScriptMain.SQL.Add('WHERE sl.Deleted="F" AND s.Deleted="F"');
    AddDateFilter('s.AdjustmentDate');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND c.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
    end;
  end;

  procedure AddAllowanceDetails;
  begin
    ScriptMain.SQL.Add('/*ALLOWANCE DETAIL*/');
    ScriptMain.SQL.Add('SELECT 0, p.PayDate,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, a.PayAllowanceID, "Payroll-Other" AS TransactionType,');
    ScriptMain.SQL.Add('c.ClientID, 0 AS TransactionNo, a.Qty * a.Amount AS CostEx,');
    ScriptMain.SQL.Add('0.00 AS IncomeEx, 0.00 as QuotedEx, 0.00 AS DebitEx, 0.00 AS CreditEx,');
    ScriptMain.SQL.Add('(a.Qty * a.Amount - 0.00) AS DiffIncome_Cost,');
    ScriptMain.SQL.Add('(a.Qty * a.Amount - 0.00) / a.Qty * a.Amount * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('a.ClassName AS Department,');
    ScriptMain.SQL.Add('"" AS "ProductName",');
    ScriptMain.SQL.Add('null AS ProductId,');
    ScriptMain.SQL.Add('null AS QtyOrdered,');
    ScriptMain.SQL.Add('null AS QtyShipped,');
    ScriptMain.SQL.Add('null AS QtyBackOrder,');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    AddCustomColumns3('c.Account2ID', 'a.Qty * a.Amount');
    ScriptMain.SQL.Add('FROM tblpaysallowances a');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID=a.ClientID');
    ScriptMain.SQL.Add('INNER JOIN tblpays p ON a.PayID=p.PayID');
    ScriptMain.SQL.Add('WHERE a.TaxExempt="T" AND p.Paid="T" AND p.Deleted="F"');
    AddDateFilter('p.DatePaid');

    if not chkAllClients.Checked then begin
      ScriptMain.SQL.Add('AND c.ClientID=' + qryCustomers.FieldByName('ClientID').AsString);
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
    ScriptMain.SQL.ADD('TRUNCATE TABLE ' + fstablename + ';');

    case grpFilters.ItemIndex of
      csSummary:
        begin
          ScriptMain.SQL.add('INSERT INTO ' + fstablename +
                ' (Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,'+
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,'+
                'DiffQuote_Cost,PercentDiffQuotebyCost,Backorders,ProfitPercent, ProfitDollars, LineID,Department,'+
                'ProductName,FirstColumn,SecondColumn,ThirdColumn,Area, ' +
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
          AddFieldsToInsert;

          Addsales;         ScriptMain.SQL.Add(' UNION ALL ' );
          AddPOs;           ScriptMain.SQL.Add(' UNION ALL ' );
          AddPays;          ScriptMain.SQL.Add(' UNION ALL ' );
          Addtimesheets;    ScriptMain.SQL.Add(' UNION ALL ' );
          AddJournalEnties; ScriptMain.SQL.Add(' UNION ALL ' );
          AddStockAdjust;   ScriptMain.SQL.Add(' UNION ALL ' );
          AddAllowances;    ScriptMain.SQL.Add(' UNION ALL ' );
          AddRepairs;
          ScriptMain.SQL.Add(' ;');
        end;

      csDetails:
        begin
          ScriptMain.SQL.add('INSERT INTO ' + fstablename +
                ' (Details,TransDate,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,' +
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,' +
                'DiffIncome_Quote,PercentDiffIncomebyQuote,DiffQuote_Cost,PercentDiffQuotebyCost,' +
                'Backorders,ProfitPercent, ProfitDollars, LineID,Department,ProductName,ProductID, QtyOrdered, QtyShipped, QtyBackOrder, FirstColumn,SecondColumn,ThirdColumn,Area, ' +
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
          AddFieldsToInsert;

          AddSalesDetails;        ScriptMain.SQL.add(' UNION ALL ' );
          AddPODetails;           ScriptMain.SQL.add(' UNION ALL ' );
          AddPayDetails;          ScriptMain.SQL.add(' UNION ALL ' );
          AddtimesheetDetails;    ScriptMain.SQL.add(' UNION ALL ' );
          AddJournalEntryDetails; ScriptMain.SQL.add(' UNION ALL ' );
          AddStockAdjustDetails;  ScriptMain.SQL.add(' UNION ALL ' );
          AddAllowanceDetails;    ScriptMain.SQL.Add(' UNION ALL ' );
          AddrepairDetails;
          ScriptMain.SQL.add(' ;');
        end;

      csExtraDetails:
        begin
          ScriptMain.SQL.add('INSERT INTO ' + fstablename +
                ' (Details,TransDate,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,' +
                'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,' +
                'DiffIncome_Quote,PercentDiffIncomebyQuote,DiffQuote_Cost,PercentDiffQuotebyCost,' +
                'Backorders,ProfitPercent,ProfitDollars, ' +
                'LineID,Department,ProductName,ProductID, QtyOrdered, QtyShipped, ' +
//                'QtyBackOrder, FirstColumn,SecondColumn,ThirdColumn,Area) ' );
                'QtyBackOrder, FirstColumn,SecondColumn,ThirdColumn,Area, ' +
                'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
                'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
          AddFieldsToInsert;

          AddSalesDetails;        ScriptMain.SQL.add(' UNION ALL ' );
          AddPODetails;           ScriptMain.SQL.add(' UNION ALL ' );
          AddPayDetails;          ScriptMain.SQL.add(' UNION ALL ' );
          AddtimesheetDetails;    ScriptMain.SQL.add(' UNION ALL ' );
          AddJournalEntryDetails; ScriptMain.SQL.add(' UNION ALL ' );
          AddStockAdjustDetails;  ScriptMain.SQL.add(' UNION ALL ' );
          AddAllowanceDetails;    ScriptMain.SQL.Add(' UNION ALL ' );
          AddrepairDetails;       ScriptMain.SQL.add(' ;');
        end;
    end;

    ScriptMain.SQL.text := AppEnv.RegionalOptions.ChangeStr(ScriptMain.SQL.Text);

    ScriptMain.SQL.add('UPDATE ' + fstablename +
      ' set CostEx = IF(DebitEx <> 0.0, ABS(CostEx), -ABS(CostEx))' +
      ' WHERE TransactionType = ''Journal entry'';');

    ScriptMain.SQL.add('UPDATE ' + fstablename + ' set ProfitPercent = (IncomeEx - CostEx)/ IncomeEx * 100.0;');
    ScriptMain.SQL.add('UPDATE ' + fstablename + ' set ProfitDollars = (IncomeEx - CostEx);');
    ScriptMain.SQL.add('UPDATE ' + fstablename + ' set TransactionNo = null where details = 0;');

    if grpFilters.ItemIndex > csSummary then begin
      ScriptMain.SQL.add( ' UPDATE ' + fstablename + ' set DiffIncome_Cost = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
      ScriptMain.SQL.add( ' UPDATE ' + fstablename + ' set PercentDiffIncomebyCost  = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    end else begin
      ScriptMain.SQL.add( ' UPDATE ' + fstablename + ' set DiffIncome_Cost = IncomeEx-CostEx where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
      ScriptMain.SQL.add( ' UPDATE ' + fstablename + ' set PercentDiffIncomebyCost  = (IncomeEx-CostEx)/if(ifnull(CostEx,0)=0,IncomeEx,CostEx)*100 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    end;

    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' T inner join tblparts P on T.productID  = P.partsID set T.LandedCost        = P.LandedCost * T.QtyShipped, T.LatestCost = P.LatestCost * T.QtyShipped where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS");');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffIncome_Landedcost    = IncomeEx-LandedCost        where ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffIncome_Latestcost    =IncomeEx-Latestcost        where ifnull(ProductID,0)<> 0 and  TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffIncomebyLandedcost =  (IncomeEx-LandedCost)/if(ifnull(LandedCost,0)=0,IncomeEx,LandedCost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffIncomebyLatestcost = (IncomeEx-Latestcost)/if(ifnull(Latestcost,0)=0,IncomeEx,Latestcost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffQuote_Cost           =IncomeEx-Quotedex                where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffQuotebyCost =  (IncomeEx-Quotedex)/if(ifnull(Quotedex,0)=0,IncomeEx,Quotedex)*100 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set TransactionType ="Quote" where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0 and Details >0;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffIncome_Cost =IncomeEx-CostEx where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffIncomebyCost= (IncomeEx-CostEx)/if(ifnull(CostEx,0)=0,IncomeEx,CostEx)*100     where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');

    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffQuote_Cost = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffQuotebyCost =0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set CostEx =0 where TransactionType = "Quote";');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set DiffIncome_Cost = 0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' set PercentDiffIncomebyCost=0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');
    ScriptMain.SQL.add( '   UPDATE ' + fstablename + ' T '+
                        ' INNER JOIN tblpurchaseorders PO on T.saleId = PO.PurchaseorderId '+
                        ' Set T.Suppliername = PO.SupplierName '+
                        ' where TransactionType in ("Purchase Order" , "Bill" ,"Credit" "Cheque");');
    LogText(ScriptMain.SQLtext);
    ScriptMain.Execute;

    qryMain.EnableControls;

    SetMainQuery;
    //LogText(qryMain.SQL.Text);

    // Add field to query and grid
    AddCustomFields;

    if not fFromSetup then
      inherited;

    qryMain.Close;
    qryMain.Open;

    case grpFilters.ItemIndex of
      csSummary, csDetails:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS';
        end;

      csExtraDetails:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS';
        end;
    end;

    qryMain.First;

   // UpdateTotals;

  finally
    (*if Assigned(qry) then FreeAndNil(qry);*)
    Self.PopulateFilterCombo;
    Processingcursor(False);
  end;
end;

(*procedure TJobProfitabilityforCustomerGUI.DeleteContentsFromTemporaryTable;
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

procedure TJobProfitabilityforCustomerGUI.CreateTemporaryJobProfitTable;
  procedure AddCustomColumns;
  var
    K: Integer;
    ColumnList: TStringList;
    ColumnName: string;
  begin
    for K := Low(fCustomColumns) to High(fCustomColumns) do begin
      ColumnList := TStringList.Create;
      Try
        FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
        ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);
        Scriptmain.SQL.Add(ColumnName + ' DOUBLE DEFAULT 0, ');
      Finally
        FreeandNil(ColumnList);
      End;
    end;
  end;
begin
  DestroyTemporaryJobProfitTable;
  (*qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;*)
  with Scriptmain do begin
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + fsTablename + ' (');
    SQL.Add('ID                       int(11) NOT NULL AUTO_INCREMENT,');
    SQL.Add('Details                  INT(11)     DEFAULT 0,');
    SQL.Add('Transdate                DateTime,');
    SQL.Add('CompanyName              VARCHAR(255),');
    SQL.Add('SupplierName             VARCHAR(255),');
    SQL.Add('Department               VARCHAR(255),');
    SQL.Add('JobName                  VARCHAR(255),');
    SQL.Add('JobNumber                INT(11)     DEFAULT 0,');
    SQL.Add('SaleID                   INT(11)  NULL   DEFAULT 0,');
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
    AddCustomColumns;
    SQL.Add('INDEX    CompanyNameIndex (CompanyName),');
    SQL.Add('INDEX    SaleIDIndex (SaleID),');
    SQL.Add('INDEX    LineIDIndex (LineID),');
    SQL.Add('INDEX    TransactionTypeIndex (TransactionType),');
    SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM;');

    SQL.Text := AppEnv.RegionalOptions.ChangeStr(SQL.Text);
    Execute;
  end;
end;

procedure TJobProfitabilityforCustomerGUI.DestroyTemporaryJobProfitTable;
begin
  commondblib.DestroyUserTemporaryTable(fsTablename);
end;

procedure TJobProfitabilityforCustomerGUI.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryJobProfitTable;
  inherited;
end;

procedure TJobProfitabilityforCustomerGUI.FieldDetails1Click(Sender: TObject);
begin
  inherited;
  ShowReportHint;
end;

procedure TJobProfitabilityforCustomerGUI.grpFiltersClick(Sender: TObject);
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

procedure TJobProfitabilityforCustomerGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then
    exit; { just in case user switches off all fields in gui prefs }
  if Field.FieldName = 'JobNumber' then begin
    if qryMain.FieldByName('JobNumber').AsInteger = 0 then begin
    end;
  end;

  if grpFilters.ItemIndex = csExtraDetails then
  begin
    if qryMainDetails.AsInteger = 2 then
      AFont.Style := [fsBold]
  end
  else if grpFilters.ItemIndex = csSummary then
    AFont.Style := [fsBold]
  else
    AFont.Style := [];

  if field is TFloatField then
    if Field.asfloat = 0 then
      AFont.color := ABrush.color;
end;

procedure TJobProfitabilityforCustomerGUI.chkAllClientsClick(Sender: TObject);
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

procedure TJobProfitabilityforCustomerGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl <> chkIgnoreDates then exit;
  ApplyDtfilteron.Enabled     := not(chkIgnoreDates.Checked);
  lblApplyDate.Enabled        := not(chkIgnoreDates.Checked);
  if chkIgnoreDates.Checked then ApplyDtfilteron.ItemIndex   := -1 else ApplyDtfilteron.ItemIndex   := 0;
  RefreshQuery;
end;

procedure TJobProfitabilityforCustomerGUI.cmdPrintClick(Sender: TObject);
var
  ReportName, ReportSQL: string;
begin

  if not chkAdvancedPrinting.Checked then
    inherited
  else begin
    ReportName := 'Job Profitability';
    ReportSQL := '';
    PrintTemplateReport(ReportName, ReportSQL, not chkPreview.Checked, 1);
  end;

end;

procedure TJobProfitabilityforCustomerGUI.actSwapDepartmentUpdate(Sender: TObject);
begin
  inherited;
//  if (grdMain.SelectedList.Count = 0) or (grpFilters.ItemIndex < 1) or (cboClass.Text = '') then begin
  if (grdMain.SelectedList.Count = 0) or (grpFilters.ItemIndex = csSummary) or (cboClass.Text = '') then begin
    btnSwapClass.Enabled := False;
  end else begin
    btnSwapClass.Enabled := True;
  end;
end;

procedure TJobProfitabilityforCustomerGUI.actSwapDepartmentExecute(Sender: TObject);
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

procedure TJobProfitabilityforCustomerGUI.FormShow(Sender: TObject);
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

function TJobProfitabilityforCustomerGUI.reporthint : string;
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

procedure TJobProfitabilityforCustomerGUI.Showformhints;
begin
  ApplyDtfilteron.Hint := ' When ''PO Invoice Date'' Selected, the date filter will be applied to the purchase order''s Invoice Date' +NL +
                          ' When ''PO Order Date'' Selected, the date filter will be applied to the purchase order''s Order Date' +NL ;

  ApplyDtfilteron.showhint := True;
  grdmain.showhint := True;
end;

procedure TJobProfitabilityforCustomerGUI.ShowReportHint;
begin
  DoMemoDialogOntop(self, self.Caption, Reporthint);
end;

procedure TJobProfitabilityforCustomerGUI.setclientID(const Value: Integer);
begin
  fiClientID := Value;
  openDb(qryCustomers);
  chkAllClients.Checked:= not(qryCustomers.Locate('ClientID' , Value , []));
end;

procedure TJobProfitabilityforCustomerGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
end;

procedure TJobProfitabilityforCustomerGUI.SetMainQuery;
  procedure AddCustomColumns2;
  var
    K: Integer;
    ColumnList: TStringList;
    ColumnName: String;
  begin
    for K := Low(fCustomColumns) to High(fCustomColumns) do begin
      ColumnList := TStringList.Create;
      Try
        FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
        ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);
        qryMain.SQL.Add(', ' + ColumnName + ' AS "' + ColumnList[0] + '"');
      Finally
        FreeandNil(ColumnList);
      End;
    end;
  end;

  procedure AddCustomColumns22(AIsSum: Boolean = False);
  var
    K: Integer;
    ColumnList: TStringList;
    ColumnName: String;
  begin
    for K := Low(fCustomColumns) to High(fCustomColumns) do begin
      ColumnList := TStringList.Create;
      Try
        FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
        ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);
        if AIsSum then
          qryMain.SQL.Add(', 0.00 AS "' + ColumnList[0] + '"')
        else
          qryMain.SQL.Add(', ROUND(SUM(' + ColumnName + '), 2) AS "' + ColumnList[0] + '"');

      Finally
        FreeandNil(ColumnList);
      End;
    end;
  end;
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

  case grpFilters.ItemIndex of
    csSummary :  // SUMMARY
    begin
      qryMain.SQL.Clear;
      qryMain.SQL.Add('SELECT');
      qryMain.SQL.Add('cast(Details as signed) as Details,');
      qryMain.SQL.Add('Transdate as Transdate,');
      qryMain.SQL.Add('cast(0  as Signed) as LineID,');
      qryMain.SQL.Add('CompanyName as CompanyName,');
      qryMain.SQL.Add('SupplierName as SupplierName,');
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
      qryMain.SQL.Add('Round(Sum(QtyOrdered), 2) as QtyOrdered,');
      qryMain.SQL.Add('Round(Sum(QtyShipped), 2) as QtyShipped,');
      qryMain.SQL.Add('Round(Sum(QtyBackOrder), 2) as QtyBackOrder,');
      qryMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
      qryMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
      qryMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      AddCustomColumns22;
      qryMain.SQL.Add('FROM ' + fsTablename);
      if likeStatement <> '' then
        qryMain.SQL.Add(likeStatement);
      qryMain.SQL.Add('group by ClientId');
      qryMain.SQL.Add('order by companyname, SupplierName,JobName');
    end;

    csDetails: // Details
    begin
      qryMain.SQL.Clear;
      qryMain.SQL.Add('SELECT');
      qryMain.SQL.Add('2 as Details, ');
      qryMain.SQL.Add('Transdate as Transdate,');
      qryMain.SQL.Add('cast(0 as Signed)  as LineID, ');
      qryMain.SQL.Add('CompanyName as CompanyName, ');
      qryMain.SQL.Add('SupplierName as SupplierName, ');
      qryMain.SQL.Add('Department as Department , ');
  //    qryMain.SQL.Add('JobName as JobName, ');
      qryMain.SQL.Add('IFNULL(JobName, "")   as JobName,');
      qryMain.SQL.Add('cast(JobNumber as Signed) as JobNumber , ');
      qryMain.SQL.Add('"" as TransactionType,');// as TransactionType , ');
      qryMAin.SQL.Add('"" as TransactionNo,');
      qryMain.SQL.Add('AccountName as AccountName,');
      qryMain.SQL.Add('Round(Sum(DebitEx), 2) as DebitEx, ');
      qryMain.SQL.Add('Round(Sum(CreditEx),2) as CreditEx,');
      qryMain.SQL.Add('Backorders as Backorders,');
      qryMain.SQL.Add('Round(Avg(ProfitPercent),2) as ProfitPercent, ');
      qryMain.SQL.Add('Round(Sum(ProfitDollars),2) as ProfitDollars,');
      qryMain.SQL.Add('CAST(0 as signed) as SaleID, ');
      qryMain.SQL.Add('ClientID as ClientID,');
      qryMain.SQL.Add('Round(Sum(CostEx),2) as CostEx , ');
      qryMain.SQL.Add('Round(Sum(IncomeEx),2) as IncomeEx ,');
      qryMain.SQL.Add('Round(Sum(Quotedex),2) as Quotedex ,');
      qryMain.SQL.Add('Round(Sum(DiffIncome_Cost),2) as DiffIncome_Cost , ');
      qryMain.SQL.Add('Round(Sum(DiffQuote_Cost), 2) as DiffQuote_Cost ,');
      qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyCost),2) as PercentDiffIncomebyCost , ');
      qryMain.SQL.Add('Round(Avg(PercentDiffQuotebyCost),2) as PercentDiffQuotebyCost ,');
      qryMain.SQL.Add('Round(Sum(LandedCost),2) as LandedCost,');
      qryMain.SQL.Add('Round(Sum(Latestcost),2) as Latestcost,');
      qryMain.SQL.Add('Round(Sum(DiffIncome_Landedcost),2)         as DiffIncome_Landedcost,');
      qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLandedcost),2)  as PercentDiffIncomebyLandedcost,');
      qryMain.SQL.Add('Round(Sum(DiffIncome_Latestcost),2)         as DiffIncome_Latestcost,');
      qryMain.SQL.Add('Round(Avg(PercentDiffIncomebyLatestcost),2)  as PercentDiffIncomebyLatestcost,');
      qryMain.SQL.Add('"" as ProductName,'); //                    as ProductName,');
      qryMain.SQL.Add('"" as FirstColumn,'); //                     as FirstColumn ,');
      qryMain.SQL.Add('"" as SecondColumn,'); //                    as SecondColumn ,');
      qryMain.SQL.Add('"" as ThirdColumn,'); //                     as ThirdColumn ,');
      qryMain.SQL.Add('"" as Area,');//Round(Sum(Area),2)                           as Area,');
      qryMain.SQL.Add('Sum(QtyOrdered)                     as QtyOrdered,');
      qryMain.SQL.Add('Sum(QtyShipped)                     as QtyShipped,');
      qryMain.SQL.Add('Sum(QtyBackOrder)                   as QtyBackOrder,');
      qryMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
      qryMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
      qryMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      AddCustomColumns22(True);
      qryMain.SQL.Add('FROM ' + fsTablename);
      if likeStatement <> '' then
        qryMain.SQL.Add(likeStatement);

      qryMain.SQL.Add('group by ClientId, JobNumber');

     //  Details

      qryMain.SQL.Add('UNION ALL');
      qryMain.SQL.Add('SELECT');
      qryMain.SQL.Add('Details as Details,');
      qryMain.SQL.Add('Transdate as Transdate,');
      qryMain.SQL.Add('0 as LineId,');
      qryMain.SQL.Add('CompanyName                    as CompanyName,');
      qryMain.SQL.Add('SupplierName                   as SupplierName,');
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
      qryMain.SQL.Add('Round(Sum(QtyOrdered),2)       as QtyOrdered,');
      qryMain.SQL.Add('Round(Sum(QtyShipped),2)       as QtyShipped,');
      qryMain.SQL.Add('Round(Sum(QtyBackOrder),2)     as QtyBackOrder,');
      qryMain.SQL.Add('CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,');
      qryMain.SQL.Add('CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,');
      qryMain.SQL.Add('CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
      AddCustomColumns22;
      qryMain.SQL.Add('FROM ' + fsTablename);
      if likeStatement <> '' then
        qryMain.SQL.Add(likeStatement);
      qryMAin.SQL.Add(' Group by CompanyName,SupplierName, JobNumber, TransactionType'); //SaleId'); //TransactionNo');
      qryMain.SQL.Add('order by companyname, SupplierName, JobNumber, details desc');
    end;

    csExtraDetails: // Extra Details
    begin
      qryMain.SQL.Clear;
      qryMain.SQL.Add('SELECT');
      qryMain.SQL.Add('cast(Details as signed)        as Details, ');
      qryMain.SQL.Add('Transdate as Transdate,');
      qryMain.SQL.Add('cast(LineID  as Signed)        as LineID, ');
      qryMain.SQL.Add('CompanyName                    as CompanyName, ');
      qryMain.SQL.Add('SupplierName                   as SupplierName, ');
      qryMain.SQL.Add('Department                     as Department , ');
      qryMain.SQL.Add('JobName                        as JobName, ');
      qryMain.SQL.Add('Cast(JobNumber as Signed)      as JobNumber , ');
      qryMain.SQL.Add('TransactionType                as TransactionType , ');
      qryMain.SQL.Add('TransactionNo,');// 'TransactionNo                  as TransactionNo,');
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
      qryMain.SQL.Add('QtyOrdered                     as QtyOrdered,');
      qryMain.SQL.Add('QtyShipped                     as QtyShipped,');
      qryMain.SQL.Add('QtyBackOrder                   as QtyBackOrder,');
      qryMain.SQL.Add('CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,');
      qryMain.SQL.Add('CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,');
      qryMain.SQL.Add('CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15');
      AddCustomColumns2;
      qryMain.SQL.Add('FROM ' + fsTablename);
      if likeStatement <> '' then
        qryMain.SQL.Add(likeStatement);
    end;
  end;

  if hasLimit then
    qryMain.SQL.Add('LIMIT 0');
//  qrymain.SQL.SaveToFile('c:\dev\main.txt');
end;

procedure TJobProfitabilityforCustomerGUI.AddCustomFields;
var
  K: Integer;
  ColumnList: TStringList;
  ColumnName: string;
  ColIndex: Integer;
begin
  // Delete existing custom fields
  for K := qryMain.Fields.Count - 1 downto 0 do begin
    if LeftStr(qryMain.Fields[K].Name, 11) = 'qryMainRose' then begin
      qryMain.Fields[K].Destroy;
    end;
  end;

  ColIndex := 30; //grdMain.FieldCount;
  for K := Low(fCustomColumns) to High(fCustomColumns) do begin
    ColumnList := TStringList.Create;
    Try
      FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
      ColumnName := StringReplace(ColumnList[0], ' ', '', [rfReplaceAll]);

      // Create new field for the column
      with TFloatField.Create(Self) do begin
        FieldKind :=fkData;
        FieldName := ColumnList[0];
        Name := 'qryMainRose' + ColumnName;
        DataSet := qryMain;
      end;

      // Add the field to grid
      grdMain.AddField(ColumnList[0], ColIndex, True);
      Inc(ColIndex);

    Finally
      FreeandNil(ColumnList);
    End;
  end;
end;


procedure TJobProfitabilityforCustomerGUI.SetupFormInPanel;
begin
  inherited;
  btnFieldDetails.Visible:= false;
end;

procedure TJobProfitabilityforCustomerGUI.cboClassCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
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

procedure TJobProfitabilityforCustomerGUI.cboClientsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TJobProfitabilityforCustomerGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  //UpdateTotals;
end;

procedure TJobProfitabilityforCustomerGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  //UpdateTotals;
end;

procedure TJobProfitabilityforCustomerGUI.ApplyDtfilteronClick(Sender: TObject);
begin
  inherited;
    RefreshQuery;
end;

procedure TJobProfitabilityforCustomerGUI.btnFieldDetailsClick(Sender: TObject);
begin
  inherited;
  ShowReportHint;
end;

procedure TJobProfitabilityforCustomerGUI.btnSetupClick(Sender: TObject);
var
  form: TCustomSetup;
  i: Integer;
begin
  // Show a form
  form := TCustomSetup.Create(nil);
  try
    if form.ShowModal = mrOK then begin
      // Fill the array with selected custom columns
      SetLength(fCustomColumns, form.GuiPrefs.Node['Headers'].Count);
      for i := 0 to form.GuiPrefs.Node['Headers'].Count - 1 do begin
        fCustomColumns[i] := form.GuiPrefs.Node['Headers'].Items[i].AsString;
      end;

      // Refresh Query
      CreateTemporaryJobProfitTable;
      fFromSetup := True;
      RefreshQuery;
      AddCalcColumns;
    end;
  finally
    form.Free;
  end;
end;

procedure TJobProfitabilityforCustomerGUI.AddCalcColumns;
var
  K: Integer;
  ColumnList: TStringList;
begin
  for K := Low(fCustomColumns) to High(fCustomColumns) do begin
    ColumnList := TStringList.Create;
    Try
      FastFuncs.Split(fCustomColumns[K], ':', ColumnList);
      AddCalcColumn(ColumnList[0], true);
    Finally
      FreeandNil(ColumnList);
    End;
  end;
end;

procedure TJobProfitabilityforCustomerGUI.CalcFooter;
var
  ctr: integer;
begin
  if grpFilters.ItemIndex <> csExtraDetails then
  begin
    inherited;
    exit;
  end;

  for ctr := Low(FooterCalcfields) to High(FooterCalcfields) do
    if (qryMain.FindField(FooterCalcfields[ctr].FieldName) <> nil) and
       (qryMainDetails.AsInteger <> 2) then
      FooterCalcfields[ctr].Total := FooterCalcfields[ctr].Total + qryMain.FindField(FooterCalcfields[ctr].fieldname).asfloat;
end;

procedure TJobProfitabilityforCustomerGUI.RefreshTotals;
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
  RegisterClassOnce(TJobProfitabilityforCustomerGUI);
end.


