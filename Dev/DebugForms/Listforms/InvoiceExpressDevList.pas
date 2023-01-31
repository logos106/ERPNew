unit InvoiceExpressDevList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvoicelistExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TInvoiceExpressDevListGUI = class(TInvoicelistExpressGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;


implementation

uses CommonLib, BusObjSales;

{$R *.dfm}
procedure TInvoiceExpressDevListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  IterateSelectedRecords;

end;

procedure TInvoiceExpressDevListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  EnableMultiselect('');
end;

procedure TInvoiceExpressDevListGUI.IterateselectedRecordsCallback(
  var Abort: boolean; SelIndex: Integer);
var
  Invoice :TInvoice;
begin
  inherited;
    if iterateprocno = 1 then begin
       Invoice := TInvoice.CreateWithNewConn(Self);
       try
          Invoice.Load(qryMainsaleID.asInteger);
          if Invoice.count =0 then exit;
          if Invoice.deleted then exit;
          Invoice.connection.begintransaction;
          try
            Invoice.Lines.deleteall;
            Invoice.deleted := true;
            Invoice.postdb;
            if not Invoice.Save then begin
              Invoice.connection.Rollbacktransaction;
              Exit;
            end;
            Invoice.connection.Committransaction;
          except
            on E:Exception do begin
              Invoice.connection.Rollbacktransaction;
            end;
          end;

       finally
        freeandnil(Invoice);
       end;
    end;

end;

initialization
  RegisterClassOnce(TInvoiceExpressDevListGUI);

end.
