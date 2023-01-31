unit fraEDIMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, AdvObj, BaseGrid, AdvGrid, ExtCtrls, DNMPanel, JsonObject,
  StdCtrls, ActnList, Menus, CheckLst, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  ComCtrls;

type
  TfrEDIMap = class(TFrame)
    pnlMain: TDNMPanel;
    grdMap: TAdvStringGrid;
    lblColumnCount: TLabel;
    cboERPClassName: TComboBox;
    ActionList1: TActionList;
    actEdit: TAction;
    actNew: TAction;
    actDelete: TAction;
    popMap: TPopupMenu;
    Edit1: TMenuItem;
    New1: TMenuItem;
    Delete1: TMenuItem;
    pagesChange: TPageControl;
    tabHeader: TTabSheet;
    pnlHeader: TDNMPanel;
    tabLines: TTabSheet;
    pnlLines: TDNMPanel;
    Label1: TLabel;
    cboHeaderChangeType: TwwDBComboBox;
    lstColsHeader: TCheckListBox;
    lblInputColumnsHeader: TLabel;
    lblColumnChangeTypeHeader: TLabel;
    cboChangeTypeHeader: TwwDBComboBox;
    Label2: TLabel;
    cboLineChangeType: TwwDBComboBox;
    lblInputColumnsLine: TLabel;
    lstColsLine: TCheckListBox;
    lblColumnChangeTypeLine: TLabel;
    cboChangeTypeLine: TwwDBComboBox;
    procedure cboERPClassNameChange(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure grdMapDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure cboHeaderChangeTypeChange(Sender: TObject);
    procedure lstColsHeaderClickCheck(Sender: TObject);
    procedure cboChangeTypeHeaderChange(Sender: TObject);
    procedure cboLineChangeTypeChange(Sender: TObject);
    procedure lstColsLineClickCheck(Sender: TObject);
    procedure cboChangeTypeLineChange(Sender: TObject);
  private
    fConfig: TJsonObject;
    fMapName: string;
    Props: TJsonObject;
    fSourceColumns: TJsonObject;
    Loading: boolean;
    procedure SetConfig(const Value: TJsonObject);
    function GetClassProps(var msg: string): boolean;
    function GetClassList: string;
    procedure LoadGrid;
    procedure ObjectToRow(aRow: integer);
    function GetColumnName(ColNo: integer): string;
    procedure EnableDisable;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MapName: string read fMapName write fMapName;
    property Config: TJsonObject read fConfig write SetConfig;
    property SourceColumns: TJsonObject read fSourceColumns write fSourceColumns;
  end;

implementation

uses
  frmEDIConfigMain, Vista_MessageDlg, frmEDIMapEdit, EDIUtils;

const
  col_MapIndex = 0;
  col_Source = 1;
  col_SourceFunc = 2;
  col_Target = 3;
  col_TargetFunc = 4;

{$R *.dfm}

{ TfrEDIMap }

procedure TfrEDIMap.actDeleteExecute(Sender: TObject);
var
  selRow: integer;
begin
  Loading := true;
  try
    if grdMap.SelectedCellsCount > 0 then begin
      selRow := grdMap.SelectedCell[0].y;
      if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to delete this Map Line?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        Config.A['Map'].Delete(selRow-1);
        LoadGrid;
      end;
    end;
  finally
    Loading := false;
  end;
end;

procedure TfrEDIMap.actEditExecute(Sender: TObject);
var
  selRow: integer;
begin
  if grdMap.SelectedCellsCount > 0 then begin
    selRow := grdMap.SelectedCell[0].y;
    if DoMapEdit(self.Color, TJsonObject(grdMap.Objects[col_MapIndex,selRow]),SourceColumns,Props) then
      ObjectToRow(selRow);


  end;
end;

procedure TfrEDIMap.actNewExecute(Sender: TObject);
var
  obj: TJsonObject;
  selRow: integer;
begin
  obj := JO;
  if DoMapEdit(self.Color, Obj,SourceColumns,Props) then begin
    grdMap.RowCount := grdMap.RowCount + 1;
    grdMap.Objects[col_MapIndex,grdMap.RowCount-1] := obj;
    Config.A['Map'].Add(obj);
    ObjectToRow(grdMap.RowCount-1);
  end
  else begin
    Obj.Free;
  end;
end;

procedure TfrEDIMap.cboChangeTypeHeaderChange(Sender: TObject);
begin
  if Loading then exit;
  Config.O['Target'].O['NewRecordOn'].O['Params'].S['Relationship'] := cboChangeTypeHeader.Value;
end;

procedure TfrEDIMap.cboChangeTypeLineChange(Sender: TObject);
begin
  if Loading then exit;
  Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].S['Relationship'] := cboChangeTypeLine.Value;
end;

procedure TfrEDIMap.cboERPClassNameChange(Sender: TObject);
var
  msg: string;
  fs: TFormStyle;
begin
  if Loading then exit;
  if not GetClassProps(msg) then begin
    fs := Application.MainForm.FormStyle;
    Application.MainForm.FormStyle := fsNormal;
    try
      Vista_MessageDlg.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    finally
      Application.MainForm.FormStyle := fs;
    end;
  end;
end;

procedure TfrEDIMap.cboHeaderChangeTypeChange(Sender: TObject);
begin
  if Loading then exit;
  Config.O['Target'].O['NewRecordOn'].S['ChangeType'] := cboHeaderChangeType.Value;
  EnableDisable;
end;

procedure TfrEDIMap.cboLineChangeTypeChange(Sender: TObject);
begin
  if Loading then exit;
  Config.O['Target'].O['Line'].O['NewRecordOn'].S['ChangeType'] := cboLineChangeType.Value;
  EnableDisable;
end;

constructor TfrEDIMap.Create(AOwner: TComponent);
begin
  inherited;
  Props := JO;
  cboERPClassName.Items.CommaText := GetClassList;
end;

destructor TfrEDIMap.Destroy;
begin
  Props.Free;
  inherited;
end;

procedure TfrEDIMap.EnableDisable;
begin
  { Header }
  if cboHeaderChangeType.Value = 'Column' then begin
    lblInputColumnsHeader.Enabled := true;
    lstColsHeader.Enabled := true;
    lblColumnChangeTypeHeader.Enabled := true;
  end
  else begin
    { Row }
    lblInputColumnsHeader.Enabled := false;
    lstColsHeader.Enabled := false;
    lblColumnChangeTypeHeader.Enabled := false;
  end;

  { Lines }
  if cboLineChangeType.Value = 'Column' then begin
    lblInputColumnsLine.Enabled := true;
    lstColsLine.Enabled := true;
    lblColumnChangeTypeLine.Enabled := true;
  end
  else begin
    { Row }
    lblInputColumnsLine.Enabled := false;
    lstColsLine.Enabled := false;
    lblColumnChangeTypeLine.Enabled := false;
  end;
end;

function TfrEDIMap.GetClassList: string;
var
  mainForm: TfmEDIConfigMain;
  params, j: TJsonObject;
begin
  result := '';
  mainForm := TfmEDIConfigMain(Application.MainForm);

  params := JO;
  j := mainForm.UtilsClient.Client.SendRequest('EDI.GetClassList',params);
  if Assigned(j) then begin
    try
      if not j.Exists('error') then begin
        result := j.S['ClassList'];
      end
      else begin
        Vista_MessageDlg.MessageDlgXP_Vista(j.O['error'].S['message'],mtInformation,[mbOk],0);
        exit;
      end;
    finally
      j.Free;
    end;
  end;

end;

function TfrEDIMap.GetClassProps(var msg: string): boolean;
var
  mainForm: TfmEDIConfigMain;
  params, j: TJsonObject;
begin
  result := true;
  Props.Clear;
  Config.O['Target'].S['ERPClassName'] := cboERPClassName.Text;

  mainForm := TfmEDIConfigMain(Application.MainForm);
  params := JO;
  params.S['ClassName'] := Config.O['Target'].S['ERPClassName'];
  params.S['Database'] := mainForm.Connection.Database;
  params.S['ERPUser'] := mainForm.edtERPUser.Text;
  params.S['ERPPass'] := mainForm.edtERPPass.Text;

  j := mainForm.UtilsClient.Client.SendRequest('EDI.GetObjectProperties',params);
  if Assigned(j) then begin
    try
      if not j.Exists('error') then begin
        Props.Assign(j.O['Props']);
      end
      else begin
        result := false;
        //Vista_MessageDlg.MessageDlgXP_Vista(j.O['error'].S['message'],mtInformation,[mbOk],0);
        msg := j.O['error'].S['message'];
        exit;
      end;
    finally
      j.Free;
    end;
  end;
end;

function TfrEDIMap.GetColumnName(ColNo: integer): string;
var
  obj: TJsonObject;
begin
  result := '[Column ' + IntToStr(ColNo) + ']';
  if Assigned(SourceColumns) then begin
    obj := SourceColumns.O[IntToStr(ColNo)];
    if not Assigned(obj) then exit;
    result := '[' + obj.S['Name'] + ']';
  end;
end;

procedure TfrEDIMap.grdMapDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  actEdit.Execute;
end;

procedure TfrEDIMap.LoadGrid;
var
  x: integer;
  obj: TJsonObject;
begin
  grdMap.RowCount := 1;
  for x := 0 to Config.A['Map'].Count -1 do begin
    grdMap.RowCount := grdMap.RowCount + 1;
    if grdMap.RowCount = 2 then grdMap.FixedRows := 1;
    obj := Config.A['Map'].Items[x].AsObject;
//    grdMap.Cells[col_MapIndex,x+1] := IntToStr(x+1);
    grdMap.Objects[col_MapIndex,x+1] := obj;
    ObjectToRow(x+1);
  end;

end;

procedure TfrEDIMap.lstColsHeaderClickCheck(Sender: TObject);
var
  x: integer;
  val: TJSONNumber;
begin
  if Loading then exit;
  Config.O['Target'].O['NewRecordOn'].O['Params'].A['Columns'].Clear;
  for x := 0 to lstColsHeader.Items.Count -1 do begin
    if lstColsHeader.Checked[x] then begin
      val := TJSONNumber.Create;
      val.Value := Integer(lstColsHeader.Items.Objects[x]);
      Config.O['Target'].O['NewRecordOn'].O['Params'].A['Columns'].Add(val);
    end;
  end;
end;

procedure TfrEDIMap.lstColsLineClickCheck(Sender: TObject);
var
  x: integer;
  val: TJSONNumber;
begin
  if Loading then exit;
  Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].A['Columns'].Clear;
  for x := 0 to lstColsLine.Items.Count -1 do begin
    if lstColsLine.Checked[x] then begin
      val := TJSONNumber.Create;
      val.Value := Integer(lstColsLine.Items.Objects[x]);
      Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].A['Columns'].Add(val);
    end;
  end;
end;

procedure TfrEDIMap.ObjectToRow(aRow: integer);
var
  obj: TJsonObject;
  s: string;
begin
  obj := TJsonObject(grdMap.Objects[col_MapIndex,aRow]);
  grdMap.Cells[col_MapIndex,aRow] := IntToStr(aRow);
  s := '';
  if obj.O['Source'].Exists('ColumnNumber') then
    s := GetColumnName(obj.O['Source'].I['ColumnNumber'])
  else if obj.O['Source'].Exists('Value') then
    s := obj.O['Source'].S['Value'];
  grdMap.Cells[col_Source,aRow] := s;

  s := '';
  if obj.O['Source'].Exists('StringReplace') then begin
    s:= 'Replace "' + obj.O['Source'].O['StringReplace'].S['SearchString'] +
    '" with "' + obj.O['Source'].O['StringReplace'].S['ReplaceString'] + '"';
    if obj.O['Source'].O['StringReplace'].B['ReplaceAll'] then s := s + ' Replace All';
    if obj.O['Source'].O['StringReplace'].B['IgnoreCase'] then begin
      if s <> '' then s := s + ',';
      s := s + ' IgnoreCase';
    end;
  end;
  if obj.O['Source'].B['MapWhenNotBlank'] then begin
    if s <> '' then s := s + ', ';
    s := s + 'Map if Not Blank';
  end;
  grdMap.Cells[col_SourceFunc,aRow] := s;

  s := '';
  if obj.O['Target'].Exists('Field') then
    s := obj.O['Target'].S['Field'];
  grdMap.Cells[col_Target,aRow] := s;

  s := '';
  if obj.O['Target'].Exists('Separator') then begin
    if obj.O['Target'].S['Separator'] = #13#10 then
      s := 'Seperator CRLF'
  end;
  grdMap.Cells[col_TargetFunc,aRow] := s;


end;

procedure TfrEDIMap.SetConfig(const Value: TJsonObject);
var
  x, y: integer;
  fs: TFormStyle;
  msg: string;
begin
  Loading := true;
  try
    fConfig := Value;
    cboERPClassName.ItemIndex := cboERPClassName.Items.IndexOf(Config.O['Target'].S['ERPClassName']);
    if cboERPClassName.Text <> '' then begin
      //GetClassProps;
      if not GetClassProps(msg) then begin
        fs := Application.MainForm.FormStyle;
        FreeAndNil(dlg);

        Application.MainForm.FormStyle := fsNormal;
        try
          Vista_MessageDlg.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
        finally
          Application.MainForm.FormStyle := fs;
        end;
        exit;
      end;
    end;
    LoadGrid;

    for x := 0 to SourceColumns.Count -1 do begin
      lstColsHeader.Items.AddObject(SourceColumns[x].Value.AsObject.S['Name'],TObject(StrToInt(SourceColumns[x].Name)));
      lstColsLine.Items.AddObject(SourceColumns[x].Value.AsObject.S['Name'],TObject(StrToInt(SourceColumns[x].Name)));
    end;
    cboHeaderChangeType.Value := Config.O['Target'].O['NewRecordOn'].S['ChangeType'];
    if cboHeaderChangeType.Value = 'Column' then begin
      for x := 0 to Config.O['Target'].O['NewRecordOn'].O['Params'].A['Columns'].Count -1 do begin
        for y := 0 to lstColsHeader.Items.Count -1 do begin
          if Config.O['Target'].O['NewRecordOn'].O['Params'].A['Columns'][x].AsInteger = Integer(lstColsHeader.Items.Objects[y]) then
            lstColsHeader.Checked[y] := true;
        end;
      end;
      cboChangeTypeHeader.Value := Config.O['Target'].O['NewRecordOn'].O['Params'].S['Relationship'];
    end
    else
      cboChangeTypeHeader.ItemIndex := -1;

    cboLineChangeType.Value := Config.O['Target'].O['Line'].O['NewRecordOn'].S['ChangeType'];
    if cboLineChangeType.Value = 'Column' then begin
      for x := 0 to Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].A['Columns'].Count -1 do begin
        for y := 0 to lstColsLine.Items.Count -1 do begin
          if Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].A['Columns'][x].AsInteger = Integer(lstColsLine.Items.Objects[y]) then
            lstColsLine.Checked[y] := true;
        end;
      end;
      cboChangeTypeLine.Value := Config.O['Target'].O['Line'].O['NewRecordOn'].O['Params'].S['Relationship'];
    end
    else
      cboChangeTypeLine.ItemIndex := -1;


    EnableDisable;
  finally
    Loading := false;
  end;
end;

end.
