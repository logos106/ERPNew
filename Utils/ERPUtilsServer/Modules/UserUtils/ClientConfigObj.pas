unit ClientConfigObj;

interface

uses
  classes, JSONObject;

type

  TComputerList = class;
  TSoftwareLicence = class;
  TSoftwareLicenceList = class;

  TClientConfig = class(TPersistent)
  private
    FActive: boolean;
    FName: string;
    fServerList: TComputerList;
    FId: integer;
    FUser: string;
    FDateTime: TDateTime;
    FSoftwareReleaseType: string;
    fERPClientName: string;
    procedure SetActive(const Value: boolean);
    procedure SetName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetUser(const Value: string);
    procedure SetSoftwareReleaseType(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function LicenceByName(aComputerName, aSoftwareName: string): TSoftwareLicence;
  published
    property Id: integer read FId write SetId;
    property Active: boolean read FActive write SetActive;
    property Name: string read FName write SetName;
    property SoftwareReleaseType: string read FSoftwareReleaseType write SetSoftwareReleaseType;
    property ServerList: TComputerList read fServerList;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property User: string read FUser write SetUser;
    property ERPClientName: string read fERPClientName write fERPClientName;
  end;

  TComputer = class;

  TComputerList = class(TCollection)
  private
  public
    constructor Create;
    function Add: TComputer;
    function ByName(aComputerName: string): TComputer;
    function ComputerNameCommaText: string;
  end;

  TComputerConfigList = class;

  TComputer = class(TCollectionItem)
  private
    FActive: boolean;
    FNotes: string;
    fConfigList: TComputerConfigList;
    FId: integer;
    FClientId: integer;
    FComputerName: string;
    FUser: string;
    FDateTime: TDateTime;
    fLicenceList: TSoftwareLicenceList;
    procedure SetActive(const Value: boolean);
    procedure SetNotes(const Value: string);
    procedure SetClientId(const Value: integer);
    procedure SetId(const Value: integer);
    procedure SetComputerName(const Value: string);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetUser(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Id: integer read FId write SetId;
    property ClientId: integer read FClientId write SetClientId;
    property ComputerName: string read FComputerName write SetComputerName;
    property Active: boolean read FActive write SetActive;
    property Notes: string read FNotes write SetNotes;
    property ConfigList: TComputerConfigList read fConfigList;
    property LicenceList: TSoftwareLicenceList read fLicenceList;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property User: string read FUser write SetUser;
  end;

  TComputerConfig = class;

  TComputerConfigList = class(TCollection)
  private
    function GetItemById(aId: integer): TComputerConfig;
  public
    constructor Create;
    function Add: TComputerConfig;
    property ItemById[aId: integer]: TComputerConfig read GetItemById;
  end;

  TComputerConfig = class(TCollectionItem)
  private
    FActive: boolean;
    FNotes: string;
    FComputerId: integer;
    FId: integer;
    fConfig: TJsonObject;
    FUser: string;
    FDateTime: TDateTime;
    procedure SetActive(const Value: boolean);
    procedure SetNotes(const Value: string);
    procedure SetComputerId(const Value: integer);
    procedure SetId(const Value: integer);
    function GetConfig: TJsonObject;
    function GetText: string;
    procedure SetText(const Value: string);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetUser(const Value: string);
    function getReadasString: String;
  public
    property Config: TJsonObject read GetConfig;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AddNote(aNote: string);
    function GetFixedDiskCount: integer;
    Property ReadasString:String read getReadasString;
  published
    property Id: integer read FId write SetId;
    property ComputerId: integer read FComputerId write SetComputerId;
    property Active: boolean read FActive write SetActive;
    property Text: string read GetText write SetText;
    property Notes: string read FNotes write SetNotes;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property User: string read FUser write SetUser;
  end;

  TSoftwareLicenceList = class(TCollection)
  private
  public
    constructor Create;
    function Add: TSoftwareLicence;
    function ByName(aSoftwareName: string): TSoftwareLicence;
  end;


  TSoftwareLicenceStatus = (lsUnknown, lsPending, lsLicenced, lsHold,
                            lsCancelled, lsReview, lsExpired);

  TSoftwareLicence = class(TCollectionItem)
  private
    FActive: boolean;
    FConcurrentUsers: integer;
    FNotes: string;
    FSoftwareName: string;
    FExpireDate: TDateTime;
    FStartDate: TDateTime;
    FStatus: TSoftwareLicenceStatus;
    FId: integer;
    fData: TJsonObject;
    FComputerId: integer;
    FUser: string;
    FDateTime: TDateTime;
    FStatusReason: string;
    procedure SetActive(const Value: boolean);
    procedure SetConcurrentUsers(const Value: integer);
    procedure SetExpireDate(const Value: TDateTime);
    procedure SetNotes(const Value: string);
    procedure SetSoftwareName(const Value: string);
    procedure SetStartDate(const Value: TDateTime);
    procedure SetStatus(const Value: TSoftwareLicenceStatus);
    procedure SetId(const Value: integer);
    function GetDataText: string;
    procedure SetDataText(const Value: string);
    procedure SetComputerId(const Value: integer);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetUser(const Value: string);
    procedure SetStatusReason(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Data: TJsonObject read fData;
    function IsLicenced(var reason: string): boolean;
    function Description(const Indent: string = ''): string;
  published
    property Id: integer read FId write SetId;
    property ComputerId: integer read FComputerId write SetComputerId;
    property Active: boolean read FActive write SetActive;
    property SoftwareName: string read FSoftwareName write SetSoftwareName;
    property StartDate: TDateTime read FStartDate write SetStartDate;
    property ExpireDate: TDateTime read FExpireDate write SetExpireDate;
    property Status: TSoftwareLicenceStatus read FStatus write SetStatus;
    property StatusReason: string read FStatusReason write SetStatusReason;
    property DataText: string read GetDataText write SetDataText;
    property ConcurrentUsers: integer read FConcurrentUsers write SetConcurrentUsers;
    property Notes: string read FNotes write SetNotes;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property User: string read FUser write SetUser;
  end;


function SoftwareLicenceStatusToStr(const status: TSoftwareLicenceStatus): string;
function StrToSoftwareLicenceStatus(const status: string): TSoftwareLicenceStatus;

implementation

uses
  sysutils, DateTimeUtils, TypInfo, SystemLib, ERPLicenseLib;
  
function SoftwareLicenceStatusToHumanStr(const status: TSoftwareLicenceStatus): string;
begin
  case status of
    lsUnknown: result:= 'Unknown';
    lsPending: result:= 'Pending';
    lsLicenced: result:= 'Licenced';
    lsHold: result:= 'Hold';
    lsCancelled: result:= 'Canceled';
    lsReview: result:= 'Review';
    lsExpired: result:= 'Expired';
    else
      result:= 'Invalid Status';
  end;
end;

function SoftwareLicenceStatusToStr(const status: TSoftwareLicenceStatus): string;
begin
  case status of
    lsUnknown: result:= 'lsUnknown';
    lsPending: result:= 'lsPending';
    lsLicenced: result:= 'lsLicenced';
    lsHold: result:= 'lsHold';
    lsCancelled: result:= 'lsCancelled';
    lsReview: result:= 'lsReview';
    lsExpired: result:= 'lsExpired';
    else
      raise exception.Create('Invalid Software Status');
  end;
end;

function StrToSoftwareLicenceStatus(const status: string): TSoftwareLicenceStatus;
begin
  if SameText(status, 'lsUnknown') then result := lsUnknown
  else if SameText(status, 'lsPending') then result := lsPending
  else if SameText(status, 'lsLicenced') then result := lsLicenced
  else if SameText(status, 'lsHold') then result := lsHold
  else if SameText(status, 'lsCancelled') then result := lsCancelled
  else if SameText(status, 'lsReview') then result := lsReview
  else if SameText(status, 'lsExpired') then result := lsExpired
  else raise Exception.Create('Invalid Software Status String');
end;

{ TClientConfig }

constructor TClientConfig.Create;
begin
  inherited;
  fServerList:= TComputerList.Create;
end;

destructor TClientConfig.Destroy;
begin
  fServerList.Free;
  inherited;
end;

function TClientConfig.LicenceByName(aComputerName,
  aSoftwareName: string): TSoftwareLicence;
var
  comp: TComputer;
begin
  result:= nil;
  comp:= ServerList.ByName(aComputerName);
  if Assigned(comp) then
    result:= comp.LicenceList.ByName(aSoftwareName);
end;

procedure TClientConfig.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TClientConfig.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
end;

procedure TClientConfig.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TClientConfig.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TClientConfig.SetSoftwareReleaseType(const Value: string);
begin
  FSoftwareReleaseType := Value;
end;

procedure TClientConfig.SetUser(const Value: string);
begin
  FUser := Value;
end;

{ TComputerList }

function TComputerList.Add: TComputer;
begin
  result:= TComputer(inherited Add);
end;

constructor TComputerList.Create;
begin
  inherited Create(TComputer);
end;

function TComputerList.ByName(aComputerName: string): TComputer;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    if TComputer(Items[x]).ComputerName = aComputerName then begin
      result:= TComputer(Items[x]);
      break;
    end;
  end;
end;

function TComputerList.ComputerNameCommaText: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to self.Count -1 do begin
    if x > 0 then result:= result + ',';
    result:= result + '"' + TComputer(Items[x]).ComputerName + '"';
  end;
end;

{ TComputer }

constructor TComputer.Create(Collection: TCollection);
begin
  inherited;
  fConfigList:= TComputerConfigList.Create;
  fLicenceList:= TSoftwareLicenceList.Create;
end;

destructor TComputer.Destroy;
begin
  fConfigList.Free;
  fLicenceList.Free;
  inherited;
end;

procedure TComputer.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TComputer.SetClientId(const Value: integer);
begin
  FClientId := Value;
end;

procedure TComputer.SetComputerName(const Value: string);
begin
  FComputerName := Value;
end;

procedure TComputer.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
end;

procedure TComputer.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TComputer.SetNotes(const Value: string);
begin
  FNotes := Value;
end;

procedure TComputer.SetUser(const Value: string);
begin
  FUser := Value;
end;

{ TComputerConfigList }

function TComputerConfigList.Add: TComputerConfig;
begin
  result:=  TComputerConfig(inherited Add);
end;

constructor TComputerConfigList.Create;
begin
  inherited Create(TComputerConfig);
end;

function TComputerConfigList.GetItemById(aId: integer): TComputerConfig;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    if TComputerConfig(Items[x]).Id = aId then begin
      result:= TComputerConfig(Items[x]);
      break;
    end;
  end;
end;

{ TComputerConfig }

procedure TComputerConfig.AddNote(aNote: string);
begin
  if fNotes <> '' then fNotes:= fNotes + #13#10;
  fNotes:= fNotes + aNote; 
end;

constructor TComputerConfig.Create(Collection: TCollection);
begin
  inherited;
  fConfig:= JO;
end;

destructor TComputerConfig.Destroy;
begin
  fConfig.Free;
  inherited;
end;

function TComputerConfig.GetConfig: TJsonObject;
begin
  result:= fConfig;
end;

function TComputerConfig.GetFixedDiskCount: integer;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to Config.Count -1 do begin
    if Config.Items[x].Value.AsObject.S['storagetypedescription'] = 'Fixed Disk' then
      Inc(result);
  end;
end;

function TComputerConfig.getReadasString: String;
begin
    Result := 'ID:' + inttostr(Id)+',' +chr(10)+
              'ComputerId:' + inttostr(ComputerId)+',' +chr(10)+
              'Active:' + Booleantostr(Active)+',' +chr(10)+
              'Text:' + Text+',' +chr(10)+
              'Notes:'+Notes+',' +chr(10)+
              'DateTime: '+ FormatDatetime('dd/mm/yyyy' , Datetime)+',' +chr(10)+
              'User:'+ User;

end;

function TComputerConfig.GetText: string;
begin
  result:= fConfig.AsString;
end;

procedure TComputerConfig.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TComputerConfig.SetComputerId(const Value: integer);
begin
  FComputerId := Value;
end;

procedure TComputerConfig.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
end;

procedure TComputerConfig.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TComputerConfig.SetNotes(const Value: string);
begin
  FNotes := Value;
end;

procedure TComputerConfig.SetText(const Value: string);
begin
  fConfig.AsString := Value;
end;

procedure TComputerConfig.SetUser(const Value: string);
begin
  FUser := Value;
end;

{ TSoftwareLicenceList }

function TSoftwareLicenceList.Add: TSoftwareLicence;
begin
  result:= TSoftwareLicence(inherited Add);
end;

function TSoftwareLicenceList.ByName(aSoftwareName: string): TSoftwareLicence;
var x: integer;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    if TSoftwareLicence(Items[x]).SoftwareName = aSoftwareName then begin
      result:= TSoftwareLicence(Items[x]);
      break;
    end;
  end;
end;

constructor TSoftwareLicenceList.Create;
begin
  inherited Create(TSoftwareLicence);
end;

{ TSoftwareLicence }

constructor TSoftwareLicence.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  fData:= TJsonObject.Create;
end;

function TSoftwareLicence.Description(const Indent: string = ''): string;
begin
  result:=
    Indent + 'Software Name: ' + FSoftwareName + #13#10 +
    Indent + 'Active: ' + BoolToStr(FActive) + #13#10 +
    Indent + 'Users: ' + IntToStr(FConcurrentUsers) + #13#10 +
    Indent + 'Start Date: ' + FormatDateTime('dd/mm/yyyy', fStartDate) + #13#10 +
    Indent + 'Expire Date: ' + FormatDateTime('dd/mm/yyyy', fExpireDate) + #13#10 +
    Indent + 'Status: ' + SoftwareLicenceStatusToHumanStr(FStatus) + #13#10 +
    Indent + 'Status Reason: ' + FStatusReason + #13#10 +
    Indent + 'Id: ' + IntToStr(FId) + #13#10 +
    Indent + 'Computer Id: ' + IntToStr(FComputerId);

//    FNotes: string;
//    fData: TJsonObject;
//    FUser: string;
//    FDateTime: TDateTime;
end;

destructor TSoftwareLicence.Destroy;
begin
  fData.Free;
  inherited;
end;

function TSoftwareLicence.GetDataText: string;
begin
  result:= fData.AsString;
end;

function TSoftwareLicence.IsLicenced(var reason: string): boolean;
begin
  if ByPassLicenseCheck then begin
        result:= true;
        reason:= 'Licence Bypassed';
        Exit;
  end;
  case self.FStatus of
    lsUnknown:
      begin
        result:= false;
        reason:= 'Licence status unknown';
      end;
    lsPending:
      begin
        result:= false;
        reason:= 'Licence pending activation';
      end;
    lsLicenced:
      begin
        result:= true;
        reason:= 'Licence valid';
      end;
    lsHold:
      begin
        result:= false;
        reason:= 'Licence on hold';
      end;
    lsCancelled:
      begin
        result:= false;
        reason:= 'Licence cancelled';
      end;
    lsReview:
      begin
        result:= true;
        reason:= 'Licence valid';
      end;
    lsExpired:
      begin
        result:= false;
        reason:= 'Licence expired';
      end;
    else begin
      result:= false;
      reason:= 'Licence status unknown';
    end;
  end;
  { NOTE: Removed the following as we can not rely on users server date/time being correct!  }
(*
  if result and (NowUTC > self.FExpireDate) then begin
    result:= false;
    reason:= 'Licence expired';
  end;
*)
end;

procedure TSoftwareLicence.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TSoftwareLicence.SetComputerId(const Value: integer);
begin
  FComputerId := Value;
end;

procedure TSoftwareLicence.SetConcurrentUsers(const Value: integer);
begin
  FConcurrentUsers := Value;
end;

procedure TSoftwareLicence.SetDataText(const Value: string);
begin
  fData.AsString := Value;
end;

procedure TSoftwareLicence.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
end;

procedure TSoftwareLicence.SetExpireDate(const Value: TDateTime);
begin
  FExpireDate := Value;
end;

procedure TSoftwareLicence.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TSoftwareLicence.SetNotes(const Value: string);
begin
  FNotes := Value;
end;

procedure TSoftwareLicence.SetSoftwareName(const Value: string);
begin
  FSoftwareName := Value;
end;

procedure TSoftwareLicence.SetStartDate(const Value: TDateTime);
begin
  FStartDate := Value;
end;

procedure TSoftwareLicence.SetStatus(const Value: TSoftwareLicenceStatus);
begin
  FStatus := Value;
end;

procedure TSoftwareLicence.SetStatusReason(const Value: string);
begin
  FStatusReason := Value;
end;

procedure TSoftwareLicence.SetUser(const Value: string);
begin
  FUser := Value;
end;


end.
