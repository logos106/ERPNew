unit BOMnPPGQtyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMnPPGQtyListGUI = class(TBaseListingGUI)
    qryMaintype: TLargeintField;
    qryMainID: TIntegerField;
    qryMainsaleId: TIntegerField;
    qryMainpqa_ptpinPQAID: TIntegerField;
    qryMainpqa_ptpoutPQAID: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainSaleProductID: TIntegerField;
    qryMainSaleProductName: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainProctreeId: TIntegerField;
    qryMainParentID: TIntegerField;
    qryMainHasChildren: TWideStringField;
    qryMainqtysold: TFloatField;
    qryMainshipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainNodecaption: TWideStringField;
    qryMainproductID: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainProctreePartID: TIntegerField;
    qryMainPTPqty: TFloatField;
    qryMainManufacturedQty: TFloatField;
    qryMainManufacturingQty: TFloatField;
    qryMainPTPuomqty: TFloatField;
    qryMainpqa_ptpoutqty: TFloatField;
    qryMainpqa_ptpoutuomqty: TFloatField;
    qryMainpqa_ptpinqty: TFloatField;
    qryMainpqa_ptpinuomqty: TFloatField;
    qryMainpqa_ppgoutqty: TFloatField;
    qryMainpqa_ppgoutuomqty: TFloatField;
    qryMainpqa_ppginqty: TFloatField;
    qryMainpqa_ppginuomqty: TFloatField;
    qryMainptpnppgout: TFloatField;
    qryMainptpnpggin: TFloatField;
    btnFix: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnFixClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsTablename :String;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, MySQLConst, tcConst, LogLib, SharedObjs , math;

{$R *.dfm}

procedure TBOMnPPGQtyListGUI.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('BOMnPPGQtyList');
//  Qrymain.sql.Text := 'Select * from ' + fsTablename ;
  Qrymain.sql.clear;
  Qrymain.sql.add('select ');
  Qrymain.sql.add('1 as type,  ');
  Qrymain.sql.add('T.* , ');
  Qrymain.sql.add('pqa_ptpoutqty  + pqa_ppgoutqty as ptpnppgout,');
  Qrymain.sql.add('pqa_ptpinqty  + pqa_ppginqty as ptpnpggin');
  Qrymain.sql.add('from '+ fstablename +' T  ');
  //Qrymain.sql.add('where Parentid=0 and round(ptpqty,5)< round(pqa_ppginqty,5)  ');
  Qrymain.sql.add('where Parentid=0 and round(ptpqty,5)< round(pqa_ptpinqty,5)  + round(pqa_ppginqty,5) ');
  Qrymain.sql.add('union ');
  Qrymain.sql.add('select  ');
  Qrymain.sql.add('2 as type,  ');
  Qrymain.sql.add('T.* , ');
  Qrymain.sql.add('pqa_ptpoutqty  + pqa_ppgoutqty as ptpnppgout,');
  Qrymain.sql.add('pqa_ptpinqty  + pqa_ppginqty as ptpnpggin');
  Qrymain.sql.add('from '+ fstablename +' T  ');
  Qrymain.sql.add('where (Parentid<>0 and round(ptpqty,5)< round(pqa_ptpoutqty,5)  + round(pqa_ppgoutqty,5)) or (HasChildren ="T" and round(ptpqty,5)< round(pqa_ptpinqty,5)  + round(pqa_ppginqty,5) ) ');
  Qrymain.sql.add('Order by SaleId desc , saleLineId, sequencedown');
  clog(Qrymain.sql.text);
  inherited;
  EnableMultiSelect('Please Choose Records To Fix');
end;

procedure TBOMnPPGQtyListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;

end;

procedure TBOMnPPGQtyListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
       if (qrymaintype.asInteger = 1) and sametext(Field.fieldname, qrymainptpqty.fieldname)        then Doredhighlight(AFont, ABrush)
  else if (qrymaintype.asInteger = 1) and sametext(Field.fieldname, qrymainpqa_ppginqty.fieldname)  then Doredhighlight(AFont, ABrush)
  else if (qrymaintype.asInteger = 2) and sametext(Field.fieldname, qrymainptpqty.fieldname)        then Doredhighlight(AFont, ABrush)
  else if (qrymaintype.asInteger = 2) and sametext(Field.fieldname, qrymainptpnppgout.fieldname)    then Doredhighlight(AFont, ABrush)
  else if (qrymaintype.asInteger = 2) and sametext(Field.fieldname, qrymainptpnpggin.fieldname)     then Doredhighlight(AFont, ABrush);

end;


procedure TBOMnPPGQtyListGUI.RefreshQuery;
begin
  with scriptmain do begin
    SQL.clear;
    SQL.add('/*1*/	drop table if exists '+ fstablename +';');
    SQL.add('/*2*/	CREATE TABLE '+ fstablename +' ( ' +
              ' ID INT(11) NOT NULL AUTO_INCREMENT,  ' +
              ' saleId INT(11) NULL DEFAULT 0, ' +
              ' saleLineId INT(11) NULL DEFAULT 0, ' +
              ' SaleProductID INT(11) NULL DEFAULT 0, ' +
              ' SaleProductName VARCHAR(60) NULL DEFAULT NULL, ' +
              ' Converted ENUM("T","F") default "F", ' +
              ' ProctreeId Int(11) null default 0, ' +
              ' ParentID Int(11) null default 0, ' +
              ' SequenceDown Int(11) null default 0, ' +
              ' HasChildren enum("T","F") default "F", ' +
              ' qtysold DOUBLE NULL DEFAULT 0, ' +
              ' shipped DOUBLE NULL DEFAULT 0, ' +
              ' backorder DOUBLE NULL DEFAULT 0, ' +
              ' UnitofMeasureQtySold DOUBLE NULL DEFAULT 0, ' +
              ' UnitofMeasureShipped DOUBLE NULL DEFAULT 0, ' +
              ' UnitofMeasureBackorder DOUBLE NULL DEFAULT 0, ' +
              ' UOM VARCHAR(279) NULL DEFAULT NULL, ' +
              ' Nodecaption VARCHAR(255) NULL DEFAULT NULL, ' +
              ' productID INT(11) NULL DEFAULT 0, ' +
              ' productname VARCHAR(60) NULL DEFAULT NULL, ' +
              ' ProctreePartID INT(11) NULL DEFAULT 0, ' +
              ' PTPqty                 DOUBLE NULL DEFAULT 0, ' +
              ' PTPuomqty             DOUBLE NULL DEFAULT 0, ' +

              ' ManufacturedQty                 DOUBLE NULL DEFAULT 0, ' +
              ' ManufacturingQty                DOUBLE NULL DEFAULT 0, ' +

              ' pqa_ptpoutPQAID int(11) Null DEFAULT 0,'+
              ' pqa_ptpoutqty             DOUBLE NULL DEFAULT 0, ' +
              ' pqa_ptpoutuomqty          DOUBLE NULL DEFAULT 0, ' +

              ' pqa_ptpinPQAID int(11) Null DEFAULT 0,'+
              ' pqa_ptpinqty               DOUBLE NULL DEFAULT 0, ' +
              ' pqa_ptpinuomqty           DOUBLE NULL DEFAULT 0, ' +

              ' pqa_ppgoutqty             DOUBLE NULL DEFAULT 0, ' +
              ' pqa_ppgoutuomqty          DOUBLE NULL DEFAULT 0, ' +

              ' pqa_ppginqty              DOUBLE NULL DEFAULT 0, ' +
              ' pqa_ppginuomqty           DOUBLE NULL DEFAULT 0, ' +

              ' PRIMARY KEY (ID),	INDEX ProctreePartID (ProctreePartID),	INDEX productID (productID) , index ProctreeId (ProctreeId), index ParentID (ParentID)) COLLATE="utf8_general_ci" ENGINE=Myisam;');

    SQL.add('/*3*/	insert ignore into '+ fstablename +' (saleId , saleLineId, SaleProductID, SaleProductName, Converted, qtysold, shipped, backorder, UnitofMeasureQtySold , UnitofMeasureShipped ,UnitofMeasureBackorder , ' +
              ' UOM  ,Nodecaption, ProctreeId, ParentID,SequenceDown, productID , productname , ProctreePartID,ptpqty,ManufacturedQty,ManufacturingQty,ptpuomqty) ' +
              ' Select distinct s.saleId , sl.saleLineId, sl.productId as SaleProductID, sl.productname as SaleProductName, S.converted , ' +
              ' SL.qtysold, SL.shipped, SL.backorder, ' +
              ' SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped ,SL.UnitofMeasureBackorder , ' +
              ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM  , ' +
              ' TreeNodeCaption(PT.Level, PT.Caption) Nodecaption, PT.proctreeID,PT.ParentID,PT.SequenceDown, PTP.productID , ptp.productname , PTP.ProctreePartID,PTP.qty,PTP.ManufacturedQty, PTP.ManufacturingQty,PTP.uomqty ' +
              ' from tblsales S ' +
              ' inner join tblsaleslines SL  on S.saleId = sl.saleID ' +
              ' inner join tblproctree PT on PT.masterId = SL.salelineId and PT.MasterType <> "mtProduct" ' +
              ' inner join tblproctreePart PTP on PT.ProcTreeId = PTP.proctreeId ' +
              ' Where S.SaleDate between ' + quotedstr(formatdatetime(Mysqldatetimeformat , filterDatefrom))+ ' and ' + quotedstr(formatdatetime(Mysqldatetimeformat , filterdateto))+
              ' Order by s.saleID desc, sl.saleLineId, PT.SequenceDown ;');

    //SQL.add('/*4*/	update '+ fstablename +' T1 set HasChildren = if((select count(*) from tblproctree where ifnull(PArentID,0) = T1.proctreeId) >1 , "T" , "F");');
    SQL.add('/*4*/	update '+ fstablename +' T1 set HasChildren = if((select count(*) from tblproctree where not(PArentID is null ) and PArentID = T1.proctreeId) >1 , "T" , "F");');

    SQL.add('/*5*/	update tblpqa pqa inner join '+ fstablename +' T on pqa.TransLineID = T.proctreepartId and pqa.transtype ="TProcTreePart" and pqa.alloctype ="OUT" ' +
              ' Set T.pqa_ptpoutqty = pqa.Qty , T.pqa_ptpoutuomqty = pqa.uomQty , T.pqa_ptpoutPQAID = PQA.PQAID;');

    SQL.add('/*6*/	update tblpqa pqa inner join '+ fstablename +' T on pqa.TransLineID = T.proctreepartId and pqa.transtype in ("TProcTreePartIN" , "TProcTreePart")  and pqa.alloctype ="IN" ' +
              ' Set T.pqa_ptpinqty = pqa.Qty , T.pqa_ptpinuomqty = pqa.uomQty , T.pqa_ptpinPQAID = Pqa.pqaID;');


    SQL.add('/*7*/	drop table if exists '+ fstablename +'1;');
    SQL.add('/*8*/	create table '+ fstablename +'1 ' +
              ' Select ' +
              ' ppg.ProctreePartID , pqa.TransType , sum(pqa.qty) qty , sum(pqa.uomqty) as uomqty ' +
              ' from '+ fstablename +' T ' +
              ' inner join tblprocprogress ppg on T.ProctreePartID = ppg.ProctreePartID and ppg.alloctype ="OUT"  and ppg.Buildstatus in ("D","B", "W")' +
              ' inner join tblpqa pqa on pqa.TransLineID = ppg.ProcProgressID and pqa.TransType = "TProcProgressOUT" ' +
              ' group by ppg.ProctreePartID ' +
              ' union all ' +
              ' Select ' +
              ' ppg.ProctreePartID , pqa.TransType , sum(pqa.qty) qty , sum(pqa.uomqty) as uomqty ' +
              ' from '+ fstablename +' T ' +
              ' inner join tblprocprogress ppg on T.ProctreePartID = ppg.ProctreePartID and ppg.alloctype ="IN"   and ppg.Buildstatus in ("D","B")' +
              ' inner join tblpqa pqa on pqa.TransLineID = ppg.ProcProgressID and pqa.TransType = "TProcProgressIn" ' +
              ' group by ppg.ProctreePartID ;');
    SQL.add('/*9*/	ALTER TABLE '+ fstablename +'1 ' +
              ' ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST, ' +
              ' ADD PRIMARY KEY (ID), ' +
              ' ADD INDEX ProctreePartID (ProctreePartID);');

    SQL.add('/*10*/	update '+ fstablename +' T1 inner join '+ fstablename +'1 T2 on T1.ProctreePartID = T2.ProctreePartID and T2.TransType = "TProcProgressOUT" ' +
              ' Set T1.pqa_ppgoutqty = T2.qty , T1.pqa_ppgoutuomqty = T2.uomqty; ');

    SQL.add('/*11*/	update '+ fstablename +' T1 inner join '+ fstablename +'1 T2 on T1.ProctreePartID = T2.ProctreePartID and T2.TransType = "TProcProgressIN" ' +
              ' Set T1.pqa_ppginqty = T2.qty , T1.pqa_ppginuomqty = T2.uomqty;');

    SQL.add('/*12*/	drop table if exists '+ fstablename +'1;');
    SQL.add('/*13-1*/	update '+ fstablename +' set Parentid        = 0 where Parentid         is null;');
    SQL.add('/*13-2*/	update '+ fstablename +' set ptpqty          = 0 where ptpqty           is null;');
    SQL.add('/*13-2*/	update '+ fstablename +' set ManufacturedQty = 0 where ManufacturedQty  is null;');
    SQL.add('/*13-2*/	update '+ fstablename +' set ManufacturingQty= 0 where ManufacturingQty is null;');
    SQL.add('/*13-3*/	update '+ fstablename +' set pqa_ppginqty    = 0 where pqa_ppginqty     is null;');
    SQL.add('/*13-4*/	update '+ fstablename +' set pqa_ptpoutqty   = 0 where pqa_ptpoutqty    is null;');
    SQL.add('/*13-5*/	update '+ fstablename +' set pqa_ppgoutqty   = 0 where pqa_ppgoutqty    is null;');
    SQL.add('/*13-6*/	update '+ fstablename +' set pqa_ptpinqty    = 0 where pqa_ptpinqty     is null;');
    SQL.add('/*13-7*/	update '+ fstablename +' set pqa_ppginqty    = 0 where pqa_ppginqty     is null;');
    SQL.add('/*13-7*/	update '+ fstablename +' set pqa_ptpinPQAID  = 0 where pqa_ptpinPQAID   is null;');
    SQL.add('/*13-7*/	update '+ fstablename +' set pqa_ptpoutPQAID = 0 where pqa_ptpoutPQAID  is null;');
    Doshowprogressbar(SQL.count,WAITMSG);
    try
      logtext(SQL.text);
      execute;
    finally
      DohideProgressbar;
    end;
  end;
  inherited;
end;

procedure TBOMnPPGQtyListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainpqa_ptpinPQAID.fieldname);
  RemoveFieldfromGrid(qryMainpqa_ptpoutPQAID.fieldname);
end;

procedure TBOMnPPGQtyListGUI.btnFixClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  try
    if qrymain.recordcount =0 then exit;

    if SelectedRecords =0 then
        if MessageDlgXP_Vista('You Have not Selected the Records to Fix. Do you Want to Select All in the List? ', mtConfirmation, [mbYes, mbNo], 0)= mrno then exit
        else grdmain.SelectAll;

    if SelectedRecords =0 then exit;


    With ScriptMain do begin
        // create erpfix table outside transaction
        SQL.clear;
        SQL.Add(ERPFixtableSQL('tblproctreepart'));
        SQL.Add(ERPFixtableSQL('tblpqa'));
        SQL.Add(ERPFixtableSQL('tblprocprogress'));
        SQL.Add(ERPFixtableSQL('tblpqadetails'));
        showProgressbar(WAITMSG, SQL.count);
        try
          Execute;
        finally
          HideProgressbar;
        end;
        SQL.clear;
    end;

    {update within transaction}
    With ScriptMainInTrans do begin
    try
        SQL.clear;
        SQL.add('Drop table if exists tmp_1;');
        SQL.add('create table tmp_1 like  tblprocprogress ;');
        SQL.add('insert ignore into tmp_1 Select ppg.* from tblprocprogress ppg ' +
                ' where ppg.alloctype ="OUT" and (ifnull(ppg.InProcProgressId,0)=0 ' +
                ' or ppg.InProcProgressId not in (Select ProcProgressId from tblprocprogress ppg1));');

        SQL.add('delete pqa.* ' +
                ' from tmp_1 ppg ' +
                ' inner join tblpqa pqa on ppg.ProcProgressID = pqa.TransLineID and pqa.TransType like "TProcProgressOUT%";');

        SQL.add('delete ppg.* ' +
                ' from  tblprocprogress ppg ' +
                ' inner join tmp_1 T on ppg.procprogressid = T.procprogressid;');
        SQL.add('Drop table if exists tmp_1;');


        (*SQL.add('create table tmp_1 ' +
                ' select inprocprogressid  , sum(Productunitcost*qty) sumProductunitcost from tblprocprogress where alloctype ="OUT" group by inprocprogressid;');

        SQL.add('drop table if exists tmp_2;');
        SQL.add('create table tmp_2 ' +
                ' select ppg.ProcProgressID,  ppg.ProductUnitCost , T.sumProductunitcost ' +
                ' from tblprocprogress ppg inner join tmp_1 T on ppg.ProcProgressID = t.inprocprogressid ' +
                ' where round(ppg.ProductUnitCost , 5) <> round(T.sumProductunitcost, 5);');

        SQL.add('update tblprocprogress  ppg inner join tmp_2 t on ppg.ProcProgressID = t.ProcProgressID Set ppg.ProductUnitCost = T.sumProductunitcost ' +
                ' where round(ppg.ProductUnitCost , 5) <> round(T.sumProductunitcost, 5);');
        SQL.add('drop table if exists tmp_1;');
        SQL.add('drop table if exists tmp_2;');*)

        SQL.add('create table tmp_1 like tblprocprogress ;');
        SQL.add('insert ignore into tmp_1 ' +
                ' select ppg.* from tblprocprogress ppg left join tblprocprogress  ppgc on ppg.procprogressid = ppgc.InProcProgressId ' +
                ' where  ppg.alloctype ="IN" and ifnull(ppgc.ProcProgressID,0)=0;');
        SQL.add('delete ppg.* from tblprocprogress ppg inner join tmp_1 t on ppg.ProcProgressID = T.procprogressid;');
        SQL.add('delete pqad.* from tblpqadetails pqad where pqaid not in (select pqaid from  tblpqa);');

        IterateProcno := 1;
        IterateSelectedRecords(true);
            showProgressbar(WAITMSG, SQL.count);
            try
              ScriptMainBeginTrans;
              try
                clog(SQL.Text);
                Execute;
                ScriptMainCommit;
                RefreshQuery;
              Except
                  on E:Exception do begin
                      ScriptMainrollback;
                  end;
              end;
            finally
              HideProgressbar;
              UserLock.UnlockAllCurrentInstance;
            end;
      finally
        ScrptMainCleanConn;
      end;
    end;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TBOMnPPGQtyListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
    if UserLock.Lock('tblsales' , QrymainsaleID.asInteger) then begin
      //if not samevalue (qrymainptpqty.asFloat , qrymainpqa_ptpoutQty.asfloat + qrymainpqa_ppgoutQty.asfloat , 0.00) then sctmain.sql.add('update tblproctreepart set Qty = ' + Floattostr(qrymainpqa_ptpoutQty.asfloat) + '+' + Floattostr(qrymainpqa_ppgoutQty.asfloat)+' where ProcTreePartId =' + inttostr(qrymainProcTreePartId.AsInteger)+';');
      //if not samevalue (qrymainptpqty.asFloat , qrymainpqa_ptpinQty.asfloat  + qrymainpqa_ppginQty.asfloat  , 0.00) then sctmain.sql.add('update tblproctreepart set Qty = ' + Floattostr(qrymainpqa_ptpinQty.asfloat)  + '+' + Floattostr(qrymainpqa_ppginQty.asfloat) +' where ProcTreePartId =' + inttostr(qrymainProcTreePartId.AsInteger )+';');
      if not samevalue (qrymainptpqty.asFloat , qrymainpqa_ptpoutQty.asfloat + qrymainpqa_ppgoutQty.asfloat , 0.00) and (qrymainpqa_ptpoutPQAID.asInteger<>0) then begin
        sctmain.sql.add('update tblpqa set Qty = ' + Floattostr(qrymainptpqty.asfloat) + '-' + Floattostr(qrymainpqa_ppgoutQty.asfloat)+' where pqaid =' + inttostr(qryMainpqa_ptpoutPQAID.AsInteger)+';');
        sctmain.sql.add('update tblproctreepart set ManufacturingQty = ' + Floattostr(qrymainpqa_ppgoutQty.asfloat)+' where ProcTreePartId =' + inttostr(qrymainProcTreePartId.AsInteger)+';');
      end;
      if not samevalue (qrymainptpqty.asFloat , qrymainpqa_ptpinQty.asfloat  + qrymainpqa_ppginQty.asfloat  , 0.00) and (qryMainpqa_ptpinPQAID.asInteger<>0) then begin
        sctmain.sql.add('update tblpqa set Qty = ' + Floattostr(qrymainptpqty.asfloat) + '-' + Floattostr(qrymainpqa_ppginQty.asfloat)+' where pqaid =' + inttostr(qryMainpqa_ptpinPQAID.AsInteger)+';');
        sctmain.sql.add('update tblproctreepart set ManufacturedQty = ' + Floattostr(qrymainpqa_ppginQty.asfloat)+' where ProcTreePartId =' + inttostr(qrymainProcTreePartId.AsInteger)+';');
      end;
    end;
  end;
end;


initialization
  RegisterClassOnce(TBOMnPPGQtyListGUI);

end.
