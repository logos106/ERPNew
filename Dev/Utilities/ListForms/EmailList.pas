unit EmailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  ComCtrls, HTMLUn2, HtmlView, FileAssociationDetails, IdMessage, wwcheckbox,
  CustomInputBox, IdHTTP, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TEmailListGUI = class(TBaseListingGUI)
    qryMainContact: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainOtherContactName: TWideStringField;
    qryMainSubject: TWideStringField;
    qryMainDateTime: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainMessageFrom: TWideStringField;
    qryMainMessageTo: TWideStringField;
    Splitter1: TSplitter;
    pnlMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    qryMainMarketingContactName: TWideStringField;
    qryMainMessageId: TWideStringField;
    btnEmailConfig: TDNMSpeedButton;
    btnEmailPurge: TDNMSpeedButton;
    qryMainRefId: TIntegerField;
    qryMessage: TERPQuery;
    procedure grdMainRowChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnEmailConfigClick(Sender: TObject);
    procedure btnEmailPurgeClick(Sender: TObject);
    procedure grdMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    FirstRowChange: boolean;
    HTTP: TIdHTTP;
    CurrentRowId: integer;
  protected
    procedure RefreshQuery; override;
  public
    procedure UpdateMe; override;
  end;

var
  EmailListGUI: TEmailListGUI;

implementation

{$R *.dfm}

uses
  ContentTypeObj, HTTPUtil, IdText, IdAttachmentFile, IdAttachmentMemory,
  ShellApi, CommonLib, SystemLib, IdAttachment, BusObjEmailConfig,
  BusObjBase, CommonDbLib, AppEnvironment, frmEmailPurge,
  EmailConst, frmEmailConfig2, HTTPConst;


{ TEmailListGUI }

procedure TEmailListGUI.btnEmailConfigClick(Sender: TObject);
var
  Config: TEmailConfig;
  qry: TERPQuery;
  dataChanged: boolean;
begin
  inherited;
  dataChanged := false;
  Config := TEmailConfig.Create(nil);
  qry:= TERPQuery.Create(nil);
  try
    Config.Connection := TMydacDataConnection.Create(Config);
    Config.Connection.Connection := CommonDbLib.GetNewMyDacConnection(Config);
    qry.Connection := Config.Connection.Connection;
    qry.Connection.StartTransaction;
    Config.LoadSelect('EntityName = "Company"');
    if Config.Count = 0 then begin
      Config.New;
      Config.EntityName := 'Company';
      Config.PostDb;
      dataChanged := true;
    end;
    qry.SQL.Text := 'select * from tblcompanyinformation';
    qry.Open;

    if not SameText(qry.FieldByName('Email').AsString,Config.EmailAddress) then begin
      Config.EmailAddress := qry.FieldByName('Email').AsString;
      Config.PostDb;
      dataChanged := true;
    end;


    if frmEmailConfig2.DoEmailConfig(Config) then begin
      if not SameText(qry.FieldByName('Email').AsString,Config.EmailAddress) then begin
        qry.Edit;
        qry.FieldByName('Email').AsString := Config.EmailAddress;
        qry.Post;
        dataChanged := true;
      end;
      if Config.ConfigValid then begin
        if not qry.FieldByName('TrackEmails').Asboolean then begin
          if CommonLib.MessageDlgXP_Vista('Email Tracking is disabled, would you like this re-enabled?',mtInformation,[mbYes,mbNo],0) = mrYes then begin
            qry.Edit;
            qry.FieldByName('TrackEmails').Asboolean := false;
            qry.Post;
            dataChanged := true;
          end;
        end;
      end
      else begin
        if qry.FieldByName('TrackEmails').Asboolean then begin
          qry.Edit;
          qry.FieldByName('TrackEmails').Asboolean := false;
          qry.Post;
          dataChanged := true;
          CommonLib.MessageDlgXP_Vista('Email settings not valid/tested so company Email Tracking has been disabled.',mtWarning,[mbOk],0);
        end;
      end;

    end;

  finally
    if dataChanged then begin
      if qry.Connection.InTransaction then
        qry.Connection.Commit;
      AppEnv.CompanyInfo.Load();
    end;
    Config.Free;
    qry.Free;
  end;
end;

procedure TEmailListGUI.btnEmailPurgeClick(Sender: TObject);
var Form : TfmEmailPurge;
begin
  inherited;
  Form := TfmEmailPurge(GetComponentByClassName('TfmEmailPurge'));
  if Assigned(Form) then begin //if has acess
    Form.AttachObserver(Self);
    Form.FormStyle := fsMDIChild;
    Form.BringToFront;
  end;
end;

procedure TEmailListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SelectedMail := nil;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  FirstRowChange := true;
  CurrentRowId := 0;
end;

procedure TEmailListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  HTMLImageStream.Free;
  FileAssociationDetails.Free;

end;

procedure TEmailListGUI.FormShow(Sender: TObject);
begin
  inherited;
  pnlMessage.Align := alNone;
  pnlMessage.Align := alClient;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('EmailMessage,RefId') ; //MessageId');
end;

procedure TEmailListGUI.grdMainDblClick(Sender: TObject);
var
  FileName: string;
  IdMessage: TIdMessage;
  Stream: TStream;
begin
  if qryMainMessageID.AsString = '' then begin
    inherited;
    exit;
  end;
  { this is an email }
  FileName := SystemLib.GetAppTempDir + '\' + qryMainMessageId.AsString + '.eml';
  IdMessage := TIdMessage.Create;
  try
    qryMessage.ParamByName('ID').AsInteger := qryMainRefId.AsInteger;
    qryMessage.Open;
    Stream := qryMessage.CreateBlobStream(qryMessage.FieldByName('EmailMessage'),bmRead);
    try
      IdMessage.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    IdMessage.SaveToFile(FileName);
  finally
    IdMessage.Free;
    qryMessage.Close;
  end;
  ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
end;

procedure TEmailListGUI.grdMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if qryMain.Active then begin
    if CurrentRowId = 0 then begin
      CurrentRowId := qryMain.RecNo;
      grdMainRowChanged(qryMain);
    end;
  end;
end;

procedure TEmailListGUI.grdMainRowChanged(Sender: TObject);
var
  stream: TStream;
  str: string;
  PartContent: TContentType;
  x: integer;
  BodyFound: boolean;
  Item: TListItem;
  ImageIndex: integer;
begin
  inherited;
  HTMLViewer.Clear;
  lvAttachments.Clear;
  FileAssociationDetails.Clear;
  { don't display content when list first opened to speed it up }
  if FirstRowChange then begin
    FirstRowChange := false;
    exit;
  end;
  lvAttachments.SmallImages := FileAssociationDetails.Images;
  if qryMain.FieldByName('MessageId').AsString <> '' then begin
    if not Assigned(SelectedMail) then begin
      SelectedMail := TIdMessage.Create(self);
    end;
    qryMessage.ParamByName('ID').AsInteger := qryMainRefId.AsInteger;
    qryMessage.Open;
    Stream := qryMessage.CreateBlobStream(qryMessage.FieldByName('EmailMessage'),bmRead);
    try
      SelectedMail.LoadFromStream(Stream);
    finally
      Stream.Free;
      qryMessage.Close;
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
  else begin
    FreeAndNil(SelectedMail);
    HTMLViewer.LoadFromString(EmailConst.EmailContentNotAvailable);
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

procedure TEmailListGUI.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
  ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL)
end;

procedure TEmailListGUI.HtmlViewerImageRequest(Sender: TObject;
  const SRC: string; var Stream: TStream);
var
  MessageId: string;
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
      if Not Assigned(HTTP) then begin
        HTTP:= TIDHTTP.Create(self);
        HTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
      end;
      HTTP.Get(SRC,HTMLImageStream);
      try
        HTMLImageStream.Position := 0;
        if HTMLImageStream.Size > 0 then
          Stream := HTMLImageStream;
      except

      end;
    end;
  end;
end;

procedure TEmailListGUI.lvAttachmentsDblClick(Sender: TObject);
var
  item: TListItem;
  Option: word;
  FileName: string;
  SaveDialog: TSaveDialog;
begin
  inherited;
  item := lvAttachments.Selected;
  if Assigned(item) then begin
    Option := MessageDlgXP_Vista('Do you wish to Save of Open this attachment?',
      mtConfirmation, [] , 0, nil , '','', False, nil, 'Save,Open,Cancel');
    case Option of
      100: { save }
        begin
          FileName := SystemLib.GetMyDocumentsDir + TIdAttachment(item.Data).FileName;
          SaveDialog:= TSaveDialog.Create(nil);
          try
            SaveDialog.FileName := FileName;
            SaveDialog.InitialDir := ExtractFilePath(FileName);
            if SaveDialog.Execute then begin
              TIdAttachment(item.Data).SaveToFile(SaveDialog.FileName);
            end;
          finally
            SaveDialog.Free;
          end;
        end;
      101: { open }
        begin
          FileName := SystemLib.GetAppTempDir + '\' + TIdAttachment(item.Data).FileName;
          TIdAttachment(item.Data).SaveToFile(FileName);
          ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
        end;
      102: exit; { Cancel }
    end;
  end;
end;

procedure TEmailListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDate := FilterDateFrom;
  qryMain.Params.ParamByName('DateTo').AsDate := Filterdateto;
  inherited;

end;

procedure TEmailListGUI.UpdateMe;
begin
  inherited;
  self.RefreshQuery;
end;

initialization
  RegisterClass(TEmailListGUI);

end.
