unit ClassExtenderListObj;

interface

uses Classes,Contnrs;

type

  TClassExtenderListItem = class(TObject)
  private
    fParentClassName: string;
    fExtenderClassName: string;
  public
    constructor Create;
    property ParentClassName: string read fParentClassName write fParentClassName;
    property ExtenderClassName: string read fExtenderClassName write fExtenderClassName;
  end;

  TClassExtenderList = class(TObjectList)
  private
    function GetExtenderItem(index: integer): TClassExtenderListItem;
  public
    procedure AddExtender(const aParentClassName, aExtenderClassName: string);
    function Exists(const aParentClassName, aExtenderClassName: string): boolean;
    function ExtenderListForParent(const aParentClassName: string): string;
    procedure CreateExtenderClasses(const ParentObj: TComponent);
    procedure Clear; override;
    property ExtenderItem[index: integer]: TClassExtenderListItem read GetExtenderItem;
  end;

  function ClassExtenderList: TClassExtenderList;

implementation

uses
  Sysutils;

{ TClassExtenderList }

var
  ExtenderList: TClassExtenderList;

function ClassExtenderList: TClassExtenderList;
begin
  if not Assigned(ExtenderList) then
    ExtenderList:= TClassExtenderList.Create;
  result:= ExtenderList;
end;

procedure TClassExtenderList.AddExtender(const aParentClassName, aExtenderClassName: string);
var
  item: TClassExtenderListItem;
begin
  if not Exists(aParentClassName, aExtenderClassName) then begin
    item := TClassExtenderListItem.Create;
    item.ParentClassName := aParentClassName;
    item.ExtenderClassName := aExtenderClassName;
    Add(item);
  end;  
end;

procedure TClassExtenderList.Clear;
begin
  inherited;
end;

procedure TClassExtenderList.CreateExtenderClasses(
  const ParentObj: TComponent);
var
  x: integer;
  item: TClassExtenderListItem;
  CompClass: TComponentClass;
begin
  for x:= 0 to Count -1 do begin
    item:= TClassExtenderListItem(Items[x]);
    if (item.ParentClassName = ParentObj.ClassName) then begin
      CompClass := TComponentClass(GetClass(item.ExtenderClassName));
      if Assigned(CompClass) then begin
        CompClass.Create(ParentObj);
        //Exit;
      end;
    end;
  end;
end;

function TClassExtenderList.Exists(const aParentClassName,
  aExtenderClassName: string): boolean;
var
  x: integer;
  item: TClassExtenderListItem;
begin
  result:= false;
  for x:= 0 to Count -1 do begin
    item:= TClassExtenderListItem(Items[x]);
    if (item.ParentClassName = aParentClassName) and
       (item.ExtenderClassName = aExtenderClassName) then begin
      result:= true;
      break;
    end;
  end;
end;

function TClassExtenderList.ExtenderListForParent(
  const aParentClassName: string): string;
var
  x: integer;
  item: TClassExtenderListItem;
begin
  result:= '';
  for x:= 0 to Count -1 do begin
    item:= TClassExtenderListItem(Items[x]);
    if (item.ParentClassName = aParentClassName) then begin
      if result <> '' then result:= result + ',';
      result:= result + item.ExtenderClassName;
    end;
  end;
end;

function TClassExtenderList.GetExtenderItem(index: integer): TClassExtenderListItem;
begin
  result:= TClassExtenderListItem(Items[index]);
end;

{ TClassExtenderListItem }

constructor TClassExtenderListItem.Create;
begin
  inherited;
  fParentClassName := '';
  fExtenderClassName := '';
end;

initialization

finalization
  FreeandNil(ExtenderList);
end.
