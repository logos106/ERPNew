unit MultisiteConfigObj;

interface

uses
  classes{, MultisiteConst, ModuleConst};

type

  TDatabaseList = class;
  TServerConfig = class(TPersistent)
  private
    FMySqlServer: string;
    fDatabaseList: TDatabaseList;
    fActive: boolean;
    fOnChange: TNotifyEvent;
    DoingAssign: boolean;
    Destroying: boolean;
    procedure SetMySqlServer(const Value: string);
    procedure SetActive(const Value: boolean);
    procedure DoSubOnChange(Sender: TObject);
    procedure DoChange;
  public
    constructor Create;
    destructor Destroy; override;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  protected
  published
    property MySqlServer: string read FMySqlServer write SetMySqlServer;
    property DatabaseList: TDatabaseList read fDatabaseList;
    property Active: boolean read fActive write SetActive;
    procedure Assign(Source: TPersistent); override;
  end;

  TDatabase = class;
  TDatabaseList = class(TCollection)
  private
    fOnChange: TNotifyEvent;
    function GetItem(idx: integer): TDatabase;
    procedure SetItem(idx: integer; const Value: TDatabase);
    procedure DoSubOnChange(Sender: TObject);
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create;
    function Add: TDatabase;
    property Items[idx: integer]: TDatabase read GetItem write SetItem; default;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

  TRemoteDatabaseList = class;
  TDatabase = class(TCollectionItem)
  private
    FSynchronizationActive: boolean;
    FDatabaseName: string;
    FCheckInterval: TDateTime;
    fRemoteDatabaseList: TRemoteDatabaseList;
    fLastSyncTime: TDateTime;
    fOnChange: TNotifyEvent;
    fDbPreCheckDone: boolean;
    procedure SetCheckInterval(const Value: TDateTime);
    procedure SetDatabaseName(const Value: string);
    procedure SetSynchronizationActive(const Value: boolean);
    function GetCaption: string;
    procedure DoSubOnChange(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Caption: string read GetCaption;
    property LastSyncTime: TDateTime read fLastSyncTime write fLastSyncTime;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property DbPreCheckDone: boolean read fDbPreCheckDone write fDbPreCheckDone;
  published
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property CheckInterval: TDateTime read FCheckInterval write SetCheckInterval;
    property SynchronizationActive: boolean read FSynchronizationActive write SetSynchronizationActive;
    property RemoteDatabaseList: TRemoteDatabaseList read fRemoteDatabaseList;
  end;

  TRemoteDatabase = class;
  TRemoteDatabaseList = class(TCollection)
  private
    fOnChange: TNotifyEvent;
    function GetItem(idx: integer): TRemoteDatabase;
    procedure SetItem(idx: integer; const Value: TRemoteDatabase);
    procedure DoSubOnChange(Sender: TObject);
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create;
    function Add: TRemoteDatabase;
    property Items[idx: integer]: TRemoteDatabase read GetItem write SetItem; default;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

  TRemoteDatabase = class(TCollectionItem)
  private
    FDatabaseName: string;
    FSiteCode: string;
    FMySQLServer: string;
    fOnChange: TNotifyEvent;
    fDbPreCheckDone: boolean;
    procedure SetDatabaseName(const Value: string);
    procedure SetMySQLServer(const Value: string);
    procedure SetSiteCode(const Value: string);
    function GetCaption: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Caption: string read GetCaption;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property DbPreCheckDone: boolean read fDbPreCheckDone write fDbPreCheckDone;
  published
    property SiteCode: string read FSiteCode write SetSiteCode;
    property MySQLServer: string read FMySQLServer write SetMySQLServer;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
  end;


implementation

uses
  JsonToObject;

{ TServerConfig }

procedure TServerConfig.Assign(Source: TPersistent);
begin
  DoingAssign:= true;
  try
    ObjToObj(Source,self);
  finally
    DoingAssign:= false;
  end;
  DoChange;
end;

constructor TServerConfig.Create;
begin
  inherited;
  Destroying:= false;
  DoingAssign:= false;
  fDatabaseList:= TDatabaseList.Create;
  fDatabaseList.OnChange:= self.DoSubOnChange;
  FMySqlServer:= 'localhost';
end;

destructor TServerConfig.Destroy;
begin
  Destroying:= true;
  fDatabaseList.Free;
  inherited;
end;

procedure TServerConfig.DoChange;
begin
  if (not Destroying) and (not DoingAssign) and Assigned(fOnChange) then
    fOnChange(self);
end;

procedure TServerConfig.DoSubOnChange(Sender: TObject);
begin
  DoChange;
end;

procedure TServerConfig.SetActive(const Value: boolean);
begin
  if fActive <> Value then begin
    fActive := Value;
    DoChange;
  end;
end;

procedure TServerConfig.SetMySqlServer(const Value: string);
begin
  if FMySqlServer <> Value then begin
    FMySqlServer := Value;
    DoChange;
  end;
end;

{ TDatabaseList }

function TDatabaseList.Add: TDatabase;
begin
  result:= TDatabase(inherited Add);
  result.OnChange:= self.DoSubOnChange;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

constructor TDatabaseList.Create;
begin
  inherited Create(TDatabase);
end;

procedure TDatabaseList.DoSubOnChange(Sender: TObject);
begin
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TDatabaseList.GetItem(idx: integer): TDatabase;
begin
  result:= TDatabase(inherited Items[idx]);
end;

procedure TDatabaseList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

procedure TDatabaseList.SetItem(idx: integer;
  const Value: TDatabase);
begin
  TDatabase(inherited Items[idx]).Assign(Value);
  if Assigned(fOnChange) then
    fOnChange(self);
end;

{ TDatabase }

constructor TDatabase.Create(Collection: TCollection);
begin
  inherited;
  fRemoteDatabaseList:= TRemoteDatabaseList.Create;
  fRemoteDatabaseList.OnChange:= self.DoSubOnChange;
  fCheckInterval:= 1/24/60 * 5;  { default to 5 mins }
  fDbPreCheckDone:= false;
end;

destructor TDatabase.Destroy;
begin
  fRemoteDatabaseList.Free;
  inherited;
end;

procedure TDatabase.DoSubOnChange(Sender: TObject);
begin
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TDatabase.GetCaption: string;
begin
  result:= 'Sync Database - [' + FDatabaseName + ']';
end;

procedure TDatabase.SetCheckInterval(const Value: TDateTime);
begin
  if FCheckInterval <> Value then begin
    FCheckInterval := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TDatabase.SetDatabaseName(const Value: string);
begin
  if FDatabaseName <> Value then begin
    FDatabaseName := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TDatabase.SetSynchronizationActive(const Value: boolean);
begin
  if FSynchronizationActive <> Value then begin
    FSynchronizationActive := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

{ TRemoteDatabaseList }

function TRemoteDatabaseList.Add: TRemoteDatabase;
begin
  result:= TRemoteDatabase(inherited Add);
  result.OnChange:= self.DoSubOnChange;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

constructor TRemoteDatabaseList.Create;
begin
  inherited Create(TRemoteDatabase);
end;

procedure TRemoteDatabaseList.DoSubOnChange(Sender: TObject);
begin
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TRemoteDatabaseList.GetItem(idx: integer): TRemoteDatabase;
begin
  result:= TRemoteDatabase(inherited Items[idx]);
end;

procedure TRemoteDatabaseList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

procedure TRemoteDatabaseList.SetItem(idx: integer;
  const Value: TRemoteDatabase);
begin
  TRemoteDatabase(inherited Items[idx]).Assign(Value);
  if Assigned(fOnChange) then
    fOnChange(self);
end;

{ TRemoteDatabase }

constructor TRemoteDatabase.Create(Collection: TCollection);
begin
  inherited;
  fDbPreCheckDone:= false;
end;

destructor TRemoteDatabase.Destroy;
begin

  inherited;
end;

function TRemoteDatabase.GetCaption: string;
begin
  result:= 'Remote Site - [' + FDatabaseName + '@' + FMySQLServer + ']';
end;

procedure TRemoteDatabase.SetDatabaseName(const Value: string);
begin
  if FDatabaseName <> Value then begin
    FDatabaseName := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TRemoteDatabase.SetMySQLServer(const Value: string);
begin
  if FMySQLServer <> Value then begin
    FMySQLServer := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TRemoteDatabase.SetSiteCode(const Value: string);
begin
  if FSiteCode <> Value then begin
    FSiteCode := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

end.
