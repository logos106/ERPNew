unit ObjectDb;

interface

type

  TUidObject = class(TObject)
  private
    fuid: shortstring;
  published
    property uid: shortstring read fuid write fuid;
  end;


  TObjectStore = class(TObject)
  private
  public
    procedure Store(aObject: TUidObject);
    procedure Load(aObject: TUidObject);
  end;

implementation

{ TObjectStore }

procedure TObjectStore.Load(aObject: TUidObject);
begin

end;

procedure TObjectStore.Store(aObject: TUidObject);
begin

end;

end.
