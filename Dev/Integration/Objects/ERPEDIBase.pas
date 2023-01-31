unit ERPEDIBase;

interface

uses
  utBaseCoreService, Classes, LogThreadBase;

type
  TERPEDIBase = class;
  TErpSynchProgEvent = procedure(Sender: TERPEDIBase; var Continue: boolean; msg: string = '') of object;


  TERPEDIBase = class
  private
  protected
    ContinueSynch: boolean;
    fReturnCode: string;
    fCurrentSynchItemType: string;
    fCoreService: TBaseCoreService;
    fUserMessage: string;
    fCurrentSynchId: integer;
    fSynchType: string;
    fAPIMEssage: string;
    fTotalItemsToSynch: integer;
    fCurrentSynchItemNo: integer;
    fOnSynchProgress: TErpSynchProgEvent;
    fOnSynchError: TNotifyEvent;
    fActive: boolean;
    fOnLog: TOnLogStrEvent;
    procedure Log(const msg: string; const aType: string = '');
    procedure DoError; overload;
    procedure DoError(const aUserMessage: string; const aReturnCode: string = 'Error'; const aAPIMEssage: string = ''); overload;
    procedure DoProgress(const msg: string = '');
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property CoreService: TBaseCoreService read fCoreService write fCoreService;
    property OnSynchProgress: TErpSynchProgEvent read fOnSynchProgress write fOnSynchProgress;
    property OnSynchError: TNotifyEvent read fOnSynchError write fOnSynchError;
    property SynchType: string read fSynchType;
    property TotalItemsToSynch: integer read fTotalItemsToSynch;
    property CurrentSynchItemNo: integer read fCurrentSynchItemNo;
    property CurrentSynchId: integer read fCurrentSynchId;
    property CurrentSynchItemType: string read fCurrentSynchItemType;
    property UserMessage: string read fUserMessage;
    property APIMessage: string read fAPIMEssage;
    property ReturnCode: string read fReturnCode;
    property Active: boolean read fActive write fActive;
    property OnLog: TOnLogStrEvent read fOnLog write fOnLog;
  end;


implementation

{ TERPEDIBase }

constructor TERPEDIBase.Create;
begin

end;

destructor TERPEDIBase.Destroy;
begin

  inherited;
end;

procedure TERPEDIBase.DoError;
begin
  if (fReturnCode = '') and (CoreService.ResultData.S['ReturnCode'] <> '') then
    fReturnCode := CoreService.ResultData.S['ReturnCode'];
  if (fUserMessage = '') and (CoreService.ResultData.S['UserMessage'] <> '') then
    fUserMessage := CoreService.ResultData.S['UserMessage'];
  fAPIMessage := CoreService.ResultData.S['APIMessage'];
  if Assigned(fOnSynchError) then
    fOnSynchError(self);
end;

procedure TERPEDIBase.DoError(const aUserMessage, aReturnCode,
  aAPIMEssage: string);
begin
  fUserMessage := aUserMessage;
  fReturnCode := aReturnCode;
  fAPIMessage := aAPIMessage;
  DoError;
end;

procedure TERPEDIBase.DoProgress(const msg: string);
begin
  if Assigned(fOnSynchProgress) then begin
    if not Active then begin
      ContinueSynch := false;
      exit;
    end;
    fOnSynchProgress(self, ContinueSynch, msg);
    if not ContinueSynch then begin
      fReturnCode := 'Terminated';
    end;
  end;
end;

procedure TERPEDIBase.Log(const msg, aType: string);
begin
  if Assigned(fOnLog) then
    fOnLog(msg, aType)
end;

end.
