{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/05/05  1.00.01 BJ  GlobalRef Field is added to the grid as the first column
 07/09/05  1.00.02 IJB  Modified to use new filtering on base listing.
 }

unit frmOthersListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook,
  kbmMemTable, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TfrmOthersList = class(TBaseListingGUI)
    qryMainCompanyName: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TAutoIncField;
    qryMainEmployee: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainContactType: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainRepID: TIntegerField;
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
    qryMainCreationDate: TDateField;
    qryMainMobile: TWideStringField;
    qryMainCompanyType: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainMediaType: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainContactdetails: TWideStringField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainCUSTDate1: TDateField;
    qryMainCUSTDate2: TDateField;
    qryMainCUSTDate3: TDateField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainDontContact: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actMergeExecute(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    LastSelectedID: integer;
    procedure SendBulkSMS;
    procedure SendBulkEmail;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

//var
//  frmOthersList: TfrmOthersList;

implementation

uses FastFuncs,frmOtherContactFrm,  MergeObj, DnmLib, {tcMessaging,} MAIN,
  CommonLib, Forms, AppEnvironment, dmMainGUI, tcDataUtils, UserUtilsClientObj,
  EmailUtils, SMSUtils, CommonDbLib, CorrespondenceObj, EmailExtraUtils;

{$R *.dfm}

procedure TfrmOthersList.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    Form := GetComponentByClassName('TfrmOtherContact');
    if Assigned(Form) then begin
      with TfrmOtherContact(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmOthersList.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TfrmOthersList.RefreshQuery;
begin
  inherited;
end;

procedure TfrmOthersList.FormShow(Sender: TObject);
begin
  fbEnableWebSearch := true;
//  qryMain.Params.ParamByName('xRepID').asInteger := AppEnv.Employee.EmployeeID;
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('RepID,ClientID');
  grpFiltersClick(Sender);
end;

procedure TfrmOthersList.FormCreate(Sender: TObject);
begin
  //  fbUseFetchProgress:=True; 
  inherited;
  LastSelectedID:= 0;
end;

procedure TfrmOthersList.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  LastSelectedID := qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TfrmOthersList.actMergeExecute(Sender: TObject);
var
  i: integer;
  MergeObj: TMergeObj;
  PrincipleName: string;
  PrincipleID: integer;
  SecordaryName: string;
  SecordaryID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count > 1 then begin
    qryMain.DisableControls;
    qryMain.Locate('ClientID',LastSelectedID,[]);
    PrincipleName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
    PrincipleID   := qryMain.FieldByName('ClientID').AsInteger;
    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to Merge these Prospects into ' + PrincipleName,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if qryMain.FieldByName('ClientID').AsInteger = PrincipleID then
          continue;
        SecordaryName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
        SecordaryID := qryMain.FieldByName('ClientID').AsInteger;
        // Ensure there is only one user connected to the database.  That is You only!
        if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Prospects') then begin
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
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Prospect';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end
          else begin
            MessageDlgXP_Vista('Unable to merge Prospects, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          end;
        end;
      end;
    end;
    grdMain.SelectedList.Clear;
    qryMain.EnableControls;
    UpdateMe;
  end else begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Prospects.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmOthersList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmOthersList.btnEmailClick(Sender: TObject);
begin
  inherited;
  self.SendBulkEmail;
end;

procedure TfrmOthersList.btnSMSClick(Sender: TObject);
begin
  inherited;
  self.SendBulkSMS;
end;

procedure TfrmOthersList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmOthersList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmOthersList.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
//  lSilent, lSecret : boolean;
begin
  if grdMain.SelectedList.Count = 0 then
  begin
    MessageDlgXP_Vista('You Have Not Selected Any Prospects To Email To', mtInformation, [mbOk], 0);
    exit;
  end;

  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email',List,self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Prospects in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Prospects in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have an email address.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' Prospects?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send Email }

//    if not EmailSilentSecret(List.Count, false, lSilent, lSecret) then
//      exit;

    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Prospects]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtOtherContact;
//    Corres.Execute(lSilent, lSecret);
    Corres.Execute(false, false);
  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TfrmOthersList.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List, self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Prospects in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Prospects in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' Prospects?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Prospects]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtOtherContact;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TfrmOthersList.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Othr');
end;

initialization
  RegisterClassOnce(TfrmOthersList);
end.
