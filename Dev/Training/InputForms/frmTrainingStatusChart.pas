unit frmTrainingStatusChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FeTskLst, FeGant, ExtCtrls, FeTskGrd, StdCtrls, FeAbsGrd, Menus,
  FePrjDlg, FeGntDlg,frmBaseTraining, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMPanel, Shader, DNMSpeedButton, Mask, wwdbedit, ProgressDialog;

type
  pTRainingEmployee = ^TTRainingEmployee;
  TTRainingEmployee = record
    EmployeeId: integer;
    EmployeeName:String;
    RowNo: Integer;
  end;

  TMoveDate = (mmPrevious=1, mmNext=2);
  TfmTrainingStatusChart = class(TfmBaseTraining)
    FETaskList1: TFETaskList;
    FETaskGrid1: TFETaskGrid;
    Splitter1: TSplitter;
    FEGantSetupDialog1: TFEGantSetupDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    QryMain: TERPQuery;
    QryMainEmployeeId: TIntegerField;
    QryMainModuleId: TIntegerField;
    QryMaintrainingemployeemoduleStatusID: TIntegerField;
    QryMainVideofilename: TWideStringField;
    QryMainHours: TFloatField;
    QryMainStartTime: TDateTimeField;
    QryMainEndTime: TDateTimeField;
    QryMainTrainingModuleName: TWideStringField;
    QryMainEmployeeName: TWideStringField;
    QryMainTrainingHrs: TFloatField;
    FEGant1: TFEGant;
    QryStatus: TERPQuery;
    QryStatusEmployeeId: TIntegerField;
    QryStatusModuleId: TIntegerField;
    QryStatustrainingemployeemoduleStatusID: TIntegerField;
    QryStatusnotDone: TLargeintField;
    QryStatusAllEntries: TLargeintField;
    QrytotalHours: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCancel: TDNMSpeedButton;
    btnShow: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    QrytotalHoursEmployeeId: TIntegerField;
    QrytotalHoursModuleID: TLargeintField;
    QrytotalHoursHours: TFloatField;
    QrytotalHoursTrainingHrs: TFloatField;
    btnTrainingstatus: TDNMSpeedButton;
    btnTrainingRoster: TDNMSpeedButton;
    lblFilter: TLabel;
    edtEmployeeSearch: TEdit;
    btnEmployeeSearch: TDNMSpeedButton;
    QryMainDescription: TWideStringField;
    QryMainTrainingID: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure GantSettings1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OpenFromFile1Click(Sender: TObject);
    procedure SaveToFile1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FETaskGrid1DblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure FETaskGrid1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure QryMainAfterOpen(DataSet: TDataSet);
    procedure btnPrintClick(Sender: TObject);
    procedure btnTrainingstatusClick(Sender: TObject);
    procedure btnTrainingRosterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmployeeSearchChange(Sender: TObject);
    procedure btnEmployeeSearchClick(Sender: TObject);
  private
    fiEmployeeId: Integer;
    fbShowingAll:Boolean;
    Rowcount:Integer;
    lstTRainingEmployees:TList;
    SearchedEmployeeID:Integer;
    function HoursforModule(EmployeeId, ModuleId:Integer): Double;
    function Tasksdonebyemployee(EmployeeId, ModuleId:Integer): Integer;
    procedure Refreshform;
    Procedure RefreshOption;
    Procedure BeforeShowTrainingStatus(Sender:TObject);
    Procedure MoveDate(direction:tMoveDate);
    procedure RefreshChart;
  Protected
    Procedure onShowERPHint(Const Value:Integer); override;
  public
    Property EmployeeId :Integer read fiEmployeeId write fiEmployeeId;
  end;


implementation

uses CommonLib, FastFuncs, dateutils,Variants, tcDataUtils,
  AppEnvironment, EmployeeObj, CommonFormLib, frmTrainingStatus, timelib(*,
  frmVideoPlayer, DNMLib*);

{$R *.DFM}
function TfmTrainingStatusChart.Tasksdonebyemployee(EmployeeId, ModuleId:Integer): Integer;
begin
  result := 0;
  if QryStatus.Locate('employeeId;ModuleID' ,varArrayof([EmployeeID, moduleId]) , []) then
    result :=QryStatusAllEntries.asInteger - QryStatusnotDone.asInteger;
end;
function TfmTrainingStatusChart.HoursforModule(EmployeeId, ModuleId:Integer): double;
begin
  result := 0;
  if QrytotalHours.Locate('employeeId;ModuleID' ,varArrayof([EmployeeID, moduleId]) , []) then
           if QrytotalHoursHours.asFloat = 0 then result:= QrytotalHoursTrainingHrs.asFloat else REsult:= QrytotalHoursHours.asFloat;
end;


procedure TfmTrainingStatusChart.FormShow(Sender: TObject);
begin
  inherited;
  if EmployeeID = 0 then EmployeeID := appenv.Employee.EmployeeID;
  fbShowingAll:= False;
  QryMain.Parambyname('employeeID').asInteger       := EmployeeID;
  QryStatus.Parambyname('employeeID').asInteger     := EmployeeID;
  QrytotalHours.Parambyname('employeeID').asInteger := EmployeeID;
  Refreshform;
  btnShow.enabled := not (employeeId = 0);
  Setcontrolfocus(FEGant1);
  ShowERPHint(9);
  (*PlayERPVideo(exedir+'videos\Step 11 Progress.avi' );*)
end;
procedure TfmTrainingStatusChart.Refreshform;
begin
      RefreshOption;
      RefreshChart;
end;

procedure TfmTrainingStatusChart.RefreshChart;
var
  aItem: TFETask;
  aItem2: TFETask;
  employeeId,moduleId:Integer;
  done,AllEntries,totProgress:Integer;
  Progress:Double; 
  ctr:Integer;
  sTime, etime:TDatetime;
  Summaryr,r:Integer;
  EmpName:string;
  Previoustime:TDatetime;

  Procedure AddItem;
    var
      x:Integer;
      EndTime: TDateTime;
  begin
    r:= r+1;
    aItem := FETaskList1.Items.Add;
//    aItem.Tag := QryMainEmployeeId.asInteger;
    aItem.Tag := qryMainTrainingEmployeeModuleStatusID.AsInteger;
    aItem.Name := empName +chr(13) + QryMainTrainingModuleName.asString+ReplicateStr('.' , ctr);
    ctr:= ctr+1;
            //'FETask'+Trim(IntToStr(Qrymain.recno));
    if QryMainStartTime.asDateTime<> 0 then aItem.StartDateTime := QryMainStartTime.asDateTime
    else aItem.StartDateTime :=  Previoustime;

//    if QryMainEndtime.asDateTime <> 0 then aItem.EndDateTime := QryMainEndtime.asDateTime
//    else if QryMainHours.AsFloat <> 0 then aItem.EndDateTime := incminute(aItem.StartDateTime , trunc(QryMainHours.AsFloat*60))
//    else aItem.EndDateTime := incminute(aItem.StartDateTime , trunc(QryMainTrainingHrs.AsFloat*60));
    if QryMainEndtime.asDateTime <> 0 then EndTime := QryMainEndtime.asDateTime
    else if QryMainHours.AsFloat <> 0 then EndTime := incminute(aItem.StartDateTime , trunc(QryMainHours.AsFloat*60))
    else EndTime := incminute(aItem.StartDateTime , trunc(QryMainTrainingHrs.AsFloat*60));
    if EndTime > aItem.StartDateTime then
      aItem.EndDateTime:= EndTime
    else
      aItem.EndDateTime:= IncMinute(aItem.StartDateTime, 5);



    aItem.Row :=r;

    if Progress<=0 then else begin
      x:=MinutesBetween(aItem.StartDateTime , aItem.EndDateTime);
      if x <Progress then begin
        aItem.Progress :=100;
        Progress:= Progress-MinutesBetween(aItem.StartDateTime , aItem.EndDateTime);
      end else begin
        aItem.Progress :=trunc(Progress/x * 100);
        Progress:= 0;
      end;
    end;
    if Assigned(aItem2) then aItem.AddPredecessor(aItem2);
    aItem2 := aitem;
    aItem.TextRight.Text:='   '+ QryMainTrainingModuleName.asString+' (' +
                IntToStr(QryStatusAllEntries.asInteger - QryStatusnotDone.asInteger)+'/' +
                IntToStr(QryStatusAllEntries.asInteger) +')'(*+'(' +IntToStr(trunc(MinutesBetween(aItem.StartDateTime , aItem.EndDateTime)/60))+' hrs)'*);
    aItem.TextRight.Text := aItem.TextRight.Text + ' ' + qryMainDescription.AsString;
    aItem.TextLeft.Font.Color := clgreen;
    aItem.TextLeft.Font.Height := -12;
    aItem.TextLeft.Font.Name := 'Arial';
    aItem.TextRight.font.Color := clgreen;
    Previoustime :=aItem.EndDateTime;
  end;

  Procedure AddEmployee;
  var
    xTRainingEmployee: pTRainingEmployee;
  begin
    New(xTRainingEmployee);
    xTRainingEmployee^.employeeId := QryMainemployeeId.asInteger;
    xTRainingEmployee^.employeename := QrymainEmployeeName.AsString;
    xTRainingEmployee^.RowNo := FETaskList1.Items.count;
    lstTRainingEmployees.Add(xTRainingEmployee);
  end;

begin
  inherited;

  FETaskGrid1.Row :=0;
  SearchedEmployeeID:=0;
  edtEmployeeSearch.text:='';

  lstTRainingEmployees.clear;
  CloseDB(QryMain);
  CloseDB(QryStatus);
  CloseDB(QrytotalHours);

  openQueries;
  FETaskList1.Items.Clear;
  if QryMain.Recordcount = 0 then exit;
  QryMain.first;
  EmployeeId := QryMainEmployeeId.asInteger;
  FEGant1.LeftDateTime := 0;//QryMainStartTime.asDateTime;
  r:= 1;
  While QryMain.eof = False do begin
      aItem2 := nil;
      sTime:=0; etime:= 0;
      totProgress :=0;
      Summaryr:= r;
      Previoustime:=Date;
      Addemployee;
      While (EmployeeID = QryMainemployeeId.asInteger) and (QryMain.Eof=False) do begin
        EmpName    := QrymainEmployeeName.AsString;
        ModuleID   := QryMainModuleId.asInteger;
        Done       :=Tasksdonebyemployee(EmployeeId,ModuleId);
        AllEntries := QryStatusAllEntries.asInteger ;
        Progress   := trunc((HoursforModule(EmployeeId,ModuleId)*Done/Allentries)*60);
        ctr:= 0;
        While (moduleId = QryMainModuleId.asInteger) and (EmployeeID = QryMainemployeeId.asInteger) and (QryMain.Eof=False) do begin
          AddItem;
          if (FEGant1.LeftDateTime >  aitem.StartDateTime) or (FEGant1.LeftDateTime=0) then
            FEGant1.LeftDateTime :=  DateOf(aitem.StartDateTime);
          if (stime=0) or (stime> aItem.StartDateTime) then stime := aItem.StartDateTime;
          if (eTime=0) or (etime <aItem.EndDateTime) then etime := aItem.EndDateTime;
          totProgress:= totProgress+MinutesBetween(aItem.StartDateTime , aItem.EndDateTime);
          QryMain.Next;
        end;
        {summary}
      end;

      r:= r+1;
      aItem := FETaskList1.Items.Add;
//      aItem.Tag := EmployeeID;
      aItem.Tag := qryMainTrainingEmployeeModuleStatusID.AsInteger;
      aItem.Style :=tsSummary;
      aItem.Name := empName;
      aItem.StartDateTime :=  sTime;
      aItem.EndDateTime := eTime;
      aItem.Row := Summaryr;
      aItem.Progress:= totProgress;
      aItem.TextLeft.Text:=empName +'(' +minToHours(totProgress)+')   ';
      aItem.TextLeft.Font.Color := clPurple;
      aItem.TextLeft.Font.Height := -12;
      aItem.TextLeft.Font.Name := 'Arial';
      if QryMain.Eof = False then begin
        EmployeeId := QryMainEmployeeId.asInteger;
      end;
  end;
  Rowcount := r-1;
end;

procedure TfmTrainingStatusChart.FormCreate(Sender: TObject);
begin
  inherited;
  FEGant1.CaptionSummary.DisplayFormat := 'DDDD ' + FormatSettings.ShortDateformat;
  EmployeeId :=0;
  Rowcount := -1;
  lstTRainingEmployees:= TList.create;
  SearchedEmployeeID:=0;
end;

procedure TfmTrainingStatusChart.GantSettings1Click(Sender: TObject);
begin
  FEGantSetupDialog1.Execute;
end;

procedure TfmTrainingStatusChart.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmTrainingStatusChart.OpenFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    FETaskList1.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfmTrainingStatusChart.SaveToFile1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    FETaskList1.SaveToFile( SaveDialog1.FileName);
end;


procedure TfmTrainingStatusChart.BeforeShowTrainingStatus(Sender: TObject);
begin
  if not (Sender is  TfmTrainingStatus) then exit;
//  TfmTrainingStatus(Sender).employeeId := FETaskList1.Items[FETaskGrid1.Row].Tag;
  if qryMain.Locate('TrainingEmployeeModuleStatusID',FETaskList1.Items[FETaskGrid1.Row].Tag,[]) then begin
    TfmTrainingStatus(Sender).EmployeeId := self.QryMainEmployeeId.AsInteger;
    TfmTrainingStatus(Sender).TrainingID := self.qryMainTrainingID.AsInteger;
  end;
end;

procedure TfmTrainingStatusChart.FETaskGrid1DblClick(Sender: TObject);
begin
  inherited;
  if FETaskGrid1.Row >= Rowcount then exit;

  try
    if FETaskGrid1.Row < Rowcount then
      if FETaskList1.Items[FETaskGrid1.Row].Tag <=0 then exit;
  Except
      // kill the wexception
  end;
  if qryMain.Locate('TrainingEmployeeModuleStatusID',FETaskList1.Items[FETaskGrid1.Row].Tag,[]) then begin
    TfmTrainingStatus(Sender).EmployeeId := self.QryMainEmployeeId.AsInteger;
    TfmTrainingStatus(Sender).TrainingID := self.qryMainTrainingID.AsInteger;
    if (self.QryMainEmployeeId.AsInteger = AppEnv.Employee.EmployeeID) or
      (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanUpdateTrainingstatus') =1)   then begin
        OpenERPFormModal('TfmTrainingStatus' , 0 , BeforeShowTrainingStatus);
        ShowERPHint(9);
        RefreshChart;
    end else MessageDlgXP_Vista('You Don''t Have Access to ' + tcDataUtils.getemployeeName(self.QryMainEmployeeId.AsInteger)+'''s Status' , mtWarning, [mbok],0);
  end;
end;

procedure TfmTrainingStatusChart.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTrainingStatusChart.RefreshOption;
begin
  if fbShowingAll then  begin
    Self.Caption := 'Training Progress';
    TitleLabel.Caption:= 'Training Progress';
    btnShow.caption := 'Show Training Progress of ' + tcdatautils.getemployeeName(EmployeeId);
  end else begin
    Self.Caption := 'Training Progress ('+ tcdatautils.getemployeeName(QryMain.Parambyname('employeeID').asInteger)+')';
    TitleLabel.Caption:= 'Training Progress ('+ tcdatautils.getemployeeName(QryMain.Parambyname('employeeID').asInteger)+')';
    btnShow.caption :='Show Training Progress of All Employees';
  end;
end;

procedure TfmTrainingStatusChart.btnShowClick(Sender: TObject);
begin
    CloseDB(QryMain);
    CloseDB(QryStatus);
    CloseDB(QrytotalHours);
  if not fbShowingAll then begin
    QryMain.Parambyname('employeeID').asInteger       := 0;
    QryStatus.Parambyname('employeeID').asInteger     := 0;
    QrytotalHours.Parambyname('employeeID').asInteger := 0;
    fbShowingAll := True;
  end else begin
    QryMain.Parambyname('employeeID').asInteger       := EmployeeID;
    QryStatus.Parambyname('employeeID').asInteger     := EmployeeID;
    QrytotalHours.Parambyname('employeeID').asInteger := EmployeeID;
    fbShowingAll:= False;
  end;
  Refreshform;
end;

procedure TfmTrainingStatusChart.FETaskGrid1Click(Sender: TObject);
begin
  inherited;
  try
    if FETaskGrid1.Row < Rowcount then
      FEGant1.LeftDateTime := DAteOf(FETaskList1.Items[FETaskGrid1.Row].StartDateTime);
  Except
      // kill the wexception
  end;
end;




procedure TfmTrainingStatusChart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  (*CloseERPVideo;*)
  Action := caFree;
end;

procedure TfmTrainingStatusChart.MoveDate(direction: tMoveDate);
begin
      if direction = mmNext then FEGant1.LeftDateTime := incday(Dateof(FEGant1.LeftDateTime) , 1)
      else FEGant1.LeftDateTime := incday(Dateof(FEGant1.LeftDateTime), -1);
end;

procedure TfmTrainingStatusChart.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  MoveDate(mmnext);
end;

procedure TfmTrainingStatusChart.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  MoveDate(mmPrevious);
end;

procedure TfmTrainingStatusChart.QryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if Qrymain.recordcount = 0 then begin
    if QryMain.Parambyname('EmployeeID').asInteger = 0 then else
      MessageDlgXP_Vista(GetEmployeeName(QryMain.Parambyname('EmployeeID').asInteger)+' Doesn''t Have Any Modules Assigned' , mtWarning , [mbok],0 );
  end;
end;

procedure TfmTrainingStatusChart.btnPrintClick(Sender: TObject);
begin
  inherited;
  FEGant1.PrintSettings.Text := TitleLabel.caption;
  FEGant1.Print;
  MessageDlgXP_Vista('Printing '+ TitleLabel.Caption +' is Finished' , mtInformation, [mbok],0);
end;

procedure TfmTrainingStatusChart.onShowERPHint(const Value: Integer);
begin
  inherited;
  if Value =9 then begin
    HighlightControl(btnTrainingstatus);
  end;
end;

procedure TfmTrainingStatusChart.btnTrainingstatusClick(Sender: TObject);
begin
  inherited;
  FETaskGrid1DblClick(FETaskGrid1);
end;

procedure TfmTrainingStatusChart.btnTrainingRosterClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmTrainingRoster' , 0 , nil);
end;

procedure TfmTrainingStatusChart.FormDestroy(Sender: TObject);
begin
  FreeAndnil(lstTRainingEmployees);   
  inherited;

end;

procedure TfmTrainingStatusChart.edtEmployeeSearchChange(Sender: TObject);
var
   i:Integer;
   xTRainingEmployee: pTRainingEmployee;
   str:String;
begin
  inherited;
  SearchedEmployeeID:= 0;
  if Trim(edtEmployeeSearch.text) = '' then exit;
  for i := 0 to lstTRainingEmployees.Count - 1 do begin
     xTRainingEmployee := lstTRainingEmployees[i];
     str:=edtEmployeeSearch.text;
     str:= trim(str);
     if Fastfuncs.PosExIgnoreCase(str, xTRainingEmployee^.EmployeeName)=1 then begin
         FETaskGrid1.Row :=xTRainingEmployee^.RowNo;
         SearchedEmployeeID :=xTRainingEmployee^.EmployeeId;
         break;
     end;
  end;
end;

procedure TfmTrainingStatusChart.btnEmployeeSearchClick(Sender: TObject);
begin
    if SearchedEmployeeID = 0 then exit;
    CloseDB(QryMain);
    CloseDB(QryStatus);
    CloseDB(QrytotalHours);

    QryMain.Parambyname('employeeID').asInteger       := SearchedEmployeeID;
    QryStatus.Parambyname('employeeID').asInteger     := SearchedEmployeeID;
    QrytotalHours.Parambyname('employeeID').asInteger := SearchedEmployeeID;

    fbShowingAll:= False;

    Refreshform;
end;

initialization
  RegisterClassOnce(TfmTrainingStatusChart);
end.
