unit SalesDispatches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TSalesDispatchesGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainDispatchID: TIntegerField;
    qryMainDispatchdate: TDateTimeField;
    qryMainemployeeName: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainBatchno: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainQty: TFloatField;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonFormLib, CommonLib;

{$R *.dfm}

procedure TSalesDispatchesGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmSalesDispatch' , 0);
end;

procedure TSalesDispatchesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BaseIndexFieldNames := QuotedStr('DispatchID') + ' DESC CIS';
end;

procedure TSalesDispatchesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.AsInteger =1 then begin
    if sametext(field.FieldName , QrymainDispatchdate.FieldName) or
       sametext(field.FieldName , QrymainemployeeName.FieldName) then
    else Afont.Color := Abrush.Color;
  end else begin
    if sametext(field.FieldName , QrymainDispatchdate.FieldName) or
       sametext(field.FieldName , QrymainemployeeName.FieldName) then
      Afont.Color := Abrush.Color;
  end;
end;

procedure TSalesDispatchesGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TSalesDispatchesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(QrymaindispatchID.fieldname);
end;

initialization
  RegisterClassOnce(TSalesDispatchesGUI);

end.
