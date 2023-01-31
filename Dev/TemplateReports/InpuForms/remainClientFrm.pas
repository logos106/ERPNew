unit remainClientFrm;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, StrUtils,
  Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, ClipBrd,
  ToolWin, ActnList, ImgList, DB,  BaseInputForm, Mask, DBCtrls, MyAccess,ERPdbComponents,
  MemDS, DBAccess, DataState, SelectionDialog, AppEvnts, ProgressDialog;

type
  TReMainClient = class(TBaseInputGUI)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    Ruler: TPanel;
    FontDialog1: TFontDialog;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    Editor: TRichEdit;
    StatusBar: TAdvOfficeStatusBar;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrinTDNMSpeedButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CuTDNMSpeedButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    FontSize: TEdit;
    ToolButton11: TToolButton;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    ToolbarImages: TImageList;
    ActionList1: TActionList;
    FileNewCmd: TAction;
    FileOpenCmd: TAction;
    FileSaveCmd: TAction;
    FilePrintCmd: TAction;
    FileExitCmd: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Bevel1: TBevel;
    EditCutCmd: TAction;
    EditCopyCmd: TAction;
    EditPasteCmd: TAction;
    EditUndoCmd: TAction;
    EditFontCmd: TAction;
    FileSaveAsCmd: TAction;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FileEmailCmd: TAction;
    FileFaxCmd: TAction;
    Email: TEdit;
    N3: TMenuItem;
    DataSource1: TDataSource;
    qryCompanyInfo: TERPQuery;
    frmCompanyInformationSrc: TDataSource;
    ADOTable2: TMyTable;
    DataSource2: TDataSource;
    Fax: TEdit;
    tblDocPath: TMyTable;
    DataSource3: TDataSource;
    Referencetxt: TEdit;
    Edit1: TEdit;
    qryContact: TERPQuery;

    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure SwitchLanguage(Sender: TObject);
    procedure ActionList2Update(Action: TBasicAction; var Handled: boolean);
    procedure FileEmail(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FFileName: string;
    FUpdating: boolean;
    FDragOfs: integer;
    FDragging: boolean;
    function CurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetFileName(const FileName: string);
    procedure CheckFileSave;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure UpdateCursorPos;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure PerformFileOpen(const AFileName: string);
    procedure LoadEditor;
    procedure SetModified(Value: boolean);

  private
    fsContent: String;
    function EmployeeInfoSQL: String;
    function customerInfoSQL: String;
    function supplierInfoSQL: String;
    function MCInfoSQL: String;
    function contactInfoSQL: String;
    function OtherContactInfoSQL: String;
    function RepairInfoSQL: String;
    { Private declarations }
  public
    { Public declarations }
    CID         : integer;
    customerID  : Integer;
    SupplierID  : Integer;
    employeeID  : Integer;
    MarketingContactId: integer;
    OtherContactID    : integer;
    repairID          :Integer;
    Property Content :String read fsContent write fsContent;
  end;

  //var
  //  ReMainClient: TReMainClient;


implementation

uses FastFuncs,RichEdit, ShellAPI, ReInit,  CommonDbLib,
  CommonLib, AppEnvironment;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite   = 'OK to overwrite %s';
  sUntitled    = 'Untitled';
  sModified    = 'Modified';
  sColRowInfo  = 'Line: %3d   Col: %3d';

const
  RulerAdj  = 4 / 3;
  GutterWid = 6;

  ENGLISH = (SUBLANG_ENGLISH_US shl 10) or LANG_ENGLISH;
  FRENCH  = (SUBLANG_FRENCH shl 10) or LANG_FRENCH;
  GERMAN  = (SUBLANG_GERMAN shl 10) or LANG_GERMAN;

  {$R *.dfm}

procedure TReMainClient.SelectionChange(Sender: TObject);
begin
  with Editor.Paragraph do try
      FUpdating := true;
      FirstInd.Left := Trunc(FirstIndent * RulerAdj) - 4 + GutterWid;
      LeftInd.Left := Trunc((LeftIndent + FirstIndent) * RulerAdj) - 4 + GutterWid;
      RightInd.Left := Ruler.ClientWidth - 6 - Trunc((RightIndent + GutterWid) * RulerAdj);
      BoldButton.Down := fsBold in Editor.SelAttributes.Style;
      ItalicButton.Down := fsItalic in Editor.SelAttributes.Style;
      UnderlineButton.Down := fsUnderline in Editor.SelAttributes.Style;
      BulletsButton.Down := boolean(Numbering);
      FontSize.Text := IntToStr(Editor.SelAttributes.Size);
      FontName.Text := Editor.SelAttributes.Name;
      case Ord(Alignment) of
        0: LeftAlign.Down := true;
        1: RightAlign.Down := true;
        2: CenterAlign.Down := true;
      end;
      UpdateCursorPos;
    finally
      FUpdating := false;
    end;
end;

function TReMainClient.CurrText: TTextAttributes;
begin
  if Editor.SelLength > 0 then Result := Editor.SelAttributes
  else Result := Editor.DefAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: integer; Data: Pointer): integer;
  stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TReMainClient.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := true;
end;

procedure TReMainClient.SetFileName(const FileName: string);
begin
  FFileName := FileName;
  Caption := Format('%s - %s', [ExtractFileName(FileName), Application.Title]);
end;

procedure TReMainClient.CheckFileSave;
var
  SaveResp: integer;
begin
  if not Editor.Modified then Exit;
  SaveResp := CommonLib.MessageDlgXP_Vista(Format(sSaveChanges, [FFileName]), mtCustom, mbYesNoCancel, 0);
  case SaveResp of
    idYes: FileSave(Self);
//    idNo: {Nothing};
    idCancel: Abort;
  end;
end;

procedure TReMainClient.SetupRuler;
var
  I: integer;
  S: string;
begin
  Setlength(S, 201);
  I := 1;
  while I < 200 do begin
    S[I]     := #9;
    S[I + 1] := '|';
    Inc(I, 2);
  end;
  Ruler.Caption := S;
end;

procedure TReMainClient.SetEditRect;
var
  R: TRect;
begin
  with Editor do begin
    R := Rect(GutterWid, 0, ClientWidth - GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, longint(@R));
  end;
end;

{ Event Handlers }

procedure TReMainClient.FormCreate(Sender: TObject);
begin
  inherited;
  Content := '';
  MarketingContactId := 0;
  customerID:=0;
  SupplierID:=0;
  employeeID:=0;
  RepairID:=0;
  OtherContactID:=0;
  CID := 0;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
  GetFontNames;
  SetupRuler;
  SelectionChange(Self);
  CurrText.Name := string(DefFontData.Name);
  CurrText.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
//  ADOTable1.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryContact.Connection := CommonDbLib.GetSharedMyDacConnection;
  ADOTable2.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblDocPath.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCompanyInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TReMainClient.FileNew(Sender: TObject);
begin
  SetFileName(sUntitled);
  Editor.Lines.Clear;
  Editor.Modified := false;
  SetModified(false);
end;

procedure TReMainClient.PerformFileOpen(const AFileName: string);
begin
  Editor.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.Modified := false;
  SetModified(false);
end;

procedure TReMainClient.LoadEditor;
var
  LineStart: integer;
  txtLine: string;
  txtSave: string;
  FileName: string;
begin
  LineStart := 1;
  SetControlFocus(Editor);
  with Editor do begin
    Lines.Clear;
    {Set Default Attributes}
    if ADOTable2.FieldByName('FontDefault').AsString <> '' then DefAttributes.Name :=
        ADOTable2.FieldByName('FontDefault').AsString
    else DefAttributes.Name := 'Arial';
    if ADOTable2.FieldByName('SizeDefault').AsString <> '' then DefAttributes.Size :=
        ADOTable2.FieldByName('SizeDefault').AsInteger
    else DefAttributes.Size := 12;
    if ADOTable2.FieldByName('ColorDefault').AsString <> '' then DefAttributes.Color := StringToColor(ADOTable2.FieldByName('ColorDefault').AsString)
    else DefAttributes.Color := clBlack;
    if ADOTable2.FieldByName('StyleDefault').AsString <> '' then begin
      if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then DefAttributes.Style := [fsBold];
      if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 2, 1) = 'I' then DefAttributes.Style := DefAttributes.Style + [fsItalic];
      if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 3, 1) = 'U' then DefAttributes.Style := DefAttributes.Style + [fsUnderline];
      if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 4, 1) = 'S' then DefAttributes.Style := DefAttributes.Style + [fsStrikeOut];
    end else DefAttributes.Style := [];
    {Company Name}
    Paragraph.FirstIndent := Paragraph.FirstIndent + 25;
    if qryCompanyInfo.FieldByName('CompanyName').AsString <> '' then begin
      Paragraph.Alignment := taCenter;
      txtLine := qryCompanyInfo.FieldByName('CompanyName').AsString;
      Lines.Add(txtLine);
      SelStart := 0;
      SelLength :=char_length(txtLine) + 1; //2;
      LineStart :=char_length(txtLine) + 2;
      if ADOTable2.FieldByName('FontCompanyName').AsString <> '' then SelAttributes.Name := ADOTable2.FieldByName('FontCompanyName').AsString
      else SelAttributes.Name := 'Times New Roman';
      if ADOTable2.FieldByName('SizeCompanyName').AsString <> '' then SelAttributes.Size := ADOTable2.FieldByName('SizeCompanyName').AsInteger
      else SelAttributes.Size := 36;
      if ADOTable2.FieldByName('ColorCompanyName').AsString <> '' then SelAttributes.Color := StringToColor(ADOTable2.FieldByName('ColorCompanyName').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('StyleCompanyName').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    {Company Street Address}
    Paragraph.Alignment := taCenter;
    if qryCompanyInfo.FieldByName('Address').AsString <> '' then begin
      txtLine := qryCompanyInfo.FieldByName('Address').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      if ADOTable2.FieldByName('FontAddress').AsString <> '' then SelAttributes.Name := ADOTable2.FieldByName('FontAddress').AsString
      else SelAttributes.Name := 'Tahoma';
      if ADOTable2.FieldByName('SizeAddress').AsString <> '' then SelAttributes.Size := ADOTable2.FieldByName('SizeAddress').AsInteger
      else SelAttributes.Size := 22;
      if ADOTable2.FieldByName('ColorAddress').AsString <> '' then SelAttributes.Color := StringToColor(ADOTable2.FieldByName('ColorAddress').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('StyleAddress').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleAddress').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    {Company Suburb, State, Postcode}
    Paragraph.Alignment := taCenter;
    if qryCompanyInfo.FieldByName('Suburb').AsString <> '' then begin
      txtLine := qryCompanyInfo.FieldByName('Suburb').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      if ADOTable2.FieldByName('Fontsuburb').AsString <> '' then SelAttributes.Name := ADOTable2.FieldByName('Fontsuburb').AsString
      else SelAttributes.Name := 'Tahoma';
      if ADOTable2.FieldByName('Sizesuburb').AsString <> '' then SelAttributes.Size := ADOTable2.FieldByName('Sizesuburb').AsInteger
      else SelAttributes.Size := 18;
      if ADOTable2.FieldByName('Colorsuburb').AsString <> '' then SelAttributes.Color := StringToColor(ADOTable2.FieldByName('Colorsuburb').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('Stylesuburb').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('Stylesuburb').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('Stylesuburb').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('Stylesuburb').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('Stylesuburb').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    {Company Country}
    Paragraph.Alignment := taCenter;
    if qryCompanyInfo.FieldByName('Country').AsString <> '' then begin
      txtLine := qryCompanyInfo.FieldByName('Country').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      if ADOTable2.FieldByName('FontSuburb').AsString <> '' then SelAttributes.Name := ADOTable2.FieldByName('FontSuburb').AsString
      else SelAttributes.Name := 'Tahoma';
      if ADOTable2.FieldByName('SizeSuburb').AsString <> '' then SelAttributes.Size := ADOTable2.FieldByName('SizeSuburb').AsInteger
      else SelAttributes.Size := 18;
      if ADOTable2.FieldByName('ColorSuburb').AsString <> '' then SelAttributes.Color := StringToColor(ADOTable2.FieldByName('ColorSuburb').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('StyleSuburb').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleSuburb').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    {Company Phone & Fax}
    Paragraph.Alignment := taCenter;
    if qryCompanyInfo.FieldByName('Phone').AsString <> '' then begin
      txtLine := qryCompanyInfo.FieldByName('Phone').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      if ADOTable2.FieldByName('FontPhone').AsString <> '' then SelAttributes.Name :=
          ADOTable2.FieldByName('FontPhone').AsString
      else SelAttributes.Name := 'Tahoma';
      if ADOTable2.FieldByName('SizePhone').AsString <> '' then SelAttributes.Size :=
          ADOTable2.FieldByName('SizePhone').AsInteger
      else SelAttributes.Size := 12;
      if ADOTable2.FieldByName('ColorPhone').AsString <> '' then SelAttributes.Color := StringToColor(ADOTable2.FieldByName('ColorPhone').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('StylePhone').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('StylePhone').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    {Company ABN}
    Paragraph.Alignment := taCenter;
    if qryCompanyInfo.FieldByName('ABN').AsString <> '' then begin
      txtLine := qryCompanyInfo.FieldByName('ABN').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      if ADOTable2.FieldByName('FontABN').AsString <> '' then SelAttributes.Name :=
          ADOTable2.FieldByName('FontABN').AsString
      else SelAttributes.Name := 'Tahoma';
      if ADOTable2.FieldByName('SizeABN').AsString <> '' then SelAttributes.Size :=
          ADOTable2.FieldByName('SizeABN').AsInteger
      else SelAttributes.Size := 12;
      if ADOTable2.FieldByName('ColorABN').AsString <> '' then SelAttributes.Color :=
          StringToColor(ADOTable2.FieldByName('ColorABN').AsString)
      else SelAttributes.Color := clBlack;
      if ADOTable2.FieldByName('StyleABN').AsString <> '' then begin
        if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleABN').AsString, 1) = 'B' then SelAttributes.Style := [fsBold];
        if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 2, 1) = 'I' then SelAttributes.Style := SelAttributes.Style + [fsItalic];
        if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 3, 1) = 'U' then SelAttributes.Style := SelAttributes.Style + [fsUnderline];
        if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 4, 1) = 'S' then SelAttributes.Style := SelAttributes.Style + [fsStrikeOut];
      end else SelAttributes.Style := [fsBold, fsItalic];
    end;
    qryContact.SQL.Clear;
    if CID > 0 then begin
      qryContact.SQL.Add(contactInfoSQL);
    end else if MarketingContactId > 0 then begin
      qryContact.SQL.Add(MCInfoSQL);
    end else if customerID>0 then begin
      qryContact.SQL.Add(customerInfoSQL);
    end else if SupplierID>0 then begin
      qryContact.SQL.Add(SupplierInfoSQL);
    end else if employeeID>0 then begin
      qryContact.SQL.Add(EmployeeInfoSQL);
    end else if OtherContactID >0 then begin
      qryContact.SQL.Add(OthercontactInfoSQL);
    end else if RepairId >0 then begin
      qryContact.SQL.Add(REpairInfoSQL);
    end;
    qryContact.Open;


//    ADOTable1.Filter   := 'ContactID=' + QuotedStr(IntToStr(CID));
//    ADOTable1.Filtered := true;
    {Letter}
    if Fax.Text = '' then begin
      //    if Caption = 'Letter' then begin
      {Default Attributes from here!}
      {Two returns}
      Lines.Add('');
      Lines.Add('');
      {Date}
      Paragraph.Alignment := taRightJustify;
      txtLine := DateToStr(Now);
      Lines.Add(txtLine);
      {Two returns}
      Lines.Add('');
      Lines.Add('');
      {Contact Name}
      Paragraph.Alignment := taLeftJustify;
      txtLine := '';
      if qryContact.FieldByName('ContactTitle').AsString <> '' then txtLine := qryContact.FieldByName('ContactTitle').AsString + ' ';
      if qryContact.FieldByName('ContactFirstName').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactFirstName').AsString + ' ';
      if qryContact.FieldByName('ContactSurName').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactSurName').AsString;
      Lines.Add(txtLine);
      {Contact Company}
      txtLine := '';
      if qryContact.FieldByName('Company').AsString <> '' then txtLine := qryContact.FieldByName('Company').AsString;
      Lines.Add(txtLine);
      {Contact Address}
      txtLine := '';
      if qryContact.FieldByName('ContactAddress').AsString <> '' then txtLine := qryContact.FieldByName('ContactAddress').AsString + ' ';
      if qryContact.FieldByName('ContactAddress2').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactAddress2').AsString;
      Lines.Add(txtLine);
      {Contact Suburb/State/Postcode}
      txtLine := '';
      if qryContact.FieldByName('ContactCity').AsString <> '' then txtLine := qryContact.FieldByName('ContactCity').AsString + ' ';
      if qryContact.FieldByName('ContactState').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactState').AsString + ' ';
      if qryContact.FieldByName('ContactPcode').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactPcode').AsString;
      Lines.Add(txtLine);
      {Two returns}
      Lines.Add('');
      Lines.Add('');
      {Salutation}
      txtLine := '';
      if qryContact.FieldByName('ContactFirstName').AsString <> '' then txtLine := 'Dear ' + qryContact.FieldByName('ContactFirstName').AsString;
      Lines.Add(txtLine);
      {Close Contact Table}
      qryContact.Close;
      {One returns}
      Lines.Add('');
    end else begin
      {Fax}
      Paragraph.Alignment := taCenter;
      txtLine := 'FAX';
      Lines.Add(txtLine);
      SelStart := LineStart;
      SelLength :=char_length(txtLine) + 2;
      LineStart := LineStart +char_length(txtLine) + 2;
      SelAttributes.Name := 'Arial';
      SelAttributes.Size := 24;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      {Two returns}
      Lines.Add('');
      Lines.Add('');
      {Fax To}
      Paragraph.Alignment := taLeftJustify;
      txtLine := 'To: ';
      if qryContact.FieldByName('ContactTitle').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactTitle').AsString + ' ';
      if qryContact.FieldByName('ContactFirstName').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactFirstName').AsString + ' ';
      if qryContact.FieldByName('ContactSurName').AsString <> '' then txtLine := txtLine + qryContact.FieldByName('ContactSurName').AsString;
      txtSave := txtLine;
      if qryContact.FieldByName('ContactFax').AsString <> '' then txtLine := txtLine + '                              Fax No: ' + qryContact.FieldByName('ContactFax').AsString
      else txtLine := txtLine + '                              Fax No: ';
      txtSave := txtSave + '                              ';
      Lines.Add(txtLine);
      SelStart := LineStart + 4;
      SelLength := 4;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      SelStart := LineStart +char_length(txtSave) + 4;
      SelLength := 7;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      LineStart := LineStart +char_length(txtLine) + 2;
      {One Return}
      Lines.Add('');
      {Fax From}
      Paragraph.Alignment := taLeftJustify;
      txtLine := 'From: ';
      if AppEnv.Employee.FirstName <> '' then txtLine := txtLine + AppEnv.Employee.FirstName + Chr(32);
      if AppEnv.Employee.LastName <> '' then txtLine := txtLine + AppEnv.Employee.LastName;
      Lines.Add(txtLine);
      SelStart := LineStart + 6;
      SelLength := 5;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      LineStart := LineStart +char_length(txtLine) + 2;
      {Date}
      txtLine := 'Date: ';
      if qryCompanyInfo.FieldByName('FaxDate').AsString <> '' then txtLine := txtLine + qryCompanyInfo.FieldByName('FaxDate').AsString;
      Lines.Add(txtLine);
      SelStart := LineStart + 6;
      SelLength := 5;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      LineStart := LineStart +char_length(txtLine) + 2;
      {No Pages}
      txtLine := 'No. Pages: ';
      Lines.Add(txtLine);
      SelStart := LineStart + 6;
      SelLength := 10;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      LineStart := LineStart +char_length(txtLine) + 2;
      {Re}
      txtLine := 'Re: ';
      Lines.Add(txtLine);
      SelStart := LineStart + 6;
      SelLength := 3;
      SelAttributes.Color := clBlack;
      SelAttributes.Style := [fsBold];
      //LineStart := LineStart +char_length(txtLine) + 2;
      qryContact.Close;
      {One returns}
      Lines.Add('');
    end;
  end;
  if tblDocPath.FieldByName('DocumentPath').AsString <> '' then FileName := tblDocPath.FieldByName('DocumentPath').AsString + '\' + Referencetxt.Text + '.RTF'
  else FileName := 'C:\' + Referencetxt.Text + '.RTF';
  Editor.Lines.Add(Content);
  Editor.Lines.SaveToFile(FileName);
  SetFileName(FileName);
  Editor.Modified := false;
  SetModified(false);
end;

function TReMainclient.customerInfoSQL:String ;
begin
  result := '      select ' +
            '  company    as Company, ' +
            '  Title      as ContactTitle, ' +
            '  FirstName  as ContactFirstName, ' +
            '  LastName   as ContactSurname, ' +
            '  Street     as ContactAddress, ' +
            '  Street2    as ContactAddress2, ' +
            '  Street3    as ContactAddress3, ' +
            '  Suburb     as ContactCity, ' +
            '  State      as ContactState, ' +
            '  PostCode   as ContactPCode, ' +
            '  FaxNumber  as ContactFax ' +
            '  from tblclients  where   clientId = ' + inttostr(CustomerID);

end;
function TReMainclient.supplierInfoSQL:String ;
begin
  result := '      select ' +
            '  company    as Company, ' +
            '  Title      as ContactTitle, ' +
            '  FirstName  as ContactFirstName, ' +
            '  LastName   as ContactSurname, ' +
            '  Street     as ContactAddress, ' +
            '  Street2    as ContactAddress2, ' +
            '  Street3    as ContactAddress3, ' +
            '  Suburb     as ContactCity, ' +
            '  State      as ContactState, ' +
            '  PostCode   as ContactPCode, ' +
            '  FaxNumber  as ContactFax ' +
            '  from tblclients  where   clientId = ' + inttostr(SupplierID);

end;
function TReMainclient.contactInfoSQL:String ;
begin
    result := 'select * from tblContacts where ContactID = ' + IntToStr(CID);
end;
function TReMainclient.EmployeeInfoSQL:String ;
begin
  result := '      select ' +
            '  employeeName as Company, ' +
            '  Title        as ContactTitle, ' +
            '  FirstName    as ContactFirstName, ' +
            '  LastName     as ContactSurname, ' +
            '  Street       as ContactAddress, ' +
            '  Street2      as ContactAddress2, ' +
            '  Street3      as ContactAddress3, ' +
            '  Suburb       as ContactCity, ' +
            '  State        as ContactState, ' +
            '  PostCode     as ContactPCode, ' +
            '  FaxNumber    as ContactFax ' +
            '  from tblemployees  where   employeeId = ' + inttostr(EmployeeID)
end;
function TReMainclient.MCInfoSQL:String ;
begin
  result := '      select ' +
            '  company      as Company, ' +
            '  Title        as ContactTitle, ' +
            '  FirstName    as ContactFirstName, ' +
            '  LastName     as ContactSurname, ' +
            '  Street       as ContactAddress, ' +
            '  Street2      as ContactAddress2, ' +
            '  Street3      as ContactAddress3, ' +
            '  Suburb       as ContactCity, ' +
            '  State        as ContactState, ' +
            '  PostCode     as ContactPCode, ' +
            '  FaxNumber    as ContactFax ' +
            '  from tblMarketingContacts where ID = ' + inttostr(MarketingcontactID);
end;

function TReMainclient.OtherContactInfoSQL:String ;
begin
  result := '      select ' +
            '  company    as Company, ' +
            '  Title      as ContactTitle, ' +
            '  FirstName  as ContactFirstName, ' +
            '  LastName   as ContactSurname, ' +
            '  Street     as ContactAddress, ' +
            '  Street2    as ContactAddress2, ' +
            '  Street3    as ContactAddress3, ' +
            '  Suburb     as ContactCity, ' +
            '  State      as ContactState, ' +
            '  PostCode   as ContactPCode, ' +
            '  FaxNumber  as ContactFax ' +
            '  from tblclients  where   clientId = ' + inttostr(OthercontactID);
end;
function TReMainclient.RepairInfoSQL:String ;
begin
  result := '      select ' +
            '  ifnull(C.Company 				, CL.Company	) as Company, ' +
            '  ifnull(C.contactTitle 		, CL.Title		) as ContactTitle, ' +
            '  ifnull(C.contactFirstName, CL.FirstName) as ContactFirstName, ' +
            '  ifnull(C.contactSurName 	, CL.LastName	) as ContactSurname, ' +
            '  ifnull(C.contactAddress 	, CL.Street		) as ContactAddress, ' +
            '  ifnull(C.contactAddress2 , CL.Street2	) as ContactAddress2, ' +
            '  ifnull(C.contactAddress3 , CL.Street3	) as ContactAddress3, ' +
            '  ifnull(C.contactCity 		, CL.Suburb		) as ContactCity, ' +
            '  ifnull(C.contactState 		, CL.State		) as ContactState, ' +
            '  ifnull(C.contactPcode 		, CL.PostCode	) as ContactPCode, ' +
            '  ifnull(C.contactFax 			, CL.FaxNumber) as ContactFax ' +
            '  from tblrepairs R ' +
            '  left join tblcontacts C on C.ContactID = R.ContactID ' +
            '  inner join tblclients CL on R.CusID = CL.ClientID where R.repairId = ' + inttostr(RepairID);
end;

procedure TReMainClient.FileOpen(Sender: TObject);
begin
  CheckFileSave;
  if OpenDialog.Execute then begin
    PerformFileOpen(OpenDialog.FileName);
    Editor.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TReMainClient.FileSave(Sender: TObject);
begin
  if FFileName = sUntitled then FileSaveAs(Sender)
  else begin
    Editor.Lines.SaveToFile(FFileName);
    Editor.Modified := false;
    SetModified(false);
  end;
end;

procedure TReMainClient.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    if FileExists(SaveDialog.FileName) then if CommonLib.MessageDlgXP_Vista(Format(sOverWrite, [SaveDialog.FileName]),
        mtCustom, mbYesNoCancel, 0) <> idYes then Exit;
    Editor.Lines.SaveToFile(SaveDialog.FileName);
    SetFileName(SaveDialog.FileName);
    Editor.Modified := false;
    SetModified(false);
  end;
end;

procedure TReMainClient.FilePrint(Sender: TObject);
begin
  if PrintDialog.Execute then Editor.Print(FFileName);
end;

procedure TReMainClient.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TReMainClient.EditUndo(Sender: TObject);
begin
  with Editor do if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TReMainClient.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TReMainClient.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TReMainClient.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TReMainClient.SelectFont(Sender: TObject);
begin
  FontDialog1.Font.Assign(Editor.SelAttributes);
  if FontDialog1.Execute then CurrText.Assign(FontDialog1.Font);
  SelectionChange(Self);
  SetControlFocus(Editor);
end;

procedure TReMainClient.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left * 2);
end;

procedure TReMainClient.FormResize(Sender: TObject);
begin
  SetEditRect;
  SelectionChange(Sender);
end;

procedure TReMainClient.FormPaint(Sender: TObject);
begin
  SetEditRect;
end;

procedure TReMainClient.BoldButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then CurrText.Style := CurrText.Style + [fsBold]
  else CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TReMainClient.ItalicButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then CurrText.Style := CurrText.Style + [fsItalic]
  else CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TReMainClient.FontSizeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  try
    CurrText.Size := FastFuncs.StrToInt(FontSize.Text);
  except
    on e: exception do begin
      CommonLib.MessageDlgXP_Vista('Invalid font size.', mtInformation, [mbOk],0);
      FontSize.Text:= IntToStr(CurrText.Size);
      SetControlFocus(FontSize);
    end;
  end;
end;

procedure TReMainClient.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TReMainClient.FontNameChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TReMainClient.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then CurrText.Style := CurrText.Style + [fsUnderline]
  else CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TReMainClient.BulletsButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

procedure TReMainClient.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  try
    CheckFileSave;
  except
    CanClose := false;
  end;
end;

{ Ruler Indent Dragging }

procedure TReMainClient.RulerItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs;
  FDragging := true;
end;

procedure TReMainClient.RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if FDragging then TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs
end;

procedure TReMainClient.FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FDragging := false;
  Editor.Paragraph.FirstIndent := Trunc((FirstInd.Left + FDragOfs - GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TReMainClient.LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FDragging := false;
  Editor.Paragraph.LeftIndent := Trunc((LeftInd.Left + FDragOfs - GutterWid) / RulerAdj) - Editor.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TReMainClient.RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  FDragging := false;
  Editor.Paragraph.RightIndent := Trunc((Ruler.ClientWidth - RightInd.Left + FDragOfs - 2) / RulerAdj) - 2 * GutterWid;
  SelectionChange(Sender);
end;

procedure TReMainClient.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
  CharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TReMainClient.FormShow(Sender: TObject);
var
  FileName: string;
begin
  DisableForm;
  try
//    ADOTable1.Open;
    ADOTable2.Open;
    tblDocPath.Open;
    qryCompanyInfo.Open;
    UpdateCursorPos;
    DragAcceptFiles(Handle, true);
    RichEditChange(nil);
    SetControlFocus(Editor);

    if tblDocPath.FieldByName('DocumentPath').AsString <> '' then FileName := tblDocPath.FieldByName('DocumentPath').AsString + '\' + Referencetxt.Text + '.RTF'
    else FileName := 'C:\' + Referencetxt.Text + '.RTF';

    { Check if we should load a file from the command line }
    if (ParamCount > 0) and FileExists(ParamStr(1)) then PerformFileOpen(ParamStr(1))
    else if (Edit1.Text = 'True') and FileExists(FileName) then PerformFileOpen(FileName)
    else LoadEditor;
  finally
    EnableForm;
  end;  
end;

procedure TReMainClient.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then begin
      CheckFileSave;
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TReMainClient.RichEditChange(Sender: TObject);
begin
  SetModified(Editor.Modified);
end;

procedure TReMainClient.SetModified(Value: boolean);
begin
  if Value then StatusBar.Panels[1].Text := sModified
  else StatusBar.Panels[1].Text          := '';
end;

procedure TReMainClient.SwitchLanguage(Sender: TObject);
var
  Name: string;
  Size: integer;
begin
  if LoadNewResourceModule(TComponent(Sender).Tag) <> 0 then begin
    Name := FontName.Text;
    Size := FastFuncs.StrToInt(FontSize.Text);
    ReinitializeForms;
    CurrText.Name := Name;
    CurrText.Size := Size;
    SelectionChange(Self);
    FontName.SelLength := 0;

    SetupRuler;
    SetControlFocus(Editor);
  end;
end;

procedure TReMainClient.ActionList2Update(Action: TBasicAction; var Handled: boolean);
begin
  { Update the status of the edit commands }
  EditCutCmd.Enabled := Editor.SelLength > 0;
  EditCopyCmd.Enabled := EditCutCmd.Enabled;
  if Editor.HandleAllocated then begin
    EditUndoCmd.Enabled  := Editor.Perform(EM_CANUNDO, 0, 0) <> 0;
    EditPasteCmd.Enabled := Editor.Perform(EM_CANPASTE, 0, 0) <> 0;
  end;
end;


procedure TReMainClient.FileEmail(Sender: TObject);
var
  strMsg: string;
  I: integer;
begin
  inherited;
  strMsg := 'mailto:' + Email.Text + '&body=';
  if Editor.Lines.Count > 0 then strMsg := strMsg + Editor.Lines[0];
  for I := 1 to Editor.Lines.Count - 1 do strMsg := strMsg + '%0D%0A' + Editor.Lines[I];
  ShellExecute(Handle, 'open', PChar(strMsg), '', '', SW_SHOW);
end;

procedure TReMainClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qryCompanyInfo.Close;
//  ADOTable1.Close;
  ADOTable2.Close;
  tblDocPath.Close;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TReMainClient);
end.


