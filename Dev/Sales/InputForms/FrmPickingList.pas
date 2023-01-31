{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 23/09/05  1.00.01 BJ    Initial Version
                         When required to give a qty for picking slip without giving a shipped
                         quantity, this form is called. This updates the tblPickSliplines
                         The form is called based on a preference - AcceptPickingSlipQty
                         this form uses the ininvoice form's connection.
 26/09/05 1.00.02  AL    When form opens, cursor goes to "qryProductsQty" (Qty) field 
                         ready to type
 24/04/06 1.00.01  BJ  'Active' field is introduced in tblProductQtyAllocation table.
                       Qrymain is filtering the records for the active allocations

}
unit FrmPickingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, DB,  StdCtrls, Buttons, DNMSpeedButton, Grids, Wwdbigrd,
  Wwdbgrid, DataState, DBAccess, MyAccess, SelectionDialog, AppEvnts,
  ExtCtrls, DNMPanel, Menus, AdvMenus, MemDS, Shader;

type
  TfmPickingList = class(TBaseInputGUI)
    grdList: TwwDBGrid;
    btnCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    qryProducts: TMyQuery;
    dsProducts: TDataSource;
    qryParts: TMyQuery;
    qryPartsPartsId: TAutoIncField;
    qryPartsPartname: TStringField;
    pnlTitle: TDNMPanel;
    qryProductsBatchId: TIntegerField;
    qryProductsPartsId: TIntegerField;
    qryProductsPartname: TStringField;
    qrybins: TMyQuery;
    qrybinsID: TAutoIncField;
    qrybinsBinLocation: TStringField;
    qrybinsbinnumber: TStringField;
    qryProductsBinLocation: TStringField;
    qryProductsBinNumber: TStringField;
    qryBatches: TMyQuery;
    qryBatchesID: TAutoIncField;
    qryBatchesBatchNumber: TStringField;
    qryBatchesExpiryDate: TDateTimeField;
    qryProductsBatchnumber: TStringField;
    qryProductsExpiryDate: TDateField;
    qryProductsID: TAutoIncField;
    qryProductsUOM: TStringField;
    qryProductsUOMQty: TFloatField;
    qryProductsQtyPicking: TFloatField;
    DNMPanel1: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryProductsBinId: TLargeintField;
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryProductsBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    fiSaleID:Integer;
    (*procedure SetSaleId(const Value: integer);*)
    (*procedure SettransType(const Value: String);*)
    procedure Setcolor(const Value: TColor);
    function GetBinQty(SaleID:Integer): String;
  public
    { Public declarations }
    property SaleId: integer write fiSaleID;
    (*property transType: String write SettransType;*)
    property BColor: TColor write Setcolor;
  end;

implementation

uses
  Forms, CommonLib, ProductQtyLib, FastFuncs;



{$R *.dfm}
procedure TfmPickingList.Setcolor(const Value: TColor);
begin
  Self.Color := Value;
  grdList.Footercolor := Value;
  grdList.TitleColor := Value;
end;
(*procedure TfmPickingList.SettransType(const Value: String);
begin
  with Qryproducts do begin
    if Active then Close;
    QryProducts.ParamByName('transType').AsString := Value;
  end;
end;*)

(*procedure TfmPickingList.SetSaleId(const Value: integer);
begin
  with Qryproducts do begin
    if Active then Close;
    QryProducts.ParamByName('SaleId').asInteger := Value;
  end;
end;*)

procedure TfmPickingList.btnPrintClick(Sender: TObject);
var
  ProductsSelected: integer;
begin
  if qryProducts.State = dsEdit then qryProducts.Post;
  ProductsSelected := 0;
  with qryProducts do if FieldByName('QtyPicking').AsFloat > 0 then ProductsSelected := ProductsSelected + 1;
  if ProductsSelected > 0 then else CommonLib.MessageDlgXP_Vista('None of the product in the list has quantity more than 0.',
      mtWarning, [mbOK], 0);
end;
function TfmPickingList.GetBinQty(SaleID:Integer): String;
var
  SQLList:TStringList;
begin
    SQLList := TStringList.Create;
    try
        SQLList.add('SELECT PQABatch.Value as Batchnumber, PQAbatch.ExpiryDate,');
        SQLList.add('PBin.BinLocation, PBin.BinNumber, ');
        SQLList.add('P.PartName, ');
        SQLList.add(ProductQtyLib.SQL4Qty(tInstock,'PQA' , 'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty , 0))') +' as Qty');
        SQLList.add(' FROM ' +ProductTables(tExtraDetails));
        SQLList.Add(' Where PQA.TransId = ' +Fastfuncs.IntTostr(SaleId)+ ' and PQA.Transtype in (' +SalesTransTypes +')');
        SQLList.add('group by PQABatch.Value , PQAbatch.ExpiryDate,');
        SQLList.add('PBin.BinLocation, PBin.BinNumber;');
        Result := SQLList.Text;
    finally
        Freeandnil(SQLList);
    end;
end;

procedure TfmPickingList.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfmPickingList.FormShow(Sender: TObject);
begin
  if qryProducts.active then qryProducts.close;
  qryProducts.SQL.clear;
  qryProducts.SQL.add(GetBinQty(fiSaleID));
  inherited;
  OpenQueries;
  qryproducts.First;
  while Qryproducts.Eof = false do begin
    if qryProductsQtyPicking.AsFloat = 0 then begin
      QryProducts.Edit;
      qryProductsQtyPicking.AsFloat := qryProductsUOMQty.AsFloat;
      QryProducts.Post;
    end;
    QryProducts.Next;
  end;
  grdList.SelectedField := qryProductsQtyPicking;
end;

procedure TfmPickingList.qryProductsBeforePost(DataSet: TDataSet);
begin
  inherited;
    if qryProductsQtyPicking.asFloat >qryProductsUOMQty.asFloat then
        qryProductsQtyPicking.asFloat :=qryProductsUOMQty.asFloat;
end;

end.
