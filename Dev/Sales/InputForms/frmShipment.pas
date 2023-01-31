unit frmShipment;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  BusObjShipment, BusObjBase, DBCtrls, Grids, Wwdbigrd, Wwdbgrid, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, Buttons, wwdblook, ComCtrls, wwcheckbox,
  AdvEdit, DBAdvEd, wwdbdatetimepicker;

type
  TfmShipment = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryShipment: TERPQuery;
    dsShipments: TDataSource;
    qryShipmentShipmentId: TIntegerField;
    qryShipmentGlobalRef: TWideStringField;
    qryShipmentShipAddressId: TIntegerField;
    qryShipmentShipmentListId: TIntegerField;
    qryShipmentMasterTrackingNumber: TWideStringField;
    qryShipmentPayorAccountNumber: TWideStringField;
    qryShipmentPayorCountryCode: TWideStringField;
    qryShipmentPayorType: TIntegerField;
    qryShipmentPayorZipCode: TWideStringField;
    qryShipmentProvider: TIntegerField;
    qryShipmentServiceType: TIntegerField;
    qryShipmentShipmentSpecialServices: TLargeintField;
    qryShipmentActive: TWideStringField;
    qryShipmentmsTimeStamp: TDateTimeField;
    qryShipmentmsUpdateSiteCode: TWideStringField;
    grdSaleLine: TwwDBGrid;
    qrySaleLine: TERPQuery;
    qrySaleLineProductName: TWideStringField;
    qrySaleLineDescription: TWideStringField;
    qrySaleLineUOM: TWideStringField;
    qrySaleLineUOMSoldQty: TFloatField;
    qrySaleLineShippedUOMQty: TFloatField;
    qrySaleLineAllocatedUOMQty: TFloatField;
    qrySaleLineUnallocatedUOMQty: TFloatField;
    qrySaleLineSaleLineId: TIntegerField;
    dsSaleLine: TDataSource;
    Label4: TLabel;
    Label5: TLabel;
    grdPackages: TwwDBGrid;
    qryPackages: TERPQuery;
    qryPackagesShipmentPackageId: TIntegerField;
    qryPackagesGlobalRef: TWideStringField;
    qryPackagesShipmentId: TIntegerField;
    qryPackagesPackageBaseCharge: TFloatField;
    qryPackagesPackageCODLabel: TWideMemoField;
    qryPackagesPackageCODType: TIntegerField;
    qryPackagesPackageDangerousGoodsAccessible: TWideStringField;
    qryPackagesPackageDescription: TWideStringField;
    qryPackagesPackageHeight: TIntegerField;
    qryPackagesPackageInsuredValue: TFloatField;
    qryPackagesPackageLength: TIntegerField;
    qryPackagesPackageNetCharge: TFloatField;
    qryPackagesPackageType: TIntegerField;
    qryPackagesPackageReference: TWideStringField;
    qryPackagesPackageReturnRecpt: TWideMemoField;
    qryPackagesPackageSignatureType: TIntegerField;
    qryPackagesPackageSpecialService: TIntegerField;
    qryPackagesPackageTotalDiscount: TFloatField;
    qryPackagesPackageTotalSurcharges: TFloatField;
    qryPackagesPackageTrackingNumber: TWideStringField;
    qryPackagesPackageWidth: TIntegerField;
    qryPackagesmsTimeStamp: TDateTimeField;
    qryPackagesmsUpdateSiteCode: TWideStringField;
    dsPackages: TDataSource;
    cboPackageType: TwwDBComboBox;
    wwDBGrid1IButton: TwwIButton;
    qryShipmentSenderFirstName: TWideStringField;
    qryShipmentSenderMiddleInitial: TWideStringField;
    qryShipmentSenderLastName: TWideStringField;
    qryShipmentSenderCompany: TWideStringField;
    qryShipmentSenderAddress1: TWideStringField;
    qryShipmentSenderAddress2: TWideStringField;
    qryShipmentSenderCity: TWideStringField;
    qryShipmentSenderState: TWideStringField;
    qryShipmentSenderZipCode: TWideStringField;
    qryShipmentSenderCountryCode: TWideStringField;
    qryShipmentSenderEmail: TWideStringField;
    qryShipmentSenderPhone: TWideStringField;
    qryShipmentSenderFax: TWideStringField;
    qrySenderCountryCodeLookup: TERPQuery;
    pcDetails: TPageControl;
    tabShipFrom: TTabSheet;
    grpShipFrom: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lblSenderCountryCode: TLabel;
    edtSenderFirstName: TDBEdit;
    edtSenderInitial: TDBEdit;
    edtSenderLastName: TDBEdit;
    edtSenderCompany: TDBEdit;
    edtSenderEmail: TDBEdit;
    edtSenderPhone: TDBEdit;
    edtSenderFax: TDBEdit;
    edtSenderAddress1: TDBEdit;
    edtSenderAddress2: TDBEdit;
    edtSenderCity: TDBEdit;
    edtSenderState: TDBEdit;
    edtSenderZipCode: TDBEdit;
    edtSenderCountryCode: TwwDBLookupCombo;
    tabDetails: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cboService: TComboBox;
    tabShipTo: TTabSheet;
    grpShipTo: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    lblReceipientCountry: TLabel;
    edtReceipientFirstName: TDBEdit;
    edtReceipientInitial: TDBEdit;
    edtReceipientLastName: TDBEdit;
    edtReceipientCompany: TDBEdit;
    edtReceipientEmail: TDBEdit;
    edtReceipientPhone: TDBEdit;
    edtReceipientFax: TDBEdit;
    edtReceipientAddress1: TDBEdit;
    edtReceipientAddress2: TDBEdit;
    edtReceipientCity: TDBEdit;
    edtReceipientState: TDBEdit;
    edtReceipientZipCode: TDBEdit;
    edtReceipientCountry: TwwDBLookupCombo;
    qryShipmentRecipientFirstName: TWideStringField;
    qryShipmentRecipientMiddleInitial: TWideStringField;
    qryShipmentRecipientLastName: TWideStringField;
    qryShipmentRecipientCompany: TWideStringField;
    qryShipmentRecipientAddress1: TWideStringField;
    qryShipmentRecipientAddress2: TWideStringField;
    qryShipmentRecipientCity: TWideStringField;
    qryShipmentRecipientState: TWideStringField;
    qryShipmentRecipientZipCode: TWideStringField;
    qryShipmentRecipientCountryCode: TWideStringField;
    qryShipmentRecipientEmail: TWideStringField;
    qryShipmentRecipientPhone: TWideStringField;
    qryShipmentRecipientFax: TWideStringField;
    qryRecipientCountryCodeLookup: TERPQuery;
    cboProvider: TComboBox;
    qryShipmentRecipientAddressValid: TWideStringField;
    chkRecipientAddressValid: TwwCheckBox;
    cboLabelImageType: TComboBox;
    Label31: TLabel;
    qryShipmentLabelImageType: TIntegerField;
    qryShipmentProcessed: TWideStringField;
    btnProcess: TDNMSpeedButton;
    chkProcessed: TwwCheckBox;
    cboPayorType: TComboBox;
    lblPayorType: TLabel;
    lblPayorAccountNumber: TLabel;
    edtPayorAccountNumber: TDBEdit;
    cboPackageCODType: TwwDBComboBox;
    cboPackageSignatureType: TwwDBComboBox;
    qryPackagesPackageWeight: TWideStringField;
    lblMasterTrackingNumber: TLabel;
    edtMasterTrackingNumber: TDBEdit;
    Label34: TLabel;
    edtTotalNetCharge: TDBEdit;
    lblTotalBaseCharge: TLabel;
    edtTotalBaseCharge: TDBEdit;
    lblTotalSurcharges: TLabel;
    edtTotalSurcharges: TDBEdit;
    Label37: TLabel;
    qryPackagesPackageOptNonStandardContainer: TBooleanField;
    qryPackagesPackageOptAdditionalHandling: TBooleanField;
    qryPackagesPackageOptAppointmentDelivery: TBooleanField;
    qryPackagesPackageOptDangeriousGoods: TBooleanField;
    qryPackagesPackageOptDryIce: TBooleanField;
    qryPackagesPackageOptPriorityAlert: TBooleanField;
    qryPackagesPackageOptCOD: TBooleanField;
    qryPackagesPackageOptSignatureOption: TBooleanField;
    qryPackagesPackageOptAlcohol: TBooleanField;
    qryPackagesPackageShippingLabel: TBlobField;
    popPackages: TPopupMenu;
    mnuViewShippingLabel: TMenuItem;
    qryPackagesPackageCODAmount: TFloatField;
    qryShipmentTotalNetCharge: TFloatField;
    qryShipmentTotalBaseCharge: TFloatField;
    qryShipmentTotalSurcharges: TFloatField;
    qryShipmentShipDate: TDateTimeField;
    btnValidateRecipientAddress: TDNMSpeedButton;
    qryShipmentTotalNetChargeNegotiated: TFloatField;
    lblTotalNetChargeNegotiated: TLabel;
    edtTotalNetChargeNegotiated: TDBEdit;
    qryShipmentMICostCenter: TWideStringField;
    qryShipmentMIPackageID: TWideStringField;
    qryShipmentEndorsement: TIntegerField;
    gbMailInnovations: TGroupBox;
    lblCostCenter: TLabel;
    edtMICostCenter: TDBEdit;
    lblMIPackageID: TLabel;
    edtMIPackageID: TDBEdit;
    cboEndorsement: TwwDBComboBox;
    lblEndorsement: TLabel;
    qryShipmentPackageIDCode: TWideStringField;
    lblPayorZipCode: TLabel;
    edtPayorZipCode: TDBEdit;
    lblMailInovations: TLabel;
    qryShipmentDeliveryData: TDateTimeField;
    lblDeliveryDate: TLabel;
    lblDropoffType: TLabel;
    cboDropoffType: TComboBox;
    tabFedExSpecialServices: TTabSheet;
    chkCOD: TCheckBox;
    chkTopLoad: TCheckBox;
    chkInternationalTrafficinArmsRegulations: TCheckBox;
    chkHomeDeliveryPremium: TCheckBox;
    chkInsideDelivery: TCheckBox;
    chkInsidePickup: TCheckBox;
    chkReturnShipment: TCheckBox;
    chkSaturdayDelivery: TCheckBox;
    chkSaturdayPickup: TCheckBox;
    chkBrokerSelect: TCheckBox;
    chkCallBeforeDelivery: TCheckBox;
    chkCustomDeliveryWindow: TCheckBox;
    chkDangeriousGoods: TCheckBox;
    chkDoNotBreakDownPallets: TCheckBox;
    chkDoNotStackPallets: TCheckBox;
    chkEastCoastSpecial: TCheckBox;
    chkElectronicTradeDocuments: TCheckBox;
    chkEmailNotification: TCheckBox;
    chkExtreamLength: TCheckBox;
    chkFood: TCheckBox;
    chkFreightGuarantee: TCheckBox;
    chkFutureDay: TCheckBox;
    chkHoldAtLocation: TCheckBox;
    chkInternationalControlledExportService: TCheckBox;
    chkLiftgateDelivery: TCheckBox;
    chkLiftgatePickup: TCheckBox;
    chkLimitedAccessDelivery: TCheckBox;
    chkLimitedAccessPickup: TCheckBox;
    chkPendingShipment: TCheckBox;
    chkPoison: TCheckBox;
    chkProtectionFromFreezing: TCheckBox;
    chkDryIce: TCheckBox;
    qryShipmentPostageProvider: TIntegerField;
    qryShipmentDropoffType: TIntegerField;
    qryPackagesPackageWeightFrac: TWideStringField;
    edtShipDate: TwwDBDateTimePicker;
    edtDeliveryDate: TwwDBDateTimePicker;
    lblCanProcess: TLabel;
    qrySaleLineWeight: TFloatField;
    qrySaleLineHeight: TFloatField;
    qrySaleLineLength: TFloatField;
    qrySaleLineWidth: TFloatField;
    chkDocumentsOnly: TwwCheckBox;
    qryShipmentProcessedComment: TWideMemoField;
    qryShipmentDocumentsOnly: TWideStringField;
    qryPackagesCommodityDescription: TWideStringField;
    qryPackagesCommodityHarmonizedCode: TWideStringField;
    qryPackagesCommodityManufacturer: TWideStringField;
    qryPackagesCommodityNumberOfPieces: TIntegerField;
    qryPackagesCommodityQuantityUnit: TWideStringField;
    qryPackagesCommodityUnitPrice: TFloatField;
    qryPackagesCommodityValue: TFloatField;
    qryPackagesCommodityWeight: TWideStringField;
    qryPackagesCommodityQuantity: TIntegerField;
    qryShipmentBookingNumber: TWideStringField;
    lblBookingNumber: TLabel;
    edtBookingNumber: TwwDBEdit;
    cboPostageProvider: TComboBox;
    lblPostageProvider: TLabel;
    btnTayorTypeHelp: TDNMSpeedButton;
    wwCheckBox1: TwwCheckBox;
    qryShipmentCanceled: TWideStringField;
    btnCancelShipment: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboProviderChange(Sender: TObject);
    procedure grdSaleLineCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qrySaleLineAllocatedUOMQtySetText(Sender: TField;
      const Text: string);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure cboServiceChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ReceipientAddressChange(Sender: TObject);
    procedure cboLabelImageTypeChange(Sender: TObject);
    procedure cboPayorTypeChange(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure grdPackagesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryPackagesCalcFields(DataSet: TDataSet);
    procedure qryPackagesPackageOptSetText(Sender: TField;
      const Text: string);
    procedure mnuViewShippingLabelClick(Sender: TObject);
    procedure btnValidateRecipientAddressClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure cboDropoffTypeChange(Sender: TObject);
    procedure chkFedExSpecialServicesClick(Sender: TObject);
    procedure edtShipDateChange(Sender: TObject);
    procedure qryPackagesBeforePost(DataSet: TDataSet);
    procedure cboPostageProviderChange(Sender: TObject);
    procedure edtPayorAccountNumberChange(Sender: TObject);
    procedure btnTayorTypeHelpClick(Sender: TObject);
    procedure btnCancelShipmentClick(Sender: TObject);
  private
    Shipment: TShipment;
    RecipientAddressDirty: boolean;
    RecipientPhoneDirty: boolean;
    InitialAccessLevel: integer;
    procedure LoadPrefsForProvider;
    Procedure LoadPrefsForSaleCustomer;
    procedure SetGuiAccess;
    procedure SetServicePreferences;
    procedure LoadSpecialServices;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses
  BusObjConst, DnMExceptions, ShipIntegrationTypes, ibxezship, ibxupsship, ibxezaddress,
  DNMLib, GridFieldsObj, AppEnvironment, tcTypes, CommonLib, SystemLib,
  ShellAPI, ShipAddressValidationObj, DbSharedObjectsObj, ShipIntegrationUtils,
  BusObjShippingAddress, BusObjClient, tcConst, CommonDbLib , ibxuspsship;

{$R *.dfm}

procedure TfmShipment.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  inherited;
  if Shipment.PackageIDCode <> '' then begin
    if edtMasterTrackingNumber.DataField <> 'PackageIDCode' then
      edtMasterTrackingNumber.DataField := 'PackageIDCode';
  end
  else begin
    if edtMasterTrackingNumber.DataField <> 'MasterTrackingNumber' then
      edtMasterTrackingNumber.DataField := 'MasterTrackingNumber';
  end;
end;

procedure TfmShipment.btnCancelClick(Sender: TObject);
begin
  inherited;
  self.RollbackTransaction;
  if (fsModal in self.FormState) then ModalResult := mrCancel
  else Close;
end;

procedure TfmShipment.btnCancelShipmentClick(Sender: TObject);
var
  SaveAccessLevel : integer;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to cancel this Shipment?', mtConfirmation, [mbNo, mbYes],0) <> mrYes  then
    exit;
  SaveAccessLevel := AccessLevel;
  try
    AccessLevel := 1;
    if Shipment.CancelShipment then begin
      self.CommitTransaction;
      self.BeginTransaction;
      CommonLib.MessageDlgXP_Vista('Shipment has been canceled.', mtInformation, [mbOk],0);
    end;
  finally
    AccessLevel := SaveAccessLevel;
  end;
end;

procedure TfmShipment.btnProcessClick(Sender: TObject);
var
  dlg: TProgressDialog;
begin
  inherited;
  dlg:= TProgressDialog.Create(nil);
  DisableForm;
  try
    dlg.Caption := 'Processing Request';
    dlg.MaxValue := 10;
    dlg.Step := 1;
    dlg.TimerUpdate := true;
    dlg.Execute;
    if Shipment.Ship then begin
      self.CommitTransaction;
      self.BeginTransaction;
      SetGuiAccess;
    end;
  finally
    dlg.Free;
    EnableForm;
  end;
end;

procedure TfmShipment.btnSaveClick(Sender: TObject);
var
  ShipAdd: TShippingAddress;
  Cust: TCustomer;
begin
  inherited;
  if not Shipment.Processed then begin
    if not Shipment.Save then
      exit;
    if RecipientPhoneDirty then begin
      { save the address changes }
      ShipAdd := TShippingAddress.Create(nil);
      try
        ShipAdd.Connection := TMyDacDataConnection.Create(ShipAdd);
        ShipAdd.Connection.Connection := self.MyConnection;
        ShipAdd.Load(self.Shipment.ShipAddressId);
        if ShipAdd.Lock then begin
          try
            ShipAdd.Connection.BeginNestedTransaction;
            try
              ShipAdd.Phone := Shipment.RecipientPhone;
              if ShipAdd.Save then begin
                if ShipAdd.CustomerPhysicalAddress then begin
                  Cust := TCustomer.Create(nil);
                  try
                    Cust.Connection := ShipAdd.Connection;
                    Cust.Load(ShipAdd.CustomerID);
                    if Cust.Lock then begin
                      try
                        Cust.Phone := ShipAdd.Phone;
                        Cust.PostDb;
                      finally
                        Cust.UnLock;
                      end;
                    end
                    else begin
                      CommonLib.MessageDlgXP_Vista('Could not lock Customer to update Address Info.' + #13#10 +
                        ShipAdd.UserLock.LockMessage, mtInformation, [mbOk],0);
                    end;
                  finally
                    Cust.Free;
                  end;
                end;
                ShipAdd.Connection.CommitNestedTransaction;
              end
              else
                ShipAdd.Connection.RollbackNestedTransaction;
            except
              on e: exception do begin
                ShipAdd.Connection.RollbackNestedTransaction;
                CommonLib.MessageDlgXP_Vista('Error updating the Shipping Address: ' + e.Message, mtInformation, [mbOk],0);
              end;
            end;

          finally
            ShipAdd.UnLock;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Could not lock Shipping Address to update it.' + #13#10 + ShipAdd.UserLock.LockMessage, mtInformation, [mbOk],0);
        end;



      finally
        ShipAdd.Free;
      end;
    end;
    self.CommitTransaction;
  end;
  if (fsModal in self.FormState) then ModalResult := mrOk
  else Close;
end;

procedure TfmShipment.btnTayorTypeHelpClick(Sender: TObject);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('If you are paying freight select "Sender", if Customer is paying freight select "Recipient".', mtInformation, [mbOk],0);
end;

procedure TfmShipment.btnValidateRecipientAddressClick(Sender: TObject);
var
  val: TShipAddressValidation;
begin
  inherited;
  DisableForm;
  val := TShipAddressValidation.Create;
  try
    val.Providers := [TibxezaddressProviders(Shipment.Provider)];
    val.PostageProviders := TibxuspsshipPostageProviders(Shipment.PostageProvider);
    val.Address.AddressLine1 := Shipment.RecipientAddress1;
    val.Address.AddressLine2 := Shipment.RecipientAddress2;
    val.Address.City := Shipment.RecipientCity;
    val.Address.State := Shipment.RecipientState;
    val.Address.PostCode := Shipment.RecipientZipCode;
    val.Address.CountryCode := Shipment.RecipientCountryCode;
    val.Address.Updated := false;
//    if Length(Shipment.RecipientPhone) < 10 then
//      val.ErrMessage := 'Phone Number must be at least 10 alphanumeric characters long.';

    if (val.ErrMessage = '') and val.ValidateAddress then begin
      if val.Address.Updated then begin
        if not SameText(val.Address.AddressLine1,Shipment.RecipientAddress1) then
          Shipment.RecipientAddress1 := val.Address.AddressLine1;
        if not SameText(val.Address.AddressLine2, Shipment.RecipientAddress2) then
          Shipment.RecipientAddress2 := val.Address.AddressLine2;
        if not SameText(val.Address.City, Shipment.RecipientCity) then
          Shipment.RecipientCity := val.Address.City;
        if not SameText(val.Address.State, Shipment.RecipientState) then
          Shipment.RecipientState := val.Address.State;
        if not SameText(val.Address.PostCode, Shipment.RecipientZipCode) then
          Shipment.RecipientZipCode := val.Address.PostCode;
        if not SameText(val.Address.CountryCode, Shipment.RecipientCountryCode) then
          Shipment.RecipientCountryCode := val.Address.CountryCode;
        if CommonLib.MessageDlgXP_Vista('Do you wish to update the Customers Shipping Address with these changes?',mtConfirmation,[mbYes, mbNo],0) = mrYes then begin
          Shipment.ShippingAddress.UpdateFromAddress(val.Address);
          Shipment.ShippingAddress.Validated := true;
          Shipment.ShippingAddress.PostDb;
        end;
      end;
      Shipment.RecipientAddressValid := true;
      CommonLib.MessageDlgXP_Vista('Address is valid.', mtInformation, [mbOk], 0);
    end
    else if val.ErrMessage <> '' then begin
//      CommonLib.MessageDlgXP_Vista(val.ErrMessage,mtWarning,[mbOk],0);
      if CommonLib.MessageDlgXP_Vista('Error '+ val.ErrMessage +NL+'While Validating Address :'+ Shipment.ShippingAddress.AddressAsString(',')+
                                   #13#10 +  #13#10 + 'Do you want to flag address as valid anyway?',mtWarning,[mbNo,mbYes],0) = mrYes then begin
//        Shipment.ShippingAddress.Validated := true;
//        Shipment.ShippingAddress.PostDb;
        Shipment.RecipientAddressValid := true;
        Shipment.PostDb;
      end;
    end;
  finally
    val.Free;
    EnableForm;
  end;
end;

procedure TfmShipment.cboLabelImageTypeChange(Sender: TObject);
begin
  inherited;
  if not TComboBox(Sender).Focused then exit;
  if Shipment.Processed then begin
    CommonLib.MessageDlgXP_Vista('The Label Image Type can not be changed after a shipment has been processed.',mtInformation,[mbOk],0);
    exit;
  end;
  case Shipment.ShipperType of
    spNone: ;
    spFedEx: Shipment.LabelImageType := FedExStrToImageType(TComboBox(Sender).Text);
    spUPS: Shipment.LabelImageType := Ord(StrToUPSImageType(TComboBox(Sender).Text));
    spUSPS: Shipment.LabelImageType := USPSStrToImageType(TComboBox(Sender).Text);
    spCanadaPost: ;
    spTNT: ;
  end;
end;

procedure TfmShipment.cboPayorTypeChange(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  if not TComboBox(Sender).Focused then exit;
  Shipment.PayorType := StrToPayorType(TComboBox(Sender).Text);
//  GuiPrefs.Node['Provider_' + IntToStr(Ord(Shipment.Provider)) + '.PayerType'].AsString := TComboBox(Sender).Text;
  if Shipment.PayorType in [ibxezship.ptSender] then begin
    Shipment.PayorAccountNumber := '';
    edtPayorAccountNumber.ReadOnly := true;
    edtPayorZipCode.ReadOnly := true;
  end
  else begin
    edtPayorAccountNumber.ReadOnly := false;
    edtPayorZipCode.ReadOnly := false;
//    if (Shipment.PayorZipCode = '') and (Shipment.RecipientZipCode <> '') then
//      Shipment.PayorZipCode := Shipment.RecipientZipCode;
  end;
  if Shipment.PayorType = ibxezship.ptRecipient then begin
    qry := TERPQuery.Create(nil); //  Shipment.TempQry(
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Text :=
        'select c.ClientPaysShippment, c.ClientShipperAccountNo from tblClients c ' +
        'inner join tblsales s on s.ClientID = c.ClientID ' +
        'inner join tblShipmentList sl on sl.SaleID = s.SaleID ' +
        'where sl.ShipmentListId = ' + IntToStr(Shipment.ShipmentListId);
      qry.Open;
      if qry.FieldByName('ClientShipperAccountNo').AsString <> '' then begin
        Shipment.PayorAccountNumber := qry.FieldByName('ClientShipperAccountNo').AsString;
      end;
    finally
      qry.Free;
    end;
  end;
end;

procedure TfmShipment.cboPostageProviderChange(Sender: TObject);
begin
  inherited;
  if not TComboBox(Sender).Focused then exit;
  if TComboBox(Sender).ItemIndex > -1 then
    Shipment.PostageProvider := TComboBox(Sender).ItemIndex
  else
    Shipment.PostageProvider := 0;
  LoadPrefsForProvider;
end;

procedure TfmShipment.cboDropoffTypeChange(Sender: TObject);
begin
  inherited;
  Shipment.DropoffType := cboDropoffType.ItemIndex;
end;

procedure TfmShipment.cboProviderChange(Sender: TObject);
begin
  inherited;
  if TComboBox(Sender).Focused then
    Shipment.Provider := StrToProviderType(TComboBox(Sender).Text);
  LoadPrefsForProvider;
  if TComboBox(Sender).Focused then
    SetServicePreferences;
end;

procedure TfmShipment.cboServiceChange(Sender: TObject);
begin
  inherited;
  if not TComboBox(Sender).Focused then exit;
  Shipment.ServiceType := StrToShipServiceType(TComboBox(Sender).Text);
  SetServicePreferences;
end;

procedure TfmShipment.chkFedExSpecialServicesClick(Sender: TObject);
var
  services: Integer;
begin
  if self.IsFlag('LoadingSpecialServices') then exit;

  services := 0;

  if chkBrokerSelect.Checked then Include(TIntegerSet(services), ssBrokerSelect);
  if chkCallBeforeDelivery.Checked then Include(TIntegerSet(services), ssCallBeforeDelivery);
  if chkCOD.Checked then Include(TIntegerSet(services), ssCOD);
  if chkCustomDeliveryWindow.Checked then Include(TIntegerSet(services), ssCustomDeliveryWindow);
  if chkDangeriousGoods.Checked then Include(TIntegerSet(services), ssDangeriousGoods);
  if chkDoNotBreakDownPallets.Checked then Include(TIntegerSet(services), ssDoNotBreakDownPallets);
  if chkDoNotStackPallets.Checked then Include(TIntegerSet(services), ssDoNotStackPallets);
  if chkDryIce.Checked then Include(TIntegerSet(services), ssDryIce);
  if chkEastCoastSpecial.Checked then Include(TIntegerSet(services), ssEastCoastSpecial);
  if chkElectronicTradeDocuments.Checked then Include(TIntegerSet(services), ssElectronicTradeDocuments);
  if chkEmailNotification.Checked then Include(TIntegerSet(services), ssEmailNotification);
  if chkExtreamLength.Checked then Include(TIntegerSet(services), ssExtreamLength);
  if chkFood.Checked then Include(TIntegerSet(services), ssFood);
  if chkFreightGuarantee.Checked then Include(TIntegerSet(services), ssFreightGuarantee);
  if chkFutureDay.Checked then Include(TIntegerSet(services), ssFutureDay);
  if chkHoldAtLocation.Checked then Include(TIntegerSet(services), ssHoldAtLocation);
  if chkInternationalControlledExportService.Checked then Include(TIntegerSet(services), ssInternationalControlledExportService);
  if chkHomeDeliveryPremium.Checked then Include(TIntegerSet(services), ssHomeDeliveryPremium);
  if chkInsideDelivery.Checked then Include(TIntegerSet(services), ssInsideDelivery);
  if chkInsidePickup.Checked then Include(TIntegerSet(services), ssInsidePickup);
  if chkLiftgateDelivery.Checked then Include(TIntegerSet(services), ssLiftgateDelivery);
  if chkLiftgatePickup.Checked then Include(TIntegerSet(services), ssLiftgatePickup);
  if chkLimitedAccessDelivery.Checked then Include(TIntegerSet(services), ssLimitedAccessDelivery);
  if chkLimitedAccessPickup.Checked then Include(TIntegerSet(services), ssLimitedAccessPickup);
  if chkPendingShipment.Checked then Include(TIntegerSet(services), ssPendingShipment);
  if chkPoison.Checked then Include(TIntegerSet(services), ssPoison);
  if chkProtectionFromFreezing.Checked then Include(TIntegerSet(services), ssProtectionFromFreezing);
  if chkReturnShipment.Checked then Include(TIntegerSet(services), ssReturnShipment);
  if chkSaturdayDelivery.Checked then Include(TIntegerSet(services), ssSaturdayDelivery);
  if chkSaturdayPickup.Checked then Include(TIntegerSet(services), ssSaturdayPickup);
  if chkTopLoad.Checked then Include(TIntegerSet(services), ssTopLoad);
  if chkInternationalTrafficinArmsRegulations.Checked then Include(TIntegerSet(services), ssInternationalTrafficinArmsRegulations);

  Shipment.ShipmentSpecialServices := services;
end;

procedure TfmShipment.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TShipment then TShipment(Sender).DataSet:= qryShipment
    else if Sender is TShipmentPackage then TShipmentPackage(Sender).DataSet:= qryPackages;
  end;
end;

procedure TfmShipment.edtPayorAccountNumberChange(Sender: TObject);
begin
  inherited;
  if not edtPayorAccountNumber.Focused then exit;
  GuiPrefs.Node['Provider_' + IntToStr(Ord(Shipment.Provider)) + '.PayerAccountNumber'].AsString := edtPayorAccountNumber.Text;
end;

procedure TfmShipment.edtShipDateChange(Sender: TObject);
begin
  inherited;
//  if Trunc(Shipment.ShipDate) = edtShipDate.Epoch then
//    Shipment.ShipDate := 0;
end;

procedure TfmShipment.ReceipientAddressChange(Sender: TObject);
begin
  inherited;
  if (Sender is TDbEdit) and (not TDbEdit(Sender).Focused) then exit;
  if (Sender is TwwDbLookupCombo) and (not TwwDbLookupCombo(Sender).Focused) then exit;
  if Sender = edtReceipientPhone then
    RecipientPhoneDirty := true;


  RecipientAddressDirty := true;
  Shipment.RecipientAddressValid := false;
end;

procedure TfmShipment.SetGuiAccess;
begin
  btnProcess.Enabled := true;
  lblCanProcess.Caption := '';
  if Shipment.Processed then begin
    btnProcess.Enabled := false;
    if Shipment.Canceled then
      lblCanProcess.Caption := '(Shipment Canceled)'
    else
      lblCanProcess.Caption := '(Shipment Processed)';
  end
  else if AccessLevel > 2 then begin
    btnProcess.Enabled := false;
    lblCanProcess.Caption := '(No User Access)';
  end
  else if ((not AppEnv.CompanyPrefs.AllowShipmentsFromSalesOrder) and SameText(Shipment.SaleType,'Sales Order')) then begin
    btnProcess.Enabled := false;
    lblCanProcess.Caption := '("Allow Shipments From Sales Order" disabled)';
  end;

  if Shipment.Processed then AccessLevel := 5;
  btnValidateRecipientAddress.Enabled := not Shipment.Processed;
  self.tabFedExSpecialServices.Enabled := (not Shipment.Processed) and (AccessLevel < 3);
  cboPostageProvider.Enabled := (not Shipment.Processed) and (AccessLevel < 3);
  btnCancelShipment.Enabled := (not Shipment.Canceled) and Shipment.Processed and (InitialAccessLevel < 3);
end;

procedure TfmShipment.SetServicePreferences;
var
  qry: TERPQuery;
  BM: TBookMark;
begin
  gbMailInnovations.Enabled := (TibxezshipProviders(Shipment.Provider) = TibxezshipProviders.pUPS) and IsUPSMailInnovations(Shipment.ServiceType);
  lblCostCenter.Enabled := gbMailInnovations.Enabled;
  lblMIPackageID.Enabled := gbMailInnovations.Enabled;
  lblEndorsement.Enabled := gbMailInnovations.Enabled;
  lblMailInovations.Enabled := gbMailInnovations.Enabled;

  edtMICostCenter.Enabled := gbMailInnovations.Enabled;
  edtMIPackageID.Enabled := gbMailInnovations.Enabled;
  cboEndorsement.Enabled := gbMailInnovations.Enabled;
  lblPayorZipCode.Caption := 'Payor Zip Code';

  case TibxezshipProviders(Shipment.Provider) of
    TibxezshipProviders.pFedEx:
      begin
        Shipment.MICostCenter := '';
        Shipment.MIPackageID := '';
        Shipment.Endorsement := 0;
        lblPayorZipCode.Caption := 'Payor Zip Code';
        lblPayorZipCode.Caption := 'Payor Country Code';
        Shipment.PayorZipCode := 'US';

      end;
    TibxezshipProviders.pUPS:
      begin
        if gbMailInnovations.Enabled then begin
          if Shipment.Endorsement = 0 then
            Shipment.Endorsement := 1;
          if Shipment.MICostCenter = '' then begin
            //Shipment.MICostCenter := AppEnv.DefaultClass.DefaultClassName;
            qry := DbSharedObj.GetQuery(Shipment.Connection.Connection);
            try
              qry.SQL.Add('select tblsaleslines.ProductName, tblshipmentsaleline.ShipmentId');
              qry.SQL.Add('from tblshipmentsaleline, tblsaleslines');
              qry.SQL.Add('where tblshipmentsaleline.ShipmentId = ' + IntToStr(Shipment.ID));
              qry.SQL.Add('and tblshipmentsaleline.SaleLineId = tblsaleslines.SaleLineID');
              qry.SQL.Add('group by tblshipmentsaleline.ShipmentId');
              qry.Open;
              Shipment.MICostCenter := ShipIntegrationUtils.StrToAlphaNumeric(qry.FieldByName('ProductName').AsString, 30);
            finally
              DbSharedObj.ReleaseObj(qry);
            end;
          end;
          if Shipment.MIPackageID = '' then begin
            //Shipment.MIPackageID := Shipment.GetSaleRefNo;
            qry := DbSharedObj.GetQuery(Shipment.Connection.Connection);
            try
              qry.SQL.Add('select GlobalRef');
              qry.SQL.Add('from tblshippingaddress');
              qry.SQL.Add('where tblshippingaddress.ShipAddressId = ' + IntToStr(Shipment.ShipAddressId));
              qry.Open;
              Shipment.MIPackageID := Shipment.GetSaleRefNo + qry.FieldByName('GlobalRef').AsString;
            finally
              DbSharedObj.ReleaseObj(qry);
            end;
          end;
          { select PackageSignatureType on lines }
          Shipment.Packages.Dataset.DisableControls;
          try
            BM := Shipment.Packages.Dataset.GetBookmark;
            try
              Shipment.Packages.First;
              while not Shipment.Packages.EOF do begin
                Shipment.Packages.PackageSignatureType := TibxezshipPackageSignatureTypes.stUSPSDeliveryConfirmation;
                Shipment.Packages.Next;
              end;
              Shipment.Packages.First;
            finally
              Shipment.Packages.Dataset.GotoBookmark(BM);
              Shipment.Packages.Dataset.FreeBookmark(BM);
            end;
          finally
            Shipment.Packages.Dataset.EnableControls;
          end;
        end
        else begin
          { select PackageSignatureType on lines }
          Shipment.Packages.Dataset.DisableControls;
          try
            BM := Shipment.Packages.Dataset.GetBookmark;
            try
              Shipment.Packages.First;
              while not Shipment.Packages.EOF do begin
                if Shipment.Packages.PackageSignatureType = TibxezshipPackageSignatureTypes.stUSPSDeliveryConfirmation then
                  Shipment.Packages.PackageSignatureType := TibxezshipPackageSignatureTypes.stServiceDefault;
                Shipment.Packages.Next;
              end;
              Shipment.Packages.First;
            finally
              Shipment.Packages.Dataset.GotoBookmark(BM);
              Shipment.Packages.Dataset.FreeBookmark(BM);
            end;
          finally
            Shipment.Packages.Dataset.EnableControls;
          end;
        end;
      end;
    TibxezshipProviders.pUSPS:
      begin
        Shipment.MICostCenter := '';
        Shipment.MIPackageID := '';
        Shipment.Endorsement := 0;

        lblPayorZipCode.Caption := 'Mailing Zip Code';


      end;
    TibxezshipProviders.pCanadaPost:
      begin
        Shipment.MICostCenter := '';
        Shipment.MIPackageID := '';
        Shipment.Endorsement := 0;



      end;
  end;

end;

procedure TfmShipment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TfmShipment.FormCreate(Sender: TObject);
var
  x: integer;
begin
  self.AllowCustomiseGrid := true;
  inherited;
  cboProvider.Items.Clear;
  for x := Low(ShipProviderList) to High(ShipProviderList) do
    cboProvider.Items.Add(ShipProviderList[x].Name);
  Shipment := TShipment.Create(self,MyConnection);
  Shipment.BusObjEvent := DoBusinessObjectEvent;
  RecipientAddressDirty := false;
  RecipientPhoneDirty := false;
end;

procedure TfmShipment.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pcDetails,1);
  lblCanProcess.Left := btnSave.Left - lblCanProcess.Width - 10;
end;

procedure TfmShipment.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      InitialAccessLevel := AccessLevel;
      GUIPrefs.Active := true;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;
      Shipment.Load(KeyId);
      if KeyID = 0 then raise exception.Create(ClassName + ' - KeyId is 0, can''t create new from here');
      Shipment.Packages;

      cboProvider.ItemIndex := cboProvider.Items.IndexOf(ProviderTypeToStr(Shipment.Provider));
      LoadPrefsForProvider;
      SetServicePreferences;

      qrySaleLine.ParamByName('SaleId').AsInteger := Shipment.SaleId;
      qrySaleLine.ParamByName('ShipmentId').AsInteger := Shipment.Id;
      OpenQueries;

      pcDetails.ActivePageIndex := 0;
      RealignTabControl(pcDetails,1);

//      qryPackagesPackageWeightFrac.DisplayLabel := 'Weight (OZ)';
//      if AppEnv.RegionalOptions.RegionType = rUSA then begin
//        qryPackagesPackageWeight.DisplayLabel := 'Weight (LBS)';
//        qryPackagesPackageLength.DisplayLabel := 'Length (IN)';
//        qryPackagesPackageWidth.DisplayLabel := 'Width (IN)';
//        qryPackagesPackageHeight.DisplayLabel := 'Height (IN)';
//      end
//      else begin
//        qryPackagesPackageWeight.DisplayLabel := 'Weight (KGS)';
//        qryPackagesPackageLength.DisplayLabel := 'Length (CM)';
//        qryPackagesPackageWidth.DisplayLabel := 'Width (CM)';
//        qryPackagesPackageHeight.DisplayLabel := 'Height (CM)';
//      end;

      qryShipmentShipDate.DisplayFormat := AppEnv.RegionalOptions.ShortDateformat;
      qryShipmentDeliveryData.DisplayFormat := AppEnv.RegionalOptions.ShortDateformat;

      SetGuiAccess;

      RecipientAddressDirty := false;

      LoadSpecialServices;

//      if IsUPSMailInnovations(Shipment.ServiceType) then begin
//        if Shipment.MICostCenter = '' then
//          SetServicePreferences;
//
//      end;


      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmShipment.grdSaleLineCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qrySaleLine.FieldByName('UnallocatedUOMQty').AsFloat <> 0 then
    ABrush.Color := $00c1c1ff
  else
    if field.FieldName <> 'AllocatedUOMQty' then
      ABrush.Color := $00d7d7d7;
  if field.FieldName = 'UnallocatedUOMQty' then
    AFont.Style := AFont.Style + [fsBold];
end;
procedure TfmShipment.LoadPrefsForSaleCustomer;
var
    qry : TERPQuery;
begin
    qry := DbSharedObj.GetQuery(Shipment.Connection.Connection);
    try
      qry.SQL.Text := ' Select C.* ' +
                      ' from tblsales S     ' +
                      ' inner join tblcustomershippingoptions  C on S.ClientID = C.CustomerID   ' +
                                                              ' AND  C.ShipperType =' + quotedstr(trim(cboProvider.text))+
                                                              ' AND  C.active ="T"   ' +
                                                              ' AND  ifnull(C.ShipperType,"") <>"" ' +
                      ' inner join tblShipmentList sl on sl.SaleID = s.SaleID ' +
                      ' where sl.ShipmentListId = ' + IntToStr(Shipment.ShipmentListId) ;

      qry.Open;
      if qry.recordcount >0 then begin
        cboPayorType.itemindex      := cboPayorType.items.indexof(trim(qry.FieldByName('PayorType').AsString));
        Shipment.PayorType          := StrToPayorType(trim(qry.FieldByName('PayorType').AsString));
        cboPayorType.text           := trim(qry.FieldByName('PayorType').AsString);
        Shipment.PayorAccountNumber := qry.FieldByName('AccountNumber').AsString;
        Shipment.PostDB;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
end;
procedure TfmShipment.LoadPrefsForProvider;
var
  x: integer;
  gf: TGridFieldList;
  rec: TGridFieldRec;
  ProviderShortName: string;
begin
  cboService.Items.Clear;
  cboPackageType.Items.Clear;
  cboPackageCODType.Items.Clear;
  cboLabelImageType.Items.Clear;
  cboPayorType.Items.Clear;
  cboPackageSignatureType.Items.Clear;

  cboPayorType.Enabled := true;
  lblPayorType.Enabled := true;
  lblPayorAccountNumber.Enabled := true;
  edtPayorAccountNumber.Enabled := true;
  lblPayorZipCode.Enabled := true;
  edtPayorZipCode.Enabled := true;

  edtDeliveryDate.Enabled := false;
  lblDeliveryDate.Enabled := false;

  lblDropOffType.Enabled := false;
  cboDropoffType.Enabled := false;

  qryPackagesPackageSpecialService.Visible := false;

  tabFedExSpecialServices.TabVisible := false;

  lblPostageProvider.Visible := false;
  cboPostageProvider.Visible := false;

  edtShipDate.ReadOnly := true;

//  GuiPrefs.DbGridElement[grdPackages].RemoveField('PackageWeightFrac');
  qryPackagesPackageWeightFrac.Visible := false;

//  self.qryPackagesPackageWeight.EditMask := '';

  lblMasterTrackingNumber.Enabled := true;
  edtMasterTrackingNumber.Enabled := true;
  lblTotalBaseCharge.Enabled := true;
  edtTotalBaseCharge.Enabled := true;
  lblTotalSurcharges.Enabled := true;
  edtTotalSurcharges.Enabled := true;
  lblTotalNetChargeNegotiated.Enabled := true;
  edtTotalNetChargeNegotiated.Enabled := true;

  lblSenderCountryCode.Enabled := true;
  edtSenderCountryCode.Enabled := true;
  lblReceipientCountry.Enabled := true;
  edtReceipientCountry.Enabled := true;

  case TibxezshipProviders(Shipment.Provider) of
    TibxezshipProviders.pFedEx:
      begin
        edtDeliveryDate.Enabled := true;
        lblDeliveryDate.Enabled := true;

        lblDropOffType.Enabled := true;
        cboDropoffType.Enabled := True;
        cboDropoffType.ItemIndex := Shipment.DropoffType;

        for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do
          if (ppFEDEX in ShipServiceTypeList[x].Providers) then
            cboService.Items.Add(ShipServiceTypeList[x].Name);
        cboService.ItemIndex := cboService.Items.IndexOf(ShipServiceTypeToStr(Shipment.ServiceType));
        if cboService.ItemIndex < 0 then
          cboService.ItemIndex :=  cboService.Items.IndexOf(SaleShipVia(Shipment.SaleId));

        for x := Low(PackageTypeList) to High(PackageTypeList) do
          if ppFEDEX in PackageTypeList[x].Providers then
            cboPackageType.Items.Add(PackageTypeList[x].Name + #9 + IntToStr(Ord(PackageTypeList[x].Package)));
        for x := Low(PackageCODTypeList) to High(PackageCODTypeList) do
          if ppFEDEX in PackageCODTypeList[x].Providers then
            cboPackageCODType.Items.Add(PackageCODTypeList[x].Name + #9 + IntToStr(Ord(PackageCODTypeList[x].COD)));

        for x := Low(ShipLabelImageFormatList) to High(ShipLabelImageFormatList) do
          if ppFedEx in ShipLabelImageFormatList[x].Providers then
            cboLabelImageType.Items.Add(ShipLabelImageFormatList[x].Name);
//        Shipment.LabelImageType := 1; { PNG }
        cboLabelImageType.ItemIndex := cboLabelImageType.Items.IndexOf(FedExImageTypeToStr(Shipment.LabelImageType));

        for x := Low(PayorTypeList) to High(PayorTypeList) do
          cboPayorType.Items.Add(PayorTypeList[x].Name);
//        cboPayorType.ItemIndex := cboPayorType.Items.IndexOf(PayorTypeToStr(Shipment.PayorType));
//        if cboPayorType.ItemIndex < 0 then
//          cboPayorType.ItemIndex := cboPayorType.Items.IndexOf(GuiPrefs.Node['Provider_' + IntToStr(Ord(Shipment.Provider)) + '.PayerType'].AsString);

//        cboPayorType.Enabled := false;
//        lblPayorType.Enabled := false;




        for x := Low(PackageSignatureTypeList) to High(PackageSignatureTypeList) do
          if ppFedEx in PackageSignatureTypeList[x].Providers then
            cboPackageSignatureType.Items.Add(PackageSignatureTypeList[x].Name + #9 + IntToStr(Ord(PackageSignatureTypeList[x].Signature)));

        tabFedExSpecialServices.TabVisible := true;

        lblTotalBaseCharge.Enabled := false;
        edtTotalBaseCharge.Enabled := false;
        lblTotalSurcharges.Enabled := false;
        edtTotalSurcharges.Enabled := false;
        lblTotalNetChargeNegotiated.Enabled := false;
        edtTotalNetChargeNegotiated.Enabled := false;

        qrySenderCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where FedEx = "T" order by Country';
        if qrySenderCountryCodeLookup.Active then qrySenderCountryCodeLookup.Refresh;
        qryRecipientCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where FedEx = "T" order by Country';
        if qryRecipientCountryCodeLookup.Active then qryRecipientCountryCodeLookup.Refresh;

        qryPackagesPackageBaseCharge.Visible := true;
        qryPackagesPackageCODAmount.Visible := true;
        qryPackagesPackageCODType.Visible := true;
        qryPackagesPackageDangerousGoodsAccessible.Visible := true;
        { Including PackageDescription in the request is producing an error so leave out for now }
        //qryPackagesPackageDescription.Visible := true;
        qryPackagesPackageSignatureType.Visible := true;
        qryPackagesPackageTotalDiscount.Visible := true;
        qryPackagesPackageTotalSurcharges.Visible := true;

        qryPackagesPackageOptNonStandardContainer.Visible := true;
        qryPackagesPackageOptAdditionalHandling.Visible := false;
        qryPackagesPackageOptAppointmentDelivery.Visible := true;
        qryPackagesPackageOptDangeriousGoods.Visible := true;
        qryPackagesPackageOptDryIce.Visible := true;
        qryPackagesPackageOptPriorityAlert.Visible := true;
        qryPackagesPackageOptCOD.Visible := true;
        qryPackagesPackageOptSignatureOption.Visible := true;
        qryPackagesPackageOptAlcohol.Visible := true;

        if Shipment.IsFedExInternational then begin
          qryPackagesCommodityDescription.Visible := true;
          qryPackagesCommodityHarmonizedCode.Visible := true;
          qryPackagesCommodityManufacturer.Visible := true;
          qryPackagesCommodityNumberOfPieces.Visible := true;
          qryPackagesCommodityQuantity.Visible := true;
          qryPackagesCommodityQuantityUnit.Visible := true;
          qryPackagesCommodityUnitPrice.Visible := true;
          qryPackagesCommodityValue.Visible := true;
          qryPackagesCommodityWeight.Visible := true;
        end
        else begin
          qryPackagesCommodityDescription.Visible := false;
          qryPackagesCommodityHarmonizedCode.Visible := false;
          qryPackagesCommodityManufacturer.Visible := false;
          qryPackagesCommodityNumberOfPieces.Visible := false;
          qryPackagesCommodityQuantity.Visible := false;
          qryPackagesCommodityQuantityUnit.Visible := false;
          qryPackagesCommodityUnitPrice.Visible := false;
          qryPackagesCommodityValue.Visible := false;
          qryPackagesCommodityWeight.Visible := false;
        end;


      end;
    TibxezshipProviders.pUPS:
      begin
        for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do
          if (ppUPS in ShipServiceTypeList[x].Providers) and (ssoUSDomestic in ShipServiceTypeList[x].Options) then
            cboService.Items.Add(ShipServiceTypeList[x].Name);
        cboService.ItemIndex := cboService.Items.IndexOf(ShipServiceTypeToStr(Shipment.ServiceType));

        for x := Low(PackageTypeList) to High(PackageTypeList) do
          if ppUPS in PackageTypeList[x].Providers then
            cboPackageType.Items.Add(PackageTypeList[x].Name + #9 + IntToStr(Ord(PackageTypeList[x].Package)));
        for x := Low(PackageCODTypeList) to High(PackageCODTypeList) do
          if ppUPS in PackageCODTypeList[x].Providers then
            cboPackageCODType.Items.Add(PackageCODTypeList[x].Name + #9 + IntToStr(Ord(PackageCODTypeList[x].COD)));
        qrySenderCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where UPS = "T" order by Country';
        if qrySenderCountryCodeLookup.Active then qrySenderCountryCodeLookup.Refresh;
        qryRecipientCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where FedEx = "T" order by Country';
        if qryRecipientCountryCodeLookup.Active then qryRecipientCountryCodeLookup.Refresh;

        for x := Low(UPSShipLabelImageFormatList) to High(UPSShipLabelImageFormatList) do
          cboLabelImageType.Items.Add(UPSShipLabelImageFormatList[x].Name);

//        Shipment.LabelImageType := 0; { GIF }
        cboLabelImageType.ItemIndex := cboLabelImageType.Items.IndexOf(UPSImageTypeToStr(TibxupsshipLabelImageTypes(Shipment.LabelImageType)));



        for x := Low(PayorTypeList) to High(PayorTypeList) do
          cboPayorType.Items.Add(PayorTypeList[x].Name);
        cboPayorType.ItemIndex := cboPayorType.Items.IndexOf(PayorTypeToStr(Shipment.PayorType));

        for x := Low(PackageSignatureTypeList) to High(PackageSignatureTypeList) do
          if ppUPS in PackageSignatureTypeList[x].Providers then
            cboPackageSignatureType.Items.Add(PackageSignatureTypeList[x].Name + #9 + IntToStr(Ord(PackageSignatureTypeList[x].Signature)));

        qryPackagesPackageBaseCharge.Visible := false;
        qryPackagesPackageCODAmount.Visible := true;
        qryPackagesPackageCODType.Visible := true;
        qryPackagesPackageDangerousGoodsAccessible.Visible := false;
        qryPackagesPackageDescription.Visible := true;
        qryPackagesPackageSignatureType.Visible := true;
        qryPackagesPackageTotalDiscount.Visible := false;
        qryPackagesPackageTotalSurcharges.Visible := true;
        qryPackagesPackageInsuredValue.Visible := false;
        qryPackagesPackageNetCharge.Visible := false;

        qryPackagesPackageOptNonStandardContainer.Visible := true;
        qryPackagesPackageOptAdditionalHandling.Visible := true;
        qryPackagesPackageOptAppointmentDelivery.Visible := false;
        qryPackagesPackageOptDangeriousGoods.Visible := false;
        qryPackagesPackageOptDryIce.Visible := false;
        qryPackagesPackageOptPriorityAlert.Visible := false;
        qryPackagesPackageOptCOD.Visible := false;
        qryPackagesPackageOptSignatureOption.Visible := false;
        qryPackagesPackageOptAlcohol.Visible := false;
      end;
    TibxezshipProviders.pUSPS:
      begin
        lblPostageProvider.Visible := true;
        cboPostageProvider.Visible := true;

        cboPostageProvider.ItemIndex := Shipment.PostageProvider;
//        GuiPrefs.DbGridElement[grdPackages].AddFields('PackageWeightFrac',2);
//        self.qryPackagesPackageWeight.EditMask := '!90\ \l\b\s\ 90\ \o\z;1;_';
        qryPackagesPackageWeightFrac.Visible := true;
        qryPackagesPackageWeightFrac.Index := 2;

        edtShipDate.ReadOnly := false;
//        lblMasterTrackingNumber.Enabled := false;
//        edtMasterTrackingNumber.Enabled := false;
        lblTotalBaseCharge.Enabled := false;
        edtTotalBaseCharge.Enabled := false;
        lblTotalSurcharges.Enabled := false;
        edtTotalSurcharges.Enabled := false;
        lblTotalNetChargeNegotiated.Enabled := false;
        edtTotalNetChargeNegotiated.Enabled := false;

        lblSenderCountryCode.Enabled := false;
        edtSenderCountryCode.Enabled := false;
        lblReceipientCountry.Enabled := false;
        edtReceipientCountry.Enabled := false;

        for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do
          if (ppUSPS in ShipServiceTypeList[x].Providers) then
            cboService.Items.Add(ShipServiceTypeList[x].Name);
        cboService.ItemIndex := cboService.Items.IndexOf(ShipServiceTypeToStr(Shipment.ServiceType));

        for x := Low(PackageTypeList) to High(PackageTypeList) do
          if ((not cboPostageProvider.ItemIndex < 1) and (ppUSPS in PackageTypeList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 1) and (ppUSPSEndicia in PackageTypeList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 2) and (ppUSPSStamps in PackageTypeList[x].Providers))  then
            cboPackageType.Items.Add(PackageTypeList[x].Name + #9 + IntToStr(Ord(PackageTypeList[x].Package)));

//        for x := Low(PackageCODTypeList) to High(PackageCODTypeList) do
//          if ppUSPS in PackageCODTypeList[x].Providers then
//            cboPackageCODType.Items.Add(PackageCODTypeList[x].Name + #9 + IntToStr(Ord(PackageCODTypeList[x].COD)));

        for x := Low(ShipLabelImageFormatList) to High(ShipLabelImageFormatList) do
          if ((cboPostageProvider.ItemIndex < 1) and (ppUSPS in ShipLabelImageFormatList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 1) and (ppUSPSEndicia in ShipLabelImageFormatList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 2) and (ppUSPSStamps in ShipLabelImageFormatList[x].Providers)) then
            cboLabelImageType.Items.Add(ShipLabelImageFormatList[x].Name);

//        Shipment.LabelImageType := 1; { TIF }
        cboLabelImageType.ItemIndex := cboLabelImageType.Items.IndexOf(USPSImageTypeToStr(Shipment.LabelImageType));

//        for x := Low(PayorTypeList) to High(PayorTypeList) do
//          cboPayorType.Items.Add(PayorTypeList[x].Name);
//        cboPayorType.ItemIndex := cboPayorType.Items.IndexOf(PayorTypeToStr(Shipment.PayorType));
        cboPayorType.Enabled := false;
        lblPayorType.Enabled := false;
        lblPayorAccountNumber.Enabled := false;
        edtPayorAccountNumber.Enabled := false;
//        lblPayorZipCode.Enabled := false;
//        edtPayorZipCode.Enabled := false;

        for x := Low(PackageSignatureTypeList) to High(PackageSignatureTypeList) do
          if ((cboPostageProvider.ItemIndex < 1) and (ppUSPS in PackageSignatureTypeList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 1) and (ppUSPSEndicia in PackageSignatureTypeList[x].Providers)) or
             ((cboPostageProvider.ItemIndex = 2) and (ppUSPSStamps in PackageSignatureTypeList[x].Providers)) then
            cboPackageSignatureType.Items.Add(PackageSignatureTypeList[x].Name + #9 + IntToStr(Ord(PackageSignatureTypeList[x].Signature)));


        qrySenderCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where USPS = "T" order by Country';
        if qrySenderCountryCodeLookup.Active then qrySenderCountryCodeLookup.Refresh;

        qryPackagesPackageBaseCharge.Visible := false;
        qryPackagesPackageCODAmount.Visible := false;
        qryPackagesPackageCODType.Visible := false;
        qryPackagesPackageDangerousGoodsAccessible.Visible := false;
        qryPackagesPackageDescription.Visible := false;
        qryPackagesPackageSignatureType.Visible := true;
        qryPackagesPackageTotalDiscount.Visible := false;
        qryPackagesPackageTotalSurcharges.Visible := false;

        qryPackagesPackageOptNonStandardContainer.Visible := false;
        qryPackagesPackageOptAdditionalHandling.Visible := false;
        qryPackagesPackageOptAppointmentDelivery.Visible := false;
        qryPackagesPackageOptDangeriousGoods.Visible := false;
        qryPackagesPackageOptDryIce.Visible := false;
        qryPackagesPackageOptPriorityAlert.Visible := false;
        qryPackagesPackageOptCOD.Visible := false;
        qryPackagesPackageOptSignatureOption.Visible := false;
        qryPackagesPackageOptAlcohol.Visible := false;
     end;
    TibxezshipProviders.pCanadaPost:
      begin
        qrySenderCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where CanadaPost = "T" order by Country';
        if qrySenderCountryCodeLookup.Active then qrySenderCountryCodeLookup.Refresh;
        qryRecipientCountryCodeLookup.SQL.Text :=
          'select * from tblCountries where FedEx = "T" order by Country';
        if qryRecipientCountryCodeLookup.Active then qryRecipientCountryCodeLookup.Refresh;

        qryPackagesPackageBaseCharge.Visible := true;
        qryPackagesPackageCODAmount.Visible := false;
        qryPackagesPackageCODType.Visible := false;
        qryPackagesPackageDangerousGoodsAccessible.Visible := false;
        qryPackagesPackageDescription.Visible := false;
        qryPackagesPackageSignatureType.Visible := false;
        qryPackagesPackageTotalDiscount.Visible := false;
        qryPackagesPackageTotalSurcharges.Visible := false;

        qryPackagesPackageOptNonStandardContainer.Visible := false;
        qryPackagesPackageOptAdditionalHandling.Visible := false;
        qryPackagesPackageOptAppointmentDelivery.Visible := false;
        qryPackagesPackageOptDangeriousGoods.Visible := false;
        qryPackagesPackageOptDryIce.Visible := false;
        qryPackagesPackageOptPriorityAlert.Visible := false;
        qryPackagesPackageOptCOD.Visible := false;
        qryPackagesPackageOptSignatureOption.Visible := false;
        qryPackagesPackageOptAlcohol.Visible := false;
      end;
  end;
  if edtPayorAccountNumber.Enabled and (edtPayorAccountNumber.Text = '') then
    Shipment.PayorAccountNumber := GuiPrefs.Node['Provider_' + IntToStr(Ord(Shipment.Provider)) + '.PayerAccountNumber'].AsString;

  pcDetails.Refresh;
  RealignTabControl(pcDetails,1);

  { fix up column groups .. }
  case Shipment.Provider of
    ibxezship.pFedEx: ProviderShortName := 'FedEx';
    ibxezship.pUPS: ProviderShortName := 'UPS';
    ibxezship.pUSPS: ProviderShortName := 'USPS';
    ibxezship.pCanadaPost: ProviderShortName := 'Canada Post';
  end;

  gf := TGridFieldList.Create;
  try
    gf.LoadFromGrid(grdPackages);
    for x := 0 to gf.Count -1 do begin
      rec := gf.Items[x];
      if SameText(rec.FieldName, 'PackageOptNonStandardContainer') or
         SameText(rec.FieldName, 'PackageOptAdditionalHandling') or
         SameText(rec.FieldName, 'PackageOptAppointmentDelivery') or
         SameText(rec.FieldName, 'PackageOptDangeriousGoods') or
         SameText(rec.FieldName, 'PackageOptDryIce') or
         SameText(rec.FieldName, 'PackageOptPriorityAlert') or
         SameText(rec.FieldName, 'PackageOptCOD') or
         SameText(rec.FieldName, 'PackageOptSignatureOption') or
         SameText(rec.FieldName, 'PackageOptAlcohol') then
        rec.GroupName := 'Package Options'
      else if SameText(rec.FieldName, 'PackageType') then
        rec.DisplayLabel := ProviderShortName + '~Package Type'
      else if SameText(rec.FieldName, 'PackageWeight') then begin
        if AppEnv.RegionalOptions.RegionType = rUSA then
          rec.DisplayLabel := ProviderShortName + '~Weight (LBS)'
        else
          rec.DisplayLabel := ProviderShortName + '~Weight (KGS)'
      end
      else if SameText(rec.FieldName, 'PackageHeight') then begin
        if AppEnv.RegionalOptions.RegionType = rUSA then
          rec.DisplayLabel := ProviderShortName + '~Height (IN)'
        else
          rec.DisplayLabel := ProviderShortName + '~Height (CM)'
      end
      else if SameText(rec.FieldName, 'PackageLength') then begin
        if AppEnv.RegionalOptions.RegionType = rUSA then
          rec.DisplayLabel := ProviderShortName + '~Length (IN)'
        else
          rec.DisplayLabel := ProviderShortName + '~Length (CM)'
      end
      else if SameText(rec.FieldName, 'PackageWidth') then begin
        if AppEnv.RegionalOptions.RegionType = rUSA then
          rec.DisplayLabel := ProviderShortName + '~Width (IN)'
        else
          rec.DisplayLabel := ProviderShortName + '~Width (CM)'
      end
      else if SameText(rec.FieldName, 'PackageWeightFrac') then begin
        rec.DisplayLabel := ProviderShortName + '~Weight (OZ)';
      end;

    end;
    gf.SaveToGrid(grdPackages);
  finally
    gf.Free;
  end;
  LoadPrefsForSaleCustomer;
end;

procedure TfmShipment.LoadSpecialServices;
var
  services: integer;
begin
  services := Shipment.ShipmentSpecialServices;
  self.AddFlag('LoadingSpecialServices');
  try
    chkBrokerSelect.Checked :=  ssBrokerSelect in TIntegerSet(services);
    chkCallBeforeDelivery.Checked := ssCallBeforeDelivery in TIntegerSet(services);
    chkCOD.Checked := ssCOD in TIntegerSet(services);
    chkCustomDeliveryWindow.Checked := ssCustomDeliveryWindow in TIntegerSet(services);
    chkDangeriousGoods.Checked := ssDangeriousGoods in TIntegerSet(services);
    chkDoNotBreakDownPallets.Checked := ssDoNotBreakDownPallets in TIntegerSet(services);
    chkDoNotStackPallets.Checked := ssDoNotStackPallets in TIntegerSet(services);
    chkDryIce.Checked := ssDryIce in TIntegerSet(services);
    chkEastCoastSpecial.Checked := ssEastCoastSpecial in TIntegerSet(services);
    chkElectronicTradeDocuments.Checked := ssElectronicTradeDocuments in TIntegerSet(services);
    chkEmailNotification.Checked := ssEmailNotification in TIntegerSet(services);
    chkExtreamLength.Checked := ssExtreamLength in TIntegerSet(services);
    chkFood.Checked := ssFood in TIntegerSet(services);
    chkFreightGuarantee.Checked := ssFreightGuarantee in TIntegerSet(services);
    chkFutureDay.Checked := ssFutureDay in TIntegerSet(services);
    chkHoldAtLocation.Checked := ssHoldAtLocation in TIntegerSet(services);
    chkInternationalControlledExportService.Checked := ssInternationalControlledExportService in TIntegerSet(services);
    chkHomeDeliveryPremium.Checked := ssHomeDeliveryPremium in TIntegerSet(services);
    chkInsideDelivery.Checked := ssInsideDelivery in TIntegerSet(services);
    chkInsidePickup.Checked := ssInsidePickup in TIntegerSet(services);
    chkLiftgateDelivery.Checked := ssLiftgateDelivery in TIntegerSet(services);
    chkLiftgatePickup.Checked := ssLiftgatePickup in TIntegerSet(services);
    chkLimitedAccessDelivery.Checked := ssLimitedAccessDelivery in TIntegerSet(services);
    chkLimitedAccessPickup.Checked := ssLimitedAccessPickup in TIntegerSet(services);
    chkPendingShipment.Checked := ssPendingShipment in TIntegerSet(services);
    chkPoison.Checked := ssPoison in TIntegerSet(services);
    chkProtectionFromFreezing.Checked := ssProtectionFromFreezing in TIntegerSet(services);
    chkReturnShipment.Checked := ssReturnShipment in TIntegerSet(services);
    chkSaturdayDelivery.Checked := ssSaturdayDelivery in TIntegerSet(services);
    chkSaturdayPickup.Checked := ssSaturdayPickup in TIntegerSet(services);
    chkTopLoad.Checked := ssTopLoad in TIntegerSet(services);
    chkInternationalTrafficinArmsRegulations.Checked := ssInternationalTrafficinArmsRegulations in TIntegerSet(services);
  finally
    self.RemoveFlag('LoadingSpecialServices');
  end;
end;

procedure TfmShipment.mnuViewShippingLabelClick(Sender: TObject);
var
  tempFile: string;
begin
  inherited;
  if TBlobField(Shipment.Packages.Dataset.FieldByName('PackageShippingLabel')).BlobSize = 0 then
     CommonLib.MessageDlgXP_Vista('There is no Shipping Label for this package.',mtInformation,[mbOk],0)
  else begin
    if Shipment.Provider = ibxezship.pUPS then begin
      tempFile := SystemLib.GetTempFileName('','.' +UPSImageTypeToStr(TibxupsshipLabelImageTypes(Shipment.LabelImageType)),true);
      TBlobField(Shipment.Packages.Dataset.FieldByName('PackageShippingLabel')).SaveToFile(tempFile);
      ShellAPI.ShellExecute(Handle, nil, PChar(tempFile), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end;

procedure TfmShipment.qryPackagesBeforePost(DataSet: TDataSet);
begin
  inherited;
  //
end;

procedure TfmShipment.qryPackagesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryPackagesPackageOptNonStandardContainer.AsBoolean := Shipment.Packages.PackageOptNonStandardContainer;
  qryPackagesPackageOptAdditionalHandling.AsBoolean := Shipment.Packages.PackageOptAdditionalHandling;
  qryPackagesPackageOptAppointmentDelivery.AsBoolean := Shipment.Packages.PackageOptAppointmentDelivery;
  qryPackagesPackageOptDangeriousGoods.AsBoolean := Shipment.Packages.PackageOptDangerousGoods;
  qryPackagesPackageOptDryIce.AsBoolean := Shipment.Packages.PackageOptDryIce;
  qryPackagesPackageOptPriorityAlert.AsBoolean := Shipment.Packages.PackageOptPriorityAlert;
  qryPackagesPackageOptCOD.AsBoolean := Shipment.Packages.PackageOptCOD;
  qryPackagesPackageOptSignatureOption.AsBoolean := Shipment.Packages.PackageOptSignatureOption;
  qryPackagesPackageOptAlcohol.AsBoolean := Shipment.Packages.PackageOptAlcohol;
end;

procedure TfmShipment.qryPackagesPackageOptSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  if Sender = qryPackagesPackageOptNonStandardContainer then Shipment.Packages.PackageOptNonStandardContainer := Text = 'True'
  else if Sender = qryPackagesPackageOptAdditionalHandling then Shipment.Packages.PackageOptAdditionalHandling := Text = 'True'
  else if Sender = qryPackagesPackageOptAppointmentDelivery then Shipment.Packages.PackageOptAppointmentDelivery := Text = 'True'
  else if Sender = qryPackagesPackageOptDangeriousGoods then Shipment.Packages.PackageOptDangerousGoods := Text = 'True'
  else if Sender = qryPackagesPackageOptDryIce then Shipment.Packages.PackageOptDryIce := Text = 'True'
  else if Sender = qryPackagesPackageOptPriorityAlert then Shipment.Packages.PackageOptPriorityAlert := Text = 'True'
  else if Sender = qryPackagesPackageOptCOD then Shipment.Packages.PackageOptCOD := Text = 'True'
  else if Sender = qryPackagesPackageOptSignatureOption then Shipment.Packages.PackageOptSignatureOption := Text = 'True'
  else if Sender = qryPackagesPackageOptAlcohol then Shipment.Packages.PackageOptAlcohol := Text = 'True'
end;

procedure TfmShipment.qrySaleLineAllocatedUOMQtySetText(Sender: TField;
  const Text: string);
begin
  inherited;
  if Shipment.SalesLines.Dataset.Locate('SaleLineId', qrySaleLine.FieldByName('SaleLineId').AsInteger, []) then begin
    Shipment.SalesLines.UOMQty := StrToFloatDef(Text,0);
    Shipment.SalesLines.PostDb;
  end
  else begin
   Shipment.SalesLines.New;
   Shipment.SalesLines.SaleLineId := qrySaleLine.FieldByName('SaleLineId').AsInteger;
    Shipment.SalesLines.UOMQty := StrToFloatDef(Text,0);
    Shipment.SalesLines.PostDb;
  end;
  Sender.DataSet.Cancel;
  qrySaleLine.Refresh;
end;

procedure TfmShipment.grdPackagesCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (Field = qryPackagesPackageTotalSurcharges) or
    (Field = qryPackagesPackageTrackingNumber) then
    ABrush.Color := $00f3f3f3;

end;

procedure TfmShipment.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  if qryPackages.RecNo > 1 then
    Shipment.Packages.Delete;
end;

initialization
  RegisterClass(TfmShipment);

end.
