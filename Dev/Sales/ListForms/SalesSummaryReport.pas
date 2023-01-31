unit SalesSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesSummary_ReportGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainClass: TWideStringField;
    qryMainPreferredLevel: TFloatField;
    qryMainReOrderPoint: TFloatField;
    qryMainReOrderAmount: TFloatField;
    qryMainproductname: TWideStringField;
    qryMainproductprintname: TWideStringField;
    qryMainTotalQty: TFloatField;
    qryMainQtyDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiQtyType: Integer;
  Protected
    Procedure RefreshTotals;Override;
    Procedure CalcFooter;Override;
    procedure SetGridColumns; Override;
  public
    Property QtyType :Integer read fiQtyType write fiQtyType;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, LogLib;

{$R *.dfm}
procedure TSalesSummary_ReportGUI.CalcFooter;
begin
  if Qrymaindetails.asinteger <> 2 then
  inherited;
end;

procedure TSalesSummary_ReportGUI.FormCreate(Sender: TObject);
begin
  QtyType:= 0;
  inherited;
  AddCalccolumn(qryMainTotalQty.fieldname , False);
  HaveDateRangeSelection := False;
end;

procedure TSalesSummary_ReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qrymaindetails.asinteger <> 1 then begin
    if sameText(field.Fieldname, qryMainQtyDate.Fieldname)     then Afont.color := Abrush.color;
  end else begin
    if not(sameText(field.Fieldname, qryMainQtyDate.Fieldname) or
      sameText(field.Fieldname, qryMaintotalQty.Fieldname)  )   then Afont.color := Abrush.color;
  end;
end;

procedure TSalesSummary_ReportGUI.RefreshQuery;
begin
  clog(qrymain.SQL.text);
  inherited;

end;

procedure TSalesSummary_ReportGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TSalesSummary_ReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
end;

initialization
  RegisterClassOnce(TSalesSummary_ReportGUI);

end.
