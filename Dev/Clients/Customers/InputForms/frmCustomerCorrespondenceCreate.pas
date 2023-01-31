unit frmCustomerCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondanceBase, WordXP, OleServer, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls, wwdblook,
  Shader, DNMPanel, tcTypes, BaseInputForm;

type
  TfmCustomerCorrespondenceCreate = class(TfmCorrespondanceBase)
    procedure FormShow(Sender: TObject);
  private
  Protected
    Procedure SetReferenceTypeID(var Value :String);override;
    Procedure SetReferenceName(var Value :String);override;
    Procedure SetReferenceAddressPart1(Var Value:String);override;
    Procedure SetReferenceAddressPart2(Var Value:String);override;
    Procedure SetReferenceSalutation(Var Value:String);override;
  public
  end;
  procedure CustContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');

implementation

uses frmCustomerFrm, frmJob;

{$R *.dfm}

procedure TfmCustomerCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if Owner is TfrmCustomer then begin
    ReferenceId        := TfrmCustomer(Owner).qryCustomersclientId.AsInteger;
    Referencetype      := rtcustomercontact;
    {
    ReferencecontactId := TfrmCustomer(Owner).qryContactsContactID.AsInteger;
    EmailId            := TfrmCustomer(Owner).qryContactsContactEmail.AsString;
    MessageTo          := TfrmCustomer(Owner).qryContactsCompany.AsString + ' (' + TfrmCustomer(Owner).qryContactsContactEmail.AsString + ')';
    }
    ReferencecontactId := TfrmCustomer(Owner).SelectedContactId;
    EmailId            := TfrmCustomer(Owner).SelectedContactEMail;
    MessageTo          := TfrmCustomer(Owner).SelectedContactCompany + ' (' + TfrmCustomer(Owner).SelectedContactEMail + ')';
    DefaultEmailText   := '';
  end else   if Owner is TJobGUI then begin
    ReferenceId        := TJobGUI(Owner).qryJobclientId.AsInteger;
    Referencetype      := rtcustomercontact;
    ReferencecontactId := TJobGUI(Owner).qryContactsContactID.AsInteger;
    EmailId            := TJobGUI(Owner).qryContactsContactEmail.AsString;
    MessageTo          := TJobGUI(Owner).qryContactsCompany.AsString + ' (' + TJobGUI(Owner).qryContactsContactEmail.AsString + ')';
    DefaultEmailText   := '';
  end;

end;

procedure TfmCustomerCorrespondenceCreate.SetReferenceAddressPart1(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmCustomer) then begin
      (*
                  if TfrmCustomer(Owner).qryContactsContactAddress.AsString <> '' then
                    Value := TfrmCustomer(Owner).qryContactsContactAddress.AsString + ' ';
                  if TfrmCustomer(Owner).qryContactsContactAddress2.AsString <> '' then
                    Value := Value + TfrmCustomer(Owner).QryContactsContactaddress2.AsString + ' ';
                  if TfrmCustomer(Owner).QryContactsContactAddress3.AsString <> '' then
                    Value := Value + TfrmCustomer(Owner).QryContactsContactAddress3.AsString;
      *)
                  Value := TfrmCustomer(Owner).SelectedContactAddress;
      end else if (Owner is TJobGUI) then begin
                  if TJobGUI(Owner).qryContactsContactAddress.AsString <> '' then
                    Value := TJobGUI(Owner).qryContactsContactAddress.AsString + ' ';
                  if TJobGUI(Owner).qryContactsContactAddress2.AsString <> '' then
                    Value := Value + TJobGUI(Owner).QryContactsContactaddress2.AsString + ' ';
                  if TJobGUI(Owner).QryContactsContactAddress3.AsString <> '' then
                    Value := Value + TJobGUI(Owner).QryContactsContactAddress3.AsString;
      end;
end;

procedure TfmCustomerCorrespondenceCreate.SetReferenceAddressPart2(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmCustomer) then begin
      (*
                  if TfrmCustomer(Owner).qryContactsContactCity.AsString <> '' then
                    Value := TfrmCustomer(Owner).qryContactsContactCity.AsString + ' ';
                  if TfrmCustomer(Owner).QryContactsContactState.AsString <> '' then
                    Value := Value + TfrmCustomer(Owner).QryContactsContactState.AsString + ' ';
                  if TfrmCustomer(Owner).qryContactsContactPcode.AsString <> '' then
                    Value := Value + TfrmCustomer(Owner).qryContactsContactPcode.AsString;
      *)
        Value := TfrmCustomer(Owner).SelectedContactState;
      end else if (Owner is TJobGUI) then begin
                  if TJobGUI(Owner).qryContactsContactCity.AsString <> '' then
                    Value := TJobGUI(Owner).qryContactsContactCity.AsString + ' ';
                  if TJobGUI(Owner).QryContactsContactState.AsString <> '' then
                    Value := Value + TJobGUI(Owner).QryContactsContactState.AsString + ' ';
                  if TJobGUI(Owner).qryContactsContactPcode.AsString <> '' then
                    Value := Value + TJobGUI(Owner).qryContactsContactPcode.AsString;
      end;

end;

procedure TfmCustomerCorrespondenceCreate.SetReferenceName(var Value: String);
begin
  inherited;
      if (Owner is TfrmCustomer) then begin
        (*
        if TfrmCustomer(Owner).QryContactsContactTitle.AsString <> '' then
          Value := TfrmCustomer(Owner).QryContactsContactTitle.AsString + ' ';
        if TfrmCustomer(Owner).QryContactsContactFirstName.AsString <> '' then
          Value := Value + TfrmCustomer(Owner).QryContactsContactFirstName.AsString + ' ';
        if TfrmCustomer(Owner).qryContactsContactSurName.AsString <> '' then
          Value := Value + TfrmCustomer(Owner).qryContactsContactSurName.AsString;
        *)
        Value := TfrmCustomer(Owner).SelectedContactName;
      end else if (Owner is TJobGUI) then begin
        if TJobGUI(Owner).QryContactsContactTitle.AsString <> '' then
          Value := TJobGUI(Owner).QryContactsContactTitle.AsString + ' ';
        if TJobGUI(Owner).QryContactsContactFirstName.AsString <> '' then
          Value := Value + TJobGUI(Owner).QryContactsContactFirstName.AsString + ' ';
        if TJobGUI(Owner).qryContactsContactSurName.AsString <> '' then
          Value := Value + TJobGUI(Owner).qryContactsContactSurName.AsString;
      end;

end;

procedure TfmCustomerCorrespondenceCreate.SetReferenceSalutation(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmCustomer) then begin
      (*
          if TfrmCustomer(Owner).QryContactsContactFirstName.AsString <> '' then
                    Value := 'Dear ' + TfrmCustomer(Owner).QryContactsContactFirstName.AsString;
      *)
          if TfrmCustomer(Owner).SelectedContactFirstName <> '' then
                    Value := 'Dear ' + TfrmCustomer(Owner).SelectedContactFirstName;
      end else if (Owner is TJobGUI) then begin
          if TJobGUI(Owner).QryContactsContactFirstName.AsString <> '' then
                    Value := 'Dear ' + TJobGUI(Owner).QryContactsContactFirstName.AsString;
      end;

end;


procedure TfmCustomerCorrespondenceCreate.SetReferenceTypeID(var Value: String);
begin
  inherited;
      if (Owner is TfrmCustomer) then begin
        if CorrespondenceType = ctFax then
          Value := TfrmCustomer(Owner).SelectedContactFax //qryContactsContactFax.AsString
        else if CorrespondenceType = ctEmail then
          Value := TfrmCustomer(Owner).SelectedContactEMail; //qryContactsContactEmail.AsString;
      end else if (Owner is TJobGUI) then begin
        if CorrespondenceType = ctFax then
          Value := TJobGUI(Owner).qryContactsContactFax.AsString
        else if CorrespondenceType = ctEmail then
          Value := TJobGUI(Owner).qryContactsContactEmail.AsString;
      end;

end;
procedure CustContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmCustomerCorrespondenceCreate;
begin
  form := TfmCustomerCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  form.FormStyle := fsMDIChild;
  form.AttachObserver(aOwner);
  form.BringToFront;
end;
end.

