unit CustomersOnSupportList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/01/06  1.00.01 IJB  Changed RefreshQuery and grpFiltersClick so that record
                        count is displayed correctly and form only does refresh
                        once during form show.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TCustomersOnSupportListGUI = class(TBaseListingGUI)
    qryMainClientID: TAutoIncField;
    qryMainCompany: TWideStringField;
    qryMainActiveUntil: TDateField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainStopCredit: TWideStringField;
    qryMainID: TIntegerField;
    qryMainCurrent: TBooleanField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainContactTitle: TWideStringField;
    qryMainContactFirstName: TWideStringField;
    qryMainContactLastName: TWideStringField;
    qryMainContactPhone: TWideStringField;
    qryMainContactAltPhone: TWideStringField;
    qryMainContactMobile: TWideStringField;
    qryMainContactId: TIntegerField;
    qryMainTeamviewerID: TWideStringField;
    qryMainIsPrimarycontact: TWideStringField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    procedure FilterQuery;
  protected
    procedure RefreshQuery; override;

  public
  end;

implementation

{$R *.dfm}

uses Forms, frmPhSupportPrintoutFrm, CommonLib,frmCustomerFrm,FastFuncs,
  CommonDbLib, tcDataUtils, BusObjClient, frmPhSupportLog;

procedure TCustomersOnSupportListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  if not Dataset.Active then Exit;
  inherited;
  qryMainID.AsInteger := -qryMainClientID.AsInteger;
  qryMainCurrent.AsBoolean := qryMainActiveUntil.AsDateTime >= Date;
end;

procedure TCustomersOnSupportListGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
  inherited;
end;

procedure TCustomersOnSupportListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientID,ID');
  if fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

procedure TCustomersOnSupportListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmPhSupportPrintout');
    if Assigned(Form) then begin
      with TfrmPhSupportPrintout(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TCustomersOnSupportListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;
end;

procedure TCustomersOnSupportListGUI.RefreshQuery;
begin
  Closedb(qryMain);
  FilterQuery;;
  inherited;
end;

procedure TCustomersOnSupportListGUI.FilterQuery;
begin
  case grpFilters.ItemIndex of
    0:qryMain.ParamByName('ActiveType').AsString := 'Active';
    1:qryMain.ParamByName('ActiveType').AsString := 'Inactive';
    2:qryMain.ParamByName('ActiveType').AsString := 'All';
  end;
end;

procedure TCustomersOnSupportListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TCustomersOnSupportListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustomersOnSupportListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustomersOnSupportListGUI.grdMainDblClick(Sender: TObject);
var
  Frm:TComponent;
  iClientID:integer;
  SupportLog: TPhSupportLogGUI;
  ContactId: integer;
begin
  if sametext(grdmain.GetActiveField.FieldName , QrymainPhone.FieldName) or
     sametext(grdmain.GetActiveField.FieldName , QrymainCompany.FieldName) or
     sametext(grdmain.GetActiveField.FieldName , QrymainMobile.FieldName) or
     sametext(grdmain.GetActiveField.FieldName , QrymainFaxNumber.FieldName) then begin
    iClientId := qryMain.FieldByName('ClientID').AsInteger;
    if FormStillOpen('TfrmCustomer') then TForm(FindExistingComponent('TfrmCustomer')).Close;
    Application.ProcessMessages;
    Frm := GetComponentByClassName('TfrmCustomer');
    if Assigned(Frm) then begin
      with TfrmCustomer(Frm) do begin
        KeyID := iClientID;
        ShowModal;
      end;
    end;
  end else begin
    ContactId := qryMainContactId.AsInteger;
//    if Clientcontactcount(qryMainClientID.asInteger) =0 then begin
    if ContactId = 0 then begin
      if MessageDlgXP_Vista(QrymainCompany.asString +' has no Contact.  Do You wish to Create the Primary Contact Automatically?' , mtconfirmation , [mbyes,mbno],0) = mrNo then exit;
      ContactId := TClient.MakeCustomerContact(QrymainclientID.asInteger , self);
      if ContactId = 0 then  Exit;
    end;
    SupportLog := TPhSupportLogGUI(GetComponentByClassName(TPhSupportLogGUI.ClassName, false));
    if Assigned(SupportLog) then begin
      SupportLog.KeyID :=  - qryMainClientID.AsInteger;
      SupportLog.ContactID := ContactId;
      SupportLog.AttachObserver(Self);
      SupportLog.FormStyle := fsMDIChild;
      SupportLog.BringToFront;
    end;
//    inherited;
  end;
end;

initialization
  RegisterClassOnce(TCustomersOnSupportListGUI);
end.

