unit BOMTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMTreeGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainproductName: TWideStringField;
    qryMaincaption: tWideStringfield;
    qryMainPTBOMGroupedLine: TWideStringField;
    qryMainPTBOMProductionLine: TWideStringField;
    qryMainPTPQty: TFloatField;
    qryMainPQAQty: TFloatField;
    qryMainPQAactive: TWideStringField;
    qryMainPTPBOMGroupedLine: TWideStringField;
    qryMainPTPBOMProductionLine: TWideStringField;
    qryMainSaleLineId: TIntegerField;
    qryMainPQAID: TIntegerField;
    qryMainProcTreeId: TLargeintField;
    qryMainProcTreePartId: TLargeintField;
    qryMainSeqno: TLargeintField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    fiSaleID: Integer;
    fisaleLineId: Integer;
    { Private declarations }
  public
    Property SaleID     :Integer read fiSaleID     write fiSaleID;
    Property SaleLineId :Integer read fisaleLineId write fisaleLineId;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TBOMTreeGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fiSaleID:=0;
    fisaleLineId:=0;
end;

procedure TBOMTreeGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
(*  if SameText(Field.fieldname,qryMaincaption.FieldName) or
    SameText(Field.fieldname,qryMainPTBOMGroupedLine.FieldName) or
    SameText(Field.fieldname,qryMainPTBOMProductionLine.FieldName) or
    SameText(Field.fieldname,qryMainPTPQty.FieldName) then
      if qryMainProcTreeId.AsInteger =0 then aBrush.Color := clPurple;*)
  if qryMainSeqno.AsInteger =2 then begin
     ABrush.Color := clYellow;
  end else begin
    if SameText(Field.fieldname,qryMainPQAQty.FieldName) or
      SameText(Field.fieldname,qryMainPQAactive.FieldName) then
        if qryMainPQAID.AsInteger <>0 then aBrush.Color := clPurple;

    if SameText(Field.fieldname,qryMainPTPQty.FieldName) or
      SameText(Field.fieldname,qryMainPTPBOMGroupedLine.FieldName) or
      SameText(Field.fieldname,qryMainPTPBOMProductionLine.FieldName) then
      if qryMainProcTreePartId.AsInteger <> 0 then aBrush.Color := clPurple;
    end;
end;
procedure TBOMTreeGUI.RefreshQuery;
begin
  Qrymain.ParamByName('SaleID').AsInteger := SaleID;
  Qrymain.ParamByName('SalelineID').AsInteger := SAlelineId;
  inherited;
end;

initialization
  RegisterClassOnce(TBOMTreeGUI);

end.

