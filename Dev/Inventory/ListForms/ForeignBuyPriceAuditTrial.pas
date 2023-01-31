unit ForeignBuyPriceAuditTrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TForeignBuyPriceAuditTrialGUI = class(TBaseListingGUI)
    qryMainAuditdate: TDateTimeField;
    qryMainSupplier: TWideStringField;
    qryMaincurrencycode: TWideMemoField;
    qryMainuomname: TWideMemoField;
    qryMainunitId: TIntegerField;
    qryMainuommult: TFloatField;
    qryMainuomPrice: TFloatField;
    qryMainPrice: TFloatField;
    qryMainCategory: TLargeintField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiProductId: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TForeignBuyPriceAuditTrialGUI }

procedure TForeignBuyPriceAuditTrialGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
//  if qryMainCategory.asInteger = 2 then ABrush.color := clinactivecaption;
end;

procedure TForeignBuyPriceAuditTrialGUI.RefreshQuery;
begin
  Qrymain.parambyname('PartsID').asInteger := ProductId;
  inherited;

end;

procedure TForeignBuyPriceAuditTrialGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainunitId.FieldName);
  RemoveFieldfromGrid(qryMainuommult.FieldName);
  RemoveFieldfromGrid(qryMainCategory.FieldName);
end;
initialization
  RegisterClassOnce(TForeignBuyPriceAuditTrialGUI);

end.
