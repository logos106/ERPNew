unit fraEDIFileCSV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, JSONObject, StdCtrls, ExtCtrls, DNMPanel, Grids, AdvObj, BaseGrid,
  AdvGrid, AdvEdit, ActnList, Menus;

type
  TfrEDIFileCSV = class(TFrame)
    pnlEDIFileCSV: TDNMPanel;
    Label2: TLabel;
    grdCols: TAdvStringGrid;
    ActionList1: TActionList;
    actEdit: TAction;
    actDelete: TAction;
    actAdd: TAction;
    actInsert: TAction;
    popGrid: TPopupMenu;
    Add1: TMenuItem;
    Insert1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    grpFile: TGroupBox;
    lblColumnCount: TLabel;
    edtNumberOfColumns: TAdvEdit;
    Label1: TLabel;
    edtFieldSep: TEdit;
    chkQuotedStrings: TCheckBox;
    grdFilter: TAdvStringGrid;
    actNewFilter: TAction;
    actEditFilter: TAction;
    actDeleteFilter: TAction;
    popFilter: TPopupMenu;
    New1: TMenuItem;
    Edit2: TMenuItem;
    Delete2: TMenuItem;
    procedure grdColsGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure grdColsGetFormat(Sender: TObject; ACol: Integer;
      var AStyle: TSortStyle; var aPrefix, aSuffix: string);
    procedure grdColsGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure edtNumberOfColumnsChange(Sender: TObject);
    procedure grdColsCheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure grdColsComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: string);
    procedure grdColsEditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure grdColsDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actEditFilterExecute(Sender: TObject);
    procedure grdFilterDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure actNewFilterExecute(Sender: TObject);
    procedure actDeleteFilterExecute(Sender: TObject);
  private
    fConfig: TJsonObject;
    Loading: boolean;
    procedure SetConfig(const Value: TJsonObject);
    procedure ChangeColumns;
    procedure ObjToRow(aRow: integer);
    procedure LoadGrid;
    procedure LoadFilters;
    { Private declarations }
  public
    property Config: TJsonObject read fConfig write SetConfig;
  end;

implementation

uses
  StringUtils, frmEDIColumnEdit, Vista_MessageDlg, frmEDIDataFilter, EDIUtils;

{$R *.dfm}

const
  col_No = 0;
  col_Letter = 1;
  col_Name = 2;
  col_Type = 3;
  col_Required = 4;
  col_Format = 5;

{ TfrEDIFileCSV }

procedure TfrEDIFileCSV.actAddExecute(Sender: TObject);
var
  obj: TJsonObject;
  selRow: integer;
begin
  selRow := Config.O['DataFormatParams'].I['NumberOfColumns'] + 1;
  obj := JO;
  obj.S['Name'] := 'Column ' + IntToAZ(selRow-1);//  IntToStr(selRow);
  obj.S['DataType'] := 'String';

  if frmEDIColumnEdit.DoEditEDIColumn('Column ' + IntToAZ(selRow-1) {IntToStr(selRow)}, Obj,self.Color) then begin

  end
  else begin
    obj.Free;
    exit;
  end;

  edtNumberOfColumns.IntValue := selRow;
  Config.O['DataFormatParams'].I['NumberOfColumns'] := selRow;
  Config.O['Columns'].Add(IntToStr(selRow),obj);

  grdCols.RowCount := grdCols.RowCount +1;
  grdCols.Objects[0,grdCols.RowCount-1] := obj;
  grdCols.SelectRows(grdCols.RowCount-1,1);
  self.ObjToRow(selRow);
  LoadGrid;
  grdCols.ScrollInView(col_Name,grdCols.RowCount-1);




//  edtNumberOfColumns.IntValue := edtNumberOfColumns.IntValue +1;
//  Config.O['DataFormatParams'].I['NumberOfColumns'] := edtNumberOfColumns.IntValue;
//  LoadGrid;
//
//  grdCols.SelectRows(grdCols.RowCount-1,1);
//  grdCols.ScrollInView(col_Name,grdCols.RowCount-1);
//  actEdit.Execute;


//  Config.O['DataFormatParams'].I['NumberOfColumns'] := Config.O['DataFormatParams'].I['NumberOfColumns'] -1;
//        edtNumberOfColumns.IntValue := Config.O['DataFormatParams'].I['NumberOfColumns'];
end;

procedure TfrEDIFileCSV.actDeleteExecute(Sender: TObject);
var
  selRow: integer;
begin
  Loading := true;
  try
    if grdCols.SelectedCellsCount > 0 then begin
      selRow := grdCols.SelectedCell[0].y;
      if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to permently delete this Column?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        Config.O['Columns'].Delete(IntToStr(selRow));
        Config.O['DataFormatParams'].I['NumberOfColumns'] := Config.O['DataFormatParams'].I['NumberOfColumns'] -1;
        edtNumberOfColumns.IntValue := Config.O['DataFormatParams'].I['NumberOfColumns'];
        LoadGrid;
      end;
    end;
  finally
    Loading := false;
  end;
end;

procedure TfrEDIFileCSV.actDeleteFilterExecute(Sender: TObject);
var
  selRow: integer;
begin
  if grdFilter.SelectedCellsCount > 0 then begin
    selRow := grdFilter.SelectedCell[0].y;
    if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to delete this Filter?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      Config.A['Filters'].Delete(selRow-1);
      self.LoadFilters;
    end;
  end;
end;

procedure TfrEDIFileCSV.actEditExecute(Sender: TObject);
var
  selRow: integer;
begin
  if grdCols.SelectedCellsCount > 0 then begin
    selRow := grdCols.SelectedCell[0].y;
    if frmEDIColumnEdit.DoEditEDIColumn('Column ' + grdCols.Cells[0,selRow] +
        ' (' + grdCols.Cells[1,selRow] + ')',
        TJsonObject(grdCols.Objects[0,selRow]),self.Color) then
      self.ObjToRow(selRow);
  end;
end;

procedure TfrEDIFileCSV.actEditFilterExecute(Sender: TObject);
var
  selRow: integer;
begin
  if grdFilter.SelectedCellsCount > 0 then begin
    selRow := grdFilter.SelectedCell[0].y;
    if DoDataFilter(Config,selRow-1,self.Color) then
      LoadFilters;
  end;
end;

procedure TfrEDIFileCSV.actInsertExecute(Sender: TObject);
var
  selRow: integer;
  x: integer;
  obj, newCols, o: TJsonObject;
begin
  if grdCols.SelectedCellsCount > 0 then begin
    selRow := grdCols.SelectedCell[0].y;

    obj := JO;
    obj.S['Name'] := 'Column ' +  IntToAZ(selRow-1); // IntToStr(selRow);
    obj.S['DataType'] := 'String';

    if frmEDIColumnEdit.DoEditEDIColumn('Column ' + IntToAZ(selRow-1) { IntToStr(selRow)}, Obj,self.Color) then begin

    end
    else begin
      obj.Free;
      exit;
    end;

    grdCols.InsertRows(selRow,1);

    for x := 0 to Config.O['Columns'].Count -1 do begin
      if StrToInt(Config.O['Columns'].Items[x].Name) >= selRow then begin
        Config.O['Columns'].Items[x].Name := IntToStr(StrToInt(Config.O['Columns'].Items[x].Name) + 1);
        o := Config.O['Columns'].Items[x].Value.AsObject;
        if Pos('Column ',o.S['Name']) = 1 then
          o.S['Name'] := 'Column ' + Config.O['Columns'].Items[x].Name;
      end;
    end;

    Config.O['Columns'].Add(IntToStr(selRow),obj);

    { now sort the columns }
    newCols := Jo;
    try
      x := 1;
      while Config.O['Columns'].Exists(IntToStr(x)) do begin
        obj := JO;
        obj.Assign(Config.O['Columns'].ItemByName[IntToStr(x)].Value.AsObject);
        newCols.Add(IntToStr(x),obj);
        Inc(x);
      end;
      Config.O['Columns'].Assign(newCols);

    finally
      newCols.Free;
    end;

    Config.O['DataFormatParams'].I['NumberOfColumns'] := Config.O['DataFormatParams'].I['NumberOfColumns'] +1;
    edtNumberOfColumns.IntValue := Config.O['DataFormatParams'].I['NumberOfColumns'];
    LoadGrid;

    grdCols.SelectRows(selRow,1);
    grdCols.ScrollInView(col_Name,selRow);

  end;
end;

procedure TfrEDIFileCSV.actNewFilterExecute(Sender: TObject);
begin
 if DoDataFilter(Config,-1,self.Color) then
   self.LoadFilters;
end;

procedure TfrEDIFileCSV.ChangeColumns;
var
  x: integer;
begin
  for x := 1 to Config.O['DataFormatParams'].I['NumberOfColumns'] do begin
    if not Config.O['Columns'].ObjectExists(IntToStr(x)) then begin
      Config.O['Columns'].O[IntToStr(x)].S['Name'] := 'Column ' + IntToAZ(x-1); // IntToStr(x);
      Config.O['Columns'].O[IntToStr(x)].S['DataType'] := 'String';
      Config.O['Columns'].O[IntToStr(x)].B['Requored'] := false;
    end;
  end;
  if x > 0 then begin
    Inc(x);
    while Config.O['Columns'].ObjectExists(IntToStr(x)) do begin
      Config.O['Columns'].Delete(IntToStr(x));
      Inc(x);
    end;
  end;
end;

procedure TfrEDIFileCSV.edtNumberOfColumnsChange(Sender: TObject);
begin
  if Loading then exit;
  ChangeColumns;
end;

procedure TfrEDIFileCSV.grdColsCheckBoxChange(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
var
  obj: TJsonObject;
begin
  if Loading then exit;
  if ACol = col_Required then begin
    obj := TJsonObject(grdCols.Objects[0,ARow]);
    obj.B['Required'] := State;
  end;
end;

procedure TfrEDIFileCSV.grdColsComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: string);
var
  obj: TJsonObject;
begin
  if Loading then exit;
  if ACol = col_Type then begin
    obj := TJsonObject(grdCols.Objects[0,aRow]);
    obj.S['DataType'] := StrToDataType(ASelection);
    if SameText(ASelection, 'DateTime') then begin
      obj.S['DateFormat'] := SysUtils.FormatSettings. ShortDateFormat;
      obj.S['TimeFormat'] := SysUtils.FormatSettings.ShortTimeFormat;
    end
    else begin
     if obj.StringExists('DateFormat') then
       obj.Delete('DateFormat');
     if obj.StringExists('TimeFormat') then
       obj.Delete('TimeFormat');
    end;
  end;
  self.ObjToRow(ARow);
end;

procedure TfrEDIFileCSV.grdColsDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  actEdit.Execute;
//  if ARow > 0 then begin
//    if frmEDIColumnEdit.DoEditEDIColumn('Column ' + grdCols.Cells[0,ARow] + ' (' + grdCols.Cells[1,ARow] + ')',
//        TJsonObject(grdCols.Objects[0,ARow]),self.Color) then
//      self.ObjToRow(aRow);
//
//  end;
end;

procedure TfrEDIFileCSV.grdColsEditCellDone(Sender: TObject; ACol,
  ARow: Integer);
var
  obj: TJsonObject;
begin
  if Loading then exit;
  if ACol = col_Name then begin
    obj := TJsonObject(grdCols.Objects[0,ARow]);
    obj.S['Name'] := grdCols.Cells[ACol,ARow];
  end;
end;

procedure TfrEDIFileCSV.grdColsGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
var
  x: integer;
begin
  case ACol of
    col_No:;
    col_Letter:;
    col_Name:;
    col_Type:
      begin
        grdCols.ClearComboString;
        for x :=  Low(MapDataTypes) to High(MapDataTypes) do
          grdCols.AddComboString(MapDataTypes[x].Name);
//        grdCols.AddComboString('String');
//        grdCols.AddComboString('Integer');
//        grdCols.AddComboString('Float');
//        grdCols.AddComboString('Currency');
//        grdCols.AddComboString('TrueFalse');
//        grdCols.AddComboString('DateTime');
      end;
    col_Required:;
    col_Format:;
  end;

end;

procedure TfrEDIFileCSV.grdColsGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    col_No:;
    col_Letter:;
    col_Name:;
    col_Type: AEditor := edComboList;
    col_Required: AEditor := edDataCheckBox;
    col_Format:;
  end;
end;

procedure TfrEDIFileCSV.grdColsGetFormat(Sender: TObject; ACol: Integer;
  var AStyle: TSortStyle; var aPrefix, aSuffix: string);
begin
  case ACol of
    col_No: AStyle := ssNumeric;
    col_Letter: AStyle := ssAlphaNumeric;
    col_Name: AStyle := ssAlphaNumeric;
    col_Type: AStyle := ssAlphaNumeric;
    col_Required: AStyle := ssCheckBox;
    col_Format:;
  end;
end;

procedure TfrEDIFileCSV.grdFilterDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  actEditFilter.Execute;
end;

procedure TfrEDIFileCSV.ObjToRow(aRow: integer);
var
  obj: TJsonObject;
  s: string;
begin
  if aRow < 1 then exit;
  obj := TJsonObject(grdCols.Objects[0,aRow]);
  grdCols.Cells[col_Name,aRow] := obj.S['Name'];
  grdCols.Cells[col_Type,aRow] := DataTypeToStr(obj.S['DataType']);
//  grdCols.SetCheckBoxState(col_Required,aRow,obj.B['Required']);
  grdCols.ReadOnly[col_Format,aRow] := true;
  grdCols.AddCheckBox(col_Required,aRow,obj.B['Required'],false);
  if SameText(obj.S['DataType'],'DateTime') then begin
    s:= '';
    if obj.StringExists('DateFormat') then
      s:= 'Date "' + obj.S['DateFormat'] + '"';
    if obj.StringExists('TimeFormat') then begin
      if s <> '' then s := s + ' ';
        s:= s + 'Time "' + obj.S['TimeFormat'] + '"';
    end;
    grdCols.Cells[col_Format,aRow] := s;
  end;
end;

procedure TfrEDIFileCSV.SetConfig(const Value: TJsonObject);
var
  x: integer;
//  s: string;
begin
  Loading := true;
  try
    fConfig := Value;
    edtNumberOfColumns.IntValue := Config.O['DataFormatParams'].I['NumberOfColumns'];

    LoadGrid;

    edtFieldSep.Text := Config.O['DataFormatParams'].S['FieldSep'];
    chkQuotedStrings.Checked := Config.O['DataFormatParams'].B['QuotedStrings'];

    grdCols.ColWidths[0] := 0;

    LoadFilters;
  finally
    Loading := false;
  end;
end;

procedure TfrEDIFileCSV.LoadFilters;
var
  x: integer;
  obj, col: TJsonObject;
  s: string;
begin
  grdFilter.RowCount := 1;
  for x := 0 to Config.A['Filters'].Count -1 do begin
    grdFilter.RowCount := grdFilter.RowCount + 1;
    obj := Config.A['Filters'][x].AsObject;
    col := Config.O['Columns'].O[IntToStr(obj.I['ColumnNumber'])];
    s := 'Unknown';
    if Assigned(Col) then begin
      s := '"' + col.S['Name'] + '" when ' + obj.S['SelectWhen'];
    end;
    grdFilter.Cells[0,grdFilter.RowCount-1] := s;

  end;

  if grdFilter.RowCount > 1 then
    grdFilter.FixedRows := 1;
end;

procedure TfrEDIFileCSV.LoadGrid;
var
  x: integer;
begin
    grdCols.RowCount := edtNumberOfColumns.IntValue + 1;

    ChangeColumns;
    for x := 1 to grdCols.RowCount -1 do begin
      grdCols.Objects[0,x] := Config.O['Columns'].O[IntToStr(x)];
      grdCols.Ints[0,x] := x;
      grdCols.Cells[1,x] :=  IntToAZ(x-1);
      ObjToRow(x);
    end;
end;



end.
