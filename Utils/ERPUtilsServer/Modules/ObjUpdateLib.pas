unit ObjUpdateLib;

interface

uses
  contnrs;

type
  TUpdateObjectList = class
  private
    fList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(obj: TObject);
    procedure Remove(obj: TObject);
    function Exists(obj: TObject): boolean;
  end;


var
  UpdateUser: string;
  UpdateObjectList: TUpdateObjectList;

implementation

uses
  classes;

{ TUpdateObjectList }

procedure TUpdateObjectList.Add(obj: TObject);
begin
  fList.Add(obj);
end;

constructor TUpdateObjectList.Create;
begin
  fList:= TObjectList.Create(false);
end;

destructor TUpdateObjectList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TUpdateObjectList.Exists(obj: TObject): boolean;
begin
  result:= fList.IndexOf(obj) > -1;
end;

procedure TUpdateObjectList.Remove(obj: TObject);
var
  x: integer;
begin
  { last in first out }
  for x:= fList.Count -1 downto 0 do begin
    if fList[x] = obj then begin
      fList.Delete(x);
      break;
    end;
  end;
end;

initialization
  UpdateObjectList:= TUpdateObjectList.Create;

finalization
  UpdateObjectList.Free;

end.
