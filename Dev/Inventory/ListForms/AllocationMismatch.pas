unit AllocationMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TAllocationMismatchGUI = class(TBaseListingGUI)
    qryMainSeqNo: TLargeintField;
    qryMainbatch: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainsntracking: TWideStringField;
    qryMainDepartmentId: TIntegerField;
    qryMainuomid: TIntegerField;
    qryMainpartsId: TIntegerField;
    qryMainPARTNAME: TWideStringField;
    qryMainbatchno: TWideStringField;
    qryMainexpirydate: TDateTimeField;
    qryMainbinlocation: TWideStringField;
    qryMainbinnumber: TWideStringField;
    qryMainserialnumber: TWideStringField;
    qryMainqty: TFloatField;
    qryMainuomqty: TFloatField;
    qryMainbatchtotal: TFloatField;
    qryMainbintotal: TFloatField;
    qryMainsntotal: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure SctMainAfterExecute(Sender: TObject; SQL: string);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure cmdNewClick(Sender: TObject);
  private
    tablename :STring;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, ProductQtyLib, LogLib, CommonLib, tcConst, PQALib;

{$R *.dfm}

{ TAllocationMismatchGUI }

procedure TAllocationMismatchGUI.cmdNewClick(Sender: TObject);
begin
  //inherited;

end;

procedure TAllocationMismatchGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('AllocationMismatch');
  Qrymain.SQL.Text := 'Select * from ' +tablename;
  inherited;

end;

procedure TAllocationMismatchGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TAllocationMismatchGUI.RefreshQuery;
begin
  clog('');
  closedb(Qrymain);
  With Scriptmain do try
      SQL.Add('/*1*/ Drop table if exists ' + Tablename +'_1;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*2*/ Create table ' + Tablename +'_1 ' + ProductQtyLib.SQL4ProductAvailableQty(now ,  '',  tDetailswithSno, 0 , 0, '', 0, '','','',tavailable, 'PQA.UOM,pqa.uomid','P.batch="T" or P.multiplebins="T" or P.SNTracking ="T"',0,true, False, False)+';'); (*logtext(SQL.text);execute;SQL.clear;*)
      (*SQL.Add('/*2*/Create table ' + Tablename +'_1 ' +
                  ' SELECT ' +
                  ' P.batch,P.MultipleBins,P.sntracking, ' +
                  ' PQA.DepartmentID , PQA.uomId, P.PartsID,  P.PARTNAME , PC.PreferredLevel, ' +
                  ' PQA.UOM, ' +
                  ' PQABatch.Value as Batchno, ' +
                  ' PQABatch.ExpiryDate , ' +
                  ' PBin.Binlocation , ' +
                  ' PBin.Binnumber , ' +
                  ' PBin.binId,concat(PBin.Binlocation ,PBin.Binnumber ) as BinLocNum, ' +
                  ' PQASN.Value as Serialnumber , ' +
                  ' Round(Sum( if(PQA.transtype ="TSalesOrderInvoiceLines" , 0, if (PQA.TransType ="TSalesOrderInvoiceLines" and PQA.Active ="F" ,0 ,   ' +
                  ' if(PQA.Active ="F" and  PQA.alloctype ="IN" and PQA.TransType in ("TProcTreePart","TProcTreePartIN"), ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 ,  ' +
                  ' PQASN.Qty, if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.Qty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty     ,0 ))),0),  if((PQA.Active ="F")  ' +
                  ' and  (not(PQA.TransType in ("TProcTreePart","TProcTreePartIN")) OR ((PQA.TransType="TProcTreePart") and (PQA.alloctype ="IN")) ), 0,  if( PQA.alloctype="IN"  ' +
                  ' and  PQA.ISBo="F", ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 , PQASN.Qty, if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.Qty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 ,  ' +
                  ' PQABatch.Qty     ,0 ))),0),  if(PQA.alloctype="OUT" and (PQA.TransType<>"TSalesOrderLine" or PQA.ISBO="F") ,0-ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 ,  ' +
                  ' PQASN.Qty, if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.Qty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty     ,0 ))),0),0))))))),5) as Qty, ' +
                  ' Round(Sum( if(PQA.transtype ="TSalesOrderInvoiceLines" , 0, if (PQA.TransType ="TSalesOrderInvoiceLines" and PQA.Active ="F" ,0 ,  if(PQA.Active ="F" and   ' +
                  ' PQA.alloctype ="IN" and PQA.TransType in ("TProcTreePart","TProcTreePartIN"), ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 , PQASN.UOMQty,  ' +
                  ' if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.UOMQty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty     ,0 ))),0),  if((PQA.Active ="F")  ' +
                  ' and  (not(PQA.TransType in ("TProcTreePart","TProcTreePartIN")) OR ((PQA.TransType="TProcTreePart") and (PQA.alloctype ="IN")) ), 0,  if( PQA.alloctype="IN"  ' +
                  ' and  PQA.ISBo="F", ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 , PQASN.UOMQty, if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.UOMQty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 ,  ' +
                  ' PQABatch.UOMQty     ,0 ))),0),  if(PQA.alloctype="OUT" and (PQA.TransType<>"TSalesOrderLine" or PQA.ISBO="F") ,0-ifnull(if(ifnull(PQASN.PQAdetailID,0)   <> 0 ,  ' +
                  ' PQASN.UOMQty, if(ifnull(PQABins.PQAdetailID,0)  <> 0 , PQABins.UOMQty, if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty     ,0 ))),0),0))))))),5) as UOMQty ' +
                  '  FROM `tblParts` as P ' +
                  ' inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID ' +
                  ' and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F") OR (PQA.PQAID in (Select PQAID from `tblPQADetails`))) ' +
                  ' inner join `tblclass` as C on PQA.departmentID = C.ClassID ' +
                  ' Inner join `tblProductClasses` as PC on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID ' +
                  ' left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" ' +
                  ' left join `tblPqaDetails` PQABins  on PQABins.PQAId 	= PQA.PQAID ' +
                  ' and PQABins.PQAType = "Bin" and PQABins.Active = "T" and ' +
                  ' ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T")  or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) ' +
                  ' Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID ' +
                  ' left join `tblPqaDetails` PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T" and PQASN.Qty <> 0 ' +
                  ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T") or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"")  ' +
                  ' and P.Multiplebins = "T" and P.SNTracking = "T")  or ((ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T"))) ' +
                  ' and PQA.transDate in  (Select max(maxpqa.transDate) ' +
                  ' from `tblPQADetails` maxpqad ' +
                  ' inner join `tblPQA` maxpqa on maxpqa.PQAID = maxpqad.PQAID ' +
                  ' where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart" , "TProcTreePartIN"))  /*and maxpqa.PQAID = PQa.PQAID*/ ' +
                  ' and maxpqa.ProductID = PQa.ProductId and maxpqa.DepartmentId = PQa.DepartmentId' +
                  ' and maxpqad.value =PQASN.value ' +
                  ' ) ' +
                  ' and PQASN.Value not in (Select ifnull(Serial,"")  from `tblfixedAssets` where PartsId = PQA.ProducTID and ClassId =PQA.DepartmentID) ' +
                  '  Where P.active <>"F" and PC.ACtive <> "F" /*and PQA.active <> "F"*/ ' +
                  ' group by P.PartsID, P.PARTNAME , PQA.DepartmentID ' +
                  ' ,UOM ' +
                  ' ,IFNULL( PQABatch.Value,"") ' +
                  ' ,IFNULL( PQABatch.ExpiryDate,0) ' +
                  ' ,IFNULL( PQABins.BinID ,"") ' +
                  ' ,IFNULL( PBin.Binlocation,"") ' +
                  ' ,IFNULL( PBin.Binnumber ,"") ' +
                  ' ,IFNULL( PQASN.Value,"") ' +
                  ' having (ifnull(Serialnumber,"") = "" or  Qty >0); ');*)
      SQL.Add('/*2.1*/ alter table ' + Tablename +'_1  add column batch enum("T","F" ) default "F", add column multiplebins enum("T","F" ) default "F", add column sntracking enum("T","F" ) default "F";'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*2.1*/ update ' + Tablename +'_1  T inner join tblparts P on P.partsId = T.partsId Set  T.batch =P.batch,T.multiplebins =P.multiplebins , T.sntracking =P.sntracking;'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*3*/ Drop table if exists ' + Tablename +'_parts;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*4*/ Create table ' + Tablename +'_parts  Select distinct batch, multiplebins, sntracking, DepartmentId, uomid, PartsId,Partname ' +
                  ' from ' + Tablename +'_1  ;');(*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*4.1*/ alter table ' + Tablename +'_parts add column qty double, add column uomqty double;'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*5*/ Drop table if exists ' + Tablename +'_batch;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*6*/ Create table ' + Tablename +'_batch  Select batch,MultipleBins,sntracking,DepartmentId, uomid, PartsId, Partname, batchno, expirydate,  sum(ifnull(qty,0)) as Qty , sum(uomQty) as uomQty  ' +
                  ' from ' + Tablename +'_1 where ifnull(batchno,"")<> "" group by DepartmentId, PartsId, uomid, batchno, expirydate;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*7*/ Drop table if exists ' + Tablename +'_bin;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*8*/ Create table ' + Tablename +'_bin  Select batch,MultipleBins,sntracking,DepartmentId, uomid, PartsId, Partname, batchno, expirydate, binlocation, binnumber,  sum(ifnull(qty,0)) as Qty , sum(uomQty) as uomQty  ' +
                  ' from ' + Tablename +'_1 where ifnull(binlocation,"")<> "" group by DepartmentId, PartsId, uomid, batchno, expirydate, binlocation, binnumber;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*9*/ Drop table if exists ' + Tablename +'_sn;');(*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*10*/ Create table ' + Tablename +'_sn  Select batch,MultipleBins,sntracking,DepartmentId, uomid, PartsId, Partname, batchno, expirydate, binlocation, binnumber, serialnumber, sum(ifnull(qty,0)) as Qty , sum(uomQty) as uomQty  ' +
                  ' from ' + Tablename +'_1 where ifnull(serialnumber,"")<> "" group by DepartmentId, PartsId, uomid, batchno, expirydate, binlocation, binnumber, serialnumber;'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*11*/ Alter table ' + Tablename +'_bin  add column sntotal double;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*12*/ update ' + Tablename +'_bin  T1 set sntotal =(Select sum(ifnull(qty,0)) '+
                ' from ' + Tablename +'_sn T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId '+
                ' and ifnull(t1.batchno,"") =ifnull( t2.batchno,"") and ifnull(t1.expirydate,0) =ifnull( t2.expirydate ,0) '+
                ' and ifnull(t1.binlocation,"") = ifnull(t2.binlocation,"") and ifnull(t1.binnumber,"") = ifnull(t2.binnumber,""));'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*13*/ Alter table ' + Tablename +'_batch  add column bintotal double, add column sntotal double;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*update ' + Tablename +'_batch  T1 set sntotal =(Select sum(ifnull(sntotal,0)) '+
                ' from ' + Tablename +'_bin T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId '+
                ' and ifnull(t1.batchno,"") =ifnull( t2.batchno,"") and ifnull(t1.expirydate,0) =ifnull( t2.expirydate ,0));*/');
      SQL.Add('/*15*/ update ' + Tablename +'_batch  T1 set sntotal =(Select sum(ifnull(qty,0)) '+
                ' from ' + Tablename +'_sn T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId '+
                ' and ifnull(t1.batchno,"") =ifnull( t2.batchno,"") and ifnull(t1.expirydate,0) =ifnull( t2.expirydate ,0));')   ;
      SQL.Add('/*16*/ update ' + Tablename +'_batch  T1 set bintotal =(Select sum(ifnull(qty,0)) '+
                ' from ' + Tablename +'_bin T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId '+
                ' and ifnull(t1.batchno,"") =ifnull( t2.batchno,"") and ifnull(t1.expirydate,0) =ifnull( t2.expirydate ,0));')    ;

      SQL.Add('/*17*/ Alter table ' + Tablename +'_parts  add column batchtotal double, add column bintotal double, add column sntotal double;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*update ' + Tablename +'_parts  T1 set sntotal =(Select sum(ifnull(sntotal,0)) '+
                ' from ' + Tablename +'_batch T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId );*/');
      SQL.Add('/*update ' + Tablename +'_parts  T1 set sntotal =(Select sum(ifnull(sntotal,0)) '+
                ' from ' + Tablename +'_bin T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId and T2.batch="F");*/');

      SQL.Add('/*20*/ update ' + Tablename +'_parts  T1 set sntotal =(Select sum(ifnull(qty,0)) '+
                ' from ' + Tablename +'_sn T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId);');(*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*update ' + Tablename +'_parts  T1 set bintotal =(Select sum(ifnull(bintotal,0)) '+
                ' from ' + Tablename +'_batch T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId );*/');

      SQL.Add('/*22*/ update ' + Tablename +'_parts  T1 set bintotal =(Select sum(ifnull(qty,0)) '+
                ' from ' + Tablename +'_bin T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId );'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*23*/ update ' + Tablename +'_parts  T1 set batchtotal = (Select sum(ifnull(qty,0)) '+
                ' from  ' + Tablename +'_batch T2 '+
                ' where  T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId );'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*24*/ Drop table if exists ' + Tablename +' ;') ;
      SQL.Add('/*25*/ create table ' + Tablename +'  '+
              ' select 1 as SeqNo, batch,MultipleBins,sntracking,DepartmentId,  uomid, partsId, PARTNAME, null as batchno, null as expirydate, null as binlocation, null as binnumber, null as serialnumber,  qty, uomqty, batchtotal, bintotal, sntotal  ' +
                  ' from ' + Tablename +'_parts P '+
              ' union all '+
              ' select 2 as SeqNo, batch,MultipleBins,sntracking,DepartmentId,  uomid, partsId, PARTNAME, batchno, expirydate, null as binlocation, null as binnumber, null as serialnumber,  qty, uomqty, null batchtotal, bintotal, sntotal  ' +
                  ' from ' + Tablename +'_batch '+
              ' union all '+
              ' select 3 as SeqNo, batch,MultipleBins,sntracking,DepartmentId,  uomid, partsId, PARTNAME, batchno, expirydate, binlocation, binnumber, null as serialnumber,  qty, uomqty, null as batchtotal, null as bintotal, sntotal  ' +
                  ' from ' + Tablename +'_bin '+
              ' union all '+
              ' select 4 as SeqNo, batch,MultipleBins,sntracking,DepartmentId,  uomid, partsId, PARTNAME, batchno, expirydate, binlocation, binnumber, serialnumber,  qty, uomqty, null batchtotal, null bintotal, null sntotal  ' +
                  ' from ' + Tablename +'_sn '+
              ' order by DepartmentId, partsId, batchno, expirydate, binlocation, binnumber, serialnumber , SeqNo;') ;

      SQL.Add('/*4.2 Drop table if exists ' + Tablename +'_2;'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*4.3*/ Create table ' + Tablename +'_2 ' + ProductQtyLib.SQL4ProductAvailableQty(now ,  '',  tSummary, 0 , 0, '', 0, '','','',tavailable, 'PQA.UOM,pqa.uomid','P.batch="T" or P.multiplebins="T" or P.SNTracking ="T"',0,true)+';'); (*logtext(SQL.text);execute;SQL.clear;*)
      SQL.Add('/*4.4*/ update ' + Tablename +' T1 inner join ' + Tablename +'_2 T2 on T2.partsId =  t1.partsId and  t2.departmentId =  t1.departmentId and  t2.uomId =  t1.uomId Set T1.qty = T2.Qty, T1.uomQty = T2.uomQty where ifnull(T1.batchno,"")="" and ifnull(T1.binlocation,"")="" and ifnull(T1.serialnumber,"")="";'); (*logtext(SQL.text);execute;SQL.clear;*)

      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_parts ;') ;
      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_batch ;') ;
      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_bin ;') ;
      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_sn ;') ;
      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_1 ;') ;
      SQL.Add('/*24*/ Drop table if exists ' + Tablename +'_2 ;') ;

      (*logtext(SQL.text);execute;SQL.clear;*)
      doshowprogressbar(33 , WAITMSG);
      try
        try
          Execute;
        Except
          on E:Exception do begin
            Logtext(E.Message);
            Raise;
          end;
        end;
      finally
        doHideProgressbar;
      end;
  finally
    scriptmain.SQL.Clear;
    //free;
  end;
  inherited;

end;
procedure TAllocationMismatchGUI.SctMainAfterExecute(Sender: TObject;
  SQL: string);
begin
  inherited;
  logtext('After execute :' +SQL);
end;

procedure TAllocationMismatchGUI.SctMainBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  logtext('before execute :' +SQL);
end;

procedure TAllocationMismatchGUI.SctMainError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  logtext('On Error:' + E.message+Nl+SQL);
end;

initialization
  RegisterClassOnce(TAllocationMismatchGUI);
end.
