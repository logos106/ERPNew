unit frmRegionalOptionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TfmRegionalOptionList = class(TBaseListingGUI)
    qryMainRegionID: TIntegerField;
    qryMainRegion: TWideStringField;
    qryMainRegionAbbreviation: TWideStringField;
    qryMainCurrencySymbol: TWideStringField;
    qryMainWholeCurrencyName: TWideStringField;
    qryMainDecimalCurrencyName: TWideStringField;
    qryMainCurrencyFormat: TSmallintField;
    qryMainNegCurrFormat: TSmallintField;
    qryMainShortDateFormat: TWideStringField;
    qryMainDateSeparator: TWideStringField;
    qryMainSuburbName: TWideStringField;
    qryMainStateName: TWideStringField;
    qryMainPostcodeLength: TIntegerField;
    qryMainPostcodeMask: TWideStringField;
    qryMainPhoneNumberLength: TIntegerField;
    qryMainPhoneNumberMask: TWideStringField;
    qryMainMobileNumberLength: TIntegerField;
    qryMainMobileNumberMask: TWideStringField;
    qryMainBSBName: TWideStringField;
    qryMainBSBLength: TIntegerField;
    qryMainBSBMask: TWideStringField;
    qryMainBankAccountLength: TIntegerField;
    qryMainBankAccountMask: TWideStringField;
    qryMainForeignExDefault: TWideStringField;
    qryMainWeekStartDay: TIntegerField;
    qryMainCurrencyFormatStr: TWideStringField;
    qryMainNegativeCurrencyFormatStr: TWideStringField;
    qryMainWeekStartDayName: TWideStringField;
    qryMainTaxCodeSalesInc: TWideStringField;
    qryMainTaxCodeSalesEx: TWideStringField;
    qryMainTaxCodePurchaseInc: TWideStringField;
    qryMainTaxCodePurchaseEx: TWideStringField;
    qryMainTaxCodeNoTax: TWideStringField;
    qryMainBusinessTaxNoLabel: TWideStringField;
    qryMainBusinessTaxNoMask: TWideStringField;
    qryMainBusinessTaxNoLength: TIntegerField;
    qryMainBusinessNoLabel: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  timelib, BaseInputForm, CommonLib;

procedure TfmRegionalOptionList.FormShow(Sender: TObject);
var x: integer;
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'RegionID,CurrencyFormat,NegCurrFormat,WeekStartDay');
  for x:= 0 to qryMain.FieldCount -1 do
    qryMain.Fields[x].EditMask:= '';

end;

procedure TfmRegionalOptionList.RefreshQuery;
begin
  inherited;
end;

procedure TfmRegionalOptionList.FormCreate(Sender: TObject);
begin
  inherited;
  AutoSetColumnControlType:= false;
end;

procedure TfmRegionalOptionList.qryMainCalcFields(DataSet: TDataSet);
var
  cs: string;
begin
  inherited;
  qryMainWeekStartDayName.AsString:= timelib.DayToDayLongame(qryMainWeekStartDay.AsInteger);
  cs:= qryMainCurrencySymbol.AsString;
  case qryMainCurrencyFormat.AsInteger of
    0: qryMainCurrencyFormatStr.asString:= (cs + '1');
    1: qryMainCurrencyFormatStr.asString:= ('1' + cs);
    2: qryMainCurrencyFormatStr.asString:= (cs + ' 1');
    3: qryMainCurrencyFormatStr.asString:= ('1 ' + cs);
    else qryMainCurrencyFormatStr.asString:= '';
  end;
  case qryMainNegCurrFormat.AsInteger of
    0: qryMainNegativeCurrencyFormatStr.asString:= ('('+cs+'1)');
    1: qryMainNegativeCurrencyFormatStr.asString:= ('-'+cs+'1');
    2: qryMainNegativeCurrencyFormatStr.asString:= (cs+'-1');
    3: qryMainNegativeCurrencyFormatStr.asString:= (cs+'1-');
    4: qryMainNegativeCurrencyFormatStr.asString:= ('(1'+cs+')');
    5: qryMainNegativeCurrencyFormatStr.asString:= ('-1'+cs);
    6: qryMainNegativeCurrencyFormatStr.asString:= ('1-'+cs);
    7: qryMainNegativeCurrencyFormatStr.asString:= ('1'+cs+'-');
    8: qryMainNegativeCurrencyFormatStr.asString:= ('-1 '+cs);
    9: qryMainNegativeCurrencyFormatStr.asString:= ('-'+cs+' 1');
    10: qryMainNegativeCurrencyFormatStr.asString:= ('1 '+cs+'-');
    11: qryMainNegativeCurrencyFormatStr.asString:= (cs+' 1-');
    12: qryMainNegativeCurrencyFormatStr.asString:= (cs+' -1');
    13: qryMainNegativeCurrencyFormatStr.asString:= ('1- '+cs);
    14: qryMainNegativeCurrencyFormatStr.asString:= ('('+cs+' 1)');
    15: qryMainNegativeCurrencyFormatStr.asString:= ('(1 '+cs+')');
    else qryMainNegativeCurrencyFormatStr.asString:= '';
  end;
end;

procedure TfmRegionalOptionList.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmRegionalOptionEdit'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      KeyId:= 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClass(TfmRegionalOptionList);


end.
