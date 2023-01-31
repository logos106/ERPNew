unit ShipAddressForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls,
  Mask, wwdbedit, wwdblook, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, DBCtrls, Wwdotdot,
  Wwdbcomb, SelectionDialog, Grids, Wwdbigrd, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, Shader, wwcheckbox,
  ImgList, ProgressDialog;

type
  TShipAddressGUI = class(TBaseInputGUI)
    dscMain: TDataSource;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblCustomer: TLabel;
    cboshiptoaddress: TwwDBLookupCombo;
    Label1: TLabel;
    qrySuburb: TERPQuery;
    tblMain: TERPQuery;
    qryMaindelete: TERPQuery;
    qryAddresses: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkActive: TwwCheckBox;
    Label36: TLabel;
    tblMainGlobalRef: TWideStringField;
    tblMainShipAddressID: TIntegerField;
    tblMainCompanyName: TWideStringField;
    tblMainCustomer_ID: TIntegerField;
    tblMainShipAddress: TWideStringField;
    tblMainShipAddress1: TWideStringField;
    tblMainShipCity: TWideStringField;
    tblMainShipPostCode: TWideStringField;
    tblMainShipState: TWideStringField;
    tblMainShipCountry: TWideStringField;
    tblMainEditedFlag: TWideStringField;
    tblMainmsTimeStamp: TDateTimeField;
    tblMainShipAddress2: TWideStringField;
    tblMainActive: TWideStringField;
    tblMainPortOfLanding: TWideStringField;
    tblMainPortOfDischarge: TWideStringField;
    tblMainFinalDestination: TWideStringField;
    tblMainIncoPlace: TWideStringField;
    tblMainPhone: TWideStringField;
    tblMainemail: TWideStringField;
    tblMainContactName: TWideStringField;
    tblMainmsUpdateSiteCode: TWideStringField;
    tblMainCustomerPhysicalAddress: TWideStringField;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblPostCode: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtAddress: TwwDBEdit;
    edtAddress2: TwwDBEdit;
    State: TwwDBEdit;
    PostCode: TwwDBEdit;
    Suburb: TwwDBLookupCombo;
    edtCountry: TwwDBEdit;
    edtCompany: TwwDBEdit;
    edtAddress3: TwwDBEdit;
    cboPortOfLoading: TwwDBLookupCombo;
    cboPortOfDischarge: TwwDBLookupCombo;
    cboFinalDestination: TwwDBLookupCombo;
    cboIncoPlace: TwwDBLookupCombo;
    Phone: TwwDBEdit;
    edtEmail: TwwDBEdit;
    edtContactName: TwwDBEdit;
    lblMsg: TLabel;
    tblMainAddressValidated: TWideStringField;
    chkAddressValidated: TwwCheckBox;
    Label14: TLabel;
    btnValidateAddress: TDNMSpeedButton;
    Label15: TLabel;
    wwDBEdit1: TwwDBEdit;
    tblMainLocationCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboshiptoaddressCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboshiptoaddressNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure SuburbEnter(Sender: TObject);
    procedure edtCompanyExit(Sender: TObject);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure cboPortOfLoadingEnter(Sender: TObject);
    procedure cboFinalDestinationEnter(Sender: TObject);
    procedure cboPortOfDischargeEnter(Sender: TObject);
    procedure cboIncoPlaceEnter(Sender: TObject);
    procedure tblMainAfterInsert(DataSet: TDataSet);
    procedure chkActiveClick(Sender: TObject);
    procedure tblMainAfterOpen(DataSet: TDataSet);
    procedure tblMainAfterPost(DataSet: TDataSet);
    procedure edtAddressChange(Sender: TObject);
    procedure edtAddress2Change(Sender: TObject);
    procedure edtAddress3Change(Sender: TObject);
    procedure SuburbChange(Sender: TObject);
    procedure StateChange(Sender: TObject);
    procedure PostCodeChange(Sender: TObject);
    procedure edtCountryChange(Sender: TObject);
    procedure btnValidateAddressClick(Sender: TObject);
    procedure edtCompanyChange(Sender: TObject);
    procedure edtContactNameChange(Sender: TObject);
    procedure PhoneChange(Sender: TObject);
    procedure SuburbExit(Sender: TObject);
    procedure StateExit(Sender: TObject);
    procedure PostCodeExit(Sender: TObject);
    procedure edtCountryExit(Sender: TObject);
  private
    { Private declarations }
    fiClientID: integer;
    fsClientName: string;
    iShipAddressID: integer;
    bNameEntered: boolean;
    procedure SetClientID(const iClientID: integer);
    procedure SetClientName(const sClientName: string);
    procedure CheckLocationCode;
  public
    { Public declarations }
    property ClientID: integer read fiClientID write SetClientID;
    property ClientName: string read fsClientName write SetClientName;
    
  end;

implementation

{$R *.dfm}
uses
  FormFactory, DNMExceptions, AuditObj, 
  CommonLib,  AppEnvironment, FastFuncs, tcConst, BusObjShippingAddress,
  ShipIntegrationUtils, JsonObject, ShipAddressValidationObj, ibxezaddress,
  BusObjLocation;

var
  bIsNewAddress: boolean;    // True if new address

procedure TShipAddressGUI.SetClientName(const sClientName: string);
begin
  fsClientName := sClientName;
  lblCustomer.Caption := sClientName;
end;


procedure TShipAddressGUI.StateChange(Sender: TObject);
begin
  inherited;
  if State.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.StateExit(Sender: TObject);
begin
  inherited;
  CheckLocationCode;
end;

procedure TShipAddressGUI.SetClientID(const iClientID: integer);
begin
  fiClientID := iClientID;
end;

procedure TShipAddressGUI.FormShow(Sender: TObject);
var
  aysDonotOpenQueries: array of string;
begin
  DisableForm;
  try
    MyConnection.Connected := true;
    BeginTransaction;
    try
      inherited;
      if tblMain.Active then begin
        if not (tblMain.State in [dsBrowse]) then begin
          tblMain.Post;
          Notify;
        end;
        CloseQueries;
      end;
      tblMain.Params.ParamByName('xID').AsInteger := KeyID;
      Setlength(aysDonotOpenQueries, 2);
      aysDonotOpenQueries[0] := 'qrySuburb';
      aysDonotOpenQueries[1] := 'qryLocations';
      OpenQueries(aysDoNotOpenQueries);
      tblMain.Open;
      if KeyID = 0 then begin
        bIsNewAddress := true;
        cboshiptoAddress.Enabled := true;
        tblMain.Insert;
        if tblMainCompanyName.asString = '' then SetControlFocus(cboshiptoAddress) else setcontrolfocus(edtAddress);
      end else begin
        fiClientID := tblMainCustomer_ID.AsInteger;
        ClientName := tblMainCompanyName.AsString;
        iShipAddressID := KeyID;
        bIsNewAddress := false;
        cboshiptoAddress.Enabled := false;
        SetControlFocus(edtAddress);
        tblMain.Edit;
        tblMain.FieldByName('EditedFlag').AsString := 'T';
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TShipAddressGUI.PhoneChange(Sender: TObject);
begin
  inherited;
  if Phone.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.PostCodeChange(Sender: TObject);
begin
  inherited;
  if PostCode.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.PostCodeExit(Sender: TObject);
begin
  inherited;
  CheckLocationCode;
end;

procedure TShipAddressGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  Notify;
  //  ShipAddressGUI := nil;
end;

procedure TShipAddressGUI.SuburbChange(Sender: TObject);
begin
  inherited;
  if Suburb.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.FieldByName('ShipState').asString := LookupTable.FieldByName('State').asString;
  FillTable.FieldByName('ShipPostcode').asString := LookupTable.FieldByName('Postcode').asString;
  FillTable.FieldByName('ShipCountry').asString := LookupTable.FieldByName('Country').asString;
  FillTable.FieldByName('Locationcode').asString := LookupTable.FieldByName('Code').asString;
end;

procedure TShipAddressGUI.btnDeleteClick(Sender: TObject);
var
  qryLink: TERPQuery;
begin
  inherited;
  if (fiClientID <> 0) then begin
    qryLink := TERPQuery.Create(Self);
    qryLink.Connection := MyConnection;
    try
      with qryLink do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE from tblClientToShipAddressLink ' +
          'WHERE ClientID = :xClientID AND ' +
          'ShipAddressID = :xShipAddressID');
        ParamByName('xClientID').asInteger := fiClientID;
        ParamByName('xShipAddressID').asInteger := tblMain.FieldByName('ShipAddressID').asInteger;
        Execute;
      end;
    finally
      FreeandNil(qryLink);
      if fsModal in FormState then
        ModalResult := mrOk
      else
      Self.Close;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You have no Client selected - You cannot perform this function',
      mtWarning, [mbOK], 0);
  end;
end;

procedure TShipAddressGUI.btnSaveClick(Sender: TObject);
var
  qryLink: TERPQuery;
  iShipAddressID: integer;
  bSaveToLink: boolean;
  objLink: TClientToShipAddressLink;
begin
  if not Empty(edtCompany.Text) then begin
    try
     tblMain.Post;
      // First post shipping address
      if tblMain.FieldByName('Customer_ID').AsInteger = 0 then begin
        { only set this for new records, not addresses that belong to another supplier }
        EditDb(tblMain);
        tblMain.FieldByName('Customer_ID').AsInteger := fiClientID;
        tblMain.Post;
      end;

      tblMain.RefreshRecord;
      iShipAddressId := tblMain.FieldByName('ShipAddressID').AsInteger;
      tblMain.Close;

      // if customer is assigned then post to link table
      if (fiClientID <> 0) then begin
        // first check if this address has not already been assigned to this client
        qryLink := TERPQuery.Create(Self);
        qryLink.Connection := MyConnection;
        try
          with qryLink do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT ShipAddressID FROM tblClientToShipAddressLink ' +
              'WHERE ClientID = :xClientID AND ShipAddressID = :xShipAddressID');
            ParamByName('xClientID').asInteger := fiClientID;
            ParamByName('xShipAddressID').asInteger := iShipAddressID;
            Open;
            if IsEmpty then begin
              // client/address combination does not exist - should Save
              bSaveToLink := true;
            end else begin
              // client/address combination does exist - no need to Save
              bSaveToLink := false;
            end;
          end;
        finally
          FreeandNil(qryLink);
        end;

        if bSaveToLink then begin
          // Save this client/address combination to link table
          objLink := TClientToShipAddressLink.Create(nil, MyConnection);
          try
            objLink.New;
            objLink.ClientID := fiClientID;
            objLink.ShipAddressID := iShipAddressID;
            if not objLink.Save then exit;
          finally
            objLink.Free;
          end;
        end;
      end;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' +
          Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
    CommitTransaction;
    Notify;
    if fsModal in FormState then
      ModalResult := mrOk
    else
      Self.Close;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must Enter a Name', mtInformation, [mbOK], 0);
    SetControlFocus(edtCompany);
  end;
end;

procedure TShipAddressGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Self.Close;
end;

procedure TShipAddressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiClientID := 0;
  bIsNewAddress := false;
  bNameEntered := false;
end;

procedure TShipAddressGUI.cboshiptoaddressCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  if (Trim(cboshiptoAddress.Text) = '') then exit;
  inherited;
  bIsNewAddress := false;
  if (tblMain.State in [dsInsert]) then begin
    tblMain.Cancel;
  end;
  tblMain.Close;
  If not (cboshiptoAddress.LookupValue='') then
    tblMain.Params.ParamByName('xID').AsInteger := FastFuncs.StrToInt(cboshiptoAddress.LookupValue)
  else
    tblMain.Params.ParamByName('xID').AsInteger := 0;
  tblMain.Open;
  tblMain.Edit;
  //cboshiptoAddress.Enabled := false;
  SetControlFocus(btnSave);
end;

procedure TShipAddressGUI.cboshiptoaddressNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('You can only select from the list'#13 +
    'Enter a new Address manually', mtInformation, [mbOK], 0);
  SetControlFocus(edtCompany);
  Accept := false;
end;

procedure TShipAddressGUI.CheckLocationCode;
begin
  if AccessLevel > 3 then
    exit;
  if tblMainLocationCode.AsString = '' then
    tblMainLocationCode.AsString :=
      TLocation.CodeForLocation(
        tblMainShipCountry.AsString,
        tblMainShipCity.AsString,
        tblMainShipState.AsString,
        tblMainShipPostCode.AsString);
end;

procedure TShipAddressGUI.chkActiveClick(Sender: TObject);
begin
  inherited;
  if not (Screen.activecontrol = chkActive) then exit;
  EditDb(tblMain);
  tblMainActive.asBoolean := chkActive.checked;
  PostDB(tblMain);
  EditDb(tblMain);
end;

procedure TShipAddressGUI.btnValidateAddressClick(Sender: TObject);
var
  val: TShipAddressValidation;
  ShippingProviders: ShippingProviderSet;
begin
  inherited;
  ShippingProviders := [];
  DisableForm;
  try
    if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
      ShippingProviders := ShippingProviders + [pUPS];
    if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then
      ShippingProviders := ShippingProviders + [pUSPS];
    if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then
      ShippingProviders := ShippingProviders + [pFedEx];
    if ShippingProviders = [] then begin
      MessageDlgXP_Vista('You do not have a Shipping Provider configured in Preferences to use for Address Validation.', mtInformation, [mbOK], 0);
      exit;
    end;


    val := TShipAddressValidation.Create;
    try
  //    if Length(tblMainPhone.AsString) < 10 then
  //      val.ErrMessage := 'Phone Number must be at least 10 alphanumeric characters long.';
      if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
        val.Providers := ShippingProviders; //TibxezaddressProviders(pUPS);
      val.Address.AddressLine1 := tblMainShipAddress.AsString;
      val.Address.AddressLine2 := tblMainShipAddress1.AsString;
      val.Address.AddressLine3 := tblMainShipAddress2.AsString;
      val.Address.City := tblMainShipCity.AsString;
      val.Address.State := tblMainShipState.AsString;
      val.Address.PostCode := tblMainShipPostCode.AsString;
      val.Address.Country := tblMainShipCountry.AsString;
      val.Address.Updated := false;

      if (val.ErrMessage = '') and val.ValidateAddress then begin
          EditDb(tblMain);
          if val.Address.Updated then begin
          if not SameText(val.Address.AddressLine1,tblMainShipAddress.AsString) then
            tblMainShipAddress.AsString := val.Address.AddressLine1;
          if not SameText(val.Address.AddressLine2, tblMainShipAddress1.AsString) then
            tblMainShipAddress1.AsString := val.Address.AddressLine2;
          if not SameText(val.Address.AddressLine3, tblMainShipAddress2.AsString) then
            tblMainShipAddress2.AsString := val.Address.AddressLine3;
          if not SameText(val.Address.City, tblMainShipCity.AsString) then
            tblMainShipCity.AsString := val.Address.City;
          if not SameText(val.Address.State, tblMainShipState.AsString) then
            tblMainShipState.AsString := val.Address.State;
          if not SameText(val.Address.PostCode, tblMainShipPostCode.AsString) then
            tblMainShipPostCode.AsString := val.Address.PostCode;
          if not SameText(val.Address.Country, tblMainShipCountry.AsString) then
            tblMainShipCountry.AsString := val.Address.Country;
        end;
        tblMainAddressValidated.AsBoolean := true;
        CommonLib.MessageDlgXP_Vista('Address is valid.', mtInformation, [mbOk], 0);
      end
      else if val.ErrMessage <> '' then begin
  //      CommonLib.MessageDlgXP_Vista(val.ErrMessage,mtWarning,[mbOk],0);
        if CommonLib.MessageDlgXP_Vista(val.ErrMessage + #13#10 + #13#10  + ' Do you want to flag address as valid anyway?',mtWarning,[mbNo,mbYes],0) = mrYes then
          tblMainAddressValidated.AsBoolean := true;
      end;
    finally
      val.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TShipAddressGUI.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TShipAddressGUI.SuburbExit(Sender: TObject);
begin
  inherited;
  CheckLocationCode;
end;

procedure TShipAddressGUI.tblMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if (ClientName<> '') and (Appenv.CompanyPrefs.LoadCustnameinNewshippingAddress) then begin
    tblMainCompanyName.asString :=ClientName;
  end;
end;

procedure TShipAddressGUI.tblMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
      hideTimerMsg;
      edtCompany.readonly           := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtContactName.readonly       := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtAddress.readonly           := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtAddress2.readonly          := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtAddress3.readonly          := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      Suburb.readonly               := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      State.readonly                := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      PostCode.readonly             := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtCountry.readonly           := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      edtEmail.readonly             := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      Phone.readonly                := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      cboPortOfLoading.readonly     := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      cboFinalDestination.readonly  := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      cboPortOfDischarge.readonly   := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      cboIncoPlace.readonly         := tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3);
      btnValidateAddress.Enabled    := not (tblMainCustomerPhysicalAddress.AsBoolean or (Accesslevel >=3));
  if tblMainCustomerPhysicalAddress.AsBoolean and (Accesslevel <5) then begin
      TimerMsg(lblMsg, 'This is ' + tblMainCompanyName.AsString +'''s Physical Address which cannot be modified.  Access has been changed to read-only.', 30);
  end;
end;

procedure TShipAddressGUI.tblMainAfterPost(DataSet: TDataSet);
begin
  inherited;
  if tblMainGlobalRef.AsString = '' then begin
    EditDb(tblMain);
    tblMainGlobalRef.AsString := AppEnv.Branch.SiteCode + IntToStr(tblMainShipAddressID.AsInteger);
  end;
  if tblMainmsUpdateSiteCode.AsString <> AppEnv.Branch.SiteCode then begin
    EditDb(tblMain);
    tblMainmsUpdateSiteCode.AsString := AppEnv.Branch.SiteCode;
  end;
  PostDb(tblMain);
end;

procedure TShipAddressGUI.edtAddress2Change(Sender: TObject);
begin
  inherited;
  if edtAddress2.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtAddress3Change(Sender: TObject);
begin
  inherited;
  if edtAddress3.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtAddressChange(Sender: TObject);
begin
  inherited;
  if edtAddress.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtCompanyChange(Sender: TObject);
begin
  inherited;
  if edtCompany.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtCompanyExit(Sender: TObject);
begin
  inherited;
  if not Empty(edtCompany.Text) then begin
    if bIsNewAddress and (not bNameEntered) then begin
      bNameEntered := true;
      tblMain.Post;
      iShipAddressID := tblMain.FieldByName('ShipAddressID').AsInteger;
      tblMain.Edit;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must Enter a Name', mtInformation, [mbOK], 0);
    SetControlFocus(edtCompany);
  end;
end;

procedure TShipAddressGUI.edtContactNameChange(Sender: TObject);
begin
  inherited;
  if edtContactName.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtCountryChange(Sender: TObject);
begin
  inherited;
  if edtCountry.Focused then begin
    editdb(tblMain);
    tblMainAddressValidated.AsBoolean := false;
  end;
end;

procedure TShipAddressGUI.edtCountryExit(Sender: TObject);
begin
  inherited;
  CheckLocationCode;
end;

procedure TShipAddressGUI.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TShipAddressGUI.cboPortOfLoadingEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TShipAddressGUI.cboFinalDestinationEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TShipAddressGUI.cboPortOfDischargeEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TShipAddressGUI.cboIncoPlaceEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

initialization
  RegisterClassOnce(TShipAddressGUI);
  with FormFact do begin
    // register 'address' column first to overcome little bug in form factory
    RegisterMe(TShipAddressGUI, 'TShipAddressListGUI_Address=ShipAddressID');
    RegisterMe(TShipAddressGUI, 'TShipAddressListGUI_*_ShippingAddress=ShipAddressID');
  end;
end.
