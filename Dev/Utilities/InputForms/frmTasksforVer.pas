unit frmTasksforVer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, busobjtasks, Grids, Wwdbigrd, Wwdbgrid, wwradiogroup,
  wwclearbuttongroup;

type
  TfmTasksforVer = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    btnMoveItemUp: TDNMSpeedButton;
    btnMoveItemDown: TDNMSpeedButton;
    QryTasks: TERPQuery;
    QryTasksGlobalref: TWideStringField;
    QryTasksID: TIntegerField;
    QryTasksTasktype: TWideStringField;
    QryTasksVersionNo: TWideStringField;
    QryTasksCreatedOn: TDateTimeField;
    QryTasksEnteredByID: TIntegerField;
    QryTasksEnteredBy: TWideStringField;
    QryTasksSubject: TWideStringField;
    QryTasksDetails: TWideMemoField;
    QryTasksEstimatedHrs: TFloatField;
    QryTasksPercentagedone: TFloatField;
    QryTasksmstimeStamp: TDateTimeField;
    QryTasksmsUpdateSiteCode: TWideStringField;
    QryTasksHelpcontextID: TIntegerField;
    QryTasksActive: TWideStringField;
    QryTasksHyperlinkText: TWideStringField;
    QryTasksCustomerName: TWideStringField;
    QryTasksClientCode: TWideStringField;
    QryTasksSeqno: TIntegerField;
    dsTasks: TDataSource;
    grdTasks: TwwDBGrid;
    DNMPanel5: TDNMPanel;
    grpFilters: TwwRadioGroup;
    optExtra: TRadioGroup;
    Label3: TLabel;
    lblTotal: TLabel;
    QryTasksTaskNo: TIntegerField;
    btnReorder: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoChangeTaskOrder(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);
    procedure QryTasksAfterOpen(DataSet: TDataSet);
    procedure grdTasksCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnReorderClick(Sender: TObject);
    procedure grdTasksDblClick(Sender: TObject);
  private
    TasksObj: TTasks;
    fsVersionNo: String;
    fiTaskNo :Integer;
    fiID:Integer;
    fiOldTaskNo:Integer;
    function SaveRecord: Boolean;
    procedure setVersionNo(const Value: String);
    procedure ChangeTaskOrder(id1, id2: Integer);
    procedure Callback_changeTaskno(Const Sender: TBusObj; var Abort: boolean);
    procedure Callback_ReOrder(Const Sender: TBusObj; var Abort: boolean);
    procedure Callback_ReCount(Const Sender: TBusObj; var Abort: boolean);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property VersionNo : String read fsVersionNo write setVersionNo;
  end;


implementation

uses CommonLib, BusObjConst, tcConst, LogLib, ERPLib, CommonFormLib;

{$R *.dfm}
procedure TfmTasksforVer.btnReorderClick(Sender: TObject);
var
  fId:Integer;
begin
  inherited;
  fId :=Tasksobj.ID;
  Tasksobj.IterateRecords(Callback_ReOrder);
  Tasksobj.closedb;
  Tasksobj.Opendb;
  Tasksobj.Locate(Tasksobj.Idfieldname , fId , []);
  if MessageDlgXP_Vista('Do You Wish To Re Count? ', mtWarning, [mbYes, mbNo], 0) = mrno then exit;

  fiTaskNo := 1;
  Tasksobj.IterateRecords(Callback_ReCount);
  Tasksobj.closedb;
  Tasksobj.Opendb;
  Tasksobj.Locate(Tasksobj.Idfieldname , fId , []);
end;

procedure TfmTasksforVer.Callback_ReOrder(Const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TTasks) then exit;
  TTasks(Sender).Seqno := TTasks(Sender).Taskno;
  TTasks(Sender).PostDB;
end;
procedure TfmTasksforVer.Callback_ReCount(Const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TTasks) then exit;
  TTasks(Sender).Taskno:= fiTaskNo;
  TTasks(Sender).Seqno := fiTaskNo;
  TTasks(Sender).PostDB;
  fiTaskNo := fiTaskNo +1;
end;

procedure TfmTasksforVer.ChangeTaskOrder(id1,id2:Integer);
var
  seqno1,seqno2 :Integer;
begin
    if TasksObj.id <> id1 then TasksObj.Locate(TasksObj.IDfieldname , id1, []);
    if not TasksObj.Lock then begin
      MessageDlgXP_Vista(TasksObj.UserLock.LockMessage+NL+NL+'You cannot change the sequence', mtWarning, [mbOK], 0);
      exit;
    end;
    seqno1 := TasksObj.Seqno;


    if TasksObj.id <> id2 then TasksObj.Locate(TasksObj.IDfieldname , id2, []);
    if not TasksObj.Lock then begin
      MessageDlgXP_Vista(TasksObj.UserLock.LockMessage+NL+NL+'You cannot change the sequence', mtWarning, [mbOK], 0);
      exit;
    end;
    seqno2 := TasksObj.Seqno;

    if TasksObj.id <> id2 then TasksObj.Locate(TasksObj.IDfieldname , id2, []);
    TasksObj.Seqno :=Seqno1;
    TasksObj.PostDB;

    if TasksObj.id <> id1 then TasksObj.Locate(TasksObj.IDfieldname , id1, []);
    TasksObj.Seqno :=Seqno2;
    TasksObj.PostDB;
    TasksObj.Dirty := True;
end;
procedure TfmTasksforVer.DoChangeTaskOrder(Sender: TObject);
var
  id1,id2:Integer;
begin
  inherited;
  if TasksObj.count =1 then exit;
  id1:= 0;

  if (sender = btnMoveItemUp) AND (TasksObj.Bof) then exit;
  if (sender = btnMoveItemDown) AND (TasksObj.eof) then exit;
  TasksObj.dataset.DisableControls;
  try
    id1 :=TasksObj.Id;
    if (sender = btnMoveItemUp)  then TasksObj.Prior;
    if (sender = btnMoveItemDown) then TasksObj.Next;
    id2 := TasksObj.ID;
    ChangeTaskOrder(id1,id2);
  finally
    TasksObj.closedb;
    TasksObj.OpenDB;
    TasksObj.Locate(TasksObj.IDfieldname , id1, []);
    TasksObj.dataset.Enablecontrols;
    grdTasks.selectrecord;
    Setcontrolfocus(grdTasks);
  end;
end;

procedure TfmTasksforVer.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmTasksforVer.SaveRecord :Boolean;
begin
  result:= False;
  TasksObj.PostDB;
  if not(TasksObj.Save) then exit;
  Result:= True;

end;

procedure TfmTasksforVer.setVersionNo(const Value: String);
begin
  fsVersionNo := Value;
  TitleLabel.Caption := 'Tasks for Version :' + Quotedstr(Value);
end;

procedure TfmTasksforVer.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  TasksObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmTasksforVer.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTasks then TTasks(Sender).Dataset  := QryTasks;
     end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_Taskno) then begin
      if sender is TTasks then begin
        fiTaskNo := TTasks(Sender).Taskno;
        fiId := TTasks(Sender).ID;
        fioldtaskno := TTasks(Sender).Dataset.fieldbyname('Taskno').oldvalue;
        TTasks(Sender).PostDB;
        TTasks(Sender).IterateRecords(Callback_changeTaskno);
        TTasks(Sender).Locate(TTasks(Sender).Idfieldname,fiId , []);
      end;
     end;
end;
procedure TfmTasksforVer.Callback_changeTaskno(Const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TTasks) then exit;
  if (TTasks(Sender).Id <> fiId) and (TTasks(Sender).Taskno = fiTaskno) then begin
    if fioldtaskno <> 0 then TTasks(Sender).Taskno := fioldtaskno
    else TTasks(Sender).Taskno := TTasks(Sender).nextTasknoforVersion;
    TTasks(Sender).PostDB;
    abort := True;
  end;
end;
procedure TfmTasksforVer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTasksforVer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if TasksObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          TasksObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmTasksforVer.FormCreate(Sender: TObject);
begin
  inherited;
  TasksObj := TTasks.CreateWithNewConn(Self);
  TasksObj.Connection.connection := Self.MyConnection;
  TasksObj.BusObjEvent := DoBusinessObjectEvent;
  TasksObj.SQLOrder := 'Seqno';
  TasksObj.LockGroupName :='Tasks for Version';
end;
procedure TfmTasksforVer.FormShow(Sender: TObject);
begin
  inherited;
  //TasksObj.Load(KeyID);
  optExtra.itemindex := 0;
  TasksObj.LoadSelect('VersionNo =' + quotedstr(VersionNo));
  TasksObj.connection.BeginTransaction;
  openQueries;

  btnReorder.visible := IsERPCustomEnabled;
  if IsERPCustomEnabled and (Accesslevel <=3)  then begin
    grdTasks.options := grdTasks.options  + [dgEditing];
    grdTasks.options := grdTasks.options  - [dgRowSelect];
    QryTasksTaskNo.readonly := False;
  end;

end;

procedure TfmTasksforVer.grdTasksCalcCellColors(Sender: TObject; Field: TField;  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if optExtra.itemindex =2 then begin
    if QryTasksActive.asboolean =False then begin
      ABrush.color := Inactivefontcolor;
    end;
  end;
end;

procedure TfmTasksforVer.grdTasksDblClick(Sender: TObject);
//var
//  fino:Integer;
begin
  inherited;
   if Tasksobj.Id =0 then exit;
  if not SaveRecord then exit;
  TasksObj.Connection.CommitTransaction;
  OpenERPForm('TfmTasks' , TasksObj.Id);
  closewait;
  (*if sametext(TField(grdTasks.GetActiveField).fieldname , QryTaskstaskno.FieldName) then begin
        fino := CustomInputInteger('Tasks No' , 'Task no =' + inttostr(Tasksobj.Taskno)+', Change to : ' );
        if fino <> 0 then
          Tasksobj.Taskno := fino;
  end;*)
end;

procedure TfmTasksforVer.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
  inherited;
    s:= '';
  try
    if  grpFilters.ItemIndex >= 7 then s := ''
    else if  grpFilters.ItemIndex = 0 then s := ' tasktype ='+Quotedstr('Bug') +' or tasktype ='+Quotedstr('Feature')
    else s := ' tasktype =' + quotedstr(Trim(grpFilters.items[grpFilters.itemindex]));
    if optExtra.itemindex = 2 then else begin
      if trim(s) <> '' then s := '('+ s +') and ';
      if optExtra.itemindex =1 then s := s +' active =' + Quotedstr('F')
      else s := s +' active =' + Quotedstr('T');
    end;
  finally
    QryTasks.filter := s;
  end;

  QryTasks.filtered := QryTasks.filter <> '';
  cLog(QryTasks.SQL.Text+NL+QryTasks.Filter);
  lblTotal.caption := inttostr(QryTasks.recordcount);
  lblTotal.REfresh;
end;

procedure TfmTasksforVer.QryTasksAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cLog(QryTasks.SQL.Text+NL+QryTasks.Filter);
  lblTotal.caption := inttostr(QryTasks.recordcount);
  lblTotal.REfresh;
end;

initialization
  RegisterClassOnce(TfmTasksforVer);

end.

