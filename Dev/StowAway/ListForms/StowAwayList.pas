unit StowAwayList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TStowAwayListGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainPSAID: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainproductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainTotalStowedQty: TFloatField;
    qryMainExtraQtyManufactures: TFloatField;
    qryMainExtraQtyToCustomer: TFloatField;
    qryMainExtraQtytoStore: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainStowAwayDate: TDateTimeField;
    qryMainStowQty: TFloatField;
    qryMainStowAwayUOM: TWideStringField;
    qryMainLineStowQty: TFloatField;
    qryMainIsInternalOrder: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainproctreeId: TIntegerField;
    chkincludeNonStowed: TwwCheckBox;
    lblincludeNonStowed: TLabel;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
    procedure beforeShowfmStowAway(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, ManufactureLib, CommonFormLib, frmStowAway, tcConst;

{$R *.dfm}

{ TStowAwayListGUI }
procedure TStowAwayListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblincludeNonStowed.Caption := 'Include Non-Stowed Jobs ' +NL+'(Apply filter on the Scheduled Date)'
end;

procedure TStowAwayListGUI.FormShow(Sender: TObject);
begin
  inherited;
  ReadnApplyGuiPrefExtra;
end;

procedure TStowAwayListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QrymainDetails.AsInteger = 1 then
      AFont.Color := clBlue
  else if grpfilters.ItemIndex =0 then
      AFont.Style := Afont.Style - [fsBold]
  else if grpfilters.ItemIndex=1 then begin
         if QrymainDetails.AsInteger = 2 then AFont.Style := Afont.Style + [fsBold]
    else if QrymainDetails.AsInteger = 3 then  AFont.Style := Afont.Style - [fsBold]
  end else if grpfilters.ItemIndex=2 then begin
         if QrymainDetails.AsInteger = 2 then AFont.Style := Afont.Style + [fsBold]
    else if QrymainDetails.AsInteger = 3 then  AFont.Style := Afont.Style - [fsBold]
    else if QrymainDetails.AsInteger = 4 then  AFont.color := $005C6D76;
  end;
  if QrymainDetails.AsInteger = 3 then begin
    if sameText(field.fieldname , QrymainEmployeeName.fieldname) or
        sameText(field.fieldname , QrymainStowAwayDate.fieldname) or
        sameText(field.fieldname , QrymainStowQty.fieldname) then
    else AFont.color := ABrush.color;
  end else if QrymainDetails.AsInteger = 4 then begin
    if sameText(field.fieldname , QrymainStowAwayUOM.fieldname) or
        sameText(field.fieldname , QrymainLineStowQty.fieldname) then
    else AFont.color := ABrush.color;
  end;
end;

procedure TStowAwayListGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
//  MessageDlgXP_vista('Stow Aways can be changed from Capacity Planner only', mtWarning, [mbOK], 0);
  if not ManufactureLib.LockCapacityplanner(Userlock, 'Stow Away', 'Do Stow Away', False ) then Exit;
  OpenERPFormModal('TfmStowAway' , 0 ,beforeShowfmStowAway);
end;
procedure TStowAwayListGUI.beforeShowfmStowAway(Sender: TObject);
begin
  if not(Sender is  TfmStowAway) then exit;
  TfmStowAway(Sender).proctreeId := QrymainProctreeId.asInteger;
  TfmStowAway(Sender).StowAwayID := QrymainPSAID.asInteger;
end;
procedure TStowAwayListGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterString := '';
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'details = 2';
    1:GroupFilterString := 'details = 2 or Details = 3';
    2:GroupFilterString := 'details = 2 or Details = 3 or Details = 4';
  end;
  if chkincludeNonStowed.Checked then
    GroupFilterString :=  GroupFilterString  + ' or Details = 1';
  inherited;

end;

procedure TStowAwayListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
      if GuiPrefs.Node.Exists('ExtraOptions') then begin
        chkincludeNonStowed.Checked := GuiPrefs.Node['ExtraOptions.IncludeNonStowed'].asBoolean;
      end;
end;

procedure TStowAwayListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Datefrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime   := FilterDateTo;
  inherited;
end;

procedure TStowAwayListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.FieldName);
  RemoveFieldfromGrid(QrymainProctreeId.FieldName);
  RemoveFieldfromGrid(QrymainPSAID.FieldName);
end;

procedure TStowAwayListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['ExtraOptions.IncludeNonStowed'].asBoolean := chkincludeNonStowed.Checked;
end;

initialization
  RegisterClassOnce(TStowAwayListGUI);
{        'SaleId'#9'10'#9'Id #'#9#9'Sales Info'
        'customername'#9'15'#9'Customer'#9#9'Sales Info'
        'SaleDate'#9'10'#9'Date'#9#9'Sales Info'
        'productName'#9'10'#9'Product'#9#9'Sales Info'
        'IsInternalOrder'#9'1'#9'Internal Order?'#9#9'Sales Info'
        'UOM'#9'10'#9'Sold As'#9#9'Sales Info'
        'UnitofMeasureShipped'#9'10'#9'Sales'#9#9'Sales Info'
        'OnOrderUOMQty'#9'10'#9'To Order'#9#9'Quantity'
        'FromStockUOMQty'#9'10'#9'From Stock'#9#9'Quantity'
        'ManufactureUOMQty'#9'10'#9'To Build'#9#9'Quantity'
        'TotalStowedQty'#9'10'#9'Total Stowed'#9#9'Quantity'
        'ExtraQtyManufactures'#9'10'#9'Extra Built'#9#9'Quantity'
        'ExtraQtyToCustomer'#9'10'#9'Extra For Customer'#9#9'Quantity'
        'ExtraQtytoStore'#9'10'#9'Extra to Store'#9#9'Quantity'
        'EmployeeName'#9'10'#9'Stow~Awayed by'
        'StowAwayDate'#9'18'#9'Stow~Awayed On'
        'StowQty'#9'10'#9'Total'#9#9'Stow Awayed Quantity'
        'StowAwayUOM'#9'10'#9'UOM'#9#9'Stow Awayed Quantity'
        'LineStowQty'#9'10'#9'in UOM'#9#9'Stow Awayed Quantity')
}
end.

