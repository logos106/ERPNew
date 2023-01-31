unit frmSupplierCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondanceBase, WordXP, OleServer, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls, wwdblook,
  Shader, DNMPanel, tcTypes, BaseInputForm;

type
  TfmSupplierCorrespondenceCreate = class(TfmCorrespondanceBase)
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

procedure SuppContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');

implementation

uses frmSupplier;

{$R *.dfm}

procedure TfmSupplierCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if Owner is TfmSupplier then begin
    ReferenceId        := TfmSupplier(Owner).qrySupplierclientId.AsInteger;
    Referencetype      := rtsuppliercontact;
    ReferencecontactId := TfmSupplier(Owner).qryContactsContactID.AsInteger;
    EmailId            := TfmSupplier(Owner).qryContactsContactEmail.AsString;
    MessageTo          := TfmSupplier(Owner).qryContactsCompany.AsString + ' (' + TfmSupplier(Owner).qryContactsContactEmail.AsString + ')';
    DefaultEmailText   := '';
  end;

end;

procedure TfmSupplierCorrespondenceCreate.SetReferenceAddressPart1(
  var Value: String);
begin
  inherited;
      if (Owner is TfmSupplier) then begin
                  if TfmSupplier(Owner).qryContactsContactAddress.AsString <> '' then
                    Value := TfmSupplier(Owner).qryContactsContactAddress.AsString + ' ';
                  if TfmSupplier(Owner).qryContactsContactAddress2.AsString <> '' then
                    Value := Value + TfmSupplier(Owner).QryContactsContactaddress2.AsString + ' ';
                  if TfmSupplier(Owner).QryContactsContactAddress3.AsString <> '' then
                    Value := Value + TfmSupplier(Owner).QryContactsContactAddress3.AsString;
      end;

end;

procedure TfmSupplierCorrespondenceCreate.SetReferenceAddressPart2(
  var Value: String);
begin
  inherited;
      if (Owner is TfmSupplier) then begin
                  if TfmSupplier(Owner).qryContactsContactCity.AsString <> '' then
                    Value := TfmSupplier(Owner).qryContactsContactCity.AsString + ' ';
                  if TfmSupplier(Owner).QryContactsContactState.AsString <> '' then
                    Value := Value + TfmSupplier(Owner).QryContactsContactState.AsString + ' ';
                  if TfmSupplier(Owner).qryContactsContactPcode.AsString <> '' then
                    Value := Value + TfmSupplier(Owner).qryContactsContactPcode.AsString;
        end;

end;

procedure TfmSupplierCorrespondenceCreate.SetReferenceName(var Value: String);
begin
  inherited;
      if (Owner is TfmSupplier) then begin
        if TfmSupplier(Owner).QryContactsContactTitle.AsString <> '' then
          Value := TfmSupplier(Owner).QryContactsContactTitle.AsString + ' ';
        if TfmSupplier(Owner).QryContactsContactFirstName.AsString <> '' then
          Value := Value + TfmSupplier(Owner).QryContactsContactFirstName.AsString + ' ';
        if TfmSupplier(Owner).qryContactsContactSurName.AsString <> '' then
          Value := Value + TfmSupplier(Owner).qryContactsContactSurName.AsString;
      end;

end;

procedure TfmSupplierCorrespondenceCreate.SetReferenceSalutation(
  var Value: String);
begin
  inherited;
      if (Owner is TfmSupplier) then begin
          if TfmSupplier(Owner).QryContactsContactFirstName.AsString <> '' then
                    Value := 'Dear ' + TfmSupplier(Owner).QryContactsContactFirstName.AsString;
      end;

end;

procedure TfmSupplierCorrespondenceCreate.SetReferenceTypeID(var Value: String);
begin
  inherited;
      if (Owner is TfmSupplier) then begin
        if CorrespondenceType = ctFax then
          Value := TfmSupplier(Owner).qryContactsContactFax.AsString
        else if CorrespondenceType = ctEmail then
          Value := TfmSupplier(Owner).qryContactsContactEmail.AsString;
      end;

end;
procedure SuppContactCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmSupplierCorrespondenceCreate;
begin
  form := TfmSupplierCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  form.FormStyle := fsMDIChild;
  form.AttachObserver(aOwner);
  form.BringToFront;
end;
end.

