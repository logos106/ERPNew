unit frmWorkOrdertimeSheet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTimeSheetGUI, DB, ActnList, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Mask, wwdbedit, StdCtrls, Shader,
  DNMSpeedButton, ERPDbLookupCombo, wwdblook, wwdbdatetimepicker, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DNMPanel, BusObjBase;

type
  TfmWorkOrdertimeSheet = class(TfrmTimeSheet)
    DNMPanel1: TDNMPanel;
    edtBarcodeInput: TEdit;
    lblMsg: TLabel;
    qryTimesheetsRatetypeID: TIntegerField;
    qryTimesheetsRateTypeName: TWideStringField;
    QryRatetype: TERPQuery;
    cboRatetypeName: TwwDBLookupCombo;
    grdEmployees: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryTimesheetsWorkOrderCouponID: TWideStringField;
    procedure edtBarcodeInputExit(Sender: TObject);
    procedure edtBarcodeInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure grdTimesheetsEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryTimesheetsAfterOpen(DataSet: TDataSet);
  private
    ProcessingBarcode:Boolean;
    procedure ProcessBarcode;
    Function FindEmployeeRec(fiemployeeID:Integer):Boolean;
    function ValidateBXRBarcode(BXRID:Integer):Boolean;
    function ValidateProcess(const SL:TStringList):Boolean;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;


implementation

uses CommonLib , fastfuncs, DbSharedObjectsObj, CommonDbLib, AppEnvironment,
  tcDataUtils, tcConst, BusObjConst, FormFactory, BusObjProcPrefs, Barcodeconst;

{$R *.dfm}

procedure TfmWorkOrdertimeSheet.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (EventType =BusObjEvent_Change) and (Value = BusObjEvent_DupWorkOrderCouponID) then begin
       timerMsg(lblMsg , 'This Job is Already Done. This will make another Timesheet Entry for the Same Job.');
    end;

end;

procedure TfmWorkOrdertimeSheet.edtBarcodeInputExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBarcodeInputKeyPress(edtBarcodeInput, keyChar);
  end;
end;

procedure TfmWorkOrdertimeSheet.edtBarcodeInputKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtBarcodeInput.Modified:= true;
end;

procedure TfmWorkOrdertimeSheet.edtBarcodeInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not ProcessingBarcode then
    Try
      ProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;   // eat VK_RETURN
        ProcessBarcode;
        edtBarcodeInput.Text := '';
      end;
    Finally
      ProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then
    Key := #0;

end;

procedure TfmWorkOrdertimeSheet.FormCreate(Sender: TObject);
begin
  ExcludeGridfromcustomize(grdEmployees);
  //AllowCustomiseGrid := False;
  inherited;
  ProcessingBarcode:= False;
  TimesheetEntryType:='WorkOrder';
  Showcontrolhint(lblMsg , 'Employee Bar Code : Employee Card -> Print Bar Code'+NL+NL+'Work Order Bar Code: Manufacturing -> Production Job Status -> Work Order -> Print Barcodes'+NL);
end;

procedure TfmWorkOrdertimeSheet.FormShow(Sender: TObject);
begin
  inherited;
  if KeyID<>0 then
    FindEmployeeRec(Timesheetentry.Timesheet.employeeId);
end;

procedure TfmWorkOrdertimeSheet.grdTimesheetsEnter(Sender: TObject);
begin
  inherited;
  if (qryEmployee.Active =False ) or (qryEmployee.Parambyname('EmployeeID').asInteger=0) then begin
      Setcontrolfocus(edtBarcodeInput);
      Exit;
  end;

end;

procedure TfmWorkOrdertimeSheet.ProcessBarcode;
var
  sl: TStringList;
begin
  hidetimerMsg;
  sl:= TStringList.Create;
  try
    fastfuncs.Split(trim(Uppercase(edtBarcodeInput.Text)),'-',sl);
    if (sl.Count =5) and (Sl[0]='P') then begin
      {barcode produced from Manufacture->Production job Statsu -> Work Order -> Specify the Bundle Qty and Save
      The record with barcode is saved into tblbarcodexRef }
      if not (ValidateProcess(sl)) then exit;
    end else if (sl.Count =2) and (sametext(sl[0] ,Barcode_Prefix_BXR)) and (ISInteger(sl[1])) then begin
      if not (ValidateBXRBarcode(strtoint(sl[1]))) then exit;
    end else if (sl.Count =2) and (sametext(sl[0] ,'Emp')) and (ISInteger(sl[1])) then begin
      if not (FindEmployeeRec(strtoint(sl[1])) ) then exit;
    end else begin
        timerMsg(lblMsg , 'Invalid BarCode.. Please Try again');
        edtBarcodeInput.Text := '';
        Exit;
    end;
  finally
    sl.Free;
  end;

end;

procedure TfmWorkOrdertimeSheet.qryTimesheetsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GuiPrefs.DbGridElement[grdTimesheets].RemoveField(qryTimesheetsWorkOrderCouponID.fieldname);
  GuiPrefs.DbGridElement[grdTimesheets].RemoveField(qryTimesheetsRepairID.fieldname);
  GuiPrefs.DbGridElement[grdTimesheets].RemoveField(qryTimesheetsRosterId.fieldname);
end;

function TfmWorkOrdertimeSheet.FindEmployeeRec(fiemployeeID:Integer): Boolean;
begin
    REsult := False;
    try
      closeDB(qryEmployee);
      qryEmployee.Parambyname('EmployeeID').asInteger := fiemployeeID;
      OpenDB(qryEmployee);
      if qryEmployee.Recordcount <> 1 then begin
        timerMsg(lblMsg , 'Invalid Employee code.');
        edtBarcodeInput.Text := '';
        REsult := False;
        Exit;
      end;

    Except
      // kill the exception is sl[1] is not integer
    end;
end;

function TfmWorkOrdertimeSheet.ValidateBXRBarcode(BXRID: Integer): Boolean;
var
  St: TStringlist;
  Qry :TERPQuery;
begin
  Result := False;
  st:= TStringList.create;
  try
    Qry := DbSharedObj.GetQuery(TimeSheetEntry.Connection.Connection);
    try
        CloseDB(Qry);
        Qry.SQL.text := 'Select * from tblBarcodexRef where ID = ' + inttostr(BXRID);
        Qry.Open;
        if Qry.recordcount <>1 then exit;
        st.add( 'P');
        st.add( inttostr(Qry.fieldbyname('IntValue1').asInteger));
        st.add( inttostr(Qry.fieldbyname('IntValue2').asInteger));
        st.add( inttostr(Qry.fieldbyname('IntValue3').asInteger));
        st.add( inttostr(Qry.fieldbyname('IntValue4').asInteger));
        Result := ValidateProcess(st);
    finally
        DbSharedObj.ReleaseObj(Qry);
    end;
  finally
    Freeandnil(st);
  end;
end;

function TfmWorkOrdertimeSheet.ValidateProcess(const SL: TStringList): Boolean;
var
  Qry :TERPQuery;
  HourlyRate :Double;
  Maxcoupons :Integer;
  fsNotes:String;
  fiCoupenDuration:Integer;
begin
  REsult := False;
  fiCoupenDuration := 0;
    if qryEmployee.Recordcount <> 1 then begin
      timerMsg(lblMsg , 'Please Scan the employee Barcode');
      edtBarcodeInput.Text := '';
      Exit;
    end;

    Qry := DbSharedObj.GetQuery(TimeSheetEntry.Connection.Connection);
    try
      try
          fsNotes :='WorkOrder';
          Closedb(Qry);
          {PROCTREE info}
          Qry.SQL.Text := 'Select * ,'+
                          ' if(round(TreePartUOMTotalQty/QtyPerCoupon) = TreePartUOMTotalQty/QtyPerCoupon , TreePartUOMTotalQty/QtyPerCoupon , round(TreePartUOMTotalQty/QtyPerCoupon)+1) as  Maxcoupons  '+
                          ' from tblproctree where ProcTreeId = ' + sl[1];
          OpenDB(Qry);

          if (Qry.RecordCount=0) then begin
            timerMsg(lblMsg , 'This Job doesn''t Exists .. Please Try again');
            edtBarcodeInput.Text := '';
            Exit;
          end;

          HourlyRate := Qry.FieldByName('RAtePercoupon').AsFloat;
          Maxcoupons := Qry.FieldByName('Maxcoupons').asInteger;

          {ProctreePart info}
          if (sl[2]<>'') and (sl[2] <> '0') then begin
            Closedb(Qry);
            Qry.SQL.Text := 'Select PP.* ,FormatSecondsTotime(PP.Duration) fDuration,  ' +
                          ' if(round(PT.TreePartUOMTotalQty/PP.QtyPerCoupon) = PT.TreePartUOMTotalQty/PP.QtyPerCoupon , ' +
                          '         Pt.TreePartUOMTotalQty/PP.QtyPerCoupon , ' +
                          '         round(PT.TreePartUOMTotalQty/PP.QtyPerCoupon)+1) as  Maxcoupons ' +
                          ' from tblProcessPart PP inner join  tblproctree PT on PT.proctreeId = PP.proctreeId where PP.Id =  ' + sl[2];
            OpenDB(Qry);

            if (Qry.RecordCount=0) then begin
              timerMsg(lblMsg , 'This Job doesn''t Exists .. Please Try again');
              edtBarcodeInput.Text := '';
              Exit;
            end;
            //fiCoupenDuration := Trunc(Qry.FieldByName('Duration').AsFloat * Qry.FieldByName('QtyPerCoupon').AsFloat);
            fiCoupenDuration := Trunc(Qry.FieldByName('Duration').AsFloat * Qry.FieldByName('BundleQty').AsFloat);

            fsNotes := 'Process Duration :' +  Qry.FieldByName('fDuration').AsString +
                        ', Coupons : ' + inttostr(Qry.FieldByName('Maxcoupons').asInteger)+
                        ' of ' + inttostr(Qry.FieldByName('QtyPerCoupon').asInteger)+' each';
            HourlyRate := Qry.FieldByName('RAtePercoupon').AsFloat;
            Maxcoupons := Qry.FieldByName('Maxcoupons').asInteger;
            if HourlyRate =0 then HourlyRate := Qry.FieldByName('HourlyLabourRate').AsFloat;  // drummond_kindred_live needs the hourly rate from resource
          end;
          if (sl[3]='') OR (sl[3] = '0') or (not(isnumber(sl[3]))) then begin
              timerMsg(lblMsg , 'Quantity Per Coupon in this Job is Zero .. Please Try again');
              edtBarcodeInput.Text := '';
              Exit;
          end;
          If StrTofloat(sl[3]) <> Qry.FieldByName('QtyPerCoupon').asFloat then begin
              timerMsg(lblMsg , 'Coupon of this Job is to have '+ inttostr(Qry.FieldByName('QtyPerCoupon').asInteger ) +' Qty Per Coupon, but you chose ' + sl[3]+'. Wrong Barcode .. Please Try again' );
              edtBarcodeInput.Text := '';
              Exit;
          end;
          if (sl[4]='') OR (sl[4] = '0') or (not(isInteger(sl[4])))  then begin
              timerMsg(lblMsg , 'Coupon number Should not be .. Please Try again');
              edtBarcodeInput.Text := '';
              Exit;
          end;


          If StrToInt(sl[4]) > Maxcoupons then begin
              timerMsg(lblMsg , 'This Job is to have '+ inttostr(Maxcoupons) +', but you choose Coupon # ' + sl[4]+'. Wrong Barcode .. Please Try again' );
              edtBarcodeInput.Text := '';
              Exit;
          end;
            Timesheetentry.Timesheet.New;
            timesheetentry.timesheet.Notes              := 'WorkOrder';//fsNotes ;
            timesheetentry.timesheet.PayRateTypeName    := Normal_Hours;
            timesheetentry.timesheet.RateTypeName       := Piece_Rate;
            timesheetentry.timesheet.TimeSheetDate      := Date;
            timesheetentry.timesheet.EmployeeName       := qryEmployeeemployeeName.asString;
            timesheetentry.timesheet.EmployeeID         := qryEmployeeemployeeID.asInteger;
            cboNameCloseUp(cboName , cboName.lookuptable, cboName.datasource.dataset ,  True);
            timesheetentry.timesheet.LabourCost         := HourlyRate;
            timesheetentry.timesheet.TimeSheetClassID   := Appenv.DefaultClass.ClassID;
            timesheetentry.timesheet.ServiceDate        := Date;
            timesheetentry.timesheet.Quantity           := 1;
            timesheetentry.timesheet.Hours              := 1;
            if ProcPrefs.DefaultCoupenTimeinWOTimesheet and (fiCoupenDuration <> 0) then
              timesheetentry.timesheet.Hours            := fiCoupenDuration/60/60;
            timesheetentry.timesheet.Active             := True;
            timesheetentry.timesheet.HourlyRate         := HourlyRate;
            timesheetentry.timesheet.WorkOrderCouponID  := edtBarcodeInput.text;
            timesheetentry.timesheet.PostDB;
            grdTimesheets.setActivefield('Hours');
            Result := TRue;
      Except
        on E:Exception do begin
              timerMsg(lblMsg , E.Message + ' .. Please Try again' );
              edtBarcodeInput.Text := '';
              Exit;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

initialization
  RegisterClassOnce(TfmWorkOrdertimeSheet);
  FormFact.RegisterMe(TfmWorkOrdertimeSheet, 'TfrmPayTimesheet_*_WorkOrder=TimesheetEntryID');
end.
