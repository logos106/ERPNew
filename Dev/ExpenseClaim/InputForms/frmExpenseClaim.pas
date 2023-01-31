unit frmExpenseClaim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, wwcheckbox, DNMSpeedButton, Shader, DNMPanel,
  BusObjExpenseClaim, BusObjBase, wwdblook, Mask, DBCtrls, wwdbdatetimepicker,
  Grids, Wwdbigrd, Wwdbgrid, ERPDbLookupCombo, Buttons, ActnList, wwdbedit,
  Wwdotdot, Wwdbcomb, DNMAction;

type
  TfmExpenseClaim = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryMaster: TERPQuery;
    qryDetail: TERPQuery;
    dsMaster: TDataSource;
    dsDetail: TDataSource;
    qryMasterExpenseClaimID: TIntegerField;
    qryMasterGlobalRef: TWideStringField;
    qryMasterDateTime: TDateTimeField;
    qryMasterDescription: TWideStringField;
    qryMasterTotalTax: TFloatField;
    qryMasterTotalAmountEx: TFloatField;
    qryMasterTotalAmountInc: TFloatField;
    qryMasterEmployeeName: TWideStringField;
    qryMasterEmployeeID: TIntegerField;
    qryMasterRefNo: TWideStringField;
    qryMasterComments: TWideStringField;
    qryMasterActive: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryMastermsUpdateSiteCode: TWideStringField;
    qryDetailExpenseClaimLineID: TIntegerField;
    qryDetailExpenseClaimID: TIntegerField;
    qryDetailGlobalRef: TWideStringField;
    qryDetailDateTime: TDateTimeField;
    qryDetailDescription: TWideStringField;
    qryDetailPayTo: TWideStringField;
    qryDetailTax: TFloatField;
    qryDetailAmountEx: TFloatField;
    qryDetailAmountInc: TFloatField;
    qryDetailAccountName: TWideStringField;
    qryDetailSupplierName: TWideStringField;
    qryDetailSupplierID: TIntegerField;
    qryDetailEmployeeName: TWideStringField;
    qryDetailEmployeeID: TIntegerField;
    qryDetailRefNo: TWideStringField;
    qryDetailComments: TWideStringField;
    qryDetailActive: TWideStringField;
    qryDetailReimbursement: TWideStringField;
    qryDetailmsTimeStamp: TDateTimeField;
    qryDetailmsUpdateSiteCode: TWideStringField;
    Label1: TLabel;
    cboMasterEmployee: TwwDBLookupCombo;
    qryMasterEmployeeLookup: TERPQuery;
    Label2: TLabel;
    edtMasterDescription: TDBEdit;
    edtMasterDate: TwwDBDateTimePicker;
    Label3: TLabel;
    chkProcessed: TwwCheckBox;
    Label4: TLabel;
    qryDetailTaxCode: TWideStringField;
    qryDetailTaxCodeId: TIntegerField;
    qryTaxCodeLookup: TERPQuery;
    qryTaxCodeLookupTaxCodeID: TIntegerField;
    qryTaxCodeLookupDescription: TWideStringField;
    qryTaxCodeLookupRate: TFloatField;
    qryTaxCodeLookupLocation: TWideStringField;
    qryTaxCodeLookupcRate: TFloatField;
    qryDetailEmployeeLookup: TERPQuery;
    qryDetailTaxRate: TFloatField;
    qryAccountLookup: TERPQuery;
    qryAccountLookupAccountName: TWideStringField;
    qryAccountLookupType: TWideStringField;
    qryAccountLookupDescription: TWideStringField;
    qryAccountLookupActive: TWideStringField;
    qryAccountLookupFullAccountName: TWideStringField;
    qryAccountLookupAccountTree: TWideStringField;
    qryAccountLookupAccountNumber: TWideStringField;
    qryAccountLookupAccountID: TIntegerField;
    qryAccountLookupAccountGroup: TWideStringField;
    qryAccountLookupTaxcode: TWideStringField;
    qrySupplierLookup: TERPQuery;
    qrySupplierLookupCompany: TWideStringField;
    qrySupplierLookupClientId: TIntegerField;
    edtTotalInc: TDBEdit;
    edtTotalTax: TDBEdit;
    edtTotalEx: TDBEdit;
    ActionList1: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    Label8: TLabel;
    edtRefNo: TDBEdit;
    qryMasterRequestToEmployeeName: TWideStringField;
    qryMasterRequestToEmployeeID: TIntegerField;
    qryMasterProcessed: TWideStringField;
    Label9: TLabel;
    cboMasterRequestToEmployeeLookup: TwwDBLookupCombo;
    qryMasterRequestToEmployeeLookup: TERPQuery;
    qryDetailAccountId: TIntegerField;
    qryDetailApproval: TWideStringField;
    qryDetailAttachments: TStringField;
    qryAttachmentLookup: TERPQuery;
    btnProcess: TDNMSpeedButton;
    actProcess: TAction;
    qryDetailProcessed: TWideStringField;
    lblProcessed: TLabel;
    qryDetailChequeId: TIntegerField;
    qryDetailBillId: TIntegerField;
    btnPrint: TDNMSpeedButton;
    actPrint: TAction;
    DNMPanel1: TDNMPanel;
    grdMain: TwwDBGrid;
    grdMainIButton: TwwIButton;
    cboTaxCode: TERPDbLookupCombo;
    cboDetailEmployee: TwwDBLookupCombo;
    cboAccountName: TERPDbLookupCombo;
    cboSupplierLookup: TERPDbLookupCombo;
    cboApproval: TwwDBComboBox;
    lblMsg: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    DNMSpeedButton1: TDNMSpeedButton;
    actPreview: TDNMAction;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    txtComments: TDBMemo;
    cmdEmail: TDNMSpeedButton;
    qryCustomerLookup: TERPQuery;
    cboCustomer: TERPDbLookupCombo;
    qryDetailCustomerID: TIntegerField;
    qryDetailCustomerName: TWideStringField;
    qryDetailDueDate: TDateField;
    qryTaxCodeLookupName: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainIButtonClick(Sender: TObject);
    procedure grdMainEnter(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryDetailCalcFields(DataSet: TDataSet);
    procedure grdMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdMainRowChanged(Sender: TObject);
    procedure cboApprovalChange(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure qryTaxCodeLookupBeforeOpen(DataSet: TDataSet);
    procedure qryDetailBeforeInsert(DataSet: TDataSet);
    procedure cmdEmailClick(Sender: TObject);
  private
    ExpenseClaim: TExpenseClaim;
    procedure SetGUILineAccess(Inserting:Boolean =False);
    procedure SetGUIAccess;
    Procedure SetGridColumns;
    function Expenseclaimreport: String;
  protected
    function FormCaptionSuffix: string; override;
    function GetReportTypeID: integer; override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure UpdateMe; override;
  end;


implementation

{$R *.dfm}

uses
  DNMExceptions, BusObjConst, AppEnvironment, CommonLib, frmAttachments,
  tcConst, CommonFormLib, FormFactory, tcDataUtils, ApprovalObj;

procedure TfmExpenseClaim.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmExpenseClaim.actNewExecute(Sender: TObject);
begin
  inherited;
  if ExpenseClaim.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not ExpenseClaim.Save then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
  FormShow(nil);
  ExpenseClaim.Dirty := false;
end;

procedure TfmExpenseClaim.actPrintExecute(Sender: TObject);
var
  SqlStr:String;
begin
  inherited;
  if ExpenseClaim.Dirty and (not ExpenseClaim.Save) then exit;
  ExpenseClaim.connection.CommitTransaction;
  fbReportSQLSupplied := False;
  SqlStr:='and E.ExpenseClaimId = ' + IntToStr(ExpenseClaim.ID);
  Expenseclaimreport;
  PrintTemplateReport(ReportToPrint,SqlStr ,sender = actPrint, 1);
  CloseAfterPrint;
end;
function TfmExpenseClaim.Expenseclaimreport: String;
begin
  ReportToPrint := '';
  if chkChooseRpt.Checked =False then
    ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);

  if (chkChooseRpt.Checked) or (ReportToPrint = '' ) then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;
end;


procedure TfmExpenseClaim.actProcessExecute(Sender: TObject);
var
  sel: word;
  bm: TBookmark;
  allOk: boolean;
  list: TStringList;
  s: string;
  chequeCount: integer;
  billCount: integer;
  x: integer;

  function ItemFormName(Const ItemName:String):String;
  begin
         if sameText(ItemName , 'Cheque') then result := 'TfmCheque'
    else if sameText(ItemName , 'Bill') then result   := 'TBillGUI'
    else result := '';
  end;
  function ItemCount(ItemName: string): integer;
  var i: integer;
  begin
    result := 0;
    for i := 0 to list.Count -1 do begin
      if SameText(list.Names[i],ItemName) then
        Inc(result);
    end;
  end;

begin
  inherited;
  allOk  := False;
  if (ExpenseClaim.Processed) then begin
    MessageDlgXP_vista('This expense claim is already processed', mtWarning, [mbOK], 0);
    exit;
  end;
  if (not ExpenseClaim.Save) then Exit;

  list:= TStringList.Create;
  try
    sel := MessageDlgXP_Vista('Do You Wish To Process This Line or Process all Approved Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Approved Lines,Cancel');
    case sel of
      100:
        begin
          ExpenseClaim.Connection.BeginNestedTransaction;
          s:= ExpenseClaim.Lines.Convert;
          if s <> '' then begin
            ExpenseClaim.Connection.CommitNestedTransaction;
            ExpenseClaim.Lines.Dataset.Refresh;
            ExpenseClaim.Dataset.Refresh;
            if list.IndexOf(s) < 0 then
              list.Add(s);
          end
          else begin
            ExpenseClaim.Connection.RollbackNestedTransaction;
          end;
        end;
      101:
        begin
          allOk:= true;
          ExpenseClaim.Connection.BeginNestedTransaction;
          bm := ExpenseClaim.Lines.Dataset.GetBookmark;
          try
            ExpenseClaim.Lines.First;
            while not ExpenseClaim.Lines.EOF do begin
              if (not ExpenseClaim.Lines.LineProcessed) {and ExpenseClaim.Lines.Approved} then begin
                s:= ExpenseClaim.Lines.Convert;
                if s = '' then begin
                  allOk := false;
                  break;
                end
                else begin
                  if list.IndexOf(s) < 0 then
                    list.Add(s);
                end;
              end;
              ExpenseClaim.Lines.Next;
            end;
            ExpenseClaim.Lines.Dataset.GotoBookmark(bm);
          finally
            ExpenseClaim.Lines.Dataset.FreeBookmark(bm);
          end;
          if allOk then begin
            ExpenseClaim.Connection.CommitNestedTransaction;
          end else begin
            ExpenseClaim.Connection.RollbackNestedTransaction;
          end;
        end;
      102: exit;
    end;
    SetGUIAccess;
    if list.Count > 0  then begin
      self.CommitTransaction;
      ExpenseClaim.UnLock;
      ExpenseClaim.Lock;
      self.BeginTransaction;
      chequeCount := ItemCount('Cheque');
      billCount := ItemCount('Bill');
      s:= '';
      if billCount > 0 then s:= 'A total of ' + IntToStr(billCount) + ' Bills';
      if chequeCount > 0 then begin
        if s <> '' then s:= s + ' and ' + IntToStr(chequeCount) + ' Cheques'
        else s:= 'A total of ' + IntToStr(chequeCount) + ' Cheques';
      end;
      s := s + ' were created.' + NL+NL + 'Do you wish to open these?';

      if MessageDlgXP_Vista(s,mtConfirmation,[mbYes, mbNo],0) = mrYes then begin
        list.Sort;
        for x := 0 to list.Count -1 do begin
            s:= ItemFormName(list.Names[x]);
            if s<> '' then begin
              OpenERPForm(s , StrToInt(list.ValueFromIndex[x]));
              SleepUntilFormshown(s);
            end;
        end;
      end;
    end;
  finally
    list.Free;
  end;
  if allOk  then begin
    ExpenseClaim.Dirty := False;
  end;
end;

procedure TfmExpenseClaim.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (not ExpenseClaim.Processed) and (not ExpenseClaim.Save) then Exit;
  CommitTransaction;
  ExpenseClaim.Dirty := False;
  Notify;
  Close;
end;

procedure TfmExpenseClaim.cboApprovalChange(Sender: TObject);
var
  val: string;
begin
  inherited;
  if IsFlag('Approval') then exit;
  AddFlag('Approval');
  try
    if cboApproval.Focused then begin
      val := cboApproval.Text;
      if not TApprovalCheck.Approved(ExpenseClaim) then begin
        {reject this change}
        cboApproval.Text := qryDetailApproval.AsString;
        //CommonLib.MessageDlgXP_Vista('Your Approval Levels are insufficient to make this change',mtInformation,[mbOk],0);
      end
      else begin
        { user has approval }
        if SameText(cboApproval.Text,'Approved') then begin
          ExpenseClaim.ResultStatus.Clear;
          if not ExpenseClaim.Lines.ValidateData then begin
            cboApproval.Text := qryDetailApproval.AsString;
            exit;
          end
          else begin
            { allow change }
            ExpenseClaim.Lines.Approval := val;
            SetGUILineAccess;
          end;
        end
        else begin
          { allow change }
          ExpenseClaim.Lines.Approval := val;
          SetGUILineAccess;
        end;
      end;
    end;
  finally
    RemoveFlag('Approval');
  end;
end;

procedure TfmExpenseClaim.cmdEmailClick(Sender: TObject);
var
  SqlStr:String;
begin
  inherited;
  if ExpenseClaim.Dirty and (not ExpenseClaim.Save) then exit;
  ExpenseClaim.connection.CommitTransaction;
  fbReportSQLSupplied := False;
  SqlStr:='and E.ExpenseClaimId = ' + IntToStr(ExpenseClaim.ID);
  Expenseclaimreport;
  if ReportToPrint = '' then exit;
  EmailReport(ExpenseClaim.Id,   ExpenseClaim.EmployeeName, ExpenseClaim.RequestToEmployeeEmail , trim(ReportToPrint) , trim(ReportToPrint) , SqlStr, False, True);
  CloseAfterPrint;
end;

procedure TfmExpenseClaim.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TExpenseClaim then TExpenseClaim(Sender).DataSet:= qryMaster
    else if (Sender is TExpenseClaimLine) then TExpenseClaimLine(Sender).DataSet:= qryDetail;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) and (Sender is TExpenseClaimLine ) then begin
    if ExpenseClaim.Lines.name <> '' then
      if not ExpenseClaim.Lines.GLAccount.AllowExpenseClaim then
        timermsg(lblMsg , 'Selected Account '+ quotedstr(ExpenseClaim.Lines.Accountname)+' is not available for ''Employee Expense Claim''.'+
                          '  It should be flagged for ''Employee Expense Claim'' inorder to process it.');
  end;
end;

function TfmExpenseClaim.FormCaptionSuffix: string;
begin
  result := '';
  if Assigned(ExpenseClaim) and ExpenseClaim.Processed then
    result := ' Claim Processed';
end;

procedure TfmExpenseClaim.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmExpenseClaim.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if ExpenseClaim.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if ExpenseClaim.Save then begin
            ExpenseClaim.Connection.CommitTransaction;
            ExpenseClaim.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          ExpenseClaim.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmExpenseClaim.FormCreate(Sender: TObject);
begin
  self.AllowCustomiseGrid := true;
  //NamenPrintNameGridObj.TaxcodeLookupQueryWithSearchengine(0, cboTaxCode , true);
  With TERPQuery(cboTaxCode.Lookuptable).sql do begin
    Clear;
    Add(NamenPrintNameGridObj.TaxcodeLookupSQL(0, true));
  end;

  inherited;
  lblProcessed.Visible := false;
  fbTabSettingEnabled := false;
  ExpenseClaim:= TExpenseClaim.Create(self);
  ExpenseClaim.Connection := TMyDacDataConnection.Create(ExpenseClaim);
  ExpenseClaim.Connection.MyDacConnection := MyConnection;
  ExpenseClaim.BusObjEvent := DoBusinessObjectEvent;
  GuiPrefs.Active := True;
end;

procedure TfmExpenseClaim.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      RollbackTransaction;


      BeginTransaction;

      ExpenseClaim.Load(KeyId);
      if KeyID = 0 then ExpenseClaim.New;
      ExpenseClaim.PostDB;
      ExpenseClaim.Lines;
      openqueries;
      ExpenseClaim.Dirty := false;

      SetGUIAccess;
      SetGridColumns;

            if ExpenseClaim.EmployeeID          = 0 then SetControlfocus(cboMasterEmployee)
      else  if ExpenseClaim.requesttoEmployeeID = 0 then SetControlfocus(cboMasterRequestToEmployeeLookup)
      else SetControlfocus(edtMasterDescription);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmExpenseClaim.GetReportTypeID: integer;
begin
  result := 132;
end;

procedure TfmExpenseClaim.grdMainDblClick(Sender: TObject);
  function ItemFormName:String;
  begin
         if qryDetailChequeId.AsInteger > 0  then result := 'TfmCheque'
    else if qryDetailBillId.AsInteger   > 0  then result   := 'TBillGUI'
    else result := '';
  end;

begin
  inherited;
  if ItemFormName ='' then begin
    CommonLib.MessageDlgXP_Vista('No further information available for this line.',mtInformation,[mbOk],0);
    exit;
  end;
  OpenERPForm(ItemFormName , iif(qryDetailChequeId.AsInteger>0 , qryDetailChequeId.AsInteger , qryDetailBillId.AsInteger));
end;

procedure TfmExpenseClaim.grdMainEnter(Sender: TObject);
begin
  inherited;
  if ExpenseClaim.Description = '' then begin
    FocusControl(edtMasterDescription);
    CommonLib.MessageDlgXP_Vista('Please enter a Description for this Claim first',mtInformation,[mbOk],0);
  end;

end;

procedure TfmExpenseClaim.grdMainIButtonClick(Sender: TObject);
begin
  inherited;
  if ExpenseClaim.Lines.Approval <> 'Approved' then
    if CommonLib.MessageDlgXP_Vista('Delete the selected line?.',mtConfirmation,[mbYes, mbNo],0) = mrYes then
      ExpenseClaim.Lines.Delete
  else
    CommonLib.MessageDlgXP_Vista('Can not delete a line that ' + APPROVEDDESC +'.',mtInformation,[mbOk],0);
end;

procedure TfmExpenseClaim.grdMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  form: TfmAttachments;
begin
  inherited;
  if Button <> mbLeft then exit;
  if grdMain.GetActiveField = qryDetailAttachments then begin
    Form := TfmAttachments(GetComponentByClassName('TfmAttachments', true, Self, true, true, qryDetailExpenseClaimLineID.AsInteger));
    If Assigned(Form) Then Begin
      ExpenseClaim.Lines.PostDb;
      With Form Do Begin
        DBConnection := Self.MyConnection;
        AttachObserver(Self);
        TableName := 'tblexpenseclaimline';
        TableId   := qryDetailExpenseClaimLineID.AsInteger;
        Tag       := qryDetailExpenseClaimLineID.AsInteger;
        FormStyle := fsMDIChild;
        BringToFront;
      End;
    End;
  end;
end;

procedure TfmExpenseClaim.grdMainRowChanged(Sender: TObject);
begin
  inherited;
  SetGUILineAccess;
end;

procedure TfmExpenseClaim.qryDetailBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  SetGUILineAccess(true);
end;

procedure TfmExpenseClaim.qryDetailCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryAttachmentLookup.Close;
  qryAttachmentLookup.ParamByName('TableId').AsInteger := qryDetailExpenseClaimLineID.AsInteger;
  qryAttachmentLookup.Open;
  if qryAttachmentLookup.FieldByName('Count').AsInteger > 0 then
    qryDetailAttachments.AsString := '[ + ]'
  else
    qryDetailAttachments.AsString := '[ - ]';
  qryAttachmentLookup.Close;
end;

procedure TfmExpenseClaim.qryTaxCodeLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxCodeLookup.ParamByName('xRegionID').asInteger             := AppEnv.RegionalOptions.ID;
  qryTaxCodeLookup.ParamByName('Clientcountry').asString          := '';
  qryTaxCodeLookup.ParamByName('ClientState').asString            := '';
  qryTaxCodeLookup.ParamByName('clientLocation').asString         := '';
  qryTaxCodeLookup.ParamByName('ClientPostcode').asString         := '';
  qryTaxCodeLookup.ParamByName('filterTaxcodeforClient').asString := 'F';
end;

procedure TfmExpenseClaim.SetGridColumns;
begin
    grdMain.RemoveField(qryDetailAccountId.FieldName)         ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailAccountId.FieldName);
    grdMain.RemoveField(qryDetailExpenseClaimlineID.FieldName);GuiPrefs.DbGridElement[grdMain].HideField(qryDetailExpenseClaimlineID.FieldName);
    grdMain.RemoveField(qryDetailExpenseClaimId.FieldName)    ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailExpenseClaimId.FieldName);
    grdMain.RemoveField(qryDetailglobalref.FieldName)         ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailglobalref.FieldName);
    grdMain.RemoveField(qryDetailSupplierId.FieldName)        ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailSupplierId.FieldName);
    grdMain.RemoveField(qryDetailEmployeeID.FieldName)        ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailEmployeeID.FieldName);
    grdMain.RemoveField(qryDetailmstimeStamp.FieldName)       ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailmstimeStamp.FieldName);
    grdMain.RemoveField(qryDetailmsupdateSiteCode.FieldName)  ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailmsupdateSiteCode.FieldName);
    grdMain.RemoveField(qryDetailTaxcodeId.FieldName)         ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailTaxcodeId.FieldName);
    grdMain.RemoveField(qryDetailChequeID.FieldName)          ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailChequeID.FieldName);
    grdMain.RemoveField(qryDetailBillID.FieldName)            ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailBillID.FieldName);
    grdMain.RemoveField(qryDetailTaxRate.FieldName)           ;GuiPrefs.DbGridElement[grdMain].HideField(qryDetailTaxRate.FieldName);
end;

procedure TfmExpenseClaim.SetGUIAccess;
begin
  if (AccessLevel < 3) then begin
    if ExpenseClaim.Processed then
      AccessLevel := 5;
    lblProcessed.Visible := ExpenseClaim.Processed;
  end;
  if Accesslevel < 3 then begin
    if ExpenseClaim.Lock =false then begin
      Accesslevel := 5;
      MessageDlgXP_Vista(replacestr(ExpenseClaim.userlock.LockMessage , 'Unable to update data.' , 'Access changed To Read Only.') , mtWarning, [mbok] , 0);
    end;
  end;
end;

procedure TfmExpenseClaim.SetGUILineAccess(Inserting:Boolean =False);
var
  x: integer;
begin
  if (AccessLevel < 3) then begin
    for x := 0 to qryDetail.FieldCount -1 do begin
      if (qryDetail.Fields[x] <> qryDetailTax) and (qryDetail.Fields[x] <> qryDetailTaxRate) then begin
        if (not(Inserting)) and qryDetailProcessed.AsBoolean then begin
          qryDetail.Fields[x].ReadOnly := true;
          grdmain.ColumnByName(qryDetail.Fields[x].FieldName).ReadOnly := true;
        end else begin
          qryDetail.Fields[x].ReadOnly := false;
          grdmain.ColumnByName(qryDetail.Fields[x].FieldName).ReadOnly := False;
        end;
      end;
    end;
    cboAccountName.enabled    := not(qryDetailProcessed.AsBoolean and not(Inserting));
    cboSupplierLookup.enabled := not(qryDetailProcessed.AsBoolean and not(Inserting));
    cboDetailEmployee.enabled := not(qryDetailProcessed.AsBoolean and not(Inserting));
    cboTaxCode.enabled        := not(qryDetailProcessed.AsBoolean and not(Inserting));
  end;
end;

procedure TfmExpenseClaim.UpdateMe;
begin
  inherited;
  if qryDetail.Active then
    qryDetail.Refresh;
end;

initialization
  RegisterClass(TfmExpenseClaim);
  with FormFact do begin
    RegisterMe(TfmExpenseClaim, 'TExpenseClaimListGUI_*_Request=ExpenseClaimID');
    RegisterMe(TfmExpenseClaim, 'TExpenseClaimListGUI_*_Deleted Request=ExpenseClaimID');
    RegisterMe(TfmExpenseClaim, 'TSalesReportGUI_ExpenseClaimID_*=ExpenseClaimID');
    RegisterMe(TfmExpenseClaim, 'TSalesReportGUI_Claimdate_*=ExpenseClaimID');
    RegisterMe(TfmExpenseClaim, 'TSalesReportGUI_Description_*=ExpenseClaimID');
    RegisterMe(TfmExpenseClaim, 'TReminderListGUI_*_Expense Claim=ID');
  end;
end.
