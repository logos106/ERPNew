unit TranstotalMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TTranstotalMismatchGUI = class(TBaseListingGUI)
    qryMaincategory: TWideStringField;
    qryMainID: TIntegerField;
    qryMainlineID: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainunitex: TFloatField;
    qryMainunitinc: TFloatField;
    qryMaintotalex: TFloatField;
    qryMaintotalinc: TFloatField;
    qryMainshipped: TFloatField;
    procedure grpFiltersClick(Sender: TObject); override;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TTranstotalMismatchGUI.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
  s:= 'Total Amount Mismatch';
  case grpFilters.ItemIndex of
    0:begin GroupFilterString := 'category = '+quotedstr('PO')          ; TitleLabel.caption := 'PO - '         + s;end;
    1:begin GroupFilterString := 'category = '+quotedstr('Invoice')     ; TitleLabel.caption := 'Invoice - '    + s;end;
    2:begin GroupFilterString := 'category = '+quotedstr('Quote')       ; TitleLabel.caption := 'Quote - '      + s;end;
    3:begin GroupFilterString := 'category = '+quotedstr('CashSale')    ; TitleLabel.caption := 'Cash Sale - '  + s;end;
    4:begin GroupFilterString := 'category = '+quotedstr('refund')      ; TitleLabel.caption := 'Refund - '     + s;end;
    5:begin GroupFilterString := 'category = '+quotedstr('Sales order') ; TitleLabel.caption := 'Sales Order - '+ s;end;
    else exit;
  end;
  inherited;
end;

procedure TTranstotalMismatchGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Category');
end;

Initialization
  RegisterClassOnce(TTranstotalMismatchGUI);

end.

