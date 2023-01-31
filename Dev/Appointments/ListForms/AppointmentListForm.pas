{

 Date       Version  Who  What
 ---------- -------- ---  ------------------------------------------------------
 15/04/05  1.00.01 BJ  GlobalRef field is added to the Grid
 28/06/05  1.00.02 BJ  Added a new column to the grid to indicate whether the
                       current record is a repeated record or not.
                       This field gives as idea of the records getting affected
                       when an appointment is cancelled or rescheduled.
 15/07/05  1.00.03 DMS Selecting the filter will show only active appointments
                       unless user selects 'Deleted' option.
 29/07/05  1.00.04 DSP Changed the spelling of 'Reschedulled' to
                       'Rescheduled'.
 03/07/05  1.00.05 DSP Added functionality to delete selected records.
 07/09/05  1.00.06 IJB Modified to use new filtering on base listing.
 12/09/05  1.00.07 DSP The 'Active' field was being displayed twice when
                       the 'Deleted' radio button was selected. This has been
                       fixed.
 05/01/06  1.00.08 BJ  For the search engin to work
                       The query in the list should have 'AS' for each field
                       Also each field should be given in a separate line. query chaned for that
 20/01/06  1.00.09 BJ  defualt value for the search mode is  smFullList so that the form opens
                       with the list of appointments.
 08/02/07  1.00.10 DSP Added 'Rep Type' field.

}

unit AppointmentListForm;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, BaseListingForm, DB, Grids,
  Wwdbigrd, Wwdbgrid, StdCtrls, ComCtrls,AdvOfficeStatusBar, Buttons, DNMSpeedButton, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, ExtCtrls, Dialogs,
   wwdblook, MessageInterface, Shader, kbmMemTable, DAScript,
  MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAppointmentListGUI = class(TBaseListingGUI)
    btnInvoice: TDNMSpeedButton;
    chkInvoice: TCheckBox;
    Label5: TLabel;
    pnlConversion: TDNMPanel;
    lblSelectAll: TLabel;
    lblBarCode: TLabel;
    chkSelectAll: TCheckBox;
    actInvoice: TAction;
    btnDelete: TDNMSpeedButton;
    qryMainAppointmentCount: TIntegerField;
    qryMainScheduleFrom: TWideStringField;
    qryMainScheduleTo: TWideStringField;
    qryMainActualfrom: TWideStringField;
    qryMainActualto: TWideStringField;
    qryMainStart_Time: TWideStringField;
    qryMainRepeatStatus: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainAppointID: TIntegerField;
    qryMainAppointmentNo: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainEndDate: TDateTimeField;
    qryMainClassID: TIntegerField;
    qryMainAppDateDay: TWideStringField;
    qryMainAppDate: TDateField;
    qryMainStartTime: TDateTimeField;
    qryMainEndTime: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainAppointmentDetails: TWideStringField;
    qryMainTrainerID: TIntegerField;
    qryMainRep: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainFeedback: TWideStringField;
    qryMainCancellation: TWideStringField;
    qryMainRescheduled: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainTotalInc: TFloatField;
    qryMainTotalCost: TFloatField;
    qryMainServiceDescription: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainEnteredBy: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainRepType: TWideStringField;
    qryMainClientType: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainActual_AppDate: TDateField;
    qryMainActual_Endtime: TDateTimeField;
    qryMainActual_Start_time: TWideStringField;
    qryMainActual_End_time: TWideStringField;
    qryMainCustomerPhone: TWideStringField;
    qryMainCustomerFaxNumber: TWideStringField;
    qryMainCustomerMobile: TWideStringField;
    qryMainCustomerAltPhone: TWideStringField;
    qryMainCustomerAltContact: TWideStringField;
    qryMainActTotalHrs: TFloatField;
    qryMainActual_StartTime: TDateTimeField;
    qryMainEnd_Time: TWideStringField;
    qryMainTotalHrs: TFloatField;
    qryMainUnavailable: TWideStringField;
    qryMainGoLiveApp: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure RefreshTotals; override;
    procedure FormShow(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure chkInvoiceClick(Sender: TObject);
    procedure chkSelectAllClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    fMsgHandler: TMsgHandler;
    procedure ConvertToInvoice;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
    CallingTrainerID: integer;
  end;

implementation

{$R *.dfm}

uses
  BusObjAppointments, DateUtils, SysUtils, Forms, CommonLib, tcDataUtils,
  BaseInputForm, AppEnvironment, FastFuncs, tcConst;

procedure TAppointmentListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('F') + ' AND Deleted = ' + QuotedStr('F');
      end;

    1:
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T') + ' AND Deleted = ' + QuotedStr('F');
      end;

    2: 
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
    3: 
      begin
      end;
  end;

  inherited;

  chkSelectAll.Checked := false;;
  //  grdMain.Options := grdMain.Options - [dgMultiSelect];
end;

procedure TAppointmentListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtFrom').AsDate := filterdateFrom;
  qryMain.Params.ParamByName('dtTo').AsDate := filterDateto;

  inherited;

  grdMain.ColumnByName('AppDateDay').DisplayLabel := 'Day';
  QrymainENDDate.DisplayFormat := FormatSettings.ShortDateformat;
  QrymainActual_Endtime.DisplayFormat := FormatSettings.ShortDateformat;
  grdMain.RemoveField('Active');
end;

procedure TAppointmentListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    Form := GetComponentByClassName('TAppointmentGUI');
    if Assigned(Form) then begin
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    //  MainForm.NewAppointmentClick(Sender);
  finally
    EnableForm;
  end;  
end;

procedure TAppointmentListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if not Empty(qryMainEndDate.AsString) and (qryMainStartTime.AsDateTime < qryMainEndDate.AsDateTime) then begin
    qryMainTotalHrs.AsFloat := HourSpan(qryMainStartTime.AsDateTime, qryMainEndDate.AsDateTime);
  end else begin
    qryMainTotalHrs.AsFloat := 0.0;
  end;


  if not Empty(QrymainActual_EndTime.AsString) and (QrymainActual_StartTime.AsDateTime < QrymainActual_EndTime.AsDateTime) then begin
    qryMainActTotalHrs.AsFloat := HourSpan(QrymainActual_StartTime.AsDateTime, QrymainActual_EndTime.AsDateTime);
  end else begin
    qryMainActTotalHrs.AsFloat := 0.0;
  end;

  qryMainAppointmentCount.asInteger := tcDataUtils.ClientAppointmentCount(qryMainClientID.AsInteger,qryMainStartTime.AsDateTime);
  qryMainScheduleFrom.asString:= FormatDateTime(FormatSettings.ShortDateformat , qryMainAppDate.asDatetime        ) + ' ' +QrymainStart_Time.AsString;
  if qrymainEndDate.asDAtetime        <> 0 then qryMainScheduleTo.asString  := formatDatetime(FormatSettings.ShortDateformat, qrymainEndDate.asDAtetime        ) + ' ' +qryMainEndTime.asString;
  if qryMainActual_AppDate.asDateTime <> 0 then qryMainActualfrom.asString  := FormatDatetime(FormatSettings.ShortDateformat , qryMainActual_AppDate.asDateTime ) + ' ' +qryMainActual_Start_time.asString;
  if qryMainActual_Endtime.asDateTime <> 0 then qryMainActualto.asString    := FormatDatetime(FormatSettings.ShortDateformat , qryMainActual_Endtime.asDateTime ) + ' ' +qryMainActual_End_time.asString;
end;

procedure TAppointmentListGUI.RefreshTotals;
var
  dTotHrs: double;
  dactTotHrs:Double;
  dTotCost: double;
  dTotSell: double;
  bm: TBookmark;
begin
  inherited;
  dTotHrs := 0;
  dactTotHrs := 0;
  dTotCost := 0;
  dTotSell := 0;
  bm := qryMain.GetBookmark;
  Try
    qryMain.DisableControls;
    with qryMain do begin
      First;
      while not Eof do begin
        dTotHrs := dTotHrs + qryMainTotalHrs.AsCurrency;
        dactTotHrs := dactTotHrs + QrymainActtotalHrs.asFloat;
        dTotCost := dTotCost + qryMainTotalCost.AsCurrency;
        dTotSell := dTotSell + qryMainTotalInc.AsCurrency;
        Next;
      end;
    end;
  finally
    qryMain.GotoBookmark(bm);
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('TotalHrs').FooterValue := FloatToStrF(dTotHrs, ffFixed, 15, 2);
  grdMain.ColumnByName('ActtotalHrs').FooterValue := FloatToStrF(dactTotHrs, ffFixed, 15, 2);
  grdMain.ColumnByName('TotalCost').FooterValue := FloatToStrF(dTotCost, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalInc').FooterValue := FloatToStrF(dTotSell, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.Options := grdMain.Options + [dgMultiSelect];
end;

procedure TAppointmentListGUI.FormShow(Sender: TObject);
begin
  fbEnableWebSearch := true;
  SearchMode := smFullList;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('AppointID,ClientID,ClassID,TrainerID,Active');
  inherited;
 // grdMain.RemoveField('Active');
end;

procedure TAppointmentListGUI.btnInvoiceClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    ConvertToInvoice;
  finally
    EnableForm;
  end;  
end;

procedure TAppointmentListGUI.ConvertToInvoice;
var
  i: integer;
  sFailedMsg, sConvertedMsg, sMsg: string;
  Appointment: TAppointment;
  lResult: Boolean;
  iInvoiceID: Integer;
  lAppDate: TDateTime;
  Form: TBaseInputGUI;
//  MsgObj: TMsgObj;
begin
  sConvertedMsg := '';
  sFailedMsg := '';
  iInvoiceID := 0;
  lResult := False;
  Appointment := TAppointment.Create(nil);
  try
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      try
        Appointment.Connection.BeginTransaction;
        Appointment.Load(qryMainAppointID.AsInteger);
        Appointment.SilentMode := True;

        lResult := Appointment.ConvertToInvoice(iInvoiceID);

        if Appointment.Actual_AppDate <> 0 then
          lAppDate := Appointment.Actual_AppDate
        else
          lAppDate := Appointment.AppDate;

        if lResult then begin
          if sConvertedMsg <> '' then
            sConvertedMsg := sConvertedMsg + #13#10;
          sConvertedMsg := Format('%sAppointmentDate: %s, Company: %s, Employee: %s',
            [sConvertedMsg, FormatDateTime(FormatSettings.ShortDateformat, lAppDate),
            Trim(Appointment.Client.ClientName), Trim(Appointment.TrainerName)]);
          if Appointment.ResultStatus.Count > 0 then
            sConvertedMsg := sConvertedMsg + #13#10 + Appointment.ResultStatus.GetPrefixedMessages('    ');
        end else begin
          if sFailedMsg <> '' then
            sFailedMsg := sFailedMsg + #13#10;
          sFailedMsg := Format('%sAppointmentDate: %s, Company: %s, Employee: %s',
            [sFailedMsg, FormatDateTime(FormatSettings.ShortDateformat, lAppDate),
            Trim(Appointment.Client.ClientName), Trim(Appointment.TrainerName)]);
          if Appointment.ResultStatus.Count > 0 then
            sFailedMsg := sFailedMsg + #13#10 + Appointment.ResultStatus.GetPrefixedMessages('    ');
        end;
      except
        on E: Exception do begin
          lResult := False;
          sFailedMsg := Format('%sAppointmentDate: %s, Company: %s, Employee: %s'#13#10'    Exception %s',
            [sFailedMsg, FormatDateTime(FormatSettings.ShortDateformat, qryMainAppDate.AsDateTime),
            Trim(qryMainCompany.AsString), Trim(qryMainRep.AsString), E.Message]);
        end;
      end;
      if lResult then begin
        Appointment.Connection.CommitTransaction;
        Appointment.Connection.BeginTransaction;
      end else begin
        Appointment.Cancel;
        Appointment.Connection.RollbackTransaction;
        Appointment.Connection.BeginTransaction;
      end;
    end;
  finally
    FreeandNil(Appointment);
  end;

  sMsg := '';
  if sFailedMsg <> ''  then
    sMsg := 'The following appointment(s) are not converted:'#13#10 + sFailedMsg;
  if sConvertedMsg <> '' then begin
    if sMsg <> '' then
      sMsg := sMsg + '____________________________________________________________'#13#10#13#10;
    sMsg := sMsg + 'The following appointment(s) are converted:'#13#10 + sConvertedMsg;
  end;
  if sMsg <> '' then
    CommonLib.MessageDlgXP_Vista(sMsg, mtInformation, [mbOK], 0);
  chkSelectAll.Checked := false;

  if (iInvoiceID <> 0) and (grdMain.SelectedList.Count = 1) and AppEnv.CompanyPrefs.ShowInvoiceFormwhenApptInvoiced then begin
    if AppEnv.CompanyPrefs.ShowInvoiceFormwhenApptInvoiced then begin
        Form := TBaseInputGUI(GetComponentByClassName('TInvoiceGUI'));
        if Assigned(Form) then begin
          Form.KeyID := iInvoiceID;
          Form.FormStyle := fsMDIChild;
          Form.BringToFrontSoon;
        end;
    end;
  end;
end;

procedure TAppointmentListGUI.chkInvoiceClick(Sender: TObject);
begin
  inherited;
  lblNote.Visible := not chkInvoice.Checked;  // "Double click on any field to get more info..."
  pnlConversion.Visible := chkInvoice.Checked;
  btnInvoice.Enabled := chkInvoice.Checked;
  if chkInvoice.Checked then begin
    grdMain.Options := grdMain.Options + [dgMultiSelect];
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
  end else begin
    grdMain.UnselectAll;
    grdMain.Options := grdMain.Options - [dgMultiSelect];
  end;
end;

procedure TAppointmentListGUI.chkSelectAllClick(Sender: TObject);
begin
  inherited;
  if chkSelectAll.Checked then begin
    grdMain.SelectAll;
  end else begin
    grdMain.UnselectAll;
  end;
end;

procedure TAppointmentListGUI.grdMainDblClick(Sender: TObject);
var
  ActiveField: TField;

  function CalledFromCustomerCard: boolean;
  begin
    result:= false;
    if Assigned(self.Parent) and Assigned(self.Parent.Owner) and
    self.Parent.Owner.ClassNameIs('TfrmCustomer') then
      result:= true;
  end;

begin
  if not(self.owner is tform) then begin
    CallingTrainerID := -1;
    SubsequentID := '';

    if not qryMainTrainerID.IsNull then
      CallingTrainerID := qryMainTrainerID.AsInteger;

    ActiveField := grdMain.GetActiveField;

    { if this is embebed in the customer card history tab dont try and open
      customer (causes exception), just open appointment }
    if (not CalledFromCustomerCard) and Assigned(ActiveField) then begin
      if Sysutils.SameText(ActiveField.FieldName, 'Company') then
        SubsequentID := Chr(95) + qryMain.FieldByName('ClientType').AsString;
    end;
  end;

  inherited;
end;

procedure TAppointmentListGUI.btnDeleteClick(Sender: TObject);
var
  x: integer;
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Delete selected record(s)?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Try
      ProcessingCursor(True);
      qryMain.DisableControls;
      try
        for x:= 0 to  grdMain.SelectedList.Count -1 do begin
          qryMain.GotoBookmark(grdMain.SelectedList[x]);
          qryMain.FreeBookmark(grdMain.SelectedList[x]);
          try
            qryMain.Connection.ExecSQL('UPDATE tblappointments SET Active= "F" WHERE AppointID=' +
              IntToStr(qryMain.FieldByName('AppointID').AsInteger), []);
          except
          end;
        end;
        grdMain.SelectedList.Clear;
        Self.RefreshQuery;
      finally
        qryMain.EnableControls;
        ProcessingCursor(False);
      end;
    except
    end;
  end;
end;

procedure TAppointmentListGUI.FormCreate(Sender: TObject);
begin
  fMsgHandler := TMsgHandler.Create(Self);
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TAppointmentListGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fMsgHandler);
  inherited;
end;

procedure TAppointmentListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('fieldname');



end;

initialization
  RegisterClassOnce(TAppointmentListGUI);
end.
