unit frmEmailMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, fraHTMLEdit, RVStyle,
  DNMSpeedButton, DNMPanel, Buttons, CorrespondenceObj, RichView, editlist,
  DMComps;

type
  TfmEmailMessage = class(TfrmBaseGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnSend: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlAttachments: TDNMPanel;
    pnlAddress: TDNMPanel;
    Label1: TLabel;
    edtSubject: TEdit;
    Label2: TLabel;
    edtCC: TEdit;
    Label3: TLabel;
    edtTo: TEdit;
    Label4: TLabel;
    edtFrom: TEdit;
    Label5: TLabel;
    edtBCC: TEdit;
    lstAttachments: TListBox;
    Label6: TLabel;
    btnAttach: TBitBtn;
    HTMLEdit: TfrHTMLEdit;
    AttachOpenDialog: TOpenDialog;
    DropAttachBtn: TDMTextTarget;
    DropAttachList: TDMTextTarget;
    Splitter1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnAttachClick(Sender: TObject);
    procedure lstAttachmentsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DropAttachBtnDrop(Sender: TObject; Acceptor: TWinControl;
      const DropText: string; X, Y: Integer);
    procedure DropAttachBtnDragOver(Sender: TObject; Effect: TDropEffect; X,
      Y: Integer);
    procedure btnAttachDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure AddAttachment(aFileName: string);
    procedure ShowAttachments;
    procedure AllignControls;
  public
    AttachmentList: TStringList;
  end;

  function EditEmailMessage(corres: TCorrespondenceGui): boolean;

implementation

uses
  RVItem, AppEnvironment, SimpleEncrypt, DnMLib, Vista_MessageDlg,
  rvhtmlimport, Types, IOUtils, EmailLib,
  ShlObj, ActiveX, DMUtil, CommonLib, CommonDbLib, AppDatabase,
  ERPErrorEmailUtils, ERPVersionConst;

{$R *.dfm}

function EditEmailMessage(corres: TCorrespondenceGui): boolean;
var
  form: TfmEmailMessage;
  tempDir: string;
  StringStream: TStringStream;
  strArr: TStringDynArray;
  x: integer;
  fsLog:String;
begin
  Result := False;
  try
                                                                                                fsLog := fsLog + ',1';
    form := TfmEmailMessage.Create(nil);                                                        fsLog := fsLog + ',2';
    try                                                                                         fsLog := fsLog + ',3';
      form.edtSubject.Text := corres.Subject;                                                   fsLog := fsLog + ',4';
      form.edtCC.Text := corres.CCList;                                                         fsLog := fsLog + ',5';
      form.edtTo.Text := corres.RecipientList;                                                  fsLog := fsLog + ',6';
      form.edtFrom.Text := corres.From;                                                         fsLog := fsLog + ',7';
      form.edtBCC.Text := corres.BCCList;                                                       fsLog := fsLog + ',8';
      form.AttachmentList.Assign(corres.AttachmentList);                                        fsLog := fsLog + ',9';
      form.ShowAttachments;                                                                     fsLog := fsLog + ',10';
      form.pnlAttachments.Visible := form.lstAttachments.Items.Count > 0;                       fsLog := fsLog + ',11';
      if SameText(corres.EmailConfig.IntegrationType, 'Server') then begin                      fsLog := fsLog + ',12';
        { direct to server .. so rich formatting }
        form.HTMLEdit.LoadHTML(corres.MessageRichText);                                         fsLog := fsLog + ',13';
      end else begin
        { message to users email client .. so plain text only }
        form.HTMLEdit.LoadHTML(corres.MessageText);                                             fsLog := fsLog + ',14';
        form.HTMLEdit.docMenu.Visible := false; { no rich editing }                             fsLog := fsLog + ',15';
      end;

      if form.ShowModal = mrOk then begin                                                       fsLog := fsLog + ',16';
        { update details }
        corres.Subject := form.edtSubject.Text;                                                 fsLog := fsLog + ',17';
        corres.CCList := form.edtCC.Text;                                                       fsLog := fsLog + ',18';
        corres.RecipientList := form.edtTo.Text;                                                fsLog := fsLog + ',19';
        corres.From := form.edtFrom.Text;                                                       fsLog := fsLog + ',20';
        corres.BCCList := form.edtBCC.Text;                                                     fsLog := fsLog + ',21';
        corres.AttachmentList.Assign(form.AttachmentList);                                      fsLog := fsLog + ',22';
        TempDir := EmailLib.EmailTempMessageDir;                                                fsLog := fsLog + ',23';
        DeleteFiles(TempDir,'*.*');                                                             fsLog := fsLog + ',24';
        corres.InlineAttachmentList.Clear;                                                      fsLog := fsLog + ',25';
        StringStream := TStringStream.Create;                                                   fsLog := fsLog + ',26';

        try                                                                                     fsLog := fsLog + ',27';
          if not SameText(corres.EmailConfig.IntegrationType, 'Server') then begin              fsLog := fsLog + ',28';
            { plain text }
            form.HTMLEdit.RichEdit.SaveTextToStream(TempDir,StringStream,80,false,false);       fsLog := fsLog + ',29';
            corres.MessageText := StringStream.DataString;                                      fsLog := fsLog + ',30';
          end else begin
            { html rich text }
            StringStream.Clear;                                                                 fsLog := fsLog + ',31';
            try
              form.HTMLEdit.RichEdit.SaveHTMLToStream(StringStream,TempDir,corres.Subject,'',
                [rvsoOverrideImages,rvsoNoHypertextImageBorders,rvsoImageSizes,rvsoMarkersAsText,rvsoUseCheckpointsNames,
                 rvsoUTF8,rvsoDefault0Style,rvsoForceNonTextCSS]);                              fsLog := fsLog + ',32';
            Except
              on Exception do begin
                fsLog := fsLog + ',35';
              end;
            end;
            corres.MessageRichText := StringStream.DataString;                                  fsLog := fsLog + ',34';

            { get any inline images ..  }
            strArr := TDirectory.GetFiles(TempDir);                                             fsLog := fsLog + ',35';
            for x := Low(strArr) to High(strArr) do begin
              corres.InlineAttachmentList.AddFile(strArr[x]);                                   fsLog := fsLog + ',36';
            end;
          end;
        finally
          StringStream.Free;                                                                    //fsLog := fsLog + ',37';
        end;

        result := true;                                                                         fsLog := fsLog + ',38';
      end;

    finally
      Freeandnil(form);// form.Release;                                                         //fsLog := fsLog + ',39;
    end;
  Except
    on E:Exception do begin
        SendEmailtoErp( 'EditEmailMessage ',
                '    Company     :' +appenv.CompanyInfo.Companyname          +chr(13) +
                '    User        :' +appenv.Employee.EmployeeName            +chr(13) +
                '    Server      :' +GetSharedMyDacConnection.Server         +chr(13) +
                '    Datase      :' +GetSharedMyDacConnection.Database       +chr(13) +
                '    Version     :' +TABLE_VERSION                           +chr(13) +
                '    Log No      :' +fsLog                                   +chr(13) +chr(13) +
                '    Error :' + E.message);
        MessageDlgXP_Vista('Emailing Failed.. Email Send to ERP', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmEmailMessage.AddAttachment(aFileName: string);
begin
  AttachmentList.Add(aFileName);
//  lstAttachments.Items.Add(aFileName);
  ShowAttachments;
end;

procedure TfmEmailMessage.btnAttachClick(Sender: TObject);
begin
  inherited;
  if AttachOpenDialog.Execute then
    AddAttachment(AttachOpenDialog.FileName);
end;

procedure TfmEmailMessage.btnAttachDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:= true;
end;

procedure TfmEmailMessage.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmEmailMessage.btnSendClick(Sender: TObject);
begin
  inherited;
  if Trim(edtTo.Text) = '' then begin
    MessageDlgXP_Vista('Please enter an Email Address to send this message to', mtInformation,[mbOk], 0);
    exit;
  end;
  if Trim(edtSubject.Text) = '' then begin
    MessageDlgXP_Vista('Please enter a Subject for this email', mtInformation,[mbOk], 0);
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfmEmailMessage.DropAttachBtnDragOver(Sender: TObject;
  Effect: TDropEffect; X, Y: Integer);
begin
  inherited;
  //
end;

procedure TfmEmailMessage.DropAttachBtnDrop(Sender: TObject; Acceptor: TWinControl;
  const DropText: string; X, Y: Integer);
var
  hasFormats: boolean;
  S, t: string;
  nFiles: DWORD;
  aFd: TFileDescriptor;
  j: integer;
  anIstream: IStream;
//  tempFileName: string;
//  ListItem: TListItem;
  ix: integer;
begin
  inherited;


  with (Sender as TDMTextTarget) do begin
    if (DroppedTextFormat = dtfFiles) then begin
      // It's a plain list of files - do the "usual" thing
      for ix := 0 to DroppedLines.Count - 1 do begin
//        ListItem := lvAttachments.Items.Add;
//        ListItem.Caption := ExtractFileName(DroppedLines[ix]);
//        GetImageForFileType(ListItem);
//        ListItem.Data := Pointer(SaveAttachment(DroppedLines[ix], ListItem.Caption, false));
        AddAttachment(DroppedLines[ix]);
      end;
    end else begin
      // It's not simple files, but MS Outlook's combination of a FileGroupDescriptor
      // and FileContents on an IStream.  We have to go get the attachments and then
      // put them on files ourselves.  It appears that Outlook 97 also puts a copy
      // of this file in the TEMP directory, but we ignore that here so we can
      // demonstrate the principles.

      // Do we have fgd?
      hasFormats := DataObjectHasFormat('FileGroupDescriptor');

      // Global override for tymed - reset automatically by calls to
      // DataObjectHasFormat and DataObjectGetFormat
      DataObjectTymed := TYMED_ISTREAM;
      // Do we have fc?  Do the call first, so we're guaranteed that it won't
      // be short-circuited, so that the global tymed and lindex get reset properly.
      hasFormats := DataObjectHasFormat('FileContents') and hasFormats;

      if hasFormats then begin
        // Get the file group descriptors
        s := string(DataObjectGetFormat('FileGroupDescriptor'));
        // How many fgd's in the returned data?  That's a DWORD at the head
        // of the string-encoded data
        nFiles := DecodeDWORDFromString(AnsiString(s));

        // Process them all
        for j := 1 to nFiles do // Iterate
        begin
          // Get the j'th file descriptor.  It starts after the initial DWORD,
          // and has the length of a TFileDescriptor.
          System.Move(s[SizeOf(DWORD) + 1 + (j - 1) * SizeOf(TFileDescriptor)], aFd,
            SizeOf(TFileDescriptor));

          // Its content is on an IStream, at lindex j-1
          // Global overrides for lindex and tymed
          DataObjectLindex := j - 1;
          DataObjectTymed := TYMED_ISTREAM;
          t := string(DataObjectGetFormat('FileContents'));

          // Watch out for nothing at that index...
          if (t <> '') then begin
            // Don't use "anIStream := IStream(DecodeDWORDFromString(s));" since that
            // would add another reference, due to Delphi's automatic reference handling.
            // Alternatively, do it that way, but immediately call anIStream._Release;
            DWORD(anIStream) := DecodeDWORDFromString(AnsiString(t));

            // Now, we have a singly-referenced Istream interface that we can read from.
            // We put it on a file somewhere.  For this example, we're using a
            // temporary file name that begins with 'dmx' and has the same extension
            // as the original and also adding it to the list.  Note that
            // GetTempFileNameEx also creates the file, so we rename it immediately.
//            tempFileName := GetTempFileName(ExtractFileName(aFd.cFileName), ExtractFileExt(aFd.cFileName));
//            ListItem := lvAttachments.Items.Add;
//            SaveIStreamToFile(anIstream, tempFileName);
//            ListItem.Caption := aFd.cFileName;
//            GetImageForFileType(ListItem);
//            ListItem.Data := Pointer(SaveAttachment(tempFileName, ListItem.Caption, true));
            self.AddAttachment(aFd.cFileName);
          end;
        end;    // for
      end;      // if hasFormats
    end         // if (DroppedTextFormat = dtfFiles)
  end;          // with
end;

procedure TfmEmailMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmEmailMessage.FormCreate(Sender: TObject);
begin
  inherited;
  HTMLEdit.SaveToolBar.Free;
  HTMLEdit.StatusBar.Visible := false;
  AttachmentList := TStringList.Create;
end;

procedure TfmEmailMessage.FormDestroy(Sender: TObject);
begin
  inherited;
  AttachmentList.Free;
end;

procedure TfmEmailMessage.FormShow(Sender: TObject);
begin
  inherited;
  ShowAttachments;
end;

procedure TfmEmailMessage.lstAttachmentsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then begin
    if lstAttachments.ItemIndex > -1 then begin
      if MessageDlgXP_Vista('Remove this attachment?' + #13#10 + #13#10 + lstAttachments.Items[lstAttachments.ItemIndex], mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
        AttachmentList.Delete(lstAttachments.ItemIndex);
        ShowAttachments;
      end;
      exit;
    end;
  end;
end;

procedure TfmEmailMessage.AllignControls;
begin
  btnAttach.Left := pnlAddress.Width - btnAttach.Width - 4;
  edtFrom.Width := pnlAddress.Width - edtFrom.Left - 4 - btnAttach.Width - 4;
  edtTo.Width := pnlAddress.Width - edtTo.Left - 4;
  edtCC.Width := pnlAddress.Width - edtCC.Left - 4;
  edtBCC.Width := pnlAddress.Width - edtBCC.Left - 4;
  edtSubject.Width := pnlAddress.Width - edtSubject.Left - 4;
  Splitter1.Visible := pnlAttachments.Visible;
  if Splitter1.Visible then begin
    Splitter1.Align := alNone;
    Splitter1.Align := alRight;
  end;
end;

procedure TfmEmailMessage.ShowAttachments;
var
  x: integer;
begin
  lstAttachments.Clear;
  for x := 0 to AttachmentList.Count - 1 do
    lstAttachments.Items.Add(ExtractFileName(AttachmentLIst[x]));
  pnlAttachments.Visible := lstAttachments.Items.Count > 0;
  AllignControls;
end;

initialization
  RegisterClass(TfmEmailMessage)

end.
