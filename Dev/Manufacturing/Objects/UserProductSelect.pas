unit UserProductSelect;

interface

uses
  BusObjStock, wwDbGrid;

type
  TProductSelectObj = class(TObject)
  private
    fPartsId: integer;
    fPartName: string;
    fPartDescription: string;
    procedure DoOnGridDataSelect(Sender: TwwDbGrid);
  public
    constructor Create;
    function SelectProduct: TProduct;
    function UserSelectProduct: boolean;
    property PartId: integer read fPartsId write fPartsId;
    property PartName: string read fPartName write fPartName;
    property PartDescription: string read fPartDescription write fPartDescription;
  end;

  function UserSelectProduct: TProduct;
  function GetUserSelectProduct(var aPartId: integer; var aPartName,
    aPartDescription: string): boolean ;



implementation

uses
  BaseListingForm, CommonLib, forms, Controls;

function UserSelectProduct: TProduct;
begin
  with TProductSelectObj.Create do begin
    result:= SelectProduct;
    Free;
  end;
end;

function GetUserSelectProduct(var aPartId: integer; var aPartName,
  aPartDescription: string): boolean ;
begin
  with TProductSelectObj.Create do begin
    result:= UserSelectProduct;
    if result then begin
      aPartId:= PartId;
      aPartName:= PartName;
      aPartDescription:= PartDescription;
    end;
    Free;
  end;
end;


{ TProductSelectObj }

constructor TProductSelectObj.Create;
begin
  inherited;
  fPartsId:= 0;
end;

procedure TProductSelectObj.DoOnGridDataSelect(Sender: TwwDbGrid);
begin
  fPartsId:= Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger;
  fPartName:= Sender.DataSource.DataSet.FieldByName('ProductName').AsString;
  fPartDescription:= Sender.DataSource.DataSet.FieldByName('SalesDescription').AsString;
//  fPartCost:= Sender.DataSource.DataSet.FieldByName('Cost1').AsFloat;
//  fPartPrice:= Sender.DataSource.DataSet.FieldByName('Price1').AsFloat;
end;

function TProductSelectObj.SelectProduct: TProduct;
var
  SelectForm: TBaseListingGUI;
begin
  inherited;
  result:= nil;
  SelectForm:= TBaseListingGUI(GetComponentByClassName('TProductListExpressGUI', false));
  If not Assigned(SelectForm) then Exit;
  SelectForm.OnGridDataSelect:= DoOnGridDataSelect;
  if (SelectForm.ShowModal = mrOK) and (fPartsId > 0) then begin
    result:= TProduct.Create(Application);
    result.Load(fPartsId);
  end;
end;

function TProductSelectObj.UserSelectProduct: boolean;
var
  SelectForm: TBaseListingGUI;
begin
  result:= false;
  SelectForm:= TBaseListingGUI(GetComponentByClassName('TProductListExpressGUI', false));
  If not Assigned(SelectForm) then Exit;
  SelectForm.OnGridDataSelect:= DoOnGridDataSelect;
  result:= (SelectForm.ShowModal = mrOK);
  { needs the following line to stop AV when user selects product from express
    list and clicks on select (rather than double clicking) }
  Application.ProcessMessages;
end;



end.
