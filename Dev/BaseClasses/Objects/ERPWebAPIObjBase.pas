unit ERPWebAPIObjBase;

interface

uses
  classes, JsonObject, ERPDbComponents,ExtCtrls ;

Type
  TERPWebAPIObjBase = Class(TPersistent)
  Private
    fSharedConnection: TERPConnection;
    fSharedScript :TERPScript;
    fSharedQuery :TERPQuery;
    fTimer :TTimer;
    function GetIsOnCONSOLE: Boolean;
    function getObjclassname: String;
  Protected
    Function SharedScript :TERPScript;
    Function SharedQuery :TERPQuery;
    Procedure Enabletimer(const ainterval:Integer);
    Procedure Diabletimer;
    Procedure Ontimer(Sender:TObjecT);Virtual;
  Public
    constructor Create; virtual;
    destructor Destroy; override;
    property  SharedConnection: TERPConnection read fSharedConnection write fSharedConnection;
    Property IsOnCONSOLE:Boolean read GetIsOnCONSOLE;
  Published
    Property Objclassname :String read getObjclassname;
  End;
implementation

uses (*CommonDbLib, *)DbSharedObjectsObj, sysutils, AppEnvironmentVirtual;

{ TERPWebAPIObjBase }

constructor TERPWebAPIObjBase.Create;
begin
  inherited Create;
  fSharedConnection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);//CommonDbLib.GetSharedMyDacConnection;;
  fSharedScript :=nil;
  fSharedQuery :=nil;
  fTimer := TTimer.create(nil);
  fTimer.enabled := False;
  fTimer.onTimer := Ontimer;
end;

destructor TERPWebAPIObjBase.Destroy;
begin
  if fSharedScript <> nil then DbSharedObj.ReleaseObj(fSharedScript);
  if fSharedQuery <> nil then DbSharedObj.ReleaseObj(fSharedQuery);
  Freeandnil(fTimer);
  inherited;
end;

function TERPWebAPIObjBase.SharedScript: TERPScript;
begin
  if fSharedScript =nil then begin
    fSharedScript := DbSharedObj.GetScript(SharedConnection);
  end;
  result := fSharedScript;
end;

function TERPWebAPIObjBase.SharedQuery: TERPQuery;
begin
  if fSharedQuery =nil then begin
    fSharedQuery := DbSharedObj.GetQuery(SharedConnection);
  end;
  result := fSharedQuery;
end;
Procedure TERPWebAPIObjBase.Enabletimer(const ainterval:Integer);
begin
   if not fTimer.enabled  then begin
    fTimer.Interval := aInterval*1000;
    fTimer.enabled := True;
   end;
end;
function TERPWebAPIObjBase.GetIsOnCONSOLE: Boolean;
begin
  {$IFNDEF CONSOLE}
    Result := False;
  {$ELSE}
    REsult := True;
  {$ENDIF}
end;

function TERPWebAPIObjBase.getObjclassname: String;
begin
  Result := Self.classname;
end;

Procedure TERPWebAPIObjBase.Diabletimer;
begin
   if fTimer.enabled  then
    fTimer.enabled := False;
end;
Procedure TERPWebAPIObjBase.Ontimer(Sender:TObjecT);
begin

end;


end.

