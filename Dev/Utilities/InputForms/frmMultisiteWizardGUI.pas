unit frmMultisiteWizardGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ImgList,
  ComCtrls, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, ProgressTime,
  rwButtonArray, MiddleTier, MyAccess, Mask, DBCtrls, MemDS,
  DBAccess, SynchedThreads, wwdblook, wwdbedit, Wwdotdot, Wwdbcomb,
  DataState, ActiveX, Menus, AdvMenus, Shader;

type
  TMultisiteWizardGUI = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    DNMPanel1: TDNMPanel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageList1: TImageList;
    MTClient: TMTClient;
    dstblmsbackendid: TDataSource;
    tblcolumnheadings: TMyTable;
    tblcolumnheadingsClassHeading: TStringField;
    qrytblEmployees: TMyQuery;
    dstblEmployees: TDataSource;
    tblmsbackendid: TMyTable;
    tblmsbackendidSiteCode: TStringField;
    tblmsbackendidSiteDesc: TStringField;
    tblmsbackendidEmailAddressData: TStringField;
    tblmsbackendidEmailPassword: TStringField;
    tblmsbackendidConflictTodoUserId: TIntegerField;
    qrytblEmployeesEmployeeID: TIntegerField;
    CloneConnection: TMyConnection;
    CloneCommand: TMyCommand;
    tblmsbackendidBEDefault: TStringField;
    Label5: TLabel;
    tblmsbackendidEmailUsername: TStringField;
    DNMPanel3: TDNMPanel;
    btnNext: TDNMSpeedButton;
    Label1: TLabel;
    DNMPanel4: TDNMPanel;
    Label3: TLabel;
    lbC: TLabel;
    lbB: TLabel;
    lbD: TLabel;
    lbF: TLabel;
    lbE: TLabel;
    lbG: TLabel;
    lbA: TLabel;
    ProgressTime1: TProgressTime;
    Label4: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    edSiteCode: TDBEdit;
    edSiteDesc: TDBEdit;
    edCompanyName: TEdit;
    Label10: TLabel;
    lbClass: TLabel;
    btnDoIt: TDNMSpeedButton;
    Bevel1: TBevel;
    TabSheet3: TTabSheet;
    DNMPanel5: TDNMPanel;
    Label11: TLabel;
    btnNext2: TDNMSpeedButton;
    Label6: TLabel;
    edEmailAddressData: TDBEdit;
    Label9: TLabel;
    edEmailUsername: TDBEdit;
    Label7: TLabel;
    edEmailPassword: TDBEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    cbConflictTodoUserID: TwwDBLookupCombo;
    cboClassQry: TMyQuery;
    cboClass: TwwDBLookupCombo;
    tblmsbackendidBackEndID: TIntegerField;
    qrytblEmployeesEmployeeName: TStringField;
    DNMPanel6: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnDoItclick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure btnSheet2click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);      
    procedure RefreshStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSiteCodeExit(Sender: TObject);
    procedure cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure edEmailAddressDataExit(Sender: TObject);
    procedure cbConflictTodoUserIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure edEmailPasswordChange(Sender: TObject);
  private
    dbCloned: boolean;
    Thread: TStopStartThread;
    ServicesParms: string;
    ServicesResult: boolean;
    ServicesResultText: string;
    ServicesStream: TMemoryStream;
    FormStarting: boolean;
    function GetSheetStatus(Index: integer): boolean;
    procedure SetSheetStatus(Index: integer; Value: boolean);  
    procedure ServicesExec(P: Pointer);
    procedure CommandDropDB(P: Pointer);
  public
    NewSiteGenerated: string;
  end;


implementation

uses FastFuncs,DNMExceptions, frmClassFrm,  CommonLib, TransactionsTable,
  CommonDbLib, DNMLib, AppEnvironment;

const
  BACKUPPATH    = 'C:\Platinum1\Backup\';
  MULTISITEPATH = 'C:\Platinum1\Multisite\';

{$R *.dfm}

// turn the lights on/off and enable/disable buttons
procedure TMultisiteWizardGUI.RefreshStatus(Sender: TObject);

  procedure StatusPage0; // (Descriptions)
  begin
    if (dstblmsbackendid.State = dsBrowse) or (dstblmsbackendid.State = dsInsert) and
      (Length(edSiteCode.Text) = 3) and (edSiteDesc.Text > '') and (tblmsbackendidConflictTodoUserID.AsInteger > 0) and
      (edCompanyName.Text > '') and (cboClass.Text > '') then SetSheetStatus(0, true)
    else SetSheetStatus(0, false);
  end;

  procedure StatusPage1; // (Descriptions)
  begin
    if (dstblmsbackendid.State = dsBrowse) or (dstblmsbackendid.State = dsInsert) and
      (edEmailAddressData.Text > '') and (edEmailUsername.Text > '') and (edEmailPassword.Text > '') then SetSheetStatus(1, true)
    else SetSheetStatus(1, false);
  end;

  procedure StatusPage2;
  begin
    if dbCloned then SetSheetStatus(2, true)
    else SetSheetStatus(2, false);
  end;
var 
  i: integer;
begin
  StatusPage0;
  StatusPage1;
  StatusPage2;

  btnNext.Enabled := GetSheetStatus(PageControl1.ActivePageIndex);
  btnNext2.Enabled := GetSheetStatus(PageControl1.ActivePageIndex);

  // to enable cmdOK, all lights must be green (ImageIndex = 1)
  cmdOK.Enabled := true;


  for i := 0 to PageControl1.PageCount - 1 do if not GetSheetStatus(i) then begin
      cmdOK.Enabled := false;
      Break;
    end;
    
  //Tab Order
  if Assigned(Sender) then begin
    if btnNext.Enabled and (TComponent(Sender).Name = 'cbConflictTodoUserID') then SetControlFocus(btnNext);
    if btnNext2.Enabled and (TComponent(Sender).Name = 'edEmailPassword') then SetControlFocus(btnNext2);
  end;
end;

procedure TMultisiteWizardGUI.ServicesExec(P: Pointer);
var 
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    ServicesResult := MTClient.ExecuteDB(['EXEC', 'Prog=BackupManager.exe', 'Parms=' + ServicesParms], ServicesStream);
    sl.LoadFromStream(ServicesStream);
    ServicesResultText := sl.Text;
  finally
    FreeandNil(sl);
  end;
end;

procedure TMultisiteWizardGUI.CommandDropDB(P: Pointer);
begin
  CloneConnection.Disconnect;
  CloneConnection.Database := 'Mysql';
  CloneConnection.Connect;
  CloneCommand.Connection := CloneConnection;
  CloneCommand.SQL.Text := 'DROP DATABASE `' + CommonDbLib.GetSharedMyDacConnection.Database + 'MSClone`;';
  CloneCommand.Execute;
  CloneConnection.Disconnect;
end;


procedure TMultisiteWizardGUI.btnDoItclick(Sender: TObject);

  procedure showRed(lb: TLabel; sleeptime: integer);
  begin
    Sleep(sleeptime);
    if lb.Caption > '' then ProgressTime1.Start(lb.Caption);
    lbA.Font.Color := clBlack;
    lbB.Font.Color := clBlack;
    lbC.Font.Color := clBlack;
    lbD.Font.Color := clBlack;
    lbE.Font.Color := clBlack;
    lbF.Font.Color := clBlack;
    lbG.Font.Color := clBlack;
    if lb <> nil then lb.Font.Color := clRed;
    Application.ProcessMessages;
  end;
var 
  targetDBName: string;
  qryTemp: TMyCommand;
  TransactionTableObj: TTransactionTableObj;  
begin
  //ProgressTime1.Start(lba);
  try
    btnDoIt.Enabled := false;
    showRed(lbA, 0);

    //Clean Fax Docs
    qryTemp := TMyCommand.Create(Self);
    try
      qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryTemp.SQL.Clear;
      qryTemp.Sql.Add('DELETE FROM tblfaxspool;');
      qryTemp.Execute;
      qryTemp.SQL.Clear;
      qryTemp.Sql.Add('DELETE FROM tblfaxspooldocs;');
      qryTemp.Execute;
    finally
      FreeAndNil(qryTemp);
    end;

    // add new backend to tblmsbackendid
    tblMsBackendIdBEDefault.AsString := 'F';
    tblMsBackendID.Post;

    showRed(lbB, 2000);
    //
    TransactionTableObj := TTransactionTableObj.Create;
    try
      TransactionTableObj.SetEmptyGlobalRef;
    finally
      FreeandNil(TransactionTableObj);
    end;

    showRed(lbC, 0);
    // clone database
    with MTClient do begin
      Host       := CommonDbLib.GetSharedMyDacConnection.Server;
      DBUserName := CommonDbLib.GetSharedMyDacConnection.Username;
      DBPassword := CommonDbLib.GetSharedMyDacConnection.Password;
      DBPort     := CommonDbLib.GetSharedMyDacConnection.Port;
      DB         := CommonDbLib.GetSharedMyDacConnection.Database;
      MTClient.AutoDetectPort;
      ServicesParms := 'Clone ' + DB + ' ' + DBUserName + ' ' + DBPassword + ' ' + DB + 'MSClone';
      Thread.MsgWaitFor(ServicesExec, nil);

      if not ServicesResult then begin
        CommonLib.MessageDlgXP_Vista('Error: could not perform Clone'#13#10 + 'Are Services running on Server?', mtWarning , [mbOK], 0);
        Exit;
      end;
    end;

    showRed(lbD, 0);
    // connect to clone

    // Set Default in tblBackendId to new site
    with CommonDbLib.GetSharedMyDacConnection do begin
      CloneConnection.Server := Server;
      CloneConnection.UserName := UserName;
      CloneConnection.PassWord := Password;
      CloneConnection.LoginPrompt := false;
      CloneConnection.Database := Database + 'MSClone';
    end;
    CloneConnection.Connected := true;
    CloneCommand.SQL.Text     := 'UPDATE tblmsbackendid SET BEDefault = "F"';
    CloneCommand.Execute;
    Assert(CloneCommand.RowsAffected > 0, 'Resetting BEDefault failed');
    CloneCommand.SQL.Text := 'UPDATE tblmsbackendid SET ' + 'BEDefault = "T", ' + 'SentStamp = "' +
      FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '" ' + 'WHERE SiteCode = "' + tblmsbackendIdSiteCode.AsString + '"' + ';';
    CloneCommand.Execute;
    Assert(CloneCommand.RowsAffected = 1, 'Setting BEDefault failed');

    CloneCommand.SQL.Text := 'UPDATE tblmsbackendid SET ' + 'ReceivedID = SentID,' + 'ReceivedStamp = "' +
      FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '" ' + 'WHERE SiteCode = "' + AppEnv.Branch.SiteCode + '"' + ';';
    CloneCommand.Execute;
    Assert(CloneCommand.RowsAffected = 1, 'Setting BEDefault failed');

    // change companyName
    CloneCommand.SQL.Text := 'UPDATE tblcompanyInformation SET CompanyName = "' + edCompanyName.Text + '";';
    CloneCommand.Execute;
    Assert(CloneCommand.RowsAffected = 1, 'Changing CompanyName failed');

    // change tblColumnHeadings
    CloneCommand.SQL.Text := 'UPDATE tblColumnHeadings SET DefaultClass = "' + FastFuncs.Trim(cboClass.Text) + '";';
    CloneCommand.Execute;
    Assert(CloneCommand.RowsAffected = 1, 'Setting DefaultClass failed');

    dbCloned := true;

    showRed(lbE, 2000);
    // make Archive (.zip)

    with CloneConnection do begin
      targetDBName := Database + '_' + tblmsbackendidSiteCode.AsString + '_STARTMULTISITE';
      ServicesParms := 'Backup ' + Database + ' ' + UserName + ' ' + Password + ' ' + targetDBName;
    end;
    Thread.MsgWaitFor(ServicesExec, nil);
    if not ServicesResult then begin
      CommonLib.MessageDlgXP_Vista('Error: could not perform Backup', mtWarning , [mbOK], 0);
      Exit;
    end;

    // ? and copy to workstation?

    showRed(lbF, 2000);
    // email other sites about change
    // tell MultiSiteGUI2 to do this
    NewSiteGenerated := tblmsbackendidSiteCode.AsString;

    showRed(lbG, 2000);

    Thread.MsgWaitFor(CommandDropDB, nil);

    SetSheetStatus(1, true);
    ProgressTime1.Stop('DONE', clGreen);
    showRed(nil, 0);
    CommonLib.MessageDlgXP_Vista('COMPLETED :-' + #13#10 + '   ' + '- Move File From This Server' + #13#10 + '      ' +
      BACKUPPATH + targetDBName + '.zip' + #13#10 + '      ' + 'To Same Folder On Server For Site ' +
      tblmsbackendidSiteDesc.AsString + '.' + #13#10 + #13#10 + '   ' + '- Then Restore This File To The Start New Site.',
      mtInformation, [mbOK], 0);
  finally
    RefreshStatus(nil);
    Screen.Cursor := crDefault;
  end;                            
end;

function TMultisiteWizardGUI.GetSheetStatus(Index: integer): boolean;
begin
  Result := PageControl1.Pages[Index].ImageIndex = 1;
end;


procedure TMultisiteWizardGUI.SetSheetStatus(Index: integer; Value: boolean);
begin
  if Value then PageControl1.Pages[Index].ImageIndex := 1
  else PageControl1.Pages[Index].ImageIndex          := 0;
end;


procedure TMultisiteWizardGUI.btnSheet2click(Sender: TObject);
begin
  SetSheetStatus(1, not GetSheetStatus(1));
  RefreshStatus(nil);
end;


procedure TMultisiteWizardGUI.btnNextClick(Sender: TObject);
begin
  if PageControl1.ActivePageIndex + 1 < PageControl1.PageCount then
    PageControl1.ActivePageIndex := PageControl1.ActivePageIndex + 1;
  RefreshStatus(nil);  
end; //btnNextClick


procedure TMultisiteWizardGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblmsBackendID.Close;
  cboClassQry.Close;
  qrytblEmployees.Close;
  if Thread.Waiting then Thread.AbortThread;
  FreeandNil(Thread);                
  FreeandNil(Servicesstream);
  Action := caFree;
//  MultisiteWizardGUI := nil;
  inherited
end;


procedure TMultisiteWizardGUI.cmdCancelClick(Sender: TObject);
begin
  if tblmsBackendID.State = dsBrowse then tblmsBackendID.Delete
  else if tblmsBackendID.State = dsInsert then tblmsBackendID.Cancel;
  NewSiteGenerated := '';
  Close;
end;


procedure TMultisiteWizardGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    RealignTabControl(PageControl1, 1);
    dbCloned := false;
    PageControl1.ActivePageIndex := 0;
    tblColumnHeadings.Open;
    lbClass.Caption := 'Default ' + tblcolumnheadingsClassHeading.AsString;
    tblColumnHeadings.Close;

    cboClassQry.Open;
    qrytblEmployees.Open;
    tblmsBackendId.Open;
    tblmsBackendID.Insert;
    tblmsBackendIDConflictToDoUserId.AsInteger := 0;
    RefreshStatus(nil);
    FormStarting := false;
  except
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;



procedure TMultisiteWizardGUI.cmdOKClick(Sender: TObject);
begin
  Close;
end;


procedure TMultisiteWizardGUI.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
begin
  with PageControl1 do begin
    case ActivePageIndex of
      0: allowChange := GetSheetStatus(0);
      1: allowChange := GetSheetStatus(1);
      2:;
    end;
  end;
  RefreshStatus(nil);
end;

procedure TMultisiteWizardGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Thread := TStopStartThread.Create;
  ServicesStream := TMemoryStream.Create;
  FormStarting := true;
end;

procedure TMultisiteWizardGUI.edSiteCodeExit(Sender: TObject);
begin
  inherited;
  if CheckForDuplicates(edSiteCode.Text) then begin
    CommonLib.MessageDlgXP_Vista('This Site Code Already Exists !', mtWarning, [mbOK], 0);
    edSiteCode.Text := '';
    tblmsbackendid.Edit;
    tblmsbackendidSiteCode.AsString := '';
    Exit;
  end;

  if CheckForPastUsedGlobalRef(edSiteCode.Text) then begin
    CommonLib.MessageDlgXP_Vista('This Site Code Already Exists In Your Data !' + #13 + #10 + #13 + #10 +
      'This Site Code May Have Already Existed As ' + #13 + #10 +
      'A Multisite Code at One Point in Time', mtWarning, [mbOK], 0);

    edSiteCode.Text := '';
    tblmsbackendid.Edit;
    tblmsbackendidSiteCode.AsString := '';
    Exit;
  end;

  RefreshStatus(Sender);
end;

procedure TMultisiteWizardGUI.cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection not in list.  Create New?', mtInformation, [mbOK], 0) = mrOk then begin
    tmpComponent := GetComponentByClassName('TfrmClass');
    If not Assigned(tmpComponent) then Exit;
    with TfrmClass(tmpComponent) do begin
      FormStyle := fsNormal;
      ShowModal;
    end;
    LookupTable.Close;
    LookupTable.Open;
    Accept := false;
  end;
end;

procedure TMultisiteWizardGUI.edEmailAddressDataExit(Sender: TObject);
begin
  inherited;
  // Test Dup Email
  if IsDupMultisiteEmail(tblmsbackendid.FieldByName('BackEndID').AsInteger, edEmailAddressData.Text) then begin
    tblmsbackendid.Edit;
    tblmsbackendid.FieldByName('EmailAddressData').AsString := '';
    edEmailAddressData.Text := '';
    CommonLib.MessageDlgXP_Vista('Cannot Have Duplicate Email Addresses In Multisite !', mtWarning, [mbOK], 0);
    SetControlFocus(edEmailAddressData);
    Exit;
  end;
  RefreshStatus(Sender);
end;

procedure TMultisiteWizardGUI.cbConflictTodoUserIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if not FormStarting then RefreshStatus(nil);
end;

procedure TMultisiteWizardGUI.edEmailPasswordChange(Sender: TObject);
begin
  inherited;
  if not FormStarting then RefreshStatus(nil);
end;

initialization
  RegisterClassOnce(TMultisiteWizardGUI);

end.
