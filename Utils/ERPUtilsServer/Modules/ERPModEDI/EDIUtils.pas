unit EDIUtils;

interface

uses
  ProgressDialog;

  function DataTypeToStr(aDataType: string): string;
  function StrToDataType(aStr: string): string;

type
  TMapDataTypeRec = record
    Value: string;
    Name: string;
  end;

const
  data_String = 'String';
  data_Int = 'Integer';
  data_Float = 'Float';
  data_Currency = 'Currency';
  data_Boolean = 'Boolean';
  data_DateTime = 'DateTime';

  MapDataTypes: Array[0..5] of TMapDataTypeRec =
  (
    (Value: data_String;   Name: 'Text'),
    (Value: data_Int;      Name: 'Whole Number'),
    (Value: data_Float;    Name: 'Number'),
    (Value: data_Currency; Name: 'Currency'),
    (Value: data_Boolean;  Name: 'True / False'),
    (Value: data_DateTime; Name: 'Date and Time')
  );

var
  dlg: TProgressDialog;

implementation

uses
  SysUtils;

function DataTypeToStr(aDataType: string): string;
var
  x: integer;
begin
  result := '';
  for x := Low(MapDataTypes) to High(MapDataTypes) do begin
    if SameText(aDataType, MapDataTypes[x].Value) then begin
      result := MapDataTypes[x].Name;
      break;
    end;
  end;
end;

function StrToDataType(aStr: string): string;
var
  x: integer;
begin
  result := '';
  for x := Low(MapDataTypes) to High(MapDataTypes) do begin
    if SameText(aStr, MapDataTypes[x].Name) then begin
      result := MapDataTypes[x].Value;
      break;
    end;
  end;
end;

end.
