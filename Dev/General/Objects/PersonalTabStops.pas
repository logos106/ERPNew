unit PersonalTabStops;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, DB,
  MyAccess,ERPdbComponents, Grids, dbGrids, wwDBGrid, Graphics, ExtCtrls;

type
  pliRecord = ^tliRecord;
  tliRecord = record
    Control: TWinControl;          // wincontrol name
    ControlID: integer;            // unique ID for wincontrol from tblcomponents
    FieldName: string;             // FieldName if Grid
    DefaultTS: boolean;            // Tabstop as from 'Design Time' setting
  end;

  // record to store the name and notifyevent of a dataset
  pAfterOpenRec = ^TAfterOpenRec;
  TAfterOpenRec = record
    Name: AnsiString;
    Event: TDataSetNotifyEvent;
  end;

  tpersonaltabs = class(TComponent)
  private
    lstOpenEvents: TList;       // list of 'AfterOpen' events
    li: TList;                  // owns liRecords for wincontrols on form
    formID: integer;
    EmployeeID: integer;
    Owner: TForm;
    MyDacConnection: TCustomMyConnection;
    GridDataSetsCount: integer;
    FInitialised: boolean;
    FTabStopState: boolean;
    bGridIsHooked: boolean;  // true if we have hooked into grid event - stops stack overflow
    procedure ClearLi;
    procedure ClearOpenEvents;
    //    procedure setPersonalTabStop(lircd: pliRecord);
    procedure drawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure grdKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure CallAfterOpenEvent(ds: TDataSet);
    function FindShape(const Control: TControl): TShape;
  public
    TabOrderFlag: integer; // TAB ORDER CRASH PROBLEM FLAG (See PersonalTabStops & BaseSale)
    constructor Create(pOwner: TForm; EmpID: integer); reintroduce;
    destructor Destroy; override;
    function HookGridDataSets: boolean;
    procedure Initialise(ds: TDataSet);
    procedure StorePrefs;
    property Initialised: boolean read FInitialised write FInitialised;
    property TabStopState: boolean read FTabStopState write FTabStopState;
    procedure TabStopsOnOff(var Msg: tagMSG; var Handled: boolean);

  published
    { Published declarations }
  end;

implementation

uses
  Variants, wwradiogroup, wwDBiGrd,
  CommonDbLib, tcConst, FastFuncs, CommonLib;

{ tpersonaltabs.Create --------------------------}
constructor tpersonaltabs.Create(pOwner: TForm; EmpID: integer);
begin
  inherited Create(pOwner);
  li := TList.Create;
  bGridIsHooked := false;
  lstOpenEvents := TList.Create;
  Owner := pOwner;
  MyDacConnection := CommonDbLib.GetSharedMyDacConnection;
  EmployeeID := EmpID;
end; //Create

{ tpersonaltabs.Destroy --------------------------}
destructor tpersonaltabs.Destroy;
begin
  ClearLi;
  FreeAndNil(li);
  ClearOpenEvents;
  FreeAndNil(lstOpenEvents);
  inherited;
end; //Destroy

{ tpersonaltabs.ClearLi-----------------------------------------------------------}
procedure tpersonaltabs.ClearLi;
begin
  while li.Count > 0 do begin
    Dispose(li.Items[li.Count - 1]);
    li.Delete(li.Count - 1);
  end;
end;

{ tpersonaltabs.ClearOpenEvents---------------------------------------------------}
procedure tpersonaltabs.ClearOpenEvents;
begin
  while lstOpenEvents.Count > 0 do begin
    Dispose(lstOpenEvents.Items[lstOpenEvents.Count - 1]);
    lstOpenEvents.Delete(lstOpenEvents.Count - 1);
  end;
end;

{ tpersonaltabs.storePrefs --------------------------}
procedure tpersonaltabs.storePrefs;
var 
  i: integer;
  qryPersonalTabs: TERPQuery;
  plircd: pliRecord;
  ts: string;
begin

  qryPersonalTabs := TERPQuery.Create(nil);
  qryPersonalTabs.Connection := MyDacConnection;
//  qryPersonalTabs.LockType := ltOptimistic;
  try
    for i := 0 to li.Count - 1 do begin
      plircd := li.Items[i];
      // FIRST DELETE EmpID, CompID Records
      qryPersonalTabs.SQL.Text := Format('DELETE FROM tblpersonaltabs ' +
        'WHERE EmployeeID = %d AND ControlID = %d AND FieldName = ''%s''', [EmployeeID, plircd.ControlID, plircd.FieldName]);
      qryPersonalTabs.Execute;
      if plircd.Control.TabStop <> plircd.DefaultTS then begin
        if Empty(plircd.FieldName) then begin  // INSERT if different from default setting
          if plircd.Control.TabStop then begin
            ts := 'T'
          end else begin
            ts := 'F';
          end;
          qryPersonalTabs.SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblpersonaltabs ' +
            '(EmployeeID, ControlID, FieldName, TabStop) ' + 'VALUES (%d, %d, ''%s'', ''%s'')',
            [EmployeeID, plircd.ControlID, plircd.FieldName, ts]);
          qryPersonalTabs.Execute;
        end;
      end;
      if (plircd.Control is TwwDBGrid) and not Empty(plircd.FieldName) then begin
        if (TwwDBGrid(plircd.Control).DataSource.DataSet.FieldByName(plircd.FieldName).Tag and TAG_MASK_PT) = TAG_MASK_PT <> plircd.DefaultTS then begin
          // gridcolumns
          if (TwwDBGrid(plircd.Control).DataSource.DataSet.FieldByName(plircd.FieldName).Tag  and TAG_MASK_PT) = TAG_MASK_PT then begin
            ts := 'T';
          end else begin
            ts := 'F';
          end;
          qryPersonalTabs.SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblpersonaltabs ' +
            '(EmployeeID, ControlID, FieldName, TabStop) ' + 'VALUES (%d, %d, ''%s'', ''%s'')',
            [EmployeeID, plircd.ControlID, plircd.FieldName, ts]);
          qryPersonalTabs.Execute;
        end;
        qryPersonalTabs.Close;
      end;
    end;
  finally
    FreeAndNil(qryPersonalTabs);
  end;
end; //storePrefs

{ tpersonaltabs.HookGridDataSets-----------------------------------------------------------}
function tpersonaltabs.HookGridDataSets: boolean;
var
  i: integer;
  pEvents: pAfterOpenRec;
begin
  Result := false;
  if not bGridIsHooked then begin
    bGridIsHooked := true;
    for i := 0 to TForm(Owner).ComponentCount - 1 do if TForm(Owner).Components[i] is TwwDBGrid then begin
        if not Assigned(TwwDBGrid(TForm(Owner).Components[i]).DataSource) or
          not Assigned(TwwDBGrid(TForm(Owner).Components[i]).DataSource.DataSet) then
          raise Exception.CreateFmt('Form %s'#13#10'Programmer:'#13#10'Connect %s to a dataset',
            [TForm(Owner).Name, TwwDBGrid(TForm(Owner).Components[i]).Name]);
        // if this grid's dataset already has an AfterOpen event, then we Save its
        // .. name and the AfterOpen event, so that we can call it from initialise
        if Assigned(TwwDBGrid(TForm(Owner).Components[i]).DataSource.DataSet.AfterOpen) then begin
          New(pEvents);
          lstOpenEvents.Add(pEvents);
          {$warnings off}
          pEvents^.Name := TwwDBGrid(TForm(Owner).Components[i]).DataSource.DataSet.Name;
          {$warnings on}
          pEvents^.Event := TwwDBGrid(TForm(Owner).Components[i]).DataSource.DataSet.AfterOpen;
        end;

        TwwDBGrid(TForm(Owner).Components[i]).DataSource.DataSet.AfterOpen := Initialise;
        TwwDBGrid(TForm(Owner).Components[i]).OnKeyDown := grdKeyDown;
        Inc(GridDataSetsCount);
        Result := true;
      end;
  end else begin
    Result := true;
  end;
end;

{ tpersonaltabs.Initialise --------------------------}
procedure tpersonaltabs.Initialise(ds: TDataSet);
var 
  qryForms, qryControls, qryPersonalTabs: TERPQuery;
  i, j: integer;
  liRecord: pliRecord;
begin
  if Assigned(ds) then begin
    // get here if Initailse was called by a DataSets AfterOpen event
    CallAfterOpenEvent(ds); // fire off the original notify event for this dataset if ti exists
  end;

  Dec(GridDataSetsCount);
{ TODO 1 :
we assume here that all Grid related DataSets
are opened before the form gets presented to the user:
only the last OpenDataSet triggers init of personaltabStops }

  if GridDataSetsCount > 0 then Exit;
  qryForms := TERPQuery.Create(nil);
  qryControls := TERPQuery.Create(nil);
  qryPersonalTabs := TERPQuery.Create(nil);
  try
    qryForms.Connection := MyDacConnection;
    qryForms.SQL.Text   := Format('SELECT FormID FROM tblForms WHERE FormName = ''%s''', [TForm(Owner).ClassName]);
    try
      // get FormID for owner
      qryForms.Open;
      if qryForms.RecordCount <> 1 then Exit;
      //      raise Exception.CreateFmt('Could not read tblForms: %s', [TForm(Owner).ClassName]);
      formID := qryForms.FieldByName('FormID').AsInteger;
      qryForms.Close;

      qryControls.Connection := MyDacConnection;
//      qryControls.LockType := ltOptimistic;
      qryControls.Close;
      qryControls.SQL.Text := Format('SELECT ControlID, FormID, ControlName ' + 'FROM tblControls WHERE FormID = %d',
        [formID]);
      qryControls.Open;

      qryPersonalTabs.Connection := MyDacConnection;
//      qryPersonalTabs.LockType := ltOptimistic;
      qryPersonalTabs.Close;
      qryPersonalTabs.SQL.Text := Format('SELECT EmployeeID, ControlID, FieldName, TabStop ' +
        'FROM tblPersonalTabs WHERE EmployeeID = %d', [EmployeeID]);
      qryPersonalTabs.Open;
      if li.Count = 0 then begin
          ClearLi;
          for i := 0 to TForm(Owner).ComponentCount - 1 do if TForm(Owner).Components[i] is TWinControl then begin
              // WinControls introduce TabStops
              New(liRecord);
              liRecord.control := TWinControl(TForm(Owner).Components[i]);
              liRecord.FieldName := '';
              liRecord.DefaultTS := liRecord.control.TabStop;
              // either read or create entry in tblControls so we have a unique ID
              if not qryControls.Locate('ControlName', liRecord.Control.Name, [loCaseInsensitive]) then begin
                UnlockTables;
                qryControls.Insert;
                qryControls.FieldByName('FormID').AsInteger := formID;
                qryControls.FieldByName('ControlName').AsString := liRecord.Control.Name;
                qryControls.Post;
                if not qryControls.Locate('ControlName', liRecord.Control.Name, [loCaseInsensitive]) then
                  raise Exception.CreateFmt('Could not reread tblControls: FormId: %1d ControlName: %s',
                    [formID, liRecord.Control.Name]);
              end;                      // add to List
              liRecord.ControlID := qryControls.FieldByName('ControlID').AsInteger;
              // set TabStops
              if qryPersonalTabs.Locate('ControlID;FieldName', VarArrayOf([liRecord.ControlID, '']), [loCaseInsensitive]) then
                liRecord.Control.TabStop := qryPersonalTabs.FieldByName('TabStop').AsString = 'T';
              li.Add(liRecord);           // add settings to our list
              {check if control is grid and store columns}
              if liRecord.Control is TwwDBGrid then for j := 0 to TwwDBGrid(liRecord.Control).DataSource.DataSet.FieldCount - 1 do
                begin
                  New(liRecord);
                  liRecord.ControlID := qryControls.FieldByName('ControlID').AsInteger;
                  liRecord.control := TWinControl(TForm(Owner).Components[i]);
                  liRecord.FieldName := TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].FieldName;

                  // set TabStops in Grid
                  liRecord.DefaultTS := not TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].ReadOnly;

                  if liRecord.DefaultTS then
                    liRecord.DefaultTS := (TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].FieldKind <> fkCalculated);

                  // initialise tags
                  if liRecord.DefaultTS then begin
                    TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag := TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag or TAG_MASK_PT;
                  end else begin
                    TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag := TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag and (not TAG_MASK_PT);
                  end;

                  if qryPersonalTabs.Locate('ControlID;FieldName',
                    VarArrayOf([liRecord.ControlID, TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].FieldName]), [loCaseInsensitive]) then
                    if qryPersonalTabs.FieldByName('TabStop').AsString = 'T' then begin
                      TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag := TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag or TAG_MASK_PT;
                    end else begin
                      TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag := TwwDBGrid(liRecord.Control).DataSource.DataSet.Fields[j].Tag and (not TAG_MASK_PT);
                    end;

                  li.Add(liRecord);           // add settings to our list
                end;
            end;
      end;
      Finitialised := true;
    except 
      on e: Exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + ' Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    FreeAndNil(qryForms);
    FreeAndNil(qryControls);
    FreeAndNil(qryPersonalTabs);
  end;
end; //Initialise

procedure tpersonaltabs.drawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
var 
  r: TRect;
  ix: integer;
begin
  with TwwDBGrid(Sender) do begin
    DefaultDrawDataCell(Rect, Field, State);
    for ix := 0 to FieldCount - 1 do if Fields[ix] = Field then Break;
    if (Fields[ix].Tag and TAG_MASK_PT) = TAG_MASK_PT then //    if TabStops[ix] then
      Canvas.Brush.Color := clGreen
    else Canvas.Brush.Color := clYellow;
    r     := Rect;
    r.Top := r.Top + 1;
    Canvas.FrameRect(r);
  end;
end;

procedure tpersonaltabs.grdKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  startCol, nextCol: integer;
  indicatorCol: integer;
  nextRow, First: boolean;
begin
  if wwDBIGrd.dgIndicator in TwwDBGrid(Sender).Options then indicatorCol := 1
  else indicatorCol := 0;
  startCol := TwwDBGrid(Sender).GetActiveCol;
  nextCol := startCol;
  nextrow := false;
  if Key = VK_TAB then begin
    if ssShift in Shift then begin
      First := true;
      while First or ((TwwDBGrid(Sender).Fields[nextCol - indicatorCol] = nil) or
        ((TwwDBGrid(Sender).Fields[nextCol - indicatorCol].Tag and TAG_MASK_PT) <> TAG_MASK_PT)) and
        (nextCol <> startCol) do begin
        Dec(nextCol);
        if nextCol - indicatorCol < 0 then begin
          nextCol := TwwDBGrid(Sender).GetColCount - indicatorCol;
          nextRow := true;
        end;
        First := false;
      end;
      TwwDBGrid(Sender).SetActiveField(TwwDBGrid(Sender).Fields[nextCol - indicatorCol].FieldName);
      if nextRow then key := VK_UP
      else key := 0;
    end else begin
      First := true;
      while First or ((TwwDBGrid(Sender).Fields[nextCol - indicatorCol] = nil) or
        ((TwwDBGrid(Sender).Fields[nextCol - indicatorCol].Tag and TAG_MASK_PT) <> TAG_MASK_PT)) and
        (nextCol <> startCol) do begin
        Inc(nextCol);
        if nextCol + indicatorCol > TwwDBGrid(Sender).GetColCount then begin
          nextCol := indicatorCol;
          nextRow := true;
        end;
        First := false;
      end;
      TwwDBGrid(Sender).SetActiveField(TwwDBGrid(Sender).Fields[nextCol - indicatorCol].FieldName);
      if nextRow then key := VK_DOWN
      else key := 0;
    end
  end;
end; //grdKeyDown


procedure tpersonaltabs.TabStopsOnOff(var Msg: tagMSG; var Handled: boolean);
var
  control: TWinControl;
  Shape: TShape;
  coord: TGridCoord;
  xpos, ypos: integer;
  // to pick the control which has hw as Handle
  function getControl(hw: THandle): TWinControl;
  var
    i: integer;
  begin
    Result := nil;
    for i := 0 to Owner.ComponentCount - 1 do if Owner.Components[i] is TWinControl then
        if TWinControl(Owner.Components[i]).Handle = hw then begin
          Result := TWinControl(Owner.Components[i]);
          Exit;
        end;
  end; //getControl
       // add rectangles to the form (they are displayed behind the wincontrols)
       // so they appear like a frame
  procedure addShape;
  var
    i: integer;
    ctl: TWinControl;
  begin
    for i := 0 to Owner.ComponentCount - 1 do if (Owner.Components[i] is TWinControl) then begin
        ctl := TWinControl(Owner.Components[i]);
        if ctl.Visible then begin
          Shape := TShape.Create(ctl);
          Shape.Pen.Width := 2;
          Shape.Brush.Style := bsClear;
//          ctl.Tag := integer(Shape);     // use tag to maintain link
          Shape.Top := ctl.Top - 2;
          Shape.Left := ctl.Left - 2;
          Shape.Width := ctl.Width + 4;
          Shape.Height := ctl.Height + 4;
          Shape.Tag := TAG_MASK_PTS;
          Shape.Parent := ctl.Parent;
          if ctl.TabStop then Shape.Pen.Color := clGreen
          else Shape.Pen.Color := clYellow;
        end;

        if Owner.Components[i] is TwwDBGrid then TwwDBGrid(Owner.Components[i]).OnDrawDataCell := drawDataCell;
      end;
  end; //addShape
       // get rid of the colored frames
  procedure RemoveShape(const AOwner: TComponent);
  var
    i: integer;
  begin
    for i := AOwner.ComponentCount - 1 downto 0 do begin
      if AOwner.Components[i].ComponentCount > 0 then
        RemoveShape(AOwner.Components[i]);

      if (AOwner.Components[i] is TShape) and ((AOwner.Components[i].Tag and TAG_MASK_PTS) = TAG_MASK_PTS) then begin
        TShape(AOwner.Components[i]).Parent := nil;
        TShape(AOwner.Components[i]).Free;
      end else if AOwner.Components[i] is TwwDBGrid then
        TwwDBGrid(AOwner.Components[i]).OnDrawDataCell := nil;
    end
  end; //removeShape
begin

  if (Msg.Message = WM_KEYDOWN) then if (Msg.wParam = VK_SPACE) and (GetKeyState(VK_CONTROL) < 0) and
      (self.Initialised) then begin
      if not self.TabStopState then begin                          // activate State
        TabOrderFlag := 0;
        //RecordPrefsToMem; // Procedure to get CompanyPrefs table data and store to temporary table
        //SetAllPrefsToOn; // Procedure to set all checkboxes to selected in Preferences table.

        TabOrderFlag := 1; // Allow BaseSale.OnPaint to Add all grid fields regardless of preferences
        addShape;
        self.TabStopState := true;
      end else begin                 // deactivate State
        self.StorePrefs;
        RemoveShape(Owner);
        self.TabStopState := false;
        //RestorePrefsFromMem; // Procedure to Restore CompanyPrefs back to where they came from
        TabOrderFlag := 2;    // Allow BaseSale.OnPaint to set visible grid fields according to Prefereneces
      end;
      //  Owner.Repaint          // does not properly redraw twwRadioGroup (Transparent)
      Owner.SendToBack;      // so we do this ...
      Owner.BringToFront;
      Handled := true;
      Exit;
    end else begin
      Handled := self.TabStopState;
      Exit;
    end;

  if self.TabStopState and (Msg.Message = WM_LBUTTONDOWN) then begin
    control := getControl(Msg.hwnd);
    if control <> nil then begin
      if Assigned(FindShape(control)) then begin
        if control.ClassType <> TwwDBGrid then begin
          Shape := FindShape(control);
          control.TabStop := not control.TabStop;
          if control.TabStop then Shape.Pen.Color := clGreen
          else Shape.Pen.Color := clYellow;
          control.Visible := false;           // twwRadioGroup - Transparent needs this
          control.Visible := true;
          Handled := true;
        end else begin
          xPos := LOWORD(Msg.lParam);  // horizontal position of cursor
          yPos := HIWORD(Msg.lParam);  // vertical position of cursor
          coord := TwwDBGrid(control).MouseCoord(xPos, yPos);

          if (coord.X > 0) and (coord.X <= TwwDBGrid(control).FieldCount) then begin
            if (TwwDBGrid(control).Fields[coord.X - 1].Tag and TAG_MASK_PT) = TAG_MASK_PT then
              TwwDBGrid(control).Fields[coord.X - 1].Tag := TwwDBGrid(control).Fields[coord.X - 1].Tag and (not TAG_MASK_PT)
            else
              TwwDBGrid(control).Fields[coord.X - 1].Tag := TwwDBGrid(control).Fields[coord.X - 1].Tag or TAG_MASK_PT;
            TwwDBGrid(control).Invalidate;
            TwwDBGrid(control).Update;
          end;

          Handled := true;
        end
      end;
    end;
  end;
end;

  // Searches the list for this datasource's name and , if found, fires off the
  // .. method
procedure tpersonaltabs.CallAfterOpenEvent(ds: TDataSet);
var
  pEvents: pAfterOpenRec;
  i: integer;
begin
  if Assigned(lstOpenEvents) then begin
    for i := 0 to lstOpenEvents.Count - 1 do begin
      pEvents := lstOpenEvents.Items[i];
      if CompareText(string(pEvents^.Name), ds.Name) = 0 then begin
        pEvents^.Event(ds);
      end;
    end;
  end;
end;

function tpersonaltabs.FindShape(const Control: TControl): TShape;
var
  Index: Integer;
  FoundShape: Boolean;
begin
  Result := nil;

  if Assigned(Control) then begin
    Index := 0;
    FoundShape := False;

    while (Index < Control.ComponentCount) and (not FoundShape) do begin
      if (Control.Components[Index].Tag and TAG_MASK_PTS) = TAG_MASK_PTS then begin
        Result := TShape(Control.Components[Index]);
        FoundShape := True;
      end
      else
        Inc(Index);
    end;
  end;
end;

end.
