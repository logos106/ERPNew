{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/06/05  1.00.01 BJ  pop-ups a message if the warranty finish date of the
                       selected customer job is less than the system date
 28/07/05  1.00.02 DSP  Code changed to use PickingSlipOrder in place of
                        PickingSlipOrderByBins.
 05/01/06  1.00.04 BJ   Records writen into tblproductqtyallocation table for the picking
                        slip report to work. this is a temporary solution, should be removed
                        When implement the bin-Batch functionality
 15/08/06  1.00.05 BJ   Print options does the validations only if the form is not in readonly state
                        as the form is non-editable when readonly, so nothing will be changed
 18/09/06  1.00.06  BJ   business object introduced
 }


unit CashSaleBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cash, DB,   StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker,
  wwdblook, DBCtrls, Mask, ExtCtrls,  DNMPanel, Wwdbigrd,
  Grids, Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts,
  wwdbedit, MemDS, DBAccess, MyAccess,ERPdbComponents, DataState, BusobjCash , BusObjbase,
  Shader, ProgressDialog, ERPDbLookupCombo, DNMAction,
  CorrespondenceObj;

type
  TCashSaleBaseGUI = class(TBaseCashGUI)
    cmdPrintPick: TDNMSpeedButton;
    actPick: TAction;
    btnDelDocket: TDNMSpeedButton;
    actDelDocket: TAction;
    txtPickMemo: TDBMemo;
    Label93: TLabel;
    txtConNote: TDBEdit;
    Label101: TLabel;
    tblDetailsIsQuote: TWideStringField;
    tblMasterSaleDateTime: TDateTimeField;
    qryTills: TERPQuery;
    cboTillName: TwwDBLookupCombo;
    Bevel3: TBevel;
    Label444: TLabel;
    tblMasterTillName: TStringField;
    btnAddDate: TDNMSpeedButton;
    procedure btnCompletedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPickExecute(Sender: TObject);
    procedure actPickUpdate(Sender: TObject);
    procedure actDelDocketExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure RestoreOverridenAccessLevel(Sender: TObject);
    procedure OverrideAccessLevel(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure txtConNoteEnter(Sender: TObject);
    procedure txtConNoteExit(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    procedure actSplitPayExecute(Sender: TObject);
    procedure btnCashDrawerClick(Sender: TObject);
    procedure cboCreationDateCloseUp(Sender: TObject);
    procedure grdTransactionsKeyPress(Sender: TObject; var Key: Char);
    procedure tblMasterCommentsSetText(Sender: TField; const Text: string);
    procedure txtCommentsExit(Sender: TObject);
    procedure btnAddDateClick(Sender: TObject);

  private
    { Private declarations }
    fbGrdDblClickSerials :Boolean;
    procedure AddAlterNateProduct(Sender: TwwDbGrid);
    procedure BeforeShowAlternateProductsGUI(Sender: TObject);
    procedure SelectAlternateProduct;


  protected
    SaveWithoutconfirmationOnNew:Boolean;
    Function SaveCashSale :Boolean;Virtual;
    function ReturnType:String;Override;
    Function  GetReportTypeID: integer;                             Override;
    Procedure AfterCommit;                                          Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure CommitAndNotify;override;
    procedure NewTransBusObjinstance;override;
    function SaveTrans:Boolean ; Override;
    function Save4NewTrans: Boolean;Override;
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    procedure CheckForMailAttachments(Corres: TCorrespondenceGui); overload;
  public
    { Public declarations }
    bIgnoreEvent: boolean;
    procedure DoOnClientchange;Override;
  end;

implementation

{$R *.dfm}

uses
  FormFactory, DNMLib,
  BaseInputForm,  (*SalesLib,*)
  CommonLib, BusObjPrintDoc, Dateutils,
  tcConst, BusObjConst, AppEnvironment, tcDataUtils,
  PaymentsLibGUI, frmAllocation, FastFuncs(*, frmSalesEquipmentProducts*),
  tcTypes, CommonFormLib, AlternateProductSearch, frmQuickPOS, BusObjAttachment,
  SystemLib, EmailExtraUtils, CommonDbLib, MySQLConst;

  { DONE -oIan Blakeley -cCash Sales : When Sales Order is converted to Cash Sale it can be saved without selecting payment method. }
procedure TCashSaleBaseGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSalesPayments         then TSalesPayments(Sender).DataSet     := qryPayments;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped)  then begin
        CashBase.Lines.PostDb;
        if not (self is TfmQuickPOS) then // no allocation for quickpos
          TfmAllocation.DoBinBatchform(CashBase.Lines.PQA , Self);
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_LineDeleted) then begin
        CashBase.Lines.postdb;
        TfmAllocation.DoBinBatchform(CashBase.Lines.PQA , Self);
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEventVal_ChooseAlternateProduct) then begin
      (* msg := 'The Product ' + CashBase.Lines.Product.ProductName + ' Has Been Discontinued  and Can Only Sell the Available Quantity!';
      Msg := msg + NL + NL +'Currently There is ' +  FloatToStr(CashBase.Lines.UOMQtyShipped) ;
      if CashBase.Lines.UOMMultiplier <> 1 then Msg := msg + ' ' + CashBase.Lines.UnitOfMeasure+'(' + FloatTostr(CashBase.Lines.UOMMultiplier)+') = ' + floatToStr(CashBase.Lines.QtyShipped) + ' ' +Default_UOM;
      Msg := msg + ' Available.';
      Msg := msg + NL + NL +'Do you wish To Select Another Product From the Alternate Product list of ' + CashBase.Lines.ProductName +
                          ' for the remaining Quanityt of '+ FloatToStr(CashBase.Lines.QtyrequiredforAlternateProduct);
      if MessageDlgXP_Vista(msg,mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      OpenERPListFormSingleselect('TAlternateProductSearchGUI' , AddAlterNateProduct, BeforeShowAlternateProductsGUI); *)
      SelectAlternateProduct;
    end;
end;
Procedure TCashSaleBaseGUI.SelectAlternateProduct;
var
  MSG:String ;
  msgoption:Word;
begin
      msg := 'The Product ' + CashBase.Lines.Product.ProductName + ' Has Been Discontinued  and Can Only Sell the Available Quantity!';
      Msg := msg + NL + NL +'Currently There is ' +  FloatToStr(CashBase.Lines.UOMQtyShipped) ;
      if CashBase.Lines.UOMMultiplier <> 1 then Msg := msg + ' ' + CashBase.Lines.UnitOfMeasure+'(' + FloatTostr(CashBase.Lines.UOMMultiplier)+') = ' + floatToStr(CashBase.Lines.QtyShipped) + ' ' +AppEnv.DefaultClass.DefaultUOM;
      Msg := msg + ' Available.';
      Msg := msg + NL + NL +'Do you wish To Select Another Product From the Alternate Product list of ' + CashBase.Lines.ProductName +
                          ' for the remaining Quanityt of '+ FloatToStr(CashBase.Lines.QtyrequiredforAlternateProduct);

      msgoption := MessageDlgXP_Vista(Msg, mtconfirmation, [], 0, nil, '' ,'' , False, nil , 'Product List,Alternate Product List,Cancel');
      if  msgoption= 102 then Exit;
      if msgoption = 100 then
        OpenERPListFormModal('TProductListExpressGUI', AddAlterNateProduct)
      else
        OpenERPListFormModal('TAlternateProductSearchGUI', AddAlterNateProduct, BeforeShowAlternateProductsGUI);
end;

Procedure TCashSaleBaseGUI.AddAlterNateProduct(Sender: TwwDbGrid) ;
var
    fLinePrice :double;
    fid: Integer;
begin
  fid := CashBase.Lines.ID;
  try
    CashBase.Lines.AddingAlternateProduct:= true;
    Try
      CashBase.Lines.PostDB;
      fLinePrice :=CashBase.Lines.lineprice;
      CashBase.Lines.New;
             if Sender.Datasource.DataSet.findfield('AlternateProductID') <> nil then CashBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('AlternateProductID').AsInteger
        else if Sender.Datasource.DataSet.findfield('PartsId')            <> nil then CashBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('PartsId').AsInteger
        else if Sender.Datasource.DataSet.findfield('ProductID')          <> nil then CashBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('ProductID').AsInteger;

             if Sender.Datasource.DataSet.findfield('AlternateProductName')<> nil then CashBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('AlternateProductName').AsString
        else if Sender.Datasource.DataSet.findfield('Partname')            <> nil then CashBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('Partname').AsInteger
        else if Sender.Datasource.DataSet.findfield('ProductName')         <> nil then CashBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('ProductName').AsString;


      CashBase.Lines.QtyShipped := CashBase.Lines.QtyrequiredforAlternateProduct;
      CashBase.Lines.UOMQtyShipped:= Round(DivZer(CashBase.Lines.QtyShipped, CashBase.Lines.UOMMultiplier), CashBase.Lines.RoundPlacesGeneral);
      CashBase.Lines.QtyrequiredforAlternateProduct:= 0;
      if (fLinePrice<> 0) and (Appenv.companyprefs.UseDiscontinuedProductPriceforAlternateProduct) then
              CashBase.Lines.lineprice := fLinePrice;
      CashBase.Lines.PostDB;
    Finally
      CashBase.Lines.AddingAlternateProduct:= False;
    End;
  finally
    if CashBase.Lines.Locate(CashBase.Lines.Idfieldname, fid, []) then begin
      if (Appenv.CompanyPrefs.ReplaceDiscontinuedwithAlternate) and (CashBase.Lines.QtySold =0) then begin
          CashBase.Lines.Deleted := True;
          CashBase.Lines.PostDB;
      end;
    end;
  end;
end;
Procedure TCashSaleBaseGUI.BeforeShowAlternateProductsGUI(Sender:TObject);
begin
  if not(Sender is TAlternateProductSearchGUI) then exit;
  TAlternateProductSearchGUI(Sender).ProductId := CashBase.Lines.ProductID;
  TAlternateProductSearchGUI(Sender).classId := CashBase.SaleclassId;
end;
function TCashSaleBaseGUI.SaveCashSale :Boolean;
begin
  try
    if not fbPaymentLock then begin
        if CashBase.Dirty then begin
          CashBase.ResultStatus.Clear;
          CashBase.PostDB;
          CashBase.Lines.PostDB;
          CashBase.Salespayments.PostDB;
            if not ValidData then begin
              Result := false;
              Exit;
            end;
            if CashBase.Save then begin
              //SrNoTransObj.BeforeCommit(MyConnection);
              CashBase.Dirty := false;
            end else begin
              Result := false;
              Exit;
            end;
        end;
    end;
     Result := True;
  finally
      (*if result then TfmSalesEquipmentProduct.ShowProductswithnoEquipment(CashBase);*)
  end;
end;
function TCashSaleBaseGUI.SaveTrans: Boolean;
begin
  REsult := SaveCashSale;
end;

procedure TCashSaleBaseGUI.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;
end;


procedure TCashSaleBaseGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveCashSale then begin
      CommitAndNotify;
      Close;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TCashSaleBaseGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

Procedure TCashSaleBaseGUI.DoOnClientchange;
begin
  if (Empty(cboClientR.Text)) or (CashBase.CustomerID =0) then Exit;

  try
    if cboClientR.LookupTable.FieldByName('company').asString <> cboClientR.Text then
      cboClientR.LookupTable.locate('company', cboClientR.Text , []);
  Except
    // kill the exception
  end;
  inherited;
  opendb(cboAccountQry);
  cboAccountQry.Locate('AccountName', UNDEPOSITED_FUNDS, [loCaseInsensitive]);
  cboAccount.LookupValue := cboAccountQry.FieldValues['AccountName'];
  cboAccount.Enabled := false;
  showRedeemPoints(CashBase.SaleDate);
end;
procedure TCashSaleBaseGUI.CheckForMailAttachments(Corres: TCorrespondenceGui);
var
  Att: TAttachment;
begin
  Att := TAttachment.Create(nil);
  try
    Att.Connection := TMyDacDataConnection.Create(Att);
    Att.Connection.Connection := MyConnection;
    Att.LoadSelect('TableName = "tblSales" and TableId = ' + self.tblMasterSaleID.AsString);
    if Att.Count > 0 then begin
      if CommonLib.MessageDlgXP_Vista('Would you like to send this ' + TransName + '''s attachments with this email?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        while not Att.EOF do begin
          Att.SaveToFile(WinTempDir + Att.AttachmentName);
          Corres.AttachmentList.Add(WinTempDir + Att.AttachmentName);
          Att.Next;
        end;
      end;
    end;
  finally
    Att.Free;
  end;
end;

function TCashSaleBaseGUI.EmailTransaction(const RecipientAddress: String;ASilent, ASecret: boolean): boolean;
var
  ReportType, OutGoingFileName: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  IsOK: boolean;
  intResult: integer;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  Recipients: string;
begin
  result := False;
  DisableForm;
  try
    if not SaveCashSale then Exit;
    Self.CommitAndNotify;
    try
      ReportToPrint := '';
      strResult := '';

      ReportType := '';
      OutGoingFileName := '';
      Recipients := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger, 'MainContactForQuote');
      if RecipientAddress <> '' then
        Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

      if Recipients = '' then
        if AppEnv.CompanyPrefs.UseDefaultMailClient then
        begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
          ASilent := false;
        end else begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString +
            ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
            'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
          ASilent := False;
        end;

      ReportType := 'CashSale';
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)

      // Ask the user if they want to specify a new subject
      intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
        tblMaster.FieldByName('CustomerName').AsString + '.' + #13 + #10 + #13 + #10 +
        'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
        'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);

      if intResult = mrYes then begin
        strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
          ReportType + ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString +
          ' for ' + tblMaster.FieldByName('CustomerName').AsString);
      end else if intResult = mrNo then begin
        strResult := '';
      end else begin
        Exit;
      end;

      try
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

        IsOK_to_Print(IsOK); //Silent Save
        if IsOK then begin
          Self.CommitAndNotify;
          inherited;
        end;

        LoadTemplate(true, true);

        Corres := TCorrespondenceGui.Create;
        try
          Corres.CorrespondenceType := CorrespondenceObj.ctEmail;
          Corres.DeleteAttachments := true;
          if strResult = '' then Corres.Subject := ReportType +
              ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString
          else Corres.Subject := strResult ;
          Corres.RecipientList := Recipients;
          Corres.CCList := GetSalesEmails;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

          OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString, '.PDF');

          if not FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            CommonLib.MessageDlgXP_Vista('Attachment could not be found. This is probably caused by a problem with the template. Please check the template and try again.', mtInformation , [mbOK], 0);
          end;
          if FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin;
              copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                PChar( Commonlib.TempDir  + OutGoingFileName), false);
            end;
          end;
          Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
          CheckForMailAttachments(Corres);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
          if ASilent and not ASecret then
            if not EmailShortSendMode(ASilent, ASecret) then
              exit;

          result := Corres.Execute(ASilent, ASecret);
        finally
          Corres.Free;
        end;

        lblEmail.Visible := false;

        TransactionID := tblMaster.FieldByName('InvoiceDocNumber').AsString;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString;

        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,');
          qryEmailedList.SQL.Add(' TransactionDescription,ContactID,EmailAddressUsed) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +  '", "' + IntToStr(EmailContactID) +
            '", "' + RecipientAddress + '")');
          qryEmailedList.Execute;

        finally
          FreeandNil(qryEmailedList);
        end;
      except
        lblEmail.Visible := false;
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);

      end;
    finally
      LogEmailed(result , ReportType);
      self.BeginTransaction;
      ReportToPrint := '';
    end;
  finally
    EnableForm;
  end;

end;

procedure TCashSaleBaseGUI.actPickExecute(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveCashSale then Exit;
    CommitAndNotify;
    PrintSalesPickingSlip;
    //Self.Close;
    self.BeginTransaction;
  finally
    EnableForm;
  end;   
end;

procedure TCashSaleBaseGUI.actPickUpdate(Sender: TObject);
begin
  actPick.Enabled := Assigned(tblDetails) and tblDetails.Active and (tblDetails.RecordCount > 0);
end;

procedure TCashSaleBaseGUI.actDelDocketExecute(Sender: TObject);
begin
    {no delivery docket in the cash sale as the shipto address is not available here}
end;

function TCashSaleBaseGUI.GetReportTypeID: integer;
begin
  Result := 6;
end;

procedure TCashSaleBaseGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveCashSale then Exit;
    CommitAndNotify;
    try
      fbReportSQLSupplied :=   False;
      CashBase.Dirty:= false;
      inherited;
//      closeAfterPrint;
      self.BeginTransaction;
    except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
  finally
    EnableForm;
  end;   
end;

procedure TCashSaleBaseGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveCashSale then Exit;
    CommitAndNotify;
    try
      fbReportSQLSupplied :=   False;
      CashBase.Dirty:= false;
      inherited;
//      closeAfterPrint;
      self.BeginTransaction;
    except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
  finally
    EnableForm;
  end;   
end;
procedure TCashSaleBaseGUI.txtCommentsExit(Sender: TObject);
begin
  if Assigned(tblMaster.FindField('IsLayby')) and tblMaster.Fieldbyname('IsLayby').AsBoolean then
    exit;
  if accesslevel <= 2 then begin
    //txtComments.text := AddDateTime(lcdOnCashsAleComments, txtComments.text);
    AddDateTime(lcdOnCashsAleComments, txtComments);
  end;
  RestoreOverridenAccessLevel(Sender);
end;
procedure TCashSaleBaseGUI.btnAddDateClick(Sender: TObject);
begin
  inherited;
  if accesslevel <= 2 then begin
    //txtComments.text := AddDateTime(lcdOnCashsAleComments, txtComments.text);
    AddDateTime(lcdOnLoganyway, txtComments);
  end;
end;

// Adds date / time to notes when user leaves the memo.
procedure TCashSaleBaseGUI.RestoreOverridenAccessLevel(Sender: TObject);
begin
  inherited;
end;

// Remove date / time if they are present.
procedure TCashSaleBaseGUI.tblMasterCommentsSetText(Sender: TField;const Text: string);
begin
  inherited;
  CashBase.Editdb;
  sender.AsString := text;
end;

procedure TCashSaleBaseGUI.OverrideAccessLevel(Sender: TObject);
begin
  inherited;
  if accesslevel = 1 then begin
    if Assigned(tblMaster.FindField('IsLayby')) and tblMaster.Fieldbyname('IsLayby').AsBoolean then
      exit;
    with txtComments do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
  end;
end;

procedure TCashSaleBaseGUI.FormShow(Sender: TObject);
begin
  //tblMasterTableName := 'tblsales';
  //tblDetailsTableName := 'tblsaleslines';
stepProgressbar;
try
  DisableForm;
  try
    inherited;
    cboAccount.Enabled := false;
    CashBase.Dirty := False;
    GuiPrefs.DbGridElement[grdTransactions].RemoveFields(
      'Attrib1,Attrib2,Attrib3,Shipped,RefundQty');
    AddRewardPointmenuITems;

    if KeyID <> 0 then
      showRedeemPoints(CashBase.SaleDate);
  finally
    EnableForm;
  end;
finally
  hideProgressbar;
end;
end;

function TCashSaleBaseGUI.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  try
    // If user does not have access to this form don't process any further
    if ErrorOccurred then Exit;

    if CashBase.Dirty then begin
      if SaveWithoutconfirmationOnNew then
        if SaveCashSale then begin
          CommitAndNotify;
          Result := true;
         end else Exit
      else
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          if SaveCashSale then begin
            CommitAndNotify;
            Result := true;
          end else Exit;  // current record should be commited before inserting new reocrd
        mrNo: begin
            RollbackTransaction;
            Result := true;
        end;
        mrCancel:
            Exit;
      end;
    end else begin
      REsult := True;
    End;
  finally
    EnableForm;
  end;
end;

procedure TCashSaleBaseGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if CashBase.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:if SaveCashSale then begin
        CanClose := true;
        Notify(true);
      end;
      mrNo:begin
          RollbackTransaction;
          CashBase.Dirty := false;
          CanClose := true;
          Notify(false);
        end;
      mrCancel:CanClose := false;
    End;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TCashSaleBaseGUI.FormCreate(Sender: TObject);
begin
  SaveWithoutconfirmationOnNew := False;
  btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnCashsAleComments));
  inherited;
  CashBase.Connection := TMyDacDataConnection.Create(CashBase);
  TMyDacDataConnection(CashBase.Connection).MyDacConnection := MyConnection;
  bIgnoreEvent := false;
end;

procedure TCashSaleBaseGUI.AfterCommit;
begin

  inherited;
  // Recalculate commissions for this invoice
  (*SalesLib.CalculateCommission(tblMasterSaleID.AsInteger, tblMasterEmployeeID.AsInteger);*)
  // Recalculate any Reward Points for this invoice
  (*SalesLib.CalculateRewardPoints(tblMasterSaleID.AsInteger);*)
end;

procedure TCashSaleBaseGUI.FormDestroy(Sender: TObject);
begin
  //FreeAndNil(CashBase);
  CashBase:= nil;
  self.CashBase := nil;
  inherited;
end;


procedure TCashSaleBaseGUI.txtConNoteEnter(Sender: TObject);
begin
  inherited;
    SavedAccessLevel := Accesslevel;
    if Accesslevel = 1 then exit;
    if fbRecEditable then begin
        AccessLevel := 1;
        CashBase.AccessManager.AccessLevel := 1;
    end;
end;

procedure TCashSaleBaseGUI.txtConNoteExit(Sender: TObject);
begin
  inherited;
    CashBase.postDB;
    CashBase.editDB;
    AccessLevel := SavedAccessLevel;
    CashBase.AccessManager.AccessLevel := SavedAccessLevel;
end;

procedure TCashSaleBaseGUI.grdTransactionsDblClick(Sender: TObject);
begin
    fbGrdDblClickSerials := true;
    try
      if TField(grdTransactions.GetActiveField).FieldName = 'UnitofMeasureShipped' then
            DoBusinessObjectEvent(CashBase.Lines, BusObjEvent_Change, BusObjEventVal_QtyShipped);
      inherited;
    finally
        fbGrdDblClickSerials := False;
    end;
end;

procedure TCashSaleBaseGUI.btnDepositClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowDepositedListForm(CashBase.ID,'Cash Sale');
end;

procedure TCashSaleBaseGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCashSaleBaseGUI.actCustomerContactsExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

procedure TCashSaleBaseGUI.actSplitPayExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;


procedure TCashSaleBaseGUI.btnCashDrawerClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

procedure TCashSaleBaseGUI.cboCreationDateCloseUp(Sender: TObject);
begin
  inherited;
    showRedeemPoints(cboCreationDate.date);
end;

procedure TCashSaleBaseGUI.grdTransactionsKeyPress(Sender: TObject;
  var Key: Char);
begin

    if (Sysutils.SameText(tblDetailsProductName.asString , REDEEM_POINTS)) then begin
        Key := chr(0);
        Exit;
    end;
  inherited;
end;

procedure TCashSaleBaseGUI.NewTransBusObjinstance;
begin
  TransBase := Cashbase;
  inherited;
end;

function TCashSaleBaseGUI.ReturnType: String;
begin
  Result := 'Cash Sale';
end;

end.




