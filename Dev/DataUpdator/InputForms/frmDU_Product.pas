unit frmDU_Product;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls,frmDU_base, wwcheckbox, Mask, DBCtrls,
  wwdblook, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, Shader, Grids,
  Wwdbigrd, Wwdbgrid, Menus, Spin, DNMSpeedButton, DateUtils, CheckComboBox;

type

  TfmDU_Product = class(TfmDU_base)
    qryUOM2: TERPQuery;
    qrycboUnitOfMeasure: TERPQuery;
    qrycboUnitOfMeasureUnitName: TWideStringField;
    qrycboUnitOfMeasureUnitID: TAutoIncField;
    qrycboUnitOfMeasureUnitDescription: TWideStringField;
    optcostOption: TRadioGroup;
    optcosttype: TRadioGroup;
    edtcostAmt: TLabeledEdit;
    OptActive: TRadioGroup;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    edtUnit: TwwDBLookupCombo;
    edtDesc: TEdit;
    cboUnitOfMeasure: TwwDBLookupCombo;
    chkSalesDefault: TwwCheckBox;
    chkPurchDefault: TwwCheckBox;
    optBatch: TRadioGroup;
    pnlcost: TDNMPanel;
    pnlReorderpoint: TDNMPanel;
    pnlActive: TDNMPanel;
    pnlSalesDefault: TDNMPanel;
    chkcost: TCheckBox;
    chkUOM: TCheckBox;
    chkActive: TCheckBox;
    chkbatch: TCheckBox;
    sbmain: TScrollBox;
    edMultiplier: TEdit;
    Label2: TLabel;
    chkprice: TCheckBox;
    optpriceOption: TRadioGroup;
    optPricetype: TRadioGroup;
    edtPriceAmt: TLabeledEdit;
    pnlUpdateSupplier: TDNMPanel;
    chkPreferedSupplier: TCheckBox;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    cboSupp: TwwDBLookupCombo;
    Label6: TLabel;
    Label7: TLabel;
    edtSupplierProductCode: TEdit;
    pnlLinkDepartment: TDNMPanel;
    chkClasses: TCheckBox;
    QryClasses: TERPQuery;
    grdClasses: TwwDBGrid;
    dsClasses: TDataSource;
    MyConnection: TERPConnection;
    QryClassesclassId: TIntegerField;
    QryClassesclassname: TWideStringField;
    OptPriceBasedon: TRadioGroup;
    btnReorderPoint: TDNMSpeedButton;
    btnPreferredLevel: TDNMSpeedButton;
    btnReorderAmount: TDNMSpeedButton;
    spReorderPoint: TSpinEdit;
    spPreferredLevel: TSpinEdit;
    spReorderAmount: TSpinEdit;
    cbRounding: TComboBox;
    lblRounding: TLabel;
    chkDoRound: TCheckBox;
    chkAllMonths: TCheckBox;
    cbMonth: TCheckComboBox;
    chkAdjustReorderPoints: TCheckBox;
    chkbin: TCheckBox;
    optbin: TRadioGroup;
    chksn: TCheckBox;
    optSN: TRadioGroup;
    DNMPanel1: TDNMPanel;
    lblAllocationhint: TLabel;
    pnlUpdateWithPurchaseCost: TDNMPanel;
    chkUpdateWithPurchaseCost: TCheckBox;
    OptUpdateWithPurchaseCost: TRadioGroup;
    procedure FlagtoUpdate(Sender: TObject);
    procedure btnReorderPointClick(Sender: TObject);
    procedure btnPreferredLevelClick(Sender: TObject);
    procedure btnReorderAmountClick(Sender: TObject);
    procedure chkDoRoundClick(Sender: TObject);
    procedure chkAllMonthsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
//  private
//    fReorderForm: TProductForecastGui;


  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    procedure SetLimits(btn : TDNMSpeedButton; sp : TSpinEdit);
    function Percentage(btn : TDNMSpeedButton) : boolean;
  published
  published
  public
    constructor Create(AOqner : TComponent); override;
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
  end;


implementation

uses CommonLib, AppEnvironment, tcConst;

{$R *.dfm}

{ TfmDU_Product }

class function TfmDU_Product.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_Product.create(AOwner);
  inherited;
end;

procedure TfmDU_Product.btnPreferredLevelClick(Sender: TObject);
begin
  if Percentage(btnPreferredLevel) then
    btnPreferredLevel.Caption := 'PreferredLevel Value'
  else
    btnPreferredLevel.Caption := 'PreferredLevel  %';
    SetLimits(btnPreferredLevel, spPreferredLevel);
end;

procedure TfmDU_Product.btnReorderAmountClick(Sender: TObject);
begin
  if Percentage(btnReorderAmount)then
  begin
    btnReorderAmount.Caption := 'ReorderAmount Value'
  end
  else
  begin
    btnReorderAmount.Caption := 'ReorderAmount %';
  end;
  SetLimits(btnReorderAmount, spReorderAmount);
end;

procedure TfmDU_Product.btnReorderPointClick(Sender: TObject);
begin
  if Percentage(btnReorderPoint) then
    btnReorderPoint.Caption := 'ReorderPoint Value'
  else
    btnReorderPoint.Caption := 'ReorderPoint     %';
  SetLimits(btnReorderPoint, spReorderPoint);
end;

procedure TfmDU_Product.chkAllMonthsClick(Sender: TObject);
begin
  inherited;
  if chkAllMonths.Checked then
  begin
    chkAllMonths.Caption := 'Adjust For All Months';
    cbMonth.ItemIndex := 0;
    cbMonth.Enabled := false;
  end
  else
  begin
    chkAllMonths.Caption := 'Adjust For Selected Months';
    cbMonth.ItemIndex := 0;
    cbMonth.Enabled := True;
  end;
end;

procedure TfmDU_Product.chkDoRoundClick(Sender: TObject);
begin
  cbRounding.Enabled := chkDoRound.Checked;
end;

constructor TfmDU_Product.Create(AOqner: TComponent);
var
  idx : integer;
begin
  inherited;
  cbRounding.Items.Clear;
  for idx := 0 to 8 do
    if csRounding[idx] = 0 then
      cbRounding.Items.Add('0 : No Rounding')
    else
      cbRounding.Items.Add(IntToStr(csRounding[idx]));


  chkDoRound.Checked := AppEnv.CompanyPrefs.ProductReorderRoundNearest;
  if AppEnv.CompanyPrefs.ProductReorderRoundNearest then
  begin
    cbRounding.ItemIndex := cbRounding.Items.IndexOf(IntToStr(AppEnv.CompanyPrefs.ProductReorderRoundValue));
    if cbRounding.ItemIndex = -1 then
      cbRounding.ItemIndex := 4;
  end
  else
  begin
    cbRounding.ItemIndex := 4;
    cbRounding.Enabled := false;
  end;

  cbMonth.Items.Clear;
  cbMonth.Items.Add('-- ALL --');
  for idx := 1 to 12 do
    cbMonth.Items.Add(FormatSettings.LongMonthNames[idx]);
  cbMonth.ItemIndex := MonthOf(incMonth(date,1)) - 1;

  chkAllMonths.Checked := true;
end;

procedure TfmDU_Product.FlagtoUpdate(Sender: TObject);
begin
  inherited;
       if (sender = edtUnit             ) or (Sender = edtDesc            ) or (Sender = edMultiplier   ) OR (Sender = cboUnitOfMeasure ) OR (Sender = chkPurchDefault) OR (Sender =chkSalesDefault) then chkUOM.Checked:= true
  else if (sender = optcostOption       ) or (Sender = optcosttype        ) or (Sender = edtcostAmt     ) then chkcost.Checked        := true
  else if (sender = optpriceOption      ) or (Sender = optPricetype       ) or (Sender = edtPriceAmt    ) then chkprice.Checked       := true
  else if (sender = optBatch            ) then chkbatch.Checked := true
  else if (sender = optbin              ) then chkbin.Checked   := true
  else if (sender = optSN               ) then chksn.Checked    := true
  else if (sender = OptActive           ) then chkActive.Checked:= true
  else if (sender = OptUpdateWithPurchaseCost) then chkUpdateWithPurchaseCost.Checked:= true;

end;

procedure TfmDU_Product.FormCreate(Sender: TObject);
begin
  inherited;
  lblAllocationhint.caption := 'Once the Product has Serial No''s / Batches / Bins already allocated,'+NL+
                               'You Can Only Turn OFF Batch / Bin / SN Tracking,'+NL+
                               'Based on the Company Preference : Inventory ->Allow Changing Product Allocation Flags.'+NL+NL+
                               'It is not Possible to Turn it back ON.'

end;

class function TfmDU_Product.MakeInstance(AOwner: TComponent;  ParentPanel: TDNMPanel): TfmDU_base;
begin
    result:= inherited MakeInstance(AOwner,ParentPanel);
end;



function TfmDU_Product.Percentage(btn: TDNMSpeedButton): boolean;
begin
  Result := pos('%', btn.Caption) > 0;
end;

procedure TfmDU_Product.SetLimits(btn: TDNMSpeedButton; sp: TSpinEdit);
begin
  if Percentage(btn) then
  begin
    sp.MinValue := -100;
    sp.MaxValue := 100;
  end
  else
  begin
    sp.MinValue := 0;
    sp.MaxValue := 0;
  end;
end;

initialization
  RegisterClassOnce(TfmDU_Product);

end.

