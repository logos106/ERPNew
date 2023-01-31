unit frmPCCImportConfigure;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  ComCtrls, MemDS, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, wwdblook, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, Shader;

type
  TPCCImportConfigure = class(TBaseInputGUI)
    PageControl: TPageControl;
    Common: TTabSheet;
    StarCard: TTabSheet;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    grdMaster: TwwDBGrid;
    grdDetail: TwwDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    qryMaster: TMyQuery;
    dsMaster: TDataSource;
    qryDetail: TMyQuery;
    dsDetail: TDataSource;
    qryProduct: TMyQuery;
    cboProduct: TwwDBLookupCombo;
    qryProductPartsID: TIntegerField;
    qryProductProductCode: TStringField;
    qryProductPartName: TStringField;
    qryMasterProductID: TIntegerField;
    qryMasterActive: TStringField;
    qryMasterGlobalRef: TStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryMasterProductCode: TStringField;
    qryDetailProductCode: TStringField;
    qryDetailDescription: TStringField;
    qryDetailPCCImportedProductCodeID: TIntegerField;
    qryDetailActive: TStringField;
    qryMasterProductName: TStringField;
    Bevel3: TBevel;
    Label3: TLabel;
    cboDepartments: TwwDBLookupCombo;
    qryImportConf: TMyQuery;
    dsImportConf: TDataSource;
    qryDepartments: TMyQuery;
    qryDepartmentsClassName: TStringField;
    qryDepartmentsClassID: TIntegerField;
    qryImportConfDepartmentID: TIntegerField;
    Bevel4: TBevel;
    grdMatch: TwwDBGrid;
    qryMatchImportFields: TMyQuery;
    dsMatch: TDataSource;
    qryMatchImportFieldsFieldNameSource: TStringField;
    qryMatchImportFieldsFieldNameTarget: TStringField;
    cboImportFieldNames: TwwDBComboBox;
    cboTargetCustomFieldNames: TwwDBComboBox;
    Bevel5: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qryCustomFields: TMyQuery;
    qryImportConfCustomerCustFieldNo: TWordField;
    qryImportConfCustFieldEqualTo: TStringField;
    qryCustomFieldsLabel: TStringField;
    qryCustomFieldsFieldNo: TLargeintField;
    edtEqualTo: TwwDBEdit;
    POS: TTabSheet;
    DNMPanel3: TDNMPanel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    qryPOSMaster: TMyQuery;
    dsPOSMaster: TDataSource;
    qryPOSDetail: TMyQuery;
    dsPOSDetail: TDataSource;
    qryPOSDetailPCCImpConfImportedDepNoID: TIntegerField;
    qryPOSDetailLocationCode: TWordField;
    qryPOSDetailDescription: TStringField;
    qryPOSDetailActive: TStringField;
    qryPOSMasterPCCImpConfNativeDepID: TIntegerField;
    qryPOSMasterDepID: TIntegerField;
    qryPOSMasterDepName: TStringField;
    qryPOSMasterActive: TStringField;
    qryPOSDepartment: TMyQuery;
    grdPOSMaster: TwwDBGrid;
    Label6: TLabel;
    grdPOSDetail: TwwDBGrid;
    Label7: TLabel;
    cboPOSDepartment: TwwDBLookupCombo;
    qryPOSDepartmentClassID: TIntegerField;
    qryPOSDepartmentClassName: TStringField;
    qryMasterPccProductCodeID: TIntegerField;
    qryDetailPCC_ProductCode: TIntegerField;
    qryPOSDetailInternal_DepID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMasterExit(Sender: TObject);
    procedure qryDetailNewRecord(DataSet: TDataSet);
    procedure grdDetailExit(Sender: TObject);
    procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMatchExit(Sender: TObject);
    procedure qryPOSDetailNewRecord(DataSet: TDataSet);
    procedure grdPOSMasterExit(Sender: TObject);
    procedure grdPOSDetailExit(Sender: TObject);
    procedure cboPOSDepartmentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure edtEqualToExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCImportConfigure: TPCCImportConfigure;

implementation

uses CommonLib;

{$R *.dfm}

procedure TPCCImportConfigure.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCImportConfigure.FormCreate(Sender: TObject);
begin
  inherited;
  cboImportFieldNames.Items.Clear;
  cboImportFieldNames.Items.CommaText :=
  ' RecordType, ParentCustomerNumber, nvoiceCustomerNumber, InvoiceNumber,    '+
  ' CostCentreCode, CardNumber, InvoiceCustomerABNNumber, SystemTraceNumber,  '+
  ' TransactionDate, TransactionTime, LocationCode, LocationName, '+
  ' LocationState, TransactionFee, TransFeeSign, DomesticNumber, '+
  ' RegistrationNumber, OdometerReading, DriverName, TransactionType, '+
  ' ProductCode, ProductVolume, UnitPrice, GrossAmount, GST, NetChargeAmount, '+
  ' PumpPrice, FederalTax, StateTax, FreightCharge ';

  cboTargetCustomFieldNames.Items.Clear;
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField1');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField2');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField3');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField4');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField5');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField6');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField7');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField8');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField9');
  cboTargetCustomFieldNames.Items.Add('SalesLinesCustField10');

end;

procedure TPCCImportConfigure.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TPCCImportConfigure.btnOKClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  Close;
end;

procedure TPCCImportConfigure.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;
  BeginTransaction;
end;

procedure TPCCImportConfigure.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not (qryMaster.State in [dsEdit,dsInsert]) then begin
    qryMaster.Edit;
  end;
  qryMaster.FieldByName('ProductID').AsInteger := qryProduct.FieldByName('PartsID').AsInteger;
  qryMaster.FieldByName('ProductName').AsString := qryProduct.FieldByName('PartName').AsString;
end;

procedure TPCCImportConfigure.grdMasterExit(Sender: TObject);
begin
  inherited;
  if qryMaster.State in [dsEdit,dsInsert] then begin
    qryMaster.Post;
  end;
end;

procedure TPCCImportConfigure.qryDetailNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryDetail.FieldByName('PCC_ProductCode').AsInteger := qryMaster.FieldByName('PccProductCodeID').AsInteger;
end;

procedure TPCCImportConfigure.grdDetailExit(Sender: TObject);
begin
  inherited;
  if qryDetail.State in [dsEdit,dsInsert] then begin
    qryDetail.Post;
  end;
end;

procedure TPCCImportConfigure.cboDepartmentsCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if qryImportConf.State in [dsEdit,dsInsert] then begin
    qryImportConf.Post;
  end;
end;

procedure TPCCImportConfigure.grdMatchExit(Sender: TObject);
begin
  inherited;
  if qryMatchImportFields.State in [dsEdit,dsInsert] then begin
    qryMatchImportFields.Post;
  end;
end;

procedure TPCCImportConfigure.qryPOSDetailNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryPOSDetail.FieldByName('Internal_DepID').AsInteger := qryPOSMaster.FieldByName('PCCImpConfNativeDepID').AsInteger;
end;

procedure TPCCImportConfigure.grdPOSMasterExit(Sender: TObject);
begin
  inherited;
  if qryPOSMaster.State in [dsEdit,dsInsert] then begin
    qryPOSMaster.Post;
  end;
end;

procedure TPCCImportConfigure.grdPOSDetailExit(Sender: TObject);
begin
  inherited;
  if qryPOSDetail.State in [dsEdit,dsInsert] then begin
    qryPOSDetail.Post;
  end;
end;

procedure TPCCImportConfigure.cboPOSDepartmentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not (qryMaster.State in [dsEdit,dsInsert]) then begin
    qryMaster.Edit;
  end;
  qryPOSMaster.FieldByName('DepID').AsInteger := qryPOSDepartment.FieldByName('ClassID').AsInteger;
  qryPOSMaster.FieldByName('DepName').AsString := qryPOSDepartment.FieldByName('ClassName').AsString;
end;

procedure TPCCImportConfigure.edtEqualToExit(Sender: TObject);
begin
  inherited;
  if qryImportConf.State in [dsEdit,dsInsert] then begin
    qryImportConf.Post;
  end;
end;

initialization
  RegisterClassOnce(TPCCImportConfigure);

end.
