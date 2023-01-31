unit frmTrainingStatusDetails;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  StdCtrls, Shader, ExtCtrls, DNMPanel, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts,  BusobjTraining, BusObjBase, frmBaseTraining, ComCtrls,
  ProgressDialog;

type
  TfmTrainingStatusDetails = class(TfmBaseTraining)
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
    dsTrainingEmployeeModuleStatusDetails: TDataSource;
    qrytrainingmoduletask: TERPQuery;
    qrytrainingmoduletaskTrainingModuleTaskID: TIntegerField;
    qrytrainingmoduletaskSeqno: TIntegerField;
    qrytrainingmoduletaskTrainingModuleTaskTitle: TWideStringField;
    qrytrainingmoduletaskTrainingModuleTaskDescription: TWideMemoField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnvideo: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    grdMain: TwwDBGrid;
    Label1: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    btnHelp: TDNMSpeedButton;
    hcGrid: THeaderControl;
    sbGrid: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnvideoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure hcGridSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
  private
    fiTEMSID: integer;
    fShowvideo: TGeneralProc;
    fsModuleHelpcontextID: String;
    procedure setModuleHelpcontextID(const Value: String);
    procedure LoadGrid;
    procedure AdjustColumns;
    procedure DoDoneClick(Sender: TObject);
    procedure ScrollToZero;
  Protected
    Procedure onShowERPHint(Const Value:Integer); override;
    Procedure AfterFormShow; override;
  public
    TEMSD: TTrainingEmployeeModuleStatusDetails;
    Property TEMSID:integer read fiTEMSID write fiTEMSID;
    Property ModuleHelpcontextID:String read fsModuleHelpcontextID write setModuleHelpcontextID;
    Property Showvideo:TGeneralProc read fShowvideo write fShowvideo;
  end;

  TTrainingStatusItem = class(TPanel)
  private
    BottomLine: TBevel;
    fOnDoneClick: TNotifyEvent;
    procedure DoOnDoneClick(Sender: TObject);
  public
    TaskId: integer;
    TitleLabel: TLabel;
    DetailLabel: TLabel;
    CheckBox: TCheckBox;
    VertLine1, VertLine2, VertLine3: TBevel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnDoneClick: TNotifyEvent read fOnDoneClick write fOnDoneClick;
  end;

implementation

uses FastFuncs, frmTrainingStatus, CommonLib, AppEnvironment,
  AppHelpProcessorObj, CommonDbLib, LanguageTranslationObj;



{$R *.dfm}

procedure TfmTrainingStatusDetails.FormCreate(Sender: TObject);
begin
  TranslateFormLanguage := false;  { wait till we have loaded grid panels ... }
  inherited;
  fiTEMSID:= 0;
  fShowvideo:= nil;
end;

procedure TfmTrainingStatusDetails.FormShow(Sender: TObject);
begin
  inherited;
(*  TEMSD.LoadSelect('trainingemployeemoduleStatusID = ' +IntToStr( TEMSID));*)
  TEMSD.Connection.BeginTransaction; // just incase if not in transaction - but it should always be
  TEMSD.Connection.BeginNestedTransaction;
//  grdMain.SetActiveField('done');
  ShowERPHint(8);
  LoadGrid;
  AdjustColumns;
  self.TranslateFormLanguage := true;
  self.DoTranslateFormLanguage;
  TEMSD.DoDelayObjectProcedure(ScrollToZero,50, Self.classname +'.ScrollToZero');
end;

procedure TfmTrainingStatusDetails.hcGridSectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
  inherited;
  AdjustColumns;
end;

procedure TfmTrainingStatusDetails.LoadGrid;
var
  ds: TDataset;
  item: TTRainingStatusItem;
begin
  ds := dsTrainingEmployeeModuleStatusDetails.DataSet;
  ds.Last;
  while not ds.BOF do begin
    item := TTRainingStatusItem.Create(self);
    item.TaskId := ds.FieldByName('TaskId').AsInteger;
    item.Parent := sbGrid;
    item.TitleLabel.Caption := ds.FieldByName('TaskTitle').AsString;
    item.DetailLabel.Caption := ds.FieldByName('TaskDescription').AsString;
    item.CheckBox.Checked := ds.FieldByName('Done').AsBoolean;
    item.OnDoneClick := DoDoneClick;
    ds.Prior;
  end;
end;

procedure TfmTrainingStatusDetails.AdjustColumns;
var
  x: integer;
  item: TTRainingStatusItem;
begin
  for x := 0 to sbGrid.ControlCount -1 do begin
    if sbGrid.Controls[x] is TTRainingStatusItem then begin
//      item.Width := hcGrid.Width;
      item := TTRainingStatusItem(sbGrid.Controls[x]);
      item.TitleLabel.Font.Style := [];
      item.TitleLabel.Left := hcGrid.Sections[0].Left + 5;
      item.TitleLabel.Width := hcGrid.Sections[0].Width - 12;
      item.DetailLabel.Left := hcGrid.Sections[1].Left + 5;
      item.DetailLabel.Width := hcGrid.Sections[1].Width - 12;
      item.DetailLabel.Font.Style := [];
//      item.CheckBox.Width := item.CheckBox.Height;
      if hcGrid.Sections[2].Width > 18 then
        item.CheckBox.Left := hcGrid.Sections[2].Left + Trunc(hcGrid.Sections[2].Width/2) - 8
      else
        item.CheckBox.Left := hcGrid.Sections[2].Left + 5;
      item.VertLine1.Left := hcGrid.Sections[1].Left -4;
      item.VertLine2.Left := hcGrid.Sections[2].Left -4;
      item.VertLine3.Left := (hcGrid.Sections[2].Left -4) + hcGrid.Sections[2].Width;
    end;
  end;
end;

procedure TfmTrainingStatusDetails.AfterformShow;
begin
  inherited;
  Application.ProcessMessages;
  sbGrid.VertScrollBar.Position := 0;
end;

procedure TfmTrainingStatusDetails.btnCloseClick(Sender: TObject);
begin
  inherited;
  TEMSD.cancelDB;
  modalresult := mrCancel;
  //TEMSD.Connection.RollbackNestedTransaction;
end;

procedure TfmTrainingStatusDetails.btnCompletedClick(Sender: TObject);
begin
  inherited;
  TEMSD.PostDB;
  modalresult := mrOk;
end;

procedure TfmTrainingStatusDetails.btnvideoClick(Sender: TObject);
begin
  inherited;
    if assigned(fShowvideo) then
      fShowvideo;
end;
procedure TfmTrainingStatusDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  if modalresult = mrok then TEMSD.Connection.CommitNestedTransaction
  else TEMSD.Connection.RollbackNestedTransaction;
end;

procedure TfmTrainingStatusDetails.onShowERPHint(
  const Value: Integer);
begin
  inherited;
  if Value =8 then begin
    HighlightControl(btnCompleted);
    HighlightextraControl1(btnvideo);
  end;
end;

procedure TfmTrainingStatusDetails.ScrollToZero;
begin
  sbGrid.VertScrollBar.Position := 0;
end;

procedure TfmTrainingStatusDetails.DNMSpeedButton1Click(Sender: TObject);
var
  tablename :String;
  st:TStringlist;
  function employeeID:Integer ;
  begin
    result :=0;
    if assigned(TEMSD.owner) then
      if TEMSD.owner is TTrainingEmployeeModuleStatus then
        REsult := TTrainingEmployeeModuleStatus(TEMSD.owner).EmployeeId;
  end;

  function ModuleId:Integer ;
  begin
    result :=0;
    if assigned(TEMSD.owner) then
      if TEMSD.owner is TTrainingEmployeeModuleStatus then
        REsult := TTrainingEmployeeModuleStatus(TEMSD.owner).ModuleId;
  end;

  function TrainingId:Integer ;
  begin
    result :=0;
    if assigned(TEMSD.owner) then
      if TEMSD.owner is TTrainingEmployeeModuleStatus then
        result := TTrainingEmployeeModuleStatus(TEMSD.owner).TrainingID;
  end;

begin
  inherited;
  tablename := commondblib.GetUserTemporaryTableName('Language');
  try
    st:= TStringlist.Create;
    try
      st.Add('Drop table if exists ' +TableName +';');
      st.Add('create table ' +TableName +'');
      st.Add('Select   TEMS.EmployeeName ,  TMT.TrainingModuleTaskTitle , TMT.TrainingModuleTaskDescription , TMT.TrainingModuleName ,   TEMSD.done , TEMSD.SeqNo , TEMSD.doneon');
      st.Add('from   tblTrainingEmployeeModuleStatus TEMS');
      st.Add('inner join tblTrainingEmployeeModuleStatusDetails TEMSD on TEMSD.TRainingEmployeeModuleStatusId = TEMS.TRainingEmployeeModuleStatusId');
      st.Add('inner join tbltrainingmoduletask TMT on  TMT.TrainingModuleTaskID = TEMSD.TaskId');
      st.Add('Where TEMS.EmployeeId = ' +IntToStr(employeeID)+
                  ' and TEMS.TrainingID = ' + IntToStr(TrainingID) +
                  ' and TEMS.ModuleId = ' +IntToStr(ModuleID) +
                  ' order by SeqNo;');
      st.Add('update ' +TableName +' T inner join');
      st.Add('erplanguages.inenglish InE  on InE.InEnglish = T.TrainingModuleTaskDescription');
      st.Add('inner join erplanguages.languagetranslation LT on LT.EnglishID = InE.ID and LT.LanguageID =' +inttostr(TLanguageTranslationObj.Inst.UserLanguageId) +'');
      st.Add('Set T.TrainingModuleTaskDescription = LT.Translation');
      st.Add('where ifnull(LT.Translation,"")<> "";');
      st.Add('update ' +TableName +' T inner join');
      st.Add('erplanguages.inenglish InE  on InE.InEnglish = T.TrainingModuleTaskTitle');
      st.Add('inner join erplanguages.languagetranslation LT on LT.EnglishID = InE.ID and LT.LanguageID =' +inttostr(TLanguageTranslationObj.Inst.UserLanguageId) +'');
      st.Add('Set T.TrainingModuleTaskTitle = LT.Translation');
      st.Add('where ifnull(LT.Translation,"")<> "";');
      ExecuteSQL(st.Text);
    finally
      Freeandnil(st);
    end;
    fbReportSQLSupplied := True;
    PrintTemplateReport('TrainingQuestions' ,
                        '{companyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
                        'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
                        'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO  '+
                    '~|||~{Details}Select * from ' + tablename +' order by SeqNo' , not(Appenv.Employee.ShowPreview) ,0 );
  finally
    commondblib.DestroyUserTemporaryTable(tablename);
  end;
end;

procedure TfmTrainingStatusDetails.DoDoneClick(Sender: TObject);
var
  ds: TDataset;
  item: TTRainingStatusItem;
begin
  ds := dsTrainingEmployeeModuleStatusDetails.DataSet;
  item := TTRainingStatusItem(Sender);
  if ds.Locate('TaskId',item.TaskId,[]) then begin
    EditDb(ds);
    ds.FieldByName('Done').AsBoolean := item.CheckBox.Checked;
    PostDb(ds);
  end;
end;

procedure TfmTrainingStatusDetails.btnHelpClick(Sender: TObject);
begin
  inherited;
  AppHelpProcessor.ShowHelp(btnHelp.HelpContext);
end;

procedure TfmTrainingStatusDetails.setModuleHelpcontextID(
  const Value: String);
begin
  fsModuleHelpcontextID := Value;
  if (ISInteger(value)) then btnhelp.HelpContext := strtoint(value);
end;

{ TTrainingStatusItem }

constructor TTrainingStatusItem.Create(AOwner: TComponent);
begin
  inherited;
  self.Name := Self.ClassName + IntToStr(self.ComponentIndex);
  Color:= clWhite;
  BevelOuter:= bvNone;
  Caption := '';
  Align := alTop;

  BottomLine := TBevel.Create(self);
  BottomLine.Shape := bsBottomLine;
  BottomLine.Height:= 2;
  BottomLine.Parent := self;
  BottomLine.Align := alBottom;

  VertLine1 := TBevel.Create(self);
  VertLine1.Shape := bsLeftLine;
  VertLine1.Width := 2;
  VertLine1.Parent := self;
  VertLine1.Top := 0;

  VertLine2 := TBevel.Create(self);
  VertLine2.Shape := bsLeftLine;
  VertLine2.Width := 2;
  VertLine2.Parent := self;
  VertLine2.Top := 0;

  VertLine3 := TBevel.Create(self);
  VertLine3.Shape := bsLeftLine;
  VertLine3.Width := 2;
  VertLine3.Parent := self;
  VertLine3.Top := 0;

  TitleLabel := TLabel.Create(AOwner); { owned by form so language translation works }
  Height := TitleLabel.Height + BottomLine.Height;
  TitleLabel.Name := self.Name + '_Title';
  TitleLabel.AutoSize := false;
  TitleLabel.Parent:= self;
  TitleLabel.Top:= 0;
  TitleLabel.Left := 0;
  TitleLabel.Width := 200;
  TitleLabel.Caption := '';

  DetailLabel := TLabel.Create(aOwner); { owned by form so language translation works }
  DetailLabel.Name := self.Name + '_Detail';
  DetailLabel.AutoSize := false;
  DetailLabel.Parent:= self;
  DetailLabel.Top := 0;
  DetailLabel.Left := TitleLabel.Width;
  DetailLabel.Width := 500;
  DetailLabel.Caption := '';

  CheckBox := TCheckBox.Create(self);
  CheckBox.Parent := self;
  CheckBox.Top := 0;
  CheckBox.Left := TitleLabel.Width + DetailLabel.Width;
  CheckBox.Width := 100;
  CheckBox.Height := TitleLabel.Height;
  CheckBox.Caption := '';
  CheckBox.Width := CheckBox.Height;
  CheckBox.OnClick := DoOnDoneClick;

  VertLine1.Height := self.Height - 2;
  VertLine2.Height := self.Height - 2;
  VertLine3.Height := self.Height - 2;
end;

destructor TTrainingStatusItem.Destroy;
begin

  inherited;
end;

procedure TTrainingStatusItem.DoOnDoneClick(Sender: TObject);
begin
  if Assigned(self.fOnDoneClick) then
    fOnDoneClick(self);
end;

initialization
  RegisterClassOnce(TfmTrainingStatusDetails);

end.
