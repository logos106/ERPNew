unit frmCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Mask, DBCtrls,
  Shader, DNMPanel, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, WordXP, wwdblook,
  tcTypes,frmCorrespondanceBase, OleServer;

type

  TfmCorrespondenceCreate = class(TfmCorrespondanceBase)
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
  procedure MCCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
implementation

{$R *.dfm}

uses
  CommonLib, SystemLib, frmMarketingLead, BusObjCorrespondence, BusObjBase,
  EmailUtils, AppEnvironment, SimpleEncrypt, CommonDBLib, Preferences,
  {$Warnings Off}
  OleAuto,
  {$Warnings On}
  StrUtils, tcDataUtils, remainClientFrm, BusObjCorrespondenceReference,
  frmCorrespondenceReference, frmEmailCorrespondenceReference,
  frmLetterCorrespondenceReference, frmMarketing;

procedure MCCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmCorrespondenceCreate;
begin
  form := TfmCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  form.FormStyle := fsMDIChild;
  form.AttachObserver(aOwner);
  form.BringToFront;

end;

procedure TfmCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if Owner is TfmMarketingLead then begin
    ReferenceId        := TfmMarketingLead(Owner).Lead.MarketingContactID;
    Referencetype      := rtMarketingcontact;
    ReferencecontactId := 0;
    EmailId            := TfmMarketingLead(Owner).Lead.MarketingContacts.currentEmailID;
    MessageTo          := TfmMarketingLead(Owner).Lead.MarketingContacts.Company + ' (' + TfmMarketingLead(Owner).Lead.MarketingContacts.Email + ')';
    DefaultEmailText   := Appenv.Companyprefs.DefaultEmailText;
  end  else if Owner is TfmMarketing then begin
    ReferenceId        := TfmMarketing(Owner).Followups.MarketingContactID;
    Referencetype      := rtMarketingcontact;
    ReferencecontactId := 0;
    EmailId            := TfmMarketing(Owner).Followups.MarketingContacts.currentEmailID;
    MessageTo          := TfmMarketing(Owner).Followups.MarketingContacts.Company + ' (' + TfmMarketing(Owner).Followups.MarketingContacts.Email + ')';
    DefaultEmailText   := Appenv.Companyprefs.DefaultEmailText;
  end;

end;

procedure TfmCorrespondenceCreate.SetReferenceAddressPart1(var Value: String);
begin
  inherited;
      if (Owner is TfmMarketingLead) then begin
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street <> '' then
                    Value := TfmMarketingLead(Owner).Lead.MarketingContacts.Street + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street2 <> '' then
                    Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.Street2 + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street3 <> '' then
                    Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.Street3;
      end;
end;

procedure TfmCorrespondenceCreate.SetReferenceAddressPart2(var Value: String);
begin
  inherited;
      if (Owner is TfmMarketingLead) then begin
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Suburb <> '' then
                    Value := TfmMarketingLead(Owner).Lead.MarketingContacts.Suburb + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.State <> '' then
                    Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.State + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Postcode <> '' then
                    Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.Postcode;
        end;
end;
procedure TfmCorrespondenceCreate.SetReferenceSalutation(var Value: String);
begin
  inherited;
      if (Owner is TfmMarketingLead) then begin
          if TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName <> '' then
                    Value := 'Dear ' + TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName;
      end;
end;

Procedure TfmCorrespondenceCreate.SetReferenceName(var Value :String);
begin
  inherited;
      if (Owner is TfmMarketingLead) then begin
        if TfmMarketingLead(Owner).Lead.MarketingContacts.Title <> '' then
          Value := TfmMarketingLead(Owner).Lead.MarketingContacts.Title + ' ';
        if TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName <> '' then
          Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName + ' ';
        if TfmMarketingLead(Owner).Lead.MarketingContacts.LastName <> '' then
          Value := Value + TfmMarketingLead(Owner).Lead.MarketingContacts.LastName;
      end;
end;
procedure TfmCorrespondenceCreate.SetReferenceTypeID(var Value: String);
begin
      if (Owner is TfmMarketingLead) then begin
        if CorrespondenceType = ctFax then
          Value := TfmMarketingLead(Owner).Lead.MarketingContacts.FaxNumber
        else if CorrespondenceType = ctEmail then
          Value := TfmMarketingLead(Owner).Lead.MarketingContacts.Email;
      end;
end;

end.
