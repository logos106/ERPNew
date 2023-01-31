unit TranswithBOMissing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TTranswithBOMissingGUI = class(TBaseListingGUI)
    qryMainType: TWideStringField;
    qryMainID: TIntegerField;
    qryMainqtysold: TFloatField;
    qryMainshipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainisSalesOrder: TWideStringField;
    qryMainisinvoice: TWideStringField;
    qryMainISPO: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    { Public declarations }
  end;


implementation

uses BusObjSales, BusObjBase, CommonLib, tcConst, busobjOrders, BusObjTrans;

{$R *.dfm}
procedure TTranswithBOMissingGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if grdmain.selectedList.count =0 then begin
    if MessageDlgXP_vista('You haven''t selected the Sales records to be fixed. Do you want to Fix all?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
    grdmain.selectAll;
  end;
  if grdmain.selectedList.count =0 then Exit;

  if MessageDlgXP_vista('This will create the missing backorder for all the selected transactions. Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  IterateProcNo:= 1;
  IterateselectedRecords(true , WAITMSG);
  RefreshQuery;
end;

procedure TTranswithBOMissingGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) +qrymaintype.asString;
  inherited;

end;

procedure TTranswithBOMissingGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  TransObj :TTransbase;
  errmsg:String;
begin
  inherited;
  if IterateProcNo = 1 then begin
    if QrymainISPO.AsBoolean then
      TransObj := TPurchaseOrder.CreateWithNewConn(Self)
    else if Qrymainisinvoice.AsBoolean then
      TransObj := TInvoice.CreateWithNewConn(Self)
    else if qrymainissalesorder.asBoolean then
      TransObj := TSalesOrder.CreateWithNewConn(Self)
    else exit;

      try
        TransObj.Load(QrymainID.AsInteger);
        if TransObj.Count =0 then begin
          MessageDlgXP_vista(TransObj.XMLNodeName+ ' #' + inttostr(QrymainID.asInteger) +' missing.', mtWarning, [mbOK], 0);
          exit;
        end;

        if not TransObj.LockTrans(errmsg) then begin
          MessageDlgXP_vista(TransObj.XMLNodeName+ ' #' + inttostr(QrymainID.asInteger) +' is locked.' +NL +Errmsg, mtWarning, [mbOK], 0);
          exit;
        end;
        TransObj.Connection.BeginTransaction;
        try
          TransObj.Dirty := true;
          if not TransObj.Save then begin
            TransObj.Connection.RollbackTransaction;
            Exit;
          end;
          TransObj.Connection.CommitTransaction;
        Except
          on E:EXception do begin
            MessageDlgXP_vista(TransObj.XMLNodeName+ ' #' + inttostr(QrymainID.asInteger) +' Failed to Save' +NL +E.Message, mtWarning, [mbOK], 0);
            TransObj.Connection.RollbackTransaction;
          end;
        end;

      finally
        FreeandNil(TransObj);
      end;
  end;

end;

initialization
  RegisterClassOnce(TTranswithBOMissingGUI);

end.

