unit ContentTypeObj;

interface

uses
  Classes;

type

  TContentType = class
  private
    fMediaType: string;
    fSubType: string;
    fAsString: string;
    procedure SetAsString(const Value: string);
  public
    Params: TStringList;
    constructor Create; overload;
    constructor Create(aMedTypeStr: string); overload;
    destructor Destroy; override;
    property AsString: string read fAsString write SetAsString;
    property MediaType: string read fMediaType;
    property SubType: string read fSubType;
  end;



implementation

uses
  Types, StrUtils, SysUtils;

{ TContentType }

constructor TContentType.Create;
begin
  Params := TStringList.Create;
end;

constructor TContentType.Create(aMedTypeStr: string);
begin
  Create;
  AsString := aMedTypeStr;
end;

destructor TContentType.Destroy;
begin
  Params.Free;
  inherited;
end;

procedure TContentType.SetAsString(const Value: string);
var
  sa: TStringDynArray;
begin
  fAsString := Value;
  fMediaType := '';
  fSubType := '';
  Params.Clear;
  sa := SplitString(Trim(Value),';');
  if Length(sa) > 1 then
    Params.Text := Trim(sa[1]);
  if Length(sa) > 0 then begin
    sa := SplitString(Trim(sa[0]),'/');
    if Length(sa) > 0 then
      fMediaType := sa[0];
    if Length(sa) > 1 then
      fSubType := sa[1];
  end;
end;

end.
