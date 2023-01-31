unit RewardPoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TRewardPointsGUI = class(TBaseListingGUI)
    qryMainAvailablePoints: TFloatField;
    qryMainAvailablePointValue: TFloatField;
    qryMainPointExpiresOnM: TDateField;
    qryMainPointsExpired: TFloatField;
    qryMainSalesLinesPointsId: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainLinePoints: TFloatField;
    qryMainLineValue: TFloatField;
    qryMainPointExpiresOn: TDateField;
    qryMainExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    qryMainPointsUOMID: TIntegerField;
    qryMainPointsUOMMultiplier: TFloatField;
    qryMainActive: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMainRewardPointID: TIntegerField;
    qryMainValueforRewardPoint: TFloatField;
    qryMainIsOpeningBalance: TWideStringField;
    qryMainOpeningBalanceAsOn: TDateField;
    qryMainDeptID: TLargeintField;
    qryMainDeptname: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainUsedPoints: TFloatField;
    qryMainRedeemAmount: TFloatField;
    qryMainSaleDate: TDateTimeField;
    qryMainExpiryDate: TDateTimeField;
    qryMainTRanstype: TWideStringField;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    (*Procedure SetQryfilter;*)
    { Private declarations }
  Protected

    Procedure SetGridColumns;override;
    procedure RefreshTotals; override;
    Function ExtraFilter :String;virtual;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, FastFuncs, AppEnvironment, CompanyPrefObj,
  BusObjProductRewardPoints, tcConst, BUsObjSaleBase, SalesConst;

{$R *.dfm}
{ TRewardPointsGUI }

(*class procedure TRewardPointsGUI.GetPoints(const CustomerID: Integer;
  const OnSelectPoints: TNotifyEvent; const SaleDate:TDateTime; const MyConnection :TERPConnection=nil);
var
  form :Tcomponent;
begin
  if FormStillOpen('TRewardPointsGUI') then begin
    form := GetComponentByClassName('TRewardPointsGUI');
    TRewardPointsGUI(form).close;
    freeandNil(form);
  end;

  form := GetComponentByClassName('TRewardPointsGUI');
  if TRewardPointsGUI(form).visible then begin
      CommonLib.MessageDlgXP_Vista('Reward points is already opened, please close it to choose the points to redeem' , mtInformation, [mbok], 0);
      exit;
  end;
  if not assigned(Form) then exit;
  TRewardPointsGUI(form).OnSelectPoints := OnSelectPoints;
  TRewardPointsGUI(form).FilterString :='ClientID = ' + IntToStr(CustomerID) +
                                {' and active = "T" ' +}
                                ' and  (ExpiryDate = 0 or ExpiryDate is null or '+
                                        ' (   ExpiryDate >=' +QuotedStr(FormatdateTime(FormatSettings.ShortDateformat , SaleDate))+
                                        ' and ExpiryDAte >= ' + quotedStr(FormatdateTime(FormatSettings.ShortDateformat, Date))+' )) ' +
                                ' and AvailablePoints <> 0';
  if MyConnection <> nil then
    TRewardPointsGUI(form).Qrymain.connection :=  MyConnection;
  TRewardPointsGUI(form).grpFilters.visible := False;
  TRewardPointsGUI(form).Showmodal;
end;*)

procedure TRewardPointsGUI.RefreshQuery;
begin
(*  Qrymain.Params.ParamByName('DateFrom').asDateTime := FilterDateFrom;
  Qrymain.Params.ParamByName('Dateto').asDateTime := FilterDateTo;*)
  inherited;
end;

procedure TRewardPointsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('SalesLinesPointsId');
  RemoveFieldfromGrid('saleLineID');
  RemoveFieldfromGrid('PointsUOMID');
  RemoveFieldfromGrid('clientID');
  RemoveFieldfromGrid('RewardPointID');
  RemoveFieldfromGrid('msTimeStamp');
  RemoveFieldfromGrid('Active');
  RemoveFieldfromGrid('PointsUOMMultiplier');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('PointExpiresOn');
  RemoveFieldfromGrid('PointExpiresOnM');
  qryMainExpiryDate.DisplayFormat := FormatSettings.ShortDateformat;
  qryMainSaleDate.DisplayFormat := FormatSettings.ShortDateformat;
end;



Function TRewardPointsGUI.ExtraFilter:String ;
begin
  REsult := '';
end;

procedure TRewardPointsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn('LinePoints', False);
  AddCalccolumn('LineValue', true);
  AddCalccolumn('UsedPoints', False);
  AddCalccolumn('RedeemAmount', true);
  AddCalccolumn('AvailablePoints', False);
  AddCalccolumn('AvailablePointValue', true);
  AddCalccolumn('PointsExpired', False);
end;

procedure TRewardPointsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainPointsExpired.asFloat  := 0;
  if (qryMainExpiresOnNoOfMonthsAfterPurchase.asInteger <> 0) or
      (qryMainPointExpiresOn.asDatetime <> 0) then begin
    qryMainPointExpiresOnM.asDatetime := IncMonth(qryMainSaleDate.asDateTime, qryMainExpiresOnNoOfMonthsAfterPurchase.asInteger);
(*    if qryMainPointExpiresOnM.asDatetime > qryMainPointExpiresOn.asDatetime then
      qryMainExpiryDate.asDatetime :=qryMainPointExpiresOnM.asDatetime  else
      qryMainExpiryDate.asDatetime :=qryMainPointExpiresOn.asDatetime;*)
        if qryMainExpiryDate.asDatetime < date then
          qryMainPointsExpired.asFloat := round(qryMainLinePoints.Asfloat - qryMainUsedPoints.asfloat,OtherRoundPlaces);
  end;
  qryMainAvailablePoints.asFloat := round(qryMainLinePoints.Asfloat - qryMainUsedPoints.asfloat,OtherRoundPlaces) - qryMainPointsExpired.asFloat ;
  QrymainAvailablePointValue.asFloat :=qryMainAvailablePoints.asFloat * qryMainValueforRewardPoint.asFloat;
end;

procedure TRewardPointsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTRanstype.asString;
  if SameText(qryMain.Fields.FieldByName('TransType').AsString,'CashSale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;
end;

procedure TRewardPointsGUI.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TRewardPointsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Sysutils.SameText(Field.fieldname , 'ExpiryDAte') then begin
      if qryMainExpiryDate.asDatetime = 0 then
        Afont.Color := ABrush.color;
  end;
end;

(*procedure TRewardPointsGUI.SetQryfilter;
begin
  if grpFilter.itemindex = 0 then begin
    FilterString := 'AvailablePoints <> 0';
  end else if grpFilter.itemindex = 1 then begin
    FilterString := 'UsedPoints<>0';
  end else begin
    FilterString := '';
  end;
  if not(chkIgnoreDates.checked) then begin
      if FilterString <> '' then FilterString := '(' + FilterString + ') ';
  end;
  inherited;
end;*)

procedure TRewardPointsGUI.grpFiltersClick(Sender: TObject);
var
  grpfilterString :String;
begin
  grpfilterString := ExtraFilter;
  if grpFilters.itemindex = 0 then begin
    if grpfilterString <> '' then grpfilterString := grpfilterString+' and ' ;
    grpfilterString := grpfilterString+'AvailablePoints <> 0 '; //and (ExpiryDate = ' +QuotedSTr(FormatDateTime(FormatSettings.ShortDateformat,0))+' or ExpiryDate>= ' +QuotedSTr(FormatDateTime(FormatSettings.ShortDateformat,date))+')' ;
  end else if grpFilters.itemindex = 1 then begin
    if grpfilterString <> '' then grpfilterString := grpfilterString+' and ' ;
    grpfilterString := grpfilterString+'UsedPoints<>0';
  end else begin
  end;
  FilterString:= grpfilterString;
  inherited;
end;

procedure TRewardPointsGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpFilters.visible then
    if grpfilters.itemindex=-1 then
      grpFilters.ItemIndex:= 0;
end;

initialization
  RegisterClassOnce(TRewardPointsGUI);


end.
