unit EmployeeDocumentsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, DNMPanel, BusObjEmployeePay, DNMSpeedButton,frmAttachments,
  kbmMemTable, OleServer, Word2000, frmBase, BusObjBase, WordXP, wwdblook, MessageConst,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, ComCtrls, HTMLUn2, HtmlView, IdMessage,
  FileAssociationDetails, ProgressDialog,BaseInputForm, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmEmployeeDocuments = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSReference: TDataSource;
    qryDocPath: TERPQuery;
    WordApplication1: TWordApplication;
    pnlDocumentsInner: TDNMPanel;
    Splitter1: TSplitter;
    pnlDocumentsList: TDNMPanel;
    Label2: TLabel;
    grdCorrespondence: TwwDBGrid;
    btnDeleteCorrespondence: TwwIButton;
    btnGetEmails: TDNMSpeedButton;
    chkShowInactiveCorrespondence: TCheckBox;
    pnlDocumentsMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    Letterbtn: TDNMSpeedButton;
    Emailbtn: TDNMSpeedButton;
    btnFax: TDNMSpeedButton;
    chkShowAllCorrespondence: TCheckBox;
    qryreference: TERPQuery;
    qryreferenceRef_Date: TDateTimeField;
    qryreferenceRef_type: TWideStringField;
    qryreferenceReferencetxt: TWideStringField;
    qryreferenceRefID: TAutoIncField;
    qryreferenceContactID: TIntegerField;
    qryreferenceCusID: TIntegerField;
    qryreferenceSupID: TIntegerField;
    qryreferenceEmployeeID: TIntegerField;
    qryreferenceEditedFlag: TWideStringField;
    qryreferenceOtherContactID: TIntegerField;
    qryreferenceGlobalRef: TWideStringField;
    qryreferenceLoyaltyProgram: TWideStringField;
    qryreferencemsTimeStamp: TDateTimeField;
    qryreferencemsUpdateSiteCode: TWideStringField;
    qryreferenceActive: TWideStringField;
    qryreferenceReferenceData: TBlobField;
    qryreferenceMessageId: TWideStringField;
    qryreferenceMessageFrom: TWideStringField;
    qryreferenceMessageTo: TWideStringField;
    btnSMS: TDNMSpeedButton;
    qryreferenceStatus: TWideStringField;
    procedure LetterbtnClick(Sender: TObject);
    procedure EmailbtnClick(Sender: TObject);
    procedure btnFaxClick(Sender: TObject);
//    procedure qryreferenceAfterOpen(DataSet: TDataSet);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure btnDeleteCorrespondenceClick(Sender: TObject);
    procedure grdCorrespondenceDblClick(Sender: TObject);
    procedure chkShowInactiveCorrespondenceClick(Sender: TObject);
    procedure chkShowAllCorrespondenceClick(Sender: TObject);
    procedure grdCorrespondenceRowChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure btnGetEmailsClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    MailProgesss: TProgressDialog;
    ProgressCanceled: boolean;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure CheckForEmails;
    procedure DoOnCheckForEmailsProgress(const msg: string; var Continue: boolean);
    procedure DoOnGetMessageCount(const MessageCount: integer);
    procedure DoOnProgressCancel(Sender: TObject);
    procedure ShowHRForm;
  public
    Procedure RefreshLookup;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    Procedure RefreshQuery;
  end;

implementation

{$R *.dfm}
uses
  (*frmEmpReferenceFrm,*)CommonLib,AppEnvironment,remainClientFrm,
  FastFuncs, BusObjConst, ShellAPI, SystemLib, IdText, IdAttachmentFile,
  IdAttachmentMemory, IdHTTP, IdAttachment, ContentTypeObj, HTTPUtil,
  MailReaderObj, BusObjEmailConfig, EmailConst, frmEmployeeCorrespondenceCreate,
  tcTypes, SMSMessageObj, frmMobileNumberInput, SMSUtils, CorrespondenceObj,
  SMSUtilsGui, HTTPConst, DocReaderObj;

procedure TfrmEmployeeDocuments.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TfrmEmployeeDocuments.btnDeleteCorrespondenceClick(Sender: TObject);
begin
  inherited;
  if not SubEmpPay.EmployeeCorrespondence.Active then begin
    MessageDlgXP_Vista('This document is already deleted', mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  SubEmpPay.EmployeeCorrespondence.Active := False;
  SubEmpPay.EmployeeCorrespondence.PostDb;
end;

procedure TfrmEmployeeDocuments.LetterbtnClick(Sender: TObject);
//Var Form : TComponent;
begin
 (* if not Assigned(SubEmpPay) then exit;
  Form := GetComponentByClassName('TfrmEmpReference');
  if Assigned(Form) then begin
    with TfrmEmpReference(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
      TitleLabel.Caption := 'Letter To Employee';
      CorrespondenceType := 'Letter';
      //EmployeeID.Text := IntToStr(SubEmpPay.EmployeeDetails.ID);
      EmpID := SubEmpPay.EmployeeDetails.ID;
      CorrespondenceDate := Date;
      EmailID := '';
      FaxNumber := '';
      KeyID := 0;
      Refresh;
    end;
  end;*)
  empCreateCorrespondence(ctLetter,nil , nil, SubEmpPay.EmployeeDetails.EmployeeName);
end;

procedure TfrmEmployeeDocuments.PerformStartup(var Msg: TMessage);
begin
  if not Assigned(SubEmpPay) then exit;
end;
procedure TfrmEmployeeDocuments.ShowHRForm;
begin
  TDocReaderObj.ShowHRForm(nil,self,SubEmpPay.EmployeeCorrespondence.ID , 'PDF');
end;
procedure TfrmEmployeeDocuments.grdCorrespondenceDblClick(Sender: TObject);
var
  FileNamedocx,FileName: OleVariant;
  sRef: string;
  Form : TComponent;
  EmailFileName: string;
  IdMessage: TIdMessage;
  Stream : TStream;
begin
  inherited;
  if not Assigned(SubEmpPay) then exit;
  if SubEmpPay.EmployeeCorrespondence.HRFormID >0 then begin
    ShowHRForm;
    exit;
  end;
  if SameText(SubEmpPay.EmployeeCorrespondence.Ref_Type, 'Email') and (SubEmpPay.EmployeeCorrespondence.MessageId <> '') then begin
    { this is an email }
    EmailFileName := SystemLib.GetAppTempDir + '\' + SubEmpPay.EmployeeCorrespondence.MessageId + '.eml';
    IdMessage := TIdMessage.Create;
    try
      Stream := SubEmpPay.EmployeeCorrespondence.Dataset.CreateBlobStream(SubEmpPay.EmployeeCorrespondence.Dataset.FieldByName('ReferenceData'),bmRead);
      try
        IdMessage.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      IdMessage.SaveToFile(EmailFileName);
    finally
      IdMessage.Free;
    end;
    ShellExecute(Handle, 'Open', PChar(EmailFileName), '', '', SW_SHOWNORMAL);
    exit;
  end;

  sRef := SubEmpPay.EmployeeCorrespondence.Referencetxt;
  if Empty(sRef) then Exit;
  if qryDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := qryDocPath.FieldByName('DocumentPath').AsString + '\' + SRef
  else FileName := 'C:\' + SRef;

  if AppEnv.Employee.UseWord then Begin
    FileNamedocx := FileName + '.docx';
    FileName := FileName + '.doc'
  end else
    FileName := FileName + '.RTF';

  if FileExists(FileNamedocx) then
    FileName := FileNamedocx;

  if not FileExists(FileName) then begin
    CommonLib.MessageDlgXP_Vista('Cannot Find File !', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.Employee.UseWord then begin
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
    WordApplication1.Connect;
    WordApplication1.Visible := true;
    WordApplication1.Documents.Open(FileName, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam,EmptyParam,EmptyParam,EmptyParam);
    WordApplication1.Documents.Save(EmptyParam, EmptyParam);
    WordApplication1.Activate;
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
  end else begin
    FileName := FileName + '.RTF';
    Form := GetComponentByClassName('TREMainClient');
    if Assigned(Form) then begin //if has acess
      with TREMainClient(Form) do begin
        Referencetxt.Text := SRef;
        Edit1.Text := 'True';
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TfrmEmployeeDocuments.grdCorrespondenceRowChanged(Sender: TObject);
var
  stream: TStream;
  str: string;
  PartContent: TContentType;
  x: integer;
  BodyFound: boolean;
  Item: TListItem;
  ImageIndex: integer;
  SMSMsg: TSMSMessage;
begin
  inherited;
  HTMLViewer.Clear;
  lvAttachments.Clear;
  FileAssociationDetails.Clear;
  lvAttachments.SmallImages := FileAssociationDetails.Images;
  if SameText(grdCorrespondence.DataSource.DataSet.FieldByName('Ref_Type').AsString,'Email') and (SubEmpPay.EmployeeCorrespondence.MessageId <> '') then begin
    if not Assigned(SelectedMail) then begin
      SelectedMail := TIdMessage.Create(self);
    end;
    Stream := SubEmpPay.EmployeeCorrespondence.Dataset.CreateBlobStream(SubEmpPay.EmployeeCorrespondence.Dataset.FieldByName('ReferenceData'),bmRead);
    try
      SelectedMail.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;

    if SelectedMail.MessageParts.Count > 0 then begin
      BodyFound := false;
      PartContent := TContentType.Create;
      try
        for x := 0 to SelectedMail.MessageParts.Count -1 do begin
          PartContent.AsString := SelectedMail.MessageParts[x].ContentType;
          if SelectedMail.MessageParts[x] is TIdText then begin
            if (PartContent.SubType = 'html') and (not BodyFound) then begin
              BodyFound := true;
              HTMLViewer.LoadFromString(TIdText(SelectedMail.MessageParts[x]).Body.Text);
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentFile(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentMemory then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentMemory(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end;
        end;
      finally
        PartContent.Free;
      end;

    end
    else begin
      { not a multipart message, display body text. }
      { remove illegal characters and replace CR LF with <BR> }
      str := StringReplace(HTTPUtil.HTMLEscape(SelectedMail.Body.Text),#13#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10#13,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#13,'<BR>',[rfReplaceAll]);

      HTMLViewer.LoadFromString(str);
    end;

  end
  else if SameText(grdCorrespondence.DataSource.DataSet.FieldByName('Ref_Type').AsString,'SMS') then begin
    FreeAndNil(SelectedMail);
    SMSMsg := TSMSMessage.Create;
    Stream := grdCorrespondence.DataSource.DataSet.CreateBlobStream(grdCorrespondence.DataSource.DataSet.FieldByName('ReferenceData'),bmRead);
    try
      SMSMsg.ReadFromStream(stream);
      HtmlViewer.LoadFromString(SMSMsg.AsHtml);
    finally
      SMSMsg.Free;
      stream.Free;
    end;
  end
  else begin
    FreeAndNil(SelectedMail);
    if SameText(SubEmpPay.EmployeeCorrespondence.Ref_Type,'Email') then begin
      HTMLViewer.LoadFromString(EmailConst.EmailContentNotAvailable);
    end;

  end;
  if lvAttachments.Items.Count > 0 then begin
    lvAttachments.Visible := true;
    HTMLViewer.Height := lvAttachments.Top - 3;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      FileAssociationDetails.AddFile(lvAttachments.Items[x].Caption);
    end;
    FileAssociationDetails.GetFileIconsAndDescriptions;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      ImageIndex := FileAssociationDetails.Extensions.IndexOf(ExtractFileExt(lvAttachments.Items[x].Caption));
      lvAttachments.Items[x].ImageIndex := ImageIndex;
    end;

  end
  else begin
    lvAttachments.Visible := false;
    HTMLViewer.Height := lvAttachments.Top + lvAttachments.Height;
  end;
end;

procedure TfrmEmployeeDocuments.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
  if SameText(grdCorrespondence.DataSource.DataSet.FieldByName('Ref_Typ').AsString,'Voice') then
    SMSUtilsGui.PlayMessages(SRC)
  else
    ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL)
end;

procedure TfrmEmployeeDocuments.HtmlViewerImageRequest(Sender: TObject;
  const SRC: string; var Stream: TStream);
var
  MessageId: string;
  HTTP: TIdHTTP;
  x: integer;
begin
  inherited;
  Stream := nil;
  HTMLImageStream.Clear;
  if Assigned(SelectedMail) then begin
    if Pos('cid:',LowerCase(SRC)) = 1 then begin
      { looking for content id from part of this message }
      MessageId := Copy(SRC,5,Length(SRC));

      for x := 0 to SelectedMail.MessageParts.Count -1 do begin
        if Pos(MessageId, SelectedMail.MessageParts[x].ContentID) > 0 then begin
          if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            TIdAttachmentFile(SelectedMail.MessageParts[x]).SaveToStream(HTMLImageStream);
            HTMLImageStream.Position := 0;
            Stream := HTMLImageStream;
          end;
          break;
        end;
      end;
    end
    else if Pos('http',LowerCase(SRC)) = 1 then begin
      { external image request }
      HTTP:= TIDHTTP.Create(nil);
      try
        HTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
        HTTP.Get(SRC,HTMLImageStream);
        try
          HTMLImageStream.Position := 0;
          if HTMLImageStream.Size > 0 then
            Stream := HTMLImageStream;
        except

        end;
      finally
        HTTP.Free;
      end;
    end;
  end;
end;

procedure TfrmEmployeeDocuments.EmailbtnClick(Sender: TObject);
begin
  empCreateCorrespondence(tcTypes.ctEmail,nil, nil, SubEmpPay.EmployeeDetails.EmployeeName);
(*var
  Form:TComponent;
begin
  if not Assigned(SubEmpPay) then exit;
  Form := GetComponentByClassName('TfrmEmpReference',false,self.DNMPanel1.Parent.Owner);
  if Assigned(Form) then begin
    with TfrmEmpReference(Form) do begin
      FormStyle := fsMDIChild;
      AttachObserver(self.DNMPanel1.Parent.Owner);
      BringToFront;
      TitleLabel.Caption := 'Email To Employee';
      CorrespondenceType := 'Email';
      //EmployeeID.Text := IntToStr(SubEmpPay.EmployeeDetails.ID);
      EmpID := SubEmpPay.EmployeeDetails.ID;
      CorrespondenceDate := now;
      if SubEmpPay.EmployeeDetails.Email  <> '' then EmailID := SubEmpPay.EmployeeDetails.Email
      else EmailID := 'Email';
      FaxNumber := '';
      Refresh;
    end;
  end;*)
end;

procedure TfrmEmployeeDocuments.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
  SelectedMail := nil;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  btnSMS.Enabled := AppEnv.CompanyPrefs.SMSEnabled;
end;

procedure TfrmEmployeeDocuments.FormDestroy(Sender: TObject);
begin
  HTMLImageStream.Free;
  FileAssociationDetails.Free;
  inherited;
end;

procedure TfrmEmployeeDocuments.btnFaxClick(Sender: TObject);
begin
  empCreateCorrespondence(ctfax,nil, nil, SubEmpPay.EmployeeDetails.EmployeeName);
(*var
  Form:TComponent;
begin
  if not Assigned(SubEmpPay) then exit;
  Form := GetComponentByClassName('TfrmEmpReference');
  with TfrmEmpReference(Form) do begin
    FormStyle := fsMDIChild;
    BringToFront;

    TitleLabel.Caption := 'Fax To Employee';
    CorrespondenceType := 'Fax';
    //EmployeeID.Text := IntToStr(SubEmpPay.EmployeeDetails.ID);
    EmpID := SubEmpPay.EmployeeDetails.ID;
    CorrespondenceDate := date;
    EmailID := '';
    if  SubEmpPay.EmployeeDetails.Faxnumber <> '' then
      TfrmEmpReference(Form).FaxNumber := SubEmpPay.EmployeeDetails.Faxnumber
    else
      FaxNumber := 'FaxNumber';

    Refresh;
  end;*)
end;

procedure TfrmEmployeeDocuments.btnGetEmailsClick(Sender: TObject);
begin
  inherited;
  CheckForEmails;
end;

procedure TfrmEmployeeDocuments.CheckForEmails;
var
  MailReader: TMailReader;
  MailConfig: TEmailConfig;
  msg: string;
begin
  FreeAndNil(MailProgesss);
  MailProgesss := TProgressDialog.Create(self);
  MailProgesss.MaxValue := 100;
  MailProgesss.Step := 1;
  MailProgesss.Caption := 'Checking for Emails';
  MailProgesss.AllowCancel := true;
  MailProgesss.OnCancel := DoOnProgressCancel;
  MailProgesss.Execute;
  ProgressCanceled := false;
  MailReader := TMailReader.Create;
  MailConfig := TEmailConfig.Create(nil);
  try
    MailReader.Connection := TERPConnection(SubEmpPay.EmployeeCorrespondence.Connection.Connection);
    MailConfig.Connection := TMyDacDataConnection.Create(MailConfig);
    MailConfig.Connection.Connection := MailReader.Connection;
    MailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName));
    if (MailConfig.Count > 0) then begin
      if MailConfig.ConfigValid then begin
        MailReader.Config.AsString := MailConfig.ConfigJSON;
        MailReader.EmailAddress := MailConfig.EmailAddress;
        MailReader.OnProgress := DoOnCheckForEmailsProgress;
        MailReader.OnGetMessageCount := DoOnGetMessageCount;
        try
          if MailReader.GetMail(msg) then begin

          end
          else begin

          end;

        finally
        end;
      end;
    end;
  finally
    if Assigned(MailProgesss) then begin
      MailProgesss.CloseDialog;
      FreeAndNil(MailProgesss);
    end;
    MailReader.Free;
    MailConfig.Free;
  end;
  SubEmpPay.EmployeeCorrespondence.Closedb;
  SubEmpPay.EmployeeCorrespondence.ResultStatus.Clear;
  SubEmpPay.EmployeeCorrespondence.Opendb;
end;

procedure TfrmEmployeeDocuments.chkShowAllCorrespondenceClick(Sender: TObject);
begin
  inherited;
  if not Assigned(SubEmpPay) then exit;
//  grdCorrespondence.SetControlType('active',fctCheckBox,'T;F');
//  grdCorrespondence.ApplySelected;
  SubEmpPay.EmployeeCorrespondence.PostDb;
  if chkShowAllCorrespondence.Checked then
    SubEmpPay.EmployeeCorrespondence.LoadSelect('EmployeeID = ' + IntToStr(SubEmpPay.EmployeeDetails.ID))
  else
    SubEmpPay.EmployeeCorrespondence.LoadSelect('EmployeeID = ' + IntToStr(SubEmpPay.EmployeeDetails.ID) +
      ' AND (IsNull(ContactID) or (ContactID < 1)) AND (IsNull(CusID) or (CusID < 1)) AND (IsNull(SupID) or (SupID < 1))');
//  grdCorrespondence.SetControlType('active',fctCheckBox,'T;F');
//  grdCorrespondence.ApplySelected;
end;

procedure TfrmEmployeeDocuments.chkShowInactiveCorrespondenceClick(Sender: TObject);
begin
  inherited;
  if not Assigned(SubEmpPay) then exit;
  SubEmpPay.EmployeeCorrespondence.Dataset.filtered := false;
  if not chkShowInactiveCorrespondence.Checked then begin
    SubEmpPay.EmployeeCorrespondence.Dataset.filter   := 'Active = ''T''';
    SubEmpPay.EmployeeCorrespondence.Dataset.filtered := true;
  end;
end;

procedure TfrmEmployeeDocuments.RefreshLookup;
begin
end;

procedure TfrmEmployeeDocuments.RefreshQuery;
begin
  CloseDb(grdCorrespondence.Datasource.dataset);
  OpenDb(grdCorrespondence.Datasource.dataset);
end;

procedure TfrmEmployeeDocuments.btnSMSClick(Sender: TObject);
var
  mobile: string;
begin
  if (SubEmpPay.EmployeeDetails.Mobile = '') or (not SMSUtils.NumberHasCorrectPrefix(SubEmpPay.EmployeeDetails.Mobile, TMyConnection(SubEmpPay.Connection.Connection))) then begin
    if (SubEmpPay.EmployeeDetails.Mobile = '') then
      mobile := GetMobileNumberFromUser('Employee (' + SubEmpPay.EmployeeDetails.EmployeeName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.')
    else
      mobile := GetMobileNumberFromUser('Employee (' + SubEmpPay.EmployeeDetails.EmployeeName +
        ' number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', mobile, TMyConnection(SubEmpPay.Connection.Connection));
    if mobile <> '' then begin
      SubEmpPay.EmployeeDetails.Mobile := mobile;
    end
    else
      exit;
  end;

  TCorrespondenceGui.SMS(SubEmpPay.EmployeeDetails.Mobile,
    '',
    SubEmpPay.EmployeeDetails.ID,rtEmployee);
end;

procedure TfrmEmployeeDocuments.DoOnCheckForEmailsProgress(const msg: string;
  var Continue: boolean);
begin
  if Assigned(MailProgesss) then begin
    MailProgesss.Message := msg;
    MailProgesss.StepIt;
    Continue := not ProgressCanceled;
  end;
end;

procedure TfrmEmployeeDocuments.DoOnGetMessageCount(
  const MessageCount: integer);
begin
  MailProgesss.MaxValue := MessageCount;
end;

procedure TfrmEmployeeDocuments.DoOnProgressCancel(Sender: TObject);
begin
  ProgressCanceled := true;
end;

procedure TfrmEmployeeDocuments.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Value = BusobjEventVal_FailedDocumentsValidateData then begin
    // HandleEmployeeCommissionErrors; {No Need For Error Handling Yet ?? }
  end;
end;

initialization
  RegisterClassOnce(TfrmEmployeeDocuments);
end.
