unit MageDataFilter;

interface

uses
  JsonObject;

type

  TMageDataFilter = class(TJsonObject)
  public
    constructor Create;
    procedure Equal(field: string; value: string); overload;
    procedure Equal(field: string; value: double); overload;
    procedure NotEqual(field: string; value: string); overload;
    procedure NotEqual(field: string; value: double); overload;
    procedure Like(field: string; value: string); overload;
    procedure NotLike(field: string; value: double); overload;
    function IsIn(field: string): TJsonArray; overload;
    function NotIn(field: string): TJsonArray; overload;
    procedure GreaterThan(field: string; value: string); overload;
    procedure GreaterThan(field: string; value: double); overload;
    procedure LessThan(field: string; value: string); overload;
    procedure LessThan(field: string; value: double); overload;
    procedure GreaterThanOrEqual(field: string; value: string); overload;
    procedure GreaterThanOrEqual(field: string; value: double); overload;
    procedure LessThanOrEqual(field: string; value: string); overload;
    procedure LessThanOrEqual(field: string; value: double); overload;
    procedure Null(field: string);
    procedure NotNull(field: string);

    function Fields: TJsonArray;
  end;

(*
  json query structure for addAttributeToFilter ..

  {"filters":
    [
      {"field":"name","filter":{"eq":"smith"}},
      {"field":"id","filter":{"in":[1,2,3,4,5,6]}}
    ],
   "fields":["field1","field2"]
  }


*)


implementation

{ TMageDataFilter }

constructor TMageDataFilter.Create;
begin
  inherited;
  self.FormatOutput := false;
end;

procedure TMageDataFilter.Equal(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['eq'] := value;
  A['filters'].Add(o);
end;

function TMageDataFilter.Fields: TJsonArray;
begin
  result := A['fields'];
end;

procedure TMageDataFilter.Equal(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['eq'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.GreaterThan(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['gt'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.GreaterThan(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['gt'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.GreaterThanOrEqual(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['gteq'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.GreaterThanOrEqual(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['gteq'] := value;
  A['filters'].Add(o);
end;

function TMageDataFilter.IsIn(field: string): TJsonArray;
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  result := o.A['in'];
end;

procedure TMageDataFilter.LessThan(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['lt'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.LessThan(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['lt'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.LessThanOrEqual(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['lteq'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.LessThanOrEqual(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['lteq'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.Like(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['like'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.NotEqual(field, value: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].S['neq'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.NotEqual(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['neq'] := value;
  A['filters'].Add(o);
end;

function TMageDataFilter.NotIn(field: string): TJsonArray;
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  result := o.A['nin'];
end;

procedure TMageDataFilter.NotLike(field: string; value: double);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].F['nlike'] := value;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.NotNull(field: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].B['null'] := false;
  A['filters'].Add(o);
end;

procedure TMageDataFilter.Null(field: string);
var
  o: TJsonObject;
begin
  o := JO;
  o.S['field'] := field;
  o.O['filter'].B['null'] := true;
  A['filters'].Add(o);
end;

end.
