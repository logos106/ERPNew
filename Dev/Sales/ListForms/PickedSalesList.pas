unit PickedSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TPickedSalesListGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMainTranstype: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainShipDate: TDateField;
    qryMainArea: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainShipCity: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainQty: TFloatField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainAddToManifest: TWideStringField;
    qryMainManifestID: TIntegerField;
    qryMainStartPickingTime: TDateTimeField;
    qryMainFinishedPickingTime: TDateTimeField;
    qryMainStartPackingTime: TDateTimeField;
    qryMainFinishedPackingTime: TDateTimeField;
    qryMainPickstatus: TWideStringField;
    qryMainProductArea: TFloatField;
    qryMainProductWeight: TFloatField;
    qryMaintotalProductArea: TFloatField;
    qryMaintotalProductWeight: TFloatField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TPickedSalesListGUI }

procedure TPickedSalesListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(QrymaintotalProductweight.fieldname, false);
  AddCalcColumn(qryMaintotalProductArea.fieldname, false);
end;

procedure TPickedSalesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.ItemIndex <0 then grpfilters.ItemIndex := 4;
end;

procedure TPickedSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) +qryMainTranstype.AsString;
  inherited;

end;

procedure TPickedSalesListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Pickstatus' , ['Picking','Picked', 'Packing','Packed','']);
  inherited;
end;

procedure TPickedSalesListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;
procedure TPickedSalesListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
end;

(*      'saleId'#9'10'#9'Sale #'
        'Transtype'#9'11'#9'Sale~Type'
        'CustomerName'#9'15'#9'Customer'
        'ShipDate'#9'10'#9'Ship Date'
        'Area'#9'10'#9'Area'
        'ShipTo'#9'20'#9'Address'#9#9'Ship To'
        'ShipCity'#9'10'#9'City'#9#9'Ship To'
        'Shipping'#9'10'#9'Via'
        'Qty'#9'10'#9'Picking~Qty'
        'totalProductArea'#9'10'#9'Area'#9#9'Pick/Pack Qty'
        'totalProductWeight'#9'10'#9'Weight'#9#9'Pick/Pack Qty'
        'CUSTFLD1'#9'10'#9'CUSTFLD1'#9#9'Product'
        'CUSTFLD2'#9'10'#9'CUSTFLD2'#9#9'Product'
        'CUSTFLD3'#9'10'#9'CUSTFLD3'#9#9'Product'
        'CUSTFLD4'#9'10'#9'CUSTFLD4'#9#9'Product'
        'CUSTFLD5'#9'10'#9'CUSTFLD5'#9#9'Product'
        'CUSTFLD6'#9'10'#9'CUSTFLD6'#9#9'Product'
        'CUSTFLD7'#9'10'#9'CUSTFLD7'#9#9'Product'
        'CUSTFLD8'#9'10'#9'CUSTFLD8'#9#9'Product'
        'CUSTFLD9'#9'10'#9'CUSTFLD9'#9#9'Product'
        'CUSTFLD10'#9'10'#9'CUSTFLD10'#9#9'Product'
        'CUSTFLD11'#9'10'#9'CUSTFLD11'#9#9'Product'
        'CUSTFLD12'#9'10'#9'CUSTFLD12'#9#9'Product'
        'CUSTFLD13'#9'10'#9'CUSTFLD13'#9#9'Product'
        'CUSTFLD14'#9'10'#9'CUSTFLD14'#9#9'Product'
        'CUSTFLD15'#9'10'#9'CUSTFLD15'#9#9'Product'
        'AddToManifest'#9'1'#9'Add To Manifest?'
        'ManifestID'#9'10'#9'Manifest #'
        'StartPickingTime'#9'12'#9'Started At'#9#9'Picking'
        'FinishedPickingTime'#9'12'#9'Finished At'#9#9'Picking'
        'StartPackingTime'#9'12'#9'Started At'#9#9'Packing'
        'FinishedPackingTime'#9'12'#9'Finished At'#9#9'Packing'
        'Pickstatus'#9'7'#9'Pick/Pack~Status'
        'ProductArea'#9'10'#9'Area'#9#9'Product'
        'ProductWeight'#9'10'#9'Weight'#9#9'Product')*)

initialization
  RegisterClassOnce(TPickedSalesListGUI);

end.

