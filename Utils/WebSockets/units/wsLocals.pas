unit wsLocals;

interface
uses
  Classes, Sysutils, sgcWebSocket_Classes;

type
  TwsLocals = class
  private
    fList: TStringList;
    function GetByGuid(const aGuid: string): TsgcWSConnection;
    function GetByName(const aName: string): TsgcWSConnection;
    function GetCount: integer;
  protected
    function IndexOf(const aGUID : string) : integer;
    property List : TStringList read fList write fList;
  public
    constructor Create;
    destructor Destroy; override;

    function DeleteByName(const aName : string) : boolean;
    function DeleteByGUID(const aGuid : string) : boolean;
    procedure Add(const aName : string; AConnection : TsgcWSConnection);

    property Count : integer read GetCount;
    property ByName[const aName : string] : TsgcWSConnection read GetByName;
    property ByGUID[const aGuid : string] : TsgcWSConnection read GetByGuid;
  end;

implementation

{ TwsLocals }

procedure TwsLocals.Add(const aName: string; AConnection: TsgcWSConnection);
begin
  List.AddObject(aName, AConnection);
end;

constructor TwsLocals.Create;
begin
  inherited;
  List := TStringList.Create;
  List.CaseSensitive := false;
  List.Sorted := true;
end;

function TwsLocals.DeleteByGUID(const aGuid: string): boolean;
var
  idx : integer;
begin
  idx := IndexOf(aGuid);
  Result := idx >= 0;
  if Result then
    List.Delete(idx);
end;

function TwsLocals.DeleteByName(const aName: string): boolean;
var
  idx : integer;
begin
  idx := List.IndexOf(aName);
  Result := idx >= 0;
  if Result then
    List.Delete(idx);
end;

destructor TwsLocals.Destroy;
begin
  List.Free;
  inherited;
end;

function TwsLocals.GetByGuid(const aGuid: string): TsgcWSConnection;
var
  idx : integer;
begin
  idx := IndexOf(aGuid);
  if idx >= 0 then
    Result := TsgcWSConnection(List.Objects[idx])
  else
   Result := nil;
end;

function TwsLocals.GetByName(const aName: string): TsgcWSConnection;
var
  idx : integer;
begin
  Result := nil;
  idx := List.IndexOf(aName);
  if idx >= 0 then
    Result := TsgcWSConnection(List.Objects[idx]);
end;

function TwsLocals.GetCount: integer;
begin
  Result := List.Count;
end;

function TwsLocals.IndexOf(const aGUID: string): integer;
var
  idx : integer;
begin
  for idx := 0 to Count - 1 do
    if TsgcWSConnection(List.Objects[idx]).guid = aGUID then
    begin
      Result := idx;
      exit;
    end;
  Result := -1;
end;

end.
