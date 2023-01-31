unit GridLib;

interface

uses
  wwdbgrid, Wwdbigrd, db , GridFieldsObj;

function ActiveField(grd:TwwDBGrid): TField;
function ActiveFieldName(grd:TwwDBGrid):  string;
Procedure SetActiveField(grd:TwwDBGrid; const Fieldname:String);
function GridDisplayLabel(const grd:TwwDBGrid ; fieldname:String):String;

implementation
function GridDisplayLabel(const grd:TwwDBGrid ; fieldname:String):String;
var
  gfl: TGridFieldList;
begin
  try
    gfl := TGridFieldList.Create;
    try
      gfl.LoadFromGrid(grd);
      Result := gfl.FieldByName(fieldname).DisplayLabel;

    finally
      gfl.Free;
    end;
  finally
    result := fieldname;
  end;
end;
function ActiveField(grd:TwwDBGrid): TField;
begin
  REsult := nil;
  try
    Result := TField(grd.GetActiveField);
  Except
  end;
end;

function ActiveFieldName(grd:TwwDBGrid):  string;
begin
  Result := '';
  try
    Result := ActiveField(grd).fieldname;
  Except
  end;
end;
Procedure SetActiveField(grd:TwwDBGrid; const Fieldname:String);
begin
  try
    if grd.datasource.dataset.findfield(fieldname) <> nil then
      setActiveField(grd,fieldname);
  Except
  end;

end;


end.
