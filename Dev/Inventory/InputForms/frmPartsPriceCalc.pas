unit frmPartsPriceCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, wwdbedit, Mask, DBCtrls,
  wwclearbuttongroup, wwradiogroup, DNMSpeedButton  , BusobjProductPriceCalc,
  frmPartsFrm,BusObjBase, AdvScrollBox;

type
TfmPartsPriceCalc = class(TBaseInputGUI)
    qryPartsPriceCalc: TERPQuery;
    dsPartsPriceCalc: TDataSource;
    qryPartsPriceCalcPartsID: TIntegerField;
    qryPartsPriceCalcProductPriceCalctype: TIntegerField;
    qryPartsPriceCalcLastCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcProductCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcAverageCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcManCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcManAverageCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcManLastCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcLandedCostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcTotalLandedcostGrossMarginMode: TWideStringField;
    qryPartsPriceCalcStandardMode: TWideStringField;
    qryPartsPriceCalcLatestCostPrice: TFloatField;
    qryPartsPriceCalcCOST1Price: TFloatField;
    qryPartsPriceCalcAvgCostPrice: TFloatField;
    qryPartsPriceCalcLandedCostPrice: TFloatField;
    qryPartsPriceCalcTotalLandedcostPrice: TFloatField;
    qryPartsPriceCalcMancostWithLabourPrice: TFloatField;
    qryPartsPriceCalcManLatestCostPrice: TFloatField;
    qryPartsPriceCalcManAvgCostPrice: TFloatField;
    qryPartsPriceCalcOverheadAmountPrice: TFloatField;
    qryPartsPriceCalcOverheadAmount: TFloatField;
    qryPartsPriceCalcLastCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcProductCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcAverageCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcManCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcManAverageCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcManLastCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcLandedCostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcTotalLandedcostGrossMarginAmount: TFloatField;
    qryPartsPriceCalcLatestCost: TFloatField;
    qryPartsPriceCalcCOST1: TFloatField;
    qryPartsPriceCalcAvgCost: TFloatField;
    qryPartsPriceCalcLandedCost: TFloatField;
    qryPartsPriceCalcTotalLandedcost: TFloatField;
    qryPartsPriceCalcMancostWithLabour: TFloatField;
    qryPartsPriceCalcManLatestCost: TFloatField;
    qryPartsPriceCalcManAvgCost: TFloatField;
    pnlMain: TDNMPanel;
    DNMPanel1: TDNMPanel;
    pnlStandard: TDNMPanel;
    lblStandard: TLabel;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    edtStandardCost: TDBEdit;
    edtOverheadAmountPrice: TDBEdit;
    edtOverheadAmount: TDBEdit;
    chkStandardCost: TCheckBox;
    optStandardMode: TwwRadioGroup;
    pnlManAvgCost: TDNMPanel;
    lblManAvgCost: TLabel;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    edtManAvgCost: TDBEdit;
    optManAvgCostMargin: TwwRadioGroup;
    edtManAvgCostPrice: TDBEdit;
    chkManAvgCost: TCheckBox;
    edtManAverageCostGrossMarginAmount: TDBEdit;
    pnlManLatestCost: TDNMPanel;
    lblManLatestCost: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    edtManLatestCost: TDBEdit;
    optManLatestCostMargin: TwwRadioGroup;
    edtManLatestCostPrice: TDBEdit;
    chkManLatestCost: TCheckBox;
    edtManLastCostGrossMarginAmount: TDBEdit;
    pnlMancostWithLabour: TDNMPanel;
    lblMancostWithLabour: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    edtMancostWithLabour: TDBEdit;
    optMancostWithLabourMargin: TwwRadioGroup;
    edtMancostWithLabourPrice: TDBEdit;
    chkMancostWithLabour: TCheckBox;
    edtManCostGrossMarginAmount: TDBEdit;
    pnlLandedCost: TDNMPanel;
    lblLandedCost: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    edtLandedCost: TDBEdit;
    OptLandedCostMargin: TwwRadioGroup;
    edtLandedCostPrice: TDBEdit;
    chkLandedCost: TCheckBox;
    edtLandedCostGrossMarginAmount: TDBEdit;
    pnlAvgCost: TDNMPanel;
    lblAvgCost: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    edtAvgCost: TDBEdit;
    optAvgCostMargin: TwwRadioGroup;
    edtAvgCostPrice: TDBEdit;
    chkAvgCost: TCheckBox;
    edtAverageCostGrossMarginAmount: TDBEdit;
    pnlLatestCost: TDNMPanel;
    lblLatestCost: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    edtLatestCost: TDBEdit;
    OptLatestCostMargin: TwwRadioGroup;
    edtLatestCostPrice: TDBEdit;
    chkLatestCost: TCheckBox;
    edtLastCostGrossMarginAmount: TDBEdit;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel4: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    qryPartsPriceCalcID: TIntegerField;
    qryPartsPriceCalcGlobalRef: TWideStringField;
    qryPartsPriceCalcmsTimeStamp: TDateTimeField;
    qryPartsPriceCalcmsUpdateSiteCode: TWideStringField;
    lblMsg: TLabel;
    pnlTotalLandedCost: TDNMPanel;
    lblTotalLandedCost: TLabel;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    Shape40: TShape;
    edtTotalLandedCost: TDBEdit;
    OpttotalLandedCostMargin: TwwRadioGroup;
    edttotalLandedCostPrice: TDBEdit;
    chkTotalLandedCost: TCheckBox;
    edtTotalLandedCostGrossMarginAmount: TDBEdit;
    pnlLeft: TDNMPanel;
    lblCost: TLabel;
    lblMargin: TLabel;
    lblPrice: TLabel;
    lblItems: TLabel;
    lblMarginAmt: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape8: TShape;
    Shape7: TShape;
    pnlCostPriceInc: TDNMPanel;
    lblCostPriceInc: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    edtCostPriceInc: TDBEdit;
    OptCostPriceIncMargin: TwwRadioGroup;
    edtCOST1Price: TDBEdit;
    chkCostPriceInc: TCheckBox;
    edtProductCostGrossMarginAmount: TDBEdit;

    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnUseSelect(Sender: TObject);
    procedure edtLatestCostEnter(Sender: TObject);
    procedure edtCostPriceIncEnter(Sender: TObject);
    procedure edtAvgCostEnter(Sender: TObject);
    procedure edtLandedcostEnter(Sender: TObject);
    procedure edtTotalLandedcostEnter(Sender: TObject);
    procedure edtMancostWithLabourEnter(Sender: TObject);
    procedure edtManLatestCostEnter(Sender: TObject);
    procedure edtManAvgCostEnter(Sender: TObject);
    procedure edtStandardCostEnter(Sender: TObject);
    procedure DoCalc(Sender: TObject);
    procedure OptCostPriceIncMarginChange(Sender: TObject);
    procedure OptLatestCostMarginChange(Sender: TObject);
    procedure optAvgCostMarginChange(Sender: TObject);
    procedure OptLandedCostMarginChange(Sender: TObject);
    procedure optManAvgCostMarginChange(Sender: TObject);
    procedure optMancostWithLabourMarginChange(Sender: TObject);
    procedure optManLatestCostMarginChange(Sender: TObject);
    procedure optStandardModeChange(Sender: TObject);
    procedure OpttotalLandedCostMarginChange(Sender: TObject);
(*    procedure CalcOnLatestcost(Sender: TField);
    procedure CalcOnProductcostchange(Sender: TField);
    procedure CalcOnAvgcostChange(Sender: TField);
    procedure CalcOnLandedcostChange(Sender: TField);
    procedure CalcOnMancostChange(Sender: TField);
    procedure CalcOnManAvgcostChange(Sender: TField);
    procedure CalcOnManLastcostChange(Sender: TField);
    procedure OnStandardAmtchange(Sender: TField);*)
  private
    fbUpdatingtoUse:Boolean;
    CalculatingCostPrice:Boolean;
    PartsPriceCalc : TPartsPriceCalc;
    fiPartsID:integer;
    Partsform : TfrmParts;
    function getProductPriceCalctype: Integer;
    procedure SetProductPriceCalctype(const Value: Integer);
    (*procedure CalcPrice(edtCost, edtPrice,edtPercent: TDBEdit; Opt: TwwRadioGroup);*)
(*    function ProductPriceCalctypeToInt(Const Value : TProductPriceCalctype):Integer;
    function IntToProductPriceCalctype(Const Value : Integer):TProductPriceCalctype;*)
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetConnectionString(const TransactionMode: boolean = true);Override;
    Procedure SetcontrolProperties(const comp :Tcomponent);Override;
  public
    Class function  DoPartsPriceCalc(AOwner:Tform):Boolean;
    Property ProductPriceCalctype : Integer read getProductPriceCalctype write SetProductPriceCalctype;
  end;


implementation

uses  CommonLib, tcConst, BusObjStock, BusObjConst, AppEnvironment, MAIN, Types;


{$R *.dfm}

procedure TfmPartsPriceCalc.btnCloseClick(Sender: TObject);
begin
  inherited;
  PartsPriceCalc.CancelDB;
  PartsPriceCalc.connection.Rollbacknestedtransaction;
  Self.ModalResult := mrCancel;
end;

procedure TfmPartsPriceCalc.btnCompletedClick(Sender: TObject);
begin
  inherited;
  PartsPriceCalc.PostDB;
  PartsPriceCalc.connection.commitNestedTransaction;
  Self.ModalResult := mrOk;
end;

procedure TfmPartsPriceCalc.DoCalc(Sender: TObject);
var
  Pnl :TDnMPanel;
  chk:Tcheckbox;
  opt:TwwRadioGroup;
  amt:TDBEdit;
  Price:TDBEdit;
  Margin:TDBEdit;
  procedure ReadPanel;
  begin
             if pnl = pnlLatestCost         then begin amt := edtLatestCost       ;opt := OptLatestCostMargin         ;Margin := edtLastCostGrossMarginAmount        ;Price := edtLatestCostPrice        ;chk := chkLatestCost       ;
    end else if pnl = pnlCostPriceInc       then begin amt := edtCostPriceInc     ;Opt := OptCostPriceIncMargin       ;margin := edtAverageCostGrossMarginAmount     ;Price := edtAvgCostPrice           ;chk:= chkAvgCost           ;
    end else if pnl = pnlAvgCost            then begin amt := edtAvgCost          ;Opt := optAvgCostMargin            ;margin := edtProductCostGrossMarginAmount     ;Price := edtCOST1Price             ;chk:= chkCostPriceInc      ;
    end else if pnl = pnlLandedCost         then begin amt := edtLandedCost       ;Opt := OptLandedCostMargin         ;margin := edtLandedCostGrossMarginAmount      ;Price := edtLandedCostPrice        ;chk:= chkLandedCost        ;
    end else if pnl = pnlTotalLandedcost    then begin amt := edtTotalLandedcost  ;Opt := OptTotalLandedcostMargin    ;margin := edtTotalLandedcostGrossMarginAmount ;Price := edtTotalLandedcostPrice   ;chk:= chkTotalLandedcost   ;
    end else if pnl = pnlMancostWithLabour  then begin amt := edtMancostWithLabour;Opt := optMancostWithLabourMargin  ;margin := edtManCostGrossMarginAmount         ;Price := edtMancostWithLabourPrice ;chk:= chkMancostWithLabour ;
    end else if pnl = pnlManLatestCost      then begin amt := edtManLatestCost    ;Opt := optManLatestCostMargin      ;margin := edtManLastCostGrossMarginAmount     ;Price := edtManLatestCostPrice     ;chk:= chkManLatestCost     ;
    end else if pnl = pnlManAvgCost         then begin amt := edtManAvgCost       ;Opt := optManAvgCostMargin         ;margin := edtManAverageCostGrossMarginAmount  ;Price := edtManAvgCostPrice        ;chk:= chkManAvgCost        ;
    end else if pnl = pnlStandard           then begin amt := edtStandardCost     ;Opt := optStandardMode             ;margin := edtOverheadAmount                   ;Price := edtOverheadAmountPrice    ;chk:= chkStandardCost      ;
    end;
  end;
begin
  inherited;
  if not(Sender is TWincontrol) or  not(Assigned(TWincontrol(Sender).parent)) or (not(TWincontrol(Sender).parent is TDnMPanel)) then exit;

  pnl := TDnmPanel(TWincontrol(Sender).parent);
  if not(Assigned(Pnl)) then exit;
  ReadPanel;
  editDb(qryPartsPriceCalc);
  if Opt.ItemIndex =0 then
        qryPartsPriceCalc.FieldByName(Price.DataField).AsFloat :=
          CommonLib.Round(TProduct.calcPricefromMarkup(Amt.DataSource.DataSet.FieldByName(amt.DataField).AsFloat, Margin.DataSource.DataSet.FieldByName(Margin.DataField).AsFloat), tcConst.GeneralRoundPlaces)
  else
        qryPartsPriceCalc.FieldByName(Price.DataField).AsFloat :=
                CommonLib.Round(TProduct.CalcPricefromGross(amt.DataSource.DataSet.FieldByName(amt.DataField).AsFloat, Margin.DataSource.DataSet.FieldByName(Margin.DataField).AsFloat), tcConst.GeneralRoundPlaces);
  PostDB(qryPartsPriceCalc);
end;
class function TfmPartsPriceCalc.DoPartsPriceCalc(AOwner: Tform):Boolean;
var
  Form : TfmPartsPriceCalc;
begin
  result := false;
  Form := TfmPartsPriceCalc(GetComponentByClassName('TfmPartsPriceCalc' , true , AOwner, False , False));
  try
    if form = nil then exit;
    Form.ShowModal;
    REsult := Form.ModalResult = mrOk ;
  finally
    Freeandnil(form);
  end;

end;





procedure TfmPartsPriceCalc.FormCreate(Sender: TObject);
  (*var
  ctr:Integer;

Procedure formatlbl(lbl:TLabel);
  begin
        lbl.Align := altop;
        lbl.AlignWithMargins := true;
        lbl.Margins.Top := 3;
        lbl.Margins.Bottom := 3;
        lbl.Margins.Left := 3;
        lbl.Margins.Right := 3;
        lbl.Alignment := taCenter;
        lbl.Layout := tlCenter;
        lbl.Height := 15;

  end;
  Procedure formatRG(rg:TwwRadioGroup);
  begin
        rg.Align := altop;
        rg.AlignWithMargins := true;
        rg.Margins.Top := 3;
        rg.Margins.Bottom := 3;
        rg.Margins.Left := 3;
        rg.Margins.Right := 3;
        rg.Alignment := taRightJustify;
        rg.Height := 40;
  end;
  Procedure formatDBEdit(edt:TDBEdit; IsReadonly:Boolean);
  begin
    edt.Readonly        := IsReadonly;
    edt.height :=  23;
    edt.Align := altop;
    edt.AlignWithMargins := true;
    edt.Margins.Top := 3;
    edt.Margins.Bottom := 3;
    edt.Margins.Left := 3;
    edt.Margins.Right := 3;
  end;
  Procedure formatchk(chk:TCheckbox; checkboxCaption:String = '');
  begin
      chk.AlignWithMargins := True;
      chk.Height := 17;
      chk.Align := alTop;
      chk.Alignment := taLeftJustify;
      chk.margins.left := 10;
      chk.margins.right := 10;
      if checkboxCaption <> '' then chk.caption :=checkboxCaption;
  end;
  Procedure NewLine(aName:String;ParentPanel:TDnMPanel; aTop:Integer);
  begin
    With TShape.Create(Self) do begin
      name := aName;
      Height := 1;
      Parent := ParentPanel;
      Align := alTop ;
      Top := aTop ;
      Pen.color := clgray;
    end;
  end;*)
function SelectedOptioncolor(const Value:TColor):TColor;
var
  G,R,B:Integer;
begin
  R:= GetRValue(Value);  //R:= R+30;  if R>255 then R := R-255;
  G:= GetGValue(Value);  //G:= G+30;  if G>255 then G := G-255;
  B:= GetBValue(Value);  //B:= B+30;  if B>255 then B := B-255;
  if b <255-30 then b:= b+ 30 else if g< 255-30 then g:= g+30 else if R < 255-30 then r:= r+30 else begin b := b - 30; r:= r-30; g:= g-30; end;
  Result := RGB(R, G, B);
end;
begin
  inherited;
  lblCost.caption := Appenv.RegionalOptions.CurrencySymbol;
  fbUpdatingtoUse:= False;
  CalculatingCostPrice := fAlse;
  Partsform := nil;
  if Assigned(Owner) then
    if owner is TfrmParts then
      PartsForm := TfrmParts(Owner);

  if Partsform <> nil then begin
    qryPartsPriceCalcLatestCost.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcCOST1.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcAvgCost.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcLandedCost.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcTotalLandedcost.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcMancostWithLabour.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcManLatestCost.LookupDataSet := Partsform.qryProduct;
    qryPartsPriceCalcManAvgCost.LookupDataSet := Partsform.qryProduct;
    (*edtLatestCost.DataSource        := Partsform.qryProductDS;
    edtCostPriceInc.DataSource      := Partsform.qryProductDS;
    edtStandardCost.DataSource      := Partsform.qryProductDS;
    edtAvgCost.DataSource           := Partsform.qryProductDS;
    edtLandedCost.DataSource        := Partsform.qryProductDS;
    edtTotalLandedcost.DataSource   := Partsform.qryProductDS;
    edtMancostWithLabour.DataSource := Partsform.qryProductDS;
    edtManLatestCost.DataSource     := Partsform.qryProductDS;
    edtManAvgCost.DataSource        := Partsform.qryProductDS;*)
    Self.Color := (*SelectedOptioncolor(*)Partsform.color;
    qryPartsPriceCalc.connection :=Partsform.qryProduct.connection;
    TransConnection :=TERPConnection(Partsform.qryProduct.connection);
    //qryPartsPriceCalc.Parambyname('PARTSID').asInteger :=Partsform.qryProductPARTSID.AsInteger;
    fiPArtsID:= Partsform.qryProductPARTSID.AsInteger;
  end;
  PartsPriceCalc := TPartsPriceCalc.CreateWithNewConn(Self);
  if TransConnection <> nil then PartsPriceCalc.Connection.connection := TransConnection else PartsPriceCalc.Connection.connection := Self.MyConnection;
  PartsPriceCalc.BusObjEvent := DoBusinessObjectEvent;

(*      for ctr:= 0 to componentcount-1 do begin
          if components[ctr] is TShader then begin
            TShader(components[ctr]).FromColor := color;
            TShader(components[ctr]).TocolorMirror := color;
            TShader(components[ctr]).ToColor := color;
            TShader(components[ctr]).FromcolorMirror := color;
          end else if components[ctr] is TwwRadiogroup then begin
            TwwRadiogroup(components[ctr]).ParentColor := TRue;
            TwwRadiogroup(components[ctr]).Transparent := True;
          end else if components[ctr] is Tcheckbox then begin
          Tcheckbox(components[ctr]).ParentColor := TRue;
          Tcheckbox(components[ctr]).color := self.Color;
          end;
      end;*)


(*  formatDBEdit(edtLatestCost, true);
  formatDBEdit(edtCostPriceInc, true);
  formatDBEdit(edtStandardCost, true);
  formatDBEdit(edtAvgCost, true);
  formatDBEdit(edtLandedCost, true);
  formatDBEdit(edtTotalLandedcost, true);
  formatDBEdit(edtMancostWithLabour, true);
  formatDBEdit(edtManLatestCost, true);
  formatDBEdit(edtManAvgCost, true);

  formatDBEdit(edtOverheadAmount                  , False); edtOverheadAmount.Margins.Top := 39;
  formatDBEdit(edtLastCostGrossMarginAmount       , False);
  formatDBEdit(edtProductCostGrossMarginAmount    , False);
  formatDBEdit(edtAverageCostGrossMarginAmount    , False);
  formatDBEdit(edtManCostGrossMarginAmount        , False);
  formatDBEdit(edtManAverageCostGrossMarginAmount , False);
  formatDBEdit(edtManLastCostGrossMarginAmount    , False);
  formatDBEdit(edtLandedCostGrossMarginAmount     , False);
  formatDBEdit(edtTotalLandedcostGrossMarginAmount, False);

  formatlbl(lblLatestCost);
  formatlbl(lblAvgCost);
  formatlbl(lblAvgCost);
  formatlbl(lblLandedCost);
  formatlbl(lblTotalLandedcost);
  formatlbl(lblMancostWithLabour);
  formatlbl(lblManLatestCost);
  formatlbl(lblManAvgCost);


  formatDBEdit(edtLatestCostPrice, true);
  formatDBEdit(edtCOST1Price, true);
  formatDBEdit(edtAvgCostPrice, true);
  formatDBEdit(edtLandedCostPrice, true);
  formatDBEdit(edtTotalLandedcostPrice, true);
  formatDBEdit(edtMancostWithLabourPrice, true);
  formatDBEdit(edtManLatestCostPrice, true);
  formatDBEdit(edtManAvgCostPrice, true);
  formatDBEdit(edtOverheadAmountPrice, true);

  formatRG(OptLatestCostMargin);
  formatRG(OptCostPriceIncMargin);
  formatRG(OptAvgCostMargin);
  formatRG(OptLandedCostMargin);
  formatRG(OptTotalLandedcostMargin);
  formatRG(OptMancostWithLabourMargin);
  formatRG(OptManLatestCostMargin);
  formatRG(OptManAvgCostMargin);


  formatchk(chkLatestCost, 'Use ?');
  formatchk(chkCostPriceInc, 'Use ?');
  formatchk(chkAvgCost, 'Use ?');
  formatchk(chkLandedCost, 'Use ?');
  formatchk(chkLandedCost, 'Use ?');
  formatchk(chkMancostWithLabour, 'Use ?');
  formatchk(chkManLatestCost, 'Use ?');
  formatchk(chkManAvgCost, 'Use ?');

  formatlbl(lblItems);   lblItems.Height  := lblLatestCost.Height;
  formatlbl(lblCost);    lblCost.Height   := edtLatestCost.Height;
  formatlbl(lblMargin);  lblMargin.Height := OptLatestCostMargin.Height;;
  formatlbl(lblMarginAmt);  lblMarginAmt.Height := edtLastCostGrossMarginAmount.Height;;
  formatlbl(lblPrice);   lblPrice.Height  := edtLatestCostPrice.Height;;

  NewLine('shp'+pnlLatestCost.Name+'0',pnlLatestCost,lblLatestCost.Top);
  NewLine('shp'+pnlLatestCost.Name+'1',pnlLatestCost,edtLatestCost.Top);
  //NewLine('shp'+pnlLatestCost.Name+'2',pnlLatestCost,OptLatestCostMargin.Top);
  NewLine('shp'+pnlLatestCost.Name+'2',pnlLatestCost,edtLastCostGrossMarginAmount.Top);
  NewLine('shp'+pnlLatestCost.Name+'3',pnlLatestCost,edtLatestCostPrice.Top );
  //NewLine('shp'+pnlLatestCost.Name+'4',pnlLatestCost,chkLatestCost.Top);

  NewLine('shp'+pnlCostPriceInc.Name+'0',pnlCostPriceInc,lblCostPriceInc.Top);
  NewLine('shp'+pnlCostPriceInc.Name+'1',pnlCostPriceInc,edtCostPriceInc.Top);
  //NewLine('shp'+pnlCostPriceInc.Name+'2',pnlCostPriceInc,OptCostPriceIncMargin.Top);
  NewLine('shp'+pnlCostPriceInc.Name+'2',pnlCostPriceInc,edtProductCostGrossMarginAmount.Top);
  NewLine('shp'+pnlCostPriceInc.Name+'3',pnlCostPriceInc,edtCOST1Price.Top );
  //NewLine('shp'+pnlCostPriceInc.Name+'4',pnlCostPriceInc,chkCostPriceInc.Top);

  NewLine('shp'+pnlAvgCost.Name+'0',pnlAvgCost,lblAvgCost.Top);
  NewLine('shp'+pnlAvgCost.Name+'1',pnlAvgCost,edtAvgCost.Top);
  //NewLine('shp'+pnlAvgCost.Name+'2',pnlAvgCost,OptAvgCostMargin.Top);
  NewLine('shp'+pnlAvgCost.Name+'2',pnlAvgCost,edtAverageCostGrossMarginAmount.Top);
  NewLine('shp'+pnlAvgCost.Name+'3',pnlAvgCost,edtAvgCostPrice.Top );
  //NewLine('shp'+pnlAvgCost.Name+'4',pnlAvgCost,chkAvgCost.Top);

  NewLine('shp'+pnlLandedCost.Name+'0',pnlLandedCost,lblLandedCost.Top);
  NewLine('shp'+pnlLandedCost.Name+'1',pnlLandedCost,edtLandedCost.Top);
  //NewLine('shp'+pnlLandedCost.Name+'2',pnlLandedCost,OptLandedCostMargin.Top);
  NewLine('shp'+pnlLandedCost.Name+'2',pnlLandedCost,edtManCostGrossMarginAmount.Top);
  NewLine('shp'+pnlLandedCost.Name+'3',pnlLandedCost,edtLandedCostPrice.Top );
  //NewLine('shp'+pnlLandedCost.Name+'4',pnlLandedCost,chkLandedCost.Top);

  NewLine('shp'+pnlTotalLandedcost.Name+'0',pnlTotalLandedcost,lblTotalLandedcost.Top);
  NewLine('shp'+pnlTotalLandedcost.Name+'1',pnlTotalLandedcost,edtTotalLandedcost.Top);
  //NewLine('shp'+pnlTotalLandedcost.Name+'2',pnlTotalLandedcost,OptTotalLandedcostMargin.Top);
  NewLine('shp'+pnlTotalLandedcost.Name+'2',pnlTotalLandedcost,edtManCostGrossMarginAmount.Top);
  NewLine('shp'+pnlTotalLandedcost.Name+'3',pnlTotalLandedcost,edtTotalLandedcostPrice.Top );
  //NewLine('shp'+pnlTotalLandedcost.Name+'4',pnlTotalLandedcost,chkTotalLandedcost.Top);

  NewLine('shp'+pnlMancostWithLabour.Name +'0',pnlMancostWithLabour,lblMancostWithLabour.Top);
  NewLine('shp'+pnlMancostWithLabour.Name +'1',pnlMancostWithLabour,edtMancostWithLabour.Top);
  //NewLine('shp'+pnlMancostWithLabour.Name +'2',pnlMancostWithLabour,OptMancostWithLabourMargin.Top);
  NewLine('shp'+pnlMancostWithLabour.Name +'2',pnlMancostWithLabour,edtManAverageCostGrossMarginAmount.Top);
  NewLine('shp'+pnlMancostWithLabour.Name +'3',pnlMancostWithLabour,edtMancostWithLabourPrice.Top );
  //NewLine('shp'+pnlMancostWithLabour.Name +'4',pnlMancostWithLabour,chkMancostWithLabour.Top);

  NewLine('shp'+pnlManLatestCost.Name +'0',pnlManLatestCost,lblManLatestCost.Top);
  NewLine('shp'+pnlManLatestCost.Name +'1',pnlManLatestCost,edtManLatestCost.Top);
  //NewLine('shp'+pnlManLatestCost.Name +'2',pnlManLatestCost,OptManLatestCostMargin.Top);
  NewLine('shp'+pnlManLatestCost.Name +'2',pnlManLatestCost,edtManLastCostGrossMarginAmount.Top);
  NewLine('shp'+pnlManLatestCost.Name +'3',pnlManLatestCost,edtManLatestCostPrice.Top );
  //NewLine('shp'+pnlManLatestCost.Name +'4',pnlManLatestCost,chkManLatestCost.Top);

  NewLine('shp'+pnlManAvgCost.Name +'0',pnlManAvgCost,lblManAvgCost.Top);
  NewLine('shp'+pnlManAvgCost.Name +'1',pnlManAvgCost,edtManAvgCost.Top);
  //NewLine('shp'+pnlManAvgCost.Name +'2',pnlManAvgCost,OptManAvgCostMargin.Top);
  NewLine('shp'+pnlManAvgCost.Name +'2',pnlManAvgCost,edtLandedCostGrossMarginAmount.Top);
  NewLine('shp'+pnlManAvgCost.Name +'2',pnlManAvgCost,edtTotalLandedcostGrossMarginAmount.Top);
  NewLine('shp'+pnlManAvgCost.Name +'3',pnlManAvgCost,edtManAvgCostPrice.Top );
  //NewLine('shp'+pnlManAvgCost.Name +'4',pnlManAvgCost,chkManAvgCost.Top);

  NewLine('shp'+pnlLeft.Name +'0',pnlLeft,lblItems.Top);
  NewLine('shp'+pnlLeft.Name +'1',pnlLeft,lblCost.Top);
  NewLine('shp'+pnlLeft.Name +'2',pnlLeft,lblMarginAmt.Top);
  NewLine('shp'+pnlLeft.Name +'3',pnlLeft,lblPrice.Top);
  //NewLine('shp'+pnlLeft.Name +'4',pnlLeft,lblPrice.Top+lblPrice.height);

  NewLine('shp'+pnlStandard.Name +'0',pnlStandard,lblStandard.Top);
  NewLine('shp'+pnlStandard.Name +'1',pnlStandard,edtStandardCost.Top);
  NewLine('shp'+pnlStandard.Name +'2',pnlStandard,edtOverheadAmountPrice.Top);
  NewLine('shp'+pnlStandard.Name +'3',pnlStandard,chkStandardCost.Top);*)
end;

procedure TfmPartsPriceCalc.FormShow(Sender: TObject);
var
  CurPos:TPoint;
begin
  inherited;
  PartsPriceCalc.LoadSelect('PartsID =' + inttostr(fiPArtsID));
  PartsPriceCalc.connection.BeginTransaction;
  PartsPriceCalc.connection.BeginnestedTransaction;
  if PartsPriceCalc.count=0 then begin
    PartsPriceCalc.new;
    PartsPriceCalc.PartsId :=fiPArtsID;
    PartsPriceCalc.PostDB;
  end;
  openQueries;
  ProductPriceCalctype := PartsPriceCalc.ProductPriceCalctype;
  if assigned(PartsForm) then begin
      CurPos:= Partsform.btnPriceCalc.ClientToScreen(Point(1,1));
      top := CurPos.y -1  (*+ Partsform.btnPriceCalc.height*);
(*      Left := ((mainform.Left+4) +  Partsform.Left +  Partsform.Pagecontrol.Left + Partsform.Pagecontrol.Margins.left)+2;
      Width :=Partsform.Pagecontrol.Width;*)
  end;

end;

function TfmPartsPriceCalc.getProductPriceCalctype: Integer;
begin
       if chkLatestCost.Checked         then result := ppctLatestcost
  else if chkCostPriceInc.Checked       then result := ppctProductcost
  else if chkAvgCost.Checked            then result := ppctAverageCost
  else if chkLandedCost.Checked         then result := ppctLandedcost
  else if chkTotalLandedcost.Checked    then result := ppctTotalLandedcost
  else if chkMancostWithLabour.Checked  then result := ppctManCost
  else if chkManLatestCost.Checked      then result := ppctManLatestcost
  else if chkManAvgCost.Checked         then result := ppctManAverageCost
  else if chkStandardCost.Checked       then result := ppctStandard
  else result := ppctNone;
end;


(*function TfmPartsPriceCalc.IntToProductPriceCalctype(
  const Value: Integer): TProductPriceCalctype;
begin
       if Value = 1 then Result := ppctLatestcost
  else if Value = 2 then Result := ppctProductcost
  else if Value = 3 then Result := ppctAverageCost
  else if Value = 4 then Result := ppctLandedcost
  else if Value = 4 then Result := ppctTotalLandedcost
  else if Value = 5 then Result := ppctManCost
  else if Value = 6 then Result := ppctManLatestcost
  else if Value = 7 then Result := ppctManAverageCost
  else if Value = 8 then Result := ppctStandard
  else result := ppctNone;

end;*)

procedure TfmPartsPriceCalc.OnUseSelect(Sender: TObject);
(*Procedure ChangeColor(chk:TCheckbox;Shader:TShader);
begin
  if chk.Checked then begin
            shader.ToColor := SelectedOptioncolor;
            shader.FromcolorMirror := SelectedOptioncolor;
  end else begin
            shader.ToColor := color;
            shader.FromcolorMirror := color;
  end;
  shader.invalidate;
end;*)
begin
  inherited;
  if fbUpdatingtoUse then exit;
  if Sender is TCheckBox then  begin
    //if screen.ActiveControl = Tcheckbox(Sender) then begin
      fbUpdatingtoUse:= True;
      try
        if Tcheckbox(Sender).Checked then begin
          chkLatestCost.Checked       := (Tcheckbox(Sender) =chkLatestCost        ) and (Tcheckbox(Sender).Checked);
          chkCostPriceInc.Checked     := (Tcheckbox(Sender) =chkCostPriceInc      ) and (Tcheckbox(Sender).Checked);
          chkAvgCost.Checked          := (Tcheckbox(Sender) =chkAvgCost           ) and (Tcheckbox(Sender).Checked);
          chkLandedCost.Checked       := (Tcheckbox(Sender) =chkLandedCost        ) and (Tcheckbox(Sender).Checked);
          chkTotalLandedcost.Checked  := (Tcheckbox(Sender) =chkTotalLandedcost   ) and (Tcheckbox(Sender).Checked);
          chkMancostWithLabour.Checked:= (Tcheckbox(Sender) =chkMancostWithLabour ) and (Tcheckbox(Sender).Checked);
          chkManLatestCost.Checked    := (Tcheckbox(Sender) =chkManLatestCost     ) and (Tcheckbox(Sender).Checked);
          chkManAvgCost.Checked       := (Tcheckbox(Sender) =chkManAvgCost        ) and (Tcheckbox(Sender).Checked);
          chkStandardCost.Checked     := (Tcheckbox(Sender) =chkStandardCost      ) and (Tcheckbox(Sender).Checked);
        end;

        if chkLatestCost.Checked        then pnlLatestCost.color        := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlLatestCost.color        :=Self.color;
        if chkCostPriceInc.Checked      then pnlCostPriceInc.color      := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlCostPriceInc.color      :=Self.color;
        if chkAvgCost.Checked           then pnlAvgCost.color           := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlAvgCost.color           :=Self.color;
        if chkLandedCost.Checked        then pnlLandedCost.color        := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlLandedCost.color        :=Self.color;
        if chkTotalLandedcost.Checked   then pnlTotalLandedcost.color   := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlTotalLandedcost.color   :=Self.color;
        if chkMancostWithLabour.Checked then pnlMancostWithLabour.color := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlMancostWithLabour.color :=Self.color;
        if chkManLatestCost.Checked     then pnlManLatestCost.color     := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlManLatestCost.color     :=Self.color;
        if chkManAvgCost.Checked        then pnlManAvgCost.color        := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlManAvgCost.color        :=Self.color;
        if chkStandardCost.Checked      then pnlStandard.color          := Partsform.color(*SelectedOptioncolor(Self.color)*) else pnlStandard.color          :=Self.color;
        PartsPriceCalc.ProductPriceCalctype := ProductPriceCalctype;
(*        ChangeColor(chkLatestCost        , pnlLatestCost        );
        ChangeColor(chkCostPriceInc      , pnlCostPriceInc      );
        ChangeColor(chkAvgCost           , pnlAvgCost           );
        ChangeColor(chkLandedCost        , pnlLandedCost        );
        ChangeColor(chkTotalLandedcost   , pnlTotalLandedcost   );
        ChangeColor(chkMancostWithLabour , pnlMancostWithLabour );
        ChangeColor(chkManLatestCost     , pnlManLatestCost     );
        ChangeColor(chkManAvgCost        , pnlManAvgCost        );
        ChangeColor(chkStandardCost      , pnlStandard          );*)


      finally
        fbUpdatingtoUse := False;
      end;
    //end;
  end;
end;



procedure TfmPartsPriceCalc.optAvgCostMarginChange          (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctAverageCost     ;end;
procedure TfmPartsPriceCalc.OptCostPriceIncMarginChange     (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctProductcost     ;end;
procedure TfmPartsPriceCalc.OptLandedCostMarginChange       (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctLandedcost      ;end;
procedure TfmPartsPriceCalc.OptTotalLandedcostMarginChange  (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctTotalLandedcost ;end;
procedure TfmPartsPriceCalc.OptLatestCostMarginChange       (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctLatestcost      ;end;
procedure TfmPartsPriceCalc.optManAvgCostMarginChange       (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctManAverageCost  ;end;
procedure TfmPartsPriceCalc.optMancostWithLabourMarginChange(Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctManCost         ;end;
procedure TfmPartsPriceCalc.optManLatestCostMarginChange    (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctManLatestcost   ;end;
procedure TfmPartsPriceCalc.optStandardModeChange           (Sender: TObject);begin  inherited;  if not IsFormshown then exit;if ProductPriceCalctype = ppctNone then ProductPriceCalctype:= ppctStandard        ;end;


(*function TfmPartsPriceCalc.ProductPriceCalctypeToInt(const Value: TProductPriceCalctype): Integer;
begin
       if Value = ppctLatestcost      then result := 1
  else if Value = ppctProductcost     then result := 2
  else if Value = ppctAverageCost     then result := 3
  else if Value = ppctLandedcost      then result := 4
  else if Value = ppctTotalLandedcost then result := 4
  else if Value = ppctManCost         then result := 5
  else if Value = ppctManLatestcost   then result := 6
  else if Value = ppctManAverageCost  then result := 7
  else if Value = ppctStandard        then result := 8
  else result := 0;
end;*)

(*procedure TfmPartsPriceCalc.CalcPrice(edtCost, edtPrice,edtPercent:TDBEdit; Opt:TwwRadioGroup);
begin
  //if (screen.ActiveControl <> edtcost) and (screen.ActiveControl <> opt ) then exit;
  if CalculatingCostPrice then exit;
  CalculatingCostPrice:= True;
  try
      if edtCost.DataSource.DataSet.FieldByName(edtCost.DataField).AsFloat <> 0 then begin
        EditDB(qryPartsPriceCalc);
        if Opt.ItemIndex =0 then
        qryPartsPriceCalc.FieldByName(edtPrice.DataField).AsFloat :=
          CommonLib.Round(TProduct.calcPricefromMarkup(edtCost.DataSource.DataSet.FieldByName(edtCost.DataField).AsFloat, edtPercent.DataSource.DataSet.FieldByName(edtPercent.DataField).AsFloat), tcConst.GeneralRoundPlaces)
        else
        qryPartsPriceCalc.FieldByName(edtPrice.DataField).AsFloat :=
                CommonLib.Round(TProduct.CalcPricefromGross(edtCost.DataSource.DataSet.FieldByName(edtCost.DataField).AsFloat, edtPercent.DataSource.DataSet.FieldByName(edtPercent.DataField).AsFloat), tcConst.GeneralRoundPlaces);
        PostDB(qryPartsPriceCalc);
      end;
  finally
    CalculatingCostPrice := False;
  end;
end;*)

procedure TfmPartsPriceCalc.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPartsPriceCalc then TPartsPriceCalc(Sender).Dataset  := qryPartsPriceCalc;
  end else if (Eventtype = BusObjEvent_Change) then begin
    if Value = BusobjEventVal_GrossMarginFixed then begin
(*      Sender.PostDb;
      Application.ProcessMessages;*)
      TimerMsg(lblMsg, 'Goss margin should be less than 100, Changed to 99' );
    end else if Partsform <> nil then begin
      if value =BusobjEventVal_ProductPriceCalctype then begin
                 if PartsPriceCalc.ProductPriceCalctype =   ppctLatestcost    then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.LatestCostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctProductcost   then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.COST1Price;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctAverageCost   then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.AvgCostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctLandedcost    then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.LandedCostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctTotalLandedcost    then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.TotalLandedcostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctManCost       then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.MancostWithLabourPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctManLatestcost then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.ManLatestCostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctManAverageCost then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.ManAvgCostPrice;
        end else if PartsPriceCalc.ProductPriceCalctype =   ppctStandard      then begin
                    PartsForm.ProductMarkupPrice := PartsPriceCalc.OverheadAmountPrice;
        end;
      (*end else if (Value =  BusobjEventVal_AvgCostPrice               ) then begin
      end else if (Value =  BusobjEventVal_COST1Price                 ) then begin
      end else if (Value =  BusobjEventVal_LandedCostPrice            ) then begin
      end else if (Value =  BusobjEventVal_TotalLandedcostPrice       ) then begin
      end else if (Value =  BusobjEventVal_LatestCostPrice            ) then begin
      end else if (Value =  BusobjEventVal_ManAvgCostPrice            ) then begin
      end else if (Value =  BusobjEventVal_MancostWithLabourPrice     ) then begin
      end else if (Value =  BusobjEventVal_ManLatestCostPrice         ) then begin
      end else if (Value =  BusobjEventVal_OverheadAmountPrice        ) then begin*)
      end;
    end;
  end;
end;

procedure TfmPartsPriceCalc.SetConnectionString(const TransactionMode: boolean);
begin
  inherited;
  if TransConnection <> nil then begin
    PartsPriceCalc.Connection.connection := TransConnection ;
    qryPartsPriceCalc.connection:= TransConnection ;
  end;
end;

procedure TfmPartsPriceCalc.SetcontrolProperties(const comp: Tcomponent);
begin
  inherited;
  if comp is TAdvScrollBox then begin
    TAdvScrollBox(comp).color := TabColor;
  end;
end;

procedure TfmPartsPriceCalc.SetProductPriceCalctype(const Value: Integer);
begin
  chkLatestCost.Checked       := Value = ppctLatestcost;
  chkCostPriceInc.Checked     := Value = ppctProductcost;
  chkAvgCost.Checked          := Value = ppctAverageCost;
  chkLandedCost.Checked       := Value = ppctLandedcost;
  chkTotalLandedcost.Checked  := Value = ppctTotalLandedcost;
  chkMancostWithLabour.Checked:= Value = ppctManCost;
  chkManLatestCost.Checked    := Value = ppctManLatestcost;
  chkManAvgCost.Checked       := Value = ppctManAverageCost;
  chkStandardCost.Checked     := Value = ppctStandard;
  Invalidate;
  Application.ProcessMessages;
end;
procedure TfmPartsPriceCalc.edtStandardCostEnter      (Sender: TObject);begin  inherited;  (*Setcontrolfocus(optStandardMode)           ;*)end;
procedure TfmPartsPriceCalc.edtManAvgCostEnter        (Sender: TObject);begin  inherited;  (*Setcontrolfocus(optManAvgCostMargin)       ;*)end;
procedure TfmPartsPriceCalc.edtMancostWithLabourEnter (Sender: TObject);begin  inherited;  (*Setcontrolfocus(optMancostWithLabourMargin);*)end;
procedure TfmPartsPriceCalc.edtManLatestCostEnter     (Sender: TObject);begin  inherited;  (*Setcontrolfocus(optManLatestCostMargin)    ;*)end;
procedure TfmPartsPriceCalc.edtLandedcostEnter        (Sender: TObject);begin  inherited;  (*Setcontrolfocus(OptLandedCostMargin)       ;*)end;
procedure TfmPartsPriceCalc.edtTotalLandedcostEnter   (Sender: TObject);begin  inherited;  (*Setcontrolfocus(OptTotalLandedcostMargin)  ;*)end;
procedure TfmPartsPriceCalc.edtLatestCostEnter        (Sender: TObject);begin  inherited;  (*Setcontrolfocus(OptLatestCostMargin)       ;*)end;
procedure TfmPartsPriceCalc.edtAvgCostEnter           (Sender: TObject);begin  inherited;  (*Setcontrolfocus(optAvgCostMargin)          ;*)end;
procedure TfmPartsPriceCalc.edtCostPriceIncEnter      (Sender: TObject);begin  inherited;  (*Setcontrolfocus(OptCostPriceIncMargin)     ;*)end;

(*procedure TfmPartsPriceCalc.CalcOnLatestcost         (Sender: TField);begin  inherited;  CalcPrice(edtLatestCost   , edtLatestCostPrice,edtLastCostGrossMarginAmount   ,OptLatestCostMargin  );end;
procedure TfmPartsPriceCalc.CalcOnProductcostchange    (Sender: TField);begin  inherited;  CalcPrice(edtCostPriceInc , edtCOST1Price     ,edtProductCostGrossMarginAmount,OptCostPriceIncMargin);end;
procedure TfmPartsPriceCalc.CalcOnAvgcostChange        (Sender: TField);begin  inherited;  CalcPrice(edtAvgCost      , edtAvgCostPrice   ,edtAverageCostGrossMarginAmount,optAvgCostMargin     );end;
procedure TfmPartsPriceCalc.CalcOnLandedcostChange     (Sender: TField);begin  inherited;  CalcPrice(edtLandedCost , edtLandedCostPrice     ,edtLandedCostGrossMarginAmount,OptLandedCostMargin);end;
procedure TfmPartsPriceCalc.CalcOnTotalLandedcostChange(Sender: TField);begin  inherited;  CalcPrice(edtTotalLandedcost , edtTotalLandedcostPrice     ,edtTotalLandedcostGrossMarginAmount,OptTotalLandedcostMargin);end;
procedure TfmPartsPriceCalc.CalcOnManAvgcostChange     (Sender: TField);begin  inherited; CalcPrice(edtManAvgCost   , edtManAvgCostPrice,edtManAverageCostGrossMarginAmount   ,optManAvgCostMargin  );end;
procedure TfmPartsPriceCalc.CalcOnMancostChange        (Sender: TField);begin  inherited; CalcPrice(edtMancostWithLabour   , edtMancostWithLabourPrice,edtManCostGrossMarginAmount   ,optMancostWithLabourMargin  );end;
procedure TfmPartsPriceCalc.CalcOnManLastcostChange    (Sender: TField);begin  inherited; CalcPrice(edtManLatestCost   , edtManLatestCostPrice,edtManLastCostGrossMarginAmount   ,optManAvgCostMargin  );end;*)
(*procedure TfmPartsPriceCalc.OnStandardAmtchange(Sender: TField);
begin
  inherited;
  //if (screen.ActiveControl <> optStandardMode) and (screen.ActiveControl <> edtOverheadAmount ) then exit;
  EditDB(qryPartsPriceCalc);
  if optStandardMode.ItemIndex =1 then begin
    qryPartsPriceCalc.FieldByName(edtOverheadAmountPrice.DataField).AsFloat :=
      CommonLib.Round(edtStandardCost.DataSource.DataSet.FieldByName(edtStandardCost.DataField).AsFloat +  edtOverheadAmount.DataSource.DataSet.FieldByName(edtOverheadAmount.DataField).AsFloat, tcConst.GeneralRoundPlaces);
  end else begin
    CalcPrice(edtStandardCost   , edtOverheadAmountPrice,edtOverheadAmount   ,optStandardMode  );
  end;
end;*)

initialization
  RegisterClassOnce(TfmPartsPriceCalc);

end.
