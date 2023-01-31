unit frmEDIMapEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, JsonObject, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  StdCtrls, DB, kbmMemTable, wwdblook, ExtCtrls, DNMPanel, ComCtrls;

type
  TfmEDIMapEdit = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grpSource: TGroupBox;
    chkSourceInputFile: TCheckBox;
    chkSourceValue: TCheckBox;
    edtSourceValue: TEdit;
    cboSourceCol: TwwDBComboBox;
    grpTarget: TGroupBox;
    tblTarget: TkbmMemTable;
    cboTarget: TwwDBLookupCombo;
    pagesSourceFormula: TPageControl;
    pgReplaceString: TTabSheet;
    pnlStringReplace: TDNMPanel;
    chkStringReplace: TCheckBox;
    lblSearchFor: TLabel;
    edtSearchString: TEdit;
    lblReplaceWith: TLabel;
    edtReplaceString: TEdit;
    chkReplaceAll: TCheckBox;
    chkIgnoreCase: TCheckBox;
    pagesTargetFormula: TPageControl;
    pgSeparator: TTabSheet;
    pnlSeparator: TDNMPanel;
    chkSeparator: TCheckBox;
    cboSeparator: TComboBox;
    lblSeparateWith: TLabel;
    lblSourceDataType: TLabel;
    lblTargetType: TLabel;
    pgFilter: TTabSheet;
    pnlFilter: TDNMPanel;
    chkMapWhenNotBlank: TCheckBox;
    tsDefaultValue: TTabSheet;
    pnlDefaultValue: TDNMPanel;
    Label1: TLabel;
    chkUseDefaultWhenBlank: TCheckBox;
    edtDefaultValue: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkSourceInputFileClick(Sender: TObject);
    procedure chkSourceValueClick(Sender: TObject);
    procedure edtSourceValueChange(Sender: TObject);
    procedure cboSourceColChange(Sender: TObject);
    procedure edtSearchStringChange(Sender: TObject);
    procedure edtReplaceStringChange(Sender: TObject);
    procedure chkReplaceAllClick(Sender: TObject);
    procedure chkIgnoreCaseClick(Sender: TObject);
    procedure cboTargetChange(Sender: TObject);
    procedure chkSeparatorClick(Sender: TObject);
    procedure cboSeparatorChange(Sender: TObject);
    procedure chkStringReplaceClick(Sender: TObject);
    procedure chkMapWhenNotBlankClick(Sender: TObject);
    procedure chkUseDefaultWhenBlankClick(Sender: TObject);
    procedure edtDefaultValueChange(Sender: TObject);
  private
    Loading: boolean;
    procedure Load;
    procedure EnableDisable;
    procedure SelectSource;
    procedure DisplaySourceDataType;
  public
    Map,
    SrcCols,
    Props: TJsonObject;
  end;


  function DoMapEdit(aColour: TColor; aMap, aSrcCols, aProps: TJsonObject): boolean;

implementation

uses
  EDIUtils, Vista_MessageDlg;

{$R *.dfm}


function DoMapEdit(aColour: TColor; aMap, aSrcCols, aProps: TJsonObject): boolean;
var
  form: TfmEDIMapEdit;
begin
  form := TfmEDIMapEdit.Create(nil);
  try
    form.Color := aColour;
    form.Map.Assign(aMap);
    form.SrcCols := aSrcCols;
    form.Props := aProps;
    result := form.ShowModal = mrOk;
    if result then
      aMap.Assign(form.Map);

  finally
    form.Release;
  end;
end;


{ TfmEDIMapEdit }

procedure TfmEDIMapEdit.btnSaveClick(Sender: TObject);
begin
  if chkSourceInputFile.Checked and (cboSourceCol.Text = '') then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please select an Input Field',mtInformation,[mbOk],0);
    exit;
  end;
  if (cboTarget.Text = '') then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please select a Target',mtInformation,[mbOk],0);
    exit;
  end;

  ModalResult := mrOk;
end;

procedure TfmEDIMapEdit.cboSeparatorChange(Sender: TObject);
begin
  if Loading then exit;
  if SameText(TComboBox(Sender).Text,'New Line') then
    Map.O['Target'].S['Separator'] := #13#10
  else if SameText(TComboBox(Sender).Text,'Space') then
    Map.O['Target'].S['Separator'] := ' '
  else
    Map.O['Target'].Delete('Separator');
end;

procedure TfmEDIMapEdit.cboSourceColChange(Sender: TObject);
begin
  if Loading then exit;
  SelectSource;
end;

procedure TfmEDIMapEdit.cboTargetChange(Sender: TObject);
begin
  lblTargetType.Caption := '';
  if cboTarget.Text <> '' then begin
    if tblTarget.Locate('Name',cboTarget.Text,[]) then
      lblTargetType.Caption := DataTypeToStr(tblTarget.FieldByName('DataType').AsString);
  end;
  if Loading then exit;
  Map.O['Target'].S['Field'] := cboTarget.Text;
end;

procedure TfmEDIMapEdit.chkIgnoreCaseClick(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].O['StringReplace'].B['IgnoreCase'] := TCheckBox(Sender).Checked;
end;

procedure TfmEDIMapEdit.chkMapWhenNotBlankClick(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].B['MapWhenNotBlank'] := chkMapWhenNotBlank.Checked;
end;

procedure TfmEDIMapEdit.chkReplaceAllClick(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].O['StringReplace'].B['ReplaceAll'] := TCheckBox(Sender).Checked;
end;

procedure TfmEDIMapEdit.chkSeparatorClick(Sender: TObject);
begin
  if Loading then exit;
  EnableDisable;
end;

procedure TfmEDIMapEdit.chkSourceInputFileClick(Sender: TObject);
begin
  if Loading then exit;
  chkSourceValue.Checked := not chkSourceInputFile.Checked;
  SelectSource;
end;

procedure TfmEDIMapEdit.chkSourceValueClick(Sender: TObject);
begin
  if Loading then exit;
  chkSourceInputFile.Checked := not chkSourceValue.Checked;
  SelectSource;
end;

procedure TfmEDIMapEdit.chkStringReplaceClick(Sender: TObject);
begin
  if Loading then exit;
  EnableDisable;
end;

procedure TfmEDIMapEdit.chkUseDefaultWhenBlankClick(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].O['Defailt'].B['UseDefaultWhenBlank'] := chkUseDefaultWhenBlank.Checked;
  EnableDisable;
end;

procedure TfmEDIMapEdit.DisplaySourceDataType;
var
  o: TJsonObject;
begin
  if chkSourceInputFile.Checked and SrcCols.ObjectExists(IntToStr(Map.O['Source'].I['ColumnNumber'])) then begin
    o := SrcCols.O[IntToStr(Map.O['Source'].I['ColumnNumber'])];
    lblSourceDataType.Caption := EDIUtils.DataTypeToStr(o.S['DataType']);
  end
  else if chkSourceValue.Checked then begin
    lblSourceDataType.Caption := EDIUtils.DataTypeToStr(data_String);
  end
  else
    lblSourceDataType.Caption := '';
end;

procedure TfmEDIMapEdit.edtDefaultValueChange(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].O['Defailt'].S['DefaultValue'] := edtDefaultValue.Text;
end;

procedure TfmEDIMapEdit.edtReplaceStringChange(Sender: TObject);
begin
  Map.O['Source'].O['StringReplace'].S['ReplaceStringString'] := TEdit(Sender).Text;
end;

procedure TfmEDIMapEdit.edtSearchStringChange(Sender: TObject);
begin
  if Loading then exit;
  Map.O['Source'].O['StringReplace'].S['SearchString'] := TEdit(Sender).Text;
end;

procedure TfmEDIMapEdit.edtSourceValueChange(Sender: TObject);
begin
  if Loading then exit;
  SelectSource;
end;

procedure TfmEDIMapEdit.EnableDisable;
begin
  { source }


  { String Replace }
  if chkStringReplace.Checked then begin
    if not Map.O['Source'].ObjectExists('StringReplace') then begin
      Map.O['Source'].O['StringReplace'].B['IgnoreCase'] := true;
      chkReplaceAll.Checked := Map.O['Source'].O['StringReplace'].B['ReplaceAll'];
      chkIgnoreCase.Checked := Map.O['Source'].O['StringReplace'].B['IgnoreCase'];
    end;
  end
  else begin
    edtSearchString.Text := '';
    edtReplaceString.Text := '';
    if Map.O['Source'].ObjectExists('StringReplace') then
      Map.O['Source'].Delete('StringReplace');
    chkReplaceAll.Checked := false;
    chkIgnoreCase.Checked := false;
  end;
  edtDefaultValue.Enabled := chkUseDefaultWhenBlank.Checked;

  lblSearchFor.Enabled := chkStringReplace.Checked;
  lblReplaceWith.Enabled := chkStringReplace.Checked;
  edtSearchString.Enabled := chkStringReplace.Checked;
  edtReplaceString.Enabled := chkStringReplace.Checked;
  chkReplaceAll.Enabled := chkStringReplace.Checked;
  chkIgnoreCase.Enabled := chkStringReplace.Checked;

  { Separator }
  if chkSeparator.Checked then begin
    if not Map.O['Target'].StringExists('Separator') then begin
      Map.O['Target'].S['Separator'] := #13#10;
      cboSeparator.ItemIndex := cboSeparator.Items.IndexOf('New Line');
    end;
  end
  else begin
    if Map.O['Target'].StringExists('Separator') then
      Map.O['Target'].Delete('Separator');

    cboSeparator.ItemIndex := -1;
  end;
  lblSeparateWith.Enabled := chkSeparator.Checked;
  cboSeparator.Enabled := chkSeparator.Checked;


end;

procedure TfmEDIMapEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Map := JO;

  tblTarget.Close;
  tblTarget.Standalone := true;
//  tblTarget.EmptyTable;
//  tblTarget.Performance := mtpfFast;
//  tblTarget.DisableControls;
//  tblTarget.EnableIndexes := false;
//  tblTarget.Reset;

  tblTarget.FieldDefs.Clear;

  with tblTarget.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with tblTarget.FieldDefs.AddFieldDef do begin
    Name     := 'Name';
    DataType := ftString;
    Size     := 255;
  end;
  with tblTarget.FieldDefs.AddFieldDef do begin
    Name     := 'ReadWrite';
    DataType := ftString;
    Size     := 255;
  end;
  with tblTarget.FieldDefs.AddFieldDef do begin
    Name     := 'DataType';
    DataType := ftString;
    Size     := 255;
  end;

  cboTarget.Selected.Add('Name'+#9+'40'+#9+'Prop Name'+#9+'F');
  cboTarget.Selected.Add('DataType'+#9+'15'+#9+'Data Type'+#9+'F');
  cboTarget.Selected.Add('ReadWrite'+#9+'15'+#9+'Read/Write'+#9+'F');

end;

procedure TfmEDIMapEdit.FormDestroy(Sender: TObject);
begin
  Map.Free;
end;

procedure TfmEDIMapEdit.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfmEDIMapEdit.Load;
var
  x: integer;
  obj: TJsonObject;
  propName: string;

  function DataType: string;
  begin
    result := obj.S['DataType'];
    if SameText(result,'Boolean') then
      result := 'True / False';
  end;

  function ReadWrite: string;
  begin
    result := obj.S['ReadWrite'];
    if SameText(result,'ReadWrite') then result := 'Read / Write'
    else if SameText(result,'Read') then result := 'Read Only'
    else if SameText(result,'Write') then result := 'Write Only';

  end;

begin
  Loading := true;
  try
    cboSourceCol.Items.Clear;
    for x := 0 to SrcCols.Count -1 do
      cboSourceCol.Items.Add(SrcCols[x].Value.AsObject.S['Name'] + #9 +
        SrcCols[x].Name);
    if Map.O['Source'].Exists('ColumnNumber') then begin
      chkSourceInputFile.Checked := true;
      chkSourceValue.Checked := false;
      cboSourceCol.Value := IntToStr(Map.O['Source'].I['ColumnNumber']);
      chkMapWhenNotBlank.Checked := Map.O['Source'].B['MapWhenNotBlank'];
      chkUseDefaultWhenBlank.Checked := Map.O['Source'].O['Defailt'].B['UseDefaultWhenBlank'];
      edtDefaultValue.Text := Map.O['Source'].O['Defailt'].S['DefaultValue'];
    end
    else begin
      chkSourceInputFile.Checked := false;
      chkSourceValue.Checked := true;
      cboSourceCol.ItemIndex := -1;
      edtSourceValue.Text := Map.O['Source'].S['Value'];
      chkMapWhenNotBlank.Checked := false;
      chkUseDefaultWhenBlank.Checked := false;
      edtDefaultValue.Text := '';
    end;
    edtSourceValue.Enabled := chkSourceValue.Checked;
    cboSourceCol.Enabled := chkSourceInputFile.Checked;

    if Map.O['Source'].ObjectExists('StringReplace') then begin
      chkStringReplace.Checked := true;
      edtSearchString.Text := Map.O['Source'].O['StringReplace'].S['SearchString'];
      edtReplaceString.Text := Map.O['Source'].O['StringReplace'].S['ReplaceString'];
      chkReplaceAll.Checked := Map.O['Source'].O['StringReplace'].B['ReplaceAll'];
      chkIgnoreCAse.Checked := Map.O['Source'].O['StringReplace'].B['IgnoreCase'];
    end
    else begin
      chkStringReplace.Checked := false;
    end;

    chkSeparator.Checked := Map.O['Target'].StringExists('Separator');
    if chkSeparator.Checked then begin
      if SameText(Map.O['Target'].S['Separator'], #13#10) then
        cboSeparator.ItemIndex := cboSeparator.Items.IndexOf('New Line')
      else if SameText(Map.O['Target'].S['Separator'], ' ') then
        cboSeparator.ItemIndex := cboSeparator.Items.IndexOf('Space');

    end;

    EnableDisable;

    tblTarget.Open;
    tblTarget.EmptyTable;
//    cboTarget.Items.Clear;
    for x := 0 to Props.Count -1 do begin
      propName := Props[x].Name;
      obj := Props[x].Value.AsObject;
      tblTarget.Append;
      tblTarget.FieldByName('Name').AsString := propName;
      tblTarget.FieldByName('DataType').AsString := DataType;
      tblTarget.FieldByName('ReadWrite').AsString := ReadWrite;
      tblTarget.Post;
//      cboTarget.Items.Add(propName + '   (' + obj.S['DataType'] + ' ' + obj.S['ReadWrite'] + ')' + #9 + propName);
    end;

    cboTarget.Text := Map.O['Target'].S['Field'];
    DisplaySourceDataType;

  finally
    Loading := false;
  end;
end;

procedure TfmEDIMapEdit.SelectSource;
begin
  Loading := true;
  try
    if chkSourceInputFile.Checked then begin
      { inpput file column }
      chkSourceValue.Checked := false;
      Map.O['Source'].I['ColumnNumber'] := StrToIntDef(cboSourceCol.Value,0);
      edtSourceValue.Text := '';

      Map.O['Source'].Delete('Value');
    end
    else begin
      { fixed value }
      chkSourceInputFile.Checked := false;
      Map.O['Source'].S['Value'] := edtSourceValue.Text;
      cboSourceCol.ItemIndex := -1;
      Map.O['Source'].Delete('ColumnNumber');
    end;
    edtSourceValue.Enabled := chkSourceValue.Checked;
    cboSourceCol.Enabled := chkSourceInputFile.Checked;
    DisplaySourceDataType;
  finally
    Loading := false;
  end;
end;

end.
