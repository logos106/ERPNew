unit frmGoodsReceiptPrintPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, wwdblook,
  DNMSpeedButton, Shader, DNMPanel, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, Mask, wwdbedit;

type
  TfmGoodsReceiptPrintPO = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboPO: TwwDBLookupCombo;
    qryPO: TERPQuery;
    MyConnection: TERPConnection;
    qryPOPurchaseOrderID: TLargeIntField;
    qryPOPurchaseOrderNumber: TWideStringField;
    qryPOClientPrintName: TWideStringField;
    wwDBEdit1: TwwDBEdit;
    dsPO: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SelectPurchaseOrder(var aPOID: integer): boolean;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

function SelectPurchaseOrder(var aPOID: integer): boolean;
var
  form: TfmGoodsReceiptPrintPO;
begin
  form := TfmGoodsReceiptPrintPO.Create(nil);
  try
    if aPOID > 0 then begin
      if form.qryPO.Locate('PurchaseOrderID',aPOID,[]) then
        form.cboPO.Text := form.qryPO.FieldByName('PurchaseOrderNumber').AsString;
    end;
    result := form.ShowModal = mrOK;
    if result then
      aPOID := form.qryPO.FieldByName('PurchaseOrderID').AsInteger;
  finally
    form.Free;
  end;
end;

procedure TfmGoodsReceiptPrintPO.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if cboPO.Text <> '' then
    modalresult := mrOK
  else
    CommonLib.MessageDlgXP_Vista('Please Select a Purchase Order',mtInformation,[mbOk],0);
end;

procedure TfmGoodsReceiptPrintPO.FormCreate(Sender: TObject);
begin
  inherited;
  qryPO.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPO.Open;
end;

end.
