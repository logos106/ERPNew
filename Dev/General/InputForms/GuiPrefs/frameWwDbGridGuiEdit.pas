unit frameWwDbGridGuiEdit;

{

 Date     Version  Who Comment
 -------- -------- --- ---------------------------------------------------------
 16/09/05  1.00.00 MV  Modified procedures actAddExecute, DoColumnSelect,
                       FormulaItemClick, SaveDisplayFormat, SaveSumColumn and
                       SaveFormula to support const GUI_PREF_CUSTOM_COLUMN_TAG
                       to address tag conflict in PersonalTabStop
 03/10/05  1.00.01 ISB AddedComponentNameExists
 06/01/06  1.00.02 DSP Changed FieldName to DisplayLabel when displaying
                       column titles.
 17/01/06  1.00.03 DSP Added field ItemEdit to TfrWwDbGridGuiEdit to allow the
                       column names to be edited by the user. This is done by
                       double-clicking on a column name.
 18/01/06  1.00.04 DSP Added test for paired fields, i.e. only display the
                       visible field of paired fields unless neither of them
                       is visible (then display both).
 25/01/06  1.00.05 DSP Added 'Double click on name to change label' to 'Columns'
                       label.
 09/02/06  1.00.06 DSP Removed code that changes a field's index when a field's
                       visible property is altered
 24/04/06  1.00.07 DSP Enabled 'Column Formula' and 'Display Format' when a new
                       custom field is generated.

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  DataTreeObj, StdCtrls, Buttons, DNMSpeedButton, CheckLst, ExtCtrls, wwDBGrid, ActnList, DB,
  Menus, AdvMenus, ParserObj, frameGuiElementEdit, ComCtrls,AdvOfficeStatusBar, GuiPrefsObj, AppEvnts,
  DNMPanel, wwcheckbox, dmGUIStylers;

type
  TfrWwDbGridGuiEdit = class(TfrGuiElementEdit)
    alColumns: TActionList;
    actAdd: TAction;
    actDelete: TAction;
    pumFormula: TAdvPopupMenu;
    mnuColumns: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    multiply1: TMenuItem;
    divide1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    actCheckFormula: TAction;
    dlgFont: TFontDialog;
    dlgColor: TColorDialog;
    pnlGrid: TDNMPanel;
    pnlCustColumn: TDNMPanel;
    grpCustColumn: TGroupBox;
    lblFormula: TLabel;
    lblFormat: TLabel;
    btnAddCustColumn: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    edtFieldFormula: TEdit;
    edtFormat: TEdit;
    btnCheckFormula: TDNMSpeedButton;
    pnlColumns: TDNMPanel;
    pnlColumnsTop: TDNMPanel;
    Label1: TLabel;
    pnlColumnsLeft: TDNMPanel;
    lstGridColumns: TCheckListBox;
    btnGridTitleFont: TDNMSpeedButton;
    btnGridFont: TDNMSpeedButton;
    btnAltRowColour: TDNMSpeedButton;
    chkSumColumn: TwwCheckBox;
    chkGridLines: TwwCheckBox;
    Label2: TLabel;
    pnlSearch: TDNMPanel;
    edtSearch: TEdit;
    btnearchnext: TDNMSpeedButton;
    Label3: TLabel;
    Shape1: TShape;
    procedure lstGridColumnsClickCheck(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure lstGridColumnslClick(Sender: TObject);
    procedure pumFormulaPopup(Sender: TObject);
    procedure FormulaItemClick(Sender: TObject);
    procedure edtFieldFormulaExit(Sender: TObject);
    procedure edtFormatExit(Sender: TObject);
    procedure actCheckFormulaExecute(Sender: TObject);
    procedure chkSumColumnClick(Sender: TObject);
    procedure btnGridFontClick(Sender: TObject);
    procedure btnGridTitleFontClick(Sender: TObject);
    procedure btnAltRowColourClick(Sender: TObject);
    procedure chkGridLinesClick(Sender: TObject);
    procedure lstGridColumnsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lstGridColumnsDblClick(Sender: TObject);
    procedure btnearchnextClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fCurrentItemIndex: Integer;
    fShowItemEdit: Boolean;
    Parser: TMathParser;
    ItemEdit: TEdit;
    fiSearchindex:Integer;
    fiSearchKey:word;
    function GetDataset: TDataset;
    procedure DoColumnSelect;
    function FieldNameExists(aDataset: TDataset; const aFieldName: string): boolean;
    function ComponentNameExists(aDataset: TDataset; const aComponentName: string): boolean;
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var Found: boolean);
    function CheckFormula(var msg: string): boolean;
    function SaveFormula: boolean;
    procedure SaveDisplayFormat;
    procedure SaveSumColumn;
    function GetSelectedField: TField;
    function CustColumns: TDataTreeNode;
    function GetGrid: TwwDbGrid;
    property Dataset: TDataset read GetDataset;
    function GetGridGuiElement: TwwDbGridGuiElement;
    procedure ClearColumnList;
    procedure SetShowItemEdit(const Value: Boolean);
    procedure SetItemValue(Sender: TObject);
    procedure InitialiseItemEdit;
    procedure SetFieldVisibility(Fld: TField);
    function IsMandatoryField(Fld: TField):Boolean;
    Function goSearch(RestartSearch: Boolean;Key: Word):Boolean;
  protected
    procedure ShowColumns;
    property GridGuiElement: TwwDbGridGuiElement read GetGridGuiElement;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisplayGuiSettings(fUserID:Integer =0); override;
    property Grid: TwwDbGrid read GetGrid;
    property ShowItemEdit: Boolean read fShowItemEdit write SetShowItemEdit;
  end;

  TColumnListItem = class(TObject)
  private
    fFieldName: string;
    fIsCustomColumn: boolean;
  public
    constructor Create;
    property FieldName: string read fFieldName write fFieldName;
    property IsCustomColumn: boolean read fIsCustomColumn write fIsCustomColumn;
  end;

implementation

{$R *.dfm}

uses
  Forms, Wwdbigrd, CommonLib, 
  tcConst,FastFuncs, AppEnvironment, GridFieldsObj, ERPdbComponents, LogLib;

const
  CUST_COLUMN_LABEL = '[Custom Column]';

  { TColumnListItem }

constructor TColumnListItem.Create;
begin
  inherited;
  fFieldName := '';
  fIsCustomColumn := false;
end;

{ TfrCustomiseDBGrid }

constructor TfrWwDbGridGuiEdit.Create(AOwner: TComponent);
begin
  inherited;
  fCurrentItemIndex := -1;
  fShowItemEdit := True;
  Parser := TMathParser.Create(self);
  Parser.OnGetVar := DoGetParserVariable;
  ItemEdit := TEdit.Create(Self);
  InitialiseItemEdit;
  fiSearchindex:= -1;
  fiSearchKey:= 0;
  pnlSearch.visible := devmode;
end;

function TfrWwDbGridGuiEdit.GetGrid: TwwDbGrid;
begin
  if Assigned(Element) then Result := TwwDbGrid(Element.Target)
  else Result := nil;
end;

function TfrWwDbGridGuiEdit.GetDataset: TDataset;
begin
  if Assigned(Grid) then Result := Grid.DataSource.DataSet
  else Result := nil;
end;

procedure TfrWwDbGridGuiEdit.ShowColumns;
var
  x, idx: integer;
  ColItem: TColumnListItem;
  FieldName: string;
  PairedName: string;
  HiddenFields: TStrings;
  BothHidden: Boolean;
  MainfieldName : String;
  fbLinkedfield :Boolean;
  fsGroupname :STring;
begin
    fbLinkedfield := False;
  if (not Assigned(Element)) then Exit;

  ClearColumnList;
  HiddenFields := TwwDbGridGuiElement(Element).HiddenFields;

  for x := 0 to DataSet.FieldCount - 1 do begin
    BothHidden := False;
    FieldName := DataSet.Fields[x].FieldName;
    PairedName := TwwDbGridGuiElement(Element).PairedField(FieldName);

    if PairedName <> '' then begin
      if (DataSet.Fields[x].Visible = False) and (DataSet.FieldByName(PairedName).Visible = False) then
        BothHidden := True;
    end
    else
      fbLinkedfield:= TwwDbGridGuiElement(Element).IsLinkedfield(FieldName , mainFieldName, fsGroupname) ;

    if (not(fbLinkedfield)) then
        if (BothHidden and (HiddenFields.IndexOf(FieldName) = -1)) or
           ((HiddenFields.IndexOf(FieldName) = -1) and
           (not ((TwwDbGridGuiElement(Element).IsPairedField(FieldName)) and
                (DataSet.Fields[x].Visible = False))))  then begin
            ColItem := TColumnListItem.Create;
            ColItem.FieldName := FieldName;

            if CustColumns.Exists(FieldName) then
                ColItem.IsCustomColumn := True;
            if TwwDbGridGuiElement(Element).IsLinkedMain(FieldName, fsGroupname) then
                idx := lstGridColumns.Items.AddObject(fsGroupname, ColItem)
            else
                idx := lstGridColumns.Items.AddObject(DataSet.Fields[x].DisplayLabel, ColItem);
            lstGridColumns.Checked[idx] := Dataset.Fields[x].Visible;
            if ColITem.IsCustomColumn then begin
                lstGridColumns.Items[idx] := lstGridColumns.Items[idx] + ' ' + CUST_COLUMN_LABEL;
            end;
        end;
    end;
end;

procedure TfrWwDbGridGuiEdit.lstGridColumnsClickCheck(Sender: TObject);
var
  Field: TField;
  ctr :Integer;
  LinkedFields :PLinkedFields;
  fieldvisible:Boolean;
begin
  Field := GetSelectedField;
  if Assigned(Field) then begin
    LinkedFields := TwwDbGridGuiElement(Element).getLinkedFields(field.fieldname);
    fieldvisible:= not Field.Visible;
    if not(fieldvisible) and IsMandatoryField(field) then begin
      TimerMsg(Quotedstr(Field.fieldname)+' is a mandatory field, cannot be removed');
      Field.Visible:= True;
      lstGridColumns.Checked[lstGridColumns.Itemindex] := True;
      exit;
    end;
    Field.Visible :=fieldvisible;
    SetFieldVisibility(Field);
    if Assigned(LinkedFields) then
        if Length(LinkedFields.Linkedfields) > 0 then
            for ctr := low(LinkedFields.Linkedfields) to high(LinkedFields.Linkedfields) do  begin
              Dataset.findfield(LinkedFields.Linkedfields[ctr]).visible := fieldvisible;
              SetFieldVisibility(Dataset.findfield(LinkedFields.Linkedfields[ctr]));
            end;
  end;
end;

function TfrWwDbGridGuiEdit.FieldNameExists(aDataset: TDataset; const aFieldName: string): boolean;
begin
  Result := false;
  if not Assigned(aDataset) then Exit
  else begin
    Result := Assigned(aDataset.FindField(aFieldName));
  end;
end;

function TfrWwDbGridGuiEdit.ComponentNameExists(aDataset: TDataset; const aComponentName: string): boolean;
var
  i: integer;
begin
  Result := false;
  if not Assigned(aDataset) then Exit
  else begin
    for I := 0 to aDataset.FieldCount - 1 do begin
      if Sysutils.SameText(aDataset.Fields[I].Name, aComponentName) then begin
        Result := true;
        Break;
      end;
    end;
  end;
end;

function IsValidFieldName(const aName: string): boolean;
var iIndex: integer;
begin
  result:= true;
  if aName = '' then begin
    result:= false;
    exit;
  end;
  for iIndex := 1 to char_length(aName) do begin
    (*if (iIndex = 1) and (not CharInSet(aName[iIndex],['a'..'z', 'A'..'Z'])) then begin
      result:= false;
      exit;
    end;*)
    if not CharInSet(aName[iIndex],['a'..'z', 'A'..'Z', '0'..'9', '_', '-','$' , '£', ' ', '~']) then begin
      result:= false;
      break;
    end;
  end;
end;

procedure TfrWwDbGridGuiEdit.actAddExecute(Sender: TObject);
var
  idx: integer;
  Field: TFloatField;
  DatasetIsOpen: boolean;
  NewFieldName: string;
  ColItem: TColumnListItem;
begin
  // Add a custom column to the grid dataset
  NewFieldName := InputBox('New Column Name', 'Enter a name for the new column', '');
  if not IsValidFieldName(NewFieldName) then begin
    CommonLib.MessageDlgXP_Vista('"' + NewFieldName +
      '" is not a valid column name.' + #13#10 + #13#10 +
      'The name must start with a letter and must only contain letters, numbers, "_", "-" or spaces.', mtInformation, [mbOK], 0);
    exit;
  end;
  while (NewFieldName <> '') and (ComponentNameExists(Grid.Datasource.Dataset,
    StringReplace(Grid.DataSource.DataSet.Name + NewFieldName, ' ', '',[rfReplaceAll,rfIgnoreCase])) or FieldNameExists(Grid.Datasource.Dataset, NewFieldName)) do
  begin
    NewFieldName := InputBox('New Column Name', 'Column "' + NewFieldName +
      '" already exists (Maybe Hidden) Please Try A Different Name', '');
  end;
  if NewFieldName = '' then Exit;

  chkSumColumn.Checked := false;
  // add the new field to the dataset
  DatasetIsOpen := Grid.DataSource.DataSet.Active;
  Grid.DataSource.DataSet.Active := false;
  Field := TFloatField.Create(Grid.DataSource.DataSet.Owner);
  Field.FieldKind := fkCalculated;
  Field.FieldName := NewFieldName; //edtColumnName.Text;
  Field.Name := Grid.DataSource.DataSet.Name + RemoveInvalidAlphaNumericCharacters(StringReplace(Field.FieldName, ' ', '',[rfReplaceAll,rfIgnoreCase]));
  Field.Index := Grid.DataSource.DataSet.FieldCount;
  Field.DataSet := Grid.DataSource.DataSet;
  Field.Tag := TAG_MASK_CG;
//  Grid.DataSource.DataSet.FieldDefs.Update;

  // add new field to GUI data
  Node['CustomColumns.' + Field.FieldName + '.Name'].AsString := Field.Name;
  Node['CustomColumns.' + Field.FieldName + '.FieldName'].AsString := Field.FieldName;
  Node['CustomColumns.' + Field.FieldName + '.DisplayFormat'].AsString :=
    AppEnv.RegionalOptions.CurrencySymbol+'###,###,##0.00;('+AppEnv.RegionalOptions.CurrencySymbol+'###,###,##0.00)';
  edtFormat.Text := Node['CustomColumns.' + Field.FieldName + '.DisplayFormat'].AsString;
  Node['CustomColumns.' + Field.FieldName + '.DisplayWidth'].AsInteger := 20;
  Node['CustomColumns.' + Field.FieldName + '.SumColumn'].AsBoolean := false;

  // add to list
  ColItem := TColumnListItem.Create;
  ColItem.FieldName := Field.FieldName;
  ColItem.IsCustomColumn := true;
  idx := lstGridColumns.Items.AddObject(Field.FieldName + ' ' + CUST_COLUMN_LABEL, ColItem);
  lstGridColumns.Checked[idx] := true;
  lstGridColumns.ItemIndex := idx;

  actCheckFormula.Enabled := true;
  chkSumColumn.Enabled    := true;

  actDelete.Enabled       := true;
  btnCheckFormula.Enabled := true;
  lblFormula.Enabled      := true;
  edtFieldFormula.Enabled := true;
  lblFormat.Enabled       := true;
  edtFormat.Enabled       := true;
  chkSumColumn.Enabled    := true;

(*  if DatasetIsOpen and (Grid.DataSource.DataSet is TERPQuery) then
    TERPQuery(Grid.DataSource.DataSet).Prepared:= true;*)

  Grid.DataSource.DataSet.Active := DatasetIsOpen;
end;

procedure TfrWwDbGridGuiEdit.actDeleteExecute(Sender: TObject);
var
  Field: TField;
begin
  // Delete a custom column from the grid dataset
  Field := GetSelectedField;
  if Assigned(Field) then begin
    Node['CustomColumns'].DeleteByName(Field.FieldName);
    Element.ApplyGuiPrefs;
    Self.DisplayGuiSettings;
  end;
end;

procedure TfrWwDbGridGuiEdit.lstGridColumnslClick(Sender: TObject);
begin
  DoColumnSelect;
end;

function TfrWwDbGridGuiEdit.IsMandatoryField(Fld: TField): Boolean;
begin
  result:= GetGridGuiElement.isMandatoryField(Fld.fieldname);
end;

procedure TfrWwDbGridGuiEdit.DoColumnSelect;
var
  Field: TField;
begin
  edtFieldFormula.Text := '';
  edtFormat.Text := '';
  Field := GetSelectedField;

  if Assigned(Field) and ((field.Tag and TAG_MASK_CG) = TAG_MASK_CG) then begin  // custom column
    actDelete.Enabled       := true;
    actCheckFormula.Enabled := true;
    chkSumColumn.Enabled    := true;
    btnCheckFormula.Enabled := true;
    lblFormula.Enabled      := true;
    edtFieldFormula.Enabled := true;
    lblFormat.Enabled       := true;
    edtFormat.Enabled       := true;
    chkSumColumn.Enabled    := true;

    edtFieldFormula.Text := CustColumns[Field.FieldName + '.Formula'].AsString;
    edtFormat.Text       := CustColumns[Field.FieldName + '.DisplayFormat'].AsString;
    chkSumColumn.Checked := CustColumns[Field.FieldName + '.SumColumn'].AsBoolean;
  end else begin
    actDelete.Enabled       := false;
    actCheckFormula.Enabled := false;
    chkSumColumn.Enabled    := false;
    btnCheckFormula.Enabled := false;
    lblFormula.Enabled      := false;
    edtFieldFormula.Enabled := false;
    lblFormat.Enabled       := false;
    edtFormat.Enabled       := false;
    chkSumColumn.Enabled    := false;
  end;
end;


procedure TfrWwDbGridGuiEdit.pumFormulaPopup(Sender: TObject);
var
  item: TMenuItem;
  x: integer;
begin
  // popuate menu with a list of fields that can be used in calculations
  mnuColumns.Clear;
  for x := 0 to grid.DataSource.DataSet.FieldCount - 1 do begin
    // exclude field the formula is for
    if (grid.DataSource.DataSet.Fields[x] <> GetSelectedField) and
      // only number fields
      (grid.DataSource.DataSet.Fields[x].DataType in [ftSmallInt,
      ftInteger,
      ftWord,
      ftFloat,
      ftCurrency]) then begin
      item := TMenuItem.Create(self);
      item.Caption := grid.DataSource.DataSet.Fields[x].FieldName;
      item.Tag := integer(grid.DataSource.DataSet.Fields[x]);
      item.OnClick := FormulaItemClick;
      mnuColumns.Add(item);
    end;
  end;
end;

procedure TfrWwDbGridGuiEdit.FormulaItemClick(Sender: TObject);
var
  s, InsertStr, MenuCaption: string;
  x: integer;
begin
  InsertStr := '';
  if TMenuItem(Sender).tag > 0 then begin
    InsertStr := '[' + TField(TMenuItem(Sender).tag).FieldName + ']';
  end else begin
    MenuCaption := StringReplace(TMenuItem(Sender).Caption, '&', '',[rfReplaceAll,rfIgnoreCase]); // remove "&" added by delphi
    if MenuCaption = 'add' then InsertStr := '+'
    else if MenuCaption = 'subtract' then InsertStr := '-'
    else if MenuCaption = 'multiply' then InsertStr := '*'
    else if MenuCaption = 'divide' then InsertStr := '/'
    else if MenuCaption = '(' then InsertStr := '('
    else if MenuCaption = ')' then InsertStr := ')';
  end;
  if InsertStr <> '' then begin
    s := edtFieldFormula.Text;
    x := edtFieldFormula.SelStart;
    Insert(InsertStr, s, x + 1);
    edtFieldFormula.Text     := s;
    edtFieldFormula.SelStart := x + char_length(InsertStr) + 1;
  end;
end;

procedure TfrWwDbGridGuiEdit.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var Found: boolean);
var
  Field: TField;
begin
  Field := Dataset.FindField(VarName);
  Found := Assigned(Field);
  if Assigned(Field) then begin
    try
      Value := Field.AsFloat;
    except
      on EConvertError do Value := 0;
    end;
  end else
    Value := 0;
end;

function TfrWwDbGridGuiEdit.CheckFormula(var msg: string): boolean;
begin
  msg := '';
  Parser.ParseString := edtFieldFormula.Text;
  Parser.Parse;
  Result := not Parser.ParseError;
  msg := Parser.ErrorMessage;
end;

procedure TfrWwDbGridGuiEdit.edtFieldFormulaExit(Sender: TObject);
begin
  SaveFormula;
end;

procedure TfrWwDbGridGuiEdit.edtFormatExit(Sender: TObject);
begin
  SaveDisplayFormat;
end;

procedure TfrWwDbGridGuiEdit.chkSumColumnClick(Sender: TObject);
begin
  SaveSumColumn;
end;

procedure TfrWwDbGridGuiEdit.SaveDisplayFormat;
var
  Field: TField;
begin
  Field := GetSelectedField;
  if Assigned(Field) and ((field.Tag and TAG_MASK_CG) = TAG_MASK_CG) then begin  // custom column
    CustColumns[Field.FieldName + '.DisplayFormat'].AsString := edtFormat.Text;
    TFloatField(Field).DisplayFormat := edtFormat.Text;
  end;
end;

procedure TfrWwDbGridGuiEdit.SaveSumColumn;
var
  Field: TField;
begin
  field := GetSelectedField;
  if Assigned(Field) and ((field.Tag and TAG_MASK_CG) = TAG_MASK_CG) then begin  // custom column
    CustColumns[Field.FieldName + '.SumColumn'].AsBoolean := chkSumColumn.Checked;
  end;
end;

function TfrWwDbGridGuiEdit.SaveFormula: boolean;
var
  Field: TField;
  msg: string;
begin
  Result := true;
  Field := GetSelectedField;
  if Assigned(Field) and ((field.Tag and TAG_MASK_CG) = TAG_MASK_CG) then begin  // custom column
    if (edtFieldFormula.Text <> '') and (not CheckFormula(msg)) then begin
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      SetControlFocus(edtFieldFormula);
      Result := false;
      Exit;
    end;
    CustColumns[Field.FieldName + '.Formula'].AsString := edtFieldFormula.Text;
  end;
end;

procedure TfrWwDbGridGuiEdit.actCheckFormulaExecute(Sender: TObject);
var
  s: string;
begin
  if CheckFormula(s) then CommonLib.MessageDlgXP_Vista('Formula Ok, output = ' + FormatFloat(edtFormat.Text, Parser.ParseValue),
      mtInformation, [mbOK], 0)
  else CommonLib.MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
end;

function TfrWwDbGridGuiEdit.GetSelectedField: TField;
begin
  Result := nil;
  if lstGridColumns.ItemIndex > -1 then Result :=
      Dataset.FindField(TColumnListItem(lstGridColumns.Items.Objects[lstGridColumns.ItemIndex]).FieldName);
end;

function TfrWwDbGridGuiEdit.CustColumns: TDataTreeNode;
begin
  if Assigned(Node) then Result := TDataTreeNode(Node['CustomColumns'])
  else Result := nil;
end;

procedure TfrWwDbGridGuiEdit.DisplayGuiSettings(fUserID:Integer =0);

  procedure DisableAllControls(aPanel: TPanel);
  var 
    x: integer;
  begin
    for x := 0 to aPanel.ControlCount - 1 do begin
      if aPanel.Controls[x] is TPanel then DisableAllControls(TPanel(aPanel.Controls[x]))
      else aPanel.Controls[x].Enabled := false;
    end;
  end;
begin
  inherited;
  ShowColumns;
  DoColumnSelect;
  chkGridLines.Checked := dgColLines in Grid.Options;
end;

procedure TfrWwDbGridGuiEdit.btnGridFontClick(Sender: TObject);
begin
  inherited;
  dlgFont.Font := Grid.Font;
  if dlgFont.Execute then begin
    Grid.Font := dlgFont.Font;
    FontToNode(dlgFont.Font, TDataTreeNode(Node['Font']));
  end;
end;

procedure TfrWwDbGridGuiEdit.btnGridTitleFontClick(Sender: TObject);
begin
  inherited;
  dlgFont.Font := Grid.TitleFont;
  if dlgFont.Execute then begin
    Grid.TitleFont := dlgFont.Font;
    FontToNode(dlgFont.Font, TDataTreeNode(Node['TitleFont']));
  end;
end;

procedure TfrWwDbGridGuiEdit.btnAltRowColourClick(Sender: TObject);
begin
  inherited;
  dlgColor.Color := Grid.PaintOptions.AlternatingRowColor;
  if dlgColor.Execute then begin
    Grid.PaintOptions.AlternatingRowColor := dlgColor.Color;
    node['AlternatingRowColor'].AsInteger := dlgColor.Color;
  end;
end;


procedure TfrWwDbGridGuiEdit.chkGridLinesClick(Sender: TObject);
begin
  inherited;
  if chkGridLines.Checked then Grid.Options := Grid.Options + [dgColLines, dgRowLines]
  else Grid.Options := Grid.Options - [dgColLines, dgRowLines];
  node['ShowGridLines'].AsBoolean := chkGridLines.Checked;
end;

function TfrWwDbGridGuiEdit.GetGridGuiElement: TwwDbGridGuiElement;
begin
  Result := TwwDbGridGuiElement(Element);
end;

procedure TfrWwDbGridGuiEdit.ClearColumnList;
begin
  while lstGridColumns.Count > 0 do begin
    lstGridColumns.Items.Objects[0].Free;
    lstGridColumns.Items.Delete(0);
  end;
end;

destructor TfrWwDbGridGuiEdit.Destroy;
begin
  ClearColumnList;
  inherited;
end;

procedure TfrWwDbGridGuiEdit.SetShowItemEdit(const Value: Boolean);
begin
  if Value <> fShowItemEdit then
  begin
    fShowItemEdit := Value;

    if not fShowItemEdit then
      ItemEdit.Hide;
  end;
end;

procedure TfrWwDbGridGuiEdit.SetItemValue(Sender: TObject);
var
  Field: TField;
  gf: TGridFieldList;
begin
  if fCurrentItemIndex >= 0 then
  begin
    if not IsValidFieldName(ItemEdit.Text) then begin
      CommonLib.MessageDlgXP_Vista('"' + ItemEdit.Text +
        '" is not a valid column name.' + #13#10 + #13#10 +
        'The name must start with a letter and must only contain letters, numbers, "_", "-" or spaces.', mtInformation, [mbOK], 0);
      exit;
    end;
    ItemEdit.Hide;
    lstGridColumns.Items[fCurrentItemIndex] := ItemEdit.Text;
    fCurrentItemIndex := -1;
    Field := GetSelectedField;
    if Assigned(Field) then begin
      Field.DisplayLabel := ItemEdit.Text;
      if not Grid.UseTFields then begin
        gf:= TGridFieldList.Create;
        try
          gf.Text:= Grid.Selected.Text;
          gf.ChangeDisplayLabel(Field.fieldname , Field.displaylabel);
          Grid.Selected.Text:= gf.Text;
        finally
          gf.Free;
        end;
      end;
      Node['GridFields'].CData:= GetGridSelectedText(grid);
    end;
  end;
end;

procedure TfrWwDbGridGuiEdit.lstGridColumnsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Flags: Integer;
  Data: string;
  DrawState: TOwnerDrawState;
begin
  inherited;

  if Control is TCheckListBox then
  begin
    DrawState := State;

    with TCheckListBox(Control) do
    begin
      if (Index = fCurrentItemIndex) and ItemEdit.Visible and
         (ItemEdit.Top <> Rect.Top + 1) then
      begin
        ItemEdit.Hide;
      end;  

      Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;

      if odGrayed in DrawState then
        Canvas.Font.Color := clGrayText;

      if odSelected in DrawState then
        Canvas.Brush.Color := clHighlight
      else
        Canvas.Brush.Color := clWindow;

      Canvas.FillRect(Rect);
      Inc(Rect.Left, 2);
      Data := TCheckListBox(Control).Items[Index];
      DrawText(Canvas.Handle, PChar(Data), -1, Rect, Flags);
    end;
  end;
end;

procedure TfrWwDbGridGuiEdit.lstGridColumnsDblClick(Sender: TObject);
var
  Field: TField;
  CustomColumn: Boolean;
begin
  inherited;
  CustomColumn := False;
  Field := GetSelectedField;

  if Assigned(Field) and ((field.Tag and TAG_MASK_CG) = TAG_MASK_CG) then
    CustomColumn := True;

  if ShowItemEdit and (Sender is TCheckListBox) and (not CustomColumn) then
  begin
    with TCheckListBox(Sender) do
    begin
      if (ItemHeight * Items.Count) <= ClientHeight then
        ItemEdit.Width := Width - ItemEdit.Left - 5
      else
        ItemEdit.Width := Width - ItemEdit.Left - 21;

      ItemEdit.Top := (ItemHeight * (ItemIndex - TopIndex)) + 1;
      ItemEdit.Text := Items[ItemIndex];
      ItemEdit.Show;
      SetControlFocus(ItemEdit);
      fCurrentItemIndex := ItemIndex;
    end;
  end;
end;

procedure TfrWwDbGridGuiEdit.InitialiseItemEdit;
begin
  ItemEdit.BorderStyle := bsNone;
  ItemEdit.AutoSelect := True;
  ItemEdit.OnExit := SetItemValue;
  ItemEdit.Left := 16;
  ItemEdit.Height := lstGridColumns.ItemHeight - 2;
  ItemEdit.Hide;
  ItemEdit.Parent := lstGridColumns;
end;

procedure TfrWwDbGridGuiEdit.SetFieldVisibility(Fld: TField);
(*var
  gf: TGridFieldList;*)
begin
  if Assigned(GridGuiElement) then begin
    if Fld.Visible then
      GridGuiElement.AddField(Fld.FieldName)
    else if IsMandatoryField(Fld) then begin
      TimerMsg(Quotedstr(fld.fieldname)+' is a mandatory field, cannot be removed');
      exit;
    end
    else
      GridGuiElement.RemoveField(Fld.FieldName);
  end else begin
(*  //if not Grid.UseTFields then begin
    gf:= TGridFieldList.Create;
    try
      gf.Text:= Grid.Selected.Text;
      if Fld.Visible then begin
        { when a column is selected (turned on) set a default display width }
        if (Fld.DisplayWidth > 40) then
          Fld.DisplayWidth := 20;
        gf.AddField(Fld);
      end
      else
        gf.RemoveField(fld.FieldName);

      Grid.Selected.Text:= gf.Text;
      grid.ApplySelected;
    finally
      gf.Free;
    end;
  //end;*)
 end;
 Node['GridFields'].CData:= GetGridSelectedText(grid);
end;
procedure TfrWwDbGridGuiEdit.btnearchnextClick(Sender: TObject);
begin
  inherited;
  goSearch(False, fiSearchKey);
end;
procedure TfrWwDbGridGuiEdit.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  (*if Key = vk_return then key := vk_f6;
  if (Key = VK_F5) or (Key = VK_F6) or (Key = VK_F7) then begin
    goSearch(True, key);
  end;*)
  if not ((Key = VK_F5) or (Key = VK_F6) or (Key = VK_F7)) then key := vk_f6;
  goSearch(True, key);
end;

function TfrWwDbGridGuiEdit.goSearch(RestartSearch:Boolean;Key: Word):Boolean;
var
  ctr:Integer;
  function itemname:String;
  begin
    result := '';
    if (ctr<0) or (ctr>lstGridColumns.Count-1) then exit;
    try
      result :=Dataset.findfield(TColumnListItem(lstGridColumns.Items.Objects[ctr]).FieldName).displaylabel;
    Except
      on E:Exception do begin
        result := TColumnListItem(lstGridColumns.Items.Objects[ctr]).FieldName;
      end;
    end;
  end;
begin
  result := False;
  if fiSearchindex <> 0 then fiSearchindex := fiSearchindex +1;
  if RestartSearch then fiSearchindex:=0
  else if fiSearchindex <0 then fiSearchindex:=0
  else if fiSearchindex> lstGridColumns.Count then fiSearchindex := 0;

  for ctr:= fiSearchindex to lstGridColumns.Count -1 do begin
    logtext(inttostr(ctr)+':' + itemname);
    if ((Key = VK_F5) and sametext(itemname , trim(edtSearch.text))) or
       ((Key = VK_F6) and (pos(uppercase(trim(edtSearch.text)) , uppercase(itemname ))=1)) Or
       ((Key = VK_F7) and (pos(uppercase(trim(edtSearch.text)) , uppercase(itemname ))>=1)) then begin
          fiSearchindex := ctr;
          fiSearchKey := Key;
         lstGridColumns.itemindex := ctr;
         result := True;
         exit;
       end;
  end;
  if fiSearchindex <> 0 then
    if goSearch(true, key) then exit;

  fiSearchindex := lstGridColumns.Count +1;

end;

initialization
  RegisterClassOnce(TfrWwDbGridGuiEdit);

finalization
  UnRegisterClass(TfrWwDbGridGuiEdit);
end.
