unit FlagListObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 19/04/05  1.00.00 IJB  Initial version.

interface

uses
  Classes;

type
  TFlagList = class(TObject)
  private
    List: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetFlag(Id: integer);
    procedure ClearFlag(Id: integer);
    function CheckFlag(Id: integer): boolean;
  end;

implementation

uses
  SysUtils;

{ TFlagList }

constructor TFlagList.Create;
begin
  inherited;
  List := TList.Create;
end;

destructor TFlagList.Destroy;
begin
  FreeAndNil(List);
  inherited;
end;

function TFlagList.CheckFlag(Id: integer): boolean;
begin
  Result := List.IndexOf(Pointer(Id)) > -1;
end;

procedure TFlagList.ClearFlag(Id: integer);
var
  index: integer;
begin
  index := List.IndexOf(Pointer(Id));
  if index > -1 then List.Delete(index);
end;

procedure TFlagList.SetFlag(Id: integer);
begin
  List.Add(Pointer(Id));
end;

end.
