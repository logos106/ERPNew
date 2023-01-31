unit frmRepairCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondanceBase, WordXP, OleServer, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls, wwdblook,
  Shader, DNMPanel, tcTypes, BaseInputForm;

type
  TfmRepairCorrespondenceCreate = class(TfmCorrespondanceBase)
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

  procedure RepairCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');

implementation

uses frmRepairs, tcDataUtils, frmPadRepairs;

{$R *.dfm}

procedure TfmRepairCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if Owner is TRepairsGUI then begin
    ReferenceId        := TRepairsGUI(Owner).RepairsOBJ.ID;
    ClientID           := TRepairsGUI(Owner).RepairsOBJ.ClientID;
    ReferencecontactId := TRepairsGUI(Owner).RepairsOBJ.ContactID;
    Referencetype      := rtRepair;
    ReferencecontactId := 0;
    EmailId            := ClientEmail(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID);
    MessageTo          := ClientName(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID) + ' (' + EmailId + ')';
    DefaultEmailText   := '';
  end else if Owner is TfmPadRepairs then begin
    ReferenceId        := TfmPadRepairs(Owner).RepairsOBJ.ID;
    ClientID           := TfmPadRepairs(Owner).RepairsOBJ.ClientID;
    Referencetype      := rtRepair;
    ReferencecontactId := TfmPadRepairs(Owner).RepairsOBJ.ContactID;
    EmailId            := ClientEmail(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID);
    MessageTo          := ClientName(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID) + ' (' + EmailId + ')';
    DefaultEmailText   := '';
  end;

end;

procedure TfmRepairCorrespondenceCreate.SetReferenceAddressPart1(
  var Value: String);
begin
  inherited;
      if (Owner is TRepairsGUI) then begin
        Value := ClientAddress(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID , 1);
      end else if (Owner is TfmPadRepairs) then begin
        Value := ClientAddress(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID , 1);
      end;

end;

procedure TfmRepairCorrespondenceCreate.SetReferenceAddressPart2(
  var Value: String);
begin
  inherited;
      if (Owner is TRepairsGUI) then begin
        Value := ClientAddress(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID,2);
      end else if (Owner is TfmPadRepairs) then begin
        Value := ClientAddress(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID,2);
      end;

end;

procedure TfmRepairCorrespondenceCreate.SetReferenceName(var Value: String);
begin
  inherited;
      if (Owner is TRepairsGUI) then begin
          Value := ClientName(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID);
      end else if (Owner is TfmPadRepairs) then begin
          Value := ClientName(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID);
      end;
end;

procedure TfmRepairCorrespondenceCreate.SetReferenceSalutation(
  var Value: String);
begin
  inherited;
      if (Owner is TRepairsGUI) then begin
        Value := 'Dear ' + ClientAddress(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID,3);
      end else if (Owner is TfmPadRepairs) then begin
        Value := 'Dear ' + ClientAddress(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID,3);
      end;

end;

procedure TfmRepairCorrespondenceCreate.SetReferenceTypeID(var Value: String);
begin
  inherited;
      if (Owner is TRepairsGUI) then begin
        if CorrespondenceType = ctFax then
          Value :=  ClientFax(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID)
        else if CorrespondenceType = ctEmail then
          Value := ClientEmail(TRepairsGUI(Owner).RepairsOBJ.clientID,TRepairsGUI(Owner).RepairsOBJ.ContactID)
      end else if (Owner is TfmPadRepairs) then begin
        if CorrespondenceType = ctFax then
          Value :=  ClientFax(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID)
        else if CorrespondenceType = ctEmail then
          Value := ClientEmail(TfmPadRepairs(Owner).RepairsOBJ.clientID,TfmPadRepairs(Owner).RepairsOBJ.ContactID)
      end;
end;
procedure RepairCreateCorrespondence(CorrespondenceType: TCorrespondenceType; aOwner: TBaseInputGUI;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmRepairCorrespondenceCreate;
begin
  form := TfmRepairCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  (*form.FormStyle := fsMDIChild;
  form.AttachObserver(aOwner);
  form.BringToFront;*)
  form.Showmodal;

end;

end.

