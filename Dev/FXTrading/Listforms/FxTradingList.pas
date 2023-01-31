unit FxTradingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TFxTradingListGUI = class(TBaseListingGUI)
    qryMainTransDate: TDateTimeField;
    qryMainamount: TFloatField;
    qryMainbuycurrencyCode: TWideStringField;
    qryMainemployeename: TWideStringField;
    qryMainCurRate: TFloatField;
    qryMaintoday: TDateField;
    qryMainValuetoday: TFloatField;
    qryMainbuyRate: TFloatField;
    qryMainID: TIntegerField;
    qryMainCurrencySymbol: TWideStringField;
    qryMainpurchaseamount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdMainDblClick(Sender: TObject); override;
  private
  Protected
    procedure SetGridColumns; Override;

  public

  end;


implementation

uses CommonLib, AppEnvironment, CommonFormLib ;

{$R *.dfm}
procedure TFxTradingListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  openERPForm('TfmFxTrading' , QrymainId.asInteger, nil);
end;

procedure TFxTradingListGUI.FormCreate(Sender: TObject);
begin
  qryMainpurchaseamount.displaylabel := 'Amount in' + appenv.RegionalOptions.ForeignExDefault ;
  qryMainValuetoday.displaylabel     := 'Amount in ' + appenv.RegionalOptions.ForeignExDefault;
  NonSearchMode := True;
  inherited;
end;

procedure TFxTradingListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Sametext(field.FieldName , QrymainTransDate.FieldName) or
     Sametext(field.FieldName , QrymainbuyRate.FieldName) or
     Sametext(field.FieldName , Qrymainpurchaseamount.FieldName) then ABrush.Color := $00CCCCFF;

  if Sametext(field.FieldName , Qrymaintoday.FieldName) or
     Sametext(field.FieldName , QrymainCurRate.FieldName) or
     Sametext(field.FieldName , QrymainValuetoday.FieldName) then ABrush.color := $00A4FFA4;
    end;

procedure TFxTradingListGUI.grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if Sametext(AFieldName , QrymainTransDate.FieldName) or
     Sametext(AFieldName , QrymainbuyRate.FieldName) or
     Sametext(AFieldName , Qrymainpurchaseamount.FieldName) then ABrush.Color := $00CCCCFF;

  if Sametext(AFieldName , Qrymaintoday.FieldName) or
     Sametext(AFieldName , QrymainCurRate.FieldName) or
     Sametext(AFieldName , QrymainValuetoday.FieldName) then ABrush.color := $00A4FFA4;

end;

procedure TFxTradingListGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  cmdNew.Click;
end;

procedure TFxTradingListGUI.qryMainCalcFields(DataSet: TDataSet);

function currate:Double;
begin
  result:= qryMainCurRate.asfloat;
  if result= 0 then result :=qryMainbuyRate.asFloat;
  if result = 0 then result := 1;
end;
begin
  inherited;
  qryMainValuetoday.asFloat := qryMainamount.asfloat * currate;
end;

procedure TFxTradingListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
  RemoveFieldfromGrid(qryMainCurrencySymbol.FieldName);
end;

initialization
  RegisterClassOnce(TFxTradingListGUI);

end.

