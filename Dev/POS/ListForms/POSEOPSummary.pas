unit POSEOPSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  wwcheckbox, CustomInputBox;

type
  TPOSEOPSummaryGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainPeriodID: TIntegerField;
    qryMainStart: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainTillName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainTrafficCount: TLargeintField;
    qryMainSalecount: TLargeintField;
    qryMainEFTPOS: TFloatField;
    qryMainVisa: TFloatField;
    qryMainMasterCard: TFloatField;
    qryMainDiners: TFloatField;
    qryMainBankCard: TFloatField;
    qryMainAmex: TFloatField;
    qryMainCheques: TFloatField;
    qryMainPeriodTotal: TFloatField;
    qryMainTotalCash: TFloatField;
    qryMainSaleID: TLargeintField;
    qryMainAmount: TFloatField;
    qryMainHundred: TIntegerField;
    qryMainFifty: TIntegerField;
    qryMainTwenty: TIntegerField;
    qryMainTen: TIntegerField;
    qryMainFive: TIntegerField;
    qryMainTwo: TIntegerField;
    qryMainOne: TIntegerField;
    qryMainFiftyCents: TIntegerField;
    qryMainTwentyCents: TIntegerField;
    qryMainTenCents: TIntegerField;
    qryMainFiveCents: TIntegerField;
    qryMainTwoCents: TIntegerField;
    qryMainOneCent: TIntegerField;
    qryMainPayMethod: TWideStringField;
    qryMainConversionRate: TFloatField;
    qryMainCash: TFloatField;
    qryMainVariance: TFloatField;
    qryMainCashSales: TFloatField;
    qryMainCreditCard: TFloatField;
    qryMainDebitCard: TFloatField;
    qryMainMaestro: TFloatField;
    qryMaineopDate: TDateField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
    Procedure RefreshTotals;Override;
    Procedure CalcFooter;Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib,DateUtils, tcConst;

{$R *.dfm}
{ TPOSEOPSummaryGUI }

procedure TPOSEOPSummaryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('TillID');
  RemoveFieldfromGrid('PeriodNumber');
  RemoveFieldfromGrid('PeriodTotal');
  RemoveFieldfromGrid('IsInDatetimeRange');
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('InvoicePayments');
  RemoveFieldfromGrid('Cash');
end;

procedure TPOSEOPSummaryGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  try
    if qryMainDetails.asInteger = 0 then begin
      qryMainConversionRate.asfloat := round(DivZer(qryMainSalecount.AsInteger,qryMainTrafficCount.asfloat) * 100, OtherRoundPlaces);
      qrymainVariance.asFloat := qryMainCash.asfloat - qryMainTotalCash.asFloat;  
    end;
  except
      //kill the exception
  end;

end;

procedure TPOSEOPSummaryGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').asDateTime  := DateUtils.StartOfTheDay(dtfrom.DateTime);
  qryMain.Params.ParamByName('Dateto').asDateTime    := DateUtils.EndOfTheDay(dtto.DateTime);
  inherited;
end;

procedure TPOSEOPSummaryGUI.grpFiltersClick(Sender: TObject);
begin

  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;
    2:
      begin {Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  inherited;

end;

procedure TPOSEOPSummaryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }


  if SameText(Field.FieldName , QrymainEFTPOS.fieldname) or
      SameText(Field.FieldName , QrymainVisa.fieldname) or
      SameText(Field.FieldName , QrymainMasterCard.fieldname) or
      SameText(Field.FieldName , QrymainDiners.fieldname) or
      SameText(Field.FieldName , QrymainBankCard.fieldname) or
      SameText(Field.FieldName , QrymainAmex.fieldname) or
      SameText(Field.FieldName , QrymainCheques.fieldname) or
      SameText(Field.FieldName , QrymainCashSales.fieldname) or
      SameText(Field.FieldName , QrymainCreditCard.fieldname) or
      SameText(Field.FieldName , QrymainDebitCard.fieldname) or
      SameText(Field.FieldName , QrymainMaestro.fieldname) then
      Abrush.color := $00B9FFFF;

  if SameText(Field.FieldName , QrymainHundred.fieldname) or
      SameText(Field.FieldName , QrymainFifty.fieldname) or
      SameText(Field.FieldName , QrymainTwenty.fieldname) or
      SameText(Field.FieldName , QrymainTen.fieldname) or
      SameText(Field.FieldName , QrymainFive.fieldname) or
      SameText(Field.FieldName , QrymainTwo.fieldname) or
      SameText(Field.FieldName , QrymainOne.fieldname) or
      SameText(Field.FieldName , QrymainFiftyCents.fieldname) or
      SameText(Field.FieldName , QrymainTwentyCents.fieldname) or
      SameText(Field.FieldName , QrymainTenCents.fieldname) or
      SameText(Field.FieldName , QrymainFiveCents.fieldname) or
      SameText(Field.FieldName , QrymainTotalCash.fieldname) then
      ABrush.color :=   $00E4FFCA;






  if (Field.FieldName = 'Variance') then begin
    if (Field.Text <> '') then begin
      if (Field.Value < 0.00) then begin
        ABrush.Color := $00EAAA8E;//clBlue;
      end;
      if (Field.Value < 0.00) then begin
        ABrush.Color := $009A75F0;//clRed;
      end;
    end;
  End;



  if QrymainDEtails.asInteger <> 0 then
    if (SameText(Field.FieldName , 'SaleCount')) or (SameText(Field.FieldName , 'TrafficCount')) then
      AFont.Color := ABrush.Color;

  if (grpFilters.ItemIndex <> 0) and (QrymainDEtails.asInteger = 0) then AFont.Style := AFont.Style + [fsBold]
  else AFont.Style := AFont.Style - [fsBold];

  if ((SameText(Field.FieldName , 'SaleDateTime'))    and (Field.Text = '1000-01-01 00:00:00')) Or
     ((SameText(Field.FieldName , 'QtySold'))         and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'SaleID'))          and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'InvoiceDocNumber'))and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'PeriodTotal'))     and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Variation'))       and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Hundred'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Fifty'))         and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Twenty'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Ten'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Five'))           and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Two'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'One'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'fiftyCents'))      and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TwentyCents'))     and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TenCents'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'fiveCents'))       and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'EFTPOS'))          and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Visa'))            and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'MasterCard'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Diners'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Bankcard'))        and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Amex'))            and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'CreditCard'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Cheques'))         and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Variance'))         and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'InvoicePayments')) and (Field.Value = 0))  OR
    ((SameText(Field.FieldName , 'CashSales')) and (Field.Value = 0))  OR
    ((SameText(Field.FieldName , 'CreditCard')) and (Field.Value = 0))  OR
    ((SameText(Field.FieldName , 'DebitCard')) and (Field.Value = 0))  OR
    ((SameText(Field.FieldName , 'Maestro')) and (Field.Value = 0))  OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'PeriodID'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Start'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'EndDate'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TillName'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'EmployeeName'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TrafficCount'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Salecount'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'EFTPOS'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Visa'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'MasterCard'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Diners'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'BankCard'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Amex'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Cheques'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'CashSales'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'CreditCard'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'DebitCard'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Maestro'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'PeriodTotal'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TotalCash'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Hundred'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Fifty'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Twenty'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Ten'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Five'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'Two'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'One'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'FiftyCents'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TwentyCents'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TenCents'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'FiveCents'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'TwoCents'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'OneCent'))) OR
    ((QrymainDEtails.asInteger <> 0 )         and (SameText(Field.fieldName , 'ConversionRate'))) then
      AFont.Color := ABrush.Color;

end;

procedure TPOSEOPSummaryGUI.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if SameText(AFieldName , QrymainEFTPOS.fieldname) or
      SameText(AFieldName , QrymainVisa.fieldname) or
      SameText(AFieldName , QrymainMasterCard.fieldname) or
      SameText(AFieldName , QrymainDiners.fieldname) or
      SameText(AFieldName , QrymainBankCard.fieldname) or
      SameText(AFieldName , QrymainAmex.fieldname) or
      SameText(AFieldName , QrymainCheques.fieldname) or
      SameText(AFieldName , QrymainCashSales.fieldname) or
      SameText(AFieldName , QrymainCreditCard.fieldname) or
      SameText(AFieldName , QrymainDebitCard.fieldname) or
      SameText(AFieldName , QrymainMaestro.fieldname) then
      Abrush.color := $00B9FFFF;

  if SameText(AFieldName , QrymainHundred.fieldname) or
      SameText(AFieldName , QrymainFifty.fieldname) or
      SameText(AFieldName , QrymainTwenty.fieldname) or
      SameText(AFieldName , QrymainTen.fieldname) or
      SameText(AFieldName , QrymainFive.fieldname) or
      SameText(AFieldName , QrymainTwo.fieldname) or
      SameText(AFieldName , QrymainOne.fieldname) or
      SameText(AFieldName , QrymainFiftyCents.fieldname) or
      SameText(AFieldName , QrymainTwentyCents.fieldname) or
      SameText(AFieldName , QrymainTenCents.fieldname) or
      SameText(AFieldName , QrymainFiveCents.fieldname) or
      SameText(AFieldName , QrymainTotalCash.fieldname) then
      ABrush.color :=   $00E4FFCA;

end;

procedure TPOSEOPSummaryGUI.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TPOSEOPSummaryGUI.CalcFooter;
begin
  if Qrymaindetails.AsInteger <> 0 then exit;
  inherited;

end;

procedure TPOSEOPSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= TRue;

  AddcalcColumn(qryMainTrafficCount.fieldname, False);
  AddcalcColumn(QrymainSalecount.fieldname   , False);
  AddcalcColumn(QrymainHundred.fieldname     , False);
  AddcalcColumn(QrymainFifty.fieldname       , False);
  AddcalcColumn(QrymainTwenty.fieldname      , False);
  AddcalcColumn(QrymainTen.fieldname         , False);
  AddcalcColumn(QrymainFive.fieldname        , False);
  AddcalcColumn(QrymainTwo.fieldname         , False);
  AddcalcColumn(QrymainOne.fieldname         , False);
  AddcalcColumn(QrymainFiftyCents.fieldname  , False);
  AddcalcColumn(QrymainTwentyCents.fieldname , False);
  AddcalcColumn(QrymainTenCents.fieldname    , False);
  AddcalcColumn(QrymainFiveCents.fieldname   , False);
  AddcalcColumn(QrymainTwoCents.fieldname    , False);
  AddcalcColumn(QrymainOneCent.fieldname     , False);


  AddcalcColumn(QrymainEFTPOS.fieldname      , True);
  AddcalcColumn(QrymainVisa.fieldname        , True);
  AddcalcColumn(QrymainMasterCard.fieldname  , True);
  AddcalcColumn(QrymainDiners.fieldname      , True);
  AddcalcColumn(QrymainBankCard.fieldname    , True);
  AddcalcColumn(QrymainAmex.fieldname        , True);
  AddcalcColumn(QrymainCheques.fieldname     , True);
  AddcalcColumn(QrymainPeriodTotal.fieldname , True);
  AddcalcColumn(QrymainTotalCash.fieldname   , True);
  AddcalcColumn(QrymainAmount.fieldname      , True);
  AddcalcColumn(QrymainCash.fieldname        , True);
  AddcalcColumn(QrymainVariance.fieldname    , True);
  AddcalcColumn(QrymainCashSales.fieldname   , True);
  AddcalcColumn(QrymainCreditCard.fieldname  , True);
  AddcalcColumn(QrymainDebitCard.fieldname   , True);
  AddcalcColumn(QrymainMaestro.fieldname   , True);
end;

procedure TPOSEOPSummaryGUI.FormShow(Sender: TObject);
begin
  inherited;
    grpFilters.ItemIndex := 0;
  grpFiltersClick(grpFilters);
end;

initialization
  RegisterClassOnce(TPOSEOPSummaryGUI);

end.
