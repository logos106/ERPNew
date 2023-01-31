unit WorkOrderTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TWorkOrderTimesGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMainsaleDate: TDateField;
    qryMainproductname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainTree: TWideStringField;
    qryMainProcessStep: TWideStringField;
    qryMainDuration: TWideMemoField;
    qryMainBundles: TWideStringField;
    qryMainCouponsPerBundle: TFloatField;
    qryMainTotalcoupons: TFloatField;
    qryMainQtyPercoupon: TWideStringField;
    qryMainCouponNo: TWideStringField;
    qryMainCoupons: TWideStringField;
    qryMainTimesheeetEntryDate: TDateTimeField;
    qryMainTimesheetDate: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMaintimespent: TWideMemoField;
    qryMainDetails: TLargeintField;
    qryMainHourlyLabourRate: TFloatField;
    qryMainHourlyOverheadRate: TFloatField;
    qryMainBarCode: TWideStringField;
    qryMaintimespentinsec: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
    Procedure  CalcnShowFooter;Override;
    Procedure CalcFooter;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

procedure TWorkOrderTimesGUI.CalcFooter;
begin
  if (GrpFilters.ItemIndex =0) or (Qrymaindetails.asInteger >1) then
    inherited;
end;

procedure TWorkOrderTimesGUI.CalcnShowFooter;
begin
    inherited;
end;

procedure TWorkOrderTimesGUI.FormCreate(Sender: TObject);
begin
  DateRangeSelectionHint := 'Report is filterd on Sales Date';
  inherited;
  DisableSortoncolumtitleclick:= True;
  AddCalcColumn(qryMaintimespentinsec.fieldname, False);
end;
procedure TWorkOrderTimesGUI.FormShow(Sender: TObject);
begin
  inherited;
  if GrpFilters.ItemIndex <0 then GrpFilters.ItemIndex := 0;
  GrpFiltersClick(GrpFilters);
end;

procedure TWorkOrderTimesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (GrpFilters.ItemIndex <>0) and (Qrymaindetails.asInteger =1 ) then Afont.style := Afont.style  +[fsBold];
  if Qrymaindetails.asInteger in [ 2,3] then
    if sametext(field.fieldname , qryMainsaleId.Fieldname ) or
       sametext(field.fieldname , qryMainsaleDate.Fieldname ) or
       sametext(field.fieldname , qryMainproductname.Fieldname ) or
       sametext(field.fieldname , qryMainUOM.Fieldname ) or
       sametext(field.fieldname , qryMainShipped.Fieldname ) or
       sametext(field.fieldname , qryMainTree.Fieldname ) or
       sametext(field.fieldname , qryMainProcessStep.Fieldname ) or
       sametext(field.fieldname , qryMainBundles.Fieldname ) or
       sametext(field.fieldname , qryMainCouponsPerBundle.Fieldname ) or
       sametext(field.fieldname , qryMainTotalcoupons.Fieldname ) or
       sametext(field.fieldname , qryMainQtyPercoupon.Fieldname ) or
       sametext(field.fieldname , qryMainCouponNo.Fieldname ) or
       sametext(field.fieldname , qryMainHourlyLabourRate.Fieldname ) or
       sametext(field.fieldname , qryMainHourlyOverheadRate.Fieldname ) or
       sametext(field.fieldname , qryMainCoupons.Fieldname ) then
        AFont.color := ABrush.color;

end;

procedure TWorkOrderTimesGUI.grpFiltersClick(Sender: TObject);
begin
  if not isformshown then begin
      if not(classnameis('TWorkOrderTimesByEmployeeGUI')) and (GrpFilters.ItemIndex = 3) then GrpFilters.ItemIndex := 0
    else if (classnameis('TWorkOrderTimesByEmployeeGUI')) and (GrpFilters.ItemIndex < 3) then GrpFilters.ItemIndex := 3;
  end;
  if not(classnameis('TWorkOrderTimesByEmployeeGUI')) and (GrpFilters.ItemIndex = 3) then begin
    OpenERpListForm('TWorkOrderTimesByEmployeeGUI', copyParamsto);
    Self.close;
  end else if (classnameis('TWorkOrderTimesByEmployeeGUI')) and (GrpFilters.ItemIndex < 3) then begin
    OpenERpListForm('TWorkOrderTimesGUI', copyParamsto);
    Self.close;
  end else if GrpFilters.ItemIndex = 0 then groupfilterstring :='Details =1'
      else if GrpFilters.ItemIndex = 1 then groupfilterstring :='Details =1 or Details =2 '
      else if GrpFilters.ItemIndex = 2 then groupfilterstring :='Details =1 or Details =3 '
      else if GrpFilters.ItemIndex = 3 then groupfilterstring :='Details =4 '
      else Exit;
  inherited;
end;

procedure TWorkOrderTimesGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TWorkOrderTimesGUI.RefreshTotals;
var
  fdTotalSecs:Double;
begin
  inherited;
  CalcnshowFooter;
  try
    fdTotalSecs:= Fieldtotal(qryMaintimespentinsec.fieldname);
    grdMain.ColumnByName(qryMaintimespent.fieldname).FooterValue := SecondsToTime(trunc(fdTotalSecs));
  Except
    // kill the exception
  end;
end;

procedure TWorkOrderTimesGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qrymaindetails.fieldname);
   RemoveFieldfromGrid(qrymainbarcode.fieldname);
   RemoveFieldfromGrid(qryMaintimespentinsec.fieldname);
end;

initialization
  RegisterClassOnce(TWorkOrderTimesGUI);

end.
