unit StockAdjustAccountList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockAdjustAccountListGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainAccountType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainStockAdjustEntryID: TIntegerField;
    qryMainCreationDate: TDateField;
    qryMainAdjustmentdate: TDateField;
    qryMainNotes: TWideMemoField;
    qryMainEmployee: TWideStringField;
    qryMainProcessed: TWideStringField;
    lblMsg: TLabel;
    qryMainAdjusttype: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}

{ TStockAdjustAccountListGUI }

procedure TStockAdjustAccountListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblMsg.caption := 'Stock Adjustments Header Should Always Use Expense Type Accounts' + NL +'and SHOULD NOT be an Asset Type Account.';
end;

procedure TStockAdjustAccountListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not (sametext(qrymainaccounttype.asString , 'EXP')) then
    ABrush.color := GridColhighLightRed;
end;

procedure TStockAdjustAccountListGUI.grdMainDblClick(Sender: TObject);
begin
  if (Qrymaindetails.asInteger =1) and (grpfilters.itemindex =0) then  begin
    grpfilters.itemindex := 1;
    exit;
  end;
  SubsequentID := Chr(95) + qryMainAdjusttype.AsString;
  inherited;

end;

procedure TStockAdjustAccountListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1'] , true);
  inherited;
end;

procedure TStockAdjustAccountListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TStockAdjustAccountListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainDetails.fieldname);
  RemoveFieldfromGrid(qryMainAdjusttype.fieldname);
end;

initialization
  RegisterClassOnce(TStockAdjustAccountListGUI);

end.
