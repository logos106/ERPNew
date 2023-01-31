unit AlternateProductSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AlternateProducts, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TAlternateProductSearchGUI = class(TAlternateProductsGUI)
  private
  Protected
    Procedure MakeQrymain;Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, LogLib, ProductQtyLib, PQALib, tcDataUtils;

{$R *.dfm}
{ TAlternateProductSearchGUI }

procedure TAlternateProductSearchGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainForeignPrice.fieldname);
end;

procedure TAlternateProductSearchGUI.MakeQrymain;
begin
    closedb(qrymain);
    qrymain.SQL.clear;
    qrymain.SQL.add('select 1 as Category , ');
    qrymain.SQL.add('P.partsId as PartsId,');
    qrymain.SQL.add('P.Partname as Partname,');
    qrymain.SQL.add('P.PARTSDESCRIPTION as Salesdescription,');
    qrymain.SQL.add('P.PURCHASEDESC as Purchasedescription,');
    qrymain.SQL.add('concat(AP.ProductName, "''s Alternate Products") as description, ');
    qrymain.SQL.add('AP.AlternateProductID as AlternateProductID, ');
    qrymain.SQL.add('AP.AlternateProductName as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault  as isdefault, ');
    qrymain.SQL.add('CL.company as Supplier,');
    qrymain.SQL.add('convert(EP.ExtraPartPriceID, unsigned)  as ExtraPriceID	,');
    qrymain.SQL.add('EP.Buy1 as ExtraPriceQuantity,');
    qrymain.SQL.add('EP.Price as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL) as ForeignPrice,');
    qrymain.SQL.add('EP.SupplierProductCode as SupplierProductCode,');
    qrymain.SQL.add('EP.SupplierProductName as SupplierProductName,');
    qrymain.SQL.add('concat(EP.UOM, "(" , EP.UOMMultiplier, ")") as ExtraPriceUOM,');
    qrymain.SQL.add('EP.UOMMultiplier as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('EP.MinimumOrderQty as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty as instockQty, ');
    qrymain.SQL.add('P.Price1 as Price1,');
    qrymain.SQL.add('P.Cost1 as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin as Defaultbin');
    qrymain.SQL.add(' from ' + fsTablename +' TP inner join tblparts P on TP.partsId = P.partsID and (TP.classId = :ClassId or ifnull(TP.classId,0)=0)');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('Left join tblextraprice EP on EP.PartsID = P.partsId');
    qrymain.SQL.add('Left join tblclients CL on EP.SupplierID = CL.clientID');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('and AP.ProductId = :ProductId  ');
    qrymain.SQL.add('Group by P.partsId');

    qrymain.SQL.add('UNION ALL  ');
    qrymain.SQL.add('select 2 as CAtegory,  ');
    qrymain.SQL.add('P.partsId as PartsId,');
    qrymain.SQL.add('P.Partname as Partname,');
    qrymain.SQL.add('P.PARTSDESCRIPTION as Salesdescription,');
    qrymain.SQL.add('P.PURCHASEDESC as Purchasedescription,');
    qrymain.SQL.add('concat(AP.AlternateProductName , " as Alternate Products") as description, ');
    qrymain.SQL.add('AP.ProductID as AlternateProductID, ');
    qrymain.SQL.add('AP.ProductName as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault  as isdefault , ');
    qrymain.SQL.add('CL.company as Supplier,');
    qrymain.SQL.add('convert(EP.ExtraPartPriceID, unsigned)  as ExtraPriceID	,');
    qrymain.SQL.add('EP.Buy1 as ExtraPriceQuantity,');
    qrymain.SQL.add('EP.Price as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL) as ForeignPrice,');
    qrymain.SQL.add('EP.SupplierProductCode as SupplierProductCode,');
    qrymain.SQL.add('EP.SupplierProductName as SupplierProductName,');
    qrymain.SQL.add('concat(EP.UOM, "(" , EP.UOMMultiplier, ")") as ExtraPriceUOM,');
    qrymain.SQL.add('EP.UOMMultiplier as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('EP.MinimumOrderQty as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty as instockQty, ');
    qrymain.SQL.add('P.Price1 as Price1,');
    qrymain.SQL.add('P.Cost1 as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin as Defaultbin');
    qrymain.SQL.add(' from ' + fsTablename +' TP inner join tblparts P on TP.partsId = P.partsID  and (TP.classId = :ClassId or ifnull(TP.classId,0)=0)');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.ProductID = P.PARTSID ');
    qrymain.SQL.add('Left join tblextraprice EP on EP.PartsID = P.partsId');
    qrymain.SQL.add('Left join tblclients CL on EP.SupplierID = CL.clientID');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('and AP.AlternateProductId = :ProductId ');
    qrymain.SQL.add('Group by P.partsId');

    qrymain.SQL.add('UNION ALL  ');
    qrymain.SQL.add('select 3 as CAtegory,  ');
    qrymain.SQL.add('P.partsId as PartsId,');
    qrymain.SQL.add('P.Partname as Partname,');
    qrymain.SQL.add('P.PARTSDESCRIPTION as Salesdescription,');
    qrymain.SQL.add('P.PURCHASEDESC as Purchasedescription,');
    qrymain.SQL.add('concat(AP.ProductName, "''s Alternate Products") as description, ');
    qrymain.SQL.add('AP.AlternateProductID as AlternateProductID, ');
    qrymain.SQL.add('AP.AlternateProductName as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault  as isdefault, ');
    qrymain.SQL.add('CL.company as Supplier,');
    qrymain.SQL.add('convert(EP.ExtraPartPriceID, unsigned)  as ExtraPriceID	,');
    qrymain.SQL.add('EP.Buy1 as ExtraPriceQuantity,');
    qrymain.SQL.add('EP.Price as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL) as ForeignPrice,');
    qrymain.SQL.add('EP.SupplierProductCode as SupplierProductCode,');
    qrymain.SQL.add('EP.SupplierProductName as SupplierProductName,');
    qrymain.SQL.add('concat(EP.UOM, "(" , EP.UOMMultiplier, ")") as ExtraPriceUOM,');
    qrymain.SQL.add('EP.UOMMultiplier as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('EP.MinimumOrderQty as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty as instockQty, ');
    qrymain.SQL.add('P.Price1 as Price1,');
    qrymain.SQL.add('P.Cost1 as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin as Defaultbin');
    qrymain.SQL.add(' from ' + fsTablename +' TP inner join tblparts P on TP.partsId = P.partsID  and (TP.classId = :ClassId or ifnull(TP.classId,0)=0)');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('Left join tblextraprice EP on EP.PartsID = P.partsId');
    qrymain.SQL.add('Left join tblclients CL on EP.SupplierID = CL.clientID');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('and AP.ProductId in (Select ProductId from tblpartsalternate where AlternateProductId = :ProductId )');
    qrymain.SQL.add('and AP.AlternateProductId  <> :ProductId');
    qrymain.SQL.add('Group by  AP.ProductId,  AP.AlternateProductID');


    qrymain.SQL.add('Order by Category , description,AlternateProductName , Supplier');
    clog(Qrymain.sql.text);
end;

procedure TAlternateProductSearchGUI.RefreshQuery;
begin
  try Qrymain.Parambyname('ProductID').AsInteger := ProductId; Except end;
  try Qrymain.Parambyname('ClassId').AsInteger   := ClassId  ; Except end;
  inherited;
end;

initialization
  RegisterClassOnce(TAlternateProductSearchGUI);

end.
