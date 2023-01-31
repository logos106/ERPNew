unit frmPhSupportPrintoutFrm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/05  1.00.01 ???  pop-ups a message if the warranty finish date of the
                       selected customer job is less than the system date
 24/04/06  1.00.02 AL  Added Emailing

 }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, DBCtrls, ExtCtrls, Buttons, DNMSpeedButton,  Mask, BaseInputForm, 
  kbmMemTable, wwdblook, EmailUtils, MemDS, DBAccess, MyAccess,ERPdbComponents, Shader,
  DNMPanel, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ImgList, ProgressDialog;

type
  TfrmPhSupportPrintout = class(TBaseInputGUI)
    txtStreet: TEdit;
    Cus_address_Label: TLabel;
    txtSuburb: TEdit;
    Cus_city_sub_Label: TLabel;
    txtState: TEdit;
    Cus_state_Label: TLabel;
    txtPostcode: TEdit;
    Cus_Pcode_Label: TLabel;
    txtAltPhone: TEdit;
    Cus_Alt_PH_Label: TLabel;
    txtContact: TEdit;
    Cus_contact1_Label: TLabel;
    cboCusIDSrc: TDataSource;
    Combo74_Label: TLabel;
    txtPhone: TEdit;
    Label6: TLabel;
    txtFaxNumber: TEdit;
    Label9: TLabel;
    Box43: TBevel;
    Box44: TBevel;
    txtPeriod1: TEdit;
    Label35: TLabel;
    txtPeriod2: TEdit;
    Label37: TLabel;
    txtPeriod3: TEdit;
    Label39: TLabel;
    txtPeriod4: TEdit;
    Label41: TLabel;
    txtAmount1: TEdit;
    Label43: TLabel;
    txtAmount2: TEdit;
    Label45: TLabel;
    txtAmount3: TEdit;
    Label47: TLabel;
    txtAmount4: TEdit;
    Label49: TLabel;
    Box50: TBevel;
    Label51: TLabel;
    qryCustomer: TERPQuery;
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdEmail: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    ADOQuery1: TERPQuery;
    DataSource1: TDataSource;
    qryAutoFill: TERPQuery;
    DataSource2: TDataSource;
    txtEmail: TEdit;
    Label1: TLabel;
    ADOQuery1PhoneSupportPeriodNo1: TWideStringField;
    ADOQuery1PhoneSupportAmountNo1: TFloatField;
    ADOQuery1PhoneSupportPeriodNo2: TWideStringField;
    ADOQuery1PhoneSupportAmountNo2: TFloatField;
    ADOQuery1PhoneSupportPeriodNo3: TWideStringField;
    ADOQuery1PhoneSupportAmountNo3: TFloatField;
    ADOQuery1PhoneSupportPeriodNo4: TWideStringField;
    ADOQuery1PhoneSupportAmountNo4: TFloatField;
    ADOQuery1EditedFlag: TWideStringField;
    ADOQuery2: TERPQuery;
    DataSource3: TDataSource;
    txtNotes: TDBMemo;
    cboCusID: TwwDBLookupCombo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnAddfollowupnotedate: TDNMSpeedButton; // Was OnAfterUpdate
    procedure AutoFillDetails;
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtNotesExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure txtNotesEnter(Sender: TObject);
    procedure cboCusIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure btnAddfollowupnotedateClick(Sender: TObject);

  private
    { Private declarations }
    fbChangesMade: boolean;
  public
    { Public declarations }

  end;

implementation

uses FastFuncs,FormFactory, ShellAPI,
  DNMExceptions, CommonLib, DNMLib,  CommonDbLib, EmailExtraUtils,
  AppEnvironment, MySQLConst, tcDataUtils, CorrespondenceObj;

{$R *.DFM}


procedure TfrmPhSupportPrintout.AutoFillDetails;
begin
  qryAutoFill.Close;
  qryAutoFill.ParamByName('CID').asInteger := ADOQuery2.FieldByName('ClientID').AsInteger;
  qryAutoFill.Open;
  txtContact.Text := qryAutoFill.FieldByName('Title').AsString + ' ' + qryAutoFill.FieldByName('FirstName').AsString +
    ' ' + qryAutoFill.FieldByName('LastName').AsString;
  txtStreet.Text := qryAutoFill.FieldByName('Street').AsString;
  txtSuburb.Text := qryAutoFill.FieldByName('Suburb').AsString;
  txtState.Text := qryAutoFill.FieldByName('State').AsString;
  txtPostcode.Text := qryAutoFill.FieldByName('Postcode').AsString;
  txtPhone.Text := qryAutoFill.FieldByName('Phone').AsString;
  txtAltPhone.Text := qryAutoFill.FieldByName('AltPhone').AsString;
  txtFaxNumber.Text := qryAutoFill.FieldByName('FaxNumber').AsString;
  txtEmail.Text := qryAutoFill.FieldByName('Email').AsString;
end;

procedure TfrmPhSupportPrintout.cmdSaveClick(Sender: TObject);
begin
  try
    ADOQuery2.Post;
  except begin
  CommonLib.MessageDlgXP_Vista('No changes have been done.', mtInformation, [mbOK], 0);
    Exit;
  end;
  end;
  Self.Close;
end;

procedure TfrmPhSupportPrintout.cmdCancelClick(Sender: TObject);
var 
  iExitResult: integer;
begin
  if fbChangesMade then begin
    iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case iExitResult of
      mrYes: cmdSave.Click;
      mrNo: 
        begin; 
          Self.Close; 
        end;
      mrCancel: Exit;
    end;
  end else begin
    Self.Close;
  end;
end;

// Adds date / time to notes when user leaves the memo.
procedure TfrmPhSupportPrintout.txtNotesExit(Sender: TObject);
begin
  inherited;
  //txtNotes.text :=  AddDateTime(lcdOnSupportPricingNotes, txtNotes.Text, False);
  AddDateTime(lcdOnSupportPricingNotes, txtNotes, False);
end;
procedure TfrmPhSupportPrintout.btnAddfollowupnotedateClick(Sender: TObject);
begin
  inherited;
  //txtNotes.text :=  AddDateTime(lcdOnLoganyway, txtNotes.Text, False);
  AddDateTime(lcdOnLoganyway, txtNotes, False);
end;

// Remove date / time if they are present.
procedure TfrmPhSupportPrintout.txtNotesEnter(Sender: TObject);
begin
  inherited;
  with txtNotes do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
end;

procedure TfrmPhSupportPrintout.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      OpenQueries;
      ADOQuery2.Insert;
      txtPeriod1.Text := ADOQuery1.FieldByName('PhoneSupportPeriodNo1').AsString;
      txtAmount1.Text := ADOQuery1.FieldByName('PhoneSupportAmountNo1').AsString;
      txtPeriod2.Text := ADOQuery1.FieldByName('PhoneSupportPeriodNo2').AsString;
      txtAmount2.Text := ADOQuery1.FieldByName('PhoneSupportAmountNo2').AsString;
      txtPeriod3.Text := ADOQuery1.FieldByName('PhoneSupportPeriodNo3').AsString;
      txtAmount3.Text := ADOQuery1.FieldByName('PhoneSupportAmountNo3').AsString;
      txtPeriod4.Text := ADOQuery1.FieldByName('PhoneSupportPeriodNo4').AsString;
      txtAmount4.Text := ADOQuery1.FieldByName('PhoneSupportAmountNo4').AsString;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPhSupportPrintout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmPhSupportPrintout.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
  if not Empty(cboCusID.Text) then ADOQuery2.Post;
    KeyID := 0;
    FormShow(nil);
    AutoFillDetails;
  finally
    EnableForm;
  end;
  SetControlFocus(cboCusID);
  fbChangesMade := false;
end;


procedure TfrmPhSupportPrintout.cboCusIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  AutoFillDetails;
  fbChangesMade := true;
end;

procedure TfrmPhSupportPrintout.FormCreate(Sender: TObject);
begin
  inherited;
  btnAddfollowupnotedate.Visible :=   not(UserPreferenceOn(lcdOnSupportPricingNotes));
  fbChangesMade := false;
end;

procedure TfrmPhSupportPrintout.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if (Key <> VK_RETURN) or (KEY <> VK_TAB) or (KEY <> VK_DOWN) or (Key <> VK_UP) or
    (Key <> VK_LEFT) or (Key <> VK_RIGHT) or (Key <> VK_HOME) or ((Key < VK_F1) and (Key > VK_F24)) then begin
    fbChangesMade := true;
  end;
end;

procedure TfrmPhSupportPrintout.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      ADOQuery2.Post;
    except begin
    CommonLib.MessageDlgXP_Vista('No changes have been done.', mtInformation, [mbOK], 0);
      Exit;
    end;
    end;
    ADOQuery2.Edit;
    if ADOQuery2.FieldByName('PSID').AsString = '' then Exit;
    PrintTemplateReport('Clients Phone Support',' WHERE PSID = ' + ADOQuery2.FieldByName('PSID').AsString, not AppEnv.Employee.ShowPreview, 1);
  finally
    EnableForm;
  end;
end;

procedure TfrmPhSupportPrintout.cmdEmailClick(Sender: TObject);
Var
  RecipientAddress, ReportType, OutGoingFileName, strResult: string;
  qryEmailedList: TERPQuery;
  EmailDate: TDateTime;
  intResult : integer;
  f: file;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  DisableForm;
  try
    inherited;
    try
      ADOQuery2.Post;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('No changes have been done.', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
//    end;
    ADOQuery2.Edit;

    ReportToPrint := 'Phone Support';

    Corres := TCorrespondenceGui.Create;
    try

      ReportType := '';
      OutGoingFileName := '';

      RecipientAddress := txtEmail.Text;

      if RecipientAddress = '' then
        if CommonLib.MessageDlgXP_Vista(cboCusID.Text +
          ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
          'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;

//      if RecipientAddress <> '' then begin
        ReportType := 'Telephone Support';
        // String defined here because it is easy to change when this code is applied to
        // other forms. (ie, Quote instead of Invoice etc)

        // Ask the user if they want to specify a new subject
        intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
          cboCusID.Text + '.' + #13 + #10 + #13 + #10 +
          'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
          'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
          [mbYes, mbNo, mbCancel], 0);

        if intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
            ReportType + ' #' +
            ' for ' + cboCusID.Text);
        end else if intResult = mrNo then begin
          strResult := '';
        end else begin
          Exit;
        end;

        try
          label8.Visible := true;

          // TURN OFF BUTTONS WHILE EMAIL IS BEING SENT
          cmdSave.Enabled := false;
          cmdNew.Enabled := false;
          cmdPrint.Enabled := false;
          cmdCancel.Enabled := false;
          cmdEmail.Enabled := false;

          LoadTemplate(true, true);
          SaveTemplateReport(ReportToPrint, '', true, 'PDF');

          if strResult <> '' then // Our new specified subject.
            Corres.Subject := strResult
          else // Default Subject / Pre set
            Corres.Subject := ReportType + ' for ' + cboCusID.Text;

          Corres.RecipientList := RecipientAddress;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

          OutGoingFileName := getOutGoingFileName('' ,' ' + ReportType ,'.PDF');
          AssignFile(f,  Commonlib.TempDir  + 'EmailReport.PDF');

          if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
            copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
              PChar( Commonlib.TempDir  + OutGoingFileName), false);
          end;

          // Add our attachment.
          Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
          // Send the Email
          if not EmailShortSendMode(lSilent, lSecret) then
            exit;
          if Corres.Execute(lSilent, lSecret) then begin
            EmailDate := Now;

            qryEmailedList := TERPQuery.Create(nil);
            qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
            try
              qryEmailedList.Sql.Clear;
              qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
                AdoQuery2.FieldByName('PSID').AsString + '","' + IntToStr(AppEnv.Employee.EmployeeID) + '", "' + FormatDateTime(MysqlDateFormat,
                EmailDate) + '", "' + ReportType + '", "' +
                '")');
              qryEmailedList.Execute;

            finally
              DeleteFiles( Commonlib.TempDir , '*.PDF');
              FreeandNil(qryEmailedList);
            end;
          end;

          cmdSave.Enabled := true;
          cmdNew.Enabled := true;
          cmdPrint.Enabled := true;
          cmdCancel.Enabled := true;
          cmdEmail.Enabled := true;

          DeleteFiles( Commonlib.TempDir , '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);

          label8.Visible := false;
        except
          on e: exception do begin

            label8.Visible := false;
            CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning  , [mbOK], 0);

            cmdSave.Enabled := true;
            cmdNew.Enabled := true;
            cmdPrint.Enabled := true;
            cmdCancel.Enabled := true;
            cmdEmail.Enabled := true;
          end;
        end;
//      end;
    finally
      Corres.Free;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TFrmPhSupportPrintOut);
  FormFact.RegisterMe(TfrmPhSupportPrintOut, 'TPhoneSupportGUI_*=ClientID');
end.
