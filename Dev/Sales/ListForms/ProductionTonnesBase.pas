unit ProductionTonnesBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpressDetails, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductionTonnesBaseGUI = class(TBaseListExpressDetailsGUI)
    qryMainDetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainBOMProductname: TWideStringField;
    qryMainUnitOfMeasureshipped: TFloatField;
    qryMainSerialnumber: TWideStringField;
    qryMainBuilddate: TDateTimeField;
    qryMainBuildQty: TFloatField;
    qryMainWeight: TLargeintField;
    qryMainTotalWeight: TFloatField;
    qryMainDescription: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainResource: TWideStringField;
    qryMainStatus: TWideMemoField;
    qryMainproductId: TIntegerField;
    qryMainBuildstatus: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    Procedure WriteGuiPrefExtra; override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses commonlib;


{$R *.dfm}

{ TProductionTonnesBaseGUI }

procedure TProductionTonnesBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  if devmode then
    if GuiPrefs.Node.Exists('Options.SaleId') then
      Qrymain.locate('SaleId;ProductId',  varArrayof([GuiPrefs.Node['Options.SaleId'].asInteger, GuiPrefs.Node['Options.ProductID'].asInteger]) , []);

end;

procedure TProductionTonnesBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex >0 then
  if Qrymaindetails.asinteger = 1 then begin
    DoGreenhighlight(Afont,ABrush );
    Dobold(Afont,ABrush );
  end else if Qrymaindetails.asinteger = 3 then GreennLight(Afont) ;
  if Qrymaindetails.asinteger = 1 then else if sametext(field.fieldname ,qryMainSaleId.fieldname) or
          sametext(field.fieldname ,qryMainClientName.fieldname) or
          sametext(field.fieldname ,qryMainBOMProductname.fieldname) or
          sametext(field.fieldname ,qryMainDescription.fieldname) or
          sametext(field.fieldname ,qryMainUOM.fieldname) or
          sametext(field.fieldname ,qryMainResource.fieldname) or
          sametext(field.fieldname ,qryMainUnitOfMeasureshipped.fieldname) or
          sametext(field.fieldname ,qryMainStatus.fieldname) then DoHide(Field,State,Afont,ABrush );

end;

procedure TProductionTonnesBaseGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1']);
  inherited;

end;

procedure TProductionTonnesBaseGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TProductionTonnesBaseGUI.SetGridColumns;
begin
  inherited;
  if not (devmode) then begin
    RemoveFieldfromGrid(qrymaindetails.fieldname);
  end;
  RemoveFieldfromGrid(qrymainProductId.fieldname);
end;

procedure TProductionTonnesBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.SaleID'].asInteger := QrymainSaleID.asInteger;
  GuiPrefs.Node['Options.ProductID'].asInteger := QrymainProductID.asInteger;
end;

end.
