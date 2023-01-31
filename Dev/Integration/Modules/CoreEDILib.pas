unit CoreEDILib;

interface

Uses CoreEDIObj , utBaseCoreService;

Type
  TLoginList = Procedure (const Value: String; const ShowinList: Boolean = True) of object;

procedure InitCodeEDI(CoreEDI:TCoreEDI);
Function ConnecttoCoreEDI(CoreEDI:TCoreEDI; CoreServObj :TBaseCoreService; fLoginList:TLoginList; ausername :String ='' ; aPassword :String = ''):Boolean;

implementation

uses AppEnvironment, sysutils, shellapi, dialogs, windows, commonlib,
  FrmInputText, controls;

Function ConnecttoCoreEDI(CoreEDI:TCoreEDI; CoreServObj :TBaseCoreService; fLoginList:TLoginList; ausername :String ='' ; aPassword :String = ''):Boolean;
  Procedure LoginList(const Value: String; const ShowinList: Boolean = True);
  begin
    if not(Assigned(fLoginList)) then exit;
    fLoginList(Value,Showinlist);
  end;
begin
  if not CoreEDI.Connected then begin
    if ausername <> '' then CoreEDI.CoreEDIUser     := ausername else CoreEDI.CoreEDIUser     := AppEnv.CompanyPrefs.CoreEDIUSerName;
    if aPassword <> '' then CoreEDI.CoreEDIPassword := aPassword else CoreEDI.CoreEDIPassword := AppEnv.CompanyPrefs.CoreEDIPassword;

    try
      CoreEDI.Connect;
    except
      on e: exception do begin
        LoginList('The following error occured while trying to connect to the CoreEDI Server:' + #13#10 + #13#10 + e.Message);
        exit;
      end;
    end;

    if not CoreEDI.Connected then begin
      Result := False;
      LoginList('Failed to connect to CoreEDI Server.');
      exit;
    end;
    if CoreServObj = nil then begin
      REsult := true;
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
    end else begin
      Result := True;
    end;
  end else begin
    Result := True;
  end;

end;
procedure InitCodeEDI(CoreEDI:TCoreEDI);
var
  s: string;
  Ips :Array of String;
begin
  if DevMode then begin
    SetLength(IPS, 2);
    IPs[0] :='localhost:8445' ;
    IPs[1] :='erpclientserver.dyndns.org:8449';
    s:= SelectFromList('CoreEDI Server' , 'Server Address' ,'',
                      IPs ,
                      IPs[0]);
    if s <> '' then
      CoreEDI.CoreEDIServer := s;
  end;
end;

end.
