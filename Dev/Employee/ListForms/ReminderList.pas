unit ReminderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TReminderListGUI = class(TBaseListingGUI)
    qryEmployeeLookup: TERPQuery;
    chkAllEmployees: TCheckBox;
    cboEmployee: TwwDBLookupCombo;
    qryMainAutoID: TIntegerField;
    qryMainRecID: TIntegerField;
    qryMainID: TIntegerField;
    qryMainTYPE: TWideStringField;
    qryMainCreated: TDateField;
    qryMainDue: TDateField;
    qryMainDescription: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainClient: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainInDays: TWideStringField;
    qryMainProjectLineID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainTypeNo: TIntegerField;
    qryMainCompanyLabel: TWideStringField;
    qryMainDayName: TWideStringField;
    qryMainNOTES: TWideMemoField;
    qryMainDueTime: TDateTimeField;
    qryMainMarketingcontactID: TIntegerField;
    qryMainStatus: TWideStringField;
    qryEmployeeLookupEmployeeName: TWideStringField;
    qryEmployeeLookupEmployeeID: TIntegerField;
    qryMainContactId: TIntegerField;
    qryMainContactName: TWideStringField;
    qryMainSupportType: TWideStringField;
    pnlshowAllreminders: TDNMPanel;
    Label2: TLabel;
    chkshowAllreminders: TwwCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkshowAllremindersClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    tablename:String;
    function QueryRecordCount: boolean;
    procedure showEmployeeSkillPage(Sender: TObject);
    procedure showEmployeeSkillPageExpire(Sender: TObject);
    procedure showPhoneSupportcomments(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    class Function  PopulateTable(AllEmps:Boolean; EmployeeID:Integer):String;
    property IsAnyReminders: boolean read QueryRecordCount;
  end;


implementation

uses ReminderLib, CommonDbLib, CommonLib, AppEnvironment, frmFollowUp,
  CommonFormLib, frmEmployeeFrm, tcDataUtils, frmToDoFrm, DbSharedObjectsObj,
  Preferences, frmPhSupportLog, tcConst, frmERPClientEdit;

{$R *.dfm}

{ TReminderListGUI }

procedure TReminderListGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  chkAllEmployees.checked := qryEmployeeLookupEmployeeName.asString = '';
  RefreshQuery;
end;

procedure TReminderListGUI.chkAllEmployeesClick(Sender: TObject);
begin
  inherited;
  if chkAllEmployees.checked then cboEmployee.text := ''
  else if cboEmployee.text = '' then begin
      if qryEmployeeLookup.active = False then qryEmployeeLookup.open;
      if qryEmployeeLookupEmployeeName.asString = '' then qryEmployeeLookup.locate('employeeId', AppEnv.Employee.EmployeeId , []);
      cboEmployee.text := qryEmployeeLookupEmployeeName.asString;
  end;
  RefreshQuery;
end;

procedure TReminderListGUI.chkshowAllremindersClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkshowAllreminders then RefreshQuery;
end;

procedure TReminderListGUI.cmdNewClick(Sender: TObject);
var
  Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmToDo');
  if Assigned(Form) then begin //if has acess
    with TfrmToDo(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TReminderListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenPrefform('Employee' ,  'cbAppointments' , 0, False);
  CloseWait;
end;

procedure TReminderListGUI.FormCreate(Sender: TObject);
begin
  tablename := CreateUserTemporaryTable('tmp_reminderlist');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('select');
  Qrymain.SQL.add('T.*,');
  Qrymain.SQL.add(' e.employeeName as EmployeeName');
  Qrymain.SQL.add('from '+Tablename +' T ');
  Qrymain.SQL.add('inner join tblemployees E on T.Employeeid =E.EmployeeId ');
  Qrymain.SQL.add('order by Due ASC');
  inherited;
  qryEmployeeLookup.Open;

end;

procedure TReminderListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  CommonDbLib.DestroyUserTemporaryTable(tablename);
end;

procedure TReminderListGUI.FormShow(Sender: TObject);
begin
  inherited;
  pnlshowAllreminders.visible := Devmode;
  specialnote := '              Appointments : Double Click on the Client Name to open The Customer/Supplier/Prospect'+NL+
                 'Smart Order Approval To Do : Double Click on the Description to Open the Smart Order.'+NL+
                 'Double Click on any Other Field/Type To Open the Transaction.';
end;

procedure TReminderListGUI.grdMainDblClick(Sender: TObject);
var
  ClickedField: String;
  MCID:Integer;
  IsLead:Boolean;
  LeadID:Integer;
  formname:String;
  qry: TERPQuery;
  Procedure ShowtoDo;
    var
      aLinktype:String;
      aLinkID:Integer;
  begin
    {Dene - open the smart order from reminder list if the TOdo is a Smart Order to do}
    if sametext(ClickedField ,qryMainDescription.fieldname) then  begin
      ToDoLinktypenID(qrymainid.AsInteger ,aLinktype ,aLinkID);
      if sametext( aLinktype , 'Smart Order') and (aLinkID <> 0) then begin
        OpenErpForm('TSmartOrderGUI', aLinkID);
        exit;
      end;
    end;
    OpenErpForm('TfrmToDo', qrymainid.AsInteger);
  end;
begin
  ClickedField := grdMain.GetActiveField.FieldName;
  if SameText(ClickedField,'Notes') then begin
    exit;
  end;

  //######## Open Listing #####################

  // Follow-Up (Client or Contact)
  if SameText(qryMain.FieldByName('Type').AsString , 'Sales Overdue') then begin
    OpenERPListForm('TOverdueInvoicesGUI' );
    Exit;
  end;

  if SameText(qryMain.FieldByName('Type').AsString , 'Employee Skill Renewal') then
    if qrymainclientID.asInteger >0 then begin
      OpenERPForm('TfrmEmployee' , qryMainEmployeeID.asInteger , showEmployeeSkillPage);
      Exit;
    end;
  if SameText(qryMain.FieldByName('Type').AsString , 'Employee Skill Expiry') then
    if qrymainclientID.asInteger >0 then begin
      OpenERPForm('TfrmEmployee' , qrymainID.asInteger , showEmployeeSkillPageExpire);
      Exit;
    end;
  if grdMain.GetActiveField.FieldName = 'Type' then begin
    if (qryMain.FieldByName('Type').AsString = 'FollowUpO') or (qryMain.FieldByName('Type').AsString = 'FollowUpS') then begin
      frmFollowUp.DoFollowUp(0, qryMain.FieldByName('Id').AsInteger);
      Exit;
    end;
  end;

  if SameText(Qrymaintype.AsString  , 'PO - BO To Receive') or SameText(Qrymaintype.AsString  , 'Back Orders To Receive') then begin
      OpenERPForm('TPurchaseGUI' , QrymainId.AsInteger);
      Exit;
  end;

  {dene: double click on in days should open the marketing contact form if exists}
  if Sysutils.SameText(grdMain.GetActiveField.FieldName , 'In Days') then begin
    if Sysutils.SameText(qryMainType.asString , 'Marketing Contact FollowUp') or
        Sysutils.SameText(qryMainType.asString , 'Lead FollowUp') or
      Sysutils.SameText(qryMainType.asString , 'Lead') then begin
        grdMain.SetActiveField('type');
        SubsequentID := Chr(95) + qryMainType.asString;
        inherited;
        exit;
    end;

    if QrymainClientID.asInteger > 0 then begin
      MarketingContactDetails(QrymainClientID.asInteger , MCID,IsLead,LeadID);
      if LeadID <> 0 then begin
        if ISLead then formname := 'TfmMarketingLead' else formname := 'TfmMarketing';
        if OpenERPForm(formname , LeadID) then exit;
      end;
    end;
  end;

  if qryMain.FieldByName('Type').AsString = 'Fixed Asset Warranty due to Expire' then begin
    //OpenERPForm('TFixedAssetGUI' , QrymainID.asInteger);
    OpenERPForm('TfmFixedAsset' , QrymainID.asInteger);
    Exit;
  end;

  if qryMain.FieldByName('Type').AsString = 'Expense Claim' then begin
    OpenERPForm('TfmExpenseClaim' , QrymainID.asInteger);
    Exit;
  end;

  if SameText(qryMain.FieldByName('Type').asString, 'Support') and (qryMain.FieldByName('typeno').AsInteger = 8) then begin
    OpenErpForm('TfrmToDo', qrymainid.AsInteger);
    exit;
  end;
  if SameText(qryMain.FieldByName('Type').asString, 'ToDo')  then begin
    Showtodo;
    exit;
  end;

  if SameText(qryMain.FieldByName('Type').asString, 'Support') then
  begin
    OpenErpForm('TPhSupportLogGUI', qrymainid.AsInteger);
    exit;
  end;

  if qryMain.FieldByName('Type').AsString = 'Received Back Orders' then begin
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Text := 'select * from tblsales where saleid = ' + IntToStr(QrymainID.asInteger);
      qry.Open;
      if qry.FieldByName('IsSalesOrder').AsBoolean then
        OpenERPForm('TSalesOrderGUI' , QrymainID.asInteger)
      else if qry.FieldByName('IsInvoice').AsBoolean then
        OpenERPForm('TInvoiceGUI' , QrymainID.asInteger)
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
    Exit;
  end;
  if qryMain.FieldByName('Type').AsString = 'Support-Comments' then begin
    OpenErpForm('TPhSupportLogGUI', qrymainid.AsInteger , showPhoneSupportcomments);
    exit;
  end;
  if qryMain.FieldByName('Type').AsString = 'ERP License Expire' then begin
    //openERPForm('TfmERPClientEdit' , Qrymainclientid.asInteger); // this function wont work as frmclientEdit is not registered, not sure y.
    with TfmERPClientEdit.Create(Application) do begin
      KeyID := qryMainClientId.AsInteger;
      AttachObserver(self);
      FormStyle := fsMDIChild;
      BringToFront;
      Highlightcontrol(dtpExpireDate);
    end;

    Exit;
  end;


  if Sysutils.SameText(qryMain.FieldByName('Type').AsString,'Appointment') AND Sysutils.SameText(ClickedField,'Client') Then Begin
    SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString) +  CommonDbLib.GetCompanyType(qryMain.FieldByName('ClientID').AsInteger);
  end else Begin
    SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString);
  end;
  inherited;
end;

class function TReminderListGUI.PopulateTable(AllEmps: Boolean;EmployeeID: Integer): String;
var
  tableName:string;
begin
    if AllEmps  then
        Tablename := PopulateReminders(tablename, Date - iif(Appenv.Employee.ListDaysPast=0 , 14, Appenv.Employee.ListDaysPast) ,
                                                  Date + Appenv.Employee.ListDaysFuture, 0   )
    else
        tablename := PopulateReminders(tablename, Date - iif(Appenv.Employee.ListDaysPast=0 , 14, Appenv.Employee.ListDaysPast) ,
                                                  Date + Appenv.Employee.ListDaysFuture , EmployeeID );
    REsult := Tablename
end;

function TReminderListGUI.QueryRecordCount: boolean;
begin
  qryPersonalPrefs.Close;
  qryPersonalPrefs.Params.Parambyname('EmployeeID').asInteger := AppEnv.Employee.EmployeeId;
  qryPersonalPrefs.open;
  ReadnApplyGuiPrefExtra;
  // Set From & To dates provided that they have not been set externally
  if not fbDateRangeSupplied then begin
    dtFrom.Date := 0;
    if qryPersonalPrefs.RecordCount = 1 then begin
      dtTo.Date := Date + qryPersonalPrefs.FieldByName('ListDaysFuture').asInteger;
      dtFrom.Date := Date - qryPersonalPrefs.FieldByName('ListDaysPast').asInteger;
    end else begin
      dtTo.Date := Date + 0;
      dtFrom.Date := Date - 14;
    end;
  end;
  CleanFromDate := dtFrom.Date;
  CleanTodate := dtTo.Date;
  RefreshQuery;
  qryMain.Close;
  qryMain.SQL.Text := StringReplace(qryMain.SQL.Text,'Limit 0','',[rfIgnoreCase]);
  qryMain.Open;
  Result := (qryMain.RecordCount <> 0);
end;

procedure TReminderListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkAllEmployees.checked := GuiPrefs.Node['Grpfilters.AllEmployees'].AsBoolean;
  if not devmode then chkshowAllreminders.checked := False  else chkshowAllreminders.checked := GuiPrefs.Node['Grpfilters.showAllreminders'].AsBoolean;

  if GuiPrefs.Node['Grpfilters.Employee'].AsString <> '' then begin
    cboEmployee.LookupTable.Locate(cboEmployee.LookupField,GuiPrefs.Node['Grpfilters.Employee'].AsString,[loCaseInsensitive]);
    cboEmployee.Text := GuiPrefs.Node['Grpfilters.Employee'].AsString;
  end
  else begin
    cboEmployee.LookupTable.Locate(cboEmployee.LookupField,AppEnv.Employee.EmployeeName,[loCaseInsensitive]);
    cboEmployee.Text := AppEnv.Employee.EmployeeName;
  end;
end;

procedure TReminderListGUI.RefreshQuery;
begin
  if not tableExists(tablename, TERPConnection(qrymain.connection)) then begin
    MessageDlgXP_Vista('System Maintainance has Deleted the Temprary Table Used for the List.  Please Close and Re-open the Reminders List.' , mtWarning, [mbOK], 0);
    Exit;
  end;
    if chkAllEmployees.checked then
        tablename := PopulateReminders(tablename, filterdateFrom , filterdateTo, 0, not chkIgnoreDates.Checked , devmode and chkshowAllreminders.checked )
    else
        tablename := PopulateReminders(tablename, filterdateFrom , filterdateTo, qryEmployeeLookup.fieldByname('EmployeeID').asInteger, not chkIgnoreDates.Checked , devmode and chkshowAllreminders.checked );
  try
    inherited;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;

end;
procedure TReminderListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAUTOID.fieldname);
  RemoveFieldfromGrid(qryMainRECID.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainCLIENTID.fieldname);
  RemoveFieldfromGrid(qryMainEMPLOYEEID.fieldname);
  RemoveFieldfromGrid(qryMainTYPENO.fieldname);
  RemoveFieldfromGrid(qryMainDAYNAME.fieldname);
  RemoveFieldfromGrid(qryMainDueTime.fieldname);
  RemoveFieldfromGrid(qryMainMarketingcontactID.fieldname);
  RemoveFieldfromGrid(qryMainContactID.fieldname);
  RemoveFieldfromGrid(qryMainProjectLineID.fieldname);
end;

procedure TReminderListGUI.showEmployeeSkillPage(Sender: TObject);
begin
  if not(Sender is TfrmEmployee) then exit;
  TfrmEmployee(Sender).LocateSkill(QrymainProjectLineID.AsInteger , 'RenewalDate');
end;

procedure TReminderListGUI.showEmployeeSkillPageExpire(Sender: TObject);
begin
  if not(Sender is TfrmEmployee) then exit;
  TfrmEmployee(Sender).LocateSkill(QrymainProjectLineID.AsInteger , 'SkillExpDate');
end;
procedure TReminderListGUI.showPhoneSupportcomments(Sender: TObject);
begin
  if QrymainProjectLineID.AsInteger = 0 then exit;
  if not(Sender is TPhSupportLogGUI) then exit;
  TPhSupportLogGUI(Sender).LocateLine(QrymainProjectLineID.AsInteger);
end;

procedure TReminderListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Grpfilters.AllEmployees'].asBoolean := chkAllEmployees.checked;
  GuiPrefs.Node['Grpfilters.Employee'].AsString := cboEmployee.LookupTable.FieldByName(cboEmployee.LookupField).AsString;
  GuiPrefs.Node['Grpfilters.showAllreminders'].asBoolean := chkshowAllreminders.checked;
end;

initialization
  RegisterClassOnce(TReminderListGUI);

end.
