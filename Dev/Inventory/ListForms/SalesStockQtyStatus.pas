unit SalesStockQtyStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , SalesStockQtyStatusBase,
  wwclearbuttongroup, wwradiogroup;

type
  TSalesStockQtyStatusGUI = class(TSalesStockQtyStatusBaseGUI)
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainPartsID: TIntegerField;
    qryMainPartName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainAvailableQty: TFloatField;
    qryMainInStockQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainSOBOQty: TFloatField;
    qryMainBOQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    procedure FormShow(Sender: TObject);
  private

  Protected
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery; Override;

  end;


implementation

uses CommonDbLib, ProductQtyLib, CommonLib, LogLib, ProductQtylist, PQALib,
  AppEnvironment, tcConst;


{$R *.dfm}

{ TBaseListingGUI1 }

function TSalesStockQtyStatusGUI.ExpressDetailListName: String;
begin
  REsult := 'TSalesStockQtyETAGUI';
end;

procedure TSalesStockQtyStatusGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Stock Qty Status of ' +  SalesBaseObj.XMLNodename +' # ' + inttostr(SalesBaseObj.ID);
end;


procedure TSalesStockQtyStatusGUI.RefreshQuery;
begin
     closedb(Qrymain);
     Qrymain.sql.clear;
     Qrymain.SQL.add('Select ');
     Qrymain.SQL.add('PC.ClassID            as ClassID, ');
     Qrymain.SQL.add('PC.ClassName          as ClassName,');
     Qrymain.SQL.add('P.PartsID             as PartsID,  ');
     Qrymain.SQL.add('P.PartName            as PartName,');
     Qrymain.SQL.add('P.ProductPrintName    as ProductPrintName,');
     Qrymain.SQL.add(SQL4Qty(tAvailable) +' as   AvailableQty,');
     Qrymain.SQL.add(SQL4Qty(tInstock)   +' as   InStockQty,');
     Qrymain.SQL.add(SQL4Qty(tSO)        +' as   SOQty,');
     Qrymain.SQL.add(SQL4Qty(tSOBO)      +' as   SOBOQty,');
     Qrymain.SQL.add(SQL4Qty(tInvBO)     +' as   BOQty,');
     Qrymain.SQL.add(SQL4Qty(tPOBO)      +' as   OnOrderQty');
     Qrymain.SQL.add('FROM ' + ProductTables(tProductList));
     if SalesBaseObj = nil then begin
        Qrymain.SQL.add('Where PC.ClassID = 0' );
        Qrymain.SQL.add('and  PC.ProductID = 0');
     end else begin
        Qrymain.SQL.add('Where PC.ProductID in ( ' + SalesBaseObj.ProductIDs +')');
        if chkAllclasses.checked = false then Qrymain.SQL.add('AND PC.ClassID = ' + inttostr(SalesBaseObj.SaleClassId));
     end;
     Qrymain.SQL.add('group by PC.ClassID, PC.ClassName , PC.ProductID');
     Qrymain.SQL.add('Order by  ClassName , PartName');
     clog(Qrymain.SQL.Text);
     inherited;
end;
procedure TSalesStockQtyStatusGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainClassID.fieldname);
  RemoveFieldfromGrid(QrymainPartsID.fieldname);
end;


initialization
  RegisterClassOnce(TSalesStockQtyStatusGUI);

end.
