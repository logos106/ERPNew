unit MagentoAttributeSetList;

interface

uses
  MagentoEntityListBase, magento_v2_soap;

type
  TMageAttributeSetList = class(TMageEntityList)
  private
    fAttributeSetList: catalogProductAttributeSetEntityArray;
    function GetDefaultAttributeSetId: integer;
    procedure LoadList;
  public
    constructor Create(Magento: TObject); overload;
    procedure Invalidate; override;
    property DefaultAttributeSetId: integer read GetDefaultAttributeSetId;
    function IdForSetName(const aName: string): integer;
    function SetNameExists(const aName: string): boolean;
  end;

implementation

uses
  MagentoObjOld, SysUtils;

{ TMageAttributeSetList }

constructor TMageAttributeSetList.Create(Magento: TObject);
begin
  inherited;
  fAttributeSetList := nil;
end;

function TMageAttributeSetList.GetDefaultAttributeSetId: integer;
begin
  result := IdForSetName(TMagento(fMagento).Config.DefaultAttributeSetName);
  if result < 1 then
    raise Exception.Create('Could not find default Attribute Set name (' +
      TMagento(fMagento).Config.DefaultAttributeSetName + ') in Magento Store.');
end;

function TMageAttributeSetList.IdForSetName(const aName: string): integer;
var
  I: integer;
begin
  result := 0;
  if not Assigned(fAttributeSetList) then LoadList;
  for I := Low(fAttributeSetList) to High(fAttributeSetList) do begin
    if SameText(fAttributeSetList[I].name_, TMagento(fMagento).Config.DefaultAttributeSetName) then begin
      result := fAttributeSetList[I].set_id;
      break;
    end;
  end;
end;

procedure TMageAttributeSetList.Invalidate;
var
  I: integer;
begin
  inherited;
  if Assigned(fAttributeSetList) then begin
    for I := Low(fAttributeSetList) to High(fAttributeSetList) do
      fAttributeSetList[I].Free;
    SetLength(fAttributeSetList,0);
    fAttributeSetList := nil;
  end;
end;

procedure TMageAttributeSetList.LoadList;
begin
  fAttributeSetList :=
    TMagento(fMagento).Mage.catalogProductAttributeSetList(TMagento(fMagento).SessionId);
end;

function TMageAttributeSetList.SetNameExists(const aName: string): boolean;
begin
  result := IdForSetName(aName) > 0;
end;

end.
