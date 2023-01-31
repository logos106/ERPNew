unit frmDU_ExtraForeignSellPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, ExtCtrls, StdCtrls, wwdblook, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,busobjDataupdator,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup,frmDU_base, Shader;

type
  TfmDU_ExtraForeignSellPrice = class(TfmDU_base_grid)
    cboUOMESFP: TwwDBLookupCombo;
    cboSellCurrency: TwwDBLookupCombo;
    qryBuyCurrencyLookup: TERPQuery;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    procedure btnDeleteClick(Sender: TObject);
    procedure cboCurrencyCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fExtraFxSellPrice: TDataUpdatorForeignSellPrice;

  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    function Formhint: String;override;
  public
    Property ExtraFxSellPrice  : TDataUpdatorForeignSellPrice read fExtraFxSellPrice write fExtraFxSellPrice;
  end;


implementation

uses frmDataUpdator, tcConst;

{$R *.dfm}

{ TfmDU_ExtraForeignSellPrice }

Class function TfmDU_ExtraForeignSellPrice.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  result:= TfmDU_ExtraForeignSellPrice.create(AOwner);
  with TfmDU_ExtraForeignSellPrice(Result) do begin
    OpenQueries;
    if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).qryExtraFxSellPrice;
    end;
  end;
end;
procedure TfmDU_ExtraForeignSellPrice.btnDeleteClick(Sender: TObject);
begin
  inherited;
  fExtraFxSellPrice.deleted:= True;
  fExtraFxSellPrice.PostDb;
end;

procedure TfmDU_ExtraForeignSellPrice.cboCurrencyCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  fExtraFxSellPrice.currencyID := LookupTable.FieldByName('CurrencyID').AsInteger
end;

function TfmDU_ExtraForeignSellPrice.Formhint: String;
begin
  REsult:= 'Varitaion Option :' + NL +
           '   Add/Update: This will create an ''Extra Sell Price(Fx)'' for each product selected for the '+
            'selected ''Currency'' and ''Unit of measssure'' for the ''Price (Ex)'' '+
            'if doesn''t exists and will update the existing records it with the ''Price (Ex)''.' +NL+
           '   Increase : will update the existing ''Extra Sell Price(Fx)'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by increasing the price with the ''Variation Amount'' specified' +NL+
           '   Decrease : will update the existing ''Extra Sell Price(Fx)'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by decreasing the Price with the ''Variation Amount'' specified' ;
end;

end.

