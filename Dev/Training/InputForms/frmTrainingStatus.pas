unit frmTrainingStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, StdCtrls, Shader, ExtCtrls,
  DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, Grids, Wwdbigrd, Wwdbgrid,
  BusobjTraining, BusObjBase, Mask, wwdbedit, wwdblook, Wwdbdlg, Buttons,
  frmBaseTraining, TeeProcs, TeEngine, Chart, DBChart, Series, ProgressDialog;

type
  TfmTrainingStatus = class(TfmBaseTraining)
    QrytrainingemployeemoduleStatus: TERPQuery;
    dstrainingemployeemoduleStatus: TDataSource;
    QrytrainingemployeemoduleStatusGlobalRef: TWideStringField;
    QrytrainingemployeemoduleStatustrainingemployeemoduleStatusID: TIntegerField;
    QrytrainingemployeemoduleStatusEmployeeId: TIntegerField;
    QrytrainingemployeemoduleStatusEmployeeName: TWideStringField;
    QrytrainingemployeemoduleStatusModuleId: TIntegerField;
    QrytrainingemployeemoduleStatusModulename: TWideStringField;
    QrytrainingemployeemoduleStatusVideoWatched: TWideStringField;
    QrytrainingemployeemoduleStatusVideoWatchedon: TDateTimeField;
    QrytrainingemployeemoduleStatusDateStarted: TDateTimeField;
    QrytrainingemployeemoduleStatusDatefinished: TDateTimeField;
    QrytrainingemployeemoduleStatusmstimestamp: TDateTimeField;
    qryTrainingEmployeeModuleStatusDetails: TERPQuery;
    qryTrainingEmployeeModuleStatusDetailsTasktitle: TWideStringField;
    qryTrainingEmployeeModuleStatusDetailsTaskDescription: TWideStringField;
    qryTrainingEmployeeModuleStatusDetailsDone: TWideStringField;
    qryTrainingEmployeeModuleStatusDetailsDoneon: TDateTimeField;
    qryTrainingEmployeeModuleStatusDetailsTaskID: TIntegerField;
    qryTrainingEmployeeModuleStatusDetailsGlobalRef: TWideStringField;
    qryTrainingEmployeeModuleStatusDetailsTrainingEmployeeModuleStatusDetailsID: TIntegerField;
    qryTrainingEmployeeModuleStatusDetailstrainingemployeemoduleStatusID: TIntegerField;
    qryTrainingEmployeeModuleStatusDetailsmstimestamp: TDateTimeField;
    qryTrainingEmployeeModuleStatusDetailsSeqNo: TLargeintField;
    QryTESGraph: TERPQuery;
    QryTESGraphGlobalRef: TWideStringField;
    QryTESGraphtrainingemployeemoduleStatusID: TIntegerField;
    QryTESGraphEmployeeId: TIntegerField;
    QryTESGraphEmployeeName: TWideStringField;
    QryTESGraphModuleId: TIntegerField;
    QryTESGraphModulename: TWideStringField;
    QryTESGraphVideoWatched: TWideStringField;
    QryTESGraphVideoWatchedon: TDateTimeField;
    QryTESGraphDateStarted: TDateTimeField;
    QryTESGraphDatefinished: TDateTimeField;
    QryTESGraphmstimestamp: TDateTimeField;
    
    qrytrainingmoduletask: TERPQuery;
    qrytrainingmoduletaskTrainingModuleTaskID: TIntegerField;
    qrytrainingmoduletaskSeqno: TIntegerField;
    qrytrainingmoduletaskTrainingModuleTaskTitle: TWideStringField;
    qrytrainingmoduletaskTrainingModuleTaskDescription: TWideMemoField;
    QrytrainingemployeemoduleStatuslk: TERPQuery;
    QrytrainingemployeemoduleStatusAllentries: TIntegerField;
    QrytrainingemployeemoduleStatusNotdone: TIntegerField;
    QrytrainingemployeemoduleStatusDonestatus: TWideStringField;
    QrytrainingemployeemoduleStatusVideofilename: TWideStringField;
    QrytrainingemployeemoduleStatusiDetails: TIntegerField;
    QrytrainingemployeemoduleStatusiVideo: TIntegerField;
    QrytrainingemployeemoduleStatuslkDoneStatus: TWideStringField;
    QrytrainingemployeemoduleStatuslktrainingemployeemoduleStatusID: TIntegerField;
    QrytrainingemployeemoduleStatuslkAllentries: TLargeintField;
    QrytrainingemployeemoduleStatuslkDone: TFloatField;
    QrytrainingemployeemoduleStatuslknotDone: TFloatField;
    QrytrainingemployeemoduleStatuslkVideofilename: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    DBChart1: TDBChart;
    QrytrainingemployeemoduleStatusDone: TIntegerField;
    Series2: THorizBarSeries;
    grdDetails: TwwDBGrid;
    dsTESGraph: TDataSource;
    QryTESGraphAllentries: TIntegerField;
    QryTESGraphNotdone: TIntegerField;
    QryTESGraphDonestatus: TWideStringField;
    QryTESGraphVideofilename: TWideStringField;
    QryTESGraphDone: TIntegerField;
    Series1: THorizBarSeries;
    btnVideo: TDNMSpeedButton;
    btnDetails: TDNMSpeedButton;
    QrytrainingemployeemoduleStatusModuleSeqNo: TIntegerField;
    btnHelp: TDNMSpeedButton;
    QrytrainingemployeemoduleStatusTrainingID: TLargeintField;
    Label11: TLabel;
    cboTraining: TwwDBLookupCombo;
    qryTrainingLookup: TERPQuery;
    WideStringField2: TWideStringField;
    WideStringField1: TWideStringField;
    LargeintField1: TLargeintField;
    DateField1: TDateField;
    DateTimeField1: TDateTimeField;
    IntegerField1: TIntegerField;
    WideStringField3: TWideStringField;
    TimeField1: TTimeField;
    TimeField2: TTimeField;
    FloatField1: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure QrytrainingemployeemoduleStatusCalcFields(DataSet: TDataSet);
    procedure grdDetailsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdDetailsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDetailsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdDetailsEnter(Sender: TObject);
    procedure QrytrainingemployeemoduleStatuslkCalcFields(
      DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure QrytrainingemployeemoduleStatusAfterClose(DataSet: TDataSet);
    procedure QrytrainingemployeemoduleStatusAfterOpen(DataSet: TDataSet);
    procedure grdDetailsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure btnVideoClick(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure cboTrainingCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fiEmployeeId: Integer;
    TEMS: TTrainingEmployeeModuleStatus;
    fiTrainingId: integer;
    Procedure TrainingStatusForModule(Sender:TObject);
    Procedure Loadform;

  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    Property EmployeeId :Integer Read fiEmployeeId Write fiEmployeeId;
    property TrainingID : integer read fiTrainingId write fiTrainingID;
    Procedure Showvideo;
    Procedure onShowERPHint(Const Value:Integer); override;
  end;

implementation

uses CommonLib, FastFuncs, CommonFormLib, BusObjConst,
  frmTrainingStatusDetails, AppEnvironment, (*Objvideos, *)FileDownloadFuncs  , ShellAPI,
  datTraining, tcDataUtils, MessageInterface, AppHelpProcessorObj(*,
  frmVideoPlayer, DNMLib*), CommonDbLib, UpdaterConst, ERPVideosLib;

{$R *.dfm}
procedure TfmTrainingStatus.FormCreate(Sender: TObject);
begin
  inherited;
  fiEmployeeId:= 0;
  TEMS:= TTrainingEmployeeModuleStatus.create(Self);
  TEMS.connection := TMyDacDataConnection.create(TEMS);
  TEMS.Connection.Connection := Self.MyConnection;
  TEMS.BusObjEvent := DoBusinessObjectEvent;
end;


procedure TfmTrainingStatus.QrytrainingemployeemoduleStatusCalcFields(
  DataSet: TDataSet);
begin
  inherited;
(*  QrytrainingemployeemoduleStatus_Details.asString := '. . .';
  QrytrainingemployeemoduleStatusVideo.asString := '. . .';*)
  QrytrainingemployeemoduleStatusiDetails.asInteger := 2;
  QrytrainingemployeemoduleStatusiVideo.asInteger := 3;
end;

procedure TfmTrainingStatus.grdDetailsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sysutils.SameText(Field.FieldName ,'Details') then begin
      ABrush.color := clInactiveCaption;
  end;
end;

procedure TfmTrainingStatus.grdDetailsDblClick(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(grdDetails.getactiveField.fieldname , 'iDetails') then begin
    TEMS.postDB;
    OpenERPFormModal('TfmTrainingStatusDetails' , 0 ,TrainingStatusForModule);
    Loadform;
  end else if Sysutils.SameText(grdDetails.GetActivefield.fieldname, 'ivideo') then begin
    ShowVideo;
    Loadform;
  end;
end;

procedure TfmTrainingStatus.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTrainingEmployeeModuleStatus then TTrainingEmployeeModuleStatus(Sender).Dataset:= QrytrainingemployeemoduleStatus;
        if Sender is TTrainingEmployeeModuleStatusDetails then TTrainingEmployeeModuleStatusDetails(Sender).Dataset:= qryTrainingEmployeeModuleStatusDetails;
    end;
end;

procedure TfmTrainingStatus.FormShow(Sender: TObject);
var
  qry: TErpQuery;
begin
  inherited;
  if EmployeeId = 0 then employeeId := appenv.Employee.employeeid;
  if TrainingId = 0 then begin
    qry := TErpQuery.Create(nil);
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('select Min(TrainingId) as TrainingID from tblTraining');
      qry.Open;
      TrainingId := qry.FieldByName('TrainingID').AsInteger;
    finally
      qry.Free;
    end;
  end;
  OpenDb(qryTrainingLookup);
  if qryTrainingLookup.Locate('TrainingID',TrainingID,[]) then
    cboTraining.Text := qryTrainingLookup.FieldByName('Description').AsString;
  TEMS.LoadSelect('TrainingID = ' + IntToStr(TrainingID) + ' and EmployeeId = ' +IntToStr(employeeId));
  TEMS.Connection.BeginTransaction;
  Self.Caption := 'Training Status of ' +tcDataUtils.getemployeeName(EmployeeID);
  TitleLabel.Caption := 'Training Status of ' +tcDataUtils.getemployeeName(EmployeeID);
  Setcontrolfocus(grdDetails);
  ShowERPHint(7);
  (*PlayERPVideo(exedir+'videos\Step 10 Status.avi' );*)
end;

procedure TfmTrainingStatus.TrainingStatusForModule(Sender: TObject);
begin
  if not (Sender is TfmTrainingStatusDetails) then exit;
  TfmTrainingStatusDetails(Sender).TEMSID :=TEMS.id;
  TfmTrainingStatusDetails(Sender).ModuleHelpcontextID :=TEMS.Module.ModuleHelpcontextID;
  TfmTrainingStatusDetails(Sender).TEMSD := TEMS.Details;
  TfmTrainingStatusDetails(Sender).dsTrainingEmployeeModuleStatusDetails.dataset := qryTrainingEmployeeModuleStatusDetails;
  TfmTrainingStatusDetails(Sender).Showvideo := Self.showVideo;
end;

procedure TfmTrainingStatus.btnCompletedClick(Sender: TObject);
begin
  inherited;
  TEMS.PostDB;
  if not TEMS.Save then exit;
  TEMS.connection.CommitTransaction;
  TEMS.Dirty := False;
  Self.close;
end;

procedure TfmTrainingStatus.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmTrainingStatus.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := false;
  if TEMS.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          TEMS.PostDB;
          if TEMS.Save then begin
            TEMS.Dirty := True;
            TEMS.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          TEMS.CancelDb;
          TEMS.Connection.RollbackTransaction;
          TEMS.dirty:= False;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmTrainingStatus.Showvideo;
var
  s:String;
  aDownloadResult: TFileDownloadResult;
  URL,Filename:String;
begin
  if TEMS.Module.Videofilename <> '' then begin
      URL:=VIDEO_FTP_URL +TEMS.Module.Videofilename;
      filename := VideoDirectory + TEMS.Module.Videofilename;
    TFileDownloader.DownloadFile(URL, FileName, aDownloadResult,
                               frReplaceIfSizeDifferent);

      s:= '';
      if aDownloadResult= drConnectFailed then s:= 'Connection Failed'
      else if aDownloadResult=drDownloadFailed then s:= 'Download Failed';
      if s<> '' then
        MessageDlgXP_Vista(s+chr(13) +'File:'+ URL, mtInformation , [mbok], 0);
      try
        ShellExecute(Handle, 'open',PChar(filename),nil, nil, SW_SHOW);
        if not TEMS.VideoWatched then TEMS.VideoWatched := true;
        if TEMS.VideoWatchedon = 0 then TEMS.VideoWatchedon := Date;
        TEMS.PostDB;
        grdDetails.refresh;
      Except
        on E:Exception do begin
          MessageDlgXP_Vista(s+chr(13) +'Failed to open File:'+ filename +chr(13) + E.Message, mtWarning , [mbok], 0);
        end;
      end;
  end;
end;

procedure TfmTrainingStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  (*CloseERPVideo;*)
  Action := caFree;
  
end;

procedure TfmTrainingStatus.grdDetailsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if (Sysutils.SameText(Afieldname , 'idetails')) or
    (Sysutils.SameText(Afieldname , 'iVideo')) then begin
      ATitleAlignment := taCenter;
      ABrush.Color := clBtnFace;
    end else ATitleAlignment := taLeftJustify	;
end;

procedure TfmTrainingStatus.grdDetailsEnter(Sender: TObject);
begin
  inherited;
  grdDetails.SetActiveField('Modulename');
end;

procedure TfmTrainingStatus.QrytrainingemployeemoduleStatuslkCalcFields(
  DataSet: TDataSet);
var
  S:String;
begin
  inherited;
  s:=IntToStr(QrytrainingemployeemoduleStatuslkDone.asInteger);
  if char_length(s) = 1 then s:= ' ' + s;
  s := s +' / ' +
            IntToStr(QrytrainingemployeemoduleStatuslkAllEntries.asInteger);
  QrytrainingemployeemoduleStatuslkDoneStatus.asString :=s;
  (*QrytrainingemployeemoduleStatuslkDoneStatus.asString :=
            IntToStr(QrytrainingemployeemoduleStatuslkDone.asInteger)+'/' +
            IntToStr(QrytrainingemployeemoduleStatuslkAllEntries.asInteger);*)
end;

procedure TfmTrainingStatus.FormDestroy(Sender: TObject);
begin
  Freeandnil(TEMS);
  inherited;
end;

procedure TfmTrainingStatus.Loadform;
var
  QueriesNotToOpen: array of string;
  bm:TBookmark;
begin
  bm := QrytrainingemployeemoduleStatus.getbookmark;
  try
    closequeries;
    Setlength(QueriesNotToOpen, 2);
    QueriesNotToOpen[0] := 'QrytrainingemployeemoduleStatus';
    QueriesNotToOpen[1] := 'qryTrainingEmployeeModuleStatusDetails';
    Openqueries(QueriesNotToOpen);
    TEMS.LoadSelect('TrainingID = ' + IntToStr(TrainingID) + ' and EmployeeId = ' +IntToStr(employeeId));
  finally
      QrytrainingemployeemoduleStatus.gotobookmark(bm);
      QrytrainingemployeemoduleStatus.Freebookmark(bm);
      ShowERPHint(7);
  end;
end;

procedure TfmTrainingStatus.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ssCtrl in Shift then begin
      if Key = ord('D') then grdDetails.SetactiveField('iDetails')
      else if Key = ord('V') then grdDetails.SetactiveField('iVideo')
      else exit;
      grdDetailsDblClick(grdDetails);
  end;
end;

procedure TfmTrainingStatus.onShowERPHint(const Value: Integer);
begin
  inherited;
  if Value =7 then begin
    HighlightControl(grdDetails);
    HighlightextraControl1(btnCompleted);
  end;
end;

procedure TfmTrainingStatus.DNMSpeedButton1Click(Sender: TObject);
var
  Form : TComponent;
  MsgHandler: TMsgHandler;
  MsgObj: TMsgObj;
begin
  inherited;
  Form := GetComponentByClassName('TListChartView', False);

  if Assigned(Form) then begin
    MsgHandler := TMsgHandler.Create(Self);
    try
      MsgObj := TMsgObj.Create;
      MsgObj.ObjPtr := grdDetails;
      MsgObj.SetAddress('TListChartView', 'ShowChartView', Form.Name);
      MsgHandler.Send(MsgObj);
    finally
      FreeandNil(MsgHandler);
    end;
  end;
end;


procedure TfmTrainingStatus.QrytrainingemployeemoduleStatusAfterClose(
  DataSet: TDataSet);
begin
  inherited;
closeDB(QryTESGraph);
end;

procedure TfmTrainingStatus.QrytrainingemployeemoduleStatusAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  closeDB(QryTESGraph);
  QryTESGraph.SQl.clear;
  QryTESGraph.SQL.add('SELECT * FROM tbltrainingemployeemodulestatus WHERE TrainingID = ' + IntToStr(TrainingID) +' and EmployeeId = '+IntToStr(employeeId)+' Order by ModuleSeqNo  desc ');
  opendb(QryTESGraph);
end;

procedure TfmTrainingStatus.grdDetailsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin

  if (Sysutils.SameText(Afieldname , 'idetails')) or
    (Sysutils.SameText(Afieldname , 'iVideo')) then begin
     grdDetails.SetactiveField(Afieldname);
     grdDetailsDblClick(grdDetails);
  end else inherited;
end;

procedure TfmTrainingStatus.btnVideoClick(Sender: TObject);
begin
  inherited;
  grdDetails.SetactiveField('iVideo');
  grdDetailsDblClick(grdDetails);
end;

procedure TfmTrainingStatus.cboTrainingCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
  doChange: boolean;
begin
  inherited;
  doChange := true;
  if TEMS.Dirty then begin
    if qryTrainingLookup.FieldByName('TrainingID').AsInteger <> self.TrainingID then begin
      case CommonLib.MessageDlgXP_Vista('Do you wish to save your changes?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes:
          begin
            if TEMS.Save then begin
              self.CommitTransaction;
              TEMS.Dirty := false;
              self.BeginTransaction;
            end
            else begin
              doChange := false;
            end;
          end;
        mrNo:
          begin
            TEMS.Cancel;
            self.RollbackTransaction;
            TEMS.Dirty := false;
            self.BeginTransaction;
          end;
        mrCancel:
          begin
            doChange := false;
          end;
      end;

    end;
  end
  else begin


  end;
  if doChange then begin
    TrainingID := qryTrainingLookup.FieldByName('TrainingID').AsInteger;
    FormShow(nil);
  end
  else begin
    if qryTrainingLookup.Locate('TrainingID',TrainingID,[]) then
      cboTraining.Text := qryTrainingLookup.FieldByName('Description').AsString;
  end;
end;

procedure TfmTrainingStatus.btnDetailsClick(Sender: TObject);
begin
  inherited;
  grdDetails.SetactiveField('idetails');
     grdDetailsDblClick(grdDetails);
end;

procedure TfmTrainingStatus.btnHelpClick(Sender: TObject);
begin
  inherited;
  if ISInteger(TEMS.Module.ModuleHelpcontextID) then
    AppHelpProcessor.ShowHelp(strToint(TEMS.Module.ModuleHelpcontextID));
end;

initialization
  RegisterClassOnce(TfmTrainingStatus);

end.
