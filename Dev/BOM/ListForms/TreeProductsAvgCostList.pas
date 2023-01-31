unit TreeProductsAvgCostList;

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
  TTreeProductsAvgCostListGUI = class(TBaseListingGUI)
    qryMainProcTreeId: TIntegerField;
    qryMainpartname: TWideStringField;
    qryMainPartsId: TIntegerField;
    qryMaincaption: TWideStringField;
    qryMainTotalQty: TFloatField;
    qryMainQuantity: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainCOSTex: TFloatField;
    qryMainCostInc: TFloatField;
    qryMainTotalCostfor1onAvg: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    fiTreeRootId: Integer;
  Protected
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure SetGridColumns; Override;
  public
    Property TreeRootId :Integer read fiTreeRootId write fiTreeRootId;
    Procedure RefreshQuery;Override;
    Class Procedure TreeProductsAvgCostforaTree(const  aTreeRootId:Integer);
  end;


implementation

uses ComCtrls,frmPartsFrm, CommonLib;

{$R *.dfm}

procedure TTreeProductsAvgCostListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is TfrmParts then begin
    TfrmParts(Popupform).pageControl.ActivePage := TTabSheet(TfrmParts(Popupform).Main);
    Setcontrolfocus(TfrmParts(Popupform).edtAvgcost);
  end;

end;

procedure TTreeProductsAvgCostListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TTreeProductsAvgCostListGUI.RefreshQuery;
begin
  Qrymain.parambyname('treerootId').asInteger := TreeRootId;
  inherited;

end;

procedure TTreeProductsAvgCostListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMainProcTreeId.fieldname);

end;

class procedure TTreeProductsAvgCostListGUI.TreeProductsAvgCostforaTree(const aTreeRootId: Integer);
var
  form :TTreeProductsAvgCostListGUI;
begin
  form := TTreeProductsAvgCostListGUI(getcomponentbyclassname('TTreeProductsAvgCostListGUI'));
  if not assigned(form) then exit;
  try
    form.TreeRootId := aTreeRootId;
    form.Showmodal;
  finally
    Freeandnil(Form);
  end;
end;
initialization
  RegisterClassOnce(TTreeProductsAvgCostListGUI);

end.
