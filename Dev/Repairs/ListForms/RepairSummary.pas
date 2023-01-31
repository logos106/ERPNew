unit RepairSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BaseListExpress,
  wwclearbuttongroup, wwradiogroup;

type
  TRepairSummaryGUI = class(TBaseListExpressGUI)
    qryMainRepairID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainRepairDocNo: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainCompletionTime: TWideStringField;
    qryMainUseBillCust: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainarea: TWideStringField;
    qryMainContractValue: TFloatField;
    qryMainSuggestedSalesAmount: TFloatField;
    qryMainEstimatedCost: TFloatField;
    qryMainTotalCostEx: TFloatField;
    qryMainTotalCostInc: TFloatField;
    qryMaintotalamount: TFloatField;
    qryMaintotalamountinc: TFloatField;
    qryMainTotalInvAmt: TFloatField;
    qryMainTotalInvAmtinc: TFloatField;
    qryMaininvoices: TIntegerField;
    qryMainAppts: TIntegerField;
    qryMainBills: TIntegerField;
    qryMainSalesOrders: TIntegerField;
    qryMainSmartOrders: TIntegerField;
    qryMainPOBOs: TIntegerField;
    qryMainRAs: TIntegerField;
    qryMainAllGoodsreceived: TWideStringField;
    qryMainenteredby: TWideStringField;
    qryMainProfitD: TFloatField;
    qryMainProfitP: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsTableName:String;
  Protected
    Function ExpressDetailListName:String;Override;
    procedure beforeshowDetailsListName(Sender: TObject);Override;
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, MySQLConst, LogLib, tcConst, CommonLib, RepairProfitability;

{$R *.dfm}

procedure TRepairSummaryGUI.beforeshowDetailsListName(Sender: TObject);
begin
  inherited;
  if sender is TRepairProfitabilityGUI then begin
    TRepairProfitabilityGUI(sender).grpFilters.ItemIndex := TRepairProfitabilityGUI(sender).grpFilters.items.count-1;
  end;
end;

function TRepairSummaryGUI.ExpressDetailListName: String;
begin
  REsult :='TRepairProfitabilityGUI';
end;

procedure TRepairSummaryGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('RS');
  Qrymain.SQL.text := 'Select * from '+ fstablename;
  inherited;
    AddCalccolumn(QrymainContractValue.fieldname        , True);
    AddCalccolumn(QrymainSuggestedSalesAmount.fieldname , True);
    AddCalccolumn(QrymainEstimatedCost.fieldname        , True);
    AddCalccolumn(QrymainTotalCostEx.fieldname          , True);
    AddCalccolumn(QrymainTotalCostInc.fieldname         , True);
    AddCalccolumn(Qrymaintotalamount.fieldname          , True);
    AddCalccolumn(Qrymaintotalamountinc.fieldname       , True);
    AddCalccolumn(QrymainTotalInvAmt.fieldname          , True);
    AddCalccolumn(QrymainTotalInvAmtinc.fieldname       , True);
end;

procedure TRepairSummaryGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TRepairSummaryGUI.RefreshQuery;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.Add('drop table if exists ' + fstablename +';');
    SQL.Add('Create table ' + fstablename +
            ' Select ' +
            ' R.RepairID as RepairID, ' +
            ' ifnull(R.GlobalRef, "") as GlobalRef, ' +
            ' R.CustomerName as CustomerName, ' +
            ' R.RepairDocNo as RepairDocNo, ' +
            ' R.CreationDate as CreationDate, ' +
            ' R.Done as Done, ' +
            ' R.Phone as Phone, ' +
            ' R.Mobile as Mobile, ' +
            ' R.Converted as Converted, ' +
            ' R.Status as Status, ' +
            ' R.CustomerPONumber as CustomerPONumber, ' +
            ' R.JobDueDate as JobDueDate, ' +
            ' R.CompletionTime as CompletionTime, ' +
            ' R.UseBillCust as UseBillCust, ' +
            ' C.ClassName as ClassName, ' +
            ' E.EmployeeName as EmployeeName, ' +
            ' R.Enteredby as Enteredby, ' +
            ' R.area as area, ' +
            ' R.ContractValue as ContractValue, ' +
            ' R.SuggestedSalesAmount as SuggestedSalesAmount, ' +
            ' R.EstimatedCost as EstimatedCost ' +
            ' from tblrepairs R ' +
            ' left join tblclass C on C.classId = R.ClassID ' +
            ' left join tblemployees E on E.EmployeeID = R.EmployeeID ' +
            ' Where ((R.CreationDate Between ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterdateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateto))+' ) ' +
            '         or (isnull(R.CreationDate)) or (R.CreationDate="1899-12-30")) ' +
            '  and R.Cancelled = "F" ' + iif((edtSearch.Text = '') and (SearchMode <> smFullList)  ,'LIMIT 0', '') +';');

    SQL.Add('ALTER TABLE ' + fstablename + ' ADD PRIMARY KEY (`RepairID`);');
    SQL.Add('Alter table ' + fstablename + ' Add column RepairCostEx            DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column RepairPrice             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column Linetotalex             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column totalAdjusted           DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalServicecharge      DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalBillEx             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalBillInc            DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalCostEx             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalCostInc            DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column totalamount             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column totalamountinc          DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column totalInvoicedAmount     DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column totalInvoicedAmountinc  DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalInvAmt             DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column TotalInvAmtinc          DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column ProfitD                 DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column ProfitP                 DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column ProfitDinc              DOUBLE  DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column ProfitPinc              DOUBLE  DEFAULT 0;');

    SQL.Add('Alter table ' + fstablename + ' Add column Bills                   INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column SalesOrders             INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column Appts                   INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column invoices                INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column RAs                     INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column SmartOrders             INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column POBOs                   INT(11) DEFAULT 0;');
    SQL.Add('Alter table ' + fstablename + ' Add column AllGoodsreceived        VarChar(10) DEFAULT "";');
    if IsLimit0selection  then else begin
      {RepairCost }
      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 Select  RP.Repairid , sum(RP.Qty * RP.linecost) as RepairCostEx , sum(RP.Linetotalex) as Linetotalex , sum(PriceInc * qty + Markup - Discount) RepairPrice' +
                                                ' from  ' + fstablename +' R inner join tblrepairParts RP on R.RepairID = RP.RepairID '+
                                                ' group by RP.Repairid;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' t inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.RepairCostEx = T1.RepairCostEx ;');
      SQL.Add('update ' + fstablename +' t inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.RepairPrice = T1.RepairPrice ;');
      SQL.Add('update ' + fstablename +' t inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.Linetotalex = T1.Linetotalex ;');



      {timesheet adjustemnt and service charges}
      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 SELECT R.RepairID, sum(TS.TotalAdjusted) as TotalAdjusted , sum(TS.TotalServicecharge) as TotalServicecharge' +
                                                ' FROM  ' + fstablename +' R ' +
                                                ' inner join tbltimesheetentry TE  on TE.Type = "Repair" and TE.TypeID = R.RepairID ' +
                                                ' inner join tbltimesheets TS on TE.TimesheetEntryID =  TS.TimesheetEntryID ' +
                                                ' group by R.RepairID;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' t inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.totalAdjusted = T1.totalAdjusted ;');
      SQL.Add('update ' + fstablename +' t inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.TotalServicecharge = T1.TotalServicecharge ;');

      {bill amount}
      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 SELECT R.RepairID, Sum(PL.TotalLineAmount ) as TotalBillEx , Sum(PL.TotalLineAmountinc ) as TotalBillinc ' +
                                                ' FROM ' + fstablename +'  R ' +
                                                ' inner join tblpurchaselines PL on PL.repairID=  R.RepairID ' +
                                                ' inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ="T" ' +
                                                ' group by R.RepairID;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.TotalBillEx = T1.TotalBillEx ;');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.TotalBillInc = T1.TotalBillInc ;');
      SQL.Add('update ' + fstablename +' T Set TotalCostEx   = RepairCostEx  + TotalAdjusted + TotalBillEx;');
      SQL.Add('update ' + fstablename +' T Set TotalCostInc   = RepairCostEx  + TotalAdjusted + TotalBillInc;');
      SQL.Add('update ' + fstablename +' T Set totalamount = Linetotalex + TotalServicecharge;');
      SQL.Add('update ' + fstablename +' T Set totalamountinc = RepairPrice + TotalServicecharge;');



      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 Select  R.Repairid , Sum(S.TotalAmountInc) as TotalAmountInc , Sum(S.TotalAmount) as TotalAmount ' +
                                                ' from   ' + fstablename +' R inner join tblsales S on S.IsInvoice = "T" and ifnull(S.Repairglobalref,"") =  ifnull(R.GlobalRef,"") ' +
                                                ' group by R.Repairid;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.totalInvoicedAmountinc = T1.TotalAmountInc ;');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.totalInvoicedAmount = T1.TotalAmount ;');
      SQL.Add('update ' + fstablename +' T Set T.TotalInvAmt    = T.totalInvoicedAmount    /*+ T.TotalServicecharge*/;');
      SQL.Add('update ' + fstablename +' T Set T.TotalInvAmtinc = T.totalInvoicedAmountinc /*+ T.TotalServicecharge*/;');

      SQL.Add('update ' + fstablename +' T Set ProfitDinc = TotalInvAmtinc  - TotalCostInc;');
      SQL.Add('update ' + fstablename +' T Set ProfitPinc = ProfitDinc / TotalCostInc where ifnull(ProfitDinc,0)<> 0 and ifnull(TotalCostInc,0)<> 0;');

      SQL.Add('update ' + fstablename +' T Set ProfitD = TotalInvAmt  - TotalCostEx;');
      SQL.Add('update ' + fstablename +' T Set ProfitP =  if(ifnull(TotalCostEx,0)=0, 100,ProfitD /TotalCostEx*100)  ;');


      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(Distinct PO.PurchaseOrderID) as bills ' +
                                            ' from ' + fstablename +'  R ' +
                                            ' inner join `tblpurchaselines` PL on PL.repairID=  R.repairId ' +
                                            ' inner join tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.ISBill ="T" ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.Bills = T1.Bills ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(So.SaleId) as SalesOrders ' +
                                            ' from  ' + fstablename +' R ' +
                                            ' inner join tblsales SO on ifnull(SO.RepairGlobalRef, "") = ifnull(R.GlobalRef, "") and SO.ISSalesOrder = "T" ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.SalesOrders = T1.SalesOrders ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(A.AppointID) as Appts ' +
                                            ' from  ' + fstablename +' R ' +
                                            ' inner join tblappointments A on ifnull(A.RepairID ,0) = R.RepairID ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.Appts = T1.Appts ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(Inv.SaleId) as invoices ' +
                                            ' from  ' + fstablename +' R ' +
                                            ' inner join tblsales inv on ifnull(Inv.RepairGlobalRef, "") = ifnull(R.GlobalRef, "") and Inv.IsInvoice = "T" ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.invoices = T1.invoices ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(Distinct RA.PurchaseOrderID) as Ras ' +
                                            ' from ' + fstablename +'  R ' +
                                            ' inner join `tblpurchaselines` RAL on RAL.repairID=  R.repairId ' +
                                            ' inner join tblpurchaseorders RA on RA.PurchaseOrderID = RAL.PurchaseOrderID and RA.isRA ="T" ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.Ras = T1.Ras ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 select ' +
                                            ' R.repairId, count(Distinct SO.SmartOrderID) as SmartOrders ' +
                                            ' from  ' + fstablename +'  R ' +
                                            ' inner join `tblsmartorderlines` SOL on SOL.repairID=  R.repairId ' +
                                            ' inner join tblsmartorder  SO on SO.SmartOrderID = SOL.SmartOrderID ' +
                                            ' group by R.repairId;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.SmartOrders = T1.SmartOrders ;');

      SQL.Add('drop table if exists ' + fstablename +'1;');
      SQL.Add('Create table ' + fstablename +'1 SELECT ' +
                                            ' R.repairId, ' +
                                            ' sum(ifnull(PL.UnitofMeasureShipped,0)) as Shipped, ' +
                                            ' sum(if(ifnull(P.BOID,"")="" , PL.BackOrder , 0)) as BOQty, ' +
                                            ' count(distinct if(ifnull(P.BOID,"")="" and ifnull(PL.BackOrder,0)<> 0, P.purchaseorderId , null) ) as POBOs,   '+
                                            ' if(ifnull(P.PurchaseOrderID,0)=0 , SL.Qty,0) as toOrder ' +
                                            ' FROM   ' + fstablename +'  R ' +
                                            ' inner join tblsmartorderlines AS SL  on SL.RepairId = R.RepairId ' +
                                            ' Left Join tblpurchaselines AS PL ON SL.SmartOrderID = PL.SmartOrderID AND SL.SmartOrderLinesId = PL.SmartOrderLineID ' +
                                            ' left join tblpurchaseorders as P on P.PurchaseOrderID = PL.PurchaseOrderID ' +
                                            ' Group by R.repairId ' +
                                            ' Order by SL.PARTSNAME;');
      SQL.Add('ALTER TABLE ' + fstablename + '1 ADD PRIMARY KEY (`RepairID`);');
      SQL.Add('update ' + fstablename +' T left join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.AllGoodsreceived = if(isnull(T1.repairID) , "N/A" , if(ifnull(T1.BOQty,0)=0 , "Yes" , "No")) ;');
      SQL.Add('update ' + fstablename +' T inner join ' + fstablename +'1 T1 on T.RepairID = T1.RepairID Set T.POBOs = T1.POBOs ;');
    end;
    clog(SQL.Text);
    DoshowProgressbar(SQL.Count , WAITMSG );
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  inherited;
end;
procedure TRepairSummaryGUI.REfreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TRepairSummaryGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TRepairSummaryGUI);

end.

