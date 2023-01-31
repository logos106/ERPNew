unit WorkOrdersUnScheduled;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkOrders, DAScript, MyScript, ERPdbComponents, DB, SelectionDialog,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TWorkOrdersUnScheduledGUI = class(TWorkOrdersGUI)
  private
  Protected
    procedure MakeQrymain;Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, LogLib;

{$R *.dfm}

procedure TWorkOrdersUnScheduledGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('select');
  Qrymain.SQL.add('convert(0,UNSIGNED) as ProcessTimeId,');
  Qrymain.SQL.add('PP.ID as PPid,');
  Qrymain.SQL.add('PT.ProctreeId as ProctreeId,');
  Qrymain.SQL.add('S.saleId as saleId,');
  Qrymain.SQL.add('SL.saleLineId as saleLineId,');
  Qrymain.SQL.add('S.CustomerName as CustomerName,');
  Qrymain.SQL.add('S.SaleDate as SaleDate,');
  Qrymain.SQL.add('SL.ShipDate as ShipDate,');
  Qrymain.SQL.add('PT.Caption as Caption,');
  Qrymain.SQL.add('replace(Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)),"," , "\n") CaptionIntend,');
  Qrymain.SQL.add('Null as EmployeeName,');
  Qrymain.SQL.add('Null as ResourceName,');
  Qrymain.SQL.add('Null as ResourceDetailName,');
  Qrymain.SQL.add('convert(Null, DATETIME) as TimeStart ,');
  Qrymain.SQL.add('convert(NULL, DATETIME) as SchdDate,');
  Qrymain.SQL.add('convert(NULL, DATETIME)  as TimeEnd,');
  Qrymain.SQL.add('PT.totalqty as totalqty,');
  Qrymain.SQL.add('PT.quantity as quantity,');
  Qrymain.SQL.add('Pt.ManufactureUOMQty as ManufactureUOMQty,');
  Qrymain.SQL.add('PT.FromStockUOMQty as FromStockUOMQty,');
  Qrymain.SQL.add('PT.OnOrderUOMQty as OnOrderUOMQty,');
  Qrymain.SQL.add('convert(FormatSecondsTotime(PP.duration*PT.totalqty), char(50)) as Duration');
  Qrymain.SQL.add('from tblSales S ');
  Qrymain.SQL.add('inner join tblSaleslines SL on S.saleId = SL.saleID');
  Qrymain.SQL.add('inner join tblprocTree PT on PT.masterId = SL.saleLineId and PT.mastertype <> "mtProduct"');
  Qrymain.SQL.add('inner join tblprocesspart PP on PT.ProctreeId = PP.ProcTreeId');
  Qrymain.SQL.add('LEft join tblprocTree PTParent ON PT.parentID = PTParent.proctreeId');
  Qrymain.SQL.add('where (ifnull(PP.Status , "" ) = "" Or PP.Status ="psNotScheduled" ) '+
                  ' AND S.converted ="F" AND ifnull(PT.ManufactureQty,0)<>0 AND (IFNULL(PT.parentID,0)=0 OR (PTParent.Inputtype <>"itOption" OR Pt.selected ="T" ))'+
                  ' and S.SaleDate between :DateFrom and :DateTo') ;
  Qrymain.SQL.add('Order by SaleID, SaleDate, SaleId, SaleLineId , PT.Sequencedown  , PP.ProcessStepSeq;');
  clog(qrymain.SQLText);
end;

procedure TWorkOrdersUnScheduledGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainEmployeeName.FieldName);
  RemoveFieldfromGrid(qryMainResourceName.FieldName);
  RemoveFieldfromGrid(qryMainResourceDetailName.FieldName);
  RemoveFieldfromGrid(qryMainTimeStart .FieldName);
  RemoveFieldfromGrid(qryMainSchdDate.FieldName);
  RemoveFieldfromGrid(qryMainTimeEnd.FieldName);
end;

Initialization
  RegisterClassOnce(TWorkOrdersUnScheduledGUI);

end.
