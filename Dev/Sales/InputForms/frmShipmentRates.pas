unit frmShipmentRates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, BusObjSales,
  Grids, AdvObj, BaseGrid, AdvGrid, ShipIntegrationTypes, clisted, AdvEdit,
  Sales, wwdbgrid;

type
  TfmShipmentRates = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnGetRates: TDNMSpeedButton;
    grdRates: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    lblServices: TLabel;
    Label3: TLabel;
    lstPackageType: TCheckListEdit;
    Label4: TLabel;
    edtWeight: TAdvEdit;
    Label5: TLabel;
    edtLength: TAdvEdit;
    edtWidth: TAdvEdit;
    edtHeight: TAdvEdit;
    Label6: TLabel;
    lstService: TCheckListEdit;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure btnGetRatesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdRatesCellChanging(Sender: TObject; OldRow, OldCol, NewRow,
      NewCol: Integer; var Allow: Boolean);
    procedure grdRatesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnCompletedClick(Sender: TObject);
    procedure grdRatesDblClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    fSale: TBaseSaleGUI;
    Providers: set of TPackageProvider;
    procedure ResizeGrid;
    procedure ClearGrid;
    procedure GetRates;
    procedure GetProviders;
    procedure GetPackageTypes;
    procedure GetServices;
    procedure AddGridRow(aServiceType, aPackageType: integer; aProvider, aPackage, aService, aRate, aDate, aNote: string);
    procedure SetShipmentDetails(RatesObj: TObject);
    function GetSale: TSales;
    function DoShipment: boolean;
    function CheckShipAddress: boolean;
//    procedure grdAddressMainonDblClick(Sender: TObject);
    procedure DoOnGridDataSelect(Sender: TwwDbGrid);
  protected
    property Sale: TSales read GetSale;
  public
    property SaleForm: TBaseSaleGUI read fSale write fSale;
  end;

var
  fmShipmentRates: TfmShipmentRates;

  procedure DoShipmentRates(aSaleForm: TBaseSaleGUI);

implementation

uses
  ibxezrates, AppEnvironment, BusObjCountries, CommonLib, ibxuspsrates,
  ibxezship, Preferences, frmShippingAllocation, BusObjShipment,
  ShipIntegrationUtils, ShipAddressListForm, ibxUPSRates, tcTypes;

{$R *.dfm}

const
  Col_Provider = 0;
  Col_Package = 1;
  Col_Service = 2;
  Col_Rate = 3;
  Col_Date = 4;
  Col_Note = 5;


procedure DoShipmentRates(aSaleForm: TBaseSaleGUI);
var
  form: TfmShipmentRates;
begin
  form := TfmShipmentRates.Create(aSaleForm);
  try
//    aSaleForm.AttachObserver(form);
    form.SaleForm := aSaleForm;
    form.FormStyle := fsmdiChild;
    form.BringToFront;
  finally
//    form.Free;
  end;
end;

{ TfmShipmentRates }

procedure TfmShipmentRates.AddGridRow(aServiceType, aPackageType: integer; aProvider, aPackage, aService, aRate,
  aDate, aNote: string);
begin
  if (grdRates.RowCount > 2) or (grdRates.Cells[Col_Provider,1] <> '') then
    grdRates.RowCount := grdRates.RowCount + 1;
  grdRates.Objects[Col_Service, grdRates.RowCount -1] := TObject(aServiceType);
  grdRates.Objects[Col_Package, grdRates.RowCount -1] := TObject(aPackageType);
  grdRates.Cells[Col_Provider, grdRates.RowCount -1] := aProvider;
  grdRates.Cells[Col_Package, grdRates.RowCount -1] := aPackage;
  grdRates.Cells[Col_Service, grdRates.RowCount -1] := aService;
  if aRate <> '' then begin
    grdRates.Cells[Col_Rate, grdRates.RowCount -1] := FloatToStrF(StrToFloat(aRate), ffCurrency, 15, 2);
  end
  else
    grdRates.Cells[Col_Rate, grdRates.RowCount -1] := aRate;
  grdRates.Cells[Col_Date, grdRates.RowCount -1] := aDate;
  grdRates.Cells[Col_Note, grdRates.RowCount -1] := aNote;
end;

procedure TfmShipmentRates.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmShipmentRates.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if DoShipment then begin
    //ModalResult := mrOk;
    Close;
  end;
end;

procedure TfmShipmentRates.btnGetRatesClick(Sender: TObject);
begin
  inherited;
  GetRates;
end;

function TfmShipmentRates.CheckShipAddress: boolean;
var
  AddressList: TShipAddressListGUI;
begin
  result := Sale.ShipToID > 0;
  if not result then begin
    if MessageDlgXP_Vista('This Sale requires a shipment address, would you like to select one from the list now?.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin

      AddressList := TShipAddressListGUI.Create(Application);
        //grdMain.OnDblClick := grdAddressMainonDblClick;
      AddressList.OnGridDataSelect := DoOnGridDataSelect;
      AddressList.CloseOnRecSelect := true;
      AddressList.CustomerID := Sale.CustomerID;
      AddressList.ShowModal;
    end;
  end;
end;

procedure TfmShipmentRates.ClearGrid;
var
  I: integer;
begin
  grdRates.RowCount := 2;
  for I := 0 to grdRates.ColCount -1 do
    grdRates.Cells[I,1] := '';
end;

function TfmShipmentRates.DoShipment: boolean;
var
  Form: TBaseInputGUI;
  ShipmentList: TShipmentList;
begin
  result := false;
  if TSalesShipments.ShipmentExistsForSale(Sale.ID) then begin
    MessageDlgXP_Vista('This Sale already has a Shipment so can not be Shipped again.', mtInformation, [mbOk], 0);
    exit;
  end;

  if not CheckShipAddress then
    exit;

  if (SaleForm.ClassNameIs('TSalesOrder')) and (not Appenv.CompanyPrefs.AllowShipmentsFromSalesOrder) then begin
    if MessageDlgXP_Vista('"Allow Processing Shipments from Sales Order" is not selected in EDI integration Preferences.',mtConfirmation,[mbOk],0, nil,'','',False, nil ,'Open Preference Form' ) = 100 then
      OpenPrefform('EDI and Integration', 'chkAllowShipmentsFromSalesOrder' ,1 ,True, '' , '');
    exit;
  end;

  if grdRates.Row < 1 then begin
    CommonLib.MessageDlgXP_Vista('Select the shipping details you wish to use from the grid.', mtInformation, [mbOk], 0);
    exit;
  end;
  if grdRates.Cells[Col_Provider, grdRates.Row] = '' then begin
    CommonLib.MessageDlgXP_Vista('No shipping Provider on this line.', mtInformation, [mbOk], 0);
    exit;
  end;
  if grdRates.Cells[Col_Package, grdRates.Row] = '' then begin
    CommonLib.MessageDlgXP_Vista('No shipping Package Type on this line.', mtInformation, [mbOk], 0);
    exit;
  end;
  if grdRates.Cells[Col_Service, grdRates.Row] = '' then begin
    CommonLib.MessageDlgXP_Vista('No shipping Service on this line.', mtInformation, [mbOk], 0);
    exit;
  end;
//  if Sale.ShipToID < 1 then begin
//    CommonLib.MessageDlgXP_Vista('Please select a Ship To Address from the Ship To List on the Sale.', mtInformation, [mbOk], 0);
//    exit;
//  end;

  ShipmentList := TShipmentList.CreateWithNewConn(nil);
  try
    ShipmentList.Connection.BeginTransaction;
    try
      ShipmentList.LoadSelect('SaleID = ' + IntToStr(Sale.Id));
      if ShipmentList.Count = 0 then begin
        ShipmentList.New;
        ShipmentList.SaleId := Sale.ID;
        ShipmentList.PostDb;
      end;

      ShipmentList.Shipments.New;
      if Pos('FedEx',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then
        ShipmentList.Shipments.Provider := pFedEx
      else if Pos('UPS',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then
        ShipmentList.Shipments.Provider := pUPS
      else if Pos('Canada Post',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then
        ShipmentList.Shipments.Provider := pCanadaPost
      else if Pos('USPS',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then begin
        ShipmentList.Shipments.Provider := pUSPS;
        if Pos('Endicia',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then
          ShipmentList.Shipments.PostageProvider := Ord(ppEndicia)
        else if Pos('Stamps',grdRates.Cells[Col_Provider, grdRates.Row]) > 0 then
          ShipmentList.Shipments.PostageProvider := Ord(ppStamps);
      end;

      ShipmentList.Shipments.ServiceType := TibxezshipServiceTypes(Integer(grdRates.Objects[Col_Service, grdRates.Row]));
      ShipmentList.Shipments.ShipAddressId := Sale.ShipToID;
      ShipmentList.Shipments.PostDb;
      { create at least one new package line }
      ShipmentList.Shipments.Packages.New;

      if ShipmentList.Shipments.Provider = pUPS then
        ShipmentList.Shipments.Packages.PackageWeight := IntToStr(Trunc(StrToFloat(edtWeight.Text))) + ' lbs 0 oz'
      else
        ShipmentList.Shipments.Packages.PackageWeight := edtWeight.Text;
      ShipmentList.Shipments.Packages.PackageWidth := edtWidth.IntValue;
      ShipmentList.Shipments.Packages.PackageHeight := edtHeight.IntValue;
      ShipmentList.Shipments.Packages.PackageLength := edtLength.IntValue;

      ShipmentList.Shipments.Packages.PackageType := TibxezshipPackageTypes(Integer(grdRates.Objects[Col_Package, grdRates.Row]));
      ShipmentList.Shipments.Packages.PostDb;
      ShipmentList.UpdatePackageReferences(Sale.CustPONumber);
      ShipmentList.AutoAllocateSales;
      if ShipmentList.Save then begin
        ShipmentList.Connection.CommitTransaction;


        form := TBaseInputGUI(GetComponentByClassName('TfmShippingAllocation',false));
        if not Assigned(form) then exit;
        form.KeyID := Sale.ID;
        form.AttachObserver(SaleForm);
        if Self.accesslevel >= 3 then form.Accesslevel := 5;
        form.FormStyle := fsMDIChild;
        form.BringToFront;

        //ModalResult := mrOk;
        Close;
      end
      else begin
        ShipmentList.Connection.RollbackTransaction;

      end;


    finally;
      if ShipmentList.Connection.InTransaction then
        ShipmentList.Connection.RollbackTransaction;
    end;
  finally
    ShipmentList.Free;
  end;
end;

procedure TfmShipmentRates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmShipmentRates.FormCreate(Sender: TObject);
begin
  inherited;
  GetProviders;
  GetPackageTypes;
  GetServices;
end;

procedure TfmShipmentRates.FormResize(Sender: TObject);
begin
  inherited;
  ResizeGrid;
end;

procedure TfmShipmentRates.GetPackageTypes;
var
  PackageProvider: TPackageProvider;
  Rec: TPackageTypeRec;
begin
  lstPackageType.Items.Clear;
  for PackageProvider in Providers do begin
    for Rec in PackageTypeList do begin
      if PackageProvider in rec.Providers then begin
        if lstPackageType.Items.IndexOf(rec.Name) < 0 then
           lstPackageType.Items.Add(rec.Name);
      end;
    end;
    case PackageProvider of
      ppFedEx:
        begin
          if AppEnv.CompanyPrefs.FedExConfig.DefaultPackage <> '' then
            lstPackageType.Checked[lstPackageType.Items.IndexOf(AppEnv.CompanyPrefs.FedExConfig.DefaultPackage)] := true;
        end;
      ppUPS:
        begin
          if AppEnv.CompanyPrefs.UPSConfig.DefaultPackage <> '' then
            lstPackageType.Checked[lstPackageType.Items.IndexOf(AppEnv.CompanyPrefs.UPSConfig.DefaultPackage)] := true;
        end;
      ppUSPS:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.DefaultPackage <> '' then
            lstPackageType.Checked[lstPackageType.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.DefaultPackage)] := true;
        end;
      ppCanadaPost:;
      ppUSPSEndicia:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultPackage <> '' then
            lstPackageType.Checked[lstPackageType.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultPackage)] := true;
        end;
      ppUSPSStamps:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.StampsDefaultPackage <> '' then
            lstPackageType.Checked[lstPackageType.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.StampsDefaultPackage)] := true;
        end;
    end;
  end;
end;

procedure TfmShipmentRates.GetProviders;
var
  PackageProvider: TPackageProvider;
begin
  Providers := [];
  if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then begin
    if (AppEnv.CompanyPrefs.USPSConfig.USPSUserID <> '') and
       (AppEnv.CompanyPrefs.USPSConfig.USPSPassword <> '') then begin
      Providers := Providers + [ppUSPS];
      if (edtWeight.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.DefaultWeight > 0) then
        edtWeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.DefaultWeight;
      if (edtLength.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.DefaultLength > 0) then begin
        edtLength.FloatValue := AppEnv.CompanyPrefs.USPSConfig.DefaultLength;
        edtWidth.FloatValue := AppEnv.CompanyPrefs.USPSConfig.DefaultWidth;
        edtHeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.DefaultHeight;
      end;
    end;
    if (AppEnv.CompanyPrefs.USPSConfig.EndiciaAccountNumber <> '') and
       (AppEnv.CompanyPrefs.USPSConfig.EndiciaPassword <> '') then begin
      Providers := Providers + [ppUSPSEndicia];
      if (edtWeight.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultWeight > 0) then
        edtWeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultWeight;
      if (edtLength.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultLength > 0) then begin
        edtLength.FloatValue := AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultLength;
        edtWidth.FloatValue := AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultWidth;
        edtHeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultHeight;
      end;
    end;
    if (AppEnv.CompanyPrefs.USPSConfig.StampsUserID <> '') and
       (AppEnv.CompanyPrefs.USPSConfig.StampsAccountNumber <> '') and
       (AppEnv.CompanyPrefs.USPSConfig.StampsPassword <> '') then begin
      Providers := Providers + [ppUSPSStamps];
      if (edtWeight.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.StampsDefaultWeight > 0) then
        edtWeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.StampsDefaultWeight;
      if (edtLength.FloatValue = 0) and (AppEnv.CompanyPrefs.USPSConfig.StampsDefaultLength > 0) then begin
        edtLength.FloatValue := AppEnv.CompanyPrefs.USPSConfig.StampsDefaultLength;
        edtWidth.FloatValue := AppEnv.CompanyPrefs.USPSConfig.StampsDefaultWidth;
        edtHeight.FloatValue := AppEnv.CompanyPrefs.USPSConfig.StampsDefaultHeight;
      end;
    end;
  end;
  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then begin
    Providers := Providers + [ppUPS];
    if (edtWeight.FloatValue = 0) and (AppEnv.CompanyPrefs.UPSConfig.DefaultWeight > 0) then
      edtWeight.FloatValue := AppEnv.CompanyPrefs.UPSConfig.DefaultWeight;
    if (edtLength.FloatValue = 0) and (AppEnv.CompanyPrefs.UPSConfig.DefaultLength > 0) then begin
      edtLength.FloatValue := AppEnv.CompanyPrefs.UPSConfig.DefaultLength;
      edtWidth.FloatValue := AppEnv.CompanyPrefs.UPSConfig.DefaultWidth;
      edtHeight.FloatValue := AppEnv.CompanyPrefs.UPSConfig.DefaultHeight;
    end;
  end;
  if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then begin
    Providers := Providers + [ppFedEx];
    if (edtWeight.FloatValue = 0) and (AppEnv.CompanyPrefs.FedExConfig.DefaultWeight > 0) then
      edtWeight.FloatValue := AppEnv.CompanyPrefs.FedExConfig.DefaultWeight;
    if (edtLength.FloatValue = 0) and (AppEnv.CompanyPrefs.FedExConfig.DefaultLength > 0) then begin
      edtLength.FloatValue := AppEnv.CompanyPrefs.FedExConfig.DefaultLength;
      edtWidth.FloatValue := AppEnv.CompanyPrefs.FedExConfig.DefaultWidth;
      edtHeight.FloatValue := AppEnv.CompanyPrefs.FedExConfig.DefaultHeight;
    end;
  end;

  lblServices.Caption := '';
  if Providers <> [] then begin
    for PackageProvider in Providers do begin
      if lblServices.Caption <> '' then lblServices.Caption := lblServices.Caption + ', ';
        lblServices.Caption := lblServices.Caption + PackageProviderToStr(PackageProvider)
    end;
  end
  else
    lblServices.Caption := 'No Shipping Options set up in Preferences > EDI Integration';

end;

procedure TfmShipmentRates.GetRates;
var
  PackageProvider: TPackageProvider;
  EzRates: TibxEzRates;  // TibxezratesPackageTypes
  UPSRates: TibxUPSRates;
  USPSRates: ibxuspsrates.TibxUSPSRates;
  PackageTypes: set of TibxezshipPackageTypes;
  PackageType: TibxezshipPackageTypes;
  I: integer;
  ServiceTypes: set of TibxezratesRequestedServices;
  ServiceType: TibxezratesRequestedServices;
  Rate: string;
  Prog: TProgressDialog;
  ProviderCount: integer;

  procedure GetPackageTypes(aPackageProvider: TPackageProvider);
  var
    ptr: TPackageTypeRec;
  begin
    PackageTypes := [];
    for ptr in PackageTypeList do begin
      if aPackageProvider in ptr.Providers then begin
        if lstPackageType.Items.IndexOf(ptr.Name) > -1 then begin
          if lstPackageType.Checked[lstPackageType.Items.IndexOf(ptr.Name)] then
            Include(PackageTypes, ptr.Package);
        end;
      end;
    end;
  end;

  procedure GetServices(aPackageProvider: TPackageProvider);
  var
    str: TShipServiceTypeRec;
  begin
    ServiceTypes := [];
    for str in ShipServiceTypeList do begin
      if aPackageProvider in str.Providers then begin
        if lstService.Items.IndexOf(str.Name) > -1 then begin
          if lstService.Checked[lstService.Items.IndexOf(str.Name)] then
            Include(ServiceTypes, TibxezratesServiceTypes(str.Service));
        end;
      end;
    end;
  end;

begin
  ClearGrid;

  if Providers = [] then begin
    CommonLib.MessageDlgXP_Vista('There are no Shipping Services configured in Preferences > EDI Integration',mtInformation, [mbOk], 0);
    exit;
  end;

  ProviderCount := 0;

  for PackageProvider in Providers do
    Inc(ProviderCount);

  EzRates := TibxEzRates.Create(nil);
  UPSRates := TibxUPSRates.Create(nil);

  USPSRates := ibxuspsrates.TibxUSPSRates.Create(nil);
  Prog := TProgressDialog.Create(nil);

  try
    Prog.MaxValue := ProviderCount + 1;
    Prog.Step := 1;
    Prog.Value := 0;
    Prog.Caption := 'Working ..';
    Prog.Execute;

    for PackageProvider in Providers do begin
      Prog.StepIt;
      Prog.Message := 'Getting rates for ' + PackageProviderToStr(PackageProvider);

      GetPackageTypes(PackageProvider);
      if PackageTypes = [] then begin
        self.AddGridRow(0,0, PackageProviderToStr(PackageProvider),'','','','','No package types selected for this Provider');
      end
      else begin
        GetServices(PackageProvider);
        if ServiceTypes = [] then begin
          self.AddGridRow(0,0, PackageProviderToStr(PackageProvider),'','','','','No Service types selected for this Provider');
        end
        else begin
          for ServiceType in ServiceTypes do begin

            for PackageType in PackageTypes do begin

              case PackageProvider of
                ppUSPS,
                ppUSPSEndicia,
                ppUSPSStamps:
                  begin
                    SetShipmentDetails(USPSRates);
                  end;
                ppFedEx,
                ppUPS,
                ppCanadaPost:
                  begin

                  end;
              end;


              case PackageProvider of
                ppUSPS:
                  begin
                    USPSRates.PostageProvider := TibxuspsratesPostageProviders.ppNone;
                    USPSRates.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
                    USPSRates.USPSServer := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
                    USPSRates.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
                  end;
                PPUSPSEndicia:
                  begin
                    USPSRates.PostageProvider := TibxuspsratesPostageProviders.ppEndicia;
                    USPSRates.USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.EndiciaAccountNumber;
                    USPSRates.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.EndiciaPassword;
    //                USPSRates.USPSServer := AppEnv.CompanyPrefs.USPSConfig.;
                  end;
                PPUSPSStamps:
                  begin
                    USPSRates.PostageProvider := TibxuspsratesPostageProviders.ppStamps;
                    USPSRates.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.StampsUserID;
                    USPSRates.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.StampsPassword;
    //                USPSRates.USPSServer := AppEnv.CompanyPrefs.USPSConfig.StampsServer;
                  end;
                ppFedEx:
                  begin
                    EzRates.Provider := TibxezratesProviders.pFedEx;
                    SetShipmentDetails(EzRates);

                    EzRates.DeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
                    //EzRates.AccessKey
                    EzRates.AccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
                    EzRates.MeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
                    EzRates.Password := AppEnv.CompanyPrefs.FedExConfig.Password;
                    EzRates.Server := AppEnv.CompanyPrefs.FedExConfig.Server;
                  end;
                ppUPS:
                  begin
//                    EzRates.Provider := TibxezratesProviders.pUPS;
//                    SetShipmentDetails(EzRates);
//
//                    //EzRates.DeveloperKey :=
//                    EzRates.AccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
//                    EzRates.AccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber ;
//                    //EzRates.MeterNumber := AppEnv.CompanyPrefs.UPSConfig. ;
//                    EzRates.Password := AppEnv.CompanyPrefs.UPSConfig.UPSPassword ;
//                    EzRates.Server := AppEnv.CompanyPrefs.UPSConfig.UPSServer ;
                    SetShipmentDetails(UpsRates);
                    if AppEnv.CompanyPrefs.UPSConfig.TestMode then
                      UPSRates.UPSServer := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/Rate'
                    else
                      UpsRates.UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/Rate'; //AppEnv.CompanyPrefs.UPSConfig.UPSServer;
                    UpsRates.UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
                    UpsRates.UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
                    UpsRates.UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
                    UpsRates.UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
                  end;
              end;

              case PackageProvider of
                ppUSPS,
                PPUSPSEndicia,
                PPUSPSStamps:
                  begin
                    USPSRates.RequestedService := TibxuspsratesServiceTypes(ServiceType);
                    USPSRates.PackageType[0] := TibxuspsratesTPackagingType(PackageType);
                    try
                      USPSRates.GetRates;
                      for I := 0 to USPSRates.ServiceCount -1 do begin
                        self.AddGridRow(
                          Ord(USPSRates.ServiceType[I]),
                          Ord(PackageType),
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          USPSRates.ServiceTypeDescription[I],    // Service Type
                          USPSRates.ServiceListNetCharge[I],      // Rate
                          '',      // Date
                          '');     // Note
                      end;
                    except
                      on e: exception do begin
                        self.AddGridRow(
                          0,
                          0,
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          '',    // Service Type
                          '',      // Rate
                          '',      // Date
                          e.Message);     // Note
                      end;
                    end;
                  end;
                ppFedEx:
                  begin
                    EzRates.RequestedService := ServiceType;
                    EzRates.PackageType[0] := TibxezratesTPackagingType(PackageType);
                    try
                      EzRates.GetRates;
                      for I := 0 to EzRates.ServiceCount -1 do begin

                        if (EzRates.ServiceAccountBaseCharge[i] <> '') and (EzRates.ServiceAccountTotalSurcharge[i] <> '') then begin
                          Rate := FloatToStr(StrToFloat(EzRates.ServiceAccountBaseCharge[i]) + StrToFloat(EzRates.ServiceAccountTotalSurcharge[i]));
                        end
                        else begin
                          RAte:= EzRates.ServiceListNetCharge[i];
                        end;

                        self.AddGridRow(
                          Ord(EzRates.ServiceType[I]),
                          Ord(PackageType),
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          EzRates.ServiceTypeDescription[I],    // Service Type
                          Rate, // Rate
                          EzRates.ServiceDeliveryDate[I],       // Date
                          '');     // Note
                      end;
                    except
                      on e: exception do begin
                        self.AddGridRow(
                          0,
                          0,
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          '',    // Service Type
                          '',      // Rate
                          '',      // Date
                          e.Message);     // Note
                      end;
                    end;
                  end;
                ppUPS:
                  begin
                    UPSRates.RequestedService := TibxupsratesRequestedServices(ServiceType);
                    UPSRates.PackageType[0] := TibxupsratesTPackagingType(PackageType);
                    try
                      UPSRates.GetRates;
                      for I := 0 to UPSRates.ServiceCount -1 do begin

//                        if (UPSRates.ServiceAccountBaseCharge[i] <> '') and (UPSRates.ServiceAccountTotalSurcharge[i] <> '') then begin
//                          Rate := FloatToStr(StrToFloat(UPSRates.ServiceAccountBaseCharge[i]) + StrToFloat(UPSRates.ServiceAccountTotalSurcharge[i]));
//                        end
//                        else begin
                          Rate:= UPSRates.ServiceListNetCharge[i];
//                        end;

                        self.AddGridRow(
                          Ord(UPSRates.ServiceType[I]),
                          Ord(PackageType),
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          UPSRates.ServiceTypeDescription[I],    // Service Type
                          Rate, // Rate
                          UPSRates.ServiceDeliveryDate[I],       // Date
                          '');     // Note
                      end;
                    except
                      on e: exception do begin
                        self.AddGridRow(
                          0,
                          0,
                          PackageProviderToStr(PackageProvider),  // Package Provider
                          PackageTypeToStr(PackageType),          // Package Type
                          '',    // Service Type
                          '',      // Rate
                          '',      // Date
                          e.Message);     // Note
                      end;
                    end;
                  end;




              end;
            end;
          end;
        end;
      end;
    end;

  finally
    Prog.Free;
    EzRates.Free;
    UPSRates.Free;
    USPSRates.Free;
  end;
end;

function TfmShipmentRates.GetSale: TSales;
begin
  result := nil;
  if Assigned(SaleForm) then
    result := SaleForm.SaleBase;
end;

procedure TfmShipmentRates.GetServices;
var
  PackageProvider: TPackageProvider;
  Rec: TShipServiceTypeRec;
begin
  lstService.Items.Clear;
  for PackageProvider in Providers do begin
    for Rec in ShipServiceTypeList do begin
      if PackageProvider in rec.Providers then begin
        if lstService.Items.IndexOf(rec.Name) < 0 then
           lstService.Items.Add(rec.Name);
      end;
    end;
    case PackageProvider of
      ppFedEx:
        begin
          if AppEnv.CompanyPrefs.FedExConfig.DefaultService <> '' then
            lstService.Checked[lstService.Items.IndexOf(AppEnv.CompanyPrefs.FedExConfig.DefaultService)] := true;
        end;
      ppUPS:
        begin
          if AppEnv.CompanyPrefs.UPSConfig.DefaultService <> '' then
            lstService.Checked[lstService.Items.IndexOf(AppEnv.CompanyPrefs.UPSConfig.DefaultService)] := true;
        end;
      ppUSPS:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.DefaultService <> '' then
            lstService.Checked[lstService.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.DefaultService)] := true;
        end;
      ppCanadaPost:;
      ppUSPSEndicia:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultService <> '' then
            lstService.Checked[lstService.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultService)] := true;
        end;
      ppUSPSStamps:
        begin
          if AppEnv.CompanyPrefs.USPSConfig.StampsDefaultService <> '' then
            lstService.Checked[lstService.Items.IndexOf(AppEnv.CompanyPrefs.USPSConfig.StampsDefaultService)] := true;
        end;
    end;
  end;
end;

//procedure TfmShipmentRates.grdAddressMainonDblClick(Sender: TObject);
//begin
//  with TwwDbGrid(Sender).Datasource.DataSet do begin
//    Sale.ShipToID := FieldByName('ShipAddressID').AsInteger;
//    Sale.PostDB;
//    Sale.Connection.CommitTransaction;
//    Sale.Connection.BeginTransaction;
//  end;
//end;

procedure TfmShipmentRates.grdRatesCellChanging(Sender: TObject; OldRow, OldCol,
  NewRow, NewCol: Integer; var Allow: Boolean);
begin
  inherited;
//  if (NewRow > 0) and (NewCol = Col_Note) and (grdRates.Cells[Col_Note, NewRow] <> '') then begin
//    grdRates.Hint := grdRates.Cells[Col_Note, NewRow];
//    grdRates.ShowHint := true;
//  end
//  else begin
//    grdRates.ShowHint := false;
//
//  end;
end;

procedure TfmShipmentRates.grdRatesDblClick(Sender: TObject);
begin
  inherited;
  if DoShipment then
//    ModalResult := mrOk;
    Close;
end;

procedure TfmShipmentRates.grdRatesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: integer;
begin
  inherited;
  grdRates.MouseToCell(X,Y,ACol,ARow);
  if (ARow > 0) and (ACol = Col_Note) and (grdRates.Cells[Col_Note, ARow] <> '') then begin
    grdRates.Hint := grdRates.Cells[Col_Note, ARow];
    grdRates.ShowHint := true;
  end
  else begin
    grdRates.ShowHint := false;

  end;
end;

procedure TfmShipmentRates.DoOnGridDataSelect(Sender: TwwDbGrid);
begin
  with TwwDbGrid(Sender).Datasource.DataSet do begin
    Sale.ShipToID := FieldByName('ShipAddressID').AsInteger;
    Sale.PostDB;
    Sale.Connection.CommitTransaction;
    Sale.Connection.BeginTransaction;
  end;
end;

procedure TfmShipmentRates.ResizeGrid;
begin
  grdRates.Cells[Col_Provider, 0] := 'Provider';
  grdRates.Cells[Col_Package, 0] := 'Package';
  grdRates.Cells[Col_Service, 0] := 'Service';
  grdRates.Cells[Col_Rate, 0] := 'Rate';
  grdRates.Cells[Col_Date, 0] := 'Due Date';
  grdRates.Cells[Col_Note, 0] := 'Note';

  grdRates.ColWidths[Col_Provider] := 80;
  grdRates.ColWidths[Col_Package] := 150;
  grdRates.ColWidths[Col_Service] := 150;
  grdRates.ColWidths[Col_Rate] := 100;
  grdRates.ColWidths[Col_Date] := 130;
  grdRates.ColWidths[Col_Note] :=
    grdRates.ClientWidth -
      (grdRates.ColWidths[Col_Provider] +
       grdRates.ColWidths[Col_Package] +
       grdRates.ColWidths[Col_Service] +
       grdRates.ColWidths[Col_Rate] +
       grdRates.ColWidths[Col_Date]);
end;

procedure TfmShipmentRates.SetShipmentDetails(RatesObj: TObject);
var
  EzRates: TibxEzRates;
  USPSRates: ibxuspsrates.TibxUSPSRates;
  UPSRates: TibxUPSRates;

  function FindCountryCode(aCountry: string): string;
  begin
    result := '';
    if Trim(aCountry) <> '' then begin
      if Length(Trim(aCountry)) = 2 then begin
        result := Trim(aCountry);
        exit;
      end;
      { get country code from country name }
      result := TCountries.ShortCodeForCountry(Trim(aCountry));
    end;
    if result = '' then begin
      if Length(AppEnv.RegionalOptions.RegionAbbreviation) = 2 then
        result := AppEnv.RegionalOptions.RegionAbbreviation
      else
        result := TCountries.ShortCodeForCode(AppEnv.RegionalOptions.RegionAbbreviation);
    end;
  end;

begin
  if RatesObj is TibxEzRates then begin
    EzRates := TibxEzRates(RatesObj);

    EzRates.SenderAddress1 := AppEnv.CompanyInfo.Address;
    EzRates.SenderAddress2 := AppEnv.CompanyInfo.Address2;
    if AppEnv.CompanyInfo.Address3 <> '' then begin
      if EzRates.SenderAddress2 <> '' then EzRates.SenderAddress2 := EzRates.SenderAddress2 + ' ';
      EzRates.SenderAddress2 := EzRates.SenderAddress2 + AppEnv.CompanyInfo.Address3;
    end;
    EzRates.SenderCity := AppEnv.CompanyInfo.City;
    EzRates.SenderState := AppEnv.CompanyInfo.State;
    EzRates.SenderZipCode := AppEnv.CompanyInfo.Postcode;
    EzRates.SenderCountryCode := FindCountryCode(AppEnv.CompanyInfo.Country);

    EzRates.RecipientAddress1 := Sale.ShipStreet1;
    if Sale.ShipStreet2 <> '' then begin
      EzRates.RecipientAddress2 := Sale.ShipStreet2;
      if Sale.ShipStreet3 <> '' then
        EzRates.RecipientAddress2 := EzRates.RecipientAddress2 + ' ' + Sale.ShipStreet3;
    end
    else
      EzRates.RecipientAddress2 := '';
    EzRates.RecipientCity := Sale.ShipSuburb;
    EzRates.RecipientState := Sale.ShipState;
    EzRates.RecipientZipCode := Sale.ShipPostcode;
    EzRates.RecipientCountryCode := FindCountryCode(Sale.ShipCountry);

    EzRates.PackageCount := 1;
    if EzRates.Provider = TibxezratesProviders.pUPS then
      EzRates.PackageWeight[0] := IntToStr(Trunc(StrToFloat(edtWeight.Text))) + ' lbs 0 oz'
    else
      EzRates.PackageWeight[0] := edtWeight.Text;
    EzRates.PackageLength[0] := edtLength.IntValue;
    EzRates.PackageWidth[0] := edtWidth.IntValue;
    EzRates.PackageHeight[0] := edtHeight.IntValue;
    { use TLS 1.2 }
    EzRates.Config('SSLEnabledProtocols=3072');

  end
  else if RatesObj is ibxuspsrates.TibxUSPSRates then begin
    USPSRates := ibxuspsrates.TibxUSPSRates(RatesObj);

    USPSRates.SenderZipCode := AppEnv.CompanyInfo.Postcode;
    USPSRates.RecipientZipCode := Sale.ShipPostcode;
    USPSRates.RecipientCountryCode := FindCountryCode(Sale.ShipCountry);

    USPSRates.PackageCount := 1;
    USPSRates.PackageWeight[0] := edtWeight.Text;
    USPSRates.PackageLength[0] := edtLength.IntValue;
    USPSRates.PackageWidth[0] := edtWidth.IntValue;
    USPSRates.PackageHeight[0] := edtHeight.IntValue;
    { use TLS 1.2 }
    USPSRates.Config('SSLEnabledProtocols=3072');
    USPSRates.Config('ShipDate=' + FormatDateTime('yyyy-mm-dd',Now))
  end
  else if RatesObj is TibxUPSRates then begin
    UPSRates := TibxUPSRates(RatesObj);

    UPSRates.PickupType := ptDailyPickup;
    UPSRates.CustomerType := ccRetail;

    UPSRates.PackageCount := 1;

    UPSRates.SenderCity := AppEnv.CompanyInfo.City;
    UPSRates.SenderState := AppEnv.CompanyInfo.State;
    UPSRates.SenderZipCode := AppEnv.CompanyInfo.Postcode;
    UPSRates.SenderCountryCode := FindCountryCode(AppEnv.CompanyInfo.Country);

    UPSRates.RecipientAddress1 := Sale.ShipStreet1;
    if Sale.ShipStreet2 <> '' then begin
      UPSRates.RecipientAddress2 := Sale.ShipStreet2;
      if Sale.ShipStreet3 <> '' then
        UPSRates.RecipientAddress2 := UPSRates.RecipientAddress2 + ' ' + Sale.ShipStreet3;
    end
    else
      UPSRates.RecipientAddress2 := '';
    UPSRates.RecipientCity := Sale.ShipSuburb;
    UPSRates.RecipientState := Sale.ShipState;
    UPSRates.RecipientZipCode := Sale.ShipPostcode;
    UPSRates.RecipientCountryCode := FindCountryCode(Sale.ShipCountry);

    UPSRates.PackageWeight[0] := edtWeight.Text;
    UPSRates.PackageLength[0] := edtLength.IntValue;
    UPSRates.PackageWidth[0] := edtWidth.IntValue;
    UPSRates.PackageHeight[0] := edtHeight.IntValue;


    if AppEnv.RegionalOptions.RegionType = rUSA then
      UPSRates.Config('WeightUnit=LBS')   { NOTE: us domestic shipments only }
    else
      UPSRates.Config('WeightUnit=KGS');
    UPSRates.Config('CurrencyCode=' + Sale.ForeignExchangeCode);
    UPSRates.Config('SSLEnabledProtocols=3072');
  end;



end;

end.
