unit RAPProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox;

type
  TRapProductListGUI = class(TBaseListingGUI)
    qryMainDisplayCat: TLargeintField;
    qryMainCategoryID: TIntegerField;
    qryMainItemNo: TStringField;
    qryMainDescription: TStringField;
    qryMainRapProductID: TLargeintField;
    qryMainProductID: TLargeintField;
    qryMainPriorApprovalRequired: TStringField;
    qryMainPriorApprovalQtyLimit: TFloatField;
    qryMainPriorApprovalAmtLimit: TFloatField;
    qryMainGST: TStringField;
    qryMainSpecialConsitions: TMemoField;
    qryMainActive: TStringField;
    qryMainPartNAme: TStringField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);     override;
  private
    { Private declarations }
  Protected
    Procedure RefreshQuery; Override;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,CommonLib, frmRAPProducts, BaseInputForm;

{$R *.dfm}
Procedure TRapProductListGUI.REfreshQuery;
begin
        DonotChangeGridLabels := True;
        Inherited;
end;
procedure TRapProductListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex       = 0 then GroupFilterString := 'Active = "T"'
  else if grpFilters.ItemIndex  = 1 then GroupFilterString := 'Active = "F"'
  else GroupFilterString := '';

  inherited;
end;

procedure TRapProductListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if Qrymain.fieldByname('DisplayCat').asInteger = 1 then begin
        AFont.Style := AFont.Style + [fsBold];
        if  Highlight then
            AFont.Color := $A0A0FF
        else
            AFont.Color := clMaroon;
        if (FastFuncs.SameText(Field.Fieldname , 'ItemNo')) or (FastFuncs.SameText(Field.Fieldname , 'Description')) then
        else Afont.Color := ABrush.Color;
    end;
    if (FastFuncs.SameText(Field.Fieldname , 'PriorApprovalAmtLimit')) or
        (FastFuncs.SameText(Field.Fieldname , 'PriorApprovalQtyLimit')) then
        if Field.Value = 0 then Afont.Color := ABrush.Color;

end;

procedure TRapProductListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRAPProducts');
  if Assigned(Form) then begin
    with TfmRAPProducts(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRapProductListGUI.FormCreate(Sender: TObject);
begin
  NoDateRange := true;
  inherited;
  LabelGridFromFieldNames := False;

end;

procedure TRapProductListGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainDisplayCat.asInteger = 1 then exit;
  inherited;

end;

initialization
  RegisterClassOnce(TRapProductListGUI);

end.
