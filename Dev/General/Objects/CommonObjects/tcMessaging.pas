unit tcMessaging;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/04/06  1.00.01 DSP  Added functionality to display the network speed to
                        SendPresence.
}

{$I ERP.inc}

interface

uses
  Classes, SysUtils, Menus, AdvMenus, LibXmlParser, MiddleTier, MyAccess,ERPdbComponents, Controls,
  ExtCtrls, DateUtils;

const
  PresenceTimer_Interval = 20000;  { 20 sec }
  ExpectedResponsePeriod = 75; //33;

type
  TServicesClientTerminateWait = class(TComponent)
  private
    fWaiting: boolean;
    SecCount: integer;
    tmr: TTimer;
    pnlWarning: TPanel;
    procedure TmrOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTimer(const Sec: integer);
    procedure StopTimer;
    property Waiting: boolean read fWaiting;
  end;

type
  TServicesClientTerminate = class(TComponent)
  private
    SecCount: integer;
    tmr: TTimer;
    pnlWarning: TPanel;
    procedure TmrOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTimer(const SecUntilTerminate: integer);
    procedure StopTimer;
  end;

type
  TtcServicesClient = class
  private
    PopMsgHStr, PopMsgStr: string;
    userCount, userid: integer;
    dbname, pname, pip: string;
    MTClientPresent: TMTClient;
    XMLParser: TXMLParser;
    FFormClassName: string;
    function processClientTag: TMenuItem;
    procedure processAlertTag;
    procedure processTerminate;
    procedure processBatchUpdate;
    function processServerAnswer(const myanswerXml: string): boolean;
    procedure doAlertRemove(Sender: TObject);
    procedure doAlertMoveToToDo(Sender: TObject);
    {$IFDEF MESSAGING}
    procedure doUserPhoneCall(Sender: TObject);
    procedure doUserAskForChat(Sender: TObject);
    procedure doUserInquiry(Sender: TObject);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure SendPresence(var MsgHStr, MsgStr: string);
    function SetLoginStamp: boolean;
    function getLicence(var serverMID: string): string;
    function setLicence(const LicenceCode: string; var expires: TDateTime; var noClients: integer): boolean;
//    function QuerySlotAvailable(const MachineID, CompanyName: string; var licence, ServerMID, conflict, noClientSlots, ServicesVersion: string; var expires: TDateTime): boolean;
//    function LockLogonToDB(const Reason: string): boolean;
//    function UnLockLogonToDB: boolean;
    function StopMultisiteNag: boolean;
    function ResetMultisiteNag: boolean;
    function SendMultisiteUptoDateTest(var MsgHStr, MsgStr: string): boolean;
    property FormClassName: string read FFormClassName write FFormClassName;
  end;

function SecToTime(const Sec: integer): string;

implementation

uses FastFuncs,Graphics, Types, Dialogs, CommonDbLib,  
     ProgressDialog, CommCtrl, Forms, MAIN, TransactionsTable,
     AppEnvironment, CommonLib;

constructor TtcServicesClient.Create;
begin
  inherited; 
  FFormClassName := '';
  XMLParser := TXMLParser.Create;
  MTClientPresent := TMTClient.Create(nil);
  with MTClientPresent do begin
    DB         := CommonDbLib.GetSharedMyDacConnection.Database;
    DBUserName := CommonDbLib.GetSharedMyDacConnection.UserName;
    DBPassword := CommonDbLib.GetSharedMyDacConnection.Password;
    DBPort     := CommonDbLib.GetSharedMyDacConnection.Port;
    Host       := CommonDbLib.GetSharedMyDacConnection.Server;
  end;
end;

destructor TtcServicesClient.Destroy;
begin
  FreeAndNil(MTClientPresent);
  FreeAndNil(XMLParser);
  inherited;
end;

function TtcServicesClient.processClientTag: TMenuItem;

  procedure addSubMenu(const Caption: string; const Action: TNotifyEvent);
  var 
    smi: TMenuItem;
  begin
    smi := TMenuItem.Create(nil);
    smi.Caption := Caption;
    smi.OnClick := Action;
    Result.Add(smi);
  end;
begin
  Result := nil;
  with XMLParser do begin
    if CurAttr.Count > 2 then // active clients
    begin
      Inc(UserCount);
      userid := StrToIntDef(CurAttr.Value('userid'), 0);
      dbname := CurAttr.Value('dbname');
      if dbname = CommonDbLib.GetSharedMyDacConnection.Database then // only show dbname if not this one
        dbname := ''
      else dbname := ' (' + dbname + ')';

      pname := CurAttr.Value('peername');
      pip := CurAttr.Value('peerip');
      Result := TMenuItem.Create(nil);
      Result.Tag := StrToIntDef(CurAttr.Value('employeeid'), 0);
      Result.Caption := ' (' + FastFuncs.IntToStr(userid) + ')' + dbname + ' - ' + pname + '(' + pip + ') ';
      {$IFDEF MESSAGING}
      addSubMenu('Phone Call', doUserPhoneCall);
      addSubMenu('Ask for Chat', doUserAskForChat);
      addSubMenu('Inquiry', doUserInquiry);
      {$ENDIF}
    end;
  end;
end;

procedure TtcServicesClient.processTerminate;
var
  SecUntilTerminate: integer;
begin
  with XMLParser do begin
    PopMsgStr         := CurAttr.Value('msg');
    PopMsgHStr        := CurAttr.Value('hmsg');
    SecUntilTerminate := StrToIntDef(CurAttr.Value('terminatewaitsec'), 0);
  end;
  with TServicesClientTerminate.Create(nil) do StartTimer(SecUntilTerminate);
end;

procedure TtcServicesClient.processAlertTag;
var
  mi: TMenuItem;

  procedure addSubMenu(const Caption: string; const Action: TNotifyEvent);
  var 
    smi: TMenuItem;
  begin
    smi := TMenuItem.Create(nil);
    smi.Caption := Caption;
    smi.OnClick := Action;
    mI.Add(smi);
  end;
begin
  with XMLParser do begin
    if FastFuncs.SameText(CurAttr.Value('popup'), 'True') then begin
      PopMsgStr := CurAttr.Value('msg');
      PopMsgHStr := CurAttr.Value('hmsg');
    end else begin
      MainForm.ilAlerts.GetIcon(1, MainForm.imAlert.Picture.Icon);
      MainForm.imAlert.Hint := CurAttr.Value('msg');
      MainForm.imAlert.ShowHint := true;
      mI := TMenuItem.Create(nil);
      mI.Caption := CurAttr.Value('msg');
      mi.AutoCheck := true;
      mI.ImageIndex := 1;
      addSubMenu('Remove', doAlertRemove);
      addSubMenu('move to TODO', doAlertMoveToToDo);
      if FastFuncs.SameText(CurAttr.Value('flash'), 'True') then begin
        mi.ImageIndex := 2;
        MainForm.MailFlashTimer.Tag := 10;
        MainForm.MailFlashTimer.Enabled := true;
      end;
      MainForm.pmAlerts.Items.Add(mI);
    end;
  end;
end;

function TtcServicesClient.processServerAnswer(const myanswerXml: string): boolean;
var 
  i: integer;
begin
  Result := false;
  if FastFuncs.Trim(myanswerXML) = '' then Exit;
  for i := MainForm.pmPresentUsers.Items.Count - 1 downto 0 do MainForm.pmPresentUsers.Items[i].Free;
  MainForm.pmPresentUsers.Items.Clear;

  with XmlParser do begin
    XmlParser.SetBuffer(@myanswerXML[1]);
    UserCount := 0;
    StartScan;
    Try
      while Scan do begin
        if (CurPartType = ptStartTag) and FastFuncs.SameText(CurName, 'CLIENT') then
          MainForm.pmPresentusers.Items.Add(processClientTag)
        else if (CurPartType = ptStartTag) and FastFuncs.SameText(CurName, 'ALERT') then
          processAlertTag
        else if (CurPartType = ptStartTag) and FastFuncs.SameText(CurName, 'TERMINATEUSERS') then
          processTerminate
        else if (CurPartType = ptStartTag) and FastFuncs.SameText(CurName, 'BATCHUPDATE') then
          processBatchUpdate
      end;
    except
    end;
//    case UserCount of
//      0: MainForm.StatusBar.Panels[2].Text := '';
//      1: MainForm.StatusBar.Panels[2].Text := Format('    One User(%d)', [MainForm.NoClientSlots]);
//      else MainForm.StatusBar.Panels[2].Text := Format('    %d( %d) Logged In Users', [UserCount, MainForm.NoClientSlots]);
//    end;
  end;
  Result := true;
end;

procedure TtcServicesClient.SendPresence(var MsgHStr, MsgStr: string);
var
  requestXml, answerXml: string;
//  SendTime: TDateTime;
//  ResponsePeriod: integer;
begin
  PopMsgHStr := '';
  PopMsgStr := '';
  if Assigned(AppEnv.Employee) then with MTClientPresent do begin
      try
        MainForm.spTCPActive.Brush.Color := clWhite;
        MainForm.spTCPActive.Visible := true;
        MainForm.spTCPActive.Update;
        requestXml := Format('<ERPMsg>' + '  <PRESENT employeeid="%d" dbname="%s" pcname="%s"></PRESENT>' + '</ERPMsg>', [AppEnv.Employee.EmployeeID, CommonDbLib.GetSharedMyDacConnection.Database, GetPCName]);
//        SendTime := Now;
        answerXml := SendXml(requestXml);
//        ResponsePeriod := MilliSecondsBetween(Now, SendTime);
//        ResponsePeriod := Trunc(Ln(ResponsePeriod) * 12.5);
//
//        if ResponsePeriod > ExpectedResponsePeriod then begin
//          if ResponsePeriod > (100 + ExpectedResponsePeriod) then
//            MainForm.SocketSpeed := 0
//          else
//            MainForm.SocketSpeed := (100 + ExpectedResponsePeriod) - ResponsePeriod;
//        end
//        else
//          MainForm.SocketSpeed := 100;

        if not FastFuncs.SameText(answerXml, 'SendXml-Error: Port is 0') then begin
          if processServerAnswer(answerXml) then begin
            MainForm.spTCPActive.Brush.Color := clGreen;
            MainForm.spTCPActive.Update;
          end;
        end else begin
          MainForm.pnlPresent.Caption := '';
          MainForm.spTCPActive.Brush.Color := clRed;
          MainForm.spTCPActive.Update;
        end;
        MsgHStr := PopMsgHStr;
        MsgStr := PopMsgStr;
      except
        on E: Exception do begin
          MainForm.pnlPresent.Caption := '';
          MainForm.SocketSpeed := 0;
          MainForm.spTCPActive.Brush.Color := clRed;
          MainForm.spTCPActive.Update;
        end
      end;
    end;
end;


//function TtcServicesClient.QuerySlotAvailable(const MachineID, CompanyName: string; var licence, ServerMID, conflict, noClientSlots, ServicesVersion: string; var expires: TDateTime): boolean;
//{ Background:
//  Services maintains as many slots as licences have been issued.
//  Each slot is preset for a specific client machine.
//
//  Result will be positive only if this machine is registered in one slot
//  or it can be registered (automatically) into a vacant slot
//}
//var
//  requestXml, answerXml, expStr: string;
//begin
//  Result := false;
//  with MTClientPresent do begin
//    requestXml := '<ERPMsg><SLOTAVAILABLE machineid="' + MachineID + '" machinename="' + GetPCName + '" companyname="' + CompanyName + '" userid="' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID) + '" dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
//    answerXml  := SendXml(requestXml);
//
//    if FastFuncs.Trim(answerXML) = '' then Exit;
//
//    with XmlParser do begin
//      SetBuffer(@answerXML[1]);
//      StartScan;
//      while Scan do if (CurPartType = ptEmptyTag) and FastFuncs.SameText(CurName, 'SLOTAVAILABLE') then begin
//          licence := CurAttr.Value('licence');
//          expStr := CurAttr.Value('expires');
//          ServerMID := CurAttr.Value('serverid');
//          conflict := CurAttr.Value('conflict');
//          noClientSlots := CurAttr.Value('noclientslots');
//          ServicesVersion := CurAttr.Value('servicesversion');
//          Result := CurAttr.Value('permission') = 'Granted';
//          if FastFuncs.StrLength(expStr) = 10 then expires := EncodeDate(FastFuncs.StrToInt(Copy(expStr, 1, 4)), FastFuncs.StrToInt(Copy(expStr, 6, 2)), FastFuncs.StrToInt(Copy(expStr, 9, 2)));
//        end;
//    end;
//  end;
//end;


procedure TtcServicesClient.doAlertMoveToToDo(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('move to ToDo', mtInformation , [mbOK], 0);
end;

procedure TtcServicesClient.doAlertRemove(Sender: TObject);
begin
  MainForm.MailFlashTimer.Enabled := false;
  MainForm.pmAlerts.Items.Remove(TMenuItem(Sender).Parent);
  if MainForm.pmAlerts.Items.Count = 0 then MainForm.ilAlerts.GetIcon(0, MainForm.imAlert.Picture.Icon);  // make grey
end;
{$IFDEF MESSAGING}

procedure TtcServicesClient.doUserAskForChat(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('Chat? ', mtInformation , [mbOK], 0);
end;

procedure TtcServicesClient.doUserInquiry(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('Inquiry?', mtInformation , [mbOK], 0);
end;

procedure TtcServicesClient.doUserPhoneCall(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('PhoneCall', mtInformation , [mbOK], 0);
end;
{$ENDIF}

function TtcServicesClient.getLicence(var serverMID: string): string;
var
  requestXml, answerXml: string;
begin
  Result := '';
  with MTClientPresent do begin
    requestXml := '<ERPMsg><GETLICENCE/></ERPMsg>';
    answerXml  := SendXml(requestXml);

    if FastFuncs.Trim(answerXML) = '' then Exit;

    with XmlParser do begin
      SetBuffer(@answerXML[1]);
      StartScan;
      while Scan do if (CurPartType = ptEmptyTag) and FastFuncs.SameText(CurName, 'LICENCE') then begin
          Result := CurAttr.Value('code');
          serverMID := CurAttr.Value('servermid');
        end;
    end;
  end;
end;

function TtcServicesClient.setLicence(const LicenceCode: string; var expires: TDateTime; var noClients: integer): boolean;
var
  requestXml, answerXml, expStr: string;
begin
  Result := false;
  expires := 0;
  with MTClientPresent do begin
    requestXml := '<ERPMsg><SETLICENCE code="' + LicenceCode + '"/></ERPMsg>';
    answerXml  := SendXml(requestXml);

    if FastFuncs.Trim(answerXML) = '' then Exit;

    with XmlParser do begin
      SetBuffer(@answerXML[1]);
      StartScan;
      while Scan do if (CurPartType = ptEmptyTag) and FastFuncs.SameText(CurName, 'SETLICENCE') then if CurAttr.Value('result') = 'OK' then begin
            Result := true;
            expStr := CurAttr.Value('expires');
            if FastFuncs.StrLength(expStr) = 10 then expires := EncodeDate(FastFuncs.StrToInt(Copy(expStr, 1, 4)), FastFuncs.StrToInt(Copy(expStr, 6, 2)), FastFuncs.StrToInt(Copy(expStr, 9, 2)));                 
            noClients := StrToIntDef(CurAttr.Value('noclients'), 0);
          end;
    end;
  end;
end;

function TtcServicesClient.SetLoginStamp: boolean;
var
  requestXml, answerXml: string;
begin
  with MTClientPresent do begin
    requestXml := '<ERPMsg><LOGIN' + ' userid="' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID) + '" dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
    answerXml  := SendXml(requestXml);
    Result     := FastFuncs.Trim(answerXML) = 'OK';
  end;
end;

//function TtcServicesClient.LockLogonToDB(const Reason: string): boolean;
//var
//  requestXml, answerXml: string;
//begin
//  with MTClientPresent do begin
//    requestXml := '<ERPMsg><LOCKLOGIN' + ' userid="' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID) + '" username="' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName + '" dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '" reason="' + Reason + '"/></ERPMsg>';
//    answerXml  := SendXml(requestXml);
//    Result     := FastFuncs.Trim(answerXML) = 'OK';
//  end;
//end;

//function TtcServicesClient.UnLockLogonToDB: boolean;
//var
//  requestXml, answerXml: string;
//begin
//  with MTClientPresent do begin
//    requestXml := '<ERPMsg><UNLOCKLOGIN' + ' dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
//    answerXml  := SendXml(requestXml);
//    Result     := FastFuncs.Trim(answerXML) = 'OK';
//  end;
//end;

function TtcServicesClient.SendMultisiteUptoDateTest(var MsgHStr, MsgStr: string): boolean;
var
  requestXml, answerXml: string;
begin
  MsgHStr := '';
  MsgStr := '';
  {$IFNDEF DevMode}
  Result := false;
  {$ELSE}
  Result := true;
  Exit;
  {$ENDIF}
  with MTClientPresent do begin
    requestXml := '<ERPMsg><MULTISITECHECK' + ' dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
    try
      answerXml := SendXml(requestXml);
    except
    end;
    if FastFuncs.Trim(answerXml) = '' then Exit;
    with XmlParser do begin
      XmlParser.SetBuffer(@answerXml[1]);
      StartScan;
      while Scan do begin
        if (CurPartType = ptEmptyTag) and FastFuncs.SameText(CurName, 'MULTISITERESULT') then begin
          if FastFuncs.SameText(CurAttr.Value('result'), 'fail') then begin
            MsgStr := CurAttr.Value('msg');
            MsgHStr := CurAttr.Value('hmsg');
            Result := false;
          end else if FastFuncs.SameText(CurAttr.Value('result'), 'pass') then begin
            Result := true;
          end;
        end;
      end;
    end;
  end;
end;

function TtcServicesClient.ResetMultisiteNag: boolean;
var
  requestXml, answerXml: string;
begin
  with MTClientPresent do begin
    requestXml := '<ERPMsg><RESETMULTISITENAG' + ' dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
    answerXml  := SendXml(requestXml);
    Result     := FastFuncs.Trim(answerXML) = 'OK';
  end;
end;

function TtcServicesClient.StopMultisiteNag: boolean;
var
  requestXml, answerXml: string;
begin
  with MTClientPresent do begin
    requestXml := '<ERPMsg><STOPMULTISITENAG' + ' dbname="' + CommonDbLib.GetSharedMyDacConnection.Database + '"/></ERPMsg>';
    answerXml  := SendXml(requestXml);
    Result     := FastFuncs.Trim(answerXML) = 'OK';
  end;
end;


function SecToTime(const Sec: integer): string;
var
  tmpDateTime: TDateTime;
begin
  tmpDateTime := Sec / (24 * 3600);
  Result := Copy(FormatDateTime('hh:m:ss', tmpDateTime), 4, 5);
end;

{ TServicesClientTerminate }

constructor TServicesClientTerminate.Create(AOwner: TComponent);
var
  r: TRect;
begin
  inherited;
  pnlWarning := TPanel.Create(Self);
  pnlWarning.Alignment := taLeftJustify;
  pnlWarning.Font.Style := [fsBold];

  tmr := TTimer.Create(Self);
  tmr.Interval := 1000;
  tmr.OnTimer := TmrOnTimer;


  Mainform.StatusBar.Perform(SB_GETRECT, Mainform.StatusBar.Panels.Count - 1, integer(@r));
  with pnlWarning do begin
    Parent := Mainform.StatusBar;
    Top    := r.Top + 1;
    Left   := r.Left + 1;
    Width  := r.Right - r.Left - 2;
    Height := r.Bottom - r.Top - 2;
  end;
end;

destructor TServicesClientTerminate.Destroy;
begin
  FreeAndNil(pnlWarning);
  FreeAndNil(tmr);
  inherited;
end;

procedure TServicesClientTerminate.StartTimer(const SecUntilTerminate: integer);
begin
  SecCount := SecUntilTerminate;
  tmr.Enabled := true;
  pnlWarning.Visible := true;
end;

procedure TServicesClientTerminate.StopTimer;
begin
  tmr.Enabled := false;
end;

procedure TServicesClientTerminate.TmrOnTimer(Sender: TObject);
begin
  SecCount := SecCount - 1;
  if (pnlWarning.Color = clMaroon) then begin
    pnlWarning.Font.Color := clBlack;
    pnlWarning.Color      := clBtnFace;
  end else if (pnlWarning.Color = clBtnFace) then begin
    pnlWarning.Font.Color := clWhite;
    pnlWarning.Color      := clMaroon;
  end;
  pnlWarning.Caption := '  Terminate User in ' + SecToTime(SecCount) + ' Mins';
  pnlWarning.Update;
  if SecCount < 0 then begin
    StopTimer;
    MainForm.TerminateApp;
  end;
end;

{ TServicesClientTerminateWait }

constructor TServicesClientTerminateWait.Create(AOwner: TComponent);
var
  r: TRect;
begin
  inherited;
  fWaiting := false;
  pnlWarning := TPanel.Create(Self);
  pnlWarning.Alignment := taLeftJustify;
  pnlWarning.Font.Style := [fsBold];

  tmr := TTimer.Create(Self);
  tmr.Interval := 1000;
  tmr.OnTimer := TmrOnTimer;

  Mainform.StatusBar.Perform(SB_GETRECT, Mainform.StatusBar.Panels.Count - 1, integer(@r));
  with pnlWarning do begin
    Parent := Mainform.StatusBar;
    Top    := r.Top + 1;
    Left   := r.Left + 1;
    Width  := r.Right - r.Left - 2;
    Height := r.Bottom - r.Top - 2;
  end;
end;

destructor TServicesClientTerminateWait.Destroy;
begin
  FreeAndNil(pnlWarning);
  FreeAndNil(tmr);
  inherited;
end;

procedure TServicesClientTerminateWait.StartTimer(const Sec: integer);
begin
  fWaiting := true;
  SecCount := Sec;
  tmr.Enabled := true;
  pnlWarning.Visible := true;
end;

procedure TServicesClientTerminateWait.StopTimer;
begin
  fWaiting := false;
  tmr.Enabled := false;
end;

procedure TServicesClientTerminateWait.TmrOnTimer(Sender: TObject);
begin
  SecCount := SecCount - 1;
  if (pnlWarning.Color = clNavy) then begin
    pnlWarning.Font.Color := clBlack;
    pnlWarning.Color      := clBtnFace;
  end else if (pnlWarning.Color = clBtnFace) then begin
    pnlWarning.Font.Color := clWhite;
    pnlWarning.Color      := clNavy;
  end;
  pnlWarning.Caption := '  Wait For Exit of All Users in ' + SecToTime(SecCount) + ' Mins';
  pnlWarning.Update;
  if SecCount < 0 then begin
    StopTimer;
    fWaiting := false;
  end;
end;

procedure TtcServicesClient.processBatchUpdate;
var
  TransactionTableObj: TTransactionTableObj;
begin
  TransactionTableObj := TTransactionTableObj.Create;
  try
    if (Mainform.GetCurrentUserCount <= 1) AND (MainForm.MDIChildCount <=1) then TransactionTableObj.SetEmptyGlobalRef;
    TransactionTableObj.CleanRefreshTrnsTable(true, false, true);
  finally
    FreeAndNil(TransactionTableObj);
  end;
end;

end.

