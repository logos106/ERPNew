unit frmProductQtyBinGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  StdCtrls, Buttons, DNMSpeedButton, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, DNMPanel, SelectionDialog, AppEvnts, DBCtrls,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader, ImgList, ProgressDialog;

const
  SX_BinQtyChangeMsg = WM_USER + 103;

type
  TProductQtyBinGUI = class(TBaseInputGUI)
    pnl1: TDNMPanel;
    qryBin: TERPQuery;
    DSBin: TDataSource;
    DSQtys: TDataSource;
    grdbins: TwwDBGrid;
    qryQtys: TERPQuery;
    Label3: TLabel;
    pnl2: TDNMPanel;
    lblDept: TLabel;
    lbqryQtysClassName: TDBText;
    qryQtysClassID: TIntegerField;
    qryQtysClassName: TWideStringField;
    qryQtysAvailableQty: TFloatField;
    qryQtysInStockQty: TFloatField;
    qryQtysBOQty: TFloatField;
    qryQtysOnOrderQty: TFloatField;
    qryQtysSOQty: TFloatField;
    qryQtysSOBoQty: TFloatField;
    qryQtysPartsID: TIntegerField;
    qryQtysPartName: TWideStringField;
    qryQtysProductPrintName: TWideStringField;
    qryBinbinlocation: TWideStringField;
    qryBinBinnumber: TWideStringField;
    qryBinUOM: TWideStringField;
    qryBinAvailableQty: TFloatField;
    qryBinSoQty: TFloatField;
    qryBinProductID: TIntegerField;
    qryBinDepartmentID: TIntegerField;
    grdPartQtyLines: TwwDBGrid;
    lblproduct: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryQtysAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure grdPartQtyLinesDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure qryQtysAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fiProductID: integer;
    fiClassID: integer;
    fConnection:TERPConnection;
    Procedure refreshbins;
    procedure initProductTransactionListtype(Sender: TObject);
    Procedure DefaultHeights;
  public
    { Public declarations }
    property ProductID: integer read fiProductID write fiProductID;
    property ClassID: integer read fiClassID write fiClassID;
    property Connection : TERPConnection read fConnection write fConnection;
  end;


implementation

uses pqalib, CommonLib, ProductQtyLib, FastFuncs, CommonFormLib,
  ProductTransactionList, AppEnvironment;

{$R *.dfm}

{ TProductQtyBinGUI }


procedure TProductQtyBinGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TProductQtyBinGUI.qryQtysAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryQtysClassName.displaylabel :=  AppEnv.DefaultClass.ClassHeading+' Name';
  qryQtysPartName.displaylabel :=  AppEnv.DefaultClass.PartColumn;
  qryQtysProductPrintName.displaylabel :=  appenv.companyPrefs.ProductPrintNameHeading;
  lblDept.Caption :=  'Bin Locations in '+ AppEnv.DefaultClass.ClassHeading +' : ';
  qryQtysAfterScroll(DataSet);
end;

procedure TProductQtyBinGUI.qryQtysAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lbqryQtysClassName.Caption:= qryQtysClassName.AsString;
  fiClassID                 := qryQtys.FieldByName('ClassID').AsInteger;
  lblProduct.Caption        := qryQtys.FieldByName('PartName').AsString;
  refreshbins;
end;
procedure TProductQtyBinGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if Self.Connection <> nil then begin
      QryQtys.Connection := Self.Connection;
    end;
    QryQtys.DisableControls;
    try
      if qryQtys.Active then qryQtys.close;
      qryQtys.SQL.clear;
      qryQtys.SQL.add('Select PC.ClassID, PC.ClassName ,P.PartsID,  P.PartName,P.ProductPrintName,');
      qryQtys.SQL.add(SQL4Qty(tAvailable) +' as   AvailableQty,');
      qryQtys.SQL.add(SQL4Qty(tInstock)   +' as   InStockQty,');
      qryQtys.SQL.add(SQL4Qty(tSO)        +' as   SOQty,');
      qryQtys.SQL.add(SQL4Qty(tSOBO)      +' as   SOBOQty,');
      qryQtys.SQL.add(SQL4Qty(tInvBO)     +' as   BOQty,');
      qryQtys.SQL.add(SQL4Qty(tPOBO)      +' as   OnOrderQty');
      qryQtys.SQL.add('FROM ' + ProductTables(tProductList));
      qryQtys.SQL.add('WHERE PC.ProductID= ' + IntToStr(ProductID));
      qryQtys.SQL.add('group by PC.ClassID, PC.ClassName');
      qryQtys.open;
    finally
        qryQtys.EnableControls;
    end;
    qryQtys.Locate('ClassID', fiClassID, [loCaseInsensitive]);
  (*  fiClassID       := qryQtys.FieldByName('ClassID').AsInteger;
    edPartName.Text := qryQtys.FieldByName('Partname').AsString;*)
  finally
    EnableForm;
  end;
end;
procedure TProductQtyBinGUI.grdPartQtyLinesDblClick(Sender: TObject);
begin
  inherited;
   if sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysSOQty.fieldname)       or
      sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysSOBOQty.fieldname)     or
      sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysBOQty.fieldname)       or
      sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysOnOrderQty.fieldname)  then
   OpenERPListForm('TProductTransactionListGUI' , initProductTransactionListtype);
end;
Procedure TProductQtyBinGUI.initProductTransactionListtype(Sender:TObject);
begin
  if not(Sender is TProductTransactionListGUI) then exit;
       if sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysSOQty.fieldname)       then TProductTransactionListGUI(Sender).Qtytype :=tSO
  else if sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysSOBOQty.fieldname)     then TProductTransactionListGUI(Sender).Qtytype :=tSOBO
  else if sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysBOQty.fieldname)       then TProductTransactionListGUI(Sender).Qtytype :=tInvBO
  else if sametext(grdPartQtyLines.GetActiveField.fieldname , qryQtysOnOrderQty.fieldname)  then TProductTransactionListGUI(Sender).Qtytype :=tPOBO;
  TProductTransactionListGUI(Sender).ProductId := qryQtysPartsID.asInteger;
end;
procedure TProductQtyBinGUI.refreshbins;
begin
  qryBin.DisableControls;
  try
    if qryBin.Active then qryBin.close;
    qryBin.SQL.clear;
    qryBin.SQL.add('Select PBin.binlocation, PBin.Binnumber, ');
    qryBin.SQL.add('PQA.UOM,PQA.ProductID ,PQA.DepartmentID , ');
    qryBin.SQL.add(SQL4Qty(tAvailable, 'PQA', 'ifnull(PQABins.UOMQty, PQA.UOMQty)') +' as   AvailableQty,');
    qryBin.SQL.add(SQL4Qty(tSO, 'PQA', 'ifnull(PQABins.UOMQty, PQA.UOMQty)')        +' as   SoQty');
    qryBin.SQL.add('FROM ' + ProductTables(tExtraDetails));
    qryBin.SQL.add('WHERE  PQA.ProductID= ' + IntToStr(ProductID));
    qryBin.SQL.add('and PQA.DepartmentID= ' + IntToStr(fiClassID));
    qryBin.SQL.add('group by PBin.binlocation, PBin.Binnumber, PQA.UOM');
    qryBin.open;
  finally
      qryBin.EnableControls;
  end;
end;

procedure TProductQtyBinGUI.DefaultHeights;
var
  i:Integer;
begin
  inherited;
  i := Self.height - pnl1.height  - pnl2.height;
  i := trunc(i/2);
  grdPartQtyLines.height := i;
end;

procedure TProductQtyBinGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;


procedure TProductQtyBinGUI.FormDestroy(Sender: TObject);
begin
  Self.Connection := nil;
  inherited; 
end;

procedure TProductQtyBinGUI.FormResize(Sender: TObject);
begin
  inherited;
  DefaultHeights;
end;

initialization
  RegisterClassOnce(TProductQtyBinGUI);

end.
