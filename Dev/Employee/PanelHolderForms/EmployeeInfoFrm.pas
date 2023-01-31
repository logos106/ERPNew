unit EmployeeInfoFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay,BusObjEmployeeDetails, wwdblook, StdCtrls, Mask, DBCtrls, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel, wwdbedit,
  wwclearbuttongroup, wwradiogroup, wwdbdatetimepicker, frmBase, wwcheckbox,
  BusObjBase, DNMSpeedButton, Wwdotdot, Wwdbcomb, Menus, HTMLUn2, HtmlView;

type
  TEmployeeInfo = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DSEmployeesInfo: TDataSource;
    DNMPanel2: TDNMPanel;
    Label27: TLabel;
    Title: TDBEdit;
    Label25: TLabel;
    Initials: TDBEdit;
    Label28: TLabel;
    FirstName: TDBEdit;
    Label30: TLabel;
    MiddleName: TDBEdit;
    Label29: TLabel;
    LastName: TDBEdit;
    DNMPanel3: TDNMPanel;
    Label31: TLabel;
    Phone: TwwDBEdit;
    Label33: TLabel;
    FaxNumber: TwwDBEdit;
    Label34: TLabel;
    Mobile: TwwDBEdit;
    DNMPanel4: TDNMPanel;
    Label96: TLabel;
    DBEdit8: TDBEdit;
    Label97: TLabel;
    DBEdit21: TDBEdit;
    Label98: TLabel;
    DBEdit22: TDBEdit;
    DNMPanel5: TDNMPanel;
    Label19: TLabel;
    cboDefaultClass: TwwDBLookupCombo;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    Label134: TLabel;
    DateStarted: TwwDBDateTimePicker;
    Label142: TLabel;
    Position: TDBEdit;
    btnDeleteUserGuiPrefs: TDNMSpeedButton;
    Label1: TLabel;
    AltPhone: TwwDBEdit;
    btnDefaultDashboard: TDNMSpeedButton;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    cboDefaultContactMethod: TwwDBComboBox;
    Label6: TLabel;
    chkIsTerminated: TwwCheckBox;
    lblDateFinished: TLabel;
    DateFinished: TwwDBDateTimePicker;
    wwCheckBox1: TwwCheckBox;
    chkIsOnRoster: TwwCheckBox;
    Label163: TLabel;
    DOB: TwwDBDateTimePicker;
    Label5: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    DNMPanel6: TDNMPanel;
    edtSkypeName: TDBEdit;
    Label7: TLabel;
    Label35: TLabel;
    AltContact: TDBEdit;
    pnlPref: TPanel;
    Label12: TLabel;
    Label4: TLabel;
    rgSex: TwwRadioGroup;
    HtmlViewer: THtmlViewer;
    Bevel1: TBevel;
    dsPersonalPrefs: TDataSource;
    edtMaxDiscount: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    EDTMinimumMarginPercentage: TwwDBEdit;
    Label8: TLabel;
    Bevel2: TBevel;
    chkPasswordNeverExpires: TwwCheckBox;
    Label9: TLabel;
    EmployeeNo: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    pnlDevComments: TDNMPanel;
    Label10: TLabel;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure TitleExit(Sender: TObject);
    procedure cboDefaultClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDeleteUserGuiPrefsClick(Sender: TObject);
    procedure btnDefaultDashboardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboDefaultClassNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboDefaultContactMethodEnter(Sender: TObject);
    procedure chkIsTerminatedClick(Sender: TObject);
    procedure DateFinishedChange(Sender: TObject);
    procedure edtMaxDiscountExit(Sender: TObject);
    procedure edtMinMarkupPercentageExit(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
    procedure wwDBEdit4Exit(Sender: TObject);
    procedure EDTMinimumMarginPercentageExit(Sender: TObject);
    procedure EmployeeNoDblClick(Sender: TObject);
    
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleInfoErrors;
    function FindEmployeeLastPayDate: TDateTime;
  public
    Emp:temployeedetails; //use this if need to create new employee
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib,BusObjSuperannuation, FastFuncs, CommonDbLib,
  DashBoardObj, dateUtils, BusObjPreference, Preferences, AppEnvironment,
  frmEmployeefrm, tcConst, tcDataUtils;

procedure TEmployeeInfo.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
(*  edtMaxDiscount.Text := FloatToStrF(fSubEmpPay.EmployeeDetails.PersonalPreferences.MaxDiscountPercentage *100, ffFixed, 7, 2) + ' %';
  edtMinMarkupPercentage.Text := FloatToStrF(fSubEmpPay.EmployeeDetails.PersonalPreferences.MinMarkupPercentage *100, ffFixed, 7, 2) + ' %';*)

end;

//procedure TEmployeeInfo.HandleInfoErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//  aDateFinished: TDateTime;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeDetails.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_Employee_Err_NoTitle                : begin
//                                                  SetControlFocus(Title);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoFirstName            : begin
//                                                  SetControlFocus(FirstName);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoLastName             : begin
//                                                  SetControlFocus(LastName);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoDefaultDepartment    : begin
//                                                  SetControlFocus(cboDefaultClass);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoDateStarted          : begin
//                                                  SetControlFocus(DateStarted);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoDOB                  : begin
//                                                  SetControlFocus(DOB);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoSex                  : begin
//                                                  SetControlFocus(rgSex);
//                                                  exit;
//                                                end;
//      BOR_Employee_Err_NoDateFinished         : begin
//                                                  SetControlFocus(DateFinished);
//                                                  aDateFinished := FindEmployeeLastPayDate;
//                                                  if aDateFinished > 0 then begin
//                                                    if commonLib.MessageDlgXP_Vista('Would you like to set Date Finished to last date employee was paid?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
//                                                      DateFinished.Date := aDateFinished;
//                                                    end;
//                                                  end;
//                                                  exit;
//                                                end;
//    end;
//  end;
//end;

procedure TEmployeeInfo.TitleExit(Sender: TObject);
begin
  if uppercase(SubEmpPay.EmployeeDetails.Title) = 'MR' then SubEmpPay.EmployeeDetails.Sex := 'Male' else SubEmpPay.EmployeeDetails.Sex := 'Female'
end;

procedure TEmployeeInfo.wwDBEdit4Exit(Sender: TObject);
begin
  inherited;
  SubEmpPay.EmployeeDetails.PersonalPreferences.PostDB;
end;

procedure TEmployeeInfo.edtMinMarkupPercentageExit(Sender: TObject);
begin
(*var
  TempPercent: Double;
begin
  inherited;
  if not Assigned(SubEmpPay) then exit;

  edtMinMarkupPercentage.Text := FloatToStrF(StrValue(edtMinMarkupPercentage.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtMinMarkupPercentage.Text) / 100;

  SubEmpPay.EmployeeDetails.PersonalPreferences.MinMarkupPercentage := TempPercent;
  edtMinMarkupPercentage.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';*)

end;

procedure TEmployeeInfo.EmployeeNoDblClick(Sender: TObject);
begin
  inherited;
  if fSubEmpPay.EmployeeDetails.EmployeeNo <> 0 then exit;

  if EmployeeIDForNo(fSubEmpPay.EmployeeDetails.ID) <> 0 then
    fSubEmpPay.EmployeeDetails.EmployeeNo := strtoint(CommonDbLib.GetSequenceNumber('EmployeeNo', LastEmployeeNo))
  else fSubEmpPay.EmployeeDetails.EmployeeNo :=fSubEmpPay.EmployeeDetails.ID;
end;

procedure TEmployeeInfo.cboDefaultClassCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  fSubEmpPay.EmployeeDetails.PostDb;
end;


procedure TEmployeeInfo.cboDefaultClassNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := False;
end;

procedure TEmployeeInfo.cboDefaultContactMethodEnter(Sender: TObject);
begin
  inherited;
  cboDefaultContactMethod.Style := csDropDownList;
end;

procedure TEmployeeInfo.chkIsTerminatedClick(Sender: TObject);
var
  aDateFinished: TDateTime;
begin
  inherited;
  DateFinished.Enabled := chkIsTerminated.Checked;
  lblDateFinished.Enabled := chkIsTerminated.Checked;
  if chkIsTerminated.Checked and (SubEmpPay.EmployeeDetails.DateFinished = 0) then begin

    aDateFinished := FindEmployeeLastPayDate;
    if aDateFinished > 0 then begin
      if commonLib.MessageDlgXP_Vista('Would you like to set Date Finished to last date employee was paid?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        SubEmpPay.EmployeeDetails.DateFinished := aDateFinished;
       // DateFinished.Date := aDateFinished;
      end;
    end
    else
      SubEmpPay.EmployeeDetails.DateFinished := now;

  end
  else if (not chkIsTerminated.Checked) and (SubEmpPay.EmployeeDetails.DateFinished > 0) then begin
    SubEmpPay.EmployeeDetails.EditDB;
    SubEmpPay.EmployeeDetails.Dataset.FieldByName('DateFinished').Clear;
  end;
end;

procedure TEmployeeInfo.DateFinishedChange(Sender: TObject);
begin
  inherited;
  if SubEmpPay.EmployeeDetails.DateFinished > 0 then
    chkIsTerminated.Checked := true;
end;

procedure TEmployeeInfo.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
//  aDateFinished: TDateTime;
begin
  inherited;
  if Value = BusobjEventVal_FailedInformationValidateData then begin
    //HandleInfoErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_Employee_Err_NoTitle                : begin
                                                  SetControlFocus(Title);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoFirstName            : begin
                                                  SetControlFocus(FirstName);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoLastName             : begin
                                                  SetControlFocus(LastName);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoDefaultDepartment    : begin
                                                  SetControlFocus(cboDefaultClass);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoDateStarted          : begin
                                                  SetControlFocus(DateStarted);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoDOB                  : begin
                                                  SetControlFocus(DOB);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoSex                  : begin
                                                  SetControlFocus(rgSex);
                                                  exit;
                                                end;
      BOR_Employee_Err_NoDateFinished         : begin
                                                  SetControlFocus(DateFinished);
//                                                  aDateFinished := FindEmployeeLastPayDate;
//                                                  if aDateFinished > 0 then begin
//                                                    if commonLib.MessageDlgXP_Vista('Would you like to set Date Finished to last date employee was paid?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
//                                                      SubEmpPay.EmployeeDetails.DateFinished := aDateFinished;
//                                                     // DateFinished.Date := aDateFinished;
//                                                    end;
//                                                  end
//                                                  else
//                                                    SubEmpPay.EmployeeDetails.DateFinished := now;
                                                  exit;
                                                end;
    end;
  end;
end;

procedure TEmployeeInfo.edtMaxDiscountExit(Sender: TObject);
begin
  SubEmpPay.EmployeeDetails.PersonalPreferences.PostDB;
end;

procedure TEmployeeInfo.EDTMinimumMarginPercentageExit(Sender: TObject);
begin
  inherited;
  SubEmpPay.EmployeeDetails.PersonalPreferences.PostDB;
end;

procedure TEmployeeInfo.btnDeleteUserGuiPrefsClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if commonLib.MessageDlgXP_Vista('Are you sure you want to delete all of the custom display preferences for ' +
     DSEmployeesInfo.DataSet.FieldByName('EmployeeName').AsString +
     ' and revert back to the global settings?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    if not TPreference.DeleteUserPrefs(DSEmployeesInfo.DataSet.FieldByName('EmployeeId').AsInteger,msg,TMyQuery(DSEmployeesInfo.DataSet).Connection) then begin
      CommonLib.MessageDlgXP_Vista('Unable to delete Preferences: ' + msg,mtWarning,[mbOk],0);
    end;
  end;
end;

procedure TEmployeeInfo.btnDefaultDashboardClick(Sender: TObject);
var
  customiseobj: TDashBoardObj;
begin
  inherited;
  if Isformvisible('TSalesDashboardGUI') then begin
    commonlib.MessageDlgXP_Vista('Please close the Dashboard before changing the configuration' , mtInformation, [mbok], 0);
    Exit;
  end;
  if Isformvisible('TMainDashboardGUI') then begin
    commonlib.MessageDlgXP_Vista('Please close the Dashboard before changing the configuration' , mtInformation, [mbok], 0);
    Exit;
  end;
  customiseobj:= TDashBoardObj.create(Self);
  try
    customiseobj.CreateDefaultGuiPref;
  finally
    Freeandnil(customiseobj);
  end;
end;

function TEmployeeInfo.FindEmployeeLastPayDate: TDateTime;
var
  qry: TERPQuery;
begin
  result:= 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := TMyQuery(FirstName.DataSource.DataSet).Connection;
    qry.SQL.Add('select Max(PayDate) as PayDate from tblpays');
    qry.SQL.Add('where EmployeeId = ' + IntToStr(FirstName.DataSource.DataSet.FieldByName('EmployeeId').AsInteger));
    qry.SQL.Add('and Paid = "T"');
    qry.Open;
    if not qry.IsEmpty then
      result := qry.FieldByName('PayDate').AsDateTime;
  finally
    qry.Free;
  end;
end;

procedure TEmployeeInfo.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  AddPhoneCallbutton(Phone);
  AddPhoneCallbutton(Mobile);
  AddPhoneCallbutton(AltPhone);
  inherited;
  pnlDevComments.visible := False;  Height := height -pnlDevComments.height;
  i:= yearof(date);
  DateStarted.CalendarAttributes.PopupYearOptions.StartYear := i-38;
  DateStarted.CalendarAttributes.PopupYearOptions.numberColumns:=4;
  DOB.CalendarAttributes.PopupYearOptions.startyear := i-50;
  DOB.CalendarAttributes.PopupYearOptions.numberColumns:=4;

  HtmlViewer.LoadFromString('<HTML>'+
                              'These Employee Limits can also be set from the <a HRef ="PersonalPreference"><U><B>Personal Preferences</B></U>.</a><BR>'+
                              'Validations for These Limits are Applied in Sales when the Employee has logged in.<BR>'+
                              'When Blank, the <a HRef ="CompanyPreference"><U><B>Company level Preference</B></U></a> will be used for the validations'+
                              '</HTML>');
end;

procedure TEmployeeInfo.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
var
  AccLevel: Integer;

  Function EmployeeForm: TfrmEmployee;
  begin
    result := nil;
    try
      result := TfrmEmployee(DSEmployeesInfo.dataset.owner);
    Except
    end;
  end;
begin
  inherited;
  AccLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPersonalPref');

  if AccLevel >= 5 then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription('FnPersonalPref'), mtWarning, [mbOK], 0);
    Exit;
  end;

  if sametext(src, 'CompanyPreference') then begin
    OpenPrefform('Sales' ,  'edtMaxDiscount' , AccLevel , False);

  end else if sametext(src, 'PersonalPreference') then begin
    if ((Appenv.Employee.EmployeeID <> DSEmployeesInfo.DataSet.FieldByName('EmployeeId').AsInteger) and
        (MessageDlgXP_Vista('To View Personal Preferences for  '+ Quotedstr(DSEmployeesInfo.DataSet.FieldByName('EmployeeName').AsString)+
                            ', Please Login as '+ Quotedstr(DSEmployeesInfo.DataSet.FieldByName('EmployeeName').AsString)+'.'+NL+NL+
                            'Do You Wish To save Current Changes and Open Your ('+Appenv.Employee.EmployeeName +') Personal Preference?', mtConfirmation, [mbYes, mbNo], 0) =mrYes))
                          OR
      ((Appenv.Employee.EmployeeID = DSEmployeesInfo.DataSet.FieldByName('EmployeeId').AsInteger) and
      (MessageDlgXP_Vista('Do You Wish To save Current Changes and Open your Personal Preference?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then begin
      try
        With EmployeeForm do begin
          if not Savencommit then exit;
          OpenPrefform('Employee' ,  'edtMaxDiscount' , AccLevel , False);
          CloseWait;
        end;
      Except
        //Kill the exception f
      end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TEmployeeInfo);

end.
