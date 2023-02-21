unit frmCheque;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/06/05  1.00.01 BJ   Property SilentMode is introduced. When the form is called
                        from the memorised transaction to post the cheques, the
                        property will have Value 'True'. When it is True, the
                        'formshow' executes 'CreateMemTrans' and closes the form
                        CreateMemTrans needs the MemTransID and the dueDate,
                        Properties defined for both of them.
                        NOTE:
                        BtnSaveclick cannot be used for posting the memorised
                        records as it posts the message and all the posted
                        messages gets executed at the end. When there are multiple
                        records to be posted, the message gets posted at the end
                        of the loop, which posts only 1 record(the last one).
 18/07/05  1.00.02 DSP  Added functionality to recall last account name used
                        after a supplier is selected.
 30/09/05  1.00.03 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm) to replace
                        procedure removed from TransLockManagementObj.
 1/11/05   1.00.04 DLS  Added RegisterClass
 10/04/06  1.00.05 DSP  Added customise grid option.
 15/08/06  1.00.06 BJ   isok_to_Print returns true if the form is in readonly state

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Expenses, DB,   Math, BusObjBase,
  StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, Mask, DBCtrls, wwdbdatetimepicker,
  wwdblook, ExtCtrls, DNMPanel, Wwdbigrd,
  Grids, Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts,
  MemDS, DBAccess, MyAccess,ERPdbComponents, DataState, DMComps, wwdbedit, Shader, busobjExpenses,
  ProgressDialog, ERPDbLookupCombo, DNMAction;

type
  TfmCheque = class(TBaseExpenseGUI)
    Label2: TLabel;
    Label66: TLabel;
    txtInvoiceNumber: TDBEdit;
    edtChqTotal: TEdit;
    chkEFT: TwwCheckBox;
    btnReconciled: TDNMSpeedButton;
    Shape2: TShape;
    Shape1: TShape;
    btnAddfollowupnotedate: TDNMSpeedButton;
    btnAdddate: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    tblMasterIsRefundCheque: TWideStringField;
    tblMasterRefundGlobalref: TWideStringField;
    btnSignature: TDNMSpeedButton;
    actSignature: TAction;
    tblMasterSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    pnlContractorPayment: TDNMPanel;
    Label4: TLabel;
    chkContractorPayment: TwwCheckBox;
    tblMasterContractorPayment: TWideStringField;
    wwCreateRule: TwwCheckBox;
    ERPQWildCards: TERPQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtChqTotalExit(Sender: TObject);
    procedure OverrideAccessLevel(Sender: TObject);
    procedure txtSalesCommentsEnter(Sender: TObject);
    procedure txtSalesCommentsExit(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure chkEFTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnReconciledClick(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure cboCreationDateCloseUp(Sender: TObject);
    procedure txtCommentsExit(Sender: TObject);
    procedure cboAccountEnter(Sender: TObject);
    procedure cboClientREnter(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnAddfollowupnotedateClick(Sender: TObject);
    procedure btnAdddateClick(Sender: TObject);
    procedure actSignatureExecute(Sender: TObject);
    procedure actSignatureUpdate(Sender: TObject);
    procedure cboCreationDateEnter(Sender: TObject);
    procedure cboCreationDateExit(Sender: TObject);
    procedure cboBaseForeignCurrencyCodeOrDateChange(Sender: TObject);

  private
    { Private declarations }
    fbSilentMode: boolean;
    fbDueDate: TDateTime;
    fbMemTransID: integer;
    fGLAccountID: integer;
    fSupplierName: string;
    fAccountName : string;
    fChequeAmount: Currency;
    fNotes       : string;
    fPayDate     : TDateTime;
    IsReconciled:Boolean;
    fOnAfterShow: TNotifyEvent;
    SavedDirty: boolean;
    procedure PrintCheque(const bPrint: boolean);
    procedure PrintDocument(const bPrint: boolean);
    procedure LockIfREconciled(Sender: TObject);
    function ChequetoPrint:String;
    function Savecheque: Boolean;

  protected
    function GetReportTypeID: integer; override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    function InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer; override;
    procedure CommitAndNotify;override;
    function TransStatustype:String ;override;
    procedure NewTransBusObjinstance;override;
    function SaveTrans:Boolean ; Override;
    procedure SetUserLocking;Override;
    function Save4NewTrans: Boolean;Override;
  public
    ChequeObj :TCheque;
    {properties used for posting the memorised transaction Cheques.}
    property SilentMode: boolean read fbSilentMode write fbSilentMode;
    property DueDate: TDateTime read fbDueDate write fbDueDate;
    property MemTransID: integer read fbMemTransID write fbMemTransID;
    property GLAccountID: integer read fGLAccountID write fGLAccountID;
    property SupplierName: string read fSupplierName write fSupplierName;
    property AccountName: string read fAccountName write fAccountName;
    property ChequeAmount: currency read fChequeAmount write fChequeAmount;
    property Notes: string read fNotes write fNotes;
    property PayDate: TDateTime read fPayDate write fPayDate;
    property OnAfterShow: TNotifyEvent read fOnAfterShow write fOnAfterShow;
  end;

implementation

uses FastFuncs, BaseInputForm, DNMLib,  FormFactory,
      DNMExceptions, StrUtils,
       PaymentsLibGUI, CommonLib,
      AppEnvironment, tcTypes, BaseTransForm, BusObjConst, frmDelayMessageDlg,
  BusObjPrintDoc, chequeLib, tcconst, tcDataUtils, frmSignatureEdit, BusObjBankReconciliationRules;

{$R *.dfm}

procedure   TfmCheque.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) then begin
    if (Value = BusObjEventVal_EmptyAccount) then begin
      application.ProcessMessages;
      if grdTransactions.ColumnByName('AccountName') <> nil then
        grdTransactions.SetActiveField('AccountName')
      else if grdTransactions.ColumnByName('AccountNumber') <> nil then
        grdTransactions.SetActiveField('AccountNumber');
    end
    else if (Value = BusObjEventVal_AccountSameAsHeader) then begin
      DelayMessageDlg('Account can not be the same as the check header account', mtInformation, [mbOk], 0);
      if grdTransactions.ColumnByName('AccountName') <> nil then
        grdTransactions.SetActiveField('AccountName')
      else if grdTransactions.ColumnByName('AccountNumber') <> nil then
        grdTransactions.SetActiveField('AccountNumber');
    end;
  end;
end;

procedure TfmCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TfmCheque.btnCompletedClick(Sender: TObject);
var
  newRule: TBankReconciliationRules;
begin
  DisableForm;
  try
    if Savecheque then begin
      SupplierName := ChequeObj.SupplierName;
      inherited;
      if wwCreateRule.Checked then begin
        newRule := TBankReconciliationRules.CreateWithNewConn(nil);
        try
          newRule.LoadSelect('Payee= ' + QuotedStr(ChequeObj.SupplierName) + ' AND StatementDesc = ' + QuotedStr(ChequeObj.Lines.ProductDescription));
          if newRule.count = 0 then begin
            newRule.New;
            newRule.StatementDesc := ChequeObj.Lines.ProductDescription;
            newRule.Payee         := ChequeObj.SupplierName;
            newRule.Active        := True;
            newRule.Save;
          end;
        finally
          newRule.Free;
        end;
      end;
      CommitAndNotify;

      if fsModal in FormState then
        ModalResult := mrOK
      else
        CloseWait;
    end;
  finally
    ChequeObj.ResultStatus.Clear;
    EnableForm;
  end;
end;

function  TfmCheque.Savecheque:Boolean;
begin
    Result := False;
    if not ChequeObj.Dirty then begin
      result := true;
      exit;
    end;

    ChequeObj.AddtoEFT      := chkEFT.Checked;
    ChequeObj.Chequetotal   := Round(StrValue(edtChqTotal.Text) , CurrencyRoundPlaces);
    if IsReconciled then begin
      if ChequeObj.ValidateData then begin
        ChequeObj.PostDB;
        ChequeObj.Dirty:= False;
        Result := True;
      end;
    end else begin
      if ChequeObj.Save then begin
          Result := True;
      end;
    end;
end;

procedure TfmCheque.FormShow(Sender: TObject);
var
  iPos: integer;
begin
stepProgressbar;
try
  DisableForm;
  try
    try
      try
        inherited;
        wwCreateRule.Visible := AppEnv.CompanyPrefs.YodleeEnabled;
        grdTransactions.ColumnByName('LineTax').readonly := True;

        ChequeObj.Lines.Dataset.filter := ChequeObj.TranslineFilter(False);
        ChequeObj.Lines.Dataset.Filtered:= true;

        if GuiPrefs.Node['grdTransactions.GridFields'].AsString <> '' then begin
          if Pos('LineCostInc',GuiPrefs.Node['grdTransactions.GridFields'].AsString) > 0 then begin
            iPos := GetGridColumnIndex(grdTransactions, 'LineCost');
            grdTransactions.RemoveField('LineCost', true);
            grdTransactions.AddField('LineCostInc', iPos, true);
            grdTransactions.ColumnByName('LineCostInc').DisplayLabel := 'Amount (Inc)';
          end else begin
            iPos := GetGridColumnIndex(grdTransactions, 'LineCost');
            grdTransactions.RemoveField('LineCostInc', true);
            grdTransactions.AddField('LineCost', iPos, true);
            grdTransactions.ColumnByName('LineCost').DisplayLabel := 'Amount (Ex)';
          end;
        end else begin
          {default}
          iPos := GetGridColumnIndex(grdTransactions, 'LineCost');
          grdTransactions.RemoveField('LineCost', true);
          grdTransactions.AddField('LineCostInc', iPos, true);
          grdTransactions.ColumnByName('LineCostInc').DisplayLabel := 'Amount (Inc)';
          grdTransactions.ColumnByName('LineCostInc').DisplayWidth := 10;
        end;

        if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAddToEFT') <> 1 then begin
          //lblEFT.Visible := false;
          chkEFT.Visible := false;
        end
        else begin
          chkEFT.OnClick := nil;
          chkEFT.Checked := AppEnv.CompanyPrefs.PaymentsAddToEFT and (KeyID = 0);
          chkEFT.OnClick := chkEFTClick;
        end;
        IsReconciled:=(fbPaymentLock and (ftLockType in [ltOnHoldRec, ltReconciled]));
        btnReconciled.Visible := IsReconciled;
        btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

        GuiPrefs.DbGridElement[grdTransactions].RemoveFields('SortId');
        GuiPrefs.DbGridElement[grdTransactions].RemoveFields('LinesOrder');
        if not btnAddFollowUpNoteDate.Visible then
        begin
          btnSignature.Left := btnAttachments.Left;
          btnSignature.Top := btnAttachments.Top + btnAttachments.Height + 3;
        end;

        if (fGLAccountID > 0) and (KeyID = 0) then begin
          //btnNext.Enabled := False;
          ChequeObj.GLAccountId:= fGLAccountID;
        end;
        if ((fSupplierName <> '') and (KeyId = 0)) then begin
          ChequeObj.SupplierName := fSupplierName;
        end;

        if (fChequeAmount > 0) and (KeyID = 0) then begin
          ChequeObj.Lines.TotalLineAmountInc := fChequeAmount;
          ChequeObj.Lines.LineCostInc := fChequeAmount;
          ChequeObj.Lines.LineTaxTotal := 0;
        end;

        if ((fAccountName <> '') and (KeyId = 0)) then
          ChequeObj.Lines.AccountName := fAccountName;

        if ((fPayDate <> 0) and (KeyId = 0)) then
          ChequeObj.OrderDate := fPayDate;

        if ((fNotes <> '') and (KeyId = 0)) then begin
          ChequeObj.Lines.ProductDescription     := fNotes;
          ChequeObj.RefNo                        := fNotes;
        end;
      finally
          edtChqTotal.Text := FloatToStrF(ChequeObj.TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
      end;
      if Assigned(fOnAfterShow) then
        fOnAfterShow(Self);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
    SetControlFocus(cboClientR);
    Self.Repaint;
  end;
finally
  Enabledisable;
  HideProgressbar;
end;
end;

procedure TfmCheque.edtChqTotalExit(Sender: TObject);
begin
  inherited;
  edtChqTotal.Text := FloatToStrF(StrValue(edtChqTotal.Text), ffCurrency, 15, CurrencyRoundPlaces);
end;

function TfmCheque.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  try
    // If user does not have access to this form don't process any further
      ChequeObj.AddtoEFT      := chkEFT.Checked;
      ChequeObj.Chequetotal   := Round(StrValue(edtChqTotal.Text) , CurrencyRoundPlaces);
    if chequeobj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes   : if (ChequeObj.ValidateData and chequeobj.Save) then begin
          CommitAndNotify ;  // current record should be commited before inserting new reocrd
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

procedure TfmCheque.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if ChequeObj.ValidateData and chequeObj.Save then begin
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
    ChequeObj.ResultStatus.Clear;
  end;end;

procedure TfmCheque.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit;
  Notify;
  Notify(false);
end;

function TfmCheque.InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
begin
    Result := mrNo;
    if CommonLib.MessageDlgXP_Vista(msg, DlgType, Buttons, 0) = mrYes then begin
        edtChqTotal.Text := FloatToStrF(ChequeObj.TotalAmountInc,ffCurrency, 15, CurrencyRoundPlaces);
        ChequeObj.Chequetotal :=ChequeObj.TotalAmountInc;
        result := mrYes;
    end;
end;
function TfmCheque.GetReportTypeID: integer;
begin
  Result := 7;
end;

// Remove date / time if they are present.
function TfmCheque.TransStatustype: String;
begin
  result:= SimpleTypes_cheque;
end;

procedure TfmCheque.OverrideAccessLevel(Sender: TObject);
begin
  inherited;
  if accesslevel = 1 then begin
    chequeObj.EditDB;
    with txtComments do begin
      Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
      text := trim(text);
      Selstart := Length(Text);
      sellength := 0;

    end;
  end;
end;
procedure TfmCheque.txtCommentsExit(Sender: TObject);
begin
  inherited;
  chequeObj.EditDB;
  //txtComments.Text  := AddDateTime(lcdOnchequecomments,txtComments.Text , False);
  AddDateTime(lcdOnchequecomments,txtComments , False);
  RestoreOverridenAccessLevel(Sender);

end;
procedure TfmCheque.btnAddfollowupnotedateClick(Sender: TObject);
begin
  inherited;
  OverrideAccessLevel(Sender);
  if accesslevel > 2 then exit;
  //txtComments.Text  := AddDateTime(lcdOnLoganyway,txtComments.Text ,false);
  AddDateTime(lcdOnLoganyway,txtComments ,false);
  RestoreOverridenAccessLevel(Sender);
end;

procedure TfmCheque.txtSalesCommentsEnter(Sender: TObject);
begin
  inherited;
  if accesslevel = 1 then begin
    chequeObj.EditDB;
    with txtSalesComments do begin
      Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
      text := trim(text);
      Selstart := Length(Text);
      sellength := 0;

    end;
  end;
end;
procedure TfmCheque.btnAdddateClick(Sender: TObject);
begin
  inherited;
  if accesslevel > 2 then exit;
  chequeObj.EditDB;
  txtSalesComments.Text  := AddDateTime(lcdOnLoganyway,txtSalesComments.Text , False);
end;

procedure TfmCheque.txtSalesCommentsExit(Sender: TObject);
begin
  inherited;
    with txtSalesComments do Lines.Strings[Lines.Count - 1] := AddDateTime(lcdOnchequeInternalcomments, Lines.Strings[Lines.Count - 1]);
    chequeObj.PostDB;
end;

procedure TfmCheque.PrintCheque(const bPrint: boolean);
var
  sSQL:String;
begin
  sSQL:= chequeSQL(chequeObj.ID, ChequeObj.TotalAmountInc);
  fbReportSQLSupplied := true;
  ReportToPrint := ChequetoPrint;
  if ReportToPrint = '' then begin
    MessageDlgXP_vista('Please select a template to print.', mtWarning, [mbOK], 0);
    Exit;
  end;
  PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1);
  fbReportSQLSupplied := false;  // change back for any other reports
end;

procedure TfmCheque.PrintDocument(const bPrint: boolean);
begin
  DisableForm;
  try
    if ChequeObj.ValidateData and chequeObj.Save then begin
      Self.CommitAndNotify;
      try
        PrintCheque(bPrint);
        chequeObj.Printdoc.Printdoc(chequeObj.ClassName, chequeObj.ID, dtmain, Self.Classname , PreviewToDocumentOutputType(not(bPrint)) , ReportToPrint);
        chequeObj.Dirty:= false;
        (*if AppEnv.Employee.CloseOnPrint then Self.Close;*)
        CloseAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
    ChequeObj.ResultStatus.Clear;
  end;
end;
function TfmCheque.SaveTrans: Boolean;
begin
  result := Savecheque;
end;

procedure TfmCheque.SetUserLocking;
begin
  inherited;
  if AccessLevel <5 then
    if ChequeObj.IsRefundCheque then begin
      AccessLevel := 5;
      TransAccessLevel:= 5;
      CommonLib.MessageDlgXP_Vista('This is a Refund Sale Cheque and  access will be changed to read-only.', mtWarning, [mbOK], 0);
    end;
end;

procedure TfmCheque.actPreviewExecute(Sender: TObject);
begin
  PrintDocument(False);
end;
procedure TfmCheque.actPrintExecute(Sender: TObject);
begin
  PrintDocument(true);
end;
procedure TfmCheque.actSignatureExecute(Sender: TObject);
begin
  if frmSignatureEdit.GetClientSignature(self.tblMasterSignature, self.tblMasterSignatureTime) then
    self.ChequeObj.Dirty := true;
end;

procedure TfmCheque.actSignatureUpdate(Sender: TObject);
begin
  inherited;
  if self.tblMasterSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;

procedure TfmCheque.chkEFTClick(Sender: TObject);
begin
  inherited;
  ChequeObj.AddtoEFT := ChkEft.checked;
  ChequeObj.Valid4EFT;
end;

procedure TfmCheque.FormCreate(Sender: TObject);
begin
  SavedDirty := false;
  btnAddfollowupnotedate.Visible :=   not(UserPreferenceOn(lcdOnchequecomments));
  btnAdddate.Visible :=   not(UserPreferenceOn(lcdOnchequeInternalcomments));
  IsReconciled:= False;
  fGLAccountID:= 0;
  AllowCustomiseGrid        := True;
  inherited;
end;

procedure TfmCheque.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
    if ErrorOccurred then Exit;

    CanClose := false;
    chequeObj.PostDb;
    if chequeObj.Dirty  then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes:begin
              if (AccessLevel <> 5) then begin
                if ChequeObj.ValidateData and chequeObj.Save then begin
                    CommitAndNotify;
                    CanClose := true;
                end;
              end else begin
                if ChequeObj.ValidateData then begin
                  chequeObj.Postdb;
                  CommitAndNotify;
                  CanClose := true;
                end;
              end;
            end;
            mrNo: begin
                RollbackTransaction;
                chequeObj.Dirty := false;
                CanClose := true;
                Notify(true);
            end;
            mrCancel:begin
                CanClose := false;
                btnClose.Enabled := True;
            end;
        end;
        ChequeObj.ResultStatus.Clear;
    end else begin
        CanClose := true;
        Notify(false);
    end;
end;

procedure TfmCheque.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(ChequeObj.ID, 'Cheque');
end;

procedure TfmCheque.grdTransactionsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if (Sysutils.SameText(AFieldName ,tblDetailsLinecost.fieldname))
    or (Sysutils.SameText(AFieldName ,tblDetailsLinecostInc.fieldname)) then begin
    Afont.Color := clmaroon;
    ATitleAlignment := taCenter;
    ABrush.Color := pnlTitle.color;
  end;
end;

procedure TfmCheque.cboAccountEnter(Sender: TObject);
begin
  inherited;
  LockIfReconciled(Sender);
end;
procedure TfmCheque.cboBaseForeignCurrencyCodeOrDateChange(Sender: TObject);
begin
  inherited;


  if Sender = cboCreationDate then begin
    if self.IsFlag('DateChange') then exit;
    self.AddFlag('DateChange');
    try
      if SavedAccessLevel = 5 then begin
        { stop user selecting dates prior to closing date }
        if cboCreationDate.Date < AppEnv.CompanyPrefs.ClosingDate then begin
          CommonLib.MessageDlgXP_Vista('Date is Prior the Closing Date.',mtInformation,[mbOk],0);
          cboCreationDate.Date := ChequeObj.OrderDate;
        end;
      end;
    finally
      self.RemoveFlag('DateChange');
    end;
  end;
end;

procedure TfmCheque.LockIfREconciled(Sender: TObject);
begin
  if not IsReconciled then exit;
       if sender is twwdbLookupcombo  then twwdbLookupcombo(SendeR).ReadOnly  := True
  else if sender is TERPDBLookupcombo then TERPDBLookupcombo(Sender).ReadOnly := True
  else if sender is TwwDBEdit         then TwwDBEdit(Sender).ReadOnly         := True;


end;
procedure TfmCheque.NewTransBusObjinstance;
begin
  Freeandnil(chequeObj);
  chequeObj := Tcheque.Create(Self);
  chequeObj.Name:= 'chequeObj';
  ExpenseBase := chequeObj;
  inherited;
end;

procedure TfmCheque.cboClientREnter(Sender: TObject);
begin
  inherited;
  LockIfReconciled(Sender);
end;

procedure TfmCheque.cboCreationDateCloseUp(Sender: TObject);
begin
  inherited;
  cboBaseForeignCurrencyCodeOrDateChange(Sender);
end;

procedure TfmCheque.cboCreationDateEnter(Sender: TObject);
begin
  SavedAccessLevel := Accesslevel;
  if fbRecEditable  then begin
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
    if assigned(TransBase) then begin
      TransBase.AccessManager.AccessLevel := AccessLevel;
      SavedDirty := TransBase.Dirty;
    end;
    if AccessLevel < 3 then begin
      cboCreationDate.ReadOnly := false;
    end;
  end;
  inherited;
end;

procedure TfmCheque.cboCreationDateExit(Sender: TObject);
begin
  if Accesslevel = SavedAccessLevel then Exit;
  if Assigned(Transbase) then begin
    Transbase.postDB;
    if (btnCompleted.enabled = False) and (TransBase.dirty) then
      btnCompleted.enabled := true;
    TransBase.AccessManager.AccessLevel := SavedAccessLevel;
    if TransBase.AccessManager.AccessLevel=1 then
      Transbase.EditDB;
    if SavedAccessLevel = 5 then begin
      Transbase.Dirty := SavedDirty;

    end;
  end
  else if tblmaster.state in [dsedit,dsInsert] then
    tblMaster.Post;
  AccessLevel := SavedAccessLevel;
  inherited;
end;

function TfmCheque.ChequetoPrint: String;
begin
  REsult:= '';
  if chkChooseRpt.Checked = False then result := tcdatautils.GetDefaultReport(GetReportTypeID);
  if (result= '') or (chkChooseRpt.Checked) then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      REsult := dlgReportSelect.SelectedItems.Text;
  end;
end;

initialization
  RegisterClassOnce(TfmCheque);
  with FormFact do begin
    RegisterMe(TfmCheque, 'TChequeListGUI_*=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TChequeDetailsListGUI_*=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TBankAccountListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TPrintchequesGUI_*_Cheque=TransID');
    RegisterMe(TfmCheque, 'TBankAccountListGUI_*_Cheque Deposit=PaymentID');
    RegisterMe(TfmCheque, 'TMemTransListGUI_*_TfmCheque=TransID');
    RegisterMe(TfmCheque, 'TBalTransListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TCashProfitandLossGUI_*_Cheque=TRansID');
    RegisterMe(TfmCheque, 'TToBeReconciledGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TReconListDetailFormGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TTrialBalTransListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TTransactionListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TBASTransReturnListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TNZTransReturnListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TVATTransReturnListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TGlobalsearchGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TTransAccountDetailsGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TGeneralLedgerReportGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TSupplierStatementGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TCashBasisDetailsGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TAllTransactionGUI_*_Cheque=TransNo');
    RegisterMe(TfmCheque, 'TMemTransListGUI_*_Cheque=TransID');
    RegisterMe(TfmCheque, 'TNumberSequenceListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TPnLEmployeereportGUI_*_Cheque=TRansId');
    RegisterMe(TfmCheque, 'TExpenseClaimListGUI_*_Cheque=PurchaseOrderID');
    RegisterMe(TfmCheque, 'TNonERPPOListGUI_*_Cheque=ERPTransId');
  end;
end.




