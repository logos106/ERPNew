unit frmPaySummaryFrm;

{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 25/07/05  1.00.01 IJB Removed HandleUnknownException (now handled by new
                       ExceptionalMagic code).
 19/10/05  1.00.02 DLS Added RegisterClass
}

{$I ERP.inc}
interface

uses
  Windows, Messages, Forms, BaseListingForm, DB, wwcheckbox, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, Classes, ActnList,
  PrintDAT, ImgList, Controls, Menus, AdvMenus, Dialogs, Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, SysUtils, DateUtils,
  ProgressDialog, AdvProgressBar, IdComponent, CheckLst,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdBaseComponent,
  IdMessage,Graphics,  wwdblook, Shader,BusObjPayUtils,BusObjPayBase,
  kbmMemTable,BusObjBase, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

const
  SX_GetCommissMsg = WM_USER + 155;

type
  pLeaveRec = ^TLeaveRec;
  TLeaveRec = record
    dtDate: TDateTime;
    sLeave: string;
    dTotHrs: double;
  end;

  pTimesRec = ^TTimesRec;
  TTimesRec = record
    dtStart: TDateTime;
    dtEnd: TDateTime;
    bMatched: boolean;
  end;

type
  TempEmailRec = class(TObject)
  private
  public
    sFileName: string;
    sEmailAddress: string;
    sEmpName: string;
    iPayID: integer;
  end;

type
  TfrmPaySummary = class(TBaseListingGUI)
    btnPayStaff: TDNMSpeedButton;
    chkPaid: TwwCheckBox;
    chkPay: TwwCheckBox;
    btnLoadRoster: TDNMSpeedButton;
    qryMainPayDate: TDateField;
    qryMainWages: TFloatField;
    qryMainCommission: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainSundries: TFloatField;
    qryMainSuperannuation: TFloatField;
    qryMainGross: TFloatField;
    qryMainTax: TFloatField;
    qryMainNet: TFloatField;
    qryMainPaid: TWideStringField;
    qryMainPay: TWideStringField;
    DNMPanel1: TDNMPanel;
    chkAddToEft: TCheckBox;
    lblEFT: TLabel;
    qryMainPayPeriods: TWordField;
    qryMainPayPeriod: TWideStringField;
    btnLoadTimesheet: TDNMSpeedButton;
    btnPayslipReport: TDNMSpeedButton;
    qryMainCDEPGross: TFloatField;
    qryMainPayID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    btnClearAll: TDNMSpeedButton;
    Label4: TLabel;
    chkPreviewPaySlips: TCheckBox;
    Bevel1: TBevel;
    cboDatePaid: TwwDBDateTimePicker;
    qryMainEmployeeName: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainPrepared: TWideStringField;
    MyConnection2: TERPConnection;
    qryPayExtraDetails: TERPQuery;
    DSPayExtraDetails: TDataSource;
    wwExpandButton2: TwwExpandButton;
    grdExtraDetails: TwwDBGrid;
    qryPayExtraDetailsdescription: TWideStringField;
    qryPayExtraDetailsleaveloading: TFloatField;
    qryPayExtraDetailsiftblpayratesIsLeaveT10: TLargeintField;
    qryPayExtraDetailsAmount: TFloatField;
    qryPayExtraDetailsQty: TFloatField;
    qryPayExtraDetailsLineTotal: TFloatField;
    qryPayExtraDetailsSuperInc: TWideStringField;
    qryMainExtraDetails: TWideStringField;
    qryMainEmployeeNo: TIntegerField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainSendPaySlipViaEmail: TWideStringField;
    qryMainLastPaid: TDateField;
    qryMainDatePaid: TDateTimeField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPayStaffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    procedure btnLoadRosterClick(Sender: TObject);
    procedure btnPayslipReportClick(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure grdMainCheckValue(Sender: TObject; PassesPictureTest: boolean);
//    procedure btnLoadTimesheetClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure chkPayExit(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainExit(Sender: TObject);
    procedure chkPayClick(Sender: TObject);
    procedure btnLoadTimesheetClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure grdMainCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure wwExpandButton2BeforeExpand(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
        CurrentConnection : TMyDacDataConnection;

    PayUtils:TPayUtils;
    ThisPay:Tpaybase;
    SelectedDepartments: TStrings;
    fbInitialising: boolean;
    bPreviewPaySlips: boolean;
    fbPaycreated:Boolean;
    procedure SendEmails;
    function EmpDeptOnList(EmployeeID: integer): boolean;
//    function OpenRoster: boolean;
    function IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
    Procedure Processunprocessedtimesheet;
    Procedure AfterPayCreate;
    Procedure AddtimeSheets(bViewTimeSheets:Boolean);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure RefreshTotals; override;
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;
var
  EmailRecList: TList;
implementation

uses
  CommonDbLib, DNMExceptions, ABAObj, 
  //PayFunctionObj,
  PayCommon,
  frmPayPeriodPopUp, frmTimeSheetGUI, CommonLib, frmActionApproved, DNMLib,systemlib,
  RosterCalForm, frmPayDeptSelectionGUI,
  AppEnvironment, FastFuncs,BusObjConst, tcConst, frmEmployeeFrm,
  CorrespondenceObj,
  BusObjPayRun;

const
  ACCESS_ALLOWED = 1;
  {$R *.dfm}

var
  bOkToUpdateFooter: boolean = true;

procedure TfrmPaySummary.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_BankSplitsError) then begin
    CommonLib.MessageDlgXP_Vista('The Banking split amounts were greater than the net pay. Amounts were adjusted', mtWarning, [mbOK], 0);
  end;
end;


procedure TfrmPaySummary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PostDb(qryMain);

  while EmailRecList.Count > 0 do begin
    TempEmailRec(EmailRecList[0]).Free;
    EmailRecList.Delete(0);
  end;
end;

procedure TfrmPaySummary.btnPayStaffClick(Sender: TObject);
var
  dtPayDate: TDateTime;
  dtLastPayDate: TDateTime;
  dtDatePaid: TDateTime;
  frm: TPayPeriodGUI;
  bEFTValid: boolean;
  ABAObj: TABAObj;
  bIsSomeoneToPay: boolean;
  EmailRec: TempEmailRec;
  frmApprovedPopUp, frmDeptSelectPopUp: TComponent;
  i,NoOfEmployeesWithDefaultDept: integer;
  SavedPrintDialogPref:Boolean;
  curdir:String;
  PayRunID: integer;
  msg: String;


begin
  DisableForm;
  try
    PayRunID := 0;
    //Make sure they have not deleted their payroll accounts
    if not AppEnv.PayPrefs.PayrollAccountsExist(False) then exit;

    if not MyConnection2.InTransaction then MyConnection2.StartTransaction;
    if not Assigned(ThisPay) then begin
      ThisPay := Tpaybase.Create(nil,qryMainPayID.Asinteger,Self.MyConnection2) ;
      ThisPay.BusObjEvent           := DoBusinessObjectEvent;
    end;
    NoOfEmployeesWithDefaultDept := 0;
    if qryMain.RecordCount = 0 then
      Exit;
    if not AppEnv.PayPrefs.PayrollAccountsExist(false) then begin
      Exit;
    end;

    if FormStillOpen('TfrmActionApproved') then
      TForm(FindExistingComponent('TfrmActionApproved')).Close;

    if not FormStillOpen('TfrmActionApproved') then begin
      frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
      if Assigned(frmApprovedPopUp) then begin
        with TfrmActionApproved(frmApprovedPopUp) do begin
          lblAction.Caption := 'Process Pays';
          ActionType := 'Process Pays';
          if ShowModal = mrOk then begin
            if not IsAccessAllowed('TfrmPaySummary', AuthorisingEmpID) then begin
              CommonLib.MessageDlgXP_Vista('You do not have access permission for to Process Pays', mtInformation, [mbOK], 0);
              Exit;
            end;
          end else begin
            Exit;
          end;
        end;
      end;
    end;

    if AppEnv.PayPrefs.PayByDepartment then begin
      NoOfEmployeesWithDefaultDept := 0;
      if FormStillOpen('TfrmPayDeptSelection') then
        TfrmPayDeptSelection(FindExistingComponent('TfrmPayDeptSelection')).Close;

      frmDeptSelectPopUp := GetComponentByClassName('TfrmPayDeptSelection');
      if Assigned(frmDeptSelectPopUp) then begin
        with TfrmPayDeptSelection(frmDeptSelectPopUp) do begin
          if ShowModal = mrOk then begin
            SelectedDepartments.Clear;

            //get departments from chkList
            for i := 0 to chkDepartments.Count - 1 do begin
              if chkDepartments.Checked[i] then begin
                SelectedDepartments.Add(chkDepartments.Items.Strings[i]);
              end;
            end;
          end else begin
            Exit;
          end;
        end;
      end;
    end;

    // Get pay dates

    dtLastPayDate := GetLastPayDate(0);
    frm := TPayPeriodGUI.Create(Self);
    try
      frm.dtpCommence.Date := dtLastPayDate;
      if frm.ShowModal = mrOk then begin
        dtLastPayDate := frm.dtpCommence.Date;
        dtDatePaid := frm.dtpDatePaid.DateTime;
      end else begin
        Exit;
      end;
    finally
      FreeAndNil(frm);
    end;

    Processingcursor(True);
    try
      qryMain.First;
      while not qryMain.Eof do begin
        if qryMain.FieldByName('Pay').AsString = 'T' then begin
          dtPayDate := qryMainPayDate.AsDateTime;
          if (CompareDate(dtPayDate, dtLastPayDate) > 0) then begin
            if CommonLib.MessageDlgXP_Vista('One or more Employees will not be paid because their Pay Dates are AFTER the Pay Date selected.' +
              #13 + #10 + 'Continue with Pay Run?',
              mtWarning, [mbOK, mbCancel], 0) = mrCancel then begin
              Exit;
            end else begin
              Break;
            end;
          end;
        end;
        qryMain.Next;
      end;

      // check that each employee who is to be paid has valid EFT details and
      // .. inform user if all employees pay dates are not 'reasonable'
      qryMain.First;
      bEFTValid := true;
      if chkAddToEft.Checked then begin
        while not qryMain.Eof do begin
          if qryMain.FieldByName('Pay').AsString = 'T' then begin
            dtPayDate := qryMainPayDate.AsDateTime;
            if (CompareDate(dtPayDate, dtLastPayDate) <= 0) then begin
              ABAObj := TABAObj.Create;
              try
                if ABAObj.ValidEFTEmployee(qryMain.FieldByName('PayID').AsInteger) then begin
                  if not ABAObj.HasValidEFTEmployeeAccountInfo(qryMain.FieldByName('PayID').AsInteger) then begin
                    CommonLib.MessageDlgXP_Vista(qryMain.FieldByName('EmpName').AsString + ' has Invalid Bank Details set in Employee Form',
                      mtWarning, [mbOK], 0);
                    bEFTValid := false;
                  end;
                end;
              finally
                FreeAndNil(ABAObj);
              end;
            end;
          end;
          qryMain.Next;
        end;
      end;
      if not bEFTValid then begin
        CommonLib.MessageDlgXP_Vista('This Pay Run has been aborted without any Pays being ' + #13 + #10 +
          'created.  Please Fix Bank Details and Try Again.', mtWarning, [mbOK], 0);
        Exit;
      end;

      //for every rec in tblPays not paid yet
      bIsSomeoneToPay := false;
      qryMain.First;
      SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      curdir := GetCurrentDir;
      try
      while not qryMain.Eof do begin
        SetCurrentDir(SystemLib.ExeDir);{Sending email changes the current dir, so set it back to exe dir for each record}
        if AppEnv.PayPrefs.PayByDepartment then begin
          if not EmpDeptOnList(qryMain.FieldByName('EmployeeID').AsInteger) then begin
            qryMain.Next;
            Continue;
          end else begin
            NoOfEmployeesWithDefaultDept := NoOfEmployeesWithDefaultDept + 1;
          end;
        end;

        if qryMain.FieldByName('Pay').AsString = 'T' then begin
          dtPayDate := qryMainPayDate.AsDateTime;
          if (CompareDate(dtPayDate, dtLastPayDate) <= 0) and (dtPayDate <> 0) then begin
            //######## Process Pay ###################

            try
              ThisPay.Load(qryMainPayID.AsInteger);
//              ThisPay.DatePaid:= dtDatePaid;
              ThisPay.RecalcAll;
              ThisPay.VerifyBanking;

       //       ShowMessage('about to ProcessPay ');
       //        if not Assigned(ThisPay.Connection) then   ShowMessage('before ProcessPay no ThisPay.Connection ') else ShowMessage('connection ok');

              CurrentConnection := ThisPay.Connection;

              PayUtils.ProcessPay(ThisPay,dtDatePaid,chkAddToEft.Checked,chkPreviewPaySlips.Checked);

      //     ThisPay.Connection :=  Self.MyConnection2;

            //   ShowMessage('PayRunID ' + IntToStr(PayRunID));
              if not Assigned(ThisPay) then   ShowMessage('no ThisPay ');
              if not Assigned(ThisPay.Connection) then
              begin
            //     ShowMessage('no ThisPay.Connection ');

                 ThisPay.Connection :=  CurrentConnection;
              end;

              if BusObjPayRun.TPayRun.AddPayToRun(PayRunID,ThisPay.Connection.Connection,msg) then begin
      //
      //          ShowMessage('AddPayToRun done');

      //                       ShowMessage('msg ' + msg);


                ThisPay.PayRunID := PayRunID;
                ThisPay.PostDb;
              end
              else begin

          //      ShowMessage('creqting exception ' + msg);

           //     raise Exception.Create(msg);
              end;

              bIsSomeoneToPay := true;
              if chkPreviewPaySlips.Checked = False then begin
                //store the file details in the Email list
                if (qryMain.FieldByName('SendPaySlipViaEmail').AsString = 'T') or
                  (qryMain.FieldByName('SendPaySlipViaEmail').AsString = 'B') then begin
                  if FileExists(GetCurrentDir +'\' +
                      qryMain.FieldByName('EmpName').AsString +
                      IntToStr(qryMain.FieldByName('PayID').AsInteger) + '.pdf') then begin
                    EmailRec := TempEmailRec.Create;
                    EmailRec.sFileName := GetCurrentDir +'\' +
                      qryMain.FieldByName('EmpName').AsString +
                      IntToStr(qryMain.FieldByName('PayID').AsInteger) + '.pdf';
                    EmailRec.sEmailAddress := qryMain.FieldByName('Email').AsString;
                    EmailRec.sEmpName := qryMain.FieldByName('EmpName').AsString;
                    EmailRec.iPayID := qryMain.FieldByName('PayID').AsInteger;
                    EmailRecList.Add(EmailRec);
                  end;
                end;
              end;
            finally

            end;
            //########################################
          end;
        end;
        AppEnv.Employee.ShowPrintDialog:= False;
        qryMain.Next;
      end;
      finally
        SetCurrentDir(curdir);
        AppEnv.Employee.ShowPrintDialog := SavedPrintDialogPref;
      end;
    finally
      Processingcursor(False);

    end;
    if bIsSomeoneToPay then begin
      MyConnection2.Commit;
      CommonLib.MessageDlgXP_Vista('Payroll Completed.', mtInformation, [mbOK], 0);
      actRefreshQry.Execute;
      //Set Action authorisation to success
      frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
      try
        if Assigned(frmApprovedPopUp) then begin
          TfrmActionApproved(frmApprovedPopUp).SetActionSuccess('T');
        end;
      finally
        if Assigned(frmApprovedPopUp) then TfrmActionApproved(frmApprovedPopUp).Release;
      end;

      SendEmails;
    end else begin
      if NoOfEmployeesWithDefaultDept > 0 then begin
        CommonLib.MessageDlgXP_Vista('No Employees were Paid. None have selected default department/s.', mtInformation, [mbOK], 0);
      end else begin
        CommonLib.MessageDlgXP_Vista('No Employees were Paid. Check date range.', mtInformation, [mbOK], 0);
      end;
    end;
  finally
    EnableForm;
  end;  
end;

function TfrmPaySummary.EmpDeptOnList(EmployeeID: integer): boolean;
var
  qry: TERPQuery;
  i: integer;
begin
  Result := false;
  qry := TERPQuery.Create(Self);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID,DefaultClassName FROM tblemployees WHERE EmployeeID = ');
    qry.SQL.Add(IntToStr(EmployeeID));
    qry.Open;

    for i := 0 to SelectedDepartments.Count - 1 do begin
      if SelectedDepartments.Strings[i] = qry.FieldByName('DefaultClassName').AsString then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmPaySummary.SendEmails;
var
  x: integer;
  iExitResult: integer;
//  Corres: TCorrespondenceGui;
  qryEmailedReports: TERPQuery;
  sSendFrom: string;
  sBody: string;
  tmpPayFunction: TPayUtils;
begin
  tmpPayFunction := TPayUtils.Create(Self);
//  Corres := TCorrespondenceGui.Create;
  qryEmailedReports := TERPQuery.Create(self);
  try
    Processingcursor(True);
    qryEmailedReports.Options.FlatBuffers := True;
    qryEmailedReports.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryEmailedReports.SQL.Add('SELECT * FROM tblemailedreports ');
    qryEmailedReports.Open;

    for x := 0 to EmailRecList.Count - 1 do begin
      try
        if AppEnv.Employee.UseEmpEmailAsFromAddress then begin
          sBody := 'Attached is your Pay slip'
        end else begin
          sBody := 'Attached is your Pay slip. The sender does not have an individual email address.'
        end;
        sSendFrom := getEmailFrom;
        tmpPayFunction.SendEmail(sSendFrom, TempEmailRec(EmailRecList[x]).sEmailAddress, 'password',
          TempEmailRec(EmailRecList[x]).sFileName, TempEmailRec(EmailRecList[x]).sEmpName +
          ' Pay Slip', sBody);

        with qryEmailedReports do begin
          Insert;
          FieldByName('Date').AsDateTime := Now;
          FieldByName('ReportType').AsString := 'Pay Slip';
          FieldByName('Status').AsString := 'Success';
          FieldByName('TransactionDescription').AsString := 'Payslip: ' + TempEmailRec(EmailRecList[x]).sEmpName;
          FieldByName('UserID').AsString := AppEnv.Employee.LogonName;
          FieldByName('TransactionID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
          Post;
        end;

      except
        if qryMain.FieldByName('SendPaySlipViaEmail').AsString = 'T' then begin
          iExitResult := CommonLib.MessageDlgXP_Vista('Email failed. Do you want to send to the printer?', mtConfirmation, [mbYes, mbNo], 0);
          case iExitResult of
            mrYes: tmpPayFunction.PrintFromDB(TempEmailRec(EmailRecList[x]).sEmpName, chkPreviewPaySlips.Checked);
            mrNo:
              begin;
              end;
          end;
        end;
        if qryMain.FieldByName('SendPaySlipViaEmail').AsString = 'B' then begin
          CommonLib.MessageDlgXP_Vista('Email for ' + TempEmailRec(EmailRecList[x]).sEmpName + ' failed, Payslip sent to Printer only.',
            mtWarning, [mbOK], 0);
        end;
        Continue;
      end;
    end;
  finally

    Processingcursor(False);
    DeleteFiles(GetCurrentDir + '\', '*.zip');
    DeleteFiles(GetCurrentDir + '\', '*.pdf');
    FreeAndNil(tmpPayFunction);
//    FreeAndNil(Corres);
    FreeAndNil(qryEmailedReports);
    while EmailRecList.Count > 0 do begin
      TempEmailRec(EmailRecList[0]).Free;
      EmailRecList.Delete(0);
    end;
  end;
end;

procedure TfrmPaySummary.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if AccessLevel < 6 then begin
        qryMain.FieldByName('Paid').DisplayWidth := 8;
        grdMain.SetControlType('Paid', fctCustom, 'chkPaid');
        grdMain.SetControlType('Pay', fctCustom, 'chkPay');
//        chkPay.OnClick := chkPayClick;
        grdMain.Invalidate;
        grdMain.RefreshDisplay;
        chkAddToEFT.Checked := AppEnv.PayPrefs.AddToEFT;
        grpFiltersClick(Sender);
        grdMain.ColumnByName('EmpName').DisplayLabel := 'Employee Name';
      end;
    except
      on EAbort do
        HandleEAbortException;
      on e: ENoAccess do
        HandleNoAccessException(e);
      on e: Exception do
        raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.FormCreate(Sender: TObject);
begin
  If not InPayrollTestMode then
    btnClearAll.Visible := false;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('tblPays.PayID, tblPays.EmployeeID, tblPays.EmpName, tblPays.PayDate,');
  qryMain.SQL.Add('tblPays.DatePaid, tblPays.Wages, tblPays.Commission, tblPays.Deductions,');
  qryMain.SQL.Add('tblPays.Allowances, tblPays.Sundries, tblPays.PayPeriods, tblPays.Superannuation,');
  qryMain.SQL.Add('tblPays.Gross, tblPays.Tax, tblPays.Net, tblPays.Paid, tblPays.Pay, tblPays.PayPeriod,');
  qryMain.SQL.Add('tblPays.CDEPGross, tblPays.Class,tblPays.Prepared,');
  qryMain.SQL.Add('tblemployees.EmployeeNo,');
  qryMain.SQL.Add('tblemployees.FirstName,tblemployees.LastName,');
  qryMain.SQL.Add('tblemployees.Email,tblemployees.SendPaySlipViaEmail,tblemployees.LastPaid');

  qryMain.SQL.Add(', tblPays.CompanyTax');

  qryMain.SQL.Add('FROM tblPays');
  qryMain.SQL.Add('INNER JOIN tblemployees ON tblPays.EmployeeID=tblemployees.EmployeeID');
  qryMain.SQL.Add('WHERE tblPays.Paid <> "T" AND tblPays.Deleted = "F"');
  qryMain.SQL.Add('AND tblPays.EmpName <> ""');
  qryMain.SQL.Add('and tblemployees.Active <> "F"');
  qryMain.SQL.Add('GROUP BY tblPays.EmployeeID');
  qryMain.SQL.Add('ORDER BY tblPays.EmpName');

  with TFloatField.Create(Self) do begin
    Currency := True;
    fieldKind := fkData;
    fieldname := 'CompanyTax';
    name := ComponentName(self, 'qryMainCompanyTax');
    DisplayLabel := 'Company Tax';
    DataSet := qryMain;
    visible := True;
  end;
  inherited;

  AddCalcColumn(qryMainWages.FieldName, true);
  AddCalcColumn(qryMainCommission.FieldName, true);
  AddCalcColumn(qryMainDeductions.FieldName, true);
  AddCalcColumn(qryMainAllowances.FieldName, true);
  AddCalcColumn(qryMainSundries.FieldName, true);
  AddCalcColumn(qryMainSuperannuation.FieldName, true);
  AddCalcColumn(qryMainGross.FieldName, true);
  AddCalcColumn(qryMainTax.FieldName, true);
  AddCalcColumn(qryMainNet.FieldName, true);
  AddCalcColumn(qryMainCDEPGross.FieldName, true);
  AddCalcColumn(qryMainCDEPGross.FieldName, true);
  AddCalcColumn('CompanyTax', true);

//  RefreshOrignalSQL;

  bPreviewPaySlips := false;
  fbInitialising := true;
  EmailRecList := TList.Create;
  SelectedDepartments := TStringList.Create;

  MyConnection2.LoginPrompt      := False;
  MyConnection2.Server           := GetSharedMyDacConnection.Server;
  MyConnection2.Database         := GetSharedMyDacConnection.Database;
  MyConnection2.Username         := GetSharedMyDacConnection.Username;
  MyConnection2.Password         := GetSharedMyDacConnection.Password;
  MyConnection2.Options.Compress := GetSharedMyDacConnection.Options.Compress;
  MyConnection2.Options.Protocol := GetSharedMyDacConnection.Options.Protocol;
  MyConnection2.Port             := GetSharedMyDacConnection.Port;
  MyConnection2.connected := True;

  PayUtils := TPayUtils.Create(nil,Self.MyConnection2);

end;

procedure TfrmPaySummary.RefreshTotals;
//var
//  dWages, dCommission, dDeductions, dAllowances, dSundries, dCDEP: double;
//  dSuper, dGross, dTax, DNet: double;
//  oRecPointer: TBookmark;
begin
  inherited;
  CalcnShowfooter;

//  if bOkToUpdateFooter then begin
//    bOkToUpdateFooter := false;
//    dWages := 0;
//    dCommission := 0;
//    dDeductions := 0;
//    dAllowances := 0;
//    dSundries := 0;
//    dSuper := 0;
//    dGross := 0;
//    dTax := 0;
//    dNet := 0;
//    dCDEP := 0;
//
//    qryMain.DisableControls;
//    oRecPointer := qryMain.GetBookmark;
//    try
//      qryMain.First;
//      while not qryMain.Eof do begin
//        dWages := dWages + qryMain.FieldByName('Wages').AsFloat;
//        dCommission := dCommission + qryMain.FieldByName('Commission').AsFloat;
//        dDeductions := dDeductions + qryMain.FieldByName('Deductions').AsFloat;
//        dAllowances := dAllowances + qryMain.FieldByName('Allowances').AsFloat;
//        dSundries := dSundries + qryMain.FieldByName('Sundries').AsFloat;
//        dSuper := dSuper + qryMain.FieldByName('Superannuation').AsFloat;
//        dGross := dGross + qryMain.FieldByName('Gross').AsFloat;
//        dTax := dTax + qryMain.FieldByName('Tax').AsFloat;
//        dNet := dNet + qryMain.FieldByName('Net').AsFloat;
//        dCDEP := dCDEP + qryMain.FieldByName('CDEPGross').AsFloat;
//        qryMain.Next;
//      end;
//
//      grdMain.ColumnByName('Wages').FooterValue := FloatToStrF(dWages, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Commission').FooterValue := FloatToStrF(dCommission, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Deductions').FooterValue := FloatToStrF(dDeductions, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Allowances').FooterValue := FloatToStrF(dAllowances, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Sundries').FooterValue := FloatToStrF(dSundries, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Superannuation').FooterValue := FloatToStrF(dSuper, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Gross').FooterValue := FloatToStrF(dGross, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Tax').FooterValue := FloatToStrF(dTax, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('Net').FooterValue := FloatToStrF(dNet, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('CDEPGross').FooterValue := FloatToStrF(dCDEP, ffCurrency, 15, CurrencyRoundPlaces);
//      grdMain.ColumnByName('CDEPGross').DisplayLabel := 'CDEP';
//      if qryMain.BookmarkValid(oRecPointer) then
//        qryMain.GoToBookmark(oRecPointer);
//      Self.Update;
//    finally
//      qryMain.FreeBookmark(oRecPointer);
//      qryMain.EnableControls;
//      bOkToUpdateFooter := true;
//    end;
//  end;
end;

procedure TfrmPaySummary.btnPayslipReportClick(Sender: TObject);
Var
  tmpPayFunction: TPayUtils;
  ssql:String;
begin
  DisableForm;
  try
    inherited;
    if qryMain.Active and (qryMain.State = dsEdit) and (qryMainPayID.AsInteger > 0) then
      qryMain.Post;
    tmpPayFunction := TPayUtils.Create(Self);
    try
      //tmpPayFunction.PrintUnprocessedPaysReport(true);
      ssql:= tmpPayFunction.PaysReportSQL(true , 0);
      ReportSQLSupplied := True;
      PrintTemplateReport('Payslip Report' , ssql, not(Appenv.Employee.ShowPreview) , 1 );
    finally
      FreeAndNil(tmpPayFunction);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.edtSearchEnter(Sender: TObject);
begin
  if (qryMain.State = dsEdit) and (qryMainPayID.AsInteger > 0) then 
    qryMain.Post;
  inherited;
end;

procedure TfrmPaySummary.grdMainCheckValue(Sender: TObject; PassesPictureTest: boolean);
begin
  if (qryMain.State = dsEdit) and (qryMainPayID.AsInteger > 0) and (qryMain.RecordCount > 0) then
    qryMain.Post;
  inherited;
end;

procedure TfrmPaySummary.grdMainDblClick(Sender: TObject);
begin
//  if Assigned(grdMain.SelectedField) and (grdMain.SelectedField = qryMainPay) then
//    exit;
  inherited;

end;

//procedure TfrmPaySummary.btnLoadTimesheetClick(Sender: TObject);
//var
//  iResult: integer;
//  frmApprovedPopUp: TComponent;
//  tmpComponent: TComponent;
//  tmpPayFunction: TPayUtils;
//begin
//  inherited;
//  iResult := CommonLib.MessageDlgXP_Vista('You have chosen to Load Job Timesheet Hours into Pays '#13 + #10 + 'that are in this List. This will only apply to Pays for the Employees who ' + #13 + #10 +
//    'have listed hours in the timesheet within their given pay schedule. ' + #13 + #10 + #13 + #10 + 'Select any leaves taken before loading timesheet entries.' + #13 + #10 + #13 + #10 +
//    'ONCE THESE TIMESHEET ENTRIES HAVE BEEN LOADED THEY CANNOT BE RELOADED! ' + #13 + #10 + #13 + #10 + 'WOULD YOU LIKE TO VERIFY THESE ENTRIES NOW BEFORE LOADING INTO PAYS?', mtWarning, [mbYes, mbNo, mbCancel], 0);
//
//  if iResult = mrCancel then
//    Exit;
//
//  if (iResult = mrYes) or (iResult = mrNo) then begin
//    if FormStillOpen('TfrmActionApproved') then begin
//      TForm(FindExistingComponent('TfrmActionApproved')).BringToFront;
//    end else begin
// //   if not FormStillOpen('TfrmActionApproved') then begin
//      frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
//      if Assigned(frmApprovedPopUp) then begin
//        with TfrmActionApproved(frmApprovedPopUp) do begin
//          lblAction.Caption := 'Load Timesheet.';
//          ActionType := 'Load Timesheet';
//          if ShowModal = mrOk then begin
//            if not IsAccessAllowed('TfrmTimeSheet', AuthorisingEmpID) then begin
//              CommonLib.MessageDlgXP_Vista('You do not have access permission for the Timesheets.', mtInformation, [mbOK], 0);
//              Exit;
//            end;
//
//            if iResult = mrYes then begin
//              tmpComponent := GetComponentByClassName('TfrmTimeSheet');
//              if Assigned(tmpComponent) then begin
//                with TfrmTimeSheet(tmpComponent) do begin
//                  // Yes, show timesheet form.
//                  Position := poDefault;
//                  FormStyle := fsNormal;
//                  CallingClassName := 'TfrmPaySummary';
//                  if ShowModal = mrCancel then
//                    Exit;
//                end;
//              end;
//            end;
//
//            Processingcursor(True);
//
//            tmpPayFunction := TPayUtils.Create(Self);
//            try
//              tmpPayFunction.LoadTimeSheet;
//              qryMain.Close;
//              qryMain.Open;
//              RefreshTotals;
//            finally
//           //   FreeAndNil(tmpPayFunction);
//              Processingcursor(False);
//            end;
//            frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
//            if Assigned(frmApprovedPopUp) then begin
//              TfrmActionApproved(frmApprovedPopUp).Visible := false;
//              TfrmActionApproved(frmApprovedPopUp).SetActionSuccess('T');
//              TfrmActionApproved(frmApprovedPopup).Close;
//            end;
//          end;
//        end;
//      end;
//    end;
//  end;
//end;

//function TfrmPaySummary.OpenRoster: boolean;
//var
//  iModalResult: integer;
//begin
//  Result := false;
//  with TRosterCalGUI.Create(Self) do
//    try
//      // get a sensible date
//      qryMain.First;
//      if not qryMain.Eof then begin
//        fdtStartDate := qryMain.FieldByName('LastPaid').AsDateTime;
//      end;
//      iModalResult := ShowModal;
//      if iModalResult <> mrCancel then begin
//        Result := true;
//      end;
//    finally
//      Free;
//    end;
//end;

//procedure TfrmPaySummary.btnLoadRosterClick(Sender: TObject);
//var
//  frmApprovedPopUp: TComponent;
//  PayUtils: TPayUtils;
//
//begin
//  PayUtils := TPayUtils.Create(Self,MyConnection2);
//  try
//    if CommonLib.MessageDlgXP_Vista('You have chosen to Load Roster Hours and Leave into Pays ' +
//      'in this List. This will only apply to Pays for the Employees who ' +
//      'have "Load Hours from Roster" or "Load Leave from Roster" ' +
//      'Checked in the Employee forms.' + #13 + #10 + #13 + #10 + '' +
//      'Hours will be adjusted for Meal Breaks ' + #10 + #13 + '' +
//      'THIS WILL OVERRIDE ANY HOURS OR LEAVE ' +
//      'PREVIOUSLY ASSIGNED' + #13 + #10 + #13 + #10 +
//      'Do you wish to proceed?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
//      Exit;
//    end;
//
//    if FormStillOpen('TfrmActionApproved') then begin
//      TForm(FindExistingComponent('TfrmActionApproved')).Close;
//    end else begin
//      frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
//      if Assigned(frmApprovedPopUp) then begin
//        with TfrmActionApproved(frmApprovedPopUp) do begin
//          lblAction.Caption := 'Load Roster.';
//          ActionType := 'Load Roster';
//          if ShowModal = mrOk then begin
//            if not IsAccessAllowed('TRosterCalGUI', AuthorisingEmpID) then begin
//              CommonLib.MessageDlgXP_Vista('You do not have access permission for the Roster.', mtInformation, [mbOK], 0);
//              Exit;
//            end;
//
//            if not OpenRoster() then begin
//              CommonLib.MessageDlgXP_Vista('You have Cancelled from the Roster, the Hours will not be ' + #13 + #10 +
//                'Loaded into the Payroll.', mtWarning, [mbOK], 0);
//              Exit;
//            end;
//            Processingcursor(True);
//            PayUtils.LoadRoster(0);
//            Processingcursor(False);
//            CommonLib.MessageDlgXP_Vista('Roster loaded.', mtInformation, [mbOK], 0);
//
//          end;
//          frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
//          if not Assigned(frmApprovedPopUp) then begin
//            TfrmActionApproved(frmApprovedPopUp).Visible := false;
//            TfrmActionApproved(frmApprovedPopUp).SetActionSuccess('T');
//            TfrmActionApproved(frmApprovedPopUp).Close;
//          end;
//        end;
//      end;
//    end;
//  finally
//    qryMain.Refresh;
//  end;
//end;

function TfrmPaySummary.IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(sFnName, iEmployeeID) <> ACCESS_ALLOWED then begin
    Result := false;
  end else
    Result := true;
end;



procedure TfrmPaySummary.AfterPayCreate;
begin
  fbPaycreated:= True;
end;

procedure TfrmPaySummary.btnClearAllClick(Sender: TObject);
//var
//  PaysTrans, Pays: TDataset;
//  tmpPayFunction: TPayFunctionObj;
begin
  inherited;
//  Pays := RetrieveDataset('tblpays', 'PayID', - 1);
//  PaysTrans := RetrieveDataset('tblpaystransactions', 'TransID', - 1);
//  try
//    Pays.First;
//    while not Pays.Eof do begin
//      tmpPayFunction := TPayFunctionObj.Create;
//      try
//        tmpPayFunction.ReallyDeletePay(Pays.FieldByName('PayID').AsInteger);
//        DebugDeleteEntirePayTrans(PaysTrans);
//      finally
//        FreeAndNil(tmpPayFunction);
//      end;
//      Pays.Next;
//    end;
//    RefreshQuery;
//  finally
//    if Assigned(Pays) then
//      FreeAndNil(Pays);
//    if Assigned(PaysTrans) then
//      FreeAndNil(PaysTrans);
//  end;
end;

procedure TfrmPaySummary.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Pay=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Pay=' + QuotedStr('F');
      end;
  end;
  inherited;
  if qryMain.RecordCount = 0 then
    grdMain.Enabled := false
  else
    grdMain.Enabled := true;
end;

procedure TfrmPaySummary.FormDestroy(Sender: TObject);
begin
  PayUtils.Free;
  ThisPay.Free;
  while EmailRecList.Count > 0 do begin
    TempEmailRec(EmailRecList[0]).Free;
    EmailRecList.Delete(0);
  end;
  EmailRecList.Free;
  FreeAndNil(SelectedDepartments);
  inherited;
end;

procedure TfrmPaySummary.actRefreshQryExecute(Sender: TObject);
begin
  fbNoRequery := False;
  inherited;
  grdMain.ColumnByName('EmpName').DisplayLabel := 'Employee Name';
  fbNoRequery := True;
end;

procedure TfrmPaySummary.chkPayExit(Sender: TObject);
begin
  inherited;
 // if (qryMain.State = dsEdit) and (qryMainPayID.AsInteger > 0) and (qryMain.RecordCount > 0) then qryMain.Post;
end;
procedure TfrmPaySummary.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
    If qryMainPrepared.asBoolean then
      ABrush.Color := $00C4FFE1;
end;

procedure TfrmPaySummary.grdMainExit(Sender: TObject);
begin
  inherited;
 // if (qryMain.State = dsEdit) and (qryMainPayID.AsInteger > 0) and (qryMain.RecordCount > 0) then qryMain.Post;
end;

procedure TfrmPaySummary.chkPayClick(Sender: TObject);
begin
  inherited;
  if qryMain.Active And (qryMainPayID.AsInteger = 0) then Begin
    qryMain.Cancel;
    qryMain.First;
    qryMain.Edit;
    Exit;
  end;
  if qryMain.State in [dsInsert, dsEdit] then begin
    if chkPay.Checked then begin
      if qryMainPay.AsString = 'F' then begin
        qryMainPay.AsString := 'T';
      end;
    end else begin
      if qryMainPay.AsString = 'T' then begin
        qryMainPay.AsString := 'F';
      end;
    end;
    if (qryMainPayID.AsInteger > 0) and (qryMain.RecordCount > 0) then qryMain.Post;
    qryMain.Edit;
  end;
end;

procedure TfrmPaySummary.btnLoadTimesheetClick(Sender: TObject);
var
  iResult: integer;
  frmApprovedPopUp: TComponent;
  PayUtils: TPayUtils;
  bViewTimeSheets:Boolean;
begin
  DisableForm;
  bViewTimeSheets := False;
  try
    inherited;
    iResult := CommonLib.MessageDlgXP_Vista('Would you like to verify the timesheet entries now before loading into pays?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if iResult = mrCancel then
      Exit;
    if (iResult = mrYes) or (iResult = mrNo) then begin
      if FormStillOpen('TfrmActionApproved') then begin
        TForm(FindExistingComponent('TfrmActionApproved')).BringToFront;
      end else begin
        frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
        if Assigned(frmApprovedPopUp) then begin
          with TfrmActionApproved(frmApprovedPopUp) do begin
            lblAction.Caption := 'Load Timesheet.';
            ActionType := 'Load Timesheet';
            if ShowModal = mrOk then begin
              if not IsAccessAllowed('TfrmTimeSheet', AuthorisingEmpID) then begin
                CommonLib.MessageDlgXP_Vista('You do not have access permission for the Timesheets.', mtInformation, [mbOK], 0);
                Exit;
              end;

              if iResult = mrYes then begin
                bViewTimeSheets := True;
                //tmpComponent := GetComponentByClassName('TfrmTimeSheet');
//                if Assigned(tmpComponent) then begin
//                  with TfrmTimeSheet(tmpComponent) do begin
//                    Position := poDefault;
//                    FormStyle := fsNormal;
//                    CallingClassName := 'TfrmPaySummary';
//                    if ShowModal = mrCancel then
//                      Exit;
//                  end;
//                end;
              end;
              Processingcursor(True);
              if not MyConnection2.InTransaction then MyConnection2.StartTransaction;
              PayUtils := TPayUtils.Create(nil);
              try

                if not Assigned(ThisPay) then begin
                    ThisPay               := Tpaybase.Create(nil,qryMainPayID.Asinteger,Self.MyConnection2) ;
                    ThisPay.BusObjEvent   := DoBusinessObjectEvent;
                end;
                fbpaycreated:= False;
                AddtimeSheets(bViewTimeSheets);
              finally
                Processingcursor(False);
                MyConnection2.Commit;
                FreeAndNil(PayUtils);
              end;

              qryMain.Close;
              qryMain.Open;
              RefreshTotals;
              try
                frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
                if Assigned(frmApprovedPopUp) then begin
                  TfrmActionApproved(frmApprovedPopUp).SetActionSuccess('T');
                end;
              finally
                TfrmActionApproved(frmApprovedPopUp).Release;
              end;
              CommonLib.MessageDlgXP_Vista('Timesheets loaded.', mtInformation, [mbOK], 0);
            end;
          end;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;


procedure TfrmPaySummary.AddtimeSheets(bViewTimeSheets: boolean);
var
   tmpComponent: TComponent;
   i: integer;
   msgOption: integer;
begin
   qryMain.First;
   msgOption := 0;
   if (qryMain.RecordCount > 1) and (bViewTimeSheets = False) then
      msgOption := MessageDlgXP_Vista
        ('Do you like to load the timesheet prior to this pay as well?', mtConfirmation, [], 0, nil,
        '', '', False, nil, 'Load Current Timesheets, Load All , Cancel');

   while not qryMain.Eof do
   begin

      ThisPay.Load(qryMainPayID.Asinteger);

      if bViewTimeSheets then
      begin

         ThisPay.TimeSheet.First;

         for i := 0 to ThisPay.TimeSheet.Count - 1 do
         begin
            tmpComponent := GetComponentByClassName('TfrmTimeSheet');
            if Assigned(tmpComponent) then
            begin
               with TfrmTimeSheet(tmpComponent) do
               begin
                  Position := poDefault;
                  FormStyle := fsNormal;
                  CallingClassName := 'TfrmEmployeePay';
                  TfrmTimeSheet(tmpComponent).PassedConnection := Self.MyConnection2;
                  KeyID := ThisPay.TimeSheet.TimesheetEntryID;
                  if ShowModal = mrCancel then
                     exit;
               end;
            end;

            ThisPay.TimeSheet.Next;
         end;
      end;

      PayUtils.LoadTimeSheet(ThisPay, msgOption);

      qryMain.Next;
   end;

   if fbPaycreated then
      exit;

   fbPaycreated := False;
   try
      Processunprocessedtimesheet;
      if fbPaycreated then
      begin
         AddtimeSheets(bViewTimeSheets);
      end;
   finally
      fbPaycreated := False;
   end;
end;


procedure TfrmPaySummary.Processunprocessedtimesheet;
var
  s:String;
  ds:TDataset;
  form :TComponent;
begin
  if not(Assigned(ThisPay)) then exit;
  s:= 'select distinct tbltimesheets.EmployeeID, tbltimesheets.EmployeeName  ' +
        ' from tbltimesheets ' +
        ' where tbltimesheets.ID not in (Select IFNULL(TimeSheetId,0) from tblpayspayrates) ' +
        ' and EmployeeId not in (Select EmployeeId from tblpays)';
  ds:= ThisPay.getNewdataset(s , true);
  try
    if ds.recordcount = 0 then exit;
    if MessageDlgXP_Vista(intToStr(ds.recordcount) +' Employees Have Timesheet Entries That Are Not Addded into Pay.'+chr(13) +chr(13) +
                'Do You Wish To Provide the Pay Details For Them And Process The Timesheet?' , mtconfirmation ,[mbyes, mbno] , 0 ) = mrno then exit;

    ds.First;
    While ds.Eof = False do begin
       Form := GetComponentByClassName('TfrmEmployee');
        try
          if (Assigned(Form)) and (TfrmEmployee(Form).AccessLevel<= 1) then begin //if has acess
              with TfrmEmployee(Form) do begin
                AfterPayCreate := Self.AfterPayCreate;
                Displaymode := dmPaydetails;
                KeyId := ds.FieldByname('EmployeeID').asInteger;
                FormStyle           := fsNormal;
                Position            := poScreenCenter;
                ShowModal;
              end;
          end else MessageDlgXP_Vista('You don''t have enough permission to change Employee Info.',mtWarning, [mbok], 0)
        finally
            FreeandNil(Form);
        end;
      ds.Next;
    end;
  finally
    if ds.active then ds.close;
    freeandnil(ds);
  end;
end;

procedure TfrmPaySummary.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPaySummary.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
var
  sSetTo:string;
begin
  if AFieldName = 'Pay' then begin
    grpFilters.ItemIndex := 2;
    if qryMain.FieldByName('Pay').AsString = 'T' then sSetTo := 'F' else sSetTo := 'T';
    qryMain.First;
    while not qryMain.Eof do begin
      qryMain.Edit;
      qryMain.FieldByName('Pay').AsString := sSetTo;
      qryMain.Next;
    end;
  end;
  inherited;
end;

procedure TfrmPaySummary.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if Sysutils.SameText(AFieldName ,'Pay') then begin
      Afont.Color := clmaroon;
      ATitleAlignment := taCenter;
      ABrush.Color := clBtnFace;
    end;
end;

procedure TfrmPaySummary.wwExpandButton2BeforeExpand(Sender: TObject);
begin
  inherited;
  if qryPayExtraDetails.Active then qryPayExtraDetails.Close;
  qryPayExtraDetails.ParamByName('xPayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
  qryPayExtraDetails.Open;
end;

procedure TfrmPaySummary.RefreshQuery;
begin
  inherited;
  if qryMain.RecordCount = 0 then
    grdMain.Enabled := false
  else
    grdMain.Enabled := true;
end;

initialization
  RegisterClassOnce(TfrmPaySummary);
end.

