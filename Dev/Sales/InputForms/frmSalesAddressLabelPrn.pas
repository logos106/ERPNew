unit frmSalesAddressLabelPrn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel, wwdblook, wwcheckbox, DBCtrls, wwradiogroup, wwclearbuttongroup;

type
  TfmSalesAddressLabelPrn = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    qrysales: TERPQuery;
    qrysalesSaleno: TWideStringField;
    qrysalesSaleId: TIntegerField;
    qrysalesCustomerName: TWideStringField;
    qrysalesType: TWideStringField;
    qrysalesshipdate: TDateField;
    qrysalesnoofboxes: TLargeintField;
    qrysalesshipped: TFloatField;
    qrysalesIsRefund: TWideStringField;
    qrysalesIsSalesOrder: TWideStringField;
    qrysalesIsInvoice: TWideStringField;
    qrysalesislayby: TWideStringField;
    grpFilters: TwwRadioGroup;
    chkIncludeBackorders: TwwCheckBox;
    Label2: TLabel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cbosalesID: TwwDBLookupCombo;
    Label1: TLabel;
    Label3: TLabel;
    edtNoOfcost: TEdit;
    procedure chkIncludeBackordersClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure edtNoOfcostKeyPress(Sender: TObject; var Key: Char);
    procedure cbosalesIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cmdOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
  private
    Procedure RefreshQuery;
    procedure ClearSelection;
  Protected
    procedure OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean); Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, saleslib, AppEnvironment, SystemLib;

{$R *.dfm}
procedure TfmSalesAddressLabelPrn.chkIncludeBackordersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmSalesAddressLabelPrn.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmSalesAddressLabelPrn.cmdOKClick(Sender: TObject);
begin
  inherited;
  if not(isinteger(edtNoOfcost.text)) then exit;
  if strtoint(edtNoOfcost.text) =0 then exit;

  fbReportSQLSupplied := true;
  try
    PrintTemplateReport('Address Labels', SalesAddressLabelSQL( strtoint(edtNoOfcost.text), QrysalesSaleID.AsInteger), not(Appenv.Employee.ShowPreview) and not(devmode), 1);
  finally
    fbReportSQLSupplied := False;
  end;
  ClearSelection;
end;

procedure TfmSalesAddressLabelPrn.edtNoOfcostKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if ((Key <'0') or (Key > '9')) and  (Key <> #8 ) then Key := Chr(0);
end;



procedure TfmSalesAddressLabelPrn.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if grpFilters.ItemIndex = 1 then qrysales.filter :=  'isinvoice =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 2 then qrysales.filter := 'isSalesOrder =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 3 then qrysales.filter := 'IsRefund =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 4 then qrysales.filter :=  'IsLayby =' +Quotedstr('T')
  else qrysales.filter := '';
  qrysales.filtered := qrysales.filter <> '';
  ClearSelection;
end;

procedure TfmSalesAddressLabelPrn.OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  //inherited;
end;

procedure TfmSalesAddressLabelPrn.RefreshQuery;
begin
  if KeyId > 0 then
    exit;
  if qrysales.ParamByName('IncludeBos').asString <> booleantoStr(chkIncludeBackorders.checked) then begin
    closedb(qrysales);
    qrysales.ParamByName('IncludeBos').asString := booleantoStr(chkIncludeBackorders.checked);
    opendb(qrysales);
    ClearSelection;
  end;
end;

procedure TfmSalesAddressLabelPrn.cbosalesIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  edtNoOfcost.text := inttostr(QrysalesNoofboxes.asInteger);
  Setcontrolfocus(edtNoOfcost);
end;
procedure TfmSalesAddressLabelPrn.FormShow(Sender: TObject);
var
  x:Integer;
begin
  inherited;
  if KeyId <> 0 then
  begin
    qrySales.SQL.Clear;
    qrySales.SQL.Add('Select S.InvoiceDocNumber as Saleno, S.SaleId as SaleId, S.Customername as CustomerName,');
    qrySales.SQL.Add('If(S.IsRefund="T","Refund",If(S.IsInvoice="T","Invoice",If(S.IsSalesOrder="T" , "Sales Order" ,"Layby"))) as Type,');
    qrySales.SQL.Add('S.ShipDate as shipdate, S.noofboxes, Sum(SL.shipped) as shipped, S.IsRefund as IsRefund,');
    qrySales.SQL.Add('S.IsSalesOrder as IsSalesOrder, S.IsInvoice as IsInvoice, S.islayby as islayby');
    qrySales.SQL.Add('From tblSales S inner join tblsaleslines SL on S.saleID = SL.SaleId');
    qrySales.SQL.Add('where S.SaleId=' + IntToStr(KeyId));
  end;
  openQueries;
  if GuiPrefs.Active =False then GuiPrefs.Active := TRue;
  if GuiPrefs.Node.Exists('Options.IncludeBackorders') then
      chkIncludeBackorders.checked :=  GuiPrefs.Node['Options.IncludeBackorders'].asBoolean;
  if GuiPrefs.Node.Exists('Grpfilters') then begin
    x := GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
    if x > 0 then if grpFilters.Items.Count >= x then grpFilters.ItemIndex := x - 1;
  end;
  ClearSelection;
  if KeyId > 0 then
  begin
    cboSalesId.Text := qrySales.FieldByName('SaleId').AsString;
    cbosalesIDCloseUp(Self, qrySales, nil, true);
  end;
end;
Procedure TfmSalesAddressLabelPrn.ClearSelection;
begin
  if KeyId = 0 then
  begin
    edtNoOfcost.Text := '';
    cbosalesID.Text := '';
    setcontrolfocus(cbosalesID);
  end;
end;
procedure TfmSalesAddressLabelPrn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GuiPrefs.Node['Options.IncludeBackorders'].asBoolean:= chkIncludeBackorders.checked;
  GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger := grpFilters.ItemIndex + 1;
  Action := caFree;
end;

Initialization
  RegisterClassOnce(TfmSalesAddressLabelPrn);

end.

