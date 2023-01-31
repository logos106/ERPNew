unit frmPayrollCompanyInfoFrm;

interface

uses
  Windows, Forms, SysUtils, BaseInputForm,  DB, Buttons, DNMSpeedButton, StdCtrls, DBCtrls, Controls,
  Mask, Classes, ExtCtrls, Dialogs, jpeg, Grids, Wwdbigrd, Wwdbgrid, Variants,
  ComCtrls, DNMPanel, wwdblook, wwdbedit, dbcgrids, DataState, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, Menus, AdvMenus, Graphics, MemDS;

type
  TfrmPayrollCompanyInfo = class(TBaseInputGUI)
    frmCompanyInformationSrc: TDataSource;
    Info: TLabel;
    CompanyName_Label: TLabel;
    EditedFlag: TDBCheckBox;
    Bevel1: TBevel;
    CompanyInfo: TMyQuery;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    BankBranch: TDBEdit;
    BSB: TDBEdit;
    Account: TDBEdit;
    APCA: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    tblBankCodes: TMyTable;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    qryClients: TMyQuery;
    qrySuper: TMyQuery;
    DataSource5: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel3: TBevel;
    CompanyInfoSetupID: TAutoIncField;
    CompanyInfoCompanyName: TStringField;
    CompanyInfoTradingName: TStringField;
    CompanyInfoAddress: TStringField;
    CompanyInfoAddress2: TStringField;
    CompanyInfoCity: TStringField;
    CompanyInfoState: TStringField;
    CompanyInfoPostcode: TStringField;
    CompanyInfoCountry: TStringField;
    CompanyInfoContactName: TStringField;
    CompanyInfoContactEmail: TStringField;
    CompanyInfoPhoneNumber: TStringField;
    CompanyInfoFaxNumber: TStringField;
    CompanyInfoABN: TStringField;
    CompanyInfoEditedFlag: TStringField;
    CompanyInfoPOBox: TStringField;
    CompanyInfoPOBox2: TStringField;
    CompanyInfoPOCity: TStringField;
    CompanyInfoPOState: TStringField;
    CompanyInfoPOPostcode: TStringField;
    CompanyInfoPOCountry: TStringField;
    CompanyInfoETPPayerType: TStringField;
    CompanyInfoFileReference: TStringField;
    CompanyInfoTaxSignatory: TStringField;
    CompanyInfoLeaveLoadingPercent: TFloatField;
    CompanyInfoCompulsorySuperPercent: TFloatField;
    CompanyInfoBSB: TStringField;
    CompanyInfoAccountNo: TStringField;
    CompanyInfoFontCompanyName: TStringField;
    CompanyInfoFontAddress: TStringField;
    CompanyInfoFontSuburb: TStringField;
    CompanyInfoFontPhone: TStringField;
    CompanyInfoFontABN: TStringField;
    CompanyInfoFontDefault: TStringField;
    CompanyInfoSizeCompanyName: TIntegerField;
    CompanyInfoSizeAddress: TIntegerField;
    CompanyInfoSizeSuburb: TIntegerField;
    CompanyInfoSizePhone: TIntegerField;
    CompanyInfoSizeABN: TIntegerField;
    CompanyInfoSizeDefault: TIntegerField;
    CompanyInfoColorCompanyName: TStringField;
    CompanyInfoColorAddress: TStringField;
    CompanyInfoColorSuburb: TStringField;
    CompanyInfoColorPhone: TStringField;
    CompanyInfoColorABN: TStringField;
    CompanyInfoColorDefault: TStringField;
    CompanyInfoStyleCompanyName: TStringField;
    CompanyInfoStyleAddress: TStringField;
    CompanyInfoStyleSuburb: TStringField;
    CompanyInfoStylePhone: TStringField;
    CompanyInfoStyleABN: TStringField;
    CompanyInfoStyleDefault: TStringField;
    CompanyInfoBankCode: TIntegerField;
    CompanyInfoBankBranch: TStringField;
    CompanyInfoAPCANo: TStringField;
    CompanyInfoWorkersCompInsurer: TIntegerField;
    qryClientsClientID: TAutoIncField;
    qryClientsCompany: TStringField;
    qryClientsStreet: TStringField;
    qryClientsStreet2: TStringField;
    qryClientsSuburb: TStringField;
    qryClientsState: TStringField;
    qryClientsPostcode: TStringField;
    qryClientsPhone: TStringField;
    qryClientsFaxNumber: TStringField;
    cboCompany: TMyQuery;
    DScboCompany: TDataSource;
    txtCompanyName: TwwDBLookupCombo;
    qryCompanyName: TMyQuery;
    wwDBGrid1: TwwDBGrid;
    cboClient: TwwDBLookupCombo;
    btnDelete: TwwIButton;
    wwDBEdit1: TwwDBEdit;
    qrySuperClientID: TIntegerField;
    qrySuperAccountNo: TStringField;
    qryClientsAccountNo: TStringField;
    qryClientsClientNo: TStringField;
    Label14: TLabel;
    qrySuperID: TAutoIncField;
    qrySuperSuperName: TStringField;
    qrySuperGlobalRef: TStringField;
    qryBankAccounts: TMyQuery;
    dsBankAccounts: TDataSource;
    Label15: TLabel;
    btnClear: TDNMSpeedButton;
    cboBankAccounts: TwwDBLookupCombo;
    lblAddress3: TLabel;
    txtAddress3: TDBEdit;
    lblCountry: TLabel;
    txtCountry: TDBEdit;
    qryClientsStreet3: TStringField;
    qryClientsCountry: TStringField;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure FormActivate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure cboBankAccountsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);

  private
    { Private declarations }
    procedure ValidateSuperGlobalRefs;

  public
    { Public declarations }
    
    function VerifySuperannuationEntries: boolean;

  end;

implementation

uses
   DNMExceptions, CommonLib, AppEnvironment;


  {$R *.DFM}


procedure TfrmPayrollCompanyInfo.cmdCloseClick(Sender: TObject);
begin
  if VerifySuperannuationEntries() then begin
    Exit;
  end;

  ValidateSuperGlobalRefs;
   
  if not (qrySuper.State in [dsBrowse]) then begin
    //qrySuper.Edit;
    qrySuper.Post;
  end;

  CompanyInfo.Edit;
  CompanyInfo.Post;
  Self.Close;
end;


procedure TfrmPayrollCompanyInfo.FormShow(Sender: TObject);
begin
  try
    inherited;
    //qryCompanyName.Open;
    CompanyInfo.ParamByName('KeyID').asInteger := 1;
    CompanyInfo.Open;
    CompanyInfo.Edit;
    qryBankAccounts.Open;
    tblBankCodes.Open;
    qryClients.Open;
    qrySuper.Open;
    cboCompany.Open;
    PageControl1.ActivePage := TTabSheet(TabSheet3);
    SetControlFocus(txtCompanyName);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmPayrollCompanyInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CompanyInfo.Close;
  qryCompanyName.Close;
  tblBankCodes.Close;
  qrySuper.Close;
  qryClients.Close;
  cboCompany.Close;
  Action := caFree;
  
end;


procedure TfrmPayrollCompanyInfo.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmPayrollCompanyInfo.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    qrySuper.Delete;
  end;
end;

procedure TfrmPayrollCompanyInfo.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qrySuper.Edit;
  qrySuper.FieldByName('ClientID').AsInteger := qryClients.FieldByName('ClientID').AsInteger;
  qrySuper.FieldByName('AccountNo').AsString := qryClients.FieldByName('ClientNo').AsString;
  wwDBEdit1.Text := VarToStr(qryClients.Lookup('Company', cboClient.Text, 'ClientNo'));
end;

procedure TfrmPayrollCompanyInfo.FormCreate(Sender: TObject);
begin
  inherited;
  tblBankCodes.Connection := MyConnection;
end;

procedure TfrmPayrollCompanyInfo.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  cThisKey := Chr(Key);
  if Shift = [ssCtrl] then begin
    if cThisKey = 'B' then begin
      PageControl1.ActivePage := TabSheet2;
      //        PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'W' then begin
      PageControl1.ActivePage := TabSheet3;
      //        PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'S' then begin
      PageControl1.ActivePage := TabSheet4;
      //        PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

function TfrmPayrollCompanyInfo.VerifySuperannuationEntries: boolean;
begin
  Result := false;
  qrySuper.First;
  while not qrySuper.Eof do begin
    if ((qrySuper.FieldByName('SuperName').AsString = '') or (qrySuper.FieldByName('SuperName').IsNull)) then begin
      CommonLib.MessageDlgXP_Vista('Entries on the Superannuation Page must specify a superannuation company and an account number.',
        mtWarning, [mbOK], 0);
      PageControl1.ActivePage := tabSheet4;
      Result := true;
      Exit;
    end;

    if (qrySuper.FieldByName('AccountNo').AsString = '') or (qrySuper.FieldByName('AccountNo').IsNull) then begin
      CommonLib.MessageDlgXP_Vista('Entries on the Superannuation Page must specify a superannuation company and an account number.',
        mtWarning, [mbOK], 0);
      PageControl1.ActivePage := tabSheet4;
      Result := true;
      Exit;
    end;

    qrySuper.Next;
  end;
end;

procedure TfrmPayrollCompanyInfo.PageControl1Change(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmPayrollCompanyInfo.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  if Pagecontrol1.ActivePage = tabSheet4 then begin
    if VerifySuperannuationEntries then begin
      AllowChange := false;
      Exit;
    end;
  end;
end;

procedure TfrmPayrollCompanyInfo.FormActivate(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabSheet4 then begin
    qrySuper.Close;
    qrySuper.Open;
  end;
end;

procedure TfrmPayrollCompanyInfo.ValidateSuperGlobalRefs;
begin
  qrySuper.First;
  while not qrySuper.Eof do begin
    qrySuper.Edit;
    qrySuper.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qrySuper.FieldByName('ID').AsString;
    qrySuper.Post;
    qrySuper.Next;
  end;
end;

procedure TfrmPayrollCompanyInfo.btnClearClick(Sender: TObject);
begin
  cboBankAccounts.Clear;
  CompanyInfo.FieldByName('BankCode').Clear;
  CompanyInfo.FieldByName('BankBranch').Clear;
  CompanyInfo.FieldByName('BSB').Clear;
  CompanyInfo.FieldByName('AccountNo').Clear;
  CompanyInfo.FieldByName('APCANo').Clear;
end;

procedure TfrmPayrollCompanyInfo.cboBankAccountsCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if tblBankCodes.Locate('BankCode', LookupTable.FieldByName('BankCode').AsString, []) then
    CompanyInfo.FieldByName('BankCode').AsInteger := tblBankCodes.FieldByName('CodeID').AsInteger
  else
    CompanyInfo.FieldByName('BankCode').Clear;
  CompanyInfo.FieldByName('BankBranch').AsString := ''; // Bank Branch is not stored in chart of accounts
  CompanyInfo.FieldByName('BSB').AsString := LookupTable.FieldByName('BSB').AsString;
  CompanyInfo.FieldByName('AccountNo').AsString := LookupTable.FieldByName('BankAccountNumber').AsString;
  CompanyInfo.FieldByName('APCANo').AsString := LookupTable.FieldByName('APCANo').AsString;
end;

initialization
  RegisterClassOnce(TfrmPayrollCompanyInfo);
end.
