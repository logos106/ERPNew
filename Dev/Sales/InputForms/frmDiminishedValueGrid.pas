unit frmDiminishedValueGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Grids, AdvObj, BaseGrid, AdvGrid, DNMSpeedButton, StdCtrls, Shader, DNMPanel,
  GradientLabel, AdvSmoothLabel, JsonObject, contnrs, ProgressDialog, ComCtrls;

type
  TValueGrid = class;
  TfmDiminishedValueGrid = class(TBaseInputGUI)
    PageControl1: TPageControl;
    tabwithRego: TTabSheet;
    tabwithoutRego: TTabSheet;
    grdMatrix1: TAdvStringGrid;
    Label2: TLabel;
    GradientLabel2: TGradientLabel;
    grdMatrix2: TAdvStringGrid;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    GradientLabel1: TGradientLabel;
    procedure grdMatrix1GetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure grdMatrix1GetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure grdMatrix1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grdMatrix1GetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure grdMatrix1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdMatrix1EditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Resize(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
  public
    gridvals_1: TValueGrid;
    gridvals_2: TValueGrid;
  end;

  TRowColRec = class(TPersistent)
  private
    fValue: double;
    fRowColNumber: integer;
  published
    property RowColNumber: integer read fRowColNumber write fRowColNumber;
    property Value: double read fValue write fValue;
  end;

  TValueGridRec = class(TPersistent)
  private
    fValue: double;
    fRow: integer;
    fColumn: integer;
  published
    property Column: integer read fColumn write fColumn;
    property Row: integer read fRow write fRow;
    property Value: double read fValue write fValue;
  end;

  TValueGrid = class(TPersistent)
  private
    fValues: TObjectList;
    fRows: TObjectList;
    fColumns: TObjectList;
    function GetValue(aCol, aRow: integer): double;
    procedure SetValue(aCol, aRow: integer; const Value: double);
    function GetColValue(col: integer): double;
    function GetRowValue(row: integer): double;
    procedure SetColValue(col: integer; const Value: double);
    procedure SetRowValue(row: integer; const Value: double);
    function GetColRec(index: integer): TRowColRec;
    function GetRowRec(index: integer): TRowColRec;
    function GetValRec(aCol, aRow: integer): TValueGridRec;
    procedure SetJsonText(const Value: string);
    function GetJsonText: string;
  public
    constructor Create;
    destructor Destroy; override;
    function AddColumn(aCol: integer; aValue: double): integer;
    function AddRow(aRow: integer; aValue: double): integer;
    property Value[aCol, aRow: integer]: double read GetValue write SetValue;
    function ColCount: integer;
    function RowCount: integer;
    property RowValue[row: integer]: double read GetRowValue write SetRowValue;
    property ColValue[col: integer]: double read GetColValue write SetColValue;
    property RowRec[index: integer]: TRowColRec read GetRowRec;
    property ColRec[index: integer]: TRowColRec read GetColRec;
    property ValRec[aCol, aRow: integer]: TValueGridRec read GetValRec;
    procedure Clear;
    property JsonText: string read GetJsonText write SetJsonText;
    function CalcValue(ColVal, RowVal: double): double;
  published
    property Columns: TObjectList read fColumns;
    property Rows: TObjectList read fRows;
    property Values: TObjectList read fValues;
  end;


function DoEditDiminishedValeMatrix(Json_1, Json_2: TJsonObject): boolean;

implementation

{$R *.dfm}

uses
  JsonToObject, CommonLib, ObjectSerialiser, DNMLib;


function DoEditDiminishedValeMatrix(Json_1, Json_2: TJsonObject): boolean;
var
  form: TfmDiminishedValueGrid;
//  JS: TJSONSerialiser;
//  JD: TJSONDeserialiser;
//  obj: TJsonObject;

begin
  form:= TfmDiminishedValueGrid.Create(nil);
  try
    form.gridvals_1.JsonText:= Json_1.AsString;
    form.gridvals_2.JsonText:= Json_2.AsString;
    result:= form.ShowModal = mrOk;
    if result then begin
      Json_1.AsString:= form.gridvals_1.JsonText;
      Json_2.AsString:= form.gridvals_2.JsonText;
    end;
  finally
    form.Free;
  end;
end;


procedure TfmDiminishedValueGrid.btnSaveClick(Sender: TObject);
var
  col,row: integer;
  ctr:Integer;
  grd: TValueGrid;
  stGrid :TAdvStringGrid;
begin
  inherited;
  { validate and save }
  for ctr:= 1 to 2 do begin
      if ctr = 1 then grd :=gridvals_1 else grd := gridvals_2;
      if ctr = 1 then stGrid :=grdMatrix1 else stgrid := grdMatrix2;

      grd.Clear;
      for col := 0 to stGrid.ColCount -1 do begin
        for row := 0 to stGrid.RowCount -1 do begin
          if (row = 0) and (col = 0) then
            continue;
          if col = 0 then begin
            if stGrid.Cells[col,row] = '' then
              continue;
            if (row > 1) and (stGrid.Floats[col,row] <= stGrid.Floats[col,row-1]) then begin
              MessageDlgXP_Vista('The repair range value in row ' + IntToStr(row) + ' must be greater than the value in row ' + IntToStr(row-1), mtInformation, [mbOk],0);
              exit;
            end;
            grd.AddRow(row, stGrid.Floats[col,row]);
          end
          else if row = 0 then begin
            if stGrid.Cells[col,row] = '' then
              continue;
            if (col > 1) and (stGrid.Floats[col,row] <= stGrid.Floats[col-1,row]) then begin
              MessageDlgXP_Vista('The dealer cost value in column ' + IntToStr(col) + ' must be greater than the value in column ' + IntToStr(col-1), mtInformation, [mbOk],0);
              exit;
            end;
            grd.AddColumn(col, stGrid.Floats[col,row]);
          end
          else begin
            if (stGrid.Cells[0,row] = '') or (stGrid.Cells[col,0] = '') then
              continue;
            if stGrid.Cells[col,row] = '' then begin
              MessageDlgXP_Vista('The value in column ' + IntToStr(col) + ', row ' + IntToStr(row) + ' is blank', mtInformation, [mbOk],0);
              exit;
            end;
            grd.Value[col,row]:= stGrid.Floats[col,row];
          end;
        end;
      end;
  end;
  ModalResult:= mrOk;
end;

procedure TfmDiminishedValueGrid.FormCreate(Sender: TObject);
begin
  inherited;
  gridvals_1:= TValueGrid.Create;
  gridvals_2:= TValueGrid.Create;
end;

procedure TfmDiminishedValueGrid.FormDestroy(Sender: TObject);
begin
  inherited;
  gridvals_1.Free;
  gridvals_2.Free;
end;


procedure TfmDiminishedValueGrid.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageControl1, 1);
end;

procedure TfmDiminishedValueGrid.FormShow(Sender: TObject);
var
 col,row, x: integer;
 valRec: TValueGridRec;
  grd: TValueGrid;
  stGrid :TAdvStringGrid;
  ctr:Integer;

begin
  inherited;
  row:= 0;

  for ctr:= 1 to 2 do begin
    if ctr = 1 then grd :=gridvals_1 else grd := gridvals_2;
    if ctr = 1 then stGrid :=grdMatrix1 else stgrid := grdMatrix2;

    for x:= 0 to grd.ColCount -1 do
      stGrid.Cells[grd.ColRec[x].RowColNumber,row]:= FormatFloat('#,##0.00',grd.ColRec[x].Value);
    col:= 0;
    for x:= 0 to grd.RowCount -1 do
      stGrid.Cells[col,grd.RowRec[x].RowColNumber]:= FormatFloat('#,##0.00',grd.RowRec[x].Value);

    for x:= 0 to grd.Values.Count -1 do begin
      valRec:= TValueGridRec(grd.Values[x]);
      stGrid.Cells[valRec.Column,valRec.Row]:= FormatFloat('#,##0.00',valRec.Value);
    end;
  end;
  RealignTabControl(PageControl1, 1);
end;

procedure TfmDiminishedValueGrid.grdMatrix1CanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit:= not ((ACol = 0) and (ARow = 0));
end;

procedure TfmDiminishedValueGrid.grdMatrix1EditCellDone(Sender: TObject; ACol,
  ARow: Integer);
begin
  inherited;
  if TAdvStringGrid(Sender).Cells[ACol,ARow] <> '' then
    TAdvStringGrid(Sender).Cells[ACol,ARow] := FormatFloat('#,##0.00',TAdvStringGrid(Sender).Floats[ACol,ARow]);
end;

procedure TfmDiminishedValueGrid.grdMatrix1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  HAlign:= taCenter;

end;

procedure TfmDiminishedValueGrid.grdMatrix1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  if (ACol = 0) and (ARow = 0) then
    ABrush.Color := clGray
  else if (ACol = 0) or (ARow = 0) then
    AFont.Style := [fsBold]
  else
    AFont.Style := []
end;

procedure TfmDiminishedValueGrid.grdMatrix1GetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  AEditor:= edFloat;
end;

procedure TfmDiminishedValueGrid.grdMatrix1GetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
  if TAdvStringGrid(Sender).Cells[ACol,ARow] <> '' then
    Value:= FormatFloat('#,##0.00',TAdvStringGrid(Sender).Floats[ACol,ARow])
  else
    Value := '';
end;

procedure TfmDiminishedValueGrid.PageControl1Resize(Sender: TObject);
begin
  inherited;
end;

{ TGridValues }

function TValueGrid.AddColumn(aCol: integer; aValue: double): integer;
var
  rec: TRowColRec;
begin
  rec:= TRowColRec.Create;
  rec.fRowColNumber:= aCol;
  rec.Value:= aValue;
  result:= fColumns.Add(rec);
end;

function TValueGrid.AddRow(aRow: integer; aValue: double): integer;
var
  rec: TRowColRec;
begin
  rec:= TRowColRec.Create;
  rec.fRowColNumber:= aRow;
  rec.Value:= aValue;
  result:= fRows.Add(rec);
end;

function TValueGrid.CalcValue(ColVal, RowVal: double): double;
var
  x, col, row: integer;
begin
  result:= 0;
  col:= -1;
  row:= -1;
  for x := self.ColCount-1 downto 0 do begin
    if ColRec[x].Value < ColVal then begin
      col:= ColRec[x].RowColNumber;
      break;
    end;
  end;
  for x := self.RowCount-1 downto 0 do begin
    if RowRec[x].Value < RowVal then begin
      row:= RowRec[x].RowColNumber;
      break;
    end;
  end;
  if (col > -1) and (row > -1) then begin
    result:= Value[col,row];
  end;
end;

procedure TValueGrid.Clear;
begin
  fColumns.Clear;
  fRows.Clear;
  fValues.Clear;
end;

function TValueGrid.ColCount: integer;
begin
  result:= fColumns.Count;
end;

constructor TValueGrid.Create;
begin
  fValues:= TObjectList.Create(true);
  fRows:= TObjectList.Create(true);
  fColumns:= TObjectList.Create(true);
end;

destructor TValueGrid.Destroy;
begin
  fColumns.Free;
  fRows.Free;
  fValues.Free;
  inherited;
end;

function TValueGrid.GetColRec(index: integer): TRowColRec;
begin
  result:= TRowColRec(Columns[index]);
end;

function TValueGrid.GetColValue(col: integer): double;
var
  x: integer;
begin
  result:= 0;
  for x := 0 to Columns.Count -1 do begin
    if TRowColRec(Columns[x]).RowColNumber = col then begin
      result:= TRowColRec(Columns[x]).Value;
      exit;
    end;
  end;
end;

function TValueGrid.GetJsonText: string;
var
  JSONSerialiser: TJSONSerialiser;
begin
  JSONSerialiser:= TJSONSerialiser.Create;
  try
    with JSONSerialiser.SerialiseObject(self) do begin
      result:= AsString;
      Free;
    end;
  finally
    JSONSerialiser.Free;
  end;
end;

function TValueGrid.GetRowRec(index: integer): TRowColRec;
begin
  result:= TRowColRec(Rows[index]);
end;

function TValueGrid.GetRowValue(row: integer): double;
var
  x: integer;
begin
  result:= 0;
  for x := 0 to Rows.Count -1 do begin
    if TRowColRec(Rows[x]).RowColNumber = row then begin
      result:= TRowColRec(Rows[x]).Value;
      exit;
    end;
  end;
end;

function TValueGrid.GetValRec(aCol, aRow: integer): TValueGridRec;
var
  x: integer;
  rec: TValueGridRec;
begin
  result:= nil;
  for x := 0 to Values.Count -1 do begin
    rec:= TValueGridRec(Values[x]);
    if (rec.Column = aCol) and (rec.Row = aRow) then begin
      result:= rec;
      exit;
    end;
  end;
end;

function TValueGrid.GetValue(aCol, aRow: integer): double;
var
  i: integer;
begin
  result:= 0;
  for i := 0 to fValues.Count -1 do begin
    if (TValueGridRec(fValues[i]).Column = aCol) and
    (TValueGridRec(fValues[i]).Row = aRow) then begin
      result:= TValueGridRec(fValues[i]).Value;
      break;
    end;
  end;
end;

function TValueGrid.RowCount: integer;
begin
  result:= fRows.Count;
end;

procedure TValueGrid.SetColValue(col: integer; const Value: double);
var
  x: integer;
  rec: TRowColRec;
begin
  for x := 0 to Columns.Count -1 do begin
    if TRowColRec(Columns[x]).RowColNumber = col then begin
      rec:= TRowColRec(Columns[x]);
      rec.Value:= Value;
      exit;
    end;
  end;
  rec:= TRowColRec.Create;
  rec.RowColNumber:= col;
  rec.Value:= Value;
  Columns.Add(rec);
end;

procedure TValueGrid.SetJsonText(const Value: string);
var
  Json, item: TJsonObject;
  list: TJsonArray;
  x: integer;
begin
  Clear;
//  exit;
  Json:= JO;
  try
    Json.AsString:= Value;
    list:= Json.O['fields'].A['Columns'];
    for x := 0 to list.Count-1 do begin
      item:= list.Items[x].AsObject;
      self.AddColumn(item.O['fields'].I['RowColNumber'],item.O['fields'].F['Value']);
    end;
    list:= Json.O['fields'].A['Rows'];
    for x := 0 to list.Count-1 do begin
      item:= list.Items[x].AsObject;
      self.AddRow(item.O['fields'].I['RowColNumber'],item.O['fields'].F['Value']);
    end;
    list:= Json.O['fields'].A['Values'];
    for x := 0 to list.Count-1 do begin
      item:= list.Items[x].AsObject;
      self.Value[item.O['fields'].I['Column'],item.O['fields'].I['Row']]:= item.O['fields'].F['Value'];
    end;
  finally
    Json.Free;
  end;
end;

procedure TValueGrid.SetRowValue(row: integer; const Value: double);
var
  x: integer;
  rec: TRowColRec;
begin
  for x := 0 to Rows.Count -1 do begin
    if TRowColRec(Rows[x]).RowColNumber = row then begin
      rec:= TRowColRec(Rows[x]);
      rec.Value:= Value;
      exit;
    end;
  end;
  rec:= TRowColRec.Create;
  rec.RowColNumber:= row;
  rec.Value:= Value;
  Rows.Add(rec);
end;

procedure TValueGrid.SetValue(aCol, aRow: integer; const Value: double);
var
  i: integer;
  rec: TValueGridRec;
begin
  for i := 0 to fValues.Count -1 do begin
    if (TValueGridRec(fValues[i]).Column = aCol) and
    (TValueGridRec(fValues[i]).Row = aRow) then begin
      rec:= TValueGridRec(fValues[i]);
      rec.Value:= Value;
      exit;
    end;
  end;
  rec:= TValueGridRec.Create;
  rec.Column:= aCol;
  rec.Row:= aRow;
  rec.Value:= Value;
  fValues.Add(rec);
end;

initialization
  RegisterClass(TfmDiminishedValueGrid);
//  RegisterClass(TValueGrid);
//  RegisterClass(TValueGridRec);
//  RegisterClass(TRowColRec);

end.
