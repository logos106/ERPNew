unit HireListDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireListDetailsGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainHireId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainShiptoAddress: TWideStringField;
    qryMainCreatedDate: TDateField;
    qryMainclassname: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainTerms: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainHireFrom: TDateTimeField;
    qryMainHireTo: TDateTimeField;
    qryMainAmountinc: TFloatField;
    qryMainconverted: TWideStringField;
    qryMainHireStatus: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUOMQty: TFloatField;
    qryMainAssetCode: TWideStringField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, tcConst;

{$R *.dfm}

procedure THireListDetailsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenErpform('TfmHire' , 0);
end;

procedure THireListDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SwapBaseIndexFieldPriority := true;
end;

procedure THireListDetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.asInteger <> 1 then begin
    if Sametext(field.fieldname , QrymainHireId.FieldName) or
        Sametext(field.fieldname , QrymainCustomerName.FieldName) or
        Sametext(field.fieldname , QrymainShiptoAddress.FieldName) or
        Sametext(field.fieldname , QrymainCreatedDate.FieldName) or
        Sametext(field.fieldname , Qrymainclassname.FieldName) or
        Sametext(field.fieldname , QrymainNotes.FieldName) or
        Sametext(field.fieldname , QrymainTerms.FieldName) or
        Sametext(field.fieldname , QrymainemployeeName.FieldName) then begin
        Afont.color := abrush.color;
    end else if  Qrymaindetails.asInteger  =2 then begin
      ABrush.Color := GridColhighLightGreen;
    end else if  Qrymaindetails.asInteger  =3 then begin
      ABrush.Color := GridColhighLightYellow1;
    end;
  end;
  if Qrymaindetails.asInteger = 2 then begin
    if (not qryMainHireFrom.IsNull) and (not qryMainHireTo.IsNull) then begin
      if SameText(qryMainStatus.AsString,'On Hire') and (now > qryMainHireTo.AsDateTime) then
        AFont.Color := clRed;
    end;
  end;
end;

procedure THireListDetailsGUI.grpFiltersClick(Sender: TObject);
begin
       if Grpfilters.itemindex =0 then GroupfilterString := 'Details = 1'
  else if Grpfilters.itemindex =1 then GroupfilterString := 'Details = 1 or Details = 2 '
  else if Grpfilters.itemindex =2 then GroupfilterString := 'Details = 1 or Details = 3 '
  else GroupfilterString := '';
  inherited;
end;

procedure THireListDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  BaseIndexFieldNames :=  QrymainHireID.fieldname+ ' desc cis; ' +QrymainDetails.fieldname+' asc cis; ';
end;

procedure THireListDetailsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure THireListDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(QrymainHireId.fieldname);
end;
initialization
  RegisterClassOnce(THireListDetailsGUI);

end.
