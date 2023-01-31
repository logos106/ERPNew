unit SMSObj;

interface

uses
  JsonObject;

type
  TSMSMessageType = (mtSMS, mtVoice);

  TSMS = class
  private
    fAccountPassword: string;
    fAccountUser: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property AccountUser: string read fAccountUser write fAccountUser;
    property AccountPassword: string read fAccountPassword write fAccountPassword;
    function CheckUser(var msg, UserInfo: string): boolean; virtual; abstract;
    function CheckReplies(var msg: string; var ReplyInfo: TJsonObject; MaxReplies: integer = 100; Confirm: boolean = false): boolean; virtual; abstract;
    function SendMessage(Recipient, TextMessage: string; var msg: string; MessageType: TSMSMessageType = mtSMS;
      RecipientID: integer = 0; MessageID: integer = 0; UTCSchedule: TDateTime = 0): boolean; virtual; abstract;
    function ConfirmReplies(ReceiptIdList: string; var msg: string): boolean; virtual; abstract;
  end;

  function SMSMessageTypeToStr(aType: TSMSMessageType): string;
  function StrToSMSMessageType(aStr: string): TSMSMessageType;


implementation

uses
  SysUtils;

function SMSMessageTypeToStr(aType: TSMSMessageType): string;
begin
  case aType of
    mtSMS: result := 'SMS';
    mtVoice: result := 'voice';
    else raise Exception.Create('SMSMessageTypeToStr - Invalid SMS Message Type: ' + IntToStr(Ord(aType)));
  end;
end;

function StrToSMSMessageType(aStr: string): TSMSMessageType;
begin
  if SameText(aStr,'SMS') then
    result := mtSMS
  else if SameText(aStr,'voice') then
    result := mtVoice
  else
    raise Exception.Create('StrToSMSMessageType - Invalid Message Type String: "' + aStr + '"');
end;

{ TSMSHTTP }

constructor TSMS.Create;
begin
end;

destructor TSMS.Destroy;
begin
  inherited;
end;

end.
