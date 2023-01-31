unit JobProfitabilityForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/06/05  1.00.01 IJB  Modified report to not include Payroll costs if these
                        have been invoiced (was previously showing Paroll cost
                        as well as cost on invoice).
 07/06/05  1.00.02 BJ   Drill down the timesgeet entry.
 14/09/05  1.00.03 IJB  Grid datasource was being set to nil in RefreshQuery and
                        this was causing a problem with grid customisation,
                        removed this.
 05/09/06  1.00.04 DSP  Now assign a value to the time sheet forms KeyID
                        before showing it.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MyAccess,ERPdbComponents, kbmMemTable,
  DBAccess, MemDS, wwdbdatetimepicker, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  Wwkeycb, wwdblook, ActnMan, ProgressDialog, CustomInputBox, Shader,
  PlatformDefaultStyleActnCtrls, DAScript, MyScript, wwcheckbox;

type
  TJobProfitabilityGUI = class(TBaseListingGUI)
    qryMainCompanyName: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainTransactionNo: TWideStringField;
    qryMainCostEx: TFloatField;
    qryMainPOCostEx: TFloatField;
    qryMainIncomeEx: TFloatField;
    qryMainAmountDiffIncomeCost: TFloatField;
    qryMainLatestcosttotal: TFloatField;
    qryMainLastcosttotal: TFloatField;
    qryMainQty: TFloatField;
    qryMainLatestcost: TFloatField;
    qryMainLastcost: TFloatField;
    qryMainLastPOLineID:TIntegerField;
    qryMainLastPOID:TIntegerField;
    qryMainClientArea:TWideStringField;
    qryMainLatestCosttotalPercent: TFloatField;
    qryMainLastcosttotalPercent: TFloatField;
    qryMainAmountDiffLastcost: TFloatField;
    qryMainAmountDiffLatestcost: TFloatField;
    qryMainPercentDiffIncomeCost: TFloatField;
    qryMainTransactionType: TWideStringField;
    qryMainBackorders: TFloatField;
    qryMainProfitPercent: TFloatField;
    qryMainJobNumber: TIntegerField;
    qryMainQuotedEx: TFloatField;
    qryMainAmountDiffQuoteCost: TFloatField;
    qryMainPercentDiffQuoteCost: TFloatField;
    qryMainAccountName: TWideStringField;
    qryMainCreditEx: TFloatField;
    qryMainDebitEx: TFloatField;
    qryMainLineID: TIntegerField;
    qryMainDepartment: TWideStringField;
    qryMainDetails: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductId:TIntegerField;
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
    Script: TERPScript;
    qryMainInvDate: TDateTimeField;
    qryMainDueDate: TDateTimeField;
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
    procedure ApplyDtfilteronClick(Sender: TObject);
    procedure ScriptError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure ScriptBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
  private
    { Private declarations }
    tablename :String;
    FirstRefreshQuery: boolean;
    fdQuotedextotal :Double;
    procedure LoadData;
    procedure initGridhint;
    procedure explainCalc;
    (*function Productcost1(const value: Integer): Double;
    function Productlastcost(Const value:Integer; costtype:Integer):Double;*)
    procedure beforeshowJobProfitablity(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    procedure CreateTemporaryJobProfitTable;
    Procedure CalcnShowFooter;override;
    Procedure CalcFooter; Override;
    procedure SetGridColumns; Override;
    procedure ApplyDisplayLabelFrompreference;Override;
  public
  end;

implementation

{$R *.dfm}

uses
  Math, CommonDbLib, frmInvoice, frmBill,
  frmPurchaseOrders, frmRefund, frmCashSale, frmQuote, {frmTimeSheetGUI,}
  Commonlib,systemlib, Forms,  AppEnvironment, FastFuncs, ProductQtyLib, tcConst, LogLib,
  CommonFormLib, frmJobProfitablity;

(*function TJobProfitabilityGUI.Productcost1(Const value:Integer):Double;
begin
  with tempMyQuery do try
    SQL.Add('Select Cost1 from tblparts where partsId = ' +inttostr(Value));
    open;
    result:= fieldbyname('Cost1').AsFloat;
  finally
    ClosenFree;
  end;
end;

function TJobProfitabilityGUI.Productlastcost(Const value:Integer; costtype:Integer):Double;
begin
  with tempMyQuery do try
    SQL.Add('Select linecost , linecost*shipped totalcost  from tblpurchaselines where productId = ' +inttostr(Value) +' order by purchaselineId desc limit 1');
    open;
    if costtype =1 then
      result:= fieldbyname('linecost').AsFloat
    else
      result:= fieldbyname('totalcost').AsFloat;
  finally
    ClosenFree;
  end;
end;*)
procedure TJobProfitabilityGUI.beforeshowJobProfitablity(Sender :TObject);
begin
  if  not(Sender is TfmJobProfitablity) then exit;
  TfmJobProfitablity(Sender).jobProfitabilityReport := self;
end;

procedure TJobProfitabilityGUI.explainCalc;
begin
  OpenERPFormModal('TfmJobProfitablity' , 0 , beforeshowJobProfitablity);
(*var
  s:String;
begin
  s:= 'Option :' + grpFilters.Items[grpFilters.itemindex] +',' +inttostr(qrymaindetails.AsInteger)+ NL +
      'Product Name :' + qrymainproductname.AsString +NL+
      'Product ID :' + qrymainproductID.AsString +NL+
      'Income :' + floatTostr(QrymainincomeEx.AsFloat) +NL+
      'Cost :' + floatTostr(QrymaincostEx.AsFloat) + NL+
      'Quoted :' + floatTostr(QrymainQuotedEx.AsFloat) +NL+
      'Qty :' + floatTostr(QrymainQty.AsFloat) +NL+
      'Latest : ' +NL +
      '   cost:' + floatTostr(QrymainLatestcost.AsFloat) +'   -   ' + floatToStr(Productcost1(QrymainproductID.AsInteger))+NL+
      '   cost Total:' + floatTostr(QrymainLatestcosttotal.AsFloat) +NL+
      '   Diff :' + floatTostr(QrymainAmountDiffLatestcost.AsFloat) +NL+
      '   Perc :' + floatTostr(QrymainLatestCosttotalPercent.AsFloat) +NL+
      'Last  : ' +NL +
      '   cost:' + floatTostr(QrymainLastcost.AsFloat) +'   -   ' + floatToStr(Productlastcost(QrymainProductID.AsInteger,1))+'   -   ' + floatToStr(Productlastcost(QrymainProductID.AsInteger,2))+ NL+
      '   cost Total:' + floatTostr(QrymainLastcosttotal.AsFloat) +NL+
      '   Diff :' + floatTostr(QrymainAmountDiffLastcost.AsFloat) +NL+
      '   Perc :' + floatTostr(QrymainLastCosttotalPercent.AsFloat) +NL+
      'Income - cost:' + floatTostr(QrymainAmountDiffIncomeCost.AsFloat) +NL+
      'Income - Cost / Cost :' + floatTostr(QrymainPercentDiffIncomeCost.AsFloat) +NL+
      'Income -  Quote :' + floatTostr(QrymainAmountDiffQuoteCost.AsFloat) +NL+
      'Income -  Quote/quote :' + floatTostr(QrymainPercentDiffQuoteCost.AsFloat) +NL+
      '(Income - Cost) /income:' + floatTostr(QrymainProfitPercent.AsFloat);
      MessageDlgXP_Vista(s, mtInformation, [mbOK], 0);*)
end;
procedure TJobProfitabilityGUI.grdMainDblClick(Sender: TObject);
//Var
//  tmpComponent: TComponent;
begin
  if Sametext(ActiveFieldName , qryMainLastcosttotal.Fieldname) or
     Sametext(ActiveFieldName , qryMainAmountDiffLastcost.Fieldname)  then begin
     if QrymainLastPOID.AsInteger<>0 then begin
      OpenERPForm('TPurchaseGUI' ,QrymainLastPOID.AsInteger );
      exit;
     end;
  end;
  if Sametext(ActiveFieldName , qryMainLatestcosttotal.Fieldname) or
     Sametext(ActiveFieldName , qryMainAmountDiffLatestcost.Fieldname) or
     Sametext(ActiveFieldName , QrymainProductName.Fieldname)  then begin
     if QrymainProductID.AsInteger<>0 then begin
      OpenERPForm('TfrmParts' ,QrymainProductId.AsInteger );
      exit;
     end;
  end;
  if Sametext(ActiveFieldName ,     qryMainLatestCosttotalPercent.Fieldname) or
    Sametext(ActiveFieldName ,     qryMainLastcosttotalPercent.Fieldname) or
		Sametext(ActiveFieldName ,     qryMainPercentDiffIncomeCost.Fieldname) or
		Sametext(ActiveFieldName ,     qryMainProfitPercent.Fieldname) or
		Sametext(ActiveFieldName ,     qryMainPercentDiffQuoteCost.Fieldname) then begin
    if QrymainProductID.AsInteger<>0 then begin
      explainCalc;
      exit;
    end;
  end;
  SubsequentID:= '';
  if grpFilters.ItemIndex > 0 then
    SubsequentID := Chr(95) + qryMain.FieldByName('TransactionType').AsString;
  inherited;
end;

procedure TJobProfitabilityGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if chkIgnoreDates.Visible then
    if GuiPrefs.Node.Exists('dateOptions') then
      chkIgnoreDates.Checked := StrtoBoolean(GuiPrefs.Node['dateOptions.ignoreDates'].asString);
end;

procedure TJobProfitabilityGUI.RefreshQuery;
begin
    LoadData;
    inherited;
    case grpFilters.ItemIndex of
      0..1:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS';
        end;
      2:
        begin
          qryMain.IndexFieldNames := 'CompanyName ASC CIS; SaleID ASC; LineID ASC; Details ASC';
        end;
    end; // End of Case Directive.
//    qryMain.First;
    //UpdateTotals;
end;

procedure TJobProfitabilityGUI.CreateTemporaryJobProfitTable;
begin
  with Script do begin
    SQL.Clear;
    SQL.Add('Drop TABLE if exists `' + tablename + '` ;');
    SQL.Add('CREATE TABLE `' + tablename + '` (');
    SQL.Add('`ID` int(11) NOT NULL AUTO_INCREMENT,');
    SQL.Add('`Details` INT(11) DEFAULT "0",');
    SQL.Add('`extraDetails` INT(11) DEFAULT "0",');
    SQL.Add('`CompanyName` VARCHAR(255),');
    SQL.Add('`Department` VARCHAR(255),');
    SQL.Add('`JobName` VARCHAR(255),');
    SQL.Add('`JobNumber` INT(11),');
    SQL.Add('`SaleID` int(11) DEFAULT "0",');
    SQL.Add('`LineID` int(11) DEFAULT "0",');
    SQL.Add('`AccountName` VARCHAR(255),');
    SQL.Add('`CreditEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`DebitEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`TransactionType` VARCHAR(255),');
    SQL.Add('`ClientID` int(11) DEFAULT "0",');
    SQL.Add('`TransactionNo` VARCHAR(30),');
    SQL.Add('`CostEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`POCostEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`IncomeEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`QuotedEx` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`AmountDiffIncomeCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`PercentDiffIncomeCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`AmountDiffQuoteCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`PercentDiffQuoteCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`AmountDiffIncomeQuote` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`PercentDiffIncomeQuote` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`Backorders` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`ProfitPercent` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`ProductName` VARCHAR(60),');
    SQL.Add('`ProductId` int(11),');
    SQL.Add('`LastPOLineId` int(11),');
    SQL.Add('`LastPOID` int(11),');
    SQL.Add('`ClientArea` VARCHAR(50),');
    SQL.Add('`Qty` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`FirstColumn` VARCHAR(255),');
    SQL.Add('`SecondColumn` VARCHAR(255),');
    SQL.Add('`ThirdColumn` VARCHAR(255),');
    SQL.Add('`Area` VARCHAR(255),');
    SQL.Add('`LastCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`LatestCost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`LastCostTotal` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`LatestCostTotal` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`LastcosttotalPercent` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`LatestCosttotalPercent` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`AmountDiffLastcost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`AmountDiffLatestcost` DOUBLE NOT NULL DEFAULT "0.00",');
    SQL.Add('`Invdate` DATETIME NULL DEFAULT NULL ,');
    SQL.Add('`DueDate` DATETIME NULL DEFAULT NULL ,');
    SQL.Add('INDEX `CompanyNameIndex` (CompanyName),');
    SQL.Add('INDEX `SaleIDIndex` (SaleID),');
    SQL.Add('INDEX `LineIDIndex` (LineID),');
    SQL.Add('INDEX `TransactionTypeIndex` (`TransactionType`),');
    SQL.Add('PRIMARY KEY (`ID`)) TYPE=MyISAM;');
    Logtext(sql.Text);
    Execute;
  end;
end;


procedure TJobProfitabilityGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TJobProfitabilityGUI.FormCreate(Sender: TObject);
begin
  FirstRefreshQuery:= true;
  tablename := GetUserTemporaryTableName('jobprofitability');
  qryMain.SQL.Text := 'SELECT * FROM ' + tablename;
  inherited;

  AddCalccolumn(QrymainCreditEx.Fieldname, True);
  AddCalccolumn(QrymainDebitEx.Fieldname, True);
  AddCalccolumn(QrymainCostEx.Fieldname, True);
  AddCalccolumn(QrymainPOCostEx.Fieldname, True);
  AddCalccolumn(QrymainIncomeEx.Fieldname, True);
  AddCalccolumn(QrymainQuotedEx.Fieldname, True);
  AddCalccolumn(QrymainAmountDiffIncomeCost.Fieldname, True);
  AddCalccolumn(qryMainAmountDiffQuoteCost.Fieldname, True);

  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Connection := CommonDbLib.GetSharedMyDacConnection;


  qryCustomers.Open;
  qryClass.Open;
  CreateTemporaryJobProfitTable;
end;
procedure TJobProfitabilityGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TJobProfitabilityGUI.grpFiltersClick(Sender: TObject);
begin
  Refreshquery;
end;

procedure TJobProfitabilityGUI.LoadData;
  Function Adddatefilter(const Filterfieldname :STring):String;
  begin
    result:= '';
    if not chkIgnoreDates.Checked then
        result := result +' AND '+Filterfieldname +'  BETWEEN '+
            QuotedStr(formatDatetime('yyyy/mm/dd' , dtfrom.DateTime) ) +
            ' AND '+QuotedStr(formatDatetime('yyyy/mm/dd' , dtTo.DateTime) ) +'';
  end;
  Function AddSales:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,IncomeEx,'+
             'QuotedEx,AmountDiffIncomeCost,PercentDiffIncomeCost,'+
             'Backorders,LineID, invdate,dueDate)';
    REsult := Result +' /*SALES*/';
    REsult := Result +' SELECT';
    REsult := Result +' 1,0                                AS Details,';
    REsult := Result +Splitfield('C' , 'Company',1) +'  AS CompanyName,';
    REsult := Result +' C.JobName                        as JobName, ';
    REsult := Result +' C.JobNumber                      AS JobNumber, ';
    REsult := Result +' s.SaleID                         as SaleID,';
    REsult := Result +SaleType +                      ' as "TransactionType",';
    REsult := Result +' s.ClientID                       as ClientID, ';
    REsult := Result +' S.InvoiceDocNumber                 as TransactionNo,';
    REsult := Result +' If(s.IsInvoice="T" /*AND sl.IsQuote="F"*/,                 Sum(sl.LineCost * Shipped), '+
                'IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.LineCost * Shipped), /*Sum(0.00)*/0)) AS "CostEx",';
    REsult := Result +' IF(s.IsInvoice="T" /*AND sl.IsQuote="F"*/,                 Sum(sl.TotalLineAmount), '+
                'IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.TotalLineAmount), /*Sum(0.00)*/0)) as "IncomeEx",';
    REsult := Result +' IF(s.IsQuote="T" AND sl.IsQuote="T", Sum(sl.TotalLineAmount), /*Sum(0.00)*/0) as "QuotedEx",';
    REsult := Result +' IF((s.IsInvoice="T" OR s.IsQuote="T") /*AND sl.IsQuote="F"*/,  Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped), '+
                'IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",      Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped), /*Sum(0.00)*/0)) as "AmountDiffIncomeCost",';
    REsult := Result +' IF((s.IsInvoice="T" OR s.IsQuote="T") /*AND sl.IsQuote="F"*/,  ((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100,'+
                'IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",      ((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100, /*Sum(0.00)*/0)) as "PercentDiffIncomeCost",';
    REsult := Result +' Sum(IF(sl.Invoiced = "F", sl.QtySold, 0.00)) As "Backorders", ';
    REsult := Result +' sl.SaleLineID                    AS LineID,';
    REsult := Result +' S.Saledate as InvDate, S.DueDate as Duedate';
    REsult := Result +' FROM tblSales s '+
                'INNER JOIN tblSalesLines sl on (s.SaleID = sl.SaleID) '+
                'INNER JOIN tblclients C on C.ClientID = s.ClientID '+
                '/*Left join  (Select SaleID, globalref,QuoteGlobalRef from tblsales where isinvoice ="T")  Inv on s.globalref  = Inv.QuoteGlobalRef*/' +
                ' Left join tblsales inv on inv.isinvoice ="T" and s.globalref  = Inv.QuoteGlobalRef  ';
    REsult := Result +' WHERE (S.IsRefund="T" or S.IsInvoice="T" or S.IsCashSale="T" or (s.IsQuote="T" and (S.converted = "F" or isnull(Inv.saleID)) ) )  '+
                'AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")';
    result := Result+ AdddateFilter('s.SaleDate');
    if not chkAllClients.Checked then begin
      REsult := Result +' AND s.ClientID=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
    REsult := Result +' GROUP By s.ClientID, s.IsInvoice, s.IsQuote;';
  end;
  Function AddPOs:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,POCostEx,'+
             '/*AmountDiffIncomeCost,PercentDiffIncomeCost,*/Backorders,ProfitPercent,LineID,invdate,duedate)';
    REsult := Result +' /*PURCHASES*/';
    REsult := Result +' SELECT STRAIGHT_JOIN 2,0, ';
    REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
    REsult := Result +' JobName, C.JobNumber, P.PurchaseOrderID,';
    REsult := Result +' if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",';
    REsult := Result +' PL.CustomerJobID, PurchaseOrderNumber as InvoiceNo,';
    REsult := Result +' Sum(TotalLineAmount) as "CostEx",';
    REsult := Result +' /*Sum(TotalLineAmount)-0 as "AmountDiffIncomeCost",';
    REsult := Result +' (Sum(TotalLineAmount)-0)/1*100 as "PercentDiffIncomeCost",*/';
    REsult := Result +' Sum(PL.Backorder) AS "Backorders", 0.00 AS "ProfitPercent", PL.PurchaseLineID,';
    REsult := Result +' P.invoiceDate as InvDate, P.DueDate as Duedate';
    REsult := Result +' FROM tblpurchaseorders P';
    REsult := Result +' INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID';
    REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID';
    REsult := Result +' WHERE (IsPO="T" or IsBill="T" or IsCredit="T" or IsCheque="T") ';
    REsult := Result +' AND NOT ISNULL(Company) AND P.Deleted <> "T" And UseTimeCost <> "T"';

    if ApplyDtfilteron.ItemIndex = 0 then REsult := Result +'  ' +AdddateFilter('P.invoicedate') else REsult := Result +'  ' +AdddateFilter('P.OrderDate');
    if not chkAllClients.Checked then begin
      REsult := Result +' AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
    REsult := Result +' GROUP BY  CompanyName, jobname;';
  end;
  Function AddPays:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
             'AmountDiffIncomeCost,PercentDiffIncomeCost,LineID,Department)';
    REsult := Result +' /*PAYS*/';
    REsult := Result +' SELECT 3,0,';
    REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
    REsult := Result +' JobName, C.JobNumber, P.PayID, "Payroll" AS "TransactionType",';
    REsult := Result +' PL.ClientID, 0 AS InvoiceNo, Sum(LineTotal) AS "CostEx",';
    REsult := Result +' Sum(LineTotal) - /*Sum(0.00)*/0 AS "AmountDiffIncomeCost",';
    REsult := Result +' (Sum(LineTotal) - /*Sum(0.00)*/0) / /*Sum(0.00)*/1 * 100 AS "PercentDiffIncomeCost",';
    REsult := Result +' PL.PaysPayRateID,';
    REsult := Result +' PL.ClassName AS Department';
    REsult := Result +' FROM tblpays P';

    REsult := Result +' INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")';
    REsult := Result +' LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))';
    REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.ClientID';
    REsult := Result +' WHERE (Paid = "T") AND P.Deleted="F" ';
    REsult := Result +'  ' +AdddateFilter('P.DatePaid');

    if not chkAllClients.Checked then begin
      REsult := Result +' AND PL.ClientID=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
      //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
    REsult := Result +' GROUP BY C.ClientID;';
  end;
  Function AddTimesheets:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
             'AmountDiffIncomeCost,PercentDiffIncomeCost,LineID)';
    REsult := Result +' /*TIMESHEETS*/';
    REsult := Result +' SELECT 4,0,';
    REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
    REsult := Result +' JobName, C.JobNumber,P.ID, ';
    REsult := Result +'  /*P.EmployeeID,*/';
    REsult := Result +'  "Timesheet" AS "TransactionType",';
    REsult := Result +' P.JobID, 0 AS InvoiceNo, IF(P.JobID > 0, Sum(P.Total), /*Sum(0.00)*/0) AS "CostEx",';
    REsult := Result +' Sum(Total) - /*Sum(0.00)*/0 AS "AmountDiffIncomeCost",';
    REsult := Result +' (Sum(Total) - /*Sum(0.00)*/0) / /*Sum(0.00)*/1 * 100 AS "PercentDiffIncomeCost",';
    REsult := Result +' P.ID';
    REsult := Result +' FROM tbltimesheets P';
    REsult := Result +' INNER JOIN tblclients C on C.ClientID = P.JobID';
    //           REsult := Result +' LEFT JOIN tblPays PH on PH.EmployeeID = P.EmployeeID AND P.Active="F" AND PH.IsTimesheet = "T" AND PH.Paid = "F"';
    REsult := Result +' WHERE (P.Active = "T" AND P.JobID > 0)';
    REsult := Result +'  ' +AdddateFilter('P.ServiceDate');

    if not chkAllClients.Checked then begin
      REsult := Result +' AND P.JobID=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
    //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
    REsult := Result +' GROUP BY P.JobID;';
  end;
  Function Addrepairs:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
             'IncomeEx,QuotedEx,AmountDiffIncomeCost,PercentDiffIncomeCost,LineID)';
    REsult := Result +' /*REPAIRS*/';
    REsult := Result +' SELECT';
    REsult := Result +' 5,0 AS Details,' +Splitfield('C' , 'Company',1) +' ,C.JobName,';
    REsult := Result +' C.JobNumber,R.RepairID,"Repair" AS "TransactionType",';
    REsult := Result +' R.CusID,R.RepairID AS transactionno,sum(RP.Linecost*RP.Qty) AS "Cost(Ex)",';
    REsult := Result +' Sum(RP.PriceEx*RP.Qty) as "Income(Ex)",';
    REsult := Result +' sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty)  as "AmountDiffIncomeCost",';
    REsult := Result +'  ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100,';
    REsult := Result +'  ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100 as "PercentDiffIncomeCost",';
    REsult := Result +'RP.RepairPartsID AS LineID';
    REsult := Result +' FROM tblrepairs AS R';
    REsult := Result +' Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID';
    REsult := Result +' Inner Join tblclients C ON  R.CusID = C.ClientID';
    REsult := Result +' WHERE R.converted = "F"';
    REsult := Result +'  ' +AdddateFilter('RP.PartIssuedON');
    if not chkAllClients.Checked then begin
      REsult := Result +' AND R.CusId=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
    REsult := Result +' GROUP By R.CusId;';
  end;
  Function AddSalesextraDetails:String;
  begin
    REsult:= '';
    REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename +
            '` (extraDetails,Details, SaleID, LineID, TransactionNo, JobNumber, JobName, ClientID, `TransactionType`, CompanyName, Department, AccountName, `DebitEx`, `CreditEx`,invdate,duedate)';
    REsult := Result +' SELECT 6,2 AS Details, s.SaleID, sl.SaleLineId, s.SaleID, C.JobNumber,';
    REsult := Result +' JobName, s.ClientID,"Account Details" ,';
    REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
    REsult := Result +'  s.Class AS Department, sl.INCOMEACCNT , 0 , sl.totallineAmount,';
    REsult := Result +' S.Saledate as InvDate, S.DueDate as Duedate';
    REsult := Result +' FROM tblSales s';
    REsult := Result +' INNER JOIN tblSalesLines sl on s.SaleID = sl.SaleID';
    REsult := Result +' INNER JOIN tblparts tp on tp.PartsID = sl.ProductID';
    REsult := Result +' LEFT JOIN tblclients C on C.ClientID = s.ClientID';
    REsult := Result +' WHERE (((s.IsInvoice="T" /*AND sl.IsQuote="F"*/)  or (s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"))) ';
    REsult := Result +' AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")';
    REsult := Result +'  ' +AdddateFilter('s.SaleDate');
    if not chkAllClients.Checked then begin
      REsult := Result +' AND s.ClientID=' + qryCustomers.FieldByName('ClientID').AsString;
    end;
    REsult := Result +' ;';
  end;
  Function AddsalesDetails:String;
  begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
              'IncomeEx,QuotedEx,AmountDiffIncomeCost,PercentDiffIncomeCost,AmountDiffIncomeQuote,'+
              'PercentDiffIncomeQuote,Backorders,LineID,'+
              'Department,ProductName,ProductID,Qty, FirstColumn,SecondColumn,ThirdColumn,Area,invdate,duedate)';
          REsult := Result +' SELECT';
          REsult := Result +' 7,1 AS Details,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' JobName, C.JobNumber, s.SaleID,';
          REsult := Result +SaleType + ' as "TransactionType",';
          REsult := Result +' s.ClientID, S.InvoiceDocNumber AS TransactionNo,';

          REsult := Result +' IF(s.IsInvoice="T" /*AND sl.IsQuote="F"*/, sl.LineCost * Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.LineCost * Shipped, 0.00)) AS "CostEx",';
          REsult := Result +' IF(s.IsInvoice="T" /*AND sl.IsQuote="F"*/, sl.TotalLineAmount, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount, 0.00)) as "IncomeEx",';
          REsult := Result +' IF(s.IsQuote="T" AND sl.IsQuote="T", sl.TotalLineAmount, 0.00) as "QuotedEx",';

          REsult := Result +' IF((s.IsInvoice="T" OR s.IsQuote="T") /*AND sl.IsQuote="F"*/, sl.TotalLineAmount-sl.LineCost*Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount-sl.LineCost*Shipped, 0.00)) as "AmountDiffIncomeCost",';
          REsult := Result +' IF((s.IsInvoice="T" OR s.IsQuote="T") /*AND sl.IsQuote="F"*/, ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100,';
          REsult := Result +' IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100, 0.00)) as "PercentDiffIncomeCost",';
          REsult := Result +' IF(s.IsQuote="T" AND sl.IsQuote="T", sl.TotalLineAmount-sl.LineCost*Shipped, 0.00) AS "AmountDiffIncomeQuote",';
          REsult := Result +' IF(s.IsQuote="T" AND sl.IsQuote="T", ((sl.TotalLineAmount-sl.LineCost*Shipped) / (sl.LineCost*Shipped))*100, 0.00) AS "PercentDiffIncomeQuote",';
          REsult := Result +' IF(sl.Invoiced = "F" AND s.IsInvoice="T" /*AND sl.IsQuote="F"*/, sl.QtySold, 0) AS "Backorders",';
          REsult := Result +'sl.SaleLineID AS LineID,';
          REsult := Result +' s.Class AS Department,';
          REsult := Result +' sl.ProductName AS "ProductName",';
          REsult := Result +' sl.ProductId as ProductId,';
          REsult := Result +' sl.Shipped as Qty,';
          REsult := Result +Firstcolumn('tp') + ' AS FirstColumn, ';
          REsult := Result +Secondcolumn('tp')+ ' AS SecondColumn, ';
          REsult := Result +Thirdcolumn('tp') + ' AS ThirdColumn, ';
          REsult := Result +' sl.Area AS "Area",';
          REsult := Result +' S.Saledate as InvDate, S.DueDate as Duedate';
          REsult := Result +' FROM tblSales s';
          REsult := Result +' INNER JOIN tblSalesLines  sl  on s.SaleID     = sl.SaleID';
          REsult := Result +' INNER JOIN tblparts       tp  on tp.PartsID   = sl.ProductID';
          REsult := Result +' LEFT  JOIN tblclients     C   on C.ClientID   = s.ClientID'+
                            ' /*LEFT  JOIN (Select SaleID, globalref,QuoteGlobalRef from tblsales  where isinvoice ="T")  Inv on s.globalref  = Inv.QuoteGlobalRef*/' +
                            ' Left join tblsales inv on inv.isinvoice ="T" and s.globalref  = Inv.QuoteGlobalRef  ';
          REsult := Result +' WHERE (S.IsRefund="T" or S.IsInvoice="T" or S.IsCashSale="T" or (s.IsQuote="T" and (S.converted = "F" or isnull(Inv.saleID)))) AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")';
          REsult := Result +'  ' +AdddateFilter('s.SaleDate');

          if not chkAllClients.Checked then begin
            REsult := Result +' AND s.ClientID=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';
  end;
  //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
    Function AddPOextraDetails:String;
    begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename +
            '` (extraDetails,Details, SaleID, LineID, TransactionNo, JobNumber, JobName, ClientID, `TransactionType`, CompanyName, Department, AccountName, `DebitEx`, `CreditEx`,invdate,duedate)';
          REsult := Result +' SELECT';
          REsult := Result +' STRAIGHT_JOIN 8,2,P.PurchaseOrderID,PL.PurchaseLineID,P.PurchaseOrderID,';
          REsult := Result +'  C.JobNumber, JobName,  PL.CustomerJobID,"Account Details" ,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' PL.Class AS Department,';
          REsult := Result +' AccountName, if(P.ISCredit="T" , 0.00, totallineAmount) , if(P.ISCredit="T" , totallineAmount,0.00),';
          REsult := Result +' P.invoiceDate as InvDate, P.DueDate as Duedate';
          REsult := Result +' FROM tblpurchaseorders P';
          REsult := Result +' INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID';
          REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID';
          REsult := Result +' WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND NOT ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"';
          if ApplyDtfilteron.ItemIndex = 0 then REsult := Result +'  ' +AdddateFilter('P.invoicedate') else REsult := Result +'  ' +AdddateFilter('P.OrderDate');
          if not chkAllClients.Checked then begin
            REsult := Result +' AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';

  end;
  Function AddPODetails:string;
  begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,poCostEx,'+
              '/*AmountDiffIncomeCost,PercentDiffIncomeCost,*/Backorders,LineID,'+
              'Department,ProductName,ProductId,Qty,FirstColumn,SecondColumn,ThirdColumn,Area,invdate,duedate)';
          // NOTE: The following section is repeated, so any changes must be applied to the next section.
          REsult := Result +' SELECT';
          REsult := Result +' STRAIGHT_JOIN 9,1,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' JobName, C.JobNumber, P.PurchaseOrderID,';
          REsult := Result +' if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",';
          REsult := Result +' PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,';
          REsult := Result +' TotalLineAmount AS "CostEx",';
          REsult := Result +' /*TotalLineAmount AS "AmountDiffIncomeCost",';
          REsult := Result +' TotalLineAmount AS "PercentDiffIncomeCost",*/';
          REsult := Result +' PL.Backorder AS "Backorders", ';
          REsult := Result +'PL.PurchaseLineID,';
          REsult := Result +' PL.Class AS Department,';
          REsult := Result +' PL.ProductName AS "ProductName",';
          REsult := Result +' PL.ProductId as ProductId,';
          REsult := Result +' PL.Shipped as Qty,';
          REsult := Result +Firstcolumn('tp') + ' AS FirstColumn, ';
          REsult := Result +Secondcolumn('tp')+ ' AS SecondColumn, ';
          REsult := Result +Thirdcolumn('tp') + ' AS ThirdColumn, ';
          REsult := Result +' PL.AreaCode AS "Area",';
          REsult := Result +' P.invoiceDate as InvDate, P.DueDate as Duedate';
          REsult := Result +' FROM tblpurchaseorders P';
          REsult := Result +' INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID';
          REsult := Result +' INNER JOIN tblparts tp on tp.PartsID = PL.ProductID';
          REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID';
          REsult := Result +' WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND NOT ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"';
          if ApplyDtfilteron.ItemIndex = 0 then REsult := Result +'  ' +AdddateFilter('P.invoicedate') else REsult := Result +'  ' +AdddateFilter('P.OrderDate');
          if not chkAllClients.Checked then begin
            REsult := Result +' AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
            //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
          REsult := Result +' UNION ALL';
          // Repeat Section to cater for NULL values in tblpurchaselines.ProductID
          REsult := Result +' SELECT';
          REsult := Result +' STRAIGHT_JOIN 10,0,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' JobName, C.JobNumber, P.PurchaseOrderID,';
          REsult := Result +' if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",';
          REsult := Result +' PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,';
          REsult := Result +' TotalLineAmount AS "CostEx",';
          REsult := Result +' /*TotalLineAmount AS "AmountDiffIncomeCost",';
          REsult := Result +' TotalLineAmount AS "PercentDiffIncomeCost",*/';
          REsult := Result +' PL.Backorder AS "Backorders", ';
          REsult := Result +'PL.PurchaseLineID,';
          REsult := Result +' PL.Class AS Department,';
          REsult := Result +' PL.ProductName AS "ProductName",';
          REsult := Result +' PL.ProductId as ProductId,';
          REsult := Result +' PL.Shipped as Qty,';
          REsult := Result +' "" AS "FirstColumn",';
          REsult := Result +' "" AS "SecondColumn",';
          REsult := Result +' "" AS "ThirdColumn",';
          REsult := Result +' "" AS "Area",';
          REsult := Result +' P.invoiceDate as InvDate, P.DueDate as Duedate';
          REsult := Result +' FROM tblpurchaseorders P';
          REsult := Result +' INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID';
          REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID';
          REsult := Result +' WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"';
          if ApplyDtfilteron.ItemIndex = 0 then REsult := Result +'  ' +AdddateFilter('P.invoicedate') else REsult := Result +'  ' +AdddateFilter('P.OrderDate');

          if not chkAllClients.Checked then begin
            REsult := Result +' AND PL.CustomerJobID=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';
            //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
        // End Repeat Section
  end;
  Function AddPayDetails:String;
  begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
              'AmountDiffIncomeCost,PercentDiffIncomeCost,LineID)';
          REsult := Result +' SELECT 11,1,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' JobName, C.JobNumber, P.PayID, "Payroll" AS "TransactionType", PL.ClientID, P.PayID AS InvoiceNo,';
          REsult := Result +' LineTotal AS "CostEx",';
          REsult := Result +' LineTotal AS "AmountDiffIncomeCost",';
          REsult := Result +' LineTotal AS "PercentDiffIncomeCost",';
          REsult := Result +'PL.PaysPayRateID';
          REsult := Result +' FROM tblpays P';
          REsult := Result +' INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")';
          REsult := Result +' LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))';
          REsult := Result +' INNER JOIN tblclients C on C.ClientID = PL.ClientID';
          REsult := Result +' WHERE (Paid = "T") AND P.Deleted="F" ';
          REsult := Result +'  ' +AdddateFilter('P.DatePaid');
          if not chkAllClients.Checked then begin
            REsult := Result +' AND PL.ClientID=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';
            //if qrymain.filter <> '' then          REsult := Result +' AND ' + ReplaceStr(replaceStr(qrymain.filter, '[', '`') , ']', '`');
  end;
  function AddtimesheetDetails:String;
  begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
              'AmountDiffIncomeCost,PercentDiffIncomeCost,LineID,'+
              'Department)';
          REsult := Result +' SELECT DISTINCT 12,1,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' JobName, C.JobNumber, P.ID, "Timesheet" AS "TransactionType",';
          REsult := Result +' P.JobID, 0 AS InvoiceNo,';
          REsult := Result +' Total AS "CostEx",';
          REsult := Result +' Total AS "AmountDiffIncomeCost",';
          REsult := Result +' Total AS "PercentDiffIncomeCost",';
          REsult := Result +'P.ID, ';
          REsult := Result +' P.ClassName';

          REsult := Result +' FROM tbltimesheets P';
          REsult := Result +' INNER JOIN tblclients C on C.ClientID = P.JobID';
          REsult := Result +' LEFT JOIN tblPays PH on PH.EmployeeID = P.EmployeeID';
          REsult := Result +' WHERE (P.Active = "T" OR (P.Active = "F" AND PH.IsTimesheet = "T" AND PH.Paid = "F" AND PH.Deleted="F"))';
          REsult := Result +'  ' +AdddateFilter('PH.PayDate');

          if not chkAllClients.Checked then begin
            REsult := Result +' AND P.JobID = ' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';

  end;
  function AddrepairDetails:String;
  begin
          REsult:= '';
          REsult := Result +' INSERT HIGH_PRIORITY INTO `' + tablename + '`'+
           ' (extraDetails,Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,CostEx,'+
              'IncomeEx,QuotedEx,AmountDiffIncomeCost,PercentDiffIncomeCost,AmountDiffIncomeQuote,'+
              'PercentDiffIncomeQuote,ProfitPercent,LineID,'+
              'Department,ProductName,ProductId, Qty,FirstColumn,SecondColumn,ThirdColumn,Area)';
          REsult := Result +' SELECT';
          REsult := Result +' 13,1 AS Details,';
          REsult := Result +Splitfield('C' , 'Company',1) +' AS CompanyName,';
          REsult := Result +' C.JobName,';
          REsult := Result +' C.JobNumber,';
          REsult := Result +' R.RepairID,';
          REsult := Result +' "Repairs" as "TransactionType",';
          REsult := Result +' R.CusID,';
          REsult := Result +' R.RepairID AS TransactionNo,';
          REsult := Result +' RP.Linecost*RP.Qty  as "CostEx",';
          REsult := Result +' RP.PriceEx*RP.Qty as "IncomeEx",';
          REsult := Result +' R.QuotedAmount as "QuotedEx",';
          REsult := Result +' RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty as "AmountDiffIncomeCost",';
          REsult := Result +' ((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100, ';
          REsult := Result +' ((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty) as "AmountDiffIncomeCost",';
          REsult := Result +' ((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as "PercentDiffIncomeCost",';
          REsult := Result +' RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty AS "AmountDiffIncomeQuote",';
          REsult := Result +' ((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as  "Percent Diff (Income-Quote)",';
          REsult := Result +' RP.ClassName,';
          REsult := Result +' RP.PartName,';
          REsult := Result +' RP.PartsID,';
          REsult := Result +' RP.Qty , ';
          REsult := Result +Firstcolumn +' AS FirstColumn,';
          REsult := Result +SecondColumn +' AS SecondColumn,';
          REsult := Result +ThirdColumn +' AS ThirdColumn, ';
          REsult := Result +' P.Area';
          REsult := Result +' FROM';
          REsult := Result +' tblrepairs AS R';
          REsult := Result +' Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID';
          REsult := Result +' Inner Join tblparts AS P ON RP.PartsID = P.PARTSID';
          REsult := Result +' Inner Join tblclients AS C ON R.CusID = C.ClientID';
          REsult := Result +' Where R.converted = "F"';
          REsult := Result +'  ' +AdddateFilter('RP.PartIssuedOn');

          if not chkAllClients.Checked then begin
            REsult := Result +' AND R.CusId=' + qryCustomers.FieldByName('ClientID').AsString;
          end;
          REsult := Result +' ;';

  end;
begin

  qryMain.Close;
  qryMain.DisableControls;
  try
    try
      Screen.Cursor  := crHourGlass;
      with Script do begin
        SQL.Clear;
        SQL.Add('truncate  ' +tablename +';');
        case grpFilters.ItemIndex of
        0:begin
            SQL.Add(Addsales);
            SQL.Add(AddPOs);
            SQL.Add(AddPays);
            SQL.Add(Addtimesheets);
            SQL.Add(AddRepairs);
          end;
        1..2:begin
            SQL.Add(AddSalesDetails);
            SQL.Add(AddPODetails);
            SQL.Add(AddPayDetails);
            SQL.Add(AddtimesheetDetails);
            SQL.Add(AddrepairDetails);
          end;
        end;
        if grpFilters.ItemIndex = 2 then begin
          SQL.Add(AddSalesextraDetails);
          SQL.Add(AddPOExtraDetails);
        end;
        SQL.add('update  ' + Tablename +' set ProfitPercent        = 100  where ifnull(IncomeEx ,0)<>0 and ifnull(costex,0)=0;');
        SQL.add('update  ' + Tablename +' set ProfitPercent        = (IncomeEx - CostEx) / IncomeEx * 100.0  where ifnull(IncomeEx ,0)<>0 and ifnull(costex,0)<>0;');
        SQL.add('update  ' + Tablename +' set ProfitPercent        = 0-100                                   where ifnull(IncomeEx ,0)=0 and ifnull(costex,0) <> 0;');
        SQL.add('update  ' + Tablename +' set ProfitPercent        = 0                                       where ifnull(IncomeEx ,0)=0 and ifnull(costex,0) = 0;');
        SQL.add('update  ' + Tablename +' Set TransactionNo        = null                                    where details =0;');

        SQL.add('update  ' + Tablename +' set AmountDiffIncomeCost = 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details <> 0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details <> 0;');
        SQL.add('update  ' + Tablename +' set AmountDiffIncomeCost = IncomeEx- CostEx                        where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details = 0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= (IncomeEx- CostEx)/CostEx*100           where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details = 0 and ifnull(CostEx,0)<>0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 100                                     where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details = 0 and ifnull(CostEx,0)=0 and ifnull(IncomeEx,0)<>0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 and details = 0 and ifnull(CostEx,0)=0 and ifnull(IncomeEx,0)=0;');

        SQL.add('update  ' + Tablename +' set AmountDiffQuoteCost  = IncomeEx- QuotedEx                      where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 ;');
        SQL.add('update  ' + Tablename +' set PercentDiffQuoteCost = (IncomeEx- QuotedEx)/QuotedEx*100       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0 ;');
        SQL.add('update  ' + Tablename +' set PercentDiffQuoteCost = 100                                     where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)=0 and ifnull(IncomeEx,0)<>0;');
        SQL.add('update  ' + Tablename +' set PercentDiffQuoteCost = 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)=0 and ifnull(IncomeEx,0)=0;');
        SQL.add('update  ' + Tablename +' set TransactionType      = "Quote"                                 where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)<> 0  and details >0;');

        SQL.add('update  ' + Tablename +' set AmountDiffIncomeCost = IncomeEx- CostEx                        where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)= 0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= (IncomeEx- CostEx) /costEx*100          where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)= 0 and ifnull(costEx,0)<>0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 100                                     where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)= 0 and ifnull(costEx,0)=0 and ifnull(IncomeEx,0)<>0;');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)= 0 and ifnull(costEx,0)=0 and ifnull(IncomeEx,0)=0;');
        SQL.add('update  ' + Tablename +' set AmountDiffQuoteCost  = 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)=0;');
        SQL.add('update  ' + Tablename +' set PercentDiffQuoteCost = 0                                       where TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS") and ifnull(QuotedEx,0)=0;');
        SQL.add('update  ' + Tablename +' set CostEx               = 0                                       where TransactionType in ("Quote");');
        SQL.add('update  ' + Tablename +' set AmountDiffIncomeCost = 0                                       where not(TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS"));');
        SQL.add('update  ' + Tablename +' set PercentDiffIncomeCost= 0                                       where not(TransactionType in ("Invoice" , "Cash Sale" , "Refund" , "POS"));');
        SQL.add('Drop table if exists ' + Tablename +'1 ;');
        SQL.add('create table ' + Tablename +'1 Select POL.ProductId, max(POL.PurchaseLineID)  PurchaseLineID from tblpurchaselines POL inner join ' +
                        Tablename +' T on T.productId =POL.productId  where ifnull(shipped,0)<> 0 and ifnull(T.productId,0)<> 0 and t.details >0 group by ProductId;');
        SQL.add('Drop table if exists ' + Tablename +'2 ;');
        SQL.add('create table ' + Tablename +'2  Select POL.PurchaseOrderID, POL.purchaseLineId, POL.ProductID , POL.LineCost '+
                        ' from ' + Tablename +'1  t inner join tblpurchaselines POL on T.PurchaseLineID = POL.PurchaseLineID;');
        SQL.add('update  ' + Tablename +' T inner join   ' + Tablename +'2 T2 on T.productID = T2.productId set T.LastCost = T2.LineCost, T.LastPOLineId = T2.purchaseLineId,T.LastPOID = T2.PurchaseOrderID where t.details >0;');
        SQL.add('Drop table if exists ' + Tablename +'1 ;');
        SQL.add('Drop table if exists ' + Tablename +'2 ;');
        SQL.add('update  ' + Tablename +' T inner join   tblparts P on T.productID = P.partsID set T.LatestCost = P.COST1 where t.details >0;');
        SQL.add('update  ' + Tablename +' T set T.LastCostTotal = T.LastCost * T.Qty where t.details >0;');
        SQL.add('update  ' + Tablename +' T set T.LatestCostTotal = T.LatestCost * T.Qty where t.details >0;');

        SQL.add('update  ' + Tablename +' T inner join   tblClients C on C.clientId = T.clientId Set T.ClientArea = C.Area;');


        SQL.add('update  ' + Tablename +' set AmountDiffLastcost          = IncomeEx - LastCostTotal where details >0;');
        SQL.add('update  ' + Tablename +' set LastcosttotalPercent        = 100  where ifnull(IncomeEx ,0)<>0 and ifnull(LastCost,0)=0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LastcosttotalPercent        = (IncomeEx - LastCost) / IncomeEx * 100.0  where ifnull(IncomeEx ,0)<>0 and ifnull(LastCost,0)<>0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LastcosttotalPercent        = 0-100                                     where ifnull(IncomeEx ,0)=0 and ifnull(LastCost,0) <> 0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LastcosttotalPercent        = 0                                         where ifnull(IncomeEx ,0)=0 and ifnull(LastCost,0) = 0 AND details >0;');

        SQL.add('update  ' + Tablename +' set AmountDiffLatestcost        = (IncomeEx - LatestCostTotal) where details >0;');
        SQL.add('update  ' + Tablename +' set LatestCosttotalPercent      = 100  where ifnull(IncomeEx ,0)<>0 and ifnull(LatestCost,0)=0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LatestCosttotalPercent      = (IncomeEx - LatestCost) / IncomeEx * 100.0  where ifnull(IncomeEx ,0)<>0 and ifnull(LatestCost,0)<>0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LatestCosttotalPercent      = 0-100                                     where ifnull(IncomeEx ,0)=0 and ifnull(LatestCost,0) <> 0 AND details >0;');
        SQL.add('update  ' + Tablename +' set LatestCosttotalPercent      = 0                                         where ifnull(IncomeEx ,0)=0 and ifnull(LatestCost,0) = 0 AND details >0;');
        DoShowProgressbar(SQL.Count, WAITMSG);
        try
          Logtext(sql.Text);
          Execute;
        finally
          DoHideProgressbar;
        end;
      end;

     RefreshOrignalSQL;
    finally
      Self.PopulateFilterCombo;
      Screen.Cursor := crDefault;
    end;
  finally
    qryMain.EnableControls;
    qryMain.Open;
  end;
end;

procedure TJobProfitabilityGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field.FieldName = 'JobNumber' then begin
    if qryMain.FieldByName('JobNumber').AsInteger = 0 then begin
      //AFont.Color := TwwDBGrid(Sender).Color;
    end;
  end;
end;

procedure TJobProfitabilityGUI.chkAllClientsClick(Sender: TObject);
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
  //LoadData;
  RefreshQuery;
end;

procedure TJobProfitabilityGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl <> chkIgnoreDates then exit;
  ApplyDtfilteron.Enabled     := not(chkIgnoreDates.Checked);
  lblApplyDate.Enabled        := not(chkIgnoreDates.Checked);
  if chkIgnoreDates.Checked then ApplyDtfilteron.ItemIndex   := -1 else ApplyDtfilteron.ItemIndex   := 0;
  //LoadData;
  RefreshQuery;
end;

procedure TJobProfitabilityGUI.actSwapDepartmentUpdate(Sender: TObject);
begin
  inherited;
  if (grdMain.SelectedList.Count = 0) or (grpFilters.ItemIndex < 1) or (cboClass.Text = '') then begin
    btnSwapClass.Enabled := False;
  end else begin
    btnSwapClass.Enabled := True;
  end;
end;

procedure TJobProfitabilityGUI.actSwapDepartmentExecute(Sender: TObject);
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
    // Goto Selected Record.
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
        // Now Save and update.
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
        // Now Save and update.
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

          // Fetch Next Record.
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
          // Fetch Next Record.
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
        //frmRefund.cboClassCloseUp(TObject(frmRefund.cboClass), frmRefund.cboClassQry, frmRefund.tblMaster, True);
        frmRefund.tblMaster.Post;
        // Now Save and update.
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
        //frmCash.cboClassCloseUp(TObject(frmCash.cboClass), frmCash.cboClassQry, frmCash.tblMaster, True);
        frmCash.tblMaster.Post;
        // Now Save and update.
        frmCash.btnCompletedClick(Sender);
        Application.ProcessMessages;
      end;
    end;
    // Fetch next record.
    qryMain.Next;
  end;
  grdMain.UnselectAll;
  qryMain.First;
end;

procedure TJobProfitabilityGUI.FormShow(Sender: TObject);
begin
  // Set to Full Access
  if Self.Parent is TDNMPanel then begin
    Self.AccessLevel := 1;
  end;
  // when the form is called from the history tab of the main forms (eg: Customer)
  // the dates hsould be invisible.
(*  if Self.Parent is TDNMPanel then begin
    chkIgnoreDates.Visible := False;
    lblFrom.Visible   := False;
    dtFrom.Visible    := False;
    lblTo.Visible     := False;
    dtTo.Visible      := False;
  end;*)

  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'SaleId,ClientId,LineId');
  inherited;
  initGridhint;
end;

Procedure TJobProfitabilityGUI.initGridhint;
var
  s:String;
begin
  grdmain.hint:= 'Latest Cost :Current ''Cost 1'' in Product Card' +NL+
  'Last Cost   :Product''s Cost in its LAST Purchase Order' +NL;
  s:= Fieldgroupname(qryMainAmountDiffLatestcost.FieldName);

  if s<> '' then  grdmain.hint:=  grdmain.hint+ replacestr(s,'&' , '&&') +':' +NL +
                  '     $ Diff = '+Qrymainincomeex.displaylabel +' - ' + qryMainLatestcosttotal.displaylabel +NL+
                  '     % Diff = ('+Qrymainincomeex.displaylabel +' - ' + qryMainLatestcosttotal.displaylabel+')/'+Qrymainincomeex.displaylabel +' ' +NL
  else grdmain.hint:= grdmain.hint +
                  qryMainAmountDiffLatestcost.DisplayLabel+  ' = '+Qrymainincomeex.displaylabel +' - ' + qryMainLatestcosttotal.displaylabel +NL+
                  qryMainLatestCosttotalPercent.DisplayLabel+  ' = ('+Qrymainincomeex.displaylabel +' - ' + qryMainLatestcosttotal.displaylabel+')/'+Qrymainincomeex.displaylabel;

  s:= Fieldgroupname(qryMainAmountDiffLastcost.FieldName);
  if s<> '' then  grdmain.hint:=  grdmain.hint+ replacestr(s,'&' , '&&') +':' +NL +
                  '     $ Diff = '+Qrymainincomeex.displaylabel +' - ' + qryMainLastcosttotal.displaylabel +NL+
                  '     % Diff = ('+Qrymainincomeex.displaylabel +' - ' + qryMainLastcosttotal.displaylabel+')/'+Qrymainincomeex.displaylabel +' ' +NL
  else grdmain.hint:= grdmain.hint +
                  qryMainAmountDiffLastcost.DisplayLabel+  ' = '+Qrymainincomeex.displaylabel +' - ' + qryMainLastcosttotal.displaylabel +NL+
                  qryMainLastCosttotalPercent.DisplayLabel+  ' = ('+Qrymainincomeex.displaylabel +' - ' + qryMainLastcosttotal.displaylabel+')/'+Qrymainincomeex.displaylabel;

  grdmain.Showhint:= True;
end;
procedure TJobProfitabilityGUI.ScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  if devmode then logtext('/*'+formatDatetime('hh-nn-ss' , now) +'*/' +SQL+';');
  if devmode then
    DoStepProgressbar(SQL)
  else
  DoStepProgressbar
end;

procedure TJobProfitabilityGUI.ScriptError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  logtext(SQL);
end;

procedure TJobProfitabilityGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainProductId.FieldName);
  RemoveFieldfromGrid(qryMainLastPOLineID.FieldName);
  RemoveFieldfromGrid(qryMainLastPOID.FieldName);
  //RemoveFieldfromGrid(qryMainLatestcosttotal.FieldName);
  //RemoveFieldfromGrid(qryMainLastcosttotal.FieldName);
  RemoveFieldfromGrid(qryMainQty.FieldName);
  RemoveFieldfromGrid(qryMainLatestcost.FieldName);
  RemoveFieldfromGrid(qryMainLastcost.FieldName);
  RemoveFieldfromGrid(qryMainDetails.FieldName);
end;

procedure TJobProfitabilityGUI.WriteGuiPrefExtra;
begin
  inherited;
  (*if chkIgnoreDates.Visible then
      GuiPrefs.Node['dateOptions.ignoreDates'].asString:= BooleanToStr(chkIgnoreDates.Checked);*)
end;

procedure TJobProfitabilityGUI.cboClientsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  //LoadData;
  RefreshQuery;
end;


procedure TJobProfitabilityGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  //UpdateTotals;
end;

procedure TJobProfitabilityGUI.ApplyDisplayLabelFrompreference;
begin
  inherited;
  if qryMain.Findfield('Department')   <> nil then qryMain.FieldByName('Department').DisplayLabel  := AppEnv.DefaultClass.ClassHeading;
end;

procedure TJobProfitabilityGUI.ApplyDtfilteronClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;



procedure TJobProfitabilityGUI.CalcFooter;
begin
  inherited;
    if ((QrymainTransactionType.AsString = 'Invoice' ) or (QrymainTransactionType.AsString =  'Cash Sale' ) or (QrymainTransactionType.AsString =  'Refund' ) or (QrymainTransactionType.AsString =  'POS'))
        and (QrymainQuotedEx.AsFloat<> 0 ) then
      fdQuotedextotal:=fdQuotedextotal + QrymainIncomeEx.AsFloat - qrymainQuotedEx.AsFloat;
end;

procedure TJobProfitabilityGUI.CalcnShowFooter;
var
  fdincomeex, fdcostEx , (*dDiff, dPercDiff ,dProfit,*)fdQuotedEx :Double;
begin
  fdQuotedextotal:= 0;
  inherited;
  fdincomeEx:= FooterCalcfieldValue(QrymainincomeEx.FieldName);
  fdcostEx:= FooterCalcfieldValue(QrymainCostEx.FieldName);
  fdQuotedex:= FooterCalcfieldValue(qryMainQuotedEx.FieldName);
  (*dDiff     := fdincomeEx - fdcostEx;
  dPercDiff := DivZer((fdincomeEx - fdcostEx), fdcostEx) * 100;
  dProfit   := DivZer((fdincomeEx - fdcostEx), fdincomeEx) * 100;*)

  if fdIncomeEx <> 0 then grdMain.ColumnByName('ProfitPercent').FooterValue         := FloatToStrF((fdIncomeEx - fdCostEx) / fdIncomeEx * 100.0, ffNumber, 15, 2) + '%'
                     else grdMain.ColumnByName('ProfitPercent').FooterValue         := FloatToStrF((0- fdCostEx) , ffNumber, 15, 2) + '%';

  if fdCostEx <> 0   then grdMain.ColumnByName('PercentDiffIncomeCost').FooterValue := FloatToStrF((fdIncomeEx - fdCostEx) / fdCostEx * 100.0, ffNumber, 15, 2) + '%'
                     else grdMain.ColumnByName('PercentDiffIncomeCost').FooterValue := FloatToStrF(fdIncomeEx , ffNumber, 15, 2) + '%';

  if fdQuotedEx <> 0 then grdMain.ColumnByName('PercentDiffQuoteCost').FooterValue  := FloatToStrF((fdQuotedextotal / fdQuotedEx) * 100.0, ffNumber, 15, 2) + '%'
                     else grdMain.ColumnByName('PercentDiffQuoteCost').FooterValue  := FloatToStrF(fdQuotedextotal , ffNumber, 15, 2) + '%';
end;

initialization
  RegisterClassOnce(TJobProfitabilityGUI);
end.


