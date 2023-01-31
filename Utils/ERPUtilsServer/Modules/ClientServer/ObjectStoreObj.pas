unit ObjectStoreObj;

interface

uses
  contnrs;

type

  TLoadedObject = class
  public
    Inst: TObject;
    Ref: string;
  end;

  TLoadedObjectList = class(TObjectList)
  private
  public
  end;


  TObjectStore = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Save(obj: TObject);
    function Load(aClassName: string; query: string): TObjectList;
  end;

implementation

{ TObjectStore }

constructor TObjectStore.Create;
begin

end;

destructor TObjectStore.Destroy;
begin

  inherited;
end;

function TObjectStore.Load(aClassName, query: string): TObjectList;
begin
  result:= nil;
end;

procedure TObjectStore.Save(obj: TObject);
begin

end;

end.
