unit frmPartsCostPriceOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, frmPartsFrm, Mask, wwdbedit, DBCtrls, wwcheckbox, db, wwclearbuttongroup, wwradiogroup,
  SelectionDialog, Menus;

type
  tchangingfield = (cfQ1=1, cfQ2=2, cfQ3=3, cfC1=4, cfC2=5, cfC3=6, cfPQ1=7, cfPQ2=8, cfPQ3=9, cfP1=10, cfP2=11, cfP3=12, cfGM=13, cfGMO=14);
  TfmPartsCostPriceOptions = class(TBaseForm)
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlPurchase: TDNMPanel;
    Label5: TLabel;
    Label4: TLabel;
    txtBuy3: TDBEdit;
    txtBuy1: TDBEdit;
    txtBuy2: TDBEdit;
    txtCost1: TwwDBEdit;
    txtCost3: TwwDBEdit;
    txtCost2: TwwDBEdit;
    txtSell1: TDBEdit;
    txtPrice1: TwwDBEdit;
    txtSell2: TDBEdit;
    txtPrice2: TwwDBEdit;
    txtSell3: TDBEdit;
    txtPrice3: TwwDBEdit;
    lblcost: TLabel;
    lblPrice: TLabel;
    chkChangeCost: TCheckBox;
    optPriceRecalculate: TRadioGroup;
    chkChangePrice: TCheckBox;
    btnClose: TDNMSpeedButton;
    btnOk: TDNMSpeedButton;
    DBCheckBox35: TwwCheckBox;
    Label1: TLabel;
    DBCheckBox80: TwwCheckBox;
    Label2: TLabel;
    Label6: TLabel;
    rgMarkupType: TwwRadioGroup;
    txtmarkup: TwwDBEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtPart: TwwDBEdit;
    lblProductName: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblMsg: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure ForceExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fPartsform: TfrmParts;
    fChangingfield: tchangingfield;
    function IsCostIncshown: boolean;
    function IsPriceIncshown: boolean;

  public
    Property Partsform :TfrmParts read fPartsform write fPartsform;
    Property Changingfield : tchangingfield read fChangingfield write fChangingfield;
    Class procedure ValidateProductcostPrice(xChangingfield: tchangingfield; xPArtsform: TfrmParts);
  end;


implementation

uses CommonLib, tcConst, DNMLib, BusObjStock , Progressdialog, CommonDbLib;

{$R *.dfm}

procedure TfmPartsCostPriceOptions.btnCloseClick(Sender: TObject);
begin
  inherited;
  with Partsform do begin
           if Changingfield = cfC1 then
             if (not VarIsNull(qryProduct.FieldByName(txtcost1.DataField).OldValue)) then
               qryProduct.FieldByName(txtcost1.DataField).asFloat := qryProduct.FieldByName(txtcost1.DataField).OldValue
      else if Changingfield = cfC2 then
        if (not VarIsNull(qryProduct.FieldByName(txtcost2.DataField).OldValue)) then
          qryProduct.FieldByName(txtcost2.DataField).asFloat := qryProduct.FieldByName(txtcost2.DataField).OldValue
      else if Changingfield = cfC3 then
        if (not VarIsNull(qryProduct.FieldByName(txtcost3.DataField).OldValue)) then
          qryProduct.FieldByName(txtcost3.DataField).asFloat := qryProduct.FieldByName(txtcost3.DataField).OldValue
      else if Changingfield = cfP1 then
        if (not VarIsNull(qryProduct.FieldByName(txtPrice1.DataField).OldValue)) then
          qryProduct.FieldByName(txtPrice1.DataField).asFloat := qryProduct.FieldByName(txtPrice1.DataField).OldValue
      else if Changingfield = cfP2 then
        if (not VarIsNull(qryProduct.FieldByName(txtPrice2.DataField).OldValue)) then
          qryProduct.FieldByName(txtPrice2.DataField).asFloat := qryProduct.FieldByName(txtPrice2.DataField).OldValue
      else if Changingfield = cfP3 then
        if (not VarIsNull(qryProduct.FieldByName(txtPrice3.DataField).OldValue)) then
          qryProduct.FieldByName(txtPrice3.DataField).asFloat := qryProduct.FieldByName(txtPrice3.DataField).OldValue;
  end;
  ModalResult:= mrCancel;
end;
function TfmPartsCostPriceOptions.IsCostIncshown:boolean;
begin
  result := not(Sametext(Partsform.tglCost.Caption , 'Cost (Ex)'));
end;
function TfmPartsCostPriceOptions.IsPriceIncshown:boolean;
begin
  result := Sametext(Partsform.tglGST.Caption , 'Price (Inc)');
end;

procedure TfmPartsCostPriceOptions.btnOkClick(Sender: TObject);
  Procedure CalccostExInc;
  begin
    With Partsform do begin
          if IsCostIncshown then begin
            qryProductcost1.AsFloat := CommonLib.Round(GetAmountex(qryProductcostinc1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
            qryProductcost2.AsFloat := CommonLib.Round(GetAmountex(qryProductcostinc2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
            qryProductcost3.AsFloat := CommonLib.Round(GetAmountex(qryProductcostinc3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          end else begin
            qryProductcostINC1.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
            qryProductcostINC2.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
            qryProductcostINC3.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          end;
    end;
  end;

  Procedure CalcPriceExInc;
  begin
    With Partsform do begin
      if ISPriceIncshown then begin
          qryProductPRICE1.AsFloat := CommonLib.Round(GetAmountEx(qryProductPRICEINC1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          qryProductPRICE2.AsFloat := CommonLib.Round(GetAmountEx(qryProductPRICEINC2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          qryProductPRICE3.AsFloat := CommonLib.Round(GetAmountEx(qryProductPRICEINC3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      end else begin
          qryProductPRICEINC1.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          qryProductPRICEINC2.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
          qryProductPRICEINC3.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      end;
      RoundPrice1;
      RoundPrice2;
      RoundPrice3;
    end;
  end;

begin
  inherited;
  With Partsform do begin
    if ChangingField in [cfGM, cfGMO] then begin
                if QryProductGrossMarginMode.asString = 'T' then begin{from markup}
                  if qryProductSell_Cost_Percentage.asfloat <> 0 then begin
                         if qryProductBuyQTY1.AsFloat = qryProductSellQTY1.AsFloat then  QryproductPRICE1.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY2.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY3.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY2.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                  end;
                end else begin   {from gross}
                  if qryProductSell_Cost_Percentage.asfloat <> 0 then begin
                         if qryProductBuyQTY1.AsFloat = qryProductSellQTY1.AsFloat then  QryproductPRICE1.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY2.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY3.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY2.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                  end;
                end;
                qryProductPRICEinc1.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
                qryProductPRICEinc2.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
                qryProductPRICEinc3.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);

    end else if ChangingField in [cfC1, cfC2, cfC3] then begin
        if chkChangeCost.Enabled and chkChangeCost.Checked then begin
            if Changingfield = cfC1 then begin
              if qryProductBuyQTY1.AsFloat = qryProductBuyQTY2.AsFloat then qryProduct.FieldByName(txtcost2.Datafield).AsFloat := QryProduct.FieldByName(txtcost1.Datafield).AsFloat;
              if qryProductBuyQTY1.AsFloat = qryProductBuyQTY3.AsFloat then qryProduct.FieldByName(txtcost3.Datafield).AsFloat := QryProduct.FieldByName(txtcost1.Datafield).AsFloat;
            end;

            if Changingfield = cfC2 then begin
              if qryProductBuyQTY2.AsFloat = qryProductBuyQTY1.AsFloat then QryProduct.FieldByName(txtcost1.Datafield).AsFloat := qryProduct.FieldByName(txtcost2.Datafield).AsFloat;
              if qryProductBuyQTY2.AsFloat = qryProductBuyQTY3.AsFloat then qryProduct.FieldByName(txtcost3.Datafield).AsFloat := qryProduct.FieldByName(txtcost2.Datafield).AsFloat;
            end;

            if Changingfield = cfC3 then begin
              if qryProductBuyQTY3.AsFloat = qryProductBuyQTY1.AsFloat then QryProduct.FieldByName(txtcost1.Datafield).AsFloat := qryProduct.FieldByName(txtcost3.Datafield).AsFloat;
              if qryProductBuyQTY3.AsFloat = qryProductBuyQTY2.AsFloat then qryProduct.FieldByName(txtcost2.Datafield).AsFloat := qryProduct.FieldByName(txtcost3.Datafield).AsFloat;
            end;
            CalccostExInc;

            if optPriceRecalculate.ItemIndex = 0 then begin {calculate price}
                if QryProductGrossMarginMode.asString = 'T' then begin{from markup}
                  if qryProductSell_Cost_Percentage.asfloat <> 0 then begin
                         if qryProductBuyQTY1.AsFloat = qryProductSellQTY1.AsFloat then  QryproductPRICE1.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY2.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY3.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY2.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                  end;
                end else begin   {from gross}
                  if qryProductSell_Cost_Percentage.asfloat <> 0 then begin
                         if qryProductBuyQTY1.AsFloat = qryProductSellQTY1.AsFloat then  QryproductPRICE1.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY2.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY2.AsFloat then  QryproductPRICE2.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                         if qryProductBuyQTY3.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY2.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces)
                    else if qryProductBuyQTY1.AsFloat = qryProductSellQTY3.AsFloat then  QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
                  end;
                end;
                qryProductPRICEinc1.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
                qryProductPRICEinc2.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
                qryProductPRICEinc3.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
            end else begin {recalculate markup}
              if (QryProductcost1.asFloat<>0) and (qryProductPRICE1.AsFloat<>0) then begin
                if QryProductGrossMarginMode.asString = 'F' then begin{markup}
                  qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.CalcGrossMarginPerc( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), 2);
                end else begin{gross}
                  qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.calcMarkupPercent( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), 2);
                end;
              end;
            end;

        end else if chkChangeCost.Enabled and not(chkChangeCost.Checked) then begin
               if Changingfield = cfC1 then qryProduct.FieldByName(txtcost1.DataField).asFloat := qryProduct.FieldByName(txtcost1.DataField).OldValue
          else if Changingfield = cfC2 then qryProduct.FieldByName(txtcost2.DataField).asFloat := qryProduct.FieldByName(txtcost2.DataField).OldValue
          else if Changingfield = cfC3 then qryProduct.FieldByName(txtcost3.DataField).asFloat := qryProduct.FieldByName(txtcost3.DataField).OldValue;
          CalcCostExInc;
        end;
    end;

    if chkChangePrice.Enabled and chkChangePrice.Checked then begin
        if Changingfield = cfP1 then begin
          if qryProductSellQTY1.AsFloat = qryProductSellQTY2.AsFloat then qryProduct.FieldByName(txtPrice2.Datafield).AsFloat := QryProduct.FieldByName(txtPrice1.Datafield).AsFloat;
          if qryProductSellQTY1.AsFloat = qryProductSellQTY3.AsFloat then qryProduct.FieldByName(txtPrice3.Datafield).AsFloat := QryProduct.FieldByName(txtPrice1.Datafield).AsFloat;
        end;

        if Changingfield = cfP2 then begin
          if qryProductSellQTY2.AsFloat = qryProductSellQTY1.AsFloat then QryProduct.FieldByName(txtPrice1.Datafield).AsFloat := qryProduct.FieldByName(txtPrice2.Datafield).AsFloat;
          if qryProductSellQTY2.AsFloat = qryProductSellQTY3.AsFloat then qryProduct.FieldByName(txtPrice3.Datafield).AsFloat := qryProduct.FieldByName(txtPrice2.Datafield).AsFloat;
        end;

        if Changingfield = cfP3 then begin
          if qryProductSellQTY3.AsFloat = qryProductSellQTY1.AsFloat then QryProduct.FieldByName(txtPrice1.Datafield).AsFloat := qryProduct.FieldByName(txtPrice3.Datafield).AsFloat;
          if qryProductSellQTY3.AsFloat = qryProductSellQTY2.AsFloat then qryProduct.FieldByName(txtPrice2.Datafield).AsFloat := qryProduct.FieldByName(txtPrice3.Datafield).AsFloat;
        end;

        if (QryProductcost1.asFloat<>0) and (qryProductPRICE1.AsFloat<>0) then begin
          if QryProductGrossMarginMode.asString = 'F' then begin{markup}
            qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.CalcGrossMarginPerc( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), 2);
          end else begin{gross}
            qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.calcMarkupPercent( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), 2);
          end;
        end;
        CalcPriceExInc;
    end else if chkChangePrice.Enabled and not(chkChangePrice.Checked) then begin
           if Changingfield = cfP1 then qryProduct.FieldByName(txtPrice1.DataField).asFloat := qryProduct.FieldByName(txtPrice1.DataField).OldValue
      else if Changingfield = cfP2 then qryProduct.FieldByName(txtPrice2.DataField).asFloat := qryProduct.FieldByName(txtPrice2.DataField).OldValue
      else if Changingfield = cfP3 then qryProduct.FieldByName(txtPrice3.DataField).asFloat := qryProduct.FieldByName(txtPrice3.DataField).OldValue;
      calcPriceExInc;
    end;
    qryProductCOST1Change(qryProductCOST1);
    qryProductPRICE1Change(qryProductPRICE1);

    Self.Close;
  end;
end;

procedure TfmPartsCostPriceOptions.ForceExit(Sender: TObject);
begin
       if chkChangeCost.enabled       then SetControlFocus(chkChangeCost)
  else if chkChangePrice.enabled      then SetControlFocus(chkChangePrice)
  else if optPriceRecalculate.enabled then SetControlFocus(optPriceRecalculate)
  else if btnOk.enabled               then SetControlFocus(btnOk)
  else if btnClose.enabled            then SetControlFocus(btnClose);
end;

procedure TfmPartsCostPriceOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PartsForm.ShowPricecostCalcHint;
end;

procedure TfmPartsCostPriceOptions.FormShow(Sender: TObject);
begin
  inherited;
  SetcontrolFocus(btnOk);
end;

class procedure TfmPartsCostPriceOptions.ValidateProductcostPrice(xChangingfield : tchangingfield ; xPArtsform:TfrmParts);
var
  form :TfmPartsCostPriceOptions;
  s:String;
  Procedure AddMsg(const Value:String);
  begin
    if s<> '' then s:= s + NL;
    s:= s + Value;
  end;
begin
  inherited;
  s:= '';
  with xPArtsform do begin
    Commondblib.EditDB(QryProduct);
    {Round the user entry}

        if (xChangingfield = cfC1) or (xChangingfield = cfC2) or (xChangingfield = cfC3) then qryProductBOMCostCalculatedFromTree.AsBoolean := False;
        if (xChangingfield = cfP1) or (xChangingfield = cfP2) or (xChangingfield = cfP3) then qryProductBOMPriceCalculatedfromTree.AsBoolean:= False;
        if xChangingfield = cfQ1 then if qryProductBuyQTY1.asFloat  <> Round(qryProductBuyQTY1.asFloat,5)  then qryProductBuyQTY1.asFloat   := Round(qryProductBuyQTY1.asFloat,5);
        if xChangingfield = cfQ2 then if qryProductBuyQTY2.asFloat  <> Round(qryProductBuyQTY2.asFloat,5)  then qryProductBuyQTY2.asFloat   := Round(qryProductBuyQTY2.asFloat,5);
        if xChangingfield = cfQ3 then if qryProductBuyQTY3.asFloat  <> Round(qryProductBuyQTY3.asFloat,5)  then qryProductBuyQTY3.asFloat   := Round(qryProductBuyQTY3.asFloat,5);
        if xChangingfield = cfC1 then if qryProductCOST1.asFloat    <> Round(qryProductCOST1.asFloat,5)    then qryProductCOST1.asFloat     := Round(qryProductCOST1.asFloat,5);
        if xChangingfield = cfC2 then if qryProductCOST2.asFloat    <> Round(qryProductCOST2.asFloat,5)    then qryProductCOST2.asFloat     := Round(qryProductCOST2.asFloat,5);
        if xChangingfield = cfC3 then if qryProductCOST3.asFloat    <> Round(qryProductCOST3.asFloat,5)    then qryProductCOST3.asFloat     := Round(qryProductCOST3.asFloat,5);
        if xChangingfield = cfQ1 then if qryProductSellQTY1.asFloat <> Round(qryProductSellQTY1.asFloat,5) then qryProductSellQTY1.asFloat  := Round(qryProductSellQTY1.asFloat,5);
        if xChangingfield = cfQ2 then if qryProductSellQTY2.asFloat <> Round(qryProductSellQTY2.asFloat,5) then qryProductSellQTY2.asFloat  := Round(qryProductSellQTY2.asFloat,5);
        if xChangingfield = cfQ3 then if qryProductSellQTY3.asFloat <> Round(qryProductSellQTY3.asFloat,5) then qryProductSellQTY3.asFloat  := Round(qryProductSellQTY3.asFloat,5);
        if xChangingfield = cfP1 then if qryProductPrice1.asFloat   <> Round(qryProductPrice1.asFloat,5)   then qryProductPrice1.asFloat    := Round(qryProductPrice1.asFloat,5);
        if xChangingfield = cfP2 then if qryProductPrice2.asFloat   <> Round(qryProductPrice2.asFloat,5)   then qryProductPrice2.asFloat    := Round(qryProductPrice2.asFloat,5);
        if xChangingfield = cfP3 then if qryProductPrice3.asFloat   <> Round(qryProductPrice3.asFloat,5)   then qryProductPrice3.asFloat    := Round(qryProductPrice3.asFloat,5);


    {Validate Cost Qty1, Qty2, Qty3}
        if xChangingfield in [ cfQ1, cfQ2, cfQ3] then begin
          if qryProductBuyQTY1.asFloat > qryProductBuyQTY2.asFloat then begin AddMsg('Volume Buy Qty#1(' + FloattoStr(qryProductBuyQTY1.asfloat)  +') Cannot be > Volume Buy Qty#2(' + FloattoStr(qryProductBuyQTY2.asfloat)  +').' );qryProductBuyQTY2.asFloat :=qryProductBuyQTY1.asFloat;end;
          if qryProductBuyQTY2.asFloat > qryProductBuyQTY3.asFloat then begin AddMsg('Volume Buy Qty#2(' + FloattoStr(qryProductBuyQTY2.asfloat)  +') Cannot be > Volume Buy Qty#3(' + FloattoStr(qryProductBuyQTY3.asfloat)  +').' );qryProductBuyQTY3.asFloat := qryProductBuyQTY2.asFloat;end;
        end;
    {Validate Price Qty1, Qty2, Qty3}
        if xChangingfield in [ cfPQ1, cfPQ2, cfPQ3] then begin
          if qryProductSellQTY1.asFloat > qryProductSellQTY2.asFloat then begin AddMsg('Volume Sell Qty#1(' + FloattoStr(qryProductSellQTY1.asfloat)  +') Cannot be > Volume Sell Qty#2(' + FloattoStr(qryProductSellQTY2.asfloat)  +').' );qryProductSellQTY2.asFloat :=qryProductSellQTY1.asFloat;end;
          if qryProductSellQTY2.asFloat > qryProductSellQTY3.asFloat then begin AddMsg('Volume Sell Qty#2(' + FloattoStr(qryProductSellQTY2.asfloat)  +') Cannot be > Volume Sell Qty#3(' + FloattoStr(qryProductSellQTY3.asfloat)  +').' );qryProductSellQTY3.asFloat := qryProductSellQTY2.asFloat;end;
        end;
    {exit if Qty changed as the qty validation is done and nothing to be recalculated}
        if xChangingfield in [ cfPQ1, cfPQ2, cfPQ3 , cfQ1, cfQ2, cfQ3] then begin
          //if s<> '' then MessageDlg(s+NL +NL+'Automatically reverted', mtInformation, [mbOK], 0);
          Exit;
        end;

    {exit if cost3 is changed and PriceQty3 is <> costQty3}
        if xChangingfield  = cfC3 then
          if (qryProductBuyQTY1.asFloat < qryProductBuyQTY3.asFloat) and
            (qryProductBuyQTY2.asFloat < qryProductBuyQTY3.asFloat) then
            if  qryProductSellQTY3.asFloat <> qryProductBuyQTY3.asFloat then Exit; {nothing to update}

    {exit if Price3 is changed and PriceQty3 is <> costQty3}
        if xChangingfield  = cfP3 then
          if (qryProductSellQTY1.asFloat < qryProductSellQTY3.asFloat) and
            (qryProductSellQTY2.asFloat < qryProductSellQTY3.asFloat) then Exit; {nothing to update}

   form := TfmPartsCostPriceOptions.Create(xPartsform);
   try
    with Form do begin
      Changingfield := xChangingfield;
      Partsform     := xPartsform;

      lblCost.Caption             := tglCost.Caption;
      lblPrice.Caption            := tglGST.Caption;
      lblProductName.caption      := lblPartname.caption;

      txtBuy1.DataField           := qryProductBuyQTY1.FieldName;
      txtBuy2.DataField           := qryProductBuyQTY2.FieldName;
      txtBuy3.DataField           := qryProductBuyQTY3.FieldName;
      if IsCostIncshown then begin
        txtcost1.DataField          := qryProductCOSTINC1.FieldName;
        txtCost2.DataField          := qryProductCOSTINC2.FieldName;
        txtCost3.DataField          := qryProductCOSTINC3.FieldName;
      end else begin
        txtcost1.DataField          := qryProductCOST1.FieldName;
        txtCost2.DataField          := qryProductCOST2.FieldName;
        txtCost3.DataField          := qryProductCOST3.FieldName;
      end;

      txtSell1.DataField          := qryProductSellQTY1.FieldName;
      txtSell2.DataField          := qryProductSellQTY2.FieldName;
      txtSell3.DataField          := qryProductSellQTY3.FieldName;
      If IsPriceIncshown then begin
        txtPrice1.DataField         := qryProductPriceInc1.FieldName;
        txtPrice2.DataField         := qryProductPriceinc2.FieldName;
        txtPrice3.DataField         := qryProductPriceinc3.FieldName;
      end else begin
        txtPrice1.DataField         := qryProductPrice1.FieldName;
        txtPrice2.DataField         := qryProductPrice2.FieldName;
        txtPrice3.DataField         := qryProductPrice3.FieldName;
      end;
           if Changingfield = cfC1 then HighlightControl(txtcost1)
      else if Changingfield = cfC2 then HighlightControl(txtCost2)
      else if Changingfield = cfC3 then HighlightControl(txtCost3)
      else if Changingfield = cfP1 then HighlightControl(txtPrice1)
      else if Changingfield = cfP2 then HighlightControl(txtPrice2)
      else if Changingfield = cfP3 then HighlightControl(txtPrice3)
      else if Changingfield = cfGM then HighlightControl(txtmarkup)
      else if Changingfield = cfGMO then HighlightControl(rgMarkupType);

    if xChangingfield in [ cfC1, cfC2, cfC3] then begin
      if IsCostIncshown then begin
        if qryProductCostInc1.asFloat < qryProductCostInc2.asFloat then begin AddMsg('Volume Buy Cost#2(' + FloattoStr(qryProductCostInc2.asfloat)  +') Cannot be > Volume Buy Cost#1(' + FloattoStr(qryProductCostInc1.asfloat)  +').' );qryProductCostInc2.asFloat :=qryProductCostInc1.asFloat;end;
        if qryProductCostInc2.asFloat < qryProductCostInc3.asFloat then begin AddMsg('Volume Buy Cost#3(' + FloattoStr(qryProductCostInc3.asfloat)  +') Cannot be > Volume Buy Cost#2(' + FloattoStr(qryProductCostInc2.asfloat)  +').' );qryProductCostInc3.asFloat := qryProductCostInc2.asFloat;end;
      end else begin
        if qryProductCost1.asFloat < qryProductCost2.asFloat then begin AddMsg('Volume Buy Cost#2(' + FloattoStr(qryProductCost2.asfloat)  +') Cannot be > Volume Buy Cost#1(' + FloattoStr(qryProductCost1.asfloat)  +').' );qryProductCost2.asFloat :=qryProductCost1.asFloat;end;
        if qryProductCost2.asFloat < qryProductCost3.asFloat then begin AddMsg('Volume Buy Cost#3(' + FloattoStr(qryProductCost3.asfloat)  +') Cannot be > Volume Buy Cost#2(' + FloattoStr(qryProductCost2.asfloat)  +').' );qryProductCost3.asFloat := qryProductCost2.asFloat;end;
      end;
    end;

    if xChangingfield in [ cfP1, cfP2, cfP3] then begin
      if IsPriceIncshown then begin
        if qryProductPriceInc1.asFloat < qryProductPriceInc2.asFloat then begin AddMsg('Volume Buy Price#2(' + FloattoStr(qryProductPriceInc2.asfloat)  +') Cannot be > Volume Buy Price#1(' + FloattoStr(qryProductPriceInc1.asfloat)  +').' );qryProductPriceInc2.asFloat :=qryProductPriceInc1.asFloat;end;
        if qryProductPriceInc2.asFloat < qryProductPriceInc3.asFloat then begin AddMsg('Volume Buy Price#3(' + FloattoStr(qryProductPriceInc3.asfloat)  +') Cannot be > Volume Buy Price#2(' + FloattoStr(qryProductPriceInc2.asfloat)  +').' );qryProductPriceInc3.asFloat := qryProductPriceInc2.asFloat;end;
      end else begin
        if qryProductPrice1.asFloat < qryProductPrice2.asFloat then begin AddMsg('Volume Buy Price#2(' + FloattoStr(qryProductPrice2.asfloat)  +') Cannot be > Volume Buy Price#1(' + FloattoStr(qryProductPrice1.asfloat)  +').' );qryProductPrice2.asFloat :=qryProductPrice1.asFloat;end;
        if qryProductPrice2.asFloat < qryProductPrice3.asFloat then begin AddMsg('Volume Buy Price#3(' + FloattoStr(qryProductPrice3.asfloat)  +') Cannot be > Volume Buy Price#2(' + FloattoStr(qryProductPrice2.asfloat)  +').' );qryProductPrice3.asFloat := qryProductPrice2.asFloat;end;
      end;
    end;
    if xChangingfield = cfGM then
      if QryProductGrossMarginMode.asString = 'F' then
        if qryProductSell_Cost_Percentage.asFloat >=100 then begin
          AdDMsg('Goss margin should be less than 100, Changed to 99' );
          PostDB(qryProduct);
          editDB(qryProduct);
          qryProductSell_Cost_Percentage.asFloat := 99;
          PostDB(qryProduct);
          editDB(qryProduct);
        end;


      if Changingfield in [ cfC1, cfC2, cfC3] then begin
        chkChangeCost.Enabled:= true;
        chkChangeCost.checked := True;
        chkChangePrice.Enabled := False;
        optPriceRecalculate.Enabled:= True;
        if Changingfield = cfC1 then
               if (qryProductCOST1.AsFloat < qryProductCOST1.OldValue) and (qryProductOnCostDecrease.asBoolean=False) then optPriceRecalculate.itemindex := 1  // cost decreased and
          else if (qryProductCOST1.AsFloat > qryProductCOST1.OldValue) and (qryProductOnCostIncrease.asBoolean=False) then optPriceRecalculate.itemindex := 1  // increased
          else optPriceRecalculate.itemindex := 0;

        if Changingfield = cfC2 then
               if (qryProductCOST2.AsFloat < qryProductCOST2.OldValue) and (qryProductOnCostDecrease.asBoolean=False) then optPriceRecalculate.itemindex := 1
          else if (qryProductCOST2.AsFloat > qryProductCOST2.OldValue) and (qryProductOnCostIncrease.asBoolean=False) then optPriceRecalculate.itemindex := 1
          else optPriceRecalculate.itemindex := 0;

        if Changingfield = cfC3 then
               if (qryProductCOST3.AsFloat < qryProductCOST3.OldValue) and (qryProductOnCostDecrease.asBoolean=False) then optPriceRecalculate.itemindex := 1
          else if (qryProductCOST3.AsFloat > qryProductCOST3.OldValue) and (qryProductOnCostIncrease.asBoolean=False) then optPriceRecalculate.itemindex := 1
          else optPriceRecalculate.itemindex := 0;

      end else if Changingfield in [ cfP1, cfP2, cfP3, cfGM, cfGMO] then begin
        chkChangeCost.Enabled:= False;
        chkChangePrice.Enabled := True;
        chkChangePrice.Checked := True;
        optPriceRecalculate.Enabled:= False;
      end;
      //if s<> '' then MessageDlg(s+NL +NL+'Automatically reverted', mtInformation, [mbOK], 0);
      if s<> '' then
            TimerMsg(lblMsg, s);
      showModal;
    end;
   finally
     Freeandnil(form);
   end;
  end;
end;

end.

