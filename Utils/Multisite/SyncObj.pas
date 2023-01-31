unit SyncObj;

interface

uses
  contnrs, JSONObject, ValueFields;

type

  TSyncObj = class
  private
    fName: string;
    fStruct: TJSONObject;
    fList: TObjectList;
    fFields: TValueFieldList;
    fParent: TSyncObj;
    fRefObj: TSyncObj;
    function GetCount: integer;
    function GetItem(idx: integer): TSyncObj;
    function GetItemByName(aName: string): TSyncObj;
    function GetFields: TValueFieldList;
    function GetIsRefObject: boolean;
    procedure SetRefObj(const Value: TSyncObj);
    function GetName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read GetName write fName;
    property Struct: TJSONObject read fStruct;
    property Items[idx: integer]: TSyncObj read GetItem;
    property ItemByName[aName: string]: TSyncObj read GetItemByName;
    function IndexOf(Obj: TSyncObj): integer;
    function Add(aItem: TSyncObj): integer;
    property Count: integer read GetCount;
    procedure Clear;
    property Fields: TValueFieldList read GetFields;
    property IsRefObject: boolean read GetIsRefObject;
    property Parent: TSyncObj read fParent write fParent;
    property RefObj: TSyncObj read fRefObj write SetRefObj;
    procedure Delete(idx: integer);
  end;

implementation

uses
  SysUtils;

{ TSyncObj }

function TSyncObj.Add(aItem: TSyncObj): integer;
begin
  result:= fList.Add(aItem);
end;

procedure TSyncObj.Clear;
begin
  fList.Clear;
end;

constructor TSyncObj.Create;
begin
  fStruct:= TJSONObject.Create;
  fList:= TObjectList.Create(true);
  fRefObj:= nil;
end;

destructor TSyncObj.Destroy;
begin
  fList.Free;
  fStruct.Free;
  fFields.Free;
  inherited;
end;

function TSyncObj.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSyncObj.GetItem(idx: integer): TSyncObj;
begin
  result:= TSyncObj(fList[idx]);
end;

function TSyncObj.GetItemByName(aName: string): TSyncObj;
var
  x: integer;
  s: string;
begin
  result:= nil;
  s:= Lowercase(aName);
  for x:= 0 to Count -1 do begin
    if Lowercase(Items[x].Name) = s then begin
      result:= Items[x];
      break;
    end;
  end;
end;

function TSyncObj.GetFields: TValueFieldList;
begin
  if not Assigned(fFields) then
    fFields:= TValueFieldList.Create;
  result:= fFields;
end;

function TSyncObj.GetIsRefObject: boolean;
begin
  result:= Assigned(fRefObj);
end;

procedure TSyncObj.SetRefObj(const Value: TSyncObj);
begin
  fRefObj := Value;
end;

function TSyncObj.GetName: string;
var s: string;
begin
  Result := fName;
  if result = '' then begin
    if Struct.Exists('ClassName') then begin
      s:= Struct.StringByName['ClassName'];
      result:= Copy(s,2,Length(s));
    end;  
  end;
end;

function TSyncObj.IndexOf(Obj: TSyncObj): integer;
begin
  result:= fList.IndexOf(Obj);
end;

procedure TSyncObj.Delete(idx: integer);
begin
  fList.Delete(idx);
end;

end.
