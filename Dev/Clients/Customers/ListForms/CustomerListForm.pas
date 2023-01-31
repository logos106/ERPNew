unit CustomerListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/05/05  1.00.01 BJ   GlobalRef Field is added to the grid as the first column
 18/07/05  1.00.02 BJ   Added a new property - ListJobOnly. When this is true,
                        the customers will be hidden and only job records will be
                        Shown in the grid. Also the customer related fields are
                        made invisible - though the fields can be made visible
                        thru Customize.
 07/09/05  1.00.03 IJB  Modified to use new filtering on bas input.
 04/01/06  1.00.04 BJ   refrence to the form variable - JObGUI - is removed.
 11/01/06  1.00.05 BJ   new button for the pool profile form.
 27/03/06  1.00.06 DSP  Class changes are now controlled by 'class change'
                        access levels.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, wwDialog, Wwlocate, SelectionDialog,
  ActnList, PrintDAT, ImgList, Menus, AdvMenus,   Buttons, DNMSpeedButton, Wwdbigrd,
  Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, wwdblook, wwcheckbox,
   Shader, kbmMemTable, BaseListDetails, DAScript, MyScript, Forms, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomerListGUI = class(TBaseListDetailsGUI)
    btnJob: TDNMSpeedButton;
    actNewJob: TAction;
    qryMainClientID: TAutoIncField;
    qryMainCompanyName: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainContactName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainTotalBalance: TCurrencyField;
    qryMainCreditLimit: TFloatField;
    qryMainGracePeriod: TWordField;
    qryMainStopCredit: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainStreet: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    N1: TMenuItem;
    Merge1: TMenuItem;
    Label4: TLabel;
    qryMainCreationDate: TDateField;
    qryMainStreet2: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainBillCountry: TWideStringField;
    CustomerJobBalance: TERPQuery;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainABN: TWideStringField;
    qryMainTerms2: TWideStringField;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label5: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    cboClassSrc: TDataSource;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainStreet3: TWideStringField;
    qryMainBillStreet3: TWideStringField;
    btnShowRelatedCustomersList: TDNMSpeedButton;
    qryMainMobile: TWideStringField;
    qryMainCardNumber: TWideStringField;
    qryMainContactdetails: TWideStringField;
    qryMainDefaultClass: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainSOBalance: TFloatField;
    qryMainRelatedClientID: TLargeintField;
    qryMainParentClientID: TLargeintField;
    qryMainParentRelatedClientID: TLargeintField;
    qryMainDontContact: TWideStringField;
    qryMainRelatedclients: TLargeintField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainprintjobname: TWideStringField;
    btnPrintAddressLabel: TDNMSpeedButton;
    procedure actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
    procedure actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
    procedure actMergeExecute(Sender: TObject);
    procedure actNewJobExecute(Sender: TObject);
    procedure actNewJobUpdate(Sender: TObject);
    procedure btnShowRelatedCustomersListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnPrintAddressLabelClick(Sender: TObject);
  private
    { Private declarations }
    fbListJobOnly: boolean;
    (*procedure MakeQRY(const Mode: string);*)
    LastSelectedClientID: integer;
    Procedure beforeshowSOList(Sender:TObject);
    procedure beforeshowAccountsPayList(Sender: TObject);
    procedure beforeshowAccountsReceiveList(Sender: TObject);
    procedure SendBulkSMS;
    procedure SendBulkEmail;
  protected
    procedure RefreshQuery; override;
    procedure SetupFormInPanel; override;
    Function ExpressDetailListName:String;Override;
    Procedure SetGridColumns;override;
  public
    property ListJobOnly: boolean read fbListJobOnly write fbListJobOnly;
  public
    { Public declarations }
  end;

implementation

uses
  frmJob, MergeObj, frmCustomerfrm, DnmLib,  CommonDbLib,
  AppContextObj, RelatedCustomerListForm, {tcMessaging,} MAIN, CommonLib,
  AccountsPayListForm,AccountsReceiveListForm,
  AppEnvironment, FastFuncs, dmMainGUI, tcDataUtils, CommonFormLib,
  SalesOrderListForm, UserUtilsClientObj, EmailUtils,
  tcConst, CorrespondenceObj, EmailExtraUtils;

{$R *.dfm}

procedure TCustomerListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  if ListJobOnly then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + ' IsJob = ''T'' ';
  end;
  inherited;

end;

procedure TCustomerListGUI.SetupFormInPanel;
begin
    inherited;
    Panel4.Visible := False;
end;
procedure TCustomerListGUI.RefreshQuery;
var
  iPos: integer;
begin
  if NOT chkAllClass.Checked then begin
      cboClassQry.Locate('ClassName', cboClass.LookupValue, [loCaseInsensitive]);
      Qrymain.Params.Parambyname('DefaultClass').asString := cboClassQryClassName.asString;
      (*MakeQRY('');*)
  end else begin
      Qrymain.Params.Parambyname('DefaultClass').asString := '';
      (*MakeQRY('All');*)
  end;

  inherited;
  iPos := GetGridColumnIndex(grdMain, 'JobName');
  if iPos > -1 then begin
    if AppEnv.CompanyPrefs.JobNameHeader <> '' then begin
      grdMain.ColumnByName('JobName').DisplayLabel := AppEnv.CompanyPrefs.JobNameHeader;
    end
  end;

  iPos := GetGridColumnIndex(grdMain, 'JobNumber');
  if iPos > -1 then begin
    if AppEnv.CompanyPrefs.JobNameHeader <> '' then begin
      grdMain.ColumnByName('JobNumber').DisplayLabel := AppEnv.CompanyPrefs.JobNumberHeader;
    end
  end;

end;

procedure TCustomerListGUI.cmdNewClick(Sender: TObject);
(*Var Form : TComponent;*)
begin
  (*DisableForm;
  try
    inherited;
    Form := FindExistingComponent('TfrmCustomer',0);
    if Assigned(Form) then
      TForm(Form).BringToFront
    else begin
      Form := GetComponentByClassName('TfrmCustomer');
      if Assigned(Form) then begin
        with TfrmCustomer(Form) do begin
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
  finally
    EnableForm;
  end;   *)
  OpenERPForm('TfrmCustomer', 0);
end;

procedure TCustomerListGUI.actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TCustomerListGUI.actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TCustomerListGUI.actNewJobExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
    with TJobGUI(GetComponentByClassName('TJobGUI')) do begin
      // For new JOB, JobGUI expects a negative clientID
      AttachObserver(Self);
      if ListJobOnly then
        KeyId := -(getClientID(CLIENT_WORKSHOP))
      else
        KeyID := -(qryMain.FieldByName('ClientID').AsInteger);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TCustomerListGUI.actNewJobUpdate(Sender: TObject);
begin
  inherited;
  actNewJob.Enabled := ((not (qryMain.FieldByName('IsJob').AsBoolean)) and
    (qryMain.FieldByName('ParentRelatedClientID').AsInteger = 0)) or (ListJobOnly = true);
end;

procedure TCustomerListGUI.grdMainDblClick(Sender: TObject);
begin
  if (grdMain.GetActiveField = qryMainARBalance) then begin
    OpenErpListform('TAccountsReceiveListGUI' , beforeshowAccountsReceiveList);
    Application.ProcessMessages;
  end else if (grdMain.GetActiveField = qryMainAPBalance) then begin
    OpenErpListform('TAccountsPayListGUI' , beforeshowAccountsPayList);
    Application.ProcessMessages;
 end else if (grdMain.GetActiveField = qryMainSOBalance) then begin
    OpenErpListform('TSalesOrderListGUI' , beforeshowSOList);
    Application.ProcessMessages;
 end else Begin
    AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
    // this allows us to open a customer form or job form according to the
    // .. value of IsJob
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
    inherited;
  end;
end;

procedure TCustomerListGUI.beforeshowAccountsReceiveList(Sender: TObject);
begin
  if not(sender is TAccountsReceiveListGUI) then exit;
  TAccountsReceiveListGUI(Sender).ARClientID := Self.qryMain.FieldByName('ClientID').AsInteger;
end;
procedure TCustomerListGUI.beforeshowAccountsPayList(Sender: TObject);
begin
  if not(sender is TAccountsPayListGUI) then exit;
  TAccountsPayListGUI(Sender).APClientID := Self.qryMain.FieldByName('ClientID').AsInteger;
end;
procedure TCustomerListGUI.beforeshowSOList(Sender: TObject);
begin
  if not(Sender is   TSalesOrderListGUI) then exit;
  TSalesOrderListGUI(Sender).clientId := Self.qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TCustomerListGUI.FormCreate(Sender: TObject);
Const PixelMove = 52;
begin
  //  fbUseFetchProgress:=True;
  inherited;
  LastSelectedClientID:= 0;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
  cboClassQry.Connection := qryMain.Connection;
  ListJobOnly := false;
  ShowChartViewOnPopup := True;
end;

procedure TCustomerListGUI.FormShow(Sender: TObject);
var
  strCaption: string;
begin
  btnSMS.Enabled := AppEnv.CompanyPrefs.SMSEnabled;
  CustomerJobBalance.Open;
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  chkAllClass.Checked := AppEnv.CompanyPrefs.AllClassesOnCustList;
  chkAllClass.Enabled := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClass') in [1, 2]);
  cboClass.Enabled := (not AppEnv.CompanyPrefs.AllClassesOnCustList) and
                      (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClass') in [1, 2]);

  If (not Assigned(OnGridDataSelect)) and Sysutils.SameText(AppEnv.CompanyPrefs.CustomerListMode,'Related') AND not FormStillOpen('TRelatedCustomerListGUI') then begin
    btnShowRelatedCustomersList.Click;
    Exit;
  end else Begin
    inherited;
  end;

  if Assigned(OnGridDataSelect) then
    btnShowRelatedCustomersList.Enabled := false;

  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ParentClientId,ParentRelatedClientID'); 


  if ListJobOnly then begin
    GroupFilterString := 'IsJob = ''T'' ';
    ApplyQueryFilter;
    if AppContext['Job'].VarExists('Caption') then strCaption := AppContext['Job'].VarByname['Caption']
    else strCaption := 'Job';
    pnlHeader.Caption   := strCaption + ' List';
    Self.Caption        := ChangeFormCaption(strCaption + ' List', Self.Caption);
    grdMain.ColumnByName('RepairNo').DisplayLabel := strCaption + ' No';
    grpFilters.Items[0] := 'Active ' + strCaption;
    grpFilters.Items[1] := 'Done ' + strCaption;

    {repostioning the buttons }
    btnJob.Caption := 'New';
    cmdNew.Visible := false;

    btnCustomize.Left := 313;
    cmdExport.Left    := 448;
    cmdPrint.Left     := 583;
  end;
  if fbFormOpenedOk and not (Parent is TDNMPanel) then begin
    grpFiltersClick(Sender);
  end;
  qryMain.First;
end;

procedure TCustomerListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;
end;

procedure TCustomerListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
begin
  inherited;
  { The customer selected last is the one we will merge into ie the Principal }
  LastSelectedClientID := qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TCustomerListGUI.actMergeExecute(Sender: TObject);
var
  i: integer;
  MergeObj: TMergeObj;
  PrincipleName: string;
  PrincipleID, ParentClientID: integer;
  SecordaryName: string;
  SecordaryID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count > 1 then begin
    qryMain.DisableControls;
    if not qryMain.Locate('ClientID', LastSelectedClientID, [loCaseInsensitive]) then begin
      CommonLib.MessageDlgXP_Vista('Could not find the "merge into" record.' + PrincipleName, mtConfirmation, [mbOk], 0);
      exit;
    end;
    PrincipleName  := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
    PrincipleID    := qryMain.FieldByName('ClientID').AsInteger;
    ParentClientID := qryMain.FieldByName('ParentClientID').AsInteger;
    { first check that we are not trying to merge any Customers into their own Jobs }
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      if qryMain.FieldByName('ClientID').AsInteger <> PrincipleID then begin
        if qryMain.FieldByName('ClientID').AsInteger = ParentClientID then begin
          CommonLib.MessageDlgXP_Vista('Can''t Merge Customer "'+
            GetClientName(qryMain.FieldByName('ClientID').AsInteger) +
            '" into it''s own job "' + PrincipleName + '"!', mtInformation, [mbOK], 0);
          exit;
        end;
      end;
    end;

    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to merge these customers into ' + PrincipleName, mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if qryMain.FieldByName('ClientID').AsInteger = PrincipleID then
          Continue;
        SecordaryName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
        SecordaryID := qryMain.FieldByName('ClientID').AsInteger;
        // Ensure there is only one user connected to the database.  That is You only!
        if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Customer') then begin
          try
            MergeObj := TMergeObj.Create;
            try
              MergeObj.Merge(mClient, PrincipleName, PrincipleID, SecordaryName, SecordaryID);
            finally
              MergeObj.Free;
            end;
          finally
            AppEnv.UtilsClient.UnlockLogon;
          end;
        end else begin
          if msg = USERS_IN_SYSTEM_MESSAGE then begin
            MainForm.GetCurrentUserCount;
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Customer';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end else begin
            MessageDlgXP_Vista('Unable to merge Customers.' +NL+NL+
                               //'Unable to Lock User Logon: ' + NL+
                               replacestr(msg , ',' , ','+NL), mtInformation, [mbOk], 0);
          end;
          break;
        end;
      end;
    end;
    grdMain.SelectedList.Clear;
    qryMain.EnableControls;
    CustomerJobBalance.Close;
    CustomerJobBalance.Open;
    UpdateMe;
  end else begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Customers.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TCustomerListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS ; ' + QuotedStr('JobName') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS';
  SecondaryIndexFieldNames := QuotedStr('JobName');
end;

procedure TCustomerListGUI.btnShowRelatedCustomersListClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TRelatedCustomerListGUI') then begin
    Form := GetComponentByClassName('TRelatedCustomerListGUI');
    if Assigned(Form) then begin
      with TRelatedCustomerListGUI(Form) do begin
          FormStyle :=fsMDIChild;
          BringToFront;
      end;
    end;
  end else TRelatedCustomerListGUI(FindExistingComponent('TRelatedCustomerListGUI')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TCustomerListGUI.btnSMSClick(Sender: TObject);
begin
  inherited;
  SendBulkSMS;
end;

procedure TCustomerListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClass') in [1, 2]);
  end;
  RefreshQuery;
end;

procedure TCustomerListGUI.cboClassCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;


procedure TCustomerListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustomerListGUI.btnEmailClick(Sender: TObject);
begin
  inherited;
  self.SendBulkEmail;
end;

procedure TCustomerListGUI.btnPrintAddressLabelClick(Sender: TObject);
var
  x: integer;
  RepName: string;
begin
  inherited;
  if grdMain.SelectedList.Count = 0 then exit;
  RepName := GetReportNameForTypeName('Client Ship Address');
  if RepName = '' then
    RepName := 'Client Ship Address Label';
  grdMain.BeginUpdate;
  try
    for x := 0 to grdMain.SelectedList.Count -1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList[x]);
      PrintTemplateReport(RepName,'~|||~ where ClientID = ' + IntToStr(qryMainClientID.AsInteger),true,1);
    end;
  finally
    grdMain.EndUpdate();
  end;
end;

procedure TCustomerListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustomerListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

function TCustomerListGUI.ExpressDetailListName: String;
begin
  REsult := 'TCustomerExpressListGUI'
end;

procedure TCustomerListGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustomerListGUI.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email',List,self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Customers in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Customers in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have an email address.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' customers?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send Email }
    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Customers]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtCustomer;
    if not EmailSilentSecret(List.Count, false, lSilent, lSecret)  then
      exit;
    Corres.Execute(lSilent, lSecret);

  finally
    Corres.Free;
    List.Free;
  end;
end;

procedure TCustomerListGUI.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List,self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Customers in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Customers in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' customers?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Customers]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtCustomer;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TCustomerListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
  RemoveFieldfromGrid('RelatedClientID');
end;

initialization
  RegisterClassOnce(TCustomerListGUI);
end.



