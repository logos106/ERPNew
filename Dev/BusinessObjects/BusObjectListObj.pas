unit BusObjectListObj;

interface

uses
  contnrs;

type
  TBusObjInfoOption = (boImport,boExport);
  TBusObjInfoOptions = set of TBusObjInfoOption;

  TBusObjectInfo = class
  public
    Name: string;
    BusObjClassName: string;
    ListFormClassName: string;
    Options: TBusObjInfoOptions;
    constructor Create;
  end;

  TObjInfoList = class
  private
    List: TObjectList;
    function GetCount: integer;
    function GetItem(index: integer): TBusObjectInfo;
    function GetItemByBusObjClassName(const aClassName: string): TBusObjectInfo;
    function GetItemByName(const aName: string): TBusObjectInfo;
    function Exists(aBusObjClassName: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Items[index: integer]: TBusObjectInfo read GetItem;
    property ItemByName[const aName: string]: TBusObjectInfo read GetItemByName;
    property ItemByBusObjClassName[const aClassName: string]: TBusObjectInfo read GetItemByBusObjClassName;
    procedure Add(const aName, aClassName: string; aListFormClassName: string = '';
      aOptions: TBusObjInfoOptions = [boImport,boExport]);
    function NameList(sorted: boolean = true; IncludeOptions: TBusObjInfoOptions = []): string;
  end;

  TBusObjInfoList = class(TObjInfoList)
    Private
    Protected
    Public
      class function Inst: TBusObjInfoList;
  end;

  TScheduledReportObjInfoList = class(TObjInfoList)
    Private
    Protected
    Public
      class function Inst: TScheduledReportObjInfoList;
  end;

implementation

uses
  sysutils, classes;

var
  fBusObjInfoList: TBusObjInfoList;
  fScheduledReportObjInfoList: TScheduledReportObjInfoList;

{ TObjInfoList }

procedure TObjInfoList.Add(const aName, aClassName: string;
  aListFormClassName: string = '';
  aOptions: TBusObjInfoOptions = [boImport,boExport]);
var
  info: TBusObjectInfo;
begin
  if not Exists(aClassName) then begin
    info:= TBusObjectInfo.Create;
    info.Name:= aName;
    info.BusObjClassName:= aClassName;
    info.ListFormClassName:= aListFormClassName;
    info.Options:= aOptions;
    List.Add(info);
  end;
end;

constructor TObjInfoList.Create;
begin
  List:= TObjectList.Create(true);
end;

destructor TObjInfoList.Destroy;
begin
  List.Free;
  inherited;
end;

function TObjInfoList.Exists(aBusObjClassName: string): boolean;
begin
  result:= Assigned(ItemByBusObjClassName[aBusObjClassName]);
end;

function TObjInfoList.GetCount: integer;
begin
  result:= List.Count;
end;

function TObjInfoList.GetItem(index: integer): TBusObjectInfo;
begin
  result:= TBusObjectInfo(List[index]);
end;

function TObjInfoList.GetItemByBusObjClassName(
  const aClassName: string): TBusObjectInfo;
var
  x: integer;
  info: TBusObjectInfo;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    info:= Items[x];
    if SameText(info.ListFormClassName, aClassName) then begin
      result:= info;
      break;
    end;
  end;
end;

function TObjInfoList.GetItemByName(const aName: string): TBusObjectInfo;
var
  x: integer;
  info: TBusObjectInfo;
begin
  result:= nil;
  for x:= 0 to Count -1 do begin
    info:= Items[x];
    if SameText(info.Name, aName) then begin
      result:= info;
      break;
    end;
  end;
end;

class function TBusObjInfoList.Inst: TBusObjInfoList;
begin
  if not Assigned(fBusObjInfoList) then
    fBusObjInfoList:= TBusObjInfoList.Create;
  result:= fBusObjInfoList;
end;

function TObjInfoList.NameList(sorted: boolean = true;
  IncludeOptions: TBusObjInfoOptions = []): string;
var
  sl: TStringList;
  x: integer;
  info: TBusObjectInfo;
begin
  sl:= TStringList.Create;
  try
    for x := 0 to Count -1 do begin
      info:= Items[x];
      if (IncludeOptions = []) or (IncludeOptions * info.Options <> []) then
        sl.Add(info.Name);
    end;
    if sorted then
      sl.Sort;
  finally
    result:= sl.CommaText;
    sl.Free;
  end;
end;

{ TBusObjectInfo }

constructor TBusObjectInfo.Create;
begin
  Options:= [];
end;

{ TScheduledReportObjInfoList }

class function TScheduledReportObjInfoList.Inst: TScheduledReportObjInfoList;
begin
  if not Assigned(fScheduledReportObjInfoList) then
    fScheduledReportObjInfoList:= TScheduledReportObjInfoList.Create;
  result:= fScheduledReportObjInfoList;
end;

initialization

finalization
  fBusObjInfoList.Free;
  fBusObjInfoList:= nil;

  fScheduledReportObjInfoList.Free;
  fScheduledReportObjInfoList:= nil;

end.
