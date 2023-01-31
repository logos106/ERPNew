unit PrefsConfigListObj;

interface

uses
  contnrs;

type

 TPrefConfigItem = class
 private
 protected
   fPreferenceName: string;
 public
   constructor Create;
   property PreferenceName: string read fPreferenceName;
   procedure CommitChanges; virtual; abstract;
   procedure RollbackChanges; virtual; abstract;
 end;

 TPrefConfigList = class
 private
   fList: TObjectList;
    function GetItemByName(aItemName: string): TPrefConfigItem;
 public
   constructor Create;
   destructor Destroy; override;
   procedure Add(aItem: TPrefConfigItem);
   property ItemByName[aItemName: string]: TPrefConfigItem read GetItemByName;
   procedure CommitChanges;
   procedure RollbackChanges;
 end;


implementation

uses
  classes, sysutils;

{ TPrefConfigList }

procedure TPrefConfigList.Add(aItem: TPrefConfigItem);
begin
  fList.Add(aItem)
end;

procedure TPrefConfigList.CommitChanges;
var
  x: integer;
begin
  for x := 0 to fList.Count -1 do
    TPrefConfigItem(fList[x]).CommitChanges;
end;

constructor TPrefConfigList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TPrefConfigList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TPrefConfigList.GetItemByName(aItemName: string): TPrefConfigItem;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to fList.Count -1 do begin
    if SameText(TPrefConfigItem(fList[x]).PreferenceName,aItemName) then begin
      result:= TPrefConfigItem(fList[x]);
      break;
    end;
  end;
end;

procedure TPrefConfigList.RollbackChanges;
var
  x: integer;
begin
  for x := 0 to fList.Count -1 do
    TPrefConfigItem(fList[x]).RollbackChanges;
end;

{ TPrefConfigItem }

constructor TPrefConfigItem.Create;
begin
  inherited;
  fPreferenceName:= ClassName;
end;

end.
