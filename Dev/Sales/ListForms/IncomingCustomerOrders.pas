unit IncomingCustomerOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TIncomingCustomerOrdersGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderId: TIntegerField;
    qryMainSmartorderId: TIntegerField;
    qryMainPOUOM: TWideStringField;
    qryMainPOsold: TFloatField;
    qryMainPOShipped: TFloatField;
    qryMainPOBO: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainSalesUOM: TWideStringField;
    qryMainSaelsSold: TFloatField;
    qryMainSalesShipped: TFloatField;
    qryMainSalesBO: TFloatField;
    qryMainSaledate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMaincustomerPrintName: TWideStringField;
    qryMainSalesrep: TWideStringField;
    qryMainSaleType: TWideStringField;
    qryMainCustomeremail: TWideStringField;
    qryMainCustomerphone: TWideStringField;
    qryMainCustomerMobile: TWideStringField;
    qryMainsaleLinePrice: TFloatField;
    qryMainSaleLinePriceInc: TFloatField;
    qryMainSaleId: TIntegerField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainsaleTotalLineAmount: TFloatField;
    qryMainSaleTotalLineAmountinc: TFloatField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainSaleMemoLine: TWideMemoField;
    qryMainSmartOrderDesc: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainReceivedDate: TDateField;
    qryMainLastOrderReceivedDate: TDateField;
    qryMainSupplierName: TWideStringField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsTablename : String;
    procedure Populatedata;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonFormLib, tcConst;

{$R *.dfm}

procedure TIncomingCustomerOrdersGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('ICO');
  Qrymain.sql.clear;

  Qrymain.sql.add('Select');
  Qrymain.sql.add('T.PurchaseOrderId	 as PurchaseOrderId	,');
  Qrymain.sql.add('T.SmartorderId	 as SmartorderId	,');
  Qrymain.sql.add('T.POUOM	 as POUOM	,');
  Qrymain.sql.add('T.POsold	as POsold	,');
  Qrymain.sql.add('T.POShipped	 as POShipped	,');
  Qrymain.sql.add('T.SupplierProductCode as SupplierProductCode,');
  Qrymain.sql.add('T.SupplierProductName as SupplierProductName,');
  Qrymain.sql.add('T.SupplierName as SupplierName,');
  Qrymain.sql.add('date(T.ReceivedDate) as ReceivedDate, ');
  Qrymain.sql.add('date(T.LastOrderReceivedDate) as LastOrderReceivedDate, ');
  Qrymain.sql.add('T.POBO	as POBO	,');
  Qrymain.sql.add('POL.ProductName as ProductName,');
  Qrymain.sql.add('POL.ProductPrintName as ProductPrintName,');
  Qrymain.sql.add('POL.TotalLineAmount as TotalLineAmount,');
  Qrymain.sql.add('POL.TotalLineAmountInc as TotalLineAmountInc,');
  Qrymain.sql.add('T.SalesUOM	as SalesUOM	,');
  Qrymain.sql.add('T.SaelsSold	as SaelsSold	,');
  Qrymain.sql.add('T.SalesShipped	as SalesShipped	,');
  Qrymain.sql.add('T.SalesBO	as SalesBO	,');
  Qrymain.sql.add('S.SaleDate as Saledate,');
  Qrymain.sql.add('S.SaleId as SaleId,');
  Qrymain.sql.add('S.CustomerName as CustomerName,');
  Qrymain.sql.add('C.PrintName as customerPrintName,');
  Qrymain.sql.add('S.EmployeeName as Salesrep,');
  Qrymain.sql.add('if (S.IsInvoice = "T", "Invoice",if(S.IsSalesOrder = "T", "Sales Order","Other")) as SaleType,');
  Qrymain.sql.add('P.GeneralNotes as GeneralNotes,');
  Qrymain.sql.add('PO.OrderDate as OrderDate,');
  Qrymain.sql.add('C.Email as Customeremail,');
  Qrymain.sql.add('C.Phone as Customerphone,');
  Qrymain.sql.add('C.Mobile as CustomerMobile,');
  Qrymain.sql.add('T.SaelsSold*SL.LinePrice as saleTotalLineAmount,');
  Qrymain.sql.add('T.SaelsSold*SL.LinePriceInc as SaleTotalLineAmountinc ,');
  Qrymain.sql.add('SL.MemoLine as SaleMemoLine,');
  Qrymain.sql.add('SO.SmartOrderDesc as SmartOrderDesc,');
  Qrymain.sql.add('SL.LinePrice as saleLinePrice,');
  Qrymain.sql.add('SL.LinePriceInc as SaleLinePriceInc');
  Qrymain.sql.add('from ' + fstablename +'  T');
  Qrymain.sql.add('inner join tblpurchaseorders PO on T.PurchaseOrderId = PO.PurchaseOrderID');
  Qrymain.sql.add('inner join tblpurchaselines POL on POL.PurchaseLineID = T.PurchaselineID');
  Qrymain.sql.add('inner join tblsales S on S.saleID = T.sale_ID');
  Qrymain.sql.add('inner join tblclients C on S.ClientID = C.ClientID');
  Qrymain.sql.add('inner join tblsaleslines SL on SL.salelineId = T.saleLine_ID');
  Qrymain.sql.add('inner join tblparts P on P.partsId = POL.ProductID');
  Qrymain.sql.add('inner join tblsmartorder SO on T.SmartorderId = SO.SmartOrderID');
  Qrymain.sql.add('where T.SaelsSold <> 0'); // T.PurchaseOrderId = T.OriginalPOID
  // Qrymain.sql.add('where T.SaelsSold > 0 AND T.SaelsSold > T.SalesShipped ');
  Qrymain.sql.add('and ((ifnull(SalesShipped,0) =0 and S.IsInvoice ="T") or (S.IsSalesOrder ="T" and S.Converted ="F")) ');
  Qrymain.sql.add('and S.SaleDate between :DateFrom and :DateTo');
  Qrymain.sql.add('and ((:filterindex = 0 and ifnull(PO.BaseNo,"") = "") or (:filterindex = 1 and ifnull(PO.BOID  ,"") = "") or (:filterindex = 2))');
  Qrymain.sql.add('Order by S.saleId desc , sl.salelineId ');
  inherited;
  ShowcontrolHint(Self, 'This Report Shows list of Purchase Orders Created for'+NL+
                          '  -> Back Ordered Sales Oder,'+NL+
                          '  -> Back Ordered Invoice and'+NL+
                          '  -> Un-Converted Sales Orders');
end;

procedure TIncomingCustomerOrdersGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TIncomingCustomerOrdersGUI.FormShow(Sender: TObject);
begin
  //Populatedata;
  inherited;
end;

procedure TIncomingCustomerOrdersGUI.grdMainDblClick(Sender: TObject);
begin
  if grdMain.GetActiveField = nil then
    exit;
  if (Sametext(ActiveFieldname, qryMainGeneralNotes.Fieldname)) or
      (Sametext(ActiveFieldname, qryMainSaleMemoLine.Fieldname)) then begin
  end
  else if (Sametext(ActiveFieldname, qryMainSmartOrderDesc.Fieldname)) Or
    (Sametext(ActiveFieldname, qryMainSmartorderId.Fieldname))  then begin
   OpenERPForm('TSmartOrderGUI',qryMainSmartOrderID.AsInteger);
  end
  else if (Sametext(ActiveFieldname, qryMainCustomerName.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleType.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainCustomerPrintName.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleID.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleDate.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainOrderDate.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleLinePriceInc.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleLinePrice.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSalesrep.Fieldname)) or
    (Sametext(ActiveFieldname, qryMainSaleMemoLine.Fieldname)) then begin
   { open sale .. }
   if SameText(qryMainSaleType.AsString,'Invoice') then
      OpenERPForm('TInvoiceGUI',qryMainSaleID.AsInteger)
   else if SameText(qryMainSaleType.AsString,'Sales Order') then
      OpenERPForm('TSalesOrderGUI',qryMainSaleID.AsInteger)
   else
     inherited;
 end
 else begin
   { open purchase order .. }
   OpenERPForm('TPurchaseGUI',qryMainPurchaseOrderID.AsInteger);
 end;

end;

procedure TIncomingCustomerOrdersGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
(*  if IsFormshown then
      RefreshQuery;*)
  if not IsFormshown then exit;
  qrymain.Disablecontrols;
  try
    Closedb(qrymain);
    opendb(Qrymain);
  finally
    qrymain.Enablecontrols;
  end;
end;

procedure TIncomingCustomerOrdersGUI.Populatedata;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('/*1*/Drop table if exists ' + fstablename +' ; ');
    SQL.add('/*2*/CREATE TABLE ' + fstablename +'  ( 	ID INT(11) NOT NULL AUTO_INCREMENT, '+
										' PurchaseOrderId 		  INT(11) null default 0, '+
                    ' OriginalPOID 		      INT(11) null default 0, '+
										' PurchaselineID 			  INT(11) null default 0, '+
										' SmartorderId 				  INT(11) null default 0, '+
										' SaleLineID 						INT(11) null default 0	, '+
										' SalesOrderId 					INT(11) null default 0	, '+
										' SalesOrderLineId 			INT(11) null default 0	, '+
										' SalesOrderconverted 	Enum("T","F") default "F", '+
										' BOSalesOrderId 				INT(11) null default 0	, '+
										' BOSalesOrderLineId 		INT(11) null default 0	, '+
										' InvoiceID 						INT(11) null default 0	, '+
										' InvoiceLineId 				INT(11) null default 0	, '+
										' BOInvoiceID 					INT(11) null default 0	, '+
										' BOInvoiceLineId 			INT(11) null default 0	, '+
										' ProductId       			INT(11) null default 0	, '+
										' Seqno           			INT(11) null default 0	, '+
										' POUOM 								VARCHAR(255) NULL DEFAULT "" , '+
										' POsold 								DOUBLE NULL DEFAULT 0, '+
										' POShipped 						DOUBLE NULL DEFAULT 0, '+
                    ' SupplierProductCode   varchar(100) null, '+
                    ' SupplierProductName   varchar(100) null, '+
                    ' SupplierName          varchar(255) Null DEfault "",' +
                    ' ReceivedDate          DateTime NULL , ' +
                    ' LastOrderReceivedDate DateTime NULL , ' +
										' POBO 									DOUBLE NULL DEFAULT 0, '+
										' Sale_Id								INT(11) null default 0	, '+
										' SaleLine_ID						INT(11) null default 0	, '+
										' SalesUOM 							VARCHAR(255) , '+
										' SaelsSold 						DOUBLE NULL DEFAULT 0, '+
										' SalesShipped 					DOUBLE NULL DEFAULT 0, '+
										' SalesBO 							DOUBLE NULL DEFAULT 0, '+
										' PRIMARY KEY (ID) ) ENGINE=Myisam ;   ');
    SQL.add('/*2.1*/alter table ' +fstablename +'  add index SalesOrderId (SalesOrderId);');
    SQL.add('/*2.2*/alter table ' +fstablename +'  add index BOSalesOrderId (BOSalesOrderId);');

    SQL.add('/*3*/insert ignore into ' + fstablename +'  '+
            ' (PurchaseOrderId , PurchaselineID , SmartorderId , SaleLineID , SupplierName) '+
            ' Select  PO.PurchaseOrderID, POL.PurchaseLineID , PO.CreatedFromSO , POL.SaleLineID , PO.SupplierName '+
            ' from tblpurchaseorders PO '+
            ' inner join tblpurchaselines POL on PO.PurchaseOrderID = POL.PurchaseOrderID '+
            ' where ifnull(POL.SaleLineID,0)<> 0 ; ');

    SQL.add('/*3.1*/update ' + fstablename +'  T  '+
            ' inner join tblpurchaseorders PO on T.PurchaseOrderId = PO.PurchaseOrderId  '+
            ' inner join tblpurchaseorders ORGPO on PO.OriginalNo = ORGPO.Globalref  '+
            ' Set T.OriginalPOID = ORGPO.PurchaseOrderId , T.SmartorderId = ORGPO.CreatedFromSO;');

    SQL.add('/*4*/update ' + fstablename +'  T '+
            ' inner join tblsaleslines SL on T.saleLineId = SL.saleLineId '+
            ' inner join tblsales S on s.saleId = SL.saleID and S.IsSalesOrder="T" '+
            ' Set T.SalesOrderId = S.saleId, T.SalesOrderLineId = SL.saleLineId ,T.productId = SL.ProductID, T.seqno = SL.SeqNo,  T.SalesOrderconverted =S.Converted; ');
    SQL.add('/*5*/update ' + fstablename +'  T '+
            ' inner join tblsaleslines SL on T.saleLineId = SL.saleLineId '+
            ' inner join tblsales S on s.saleId = SL.saleID and S.IsInvoice ="T"  '+
            ' Set T.InvoiceID= S.saleId, T.InvoiceLineId = SL.saleLineId ,T.productId = SL.ProductID, T.seqno = SL.SeqNo; ');

    SQL.add('/*6*/update ' + fstablename +'  T '+
            ' inner join tblsales S on S.saleId = T.SalesOrderId  '+
            ' inner join tblsales BO on S.OriginalNo = BO.OriginalNo and ifnull(BO.BOID , "")= ""  '+
            ' Set BOSalesOrderId = BO.SaleID where T.SalesOrderconverted ="T" and ifnull(T.SalesOrderId ,0)<> 0 ; ');
    SQL.add('/*7*/update ' + fstablename +'  T '+
            ' inner join tblsales S on T.BOSalesOrderId = S.saleId '+
            ' inner join tblsaleslines Sl on SL.SaleId = s.saleId and SL.productId = T.productId and SL.seqno = T.seqno '+
            ' Set BOSalesOrderLineId = SL.saleLineId; ');
    SQL.add('/*8*/update ' + fstablename +'  T '+
            ' Set T.BOSalesOrderId = SalesOrderId , T.BOSalesOrderLineId = T.SalesOrderLineId '+
            ' Where ifnull(BOSalesOrderId,0)=0 and ifnull(BOSalesOrderLineId,0)=0; ');

    SQL.add('/*9*/Update ' + fstablename +'  T '+
            ' inner join tblsales SO on T.SalesOrderId   = SO.saleId '+
            ' inner join tblsales Inv on SO.globalref  = Inv.SalesOrderGlobalRef '+
            ' Set T.InvoiceID = Inv.saleId where ifnull(T.InvoiceID,0)=0; ');
    SQL.add('/*10*/Update ' + fstablename +'  T '+
            ' inner join tblsales SO on T.BOSalesOrderId = SO.saleId '+
            ' inner join tblsales Inv on SO.globalref  = Inv.SalesOrderGlobalRef '+
            ' Set T.InvoiceID = Inv.saleId where ifnull(T.InvoiceID,0)=0; ');

    SQL.add('/*11*/update ' + fstablename +'  T '+
            ' inner join tblsales S on S.saleId = T.InvoiceId  '+
            ' inner join tblsales BO on S.OriginalNo = BO.OriginalNo and ifnull(BO.BOID , "")= ""  '+
            ' Set BOInvoiceId = BO.SaleID where ifnull(T.InvoiceId ,0)<> 0 ; ');
    SQL.add('/*12*/update ' + fstablename +'  T '+
            ' inner join tblsales S on T.BOInvoiceId = S.saleId '+
            ' inner join tblsaleslines Sl on SL.SaleId = s.saleId and SL.productId = T.productId and SL.seqno = T.seqno '+
            ' Set BOInvoiceLineId = SL.saleLineId; ');
    SQL.add('/*13*/update ' + fstablename +'  T '+
            ' Set T.BOInvoiceId = InvoiceId , T.BOInvoiceLineId = T.InvoiceLineId '+
            ' Where ifnull(BOInvoiceId,0)=0 and ifnull(BOInvoiceLineId,0)=0; ');

    SQL.add('/*14*/update ' + fstablename +'  T  '+
            ' inner join tblpurchaselines POL on T.PurchaselineID     = POL.PurchaseLineID  '+
            ' Set POUOM    = concat(POL.UnitofMeasurePOLines  , "(" , POL.UnitofMeasureMultiplier, ")") ,  '+
            ' T.posold    = POL.UnitofMeasureQtySold, T.POShipped    = POL.UnitofMeasureShipped,  '+
            'T.ReceivedDate = POL.ReceivedDate , '+
            'T.SupplierProductCode = POL.SupplierProductCode ,'+
            'T.SupplierProductName = POL.SupplierProductName ,'+
            ' T.POBO    = POL.UnitofMeasureBackorder; ');
    SQL.add('/*15*/update ' + fstablename +'  T  '+
            ' inner join tblsaleslines    SL  on T.boinvoicelineId    = SL.SaleLineID       '+
            ' Set  T.Sale_Id = SL.saleId, T.saleLine_Id = SL.SaleLineId ,   '+
            ' SalesUOM = concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") ,  '+
            ' T.SaelsSold = SL.UnitofMeasureQtySold ,  '+
            ' T.SalesShipped = SL.UnitofMeasureShipped ,  '+
            ' T.SalesBO = SL.UnitofMeasureBackorder; ');
    SQL.add('/*16*/update ' + fstablename +'  T  '+
            ' inner join tblsaleslines    SL  on T.invoicelineId      = SL.SaleLineID       '+
            ' Set  T.Sale_Id = SL.saleId, T.saleLine_Id = SL.SaleLineId ,   '+
            ' SalesUOM = concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") ,  '+
            ' T.SaelsSold = SL.UnitofMeasureQtySold ,  '+
            ' T.SalesShipped = SL.UnitofMeasureShipped ,  '+
            ' T.SalesBO = SL.UnitofMeasureBackorder  '+
            // ' where ifnull(T.boinvoicelineId, 0) = 0;');
            ' where ifnull(T.invoicelineId, 0) = 0;');  // **GH** 2022.03.25
    SQL.add('/*17*/update ' + fstablename +'  T  '+
            ' inner join tblsaleslines    SL  on T.BOSalesOrderLineId = SL.SaleLineID       '+
            ' Set  T.Sale_Id = SL.saleId, T.saleLine_Id = SL.SaleLineId ,   '+
            ' SalesUOM = concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") ,  '+
            ' T.SaelsSold = SL.UnitofMeasureQtySold ,  '+
            ' T.SalesShipped = SL.UnitofMeasureShipped ,  '+
            ' T.SalesBO = SL.UnitofMeasureBackorder  '+
            ' where ifnull(T.boinvoicelineId ,0)=0  '+
            ' and ifnull(T.invoicelineId,0)=0; ');
    SQL.add('/*18*/update ' + fstablename +'  T  '+
            ' inner join tblsaleslines    SL  on T.SalesOrderLineId   = SL.SaleLineID       '+
            ' Set  T.Sale_Id = SL.saleId, T.saleLine_Id = SL.SaleLineId ,   '+
            ' SalesUOM = concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") ,  '+
            ' T.SaelsSold = SL.UnitofMeasureQtySold ,  '+
            ' T.SalesShipped = SL.UnitofMeasureShipped ,  '+
            ' T.SalesBO = SL.UnitofMeasureBackorder  '+
            ' where ifnull(T.boinvoicelineId ,0)=0  '+
            ' and ifnull(T.invoicelineId,0)=0  '+
            ' and ifnull(BOSalesOrderLineId,0)=0; ');

    SQL.add('/*19*/Drop table if exists ' + fstablename +'1;');
    SQL.add('/*20*/Create table ' + fstablename +'1  '+
            ' Select OriginalPOID, ProductId, Seqno , sum(POShipped) as POShipped   '+
            ' from ' + fstablename +' T group by  OriginalPOID, ProductId, Seqno;');
    SQL.add('/*20.1*/alter table ' +fstablename +'1  add index OriginalPOID (OriginalPOID, productID, seqno);');
    SQL.add('/*20.1*/alter table ' +fstablename +'  add index PurchaseOrderId (PurchaseOrderId, productID, seqno);');
    SQL.add('/*21*/update ' + fstablename +'  T   '+
            ' inner join ' + fstablename +'1 T1 on  T.PurchaseOrderId = T1.OriginalPOID   and T.productId = T1.productID    and T.Seqno = T1.Seqno  '+
            ' Set T.POShipped = T1.POShipped ;');
    SQL.add('/*22*/update ' + fstablename +'  T  Set T.POBO = T.posold - T.POShipped ;');

    SQL.add('/*23*/Drop table if exists ' + fstablename +'1;');
    SQL.add('/*24*/Create table ' + fstablename +'1  '+
            ' Select OriginalPOID, ProductId, Seqno , sum(POShipped) as POShipped , max(ReceivedDate) as LastOrderReceivedDate  '+
            ' from ' + fstablename +' T group by  OriginalPOID, ProductId, Seqno;');
    SQL.add('/*25.1*/alter table ' +fstablename +'1  add index OriginalPOID (OriginalPOID);');
    SQL.add('/*25.1*/alter table ' +fstablename +'   add index OriginalPOID (OriginalPOID);');
    SQL.add('/*27*/update ' + fstablename +'  T   '+
            ' inner join ' + fstablename +'1 T1 on  T.OriginalPOID = T1.OriginalPOID  '+
            ' Set T.LastOrderReceivedDate = T1.LastOrderReceivedDate;');
    SQL.add('/*28*/update ' + fstablename +'  T  Set T.POBO = T.posold - T.POShipped ;');
    SQL.add('/*29*/Drop table if exists ' + fstablename +'1;');


    DoShowProgressbar(SQL.count, WAITMSG);
    try
      SQL.text := ChangeQuery(SQL.text);
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
end;
procedure TIncomingCustomerOrdersGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrymain.parambyname('filterindex').asInteger :=grpFilters.itemindex;
end;

procedure TIncomingCustomerOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Populatedata;
  inherited;
end;

initialization
  RegisterClass(TIncomingCustomerOrdersGUI);

end.
