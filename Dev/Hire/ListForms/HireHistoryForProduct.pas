unit HireHistoryForProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireHistoryForProductGUI = class(TBaseListingGUI)
    lblSubtitle: TLabel;
    qryMainHireID: TIntegerField;
    qryMainHireLineID: TIntegerField;
    qryMainHireDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainShiptoAddress: TWideStringField;
    qryMainBillToAddress: TWideStringField;
    qryMainItemName: TWideStringField;
    qryMainHireFrom: TDateTimeField;
    qryMainHireFromTime: TWideStringField;
    qryMainHireTo: TDateTimeField;
    qryMainHiretoTime: TWideStringField;
    qryMainActualHireFrom: TDateTimeField;
    qryMainActualHireFromTime: TWideStringField;
    qryMainActualHireTo: TDateTimeField;
    qryMainActualHiretoTime: TWideStringField;
    qryMainHireOut: TDateTimeField;
    qryMainHireIn: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fiAssetId: Integer;
    fdStatusDateAsOn: TDateTime;
    fiStatusDateId :Integer;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetGridColumns; override;
  public
    Property AssetId :Integer read fiAssetId write fiAssetId;
    Property StatusDateAsOn: TDateTime read fdStatusDateAsOn write fdStatusDateAsOn;
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, tcConst, tcDataUtils, BusObjFixedAsset;

{$R *.dfm}
procedure THireHistoryForProductGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AssetId := 0;
  StatusDateAsOn := 0;
  HaveDateRangeSelection := False;
end;

procedure THireHistoryForProductGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if fiStatusDateId = qryMainHireLineID.AsInteger then begin
    ABrush.Color := GridColhighLightGreen;
  end;
end;

procedure THireHistoryForProductGUI.IterateselectedRecordsCallback(
  var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateProcno =1 then begin
    if (qryMainHireIn.AsDateTime <= fdStatusDateAsOn) or
      (qryMainHireOut.AsDateTime <= fdStatusDateAsOn) then begin
        fiStatusDateId :=  qryMainHireLineID.AsInteger;
        Abort := True;
      end;
  end;
end;

procedure THireHistoryForProductGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  fiStatusDateId:= 0;
  if StatusDateAsOn >0 then begin
    IterateProcno := 1;
    IterateRecords(True);
  end;
end;

procedure THireHistoryForProductGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
(*    qryMaincHireFrom.asDateTime       := qryMainHireFrom.AsDateTime      + qryMainHireFromTime.AsDateTime      ;
    qryMaincHireto.asDateTime         := qryMainHireto.AsDateTime        + qryMainHiretoTime.AsDateTime        ;
    qryMaincActualHireFrom.asDateTime := qryMainActualHireFrom.AsDateTime+ qryMainActualHireFromtime.AsDateTime;
    qryMaincActualHireto.asDateTime   := qryMainActualHireto.AsDateTime  + qryMainActualHiretoTime.AsDateTime  ;*)
end;

procedure THireHistoryForProductGUI.RefreshQuery;
var
  s:String;
begin
  Qrymain.ParamByName('AssetId').AsInteger := AssetId;
  inherited;
  lblSubtitle.caption := 'Hire Product History ';
  s:= '';
  if AssetId <> 0 then begin
    s:= TFixedAssets.AssetNameForId(AssetId);
    if s<> '' then begin
      lblSubtitle.caption := lblSubtitle.caption + ' for Equipment :' +Quotedstr(s);
    end;

    if (qryMainHireOut.asDatetime <= StatusDateAsOn) and (qryMainHireIn.asDateTime >= StatusDateAsOn) then
      lblSubtitle.caption := lblSubtitle.caption + ' - Unavailable as on : '+ Formatdatetime(FormatSettings.ShortDateFormat +' hh:nn am/pm' , StatusDateAsOn)+'  '
    else if ((qryMainHireOut.asDatetime > StatusDateAsOn) and   (qryMainHireIn.asDateTime > StatusDateAsOn)) or
            ((qryMainHireOut.asDatetime < StatusDateAsOn) and   (qryMainHireIn.asDateTime < StatusDateAsOn))then
      lblSubtitle.caption := lblSubtitle.caption + ' - Available as on : '+ Formatdatetime(FormatSettings.ShortDateFormat  +' hh:nn am/pm', StatusDateAsOn)+'  ';
  end;
end;

procedure THireHistoryForProductGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainHireId.fieldname);
  RemoveFieldfromGrid(qryMainHireLineId.fieldname);
  if not devmode then begin
    RemoveFieldfromGrid(qryMainHireFromTime.fieldname);
    RemoveFieldfromGrid(qryMainHiretoTime.fieldname);
    RemoveFieldfromGrid(qryMainActualHireFromTime.fieldname);
    RemoveFieldfromGrid(qryMainActualHiretoTime.fieldname);
    RemoveFieldfromGrid(qryMainHireFrom.fieldname);
    RemoveFieldfromGrid(qryMainHireTo.fieldname);
    RemoveFieldfromGrid(qryMainActualHireFrom.fieldname);
    RemoveFieldfromGrid(qryMainActualHireTo.fieldname);
  end;
end;

initialization
  RegisterClassOnce(THireHistoryForProductGUI);

end.
