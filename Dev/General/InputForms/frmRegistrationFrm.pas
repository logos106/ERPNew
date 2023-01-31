unit frmRegistrationFrm;
// Date     Version  Who  What
// -------- -------- ---  ------------------------------------------------------
// 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages

interface

uses
  Windows, Forms, BaseFormForm,   MyAccess,ERPdbComponents, Dialogs, DB, MemDS,
  DBAccess, ALXMLDoc, LbCipher, LbClass, wwcheckbox, Grids,
  Wwdbigrd, Wwdbgrid, DBCtrls, StdCtrls, ComCtrls,AdvOfficeStatusBar, Wwdotdot, Wwdbcomb,
  wwdblook, ExtCtrls, Mask, wwdbedit, Wwdbspin, Buttons, DNMSpeedButton, Controls,
  DNMPanel, Variants, Classes, Graphics, Messages, AppEvnts, wwriched,
  wwdbdatetimepicker, Shader;

type
  TfrmRegistration = class(TBaseForm)
    DNMPanel2: TDNMPanel;
    btnContinue: TDNMSpeedButton;
    LbBlowfish: TLbBlowfish;
    PageControl1: TPageControl;
    qryClients: TERPQuery;
    tsAccounts: TTabSheet;
    tsGenerateClient: TTabSheet;
    tsProcess: TTabSheet;
    tsRequest: TTabSheet;
    XMLDocument: TALXMLDocument;
    qryClientsLookup: TERPQuery;
    dsClientLookup: TDataSource;
    dsClients: TDataSource;
    qryLicence: TERPQuery;
    dsLicence: TDataSource;
    qryLicenceClientID: TIntegerField;
    qryLicenceNoClients: TIntegerField;
    qryLicenceContractStart: TDateField;
    qryLicenceAutoInvoice: TStringField;
    qryLicenceTermsSigned: TDateField;
    qryLicenceServerPrice: TFloatField;
    qryLicenceClientPrice: TFloatField;
    qryLicenceInvoiced: TERPQuery;
    dsLicenceInvoiced: TDataSource;
    qrySaleIDLookup: TERPQuery;
    qryLicenceID: TIntegerField;
    qryLicenceInvoiced2: TIntegerField;
    qryLicenceInvoicedExpires: TDateField;
    qryLicenceInvoicedSaleID: TIntegerField;
    qryLicenceInvoicedLicenceID: TIntegerField;
    qryLicenceInvoicedAnnualFee: TCurrencyField;
    qryLicenceYearlyMaintenancePercent: TIntegerField;
    Shape4: TShape;
    Label29: TLabel;
    PrintDialog1: TPrintDialog;
    tblCompanyInformation: TMyTable;
    qryInvoiced: TERPQuery;
    qryLicenceInvoicedLicence: TStringField;
    qryLicenceAnnualFee: TCurrencyField;
    qryLicenceExpires: TDateField;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Shape1: TShape;
    Label26: TLabel;
    Shape2: TShape;
    Label27: TLabel;
    Shape3: TShape;
    Label28: TLabel;
    Shape5: TShape;
    Label30: TLabel;
    Shape6: TShape;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    memExistingCode: TMemo;
    Button1: TDNMSpeedButton;
    memEmail: TMemo;
    Memo1: TMemo;
    btnPrintAgreementForm: TDNMSpeedButton;
    memAgreementForm: TMemo;
    seNoClientSlots: TwwDBSpinEdit;
    btnProcessEmail: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    memRenewedCode: TMemo;
    btnStoreLicence: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    Label14: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbxml: TLabel;
    lbTblLicence: TLabel;
    lbxmlOut: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    lbKey: TLabel;
    btnEncode: TDNMSpeedButton;
    edClientID: TLabeledEdit;
    luClientSystem: TwwDBLookupCombo;
    cbInvoiceSelect: TwwDBComboBox;
    memDecodedLicence: TMemo;
    edLicence: TEdit;
    dtExpires: TDateTimePicker;
    edCompanyName: TLabeledEdit;
    edMID: TLabeledEdit;
    edLicenceID: TLabeledEdit;
    edNoClientSlots: TLabeledEdit;
    edNoMultiSites: TLabeledEdit;
    cbViewInternals: TCheckBox;
    DNMPanel5: TDNMPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    luClient: TwwDBLookupCombo;
    edBalance: TDBEdit;
    grdLicences: TwwDBGrid;
    cbAutoInvoice: TwwCheckBox;
    wwDBGrid2: TwwDBGrid;
    cbSaleID: TwwDBComboBox;
    wwExpandButton1: TwwExpandButton;
    cbLicence: TwwDBComboBox;
    Label23: TLabel;
    Shape7: TShape;
    Label38: TLabel;
    Shape8: TShape;
    Label39: TLabel;
    Label40: TLabel;
    qryLicenceTodoIssued: TDateTimeField;
    qryLicenceActive: TStringField;
    Label41: TLabel;
    Label42: TLabel;
    cbActive: TwwCheckBox;
    btnAccountList: TDNMSpeedButton;
    qryLicenceLocation: TStringField;
    qryLicenceNotes: TMemoField;
    Notes: TwwDBRichEdit;
    qryLicenceNextReminderDate: TDateTimeField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure memDecodedLicenceChange(Sender: TObject);
    procedure btnDecodeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEncodeClick(Sender: TObject);
    procedure memRenewedCodeChange(Sender: TObject);
    procedure btnStoreLicenceClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure luClientChange(Sender: TObject);
    procedure qryLicenceBeforePost(DataSet: TDataSet);
    procedure cbAutoInvoiceClick(Sender: TObject);
    procedure qryLicenceAfterScroll(DataSet: TDataSet);
    procedure qryLicenceInvoicedBeforePost(DataSet: TDataSet);
    procedure cbSaleIDDropDown(Sender: TObject);
    procedure cbSaleIDCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure qryLicenceInvoicedCalcFields(DataSet: TDataSet);
    procedure wwExpandButton1BeforeExpand(Sender: TObject);
    procedure btnPrintAgreementFormClick(Sender: TObject);
    procedure wwExpandButton1BeforeCollapse(Sender: TObject);
    procedure btnProcessEmailClick(Sender: TObject);
    procedure cbInvoiceSelectDropDown(Sender: TObject);
    procedure cbInvoiceSelectChange(Sender: TObject);
    procedure cbViewInternalsClick(Sender: TObject);
    procedure qryLicenceTermsSignedValidate(Sender: TField);
    procedure grdLicencesExit(Sender: TObject);
    procedure qryLicenceCalcFields(DataSet: TDataSet);
    procedure grdLicencesColExit(Sender: TObject);
    procedure qryClientsAfterOpen(DataSet: TDataSet);
    procedure qryLicenceAfterInsert(DataSet: TDataSet);
    procedure btnAccountListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbActiveClick(Sender: TObject);
    procedure Label14DblClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure FeldSetTextDontAllowNulls(Sender: TField;
      const Text: String);
  private
    fbLicenceUpdated: boolean;
    //    fdExpires: TDateTime;
    procedure TabSheetShow(Sender: TObject);
    procedure DecodeLicence;
    procedure EncodeLicence;
    function CheckLicClientID(Const LicID: Integer): Integer;

  public
    ClientMode: boolean;            // true: no system or account tab
    TheServerMID: string;
    destructor Destroy; override;
    //class function Instance: TfrmRegistration;
    property LicenceUpdated: boolean read fbLicenceUpdated;
  end;

implementation

uses
  CommonLib, CommonDbLib, RegistrationLib, Printers, DnMLib, DateUtils, 
  frmRegoAccountList, SysUtils, tcMessaging, MAIN,FastFuncs,
  AppEnvironment, dmMainGUI, tcConst;

{$R *.dfm}

{ TfrmRegistration }

destructor TfrmRegistration.Destroy;
begin
  inherited;
end;


//class function TfrmRegistration.Instance: TfrmRegistration;
//begin
//  if not Assigned(frmRegistration) then frmRegistration := TfrmRegistration.Create(nil);
//  Result := frmRegistration;
//  Result.fbLicenceUpdated := false;
//end;

procedure TfrmRegistration.Button1Click(Sender: TObject);
var 
  memo: TMemo;
begin
  memo := TMemo.Create(nil);
  memo.Visible := false;
  memo.Parent := self;
  try
    memo.Lines.Text := memEmail.Lines.Text + memExistingCode.Lines.Text;
    memo.Lines.Text := FastFuncs.AnsiStringReplace(memo.Lines.Text, '<&Date/>', FormatDateTime('dd.mm.yyyy', Date), [rfReplaceAll,rfIgnoreCase]);
    memo.Lines.Text := FastFuncs.AnsiStringReplace(memo.Lines.Text, '<&CompanyName/>', CommonDbLib.GetCompanyName, [rfReplaceAll,rfIgnoreCase]);
    memo.Lines.Text := FastFuncs.AnsiStringReplace(memo.Lines.Text, '<&ClientSlots/>', seNoClientSlots.Text, [rfReplaceAll,rfIgnoreCase]);
    memo.Lines.Text := FastFuncs.AnsiStringReplace(memo.Lines.Text, '<&PaymentDetails/>', memo1.Text, [rfReplaceAll,rfIgnoreCase]);
    memo.SelectAll;
    memo.CopyToClipboard;
  finally
    FreeandNil(memo);
  end;
end;

procedure TfrmRegistration.DecodeLicence;
var 
  code: string;
  key: string;
  xml: string;
  i: integer;
  p1, p2: integer;
  lic: TALXMLNode;
  ClientID:Integer;

  function attr(const Name: string): string;
  begin
    Result := '';
    if lic.Attributes[Name] <> null then Result := lic.Attributes[Name];
  end; //attr

begin
  inherited;
  p1 := FastFuncs.PosEx('*******>', memDecodedLicence.Text) + 8;
  p2 := FastFuncs.PosEx('<*******', memDecodedLicence.Text) - 1;
  code := '';
  //SetLength(code, p2-p1+1);
  for i := p1 to p2 do if memDecodedLicence.Text[i] > ' ' then code := code + memDecodedLicence.Text[i];
  key := Copy(code, FastFuncs.StrLength(code) - 7, 8);
  lbKey.Caption := key;
  lbBlowfish.GenerateKey(key + key);
  xml := '';
  xml := lbBlowfish.DecryptString(Copy(code, 1, FastFuncs.StrLength(code) - 8));

  lbxml.Caption := xml;

  XMLDocument.XML.Text := xml;
  XMLDocument.Active := true;
  lic := XMLDocument.DocumentElement;

  edClientID.Text := attr('clientid');
  edMID.Text := key;
  edLicenceID.Text := attr('licenceid');
  edCompanyName.Text := attr('companyname');

  ClientID := CheckLicClientID(StrToIntDef(edLicenceID.Text,0));
  if (ClientID<>0) AND (StrToIntDef(edClientID.Text,0)<>ClientID) then
    edClientID.Text := FastFuncs.IntToStr(ClientID);

  luClientSystem.Enabled := edMID.Text > '';
  cbInvoiceSelect.Enabled := edMID.Text > '';

  qryClientsLookup.Open;
  if qryClientsLookup.Locate('ClientID', edClientID.Text, []) then begin
    luClientSystem.Text     := qryClientsLookup.FieldByName('company').AsString;
    luClientSystem.Enabled  := false;
    cbInvoiceSelect.Visible := false;
  end;
end; //DecodeLicence


procedure TfrmRegistration.EncodeLicence;

  function EscapeForXML(const s: string): string;
  var 
    i: integer;
    ch: string;
  begin
    for i := 1 to FastFuncs.StrLength(s) do begin
      case s[i] of
        '&': ch := '&amp;';
        '<': ch := '&lt;';
        '>': ch := '&gt;';
        '''': ch := '&apos;';
        '"': ch := '&quot;';
        else ch := s[i];
      end;
      Result := Result + ch;
    end;
  end;
var 
  xml: string;
  sql: string;
  memo: TMemo;
  i: integer;
begin
  memo := TMemo.Create(nil);
  memo.Visible := false;
  memo.Parent := self;
  try
    lbBlowfish.GenerateKey(lbkey.Caption + lbkey.Caption);
    xml := '<Licence' + ' machineid="' + edMID.Text + '"' + ' licence="' + edLicence.Text + '"' +
      ' licenceid="' + edlicenceID.Text + '"' + ' clientid="' + edClientID.Text + '"' + ' noclientslots="' +
      edNoClientSlots.Text + '"' + ' nomultisites="' + edNoMultisites.Text + '"' + ' companyname="' +
      EscapeForXML(edCompanyName.Text) + '"' + ' begins="' + FormatDateTime(MysqlDateFormat,
      Date) + '"' + ' expires="' + FormatDateTime(MysqlDateFormat, dtExpires.Date) + '"' + '/>';
    lbxmlOut.Caption := xml;
    with TStringList.Create do begin
      Text:= xml;
      savetofile(ExtractFilePath(Application.ExeName) + 'Licence_xml.txt');
      free;
    end;
    xml := lbBlowfish.EncryptString(xml){ + edMID.Text};

    with memo.Lines do begin
      Add('To ' + luClientSystem.Text);
      Add('ERP Licence for   Server ' + edCompanyName.Text);
      Add(''); 
      Add(''); 
      Add('To process click Menu "Help | Register" and follow instructions');
      Add('');    
      Add('COPY FROM HERE >>');
      Add('************ Do not change text from here on *****************>');
      Add('');
      i := 1;
      while i <= FastFuncs.StrLength(xml) do begin
        Add(Copy(xml, i, 50));
        Inc(i, 50);
      end;
      Add('');
      Add('<*********** Do not change text before this ******************');
      Add('<< TO HERE');
      Add('');
    end;

    memo.SelectAll;
    memo.CopyToClipboard;

    sql := Format('INSERT HIGH_PRIORITY INTO tbllicencehistory SET ' +
      'Issued="%s", LicenceID="%s", UserID="%d", ServerMID="%s", LicenceXML="%s";',
      [FormatDateTime(MysqlDateTimeFormat, Now), edlicenceID.Text, AppEnv.Employee.EmployeeID, lbKey.Caption,
      FastFuncs.AnsiStringReplace(lbxmlOut.Caption, '"', '\"', [rfReplaceAll,rfIgnoreCase])]);
    CommonDbLib.GetSharedMyDacConnection.ExecSQL(sql, []);
  finally
    FreeandNil(memo);
  end;
end; //EncodeLicence

procedure TfrmRegistration.memDecodedLicenceChange(Sender: TObject);
begin
  try
    DecodeLicence;
    btnDecodeClick(Sender);
  except
    on Exception do CommonLib.MessageDlgXP_Vista('Invalid licence code', mtInformation , [mbOK], 0);
  end;
end;

procedure TfrmRegistration.btnDecodeClick(Sender: TObject);
var 
  validLicence: boolean;
  dayInLicence: integer;
  ValidLicenceCount: integer;
  fYear, fMonth, fDay: word;
  ContractAnnDate: TDateTime;
begin
  validLicence := false;
  lbTblLicence.Caption := Format('ClientID %s no Licence Data', [edClientID.Text]);

  with qryLicence do begin
    ParamByName('ClientID').AsString := edClientID.Text;
    Open;

    ValidLicenceCount := 0;
    First;
    while not Eof do // active licence records make up serverlicence count
    begin
      if qryLicenceActive.AsString = 'T' then Inc(ValidLicenceCount);
      Next;
    end;

    First;
    while not Eof do begin
      // searching for a specific licecence id for this client
      if qryLicenceID.AsString = edLicenceID.Text then begin      // we have a record in tbllicence
        edNoClientSlots.Text := qryLicenceNoClients.AsString;

        // automatic lincence issuing rules:
        //   issue 60 day licence if date is within 46 days from contractstart
        //   issue first 365 day licence if date is within 365-20 days
        //   issue next 365 day licence if date is after 365*x -2 days
        // All of the above only if account is in balance
        dayInLicence := DaysBetween(Date, qryLicenceContractStart.AsDateTime);
        case dayInLicence of
          0..(46 - 14): 
            begin
              dtExpires.Date := qryLicenceContractStart.AsDateTime + 60;
              edLicence.Text := 'Stage60';
            end;
          (46 - 13)..344:
            begin
              dtExpires.Date := IncYear(qryLicenceContractStart.AsDateTime);
              edLicence.Text := 'Stage365';
            end;
          else begin
              edLicence.Text := 'Stage365+';
              // grant next year licence if today is not earlier than
              // 20 days before current licence runs out
              // otherwise just return current licence (expiry date)
              if (qryLicenceExpires.AsDateTime = 0) then begin
                DecodeDate(qryLicenceContractStart.AsDateTime, fYear, fMonth, fDay);
                ContractAnnDate := EncodeDate(YearOf(Date), fMonth, fDay);
              end else ContractAnnDate := qryLicenceExpires.AsDateTime;

              if (ContractAnnDate - Date < 21.0) then dtExpires.Date := IncYear(ContractAnnDate)
              else dtExpires.Date := ContractAnnDate;
            end
        end;

        edNoMultiSites.Text := FastFuncs.IntToStr(ValidLicenceCount);

        lbTblLicence.Caption := Format('Expiry: %s (Days: %d)',
          [FormatDateTime('dd.mm.yy', dtExpires.Date), Trunc(dtExpires.Date - Date)]);
        qryClients.ParamByName('ClientID').AsInteger := qryLicenceClientID.AsInteger;
        qryClients.Open;
        if qryClients.RecordCount > 0 then begin
          if (RoundCurrency(qryClients.FieldByName('Balance').AsFloat) > 0) then
            lbTblLicence.Caption := lbTblLicence.Caption + Format(' Not in Balance: %1.1m',
              [RoundCurrency(qryClients.FieldByName('Balance').AsFloat)])
          else if qryLicenceActive.AsString <> 'T' then lbTblLicence.Caption :=
              lbTblLicence.Caption + ' Invalid (replaced?)'
          else begin
            if qryLicenceTermsSigned.AsDateTime < qryLicenceContractStart.AsDateTime then
              lbTblLicence.Caption := lbTblLicence.Caption + 'Agreement not signed'
            else if dtExpires.Date < Date then CommonLib.MessageDlgXP_Vista(Format('Calculated Expiry Date invalid: %s',
                [FormatDateTime('dd/mm/yyyy', dtExpires.Date)]), mtError , [mbOK], 0)
            else begin
              validLicence := true;
              dtExpires.Date:= StrToDate(InputBox('Expire Date','Licence Expire Date',FormatDateTime('dd/mm/yyyy',dtExpires.Date)));

              qryLicence.Edit;
              qryLicenceExpires.AsDateTime := dtExpires.Date;
              qryLicence.Post;
            end;
          end
        end else lbTblLicence.Caption := lbTblLicence.Caption + ' Customer not found. Check Customer is Active.';
        Break;
      end;  // if
      Next;
    end; // while
  end;

  btnEncode.Enabled := validLicence and (lbKey.Caption[1] > ' ');
  if btnEncode.Enabled then btnEncodeClick(nil);

  qryClients.Close;
  qryLicence.Close;
     //qryLicenceInvoiced.Close;
end; //btnDecodeClick


procedure TfrmRegistration.FormShow(Sender: TObject);
Var Form : TComponent;
begin
  Self.Enabled := False;
  try
    inherited;
    if CommonDbLib.GetCompanyName = 'Default Company' then begin
      CommonLib.MessageDlgXP_Vista('Please enter Company Information first', mtInformation , [mbOK], 0);
      PostMessage(Handle, WM_Close, 0, 0);

      if not FormStillOpen('TfrmCompanyInformation') then begin
        Form := GetComponentByClassName('TfrmCompanyInformation');
        if Assigned(Form) then begin //if has acess
          with TForm(Form) do begin
            FormStyle := fsmdiChild;
            BringToFront;
          end;
        end;
      end else begin
        with TForm(FindExistingComponent('TfrmCompanyInformation')) do begin
          Show;
          BringToFront;
        end;
      end;

      Exit;
    end;

    PageControl1.ActivePageIndex := 0;
    if ClientMode then begin
      tsGenerateClient.TabVisible := false;
      tsAccounts.TabVisible       := false;
      tsRequest.TabVisible        := true;
      tsProcess.TabVisible        := true;
      if MainForm.GetCurrentUserCount > 1 then begin
        dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Registration';
        dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
        dtmMainGUI.dlgCurrentUsers.Message := 'The Following User(s) Must Exit The System Before Registration.';
        dtmMainGUI.dlgCurrentUsers.Execute;
        PostMessage(Self.Handle, WM_Close, 0, 0);
        Exit;
      end;
    end else begin
      tsRequest.TabVisible        := false;
      tsProcess.TabVisible        := false;
      tsGenerateClient.TabVisible := true;
      tsAccounts.TabVisible       :=  KeyInitializeNoMessage and KeyGenVaildate;
      cbViewInternals.Visible     := tsAccounts.TabVisible;
      if tsAccounts.TabVisible then qryClientsLookup.Open;
    end;

    PageControl1.TabWidth := PageControl1.Width div 2 - 2;
    PerformPaints;
  finally
    Self.Enabled := True;
  end;  
end;

procedure TfrmRegistration.btnEncodeClick(Sender: TObject);
begin
  If (Now()<dtExpires.date) AND (DaysBetween(Now(),dtExpires.date)>365) then dtExpires.date := IncYear(Now());
  EncodeLicence;
end;

procedure TfrmRegistration.memRenewedCodeChange(Sender: TObject);
begin
  btnStoreLicence.Enabled := memRenewedCode.Lines.Text > '';
end;


procedure TfrmRegistration.btnStoreLicenceClick(Sender: TObject);
var
  ServicesClient: TtcServicesClient;
  code: string;
  expires: TDateTime;
  i, p1, p2: integer;
  noclients: integer;
begin
  ServicesClient := TtcServicesClient.Create;
  try
    p1   := FastFuncs.PosEx('*******>', memRenewedCode.Text) + 8;
    p2   := FastFuncs.PosEx('<*******', memRenewedCode.Text) - 1;
    code := '';
    //SetLength(code, p2-p1+1);
    if p1 < 1 then p2 := 1;

    if p2 < 1 then p2 := FastFuncs.StrLength(memRenewedCode.Text);

    for i := p1 to p2 do if memRenewedCode.Text[i] > ' ' then code := code + memRenewedCode.Text[i];

    if not ServicesClient.setLicence(code, expires, noclients) then CommonLib.MessageDlgXP_Vista('Licence Code appears invalid', mtInformation , [mbOK], 0)
    else begin
      MainForm.theExpiryDate := expires;
      MainForm.NoClientSlots := noclients;
      CommonLib.MessageDlgXP_Vista('Licence stored - Please login again', mtInformation , [mbOK], 0);
      fbLicenceUpdated := true;
      MainForm.TerminateApp;  //Application.Terminate;
      Exit;
    end;
    btnStoreLicence.Enabled := false;
  finally
    FreeandNil(ServicesClient);
  end;
end;

procedure TfrmRegistration.btnContinueClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRegistration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TfrmRegistration.luClientChange(Sender: TObject);
var 
  company: string;
begin
  if lbKey.Caption = '' then Exit;
  if Sender = luClientSystem then
    company := luClientSystem.Text
  else
    company := luClient.Text;

  qryClients.Close;
  qryClients.ParamByName('Company').AsString := company;
  qryClients.ParamByName('ClientID').AsInteger := 0;
  qryClients.Open;

  qryLicence.Close;
  qryLicence.ParamByName('ClientID').AsInteger := qryClients.FieldByName('ClientID').AsInteger;
  qryLicence.Open;

  // set cbAutoInvoice from first tbllicence record (they all hold the same autoInvoice)
  if qryLicence.RecordCount > 0 then cbAutoInvoice.Checked := qryLicence.FieldByName('AutoInvoice').AsString = 'T';

  if Sender = luClientSystem then begin
    edClientID.Text      := qryClients.FieldByName('ClientID').AsString;
    cbInvoiceSelect.Text := '';
    cbInvoiceSelect.Items.Clear;
  end;
end; //luClientChange


procedure TfrmRegistration.qryLicenceBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryLicence.FieldByName('ClientID').AsInteger = 0 then
    qryLicence.FieldByName('ClientID').AsInteger := qryClients.FieldByName('ClientID').AsInteger;

  if cbAutoInvoice.Checked then qryLicence.FieldByName('AutoInvoice').AsString := 'T'
  else qryLicence.FieldByName('AutoInvoice').AsString := 'F';
end; //qryLicenceBeforePost

procedure TfrmRegistration.cbAutoInvoiceClick(Sender: TObject);
var 
  bm: TBookmark;
begin
  with qryLicence do if RecordCount > 0 then begin
      bm := GetBookmark;
      First;
      // set all licence records
      while not Eof do begin
        Edit;
        if cbAutoInvoice.Checked then FieldByName('AutoInvoice').AsString := 'T'
        else FieldByName('AutoInvoice').AsString := 'F';
        Post;
        Next;
      end;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
end; //cbAutoInvoiceClick


procedure TfrmRegistration.qryLicenceAfterScroll(DataSet: TDataSet);
begin
  with qryLicenceInvoiced do begin
    Close;
    ParamByName('LicenceID').AsInteger := qryLicence.FieldByName('ID').AsInteger;
    Open;
  end;

  with qrySaleIDLookup do begin
    Close;
    ParamByName('ClientID').AsInteger := qryLicence.FieldByName('ClientID').AsInteger;
    Open;
  end;
end; //qryLicenceAfterScroll


procedure TfrmRegistration.qryLicenceInvoicedBeforePost(DataSet: TDataSet);
begin
  if qryLicenceInvoiced.FieldByName('LicenceID').AsInteger = 0 then
    qryLicenceInvoiced.FieldByName('LicenceID').AsInteger := qryLicence.FieldByName('ID').AsInteger;
end; //qryLicenceInvoicedBeforePost


procedure TfrmRegistration.cbSaleIDDropDown(Sender: TObject);
begin
  cbSaleID.Items.Clear;
  with qrySaleIDLookup do begin
    First;
    while not Eof do begin
      cbSaleID.Items.Add(Format('%d (%s) %1.2m',
        [FieldByName('SaleID').AsInteger,
        FormatDateTime('dd.mm.yyyy', FieldByName('SaleDate').AsDateTime),
        FieldByName('TotalAmount').asCurrency]));  
      Next;
    end;
  end;
end; //cbSaleIDDropDown


procedure TfrmRegistration.cbSaleIDCloseUp(Sender: TwwDBComboBox; Select: boolean);
var 
  i, sid: integer;
begin
  if Select and (Length(cbSaleID.Text) > 0) then begin
    sid := 0;
    i   := 1;
    while cbSaleID.Text[i] in ['0'..'9'] do begin
      sid := sid * 10 + Ord(cbSaleID.Text[i]) - Ord('0');
      Inc(i);
    end;
    qryLicenceInvoiced.Edit;
    qryLicenceInvoiced.FieldByName('SaleID').AsInteger := sid;
  end;
end; //cbSaleIDCloseUp


procedure TfrmRegistration.qryLicenceInvoicedCalcFields(DataSet: TDataSet);
begin
end; //qryLicenceInvoicedCalcFields

                                                      
procedure TfrmRegistration.wwExpandButton1BeforeExpand(Sender: TObject);
begin
  qryLicenceInvoiced.Refresh;
end;


procedure TfrmRegistration.btnPrintAgreementFormClick(Sender: TObject);
var
  I: integer;
  r: TRect;
  s: string;

  function replace(const s: string): string;
  begin
    with tblCompanyInformation do begin
      Result := FastFuncs.AnsiStringReplace(s, '<&CompanyName/>', CommonDbLib.GetCompanyName, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Address1/>', FieldByName('Address').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Address2/>', FieldByName('Address2').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&City/>', FieldByName('City').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&StatePlc/>', FieldByName('State').AsString + ' ' + FieldByName('PostCode').AsString,[rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Country/>', FieldByName('Country').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Phone/>', FieldByName('PhoneNumber').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Fax/>', FieldByName('FaxNumber').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&ABN/>', FieldByName('ABN').AsString, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&Date/>', FormatDateTime('dd.mm.yyyy', Date), [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&ServerMid/>', TheServerMID, [rfReplaceAll,rfIgnoreCase]);
      Result := FastFuncs.AnsiStringReplace(Result, '<&NoClientSlots/>', seNoClientSlots.Text, [rfReplaceAll,rfIgnoreCase]);
    end;
  end; //replace
  
begin  //btnPrintAgreementFormClick
  PrintDialog1.Options := [];
  if PrintDialog1.Execute then with Printer do begin
      tblCompanyInformation.Open;
      r := Rect(300, 300, (Pagewidth - 200), (PageHeight - 200));
      BeginDoc;
      Canvas.Font.Name := 'Courier New';
      Canvas.Font.Size := 12;
      for i := 0 to memAgreementForm.Lines.Count - 1 do begin
        s := replace(memAgreementForm.Lines.Strings[i]);
        Canvas.TextOut(320, 320 + (i * Canvas.TextHeight(s)), s);
      end;
      Canvas.Brush.Color := clBlack;
      Canvas.FrameRect(r);
      EndDoc;
      tblCompanyInformation.Close;
    end;
end; //wwExpandButton1BeforeExpand


procedure TfrmRegistration.wwExpandButton1BeforeCollapse(Sender: TObject);
begin
  if qryLicenceInvoiced.State in [dsEdit, dsInsert] then qryLicenceInvoiced.Post;
end; //wwExpandButton1BeforeCollapse

procedure TfrmRegistration.btnProcessEmailClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
end;

procedure TfrmRegistration.cbInvoiceSelectDropDown(Sender: TObject);
begin
  with qryInvoiced do begin
    Close;
    ParamByName('ClientID').AsString := edClientID.Text;
    Open;
    cbInvoiceSelect.Items.Clear;
    while not Eof do begin
      if (FieldByName('Expires').AsDateTime = 0) and (FieldByName('Active').AsString = 'T') then
        cbInvoiceSelect.Items.AddObject(FieldByName('Company').AsString + ' Clients=' + FieldByName('NoClients').AsString,
          Pointer(FieldByName('ID').AsInteger));

      Next;
    end;
  end;
end;


procedure TfrmRegistration.cbInvoiceSelectChange(Sender: TObject);
begin                        
  edLicenceID.Text := '';
  dtExpires.DateTime := 0.0;
  edNoClientSlots.Text := '';
  with qryInvoiced do begin
    if Locate('ID', integer(cbInvoiceSelect.Items.Objects[cbInvoiceSelect.ItemIndex]), []) then begin
      if cbInvoiceSelect.Items.Count > 1 then if CommonLib.MessageDlgXP_Vista('A licence can only ever be allocated once.' +
          #13 + #10 + '' + #13 + #10 + 'Is the selected licence the one you want? ',
          mtConfirmation, [mbYes, mbCancel], 0) <> mrYes then Exit; //===> EXIT;

      edLicenceID.Text := FieldByName('ID').AsString;
      btnDecodeClick(Sender);
    end;
  end;
end;

procedure TfrmRegistration.cbViewInternalsClick(Sender: TObject);
var 
  i: integer;
begin
  for i := 0 to self.ComponentCount - 1 do if (self.Components[i].Tag = 1) and (Components[i] is TControl) then
      TControl(self.Components[i]).Visible := cbViewInternals.Checked;
end;

procedure TfrmRegistration.qryLicenceTermsSignedValidate(Sender: TField);
begin
  if qryLicenceTermsSigned.AsDateTime > 0.0 then if qryLicenceTermsSigned.AsDateTime < qryLicenceContractStart.AsDateTime then
      //raise Exception.Create('Terms Signed earlier than Contract Start - please adjust');
      CommonLib.MessageDlgXP_Vista('Terms Signed earlier than Contract Start - please adjust', mtError, [mbOK], 0); 
end;

procedure TfrmRegistration.grdLicencesExit(Sender: TObject);
begin
  inherited;
  If grdLicences.DataSource.DataSet.Active then
    grdLicences.DataSource.DataSet.Last;
end;

procedure TfrmRegistration.qryLicenceCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryLicenceAnnualFee.AsCurrency :=
    (qryLicenceServerPrice.AsCurrency + (qryLicenceClientPrice.asCurrency * (qryLicenceNoClients.AsInteger - 3)))
    * qryLicenceYearlyMaintenancepercent.AsInteger / 100;
end;

procedure TfrmRegistration.grdLicencesColExit(Sender: TObject);
begin
  inherited;
  if grdLicences.DataSource.State in [dsEdit, dsInsert] then qryLicenceCalcFields(nil);
end;

procedure TfrmRegistration.qryClientsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(qryClients.FieldByName('Balance')).currency := true;
end;

procedure TfrmRegistration.qryLicenceAfterInsert(DataSet: TDataSet);
begin
  inherited;
  cbActive.Checked := true;
end;

procedure TfrmRegistration.btnAccountListClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmRegoAccountListGUI') then begin
    Form := GetComponentByClassName('TfrmRegoAccountListGUI');
    if Assigned(Form) then begin //if has acess
      TfrmRegoAccountListGUI(Form).FormStyle := fsMDIChild;
    end;
  end else begin
    TfrmRegoAccountListGUI(GetComponentByClassName('TfrmRegoAccountListGUI')).show;
  end;
  Close;
end;

procedure TfrmRegistration.FormCreate(Sender: TObject);
var
  ControlIndex,Index :Integer;

  procedure SetPanelProperties(const Panel: TDNMPanel);
  var
    fIndex: Integer;
  begin
    Panel.Transparent := False;
    Panel.Color := TitleShader.FromColor;
    for fIndex := 0 to Panel.ControlCount - 1 do begin
      if Panel.Controls[fIndex] is TDNMPanel then
        SetPanelProperties(TDNMPanel(Panel.Controls[fIndex]));
    end;
  end;

begin
  inherited;
  qryClientsLookup.Connection := GetSharedMyDacConnection;
  qryLicence.Connection := GetSharedMyDacConnection;
  qryClients.Connection := GetSharedMyDacConnection;
  qryLicenceInvoiced.Connection := GetSharedMyDacConnection;
  qrySaleIDLookup.Connection := GetSharedMyDacConnection;
  tblCompanyInformation.Connection := GetSharedMyDacConnection;
  qryInvoiced.Connection := GetSharedMyDacConnection;
  fbLicenceUpdated := false;
  TitleShader.FromColor := GetGradientColor(Self.ClassName).Color;
  TitleShader.ToColorMirror := TitleShader.FromColor;

  for Index := 0 to ComponentCount - 1 do
    if Components[Index] is TPageControl then begin
      TPageControl(Components[Index]).OwnerDraw := true;
      TPageControl(Components[Index]).OnDrawTab := PageControl1DrawTab;
      for ControlIndex := 0 to TTabSheet(Components[Index]).ControlCount - 1 do begin
        if TTabSheet(Components[Index]).Controls[ControlIndex] is TDNMPanel then
          SetPanelProperties(TDNMPanel(TTabSheet(Components[Index]).Controls[ControlIndex]));
      end;
    end;      

end;

procedure TfrmRegistration.cbActiveClick(Sender: TObject);
begin
  inherited;
  if cbActive.Checked then begin
    if (qryLicenceContractStart.AsDateTime = 0) then begin
      qryLicence.Edit;
      qryLicenceActive.AsBoolean := false;
      CommonLib.MessageDlgXP_Vista('Please Set Contract Dates', mtWarning, [mbOK], 0);
    end;
    if (qryLicenceContractStart.AsDateTime > Now()) then begin
      qryLicence.Edit;
      qryLicenceActive.AsBoolean := false;
      CommonLib.MessageDlgXP_Vista('Cannot Set Active Until Contract Date', mtWarning, [mbOK], 0);
    end;
    if (qryLicenceTermsSigned.AsDateTime < qryLicenceContractStart.AsDateTime) then begin
      qryLicence.Edit;     
      qryLicenceActive.AsBoolean := false;
      CommonLib.MessageDlgXP_Vista('Please Set Terms Signed Dates', mtWarning, [mbOK], 0);
    end;
  end;
end;

function TfrmRegistration.CheckLicClientID(Const LicID: Integer): Integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID,ClientID FROM tbllicence WHERE ID='+FastFuncs.IntToStr(LicID)+';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('ClientID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmRegistration.Label14DblClick(Sender: TObject);
begin
  inherited;
  dtExpires.enabled := True;
end;

procedure TfrmRegistration.FormPaint(Sender: TObject);
var
  Index:Integer;
begin
  inherited;
  for Index := 0 to ComponentCount - 1 do
    if (Components[Index] is TPageControl) and Assigned(TPageControl(Components[Index]).ActivePage) then
      TabSheetShow(TPageControl(Components[Index]).ActivePage);
end;

procedure TfrmRegistration.TabSheetShow(Sender: TObject);
var
  TabSheetRect: TRect;
  PageControlRect: TRect;
  Bitmap: TBitmap;
  fCanvas: TControlCanvas;
begin
  Bitmap := TBitmap.Create;
  fCanvas := TControlCanvas.Create;
  try
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := TitleShader.FromColor;
    Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
    TabSheetRect := TTabSheet(Sender).ClientRect;
    fCanvas.Control := TTabSheet(Sender);
    fCanvas.Brush.Bitmap := Bitmap;
    fCanvas.FillRect(TabSheetRect);
    fCanvas.Control := TTabSheet(Sender).PageControl;
    fCanvas.Brush.Bitmap := Bitmap;
    PageControlRect := fCanvas.Control.ClientRect;
    PageControlRect.Left := TTabSheet(Sender).Left - 2;
    PageControlRect.Top := TTabSheet(Sender).Top - 2;
    PageControlRect.Right := PageControlRect.Right - 2;
    PageControlRect.Bottom := PageControlRect.Bottom - 2;
    fCanvas.FillRect(PageControlRect);
  finally
    FreeAndNil(Bitmap);
    FreeAndNil(fCanvas);
  end;
end;

procedure TfrmRegistration.PageControl1DrawTab(Control: TCustomTabControl;  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  TmpRect: TRect;
  Bitmap: TBitmap;

  Function FindPageforTabIndex( pagecontrol: TPagecontrol; tabindex: Integer ): TTabSheet;
  Var
    i: Integer;
  Begin
    Assert( Assigned( pagecontrol ));
    Assert( (tabindex >= 0) and (tabindex < pagecontrol.pagecount ));
    Result := nil;
    For i:= 0 To pagecontrol.pagecount-1 Do
      If pagecontrol.pages[i].tabVisible Then Begin
        Dec( tabindex );
        If tabindex < 0 Then Begin
          result := pagecontrol.pages[i];
          break;
        End;
      End;
  end;


begin
  Bitmap := TBitmap.Create;
  try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := TitleShader.FromColor;
    Bitmap.Canvas.FillRect(Classes.Rect(0, 0, 300, 300));

    Control.Canvas.Brush.Bitmap := Bitmap;
    TmpRect := Control.ClientRect;
    TmpRect.Left := ((TPageControl(Control).TabWidth * TPageControl(Control).PageCount) div TPageControl(Control).RowCount) + 4;
    TmpRect.Bottom := Rect.Bottom - 4;
    Control.Canvas.FillRect(TmpRect);
    TmpRect := Rect;
    TmpRect.Bottom := TmpRect.Bottom + 2;
    Control.Canvas.FillRect(TmpRect);
    TmpRect.Bottom := TmpRect.Bottom - 2;

    if Active then
        Control.Canvas.Font.Color := clNavy;

    Control.Canvas.Brush.Style := bsClear;

    DrawText(Control.Canvas.Handle, PChar(FindPageforTabIndex(TPageControl(Control),TabIndex).Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TfrmRegistration.FeldSetTextDontAllowNulls(Sender: TField;
      const Text: String);
begin
  inherited;
  if text = '' then
    Sender.AsString:= '0'
  else
    Sender.AsString:= text;
end;


initialization
  RegisterClassOnce(TfrmRegistration);
end.



