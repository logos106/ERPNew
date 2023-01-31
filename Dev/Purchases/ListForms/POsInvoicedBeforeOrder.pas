unit POsInvoicedBeforeOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PurchaseOrderListExpress, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TPOsInvoicedBeforeOrderGUI = class(TPurchaseOrderListExpressGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    procedure CreatePOBackupTable;
    Procedure BackupPOrec(const POID:Integer);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetGridColumns; Override;
  public

  end;

implementation

uses CommonLib, busobjOrders, BusObjBase, CommonDbLib, SharedObjs;

{$R *.dfm}
procedure TPOsInvoicedBeforeOrderGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  CreatePOBackupTable;
  iterateProcNo := 1;
  IterateselectedRecordsReverse(true);
end;
procedure TPOsInvoicedBeforeOrderGUI.BackupPOrec(const POID: Integer);
begin
  CreatePOBackupTable;
   executeSQL('insert ignore into ' + ERPFIXTablenameforCurVersion('tblpurchaseorders') +' select * from tblpurchaseorders where purchaseorderId = ' + inttostr(POID)+';'+
              'insert ignore into ' + ERPFIXTablenameforCurVersion('tblpurchaselines')  +' select * from tblpurchaselines  where purchaseorderId = ' + inttostr(POID)+';');
end;

Procedure TPOsInvoicedBeforeOrderGUI.CreatePOBackupTable;
begin
   executeSQL('create table if not exists ' + ERPFIXTablenameforCurVersion('tblpurchaseorders') +' like tblpurchaseorders;'+
              'create table if not exists ' + ERPFIXTablenameforCurVersion('tblpurchaselines')  +' like tblpurchaselines;');
end;
procedure TPOsInvoicedBeforeOrderGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  iterateProcNo := 2;
  IterateselectedRecordsReverse(true);
end;

procedure TPOsInvoicedBeforeOrderGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.Caption := 'POs Invoiced before Ordered';
end;

procedure TPOsInvoicedBeforeOrderGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(field.FieldName ,  qrymainorderdate.FieldName) or
      sametext(field.FieldName ,  qrymaininvoicedate.FieldName) then
        ABrush.Color := $00C4C4FF;
end;

procedure TPOsInvoicedBeforeOrderGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  PO :TPurchaseOrder;
begin
  inherited;
  if (iterateProcNo<>1) and (iterateProcNo<>2) then exit;
  PO := TPurchaseOrder.CreateWithNewConn(self);
  try
    PO.Load(qryMainPurchaseOrderID.AsInteger);
    if PO.Count =0 then exit;
    if not PO.Lock  then exit;
    if PO.SupplierInvoiceDate =0 then exit;
    if PO.OrderDate =0 then exit;
    if PO.SupplierInvoiceDate >= PO.OrderDate then exit;

    BackupPOrec(PO.ID);
    PO.Connection.BeginTransaction;
    try
      if iterateProcNo = 1 then begin
        PO.OrderDate := PO.SupplierInvoiceDate;
      end else if iterateProcNo =2 then begin
        PO.SupplierInvoiceDate := PO.OrderDate;
      end;
      PO.PostDb;
      PO.Connection.CommitTransaction;
      grdmain.UnselectRecord;
    Except
      on E:Exception do begin
        PO.Connection.RollbackTransaction;
      end;
    end;
  finally
    freeandnil(PO);
  end;
end;

procedure TPOsInvoicedBeforeOrderGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainSmartOrderApprovedBy.fieldname);
end;

initialization
  RegisterClassOnce(TPOsInvoicedBeforeOrderGUI);
end.

