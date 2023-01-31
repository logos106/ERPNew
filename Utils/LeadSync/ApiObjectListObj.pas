unit ApiObjectListObj;

interface

uses
  JsonObject, Contnrs;

type

  TApiObjectListBase = class
  private
  protected
    function GetAsString: string; virtual;
    function GetCount: integer; virtual;
    function GetCurrent: TJsonObject; virtual;
    function GetListType: string; virtual;
    procedure SetAsString(const Value: string); virtual;
  public
    property Count: integer read GetCount;
    property Current: TJsonObject read GetCurrent;
    function ItemByID(aID: integer): TJsonObject;
    function ItemByProp(aPropName, aPropValue: string): TJsonObject;
    procedure First; virtual;
    procedure Next; virtual;
    function BOF: boolean; virtual;
    function EOF: boolean; virtual;
    property ListType: string read GetListType;
    property AsString: string read GetAsString write SetAsString;
  end;

  TApiObjectListMem = class(TApiObjectListBase)
  private
    Json: TJsonObject;
    fCurrentPosition: integer;
    fListType: string;
    fEOF: boolean;
  protected
    function GetAsString: string; override;
    function GetCount: integer; override;
    function GetCurrent: TJsonObject; override;
    function GetListType: string; override;
    procedure SetAsString(const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure First; override;
    procedure Next; override;
    function BOF: boolean; override;
    function EOF: boolean; override;
  end;

  TApiObjectListFile = class(TApiObjectListBase)
  private
  protected
    function GetAsString: string; override;
    function GetCount: integer; override;
    function GetCurrent: TJsonObject; override;
    function GetListType: string; override;
    procedure SetAsString(const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure First; override;
    procedure Next; override;
    function BOF: boolean; override;
    function EOF: boolean; override;
  end;

  TApiListStorageType = (lsDefault,lsMemory, lsFile);

  TApiObjectLists = class
  private
    fList: TObjectList;
    fListStorageType: TApiListStorageType;
    function GetListByType(aListType: string): TApiObjectListBase;
  public
    constructor Create(StorageType: TApiListStorageType = lsMemory);
    destructor Destroy; override;
    procedure AddList(aListType: string; Data: string; StorageType: TApiListStorageType = lsDefault);
    property ListByType[aListType: string]: TApiObjectListBase read GetListByType;
    procedure Delete(aListType: string);
    procedure Clear;
  end;

implementation

uses
  classes, sysutils;

{ TApiObjectListBase }

function TApiObjectListBase.BOF: boolean;
begin
  result:= false;
end;

function TApiObjectListBase.EOF: boolean;
begin
  result:= false;
end;

procedure TApiObjectListBase.First;
begin

end;

function TApiObjectListBase.GetAsString: string;
begin

end;

function TApiObjectListBase.GetCount: integer;
begin
  result:= 0;
end;

function TApiObjectListBase.GetCurrent: TJsonObject;
begin
  result:= nil;
end;

function TApiObjectListBase.GetListType: string;
begin

end;

function TApiObjectListBase.ItemByID(aID: integer): TJsonObject;
begin
  result:= nil;
  First;
  if Assigned(Current) then begin
    if not Current.IntegerExists('ID') then
      raise Exception.Create('List for ' + ListType + ' missing field "ID"');
  end;
  while not EOF do begin
    if Current.I['ID'] = aID then begin
      result:= Current;
      exit;
    end;
    Next;
  end;
end;

function TApiObjectListBase.ItemByProp(aPropName,
  aPropValue: string): TJsonObject;
begin
  result:= nil;
  if (aPropNAme = '') or (aPropValue = '') then
    exit;
  First;
  if Assigned(Current) then begin
    if not Current.Exists(aPropName) then
      raise Exception.Create('List for ' + ListType + ' missing field "'+aPropName+'"');
  end;
  while not EOF do begin
    if SameText(Current.ItemByName[aPropName].Value.AsString,aPropValue) then begin
      result:= Current;
      exit;
    end;
    Next;
  end;

end;

procedure TApiObjectListBase.Next;
begin

end;

procedure TApiObjectListBase.SetAsString(const Value: string);
begin

end;

{ TApiObjectListMem }

function TApiObjectListMem.BOF: boolean;
begin
  result:= fCurrentPosition = 0;
end;

constructor TApiObjectListMem.Create;
begin
  Json:= JO;
  fCurrentPosition:= 0;
  fListType:= '';
  fEOF:= true;
end;

destructor TApiObjectListMem.Destroy;
begin
  Json.Free;
  inherited;
end;

function TApiObjectListMem.EOF: boolean;
begin
  result:= fEOF;
//  result:= true;
//  if ListType <> '' then
//    result:= (Count = 0) or (fCurrentPosition = Count -1);
end;

procedure TApiObjectListMem.First;
begin
  fCurrentPosition:= 0;
  fEOF:= Count = 0;
end;

function TApiObjectListMem.GetAsString: string;
begin
  result:= Json.AsString;
end;

function TApiObjectListMem.GetCount: integer;
begin
  result:= 0;
  if ListType <> '' then
    result:= Json.A[ListType].Count;
end;

function TApiObjectListMem.GetCurrent: TJsonObject;
begin
  result:= nil;
  if (ListType <> '') and (Count > 0) then
    result:= Json.A[ListType].Items[fCurrentPosition].AsObject;
end;

function TApiObjectListMem.GetListType: string;
begin
  result:= fListType;
end;

procedure TApiObjectListMem.Next;
begin
  if (ListType <> '') and (fCurrentPosition < (Count -1)) then
    Inc(fCurrentPosition)
  else
    fEOF:= true;
end;

procedure TApiObjectListMem.SetAsString(const Value: string);
begin
  Json.AsString:= Value;
  if Json.Count > 0 then begin
    fListType:= Json.Items[0].Name;
    First;
  end
  else begin
    fListType:= '';
    fEOF:= true;
  end;
end;

{ TApiObjectListFile }

function TApiObjectListFile.BOF: boolean;
begin
  result:= true;
end;

constructor TApiObjectListFile.Create;
begin

end;

destructor TApiObjectListFile.Destroy;
begin

  inherited;
end;

function TApiObjectListFile.EOF: boolean;
begin
  result:= true;
end;

procedure TApiObjectListFile.First;
begin
  inherited;

end;

function TApiObjectListFile.GetAsString: string;
begin

end;

function TApiObjectListFile.GetCount: integer;
begin
  result:= 0;
end;

function TApiObjectListFile.GetCurrent: TJsonObject;
begin
  result:= nil
end;

function TApiObjectListFile.GetListType: string;
begin

end;

procedure TApiObjectListFile.Next;
begin
  inherited;

end;

procedure TApiObjectListFile.SetAsString(const Value: string);
begin
  inherited;

end;

{ TApiObjectLists }

procedure TApiObjectLists.AddList(aListType, Data: string; StorageType: TApiListStorageType = lsDefault);
var
  List: TApiObjectListBase;
begin
  if StorageType = lsDefault then begin
    if fListStorageType = lsMemory then
      List:= TApiObjectListMem.Create
    else
      List:= TApiObjectListFile.Create;
  end
  else begin
    if StorageType = lsMemory then
      List:= TApiObjectListMem.Create
    else
      List:= TApiObjectListFile.Create;
  end;
  List.AsString:= Data;
  fList.Add(List);
end;

procedure TApiObjectLists.Clear;
begin
  fList.Clear;
end;

constructor TApiObjectLists.Create(StorageType: TApiListStorageType = lsMemory);
begin
  fListStorageType:= StorageType;
  if fListStorageType = lsDefault then
    fListStorageType:= lsMemory;
  fList:= TObjectList.Create(true);
end;

procedure TApiObjectLists.Delete(aListType: string);
var
  x: integer;
begin
  for x := 0 to fList.Count -1 do begin
    if SameText(TApiObjectListBase(fList[x]).ListType,aListType) then begin
      fList.Delete(x);
      exit;
    end;
  end;
end;

destructor TApiObjectLists.Destroy;
begin
  fList.Free;
  inherited;
end;

function TApiObjectLists.GetListByType(aListType: string): TApiObjectListBase;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to fList.Count -1 do begin
    if SameText(TApiObjectListBase(fList[x]).ListType,aListType) then begin
      result:= TApiObjectListBase(fList[x]);
      exit;
    end;
  end;
end;

end.
