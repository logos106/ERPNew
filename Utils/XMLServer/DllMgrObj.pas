unit DllMgrObj;

interface

uses
  Contnrs;

type

  TDllMgrItem = class(TObject)
  private
    fDllFileName: string;
    fName: string;
    fHandle: THandle;
  public
    constructor Create;
    destructor Destroy; override;
    property DllFileName: string read fDllFileName write fDllFileName;
    property Name: string read fName write fName;
    property Handle: THandle read fHandle write fHandle;
    procedure Unload;
    function Loaded: boolean;
    function Load: boolean;
  end;


  TDllMgr = class(TObject)
  private
    fList: TObjectList;
    function GetItemByName(aName: string): TDllMgrItem;
    function GetItem(index: integer): TDllMgrItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const aDllFileName, aName: string);
    property ItemByName[aName: string]: TDllMgrItem read GetItemByName;
    property Item[index: integer]: TDllMgrItem read GetItem; default;
    procedure UnloadAll;
  end;

implementation

uses
  windows, sysutils;

{ TDllMgrItem }

constructor TDllMgrItem.Create;
begin
  fHandle:= 0;
end;

destructor TDllMgrItem.Destroy;
begin
  if fHandle <> 0 then
    FreeLibrary(fHandle);
  inherited;
end;

function TDllMgrItem.Load: boolean;
begin
  Unload;
  fHandle:= LoadLibrary(PChar(fdllFileName));
  result:= fHandle <> 0;
end;

function TDllMgrItem.Loaded: boolean;
begin
  result:= fHandle <> 0;
end;

procedure TDllMgrItem.Unload;
begin
  if fHandle <> 0 then begin
    FreeLibrary(fHandle);
    fHandle:= 0;
  end;
end;

{ TDllMgr }

procedure TDllMgr.Add(const aDllFileName, aName: string);
var o: TDllMgrItem;
begin
  o:= TDllMgrItem.Create;
  o.Name:= Lowercase(aName);
  o.DllFileName:= aDllFileName;
  fList.Add(o);
end;

constructor TDllMgr.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TDllMgr.Destroy;
begin
  fList.Free;
  inherited;
end;

function TDllMgr.GetItem(index: integer): TDllMgrItem;
begin
  result:= TDllMgrItem(fList[index]);
end;

function TDllMgr.GetItemByName(aName: string): TDllMgrItem;
var x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if TDllMgrItem(fList[x]).Name = lowerCase(aName) then begin
      result:= TDllMgrItem(fList[x]);
      break;
    end;
  end;
end;

procedure TDllMgr.UnloadAll;
var x: integer;
begin
  for x:= 0 to fList.Count -1 do
    Item[x].Unload;
end;

end.
