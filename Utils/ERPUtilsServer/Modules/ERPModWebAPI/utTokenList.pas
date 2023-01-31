unit utTokenList;

interface

uses
  classes;

const
  DEFAULT_TOKEN_EXPIRE_MINUTES = 120;

type

  TTokenRec = class(TObject)
  private
    fToken: string;
    fExpires: TDateTime;
    fDatabaseDirectory: string;
    fUsername: string;
    fPassword: string;
  published

  public
    property Token: string read fToken write fToken;
    property DatabaseDirectory: string read fDatabaseDirectory write fDatabaseDirectory;
    property Username: string read fUsername write fUsername;
    property Password: string read fPassword write fPassword;
    property Expires: TDateTime read fExpires write fExpires;
  end;

  TTokenValidationResult = (tvValid, tvExpired, tvNotFound);

  TTokenListWorker = class;
  TTokenList = class(TObject)
  private
    fWorker: TTokenListWorker;
    fList: TThreadList;
  public
    constructor Create;
    destructor Destroy; override;
    function NewToken(const aDatabaseDirectory, aUsername, aPassword: string; ExpireMinutes: integer = DEFAULT_TOKEN_EXPIRE_MINUTES): string;
    function Validate(const aToken: string; var aDatabaseDirectory, aUsername, aPassword: string): TTokenValidationResult;
    procedure DeleteExpired(ExpiredByMinutes: integer = 0);
  end;

  TTokenListWorker = class(TThread)
  private
    dt: TDateTime;
    fTokenList: TTokenList;
  protected
    procedure Execute; override;
  public
    constructor Create(aTokenList: TTokenList);
  end;

  function TokenList: TTokenList;

implementation

uses
  SysUtils, DateTimeUtils, DateUtils, RandomUtils;

var
  fTokenList: TTokenList;

function TokenList: TTokenList;
begin
  if not Assigned(fTokenList) then
    fTokenList := TTokenList.Create;
  result := fTokenList;
end;

{ TTokenList }

constructor TTokenList.Create;
begin
  fList := TThreadList.Create;
  fWorker := TTokenListWorker.Create(self);
  fWorker.FreeOnTerminate := true;
end;

procedure TTokenList.DeleteExpired(ExpiredByMinutes: integer);
var
  lst: TList;
  I: integer;
begin
  lst := fList.LockList;
  try
    I := 0;
    while I < lst.Count do begin
      if (TTokenRec(lst[I]).Expires + (ExpiredByMinutes * OneMinute)) < NowUtc  then
        lst.Delete(I)
      else
        Inc(I);
    end;
  finally
    fList.UnlockList;
  end;
end;

destructor TTokenList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TTokenList.NewToken(const aDatabaseDirectory, aUsername, aPassword: string;
  ExpireMinutes: integer): string;
var
  lst: TList;
  I: integer;
  rec: TTokenRec;
begin
  if aDatabaseDirectory = '' then
    raise Exception.Create(Classname + ' - DatabaseDirectory is blank');
  if aUsername = '' then
    raise Exception.Create(Classname + ' - Username is blank');
  if aPassword = '' then
    raise Exception.Create(Classname + ' - Password is blank');

  lst := fList.LockList;
  try
    I := 0;
    { delete any existing for this database and user .. }
    while I < lst.Count do begin
      if SameText(TTokenRec(lst[I]).DatabaseDirectory, aDatabaseDirectory) and SameText(TTokenRec(lst[I]).Username, aUsername) then
        lst.Delete(I)
      else
        Inc(I);
    end;
    { create new .. }
    rec := TTokenRec.Create;
    rec.DatabaseDirectory := aDatabaseDirectory;
    rec.Username := aUsername;
    rec.Password := aPassword;
    rec.Token := MakeRandomString(24);
    rec.Expires := NowUTC + (ExpireMinutes * OneMinute);
    result := rec.Token;
  finally
    fList.UnlockList;
  end;
  fList.Add(rec);
end;

function TTokenList.Validate(const aToken: string; var aDatabaseDirectory,
  aUsername, aPassword: string): TTokenValidationResult;
var
  lst: TList;
  I: Integer;
begin
  result := tvNotFound;
  lst := fList.LockList;
  try
    for I := 0 to lst.Count -1 do begin
      if TTokenRec(lst[I]).Token = aToken then begin
        if TTokenRec(lst[I]).Expires < NowUTC then
          result := tvExpired
        else begin
          result := tvValid;
          aDatabaseDirectory := TTokenRec(lst[I]).DatabaseDirectory;
          aUsername := TTokenRec(lst[I]).Username;
          aPassword := TTokenRec(lst[I]).Password;
        end;
        exit;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

{ TTokenListWorker }

constructor TTokenListWorker.Create(aTokenList: TTokenList);
begin
  dt := now + (OneMinute * 5);
  fTokenList := aTokenList;
  inherited Create(false);
end;

procedure TTokenListWorker.Execute;
begin
  inherited;
  while not terminated do begin
    try
      sleep(500);
      if now >= dt then begin
        dt := now + (OneMinute * 5);
        fTokenList.DeleteExpired(8 * 60);
      end;
    except
    end;
  end;
end;

initialization
  fTokenList := nil;

finalization
  fTokenList.Free;


end.
