unit EMHelper;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 02/08/05  1.00.XX DMS  Changed the order of information written to the log file
 10/08/05  1.00.XX DMS  Re-enabled option to show dialog
 10/08/05  1.00.XX DSP  Added message display for server connection loss.
 28/08/06  1.00.01 DSP  Added message display for printing errors.
 03/10/06  1.00.02 DSP  Added TUserActions object.

}

interface

{$I ERP.inc}


{Don't Add Uses Need To initialization First}
uses
  Windows, SysUtils, ExcMagic, Classes, IdMessage, IdSMTP, IdException, ExtCtrls, Forms, controls,ERPDbLookupCombo,Wwdbgrid,  WwDbiGrd  ;

type
  TExceptionAppInfoRec = record
    VaildData:Boolean;
    EmployeeLogonName: string;
    CompanyName: string;
    CompanyDetails: string;
    EmailSMTPHost: string;
    EmailSMTPPort: integer;
    EmailUseAuthentication: boolean;
    EmailAuthUserID: string;
    EmailAuthPassword: string;
    EmailCompanyAddress: string;
    WindowsVersion: string;
    MySqlServerVersion: string;
    FileVersion: string;
    ClientSlots: integer;
    PCName: string;
    PCNetworkName: string;
    TransactionEventsummary:string;
    DatabaseName:String;
  end;

//  TExceptionHelper = class(TObject)
//    procedure DoOnException(E: Exception; var Regs: PPushedRegisters; var AllowException: boolean); //virtual; abstract;
//  end;

  TDefaultExcFilter = class(TInterfacedObject, IExcMagicFilter)
    function IsIgnoredMessage(const Msg: string): boolean;
    function ShowException(ExceptionObject: TObject; Title: string; ExceptionMessage: string;
      CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer;
      CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo;
      Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
    procedure EmailLogFile;
  end;

  TIndyExcFilter = class(TInterfacedObject, IExcMagicFilter)
    function ShowException(ExceptionObject: TObject; Title: string; ExceptionMessage: string;
      CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer;
      CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo;
      Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
  end;

  TUserEventType = (uetMouse, uetKeyboard, uetNone);

  TUserActionBase = class(TObject)
  private

  Protected
    FEventList        : TStrings;
    ActiveFormName    : String;
    ActiveCtrl :TControl;
    ActiveControlName : String;
    ActiveControlClassName : String;
    ActivecontrolPropnvalue: String;
    ActivecontrolValue :String;
    ActivecontrolProp :String;
    procedure GetActiveNames;Overload;virtual;
    Function ReadActiveControlNamenValue:String;
    procedure ReadActiveControlValue(out ActivecontrolPropnvalue: String; out ActivecontrolValue :String;out ActivecontrolProp :String);
    Function  Activecontrol: Tcontrol;
    Function  Activeform:TForm;
    Function GridwhenComboinGrid(Combo :TERPDbLookupCombo):Tcontrol;
    Function ComboinGrid(Combo :TERPDbLookupCombo;Grid:TwwDBGrid):Boolean;Overload;
    Function ComboinGrid(FieldNAme:String;Grid:TwwDBGrid):String;Overload;
    function ComboinGrid4fieldname(comboname: String; Grid: TwwDBGrid): String;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function EventList :TStrings;
  end;

  TUserActions = class(TUserActionBase)
  Private
    PreviousFocusedForm: string;
    PreviousFocusedControl: string;
    PreviousEventName :String;
    procedure AddFocused(const TimeStamp: string);
  Public
    constructor Create;Override;
    procedure Add(const UserEventType: TUserEventType; const wParam: Longint; const lParam: Longint; extraInfo:String = '');
  end;


const
  CRLF = #13#10;
  MAX_CALLSTACK_LINES = 250;
  MAX_USER_EVENT_LINES = 250;

var
  IsFirstException: boolean;
  ExceptionLogFile: string;
  DefaultExcFilter: TDefaultExcFilter;

  IndyExcFilter: TIndyExcFilter;
  fbApplicationRestart: boolean = false;
  UserActions: TUserActions;
  ExceptionAppInfo: TExceptionAppInfoRec;


function GetExceptionCustomInfo: string;
function FormUserAccess :String;
procedure DisableExceptionalMagic;
procedure EnableExceptionalMagic;


implementation


{Don't Add Uses Need To initialization First}
uses
  Dialogs,
  Messages, StrUtils,StdCtrls,CommonLib, MailServerConst
  {$ifdef COMPILER_22_UP}
  ,IdAttachmentFile
  {$endif}, tcDataUtils , TypInfo, wwdblook,
  UserMessageConst, WorkflowObj, FilesLib;

const
  cDefaultLogFile     = 'C:\ExcMagic.log';
  FORM_HEADING = 'Active Forms:';
  ERROR_TYPE = 'Error Type: ';
  FOCUSED_FORM = 'Focused Form: ';
  FOCUSED_CONTROL = 'Focused Control: ';

{$WARNINGS OFF}
function GetExcLogFileName: string;
var
  ExeName: string;
begin
  ExeName := Application.ExeName;
  Result :=
    IncludeTrailingBackslash(ExtractFilePath(ExeName)) + ChangeFileExt(ExtractFileName(ExeName),
    '') + '_Log_' + FormatDateTime('YYYYMMDD_HHNNSS', SysUtils.Now) + '.txt';
end;
{$WARNINGS ON}
function FormUserAccess :String;
var
  comp:TComponent;
  PropInfo: PPropInfo;
begin
  comp:= nil;
  if Assigned(Screen.ActiveForm) then
    comp := findExistingcomponent(Screen.ActiveForm.classname);
  if assigned(comp) then begin
    REsult := Screen.ActiveForm.Name+ ':' +Screen.ActiveForm.Caption;
    PropInfo:= GetPropInfo(comp, 'AccessLevel');
    if Assigned(PropInfo) then
      REsult := REsult + crlf+'Current Access level : ' + inttostr(GetOrdProp(comp,PropInfo));
    Result := REsult + crlf + 'Access level in DB : ' + inttostr(GetEmployeeAccessLevel(Screen.ActiveForm.classname , ExceptionAppInfo.EmployeeLogonName));
  end;
end;
function GetExceptionCustomInfo: string;
var
  UserName, CompanyName, CompanyDetails: string;
  EmailHost, EmailAddress: string;
  Index: Integer;
  FormList: string;
  //ActiveFormName, ActiveControlName , ActivecontrolPropnvalue: string;
begin
  // get information about the company/product/user

  UserName := 'UNKNOWN';
  if ExceptionAppInfo.VaildData then UserName := ExceptionAppInfo.EmployeeLogonName;

  CompanyName := 'UNKNOWN';
  try
    CompanyName := ExceptionAppInfo.CompanyName;
  except
  end;

  CompanyDetails := 'UNKNOWN';
  try
    CompanyDetails := ExceptionAppInfo.CompanyDetails;
  except
  end;

  EmailHost := 'UNKNOWN';
  EmailAddress := 'UNKNOWN';
  if ExceptionAppInfo.VaildData then begin
    EmailHost    := ExceptionAppInfo.EmailSMTPHost;
    EmailAddress := ExceptionAppInfo.EmailCompanyAddress;
  end;

  FormList := '';

  for Index := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[Index].Name <> '' then
      FormList := FormList + Screen.Forms[Index].Name + CRLF;
  end;

  UserActions.GetActiveNames;

  Result :=
    'Windows Version: ' + ExceptionAppInfo.WindowsVersion + CRLF + 'MySQL Version: ' + ExceptionAppInfo.MySqlServerVersion + CRLF +
    'ERP Version: ' + ExceptionAppInfo.FileVersion +
    CRLF + 'Company: ' + CompanyName + CRLF + CompanyDetails + CRLF + 'Licenced Users : ' + SysUtils.IntToStr(ExceptionAppInfo.ClientSlots) +
    CRLF + CRLF + 'User: ' + UserName +
    CRLF + 'PC Name: ' + SysUtils.Trim(ExceptionAppInfo.PCName) + '(' + SysUtils.Trim(ExceptionAppInfo.PCNetworkName) + ')' + CRLF + 'Send Details: ' +
    CRLF + 'Database : '+ ExceptionAppInfo.DatabaseName +
    CRLF + '  Host  - ' + EmailHost + CRLF + '  Email - ' + EmailAddress + CRLF + CRLF +
    ERROR_TYPE + 'Non-Fatal' + CRLF +
    FORM_HEADING + CRLF + trim(FormList) + CRLF + FOCUSED_FORM + UserActions.ActiveFormName + CRLF +
    FOCUSED_CONTROL + UserActions.ActiveControlName;
end;

procedure DisableExceptionalMagic;
begin
  ExcMagic.ExceptionHook.Enabled := false;
  ExcMagic.ExceptionHook.LogEnabled := false;
end;

procedure EnableExceptionalMagic;
begin
  ExcMagic.ExceptionHook.Enabled := true;
  ExcMagic.ExceptionHook.LogEnabled := true;
end;

{ TDefaultExcFilter }

procedure TDefaultExcFilter.EmailLogFile;
var
  exMessage: TIdMessage;
  exSMTP: TIdSMTP;
  {$IFNDEF KEEP_EM_LOGS}
  KeepLog: boolean;
  {$ENDIF}
begin
  {$IFNDEF KEEP_EM_LOGS}
  KeepLog := false;
  {$ENDIF}
  exMessage := TIdMessage.Create(nil);
  exSMTP := TIdSMTP.Create(nil);
  try
    try

      exSMTP.Host := SMTPHost;
      exSMTP.Port := SMTP3Port;
      {$ifdef COMPILER_22_UP}
      exSMTP.AuthType := satDefault;
      {$else}
      exSMTP.AuthenticationType := atLogin;
      {$endif}
      exSMTP.Username := SMTPUsername;
      exSMTP.Password := SMTPPassword;
      exMessage.From.Text := EMAIL_ERROR_RECEPIENT;
      exMessage.Recipients.EMailAddresses := EMAIL_ERROR_RECEPIENT;
      exMessage.Subject := ExtractFileName(Application.ExeName) + ': Error v' + ExceptionAppInfo.FileVersion;
      exMessage.Body.Add(ExceptionAppInfo.CompanyName + ': ' + ExtractFileName(Application.ExeName) +
                       ' has encounted a minor error to report.');
      exMessage.Body.Add('Please find attached log file -' + ExceptionLogFile + ' for details');

      if FileExists(ExceptionLogFile) then Begin
        {$ifdef COMPILER_22_UP}
        TIdAttachmentFile.Create(exMessage.MessageParts, ExceptionLogFile);
        {$else}
        TIdAttachment.Create(exMessage.MessageParts, ExceptionLogFile);
        {$endif}
      end;

      //Forces All Exception Emails to flathead smtp server - therefore only needs internet
      Try
        {$ifdef COMPILER_22_UP}
        exSMTP.ConnectTimeout:= 5000;
        exSMTP.Connect;
        {$else}
        exSMTP.Connect(5000);
        {$endif}
      except
      end;

      if exSMTP.Connected then
        exSMTP.Send(exMessage)
      else Begin
        exSMTP.Host := ExceptionAppInfo.EmailSMTPHost;
        exSMTP.Port := ExceptionAppInfo.EmailSMTPPort;
        If ExceptionAppInfo.EmailUseAuthentication then Begin
          {$ifdef COMPILER_22_UP}
          exSMTP.AuthType:= satDefault;
          {$else}
          exSMTP.AuthenticationType := atLogin;
          {$endif}
        end else Begin
          {$ifdef COMPILER_22_UP}
          exSMTP.AuthType:= satNone;
          {$else}
          exSMTP.AuthenticationType := atNone;
          {$endif}
        end;
        exSMTP.Username := ExceptionAppInfo.EmailAuthUserID;
        exSMTP.Password := ExceptionAppInfo.EmailAuthPassword;
        {$ifdef COMPILER_22_UP}
        exSMTP.ConnectTimeout:= 5000;
        exSMTP.Connect;
        {$else}
        exSMTP.Connect(5000);
        {$endif}

        if exSMTP.Connected then
          exSMTP.Send(exMessage);
      end;
    except
      Commonlib.MessageDlgXP_Vista('Information could not be emailed this time. The log file will be kept.',
        mtInformation, [mbOK], 0);
      {$IFNDEF KEEP_EM_LOGS}
      KeepLog := true;
      {$ENDIF}
    end;
  finally
    FreeAndNil(exMessage);
    FreeAndNil(exSMTP);
    {$IFNDEF KEEP_EM_LOGS}
    if not KeepLog then SysUtils.DeleteFile(ExceptionLogFile);
    {$ENDIF}
    ExceptionLogFile := '';
    ExcMagic.ExceptionHook.LogFile := cDefaultLogFile;
  end;
end;

function TDefaultExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo;
  Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
const
  DEFAULT_EXCEPTION_MSG_BRIEF: PChar =
    'Exception ''%s'' in module %s at %p'#13#10'%s';
  DEFAULT_EXCEPTION_MSG_FULL: PChar  =
    'Exception ''%s'' in module %s at %p'#13#10 +
    '%s'#13#10#13#10 +
    'Module: %s, Source: %s, Line %s'#13#10 +
    'Procedure: %s';
  UNKNOWN: string = 'UNKNOWN';
begin
  CustomInfo.Text := GetExceptionCustomInfo;

  with MessageInfo do if excDlgLocation in ExceptionHook.Options then
      StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_FULL,
        [ExceptionObject.ClassName,
        miModuleName,
        miModuleAddress,
        miMessage,
        ExtractFileName(miSrcModule),
        ExtractFileName(miSrcFile),
        miSrcLine,
        miSrcProc])
  else StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_BRIEF,
      [ExceptionObject.ClassName,
      miModuleName,
      miModuleAddress,
      miMessage]);

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.IsIgnoredMessage(const Msg: string): boolean;
begin
  Result := (Pos('is not a valid floating point value for field', Msg) > 0) or
            (Pos('duplicate entry', LowerCase(Msg)) > 0) or
            (Pos(LowerCase('EDBEditError'), LowerCase(Msg)) > 0);
end;

function TDefaultExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer;
  CallStack, Registers, CustomInfo: TStrings): integer;
const
  CRLF: word = $0A0D;
resourcestring
  HDRLINE    = '---------------------------';
  ADDITIONAL_TITLE = 'Additional info:'#13#10;
  USER_ACTIONS = 'User Actions:'#13#10;
  WORKFLOW_STATUS = 'WorkFlow Status:'#13#10;

var
  S, Msg: string;
  Stream: TFileStream;
  writer: TStreamWriter;

begin
  Msg := string(Buffer);
  if IsIgnoredMessage(Msg) then begin
    Result := EXC_FILTER_STOP;
    Exit;
  end;

  if ExceptionHook.LogFile <> '' then begin
    if SameText(ExceptionHook.LogFile, cDefaultLogFile) then begin
      ExceptionLogFile := GetExcLogFileName;
      ExceptionHook.LogFile := ExceptionLogFile;
    end;

    // get our custom exception info here
    CustomInfo.Text := GetExceptionCustomInfo;

    // continue with logging
    stream:= TFileStream.Create(ExceptionHook.LogFile, fmCreate);
    writer:= TStreamWriter.Create(stream);
    try
      // write custom info
      if char_length(CustomInfo.Text) > 0 then begin
        writer.Write(ADDITIONAL_TITLE);
        writer.Write(CustomInfo.Text);
        writer.WriteLine;
      end;

      S := HDRLINE + FormatDateTime('dd/mm/yyyy hh:nn:ss',Now) + HDRLINE + #13#10;
      writer.Write(s);
      writer.WriteLine;
      writer.WriteLine;
      writer.Write('Active Tables ' +  #13#10 +'================================='+ #13#10+ActiveTables);
      writer.WriteLine;
      writer.WriteLine;
      writer.Write('Active Forms ' +  #13#10 +'================================='+ #13#10+Activeforms);
      writer.WriteLine;
      writer.WriteLine;
      writer.Write(FormUserAccess);
      writer.WriteLine;
      writer.WriteLine;
      if ExceptionAppInfo.TransactionEventsummary <> '' then begin
        s:= ExceptionAppInfo.TransactionEventsummary;
        writer.Write(s);
        writer.WriteLine;
      end;

      {S := HDRLINE + LocalTimeStr + HDRLINE + #13#10;}
      writer.WriteLine;
      writer.Write(Msg);
      writer.WriteLine;
      // write call stack
      writer.WriteLine;
      writer.Write(CallStack.Text);
      writer.WriteLine;
      writer.WriteLine;

      { add list of user actions to body of message }
      if char_length(UserActions.FEventList.Text) > 0 then begin
        writer.Write(USER_ACTIONS);
        writer.Write(UserActions.FEventList.Text);
        writer.WriteLine;
      end;

      writer.Write(WORKFLOW_STATUS);
           (*if WorkflowStatus  = wfsNone       then writer.Write('None')
      else *)if IsWorkFlowRecoding    then writer.Write('Playing')
      else if IsWorkFlowPlaying  then writer.Write('recording')
      else writer.Write('None');
      writer.WriteLine;


    finally
      writer.Close;
      writer.Free;
      stream.Free;
    end;
  end;

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: string;
  CallStack, Registers, CustomInfo: TStrings): integer;
var
  AllowException: boolean;
  Msg, ExtraMsg: string;
  ServerConnectionLost: boolean;
  x: integer;
  sl: TStringList;

  procedure KillProcess(hWindowHandle: HWND);
  var
    hprocessID: integer;
    processHandle: THandle;
    DWResult: DWORD;
  begin
    SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0, SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
    if isWindow(hWindowHandle) then begin
      GetWindowThreadProcessID(hWindowHandle, @hprocessID);
      if hprocessID <> 0 then begin
        processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, false, hprocessID);
        if processHandle <> 0 then begin
          TerminateProcess(processHandle, 0);
          CloseHandle(ProcessHandle);
        end;
      end;
    end;
  end;  

begin

(*  {ignore exceptions from the workflow}
  if Screen.ActiveForm.ClassnameIs('TfmWorkflowPlay') or Screen.ActiveForm.ClassnameIs('TfmWorkflowPlayPointer')  or Screen.ActiveForm.ClassnameIs('TfmWorkflowhint') then begin
    Exit;
  end;*)

  if IsFirstException then begin
    Result := EXC_FILTER_STOP;
    Exit;
  end;

  IsFirstException := true;
  try

    AllowException := false;

    if Pos('is not a valid floating point value for field', ExceptionMessage) > 0 then begin
      Commonlib.MessageDlgXP_Vista('This Entry Is Not A Vaild Number !', mtWarning, [mbOK], 0);
    end else if (Pos('duplicate entry', SysUtils.LowerCase(ExceptionMessage)) > 0) then begin
      Commonlib.MessageDlgXP_Vista(Db_Duplicate_Entry, mtWarning, [mbOK], 0);
    end else if SysUtils.SameText(ExceptionObject.ClassName, 'EFCreateError') then begin
      Commonlib.MessageDlgXP_Vista(ExceptionMessage, mtWarning, [mbOK], 0);
    end else if Pos('Due to errors, the report', ExceptionMessage) > 0 then begin
      Commonlib.MessageDlgXP_Vista(ExceptionMessage, mtWarning, [mbOK], 0);
    end else if Pos('Use escape key to abandon changes', ExceptionMessage) > 0 then begin
      Commonlib.MessageDlgXP_Vista('Invalid input value.  Use escape key to abandon changes.', mtWarning, [mbOK], 0);
    end else begin
      AllowException := true;

      ExtraMsg := '';

      ServerConnectionLost := AnsiContainsText(ExceptionMessage, 'Can''t connect to MySQL server on') or
        AnsiContainsText(ExceptionMessage, 'Lost connection to MySQL server');
      fbApplicationRestart := AnsiContainsText(ExceptionObject.ClassName, 'EAccessViolation') or ServerConnectionLost;

      if fbApplicationRestart then ExtraMsg := CRLF + CRLF + 'Application will need to be restarted';

      // Display the end user message
      if ServerConnectionLost then begin
        Commonlib.MessageDlgXP_Vista(ExtractFileName(Application.ExeName) +
          ' has lost connection with the MySQL server.' + CRLF +
          'Please ensure the server is running and any cables required are connected.' +
          ExtraMsg, mtWarning, [mbOK], 0);
      end else begin
        Msg:= '';
        if SysUtils.SameText(ExceptionObject.ClassName, 'EMyError') and
          (Pos('Errcode: 28', ExceptionMessage) > 0) then begin
          fbApplicationRestart:= true;
          Msg:= 'This error may have been caused by your MySQL Server running low on disk space.';
        end
        else if SysUtils.SameText(ExceptionObject.ClassName, 'EMyError') and
          (Pos('Errcode: 17', ExceptionMessage) > 0) then begin
          fbApplicationRestart:= true;
          Msg:= 'ERP is unable to replace a tempory file on your server as ' +
          'another program has controll of it, i.e. like a virus scanner program.';
        end
        else if SysUtils.SameText(ExceptionObject.ClassName, 'EMyError') and
          (Pos('Errcode: 13', ExceptionMessage) > 0) then begin
          fbApplicationRestart:= true;
          Msg:= 'ERP is unable to access a file on your server, ' +
          'either ERP was not installed with full Windows Administrator Rights ' +
          'on the server or another program such as a virus scanner is preventing access.';
        end else if SysUtils.SameText(ExceptionObject.ClassName, 'EMyError') and (Pos('Lock wait timeout',ExceptionMessage) > 0) and devmode  then begin
          fbApplicationRestart:= False;
          Msg:= 'ERP has Locked Some of the Table/Date, ' +
          'Please check for the 64 Bit Version compatability.';
        end else if SysUtils.SameText(ExceptionObject.ClassName, 'EDatabaseError') and (Pos('Field ''Received Date'' cannot be modified',ExceptionMessage) > 0) then begin
          fbApplicationRestart:= False;
          if not EmployeeHasAccess('FnCanChangeReceiveDate') then Msg:= 'You Do Not Have Enough Access to Change the Received Date'
          else Msg:= ExceptionMessage;
        end else begin
          Msg:= ExtractFileName(Application.ExeName) +
            ' has encounted a minor error that should be reported.';
        end;
        Msg := MSg +CRLF + CRLF + 'ERP Version : ' + getUserVersion;
        if Commonlib.MessageDlgXP_Vista(Msg + CRLF + CRLF +
          'A copy of the log file: ' +
          ExceptionLogFile + ' will be emailed' + ExtraMsg, mtWarning, [mbOK], 0,nil, '','',false, nil,'Open File'  ) = 100 then
          Fileslib.Openfile(ExceptionLogFile, 0, 'Erp Exception');

      end;

      if fbApplicationRestart then begin
        sl:= TStringList.Create;
        try
          sl.LoadFromFile(ExceptionLogFile);
          x:= sl.IndexOf(ERROR_TYPE + 'Non-Fatal');
          if x >= 0 then
            sl[x]:= ERROR_TYPE + 'Fatal';

          sl.SaveToFile(ExceptionLogFile);
        finally
          sl.Free;
        end;
      end;

      if not ServerConnectionLost then EmailLogFile;

      if fbApplicationRestart then begin
        Result := EXC_FILTER_STOP;
        if Result <> 0 then;
        PostMessage(Application.Handle, WM_QUIT, 0, 0);
        KillProcess(Application.Handle);
      end;
    end;

    if AllowException then
      Result := EXC_FILTER_CONTINUE
    else
      Result := EXC_FILTER_STOP;
  finally
    IsFirstException := false;
  end;
end;

{ TIndyExcFilter }

function TIndyExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo;
  Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
begin
  Result := EXC_FILTER_STOP;
end;

function TIndyExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer;
  CallStack, Registers, CustomInfo: TStrings): integer;
begin
  Result := EXC_FILTER_STOP;
end;

function TIndyExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: string;
  CallStack, Registers, CustomInfo: TStrings): integer;
begin
  Result := EXC_FILTER_STOP;
end;

{ TUserActionBase }


Function TUserActionBase.ReadActiveControlNamenValue:String;
begin
    result := '';
    if activecontrol = nil then exit;
    with activecontrol do begin
      //Result := Name;
      Result := ControlParent(activecontrol);
      ReadActiveControlValue(ActivecontrolPropnvalue,ActivecontrolValue,ActivecontrolProp);
      Result:= Result+ActivecontrolPropnvalue;
    end ;
end;

function TUserActionBase.Activecontrol: Tcontrol;
begin
  REsult := nil;
  if Assigned(Screen.ActiveForm) and Assigned(Screen.ActiveForm.ActiveControl) then
    result := Screen.ActiveForm.ActiveControl;
end;
function TUserActionBase.Activeform: TForm;
begin
  REsult := nil;
  if Assigned(Screen.ActiveForm)  then
    result := Screen.ActiveForm;
end;
function TUserActionBase.GridwhenComboinGrid(Combo :TERPDbLookupCombo): Tcontrol;
var
  ctr:Integer;
begin
  result := Combo;
  if not(Assigned(Combo.Owner)) then exit;
  for ctr := 0 to Combo.owner.ComponentCount -1 do begin
    if Combo.owner.Components[ctr] is twwdbGrid then begin
      if ComboinGrid(Combo ,twwDBGrid(Combo.owner.Components[ctr])) then begin
        result := Tcontrol(Combo.owner.Components[ctr]);
        Exit;
      end;
    end;
  end;
end;
Function TUserActionBase.ComboinGrid(FieldNAme:String;Grid:TwwDBGrid):String;
var
  ctr:Integer;
  st:TStringlist;
begin
  REsult:= '';
  if not(Assigned(Grid.ControlType)) or (Grid.ControlType.Count =0) then exit;
  st:= tStringlist.Create;
  try
    for ctr := 0 to Grid.ControlType.Count-1 do begin
      st.Clear;
      StrtoStringlist(Grid.ControlType[ctr] , ';' , st);
      if st.Count >= 3 then begin
        if sametext(st[1] , 'CustomEdit') then
          if sametext(st[0] , FieldNAme) then begin
            result := st[2];
            Exit;
          end;
      end;
    end;
  finally
    FreeandNil(st);
  end;

end;
Function TUserActionBase.ComboinGrid4fieldname(comboname:String;Grid:TwwDBGrid):String;
var
  ctr:Integer;
  st:TStringlist;
begin
  REsult:= '';
  if not(Assigned(Grid.ControlType)) or (Grid.ControlType.Count =0) then exit;
  st:= tStringlist.Create;
  try
    for ctr := 0 to Grid.ControlType.Count-1 do begin
      st.Clear;
      StrtoStringlist(Grid.ControlType[ctr] , ';' , st);
      if st.Count >= 3 then begin
        if sametext(st[1] , 'CustomEdit') then
          if sametext(st[2] , comboname) then begin
            result := st[0];
            Exit;
          end;
      end;
    end;
  finally
    FreeandNil(st);
  end;

end;
function TUserActionBase.ComboinGrid(Combo :TERPDbLookupCombo; Grid: TwwDBGrid): Boolean;
var
  ctr:Integer;
  st:TStringlist;
begin
  REsult:= False;
  if not(Assigned(Grid.ControlType)) or (Grid.ControlType.Count =0) then exit;
  st:= tStringlist.Create;
  try
    for ctr := 0 to Grid.ControlType.Count-1 do begin
      st.Clear;
      StrtoStringlist(Grid.ControlType[ctr] , ';' , st);
      if st.Count >= 3 then begin
        if sametext(st[1] , 'CustomEdit') then
          if sametext(st[2] , Combo.Name) then begin
            result := True;
            Exit;
          end;
      end;
    end;
  finally
    FreeandNil(st);
  end;

end;

Procedure TUserActionBase.ReadActiveControlValue(out ActivecontrolPropnvalue: String; out ActivecontrolValue :String;out ActivecontrolProp :String);
var
  PropInfo: PPropInfo;
  Comp :TWinControl;
begin
  ActivecontrolPropnvalue:= '';
  if Assigned(Screen.ActiveForm) and Assigned(Screen.ActiveForm.ActiveControl) then begin
    Comp :=Screen.ActiveForm.ActiveControl;

    if not(assigned(Comp)) then Exit;

    if comp is TwwDBLookupCombo then begin
      ActivecontrolPropnvalue := '.Text = ' +Quotedstr(TwwDBLookupCombo(comp).text);
      ActivecontrolValue :=TwwDBLookupCombo(comp).text;
      ActivecontrolProp := 'Text';
      Exit;
    end;

    PropInfo:= GetPropInfo(Comp, 'text');
    if Assigned(PropInfo) then begin
      ActivecontrolPropnvalue := '.Text = ' +Quotedstr(GetStrProp(comp,PropInfo));
      ActivecontrolValue :=GetStrProp(comp,PropInfo);
      ActivecontrolProp := 'Text';
      Exit;
    end;
    PropInfo:= GetPropInfo(Comp, 'Caption');
    if Assigned(PropInfo) then begin
      ActivecontrolPropnvalue := '.Caption = ' +Quotedstr(GetStrProp(comp,PropInfo));
      ActivecontrolValue :=GetStrProp(comp,PropInfo);
      ActivecontrolProp := 'Caption';
      Exit;
    end;
    PropInfo:= GetPropInfo(Comp, 'Value');
    if Assigned(PropInfo) then begin
      ActivecontrolPropnvalue := '.Value = ' +Quotedstr(GetStrProp(comp,PropInfo));
      ActivecontrolValue :=GetStrProp(comp,PropInfo);
      ActivecontrolProp := 'Value';
      Exit;
    end;

  end;
end;

procedure TUserActionBase.GetActiveNames;
begin
  if Assigned(Screen.ActiveForm) then begin
    ActiveFormName := Screen.ActiveForm.Name;
    if Assigned(Screen.ActiveForm.ActiveControl) then  begin
      ActiveControlName := Screen.ActiveForm.ActiveControl.Name;
      ActiveCtrl  :=Screen.ActiveForm.ActiveControl;
      ActiveControlClassName := Screen.ActiveForm.ActiveControl.ClassName;
      if ActiveControlName = '' then ActiveControlName :=Screen.ActiveForm.ActiveControl.Classname;
      ReadActiveControlValue(ActivecontrolPropnvalue,ActivecontrolValue,ActivecontrolProp);
    end else begin
      ActiveControlName := 'None';
      ActiveCtrl := nil;
      ActiveControlClassName := 'None';
    end;
  end else begin
    ActiveFormName := 'None';
    ActiveControlName := 'None';
    ActiveCtrl := nil;
    ActiveControlClassName := 'None';
  end;
end;



constructor TUserActionBase.Create;
begin
  Inherited;
  FEventList := TStringList.Create;
end;

destructor TUserActionBase.Destroy;
begin
  FreeAndNil(FEventList);
  inherited;
end;

function TUserActionBase.EventList: TStrings;
begin
  REsult := FEventList;
end;


constructor TUserActions.Create;
begin
  inherited;
  PreviousFocusedForm := '';
  PreviousFocusedControl := '';
  PreviousFocusedForm:= '';
  PreviousFocusedControl:= '';
  PreviousEventName := '';
  ExceptionAppInfo.VaildData := False;
  ExceptionAppInfo.EmployeeLogonName := '';
  ExceptionAppInfo.CompanyName := '';
  ExceptionAppInfo.CompanyDetails := '';
  ExceptionAppInfo.EmailSMTPHost := '';
  ExceptionAppInfo.EmailSMTPPort := 0;
  ExceptionAppInfo.EmailUseAuthentication := False;
  ExceptionAppInfo.EmailAuthUserID := '';
  ExceptionAppInfo.EmailAuthPassword := '';
  ExceptionAppInfo.EmailCompanyAddress := '';
  ExceptionAppInfo.WindowsVersion := '';
  ExceptionAppInfo.MySqlServerVersion := '';
  ExceptionAppInfo.FileVersion := '';
  ExceptionAppInfo.ClientSlots := 0;
  ExceptionAppInfo.PCName := '';
  ExceptionAppInfo.PCNetworkName := '';
end;
procedure TUserActions.AddFocused(const TimeStamp: string);
begin
  GetActiveNames;
  if not SysUtils.SameText(ActiveFormName, PreviousFocusedForm) and (trim(PreviousFocusedForm)<> '') then begin
    PreviousFocusedForm :=ActiveFormName;
    FEventList.Add(TimeStamp + 'Focused Form: ' + PreviousFocusedForm);
  end;

  if not SysUtils.SameText(ActiveControlName, PreviousFocusedControl) then begin
    PreviousFocusedControl := ActiveControlName +ActivecontrolPropnvalue;
    //FEventList.Add(TimeStamp + 'Focused Control: ' + PreviousFocusedControl);
    FEventList.Add(TimeStamp + 'Focused Control: ' + controlParent(ActiveCtrl));

  end;
end;
procedure TUserActions.Add(const UserEventType: TUserEventType; const wParam: Longint; const lParam: Longint; extraInfo:String = '');
var
  NewEntry: string;
  CtrlDown: Boolean;
  ShiftDown: Boolean;
  AltDown: Boolean;
  KeyDown: Boolean;
  CapsLockOn: Boolean;
  NumLockOn: Boolean;
//  CharBuf: array[0..1] of Char;
//  KeyboardState: TKeyboardState;
begin
  NewEntry := FormatDateTime('hh:mm:ss:zzz - ', Now);

  case UserEventType of
    uetMouse:
    begin
      case wParam of
        WM_LBUTTONDOWN:
        begin
          AddFocused(NewEntry);
          NewEntry := NewEntry + 'Left mouse button down';
          FEventList.Add(NewEntry+' : ' + ReadActiveControlNamenValue);
        end;

        WM_LBUTTONUP:
        begin
          AddFocused(NewEntry);
          NewEntry := NewEntry + 'Left mouse button up';
          FEventList.Add(NewEntry+' : ' + ReadActiveControlNamenValue);
        end;

        WM_RBUTTONDOWN:
        begin
          AddFocused(NewEntry);
          NewEntry := NewEntry + 'Right mouse button down';
          FEventList.Add(NewEntry+' : ' + ReadActiveControlNamenValue);
        end;

        WM_RBUTTONUP:
        begin
          AddFocused(NewEntry);
          NewEntry := NewEntry + 'Right mouse button up';
          FEventList.Add(NewEntry+' : ' + ReadActiveControlNamenValue);
        end;
      end;
    end;

    uetKeyboard:
    begin
      if not (wParam in [VK_CONTROL, VK_SHIFT, VK_MENU, VK_CAPITAL, VK_NUMLOCK]) then begin
        CtrlDown := ((GetKeyState(VK_CONTROL) and $80) <> 0);
        ShiftDown := ((GetKeyState(VK_SHIFT) and $80) <> 0);
        AltDown := ((GetKeyState(VK_MENU) and $80) <> 0);
        CapsLockOn := ((GetKeyState(VK_CAPITAL) and $01) <> 0);
        NumLockOn := ((GetKeyState(VK_NUMLOCK) and $01) <> 0);
        KeyDown := ((lParam and $80000000) = 0);

        AddFocused(NewEntry);

        if CapsLockOn then
          NewEntry := NewEntry + '[Caps Lock] ';

        if NumLockOn then
          NewEntry := NewEntry + '[Num Lock] ';

        if CtrlDown then
          NewEntry := NewEntry + '[Ctrl] ';

        if ShiftDown then
          NewEntry := NewEntry + '[Shift] ';

        if AltDown then
          NewEntry := NewEntry + '[Alt] ';

        case wParam of
          VK_BACK:
          begin
            NewEntry := NewEntry + 'Backspace ';
          end;

          VK_TAB:
          begin
            NewEntry := NewEntry + 'Tab ';
          end;

          VK_ESCAPE:
          begin
            NewEntry := NewEntry + 'Esc ';
          end;

          VK_RETURN:
          begin
            NewEntry := NewEntry + 'Enter ';
          end;

          VK_SPACE:
          begin
            NewEntry := NewEntry + 'Space ';
          end;

          VK_PRIOR:
          begin
            NewEntry := NewEntry + 'Page Up ';
          end;

          VK_NEXT:
          begin
            NewEntry := NewEntry + 'Page Down ';
          end;

          VK_END:
          begin
            NewEntry := NewEntry + 'End ';
          end;

          VK_HOME:
          begin
            NewEntry := NewEntry + 'Home ';
          end;

          VK_LEFT:
          begin
            NewEntry := NewEntry + 'Left Arrow ';
          end;

          VK_UP:
          begin
            NewEntry := NewEntry + 'Up Arrow ';
          end;

          VK_RIGHT:
          begin
            NewEntry := NewEntry + 'Right Arrow ';
          end;

          VK_DOWN:
          begin
            NewEntry := NewEntry + 'Down Arrow ';
          end;

          VK_INSERT:
          begin
            NewEntry := NewEntry + 'Insert ';
          end;

          VK_DELETE:
          begin
            NewEntry := NewEntry + 'Delete ';
          end;

          VK_PAUSE:
          begin
            NewEntry := NewEntry + 'Pause ';
          end;

          VK_SCROLL:
          begin
            NewEntry := NewEntry + 'Scroll Lock ';
          end;

          VK_MULTIPLY:
          begin
            NewEntry := NewEntry + '* (keypad) ';
          end;

          VK_ADD:
          begin
            NewEntry := NewEntry + '+ (keypad) ';
          end;

          VK_SUBTRACT:
          begin
            NewEntry := NewEntry + '- (keypad) ';
          end;

          VK_DECIMAL:
          begin
            NewEntry := NewEntry + '. (keypad) ';
          end;

          VK_DIVIDE:
          begin
            NewEntry := NewEntry + '/ (keypad) ';
          end;

          VK_NUMPAD0..VK_NUMPAD9:
          begin
            NewEntry := NewEntry + SysUtils.IntToStr(wParam - VK_NUMPAD0) + ' (keypad) ';
          end;

          VK_F1..VK_F24:
          begin
            NewEntry := NewEntry + 'F' + SysUtils.IntToStr(wParam - VK_F1 + 1) + ' ';
          end;

          else begin
//            GetKeyboardState(KeyboardState);
//            ToAscii(wParam, 0, KeyboardState, CharBuf, 0);
//            NewEntry := NewEntry + CharBuf[0] + ' ';
            NewEntry := NewEntry + GetCharFromVKey(wParam) + ' ';
          end;
        end;

        if KeyDown then
          NewEntry := NewEntry + 'down'
        else
          NewEntry := NewEntry + 'up';

        FEventList.Add(NewEntry+' : ' + ReadActiveControlNamenValue);
      end;
    end;
    uetNone:
    begin
       FEventList.Add(NewEntry+ExtraInfo);
    end;
  end;

  while FEventList.Count > MAX_USER_EVENT_LINES do
    FEventList.Delete(0);
end;


initialization
{$IFDEF EXCEPTIONAL_MAGIC}
  DefaultExcFilter := TDefaultExcFilter.Create;
  IndyExcFilter := TIndyExcFilter.Create;
  // turn EM on
  EnableExceptionalMagic;
  ExcMagic.ExceptionHook.MaxCallStack := MAX_CALLSTACK_LINES;
  // set the hook properties
  ExcMagic.ExceptionHook.LogFile := cDefaultLogFile;
  ExcMagic.ExceptionHook.LogHandled := false;
  // register indy filter
  ExcMagic.ExceptionHook.RegisterExceptionFilter(EIdConnClosedGracefully, IndyExcFilter, true);
  ExcMagic.ExceptionHook.EnableExceptionFilter(IndyExcFilter, true);
  // register 'our' default filter
  ExcMagic.ExceptionHook.RegisterExceptionFilter(Exception, DefaultExcFilter, false);
  ExcMagic.ExceptionHook.EnableExceptionFilter(DefaultExcFilter, true);

  UserActions := TUserActions.Create;
{$ELSE}
  ExcMagic.ExceptionHook.Enabled := false;
  ExcMagic.ExceptionHook.LogEnabled := false;
{$ENDIF}

finalization
{$IFDEF EXCEPTIONAL_MAGIC}
  FreeAndNil(UserActions);
{$ENDIF}
end.


