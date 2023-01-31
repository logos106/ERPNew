unit frmEmployeeLeaveRequests;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusObjEmployeeLeaveRequests, wwdblook,
  wwdbdatetimepicker, Spin, Mask, wwdbedit;

type
  TfmEmployeeLeaveRequests = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cboEmployeeLookup: TERPQuery;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    qryEmployeeLeaveRequests: TERPQuery;
    dsEmployeeLeaveRequests: TDataSource;
    qryEmployeeLeaveRequestsID: TIntegerField;
    qryEmployeeLeaveRequestsGlobalRef: TWideStringField;
    qryEmployeeLeaveRequestsEmployeeId: TIntegerField;
    qryEmployeeLeaveRequestsLeaveDate: TDateField;
    qryEmployeeLeaveRequestsActive: TWideStringField;
    qryEmployeeLeaveRequestsmsTimeStamp: TDateTimeField;
    qryEmployeeLeaveRequestsmsUpdatesitecode: TWideStringField;
    qryEmployeeLeaveRequestsEmployeename: TWideStringField;
    pnlDateRange: TDNMPanel;
    Qrytblleavetypes: TERPQuery;
    DNMPanel4: TDNMPanel;
    Label3: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qryEmployeeLeaveRequestsLeavetypeID: TIntegerField;
    qryEmployeeLeaveRequestsLeavetype: TWideStringField;
    QrytblleavetypesLeaveTypeID: TIntegerField;
    QrytblleavetypesLeaveType: TWideStringField;
    SpinButton1: TSpinButton;
    dtFrom: TwwDBDateTimePicker;
    lblFrom: TLabel;
    edtHours: TwwDBEdit;
    qryEmployeeLeaveRequestsHours: TFloatField;
    Label1: TLabel;
    qryEmployeeLeaveRequestsStartTime: TDateTimeField;
    qryEmployeeLeaveRequestsEndtime: TDateTimeField;
    dtTotime: TwwDBDateTimePicker;
    Label2: TLabel;
    Label4: TLabel;
    edtDays: TwwDBEdit;
    SpinButton2: TSpinButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure qryEmployeeLeaveRequestsAfterInsert(DataSet: TDataSet);
    procedure dtToChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure edtDaysChange(Sender: TObject);
    procedure qryEmployeeLeaveRequestsAfterOpen(DataSet: TDataSet);
  private
    EmpLeaveRequest: TEmpLeaveRequests;
    fdhours :double;
    fdLeaveRequestTo: TDateTime;
    fdLeaveRequestfrom: TDateTime;
    function SaveRecord: Boolean;
    procedure sethours(const Value: double);
    Property hours : double read fdhours write sethours;
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
    Property LeaveRequestfrom :TDateTime read fdLeaveRequestfrom write fdLeaveRequestfrom;
    Property LeaveRequestTo :TDateTime read fdLeaveRequestTo write fdLeaveRequestTo;
  end;


implementation

uses CommonLib, BusObjConst, tcDataUtils , dateutils, ManufactureLib,
  FormFactory, AppEnvironment;

{$R *.dfm}



procedure TfmEmployeeLeaveRequests.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmEmployeeLeaveRequests.SaveRecord :Boolean;
begin
  result:= False;
  EmpLeaveRequest.PostDB;
  if not(EmpLeaveRequest.Save) then exit;
  Result:= True;
  //result := EmpLeaveRequest.LeaveRequest(DtFrom.Datetime, dtTotime.DateTime , EmpLeaveRequest.employeeID, EmpLeaveRequest.Hours);
(*var
  dt:TDateTime;
  leavecreated:Boolean;
begin
  result:= False;
  EmpLeaveRequest.PostDB;
  if pnlDateRange.Visible = True then begin
    EmpLeaveRequest.connection.BeginNestedTransaction;
    try
      if (dtfrom.Date =0) or (dtto.Date =0) or (dtfrom.Date > dtto.Date) then begin
        MessageDlgXP_Vista('Date Range selected is invalid.', mtWarning, [mbOK], 0);
        Exit;
      end;

      dt := dtFrom.Date;
      dt := incday(dt,1);
      leavecreated:=False;
      while dt <= DtTo.Date do begin
        if EmpLeaveRequest.Isworkingday(dt) then begin
          EmpLeaveRequest.New;
          EmpLeaveRequest.LeaveDate := dt;
          EmpLeaveRequest.hours := hours;
        end;
        dt := incday(dt,1);
      end;
      if leavecreated then begin
        EmpLeaveRequest.Connection.CommitNestedTransaction;
        REsult := True;
      end;
    Except
      on E:Exception do begin
        EmpLeaveRequest.Connection.RollbackNestedTransaction;
      end;
    end;
  end else begin
    if not(EmpLeaveRequest.Save) then exit;
  end;
  Result:= True;*)
end;

procedure TfmEmployeeLeaveRequests.sethours(const Value: double);
begin
  fdhours := Value;
  edtHours.Text := floattostr(Value);
end;

procedure TfmEmployeeLeaveRequests.SpinButton1DownClick(Sender: TObject);
begin
  inherited;
  hours := hours - 0.5;
  if hours <0.5 then hours := 0.5;
end;

procedure TfmEmployeeLeaveRequests.SpinButton1UpClick(Sender: TObject);
begin
  inherited;
  hours := hours + 0.5;
  if hours >7.5 then hours := 7.5;
end;

procedure TfmEmployeeLeaveRequests.SpinButton2DownClick(Sender: TObject);
begin
  inherited;
  try
    Setcontrolfocus(edtDays);
    edtDays.Text :=  inttostr(strToInt(edtDays.Text)-1);
    if strToInt(edtDays.Text) <1 then edtDays.Text := '1';
  except
    on E:Exception do begin
      edtDays.Text := '1';
    end;
  end;


end;

procedure TfmEmployeeLeaveRequests.SpinButton2UpClick(Sender: TObject);
begin
  inherited;
  try
    Setcontrolfocus(edtDays);
    edtDays.Text :=  inttostr(strToInt(edtDays.Text)+1);
  except
    on E:Exception do begin
      edtDays.Text := '1';
    end;
  end;

end;

procedure TfmEmployeeLeaveRequests.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  EmpLeaveRequest.Connection.CommitTransaction;
  EmpLeaveRequest.dirty := False;
  Self.Close;

end;

procedure TfmEmployeeLeaveRequests.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
{----}if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
          if Sender is TEmpLeaveRequests then TEmpLeaveRequests(Sender).Dataset  := qryEmployeeLeaveRequests;
{----}end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and (Sender is TEmpLeaveRequests ) then begin
          dtToTime.datetime :=TEmpLeaveRequests(Sender).endtime;
{----}end else if (Eventtype = BusobjEvent_change) and (Value = Busobjeventval_LeaveDate) then begin
          dtToTime.datetime :=TEmpLeaveRequests(Sender).endtime;
{----}end;
end;

procedure TfmEmployeeLeaveRequests.dtToChange(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl = dtToTime) then exit;
  while not(EmpLeaveRequest.Isworkingday(dtToTime.Date)) or (dtToTime.Date < EmpLeaveRequest.LeaveDate) do dtToTime.Date  := incday(dtToTime.Date);

end;

procedure TfmEmployeeLeaveRequests.edtDaysChange(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl = edtDays) then exit;
  if edtDays.Text ='' then exit;
  try
    EmpLeaveRequest.hours := (strtoint(edtDays.Text)* Appenv.companyprefs.SecondsInaday)/60/60;
  Except

  end;
end;

procedure TfmEmployeeLeaveRequests.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

Procedure TfmEmployeeLeaveRequests.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if EmpLeaveRequest.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          EmpLeaveRequest.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmEmployeeLeaveRequests.FormCreate(Sender: TObject);
begin
  fdLeaveRequestTo:=0;
  fdLeaveRequestfrom:=0;
  inherited;
  EmpLeaveRequest := TEmpLeaveRequests.CreateWithNewConn(Self);
  EmpLeaveRequest.Connection.connection := Self.MyConnection;
  EmpLeaveRequest.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmEmployeeLeaveRequests.FormShow(Sender: TObject);
begin
  inherited;
  EmpLeaveRequest.Load(KeyID);
  EmpLeaveRequest.connection.BeginTransaction;
  if EmpLeaveRequest.count=0 then EmpLeaveRequest.new;
  openQueries;
end;

procedure TfmEmployeeLeaveRequests.qryEmployeeLeaveRequestsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if fdLeaveRequestfrom <> 0 then dtFrom.Date := fdLeaveRequestfrom else dtFrom.Date := EmpLeaveRequest.LeaveDate;
  if fdLeaveRequestTo   <> 0 then dtToTime.Date   := fdLeaveRequestTo   else dtToTime.Date := EmpLeaveRequest.LeaveDate;
end;

procedure TfmEmployeeLeaveRequests.qryEmployeeLeaveRequestsAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  if EmpLeaveRequest.hours > Appenv.companyprefs.SecondsInaday/60/60 then
    edtDays.Text := inttostr(trunc(EmpLeaveRequest.hours/(Appenv.companyprefs.SecondsInaday/60/60)))
  else edtDays.Text := '';
end;

initialization
  RegisterClassOnce(TfmEmployeeLeaveRequests);
  with FormFact do begin
    RegisterMe(TfmEmployeeLeaveRequests, 'TEmployeeLeaveRequestsGUI_*=ID');
  end;


end.

