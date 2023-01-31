unit AlternateProductList;

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
  TAlternateProductListGUI = class(TBaseListingGUI)
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainAlternateProductID: TIntegerField;
    qryMainAlternateProductName: TWideStringField;
    qryMainisdefault: TWideStringField;
    qryMainclassname: TWideStringField;
    qryMainInstockQty: TFloatField;
    qryMainPrice1: TFloatField;
    qryMainCost1: TFloatField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainDefaultbin: TWideStringField;
    qryMainAlternateProductActive: TWideStringField;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ProductQtyLib, PQALib;

{$R *.dfm}
{ TAlternateProductListGUI }

procedure TAlternateProductListGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TAlternateProductListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(ActiveFieldname , Qrymainproductname.fieldname) then
  inherited;

end;

procedure TAlternateProductListGUI.MakeQrymain;
begin
  closedb(qrymain);
  qrymain.SQL.clear;
  qrymain.SQL.add('select  ');
  qrymain.SQL.add('AP.ProductId  as ProductId ,  ');
  qrymain.SQL.add('AP.ProductName  as ProductName ,  ');
  qrymain.SQL.add('AP.AlternateProductID as AlternateProductID, ');
  qrymain.SQL.add('AP.AlternateProductName as AlternateProductName, ');
  qrymain.SQL.add('AP.isdefault  as isdefault, ');
  qrymain.SQL.add('P.active as AlternateProductActive, ');
  qrymain.SQL.add('C.classname as classname, ');
  qrymain.SQL.add(ProductQtyLib.SQL4Qty(tInStock) + ' as InstockQty, ');
  qrymain.SQL.add('P.Price1 as Price1,');
  qrymain.SQL.add('P.Cost1 as Cost1,');
  qrymain.SQL.add('P.PREFEREDSUPP as PREFEREDSUPP,');
  qrymain.SQL.add('concat(PB.BinLocation , "-" , PB.BinNumber) as Defaultbin');
  qrymain.SQL.add('from '+ replacestr(ProductTables(tSummary) , 'inner' , 'LEFT')+ ' ' );
  qrymain.SQL.add('Left join tblproductbin PB on PB.BinID = PC.DefaultbinId');
  qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
  qrymain.SQL.add('Where P.Active <> "F" ');
  qrymain.SQL.add('Group by AP.ProductId, P.partsId , PQa.departmentID');
  qrymain.SQL.add('Order by Productname, AlternateProductName, Classname');
end;

procedure TAlternateProductListGUI.RefreshQuery;
begin
  inherited;

end;

procedure TAlternateProductListGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TAlternateProductListGUI);

end.
