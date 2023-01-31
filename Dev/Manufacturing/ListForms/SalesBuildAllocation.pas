unit SalesBuildAllocation;

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
  TSalesBuildAllocationGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    QrySalesOrder: TERPQuery;
    dsSalesOrder: TDataSource;
    qryMainTreeNodeCaption: TWideStringField;
    qryMainproctreeid: TIntegerField;
    qryMainbatchno: TWideStringField;
    qryMainexpirydate: TDateTimeField;
    qryMainbinlocation: TWideStringField;
    qryMainbinnumber: TWideStringField;
    qryMainserialnumebr: TWideStringField;
    qryMainSequenceDown: TIntegerField;
    qryMainalloctype: TWideStringField;
    qryMainpqaid: TIntegerField;
    QrySalesOrderSaleID: TIntegerField;
    QrySalesOrderSaleLineId: TIntegerField;
    QrySalesOrderUnitofMeasureQtySold: TFloatField;
    QrySalesOrderUnitofMeasureShipped: TFloatField;
    QrySalesOrderUnitofMeasureBackorder: TFloatField;
    QrySalesOrderUOM: TWideStringField;
    wwDBGrid1: TwwDBGrid;
    wwIButton1: TwwIButton;
    QrySalesOrderproductname: TWideStringField;
    qryMainUOMQty: TFloatField;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    fiSaleLineID: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property SaleLineID:Integer read fiSaleLineID write fiSaleLineID;
  end;


implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TSalesBuildAllocationGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TSalesBuildAllocationGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  closedb(QrySalesOrder);
  QrySalesOrder.parambyname('saleLineID').asInteger :=  Qrymain.parambyname('saleLineID').asInteger ;
  QrySalesOrder.connection := Qrymain.Connection;
  opendb(QrySalesOrder);
end;

procedure TSalesBuildAllocationGUI.RefreshQuery;
begin
  Qrymain.parambyname('saleLineID').asInteger := SaleLineId;
  inherited;
end;

procedure TSalesBuildAllocationGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainproctreeid.fieldname);
  RemoveFieldfromGrid(qryMainSequenceDown.fieldname);
  RemoveFieldfromGrid(qryMainpqaid.fieldname);
end;
initialization
  RegisterClassOnce(TSalesBuildAllocationGUI);

end.
