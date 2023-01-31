unit frmDU_ExtraBuyPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, ExtCtrls, StdCtrls, wwdblook, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents ,busobjDataupdator,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup,frmDU_base, Shader, Menus;

type
  TfmDU_ExtraBuyPrice = class(TfmDU_base_grid)
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    cboSupplier: TwwDBLookupCombo;
    cboUOMEBP: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    fExtraBuyPrice: TDataUpdatorExtraBuyPrice;
    { Private declarations }
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    function Formhint :string;Override;
  public
    Property ExtraBuyPrice     : TDataUpdatorExtraBuyPrice read fExtraBuyPrice write fExtraBuyPrice;
  end;


implementation

uses frmDataUpdator, tcConst;


{$R *.dfm}

{ TfmDU_ExtraBuyPrice }

procedure TfmDU_ExtraBuyPrice.btnDeleteClick(Sender: TObject);
begin
  inherited;
  fExtraBuyPrice.deleted:= True;
  fExtraBuyPrice.PostDb;
end;

function TfmDU_ExtraBuyPrice.Formhint: string;
begin
  REsult:= 'Varitaion Option :' + NL+
            '   Add/Update: This will create an ''Extra Buy Price'' for each product selected for the '+
            'selected ''Supplier'' and ''Unit of measssure'' for the ''Price (Ex)'' '+
            'if doesn''t exists and will update the existing records it with the ''Price (Ex)''.' +NL+
           '   Increase : will update the existing ''Extra Buy Price'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by increasing the price with the ''Variation Amount'' specified' +NL+
           '   Decrease : will update the existing ''Extra Buy Price'' for each product selected for '+
            'the selected ''Currency'' and ''Unit of measssure'' by decreasing the Price with the ''Variation Amount'' specified' ;
end;

procedure TfmDU_ExtraBuyPrice.FormShow(Sender: TObject);
begin
  inherited;
  OptVariation.Hint := 'Add/Update : This will create a new record with the amount if the record doesn''t exists for the product and will update wwith the amount if it already exists ' +NL+
                       'Increase : will increase the discount by the specified amount/percentage'+NL+
                       'Decrease : will decrease the discount by the specified amount/percentage';
  OptVariation.ShowHint := True;
end;

Class function TfmDU_ExtraBuyPrice.MakeInstance(AOwner:TComponent): TfmDU_base;
begin
   result:= TfmDU_ExtraBuyPrice.create(AOwner);
   With TfmDU_ExtraBuyPrice(Result) do begin
     OpenQueries;
     if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).qryExtraBuyPrice;
     end;
   end;
end;

end.

