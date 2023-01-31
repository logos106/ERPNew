unit QueryLoadObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/06  1.00.01 DSP  First version. This class loads or executes queries
                        stored in the table 'tblcommonquerylist'.  Paramater
                        values can be passed in any descendent of TStrings
                        using name, value pairs, eg. Add('EmployeeID=35').

 05/01/07  1.00.02 DSP  Added TVarParams class.                       

}

interface

uses
  SysUtils, Classes, StrUtils, MyAccess,ERPdbComponents, DB;

type
  PNameValue = ^TNameValue;

  TNameValue = record
    Name: string;
    Value: Variant;
  end;

  TVarParams = class(TObject)
  private
    FParams: TList;
    function GetItem(ItemIndex: Integer): Pointer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Name: string; const Value: Variant);
    procedure Delete(const Name: string);
    procedure Clear;
    function Count: Integer;
    property Items[ItemIndex: Integer]: Pointer read GetItem; default;
  end;

  TQueryLoad = class(TObject)
  private
    FConnection: TERPConnection;
    FQueryGroup: string;
  public
    constructor Create;
    function GetQuery(const QueryName: string; const Params: TStrings = nil; const Group: string = ''): string;
    procedure Execute(const QueryName: string; const Params: TStrings = nil; const Group: string = ''); overload;
    function Execute(const QueryName: string; const Params: TVarParams = nil; const Group: string = ''): TDataSet; overload;
    procedure DropTable(const TableName: string);
    property Connection: TERPConnection read FConnection write FConnection;
    property QueryGroup: string read FQueryGroup write FQueryGroup;
  end;

implementation

uses
  CommonDbLib, Variants, FastFuncs;

{ TVarParams }

procedure TVarParams.Add(const Name: string; const Value: Variant);
var
  NameValue: PNameValue;
begin
  New(NameValue);
  NameValue.Name := Name;
  NameValue.Value := Value;
  FParams.Add(NameValue);
end;

procedure TVarParams.Clear;
begin
  while FParams.Count > 0 do begin
    Dispose(FParams.Items[0]);
    FParams.Delete(0);
  end;
end;

function TVarParams.Count: Integer;
begin
  Result := FParams.Count;
end;

constructor TVarParams.Create;
begin
  inherited;  
  FParams := TList.Create;
end;

procedure TVarParams.Delete(const Name: string);
var
  Index: Integer;
  FoundMatch: Boolean;
begin
  Index := 0;
  FoundMatch := False;

  while (Index < FParams.Count) and (not FoundMatch) do begin
    if Sysutils.SameText(PNameValue(FParams.Items[Index]).Name, Name) then
      FoundMatch := True
    else
      Inc(Index);
  end;

  if FoundMatch then begin
    Dispose(FParams.Items[Index]);
    FParams.Delete(Index);
  end;
end;

destructor TVarParams.Destroy;
begin
  Clear;
  FreeAndNil(FParams);
  inherited;
end;

function TVarParams.GetItem(ItemIndex: Integer): Pointer;
begin
  Result := FParams[ItemIndex];
end;

{ TQueryLoad }

constructor TQueryLoad.Create;
begin
  inherited;  
  FConnection := nil;
  FQueryGroup := '';
end;

procedure TQueryLoad.Execute(const QueryName: string; const Params: TStrings = nil; const Group: string = '');
var
  Index: Integer;
  qryProcess: TERPQuery;
  ParamName: string;
begin
  qryProcess := TERPQuery.Create(nil);

  try
    if Assigned(fConnection) then
      qryProcess.Connection := Connection
    else
      qryProcess.Connection := GetSharedMyDacConnection;

    qryProcess.SQL.Text := GetQuery(QueryName, nil, Group);

    //
    // Set parameter values in query
    //
    if Assigned(Params) then begin
      for Index := 0 to Params.Count - 1 do begin
        ParamName := Params.Names[Index];

        if Assigned(qryProcess.FindParam(ParamName)) then
          qryProcess.ParamByName(ParamName).AsString := Params.Values[ParamName];
      end;
    end;

    qryProcess.Execute;
  finally
    FreeAndNil(qryProcess);
  end;
end;

function TQueryLoad.Execute(const QueryName: string; const Params: TVarParams = nil; const Group: string = ''): TDataSet;
var
  Index: Integer;
  qryProcess: TERPQuery;
  ParamName: string;
  ParamValue: Variant;
  IsSelect: Boolean;
begin
  Result := nil;
  IsSelect := False;
  qryProcess := TERPQuery.Create(nil);

  try
    if Assigned(fConnection) then
      qryProcess.Connection := Connection
    else
      qryProcess.Connection := GetSharedMyDacConnection;

    qryProcess.SQL.Text := GetQuery(QueryName, nil, Group);
    IsSelect := Sysutils.SameText(Copy(Trim(qryProcess.SQL.Text), 1, 6), 'select');

    //
    // Set parameter values in query
    //
    if Assigned(Params) then begin
      for Index := 0 to Params.Count - 1 do begin
        ParamName := PNameValue(Params[Index]).Name;

        if Assigned(qryProcess.FindParam(ParamName)) then begin
          ParamValue := PNameValue(Params[Index]).Value;

          case VarType(ParamValue) of
            varInteger,
            varByte,
            varWord: qryProcess.ParamByName(ParamName).AsInteger := ParamValue;

            varDouble: qryProcess.ParamByName(ParamName).AsFloat := ParamValue;

            varBoolean: qryProcess.ParamByName(ParamName).AsBoolean := ParamValue;

            varDate: qryProcess.ParamByName(ParamName).AsDateTime := ParamValue;

            varString: qryProcess.SQL.Text := AnsiReplaceText(qryProcess.SQL.Text, ':' + ParamName, ParamValue);
          end;
        end;
      end;
    end;

    if IsSelect then
      qryProcess.Open
    else
      qryProcess.Execute;
  finally
    if IsSelect then
      Result := qryProcess
    else
      FreeAndNil(qryProcess);
  end;
end;

procedure TQueryLoad.DropTable(Const TableName: string);
var
  qryProcess: TERPQuery;
begin
  if TableName = '' then
    Exit;

  qryProcess := TERPQuery.Create(nil);

  try
    if Assigned(fConnection) then
      qryProcess.Connection := Connection
    else
      qryProcess.Connection := GetSharedMyDacConnection;

    qryProcess.SQL.Text := 'Drop Table if Exists ' + TableName;
    qryProcess.Execute;
  finally
    FreeAndNil(qryProcess);
  end;
end;

function TQueryLoad.GetQuery(const QueryName: string; const Params: TStrings = nil; const Group: string = ''): string;
var
  Index: Integer;
  qryList: TERPQuery;
  TmpGroup: string;
  ParamName: string;
begin
  Result := '';
  qryList := TERPQuery.Create(nil);

  try
    if Assigned(fConnection) then
      qryList.Connection := Connection
    else
      qryList.Connection := GetSharedMyDacConnection;

    if Group <> '' then
      TmpGroup := Group
    else
      TmpGroup := QueryGroup;

    qryList.SQL.Text := 'SELECT * FROM tblcommonquerylist WHERE (QueryGroup = ' +
                        QuotedStr(TmpGroup) + ') AND (Name = ' + QuotedStr(QueryName) + ')';
    qryList.Open;

    if not qryList.IsEmpty then begin
      Result := qryList.FieldByName('QueryText').AsString;

      //
      // Assign parameter values in query text
      //
      if Assigned(Params) then begin
        for Index := 0 to Params.Count - 1 do begin
          ParamName := Params.Names[Index];
          Result := AnsiReplaceText(Result, ':' + ParamName, Params.Values[ParamName]);
        end;
      end;
    end;

    qryList.Close;
  finally
    FreeAndNil(qryList);
  end;
end;

end.
