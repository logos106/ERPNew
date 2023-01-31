unit frmCompanyInfoCustomiseFrm;

interface
{$I ERP.inc}
uses
  Windows, Forms, Graphics, SysUtils, BaseInputForm, DB, Dialogs, DBCtrls, StdCtrls,
  Mask, Buttons, DNMSpeedButton, Controls, ComCtrls,AdvOfficeStatusBar, Classes, ExtCtrls, StrUtils, jpeg,
  AppEvnts, kbmMemTable, SelectionDialog, DNMPanel, wwcheckbox, DBAccess,
  MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader, ImgList,
  ProgressDialog;

type
  TfrmCompanyInfoCustomise = class(TBaseInputGUI)
    CompanyName_Label: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    txtPOCity: TDBEdit;
    Label30: TLabel;
    txtPOCountry: TDBEdit;
    PhoneNumber_Label: TLabel;
    txtPhoneNumber: TDBEdit;
    Label18: TLabel;
    txtABN: TDBEdit;
    frmCompanyInformationSrc: TDataSource;
    FontDialog1: TFontDialog;
    BitBtn1: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    BitBtn3: TDNMSpeedButton;
    BitBtn4: TDNMSpeedButton;
    BitBtn5: TDNMSpeedButton;
    Label1: TLabel;
    BitBtn6: TDNMSpeedButton;
    DefaultBodyText: TEdit;
    txtCompanyName: TDBMemo;
    txtPOBox: TDBMemo;
    EditCompanyName: TEdit;
    EditAddress: TEdit;
    EditSuburb: TEdit;
    EditPhone: TEdit;
    EditABN: TEdit;
    EditDefault: TEdit;
    FontCompanyName: TDBEdit;
    FontAddress: TDBEdit;
    FontSuburb: TDBEdit;
    FontPhone: TDBEdit;
    FontDefault: TDBEdit;
    SizeCompanyName: TDBEdit;
    ColorCompanyName: TDBEdit;
    StyleCompanyName: TDBEdit;
    SizeAddress: TDBEdit;
    SizeSuburb: TDBEdit;
    SizePhone: TDBEdit;
    SizeDefault: TDBEdit;
    ColorAddress: TDBEdit;
    ColorSuburb: TDBEdit;
    ColorPhone: TDBEdit;
    ColorDefault: TDBEdit;
    StyleAddress: TDBEdit;
    StyleSuburb: TDBEdit;
    StylePhone: TDBEdit;
    StyleDefault: TDBEdit;
    qryCompanyInfo: TERPQuery;
    DataSource1: TDataSource;
    PhoneNumber: TDBEdit;
    FaxNumber: TDBEdit;
    FontABN: TDBEdit;
    SizeABN: TDBEdit;
    ColorABN: TDBEdit;
    StyleABN: TDBEdit;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBMemo1: TDBMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    SpeedButton1: TDNMSpeedButton;
    DocumentTemplatePath: TDBEdit;
    Label69: TLabel;
    UseDocumentTemplate: TwwCheckBox;
    Label6: TLabel;
    Bevel1: TBevel;
    Label156: TLabel;
    OpenDialog1: TOpenDialog;
    Label7: TLabel;
    cboHideCompanyName: TwwCheckBox;
    cboHideAddress: TwwCheckBox;
    cboHideAddress2: TwwCheckBox;
    cboHideCity: TwwCheckBox;
    cboHideCountry: TwwCheckBox;
    cboHidePhoneNumber: TwwCheckBox;
    cboHideABN: TwwCheckBox;
    CompanyInfo: TMyTable;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label8: TLabel;
    DBMemo2: TDBMemo;
    cboHideAddress3: TwwCheckBox;
    RichEdit1: TRichEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RichEditRefresh;
    function GetFontStyle(Font: TFont): string;
    procedure FormShow(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure UseDocumentTemplateClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses FastFuncs,CommonDbLib, CommonLib;

  {$R *.dfm}

procedure TfrmCompanyInfoCustomise.BitBtn1Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font := EditCompanyName.Font;
  FontDialog1.Execute;
  EditCompanyName.Font := FontDialog1.Font;
  ColorCompanyName.Text := ColorToString(FontDialog1.Font.Color);
  if ColorCompanyName.Text = 'clWindowText' then ColorCompanyName.Text := 'clBlack';
  FontCompanyName.Text := FontDialog1.Font.Name;
  SizeCompanyName.Text := IntToStr(FontDialog1.Font.Size);
  StyleCompanyName.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

function TfrmCompanyInfoCustomise.GetFontStyle(Font: TFont): string;
var
  strFont: string;
begin
  strFont := '';
  if (fsBold in Font.Style) then begin
    strFont := strFont + 'B';
  end else begin
    strFont := strFont + 'N';
  end;

  if (fsItalic in Font.Style) then begin
    strFont := strFont + 'I';
  end else begin
    strFont := strFont + 'N';
  end;

  if (fsUnderline in Font.Style) then begin
    strFont := strFont + 'U';
  end else begin
    strFont := strFont + 'N';
  end;

  if (fsStrikeOut in Font.Style) then begin
    strFont := strFont + 's';
  end else begin
    strFont := strFont + 'N';
  end;

  GetFontStyle := strFont;
end;

procedure TfrmCompanyInfoCustomise.BitBtn2Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font := EditAddress.Font;
  FontDialog1.Execute;
  EditAddress.Font := FontDialog1.Font;
  ColorAddress.Text := ColorToString(FontDialog1.Font.Color);
  if ColorAddress.Text = 'clWindowText' then ColorAddress.Text := 'clBlack';
  FontAddress.Text := FontDialog1.Font.Name;
  SizeAddress.Text := IntToStr(FontDialog1.Font.Size);
  StyleAddress.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

procedure TfrmCompanyInfoCustomise.RichEditRefresh;
(* var
  LineStart: integer;
  txtLine: string; *)
  Procedure LinesAdd(Const Value:String);
  begin
    Try
      RichEdit1.Lines.Add(Value);
    Except
    End;
  end;
  Procedure AddLine(HideLine:boolean ; fontEdit:TEdit;ColorEdit:TDBEdit; Value:String );
  var
    i1, i2:Integer;
  begin
    if hideLine then Exit;
    RichEdit1.Paragraph.Alignment := taCenter;
    (* i1:= char_Length(RichEdit1.Text); if i1<> 0 then i1:= i1-1;
    i2:=char_Length(Value); *)
    LinesAdd(Value);
    if Value <> '' then begin
      i2:=char_Length(Value);
      i1:= (char_Length(TRim(RichEdit1.Text))-i2)-(RichEdit1.Lines.count-1);
      if i1<0 then i1 := 0;
      //i:= RichEdit1.FindText(Value, i, char_Length(RichEdit1.Text) , [stWholeWord , stMatchCase]);
      RichEdit1.SelStart           :=i1;
      RichEdit1.SelLength          :=i2;
      RichEdit1.SelAttributes.Name := fontEdit.Font.Name;
      RichEdit1.SelAttributes.Size := fontEdit.Font.Size;
      RichEdit1.SelAttributes.Style := fontEdit.Font.Style;
      if ColorEdit.Text <> '' then RichEdit1.SelAttributes.Color := StringToColor(ColorEdit.Text);
    end;
  end;
begin
  SetControlFocus(RichEdit1);
  with RichEdit1 do begin
    Lines.Clear;
    {Set Default Attributes}
    (* DefAttributes.Name := EditDefault.Font.Name;
    DefAttributes.Size := EditDefault.Font.Size; *)
    if ColorDefault.Text <> '' then DefAttributes.Color := StringToColor(ColorDefault.Text);
    AddLine(cboHideCompanyName.checked ,EditCompanyName ,ColorCompanyName , txtCompanyName.Text );
    AddLine(cboHideAddress.checked ,EditAddress ,ColorAddress , txtPOBox.Text );
    AddLine(cboHideAddress2.checked ,EditAddress ,ColorAddress , DBMemo1.Text );
    AddLine(cboHideAddress3.checked ,EditAddress ,ColorAddress , DBMemo2.Text );
    AddLine(cboHideCity.checked ,EditSuburb ,ColorSuburb , txtPOCity.Text );
    AddLine(cboHideCity.checked ,EditSuburb ,ColorSuburb , dbedit1.Text );
    AddLine(cboHideCity.checked ,EditSuburb ,ColorSuburb , dbedit2.Text );
    AddLine(cboHideCountry.checked ,EditSuburb ,ColorSuburb , txtPOCountry.Text );
    AddLine(cboHidePhoneNumber.checked ,EditPhone ,ColorPhone ,  'Phone: ' + PhoneNumber.Text + ' Fax: ' + FaxNumber.Text);
    AddLine(cboHideABN.checked ,EditABN ,ColorABN , 'ABN: ' + txtABN.Text );
    AddLine(False ,EditDefault ,ColorDefault , DefaultBodyText.text );
    RichEdit1.SelStart           :=0;
    RichEdit1.SelLength          :=0;
  end;
    (*

    txtLine := txtCompanyName.Text;
    if not cboHideCompanyName.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine)
      LineStart          :=char_length(txtLine)
      SelAttributes.Name := EditCompanyName.Font.Name;
      SelAttributes.Size := EditCompanyName.Font.Size;
      SelAttributes.Style := EditCompanyName.Font.Style;
      if ColorCompanyName.Text <> '' then SelAttributes.Color := StringToColor(ColorCompanyName.Text);
    end;
    LineStart := Length(RichEdit1.text);
    //Company Street Address
    txtLine := txtPOBox.Text;
    if not cboHideAddress.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditAddress.Font.Name;
      SelAttributes.Size := EditAddress.Font.Size;
      SelAttributes.Style := EditAddress.Font.Style;
      if ColorAddress.Text <> '' then SelAttributes.Color := StringToColor(ColorAddress.Text);
    end;
    LineStart := Length(RichEdit1.text);
    {Company Street Address2}
    txtLine := DBMemo1.Text;
    if not cboHideAddress2.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditAddress.Font.Name;
      SelAttributes.Size := EditAddress.Font.Size;
      SelAttributes.Style := EditAddress.Font.Style;
      if ColorAddress.Text <> '' then SelAttributes.Color := StringToColor(ColorAddress.Text);
    end;
    LineStart := Length(RichEdit1.text);
    txtLine := DBMemo2.Text;
    if not cboHideAddress3.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditAddress.Font.Name;
      SelAttributes.Size := EditAddress.Font.Size;
      SelAttributes.Style := EditAddress.Font.Style;
      if ColorAddress.Text <> '' then SelAttributes.Color := StringToColor(ColorAddress.Text);
    end;
    LineStart := Length(RichEdit1.text);

    {Company Suburb, State, Postcode}
    txtLine := txtPOCity.Text;
    if not cboHideCity.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditSuburb.Font.Name;
      SelAttributes.Size := EditSuburb.Font.Size;
      SelAttributes.Style := EditSuburb.Font.Style;
      if ColorSuburb.Text <> '' then SelAttributes.Color := StringToColor(ColorSuburb.Text);
    end;
    LineStart := Length(RichEdit1.text);
    {Company Country}

    txtLine := txtPOCountry.Text;
    if not cboHideCountry.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditSuburb.Font.Name;
      SelAttributes.Size := EditSuburb.Font.Size;
      SelAttributes.Style := EditSuburb.Font.Style;
      if ColorSuburb.Text <> '' then SelAttributes.Color := StringToColor(ColorSuburb.Text);
    end;
    LineStart := Length(RichEdit1.text);
    {Company Phone & Fax}
    txtLine := 'Phone: ' + PhoneNumber.Text + ' Fax: ' + FaxNumber.Text;
    if not cboHidePhoneNumber.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditPhone.Font.Name;
      SelAttributes.Size := EditPhone.Font.Size;
      SelAttributes.Style := EditPhone.Font.Style;
      if ColorPhone.Text <> '' then SelAttributes.Color := StringToColor(ColorPhone.Text);
    end;
    LineStart := Length(RichEdit1.text);
    {Company ABN}

    txtLine := 'ABN: ' + txtABN.Text;
    if not cboHideABN.Checked then begin
      Paragraph.Alignment := taCenter;
      LinesAdd(txtLine);
      SelStart           := linestart;
      SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
      LineStart          := LineStart +char_length(txtLine) +2;
      SelAttributes.Name := EditABN.Font.Name;
      SelAttributes.Size := EditABN.Font.Size;
      SelAttributes.Style := EditABN.Font.Style;
      if ColorABN.Text <> '' then SelAttributes.Color := StringToColor(ColorABN.Text);
    end;
    {Default Attributes from here!}
    {Two returns}
    LinesAdd('');
    LinesAdd('');
    LineStart := LineStart +2;
    {Date}
    Paragraph.Alignment := taRightJustify;
    txtLine := DateToStr(Now);
    LinesAdd(txtLine);
    SelStart           := linestart;
    SelLength          := (Length(RichEdit1.text) - linestart)-1;//char_length(txtLine) +2;
    LineStart := LineStart +char_length(txtLine) +2;
    if LineStart = 0 then;
    SelAttributes.Name  := EditDefault.Font.Name;
    SelAttributes.Size  := EditDefault.Font.Size;
    SelAttributes.Style := EditDefault.Font.Style;
    if ColorDefault.Text <> '' then SelAttributes.Color := StringToColor(ColorDefault.Text);
    LinesAdd('');
    Paragraph.Alignment := taLeftJustify;
  end; *)
end;

procedure TfrmCompanyInfoCustomise.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    BeginTransaction;
    qryCompanyInfo.ParamByName('SetupID').asInteger := KeyID;
    qryCompanyInfo.Open;
    CompanyInfo.Open;
    with CompanyInfo do begin
      Filtered := false;
      Filter   := 'SetupID = ' + QuotedStr(IntToStr(KeyID)) + ' OR ' + 'SetupID = NULL';;
      Filtered := true;
    end;
    EditDB(CompanyInfo);
    {Company Name}
    if FontCompanyName.Text <> '' then EditCompanyName.Font.Name := FontCompanyName.Text
    else EditCompanyName.Font.Name := 'Times New Roman';
    if ColorCompanyName.Text <> '' then EditCompanyName.Font.Color := StringToColor(ColorCompanyName.Text)
    else EditCompanyName.Font.Color := clBlack;
    if SizeCompanyName.Text <> '' then EditCompanyName.Font.Size := FastFuncs.StrToInt(SizeCompanyName.Text)
    else EditCompanyName.Font.Size := 36;
    if StyleCompanyName.Text <> '' then begin
      if FastFuncs.LeftStr(StyleCompanyName.Text, 1) = 'B' then EditCompanyName.Font.Style := [fsBold];
      if MidStr(StyleCompanyName.Text, 2, 1) = 'I' then EditCompanyName.Font.Style := EditCompanyName.Font.Style + [fsItalic];
      if MidStr(StyleCompanyName.Text, 3, 1) = 'U' then EditCompanyName.Font.Style :=
          EditCompanyName.Font.Style + [fsUnderline];
      if MidStr(StyleCompanyName.Text, 4, 1) = 'S' then EditCompanyName.Font.Style :=
          EditCompanyName.Font.Style + [fsStrikeOut];
    end else EditCompanyName.Font.Style := [fsBold, fsItalic];
    {Address}
    if FontAddress.Text <> '' then EditAddress.Font.Name := FontAddress.Text
    else EditAddress.Font.Name := 'Times New Roman';
    if ColorAddress.Text <> '' then EditAddress.Font.Color := StringToColor(ColorAddress.Text)
    else EditAddress.Font.Color := clBlack;
    if SizeAddress.Text <> '' then EditAddress.Font.Size := FastFuncs.StrToInt(SizeAddress.Text)
    else EditAddress.Font.Size := 22;
    if StyleAddress.Text <> '' then begin
      if FastFuncs.LeftStr(StyleAddress.Text, 1) = 'B' then EditAddress.Font.Style := [fsBold];
      if MidStr(StyleAddress.Text, 2, 1) = 'I' then EditAddress.Font.Style := EditAddress.Font.Style + [fsItalic];
      if MidStr(StyleAddress.Text, 3, 1) = 'U' then EditAddress.Font.Style := EditAddress.Font.Style + [fsUnderline];
      if MidStr(StyleAddress.Text, 4, 1) = 'S' then EditAddress.Font.Style := EditAddress.Font.Style + [fsStrikeOut];
    end else EditAddress.Font.Style := [fsBold, fsItalic];
    {Suburb & Country}
    if FontSuburb.Text <> '' then EditSuburb.Font.Name := FontSuburb.Text
    else EditSuburb.Font.Name := 'Times New Roman';
    if ColorSuburb.Text <> '' then EditSuburb.Font.Color := StringToColor(ColorSuburb.Text)
    else EditSuburb.Font.Color := clBlack;
    if SizeSuburb.Text <> '' then EditSuburb.Font.Size := FastFuncs.StrToInt(SizeSuburb.Text)
    else EditSuburb.Font.Size := 22;
    if StyleSuburb.Text <> '' then begin
      if FastFuncs.LeftStr(StyleSuburb.Text, 1) = 'B' then EditSuburb.Font.Style := [fsBold];
      if MidStr(StyleSuburb.Text, 2, 1) = 'I' then EditSuburb.Font.Style := EditSuburb.Font.Style + [fsItalic];
      if MidStr(StyleSuburb.Text, 3, 1) = 'U' then EditSuburb.Font.Style := EditSuburb.Font.Style + [fsUnderline];
      if MidStr(StyleSuburb.Text, 4, 1) = 'S' then EditSuburb.Font.Style := EditSuburb.Font.Style + [fsStrikeOut];
    end else EditSuburb.Font.Style := [fsBold, fsItalic];
    {Phone}
    if FontPhone.Text <> '' then EditPhone.Font.Name := FontPhone.Text
    else EditPhone.Font.Name := 'Times New Roman';
    if ColorPhone.Text <> '' then EditPhone.Font.Color := StringToColor(ColorPhone.Text)
    else EditPhone.Font.Color := clBlack;
    if SizePhone.Text <> '' then EditPhone.Font.Size := FastFuncs.StrToInt(SizePhone.Text)
    else EditPhone.Font.Size := 16;
    if StylePhone.Text <> '' then begin
      if FastFuncs.LeftStr(StylePhone.Text, 1) = 'B' then EditPhone.Font.Style := [fsBold];
      if MidStr(StylePhone.Text, 2, 1) = 'I' then EditPhone.Font.Style := EditPhone.Font.Style + [fsItalic];
      if MidStr(StylePhone.Text, 3, 1) = 'U' then EditPhone.Font.Style := EditPhone.Font.Style + [fsUnderline];
      if MidStr(StylePhone.Text, 4, 1) = 'S' then EditPhone.Font.Style := EditPhone.Font.Style + [fsStrikeOut];
    end else EditPhone.Font.Style := [fsBold, fsItalic];
    {ABN}
    if FontABN.Text <> '' then EditABN.Font.Name := FontABN.Text
    else EditABN.Font.Name := 'Times New Roman';
    if ColorABN.Text <> '' then EditABN.Font.Color := StringToColor(ColorABN.Text)
    else EditABN.Font.Color := clBlack;
    if SizeABN.Text <> '' then EditABN.Font.Size := FastFuncs.StrToInt(SizeABN.Text)
    else EditABN.Font.Size := 12;
    if StyleABN.Text <> '' then begin
      if FastFuncs.LeftStr(StyleABN.Text, 1) = 'B' then EditABN.Font.Style := [fsBold];
      if MidStr(StyleABN.Text, 2, 1) = 'I' then EditABN.Font.Style := EditABN.Font.Style + [fsItalic];
      if MidStr(StyleABN.Text, 3, 1) = 'U' then EditABN.Font.Style := EditABN.Font.Style + [fsUnderline];
      if MidStr(StyleABN.Text, 4, 1) = 'S' then EditABN.Font.Style := EditABN.Font.Style + [fsStrikeOut];
    end else EditABN.Font.Style := [];
    {Default}
    if FontDefault.Text <> '' then EditDefault.Font.Name := FontDefault.Text
    else EditDefault.Font.Name := 'Arial';
    if ColorDefault.Text <> '' then EditDefault.Font.Color := StringToColor(ColorDefault.Text)
    else EditDefault.Font.Color := clBlack;
    if SizeDefault.Text <> '' then EditDefault.Font.Size := FastFuncs.StrToInt(SizeDefault.Text)
    else EditDefault.Font.Size := 10;
    if StyleDefault.Text <> '' then begin
      if FastFuncs.LeftStr(StyleDefault.Text, 1) = 'B' then EditDefault.Font.Style := [fsBold];
      if MidStr(StyleDefault.Text, 2, 1) = 'I' then EditDefault.Font.Style := EditDefault.Font.Style + [fsItalic];
      if MidStr(StyleDefault.Text, 3, 1) = 'U' then EditDefault.Font.Style := EditDefault.Font.Style + [fsUnderline];
      if MidStr(StyleDefault.Text, 4, 1) = 'S' then EditDefault.Font.Style := EditDefault.Font.Style + [fsStrikeOut];
    end else EditDefault.Font.Style := [];
    RichEditRefresh;
    Label69.Enabled := UseDocumentTemplate.Checked;
    DocumentTemplatePath.Enabled := UseDocumentTemplate.Checked;
    SpeedButton1.Enabled := UseDocumentTemplate.Checked;
  finally
    EnableForm;
  end;  
end;

procedure TfrmCompanyInfoCustomise.cmdCancelClick(Sender: TObject);
begin
  inherited;
  CancelDB(CompanyInfo);
  RollbackTransaction;
  Self.Close;
end;

procedure TfrmCompanyInfoCustomise.cmdCloseClick(Sender: TObject);
begin
  inherited;
  EditDB(CompanyInfo);
  PostDB(CompanyInfo);
  CommitTransaction;
  Self.Close;
end;

procedure TfrmCompanyInfoCustomise.BitBtn3Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font := EditSuburb.Font;
  FontDialog1.Execute;
  EditSuburb.Font := FontDialog1.Font;
  ColorSuburb.Text := ColorToString(FontDialog1.Font.Color);
  if ColorSuburb.Text = 'clWindowText' then ColorSuburb.Text := 'clBlack';
  FontSuburb.Text := FontDialog1.Font.Name;
  SizeSuburb.Text := IntToStr(FontDialog1.Font.Size);
  StyleSuburb.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

procedure TfrmCompanyInfoCustomise.BitBtn4Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font := EditPhone.Font;
  FontDialog1.Execute;
  EditPhone.Font := FontDialog1.Font;
  ColorPhone.Text := ColorToString(FontDialog1.Font.Color);
  if ColorPhone.Text = 'clWindowText' then ColorPhone.Text := 'clBlack';
  FontPhone.Text := FontDialog1.Font.Name;
  SizePhone.Text := IntToStr(FontDialog1.Font.Size);
  StylePhone.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

procedure TfrmCompanyInfoCustomise.BitBtn5Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font:= EditABN.Font;
  FontDialog1.Execute;
  EditABN.Font := FontDialog1.Font;
  ColorABN.Text := ColorToString(FontDialog1.Font.Color);
  if ColorABN.Text = 'clWindowText' then ColorABN.Text := 'clBlack';
  FontABN.Text := FontDialog1.Font.Name;
  SizeABN.Text := IntToStr(FontDialog1.Font.Size);
  StyleABN.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

procedure TfrmCompanyInfoCustomise.BitBtn6Click(Sender: TObject);
begin
  inherited;
  FontDialog1.Font := EditDefault.Font;
  FontDialog1.Execute;
  EditDefault.Font := FontDialog1.Font;
  ColorDefault.Text := ColorToString(FontDialog1.Font.Color);
  if ColorDefault.Text = 'clWindowText' then ColorDefault.Text := 'clBlack';
  FontDefault.Text := FontDialog1.Font.Name;
  SizeDefault.Text := IntToStr(FontDialog1.Font.Size);
  StyleDefault.Text := GetFontStyle(FontDialog1.Font);
  Refresh;
  RichEditRefresh;
end;

procedure TfrmCompanyInfoCustomise.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CompanyInfo.Close;
  qryCompanyInfo.Close;
  Action := caFree;
end;

procedure TfrmCompanyInfoCustomise.FormCreate(Sender: TObject);
begin
  inherited;
  CompanyInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
end;


procedure TfrmCompanyInfoCustomise.UseDocumentTemplateClick(Sender: TObject);
begin
  inherited;
  Label69.Enabled := UseDocumentTemplate.Checked;
  DocumentTemplatePath.Enabled := UseDocumentTemplate.Checked;
  SpeedButton1.Enabled := UseDocumentTemplate.Checked;
end;

procedure TfrmCompanyInfoCustomise.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OpenDialog1.Execute then begin
    DocumentTemplatePath.Text := Opendialog1.FileName;
  end;
end;

procedure TfrmCompanyInfoCustomise.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  RichEditRefresh;
end;

Initialization
  RegisterClassOnce(TfrmCompanyInfoCustomise);

end.
