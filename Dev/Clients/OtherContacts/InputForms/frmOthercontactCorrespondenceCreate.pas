unit frmOthercontactCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondanceBase, WordXP, OleServer, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls, wwdblook,
  Shader, DNMPanel, tcTypes, BaseInputForm;

type
  TfmOthercontactCorrespondenceCreate = class(TfmCorrespondanceBase)
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
  procedure OthercontactContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');


implementation

uses frmOtherContactFrm;

{$R *.dfm}

procedure TfmOthercontactCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if Owner is TfrmOtherContact then begin
    ReferenceId        := TfrmOtherContact(Owner).qryCustomersclientId.AsInteger;
    Referencetype      := rtOthercontactcontact;
    ReferencecontactId := TfrmOtherContact(Owner).qryContactsContactID.AsInteger;
    EmailId            := TfrmOtherContact(Owner).qryContactsContactEmail.AsString;
    MessageTo          := TfrmOtherContact(Owner).qryContactsCompany.AsString + ' (' + TfrmOtherContact(Owner).qryContactsContactEmail.AsString + ')';
    DefaultEmailText   := '';
  end;
end;

procedure TfmOthercontactCorrespondenceCreate.SetReferenceAddressPart1(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmOtherContact) then begin
                  if TfrmOtherContact(Owner).qryContactsContactAddress.AsString <> '' then
                    Value := TfrmOtherContact(Owner).qryContactsContactAddress.AsString + ' ';
                  if TfrmOtherContact(Owner).qryContactsContactAddress2.AsString <> '' then
                    Value := Value + TfrmOtherContact(Owner).QryContactsContactaddress2.AsString + ' ';
                  if TfrmOtherContact(Owner).QryContactsContactAddress3.AsString <> '' then
                    Value := Value + TfrmOtherContact(Owner).QryContactsContactAddress3.AsString;
      end;

end;

procedure TfmOthercontactCorrespondenceCreate.SetReferenceAddressPart2(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmOtherContact) then begin
                  if TfrmOtherContact(Owner).qryContactsContactCity.AsString <> '' then
                    Value := TfrmOtherContact(Owner).qryContactsContactCity.AsString + ' ';
                  if TfrmOtherContact(Owner).QryContactsContactState.AsString <> '' then
                    Value := Value + TfrmOtherContact(Owner).QryContactsContactState.AsString + ' ';
                  if TfrmOtherContact(Owner).qryContactsContactPcode.AsString <> '' then
                    Value := Value + TfrmOtherContact(Owner).qryContactsContactPcode.AsString;
        end;

end;

procedure TfmOthercontactCorrespondenceCreate.SetReferenceName(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmOtherContact) then begin
        if TfrmOtherContact(Owner).QryContactsContactTitle.AsString <> '' then
          Value := TfrmOtherContact(Owner).QryContactsContactTitle.AsString + ' ';
        if TfrmOtherContact(Owner).QryContactsContactFirstName.AsString <> '' then
          Value := Value + TfrmOtherContact(Owner).QryContactsContactFirstName.AsString + ' ';
        if TfrmOtherContact(Owner).qryContactsContactSurName.AsString <> '' then
          Value := Value + TfrmOtherContact(Owner).qryContactsContactSurName.AsString;
      end;

end;

procedure TfmOthercontactCorrespondenceCreate.SetReferenceSalutation(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmOtherContact) then begin
          if TfrmOtherContact(Owner).QryContactsContactFirstName.AsString <> '' then
                    Value := 'Dear ' + TfrmOtherContact(Owner).QryContactsContactFirstName.AsString;
      end;

end;

procedure TfmOthercontactCorrespondenceCreate.SetReferenceTypeID(
  var Value: String);
begin
  inherited;
      if (Owner is TfrmOtherContact) then begin
        if CorrespondenceType = ctFax then
          Value := TfrmOtherContact(Owner).qryContactsContactFax.AsString
        else if CorrespondenceType = ctEmail then
          Value := TfrmOtherContact(Owner).qryContactsContactEmail.AsString;
      end;

end;
procedure OthercontactContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmOthercontactCorrespondenceCreate;
begin
  form := TfmOthercontactCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  form.FormStyle := fsMDIChild;
  form.AttachObserver(aOwner);
  form.BringToFront;

end;
end.

