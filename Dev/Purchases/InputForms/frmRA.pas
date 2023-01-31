{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/07/05  1.00.01 BJ    Bug Fixed : cboPartsSepc is a combobox introduced in the
                         Order form which is not used here but used in purchase order
                         as an embedded combo for the grid. The combo was visible
                         in the centre of the screen.
                         Order
                            |--Purchase Order
                            |--Return Authority
                         Made the combo inviisble for this form.
 19/10/05 1.00.02 DLS  Added RegisterClass.
 10/01/06 1.00.03 AL   Changed Search modes to use SearchEngineObj.
 01/02/06 1.00.04 DSP  Modified tblDetails' fields initial property values.
 06/02/06 1.00.05 DSP  Product_Description field is visible again.
 09/02/06 1.00.06 DSP  Changed HiddenFields to HideField.
 20/02/06 1.00.07 DSP  Added password to email authentication.
 25/05/06 1.00.08 BJ   PO object is introduced for PurchaseOrder,
                       Repeated Code from the template-Order-is moved into this unit because .
 15/08/06 1.00.09 Bj  isok_to_Print returns true if the form is in readonly state
                      ValidateClosingDate function in the basetrans form locks the records prior to closingdate,
                      RA records should not be locked as it doesn;t affect the qty, so overiding not to lock.

}

unit frmRA;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Order, DB,   StdCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  wwdbdatetimepicker, wwdblook, DBCtrls, Mask, ExtCtrls, wwdbedit, Wwdotdot,
  Wwdbcomb, DNMPanel, kbmMemTable, Wwdbigrd, Grids,
  Wwdbgrid, ActnList, Menus, AdvMenus, {Psock,} ImgList, SelectionDialog, AppEvnts, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, EmailUtils, DMComps,
  BusObjBase,Shader,busobjOrders, ProgressDialog, DNMAction, ERPDbLookupCombo;

type
  TReturnAGUI = class(TBaseOrderGUI)
    Bevel1: TBevel;
    cboStatus: TwwDBComboBox;
    memtblMaster: TkbmMemTable;
    memtblDetails: TkbmMemTable;
    DNMSpeedButton1: TDNMSpeedButton;
    edtCreditMsg: TLabel;
    tblDetailsOriginalCost: TFloatField;
    tblDetailsSEQNo: TIntegerField;
    Label7: TLabel;
    txtConsignmentNotes: TDBMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cmdFaxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure tblDetailsShippedChange(Sender: TField);
    procedure tblDetailsAttrib2PurchaseChange(Sender: TField);
    procedure grdTransactionsEnter(Sender: TObject);
//    procedure cboProductXCloseUp(Sender: TObject; LookupTable,
//      FillTable: TDataSet; modified: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure edtCreditMsgDblClick(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure grdTransactionsRowChanged(Sender: TObject);
  private
    function SendPrintEmailSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintSMS: boolean;
    Procedure LockRA;
    Function IsRALocked: Boolean;
  protected
//    SE : TSearchEngineObj;
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    function GetReportTypeID: integer; override;
    procedure IsOK_to_Print(var IsOk: boolean); override;
    function ValidateClosingDate(const TransDate: TDateTime): Boolean; override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure DoOnProductchange;Override;
    procedure CommitAndNotify;Override;
    function TransStatustype:String;Override;
    procedure NewTransBusObjinstance;override;
    function SaveTrans:Boolean ; Override;
    function Save4NewTrans: Boolean;Override;
    Function IstransLineLocked: Boolean;Override;
  public
    { Public declarations }
    RAObj :TReturnAuthority;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;

implementation

{$R *.dfm}

uses
  FormFactory, DNMExceptions,  CommonDbLib, FaxObj,
   BaseInputForm, DNMLib, AppEnvironment, CommonLib, FastFuncs,
  tcDataUtils, MySQLConst, CommonFormLib, BusObjConst, tcTypes,
  tcconst, frmReportingOptions, SMSUtils,
  CorrespondenceObj, EmailExtraUtils;

procedure TReturnAGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TReturnAGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    if not RAObj.Save then Exit;
    CommitAndNotify;
    Close;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;
end;
procedure TReturnAGUI.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;
end;
function TReturnAGUI.GetReportTypeID: integer;
begin
  Result := 24;
end;

procedure TReturnAGUI.FormShow(Sender: TObject);
begin
stepProgressbar;
try
  DisableForm;
  try
    try

      inherited;
      GuiPrefs.DbGridElement[grdTransactions].RemoveFields(
        'LandedCostsPercentage,TotalLineLandedCost,' +
        'QtySold,UnitOfMeasureQtySold,'+
        'Shipped,UnitOfMeasureShipped,QtySold,UnitOfMeasureBackorder,'+
        'SupplierProductCode,SupplierProductName,pqa,'+
        'FormulaQtyShippedValue,FormulaQtyShippedValue1,FormulaQtyShippedValue2,FormulaQtyShippedValue3,FormulaQtyShippedValue4,FormulaQtyShippedValue5');
      GuiPrefs.DbGridElement[grdTransactions].AddField('RAQty');
      GuiPrefs.DbGridElement[grdTransactions].AddField('RAStatus');
      GuiPrefs.DbGridElement[grdTransactions].AddField('CustomerJob');

      RAObj.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      RAObj.Lines.Dataset.Filtered:= true;

      cboProductQry.Open;

      lblBaseForeignCurrencyCode.Visible := false;
      cboBaseForeignCurrencyCode.Visible := false;
      lblBaseExchangeRate.Visible        := false;
      edtBaseExchangeRate.Visible        := false;

      tblDetails.First;
      LockRA;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
finally
  Enabledisable;
  hideProgressbar;
end;
end;

procedure TReturnAGUI.cmdEmailClick(Sender: TObject);
var
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: string;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  qryEmailedList: TERPQuery;
  intResult: integer;
  strResult: string;
  Emailed:Boolean;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  Emailed:=False;
    DisableForm;
    try
      RecipientAddress := '';
      ReportType := '';
      OutGoingFileName := '';
      if not RAObj.Save then Exit;
      CommitAndNotify;
      try
        RecipientAddress := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger,'MainContactForRA');

        lSilent := true;
        lSecret := false;
        if RecipientAddress = '' then
        begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('SupplierName').AsString +
            ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
            'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0)  = mrNo then
              Exit;
          lSilent := false;
        end;

        ReportType := 'Return Authority';
        // String defined here because it is easy to change when this code is applied to
        // other forms. (ie, Quote instead of Invoice etc)

        // Ask the user if they want to specify a new subject
        intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
          tblMaster.FieldByName('SupplierName').AsString + '.' + #13 + #10 + #13 + #10 +
          'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
          'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
          [mbYes, mbNo, mbCancel], 0);

        if intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
            ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString +
            ' for ' + tblMaster.FieldByName('SupplierName').AsString);
        end else if intResult = mrNo then begin
          strResult := '';
        end else begin
          Exit;
        end;

        Corres := TCorrespondenceGui.Create;
        try
          lblEmail.Visible := true;
          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
          // TURN OFF BUTTONS WHILE EMAIL IS BEING SENT
          btnNext.Enabled := false;
          btnCompleted.Enabled := false;
          btnClose.Enabled := false;
          btnPreview.Enabled := false;
          btnPrint.Enabled := false;
          cmdEmail.Enabled := false;

          LoadTemplate(true, true);

          if lSilent then
            if not EmailShortSendMode(lSilent, lSecret) then
              exit;

          try

            Corres.Subject := ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString +
              ' for ' + tblMaster.FieldByName('SupplierName').AsString;

            Corres.RecipientList := RecipientAddress;
            Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

            OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString, '.PDF');
            AssignFile(f,  Commonlib.TempDir  + 'EmailReport.PDF');

            if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
              copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                PChar( Commonlib.TempDir  + OutGoingFileName), false);
            end;

            Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
            ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(REportToPrint));
            if Corres.Execute(lSilent, lSecret) then begin

              Emailed:=True;
              /////////////////////////

              TransactionID := tblMaster.FieldByName('PurchaseOrderNumber').AsString;
              UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
              EmailDate := Now;

              // ReportType already defined at start of procedure
              TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
                tblMaster.FieldByName('PurchaseOrderNumber').AsString + ' for ' + tblMaster.FieldByName('SupplierName').AsString;

              qryEmailedList := TERPQuery.Create(nil);
              qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
              try
                qryEmailedList.Sql.Clear;
                qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
                  TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
                  EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
                  '")');
                qryEmailedList.Execute;

              finally
                FreeAndNil(qryEmailedList);
                ReportToPrint := '';
              end;
            end;

            DeleteFiles( Commonlib.TempDir , '*.PDF');
            DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
            lblEmail.Visible := false;
            // TURN ON BUTTONS AFTER EMAIL HAS BEEN SENT
            btnNext.Enabled := true;
            btnCompleted.Enabled := true;
            btnClose.Enabled := true;
            btnPreview.Enabled := true;
            btnPrint.Enabled := true;
            cmdEmail.Enabled := true;

          except
            lblEmail.Visible := false;
            CommonLib.MessageDlgXP_Vista('There was an error sending email', mtInformation , [mbOK], 0);
          end;
        finally
          Corres.Free;
        end;
      finally
        LogEmailed(Emailed, ReportType);
        closeAfterPrint(Emailed);
      end;

    finally
      RAObj.ResultStatus.Clear;
      EnableForm;
    end;
end;

function TReturnAGUI.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  try
    if RAObj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes   : if RAObj.Save then begin
          CommitAndNotify;  // current record should be commited before inserting new reocrd
          Result := True;
        end;
        mrNo    : begin
          RollbackTransaction;
          Result := True;
        end;
        mrCancel: Exit;
      end;
    end else begin
      REsult := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TReturnAGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if RAObj.Save then begin
      Self.CommitAndNotify;
      try
        inherited;
        RAObj.Dirty:= false;
        CloseAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;

end;

procedure TReturnAGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not RAObj.Save then exit;
  Self.CommitAndNotify;
    OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
    try
      OptsForm.ActionList.AddDivider('Print');
      OptsForm.ActionList.Add('Print' ,'Print a Return Authority',actPrintExecute, true, true);
      OptsForm.ActionList.Add('Preview', 'Preview a Return Authority', self.actPreviewExecute, true, true);
      OptsForm.ActionList.Add('Save PDF','Save a PDF Return Authority to your computer', SaveTransToPDF, true, true);

      OptsForm.ActionList.AddDivider('Email');
      OptsForm.ActionList.Add('Email RA', 'Email a copy of the Return Authority', DoEmailTransactionSilentnSecret, true, true);
      OptsForm.ActionList.Add('Email RA (Edit)', 'Edit Email Message Before Sending, With a Copy of the RA', DoEmailTransactionnonsilent, true, true);
      if AppEnv.CompanyPrefs.EnableInvoiceMail and ((RAObj.ContactEmail <> '') or (RAObj.Supplier.Email <> '')) then begin
        OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Return Authority', self.SendPrintEmailSilent, true, true);
      end
      else begin
        OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Return Authority', self.SendPrintEmailSilent, true, false);
      end;
      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Return Authority', self.SendPrintEmail, true, true);

      OptsForm.ActionList.AddDivider('SMS');
      IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
         AppEnv.CompanyPrefs.EnableRAPrintSMS and
         ((RAObj.ContactMobile <> '') or (RAObj.Supplier.Email <> ''));
      OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
      OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

      OptsForm.ShowModal;
      CloseAfterPrint(OptsForm.CloseWhenDone );
    finally
      OptsForm.Free;
    end;
end;

procedure TReturnAGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    if RAObj.Save then begin
      Self.CommitAndNotify;
      try
        inherited;
        RAObj.Dirty:= false;
//        closeAfterPrint;
        self.BeginTransaction;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;
end;

procedure TReturnAGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if RAObj.Save then begin
      Self.CommitAndNotify;
      try
        inherited;
        RAObj.Dirty:= false;
//        closeAfterPrint;
        self.BeginTransaction;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;
end;


procedure TReturnAGUI.IsOK_to_Print(var IsOk: boolean);
begin
  if AccessLevel = 5 then begin
      isOk := True;
      Exit;
  end;
  ProcessEditedFlag('Main', Self, memTblMaster, tblMaster, nil);
  ProcessEditedFlag('Lines', Self, memTblDetails, tblDetails, tblMaster);
  IsOk := true;
end;

function TReturnAGUI.IsRALocked: Boolean;
begin
  result := False;
  If Not tblmaster.active then Exit;
  If RAObj.CleanId <> 0 Then REsult := RAObj.CreditRef<> '';
  if not Result then result := AccessLevel > 3;
end;

function TReturnAGUI.IstransLineLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;

  (*If RAObj.Lines.RAstatus =RALineStatus_Returned  then begin
    LineLockMsg :='This Product is Returned';
    result := True;
  End;*)

end;

procedure TReturnAGUI.LockRA;
Var
  intX: Integer; fIsPOLineLocked: Boolean;
  ctr:Integer;
  lIsLocked : boolean;
Begin
  lIsLocked := IsRALocked;
  For intX := 0 To Self.ComponentCount - 1 Do Begin
    If Self.Components[intX] Is TwwDBDateTimePicker then TwwDBDateTimePicker(Self.Components[intX]).ReadOnly := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TwwDBLookupCombo then TwwDBLookupCombo(Self.Components[intX]).ReadOnly  := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TDBMemo then TDBMemo(Self.Components[intX]).ReadOnly                    := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TDBEdit then TDBEdit(Self.Components[intX]).ReadOnly                    := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TEdit then TEdit(Self.Components[intX]).ReadOnly                        := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is twwIButton then twwIButton(Self.Components[intX]).Enabled               := Not(lIsLocked); //IsPOLocked);
    If Self.Components[intX] Is TwwDBGrid Then
      If Not IsRALocked then begin
        If Not(dgEditing In TwwDBGrid(Self.Components[intX]).Options) then TwwDBGrid(Self.Components[intX]).Options := TwwDBGrid(Self.Components[intX]).Options + [dgEditing];
      end else
        If dgEditing In TwwDBGrid(Self.Components[intX]).Options  then TwwDBGrid(Self.Components[intX]).Options := TwwDBGrid(Self.Components[intX]).Options - [dgEditing];

  End;

//  If Not IsPOLocked then begin
  if not lIsLocked then
  begin
    If keyId <> 0 then begin
      fIsPOLineLocked  := IstransLineLocked;
      for ctr:= 0 to tbldetails.Fields.Count-1 do
        try
          grdtransactions.ColumnByName(tbldetails.Fields[ctr].fieldname).ReadOnly:= fIsPOLineLocked;
        Except
          // kill exception if the column doesn't exists
        end;
      cboProductR.ReadOnly                    := fIsPOLineLocked;
      if fIsPOLineLocked then begin
        if dgEditing      in grdTransactions.Options    then grdTransactions.Options    := grdTransactions.Options    - [dgEditing];
        if dgAllowInsert  in grdTransactions.KeyOptions then grdTransactions.Keyoptions := grdTransactions.KeyOptions - [dgAllowInsert];
      end;
    End;
  End;


  ApplyTransAccesslevel(IsRALocked , IsRALocked);
end;

procedure TReturnAGUI.NewTransBusObjinstance;
begin
  Freeandnil(RAObj);
  RAObj := TReturnAuthority.Create(Self);
  RAObj.Name:= 'RAObjObj';
  RAObj.DoProductallocation := Self.DoProductallocation;
  Order                  := RAObj;
  inherited;
end;

function TReturnAGUI.SaveTrans: Boolean;
begin
  REsult := RAObj.Save ;
end;

function TReturnAGUI.SendPrintEmail: boolean;
var
  msgTo: string;
begin
  msgTo := RAObj.ContactEmail;
  if msgTo = '' then msgTo := RAObj.Supplier.Email;

  result := TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TReturnAGUI.SendPrintEmailSilent: boolean;
var
  msgTo: string;
begin
  msgTo := RAObj.ContactEmail;
  if msgTo = '' then msgTo := RAObj.Supplier.Email;

  result := TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;

function TReturnAGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  TCorrespondenceGui.SMSSupplier(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TReturnAGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  result := true;
  toMobile := RAObj.ContactMobile;
  if toMobile = '' then
    toMobile := RAObj.Supplier.Mobile;
  TCorrespondenceGui.SMSSupplier(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RAPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;

function TReturnAGUI.TransStatustype: String;
begin
  REsult:= SimpleTypes_ReturnAuthority;
end;

procedure TReturnAGUI.cmdFaxClick(Sender: TObject);
var
  IsOK: boolean;
  Fax: TFaxObj;
  FaxNo: string;
  Faxed:Boolean;
begin
  Faxed:= false;
  DisableForm;
  try
    inherited;
    IsOK_to_Print(IsOK);
    if not IsOK then begin
      Exit;
    end;
    //FaxNo := GetClientFaxNumber(tblMaster.FieldByName('ClientID').AsInteger);
    if not RAObj.Save then Exit;
    CommitAndNotify;
    try
      FaxNo := RAObj.Supplier.Faxnumber;

      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('SupplierName').AsString +
          ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
          'Please Review Supplier information to Add an Fax Number.', mtWarning,
          [mbOK], 0);
      end else begin
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Adding to Fax Spool...';
        fsFax          := true;
        LoadTemplate(true, true, true, 'RA_' + tblMasterGlobalRef.AsString);
        Fax := TFaxObj.Create;
        try
          Fax.AddToFaxSpool(tblMaster.FieldByName('EmployeeName').AsString,
            tblMaster.FieldByName('SupplierName').AsString, FaxNo, 'Return Authority',
            tblMaster.FieldByName('GlobalRef').AsString, '',
            ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
          Faxed:= true;
        finally
          FreeAndNil(Fax);
        end;
        lblEmail.Visible := false;
        DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
      end;
    finally
      LogFaxed(Faxed , ReportToPrint);
      ReportToPrint:= '';
      closeAfterPrint(Faxed);

    end;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;
end;

procedure TReturnAGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if RAObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if RAObj.Save then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          RAObj.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
    RAObj.ResultStatus.Clear;
  end else begin
    CanClose := true;
  end;
end;

procedure TReturnAGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  edtCreditMsg.Caption := '';
  fLastComboAccessed := nil;
  cboStatus.Items.CommaText:= RALineStatusCommaText;
  cboStatus.Items.Add('');

  //Create Search Engine
//  SE := TSearchEngineObj.Create(self);
//  SE.OriginalSQL := cboProductQry.SQL.Text;
//  SE.ComboName := 'cboProductX';
//  SE.QueryName := 'cboProductQry';
//  SE.SearchLookupFields.Add(
//  'if((LOCATE("^",tblParts.PRODUCTGROUP,InStr(tblParts.PRODUCTGROUP,"^")+1))>0,'+//Dept
//  'MID(tblParts.PRODUCTGROUP,LOCATE("^",tblParts.PRODUCTGROUP,'+
//  'InStr(tblParts.PRODUCTGROUP,"^")+1)+1,char_length(tblParts.PRODUCTGROUP)-'+
//  'LOCATE("^",tblParts.PRODUCTGROUP,InStr(tblParts.PRODUCTGROUP,"^")+1)),Null);'+
//  'MID(tblParts.PRODUCTGROUP,InStr(tblParts.PRODUCTGROUP,"^")+1,'+//Type
//  'If(LOCATE("^",tblParts.PRODUCTGROUP,'+
//  'InStr(tblParts.PRODUCTGROUP,"^")+1)-InStr(tblParts.PRODUCTGROUP,"^")>0,'+
//  'LOCATE("^",tblParts.PRODUCTGROUP,'+
//  'InStr(tblParts.PRODUCTGROUP,"^")+1)-1-InStr(tblParts.PRODUCTGROUP,"^"),'+
//  'IF(InStr(tblParts.PRODUCTGROUP,"^")<>0,'+
//  'char_length(tblParts.PRODUCTGROUP)-InStr(tblParts.PRODUCTGROUP,"^"),0)));'+
//  'If(InStr(tblParts.PRODUCTGROUP,"^")-1>0,Left(tblParts.PRODUCTGROUP,InStr(tblParts.PRODUCTGROUP,"^")-1),'+
//  'tblParts.PRODUCTGROUP);'+//Manuf
//  'tblParts.PARTNAME;'+//PartName
//  'tblParts.PartsDescription');//PartsDescription
//  SE.GridName := 'grdTransactions';
//  SE.GridFieldName := 'ProductName';
end;

procedure TReturnAGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
begin
  if Cancelled then Exit;
    (*if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboProductR') then begin
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
      end;
    end;
    end;*)
  if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then begin
    if Sysutils.SameText(fLastComboAccessed.Name, 'cboProductR') then begin
      with fLastComboAccessed do begin
        LookupTable.Close;
        LookupTable.Open;
        if LookupTable.Locate('PartsId', TBaseInputGUI(aObject).KeyID, []) then begin
          if not (tblDetails.State in [dsEdit, dsInsert]) then tblDetails.Edit;
          tblDetails.FieldByName('ProductName').AsString := LookupTable.FieldByName('PartName').AsString;
        end;
      end
    end;
  end;
  inherited UpdateMe(cancelled, aObject);
end;


procedure TReturnAGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TReturnAGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TReturnAGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TReturnAGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TReturnAGUI.tblDetailsShippedChange(Sender: TField);
begin
  inherited;
  with tblDetails do begin
    if not (Self.ClassName = 'TReturnAGUI') then begin
      if FieldByName('QtySold').AsFloat < Sender.AsFloat then begin
        CommonLib.MessageDlgXP_Vista('Can''t Ship a Greater Quantity then Ordered !', mtWarning, [mbOK], 0);
        with tblDetails do begin
          FieldByName('Shipped').AsFloat := FieldByName('QtySold').AsFloat;
        end;
      end;
    end;
  end;
end;

procedure TReturnAGUI.tblDetailsAttrib2PurchaseChange(Sender: TField);
begin
  if IsUsingBusObj then begin
    Exit;
  end;
  if tblDetails.FieldByName('Attrib2Purchase').AsFloat < 0 then
    tblDetails.FieldByName('Attrib2Purchase').AsFloat := tblDetails.FieldByName('Attrib2Purchase').AsFloat * -1;
  inherited;

end;

function TReturnAGUI.ValidateClosingDate(const TransDate: TDateTime): Boolean;
begin
  // as the qty or cost is not involved , don;t lock the record
  Result := False;
end;

procedure TReturnAGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  if RAObj.Lines.Dataset.State in [dsEdit,dsInsert] then Exit;

  RAObj.Lines.Dataset.Disablecontrols;
  Try
    if RAObj.Lines.Dataset.Recordcount = 0 then
        if RAObj.Lines.Dataset.State in [dsEdit,dsInsert] then
        else RAObj.Lines.New;
  Finally
      RAObj.Lines.Dataset.EnableControls;
  end;
  LockRA;

end;

procedure TReturnAGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
  LockRA;
end;

//procedure TReturnAGUI.cboProductXCloseUp(Sender: TObject; LookupTable,
//  FillTable: TDataSet; modified: Boolean);
//begin
//  if Matrixshown then exit;;
//  inherited;
//end;

procedure TReturnAGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReturnAGUI.actCustomerContactsExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReturnAGUI.DNMSpeedButton1Click(Sender: TObject);
var
  POID:Integer;
begin
  inherited;
  DisableForm;
  try
    if not RAObj.Save then Exit;
    CommitAndNotify;
    BeginTransaction;

    if RAObj.count       = 0 then exit;
    if RAObj.lines.count = 0 then exit;

    if RAObj.CreditRef <> '' then begin
      MessageDlgXP_Vista(edtCreditMsg.caption+'.' +chr(13)+chr(13)+'Another Credit Cannot be Createed.' , mtInformation , [mbok] , 0) ;
      Exit;
    end;
        //if MessageDlgXP_Vista(edtCreditMsg.caption+'.' +chr(13)+chr(13)+'Do You Wish To Create Another Credit?' , mtConfirmation , [mbyes,mbno] , 0) = mrno then Exit;


    POID:= RAObj.ConvertTopo;
    if POID <> 0 then begin
      OpenERPForm('TPurchaseGUI' , POID);
      NewAuditTrialentry('Purchase Order Created');
    end else if RAObj.ObjInstanceToClone.ResultStatus.getLastFatalStatusItem<> nil then
      MessageDlgXP_Vista('Negative Purchase Order Creation Failed.' + chr(13) +RAObj.ObjInstanceToClone.ResultStatus.getLastFatalStatusItem.Message , mtWarning, [mbok] , 0)
    else MessageDlgXP_Vista('Negative Purchase Order Creation Failed.' , mtWarning, [mbok] , 0);
    RAObj.Dirty := False;
    Self.Close;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;

end;
Procedure TReturnAGUI.DoOnProductchange;
begin
  if Matrixshown then exit;
  inherited;
end;
procedure TReturnAGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited DoBusinessObjectEvent(Sender,EventType, Value);
{-->}   if ((Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_IDChanged) and (RAobj.ID > 0)) Or
            ((Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) and (RAobj.ID > 0))  then begin
          if RAobj.CreditRef = '' then edtCreditMsg.Caption := ''
          else begin
            edtCreditMsg.Caption := 'Credit (Negative PO) Already Created. Ref : ' + RAobj.CreditRef;
            DNMSpeedButton1.Enabled := False;
          end;
{-->}   end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_ProductChanged) then begin
          DoOnProductchange;
        end;
end;


procedure TReturnAGUI.edtCreditMsgDblClick(Sender: TObject);
var
  POID:Integer;
begin
  inherited;
  POID :=  TPurchaseOrder.IDToggle(RAobj.CreditRef);
  if POID = 0 then exit;

  DisableForm;
  try
    if not RAObj.Save then Exit;
    RAObj.Dirty := False;
    CommitAndNotify;
    OpenERPForm('TPurchaseGUI' , POID);
    Self.Close;
  finally
    EnableForm;
    RAObj.ResultStatus.Clear;
  end;

end;

function TReturnAGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
var
  f: file;
  (*RecipientAddress, *)ReportType, OutGoingFileName: string;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  qryEmailedList: TERPQuery;
  intResult: integer;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  Recipients: string;
begin
    result := False;
    DisableForm;
    try
      //RecipientAddress := '';
      ReportType := '';
      OutGoingFileName := '';
      if not RAObj.Save then Exit;
      CommitAndNotify;
      try
        Recipients := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger, 'MainContactForRA');
        if RecipientAddress <> '' then
          Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

        if Recipients = '' then begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('SupplierName').AsString +
            ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
            'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
          ASilent := false;
        end;

        ReportType := 'Return Authority';
        // String defined here because it is easy to change when this code is applied to
        // other forms. (ie, Quote instead of Invoice etc)

        // Ask the user if they want to specify a new subject
        intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
          tblMaster.FieldByName('SupplierName').AsString + '.' + #13 + #10 + #13 + #10 +
          'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
          'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
          [mbYes, mbNo, mbCancel], 0);

        if intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
            ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString +
            ' for ' + tblMaster.FieldByName('SupplierName').AsString);
        end else if intResult = mrNo then begin
          strResult := '';
        end else begin
          Exit;
        end;

        try
          lblEmail.Visible := true;
          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

          LoadTemplate(true, true);

          Corres := TCorrespondenceGui.Create;
          try
            Corres.Subject :=
              ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString +
              ' for ' + tblMaster.FieldByName('SupplierName').AsString;

            // Corres.RecipientList := RecipientAddress;
            Corres.RecipientList := Recipients;
            Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

            OutGoingFileName := //GetCompanyName + ' ' + ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString +'.PDF';
                                getOutGoingFileName('',' ' + ReportType + ' #' + tblMaster.FieldByName('PurchaseOrderNumber').AsString, '.PDF');
            AssignFile(f,  Commonlib.TempDir  + 'EmailReport.PDF');

            if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
              copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                PChar( Commonlib.TempDir  + OutGoingFileName), false);
            end;

            Corres.AttachmentList.Add( Commonlib.TempDir  + OutGoingFileName);
            ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(REportToPrint));
            if ASilent and not EmailShortSendMode(ASilent, ASecret) then
              exit;
            if Corres.Execute(ASilent, ASecret) then begin
              result:=True;
              TransactionID := tblMaster.FieldByName('PurchaseOrderNumber').AsString;
              UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
              EmailDate := Now;

              // ReportType already defined at start of procedure
              TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
                tblMaster.FieldByName('PurchaseOrderNumber').AsString + ' for ' + tblMaster.FieldByName('SupplierName').AsString;

              qryEmailedList := TERPQuery.Create(nil);
              qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
              try
                qryEmailedList.Sql.Clear;
                qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
                  TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
                  EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
                  '")');
                qryEmailedList.Execute;

              finally
                FreeAndNil(qryEmailedList);
              end;
            end;

            DeleteFiles( Commonlib.TempDir , '*.PDF');
            DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
            lblEmail.Visible := false;

          finally
            Corres.Free;
          end;
        except
          lblEmail.Visible := false;
          CommonLib.MessageDlgXP_Vista('There was an error sending email', mtInformation , [mbOK], 0);
        end;
      finally
        LogEmailed(result, ReportType);
        self.BeginTransaction;
        ReportToPrint := '';
      end;

    finally
      RAObj.ResultStatus.Clear;
      EnableForm;
    end;
end;

initialization
  RegisterClassOnce(TReturnAGUI);
  with FormFact do begin
    RegisterMe(TReturnAGUI, 'TReturnAuthListGUI_*=PurchaseOrderID');
    RegisterMe(TReturnAGUI,'TTransAccountDetailsGUI_*_Return Authority=PurchaseOrderID');
    RegisterMe(TReturnAGUI,'TSupplierReportGUI_*_Return Authority=PurchaseOrderID');
    RegisterMe(TReturnAGUI, 'TMemTransListGUI_*_TReturnAGUI=TransID');
    RegisterMe(TReturnAGUI,'TSupplierProductReportGUI_*_Return Authority=PurchaseOrderID');
    RegisterMe(TReturnAGUI,'TEmailedReportsList_*_Return Authority=Transaction');
    RegisterMe(TReturnAGUI,'TFaxSpoolListingGUI_TransGlobal_Return Authority=TransGlobal');
    RegisterMe(TReturnAGUI,'TFaxSpoolListingGUI_TransType_Return Authority=TransGlobal');
    RegisterMe(TReturnAGUI,'TSupplierStatementGUI_*_Return Authority=PurchaseOrderID');
    RegisterMe(TReturnAGUI, 'TAllTransactionGUI_*_Return Authority=TransNo');
    RegisterMe(TReturnAGUI, 'TBillsnCheque_LinesDeletedGUI_*_RA=PurchaseOrderId');
    RegisterMe(TReturnAGUI, 'TNumberSequenceListGUI_*_Return Authority=PurchaseOrderID');
    RegisterMe(TReturnAGUI, 'TGlobalsearchGUI_*_RA=PurchaseOrderID');
    RegisterMe(TReturnAGUI, 'TNonERPPOListGUI_*_Return Authority=ERPTransId');
  end;
end.


