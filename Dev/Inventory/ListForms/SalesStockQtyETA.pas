unit SalesStockQtyETA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesStockQtyStatusBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesStockQtyETAGUI = class(TSalesStockQtyStatusBaseGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainETADate: TDateField;
    qryMainBackorder: TFloatField;
    qryMainClassname: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses LogLib, CommonLib, CommonDbLib, ProductQtyLib, tcConst, PQALib;

{$R *.dfm}

{ TSalesStockQtyETAGUI }

function TSalesStockQtyETAGUI.ExpressDetailListName: String;
begin
  REsult := 'TSalesStockQtyStatusGUI';
end;

procedure TSalesStockQtyETAGUI.FormShow(Sender: TObject);
begin
  inherited;
  if SalesBaseObj <> nil then TitleLabel.caption := 'ETA of Products of ' +  SalesBaseObj.XMLNodename +' # ' + inttostr(SalesBaseObj.ID);
end;

procedure TSalesStockQtyETAGUI.RefreshQuery;
begin
     closedb(Qrymain);
     Qrymain.sql.clear;
     Qrymain.SQL.Clear;
     Qrymain.SQL.Add('SELECT ');
     Qrymain.SQL.Add('P.GlobalRef         as GlobalRef,');
     Qrymain.SQL.Add('PL.ProductName      as ProductName, ');
     Qrymain.SQL.Add('PL.ProductID        as ProductID, ');
     Qrymain.SQL.Add('PL.ETADate          as ETADate,');
     Qrymain.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tPOBO) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+')   AS Backorder,');
     Qrymain.SQL.add('PL.Class            AS Classname, ');
     Qrymain.SQL.Add('PL.PurchaseOrderID  AS PurchaseOrderID ');
     Qrymain.SQL.add('FROM tblpurchaselines AS PL');
     Qrymain.SQL.add('INNER JOIN tblpurchaseorders AS P Using(PurchaseOrderID)');
     Qrymain.SQL.add('inner join tblPQA PQA  ON `PL`.`PurchaseLineID` = `PQA`.`TransLineID` ');
     Qrymain.SQL.add('AND `PL`.`PurchaseOrderID` = `PQA`.`TransID`  ');
     Qrymain.SQL.add('AND `PL`.`PurchaseLineID` = `PQA`.`TransLineID`');
     Qrymain.SQL.add('and  `PQA`.`TransType`   in ('+ POTranstypes+') ');
     Qrymain.SQL.add('and `PQA`.`IsBO` =  "T" and PQA.Active = "T"');
     Qrymain.SQL.add('WHERE P.IsPO="T" ');
     if SalesBaseObj = nil then begin
       Qrymain.SQL.add('and PL.ProductID = 0');
       Qrymain.SQL.Add('AND PL.ClassID = 0' );
     end else begin
      Qrymain.SQL.add('and PL.ProductID in ( ' + SalesBaseObj.ProductIDs +')');
       if chkAllclasses.checked = false then Qrymain.SQL.Add('AND PL.ClassID = ' + inttostr(SalesBaseObj.SaleClassId));
     end;
     Qrymain.SQL.add('GROUP BY PL.PurchaseOrderID , PL.Class , PL.ProductID;');
     clog(Qrymain.SQL.text);
  inherited;

end;

procedure TSalesStockQtyETAGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainProductID.fieldname);
end;
initialization
  RegisterClassOnce(TSalesStockQtyETAGUI);

end.
