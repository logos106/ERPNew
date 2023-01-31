unit SalesgrossProfit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TSalesgrossProfitGUI = class(TBaseListingGUI)
    qryMainProductname: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainlinecostInc: TFloatField;
    qryMainGP: TFloatField;
    qryMainGPP: TFloatField;
    qryMainTotalLinePriceInc: TFloatField;
    qryMainTotalLineCostInc: TFloatField;
    qryMainSalesCommissionId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    fiSaleID: Integer;
    Totalcost, totalPrice:double;
    GPP:double;
    
  Protected
    procedure RefreshTotals; override;
    Procedure CalcnShowFooter;override;
  public
    Procedure RefreshQuery; override;
    Property SaleID:Integer read fiSaleID Write fiSaleID;
    Procedure CalcFooter; Override;

  end;


implementation

uses CommonLib, FastFuncs, tcConst;
{$R *.dfm}

{ TBaseListingGUI1 }

procedure TSalesgrossProfitGUI.RefreshQuery;
begin
  Closedb(Qrymain);
  Qrymain.Params.Parambyname('SaleID').asInteger := SaleID;
  inherited;

end;

procedure TSalesgrossProfitGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSaleID :=0;
  AddCalccolumn('TotalLinePriceinc', true);
  AddCalccolumn('TotalLinecostInc', true);
  AddCalccolumn('GP', true);
end;

procedure TSalesgrossProfitGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrymainTotalLinePriceInc.asfloat :=QrymainLinePriceInc.asfloat * QrymainShipped.asfloat;
  qryMainTotalLineCostInc.asfloat:= QrymainlinecostInc.asfloat* QrymainShipped.asfloat;
  QrymainGP.asfloat := (QrymainTotalLinePriceInc.asfloat)- (qryMainTotalLineCostInc.asfloat);
  if (QrymainTotalLinePriceInc.asFloat = 0) and (qryMainTotalLineCostInc.asfloat = 0) then
    QrymainGPP.asfloat := 0
  else if (QrymainTotalLinePriceInc.asFloat = 0) and (qryMainTotalLineCostInc.asfloat <> 0) then
      QrymainGPP.asfloat := 0-100
  else if (QrymainTotalLinePriceInc.asFloat <> 0 ) and (qryMainTotalLineCostInc.asfloat = 0) then
    QrymainGPP.asfloat := 100
  else
    QrymainGPP.asfloat := commonlib.Round(((QrymainTotalLinePriceInc.asFloat  -
                                          qryMainTotalLineCostInc.asfloat) /
                                         QrymainTotalLinePriceInc.asfloat)*100 ,CurrencyRoundPlaces);
end;

procedure TSalesgrossProfitGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSalesgrossProfitGUI.CalcFooter;
begin
  inherited;
  if qryMainSalesCommissionId.asInteger <> 0 then begin
    Totalcost:= Totalcost+ qryMainTotallinecostInc.asfloat;
    totalPrice:= totalPrice+ qryMainTotallinePriceInc.asfloat;
  end;
end;

procedure TSalesgrossProfitGUI.CalcnShowFooter;
begin
  GPP :=0;
  Totalcost:=0;
  totalPrice:=0;
  inherited;
  try
         if totalCost   = 0 then GPP := 100
    else if totalprice  = 0 then GPP := -100
    else GPP:=(totalPrice  - totalCost) / totalPrice *100 ;
  except
      // kill INF error
      GPP:= 0;
  end;
  grdMain.ColumnByName('GPP').FooterValue := FloatToStrF(Round(GPP,2), ffGeneral, 15, 2);
end;

procedure TSalesgrossProfitGUI.FormShow(Sender: TObject);
begin
  inherited;
    TitleLabel.Caption := 'Sale # '+IntToStr(SaleID);
end;

procedure TSalesgrossProfitGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainSalesCommissionId.asInteger = 0 then AFont.Color := clblue;
end;

initialization
  RegisterClassOnce(TSalesgrossProfitGUI);
end.
