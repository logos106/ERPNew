unit MarketingContactListDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, 
  BaseMarketingContactList, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TMarketingContactListDetailGUI = class(TBaseMarketingContactListGUI)
    qryMainDateEntered: TDateTimeField;
    qryMainGlobalRef: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainUpdateDate: TDateTimeField;
    qryMainActionRef: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainAction: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainResultTypeName: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainISLEad: TWideStringField;
    qryMainID: TIntegerField;
    qryMainLeadId: TLargeintField;
    qryMainFollowupId: TLargeintField;
    qryMainActionDate: TDateTimeField;
    qryMainTMId: TLargeintField;
    qryMainEmail: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  Protected
    (*Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;*)
    Procedure SetGridColumns;override;
  public
    procedure RefreshQuery; override;
  end;

implementation

uses BaseFormForm, Commonlib,systemlib, MarketingContactList,
  frmMarketingContact, BaseInputForm, BaseListingForm, tcConst,
  FastFuncs;

{$R *.dfm}
(*Procedure TMarketingContactListDetailGUI.AssignKeyId(Popupform :TBaseInputGUI);
begin
    Popupform.KeyId := 0;
    if Sysutils.SameText(FormFact.Identifier, 'FollowupDate') then begin
        if qryMainISLead.asBoolean = true then begin
            if Sysutils.SameText(popupform.classname , 'TfmMarketingLead') then
                Popupform.KeyId := qryMainLeadid.asInteger;
        end else
            if Sysutils.SameText(popupform.classname , 'TfmMarketing') then
                Popupform.KeyId := qryMainLeadid.asInteger;
    end else if (Sysutils.SameText(FormFact.Identifier , 'Company'))
            or (Sysutils.SameText(FormFact.Identifier , 'LastName'))
            or (Sysutils.SameText(FormFact.Identifier , 'FirstName')) then begin
        Popupform.KeyId := qryMainid.asInteger;
    end else inherited;
end;*)
procedure TMarketingContactListDetailGUI.RefreshQuery;
begin
    DonotChangeGridLabels := True;
    if Self.ErrorOccurred then Exit;
    qryMain.parambyname('FilterOnDate').asString := BooleanToStr(chkIgnoreDates.Checked);
    qryMain.parambyname('DateFrom').asDatetime :=FilterDateFrom;
    qryMain.parambyname('Dateto').asDatetime :=FilterDateto;
    inherited;
end;
procedure TMarketingContactListDetailGUI.grpFiltersClick(Sender: TObject);
begin
(*var
    Form :TComponent;
begin
    if grpFilters.itemindex = 0 then exit;
  if not FormStillOpen('TMarketingContactGUI') then begin
    Form := GetComponentByClassName('TMarketingContactGUI');
    if Assigned(Form) then begin
      with TMarketingContactGUI(Form) do begin
          FormStyle :=fsMDIChild;
          if TMarketingContactGUI(Form).Qrymain.Locate('ID' , QrymainID.asInteger , []) then
            TMarketingContactGUI(Form).GrdMain.refresh;
          BringToFront;
      end;
    end;
  end else TBaseListingGUI(FindExistingComponent('TMarketingContactGUI')).show;
  Application.ProcessMessages;
  Self.Close;*)
end;

procedure TMarketingContactListDetailGUI.cmdNewClick(Sender: TObject);
var
    Form :TComponent;
begin
  inherited;
 Form := GetComponentByClassName('TfmMarketingContact');
  if Assigned(Form) then begin
    with TfmMarketingContact(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TMarketingContactListDetailGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Dateentered');
  RemoveFieldfromGrid('Globalref');
  RemoveFieldfromGrid('LeadId');
  RemoveFieldfromGrid('Id');
  RemoveFieldfromGrid('UpdateDate');
  RemoveFieldfromGrid('FollowupID');
end;

procedure TMarketingContactListDetailGUI.grdMainDblClick(Sender: TObject);
begin
  if Sysutils.SameText(TwwDBGrid(Sender).GetActiveField.fieldname, 'Notes') then exit;
  if qryMainISLEad.AsBoolean then SubsequentID :='_Lead' else SubsequentID :='_Telemarketing';
  inherited;
end;

initialization
  RegisterClassOnce(TMarketingContactListDetailGUI);

end.
