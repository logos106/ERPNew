unit OptimiseInsertsObj;

interface

uses Classes,DB;

type
  TOptimiseInserts = class(TObject)
  private
    SourceCopy,InsertsSQL,OptimisedInserts : TStringList;
    procedure MoveInsertSQL(Const FromStrList: TStringList; Const ToStrList: TStringList);
    procedure OptimiseInsertsSQL(Const FromStrList: TStringList; Const ToStrList: TStringList);
    Function ResultFieldValue(Const CurrentField: TField): String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InsertSelectToInsertValues(Const InsertSelectSQL: String; Const OptimisedSQL: TStringList);
    procedure Optimise(Const SourceSQL: TStringList);
  end;

implementation

uses SysUtils,(*CommonDBlib,*)AppEnvironmentVirtual, MyAccess,ERPdbComponents, MySQLConst, strutils;

{ TOptimiseInserts }

constructor TOptimiseInserts.Create;
begin
  inherited Create;
  SourceCopy := TStringList.Create;
  InsertsSQL := TStringList.Create;
  OptimisedInserts := TStringList.Create;
end;


destructor TOptimiseInserts.Destroy;
begin
  FreeAndNil(SourceCopy);
  FreeAndNil(InsertsSQL);
  FreeAndNil(OptimisedInserts);
  inherited;
end;

procedure TOptimiseInserts.MoveInsertSQL(const FromStrList, ToStrList: TStringList);
var
  Index: Integer;
  s: string;
begin
  // Move All Insert Statments From FromStrList to ToStrList
  Index := 0;
  While (Index < FromStrList.Count) do begin
    s:= Uppercase(FromStrList[Index]);
   if (Pos('INSERT HIGH_PRIORITY INTO ',s)>0)
         AND ((Pos(') VALUES (',s)>0)
         OR (Pos(')VALUES(',s)>0)
         OR (Pos(')VALUES (',s)>0)
         OR (Pos(') VALUES(',s)>0))
        AND (Pos(');',s)>0) then Begin
      ToStrList.Add(FromStrList[Index]);
      FromStrList.Delete(Index);
    end else
      Inc(Index);
  end;
end;

procedure TOptimiseInserts.Optimise(Const SourceSQL: TStringList);
begin
  SourceCopy.Clear;
  OptimisedInserts.Clear;
  InsertsSQL.Clear;
  SourceCopy.Assign(SourceSQL);
  MoveInsertSQL(SourceCopy,InsertsSQL);
  OptimiseInsertsSQL(InsertsSQL, OptimisedInserts);
  OptimisedInserts.AddStrings(SourceCopy);
  SourceSQL.Clear;
  SourceSQL.Assign(OptimisedInserts);
end;

procedure TOptimiseInserts.OptimiseInsertsSQL(const FromStrList, ToStrList: TStringList);
var
  Index, SubIndex: Integer;
  AddString, SameInsertTable: String;
begin
  SameInsertTable := '';
  Index := 0;
  While (Index < FromStrList.Count) do Begin
    AddString := Trim(FromStrList[Index]);
    If Pos(';',AddString)=Length(AddString) then
      AddString := LeftStr(AddString,Length(AddString)-1);
    SameInsertTable :=  LeftStr(AddString,Pos('VALUES',Uppercase(AddString)) + 5);
    ToStrList.Add(AddString);
    FromStrList.Delete(Index);
    SubIndex := 0;
    While (SubIndex < FromStrList.Count) do Begin
      if (Pos(Lowercase(SameInsertTable),Lowercase(FromStrList[SubIndex]))>0) then Begin
        AddString := StringReplace(FromStrList[SubIndex],SameInsertTable,'',[rfIgnoreCase]);
        AddString := LeftStr(AddString,Length(AddString)-1);
        ToStrList.Add(','+AddString);
        FromStrList.Delete(SubIndex);
      end else
        Inc(SubIndex);
    end;    
    ToStrList[ToStrList.Count-1] := ToStrList[ToStrList.Count-1]+';';
    SameInsertTable := '';
    Inc(Index);
  end;
end;

procedure TOptimiseInserts.InsertSelectToInsertValues(Const InsertSelectSQL: String; Const OptimisedSQL: TStringList);
{Stops Lock Timeout on the Select Tables of an Insert...Select}
Var
  InsertStatement:String;
  SelectStatement:String;
  qryTemp: TERPQuery;
  I:Integer;
  TempStr: String;
begin
  qryTemp := TERPQuery.Create(nil);
  Try
    if (Pos('INSERT HIGH_PRIORITY INTO ',Uppercase(InsertSelectSQL))>0) AND(Pos('SELECT ',Uppercase(InsertSelectSQL))>0) then Begin
      InsertStatement := Trim(LeftStr(InsertSelectSQL,Pos('SELECT ',Uppercase(InsertSelectSQL))-1));
      SelectStatement := Trim(StringReplace(InsertSelectSQL,InsertStatement,'',[rfIgnoreCase]));
      OptimisedSQL.Clear;
      qryTemp.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      qryTemp.SQL.Text := SelectStatement;
      qryTemp.Open;
      If (qryTemp.RecordCount>0) then begin
        OptimisedSQL.Add(InsertStatement+' VALUES ');
        qryTemp.First;
        While not qryTemp.Eof do Begin
          TempStr := '(';
          for I := 0 to qryTemp.FieldCount-1 do Begin
            TempStr := TempStr + QuotedStr(ResultFieldValue(qryTemp.Fields[I])) + ',';
          end;
          TempStr := LeftStr(TempStr,Length(TempStr)-1)+ '),';
          OptimisedSQL.Add(TempStr);
          qryTemp.Next;
        end;
        TempStr := OptimisedSQL[OptimisedSQL.Count-1];
        TempStr := LeftStr(TempStr,Length(TempStr)-1)+ ';';
        OptimisedSQL[OptimisedSQL.Count-1] := TempStr;
      end;
    end;
  Finally
    FreeAndNil(qryTemp);
  end;
end;

Function TOptimiseInserts.ResultFieldValue(Const CurrentField: TField): String;
Begin
  case CurrentField.DataType of
    ftDate:
            if not (CurrentField.AsDateTime = 0) then
              Result := FormatDateTime(MysqlDateFormat, CurrentField.AsDateTime)
            else if CurrentField.IsNull then
              Result := 'NULL'
            else
              Result := '""';
    ftDateTime:
            if not (CurrentField.AsDateTime = 0) then
              Result := FormatDateTime(MysqlDateTimeFormat, CurrentField.AsDateTime)
            else if CurrentField.IsNull then
              Result := 'NULL'
            else
              Result := '""';
  else
    Result := CurrentField.asString;
  end;
end;

end.


