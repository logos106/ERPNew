unit BaseMarketingContactList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm, DAScript,
  MyScript, wwcheckbox, CustomInputBox;

type
  TBaseMarketingContactListGUI = class(TBaseListingGUI)
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    AssignKeyIdDone :Boolean;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib, FastFuncs;



{$R *.dfm}
Procedure TBaseMarketingContactListGUI.AssignKeyId(Popupform :TBaseInputGUI);
var
    s:STring;
begin
    if Sysutils.SameText(FormFact.Identifier, 'LastFollowupdone') then
        Popupform.KeyId := Qrymain.FieldByname('FollowupId').asInteger
    else if Sysutils.SameText(FormFact.Identifier, 'LastLeaddone') then
        Popupform.KeyId := Qrymain.Fieldbyname('LeadId').asInteger
    else if (Sysutils.SameText(FormFact.Identifier, 'ActionDate')) or (Sysutils.SameText(FormFact.Identifier, 'Action')) then begin
        Popupform.KeyId :=0;
        if qryMain.Fieldbyname('LeadId').asInteger <> 0 then begin
            if Sysutils.SameText(popupform.classname , 'TfmMarketingLead') then
                Popupform.KeyId := qryMain.Fieldbyname('Leadid').asInteger;
        end else if qryMain.Fieldbyname('LeadId').asInteger = 0 then
            if Sysutils.SameText(popupform.classname , 'TfmMarketing') then
                Popupform.KeyId := qryMain.Fieldbyname('FollowupId').asInteger;
        if not AssignKeyIdDone then begin
            AssignKeyIdDone := true;
            s := '';
            if Sysutils.SameText(frmPopup.classname , 'TfmMarketingLead')  then s := 'TfmMarketing'
            else if Sysutils.SameText(frmPopup.classname , 'TfmMarketing') then s := 'TfmMarketingLead';
            if s <> '' then begin
                if frmpopup.KeyId = 0 then begin
                    frmPopup := TBaseInputGUI(getcomponentbyclassname(s , true));
                    if not(Assigned(frmPopup)) then exit;
                    AssignKeyID(frmPopup);
                end;
            end;
        End;
    end else if (Sysutils.SameText(FormFact.Identifier , 'company')) or
                (Sysutils.SameText(FormFact.Identifier , 'FirstName')) or
                (Sysutils.SameText(FormFact.Identifier , 'MiddleName')) or
                (Sysutils.SameText(FormFact.Identifier , 'LastName')) then begin
        Popupform.KeyId := Qrymain.Fieldbyname('Id').asInteger
    end else inherited;
end;

procedure TBaseMarketingContactListGUI.grdMainDblClick(Sender: TObject);
begin
    AssignKeyIdDone := False;
    inherited;
end;

end.
