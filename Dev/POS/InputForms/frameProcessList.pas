unit frameProcessList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frameProcessItem, ExtCtrls,
  MyAccess,ERPdbComponents;  //MySQL MyDAC components

type

  TProcessItemList = class(TObject)
  private
    fList: TStringList;
    procedure SetItem(x: integer; item: TfrProcessItem);
    function GetItem(x: integer): TfrProcessItem;
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[x: integer]: TfrProcessItem read GetItem write SetItem; default;
    property Count: integer read GetCount;
    procedure AddItem(const Item: TfrProcessItem; const SortStr: string = '');
    procedure DeleteItem(const x: integer);
  end;

  TDisplayOrder = (doTopDown, doBottomUp);  // BottomUp means older at bottom
  // TopDown older at top

  TfrProcessList = class(TFrame)
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    fDisplayOrder: TDisplayOrder;
    // List of process step types to display on form (tblProcessStep)
    // List item contains Description and Object contains ID
    fProcessStepList: TStringList;
    qryOrders, qryLine: TERPQuery;
    CurrentWidth: integer;
    fShowComplete: boolean;
    fShowNotComplete: boolean;
    fShowAllSteps: boolean;
    fShowRangeStart,
    fShowRangeEnd: TDateTime;
    fMaxOrders: integer;
    ShowOrderCountWarning: boolean;
    fShowPriorButtons: boolean;
    fCanEdit: boolean;
    procedure SetDisplayOrder(dispOrd: TDisplayOrder);
    procedure RedisplayItems;
    procedure ItemChange(Sender: TObject);
    procedure SetRefreshIntervalSecs(secs: integer);
    function GetRefreshIntevalSecs: integer;
    procedure SetQuerySelection;
    procedure ProcessStepListChange(Sender: TObject);
    procedure SetShowComplete(Value: boolean);
    procedure SetShowNotComplete(Value: boolean);
    procedure SetShowAllSteps(Value: boolean);
    procedure SetShowRangeStart(Value: TDateTime);
    procedure SetShowRangeEnd(Value: TDateTime);
    procedure SetShowPriorButtons(Value: boolean);
    procedure SaveConfigInformation;
    procedure LoadConfigInformation;
  public
    { Public declarations }
    Items: TProcessItemList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DisplayOrder: TDisplayOrder read fDisplayOrder write SetDisplayOrder default doBottomUp;
    function AddItem: TfrProcessItem;
    function GetItemById(aId: integer): TfrProcessItem;
    property ProcessStepList: TStringList read fProcessStepList write fProcessStepList;
    function StepInList(ProcessStepId: integer): boolean;
    property RefreshIntervalSecs: integer read GetRefreshIntevalSecs write SetRefreshIntervalSecs;
    procedure UpdateOrdersFromDB;
    function RemoveCompleteItems: boolean;
    procedure ClearList;
    property ShowComplete: boolean read fShowComplete write SetShowComplete;
    property ShowNotComplete: boolean read fShowNotComplete write SetShowNotComplete;
    property ShowAllSteps: boolean read fShowAllSteps write SetShowAllSteps;
    property ShowRangeStart: TDateTime read fShowRangeStart write SetShowRangeStart;
    property ShowRangeEnd: TDateTime read fShowRangeEnd write SetShowRangeEnd;
    // maximum number of orders to display, 0 = no max
    property MaxOrders: integer read fMaxOrders write fMaxOrders;
    property ShowPriorButtons: boolean read fShowPriorButtons write SetShowPriorButtons;
    property CanEdit: boolean read fCanEdit write fCanEdit;
  end;

implementation

{$R *.dfm}

uses FastFuncs,OrdersLib, CommonDbLib, IniFiles, CommonLib, DNMLib,systemlib;

const
  OrderDisplaySaveFile = 'OrderDisplayInfo.ini';

constructor TfrProcessList.Create(AOwner: TComponent);
begin
  inherited;
  // set defaults
  fShowComplete := false;     // don't show completed orders
  fShowNotComplete := true;   // show not completeded orders
  fShowAllSteps := false;     // only show steps specified in list
  fShowRangeStart := 0;       // no time/date range filtering
  fShowRangeEnd := 0;
  fMaxOrders := 0;            // max number of orders to display, 0 = no maximum
  fShowPriorButtons := false; // hide 'Prior' buttons on items by default
  fCanEdit := true;           // allow changing processing of items

  ShowOrderCountWarning := true;

  Items := TProcessItemList.Create;
  qryOrders := TERPQuery.Create(nil);
  qryLine := TERPQuery.Create(nil);
  qryOrders.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryLine.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryLine.SQL.Text := 'SELECT * FROM tblOrderLines WHERE ID = :ID';

  fProcessStepList := TStringList.Create;
  fProcessStepList.OnChange := ProcessStepListChange;
  // set default display order
  fDisplayOrder := doBottomUp;

  CurrentWidth := Self.ClientWidth;
  SetQuerySelection;
  Timer.Interval := 5000;
  LoadConfigInformation;
  Timer.Enabled := true;
end;

destructor TfrProcessList.Destroy;
begin
  SaveConfigInformation;
  FreeAndNil(Items);
  FreeAndNil(fProcessStepList);
  FreeAndNil(qryOrders);
  FreeAndNil(qryLine);
  inherited;
end;

procedure TfrProcessList.SaveConfigInformation;
var
  Ini: TMemIniFile;
  x: integer;
begin
  Ini := TMemIniFile.Create(SystemLib.ExeDir + OrderDisplaySaveFile);
  try
    Ini.EraseSection('StepList');
    for x := 0 to Self.ProcessStepList.Count - 1 do begin
      Ini.WriteString('StepList', 'Item' + IntToStr(x),
        IntToStr(integer(Self.ProcessStepList.Objects[x])) + ',"' + Self.ProcessStepList[x] + '"');
    end;
    Ini.WriteBool('General', 'ShowAllSteps', Self.ShowAllSteps);
    Ini.WriteBool('General', 'ShowComplete', Self.ShowComplete);
    Ini.WriteBool('General', 'ShowNotComplete', Self.ShowNotComplete);
    Ini.WriteBool('General', 'ShowPriorButtons', Self.ShowPriorButtons);
    Ini.WriteInteger('General', 'RefreshIntervalSecs', Self.RefreshIntervalSecs);
    Ini.UpdateFile;
  finally
    FreeAndNil(Ini);
  end;
end;

procedure TfrProcessList.LoadConfigInformation;
var
  Ini: TMemIniFile;
  x: integer;
  sl: TStringList;
begin
  Ini := TMemIniFile.Create(SystemLib.ExeDir + OrderDisplaySaveFile);
  sl := TStringList.Create;
  try
    x := 0;
    // build display list
    while Ini.ValueExists('StepList', 'Item' + IntToStr(x)) do begin
      sl.CommaText := Ini.ReadString('StepList', 'Item' + IntToStr(x), '');
      if sl.Count = 2 then Self.ProcessStepList.AddObject(sl[1], TObject(FastFuncs.StrToInt(sl[0])));
      Inc(x);
    end;

    Self.ShowAllSteps        := Ini.ReadBool('General', 'ShowAllSteps', false);
    Self.ShowComplete        := Ini.ReadBool('General', 'ShowComplete', false);
    Self.ShowNotComplete     := Ini.ReadBool('General', 'ShowNotComplete', true);
    Self.ShowPriorButtons    := Ini.ReadBool('General', 'ShowPriorButtons', false);
    Self.RefreshIntervalSecs := Ini.ReadInteger('General', 'RefreshIntervalSecs', 5);
  finally
    FreeAndNil(sl);
    FreeAndNil(Ini);
  end;
end;


procedure TfrProcessList.ClearList;
begin
  while Self.Items.Count > 0 do begin
    Self.RemoveComponent(Self.Items[0]);
    Self.Items.DeleteItem(0);
  end;
end;

procedure TfrProcessList.SetDisplayOrder(dispOrd: TDisplayOrder);
begin
  if fDisplayOrder <> dispOrd then begin
    fDisplayOrder := dispOrd;

    //now redisplay in the required order
    RedisplayItems;
  end;
end;

function TfrProcessList.AddItem: TfrProcessItem;
begin
  Result := TfrProcessItem.Create(self);
  Result.Visible := false;
  Result.ShowPriorButton := self.ShowPriorButtons;
  Result.CanEdit := self.CanEdit;

  // Add new item to list
  Items.AddItem(Result);

  // Make this frame the parent
  Self.InsertControl(Result);

  Result.onItemChange := ItemChange;
end;

//Returns tru if this step is currently being displayed
function TfrProcessList.StepInList(ProcessStepId: integer): boolean;
begin
  Result := (fProcessStepList.IndexOfObject(TObject(ProcessStepId)) > -1);
end;

procedure TfrProcessList.RedisplayItems;
var
  x, totHeight: integer;
  isFirst: boolean;
  LastItem: TfrProcessItem;
  SavePos: integer;

  procedure SetVisibility(item: TfrProcessItem);
  var
    status: OrdersLib.TProcessStepStatus;
    x: integer;
  begin
    // delete any lines that are outside list display criteria
    x := 0;
    while x < item.Lines.LineCount do begin
      if (not Self.ShowAllSteps) and (not StepInList(item.Lines[x].CurrentProcessStepID)) then item.Lines.DeleteLine(x)
      else Inc(x);
    end;

    // hide items
    status := item.Status;
    if (item.Lines.LineCount < 1) or
      ((not Self.ShowComplete) and (Status = psComplete)) then item.Visible := false
    else item.Visible := true;
  end;
begin
  LastItem := nil;
  Self.DisableAlign;
  self.OnResize := nil;
  SavePos := Self.VertScrollBar.Position;
  Self.VertScrollBar.Position := 0;
  //Self.DisableAutoRange;
  try

    totHeight := 0;

    if DisplayOrder = doBottomUp then begin
      x := Items.Count - 1;
      isFirst := true;
      while x >= 0 do begin
        SetVisibility(Items[x]);

        if Items[x].Visible then begin
          if isFirst then begin
            Items[x].Top := 0;
            isFirst := false;
          end else Items[x].Top := LastItem.Top + LastItem.Height;

          LastItem := Items[x];
          totHeight := totHeight + Items[x].Height;
          Items[x].Width := Self.ClientWidth;
        end;
        Dec(x);
      end;
      Self.VertScrollBar.Range := totHeight;
      if Self.VertScrollBar.Range >= SavePos then Self.VertScrollBar.Position := SavePos
      else Self.VertScrollBar.Position := 0;
    end else begin
      x := 0;
      isFirst := true;
      while x < Items.Count - 1 do begin
        SetVisibility(Items[x]);

        if Items[x].Visible then begin
          if isFirst then begin
            Items[x].Top := 0;
            isFirst := false;
          end else Items[x].Top := LastItem.Top + LastItem.Height;

          LastItem := Items[x];
          totHeight := totHeight + Items[x].Height;
          Items[x].Width := Self.ClientWidth;
        end;
        Inc(x);
      end;
      Self.VertScrollBar.Range := totHeight;
      if Self.VertScrollBar.Range >= SavePos then Self.VertScrollBar.Position := SavePos
      else Self.VertScrollBar.Position := Self.VertScrollBar.Range;
    end;

    if Self.VertScrollBar.Range >= SavePos then Self.VertScrollBar.Position := SavePos

    finally
      Self.EnableAlign;
    //Self.EnableAutoRange;
    self.OnResize := FrameResize;
  end;
  Self.VertScrollBar.Size := 50;
end;


// find the item for aID (OrderID), returns nil if not in list
function TfrProcessList.GetItemById(aId: integer): TfrProcessItem;
var
  found: boolean;
  x: integer;
begin
  Result := nil;
  found := false;
  x := 0;
  while (x < self.Items.Count) and (not found) do begin
    if self.Items[x].ID = aId then begin
      found := true;
      Result := self.Items[x];
    end else Inc(x);
  end;
end;

procedure TfrProcessList.FrameResize(Sender: TObject);
var
  x: integer;
begin
  // SetItemWidths;
  for x := 0 to self.Items.Count - 1 do Self.Items[x].Width := ClientWidth;
end;

  // remove any items that have all of there lines complete for the current
  // process steps being displayed. Returns true if items have been removed.
function TfrProcessList.RemoveCompleteItems: boolean;
var
  OrderPos: integer;
begin
  Result := false;
  if Self.ShowComplete then Exit;
  OrderPos := 0;
  while OrderPos < self.Items.Count do begin
    if Self.Items[OrderPos].Status = psComplete then begin
      Self.RemoveComponent(self.Items[OrderPos]);
      self.Items.DeleteItem(OrderPos);
      Result := true;
    end else Inc(OrderPos);
  end;
end;

procedure TfrProcessList.ItemChange(Sender: TObject);
begin
  RedisplayItems; // will hide any finished orders untill they are deleted
end;


procedure TfrProcessList.SetRefreshIntervalSecs(secs: integer);
var
  TimerEnabled: boolean;
begin
  TimerEnabled := Timer.Enabled;
  Timer.Enabled := false;
  Timer.Interval := secs * 1000;
  Timer.Enabled := TimerEnabled;
end;

function TfrProcessList.GetRefreshIntevalSecs: integer;
begin
  Result := Trunc(Timer.Interval / 1000);
end;

procedure TfrProcessList.SetQuerySelection;
var
  TimerEnabled: boolean;
  x: integer;
  isFirst: boolean;
  s: string;
begin
  TimerEnabled := Timer.Enabled;
  Timer.Enabled := false;
  try

    qryOrders.Close;
    qryOrders.SQL.Text := 'SELECT' + ' tblOrder.ID as ''OrderId'',' + ' tblOrder.LastUpdated as ''OrderLastUpdated'',' +
      ' tblOrder.CreateTime as ''OrderCreateTime'',' + ' tblOrder.CustDocketRef as ''OrderCustDocketRef'',' +
      ' tblOrder.Complete as ''OrderComplete'',' + ' tblOrderLines.ID as ''OrderLineId'',' +
      ' tblOrderLines.LastUpdated as ''OrderLineLastUpdated'',' + ' tblOrderLines.Description as ''OrderLineDescription'',' +
      ' tblOrderLines.Qty as ''OrderLineQty'',' + ' tblOrderLines.RequiresProcessing as ''OrderLineRequiresProcessing'',' +
      ' tblOrderLines.Status as ''OrderLineStatus'',' + ' tblOrderLines.CurrentProcStep as ''OrderLineCurrentProcStep'',' +
      ' tblProcessStep.Description as ''OrderLineCurrentProcStepDesc'',' + ' tblOrderLines.Complete as ''OrderLineComplete''' +
      ' FROM tblOrder, tblOrderLines, tblProcessStep' + ' WHERE tblOrderLines.OrderID = tblOrder.ID' +
      ' AND tblOrderLines.CurrentProcStep = tblProcessStep.ID';// +

    if (not fShowAllSteps) and (self.fProcessStepList.Count > 0) then begin
      // get a list of currently displayed step id's
      isFirst := true;
      s := '(';
      for x := 0 to self.fProcessStepList.Count - 1 do begin
        if isFirst then isFirst := false
        else s := s + ',';
        s := s + IntToStr(integer(self.fProcessStepList.Objects[x]));
      end;
      s := s + ')';
      qryOrders.SQL.Add(' AND tblOrderLines.CurrentProcStep IN ' + s);
    end;

    // can only show Complete, Not Complete or Both
    if not (fShowComplete and fShowNotComplete) then begin
      if fShowNotComplete then qryOrders.SQL.Add(' AND tblOrderLines.Complete = ''F''')
      else qryOrders.SQL.Add(' AND tblOrderLines.Complete = ''T''');
    end;

    // Date/time range filtering
    if (fShowRangeStart > 0) and (fShowRangeEnd > 0) then begin
      qryOrders.SQL.Add(' AND (' +
        ' tblOrder.CreateTime >= ''' +
        FormatDateTime('yyyy-mm-dd mm:nn:ss', fShowRangeStart) + '''''' +
        ' AND tblOrder.CreateTime <= ''' +
        FormatDateTime('yyyy-mm-dd mm:nn:ss', fShowRangeEnd) + ''')');
    end;

    // Sort lines as per original input sequence
    qryOrders.SQL.Add(' GROUP BY tblOrderLines.OrderID, tblOrderLines.ID');

  finally
    Timer.Enabled := TimerEnabled;
  end;
end;

procedure TfrProcessList.ProcessStepListChange(Sender: TObject);
begin
  //the process step selection has changed so we need to update the main sql
  Timer.Enabled := false;
  try
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  finally
    Timer.Enabled := true;
  end;
end;

procedure TfrProcessList.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  try
    UpdateOrdersFromDB;
  finally
    Timer.Enabled := true;
  end;
end;


// Main processing procedure to add/update orders from database
procedure TfrProcessList.UpdateOrdersFromDB;
var
  Order: TfrProcessItem;
  OrdersAdded, LinesAdded, OrdersRemoved: boolean;
  OrderCount: integer;

  procedure CheckOrCreateLines;
  var
    Line: TOrderLineItem;
  begin
    Line := Order.Lines.GetLineById(qryOrders.FieldByName('OrderLineId').AsInteger);
    if Line = nil then begin
      Line       := Order.Lines.AddLine;  // add this line
      Line.ID    := qryOrders.FieldByName('OrderLineId').AsInteger;
      LinesAdded := true;
    end;
    if Line.LastUpdated <> qryOrders.FieldByName('OrderLineLastUpdated').AsDateTime then begin
      Line.Description := qryOrders.FieldByName('OrderLineDescription').AsString;
      Line.Qty         := qryOrders.FieldByName('OrderLineQty').AsFloat;
      Line.CurrentProcessStepID := qryOrders.FieldByName('OrderLineCurrentProcStep').AsInteger;
      Line.CurrentProcessStepDesc := qryOrders.FieldByName('OrderLineCurrentProcStepDesc').AsString;
      Line.Status      := TProcessStepStatus(qryOrders.FieldByName('OrderLineStatus').AsInteger);
      Line.LastUpdated := qryOrders.FieldByName('OrderLineLastUpdated').AsDateTime;
      Line.Complete    := qryOrders.FieldByName('OrderLineComplete').AsBoolean;
    end;
  end;
begin
  // If no process steps are selected for viewing then exit
  if (not fShowAllSteps) and (fProcessStepList.Count = 0) then Exit;

  OrdersAdded := false;
  LinesAdded := false;
  qryOrders.Open;
  try
    OrdersRemoved := RemoveCompleteItems;
    OrderCount    := 0;
    while not qryOrders.Eof do begin
      if (fMaxOrders <> 0) and (qryOrders.RecordCount > fMaxOrders) then begin
        if ShowOrderCountWarning then CommonLib.MessageDlgXP_Vista('There are ' + IntToStr(qryOrders.RecordCount) +
            ' orders, only the first ' + IntToStr(fMaxOrders) + ' will be displayed.', mtWarning, [mbOK], 0);
        ShowOrderCountWarning := false;       // only show once
      end else ShowOrderCountWarning := true; // reset when selection is below max

      Inc(OrderCount);
      if (fMaxOrders = 0) or (OrderCount <= fMaxOrders) then begin
        Order := Self.GetItemById(qryOrders.FieldByName('OrderId').AsInteger);
        if Order = nil then begin
          // create a new order
          Order := Self.AddItem;
          Order.ID := qryOrders.FieldByName('OrderID').AsInteger;
          OrdersAdded := true;
        end;

        // update if need be
        if Order.LastUpdated <> qryOrders.FieldByName('OrderLastUpdated').AsDateTime then begin
          Order.OrderRef := qryOrders.FieldByName('OrderCustDocketRef').AsString;
          Order.Complete := qryOrders.FieldByName('OrderComplete').AsBoolean;
          Order.LastUpdated := qryOrders.FieldByName('OrderLastUpdated').AsDateTime;
        end;

        // now check/create lines
        CheckOrCreateLines;
      end;
      qryOrders.Next;
    end; // while
  finally
    qryOrders.Close;
  end;

  if OrdersAdded or LinesAdded or OrdersRemoved then begin
    Self.RedisplayItems;
  end;
end;

procedure TfrProcessList.SetShowComplete(Value: boolean);
begin
  if fShowComplete <> Value then begin
    fShowComplete := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;

procedure TfrProcessList.SetShowNotComplete(Value: boolean);
begin
  if fShowNotComplete <> Value then begin
    fShowNotComplete := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;

procedure TfrProcessList.SetShowAllSteps(Value: boolean);
begin
  if fShowAllSteps <> Value then begin
    fShowAllSteps := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;

procedure TfrProcessList.SetShowRangeStart(Value: TDateTime);
begin
  if fShowRangeStart <> Value then begin
    fShowRangeStart := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;

procedure TfrProcessList.SetShowRangeEnd(Value: TDateTime);
begin
  if fShowRangeEnd <> Value then begin
    fShowRangeEnd := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;

procedure TfrProcessList.SetShowPriorButtons(Value: boolean);
begin
  if fShowPriorButtons <> Value then begin
    fShowPriorButtons := Value;
    ClearList;
    SetQuerySelection;
    UpdateOrdersFromDB;
  end;
end;


//--------- TProcessItemList ---------------------------------------------------

constructor TProcessItemList.Create;
begin
  inherited;
  fList := TStringList.Create;
  // Note: setting sorted to true results in wrong fList.Count value when
  //       items are first added
  //fList.Sorted:= True;
end;

destructor TProcessItemList.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

procedure TProcessItemList.SetItem(x: integer; item: TfrProcessItem);
begin
  fList.Objects[x] := item;
end;

function TProcessItemList.GetItem(x: integer): TfrProcessItem;
begin
  Result := TfrProcessItem(fList.Objects[x]);
end;

function TProcessItemList.GetCount;
begin
  Result := fList.Count;
end;

procedure TProcessItemList.AddItem(const Item: TfrProcessItem; const SortStr: string = '');
var
  s: string;
begin
  if s = '' then s := FormatFloat('000000.000000', Now); // use time as default sort

  fList.AddObject(s, Item);
end;

procedure TProcessItemList.DeleteItem(const x: integer);
begin;
  self.Items[x].Free;
  fList.Delete(x);
end;

initialization
end.
