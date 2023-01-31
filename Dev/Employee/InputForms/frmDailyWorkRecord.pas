unit frmDailyWorkRecord;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/10/05 1.00.00  MV   Initial verson.
 31/10/05 1.00.01  MV   Modified to create seven mandatory detail records
 06/01/06  1.00.18 DSP  Changed the parameter passed to AdjustCustomFields
                        from wwDBGrid1 to tblDetails.
 01/02/06  1.00.19 IJB  Rearanged layout, default Name to current user.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, MemDS, wwdbedit, Grids, Wwdbigrd, Wwdbgrid,
  wwdbdatetimepicker, wwdblook, Menus, AdvMenus, Shader;

type
  TfrmDailyWorkRecord = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTop: TDNMPanel;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    DSMaster: TDataSource;
    tblMaster: TMyQuery;
    tblDetails: TMyQuery;
    DSDetails: TDataSource;
    qryEmployeeID: TMyQuery;
    tblMasterGlobalRef: TStringField;
    tblMasterDailyWorkRecordID: TIntegerField;
    tblMasterIssuedTo: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterZone: TStringField;
    tblDetailsGlobalRef: TStringField;
    tblDetailsDailyWorkRecordLineID: TIntegerField;
    tblDetailsDailyWorkRecordID: TIntegerField;
    tblDetailsDate: TDateTimeField;
    tblDetailsCustomField1: TStringField;
    tblDetailsCustomField2: TStringField;
    tblDetailsCustomField3: TStringField;
    tblDetailsCustomField4: TStringField;
    tblDetailsCustomField5: TStringField;
    tblDetailsCustomField6: TStringField;
    tblDetailsCustomField7: TStringField;
    tblDetailsCustomField8: TStringField;
    tblDetailsCustomField9: TStringField;
    tblDetailsCustomField10: TStringField;
    tblDetailsAUSCompliance: TStringField;
    tblDetailsAUSStandard: TStringField;
    tblDetailsComments: TStringField;
    tblDetailsDownTimeReason: TStringField;
    tblMasterWeekEnding: TDateField;
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label3: TLabel;
    dtWeekEnding: TwwDBDateTimePicker;
    lblIssuedTo: TLabel;
    cboIssuedTo: TwwDBLookupCombo;
    Label1: TLabel;
    edtZone: TwwDBEdit;
    tblDetailsStartTime: TTimeField;
    tblDetailsFinishTime: TTimeField;
    grdDailyrecord: TwwDBGrid;
    tblDetailsDownTime: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure tblDetailsBeforeInsert(DataSet: TDataSet);
    procedure tblDetailsAfterInsert(DataSet: TDataSet);
    procedure grdDailyrecordEnter(Sender: TObject);
    procedure dtWeekEndingCloseUp(Sender: TObject);
    procedure cboEmployeeEnter(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboIssuedToCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    Procedure showDetials(Sender :TObject);
    procedure tblDetailsDateChange(Sender: TField);
  private
    FDetailsRecord: integer;
    //GeneratingRec :boolean;
    procedure DoOpenData;
    function SaveData: boolean;
    function MasterValid(ShowError :Boolean = False) :Boolean;
  public
    procedure UpdateMe; override;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions,
  FormFactory,    
  CommonLib,  DAteUtils, 
  CommonDbLib, DNMLib, AppEnvironment, FastFuncs, tcConst;
  
const
  MAX_DETAILS_RECORDS = 7;

procedure TfrmDailyWorkRecord.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  //GeneratingRec := False;
  inherited;
  if ErrorOccurred then Exit;
 GuiPrefs.Active := True;
end;

procedure TfrmDailyWorkRecord.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfrmDailyWorkRecord.FormShow(Sender: TObject);
begin
  try
    inherited;
    if ErrorOccurred then Exit;
    DoOpenData;
    SavefieldPrefs(GuiPrefs);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
  end;
end;

procedure TfrmDailyWorkRecord.DoOpenData;
begin
  if tblMaster.State in [dsEdit,dsInsert] then tblMaster.Cancel;
  if tblDetails.State in [dsEdit,dsInsert] then tblDetails.Cancel;
  RollbackTransaction;

  tblMaster.Close;
  tblDetails.Close;

  tblMaster.connection := MyConnection;
  tblDetails.connection := MyConnection;

  tblMaster.ParamByName('ID').asInteger := KeyID;
  tblDetails.ParamByName('ID').asInteger := KeyID;
  tblMaster.Open;
  tblDetails.Open;
  qryEmployeeID.Open;

  BeginTransaction;

  if KeyID <> 0 then begin
  end else begin
    tblMaster.Insert;
    if qryEmployeeID.Locate('EmployeeID', AppEnv.Employee.EmployeeID, []) then
      tblMasterEmployeeID.AsInteger:= qryEmployeeID.FieldByName('EmployeeID').AsInteger;
      SetControlFocus(cboIssuedTo);
  end;

  if not DataState.IsActive then DataState.Activate
  else DataState.Dirty := false;
end;

procedure TfrmDailyWorkRecord.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  SetControlFocus(BtnSave);
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  DataState.Dirty := false;
  Close;
end;

procedure TfrmDailyWorkRecord.actMainNewExecute(Sender: TObject);
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  DoOpenData;
end;

procedure TfrmDailyWorkRecord.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDailyWorkRecord.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if ErrorOccurred then Exit;
  CanClose := false;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveData then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          RollbackTransaction;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

function TfrmDailyWorkRecord.SaveData: boolean;
begin
  Result := false;
  if MasterValid(True) then begin
    if tblMaster.State in [dsInsert, dsEdit] then tblMaster.Post;
    if tblDetails.State in [dsInsert, dsEdit] then tblDetails.Post;
    Result := true;
  end;
end;

procedure TfrmDailyWorkRecord.UpdateMe;
begin
  // Close/re-open queryies to refresh data
end;

procedure TfrmDailyWorkRecord.tblDetailsBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  if tblDetails.RecordCount >= MAX_DETAILS_RECORDS then Abort;

  FDetailsRecord := tblDetails.RecNo;
end;

procedure TfrmDailyWorkRecord.tblDetailsAfterInsert(DataSet: TDataSet);
begin
  inherited;

  tblDetails.FieldByName('Date').AsDateTime := tblMaster.FieldByName('WeekEnding').AsDateTime - (6 - FDetailsRecord);
end;

procedure TfrmDailyWorkRecord.grdDailyrecordEnter(Sender: TObject);
var
    LoopRecords :Integer;
    Dt :TDatetime ;
    qry :TMyQuery;
begin
  inherited;
//GeneratingRec := True;
Try
  if not MasterValid then Exit;
  if tblMaster.state in [dsEdit, dsInsert] then tblMaster.Post;
  Qry :=  TMyQuery.Create(nil);
  With Qry do Try
          connection := commondbLib.GetSharedMyDacConnection;
          SQL.add('SELECT * FROM tbldailyworkrecord where Weekending = '+
                QuotedStr(FormatDateTime(MysqlDateFormat , tblMaster.FieldByName('WeekEnding').AsDateTime))  +
                ' and EmployeeId = ' + FastFuncs.IntToStr(tblMasterEmployeeID.AsInteger) +
                ' and IssuedTo = ' + FastFuncs.IntToStr(tblMasterIssuedTo.asInteger) ) ;
          open;
          if recordcount > 0 then 
            if fieldByname('DailyworkRecordId').asInteger <> 0 then
                if KeyId <> fieldByname('DailyworkRecordId').asInteger then
                    if (KeyId = 0 )  or ((KeyId <> 0 ) and (
                        CommonLib.MessageDlgXP_Vista('Another record already exists. Do you wish to open that record? '+ chr(13) +
                            'Opening another record will cancel the changes made here.'  , mtconfirmation , [mbYes,mbNo] , 0) = mrYes )) then begin
                            KeyId := fieldByname('DailyworkRecordId').asInteger;
                            DoOpenData;
                    end else begin
                        SetControlFocus(cboEmployee);
                        Exit;
                    end;
      Finally
        if Active then close;
        Free;
      end;
      dt := incDay(DateOf(tblMasterWeekEnding.asDatetime), -6);
      if KeyId = 0 then begin
            for LoopRecords := 1 to 7 do begin
                if not (tblDetails.locate('DailyWorkRecordID;Date' , VarArrayof([tblMasterDailyWorkRecordID.AsInteger , dt]) , []) ) then begin
                    tblDetails.Append;
                    tblDetailsDailyWorkRecordID.AsInteger := tblMasterDailyWorkRecordID.AsInteger;
                    tblDetailsDate.asDateTime := dt;
                    tblDetails.Post;
                    dt := incDay(dt);
                end;
            end;
      end;
      if screen.ActiveControl.name <> grdDailyrecord.name then
        SetControlFocus(grdDailyrecord);
Finally
    //GeneratingRec:= False;
end;
end;


Procedure TfrmDailyWorkRecord.showDetials(Sender :TObject);
begin
    if (FastFuncs.Trim(cboEmployee.Text) <> '') and
        (dtWeekEnding.Date <> 0) and
        (FastFuncs.Trim(cboIssuedTo.Text) <> '') then begin
        grdDailyrecordEnter(sender);
    end;

end;
Function TfrmDailyWorkRecord.MasterValid(ShowError :Boolean = False) :Boolean;
begin
    REsult := False;
    if FastFuncs.Trim(cboEmployee.Text) = '' then begin
        if showerror then
            CommonLib.MessageDlgXP_Vista('Employee should not be blank.' ,mtWarning , [mbOk] , 0);
        SetControlFocus(cboEmployee);
        Exit;
    end;
    if FastFuncs.Trim(cboIssuedTo.Text) = '' then begin
        if showerror then
            CommonLib.MessageDlgXP_Vista('Issued To should not be blank' ,mtWarning , [mbOk] , 0);
        SetControlFocus(cboIssuedTo);
        Exit;
    end;
    if dtWeekEnding.Date = 0 then begin
        if showerror then
            CommonLib.MessageDlgXP_Vista('Weekending date should not be blank.' ,mtWarning , [mbOk] , 0);
        SetControlFocus(dtWeekEnding);
        Exit;
    end;
    Result := true;
end;

procedure TfrmDailyWorkRecord.dtWeekEndingCloseUp(Sender: TObject);
begin
  inherited;
    if dtWeekEnding.Date = 0 then Exit;

    if tblMaster.State in [dsEdit,dsInsert] then tblMaster.Post;
    if DayOfTheWeek(tblMasterWeekEnding.asDatetime) <> AppEnv.CompanyPrefs.EndWeekDay then begin
        if not (tblMaster.State in [dsEdit,dsInsert]) then tblMaster.Edit;
        tblMasterWeekEnding.asDateTime := CurrentWeekEndDate(tblMasterWeekEnding.asDateTime);
        tblMaster.Post;
    end;
    showDetials(sender);
end;

procedure TfrmDailyWorkRecord.cboEmployeeEnter(Sender: TObject);
begin
  inherited;
    if tblDetails.Recordcount > 0 then SetControlFocus(grdDailyrecord);
end;

procedure TfrmDailyWorkRecord.cboEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    showDetials(sender);
end;

procedure TfrmDailyWorkRecord.cboIssuedToCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    showDetials(sender);
end;

procedure TfrmDailyWorkRecord.tblDetailsDateChange(Sender: TField);
begin
  inherited;
    {if GeneratingRec then exit;
    GeneratingRec := True;
    if (DateOf(Sender.Value) > DateOf(tblMasterWeekEnding.AsDatetime)) or
        (DateOf(Sender.Value) < incDay(DateOf(tblMasterWeekEnding.AsDatetime), -6)) then
        tbldetailsDate.Value := tbldetailsDate.oldvalue;
    GeneratingRec := False;}
end;

initialization
  RegisterClassOnce(TfrmDailyWorkRecord);
  with FormFact do begin
    RegisterMe(TfrmDailyWorkRecord, 'TDailyWorkListingGUI_*=DailyWorkRecordID');
  end;

finalization
  UnRegisterClass(TfrmDailyWorkRecord);
end.
