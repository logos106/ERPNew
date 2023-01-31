unit ProductQtysList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductQtysListGUI = class(TBaseListingGUI)
    qryMainPartname: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainOnBuildQty: TFloatField;
    qryMainBuildingQty: TFloatField;
    qryMainBuiltQty: TFloatField;
    qryMainSubBuiltQty: TFloatField;
    qryMainUSedForBuildQty: TFloatField;
    qryMainInStockQty: TFloatField;
    qryMainInStocknOnOrderQty: TFloatField;
    qryMainActStockwithManQty: TFloatField;
    qryMainActStockQty: TFloatField;
    qryMainStockQtyQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainAvailablenOnOrderQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainInvBOQty: TFloatField;
    qryMainTotSalesQty: TFloatField;
    qryMainPOBOQty: TFloatField;
    qryMainSOBOQty: TFloatField;
    qryMainTransQtyQty: TFloatField;
    qryMainInStockMovementQty: TFloatField;
    qryMainOUTsQty: TFloatField;
    qryMainINsQty: TFloatField;
    qryMainOnTransitQty: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure BuildMainQuery;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses PQALib, LogLib, CommonLib;

{$R *.dfm}

{ TProductQtysListGUI }

procedure TProductQtysListGUI.BuildMainQuery;
begin
  Qrymain.SQL.clear;
  Qrymain.Sql.add('Select');
  Qrymain.Sql.add('Partname as Partname,');
  Qrymain.Sql.add('PartType as PartType,');
  Qrymain.Sql.add(SQL4QtyField(tOnBuild) +' as OnBuildQty,');
  Qrymain.Sql.add(SQL4QtyField(tBuilding) +' as BuildingQty,');
  Qrymain.Sql.add(SQL4QtyField(tBuilt) +' as BuiltQty,');
  Qrymain.Sql.add(SQL4QtyField(tSubBuilt) +' as SubBuiltQty,');
  Qrymain.Sql.add(SQL4QtyField(tUSedForBuild) +' as USedForBuildQty,');
  Qrymain.Sql.add(SQL4QtyField(tInStock) +' as InStockQty,');
  Qrymain.Sql.add(SQL4QtyField(tInStocknOnOrder) +' as InStocknOnOrderQty,');
  Qrymain.Sql.add(SQL4QtyField(tActStockwithMan) +' as ActStockwithManQty,');
  Qrymain.Sql.add(SQL4QtyField(tActStock) +' as ActStockQty,');
  Qrymain.Sql.add(SQL4QtyField(tStockQty) +' as StockQtyQty,');
  Qrymain.Sql.add(SQL4QtyField(tAvailable) +' as AvailableQty,');
  Qrymain.Sql.add(SQL4QtyField(tAvailablenOnOrder) +' as AvailablenOnOrderQty,');
  Qrymain.Sql.add(SQL4QtyField(tSO) +' as SOQty,');
  Qrymain.Sql.add(SQL4QtyField(tInvBO) +' as InvBOQty,');
  Qrymain.Sql.add(SQL4QtyField(tTotSales) +' as TotSalesQty,');
  Qrymain.Sql.add(SQL4QtyField(tPOBO) +' as POBOQty,');
  Qrymain.Sql.add(SQL4QtyField(tSOBO) +' as SOBOQty,');
  Qrymain.Sql.add(SQL4QtyField(tTransQty) +' as TransQtyQty,');
  Qrymain.Sql.add(SQL4QtyField(tInStockMovement) +' as InStockMovementQty,');
  Qrymain.Sql.add(SQL4QtyField(tOUTs) +' as OUTsQty,');
  Qrymain.Sql.add(SQL4QtyField(tINs) +' as INsQty,');
  Qrymain.Sql.add(SQL4QtyField(tOnTransitOut,'','Qty') +' as OnTransitQty');
  Qrymain.Sql.add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
  Qrymain.Sql.add('group by p.partsID');
  Qrymain.Sql.add('Order by partname');
  clog(Qrymain.sql.text);
end;

procedure TProductQtysListGUI.FormCreate(Sender: TObject);
begin
  BuildMainQuery;
  inherited;
end;

procedure TProductQtysListGUI.RefreshQuery;
begin
(*  CloseDB(QryMain);
  BuildMainQuery;*)
  inherited;
end;
initialization
  RegisterClassOnce(TProductQtysListGUI);

end.
