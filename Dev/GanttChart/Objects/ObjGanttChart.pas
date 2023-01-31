unit ObjGanttChart;

interface

uses Classes ,  wgsGanttEntities, wgsController, wgsGanttGraph, wgsDataSource, wgsCalendar,Graphics, db, wgsGanttBar , Contnrs,
     wgsDocumentCalendar , wgsVisualGoodie , wgsTreeRow , wgsTreeHeaderCell;

const
    BarMoveCancelled    = 'BarMoveCancelled';
    BarResizeCancelled  = 'BarResizeCancelled';
    BarDeleteCancelled  = 'BarDeleteCancelled';
    BarRescheduled      = 'BarRescheduled';

type

  TRefreshChartEvent = function (FieldName:String) :String of Object ;

  TGridColumns = record
    ColName: String;
    ColWidth: Integer;
    FieldName:String;
  end;

  TWGSMonday = class (TWGSWeekend)
  Public
    function Matches(Date : TDateTime; TM : TWGSTimeMode = tmNone):Boolean;override;
  end;
  TWGSTuesday = class (TWGSWeekend)
  Public
    function Matches(Date : TDateTime; TM : TWGSTimeMode = tmNone):Boolean;override;
  end;
  TWGSWednesday = class (TWGSWeekend)
  Public
    function Matches(Date : TDateTime; TM : TWGSTimeMode = tmNone):Boolean;override;
  end;
  TWGSThursday = class (TWGSWeekend)
  Public
    function Matches(Date : TDateTime; TM : TWGSTimeMode = tmNone):Boolean;override;
  end;
  TWGSFriday = class (TWGSWeekend)
  Public
    function Matches(Date : TDateTime; TM : TWGSTimeMode = tmNone):Boolean;override;
  end;

  TGanttBar = class(TObject)
  Private
    fBar            : TWGSGanttBar;
    fiProcessTimeId : Integer;
    fdTimeStart     : TdateTime;
    fdTimeEnd       : TDateTime;
    fiRowno         : Integer;
    fiProcTreeId    : Integer;
    fiProcessPartId : Integer;
  Public
    Constructor Create;
    destructor Destroy; override;
    Property ProcessTimeId:Integer      read fiProcessTimeId  write fiProcessTimeId;
    Property ProcessPartId:Integer      read fiProcessPartId  write fiProcessPartId;
    Property Bar          :TWGSGanttBar read fBar             write fBar;
    Property TimeStart    :TdateTime    read fdTimeStart      write fdTimeStart;
    Property TimeEnd      :TDateTime    read fdTimeEnd        write fdTimeEnd;
    Property Rowno        :Integer      read fiRowno          write fiRowno;
    Property ProcTreeId   :Integer      read fiProcTreeId     write fiProcTreeId;
  end;

  TBarConType = (tbctFF=0,tbctFS=1,tbctSF=2,tbctSS=3);

  TListObject =  class(TObject)
  Private
    function GetCount: integer;
    function GetItem(const index: integer): TObject;
  Protected
    fList: TObjectList;
  Public
    Constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TObject read GetItem; default;
    procedure Clear; virtual;
    procedure Reset; virtual;
    procedure Delete(const index: integer);virtual;
    procedure Add(const aItem: TObject);
  end;
  TGanttBarList = Class(TListObject)
    Private
      function GetItemByProcessTimeId(const ProcessTimeId: integer): TGanttBar;
      function getItembyBar(const bar: TWGSGanttBar): TGanttBar;
    protected
    Public
      procedure Add(const aItem: TGanttBar); Reintroduce;
      property ItemByProcessTimeId[const ProcessTimeId: integer]: TGanttBar read GetItemByProcessTimeId;
      Property ItembyBar[const  bar :TWGSGanttBar ]:TGanttBar read getItembyBar;
  End;

  TGanttChartEvent = procedure (const Sender: TObject; const  Value , Msg: string) of object;
  TGanttchartColumn = class(TObject)
    Private
      fsValue: string;
      fsColumnName: String;
      function GetAsBoolean: Boolean;
      function GetAsDateTime: TDateTime;
      function GetAsFloat: Double;
      function GetAsInteger: Integer;
      function GetAsString: string;
    Public
      Property Value        : string    read fsValue      write fsValue;
      Property ColumnName   : String    read fsColumnName write fsColumnName;
      property AsBoolean    : Boolean   read GetAsBoolean;
      property AsDateTime   : TDateTime read GetAsDateTime;
      property AsFloat      : Double    read GetAsFloat;
      property AsInteger    : Integer   read GetAsInteger;
      property AsString     : string    read GetAsString;
  end;
  TGanttChart = class;

  TGanttchartrow = class(TComponent)
    Private
      fRow : TWGSTreeRow;
      fGanttchartColumn : TGanttchartColumn;
      function getColumnByname(Columnname: String): TGanttchartColumn;
      function GanttChart :TGanttChart;
    function getRowIndex: Integer;
    Protected

    Public
      Constructor Create(AOwner :TComponent); Overload;Override;
      Destructor Destroy; override;
      Property Row :TWGSTreeRow read fRow write   fRow;
      Property ColumnByname[Columnname:String]:TGanttchartColumn read getColumnByname;
      Property RowIndex :Integer read getRowIndex;
  end;
  TGanttChart = class(TComponent)
    Private
      fDatasource             : TWGSDataSource;
      fGanttGraph             : TWGSGanttGraph;
      fTimeMode               : TWGSTimeMode;
      GridColumns             : Array of TGridColumns;
      Scales                  : Array of TWGSTimeMode;
      fMasterDs               : TDataset;
      fTRefreshChartEvent     : TRefreshChartEvent;
      fsDateFromfield         : String;
      fsDatetofield           : String;
      fDetailsDs              : TDataset;
      fsGroupingfield         : String;
      fScalecolor             : TColor;
      fHourTimeFormat         : TWGSTimeFormat;
      fQuarterTimeFormat      : TWGSTimeFormat;
      fyearTimeFormat         : TWGSTimeFormat;
      fdecadeTimeFormat       : TWGSTimeFormat;
      fDayTimeFormat          : TWGSTimeFormat;
      fMonthTimeFormat        : TWGSTimeFormat;
      fWeekTimeFormat         : TWGSTimeFormat;
      fOnBarResize            : TWGSBarResizeEvent;
      fOnGanttBarMove         : TWGSGanttBarMoveEvent;
      fOnAfterBarResize       : TWGSAfterBarOperationEvent;
      fOnAfterBarAdd          : TWGSAfterBarOperationEvent;
      fOnBeforeBarMove        : TWGSBeforeBarOperationEvent;
      fOnBeforeBarDelete      : TWGSBeforeBarOperationEvent;
      fOnBeforeBarResize      : TWGSBeforeBarOperationEvent;
      fOnAfterBarMove         : TWGSAfterBarOperationEvent;
      fonAfterBarMoveDetailed : TWGSAfterBarMoveOperationEvent;
      fonTreeColumnMove       : TWGSTreeColumnMoveOperation;
      fOnBeforeBarAdd         : TWGSBeforeBarOperationEvent;
      fOnAfterBarDelete       : TWGSAfterBarOperationEvent;
      fbAllowToMoveBar        : Boolean;
      fGanttChartEvent        : TGanttChartEvent;
      clearingRows            : Boolean;
      fGanttchartrow          : TGanttchartrow;
      function getGridColor   : TColor;
      function getBaseColor   : TColor;
      function getGridLineColor   : Tcolor;
      function getBackGroundcolor : TColor;
      function getColor           : Tcolor;
      function getgroupColor      : Tcolor;
      function getFocusedRowColor : Tcolor;
      function getRowcount        : Integer;
      function getdefaultRowheight: Integer;
      (*function ValidtoRefresh     : Boolean;*)
      function GetColumnWidth     (Index: Integer): Integer;
      Function GetDisplayLabel    (Index: Integer):String;
      Function ColIndex           (const ColName:String):Integer;
      function getCellData        (ColName: String; Row: Integer): String;

      procedure setGridLineColor      (const Value: Tcolor);
      procedure setTimeMode           (const Value: TWGSTimeMode);
      procedure SetGridColor          (const Value: TColor);
      procedure setBaseColor          (const Value: TColor);
      procedure SetBackGroundcolor    (const Value: TColor);
      procedure SetColor              (const Value:Tcolor);
      procedure SetgroupColor         (const Value:Tcolor);
      procedure SetFocusedRowColor    (const Value:Tcolor);
      procedure setdefaultRowheight   (const Value: Integer);
      procedure setcolumnWidth        (Index: Integer; const Value: Integer);
      Procedure SetDisplayLabel       (Index:Integer; const Value:STring);
      procedure Restorecolumn         (Index: Integer);(*Overload;*)
      (*procedure Restorecolumn         (ColName:String);Overload;*)
      procedure SetCellData           (ColName: String; Row: Integer;Value:String);
      function DateFrom: TDateTime;
      function DateTo: TDateTime;
      procedure SetGanttGraph(const Value: TWGSGanttGraph);
      procedure SetDatasource(const Value: TWGSDataSource);
      function getBarcount: Integer;
      procedure setScalecolor(const Value: TColor);
      function FormatDateToDisplay(date: TDateTime; TimeFormat: TWGSTimeFormat): String;
      function ScaleDefaultTimeFormat(TimeMode: TWGSTimeMode): TWGSTimeFormat;
      procedure InitScales;
      function getGraphColumnWidth: Integer;
      procedure setGraphColumnWidth(const Value: Integer);
      function getStringTimeMode: String;
      function GanttChartDrawStyle: TWGSDrawStyles;



    Protected
      InsertedbarIndex    : Integer;
      DateFromBeforechange, (*DateToBeforechanging, *)DateFromAfterchange(*, DateToAfterchange*):TDatetime;
      ProcTreeIDofBarChanging :Integer;

      Procedure DoOnBarResize           (Bar : TWGSGanttBar; changeX : Real; changeY : Integer; Right : Boolean; var Allowed : Boolean) ;Virtual;
      Procedure DoOnGanttBarMove        (Bar : TWGSGanttBar; NewRow : Integer; NewStartDate : TDateTime; var Allowed : Boolean);Virtual;
      Procedure DoOnAfterBarResize      (Bar : TWGSGanttBar) ;Virtual;
      Procedure DoOnAfterBarAdd         (Bar : TWGSGanttBar) ;Virtual;
      Procedure DoOnAfterBarMove        (Bar : TWGSGanttBar) ;Virtual;
      Procedure DoOnAfterBarMoveDetailed(Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;Virtual;
      Procedure DoOnTreeColumnMove      (column:TWGSTreeHeaderCell;width : integer)   ; virtual;
      Procedure DoOnAfterBarDelete      (Bar : TWGSGanttBar) ;Virtual;
      Procedure DoOnBeforeBarMove       (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
      Procedure DoOnBeforeBarDelete     (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
      Procedure DoOnBeforeBarResize     (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
      Procedure DoOnBeforeBarAdd        (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
      Function BarConTypeToInteger(Const Value:TBarConType):Integer;
      procedure OnBarBeforeChange(Bar: TWGSGanttBar);
      procedure OnBarAfterChange(Bar: TWGSGanttBar);
      Procedure SendEvent(const Value, Msg: string);
    Public
      GanttBars                : TGanttBarList;
      Constructor Create(AOwner :TComponent; foGanttGraph :TWGSGanttGraph; foDatasource:TWGSDataSource;foMasterDs:TDataset;foRefreshChartEvent:TRefreshChartEvent); reintroduce;Overload;
      Constructor Create(AOwner :TComponent); Overload;Override;
      Destructor Destroy; override;
      procedure AddFixedcol(Fieldname:string;ColName: String;colwidth:Integer=80);
      Function Addrow(Row:Integer =0) :Integer;Overload;
      Function Addrow(Data:Array of String; timeFrom , TimeTo :TDatetime; Row:Integer =0):Integer;Overload;
      Function MakeBar(timeFrom , TimeTo :TDatetime; Row:Integer =0):Integer; virtual;
      Procedure InsertScale(Value:TWGSTimeMode);
      function ScaleInserted(Value: TWGSTimeMode): Integer;
      Procedure Hidecolumn(const ColName:String);Overload;
      Procedure Hidecolumn(const Index:Integer);Overload;
      Procedure Showcolumn(const ColName:String);Overload;
      Procedure Showcolumn(const Index:Integer);Overload;
      Procedure ClearBars;
      Procedure ClearConnections;
      procedure ClearGraph;virtual;
      procedure RefreshChart;
      Procedure RefreshTree(Dtfrom , dtTo :TDateTime);Virtual;
      procedure Repaint;
      procedure SetDefaultcolumnwidth;
      function focusedRow:TGanttchartrow;


      Property GanttGraph       :TWGSGanttGraph     read fGanttGraph          write SetGanttGraph;
      Property Datasource       :TWGSDataSource     read fDatasource          write SetDatasource;
      Property MasterDs         :TDataset           read fMasterDs            Write fMasterDs;
      Property DetailsDs        :TDataset           read fDetailsDs           Write fDetailsDs;
      Property DateFromfield    :String             read fsDateFromfield      write fsDateFromfield;
      Property Datetofield      :String             read fsDatetofield        write fsDatetofield;
      Property RefreshChartEvent:TRefreshChartEvent Read fTRefreshChartEvent  write fTRefreshChartEvent;
      Property TimeMode         :TWGSTimeMode       read fTimeMode            write setTimeMode;
      Property BackGroundcolor  :TColor             read getBackGroundcolor   write SetBackGroundcolor;
      Property GridColor        :TColor             read getGridColor         write SetGridColor;
      Property BaseColor        :TColor             read getBaseColor         write setBaseColor;
      Property GridLineColor    :Tcolor             read getGridLineColor     write setGridLineColor;
      Property Color            :Tcolor             read getColor             Write setColor;
      Property groupColor       :Tcolor             read getgroupColor        Write setgroupColor;
      Property FocusedRowColor  :Tcolor             read getFocusedRowColor   Write setFocusedRowColor;
      Property Scalecolor       :TColor             read fScalecolor          write setScalecolor;
      Property rowcount         :Integer            read getRowcount;
      Property Groupingfield    :String             read fsGroupingfield      write fsGroupingfield;
      Property DefaultRowheight :Integer            read getdefaultRowheight  Write setdefaultRowheight;
      Property AllowToMoveBar   :Boolean            read fbAllowToMoveBar     write fbAllowToMoveBar;
      property ColumnWidth[Index:Integer] : Integer read GetColumnWidth       write setcolumnWidth;
      property DisplayLabel[Index:Integer]: String  read GetDisplayLabel      write setDisplayLabel;
      Property CellData[ColName: String; Row: Integer] :String read getCellData write setCellData;
      Property Barcount         :Integer            read getBarcount;
      Property HourTimeFormat   :TWGSTimeFormat     read fHourTimeFormat      write fHourTimeFormat;
      Property DayTimeFormat    :TWGSTimeFormat     read fDayTimeFormat       write fDayTimeFormat;
      Property WeekTimeFormat   :TWGSTimeFormat     read fWeekTimeFormat      write fWeekTimeFormat;
      Property MonthTimeFormat  :TWGSTimeFormat     read fMonthTimeFormat     write fMonthTimeFormat;
      Property QuarterTimeFormat:TWGSTimeFormat     read fQuarterTimeFormat   write fQuarterTimeFormat;
      Property yearTimeFormat   :TWGSTimeFormat     read fyearTimeFormat      write fyearTimeFormat;
      Property decadeTimeFormat :TWGSTimeFormat     read fdecadeTimeFormat    write fdecadeTimeFormat;
      Property GraphColumnWidth :Integer            read getGraphColumnWidth  Write setGraphColumnWidth;
      Property StringTimeMode   :String             read getStringTimeMode;
      Property OnBarResize      :TWGSBarResizeEvent           read fOnBarResize       Write fOnBarResize ;
      Property OnBeforeBarAdd   :TWGSBeforeBarOperationEvent  read fOnBeforeBarAdd    Write fOnBeforeBarAdd ;
      Property OnBeforeBarResize:TWGSBeforeBarOperationEvent  read fOnBeforeBarResize Write fOnBeforeBarResize ;
      Property OnBeforeBarMove  :TWGSBeforeBarOperationEvent  read fOnBeforeBarMove   Write fOnBeforeBarMove ;
      Property OnBeforeBarDelete:TWGSBeforeBarOperationEvent  read fOnBeforeBarDelete Write fOnBeforeBarDelete ;
      Property OnAfterBarDelete :TWGSAfterBarOperationEvent   read fOnAfterBarDelete  Write fOnAfterBarDelete ;
      Property OnAfterBarAdd    :TWGSAfterBarOperationEvent   read fOnAfterBarAdd     Write fOnAfterBarAdd ;
      Property OnAfterBarMove   :TWGSAfterBarOperationEvent   read fOnAfterBarMove    Write fOnAfterBarMove ;
      Property OnAfterBarMoveDetailed :TWGSAfterBarMoveOperationEvent read fOnAfterBarMoveDetailed write fOnAfterBarMoveDetailed;
      Property OnTreeColumnMove :TWGSTreeColumnMoveOperation  read fOnTreeColumnMove  write fOnTreeColumnMove;
      Property OnAfterBarResize :TWGSAfterBarOperationEvent   read fOnAfterBarResize  Write fOnAfterBarResize ;
      Property OnGanttBarMove   :TWGSGanttBarMoveEvent        read fOnGanttBarMove    Write fOnGanttBarMove ;
      Property GanttChartEvent  :TGanttChartEvent             read fGanttChartEvent   Write fGanttChartEvent;

  end;

implementation

uses ERPdbComponents, wgsTreeSimpleTextCell , wgsTaskBar , wgsTimeScale, sysutils,
  CommonDbLib, dateutils, AppEnvironment  , variants;

{ TGanttChart }

constructor TGanttChart.Create(AOwner: TComponent);
begin
  clearingRows:= false;
  fGanttChartEvent := nil;
  InsertedbarIndex := -1;
  AllowToMoveBar := True;
  inherited Create(AOwner);
  GanttGraph        := nil;
  Datasource        := nil;
  MasterDs          := nil;
  DetailsDs         := nil;
  RefreshChartEvent := nil;
  DateFromfield     := '';
  Datetofield       := '';
  fsGroupingfield   := '';
  SetLength(GridColumns , 0);
  GanttBars:= TGanttBarList.Create;
  fGanttchartrow := nil;
  initScales;

end;
Procedure TGanttChart.InitScales;
begin
  SetLength(Scales , 0);
  fHourTimeFormat   := tmfHourAMPM;;
  fQuarterTimeFormat:= tmfDateshort;
  fyearTimeFormat   := tmfWeeknMonth;
  fdecadeTimeFormat := tmfMonthMedium;
  fDayTimeFormat    := tmfQuarterShort;
  fMonthTimeFormat  := tmfYearFull;
  fWeekTimeFormat   := tmfDecade;
end;

function TGanttChart.ScaleDefaultTimeFormat(TimeMode : TWGSTimeMode) : TWGSTimeFormat;
begin
  case TimeMode of
    tmHour    : Result := fHourTimeFormat;
    tmDay     : Result := fQuarterTimeFormat;
    tmWeek    : Result := fyearTimeFormat;
    tmMonth   : Result := fdecadeTimeFormat;
    tmQuarter : Result := fDayTimeFormat;
    tmYear    : Result := fMonthTimeFormat;
    tmDecade  : Result := fWeekTimeFormat;
  else
    Result := tmfNone;
  end
end;
Procedure TGanttChart.ClearGraph;
var
  ctr:Integer;
begin
  if clearingRows then exit;

  if rowcount = 0 then exit;

  clearingRows:= True;
  try
    for ctr :=  rowcount-1 downto 0 do
      try
        DataSource.RowClear(ctr);
        DataSource.RowDelete(ctr);
      Except
        //
      end;
  finally
    clearingRows:= false;
  end;
end;
Function TGanttChart.Addrow(Row:Integer =0):Integer;
begin
  REsult := -1;
  if (Row<>0) and (rowcount>Row) then
    Result := Row
  else if DataSource.RowAppend then
    Result := RowCount-1;
end;
function TGanttChart.MakeBar(timeFrom, TimeTo: TDatetime; Row:Integer =0): Integer;
begin
  Result := AddRow(Row) ;
  if Result <0 then exit;
  if (Timefrom =0) and  (Timeto=0) then exit;
  Datasource.BarAdd(TWGSTaskBar.Create(timeFrom,TimeTo ,Result), Result);
end;
Function TGanttChart.Addrow(Data:Array of String; timeFrom , TimeTo :TDatetime; Row:Integer =0):Integer;
var
  ctr:Integer;
begin
  Result := MakeBar(timeFrom, timeto , Row);
  if Result <0 then exit;
  for ctr:= low(Data) to high(Data) do Datasource.Tree.rows[Result].cells[ctr+1].Text :=  Data[ctr];
end;
function TGanttChart.BarConTypeToInteger(const Value: TBarConType): Integer;
begin
  REsult :=3;
       if Value = tbctFF then result := 0
  else if Value = tbctFS then result := 1
  else if Value = tbctSF then result := 2
  else if Value = tbctSS then result := 3;
end;

Procedure TGanttChart.SetCellData(ColName:String;Row:Integer;Value:String);
var
  ctr:Integer;
begin
  ctr:= colIndex(ColName);
  if ctr <0 then exit;
  Datasource.Tree.rows[Row].cells[ctr].Text :=Value;
end;


procedure TGanttChart.ClearBars;
var
  ctr:Integer;
begin

  if Rowcount<1 then exit;
  ClearConnections;
  for ctr:= GanttBars.Count-1 downto 0 do
    if GanttBars.Item[ctr] is TGanttBar then
      Datasource.BarDelete(TWGSGanttBar(TGanttBar(GanttBars[0]).bar));
  Repaint;
end;

procedure TGanttChart.ClearConnections;
var
  ctr:Integer;
begin
  if fGanttGraph.document.countConnections =0 then exit;
  for ctr := fGanttGraph.document.countConnections-1 downto 0 do
    Datasource.ConnectionDelete(fGanttGraph.document.connection[0]);
end;

function TGanttChart.ColIndex(const ColName: String): Integer;
var
  ctr:Integer;
begin
  Result := -1;
  if GanttGraph.tree.header.cellsCount <1 then exit;
  For ctr := 0 to GanttGraph.tree.header.cellsCount-1 do
    if sameText(ColName ,   Datasource.Tree.header.cells[ctr].Title) then begin
      Result := ctr;
      break;
    end;
end;

constructor TGanttChart.Create(AOwner:TComponent; foGanttGraph :TWGSGanttGraph; foDatasource:TWGSDataSource;foMasterDs:TDataset;foRefreshChartEvent:TRefreshChartEvent);
begin
  Create(AOwner);
  GanttGraph        := foGanttGraph;
  Datasource        := foDatasource;
  RefreshChartEvent := foRefreshChartEvent;
  MasterDs          := foMasterDs;
end;
(*Function TGanttChart.ValidtoRefresh:Boolean;
var
  ctr:Integer;
begin
  Result := False;
  if not(Assigned(MasterDs))  then exit;
  if (Datetofield='')         then exit;
  if (DateFromfield='')       then exit;
  if (Length(Gridcolumns)=0)  then exit;
  if Assigned(DetailsDs) then begin
    if  (DetailsDs.FindField(DateFromfield) = nil) then exit
  end else if MasterDs.FindField(DateFromfield) = nil then exit;

  if Assigned(DetailsDs) then begin
    if (DetailsDs.FindField(Datetofield) = nil) then exit
  end else if MasterDs.FindField(Datetofield) = nil then exit;

  for ctr := low(Gridcolumns) to high(Gridcolumns) do
    if Gridcolumns[ctr].FieldName <> '' then
      if MasterDs.FindField(Gridcolumns[ctr].FieldName) = nil then exit;
  REsult := True;
end;*)

Function TGanttChart.DateFrom :TDateTime;
begin
  REsult :=0;
  if Datetofield = '' then exit;
  if Assigned(DetailsDs) and (DetailsDs.FindField(DateFromfield) <> nil) then REsult :=DetailsDs.FindField(DateFromfield).asDatetime
  else if MasterDs.FindField(DateFromfield) <> nil then REsult :=MasterDs.FindField(DateFromfield).asDatetime
end;
Function TGanttChart.DateTo :TDateTime;
begin
  REsult :=0;
  if Datetofield = '' then exit;
  if Assigned(DetailsDs) and (DetailsDs.FindField(DateTofield) <> nil) then REsult :=DetailsDs.FindField(DateTofield).asDatetime
  else if MasterDs.FindField(DateTofield) <> nil then REsult :=MasterDs.FindField(DateTofield).asDatetime
end;
destructor TGanttChart.Destroy;
begin
  Freeandnil(GanttBars);
  Freeandnil(fGanttchartrow);
  inherited;
end;

procedure TGanttChart.RefreshChart;
var
  ctr:Integer;
  s:String;
  GroupingfieldData:String;
  GroupingfieldIndex:Integer;


  Procedure MakeGroup;
  begin
    if Groupingfield = '' then exit;
    if MasterDs.FindField(Groupingfield) = nil then exit;
    if GroupingfieldData <> MasterDs.FindField(Groupingfield).AsString then begin
      DataSource.RowsGroup(GroupingfieldIndex,Rowcount-1);
      GroupingfieldIndex:= Rowcount;
      GroupingfieldData := MasterDs.FindField(Groupingfield).AsString;
    end;
  end;

begin
  GroupingfieldData := MasterDs.FindField(Groupingfield).AsString;
  GroupingfieldIndex:= 0;
  try
    ClearGraph;
    openDb(MasterDs);
    if MasterDs.recordcount = 0 then exit;

    MasterDs.First;
    While MasterDs.Eof = False do begin
      MakeGroup;
      Addrow(Rowcount);
      for ctr := Low(Gridcolumns) to High(Gridcolumns) do begin
        if Gridcolumns[ctr].FieldName <> '' then begin
          s:= '';
          if Assigned(RefreshChartEvent) then s:= RefreshChartEvent(Gridcolumns[ctr].FieldName);
          if s = '' then s :=MasterDs.FieldByName(Gridcolumns[ctr].FieldName).AsString;
          CellData[Gridcolumns[ctr].ColName , Rowcount-1] :=s;
        end;
      end;

      if Assigned(DetailsDs) then begin
        if  (detailsDs.RecordCount>0) then begin
          DetailsDs.First;
          While DetailsDs.Eof = False do begin
            MakeBar(DateFrom, Dateto , Rowcount-1);
            DetailsDs.Next;
          end;
        end;
      end else begin
        MakeBar(DateFrom, Dateto , Rowcount-1);
      end;

      MasterDs.Next;
      end;
  finally
    rePaint;
  end;
end;

procedure TGanttChart.RefreshTree(Dtfrom , dtTo :TDateTime);
begin

end;

procedure TGanttChart.Repaint;
begin
  GanttGraph.Repaint;
end;

procedure TGanttChart.AddFixedcol(Fieldname:string;ColName:String;colwidth:Integer=80);
var
  i:Integer;
begin
 i := colIndex(ColName);
 if i>0 then exit;
 Datasource.ColumnAppend(TWGSTreeSimpleTextCellType.Create);
 i:=Datasource.Tree.header.cellsCount-1;
 DisplayLabel[i] := ColName;
 columnwidth[i]  := ColWidth;
 SetLength(gridcolumns , Length(Gridcolumns)+1);
 gridcolumns[high(gridcolumns)].ColName     := ColName;
 gridcolumns[high(gridcolumns)].ColWidth  := ColWidth;
 gridcolumns[high(gridcolumns)].fieldName := FieldName;

 Repaint;
end;

function TGanttChart.getCellData(ColName: String; Row: Integer): String;
var
  ctr:Integer;
begin
  REsult := '';
  ctr:= colIndex(ColName);
  if ctr <0 then exit;
  if (row<0) or (Row<Rowcount-1) then exit;
  REsult := Datasource.Tree.rows[Row].cells[ctr].Text;
end;
procedure TGanttChart.Hidecolumn(const Index: Integer);
begin
  if index<0 then exit;
  if index> GanttGraph.tree.header.cellsCount-1 then exit;
  Datasource.ColumnDelete(index);
  //ColumnWidth[index] :=0;
end;

function TGanttChart.ScaleInserted(Value: TWGSTimeMode) : Integer ;
var
  ctr:Integer;
begin
  Result := -1;
  if GanttGraph.document.Scalescount =0 then exit;
  if (length(Scales) =0) and (GanttGraph.document.Scalescount = 1) then begin
    SetLength(Scales,1);
    SCales[0] := Value;
    REsult :=0;
    Exit;
  end;
  for ctr:= 0 to GanttGraph.document.Scalescount-1 do
    if GanttGraph.document.Scales[ctr].TimeMode = Value then begin
      Result := ctr;
      break;
    end;

end;
procedure TGanttChart.InsertScale(Value: TWGSTimeMode);
var
  i:Integer;
begin
  i:= ScaleInserted(Value);
  if i<0  then begin
    GanttGraph.document.InsertScale(0,TWGSTimeScale.Create(Value,GanttGraph.document));
    SetLength(Scales,GanttGraph.document.Scalescount);
    i :=GanttGraph.document.Scalescount-1;
    SCales[i] := Value;
  end;
  if i>=0 then begin
    GanttGraph.document.Scales[i].Color := Scalecolor;
             if Value = tmHour      then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfHourAMPM;
    end else if Value = tmDay       then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfDayShort;
    end else if Value = tmWeek      then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfWeekYearNr;
    end else if Value = tmMonth     then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfMonthShort;
    end else if Value = tmQuarter   then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfQuarterShort;
    end else if Value = tmYear      then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfYearFull;
    end else if Value = tmDecade    then begin  TimeMode := Value; GanttGraph.document.Scales[i].TimeFormat := tmfDecade;
    end;
  end;
end;

procedure TGanttChart.Showcolumn(const Index: Integer);
begin
  if index<0 then exit;
  if index> GanttGraph.tree.header.cellsCount-1 then exit;
  Restorecolumn(index);
end;
(*procedure TGanttChart.Restorecolumn(ColName:String);
var
  ctr:Integer;
begin
  if Length(GridColumns)=0 then exit;
  for ctr := low(GridColumns) to high(GridColumns) do
    if SameText(GridColumns[ctr].ColName , ColName) then begin
      break;
    end;
  Restorecolumn(ctr);
end;*)

procedure TGanttChart.Restorecolumn(Index:Integer);
begin
  if index<  GanttGraph.tree.header.cellsCount-1 then exit;
  if index <0 then exit;
  if (index < low( GridColumns)) or (index > high(GridColumns)) then exit;
  Columnwidth[index] := GridColumns[Index].ColWidth;
end;

function TGanttChart.getBaseColor       : TColor  ;begin  Result := GanttGraph.table.getBaseColor   ;end;
function TGanttChart.getGraphColumnWidth: Integer;
begin
  REsult := GanttGraph.Table.ColumnWidth;
end;

function TGanttChart.getGridColor       : TColor  ;begin  Result := GanttGraph.table.GridColor      ;end;
function TGanttChart.getGridLineColor   : Tcolor  ;begin  Result := GanttGraph.tree.GridLineColor   ;end;
function TGanttChart.getBackGroundcolor : TColor  ;begin  Result := GanttGraph.tree.bkColor         ;end;
function TGanttChart.getBarcount: Integer;
begin
  REsult := GanttBars.Count;
end;

function TGanttChart.getColor           : Tcolor  ;begin  Result := GanttGraph.tree.defaultRowSettings.Font.Color; end;
function TGanttChart.getdefaultRowheight: Integer ;begin  Result := Datasource.Table.defaultRowheight;end;
function TGanttChart.getgroupColor      : Tcolor  ;begin  Result := GanttGraph.tree.defaultRowSettings.groupColor; end;
function TGanttChart.getRowcount        : Integer ;begin  Result := DataSource.table.RowCount       ;end;

function TGanttChart.getStringTimeMode: String;
begin
       if Timemode = tmHour    then Result :='Hour'
  else if Timemode = tmDay     then Result :='Day'
  else if Timemode = tmWeek    then Result :='Week'
  else if Timemode = tmMonth   then Result :='Month'
  else if Timemode = tmQuarter then Result :='Quarter'
  else if Timemode = tmYear    then Result :='Year'
  else if Timemode = tmDecade  then Result :='Decade'
  else Result := 'Unknown';
end;

function TGanttChart.getFocusedRowColor                 : Tcolor  ;begin  Result := GanttGraph.tree.focusedRowColor           ;end;
function TGanttChart.GetColumnWidth(Index : Integer)    : Integer ;begin  Result := GanttGraph.tree.header.cells[Index].width ;end;
function TGanttChart.GetDisplayLabel(Index: Integer)    : String  ;begin  Result := Datasource.Tree.header.cells[Index].title ;end;

procedure TGanttChart.setBaseColor      (const Value: TColor)      ;begin  GanttGraph.table.SetBaseColor(clWhite)                     ;end;
procedure TGanttChart.SendEvent(const Value,  Msg: string);
begin
  if Assigned(fGanttChartEvent) then
    fGanttChartEvent(Self , Value , Msg);
end;

procedure TGanttChart.SetBackGroundcolor(const Value: TColor)      ;begin  GanttGraph.tree.bkColor  := Value                          ;end;

procedure TGanttChart.SetGanttGraph(const Value: TWGSGanttGraph);
begin
  fGanttGraph := Value;
  if Value <> nil then begin
    BackGroundcolor := clWhite;
    GridColor       := $00A0A0A0;
    BaseColor       := clWhite;
    GridLineColor   := $00A0A0A0;
    Color           := $006A3500;
    groupColor      := $00BFE6FB;
    FocusedRowColor := $006A3500;
    Scalecolor      := $02C56A31;
    columnwidth[0]  := 40;
    Value.Document.FormatDateToDisplay    := FormatDateToDisplay;
    Value.Document.ScaleDefaultTimeFormat := ScaleDefaultTimeFormat;
  end;
end;
procedure TGanttChart.setGraphColumnWidth(const Value: Integer);
begin
  GanttGraph.Table.ColumnWidth := Value;
  GanttGraph.Repaint;
end;

function TGanttChart.FormatDateToDisplay(date:TDateTime;TimeFormat : TWGSTimeFormat):String;
begin
  if TimeFormat = tmfDateshort then
    REsult := Formatdatetime(Formatsettings.shortDateformat, Date);
end;
procedure TGanttChart.SetDatasource(const Value: TWGSDataSource);
begin
  fDatasource := Value;
  if Value <> nil then begin
    if Assigned(fGanttGraph) then fGanttGraph.DataSource := Value;
    TimeMode        :=  tmDay;
    DefaultRowheight:= 36;
    fDatasource.OnAfterBarAdd     := doOnAfterBarAdd;
    fDatasource.OnAfterBarDelete  := doOnAfterBarDelete;
    fDatasource.OnBarResize       := doOnBarResize;
    fDatasource.OnGanttBarMove    := DoOnGanttBarMove;
    fDatasource.OnAfterBarResize  := DoOnAfterBarResize;
    fDatasource.OnAfterBarMove    := DoOnAfterBarMove;
    fDatasource.OnAfterBarMoveDetailed:= doOnAfterBarMoveDetailed;
    fDatasource.OnTreeColumnMove  := DoOnTreeColumnMove;
    fDatasource.OnBeforeBarMove   := DoOnBeforeBarMove;
    fDatasource.OnBeforeBarDelete := DoOnBeforeBarDelete;
    fDatasource.OnBeforeBarResize := DoOnBeforeBarResize;
    fDatasource.OnBeforeBarAdd    := DoOnBeforeBarAdd;
  end;
end;
procedure TGanttChart.setScalecolor(const Value: TColor);
var
  i:Integer;
begin
  fScalecolor := Value;
  for i := 0 to GanttGraph.document.ScalesCount-1 do
    GanttGraph.document.Scales[i].Color := Value;
end;

procedure TGanttChart.setTimeMode       (const Value: TWGSTimeMode)           ;
begin
  // make sure the mode is enabled before setting the mode
  fTimeMode := Value;
  DataSource.Calendar.SetTimeMode(Value);
(*  SetDefaultcolumnwidth    *)
end;
procedure TGanttChart.SetDefaultcolumnwidth;
begin
       if Timemode = tmHour    then GraphColumnWidth := 20
  else if Timemode = tmDay     then GraphColumnWidth := 40
  else if Timemode = tmWeek    then GraphColumnWidth := 40
  else if Timemode = tmMonth   then GraphColumnWidth := 40
  else if Timemode = tmQuarter then GraphColumnWidth := 40
  else if Timemode = tmYear    then GraphColumnWidth := 40
  else if Timemode = tmDecade  then GraphColumnWidth := 40;
end;

procedure TGanttChart.SetGridColor      (const Value: TColor)                 ;begin  GanttGraph.table.GridColor := Value                                         ;end;
procedure TGanttChart.setGridLineColor  (const Value: Tcolor)                 ;begin  GanttGraph.tree.GridLineColor := Value                                      ;end;
procedure TGanttChart.Showcolumn        (const ColName: String)               ;begin  Showcolumn(ColIndex(ColName))                                               ;end;
procedure TGanttChart.setColor          (const Value: Tcolor)                 ;begin  GanttGraph.tree.defaultRowSettings.Font.Color:= Value                       ;end;
procedure TGanttChart.setcolumnWidth    (Index: Integer; const Value: Integer);begin  if GanttGraph <> nil then GanttGraph.tree.header.cells[Index].width := Value;end;
procedure TGanttChart.setdefaultRowheight(const Value: Integer)               ;begin  Datasource.Table.defaultRowheight:= Value                                   ;end;
procedure TGanttChart.setgroupColor     (const Value: Tcolor)                 ;begin  GanttGraph.tree.defaultRowSettings.groupColor:= Value                       ;end;
procedure TGanttChart.SetDisplayLabel   (Index: Integer; const Value: STring) ;begin  Datasource.Tree.header.cells[Index].Title := Value                          ;end;
procedure TGanttChart.setFocusedRowColor(const Value: Tcolor)                 ;begin  GanttGraph.tree.focusedRowColor:= Value                                     ;end;
procedure TGanttChart.Hidecolumn        (const ColName: String)               ;begin  hidecolumn(ColIndex(ColName))                                               ;end;
{event procedures}
procedure TGanttChart.doOnAfterBarDelete(Bar: TWGSGanttBar);
var
  ctr:Integer;
begin
  if Assigned(fOnAfterBarDelete) then fOnAfterBarDelete(Bar);
  OnBarAfterChange(bar);

  if GanttBars.Count=0 then exit;
  for ctr := 0 to GanttBars.Count-1 do
    if GanttBars.Item[ctr] is TGanttBar then
      if TGanttBar(GanttBars.Item[ctr]).Bar = Bar then begin
        GanttBars.Delete(ctr);
        Break;
      end;
end;
function TGanttChart.GanttChartDrawStyle : TWGSDrawStyles;
begin

  case Appenv.Companyprefs.GanttChartDrawStyle of
     1: result := dsDrawSolid;
     2: result := dsDrawGradient;
     3: result := dsDrawPattern;
     4: result := dsDrawBar3D;
     5: result := dsDrawHatch;
     else result := dsDrawGradient;
  end;
end;
procedure TGanttChart.doOnAfterBarAdd(Bar: TWGSGanttBar);
var
  BarObj :TGanttBar;
begin
  if Assigned(fOnAfterBarAdd) then fOnAfterBarAdd(Bar);
  OnBarAfterChange(bar);
  BarObj :=TGanttBar.Create;
  BarObj.Bar := Bar;
  GanttBars.Add(BarObj);
  InsertedbarIndex :=GanttBars.Count-1;
  if not(Bar is TWGSTaskBar ) then exit;
  TWGSTaskBar(Bar).Settings.Height := Appenv.Companyprefs.GanttChartBarHeight;
  TWGSTaskBar(Bar).Settings.visualGoodie.drawStyle    := GanttChartDrawStyle;
  TWGSTaskBar(Bar).Settings.visualGoodie.GFStartColor := Appenv.Companyprefs.GanttChartGFStartColour;
  TWGSTaskBar(Bar).Settings.visualGoodie.GFEndColor   := Appenv.Companyprefs.GanttChartGFEndcolour;
end;
procedure TGanttChart.DoOnAfterBarMove(Bar: TWGSGanttBar);
begin
  if Assigned(fOnAfterBarMove) then fOnAfterBarMove(Bar);
  OnBarAfterChange(bar);
end;
Procedure TGanttChart.DoOnAfterBarMoveDetailed(Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;
begin
  if Assigned(fOnAfterBarMoveDetailed) then fOnAfterBarMoveDetailed(Bar , AFromSummaryBar);
  OnAfterBarMoveDetailed(bar , AFromSummaryBar);
end;
procedure TGanttChart.DoOnTreeColumnMove(column:TWGSTreeHeaderCell;width : integer);
begin
  if Assigned(fOnTreeColumnMove) then fOnTreeColumnMove(column, width);
end;


procedure TGanttChart.DoOnAfterBarResize(Bar: TWGSGanttBar);
begin
  if Assigned(fOnAfterBarResize) then fOnAfterBarResize(Bar);
  OnBarAfterChange(bar);
end;

procedure TGanttChart.DoOnBarResize(Bar: TWGSGanttBar; changeX: Real;  changeY: Integer; Right: Boolean; var Allowed: Boolean);
begin
  if Assigned(fOnBarResize) then fOnBarResize(Bar, ChangeX,changeY, right, Allowed);
end;

procedure TGanttChart.DoOnBeforeBarAdd(Bar: TWGSGanttBar; var Cancel: Boolean);
begin
    if Assigned(fOnBeforeBarAdd) then fOnBeforeBarAdd(Bar, Cancel);
    OnBarBeforeChange(Bar);
end;

procedure TGanttChart.DoOnBeforeBarDelete(Bar: TWGSGanttBar;var Cancel: Boolean);
begin
  if AllowToMoveBar then begin
    if Assigned(fOnBeforeBarDelete) then fOnBeforeBarDelete(Bar, Cancel);
    OnBarBeforeChange(Bar);
  end else begin
    Cancel := True;
    SendEvent(BarDeleteCancelled , '');
  end;
end;


procedure TGanttChart.DoOnBeforeBarMove(Bar: TWGSGanttBar; var Cancel: Boolean);
begin
  if AllowToMoveBar then  begin
    if Assigned(fOnBeforeBarMove) then fOnBeforeBarMove(Bar, Cancel);
    OnBarBeforeChange(Bar);
  end else begin
    Cancel := True;
    SendEvent(BarMoveCancelled, '');
  end;
end;
procedure TGanttChart.DoOnBeforeBarResize(Bar: TWGSGanttBar;var Cancel: Boolean);
begin
  if AllowToMoveBar then  begin
    if Assigned(fOnBeforeBarResize) then fOnBeforeBarResize(Bar, Cancel);
    OnBarBeforeChange(Bar);
  end else begin
    Cancel:= True;
    SendEvent(BarResizeCancelled,'');
  end;
end;
procedure TGanttChart.OnBarBeforeChange(Bar:TWGSGanttBar);
var
  gbar: TGanttBar;
begin
    DateFromBeforechange := bar.StartDate;
    //DateToBeforechanging   := bar.EndDate;
    ProcTreeIDofBarChanging:= 0;
    gbar:= GanttBars.ItembyBar[bar];
    if assigned(gbar) then begin
      ProcTreeIDofBarChanging:= gbar.ProcTreeId;
    end;
end;
procedure TGanttChart.OnBarAfterChange(Bar: TWGSGanttBar);
begin
    DateFromAfterchange := bar.StartDate;
    //DateToAfterchange   := bar.EndDate;
end;

procedure TGanttChart.DoOnGanttBarMove(Bar: TWGSGanttBar; NewRow: Integer;NewStartDate: TDateTime; var Allowed: Boolean);
begin
  if  (Bar.row <> NewRow) then begin
    Allowed:= False;
    SendEvent(BarMoveCancelled, 'Process Cannot be moved into a differnet branch');
    Exit;
  end;
  if Assigned(fOnGanttBarMove) then fOnGanttBarMove(Bar , NewRow,NewstartDate, Allowed);
end;

function TGanttChart.focusedRow: TGanttchartrow;
begin
  if fGanttchartrow = nil then fGanttchartrow:= TGanttchartrow.Create(Self);
  fGanttchartrow.Row:=GanttGraph.tree.focusedRow;
  result:= fGanttchartrow;
end;

{ TListObject }

procedure TListObject.Add(const aItem: TObject);
begin
  fList.Add(aItem);
end;

procedure TListObject.Clear;
begin
  fList.Clear;
end;

constructor TListObject.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
  Reset;
end;

procedure TListObject.Delete(const index: integer);
begin
  fList.Delete(index);
end;

destructor TListObject.Destroy;
var
  ctr:Integer;
begin
  for ctr:= 0 to count-1 do begin
    Delete(0);
  end;
  Freeandnil(fList);
  inherited;
end;

function TListObject.GetCount: integer;
begin
  result:= fList.Count;
end;

function TListObject.GetItem(const index: integer): TObject;
begin
  result:= fList[index];
end;

procedure TListObject.Reset;
begin

end;

{ TGanttBarList }

procedure TGanttBarList.Add(const aItem: TGanttBar);
begin
  fList.Add(aItem);
end;

function TGanttBarList.getItembyBar(const bar: TWGSGanttBar): TGanttBar;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if self.Item[x] is TGanttBar then
      if TGanttBar(self.Item[x]).bar = bar then begin
        result:= TGanttBar(self.Item[x]);
        break;
      end;
  end;

end;

function TGanttBarList.GetItemByProcessTimeId(const ProcessTimeId: integer): TGanttBar;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if self.Item[x] is TGanttBar then
      if TGanttBar(self.Item[x]).ProcessTimeId = ProcessTimeId then begin
        result:= TGanttBar(self.Item[x]);
        break;
      end;
  end;
end;

{ TGanttBar }

constructor TGanttBar.Create;
begin
  inherited;
  fBar            := nil;
  fiProcessTimeId := 0;
  fiProcessPartId :=0;
  fdTimeStart     := 0;
  fdTimeEnd       := 0;
  fiRowno         := 0;
  fiProcTreeId    := 0;
end;

destructor TGanttBar.Destroy;
begin
  inherited;
end;

{ TWGSMonday }

function TWGSMonday.Matches(Date: TDateTime; TM: TWGSTimeMode): Boolean;
begin
    Result := ((TM = tmDay) or (TM = tmNone)) and (DayOfTheWeek(Date) = 1);
end;

{ TWGSTuesday }

function TWGSTuesday.Matches(Date: TDateTime; TM: TWGSTimeMode): Boolean;
begin
  Result := ((TM = tmDay) or (TM = tmNone)) and (DayOfTheWeek(Date) = 2);
end;

{ TWGSWednesday }

function TWGSWednesday.Matches(Date: TDateTime; TM: TWGSTimeMode): Boolean;
begin
    Result := ((TM = tmDay) or (TM = tmNone)) and (DayOfTheWeek(Date) = 3);
end;

{ TWGSThursday }

function TWGSThursday.Matches(Date: TDateTime; TM: TWGSTimeMode): Boolean;
begin
    Result := ((TM = tmDay) or (TM = tmNone)) and (DayOfTheWeek(Date) = 4);
end;

{ TWGSFriday }

function TWGSFriday.Matches(Date: TDateTime; TM: TWGSTimeMode): Boolean;
begin
  Result := ((TM = tmDay) or (TM = tmNone)) and (DayOfTheWeek(Date) = 5);
end;

{ TGanttchartrow }

constructor TGanttchartrow.Create(AOwner: TComponent);
begin
  inherited;
  frow := nil;
  fGanttchartColumn := nil;
end;


destructor TGanttchartrow.Destroy;
begin
  Freeandnil(fGanttchartColumn);
  inherited;
end;

function TGanttchartrow.GanttChart: TGanttChart;
begin
  Result:= nil;
  if Assigned(Owner) then
    if owner is TGanttChart  then
      result := TGanttChart(Owner);
end;

function TGanttchartrow.getColumnByname(Columnname: String): TGanttchartColumn;
var
  ctr:Integer;
begin
  result:= nil;
  if not(Assigned(frow)) then exit;
  if GanttChart = nil then exit;

  if (fGanttchartColumn <>nil)  and (SameText(fGanttchartColumn.ColumnName , Columnname)) then
  else begin
    if fGanttchartColumn = nil then      fGanttchartColumn :=TGanttchartColumn.Create;
    fGanttchartColumn.ColumnName := columnName;
  end;
  for ctr := Low(GanttChart.Gridcolumns) to High(GanttChart.Gridcolumns) do begin
      if sametext(Columnname , GanttChart.Gridcolumns[ctr].FieldName ) then begin
        fGanttchartColumn.Value :=fRow.cells[ctr+1].Text;
        result :=fGanttchartColumn;
        exit;
      end;
  end;
end;

function TGanttchartrow.getRowIndex: Integer;
begin
  result:= -1;
  if assigned(frow) then
    result :=frow.rowIndex;
end;

{ TGanttchartColumn }
function TGanttchartColumn.GetAsBoolean: Boolean;
begin
  Result:= sametext(Value, 'True') or sametext(Value, 'T') or sametext(Value, 'Yes') or sametext(Value, 'Y');
end;

function TGanttchartColumn.GetAsDateTime: TDateTime;
begin
  Result:= 0;
  Try
    result := strtoDate(value);
  Except
    // kill the exception if data is not date format
  End;
end;

function TGanttchartColumn.GetAsFloat: Double;
begin
  Result:= 0;
  Try
    result := StrToFloat(Value);
  Except
    // kill the exception if data is not date format
  End;
end;
function TGanttchartColumn.GetAsInteger: Integer;
begin
  Result:= 0;
  Try
    result := StrToint(Value);
  Except
    // kill the exception if data is not date format
  End;
end;
function TGanttchartColumn.GetAsString: string;
begin
  Result:= Value;
end;
end.

