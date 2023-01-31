unit SyncConfigObj;

interface

uses
  Classes;

type

  IDirtyObject = interface(IInterface)
    function GetDirty: boolean;
    procedure SetDirty(aValue: boolean);
    property Dirty: boolean read GetDirty write SetDirty;
  end;

  TOnNotifyEvent = procedure(Item: TCollectionItem; Action: TCollectionNotification) of object;
  TNotifyCollection = class(TCollection)
  private
    fOnNotify: TOnNotifyEvent;
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    property OnNotify: TOnNotifyEvent read fOnNotify write fOnNotify;
  end;

  TSyncDatabaseConfig = class;
  TSyncConfig = class(TComponent, IDirtyObject)
  private
    FMySQLServer: string;
    fDatabaseList: TNotifyCollection;
    fDirty: boolean;
    function GetDirty: boolean;
    procedure SetDirty(aValue: boolean);
    procedure SetMySQLServer(const Value: string);
    function GetDatabase(idx: integer): TSyncDatabaseConfig;
    procedure DoOnNotify(Item: TCollectionItem; Action: TCollectionNotification);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Dirty: boolean read GetDirty write SetDirty;
    property Databases[idx: integer]: TSyncDatabaseConfig read GetDatabase;
    function DatabaseByName(aName: string): TSyncDatabaseConfig;
    function Add: TSyncDatabaseConfig;
  published
    property MySQLServer: string read FMySQLServer write SetMySQLServer;
    property DatabaseList: TNotifyCollection read fDatabaseList;
  end;

  TSyncSiteItem = class;
  TSyncDatabaseConfig = class(TCollectionItem)
  private
    fDirty: boolean;
    fSiteList: TNotifyCollection;
    FSynchronizationActive: boolean;
    FDatabaseName: string;
    FCheckInterval: TDateTime;
    function GetDirty: boolean;
    procedure SetDirty(aValue: boolean);
    procedure SetCheckInterval(const Value: TDateTime);
    procedure SetDatabaseName(const Value: string);
    procedure SetSynchronizationActive(const Value: boolean);
    procedure DoOnNotify(Item: TCollectionItem; Action: TCollectionNotification);
    function GetSite(idx: integer): TSyncSiteItem;
    function GetCaption: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Dirty: boolean read GetDirty write SetDirty;
    function Add: TSyncSiteItem;
    function SiteByCode(aSiteCode: string): TSyncSiteItem;
    property Sites[idx: integer]: TSyncSiteItem read GetSite;
    property Caption: string read GetCaption;
  published
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property CheckInterval: TDateTime read FCheckInterval write SetCheckInterval;
    property SynchronizationActive: boolean read FSynchronizationActive write SetSynchronizationActive;
    property SiteList: TNotifyCollection read fSiteList;
  end;

  TSyncSiteItem = class(TCollectionItem)
  private
    fDirty: boolean;
    FSiteCode: string;
    FDatabaseName: string;
    FMySQLServer: string;
    function GetDirty: boolean;
    procedure SetDatabaseName(const Value: string);
    procedure SetDirty(const Value: boolean);
    procedure SetMySQLServer(const Value: string);
    procedure SetSiteCode(const Value: string);
    function GetCaption: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Dirty: boolean read GetDirty write SetDirty;
    property Caption: string read GetCaption;
  published
    property SiteCode: string read FSiteCode write SetSiteCode;
    property MySQLServer: string read FMySQLServer write SetMySQLServer;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
  end;

implementation

uses
  sysutils;

{ TNotifyCollection }

procedure TNotifyCollection.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;
  if Assigned(fOnNotify) then
    fOnNotify(Item, Action);
end;

{ TSyncConfig }

function TSyncConfig.Add: TSyncDatabaseConfig;
begin
  result:=  TSyncDatabaseConfig(fDatabaseList.Add);
end;

constructor TSyncConfig.Create;
begin
  inherited;
  fDirty:= false;
  fDatabaseList:= TNotifyCollection.Create(TSyncDatabaseConfig);
  fDatabaseList.OnNotify:= self.DoOnNotify;
end;

function TSyncConfig.DatabaseByName(aName: string): TSyncDatabaseConfig;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.DatabaseList.Count -1 do begin
    if Lowercase(self.Databases[x].DatabaseName) = Lowercase(aName) then begin
      result:= self.Databases[x];
      exit;
    end;
  end;
end;

destructor TSyncConfig.Destroy;
begin
  fDatabaseList.Free;
  inherited;
end;

procedure TSyncConfig.DoOnNotify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  fDirty:= true;
end;

function TSyncConfig.GetDatabase(idx: integer): TSyncDatabaseConfig;
begin
  result:= TSyncDatabaseConfig(fDatabaseList.Items[idx]);
end;

function TSyncConfig.GetDirty: boolean;
var
  x: integer;
begin
  result:= fDirty;
  if not fDirty then begin
    for x:= 0 to fDatabaseList.Count -1 do begin
      if TSyncDatabaseConfig(fDatabaseList.Items[x]).Dirty then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

procedure TSyncConfig.SetDirty(aValue: boolean);
var
  x: integer;
begin
  fDirty:= aValue;
  for x:= 0 to fDatabaseList.Count -1 do begin
    TSyncDatabaseConfig(fDatabaseList.Items[x]).Dirty := aValue;
  end;
end;

procedure TSyncConfig.SetMySQLServer(const Value: string);
begin
  if FMySQLServer <> Value then begin
    FMySQLServer := Value;
    Name:= Value;
    fDirty:= true;
  end;
end;

{ TSyncDatabaseConfig }

function TSyncDatabaseConfig.Add: TSyncSiteItem;
begin
  result:=  TSyncSiteItem(self.fSiteList.Add);
end;

constructor TSyncDatabaseConfig.Create(Collection: TCollection);
begin
  inherited;
  fDirty:= false;
  fSiteList:= TNotifyCollection.Create(TSyncSiteItem);
  fSiteList.OnNotify:= self.DoOnNotify;
end;

destructor TSyncDatabaseConfig.Destroy;
begin
  fSiteList.Free;
  inherited;
end;

procedure TSyncDatabaseConfig.DoOnNotify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  fDirty:= true;
end;

function TSyncDatabaseConfig.GetCaption: string;
begin
  result:= 'Sync Database - [' + FDatabaseName + ']';
end;

function TSyncDatabaseConfig.GetDirty: boolean;
var
  x: integer;
begin
  result:= fDirty;
  if not fDirty then begin
    for x:= 0 to fSiteList.Count -1 do begin
      if TSyncSiteItem(fSiteList.Items[x]).Dirty then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

function TSyncDatabaseConfig.GetSite(idx: integer): TSyncSiteItem;
begin
  result:= TSyncSiteItem(SiteList.Items[idx]);
end;

procedure TSyncDatabaseConfig.SetCheckInterval(const Value: TDateTime);
begin
  if FCheckInterval <> Value then begin
    FCheckInterval := Value;
    fDirty:= true;
  end;
end;

procedure TSyncDatabaseConfig.SetDatabaseName(const Value: string);
begin
  if FDatabaseName <> Value then begin
    FDatabaseName := Value;
    fDirty:= true;
  end;
end;

procedure TSyncDatabaseConfig.SetDirty(aValue: boolean);
var
  x: integer;
begin
  fDirty:= aValue;
  for x:= 0 to fSiteList.Count -1 do begin
    TSyncSiteItem(fSiteList.Items[x]).Dirty := aValue;
  end;
end;

procedure TSyncDatabaseConfig.SetSynchronizationActive(
  const Value: boolean);
begin
  if FSynchronizationActive <> Value then begin
    FSynchronizationActive := Value;
    fDirty:= true;
  end;
end;

function TSyncDatabaseConfig.SiteByCode(aSiteCode: string): TSyncSiteItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.fSiteList.Count -1 do begin
    if Lowercase(TSyncSiteItem(fSiteLIst.Items[x]).SiteCode) = Lowercase(aSiteCode) then begin
      result:= TSyncSiteItem(fSiteLIst.Items[x]);
      exit;
    end;
  end;
end;

{ TSyncSiteItem }

constructor TSyncSiteItem.Create(Collection: TCollection);
begin
  inherited;
  fDirty:= false;
end;

destructor TSyncSiteItem.Destroy;
begin

  inherited;
end;

function TSyncSiteItem.GetCaption: string;
begin
  result:= 'Remote Site - [' + FDatabaseName + '@' + FMySQLServer + ']';
end;

function TSyncSiteItem.GetDirty: boolean;
begin
  result:= fDirty;
end;

procedure TSyncSiteItem.SetDatabaseName(const Value: string);
begin
  if FDatabaseName <> Value then begin
    FDatabaseName := Value;
    fDirty:= true;
//    Name:= FDatabaseName + '@' + FMySQLServer;
  end;
end;

procedure TSyncSiteItem.SetDirty(const Value: boolean);
begin
  fDirty:= false;
end;

procedure TSyncSiteItem.SetMySQLServer(const Value: string);
begin
  if FMySQLServer <> Value then begin
    FMySQLServer := Value;
    fDirty:= true;
//    Name:= FDatabaseName + '@' + FMySQLServer;
  end;
end;

procedure TSyncSiteItem.SetSiteCode(const Value: string);
begin
  if FSiteCode <> Value then begin
    FSiteCode := Value;
    fDirty:= true;
  end;  
end;

end.
