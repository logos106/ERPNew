unit frmSalesShippingDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMSpeedButton, StdCtrls, Shader, DNMPanel, BusObjSales, Mask, wwdbedit,
  wwdbdatetimepicker, DBCtrls, wwdblook, ProgressDialog;

type
  TfmSalesShippingDetail = class(TBaseInputGUI)
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    DSMaster: TDataSource;
    dssalesshippingdetails: TDataSource;
    edtFlightno: TwwDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblSizeUOM: TLabel;
    lblGrossWeightUOM: TLabel;
    lblWeightUOM: TLabel;
    Label13: TLabel;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    QryWeightUOM: TERPQuery;
    QryWeightUOMunitId: TIntegerField;
    QryWeightUOMunitname: TWideStringField;
    QrySizeUOM: TERPQuery;
    QrySizeUOMunitId: TIntegerField;
    QrySizeUOMunitname: TWideStringField;
    cboDefaultWeightUOM2: TwwDBLookupCombo;
    cboDefaultSizeUOM: TwwDBLookupCombo;
    cboDefaultWeightUOM1: TwwDBLookupCombo;
    dtExFactoryDate: TwwDBDateTimePicker;
    Label10: TLabel;
    dtETA: TwwDBDateTimePicker;
    dtETD: TwwDBDateTimePicker;
    mem_Note: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure wwDBEdit1Enter(Sender: TObject);
    procedure DefaultWeightUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboDefaultsizeUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboDefaultWeightUOM1CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fSalesObject: TSales;
    { Private declarations }
  public
    (*Property SalesObject :TSales Read fSalesObject Write fSalesObject;*)
    constructor Create(AOwner: TComponent; SalesObject :TSales);reintroduce;
  end;


implementation

uses CommonLib, BusobjSaleBase, BusObjClient, tcDataUtils;

{$R *.dfm}

procedure TfmSalesShippingDetail.FormCreate(Sender: TObject);
begin
  inherited;
  fSalesObject := nil;
end;

procedure TfmSalesShippingDetail.FormShow(Sender: TObject);
begin
  inherited;
  if assigned(fSalesObject) then fSalesObject.Connection.BeginNestedTransaction;
  Openqueries;
end;

procedure TfmSalesShippingDetail.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Assigned(fSalesObject) then begin
    fSalesObject.SalesShippingDetails.PostDb;
    fSalesObject.Connection.CommitNestedTransaction;
    Self.Close;
  end;
end;

procedure TfmSalesShippingDetail.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Assigned(fSalesObject) then begin
    fSalesObject.SalesShippingDetails.CancelDb;
    fSalesObject.Connection.RollbackNestedTransaction;
  end;
  Self.Close;
end;

constructor TfmSalesShippingDetail.Create(AOwner: TComponent;  SalesObject: TSales);
begin
  inherited Create(AOwner);
   fSalesObject := SalesObject;
   dssalesshippingdetails.Dataset := fSalesObject.SalesShippingDetails.Dataset;
   DSMaster.dataset               := fSalesObject.Dataset;
(*   lblWeightUOM.Caption      := 'In ' +  GetUOMName(fSalesObject.Customer.ShippingAgent.DefaultWeightUOMID);
   lblGrossWeightUOM.Caption := 'In ' +  GetUOMName(fSalesObject.Customer.ShippingAgent.DefaultWeightUOMID);
   lblSizeUOM.Caption        := 'In Cubic ' +  GetUOMName(fSalesObject.Customer.ShippingAgent.DefaultSizeUOMID);*)
   if fSalesObject.SalesShippingDetails.count = 0 then begin
    fSalesObject.SalesShippingDetails.New;
    fSalesObject.SalesShippingDetails.WeightUOMID :=fSalesObject.Customer.ShippingAgent.DefaultWeightUOMID;
    fSalesObject.SalesShippingDetails.sizeUOMID :=fSalesObject.Customer.ShippingAgent.DefaultsizeUOMID;
   end;
end;

procedure TfmSalesShippingDetail.wwDBEdit1Enter(Sender: TObject);
begin
  inherited;
  SetControlFocus(edtFlightno);
end;

procedure TfmSalesShippingDetail.DefaultWeightUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  fSalesObject.SalesShippingDetails.WeightUOMID :=QryWeightUOMunitId.asInteger;
end;

procedure TfmSalesShippingDetail.cboDefaultsizeUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
   fSalesObject.SalesShippingDetails.SizeUOMID :=QrySizeUOMunitId.asInteger;

end;

procedure TfmSalesShippingDetail.cboDefaultWeightUOM1CloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  fSalesObject.SalesShippingDetails.WeightUOMID :=QryWeightUOMunitId.asInteger;
end;

initialization
  RegisterClassOnce(TfmSalesShippingDetail);

end.
