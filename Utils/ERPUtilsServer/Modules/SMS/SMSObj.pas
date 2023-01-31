unit SMSObj;

interface

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
    function CheckReplies(var msg, ReplyInfo: string; MaxReplies: integer = 100; Confirm: boolean = false): boolean; virtual; abstract;
    function SendMessage(Recipient, TextMessage: string; var msg: string; MessageType: TSMSMessageType = mtSMS;
      RecipientID: integer = 0; MessageID: integer = 0; UTCSchedule: TDateTime = 0): boolean; virtual; abstract;
    function ConfirmReplies(ReceiptIdList: string; var msg: string): boolean; virtual; abstract;
  end;

implementation

{ TSMSHTTP }

constructor TSMS.Create;
begin
end;

destructor TSMS.Destroy;
begin
  inherited;
end;

end.
