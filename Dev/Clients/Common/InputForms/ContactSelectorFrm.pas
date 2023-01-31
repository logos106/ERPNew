unit ContactSelectorFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 04/01/06  1.00.01 DSP  Fixed fault causing an access violation in the
                        btnOkClick procedure.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar,
  CommonLib,wwdblook, BaseTransForm, DBCtrls, dbcgrids, Grids, Wwdbigrd, Wwdbgrid,
  DBAccess, MyAccess,ERPdbComponents, DataState, {frmRepairs,} Menus, AdvMenus, MemDS, Shader,
  ImgList;

type
  TUpdatecontact= procedure(const Value:TDataset)  of object;
  TfrmContactSelector = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCustomer: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dsContacts: TDataSource;
    btnNew: TDNMSpeedButton;
    grdContacts: TwwDBGrid;
    tblContact: TERPQuery;
    tblContactcontacttitle: TWideStringField;
    tblContactcontactfirstname: TWideStringField;
    tblContactcontactsurname: TWideStringField;
    tblContactcontactid: TAutoIncField;
    tblContactCompany: TWideStringField;
    tblContactcontactaddress: TWideStringField;
    tblContactcontactaddress2: TWideStringField;
    tblContactcontactcity: TWideStringField;
    tblContactcontactstate: TWideStringField;
    tblContactcontactpcode: TWideStringField;
    tblClient: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tblContactContactAddress3: TWideStringField;
    tblContactphone: TWideStringField;
    tblContactmobile: TWideStringField;
    tblContactFax: TWideStringField;
    tblContactClientID: TIntegerField;
    tblContactClientName: TWideStringField;
    tblContactJobTitle: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbNamesClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure grdContactsDblClick(Sender: TObject);
    procedure grdContactsEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    fiClientID: integer;
    fContactType: TContactType;
    fUpdateContactDetails: TUpdatecontact;
    //    function GetShipToComponentID:Integer;
  public
    { Public declarations }
    Property ContactType:TContactType REad fContactType Write fContactType;
    Property UpdateContactDetails :TUpdatecontact read fUpdateContactDetails write fUpdateContactDetails;

    property ClientID: integer read fiClientID write fiClientID;
  end;

(*var
  strKeyName: string;*)

implementation

uses
  DNMExceptions, frmContactFrm,
  FastFuncs ;

{$R *.dfm}

procedure TfrmContactSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblContact.Active := false;
  tblClient.Active := false;
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmContactSelector.FormShow(Sender: TObject);
var
  sWhere: string;
begin
  DisableForm;
  try
    inherited;
    try
      if tblContact.Active then begin
        if tblContact.State in [dsBrowse] then begin
          tblContact.Post;
          Notify;
        end;
        CloseQueries;
      end;

      with tblClient do begin
        Active := false;
        SQL.Text := 'SELECT * FROM tblclients WHERE (ClientID = ' + IntToStr(fiClientID) + ')';
        Active := true;
      end;

      with tblContact do begin
        Active := false;
        SQL.Text :='SELECT contactid, ClientID, ClientName, Company, contacttitle,' +
        ' contactfirstname, contactsurname, JobTitle,contactaddress,contactaddress2,' +
        ' contactaddress3, contactcity, contactstate, contactpcode, ContactPH as phone,' +
        ' ContactMOB as mobile ,ContactFax as Fax FROM tblcontacts';

        sWhere := ' WHERE (ClientID=' + IntToStr(fiClientID) + ') AND Active = ''T''';
//        sWhere := ' WHERE (CusID=' + IntToStr(fiClientID) + ') AND Active = ''T''';
//        if ContactType = tAll then
//          sWhere := sWhere + ' OR (SupID=' + IntToStr(fiClientID) + ' AND Active = ''T'')'
//        else if ContactType = tEmployeecontact then
//          sWhere := 'WHERE EmployeeID=' + IntToStr(fiClientID)// Is the calling form the Employee Form.
//        else if ContactType = tSupplierContact then
//          sWhere := 'WHERE SupID=' + IntToStr(fiClientID);
        sWhere := sWhere + ' ORDER BY contactsurname';

        SQL.Text := SQL.Text + sWhere;
        Active := true;
      end;

      OpenQueries;
      grdContacts.Enabled := true;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmContactSelector.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.ModalResult := 2;
end;

procedure TfrmContactSelector.btnOkClick(Sender: TObject);
begin
  inherited;
  if assigned(fUpdateContactDetails) then fUpdateContactDetails(tblcontact);
  Self.ModalResult := 1;
end;

procedure TfrmContactSelector.lbNamesClick(Sender: TObject);
begin
  if not btnOk.Enabled then btnOk.Enabled := true;
end;

procedure TfrmContactSelector.btnNewClick(Sender: TObject);
Var Form : TComponent;
begin
    if not FormStillOpen('TfrmContact') then begin
    Form := GetComponentByClassName('TfrmContact');
    if Assigned(Form) then begin
      with TfrmContact(Form) do begin
        KeyID := 0;
//        if contacttype = tSupplierContact then
//          supplierId := tblClient.fieldbyname('ClientID').asInteger
//        else ClientId:= tblClient.fieldbyname('ClientID').asInteger;
        ClientId:= tblClient.fieldbyname('ClientID').asInteger;
        Position := poScreenCenter;
        ShowModal;
        if tblContact.active then tblContact.Close;
        tblContact.Open;
      end;
    end;  
end;
end;

procedure TfrmContactSelector.grdContactsDblClick(Sender: TObject);
begin
  inherited;
  if not btnOk.Enabled then btnOk.Enabled := true;
  btnOkClick(Sender);
end;

procedure TfrmContactSelector.grdContactsEnter(Sender: TObject);
begin
  inherited;
  btnOk.Enabled := true;
end;

procedure TfrmContactSelector.FormCreate(Sender: TObject);
begin
  inherited;
  fUpdateContactDetails := nil;
end;

initialization
  RegisterClassOnce(TfrmContactSelector);

end.
