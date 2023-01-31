unit RAPsales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess, StdCtrls, wwdblook,
  ExtCtrls, DNMPanel, wwcheckbox, DBCtrls, Mask, wwdbedit,
  wwclearbuttongroup, wwradiogroup, BusObjSales, DNMSpeedButton,
  BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TRapSalesGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    cboClient: TwwDBLookupCombo;
    cboClientLookup: TMyQuery;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TStringField;
    Label80: TLabel;
    rdoGender: TwwRadioGroup;
    Bevel19: TBevel;
    Label73: TLabel;
    edtPhonenumber: TwwDBEdit;
    Label2: TLabel;
    edtPostCode: TwwDBEdit;
    txtClientDetails: TDBMemo;
    Label3: TLabel;
    chkSubmitted: TwwCheckBox;
    cboClientLookupGender: TStringField;
    cboClientLookupPhone: TStringField;
    cboClientLookupPOPostcode: TStringField;
    cboClientLookupFirstName: TStringField;
    cboClientLookupMiddleName: TStringField;
    cboClientLookupLastName: TStringField;
    cboClientLookupDVANumber: TStringField;
    Label4: TLabel;
    edtDVAFilenumber: TwwDBEdit;
    Label6: TLabel;
    cboDVADeliveryCode: TwwDBLookupCombo;
    btnCompleted: TDNMSpeedButton;
    qryDVADeliveryCodes: TMyQuery;
    qryDVADeliveryCodesDeliveryCode: TStringField;
    qryDVADeliveryCodesDescription: TStringField;
    qryDVADeliveryCodesDeliveryCodeID: TIntegerField;
    qryDVADeliveryCodesActive: TStringField;
    Label7: TLabel;
    edtVeteranPostcode: TwwDBEdit;
    edtPriorApprovalRefNo: TwwDBEdit;
    lblPriorApprovalRefNo: TLabel;
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fDatasource :TDatasource;
    fsaleObj    :TSales;

    Procedure Setdatasource(const Value :TDataSource);
  public
    Property Datasource : TDatasource Write Setdatasource;
    Property SaleObj    : TSales read fsaleObj Write    fsaleObj;
  end;


implementation

uses CommonDbLib, BusobjSaleBase, CommonLib;

{$R *.dfm}

Procedure TRapSalesGUI.Setdatasource(const Value :TDataSource);
var
    ctr :Integer;
begin
    fDatasource                     := Value;
    for ctr := 0 to ComponentCount-1 do
        if Components[ctr] is TwwDBLookupCombo then
            TwwDBLookupCombo(Components[ctr]).Datasource := Value
        else if Components[ctr] is TwwDBEdit then
            TwwDBEdit(Components[ctr]).Datasource := Value
        else if Components[ctr] is TDBMemo then
            TDBMemo(Components[ctr]).Datasource := Value
        else if Components[ctr] is TwwRadioGroup then
            TwwRadioGroup(Components[ctr]).Datasource := Value
        else if Components[ctr] is TwwRadioGroup then
            TwwRadioGroup(Components[ctr]).Datasource := Value;
    (*cboClient.datasource            := Value;
    edtDVAFilenumber.datasource     := Value;
    txtClientDetails.datasource     := Value;
    rdoGender.datasource            := Value;
    edtPhonenumber.datasource       := Value;
    edtPostCode.datasource          := Value;
    cboDVADeliveryCode.datasource   := Value;
    chkSubmitted.datasource         := Value;*)
end;
procedure TRapSalesGUI.btnCompletedClick(Sender: TObject);
begin
    inherited;
    Self.Close;
end;
procedure TRapSalesGUI.FormShow(Sender: TObject);
begin
  inherited;
  cboClientLookup.connection    := CommonDbLib.GetSharedMyDACConnection;
  qryDVADeliveryCodes.connection:= CommonDbLib.GetSharedMyDACConnection;
  if not cboClientLookup.Active       then cboClientLookup.Open;
  if not qryDVADeliveryCodes.Active   then qryDVADeliveryCodes.Open;
  if Assigned(SaleObj) then begin
    edtPriorApprovalRefNo.Enabled := SaleObj.PriorApprovalRequired;
    lblPriorApprovalRefNo.Enabled := SaleObj.PriorApprovalRequired;
  end;
end;

initialization
  RegisterClassOnce(TRapSalesGUI);

end.
