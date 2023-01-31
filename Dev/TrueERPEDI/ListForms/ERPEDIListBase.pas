unit ERPEDIListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, CoreEDIObj, utBaseCoreService,
  ERPEDIBase; //, ErpSynchObj;

type
  TERPEDIListBaseGUI = class(TBaseListingGUI)
    pnlEDIAutocheckProgress: TPanel;
    lblListHint: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fHasEDIAutocheckProgress: Boolean;
    fShowLogAutomessage: boolean;
    procedure setHasEDIAutocheckProgress(const Value: Boolean);
    procedure SetShowLogAutomessage(const Value: boolean);
  Protected
    fEDIAutocheckProgress: TComponent;
    CoreEDIErrMsg : String;
    CoreEDI: TCoreEDI;
    CoreServObj :TBaseCoreService;
    SynchObj: TERPEDIBase;
    fsSynchCaption:String;

    Procedure DoEDIAutocheck(Sender: TObject); Virtual;
    Function Autocheck: Boolean; virtual;
    Function ModuleCaption: String; Virtual;
    procedure InitTimers(DoEnable: Boolean); virtual;
    Procedure DoEDICheckEvent; Virtual;
    Function CheckOrdersInterval: Integer; Virtual;
    property ShowLogAutomessage: boolean read fShowLogAutomessage write SetShowLogAutomessage;
    function InitializeCoreEDIObj: Boolean; Virtual;
    Function HasEDICredentials :Boolean ; Virtual;
    Function MakeCoreServiceObj :TBaseCoreService; Virtual;
    procedure DoOnSynchProg(Sender: TERPEDIBase; var Continue: boolean; msg: string);Virtual;
    procedure DoOnSynchError(Sender: TObject);Virtual;
    procedure DoOnLog(const msg: string; const aType: string = '');Virtual;
    procedure LogError(const UserMessage, APIMessage: string; CurrentTask: string = '');Virtual;
    procedure StopSynch(btnSynch: TDNMSpeedButton); Overload; Virtual;
    Procedure InitCodeEDI; Virtual;
    function CreateERPEDISynchObj: TERPEDIBase; virtual;
  public
    procedure LoginList(const Value: String; const ShowinList: Boolean = True); Virtual;
    Property HasEDIAutocheckProgress: Boolean read fHasEDIAutocheckProgress
      write setHasEDIAutocheckProgress;
    procedure HideProgressbar; Override;
    procedure ShowProgressBar(Progressbarcaption: string; Progresscount: Integer = 0;
      AllowCancel: Boolean = True; OnScriptExecuteProgressCancel: TNotifyEvent = nil); Override;
    procedure StepProgressBar(Const ProgressbarMsg: String = ''); Override;
    Procedure OpenPreferance; Virtual;

  end;

implementation

uses frmEDIAutocheckProgress, LogDialog, AppEnvironment, CommonLib, shellapi,
  JSONObject, JsonObjectUtils, Preferences, ErpSynchObj, FrmInputText,
  CoreEDILib;

{$R *.dfm}
{ TERPEDIListBaseGUI }

function TERPEDIListBaseGUI.HasEDICredentials: Boolean;
begin
  Result := True;
end;

procedure TERPEDIListBaseGUI.HideProgressbar;
begin
  inherited;
end;

procedure TERPEDIListBaseGUI.InitCodeEDI;
begin
  CoreEDILib.InitCodeEDI(CoreEDI);
(*var
  s: string;
  Ips :Array of String;
begin
  inherited;
//  CoreEDI.CoreEDIServer := 'localhost:8445';
//    CoreEDI.CoreEDIServer := 'erpclientserver.dyndns.org:8445';
  if DevMode then begin
    SetLength(IPS, 2);
    IPs[0] :='localhost:8445' ;
    IPs[1] :='erpclientserver.dyndns.org:8449';
    s:= SelectFromList('CoreEDI Server' , 'Server Address' ,'',
                      IPs ,
                      IPs[0]);
    //s := InputBox('CoreEDI Server','localhost:8445','localhost:8445');
    if s <> '' then
      CoreEDI.CoreEDIServer := s;
  end;*)
end;

procedure TERPEDIListBaseGUI.SetShowLogAutomessage(const Value: boolean);
begin
  fShowLogAutomessage := Value;
  if assigned(fEDIAutocheckProgress) then
    TfmEDIAutocheckProgress(fEDIAutocheckProgress).ShowLogAutomessage := Value;
end;

procedure TERPEDIListBaseGUI.ShowProgressBar(Progressbarcaption: string; Progresscount: Integer = 0;
  AllowCancel: Boolean = True; OnScriptExecuteProgressCancel: TNotifyEvent = nil);
begin
  inherited;
end;

procedure TERPEDIListBaseGUI.StepProgressBar(Const ProgressbarMsg: String = '');
begin
  inherited;
end;

procedure TERPEDIListBaseGUI.StopSynch(btnSynch: TDNMSpeedButton);
begin
//  if CoreEDI.Connected and SynchObj.Active then
    SynchObj.Active := true;
    btnSynch.Caption := fsSynchCaption;
end;


procedure TERPEDIListBaseGUI.setHasEDIAutocheckProgress(const Value: Boolean);
begin
  fHasEDIAutocheckProgress := Value;
  if Value then begin
    fEDIAutocheckProgress := TfmEDIAutocheckProgress.MakeEDIAutocheckProgress(Self, DoEDIAutocheck,
      pnlEDIAutocheckProgress, Autocheck, ModuleCaption, CheckOrdersInterval);
    TfmEDIAutocheckProgress(fEDIAutocheckProgress).ShowLogAutomessage := fShowLogAutomessage;
  end;
end;

procedure TERPEDIListBaseGUI.LogError(const UserMessage, APIMessage: string;CurrentTask: string);
var
  json: TJsonObject;
  s: string;
  function aLine :String;
  begin
    result := '--------------------------------------------------------';
  end;
begin
  s := '';
  if CurrentTask <> '' then
    s := 'Current Task: ' + CurrentTask + #13#10;

  s := s + 'ERROR Returned:' ;

  if UserMessage <> '' then begin
    s := s + UserMessage;
    s := s + #13#10;
  end;


  if APIMessage <> '' then begin
    json := JO;
    try
      json.AsString := APIMessage;
      s := s + JsonToStrFormat(json);
    finally
      json.Free;
    end;
  end;
//  else begin
//    s := s + 'Error Returned:' + #13#10 + #13#10 +
//      UserMessage;
//  end;
  LoginList(aLine + #13#10 +'Error Synchronizing Data' + #13#10 + s+#13#10 + aLine);

end;

procedure TERPEDIListBaseGUI.LoginList(const Value: String; const ShowinList: Boolean);
begin
  if ShowinList then begin
    LogToDialog(Value);
  end;
end;

function TERPEDIListBaseGUI.CheckOrdersInterval: Integer;
begin
  Result := 1000 * 10;
end;

function TERPEDIListBaseGUI.CreateERPEDISynchObj: TERPEDIBase;
begin
  result := TErpSynch.Create;
end;

procedure TERPEDIListBaseGUI.DoEDIAutocheck(Sender: TObject);
begin
end;

function TERPEDIListBaseGUI.MakeCoreServiceObj: TBaseCoreService;
begin
  Result := nil;
end;

function TERPEDIListBaseGUI.ModuleCaption: String;
begin
  Result := '';
end;

procedure TERPEDIListBaseGUI.OpenPreferance;
begin
end;

function TERPEDIListBaseGUI.Autocheck: Boolean;
begin
  Result := False;
end;


function TERPEDIListBaseGUI.InitializeCoreEDIObj: Boolean;
begin
//  result := False;
//  CoreEDIErrMsg := '';
//  if not Assigned(CoreEDI) then begin
//    if not HasEDICredentials  then begin
//          LoginList('ERROR : Missing EDI Credentials');
//          Exit;
//    end;
//    CoreEDI := TCoreEDI.Create;
//    InitCodeEDI;
//
//    CoreServObj := MakeCoreServiceObj;
//    CoreEDI.AddService(CoreServObj);
//
      SynchObj := CreateERPEDISynchObj; //TErpSynch.Create;
      SynchObj.OnSynchProgress := DoOnSynchProg;
      SynchObj.OnSynchError := DoOnSynchError;
 //     SynchObj.CoreService := CoreServObj;
      SynchObj.OnLog := DoOnLog;
//  end;

(*  if not CoreEDI.Connected then begin
    CoreEDI.CoreEDIUser     := AppEnv.CompanyPrefs.CoreEDIUSerName;
    CoreEDI.CoreEDIPassword := AppEnv.CompanyPrefs.CoreEDIPassword;

    try
      CoreEDI.Connect;
      result := True;
    except
      on e: exception do begin
        LoginList('The following error occured while trying to connect to the CoreEDI Server:' + #13#10 + #13#10 + e.Message);
        exit;
      end;
    end;

    if not CoreEDI.Connected then begin
      LoginList('Failed to connect to CoreEDI Server.');
      exit;
    end;

    if not CoreServObj.Initialize then begin

      if SameText(CoreServObj.ResultData.S['ReturnCode'], 'UserAuthRequired') then begin
        if CommonLib.MessageDlgXP_Vista(CoreServObj.ResultData.S['UserMessage'], mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
          ShellExecute(0, 'OPEN', PChar(CoreServObj.ResultData.S['AuthURL']), '', '', SW_SHOWNORMAL);
        result := false;
        exit;
      end else if SameText(CoreServObj.ResultData.S['ReturnCode'], 'Ok') then begin
        // success
      end else begin
        LoginList('The following error occured while trying to Initialize CoreEDI '+ CoreServObj.ServiceName +' Service:' + #13#10 + #13#10 +
          CoreServObj.ResultData.S['UserMessage']);
      end;

      CoreServObj.Initialized := false;
      CoreEDI.Connected := false;
      exit;
    end;
  end else begin
    Result := True;
  end;*)
  Result := True; //ConnecttoCoreEDI(CoreEDI, CoreServObj, LoginList);

  { connected and initialized }
//  if result then
//  SynchObj.Active := true;
end;

procedure TERPEDIListBaseGUI.initTimers(Doenable: Boolean);
begin
  if assigned(fEDIAutocheckProgress) then
    TfmEDIAutocheckProgress(fEDIAutocheckProgress).initTimers(Doenable);
end;

procedure TERPEDIListBaseGUI.DoEDICheckEvent;
begin
  if not Appenv.companyprefs.MagentoEnabled then
    if assigned(fEDIAutocheckProgress) then
      TfmEDIAutocheckProgress(fEDIAutocheckProgress).DoEDICheckEvent;
end;

procedure TERPEDIListBaseGUI.DoOnLog(const msg, aType: string);
var
  s: string;
begin
  s := aType;
  if s <> '' then s := s + ' ';
  s := s + msg;
  LogInList(s);
end;

procedure TERPEDIListBaseGUI.DoOnSynchError(Sender: TObject);
begin
  //LogError(SynchObj.UserMessage, SynchObj.APIMessage, SynchObj.CoreService.ResultData.S['CurrentTask']);
end;

procedure TERPEDIListBaseGUI.DoOnSynchProg(Sender: TERPEDIBase; var Continue: boolean; msg: string);
var
  s: string;
begin
  //pbProgress.Position := System.Round((SynchObj.CurrentSynchItemNo / SynchObj.TotalItemsToSynch) * 100);
  //lblProgress.Caption :=
  s := '';
  if (SynchObj.CurrentSynchItemNo > 0) or (SynchObj.TotalItemsToSynch > 0) then begin
    s :=
      'Processing Rec ' + IntToStr(SynchObj.CurrentSynchItemNo) + ' of ' + IntToStr(SynchObj.TotalItemsToSynch) +
      ' ' + SynchObj.CurrentSynchItemType;
    if SynchObj.CurrentSynchId > 0 then
      s := s + ' Id: ' + IntToStr(SynchObj.CurrentSynchId);
  end;
  if msg <> '' then begin
    if s <> '' then s := s + ' ';

    s := s + msg;
  end;
  if s <> '' then
    LoginList(s);
end;

procedure TERPEDIListBaseGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseLogToDialog;
end;

procedure TERPEDIListBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SynchObj := nil;
  CoreEDI := nil;
  pnlEDIAutocheckProgress.width := grpfilters.width;
  fsSynchCaption:='Synch Transactions'
end;

procedure TERPEDIListBaseGUI.FormDestroy(Sender: TObject);
begin
  CoreEDI.Free;
  SynchObj.Free;
  inherited;
end;

end.
