unit frmWorkflow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjWorkflow, wwcheckbox, Mask, wwdbedit, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdblook, Wwdotdot, Wwdbcomb (*, Objvideos*);

type
  TfmWorkflow = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    qryworkflow: TERPQuery;
    dsworkflow: TDataSource;
    qryworkflowLines: TERPQuery;
    dsworkflowLines: TDataSource;
    qryworkflowID: TIntegerField;
    qryworkflowDescription: TWideStringField;
    qryworkflowActive: TWideStringField;
    qryworkflowIsERpWorkflow: TWideStringField;
    qryworkflowCreatedBy: TIntegerField;
    Label1: TLabel;
    edtDescription: TwwDBEdit;
    chkActive: TwwCheckBox;
    lblVideo: TLabel;
    qryworkflowLinesID: TIntegerField;
    qryworkflowLinesWorkflowID: TIntegerField;
    qryworkflowLinesformName: TWideStringField;
    qryworkflowLinesControlname: TWideStringField;
    qryworkflowLinesfieldname: TWideStringField;
    qryworkflowLinesGridcomboname: TWideStringField;
    qryworkflowLinesvalue: TWideStringField;
    qryworkflowLinesSeqno: TIntegerField;
    qryworkflowLinesControlParent: TWideStringField;
    qryworkflowLinesEventName: TWideStringField;
    qryworkflowLinesPropname: TWideStringField;
    qryworkflowLineseventtype: TWideStringField;
    qryworkflowLinesshowhint: TWideStringField;
    qryworkflowLinesshowPoint: TWideStringField;
    qryworkflowLinesFormClassName: TWideStringField;
    qryworkflowLinesmstimestamp: TDateTimeField;
    qryworkflowLinesmsupdateSitecode: TWideStringField;
    qryworkflowmstimestamp: TDateTimeField;
    qryworkflowmsupdateSitecode: TWideStringField;
    cmdCancel: TDNMSpeedButton;
    qryworkflowLanguageID: TIntegerField;
    grdworkflowlines: TwwDBGrid;
    btnDelete: TwwIButton;
    Label2: TLabel;
    qryworkflowTabGroup: TIntegerField;
    qryworkflowSkinsGroup: TWideStringField;
    qryworkflowCategory: TWideStringField;
    Label5: TLabel;
    cboCategory: TwwDBLookupCombo;
    QryCategory: TERPQuery;
    lblMsg: TLabel;
    cboSkinsGroup: TwwDBComboBox;
    wwCheckBox1: TwwCheckBox;
    Shape1: TShape;
    qryworkflowVideoName: TWideStringField;
    qryworkflowCompanyName: TWideStringField;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    cboVideos: TwwDBLookupCombo;
    ERPQuery1: TERPQuery;
    QryVideos: TERPQuery;
    Label4: TLabel;
    wwDBEdit2: TwwDBEdit;
    qryworkflowCreatedByName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryworkflowLinesshowhintSetText(Sender: TField; const Text: string);
    procedure qryworkflowLinesshowPointSetText(Sender: TField; const Text: string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdworkflowlinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryworkflowAfterOpen(DataSet: TDataSet);
    procedure cboCategoryNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cboSkinsGroupCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboVideoNameEnter(Sender: TObject);
    procedure cboVideosEnter(Sender: TObject);
    procedure QryVideosBeforeOpen(DataSet: TDataSet);
    procedure cboVideosNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
  private
    WorkFlow: TWorkFlow;
    fbShowHeaderonly:Boolean;
    //fVideoObj:TvideoObj;
    fsvideosLadedforPage:String;

    function SaveRecord: Boolean;
    function getWorkFlowID: Integer;
    Procedure LoadSkingroups;
    //Procedure LoadVideos;
    //function VideoObj:TvideoObj;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetTransConnection(const Value: TERPConnection);Override;
  public
    Property WorkFlowID:Integer read getWorkFlowID;
    Property ShowHeaderonly:boolean read fbShowHeaderonly write fbShowHeaderonly;
  end;


implementation

uses CommonLib, BusObjConst , FormFactory, MAIN, AppEnvironment,Menulib, MainSwitchFrm2,
  DbSharedObjectsObj, CommonDbLib;

{$R *.dfm}

procedure TfmWorkflow.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if accesslevel> 3 then exit;
  if Workflow.Lines.count >0 then
    if MessageDlgXP_Vista('Do you want to delete?', mtConfirmation, [mbyes,mbno], 0)  = mryes then
      Workflow.Lines.Delete;
end;

procedure TfmWorkflow.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrcancel
  else
    Self.Close;
end;

Function TfmWorkflow.SaveRecord :Boolean;
begin
  result:= False;
  WorkFlow.Lines.postdb;
  WorkFlow.PostDB;
  if not(WorkFlow.Save) then exit;
  Result:= True;

end;

procedure TfmWorkflow.SetTransConnection(const Value: TERPConnection);
var
  fiID:Integer;
begin
  inherited SetTransConnection(Value);
  fiID := 0;
  if Assigned(Workflow) then
    if workflow.datasetAssigned and workflow.dataset.active then begin
      fiID := WorkFlow.ID;
      workflow.closedb;
    end;

  workflow.connection.connection := Value;
  if fiID<> 0 then
    workflow.Load(0);


end;

procedure TfmWorkflow.cboVideosEnter(Sender: TObject);
begin
  inherited;
  if QryVideos.ParamByName('Pagename').AsString <>  WorkFlow.SkinsGroup then
    closeDB(QryVideos);
  opendb(Qryvideos);
  end;

procedure TfmWorkflow.cboVideosNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := False;
end;

(*function TfmWorkflow.VideoObj: TvideoObj;
begin
  if fVideoObj = nil then begin
    fVideoObj:=TvideoObj.create(nil);
    fVideoObj.LoadVideos;
  end;
  result := fVideoObj;
end;*)

procedure TfmWorkflow.cboSkinsGroupCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  //WorkFlow.TabGroup := qrySkinsGroup.FieldByName('TabGroup').AsInteger;
  WorkFlow.SkinsGroup := cboSkinsGroup.Text;
end;

procedure TfmWorkflow.cboVideoNameEnter(Sender: TObject);
begin
  inherited;
  //LoadVideos;
end;

procedure TfmWorkflow.cboCategoryNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := True;
end;

procedure TfmWorkflow.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  CommitTransaction;
  WorkFlow.dirty := False;
  if fsModal in FormState then
    ModalResult := mrOk
  else
    Self.Close;
end;

procedure TfmWorkflow.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TWorkFlow       then TWorkFlow(Sender).Dataset      := qryworkflow
    else if sender is TWorkFlowLines  then TWorkFlowLines(Sender).dataset := qryworkflowLines;
  end
  else if (Eventtype = BusObjEvent_Error) then begin
    if (Value = BusObjEventVal_DuplicateDescription) then begin
      CommonLib.MessageDlgXP_Vista('A Workflow with this Description allready exists.',mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TfmWorkflow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmWorkflow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if WorkFlow.Dirty then begin
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
          WorkFlow.Dirty := false;
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

procedure TfmWorkflow.FormCreate(Sender: TObject);
begin
  fsvideosLadedforPage := '';
  //fVideoObj:= nil;
  fbShowHeaderonly:= False;
  AllowCustomiseGrid := true;
  inherited;
  WorkFlow := TWorkFlow.Create(Self);
  WorkFlow.Connection := TMyDacDataConnection.Create(WorkFlow);
  WorkFlow.Connection.Connection:= Self.MyConnection;
  WorkFlow.BusObjEvent := DoBusinessObjectEvent;
  LoadSkingroups;
end;
procedure TfmWorkflow.FormDestroy(Sender: TObject);
begin
  //Freeandnil(fVideoObj);
  Freeandnil(WorkFlow);
  inherited;

end;

procedure TfmWorkflow.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ssCtrl in Shift then
    if (Key = VK_DELETE) and (self.ActiveControl = grdworkflowlines) then begin
      btnDelete.Click;
      Exit;
    end;
  if Key = VK_ESCAPE then Begin
    if MessageDlgXP_Vista('Do you wish to stop the workflow recording?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      try
        MainForm.DoCancelrecording;
        Key := 0;
        Exit;
      except
      end;
    end;
  End;

end;

procedure TfmWorkflow.FormShow(Sender: TObject);
function NewWorkFlowName:String;
var
  ctr:Integer;
  QRy:TERPQuery;
begin
  ctr:= 0;
//  with SharedQryObj do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry do begin
      While True do begin
        Result := Appenv.Employee.employeeName +' - '+  FormatDateTime(FormatSettings.ShortDateFormat +' hh:nn' , now);
        if active then close;
        SQL.clear;
        SQL.add('Select Id from tblworkflow where description = ' +quotedstr(result));
        open;
        if recordcount =0 then Exit;
        ctr:= ctr+1;
        Result := result + inttostr(ctr);
      end;
    end;
  finally
      DbSharedObj.ReleaseObj(qry);
  end;
end;
begin
  inherited;
  try
  if TransConnection <> nil then AssignConnectiontoallQrys(TransConnection);
  GuiPrefs.active := TRue;
  WorkFlow.Load(KeyID);
  BeginTransaction;
  if KeyId = 0 then begin
    WorkFlow.New;
    WorkFlow.Description := NewWorkFlowName;
    WorkFlow.Skinsgroup := MainSwitch2.ActivePageName;
    WorkFlow.PostDB;
  end else if not WorkFlow.Lock then begin
    MessageDlgXP_vista('Access is changed to readonly' + WorkFlow.Userlock.LockMessage, mtWarning, [mbOK], 0);
    Accesslevel := 5;
  end;
  WorkFlow.Lines;
  openQueries;
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesID.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesWorkflowID.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesGridcomboname.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesvalue.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesSeqno.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesControlParent.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesPropname.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLineseventtype.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesshowhint.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesshowPoint.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesFormClassName.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesmstimestamp.FieldName);
  GuiPrefs.DbGridElement[grdworkflowlines].RemoveField(qryworkflowLinesmsupdateSitecode.FieldName);
  grdworkflowlines.Visible := True;
  Self.Height:= 591;
  if ShowHeaderonly then begin
    Self.Height := self.Height - grdworkflowlines.Height;
    grdworkflowlines.Visible := False;
    timerMsg(lblMsg , 'Please Give a name for the new Workflow');
  end;
  if WorkFlow.IsERpWorkflow and not(Devmode) then begin
    MessageDlgXP_vista('This is one of the ERP workflow and you are not allowed to change it. Access level is changed to Read-only', mtWarning, [mbOK], 0);
    Accesslevel := 5;
  end;
  Except
    On E:Exception do begin
      if devmode then
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

function TfmWorkflow.getWorkFlowID: Integer;
begin
  REsult := WorkFlow.ID;
end;

procedure TfmWorkflow.grdworkflowlinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Field.readonly then AFont.color := clInactiveCaption;
end;

procedure TfmWorkflow.LoadSkingroups;
var
  OrigCategories :TStringList;
  SortedCategories :TStringList;
begin
  cboSkinsGroup.Items.Clear;

  OrigCategories   := TStringList.Create;
  SortedCategories := TStringList.Create;
  try
    Menulib.DefaultCategories(OrigCategories, nil , SortedCategories, nil);
    cboSkinsGroup.Items.TExt :=SortedCategories.Text;
  finally
    FreeandNil(OrigCategories);
    FreeandNil(SortedCategories);
  end;

end;

procedure TfmWorkflow.QryVideosBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryVideos.ParamByName('Pagename').AsString := WorkFlow.SkinsGroup;
end;

(*procedure TfmWorkflow.LoadVideos;
var
  i1, i2:Integer;
begin
  if sametext(fsvideosLadedforPage ,Workflow.skinsGroup) then exit;
    cboVideoName.Items.Clear;
    if Workflow.skinsGroup = '' then exit;
    if VideoObj.count =0 then exit;
    for i1 := 0 to VideoObj.count-1 do begin
      if sametext(VideoObj.items[i1].PageName , Workflow.skinsGroup) then begin
        if VideoObj.items[i1].count =0 then exit;
        for i2 := 0 to VideoObj.items[i1].count-1 do begin
          cboVideoName.Items.Add(VideoObj.items[i1].items[i2].VideoCaption);
        end;
        fsvideosLadedforPage := Workflow.skinsGroup;
        Exit;
      end;
    end;
end;*)

procedure TfmWorkflow.qryworkflowAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtDescription.ReadOnly := (accesslevel >3); // or (KeyID<>0);
end;

procedure TfmWorkflow.qryworkflowLinesshowhintSetText(Sender: TField; const Text: string);
begin
  inherited;
  WorkFlow.Lines.Showhint := Text='T';
  WorkFlow.Lines.Dataset.Refresh;

end;

procedure TfmWorkflow.qryworkflowLinesshowPointSetText(Sender: TField; const Text: string);
begin
  inherited;
  WorkFlow.Lines.ShowPoint := Text='T';
  WorkFlow.Lines.Dataset.Refresh;
end;

initialization
  RegisterClassOnce(TfmWorkflow);
  with FormFact do begin
    //RegisterMe(TfmWorkflow, 'TWorkflowsGUI_*=ID');
  end;
end.

