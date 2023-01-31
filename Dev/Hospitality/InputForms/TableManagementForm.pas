unit TableManagementForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ImgList,
  Buttons, DNMSpeedButton, StdCtrls, ComCtrls, ExtCtrls, DNMPanel, TableCreatorComp, 
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, DBCtrls, wwdblook, rwButtonArray,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS;

type
  TfrmTableManagement = class(TBaseInputGUI)
    pcOptions: TPageControl;
    tabGeneral: TTabSheet;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    txtNumOfXCells: TEdit;
    udGridXCells: TUpDown;
    txtNumOfYCells: TEdit;
    udGridYCells: TUpDown;
    btnClear: TDNMSpeedButton;
    cboTemplates: TComboBox;
    btnSaveTemplate: TDNMSpeedButton;
    btnDelTemplate: TDNMSpeedButton;
    tabInfo: TTabSheet;
    DNMPanel2: TDNMPanel;
    Label6: TLabel;
    Label9: TLabel;
    edtCellID: TEdit;
    edtMaxSeating: TEdit;
    udMaxSeating: TUpDown;
    dsFloorPlan: TDataSource;
    qryFloorPlan: TERPQuery;
    qryFloorPlanRoomPlanName: TWideStringField;
    dsTemplates: TDataSource;
    qryTemplatePlan: TERPQuery;
    StringField1: TWideStringField;
    ColorDialog1: TColorDialog;
    qryDeleteFloorPlan: TERPQuery;
    StringField2: TWideStringField;
    qryDeleteTemplatePlan: TERPQuery;
    StringField3: TWideStringField;
    btnClose: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    BasicTables1: TBasicTables;
    Label11: TLabel;
    Edit1: TEdit;
    udTableID: TUpDown;
    Label10: TLabel;
    edtComments: TEdit;
    btnTableStatus: TDNMSpeedButton;
    Label4: TLabel;
    qryRooms: TERPQuery;
    dsFuncRooms: TDataSource;
    cboRoomName: TwwDBLookupCombo;
    qryFuncRooms2: TERPQuery;
    dsFuncRooms2: TDataSource;
    btnSaveRoomData: TDNMSpeedButton;
    qryTableCustomers: TERPQuery;
    ImageList1: TImageList;
    Bevel1: TBevel;
    Label3: TLabel;
    sbIdle: TDNMSpeedButton;
    sbClear: TDNMSpeedButton;
    sbInfo: TDNMSpeedButton;
    sbPlaceTable: TDNMSpeedButton;
    btnMoveTable: TDNMSpeedButton;
    sbWall: TDNMSpeedButton;
    Label5: TLabel;
    btnCanvasColour: TDNMSpeedButton;
    SetStatusTextColour: TDNMSpeedButton;
    btnCellCursorColour: TDNMSpeedButton;
    btnSetWallColour: TDNMSpeedButton;
    Bevel2: TBevel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtNumOfXCellsChange(Sender: TObject);
    procedure txtNumOfYCellsChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDelTemplateClick(Sender: TObject);
    procedure cboTemplatesSelect(Sender: TObject);
    procedure btnSaveTemplateClick(Sender: TObject);
    procedure BasicTables1GridNotOccupied;
    procedure BasicTables1GridOccupied;
    procedure BasicTables1StatusChange(PrevMode, CurrentMode: TEditMode);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure BasicTables1CellSelected(CellID: integer; CellInfo: TCellInfo);
    procedure btnTableStatusClick(Sender: TObject);
    procedure DNMPanel3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure BasicTables1TableMoved(CellID: integer; CellInfo: PCellInfo);
    procedure Edit1Change(Sender: TObject);
    procedure edtCellIDChange(Sender: TObject);
    procedure edtMaxSeatingChange(Sender: TObject);
    procedure edtCommentsChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure BasicTables1CellUpdate(CellID: integer);
    procedure udGridXCellsChangingEx(Sender: TObject; var AllowChange: boolean; NewValue: smallint;
      Direction: TUpDownDirection);
    procedure cboRoomsCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboRoomNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure sbIdleclick(Sender: TObject);
    procedure sbPlaceTableclick(Sender: TObject);
    procedure sbClearclick(Sender: TObject);
    procedure sbWallclick(Sender: TObject);
    procedure sbInfoclick(Sender: TObject);
    procedure btnSaveRoomDataClick(Sender: TObject);
    procedure btnMoveTableclick(Sender: TObject);
    procedure btnCanvasColourclick(Sender: TObject);
    procedure btnCellCursorColourclick(Sender: TObject);
    procedure btnSetWallColourclick(Sender: TObject);
    procedure btnSetStatusTextColourclick(Sender: TObject);
    procedure BasicTables1DblClick(CellID: integer; CellInfo: TCellInfo);
    procedure BasicTables1TablePlaced(CellID: Integer;
      CellInfo: PCellInfo);

  private
    { Private declarations }
    MyCellInfo: TCellInfo;
    procedure BuildTemplateNames;
//    procedure GetTableImageListsDLL;
  public
    { Public declarations }
  end;

  TGetImageListFunc = function : TImageList;

const
  ROOM_NAME: string = 'Roomdata';



implementation

uses FastFuncs,DNMExceptions,StatusEditorForm,
  CommonLib;

{$R *.dfm}

procedure TfrmTableManagement.FormCreate(Sender: TObject);
begin
  inherited;
  BasicTables1.ShowScrollBars := false;
  pcOptions.ActivePage := tabGeneral;
  tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BringToFront;
end;

procedure TfrmTableManagement.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  frmTableManagement := nil;
end;

procedure TfrmTableManagement.txtNumOfXCellsChange(Sender: TObject);
begin
  inherited;
  // Set the number of X Cells.
  BasicTables1.NumOfXCells := Trunc(StrValue(txtNumOfXCells.Text));
end;

procedure TfrmTableManagement.txtNumOfYCellsChange(Sender: TObject);
begin
  inherited;
  // Set the number of Y Cells.
  BasicTables1.NumOfYCells := Trunc(StrValue(txtNumOfYCells.Text));
end;

procedure TfrmTableManagement.btnClearClick(Sender: TObject);
begin
  inherited;
  BasicTables1.ClearGrid;
end;

procedure TfrmTableManagement.btnDelTemplateClick(Sender: TObject);
begin
  inherited;
  with qryDeleteFloorPlan do begin
    SQL.Clear;
    SQL.Add('DELETE FROM tbltablemanagementtemplates');
    SQL.Add('WHERE (RoomPlanName = :RoomName)');
    ParamByName('RoomName').asString := cboTemplates.Text;
    Execute;
  end;

  cboTemplates.Text := '';
  qryRooms.Close;
  qryFuncRooms2.Close;
  qryRooms.Open;
  qryFuncRooms2.Open;
  BuildTemplateNames;
end;

procedure TfrmTableManagement.cboTemplatesSelect(Sender: TObject);
//var
//  strOldStatus: string;
//  OldCursor: TCursor;
//  OldMode: TEditMode;
begin
  inherited;
//  OldCursor := Self.Cursor;
//  try
//    // Set cursor state to busy.
//    Self.Cursor := crHourGlass;
//    // Initialise Component before Loading Template Data.
//    BasicTables1.PlanName := cboTemplates.Text;
//    strOldStatus := BasicTables1.StatusText;
//    OldMode := BasicTables1.EditMode;
//    // Set Status Mode to busy.
//    BasicTables1.EditMode := emBusy;
//
//    // Retrieve Template Data.
//    BasicTables1.LoadTemplateRoomData;
//
//    // Restore Mode to previous setting.
//    BasicTables1.EditMode   := OldMode;
//    BasicTables1.StatusText := strOldStatus;
//    udGridXCells.Position   := BasicTables1.NumOfXCells;
//    udGridYCells.Position   := BasicTables1.NumOfYCells;
//  finally
//    // Restore our cursor state.
//    Self.Cursor := OldCursor;
//  end;
end;

procedure TfrmTableManagement.btnSaveTemplateClick(Sender: TObject);
//var
//  strOldStatus: string;
//  strCurTemplateName: string;
//  OldCursor: TCursor;
begin
  inherited;
//  strOldStatus := BasicTables1.StatusText;
//  strCurTemplateName := cboTemplates.Text;
//  OldCursor := Self.Cursor;
//  Self.Cursor := crHourGlass;
//  // Ensure a template name has been provided before we Save.
//  if strCurTemplateName = '' then begin
//    // No template name, then report error to user.
//    CommonLib.MessageDlgXP_Vista('You have not specified a template name to use for this design.  Please specify and try again.',
//      mtWarning, [mbOK], 0);
//    SetControlFocus(cboTemplates);
//    // NO more we can do here, so exit.
//    Exit;
//  end;
//
//  try
//    // Set our Plan Name before saving.
//    BasicTables1.PlanName   := cboTemplates.Text;
//    BasicTables1.IsTemplate := true;
//    if not BasicTables1.SaveRoomData then begin
//      // Report Error to user.
//      CommonLib.MessageDlgXP_Vista('Failed to Save room template data!', mtWarning, [mbOK], 0);
//    end else begin
//      // Requery the database to show new list.
//      qryFloorPlan.Close;
//      qryFloorPlan.Open;
//      qryTemplatePlan.Close;
//      qryTemplatePlan.Open;
//
//      // Reestablish List.
//      BuildTemplateNames;
//    end;
//  finally
//    BasicTables1.StatusText := strOldStatus;
//    cboTemplates.Text := strCurTemplateName;
//    Self.Cursor := OldCursor;
//  end;
end;

procedure TfrmTableManagement.BasicTables1GridNotOccupied;
begin
  inherited;
  if Assigned(Label1) then Label1.Enabled := true;
  if Assigned(txtNumOfXCells) then txtNumOfXCells.Enabled := true;
  if Assigned(udGridXCells) then udGridXCells.Enabled := true;
  if Assigned(Label2) then Label2.Enabled := false;
  if Assigned(txtNumOfYCells) then txtNumOfYCells.Enabled := false;
  if Assigned(udGridYCells) then udGridYCells.Enabled := false;
end;

procedure TfrmTableManagement.BasicTables1GridOccupied;
begin
  inherited;
  if Assigned(Label1) then Label1.Enabled := false;
  if Assigned(txtNumOfXCells) then txtNumOfXCells.Enabled := false;
  if Assigned(udGridXCells) then udGridXCells.Enabled := false;
  if Assigned(Label2) then Label2.Enabled := false;
  if Assigned(txtNumOfYCells) then txtNumOfYCells.Enabled := false;
  if Assigned(udGridYCells) then udGridYCells.Enabled := false;
end;

procedure TfrmTableManagement.BasicTables1StatusChange(PrevMode, CurrentMode: TEditMode);
begin
  inherited;
  // If the previous mode is the same as the
  // current new mode then dont bother.
  if PrevMode = CurrentMode then Exit;

  // Editor Idle Mode
  if CurrentMode = emIdle then begin
    sbIdleclick(nil);
  end;
end;

procedure TfrmTableManagement.BuildTemplateNames;
begin
  qryTemplatePlan.Close;
  qryTemplatePlan.Open;
  qryTemplatePlan.First;
  cboTemplates.Items.Clear;
  while not qryTemplatePlan.Eof do begin
    cboTemplates.Items.Add(qryTemplatePlan.FieldByName('RoomPlanName').AsString);
    qryTemplatePlan.Next;
  end;
end;

procedure TfrmTableManagement.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;
      Setlength(QueryNamesNotToOpen, 4);
      QueryNamesNotToOpen[0] := 'qryDeleteFloorPlan';
      QueryNamesNotToOpen[1] := 'qryDeleteTemplatePlan';
      QueryNamesNotToOpen[2] := 'qryFloorPlan';
      QueryNamesNotToOpen[3] := 'qryTableCustomers';
      OpenQueries(QueryNamesNotToOpen);

      if qryRooms.RecordCount = 0 then begin
        CommonLib.MessageDlgXP_Vista('You currently have no function rooms defined.  Please define your function rooms and try again!',
          mtWarning, [mbOK], 0);
        Close;
        Exit;
      end;

      BasicTables1.RoomID   := qryRooms.FieldByName('RoomID').AsInteger;
      BasicTables1.PlanName := ROOM_NAME + qryRooms.FieldByName('RoomID').AsString;
      BasicTables1.LoadRoomData;
      BasicTables1.StatusText     := 'Standing By ...';
      BasicTables1.IsTemplate     := false;
      BasicTables1.ShowScrollBars := false;
      BasicTables1.UseAutoResync  := false;
      BasicTables1.EditMode       := emIdle;

      with qryFloorPlan do begin
        ParamByName('ID').asInteger := BasicTables1.RoomID;
        Open;
      end;

      BuildTemplateNames;
      Self.Top:=0;
      //GetTableImageListsDLL;
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

//procedure TfrmTableManagement.GetTableImageListsDLL;
//var
//  Handle: THandle;
//  GetImageListFunc: TGetImageListFunc;
//begin
//  Handle := LoadLibrary(pchar(SystemLib.ExeDir + 'IntroImagesDLL.dll'));
//  if Handle <> 0 then begin
//    Try
//      @GetImageListFunc := GetProcAddress(Handle, 'GetTableImageList');
//      if @GetImageListFunc <> nil then
//      begin
//        IMageList1.AddImages(GetImageListFunc);
//      end;
//    Finally
//      FreeLibrary(Handle);
//    end;
//  end;
//end;

procedure TfrmTableManagement.btnCloseClick(Sender: TObject);
begin
  inherited;
//  Close;
end;

procedure TfrmTableManagement.BasicTables1CellSelected(CellID: integer; CellInfo: TCellInfo);
begin
  inherited;
  // Are we in Move Table Mode?
  if (BasicTables1.EditMode = emMovingTable) then begin
    // Ensure we have the parent cell.
    BasicTables1.CellID := CellInfo.ParentCellID;
    // Copy Cell Information as we need to restore later.
    CopyMemory(@MyCellInfo, BasicTables1.CellInfo, SizeOf(MyCellInfo));
    // Exit.
    Exit;
  end;
  
  // Are we in Fetch Information Mode?
  if BasicTables1.EditMode = emFetchInfo then begin
    // Show our Information Tab
    tabInfo.TabVisible := true;
    pcOptions.TabWidth := 119;
    if BasicTables1.PrevSelectedCell <> -1 then begin
      BasicTables1.PrevSelectedCellInfo^.FlashTable := false;
    end;

    // Yes, is this cell info a table?
    if CellInfo.CellType = IsTable then begin
      // Restore Information to Information panel.
      BasicTables1.SelectedCellInfo^.FlashTable := true;
      pcOptions.ActivePage := tabInfo;
      edtCellID.Text := IntToStr(CellInfo.ParentCellID);
      udMaxSeating.Position := CellInfo.TableSeating;
      udTableID.Position := CellInfo.TableID;
      edtComments.Text := string(CellInfo.Comments);
    end else begin
      // Disable Table Information Tab.
      tabInfo.TabVisible := false;
      pcOptions.TabWidth := 237;
      pcOptions.ActivePage := tabGeneral;
    end;
  end;

  //  BasicTables1.SetTableStatus(TableID, StatusID);
end;

procedure TfrmTableManagement.btnTableStatusClick(Sender: TObject);
//Var Form : TComponent;
begin
  inherited;
//  Form := GetComponentByClassName('TfrmStatusEditor');
//  if Assigned(Form) then begin //if has acess
//    with TfrmStatusEditor(Form) do begin
//      Position := poDefault;
//      ShowModal;
//    end;
//  end;
end;

procedure TfrmTableManagement.DNMPanel3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  BasicTables1.DisableCursor;
end;

procedure TfrmTableManagement.BasicTables1TableMoved(CellID: integer; CellInfo: PCellInfo);
begin
  with CellInfo^ do begin
    CellType         := MyCellInfo.CellType;
    TableColour      := MyCellInfo.TableColour;
    TableID          := MyCellInfo.TableID;
    TableSeating     := MyCellInfo.TableSeating;
    RoomAllocationID := MyCellInfo.RoomAllocationID;
    StrCopy(Comments, MyCellInfo.Comments);
  end;
end;

procedure TfrmTableManagement.Edit1Change(Sender: TObject);
begin
  BasicTables1.RequestCellUpdate(FastFuncs.StrToInt(edtCellID.Text));
end;

procedure TfrmTableManagement.edtCellIDChange(Sender: TObject);
begin
  BasicTables1.RequestCellUpdate(FastFuncs.StrToInt(edtCellID.Text));
end;

procedure TfrmTableManagement.edtMaxSeatingChange(Sender: TObject);
begin
  BasicTables1.RequestCellUpdate(FastFuncs.StrToInt(edtCellID.Text));
end;

procedure TfrmTableManagement.edtCommentsChange(Sender: TObject);
begin
  BasicTables1.RequestCellUpdate(FastFuncs.StrToInt(edtCellID.Text));
end;

procedure TfrmTableManagement.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
 //  This is a temporary keypress for testing purposes only.
 //   if (Shift = [ssShift, ssCtrl, ssAlt]) and (Key = VK_F12) then begin
//       SpeedButton1.Visible := True;
//    end;
end;

procedure TfrmTableManagement.BasicTables1CellUpdate(CellID: integer);
var
  iTableType: integer;
begin
  inherited;
  // Save Table Information to our Cell Info.
  BasicTables1.CellID := FastFuncs.StrToInt(edtCellID.Text);

  // Save information to parent Cell
  with BasicTables1.CellInfo^ do begin
    StrPCopy(Comments, AnsiString(edtComments.Text));
    TableSeating := udMaxSeating.Position;
    TableID      := udTableID.Position;
  end;

  // Determine now if this is a horizontal or vertical table.
  iTableType := BasicTables1.CellInfo^.ImageIndex;
  case iTableType of
    2..5, 9..17:
      begin
        BasicTables1.CellID := BasicTables1.CellID + 1;
        // Now Save Information to child cell.
        with BasicTables1.CellInfo^ do begin
          StrPCopy(Comments, AnsiString(edtComments.Text));
          TableSeating := udMaxSeating.Position;
          TableID := udTableID.Position;
        end;

        BasicTables1.CellID := BasicTables1.CellID + BasicTables1.NumOfYCells;
        // Now Save Information to child cell.
        with BasicTables1.CellInfo^ do begin
          StrPCopy(Comments, AnsiString(edtComments.Text));
          TableSeating := udMaxSeating.Position;
          TableID := udTableID.Position;
        end;

        BasicTables1.CellID := BasicTables1.CellID - 1;
        // Now Save Information to child cell.
        with BasicTables1.CellInfo^ do begin
          StrPCopy(Comments, AnsiString(edtComments.Text));
          TableSeating := udMaxSeating.Position;
          TableID := udTableID.Position;
        end;
      end;
  end;
end;

procedure TfrmTableManagement.udGridXCellsChangingEx(Sender: TObject; var AllowChange: boolean;
  NewValue: smallint; Direction: TUpDownDirection);
begin
  inherited;
  case NewValue of
    1: 
      begin
        txtNumOfXCells.Text := IntToStr(8);
        udGridYCells.Position := 1;
        txtNumOfYCells.Text := '8';
      end;

    2: 
      begin
        txtNumOfXCells.Text := IntToStr(16);
        txtNumOfYCells.Text := '16';
        udGridYCells.Position := 2;
      end;

    3: 
      begin
        txtNumOfXCells.Text := IntToStr(32);
        udGridYCells.Position := 3;
        txtNumOfYCells.Text := '32';
      end;
  end;
  AllowChange := true;
end;

procedure TfrmTableManagement.cboRoomsCloseUp(Sender: TwwDBComboBox; Select: boolean);
var
  strOldStatus: string;
  OldMode: TEditMode;
begin
  inherited;
  try
    // Set cursor state to busy.
    Processingcursor(True);

    // Initialise Component before Loading Room Data.
    strOldStatus := BasicTables1.StatusText;
    OldMode      := BasicTables1.EditMode;

    // Set Status Mode to busy.
    BasicTables1.EditMode := emBusy;

    // Retrieve Template Data.
    BasicTables1.RoomID   := qryRooms.FieldByName('RoomID').AsInteger;
    BasicTables1.PlanName := ROOM_NAME + qryRooms.FieldByName('RoomID').AsString;

    if BasicTables1.LoadRoomData then begin
      udGridXCells.Position := BasicTables1.NumOfXCells;
      udGridYCells.Position := BasicTables1.NumOfYCells;
    end;

    // Restore Mode to previous setting.
    BasicTables1.EditMode   := OldMode;
    BasicTables1.StatusText := strOldStatus;

  finally
    // Restore our cursor state.
    Processingcursor(False);
  end;
end;

procedure TfrmTableManagement.cboRoomNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  sOldStatus: string;
  OldMode: TEditMode;
begin
  if not Modified then Exit;
  inherited;
  with BasicTables1 do begin
    Processingcursor(True);
    try
      sOldStatus  := StatusText;
      ClearGrid;
      RoomId   := LookupTable.FieldByName('RoomID').AsInteger;
      PlanName := ROOM_NAME + LookupTable.FieldByName('RoomID').AsString;
      OldMode  := EditMode;
      EditMode := emBusy;
      LoadRoomData;
      EditMode    := OldMode;
      StatusText  := sOldStatus;
    finally
      Processingcursor(False);
    end;
  end;
end;

procedure TfrmTableManagement.sbIdleclick(Sender: TObject);
begin
  inherited;
 tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BasicTables1.EditMode := emIdle;
  BasicTables1.StatusText := 'Standing By ...';
end;

procedure TfrmTableManagement.sbPlaceTableclick(Sender: TObject);
begin
  inherited;
  tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BasicTables1.EditMode := emPlacingTable;
  BasicTables1.DisableCursor;
  BasicTables1.StatusText := 'Please left click in cell to place table object.';
end;

procedure TfrmTableManagement.sbClearclick(Sender: TObject);
begin
  inherited;
  tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BasicTables1.EditMode := emClearing;
  BasicTables1.StatusText := 'Please left click in cell to clear.  If this is a table, then the table will be removed.';
end;

procedure TfrmTableManagement.sbWallclick(Sender: TObject);
begin
  inherited;
  tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BasicTables1.EditMode := emPlacingWall;
  BasicTables1.StatusText := 'Please left click in cell to place wall object.';
end;

procedure TfrmTableManagement.sbInfoclick(Sender: TObject);
begin
  inherited;
  BasicTables1.EditMode := emFetchInfo;
  BasicTables1.EnableCursor;
  BasicTables1.StatusText := 'Please left click in cell to retrieve information.';
end;

procedure TfrmTableManagement.btnSaveRoomDataClick(Sender: TObject);
var
  strOldStatus: string;
  OldMode: TEditMode;
  iX: integer;
begin
  DisableForm;
  try
    inherited;
    OldMode := BasicTables1.EditMode;
    try
      Processingcursor(True);
      // Set our Plan Name before saving.
      BasicTables1.RoomID     := qryRooms.FieldByName('RoomID').AsInteger;
      BasicTables1.PlanName   := ROOM_NAME + IntToStr(BasicTables1.RoomID);
      BasicTables1.IsTemplate := false;
      // Save room data.
      strOldStatus := BasicTables1.StatusText;
      if not BasicTables1.SaveRoomData then begin
        // Report Error to user.
        CommonLib.MessageDlgXP_Vista('Failed to Save room data!', mtWarning, [mbOK], 0);
      end else begin
        // Requery the database to show new list.
        qryFloorPlan.Close;
        qryFloorPlan.Open;
        qryTemplatePlan.Close;
        qryTemplatePlan.Open;

        // Reestablish List.
        BuildTemplateNames;
      end;

      BasicTables1.StatusText := strOldStatus;

      // Now generate the Table Customer List for this room.
      for iX := 0 to BasicTables1.MaxCells - 1 do begin
        with BasicTables1 do begin
          CellID := iX;
          if CellInfo^.CellType <> IsTable then Continue;
          if CellInfo^.TableID = 0 then Continue;
          if CellInfo^.ParentCellID < iX then Continue;
          if CellInfo^.ParentCellID = iX then begin
            // Setup our Query
            qryTableCustomers.Close;
            qryTableCustomers.ParamByName('xCompanyName').AsString := 'Table' + IntToStr(CellInfo^.TableID);// + ' (' + cboRoomName.Text + ')';
            qryTableCustomers.Open;
            if qryTableCustomers.RecordCount > 0 then begin
              qryTableCustomers.Edit;
              qryTableCustomers.FieldByName('Active').AsString := 'T';
              qryTableCustomers.FieldByName('Customer').AsString := 'T';
            end else begin
              // No, then add table.
              qryTableCustomers.Insert;
              qryTableCustomers.FieldByName('Active').AsString := 'T';
              qryTableCustomers.FieldByName('Customer').AsString := 'T';
              qryTableCustomers.FieldByName('Company').AsString :=
                'Table' + IntToStr(CellInfo^.TableID);// + ' (' + cboRoomName.Text + ')';
            end;
            qryTableCustomers.Post;
          end;
        end;
      end;
    finally
      // Cleanup.
      BasicTables1.EditMode := OldMode;
      Processingcursor(False);
      qryTableCustomers.Close;
    end;
  //  Close;
  finally
    EnableForm;
  end;
end;

procedure TfrmTableManagement.btnMoveTableclick(Sender: TObject);
begin
  inherited;
  tabInfo.TabVisible := false;
  pcOptions.TabWidth := 237;
  BasicTables1.EditMode := emMovingTable;
  BasicTables1.EnableCursor;
  BasicTables1.StatusText := 'Please left click on table object to begin moving.';
end;

procedure TfrmTableManagement.btnCanvasColourclick(Sender: TObject);
var
  strOldStatus: string;
begin
  inherited;
  strOldStatus := BasicTables1.StatusText;
  BasicTables1.StatusText := 'Please select a background colour.';
  if colorDialog1.Execute then begin
    BasicTables1.CanvasColour := ColorDialog1.Color;
  end;
  BasicTables1.StatusText := strOldStatus;
end;

procedure TfrmTableManagement.btnCellCursorColourclick(Sender: TObject);
var
  strOldStatus: string;
begin
  inherited;
  strOldStatus := BasicTables1.StatusText;
  BasicTables1.StatusText := 'Please select a colour for your edit highlight cursor.';
  if ColorDialog1.Execute then begin
    BasicTables1.CellCursorColour := ColorDialog1.Color;
  end;
  BasicTables1.StatusText := strOldStatus;
end;

procedure TfrmTableManagement.btnSetWallColourclick(Sender: TObject);
var
  strOldStatus: string;
begin
  inherited;
  strOldStatus := BasicTables1.StatusText;
  BasicTables1.StatusText := 'Please select a colour to represent your walls.';
  if colorDialog1.Execute then begin
    BasicTables1.WallColour := ColorDialog1.Color;
  end;
  BasicTables1.StatusText := strOldStatus;
end;

procedure TfrmTableManagement.btnSetStatusTextColourclick(Sender: TObject);
var
  strOldStatus: string;
begin
  inherited;
  strOldStatus := BasicTables1.StatusText;
  BasicTables1.StatusText := 'Please select a colour for your status text.';
  if colorDialog1.Execute then begin
    BasicTables1.StatusTextColour := ColorDialog1.Color;
  end;
  BasicTables1.StatusText := strOldStatus;
end;

procedure TfrmTableManagement.BasicTables1DblClick(CellID: integer; CellInfo: TCellInfo);
begin
  inherited;
//  CommonLib.MessageDlgXP_Vista('It Fired!', mtInformation , [mbOK], 0);
  
end;

procedure TfrmTableManagement.BasicTables1TablePlaced(CellID: Integer;
  CellInfo: PCellInfo);
begin
  inherited;
//  ShowMessage('Table placed');
end;

initialization
  RegisterClassOnce(TfrmTableManagement);
end.
