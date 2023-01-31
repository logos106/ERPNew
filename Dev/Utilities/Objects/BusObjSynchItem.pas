unit BusObjSynchItem;

interface

uses
  BusObjBase, classes;

type
  TSynchItem = class(TMSBusObj)
  private
    function GetItemData: string;
    function GetItemID: integer;
    function GetItemMsTimeStamp: TDateTime;
    function GetItemMsUpdateSiteCode: string;
    function GetItemType: string;
    procedure SetItemData(const Value: string);
    procedure SetItemID(const Value: integer);
    procedure SetItemMsTimeStamp(const Value: TDateTime);
    procedure SetItemMsUpdateSiteCode(const Value: string);
    procedure SetItemType(const Value: string);
  published
  Public
    Class Function GetIDField: string; Override;
    Class Function GetBusObjectTablename: String; Override;
    Destructor Destroy; Override;
    Constructor Create(AOwner: TComponent); Override;
    function Save: boolean; override;
  published
    property ItemType: string read GetItemType write SetItemType;
    property ItemID: integer read GetItemID write SetItemID;
    property ItemMsTimeStamp: TDateTime read GetItemMsTimeStamp write SetItemMsTimeStamp;
    property ItemMsUpdateSiteCode: string read GetItemMsUpdateSiteCode write SetItemMsUpdateSiteCode;
    property ItemData: string read GetItemData write SetItemData;
  end;

implementation

{ TSynchItem }

constructor TSynchItem.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'select * from tblSynchItem';
end;

destructor TSynchItem.Destroy;
begin

  inherited;
end;

class function TSynchItem.GetBusObjectTablename: String;
begin
  result := 'tblSynchItem';
end;

class function TSynchItem.GetIDField: string;
begin
  result := 'ID';
end;

function TSynchItem.GetItemData: string;
begin
  result := GetStringField('ItemData');
end;

function TSynchItem.GetItemID: integer;
begin
  result := GetIntegerField('ItemID');
end;

function TSynchItem.GetItemMsTimeStamp: TDateTime;
begin
  result := GetDateTimeField('ItemMsTimeStamp');
end;

function TSynchItem.GetItemMsUpdateSiteCode: string;
begin
  result := GetStringField('ItemMsUpdateSiteCode');
end;

function TSynchItem.GetItemType: string;
begin
  result := GetStringField('ItemType');
end;

function TSynchItem.Save: boolean;
begin
  self.PostDb;
  result := inherited;
end;

procedure TSynchItem.SetItemData(const Value: string);
begin
  SetStringField('ItemData',Value);
end;

procedure TSynchItem.SetItemID(const Value: integer);
begin
  SetIntegerField('ItemID',Value);
end;

procedure TSynchItem.SetItemMsTimeStamp(const Value: TDateTime);
begin
  SetDateTimeField('ItemMsTimeStamp',Value);
end;

procedure TSynchItem.SetItemMsUpdateSiteCode(const Value: string);
begin
  SetStringField('ItemMsUpdateSiteCode',Value);
end;

procedure TSynchItem.SetItemType(const Value: string);
begin
  SetStringField('ItemType',Value);
end;

end.
