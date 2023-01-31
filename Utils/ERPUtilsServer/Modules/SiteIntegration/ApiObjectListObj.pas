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
    function GetPos: integer; virtual;
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
    property Pos: integer read GetPos;
    procedure Append(aItem: TJsonObject); virtual;
  end;

  TApiObjectListMem = class(TApiObjectListBase)
  private
    fCurrentPosition: integer;
    fListType: string;
    fEOF: boolean;
  protected
    function GetAsString: string; override;
    function GetCount: integer; override;
    function GetCurrent: TJsonObject; override;
    function GetListType: string; override;
    procedure SetAsString(const Value: string); override;
    function GetPos: integer; override;
  public
    Json: TJsonObject;
    constructor Create;
    destructor Destroy; override;
    procedure First; override;
    procedure Next; override;
    function BOF: boolean; override;
    function EOF: boolean; override;
    procedure Append(aItem: TJsonObject); override;
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

  TLastChangeTimeRec = class
  public
    LastTime: TDateTime;
    ObjTypeName: string;
    SyncName: string;
    URL: string;
    Database: string;
  end;

  TLastChangeList = class
  private
    List: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetLastChangeTime(aObjType, aSyncName, aURL, aDatabase: string): TDateTime;
    procedure SetLastChangeTime(aChangeTime: TDateTime; aObjType, aSyncName, aURL, aDatabase: string);
  end;

implementation

uses
  classes, sysutils;

{ TApiObjectListBase }

procedure TApiObjectListBase.Append(aItem: TJsonObject);
begin

end;

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

function TApiObjectListBase.GetPos: integer;
begin
  result:= 0;
end;

function TApiObjectListBase.ItemByID(aID: integer): TJsonObject;
var
  CurrentId: integer;
begin
  if Assigned(Current) and Current.IntegerExists('ID') then
    CurrentId:= Current.I['ID']
  else
    CurrentId:= -1;

  result:= nil;
  First;
  if Assigned(Current) then begin
    if not Current.IntegerExists('ID') then
      raise Exception.Create('List for ' + ListType + ' missing field "ID"');
  end;
  while not EOF do begin
    if Current.I['ID'] = aID then begin
      result:= Current;
      break;
    end;
    Next;
  end;

  { reposition back }
  if CurrentId > -1 then begin
    First;
    while not EOF do begin
      if Current.I['ID'] = CurrentId then
        Break
      else
        Next;
    end;
  end;
end;

function TApiObjectListBase.ItemByProp(aPropName,
  aPropValue: string): TJsonObject;
var
  CurrentId: integer;
begin
  if Assigned(Current) and Current.IntegerExists('ID') then
    CurrentId:= Current.I['ID']
  else
    CurrentId:= -1;

  result:= nil;
  if (aPropNAme = '') or (aPropValue = '') then
    exit;
  First;
  if Assigned(Current) then begin
    if not Current.Exists(aPropName) then
      raise Exception.Create('List for ' + ListType + ' missing field "'+aPropName+'"');
  end;
  while not EOF do begin
    if Current.Exists(aPropName) and SameText(Current.ItemByName[aPropName].Value.AsString,aPropValue) then begin
      result:= Current;
      break;
    end;
    Next;
  end;

  { reposition back }
  if CurrentId > -1 then begin
    First;
    while not EOF do begin
      if Current.I['ID'] = CurrentId then
        Break
      else
        Next;
    end;
  end;
end;

procedure TApiObjectListBase.Next;
begin

end;

procedure TApiObjectListBase.SetAsString(const Value: string);
begin

end;

{ TApiObjectListMem }

procedure TApiObjectListMem.Append(aItem: TJsonObject);
begin
  Json.A[ListType].Add(aItem);
end;

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

function TApiObjectListMem.GetPos: integer;
begin
  result:= fCurrentPosition;
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

{ TLastChangeList }

constructor TLastChangeList.Create;
begin
  List:= TObjectList.Create(true);
end;

destructor TLastChangeList.Destroy;
begin
  List.Free;
  inherited;
end;

function TLastChangeList.GetLastChangeTime(aObjType, aSyncName, aURL,
  aDatabase: string): TDateTime;
var
  rec: TLastChangeTimeRec;
  x: integer;
begin
//  TLogger.Inst.Log(aSyncName + ' ' + aObjType + ' ' + aURL + ' ' + aDatabase + ' Count: ' + IntToStr(List.Count));
  result:= 0;
  for x := 0 to List.Count -1 do begin
    rec:= TLastChangeTimeRec(List[x]);
    if SameText(aObjType,rec.ObjTypeName) and
       SameText(aSyncName,rec.SyncName) and
       SameText(aURL,rec.URL) and
       SameText(aDatabase,rec.Database) then begin
      result:= rec.LastTime;
      break;
    end;
  end;
//  TLogger.Inst.Log('  Result: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',result));
end;

procedure TLastChangeList.SetLastChangeTime(aChangeTime: TDateTime; aObjType,
  aSyncName, aURL, aDatabase: string);
var
  rec: TLastChangeTimeRec;
  x: integer;
  found: boolean;
begin
  found:= false;
  for x := 0 to List.Count -1 do begin
    rec:= TLastChangeTimeRec(List[x]);
    if SameText(aObjType,rec.ObjTypeName) and
       SameText(aSyncName,rec.SyncName) and
       SameText(aURL,rec.URL) and
       SameText(aDatabase,rec.Database) then begin
      rec.LastTime:= aChangeTime;
      found:= true;
      break;
    end;
  end;
  if not found then begin
    rec:= TLastChangeTimeRec.Create;
    rec.LastTime:= aChangeTime;
    rec.ObjTypeName:= aObjType;
    rec.SyncName:= aSyncName;
    rec.URL:= aURL;
    rec.Database:= aDatabase;
    List.Add(rec)
  end;
end;

end.
