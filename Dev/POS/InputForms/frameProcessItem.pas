unit frameProcessItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, StdCtrls, Buttons, DNMSpeedButton, OrdersLib;

type

  TOrderLineItem = class(TObject)
  private
    fId: integer;
    fDesc: string;
    fQty: double;
    fCurrentStepId: integer;
    fCurrentStepDesc: string;
    fStatus: TProcessStepStatus;
    fIndex: integer;
    fLastUpdated: TDateTime;
    fComplete: boolean;
    fOnItemChange: TNotifyEvent;
    procedure SetId(const aId: integer);
    procedure SetDesc(const aDesc: string);
    procedure SetQty(const aQty: double);
    procedure SetCurrentStepId(const ID: integer);
    procedure SetCurrentStepDesc(const desc: string);
    procedure SetStatus(const aStatus: TProcessStepStatus);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetProcessInfo(const StepId: integer; const StepDesc: string; const Status: TProcessStepStatus);
    property OnItemChange: TNotifyEvent read fOnItemChange write fOnItemChange;
    property ID: integer read fId write SetID;
    property Description: string read fDesc write SetDesc;
    property Qty: double read fQty write SetQty;
    property CurrentProcessStepID: integer read fCurrentStepId write SetCurrentStepId;
    property CurrentProcessStepDesc: string read fCurrentStepDesc write SetCurrentStepDesc;
    property Status: TProcessStepStatus read fStatus write SetStatus;
    property LastUpdated: TDateTime read fLastUpdated write fLastUpdated;
    property Complete: boolean read fComplete write fComplete;
    property ListIndex: integer read fIndex;
  end;

  TOrderLineList = class(TObject)
  private
    fList: TList;
    fOnListChange: TNotifyEvent;
    procedure LineItemChange(Sender: TObject);
    procedure SetItem(x: integer; item: TOrderLineItem);
    function GetItem(x: integer): TOrderLineItem;
    function GetLineCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    function AddLine: TOrderLineItem;
    procedure DeleteLine(const x: integer);
    function GetLineById(const aId: integer): TOrderLineItem;    
    property OnListChange: TNotifyEvent read fOnListChange write fOnListChange;
    property Items[x: integer]: TOrderLineItem read GetItem write SetItem; default;
    property LineCount: integer read GetLineCount;

  end;

  TItemChangeEvent = procedure(Sender: TObject) of object;

  TfrProcessItem = class(TFrame)
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnlMain: TPanel;
    pnlRef: TPanel;
    grdLines: TStringGrid;
    pnlRight: TPanel;
    pnlButtons: TPanel;
    btnNext: TPanel;
    btnPrior: TPanel;
    procedure ControlClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure btnPriorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure btnPriorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure btnPriorClick(Sender: TObject);
  private
    { Private declarations }
    fID: integer;
    fOnItemChange: TItemChangeEvent;
    fComplete: boolean;
    fLastUpdated: TDateTime;
    fShowPriorButton: boolean;
    fCanEdit: boolean;
    procedure LinesChange(Sender: TObject);
    procedure SetColour(aColour: TColor);
    function GetColour: TColor;
    procedure SetOrderRef(const aRef: string);
    function GetOrderRef: string;
    function GetStatus: TProcessStepStatus;
    //procedure SetStatus(newStatus: TProcessStepStatus);
    procedure SetCanEdit(Value: boolean);

  public
    { Public declarations }
    Lines: TOrderLineList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ID: integer read fID write fID;
    property Colour: TColor read GetColour write SetColour;
    property OrderRef: string read GetOrderRef write SetOrderRef;
    property OnItemChange: TItemChangeEvent read fOnItemChange write fOnItemChange;
    property Complete: boolean read fComplete write fComplete;
    property LastUpdated: TDateTime read fLastUpdated write fLastUpdated;
    property Status: TProcessStepStatus read GetStatus; // write SetStatus;
    procedure SetLayout;
    property ShowPriorButton: boolean read fShowPriorButton write fShowPriorButton;
    property CanEdit: boolean read fCanEdit write SetCanEdit;
  end;

implementation

{$R *.dfm}

const
  MIN_FRAME_HEIGTH = 70;
  GRID_MARGIN      = 3;

constructor TfrProcessItem.Create(AOwner: TComponent);
begin
  inherited;

  // set name to somthing unique
  self.Name := '';

  fID := 0;
  fComplete := false;
  fLastUpdated := 0;
  pnlButtons.Visible := Self.fCanEdit;
  btnPrior.Visible := fShowPriorButton;
  Lines := TOrderLineList.Create;
  Lines.fOnListChange := LinesChange; // assing event handler

  //Set the grid up
  grdLines.ColWidths[0] := 0;    // set to 0 width to hide focus sell
  grdLines.ColWidths[1] := 150;  // Description
  grdLines.ColWidths[2] := 40;   // Quantity
  grdLines.ColWidths[3] := 100;   // Step name
  grdLines.ColWidths[4] := 70;   // Status

  //ProcessStatus:= psNone;
end;

destructor TfrProcessItem.Destroy;
begin
  FreeAndNil(Lines);
  inherited;
end;

procedure TfrProcessItem.SetColour(aColour: TColor);
var
  x: integer;
begin
  { If you specify TColor as a specific 4-byte hexadecimal number instead
    of using the constants defined in the Graphics unit, the low three bytes
    represent RGB color intensities for blue, green, and red, respectively.
    The value $00FF0000 represents full-intensity, pure blue,
    $0000FF00 is pure green, and $000000FF is pure red.
    $00000000 is black and $00FFFFFF is white.
  }
  Self.Color := aColour;
  for x := 0 to self.ComponentCount - 1 do begin
    if (self.Components[x] is TPanel) then TPanel(self.Components[x]).Color := aColour
    else if (self.Components[x] is TStringGrid) then TStringGrid(self.Components[x]).Color := aColour
  end;
end;

function TfrProcessItem.GetColour: TColor;
begin
  Result := self.Color;
end;

procedure TfrProcessItem.SetOrderRef(const aRef: string);
begin
  self.pnlRef.Caption := aRef;
end;

function TfrProcessItem.GetOrderRef: string;
begin
  Result := self.pnlRef.Caption;
end;

procedure TfrProcessItem.SetCanEdit(Value: boolean);
begin
  fCanEdit := Value;
  pnlButtons.Visible := fCanEdit;
end;

procedure TfrProcessItem.LinesChange(Sender: TObject);
var
  x: integer;
begin
  // Lines have changed so update the grid

  // Resize grid to fit all lines
  grdLines.RowCount := Lines.LineCount;
  grdLines.Height := (grdLines.RowHeights[0] + 1) * Lines.LineCount;
  if (grdLines.Height + 2 * GRID_MARGIN) <= MIN_FRAME_HEIGTH then self.Height := MIN_FRAME_HEIGTH
  else self.Height := (grdLines.Height + 2 * GRID_MARGIN);

  // Center grid vertically
  grdLines.Top := Round((self.Height - grdLines.Height) / 2);

  // Refresh grid cells
  for x := 0 to Lines.LineCount - 1 do begin
    grdLines.Cells[1, x] := Lines[x].Description;
    grdLines.Cells[2, x] := '  ' + FloatToStr(Lines[x].Qty);
    grdLines.Cells[3, x] := Lines[x].CurrentProcessStepDesc;
    grdLines.Cells[4, x] := ' ' + ProcessStepStatusDesc[Lines[x].Status];
  end;
  //self.StatusToColour;
  GetStatus;
  grdLines.Color := Colour;
  //Self.Refresh;
end;

procedure TfrProcessItem.ControlClick(Sender: TObject);
begin
  //CommonLib.MessageDlgXP_Vista('CLICK: ' + self.OrderRef);
end;

procedure TfrProcessItem.btnNextClick(Sender: TObject);
var
  x: integer;
  info: TProcessStepInfo;
begin
  for x := 0 to Self.Lines.LineCount - 1 do begin
    info := OrdersLib.ProgressOrderLineProcess(Self.Lines[x].ID);
    Self.Lines[x].SetProcessInfo(info.id, info.Description, info.Status);
  end;

  if Assigned(fOnItemChange) then fOnItemChange(self);
end;

procedure TfrProcessItem.btnPriorClick(Sender: TObject);
var
  x: integer;
  info: TProcessStepInfo;
begin
  for x := 0 to Self.Lines.LineCount - 1 do begin
    info := OrdersLib.RegressOrderLineProcess(Self.Lines[x].ID);
    Self.Lines[x].SetProcessInfo(info.id, info.Description, info.Status);
  end;
  //self.Refresh;
  if Assigned(fOnItemChange) then fOnItemChange(self);
end;

procedure TfrProcessItem.FrameResize(Sender: TObject);
begin
  SetLayout;
end;

procedure TfrProcessItem.SetLayout;
begin
  // reposition controls
  // set button pos
  pnlRight.Left := ClientWidth - pnlRight.Width;
  pnlRight.Height := Height;
  pnlButtons.Left := pnlRight.Left - pnlButtons.Width;
  pnlButtons.Top := Round((Height - pnlButtons.Height) / 2);

  //set grid width;
  grdLines.Width := pnlButtons.Left - grdLines.Left - 30;

  grdLines.ColWidths[1] := grdLines.Width - grdLines.ColWidths[0] - grdLines.ColWidths[2] -
    grdLines.ColWidths[3] - grdLines.ColWidths[4];
end;


// get the process status that is common to all lines else return psNone
function TfrProcessItem.GetStatus: TProcessStepStatus;
var
  x: integer;
begin
  Result := psNone;
  if self.Lines.LineCount > 0 then begin
    Result := Self.Lines[0].Status;
    x      := 0;
    while (x < self.Lines.LineCount - 1) and (Result = Self.Lines[0].Status) do begin
      if Result <> Self.Lines[x].Status then Result := psNone
      else Inc(x);
    end;
  end;

  // set button
  case Result of
    psNone: 
      begin
        btnNext.Visible := false;
        btnPrior.Visible := false;
        SetColour(OrdersLib.ProcessStepColours[Result]);
      end;
    psWaiting: 
      begin
        btnNext.Visible := true;
        btnPrior.Visible := fShowPriorButton;
        SetColour(OrdersLib.ProcessStepColours[Result]);
      end;
    psStarted: 
      begin
        btnNext.Visible := true;
        btnPrior.Visible := fShowPriorButton;
        SetColour(OrdersLib.ProcessStepColours[Result]);
      end;
    psComplete: 
      begin
        btnNext.Visible := false;
        btnPrior.Visible := true;
        SetColour(OrdersLib.ProcessStepColours[Result]);
      end;
  end;
end;

// ------------ TOredreLineItem ------------------------------------------------

constructor TOrderLineItem.Create;
begin
  inherited;
  fId := 0;
  fDesc := '';
  fQty := 0;
  fStatus := psNone;
  fCurrentStepId := 0;
  fCurrentStepDesc := '';
  fIndex := 0;
  fLastUpdated := 0;
  fComplete := false;
end;

destructor TOrderLineItem.Destroy;
begin
  inherited;
end;

procedure TOrderLineItem.SetId(const aId: integer);
begin
  if fId <> aId then begin
    fId := aId;
    // don't triger event when id set, don't want it to redisplay everthing at this stage
    //if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

procedure TOrderLineItem.SetDesc(const aDesc: string);
begin
  if fdesc <> aDesc then begin
    fDesc := aDesc;
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

procedure TOrderLineItem.SetQty(const aQty: double);
begin
  if fQty <> aQty then begin
    fQty := aQty;
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

procedure TOrderLineItem.SetCurrentStepId(const ID: integer);
begin
  if fCurrentStepId <> ID then begin
    fCurrentStepId := ID;
    (*
    if ID = 0 then begin
      fComplete:= true;
      fStatus:= psNone;
    end
    else begin
      fComplete:= false;
      fStatus:= psWaiting;
    end;
    *)
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

procedure TOrderLineItem.SetCurrentStepDesc(const desc: string);
begin
  if fCurrentStepDesc <> desc then begin
    fCurrentStepDesc := desc;
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;


procedure TOrderLineItem.SetStatus(const aStatus: TProcessStepStatus);
begin
  if fStatus <> aStatus then begin
    fStatus := aStatus;
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

procedure TOrderLineItem.SetProcessInfo(const StepId: integer; const StepDesc: string; const Status: TProcessStepStatus);
begin
  if (fCurrentStepId <> StepId) or (fCurrentStepDesc <> StepDesc) or (fStatus <> Status) then begin
    fCurrentStepId   := StepId;
    fCurrentStepDesc := StepDesc;
    fStatus          := Status;
    if Assigned(OnItemChange) then OnItemChange(self);
  end;
end;

// ------------ TOredreLineList ------------------------------------------------

constructor TOrderLineList.Create;
begin
  inherited;
  fList := TList.Create;
end;

destructor TOrderLineList.Destroy;
begin
  while fList.Count > 0 do begin
    TOrderLineItem(fList.Items[0]).Free;
    fList.Delete(0);
  end;
  FreeAndNil(fList);
  inherited;
end;

procedure TOrderLineList.LineItemChange(Sender: TObject);
begin
  // an item in the list has changed so pass it up the chain
  if Assigned(fOnListChange) then fOnListChange(self);
end;

procedure TOrderLineList.SetItem(x: integer; item: TOrderLineItem);
begin
  fList.Items[x] := item;
  if Assigned(fOnListChange) then fOnListChange(self);
end;

function TOrderLineList.GetItem(x: integer): TOrderLineItem;
begin
  Result := fList.Items[x];
end;

function TOrderLineList.GetLineCount: integer;
begin
  Result := fList.Count;
end;

function TOrderLineList.AddLine: TOrderLineItem;
var
  posn: integer;
begin
  Result := TOrderLineItem.Create;
  posn := fList.Add(Result);
  // the index in the list
  Result.fIndex := posn;
  // assign change event handler
  Result.OnItemChange := LineItemChange;
  if Assigned(fOnListChange) then fOnListChange(self);
end;

procedure TOrderLineList.DeleteLine(const x: integer);
begin
  TOrderLineItem(fList.Items[x]).Free;
  fList.Delete(x);
  if Assigned(fOnListChange) then fOnListChange(self);
end;

// returns nil if item not found
function TOrderLineList.GetLineById(const aId: integer): TOrderLineItem;
var
  x: integer;
  found: boolean;
begin
  Result := nil;
  found := false;
  x := 0;
  while (not found) and (x < self.fList.Count) do begin
    if TOrderLineItem(fList.Items[x]).ID = aId then begin
      found := true;
      Result := fList.Items[x];
    end else Inc(x);
  end;
end;

procedure TfrProcessItem.btnPriorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  TPanel(Sender).BevelInner := bvLowered;
end;

procedure TfrProcessItem.btnPriorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  TPanel(Sender).BevelInner := bvRaised;
end;

end.
