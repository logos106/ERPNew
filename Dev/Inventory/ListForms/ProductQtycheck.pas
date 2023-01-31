unit ProductQtycheck;

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
  TProductQtycheckGUI = class(TBaseListingGUI)
    qryMainProductName: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainDescription: TWideStringField;
    qryMainAlloctype: TWideStringField;
    qryMaintransid: TLargeintField;
    qryMainUOMQty: TFloatField;
    qryMainbatchuomqty: TFloatField;
    qryMainbinuomqty: TFloatField;
    qryMainsnuomqty: TFloatField;
    qryMaintransuomqty: TFloatField;
    qryMainClassname: TWideStringField;
    qryMaintransqty: TFloatField;
    qryMainbinqty: TFloatField;
    qryMainsnqty: TFloatField;
    qryMainpqaid: TIntegerField;
    qryMainQty: TFloatField;
    qryMainbatchqty: TFloatField;
    qryMainSNtracking: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;

    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
  private
    fiProductId: Integer;
    fiClassId: Integer;
    procedure SetClassId(const Value: Integer);
    procedure SetProductId(const Value: Integer);
  Protected
    Procedure SetGridColumns;override;
  public
    Procedure RefreshQuery;Override;
    Property ProductId :Integer read fiProductId write SetProductId;
    Property classId :Integer read fiClassId write SetClassId;
  end;

implementation

uses CommonDbLib, CommonLib, ProductQtyLib, LogLib;

{$R *.dfm}

{ TProductQtycheckGUI }

procedure TProductQtycheckGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductId := 0;
  ficlassId := 0;
  SelectionOption := soClass;
  SelectionOption := soProduct;
end;

procedure TProductQtycheckGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  if isformshown then RefreshQuery;
end;

procedure TProductQtycheckGUI.RefreshQuery;
var
  S:String;
begin
  closedb(qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.add('SELECT ');
  Qrymain.sql.add('pqa.pqaid            as pqaid, ');
  Qrymain.sql.add('pqa.ProductName      as ProductName, ');
  Qrymain.sql.add('c.classname          as Classname, ');
  Qrymain.sql.add('pqa.TransDate        as TransDate,  ');
  Qrymain.sql.add('PQAT.Description     as Description, ');
  Qrymain.sql.add('pqa.Alloctype        as Alloctype, ');
  Qrymain.sql.add('pqa.transid          as transid,');
  Qrymain.sql.add('P.Batch              as Batch,');
  Qrymain.sql.add('P.Multiplebins       as Multiplebins,');
  Qrymain.sql.add('P.SNtracking         as SNtracking,');
  Qrymain.sql.add('if (PQA.TRanstype in ("TPurchaseOrderLine")  , POL.Shipped , ' +
                  ' if(PQA.TRanstype in ("TStockMovementLines")  , SML.Qty ,  ' +
                  ' if(PQA.TRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.Shipped ,   ' +
                  ' if(PQA.TRanstype in ("TSalesOrderInvoiceLines") , SOIL.Qty ,   ' +
                  ' if(PQA.TRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PTP.Qty ,   ' +
                  ' if(PQA.TRanstype in ("TProcProgressIn") , PP.Qty,0)))))) as transqty ,');

  Qrymain.sql.add('if (PQA.TRanstype in ("TPurchaseOrderLine")  , POL.UnitofMeasureShipped,   ' +
                  ' if(PQA.TRanstype in ("TStockMovementLines")  , SML.UOMQty ,    ' +
                  ' if(PQA.TRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine") , SL.UnitofMeasureShipped ,     ' +
                  ' if(PQA.TRanstype in ("TSalesOrderInvoiceLines") , SOIL.UOMQty ,     ' +
                  ' if(PQA.TRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE") , PTP.UOMQty,     ' +
                  ' if(PQA.TRanstype in ("TProcProgressIn") , PP.UOMQty,0)))))) as transuomqty ,');
  Qrymain.sql.add('pqa.Qty              as Qty, ');
  Qrymain.sql.add('pqa.UOMQty           as UOMQty,');
  if grpfilters.Itemindex in [0,3,4] then begin
    Qrymain.sql.add('sum(PQABatch.Qty)    as batchqty, ');
    Qrymain.sql.add('sum(PQABatch.UOMQty) as batchuomqty,');
  end else begin
    Qrymain.sql.add('0.0 as batchqty, ');
    Qrymain.sql.add('0.0 as batchuomqty,');
  end;
  if grpfilters.Itemindex in [1,3,4] then begin
    Qrymain.sql.add('sum(PQABins.Qty)     as binqty, ');
    Qrymain.sql.add('sum(PQABins.UOMQty)  as binuomqty,');
  end else begin
    Qrymain.sql.add('0.0 as binqty, ');
    Qrymain.sql.add('0.0 as binuomqty,');
  end;
  if grpfilters.Itemindex in [2,3,4] then begin
    Qrymain.sql.add('sum(PQASN.Qty)       as snqty, ');
    Qrymain.sql.add('sum(PQASN.UOMQty)    as snuomqty');
  end else begin
    Qrymain.sql.add('0.0 as snqty, ');
    Qrymain.sql.add('0.0 as snuomqty');
  end;

(*  Qrymain.sql.add('FROM tblpqa AS PQA');
  Qrymain.sql.add('inner join tblparts p on pqa.productid = p.partsid');*)

  if grpfilters.Itemindex =0 then Qrymain.sql.add(TransTables(tDetails,'','','',''))
  else if grpfilters.Itemindex =1 then Qrymain.sql.add(TransTables(tExtraDetails,'','','',''))
  else Qrymain.sql.add(TransTables(tDetailswithSno,'','','',''));

  Qrymain.sql.add('inner join tblclass C on pqa.departmentid = c.classId');
  Qrymain.sql.add('inner join tblpqatranstypes PQAT on PQA.TransType = PQAT.Transtype');
(*  if grpfilters.Itemindex in [0,3] then begin
    Qrymain.sql.add('left join `tblPqaDetails` PQABatch on PQABatch.PQAId = PQA.PQAID  and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"');
  end;
  if grpfilters.Itemindex in [1,3] then begin
    Qrymain.sql.add('left join `tblPqaDetails` PQABins  on PQABins.PQAId 	= PQA.PQAID  and PQABins.PQAType  = "Bin"    and PQABins.Active = "T"  ' +
                  ' and  (   (' + inttostr(grpfilters.Itemindex ) +'=3 and  PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T")  ' +
                  '       or ((' + inttostr(grpfilters.Itemindex ) +'=1 or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F")) and P.multiplebins = "T"))');
  end;
  if grpfilters.Itemindex in [2,3] then begin
    Qrymain.sql.add('left join `tblPqaDetails` PQASN    on  PQASN.PQAId 	= PQA.PQAID  and PQASN.PQAType    = "SN"     and PQASN.Active = "T" and PQASN.Qty <> 0 and  ' +
                  ' (  (' + inttostr(grpfilters.Itemindex ) +'=3 and  PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")  ' +
                  ' or (' + inttostr(grpfilters.Itemindex ) +'=3 and  PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T")  ' +
                  ' or ((' + inttostr(grpfilters.Itemindex) +'=2 or (ifnull(PQASN.Parentref ,"") = "" and P.Batch="F" and P.Multiplebins = "F") and P.SNTracking = "T")))');
  end;*)
  Qrymain.sql.add('Left  Join `tblpurchaselines`          AS POL  ON PQA.TransLineID    = POL.PurchaseLineID        and PQA.TRanstype in ("TPurchaseOrderLine")');
  Qrymain.sql.add('Left  Join `tblpurchaseorders`         AS PO   ON POL.PurchaseOrderID= PO.PurchaseOrderID');
  Qrymain.sql.add('Left  Join `tblstockmovementlines`     AS SML  ON PQA.TransLineID    = SML.StockmovementLinesID  and PQA.TRanstype in ("TStockMovementLines")');
  Qrymain.sql.add('Left  Join `tblsaleslines`             AS SL   ON PQA.TransLineID    = SL.SaleLineID             and PQA.TRanstype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")');
  Qrymain.sql.add('Left  Join `tblsales`                  AS S    ON SL.SaleID          = S.SaleID');
  Qrymain.sql.add('Left  join  tblsalesorderinvoicelines  AS SOIL on PQA.transLineId    = SOIL.SOInvoiceLineID  and PQA.transtype = "TSalesOrderInvoiceLines"');
  Qrymain.sql.add('Left  Join `tblsalesorderinvoices`     AS SOI  ON SOIL.SOInvoiceID   = SOI.SOInvoiceID');
  Qrymain.sql.add('Left  Join `tblproctreepart`           AS PTP  ON PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE")');
  Qrymain.sql.add('Left  join tblprocprogress             AS PP   on PP.ProcProgressID  = PQA.TransLineID           and PQA.TRanstype in ("TProcProgressIn")');

  s:= 'PQa.productId <>0';
  if productId <> 0 then s:= s + ' and PQa.productId = ' + inttostr(ProductID);
  if classID   <> 0 then s:= s + ' and PQa.DepartmentID = ' + inttostr(ClassId);
  if grpfilters.Itemindex =0 then s:= s + ' and   (ifnull(PQABatch.PQADetailID,0) <> 0 Or P.Batch="T")';
  if grpfilters.Itemindex =1 then s:= s + ' and  ((ifnull(PQABins.PQADetailID ,0) <> 0  and ifnull(PQABins.Parentref ,"") = "") OR P.multiplebins="T")';
  if grpfilters.Itemindex =2 then s:= s + ' and  ((ifnull(PQASn.PQADetailID   ,0) <> 0  and ifnull(PQASn.Parentref   ,"") = "") OR P.SNTracking="T") ';
  if grpfilters.Itemindex =3 then s:= s + ' and   (P.Batch="T" or  P.multiplebins="T" OR P.SNTracking="T") ';
  if s <> 'PQa.productId <>0' then Qrymain.sql.add(' where ' + s);

  Qrymain.sql.add('group by pqaid');
  Qrymain.sql.add('order by pqa.productid, pqa.transdate desc ;');
    clog(qrymain.sql.text);
  QueryManipulationObj.RefreshOrignalSQL(qryMain.SQL.Text);
  inherited;

end;

procedure TProductQtycheckGUI.SetClassId(const Value: Integer);
begin
  fiClassId := Value;
  if Assigned(ClassLookupform) then ClassLookupform.Lookupid := Value;
end;

procedure TProductQtycheckGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainpqaid.fieldname);
  RemoveFieldfromGrid(qryMaintransqty.fieldname);
  RemoveFieldfromGrid(qryMainbinqty.fieldname);
  RemoveFieldfromGrid(qryMainsnqty.fieldname);
  RemoveFieldfromGrid(qryMainQty.fieldname);
  RemoveFieldfromGrid(qryMainbatchqty.fieldname);
end;

procedure TProductQtycheckGUI.SetProductId(const Value: Integer);
begin
  fiProductId := Value;
  if Assigned(ProductLookupform) then ProductLookupform.Lookupid := Value;
end;
initialization
  RegisterClassOnce(TProductQtycheckGUI);

end.
