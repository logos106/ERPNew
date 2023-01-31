unit fraHTMLEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, AdvToolBar, AdvToolBarStylers, ActnList, ImgList, AdvToolBtn,
  StdCtrls, AdvCombo, ExtCtrls, RichView, RVScroll, RVEdit, ComCtrls, RVStyle,
  HTMLUn2, HtmlView, rvhtmlimport;

type
  TfrHTMLEdit = class(TFrame)
    docMenu: TAdvDockPanel;
    MenuStyler: TAdvToolBarOfficeStyler;
    AlignToolBar: TAdvToolBar;
    btnAlignJustify: TAdvToolButton;
    btnAlignCenter: TAdvToolButton;
    btnAlignRight: TAdvToolButton;
    btnAlignLeft: TAdvToolButton;
    MenuImageList: TImageList;
    FontToolbar: TAdvToolBar;
    FormatToolbar: TAdvToolBar;
    SaveToolBar: TAdvToolBar;
    cboFont: TAdvComboBox;
    cboFontSize: TAdvComboBox;
    btnFontBAckgroundColor: TAdvToolButton;
    btnFontColor: TAdvToolButton;
    btnFont: TAdvToolButton;
    btnUnderline: TAdvToolButton;
    btnItalic: TAdvToolButton;
    btnBold: TAdvToolButton;
    RichEdit: TRichViewEdit;
    StatusBar: TStatusBar;
    RichEditStyle: TRVStyle;
    sd: TSaveDialog;
    od: TOpenDialog;
    fd: TFontDialog;
    cd: TColorDialog;
    btnParaBackColor: TAdvToolButton;
    btnIndentDec: TAdvToolButton;
    btnIndentInc: TAdvToolButton;
    btnSaveAs: TAdvToolButton;
    btnNew: TAdvToolButton;
    btnOpen: TAdvToolButton;
    btnSave: TAdvToolButton;
    HtmlImporter: TRvHtmlImporter;
    procedure RichEditCurTextStyleChanged(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure RichEditCurParaStyleChanged(Sender: TObject);
    procedure RichEditParaStyleConversion(Sender: TCustomRichViewEdit; StyleNo,
      UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
    procedure btnApplyParaClick(Sender: TObject);
    procedure cboFontSizeClick(Sender: TObject);
    procedure cboFontSizeExit(Sender: TObject);
    procedure cboFontSizeKeyPress(Sender: TObject; var Key: Char);
    procedure cboFontClick(Sender: TObject);
    procedure FontStyleButtonClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure btnFontColorClick(Sender: TObject);
    procedure btnFontBAckgroundColorClick(Sender: TObject);
    procedure RichEditStyleConversion(Sender: TCustomRichViewEdit; StyleNo,
      UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
    procedure btnIndentIncClick(Sender: TObject);
    procedure btnIndentDecClick(Sender: TObject);
    procedure btnParaBackColorClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
  private
    IgnoreChanges: Boolean;
    FileName: string;
    FontSize: integer;
    FontName: string;
    function GetAlignmentFromUI: TRVAlignment;
    procedure SetAlignmentToUI(Alignment: TRVAlignment);
    function SaveIfNeeded: Boolean;
    function Save: Boolean;
    function SaveAs: Boolean;
    procedure New;
    procedure Open;
  public
    constructor Create(aOwner: TComponent); override;
    procedure LoadHTMLFromFile(aFileName: string);
    procedure LoadHTML(HTML: string);
  end;

implementation

uses
  EmailLib, AppEnvironment, RVTypes;

// Parameters for ApplyStyleConversion
const
  TEXT_BOLD          = 1;
  TEXT_ITALIC        = 2;
  TEXT_UNDERLINE     = 3;
  TEXT_APPLYFONTNAME = 4;
  TEXT_APPLYFONT     = 5;
  TEXT_APPLYFONTSIZE = 6;
  TEXT_COLOR         = 7;
  TEXT_BACKCOLOR     = 8;
  // Parameters for ApplyParaStyleConversion
  PARA_ALIGNMENT = 1;
  PARA_INDENTINC = 2;
  PARA_INDENTDEC = 3;
  PARA_COLOR     = 4;

{$R *.dfm}

{ TfrHTMLEdit }

procedure TfrHTMLEdit.btnFontBAckgroundColorClick(Sender: TObject);
begin
  case Application.MessageBox
    ('Make the selected text background transparent?'#13 +
    '(YES - make transparent; NO - choose color)', 'Text Background',
    MB_YESNOCANCEL or MB_ICONQUESTION) of
    IDYES:
      cd.Color := clNone;
    IDNO:
      begin
        cd.Color := RichEditStyle.TextStyles[RichEdit.CurTextStyleNo].BackColor;
        if cd.Color = clNone then
          cd.Color := clWhite;
        if not cd.Execute then
          exit;
      end;
    IDCANCEL:
      exit;
  end;
  RichEdit.ApplyStyleConversion(TEXT_BACKCOLOR);
end;

procedure TfrHTMLEdit.btnFontClick(Sender: TObject);
begin
  fd.Font.Assign(RichEditStyle.TextStyles[RichEdit.CurTextStyleNo]);
  if fd.Execute then
  begin
    RichEdit.ApplyStyleConversion(TEXT_APPLYFONT);
  end;
end;

procedure TfrHTMLEdit.btnFontColorClick(Sender: TObject);
begin
  cd.Color := RichEditStyle.TextStyles[RichEdit.CurTextStyleNo].Color;
  if cd.Execute then
    RichEdit.ApplyStyleConversion(TEXT_COLOR);
end;

procedure TfrHTMLEdit.btnIndentDecClick(Sender: TObject);
begin
  RichEdit.ApplyParaStyleConversion(PARA_INDENTDEC);
end;

procedure TfrHTMLEdit.btnIndentIncClick(Sender: TObject);
begin
  RichEdit.ApplyParaStyleConversion(PARA_INDENTINC);
end;

procedure TfrHTMLEdit.btnNewClick(Sender: TObject);
begin
  New;
end;

procedure TfrHTMLEdit.btnOpenClick(Sender: TObject);
begin
  Open;
end;

procedure TfrHTMLEdit.btnParaBackColorClick(Sender: TObject);
begin
  case Application.MessageBox
    ('Make the selected paragraph background transparent?'#13 +
    '(YES - make transparent; NO - choose color)', 'Text Background',
    MB_YESNOCANCEL or MB_ICONQUESTION) of
    IDYES:
      cd.Color := clNone;
    IDNO:
      begin
        cd.Color := RichEditStyle.ParaStyles[RichEdit.CurParaStyleNo].Background.Color;
        if cd.Color = clNone then
          cd.Color := clWhite;
        if not cd.Execute then
          exit;
      end;
    IDCANCEL:
      exit;
  end;
  RichEdit.ApplyParaStyleConversion(PARA_COLOR);
end;

procedure TfrHTMLEdit.btnSaveAsClick(Sender: TObject);
begin
  SaveAs;
end;

procedure TfrHTMLEdit.btnSaveClick(Sender: TObject);
begin
  Save;
end;

procedure TfrHTMLEdit.cboFontClick(Sender: TObject);
begin
  if (cboFont.ItemIndex <> -1) then
  begin
    if not IgnoreChanges then
    begin
      FontName := cboFont.Items[cboFont.ItemIndex];
      RichEdit.ApplyStyleConversion(TEXT_APPLYFONTNAME);
    end;
  end;
  if Visible then
    RichEdit.SetFocus;
end;

procedure TfrHTMLEdit.cboFontSizeClick(Sender: TObject);
begin
  if (cboFontSize.Text <> '') and not IgnoreChanges then
  begin
    FontSize := StrToIntDef(cboFontSize.Text, 10);
    RichEdit.ApplyStyleConversion(TEXT_APPLYFONTSIZE);
  end;
  if Visible then
    RichEdit.SetFocus;
end;

procedure TfrHTMLEdit.cboFontSizeExit(Sender: TObject);
begin
  cboFontSizeClick(nil);
end;

procedure TfrHTMLEdit.cboFontSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = VK_RETURN then
  begin
    Key := #0;
    cboFontSizeClick(nil);
  end;
end;

constructor TfrHTMLEdit.Create(aOwner: TComponent);
begin
  inherited;
  cboFont.Items.Assign(Screen.Fonts);
  btnBold.Tag := TEXT_BOLD;
  btnItalic.Tag := TEXT_ITALIC;
  btnUnderline.Tag := TEXT_UNDERLINE;
  New;
end;

function TfrHTMLEdit.GetAlignmentFromUI: TRVAlignment;
begin
  if btnAlignLeft.Down then
    Result := rvaLeft
  else if btnAlignRight.Down then
    Result := rvaRight
  else if btnAlignCenter.Down then
    Result := rvaCenter
  else
    Result := rvaJustify;
end;

procedure TfrHTMLEdit.LoadHTML(HTML: string);
var
  sl: TStringList;
  dirName: string;
begin
  sl := TStringList.Create;
  try
    dirName := EmailLib.EmailTempMessageDir;
    ForceDirectories(dirName);
    sl.Text := HTML;
    sl.SaveToFile(dirName + 'temp_message.html');
    LoadHTMLFromFile(dirName + 'temp_message.html');
  finally
    sl.Free;
  end;
end;

procedure TfrHTMLEdit.LoadHTMLFromFile(aFileName: string);
var
  sl: TStringList;
begin
  Screen.Cursor := crHourGlass;
  sl := TStringList.Create;
  try
    sl.LoadFromFile(aFileName);
    HtmlImporter.BasePath := ExtractFilePath(aFileName);
    HtmlImporter.LoadHtml(TRVRawByteString(sl.Text));
    HtmlImporter.BasePath := '';
  finally
    HtmlImporter.RichView.Format;
    sl.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrHTMLEdit.New;
begin
  if not SaveIfNeeded then
    exit;
  FileName := '';
  StatusBar.Panels[0].Text := '';
  Caption := 'Unnamed';
  RichEdit.LeftMargin := 5;
  RichEdit.RightMargin := 5;
  RichEdit.TopMargin := 5;
  RichEdit.BottomMargin := 5;
  RichEdit.BackgroundBitmap := nil;
  RichEdit.BackgroundStyle := bsNoBitmap;
  RichEdit.Clear;
  RichEdit.DeleteUnusedStyles(True, True, True);
  RichEdit.Format;
  // you can delete non default styles here...
  RichEditCurTextStyleChanged(nil);
  RichEditCurParaStyleChanged(nil);
end;

procedure TfrHTMLEdit.Open;
begin
  if not SaveIfNeeded then
    exit;
  RichEdit.Modified := False;
  New;
  if od.Execute then
  begin
    FileName := od.FileName;
    RichEdit.LoadRVF(FileName);
    RichEdit.Format;
    RichEditCurTextStyleChanged(nil);
    RichEditCurParaStyleChanged(nil);
    StatusBar.Panels[0].Text := '';
    Caption := ExtractFileName(FileName);
  end;
end;

procedure TfrHTMLEdit.RichEditChange(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Modified';
end;

procedure TfrHTMLEdit.RichEditCurParaStyleChanged(Sender: TObject);
begin
  SetAlignmentToUI(RichEditStyle.ParaStyles[RichEdit.CurParaStyleNo].Alignment);
end;

procedure TfrHTMLEdit.RichEditCurTextStyleChanged(Sender: TObject);
var
  fi: TFontInfo;
begin
  IgnoreChanges := True;
  StatusBar.Panels[1].Text := 'Style : ' + IntToStr(RichEdit.CurTextStyleNo);
  // Changing selection in comboboxes with font names and sizes:
  fi := RichEditStyle.TextStyles[RichEdit.CurTextStyleNo];
  cboFont.ItemIndex := cboFont.Items.IndexOf(fi.FontName);
  //cboFontSize.Text := IntToStr(fi.Size);
  try
    cboFontSize.ItemIndex := cboFontSize.Items.IndexOf(IntToStr(fi.Size));
  except
    cboFontSize.ItemIndex := cboFontSize.Items.IndexOf('10');
  end;
  // Checking font buttons
  btnBold.Down := fsBold in fi.Style;
  btnItalic.Down := fsItalic in fi.Style;
  btnUnderline.Down := fsUnderline in fi.Style;
  IgnoreChanges := False;
end;

procedure TfrHTMLEdit.RichEditParaStyleConversion(Sender: TCustomRichViewEdit;
  StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
var
  ParaInfo: TParaInfo;
begin
  ParaInfo := TParaInfo.Create(nil);
  try
    ParaInfo.Assign(RichEditStyle.ParaStyles[StyleNo]);
    case UserData of
      PARA_ALIGNMENT:
        ParaInfo.Alignment := GetAlignmentFromUI;
      PARA_INDENTINC:
        begin
          ParaInfo.LeftIndent := ParaInfo.LeftIndent + 20;
          if ParaInfo.LeftIndent > 200 then
            ParaInfo.LeftIndent := 200;
        end;
      PARA_INDENTDEC:
        begin
          ParaInfo.LeftIndent := ParaInfo.LeftIndent - 20;
          if ParaInfo.LeftIndent < 0 then
            ParaInfo.LeftIndent := 0;
        end;
      PARA_COLOR:
        ParaInfo.Background.Color := cd.Color;
      // add your code here....
    end;
    NewStyleNo := RichEditStyle.FindParaStyle(ParaInfo);
  finally
    ParaInfo.Free;
  end;
end;

procedure TfrHTMLEdit.RichEditStyleConversion(Sender: TCustomRichViewEdit;
  StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
var
  FontInfo: TFontInfo;
begin
  FontInfo := TFontInfo.Create(nil);
  try
    FontInfo.Assign(RichEditStyle.TextStyles[StyleNo]);
    case UserData of
      TEXT_BOLD:
        if btnBold.Down then
          FontInfo.Style := FontInfo.Style + [fsBold]
        else
          FontInfo.Style := FontInfo.Style - [fsBold];
      TEXT_ITALIC:
        if btnItalic.Down then
          FontInfo.Style := FontInfo.Style + [fsItalic]
        else
          FontInfo.Style := FontInfo.Style - [fsItalic];
      TEXT_UNDERLINE:
        if btnUnderline.Down then
          FontInfo.Style := FontInfo.Style + [fsUnderline]
        else
          FontInfo.Style := FontInfo.Style - [fsUnderline];
      TEXT_APPLYFONTNAME:
        FontInfo.FontName := FontName;
      TEXT_APPLYFONTSIZE:
        FontInfo.Size := FontSize;
      TEXT_APPLYFONT:
        FontInfo.Assign(fd.Font);
      TEXT_COLOR:
        FontInfo.Color := cd.Color;
      TEXT_BACKCOLOR:
        FontInfo.BackColor := cd.Color;
      // add your code here....
    end;
    NewStyleNo := RichEditStyle.FindTextStyle(FontInfo);
  finally
    FontInfo.Free;
  end;
end;

function TfrHTMLEdit.Save: Boolean;
begin
  if FileName = '' then
    Result := SaveAs
  else
  begin
    RichEdit.SaveRVF(FileName, False);
    RichEdit.Modified := False;
    StatusBar.Panels[0].Text := '';
    Result := True;
  end;
end;

function TfrHTMLEdit.SaveAs: Boolean;
begin
  if sd.Execute then
  begin
    FileName := sd.FileName;
    Result := Save;
    if Result then
      Caption := ExtractFileName(FileName) + '- RDemo';
  end
  else
    Result := False;
end;

function TfrHTMLEdit.SaveIfNeeded: Boolean;
begin
  Result := True;
  if RichEdit.Modified then
    case Application.MessageBox('Save file now?', 'File was modified',
      MB_ICONQUESTION or MB_YESNOCANCEL) of
      IDYES:
        Result := Save;
      IDNO:
        Result := True;
      IDCANCEL:
        Result := False;
    end;
end;

procedure TfrHTMLEdit.SetAlignmentToUI(Alignment: TRVAlignment);
begin
  case Alignment of
    rvaLeft:
      btnAlignLeft.Down := True;
    rvaCenter:
      btnAlignCenter.Down := True;
    rvaRight:
      btnAlignRight.Down := True;
    rvaJustify:
      btnAlignJustify.Down := True;
  end;
end;

procedure TfrHTMLEdit.btnApplyParaClick(Sender: TObject);
var
  Button: TAdvToolButton;
  x: integer;
begin
  Button := Sender as TAdvToolButton;
  for x := 0 to Button.Parent.ControlCount -1 do begin
    if (Button.Parent.Controls[x] is TAdvToolButton) and
       (Button.Parent.Controls[x] <> Button) and
       (TAdvToolButton(Button.Parent.Controls[x]).GroupIndex = Button.GroupIndex) then
      TAdvToolButton(Button.Parent.Controls[x]).Down := false;

  end;
  RichEdit.ApplyParaStyleConversion(PARA_ALIGNMENT);
end;

procedure TfrHTMLEdit.FontStyleButtonClick(Sender: TObject);
var
  Button: TAdvToolButton;
begin
  Button := Sender as TAdvToolButton;
  // constants TEXT_BOLD, TEXT_ITALIC and TEXT_UNDERLINE are
  // assigned to the tags of corresponding buttons
  RichEdit.ApplyStyleConversion(Button.Tag);
end;

end.
