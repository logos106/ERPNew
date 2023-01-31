unit frmDU_SpecialProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, DB, Menus, ExtCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwclearbuttongroup, wwradiogroup, Shader, DNMPanel ,
  wwdblook, ERPDbLookupCombo, MemDS, DBAccess, MyAccess, ERPdbComponents , busobjDataupdator, frmDU_base;

type
  TfmDU_SpecialProducts = class(TfmDU_base_grid)
    cboProductQry: TERPQuery;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    QryUOMmultiplier: TFloatField;
    QryUOMUnitId: TIntegerField;
    QryUOMPartID: TIntegerField;
    cboProd: TERPDbLookupCombo;
    cboUOM: TwwDBLookupCombo;
    procedure cboUOMCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure btnDeleteClick(Sender: TObject);
  private
    fSpecialProducts: TDataupdatorSpecialProducts;
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    function Formhint :String;override;
  public
    Property SpecialProducts    : TDataupdatorSpecialProducts read fSpecialProducts  write fSpecialProducts ;
  end;


implementation

uses frmDataUpdator, CommonDbLib, tcConst;


{$R *.dfm}

{ TfmDU_SpecialProducts }

procedure TfmDU_SpecialProducts.btnDeleteClick(Sender: TObject);
begin
  inherited;
  SpecialProducts.deleted:= True;
  SpecialProducts.PostDb;
end;

procedure TfmDU_SpecialProducts.cboUOMCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not modified then Exit;
  inherited;
  if filltable.State = dsCalcFields then exit;
  EditDB(Filltable);
  filltable.fieldbyname('UOM').asString         := Lookuptable.fieldbyname('UnitName').asString;
  PostDB(Filltable);
  EditDB(Filltable);
end;

function TfmDU_SpecialProducts.Formhint: String;
begin
  REsult:= 'Varitaion Option :' + NL+
           '   Add/Update: This will create a ''Customer''s Special Price'' for each Customer selected for the '+
            'selected ''Products'' and ''Unit of measssure'' for the ''Date Range'' for the ''Price'' '+
            'if doesn''t exists and will update the Special Price with the ''Price'' if it already exists.' +NL+
           '   Increase : will update the existing ''Special Price'' for each Customer selected for '+
            'the selected ''Product'' and ''Unit of measssure'' for the ''Date Range'' by increasing the Price with the ''Variation Amount'' specified' +NL+
           '   Decrease : will update the existing ''Special Price'' for each Customer selected for '+
            'the selected ''Product'' and ''Unit of measssure'' for the ''Date Range'' by decreasing the Price with the ''Variation Amount'' specified' ;

end;

class function TfmDU_SpecialProducts.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_SpecialProducts.create(AOwner);
  With TfmDU_SpecialProducts(Result) do begin
    OpenQueries;
    if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).qrySpecialProducts;
    end;
  end;

end;

end.
