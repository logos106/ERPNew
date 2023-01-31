unit AssessmentGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  kbmMemTable, wwdblook, DBAccess, MyAccess,ERPdbComponents, DataState, wwcheckbox, Menus, AdvMenus, MemDS,
  wwdbdatetimepicker, Grids, Wwdbigrd, Wwdbgrid, wwclearbuttongroup,
  wwradiogroup, wwdbedit, Wwdotdot, Wwdbcomb, ComCtrls,AdvOfficeStatusBar, Shader,
  ImgList;

const
  SX_CalcsMsg = WM_USER + 100;

type
  TAssessmentGUI = class(TBaseInputGUI)
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblDetails: TERPQuery;
    DSDetails: TDataSource;
    tblMasterAssessmentID: TIntegerField;
    tblMasterDriverID: TIntegerField;
    tblMasterTimeOn: TTimeField;
    tblMasterTimeOff: TTimeField;
    tblMasterJourneyFrom: TWideStringField;
    tblMasterJourneyTo: TWideStringField;
    tblMasterBusDestination: TWideStringField;
    tblMasterWeatherType: TWideStringField;
    tblMasterVehicleType: TWideStringField;
    tblMasterFleetNumber: TWideStringField;
    tblMasterRunningNumber: TWideStringField;
    tblMasterRegNumber: TWideStringField;
    tblMasterGarage: TWideStringField;
    tblMasterRoute: TWideStringField;
    tblMasterCovert: TWideStringField;
    tblMasterUniformWorn: TWideStringField;
    tblMasterAssessmentToday: TIntegerField;
    tblMasterDate: TDateField;
    tblDetailsAssessmentDetailsID: TIntegerField;
    tblDetailsAssessmentID: TIntegerField;
    tblDetailsLabelID: TIntegerField;
    tblDetailsLabel: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblActive: TLabel;
    chkActive: TwwCheckBox;
    Bevel1: TBevel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label1: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label2: TLabel;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    Label3: TLabel;
    edtDesc: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    Label8: TLabel;
    DBEdit4: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit5: TDBEdit;
    cboGarage: TwwDBLookupCombo;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit6: TDBEdit;
    wwCheckBox1: TwwCheckBox;
    Label13: TLabel;
    wwCheckBox2: TwwCheckBox;
    Label14: TLabel;
    wwRadioGroup1: TwwRadioGroup;
    tblMasterActive: TWideStringField;
    tblDetailsResult: TIntegerField;
    wwDBLookupCombo3: TwwDBLookupCombo;
    Label15: TLabel;
    tblMasterTypeID: TIntegerField;
    qryAssessmentType: TERPQuery;
    qryWeather: TERPQuery;
    qryCust: TERPQuery;
    DBEdit7: TDBEdit;
    Label16: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label48: TLabel;
    cboEmployeeLookup: TERPQuery;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    btnPrint: TDNMSpeedButton;
    tblMasterConverted: TWideStringField;
    tblMasterScore: TIntegerField;
    tblMasterRating: TWideStringField;
    Bevel2: TBevel;
    Score: TwwDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    tblMasterOverrideRating: TWideStringField;
    OverrideRating: TwwCheckBox;
    Label19: TLabel;
    Rating: TwwDBComboBox;
    cboDrivers: TwwDBLookupCombo;
    qryDrivers: TERPQuery;
    Label20: TLabel;
    tblMasterAssessorID: TIntegerField;
    qryDriversDriverName: TWideStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    wwRadioGroup2: TwwRadioGroup;
    grdData: TwwDBGrid;
    grdData2: TwwDBGrid;
    tblDetails2: TERPQuery;
    DSDetails2: TDataSource;
    tblDetails2AssessmentotherDetailsID: TLargeintField;
    tblDetails2AssessmentID: TIntegerField;
    tblDetails2LabelID: TIntegerField;
    tblDetails2Label: TWideStringField;
    tblDetails2Result: TWideStringField;
    chkyesno: TwwCheckBox;
    qryDriversDriverID: TIntegerField;
    TabSheet3: TTabSheet;
    DBMemo1: TDBMemo;
    tblMasterNotes: TMemoField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    Label21: TLabel;
    DBEdit8: TDBEdit;
    Label22: TLabel;
    DBEdit9: TDBEdit;
    tblMasterRequestedBy: TWideStringField;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure wwDBLookupCombo3CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure wwDBLookupCombo1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboGarageNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure DoCalcs(var Message: TMessage); message SX_CalcsMsg;
    procedure tblDetailsResultChange(Sender: TField);
    procedure grdDataExit(Sender: TObject);
    procedure OverrideRatingClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboDriversCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure tblDetails2BeforePost(DataSet: TDataSet);
    procedure cboGarageChange(Sender: TObject);
    procedure qryDriversBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    function SaveData: Boolean;
    procedure AddAssessmentLabels;
    procedure PrintAssessment(Const AssessmentID: Integer);
    procedure CalcScoreAndRating;
    function GetPointsFromLabelResult(Const LabelResult:Integer): Integer;
    function GetAssessmentTypeDefaultReport(const TypeID: integer): string;    
  protected
    function GetReportTypeID: integer; override;
  public
    { Public declarations }
  end;


implementation

uses
  FormFactory, DNMExceptions, CommonDBLib,  tcDataUtils,
  AppEnvironment, CommonLib, FastFuncs;

{$R *.dfm}

procedure TAssessmentGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAssessmentGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TAssessmentGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;

      if tblDetails.Active then begin
        if not (tblDetails.State in [dsBrowse]) then tblDetails.Post;
      end;

      if tblMaster.Active then begin
        if not (tblMaster.State in [dsBrowse]) then begin
          tblMaster.Post;
          Notify;
        end;
        CloseQueries;
      end;

      tblMaster.Params.ParamByName('xID').AsInteger  := KeyID;
      tblDetails.Params.ParamByName('xID').AsInteger := KeyID;
      tblDetails2.Params.ParamByName('xID').AsInteger := KeyID;

      SetLength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'qryAssessmentType';
      OpenQueries(QueryNamesNotToOpen);

      qryAssessmentType.Params.ParamByName('xID').AsInteger :=
        tblMasterTypeID.AsInteger;
      qryAssessmentType.Open;

      BeginTransaction;

      if KeyID = 0 then begin
        tblMaster.Insert;
        AddAssessmentLabels;
      end else begin
        EditNoAbort(tblMaster);
        PostMessage(self.Handle, SX_CalcsMsg, 0, 0);
      end;

      qryDrivers.Close;
      qryDrivers.Open;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;  


procedure TAssessmentGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  Close;
end;

function TAssessmentGUI.SaveData: Boolean;
begin
  Result := true;
  try
    if tblDetails2.Active then begin
      if not (tblDetails2.State in [dsBrowse]) then begin
        tblDetails2.Post;
      end;
    end;
    if tblDetails.Active then begin
      if not (tblDetails.State in [dsBrowse]) then begin
        tblDetails.Post;
      end;
    end;
    if tblMaster.Active then begin
      if not (tblMaster.State in [dsBrowse]) then begin
        tblMaster.Post;
        Notify;
      end;
    end;

    if (tblMasterAssessorID.AsInteger = 0) then begin
      Commonlib.MessageDlgXP_Vista('No Assessor', mtWarning, [mbOK], 0);
      Result := false;
      exit;
    end;

    if (tblMasterTypeID.AsInteger = 0) then begin
      commonlib.MessageDlgXP_Vista('No Assessment Type', mtWarning, [mbOK], 0);
      Result := false;
      exit;
    end;

    CommitTransaction;
  except
    Result := false;
  end;
end;

procedure TAssessmentGUI.btnNewClick(Sender: TObject);
begin
  try
    inherited;
    if not SaveData then Exit;
    KeyID := 0;
    FormShow(nil);
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TAssessmentGUI.AddAssessmentLabels;
var
  qryTemp: TERPQuery;
begin
  if not tblMaster.Active then Exit;
  if not tblDetails.Active then Exit;
  if not tblDetails2.Active then Exit;
  qryTemp := TERPQuery.Create(nil);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDBLib.GetSharedMyDacConnection;
    {Labels}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM tblassessmenttypesdetails WHERE TypeID = ' +
      FastFuncs.IntToStr(tblMasterTypeID.AsInteger) + ';');
    qryTemp.Open;
    if (qryTemp.RecordCount > 0) then begin
      grdData.Keyoptions := grdData.Keyoptions + [dgAllowInsert];
      qryTemp.First;
      while not qryTemp.Eof do begin
        tblDetails.Append;
        tblDetailsLabel.AsString := qryTemp.FieldByName('Label').AsString;
        tblDetailsLabelID.AsInteger := qryTemp.FieldByName('LabelID').AsInteger;
        tblDetails.Post;
        qryTemp.Next;
      end;
      grdData.Keyoptions := grdData.Keyoptions - [dgAllowInsert];
    end;
    {Other Option}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM tblassessmenttypesotherdetails WHERE TypeID = ' +
      FastFuncs.IntToStr(tblMasterTypeID.AsInteger) + ';');
    qryTemp.Open;
    if (qryTemp.RecordCount > 0) then begin
      grdData2.Keyoptions := grdData.Keyoptions + [dgAllowInsert];
      qryTemp.First;
      while not qryTemp.Eof do begin
        tblDetails2.Append;
        tblDetails2Label.AsString := qryTemp.FieldByName('Label').AsString;
        tblDetails2LabelID.AsInteger := qryTemp.FieldByName('LabelID').AsInteger;
        tblDetails2.Post;
        qryTemp.Next;
      end;
      grdData2.Keyoptions := grdData.Keyoptions - [dgAllowInsert];
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TAssessmentGUI.wwDBLookupCombo3CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin
  If not modified then Exit;
  inherited;
  if not tblMaster.Active then Exit;
  if (KeyID <> 0) then Exit;

  EditNoAbort(tblMaster);
  if not (tblMaster.State in [dsBrowse]) then
    tblMaster.Post;
  EditNoAbort(tblMaster);

  AddAssessmentLabels;
end;

procedure TAssessmentGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if tblMasterAssessmentID.AsInteger = 0 then begin
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
    end;
    EditNoAbort(tblMaster);
  end;
  tblDetailsAssessmentID.AsInteger := tblMasterAssessmentID.AsInteger;
end;

procedure TAssessmentGUI.wwDBLookupCombo1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: Boolean);
begin
  //  inherited;
  Accept := false;
end;

procedure TAssessmentGUI.cboGarageNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: Boolean);
begin
  //  inherited;
  Accept := false;
end;

procedure TAssessmentGUI.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if SaveData then begin
      PrintAssessment(tblMasterAssessmentID.AsInteger);
    end;
    Close;
  finally
    EnableForm;
  end;
end;


function TAssessmentGUI.GetAssessmentTypeDefaultReport(const TypeID: integer): string;
var
  qryTemp: TERPQuery;
  TemplID: Integer;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT TypeID,DefaultTemplateID FROM `tblassessmenttypes`  WHERE `TypeID` = ' +
      FastFuncs.IntToStr(TypeID) + ';');
    qryTemp.Active := true;

    if not qryTemp.IsEmpty then begin
      TemplID := qryTemp.FieldByName('DefaultTemplateID').AsInteger;
    end else begin
      TemplID := 0;
    end;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TemplID` = ' + Fastfuncs.IntToStr(TemplID) + ';');
    qryTemp.Active := true;

    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('TemplName').AsString;
    end else begin
      Result := '';
    end;
  finally
    if Assigned(qryTemp) then qryTemp.Free;
  end;
end;


procedure TAssessmentGUI.PrintAssessment(Const AssessmentID: Integer);
var
  sReportName, sSQL: string;
begin
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      sReportName := dlgReportSelect.SelectedItems.Text;
    end;
  end else begin
    sReportName := GetAssessmentTypeDefaultReport(tblMasterTypeID.AsInteger);
    If Empty(sReportName) then
      sReportName := GetDefaultReport(GetReportTypeID);
  end;

  If Empty(sReportName) then sReportName := 'Assessment';


  sSql := '~|||~WHERE tblassessments.AssessmentID = '+FastFuncs.IntToStr(AssessmentID)+
          '~|||~WHERE tblassessmentsdetails.AssessmentID = '+FastFuncs.IntToStr(AssessmentID)+
          '~|||~WHERE tblassessmentsdetails.AssessmentID = '+FastFuncs.IntToStr(AssessmentID)+
          '~|||~WHERE tblassessmentsotherdetails.AssessmentID = '+FastFuncs.IntToStr(AssessmentID);
  PrintTemplateReport(sReportName, sSQL, not Appenv.Employee.ShowPreview, 1);
end;

procedure TAssessmentGUI.DoCalcs(var Message: TMessage);
begin
  CalcScoreAndRating;
end;

function TAssessmentGUI.GetPointsFromLabelResult(const LabelResult: Integer): Integer;
begin
  Result := 0;
  If LabelResult=1 then
    Result := 0
  else If LabelResult=2 then
    Result := 2
  else If LabelResult=3 then
    Result := 20
  else If LabelResult=4 then
    Result := 50;
end;

procedure TAssessmentGUI.CalcScoreAndRating;
Var
  bm: TBookmark;
  Score: Integer;
  Rating: Integer;
  RatingStr:String;
begin
  RatingStr:='1';
  Rating := 1;
  Score := 0;
  If Not tblDetails.Active then Exit;
  with tblDetails do begin
    bm := GetBookmark;
    Try
      DisableControls;
      First;
      while not Eof do begin
        Score := Score + GetPointsFromLabelResult(FieldByName('Result').AsInteger);
        If (Rating<1) and (FieldByName('Result').AsInteger=1) Then Begin
          Rating := 1;
        end else If (Rating<2) and (FieldByName('Result').AsInteger=2) Then Begin
          Rating := 2;
        end else If (Rating<3) and (FieldByName('Result').AsInteger=3) Then Begin
          Rating := 3;
        end else If (Rating=3) and (FieldByName('Result').AsInteger=3) Then Begin
          Rating := 4;
        end else If (Rating<5) and (FieldByName('Result').AsInteger=4) Then Begin
          Rating := 5;
        end;
        If (Rating=5) Then Break;
        Next;
      end;

      If (Rating=1) then
        RatingStr := '1'
      else If (Rating=2) then
        RatingStr := '2'
      else If (Rating=3) then
        RatingStr := '3A'
      else If (Rating=4) then
        RatingStr := '3B'
      else If (Rating=5) then
        RatingStr := '4';

      If EditNoAbort(tblMaster) then Begin
        tblMasterScore.AsInteger := Score;
        If not OverrideRating.Checked then
          tblMasterRating.asString := RatingStr;
      end;
    finally
      GotoBookmark(bm);
      FreeBookmark(bm);
      EnableControls;
    end;
    tblDetails.Edit;
  end;
end;

procedure TAssessmentGUI.tblDetailsResultChange(Sender: TField);
begin
  inherited;
  PostMessage(self.Handle, SX_CalcsMsg, 0, 0);
end;

procedure TAssessmentGUI.grdDataExit(Sender: TObject);
begin
  inherited;
  PostMessage(self.Handle, SX_CalcsMsg, 0, 0);
end;

procedure TAssessmentGUI.OverrideRatingClick(Sender: TObject);
begin
  inherited;
  PostMessage(self.Handle, SX_CalcsMsg, 0, 0);
end;

procedure TAssessmentGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  If not modified then Exit;
  inherited;
  if not tblMaster.Active then Exit;

  EditNoAbort(tblMaster);
  if not (tblMaster.State in [dsBrowse]) then
    tblMaster.Post;
  EditNoAbort(tblMaster);


end;

procedure TAssessmentGUI.cboDriversCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  If not modified then Exit;
  inherited;
  if not tblMaster.Active then Exit;

  EditNoAbort(tblMaster);
  if not (tblMaster.State in [dsBrowse]) then
    tblMaster.Post;
  EditNoAbort(tblMaster);
end;

procedure TAssessmentGUI.tblDetails2BeforePost(DataSet: TDataSet);
begin
  inherited;
  if tblMasterAssessmentID.AsInteger = 0 then begin
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
    end;
    EditNoAbort(tblMaster);
  end;
  tblDetails2AssessmentID.AsInteger := tblMasterAssessmentID.AsInteger;
end;

procedure TAssessmentGUI.cboGarageChange(Sender: TObject);
begin
  inherited;
  qryDrivers.Close;
  qryDrivers.Open;
end;

procedure TAssessmentGUI.qryDriversBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryDrivers.Params.ParamByName('CusID').AsInteger :=  tcDataUtils.getclientID(cboGarage.Text);
end;

function TAssessmentGUI.GetReportTypeID: integer;
begin
  Result := 84;
end;

initialization
  RegisterClassOnce(TAssessmentGUI);
  with FormFact do begin
    RegisterMe(TAssessmentGUI, 'TAssessmentListGUI_*=AssessmentID');
  end;
end.
