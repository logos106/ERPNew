unit frmDU_DeleteExtraSellPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, DB, ExtCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  StdCtrls, wwclearbuttongroup, wwradiogroup, Shader, DNMPanel , frmDU_base, BaseListingForm,
  Menus;

type
  TfmDU_DeleteExtraSellPrice = class(TfmDU_base)
    procedure grdmainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    ProductExtraSellPrice : TBaseListingGUI;
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

{ TfmDU_DeleteExtraSellPrice }

function TfmDU_DeleteExtraSellPrice.EntriesSelected(const ProductID: Integer): String;
begin
  result:= SelectedIds(grdmain,'PriceId' , TRue);
end;

procedure TfmDU_DeleteExtraSellPrice.FormCreate(Sender: TObject);
begin
  inherited;
  CreateHistorylistform('TProductExtraSellPriceGUI' ,Self, ProductExtraSellPrice);
  ProductExtraSellPrice.lblcustomReport.Visible := False;
  ProductExtraSellPrice.cboCustomReports.Visible := False;
  ProductExtraSellPrice.Parent := pnlDEtails;
  ProductExtraSellPrice.BorderStyle := bsNone;
  ProductExtraSellPrice.DisablePopupmenuinPanel:= False;
  ProductExtraSellPrice.Show;
  //ProductExtraSellPrice.grdMain.PopupMenu := ProductExtraSellPrice.mnuFilter;
  ProductExtraSellPrice.Hint  := 'Select the ''Extra Sell Price(s)'' to be deleted' +NL+
          ' the ''Product'' Selection in the Grid above will be ignored for this ';
end;


function TfmDU_DeleteExtraSellPrice.grdmain: TwwDBGrid;
begin
  REsult:=  ProductExtraSellPrice.grdMain;
end;

procedure TfmDU_DeleteExtraSellPrice.grdmainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  (*if Selecting then DoProductselection(grdmain.DataSource.DataSet.FieldByName('PartsId').AsInteger);*)
end;

(*procedure TfmDU_DeleteExtraSellPrice.DoProductselection(const PartsID:Integer);
begin
  if Assigned(MainForm) and (mainform is MainForm) then
      MainForm(Mainform).SelectProduct(PartsID);
end;*)

class function TfmDU_DeleteExtraSellPrice.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_DeleteExtraSellPrice.create(AOwner);
  With TfmDU_DeleteExtraSellPrice(Result) do begin
    (*OpenQueries;
    if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).qryExtraSellPricetoDelete;
    end;*)
  end;

end;

function TfmDU_DeleteExtraSellPrice.ProductsSelected: String;
begin
  result := SelectedIDs(grdmain, 'PartsID' , True);
end;

end.

