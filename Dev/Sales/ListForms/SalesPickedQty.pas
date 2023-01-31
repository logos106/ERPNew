unit SalesPickedQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesPickedQtyGUI = class(TBaseListingGUI)
    qryMainproductname: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainTotalshipped: TFloatField;
    qryMainQtyBackorder: TFloatField;
    qryMainQtyPacked: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMId: TIntegerField;
    qryMainUOMMultiplier: TFloatField;
    grpSales: TRadioGroup;
    qryMainSaleId: TLargeintField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsOriginalno:String;
    fisaleId:Integer;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; Override;
    Property SaleID :Integer read fiSaleId write fisaleId;
    Property Originalno :String read fsOriginalno write fsOriginalno;
  end;


implementation

uses CommonLib, tcDataUtils;

{$R *.dfm}
procedure TSalesPickedQtyGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsOriginalno:='';
  fisaleId:=0;
end;

procedure TSalesPickedQtyGUI.FormShow(Sender: TObject);
begin
  inherited;
  if saleId <> 0 then
    if originalno = '' then
      originalno := getSalesOriginalno(saleID);

  grpSales.visible := (saleID<>0) and (Originalno <> '');
  if grpSales.visible then begin
    grpSales.items[0] := SaleType(SaleID) + '# ' + inttostr(SaleID);
    grpSales.items[1] := 'All ' + SaleType(SaleID) + '(s) of the group'
  end;

end;

procedure TSalesPickedQtyGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;

end;

procedure TSalesPickedQtyGUI.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
      if GuiPrefs.Node.Exists('grpSales') then begin
        x := GuiPrefs.Node['grpSales.ItemIndex'].asInteger;
        if x > 0 then if grpSales.Items.Count >= x then grpSales.ItemIndex := x - 1;
      end;
      inherited;
end;

procedure TSalesPickedQtyGUI.RefreshQuery;
begin
  if grpSales.itemindex =0 then begin
    Qrymain.parambyname('OriginalNo').asString := '';
    Qrymain.parambyname('SaleId').asInteger := SaleId;
  end else begin
    Qrymain.parambyname('OriginalNo').asString := OriginalNo;
    Qrymain.parambyname('SaleId').asInteger := 0;
  end;
  if grpfilters.itemindex = 1 then Qrymain.parambyname('groupProduct').asString := 'F' else Qrymain.parambyname('groupProduct').asString := 'T';

  if (saleId <> 0) and (grpSales.itemindex=0) then
      TitleLabel.caption := 'Sales Picked of ' + SaleType(SaleID) +' Group # ' + quotedstr(originalno)
  else if OriginalNo <> '' then
      TitleLabel.caption := 'Sales Picked of ' + SaleType(SaleID) +' # ' + inttostr(SaleID)
  else TitleLabel.caption := 'Sales Picked';


  Qrymain.parambyname('dateFrom').asDateTime := filterDateFrom;
  Qrymain.parambyname('dateTo').asDateTime   := filterDateTo;
  inherited;
end;

procedure TSalesPickedQtyGUI.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['grpSales.ItemIndex'].asInteger := grpSales.ItemIndex + 1;
end;

initialization
  RegisterClassOnce(TSalesPickedQtyGUI);

end.

