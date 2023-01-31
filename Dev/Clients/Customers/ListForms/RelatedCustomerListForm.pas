
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/05/05  1.00.01 BJ   GlobalRef Field is added to the grid as the first column
 18/07/05  1.00.02 BJ   Added a new property - ListJobOnly. When this is true,
                        the customers will be hidden and only job records will be
                        Shown in the grid. Also the customer related fields are
                        made invisible - though the fields can be made visible
                        thru Customize.
 07/09/05  1.00.03 IJB  Modified to use new filtering on base listing.
 }
unit RelatedCustomerListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, wwDialog, Wwlocate, SelectionDialog,
  ActnList, PrintDAT, ImgList, Menus, AdvMenus,   Buttons, DNMSpeedButton, Wwdbigrd,
  Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TRelatedCustomerListGUI = class(TBaseListingGUI)
    actNewJob: TAction;
    qryMainClientID: TAutoIncField;
    qryMainParentClientID: TIntegerField;
    qryMainCompanyName: TWideStringField;
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
    qryMainCreditLimit: TFloatField;
    qryMainGracePeriod: TWordField;
    qryMainTermsID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltContact: TWideStringField;
    qryMainPickingPriority: TIntegerField;
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
    qryTerms: TERPQuery;
    qryMainManufacture: TWideStringField;
    qryMainSerial: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainCreditCardType: TWideStringField;
    qryMainCreditCardNumber: TWideStringField;
    qryMainCreditCardExpiryDate: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCreditCardNotes: TWideStringField;
    qryMainABN: TWideStringField;
    qryMainRelatedCompany: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainParentRelatedClientID: TIntegerField;
    btnShowCustomerList: TDNMSpeedButton;
    btnJob: TDNMSpeedButton;
    qryMainDetails: TLargeintField;
    qryMainRelatedBalance: TFloatField;
    qryMainTotalBalance: TFloatField;
    chkshowrelatedonly: TwwCheckBox;
    Label5: TLabel;
    procedure actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
    procedure actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
    procedure actMergeExecute(Sender: TObject);
    procedure actNewJobExecute(Sender: TObject);
    procedure actNewJobUpdate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnShowCustomerListClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure chkshowrelatedonlyClick(Sender: TObject);
  private
    { Private declarations }
    fbListJobOnly: boolean;
    LastSelectedID: integer;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
    property ListJobOnly: boolean read fbListJobOnly write fbListJobOnly;
  end;

//var
//  RelatedCustomerListGUI: TRelatedCustomerListGUI;

implementation

uses
  frmJob, MergeObj, frmCustomerfrm, DnmLib,  CommonDbLib,
  AppContextObj, CustomerListForm, {tcMessaging,} MAIN, CommonLib, AppEnvironment,
  FastFuncs, dmMainGUI, tcDataUtils, UserUtilsClientObj, tcConst;

{$R *.dfm}

procedure TRelatedCustomerListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  RelatedCustomerListGUI := nil;
end;

procedure TRelatedCustomerListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  if ListJobOnly then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + ' IsJob = ''T'' ';
  end;
  if chkshowrelatedonly.Checked then begin
     if GroupFilterString <> '' then GroupFilterString := GroupFilterString +' and ';
     GroupFilterString := GroupFilterString + ' details = 2';
  end;
  inherited;

end;

procedure TRelatedCustomerListGUI.RefreshQuery;
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

procedure TRelatedCustomerListGUI.chkshowrelatedonlyClick(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

procedure TRelatedCustomerListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
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

procedure TRelatedCustomerListGUI.actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TRelatedCustomerListGUI.actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TRelatedCustomerListGUI.actNewJobExecute(Sender: TObject);
begin
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
end;

procedure TRelatedCustomerListGUI.actNewJobUpdate(Sender: TObject);
begin
  inherited;
  actNewJob.Enabled :=
    ((not (qryMain.FieldByName('IsJob').AsBoolean)) and (qryMain.FieldByName('ParentRelatedClientID').AsInteger = 0)) or
    (ListJobOnly = true);
end;

procedure TRelatedCustomerListGUI.grdMainDblClick(Sender: TObject);
begin
  //AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
  // this allows us to open a customer form or job form according to the
  // .. value of IsJob
  //SubsequentID := Chr(95) + qryMain.Fields.fieldbyname('IsJob').AsString;
  SubsequentID:='';
  if Sametext(ActiveFieldname , Qrymaincompanyname.fieldname) and (QrymainParentRelatedclientID.AsInteger <>0) then
    SubsequentID := Chr(95) + 'ParentCustomer';
  inherited;
end;

procedure TRelatedCustomerListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  fbIgnoreQuerySpeed := true;
  fbIgnoreAccessLevels := true;
  //  fbUseFetchProgress:=True;
  inherited;
  ListJobOnly := false;
  LastSelectedID:= 0;
end;

procedure TRelatedCustomerListGUI.FormShow(Sender: TObject);
var
  strCaption: string;
begin
  qryTerms.Open;
  {if ListJobOnly then begin
      with Qrymain do begin
          if Active then Close;
          Sql.Add(' and C.IsJob = ''T'' ');
          Open;
      end;

  end;}
  inherited;

  if ListJobOnly then begin
    //QryMain.Filter := 'IsJob = ''T'' ';
    //QryMain.Filtered := True;
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
end;

procedure TRelatedCustomerListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
begin
  inherited;
  LastSelectedID := qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TRelatedCustomerListGUI.actMergeExecute(Sender: TObject);
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
    qryMain.Locate('ClientID', LastSelectedID,[]);
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
    UpdateMe;
  end else begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Customers.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TRelatedCustomerListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('CompanyName') + ' ASC CIS';

  qryMain.AutoCalcFields:= true;
end;

procedure TRelatedCustomerListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;

  qryMain.AutoCalcFields:= false;
end;

procedure TRelatedCustomerListGUI.btnShowCustomerListClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TCustomerListGUI') then begin
    Form := GetComponentByClassName('TCustomerListGUI');
    if Assigned(Form) then begin
      with TCustomerListGUI(Form) do begin
          FormStyle :=fsMDIChild;
          BringToFront;
      end;
    end;
  end else TCustomerListGUI(FindExistingComponent('TCustomerListGUI')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TRelatedCustomerListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
end;

procedure TRelatedCustomerListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainDetails.asInteger = 1 then begin
        Afont.Color := clred;
  end;
end;

initialization
  RegisterClassOnce(TRelatedCustomerListGUI);
end.


