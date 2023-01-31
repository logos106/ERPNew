unit PurchaseOrders_RoundFix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPurchaseOrders_RoundFixGUI = class(TBaseListingGUI)
    qryMainAccount: TWideStringField;
    qryMainispo: TWideStringField;
    qryMainiscredit: TWideStringField;
    qryMainisbill: TWideStringField;
    qryMainischeque: TWideStringField;
    qryMainisRA: TWideStringField;
    qryMainpurchaseOrderId: TIntegerField;
    qryMainHeaderTax: TFloatField;
    qryMainlinestax: TFloatField;
    qryMainheaderinc: TFloatField;
    qryMainlinesinc: TFloatField;
    qryMainheaderex: TFloatField;
    qryMainlinesex: TFloatField;
    qryMainseqno: TLargeintField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure SctMainAfterExecute(Sender: TObject; SQL: string);
  private
    fstablename :String;
    procedure Dofix;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, tcConst, busobjOrders, CommonDbLib, math, BusObjOrderBase;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TPurchaseOrders_RoundFixGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  IterateProcNo := 1;
  IterateRecords(True , WAITMSG);
  RefreshQuery;
end;
procedure TPurchaseOrders_RoundFixGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  //DoDelayObjectProcedure(Dofix, 50, Self.classname +'.Dofix');
  Dofix;
end;
procedure TPurchaseOrders_RoundFixGUI.Dofix;
var
  PO :TOrderBase;
begin
  if  IterateProcNo = 1 then begin
    sleep(50);
    if qrymainispo.AsBoolean then
      PO := TPurchaseOrder.CreateWithNewConn(self)
    else if qryMainisRA.asboolean then
      PO := TReturnAuthority.CreateWithNewConn(self)
    else begin
      exit;
    end;

    try
      PO.DisableCalcOrderTotals := true;
      PO.AllowNewRecordWhenLocked:= true;
      PO.Load(qryMainpurchaseOrderId.AsInteger);
      if PO.Count =0 then exit;
      if not (PO.Lock) then exit;
      PO.AccessManager.AccessLevel:= 1;
      PO.Connection.BeginTransaction;
      try
        PO.Lines.Last;
        PO.Lines.New;
        PO.Lines.ProductName :=PART_ROUNDING;
        PO.Lines.QtySold:= 1;
        PO.Lines.QtyShipped := 1;
        PO.Lines.TotalLineAmount := qryMainHeaderex.AsFloat - qryMainlinesex.AsFloat;
        PO.Lines.LineTaxTotal := qryMainHeaderTax.AsFloat - qryMainlinestax.AsFloat;
        PO.Lines.TotalLineAmountinc := qryMainHeaderinc.AsFloat - qryMainlinesinc.AsFloat;
        PO.Lines.Invoiced:= True;
        PO.Lines.ProductDescription := 'Round Fix ' ;
        PO.Lines.postdb;
        PO.comments := 'Round Fix -> Ex :' +floaTtostr(round(Qrymainheaderex.asfloat    - QrymainlinesEx.asfloat, 2)) +', '+
                                    'Tax:' + floaTtostr(round(Qrymainheadertax.asfloat  - Qrymainlinestax.asfloat, 2))+', '+
                                    'Inc:' + floaTtostr(round(Qrymainheaderinc.asfloat  - Qrymainlinesinc.asfloat, 2))+NL+PO.comments ;
        PO.PostDB;
        PO.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          PO.Connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(PO);
    end;
  end;
end;
procedure TPurchaseOrders_RoundFixGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('PurchaseOrders_RoundFixGUI');
  Qrymain.sQL.text := 'Select * from ' +fstablename;
  inherited;
end;

procedure TPurchaseOrders_RoundFixGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not(SameValue(qryMainHeaderTax.asfloat , qryMainlinestax.asfloat)) then if sametext(qryMainHeaderTax.fieldname, field.fieldname) or sametext(qryMainlinestax.fieldname, field.fieldname) then Abrush.color := clred;
  if not(SameValue(qryMainheaderinc.asfloat , qryMainlinesinc.asfloat)) then if sametext(qryMainheaderinc.fieldname, field.fieldname) or sametext(qryMainlinesinc.fieldname, field.fieldname) then Abrush.color := clred;
  if not(SameValue(qryMainheaderex.asfloat  , qryMainlinesex.asfloat )) then if sametext(qryMainheaderex.fieldname , field.fieldname) or sametext(qryMainlinesex.fieldname , field.fieldname) then Abrush.color := clred;

end;

procedure TPurchaseOrders_RoundFixGUI.RefreshQuery;
begin
  with ScriptMain do begin
    SQL.clear;
    (*SQL.add('alter table tblpurchaselines add column xLineTax double, add column xtotallineamount double, add column xtotallineamountinc double;');
    SQL.add('update tblpurchaselines set xLineTax = LineTax, xtotallineamount = totallineamount, xtotallineamountinc =totallineamountinc;');

    SQL.add('alter table tblpurchaseorders add column xtotaltax double, add column xtotalamount double, add column xtotalamountinc double;');
    SQL.add('update tblpurchaseorders set xtotaltax = totaltax, xtotalamount = totalamount, xtotalamountinc =totalamountinc;');*)


    SQL.add('Create table if not exists erpfix_PO_RoundFix  like tblpurchaseorders;');
    SQL.add('Create table if not exists erpfix_POL_RoundFix like tblpurchaselines;');

    SQL.add('insert ignore into erpfix_PO_RoundFix   ' +
            ' select * from  tblpurchaseorders  PO   ' +
            ' /*ON DUPLICATE KEY UPDATE erpfix_PO_RoundFix.totalamount      = PO.totalamount     ,   ' +
            ' erpfix_PO_RoundFix.totaltax = PO.totaltax,  ' +
            ' erpfix_PO_RoundFix.totalamountinc = PO.totalamountinc */;');
    SQL.add('insert ignore into erpfix_POL_RoundFix  ' +
            ' select * from  tblpurchaselines   POL  ' +
            ' /*ON DUPLICATE KEY UPDATE erpfix_POL_RoundFix.totallineamount = POL.totallineamount,   ' +
            ' erpfix_POL_RoundFix.linetax = POL.linetax,  ' +
            ' erpfix_POL_RoundFix.totallineamountinc = POL.totallineamountinc*/;');


    SQL.add('update tblpurchaselines set totallineamountinc  = round(totallineamountinc,2);');
    SQL.add('update tblpurchaselines set totallineamount     = round(totallineamount,2);');
    SQL.add('update tblpurchaselines set LineTax             = round(totallineamountinc - totallineamount,2);');


    SQL.add('drop table if exists ' + fsTablename +';');
    SQL.add('create table ' + fsTablename +'  ' +
            ' select ' +
            ' PO.Account, PO.ispo, po.iscredit, po.isbill, po.ischeque, ' +
            ' PO.purchaseOrderId,  PO.totalTax   HeaderTax, (Select sum(PL.LineTax) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) linestax, ' +
            ' PO.totalamountinc as headerinc, (Select sum(PL.totallineamountinc) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) linesinc, ' +
            ' PO.totalamount   as headerex, (Select sum(PL.totallineamount) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) as linesex, ' +
            ' (Select Max(Seqno)+10 from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) as seqno ' +
            ' from tblpurchaseOrders PO ;');
    SQL.add('Alter table ' + fsTablename +' add index purchaseOrderId (purchaseOrderId);');
    SQL.add('update tblpurchaseOrders PO   ' +
            ' inner join ' + fsTablename +' T on PO.purchaseOrderId = T.purchaseOrderId   ' +
            ' Set PO.totaltax = T.linestax , PO.totalamount = T.linesex   ' +
            ' where round(ifnull(linesinc,0),2) = round(ifnull(PO.totalamountinc,0),2);');

    SQL.add('drop table if exists ' + fsTablename +';');
    SQL.add('create table ' + fsTablename +'');
    SQL.add('select  ' +
            ' PO.Account, PO.ispo, po.iscredit, po.isbill, po.ischeque, PO.isRA,  ' +
            ' PO.purchaseOrderId,  PO.totalTax   HeaderTax, (Select sum(PL.LineTax) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) linestax,  ' +
            ' PO.totalamountinc as headerinc, (Select sum(PL.totallineamountinc) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) linesinc,  ' +
            ' PO.totalamount   as headerex, (Select sum(PL.totallineamount) from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) as linesex,  ' +
            ' (Select Max(Seqno)+10 from tblpurchaselines PL where  PO.PurchaseOrderID = PL.PurchaseOrderID ) as seqno  ' +
            ' from tblpurchaseOrders PO ;');
    SQL.add('Alter table ' + fsTablename +' add index purchaseOrderId (purchaseOrderId);');
    SQL.add('delete from ' + fsTablename +' where ifnull(HeaderTax,0)=0 and ifnull(linestax,0)=0 and ifnull(headerex,0)=0 and ifnull(linesex,0)=0 and ifnull(headerinc,0)=0 and ifnull(linesinc,0)=0;');
    SQL.add('delete from ' + fsTablename +' where round(ifnull(HeaderTax,0),5) = round(ifnull(linestax,0),5) and  round(ifnull(headerex,0),5) = round(ifnull(linesex,0),5) and round(ifnull(headerinc,0),5) = round(ifnull(linesinc,0),5);');
    DoShowProgressbar(SQL.Count, WAITMSG);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
    SQL.clear;
  end;
  inherited;

end;

procedure TPurchaseOrders_RoundFixGUI.SctMainAfterExecute(Sender: TObject; SQL: string);
begin
  inherited;
  DoStepProgressbar;
end;

procedure TPurchaseOrders_RoundFixGUI.SctMainError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue;
end;

initialization
  RegisterClassOnce(TPurchaseOrders_RoundFixGUI);

end.

