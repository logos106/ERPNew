unit frmPhoneButton;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls, Mask, wwdbedit, ShellApi;

type
  TPhoneButton = class(TFrame)
    pnlPhonebutton: TDNMPanel;
    Phonebutton: TDNMSpeedButton;
    procedure PhonebuttonClick(Sender: TObject);
    procedure PhonebuttonExit(Sender: TObject);
  private
    fPhoneEdit: TCustomEdit;
    fsErrorMsg: String;
    procedure DoOnEditDblClick(Sender: TObject);
    procedure SetPhoneEdit(const Value: TCustomEdit);
    procedure CallOnCyTrack;
  public
    Property PhoneEdit: TCustomEdit read fPhoneEdit write SetPhoneEdit;
    Property ErrorMsg:String read fsErrorMsg;
    constructor Create(AOwner:TComponent);Override;
    destructor   Destroy; override;
  end;

implementation

uses AppEnvironment, (*RegEdit,*) SystemLib, CommonLib, CyTrackObj;

{$R *.dfm}

procedure TPhoneButton.CallOnCyTrack;
var
  s: string;
begin
  s := ReplaceStr(Trim(PhoneEdit.text), '(' , '');
  s := ReplaceStr(s, ')' , '');
  s := ReplaceStr(s, ' ' , '');
  if not TCyTrack.Inst.Connected then begin
    CommonLib.MessageDlgXP_Vista('ERP is not connected to CyDesk, make sure CyDesk is running and ERP CyTrack preference settings are correct.',mtInformation,[mbOk],0);
    exit;
  end;
  if SameText(TCyTrack.Inst.Status,'Idle') then
    TCyTrack.Inst.MakeCall(s)
  else
    CommonLib.MessageDlgXP_Vista('CyDesk is not ready to make a call, current status is "' + TCyTrack.Inst.Status + '"',mtInformation,[mbOk],0);
end;

constructor TPhoneButton.Create(AOwner: TComponent);
begin
  inherited;
  pnlPhonebutton.top := 0;
  pnlPhonebutton.Left := 0;
  Self.width := pnlPhonebutton.width;
  Self.Height := pnlPhonebutton.Height;
  fPhoneEdit:= nil;
  pnlPhonebutton.Align := alClient;
end;

destructor TPhoneButton.Destroy;
begin
  inherited;
end;

procedure TPhoneButton.DoOnEditDblClick(Sender: TObject);
begin
  if (Sender is TwwDBEdit) or (Sender is TEdit) then begin
    if AppEnv.CompanyPrefs.CyTrackIntegrationEnabled and AppEnv.Employee.CyTrackIntegrationEnabled then begin
      CallOnCyTrack;
    end;
  end;
end;

procedure TPhoneButton.PhonebuttonClick(Sender: TObject);
var
  s:String;
  sPhonenumber :String;
//  UsingSkype: boolean;
//  UsingCyTrack: boolean;
  dlgResult: integer;

  procedure CallOnSkype;
  begin
    s:= '"' +s+'"' + ' /Callto:' +sPhonenumber;
    ExecNewProcess(s, False);
  end;

begin
(*
  UsingCyTrack := AppEnv.CompanyPrefs.CyTrackIntegrationEnabled and AppEnv.Employee.CyTrackIntegrationEnabled;
  if UsingCyTrack then
    pnlPhonebutton.hint:='Select to Call on Skype or CyTrack'
  else
    pnlPhonebutton.hint:='Select to Call on Skype';
  *)
  pnlPhonebutton.hint:='Select to Call on Your Default Calling Program';
  try
    if PhoneEdit=nil then exit;
    sPhonenumber:=ReplaceStr(TRim(PhoneEdit.text), ' ' , '');
    if sPhonenumber = '' then begin
      fsErrorMsg := 'Phone Number is Empty';
      pnlPhonebutton.hint:=fsErrorMsg;
      exit;
    end;
(*
    if Copy(sPhonenumber, 1,1 ) = '0' then sPhonenumber:= copy(sPhonenumber , 2, length(sPhonenumber));
    if Copy(sPhonenumber, 1,1 ) = '+' then else begin
*)
    if sPhoneNumber[1] = '0' then Delete(sPhoneNumber,1,1);
    if sPhoneNumber[1] <> '+' then
    begin
      if Appenv.RegionalOptions.ISDCode<> 0 then sPhonenumber:= inttostr(Appenv.RegionalOptions.ISDCode)+sPhonenumber;
      sPhonenumber:= '+'+sPhonenumber;
    end;

    dlgResult := ShellExecute(0, 'open', PChar('callto: ' + sPhoneNumber), nil, nil, SW_SHOWNORMAL);
    if dlgResult <= 32 then
    begin
      case dlgResult of
       0,
       SE_ERR_OOM : s := 'Windows is Out of Memory or Resources';
       SE_ERR_DLLNOTFOUND,
//       SE_ERR_FNF,
//       SE_ERR_PNF,
       ERROR_FILE_NOT_FOUND,
       ERROR_PATH_NOT_FOUND: s := 'File or Path not Found; Please re-install Your Calling App';
       ERROR_BAD_FORMAT: s := 'The App Set as Default is not a Windows App';
       SE_ERR_ACCESSDENIED: s := 'You do not Have Rights to Access the App';
       else s := 'Error on Launching Calling App';
      end;
      MessageDlgXP_Vista('Call Failed.'#13#10 + s, mtError, [mbOk], 0);
    end;

    (*
    s := Appenv.CompanyPrefs.SkypePath;
    UsingSkype := (s <> '') and FileExists(s);

    if (not UsingSkype) and (not UsingCyTrack) then begin
      fsErrorMsg := 'Skype is not installed and CyTrack is not enabled';
      pnlPhonebutton.hint := fsErrorMsg;
      Exit;
    end;

    if UsingSkype and (not UsingCyTrack) then
      CallOnSkype
    else if UsingCyTrack and (not UsingSkype) then
      CallOnCyTrack
    else begin
      dlgResult:=
        MessageDlgXP_Vista('How would you like to make the call?' + #13#10 + #13#10 +
          '(note that double clicking on the phone number will call using CyTRack)',
          mtConfirmation,[],0,nil,'','',false,nil,'Skype,CyTrack,Cancel');
      case dlgResult of
        100: CallOnSkype;
        101: CallOnCyTrack;
        102:;
      end;
    end;
   *)
    if PhoneEdit.enabled then SetcontrolFocus(PhoneEdit);
  finally
    Phonebutton.hint :=pnlPhonebutton.hint;
  end;
end;

procedure TPhoneButton.PhonebuttonExit(Sender: TObject);
begin
  pnlPhonebutton.hint:='Select to Call on Skype';
  Phonebutton.hint :=pnlPhonebutton.hint;
end;

procedure TPhoneButton.SetPhoneEdit(const Value: TCustomEdit);
begin
  fPhoneEdit := Value;
  if fPhoneEdit is TwwDbEdit then
    TwwDbEdit(fPhoneEdit).OnDblClick := DoOnEditDblClick
  else if fPhoneEdit is TEdit then
    TEdit(fPhoneEdit).OnDblClick := DoOnEditDblClick;
  //fPhoneEdit.OnDblClick := DoOnEditDblClick;
end;

end.
