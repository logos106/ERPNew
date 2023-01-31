unit SaveExcludeListObj;

interface

uses
  classes, contnrs, forms;

type

  TSaveExcludeList = class(TComponent)
  private
    fList: TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(const aClassName, aFieldName: string);
    function Exists(const aClassName, aFieldName: string): boolean; overload;
    function Exists(const aObject: TObject; const aFieldName: string): boolean; overload;
  end;

  function SaveExcludeList: TSaveExcludeList;

implementation

uses
  SysUtils;

const
  SepStr = '_';

var
  ExcludeList: TSaveExcludeList;



function SaveExcludeList: TSaveExcludeList;
begin
  if not Assigned(ExcludeList) then
    ExcludeList:= TSaveExcludeList.Create(Application);
  result:= ExcludeList;
end;


{ TSaveExcludeList }

constructor TSaveExcludeList.Create(AOwner: TComponent);
begin
  inherited;
  fList:= TStringList.Create;
end;

destructor TSaveExcludeList.Destroy;
begin
  FreeandNil(fList);
  inherited;
end;

procedure TSaveExcludeList.Add(const aClassName, aFieldName: string);
begin
  if not Exists(aClassName, aFieldName) then
    fList.Add(aClassName + SepStr + aFieldName);
end;

function TSaveExcludeList.Exists(const aClassName,
  aFieldName: string): boolean;
begin
  result:= fList.IndexOf(aClassName + SepStr + aFieldName) > -1;
end;

function TSaveExcludeList.Exists(const aObject: TObject;
  const aFieldName: string): boolean;
begin
  result:= fList.IndexOf(aObject.ClassName + SepStr + aFieldName) > -1;
end;

end.
