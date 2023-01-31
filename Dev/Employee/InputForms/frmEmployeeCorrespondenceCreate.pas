unit frmEmployeeCorrespondenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondanceBase, WordXP, OleServer, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls, wwdblook,
  Shader, DNMPanel, tcTypes, BaseInputForm , frmEmployeeFrm;

type
  TfmEmployeeCorrespondenceCreate = class(TfmCorrespondanceBase)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fEmployeeFrm :TfrmEmployee;
    function EmployeeFrm : TfrmEmployee;
  protected
    Procedure SetReferenceTypeID(var Value :String);override;
    Procedure SetReferenceName(var Value :String);override;
    Procedure SetReferenceAddressPart1(Var Value:String);override;
    Procedure SetReferenceAddressPart2(Var Value:String);override;
    Procedure SetReferenceSalutation(Var Value:String);override;
  public
  end;
  procedure EmpCreateCorrespondence(CorrespondenceType: TCorrespondenceType;aOwner: TBaseInputGUI; aAttachmentList: TStrings = nil;sTransdata1:String ='';sTransdata2:String ='');

implementation

uses CommonLib;



{$R *.dfm}

function TfmEmployeeCorrespondenceCreate.EmployeeFrm: TfrmEmployee;
begin
  if fEmployeeFrm = nil then
    fEmployeeFrm := TfrmEmployee(FindExistingComponent('TfrmEmployee'));
  result :=fEmployeeFrm;
end;

procedure TfmEmployeeCorrespondenceCreate.FormCreate(Sender: TObject);
begin
  inherited;
  fEmployeeFrm := nil;
end;

procedure TfmEmployeeCorrespondenceCreate.FormShow(Sender: TObject);
begin
  inherited;
  if EmployeeFrm <> nil then begin
    ReferenceId        := EmployeeFrm.EmpPay.EmployeeDetails.ID;
    Referencetype      := rtemployee;
    ReferencecontactId := 0;
    EmailId            := EmployeeFrm.EmpPay.EmployeeDetails.Email;
    MessageTo          := EmployeeFrm.EmpPay.EmployeeDetails.EmployeeName + ' (' + EmployeeFrm.EmpPay.EmployeeDetails.Email + ')';
    DefaultEmailText   := '';
    Ownerconnection    := EmployeeFrm.Myconnection;
  end;

end;

procedure TfmEmployeeCorrespondenceCreate.SetReferenceAddressPart1(
  var Value: String);
begin
  inherited;
      if EmployeeFrm <> nil  then begin
                  if EmployeeFrm.empPay.EmployeeDetails.Street <> '' then
                    Value := EmployeeFrm.empPay.EmployeeDetails.Street + ' ';
                  if EmployeeFrm.empPay.EmployeeDetails.Street2 <> '' then
                    Value := Value + EmployeeFrm.empPay.EmployeeDetails.Street2 + ' ';
                  if EmployeeFrm.empPay.EmployeeDetails.Street3 <> '' then
                    Value := Value + EmployeeFrm.empPay.EmployeeDetails.Street3;
      end;

end;

procedure TfmEmployeeCorrespondenceCreate.SetReferenceAddressPart2(
  var Value: String);
begin
  inherited;
      if EmployeeFrm <> nil  then begin
                  if EmployeeFrm.empPay.EmployeeDetails.Suburb <> '' then
                    Value := EmployeeFrm.empPay.EmployeeDetails.Suburb + ' ';
                  if EmployeeFrm.empPay.EmployeeDetails.State <> '' then
                    Value := Value + EmployeeFrm.empPay.EmployeeDetails.State + ' ';
                  if EmployeeFrm.empPay.EmployeeDetails.Postcode <> '' then
                    Value := Value + EmployeeFrm.empPay.EmployeeDetails.Postcode;
        end;

end;

procedure TfmEmployeeCorrespondenceCreate.SetReferenceName(var Value: String);
begin
  inherited;
      if EmployeeFrm <> nil  then begin
        if EmployeeFrm.empPay.EmployeeDetails.Title <> '' then
          Value := EmployeeFrm.empPay.EmployeeDetails.Title + ' ';
        if EmployeeFrm.empPay.EmployeeDetails.FirstName <> '' then
          Value := Value + EmployeeFrm.empPay.EmployeeDetails.FirstName + ' ';
        if EmployeeFrm.empPay.EmployeeDetails.LastName <> '' then
          Value := Value + EmployeeFrm.empPay.EmployeeDetails.LastName;
      end;

end;

procedure TfmEmployeeCorrespondenceCreate.SetReferenceSalutation(
  var Value: String);
begin
  inherited;
      if EmployeeFrm <> nil  then begin
          if EmployeeFrm.empPay.EmployeeDetails.FirstName <> '' then
                    Value := 'Dear ' + EmployeeFrm.empPay.EmployeeDetails.FirstName;
      end;
end;


procedure TfmEmployeeCorrespondenceCreate.SetReferenceTypeID(var Value: String);
begin
  inherited;
      if EmployeeFrm <> nil then begin
        if CorrespondenceType = ctFax then
          Value := EmployeeFrm.empPay.EmployeeDetails.FaxNumber
        else if CorrespondenceType = ctEmail then
          Value := EmployeeFrm.empPay.EmployeeDetails.Email;
      end;
end;
procedure EmpCreateCorrespondence(CorrespondenceType: TCorrespondenceType;aOwner: TBaseInputGUI; aAttachmentList: TStrings = nil;sTransdata1:String ='';sTransdata2:String ='');
var
  form: TfmEmployeeCorrespondenceCreate;
begin
  form := TfmEmployeeCorrespondenceCreate.Create(aOwner);
  form.CorrespondenceType := CorrespondenceType;
  form.TransData1:= sTransData1;
  form.TransData2:= sTransData2;
  form.FormStyle := fsMDIChild;
  if Assigned(aAttachmentList) then
    form.AttachmentList.Assign(aAttachmentList);
  form.AttachObserver(form.EmployeeFrm);
  form.BringToFront;
end;
end.

