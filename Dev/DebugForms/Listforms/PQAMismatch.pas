unit PQAMismatch;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,  DataState,
  AppEvnts, DAScript, MyScript, ComCtrls, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPQAMismatchGUI = class(TBaseListingGUI)
    ERPScript1: TERPScript;
    qryMainID: TIntegerField;
    qryMainseqno: TIntegerField;
    QrymainBOSeqno:TIntegerfield;
    qryMaintransId: TIntegerField;
    qryMainTransLineID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainBackOrder: TFloatField;
    qryMainbaselineno: TIntegerField;
    qryMainglobalref: TWideStringField;
    qryMaintype: TWideStringField;
    qryMainboid: TWideStringField;
    qryMainOriginalno: TWideStringField;
    qryMainbaseno: TWideStringField;
    qryMainboTransLineID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPQAID: TIntegerField;
    qryMaincount_PQAID: TLargeintField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainConverted: TWideStringField;
    qryMainAlloctype: TWideStringField;
    btnUpdate: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ERPScript1Error(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);   override;
    procedure FormShow(Sender: TObject);
    procedure ERPScript1BeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure updateAllclick1(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure TitleLabelDblClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);

  private
    tablename:String;
    Procedure Createtemptable;
    Procedure BeforeShowPQAMissingtypeGui (Sender:TObject);
    Procedure BeforeshowPQAMismatchDetailsGUI (Sender:TObject);
    Procedure beforeshowPQADetailsBOMismatchGUI(Sender:TObject);
    Procedure DeleteDupicatePQAs;
    function  ValidPQAID: Integer;
    procedure FixblankPOlinesnMakeifmissing;
    Procedure FixManPQAs;
    procedure FixSOBOPQAs;
    procedure FixInactivePQAs;
    function  invalidRecords: Integer;
    Function VerTablePrefix:String;
  Protected
  public

  end;


implementation

uses CommonDbLib, Commonlib,systemlib,  CommonFormLib, PQAMismatchDetails,
  PQADetailsBOMismatch, tcConst, PQAMissingtype, BusObjSales, busobjOrders,
  AppEnvironment, AppDatabase, BusObjProcTreePart, LogLib, PQALib,
  ERPVersionConst;

{$R *.dfm}

{ TPQAMismatchGUI }

Function TPQAMismatchGUI.invalidRecords:Integer;
var
  qry :TErpQuery;
begin
  inherited;
  qry:= TempMyquery;
  try
    qry.connection := ErpScript1.Connection;
    qry.SQl.add('Select PQAID from tblPQa PQa where ifnull(transtype,"") = "TProcTreePart" and ifnull(transLineId,0) not in (Select ProcTreePartId from tblproctreepart)  ;');
    qry.open;
    result := qry.recordcount;
  finally
    Freeandnil(qry);
  end;
end;

procedure TPQAMismatchGUI.ERPScript1BeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  stepProgressbar(copy(SQL,1,55));
end;

procedure TPQAMismatchGUI.ERPScript1Error(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  action := eaContinue ;
end;

procedure TPQAMismatchGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyUserTemporaryTable(tablename+'_1');
  DestroyUserTemporaryTable(tablename+'_2');
  DestroyUserTemporaryTable(tablename+'_3');
  DestroyUserTemporaryTable(tablename+'_4');
  DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TPQAMismatchGUI.FormCreate(Sender: TObject);
begin
  tablename := commondblib.GetUserTemporaryTableName('PQAMismatch');
  inherited;
  Createtemptable;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select * from ' +tablename+' order by originalno, globalref');
  RefreshOrignalSQL;

end;

procedure TPQAMismatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnUpdate.enabled := False;
  grpfilters.itemindex := 0;
end;

procedure TPQAMismatchGUI.grdMainDblClick(Sender: TObject);
begin
  if grpFilters.Itemindex = 0 then begin
    OpenErplistform('TPQAMismatchDetailsGUI' , BeforeshowPQAMismatchDetailsGUI);
  end else if grpFilters.Itemindex = 1 then begin
    OpenErplistform('TPQADetailsBOMismatchGUI' , beforeshowPQADetailsBOMismatchGUI);
  end else if grpfilters.itemindex = 2 then begin
    OpenErplistform('TPQAMissingtypeGui' , BeforeShowPQAMissingtypeGui);
  end else
    inherited;

end;

procedure TPQAMismatchGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'count_pqaid >1' ;
      end;
    1:
      begin
        GroupFilterString := qryMainboTransLineID.FieldName +' <> 0 and ' +
                             qryMainboTransLineID.FieldName +' <> NULL and ' +
                             QrymainPQAID.fieldname +' <> 0 and ' +
                             QrymainPQAID.fieldname +' <> NULL and ' +
                             qryMainActive.fieldname +' = "T" and '+
                             Qrymainboid.fieldname +' <> "" and ' +
                             Qrymainboid.fieldname +' <> NULL and ' +
                             qrymainshipped.fieldname +' =0';
      end;
    2:
      begin
        GroupFilterString := QrymainPQAID.fieldname +' = 0 OR ' +
                             QrymainPQAID.fieldname +' = NULL  ';
      end;
  end;


  inherited;

end;

procedure TPQAMismatchGUI.TitleLabelDblClick(Sender: TObject);
begin
  inherited;
  btnUpdate.enabled := True;
end;

procedure TPQAMismatchGUI.beforeshowPQADetailsBOMismatchGUI(Sender: TObject);
begin
  if not (Sender is    TPQADetailsBOMismatchGUI) then exit;
  TPQADetailsBOMismatchGUI(Sender).Originalno := qryMainOriginalno.asString;
  TPQADetailsBOMismatchGUI(Sender).Transtype := Qrymaintranstype.asString;
  TPQADetailsBOMismatchGUI(Sender).ProductId := QrymainProductID.asInteger;
  TPQADetailsBOMismatchGUI(Sender).globalref := QrymainGlobalref.asString;
  TPQADetailsBOMismatchGUI(Sender).Seqno := qrymainSeqno.asInteger;

end;

procedure TPQAMismatchGUI.BeforeshowPQAMismatchDetailsGUI(Sender: TObject);
begin
  if not (Sender is    TPQAMismatchDetailsGUI) then exit;
  TPQAMismatchDetailsGUI(Sender).transId := qrymaintransId.asInteger;
  TPQAMismatchDetailsGUI(Sender).TransLineID:= qrymaintranslineId.asInteger;
  TPQAMismatchDetailsGUI(Sender).transtype:= qrymaintranstype.asString;
end;

procedure TPQAMismatchGUI.BeforeShowPQAMissingtypeGui(Sender: TObject);
begin
  if not (Sender is    TPQAMissingtypeGui) then exit;
  TPQAMissingtypeGui(Sender).transId := qrymaintransId.asInteger;
  TPQAMissingtypeGui(Sender).TransLineID:= qrymaintranslineId.asInteger;
  TPQAMissingtypeGui(Sender).transtype:= qrymaintype.asString;
end;

procedure TPQAMismatchGUI.Createtemptable;
begin
  inherited;
  With ERPScript1 do begin
    connection := Qrymain.connection;
     SQL.add('Drop table if exists '+tablename+'_1;');
     SQL.add('Create table '+tablename+'_1 Select if(S.IsInvoice ="T" , "Invoice" , "SalesOrder") as type, Sl.seqno, Sl.SaleId as TransId, Sl.SAleLineId as TransLineId, Sl.ProductId, ');
     SQL.add('Sl.ProductName , Sl.QtySold, Sl.Shipped, Sl.BackOrder ,if(ifnull(sl.baselineno,0)=0 , ');
     SQL.add('Sl.SaleLineId, sl.baselineno) baselineno, s.globalref, s.boid,S.Originalno, s.baseno, s.Converted ');
     SQL.add('from tblSaleslines Sl ');
     SQL.add('inner join tblsales s on s.SaleId = Sl.SaleID where (S.IsInvoice ="T" or S.IsSalesOrder = "T") and Sl.Parttype ="Inv" and ifnull(sl.qtysold,0)<> 0;');
     SQL.add('ALTER TABLE '+tablename+'_1  CHANGE COLUMN TransLineID TransLineID INT(11) NOT NULL AUTO_INCREMENT ,  ADD PRIMARY KEY (TransLineID);');
     SQL.add('ALTER TABLE '+tablename+'_1  Add column boTransLineID int(11);');
     SQL.add('update  '+tablename+'_1 t inner join tblSales S on S.GlobalRef = ifnull(T.boid , "") ');
     SQL.add('inner join tblSalesLines SL on SL.SaleID = s.SaleId and ifnull(Sl.seqno,0) = ifnull(t.seqno , 0) ');
     SQL.add('and SL.ProductID = T.ProductId Set T.boTransLineID = Sl.SaleLineId;');
     SQL.add('Drop table if exists '+tablename+'_2;');

     SQL.add('Create table '+tablename+'_2');
     SQL.add('Select T.*  , PQA.TransType , PQA.Active ,PQA.Alloctype,  min(PQAID) PQAID,Count(PQAID) count_PQAID ');
     SQL.add('from '+tablename+'_1 T');
     SQL.add('Left  join tblPQA PQA  on T.transId = PQA.TransID and T.TransLineID = PQA.TransLineID ');
     SQL.add('and PQA.transtype in ("TInvoiceLine" , "TSalesOrderline" , "TRefundSaleLine" , "TPOSCashSaleline" , "TPOSLaybylines" , "TCashSaleLine" )');
     SQL.add('where (ifnull(T.backorder,0)<> 0 or ifnull(T.shipped,0) <> 0)');
     SQL.add('Group by transId, TransLineID, TransType, Alloctype');
     SQL.add('order by T.baselineno;');

     SQL.add('insert into   '+tablename+'_2 (type,seqno,TransId,TransLineID,ProductId,ProductName,QtySold,Shipped,BackOrder,baselineno,globalref,boid,Originalno,baseno,Converted,boTransLineID , TransType , Active ,Alloctype,  PQAID,count_PQAID)');
     SQL.add('Select');
     SQL.add('"SO-Man",T.seqno,T.TransId, PTP.ProctreePartID ,PTP.ProductId,PTP.ProductName,PTP.Qty,PTP.Qty,0,0,T.globalref,"",T.Originalno,"",T.Converted,0 ,');
     SQL.add('PQA.TransType , PQA.Active ,PQA.Alloctype,  min(PQAID) PQAID,Count(PQAID) count_PQAID');
     SQL.add('from  '+tablename+'_1 T');
     SQL.add('inner join tblProcTree PT on 	T.TransLineId = PT.masterID 		 and PT.Mastertype <> "mtProduct" and PT.ParentId<>0');
     SQL.add('inner join tblproctreepart PTP on PTP.ProcTreeId = PT.ProcTreeId');
     SQL.add('left join tblPQA PQA on PQA.TransLineId= PTP.ProctreePartID and PQA.Alloctype = "OUT" and PQA.Transtype = "TProcTreePart"');
     SQL.add('where PTP.PARTTYPE = "INV"');
     SQL.add('Group by transId, ProctreePartID, TransType, Alloctype;');

     SQL.add('insert into   '+tablename+'_2 (type,seqno,TransId,TransLineID,ProductId,ProductName,QtySold,Shipped,BackOrder,baselineno,globalref,boid,Originalno,baseno,Converted,boTransLineID , TransType , Active ,Alloctype,  PQAID,count_PQAID)');
     SQL.add('Select');
     SQL.add('"SO-ManIn",T.seqno,T.TransId, PTP.ProctreePartID ,PTP.ProductId,PTP.ProductName,PTP.Qty,PTP.Qty,0,0,T.globalref,"",T.Originalno,"",T.Converted,0 ,');
     SQL.add('PQA.TransType , PQA.Active ,PQA.Alloctype,  min(PQAID) PQAID,Count(PQAID) count_PQAID');
     SQL.add('from  '+tablename+'_1 T');
     SQL.add('inner join tblProcTree PT on 	T.TransLineId = PT.masterID  and PT.Mastertype <> "mtProduct" and PT.ParentId=0');
     SQL.add('inner join tblproctreepart PTP on PTP.ProcTreeId = PT.ProcTreeId');
     SQL.add('left join tblPQA PQA on PQA.TransLineId= PTP.ProctreePartID and PQA.Alloctype = "IN" and PQA.Transtype = "TProcTreePart"');
     SQL.add('where PTP.PARTTYPE = "INV"');
     SQL.add('Group by transId, ProctreePartID, TransType, Alloctype;');

     SQL.add('Drop table if exists '+tablename+'_3;');
     SQL.add('Create table '+tablename+'_3 Select "Purchase" as type, pl.seqno, pl.purchaseorderId, pl.purchaselineID, pl.ProductId, pl.ProductName , ');
     SQL.add('pl.QtySold, pl.Shipped, pl.BackOrder ,if(ifnull(pl.baselineno,0)=0 , pl.purchaselineID, pl.baselineno) baselineno, ');
     SQL.add('po.globalref, po.boid, Po.Originalno, po.baseno, "F" as Converted');
     SQL.add('from tblpurchaselines pl inner join tblpurchaseorders po on po.PurchaseOrderID = pl.PurchaseOrderID where po.ispo="T" ');
     SQL.add('and pl.Parttype ="Inv" and ifnull(pl.qtysold,0)<> 0;');
     SQL.add('ALTER TABLE '+tablename+'_3  CHANGE COLUMN purchaselineID purchaselineID INT(11) NOT NULL AUTO_INCREMENT ,  ADD PRIMARY KEY (purchaselineID);');
     SQL.add('ALTER TABLE '+tablename+'_3  Add column bopurchaselineID int(11);');
     SQL.add('update  '+tablename+'_3 t inner join tblpurchaseorders po on po.GlobalRef = ifnull(T.boid , "") ');
     SQL.add('inner join tblpurchaselines PL on PL.PurchaseOrderID= po.PurchaseOrderID and ifnull(pl.seqno,0) = ifnull(t.seqno , 0) ');
     SQL.add('and pL.ProductID = T.ProductId Set T.bopurchaselineID = pl.purchaselineId;');
     SQL.add('Drop table if exists '+tablename+'_4;');
     SQL.add('Create table '+tablename+'_4');
     SQL.add('Select T.*  , PQA.TransType , PQA.Active , PQa.Alloctype, min(PQAID) as PQAID , count(PQAID) as count_PQAID');
     SQL.add('from '+tablename+'_3 T');
     SQL.add('Left  join tblPQA PQA  on T.purchaseorderid = PQA.TransID and T.purchaselineid = PQA.TransLineID and PQA.transtype in ("TPurchaseOrderLine")');
     SQL.add('where (ifnull(T.backorder,0)<> 0 or ifnull(T.shipped,0) <> 0)');
     SQL.add('Group by  purchaseorderid , purchaselineid , Transtype , Alloctype');
     SQL.add('order by T.baselineno;');
     SQL.add('Drop table if exists '+tablename+';');
     SQL.add('Create table '+tablename+' Select * from '+tablename+'_2 union all select * from '+tablename+'_4;');
     SQL.add('ALTER TABLE '+tablename+'   ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST,  ');
     SQL.add('ADD UNIQUE INDEX transId_TransLineID_TransType (transId, TransLineID, TransType),  ADD PRIMARY KEY (ID);');
     SQL.add('ALTER TABLE '+tablename+'  Add column BOSeqno int(11);');
     showProgressbar(WAITMSG, SQL.count);
     try
      execute;
     finally
       HideProgressbar;
     end;
   end;
end;
function TPQAMismatchGUI.ValidPQAID:Integer;
var
  s:String;
  fbActive :Boolean;
begin
  Result := 0;
      s:= 'Select PQAId,active from tblPQA ' +
            ' where TransId = ' +inttostr(QrymaintransID.asInteger)+
            ' and TranslineId = ' +inttostr(QrymaintranslineID.asInteger) +
            ' and Alloctype = ' +Quotedstr(QrymainAlloctype.asString)  +
            ' and TransType = ' +Quotedstr(QrymainTranstype.asString) ;

  if SameText(QrymainTranstype.asString , TSalesOrderLine.classname) then begin
    if (qryMainconverted.asBoolean) or ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then  fbActive := False else fbActive := True;
  end else if SameText(QrymainTranstype.asString , TInvoiceLine.classname) then begin
    if ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then  fbActive := False else fbActive := True;
  end else if SameText(QrymainTranstype.asString , TPurchaseOrderLine.classname) then begin
    if ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then  fbActive := False else fbActive := True;
  end else if SameText(QrymainTranstype.asString , TProcTreePart.classname) then begin
    fbActive := True;
  end else exit;


  With tempMyquery do try
      SQL.add(s);
      open;
      if recordcount >0 then begin
        if locate('Active' , BooleanToStr(fbActive) , []) then begin
          result := fieldbyname('PQAID').asInteger;
          exit;
        end else begin
          if Fieldbyname('Active').asBoolean = not(fbActive) then begin
            ERPScript1.SQL.add('insert ignore into erpfix_pqa_fixed '+
              ' (GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef , fixtype)'+
              ' Select GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef  , 3'+
              ' from tblPQa where PQAId = ' + inttostr(fieldByname('pqaid').asInteger)+';');
            ERPScript1.SQL.add('update tblPQa set Active = '+ Quotedstr(BooleanToStr(fbActive))+' where PQAId = ' + inttostr(fieldbyname('PQAID').asInteger)+';');
            REsult :=fieldbyname('PQAID').asInteger;
            exit;
          end;
        end;
      end;
    finally
      closenFree;
    end;
end;
function TPQAMismatchGUI.VerTablePrefix: String;begin  result := replacestr(TABLE_VERSION , '.' , '');end;

procedure TPQAMismatchGUI.FixblankPOlinesnMakeifmissing;
var
  fdQty:Double;
  fbActive:Boolean;
  s:string;
  fsAlloctype:String;
  fbfound:boolean;
begin
  Qrymain.first;
    with TempMyQuery do try
      SQL.add('Select * from tblPQa  '+
              ' where TRansId =:TransId    '+
              ' and TransLineId = :TransLineId    '+
              ' and ifnull(Transtype, "") = ""   ');
      while Qrymain.Eof = False do begin
          fbfound:= False;
          if active then close;
          Parambyname('TransId').asInteger      := QrymaintransID.asInteger;
          Parambyname('TransLineId').asInteger  := QrymainTransLineId.asInteger;
          open;
          if recordcount = 0 then else begin
            First;
            if qryMainShipped.asFloat <> 0 then begin
              fdQty := qryMainShipped.asFloat ;
              if Qrymainconverted.asBoolean then fbActive := False else fbActive := True;
            end else begin
              fdQty := qryMainBackOrder.asFloat;
              if (Qrymainconverted.asBoolean) or ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then  fbActive := False else fbActive := True;
            end;
            if SAmeText(qryMaintype.asString , 'Purchase') then  fsAlloctype := 'IN'
            else if SAmeText(qryMaintype.asString , 'SO-Man') then  fsAlloctype := 'OUT'
            else if SAmeText(qryMaintype.asString , 'So-ManIn') then  fsAlloctype := 'IN'
            else fsAlloctype := 'OUT';

            While Eof = False do begin
              if Fieldbyname('Qty').asFloat = fdQty then begin
                ERPScript1.SQL.add('insert ignore into erpfix_pqa_fixed '+
                ' (GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef , fixtype)'+
                ' Select GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef , 4 '+
                ' from tblPQa where PQAId = ' + inttostr(fieldByname('pqaid').asInteger)+';');
                if SAmeText(qryMaintype.asString , 'Purchase') then s:= 'update tblPQa set Transtype = ' +Quotedstr(TPurchaseOrderLine.classname)
                else if SAmeText(qryMaintype.asString , 'SO-Man') then s:= 'update tblPQa set Transtype = ' +Quotedstr(TProcTreePart.classname)
                else if SAmeText(qryMaintype.asString , 'So-ManIn') then s:= 'update tblPQa set Transtype = ' +Quotedstr(TProcTreePart.classname)
                else if SAmeText(qryMaintype.asString , 'Invoice') then s:= 'update tblPQa set Transtype = ' +Quotedstr(TInvoiceline.classname)
                else if SAmeText(qryMaintype.asString , 'Salesorder') then s:= 'update tblPQa set Transtype = ' +Quotedstr(TSalesOrderLine.classname)
                else break;
                if fieldbyname('Active').asBoolean <> fbActive then s:= s+', Active = ' +Quotedstr(BooleanToStr(fbActive));
                if fieldbyname('alloctype').Asstring <> fsAlloctype then s:= s+', Alloctype = ' +Quotedstr(fsAlloctype);
                s:= s +' where PQAId = ' + inttostr(fieldByname('pqaid').asInteger)+';';
                ERPScript1.SQL.add(s);
                fbfound := true;
                break;
              end;
              NExt;
            end;
          end;
        if fbfound = False then begin
          s:= 'insert ignore into tblpqa '+
                ' ( TransLineID,  TransDate, Alloctype, UOM, UOMMultiplier, UOMID, DepartmentID, '+
                    'ProductID, ProductName,  TransID,  MatrixRef , TransType,Active,IsBO, Qty, UOMQty)';
           if SAmeText(qryMaintype.asString , 'Purchase') then begin
                s:= s + ' Select '+
                       'PL.PurchaseLineID , 	'+
                       'if(ifnull(PL.ReceivedDate,0) =0 , PO.OrderDate , PL.ReceivedDate),' +
                       '"IN" ,'+
                       'PL.UnitofMeasurePOLines, '+
                       'PL.UnitofMeasureMultiplier , '+
                       'PL.UnitOfMeasureID , '+
                       'PL.ClassID, '+
                       'PL.ProductID, '+
                       'PL.ProductName, '+
                       'PL.PurchaseOrderID, '+
                       'PL.MatrixRef,  '+
                       Quotedstr(TpurchaseOrderLine.className)+',' ;
                if ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then   s:= s + ' "F" ,' else s:= s + ' "T" ,';
                if qryMainShipped.asFloat <> 0  then s:= s + ' "F" ,PL.Shipped ,PL.UnitofMeasureShipped ' else s:= s +' "T" ,PL.BackOrder ,PL.UnitofMeasureBackorder ';
                s:= s +' from tblpurchaselines PL inner join tblpurchaseorders PO on PL.PurchaseOrderID = PO.PurchaseOrderID';
                s:= s +' where PL.PurchaseLineID = ' + inttostr(QrymainTranslineId.asInteger)+';';
           end else if  SAmeText(qryMaintype.asString , 'SO-Man') then begin
                s:= s+ ' Select PTP.ProcTreePartId , PTP.DateRequired, "OUT" ,PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , '+
                ' PTP.UnitOfMeasureId ,PTP.ClassId , PTP.ProductId ,  '+
                      ' PTP.ProductName , PTP.SaleId , PTP.MatrixRef, ' +
                      ' "TProcTreePart" ,"T" , "F" , PTP.Qty , PTP.UOMQty  '+
                      '   from tblproctreepart PTP where PTP.ProcTreePartId = ' + inttostr(QrymainTranslineId.asInteger)+';';
           end else if  SAmeText(qryMaintype.asString , 'So-ManIn') then begin
                 (*s:= s + ' Select '+
                        ' SL.SaleLineID , 	'+
                        ' if(ifnull(SL.ShipDate,0) =0 , S.ShipDate, SL.ShipDate),' +
                        ' "IN" ,'+
                        ' sL.UnitofMeasureSaleLines, '+
                        'sL.UnitofMeasureMultiplier , '+
                        'sL.UnitOfMeasureID , '+
                        'S.ClassID, '+
                        'SL.ProductID, '+
                        'SL.ProductName, '+
                        'SL.SaleID, '+
                        'SL.MatrixRef,  "TProcTreePart"  ,  "T" , "F" ,SL.Shipped ,SL.UnitofMeasureShipped ' ;
                s:= s + ' from tblSaleslines SL inner join tblSAles S on S.SaleID = SL.SaleID';
                s:= s +' where SL.SaleLineID = ' + inttostr(QrymainTranslineId.asInteger)+';';*)
                s:= s+ ' Select PTP.ProcTreePartId , PTP.DateRequired, "IN" ,PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , '+
                ' PTP.UnitOfMeasureId ,PTP.ClassId , PTP.ProductId ,  '+
                      ' PTP.ProductName , PTP.SaleId , PTP.MatrixRef, ' +
                      ' "TProcTreePart" ,"T" , "F" , PTP.Qty , PTP.UOMQty  '+
                      '   from tblproctreepart PTP where PTP.ProcTreePartId = ' + inttostr(QrymainTranslineId.asInteger)+';';
           end else begin
                s:= s + ' Select '+
                        ' SL.SaleLineID , 	'+
                        ' if(ifnull(SL.ShipDate,0) =0 , S.ShipDate, SL.ShipDate),' +
                        ' "OUT" ,'+
                        ' sL.UnitofMeasureSaleLines, '+
                        'sL.UnitofMeasureMultiplier , '+
                        'sL.UnitOfMeasureID , '+
                        'S.ClassID, '+
                        'SL.ProductID, '+
                        'SL.ProductName, '+
                        'SL.SaleID, '+
                        'SL.MatrixRef,  ';
                if SameText(Qrymaintype.asString , 'Invoice') then s:= s +Quotedstr(Tinvoiceline.classname)+',' else s:= s +Quotedstr(TSalesOrderLine.classname)+',';
                if (Qrymainconverted.asboolean) or ((qryMainboid.asString <> '') and (qryMainboTransLineID.asInteger<>0)) then   s:= s + ' "F" ,' else s:= s + ' "T" ,';
                if qryMainShipped.asFloat <> 0 then s:= s + ' "F" ,SL.Shipped ,SL.UnitofMeasureShipped ' else s:= s + ' "T" ,SL.BackOrder ,SL.UnitofMeasureBackorder ';
                s:= s + ' from tblSaleslines SL inner join tblSAles S on S.SaleID = SL.SaleID';
                s:= s +' where SL.SaleLineID = ' + inttostr(QrymainTranslineId.asInteger)+';';
           end;
           ERPScript1.SQL.add(s);
        end;
        Qrymain.Next;
      end;
    finally
      closenFree;
    end;
end;
procedure TPQAMismatchGUI.FixInactivePQAs;
var
  s:String;
begin
With TEmpMyQuery do try
  SQL.add('Select PQA.PQAID from tblpurchaseorders  PO ' +
            ' inner join tblpurchaselines PL on PO.PurchaseOrderID = PL.PurchaseOrderID ' +
            ' inner join tblPQA PQA on PL.PurchaseLineID = PQA.TransLineID and PL.PurchaseOrderID = PQA.TransID and PQA.TransType = "TPurchaseOrderLine" and PQA.ProductId = PL.ProductID ' +
            ' where  ifnull(PO.boid,"") =""  and ifnull(PQA.Active,"T") = "F" ' );
  open;
  s:= groupconcat('PQAID');
  if s = '' then exit;
  ERPScript1.SQL.add('update tblPQa set Active = "T" where PQAID in (' + s +') ;');


  Close;
  SQL.clear;
  SQL.add('Select PQA.PQAID  from tblsales  S ' +
            ' inner join tblsalesLines SL on S.SaleID = Sl.SaleID ' +
            ' inner join tblPQA PQA on Sl.SAleLineID = PQA.TransLineID and Sl.SaleID= PQA.TransID and PQA.TransType = "TInvoiceLine"  and PQA.ProductId = SL.ProductID ' +
            ' where  ifnull(S.boid,"") =""  and ifnull(PQA.Active,"T") = "F"' );
  open;
  s:= groupconcat('PQAID');
  if s = '' then exit;
  ERPScript1.SQL.add('update tblPQa set Active = "T" where PQAID in (' + s +') ;');

  Close;
  SQL.clear;
  SQL.add('Select PQA.PQAID from tblsales  S ' +
            ' inner join tblsalesLines SL on S.SaleID = Sl.SaleID ' +
            ' inner join tblPQA PQA on Sl.SAleLineID = PQA.TransLineID and Sl.SaleID= PQA.TransID and PQA.TransType = "TSalesOrderLine"  and PQA.ProductId = SL.ProductID ' +
            ' where  ifnull(S.boid,"") ="" and ifnull(PQA.Active,"T") = "F" and S.converted = "F"' );
  s:= groupconcat('PQAID');
  if s = '' then exit;
  ERPScript1.SQL.add('update tblPQa set Active = "T" where PQAID in (' + s +') ;');

finally
     ClosenFree;
end;

end;

procedure TPQAMismatchGUI.FixSOBOPQAs;
var
  s:String;
begin
With TEmpMyQuery do try
  SQL.add('Select PQA.PQAID from tblPqa PQa ' +
            ' inner join tblsaleslines Sl on  Sl.SaleId = PQa.TransId and Sl.SaleLineID = PQa.translineId ' +
            ' inner join tblSales S on S.SaleId = Sl.SaleId ' +
            ' where PQA.TransType = "TSalesOrderLine"  and S.converted = "T" and PQa.Active = "T" ' +
            ' and PQA.alloctype = "OUT" and ifnull(PQA.qty,0)<>0');
  open;
  s:= groupconcat('PQAID');
  if s = '' then exit;
  ERPScript1.SQL.add('update tblPQa set Active = "F" where PQAID in (' + s +') ;');
  if active then close;
  SQL.clear;

    SQL.add('Select PQA.PQAId' +
            ' from tblsales S inner join tblsaleslines SL on S.SaleId = Sl.SaleId' +
            ' inner join tblPQa PQa on PQa.TransLineID = Sl.SaleLineId and PQA.transId = Sl.saleId and PQa.transtype in ("TSalesOrderline" , "TInvoiceLine")' +
            ' where ifnull(S.boid,"")<> "" and PQA.Active = "T" and PQa.IsBO = "T"');
  s:= groupconcat('PQAID');
  if s = '' then exit;
  ERPScript1.SQL.add('update tblPQa set Active = "F" where PQAID in (' + s +') ;');
finally
  ClosenFree;
end;
end;
procedure TPQAMismatchGUI.FixManPQAs;
begin
  {backup tblproctreepart}
  if not tableexists('erpfix_proctreepart'+ VerTablePrefix+'') then
    ERPScript1.SQL.add(CreateTableSQL('erpfix_proctreepart'+ VerTablePrefix+'' ,  'tblproctreepart')+';');
  ERPScript1.SQL.add('insert ignore into erpfix_proctreepart'+ VerTablePrefix+' select * from tblproctreepart;') ;
  {backup tblproctree}
  if not tableexists('erpfix_proctree'+ VerTablePrefix+'') then
    ERPScript1.SQL.add(CreateTableSQL('erpfix_proctree'+ VerTablePrefix+'' ,  'tblproctree')+';');
  ERPScript1.SQL.add('insert ignore into erpfix_proctree'+ VerTablePrefix+' select * from tblproctree;');
  {delete pqa with productname and productid blank}
  ERPScript1.SQL.add('Delete from tblPQa where ifnull(ProductID,0) = 0 and ifnull(ProductName,"") = "";');
  {update pqa productname = part.partname where blank}
  ERPScript1.SQL.add('update  tblPQa PQA inner join tblParts P on PQA.ProductID  = P.PArtsID   ' +
                ' Set PQA.ProductName = P.Partname  Where ifnull(PQA.productname , "") = "" and ifnull(PQA.ProductID,0)<>0;');

  {update pa.productId= SL.productId}
  (*ERPScript1.SQL.add('update tblsaleslines SL inner join tblPQa PQa on PQa.TransLineID = Sl.SaleLineId and pqa.transtype = "TProcTreePart"   and PQA.Alloctype = "IN" ' +
      ' Set PQA.ProductId = SL.ProductId , PQA.ProductName = SL.ProductName ' +
      ' where SL.ProductId <> pqa.productId; ' );*)

  {wrong part type in saleslines }
  ERPScript1.SQL.add('update  tblSaleslines SL inner join tblParts P on P.PartsId = SL.ProductID ' +
                ' Set SL.Parttype = P.Parttype ' +
                ' where ifnull(SL.parttype , "") <> P.PartType;');

  {Delete PQAs of proctreepart with procid=0}
  ERPScript1.SQL.add('insert ignore into erpfix_pqa_fixed '+
                      ' (GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef , fixtype)'+
                      ' Select GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef  , 6'+
                      ' from tblPQa  where Transtype = "TProcTreePart" and TransLineId in (Select ProctreePartID from tblproctreepart where ifnull(ProcTreeID,0) = 0);');
  ERPScript1.SQL.add('Delete from tblPQa where Transtype = "TProcTreePart" and TransLineId in (Select ProctreePartID from tblproctreepart where ifnull(ProcTreeID,0) = 0);');

  {Delete proctreepart with procId =0}
  ERPScript1.SQL.add('Delete from tblproctreepart where ifnull(ProcTreeID,0) = 0;');

  {update proctreepart.partsId = proctree.partsID}
  ERPScript1.SQL.add('update  tblproctree PT inner join tblproctreepart ptp on PT.proctreeID= ptp.ProcTreeId  ' +
      ' Set PTP.productId = pt.partsId where PT.partsID <> ptp.ProductId;');
  {update pa.productId= proctreepart.productId}
  ERPScript1.SQL.add('update tblproctreepart ptp inner join tblPQa PQa on PQa.TransLineID = ptp.ProcTreePartId and pqa.transtype = "TProcTreePart"  ' +
      ' Set PQA.productId  = PTP.productId, PQa.productname = ptp.productname where ptp.ProductId <> pqa.productId;');


  {delete proctrees without sales}
  ERPScript1.SQL.add('Delete from tblproctree where mastertype<>"mtProduct" and  masterId not in (select salelineid from tblsaleslines);');


  {create proctreepart where missing}
  ERPScript1.SQL.add('insert into tblproctreePart  ' +
    ' (SaleId, SaleLineId, ProductId, ProductName, ProcTreeId, Qty, UOMQty, UOMQtyOriginal,  ' +
    ' UOMQtyUsed, UnitOfMeasure, UnitOfMeasureMultiplier, UnitOfMeasureId, ClassId, DateRequired, ' +
    ' Active, Parttype, MatrixDesc, MatrixRef, MatrixPrice) ' +
    ' Select SL.SaleId, SL.SaleLineID , PT.PartsId , P.PARTNAME , PT.ProcTreeId , PT.TotalQty, PT.TreePartUOMTotalQty , ' +
    ' PT.TreePartUOMTotalQty , PT.TreePartUOMTotalQty , PT.TreePartUOM , PT.TreePartUOMMultiplier , PT.TreePartUOMID , ' +
    ' S.ClassID , ifnull(SL.ShipDate , S.ShipDate) , "T" , "INV" , PT.MatrixDesc , PT.MatrixRef , PT.MatrixPrice ' +
    ' from tblsales S ' +
    ' inner join tblsaleslines SL on S.saleId = Sl.sAleId ' +
    ' inner join tblProcTree PT on SL.SaleLineid = PT.MasterId and PT.MasterType="mtSalesOrder" ' +
    ' inner join tblParts P on P.PARTSID = PT.PartsId ' +
    ' Left join tblproctreepart PTP on PTP.ProcTreeId = PT.ProcTreeId ' +
    ' where P.PartType = "Inv"  and PT.PartSource<> "psStock"' +
    ' and ifnull(PTP.ProcTreeId,0) =0 and ifnull(PT.TotalQty,0) <> 0;');

  {Create PQa for missing proctreepart -In for main product}
  ERPScript1.SQL.add('insert into tblPQa (TransLineID, TransType, TransDate, Alloctype, IsBO, Qty,   ' +
    ' UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved,  MatrixRef)  ' +
    ' Select PTP.ProcTreePartId , "TProcTreePart" , PTP.DateRequired, "IN" , "F" , PTP.Qty , PTP.UOMQty ,   ' +
    ' PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , PTP.UnitOfMeasureId , PTP.ClassId , PTP.ProductId ,   ' +
    ' PTP.ProductName , "T" , PTP.SaleId , "F" , PTP.MatrixRef   ' +
    ' from tblproctreepart PTP  inner join tblProcTree Pt on PT.ProcTreeId = PTP.proctreeId' +
    ' where PTP.Parttype = "INV" and ifnull(PT.ParentId,0) =0 and PTP.ProcTreePartId not in (Select TransLineId from tblPQA PQA where  PQA.transtype = "TProcTreePart");');

  {Create PQa for missing proctreepart -OUT for sub products}
  ERPScript1.SQL.add('insert into tblPQa (TransLineID, TransType, TransDate, Alloctype, IsBO, Qty,   ' +
    ' UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved,  MatrixRef)  ' +
    ' Select PTP.ProcTreePartId , "TProcTreePart" , PTP.DateRequired, "OUT" , "F" , PTP.Qty , PTP.UOMQty ,   ' +
    ' PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , PTP.UnitOfMeasureId , PTP.ClassId , PTP.ProductId ,   ' +
    ' PTP.ProductName , "T" , PTP.SaleId , "F" , PTP.MatrixRef   ' +
    ' from tblproctreepart PTP  inner join tblProcTree Pt on PT.ProcTreeId = PTP.proctreeId' +
    ' where PTP.Parttype = "INV" and ifnull(PT.ParentId,0) <> 0 and PTP.ProcTreePartId not in (Select TransLineId from tblPQA PQA where  PQA.transtype = "TProcTreePart");');

  {building qty pqa should be inactive until SO is converted}
  ERPScript1.SQL.add('update  tblSales S  ' +
    ' inner join tblSaleslines SL on S.SaleID = Sl.SAleId  ' +
    ' inner join tblproctree PT on Sl.SaleLineId	= PT.masterID and PT.ParentID<>0		and 	PT.Mastertype <> "mtProduct"  ' +
    ' inner join tblproctreepart	PTP	 on PTP.ProcTreeId = PT.ProcTreeId  ' +
    ' inner join tblPQA	PQA	 on PTP.ProcTreePartId = PQA.TransLineID			  ' +
    ' and 	pqa.Active = "T"		 and 	pqa.Alloctype = "OUT"		 and 	PQA.Transtype ="TprocTreePart"  ' +
    ' set PQA.Active = "F"  ' +
    ' where  S.converted = "F"  ;' );

  ERPScript1.SQL.add('update  tblSales S  ' +
    ' inner join tblSaleslines SL on S.SaleID = Sl.SAleId  ' +
    ' inner join tblproctree PT on Sl.SaleLineId	= PT.masterID and PT.ParentID<>0		and 	PT.Mastertype <> "mtProduct"  ' +
    ' inner join tblproctreepart	PTP	 on PTP.ProcTreeId = PT.ProcTreeId  ' +
    ' inner join tblPQA	PQA	 on PTP.ProcTreePartId = PQA.TransLineID			  ' +
    ' and 	pqa.Active = "F"		 and 	pqa.Alloctype = "OUT"		 and 	PQA.Transtype ="TprocTreePart"  ' +
    ' set PQA.Active = "T"  ' +
    ' where  S.converted = "T"  ;' ) ;

  {update sl.productname from proctree}
  ERPScript1.SQL.add('  update' +
    ' tblsaleslines SL' +
    ' inner join tblProcTree Pt  on Sl.SaleLineId	= PT.masterID and PT.ParentID=0	 and 	PT.Mastertype <> "mtProduct"' +
    ' Set SL.productname = PT.caption, SL.productId = Pt.partsID' +
    ' Where Pt.PartsId <> Sl.productId;');

  {update pqa.productname from SL}
  ERPScript1.SQL.add('  update' +
    ' tblsaleslines SL' +
    ' inner join tblPQa PQA on PQA.TransID = SL.saleId and PQA.transLineId = Sl.SaleLineID and  PQa.transtype in ("TSalesOrderLine"   , "TInvoiceLine")' +
    ' Set PQa.ProductId = SL.ProductId, PQA.ProductName = SL.Productname' +
    ' Where Sl.productname<>  PQA.ProductName;');

  {pqa.active =f when so is converted}
  ERPScript1.SQL.add('   update tblsales S' +
    ' inner join tblSAleslines Sl on s.saleId = sl.SaleId' +
    ' inner join tblPQa PQa on PQA.transId = Sl.saleId and PQa.transLineId = SL.salelineId and PQA.transtype = "TSalesOrderLine"' +
    ' set PQa.Active = "F"' +
    ' where S.converted ="T" and  PQa.active ="T" and SL.shipped <> 0;');

  ERPScript1.SQL.add('   update tblsales S' +
    ' inner join tblSAleslines Sl on s.saleId = sl.SaleId' +
    ' inner join tblPQa PQa on PQA.transId = Sl.saleId and PQa.transLineId = SL.salelineId and PQA.transtype = "TSalesOrderLine"' +
    ' set PQa.Active = "T"' +
    ' where S.converted ="F" and  PQa.active ="F" and SL.shipped <> 0;');

  {Delete PQA of from stock man items}
  ERPScript1.SQL.add(' Delete from tblPQa where transLineId in (Select ProcTreePartId from tblproctreepart '+
              ' where proctreeId in (Select ProcTreeId from tblprocTree where partsource  = "psStock")) and TransType = "TProcTreePart";'+
              ' Delete from tblproctreepart where proctreeId in (Select ProcTreeId from tblprocTree where partsource  = "psStock");');
  ERPScript1.SQL.add(' Delete from tblPQa  '+
              ' where transtype in ("TInvoiceLine" , "TSalesOrderline" , "TRefundSaleLine" , "TPOSCashSaleline" , "TPOSLaybylines" , "TCashSaleLine")  '+
              ' and TransLineId not in (select saleLineId from tblsaleslines);');

  ERPScript1.SQL.add(' Delete from tblproctreepart where proctreeId not in (select proctreeId from tblproctree);');
  ERPScript1.SQL.add(' Delete from tblPQa where transtype in (' + ManufactureTypes +') and  transLineId not in (Select ProcTreePartId from tblproctreepart ) ;');

end;

procedure TPQAMismatchGUI.DeleteDupicatePQAs;
 var
  PQAID:Integer;
begin
  Qrymain.first;
    with TempMyQuery do try
      SQL.add('Select * from tblPQa  '+
              ' where TRansId =:TransId    '+
              ' and TransLineId = :TransLineId    '+
              ' and Transtype = :Transtype   '+
              ' and Alloctype = :alloctype   '+
              ' and PQAID <> :PQAID');
      while Qrymain.Eof = False do begin
        PQAID:= ValidPQAID;
        if PQAID <> 0 then begin
          if active then close;
          Parambyname('TransId').asInteger      := QrymaintransID.asInteger;
          Parambyname('TransLineId').asInteger  := QrymainTransLineId.asInteger;
          Parambyname('Transtype').asString     := QrymainTranstype.asString;
          Parambyname('alloctype').asString     := Qrymainalloctype.asString;
          Parambyname('PQAId').asInteger        := PQAID;
          open;
          if recordcount > 0 then begin
            First;
            While Eof = False do begin
              ERPScript1.SQL.add('insert ignore into erpfix_pqa_fixed '+
                      ' (GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef , fixtype)'+
                      ' Select GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef  , 5'+
                      ' from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
              ERPScript1.SQL.add('delete from tblPQa where PQAId = ' +inttostr(fieldbyname('PQAID').asInteger)+';');
              Next;
            end;
          end;
        end;
        Qrymain.Next;
      end;
    finally
      closenFree;
    end;
end;

procedure TPQAMismatchGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  With ScriptMain do begin
    SQL.clear;
    {pqa backup}
    SQL.add('create table if not exists erpfix_pqa_'+ VerTablePrefix + '  like tblpqa;');
    SQL.add('insert ignore into erpfix_pqa_'+ VerTablePrefix + '  Select * from tblpqa ;');

    {make PQAs for missing polines}
    SQL.add('Insert ignore into tblpqa (TranslineId, transtype, transdate, alloctype, isbo, qty, uomqty, uom, uommultiplier, uomid, departmentId, productId, productname, active, transId, REserved )'+
              '  Select pol.PurchaseLineID ,"TPurchaseOrderLine" , pol.ReceivedDate , "IN" , if(pol.Shipped=0,"T" , "F") isbo, if(pol.Shipped<> 0, pol.Shipped, pol.QtySold) qty, '+
              ' if(pol.Shipped<> 0, pol.UnitofMeasureShipped, pol.UnitofMeasureQtySold) ,  pol.UnitofMeasurePOLines , pol.UnitofMeasureMultiplier, pol.UnitOfMeasureID, pol.ClassID, '+
              ' pol.ProductID, pol.ProductName, "T", pol.PurchaseOrderID, "F" '+
              ' from tblpurchaselines  				pol '+
              ' left join tblpqa pqa  on pqa.TransLineID 	= pol.PurchaseLineID and pqa.TransType in ('+ POTranstypes +')  where pol.PARTTYPE ="INV" and  ifnull(pqa.pqaid ,0)=0;');

    {make PQAs for missing sales lines}
    SQL.add('Insert ignore into tblpqa (TranslineId, transtype, transdate, alloctype, isbo, qty, uomqty, uom, uommultiplier, uomid, departmentId, productId, productname, active, transId, REserved )'+
              '  Select SL.SaleLineId ,"TSalesOrderLine" , SL.ShipDate , "OUT" , if(SL.Shipped=0,"T" , "F") isbo, if(SL.Shipped<> 0, SL.Shipped, SL.QtySold) qty, '+
              ' if(SL.Shipped<> 0, SL.UnitofMeasureShipped, SL.UnitofMeasureQtySold) ,  SL.UnitofMeasureSaleLines , SL.UnitofMeasureMultiplier, SL.UnitOfMeasureID, S.ClassID, '+
              ' SL.ProductID, SL.ProductName, if(S.converted ="T" , "F" , "T"), SL.SaleID, "F" '+
              ' from tblsales S inner join tblsaleslines sl on s.saleId = sl.saleId and S.isSalesorder ="T" '+
              ' left join tblpqa pqa  on pqa.TransLineID 	= SL.saleLineId and pqa.TransType in ("TSalesOrderLine")  where SL.PARTTYPE ="INV" and  ifnull(pqa.pqaid ,0)=0;');

    SQL.add('Insert ignore into tblpqa (TranslineId, transtype, transdate, alloctype, isbo, qty, uomqty, uom, uommultiplier, uomid, departmentId, productId, productname, active, transId, REserved )'+
              '  Select SL.SaleLineId ,"TInvoiceLine" , SL.ShipDate , "OUT" , if(SL.Shipped=0,"T" , "F") isbo, if(SL.Shipped<> 0, SL.Shipped, SL.QtySold) qty, '+
              ' if(SL.Shipped<> 0, SL.UnitofMeasureShipped, SL.UnitofMeasureQtySold) ,  SL.UnitofMeasureSaleLines , SL.UnitofMeasureMultiplier, SL.UnitOfMeasureID, S.ClassID, '+
              ' SL.ProductID, SL.ProductName, if(S.converted ="T" , "F" , "T"), SL.SaleID, "F" '+
              ' from tblsales S inner join tblsaleslines sl on s.saleId = sl.saleId and S.IsInvoice ="T" '+
              ' left join tblpqa pqa  on pqa.TransLineID 	= SL.saleLineId and pqa.TransType in ("TInvoiceLine")  where SL.PARTTYPE ="INV" and  ifnull(pqa.pqaid ,0)=0;');

    SQL.add('Insert ignore into tblpqa (TranslineId, transtype, transdate, alloctype, isbo, qty, uomqty, uom, uommultiplier, uomid, departmentId, productId, productname, active, transId, REserved )'+
              '  Select SL.SaleLineId ,"TCashSaleLine" , SL.ShipDate , "OUT" , if(SL.Shipped=0,"T" , "F") isbo, if(SL.Shipped<> 0, SL.Shipped, SL.QtySold) qty, '+
              ' if(SL.Shipped<> 0, SL.UnitofMeasureShipped, SL.UnitofMeasureQtySold) ,  SL.UnitofMeasureSaleLines , SL.UnitofMeasureMultiplier, SL.UnitOfMeasureID, S.ClassID, '+
              ' SL.ProductID, SL.ProductName, if(S.converted ="T" , "F" , "T"), SL.SaleID, "F" '+
              ' from tblsales S inner join tblsaleslines sl on s.saleId = sl.saleId and S.IsCashSale ="T" '+
              ' left join tblpqa pqa  on pqa.TransLineID 	= SL.saleLineId and pqa.TransType in ("TCashSaleLine")  where SL.PARTTYPE ="INV" and  ifnull(pqa.pqaid ,0)=0;');

    {delete duplicate pqa}
    SQL.add('Delete from tblPQA where ifnull(TransType,"") = "";');
    SQL.add('Drop table if exists tmp_1;');
    SQL.add('create table tmp_1 like tblpqa;');
    SQL.add('insert ignore into tmp_1 Select * from tblpqa group by TransId, TransLineId , Transtype , alloctype ;');
    SQL.add('truncate tblpqa ;');
    SQL.add('insert ignore into tblpqa select * from tmp_1;');
    SQL.add('Drop table if exists tmp_1;');


    {delete proctrees of deleted lines}
    SQL.add('Delete from tblproctree where mastertype<>"mtProduct" and  masterId not in (select salelineid from tblsaleslines);');

    {make missin g proctreepart }
    SQL.add('insert into tblproctreePart  (SaleId, SaleLineId, ProductId, ProductName, ProcTreeId, Qty, UOMQty, UOMQtyOriginal,  UOMQtyUsed, '+
              ' UnitOfMeasure, UnitOfMeasureMultiplier, UnitOfMeasureId, ClassId, DateRequired, Active, Parttype, MatrixDesc, MatrixRef, MatrixPrice)  '+
              ' Select SL.SaleId, SL.SaleLineID , PT.PartsId , P.PARTNAME , PT.ProcTreeId , PT.TotalQty, PT.TreePartUOMTotalQty , PT.TreePartUOMTotalQty , '+
              ' PT.TreePartUOMTotalQty , PT.TreePartUOM , PT.TreePartUOMMultiplier , PT.TreePartUOMID , S.ClassID , ifnull(SL.ShipDate , S.ShipDate) , "T" , '+
              ' P.PartType , PT.MatrixDesc , PT.MatrixRef , PT.MatrixPrice  '+
              ' from tblsales S  '+
              ' inner join tblsaleslines SL on S.saleId = Sl.sAleId  '+
              ' inner join tblProcTree PT on SL.SaleLineid = PT.MasterId and PT.MasterType="mtSalesOrder"  '+
              ' inner join tblParts P on P.PARTSID = PT.PartsId  '+
              ' Left join tblproctreepart PTP on PTP.ProcTreeId = PT.ProcTreeId  '+
              ' where PT.PartSource<> "psStock"and ifnull(PTP.ProcTreeId,0) =0 and ifnull(PT.TotalQty,0) <> 0;');

    {delete proctreeparts of deleted nodes}
    SQL.add('Delete from tblproctreepart where ifnull(ProcTreeID,0) = 0;');

    {"TPrctreePart"  - "IN" for the root node}
    SQL.add('insert into tblPQa (TransLineID, TransType, TransDate, Alloctype, IsBO, Qty,    UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved,  MatrixRef)   '+
              ' Select PTP.ProcTreePartId , "TProcTreePart" , PTP.DateRequired, "IN" , "F" , PTP.Qty , PTP.UOMQty ,    PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , PTP.UnitOfMeasureId , PTP.ClassId , '+
              ' PTP.ProductId ,    PTP.ProductName , "T" , PTP.SaleId , "F" , PTP.MatrixRef    '+
              ' from tblproctreepart PTP  '+
              ' inner join tblProcTree Pt on PT.ProcTreeId = PTP.proctreeId '+
              ' where PTP.Parttype = "INV" and ifnull(PT.ParentId,0) =0 and PTP.ProcTreePartId not in (Select TransLineId from tblPQA PQA where  PQA.transtype = "TProcTreePart");');

    {*"TPrctreePart"  - "OUT" for the non sroot node}
    SQL.add('insert into tblPQa (TransLineID, TransType, TransDate, Alloctype, IsBO, Qty,    UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved,  MatrixRef)   '+
              ' Select PTP.ProcTreePartId , "TProcTreePart" , PTP.DateRequired, "OUT" , "F" , PTP.Qty , PTP.UOMQty ,    PTP.UnitOfMeasure , PTP.UnitOfMeasureMultiplier , PTP.UnitOfMeasureId , PTP.ClassId , '+
              ' PTP.ProductId ,    PTP.ProductName , "T" , PTP.SaleId , "F" , PTP.MatrixRef    '+
              ' from tblproctreepart PTP  '+
              ' inner join tblProcTree Pt on PT.ProcTreeId = PTP.proctreeId '+
              ' where PTP.Parttype = "INV" and ifnull(PT.ParentId,0) <> 0 and PTP.ProcTreePartId not in (Select TransLineId from tblPQA PQA where  PQA.transtype = "TProcTreePart");');

    {Delete PQA of from stock man items}
    SQL.add('Delete from tblPQa where transLineId in (Select ProcTreePartId from tblproctreepart where proctreeId in (Select ProcTreeId from tblprocTree where partsource  = "psStock")) and TransType = "TProcTreePart";');
    SQL.add('Delete from tblproctreepart where proctreeId in (Select ProcTreeId from tblprocTree where partsource  = "psStock");');

    SQL.add('delete pqa.* from tblpqa pqa where not (transtype in ('+ salesTranstypes+', '+ ManufactureTypes +' , '+ POTranstypes +', '+ RepairType +','+ StockMovementtypes +' , "TSalesOrderInvoiceLines"));');

    SQL.add('delete PQA.* from tblpqa pqa left join tblsaleslines 						sl 	on pqa.TransLineID	= sl.saleLineId 						where pqa.transtype in ('+ salesTranstypes    +') and ifnull(Sl.saleLineId        ,0)=0;');
    SQL.add('delete pqa.* from tblpqa pqa left join tblproctreepart 					ptp on pqa.TransLineID 	= ptp.ProcTreePartId  			where pqa.TransType in ('+ ManufactureTypes   +') and ifnull(ptp.ProcTreePartId   ,0)=0;');
    SQL.add('delete pqa.* from tblpqa pqa left join tblpurchaselines  				pol on pqa.TransLineID 	= pol.PurchaseLineID  			where pqa.TransType in ('+ POTranstypes       +') and ifnull(pol.PurchaseLineID   ,0)=0;');
    SQL.add('delete pqa.* from tblpqa pqa left join tblrepairparts  				  rp  on pqa.TransLineID  = rp.RepairPartsID 					where pqa.TransType in ('+ RepairType         +') and ifnull(rp.RepairPartsID     ,0)=0;');
    SQL.add('delete pqa.* from tblpqa pqa left join tblstockmovementlines  	  sml on pqa.TransLineID  = sml.StockmovementLinesID 	where pqa.TransType in ('+ StockMovementtypes +') and ifnull(sml.StockmovementLinesID  ,0)=0 ;');
    SQL.add('delete pqa.* from tblpqa pqa left join tblsalesorderinvoicelines soil on pqa.TransLineID = soil.SOInvoiceLineID 	where pqa.TransType in ("TSalesOrderInvoiceLines") 		and ifnull(soil.SOInvoiceLineID ,0)=0;');

    SQL.add('update tblsaleslines 		    sl  inner join tblparts p on sl.ProductID   = p.partsId set sl.ProductName  = p.PARTNAME, sl.PARTTYPE   = p.PARTTYPE;');
    SQL.add('update tblproctreepart   	  ptp inner join tblparts p on ptp.ProductId  = p.partsId set ptp.ProductName = p.PARTNAME, ptp.Parttype  = p.PARTTYPE;');
    SQL.add('update tblpurchaselines      pol inner join tblparts p on pol.ProductId  = p.partsId set pol.ProductName = p.PARTNAME, pol.Parttype  = p.PARTTYPE;');
    SQL.add('update tblrepairparts 	      rp  inner join tblparts p on rp.PartsID     = p.partsId set rp.PartName     = p.PARTNAME, rp.PartType   = p.PARTTYPE;');
    SQL.add('update tblstockmovementlines sml inner join tblparts p on sml.ProductID  = p.partsId set sml.ProductName = p.PARTNAME, sml.Parttype  = p.PARTTYPE;');

    SQL.add('update tblpqa pqa   '+
              ' inner join tblsaleslines 	sl 	  on pqa.TransLineID	= sl.saleLineId 						  '+
              ' inner join tblsales S on s.saleId  = sl.saleId        '+
              ' Set pqa.active = if(s.converted ="T", "F" , "T"),   '+
              ' pqa.productId = sl.productID,  '+
              ' pqa.productname = sl.productname,  '+
              ' PQA.Qty = if(ifnull(sl.shipped,0)<> 0 ,sl.shipped, sl.qtysold) ,   '+
              ' PQA.UOMQty =  if(ifnull(UnitofMeasureShipped,0)<> 0 ,UnitofMeasureShipped, UnitofMeasureQtySold),  '+
              ' isbo = if(ifnull(sl.shipped,0)<> 0 ,"F", "T")   '+
              ' where pqa.transtype in ('+ salesTranstypes+');' ) ;

    SQL.add('update tblpqa pqa   '+
              ' inner join tblproctreepart ptp   on pqa.TransLineID 	= ptp.ProcTreePartId  			  '+
              ' inner join tblsales S on ptp.saleId= s.saleId         '+
              ' set pqa.active = if(S.Converted="T" , "T", "F"),    '+
              ' pqa.productId = ptp.ProductId,  '+
              ' pqa.productname = ptp.ProductName,  '+
              ' pqa.qty = ptp.Qty,  '+
              ' pqa.UOMQty = ptp.UOMQty   '+
              ' where pqa.TransType in ('+ ManufactureTypes +');');

    SQL.add('update tblpqa pqa   '+
              ' inner join tblsalesorderinvoicelines  soil  on pqa.TransLineID  = soil.SOInvoiceLineID 	      '+
              ' inner join tblparts p on p.PARTSID = soil.ProductId   '+
              ' set pqa.ProductID = soil.ProductId,  '+
              ' pqa.ProductName = p.PARTNAME,  '+
              ' pqa.Qty = soil.Qty,  '+
              ' pqa.uomqty = soil.UOMQty where pqa.TransType in ("TSalesOrderInvoiceLines") ;');

    SQL.add('update tblpqa pqa   '+
              ' inner join tblpurchaselines  				  pol   on pqa.TransLineID 	= pol.PurchaseLineID  			  '+
              ' set pqa.ProductID = pol.ProductID,  '+
              ' pqa.Productname = pol.Productname,  '+
              ' pqa.Qty = if(pol.shipped<>0 , pol.shipped, pol.QtySold),   '+
              ' pqa.uomQty = if(pol.UnitofMeasureShipped<>0 , pol.UnitofMeasureShipped, pol.UnitofMeasureQtySold),   '+
              ' pqa.isbo = if(pol.shipped<>0 , "F", "T"), pqa.active ="T"    '+
              ' where pqa.TransType in ('+ POTranstypes +');');
    SQL.add('update tblpqa pqa   '+
              ' inner join tblrepairparts  					  rp    on pqa.TransLineID  = rp.RepairPartsID 					  '+
              ' Set pqa.productid = rp.PartsID,  '+
              ' pqa.ProductName = rp.PartName,  '+
              ' pqa.Qty = rp.Qty,  '+
              ' pqa.UOMQty = rp.UOMQty   '+
              ' where pqa.TransType in ('+ RepairType +');');
    SQL.add('update tblpqa pqa   '+
              ' inner join tblstockmovementlines  	  sml   on pqa.TransLineID  = sml.StockmovementLinesID 	  '+
              ' Set pqa.ProductID = sml.ProductID,  '+
              ' pqa.ProductName = sml.ProductName,  '+
              ' pqa.Qty = sml.Qty,  '+
              ' pqa.UOMQty = sml.UOMQty where pqa.TransType in ('+ StockMovementtypes +') ;');
    SQL.add('  Delete CS_Pqa.* ' +
              '  From ' +
              '  tblsales s ' +
              ' inner join tblsaleslines SL  on s.saleId = sl.saleid and s.iscashsale ="T" and s.IsPOS ="T" ' +
              ' inner join  tblPQa CS_Pqa on CS_Pqa.transId = sl.saleId and CS_Pqa.transLineid = sl.saleLineId and CS_Pqa.transtype in ("TCashSaleLine") ' +
              ' inner join  tblPQa POS_Pqa on POS_Pqa.transId = sl.saleId and POS_Pqa.transLineid = sl.saleLineId and POS_Pqa.transtype in ("TPOSCashSaleline");');
    SQL.add('  Delete ' +
              ' pqa.* ' +
              ' From tblpurchaseorders PO ' +
              ' inner join tblpurchaselines PL on PO.purchaseOrderId = PL.PurchaseOrderID ' +
              ' inner join tblpqa pqa on pqa.TransID = PL.PurchaseOrderID and pqa.TransLineID = PL.PurchaseLineID and pqa.TransType = "TPurchaseOrderLine" ' +
              ' where PO.ispo ="F" and PO.isRA="T";');

    SQL.add('  update  ' +
              ' tblsales S inner join tblsaleslines SL on S.saleId = SL.saleId ' +
              ' inner join tblpqa pqa on pqa.transId = sl.saleId and pqa.translineid = sl.salelineId and pqa.transtype = "TRefundSaleLine" ' +
              ' Set pqa.qty = 0-sl.shipped, pqa.uomqty := 0- SL.UnitofMeasureShipped ' +
              ' where pqa.Qty <0;');

    SQL.add('  update  ' +
              ' tblsales S inner join tblsaleslines SL on S.saleId = SL.saleId  ' +
              ' inner join tblpqa pqa on pqa.transId = sl.saleId and pqa.translineid = sl.salelineId and pqa.transtype = "TInvoiceLine"  ' +
              ' set pqa.active ="T"  ' +
              ' where pqa.active ="F" and ifnull(SL.shipped,0)<> 0;');

    SQL.add('  update tblsales s inner join tblsaleslines SL  on s.saleId = sl.saleId  ' +
              ' inner join tblproctree PT on SL.saleLineId = PT.masterID and ifnull(ParentID,0)=0  ' +
              ' inner  join tblproctreepart pp on Pt.proctreeId = pp.proctreeId  ' +
              ' inner join tblPqa pqa on pqa.translineId = pp.ProcTreePartId and pqa.transtype = "TProcTreePart" and pqa.alloctype ="IN"  ' +
              ' set pqa.active ="T"  ' +
              ' where s.converted ="T" and pqa.active ="F";');


  clog(SQL.text);
  Execute;
  end;
end;

procedure TPQAMismatchGUI.btnUpdateClick(Sender: TObject);
begin
  inherited;
  ERPScript1.SQl.clear;
  FixblankPOlinesnMakeifmissing;
  DeleteDupicatePQAs;

  showProgressbar(waitmsg , ERPScript1.SQL.count);
  try
    ERPScript1.execute;
  finally
    Hideprogressbar;
  end;
end;

procedure TPQAMismatchGUI.updateAllclick1(Sender: TObject);
var
  tablename :String;
begin
  inherited;
  logtext('updating the db-> invalid records:' + inttostr(invalidRecords));
    showProgressbar(waitmsg , 7);
    try
      Tablename := 'Erpfix_pqa_'+ VerTablePrefix;
      ERPScript1.SQL.clear;
      if not tableexists(tablename) then
        ERPScript1.SQL.add(CreateTableSQL(tablename , 'tblpqa')+';');
      ERPScript1.SQL.add('Insert ignore into ' +tablename +
          ' (GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, '+
          '  UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef)'+
          '  Select GlobalRef, PQAID, TransLineID, TransType, TransDate, Alloctype, IsBO, Qty, UOMQty, UOM, '+
          '  UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, Active, TransID, Reserved, msTimeStamp, MatrixRef '+
          '  from tblPQA;');
      ERPScript1.SQL.add('update tblSaleslines  SL '+
                        ' inner join tblpqa PQA on PQa.transId = Sl.SaleId and PQa.TransLineId = Sl.SaleLineId and PQa.transtype in (' + SalesTransTypes+') and SL.ProductId = PQa.ProductID '+
                        ' Set PQA.Qty = if(ifnull(shipped,0)<> 0 ,shipped, qtysold) ,  '+
                        ' PQA.UOMQty =  if(ifnull(UnitofMeasureShipped,0)<> 0 ,UnitofMeasureShipped, UnitofMeasureQtySold) '+
                        ' where ifnull(SL.ProductId,0) <> 0 ;');
                        //' where ifnull(SL.qtysold,0) = 0 and ifnull(SL.ProductId,0) <> 0 and pqa.qty <> 0;');

      ERPScript1.SQL.add('update tblpurchaselines  PL '+
                        ' inner join tblpqa PQA on PQa.transId = Pl.purchaseOrderID and PQa.TransLineId = PL.PurchaselineId and PQa.transtype in ('+POTranstypes +') and PL.ProductId = PQa.ProductID '+
                        ' Set PQA.Qty = if(ifnull(shipped,0)<> 0 ,shipped, qtysold),  '+
                        ' PQA.UOMQty =  if(ifnull(UnitofMeasureShipped,0)<> 0 ,UnitofMeasureShipped, UnitofMeasureQtySold) '+
                        ' where  ifnull(PL.ProductId,0) <> 0 ;');
                        //' where ifnull(PL.qtysold,0) = 0 and ifnull(PL.ProductId,0) <> 0 and pqa.qty <> 0;');

      Stepprogressbar;
      FixManPQAs;
      Stepprogressbar;
      grpFilters.Itemindex := 0;
      DeleteDupicatePQAs;
      Stepprogressbar;
      grpFilters.Itemindex := 1;
      DeleteDupicatePQAs;
      Stepprogressbar;
      grpfilters.itemindex := 2;
      FixblankPOlinesnMakeifmissing;
      Stepprogressbar;
      DeleteDupicatePQAs;
      Stepprogressbar;
      FixSOBOPQAs;
      Stepprogressbar;
      FixInactivePQAs;
      Stepprogressbar;
      ERPScript1.SQL.add('Delete from tblPQA where ifnull(TransType,"") = "";');
    finally
      Hideprogressbar;
    end;

    showProgressbar(waitmsg , ERPScript1.SQL.count);
    try
      ERPScript1.execute;
    finally
      Hideprogressbar;
    end;
end;

initialization
  RegisterClassOnce(TPQAMismatchGUI);

end.

