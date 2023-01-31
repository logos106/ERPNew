unit frmBill;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/07/05  1.00.01 DSP  Added functionality to recall last account name used
                        after a supplier is selected.
 11/10/05  1.00.02 AL   Moved some controls to make a better look
 19/10/05  1.00.03 DLS  Added RegisterClass
 06/04/06  1.00.04 AL   Added call of AddToPayAuthorisations on Save
 10/04/06  1.00.05 DSP  Added customise grid option.
 15/08/06  1.00.06 BJ   isok_to_Print returns true if the form is in readonly state

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Expenses, DB,  StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker,
  wwdblook, DBCtrls, Mask, ExtCtrls, BaseInputForm, DNMPanel, Wwdbigrd, Grids,
  Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, DMComps, wwdbedit, Shader, busobjExpenses, busobjbase,
  ProgressDialog, ERPDbLookupCombo, DNMAction;

type
  TBillGUI = class(TBaseExpenseGUI)
    Label2: TLabel;
    edtBillTotal: TEdit;
    tblMasterApproved: TWideStringField;
    tblDetailsRelatedShipContainerID: TIntegerField;
    qryShipContainerLookup: TERPQuery;
    qryShipContainerLookupContainerName: TWideStringField;
    qryShipContainerLookupShippingContainerID: TIntegerField;
    tblDetailsShipContainerName: TWideStringField;
    Shape1: TShape;
    Shape2: TShape;
    Label3: TLabel;
    txtInvoiceNumber: TDBEdit;
    pnlApprover: TDNMPanel;
    lblApprover: TLabel;
    cboApprover: TwwDBLookupCombo;
    chkSendEmail: TwwCheckBox;
    qryApproverLookup: TERPQuery;
    tblMasterApproverID: TIntegerField;
    chkApproved: TwwCheckBox;
    cboRelatedShipContainerID: TwwDBLookupCombo;
    cboRelShipContainer: TERPDbLookupCombo;
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure edtBillTotalExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtInvNumberExit(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboRelatedPOIDNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure cboCreationDateCloseUp(Sender: TObject);
    procedure tblDetailsAfterInsert(DataSet: TDataSet);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblDetailsBeforeScroll(DataSet: TDataSet);
    procedure tblDetailsBeforeCancel(DataSet: TDataSet);
    procedure tblDetailsBeforeInsert(DataSet: TDataSet);
    procedure tblDetailsBeforeEdit(DataSet: TDataSet);
    procedure tblDetailsAfterEdit(DataSet: TDataSet);
    procedure tblDetailsAfterPost(DataSet: TDataSet);
    procedure tblDetailsAfterScroll(DataSet: TDataSet);
    procedure tblDetailsAfterCancel(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure grdTransactionsColEnter(Sender: TObject);
    procedure chkApprovedClick(Sender: TObject);
    procedure btnfixClick(Sender: TObject);
    procedure cboRelShipContainerNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
  private
    fbShowingOrClosing: Boolean;
    (*AccountNames :TStringList;*)
    fiRepairID: Integer;
    fsArea:String;
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    (*Procedure CallbackAccountname(Const Sender: TBusObj; var Abort: boolean);*)
    function SaveBill:boolean;
    function ValidateforRepair: Boolean;
    procedure updaterepair;
    function SendPrintEmailSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintSMS: boolean;
  protected
    BillObj :TBill;
    function GetReportTypeID: integer; override;
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer; override;
    procedure AfterCommit;Override;
    procedure CommitAndNotify;override;
    function TransStatustype:String ;override;
    procedure NewTransBusObjinstance;override;
    procedure beforeOnComboNotInList(Sender: TObject);override;
    Procedure NewTransBusObjRecord(aId: integer = 0); override;
    function SaveTrans:Boolean ; Override;
    function EmailTransaction(const RecipientAddress: String =''; ASilent: boolean=True; ASecret: boolean = True): boolean; override;
    function Save4NewTrans: Boolean;Override;
  public
    { Public declarations }
    class procedure CloseMe; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    procedure PopulateMessageSubstituteList(SL: TStringList);override;
    Property RepairID : Integer read fiRepairID write fiRepairID;
    Property Area :String read fsArea    write fsArea;
  end;

implementation

uses
  FormFactory,  DNMLib, DNMExceptions,
  BaseTransForm, Commonlib,  AppEnvironment,
  FastFuncs, tcDataUtils, BusObjConst, tcTypes, BusObjRepairs,
  tcconst, frmReportingOptions, EmailUtils, SMSUtils,
  TimedHint, CorrespondenceObj, BusObjApprovals, ApprovalNotificationLib,
  LookupcomboLib, CommonDbLib, MySQLConst, BusObjGLAccount;

{$R *.dfm}
procedure   TBillGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) then begin
    if (Value = BusObjEventVal_Approved) then begin

    end
    else if (Value = BusObjEvent_OnCalcOrderTotals) then begin
      if AppEnv.CompanyPrefs.UseApprovalLevels then begin
        //qryApproverLookup.ParamByName('ApprovalType').AsString := ApprovalTypeBill;
        qryApproverLookup.ParamByName('OrderTotal').AsFloat := BillObj.TotalAmountInc;
        qryApproverLookup.Refresh;
        if BillObj.ApproverID > 0 then begin
          qryApproverLookup.Locate('EmployeeID',BillObj.ApproverID,[]);
          cboApprover.Text := qryApproverLookup.FieldByName('EmployeeName').AsString;
        end;
      end;
    end;
  end;
end;

function TBillGUI.InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
begin
    Result := mrNo;
    if CommonLib.MessageDlgXP_Vista(msg, Dlgtype, Buttons, 0) = mrYes then begin
        edtBillTotal.Text := FloatToStrF(BillObj.TotalAmountInc,ffCurrency, 15, CurrencyRoundPlaces);
        BillObj.Billtotal :=BillObj.TotalAmountInc;
        result := mrYes;
    end;
end;

procedure TBillGUI.NewTransBusObjinstance;
begin
  Freeandnil(Billobj);
  Billobj := TBill.Create(Self);
  Billobj.Name:= 'Billobj';
  ExpenseBase := Billobj;
  inherited;
end;

procedure TBillGUI.NewTransBusObjRecord(aId: integer);
begin
  inherited;
  edtBillTotal.Text := FloatToStrF(billObj.TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TBillGUI.PopulateMessageSubstituteList(SL: TStringList);
begin
  inherited;

end;

function TBillGUI.TransStatustype: String;
begin
  REsult:= SimpleTypes_Bill;
end;

procedure TBillGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    billObj.BillTotal   := Round(StrValue(edtBillTotal.Text) , (*billObj.RoundPlacesGeneral*)CurrencyRoundPlaces);
    if SaveBill then begin
      inherited;
      CommitAndNotify;
      if AppEnv.CompanyPrefs.UseApprovalLevels then begin
        if chkSendEmail.Checked and (BillObj.ApproverID > 0) then begin
          TApprovalNotification.Notify(self);
        end;
      end;
      Self.close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TBillGUI.btnfixClick(Sender: TObject);
begin
  if billObj.DoRoundFix then exit;
  inherited;
end;

procedure TBillGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  fbShowingOrClosing := True;
end;

procedure TBillGUI.FormShow(Sender: TObject);
begin
  stepProgressbar;
  try
    GuiPrefs.DbGridElement[grdTransactions].RemoveFields('SortId');
    GuiPrefs.DbGridElement[grdTransactions].RemoveFields('LinesOrder');

    DisableForm;
    try
      try
        try
          fbShowingOrClosing := True;
          inherited;
          BillObj.Lines.Dataset.Filter := BillObj.TranslineFilter(False);
          BillObj.Lines.Dataset.Filtered:= true;
          (*if not AppEnv.CompanyPrefs.DisplayPurhcasesExPrice then begin
            with grdTransactions do begin
              SetActiveField('LineCost');
              AddField('LineCostInc', grdTransactions.GetActiveCol, false);
              RemoveField('LineCost');
              ColumnByName('LineCostInc').DisplayLabel := 'Amount (Inc)';
  //            ColumnByName('LineCostInc').DisplayWidth := 10;
            end;
          end;*)

          DMTextTargetExpense.AcceptorControl := nil;
          DMTextTargetExpense.AcceptorControl := txtComments;

          pnlApprover.Visible :=  AppEnv.CompanyPrefs.UseApprovalLevels;
          if AppEnv.CompanyPrefs.UseApprovalLevels then
            DoBusinessObjectEvent(BillObj, BusObjEvent_Change, BusObjEvent_OnCalcOrderTotals);

        finally
          If tblMaster.Active then
            edtBillTotal.Text := FloatToStrF(billObj.TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
          fbShowingOrClosing := False;
        end;
      except
        on EAbort do HandleEAbortException;
        on E: ENoAccess do HandleNoAccessException(e);
        else raise;
      end;
    finally
      EnableForm;
    end;
  finally
    Enabledisable;
    hideProgressbar;
    SetControlFocus(cboClientR);
  end;
end;

procedure TBillGUI.edtBillTotalExit(Sender: TObject);
begin
  inherited;
  edtBillTotal.Text := FloatToStrF(StrValue(edtBillTotal.Text), ffCurrency, 15, CurrencyRoundPlaces);
end;

function TBillGUI.EmailTransaction(const RecipientAddress: String; ASilent,
  ASecret: boolean): boolean;
Var
  f: File;
  ReportType, OutGoingFileName: String;
  TransactionID, UserID, TransactionDescription: String;
  EmailDate: TDateTime; qryEmailedList: TERPQuery; intResult: Integer;
  strResult: String;
//  XMLEmailObj :TXMLEmailObj;
//  sXMLAddress:String;

//  ftp: TIdFTP;
  stream: TMemoryStream;
//  url: TURLObj;
  fileName: string;
//  StringStream: TStringStream;
  ReportAttachmentfiles: String;
  Corres: TCorrespondenceGui;
  Recipients : string;
Begin
  result:= False;
//  if chkChooseRpt.checked = False then
//    ReportToPrint := tcDataUtils.GetTemplate(BillObj.Supplier.Default POTemplateID);
  DisableForm;
  Try
    If Not SaveBill then Exit;
    Try


//      if PO.Supplier.SendXMLPOs then begin
//        XMLEmailObj := TXMLEmailObj.Create;       //Send XML email
//        try
//          sXMLAddress := ClientPOXMLEmail(PO.Supplierid );
//          if sXMLAddress <> '' then begin
//            ReportType := 'Purchase Order';
//            intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this XML ' + ReportType + ' to ' +
//            sXMLAddress + '.' + #13 + #10 + #13 + #10 +
//            'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
//            'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
//            [mbYes, mbNo, mbCancel], 0);
//
//            if intResult = mrYes then begin
//              strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
//                ReportType + ' #' + PO.DocNumber +
//                ' for ' + PO.SupplierName);
//            end else if intResult = mrNo then begin
//              strResult := 'XML PurchaseOrder';
//            end else begin
//              Exit;
//            end;
//
//            { use XMLDoc.SaveToStream to force inclusion of "encoding" .. PO.XML removes encoding for default UTF-8 }
//            StringStream := TStringStream.Create;
//            try
//              PO.XMLDoc.SaveToStream(StringStream);
//              StringStream.Position := 0;
//              XMLEmailObj.SendEmail(getEmailFrom, sXMLAddress,StringStream.DataString,strResult,'PurchaseOrder XML in attached file',0,PO.SupplierId);
//            finally
//              StringStream.Free;
//            end;
//          end;
//        finally
//          FreeAndNil(XMLEmailObj);
//          strResult := '';
//        end;
//      end;
//
//      if PO.Supplier.SendFTPXMLPOs then begin
//        ftp := TIdFTP.Create(nil);
//        stream := TMemoryStream.Create;
//        url := TURLObj.Create(PO.Supplier.FTPAddress);
//        try
//          ftp.Host := url.Host;  //PO.Supplier.FTPAddress;
//          ftp.Username := PO.Supplier.FTPUserName;
//          ftp.Password := PO.Supplier.FTPPassword;
//          PO.XMLDoc.SaveToStream(stream);
//          stream.Position := 0;
//          try
//            fileNAme := url.Path;
//            if (fileName <> '') and (copy(fileName,Length(fileName),1) <> '/') then
//              fileName := fileName + '/';
//            fileName := fileName + 'TrueERP_PO_' + IntToStr(PO.ID) + '.xml';
//            ftp.Connect;
//            ftp.Put(stream,fileName);
//            ftp.Disconnect;
//          except
//            on e: exception do begin
//              CommonLib.MessageDlgXP_Vista('Error sending XML PO to FTP site: ' + e.Message,mtWarning,[mbOK],0);
//            end;
//          end;
//        finally
//          ftp.Free;
//          stream.Free;
//          url.Free;
//        end;
//      end;


      Corres := TCorrespondenceGui.Create;
      try
        // Clear all previous params/data
        //RecipientAddress := '';
        ReportType       := '';
        OutGoingFileName := '';

        Recipients := GetContactEmails(BillObj.ClientId, 'MainContactForBill');
        if RecipientAddress <> '' then
          Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

        //If RecipientAddress = '' then // no recipient address
        if Recipients = '' then
        begin
         If CommonLib.MessageDlgXP_Vista(BillObj.SupplierName + ' does not have an email address.' + #13 + #10 +
           'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
          ASilent := false;
        end;

        ReportType := 'Bill';

        // Ask the user if they want to specify a new subject
        intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' + BillObj.SupplierName + '.' + chr(13) + chr(13) + 'Would you like to specify a subject for this email?'
            + chr(13) + chr(13) + 'Please select ''Yes'' to enter new email subject line or ''No'' to use standard subject line.', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

        If intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email', ReportType + ' #' + BillObj.DocNumber + ' for ' +
              BillObj.SupplierName);
        End
        Else If intResult = mrNo then begin
          strResult := '';
        End Else Begin
          Exit;
        End;

        Try
          lblEmail.Visible    := true;
          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

//          GroupReportByClass := GroupProducts.Checked;

          LoadTemplate(true, true);
          OutGoingFileName := getOutGoingFileName('', ' ' + ReportType + ' #' + BillObj.DocNumber, '.PDF');
          assignfile(f, CommonLib.TempDir + 'EmailReport.PDF');
          if not FileExists(Commonlib.TempDir +  'EmailReport.PDF') then begin
            CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
            Exit;
          end;
          Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'), PChar(Commonlib.TempDir  + OutGoingFileName), false);


          If strResult <> '' Then
            // Our new specified subject.
              Corres.Subject := strResult
          Else
            // Default Subject / Pre set
              Corres.Subject := ReportType + ' #' + BillObj.DocNumber + ' for ' + BillObj.SupplierName;

          //Corres.RecipientList := RecipientAddress;
          Corres.RecipientList := Recipients;

          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
          Corres.SupplierId := BillObj.SupplierId;

          Corres.AttachmentList.Add(CommonLib.TempDir + OutGoingFileName);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(REportToPrint));

(*          if ASilent then
            if not EmailShortSendMode(ASilent, ASecret) then
              exit;*)

          if Corres.Execute(ASilent, ASecret) then begin
            result := true;

            TransactionID := BillObj.DocNumber;
            UserID        := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
            EmailDate     := Now;

            // ReportType already defined at start of procedure
            TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + BillObj.DocNumber + ' for ' + BillObj.SupplierName;

            qryEmailedList            := TERPQuery.Create(Nil);
            qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;

            Try
              qryEmailedList.SQL.Clear;
              qryEmailedList.SQL.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,');
              qryEmailedList.SQL.Add(' TransactionDescription,ContactID,EmailAddressUsed) Values ("' + TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' +
                  ReportType + '", "' + TransactionDescription + '", "' + IntToStr(EmailContactID) + '", "' + RecipientAddress + '")');
              qryEmailedList.Execute;
            Finally
              If assigned(qryEmailedList) then FreeAndNil(qryEmailedList);
            End;
          end;

          DeleteFiles(CommonLib.TempDir, '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);

          lblEmail.Visible := False;

        Except
          On e: Exception Do Begin
            lblEmail.Visible := False;
            CommonLib.MessageDlgXP_Vista('There was an error sending email : ' + e.message, mtWarning, [mbOk], 0);
          End;
        End;
      finally
        Corres.Free;
      end;
    Finally
      LogEmailed(result , ReportToPrint);
      ReportToPrint:= '';
      Self.BeginTransaction;
    End;
  Finally EnableForm;
  End;
end;

function TBillGUI.GetReportTypeID: integer;
begin
  Result := 5;
end;

procedure TBillGUI.grdTransactionsColEnter(Sender: TObject);
begin
  inherited;
  if SameText(grdTransactions.GetActiveField.fieldname ,tblDetailsRelatedPOID.FieldName) then
    //ShowTimedHint(grdTransactions,cboRelatedShipContainerID.Hint , false, 5000 , grdtransactions.Width-4, 0 , Self.color, clred);
    //ShowTimedHint(grdtransactions, 'List of all Foreign Purchase orders which is  not assigned to any bill yet' , false, 5000 , grdtransactions.Width-4, 0 , Self.color, clred);
    TransTimerMsg(cboRelatedPOID.Hint);

end;

procedure TBillGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if SaveBill then begin
      Self.CommitAndNotify;
      try
        inherited;
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
  end;
end;

procedure TBillGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    billObj.BillTotal   := Round(StrValue(edtBillTotal.Text) , (*billObj.RoundPlacesGeneral*)CurrencyRoundPlaces);
    if SaveBill then begin
      Self.CommitAndNotify;
      try
        inherited;
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
  end;
end;

procedure TBillGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
    if ErrorOccurred then Exit;

    CanClose := false;
    if BillObj.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes:begin
                if SaveBill then begin
                    CommitAndNotify;
                    CanClose := true;
                end;
            end;
            mrNo: begin
                RollbackTransaction;
                BillObj.Dirty := false;
                CanClose := true;
                Notify(true);
            end;
            mrCancel:begin
                CanClose := false;
                btnClose.Enabled := True;
            end;
        end;
    end else begin
        CanClose := true;
        Notify(false);
    end;
end;

procedure TBillGUI.tblDetailsAfterCancel(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsAfterCancel');
end;

procedure TBillGUI.tblDetailsAfterEdit(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsAfterEdit');
end;

procedure TBillGUI.tblDetailsAfterInsert(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsAfterInsert');
  tbldetailsrepairID.asInteger := fiRepairID;
end;

procedure TBillGUI.tblDetailsAfterPost(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsAfterPost');
end;

procedure TBillGUI.tblDetailsAfterScroll(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsAfterScroll');
end;

procedure TBillGUI.tblDetailsBeforeCancel(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsBeforeCancel');
end;

procedure TBillGUI.tblDetailsBeforeEdit(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsBeforeEdit');
end;

procedure TBillGUI.tblDetailsBeforeInsert(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsBeforeInsert');
end;

procedure TBillGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsBeforePost');
end;

procedure TBillGUI.tblDetailsBeforeScroll(DataSet: TDataSet);
begin
  inherited;
//  TLogger.Inst.Log('TBillGUI.tblDetailsBeforeScroll');
end;

procedure TBillGUI.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tblMasterArea.asString  := fsArea;
end;

procedure TBillGUI.txtInvNumberExit(Sender: TObject);
begin
    BillObj.ISInvNoUnique;
end;

class procedure TBillGUI.CloseMe;
begin
  inherited;
  if FormStillOpen('TBillGUI') then begin
      TBillGUI(FindExistingComponent('TBillGUI')).Close;
    Application.ProcessMessages;
  end;
end;

procedure TBillGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
begin
  if Cancelled then Exit;
    (*if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboAccountlineX') or
         Sysutils.SameText(fLastComboAccessed.Name, 'cboClientR') then begin
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
      end;
    end;
    end;*)
  if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then begin
    if Sysutils.SameText(fLastComboAccessed.Name, 'cboAccountlineX') then begin
      SearchIDnUpdateName(fLastComboAccessed, 'AccountID' , TBaseInputGUI(aObject).KeyID  , tbldetails, 'AccountNumber' ,'AccountNumber');
    end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboTaxCode') then begin
      SearchIDnUpdateName(fLastComboAccessed, 'TaxCodeID' , TBaseInputGUI(aObject).KeyID  , tbldetails, 'linetaxcode' ,'Taxcode');
    end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboClientR') then begin
      if SearchIDnUpdateName(fLastComboAccessed, 'ClientID' , TBaseInputGUI(aObject).KeyID  , tblMaster, 'SupplierName' ,'Company') then
        DoOnClientchange;
    end;
  end;
  inherited UpdateMe(cancelled, aObject);
end;


procedure TBillGUI.FormCreate(Sender: TObject);
begin
  fiRepairID:= 0;
  fsArea :='';
  AllowCustomiseGrid    := True;
  inherited;
  fLastComboAccessed := nil;
  //chkApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;
  //TransApprovalInit(chkApproved ,  ApprovalTypeBill , BillObj, 'TotalAmountInc',true);
    TransApprovalInit(chkApproved ,  BillObj.Approvaltype , BillObj, 'TotalAmountInc',true , cboApprover,lblApprover,chkSendEmail);
  ApproverCombo.ApproverLookupQrySQL(cboApprover , ApprovalTypeBill);
  cboRelShipContainer.SpcialLookupItemList.Clear;
end;

procedure TBillGUI.FormResize(Sender: TObject);
begin
  inherited;
  if Assigned(grdTransactions.SelectedField) and SameText(grdTransactions.SelectedField.FieldName,'Product_Description') and
    (grdTransactions.DataSource.DataSet.State in [dsInsert,dsEdit]) then begin
    try
      grdTransactions.DataSource.DataSet.Post;
    except
    end;
  end;
end;

procedure TBillGUI.CompleteComboNotInList(const aObserver: TObject);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
  InComboNotinList := False;
end;
Function TBillGUI.ValidateforRepair:Boolean;
begin
  result := True;
  if repairID = 0 then exit;
  With BillObj.getnewDataset('Select purchaseLineId from tblPurchaseLines where ifnull(repairID,0) <> ' +inttostr(REpairID) +' and PurchaseOrderId = ' + inttostr(BillObj.ID) , true) do try
    if recordcount > 0 then
      if MessageDlgXP_Vista('This Bill was Created for Repair #' + inttostr(RepairID)+'.  There are Lines not Linked to this Repair.' +chr(13) +'Do You Wish To Save it as it is?' , mtconfirmation , [mbyes,mbno],0 ) = mrno then result := False;
  finally
    if active then close;
    Free;
  end;
end;
Procedure TBillGUI.updaterepair;
var
  Repairs :TRepairs;
  fdRepairTotal:Double;
begin
  if RepairID =0 then exit;
  if not Userlock.Lock(TRepairs.GetBusObjectTablename, RepairID , BillObj.LockGroupName) then exit;
  try
     Repairs := TRepairs.create(BillObj);
     try
       Repairs.connection :=BillObj.connection;
       Repairs.Load( RepairID);
       if Repairs.count =0 then exit;
       fdRepairTotal :=BillObj.RepairTotal(repairID);
       if Repairs.BilltotalPrice <fdRepairTotal then begin
        Repairs.BilltotalPrice := fdRepairTotal;
        Repairs.PostDB;
       end;
     finally
       Freeandnil(Repairs);
     end;
  finally
    Userlock.UnLock(TRepairs.GetBusObjectTablename, RepairID , BillObj.LockGroupName);
  end;
end;
function TBillGUI.SaveBill: boolean;
begin
   result:= true;
   if accesslevel = 5 then begin
      BillObj.CancelDb;
      exit;
   end;
   REsult := billObj.Save;
   if result then begin
      result := ValidateforRepair;
   end;
   BillObj.ResultStatus.Clear;
end;

function TBillGUI.SaveTrans: Boolean;
begin
  result := SaveBill;
end;

function TBillGUI.SendPrintEmail: boolean;
var
  msgTo: string;
begin
  msgTo := GetContactEmails(self.tblMasterClientID.AsInteger, 'MainContactForBill');
  result := TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintEmailSubject, BillObj.PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintEmailText, BillObj.PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, false, false)
end;

function TBillGUI.SendPrintEmailSilent: boolean;
var
  msgTo: string;
begin
  msgTo := GetContactEmails(self.tblMasterClientID.AsInteger, 'MainContactForBill');
  result := TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintEmailSubject, BillObj.PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintEmailText, BillObj.PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, false, false);
end;

function TBillGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSSupplier(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintSMSText, BillObj.PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TBillGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := BillObj.ContactMobile;
  if toMobile = '' then
    toMobile := BillObj.Supplier.Mobile;

  result := TCorrespondenceGui.SMSSupplier(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.BillPrintSMSText, BillObj.PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;


procedure TBillGUI.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
end;

procedure TBillGUI.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit;
  Notify;
end;
procedure TBillGUI.AfterCommit;
begin
  inherited AfterCommit;
  Updaterepair;
end;

function TBillGUI.Save4NewTrans: Boolean;
begin
  Result := False;

  DisableForm;
  try
    billObj.BillTotal   := Round(StrValue(edtBillTotal.Text) , (*billObj.RoundPlacesGeneral*)CurrencyRoundPlaces);
    if BillObj.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes   : if SaveBill then begin
              CommitAndNotify;  // current record should be commited before inserting new reocrd
              result := True;
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

procedure TBillGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    billObj.BillTotal   := Round(StrValue(edtBillTotal.Text) , (*billObj.RoundPlacesGeneral*)CurrencyRoundPlaces);
    if SaveBill then begin
      Self.CommitAndNotify;
      try
        inherited;
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
  end;

end;

procedure TBillGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
  Recipients: string;
begin
  if not Billobj.Save  then exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print a Bill',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Bill', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF Bill to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
//    OptsForm.ActionList.Add('Email Bill', 'Email a copy of the Bill', EmailBill, true, true);
    OptsForm.ActionList.Add('Email Bill', 'Email a copy of the Bill', DoEmailTransactionSilentnSecret, true, true);
    OptsForm.ActionList.Add('Email Bill (Edit)', 'Edit Email Message Before Sending, With a Copy of the Bill', DoEmailTransactionnonsilent, true, true);

    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Bill', self.SendPrintEmail, true, true);
    Recipients := GetContactEmails(self.tblMasterClientID.AsInteger, 'MainContactForBill');
    if Recipients <> ''  then begin
      OptsForm.ActionList.Add('Email Msg Silently', 'Send an email message silently, without Bill', self.SendPrintEmailSilent, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg Silently', 'Send an email message silently, without Bill', self.SendPrintEmailSilent, true, false);
    end;

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableBillPrintSMS and
       ((BillObj.ContactMobile <> '') or (BillObj.Supplier.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

procedure TBillGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBillGUI.cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBillGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBillGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBillGUI.cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;


procedure TBillGUI.chkApprovedClick(Sender: TObject);
begin
  inherited;
(*  if TwwCheckBox(Sender).Focused then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsBoolean := TwwCheckBox(Sender).Checked;*)
end;

procedure TBillGUI.cboRelatedPOIDNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  if NewValue = '' then begin
    tblDetails.FieldByName('RelatedPOID').AsInteger := 0;
  end;
end;

procedure TBillGUI.cboRelShipContainerNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if NewValue = '' then begin
    tblDetails.FieldByName('RelatedShipContainerID').AsInteger := 0;
  end;
end;

procedure TBillGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBillGUI.beforeOnComboNotInList(Sender: TObject);
begin
  inherited;
end;

procedure TBillGUI.btnAttachmentsClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

(*procedure TBillGUI.CallbackAccountname(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (sender is TBillLines) then Exit;
  AccountNames.Add(TBillLines(Sender).AccountName);
end;*)

procedure TBillGUI.cboCreationDateCloseUp(Sender: TObject);
begin
  inherited;
  cboBaseForeignCurrencyCodeOrDateChange(Sender);
end;

initialization
  RegisterClassOnce(TBillGUI);
  with FormFact do begin
    RegisterMe(TBillGUI, 'TBankAccountListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TBillListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TCashProfitandLossGUI_*_Bill=TRansID');
    RegisterMe(TBillGUI, 'TBillDetailsListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TSupplierReportGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TTransAccountDetailsGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TAccountsPayListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TMemTransListGUI_*_TBillGUI=TransID');
    RegisterMe(TBillGUI, 'TApprovalListGUI_*_Bill=PurchaseORderID');
    RegisterMe(TBillGUI, 'TSupplierProductReportGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TBalTransListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TToBeReconciledGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TReconListDetailFormGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TTrialBalTransListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TTransactionListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TBASTransReturnListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TNZTransReturnListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TVATTransReturnListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TGlobalsearchGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TTransAccountDetailsGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TGeneralLedgerReportGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TUnpaidBillGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TJobProfitabilityGUI_*_Bill=SaleID');
    RegisterMe(TBillGUI, 'TJobProfitabilityforCustomerGUI_*_Bill=SaleID');
    RegisterMe(TBillGUI, 'TRepairProfitabilityGUI_*_Bill=SaleId');
    RegisterMe(TBillGUI, 'TSupplierStatementGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TCashBasisDetailsGUI_TransType_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TAccountsPayableNotes_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TExpenseClaimListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TApprovalReminderListGUI_*_Bill=PurchaseOrderID');
    (*RegisterMe(TBillGUI, 'TRemindersListGUI_*_Bill=ID');*)
    RegisterMe(TBillGUI, 'TReminderListGUI_*_Bill=ID');
    RegisterMe(TBillGUI, 'TAllTransactionGUI_*_Bill=TransNo');
    RegisterMe(TBillGUI, 'TMemTransListGUI_*_Bill=TransID');
    RegisterMe(TBillGUI, 'TBillsnCheque_LinesDeletedGUI_*_Bill=PurchaseOrderId');
    RegisterMe(TBillGUI, 'TNumberSequenceListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TPnLEmployeereportGUI_*_Bill=TransID');
    RegisterMe(TBillGUI, 'TExpenseClaimListGUI_*_Bill=PurchaseOrderID');
    RegisterMe(TBillGUI, 'TImportCostGUI_*_Bill=PurchaseOrderId');
    RegisterMe(TBillGUI, 'TNonERPPOListGUI_*_Bill=ERPTransId');
  end;
end.

