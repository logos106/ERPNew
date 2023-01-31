unit ActionsObj;

interface

uses
  Classes, ActnList;

type
  { TActionHelperItem }
  TActionHelperItem = class(TCollectionItem)
  private
    FAction: TAction;
    FActionName: string;
    FActionClassName: string; // "ClassName" is already native to every class
    FActive: boolean;

    FItemIndex: integer;
    FShortDesc: string;
    function GetShortDesc: string;
  public
    property Action: TAction read FAction write FAction;
    property ActionName: string read FActionName write FActionName;
    property ActionClassName: string read FActionClassName write FActionClassName;
    property Active: boolean read FActive write FActive;

    property ItemIndex: integer read FItemIndex write FItemIndex;
    property ShortDesc: string read GetShortDesc write FShortDesc;
  end;

  { TActionHelper }
  TActionHelper = class(TCollection)
  private
    function GetItems(const Index: integer): TActionHelperItem;
    procedure SetActionByName(const ActionName: string; const Value: TAction);
    procedure SetItems(const Index: integer; const Value: TActionHelperItem);
    procedure SetItemByName(const ActionName: string; const Value: TActionHelperItem);
  protected
    function GetItemByName(const ActionName: string): TActionHelperItem;
    function GetActionByName(const ActionName: string): TAction;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: TActionHelperItem;
    function ActionCount(const AClassName: string = ''): integer;
    function ActionNameToClassName(const ActionName: string): string;
    function GetShortDesc(const ActionName: string): string;
    function IsActionActive(const ActionName: string): boolean;
    function IsClassMember(const ActionName, AClassName: string): boolean;
    function SetActionActive(const ActionName: string; const Value: boolean): boolean;

    procedure AssociateActionWithClassName(const ActionName, AClassName: string; const AShortDesc: string = '');

    procedure GetActionNamesByClassName(const AClassName: string; const AList: TStrings);
    property ActionByName[const ActionName: string]: TAction read GetActionByName write SetActionByName;
    property ItemByName[const ActionName: string]: TActionHelperItem read GetItemByName write SetItemByName;
    property Items[const Index: integer]: TActionHelperItem read GetItems write SetItems;
  end;

implementation

uses FastFuncs,SysUtils;

{ TActionHelper }

function TActionHelper.ActionCount(const AClassName: string): integer;
var
  I: integer;
begin
  if AClassName = '' then Result := Self.Count
  else begin
    Result := 0;
    if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Items[I].ActionClassName = AClassName then Inc(Result);
  end;
end;

function TActionHelper.ActionNameToClassName(const ActionName: string): string;
var
  I: integer;
begin
  Result := '';
  if ActionName <> '' then begin
    if Self.Count > 0 then
      for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Result := Items[I].ActionClassName;
        Break;
      end;
  end;
end;

function TActionHelper.Add: TActionHelperItem;
begin
  Result := TActionHelperItem(inherited Add);
end;

procedure TActionHelper.AssociateActionWithClassName(const ActionName, AClassName: string; const AShortDesc: string = '');
var
  AI: TActionHelperItem;
begin
  AI := ItemByName[ActionName];
  if Assigned(AI) then begin
    AI.ActionClassName := AClassName;
    AI.ShortDesc       := AShortDesc;
  end else raise Exception.CreateFmt('Action "%s" not found in Action Helper list',
      [ActionName]);
end;

constructor TActionHelper.Create;
begin
  inherited Create(TActionHelperItem);
end;


destructor TActionHelper.Destroy;
begin
//
  inherited;
end;

function TActionHelper.GetActionByName(const ActionName: string): TAction;
var
  I: integer;
begin
  Result := nil;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Result := Items[I].Action;
        Break;
      end;
end;

procedure TActionHelper.GetActionNamesByClassName(const AClassName: string; const AList: TStrings);
var
  I: integer;
begin
  AList.Clear;

  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionClassName, AClassName) then
        AList.Add(Items[I].ActionName);
end;

function TActionHelper.GetItemByName(const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Result := Items[I];
        Break;
      end;
end;

function TActionHelper.GetItems(const Index: integer): TActionHelperItem;
begin
  Result := TActionHelperItem(inherited Items[Index]);
end;

function TActionHelper.GetShortDesc(const ActionName: string): string;
var
  AI: TActionHelperItem;
begin
  Result := '';
  AI := ItemByName[ActionName];
  if Assigned(AI) then Result := AI.ShortDesc;
end;

function TActionHelper.IsActionActive(const ActionName: string): boolean;
var
  I: integer;
begin
  Result := false;

  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Result := Items[I].Active;
        Break;
      end;
end;

function TActionHelper.IsClassMember(const ActionName, AClassName: string): boolean;
var
  I: integer;
begin
  Result := false;

  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) and
        Sysutils.SameText(Items[I].ActionClassName, AClassName) then begin
        Result := true;
        Break;
      end;
end;

function TActionHelper.SetActionActive(const ActionName: string; const Value: boolean): boolean;
var
  I: integer;
begin
  Result := false;

  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Items[I].Active := Value;
        Result := true; // success
        Break;
      end;
end;

procedure TActionHelper.SetActionByName(const ActionName: string; const Value: TAction);
var
  I: integer;
begin
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].ActionName, ActionName) then begin
        Items[I].Action := Value;
        Break;
      end;
end;

procedure TActionHelper.SetItemByName(const ActionName: string; const Value: TActionHelperItem);
var
  AI: TActionHelperItem;
begin
  AI := ItemByName[ActionName];
  if Assigned(AI) then Items[AI.Index] := Value
end;

procedure TActionHelper.SetItems(const Index: integer; const Value: TActionHelperItem);
begin
  TActionHelperItem(inherited Items[Index]).Assign(Value);
end;

{ TActionHelperItem }

function TActionHelperItem.GetShortDesc: string;
begin
  Result := '';
  if FShortDesc <> '' then Result := FShortDesc
  else if Assigned(FAction) then Result := FAction.Caption;
end;

end.
