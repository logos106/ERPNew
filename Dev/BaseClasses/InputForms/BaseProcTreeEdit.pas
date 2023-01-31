unit BaseProcTreeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls, StdCtrls,
  Shader, wwradiogroup, wwcheckbox, wwdblook, DNMSpeedButton, MessageConst,
  MyAccess,ERPdbComponents, AdvEdit, AdvGrid, NodePropertiesLink, DB, TypInfo;

type
  TGridKeydownEvent = procedure(Sender: TObject; var Key: Word;Shift: TShiftState) of object;
  TGridMouseUpEvent = Procedure(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of Object;
  TBaseProcTreeEditGUI = class(TBaseForm)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    FCallingControl: TWinControl;
    FPopupModified: Boolean;
    FSequenceUp: Integer;
    FSequenceDown: Integer;
    FNodePropLink: TNodePropertiesLink;
    fbDeletingRow:Boolean;
    procedure SaveTree;
    procedure SetSavePoint;
    procedure RollbackToSavePoint;
    procedure RemoveControlsLink;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    function RowEmpty(Sender :TObject):Boolean;
    Procedure DeleteEmptyrow;
  protected
    function GetControl(const Name: string): TControl;
    function GetPropertyName(const ControlName: string): string;
    function GetGridPropNames(const GridName: string): TStringList;
    procedure InitControls;
    procedure SetPropertyValue(Sender: TObject); virtual;
    procedure DisableGridColumnMove(Sender: TObject; ACol: Integer; var Allow: Boolean);
    procedure OnGridKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure OnGridMouseUP(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    Procedure OnCheckboxClick(Sender :TObject);
    procedure SaveGridToProps(const Grid: TAdvStringGrid);
    procedure LoadGridFromProps(const Grid: TAdvStringGrid); virtual;
    Procedure GridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: Integer;  var Allow: Boolean); virtual;
  public
    property PopupModified: Boolean read FPopupModified write FPopupModified;
    property NodePropLink: TNodePropertiesLink read FNodePropLink write FNodePropLink;
  end;

implementation

uses
  CommonDbLib, FastFuncs, TreeFrame, BusObjNDSBase, CommonLib, BaseGrid,
  FormEvents;

{$R *.dfm}

procedure TBaseProcTreeEditGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FCallingControl := nil;
  FPopupModified := False;
  FSequenceUp := 0;
  FSequenceDown := 0;
  FNodePropLink := nil;
  fbDeletingRow := False;
end;

function TBaseProcTreeEditGUI.GetControl(const Name: string): TControl;
var
  Index: Integer;
  FoundMatch: Boolean;
begin
  Result := nil;
  Index := Low(NodePropLink.PropControlItems);
  FoundMatch := False;

  while (Index <= High(NodePropLink.PropControlItems)) and (not FoundMatch) do begin
    if Sysutils.SameText(NodePropLink.PropControlItems[Index].Name, Name) then begin
      Result := TControl(FindComponent(NodePropLink.PropControlItems[Index].Control));
      FoundMatch := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TBaseProcTreeEditGUI.InitControls;
var
  Index: Integer;
  Control: TControl;
  PropName: string;
  PropObject: TNodeProperties;
  PER: PEventRec;
  InitialisedControls :Array of String;
  Function Alreadyinitialised(const controlName :STring) :Boolean ;
  Var
    Ctr :Integer;
  begin
    Result := False;
    For ctr := low(InitialisedControls) to high(InitialisedControls) do
        if Sysutils.SameText(InitialisedControls[ctr] ,controlName) then begin
            Result := True;
            Break;
        end;
    if not result then begin
        Setlength(InitialisedControls , high(InitialisedControls) +2);
        InitialisedControls[high(InitialisedControls)] := controlName;
    end;
  end;
begin
    if Assigned(NodePropLink) then begin
        NodePropLink.Loading := True;
        Setlength(InitialisedControls , 1);
        try
            for Index := Low(NodePropLink.PropControlItems) to High(NodePropLink.PropControlItems) do begin
                Control := GetControl(NodePropLink.PropControlItems[Index].Name);
                if Assigned(Control)  then begin
                    if (Control is TAdvStringGrid) then  begin
                        if  (not(Alreadyinitialised(TAdvStringGrid(Control).name))) then begin
                            if Assigned(TAdvStringGrid(Control).onKeydown) then begin
                                System.New(PER);
                                PER^.EventType:= on_keydown;
                                PER^.Name:= TAdvStringGrid(Control).Name;
                                PER^.Data:= TMethod(TAdvStringGrid(Control).onKeyDown).Data;
                                PER^.Code:= TMethod(TAdvStringGrid(Control).onKeydown).Code;
                                EventList.Add(PER);
                            end;
                            if Assigned(TAdvStringGrid(Control).onMouseup) then begin
                                System.New(PER);
                                PER^.EventType:= on_MouseUP;
                                PER^.Name:= TAdvStringGrid(Control).Name;
                                PER^.Data:= TMethod(TAdvStringGrid(Control).onMouseup).Data;
                                PER^.Code:= TMethod(TAdvStringGrid(Control).onMouseup).Code;
                                EventList.Add(PER);
                            end;
                            TAdvStringGrid(Control).OnExit          := SetPropertyValue;
                            TAdvStringGrid(control).OnCellChanging  := gridCellChanging;
                            TAdvStringGrid(control).onKeyDown       := OngridKeyDown;
                            TAdvStringGrid(Control).onColumnMove    := DisableGridColumnMove;
                            TAdvStringGrid(control).onMouseUP       := OnGridMouseUP;
                            LoadGridFromProps(TAdvStringGrid(Control));
                        end;
                    end else if not (Control is TDNMSpeedButton) then begin
                        PropObject := nil;
                        PropName := GetPropertyName(Control.Name);
                        if PropName <> '' then begin
                          if IsPublishedProp(NodePropLink, PropName) then begin
                            PropObject := TNodeProperties(GetObjectProp(NodePropLink, PropName));

                            if Assigned(PropObject) then
                              PropObject.ControlLink := Control;
                          end;
                        end;

                        if Assigned(PropObject) then begin
                            if (Control is TwwRadioGroup) then begin
                                if (not(Alreadyinitialised(TwwRadioGroup(Control).name))) then begin
                                    TwwRadioGroup(Control).OnClick := SetPropertyValue;
                                    TwwRadioGroup(Control).ItemIndex := StrToIntDef(PropObject.Value, -1);
                                end;
                            end else if (Control is TAdvEdit) then begin
                                if (not(Alreadyinitialised(TAdvEdit(Control).name))) then begin
                                    TAdvEdit(Control).OnExit := SetPropertyValue;
                                    TAdvEdit(Control).Text := PropObject.Value;
                                end;
                            end else if (Control is TMemo) then begin
                                if (not(Alreadyinitialised(TMemo(Control).name))) then begin
                                    TMemo(Control).OnExit := SetPropertyValue;
                                    TMemo(Control).Lines.Text := PropObject.Value;
                                end;
                            end else if (Control is TwwCheckBox) then begin
                                if  (not(Alreadyinitialised(TwwCheckBox(Control).name))) then begin
                                    if Assigned(TAdvStringGrid(Control).onclick) then begin
                                        System.New(PER);
                                        PER^.EventType:= on_click;
                                        PER^.Name:= TAdvStringGrid(Control).Name;
                                        PER^.Data:= TMethod(TAdvStringGrid(Control).onclick).Data;
                                        PER^.Code:= TMethod(TAdvStringGrid(Control).onclick).Code;
                                        EventList.Add(PER);
                                    end;
                                    TwwCheckBox(Control).OnClick := OnCheckboxClick;
                                    TwwCheckBox(Control).Checked := Sysutils.SameText(PropObject.Value, 'T');
                                end;
                            end else if (Control is TwwDBLookupCombo) then begin
                                if (not(Alreadyinitialised(TwwDBLookupCombo(Control).name))) then begin
                                    TwwDBLookupCombo(Control).OnChange := SetPropertyValue;
                                    TwwDBLookupCombo(Control).Text := PropObject.Value;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        finally
            NodePropLink.Loading := False;
        end;
    end;
end;

procedure TBaseProcTreeEditGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveTree;
  ModalResult := mrOK;
end;

procedure TBaseProcTreeEditGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TBaseProcTreeEditGUI.PerformStartup(var Msg: TMessage);
begin
  if Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) and Assigned(NodePropLink.PropControlItems) then begin
    FCallingControl := FindControl(Msg.wParam);
    InitControls;
    SaveTree;
    FSequenceUp := NodePropLink.BaseTreeNode.SequenceUp;
    FSequenceDown := NodePropLink.BaseTreeNode.SequenceDown;
    SetSavePoint;
  end;
end;

procedure TBaseProcTreeEditGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Response: TModalResult;
begin
  inherited;
    DeleteEmptyrow;
  if Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) and
     (NodePropLink.BaseTreeNode.TreeDirty or PopupModified) and (ModalResult <> mrOK) then begin
    Response := CommonLib.MessageDlgXP_Vista('Save any changes made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

    case Response of
      mrYes:
      begin
        SaveTree;
        ModalResult := mrOK;
      end;

      mrNo:
      begin
        RollbackToSavePoint;
        NodePropLink.BaseTreeNode.Children.Clear;
        NodePropLink.BaseTreeNode.SequenceUp := FSequenceUp;
        NodePropLink.BaseTreeNode.SequenceDown := FSequenceDown;
        NodePropLink.BaseTreeNode.LoadTree(True);
        NodePropLink.RefreshListNodes;
        ModalResult := mrCancel;
      end;

      mrCancel:
      begin
        CanClose := False;
      end;
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.SetSavePoint;
var
  qrySave: TERPQuery;
begin
  if Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) and
     NodePropLink.BaseTreeNode.Storer.Connection.Intransaction then begin
    qrySave := TERPQuery.Create(Self);

    try
      qrySave.Options.FlatBuffers := True;
      qrySave.Connection := NodePropLink.BaseTreeNode.Storer.Connection;
      qrySave.SQL.Text := 'SAVEPOINT ' + Name;
      qrySave.Execute;
    finally
      FreeAndNil(qrySave);
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.RollbackToSavePoint;
var
  qryRollback: TERPQuery;
begin
  if Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) and
     NodePropLink.BaseTreeNode.Storer.Connection.Intransaction then begin
    qryRollback := TERPQuery.Create(Self);

    try
      qryRollback.Options.FlatBuffers := True;
      qryRollback.Connection := NodePropLink.BaseTreeNode.Storer.Connection;
      qryRollback.SQL.Text := 'ROLLBACK TO SAVEPOINT ' + Name;
      qryRollback.Execute;
    finally
      FreeAndNil(qryRollback);
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.SaveTree;
begin
  if Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) and Assigned(FCallingControl) then begin
    if NodePropLink.BaseTreeNode.TreeDirty or FPopupModified then begin
      if FCallingControl is TBaseProcTreeEditGUI then
        TBaseProcTreeEditGUI(FCallingControl).PopupModified := True
      else if FCallingControl is TframeTree then
        TframeTree(FCallingControl).PopupModified := True;
    end;

    NodePropLink.BaseTreeNode.RootNode.Save;
  end;
end;
Procedure TBaseProcTreeEditGUI.GridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: Integer;  var Allow: Boolean);
begin
    if fbDeletingRow then exit;
    SetPropertyValue(Sender);
    LoadGridFromProps(TAdvStringGrid(sender));
end;
procedure TBaseProcTreeEditGUI.DisableGridColumnMove(Sender: TObject; ACol: Integer; var Allow: Boolean);
begin
    Allow := false;
end;
Procedure TBaseProcTreeEditGUI.OnCheckboxClick(Sender:TObject);
var
    EventRec: TFormEventRec;
    NotifyEvent: TNotifyEvent;
begin
    NotifyEvent := nil;
    if Self.GetEventRec(EventRec, TwwCheckBox(Sender).Name, on_click) then  begin
          TMethod(NotifyEvent).Data:= EventRec.Data;
          TMethod(NotifyEvent).Code:= EventRec.Code;
          NotifyEvent(Sender);
    end;
    SetPropertyValue(Sender);
end;
procedure TBaseProcTreeEditGUI.OnGridMouseUP(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    EventRec: TFormEventRec;
    NotifyEvent: TGridMouseUpEvent;
    ARow: Integer;
    ACol: Integer;
begin
    fbDeletingRow := true;
    try
        TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);

        if (ACol = 0) and (ARow = 0) then begin
            if TAdvStringGrid(Sender).RowCount > TAdvStringGrid(Sender).Fixedrows+1 then begin
                TAdvStringGrid(Sender).RemoveRows(TAdvStringGrid(Sender).Row, 1);
            end else begin
                TAdvStringGrid(Sender).ClearRows(1, 1);
            end;
        end;
        NotifyEvent := nil;
        if Self.GetEventRec(EventRec, TAdvStringgrid(Sender).Name, on_MouseUP) then  begin
          TMethod(NotifyEvent).Data:= EventRec.Data;
          TMethod(NotifyEvent).Code:= EventRec.Code;
          NotifyEvent(Sender ,Button,Shift, X, Y);
        end;
    finally
        fbDeletingRow := false;
    end;
end;
Procedure TBaseProcTreeEditGUI.DeleteEmptyrow;
var
    ctr:Integer;
    x :Integer;
begin
    For ctr := 0 to ComponentCount-1 do begin
        if Components[ctr] is TAdvStringGrid then begin
            if TAdvStringGrid(Components[ctr]).FixedRows < TAdvStringGrid(Components[ctr]).rowcount then
                for x := TAdvStringGrid(Components[ctr]).FixedRows to TAdvStringGrid(Components[ctr]).RowCount-1 do begin
                    TAdvStringGrid(Components[ctr]).Row := x;
                    if RowEmpty(TAdvStringGrid(Components[ctr])) then
                        TAdvStringGrid(Components[ctr]).RemoveRows(x, 1);
                end;
        end;
    end;

end;
Function TBaseProcTreeEditGUI.RowEmpty (Sender: TObject):Boolean;
    var
        ctr:Integer;
begin
    REsult := True;
    for ctr := TAdvStringGrid(Sender).FixedCols to TAdvStringGrid(Sender).colcount-1 do
      if (TAdvStringGrid(Sender).Cells[ctr,TAdvStringGrid(Sender).Row] <> '') and
        (TAdvStringGrid(Sender).Cells[ctr,TAdvStringGrid(Sender).Row] <> '0') and
        (TAdvStringGrid(Sender).Cells[ctr,TAdvStringGrid(Sender).Row] <> '0.0') then begin
          REsult := False;
          Break;
      end;
end;

procedure TBaseProcTreeEditGUI.OnGridKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var
    EventRec: TFormEventRec;
    NotifyEvent: TGridKeydownEvent;
begin
    NotifyEvent := nil;
    {stop adding empty rows}
    if TAdvStringGrid(Sender).Row = (TAdvStringGrid(Sender).RowCount - 1) then begin
        if (Key = VK_DOWN) and not(RowEmpty(Sender)) then begin
            TAdvStringGrid(Sender).AddRow;
            TAdvStringGrid(Sender).Row := TAdvStringGrid(Sender).Row + 1;
        end else if (Key = VK_TAB) and
            (TAdvStringGrid(Sender).Col = (TAdvStringGrid(Sender).ColCount - 1)) and
            (not(RowEmpty(Sender))) then begin
            TAdvStringGrid(Sender).AddRow;
            TAdvStringGrid(Sender).Row := TAdvStringGrid(Sender).Row + 1;
            TAdvStringGrid(Sender).Col := 1;
        end;
    end;
    if Self.GetEventRec(EventRec, TAdvStringgrid(Sender).Name, on_KeyDown) then  begin
      TMethod(NotifyEvent).Data:= EventRec.Data;
      TMethod(NotifyEvent).Code:= EventRec.Code;
      NotifyEvent(Sender , Key, shift);
    end;
end;
procedure TBaseProcTreeEditGUI.SetPropertyValue(Sender: TObject);
var
  PropName: string;
  PropValue: string;
  PropObject: TNodeProperties;
begin
  if Assigned(NodePropLink) then begin
    if Sender is TAdvStringGrid then
      SaveGridToProps(TAdvStringGrid(Sender))
    else begin
      PropName := GetPropertyName(TControl(Sender).Name);

      if PropName <> '' then begin
        if Sender is TwwRadioGroup then
          PropValue := IntToStr(TwwRadioGroup(Sender).ItemIndex)
        else if Sender is TAdvEdit then
          PropValue := TAdvEdit(Sender).Text
        else if Sender is TMemo then
          PropValue := TMemo(Sender).Lines.Text
        else if Sender is TwwCheckBox then begin
          if TwwCheckBox(Sender).Checked then
            PropValue := 'T'
          else
            PropValue := 'F';
        end
        else if Sender is TwwDBLookupCombo then
          PropValue := TwwDBLookupCombo(Sender).Text
        else
          PropValue := '';

        PropObject := TNodeProperties(GetObjectProp(NodePropLink, PropName));

        if Assigned(PropObject) then
          SetStrProp(PropObject, 'Value', PropValue);
      end;
    end;
  end;
end;

function TBaseProcTreeEditGUI.GetPropertyName(const ControlName: string): string;
var
  Index: Integer;
  FoundMatch: Boolean;
begin
  Result := '';

  if Assigned(NodePropLink.PropControlItems) then begin
    FoundMatch := False;
    Index := Low(NodePropLink.PropControlItems);

    while (Index <= High(NodePropLink.PropControlItems)) and (not FoundMatch) do begin
      if Sysutils.SameText(ControlName, NodePropLink.PropControlItems[Index].Control) then begin
        Result := NodePropLink.PropControlItems[Index].Name;
        FoundMatch := True;
      end
      else
        Inc(Index);
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.SaveGridToProps(const Grid: TAdvStringGrid);
var
  ColIndex: Integer;
  RowIndex: Integer;
  PropNames: TStringList;
  PropObject: TNodePropertiesList;
begin
  if Assigned(Grid) then begin
    PropNames := GetGridPropNames(Grid.Name);

    try
      for ColIndex := 0 to PropNames.Count - 1 do begin
        PropObject := TNodePropertiesList(GetObjectProp(NodePropLink, PropNames[ColIndex]));

        if Assigned(PropObject) then begin
          for RowIndex := 0 to Grid.RowCount - 2 do
            PropObject[RowIndex].Value := Grid.Cells[ColIndex + 1, RowIndex + 1];
        end;

        while (Grid.RowCount - 1) < PropObject.NodePropsCount do
          PropObject.DeleteNodeProp(PropObject.NodePropsCount - 1);
      end;
    finally
      FreeAndNil(PropNames);
    end;
  end;
end;

function TBaseProcTreeEditGUI.GetGridPropNames(const GridName: string): TStringList;
var
  Index: Integer;
begin
  Result := TStringList.Create;

  if Assigned(NodePropLink) and Assigned(NodePropLink.PropControlItems) then begin
    for Index := Low(NodePropLink.PropControlItems) to High(NodePropLink.PropControlItems) do begin
      if Sysutils.SameText(NodePropLink.PropControlItems[Index].Control, GridName) then
        Result.Add(NodePropLink.PropControlItems[Index].Name);
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.LoadGridFromProps(const Grid: TAdvStringGrid);
var
  ColIndex: Integer;
  RowIndex: Integer;
  PropNames: TStringList;
  PropObject: TNodePropertiesList;
begin
  if Assigned(Grid) then begin
    PropNames := GetGridPropNames(Grid.Name);

    try
      for ColIndex := 0 to PropNames.Count - 1 do begin
        PropObject := TNodePropertiesList(GetObjectProp(NodePropLink, PropNames[ColIndex]));

        if Assigned(PropObject) then begin
          for RowIndex := 0 to PropObject.NodePropsCount - 1 do begin
            if Grid.RowCount < (RowIndex + 2) then
              Grid.AddRow;

            Grid.Cells[ColIndex + 1, RowIndex + 1] := PropObject[RowIndex].Value;
          end;
        end;
      end;
    finally
      FreeAndNil(PropNames);
    end;
  end;
end;

procedure TBaseProcTreeEditGUI.FormDestroy(Sender: TObject);
begin
  RemoveControlsLink;
  inherited;
end;

procedure TBaseProcTreeEditGUI.RemoveControlsLink;
var
  Index: Integer;
  PropName: string;
  PropObject: TNodeProperties;
begin
  if Assigned(NodePropLink) and (not (csDestroying in NodePropLink.ComponentState)) then begin
    for Index := Low(NodePropLink.PropControlItems) to High(NodePropLink.PropControlItems) do begin
      PropName := NodePropLink.PropControlItems[Index].Name;

      if PropName <> '' then begin
        if IsPublishedProp(NodePropLink, PropName) then begin

          if GetObjectPropClass(NodePropLink, PropName) = TNodeProperties then begin
            PropObject := TNodeProperties(GetObjectProp(NodePropLink, PropName));

            if Assigned(PropObject) then
              PropObject.ControlLink := nil;
          end;
        end;
      end;
    end;  
  end;
end;

end.
