unit DbConnectopnPoolObj;

interface

// http://edn.embarcadero.com/article/30027

uses
  ERPDbComponents, SyncObjs, Classes;

type

  IConnection = Interface(IInterface)
    function Connection: TERPConnection;
    function GetRefCount: Integer;
    function GetLastAccess: TDateTime;
    property LastAccess: TDateTime read GetLastAccess;
    property RefCount: Integer read GetRefCount;
  end;

  //This provides the implementation
  //of the IConnection interface. To use a data access
  //mechanism other than dbExpress, modify the components
  //that appear on this data module, and change the class
  //of the Connection function in the IConnection interface
  //as well as in this class.
  TConnectionModule = class(TObject, IConnection)
  private
    fConnection: TERPConnection;
    { Private declarations }
  protected
    FRefCount: Integer;
    FLastAccess: TDateTime;
    //When the data module is created the
    //connection pool that creates the data module
    //will assign its critical section to this field.
    //The data module will use this critical section
    //to synchronize access to its reference count.
    CriticalSection: TCriticalSection;
    //This semaphore points to the FixedConnectionPool's
    //semaphore. It will be used to call ReleaseSemaphore
    //from the _Release method of the TDataModule.
    Semaphore: THandle;
    //These two static methods are reintroduced
    //in order to implement lifecycle management
    //for the interface of this object.
    //Normally, unlike normal COM objects, Delphi
    //TComponent descendants are not lifecycle managed
    //when used in interface references.
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IConnection methods}
    function GetLastAccess: TDateTime;
    function GetRefCount: Integer;
  public
    { Public declarations }
    {IConnection method}
    //CHANGE
    //To use a connection of another type, change the
    //return type of the Connection function
    function Connection: TERPConnection;
  end;

  TCleanupThread = class;

  //This is the class that manages the connection pool
  TFixedConnectionPool = class(TObject)
  private
    FPool: array of IConnection;
    FPoolSize: Integer;
    FTimeout: Int64;
    CleanupThread: TCleanupThread;
    //This semaphore is used to limit the number of
    //simultaneous connections. When the nth+1 connection
    //is requested, it will be blocked until a connection
    //becomes available.
    Semaphore: THandle;
    //This is the critical section that synchronizes
    //access to the connection module reference counts
    CriticalSection: TCriticalSection;
  public
    //This overloaded constructor takes two optional
    //parameters. These parameters specify the size
    //of the connection pool, as well as how long idle
    //connections in the connection pool will be kept.
    constructor Create(const PoolSize: Integer = 10;
      const CleanupDelayMinutes: Integer = 5;
      const Timeoutms: Int64 = 10000); overload;
    destructor Destroy; override;
    //This function returns an object
    //that implements the IConnection interface.
    //This object can be a data module, as was
    //done in this example.
    function GetConnection: IConnection;
  end;

  //This thread class is used by the connection pool
  //object to cleanup idle connections after a
  //configurable period of time.
  TCleanupThread = class(TThread)
  private
    FCleanupDelay: Integer;
  protected
    //When the thread is created, this critical section
    //field will be assigned the connection pool's
    //critical section. This critical section is
    //used to synchronize access to data module
    //reference counts.
    CriticalSection: TCriticalSection;
    FixedConnectionPool: TFixedConnectionPool;
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean;
      const CleanupDelayMinutes: Integer);
  end;

(* USAGE EXAMPLE

  var
    ConnPool: TFixedConnectionPool;

  begin
    ConnPool := TFixedConnectionPool.Create(10, 5, 20000);


  var
    SQLDataSet: TSQLDataSet;
    Conn: IConnection;
  begin
    SQLDataSet := TSQLDataSet.Create(nil);
    try
      SQLDataSet.CommandText := 'select * from employee';
      Conn := ConnPool.GetConnection;
      SQLDataSet.SQLConnection := Conn.Connection;
      SQLDataSet.Open;
      //do something with the result
    finally
      SQLDataSet.Free;
    end;
  //The connection is released when Conn goes out of scope

end;

*)

implementation

uses
  SysUtils, Windows, DateUtils;

{ TConnectionModule }

function TConnectionModule.Connection: TERPConnection;
begin

end;

function TConnectionModule.GetLastAccess: TDateTime;
begin

end;

function TConnectionModule.GetRefCount: Integer;
begin

end;

function TConnectionModule._AddRef: Integer;
begin
  //increment the reference count
  CriticalSection.Enter;
  try
    Inc(FRefCount);
    Result := FRefCount;
  finally
    CriticalSection.Leave;
  end;
end;

function TConnectionModule._Release: Integer;
begin
//decrement the reference count
  CriticalSection.Enter;
  try
    Dec(FRefCount);
    Result := FRefCount;
    //if not more references, call Destroy
    if Result = 0 then
      Destroy
    else
      Self.FLastAccess := Now;
  finally
    CriticalSection.Leave;
    if FRefCount = 1 then
      ReleaseSemaphore(Semaphore, 1, nil);
end;end;

{ TFixedConnectionPool }

constructor TFixedConnectionPool.Create(const PoolSize,
  CleanupDelayMinutes: Integer; const Timeoutms: Int64);
begin
  FPoolSize := PoolSize;
  FTimeout := Timeoutms;
  Semaphore := CreateSemaphore(nil, PoolSize, PoolSize, '');
  CriticalSection := TCriticalSection.Create;
  //Set the length of the connection pool
  SetLength(FPool, PoolSize);
    //Create and start the cleanup thread
  CleanupThread := TCleanupThread.Create(True,
    CleanupDelayMinutes);
  with CleanupThread do
  begin
    FreeOnTerminate := True;
    Priority := tpLower;
    FixedConnectionPool := Self;
    Resume;
  end;
end;

destructor TFixedConnectionPool.Destroy;
var
  i: Integer;
begin
  //Free any remaining connections
  CleanupThread.Terminate;
  CriticalSection.Enter;
  try
    for i := Low(FPool) to High(FPool) do
      FPool[i] := nil;
    SetLength(FPool,0);
  finally
    CriticalSection.Leave;
  end;
  CriticalSection.Free;
  //Release the semaphore
  CloseHandle(Semaphore);
  inherited;
end;

function TFixedConnectionPool.GetConnection: IConnection;
var
  i: Integer;
  DM: TConnectionModule;
  WaitResult: Integer;
begin
  Result := nil;
  WaitResult := WaitForSingleObject(Semaphore, FTimeout);
  if WaitResult <> WAIT_OBJECT_0 then
    raise Exception.Create('Connection pool timeout. '+
      'Cannot obtain a connection');
  CriticalSection.Enter;
  try
    for i := Low(FPool) to High(FPool) do
      begin
        //If FPool[i] = nil, the IConnection has
        //not yet been created. Create it, initialize
        //it, and return it. If FPool[i] <> nil, then
        //check to see if its RefCount = 1 (only the pool
        //is referencing the object).
        if FPool[i] = nil then
          begin
            DM := TConnectionModule.Create(nil);
            DM.CriticalSection := Self.CriticalSection;
            DM.Semaphore := Self.Semaphore;
            FPool[i] := DM;
            FPool[i].Connection.Connected := True;
            Result := FPool[i];
            Exit;
          end;
        //if FPool[i].FRefCount = 1 then
        //the connection is available. Return it.
        if FPool[i].RefCount = 1 then
          begin
            Result := FPool[i];
            Exit;
          end;
      end; //for
  finally
    CriticalSection.Leave;
  end;
end;

{ TCleanupThread }

constructor TCleanupThread.Create(CreateSuspended: Boolean;
  const CleanupDelayMinutes: Integer);
begin
  // always create suspended
  inherited Create(True); // always create suspended
  FCleanupDelay := CleanupDelayMinutes;
  //Resume if not created suspended
  if not CreateSuspended then
    Resume;
end;

procedure TCleanupThread.Execute;
var
  i: Integer;
begin
  while True do
  begin
    if Terminated then Exit;
    //sleep for delay
    sleep(FCleanupDelay * 1000 * 60);
    if Terminated then Exit;
    FixedConnectionPool.CriticalSection.Enter;
    try
      for i := low(FixedConnectionPool.FPool) to
        High(FixedConnectionPool.FPool) do
        //if the connection exists, has no external reference,
        //and has not been used lately, release it
        if (FixedConnectionPool.FPool[i] <> nil) and
          (FixedConnectionPool.FPool[i].RefCount = 1) and
          (MinutesBetween(FixedConnectionPool.FPool[i].LastAccess, Now) >
            FCleanupDelay) then
            FixedConnectionPool.FPool[i] := nil;
    finally
      FixedConnectionPool.CriticalSection.Leave;
    end;//try
  end;//while
end;

end.
