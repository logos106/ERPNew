unit frmsaleslineManufactureTotalQtyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmsaleslineManufactureSummary, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, Mask, wwdbedit, Shader,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Grids, Wwdbigrd, Wwdbgrid,
  DNMPanel,BusObjProcess;

type
  TfmsaleslineManufactureTotalQtyEdit = class(TfmsaleslineManufactureSummary)
    qryMainTreePartUOMtotalNewQty: TFloatField;
    qryMainWasteUOMQty: TFloatField;
    qryMaintreePartUOMMultiplier: TFloatField;
    qryMainproctreeId: TIntegerField;
    qryMainParentProcTreeId: TIntegerField;
    qryMainQtyEditable: TWideStringField;
    procedure btnEditClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterScroll(DataSet: TDataSet);
  private
    fsTablename:String;
    fProcTree: TProcTreeNode;
    Procedure Check4QtyEditable;
  Protected
    Procedure MakeQrymain;Override;
    Procedure OpenQrymain;Override;
  public
    class Function  EditsaleslineManufactureTotalQty(aMyConnection: TERPConnection; aSalesLineID:Integer;aProcTree: TProcTreeNode):Integer;
  end;

implementation

uses CommonDbLib, DbSharedObjectsObj, tcConst, LogLib;

{$R *.dfm}

{ TfmsaleslineManufactureTotalQtyEdit }

procedure TfmsaleslineManufactureTotalQtyEdit.btnEditClick(Sender: TObject);
var
  fdChangeQty, fdUOMChangeQty:Double;
begin
  if fProctree is TSalesLineProcTree then begin
     Qrymain.first;
     while Qrymain.EOF = False do begin
       fdUOMChangeQty:=qrymainTreePartUOMtotalNewQty.asfloat - qrymainTreePartUOMtotalQty.asfloat;
       if fdUOMChangeQty<>0 then begin
          fdChangeQty:= fdUOMChangeQty* qrymaintreePartUOMMultiplier.asFloat;
          TSalesLineProcTree(fProctree).ChangeTotalQty(qrymainproctreeID.asInteger ,qrymainTreePartUOMtotalNewQty.asfloat,qrymainWasteUOMQty.asfloat(*fdChangeQty*));
       end;
       Qrymain.Next;
     end;
     TSalesLineProcTree(fProctree).DoNotCreateSmartOrder := True;
     TSalesLineProcTree(fProctree).savenocheck;
  end;
(*var
  scr :TERPScript;
  fdChangeQty, fdUOMChangeQty:Double;
begin
//  inherited;
  postdb(qrymain);
  scr := DbSharedObj.GetScript(TransConnection);
  try
     scr.SQL.clear;
     Qrymain.first;
     while Qrymain.EOF = False do begin
       fdUOMChangeQty:=qrymainTreePartUOMtotalNewQty.asfloat - qrymainTreePartUOMtotalQty.asfloat;
       if fdUOMChangeQty<>0 then begin
          fdChangeQty:= fdUOMChangeQty* qrymaintreePartUOMMultiplier.asFloat;

          scr.SQL.add('update tblproctree     set FromStockQty        = FromStockQty        + '+Floattostr(fdChangeQty   )+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' + NL+
                      'update tblproctree     set FromStockUOMQty     = FromStockUOMQty     + '+Floattostr(fdUOMChangeQty)+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctree     set TotalQty            = TotalQty            + '+Floattostr(fdChangeQty   )+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctree     set TreePartUOMtotalQty = TreePartUOMtotalQty + '+Floattostr(fdUOMChangeQty)+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+

                      'update tblproctreePart set Qty                 = Qty                 + '+Floattostr(fdChangeQty   )+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctreePart set UOMQty              = UOMQty              + '+Floattostr(fdUOMChangeQty)+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctreePart set FromStockQty        = FromStockQty        + '+Floattostr(fdChangeQty   )+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctreePart set FromStockUOMQty     = FromStockUOMQty     + '+Floattostr(fdUOMChangeQty)+' where ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+

                      'update tblproctreePart PTP inner join tblpqa pqa on PTP.proctreepartID = pqa.transLinID and pqa.transType in ("TProcTreePartIN" , "TProcTreePart") set PQA.uomqty = PQA.uomqty + '+Floattostr(fdUOMChangeQty )+' where PTP.ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' +NL+
                      'update tblproctreePart PTP inner join tblpqa pqa on PTP.proctreepartID = pqa.transLinID and pqa.transType in ("TProcTreePartIN" , "TProcTreePart") set PQA.qty    = PQA.qty + '   +Floattostr(fdChangeQty    )+' where PTP.ProctreeId = ' + inttostr(qrymainproctreeID.asInteger)+';' );
       end;
       Qrymain.Next;
     end;
     if scr.SQL.count >0 then begin
      clog(scr.SQL.text);
      scr.Execute;
     end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;*)
  Self.Close;
end;

procedure TfmsaleslineManufactureTotalQtyEdit.Check4QtyEditable;
begin
  qryMainTreePartUOMtotalNewQty.Readonly := not(qryMainQtyEditable.asboolean);
  qryMainWasteUOMQty.Readonly := not(qryMainQtyEditable.asboolean) or (qrymainParentProcTreeId.asInteger=0);
end;

procedure TfmsaleslineManufactureTotalQtyEdit.cmdCloseClick(Sender: TObject);
begin
//  inherited;

end;

class function TfmsaleslineManufactureTotalQtyEdit.EditsaleslineManufactureTotalQty(aMyConnection: TERPConnection; aSalesLineID: Integer;aProcTree: TProcTreeNode): Integer;
begin
  With TfmsaleslineManufactureTotalQtyEdit.Create(nil) do try
    TransConnection := aMyConnection;
    SalesLineID := aSalesLineID;
    pnlHide.visible := False;
    fProcTree := aProcTree;
    result:= Showmodal ;
  finally
    Free;
  end;

end;

procedure TfmsaleslineManufactureTotalQtyEdit.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not(qryMainQtyEditable.asBoolean) or sametext(Field.fieldname , qrymainTreePartUOMtotalQty.fieldname) then begin
      AFont.color  := clDkGray;
  end else if sametext(Field.fieldname , qrymainTreePartUOMtotalNewQty.fieldname) and (qryMainQtyEditable.asBoolean) then begin
      Abrush.color := clwhite;
      AFont.color  := clBlack;
  end else if sametext(Field.fieldname , qrymainWasteUOMQty.fieldname) and (qryMainQtyEditable.asBoolean) and (qrymainParentProcTreeId.asInteger<>0) then begin
      Abrush.color := clwhite;
      AFont.color  := clBlack;
  end;
end;

procedure TfmsaleslineManufactureTotalQtyEdit.MakeQrymain;
begin
//  inherited;
  fsTableName := GetUserTemporaryTableName('treeEdit');
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('SELECT* from '+ fsTableName);
end;

procedure TfmsaleslineManufactureTotalQtyEdit.OpenQrymain;
var
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    // outside transaction to create table otherwise the connection will be commited
    scr.SQL.clear;
    scr.SQL.add('Drop table if exists '+ fsTablename +';');
    scr.SQL.add('CREATE TABLE  '+ fsTablename +' ( proctreeId int(11) NOT NULL DEFAULT 0, ' +
                                                  ' ParentProcTreeId int(11) NOT NULL DEFAULT 0, ' +
                                                  ' caption varchar(255) DEFAULT NULL, ' +
                                                  ' uom varchar(255) DEFAULT NULL, ' +
                                                  ' TreePartUOMtotalQty double DEFAULT 0, ' +
                                                  ' TreePartUOMtotalNewQty double DEFAULT 0, ' +
                                                  ' WasteUOMQty double DEFAULT 0, ' +
                                                  ' treePartUOMMultiplier double DEFAULT 0, ' +
                                                  ' ManufactureUOMQty double DEFAULT NULL , ' +
                                                  ' FromStockUOMQty double DEFAULT NULL, ' +
                                                  ' OnOrderUOMQty double DEFAULT NULL, ' +
                                                  ' PartsId int(11) DEFAULT NULL, ' +
                                                  ' QtyEditable Enum("T","F") default "F" , '+
                                                  ' SaleLineId int(11) DEFAULT NULL, ' +
                                                  ' SAleID int(11) DEFAULT NULL, ' +
                                                  ' productname varchar(255) DEFAULT NULL, ' +
                                                  ' Salesuom varchar(255) DEFAULT NULL, ' +
                                                  ' UnitofMeasureQtySold double DEFAULT NULL, ' +
                                                  ' UnitofMeasureShipped double DEFAULT NULL, ' +
                                                  ' UnitofMeasureBackorder double DEFAULT NULL, ' +
                                                  ' AvailableQty double DEFAULT NULL, ' +
                                                  ' InstockQty double DEFAULT NULL, ' +
                                                  '   	PRIMARY KEY (`proctreeId`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;' );
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

  scr := DbSharedObj.GetScript(TransConnection);
  try
    scr.SQL.add('insert ignore into   '+ fsTablename +' (SAleID ,productname , UnitofMeasureQtySold ,UnitofMeasureShipped , UnitofMeasureBackorder , Salesuom ,   ' +
                                                        'proctreeId , ParentProcTreeId , caption , uom , TreePartUOMtotalQty, TreePartUOMtotalNewQty, WasteUOMQty, treePartUOMMultiplier, ManufactureUOMQty,FromStockUOMQty, OnOrderUOMQty, ' +
                                                        'PartsId, QtyEditable ) ' +
                                                        ' SELECT  Sl.SAleID , SL.productname,   ' +
                                                        ' SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.UnitofMeasureBackorder, ' +
                                                        ' concat(SL.UnitofMeasureSaleLines, " (" , SL.UnitofMeasureMultiplier ,")" ) Salesuom, ' +
                                                        ' PT.proctreeId, ifnull(ParentPT.ProctreeId,0) as ParentProcTreeId,  Convert(TreeNodeCaption(PT.Level, PT.caption ),char(255))  as caption,  ' +
                                                        ' concat(PT.TreePartUOM, " (" , PT.treePartUOMMultiplier ,")" ) uom,  PT.TreePartUOMtotalQty,' +
                                                        ' PT.TreePartUOMtotalQty,  0 as WasteUOMQty,  PT.treePartUOMMultiplier, PT.ManufactureUOMQty,  PT.FromStockUOMQty,  PT.OnOrderUOMQty, PT.PartsId  ,' +
                                                        ' if(ifnull(ParentPT.ProcTreeId,0)=0 or ((ParentPT.InputType<>"itOption" or PT.selected ="T")), "T" , "F") as QtyEditable' +
                                                        ' FROM tblsaleslines SL inner join tblproctree   PT on PT.masterId = SL.saleLineId and PT.masterType <> "mtProduct"' +
                                                        ' Left join tblproctree   ParentPT on PT.ParentId = ParentPT.ProcTreeId ' +
                                                        ' where Sl.salelineID = '+ inttostr(SalesLineID)+' having QtyEditable ="T" /*or ParentProcTreeId =0 */;');
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
  Qrymain.Connection := TransConnection;
  Qrymain.open;
  grpFilters.itemindex :=0;
  grpFilters.visible := False;
end;

procedure TfmsaleslineManufactureTotalQtyEdit.qryMainAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Check4QtyEditable;
end;

end.
