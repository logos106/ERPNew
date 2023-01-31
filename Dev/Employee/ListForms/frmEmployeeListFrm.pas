  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 17/05/05  1.00.01 BJ   GlobalRef Field is added to the grid as the first column
  // 07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
  // 24/10/05  1.00.03 MV   Modified qryMain to display additional field Department.

unit frmEmployeeListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, PrintDAT, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, ActnList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog, kbmMemTable, 
  wwdblook, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmEmployeeList = class(TBaseListingGUI)
    qryMainEmployeeID: TAutoIncField;
    qryMainEmployeeName: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFaxNumber: TWideStringField;
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
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmployeeNo: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainWorkPhone: TWideStringField;
    qryMainDOB: TDateField;
    qryMainDateStarted: TDateField;
    qryMainPosition: TWideStringField;
    qryMainDateFinished: TDateField;
    qryMainIsTerminated: TWideStringField;
    qryMainEmail: TWideStringField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainArea: TWideStringField;
    qryMainCreationDate: TDateTimeField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    procedure SendBulkSMS;
    procedure SendBulkEmail;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs,Forms, frmEmployeeFrm, CommonLib, BaseInputForm,
  EmailUtils, SMSUtils, CommonDbLib, AppEnvironment, CorrespondenceObj, EmailExtraUtils;

{$R *.dfm}

procedure TfrmEmployeeList.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TfrmEmployeeList.RefreshQuery;
begin
  inherited;
(*  replaceCustFlds;*)
end;

procedure TfrmEmployeeList.FormShow(Sender: TObject);
begin
  inherited;
  (*GuiPrefs.DbGridElement[grdMain].RemoveFields('EmployeeID');*)
  grpFiltersClick(Sender);
end;

procedure TfrmEmployeeList.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmEmployee');
    if Assigned(Form) then begin //if has acess
      with TfrmEmployee(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    //  MainForm.Employee2Click(Sender);
  finally
    EnableForm;
  end;  
end;

procedure TfrmEmployeeList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeList.btnEmailClick(Sender: TObject);
begin
  inherited;
  SendBulkEmail;
end;

procedure TfrmEmployeeList.btnSMSClick(Sender: TObject);
begin
  inherited;
  SendBulkSMS;
end;

procedure TfrmEmployeeList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeList.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
  lSIlent,
  lSecret : boolean;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email',List, self.qryMainEmployeeID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Employees in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Employees in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have an email address.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' Employees?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send Email }
    if not EmailSilentSecret(List.Count, false, lSilent, lSecret) then
      exit;
    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Employees]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtEmployee;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TfrmEmployeeList.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List, self.qryMainEmployeeID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Employees in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Employees in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' Employees?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Employees]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtEmployee;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TfrmEmployeeList.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Empl');
end;

procedure TfrmEmployeeList.grdMainDblClick(Sender: TObject);
var
  form: TBaseInputGUI;
begin
  form:= TBaseInputGUI(FindExistingComponent('TfrmEmployee'));
  if Assigned(form) then begin
    if form.KeyID = qryMainEmployeeID.AsInteger then
      form.BringToFront
    else begin
      form.Release;
      Application.ProcessMessages;
      if not Assigned(FindExistingComponent('TfrmEmployee')) then
        inherited;
    end;
  end
  else
    inherited;
end;

initialization
  RegisterClassOnce(TfrmEmployeeList);
end.

