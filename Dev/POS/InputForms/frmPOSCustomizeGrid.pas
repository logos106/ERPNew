unit frmPOSCustomizeGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, StdCtrls,
  Menus, SelectionDialog;

type
  TfmPOSCustomizeGrid = class(TBaseForm)
    GroupBox1: TGroupBox;
    chkproductdesc: TCheckBox;
    chkproductname: TCheckBox;
    chkunitprice: TCheckBox;
    chkQty: TCheckBox;
    chkamount: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    chkProfitPercent: TCheckBox;
    chkProfitDollar: TCheckBox;
    procedure btnOkClick(Sender: TObject);
  private
    function getAmountVisible: Boolean;
    function getProductdescVisible: Boolean;
    function getProductNameVisible: Boolean;
    function getQtyVisible: Boolean;
    function getUnitPriceVisible: Boolean;
    procedure setAmountVisible(const Value: Boolean);
    procedure setProductdescVisible(const Value: Boolean);
    procedure setProductNameVisible(const Value: Boolean);
    procedure setQtyVisible(const Value: Boolean);
    procedure setUnitPriceVisible(const Value: Boolean);
    function getProfitDollarVisible: boolean;
    function getProfitPercentVisible: boolean;
    procedure setProfitDollarVisible(const Value: boolean);
    procedure setProfitPercentVisible(const Value: boolean);
  public
    Property QtyVisible         :Boolean read getQtyVisible         write setQtyVisible;
    Property ProductNameVisible :Boolean read getProductNameVisible write setProductNameVisible;
    Property ProductdescVisible :Boolean read getProductdescVisible write setProductdescVisible;
    Property UnitPriceVisible   :Boolean read getUnitPriceVisible   write setUnitPriceVisible;
    Property AmountVisible      :Boolean read getAmountVisible      write setAmountVisible;
    property ProfitPercentVisible: boolean read getProfitPercentVisible write setProfitPercentVisible;
    property ProfitDollarVisible : boolean read getProfitDollarVisible write setProfitDollarVisible;

  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TfmPOSCustomizeGrid }

function TfmPOSCustomizeGrid.getqtyVisible        : Boolean;begin result := chkQty.Checked          ;end;
function TfmPOSCustomizeGrid.getProductNameVisible: Boolean;begin result := chkProductName.Checked  ;end;
function TfmPOSCustomizeGrid.getProfitDollarVisible: boolean;
begin
  Result := chkProfitDollar.Checked;
end;

function TfmPOSCustomizeGrid.getProfitPercentVisible: boolean;
begin
  Result := chkProfitPercent.Checked;
end;


function TfmPOSCustomizeGrid.getProductdescVisible: Boolean;begin result := chkProductdesc.Checked  ;end;
function TfmPOSCustomizeGrid.getUnitPriceVisible  : Boolean;begin result := chkUnitPrice.Checked    ;end;
procedure TfmPOSCustomizeGrid.btnOkClick(Sender: TObject);
begin
  inherited;
    if not(chkQty.Checked) and
       not(chkProductName.Checked) and
       not(chkProductdesc.Checked) and
       not(chkUnitPrice.Checked) and
       not(chkAmount.Checked) and
       not (chkProfitPercent.Checked) then begin
      MessageDlgXP_Vista('Please Select at least one column to be shown', mtWarning, [mbOK], 0);
      Exit;
    end;
    Modalresult:= mrOk;
end;

function TfmPOSCustomizeGrid.getAmountVisible     : Boolean;begin result := chkAmount.Checked       ;end;

procedure TfmPOSCustomizeGrid.setQtyVisible         (const Value: Boolean);begin chkQty.Checked         := Value;end;
procedure TfmPOSCustomizeGrid.setProductNameVisible (const Value: Boolean);begin chkProductName.Checked := Value;end;

procedure TfmPOSCustomizeGrid.setProfitPercentVisible(const Value: boolean);
begin
  chkProfitPercent.Checked := Value;
end;

procedure TfmPOSCustomizeGrid.setProfitDollarVisible(const Value: boolean);
begin
  chkProfitDollar.Checked := Value;
end;

procedure TfmPOSCustomizeGrid.setProductdescVisible (const Value: Boolean);begin chkProductdesc.Checked := Value;end;
procedure TfmPOSCustomizeGrid.setUnitPriceVisible   (const Value: Boolean);begin chkUnitPrice.Checked   := Value;end;
procedure TfmPOSCustomizeGrid.setAmountVisible      (const Value: Boolean);begin chkAmount.Checked      := Value;end;

end.

