unit frmSendMessage;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Shader, DNMSpeedButton, DNMPanel;

type
  TfmSendMessage = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnSend: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlSubject: TDNMPanel;
    pnlMessage: TDNMPanel;
    edtTo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtSubject: TEdit;
    Label3: TLabel;
    memMessage: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fCorrespondenceType: string;
    fSupId: Integer;
    fContactId: Integer;
    fMarketingContactId: integer;
    fRepairID: Integer;
    fOtherContactId: Integer;
    fEmployeeId: Integer;
    fMessageFrom: string;
    fCusId: Integer;
    fAutoSend: boolean;
    fAttachmentFileName: string;
    function GetMessageText: string;
    function GetMessageTo: string;
    function GetSubject: string;
    procedure SetCorrespondenceType(const Value: string);
    procedure SetMessageText(const Value: string);
    procedure SetMessageTo(const Value: string);
    procedure SetSubject(const Value: string);
    function ValidateData: boolean;
    function SubdistutedText(s: string): string;
  public
    SubstituteList: TStringList;
    property CorrespondenceType: string read fCorrespondenceType write SetCorrespondenceType;
    property AutoSend: boolean read fAutoSend write fAutoSend;
    property MessageTo: string read GetMessageTo write SetMessageTo;
    property Subject: string read GetSubject write SetSubject;
    property MessageText: string read GetMessageText write SetMessageText;
    Property ContactId: Integer Read fContactId Write fContactId;
    Property CustomerId: Integer Read fCusId Write fCusId;
    Property SupplierId: Integer Read fSupId Write fSupId;
    property MarketingContactId: integer read fMarketingContactId write fMarketingContactId;
    Property EmployeeId: Integer Read fEmployeeId Write fEmployeeId;
    Property OtherContactId: Integer Read fOtherContactId Write fOtherContactid;
    Property RepairID: Integer Read fRepairID Write fRepairID;
    property MessageFrom: string read fMessageFrom write fMessageFrom;
    property AttachmentFileName: string read fAttachmentFileName write fAttachmentFileName;
  end;

var
  fmSendMessage: TfmSendMessage;

implementation

{$R *.dfm}

uses
  CommonLib, BusObjCorrespondence, EmailUtils, BusObjBase, AppEnvironment,
  SimpleEncrypt, SMSUtils;

procedure TfmSendMessage.btnSendClick(Sender: TObject);
var
  Corres: TCorrespondence;
  Mail: TEmailSender;
  TrackEmails: boolean;
begin
  if not ValidateData then exit;
  if AutoSend then begin
    Corres:= TCorrespondence.Create(nil);
    try
      Corres.Connection := TMyDacDataConnection.Create(Corres);
      if Assigned(Owner) and (Owner is TBaseInputGUI) then begin
        Corres.Connection.Connection := TBaseInputGUI(Owner).MyConnection;
        Corres.Connection.BeginNestedTransaction;
      end
      else begin
        Corres.Connection.Connection := MyConnection;
        self.BeginTransaction;
      end;

      try

        Corres.Load(0);
        Corres.New;
        Corres.Ref_Type := CorrespondenceType;
        Corres.Ref_Date := now;
        Corres.ReferenceTxt := Copy(Subject,1,50);
        Corres.MessageTo := MessageTo;
        Corres.MessageFrom := MessageFrom;
        Corres.ContactId := ContactId;
        Corres.CusId := CustomerId;
        Corres.SupId := SupplierId;
        Corres.MarketingContactId := MarketingContactId;
        Corres.EmployeeId := EmployeeId;
        Corres.OtherContactId := OtherContactId;
        Corres.RepairID := RepairID;


        if SameText(CorrespondenceType, 'SMS') then begin
          Corres.Status := 'Waiting';
          Corres.SMS.Format := 'SMS';
          Corres.SMS.Status := 'Waiting';
          Corres.SMS.PhoneNumber := MessageTo;
          {$IFDEF DevMode}
            Corres.SMS.PhoneNumber := SMSUtils.DevMode_MobileNumber;
          {$ENDIF}
          Corres.SMS.Content := SubdistutedText(MessageText);
          Corres.ReferenceTxt := Copy(Corres.SMS.Content,1,50);
        end
        else if SameText(CorrespondenceType, 'Email') then begin
          Mail := TEmailSender.Create;
          try
            TrackEmails := false;
            Mail.Recipients := MessageTo;

            { BCC back to sender }
            if not AppEnv.Employee.UseEmpEmailAsFromAddress then begin
              if AppEnv.CompanyInfo.TrackEmails then begin
                Mail.BccList := AppEnv.CompanyInfo.Email;
                TrackEmails := true;
              end;
              Corres.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.CompanyInfo.Email + ')';
            end  else begin
              if AppEnv.Employee.TrackEmails then begin
                Mail.BccList := AppEnv.Employee.Email;
                TrackEmails := true;
              end;
              Corres.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.Employee.Email + ')';
            end;
            Mail.Subject := Subject;
            Mail.EmailBody.Text := MessageText;
            if AttachmentFileName <> '' then
              Mail.AddAttachment(AttachmentFileName);
            Corres.PostDb;
            if TrackEmails then
              MakeBodyWithRef(SimpleCrypt(Corres.Connection.Connection.Database)+ '-id-'+ IntToStr(Corres.ID), Mail.EmailBody);
            Mail.Send(false);
          finally
            Mail.Free;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Invalid Message Type: "' + CorrespondenceType + '"',mtError,[mbOk],0);
          exit;
        end;

        if not Corres.Save then begin
          CommonLib.MessageDlgXP_Vista(Corres.ResultStatus.Messages,mtWarning,[mbOk],0);
          exit;
        end;

        if Assigned(Owner) and (Owner is TBaseInputGUI) then
          Corres.Connection.CommitNestedTransaction
        else
          self.CommitTransaction;
        if SameText(CorrespondenceType, 'SMS') then
          AppEnv.UtilsClient.TriggerSMSSend;
        self.ModalResult := mrOk;

      finally
        if Assigned(Owner) and (Owner is TBaseInputGUI) then
          Corres.Connection.RollbackNestedTransaction
        else
          self.RollbackTransaction;
      end;
    finally
      Corres.Free;
    end;
  end
  else begin
    self.ModalResult := mrOk;
  end;
end;

procedure TfmSendMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSendMessage.FormCreate(Sender: TObject);
begin
  inherited;
  SubstituteList := TStringList.Create;
  AutoSend:= true;
end;

procedure TfmSendMessage.FormDestroy(Sender: TObject);
begin
  inherited;
  SubstituteList.Free;
end;

procedure TfmSendMessage.FormShow(Sender: TObject);
begin
  inherited;
  if SameText(CorrespondenceType,'SMS') then begin
    TitleLabel.Caption := 'Send SMS';
    memMessage.SetFocus;
  end
  else if SameText(CorrespondenceType,'Email') then begin
    TitleLabel.Caption := 'Send Email';
    edtTo.ReadOnly := false;
    if edtTo.Text = '' then
      edtTo.SetFocus
    else
      edtSubject.SetFocus;
  end;
end;

function TfmSendMessage.GetMessageText: string;
begin
  result := memMessage.Lines.Text;
end;

function TfmSendMessage.GetMessageTo: string;
begin
  result := edtTo.Text;
end;

function TfmSendMessage.GetSubject: string;
begin
  result := edtSubject.Text;
end;

procedure TfmSendMessage.SetCorrespondenceType(const Value: string);
begin
  fCorrespondenceType := Value;
  if SameText(Value, 'SMS') then
    pnlSubject.Visible := false
  else
    pnlSubject.Visible := true;
end;

procedure TfmSendMessage.SetMessageText(const Value: string);
begin
  memMessage.Lines.Text := SubdistutedText(Value);
end;

procedure TfmSendMessage.SetMessageTo(const Value: string);
begin
  edtTo.Text := Value;
end;

procedure TfmSendMessage.SetSubject(const Value: string);
begin
  edtSubject.Text := SubdistutedText(Value);
end;

function TfmSendMessage.SubdistutedText(s: string): string;
var
  x: integer;
begin
  result := s;
  for x := 0  to SubstituteList.Count -1 do begin
    result := StringReplace(result, SubstituteList.Names[x], SubstituteList.ValueFromIndex[x], [rfReplaceAll,rfIgnoreCase]);
  end;
end;

function TfmSendMessage.ValidateData: boolean;
begin
  result:= false;
  if memMessage.Lines.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('The Message text is blank.', mtInformation, [mbOk],0);
    exit;
  end;
  if (not SameText(CorrespondenceType, 'SMS')) and (edtSubject.Text = '') then begin
    CommonLib.MessageDlgXP_Vista('The Message Subject is blank.', mtInformation, [mbOk],0);
    exit;
  end;
  result := true;
end;

initialization
  RegisterClass(TfmSendMessage);

end.
