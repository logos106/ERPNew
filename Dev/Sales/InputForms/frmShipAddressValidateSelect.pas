unit frmShipAddressValidateSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, Grids, AdvObj, BaseGrid, AdvGrid,
  DNMSpeedButton, Shader, DNMPanel, JsonObject, BusObjShippingAddress,
  ShipIntegrationTypes, SelectionDialog, Menus;

type
  TfmShipAddressValidateSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grdMain: TAdvStringGrid;
    lblInstructions: TLabel;
    lblAddress: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    fSelectedIndex: integer;
    Fdata: TJsonObject;
    FUpdateFromSelected: boolean;
    FShippingAddressId: integer;
    FShippingAddress: TShippingAddress;
    fAddress: TAddress;
    procedure Setdata(const Value: TJsonObject);
    procedure SelectAndClose;
    procedure SetUpdateFromSelected(const Value: boolean);
    procedure SetShippingAddressId(const Value: integer);
    procedure SetShippingAddress(const Value: TShippingAddress);
    procedure SetAddress(const Value: TAddress);
    { Private declarations }
  public
    { Public declarations }
    class function SelectCorrectShipAddress(
      ShipAddressId: integer; list: TJsonObject;
      UpdateAddress: boolean = true;
      ShippingAddress: TShippingAddress  = nil): boolean;
    class function SelectCorrectAddress(
      Address: TAddress; json: TJsonObject): boolean;
    property SelectedIndex: integer read fSelectedIndex;
    property data: TJsonObject read Fdata write Setdata;
    property UpdateFromSelected: boolean read FUpdateFromSelected write SetUpdateFromSelected;
    property ShippingAddressId: integer read FShippingAddressId write SetShippingAddressId;
    property ShippingAddress: TShippingAddress read FShippingAddress write SetShippingAddress;
    property Address: TAddress read fAddress write SetAddress;
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib;

{ TfmShipAddressValidateSelect }

procedure TfmShipAddressValidateSelect.btnSaveClick(Sender: TObject);
begin
  inherited;
  SelectAndClose;
end;

procedure TfmShipAddressValidateSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmShipAddressValidateSelect.FormCreate(Sender: TObject);
begin
  inherited;
  fSelectedIndex := -1;
  lblAddress.Visible := false;
end;

procedure TfmShipAddressValidateSelect.grdMainDblClick(Sender: TObject);
begin
  inherited;
  SelectAndClose;
end;

procedure TfmShipAddressValidateSelect.SelectAndClose;
var
  add: TShippingAddress;
begin
  add:= nil;
  if grdMain.Row < 1 then exit;
  if Assigned(Address) then begin
    if (grdMain.Cells[1,grdMain.Row] <> '') and (not Sametext(Address.AddressLine1, grdMain.Cells[1,grdMain.Row])) then begin
      Address.AddressLine1 := grdMain.Cells[1,grdMain.Row];
      Address.AddressLine3 := '';
      Address.Updated := true;
    end;
    if (grdMain.Cells[2,grdMain.Row] <> '') and (not Sametext(Address.AddressLine2, grdMain.Cells[2,grdMain.Row])) then begin
      Address.AddressLine2 := grdMain.Cells[2,grdMain.Row];
      Address.AddressLine3 := '';
      Address.Updated := true;
    end;
    if (grdMain.Cells[3,grdMain.Row] <> '') and (not Sametext(Address.City, grdMain.Cells[3,grdMain.Row])) then begin
      Address.City := grdMain.Cells[3,grdMain.Row];
      Address.Updated := true;
    end;
    if (grdMain.Cells[4,grdMain.Row] <> '') and (not Sametext(Address.State, grdMain.Cells[4,grdMain.Row])) then begin
      Address.State := grdMain.Cells[4,grdMain.Row];
      Address.Updated := true;
    end;
    if (grdMain.Cells[5,grdMain.Row] <> '') and (not Sametext(Address.PostCode, grdMain.Cells[5,grdMain.Row])) then begin
      Address.PostCode := grdMain.Cells[5,grdMain.Row];
      Address.Updated := true;
    end;
    if (grdMain.Cells[6,grdMain.Row] <> '') and (not Sametext(Address.CountryCode, grdMain.Cells[6,grdMain.Row])) then begin
      Address.CountryCode := grdMain.Cells[6,grdMain.Row];
      Address.Updated := true;
    end;
  end
  else if UpdateFromSelected then begin
    if Assigned(ShippingAddress) then
      add := ShippingAddress
    else
      add := TShippingAddress.Create(nil,CommonDbLib.GetNewMyDacConnection(add));
    try
      if not Assigned(ShippingAddress) then
        add.Load(ShippingAddressId);
      if Assigned(ShippingAddress) then
        add.Connection.BeginNestedTransaction
      else
        add.Connection.BeginTransaction;
      try
        if (grdMain.Cells[1,grdMain.Row] <> '') and (not Sametext(add.ShipAddress, grdMain.Cells[1,grdMain.Row])) then begin
          add.ShipAddress := grdMain.Cells[1,grdMain.Row];
          add.ShipAddress2 := '';
        end;
        if (grdMain.Cells[2,grdMain.Row] <> '') and (not Sametext(add.ShipAddress1, grdMain.Cells[2,grdMain.Row])) then begin
          add.ShipAddress2 := grdMain.Cells[2,grdMain.Row];
          add.ShipAddress2 := '';
        end;
        if (grdMain.Cells[3,grdMain.Row] <> '') and (not Sametext(add.ShipCity, grdMain.Cells[3,grdMain.Row])) then
          add.ShipCity := grdMain.Cells[3,grdMain.Row];
        if (grdMain.Cells[4,grdMain.Row] <> '') and (not Sametext(add.ShipState, grdMain.Cells[4,grdMain.Row])) then
          add.ShipState := grdMain.Cells[4,grdMain.Row];
        if (grdMain.Cells[5,grdMain.Row] <> '') and (not Sametext(add.ShipPostCode, grdMain.Cells[5,grdMain.Row])) then
          add.ShipPostCode := grdMain.Cells[5,grdMain.Row];
        if (grdMain.Cells[6,grdMain.Row] <> '') and (not Sametext(add.ShipCountry, grdMain.Cells[6,grdMain.Row])) then
          add.ShipCountry := grdMain.Cells[6,grdMain.Row];
        if not add.Save then begin
          if Assigned(ShippingAddress) then
            add.Connection.RollbackNestedTransaction
          else
            add.Connection.RollbackTransaction;
          exit;
        end;
        if Assigned(ShippingAddress) then
          add.Connection.CommitNestedTransaction
        else
          add.Connection.CommitTransaction;
      except
        if Assigned(ShippingAddress) then
          add.Connection.RollbackNestedTransaction
        else
          add.Connection.RollbackTransaction;
        raise;
      end;
    finally
      if not Assigned(ShippingAddress) then
        add.Free;
    end;
  end;

  ModalResult := mrOk;
end;

class function TfmShipAddressValidateSelect.SelectCorrectAddress(
  Address: TAddress; json: TJsonObject): boolean;
var
  inst: TfmShipAddressValidateSelect;
begin
  inst := TfmShipAddressValidateSelect.Create(nil);
  try
    inst.data := json;
    inst.Address := Address;
    result := inst.ShowModal = mrOk;
  finally
    inst.Release;
  end;
end;

class function TfmShipAddressValidateSelect.SelectCorrectShipAddress(
  ShipAddressId: integer; list: TJsonObject;
  UpdateAddress: boolean = true;
  ShippingAddress: TShippingAddress  = nil): boolean;
var
  inst: TfmShipAddressValidateSelect;
begin
  inst := TfmShipAddressValidateSelect.Create(nil);
  try
    inst.data := list;
    inst.UpdateFromSelected := UpdateAddress;
    inst.ShippingAddressId := ShipAddressId;
    inst.ShippingAddress := ShippingAddress;
    result := inst.ShowModal = mrOk;
  finally
    inst.Release;
  end;
end;

procedure TfmShipAddressValidateSelect.SetAddress(const Value: TAddress);
begin
  fAddress := Value;
  lblAddress.Caption := 'Checking Address:  ' + Address.AddressLine1;
  if Address.AddressLine2 <> '' then
    lblAddress.Caption := lblAddress.Caption + ' ' + Address.AddressLine2;
  if Address.AddressLine3 <> '' then
    lblAddress.Caption := lblAddress.Caption + ' ' + Address.AddressLine3;
  lblAddress.Caption := lblAddress.Caption + ' ' + Address.City;
  lblAddress.Caption := lblAddress.Caption + ' ' + Address.State;
  lblAddress.Caption := lblAddress.Caption + ' ' + Address.PostCode;
  lblAddress.Caption := lblAddress.Caption + ' ' + Address.CountryCode;

  lblAddress.Visible := true;
  grdMain.Top := lblAddress.Top + lblAddress.Height + 5;
  grdMain.Height := btnSave.Top - 5 - grdMain.Top;
end;

procedure TfmShipAddressValidateSelect.Setdata(const Value: TJsonObject);
var
  x: integer;
begin
  Fdata := Value;
  grdMain.RowCount := data.A['list'].Count + 1;
  for x := 0 to data.A['list'].Count -1 do begin
    grdMain.Cells[0,x+1]:= data.A['list'].Items[x].AsObject.S[Match_Company];
    grdMain.Cells[1,x+1]:= data.A['list'].Items[x].AsObject.S[Match_Address1];
    grdMain.Cells[2,x+1]:= data.A['list'].Items[x].AsObject.S[Match_Address2];
    grdMain.Cells[3,x+1]:= data.A['list'].Items[x].AsObject.S[Match_City];
    grdMain.Cells[4,x+1]:= data.A['list'].Items[x].AsObject.S[Match_State];
    grdMain.Cells[5,x+1]:= data.A['list'].Items[x].AsObject.S[Match_PostCode];
    grdMain.Cells[6,x+1]:= data.A['list'].Items[x].AsObject.S[Match_CountryCode];
    if SameText(data.A['list'].Items[x].AsObject.S[Match_ResidentialStatus],'BUSINESS') then
      grdMain.Cells[7,x+1]:= 'Business'
    else if SameText(data.A['list'].Items[x].AsObject.S[Match_ResidentialStatus],'RESIDENTIAL') then
      grdMain.Cells[7,x+1]:= 'Residential';

  end;
end;

procedure TfmShipAddressValidateSelect.SetShippingAddress(
  const Value: TShippingAddress);
begin
  FShippingAddress := Value;
end;

procedure TfmShipAddressValidateSelect.SetShippingAddressId(
  const Value: integer);
begin
  FShippingAddressId := Value;
end;

procedure TfmShipAddressValidateSelect.SetUpdateFromSelected(
  const Value: boolean);
begin
  FUpdateFromSelected := Value;
end;

end.
