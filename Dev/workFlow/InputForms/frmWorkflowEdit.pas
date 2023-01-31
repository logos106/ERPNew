unit frmWorkflowEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, Menus, ExtCtrls, StdCtrls , BusobjWorkflow, BusObjBase,
  DNMPanel, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid, ActnList, DNMAction , GuiPrefsObj, Buttons, DBCtrls, DNMSpeedButton ;

type
  TfmWorkflowEdit = class(TfrmBaseGUI)
    pnlDetails: TDNMPanel;
    dsworkflowLines: TDataSource;
    grdMain: TwwDBGrid;
    grdMainIButton: TwwIButton;
    pnlworkflowLineDetails: TDNMPanel;
    Label1: TLabel;
    edtFormClassName: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    DBEdit6: TDBEdit;
    Label5: TLabel;
    DBEdit7: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit8: TDBEdit;
    mnuGrid: TPopupMenu;
    DeleteAllEmpty1: TMenuItem;
    pnlbtns: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlbuttons: TDNMPanel;
    btnup: TDNMSpeedButton;
    btndown: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure PostLineOnExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEventNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainIButtonClick(Sender: TObject);
    procedure pnlworkflowLineDetailsExit(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure grdMainEnter(Sender: TObject);
    procedure DeleteAllEmpty1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
  private
    fWorkFlow : TWorkFlow;
    fcurform :Tform;
    fCurcontrol :TWinControl;
    GuiPrefs: TFormGuiPrefs;
    Procedure Readguiprefs;
    Procedure WriteGuiPrefs;
    Procedure DeleteAllEmptyCallback(Const Sender: TBusObj; Var Abort: Boolean);
    procedure MoveRec(moveup: Boolean);
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
    Property WorkFlow :TWorkFlow Read fWorkFlow write fWorkFlow;
  end;

implementation

uses CommonLib, BusObjConst, LogLib , GridFieldsObj, MAIN, tcConst, dmMainGUI;

{$R *.dfm}

{ TfmWorkflowEdit }


procedure TfmWorkflowEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  try
    MainForm.DoCancelrecording;
  except
  end;
end;

procedure TfmWorkflowEdit.btndownClick(Sender: TObject);
begin
  inherited;
  MoveRec(False);
end;

procedure TfmWorkflowEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  try
    MainForm.DoStoprecording;
  except
  end;

end;

procedure TfmWorkflowEdit.btnupClick(Sender: TObject);
begin
   MoveRec(true);
end;
procedure TfmWorkflowEdit.MoveRec(moveup:Boolean);
var
  fid1, fsno1, fsno2:Integer;
begin
  inherited;
  Workflow.Lines.postdb;
  if moveup then if Workflow.Lines.bof then exit;
  if not moveup then if Workflow.Lines.eof then exit;

  if Workflow.Lines.count =1 then exit;
  fid1:=Workflow.Lines.ID;  fsno1:=Workflow.Lines.seqno;

  try
      if moveup  then Workflow.Lines.Prior else Workflow.Lines.Next;
      fsno2:=Workflow.Lines.seqno;


      Workflow.Lines.Connection.BeginNestedTransaction;
      try
        Workflow.Lines.seqno := fsno1;
        Workflow.Lines.PostDB;
        if Workflow.Lines.Locate('ID' , fid1 , []) then begin
          Workflow.Lines.seqno := fsno2;
          Workflow.Lines.PostDB;
        end;
        Workflow.Lines.Connection.CommitNestedTransaction;
        Workflow.Lines.RefreshDB;
      except
        on E:Exception do begin
          Workflow.Lines.Connection.RollbackNestedTransaction;
        end;
      end;
  finally
    if Workflow.Lines.Id <fid1 then
      Workflow.Lines.Locate('ID' , fid1 , []) ;
  end;
end;

procedure TfmWorkflowEdit.DeleteAllEmpty1Click(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_Vista('Are you sure want to delete all lines with no Eventname?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  WorkFlow.Lines.IterateRecordsReverse(DeleteAllEmptyCallback);
end;

procedure TfmWorkflowEdit.DeleteAllEmptyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TWorkFlowLines) then exit;
  if TWorkFlowLines(Sender).EventName = '' then begin
    TWorkFlowLines(Sender).Delete;
  end;
end;

procedure TfmWorkflowEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) and (Sender is TWorkFlowLines) then begin
      dsworkflowLines.DataSet := Sender.Dataset;
  end else if (Sender is TWorkFlow) then begin
    if ((Eventtype = BusobjEvent_Event  ) and (Value = BusObjEventDataset_AfterOpen   )) or
       ((Eventtype = BusobjEvent_Event  ) and (Value = BusObjEventDataset_AfterPost   )) or
       ((Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value))) then
      Self.Caption :=TWorkFlow(Sender).Description;
  end;
  if (Sender is TWorkFlowLines) then begin
(*    if ((Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen)) or
      ((Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost)) or
      ((Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value))) then begin*)
    if not(Sender.DatasetAssigned) or (TWorkFlowLines(Sender).EventName ='') then Visible := False else Visible := True;
    if (Screen.activeform <> self) and (not(Screen.activeform.ClassNameIs('TMainForm'))) then fcurform := Screen.activeform;
    if Screen.ActiveControl.Owner <> self then fCurcontrol := Screen.ActiveControl;
    logtext(Eventtype+'.' +Value +'=' +fcurform.classname +'.' +fCurcontrol.Name);
  end;

end;

procedure TfmWorkflowEdit.edtEventNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  try
    if (Key = vk_Tab)  or (Key = VK_ESCAPE ) then begin
        if Assigned(fcurform) and (fcurform.visible) then begin
          try
            WorkFlow.Lines.PostDb;
            SetActiveWindow(fcurform.Handle);
            SetcontrolFocus(fCurcontrol);
            Key := 0;
            Exit;
          Except
          end;
        end;
    end else if (ssCtrl in Shift) and  (Key = vk_RIGHT)   then begin
      if Self.width < mainform.width-30 then begin
        width := width +7;
        Left := Left -7;
        grdmain.datasource.dataset.fieldbyname('ControlParent').displaywidth := grdmain.datasource.dataset.fieldbyname('ControlParent').displaywidth+1;
      end;
      Key := 0;
    end else if (ssCtrl in Shift) and  (Key = vk_LEFT)   then begin
      if grdmain.datasource.dataset.fieldbyname('ControlParent').displaywidth  >= 25 then begin
        width := width -7;
        Left := Left +7;
        grdmain.datasource.dataset.fieldbyname('ControlParent').displaywidth := grdmain.datasource.dataset.fieldbyname('ControlParent').displaywidth-1;
      end;
      Key := 0;
    end else if (ssCtrl in Shift) and  (Key = vk_DOWN)   then begin
      if Self.height < mainform.height - (mainform.MainToolBar.Height+20) then begin
        Height := Height +5;
      end;
      Key := 0;
    end else if (ssCtrl in Shift) and  (Key = vk_UP)   then begin
      if Self.height > 150 then begin
        Height := Height -5;
      end;
      Key := 0;
    end;
  Except
  end;
end;

procedure TfmWorkflowEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmWorkflowEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Color := clWhite;
  TransparentColor:= True;
  TransparentColorValue := clWhite;
  fWorkFlow := nil;
  grdMain.hint := 'Height, Width and column widths can be changed and gets saved.' +NL +
                  'Hold down CTRL and  → or ← To Increase or Decrease Width '+NL+
                  'Hold down CTRL and  ↓ or ↑ to Increase or Decrease the height of the form.' +NL +
                  'The form can be repositioned by dragging and dropping within the mainform.'+NL;
  grdMain.showhint := True;
(*  if devmode then begin
    pnllines.Visible := True;
    Self.Width := 775;
  end else begin
    pnllines.Visible := False;
    Self.Width := 300;
  end;
  Self.Height := 150;*)
  fcurform := nil;
end;

procedure TfmWorkflowEdit.FormDestroy(Sender: TObject);
begin
  WriteGuiPrefs;
  inherited;

end;

procedure TfmWorkflowEdit.FormResize(Sender: TObject);
begin
  inherited;
  pnlbtns.height    := 33;
  btnCancel.Width   := 107;
  btnSave.Width     := 107;
  btnCancel.height  := 25;
  btnSave.height    := 25;
  btnCancel.top     := trunc((pnlbtns.height -btnCancel.height)/2);
  btnSave.top       := trunc((pnlbtns.height -btnCancel.height)/2);
  btnCancel.Left    := trunc(Self.Width/2) - btnCancel.Width -10;
  btnSave.Left      := trunc(Self.Width/2) +10;
  btnup.Left:=0;
  btndown.Left:=0;
  btnup.Top :=trunc(grdMain.Height /2)- btndown.height-2;
  btndown.top := trunc(grdMain.Height /2)+2;
end;

procedure TfmWorkflowEdit.FormShow(Sender: TObject);
begin
  inherited;
  Readguiprefs;
  Color := clWhite;
  TransparentColor:= True;
  TransparentColorValue := clWhite;
end;

procedure TfmWorkflowEdit.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if SAmetext(TField(grdMain.GetActiveField).FieldName , 'ControlParent') or
     SAmetext(TField(grdMain.GetActiveField).FieldName , 'MenuName') then begin
    pnlworkflowLineDetails.Visible := True;
    SetControlfocus(edtFormClassName);
  end;
end;

procedure TfmWorkflowEdit.grdMainEnter(Sender: TObject);
begin
  inherited;
  pnlworkflowLineDetails.Visible := False;
end;

procedure TfmWorkflowEdit.grdMainIButtonClick(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_vista('Are you sure you want to delete this entry?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
    Workflow.Lines.Delete;
end;

procedure TfmWorkflowEdit.pnlworkflowLineDetailsExit(Sender: TObject);
begin
  inherited;
  pnlworkflowLineDetails.Visible := False;
end;

procedure TfmWorkflowEdit.PostLineOnExit(Sender: TObject);
begin
  inherited;
  if not Workflow.datasetassigned then exit;
  WorkFlow.Lines.PostDb;
end;
procedure TfmWorkflowEdit.Readguiprefs;
var
  GridfieldList: TGridFieldList;
  EventName: TGridFieldRec;
  ControlParent: TGridFieldRec;
  MenuName: TGridFieldRec;
begin
  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.active := True;

  if GuiPrefs.Node.Exists('Options.Left') then begin
    Self.Left :=  GuiPrefs.Node['Options.Left'].asInteger;
  end else begin
    Left := (mainform.width - Width )-15;
  end;
  if GuiPrefs.Node.Exists('Options.top') then begin
    Self.top :=  GuiPrefs.Node['Options.top'].asInteger;
  end else begin
    Top := 0 +mainform.MainToolBar.Height+10;
  end;
  if GuiPrefs.Node.Exists('Options.width') then begin
    Self.Width :=  GuiPrefs.Node['Options.width'].asInteger;
    (*pnlDetails.Width :=  GuiPrefs.Node['Options.width'].asInteger;*)
  end;
  if GuiPrefs.Node.Exists('Options.Height') then begin
    Self.Height :=  GuiPrefs.Node['Options.Height'].asInteger;
    (*pnlDetails.Height :=  GuiPrefs.Node['Options.Height'].asInteger;*)
  end;
  GridfieldList:= TGridFieldList.Create;
  try
     EventName:= TGridFieldRec(GridfieldList.Add);
     EventName.FieldName:= 'EventName';
     if GuiPrefs.Node.Exists('Options.EventNamewidth') then
          EventName.DisplayWidth:= GuiPrefs.Node['Options.EventNamewidth'].asInteger
     else EventName.DisplayWidth:= 30;
     EventName.DisplayLabel:= 'Details';
     EventName.ReadOnly:= false;


     ControlParent:= TGridFieldRec(GridfieldList.Add);
     ControlParent.FieldName:= 'ControlParent';
     if GuiPrefs.Node.Exists('Options.ControlParentwidth') then
          ControlParent.DisplayWidth:= GuiPrefs.Node['Options.ControlParentwidth'].asInteger
     else ControlParent.DisplayWidth:= 49;
     ControlParent.DisplayLabel:= 'Coding control Panel';
     ControlParent.ReadOnly:= True;

     Menuname:= TGridFieldRec(GridfieldList.Add);
     Menuname.FieldName:= 'Menuname';
     if GuiPrefs.Node.Exists('Options.Menunamewidth') then
          Menuname.DisplayWidth:= GuiPrefs.Node['Options.Menunamewidth'].asInteger
     else Menuname.DisplayWidth:= 15;
     Menuname.DisplayLabel:= 'Menu';
     Menuname.ReadOnly:= True;

    grdmain.Selected.Text := GridfieldList.Text;
    grdmain.ApplySelected;
  finally
    Freeandnil(EventName);
    Freeandnil(ControlParent);
    Freeandnil(MenuName);
    Freeandnil(GridfieldList);
  end;
end;

procedure TfmWorkflowEdit.WriteGuiPrefs;
begin
  try
      GuiPrefs.Node['Options.width'].asInteger := Width;
      GuiPrefs.Node['Options.Height'].asInteger := Height;
      GuiPrefs.Node['Options.EventNamewidth'].asInteger := grdmain.DataSource.DataSet.FieldByName('Eventname').DisplayWidth;
      GuiPrefs.Node['Options.ControlParentwidth'].asInteger := grdmain.DataSource.DataSet.FieldByName('ControlParent').DisplayWidth;
      GuiPrefs.Node['Options.Menunamewidth'].asInteger := grdmain.DataSource.DataSet.FieldByName('Menuname').DisplayWidth;
      Freeandnil(GuiPrefs);
  Except

  end;
end;

initialization
  RegisterClassOnce(TfmWorkflowEdit);
end.

