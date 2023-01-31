unit TransMissingBO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TTransMissingBOList = class(TBaseListingGUI)
    qryMaintype: TWideStringField;
    qryMainid: TIntegerField;
    qryMainshipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainboid: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    Tablename:String;
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TTransMissingBOList.FormCreate(Sender: TObject);
var
  s:String;
begin
  tablename := commondblib.GetUserTemporaryTableName('missingbo');
  s:= 'Drop table if exists '+tablename +';' +
        ' create table '+tablename +'' +
        ' select "Purchase Order"  type, po.PurchaseOrderId id , sum(abs(pl.Shipped)) shipped , sum(abs(pl.backorder)) backorder  , po.boid' +
        ' from tblpurchaseorders PO inner join tblpurchaselines pl  on po.purchaseOrderId= pl.purchaseorderId' +
        ' group by po.PurchaseOrderId' +
        ' union all' +
        ' select if(isinvoice="T", "Invoice" , "Sales order") , s.SaleID, sum(abs(sl.Shipped)) shipped , sum(abs(sl.backorder)) backorder  , s.boid' +
        ' from tblsales  s inner join tblsaleslines sl  on S.SaleId = Sl.SaleID' +
        ' group by S.SAleId;';
  ExecuteSQL(s);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select * from ' + tablename+'  where ifnull(Shipped,0)<> 0 and ifnull(backorder,0)<> 0 and ifnull(boid,"")=""');
  inherited;
end;

procedure TTransMissingBOList.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;
initialization
  RegisterClassOnce(TTransMissingBOList);

end.

