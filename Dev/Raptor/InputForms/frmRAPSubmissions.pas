unit frmRAPSubmissions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, MemDS, StdCtrls, DBCtrls,
  wwdbdatetimepicker, Buttons, Wwdbigrd, Grids, Wwdbgrid, Mask, wwdbedit,
  wwcheckbox, DNMSpeedButton, DNMPanel, busobjRap, ActnList, BusObjBase,
  wwdblook, Shader;

type
  TfmRAPSubmissions = class(TBaseInputGUI)
    qryRAPSubmission: TMyQuery;
    dsRAPProducts: TDataSource;
    qryRAPSubmissionLines: TMyQuery;
    dsIncvoices: TDataSource;
    qryRAPSubmissionLinesSubmissionLineID: TAutoIncField;
    qryRAPSubmissionLinesSubmissionID: TIntegerField;
    qryRAPSubmissionLinesSaleID: TIntegerField;
    qryRAPSubmissionLinesSaleLineID: TIntegerField;
    qryRAPSubmissionSubmissionID: TAutoIncField;
    qryRAPSubmissionSubmissionDate: TDateField;
    qryRAPSubmissionTotalInvoices: TIntegerField;
    qryRAPSubmissionSubmitted: TStringField;
    qryRAPSubmissionXMLFileName: TStringField;
    qryRAPSubmissionReceivedSubmissionReport: TStringField;
    qryRAPSubmissionfoundErrors: TStringField;
    qryRAPSubmissionSubmissionErrorMessage: TMemoField;
    qryRAPSubmissionParentSubmissionId: TIntegerField;
    qryRAPSubmissionRequestedAmount: TFloatField;
    qryRAPSubmissionPaymentReceived: TStringField;
    qryRAPSubmissionAmountReceived: TFloatField;
    qryRAPSubmissionActive: TStringField;
    qryRAPSubmissionResubmittedID: TIntegerField;
    qryRAPSubmissionDepositID: TIntegerField;
    qryLookupSales: TMyQuery;
    HeaderPanel: TDNMPanel;
    Panel2: TDNMPanel;
    Label8: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Panel1: TDNMPanel;
    pnlInvoices: TDNMPanel;
    lblXMLFileName: TLabel;
    lblSubmitted: TLabel;
    edtXMLFileName: TwwDBEdit;
    grdRapSubmissionLines: TwwDBGrid;
    btnRapSubmissionLines: TwwIButton;
    dtSubmissionDate: TwwDBDateTimePicker;
    btnInvoivces: TDNMSpeedButton;
    btnCreateXML: TDNMSpeedButton;
    btnDeleteXML: TDNMSpeedButton;
    pnlReport: TDNMPanel;
    Label3: TLabel;
    chkReceivedSubmissionReport: TwwCheckBox;
    pnlamount: TDNMPanel;
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    edtAmountReceived: TwwDBEdit;
    chkPaymentReceived: TwwCheckBox;
    edtRequestedAmount: TwwDBEdit;
    pnlErrors: TDNMPanel;
    Label4: TLabel;
    chkfoundErrors: TwwCheckBox;
    pnlErrorDesc: TDNMPanel;
    Label5: TLabel;
    memSubmissionErrorMessage: TDBMemo;
    btnViewXML: TDNMSpeedButton;
    pnlSubmission: TDNMPanel;
    Label10: TLabel;
    chkSubmitted: TwwCheckBox;
    lsTDNMSpeedButtonActions: TActionList;
    actCreateXML: TAction;
    actDeleteXML: TAction;
    qryRAPSubmissionSales: TMyQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    dsRAPSubmissionSales: TDataSource;
    qryLookupSalesSaleID: TIntegerField;
    qryLookupSalesShipDate: TDateField;
    qryLookupSalesDVAFileNum: TStringField;
    qryLookupSalesInvoiceDocNumber: TStringField;
    qryLookupSalesProviderNum: TStringField;
    qryLookupSalesDVADeliveryCode: TStringField;
    qryRAPSubmissionSalesshipDate: TDateField;
    qryRAPSubmissionSalesVeteranno: TStringField;
    qryRAPSubmissionSalesSORef: TStringField;
    qryRAPSubmissionSalesPrescriber: TStringField;
    qryRAPSubmissionSalesdeliveryCode: TStringField;
    cbosalesID: TwwDBLookupCombo;
    DNMSpeedButton1: TDNMSpeedButton;
    actResubmit: TAction;
    DBText1: TDBText;
    qryRAPSubmissionGlobalRef: TStringField;
    qryRAPSubmissionLinesGlobalRef: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;{this combo box is invisible and is used for the double click for the grid}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnInvoivcesClick(Sender: TObject);
    procedure btnRapSubmissionLinesClick(Sender: TObject);
    procedure chkPaymentReceivedEnter(Sender: TObject);
    procedure chkPaymentReceivedClick(Sender: TObject);
    procedure chkSubmittedClick(Sender: TObject);
    procedure chkReceivedSubmissionReportClick(Sender: TObject);
    procedure chkfoundErrorsClick(Sender: TObject);
    procedure btnViewXMLClick(Sender: TObject);
    procedure actCreateXMLExecute(Sender: TObject);
    procedure actCreateXMLUpdate(Sender: TObject);
    procedure actDeleteXMLExecute(Sender: TObject);
    procedure grdRapSubmissionLinesDblClick(Sender: TObject);
    procedure actResubmitUpdate(Sender: TObject);
    procedure actResubmitExecute(Sender: TObject);


  private
    RapObj : TRAPSubmission;
    fsSelectedSaleIDs :String;
    allInvoicesLocked :boolean;
    procedure SelectedSaleLineIDs(Const Sender: TBusObj; var Abort: boolean);
    procedure LockSalesRecord(Const Sender: TBusObj; var Abort: boolean);
    Procedure LockInvoices;
    Procedure form_Show;
  public
  end;

implementation

uses FastFuncs,RAPPendingInvoices, CommonLib, frmPaymentsCustFrm, BaseWebBrowser , XMLIntf,
  FormFactory;

{$R *.dfm}

procedure TfmRAPSubmissions.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPSubmission.Create(self);
    RapObj.Connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := Self.MyConnection;
    RapObj.FormProc := LockInvoices;
end;
Procedure TfmRAPSubmissions.LockInvoices;
var
    ctr :Integer;
begin
    for ctr := 0 to pnlInvoices.ControlCount-1 do
        if pnlInvoices.Controls[ctr] is TWinControl then
            TWinControl(pnlInvoices.Controls[ctr]).Enabled    := not RapObj.Submitted ;
    for ctr := 0 to pnlSubmission.ControlCount-1 do
        if pnlSubmission.Controls[ctr] is TWinControl then
            TWinControl(pnlSubmission.Controls[ctr]).Enabled    := RapObj.Xmlfilename <> '';
            
    for ctr := 0 to pnlReport.ControlCount-1 do
        if pnlReport.Controls[ctr] is TWinControl then
            TWinControl(pnlReport.Controls[ctr]).Enabled    := RapObj.Submitted;

    for ctr := 0 to pnlErrors.ControlCount-1 do
        if pnlErrors.Controls[ctr] is TWinControl then
            TWinControl(pnlErrors.Controls[ctr]).Enabled    := RapObj.Submitted and
                                                                 RapObj.ReceivedSubmissionReport and
                                                                 not(RapObj.PaymentReceived);
    for ctr := 0 to pnlErrorDesc.ControlCount-1 do
        if pnlErrorDesc.Controls[ctr] is TWinControl then
            TWinControl(pnlErrorDesc.Controls[ctr]).Enabled := RapObj.Submitted and
                                                                 RapObj.ReceivedSubmissionReport and
                                                                 RapObj.FoundErrors;
    for ctr := 0 to pnlamount.ControlCount-1 do
        if pnlamount.Controls[ctr] is TWinControl then
            TWinControl(pnlamount.Controls[ctr]).Enabled    := RapObj.Submitted and
                                                                 RapObj.ReceivedSubmissionReport and
                                                                 not(RapObj.FoundErrors);
end;

procedure TfmRAPSubmissions.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRAPSubmissions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RapObj.UserLock.Unlock(RapObj.LockGroupName);
  Action := caFree;
end;

procedure TfmRAPSubmissions.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if RapObj.Save then begin
     CommitTransaction;
    Self.Close;
  end;

end;

procedure TfmRAPSubmissions.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmRAPSubmissions.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not RapObj.Save then Exit;
  RapObj.New;
  SetFocusedControl(dtSubmissionDate);

end;

procedure TfmRAPSubmissions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
CanClose := false;
  if RapObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if RapObj.Save then begin
            CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          RapObj.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmRAPSubmissions.FormShow(Sender: TObject);
begin
  inherited;
  RapObj.Dataset := qryRAPSubmission;
  RapObj.Lines.Dataset :=qryRAPSubmissionLines;
  Form_show;
end;
Procedure TfmRAPSubmissions.form_Show;
var
  QueryNamesNotToOpen: array of string;
begin
  closeQueries;
  RapObj.load(KeyID);
  RapObj.Lines;
  if RapObj.Resubmittedid>0 then begin
    CommonLib.MessageDlgXP_Vista('This record is already resubmitted.' + #13 + #10 + #13 + #10 +
                  'Access will be changed to read-only.', mtWarning, [mbOK], 0);
    AccessLevel :=5;
  End;
  if qryRAPSubmissionSales.Active then qryRAPSubmissionSales.close;
  qryRAPSubmissionSales.ParamByName('xSubmissionID').asInteger := KeyID;
  RapObj.Connection.BeginTransaction;
  SetLength(QueryNamesNotToOpen, 2);
  QueryNamesNotToOpen[0] := 'qryRAPSubmission';
  QueryNamesNotToOpen[1] := 'qryRAPSubmissionLines';
  OpenQueries(QueryNamesNotToOpen);
  LockInvoices;
end;
procedure TfmRAPSubmissions.SelectedSaleLineIDs(Const Sender: TBusObj; var Abort: boolean);
begin
    if fsSelectedSaleIDs <> '' then fsSelectedSaleIDs := fsSelectedSaleIDs + ',';
    fsSelectedSaleIDs := fsSelectedSaleIDs + FastFuncs.IntToStr(TRAPSubmissionLines(sender).SaleID);
end;
procedure TfmRAPSubmissions.LockSalesRecord(Const Sender: TBusObj; var Abort: boolean);
var
    strMsg :String;
begin
    if not RapObj.UserLock.Lock('tblSales' , TRapSubmissionlines(Sender).saleID , RapObj.LockGroupName) then begin
        strMsg :=RapObj.UserLock.lockMessage;
        strMsg := ReplaceStr(strMsg , 'Unable to update data' , 'Unable to lock Sales Order - ' + FastFuncs.IntToStr(TRapSubmissionlines(Sender).saleID));
        CommonLib.MessageDlgXP_Vista(strMsg , mtWarning , [mbok] , 0);
        allInvoicesLocked := False;
        abort := true;
    end;
end;
procedure TfmRAPSubmissions.btnInvoivcesClick(Sender: TObject);
var
    RAPPendingInvoices : TRAPPendingInvoiceGUI;
    strSQl :String;

begin
    inherited;
    if not rapObj.ValidateData then Exit;
    RapObj.PostDB;
    RAPPendingInvoices := TRAPPendingInvoiceGUI(GetComponentByClassName('TRAPPendingInvoiceGUI'));
    Try
        fsSelectedSaleIDs := '';
        RapObj.Lines.IterateRecords(SelectedSaleLineIDs);
        if fsSelectedSaleIDs <> '' then fsSelectedSaleIDs := '(' + fsSelectedSaleIDs + ')';
        RAPPendingInvoices.SelectedSaleIDs := fsSelectedSaleIDs;
        RAPPendingInvoices.ShowModal;
        if RAPPendingInvoices.ModalResult = mrok then begin
            fsSelectedSaleIDs:= RAPPendingInvoices.SelectedSaleIDs;
            if fsSelectedSaleIDs <> '' then begin

                strSQL := 'insert into tblRAPSubmissionLines ' +
                    '(SubmissionID,SaleID,SaleLineID)  ' +
                    ' Select ' + FastFuncs.IntToStr(RapObj.ID) + ', SaleId, SaleLineId ' +
                    ' from tblSalesLines where SaleId in ' + fsSelectedSaleIDs +
                    ' and Invoiced = "T" ';
                RapObj.GetNewDataSet(strSQL,True);
                RapObj.Lines.Dataset.close;
                RapObj.Lines;
                if qryRAPSubmissionSales.Active then qryRAPSubmissionSales.close;
                qryRAPSubmissionSales.ParamByName('xSubmissionID').asInteger := Rapobj.Id;
                qryRAPSubmissionSales.Open;
                strSQL := 'Select distinct tblSales.SaleId , tblSales.TotalAmountInc ' +
                    ' from tblSales inner join tblRAPSubmissionLines on tblRAPSubmissionLines.SaleId = tblSales.SaleID ' +
                    ' where tblRAPSubmissionLines.SubmissionID = ' + FastFuncs.IntToStr(RapObj.ID);
                With RapObj.getNewDataset(strSQL, True) do try
                    RapObj.RequestedAmount:= 0;
                    RapObj.Totalinvoices := 0;
                    if recordcount > 0 then begin
                        First;
                        while Eof = False do begin
                            RapObj.Totalinvoices := RapObj.Totalinvoices +1 ;
                            RapObj.RequestedAmount:= RapObj.RequestedAmount+ fieldByname('totalAmountinc').asFloat;
                            Next;
                        end;
                    end;
                finally
                    if Active then Close;
                    Free;
                end;
            end;
        end;
    finally
        FreeandNil(RAPPendingInvoices);
    end;
end;

procedure TfmRAPSubmissions.btnRapSubmissionLinesClick(Sender: TObject);
var
    strSQL :String;
begin
    inherited;
    if  CommonLib.MessageDlgXP_Vista('Are you sure you wish to delete this Sales order from your submission? ' ,
                    mtconfirmation, [mbYes, mbNo], 0)  = mrno then Exit;
    allInvoicesLocked := True;
    RapObj.Lines.IterateREcords(LockSalesRecord);
    if not allInvoicesLocked then Exit;

    strSQL := 'update tblSales, tblRAPSubmissionLines ' +
            ' set tblSales.RapSubmitstatus = "F" ' +
            ' Where tblSales.SaleId = ' + FastFuncs.IntToStr(RapObj.Lines.SaleID);
    RapObj.getNewDataset(strSQL, True);

    strSQL := 'Delete from tblrapsubmissionlines  where SaleId = ' + FastFuncs.IntToStr(RapObj.Lines.Saleid);
    RapObj.getnewDataset(strSQL , True);

    RapObj.Lines.Dataset.Close;
    RapObj.Lines.Dataset.Open;

    if qryRAPSubmissionSales.Active then qryRAPSubmissionSales.close;
    qryRAPSubmissionSales.ParamByName('xSubmissionID').asInteger := Rapobj.Id;
    qryRAPSubmissionSales.Open;
end;

procedure TfmRAPSubmissions.chkPaymentReceivedEnter(Sender: TObject);
begin
  inherited;
    if RapObj.Paymentreceived then
        if RapObj.DepositId > 0 then
            chkPaymentReceived.Readonly := True;
end;

procedure TfmRAPSubmissions.chkPaymentReceivedClick(Sender: TObject);
var
    Form :TPaymentCustGUI;
begin
  inherited;
    if chkPaymentReceived.checked then begin
        setfocusedcontrol(edtAmountReceived);
        form := TPaymentCustGUI(getComponentbyclassname('TPaymentCustGUI' , True, Self));
        Try
            if RapObj.DepositId <> 0 then Form.KeyId := RapObj.DepositID;

        finally
            FreeandNil(Form);
        end;
    end;
end;

procedure TfmRAPSubmissions.chkSubmittedClick(Sender: TObject);
begin
  inherited;
    if Screen.Activecontrol <> chkSubmitted then exit;
    RapObj.Submitted := chkSubmitted.Checked;
    RapObj.PostDB;
    RapObj.EditDB;
    LockInvoices;
end;

procedure TfmRAPSubmissions.chkReceivedSubmissionReportClick(
  Sender: TObject);
begin
  inherited;
if Screen.Activecontrol <> chkReceivedSubmissionReport then exit;
    RapObj.receivedSubmissionReport := chkReceivedSubmissionReport.Checked;
    RapObj.PostDB;
    RapObj.EditDB;
    LockInvoices;
end;

procedure TfmRAPSubmissions.chkfoundErrorsClick(Sender: TObject);
begin
  inherited;
if Screen.Activecontrol <> chkfoundErrors then exit;
    RapObj.foundErrors := chkfoundErrors.Checked;
    RapObj.PostDB;
    RapObj.EditDB;
    LockInvoices;
end;

procedure TfmRAPSubmissions.btnViewXMLClick(Sender: TObject);
var
    form :TBaseWebBrowserGUI;
begin
  inherited;
  if Rapobj.Xmlfilename = '' then Exit;
  if not FileExists(Rapobj.Xmlfilename) then Exit;

  form := TBaseWebBrowserGUI(GetComponentByClassName('TBaseWebBrowserGUI' ,True, nil, False ) );
  if not assigned(Form) then Exit;
  form.FormStyle := fsMDIChild;
  form.Show;
  Form.WebBrowser.Navigate(Rapobj.Xmlfilename);
end;

procedure TfmRAPSubmissions.actCreateXMLExecute(Sender: TObject);
var
    RapObjXML : IXMLDocument;
    strSQL :String;
begin
  inherited;
    Try
        allInvoicesLocked := True;
        RapObj.Lines.IterateREcords(LockSalesRecord);
        if  not allInvoicesLocked then Exit;

        RapObjXML :=RapObj.CreateRAPXML;
        if RapObjXML = nil then Exit;
        RapObjXML.XML.SaveToFile(RapObj.RAPXMLFileName);
        RapObj.Xmlfilename :=RapObj.RAPXMLFileName;
        RapObj.PostDB;

        strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                        ' set tblSales.RapSubmitstatus = "L" ' +
                        ' Where tblSales.SaleId =tblRAPSubmissionLines.SaleId'+
                        ' and tblRAPSubmissionLines.SubmissionId = ' + FastFuncs.IntToStr(RapObj.ID);
        RapObj.getNewDataset(strSQL, True);
    Except
        on E: Exception do begin
            CommonLib.MessageDlgXP_Vista(E.Message , mtWarning , [mbok] , 0);
        end;
    End;
    LockInvoices;

end;

procedure TfmRAPSubmissions.actCreateXMLUpdate(Sender: TObject);
begin
  inherited;
  if not Assigned(RapObj) then Exit;
    if RapObj.Xmlfilename = '' then begin
        actCreateXML.visible := True;
        if screen.Activecontrol = btnDeleteXML then SetFocusedControl(btnCreateXML);
        actDeleteXML.visible := False;
    end else begin
        actDeleteXML.visible := True;
        if screen.Activecontrol = btnCreateXML then SetFocusedControl(btnDeleteXML);
        actCreateXML.visible := False;
    End;
    actDeleteXML.visible := not(actCreateXML.visible);
end;

procedure TfmRAPSubmissions.actDeleteXMLExecute(Sender: TObject);

var
    strSQL :String;
begin
  inherited;
    if RapObj.Submitted then begin
    end else begin
      strSQL := RapObj.XMLfileName;
      RapObj.XMLfileName := '';
      DeleteFile(strSQL)  ;

      allInvoicesLocked := True;
      RapObj.Lines.IterateREcords(LockSalesRecord);
      if not allInvoicesLocked then Exit;

      strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                        ' set tblSales.RapSubmitstatus = "F" ' +
                        ' Where tblSales.SaleId =tblRAPSubmissionLines.SaleId'+
                        ' and tblRAPSubmissionLines.SubmissionId = ' + FastFuncs.IntToStr(RapObj.ID);
        RapObj.getNewDataset(strSQL, True);
      RapObj.PostDB;
    end;
    LockInvoices;
end;
procedure TfmRAPSubmissions.grdRapSubmissionLinesDblClick(Sender: TObject);
begin
  inherited;
    OnComboDblClick(cbosalesID);
end;

procedure TfmRAPSubmissions.actResubmitUpdate(Sender: TObject);
begin
  inherited;
    actResubmit.Enabled := (RapObj.Receivedsubmissionreport) and (RapObj.Founderrors) and (RapObj.Resubmittedid = 0);
end;

procedure TfmRAPSubmissions.actResubmitExecute(Sender: TObject);
begin
  inherited;
  if RapObj.Resubmit then begin
    RapObj.connection.CommitTransaction;
    KeyId := Rapobj.ResubmittedID;
    form_Show
  end;
end;

initialization
  RegisterClassOnce(TfmRAPSubmissions);
  with FormFact do  begin
    RegisterMe(TfmRAPSubmissions, 'TRAPSubmissionsGUI_*=SubmissionID');
  End;
end.
