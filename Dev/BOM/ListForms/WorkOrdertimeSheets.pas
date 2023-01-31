unit WorkOrdertimeSheets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TWorkOrdertimeSheetsGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainSaleDocNumber: TWideStringField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleShipDate: TDateField;
    qryMainLineProductName: TWideStringField;
    qryMainLineProductDescription: TWideStringField;
    qryMainLineQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainResourceHourlyLabourRate: TFloatField;
    qryMainBundleQty: TFloatField;
    qryMainCouponsPerBundle: TFloatField;
    qryMainRAtePercoupon: TFloatField;
    qryMainQtyPerCoupon: TFloatField;
    qryMainLineShipDate: TDateTimeField;
    qryMainStatus: TWideStringField;
    qryMainTSID: TIntegerField;
    qryMainTimesheetDate: TDateTimeField;
    qryMainHours: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainHourlyRate: TFloatField;
    qryMainTotal: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainREsource: TWideStringField;
    qryMainProcessstep: TWideStringField;
    qryMaindetails: TLargeintField;
    qryMainsaleLineId: TIntegerField;
    qryMainproctreeId: TIntegerField;
    qryMainSequenceDown: TIntegerField;
    qryMaincaption: TWideStringField;
    qryMainCaptionint: TWideMemoField;
    qryMainTimeTaken: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals; Override;
    procedure CalcnShowFooter; Override;
    Procedure CalcFooter;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TWorkOrdertimeSheetsGUI }

procedure TWorkOrdertimeSheetsGUI.CalcFooter;
begin
  if Qrymaindetails.asinteger <=1 then exit;
  inherited;

end;

procedure TWorkOrdertimeSheetsGUI.CalcnShowFooter;
begin
  inherited;
  grdMain.ColumnByName(qrymainTimeTaken.fieldname).FooterValue :=  SecondsToTime(trunc(FooterCalcfields[0].total*60*60), true);
end;

procedure TWorkOrdertimeSheetsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  AddCalccolumn(Qrymainhours.fieldname, False);
  AddCalccolumn(QrymainTotal.fieldname, TRue);
end;

procedure TWorkOrdertimeSheetsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.asinteger = 1 then begin
    if  sametext(Field.Fieldname ,QrymainSaleId.fieldname                   ) or
        sametext(Field.Fieldname ,QrymainSaleDocNumber.fieldname            ) or
        sametext(Field.Fieldname ,QrymainSaleCustomerName.fieldname         ) or
        sametext(Field.Fieldname ,QrymainSaleShipDate.fieldname             ) or
        sametext(Field.Fieldname ,QrymainsaleLineId.fieldname               ) or
        sametext(Field.Fieldname ,QrymainLineProductName.fieldname          ) or
        sametext(Field.Fieldname ,QrymainLineProductDescription.fieldname   ) or
        sametext(Field.Fieldname ,QrymainLineQty.fieldname                  ) or
        sametext(Field.Fieldname ,QrymainUOM.fieldname                      ) or
        sametext(Field.Fieldname ,QrymainproctreeId.fieldname               ) or
        sametext(Field.Fieldname ,QrymainSequenceDown .fieldname            ) or
        sametext(Field.Fieldname ,Qrymaincaption.fieldname                  ) or
        sametext(Field.Fieldname ,QrymainCaptionint.fieldname               ) or
        sametext(Field.Fieldname ,QrymainResourceHourlyLabourRate.fieldname ) or
        sametext(Field.Fieldname ,QrymainBundleQty.fieldname                ) or
        sametext(Field.Fieldname ,QrymainCouponsPerBundle.fieldname         ) or
        sametext(Field.Fieldname ,QrymainRAtePercoupon.fieldname            ) or
        sametext(Field.Fieldname ,QrymainQtyPerCoupon.fieldname             ) or
        sametext(Field.Fieldname ,QrymainLineShipDate.fieldname             ) or
        sametext(Field.Fieldname ,QrymainREsource.fieldname                 ) or
        sametext(Field.Fieldname ,QrymainStatus.fieldname                   ) or
        sametext(Field.Fieldname ,qryMainClassName.fieldname                ) or
        sametext(Field.Fieldname ,qryMainTimeTaken.fieldname                ) or
        sametext(Field.Fieldname ,QrymainProcessstep.fieldname)  then begin
          AFont.style := font.style  +[fsBold];
        end else begin
          AFont.color := ABrush.Color;
        end;
  end else begin
    if  sametext(Field.Fieldname ,QrymainSaleId.fieldname                   ) or
        sametext(Field.Fieldname ,QrymainSaleDocNumber.fieldname            ) or
        sametext(Field.Fieldname ,QrymainSaleCustomerName.fieldname         ) or
        sametext(Field.Fieldname ,QrymainSaleShipDate.fieldname             ) or
        sametext(Field.Fieldname ,QrymainsaleLineId.fieldname               ) or
        sametext(Field.Fieldname ,QrymainLineProductName.fieldname          ) or
        sametext(Field.Fieldname ,QrymainLineProductDescription.fieldname   ) or
        sametext(Field.Fieldname ,QrymainLineQty.fieldname                  ) or
        sametext(Field.Fieldname ,QrymainUOM.fieldname                      ) or
        sametext(Field.Fieldname ,QrymainproctreeId.fieldname               ) or
        sametext(Field.Fieldname ,QrymainSequenceDown .fieldname            ) or
        sametext(Field.Fieldname ,Qrymaincaption.fieldname                  ) or
        sametext(Field.Fieldname ,QrymainCaptionint.fieldname               ) or
        sametext(Field.Fieldname ,QrymainResourceHourlyLabourRate.fieldname ) or
        sametext(Field.Fieldname ,QrymainBundleQty.fieldname                ) or
        sametext(Field.Fieldname ,QrymainCouponsPerBundle.fieldname         ) or
        sametext(Field.Fieldname ,QrymainRAtePercoupon.fieldname            ) or
        sametext(Field.Fieldname ,QrymainQtyPerCoupon.fieldname             ) or
        sametext(Field.Fieldname ,QrymainLineShipDate.fieldname             ) or
        sametext(Field.Fieldname ,QrymainREsource.fieldname                 ) or
        sametext(Field.Fieldname ,QrymainStatus.fieldname                   ) or
        sametext(Field.Fieldname ,QrymainProcessstep.fieldname)  then   begin
          AFont.color := ABrush.Color;
        end;

  end;
end;

procedure TWorkOrdertimeSheetsGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1'], true);
  inherited;
end;

procedure TWorkOrdertimeSheetsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TWorkOrdertimeSheetsGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TWorkOrdertimeSheetsGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainTSID.Fieldname);
    RemoveFieldfromGrid(qryMainsaleLineId.Fieldname);
    RemoveFieldfromGrid(qryMainproctreeId.Fieldname);
    RemoveFieldfromGrid(qryMainSequenceDown.Fieldname);
    RemoveFieldfromGrid(Qrymaindetails.Fieldname);
    RemoveFieldfromGrid(Qrymainhours.Fieldname);
end;
initialization
  RegisterClassOnce(TWorkOrdertimeSheetsGUI);

end.
