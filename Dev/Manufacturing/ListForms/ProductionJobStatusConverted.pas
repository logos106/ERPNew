unit ProductionJobStatusConverted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductionJobStatusbase, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMAction, ActnList,
  PrintDAT, ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar,
  DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TProductionJobStatusConvertedGUI = class(TProductionJobStatusbaseGUI)
    procedure btnOtherListClick(Sender: TObject);
  private
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, CommonFormLib, CommonDbLib, MySQLConst;

{$R *.dfm}
procedure TProductionJobStatusConvertedGUI.btnOtherListClick(
  Sender: TObject);
begin
  inherited;
  if OpenERPListForm('TProductionJobStatusGUI') then
    Self.Close;
end;

procedure TProductionJobStatusConvertedGUI.RefreshQuery;
  function OrderProcessStatus:String;
  begin
    REsult := 'if(ppd.status = "psComplete" , 1 , ' +
                ' if(ppd.status = "psScheduled" , 2, ' +
                ' if(ppd.status = "psStarted" ,3 , ' +
                ' if(ppd.status = "psnotScheduled" , 4, ' +
                ' if(ppd.stats ="psQualityAssurance" , 5, 6) ))))';
  end;
begin
     CloseDB(Qrymain);
     DestroyUserTemporaryTable(tablename);
     ExecuteSQL('create table '+tablename +'  '+
          'SELECT '+
          'S.clientId as clientId, '+
          '1 as Details , '+
          's.SaleId as SaleId, '+
          's.InvoiceDocNumber as SaleDocNumber, '+
          's.CustomerName as SaleCustomerName, '+
          's.ClassId as SaleClassId, '+
          's.ShipDate as SaleShipDate, '+
          's.SaleDate as SaleDate, '+
          'sl.SaleLineId as SaleLineId, '+
          ' SL.ProductId as ProductId,' +
          'sl.ProductName as LineProductName, '+
          'sl.Product_Description as LineProductDescription, '+
          'sl.UnitOfMeasureShipped as LineQty, '+
          'sl.ShipDate as LineShipDate, '+
          'pt.ProcTreeId  as ProcTreeId, '+
          'PT.Complete  Complete , '+
          'PT.FromStockUOMQty,'+
          'PT.ManufactureUOMQty,'+
          'PT.OnOrderUOMQty,'+
          ' ProcessStatus(SL.SaleLineID) as ProcessPartStatus ' +
          'FROM tblSales s '+
          'inner join  tblSalesLines sl on sl.SaleId = s.SaleId '+
          'inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId and PT.ParentId = 0 and pt.MasterType = "mtSalesOrder" '+
          'where  s.SaleDate between '+Quotedstr(FormatDateTime(MysqlDateFormat , FilterDateFrom)) +
          ' AND '+Quotedstr(FormatDateTime(MysqlDateFormat , FilterDateTo)) +' and S.converted = "T"');
  inherited;
end;

initialization
  RegisterClassOnce(TProductionJobStatusConvertedGUI);

end.
