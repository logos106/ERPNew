unit POLineList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TPOLineListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderId: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainpurchaselineID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainUnitOfMeasureQtysold: TFloatField;
    qryMainUnitOfMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainuom: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainTotalEstimated: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    fPurchaseOrderId: integer;
    procedure SetPurchaseOrderId(const Value: integer);
  Protected
    procedure SetGridColumns; Override;
  public
    property PurchaseOrderId: integer read fPurchaseOrderId write SetPurchaseOrderId;
    procedure RefreshQuery; override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TPOLineListGUI }

procedure TPOLineListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;


procedure TPOLineListGUI.RefreshQuery;
begin
  qryMain.ParamByName('PurchaseOrderId').AsInteger := PurchaseOrderId;
  inherited;
end;

procedure TPOLineListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPurchaseOrderId.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMainpurchaselineID.fieldname);
end;

procedure TPOLineListGUI.SetPurchaseOrderId(const Value: integer);
begin
  fPurchaseOrderId := Value;
  TitleLabel.caption := 'PO #' + inttostr(Value) +' Product List';
end;
initialization
  RegisterClass(TPOLineListGUI);

end.
