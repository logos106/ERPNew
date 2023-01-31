unit frameSQLSelectBuilder;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, XMLDataObj;

type
  TfrSQLSelectBuilder = class(TFrame)
    pnlFrame: TDNMPanel;
    lblSearchCriteria: TLabel;
    lstLines: TListBox;
    cboAndOr: TComboBox;
    Label3: TLabel;
    Label5: TLabel;
    cboField: TComboBox;
    Label6: TLabel;
    cboOperator: TComboBox;
    Label7: TLabel;
    edtConstValue: TEdit;
    btnAddListItem: TDNMSpeedButton;
    btnDeleteListItem: TDNMSpeedButton;
    procedure ControlChange(Sender: TObject);
    procedure lstLinesClick(Sender: TObject);
    procedure btnAddListItemClick(Sender: TObject);
    procedure btnDeleteListItemClick(Sender: TObject);
  private
    { Private declarations }
    fDirty: boolean;
    DoControlChange: boolean;
    fIsReadOnly: boolean;
    procedure GetLine(LineNumber: integer);
    procedure SetLine(LineNumber: integer);
    procedure DeleteLine(LineNumber: integer);
    procedure AddLine;
    procedure OnXMLDataLoad(Sender: TObject);
    procedure BuildSQLString;
    procedure GetTableFields;
    procedure SetIsReadOnly(const Value: boolean);
    procedure ClearEditBoxs;
    procedure SetEditState;
    function OperatorToSQL(const operator: string): string;
  public
    { Public declarations }
    XMLData: TXMLData;
    property Dirty: boolean read fDirty write fDirty;
    property IsReadOnly: boolean read fIsReadOnly write SetIsReadOnly;
    procedure UpdateFromXMLData;
    function ValidateData: boolean;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  MyAccess,ERPdbComponents, CommonDbLib, CommonLib, FastFuncs;

constructor TfrSQLSelectBuilder.Create(AOwner: TComponent);
begin
  inherited;
  XMLData := TXMLData.Create(Self);
  XMLData.OnDataLoad := Self.OnXMLDataLoad; // assign event handler
  IsReadOnly := false;
  DoControlChange := true;
  ClearEditBoxs;
end;

// XMLData.OnDataLoad event handler
procedure TfrSQLSelectBuilder.OnXMLDataLoad(Sender: TObject);
begin
  UpdateFromXMLData;
end;

procedure TfrSQLSelectBuilder.SetEditState;
begin
  if lstLines.ItemIndex < 0 then begin
    cboAndOr.Enabled      := false;
    cboField.Enabled      := false;
    cboOPerator.Enabled   := false;
    edtConstValue.Enabled := false;
  end else begin
    if lstLines.ItemIndex = 0 then begin
      cboAndOr.Enabled := false;
      cboAndOr.ItemIndex := -1;
    end else begin
      if not fIsReadOnly then begin
        cboAndOr.Enabled := true;
      end;
    end;

    if not fIsReadOnly then begin
      cboField.Enabled := true;
      cboOPerator.Enabled := true;
      edtConstValue.Enabled := true;
    end;
  end;
end;

procedure TfrSQLSelectBuilder.UpdateFromXMLData;
var
  x: integer;
begin
  // The XML structure is as follows:
  // Node['SQLSelect']                        - top level node
  // Node['SQLSelect'].Attribute['SQL']       - resultant sql select statement
  // Node['SQLSelect.Lines']                  - values used to build criteria list
  // Node['SQLSelect.Tables']                 - List of tables that user can select fields from
  // Node['SQLSelect.Tables.Table0'].Attribute['TableName']  - First table
  // Node['SQLSelect.Tables.Table1'].Attribute['TableName']  - etc
  // If fields are specified as follows these will be used rather than reading all fields from database
  // Node['SQLSelect.Tables.Table2'].Attribute['Field0']     - First user specified firld to use
  // Node['SQLSelect.Tables.Table2'].Attribute['Field1']     - etc

  GetTableFields;
  lstLInes.Items.Clear;

  x := 0;
  while XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(x)) do begin
    lstLines.Items.Add(XMLData.Node['SQLSelect.Lines.Line' + IntToStr(x)].Attribute['UserSQL'].AsString);
    Inc(x);
  end;
  SetEditState;

  Self.Dirty := false;
end;

function TfrSQLSelectBuilder.ValidateData: boolean;
var
  x: integer;
  operator: string;
begin
  Result := true;
  x := 0;
  while x < lstLines.Count do begin
    if FastFuncs.PosEx('New line', lstLines.Items[x]) > 0 then DeleteLine(x)
    else Inc(x);
  end;
  if lstLines.Items.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Please enter at least one selection criteria line', mtWarning, [mbOK], 0);
    Result := false;
  end else begin
    x := 0;
    while XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(x)) do begin
      with XMLData.Node['SQLSelect.Lines.Line' + IntToStr(x)] do begin
        if (Attribute['AndOr'].AsString = '') and (x > 0) then begin
          CommonLib.MessageDlgXP_Vista('Please select AND / OR for this line', mtWarning, [mbOK], 0);
          lstLines.ItemIndex := x;
          lstLines.OnClick(self);
          SetControlFocus(cboAndOr);
          Result := false;
          Exit;
        end else if Attribute['FieldName'].AsString = '' then begin
          CommonLib.MessageDlgXP_Vista('Please select a field for this line', mtWarning, [mbOK], 0);
          lstLines.ItemIndex := x;
          lstLines.OnClick(self);
          SetControlFocus(cboField);
          Result := false;
          Exit;
        end else if Attribute['ConstantValue'].AsString = '' then begin
          operator := Attribute['Operator'].AsString;
          if (operator <> 'is blank') and
            (operator <> 'is not blank') and
            (operator <> 'all') then begin
            CommonLib.MessageDlgXP_Vista('Please enter a value for this line', mtWarning, [mbOK], 0);
            lstLines.ItemIndex := x;
            lstLines.OnClick(self);
            SetControlFocus(edtConstValue);
            Result := false;
            Exit;
          end;
        end;
      end;
      Inc(x);
    end;
  end;
end;

procedure TfrSQLSelectBuilder.GetTableFields;
var
  iTable, iField: integer;
  TableName: string;
  qry: TERPQuery;
begin
  cboField.Items.Clear;
  iTable := 0;
  //iField:= 0;
  if XMLData.NodeExists('SQLSelect.Tables.Table0') then begin  // get field names from table
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      while XMLData.NodeExists('SQLSelect.Tables.Table' + IntToStr(iTable)) do begin
        TableName := XMLData.Node['SQLSelect.Tables.Table' + IntToStr(iTable)].Attribute['TableName'].AsString;

        iField := 0;
        if XMLData.Node['SQLSelect.Tables.Table' + IntToStr(iTable)].Attribute['Field' + IntToStr(iField)].Exists then begin
          // user supplied list of fields
          while XMLData.Node['SQLSelect.Tables.Table' + IntToStr(iTable)].Attribute['Field' + IntToStr(iField)].Exists do
          begin
            if TableName <> '' then cboField.Items.Add(TableName + '.' +
                XMLData.Node['SQLSelect.Tables.Table' + IntToStr(iTable)].Attribute['Field' + IntToStr(iField)].AsString)
            else cboField.Items.Add(XMLData.Node['SQLSelect.Tables.Table' + IntToStr(iTable)].Attribute['Field' +
                IntToStr(iField)].AsString);
            Inc(iField);
          end;
        end else begin // get fields from database
          qry.SQL.Text := 'SHOW COLUMNS FROM ' + TableName;
          qry.Open;
          while not qry.Eof do begin
            cboField.Items.Add(TableName + '.' + qry.FieldByName('Field').AsString);
            qry.Next;
          end;
          qry.Close;
        end;
        Inc(iTable);
      end;
    finally
      FreeAndNil(qry);
    end;
  end
end;

procedure TfrSQLSelectBuilder.GetLine(LineNumber: integer);
begin
  if XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(LineNumber)) then begin
    DoControlChange := false;
    try
      with XMLData.Node['SQLSelect.Lines.Line' + IntToStr(LineNumber)] do begin
        if Attribute['AndOr'].AsString <> '' then CboAndOr.ItemIndex := CboAndOr.Items.IndexOf(Attribute['AndOr'].AsString)
        else CboAndOr.ItemIndex := -1;

        cboField.ItemIndex := cboField.Items.IndexOf(Attribute['FieldName'].AsString);
        cboOPerator.ItemIndex := cboOperator.Items.IndexOf(Attribute['Operator'].AsString);
        edtConstValue.Text := Attribute['ConstantValue'].AsString;
      end;
    finally
      DoControlChange := true;
    end;
  end;
end;

function TfrSQLSelectBuilder.OperatorToSQL(const operator: string): string;
begin
  if operator = '' then Result := ''
  else begin
    if operator = 'equal to' then Result := '='
    else if operator = 'all' then Result := 'IS NOT NULL'
    else if operator = 'not equal to' then Result := '<>'
    else if operator = 'less than' then Result := '<'
    else if operator = 'like' then Result := 'LIKE'
    else if operator = 'greater than' then Result := '>'
    else if operator = 'greater or equal to' then Result := '>='
    else if operator = 'less or equal to' then Result := '<='
    else if operator = 'is blank' then Result := 'IS NULL'
    else if operator = 'is not blank' then Result := 'IS NOT NULL'
    else if operator = 'starts with' then Result := 'LIKE'
    else begin
      Result := '';
      CommonLib.MessageDlgXP_Vista('Invalid comparison: "' + operator + '"', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfrSQLSelectBuilder.SetLine(LineNumber: integer);
var
  s, sql, prefix, suffix, quote: string;
  operator: string;
  Val: string;
begin
  with XMLData.Node['SQLSelect.Lines.Line' + IntToStr(LineNumber)] do begin
    Attribute['AndOr'].AsString := cboAndOr.Text;
    Attribute['FieldName'].AsString := cboField.Text;
    operator := cboOperator.Text;
    Attribute['Operator'].AsString := operator;
    Val      := Trim(edtConstValue.Text);

    prefix := '';
    suffix := '';
    quote := '';

    if (operator = 'starts with') or (operator = 'like') then suffix := '%';
    if operator = 'like' then prefix := '%';

    if Copy(Val, 1, 1) = '"' then Val := Copy(Val, 2, char_length(Val));

    if Copy(Val, char_length(Val), 1) = '"' then Val := Copy(Val, 1, char_length(Val) - 1);

    if not CommonLib.IsNumber(Val) then quote := '"';

    Attribute['ConstantValue'].AsString := Val;

    // build SQL for this line
    s := Attribute['AndOr'].AsString;
    if s <> '' then s := s + ' ';
    s := s + Attribute['FieldName'].AsString;

    if s <> '' then s := s + ' ';
    sql := s;
    s   := s + operator;
    sql := sql + OperatorToSQL(operator);

    if Attribute['ConstantValue'].AsString <> '' then begin
      s := s + ' ' + quote + Attribute['ConstantValue'].AsString + quote;
      sql := sql + ' ' + quote + prefix +  Attribute['ConstantValue'].AsString + suffix + quote;
    end;

    Attribute['SQL'].AsString     := sql;
    Attribute['UserSQL'].AsString := s;

    lstLines.Items[LineNumber] := s;

    BuildSQLString;
  end;
end;

procedure TfrSQLSelectBuilder.BuildSQLString;
var
  s: string;
  x: integer;
begin
  // build SQL
  x := 0;
  s := '';
  while XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(x)) do begin
    if s <> '' then s := s + #13#10;
    s := s + XMLData.Node['SQLSelect.Lines.Line' + IntToStr(x)].Attribute['SQL'].AsString;
    Inc(x);
  end;
  XMLData.Node['SQLSelect'].Attribute['SQL'].AsString := s;
end;

procedure TfrSQLSelectBuilder.DeleteLine(LineNumber: integer);
var
  currLine, nextLine: integer;
begin
  currLine := LineNumber;
  nextLine := currLine + 1;
  lstLines.Items.Delete(LineNumber);
  if XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(currLine)) then begin
    while XMLData.NodeExists('SQLSelect.Lines.Line' + IntToStr(nextLine)) do begin
      XMLData.Node['SQLSelect.Lines.Line' + IntToStr(currLine)].Attribute['AndOr'].AsString :=
        XMLData.Node['SQLSelect.Lines.Line' + IntToStr(nextLine)].Attribute['AndOr'].AsString;
      XMLData.Node['SQLSelect.Lines.Line' + IntToStr(currLine)].Attribute['FieldName'].AsString :=
        XMLData.Node['SQLSelect.Lines.Line' + IntToStr(nextLine)].Attribute['FieldName'].AsString;
      XMLData.Node['SQLSelect.Lines.Line' + IntToStr(currLine)].Attribute['Operator'].AsString :=
        XMLData.Node['SQLSelect.Lines.Line' + IntToStr(nextLine)].Attribute['OPerator'].AsString;
      XMLData.Node['SQLSelect.Lines.Line' + IntToStr(currLine)].Attribute['ConstantValue'].AsString :=
        XMLData.Node['SQLSelect.Lines.Line' + IntToStr(nextLine)].Attribute['ConstantValue'].AsString;
      XMLData.Node['SQLSelect.Lines.Line' + IntToStr(currLine)].Attribute['SQL'].AsString :=
        XMLData.Node['SQLSelect.Lines.Line' + IntToStr(nextLine)].Attribute['SQL'].AsString;

      Inc(currLine);
      nextLine := currLine + 1;
    end;
    XMLData.DeleteNode('SQLSelect.Lines.Line' + IntToStr(currLine));
  end;
end;

procedure TfrSQLSelectBuilder.AddLine;
var
  newLIneNumber: integer;
begin
  newLIneNumber := lstLines.Items.Add('New line, enter selection below');
  lstLines.ItemIndex := newLineNumber;
  self.ClearEditBoxs;
  SetEditState;
  Self.Dirty := true;
  if newLIneNumber = 0 then begin
    SetControlFocus(cboField);
  end else begin
    SetControlFocus(cboAndOr);
  end;
end;

procedure TfrSQLSelectBuilder.ControlChange(Sender: TObject);
begin
  if not DoControlChange then Exit;
  Dirty := true;
  if lstLines.ItemIndex > -1 then begin
    SetLine(lstLines.ItemIndex);
    Self.Dirty := true;
    if (cboOperator.Text = 'is blank') or (cboOperator.Text = 'is not blank') or
      (cboOperator.Text = 'all') then begin
      edtConstValue.Text := '';
      edtConstValue.Enabled := false;
    end else begin
      edtConstValue.Enabled := true;
    end
  end;
end;


procedure TfrSQLSelectBuilder.lstLinesClick(Sender: TObject);
begin
  SetEditState;
  if lstLines.ItemIndex > -1 then begin
    if lstLines.ItemIndex = 0 then begin
      SetControlFocus(cboField);
    end else begin
      SetControlFocus(cboAndOr);
    end;
  end;
  GetLine(lstLines.ItemIndex);
end;

procedure TfrSQLSelectBuilder.btnAddListItemClick(Sender: TObject);
begin
  AddLine;
end;

procedure TfrSQLSelectBuilder.btnDeleteListItemClick(Sender: TObject);
begin
  if lstLines.ItemIndex > -1 then begin
    DeleteLine(lstLines.ItemIndex);
    ClearEditBoxs;
    //GetLine(lstLines.ItemIndex);
  end;
  lstLines.OnClick(self);
end;

procedure TfrSQLSelectBuilder.SetIsReadOnly(const Value: boolean);
begin
  fIsReadOnly := Value;
  btnAddListItem.Enabled := not fIsReadOnly;
  btnDeleteListItem.Enabled := not fIsReadOnly;
  cboAndOr.Enabled := not fIsReadOnly;
  cboField.Enabled := not fIsReadOnly;
  cboOperator.Enabled := not fIsReadOnly;
  edtConstValue.Enabled := not fIsReadOnly;
  lstLines.Enabled := not fIsReadOnly;
end;

procedure TfrSQLSelectBuilder.ClearEditBoxs;
begin
  cboAndOr.ItemIndex := -1;
  cboField.ItemIndex := -1;
  cboOperator.ItemIndex := -1;
  edtConstValue.Text := '';
end;


end.
