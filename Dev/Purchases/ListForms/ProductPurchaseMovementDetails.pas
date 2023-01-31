unit ProductPurchaseMovementDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TProductPurchaseMovementDetailsGUI = class(TBaseListingGUI)
    QryProductLookup: TERPQuery;
    QryProductLookupPARTSID: TIntegerField;
    QryProductLookupPARTNAME: TWideStringField;
    lblProduct: TLabel;
    cboProduct: TwwDBLookupCombo;
    qryMainSupplierName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainPOtype: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainOrderDate: TDateField;
    qryMainInvoiceDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainAmount: TFloatField;
    qryMainETADate: TDateField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClass: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    fDateto: TDatetime;
    fdateFrom: TDateTime;
    fiProductId: Integer;
    fsBasedonDate: String;
    procedure OpenProduct;
    procedure SetProductID(const Value: Integer);
    procedure SetdateFrom(const Value: TDateTime);
    procedure setDateto(const Value: TDatetime);
    procedure SetBasedonDate(const Value: String);
    { Private declarations }
  Protected
      procedure ReadnApplyGuiPrefExtra; Override;
      Procedure WriteGuiPrefExtra; Override;
      procedure SetGridColumns; Override;
  public
    Property ProductId :Integer read fiProductId write SetProductID;
    Property dateFrom :TDateTime read fdateFrom write SetdateFrom;
    Property Dateto :TDatetime Read fDateto write setDateto;
    Property BasedonDate :String read fsBasedonDate write SetBasedonDate;
    Procedure RefreshQuery; Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TProductPurchaseMovementDetailsGUI.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  OpenProduct;
  QryProductLookup.locate('Partname' , cboProduct.text , []);
  ProductID :=QryProductLookupPARTSID.asInteger;
  RefreshQuery;
end;

procedure TProductPurchaseMovementDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fDateto     :=0;
  fdateFrom   :=0;
  fiProductId :=0;
  fsBasedonDate:= 'I';
end;

procedure TProductPurchaseMovementDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  openProduct;
end;
procedure TProductPurchaseMovementDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
end;

Procedure TProductPurchaseMovementDetailsGUI.OpenProduct;
begin
  if QryProductLookup.active = False then begin
    QryProductLookup.connection := Qrymain.Connection;
    QryProductLookup.open;
  end;
end;
procedure TProductPurchaseMovementDetailsGUI.ReadnApplyGuiPrefExtra;
var
  s:STring;
begin
  inherited;
  if fiProductID =0 then begin
    s:=GuiPrefs.Node['General.ProductName'].AsString;
    if s<> '' then begin
       if QryProductLookup.active = false then QryProductLookup.open;
        if cboProduct.text <> s then begin
          cboProduct.text:=s;
          cboProductCloseUp(cboProduct ,QryProductLookup , nil,  True);
        end;
    end;
  end;
end;

procedure TProductPurchaseMovementDetailsGUI.RefreshQuery;
begin
  if grpFilters.itemindex = 0 then Qrymain.Parambyname('BasedonDate').asString := 'I' else Qrymain.Parambyname('BasedonDate').asString := 'O';
  Qrymain.Parambyname('DateFrom').AsDateTime  :=  filterDateFrom;
  Qrymain.Parambyname('Dateto').AsDateTime    :=  filterDateTo;
  Qrymain.Parambyname('ProductID').asInteger  := ProductId;
  inherited;
end;

procedure TProductPurchaseMovementDetailsGUI.SetBasedonDate(
  const Value: String);
begin
  fsBasedonDate := Value;
  if Value ='I' then grpFilters.itemindex := 0 else grpFilters.itemindex := 1;
end;

procedure TProductPurchaseMovementDetailsGUI.SetdateFrom(
  const Value: TDateTime);
begin
  fdateFrom := Value;
  dtFrom.Date := value;
end;

procedure TProductPurchaseMovementDetailsGUI.setDateto(const Value: TDatetime);
begin
  fDateto := Value;
  dtTo.Date:= Value;
end;

procedure TProductPurchaseMovementDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainProductId.Fieldname);
  RemoveFieldfromGrid(QrymainPurchaseLineId.Fieldname);
end;

procedure TProductPurchaseMovementDetailsGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  openProduct;
  QryProductLookup.Locate('PartsID' , Value , []);
  cboProduct.text :=QryProductLookupPartname.asString;
end;

procedure TProductPurchaseMovementDetailsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.ProductName'].AsString:=cboProduct.text;
end;

initialization
  RegisterClassOnce(TProductPurchaseMovementDetailsGUI);

end.

