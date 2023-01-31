unit StockValueList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockStatusRolingList, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockValue = class(TStockStatusRoling)
    Label2: TLabel;
    btnHowTo: TDNMSpeedButton;
    btnCompare: TDNMSpeedButton;
    btnBatchBalanceSheet: TDNMSpeedButton;
    btnMatchProductlist: TDNMSpeedButton;
    procedure btnBatchBalanceSheetClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    fiSelectedOption :Integer;
    function getAssetValue: Double;
    procedure BeforeInventoryAssetVsStockStauts(Sender: TObject);
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
    Property AssetValue :Double read getAssetValue;
  end;


implementation

uses
  BAseListingForm, CommonLib, CommonFormLib, tcConst;

{$R *.dfm}

procedure TStockValue.btnBatchBalanceSheetClick(Sender: TObject);
begin
  inherited;
  chkAging.Checked := true;
  dtFrom.Date := 0;
  dtTo.Date := Date;
  chkIgnoreDates.Checked := false;
  grpFilters.ItemIndex := 2;
  SearchMOde := smFullList;

       if sender = btnBatchBalanceSheet then fiSelectedOption := 1
  else if sender = btnMatchProductlist then fiSelectedOption := 2
  else fiSelectedOption := 0;

  btnBatchBalanceSheet.Down := fiSelectedOption =1;
  btnMatchProductlist.Down := fiSelectedOption =2;

  if fiSelectedOption =1 then AddFieldtoGrid(qrymainTotalCost.FieldName) ;
  if fiSelectedOption =2 then AddFieldtoGrid(qrymainAvgTotalCost.FieldName);
  RefreshQuery;

end;

procedure TStockValue.btnCompareClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TInventoryAssetVsStockStautsGUI', BeforeInventoryAssetVsStockStauts);
//  CloseWait;
end;
procedure TStockValue.FormCreate(Sender: TObject);
begin
  HaveOnlyToDate['As On '] := true;
  fiSelectedOption := 0;
  inherited;
end;

procedure TStockValue.BeforeInventoryAssetVsStockStauts(Sender: TObject);
begin
  copyParamsto(Sender);
end;

function TStockValue.getAssetValue: Double;
begin
  REsult :=   strValue(grdMain.ColumnByName(qryMainTotalCost.fieldname).FooterValue);
end;

procedure TStockValue.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if fiSelectedOption =1 then if sametext(Field.FieldName , qrymainTotalCost.FieldName) then ABrush.color := GridColhighLightGreen;
  if fiSelectedOption =2 then if sametext(Field.FieldName , qrymainAvgTotalCost.FieldName) then ABrush.color := GridColhighLightGreen;
end;

procedure TStockValue.RefreshQuery;
begin
  inherited;
end;

initialization
  RegisterClass(TStockValue);

end.
