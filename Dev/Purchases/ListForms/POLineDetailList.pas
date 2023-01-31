unit POLineDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TPOLineDetailListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderId: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainCost: TFloatField;
    qryMainBatch: TWideStringField;
    qryMainBin: TWideStringField;
    qryMainSN: TWideStringField;
    qryMainBinId: TIntegerField;
    qryMainBinNumber: TWideStringField;
    qryMainBinLocation: TWideStringField;
    qryMainBatchNumber: TWideStringField;
    qryMainExpiryDate: TDateTimeField;
    qryMainSerialNumber: TWideStringField;
  private
    fPurchaseOrderId: integer;
  protected
    procedure RefreshQuery; override;
  public
    property PurchaseOrderId: integer read fPurchaseOrderId write fPurchaseOrderId;
  end;

implementation

{$R *.dfm}

{ TPOLineDetailListGUI }

procedure TPOLineDetailListGUI.RefreshQuery;
begin
  qryMain.ParamByName('PurchaseOrderId').AsInteger := PurchaseOrderId;
  inherited;

end;

initialization
  RegisterClass(TPOLineDetailListGUI);

end.
