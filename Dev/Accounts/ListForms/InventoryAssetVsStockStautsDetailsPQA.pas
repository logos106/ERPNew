unit InventoryAssetVsStockStautsDetailsPQA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , InventoryAssetVsStockStautsDetailsBase,
  wwclearbuttongroup, wwradiogroup;

type
  TInventoryAssetVsStockStautsDetailsPQAGUI = class(TInventoryAssetVsStockStautsDetailsBaseGUI)
    procedure FormShow(Sender: TObject);
  protected
    Procedure MakeQrymain;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TInventoryAssetVsStockStautsDetailsPQAGUI }

procedure TInventoryAssetVsStockStautsDetailsPQAGUI.FormShow(Sender: TObject);
begin
  MakeQrymain;
  inherited;
end;

procedure TInventoryAssetVsStockStautsDetailsPQAGUI.MakeQrymain;
begin
  Closedb(Qrymain);
  Qrymain.sQL.clear;
  Qrymain.sQL.add('Select PQA.TransDate , PQA.Trans_Type , PQA.Transactionno , PQA.Qty, PQA.AvgCost, PQA.LineCost,  PQA.PQATranslineID ,  PQA.TotalCost, PQA.AvgTotalCost,');
  Qrymain.sQL.add('if( PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , ' +
                      ' Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)), PQA.productname) as Productname,');
  Qrymain.sQL.add('if (PQA.PQATRanstype in ("TPurchaseOrderLine")  , POL.Shipped , if(PQA.PQATRanstype in ("TStockMovementLines")  , SML.Qty ,   ' +
                      ' if(PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.Shipped ,    ' +
                      ' if(PQA.PQATRanstype in ("TSalesOrderInvoiceLines") , SOIL.Qty ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PTP.ManufactureQty ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcProgressIn") , PP.Qty,0)))))) as transqty ,');
  Qrymain.sQL.add('if (PQA.PQATRanstype in ("TPurchaseOrderLine")  , POL.Linecost ,  ' +
                      ' if(PQA.PQATRanstype in ("TStockMovementLines")  , SML.Cost ,   ' +
                      ' if(PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.linecost ,    ' +
                      ' if(PQA.PQATRanstype in ("TSalesOrderInvoiceLines") , null ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PT.cost ,    ' +
                      ' if(PQA.PQATRanstype in ("TProcProgressIn") , PPT.cost,0)))))) as transcost');
  Qrymain.sQL.add('from  '+tablename + '_sms   PQA');
  Qrymain.sQL.add('Left  Join tblpurchaselines          AS POL  ON PQa.PQATranslineID = POL.PurchaseLineID        and PQA.PQATRanstype in ("TPurchaseOrderLine")');
  Qrymain.sQL.add('Left  Join tblpurchaseorders         AS PO   ON POL.PurchaseOrderID= PO.PurchaseOrderID');
  Qrymain.sQL.add('Left  Join tblstockmovementlines     AS SML  ON PQa.PQATranslineID = SML.StockmovementLinesID  and PQA.PQATRanstype in ("TStockMovementLines")');
  Qrymain.sQL.add('Left  Join tblsaleslines             AS SL   ON PQa.PQATranslineID = SL.SaleLineID              ' +
                      ' and PQA.PQATRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")');
  Qrymain.sQL.add('Left  Join tblsales                  AS S    ON SL.SaleID          = S.SaleID');
  Qrymain.sQL.add('Left  join (tblsalesorderinvoicelines  AS SOIL inner   Join tblsalesorderinvoices     AS SOI  ON SOIL.SOInvoiceID   = SOI.SOInvoiceID )  ' +
                      ' on PQa.PQATranslineID = SOIL.SOInvoiceLineID  and PQA.PQATRanstype = "TSalesOrderInvoiceLines"');
  Qrymain.sQL.add('Left  Join (tblproctreepart            AS PTP inner join tblproctree PT on PTP.proctreeId = PT.proctreeID)  ON PTP.ProcTreePartId = PQa.PQATranslineID            ' +
                      ' and PQA.PQATRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE")');
  Qrymain.sQL.add('Left  join (tblprocprogress            AS PP  inner join tblproctree PPT on PP.proctreeId = PPT.proctreeID )  on PP.ProcProgressID  = PQa.PQATranslineID            ' +
                      ' and PQA.PQATRanstype in ("TProcProgressIn")');
  Qrymain.sQL.add(' where ' + TypeWhere('PQA.PQATRanstype')+'  and PQA.Transactionno =' + inttostr(transID));
  Qrymain.sQL.add('Order by PT.sequencedown , Pqa.productname ');
  inherited;
end;

procedure TInventoryAssetVsStockStautsDetailsPQAGUI.RefreshQuery;
begin
  inherited;

end;

initialization
  RegisterClassOnce(TInventoryAssetVsStockStautsDetailsPQAGUI);

end.
