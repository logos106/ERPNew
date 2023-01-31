unit PQAFix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Menus, ExtCtrls, StdCtrls, BaseInputForm, DAScript, MyScript, kbmMemTable,
  CustomInputBox, wwDialog, Wwlocate, ActnList, PrintDAT, AdvOfficeStatusBar,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, Shader, DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TpqaFixGUI = class(TBaseListingGUI)
    btnUpdateAll: TDNMSpeedButton;
    qryMainTransId: TIntegerField;
    qryMainTransLineId: TIntegerField;
    qryMaintranstype: TWideStringField;
    qryMainalloctype: TWideStringField;
    qryMaintransdate: TDateTimeField;
    qryMainisbo: TWideStringField;
    qryMainqty: TFloatField;
    qryMainuomqty: TFloatField;
    qryMainuom: TWideStringField;
    qryMainuommult: TFloatField;
    qryMainuomid: TIntegerField;
    qryMaindeptId: TIntegerField;
    qryMainproductId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainPQAs: TLargeintField;
    qryMainpqaisbo: TWideStringField;
    qryMainpqaactive: TWideStringField;
    procedure btnUpdateAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsTablename : String;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib,AppDatabase, PQALib, LogLib, tcConst, CommonDbLib,
  DbSharedObjectsObj, ERPVersionConst;

{$R *.dfm}

procedure TpqaFixGUI.btnUpdateAllClick(Sender: TObject);
var
  Levelno,ctr:Integer;
  Qry : TERPQuery;
begin
  inherited;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    with qry do begin
      SQL.Text :=  'SELECT MAX(LEVEL) Level FROM tblproctree;';
      open;
      Levelno := fieldbyname('LEvel').asInteger;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

  With Scriptmain do begin
      SQL.Clear;
      if Levelno >0 then begin
          SQL.Add('Truncate tblproctreeNodes;');
          SQL.Add('Insert ignore into tblproctreeNodes (ProctreeId ,ParentID ,Level , Selected) select ProctreeId  , ParentID , Level, "" from tblProctree where mastertype <> "mtProduct";');
          SQL.Add('update tblproctreeNodes PTN  inner join tblproctree PT on PTN.proctreeId = PT.proctreeId and ifnull(PT.ParentId,0)=0 Set PTN.selected ="T";');
          for ctr := 1 to levelno do begin
            SQL.add('update tblproctreeNodes PTN '+
                    ' inner join tblProctree PT on PT.proctreeId = PTN.proctreeID  and PT.level = '+ inttostr(ctr) +' '+
                    ' inner join tblproctreeNodes PPTN on PT.ParentId = PPTN.ProctreeId '+
                    ' inner join tblproctree PPT on PPT.proctreeId = PT.parentID '+
                    ' Set PTN.Selected = if(PPTN.Selected ="F", "F", if(PPT.inputtype <> "itOption" , "T" , if(PPTN.Selected ="T" and PT.selected="T"  , "T" , "F")));');
          end;
      end;
      SQL.add('/*backup of PQA*/');
      SQL.add('create table if not exists erpfix_tblpqa' + replacestr(TABLE_VERSION , '.' , '') +' like tblpqa;');
      SQL.add('insert ignore into erpfix_tblpqa' + replacestr(TABLE_VERSION , '.' , '') +' select * from tblpqa;');
      SQL.add('truncate tblpqa;');

      SQL.add('/*Distinct PQAs*/');
      SQL.add('insert ignore into tblpqa Select * from erpfix_tblpqa' + replacestr(TABLE_VERSION , '.' , '') +' group by transId, translineId, transtype, alloctype;');
      SQL.add('create table if not exists erpfix_tblpqadetails' + replacestr(TABLE_VERSION , '.' , '') +' like tblpqadetails;');
      SQL.add('insert ignore into erpfix_tblpqadetails' + replacestr(TABLE_VERSION , '.' , '') +' select * from tblpqadetails;');
      SQL.add('/*delete the invalid allocation which is not linked to any pqa*/');
      SQL.add('delete from tblpqadetails where pqaId not in (Select pqaId from tblpqa);');


      SQL.add('Drop table if exists tmp_1  ;');
      SQL.add('create table tmp_1  like tblpurchaselines;');
      SQL.add('insert ignore into tmp_1  select pol.* from tblpurchaselines pol inner join tblpurchaseorders po on pol.PurchaseOrderID = po.PurchaseOrderID and po.IsPO="T" and pol.PARTTYPE ="INV";');
      SQL.add('alter table tmp_1  add column bolineId int(11) ;');
      SQL.add('update tmp_1  T inner join tblpurchaseorders PO on PO.PurchaseOrderID = t.PurchaseOrderID and ifnull(PO.BOID,"")<> "" '+
              ' inner join tblpurchaseorders POBO on PO.BOID = POBO.GlobalRef and PO.OriginalNo = POBO.OriginalNo '+
              ' inner join tblpurchaselines POLBO on POBO.PurchaseOrderID = POLBO.PurchaseOrderID and POLBO.ProductID = T.productId and POLBO.SEQNo = t.seqno '+
              ' Set T.bolineId = POLBO.PurchaseLineID;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.purchaseorderId = pqa.TransID and t.purchaselineId = pqa.TransLineID and pqa.transtype = ' + POTranstypes +' '+
              ' Set pqa.active ="F" where ifnull(t.bolineId,0)<>0  and ifnull(shipped,0)=0 ;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.purchaseorderId = pqa.TransID and t.purchaselineId = pqa.TransLineID and pqa.transtype = ' + POTranstypes +' '+
              ' Set pqa.active ="T" where ifnull(t.bolineId,0)=0 or ifnull(shipped,0)<> 0 ;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.purchaseorderId = pqa.TransID and t.purchaselineId = pqa.TransLineID and pqa.transtype = ' + POTranstypes +' '+
              ' Set pqa.ISBO ="T" where ifnull(T.shipped,0)=0;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.purchaseorderId = pqa.TransID and t.purchaselineId = pqa.TransLineID and pqa.transtype = ' + POTranstypes +' '+
              ' Set pqa.ISBO ="F" where ifnull(T.shipped,0)<>0;');

      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select t.PurchaseorderId, t.PurchaseLineId, ' + POTranstypes +'   , "IN" , if(ifnull(T.ReceivedDate,0)=0 , PO.OrderDate , T.ReceivedDate), if(ifnull(T.shipped,0)=0,"T","F"), '+
              ' if(ifnull(shipped,0)=0 ,t.backorder, t.shipped) , '+
              ' if(ifnull(shipped,0)=0 ,t.UnitofMeasureBackorder, t.UnitofMeasureShipped),  '+
              ' t.UnitofMeasurePOLines, t.UnitofMeasureMultiplier, t.UnitOfMeasureID, t.ClassID , t.productId, t.productname, if(ifnull(t.bolineId,0)=0,"T","F"), "F" '+
              ' from tmp_1  T '+
              ' inner join tblpurchaseorders PO on PO.PurchaseOrderID = t.purchaselineId '+
              ' left join tblpqa pqa on pqa.TransLineID = t.purchaselineId and pqa.transID = T.purchaseorderId and pqa.TransType =' + POTranstypes +' '+
              ' where (ifnull(t.shipped,0)<> 0 or ifnull(T.backorder,0)<> 0) and ifnull(pqa.PQAID,0)=0 ;');

      SQL.add('#sales');
      SQL.add('Drop table if exists tmp_1  ;');
      SQL.add('create table tmp_1  like tblsaleslines;');
      SQL.add('insert ignore into tmp_1  select SL.* from tblsaleslines SL inner join tblsales S on SL.saleId = S.saleId and S.Isquote="F" and S.IsCustomerReturn="F" and SL.PARTTYPE ="INV";');
      SQL.add('alter table tmp_1  add column bolineId int(11) ;');

      SQL.add('update tmp_1  T inner join tblsales S on S.saleId = t.saleId and ifnull(S.BOID,"")<> "" '+
              ' inner join tblsales SBO on S.BOID = SBO.GlobalRef and S.OriginalNo = SBO.OriginalNo '+
              ' inner join tblsaleslines SLBO on SBO.saleId = SLBO.saleId and SLBO.ProductID = T.productId and SLBO.SEQNo = t.seqno '+
              ' Set T.bolineId = SLBO.SaleLineID;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.saleId = pqa.TransID and t.SaleLineID = pqa.TransLineID and pqa.transtype in (' + SalesTransTypes +' ) '+
              ' inner join tblsales S on t.saleId = s.saleId '+
              ' Set pqa.active ="F" where (ifnull(t.bolineId,0)<>0 and  ifnull(shipped,0)=0 ) or s.converted="T";');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.saleId = pqa.TransID and t.SaleLineID = pqa.TransLineID and pqa.transtype in (' + SalesTransTypes +' ) '+
              ' inner join tblsales S on t.saleId = s.saleId '+
              ' Set pqa.active ="T" where (ifnull(t.bolineId,0)=0 or ifnull(shipped,0)<> 0 ) and S.converted ="F";');


      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.saleId = pqa.TransID and t.SaleLineID = pqa.TransLineID and pqa.transtype in (' + SalesTransTypes +' ) '+
              ' Set pqa.ISBO ="T" where ifnull(T.shipped,0)=0;');

      SQL.add('update tmp_1  T '+
              ' inner join tblpqa pqa  on T.saleId = pqa.TransID and t.SaleLineID = pqa.TransLineID and pqa.transtype in (' + SalesTransTypes +' ) '+
              ' Set pqa.ISBO ="F" where ifnull(T.shipped,0)<>0;');

      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select T.SaleID, t.salelineID,  '+
              ' if (s.isinvoice="T", "TInvoiceLine",if(S.issalesorder ="T" , "TSalesOrderline",if(S.isrefund ="T", "TRefundSaleLine",if(S.iscashsale="T","TCashSaleLine", if(S.ispos="T", "TPOSCashSaleline","TPOSLaybylines")))))  ,  '+
              ' "OUT" , T.shipdate, if(ifnull(T.shipped,0)=0,"T","F"), '+
              ' if(ifnull(shipped,0)=0 ,t.backorder, t.shipped) , '+
              ' if(ifnull(shipped,0)=0 ,t.UnitofMeasureBackorder, t.UnitofMeasureShipped), T.UnitofMeasureSaleLines, t.UnitofMeasureMultiplier,  '+
              ' t.UnitOfMeasureID, s.ClassID , t.productId, t.productname, if(ifnull(t.bolineId,0)=0,"T","F"), "F" '+
              ' from tmp_1  T '+
              ' inner join tblsales s on t.saleId = s.saleId and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' left join tblpqa pqa on pqa.TransLineID = t.SalelineId and pqa.transID = T.SaleID and pqa.TransType in (' + SalesTransTypes +' ) '+
              ' where (ifnull(t.shipped,0)<> 0 or ifnull(T.backorder,0)<> 0) and ifnull(pqa.PQAID,0)=0 ;');


      SQL.add('/*stock adjustment and stock transfers*/');

      SQL.add('update tblstockmovementlines SML '+
              ' inner join tblstockmovement SM on SM.stockmovementId = SML.stockmovementId '+
              ' inner join tblpqa pqa on pqa.TransLineID = SML.StockmovementLinesID and pqa.TransID = SML.StockmovementID and pqa.transtype = ' + StockMovementtypes +' '+
              ' Set PQA.active =if(SM.Deleted="T","F","T");');

      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select SML.StockmovementID, SML.StockmovementLinesID, ' + StockMovementtypes +'  , "IN", SM.MovementDate, "F" , SML.Qty , SML.UOMQty, SML.UOM, SML.UOMMultiplier, SML.UOMID, '+
              ' SML.ClassID, SML.ProductID, SML.ProductName, if(SM.Deleted="T","F","T"), "F" '+
              ' from tblstockmovementlines SML '+
              ' inner join tblstockmovement SM on SM.stockmovementId = SML.stockmovementId '+
              ' Left join tblpqa pqa on pqa.TransLineID = SML.StockmovementLinesID and pqa.TransID = SML.StockmovementID and pqa.transtype = ' + StockMovementtypes +' '+
              ' where parttype ="INV" and ifnull(pqa.PQAID,0)=0;');


      SQL.add('/*Manufacture - root*/');
      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select s.sAleId, PTP.ProcTreePartId , "TProcTreePart", "IN", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" , SL.Shipped ,  '+
              ' SL.UnitofMeasureShipped, SL.UnitofMeasureSaleLines, SL.UnitofMeasureMultiplier, SL.UnitOfMeasureID, S.ClassID, SL.ProductID, SL.ProductName, if(S.converted="T" , "T","F"), "F" '+
              ' from tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0  and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="IN" '+
              ' where ifnull(PT.ParentId,0)=0 and ifnull(PQA.pqaid,0)=0 ;');


      SQL.add('update tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' inner join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="IN" '+
              ' set pqa.active =if(S.converted="T" , "T","F") '+
              ' where ifnull(PT.ParentId,0)=0 ;');

      SQL.add('/*Manufacture - nonroot*/');
      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select s.sAleId, PTP.ProcTreePartId , "TProcTreePart", "OUT", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" , PTP.Qty ,  '+
              ' PTP.UOMQty, PTP.UnitOfMeasure, PTP.UnitOfMeasureMultiplier, PTP.UnitOfMeasureId, S.ClassID, PTP.ProductId, PTP.ProductName, if(S.converted="T" , "T","F"), "F" '+
              ' from tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0  and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T" '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="OUT" '+
              ' where ifnull(PT.ParentId,0)<> 0 and ifnull(PQA.pqaid,0)=0 ;');


      SQL.add('update tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T" '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' inner join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="OUT" '+
              ' set pqa.active =if(S.converted="T" , "T","F") '+
              ' where ifnull(PT.ParentId,0)<> 0;');


      SQL.add('/*Manufacture sub builds - in*/');
      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select distinct s.sAleId, PTP.ProcTreePartId , "TProcTreePartIN", "IN", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" , PTP.Qty , PTP.UOMQty, PTP.UnitOfMeasure,  '+
              ' PTP.UnitOfMeasureMultiplier, PTP.UnitOfMeasureId, S.ClassID, PTP.ProductId, PTP.ProductName, if(S.converted="T" , "T","F"), "F" '+
              ' from tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T" '+
              ' inner join tblproctree PPT on PT.ProcTreeId = PPT.ParentId '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePartIN" and alloctype ="IN" '+
              ' where ifnull(PT.ParentId,0)<> 0 and ifnull(PQA.pqaid,0)=0 ;');


      SQL.add('update tblsales S '+
              ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0  and S.Isquote="F" and S.IsCustomerReturn="F" '+
              ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder" '+
              ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T" '+
              ' inner join tblproctree PPT on PT.ProcTreeId = PPT.ParentId  '+
              ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV" '+
              ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePartIN" and alloctype ="IN" '+
              ' set pqa.active =if(S.converted="T" , "T","F") '+
              ' where ifnull(PT.ParentId,0)<> 0;');

      SQL.add('/*RepairParts*/');
      SQL.add('insert ignore into tblpqa (transId, translineID, transtype, alloctype, TransDate, IsBO, Qty, uomqty, uom, UOMMultiplier, uomid,departmentId,productId,productname,Active,reserved) '+
              ' Select RP.RepairID , RP.RepairPartsID, ' + RepairType + ', "OUT", if(ifnull(RP.PartIssuedOn,0)=0 , R.CreationDate , RP.PartIssuedOn), "F" ,  '+
              ' RP.Qty, RP.UOMQty, RP.UnitofMeasure, RP.UnitofMeasureMultiplier, RP.UnitofMeasureID, RP.ClassID, RP.PartsID, RP.PartName, if(RP.ConvertToInvoice="F" , "T", "F"), "F" '+
              ' from tblrepairparts RP '+
              ' inner join tblrepairs R on RP.RepairID = R.RepairID '+
              ' Left join tblpqa pqa on pqa.TransLineID = RP.RepairPartsID and pqa.TransID = RP.RepairID and pqa.TransType in  (' + RepairType + ') '+
              ' where ifnull(pqa.PQAID,0)=0;');

      SQL.add('update tblrepairparts RP '+
              ' inner join tblrepairs R on RP.RepairID = R.RepairID '+
              ' inner join tblpqa pqa on pqa.TransLineID = RP.RepairPartsID and pqa.TransID = RP.RepairID and pqa.TransType in  (' + RepairType + ') '+
              ' Set pqa.Active = if(RP.ConvertToInvoice="F" , "T", "F");');
    clog(SQL.Text);
    DoShowProgressbar(Statements.Count , WAITMSG );
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  RefreshQuery;
end;

procedure TpqaFixGUI.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('PQAfix');
  With scriptmain do begin
    SQl.Clear;
    SQL.Add('drop TABLE if exists '+fstablename+' ;' +
            ' CREATE TABLE '+fstablename+' ( '+
    	      '   ID            INT(11)       NULL AUTO_INCREMENT, '+
    	      ' 	TransId       INT(11)       NULL DEFAULT NULL, '+
    	      ' 	TranslineId   INT(11)       NULL DEFAULT 0, '+
    	      ' 	transtype     VARCHAR(18)   NULL DEFAULT "", '+
    	      ' 	alloctype     VARCHAR(2)    NULL DEFAULT "", '+
    	      ' 	transdate     DATETIME      NULL DEFAULT NULL, '+
    	      ' 	isbo          VARCHAR(1)    NULL DEFAULT "", '+
    	      ' 	qty           DOUBLE        NULL DEFAULT 0, '+
    	      ' 	uomqty        DOUBLE        NULL DEFAULT 0, '+
    	      ' 	uom           VARCHAR(255)  NULL DEFAULT NULL, '+
    	      ' 	uommult       DOUBLE        NULL DEFAULT 1, '+
    	      ' 	uomid         INT(11)       NULL DEFAULT NULL, '+
    	      ' 	deptId        INT(11)       NULL DEFAULT 0, '+
    	      ' 	productId     INT(11)       NULL DEFAULT NULL, '+
    	      ' 	productname   VARCHAR(60)   NULL DEFAULT NULL, '+
    	      ' 	PQAs          BIGINT(21)    NOT NULL DEFAULT 0, '+
    	      ' 	pqaisbo       ENUM("T","F","") DEFAULT NULL , '+
    	      ' 	pqaactive     ENUM("T","F","") NULL DEFAULT NULL, '+
    	      ' 	PRIMARY KEY (ID) ) ENGINE=MyISAM ');
    execute;
  end;

  Qrymain.SQL.Text := 'Select * from '+ fsTablename +' where PQAS<> 1';
  inherited;

end;

procedure TpqaFixGUI.RefreshQuery;
begin
  with scriptMain do begin
    SQL.Clear;
    SQL.Add('truncate ' + fstablename +' ;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select t.PurchaseorderId, t.PurchaseLineId, "TPurchaseOrderLine"  transtype, "IN" alloctype, if(ifnull(T.ReceivedDate,0)=0 , PO.OrderDate , T.ReceivedDate) transdate, if(ifnull(T.shipped,0)=0,"T","F") isbo,  '+
            ' if(ifnull(shipped,0)=0 ,t.backorder, t.shipped) qty,  '+
            ' if(ifnull(shipped,0)=0 ,t.UnitofMeasureBackorder, t.UnitofMeasureShipped) uomqty, t.UnitofMeasurePOLines uom, t.UnitofMeasureMultiplier uommult, t.UnitOfMeasureID uomid, t.ClassID deptId, t.productId productId, t.productname productname,  '+
            ' count(PQA.PQAID) as PQAs, PQA.ISBO pqaisbo, PQa.Active pqaactive  '+
            ' from tblpurchaselines  T  '+
            ' inner join tblpurchaseorders PO on PO.PurchaseOrderID = t.purchaselineId  '+
            ' left join tblpqa pqa on pqa.TransLineID = t.purchaselineId and pqa.transID = T.purchaseorderId and pqa.TransType ="TPurchaseOrderLine"  '+
            ' where (ifnull(t.shipped,0)<> 0 or ifnull(T.backorder,0)<> 0) and T.parttype ="INV" '+
            ' group by t.PurchaseorderId, t.PurchaseLineId;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select T.SaleID, t.salelineID,  '+
            ' if (s.isinvoice="T", "TInvoiceLine",if(S.issalesorder ="T" , "TSalesOrderline",if(S.isrefund ="T", "TRefundSaleLine",if(S.iscashsale="T","TCashSaleLine", if(S.ispos="T", "TPOSCashSaleline","TPOSLaybylines")))))  ,  '+
            ' "OUT" , T.shipdate, if(ifnull(T.shipped,0)=0,"T","F"),  '+
            ' if(ifnull(shipped,0)=0 ,t.backorder, t.shipped) ,  '+
            ' if(ifnull(shipped,0)=0 ,t.UnitofMeasureBackorder, t.UnitofMeasureShipped), T.UnitofMeasureSaleLines, t.UnitofMeasureMultiplier, t.UnitOfMeasureID, s.ClassID , t.productId, t.productname,  '+
            ' count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblsaleslines T  '+
            ' inner join tblsales s on t.saleId = s.saleId and S.Isquote="F" and S.IsCustomerReturn="F"  '+
            ' left join tblpqa pqa on pqa.TransLineID = t.SalelineId and pqa.transID = T.SaleID and pqa.TransType in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")  '+
            ' where (ifnull(t.shipped,0)<> 0 or ifnull(T.backorder,0)<> 0) and T.parttype ="INV"  '+
            ' group by  T.SaleID, t.salelineID;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select SML.StockmovementID, SML.StockmovementLinesID, "TStockMovementLines" , "IN", SM.MovementDate, "F" , SML.Qty , SML.UOMQty, SML.UOM, SML.UOMMultiplier, SML.UOMID,  '+
            ' SML.ClassID, SML.ProductID, SML.ProductName, count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblstockmovementlines SML  '+
            ' inner join tblstockmovement SM on SM.stockmovementId = SML.stockmovementId  '+
            ' Left join tblpqa pqa on pqa.TransLineID = SML.StockmovementLinesID and pqa.TransID = SML.StockmovementID and pqa.transtype = "TStockMovementLines"  '+
            ' where parttype ="INV"  and SML.parttype ="INV"'+
            ' group by SML.StockmovementID, SML.StockmovementLinesID;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select s.sAleId, PTP.ProcTreePartId , "TProcTreePart", "IN", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" ,  '+
            ' SL.Shipped , SL.UnitofMeasureShipped, SL.UnitofMeasureSaleLines, SL.UnitofMeasureMultiplier, SL.UnitOfMeasureID, S.ClassID, SL.ProductID, SL.ProductName, count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblsales S  '+
            ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F"  '+
            ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder"  '+
            ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV"  '+
            ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="IN"  '+
            ' where ifnull(PT.ParentId,0)=0  and ptp.parttype ="INV"'+
            ' group by s.sAleId, PTP.ProcTreePartId ;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select s.sAleId, PTP.ProcTreePartId , "TProcTreePart", "OUT", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" , PTP.Qty , PTP.UOMQty, PTP.UnitOfMeasure,  '+
            ' PTP.UnitOfMeasureMultiplier, PTP.UnitOfMeasureId, S.ClassID, PTP.ProductId, PTP.ProductName, count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblsales S  '+
            ' inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F"  '+
            ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder"  '+
            ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T"  '+
            ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV"  '+
            ' left join tblpqa pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePart" and alloctype ="OUT"  '+
            ' where ifnull(PT.ParentId,0)<> 0 and PTP.parttype ="INV" '+
            ' group by s.sAleId, PTP.ProcTreePartId  ;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select s.sAleId, PTP.ProcTreePartId , "TProcTreePartIN", "IN", if(ifnull(PTP.DateRequired,0)=0 , SL.ShipDate , PTP.DateRequired), "F" , PTP.Qty ,  '+
            ' PTP.UOMQty, PTP.UnitOfMeasure, PTP.UnitOfMeasureMultiplier, PTP.UnitOfMeasureId, S.ClassID, PTP.ProductId, PTP.ProductName, count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblsales S  '+
            ' inner join tblsaleslines    SL on s.saleId = SL.saleId  and ifnull(SL.Shipped,0) <>0 and S.Isquote="F" and S.IsCustomerReturn="F"  '+
            ' inner join tblproctree      PT on SL.salelineId = PT.MasterId and PT.MasterType ="mtSalesOrder"  '+
            ' inner join tblproctreeNodes PTN on PT.proctreeId = PTN.proctreeId and PTN.selected ="T"  '+
            ' inner join tblproctree      PPT on PT.ProcTreeId = PPT.ParentId  '+
            ' inner join tblproctreepart  PTP on PT.ProcTreeId = PTP.ProcTreeId and PTP.Parttype ="INV"  '+
            ' left join tblpqa            pqa on pqa.TransID = sl.saleId and pqa.TransLineID = ptp.proctreepartId and pqa.TransType = "TProcTreePartIN" and alloctype ="IN"  '+
            ' where ifnull(PT.ParentId,0)<> 0  and PTP.parttype ="INV" '+
            ' group by s.sAleId, PTP.ProcTreePartId ;');
    SQL.Add('insert into ' + fstablename +'( TransId,	TranslineId,	transtype,	alloctype,	transdate,	isbo,	qty,	uomqty,	uom,	uommult,	uomid,	deptId,	productId,	productname,	PQAs,	pqaisbo,	pqaactive ) '+
            ' Select RP.RepairID , RP.RepairPartsID, "TRepairParts", "OUT", if(ifnull(RP.PartIssuedOn,0)=0 , R.CreationDate , RP.PartIssuedOn), "F" , RP.Qty, RP.UOMQty,  '+
            ' RP.UnitofMeasure, RP.UnitofMeasureMultiplier, RP.UnitofMeasureID, RP.ClassID, RP.PartsID, RP.PartName, count(PQA.PQAID) as PQAs, PQA.ISBO, PQa.Active  '+
            ' from tblrepairparts RP  '+
            ' inner join tblrepairs R on RP.RepairID = R.RepairID  '+
            ' Left join tblpqa pqa on pqa.TransLineID = RP.RepairPartsID and pqa.TransID = RP.RepairID and pqa.TransType = "TRepairParts"  '+
            ' where RP.parttype ="INV"  '+
            ' group by  RP.RepairID , RP.RepairPartsID ;');
    clog(SQL.Text);
    DoShowProgressbar(Statements.Count , WAITMSG );
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  inherited;

end;

initialization
  RegisterClassOnce(TpqaFixGUI);

end.
