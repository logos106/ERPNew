unit frmStockToFixedAssetQtyInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, AdvEdit,
  Shader, DNMPanel, DNMSpeedButton;

type
  TfmStockToFixedAssetQtyInput = class(TBaseForm)
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtQty: TAdvEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    fMaxQty: integer;
    fProductName: string;
  public
    property MaxQty: integer read fMaxQty write fMaxQty;
    property ProductName: string read fProductName write fProductName;
  end;

  function GetQtyOfProduct(const aProductName: string; aMaxQty: integer): integer;

implementation

{$R *.dfm}

function GetQtyOfProduct(const aProductName: string; aMaxQty: integer): integer;
var
  form: TfmStockToFixedAssetQtyInput;
begin
  result := 0;
  form := TfmStockToFixedAssetQtyInput.Create(nil);
  try
    form.MaxQty := aMaxQty;
    form.ProductName := aProductName;
    if form.ShowModal = mrOk then
      result := form.edtQty.IntValue;

  finally
    form.Release;
  end;
end;

procedure TfmStockToFixedAssetQtyInput.FormShow(Sender: TObject);
begin
  inherited;
  Label2.Caption := 'Enter the Qty of Fixed Assets to create for ' + ProductName ;
  if MaxQty > -1 then
    Label2.Caption := Label2.Caption + ' (' + IntToStr(MaxQty) + ' in stock)';
end;

end.
