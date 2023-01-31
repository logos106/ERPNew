unit frmProjectfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, ExtCtrls, DNMPanel, FeTskLst, FeGant,
  FeAbsGrd, FePrjDlg, FeGntDlg, wwdblook, Grids, Wwdbigrd, Wwdbgrid,
  Menus, AdvMenus, StrUtils, LinkLabel, DBAccess, MyAccess, DataState, FeTskGrd,
  MemDS, Shader, dmGUIStylers;

type
  pLinksOldTimes = ^TLinksOldTimes;
  TLinksOldTimes = record
    TaskID: integer;
    StartTime: TDateTime;
    EndTime: TDateTime;
    LinkTo: integer;
    LineNo: integer;
    PartsID: integer;
  end;


type
  TfrmProject = class(TBaseInputGUI)
    qryProjects: TMyQuery;
    DSProjects: TDataSource;
    ProjectPageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tabGantt: TTabSheet;
    PageControl2: TPageControl;
    DNMPanel1: TDNMPanel;
    cmdOk: TDNMSpeedButton;
    ProjectGant1: TFEGant;
    ProjectTaskList1: TFETaskList;
    FEGantSetupDialog: TFEGantSetupDialog;
    tabDesign: TTabSheet;
    DNMPanel3: TDNMPanel;
    qryProjectLines: TMyQuery;
    DSProjectLines: TDataSource;
    Label25: TLabel;
    Company: TDBEdit;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    Label7: TLabel;
    DBEdit2: TDBEdit;
    cboProductLookup: TMyQuery;
    DSProductLookup: TDataSource;
    GanTAdvPopupMenu1: TAdvPopupMenu;
    Linkwithpredecessor1: TMenuItem;
    Removefromchart1: TMenuItem;
    PrintChart1: TMenuItem;
    grdManuf: TwwDBGrid;
    Splitter1: TSplitter;
    ProjectTaskGrid1: TFETaskGrid;
    cmdCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    Label8: TLabel;
    DBMemo1: TDBMemo;
    TaskLisTAdvPopupMenu: TAdvPopupMenu;
    GotoToday1: TMenuItem;
    tabAll: TTabSheet;
    dsProjectsAll: TDataSource;
    qryProjectsAll: TMyQuery;
    dsProjectLinesAll: TDataSource;
    qryProjectLinesAll: TMyQuery;
    TaskListAll: TFETaskList;
    FEGantSetupDialogAll: TFEGantSetupDialog;
    PrinterSetupDialog: TPrinterSetupDialog;
    qryProjectsAllProjectID: TIntegerField;
    qryProjectsAllProjectName: TStringField;
    qryProjectsAllStartDate: TDateTimeField;
    qryProjectsAllEndDate: TDateTimeField;
    qryProjectsAllClientID: TIntegerField;
    tabGanttWeek: TTabSheet;
    tabAllWeek: TTabSheet;
    DNMPanel2: TDNMPanel;
    Splitter3: TSplitter;
    gantWeek: TFEGant;
    FETaskGrid1: TFETaskGrid;
    DNMPanel4: TDNMPanel;
    FETaskGridAll: TFETaskGrid;
    Splitter2: TSplitter;
    gantAll: TFEGant;
    DNMPanel5: TDNMPanel;
    Splitter4: TSplitter;
    FETaskGrid2: TFETaskGrid;
    gantAllWeek: TFEGant;
    chkShowAddress: TCheckBox;
    Label9: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure ClearList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure CompanyChange(Sender: TObject);
    procedure PrintChart1Click(Sender: TObject);
    procedure Removefromchart1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProjectTaskList1TaskChange(Sender: TObject; aItem: TFETask);
    procedure ProjectGant1Click(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure ProjectGant1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure ProjectPageControlChange(Sender: TObject);
    procedure ProjectTaskGrid1DblClick(Sender: TObject);
    procedure GotoToday1Click(Sender: TObject);
    procedure RefreshGantt;
    procedure RefreshGanttAll;
    procedure grdManufExit(Sender: TObject);
    procedure FETaskGridAllDblClick(Sender: TObject);
    procedure ProjectPageControlChanging(Sender: TObject; var AllowChange: boolean);
    procedure btnModeClick(Sender: TObject);
    procedure chkShowAddressClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    { Private declarations }
    lstOldTaskTimes: TList;
    bShowAddress: boolean;
    dtGanttLastDate: TDateTime;
    dtGanttAllLastDate: TDateTime;
    fDateError: Boolean;
    procedure UpdateProjectLines;
    procedure OpenProject(iProjectID: integer);
    function GetPrjAddress(iClientID: integer): string;
  public
    { Public declarations }
    OldStartDayTime: TDateTime;
    AItemFlag: string;
    OpenFlag: integer;
  end;

  
implementation

uses FastFuncs, DNMExceptions, DateUtils, CommonDbLib,  
  AppEnvironment, CommonLib;



{$R *.dfm}


procedure TfrmProject.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if ProjectPageControl.ActivePage = tabGantt then begin
    AppEnv.Employee.ActiveGant := 1;
  end else if ProjectPageControl.ActivePage = tabGanttWeek then begin
    AppEnv.Employee.ActiveGant := 2;
  end else if ProjectPageControl.ActivePage = tabAll then begin
    AppEnv.Employee.ActiveGant := 3;
  end else if ProjectPageControl.ActivePage = tabAllWeek then begin
    AppEnv.Employee.ActiveGant := 4;
  end else if ProjectPageControl.ActivePage = tabDesign then begin
    AppEnv.Employee.ActiveGant := 5;
  end else begin
    AppEnv.Employee.ActiveGant := 0;
  end;



  AppEnv.Employee.GantShowAddress := chkShowAddress.Checked;
  CloseQueries;
  ClearList; // Disposes of items on TLIST to avoid memory leaks.
  Action := caFree;
//  frmProject := nil;
end;

procedure TfrmProject.FormShow(Sender: TObject);
begin
  try
    inherited;
    OpenProject(KeyID);

    BeginTransaction;
    if KeyID = 0 then begin
      qryProjects.Insert;
    end else begin
    end;

    gantAllWeek.CaptionSummary.DisplayFormat := 'yyyy' + #10#13 + 'mmm' + #10#13 + 'dd';
    gantAll.LeftDateTime     := IncMonth(Date(), - 1);
    gantAllWeek.LeftDateTime := IncDay(Date(), - 1);
    dtGanttLastDate          := Now;
    dtGanttAllLastDate       := IncDay(Date(), - 2);

    case AppEnv.Employee.ActiveGant of
      1: ProjectPageControl.ActivePage := tabGantt;
      2: ProjectPageControl.ActivePage := tabGanttWeek;
      3: ProjectPageControl.ActivePage := tabAll;
      4: ProjectPageControl.ActivePage := tabAllWeek;
      5: ProjectPageControl.ActivePage := tabDesign;
      else ProjectPageControl.ActivePage := tabGanttWeek;
    end;
    ProjectPageControlChange(Sender);
    chkShowAddress.Checked := AppEnv.Employee.GantShowAddress;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;    
    else raise;
  end;
end;

procedure TfrmProject.cmdOkClick(Sender: TObject);
  //var i: integer;
begin
  inherited;

  if not fDateError then begin
    if (ProjectPageControl.ActivePage = tabGantt) or
      (ProjectPageControl.ActivePage = tabGanttWeek) then begin
      UpdateProjectLines;
    end;

    if (qryProjects.State in [dsInsert, dsEdit]) then begin
      qryProjects.Post;
    end;
    CommitTransaction;
    Notify;
    Self.Close;
  end;  
end;

procedure TfrmProject.RefreshGantt;
var
  i: integer;
  aItem: TFETask;
  LinksTimes: pLinksOldTimes;
  tmpStartDateTime: TDateTime;
  tmpEndDateTime: TDateTime;
begin;
  TitleLabel.Caption := qryProjects.FieldByName('ProjectName').AsString;
  ClearList;  // clear lstOldTaskTimes
  ProjectTaskList1.Items.Clear;
  i := 0;
  fDateError := False;
  qryProjectLines.First;

  while (not qryProjectLines.Eof) and (not fDateError) do begin
    aItem := ProjectTaskList1.Items.Add;
    with aItem do begin
      Name := FastFuncs.IntToStr(i) + ' ' + qryProjectLines.FieldByName('PartDescription').AsString;

      if chkShowAddress.Checked then begin
        TextBottom.Text := qryProjectLines.FieldByName('PartDescription').AsString + '- ' +
          GetPrjAddress(qryProjectLines.FieldByName('CustomerID').AsInteger);
      end else begin
        TextBottom.Text := qryProjectLines.FieldByName('PartDescription').AsString;
      end;

      tmpStartDateTime := qryProjectLines.FieldByName('StartDay').asDateTime;
      tmpEndDateTime := qryProjectLines.FieldByName('EndDay').asDateTime;

      if tmpStartDateTime <= tmpEndDateTime then begin
        StartDateTime := tmpStartDateTime;
        EndDateTime := tmpEndDateTime;
        aItem.Row := qryProjectLines.FieldByName('LineNo').AsInteger;
        OldStartDayTime := StartDateTime;

        if AppEnv.CompanyPrefs.PrjStatusColours then begin
          // If Task is in the future and no reminders have been generated, task is RED
          if (qryProjectLines.FieldByName('HavePromptedOrder').AsBoolean = true) and
            (qryProjectLines.FieldByName('HavePromptedPay').AsBoolean = true) then begin
            aitem.Style := tsSummary;
          end;

          // If Task is in Present and Purchase Reminder generated, but no Payment made, task is BLUE
          if (qryProjectLines.FieldByName('HavePromptedOrder').AsBoolean = true) and
            (qryProjectLines.FieldByName('HavePromptedPay').AsBoolean = false) then begin
            aitem.Style := tsTask;
          end;

          // If Task is in Past, and has been paid off, task is GREEN
          if (qryProjectLines.FieldByName('HavePromptedOrder').AsBoolean = false) and
            (qryProjectLines.FieldByName('HavePromptedPay').AsBoolean = false) then begin
            aitem.Style := tsProjectSummary;
          end;
        end else begin
          // toggle colours
          case i mod 3 of
            0: aitem.Style := tsSummary;          // green
            1: aitem.Style := tsTask;             // blue
            else aitem.Style := tsProjectSummary; // red
          end;
        end;

        // make sure any link is valid (LinkTo starts at 1, item indexes start at zero)
        if (qryProjectLines.FieldByName('LinkTo').AsInteger > ProjectTaskList1.Items.Count) then begin
          qryProjectLines.Edit;
          qryProjectLines.FieldByName('LinkTo').AsInteger := 0;
          qryProjectLines.Post;
        end;

        // do the link
        if (qryProjectLines.FieldByName('LinkTo').AsInteger <> 0) and
          (qryProjectLines.FieldByName('LinkTo').AsInteger <> qryProjectLines.FieldByName('LineNo').AsInteger) then begin
          // set the start time to the end time of the parent - probably should change this later
          //aItem.StartDateTime :=  ProjectTaskList1.Items.Items[qryProjectLines.FieldByName('LinkTo').AsInteger-1].EndDateTime;
          aItem.AddPredecessor(ProjectTaskList1.Items.Items[qryProjectLines.FieldByName('LinkTo').AsInteger - 1]);
        end;

        New(LinksTimes);
        lstOldTaskTimes.Add(LinksTimes);
        LinksTimes^.StartTime := aitem.StartDateTime;
        LinksTimes^.EndTime := aitem.EndDateTime;
        LinksTimes^.TaskID := aitem.ID;
        LinksTimes^.LinkTo := qryProjectLines.FieldByName('LinkTo').AsInteger;
        LinksTimes^.LineNo := qryProjectLines.FieldByName('LineNo').AsInteger;
        LinksTimes^.PartsID := qryProjectLines.FieldByName('PartsID').AsInteger;
        // CommonLib.MessageDlgXP_Vista('Loading LinkTo: '+qryProjectLines.FieldByName('LinkTo').AsString+' LineNo '+qryProjectLines.FieldByName('LineNo').AsString);
        // CommonLib.MessageDlgXP_Vista('ID= '+FastFuncs.IntToStr(aitem.ID));
        qryProjectLines.Next;
        i := i + 1;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('The end date cannot be less than the start date.', mtInformation, [mbOK], 0);
        fDateError := True;
      end;
    end;
  end;
  //if i = 0 then ProjectGant1.LeftDateTime := dtGanttLastDate;
end;


procedure TfrmProject.RefreshGanttAll;
var
  i: integer;
  aItem: TFETask;
  // aPredecessor: TFETask;
  // aDetail: TFETask;
  // LinksTimes : pLinksOldTimes;
begin;
  TitleLabel.Caption := 'All Projects';
  qryProjectsAll.Close;
  qryProjectsAll.Open;
  TaskListAll.Items.Clear;
  i := 0;
  while not qryProjectsAll.Eof do begin
    i     := i + 1;
    aItem := TaskListAll.Items.Add;
    with aItem do begin
      Name := FastFuncs.IntToStr(i) + ' ' + qryProjectsAll.FieldByName('ProjectName').AsString;

      if chkShowAddress.Checked then begin
        TextRight.Text := qryProjectsAll.FieldByName('ProjectName').AsString + '- ' +
          GetPrjAddress(qryProjectsAll.FieldByName('ClientID').AsInteger);
      end else begin
        TextRight.Text := qryProjectsAll.FieldByName('ProjectName').AsString;
      end;
      aItem.StartDateTime := qryProjectsAll.FieldByName('StartDate').AsDateTime;
      aItem.EndDateTime := qryProjectsAll.FieldByName('EndDate').AsDateTime;
      Row := i;
      Tag := qryProjectsAll.FieldByName('ProjectID').AsInteger;
      if (Tag = qryProjects.FieldByName('ProjectID').AsInteger) then begin
        FETaskGridAll.CurrentTask := aItem;
      end;
      qryProjectsAll.Next;
    end;
  end;
end;


procedure TfrmProject.CompanyChange(Sender: TObject);
begin
  inherited;
  TitleLabel.Caption := Company.Text;
end;

procedure TfrmProject.PrintChart1Click(Sender: TObject);
begin
  inherited;
  ProjectGant1.PrintSettings.Text := TitleLabel.Caption;
  ProjectGant1.Print;
end;

procedure TfrmProject.Removefromchart1Click(Sender: TObject);
begin
  inherited;
  ProjectTaskList1.CurrentTask.Destroy;
end;


procedure TfrmProject.FormCreate(Sender: TObject);
begin
  inherited;
  lstOldTaskTimes := TList.Create;
  bShowAddress := false;
end;


procedure TFrmProject.ClearList;
var 
  i: integer;
begin;
  for i := 0 to lstOldTaskTimes.Count - 1 do Dispose(lstOldTaskTimes.Items[i]);
  lstOldTaskTimes.Clear;
end;


procedure TfrmProject.ProjectTaskList1TaskChange(Sender: TObject; aItem: TFETask);
var
  //i : integer;
  //LinksTimes : pLinksOldTimes;
  //listIndex : integer;
  DaysDifference: double;
  OldTime, PresentTime: TDateTime;
  LinksTimes: pLinksOldTimes;
  i{,j,ListIndex}: integer;
  task: TFETask;


  procedure UpdateDecendents(parentTask: TFETask; diff: double);
  var
    i: integer;
  begin;
    if diff <> 0 then begin
      for i := lstOldTaskTimes.Count - 1 downto 0 do begin
        LinksTimes := lstOldTaskTimes[i];
        if LinksTimes.LinkTo = parentTask.Row then begin
          //ListIndex := i;
          ProjectTaskList1.Items.Items[i].StartDateTime :=
            ProjectTaskList1.Items.Items[i].StartDateTime + Diff;
          LinksTimes.EndTime := ProjectTaskList1.Items.Items[i].EndDateTime;
          UpdateDecendents(ProjectTaskList1.Items.Items[i], Diff);
        end;
      end;
    end;
  end;
  //----   // END NESTED PROCEDURE
begin
  inherited;
  task := ProjectTaskList1.CurrentTask;
  DaysDifference := 0;

  // Use the Old Task times to evaluate how much the task has been moved

  if task <> nil then begin
    // if task.DisplayName <> AItemFlag then begin
    AItemFlag := task.DisplayName;
    for i := lstOldTaskTimes.Count - 1 downto 0 do begin;     // I= Primary loop to iterate through TLIST
      LinksTimes := lstOldTaskTimes[i];
      if LinksTimes.TaskID = task.ID then begin;

        OldTime := LinksTimes.EndTime;
        PresentTime := task.EndDateTime;
        DaysDifference := DaySpan(PresentTime, OldTime);
        if PresentTime < OldTime then begin
          DaysDifference := DaysDifference * -1;
        end;
        LinksTimes.EndTime := PresentTime;
        Break;
      end;
      //end;
    end;


    UpdateDecendents(task, DaysDifference);
  end;
  // Make sure all other tasks attached to this one move with it if they are linked.
  //  for i:=0 to ProjectTaskList1.Items.Count-1 do begin;
  //    UpdateDecendents;
  //  end;
end;





procedure TfrmProject.ProjectGant1Click(Sender: TObject);
begin
  inherited;
  if ProjectTaskList1.CurrentTask <> nil then begin;
    // This line is used to stop people from adding tasks to the gantt chart by accidentally clicking on it.
    // There does not appear to be a property to disable task adding.
    // When you click on the gantt chart a new task is given the name TFETask1 or something. This task becomes
    // the current task so we just delete it.
    if FastFuncs.LeftStr(ProjectTaskList1.CurrentTask.DisplayName, 7) = 'TFETask' then begin;
      ProjectTaskList1.CurrentTask.Destroy;
    end;
  end;
end;

procedure TfrmProject.btnPrintClick(Sender: TObject);
begin
  inherited;
  if PrinterSetupDialog.Execute then begin
    if ProjectPageControl.ActivePage = tabAll then begin
      gantAll.PrintSettings.Text := 'All Projects';
      gantAll.Print;
    end else begin
      ProjectGant1.PrintSettings.Text := TitleLabel.Caption;
      ProjectGant1.Print;
    end;
  end;
end;

procedure TfrmProject.cmdCancelClick(Sender: TObject);
var 
  SaveButtonFlag, iExitResult: integer;
  bCancelled: boolean;
begin
  inherited;
{  if CommonLib.MessageDlgXP_Vista('Are you sure you want to lose any changes you may have made?',
                  mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
    self.close;
}

  SaveButtonFlag := 0;
  bCancelled := false;
  // if (qryProjects.Modified) or (qryProjectLines.Modified) then begin
  iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  case iExitResult of
    mrYes: 
      begin 
        bCancelled := false; 
        SaveButtonFlag := 1; 
      end;
    mrNo: 
      begin 
        bCancelled := true; 
        SaveButtonFlag := 0; 
      end;
    mrCancel: Exit;
  end;



  if (not bCancelled) and (SaveButtonFlag = 1) then begin;
    // This bit catches the CANCEL-SAVE? and if save=yes, executes btnCompleted.Click
    // This is done because the CANCEL-SAVE?-YES routine on it's own throws the balance-sheet out, whereas the normal SAVE button doesn't.
    cmdOK.Click;
  end;

  if (SaveButtonFlag = 0) then begin;
    Self.Close
  end;
end;



procedure TfrmProject.ProjectGant1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  // Just trying to capture which task is under mouse
  //label8.caption := FastFuncs.IntToStr(Mouse.CursorPos.x)+' '+FastFuncs.IntToStr(Mouse.CursorPos.y)+' '+ProjectGant1.GetTaskAt(Mouse.CursorPos.X,Mouse.CursorPos.y).DisplayName;
end;

procedure TfrmProject.ProjectPageControlChange(Sender: TObject);
begin
  inherited;
  if ProjectPageControl.ActivePage = tabDesign then begin;
  end else if ProjectPageControl.ActivePage = tabGantt then begin
    RefreshGantt;
    ProjectGant1.LeftDateTime := dtGanttLastDate;
  end else if ProjectPageControl.ActivePage = tabGanttWeek then begin
    RefreshGantt;
    gantWeek.LeftDateTime := dtGanttLastDate;
  end else if ProjectPageControl.ActivePage = tabAll then begin
    RefreshGanttAll;
    gantAll.LeftDateTime := dtGanttAllLastDate
  end else if ProjectPageControl.ActivePage = tabAllWeek then begin
    RefreshGanttAll;
    gantAll.LeftDateTime := dtGanttAllLastDate
  end;
end;

procedure TfrmProject.UpdateProjectLines;
var
  i: integer;
begin
  qryProjectLines.First;

  if ProjectTaskList1.Items.Count = qryProjectLines.RecordCount then begin
    for i := 0 to qryProjectLines.RecordCount - 1 do begin
      qryProjectLines.Edit;
      qryProjectLines.FieldByName('StartDay').AsDateTime := ProjectTaskList1.Items.Items[i].StartDateTime;
      qryProjectLines.FieldByName('EndDay').AsDateTime := ProjectTaskList1.Items.Items[i].EndDateTime;
      qryProjectLines.FieldByName('Progress').AsInteger := ProjectTaskList1.Items.Items[i].Progress;
      qryProjectLines.FieldByName('LineNo').AsInteger := ProjectTaskList1.Items.Items[i].Row;
      qryProjectLines.Post;
      qryProjectLines.Next;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('Mismatch in Task List count', mtError, [mbOK], 0);
  end;
end;

procedure TfrmProject.ProjectTaskGrid1DblClick(Sender: TObject);
begin
  inherited;
  ProjectGant1.LeftDateTime := ProjectTaskList1.CurrentTask.StartDateTime;
end;

procedure TfrmProject.GotoToday1Click(Sender: TObject);
begin
  inherited;
  ProjectGant1.LeftDateTime := Now;
end;

procedure TfrmProject.grdManufExit(Sender: TObject);
begin
  inherited;
  RefreshGantt;
end;

procedure TfrmProject.OpenProject(iProjectID: integer);
begin
  qryProjects.Close;
  qryProjects.ParamByName('ProjectID').asInteger := iProjectID;
  qryProjects.Open;

  qryProjectLines.Close;
  qryProjectLines.ParamByName('ProjectID').asInteger := qryProjects.FieldByName('OrderNumber').AsInteger;
  qryProjectLines.Open;
end;

procedure TfrmProject.FETaskGridAllDblClick(Sender: TObject);
begin
  inherited;

  // Load the new project
  OpenProject(FeTaskGridAll.CurrentTask.Tag);
  ProjectPageControl.ActivePage := tabGantt;
  ProjectPageControlChange(nil);   // PageControlChange event is not fired when changed in program
  ProjectGant1.LeftDateTime := IncWeek(ProjectTaskList1.Items[0].StartDateTime, - 1);
end;

procedure TfrmProject.btnModeClick(Sender: TObject);
begin
  inherited;
(*
  if btnMode.Caption = 'Week Mode' then begin

    btnMode.Caption := 'Month Mode';
    gantAll.Scale := gsHour;
    gantAll.ColWidth := 5;
    gantAll.CaptionDetail.DefaultDisplayFormat := true;
    gantAll.CaptionSummary.DefaultDisplayFormat := true;

    ProjectGant1.Scale := gsHour;
    ProjectGant1.ColWidth := 5;
    ProjectGant1.CaptionDetail.DisplayFormat := ' ';
    ProjectGant1.CaptionSummary.DefaultDisplayFormat := true;

  end else begin

    btnMode.Caption := 'Week Mode';

    gantAll.Scale := gsWeek;
    gantAll.ColWidth := 3;
    gantAll.CaptionDetail.DisplayFormat := 'd';
    gantAll.CaptionSummary.DisplayFormat := 'yyyy' +  #10#13 + 'mmm' + #10#13 + 'dd';

    ProjectGant1.Scale := gsWeek;
    ProjectGant1.ColWidth := 25;
    ProjectGant1.CaptionDetail.DefaultDisplayFormat := true;
    ProjectGant1.CaptionSummary.DefaultDisplayFormat := true;

  end;
  RefreshGantt;
  RefreshGanttAll;
*)
end;

function TfrmProject.GetPrjAddress(iClientID: integer): string;
var
  qry: TMyQuery;
begin
  Result := '';
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT ClientID, Street, Suburb FROM tblClients ' +
        'WHERE ClientID = :xClientID');
      ParamByName('xClientID').asInteger := iClientID;
      Open;
      if not IsEmpty then begin
        Result := qry.FieldByName('Street').AsString + ', ' + qry.FieldByName('Suburb').AsString;
        if Result = ', ' then begin
          Result := 'No Address'
        end;
      end else begin
        Result := 'Address not found';
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmProject.chkShowAddressClick(Sender: TObject);
begin
  inherited;
  if ProjectPageControl.ActivePage = tabGantt then begin
    UpdateProjectLines;
    RefreshGantt;
  end else if ProjectPageControl.ActivePage = tabGanttWeek then begin
    UpdateProjectLines;
    RefreshGantt;
  end else if ProjectPageControl.ActivePage = tabAll then begin
    RefreshGanttAll;
  end else if ProjectPageControl.ActivePage = tabAllWeek then begin
    RefreshGanttAll;
  end;
end;

procedure TfrmProject.ProjectPageControlChanging(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  // we are about to leave the Single Project gant so save the state
  if ProjectPageControl.ActivePage = tabGantt then begin
    UpdateProjectLines;
    dtGanttLastDate := ProjectGant1.LeftDateTime;
  end else if ProjectPageControl.ActivePage = tabGanttWeek then begin
    UpdateProjectLines;
    dtGanttLastDate := gantWeek.LeftDateTime;
  end else if ProjectPageControl.ActivePage = tabAll then begin
    dtGanttAllLastDate := gantAll.LeftDateTime;
  end else if ProjectPageControl.ActivePage = tabAllWeek then begin
    dtGanttAllLastDate := gantAllWeek.LeftDateTime;
  end;
end;

procedure TfrmProject.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  cThisKey := Chr(Key);
  if Shift = [ssCtrl] then begin
    if cThisKey = 'D' then begin
      ProjectPageControl.ActivePage := tabGantt;
      ProjectPageControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'W' then begin
      ProjectPageControl.ActivePage := tabGanttWeek;
      ProjectPageControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'R' then begin
      ProjectPageControl.ActivePage := tabAllWeek;
      ProjectPageControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'O' then begin
      ProjectPageControl.ActivePage := TabSheet1;
      ProjectPageControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'E' then begin
      ProjectPageControl.ActivePage := tabDesign;
      ProjectPageControlChange(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

Initialization
  RegisterClassOnce(TfrmProject);

end.
