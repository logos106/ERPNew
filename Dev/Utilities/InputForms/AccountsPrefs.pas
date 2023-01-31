unit AccountsPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  MemDS, wwcheckbox, wwdblook, Wwdotdot, Wwdbcomb, Mask, wwdbedit,
  ExtCtrls, DNMPanel, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  wwdbdatetimepicker, DateUtils, Wwdbspin , BasePrefs, frmBase,
  wwclearbuttongroup, wwradiogroup, Menus,TransactionsTable, AdvScrollBox,
  HTMLabel, AccountsPrefsHMRC, AccountsPrefsVAT;

type
  TAccountsPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryClass: TERPQuery;
    dsColumnHeadings: TDataSource;
    qryColumnHeadings: TERPQuery;
    dsAccountTypes: TDataSource;
    qryAccountTypes: TERPQuery;
    qryTerms: TERPQuery;
    QryTermsCreditCheckTermsInv: TERPQuery;
    QrytermsCreditCheckTermsSO: TERPQuery;
    pnlClosingDates: TDNMPanel;
    Bevel2: TBevel;
    lblPanelCaption_ClosingDates: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    cboGlobal: TwwDBDateTimePicker;
    cboAccountsRec: TwwDBDateTimePicker;
    cboAccountsPay: TwwDBDateTimePicker;
    cboSummarisedTransDate: TwwDBDateTimePicker;
    btnRefresh: TDNMSpeedButton;
    wwDBEdit12: TwwDBEdit;
    btnSetToStart: TDNMSpeedButton;
    chkDisableAutoUpdateclosingDate: TwwCheckBox;
    wwDBSpinEdit1: TwwDBSpinEdit;
    btnSetToCurrent: TDNMSpeedButton;
    pnlNewUserDefaults: TDNMPanel;
    Bevel3: TBevel;
    Shape1: TShape;
    lblPanelCaption_DefaultValuesForNewCustomer: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    chkCreditCheckPO: TwwCheckBox;
    chkCreditcheckPOIncludeBO: TwwCheckBox;
    chkPreventInvoiceOnStopCredit: TwwCheckBox;
    chkPreventSalesOrderOnStopCredit: TwwCheckBox;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    pnlBudget: TDNMPanel;
    Bevel9: TBevel;
    lblPanelCaption_Budget: TLabel;
    wwCheckBox10: TwwCheckBox;
    pnlBASAccountingMethod: TDNMPanel;
    Bevel10: TBevel;
    lblPanelCaption_BAS: TLabel;
    wwRadioGroup1: TwwRadioGroup;
    chkIncludeJournalsInCashBAS: TwwCheckBox;
    pnlGeneral: TDNMPanel;
    Bevel1: TBevel;
    lblPanelCaption_General: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBComboBox1: TwwDBComboBox;
    wwDBLookupCombo1: TwwDBLookupCombo;
    chkShowOnlyActiveClass: TwwCheckBox;
    chkDefaultToTreeView: TwwCheckBox;
    chkForcePriceUpdateOnMemsTrans: TwwCheckBox;
    grdAccountTypes: TwwDBGrid;
    btnTenderAccounts: TDNMSpeedButton;
    wwDBSpinEdit2: TwwDBSpinEdit;
    wwCheckBox11: TwwCheckBox;
    chkShowAccountNumbers: TwwCheckBox;
    wwDBEdit13: TwwDBEdit;
    pnlAccountComboSettings: TDNMPanel;
    Bevel11: TBevel;
    lblPanelCaption_AccountComboDropdownWidths: TLabel;
    lblProductName: TLabel;
    lblProductfirstcolumn: TLabel;
    lblProductSecondcolumn: TLabel;
    lblProductcomboWidthHint: TLabel;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    Label36: TLabel;
    pnlItrastat: TDNMPanel;
    Bevel12: TBevel;
    lblPanelCaption_IntraStat: TLabel;
    wwCheckBox12: TwwCheckBox;
    qryAccount: TERPQuery;
    DNMPanel1: TDNMPanel;
    wwDBLookupCombo5: TwwDBLookupCombo;
    Label1: TLabel;
    Label6: TLabel;
    Bevel4: TBevel;
    QryDebitTerms: TERPQuery;
    pnlVS1: TDNMPanel;
    Bevel5: TBevel;
    Label12: TLabel;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    procedure btnTenderAccountsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cboGlobalCloseUp(Sender: TObject);
    procedure wwDBComboBox1CloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure qryColumnHeadingsAfterPost(DataSet: TDataSet);
    procedure wwDBLookupCombo1BeforeDropDown(Sender: TObject);
    procedure cboSummarisedTransDateEnter(Sender: TObject);
    procedure btnRefreshEnter(Sender: TObject);
    procedure chkCreditcheckPOIncludeBOEnter(Sender: TObject);
    procedure chkCreditCheckPOClick(Sender: TObject);
    procedure chkCreditcheckPOIncludeBOClick(Sender: TObject);
    procedure pnlClosingDatesDblClick(Sender: TObject);
    procedure btnSetToStartClick(Sender: TObject);
    procedure wwRadioGroup1Change(Sender: TObject);
    procedure pnlclosingdatesEnter(Sender: TObject);
    procedure btnSetToCurrentClick(Sender: TObject);
    procedure qryAccountTypesAfterPost(DataSet: TDataSet);
  private
    fRunOnce: Boolean;
    fDoingSummarisedTransDateChange: boolean;
    cleanDefaultclass:String;
    CleanSummarisedTransDate:TDateTime;
    //CleanProductAvgcostCalculatedForDepartment :Boolean;
    fbChangingallClosingdate:Boolean;
    PrefsHMRC: TAccountsPrefsHMRCGUI;
    PrefsVAT: TAccountsPrefsVATGUI;
    procedure PrefsAfterOpen(DataSet: TDataSet);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure ClosingDateChange(Sender: TField);
    procedure SummarisedTransDateChange(Sender: TField);
    procedure DoClosingdateRefresh(Sender: TField;TransactionTableObj: TTransactionTableObj);
    Procedure DoTransactionTableObjBeforeScriptExecute(Sender: TObject; var SQL: string;var Omit: Boolean);
    procedure InitPanelOrder;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  DNMLib,  {tcMessaging,} SelectionDialog,
  CommonLib, AppEnvironment, dmMainGUI, UserUtilsClientObj, tcTypes, tcConst,
  CommonFormLib, LogLib, CommonDbLib, PreferenceLib, PreferancesLib , UtilsLib;

{$R *.dfm}

{ TAccountsPrefsGUI }


procedure TAccountsPrefsGUI.pnlClosingDatesDblClick(Sender: TObject);
begin
  inherited;
    MessageDlgXP_Vista(pnlclosingdates.hint, mtInformation, [mbOK], 0 , nil , '' , '' , False , nil , '' , '' , 700);
end;

procedure TAccountsPrefsGUI.pnlclosingdatesEnter(Sender: TObject);
begin
  inherited;
  CleanSummarisedTransDate :=dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime ;
  //CleanProductAvgcostCalculatedForDepartment :=chkProductAvgcostCalculatedForDepartment.Checked;
end;


procedure TAccountsPrefsGUI.btnRefreshEnter(Sender: TObject);
begin
  inherited;
  if CleanSummarisedTransDate =0 then
   CleanSummarisedTransDate :=dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime ;
end;

procedure TAccountsPrefsGUI.btnSetToCurrentClick(Sender: TObject);
var
  dt:TDatetime;
begin
  inherited;
  fbChangingallClosingdate:=true;
  try
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SummarisedTransDateChanged').AsDateTime := Now;
    dt:= incyear(dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime          , 10); if dt > cboGlobal.maxdate               then dt:= cboGlobal.maxDate             ;dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime        := dt;
    dt:= incyear(dsPrefs.DataSet.FieldByName('ClosingDateAR').AsDateTime        , 10); if dt > cboAccountsRec.maxdate          then dt:= cboAccountsRec.maxDate        ;dsPrefs.DataSet.FieldByName('ClosingDateAR').AsDateTime      := dt;
    dt:= incyear(dsPrefs.DataSet.FieldByName('ClosingDateAP').AsDateTime        , 10); if dt > cboAccountsPay.maxdate          then dt:= cboAccountsPay.maxDate        ;dsPrefs.DataSet.FieldByName('ClosingDateAP').AsDateTime      := dt;
    dt:= incyear(dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime  , 10); if dt > cboSummarisedTransDate.maxdate  then dt:= cboSummarisedTransDate.maxDate;dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime:= dt;
  finally
    fbChangingallClosingdate:= False;
  end;
end;

procedure TAccountsPrefsGUI.btnSetToStartClick(Sender: TObject);
begin
  inherited;
  fbChangingallClosingdate:=true;
  try
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SummarisedTransDateChanged').AsDateTime := Now;
    dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime         := incyear(date, -10);
    dsPrefs.DataSet.FieldByName('ClosingDateAR').AsDateTime       := incyear(date, -10);
    dsPrefs.DataSet.FieldByName('ClosingDateAP').AsDateTime       := incyear(date, -10);
    dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime := incyear(date, -10);
  finally
    fbChangingallClosingdate:= False;
  end;
end;

procedure TAccountsPrefsGUI.btnTenderAccountsClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TTenderPrefsGUI');

  if not Assigned(tmpComponent) then
    Exit;

  with TForm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TAccountsPrefsGUI.ClosingDateChange(Sender: TField);
begin
  inherited;
  if fbChangingallClosingdate then exit;
  if not (csDestroying in ComponentState) then begin
    if not(dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime <= dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime)  then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime := dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime;
    end;

    if not(dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime <= dsPrefs.DataSet.FieldByName('ClosingDateAR').AsDateTime) then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('ClosingDateAR').AsDateTime := dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime;
    end;

    if not(dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime <= dsPrefs.DataSet.FieldByName('ClosingDateAP').AsDateTime) then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('ClosingDateAP').AsDateTime := dsPrefs.DataSet.FieldByName('ClosingDate').AsDateTime;
    end;
  end;
end;
Procedure TAccountsPrefsGUI.DoClosingdateRefresh(Sender: TField; TransactionTableObj: TTransactionTableObj);
var
  Msg:String;
begin
                msg := 'Changing Summarised Dates will Remain For Twenty Four Hours. '+NL+NL+
                             'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year';

                    if CommonLib.MessageDlgXP_Vista(Msg +NL+NL+ 'This Process May Take Several Minutes.'+NL+NL+'Are You Sure You Wish To Proceed ?',
                                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                        ShowUpdateBatchHint(Tform(Self.Owner));
                        try
                          AppEnv.CompanyPrefs.ClosingDateChangeDone:= false;
                          try
                            fRunOnce := True;
                            dsPrefs.SaveData;
                            if qryColumnHeadings.State in [dsEdit, dsInsert] then qryColumnHeadings.Post;
                            if qryAccountTypes.State in [dsEdit, dsInsert] then qryAccountTypes.Post;
                            if dsPrefs.Connection.InTransaction then dsPrefs.Connection.Commit;
                            TransactionTableObj.InitforRefreshTrnsTable;
                            dsPrefs.DataSet.Edit;
                            dsPrefs.DataSet.FieldByName('SummarisedTransDateChanged').AsDateTime := Now;
                            dsPrefs.DataSet.Post;
                            { need to reload company prefs so it gets
                              new SummarisedTransDate ... used by TransTableObj }
                            AppEnv.CompanyPrefs.PopulateMe;
                            TransactionTableObj.CleanRefreshTrnsTable(True, True,False , True);
                            TransactionTableObj.CreatePermanentSummaryTable;
                            TransactionTableObj.CleanRefreshTrnsTable(True, False, True, true);
                            LockPreferenceTable(Msg);
                          finally
                            AppEnv.CompanyPrefs.ClosingDateChangeDone:= true;
                          end;
                        finally
                          HideERPHint(Tform(Self.Owner));
                        end;
                        fRunOnce := False;
                    end else begin
                      dsPrefs.DataSet.Cancel;
                      dsPrefs.Active := False;
                      dsPrefs.Active := True;
                    end;
end;
procedure TAccountsPrefsGUI.DoTransactionTableObjBeforeScriptExecute(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  Logtext(wrappedSQLText(SQL), 'TransactionTableSQLs.Log');
end;

procedure TAccountsPrefsGUI.SummarisedTransDateChange(Sender: TField);
var
  TransactionTableObj: TTransactionTableObj;
  msg: string;
  function GetCurrentUserCount: Integer;
  var
    s: string;
  begin
    result:= -1;
    if AppEnv.UtilsClient.GetDatabaseUserList(s, AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true) then begin
      dtmMainGUI.dlgCurrentUsers.Items.CommaText:= s;
      Result := dtmMainGUI.dlgCurrentUsers.Items.Count;
    end;
  end;
  Procedure logLockLogon(const Value:String);
  begin
    application.ProcessMessages;
    with TempMyQuery(GetNewServicesConnection(Self)) do try
      SQL.Text := 'SELECT * FROM tbllogonlock';
      open;
      Logtext (Value +' -> tbllogonlock.count = ' + inttostr(recordcount)+' IDs - ' + GroupConcat('ID'));
    finally
      if active then close;
      Free;
    end;
  end;

begin
  inherited;
  if IsformClosing then exit;
  if fDoingSummarisedTransDateChange then exit;
  DoingProcess:= True;
  try
    DisableForm;
    Try
      fDoingSummarisedTransDateChange:= true;
      try
        TransactionTableObj := TTransactionTableObj.Create(False);
        try
          TransactionTableObj.BeforeScriptExecute := DoTransactionTableObjBeforeScriptExecute;
          if not(TransactionTableObj.Lock('Update Batch / Report')) then begin
            if Sender = dsPrefs.DataSet.findfield('SummarisedTransDate') then begin
              EditDb(dsPrefs.DataSet);
              dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime := CleanSummarisedTransDate;
              PostDB(dsPrefs.DataSet);
              ClosingDateChange(nil);
            end;
            exit;
          end;
          logtext('Update Batch / Report - Locked');

        try
            if (not fRunOnce) {and cboSummarisedTransDate.Modified} then begin
              if (Sender = dsPrefs.DataSet.findfield('SummarisedTransDate')) and (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClosingDate') <> 1) then begin
                CommonLib.MessageDlgXP_Vista('You don''t have access to ' + AppEnv.AccessLevels.GetFormDescription('FnChangeClosingDate'), mtInformation, [mbOK], 0);
                dsPrefs.DataSet.Cancel;
                Exit;
              end;

                if  (devmode ) or AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Closing Date Update') then begin
                  logLockLogon('UtilsClient locked');
                  try
                    DoClosingdateRefresh(Sender , TransactionTableObj);
                  finally
                    AppEnv.UtilsClient.UnlockLogon;
                    logLockLogon('UtilsClient -  unlocked');
                  end;
                end else begin
                  if msg = USERS_IN_SYSTEM_MESSAGE then begin
                    if GetCurrentUserCount > 0 then begin
                      dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Closing Date Update';
                      dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
                      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
                      dtmMainGUI.dlgCurrentUsers.Execute;
                    end else begin
                      MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
                    end;
                  end else begin
                    MessageDlgXP_Vista('Unable to Summarise Transactions, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
                  end;
                  EditDb(dsPrefs.DataSet);
                  dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime := CleanSummarisedTransDate;
                  ClosingDateChange(nil);
                end;
            end;
          finally
            TransactionTableObj.unLock('Update Batch / Report');
            logtext('Update Batch / Report - unLocked');
          end;
        finally
          FreeandNil(TransactionTableObj);
        end;
      finally
        fDoingSummarisedTransDateChange:= false;
      end;
    Finally
      Enableform;
    End;
  finally
    DoingProcess:= False;
    logLockLogon('UtilsClient Locks ');
  end;

  (*function GetCurrentUserCount: Integer;
  var
    s: string;
  begin
    result:= -1;
    if AppEnv.UtilsClient.GetDatabaseUserList(s, AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true) then begin
      dtmMainGUI.dlgCurrentUsers.Items.CommaText:= s;
      Result := dtmMainGUI.dlgCurrentUsers.Items.Count;
    end;
  end;

begin
  inherited;
  if IsformClosing then exit;
  if fDoingSummarisedTransDateChange then exit;
  DoingProcess:= True;
  try
    DisableForm;
    Try
      fDoingSummarisedTransDateChange:= true;
      try
        TransactionTableObj := TTransactionTableObj.Create(False);
        try
          if not(TransactionTableObj.Lock('Update Batch / Report')) then begin
            EditDb(dsPrefs.DataSet);
            dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime := CleanSummarisedTransDate;
            ClosingDateChange(nil);
            exit;
          end;

          try
            if (not fRunOnce) {and cboSummarisedTransDate.Modified} then begin
              if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClosingDate') <> 1 then begin
                CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s',
                           [AppEnv.AccessLevels.GetFormDescription('FnChangeClosingDate')]), mtInformation, [mbOK], 0);
                dsPrefs.DataSet.Cancel;
              end
              else begin

                if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Closing Date Update') then begin
                  try
                    if CommonLib.MessageDlgXP_Vista('Changing Summarised Dates will Remain For Twenty Four Hours. '+#13+#10+#13+#10+
                                  'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year'+#13+#10+#13+#10+
                                  'This Process May Take Several Minutes.'+#13+#10+#13+#10+'Are You Sure You Wish To Proceed ?',
                                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                        ShowUpdateBatchHint(Tform(Self.Owner));
                        try
                          AppEnv.CompanyPrefs.ClosingDateChangeDone:= false;
                          try
                            fRunOnce := True;
                            dsPrefs.SaveData;

                            if qryColumnHeadings.State in [dsEdit, dsInsert] then
                              qryColumnHeadings.Post;

                            if qryAccountTypes.State in [dsEdit, dsInsert] then
                              qryAccountTypes.Post;

                            if dsPrefs.Connection.InTransaction then
                              dsPrefs.Connection.Commit;

                            TransactionTableObj.InitforRefreshTrnsTable;

                            dsPrefs.DataSet.Edit;
                            dsPrefs.DataSet.FieldByName('SummarisedTransDateChanged').AsDateTime := Now;
                            dsPrefs.DataSet.Post;

                            { need to reload company prefs so it gets
                              new SummarisedTransDate ... used by TransTableObj }
                            AppEnv.CompanyPrefs.PopulateMe;
                            TransactionTableObj.CleanRefreshTrnsTable(True, True,False , True);
                            TransactionTableObj.CreatePermanentSummaryTable;
                            TransactionTableObj.CleanRefreshTrnsTable(True, False, True, true);
                          finally
                            AppEnv.CompanyPrefs.ClosingDateChangeDone:= true;
                          end;

                        finally
                          HideERPHint(Tform(Self.Owner));
                        end;

                      fRunOnce := False;
                    end
                    else begin
                      dsPrefs.DataSet.Cancel;
                      dsPrefs.Active := False;
                      dsPrefs.Active := True;
                    end;
                  finally
                    AppEnv.UtilsClient.UnlockLogon;
                  end;
                end
                else begin
                  if msg = USERS_IN_SYSTEM_MESSAGE then begin
                    if GetCurrentUserCount > 0 then begin
                      dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Closing Date Update';
                      dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
                      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
                      dtmMainGUI.dlgCurrentUsers.Execute;
                    end else begin
                      MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
                    end;
                  end else begin
                    MessageDlgXP_Vista('Unable to Summarise Transactions, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
                  end;
                  EditDb(dsPrefs.DataSet);
                  dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime := CleanSummarisedTransDate;
                  ClosingDateChange(nil);
                end;
              end;
            end;
          finally
            TransactionTableObj.unLock('Update Batch / Report');
          end;
        finally
          FreeandNil(TransactionTableObj);
        end;
      finally
        fDoingSummarisedTransDateChange:= false;
      end;
    Finally
      Enableform;
    End;
  finally
    DoingProcess:= False;
  end;*)
end;

procedure TAccountsPrefsGUI.FormCreate(Sender: TObject);
begin
  if devmode then pnlclosingdates.tabOrder := 0;
  pnlVS1.visible := (UtilsLib.HasVS1data(GetSharedMyDacConnection) or devmode );
  pnlVS1.taborder :=pnlclosingdates.taborder +1;
  inherited;
  fRunOnce := False;
  if Appenv.RegionalOptions.RegionType = rUK then
    lblPanelCaption_BAS.caption :='VAT : Default Accounting Method'
  else
    lblPanelCaption_BAS.caption :='BAS : Default Accounting Method';

  Label11.showhint := False;
  cboSummarisedTransDate.showhint := False;
  Label11.hint := 'Changing the closing date will reset it back to the beginning of the financial year and run a ''closing Date refresh'' when the application restarts  if: ' + Nl +Nl +
            ' (1) ''someone already not doing the batch update'' AND '+NL+
            '     ''No data prior to the ''Summarised Date'' currently Exists'' '+NL+NL+
            '                                                 OR '+NL+NL+
            AutochangeSumDtMsg(Dnmlib.GetCurrentFiscalYearStart, GetLastFiscalYearEnd(Now()), true);
  cboSummarisedTransDate.hint := label11.hint;

  chkDisableAutoUpdateclosingDate.visible := AppEnv.CompanyPrefs.IsClonedCopy;

  PrefsHMRC := TAccountsPrefsHMRCGUI.Create(self);
  PrefsHMRC.pnlHMRC.Parent := sbpanels;
  PrefsHMRC.pnlHMRC.TabOrder := 3;
  PrefsHMRC.Load;

  PrefsVAT := TAccountsPrefsVATGUI.Create(self);
  PrefsVAT.pnlVAT.Parent := sbpanels;
  PrefsVAT.pnlVAT.TabOrder := 4;
  PrefsVAT.Load(dsPrefs);

  InitPanelOrder;
end;

procedure TAccountsPrefsGUI.InitPanelOrder;
var
  sl: TStringList;
  I: Integer;

  procedure AddPanel(pnl: TDNMPanel);
  var
    x: Integer;
  begin
    for x := 0 to pnl.ControlCount -1 do begin
      if (pnl.Controls[x] is TLabel) and (Pos('lblPanelCaption_',TLabel(pnl.Controls[x]).Name) = 1) then begin
        sl.AddObject(TLabel(pnl.Controls[x]).Caption, pnl);
        break;
      end;
    end;
  end;

begin
  sl := TStringList.Create;
  try
    for I := 0 to ComponentCount -1 do begin
      if Components[I] is TDNMPanel then begin
        AddPanel(TDNMPanel(Components[I]));
      end;
    end;
    sl.Sort;
    for I := sl.Count -1 downto 0 do
      TDNMPanel(sl.Objects[I]).TabOrder := 0;

  finally
    sl.Free;
  end;
end;

procedure TAccountsPrefsGUI.btnRefreshClick(Sender: TObject);
begin
  clog('Closing Date refresh');
  SummarisedTransDateChange(nil);
  Logtext('Closing Date refresh... done');
end;

procedure TAccountsPrefsGUI.PrefsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsPrefs.Active then begin
    dsPrefs.DataSet.FieldByName('ClosingDateAP').OnChange := ClosingDateChange;
    dsPrefs.DataSet.FieldByName('ClosingDateAR').OnChange := ClosingDateChange;
    dsPrefs.DataSet.FieldByName('ClosingDate').OnChange := ClosingDateChange;
    dsPrefs.DataSet.FieldByName('SummarisedTransDate').OnChange := SummarisedTransDateChange;
  end;
end;

procedure TAccountsPrefsGUI.cboGlobalCloseUp(Sender: TObject);
begin
  inherited;
//  if cboGlobal.DateTime > cboSummarisedTransDate.DateTime then begin
//    CommonLib.MessageDlgXP_Vista('Global Date can not be earlier than the Summarised Transactions Before Date.', mtInformation, [mbOK], 0);
//    SetControlFocus(cboGlobal);
//  end;
end;

procedure TAccountsPrefsGUI.cboSummarisedTransDateEnter(Sender: TObject);
begin
  inherited;
  CleanSummarisedTransDate :=dsPrefs.DataSet.FieldByName('SummarisedTransDate').AsDateTime ;
end;

procedure TAccountsPrefsGUI.chkCreditCheckPOClick(Sender: TObject);
begin
  inherited;
(*  if not(chkCreditCheckPO.Checked) then
    if (Sender is twwCheckbox) and (twwCheckbox(Sender) = chkCreditCheckPO) then
      chkCreditcheckPOIncludeBO.Checked := False;*)
end;

procedure TAccountsPrefsGUI.chkCreditcheckPOIncludeBOClick(Sender: TObject);
begin
  inherited;
  (*if not(chkCreditCheckPO.Checked) then
    if (Sender is twwCheckbox) and (twwCheckbox(Sender) = chkCreditcheckPOIncludeBO) then begin
      chkCreditcheckPOIncludeBO.Checked := False;
    end;*)
end;

procedure TAccountsPrefsGUI.chkCreditcheckPOIncludeBOEnter(Sender: TObject);
begin
  inherited;
  if not(chkCreditCheckPO.Checked) then SetControlFocus(chkCreditCheckPO)
end;

procedure TAccountsPrefsGUI.wwDBComboBox1CloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  if not Sender.ReadOnly then begin
    if dsPrefs.DataSet.State in [dsInsert, dsEdit] then
      dsPrefs.DataSet.Post;
    dsPrefs.DataSet.Edit;
  end;
end;

procedure TAccountsPrefsGUI.qryAccountTypesAfterPost(DataSet: TDataSet);
begin
  inherited;
  PreferancesLib.DoPrefAuditTrail('The Order that Accounts Appear in Lists');
end;

procedure TAccountsPrefsGUI.qryColumnHeadingsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qryClass.Locate('ClassName' , qryColumnHeadings.fieldbyname('DefaultClass').AsString , []) then
    updateDefaultCalss(qryColumnHeadings.fieldbyname('DefaultClass').AsString , qryClass.fieldbyname('SiteCode').asString ,cleanDefaultclass , TERpConnection(dsPrefs.connection));
end;

procedure TAccountsPrefsGUI.wwDBLookupCombo1BeforeDropDown(
  Sender: TObject);
begin
  inherited;
  cleanDefaultclass := qryColumnHeadings.fieldbyname('DefaultClass').AsString;
end;

procedure TAccountsPrefsGUI.wwRadioGroup1Change(Sender: TObject);
begin
  inherited;
  chkIncludeJournalsInCashBAS.Enabled := wwRadioGroup1.ItemIndex = 1;
end;
procedure TAccountsPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
  if devmode then pnlclosingdates.top := 0;
end;

procedure TAccountsPrefsGUI.StartupProcess(var Msg: TMessage);
var
  tmpDate: TDate;
  s:String;
begin
  inherited;
  //btnSetToStart.visible := Devmode;
  fDoingSummarisedTransDateChange:= false;
  cboGlobal.MaxDate := IncDay(Now, -1);
  cboAccountsRec.MaxDate := IncDay(Now, -1);
  cboAccountsPay.MaxDate := IncDay(Now, -1);

  if (StartOfAMonth(YearOf(Now), 7) <= Now) and (Now <= EndOfAMonth(YearOf(Now()), 7)) then
    tmpDate := EndOfAMonth(YearOf(Now), 6)
  else
    tmpDate := Now;

  cboSummarisedTransDate.MaxDate := GetLastFiscalYearEnd(tmpDate);

  dsPrefs.DataSet.AfterOpen := PrefsAfterOpen;
  PrefsAfterOpen(dsPrefs.DataSet);

  s:= 'Next Batch update will automatically change the ''Summarise Trans Date'' to the current, if ' +Nl+
       AutochangeSumDtMsg(Dnmlib.GetCurrentFiscalYearStart, GetLastFiscalYearEnd(Now()), true) +NL;
  pnlclosingdates.hint     := s;
  pnlclosingdates.showhint := true;

//  chkHMRCActive.Checked := AppEnv.CompanyPrefs.HMRC_APIConfig.Active;
//  chkTestMode.Checked := AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode;
//  edtHMRCSandboxClientID.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID;
//  edtHMRCSandboxClientSecret.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret;
//
//  edtHMRCProductionClientID.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID;
//  edtHMRCProductionClientSecret.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret;
//
//  edtVATRegistrationNumber.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber;
end;
procedure TAccountsPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TAccountsPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryColumnHeadings.State in [dsEdit, dsInsert] then
    qryColumnHeadings.Post;

  if qryAccountTypes.State in [dsEdit, dsInsert] then begin
    qryAccountTypes.Post;
    PreferancesLib.DoPrefAuditTrail;
  end;

  PrefsHMRC.Save;

//  AppEnv.CompanyPrefs.HMRC_APIConfig.Active := chkHMRCActive.Checked;
//  AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode := chkTestMode.Checked;
//  AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID := edtHMRCSandboxClientID.Text;
//  AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret := edtHMRCSandboxClientSecret.Text;
//
//  AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID := edtHMRCProductionClientID.Text;
//  AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret := edtHMRCProductionClientSecret.Text;
//
//  AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber := edtVATRegistrationNumber.Text;
//  AppEnv.CompanyPrefs.HMRC_APIConfig.Save(dsPrefs.Connection);

end;

initialization
  RegisterClassOnce(TAccountsPrefsGUI);
finalization
  UnRegisterClass(TAccountsPrefsGUI);
end.
