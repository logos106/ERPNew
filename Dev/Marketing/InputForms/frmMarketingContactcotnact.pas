unit frmMarketingContactcotnact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmContactbase, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, Shader,
  ExtCtrls, DNMPanel, wwdbedit, StdCtrls, wwcheckbox, wwdblook,
  DNMSpeedButton, DBCtrls, Mask, BusObjBase,BusobjMarketingcontacts,
  ProgressDialog, ComCtrls;

type
  TfmMarketingContactcotnact = class(TfmContactbase)
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TIntegerField;
    qryContactsMarketingContactID: TIntegerField;
    qryContactsCompany: TWideStringField;
    qryContactsContactTitle: TWideStringField;
    qryContactsContactFirstName: TWideStringField;
    qryContactsContactSurName: TWideStringField;
    qryContactsContactAddress: TWideStringField;
    qryContactsContactAddress2: TWideStringField;
    qryContactsContactAddress3: TWideStringField;
    qryContactsContactCity: TWideStringField;
    qryContactsContactState: TWideStringField;
    qryContactsContactPcode: TWideStringField;
    qryContactsContactCountry: TWideStringField;
    qryContactsContactPH: TWideStringField;
    qryContactsContactAltPH: TWideStringField;
    qryContactsContactMOB: TWideStringField;
    qryContactsContactFax: TWideStringField;
    qryContactsContactEmail: TWideStringField;
    qryContactsNotes: TWideStringField;
    qryContactsEditedFlag: TWideStringField;
    qryContactsActive: TWideStringField;
    qryContactsCardNumber: TWideStringField;
    qryContactsAccountNo: TWideStringField;
    qryContactsJobTitle: TWideStringField;
    qryContactsmsTimeStamp: TDateTimeField;
    qryContactsIsPrimarycontact: TWideStringField;
    qryContactsDoNotContact: TWideStringField;
    qryContactsmsUpdateSiteCode: TWideStringField;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure cmdAddNewRecordClick(Sender: TObject);
    procedure cmOriginalClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SuburbCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fiMCId: Integer;
    Procedure CancelRecord;
    Procedure Doinitialise;
    Procedure SetcontractDefaults;
    function GetClientType(id: integer): string;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    MCC: TMarketingContactContact;
    property MCID:Integer read fiMCId write fiMCID;
  end;


implementation

uses CommonLib, AppEnvironment, CommonDbLib, FastFuncs, 
  BaseInputForm, BusObjConst ;

{$R *.dfm}
procedure TfmMarketingContactcotnact.cmdCloseClick(Sender: TObject);
begin
  inherited;
    cancelrecord;

      if not(assigned(Transconnection)) then begin
          MCC.Connection.RollbackTransaction;
          notify(true);
      end;
      if fsModal in Self.FormState then
        Modalresult := mrCancel
      else begin
        Self.close;
      end;
end;

procedure TfmMarketingContactcotnact.FormShow(Sender: TObject);
begin
  inherited;
  SetTransconenctiontoQueries;
  if not(Assigned(MCC)) then begin
      MCC := TMarketingContactContact.create(Self);
      MCC.connection := TMyDacDataConnection.create(MCC);
      if assigned(Transconnection) then begin
        MCC.connection.Connection := Transconnection;
      end else begin
        MCC.connection.Connection := Self.MyConnection;
      end;
      MCC.connection.BeginTransaction;
      MCC.BusObjEvent := DoBusinessObjectEvent;
      MCC.Load(KeyID);
  end
  else begin

  end;
  Objcontact := MCC;
  opendb(qrySuburb);
  DoInitialise;
end;

procedure TfmMarketingContactcotnact.qrySuburbBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmMarketingContactcotnact.cmdAddNewRecordClick(Sender: TObject);
begin
  inherited;
  if MCC.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
          if not MCC.Save then Exit;
          if fsModal in Self.FormState then

          else begin
            MCC.Connection.CommitTransaction;
            MCC.Connection.BeginTransaction;
          end;
      end;
      mrNo: begin
        CancelRecord;
        if  fsModal in Self.FormState then
        else begin
          MCC.Connection.RollbackTransaction;
          MCC.Connection.BeginTransaction;
        end;
      end;
      mrCancel:
          Exit;
    end;
  end;
  MCC.NEW;
  SetFocusedControl(txtCompany);
end;

procedure TfmMarketingContactcotnact.cmOriginalClick(Sender: TObject);
begin
  inherited;
  if Assigned(MCC.MarketingContact) then begin
      MCC.ContactPH         := MCC.MarketingContact.Phone;
      MCC.ContactFax        := MCC.MarketingContact.FaxNumber;
      MCC.ContactAltPH      := MCC.MarketingContact.AltPhone;
      MCC.ContactAddress    := MCC.MarketingContact.Street;
      MCC.ContactAddress2   := MCC.MarketingContact.Street2;
      MCC.ContactAddress3   := MCC.MarketingContact.Street3;
      MCC.ContactCity       := MCC.MarketingContact.Suburb;
      MCC.ContactState      := MCC.MarketingContact.State;
      MCC.ContactPcode      := MCC.MarketingContact.Postcode;
      MCC.ContactCountry    := MCC.MarketingContact.Country;
      MCC.Active            := True;
  end;
end;


procedure TfmMarketingContactcotnact.btnOkClick(Sender: TObject);
begin
  inherited;
  if MCC.Save then   begin
      if not(assigned(Transconnection)) then begin
          MCC.Connection.CommitTransaction;
          notify(False);
      end;

      if fsModal in Self.FormState then
        Modalresult := mrOk
      else begin
        Self.close;
      end;
  end;
end;

procedure TfmMarketingContactcotnact.CancelRecord;
begin
    MCC.CancelDB;
end;
procedure TfmMarketingContactcotnact.Doinitialise;
var
  qry: TMyQuery;
begin
  if KeyID = 0 then begin
    MCC.New;
    MCC.MarketingContactID := mcID;
    MCC.PostDb;

    if fiMcID > 0 then begin
      qry:= TMyQuery.Create(nil);
      try
        qry.Connection:= MCC.Connection.Connection;
        qry.SQL.Add('SELECT ContactID FROM tblmarketingcontactcontacts');
        qry.SQL.Add('WHERE MarketingContactID = ' + IntToStr(fiMCID));
        qry.SQL.Add('and ContactID <> ' + IntToStr(MCC.Id));
        qry.Open;
        if qry.RecordCount = 0 then
          SetcontractDefaults;
      finally
        qry.Free;
      end;

    end;
  end
  else begin
    if KeyID <> MCC.ID then
      MCC.Load(KeyID);
  end;

end;

procedure TfmMarketingContactcotnact.FormCreate(Sender: TObject);
begin
  inherited;
  fiMCID:= 0;
end;

procedure TfmMarketingContactcotnact.SetcontractDefaults;
begin
  With CommonDbLib.tempmyquery do try
    connection := Mcc.connection.connection;
    SQL.add('SELECT  `MC`.`Title`,`MC`.`FirstName`,`MC`.`LastName`,`MC`.`JobTitle`,' +
              '`MC`.`Email`,`MC`.`Phone`,`MC`.`Mobile` , `Mc`.`FaxNumber`,`MC`.`AltPhone`,`MC`.`Street`,' +
              '`MC`.`Street2`,`MC`.`Street3`,`MC`.`SUBURB`,`MC`.`STATE`,`MC`.`POSTCODE`,`MC`.`Country`' +
              ' from  tblmarketingcontacts MC Where ID = ' + IntToStr(fiMcID));
    open;
    if recordcount = 0 then exit;
    MCC.MarketingContactID := mcID;
    MCC.ContactTitle      := fieldbyname('Title').asString;
    MCC.ContactFirstName  := fieldbyname('FirstName').asString;
    MCC.ContactSurName    := fieldbyname('LastName').asString;
    MCC.ContactMOB        := fieldbyname('Mobile').asString;
    MCC.jobtitle          := fieldbyname('JobTitle').asString;
    MCC.ContactEmail      := fieldbyname('Email').asString;
    MCC.ISPrimaryContact  := True;
    MCC.ContactPH         := fieldbyname('Phone').asString;
    MCC.ContactFax        := fieldbyname('FaxNumber').asString;
    MCC.ContactAltPH      := fieldbyname('AltPhone').asString;
    MCC.ContactAddress    := fieldbyname('Street').asString;
    MCC.ContactAddress2   := fieldbyname('Street2').asString;
    MCC.ContactAddress3   := fieldbyname('Street3').asString;
    MCC.ContactCity       := fieldbyname('Suburb').asString;
    MCC.ContactState      := fieldbyname('State').asString;
    MCC.ContactPcode      := fieldbyname('Postcode').asString;
    MCC.ContactCountry    := fieldbyname('Country').asString;
    MCC.Active            := True;
    lblCustType.Caption := GetClientType(fiMCId);
    Companyname;
  finally
    if active then close;
    Free;
  end;

end;

function TfmMarketingContactcotnact.GetClientType(id: integer): string;
begin
  Result := '';
  with CommondbLib.tempMyQuery do try
      Close;
      SQL.Clear;
      SQL.Add('SELECT `CompanyTypeName`  ' +
        ' FROM tblmarketingcontacts MC' +
        ' WHERE ID = ' +IntToStr(ID));
      Open;
      if not IsEmpty then begin
        Result := FieldByName('CompanyTypeName').AsString;
      end;
  finally
    if active then close;
    Free;
  end;
end;

procedure TfmMarketingContactcotnact.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmMarketingContactcotnact.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if sender is TMarketingContactContact then TMarketingContactContact(SendeR).dataset := qryContacts;
  end;
end;

procedure TfmMarketingContactcotnact.SuburbCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  MCC.ContactState := LookupTable.FieldByName('State').asString;
  MCC.ContactPcode := LookupTable.FieldByName('Postcode').asString;
  MCC.ContactCountry := LookupTable.FieldByName('Country').asString;
end;

initialization
  RegisterClassOnce(TfmMarketingContactcotnact);


end.
