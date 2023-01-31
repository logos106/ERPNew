unit RollaBlindQueryLoadObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  SysUtils, MyAccess;

type
  TRollaBlindQueryLoad = class(TObject)
  private
    fConnection: TMyConnection;
  public
    constructor Create;
    function GetQuery(const Queryname: string): string;
    procedure Execute(const QueryName: string; const SheetID: Integer = 0; const ColourGridID: Integer = 0; const HiddenProfileType: string = '');
    property Connection: TMyConnection read fConnection write fConnection;
  end;

implementation

{ TRollaBlindQueryLoad }

constructor TRollaBlindQueryLoad.Create;
begin
  inherited;
  fConnection := nil;
end;

function TRollaBlindQueryLoad.GetQuery(const Queryname: string): string;
var
  qryList: TMyQuery;
begin
  Result := '';

  if Assigned(fConnection) then begin
    qryList := TMyQuery.Create(nil);
    qryList.Options.FlatBuffers := True;
    try
      qryList.Connection := fConnection;
      qryList.SQL.Text := 'SELECT * FROM tblrollaquerylist WHERE Name = ' + QuotedStr(QueryName);
      qryList.Open;

      if not qryList.IsEmpty then
        Result := qryList.FieldByName('QueryText').AsString;

      qryList.Close;
    finally
      FreeandNil(qryList);
    end;
  end;
end;

procedure TRollaBlindQueryLoad.Execute(const QueryName: string; const SheetID: Integer; const ColourGridID: Integer; const HiddenProfileType: string);
var
  qryProcess: TMyQuery;
begin
  if Assigned(fConnection) then begin
    qryProcess := TMyQuery.Create(nil);
    qryProcess.Options.FlatBuffers := True;
    try
      qryProcess.Connection := fConnection;
      qryProcess.SQL.Text := GetQuery(QueryName);

      if Assigned(qryProcess.FindParam('SheetID')) then
        qryProcess.ParamByName('SheetID').AsInteger := SheetID;

      if Assigned(qryProcess.FindParam('ColourGridID')) then
        qryProcess.ParamByName('ColourGridID').AsInteger := ColourGridID;

      if Assigned(qryProcess.FindParam('HiddenProfileType')) then
        qryProcess.ParamByName('HiddenProfileType').AsString := HiddenProfileType;

      qryProcess.Execute;
    finally
      FreeandNil(qryProcess);
    end;
  end;
end;

end.
