unit frameWwDbGridGuiEdit;

 {
 Date     Version  Who Comment
 -------- -------- --- ---------------------------------------------------------
 16/09/05  1.00.00 MV  Modified procedures actAddExecute, DoColumnSelect,
                       FormulaItemClick, SaveDisplayFormat, SaveSumColumn and
                       SaveFormula to support const GUI_PERF_CUSTOM_COLUMN_TAG
                       to address tag conflict in PersonalTabStop
 03/10/05  1.00.01 ISB AddedComponentNameExists

 }
 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DataTreeObj, StdCtrls, Buttons, CheckLst, ExtCtrls, wwDBGrid, ActnList, DB,
  Menus, frameGuiElementEdit, ComCtrls, GuiPrefsObj, DNMSpeedButton;

type
  TfrWwDbGridGuiEdit = class(TfrGuiElementEdit)
    pumFormula: TPopupMenu;
    mnuColumns: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    multiply1: TMenuItem;
    divide1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    dlgFont: TFontDialog;
    dlgColor: TColorDialog;
    pnlGrid: TPanel;
    pnlColumns: TPanel;
    pnlColumnsTop: TPanel;
    Label1: TLabel;
    pnlColumnsLeft: TPanel;
    lstGridColumns: TCheckListBox;
    chkGridLines: TCheckBox;
    btnGridTitleFont: TDNMSpeedButton;
    btnGridFont: TDNMSpeedButton;
    btnAltRowColour: TDNMSpeedButton;
    procedure lstGridColumnsClickCheck(Sender: TObject);
    procedure btnGridFontClick(Sender: TObject);
    procedure btnGridTitleFontClick(Sender: TObject);
    procedure btnAltRowColourClick(Sender: TObject);
    procedure chkGridLinesClick(Sender: TObject);
  private
    function GetDataset: TDataset;
    function GetSelectedField: TField;
    function Columns: TDataTreeNode;
    function GetGrid: TwwDbGrid;
    property Dataset: TDataset read GetDataset;
    function GetGridGuiElement: TwwDbGridGuiElement;
    procedure ClearColumnList;
  protected
    procedure ShowColumns;
    property GridGuiElement: TwwDbGridGuiElement read GetGridGuiElement;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisplayGuiSettings; override;
    property Grid: TwwDbGrid read GetGrid;
  end;

implementation

{$R *.dfm}

uses
   Wwdbigrd;

const
  CUST_COLUMN_LABLE = '[Custom Column]';

type
  TColumnListItem = class(TObject)
  private
    fFieldName: string;
    fIsCustomColumn: boolean;
  public
    constructor Create;
    property FieldName: string read fFieldName write fFieldName;
    property IsCustomColumn: boolean read fIsCustomColumn write fIsCustomColumn;
  end;

{ TColumnListItem }

constructor TColumnListItem.Create;
begin
    fFieldName:= '';
    fIsCustomColumn:= false;
end;

{ TfrCustomiseDBGrid }

constructor TfrWwDbGridGuiEdit.Create(AOwner: TComponent);
begin
  inherited;

end;

function TfrWwDbGridGuiEdit.GetGrid: TwwDbGrid;
begin
  if Assigned(Element) then
    result:= TwwDbGrid(Element.Target)
  else
    result:= nil;
end;

function TfrWwDbGridGuiEdit.GetDataset: TDataset;
begin
  if Assigned(Grid) then
    result:= Grid.DataSource.DataSet
  else
    result:= nil;
end;

procedure TfrWwDbGridGuiEdit.ShowColumns;
var
  x, idx: integer;
  ColItem: TColumnListItem;
begin
  if (not Assigned(Element)) then Exit;
  ClearColumnList;
  for x:= 0 to DataSet.FieldCount -1 do begin
//    if not TDbPrimaryKeys.TableKeyExists(DataSet.Fields[x].FieldName) then begin
      ColItem:= TColumnListItem.Create;
      ColItem.FieldName:= DataSet.Fields[x].FieldName;
      idx:= lstGridColumns.Items.AddObject(DataSet.Fields[x].FieldName, ColItem);

      lstGridColumns.Checked[idx]:= Dataset.Fields[x].Visible;
      Columns[DataSet.Fields[x].FieldName+'.Visible'].AsBoolean:= Dataset.Fields[x].Visible;
      if ColITem.IsCustomColumn then begin
        lstGridColumns.Items[idx]:= lstGridColumns.Items[idx] + ' ' +CUST_COLUMN_LABLE;
      end;
//    end;
  end;
//  TDbPrimaryKeys.FreeMe;
end;

procedure TfrWwDbGridGuiEdit.lstGridColumnsClickCheck(Sender: TObject);
var
  Field: TField;
  x, LastVisibleFieldIndex, CurrentFieldIndex, FldIndex: integer;
begin
  Field:= GetSelectedField;
  if Assigned(Field) then begin
    Field.Visible:= not Field.Visible;
    Columns[Field.FieldName + '.Visible'].AsBoolean:= Field.Visible;

   // Reindex the fields in the node Gui Data
    if Field.Visible then begin
      // User has made field visible so needs to be added to end of other
      // visible fields and non visible fields with a lower index need to be
      // incremented
      LastVisibleFieldIndex:= 0;
      CurrentFieldIndex:= Field.Index;
      for x:= 0 to Columns.Count -1 do begin
        if Columns.Items[x].NodeName <> Field.FieldName then begin
          FldIndex:= Columns.Items[x].ItemByName['Index'].AsInteger;
          if Columns.Items[x].ItemByName['Visible'].AsBoolean then begin
            // get the index of the last
            if FldIndex > LastVisibleFieldIndex then
              LastVisibleFieldIndex:= FldIndex;
          end
          else begin
            if FldIndex < CurrentFieldIndex then
              Columns.Items[x].ItemByName['Index'].AsInteger := FldIndex + 1;
          end;
        end;
      end; // for
      Columns[Field.FieldName +'.Index'].AsInteger:= LastVisibleFieldIndex + 1;
    end
    else begin
      // Field has beeen made Not visible so shuffle visible fiels with a
      // higher index up
      LastVisibleFieldIndex:= 0;
      CurrentFieldIndex:= Field.Index;
      for x:= 0 to Columns.Count -1 do begin
        if Columns.Items[x].NodeName <> Field.FieldName then begin
          FldIndex:= Columns.Items[x].ItemByName['Index'].AsInteger;
          if Columns.Items[x].ItemByName['Visible'].AsBoolean then begin
            // get the index of the last
            if FldIndex > LastVisibleFieldIndex then
              LastVisibleFieldIndex:= FldIndex;
            if FldIndex > CurrentFieldIndex then
              Columns.Items[x].ItemByName['Index'].AsInteger:= FldIndex -1;
          end;
        end;  
      end; // for
      Columns[Field.FieldName +'.Index'].AsInteger:= LastVisibleFieldIndex + 1;
    end;
  end;
end;

function TfrWwDbGridGuiEdit.GetSelectedField: TField;
begin
  result:= nil;
  if lstGridColumns.ItemIndex > -1 then
    result:=
      Dataset.FindField(TColumnListItem(lstGridColumns.Items.Objects[lstGridColumns.ItemIndex]).FieldName);
end;

function TfrWwDbGridGuiEdit.Columns: TDataTreeNode;
begin
  if Assigned(Node) then
    result:= Node['Columns']
  else
    result:= nil;
end;

procedure TfrWwDbGridGuiEdit.DisplayGuiSettings;

  procedure DisableAllControls(aPanel: TPanel);
  var x: integer;
  begin
    for x:= 0 to aPanel.ControlCount -1 do begin
      if aPanel.Controls[x] is TPanel then
        DisableAllControls(TPanel(aPanel.Controls[x]))
      else
        aPanel.Controls[x].Enabled:= false;
    end;
  end;

begin
  inherited;
  ShowColumns;
  chkGridLines.Checked:= dgColLines in Grid.Options;
end;

procedure TfrWwDbGridGuiEdit.btnGridFontClick(Sender: TObject);
begin
  inherited;
  dlgFont.Font:= Grid.Font;
  if dlgFont.Execute then begin
    Grid.Font:= dlgFont.Font;
    FontToNode(dlgFont.Font, Node['Font']);
  end;
end;

procedure TfrWwDbGridGuiEdit.btnGridTitleFontClick(Sender: TObject);
begin
  inherited;
  dlgFont.Font:= Grid.TitleFont;
  if dlgFont.Execute then begin
    Grid.TitleFont:= dlgFont.Font;
    FontToNode(dlgFont.Font, Node['TitleFont']);
  end;
end;

procedure TfrWwDbGridGuiEdit.btnAltRowColourClick(Sender: TObject);
begin
  inherited;
  dlgColor.Color:= Grid.PaintOptions.AlternatingRowColor;
  if dlgColor.Execute then begin
    Grid.PaintOptions.AlternatingRowColor:= dlgColor.Color;
    node['AlternatingRowColor'].AsInteger := dlgColor.Color;
  end;
end;

procedure TfrWwDbGridGuiEdit.chkGridLinesClick(Sender: TObject);
begin
  inherited;
  if chkGridLines.Checked then
    Grid.Options:= Grid.Options + [dgColLines, dgRowLines]
  else
    Grid.Options:= Grid.Options - [dgColLines, dgRowLines];
  node['ShowGridLines'].AsBoolean:= chkGridLines.Checked;
end;

function TfrWwDbGridGuiEdit.GetGridGuiElement: TwwDbGridGuiElement;
begin
  result:= TwwDbGridGuiElement(Element);
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

initialization
  RegisterClass(TfrWwDbGridGuiEdit);

finalization
  UnregisterClass(TfrWwDbGridGuiEdit);

end.
