unit NegativePOBO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BackOrderPurchaseListForm, kbmMemTable, DB, 
  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents,
  MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  wwcheckbox, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel,
  DNMSpeedButton;

type
  TNegativePOBOGUI = class(TBackOrderPurchaseListGUI)
    qryMainBaseno: TWideStringField;
    qryMainBOID: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonLib, busobjOrders, BusObjBase, CommonDbLib, FastFuncs,
  BaseListingForm;

{$R *.dfm}
procedure TNegativePOBOGUI.grdMainDblClick(Sender: TObject);
var
  PO:TPurchaseOrder;
  fsFieldName:String;
begin
  fsFieldName :=grdMain.GetActiveField.FieldName ;
  if (Sysutils.SameText(fsFieldName , 'Backorder')) then begin

    if CommonLib.MessageDlgXP_Vista('Do You Wish To Delete This Line?' , mtconfirmation , [mbYes, mbNo],0) = mrno then exit;
      PO:=TPurchaseOrder.create(Self);
      try
        PO.connection := tmyDacDataconnection.create(PO);
        Po.connection.Connection := CommonDbLib.GetNewMyDacConnection(PO);
        PO.Load(qryMainPurchaseOrderID.asInteger);
        PO.Connection.BeginTransaction;
        try
          if PO.Lines.locate('PurchaseLineID' , qryMainPurchaseLineID.asInteger , []) then begin
            (*PO.GetNewDataSet(strSQL,true);*)
            PO.Lines.Deleted := true;
            if PO.Save then begin
              PO.connection.CommitTransaction;
              RefreshQuery;
            end else begin
              PO.connection.RollbackTransaction;
            end;
          end;
        except
          PO.connection.RollbackTransaction;
        end;
      finally
          Freeandnil(PO);
      end;

  end else inherited;

end;

procedure TNegativePOBOGUI.RefreshQuery;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TNegativePOBOGUI);

end.
