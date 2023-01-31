unit DU_UOMMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TDU_UOMMismatchGUI = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainUnitID: TIntegerField;
    qryMainTransUOMID: TIntegerField;
    qryMainTransUOM: TFloatField;
    qryMainID: TIntegerField;
    qryMainProductname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsTablename :String;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Procedure UOMMismatchFix;
  end;

implementation

uses CommonLib, CommonDbLib, tcConst, DebugLib, LogLib;

{$R *.dfm}

procedure TDU_UOMMismatchGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('DU_UOM');
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('T.* , ');
  Qrymain.SQL.add('P.partname as Productname');
  Qrymain.SQL.add('from '+fstablename+' T');
  Qrymain.SQL.add('inner join tblparts P on P.partsId = T.partId');
  Qrymain.SQL.add('order by P.partname , Description , UnitName');
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TDU_UOMMismatchGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  try
    inherited;
  Except
    // kill excpetion
  end;

end;

procedure TDU_UOMMismatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(Parent) then
    if (Parent is TDNMPanel) then Self.Color := TDNMPanel(Parent).Color
    else if (Parent is TScrollbox)  then Self.Color := TScrollbox(Parent).Color;
end;

procedure TDU_UOMMismatchGUI.RefreshQuery;
begin
  with scriptmain do begin
    SQL.Clear;
    SQL.add('/*1*/Drop table if exists ' + fstablename +';');
    SQL.add('/*2*/drop table if exists  ' + fstablename +';');
    SQL.add('/*3*/Create table if not exists  ' + fstablename +' ('+
            ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
            ' Description varchar(50) NULL DEFAULT "", '+
            ' PartID int(11) null, '+
            ' UnitName varchar(255) NULL DEFAULT NULL, '+
            ' Multiplier double NULL DEFAULT 0, '+
            ' UnitID int(11) NULL DEFAULT 0, '+
            ' TransUOMID int(11) NULL DEFAULT NULL, '+
            ' TransUOM double NULL DEFAULT NULL ,'+
            ' PRIMARY KEY (ID) ) ENGINE=myisam DEFAULT CHARSET=utf8;');
    SQL.add('/*3-1*/ update IGNORE tblunitsofmeasure Set PartID =0 where ifnull(PartID , 0)=0;');
    SQL.add('/*3-4*/ update IGNORE tblproctreepart 					 Trans  set Trans.ProductId =0 Where ifnull(Trans.ProductId	,0)=0;');
    SQL.add('/*3-5*/ update IGNORE tblextraprice 						 Trans  Set PartsID=0 Where ifnull(Trans.PartsID		,0)=0;');
    SQL.add('/*3-6*/ update IGNORE tblextrapricesell 				 Trans  Set PartsID=0 Where ifnull(Trans.PartsID		,0)=0;');
    SQL.add('/*3-7*/ update IGNORE tblforeignprice 					 Trans  Set PartsID=0 Where ifnull(Trans.PartsID		,0)=0;');
    SQL.add('/*3-8*/ update IGNORE tblproctree 							 Trans  Set PartsId=0 Where ifnull(Trans.PartsId		,0)=0;');
    SQL.add('/*3-9*/ update IGNORE tblparts 									 Trans  Set PartsId=0 Where ifnull(Trans.PartsId		,0)=0;');
    SQL.add('/*3-10*/update IGNORE tblPurchaselines 					 Trans  Set ProductId=0 Where ifnull(Trans.ProductId	,0)=0;');
    SQL.add('/*3-11*/update IGNORE tblsaleslines 						 Trans  Set ProductId=0 Where ifnull(Trans.ProductId	,0)=0;');
    SQL.add('/*3-12*/update IGNORE tblstockadjustentrylines 	 Trans  Set ProductId=0 Where ifnull(Trans.ProductId	,0)=0;');
    SQL.add('/*3-13*/update IGNORE tblstocktransferentrylines Trans  Set ProductId=0 Where ifnull(Trans.ProductId	,0)=0;');
    SQL.add('/*3-14*/update IGNORE tblStockmovementlines 		 Trans  Set ProductId=0 Where ifnull(Trans.ProductId	,0)=0;');

    SQL.add('/*4*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Tree"  						 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UnitOfMeasureId 	as TransUOMID, Trans.UnitOfMeasureMultiplier  as TransUOM'+' From tblproctreepart 					 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitOfMeasure 				 and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.UnitOfMeasureId  ;');
    SQL.add('/*5*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Extra Buy Price"   as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UOMId 						as TransUOMID, Trans.UOMMultiplier  					as TransUOM'+' From tblextraprice 						 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM 									 and U.PartID =  Trans.PartsID		 '+'  Where U.UnitID <> Trans.UOMId 					 ;');
    SQL.add('/*6*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Extra Sell Price"  as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UOMId 						as TransUOMID, Trans.UOMMultiplier  					as TransUOM'+' From tblextrapricesell 				 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM 									 and U.PartID =  Trans.PartsID		 '+'  Where U.UnitID <> Trans.UOMId 					 ;');
    SQL.add('/*7*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Foreign buy Price" as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UOMId 						as TransUOMID, Trans.UOMMultiplier  					as TransUOM'+' From tblforeignprice 					 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM 									 and U.PartID =  Trans.PartsID		 '+'  Where U.UnitID <> Trans.UOMId 					 ;');
    SQL.add('/*8*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Tree"  						 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.TreePartUOMID 		as TransUOMID, Trans.TreePartUOMMultiplier 		as TransUOM'+' From tblproctree 							 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.TreePartUOM 					 and U.PartID =  Trans.PartsId		 '+'  Where U.UnitID <> Trans.TreePartUOMID 	 ;');
    SQL.add('/*9*/ insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Products"  				 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.ProductUOMID 		as TransUOMID, NULL 													as TransUOM'+' From tblparts 									   Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.ProductUOM 						 and U.PartID =  Trans.PartsId		 '+'  Where U.UnitID <> Trans.ProductUOMID 	   ;');
    SQL.add('/*10*/insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"PO"  							 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UnitOfMeasureId 	as TransUOMID, Trans.UnitofMeasureMultiplier 	as TransUOM'+' From tblPurchaselines 					 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitofMeasurePOLines 	 and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.UnitOfMeasureId  ;');
    SQL.add('/*11*/insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Sales"  					 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.UnitOfMeasureId 	as TransUOMID, Trans.UnitOfMeasureMultiplier 	as TransUOM'+' From tblsaleslines 						 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitofMeasureSaleLines and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.UnitOfMeasureId  ;');
    SQL.add('/*12*/insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Adjustments"			 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.uomid 						as TransUOMID, Trans.UOMMultiplier 						as TransUOM'+' From tblstockadjustentrylines 	 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.uom 									 and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.uomid 					 ;');
    SQL.add('/*13*/insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Transfers"				 as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.uomid 						as TransUOMID, Trans.UOMMultiplier 						as TransUOM'+' From tblstocktransferentrylines Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.uom 									 and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.uomid 					 ;');
    SQL.add('/*14*/insert ignore into  ' + fstablename +' ( PartID,Description,UnitName,Multiplier,UnitID,TransUOMID,TransUOM)'+' Select Distinct U.PartID,"Stock Movements"   as Description , U.UnitName , U.Multiplier ,U.UnitID , Trans.uomid 						as TransUOMID, Trans.UOMMultiplier 						as TransUOM'+' From tblStockmovementlines 		 Trans  inner join  tblunitsofmeasure U on U.UnitName = Trans.uom 									 and U.PartID =  Trans.ProductId	 '+'  Where U.UnitID <> Trans.uomid            ;');
    showProgressbar(waitmsg+' - Populating UOM Mismatch List', SQL.Count);
    try
      clog(SQL.text);
      Execute;
    finally
      HideProgressbar;
    end;
  end;
  inherited;
end;

procedure TDU_UOMMismatchGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
  //RemoveFieldfromGrid(qrymainunitid.fieldname);
  RemoveFieldfromGrid(qrymaintransuom.fieldname);
end;

procedure TDU_UOMMismatchGUI.UOMMismatchFix;
var
  aTableName :String;
begin
  with scriptmain do begin
    SQL.clear;
    aTableName := FixTableName('tblProcTreePart', '');
    SQL.add('/*1*/Create table if not exists ' +aTableName+' like tblproctreepart; insert ignore into ' + aTableName +' Select * from tblproctreepart;');
    SQL.add('/*2*/update IGNORE tblproctreepart Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitOfMeasure and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.UnitOfMeasureId = U.UnitID /*, Trans.UnitOfMeasureMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UnitOfMeasureId;');
    SQL.add('/*2-1*/Delete Trans.* from tblproctreepart Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitOfMeasure and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' where U.UnitID <> Trans.UnitOfMeasureId;');
    aTableName :=FixTableName('tblextraprice', '');
    SQL.add('/*3*/Create table if not exists  ' +aTableName+' Like tblextraprice; insert ignore into ' + aTableName +' Select * from tblextraprice;');
    SQL.add('/*4*/update IGNORE tblextraprice Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' Set Trans.UOMID = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UOMId;');
    SQL.add('/*4-1*/delete trans.* from tblextraprice Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' where U.UnitID <> Trans.UOMId;');
    aTableName :=FixTableName('tblextrapricesell', '');
    SQL.add('/*5*/Create table if not exists  ' +aTableName+' Like tblextrapricesell; insert ignore into ' + aTableName +' Select * from tblextrapricesell;');
    SQL.add('/*6*/update IGNORE tblextrapricesell Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' Set Trans.UOMID = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UOMId;');
    SQL.add('/*6-1*/delete trans.* from tblextrapricesell Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' where U.UnitID <> Trans.UOMId;');
    aTableName :=FixTableName('tblforeignprice', '');
    SQL.add('/*7*/Create table if not exists  ' +aTableName+' Like tblforeignprice; insert ignore into ' + aTableName +' Select * from tblforeignprice;');
    SQL.add('/*8*/update IGNORE tblforeignprice Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' Set Trans.UOMID = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UOMId;');
    SQL.add('/*8-1*/Delete trans.* from tblforeignprice Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UOM and U.PartID =  ifnull(Trans.PartsID,0) '+
                ' where U.UnitID <> Trans.UOMId;');
    aTableName :=FixTableName('tblproctree', '');
    SQL.add('/*9*/Create table if not exists  ' +aTableName+' Like tblproctree; insert ignore into ' + aTableName +' Select * from tblproctree;');
    SQL.add('/*10*/update IGNORE tblproctree Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.TreePartUOM and U.PartID =  ifnull(Trans.PartsId,0) '+
                ' Set Trans.TreePartUOMID = U.UnitID /*, Trans.TreePartUOMMultiplier= U.Multiplier*/ '+
                ' where U.UnitID <> Trans.TreePartUOMID;');
    aTableName :=FixTableName('tblparts', '');
    SQL.add('/*11*/Create table if not exists  ' +aTableName+' Like tblparts; insert ignore into ' + aTableName +' Select * from tblparts;');
    SQL.add('/*12*/update IGNORE tblparts Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.ProductUOM and U.PartID =  ifnull(Trans.PartsId,0) '+
                ' Set Trans.ProductUOMID = U.UnitID '+
                ' where U.UnitID <> Trans.ProductUOMID;');
    aTableName :=FixTableName('tblPurchaselines', '');
    SQL.add('/*13*/Create table if not exists  ' +aTableName+' Like tblPurchaselines; insert ignore into ' + aTableName +' Select * from tblPurchaselines;');
    SQL.add('/*14*/update IGNORE tblPurchaselines Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitofMeasurePOLines and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.UnitOfMeasureID = U.UnitID /*, Trans.UnitofMeasureMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UnitOfMeasureId;');
    aTableName :=FixTableName('tblsaleslines', '');
    SQL.add('/*15*/Create table if not exists  ' +aTableName+' Like tblsaleslines; insert ignore into ' + aTableName +' Select * from tblsaleslines;');
    SQL.add('/*16*/update IGNORE tblsaleslines Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.UnitofMeasureSaleLines and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.UnitOfMeasureId = U.UnitID /*, Trans.UnitOfMeasureMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.UnitOfMeasureId;');
    aTableName :=FixTableName('tblstockadjustentrylines', '');
    SQL.add('/*17*/Create table if not exists  ' +aTableName+' Like tblstockadjustentrylines; insert ignore into ' + aTableName +' Select * from tblstockadjustentrylines;');
    SQL.add('/*18*/update IGNORE tblstockadjustentrylines Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.uom and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.uomid = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.uomid;');
    aTableName :=FixTableName('tblstocktransferentrylines', '');
    SQL.add('/*19*/Create table if not exists  ' +aTableName+' Like tblstocktransferentrylines; insert ignore into ' + aTableName +' Select * from tblstocktransferentrylines;');
    SQL.add('/*20*/update IGNORE tblstocktransferentrylines Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.uom and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.uomid = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.uomid;');
    aTableName :=FixTableName('tblStockmovementlines', '');
    SQL.add('/*21*/Create table if not exists  ' +aTableName+' Like tblStockmovementlines; insert ignore into ' + aTableName +' Select * from tblStockmovementlines;');
    SQL.add('/*22*/update IGNORE tblStockmovementlines Trans '+
                ' inner join  tblunitsofmeasure U on U.UnitName = Trans.uom and U.PartID =  ifnull(Trans.ProductId,0) '+
                ' Set Trans.uomid = U.UnitID /*, Trans.UOMMultiplier = U.Multiplier*/ '+
                ' where U.UnitID <> Trans.uomid;');
    aTableName :=FixTableName('tblPQa', '');
    SQL.add('/*23*/Create table if not exists  ' +aTableName+' Like tblPQa; insert ignore into ' + aTableName +' Select * from tblPQa;');
    SQL.add('/*24*/update IGNORE tblpqa pqa inner join tblpurchaselines PL on PQa.transId = pl.purchaseorderID and PQa.translineid = PL.purchaselineId and pqa.transtype = "TPurchaseOrderLine" '+
                ' set pqa.UOM = PL.UnitofMeasurePOLines , pqa.UOMMultiplier = PL.UnitofMeasureMultiplier , pqa.UOMID = PL.UnitOfMeasureId '+
                ' where pqa.UOMID <> PL.UnitOfMeasureId ;');
    SQL.add('/*25*/update IGNORE tblpqa pqa  '+
                ' inner join tblsaleslines SL on PQa.transId = SL.saleId and PQa.translineid = SL.SaleLineID and pqa.transtype in ("TInvoiceLine" , "TSalesOrderline" , "TRefundSaleLine" , "TPOSCashSaleline" , "TPOSLaybylines" , "TCashSaleLine") '+
                ' set pqa.UOM = SL.UnitofMeasureSaleLines , pqa.UOMMultiplier = SL.UnitofMeasureMultiplier , pqa.UOMID = SL.UnitOfMeasureId '+
                ' where pqa.UOMID <> SL.UnitOfMeasureId ;');
    SQL.add('/*26*/update IGNORE tblproctreepart ptp inner join tblPQa PQa on PQa.TransLineID = ptp.ProcTreePartId and pqa.transtype in ( "TProcTreePart" ,  "TProcTreePartIN" ) '+
                ' set pqa.UOM = ptp.UnitOfMeasure , pqa.UOMMultiplier = ptp.UnitOfMeasureMultiplier , pqa.UOMID = ptp.UnitOfMeasureId '+
                ' where pqa.UOMID <> ptp.UnitOfMeasureId;');
    SQL.add('/*27*/update IGNORE tblpqa pqa inner join tblstockmovementlines SL on PQa.transId = SL.StockmovementID and PQa.translineid = SL.StockmovementLinesID and pqa.transtype in ("TStockMovementLines") '+
                ' set pqa.UOM = SL.UOM, pqa.UOMMultiplier = SL.UOMMultiplier, pqa.UOMID = SL.UOMID '+
                ' where pqa.UOMID <> SL.UOMID;');
    ShowProgressbar(WAITMSG , SQL.Count);
    try
      clog(SQL.text);
      Execute;
    finally
      hideProgressbar;
    end;
    RefreshQuery;
  end;

end;

initialization
  RegisterClassOnce(TDU_UOMMismatchGUI);
end.
