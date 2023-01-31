unit InventoryAssetVsStockStautsDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TInventoryAssetVsStockStautsDetailsGUI = class(TBaseListingGUI)
    qryMainCategory: TIntegerField;
    qryMainaccountname: TWideStringField;
    qryMainbalTransId: TIntegerField;
    qryMainProductname: TWideStringField;
    qryMaintransactionno: TIntegerField;
    qryMainTranstype: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainBalanceSheet: TFloatField;
    qryMainStockValue: TFloatField;
    qryMainsmsids: TWideStringField;
    qryMainCOGSAdjamount: TFloatField;
    qryMaindiff: TFloatField;
    qryMain_sms: TERPQuery;
    qryMain_smsTransDate: TDateTimeField;
    qryMain_smsTrans_Type: TWideStringField;
    qryMain_smsTransactionno: TIntegerField;
    qryMain_smsQty: TFloatField;
    qryMain_smsAvgCost: TFloatField;
    qryMain_smsLineCost: TFloatField;
    qryMain_smsPQATranslineID: TIntegerField;
    qryMain_smsTotalCost: TFloatField;
    qryMain_smsAvgTotalCost: TFloatField;
    qryMain_smsProductname: TWideMemoField;
    qryMain_smstransqty: TFloatField;
    qryMain_smstranscost: TFloatField;
    dsMain_sms: TDataSource;
    qryMain_smsTranstotalcost: TFloatField;
    Qrymain_bal: TERPQuery;
    Qrymain_balProductname: TWideStringField;
    Qrymain_balseqno: TFloatField;
    Qrymain_balDate: TDateField;
    Qrymain_baltype: TWideStringField;
    Qrymain_balTransactionno: TIntegerField;
    Qrymain_balClientName: TWideStringField;
    Qrymain_balAccountname: TWideStringField;
    Qrymain_balnotes: TWideStringField;
    Qrymain_balAmountEx: TFloatField;
    Qrymain_balAmountInc: TFloatField;
    dsmain_bal: TDataSource;
    spliter_bal: TSplitter;
    spliter_sms: TSplitter;
    pnl_sms: TDNMPanel;
    grdMain_sms: TwwDBGrid;
    wwIButton1: TwwIButton;
    pnl_bal: TDNMPanel;
    grdMain_bal: TwwDBGrid;
    wwIButton2: TwwIButton;
    Label2: TLabel;
    Label4: TLabel;
    btnExpressDetail: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure qryMain_smsCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    fsTableName: String;
    fsTranstype: String;
    fiTransID: Integer;
    procedure initform(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    Property TableName :String read fsTableName write fsTableName;
    Property Transtype :String read fsTranstype write fsTranstype;
    Property TransID   :Integer read fiTransID write fiTransID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, MAIN, CommonLib, LogLib,
  frmInventoryAssetVsStockStautsDetails, CommonFormLib;

{$R *.dfm}

procedure TInventoryAssetVsStockStautsDetailsGUI.btnExpressDetailClick(  Sender: TObject);
begin
  inherited;
  OpenERpForm('TfmInventoryAssetVsStockStautsDetails', 0 , nil, initform);
  Self.close;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.FormCreate(Sender: TObject);
begin
  tablename := '';
  Transtype := '';
  TransID := 0;
  inherited;
  SearchMode:= smFullList;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
  Except
    // kill the exception
  end;
  Widerform(Mainform.clientWidth - 50);
  pnl_sms.left := 0;
  spliter_sms.left := 0;
  pnl_bal.left := 0;
  spliter_bal.left := 0;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.initform(Sender: TObject);
begin
   if (Sender is TfmInventoryAssetVsStockStautsDetails) then begin
     TfmInventoryAssetVsStockStautsDetails(Sender).TableName := TableName;
     TfmInventoryAssetVsStockStautsDetails(Sender).Transtype := Transtype;
     TfmInventoryAssetVsStockStautsDetails(Sender).TransID   := TransID;
   end;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.qryMain_smsCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  qryMain_smsTranstotalcost.asFloat := qryMain_smstranscost.asFloat *qryMain_smstransqty.asFloat;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.pnl_smsWidth') then pnl_sms.Width := GuiPrefs.Node['Options.pnl_smsWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.pnl_balWidth') then pnl_bal.Width := GuiPrefs.Node['Options.pnl_balWidth'].asInteger;
end;

procedure TInventoryAssetVsStockStautsDetailsGUI.RefreshQuery;

Function TypeWhere(const fieldname :String):String;
begin
  REsult :='(' + fieldname + '=' +Quotedstr(transtype) + ' or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Stock Adjustment') +' and (' + fieldname +' ="StockAdjustEntry"))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Manufacturing'   ) +' and (' + fieldname +' ="TProcTreePart" or ' + fieldname +' ="TProcTreePartIN"   or ' + fieldname +' ="TProcProgressOut" or ' + fieldname +' ="TProcProgressIn" ))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Purchase Order'  ) +' and (' + fieldname +' ="PO"            or ' + fieldname +' ="Un-Invoiced PO"))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Cash Sale'       ) +' and (' + fieldname +' ="Cash Sale"     or ' + fieldname +' ="POS")) )';
end;
begin
  Closedb(qryMain_sms);
  qryMain_sms.sQL.clear;


  qryMain_sms.sQL.add('Select PQA.TransDate , PQA.Trans_Type , PQA.Transactionno , PQA.Qty, PQA.AvgCost, PQA.LineCost,  PQA.PQATranslineID ,  PQA.TotalCost, PQA.AvgTotalCost,');
  qryMain_sms.sQL.add('if( PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , ' +
                      ' Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)), PQA.productname) as Productname,');
  qryMain_sms.sQL.add('if (PQA.PQATRanstype in ("TPurchaseOrderLine")  , POL.Shipped , if(PQA.PQATRanstype in ("TStockMovementLines")  , SML.Qty ,   ' +
                      ' if(PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.Shipped ,    ' +
                      ' if(PQA.PQATRanstype in ("TSalesOrderInvoiceLines") , SOIL.Qty ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PTP.ManufactureQty ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcProgressIn") , PP.Qty,0)))))) as transqty ,');
  qryMain_sms.sQL.add('if (PQA.PQATRanstype in ("TPurchaseOrderLine")  , POL.Linecost ,  ' +
                      ' if(PQA.PQATRanstype in ("TStockMovementLines")  , SML.Cost ,   ' +
                      ' if(PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.linecost ,    ' +
                      ' if(PQA.PQATRanstype in ("TSalesOrderInvoiceLines") , null ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PT.cost ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcProgressIn") , PPT.cost,0)))))) as transcost');
  qryMain_sms.sQL.add('from  '+tablename + '_sms   PQA');
  qryMain_sms.sQL.add('Left  Join tblpurchaselines          AS POL  ON PQa.PQATranslineID = POL.PurchaseLineID        and PQA.PQATRanstype in ("TPurchaseOrderLine")');
  qryMain_sms.sQL.add('Left  Join tblpurchaseorders         AS PO   ON POL.PurchaseOrderID= PO.PurchaseOrderID');
  qryMain_sms.sQL.add('Left  Join tblstockmovementlines     AS SML  ON PQa.PQATranslineID = SML.StockmovementLinesID  and PQA.PQATRanstype in ("TStockMovementLines")');
  qryMain_sms.sQL.add('Left  Join tblsaleslines             AS SL   ON PQa.PQATranslineID = SL.SaleLineID              ' +
                      ' and PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")');
  qryMain_sms.sQL.add('Left  Join tblsales                  AS S    ON SL.SaleID          = S.SaleID');
  qryMain_sms.sQL.add('Left  join (tblsalesorderinvoicelines  AS SOIL inner   Join tblsalesorderinvoices     AS SOI  ON SOIL.SOInvoiceID   = SOI.SOInvoiceID )  ' +
                      ' on PQa.PQATranslineID = SOIL.SOInvoiceLineID  and PQA.PQATRanstype = "TSalesOrderInvoiceLines"');
  qryMain_sms.sQL.add('Left  Join (tblproctreepart            AS PTP inner join tblproctree PT on PTP.proctreeId = PT.proctreeID)  ON PTP.ProcTreePartId = PQa.PQATranslineID            ' +
                      ' and PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE")');
  qryMain_sms.sQL.add('Left  join (tblprocprogress            AS PP  inner join tblproctree PPT on PP.proctreeId = PPT.proctreeID )  on PP.ProcProgressID  = PQa.PQATranslineID            ' +
                      ' and PQA.PQATRanstype in ("TProcProgressIn")');
  qryMain_sms.sQL.add(' where ' + TypeWhere('PQA.PQATRanstype')+'  and PQA.Transactionno =' + inttostr(transID));
  qryMain_sms.sQL.add('Order by PT.sequencedown , Pqa.productname ');

    Closedb(Qrymain_bal);
  Qrymain_bal.sQL.clear;
Qrymain_bal.sQL.add('   select Productname, seqno , Date , type, Transactionno, ClientName, `Account name`, notes, `Amount (Ex)`, `Amount (Inc)` ' +
                          ' from   '+tablename + '_bal where ' + TypeWhere('type')+'  and Transactionno =' + inttostr(transID));
  Closedb(qrymain);
  qrymain.sQL.clear;
  qrymain.sQL.add('Select');
  qrymain.sQL.add('T.* ,');
  qrymain.sQL.add(' round((ifnull(Balancesheet,0)-ifnull(stockValue,0)) ,2) as diff ');
  qrymain.sQL.add('from '+tablename + ' T');
  qrymain.sQL.add(' where  ' + TypeWhere('transtype')+'  and Transactionno =' + inttostr(transID));
  inherited;
  Opendb(qryMain_sms);
  Opendb(Qrymain_bal);

  dsMain_sms.dataset := qryMain_sms;
  dsmain_bal.dataset := Qrymain_bal;

  grdMain_sms.datasource := dsMain_sms;
  grdmain_bal.datasource := dsmain_bal;

  end;

procedure TInventoryAssetVsStockStautsDetailsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.pnl_smsWidth'].asInteger := pnl_sms.Width;
  GuiPrefs.Node['Options.pnl_balWidth'].asInteger := pnl_bal.Width;
end;

initialization
  RegisterClassOnce(TInventoryAssetVsStockStautsDetailsGUI);

end.
