unit StSObjetcsLib;

interface

uses ERPdbComponents, classes;

type
  TTagChangePhase = class(TComponent)
  Private
    fsSourceTag: string;
    fConnection: TERPconnection;
  Protected
  Public
    Constructor Create(AOwner:Tcomponent);Overload;Override;
    Constructor Create(AOwner:Tcomponent; aConnection :TERPconnection);Overload;
    Property Connection :TERPconnection read fConnection write fConnection;
    Property SourceTag :string read fsSourceTag write fsSourceTag;
  end;

implementation

{ TTagChangePhase }

constructor TTagChangePhase.Create(AOwner: Tcomponent);
begin
  inherited Create(AOwner);
  SourceTag := '';
  fConnection := nil;

end;

constructor TTagChangePhase.Create(AOwner: Tcomponent;  aConnection: TERPconnection);
begin
  Create(AOwner);
  fConnection := aConnection ;

end;

end.
