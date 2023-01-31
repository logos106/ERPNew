unit frmpqa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DAScript, MyScript, ERPdbComponents, StdCtrls, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, Menus, ExtCtrls;

type
  TQtyncost =record
    Qty:double;
    cost:double;
    costinc:double;
  end;
  Tfmpqa = class(TBaseInputGUI)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scriptmainBeforeExecute(Sender: TObject; var SQL: string; var Omit: Boolean);
  private
    procedure MakeCOGSCost;
    { Private declarations }
  public
  end;


implementation

uses pqalib, CommonDbLib, ProductQtyLib, CommonLib;

{$R *.dfm}

procedure Tfmpqa.Button1Click(Sender: TObject);
begin
  MakeCOGSCost;
end;
procedure Tfmpqa.MakeCOGSCost;
var
  fdRunningQty:Double;
  ProductId:Integer;
  Qtyncost :Array of TQtyncost;
  fdQtyncosttotalCost, fdQtyncosttotalCostInc:Double;
  fdQty:Double;
  Qrymain, Qrycost :TERPQuery;
  scriptmain:TERPScript;

Procedure  QtyncosttotalCost;
  var
    ctr:Integer;
  begin
    fdQtyncosttotalCost:= 0;
    fdQtyncosttotalCostinc := 0;
    for ctr:= low(Qtyncost) to high(Qtyncost) do begin
      fdQtyncosttotalCost:= fdQtyncosttotalCost +Qtyncost[ctr].cost*Qtyncost[ctr].Qty;
      fdQtyncosttotalCostinc:= fdQtyncosttotalCostinc +Qtyncost[ctr].costinc*Qtyncost[ctr].Qty;
    end;
  end;
begin
  inherited;
  Qrymain:= TERPQuery.Create(Self);
  Qrycost:= TERPQuery.Create(Self);
  scriptmain:= TERPScript.Create(Self);
  try
    Qrymain.Connection := GetSharedMyDacConnection;
    Qrycost.Connection := GetSharedMyDacConnection;
    scriptmain.Connection := GetSharedMyDacConnection;
      with scriptmain do begin
        connection := GetSharedMyDacConnection;
        SQL.Clear;
        SQl.Add('Truncate table tbltransactionPQAs;');
        SQl.Add('insert ignore into tbltransactionPQAs '+
                ' (PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,Active	,TransID , StockQty	)  '+
                ' select PQAID,TransLineID	,TransType	,TransDate	,Alloctype	,IsBO	,Qty	,UOMQty	,UOM	,UOMMultiplier	,UOMID	,DepartmentID	,ProductID	,ProductName	,Active	,TransID , '+ SQL4QtyField(tActStockwithMan) +
                ' from tblpqa pqa;');

        SQl.Add('update tbltransactionPQAs pqa inner join tblpurchaselines POL on pqa.transId = POL.PurchaseOrderID and pqa.translineId = POL.PurchaseLineID and pqa.transtype in ( '+POTranstypes +')'+
                      ' Set pqa.Linecost = POL.LineCost , pqa.Linecostinc = POL.LineCostinc, pqa.totalcost = POL.totallineamount , pqa.totalcostinc = POL.totallineamountinc , '+
                      ' Actualtotalcost = POL.totallineamount, Actualtotalcostinc =POL.totallineamountinc'+
                      ' where pqa.transtype in ( '+POTranstypes +');' ) ;

        SQl.Add('update tbltransactionPQAs pqa inner join tblsaleslines SL on pqa.transId = SL.SaleId and pqa.translineId = SL.SaleLineId and pqa.transtype in ( '+ SalesTransTypes+')'+
                      ' Set pqa.Linecost = SL.LineCost , pqa.Linecostinc = SL.LineCostinc, pqa.totalcost = SL.Linecost *SL.shipped , pqa.totalcostinc = SL.Linecostinc *SL.shipped'+
                      ' where pqa.transtype in ( '+SalesTransTypes +');' ) ;

        SQl.Add('update tbltransactionPQAs pqa inner join tblstockmovementlines SML on pqa.transId = SML.StockmovementID and pqa.translineId = SML.StockmovementID and  pqa.transtype In ('+StockMovementtypes+')'+
                      ' Set pqa.Linecost = SML.Cost , pqa.Linecostinc = SML.Cost, pqa.totalcost = SML.Cost * SML.Qty  , pqa.totalcostinc = SML.Cost * SML.Qty , '+
                      ' Actualtotalcost =  if( Alloctype = "IN", SML.Cost * SML.Qty ,0) , Actualtotalcostinc =  if( Alloctype = "IN", SML.Cost * SML.Qty ,0) '+
                      ' where pqa.transtype In ('+StockMovementtypes+') ;');

        SQl.Add('update tbltransactionPQAs pqa inner join tblproctreepart PTP  on PQA.TransLineId= PTP.ProctreePartID and PQA.Transtype In ('+ManufactureTypes+') '+
                      ' inner join tblProcTree PT on PTP.ProcTreeId = PT.ProcTreeId '+
                      ' Set pqa.Linecost = PT.Cost , pqa.Linecostinc = PT.cost, pqa.totalcost = PT.cost * PTP.Qty , pqa.totalcostinc = PT.cost * PTP.Qty , '+
                      ' Actualtotalcost = if(PQA.alloctype="IN" , PT.cost * PTP.Qty , 0), Actualtotalcostinc =if(PQA.alloctype="IN" , PT.cost * PTP.Qty , 0) '+
                      ' where PQA.Transtype In ('+ManufactureTypes+');');


        DoShowProgressbar(6, 'Populating Transactional PQA');
        try
          Execute;
        finally
          DoHideProgressbar;
        end;
      end;
      closedb(Qrymain);
      Qrymain.SQL.Text := 'Select * from  tbltransactionPQAs order by  ProductId, TransDate  ,transId, transLineId ;';
      opendb(Qrymain);

      if Qrymain.RecordCount =0 then exit;
      Qrymain.First;
      fdRunningQty:= 0;
      ProductId :=Qrymain.fieldbyname('ProductID').asInteger;
      DoShowProgressbar(Qrymain.RecordCount, 'Populating Running Qty');
      try
        While Qrymain.Eof = False do begin
          if ProductId <>Qrymain.fieldbyname('ProductID').asInteger then begin
            fdRunningQty := 0;
            ProductId :=Qrymain.fieldbyname('ProductID').asInteger;
          end;
          fdRunningQty := fdRunningQty+ Qrymain.FieldByName('StockQty').asFloat;
          EditDB(Qrymain);
          Qrymain.FieldByName('RunningQty').AsFloat := fdRunningQty;
          PostDB(Qrymain);
          Qrymain.NExt;
          DoStepProgressbar(Qrymain.FieldByName('ProductName').AsString);
        end;
      finally
        DoHideProgressbar;
      end;

      closedb(Qrymain);
      Qrymain.SQL.Text := 'Select * from  tbltransactionPQAs '+
                          ' where (Alloctype = "OUT" or transtype ="TRefundSaleLine") and ifnull(StockQty,0) <>0 '+
                          ' order by  ProductId, TransDate  ,transId, transLineId ;';
      opendb(Qrymain);

      closedb(qryCost);
      qryCost.SQL.Text := 'Select * from  tbltransactionPQAs '+
                          ' where (Alloctype = "IN" and transtype <> "TRefundSaleLine") and ifnull(StockQty,0) <>0 '+
                          ' order by  ProductId, TransDate  ,transId, transLineId ;';
      opendb(qryCost);

      qryCost.First;
      Qrymain.First;
      DoShowProgressbar(Qrymain.RecordCount, 'Populating Cost');
      try
        While Qrymain.Eof = False do begin
          fdRunningQty:= 0-Qrymain.fieldbyname('stockQty').Asfloat;
          if fdRunningQty<> 0 then begin
            SetLength(Qtyncost,0);
            if (fdRunningQty>0) then begin
              if not Qrycost.eof then
                if qryCost.fieldbyname('ProductID').asInteger <> Qrymain.fieldbyname('ProductID').asInteger then
                  Qrycost.Next;
              while (Qrycost.eof = False) and (qryCost.fieldbyname('ProductID').asInteger = Qrymain.fieldbyname('ProductID').asInteger) and (fdRunningQty<>0) do begin
                if qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat <> 0 then begin
                  if (qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat < fdRunningQty)   then fdQty:=qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat else fdQty:= fdRunningQty;
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].qty     := fdQty;
                  Qtyncost[high(Qtyncost)].cost    := qryCost.fieldByname('linecost').asFloat;
                  Qtyncost[high(Qtyncost)].costinc := qryCost.fieldByname('linecostinc').asFloat;
                  EditDb(qryCost);
                  qryCost.fieldbyname('tempQty').asfloat := qryCost.fieldbyname('tempQty').asfloat + fdQty;
                  PostDB(qryCost);
                  fdRunningQty:= fdRunningQty-fdQty;
                end;
                Qrycost.Next;
              end;
            end else begin
              if not Qrycost.bof then
                if qryCost.fieldbyname('ProductID').asInteger <> Qrymain.fieldbyname('ProductID').asInteger then
                  Qrycost.Prior;
              while (Qrycost.bof = False) and (qryCost.fieldbyname('ProductID').asInteger = Qrymain.fieldbyname('ProductID').asInteger) and (fdRunningQty<>0) do begin
                if qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat <> 0 then begin
                  if (qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat < abs(fdRunningQty))   then fdQty:=qryCost.fieldByname('stockQty').asFloat- qryCost.fieldbyname('tempQty').asfloat else fdQty:= abs(fdRunningQty);
                  SetLength(Qtyncost,length(Qtyncost)+1);
                  Qtyncost[high(Qtyncost)].qty    := fdQty;
                  Qtyncost[high(Qtyncost)].cost   := qryCost.fieldByname('linecost').asFloat;
                  Qtyncost[high(Qtyncost)].costinc:= qryCost.fieldByname('linecostinc').asFloat;
                  EditDb(qryCost);
                  qryCost.fieldbyname('tempQty').asfloat := qryCost.fieldbyname('tempQty').asfloat +fdQty;
                  PostDB(qryCost);
                  fdRunningQty:= fdRunningQty+fdQty;
                end;
                Qrycost.Prior;
              end;
            end;
            if length(Qtyncost)>0 then begin
                QtyncosttotalCost;
                EditDB(qrymain);
                Qrymain.fieldbyname('Actualtotalcost').asFloat := fdQtyncosttotalCost;
                Qrymain.fieldbyname('Actualtotalcostinc').asFloat := fdQtyncosttotalCostInc;
                PostDB(qrymain);
            end else begin
                EditDB(qrymain);
                Qrymain.fieldbyname('Actualtotalcost').asFloat    := Qrymain.fieldbyname('totalcost').asFloat ;
                Qrymain.fieldbyname('Actualtotalcostinc').asFloat := Qrymain.fieldbyname('totalcostinc').asFloat ;
                PostDB(qrymain);
            end;
          end;
          Qrymain.NExt;
          DoStepProgressbar(qrymain.FieldByName('Productname').AsString);
        end;
      finally
        DoHideProgressbar;
      end;
  finally
    Freeandnil(Qrymain);
    Freeandnil(Qrycost);
    Freeandnil(scriptmain);
  end;
end;
procedure Tfmpqa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
action := caFree;
end;

procedure Tfmpqa.scriptmainBeforeExecute(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  inherited;
  DoStepProgressbar(iif(devmode , SQL, ''));
end;

initialization
  RegisterClassOnce(Tfmpqa);

end.

