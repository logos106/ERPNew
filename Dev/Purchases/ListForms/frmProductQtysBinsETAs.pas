{used to embed frmProductQtyBinGUI and frmProductETAinfo, also shows shipping containers}

unit frmProductQtysBinsETAs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls,BusObjShippingContainer,
  StdCtrls, Shader, DNMPanel, DNMSpeedButton, DBCtrls, Grids, Wwdbigrd,
  Wwdbgrid, MemDS, ImgList, ProgressDialog  , ProductQtyinCrossStockCompanies,
  ComCtrls, busobjorders;

type
  TfrmProductQtyBinETA = class(TBaseInputGUI)
    pnlFooter: TDNMPanel;
    BitBtn2: TDNMSpeedButton;
    qryShippingContainer: TERPQuery;
    qryShippingContainerShippingContainerID: TIntegerField;
    qryShippingContainerContainerName: TWideStringField;
    qryShippingContainerETDeparture: TDateField;
    qryShippingContainerShippingContainerStatus: TWideStringField;
    qryShippingContainerDeparturePoint: TWideStringField;
    qryShippingContainerVesselName: TWideStringField;
    qryShippingContainerETA: TDateField;
    qryShippingContainerArrivalPoint: TWideStringField;
    qryShippingContainerActive: TWideStringField;
    qryShipContainerDetails: TERPQuery;
    qryShipContainerDetailsPurchaseLineID: TIntegerField;
    qryShipContainerDetailsOrderDate: TDateField;
    qryShipContainerDetailsCommercialInvNo: TWideStringField;
    qryShipContainerDetailsSupplierWorkOrderNo: TWideStringField;
    qryShipContainerDetailsProductName: TWideStringField;
    qryShipContainerDetailsTotalAmountInc: TFloatField;
    qryShipContainerDetailsUnitOfMeasureQtySold: TWideStringField;
    qryShipContainerDetailsDepartment: TWideStringField;
    qryShipContainerDetailsProductDescription: TWideStringField;
    qryShipContainerDetailsShipContainerDetailID: TIntegerField;
    qryShipContainerDetailsShippingContainerID: TIntegerField;
    qryShipContainerDetailsGLOBALREF: TWideStringField;
    qryShipContainerDetailsSupplier: TWideStringField;
    qryShipContainerDetailsCustomerJob: TWideStringField;
    qryShipContainerDetailsPurchaseOrderID: TIntegerField;
    qryShipContainerDetailsUnits: TWideStringField;
    DSShipContainer: TDataSource;
    qryShipContainers: TERPQuery;
    qryShipContainersContainerName: TWideStringField;
    qryShipContainersPurchaseLineID: TIntegerField;
    qryShipContainerspartname: TWideStringField;
    qryShipContainersETDeparture: TDateField;
    qryShipContainersShippingContainerStatus: TWideStringField;
    qryShipContainersDeparturePoint: TWideStringField;
    qryShipContainersVesselName: TWideStringField;
    qryShipContainersETA: TDateField;
    qryShipContainersArrivalPoint: TWideStringField;
    qryShipContainersShippingContainerID: TIntegerField;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryShipContainerLookup: TERPQuery;
    Mnumain: TAdvPopupMenu;
    DefaultHeight1: TMenuItem;
    PgMain: TPageControl;
    TabPO: TTabSheet;
    spltop2: TSplitter;
    pnlshipcontainers: TDNMPanel;
    Label1: TLabel;
    grdShipping: TwwDBGrid;
    PnlETA: TDNMPanel;
    Label3: TLabel;
    TabStock: TTabSheet;
    pnlBins: TDNMPanel;
    Label2: TLabel;
    pnlCCS: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    splBottom1: TSplitter;
    btnHowTo: TDNMSpeedButton;
    btnAltProducts: TDNMSpeedButton;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure grdShippingDblClick(Sender: TObject);
    procedure DefaultHeight1Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure PgMainResize(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure btnAltProductsClick(Sender: TObject);
  private
    fShipContainer:TShippingContainer;
    fSaleLineID:integer;
    fiPurchaseLineID :integer;
    fiProductID: integer;
    fiClassID: integer;
    fbSalesOrderMode: boolean;
    fbBlockMode: boolean;
    ffrmEmbed1: TBaseInputGUI;
    ffrmEmbed2: TBaseInputGUI;
    fConnection : TERPConnection;
    css: TProductQtyinCrossStockCompaniesGUI;
    fAlternateProductselection: TNotifyEvent;
    fPOObj: TPurchaseOrder;
    procedure EmbedBins;
    procedure EmbedETA;
    Procedure EmbedCCS;
    procedure ReadnApplyGuiPrefExtra;
    Procedure WriteGuiPrefExtra;
    procedure beforeShowcss(Sender: TObject);
    procedure DefaultHeights;
    procedure SetAlternateProductselection(const Value: TNotifyEvent);
    procedure OnSelectCompany(Sender: TwwDbGrid);
  public
    property SaleLineID : integer read fSaleLineID write fSaleLineID;
    property ProductID: integer read fiProductID write fiProductID;
    {if salesline has not been assigned yet(by smart order)then use the purchaselineID}
    property PurchaseLineID: integer read fiPurchaseLineID write fiPurchaseLineID;

    property ClassID: integer read fiClassID write fiClassID;
    property SalesOrderMode: boolean read fbSalesOrderMode write fbSalesOrderMode;
    property BlockMode: boolean read fbBlockMode write fbBlockMode;
    property Connection :TERPConnection read fConnection write fConnection;
    Property AlternateProductselection :TNotifyEvent read fAlternateProductselection write SetAlternateProductselection;
    Property POObj :TPurchaseOrder read fPOObj write fPOObj;
  end;


implementation

{$R *.dfm}
uses
  CommonLib,ProductQtyLib,FastFuncs,tcDataUtils,frmProductQtyBinGUI,frmProductETAInfo,
  frmShippingContainerGUI, FormFactory, CommonFormLib, DNMLib, DocReaderObj,
  SalesForPOAutoCreate, GridLib, tcConst, BusObjConst, AppEnvironment;


procedure TfrmProductQtyBinETA.EmbedETA;
begin
  If FormStillOpen('TfrmProductETAInfoGUI', 99) then
    ffrmEmbed2 := TBaseInputGUI(FindExistingComponent('TfrmProductETAInfoGUI', 99));

  If not Assigned(ffrmEmbed2) then
    ffrmEmbed2 := TBaseInputGUI(GetComponentByClassName('TfrmProductETAInfoGUI',False,Self,False,False,99));

  If Assigned(ffrmEmbed2) then Begin
    try
      ffrmEmbed2.Parent :=    pnlETA;
      ffrmEmbed2.BorderStyle := bsNone;
      TfrmProductETAInfoGUI(ffrmEmbed2).btnSalesOrder.Visible := False;
      TfrmProductETAInfoGUI(ffrmEmbed2).btnInvoice.Visible := False;
      TfrmProductETAInfoGUI(ffrmEmbed2).grdETAs.Height := 138;

//      TfrmProductETAInfoGUI(ffrmEmbed2).grdETAs.Height := Trunc(Self.Height * 0.2);

      TfrmProductETAInfoGUI(ffrmEmbed2).grdETAs.Width := ffrmEmbed2.Width;
      TfrmProductETAInfoGUI(ffrmEmbed2).grdETAs.Anchors :=  [akLeft,akTop,akBottom,akRight];
      TfrmProductETAInfoGUI(ffrmEmbed2).grdETAs.ReadOnly := True;

      TfrmProductETAInfoGUI(ffrmEmbed2).KeyID := Self.KeyID;
      TfrmProductETAInfoGUI(ffrmEmbed2).SalesOrderMode := false;
      TfrmProductETAInfoGUI(ffrmEmbed2).BlockMode := true;
      ffrmEmbed2.Align := alClient;
      ffrmEmbed2.Show;
    finally
      ffrmEmbed2 := nil;
    end;
  end;
end;



procedure TfrmProductQtyBinETA.DefaultHeight1Click(Sender: TObject);
begin
  DefaultHeights;
end;
procedure TfrmProductQtyBinETA.DefaultHeights;
var
  i:Integer;
begin
  inherited;
  i := Self.TabPO.Height;
  i := trunc(i/2);
  pnlshipcontainers.Height := i;
  i := Self.TabStock.Height;
  i := trunc(i/3);
  pnlCCS.Height := i;
end;

procedure TfrmProductQtyBinETA.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmCrossStockCompanies' , 0 , nil, true);
  if Assigned(css) then
    css.RefreshQuery;
end;

procedure TfrmProductQtyBinETA.EmbedBins;
begin
  If FormStillOpen('TProductQtyBinGUI', 99) then
    ffrmEmbed1 := TBaseInputGUI(FindExistingComponent('TProductQtyBinGUI', 99));

  If not Assigned(ffrmEmbed1) then
    ffrmEmbed1 := TBaseInputGUI(GetComponentByClassName('TProductQtyBinGUI',False,Self,False,False,99));

  If Assigned(ffrmEmbed1) then Begin
    try
      ffrmEmbed1.Parent :=    pnlBins;
      ffrmEmbed1.BorderStyle := bsNone;

      TProductQtyBinGUI(ffrmEmbed1).ClassID := Self.ClassID;
      TProductQtyBinGUI(ffrmEmbed1).ProductID := Self.KeyID;
      TProductQtyBinGUI(ffrmEmbed1).grdbins.ReadOnly := True;
      TProductQtyBinGUI(ffrmEmbed1).grdPartQtyLines.ReadOnly := True;
      ffrmEmbed1.Align := alClient;

      if Self.Connection <> nil then TProductQtyBinGUI(ffrmEmbed1).Connection := Self.Connection; 

      ffrmEmbed1.Show;   
    finally
  //    ffrmEmbed1 := nil;
    end;
  end;
end;

procedure TfrmProductQtyBinETA.beforeShowcss(Sender: TObject);
begin
   css.AddProductname(getProduct(KeyId));
   css.Grdmain.borderStyle := bssingle;
   css.OnGridDataSelect := OnSelectCompany;
   css.CloseOnRecSelect := False;
end;
procedure TfrmProductQtyBinETA.OnSelectCompany(Sender: TwwDbGrid);
var
  Msg:String;
  fs:String;
begin
  if POObj  <> nil then begin
  POObj.Connection.CommitTransaction;
  try
    fs:=POObj.Comments;
    if CreateSalesForPO(POObj , POObj.lines.Id, GridLib.ActiveFieldName(Sender), Msg, self) then begin
      //MessageDlgXP_Vista('Failed to Create Sales Order Automatically.'+NL+Msg, mtWarning, [mbOK], 0);
      if fs<> POObj.Comments then fs:= StringReplace(POObj.Comments , fs , '' ,[] );
      if fs <> '' then MessageDlgXP_Vista(fs, mtInformation, [mbOK], 0);
      POObj.SendEvent(BusObjEvent_Change, BusObjEvent_CrosscompanySaleCreated, POObj);
      POObj.Connection.CommitTransaction;
      Appenv.AppDB.save;
      Self.CloseIt(true);
    end else begin
      POObj.Connection.RollbackTransaction;
    end;
  finally
    POObj.Connection.beginTransaction;
  end;
  end;
end;
procedure TfrmProductQtyBinETA.EmbedCCS;
begin
  if css = nil then css:= TProductQtyinCrossStockCompaniesGUI(Getcomponentbyclassname('TProductQtyinCrossStockCompaniesGUI' , False , nil , False));
  css.GrdmainForPanel(pnlCCS , beforeShowcss);

  (*css:= TProductQtyinCrossStockCompaniesGUI.Create(Self);
  css.AddProductname(getProduct(KeyId));*)

  (*css.RefreshQuery;
  css.grdmain.Parent := pnlCCS;
  css.grdmain.align := alClient;

  css.Parent := pnlCCS;
  css.align := alclient;
  css.BorderStyle := bsNone;
  css.fbIgnoreQuerySpeed := true;
  try
    css.Show;
    css.HeaderPanel.visible := false;
    css.FooterPanel.visible := false;
    css.GrdmainForPanel(pnlCCS , beforeShowHistoryList);
  except
    FreeAndNil(css);
  end;   *)

end;

procedure TfrmProductQtyBinETA.FormCreate(Sender: TObject);
begin
  DefaultHeights;
  fbIgnoreAccessLevels := true;
  inherited;
  fShipContainer := TShippingContainer.Create(Self);
end;

procedure TfrmProductQtyBinETA.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmProductQtyBinETA.btnAltProductsClick(Sender: TObject);
begin
  inherited;
  if assigned(fAlternateProductselection) then begin
    fAlternateProductselection(sender);
    Self.Close;
  end;
end;

procedure TfrmProductQtyBinETA.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Cross Company Stock');
end;

procedure TfrmProductQtyBinETA.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPrefExtra;
  ffrmEmbed1 := nil;
  Self.Connection := nil;
  Action := cafree;
  inherited;
end;

procedure TfrmProductQtyBinETA.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    ReadnApplyGuiPrefExtra;
    ProductID := KeyID;
    if qryShipContainers.Active then qryShipContainers.Close;

    if Self.Connection <> nil then qryShipContainers.Connection := Self.Connection;

    if Self.SaleLineID > 0 then begin
      qryShipContainers.SQL.Add(' WHERE PL.SaleLineID = :xSaleLineID');
      qryShipContainers.SQL.Add('GROUP BY shippingContainerID');
      qryShipContainers.SQL.Add('order by SC.ETA');
      qryShipContainers.Params.ParamByName('xSaleLineID').AsInteger := Self.SaleLineID ;
    end (*else begin
      if Self.PurchaseLineID > 0 then begin
        qryShipContainers.SQL.Add(' WHERE PL.PurchaseLineID = :xPurchaseLineID');
        qryShipContainers.SQL.Add('GROUP BY shippingContainerID');
        qryShipContainers.SQL.Add('order by SC.ETA');
        qryShipContainers.Params.ParamByName('xPurchaseLineID').AsInteger := Self.PurchaseLineID;
      end *)
    else begin
        {only Id is ProductID}
        qryShipContainers.SQL.Add(' WHERE PartsID = :xPartsID');
        qryShipContainers.SQL.Add(' AND SC.Active = ''T'' ');
        qryShipContainers.SQL.Add('GROUP BY shippingContainerID');
        qryShipContainers.SQL.Add('order by SC.ETA');
        qryShipContainers.Params.ParamByName('xPartsID').AsInteger := Self.ProductID;
      //end;
    end;
    qryShipContainers.Open;

    EmbedBins;
    EmbedETA;
    EmbedCCS;


    (*{bottom aligned components in order}
    splBottom1.top :=Self.Height;
    pnlCCS.top :=Self.Height;
    pnlFooter.top :=Self.Height;

    {bottom aligned components in order}
    pnlETA.Top   :=0;
    spltop2.Top :=0;
    pnlshipcontainers.Top :=0;
    splTop1.Top :=0;
    pnlBins.Top :=0;
    pnlTop.Top :=0;*)

  finally
    pgmain.activepage := tabStock;
    RealignTabControl(pgMain, 1);
    EnableForm;
  end;  
end;

procedure TfrmProductQtyBinETA.FormResize(Sender: TObject);
begin
  inherited;
(*  If Assigned(ffrmEmbed1) then Begin
    pnlBins.Height := trunc((Self.height - 100) * 0.50); {holds 2 of the embedded forms}
    TProductQtyBinGUI(ffrmEmbed1).grdPartQtyLines.Height := Trunc((pnlBins.Height - 50) * 0.5);
    grdShipping.Height := trunc((Self.Height - 150) * 0.23);
  end;*)
  DefaultHeights;
  RealignTabControl(pgMain, 1);
end;

procedure TfrmProductQtyBinETA.grdShippingDblClick(Sender: TObject);
  var
  Frm:TComponent;
begin
  inherited;
  Frm := GetComponentByClassName('TfrmShipContainer');
  if Assigned(Frm) then begin //if has access
    with TfrmShipContainer(Frm) do begin
      AttachObserver(Self);
      TfrmShipContainer(Frm).KeyID := qryShipContainers.FieldByName('ShippingContainerID').AsInteger;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfrmProductQtyBinETA.PgMainResize(Sender: TObject);
begin
  inherited;
  //RealignTabControl(pgMain, 1);
end;

procedure TfrmProductQtyBinETA.ReadnApplyGuiPrefExtra;
begin
  if GuiPrefs.Node.Exists('Options.pnlshipcontainers')  then pnlshipcontainers.height := GuiPrefs.Node['Options.pnlshipcontainers'].asInteger;
  if GuiPrefs.Node.Exists('Options.pnlCCS')             then pnlCCS.height            := GuiPrefs.Node['Options.pnlCCS'].asInteger;
end;

procedure TfrmProductQtyBinETA.SetAlternateProductselection(const Value: TNotifyEvent);
begin
  fAlternateProductselection := Value;
  btnAltProducts.visible := Assigned(fAlternateProductselection);
end;

procedure TfrmProductQtyBinETA.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['Options.pnlshipcontainers'].asInteger:= pnlshipcontainers.height;
  GuiPrefs.Node['Options.pnlCCS'].asInteger           := pnlCCS.height;
end;

initialization
  RegisterClassOnce(TfrmProductQtyBinETA);
  with FormFact do begin
    RegisterMe(TfrmProductQtyBinETA, 'TProductListGUI_OnOrder_OnOrderRequest=PARTSID');
    RegisterMe(TfrmProductQtyBinETA, 'TProductQtylistGUI_OnOrder_OnOrderRequest=PARTSID');
    RegisterMe(TfrmProductQtyBinETA, 'TProductionPartStatusGUI_OnOrderQty_OnOrderRequest=PARTSID');
    //RegisterMe(TfrmProductQtyBinETA, 'TProductSalesListGUI_On Order=PartsID');
    RegisterMe(TfrmProductQtyBinETA, 'TProductSalesListFormSoldGUI_On Order=PartsID');
    RegisterMe(TfrmProductQtyBinETA, 'TProductSalesListFormNotSoldGUI_On Order=PartsID');

  end;
end.
