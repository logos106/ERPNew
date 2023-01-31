unit frmPasswordFrm;

interface

uses
  Windows, BaseInputForm, DB, MyAccess,ERPdbComponents, Buttons, DNMSpeedButton, StdCtrls, Controls, Mask,
  DBCtrls, ExtCtrls, jpeg, Classes, Forms, SysUtils, kbmMemTable, MemDS,
  DBAccess, Shader, DNMPanel, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Graphics, ImgList, ProgressDialog;


type
  TfrmPassword = class(TBaseInputGUI)
    frmPasswordSrc: TDataSource;
    EPassword: TDBEdit;
    Password: TEdit;
    Label3: TLabel;
    Label14: TLabel;
    EmployeeID: TDBEdit;
    Label16: TLabel;
    cmdAccessLevel: TDNMSpeedButton;
    qryPassword: TERPQuery;
    qryGETLP: TERPQuery;
    DataSource1: TDataSource;
    PasswordID: TDBEdit;
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Confirmation: TEdit;
    Label1: TLabel;
    Text11: TEdit;
    memQryPassword: TkbmMemTable;
    qryPasswordPswd_ID: TAutoIncField;
    qryPasswordEmployeeId: TIntegerField;
    qryPasswordEditedFlag: TWideStringField;
    qryPasswordTitle: TWideStringField;
    qryPasswordEmployeeName: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPasswordPasswordDate: TDateField;
    Text15: TDBEdit;
    qryPasswordLogon_Name: TWideStringField;
    qryPasswordLogon_Password: TWideStringField;
    procedure cmdSaveClick(Sender: TObject);
    procedure GETLP;
    procedure Form_Open(Cancel: smallint);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdAccessLevelClick(Sender: TObject);
    procedure qryPasswordAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fsName: string;
    fPassedConnection: TERPConnection;
    NewUser:Boolean;
    CleanUserName:String;
    Procedure AddEmployeeforTraining(Sender:TObject);
    procedure LockUserNamePassword;
  public
    { Public declarations }
    
    property EmployeeName: string read fsName write fsName;
    property PassedConnection: TERPConnection read fPassedConnection write fPassedConnection;
  end;

implementation

uses
  Dialogs, DNMLib, DNMExceptions, AuditObj, frmEmployeeFrm, CommonLib,
  frmAccessLevels, FastFuncs, TrainingLib, CommonFormLib,
  frmTrainingAssignment, tcDataUtils, AppEnvironment, SimpleEncrypt;

{$R *.DFM}

procedure TfrmPassword.GETLP;
var
  ELP: string;
  KEY: string;
begin
  if qryGETLP.RecordCount = 0 then Exit;
  Self.Refresh;
  KEY := 'z';
  if qryGETLP.FieldByName('Logon_Password').AsString > '' then begin
    ELP           := qryGETLP.FieldByName('Logon_Password').AsString;
    Password.Text := FastFuncs.LowerCase(DeCrypt(ELP, KEY));
  end;
end;

procedure TfrmPassword.Form_Open(Cancel: smallint);
begin
  GETLP;
end;

procedure TfrmPassword.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

Procedure TfrmPassword.LockUserNamePassword;
begin
  CleanUserName :=qryPasswordLogon_Name.asString;
  if AppEnv.UtilsClient.HasUserLogedIn(qryPasswordLogon_Name.asString , AppEnv.appdb.Database) then begin
    Text15.readonly:= true;
    Text15.Hint := 'Read Only as ' + CleanUserName+' is already logged in';
  end;
end;

procedure TfrmPassword.FormShow(Sender: TObject);
var
  sPassword: string;
begin
  DisableForm;
  try
    try
      inherited;
      if qryPassword.Active then begin
        if not (qryPassword.State in [dsBrowse]) then begin
          qryPassword.Edit;
          qryPassword.Post;
          Notify;
        end;
        CloseQueries;
      end;
      qryPassword.ParamByName('EmpID').asInteger := KeyID;
      qryPassword.Open;
      if qryPassword.IsEmpty then begin
        qryPassword.Insert;
        qryPassword.FieldByName('EmployeeId').AsInteger := KeyID;
      end else begin
        qryPassword.Edit;
      end;
      Text11.Text       := fsName;
      sPassword         := qryPassword.Fields.FieldByName('Logon_Password').AsString;
      Password.Text     := FastFuncs.LowerCase(DeCrypt(sPassword, 'z'));
      Confirmation.Text := FastFuncs.LowerCase(DeCrypt(sPassword, 'z'));
      SetControlFocus(Text15);
      NewUser:= Trim(qryPasswordLogon_Name.asString) = '';
      Lockusernamepassword;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmPassword.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Closequeries;
  inherited;
  Action := caFree;
end;

procedure TfrmPassword.cmdAccessLevelClick(Sender: TObject);
var
  frm: TAccessLevelsGUI;
  EmployeeGUI: TComponent;
  Form : TComponent;
begin
  inherited;

  if FormStillOpen('TfrmEmployee') then begin
    EmployeeGUI := FindExistingComponent('TfrmEmployee');
    TfrmEmployee(EmployeeGUI).MyConnection.Commit;
    TfrmEmployee(EmployeeGUI).MyConnection.StartTransaction;
  end;

  if not FormStillOpen('TAccessLevelsGUI') then begin
    Form := GetComponentByClassName('TAccessLevelsGUI');
    if Assigned(Form) then begin //if has acess
      with TForm(Form) do begin
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else begin
    with TForm(FindExistingComponent('TAccessLevelsGUI')) do begin
      Show;
      BringToFront;
    end;
  end;

  Application.ProcessMessages;
  frm := TAccessLevelsGUI(GetComponentByClassName('TAccessLevelsGUI'));
  if assigned(frm) then begin
    frm.cboEmployee.OnNotInList := nil;
    if not frm.qryEmployee.Active then Exit;
    frm.qryEmployee.Locate('EmployeeID', Self.KeyID, [loCaseInsensitive]);
    frm.cboEmployee.Text := frm.qryEmployee.FieldByName('Employee Names').AsString;
    frm.cboEmployeeCloseUp(frm.cboEmployee, frm.cboEmployee.lookupTable, nil, false);
//    frm.TabCtlChange(frm.TabCtl);
  end;

end;

procedure TfrmPassword.cmdSaveClick(Sender: TObject);
var
  KEY: string;
  LP: string;
  msg: string;
begin
  KEY := 'z';
  try
  if not(SameText(CleanUserName ,qryPasswordLogon_Name.asString)) and (AppEnv.UtilsClient.HasUserLogedIn(qryPasswordLogon_Name.asString , AppEnv.appdb.Database)) then begin
    EditDb(qryPassword);
    qryPasswordLogon_Name.asString:=CleanUserName;
    Text15.Text :=CleanUserName;
    Text15.readonly:= true;
    Text15.Hint := 'Read Only as ' + CleanUserName+' is already logged in';
    MessageDlgXP_Vista('Logon name cannot be changed as' +CleanUserName +' is already logged in', mtWarning, [mbOK], 0);
  end;
    if FastFuncs.LowerCase(Confirmation.Text) = FastFuncs.LowerCase(Password.Text) then begin
      if not AppEnv.CompanyPrefs.PasswordConfig.PasswordValid(Password.Text,msg) then begin
        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        SetControlFocus(Password);
        exit;
      end;
      if not (qryPassword.State in [dsBrowse]) then begin
//        LP := FastFuncs.LowerCase(Password.Text);
        LP := Password.Text;
        qryPasswordLogon_Password.AsString := EnCrypt(LP, KEY);
        qryPasswordPasswordDate.AsDateTime := Date;
        ProcessEditedFlag('Main', Self, memQryPassword, qryPassword, nil);
        qryPassword.Edit;
        qryPassword.Post;
        Notify;
      end;
      if NewUser then
        if not HasTRainingAssigned(qryPasswordEmployeeId.asInteger) then begin
          if MessageDlgXP_Vista(tcDataUtils.getemployeeName(qryPasswordEmployeeId.asInteger) +' Has No Module Assigned For Training.  Do You Wish To Assign the Training For ' +tcDataUtils.getemployeeName(qryPasswordEmployeeId.asInteger) +'?'  , mtconfirmation, [mbyes, mbno] , 0) = mryes then begin
             OpenERPForm('TfmTrainingAssignment' , 0 , AddEmployeeforTraining);
          end;
        end;
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('Logon Password Does not Match Verify Password ! Try Again', mtWarning, [mbOK], 0);
      Password.Text := '';
      Confirmation.Text := '';
      SetControlFocus(Text15);
    end;
  except
    on EAbort do HandleEAbortException;
    on e: EDatabaseError do begin
      Audit.AddEntry(e, Self);
      if FastFuncs.PosEx('duplicate', FastFuncs.LowerCase(e.Message)) > 0 then begin  // i know this is Ugly, but what can i do :-0
        CommonLib.MessageDlgXP_Vista('This Password is already in use. Try Again', mtWarning, [mbOK], 0);
        SetControlFocus(Password);
      end else begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
    else raise;
  end;
end;


procedure TfrmPassword.qryPasswordAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryPassword, memQryPassword);
end;

procedure TfrmPassword.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(PassedConnection) then
    qryPassword.Connection:= PassedConnection;
  NewUser := False;
end;

procedure TfrmPassword.AddEmployeeforTraining(Sender: TObject);
begin
  if not (Sender is TfmTrainingAssignment) then exit;
  TfmTrainingAssignment(Sender).AddEmployeeforTraining(qryPasswordEmployeeId.asInteger);
end;

Initialization
  RegisterClassOnce(TfrmPassword);
end.
