unit AreaPOLinesDetailsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListDetails, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  pqalib, ProductQtyLib, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAreaPOLinesDetailsListGUI = class(TBaseListDetailsGUI)
    qryMainDetails: TLargeintField;
    qryMainEquipmentId: TIntegerField;
    qryMainEquipmentName: TWideStringField;
    qryMainAreaCode: TWideStringField;
    qryMainproductName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainAvailableQty: TFloatField;
    qryMainInStockqty: TFloatField;
    qryMainAllocatedSOqty: TFloatField;
    qryMainAllocatedBOQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    qryMainOnBuildqty: TFloatField;
    qryMainSOBOQty: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fsTablename :String;
    Qtytype: Tqtytype;
    Procedure CreateTemptable;
    procedure MakeQrymain;
    Procedure ProductDetails;
    Procedure beforeshowProductQtyDetails(Sender:TObject);
  protected
    Function ExpressDetailListName:String;Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses tcConst, AppEnvironment, CommonLib, CommonDbLib, LogLib, ProductMovementList, AppContextObj, CommonFormLib, ProductQtyDetails;

{$R *.dfm}

function TAreaPOLinesDetailsListGUI.ExpressDetailListName: String;
begin
  REsult := 'TAreaPOLinesListGUI';
end;

procedure TAreaPOLinesDetailsListGUI.FormCreate(Sender: TObject);
begin
  grpfilters.items[0] := Appenv.companyprefs.Areacolumnname +' Summary';
  fstablename := commondblib.GetUserTemporaryTableName('AreaPOLines');
  CreateTemptable;
  MakeQrymain;
  //Qrymain.SQL.text := 'Select * from '+fsTablename;
  inherited;
  Self.Caption := Appenv.companyprefs.Areacolumnname +  ' Product List';
  TitleLabel.Caption := Appenv.companyprefs.Areacolumnname + ' Product List';

end;
procedure TAreaPOLinesDetailsListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TAreaPOLinesDetailsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.ItemIndex =-1 then grpfilters.ItemIndex := 0;
end;

procedure TAreaPOLinesDetailsListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if grpfilters.ItemIndex = 1 then
    if QrymainDetails.AsInteger = 1 then begin
      AFont.Style := AFont.Style +[fsBold];
      ABrush.color := $00B3FFFF;
    end;
end;

procedure TAreaPOLinesDetailsListGUI.grdMainDblClick(Sender: TObject);
begin
  if not Assigned(TField(grdMain.GetActiveField)) then exit;

{------}if Sametext(ActiveFieldName, qryMainOnOrderQty.fieldName) then begin
            SubsequentID := Chr(95) + 'OnOrderRequest';
            AppContext['PartDrillInfo'].IntVar['Department'] := 0;
{------}end else if Sametext(ActiveFieldName,qryMainOnBuildQty.fieldName ) then begin
              Qtytype :=tonBuild;
              ProductDetails;
              exit;
{------}end else if Sametext(ActiveFieldName, qryMainAllocatedSOQty.fieldName ) or Sametext(ActiveFieldName, qryMainSOBoQty.fieldName ) then begin
            SubsequentID := Chr(95) + 'OnSORequest';
            AppContext['PartDrillInfo'].IntVar['Department'] := 0;
{------}end else if Sametext(ActiveFieldName,qryMainAllocatedBOqty.fieldName ) then begin
            SubsequentID := Chr(95) + 'OnBORequest';
            AppContext['PartDrillInfo'].IntVar['Department'] := 0;
{------}end else if Sametext(ActiveFieldName, QrymainAvailableqty.fieldName) then begin
            ProcessingCursor(True);
            try
              TProductMovementForm.showList(Self, qryMainProductID.asInteger, 0);
              Exit;
            finally
              ProcessingCursor(False);
            end;
{------}end else begin
            SubsequentID := '';
{------}end;
  inherited;

end;

procedure TAreaPOLinesDetailsListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1','2','3']);
  inherited;
end;

procedure TAreaPOLinesDetailsListGUI.beforeshowProductQtyDetails(Sender: TObject);
begin
     if not(Sender is TProductQtyDetailsGUI) then exit;
     TProductQtyDetailsGUI(Sender).productId := qryMainProductID.asInteger;
     TProductQtyDetailsGUI(Sender).ClassID := 0;
     TProductQtyDetailsGUI(Sender).Qtytype := Qtytype;
end;

procedure TAreaPOLinesDetailsListGUI.CreateTemptable;
begin
  with Scriptmain do begin
    SQL.clear;
    SQL.add('Drop table if exists '+fsTablename +';');
    SQL.add('Drop table if exists '+fsTablename +' ;');
    SQL.add('Create table '+fsTablename +'  like tblPQA;');
    SQL.add('insert ignore into '+fsTablename +'  Select * from tblPQA;');
    SQL.add('delete from '+fsTablename +'   where  Transtype  in (' + StockMovementtypes+');');
    SQL.add('Alter Table '+fsTablename +'  Add column Area Varchar(50);');
    SQL.add('update  '+fsTablename +'   T ' +
                ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.transtype  in (' + SalesTransTypes+')' +
                ' set T.Area = Sl.Area;');
    SQL.add('update  '+fsTablename +'   T ' +
                ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.transtype  in (' + POTranstypes+')' +
                ' set  T.Area =  PL.AreaCode ;');
    SQL.add('update  '+fsTablename +'   T ' +
              ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.transtype in (' +ManufactureTypes+')' +
              ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID   and ifnull(PT.parentID,0)<>0' +
              ' inner join tblsaleslines SL on SL.saleLineId = PT.masterID and PT.mastertype <> "mtProduct"' +
              ' Set T.Area = Sl.Area;');
    SQL.add('Alter Table '+fsTablename +'  Add EquipmentId int(11);');
    SQL.add('Alter Table '+fsTablename +'  Add EquipmentName varchar(100);');
    SQL.add('update '+fsTablename +'  T  ' +
              ' inner join tblpurchaselines POL on T.ProductId = POL.productId and T.area = POL.areacode  ' +
              ' inner join tblpurchaseorders PO on PO.purchaseorderID = POL.PurchaseOrderID  ' +
              ' Set T.EquipmentName = PO.EquipmentName, T.EquipmentId = PO.EquipmentId;');
    logtext(SQL.Text);
    Execute;
    SQL.Clear;
  end;
end;
procedure TAreaPOLinesDetailsListGUI.MakeQrymain;
begin
  closeDB(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add( 'Select Distinct');
  Qrymain.SQL.Add( '1                 as Details,');
  Qrymain.SQL.Add( 'PQA.EquipmentId   as EquipmentId ,');
  Qrymain.SQL.Add( 'PQA.EquipmentName as EquipmentName ,');
  Qrymain.SQL.Add( 'PQA.Area          as AreaCode ,');
  Qrymain.SQL.Add( 'NULL              as productName ,');
  Qrymain.SQL.Add( 'NULL              as ProductID,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AvailableQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnBuildqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedSOqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS InStockqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnOrderQty');
  Qrymain.SQL.Add( 'from  tblparts P');
  Qrymain.SQL.Add( 'inner join `tblProductClasses` as PC on PC.ProductID = P.PartsId');
  Qrymain.SQL.Add( 'inner join '+fsTablename +'   as PQA on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID');
  Qrymain.SQL.Add( 'group by PQA.equipmentId  ,PQA.EquipmentName ,PQA.area');
  Qrymain.SQL.Add( 'union');
  Qrymain.SQL.Add( 'Select Distinct');
  Qrymain.SQL.Add( '2                 as Details,');
  Qrymain.SQL.Add( 'PQA.EquipmentId   as EquipmentId ,');
  Qrymain.SQL.Add( 'PQA.EquipmentName as EquipmentName ,');
  Qrymain.SQL.Add( 'NULL              as AreaCode ,');
  Qrymain.SQL.Add( 'PQA.Productname   as productName ,');
  Qrymain.SQL.Add( 'PQA.ProductID     as ProductID,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AvailableQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnBuildqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedSOqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS InStockqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnOrderQty');
  Qrymain.SQL.Add( 'from  tblparts P');
  Qrymain.SQL.Add( 'inner join `tblProductClasses` as PC on PC.ProductID = P.PartsId');
  Qrymain.SQL.Add( 'inner join '+fsTablename +'   as PQA on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID');
  Qrymain.SQL.Add( 'group by PQA.equipmentId  ,PQA.EquipmentName ,PQA.ProductID');
  Qrymain.SQL.Add( 'union');
  Qrymain.SQL.Add( 'Select Distinct');
  Qrymain.SQL.Add( '3                 as Details,');
  Qrymain.SQL.Add( 'PQA.EquipmentId   as EquipmentId ,');
  Qrymain.SQL.Add( 'PQA.EquipmentName as EquipmentName ,');
  Qrymain.SQL.Add( 'PQA.Area          as AreaCode ,');
  Qrymain.SQL.Add( 'PQA.ProductName   as productName ,');
  Qrymain.SQL.Add( 'PQA.ProductId     as ProductID,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AvailableQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnBuildqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedSOqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS AllocatedBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOBOQty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS InStockqty,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS OnOrderQty');
  Qrymain.SQL.Add( 'from  tblparts P');
  Qrymain.SQL.Add( 'inner join `tblProductClasses` as PC on PC.ProductID = P.PartsId');
  Qrymain.SQL.Add( 'inner join '+fsTablename +'   as PQA on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID');
  Qrymain.SQL.Add( 'group by PQA.equipmentId  ,PQA.EquipmentName ,PQA.area, PQA.productName');
  Qrymain.SQL.Add( 'order by AreaCode ,Productname,  EquipmentName, Details ');
  Logtext(Qrymain.SQL.text);

end;

procedure TAreaPOLinesDetailsListGUI.ProductDetails;
begin
     OpenERPListForm('TProductQtyDetailsGUI' , beforeshowProductQtyDetails)
end;

procedure TAreaPOLinesDetailsListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainequipmentId.fieldname);
end;

initialization
  RegisterClassOnce(TAreaPOLinesDetailsListGUI);

end.

