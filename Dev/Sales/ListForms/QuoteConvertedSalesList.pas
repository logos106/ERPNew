unit QuoteConvertedSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesConvertedtoList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseListingForm;

type
  TQuoteConvertedSalesListGUI = class(TsalesConvertedtoListGUI)
    qryMainconverted: TWideStringField;
    qryMainSalesOrderglobalref: TWideStringField;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;

  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TQuoteConvertedSalesListGUI }

procedure TQuoteConvertedSalesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Sales Converted from Quote # ' +inttostr(ConvertingFromId);
end;

procedure TQuoteConvertedSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  if (SameText(ActiveFieldName,'Globalref') or SameText(ActiveFieldName , 'SaleID')) and (Qrymainconverted.asBoolean) then
    if Qrymain.Locate('SalesorderGlobalref' , Qrymainglobalref.asString , []) then exit;
  inherited;
end;


procedure TQuoteConvertedSalesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Salesorderglobalref');
end;

initialization
  RegisterClassOnce(TQuoteConvertedSalesListGUI);

end.

