unit HireItemDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireItemDetailListGUI = class(TBaseListingGUI)
    qryMainCreatedDate: TDateField;
    qryMainHireDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainBillCustomerName: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainHireUOMQty: TFloatField;
    qryMainHireFrom: TDateTimeField;
    qryMainHireTo: TDateTimeField;
    qryMainActualHireFrom: TDateTimeField;
    qryMainActualHireTo: TDateTimeField;
    qryMainStatus: TWideStringField;
    qryMainDurationName: TWideStringField;
    qryMainDurationRate: TFloatField;
    qryMainDurationQty: TFloatField;
    qryMainPriceEx: TFloatField;
    qryMainPriceInc: TFloatField;
    qryMainLineAmountEx: TFloatField;
    qryMainLineAmountInc: TFloatField;
    qryMainLineTaxCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainHireId: TIntegerField;
    qryMainAssetCode: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);override;
  private
    { Private declarations }
  protected
    procedure ApplyQueryFilter; override;
  public
    Procedure RefreshQuery;  Override;
  end;

var
  HireItemDetailListGUI: THireItemDetailListGUI;

implementation

{$R *.dfm}
uses
  MySQLConst;

procedure THireItemDetailListGUI.ApplyQueryFilter;
begin
  inherited;
  RefreshQuery;
end;

procedure THireItemDetailListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (not qryMainActualHireFrom.IsNull) and (not qryMainActualHireTo.IsNull) then begin
    if SameText(qryMainStatus.AsString,'On Hire') and (now > qryMainActualHireTo.AsDateTime) then
      AFont.Color := clRed;
  end
  else if (not qryMainHireFrom.IsNull) and (not qryMainHireTo.IsNull) then begin
    if SameText(qryMainStatus.AsString,'On Hire') and (now > qryMainHireTo.AsDateTime) then
      AFont.Color := clRed;
  end;
end;

procedure THireItemDetailListGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  qryMain.Close;
  if grpFilters.ItemIndex = 2 then
         GroupfilterString := // 'Hirestatus = ' + Quotedstr('O') +
         {' and }'(((HireTo > ActualHireTo) and (HireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (HireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+'))' +
         ' or ((HireTo < ActualHireTo) and (ActualHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (ActualHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+')))'
  else
    GroupfilterString := '';
  case grpFilters.ItemIndex of
  {
    0: qryMain.ParamByName('Status').AsString := '';
    1: qryMain.ParamByName('Status').AsString := 'O';
    2: qryMain.ParamByName('Status').AsString := 'P';
    3: qryMain.ParamByName('Status').AsString := 'A';
    4: qryMain.ParamByName('Status').AsString := 'R';
    5: qryMain.ParamByName('Status').AsString := 'N';
}
    0: qryMain.ParamByName('Status').AsString := '';
    1: qryMain.ParamByName('Status').AsString := 'O';
    2: begin
         qryMain.ParamByName('Status').AsString := 'O';
         {
         GroupfilterString := // 'Hirestatus = ' + Quotedstr('O') +
         (((HireTo > ActualHireTo) and (HireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (HireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+'))' +
         ' or ((HireTo < ActualHireTo) and (ActualHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (ActualHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+')))'
         }
       end;
    3: qryMain.ParamByName('Status').AsString := 'P';
    4: qryMain.ParamByName('Status').AsString := 'A';
    5: qryMain.ParamByName('Status').AsString := 'R';
    6: qryMain.ParamByName('Status').AsString := 'N';
  end;
  inherited;
  RefreshQuery;
end;

procedure THireItemDetailListGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDateTime := dtTo.Date;
  end;
  (*
  if grpFilters.ItemIndex = 2 then
         GroupfilterString := // 'Hirestatus = ' + Quotedstr('O') +
         {' and }'(((HireTo > ActualHireTo) and (HireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (HireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+'))' +
         ' or ((HireTo < ActualHireTo) and (ActualHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (ActualHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+')))'
  else
    GroupfilterString := '';
  case grpFilters.ItemIndex of
  {
    0: qryMain.ParamByName('Status').AsString := '';
    1: qryMain.ParamByName('Status').AsString := 'O';
    2: qryMain.ParamByName('Status').AsString := 'P';
    3: qryMain.ParamByName('Status').AsString := 'A';
    4: qryMain.ParamByName('Status').AsString := 'R';
    5: qryMain.ParamByName('Status').AsString := 'N';
}
    0: qryMain.ParamByName('Status').AsString := '';
    1: qryMain.ParamByName('Status').AsString := 'O';
    2: begin
         qryMain.ParamByName('Status').AsString := 'O';
         {
         GroupfilterString := // 'Hirestatus = ' + Quotedstr('O') +
         (((HireTo > ActualHireTo) and (HireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (HireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+'))' +
         ' or ((HireTo < ActualHireTo) and (ActualHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (ActualHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+')))'
         }
       end;
    3: qryMain.ParamByName('Status').AsString := 'P';
    4: qryMain.ParamByName('Status').AsString := 'A';
    5: qryMain.ParamByName('Status').AsString := 'R';
    6: qryMain.ParamByName('Status').AsString := 'N';
  end;
  *)
  inherited;
end;

initialization
  RegisterClass(THireItemDetailListGUI);

end.
