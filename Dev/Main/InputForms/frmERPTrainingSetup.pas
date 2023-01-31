unit frmERPTrainingSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, StdCtrls, Shader, ExtCtrls,
  DNMPanel, busobjErpSetup,BaseInputForm, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  BusObjBase, AppEvnts , dmMainGUI, DBCtrls, ProgressDialog, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmERPTrainingSetup = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label3: TLabel;
    Shader1: TShader;
    lblTrainingStep1: TDBText;
    btnTrainingStep1: TDNMSpeedButton;
    Shader2: TShader;
    lblTrainingStep2: tDBText;
    btnTrainingStep2: TDNMSpeedButton;
    Shader3: TShader;
    lblTrainingStep6: TDBText;
    Shader4: TShader;
    lblTrainingStep3: TDBText;
    btnTrainingStep3: TDNMSpeedButton;
    Shader5: TShader;
    lblTrainingStep4: TDBText;
    btnTrainingStep4: TDNMSpeedButton;
    Shader6: TShader;
    lblTrainingStep5: TDBText;
    btnTrainingStep5: TDNMSpeedButton;
    btnTrainingStep6: TDNMSpeedButton;
    lblno1: TLabel;
    lblno2: TLabel;
    lblno3: TLabel;
    lblno4: TLabel;
    lblno5: TLabel;
    lblno6: TLabel;
    imgDone1: TImage;
    imgNotDone1: TImage;
    imgDone2: TImage;
    imgNotDone2: TImage;
    imgDone3: TImage;
    imgNotDone3: TImage;
    imgDone4: TImage;
    imgNotDone4: TImage;
    imgDone5: TImage;
    imgNotDone5: TImage;
    imgDone6: TImage;
    imgNotDone6: TImage;
    btnClose: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    qryerpsetup: TERPQuery;
    qryerpsetupGlobalRef: TWideStringField;
    qryerpsetupID: TLargeintField;
    qryerpsetupTrainingStep1: TWideStringField;
    qryerpsetupTrainingStep1Caption: TWideStringField;
    qryerpsetupTrainingStep2: TWideStringField;
    qryerpsetupTrainingStep2Caption: TWideStringField;
    qryerpsetupTrainingStep3: TWideStringField;
    qryerpsetupTrainingStep3Caption: TWideStringField;
    qryerpsetupTrainingStep4: TWideStringField;
    qryerpsetupTrainingStep4Caption: TWideStringField;
    qryerpsetupTrainingStep5: TWideStringField;
    qryerpsetupTrainingStep5Caption: TWideStringField;
    qryerpsetupTrainingStep6: TWideStringField;
    qryerpsetupTrainingStep6Caption: TWideStringField;
    dserpsetup: TDataSource;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    lblSkip2: TLabel;
    lblSkip3: TLabel;
    lblSkip4: TLabel;
    lblSkip5: TLabel;
    lblSkip6: TLabel;
    Shader7: TShader;
    DNMSpeedButton1: TDNMSpeedButton;
    lblVideo2: TLabel;
    lblVideo3: TLabel;
    lblVideo4: TLabel;
    lblVideo5: TLabel;
    lblVideo6: TLabel;
    lblSkip1: TLabel;
    Label8: TLabel;
    qryerpsetupTrainingStep1VideoFilename: TWideStringField;
    qryerpsetupTrainingStep2VideoFilename: TWideStringField;
    qryerpsetupTrainingStep3VideoFilename: TWideStringField;
    qryerpsetupTrainingStep4VideoFilename: TWideStringField;
    qryerpsetupTrainingStep5VideoFilename: TWideStringField;
    qryerpsetupTrainingStep6VideoFilename: TWideStringField;
    Label7: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qryerpsetupcTrainingstep1Caption: TWideStringField;
    qryerpsetupcTrainingstep2Caption: TWideStringField;
    qryerpsetupcTrainingstep3Caption: TWideStringField;
    qryerpsetupcTrainingstep4Caption: TWideStringField;
    qryerpsetupcTrainingstep5Caption: TWideStringField;
    qryerpsetupcTrainingstep6Caption: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTrainingStep1Click(Sender: TObject);
    procedure btnTrainingStep2Click(Sender: TObject);
    procedure btnTrainingStep3Click(Sender: TObject);
    procedure btnTrainingStep4Click(Sender: TObject);
    procedure btnTrainingStep5Click(Sender: TObject);
    procedure btnTrainingStep6Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrainingStepDone2(Sender: TObject);
    procedure TrainingStepDone3(Sender: TObject);
    procedure TrainingStepDone4(Sender: TObject);
    procedure TrainingStepDone5(Sender: TObject);
    procedure TrainingStepDone6(Sender: TObject);
    procedure PlayTrainingvideo2(Sender: TObject);
    procedure PlayTrainingvideo3(Sender: TObject);
    procedure PlayTrainingvideo4(Sender: TObject);
    procedure PlayTrainingvideo5(Sender: TObject);
    procedure PlayTrainingvideo6(Sender: TObject);
    procedure TrainingStepDone1(Sender: TObject);
    procedure PlayTrainingvideo1(Sender: TObject);
    procedure qryerpsetupCalcFields(DataSet: TDataSet);
  private
    fbSettingupERp: boolean;
    Activebutton:TDNMSpeedButton;
    TrainingDaycount,TrainingDayscount, TrainingEmployeescount :Integer;

      Procedure ThisTrainingStepdone(const Value:Integer);
      Procedure Refreshdisplay;
      function ValidtodoTrainingStep(Const TrainingStepvalue:integer):Boolean;

      Procedure SetDEfaultPageIndex(Sender:TObject);
      Procedure TrainingSetupAfteropen(Sender:TObject);
      Procedure TrainingSetupAfterClose(Sender:TObject);
  Protected
      procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;

  public
    ERPSetup:  TERPSetup;
    Property  SettingupERp :boolean read fbSettingupERp write fbSettingupERp;




  end;


implementation

uses CommonLib, CommonFormLib, MAIN, frmExportOptionsFrm,
  CommonDbLib, AppEnvironment, AppDatabase, BusObjConst,
  wwradiogroup, FastFuncs, frmERPSetupExportImportData,
 DNMLib,SystemLib, frmVideoPlayer, frmTrainingAssignment;

{$R *.dfm}
procedure TfmERPTrainingSetup.FormCreate(Sender: TObject);
begin
  inherited;
  ERPSetup:=  TERPSetup.create(self);
  ERPSetup.connection := TMyDacDataConnection.Create(ERPSetup);
  ERPSetup.connection.Connection:= Self.MyConnection;
  ERPSetup.BusObjEvent := DoBusinessObjectEvent;
  fbSettingupERp := False;

  imgDone1.Left := 16;
  imgDone2.Left := 16;
  imgDone3.Left := 16;
  imgDone4.Left := 16;
  imgDone5.Left := 16;
  imgDone6.Left := 16;

  imgnotDone1.Left := 16;
  imgnotDone2.Left := 16;
  imgnotDone3.Left := 16;
  imgnotDone4.Left := 16;
  imgnotDone5.Left := 16;
  imgnotDone6.Left := 16;

end;

procedure TfmERPTrainingSetup.FormShow(Sender: TObject);
begin
  inherited;
  if not SettingupERp then begin
    ERPSetup.Load;
    if not (ERPSetup.Lock) then begin
        AccessLevel := 5;
        MessageDlgXP_Vista('Unable to Setup ERP.'+chr(13)+'Currently the User "'+ERPSetup.UserLock.LockInfo.Username +'" is Setting Up ERP Since since: ' + FormatDateTime('dd/mm hh:nn:ss', ERPSetup.UserLock.LockInfo.TimeLocked) , mtinformation, [mbok],0 );
        btnTrainingStep1.Enabled := False;
        btnTrainingStep2.Enabled := False;
        btnTrainingStep3.Enabled := False;
        btnTrainingStep4.Enabled := False;
        btnTrainingStep5.Enabled := False;
        btnTrainingStep6.Enabled := False;
        lblSkip2.Enabled := False;
        lblSkip3.Enabled := False;
        lblSkip4.Enabled := False;
        lblSkip5.Enabled := False;
        lblSkip6.Enabled := False;
    end;
  end;
  lblSkip1.visible := not(ERPSetup.TrainingStep1);
  lblSkip2.visible := not(ERPSetup.TrainingStep2);
  lblSkip3.visible := not(ERPSetup.TrainingStep3);
  lblSkip4.visible := not(ERPSetup.TrainingStep4);
  lblSkip5.visible := not(ERPSetup.TrainingStep5);
  lblSkip6.visible := not(ERPSetup.TrainingStep6);
  (*if not (ERPSetup.Lock) then begin
      MessageDlgXP_Vista('Unable to Setup ERP.'+chr(13)+'Currently the User "'+ERPSetup.UserLock.LockInfo.Username +'" is Setting Up ERP Since : ' + FormatDateTime('dd/mm hh:nn:ss', ERPSetup.UserLock.LockInfo.TimeLocked) , mtinformation, [mbok],0 );
    if fsModal in FormState then begin
        modalresult := mrcancel;
        Exit;
    end else begin
        Self.Close;
        Exit;
    end;
  end;*)

(*  lblTrainingStep1.Caption := ERPSetup.TrainingStep1Caption;
  lblTrainingStep2.Caption := ERPSetup.TrainingStep2Caption;
  lblTrainingStep3.Caption := ERPSetup.TrainingStep3Caption;
  lblTrainingStep4.Caption := ERPSetup.TrainingStep4Caption;
  lblTrainingStep5.Caption := ERPSetup.TrainingStep5Caption;
  lblTrainingStep6.Caption := ERPSetup.TrainingStep6Caption;*)

  Refreshdisplay;


end;

procedure TfmERPTrainingSetup.ThisTrainingStepdone(const Value: Integer);
var
  lblcaption:TDBText;
  lblNo:TLabel;
  imgdone:TImage;
begin
  if Value = 1 then begin
     lblCaption := lblTrainingStep1;
     lblno :=lblno1;
     imgdone := imgdone1;
  end else if Value = 2 then begin
     lblCaption := lblTrainingStep2;
     lblno :=lblno2;
     imgdone := imgdone2;
  end else if Value = 3 then begin
     lblCaption := lblTrainingStep3;
     lblno :=lblno3;
     imgdone := imgdone3;
  end else if Value = 4 then begin
     lblCaption := lblTrainingStep4;
     lblno :=lblno4;
     imgdone := imgdone4;
  end else if Value = 5 then begin
     lblCaption := lblTrainingStep5;
     lblno :=lblno5;
     imgdone := imgdone5;
  end else if Value = 6 then begin
     lblCaption := lblTrainingStep6;
     lblno :=lblno6;
     imgdone := imgdone6;
  end else exit;
  lblCaption.Font.Color := clGreen;
  lblno.Font.Color := clGreen;
  imgdone.visible := True;
end;

procedure TfmERPTrainingSetup.btnTrainingStep1Click(Sender: TObject);
begin
  inherited;
  Activebutton := TDNMSpeedButton(Sender);
  OpenERPForm('TfmTrainingAssignment' ,0, SetDEfaultPageIndex, nil, True);
  TrainingStepDone1(nil);
  PlayTrainingvideo1(nil);
end;

procedure TfmERPTrainingSetup.btnTrainingStep2Click(Sender: TObject);
begin
  if not ValidtodoTrainingStep(2) then Exit;

  Activebutton := TDNMSpeedButton(Sender);
  OpenERPForm('TfmTrainingAssignment' ,0, SetDefaultPageIndex, nil, true);
  TrainingStepDone2(nil);
  PlayTrainingvideo2(nil);
end;

procedure TfmERPTrainingSetup.btnTrainingStep3Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoTrainingStep(3) then Exit;
  Activebutton := TDNMSpeedButton(Sender);
  OpenERPForm('TfmTrainingAssignment' ,0, SetDEfaultPageIndex, nil, true);
  TrainingStepDone3(nil);
  PlayTrainingvideo3(nil);
end;


procedure TfmERPTrainingSetup.btnTrainingStep4Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoTrainingStep(4) then Exit;
  OpenERPForm('TfmTrainingRoster' ,0, nil, nil, true);
  TrainingStepDone4(nil);
  PlayTrainingvideo4(nil);
end;

procedure TfmERPTrainingSetup.btnTrainingStep5Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoTrainingStep(5) then Exit;

  OpenERPForm('TfmTrainingStatus' ,0, nil, nil, true);
  TrainingStepDone5(nil);
  PlayTrainingvideo5(nil);
end;

procedure TfmERPTrainingSetup.btnTrainingStep6Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoTrainingStep(6) then Exit;

  OpenERPForm('TfmTrainingStatusChart' ,0, nil, nil, true);
  TrainingStepDone6(nil);
  PlayTrainingvideo6(nil);
  if ERPsetup.TrainingStep6 <> ErpSetup.CleanTrainingStep6 then btnClose.Click;
end;

procedure TfmERPTrainingSetup.Refreshdisplay;
begin
  imgNotDone1.Visible := False;
  imgNotDone2.Visible := False;
  imgNotDone3.Visible := False;
  imgNotDone4.Visible := False;
  imgNotDone5.Visible := False;
  imgNotDone6.Visible := False;

  imgDone1.Visible := False;
  imgDone2.Visible := False;
  imgDone3.Visible := False;
  imgDone4.Visible := False;
  imgDone5.Visible := False;
  imgDone6.Visible := False;

  lblTrainingStep1.font.color := clblue; lblno1.font.color := clblue;
  lblTrainingStep2.font.color := clblue; lblno2.font.color := clblue;
  lblTrainingStep3.font.color := clblue; lblno3.font.color := clblue;
  lblTrainingStep4.font.color := clblue; lblno4.font.color := clblue;
  lblTrainingStep5.font.color := clblue; lblno5.font.color := clblue;
  lblTrainingStep6.font.color := clblue; lblno6.font.color := clblue;

  if not (ERPSetup.TrainingStep1) then begin imgNotDone1.visible := True; exit; end;
  ThisTrainingStepdone(1);
  if not (ERPSetup.TrainingStep2) then begin imgNotDone2.visible := True; exit; end;
  ThisTrainingStepdone(2);
  if not (ERPSetup.TrainingStep3) then begin imgNotDone3.visible := True; exit; end;
  ThisTrainingStepdone(3);
  if not (ERPSetup.TrainingStep4) then begin imgNotDone4.visible := True; exit; end;
  ThisTrainingStepdone(4);
  if not (ERPSetup.TrainingStep5) then begin imgNotDone5.visible := True; exit; end;
  ThisTrainingStepdone(5);
  if not (ERPSetup.TrainingStep6) then begin imgNotDone6.visible := True; exit; end;
  ThisTrainingStepdone(6);

end;



procedure TfmERPTrainingSetup.btnCloseClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then begin
        modalresult := mrok;
  end else begin
        Self.Close;
  end;
end;

procedure TfmERPTrainingSetup.FormDestroy(Sender: TObject);
begin
  FreeandNil(ERPSetup);
  inherited;

end;

procedure TfmERPTrainingSetup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  ERPSetup.postDB;
end;

procedure TfmERPTrainingSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 if not(fsModal in FormState) then Action := caFree;
 CloseERPVideo;
 if  (not ERPSetup.TrainingStep1) or  (not ERPSetup.TrainingStep2) or
      (not ERPSetup.TrainingStep3) or  (not ERPSetup.TrainingStep4) or
      (not ERPSetup.TrainingStep5)  then
  if not MainForm.visible then Application.terminate ;
 Action := cafree;
end;



function TfmERPTrainingSetup.ValidtodoTrainingStep(const TrainingStepvalue: integer): Boolean;
begin
  REsult := False;
  if TrainingStepValue >=2 then begin
    if (not(ERPSetup.TrainingStep1))  then begin
        MessageDlgXP_Vista('Please Setup the Training' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if TrainingStepValue >=3 then begin
    if (not(ERPSetup.TrainingStep2))  then begin
        MessageDlgXP_Vista('Please Schedule the Training' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if TrainingStepValue >=4 then begin
    if (not(ERPSetup.TrainingStep3))  then begin
        MessageDlgXP_Vista('Please Select Employees for Training' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

(*  if TrainingStepValue >=5 then begin
    if (not(ERPSetup.TrainingStep3))  then begin
        MessageDlgXP_Vista('Please Import Client Data' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if TrainingStepValue >=6 then begin
    if (not(ERPSetup.TrainingStep3))  then begin
        MessageDlgXP_Vista('Please Take a Backup' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;*)
  Result := True;
end;

procedure TfmERPTrainingSetup.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TERPSetup then TERPSetup(Sender).Dataset := qryerpsetup;
  end;
end;  


procedure TfmERPTrainingSetup.TrainingStepDone2(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep2:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip2.visible := False;
end;

procedure TfmERPTrainingSetup.TrainingStepDone3(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep3:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip3.visible := False;

end;

procedure TfmERPTrainingSetup.TrainingStepDone4(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep4:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip4.visible := False;
end;

procedure TfmERPTrainingSetup.TrainingStepDone5(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep5:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip5.visible := False;
end;

procedure TfmERPTrainingSetup.TrainingStepDone6(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep6:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip6.visible := False;
//  btnClose.Click;
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo2(Sender: TObject);
begin
  inherited;
    PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep2VideoFilename );
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo3(Sender: TObject);
begin
  inherited;
    PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep3VideoFilename );
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo4(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep4VideoFilename );
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo5(Sender: TObject);
begin
  inherited;
    PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep5VideoFilename );
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo6(Sender: TObject);
begin
  inherited;
    PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep6VideoFilename );
end;

procedure TfmERPTrainingSetup.qryerpsetupCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryerpsetupcTrainingstep1Caption.asString := DoTranslate(qryerpsetupTrainingstep1Caption.asString);
  qryerpsetupcTrainingstep2Caption.asString := DoTranslate(qryerpsetupTrainingstep2Caption.asString);
  qryerpsetupcTrainingstep3Caption.asString := DoTranslate(qryerpsetupTrainingstep3Caption.asString);
  qryerpsetupcTrainingstep4Caption.asString := DoTranslate(qryerpsetupTrainingstep4Caption.asString);
  qryerpsetupcTrainingstep5Caption.asString := DoTranslate(qryerpsetupTrainingstep5Caption.asString);
  qryerpsetupcTrainingstep6Caption.asString := DoTranslate(qryerpsetupTrainingstep6Caption.asString);
end;

procedure TfmERPTrainingSetup.SetDEfaultPageIndex(Sender: TObject);
begin
    if not (Sender is TfmTrainingAssignment) then exit;

    TfmTrainingAssignment(sender).AfterTrainingformShow :=TrainingSetupAfteropen;
    TfmTrainingAssignment(sender).AfterTrainingformClose :=TrainingSetupAfterClose;
    if Activebutton = btnTrainingStep1 then TfmTrainingAssignment(sender).ActivePage := 1
    else if Activebutton = btnTrainingStep2 then TfmTrainingAssignment(sender).ActivePage := 2
    else if Activebutton = btnTrainingStep2 then TfmTrainingAssignment(sender).ActivePage := 3;
end;

procedure TfmERPTrainingSetup.TrainingStepDone1(Sender: TObject);
begin
  inherited;
  ERPSetup.TrainingStep1:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip1.visible := False;
end;

procedure TfmERPTrainingSetup.PlayTrainingvideo1(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.TRainingStep1VideoFilename );
end;

procedure TfmERPTrainingSetup.TrainingSetupAfteropen(Sender: TObject);
begin
  if not (Sender is TfmTrainingAssignment) then exit;
  TrainingDayscount       := TfmTrainingAssignment(Sender).Training.TrainingDays.count;
  TrainingEmployeescount  :=TfmTrainingAssignment(Sender).Training.TrainingEmployeeModules.count;
  TrainingDaycount        := TfmTrainingAssignment(Sender).Training.TrainingDay.count;
end;

procedure TfmERPTrainingSetup.TrainingSetupAfterClose(Sender: TObject);
begin
  if not (Sender is TfmTrainingAssignment) then exit;
  try
    if TrainingDaycount       <> TfmTrainingAssignment(Sender).Training.TrainingDay.count then if not erpsetup.Trainingstep1 then TrainingStepDone1(nil);
    if TrainingDayscount      <> TfmTrainingAssignment(Sender).Training.TrainingDays.count         then if not erpsetup.Trainingstep2 then TrainingStepDone2(nil);
    if TrainingEmployeescount <> TfmTrainingAssignment(Sender).Training.TrainingEmployeeModules.count                  then if not erpsetup.Trainingstep3 then TrainingStepDone3(nil);
  Except

  end;
end;


initialization
  RegisterClassOnce(TfmERPTrainingSetup);

end.

