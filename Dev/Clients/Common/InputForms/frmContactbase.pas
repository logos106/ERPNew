unit frmContactbase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Shader, DNMPanel, wwdbedit, StdCtrls, wwcheckbox, wwdblook,
  DNMSpeedButton, DBCtrls, Mask, BusObjContact, ProgressDialog, ComCtrls; // BusobjMarketingcontacts;

type
  TfmContactbase = class(TBaseInputGUI)
    qryContacts: TERPQuery;
    dsContacts: TDataSource;
    qrySuburb: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    TABCTL20: TPageControl;
    tsMain: TTabSheet;
    MainPanel: TDNMPanel;
    Bevel2: TBevel;
    Box69: TBevel;
    Box70: TBevel;
    Box72: TBevel;
    Box83: TBevel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label59: TLabel;
    Label78: TLabel;
    Label77: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblSuburb: TLabel;
    lblPostCode: TLabel;
    lblState: TLabel;
    Label3: TLabel;
    lblCustType: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblCountry: TLabel;
    ContactFax: TwwDBEdit;
    ContactMOB: TwwDBEdit;
    txtContactAltPH: TwwDBEdit;
    txtNotes: TDBMemo;
    txtContactAddress: TDBEdit;
    txtContactEmail: TDBEdit;
    txtContactAddress2: TDBEdit;
    txtCompany: TDBEdit;
    Postcode: TDBEdit;
    Suburb: TwwDBLookupCombo;
    State: TDBEdit;
    chkActive: TwwCheckBox;
    edtCardNum: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    JobTitle: TDBEdit;
    txtContactAddress3: TDBEdit;
    edtCountry: TwwDBEdit;
    wwCheckBox1: TwwCheckBox;
    txtContactFirstName: TDBEdit;
    txtContactTitle: TDBEdit;
    txtContactSurName: TDBEdit;
    ContactPh: TwwDBEdit;
    chkDoNotContact: TwwCheckBox;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmOriginal: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    procedure txtContactFirstNameExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtCompanyExit(Sender: TObject);
    procedure TABCTL20DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
  private

  Protected
    Objcontact :TContactBase;
    
    (*function ValidateFormData: boolean;virtual;*)
    fbEmailchanged:Boolean;
    Procedure Companyname;
    Procedure SplitCompanyname;
  public
  end;


implementation

uses CommonLib, FastFuncs, AppEnvironment;

{$R *.dfm}

procedure TfmContactbase.Companyname;
var
  CoName: string;
begin
  (*CoName:= Trim(qryContacts.Fieldbyname('company').asString);
  if qryContacts.Fieldbyname('company').asString <> CoName then begin
    editDb(qryContacts);
    qryContacts.Fieldbyname('company').asString := Trim(qryContacts.Fieldbyname('company').asString);
  end;

  if (qryContacts.Fieldbyname('company').asString = '') or
    (qryContacts.Fieldbyname('company').asString = qryContacts.Fieldbyname('ContactFirstName').asString) or
    (qryContacts.Fieldbyname('company').asString = qryContacts.Fieldbyname('ContactSurName').asString) then begin
    editDb(qryContacts);
    qryContacts.Fieldbyname('company').asString := qryContacts.Fieldbyname('ContactFirstName').asString + ' ' +
                                            qryContacts.Fieldbyname('ContactSurName').asString;
  end;*)

  CoName:= Trim(Objcontact.Company);
  if Objcontact.Company <> CoName then begin
    Objcontact.Company := Trim(Objcontact.Company);
  end;

  if (Objcontact.Company = '') or
    (Objcontact.Company = Trim(Objcontact.contactFirstName)) or
    (Objcontact.Company = Trim(Objcontact.contactSurname)) then begin
    Objcontact.Company := Trim(Objcontact.contactFirstName + ' ' +
                                            Objcontact.contactSurname);
  end;
end;

(*function TfmContactbase.ValidateFormData: boolean;
begin
  Companyname;

  if Trim(txtContactFirstName.Text + ' ' + txtContactSurName.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Contacts must at least have a first or last name!', mtWarning, [mbOK], 0);
    Result := false;
    Exit;
  end;
  result := ConfirmEmailId(fbEmailchanged ,txtContactEmail ,qryContacts ,'ContactEmail');
  qryContacts.Edit;


end;*)

procedure TfmContactbase.FormCreate(Sender: TObject);
begin
  AddPhoneCallbutton(ContactPh);
  AddPhoneCallbutton(ContactMOB);
  AddPhoneCallbutton(txtContactAltPH);
  inherited;
  qrySuburb.Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmContactbase.SplitCompanyname;
var
  CoName: string;
  f, s:String;
begin
  Objcontact.PostDB;
  CoName:= Trim(Objcontact.Company);
  if Objcontact.Company <> CoName then Objcontact.Company := Trim(Objcontact.Company);

  if (Objcontact.Company = '')  then exit;

  f:= SubStr(CoName , ' ' , 1 );
  s:= StringReplace(CoName, f, '',[]);

  if Trim(Objcontact.contactFirstName) = '' then Objcontact.contactFirstName := Trim(f);
  if Trim(Objcontact.contactSurname) = ''   then Objcontact.contactSurname := trim(s);
end;

procedure TfmContactbase.SuburbCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
//
  if not Modified then
    exit;
  qryContacts.Edit;
  qryContacts.FieldByName('ContactState').asString := qrySuburb.FieldByName('State').AsString;
  qryContacts.FieldByName('ContactPCode').asString := qrySuburb.FieldByName('PostCode').AsString;
  qryContacts.FieldByName('ContactCountry').asString := qrySuburb.FieldByName('Country').AsString;
end;

procedure TfmContactbase.TABCTL20DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  inherited;
//
end;

procedure TfmContactbase.txtCompanyExit(Sender: TObject);
begin
  inherited;
  SplitCompanyname;
end;

procedure TfmContactbase.txtContactFirstNameExit(Sender: TObject);
begin
  inherited;
  companyName;
end;

end.
