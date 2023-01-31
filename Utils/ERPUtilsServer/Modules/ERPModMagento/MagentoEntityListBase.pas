unit MagentoEntityListBase;

interface

type
  TMageEntityList = class
  protected
    fMagento: TObject;
  public
    constructor Create(Magento: TObject); virtual;
    destructor Destroy; overload;
    procedure Invalidate; virtual; { clear list etc to force reload }
  end;

implementation

{ TMageEntityList }

constructor TMageEntityList.Create(Magento: TObject);
begin
  fMagento := Magento;
end;

destructor TMageEntityList.Destroy;
begin
  Invalidate;
  inherited;
end;

procedure TMageEntityList.Invalidate;
begin

end;

end.
