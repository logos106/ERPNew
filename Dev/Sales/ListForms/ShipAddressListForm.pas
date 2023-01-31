unit ShipAddressListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/02/06 1.00.01  DSP  Removed the 'ShipAddressID' field from the grid display.
 09/02/06 1.00.02  DSP  Changed HiddenFields to HideField.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MyAccess,ERPdbComponents,
  DBAccess, MemDS, wwdbdatetimepicker, ProgressDialog,
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox , IntegerListObj, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TShipAddressListGUI = class(TBaseListingGUI)
    btnEdit: TDNMSpeedButton;
    qryMainCompanyName: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainAddress2: TWideStringField;
    qryMainCity: TWideStringField;
    qryMainPostCode: TWideStringField;
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainShipAddressId: TIntegerField;
    qryMainAddress3: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPortOfLanding: TWideStringField;
    qryMainPortOfDischarge: TWideStringField;
    qryMainFinalDestination: TWideStringField;
    qryMainIncoPlace: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainShipAddressIdAlreadySelected: TStringField;
    qryMainCustomerPhysicalAddress: TWideStringField;
    qryMainClientID: TIntegerField;
    mnuValidateAddress: TMenuItem;
    N1: TMenuItem;
    qryMainAddressValidated: TWideStringField;
    btnValidate: TDNMSpeedButton;
    qryMainPhone: TWideStringField;
    qryMainCustomer_ID: TIntegerField;
    qryMainLocationCode: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure mnuValidateAddressClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
  private
    { Private declarations }
    bDoNotReturnToOwner: boolean;
    fiCustomerID: Integer;
    fsShipAddressIdsAlreadySelected:String;
    ShipAddressIdsAlreadySelectedList :TIntegerList;
    function getClientID: integer;
    function getClientName: string;
    procedure setShipAddressIdsAlreadySelected(const Value: String);
    procedure ValidateSelection(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure ValidateSelectedAddress(ErrorList: TStringList = nil);
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }

    CallerEdit: TEdit;      // this is to be set to a valid instance
    // by the caller
    // Doubleclick will set it's text property
    // to the selected ship address text
    // and clear the reference
    CallerEditID: TEdit;    // As Above ... to return ship-address-ID
    Property CustomerID :Integer read fiCustomerID write fiCustomerID;
    Procedure RefreshQuery; override;
    Property ShipAddressIdsAlreadySelected :String read fsShipAddressIdsAlreadySelected write setShipAddressIdsAlreadySelected;

  end;

implementation

{$R *.dfm}

uses
  ShipAddressForm, CommonDbLib, CommonLib, Forms, FastFuncs,
  ShipIntegrationUtils, JsonObject, frmShipAddressValidateSelect,
  BusObjShippingAddress, ShipAddressValidationObj, AppEnvironment,
  ibxezaddress, MemoDialog, tcConst;

procedure TShipAddressListGUI.btnValidateClick(Sender: TObject);
var
  sl: TStringList;
  x: integer;

begin
//  ValidateSelectedAddress;
  if grdMain.SelectedList.Count > 0 then begin
    sl := TStringList.Create;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
        ValidateSelectedAddress(sl);
      end;

      if sl.Count > 0 then begin
        DoMemoDialog('Address Validation Errors',sl.Text,ssBoth);
      end;
      self.RefreshQuery;

    finally
      sl.Free;
    end;
  end
  else
    ValidateSelectedAddress;
end;

procedure TShipAddressListGUI.ValidateSelectedAddress(ErrorList: TStringList = nil);
var
//  list: TJsonObject;
  add: TShippingAddress;
  con : TERPConnection;
  val: TShipAddressValidation;
  s: string;
  ShippingProviders: ShippingProviderSet;

  procedure RefreshAndLocate;
  var id: integer;
  begin
    if not qryMain.Active or (qryMain.RecordCount = 0) then exit;
    id := qryMainShipAddressId.AsInteger;
    qryMain.Refresh;
    qryMain.Locate('ShipAddressId',id,[]);
  end;

begin
  if (not qryMain.Active) or (qryMain.RecordCount = 0) then exit;
  ShippingProviders := [];
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
    if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
      val.Providers := ShippingProviders; //TibxezaddressProviders(pUPS);
    val.Address.AddressLine1 := qryMainAddress.AsString;
    val.Address.AddressLine2 := qryMainAddress2.AsString;
    val.Address.AddressLine3 := qryMainAddress3.AsString;
    val.Address.City := qryMainCity.AsString;
    val.Address.State := qryMainState.AsString;
    val.Address.PostCode := qryMainPostCode.AsString;
    val.Address.Country := qryMainCountry.AsString;
    val.Address.Updated := false;
    if Length(qryMainPhone.AsString) < 10 then
      val.ErrMessage := 'Phone Number must be at least 10 alphanumeric characters long.';

    if (val.ErrMessage = '') and val.ValidateAddress then begin
      { only update if somthing changed }
      if val.Address.Updated or (not qryMainAddressValidated.AsBoolean) then begin
        { update the address }
        con := CommonDbLib.GetNewMyDacConnection(nil);
        try
          add := TShippingAddress.Create(nil,con);
          try
            add.Load(self.qryMainShipAddressId.AsInteger);
            add.Connection.BeginTransaction;
            add.ShipAddress := val.Address.AddressLine1;
            add.ShipAddress1 := val.Address.AddressLine2;
            add.ShipAddress2 := val.Address.AddressLine3;
            add.ShipCity := val.Address.City;
            add.ShipState := val.Address.State;
            add.ShipPostCode := val.Address.PostCode;
            add.ShipCountry := val.Address.Country;

            add.AddressValidated := true;
            if add.Save then
              add.Connection.CommitTransaction
            else
              add.Connection.RollbackTransaction;
          finally
            add.Free;
          end;
        finally
          Freeandnil(con);
        end;
        if not Assigned(ErrorList) then
          RefreshAndLocate;
      end;
      if not Assigned(ErrorList) then
        CommonLib.MessageDlgXP_Vista('Address is valid.', mtInformation, [mbOk], 0);
    end
    else if val.ErrMessage <> '' then begin
      if not Assigned(ErrorList) then
        CommonLib.MessageDlgXP_Vista(val.ErrMessage,mtWarning,[mbOk],0)
      else begin
        if ErrorList.Count > 0 then ErrorList.Add('');
        s:= qryMainAddress.AsString;
        if qryMainAddress2.AsString <> '' then
          s:= s + ' ' + qryMainAddress2.AsString;
        if qryMainAddress3.AsString <> '' then
          s:= s + ' ' + qryMainAddress3.AsString;
        s := s + ' ' + qryMainCity.AsString;
        s := s + ' ' + qryMainState.AsString;
        s := s + ' ' + qryMainPostCode.AsString;
        s:= s + ' ' + qryMainCountry.AsString;
        ErrorList.Add(s);
        ErrorList.Add(val.ErrMessage);
      end;
    end;
  finally
    val.Free;
  end;
end;

procedure TShipAddressListGUI.cmdNewClick(Sender: TObject);
var
  form: TShipAddressGUI;
begin
  inherited;
  form := TShipAddressGUI(GetComponentByClassName('TShipAddressGUI'));
  if not Assigned(form) then Exit;
  form.AttachObserver(Self);
  form.ClientID   := GetClientID;
  form.ClientName := GetClientName;
  if fsmodal in formstate then begin
    form.showmodal;
    RefreshQuery;
  end else begin
    form.FormStyle  := fsMDIChild;
    form.BringToFront;
  end;
end;

function TShipAddressListGUI.GetClientID: integer;
  // assumes that the client ID is embedded in th4e filterstring for the main qry
  // returns -1 if error
var
  iIndex, i: integer;
  iCode: integer;
  sClientID: string;
begin
  Result := -1;
  if CustomerID > 0 then begin
    result := CustomerID;
    exit;
  end;
  sClientID := '';
  iIndex := LastDelimiter(' ', FilterString);
  if iIndex <> 0 then begin
    for i := iIndex + 1 to char_length(FilterString) do begin
      sClientID := sClientID + FilterString[i];
    end;
    Val(sClientID, Result, iCode);
  end;
  if (iCode <> 0) or (iIndex = 0) then begin
    Result := -1;
  end
end;



procedure TShipAddressListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
   if qryMainShipAddressIdAlreadySelected.AsBoolean then AFont.color := clred;
end;

procedure TShipAddressListGUI.grdMainDblClick(Sender: TObject);
var
  sText: string;
begin
  if Assigned(CallerEdit) and not bDoNotReturnToOwner then begin
    if qryMainContactName.AsString <> '' then
      sText := qryMainContactName.AsString + #13
    else
      sText := '';

    sText := sText + qryMain.FieldByName('Company Name').AsString;

    if not Empty(qryMain.FieldByName('Address').AsString) then sText :=
        sText + #13 + qryMain.FieldByName('Address').AsString;

    if not Empty(qryMain.FieldByName('Address 2').AsString) then sText := sText + #13 + qryMain.FieldByName('Address 2').AsString;

    if not Empty(qryMain.FieldByName('Address 3').AsString) then sText := sText + #13 + qryMain.FieldByName('Address 3').AsString;

    if not Empty(qryMain.FieldByName('City').AsString) then sText := sText + #13 + qryMain.FieldByName('City').AsString;

    if not Empty(qryMain.FieldByName('State').AsString) then sText := sText + ' ' + qryMain.FieldByName('State').AsString;

    sText := sText + ' ' + qryMain.FieldByName('PostCode').AsString;

    if not Empty(qryMain.FieldByName('Country').AsString) then sText :=
        sText + #13 + qryMain.FieldByName('Country').AsString;

    CallerEdit.Clear;
    CallerEdit.Text := sText;
    CallerEdit      := nil;

    if Assigned(CallerEditID) then begin
      CallerEditID.Text := qryMain.FieldByName('ShipAddressID').AsString;
      CallerEditID := nil;
    end;


    Close;
  end else begin
    if qryMainCustomerPhysicalAddress.AsBoolean then begin
      self.SubsequentID := '_Client';
      if not Assigned(fOnGridDataSelect) then begin
        MessageDlgXP_Vista('This is the physical address of' + NL+
          quotedstr(qryMainCompanyName.asString) +'.'+NL+'Please change it in the customer card', mtInformation, [mbOK], 0);
      end;
    end else
      self.SubsequentID := '_ShippingAddress';

    inherited;
    (* if FormStillOpen('TShipAddressGUI') then begin
      with TShipAddressGUI(FindExistingComponent('TShipAddressGUI')) do begin
        TShipAddressGUI(FindExistingComponent('TShipAddressGUI')).ClientID := GetClientID;
        TShipAddressGUI(FindExistingComponent('TShipAddressGUI')).ClientName := GetClientName;
      end;
    end; *)
  end;
end;

procedure TShipAddressListGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  ValidateSelection(Grid,Selecting,Accept);
end;

procedure TShipAddressListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  ValidateSelection(Grid,Selecting,Accept);
end;

procedure TShipAddressListGUI.ValidateSelection(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  if QrymainShipAddressIdAlreadySelected.AsBoolean and selecting then begin
    accept := False;
    TimerMsg(lblDateComments , qryMainCompanyName.AsString +' is already selected');
  end else begin
    lblDateComments.Visible := False;
  end;
end;

procedure TShipAddressListGUI.btnEditClick(Sender: TObject);
begin
  // act like we have dblclicked (but do not invoke back-to-owner functionality)
  bDoNotReturnToOwner := true;
  grdMainDblClick(Sender);
  bDoNotReturnToOwner := false;
end;

procedure TShipAddressListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbAllowdrilldownwhenModal := True;
  ShipAddressIdsAlreadySelectedList := TIntegerList.Create;
  bDoNotReturnToOwner := false;
  fiCustomerID :=0;
  ShipAddressIdsAlreadySelected:= '';
end;

procedure TShipAddressListGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(ShipAddressIdsAlreadySelectedList);
  inherited;

end;

function TShipAddressListGUI.getClientName: string;
var
  qryClients: TERPQuery;
begin
  Result := '';
  qryClients := TERPQuery.Create(nil);
  qryClients.Options.FlatBuffers := True;
  qryClients.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qryClients do begin
      SQL.Clear;
      SQL.Add('SELECT Company FROM tblClients ' +
        'WHERE ClientID = :xClientID;');
      Params.ParamByName('xClientID').AsInteger := GetClientID;
      Open;
      if not IsEmpty then begin
        Result := qryClients.FieldByName('Company').AsString;
      end;
    end;
  finally
    FreeandNil(qryClients);
  end;
end;

procedure TShipAddressListGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(Sender);
  if Assigned(fOnGridDataSelect) then begin
    btnEdit.Enabled := false;
    btnValidate.Enabled := false;
    mnuValidateAddress.Enabled := false;
  end;
end;

procedure TShipAddressListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TShipAddressListGUI.mnuValidateAddressClick(Sender: TObject);
begin
  inherited;
  ValidateSelectedAddress;
end;

procedure TShipAddressListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainShipAddressIdAlreadySelected.AsBoolean :=  ShipAddressIdsAlreadySelectedList.InList(qryMainShipAddressId.AsInteger);
end;

procedure TShipAddressListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('CustomerID').asInteger := fiCustomerID;
  inherited;

end;


procedure TShipAddressListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ShipAddressID');
  RemoveFieldfromGrid(QrymainShipAddressIdAlreadySelected.FieldName);
  RemoveFieldfromGrid(qryMainCustomerPhysicalAddress.FieldName);
end;

procedure TShipAddressListGUI.setShipAddressIdsAlreadySelected(const Value: String);
begin
  fsShipAddressIdsAlreadySelected := Value;
  ShipAddressIdsAlreadySelectedList.CommaText := Value;
end;

initialization
  RegisterClassOnce(TShipAddressListGUI);
end.
