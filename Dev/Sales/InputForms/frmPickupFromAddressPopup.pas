unit frmPickupFromAddressPopup;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/01/06  1.00.01 IJB  Changed cmdOkClick to use CallingForm property.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, wwdblook, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, DB,
  MyAccess,ERPdbComponents, BaseTransForm, MemDS, DBAccess, Shader, AppEvnts,
  BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, ImgList,
  ProgressDialog;

type
  // These are the possible calling form types.
  TFormType = (ftInvoice, ftSalesOrder, ftPurchaseOrder);

type
  TPickFromPopupGUI = class(TBaseInputGUI)
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TAutoIncField;
    cboClientLookupStreet: TWideStringField;
    cboClientLookupStreet2: TWideStringField;
    cboClientLookupSuburb: TWideStringField;
    cboClientLookupState: TWideStringField;
    cboClientLookupCountry: TWideStringField;
    cboClientLookupPostcode: TWideStringField;
    cboClientLookupBillStreet: TWideStringField;
    cboClientLookupBillStreet2: TWideStringField;
    cboClientLookupBillSuburb: TWideStringField;
    cboClientLookupBillState: TWideStringField;
    cboClientLookupBillPostcode: TWideStringField;
    cboClientLookupTERMS: TWideStringField;
    cboClientLookupTermsID: TIntegerField;
    cboClientLookupShippingMethod: TWideStringField;
    cboClientLookupShippingID: TIntegerField;
    cboClientLookupRepID: TIntegerField;
    cboClientLookupTaxID: TIntegerField;
    DSClientLookup: TDataSource;
    Bevel1: TBevel;
    Label38: TLabel;
    Label27: TLabel;
    cboClient: TwwDBLookupCombo;
    txtClientDetails: TDBMemo;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
  private
    { Private declarations }
    frmCalling: TBaseTransGUI;
    frmType: TFormType;
    fsClientDetails: string;
    function SetPhysicalAddress: string;
  public
    { Public declarations }
    //class function Instance: TPickFromPopupGUI;
    property CallingFormType: TFormType read frmType write frmType;
    property CallingForm: TBaseTransGUI read frmCalling write frmCalling;
    property ClientDetails: string read fsClientDetails write fsClientDetails;
  end;

implementation

uses
  frmInvoice, frmSalesOrder, CommonDbLib, CommonLib, frmPurchaseOrders;

{$R *.dfm}

procedure TPickFromPopupGUI.cmdOkClick(Sender: TObject);
begin
  case CallingFormType of
    ftInvoice:
      begin
        TInvoiceGUI(self.CallingForm).Invoice.PickupFromDesc:= txtClientDetails.Text;
        TInvoiceGUI(self.CallingForm).Invoice.PickUpfromID := cboClient.lookuptable.fieldbyname('clientID').asInteger;
      end;
    ftSalesOrder:
      begin
        TSalesOrderGUI(self.CallingForm).SalesOrder.PickupFromDesc:= txtClientDetails.Text;
        TSalesOrderGUI(self.CallingForm).SalesOrder.PickUpfromID := cboClient.lookuptable.fieldbyname('clientID').asInteger;
      end;
    ftPurchaseorder:
      begin
        TPurchaseGUI(self.CallingForm).PO.PickupFromDesc:= txtClientDetails.Text;
        TPurchaseGUI(self.CallingForm).PO.PickUpfromID := cboClient.lookuptable.fieldbyname('clientID').asInteger;
      end;
  end;
  Close;
end;

procedure TPickFromPopupGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    cboClientLookup.Open;
    txtClientDetails.Text := fsClientDetails;
  finally
    EnableForm;
  end;  
end;

procedure TPickFromPopupGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cboClientLookup.Close;
  Action := caFree;
end;

procedure TPickFromPopupGUI.FormCreate(Sender: TObject);
begin
  inherited;
  cboClientLookup.Connection := CommonDbLib.GetSharedMyDacConnection;

end;

procedure TPickFromPopupGUI.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TPickFromPopupGUI.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  i: integer;
begin
  if not Modified then Exit;
  if not LookupTable.Locate('Company', cboClient.Text, [loCaseInsensitive]) then begin
    cboClient.Text := '';
    Exit;
  end;

  txtClientDetails.Text := cboClient.Text + Chr(13) + Chr(10) + SetPhysicalAddress;

  //Check the address field doesn't have empty lines
  if txtClientDetails.Lines.Count > 0 then begin
    i := 0;
    while i < txtClientDetails.Lines.Count do begin
      if txtClientDetails.Lines[i] = '' then begin
        txtClientDetails.Lines.Delete(i);
        i := i - 1;
      end;
      i := i + 1;
    end;
  end;
end;

function TPickFromPopupGUI.SetPhysicalAddress: string;
begin
  Result := cboClientLookup.FieldByName('Street').AsString + Chr(13) + Chr(10) +
    cboClientLookup.FieldByName('Street2').AsString + Chr(13) + Chr(10) + cboClientLookup.FieldByName('Suburb').AsString +
    ' ' + cboClientLookup.FieldByName('State').AsString + ' ' + cboClientLookup.FieldByName('PostCode').AsString;
end;

Initialization
  RegisterClassOnce(TPickFromPopupGUI);

end.
