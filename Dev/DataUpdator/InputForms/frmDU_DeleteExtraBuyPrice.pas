unit frmDU_DeleteExtraBuyPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, DB, ExtCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  StdCtrls, wwclearbuttongroup, wwradiogroup, Shader, DNMPanel , frmDU_base, BaseListingForm,
  Menus;

type
  TfmDU_DeleteExtraBuyPrice = class(TfmDU_base)
    procedure FormCreate(Sender: TObject);
  private
    ProductExtraBuyPrice : TBaseListingGUI;
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
  public
    function ProductsSelected:String;
    function EntriesSelected(const ProductID:Integer):String;
    Function grdmain:TwwDBGrid;
  end;


implementation

uses frmDataUpdator, tcConst, CommonLib, CommonFormLib ;

{$R *.dfm}

{ TfmDU_DeleteExtraBuyPrice }

function TfmDU_DeleteExtraBuyPrice.EntriesSelected(const ProductID: Integer): String;
begin
  result:= SelectedIds(grdmain,'ExtraPartPriceId' , TRue);
end;

procedure TfmDU_DeleteExtraBuyPrice.FormCreate(Sender: TObject);
begin
  inherited;
  CreateHistorylistform('TProductExtraBuyPricesGUI' ,Self, ProductExtraBuyPrice);
  ProductExtraBuyPrice.lblcustomReport.Visible := False;
  ProductExtraBuyPrice.cboCustomReports.Visible := False;
  ProductExtraBuyPrice.Parent := pnlDEtails;
  ProductExtraBuyPrice.BorderStyle := bsNone;
  ProductExtraBuyPrice.DisablePopupmenuinPanel:= False;
  ProductExtraBuyPrice.Grpfilters.itemindex := 1;
  ProductExtraBuyPrice.Show;
  ProductExtraBuyPrice.Hint  := 'Select the ''Extra Buy Price(s)'' to be deleted' +NL+
          ' the ''Product'' Selection in the Grid above will be ignored for this ';
end;


function TfmDU_DeleteExtraBuyPrice.grdmain: TwwDBGrid;
begin
  REsult:=  ProductExtraBuyPrice.grdMain;
end;

class function TfmDU_DeleteExtraBuyPrice.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_DeleteExtraBuyPrice.create(AOwner);
end;

function TfmDU_DeleteExtraBuyPrice.ProductsSelected: String;
begin
  result := SelectedIDs(grdmain, 'PartsID' , True);
end;

end.

