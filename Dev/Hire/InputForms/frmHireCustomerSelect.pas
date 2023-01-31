unit frmHireCustomerSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, DNMSpeedButton, Shader, DNMPanel,
  wwdblook, ERPDbLookupCombo, kbmMemTable , BaseInputForm;

type
  TfmHireCustomerSelect = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryClientLookup: TERPQuery;
    qryClientLookupCompany: TWideStringField;
    qryClientLookupClientId: TIntegerField;
    qryClientLookupDefaultPostAccount: TWideStringField;
    qryClientLookupDefaultPostAccountID: TIntegerField;
    qryClientLookupStreet: TWideStringField;
    qryClientLookupStreet2: TWideStringField;
    qryClientLookupStreet3: TWideStringField;
    qryClientLookupSuburb: TWideStringField;
    qryClientLookupState: TWideStringField;
    qryClientLookupCountry: TWideStringField;
    qryClientLookupPostcode: TWideStringField;
    qryClientLookupBillStreet: TWideStringField;
    qryClientLookupBillStreet2: TWideStringField;
    qryClientLookupBillStreet3: TWideStringField;
    qryClientLookupBillSuburb: TWideStringField;
    qryClientLookupBillState: TWideStringField;
    qryClientLookupBillPostcode: TWideStringField;
    qryClientLookupBillCountry: TWideStringField;
    qryClientLookupTERMS: TWideStringField;
    qryClientLookupTermsID: TIntegerField;
    qryClientLookupShippingMethod: TWideStringField;
    qryClientLookupShippingID: TIntegerField;
    qryClientLookupRepID: TIntegerField;
    qryClientLookupTaxID: TIntegerField;
    qryClientLookupPhone: TWideStringField;
    qryClientLookupFax: TWideStringField;
    qryClientLookupAltPhone: TWideStringField;
    qryClientLookupStopCredits: TWideStringField;
    qryClientLookupForcePOOnInvoice: TWideStringField;
    qryClientLookupUseInvBase: TWideStringField;
    qryClientLookupInvBaseNumber: TIntegerField;
    qryClientLookupWarrantyFinishDate: TDateTimeField;
    qryClientLookupIsJob: TWideStringField;
    cboClientR: TERPDbLookupCombo;
    Label38: TLabel;
    mtClient: TkbmMemTable;
    dtClient: TDataSource;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetHireCustomerId(var ClientName: string): integer;

implementation

uses
  Vista_MessageDlg, CommonDbLib;

{$R *.dfm}

function GetHireCustomerId(var ClientName: string): integer;
var
  form: TfmHireCustomerSelect;
begin
  result := 0;
  form := TfmHireCustomerSelect.Create(nil);
  try
    if form.ShowModal = mrOk then begin
      if form.cboClientR.Text <> '' then begin
        result := form.qryClientLookupClientId.AsInteger;
        ClientName := form.cboClientR.Text;
      end;
    end;
  finally
    form.Release;
  end;
end;

procedure TfmHireCustomerSelect.btnSaveClick(Sender: TObject);
begin
  inherited;
  if cboClientR.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please select a Customer for this Hire',mtInformation,[mbOk],0);
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfmHireCustomerSelect.FormCreate(Sender: TObject);
begin
  inherited;
  mtClient.Close;
  mtClient.FieldDefs.Clear;
  with mtClient.FieldDefs.AddFieldDef do begin
    Name     := 'ClientId';
    DataType := ftLargeint;
  end;
  with mtClient.FieldDefs.AddFieldDef do begin
    Name     := 'ClientName';
    DataType := ftString;
    Size     := 255;
  end;
  with mtClient.FieldDefs.AddFieldDef do begin
    Name     := 'ClientPrintName';
    DataType := ftString;
    Size     := 255;
  end;
  mtClient.CreateTable;
  mtClient.Open;


end;

procedure TfmHireCustomerSelect.FormShow(Sender: TObject);
begin
  inherited;
  qryClientLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(0,  cboClientR,False, True, False , true , True , 'ClientPrintName' , nil, true);
  qryClientLookup.Open;
end;

end.
