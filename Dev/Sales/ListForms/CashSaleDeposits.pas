unit CashSaleDeposits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCashSaleDepositGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainPaymethod: TWideStringField;
    qryMainSalesamount: TFloatField;
    qryMainDeposited: TFloatField;
    qryMainTobeDeposited: TFloatField;
    grpOptions: TRadioGroup;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    function SalesType(fiSaleID:Integer):String;
  Protected
    Procedure SetGridColumns;override;
    procedure RefreshTotals; override;
    Procedure CalcFooter;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, FastFuncs, CommonDbLib, BusObjSaleBase, SalesConst;

{$R *.dfm}

procedure TCashSaleDepositGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.itemindex =0 then GroupFilterString := 'details =1' else GroupFilterString := '';
  if grpOptions.itemindex <> 2 then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    if grpOptions.itemindex =0 then GroupFilterString := GroupFilterString + 'Deposited <> SalesAmount'
    else GroupFilterString := GroupFilterString + 'Deposited = SalesAmount';
  end;
  inherited;
end;
procedure TCashSaleDepositGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Details');
end;

procedure TCashSaleDepositGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFilters.itemindex := 0;
  grpFiltersClick(grpFilters);
end;

procedure TCashSaleDepositGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if grpFilters.itemindex = 1 then begin
    if Qrymaindetails.asInteger = 1 then AFont.Style := AFont.Style + [fsBold];
  end;

(*  if Sysutils.SameText(Field.fieldname ,'TobeDeposited') then
    if qryMainTobeDeposited.asFloat = 0 then
        Afont.Color := ABrush.Color;*)
  (*if Qrymaindetails.asInteger = 2 then
    if Sysutils.SameText(Field.fieldname ,'TobeDeposited') then Afont.Color := ABrush.Color;*)
end;

procedure TCashSaleDepositGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qrymainTobeDeposited.asFloat := qryMainSalesamount.asFloat - qryMainDeposited.asfloat;
end;

procedure TCashSaleDepositGUI.FormCreate(Sender: TObject);
begin
  //NoDateRange := true;
  inherited;
  AddCalccolumn('SalesAmount'   , true);
  AddCalccolumn('Deposited'     , true);
  AddCalccolumn('TobeDeposited' , true);
end;

procedure TCashSaleDepositGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TCashSaleDepositGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + SalesType(qryMainSaleId.asInteger);
  case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
    stPOS,
    stPOSLayby,
    stPOSLaybyPayment,
    stPOSCashSale: SubsequentID := Chr(95) + 'POS';
  end;
  inherited;

end;

function TCashSaleDepositGUI.SalesType(fiSaleID: Integer): String;
begin
  With CommonDbLib.TempMyQuery do try
    SQL.add('select isCashSale, isRefund from tblSales where saleId = ' + IntToStr(fiSaleID));
    open;
    if fieldByname('iscashSale').asBoolean then result := 'CashSale' else result := 'Refund';
  finally
      if active then  close;
      Free;
  end;
end;

procedure TCashSaleDepositGUI.CalcFooter;
begin
  if qryMaindetails.asinteger = 1 then
    inherited;
end;

initialization
  RegisterClassOnce(TCashSaleDepositGUI);

end.
