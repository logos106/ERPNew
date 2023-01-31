unit frmERPSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, StdCtrls, Shader, ExtCtrls,
  DNMPanel, busobjErpSetup,BaseInputForm, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  BusObjBase, AppEvnts , dmMainGUI, DBCtrls, ProgressDialog, Mask, wwdbedit;

type
  TfmERPSetup = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label3: TLabel;
    Shader1: TShader;
    btnStep1: TDNMSpeedButton;
    Shader2: TShader;
    lblStep2: tDBText;
    btnStep2: TDNMSpeedButton;
    Shader3: TShader;
    lblstep6: TDBText;
    Shader4: TShader;
    lblStep3: TDBText;
    btnStep3: TDNMSpeedButton;
    Shader5: TShader;
    lblstep4: TDBText;
    btnStep4: TDNMSpeedButton;
    Shader6: TShader;
    lblStep5: TDBText;
    btnStep5: TDNMSpeedButton;
    btnStep6: TDNMSpeedButton;
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qryerpsetup: TERPQuery;
    qryerpsetupGlobalRef: TWideStringField;
    qryerpsetupID: TLargeintField;
    qryerpsetupStep1: TWideStringField;
    qryerpsetupStep1Caption: TWideStringField;
    qryerpsetupStep2: TWideStringField;
    qryerpsetupStep2Caption: TWideStringField;
    qryerpsetupStep3: TWideStringField;
    qryerpsetupStep3Caption: TWideStringField;
    qryerpsetupStep4: TWideStringField;
    qryerpsetupStep4Caption: TWideStringField;
    qryerpsetupStep5: TWideStringField;
    qryerpsetupStep5Caption: TWideStringField;
    qryerpsetupStep6: TWideStringField;
    qryerpsetupStep6Caption: TWideStringField;
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
    qryerpsetupStep1VideoFilename: TWideStringField;
    qryerpsetupStep2VideoFilename: TWideStringField;
    qryerpsetupStep3VideoFilename: TWideStringField;
    qryerpsetupStep4VideoFilename: TWideStringField;
    qryerpsetupStep5VideoFilename: TWideStringField;
    qryerpsetupStep6VideoFilename: TWideStringField;
    qryerpsetupcStep1Caption: TWideStringField;
    qryerpsetupcStep2Caption: TWideStringField;
    qryerpsetupcStep3Caption: TWideStringField;
    qryerpsetupcStep4Caption: TWideStringField;
    qryerpsetupcStep5Caption: TWideStringField;
    qryerpsetupcStep6Caption: TWideStringField;
    lblstep1: TDBText;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStep1Click(Sender: TObject);
    procedure btnStep2Click(Sender: TObject);
    procedure btnStep3Click(Sender: TObject);
    procedure btnStep4Click(Sender: TObject);
    procedure btnStep5Click(Sender: TObject);
    procedure btnStep6Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblSkip2Click(Sender: TObject);
    procedure lblSkip3Click(Sender: TObject);
    procedure lblSkip4Click(Sender: TObject);
    procedure lblSkip5Click(Sender: TObject);
    procedure lblSkip6Click(Sender: TObject);
    procedure lblVideo2Click(Sender: TObject);
    procedure lblVideo3Click(Sender: TObject);
    procedure lblVideo4Click(Sender: TObject);
    procedure lblVideo5Click(Sender: TObject);
    procedure lblVideo6Click(Sender: TObject);
    procedure qryerpsetupCalcFields(DataSet: TDataSet);
  private
    fbSettingupERp: boolean;

      Procedure ThisStepdone(const Value:Integer);
      Procedure Refreshdisplay;
      function ValidtodoStep(Const Stepvalue:integer):Boolean;
      Procedure ToImport(Sender:TObject);
      Procedure ToExport(Sender:TObject);
      Procedure PostAndcloseERPSetpup(Sender:TObject);

      Procedure AftershowCompanyinfo(Sender:TObject);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    ERPSetup:  TERPSetup;
    CompaniesAlreadyCreated:Boolean;
    Property  SettingupERp :boolean read fbSettingupERp write fbSettingupERp;

    Class Procedure SetUpERP(CompaniesAlreadyCreated:Boolean);
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;


implementation

uses CommonLib, CommonFormLib, MAIN, frmExportOptionsFrm,
  CommonDbLib, AppEnvironment, AppDatabase, BusObjConst,
  wwradiogroup, FastFuncs, frmERPSetupExportImportData,
  DNMLib,systemlib, frmVideoPlayer;

{$R *.dfm}
procedure TfmERPSetup.FormCreate(Sender: TObject);
begin
  inherited;
  ERPSetup:=  TERPSetup.create(self);
  ERPSetup.connection := TMyDacDataConnection.Create(ERPSetup);
  ERPSetup.connection.Connection:= Self.MyConnection;
  ERPSetup.BusObjEvent := DoBusinessObjectEvent;
  fbSettingupERp := False;

  imgDone1.Left := 30;
  imgDone2.Left := 30;
  imgDone3.Left := 30;
  imgDone4.Left := 30;
  imgDone5.Left := 30;
  imgDone6.Left := 30;

  imgnotDone1.Left := 30;
  imgnotDone2.Left := 30;
  imgnotDone3.Left := 30;
  imgnotDone4.Left := 30;
  imgnotDone5.Left := 30;
  imgnotDone6.Left := 30;

end;

procedure TfmERPSetup.FormShow(Sender: TObject);
begin
  inherited;
  if not SettingupERp then begin
    CompaniesAlreadyCreated := True;
    ERPSetup.Load;
    if not (ERPSetup.Lock) then begin
        AccessLevel := 5;
        MessageDlgXP_Vista('Unable to Setup ERP.'+chr(13)+'Currently the User "'+ERPSetup.UserLock.LockInfo.Username +'" is Setting Up ERP Since since: ' + FormatDateTime('dd/mm hh:nn:ss', ERPSetup.UserLock.LockInfo.TimeLocked) , mtinformation, [mbok],0 );
        btnStep1.Enabled := False;
        btnStep2.Enabled := False;
        btnStep3.Enabled := False;
        btnStep4.Enabled := False;
        btnStep5.Enabled := False;
        btnStep6.Enabled := False;
        lblSkip2.Enabled := False;
        lblSkip3.Enabled := False;
        lblSkip4.Enabled := False;
        lblSkip5.Enabled := False;
        lblSkip6.Enabled := False;
    end;
  end;

  lblSkip2.visible := CompaniesAlreadyCreated and not(ERPSetup.Step2);
  lblSkip3.visible := CompaniesAlreadyCreated and not(ERPSetup.Step3);
  lblSkip4.visible := CompaniesAlreadyCreated and not(ERPSetup.Step4);
  lblSkip5.visible := CompaniesAlreadyCreated and not(ERPSetup.Step5);
  lblSkip6.visible := CompaniesAlreadyCreated and not(ERPSetup.Step6);
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

  if  (ERPSetup.Step1) and  (ERPSetup.Step2) and
      (ERPSetup.Step3) and  (ERPSetup.Step4) and
      (ERPSetup.Step5)  then
    if fsModal in FormState then begin
        modalresult := mrok;
        Self.Close;
        Exit;
    end;

(*  lblStep1.Caption := ERPSetup.Step1Caption;
  lblStep2.Caption := ERPSetup.Step2Caption;
  lblStep3.Caption := ERPSetup.Step3Caption;
  lblStep4.Caption := ERPSetup.Step4Caption;
  lblStep5.Caption := ERPSetup.Step5Caption;
  lblStep6.Caption := ERPSetup.Step6Caption;*)

  Refreshdisplay;


end;

procedure TfmERPSetup.ThisStepdone(const Value: Integer);
var
  lblcaption:TDBText;
  lblNo:TLabel;
  imgdone:TImage;
begin
  if Value = 1 then begin
     lblCaption := lblstep1;
     lblno :=lblno1;
     imgdone := imgdone1;
  end else if Value = 2 then begin
     lblCaption := lblstep2;
     lblno :=lblno2;
     imgdone := imgdone2;
  end else if Value = 3 then begin
     lblCaption := lblstep3;
     lblno :=lblno3;
     imgdone := imgdone3;
  end else if Value = 4 then begin
     lblCaption := lblstep4;
     lblno :=lblno4;
     imgdone := imgdone4;
  end else if Value = 5 then begin
     lblCaption := lblstep5;
     lblno :=lblno5;
     imgdone := imgdone5;
  end else if Value = 6 then begin
     lblCaption := lblstep6;
     lblno :=lblno6;
     imgdone := imgdone6;
  end else exit;
  lblCaption.Font.Color := clGreen;
  lblno.Font.Color := clGreen;
  imgdone.visible := True;
end;

procedure TfmERPSetup.btnStep1Click(Sender: TObject);
begin
  inherited;
  MessageDlgXP_Vista('ERP is Already Installed in your System' , mtInformation , [mbok] , 0);
end;

procedure TfmERPSetup.btnStep2Click(Sender: TObject);
var
  NewDBname:String;
begin
  inherited;
  lblVideo2Click(nil);
  if not CompaniesAlreadyCreated then begin
    NewDBname:= MainForm.NewCompany;
    {newcompany failed}
    if NewDBname = '' then begin
        MessageDlgXP_Vista('Database Creation Failed. You Cannot Proceed Without Creating a new Database.  Please Contact  ERP' ,mtInformation , [mbok] , 0 );
        Exit;
    end;

    {conenct to new company}
    try
      AppEnv.Reset;
      AppEnv.AppDb.connection.disconnect;
      AppEnv.AppDb.Database:= NewDBname;
      AppEnv.AppDb.ConnectUser('Admin', 'Admin');
      SetGlobalIsolationLevel(AppEnv.AppDb.Connection);
      Application.ProcessMessages;
      Application.Title := Application.Title+ ' [' + GetCompanyName+ ']';
      CompaniesAlreadyCreated:= True;
      ERPSetup.CloseDB;
      MyConnection.Disconnect;
      MyConnection.Database:=AppEnv.AppDb.Database;
      MyConnection.Server := AppEnv.AppDb.Server;
      MyConnection.Connect;
      ERPSetup.load;

    Except
      //any exception should stop here
      on E:Exception do begin
          MessageDlgXP_Vista('Failed to connect to ' + NewDBname+'.  Please Contact ERP.' +chr(13)+E.message, mtInformation , [mbok] , 0);
          Exit;
      end;
    end;
  end;

  OpenERPForm('TfrmCompanyInformation' ,0, AftershowCompanyinfo, nil);
end;

procedure TfmERPSetup.btnStep3Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoStep(3) then Exit;
  OpenERPForm('TfmERPSetupExportImportData' ,0  , ToExport, nil);
  lblVideo3Click(nil);
  ERPSetup.Step3:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
end;


procedure TfmERPSetup.btnStep4Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoStep(4) then Exit;

   OpenERPForm('TfmERPSetupExportImportData' ,0 , ToImport, nil);
   lblVideo4Click(nil);
      ERPSetup.Step4:= true;
      ERpSetup.PostDB;
      Refreshdisplay;

end;

procedure TfmERPSetup.btnStep5Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoStep(5) then Exit;
  lblVideo5Click(nil);
    MainForm.Backup1Click(Self);
      ERPSetup.Step5:= true;
      ERpSetup.PostDB;
      Refreshdisplay;

end;

procedure TfmERPSetup.btnStep6Click(Sender: TObject);
begin
  inherited;
  if not ValidtodoStep(6) then Exit;
  CloseERPVideo;
  //lblVideo6Click(nil);
  OpenERPFormModal('TfmERPTrainingSetup' ,0 , PostAndcloseERPSetpup, true);
  
end;

procedure TfmERPSetup.Refreshdisplay;
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

  lblstep1.font.color := clblue; lblno1.font.color := clblue;
  lblstep2.font.color := clblue; lblno2.font.color := clblue;
  lblstep3.font.color := clblue; lblno3.font.color := clblue;
  lblstep4.font.color := clblue; lblno4.font.color := clblue;
  lblstep5.font.color := clblue; lblno5.font.color := clblue;
  lblstep6.font.color := clblue; lblno6.font.color := clblue;

  if not (ERPSetup.Step1) then begin imgNotDone1.visible := True; exit; end;
  ThisStepdone(1);
  if not (ERPSetup.Step2) then begin imgNotDone2.visible := True; exit; end;
  if not CompaniesAlreadyCreated then begin imgNotDone2.visible := True; exit; end;
  ThisStepdone(2);
  if not (ERPSetup.Step3) then begin imgNotDone3.visible := True; exit; end;
  ThisStepdone(3);
  if not (ERPSetup.Step4) then begin imgNotDone4.visible := True; exit; end;
  ThisStepdone(4);
  if not (ERPSetup.Step5) then begin imgNotDone5.visible := True; exit; end;
  ThisStepdone(5);
  if not (ERPSetup.Step6) then begin imgNotDone6.visible := True; exit; end;
  ThisStepdone(6);

end;

class procedure TfmERPSetup.SetUpERP(CompaniesAlreadyCreated:Boolean);
var
  form :Tcomponent;
begin
  form := GetComponentByClassName('TfmERPSetup' , true, nil, False);
  if not assigned(Form) then exit;
  try
    TfmERPSetup(form).ERPSetup.Load;

    if not (TfmERPSetup(form).ERPSetup.Lock) then begin
      if not CompaniesAlreadyCreated then 
        MessageDlgXP_Vista('Unable to Setup ERP.'+chr(13)+'Currently the User "'+TfmERPSetup(form).ERPSetup.UserLock.LockInfo.Username +'" is Setting Up ERP Since : ' + FormatDateTime('dd/mm hh:nn:ss', TfmERPSetup(form).ERPSetup.UserLock.LockInfo.TimeLocked) , mtinformation, [mbok],0 );
        Exit;
    end;
    if not CompaniesAlreadyCreated then begin
      if TfmERPSetup(form).ERPSetup.Step2 then TfmERPSetup(form).ERPSetup.Step2:= False;
      if TfmERPSetup(form).ERPSetup.Step3 then TfmERPSetup(form).ERPSetup.Step3:= False;
      if TfmERPSetup(form).ERPSetup.Step4 then TfmERPSetup(form).ERPSetup.Step4:= False;
      if TfmERPSetup(form).ERPSetup.Step5 then TfmERPSetup(form).ERPSetup.Step5:= False;
      TfmERPSetup(form).ERPSetup.PostDB;
    end;

    if  (TfmERPSetup(form).ERPSetup.Step1) and  (TfmERPSetup(form).ERPSetup.Step2) and
          (TfmERPSetup(form).ERPSetup.Step3) and  (TfmERPSetup(form).ERPSetup.Step4) and
          (TfmERPSetup(form).ERPSetup.Step5)  then
          Exit;
    TfmERPSetup(form).CompaniesAlreadyCreated := CompaniesAlreadyCreated;
    TfmERPSetup(form).SettingupERp := true;
    TfmERPSetup(form).showModal;
  Finally
      Freeandnil(form);
  end;
end;

procedure TfmERPSetup.btnCloseClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then begin
        modalresult := mrok;
  end else begin
        Self.Close;
  end;
end;

procedure TfmERPSetup.FormDestroy(Sender: TObject);
begin
  FreeandNil(ERPSetup);
  inherited;

end;

procedure TfmERPSetup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  ERPSetup.postDB;
end;

procedure TfmERPSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 if not(fsModal in FormState) then Action := caFree;
 CloseERPVideo;
 if  (not ERPSetup.Step1) or  (not ERPSetup.Step2) or
      (not ERPSetup.Step3) or  (not ERPSetup.Step4) or
      (not ERPSetup.Step5)  then
  if not MainForm.visible then Application.terminate ;

end;



function TfmERPSetup.ValidtodoStep(const Stepvalue: integer): Boolean;
begin
  REsult := False;
  if StepValue >=2 then begin
    if (not(CompaniesAlreadyCreated)) then begin
        MessageDlgXP_Vista('Please Setup Client''s Company' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if StepValue >=3 then begin
    if (not(ERPSetup.Step2))  then begin
        MessageDlgXP_Vista('Please Setup Client''s Company' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if StepValue >=4 then begin
    if (not(ERPSetup.Step3))  then begin
        MessageDlgXP_Vista('Please Export Sample Data' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if StepValue >=5 then begin
    if (not(ERPSetup.Step4))  then begin
        MessageDlgXP_Vista('Please Import Client Data' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;

  if StepValue >=6 then begin
    if (not(ERPSetup.Step5))  then begin
        MessageDlgXP_Vista('Please Take a Backup' , mtWarning, [mbok] , 0);
        Exit;
    end;
  end;
  Result := True;
end;

procedure TfmERPSetup.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TERPSetup then TERPSetup(Sender).Dataset := qryerpsetup;
  end;
end;  
procedure TfmERPSetup.ToExport(Sender: TObject);
begin
  if not(Sender is TfmERPSetupExportImportData) then exit;
  TfmERPSetupExportImportData(Sender).ERPSetupMode := tsmExport;
end;

procedure TfmERPSetup.ToImport(Sender: TObject);
begin
  if not(Sender is TfmERPSetupExportImportData) then exit;
  TfmERPSetupExportImportData(Sender).ERPSetupMode := tsmImport;
end;

procedure TfmERPSetup.lblSkip2Click(Sender: TObject);
begin
  inherited;
  ERPSetup.Step2:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip2.visible := False;
end;

procedure TfmERPSetup.lblSkip3Click(Sender: TObject);
begin
  inherited;
  ERPSetup.Step3:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip3.visible := False;

end;

procedure TfmERPSetup.lblSkip4Click(Sender: TObject);
begin
  inherited;
  ERPSetup.Step4:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip4.visible := False;
end;

procedure TfmERPSetup.lblSkip5Click(Sender: TObject);
begin
  inherited;
  ERPSetup.Step5:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip5.visible := False;
end;

procedure TfmERPSetup.lblSkip6Click(Sender: TObject);
begin
  inherited;
  ERPSetup.Step6:= true;
  ERpSetup.PostDB;
  Refreshdisplay;
  lblSkip6.visible := False;
  btnClose.Click;
end;

procedure TfmERPSetup.lblVideo2Click(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.Step2VideoFilename );
end;

procedure TfmERPSetup.lblVideo3Click(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.Step3VideoFilename );
end;

procedure TfmERPSetup.lblVideo4Click(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.Step4VideoFilename );
end;

procedure TfmERPSetup.lblVideo5Click(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.Step5VideoFilename );
end;

procedure TfmERPSetup.lblVideo6Click(Sender: TObject);
begin
  inherited;
  PlayERPVideo(exedir+'videos\'+ERPSetup.Step6VideoFilename );
end;

procedure TfmERPSetup.AftershowCompanyinfo(Sender: TObject);
begin
  if Sysutils.SameText(Sender.classname , 'TfrmCompanyInformation') then begin
      TBaseInputGUI(Sender).AttachObserver(Self);
  end;
end;


procedure TfmERPSetup.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
    if Assigned(aObject) and Sysutils.SameText(aObject.classname , 'TfrmCompanyInformation') then begin
      if not(CommonDbLib.GetCompanyName(true) = 'Default Company') then begin
          ERPSetup.Step2:= true;
          ERpSetup.PostDB;
          Refreshdisplay;
      end;
    end;
end;

procedure TfmERPSetup.PostAndcloseERPSetpup(Sender: TObject);
begin
  ERPSetup.Step6:= true;
  ERpSetup.PostDB;
  if  (ERPSetup.Step1) and  (ERPSetup.Step2) and
      (ERPSetup.Step3) and  (ERPSetup.Step4) and
      (ERPSetup.Step5) and  (ERPSetup.Step6) then
  if fsModal in FormState then begin
        modalresult := mrok;
        Self.close;
        Exit;
  end else begin
        Self.close;
        Exit;
  end;
  Refreshdisplay;
end;

procedure TfmERPSetup.qryerpsetupCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryerpsetupcStep1Caption.asString := DoTranslate(QryERpSetupStep1Caption.asString);
  qryerpsetupcStep2Caption.asString := DoTranslate(QryERpSetupStep2Caption.asString);
  qryerpsetupcStep3Caption.asString := DoTranslate(QryERpSetupStep3Caption.asString);
  qryerpsetupcStep4Caption.asString := DoTranslate(QryERpSetupStep4Caption.asString);
  qryerpsetupcStep5Caption.asString := DoTranslate(QryERpSetupStep5Caption.asString);
  qryerpsetupcStep6Caption.asString := DoTranslate(QryERpSetupStep6Caption.asString);
end;

initialization
  RegisterClassOnce(TfmERPSetup);

end.
