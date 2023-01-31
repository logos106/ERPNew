unit frmSelectProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls , BusObjTrans, Shader,
  DNMPanel, wwdblook, ERPDbLookupCombo, BaseTransForm, Mask, wwdbedit, DNMSpeedButton;


type

  TComponentProperties = record
    name :String;
    visible :boolean;
    Readonly :boolean;
  end;


  TfmSelectProduct = class(TBaseInputGUI)
    pnlMain: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblProduct: TLabel;
    lbluom: TLabel;
    Label3: TLabel;
    QtyShipped: TwwDBEdit;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    cboProductR: TERPDbLookupCombo;
    cboUnitOfMeasure: TwwDBLookupCombo;
    cmdNew: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cboProductRExit(Sender: TObject);
  private
    grdiProperties : Array of TComponentProperties;
    //transAccesslevel:Integer;
    function Transform :TBaseTransGUI ;
    function Productcombo : TERPDBLookupcombo;
    function UOMcombo : TwwDBLookupcombo;
    procedure InitProductcombo;
    procedure InitGrid;
    procedure InitUOMcombo;
  public
    Class function  SelectProduct(AOwner:TComponent): Boolean;
  end;


implementation

uses BusObjSales, busobjOrders, Commonlib,systemlib, frmInvoice, frmSalesOrder, frmPurchaseOrders;


{$R *.dfm}

{ TfmSelectProduct }
Procedure TfmSelectProduct.InitGrid;
var
  ctr:Integer;
begin
   SetLength(grdiProperties,0);
   for ctr:= 0 to transform.transbase.Lines.dataset.fieldcount-1 do begin
    SetLength(grdiProperties,ctr+1);
    grdiProperties[high(grdiProperties)].name :=transform.transbase.Lines.dataset.fields[ctr].fieldname;
    grdiProperties[high(grdiProperties)].visible :=transform.transbase.Lines.dataset.fields[ctr].visible;
    grdiProperties[high(grdiProperties)].REadonly :=transform.transbase.Lines.dataset.fields[ctr].REadonly;
    transform.transbase.Lines.dataset.fields[ctr].Readonly := False;
   end;
end;
Procedure TfmSelectProduct.InitProductcombo;
begin
  cboProductR.Lookupfield := '';
  cboProductR.Datafield   := '';
  cboProductR.Lookuptable := productcombo.lookuptable;
  cboProductR.Lookupfield := productcombo.Lookupfield;
  cboProductR.DataSource  := productcombo.DataSource;
  cboProductR.Datafield   := productcombo.Datafield;
  cboProductR.OnCloseUp   := productcombo.OnCloseUp;
  cboProductR.OnNotInList := productcombo.OnNotInList;
  cboProductR.onDropdown  := productcombo.onDropdown;
  cboProductR.Onchange    := productcombo.Onchange;
  productcombo.REadonly := False;
end;

Procedure TfmSelectProduct.InitUOMcombo;
begin
  cboUnitOfMeasure.Lookupfield := '';
  cboUnitOfMeasure.Datafield  := '';
  cboUnitOfMeasure.Lookuptable:= UOMcombo.lookuptable;
  cboUnitOfMeasure.Lookupfield:= UOMcombo.Lookupfield;
  cboUnitOfMeasure.DataSource := UOMcombo.DataSource;
  cboUnitOfMeasure.Datafield  := UOMcombo.Datafield;
  cboUnitOfMeasure.OnCloseUp  := UOMcombo.OnCloseUp;
  cboUnitOfMeasure.onnotinlist:= UOMcombo.onnotinlist;
  cboUnitOfMeasure.onDropdown := UOMcombo.onDropdown;
  cboUnitOfMeasure.Onchange   := UOMcombo.Onchange;
  UOMcombo.REadonly := False;
end;
procedure TfmSelectProduct.btnCloseClick(Sender: TObject);
begin
  inherited;
  (*Transform.TransBase.Lines.canceldb;
  Transform.TransBase.connection.RollbackNestedTransaction;*)
  Modalresult:= mrCancel;
end;

procedure TfmSelectProduct.btnCompletedClick(Sender: TObject);
begin
  inherited;
  Transform.TransBase.Lines.UOMQtyShipped := Transform.TransBase.Lines.UOMQtySold;
  Transform.TransBase.Lines.PostDB;
  (*Transform.TransBase.connection.CommitNestedTransaction;
  Self.Close;*)
  Modalresult:= mrOk;
end;

procedure TfmSelectProduct.cboProductRExit(Sender: TObject);
begin
  inherited;
  if transform.transbase.lines.UOMQtySold =0 then
    transform.transbase.lines.UOMQtySold := 1;
end;

procedure TfmSelectProduct.cmdNewClick(Sender: TObject);
begin
  inherited;
  if Transform.TransBase.Lines.ProductId =0 then exit;
  Transform.TransBase.Lines.UOMQtyShipped := Transform.TransBase.Lines.UOMQtySold;
  Transform.TransBase.Lines.PostDB;
  Transform.TransBase.Lines.New;
  Setcontrolfocus(cboProductR);
end;

procedure TfmSelectProduct.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ctr:Integer;
begin
  inherited;
  for ctr:= low(grdiProperties) to high(grdiProperties) do begin
    transform.transbase.lines.dataset.fieldbyname(grdiProperties[ctr].name).Visible := grdiProperties[ctr].visible;
    transform.transbase.lines.dataset.fieldbyname(grdiProperties[ctr].name).readonly := grdiProperties[ctr].readonly;
  end;
  //Transform.TransBase.AccessManager.AccessLevel :=transAccesslevel;
  //action := Cafree;
end;

procedure TfmSelectProduct.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Select Product For ' + Transform.Transbase.XMLNodeName + ' # ' + inttostr(Transform.Transbase.ID);
  TitleLabel.Caption := Transform.Transbase.XMLNodeName + ' # ' + inttostr(Transform.Transbase.ID);
  if Owner is TForm then color := TForm(Owner).Color;
  Transform.TransBase.Lines.Last;

  initProductcombo;
  InitUOMcombo;
  QtyShipped.DataSource := productcombo.DataSource;
  QtyShipped.DataField := 'UnitofMeasureQtySold';
  (*transAccesslevel:=Transform.TransBase.AccessManager.AccessLevel;
  Transform.TransBase.AccessManager.AccessLevel := 1;*)
  (*Transform.TransBase.Connection.BeginTransaction;
  Transform.TransBase.Connection.BeginNestedTransaction;*)
  Transform.TransBase.AllowNewRecordWhenLocked := True;
  Transform.TransBase.Lines.New;
  InitGrid;
  //QtyShipped.DataSource.DataSet.FieldByName(QtyShipped.DataField).AsFloat := 1;
  Setcontrolfocus(cboProductR);
end;

function TfmSelectProduct.Productcombo: TERPDBLookupcombo;
begin
  result:= nil;
  if Owner is TSalesOrderGUI then result :=TSalesOrderGUI(Owner).cboProductR
  else if Owner is TInvoiceGUI then result :=TInvoiceGUI(Owner).cboProductR
  else if Owner is TPurchaseGUI then result :=TPurchaseGUI(Owner).cboProductR;
end;

class function  TfmSelectProduct.SelectProduct(AOwner: TComponent):Boolean;
var
  form :Tcomponent;
begin
  result:= False;
  if not (AOwner is TBaseTransGUI) then exit;
  form := GetComponentByClassName('TfmSelectProduct' , False , AOwner);
  try
    if form = nil then exit;
    With TfmSelectProduct(form) do begin
        ShowModal;
        result := modalresult = mrOk;
    end;
  finally
    Freeandnil(Form);
  end;
end;

function TfmSelectProduct.Transform: TBaseTransGUI;
begin
  Result := TBaseTransGUI(Owner);
end;

function TfmSelectProduct.UOMcombo: TwwDBLookupcombo;
begin
  result:= nil;
  if Owner is TSalesOrderGUI then result :=TSalesOrderGUI(Owner).cboUnitOfMeasure
  else if Owner is TInvoiceGUI then result :=TInvoiceGUI(Owner).cboUnitOfMeasure
  else if Owner is TPurchaseGUI then result :=TPurchaseGUI(Owner).cboUnitOfMeasure;

end;
Initialization
  RegisterClassOnce(TfmSelectProduct);

end.

