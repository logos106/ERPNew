unit frmTasks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Mask, wwdbedit, wwclearbuttongroup, wwradiogroup, DNMSpeedButton,
  Shader, DNMPanel, DBCtrls, wwdbdatetimepicker, busobjtasks, BusObjBase,
  ProgressDialog, wwdblook , busobjERPVideo, ActnList, DNMAction, Grids,
  Wwdbigrd, Wwdbgrid, Buttons, wwcheckbox, frmAttachments;

type
  TfmTasks = class(TBaseInputGUI)
    QryTasks: TERPQuery;
    dsTasks: TDataSource;
    QryTasksGlobalref: TWideStringField;
    QryTasksID: TIntegerField;
    QryTasksTasktype: TWideStringField;
    QryTasksVersionNo: TWideStringField;
    QryTasksCreatedOn: TDateTimeField;
    QryTasksEnteredByID: TIntegerField;
    QryTasksEnteredBy: TWideStringField;
    QryTasksSubject: TWideStringField;
    QryTasksDetails: TWideMemoField;
    QryTaskserphelpdocDesc: TWideStringField;
    QryTasksEstimatedHrs: TFloatField;
    QryTasksPercentagedone: TFloatField;
    QryTasksmstimeStamp: TDateTimeField;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    Label2: TLabel;
    SaleDate_Label: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    opttype: TwwRadioGroup;
    edtVersion: TwwDBEdit;
    cboCreationDate: TwwDBDateTimePicker;
    edName: TwwDBEdit;
    DBMemo1: TDBMemo;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    QryPagenames: TERPQuery;
    QryPagenamesPagename: TWideStringField;
    cboPagename: TwwDBLookupCombo;
    Label7: TLabel;
    QryTasksmsUpdateSiteCode: TWideStringField;
    btnVideo: TDNMSpeedButton;
    ActionList1: TActionList;
    actVideo: TDNMAction;
    OpenDialog1: TOpenDialog;
    edtHelp: TwwDBEdit;
    lblHelp: TLabel;
    QryTasksHelpcontextID: TIntegerField;
    QryTaskPages: TERPQuery;
    dsTasksPages: TDataSource;
    wwDBGrid1: TwwDBGrid;
    QryTaskPagesID: TIntegerField;
    QryTaskPagesGlobalref: TWideStringField;
    QryTaskPagesTaskID: TIntegerField;
    QryTaskPagesPageName: TWideStringField;
    QryTaskPagesmsTimeStamp: TDateTimeField;
    QryTaskPagesmsUpdateSiteCode: TWideStringField;
    QryTaskPagesActive: TWideStringField;
    chkActive: TwwCheckBox;
    QryTasksActive: TWideStringField;
    wwDBGrid1IButton: TwwIButton;
    QryTasksHyperlinkText: TWideStringField;
    Label8: TLabel;
    wwDBEdit3: TwwDBEdit;
    QryCustomer: TERPQuery;
    QryCustomerCompany: TWideStringField;
    QryCustomerClientCode: TWideStringField;
    cbocustomer: TwwDBLookupCombo;
    QryTasksCustomerName: TWideStringField;
    QryTasksClientCode: TWideStringField;
    Label9: TLabel;
    QryTasksSeqno: TIntegerField;
    QryTasksTaskNo: TIntegerField;
    edTaskNo: TwwDBEdit;
    pnlAttachments: TPanel;
    Label1: TLabel;
    lblID: TLabel;
    edtID: TwwDBEdit;
    Label10: TLabel;
    qryERPHelpDocs: TERPQuery;
    qryERPHelpDocsDescription: TWideStringField;
    qryERPHelpDocsFiletype: TWideStringField;
    wwDBLookupCombo1: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure QryTasksAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure actVideoUpdate(Sender: TObject);
    procedure actVideoExecute(Sender: TObject);
    procedure QryTasksAfterInsert(DataSet: TDataSet);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure QryTasksAfterPost(DataSet: TDataSet);

  private
    TaskObj :TTasks;
    fERPVideo :TERPVideo;
    fstaskType: String;
    AttachmentForm : TfmAttachments;
    function ERPVideo :TERPVideo;

  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function SaveOrCancelChanges: boolean;Override;
    procedure InitAttachments;
  public
    Property taskType :String read fstaskType write fstaskType;
  end;


implementation

uses CommonLib , BusObjConst, FormFactory, ERPLib, CommonFormLib, frmERPVideo,
  tcConst, ERPMessageTypes;

{$R *.dfm}
(*procedure TfmTasks.actVideoExecute(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmERPVideo' , ERPVideo.ID , InitTaskDetailsERPVideo , InitERPVideoType);
end;
procedure TfmTasks.InitERPVideoType(Sender: TObject);
begin
  if not (Sender is  TfmERPVideo) then exit;
  TfmERPVideo(Sender).VideoType := vtTask;
end;
procedure TfmTasks.InitTaskDetailsERPVideo(Sender: TObject);
begin
  if not (Sender is  TfmERPVideo) then exit;
  if TfmERPVideo(Sender).KeyID =0 then begin
    TfmERPVideo(Sender).ERPVideoObj.Pagename := TaskObj.Pagename;
    TfmERPVideo(Sender).ERPVideoObj.PageCaption := TaskObj.Subject;
    TfmERPVideo(Sender).ERPVideoObj.PostDB;
  end;
  Setcontrolfocus(TfmERPVideo(Sender).btnchoosefile);
  TfmERPVideo(Sender).btnchoosefile.Click;
end;*)
procedure TfmTasks.actVideoExecute(Sender: TObject);
var
  filepath, fsFilename:String;
begin
  inherited;
  TaskObj.PostDB;
  if not(TaskObj.ValidateData) then exit;
  TaskObj.Connection.BeginNestedTransaction;
  try
    if not OpenDialog1.Execute then exit;
    fsfilename := Opendialog1.FileName;
    if fsfilename = '' then exit;
    if ERPVideo.count =0 then begin
      ERPVideo.New;
      //ERPVideo.Pagename   := TaskObj.TasksPages.PageName;
      //ERPVideo.PageIndex  := QryPagenamesPageindex.AsInteger;
      ERPVideo.PageCaption:= TaskObj.Subject;
      ERPVideo.video_type := vtTask;
      ERPVideo.PostDB;
    end;
    ERPVideo.EditDB;
    TBlobfield(ERPVideo.Dataset.FieldByName('video')).LoadFromFile(fsfilename);
    filepath := ExtractShortPathName(ExtractFilePath(fsFilename));
    ERPVideo.filename :=ExtractFileName(fsFilename);
    ERPVideo.PostDB;
    (*for ctr:= 1 to TaskObj.TasksPages.count do begin
      ERPVideo.VideoPages.New;
      ERPVideo.VideoPages.Pagename   := TaskObj.TasksPages.PageName;
      ERPVideo.VideoPages.PostDB;
      TaskObj.TasksPages.Next;
    end;*)
    if not(Sametext(ExtractFilePath(fsFilename) , VideofilenamewithPath)) and not(Sametext(ExtractShortPathName(ExtractFilePath(fsFilename)) , VideofilenamewithPath))  then
      try
        CopyFile(pchar(fsfilename ), pchar(VideofilenamewithPath(ERPVideo.filename)), true);
      Except
      end;
    if not ERPVideo.ValidateData then begin
      TaskObj.Connection.RollbackNestedTransaction;
      Exit;
    end;
    if not ERPVideo.Save then begin
      TaskObj.Connection.RollbackNestedTransaction;
      Exit;
    end;
    TaskObj.Connection.CommitNestedTransaction;
  Except
    on E:Exception do begin
      TaskObj.Connection.RollbackNestedTransaction;
    end;
  end;
end;

procedure TfmTasks.actVideoUpdate(Sender: TObject);
begin
  inherited;
  if actVideo.Visible then
    if (ERPVideo.filename <> '') then  ShowControlhint(btnVideo , 'Video Already created :' + Quotedstr(ERPVideo.filename+'.'+NL+'This will let you Choose Another Video.')+NL)
    else ShowControlhint(btnVideo , 'Choose the Video');
end;

procedure TfmTasks.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTasks.btnNewClick(Sender: TObject);
begin
  inherited;
  if not TaskObj.Save then Exit;
  TaskObj.dirty := False;
  TaskObj.Connection.CommitTransaction;
  TaskObj.connection.BeginTransaction;
  TaskObj.New;
  Setcontrolfocus(opttype);
end;

procedure TfmTasks.btnSaveClick(Sender: TObject);
begin
  inherited;
  if TaskObj.Save then begin
    TaskObj.dirty := False;
    TaskObj.Connection.CommitTransaction;
    self.close;
  end;
end;

procedure TfmTasks.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType,Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTasks then TTasks(Sender).Dataset   := QryTasks
        else if Sender is TTasksPages then TTasksPages(Sender).Dataset   := QryTaskPages;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_BeforeOpen) then begin
        if Sender is TERPVideo then begin
          doshowProgressbar(1 , 'Checking for the Task Video');
          DoStepProgressbar;
        end;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
        if Sender is TERPVideo then doHideProgressbar;
    end;
end;

function TfmTasks.ERPVideo: TERPVideo;
begin
  fERPVideo.LoadSelect((*'Pagename =' + quotedstr(TaskObj.TasksPages.pagename)+' and '+*)' PageCaption = ' + quotedstr(TaskObj.Subject)+' and Videotype =' +quotedstr(VideoTypeToString(vtTask)));
  result := fERPVideo;
end;

procedure TfmTasks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTasks.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := SaveorcancelChanges;
end;

procedure TfmTasks.FormCreate(Sender: TObject);
Procedure AddTasktype(const Taskname, taskValue:String);
begin
   opttype.items.add(Taskname) ;
   opttype.Values.add(taskValue);
end;
begin
  inherited;
  taskType := '';
  TaskObj := TTasks.Create(Self);
  TaskObj.connection := TMyDacdataconnection.create(TaskObj);
  TaskObj.connection.connection := Self.MyConnection;
  TaskObj.BusObjEvent := DoBusinessObjectEvent;

  fERPVideo :=TERPVideo.Create(Self);
  fERPVideo.connection := TaskObj.connection;
  fERPVideo.BusObjEvent := DoBusinessObjectEvent;

  opttype.items.Clear; opttype.Values.Clear;
  AddTasktype(ERPMESSAGE_FEATURE  , ERPMESSAGE_FEATURE);
  AddTasktype(ERPMESSAGE_Bug      , ERPMESSAGE_Bug);
  AddTasktype(ERPMESSAGE_Tablet   , ERPMESSAGE_Tablet);
  AddTasktype(ERPMESSAGE_Website  , ERPMESSAGE_Website);

  opttype.columns := 4;
  if IsERPCustomEnabled then begin
    AddTasktype(ERPMESSAGE_TIP    , ERPMESSAGE_TIP);
    AddTasktype(ERPMESSAGE_Popup  , ERPMESSAGE_Popup);
    opttype.columns := 6;

    actVideo.Visible := TRue;
    edtHelp.visible := True;
    lblHelp.visible := True;
  end else begin
    actVideo.Visible := False;
    edtHelp.visible := False;
    lblHelp.visible := False;
  end;
end;

procedure TfmTasks.FormDestroy(Sender: TObject);
begin
  Freeandnil(fERPVideo);
  inherited;

end;

procedure TfmTasks.FormShow(Sender: TObject);
begin
  inherited;
  TaskObj.Load(KeyId);
  TaskObj.connection.BeginTransaction;
  if KeyId =0 then TaskObj.New;
  TaskObj.TasksPages;
  OpenQueries;

  lblID.Visible := IsERPCustomEnabled ;
  edtID.Visible := IsERPCustomEnabled ;
end;

procedure TfmTasks.InitAttachments;
begin
  TaskObj.PostDB;
  if TaskObj.ID =0 then exit;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,TaskObj.ID));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblTasks';
  end;
  if AttachmentForm.TableId <> TaskObj.ID then begin
    AttachmentForm.TableId := TaskObj.ID;
    AttachmentForm.Tag := TaskObj.ID;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

procedure TfmTasks.QryTasksAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if taskType <> '' then QryTasksTasktype.AsString :=taskType;
end;

procedure TfmTasks.QryTasksAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ERPVideo.ID;
  InitAttachments;
end;

procedure TfmTasks.QryTasksAfterPost(DataSet: TDataSet);
begin
  inherited;
  InitAttachments;
end;

function TfmTasks.SaveOrCancelChanges: boolean;
var
  iExitResult: integer;
begin
  REsult := true;
  if TaskObj.Dirty = False then exit;

      iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes:
          begin
            result := TaskObj.Save;
            if result then begin
              CommitTransaction;
              Notify(False);
            end;
          end;
        mrNo:
          begin;
            RollbackTransaction;
            Notify(True);
            REsult := true;
          end;
        mrCancel: REsult := false;
      end;
end;

procedure TfmTasks.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not TaskObj.TasksPages.Active then AFont.Color := clDkGray;
end;

procedure TfmTasks.wwDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if not TaskObj.TasksPages.Active  then begin
    if MessageDlgXP_vista('This Page is deleted for this task. Do you want to restore it?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    TaskObj.TasksPages.Active := True;
    TaskObj.TasksPages.PostDB;
  end;
end;

procedure TfmTasks.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  TaskObj.TasksPages.PostDB;
  if TaskObj.TasksPages.Count =0 then exit;
  if not TaskObj.TasksPages.Active then exit;
  TaskObj.TasksPages.Active := False;
  TaskObj.TasksPages.PostDb;
end;

initialization
  RegisterClassOnce(TfmTasks);
  with FormFact do begin
    RegisterMe(TfmTasks, 'TTasksGUI_*=ID');
  end;

end.

