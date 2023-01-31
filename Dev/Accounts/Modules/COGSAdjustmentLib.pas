unit COGSAdjustmentLib;

interface

uses  TransactionsTable;

type
    TQtyncost =record
      PQAID:Integer;
      TRanstype:String;
      Qty:double;
      cost:double;
      costinc:double;
    end;
procedure MakeCOGSCost(TransactionTableObj : TTransactionTableObj; SummaryDetailsTable:boolean);



implementation

uses
  MyAccess,MySQLConst,
  db,classes, PQALib, sysutils, AppEnvironmentVirtual, Variants,
  ERPdbComponents,UtilsLib, SystemLib(*, BusobjTransactionPQACOGSDetails,
  BusObjBase*);

procedure MakeCOGSCost(TransactionTableObj : TTransactionTableObj; SummaryDetailsTable:boolean);
var
  fdRunningQty:Double;
  ProductId:Integer;
  DepartmentId:Integer;
  Qtyncost :Array of TQtyncost;
  fdQtyncosttotalCost, fdQtyncosttotalCostInc:Double;
  fdQty:Double;
  TempQry1, TempQry2 :TERPQuery;
  TempScript:TERPScript;
  //BusobjPQACogs:TTransactionPQACOGSDetails;
  function RoundQty(const Value:Double):Double;
  begin
    result := AppEnvVirt.Round(Value,   AppEnvVirt.Int['TcConst.GeneralRoundPlaces'] )
  end;
  Procedure DoMakeTransPQA;
  begin
    with TempScript do begin
        connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
        SQL.Clear;
        if SummaryDetailsTable then begin
          {All records from PQA}
          SQl.Add('Truncate table tbltransactionPQAs;');
          SQl.Add('Truncate table tbltransactionPQACOGSDetails;');
          SQl.Add('insert ignore into tbltransactionPQAs '+
                ' (Seqno, PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,ProductType , Active	,TransID , StockQty	)  '+
                ' select 3, PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,"INV", Active	,TransID , '+ SQL4QtyField(tActStockwithMan) +
                ' from tblpqa pqa;');
        end else begin
          {All records from PQA only after closing date }
          SQl.Add('Delete from tbltransactionPQAs where transdate >= ' +quotedstr(FormatDateTime(MysqlDateFormat, AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'])) +';');
          SQl.Add('Delete from tbltransactionPQACOGSDetails where PQAID1 not in (Select PQAID from tbltransactionPQAs);');
          SQl.Add('insert ignore into tbltransactionPQAs '+
                ' (Seqno, PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,ProductType , Active	,TransID , StockQty	)  '+
                ' select 4, PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,"INV" , Active	,TransID , '+ SQL4QtyField(tActStockwithMan) +
                ' from tblpqa pqa where transdate >= ' + quotedstr(FormatDateTime(MysqlDateFormat, AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate']))+';');
        end;
        {isSubBOM}
          SQl.Add('update '+
                ' tbltransactionpqas TPQa inner join tblpqa PQA on TPQA.transId = PQa.transID and TPQa.TransLineID = PQA.translineId and PQA.transType = "TProcTreePartIN" and PQA.alloctype ="IN" '+
                ' set TPQa.IsSubBOM ="T" '+
                ' where TPQA.transType ="TProcTreePart" and TPQA.alloctype ="OUT";');
          SQl.Add('update '+
                ' tbltransactionpqas TPQa inner join tblpqa PQA on TPQA.transId = PQa.transID and TPQa.TransLineID = PQA.translineId and PQA.transType = "TProcTreePart" and PQA.alloctype ="OUT" '+
                ' set TPQa.IsSubBOM ="T" '+
                ' where TPQA.transType ="TProcTreePartIN" and TPQA.alloctype ="IN";');
        {delete converted SO rec}
          SQL.add('delete from tbltransactionPQAs  where (transtype = "TSalesOrderLine" and Active ="F") or ISBO="T" or transtype ="TSalesOrderInvoiceLines" or (transtype ="TRepairParts" and Active="F");'); {converted salesorders}

        {update cost from the actual transaction table}
        {PO}
        SQl.Add('update tbltransactionPQAs pqa inner join tblpurchaselines POL on pqa.transId = POL.PurchaseOrderID and pqa.translineId = POL.PurchaseLineID and pqa.transtype in ( '+POTranstypes +')'+
                      ' Set costsourceID = 1, '+
                      ' pqa.Linecost  = POL.LineCost          +  if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0), '+
                      ' pqa.Linecostinc   = POL.LineCostinc       +  if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0), '+
                      ' pqa.totalcost     = POL.totallineamount   + (if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0)*POL.shipped) , '+
                      ' pqa.totalcostinc  = POL.totallineamountinc+ (if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0)*POL.shipped) , '+
                      ' Actualtotalcost   = POL.totallineamount   + (if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0)*POL.shipped) , '+
                      ' Actualtotalcostinc =POL.totallineamountinc+ (if(' + Quotedstr(BooleanToStr(AppEnvVirt.Bool['CompanyPrefs.IncludeLandedCostsinAvgCost']))+ '="T", POL.LandedCostsPerItem , 0)*POL.shipped)  '+
                      ' where pqa.transtype in ( '+POTranstypes +');' ) ;
        {Sales}
        SQl.Add('update tbltransactionPQAs pqa inner join tblsaleslines SL on pqa.transId = SL.SaleId and pqa.translineId = SL.SaleLineId and pqa.transtype in ( '+ SalesTransTypes+')'+
                      ' Set costsourceID = 2, '+
                      ' pqa.Linecost = SL.LineCost , pqa.Linecostinc = SL.LineCostinc, pqa.totalcost = SL.Linecost * SL.shipped , pqa.totalcostinc = SL.Linecostinc *SL.shipped'+
                      ' where pqa.transtype in ( '+SalesTransTypes +') and TRanstype <>  "TRefundSaleLine";' ) ;
        {refund cost}
        SQl.Add('update tbltransactionPQAs pqa inner join tblsaleslines SL on pqa.transId = SL.SaleId and pqa.translineId = SL.SaleLineId and pqa.TRanstype =  "TRefundSaleLine"'+
                      ' Set costsourceID = 2, '+
                      ' pqa.Linecost = SL.LineCost , pqa.Linecostinc = SL.LineCostinc, pqa.totalcost = SL.Linecost * (0-SL.shipped) , pqa.totalcostinc = SL.Linecostinc *(0-SL.shipped)'+
                      ' where TRanstype = "TRefundSaleLine";' ) ;
        {Stock Movement}
        SQl.Add('update tbltransactionPQAs pqa inner join tblstockmovementlines SML on pqa.transId = SML.StockmovementID and pqa.translineId = SML.StockmovementLinesID and  pqa.transtype In ('+StockMovementtypes+')'+
                      ' Set costsourceID = 3, '+
                      ' pqa.Linecost = SML.Cost , pqa.Linecostinc = SML.Cost, pqa.totalcost = SML.Cost * SML.Qty  , pqa.totalcostinc = SML.Cost * SML.Qty , '+
                      ' Actualtotalcost =  if( Alloctype = "IN", SML.Cost * SML.Qty ,0) , Actualtotalcostinc =  if( Alloctype = "IN", SML.Cost * SML.Qty ,0) '+
                      ' where pqa.transtype In ('+StockMovementtypes+') ;');

        {-ive qty invoiceline with 0 cost }
        SQl.Add('update tbltransactionPQAs pqa inner join tblparts P on p.partsId = pqa.productId'+
                      ' Set costsourceID = 5, '+
                      ' pqa.linecost =p.cost1, pqa.linecostinc = p.cost1, pqa.totalcost = p.cost1*pqa.qty, pqa.totalcostinc = p.cost1*pqa.qty, pqa.actualtotalcost = p.cost1*pqa.qty, pqa.actualtotalcostinc = p.cost1*pqa.qty'+
                      ' Where pqa.TRanstype = "TInvoiceLine" and ifnull(pqa.Qty,0)< 0 and ifnull(pqa.linecost,0) =0 and ifnull(pqa.totalcost,0)=0; ');

        SQl.Add('update tbltransactionPQAs pqa  '+
                      ' Set pqa.actualtotalcost = totalcost , '+
                      ' pqa.actualtotalcostinc = totalcostinc '+
                      ' Where pqa.TRanstype = "TInvoiceLine" and ifnull(pqa.Qty,0)< 0 and ifnull(pqa.actualtotalcost ,0)=0;');

        {-REfund  }
        SQl.Add('update tbltransactionPQAs pqa  '+
                      ' Set pqa.actualtotalcost = totalcost , '+
                      ' pqa.actualtotalcostinc = totalcostinc '+
                      ' Where pqa.TRanstype = "TRefundSaleLine"  ;');


        {Posting should only be done for the converted Sales Orders - until the sales order is converted, there is no posting }


        SQL.add('update  tbltransactionPQAs Set ISToDelete ="F";');

        {tblaccountpostingdetail should not have reocrds for NOT SELECTED OPTION items... to delete currupted data from history}
        SQL.add('update tblproctreePart ptp '+
                      ' inner join tblproctree Pt  on ptp.proctreeId = pt.proctreeId   '+
                      ' inner join tblproctreeNodes  PTN on PT.ProctreeId = PTN.proctreeId '+
                      ' inner  join tbltransactionPQAs pqa  on PQA.TransLineId= PTP.ProctreePartID and PQA.Transtype In  ('+ManufactureTypes+') '+
                      ' Set PQa.ISToDelete ="T" '+
                      'Where PTN.selected ="F";');

        SQL.add('update  tbltransactionPQAs pqa '+
                      ' inner join tblproctreepart PTP  on PQA.TransLineId= PTP.ProctreePartID and PQA.Transtype In  ('+ManufactureTypes+') '+
                      ' Left join tblAccountPostingDetail APD on APD.sourcelineID = PTP.ProctreePartID '+
                      ' Set pqa.ISToDelete ="T" '+
                      ' Where ifnull(APD.AccountPostingDetailId  ,0)=0;');

        {PQA should not have reocrds for NOT SELECTED OPTION items... to delete currupted data from history}
        SQL.add('update tbltransactionpqas pqa '+
                      ' inner join tblproctreePart ptp on ptp.proctreepartId = pqa.translineId and pqa.transtype  In  ('+ManufactureTypes+') '+
                      ' inner join tblproctree Pt  on ptp.proctreeId = pt.proctreeId  inner join tblproctreenodes PN on PT.ProcTreeId = PN.ProctreeId and PN.Selected ="F"'+
                      ' inner  join tblproctree ppt on Pt.parentId = PPT.proctreeID '+
                      ' Set PQa.ISToDelete ="T" '+
                      ' /*Where (PPT.inputType= "itOption" and  PT.selected="F")*/;');

        SQL.add('Delete from tbltransactionPQAs where ISToDelete ="T";');
        {Manufacture from Accountposting}

(* SQl.Add('update tbltransactionPQAs pqa inner join tblproctreepart PTP  on PQA.TransLineId= PTP.ProctreePartID and PQA.Transtype In ('+ManufactureTypes+') '+
                ' inner join tblAccountPostingDetail APD on APD.sourcelineID = PTP.ProctreePartID '+
                      ' Set costsourceID = 6, '+
                      ' pqa.Linecost    = if(DebitAmount=0,Creditamount, DebitAmount) / if(ifnull(PTP.Qty,0)=0,1,PTP.Qty) , '+
                          ' pqa.Linecostinc = if(DebitAmount=0,Creditamount, DebitAmount) / if(ifnull(PTP.Qty,0)=0,1,PTP.Qty), '+
                          ' pqa.totalcost   = if(DebitAmount=0,Creditamount, DebitAmount) /** PTP.Qty*/ , '+
                          ' pqa.totalcostinc= if(DebitAmount=0,Creditamount, DebitAmount) /** PTP.Qty*/ , '+
                          ' Actualtotalcost    = if(PQA.alloctype="IN" , if(DebitAmount=0,Creditamount, DebitAmount) /** PTP.Qty*/ , 0), '+
                          ' Actualtotalcostinc = if(PQA.alloctype="IN" , if(DebitAmount=0,Creditamount, DebitAmount) /** PTP.Qty*/ , 0) '+
                      ' where PQA.Transtype In ('+ManufactureTypes+');');*)
        TRy
          TransactionTableObj.showprogressDlg('Populating Transactional PQA',Statements.Count);
          BeforeExecute := TransactionTableObj.MyScriptBeforeExecute;
          Execute;
        Finally
          TransactionTableObj.ProgressDlg.CloseDialog;
        End;
      end;
  end;

  Procedure DoCalcRunningQty;
  begin
      AppEnvVirt.LogText(' CalcRunningQty');
      TempQry1.First;
      fdRunningQty:= 0;
      ProductId   :=TempQry1.fieldbyname('ProductID').asInteger;
      DepartmentId:=TempQry1.fieldbyname('DepartmentId').asInteger;

      TransactionTableObj.showprogressDlg('Populating Running Qty',TempQry1.RecordCount);
      try
        While TempQry1.Eof = False do begin
          if (ProductId <>TempQry1.fieldbyname('ProductID').asInteger)  then begin
            fdRunningQty := 0;
            ProductId :=TempQry1.fieldbyname('ProductID').asInteger;
            DepartmentId:=TempQry1.fieldbyname('DepartmentId').asInteger
          end;
          fdRunningQty := fdRunningQty+ TempQry1.FieldByName('StockQty').asFloat;
          if TempQry1.State in [dsEdit,dsInsert] then else TempQry1.Edit;
          TempQry1.FieldByName('RunningQty').AsFloat := fdRunningQty;
          if TempQry1.State in [dsEdit,dsInsert] then TempQry1.Post;
          TempQry1.NExt;
          if TransactionTableObj.devmode then TransactionTableObj.ProgressDlg.Message := TempQry1.fieldbyname('Productname').asString ;
          TransactionTableObj.ProgressDlg.StepIt;
        end;
      finally
        TransactionTableObj.ProgressDlg.CloseDialog;
      end;
      AppEnvVirt.LogText(' CalcRunningQty...Done');
  end;

  Procedure  QtyncosttotalCost;
  var
    fiCtr:Integer;
  begin
    fdQtyncosttotalCost:= 0;
    fdQtyncosttotalCostinc := 0;
    TempScript.SQL.Clear;
    for fiCtr:= low(Qtyncost) to high(Qtyncost) do begin
      if RoundQty(Qtyncost[fiCtr].Qty)<> 0 then begin
        TempScript.SQL.Add('insert ignore into tbltransactionpqacogsdetails '+
                           ' Set  PQAID1        = ' + inttostr(TempQry1.fieldbyname('PQAID').asInteger) +','+
                                 'PQAID2        = ' + inttostr(Qtyncost[fiCtr].PQAID) +','+
                                 'TransType1    = ' + quotedstr(TempQry1.fieldbyname('Transtype').asString) +',' +
                                 'TransType2    = ' + quotedstr(Qtyncost[fiCtr].Transtype) +',' +
                                 'ProductId     = ' + inttostr(TempQry1.fieldbyname('ProductId').asInteger) +','+
                                 'productname   = ' + quotedstr(TempQry1.fieldbyname('ProductName').AsString) +',' +
                                 'Qty           = ' + FloatTostr(Qtyncost[fiCtr].Qty) +','+
                                 'unitcostex    = ' + FloatTostr(Qtyncost[fiCtr].cost) +','+
                                 'unitcostinc   = ' + FloatTostr(Qtyncost[fiCtr].costInc) +','+
                                 'totalcostEx   = ' + FloatTostr(Qtyncost[fiCtr].cost*Qtyncost[fiCtr].Qty) +','+
                                 'totalcostinc  = ' + FloatTostr(Qtyncost[fiCtr].costinc*Qtyncost[fiCtr].Qty) +
                                 ' ON DUPLICATE KEY UPDATE '+
                                 'unitcostex    = ' + FloatTostr(Qtyncost[fiCtr].cost) +','+
                                 'unitcostinc   = ' + FloatTostr(Qtyncost[fiCtr].costInc) +','+
                                 'totalcostEx   = ' + FloatTostr(Qtyncost[fiCtr].cost*Qtyncost[fiCtr].Qty) +','+
                                 'totalcostinc  = ' + FloatTostr(Qtyncost[fiCtr].costinc*Qtyncost[fiCtr].Qty) +' ;');

        fdQtyncosttotalCost:= fdQtyncosttotalCost +Qtyncost[fiCtr].cost*Qtyncost[fiCtr].Qty;
        fdQtyncosttotalCostinc:= fdQtyncosttotalCostinc +Qtyncost[fiCtr].costinc*Qtyncost[fiCtr].Qty;
      end;
    end;
    TempScript.Execute;
  end;

  Function DOBOMCogsudpate:Boolean;
  var
    ctr:Integer;
    Levelno :Integer;
  begin
  result := true;
  with tempQry1 do begin
    if active then close;
    SQL.clear;
    SQL.add( 'SELECT MAX(LEVEL) Level FROM tblproctree;');
    open;
    Levelno := fieldbyname('Level').asInteger;
  end;
  if Levelno =0 then begin
    REsult := False ;
    exit;
  end;
  with TempScript do begin
      SQL.add('drop table if exists tbltransactionpqas_1;');
      SQL.add('create table tbltransactionpqas_1 like tblproctree;');
      SQL.add('insert into tbltransactionpqas_1 select * from tblproctree;');
      SQL.add('alter table tbltransactionpqas_1  add column nodeSelected enum("T","F") default "F";');
      SQL.add('update tbltransactionpqas_1 T inner join tblproctreenodes PN on PN.proctreeId = T.proctreeId Set t.nodeselected = PN.Selected;');

      SQL.add('alter table tbltransactionpqas_1  add column actualtotalcost double , add column actualtotalcostinc double;');

      SQL.add('update tbltransactionpqas_1 T '+
                ' Left join tblproctree Pt on Pt.ParentId = t.proctreeID '+
                ' inner join tblProctreePart PTP on PTP.proctreeId = t.proctreeId '+
                ' inner join tbltransactionPQAs PQA on PQA.transLineId = PTP.proctreePArtID and PQa.transtype ="TProcTreePart" and pqa.alloctype ="OUT" '+
                ' Set T.actualtotalcost = pqa.actualtotalcost,T.actualtotalcostinc = pqa.actualtotalcostinc '+
                ' Where ifnull(Pt.ProcTreeId,0)=0;');

      SQL.add('update tbltransactionpqas_1 T '+
                ' Left join tblproctree Pt on Pt.ParentId = t.proctreeID '+
                ' inner join tblProctreePart PTP on PTP.proctreeId = t.proctreeId '+
                ' inner join tblaccountpostingdetail APD on APD.SourcelineID = PTP.ProctreepartId '+
                ' Set T.actualtotalcost = APD.creditAmount , T.actualtotalcostinc = APD.creditAmount '+
                ' Where  PTP.Parttype <> "INV"  and ifnull(Pt.ProcTreeId,0)=0;');

      for ctr:= 1 to Levelno+1 do begin
        SQL.add('Drop table if exists tbltransactionpqas_2;');
        SQL.add('Create table tbltransactionpqas_2 select ParentId, round(Sum(Actualtotalcost),' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces'])+') Actualtotalcost, '+
                                                                   ' round(sum(ActualtotalcostInc),' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces'])+') as ActualtotalcostInc '+
                                                                   ' from tbltransactionpqas_1 where nodeselected ="T" group by ParentID;');
        SQL.add('update tbltransactionpqas_1 T1 inner join tbltransactionpqas_2 T2 on T1.proctreeId = T2.ParentId Set T1.Actualtotalcost = T2.Actualtotalcost , T1.Actualtotalcostinc = T2.Actualtotalcostinc;');
      end;

      SQL.add('Drop table if exists tbltransactionpqas_2;');
      SQL.add('create table tbltransactionpqas_2 like tbltransactionpqas_1;');
      SQL.add('insert into tbltransactionpqas_2' +
                ' Select distinct T1.*' +
                ' from tbltransactionpqas_1 T1' +
                ' inner join tblproctree Pt on T1.ProctreeId = Pt.ParentId;');

      SQL.add('update tbltransactionpqas_2 T ' +
             ' inner join tblproctreePart ptp on T.proctreeId = ptp.proctreeID ' +
             ' inner join tbltransactionpqas pqa on pqa.transLineId = ptp.proctreePartId and  pqa.transtype in ('+ ManufactureTypes +') ' +
             ' Set pqa.costsourceID = 10,   ' +
             '     pqa.Actualtotalcost = t.Actualtotalcost ,  ' +
             '     pqa.Actualtotalcostinc = t.Actualtotalcostinc ,  ' +
             '     pqa.totalcost    = t.actualtotalcost,  ' +
             '     pqa.totalcostinc = t.actualtotalcostinc ,  ' +
             '     pqa.linecost     = t.actualtotalcost /t.totalqty, ' +
             '     pqa.linecostinc  = t.actualtotalcostinc /t.totalqty ;');
      SQL.add('Drop table if exists tbltransactionpqas_2;');
      SQL.add('Drop table if exists tbltransactionpqas_1;');
      SQl.Add('update tbltransactionpqas Set SoldQty=0;');
      TRy
          TransactionTableObj.showprogressDlg('BOM Cogs udpate',SQl.Count);
          BeforeExecute := TransactionTableObj.MyScriptBeforeExecute;
          Execute;
        Finally
          TransactionTableObj.ProgressDlg.CloseDialog;
        End;
  end;

  end;
(*  function DoBOMCogs(firstRun :boolean):Boolean;
  var
    ctr:Integer;
  begin
    result := False;
    AppEnvVirt.LogText(' BOMCogs');
    ctr:= 1;

  With TransactionTableObj.aQuery do try
    SQL.Text := 'Select count( * ) ctr from tblaccountpostingdetail ';
    open;
    if fieldbyname('ctr').asInteger =0 then exit; // no accountposting
  finally
    ClosenFree;
  end;


    with TempScript do begin
            TransactionTableObj.showprogressDlg('Calculating BOM COGS',10);
            TRy
                {loop to update the Manufacture Product's cost from the row materials}
                if TempQry1.Active then TempQry1.Close;
                TempQry1.SQl.text := 'Select count(P2clean.pqaid) as ctr '+
                                  ' from tbltransactionpqas p2 '+
                                  ' inner join tbltransactionpqasclean p2clean on p2.pqaid = P2clean.pqaid and p2.transtype in ( "TProcTreePart" ,  "TProcTreePartIN") '+
                                  ' where round( p2.Actualtotalcost ,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +') <> round(p2clean.Actualtotalcost,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +') '+
                                  ' or round(p2.Actualtotalcostinc,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +') <> round(p2clean.Actualtotalcostinc,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +')  ;';

                    if TransactionTableObj.Devmode  then TransactionTableObj.ProgressDlg.Message  := 'BOM COGS calculation : Tree heirarchy Level '+ inttostr(ctr);

                    SQL.clear;
                    SQl.Add('Drop table if exists tbltransactionpqas1;');
                    SQl.Add('create table tbltransactionpqas1 '+
                                      ' Select pqa.PQAID, pqa.transId, pqa.transLineID , PT.ProcTreeId, PT.TreeRootId , PT.ParentId, "F" as isparent, pqa.Actualtotalcost , pqa.Actualtotalcostinc, pqa.transtype '+
                                      ' from tbltransactionpqas  pqa  '+
                                      ' inner join tblproctreepart ptp on pqa.translineId = ptp.ProcTreePartId and pqa.transtype in ( '+ManufactureTypes+') '+
                                      ' inner join tblproctree PT on PT.ProcTreeId = PTP.proctreeID  inner join tblproctreenodes PN on PT.ProcTreeId = PN.ProctreeId and PN.Selected ="T"'+
                                      ' Left join tblproctree PPT on Pt.parentId = PPT.proctreeId  '+
                                      ' /*Where (ifnull(PPt.proctreeId,0)=0 or PPT.inputtype <> "itOption" or PT.selected ="T") */;');

                    //SQL.Add(fsBOMTransfornonInv);
                    if firstRun  then {non-invs are already added into thltransactionPQAs the first time and its cost doesn't change }
                      SQl.Add('insert into tbltransactionpqas1   (PQAID, transId, transLineID , ProcTreeId, TreeRootId , ParentId, isparent, Actualtotalcost , Actualtotalcostinc, transtype  ) '+
                            ' select  0 as PQAID, sl.saleId as transId, sourceLineID as transLineID , Pt.ProcTreeId, Pt.TreeRootId , Pt.ParentId, "F" as isparent, '+
                            ' if(APD.CreditDebittype="D" ,  APD.DebitAmount,    APD.CreditAmount) Actualtotalcost,   if(APD.CreditDebittype="D" ,  APD.DebitAmount,    APD.CreditAmount) ActualtotalcostInc, '+
                            ' if(APD.CreditDebittype="D" ,  "TProcTreePartIN" ,    "TProcTreePart" ) transtype '+
                            ' from tblsales S '+
                            ' inner join tblsaleslines SL  on S.saleId = SL.saleId and s.converted ="T" and S.IsSalesOrder="T" '+
                            ' inner join tblproctree  PT   on PT.masterId = SL.salelineId  AND PT.masterType in ("mtSalesOrder" ) inner join tblproctreenodes PN on PT.ProcTreeId = PN.ProctreeId and PN.Selected ="T" '+
                            ' Left join tblproctree PPT on PT.parentId = PPT.ProcTreeId '+
                            ' Left join tblparts P on PT.PartsId = P.partsID '+
                            ' Left join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId '+
                            ' left join tblaccountpostingdetail APD on APD.SourcelineID = PTP.ProcTreePartId and APD.Parttype <> "INV" '+
                            ' where  (ifnull(P.partsID,0)=0 or P.Parttype <> "INV") /*and '+
                            ' (ifnull(PPT.ProcTreeId,0)=0  or PPT.InputType <> "itOption" or PPT.Selected ="T")*/;');

                    SQL.add('Alter table tbltransactionpqas1  add index proctreeID (proctreeID);');
                    SQL.add('Alter table tbltransactionpqas1  add index PQAID (PQAID);');

                    Execute;
                repeat {repeat loop for the BOM heirarchy levels}
                   AppEnvVirt.LogTextLoge('BOM COGS calculation : Tree heirarchy Level '+ inttostr(ctr));
                    SQL.clear;
                    SQl.Add('drop table if exists tbltransactionpqas2;');
                    SQl.Add('create table tbltransactionpqas2 '+
                                      ' Select  ParentID ,   sum(Actualtotalcost) as Actualtotalcost , sum(Actualtotalcostinc) as ActualtotalcostInc '+
                                      ' from tbltransactionpqas1 where ifnull(ParentID ,0)<> 0 and transtype ="TProcTreePart" group by ParentID ;');
                    SQL.add('Alter table tbltransactionpqas2  add index parentId (parentId);');


                    SQl.Add('update tbltransactionpqas2 p2 '+
                                      ' inner join tbltransactionpqas1 p1 on p2.parentId = p1.proctreeID '+
                                      ' set p1.Actualtotalcost = round(p2.Actualtotalcost,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +') , '+
                                      ' p1.Actualtotalcostinc = round(p2.Actualtotalcostinc ,' + IntToStr(AppEnvVirt.Int['TcConst.GeneralRoundPlaces']) +'), ISparent ="T";');

                    SQl.Add('drop table if exists tbltransactionpqasclean ;');
                    SQl.Add('create table tbltransactionpqasclean  Select * from tbltransactionpqas;');


                    SQl.Add('update tbltransactionpqas p '+
                                      ' inner join tbltransactionpqas1 p1 on p.PQAID = p1.pqaid '+
                                      ' set  costsourceID = 7, '+
                                      ' p.linecost     = p1.Actualtotalcost /P.qty,'+
                                      ' p.linecostinc       = p1.Actualtotalcostinc /P.qty,'+
                                      ' p.totalcost         = p1.Actualtotalcost , '+
                                      ' p.totalcostinc      = p1.Actualtotalcostinc, '+
                                      ' p.Actualtotalcost   = p1.Actualtotalcost , '+
                                      ' p.Actualtotalcostinc= p1.Actualtotalcostinc;' );
                    TransactionTableObj.showprogressDlg('BOM Cogs Calculation',SQL.count);
                    Execute;

                    TransactionTableObj.ProgressDlg.StepIt;

                    if TempQry1.Active then TempQry1.Close;
                    TempQry1.open;
                    ctr:= ctr+1;
                until TempQry1.fieldbyname('ctr').asInteger =0;

                TransactionTableObj.ProgressDlg.StepIt;

                 {delete the temporary tables}
                SQL.clear;
                {noninv sub bom posting}
                if firstRun  then begin {non-invs are already added into thltransactionPQAs the first time and its cost doesn't change }
                  SQl.Add('INSERT IGNORE INTO tbltransactionpqas  '+
                        '  (costsourceID ,Seqno, TransId, transLineId, transtype, transdate, alloctype, qty, uomqty, departmentId, productID, productname, ProductType , Active,  '+
                        ' Linecost, linecostinc, totalcost, totalcostinc, actualtotalcost, actualtotalcostinc, ISBO, uomid, uom, uommultiplier) '+
                        '  SELECT 8,1, SL.saleId AS TransId, PTP.ProctreePartID AS transLineid, T.transtype, AP.Date,  '+
                        '  IF(T.transtype = "", "IN", "OUT") AS Alloctype, 1 AS Qty, 1 AS uomQty, PTP.classId AS DepartmentID, PTP.productID, PTP.productname, APD.Parttype , "T",  '+
                        'T.actualTotalcost  ,T.actualTotalcost ,T.actualTotalcost ,T.actualTotalcost ,T.actualTotalcost ,T.actualTotalcost ,'+
                        '  "F" , PTP.UnitOfMeasureId , PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier '+
                        '  FROM tbltransactionpqas1 T '+
                        '  INNER JOIN tblaccountpostingdetail APD ON T.transLineId = APD.sourceLineId AND APD.Parttype <> "INV" AND IF(APD.CreditDebittype="C", "TProcTreePart", "TProcTreePartIN") = T.transtype '+
                        '  INNER JOIN tblaccountposting AP ON APD.AccountPostingId = AP.AccountPostingId '+
                        '  INNER JOIN tblProctreePart PTP ON PTP.proctreePartId = APD.sourcelineId '+
                        '  INNER JOIN tblproctree PT ON PT.ProcTreeId = PTP.ProcTreeId '+
                        '  INNER JOIN tblsaleslines SL ON SL.salelineId = PT.MasterId;');

                  SQl.Add('INSERT IGNORE INTO tbltransactionpqas  '+
                        '  (costsourceID, Seqno, TransId, transLineId, transtype, transdate, alloctype, qty, uomqty, departmentId, productID, productname, ProductType, Active,  '+
                        ' Linecost, linecostinc, totalcost, totalcostinc, actualtotalcost, actualtotalcostinc, ISBO, uomid, uom, uommultiplier) '+
                        ' SELECT 9, 2, SL.saleId AS TransId, PTP.ProctreePartID AS transLineid, "TProcTreePart", AP.Date,    "OUT" AS Alloctype,  '+
                        ' 1 AS Qty, 1 AS uomQty, PTP.classId AS DepartmentID, PTP.productID, PTP.productname,APD.PArttype,  "T", '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount), '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount), '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount), '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount), '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount), '+
                        ' if(APD.CreditDebittype ="C" , APD.CreditAmount , APD.DebitAmount) '+
                        '  ,  "F" , PTP.UnitOfMeasureId , PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier '+
                        ' FROM tblaccountpostingdetail APD '+
                        ' INNER JOIN tblaccountposting AP ON APD.AccountPostingId = AP.AccountPostingId   and APD.PArttype <> "INV" '+
                        ' INNER JOIN tblProctreePart PTP ON PTP.proctreePartId = APD.sourcelineId '+
                        ' INNER JOIN tblproctree PT ON PT.ProcTreeId = PTP.ProcTreeId '+
                        ' Left join tblproctree PTC on PT.ProcTreeId =PTC.ParentId '+  //PTC:Proctreechildren
                        ' INNER JOIN tblsaleslines SL ON SL.salelineId = PT.MasterId '+
                        ' where ifnull(PTC.ProcTreeId,0)=0;');  // has noc hildren entries
                end;


                SQl.Add('Drop table if exists tbltransactionpqas1;');
                SQl.Add('Drop table if exists tbltransactionpqas2;');
                SQl.Add('Drop table if exists tbltransactionpqasclean;');
                SQl.Add('update tbltransactionpqas Set SoldQty=0;');
                Execute;
            Finally
              TransactionTableObj.ProgressDlg.CloseDialog;
            End;
        end;
        AppEnvVirt.LogText(' BOMCogs...done');
        Result := True;
  end;*)

  Procedure DoCalcActualCost;
  var
    LastcostProductId:Integer;
    //LastcostDepartmentID:Integer;
    LastCost:double;
    LastCostinc:double;
    Intransfound:boolean;
  begin
    LastcostProductId:= 0;
    Lastcost:= 0;
    Lastcostinc:= 0;
      AppEnvVirt.LogText(' CalcActualCost');
      if TempQry1.Active then TempQry1.Close;

      {OUT transactions}
      TempQry1.SQL.Text :='Select * from  tbltransactionPQAs '+
                          'where ((Alloctype = "OUT"  and qty >0) or (Alloctype = "IN" and Qty <0) or (transtype ="TRefundSaleLine" and Qty >0) )  '+
                          ' and ifnull(StockQty,0) <>0 and IsSubBOM <> "T" '+
                          ' order by ProductId,TransDate  ,PQAID, transId, transLineId ;';
      TempQry1.open;

      if TempQry2.Active then TempQry2.Close;
      {IN transactions}
      TempQry2.SQL.Text := 'Select * from  tbltransactionPQAs '+
                          ' where ((Alloctype = "IN"  and qty >0 and transtype <>"TRefundSaleLine" ) or (Alloctype = "OUT" and Qty <0) or (transtype ="TRefundSaleLine" and Qty <0)  )  '+
                          ' and transtype <> "TProcTreePartIN" and ifnull(StockQty,0) <>0   and IsSubBOM <> "T" '+
                          ' order by  ProductId, TransDate  ,PQAID, transId, transLineId ;';
      TempQry2.Open;

      TempQry2.First;
      TempQry1.First;
      TransactionTableObj.showprogressDlg('Populating Cost', TempQry1.RecordCount);
      try
        While TempQry1.Eof = False do begin
          fdRunningQty:= RoundQty(0-TempQry1.fieldbyname('stockQty').Asfloat);
          if fdRunningQty<> 0 then begin
            SetLength(Qtyncost,0);
            if (fdRunningQty>0) then begin
              if not TempQry2.eof then

                if (TempQry2.fieldbyname('ProductID').asInteger <> TempQry1.fieldbyname('ProductID').asInteger) then  TempQry2.Locate('ProductID' , TempQry1.fieldbyname('ProductID').asInteger, []);
                if (LastcostProductId<> TempQry1.fieldbyname('ProductID').asInteger)  then begin
                    LastCost:= 0;
                    LastCostinc := 0;
                end;
                Intransfound:=False;
              while (TempQry2.eof = False) and
                    (TempQry2.fieldbyname('ProductID').asInteger     = TempQry1.fieldbyname('ProductID').asInteger) and
                    (fdRunningQty<>0) do begin
                fdQty:=0;
                if TempQry2.fieldByname('stockQty').asFloat- TempQry2.fieldbyname('SoldQty').asfloat <> 0 then begin
                  Intransfound:=True;

                  if (TempQry2.fieldByname('stockQty').asFloat- TempQry2.fieldbyname('SoldQty').asfloat < fdRunningQty)   then
                      fdQty:=TempQry2.fieldByname('stockQty').asFloat- TempQry2.fieldbyname('SoldQty').asfloat
                  else fdQty:= fdRunningQty;
                  fdQty := RoundQty(fdQty);

                  LastCost    := TempQry2.fieldByname('linecost').asFloat;
                  LastCostinc := TempQry2.fieldByname('linecostinc').asFloat;
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].PQAID   := TempQry2.fieldByname('PQAID').asInteger;
                  Qtyncost[high(Qtyncost)].Transtype  := TempQry2.fieldByname('Transtype').asString;
                  Qtyncost[high(Qtyncost)].qty     := fdQty;
                  Qtyncost[high(Qtyncost)].cost    := TempQry2.fieldByname('linecost').asFloat;
                  Qtyncost[high(Qtyncost)].costinc := TempQry2.fieldByname('linecostinc').asFloat;
                  if TempQry2.State in [dsEdit, dsInsert] then else TempQry2.Edit;
                  TempQry2.fieldbyname('SoldQty').asfloat := TempQry2.fieldbyname('SoldQty').asfloat + fdQty;
                  if TempQry2.State in [dsEdit, dsInsert] then TempQry2.Post;
                  AppEnvVirt.LogTextLoge(TempQry2.fieldByname('Productname').asString  +',' +TempQry2.fieldByname('PQAID').asString+',' + floattostr(fdQty) +','+TempQry2.fieldByname('SoldQty').asString);
                  fdRunningQty:= RoundQty(fdRunningQty-fdQty);
                end;
                if fdRunningQty <> 0 then TempQry2.Next
                else if (TempQry2.fieldByname('stockQty').asFloat- TempQry2.fieldbyname('SoldQty').asfloat <=0) then TempQry2.Next;
              end;

              if fdRunningQty <> 0 then begin
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].PQAID   := 0;
                  Qtyncost[high(Qtyncost)].Transtype  := '';
                  Qtyncost[high(Qtyncost)].qty     := fdRunningQty;
                  if Intransfound or (LastcostProductId= TempQry1.fieldbyname('ProductID').asInteger) then begin
                    Qtyncost[high(Qtyncost)].cost    := Lastcost;
                    Qtyncost[high(Qtyncost)].costinc := Lastcostinc;
                  end else begin
                    Qtyncost[high(Qtyncost)].cost    := TempQry1.fieldbyname('Linecost').asfloat;
                    Qtyncost[high(Qtyncost)].costinc := TempQry1.fieldbyname('Linecostinc').asfloat;
                  end;
              end;

            end else begin
              AppEnvVirt.LogText('-ive Qty:' + TempQry1.fieldbyname('PQAID').assTring);
              if not TempQry2.bof then
                if (TempQry2.fieldbyname('ProductID').asInteger <> TempQry1.fieldbyname('ProductID').asInteger)  then  TempQry2.Locate('ProductID' , TempQry1.fieldbyname('ProductID').asInteger, []);
                if (LastcostProductId<> TempQry1.fieldbyname('ProductID').asInteger)  then begin
                    LastCost:= 0;
                    LastCostinc := 0;
                end;

              Intransfound := false;
              while (TempQry2.bof = False) and
                    (TempQry2.fieldbyname('ProductID').asInteger     = TempQry1.fieldbyname('ProductID').asInteger) and
                    (fdRunningQty<>0) do begin
                    fdQty:= 0;
                if TempQry2.fieldbyname('SoldQty').asfloat >0 then begin
                  Intransfound := True;
                  if TempQry2.fieldbyname('SoldQty').asfloat < abs(fdRunningQty)   then fdQty:=TempQry2.fieldbyname('SoldQty').asfloat else fdQty:= abs(fdRunningQty);
                  fdQty := RoundQty(fdQty);
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].PQAID   := TempQry2.fieldByname('PQAID').asInteger;
                  Qtyncost[high(Qtyncost)].Transtype  := TempQry2.fieldByname('Transtype').asString;
                  Qtyncost[high(Qtyncost)].qty    := fdQty;
                  Qtyncost[high(Qtyncost)].cost   := TempQry2.fieldByname('linecost').asFloat;
                  Qtyncost[high(Qtyncost)].costinc:= TempQry2.fieldByname('linecostinc').asFloat;
                  if TempQry2.State in [dsEdit, dsInsert] then else TempQry2.Edit;
                  TempQry2.fieldbyname('SoldQty').asfloat := TempQry2.fieldbyname('SoldQty').asfloat -fdQty;
                  if TempQry2.State in [dsEdit, dsInsert] then TempQry2.Post;
                  AppEnvVirt.LogTextLoge(TempQry2.fieldByname('Productname').asString  +',' +TempQry2.fieldByname('PQAID').asString+',' + floattostr(fdQty) +','+TempQry2.fieldByname('SoldQty').asString);
                  fdRunningQty:= RoundQty(fdRunningQty+fdQty);
                end;
                if fdRunningQty <> 0 then TempQry2.Prior
                else if TempQry2.fieldbyname('SoldQty').asfloat <=0 then TempQry2.Prior;
              end;

              if fdRunningQty <> 0 then begin
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].PQAID   := 0;
                  Qtyncost[high(Qtyncost)].Transtype  := '';
                  Qtyncost[high(Qtyncost)].qty     := fdRunningQty;
                  if Intransfound then begin
                    Qtyncost[high(Qtyncost)].cost    := Lastcost;
                    Qtyncost[high(Qtyncost)].costinc := Lastcostinc;
                  end else begin
                    Qtyncost[high(Qtyncost)].cost    := TempQry1.fieldbyname('Linecost').asfloat;
                    Qtyncost[high(Qtyncost)].costinc := TempQry1.fieldbyname('Linecostinc').asfloat;
                  end;
              end;
            end;

            if length(Qtyncost)>0 then begin
                QtyncosttotalCost;
                  if TempQry1.State in [dsEdit, dsInsert] then else TempQry1.Edit;
                  TempQry1.fieldbyname('Actualtotalcost').asFloat   := fdQtyncosttotalCost;
                  TempQry1.fieldbyname('Actualtotalcostinc').asFloat:= fdQtyncosttotalCostInc;
                if TempQry1.State in [dsEdit, dsInsert] then TempQry1.Post;
            end else begin
                  if TempQry1.State in [dsEdit, dsInsert] then else TempQry1.Edit;
                  TempQry1.fieldbyname('Actualtotalcost').asFloat    := TempQry1.fieldbyname('totalcost').asFloat ;
                  TempQry1.fieldbyname('Actualtotalcostinc').asFloat := TempQry1.fieldbyname('totalcostinc').asFloat ;
                if TempQry1.State in [dsEdit, dsInsert] then TempQry1.Post;
            end;
          end;

          LastcostProductId   :=  TempQry1.fieldbyname('ProductID').asInteger;
          //LastcostDepartmentID:=  TempQry1.fieldbyname('departmentID').asInteger;
          TempQry1.NExt;
          if TransactionTableObj.Devmode  then TransactionTableObj.ProgressDlg.Message := inttostr(TempQry1.recno) +' of ' + inttostr(TempQry1.recordcount);
          AppEnvVirt.LogTextLoge(inttostr(TempQry1.recno) +' of ' + inttostr(TempQry1.recordcount));
          TransactionTableObj.ProgressDlg.Stepit;
        end;
      finally
        TransactionTableObj.ProgressDlg.CloseDialog;
      end;
      AppEnvVirt.LogText(' CalcActualCost....done');
  end;
begin
try
  AppEnvVirt.LogText('');
  //BusobjPQACogs:= TTransactionPQACOGSDetails.createwithNewconn(nil);
  try
    AppEnvVirt.LogText(' MakeCOGSCost');
    if AppEnvVirt.Bool['CompanyPrefs.EnableCogsAdjustmentPosting'] then begin

        if (TransactionTableObj.COGSCoststatus = ccsSummary) then exit;   //COGS calculated for all data including prior to the closing date
        if (TransactionTableObj.COGSCoststatus = ccsCurrent) and not(SummaryDetailsTable) then exit; //COGS calculated for data after closing date and is called for the same

        TempQry1:= TERPQuery.Create(nil);
        TempQry2:= TERPQuery.Create(nil);
        TempScript:= TERPScript.Create(nil);
        try
          TempQry1.Connection   := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          TempQry2.Connection   := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          TempScript.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          TempScript.BeforeExecute := TransactionTableObj.MyScriptBeforeExecute;
          DoMakeTransPQA; // create temp PQA for cost -> table created from pqa and cost from the actual tranaction table

          if TempQry1.Active then TempQry1.Close;
          TempQry1.SQL.Text := 'Select * from  tbltransactionPQAs order by   ' +' ProductId, TransDate  , PQAID,transId, transLineId ;';
          TempQry1.Open;
          if TempQry1.RecordCount =0 then exit;

          DoCalcRunningQty; // for each product within the department, calculate a running quantity in the date order

          doCalcActualcost;  // calculates the actual cost of OUT transactions based on the IN transactions
          if DOBOMCogsudpate then begin   // If has BOM products, calculates the actual cost of the assembly based on the sub products and sub assemblies
            doCalcActualcost;// If has BOM products, recalculate the cost as the BOM product's costs are changed
            DOBOMCogsudpate;       // if subnodes are not manufactured and taken from stock, the other BOM transactions costs should be calculated before calculating the final cost
            doCalcActualcost;
          end;

          if SummaryDetailsTable then TransactionTableObj.COGSCoststatus := ccsSummary else TransactionTableObj.COGSCoststatus := ccscurrent;
          TempScript.SQL.clear;
          TempScript.SQL.add('update tbltransactionPQAs set ActualTotalcost     = 0 where ifnull(ActualTotalcost,0)   = 0;');
          TempScript.SQL.add('update tbltransactionPQAs set ActualTotalcostinc  = 0 where ifnull(ActualTotalcostinc,0)= 0;');
          TempScript.SQL.add('update tbltransactionPQAs set Totalcost           = 0 where ifnull(Totalcost,0)         = 0;');
          TempScript.SQL.add('update tbltransactionPQAs set Totalcostinc        = 0 where ifnull(Totalcostinc,0)      = 0;');
          TempScript.SQL.add('update tbltransactionPQAs set Linecost            = 0 where ifnull(Linecost,0)          = 0;');
          TempScript.SQL.add('update tbltransactionPQAs set Linecostinc         = 0 where ifnull(Linecostinc,0)       = 0;');
          TempScript.Execute;
        finally
          Freeandnil(TempQry1);
          Freeandnil(TempQry2);
          Freeandnil(TempScript);
        end;
        AppEnvVirt.LogText(' MakeCOGSCost....done');
    end;
  finally
     //Freeandnil(BusobjPQACogs);
  end;
Except
  on E:Exception do begin
    AppEnvVirt.LogTextLoge('Exception in MakeCOGSCost: ' + E.message);
  end;
end;
end;

end.
