unit RelatedProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup,
  wwradiogroup;

type
  TRelatedProductsGUI = class(TBaseListingGUI)
    qryMainPARTNAME: TWideStringField;
    qryMainRelatedID: TIntegerField;
    qryMainQty: TFloatField;
    qryMainHideRelated: TWideStringField;
    qryMainIncurAmount: TFloatField;
    qryMainExtraQty: TFloatField;
    qryMainUseIncur: TWideStringField;
    qryMainIncurAfterTax: TWideStringField;
    qryMainrelatedProduct: TWideStringField;
    qryMainParentID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainParentQty: TFloatField;
    qryMainCanDelete: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fbSelectCannotDeleteProducts: Boolean;
    fbSelectAllProducts: Boolean;
  Protected
    Procedure SetGridColumns;Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Property SelectCannotDeleteProducts  :Boolean read fbSelectCannotDeleteProducts  write fbSelectCannotDeleteProducts ;
    Property SelectAllProducts  :Boolean read fbSelectAllProducts  write fbSelectAllProducts ;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TRelatedProductsGUI }

procedure TRelatedProductsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbSelectCannotDeleteProducts := False;
  fbSelectAllProducts := False;
end;

procedure TRelatedProductsGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
begin
  inherited;
  if IterateProcNo = 1 then begin
    if SelectCannotDeleteProducts then
      if QrymainCanDelete.asBoolean =False then
        grdmain.selectrecord;
  end;
end;

procedure TRelatedProductsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if SelectAllProducts then begin
    grdmain.selectall;
  end else if SelectCannotDeleteProducts then begin
    IterateProcNo := 1;
    IterateRecords;
  end;
end;

procedure TRelatedProductsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ParentId');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('RelatedId');
  RemoveFieldfromGrid('PartsId');
end;

initialization
  RegisterClassOnce(TRelatedProductsGUI);

end.
