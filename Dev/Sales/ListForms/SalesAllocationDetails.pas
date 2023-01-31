unit SalesAllocationDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TSalesAllocationDetailsGUI = class(TBaseListingGUI)
    qryMainsaleID: TIntegerField;
    qryMainsaleLineID: TIntegerField;
    qryMainsaleDAte: TDateField;
    qryMainproductname: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainuom: TWideStringField;
    qryMainSequencedown: TLargeintField;
    qryMainCaption: TWideStringField;
    qryMainTransType: TWideStringField;
    qryMainAlloctype: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainBatchQty: TFloatField;
    qryMainbinlocation: TWideStringField;
    qryMainbinnumber: TWideStringField;
    qryMainbinQty: TFloatField;
    qryMainSerialnumber: TWideStringField;
    qryMainPQaqty: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    fiSaleId: Integer;
    fiSaleLineId: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Property SaleId :Integer read fiSaleId write fiSaleId;
    Property SaleLineId :Integer read fiSaleLineId write fiSaleLineId;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TSalesAllocationDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SaleLineId := 0;
  SaleId := 0;
  HaveDateRangeSelection := False;
end;

procedure TSalesAllocationDetailsGUI.RefreshQuery;
begin
  Qrymain.parambyname('saleId').asInteger := SAleID;
  Qrymain.parambyname('salelineId').asInteger := salelineId;
  inherited;

end;

procedure TSalesAllocationDetailsGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qrymainsaleLineID.fieldname);
    RemoveFieldfromGrid(qrymainSequencedown.fieldname);
end;

initialization
  RegisterClassOnce(TSalesAllocationDetailsGUI);

end.
