unit BaseTreeView;

{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  VirtualTrees, StdCtrls, ExtCtrls, DNMPanel,
  wwdbdatetimepicker, Buttons, DNMSpeedButton, DataState, Menus, AdvMenus,
  GuiPrefsObj, PrintTemplateObj, Shader, ImgList, MemDS, ProgressDialog, forms , VTEditControl;

const
      CheckBoxTrueValue = 'Yes';
      CheckBoxFalseValue = 'No';
      SX_DatechangeMsg = WM_USER + 130;
type
  TIteratingNode = record
    Parentnode: PVirtualnode;
    aNode: PVirtualnode;
  end;

  TDoIterateTreeNode = Procedure (Parentnode, aNode: PVirtualnode) of Object ;

  TValueType = (vtNone,
    vtString,
    vtInteger,
    vtFloat,
    vtCurrency,
    vtDate,
    vtBoolean,
    vtPercentage
    );

  TTreeColumnList = class;
  TTreeColumn     = class(TObject)
  private
    fTreeColumn: TVirtualTreeColumn;
    fVisible: boolean;
    fWidth: integer;
    fColumnName: string;
    fColumnList: TTreeColumnList;
    procedure SetVisible(const Value: boolean);
    function GetColumnName: string;
    procedure SetColumnName(const Value: string);
    function GetDisplayLabel: string;
    procedure SetDisplayLabel(const Value: string);
    function GetWidth: integer;
    procedure SetWidth(const Value: integer);
    function GetAlignment: TAlignment;
    procedure SetAlignment(const Value: TAlignment);
    function GetPosition: integer;
    function GetIndex: integer;
  Protected
  public
    FieldType: TValueType;
    constructor Create(ColumnList: TTreeColumnList; VirtualTreeColumn: TVirtualTreeColumn);
    destructor Destroy; override;
    property Visible: boolean read fVisible write SetVisible;
    property ColumnName: string read GetColumnName write SetColumnName;
    property DisplayLabel: string read GetDisplayLabel write SetDisplayLabel;
    property Width: integer read GetWidth write SetWidth;
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property ColumnList: TTreeColumnList read fColumnList;
    property Position: integer read GetPosition;
    property Index: integer read GetIndex;
  end;

  TTreeColumnList = class(TObject)
  private
    fList: TList;
    fTree: TVirtualStringTree;
    fOnColumnChange: TNotifyEvent;
    fHeaderColor: TColor;
    function GetColumn(const x: integer): TTreeColumn;
    function GetHeader: TVTHeader;
    function GetColumnByName(ColumnName: string): TTreeColumn;
  public
    constructor Create(const TreeView: TVirtualStringTree);
    destructor Destroy; override;
    property OnColumnChange: TNotifyEvent read fOnColumnChange write fOnColumnChange;
    function Add(const ColumnName: string; const FieldType: TValueType; const ColWidth: integer;const Align: TAlignment = taLeftJustify;displayLabel:String = ''): TTreeColumn;
    function Count: integer;
    procedure Delete(const index: integer);
    procedure Clear;
    property Column[const x: integer]: TTreeColumn read GetColumn; default;
    property ByName[ColumnName: string]: TTreeColumn  read GetColumnByName;
    property Header: TVTHeader read GetHeader;
    property HeaderColor: TColor read fHeaderColor write fHeaderColor;
  end;

  TTreeCellData = class(TObject)
  private
    fColumn: TTreeColumn;
    fValue: string;
    function GetAsString: string;
    procedure SetAsString(const aValue: string);
    function getValue: string;
    procedure setValue(const Value: string);
  public
    constructor Create(const Column: TTreeColumn);
    destructor Destroy; override;
    property AsString: string read GetAsString write SetAsString;
    property TreeColumn: TTreeColumn read fColumn;
    Property Value :string read getValue write setValue;
  end;

  TNodeData = class(TObject)
  private
    fList: TList;  // list of TTreeCellData
    fColumnList: TTreeColumnList;
    FiLevel: integer;
    function GetData(const ColumnNumber: integer): TTreeCellData;
    function GetDataByName(const ColumnName: string): TTreeCellData;
    function getColumncount: Integer;
  public
    Id: integer;
    KeyStr: string;

    constructor Create(const ColumnList: TTreeColumnList);
    destructor Destroy; override;
    property CellData[const ColumnNumber: integer]: TTreeCellData read GetData;
    property ByName[const ColumnName: string]: TTreeCellData read GetDataByName;
    Property Columncount :Integer read getColumncount;
    property Level: integer read FiLevel write fiLevel;
  end;


  PNodeRec = ^TNodeRec;
  TNodeRec = record
    Captions: array of string;
    CheckBoxes: array of TCheckBox;
    Data: TNodeData;
  end;


  TTreeExpandMode = (emExpandAll, emContractAll, emExpandLoad, emExpandSave);

  TNodeDblClick = procedure(Node: PVirtualNode; Column: TColumnIndex) of object;

  TVTFrameEditControl = class(TVTEditControlbase, IVTEditLink)
    Private
    fiAccessLevel: Integer;
//      function getcolumwidth(nodeData: PNodeRec;iWidth:Integer;ParentNodeData:PNodeRec): Integer;
    Protected
      function getEditcontrol(aColumn: TColumnIndex): TEditControlType; Override;
      procedure HandleComboBoxCloseUp(Sender: TObject);Override;
    Public
      Property AccessLevel :Integer read fiAccessLevel write fiAccessLevel;
      function BeginEdit  : Boolean; stdcall;
      function CancelEdit : Boolean; stdcall;
      function EndEdit    : Boolean; stdcall;
      function GetBounds  : TRect  ; stdcall;
      function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
      procedure ProcessMessage(var message: TMessage); stdcall;
      procedure SetBounds(R: TRect); stdcall;
  end;

  TBaseTreeViewGUI = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnCustomize: TDNMSpeedButton;
    cmdExport: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    cboDateRange: TComboBox;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    PrintDialog: TPrintDialog;
    PrinterSetupDialog: TPrinterSetupDialog;
    dlgSave: TSaveDialog;
    btnExpandAll: TDNMSpeedButton;
    pnlSearch: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cboFilter: TComboBox;
    edtSearch: TEdit;
    btnGo: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblMsg: TLabel;
    Tree: TVirtualStringTree;
    Memo1: TMemo;
    btnRequery: TDNMSpeedButton;
    chkBlankwhen0: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExpandAllClick(Sender: TObject);
    procedure TreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure TreeAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      const Elements: THeaderPaintElements);
    procedure TreeHeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      var Elements: THeaderPaintElements);
    procedure TreeColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure btnRequeryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkBlankwhen0Click(Sender: TObject);
  private
    ExportDelimiter: string;
    ExportFile: TextFile;
    ExpandMode: TTreeExpandMode;
    TreeShiftState: TShiftState;
    SelectedColumn: TColumnIndex;
    ChangingDate:Boolean;
    procedure DoColumnChange(Sender: TObject);
    procedure SearchCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
    procedure ExportCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
    procedure ExpandAllCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
    function ValidReport(const ReportName, SQLPortion: string): boolean;
    function getSelectedcolumnName: String;
    function getSelectedCellData: String;
    procedure IterateTreeNodeCallback(Captionindex:Integer; Parentnode, aNode: PVirtualnode;DoIterateTreeNode: TDoIterateTreeNode);
    function TreenodeValue(iindex: Integer; xNode: PVirtualnode): String;
    function BlankWhen0:boolean;
    function getFilterDateFrom: TDateTime;
    function getFilterdateto: TDateTime;
  protected
    FVTEditControl: TVTFrameEditControl;
    Columns: TTreeColumnList;
    PrintTemplate: TPrintTemplates;
    fbReportSQLSupplied: boolean;
    IterateNodeNo:Integer;
    GuiPrefs: TFormGuiPrefs;
    formshown:boolean;
  //SelectedNode: PVirtualNode;
    procedure ExpandContractTree(Expand: boolean);
    procedure RefreshTree; virtual;
    procedure TreeDoubleClick(Node: PVirtualNode; Column: TColumnIndex); virtual;
    procedure SaveExpandedState;
    procedure LoadExpandedState;
    procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer);
    Procedure Hidecolumn(Const ColIndex:Integer);virtual;
    Procedure UnHidecolumn(Const ColIndex:Integer);virtual;
    Procedure ActivateGuiPrefs(Const Value:boolean = True);
    Procedure WriteGuiPref;Overload;Virtual;
    function Addcolumn(const ColumnName: string; const FieldType: TValueType; const ColWidth: integer;const Align: TAlignment = taLeftJustify;displayLabel:String = ''): TTreeColumn; virtual;
    procedure InitTreenodesize; Virtual;
    function getColumnByname(Columnname: String): String;Virtual;
    function GetRootNodeData: TNodeData;
    Procedure IterateTree(Captionindex:Integer; DoIterateTreeNode: TDoIterateTreeNode); overload; virtual;
    Procedure IterateTree(Captionindex:Integer; aNode: PVirtualnode; DoIterateTreeNode: TDoIterateTreeNode); overload; virtual;
    Procedure Readguiprefs;virtual;
    Procedure WriteGuiPrefs;virtual;
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    Procedure ExpandAll;
    Procedure ContractAll;
    Procedure DoAfterExpand;virtual;
    Procedure DoAfterContract;virtual;

    //procedure DoIterateTreeNode(aNode: PVirtualnode);virtual;

  public
    ToPrevDate: TDateTime;
    FromPrevDate: TDateTime;
    procedure UpdateMe; override;
    Property SelectedcolumnName:String read getSelectedcolumnName;
    Property SelectedCellData :String read getSelectedCellData;
    Property ColumnByname[Columnname:String]:String read getColumnByname;
    property FilterDateFrom: TDateTime read getFilterDateFrom;
    property FilterDateTo: TDateTime read getFilterdateto;

  end;

implementation

{$R *.dfm}

uses FastFuncs,DateUtils, Math, Printers, AppContextObj,
  CommonDbLib, AppEnvironment, CommonLib, LogLib, LogUtils, tcConst;


procedure TBaseTreeViewGUI.InitTreenodesize;
begin
  Tree.NodeDataSize := SizeOf(TNodeRec);
end;
procedure TBaseTreeViewGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPrefs;
  GuiPrefs.SavePrefs;
end;

procedure TBaseTreeViewGUI.FormCreate(Sender: TObject);
begin
  ChangingDate := False;
  formshown := False;
  inherited;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.prefsname := guiprefname;
  GuiPrefs.Active := True;
  Readguiprefs;
  IterateNodeNo:=0;
  Columns := TTreeColumnList.Create(Tree);
  Columns.OnColumnChange := DoColumnChange;

  // Set up some grid defaults
  Columns.Header.Font.Style := Columns.Header.Font.Style + [fsBold];
  Columns.Header.Options := Columns.Header.Options + [hoVisible];
  Columns.Header.Options := Columns.Header.Options + [hoOwnerDraw];

  Tree.TreeOptions.AnimationOptions := Tree.TreeOptions.AnimationOptions + [toAnimatedToggle]; // slow expand
  Tree.IncrementalSearch := isNone;
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toExtendedFocus]; // enable selecting of columns

  //Tree.NodeDataSize := SizeOf(TNodeRec);
  InitTreenodesize;

  PrintTemplate := TPrintTemplates.Create;
  SelectedColumn := -1;
  Self.Columns.HeaderColor := Self.color;
  Columns.Header.Background := Self.color;

end;

procedure TBaseTreeViewGUI.FormDestroy(Sender: TObject);
begin
  WriteGuiPref;
  FreeandNil(Columns);
  If Assigned(PrintTemplate) then FreeAndNil(PrintTemplate);
  inherited;
end;

procedure TBaseTreeViewGUI.FormShow(Sender: TObject);
begin
  inherited;
  pnlSearch.Color := Self.Color;
  Columns.HeaderColor := pnlSearch.Color;
  Columns.Header.Background := pnlSearch.Color;
  RefreshTree;
  TitleLabel.Caption := ReplaceStr(ReplaceStr(Self.Caption, AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel), ''), '(Press F2 for Help)', '');
  formshown:= True;
end;

function TBaseTreeViewGUI.getColumnByname(Columnname: String): String;
var
  Rec: PNodeRec;
begin
  REsult:= '';
  rec:= tree.Getnodedata(Tree.GetFirstSelected);
  if REc.Data.ByName[Columnname] <> nil then
    Result:= REc.Data.ByName[Columnname].asString;
end;
function TBaseTreeViewGUI.getFilterDateFrom: TDateTime;
begin
  Result := dateof(dtFrom.DateTime);
  if not(dtFrom.visible) then Result:= 1
end;

function TBaseTreeViewGUI.getFilterdateto: TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
  if not(dtTo.visible) then Result:= incyear(Date , 20);
end;

procedure TBaseTreeViewGUI.IterateTreeNodeCallback(Captionindex:Integer; Parentnode, aNode: PVirtualnode;DoIterateTreeNode: TDoIterateTreeNode);
var
  xNode: PVirtualnode;
begin
    IterateNodeNo:= IterateNodeNo +1;
    DoIterateTreeNode(Parentnode, anode);
    xNode :=   Tree.GetFirstChild(aNode);
    while Assigned(xNode) do begin
      IterateTreeNodeCallback(Captionindex, anode, xNode ,DoIterateTreeNode);
      DoStepProgressbar(TreenodeValue(Captionindex, aNode));
      xNode := Tree.GetNextSibling(xNode);
    end;
end;
Procedure TBaseTreeViewGUI.IterateTree(Captionindex:Integer; aNode: PVirtualnode; DoIterateTreeNode: TDoIterateTreeNode);
begin
    IterateTreeNodeCallback(Captionindex, nil, Anode , DoIterateTreeNode);
end;
Function TBaseTreeViewGUI.TreenodeValue(iindex:Integer; xNode: PVirtualnode):String;
var
  NodeData: PNodeRec;
begin
  Result := '';
  try
    NodeData := Tree.GetNodeData(xNode);
    REsult :=NodeData^.Data.CellData[iIndex].Value;
  except
    //
  end;
end;
procedure TBaseTreeViewGUI.IterateTree(Captionindex:Integer; DoIterateTreeNode: TDoIterateTreeNode);
var
  aNode: PVirtualnode;
begin
    IterateNodeNo:=0;
    aNode := tree.GetFirstChild(nil);
    Doshowprogressbar(10, WaitMsg);
    try
      while Assigned(anode) do begin
        IterateTreeNodeCallback(Captionindex, nil, Anode , DoIterateTreeNode);
        aNode := Tree.GetNextSibling(aNode);
        DoStepProgressbar(TreenodeValue(Captionindex, aNode));
      end;
    finally
      DohideProgressbar;
    end;
end;

function TBaseTreeViewGUI.GetRootNodeData: TNodeData;
var
  NodeData: PNodeRec;
begin
  try
    Result := nil;
    NodeData := Tree.GetNodeData(Tree.RootNode.FirstChild);
    if Assigned(NodeData) then Result := NodeData.Data;
  except
    on E: Exception do begin
      LogD('TframeTree.GetRootNodeData - Exception: ' + E.Message);
      raise;
    end;
  end;

end;

function TBaseTreeViewGUI.getSelectedCellData: String;
var
  rec: PNodeRec;
begin
  Result := '';
  if SelectedColumn <0 then exit;
  if Tree.RootNode = nil then exit;
  rec := Tree.GetNodeData(Tree.GetFirstSelected);
  result := rec^.Data.Celldata[SelectedColumn].Value;
end;

function TBaseTreeViewGUI.getSelectedcolumnName: String;
var
  rec: PNodeRec;
begin
  Result := '';
  if SelectedColumn <0 then exit;
  if Tree.GetFirstSelected = nil then exit;
  rec := Tree.GetNodeData(Tree.GetFirstSelected);
  result := rec^.Data.Celldata[SelectedColumn].treecolumn.columnname;
end;

procedure TBaseTreeViewGUI.Hidecolumn(const ColIndex: Integer);
begin
  Tree.Header.columns[colIndex].Options := Tree.Header.columns[colIndex].Options - [coVisible];
end;

function TBaseTreeViewGUI.BlankWhen0: boolean;
begin
  Result := chkBlankwhen0.Checked;
end;

// ---------- TTreeColumn ------------------------------------------------------

constructor TTreeColumn.Create(ColumnList: TTreeColumnList; VirtualTreeColumn: TVirtualTreeColumn);
begin
  inherited Create;
  fTreeColumn := VirtualTreeColumn;
  fColumnList := ColumnList;
end;

destructor TTreeColumn.Destroy;
begin
  inherited;
end;

procedure TTreeColumn.SetVisible(const Value: boolean);
begin
  fVisible := Value;
  if not fVisible then fTreeColumn.Width := 0;
end;

function TTreeColumn.GetColumnName: string;
begin
  Result := fColumnName;
end;

procedure TTreeColumn.SetColumnName(const Value: string);
begin
  fColumnName := Value;
  if DisplayLabel = '' then DisplayLabel := Value;
end;

function TTreeColumn.GetDisplayLabel: string;
begin
  Result := fTreeColumn.Text;
end;

procedure TTreeColumn.SetDisplayLabel(const Value: string);
begin
  fTreeColumn.Text := Value;
end;

function TTreeColumn.GetWidth: integer;
begin
  Result := fWidth;
end;
procedure TTreeColumn.SetWidth(const Value: integer);
begin
  fWidth := Value;
  if fVisible then fTreeColumn.Width := fWidth;
end;

function TTreeColumn.GetAlignment: TAlignment;
begin
  Result := fTreeColumn.Alignment;
end;

procedure TTreeColumn.SetAlignment(const Value: TAlignment);
begin
  fTreeColumn.Alignment := Value;
end;

function TTreeColumn.GetPosition: integer;
begin
  Result := self.fTreeColumn.Position;
end;

function TTreeColumn.GetIndex: integer;
begin
  Result := fColumnList.fList.IndexOf(Self);
end;

// ---------- TTreeColumnList --------------------------------------------------

constructor TTreeColumnList.Create(const TreeView: TVirtualStringTree);
begin
  inherited Create;
  fTree := TreeView;
  fList := TList.Create;
  fHeaderColor := clBtnFace;
end;

destructor TTreeColumnList.Destroy;
begin
  Clear;
  FreeandNil(fList);
  inherited;
end;

function TTreeColumnList.Add(const ColumnName: string; const FieldType: TValueType;
  const ColWidth: integer; const Align: TAlignment = taLeftJustify;displayLabel:String = ''): TTreeColumn;
begin
  Result := TTreeColumn.Create(Self, fTree.Header.Columns.Add);
  Result.Visible := true;
  Result.ColumnName := ColumnName;
  Result.FieldType := FieldType;
  Result.Width := ColWidth;
  Result.fTreeColumn.Style := vsOwnerDraw;
  if DisplayLabel <> '' then Result.DisplayLabel := DisplayLabel;

  fList.Add(Result);
  if Assigned(fOnColumnChange) then fOnColumnChange(Self);
end;

function TTreeColumnList.Count: integer;
begin
  Result := fList.Count;
end;

procedure TTreeColumnList.Delete(const index: integer);
begin
  fTree.Header.Columns.Delete(index);
  TTreeColumn(fList[index]).Free;
  fList.Delete(index);
  if Assigned(fOnColumnChange) then fOnColumnChange(Self);
end;

procedure TTreeColumnList.Clear;
begin
  while Count > 0 do Delete(0);
  if Assigned(fOnColumnChange) then fOnColumnChange(Self);
end;

function TTreeColumnList.GetColumn(const x: integer): TTreeColumn;
begin
  Result := TTreeColumn(fList[x]);
end;

function TTreeColumnList.GetHeader: TVTHeader;
begin
  Result := fTree.Header;
end;

function TTreeColumnList.GetColumnByName(ColumnName: string): TTreeColumn;
var x: integer;
begin
  result := nil;
  for x := 0 to fList.Count -1 do begin
    if SameText(ColumnName, TTreeColumn(fList[x]).ColumnName) then begin
      result := TTreeColumn(fList[x]);
      break;
    end;
  end;
end;

// --------- TTreeCellData -----------------------------------------------------

constructor TTreeCellData.Create(const Column: TTreeColumn);
begin
  inherited Create;
  fColumn := Column;
end;

destructor TTreeCellData.Destroy;
begin
  inherited;
end;

function TTreeCellData.GetAsString: string;
var
  d: double;
begin
  case fColumn.FieldType of
    vtNone:
      begin
        Result := '';
      end;
    vtString:
      begin
        Result := Value;
      end;
    vtInteger:
      begin
        Result := Value;
      end;
    vtFloat:
      begin
        Result := Value;
      end;
    vtCurrency:
      begin
        if Value = '' then Result := ''
        else begin
          d := StrToFloat(Value);
          Result := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, d);
        end;
      end;
    vtPercentage:
      begin
        if Value = '' then Result := ''
        else begin
          d := StrToFloat(Value);
          Result := FormatFloat('#0.##%', d*100);
        end;
      end;

    vtDate:
      begin
        Result := Value;
      end;
    vtBoolean:
      begin
        if Value = 'T' then Result := CheckBoxTrueValue
        else if Value = 'F' then Result := CheckBoxFalseValue
        else Result := '';
      end;
  end;
end;

function TTreeCellData.getValue: string;
begin
  Result := fValue;
end;

procedure TTreeCellData.SetAsString(const aValue: string);
begin
  Value := aValue;
end;

procedure TTreeCellData.setValue(const Value: string);
begin
  fValue := Value;
end;

// ---------- TNodeData --------------------------------------------------------

constructor TNodeData.Create(const ColumnList: TTreeColumnList);
begin
  inherited Create;
  fColumnList := ColumnList;
  fList := TList.Create;
end;

destructor TNodeData.Destroy;
begin
  while fList.Count > 0 do begin
    TTreeCellData(fList[0]).Free;
    fList.Delete(0);
  end;
  FreeandNil(fList);
  inherited;
end;

function TNodeData.getColumncount: Integer;
begin
  result:=0;
  if Assigned(fList) then REsult := fList.Count;
end;

function TNodeData.GetData(const ColumnNumber: integer): TTreeCellData;
var
  x: integer;
begin
  Result := nil;
  try
    for x := 0 to fList.Count - 1 do begin
      if TTreeCellData(fList[x]).TreeColumn.Index = ColumnNumber then begin
        Result := TTreeCellData(fList[x]);
        Break;
      end;
    end;
    if not Assigned(Result) then begin
      Result := TTreeCellData.Create(fColumnList.Column[ColumnNumber]);
      fList.Add(Result);
    end;
  Except
  //kill the exception
  end;
end;

function TNodeData.GetDataByName(const ColumnName: string): TTreeCellData;
var
  x: integer;
begin
  Result := nil;
  for x := 0 to fList.Count - 1 do begin
    if SameText(TTreeCellData(fList[x]).TreeColumn.ColumnName, ColumnName) then begin
      Result := TTreeCellData(fList[x]);
      Break;
    end;
  end;
  if not Assigned(Result) then begin
    Result := TTreeCellData.Create(fColumnList.ByName[ColumnName]);
    fList.Add(Result);
  end;
end;

// -----------------------------------------------------------------------------

procedure TBaseTreeViewGUI.DateChange(var Message: TMessage);
begin
  if not(formshown) then exit;
  RefreshTree;
end;

procedure TBaseTreeViewGUI.DoAfterContract;
begin
//
end;

procedure TBaseTreeViewGUI.DoAfterExpand;
begin
//
end;

procedure TBaseTreeViewGUI.DoColumnChange(Sender: TObject);
var
  x: integer;
begin
  if (csDestroying in ComponentState) then Exit;
  cboFilter.Clear;
  for x := 0 to Columns.Count - 1 do begin
    cboFilter.Items.AddObject(Columns[x].DisplayLabel, Columns[x]);
  end;
  if cboFilter.Items.Count > 0 then cboFilter.ItemIndex := 0;
end;


procedure TBaseTreeViewGUI.cboDateRangeCloseUp(Sender: TObject);
const
  // Date Range Combo values
  TODAY          = 0;
  YESTEDAY       = 1;
  LAST_WEEK      = 2;
  LAST_MONTH     = 3;
  LAST_QUARTER   = 4;
  LAST_12_MONTHS = 5;
  PREV_WEEK      = 6;
  PREV_MONTH     = 7;
  PREV_QUARTER   = 8;
  PREV_FINANCIAL_YEAR = 9;
  THIS_WEEK      = 10;
  THIS_MONTH     = 11;
  THIS_QUARTER   = 12;
  THIS_FINANCIAL_YEAR = 13;


  function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
  var
    iMonth: integer;
    iQuater: integer;
    iStartMonth: integer;
  begin
    iMonth := MonthOfTheYear(dtDate);
    iQuater := (iMonth - 1) div 3 + 1;
    iStartMonth := (iQuater - 1) * 3 + 1;
    Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
  end;
begin
  if ErrorOccurred then Exit;
  inherited;
  case cboDateRange.ItemIndex of
    TODAY:
      begin
        dtFrom.Date := Date;
        dtTo.Date := Date;
      end;
    YESTEDAY:
      begin
        dtFrom.Date := IncDay(Date, - 1);
        dtTo.Date := IncDay(Date, - 1);
      end;
    LAST_WEEK:
      begin
        dtFrom.Date := IncDay(Date, - 6);
        dtTo.Date := Date;
      end;
    LAST_MONTH:
      begin
        dtFrom.Date := IncDay(IncMonth(Date, - 1));
        dtTo.Date := Date;
      end;
    LAST_QUARTER:
      begin
        dtFrom.Date := IncDay(IncMonth(Date, - 3));
        dtTo.Date := Date;
      end;
    LAST_12_MONTHS:
      begin
        dtFrom.Date := IncDay(IncYear(Date, - 1));
        dtTo.Date := Date;
      end;
    PREV_WEEK:
      begin
        dtFrom.Date := IncWeek(StartOfTheWeek(Date), - 1);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;
    PREV_MONTH:
      begin
        dtFrom.Date := IncMonth(StartOfTheMonth(Date), - 1);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), - 1);
      end;
    PREV_QUARTER:
      begin
        dtFrom.Date := IncMonth(StartOfTheQuarter(Date), - 3);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), - 1);
      end;
    PREV_FINANCIAL_YEAR:
      begin
        if MonthOfTheYear(Date) <= 6 then begin
          dtFrom.Date := IncYear(IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6), - 1);
        end else begin
          dtFrom.Date := IncYear(IncMonth(StartOfTheYear(Date), 6), - 1);
        end;
        dtTo.Date := IncDay(IncYear(dtFrom.Date), - 1);
      end;
    THIS_WEEK:
      begin
        dtFrom.Date := StartOfTheWeek(Date);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;
    THIS_MONTH:
      begin
        dtFrom.Date := StartOfTheMonth(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), - 1);
      end;
    THIS_QUARTER:
      begin
        dtFrom.Date := StartOfTheQuarter(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), - 1);
      end;
    THIS_FINANCIAL_YEAR:
      begin
        if MonthOfTheYear(Date) <= 6 then begin
          dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6);
        end else begin
          dtFrom.Date := IncMonth(StartOfTheYear(Date), 6);
        end;
        dtTo.Date := IncDay(IncYear(dtFrom.Date), - 1);
      end;
  end;
  //dtFromChange(nil);
  dtToChange(nil);
end;

procedure TBaseTreeViewGUI.chkBlankwhen0Click(Sender: TObject);
begin
  inherited;
  Tree.Refresh;
end;

procedure TBaseTreeViewGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  if ChangingDate then exit;
  ChangingDate:= TRue;
  try
    if dtFrom.Date > dtto.Date then dtFrom.Date := incday(dtto.Date,-1);
    if not dtFrom.DroppedDown then begin
      if not (dtFrom.DateTime = FromPrevDate) then begin
        PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
      end;
      FromPrevDate := dtFrom.DateTime;
    end;
  finally
    ChangingDate:= False;
  end;
end;

procedure TBaseTreeViewGUI.dtFromCloseUp(Sender: TObject);
begin
  if ErrorOccurred then Exit;
  if not dtFrom.DroppedDown then begin
    if not (dtFrom.DateTime = FromPrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
    end;
    FromPrevDate := dtFrom.DateTime;
  end;
end;

procedure TBaseTreeViewGUI.dtToChange(Sender: TObject);
begin
  if ErrorOccurred then Exit;
  if ChangingDate then exit;
  ChangingDate := True;
  try
    if not dtTo.DroppedDown then begin
      if dtFrom.Date > dtto.Date then dtto.Date := incday(dtfrom.Date,1);
      if not (dtTo.DateTime = ToPrevDate) then begin
        PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
      end;
      ToPrevDate := dtTo.DateTime;
    end;
  finally
    ChangingDate:= False;
  end;
end;

procedure TBaseTreeViewGUI.dtToCloseUp(Sender: TObject);
begin
  if ErrorOccurred then Exit;
  if not dtTo.DroppedDown then begin
    if not (dtTo.DateTime = ToPrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
    end;
    ToPrevDate := dtTo.DateTime;
  end;
end;

procedure TBaseTreeViewGUI.SearchCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
var
  S, PropText: string;
  Rec: PNodeRec;
  ParentNode: PVirtualNode;
begin
  S := edtSearch.Text;
  Rec := Sender.GetNodeData(Node);
  PropText := Rec^.Data.CellData[TTreeColumn(cboFilter.Items.Objects[cboFilter.ItemIndex]).Index].AsString;
  Abort := (StrLIComp(PChar(S), PChar(PropText), Min(char_length(S), char_length(PropText))) = 0);
  if Abort then begin
    ParentNode := Node;
    while Assigned(Tree.NodeParent[ParentNode]) do begin
      Tree.Expanded[Tree.NodeParent[ParentNode]] := true;
      ParentNode := Tree.NodeParent[ParentNode];
    end;
    Tree.Selected[Node] := true;
  end;
end;

procedure TBaseTreeViewGUI.btnGoClick(Sender: TObject);
begin
  inherited;
  if (edtSearch.Text = '') or (cboFilter.ItemIndex < 0) then Exit;
  Tree.FocusedColumn := TTreeColumn(cboFilter.Items.Objects[cboFilter.ItemIndex]).Index;
  Tree.IterateSubtree(nil, SearchCallback, nil);
end;

procedure TBaseTreeViewGUI.btnRequeryClick(Sender: TObject);
begin
  inherited;
  if not(formshown) then exit;
  REfreshTree;
end;

procedure TBaseTreeViewGUI.edtSearchChange(Sender: TObject);
begin
  inherited;
  btnGo.Click;
end;

procedure TBaseTreeViewGUI.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if AppEnv.Employee.ShowPrintDialog then begin
    if PrintDialog.Execute then begin
      //SaveExpandedState;
      //ExpandContractTree(True);
      Tree.Print(Printer, true);
      //LoadExpandedState;
    end;
  end else Tree.Print(Printer, true);
end;

procedure TBaseTreeViewGUI.ContractAll;
begin
  btnExpandAll.Caption := 'Contract All';
  btnExpandAll.click;
end;

procedure TBaseTreeViewGUI.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

// called once per tree node
procedure TBaseTreeViewGUI.ExportCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
var
  line, s: string;
  Rec: PNodeRec;
  x: integer;
begin
  Rec := Sender.GetNodeData(Node);
  s := '';
  line := '';
  // build a line containing text from each column
  for x := 0 to Columns.Count - 1 do begin
    if line <> '' then line := line + ExportDelimiter;
    s := Rec^.Data.CellData[x].AsString;
    if s <> '' then s := '"' + s + '"';
    line := line + s;
  end;
  Writeln(ExportFile, line);
end;

procedure TBaseTreeViewGUI.cmdExportClick(Sender: TObject);
var
  sFileExt, s, Header: string;
  x: integer;
begin
  inherited;
  dlgSave.Title := 'Export - ' + Caption;
  if dlgSave.Execute then begin
    sFileExt := ExtractFileExt(dlgSave.FileName);
    if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
      ExportDelimiter := #9;
    end else if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
      ExportDelimiter := ',';
    end else begin
      CommonLib.MessageDlgXP_Vista('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.',
        mtWarning, [mbOK], 0);
      ExportDelimiter := #9;
    end;
    s      := '';
    Header := '';
    for x := 0 to Columns.Count - 1 do begin
      if Header <> '' then Header := Header + ExportDelimiter;
      s := Columns[x].ColumnName;
      if s <> '' then s := '"' + s + '"';
      Header := Header + s;
    end;
    AssignFile(ExportFile, dlgSave.FileName);
    try
      try
        Rewrite(ExportFile);
        Writeln(ExportFile, Header); // write out the header
        Tree.IterateSubtree(nil, ExportCallback, nil);  // Iterate through whole tree and write out data
      except
        CommonLib.MessageDlgXP_Vista('Unable to write to output file: "' + dlgSave.FileName + '"',
          mtWarning, [mbOK], 0);
      end;
    finally
      try
        CloseFile(ExportFile);
      except
      end;
    end;
  end;
end;

procedure TBaseTreeViewGUI.ExpandContractTree(Expand: boolean);
begin
  if Expand then ExpandMode := emExpandAll
  else ExpandMode           := emContractAll;

  if toAnimatedToggle in Tree.TreeOptions.AnimationOptions then begin
    Tree.TreeOptions.AnimationOptions := Tree.TreeOptions.AnimationOptions - [toAnimatedToggle]; //
    Tree.IterateSubtree(nil, ExpandAllCallback, nil);
    Tree.TreeOptions.AnimationOptions := Tree.TreeOptions.AnimationOptions + [toAnimatedToggle]; // slow expand

  end else begin
    Tree.IterateSubtree(nil, ExpandAllCallback, nil);

  end;
  if Expand then begin
    btnExpandAll.Caption := 'Contract All';
    btnExpandAll.Hint:= 'Fully collapse the tree';
    DoAfterExpand;
  end
  else begin
    btnExpandAll.Caption           := 'Expand All';
    btnExpandAll.Hint:= 'Fully expand the tree';
    DoAfterContract;
  end;
end;


procedure TBaseTreeViewGUI.ActivateGuiPrefs(const Value: boolean);
begin
  if GuiPrefs.Active <> Value then
    GuiPrefs.Active := Value;
end;

function TBaseTreeViewGUI.Addcolumn(const ColumnName: string;  const FieldType: TValueType; const ColWidth: integer;  const Align: TAlignment= taLeftJustify;displayLabel:String = ''): TTreeColumn;
begin
  result := Self.Columns.Add(dotranslate(ColumnName),FieldType,ColWidth,Align ,DisplayLabel);
end;

procedure TBaseTreeViewGUI.btnExpandAllClick(Sender: TObject);
begin
  inherited;
  if btnExpandAll.Caption = 'Expand All' then begin
    ExpandContractTree(true);
  end else begin
    ExpandContractTree(false);
  end;
end;

procedure TBaseTreeViewGUI.TreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  TreeShiftState := Shift;
end;

procedure TBaseTreeViewGUI.TreeDblClick(Sender: TObject);
begin
  inherited;
  // Default is to expand/contract on dblClick, trap this
  // event if dblClick occures (without shift key down)
  if not (ssShift in TreeShiftState) then begin
    TreeDoubleClick(Tree.GetFirstSelected, SelectedColumn);
    Abort;
  end;
end;

procedure TBaseTreeViewGUI.UnHidecolumn(const ColIndex: Integer);
begin
  Tree.Header.columns[colIndex].Options := Tree.Header.columns[colIndex].Options + [coVisible];
end;

procedure TBaseTreeViewGUI.UpdateMe;
begin
  if not(formshown) then exit;
  RefreshTree;
end;


procedure TBaseTreeViewGUI.Readguiprefs;
begin
  chkBlankwhen0.Checked :=  GuiPrefs.Node['Options.Blankwhen0'].asBoolean;
  dtTo.Date:= date;
  dtFrom.Date := Date - Appenv.Employee.ListDaysPast;
  dtTo.Date := Date + Appenv.Employee.ListDaysFuture;
end;

procedure TBaseTreeViewGUI.RefreshTree;
begin
  ActivateguiPrefs(True);
  // do nothing - this procedure needs to be overriden in child forms
end;

procedure TBaseTreeViewGUI.TreeDoubleClick(Node: PVirtualNode; Column: TColumnIndex);
begin
  // do nothing - this procedure needs to be overriden in child forms
end;

procedure TBaseTreeViewGUI.TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Rec: PNodeRec;
begin
  inherited;
  if Column < 0 then Exit;
  Rec := Tree.GetNodeData(Node);
  try
      if BlankWhen0 and (self.Columns[column].FieldType  in [vtCurrency    , vtFloat , vtInteger]) and (strValue(Rec^.Data.CellData[Column].AsString)=0) then
            CellText := ''
      else  CellText := Rec^.Data.CellData[Column].AsString;
  Except
    if devmode then
      MessageDlgXP_vista(inttostr(column) +':' +Rec^.Data.CellData[Column].AsString, mtWarning, [mbOK], 0);
  end;
end;

procedure TBaseTreeViewGUI.ExpandAll;
begin
  btnExpandAll.Caption := 'Expand All';
  btnExpandAll.Click;

end;

procedure TBaseTreeViewGUI.ExpandAllCallback(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: boolean);
var
  Rec: PNodeRec;
begin
  case ExpandMode of
    emExpandAll:
      begin
        Tree.Expanded[Node] := true;
      end;
    emContractAll:
      begin
        Tree.Expanded[Node] := false;
      end;
    emExpandLoad:
      begin
        Rec := Tree.GetNodeData(Node);
        if AppContext[Self.ClassName + '_Expanded'].VarExists(Rec^.Data.KeyStr) then Tree.Expanded[Node] := true
        else Tree.Expanded[Node] := false;
      end;
    emExpandSave:
      begin
        Rec := Tree.GetNodeData(Node);
        if Tree.Expanded[Node] then AppContext[Self.ClassName + '_Expanded'].BoolVar[Rec^.Data.KeyStr] := true;
      end;
  end;
end;

procedure TBaseTreeViewGUI.SaveExpandedState;
begin
  ExpandMode := emExpandSave;
  AppContext.DeleteContext(Self.ClassName + '_Expanded'); // delete list of expanded nodes
  Tree.IterateSubtree(nil, ExpandAllCallback, nil);
  AppContext[Self.ClassName].IntVar['TreeOffsetX'] := Tree.OffsetX;
  AppContext[Self.ClassName].IntVar['TreeOffsetY'] := Tree.OffsetY;
end;

procedure TBaseTreeViewGUI.LoadExpandedState;
begin
  ExpandMode := emExpandLoad;
  if toAnimatedToggle in Tree.TreeOptions.AnimationOptions then begin
    Tree.TreeOptions.AnimationOptions := Tree.TreeOptions.AnimationOptions - [toAnimatedToggle]; //
    Tree.IterateSubtree(nil, ExpandAllCallback, nil);
    Tree.TreeOptions.AnimationOptions := Tree.TreeOptions.AnimationOptions + [toAnimatedToggle]; // slow expand
  end else begin
    Tree.IterateSubtree(nil, ExpandAllCallback, nil);
  end;
  Tree.OffsetX := AppContext[Self.ClassName].IntVar['TreeOffsetX'];
  Tree.OffsetY := AppContext[Self.ClassName].IntVar['TreeOffsetY'];
end;

procedure TBaseTreeViewGUI.TreeAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
  const Elements: THeaderPaintElements);
begin
  if (csDestroying in ComponentState) then Exit;
  inherited;
  with PaintInfo do begin
    // First check the column member. If it is NoColumn then it's about the header background.
    if Column <> nil then begin
      if hpeBackground in Elements then begin
        TargetCanvas.Brush.Color := Columns.HeaderColor;
        TargetCanvas.FillRect(PaintRectangle);
        TargetCanvas.Pen.Width := 1;
        TargetCanvas.Rectangle(PaintRectangle);
      end;
    end
  end;
end;

procedure TBaseTreeViewGUI.TreeHeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
  var Elements: THeaderPaintElements);
begin
  inherited;
  with PaintInfo do begin
    // First check the column member. If it is NoColumn then it's about the header background.
    if Column <> nil then Elements := [hpeBackground] // No other flag is recognized for the header background.
  end;
end;

procedure TBaseTreeViewGUI.TreeColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
begin
  inherited;
  SelectedColumn := Column;
end;
procedure TBaseTreeViewGUI.PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer);
begin
  if (ReportName ='') or (not ValidReport(Trim(ReportName), SQLPortion)) then
    Exit;
  PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
  PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, CommonDbLib.GetSharedMyDacConnection);
end;
function TBaseTreeViewGUI.ValidReport(const ReportName, SQLPortion: string): boolean;
var
  Qry: TERPQuery;
begin
  Result := true;
  Qry := TERPQuery.Create(nil);
  Qry.Options.FlatBuffers := True;
  try
    with Qry do begin
      Connection := commonDbLib.GetSharedMyDacConnection;
      SQL.Add('Select * from tblTemplates where TemplName = ' + QuotedStr(Trim(ReportName)));
      SQL.Add(' OR TemplateClass = ' + QuotedStr(Trim(ReportName)));
      Open;
      if FieldByName('Report').AsString = '' then begin
        Result := false;
        CommonLib.MessageDlgXP_Vista('The template is not created for this report.' + Chr(13) + 'Create the template before printing / previewing' + Chr(13) + 'Report Name: ' + ReportName, mtWarning, [mbOK], 0);
        Exit;
      end;
      if SQLPortion = '' then
        if FieldByName('SQLString').AsString = '' then begin
          Result := false;
          CommonLib.MessageDlgXP_Vista('SQL for the report should not be blank.' + Chr(13) + 'Report Name: ' + ReportName, mtWarning, [mbOK], 0);
          Exit;
        end;
    end;
  finally
    if Assigned(Qry) then begin
      if qry.Active then
        Qry.Close;
      FreeAndNil(Qry);
    end;
  end;
end;


procedure TBaseTreeViewGUI.WriteGuiPref;
begin
  //d escendants will override;
end;

procedure TBaseTreeViewGUI.WriteGuiPrefs;
begin
  GuiPrefs.Node['Options.Blankwhen0'].asBoolean := chkBlankwhen0.Checked;
end;

{ TVTFrameEditControl }

function TVTFrameEditControl.BeginEdit: Boolean;
begin
  try
    Result := not FStopping;
    if not result then exit;

    Result := DoBeginEdit;
    if not result then exit;

    if Result then begin
      case ControlType of
        ectEdit: begin
            FEdit.Show;
            FEdit.Width := TVirtualStringTree(ftree).Header.Columns[FColumn].width-2;
            if AccessLevel <=3 then begin
              FEdit.Enabled := True;
              FEdit.SelectAll;
              SetControlFocus(FEdit);
            end else FEdit.Enabled := False;
          end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTFrameEditControl.BeginEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTFrameEditControl.CancelEdit: Boolean;
begin
  result := DoCancelEdit;
end;

function TVTFrameEditControl.EndEdit: Boolean;
begin
  try
    Result := not FStopping;

    if Result then begin
      try
        FStopping := True;

        case ControlType of
          ectEdit: begin
              FTree.Text[FNode, FColumn] := FEdit.Text;
              FEdit.Hide;
            end;
        end;
      finally FStopping := False;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoEndEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTFrameEditControl.GetBounds: TRect;
begin
  result := DoGetBounds;
end;

function TVTFrameEditControl.getEditcontrol(aColumn: TColumnIndex): TEditControlType;
begin
  REsult := ectNone;
end;

procedure TVTFrameEditControl.HandleComboBoxCloseUp(Sender: TObject);
begin
  inherited;

end;

function TVTFrameEditControl.PrepareEdit(Tree: TBaseVirtualTree;Node: PVirtualNode; Column: TColumnIndex): Boolean;
begin
  Result := DoPrepareEdit(Tree, Node, Column);
  if not result then exit;
  ControlType := Editcontrol[fColumn];
  case ControlType of
        ectEdit : begin
        end;
  end;
end;

procedure TVTFrameEditControl.ProcessMessage(var message: TMessage);
begin
  DoProcessMessage(Message);
end;

procedure TVTFrameEditControl.SetBounds(R: TRect);
begin
  DoSetBounds(R);
end;

end.
