{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/12/05  1.00.01 MV   New JobListGUI

}

unit JobListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, wwDialog, Wwlocate, SelectionDialog,
  ActnList, PrintDAT, ImgList, Menus, AdvMenus,   Buttons, DNMSpeedButton, Wwdbigrd,
  Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TJobListGUI = class(TBaseListingGUI)
    btnJob: TDNMSpeedButton;
    actNewJob: TAction;
    qryMainClientID: TAutoIncField;
    qryMainParentClientID: TIntegerField;
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
    qryMainTermsID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainStopCredit: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltContact: TWideStringField;
    qryMainPickingPriority: TIntegerField;
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
    qryMainArea: TWideStringField;
    qryMainDischargeDate: TDateField;
    N1: TMenuItem;
    Merge1: TMenuItem;
    Label4: TLabel;
    qryMainCreationDate: TDateField;
    qryMainStreet2: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainBillCountry: TWideStringField;
    CustomerJobBalance: TERPQuery;
    qryTerms: TERPQuery;
    qryMainManufacture: TWideStringField;
    qryMainSerial: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainParentRelatedClientID: TIntegerField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainCreditCardType: TWideStringField;
    qryMainCreditCardNumber: TWideStringField;
    qryMainCreditCardExpiryDate: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCreditCardNotes: TWideStringField;
    qryMainABN: TWideStringField;
    btnShowRelatedCustomersList: TDNMSpeedButton;
    qryMainContactdetails: TWideStringField;
    qryMainWarrantyFinishDate: TDateTimeField;
    qryMainHoursTakenForJob: TFloatField;
    qryMainWarrantyPeriod: TFloatField;
    qryMainHours: TFloatField;
    qryMainClaimNumber: TWideStringField;
    qryMainStormLocation: TWideStringField;
    qryMainStormDate: TDateField;
    qryMainYear: TDateField;
    qryMainColour: TWideStringField;
    qryMainBodyType: TWideStringField;
    qryMainAssessorsName: TWideStringField;
    qryMainExcessAmount: TFloatField;
    qryMainCustomerJobNumber: TWideStringField;
    qryMainExpiryDate: TDateField;
    qryMainJobRegistration: TWideStringField;
    procedure actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
    procedure actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
    procedure actMergeExecute(Sender: TObject);
    procedure actNewJobExecute(Sender: TObject);
    procedure actNewJobUpdate(Sender: TObject);
    procedure btnShowRelatedCustomersListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    LastSelectedID: integer;
    fbListJobOnly: boolean;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    property ListJobOnly: boolean read fbListJobOnly write fbListJobOnly;
  public
    { Public declarations }
  end;

//var
//  JobListGUI: TJobListGUI;

implementation

uses
  frmJob, MergeObj, frmCustomerfrm, DnmLib,  CommonDbLib,
  AppContextObj, RelatedCustomerListForm, {tcMessaging,} MAIN, CommonLib,
  AppEnvironment, FastFuncs, dmMainGUI, tcDataUtils, UserUtilsClientObj, tcConst;

{$R *.dfm}

procedure TJobListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  JobListGUI := nil;
end;

procedure TJobListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  if ListJobOnly then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + ' IsJob = ''T'' ';
  end;
  inherited;
end;

procedure TJobListGUI.RefreshQuery;
var
  iPos: integer;
begin
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


procedure TJobListGUI.cmdNewClick(Sender: TObject);
var
  Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmCustomer');
  if Assigned(Form) then begin
    with TfrmCustomer(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TJobListGUI.actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TJobListGUI.actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TJobListGUI.actNewJobExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
  Form := GetComponentByClassName('TJobGUI');
  if Assigned(Form) then begin
    with TJobGUI(Form) do begin
      // For new JOB, JobGUI expects a negative clientID
      AttachObserver(Self);
      if ListJobOnly then
        KeyId := -(getClientID(CLIENT_WORKSHOP))
      else
        KeyID := -(qryMain.FieldByName('ClientID').AsInteger);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TJobListGUI.actNewJobUpdate(Sender: TObject);
begin
  inherited;
  actNewJob.Enabled := ((not (qryMain.FieldByName('IsJob').AsBoolean)) and
    (qryMain.FieldByName('ParentRelatedClientID').AsInteger = 0)) or (ListJobOnly = true);
end;

procedure TJobListGUI.grdMainDblClick(Sender: TObject);
begin
  AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
  // this allows us to open a customer form or job form according to the
  // .. value of IsJob
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
  inherited;
end;

procedure TJobListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  //  fbUseFetchProgress:=True;
  inherited;
  ListJobOnly := false;
  ShowChartViewOnPopup := True;
  LastSelectedID:= 0;
end;

procedure TJobListGUI.FormShow(Sender: TObject);
var
  strCaption: string;
begin
  CustomerJobBalance.Open;
  qryTerms.Open;
  {if ListJobOnly then begin
      with Qrymain do begin
          if Active then Close;
          Sql.Add(' and C.IsJob = ''T'' ');
          Open;
      end;

  end;}
  inherited;
  label4.top := 1;
  if not Empty(AppEnv.CompanyPrefs.JobNameHeader) then
    strCaption := AppEnv.CompanyPrefs.JobNameHeader
  else
    strCaption := 'Job';
  pnlHeader.Caption   := strCaption + ' List';
  Self.Caption        := ChangeFormCaption(strCaption + ' List', Self.Caption);
  if ListJobOnly then begin
    GroupFilterString := 'IsJob = ''T'' ';
    ApplyQueryFilter;

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
end;

procedure TJobListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;
end;

procedure TJobListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
begin
  inherited;
  LastSelectedID := qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TJobListGUI.actMergeExecute(Sender: TObject);
var
  i: integer;
  MergeObj: TMergeObj;
  PrincipleName: string;
  PrincipleID: integer;
  SecordaryName: string;
  SecordaryID: integer;
  ParentClientID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count > 1 then begin
    qryMain.DisableControls;
    qryMain.Locate('ClientID', LastSelectedID, []);
    PrincipleName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
    PrincipleID   := qryMain.FieldByName('ClientID').AsInteger;
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

    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to merge these Customers into ' + PrincipleName, mtConfirmation,
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
        end
        else begin
          if msg = USERS_IN_SYSTEM_MESSAGE then begin
            MainForm.GetCurrentUserCount;
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Customer';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end
          else begin
            MessageDlgXP_Vista('Unable to merge Customers, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          end;
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

procedure TJobListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS ; ' + QuotedStr('JobName') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS';
  SecondaryIndexFieldNames := QuotedStr('JobName');
end;

procedure TJobListGUI.btnShowRelatedCustomersListClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;

  if not FormStillOpen('TRelatedCustomerListGUI') then begin
    Form := GetComponentByClassName('TRelatedCustomerListGUI');
    if Assigned(Form) then begin
      with TRelatedCustomerListGUI(Form) do begin
          FormStyle := fsMDIChild;
          BringToFront;
      end;
    end;  
  end else TRelatedCustomerListGUI(FindExistingComponent('TRelatedCustomerListGUI')).Show;
  Self.Close;  
end;

procedure TJobListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
end;

initialization
  RegisterClassOnce(TJobListGUI);

finalization
  UnRegisterClass(TJobListGUI);

end.
