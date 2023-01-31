unit GlobalClassFinder;

interface

uses
  classes;


type
  TComponentClass = class of TComponent;

  TFindModuleClassFunc = function (const aClassName: string; const aOwner: TComponent; var FoundClass: TComponent): boolean;

  TGlobalClassFinder = class(TComponent)
  private
    fList: TList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddFindModuleClassFunc(Func: TFindModuleClassFunc);
    function FindClass(const aClassName: string; const aOwner: TComponent): TComponent;
  end;

  function ClassFinder: TGlobalClassFinder;
  function FindModuleClassFunc(const aClassName: string; const aOwner: TComponent; var FoundClass: TComponent): boolean;

implementation

uses
  Forms, sysutils;

function ClassFinder: TGlobalClassFinder;
var x: integer;
begin
  result:= nil;
  for x:= 0 to Application.ComponentCount -1 do begin
    if Application.Components[x].ClassNameIs('TGlobalClassFinder') then begin
      result:= TGlobalClassFinder(Application.Components[x]);
      break;
    end;
  end;
  if not Assigned(result) then
    result:= TGlobalClassFinder.Create(Application);
end;


function FindModuleClassFunc(const aClassName: string; const aOwner: TComponent; var FoundClass: TComponent): boolean;
var
  cls: TComponentClass;
begin
  cls:= TComponentClass(GetClass(aClassName));
  result:= Assigned(cls);
  if result then begin
    if Assigned(aOwner) then
      FoundClass:= cls.Create(aOwner)
    else
      FoundClass:= cls.Create(nil);
  end;
end;

{ TClassFinder }

constructor TGlobalClassFinder.Create(AOwner: TComponent);
begin
  inherited;
  fList:= TList.Create;
end;

destructor TGlobalClassFinder.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

procedure TGlobalClassFinder.AddFindModuleClassFunc(Func: TFindModuleClassFunc);
begin
  fList.Add(@Func);
end;

function TGlobalClassFinder.FindClass(const aClassName: string;
  const aOwner: TComponent): TComponent;
var x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if TFindModuleClassFunc(fList[x])(aClassName, aOwner, result) then
      break;
  end;
end;

end.
