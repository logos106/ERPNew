unit ProductQtyinProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TProductQtyinProgressGUI = class(TBaseListingGUI)
    qryMainPartsId: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainExpiryDate: TWideStringField;
    qryMainBinlocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainUOMQty: TFloatField;
    qryMainQty: TFloatField;
    qryMainInstockUOMQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainActStockwithManUOMQty: TFloatField;
    qryMainActStockwithManQty: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    cleanSelectedProductID:Integer;
    cleanfilteroption:Integer;
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ProductQtyLib, LogLib;

{$R *.dfm}
{ TProductQtyinProgressGUI }

procedure TProductQtyinProgressGUI.FormCreate(Sender: TObject);
begin
  cleanSelectedProductID := -1;
  cleanfilteroption := -1;
  MakeQrymain;
  inherited;
  SearchMode:= smFullList;
  SelectionOption := soProduct;
  HaveDateRangeSelection := False;
  dtTo.Visible := TRue;
  lblTo.Visible := TRue;
  lblTo.Caption := 'As of ';
end;

procedure TProductQtyinProgressGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
RefreshQuery;
end;

procedure TProductQtyinProgressGUI.MakeQrymain;
begin
  if (trim(Qrymain.sql.text) ='') or (cleanSelectedProductID <> SelectedProductID) or (cleanfilteroption <> grpfilters.itemindex) then begin
    closedb(Qrymain);
    if grpfilters.itemindex = 0 then
         Qrymain.SQL.Text :=  StockQty(False, SelectedProductId,0,tSummary        , filterdateto , True , True )
    else Qrymain.SQL.Text :=  StockQty(False, SelectedProductId,0,tDetailswithSno , filterdateto , True , True );
    Qrymain.SQL.Text :=replacestr(Qrymain.SQL.Text  , 'order by ' ,  ' having round(abs(ifnull(ActStockwithManQty,0) - ifnull(InstockQty,0)),2) >0.05  order by  ');
    Qrymain.SQL.Text :=replacestr(Qrymain.SQL.Text  , 'union all ' ,  ' having round(abs(ifnull(ActStockwithManQty,0) - ifnull(InstockQty,0)),2) >0.05  union all ');
    cleanSelectedProductID :=  SelectedProductID;
    cleanfilteroption :=  grpfilters.itemindex;
    clog(Qrymain.SQL.Text);
  end;
end;

procedure TProductQtyinProgressGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;

end;

procedure TProductQtyinProgressGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainPartsId.fieldname);
    RemoveFieldfromGrid(qryMainDepartmentID.fieldname);
    RemoveFieldfromGrid(qryMainUOMID.fieldname);
end;

initialization
  RegisterClassOnce(TProductQtyinProgressGUI);

end.
