unit frmDU_ExtraForeignBuyPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, ExtCtrls, StdCtrls, wwdblook, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents ,busobjDataupdator,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup,frmDU_base, Shader;

type
  TfmDU_ExtraForeignBuyPrice = class(TfmDU_base_grid)
    cboSupplierForeign: TwwDBLookupCombo;
    cboUOMEBFP: TwwDBLookupCombo;
    cboBuyCurrency: TwwDBLookupCombo;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    qrySellCurrencyLookup: TERPQuery;
    procedure btnDeleteClick(Sender: TObject);
    procedure cboCurrencyCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fExtraFxBuyPrice: TDataUpdatorForeignBuyPrice;
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    function Formhint: String;override;
  public
    Property ExtraFxBuyPrice   : TDataUpdatorForeignBuyPrice read fExtraFxBuyPrice write fExtraFxBuyPrice;
  end;

implementation

uses frmDataUpdator, tcConst;

{$R *.dfm}

{ TfmDU_ExtraForeignBuyPrice }

Class function TfmDU_ExtraForeignBuyPrice.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  result:= TfmDU_ExtraForeignBuyPrice.create(AOwner);
  with TfmDU_ExtraForeignBuyPrice(Result) do begin
    OpenQueries;
    if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).QryExtraFxBuyPrice;
    end;
  end;
end;
procedure TfmDU_ExtraForeignBuyPrice.btnDeleteClick(Sender: TObject);
begin
  inherited;
  fExtraFxBuyPrice.deleted:= True;
  fExtraFxBuyPrice.PostDb;
end;

procedure TfmDU_ExtraForeignBuyPrice.cboCurrencyCodeCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  fExtraFxBuyPrice.currencyID := LookupTable.FieldByName('CurrencyID').AsInteger
end;

function TfmDU_ExtraForeignBuyPrice.Formhint: String;
begin
  REsult:= 'Varitaion Option :' + NL+
           '   Add/Update: This will create an ''Extra Buy Price(Fx)'' for each product selected for the '+
            'selected ''Currency'' and ''Unit of measssure'' for the ''Price (Ex)'' '+
            'if doesn''t exists and will update the existing records it with the ''Price (Ex)''.' +NL+
           '   Increase : will update the existing ''Extra Buy Price(Fx)'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by increasing the price with the ''Variation Amount'' specified' +NL+
           '   Decrease : will update the existing ''Extra Buy Price(Fx)'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by decreasing the Price with the ''Variation Amount'' specified' ;
end;

end.

