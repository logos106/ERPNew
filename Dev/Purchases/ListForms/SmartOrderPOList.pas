unit SmartOrderPOList;

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
  TSmartOrderPOListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainOrdered: TFloatField;
    qryMainShipped: TFloatField;
    qryMainBO: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainOrderDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainLineCostAmount: TFloatField;
    qryMainETADate: TDateField;
    qryMainClass: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainConNote: TWideStringField;
    qryMainOrderStatus: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainFuturePo: TWideStringField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainLeadDays: TLargeintField;
    qryMainOrderLineCustomField1: TWideStringField;
    qryMainOrderLineCustomField2: TWideStringField;
    qryMainOrderLineCustomField3: TWideStringField;
    qryMainOrderLineCustomField4: TWideStringField;
    qryMainOrderLineCustomField5: TWideStringField;
    qryMainOrderLineCustomField6: TWideStringField;
    qryMainOrderLineCustomField7: TWideStringField;
    qryMainOrderLineCustomField8: TWideStringField;
    qryMainOrderLineCustomField9: TWideStringField;
    qryMainOrderLineCustomField10: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fismartOrderId: Integer;
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
    Property smartOrderId :Integer read fismartOrderId write fismartOrderId;
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TSmartOrderPOListGUI }

procedure TSmartOrderPOListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TSmartOrderPOListGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Purchase orders of Smart Order # '+ trim(inttostr(SmartOrderId));
end;

procedure TSmartOrderPOListGUI.RefreshQuery;
begin
  Qrymain.parambyname('SOID').asInteger := smartOrderId;
  inherited;

end;

initialization
  RegisterClassOnce(TSmartOrderPOListGUI);

end.
