unit frmSalesInventoryVerify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmInventoryVerify, DB, ActnList, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, Grids, Wwdbigrd,
  BusObjSmartOrder, Wwdbgrid, Shader, DNMPanel, DNMSpeedButton, StdCtrls;

type
  TfrmSalesInvVerifyGUI = class(TfmInventoryVerify)
  private
  Protected
    Function TransTableSQL:String; override;
    Function TransLineIDfieldName:String; override;
    Function TransLineQtyfieldName:String; override;
    Procedure InitProductinSOLine(const SOLine :TsmartOrderLine);Override;
    Function LineHasTree:Boolean; override;
  public
    //property SourceSalesForm: TBaseSaleGUI read frmSourceSaleForm write frmSourceSaleForm;
  end;

implementation

uses ProductQtyLib, tcConst, CommonDbLib, CommonLib, ProcessDataUtils;

{$R *.dfm}
{ TfmSalesInventoryVerify }


{ TfrmSalesInvVerifyGUI }

procedure TfrmSalesInvVerifyGUI.InitProductinSOLine(const SOLine: TsmartOrderLine);
begin
  inherited;
  SOLine.PARTSNAME      := TransLineDataset.FieldByName('ProductName').AsString;
  SOLine.UnitofMeasure  := TransLineDataset.FieldByName('UnitOfMeasureSaleLines').AsString;

end;

function TfrmSalesInvVerifyGUI.LineHasTree: Boolean;
begin
  REsult := TreeRootIdForSaleLineId(QrymainTransLineID.asInteger , TERPConnection(TransLineDataset.Connection))>0
end;

function TfrmSalesInvVerifyGUI.TransLineIDfieldName: String;
begin
  Result := 'SL.SaleLineID';
end;

function TfrmSalesInvVerifyGUI.TransLineQtyfieldName: String;
begin
  REsult := 'SL.UnitOfMeasureQtySold ';
end;

function TfrmSalesInvVerifyGUI.TransTableSQL: String;
begin
  Result := ' INNER JOIN tblSaleslines SL on SL.ProductId = P.PartsId and SL.SaleId =  ' +inttoStr(TransLineDataset.FieldByName('SaleID').AsInteger);
end;

initialization
  RegisterClassOnce(TfrmSalesInvVerifyGUI);

end.

