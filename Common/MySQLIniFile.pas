unit MySQLIniFile;

interface

uses
  classes;

type

  TLineRec = record
    Option,
    Value,
    Comment: string;
    LineNo: integer;
  end;

  TMySqlIniFile = class
  private
    fLines: TStringList;
    fFileName: string;
    function GetLineRec(const aGroup, aOption: string; var LineRec: TLineRec): boolean;
    procedure UpdateLine(LineRec: TLineRec);
    function ExtractGroupName(str: string): string;
  public
    constructor Create(aFileName: string);
    destructor Destroy; override;
    function ReadString(const Group, Option: string): string;
    procedure WriteString(const Group, Option, Value: string);
    function ReadBoolean(const Group, Option: string): boolean;
    procedure WriteBoolean(const Group, Option: string; Value: boolean);
    procedure DeleteOption(const Group, Option: string);
    procedure SaveFile;
  end;

implementation


uses
  sysutils;

{ TMySqlIniFile }

constructor TMySqlIniFile.Create(aFileName: string);
begin
  fFileName:= aFileName;
  fLines:= TStringList.Create;
  fLines.LoadFromFile(aFileName);
end;

procedure TMySqlIniFile.DeleteOption(const Group, Option: string);
var
  Rec: TLineRec;
begin
  if GetLineRec(Group, Option, Rec) then
    fLines.Delete(rec.LineNo);
end;

destructor TMySqlIniFile.Destroy;
begin
  fLines.Free;
  inherited;
end;

function TMySqlIniFile.ExtractGroupName(str: string): string;
var
  s: string;
begin
  result:= '';
  s:= Trim(str);
  if (Pos('[',s) <> 1) or (Pos(']',s) < 3) then exit;
  result:= Copy(s,2,Pos(']',s)-2);
end;

function TMySqlIniFile.GetLineRec(const aGroup, aOption: string;
  var LineRec: TLineRec): boolean;
var
  x: integer;
  line: string;
  linePos: integer;
  groupFound: boolean;
  groupName: string;

  function IsQuoteChar: boolean;
  begin
    result:= (line[linePos] = '"') or (line[linePos] = '''');
  end;

  function IsCommentChar: boolean;
  begin
    result:= (line[linePos] = '#') or (line[linePos] = ';');
  end;

  function GetOption: boolean;
  var val: string;
  begin
    val:= '';
    while linePos <= Length(line) do begin
      if CharInSet(line[linePos],[';','#','=']) then
        break
      else
        val:= val + line[linePos];
      Inc(linePos);
    end;
    val:= Lowercase(Trim(val));
    result:= val = Lowercase(aOption);
  end;

  procedure GetValue;
  var
    val: string;
    InQuotes: boolean;
  begin
    val:= '';
    InQuotes:= false;
    if (linePos <= Length(line)) and (line[linePos] = '=') then begin
      Inc(linePos);
      while linePos <= Length(line) do begin
        if InQuotes then begin
          if IsQuoteChar then
            InQuotes:= false;
          val:= val + line[linePos];
          Inc(linePos);
        end
        else begin
          { not in quotes }
          if IsCommentChar then
            break
          else if IsQuoteChar then
            InQuotes:= true;
          val:= val + line[linePos];
          Inc(linePos);
        end;
      end;
    end;
    LineRec.Value:= Trim(val);
  end;

  procedure GetComment;
  var
    val: string;
  begin
    val:= '';
    if (linePos <= Length(line)) and IsCommentChar then begin
      Inc(linePos);
      while linePos <= Length(line) do begin
        val:= val + line[linePos];
        Inc(linePos);
      end;
    end;
    LineRec.Comment:= val;
  end;

begin
  result:= false;
  LineRec.LineNo:= -1;
  LineRec.Option:= aOption;
  groupFound:= false;
  LineRec.Value:= '';
  LineRec.Comment:= '';
  LineRec.LineNo:= -1;
  for x := 0 to fLines.Count -1 do begin
    line:= fLines[x];
    groupName:= Lowercase(ExtractGroupName(line));
    if groupFound then begin
      if groupName <> '' then begin
        exit;
      end;
      line:= Trim(line);
      if Length(line) < 1 then
        continue;
      linePos:= 1;
      if GetOption then begin
        GetValue;
        GetComment;
        result:= true;
        LineRec.LineNo:= x;
        exit;
      end
      else
        Continue;
    end
    else begin
      if Lowercase(aGroup) = groupName then begin
        groupFound:= true;
        LineRec.LineNo:= x;
      end;
    end;
  end;
end;

function TMySqlIniFile.ReadBoolean(const Group, Option: string): boolean;
var
  Rec: TLineRec;
begin
  result:= GetLineRec(Group, Option, Rec);
end;

function TMySqlIniFile.ReadString(const Group, Option: string): string;
var
  Rec: TLineRec;
begin
  if GetLineRec(Group, Option, Rec) then
    result:= Rec.Value
  else
    result:= '';
end;

procedure TMySqlIniFile.SaveFile;
begin
  fLines.SaveToFile(fFileName);
end;

procedure TMySqlIniFile.UpdateLine(LineRec: TLineRec);
var
  s: string;
begin
  s:= LineRec.Option;
  if LineRec.Value <> '' then
    s:= s + ' = ' + LineRec.Value;
  if LineRec.Comment <> '' then
    s:= s + ' # ' + LineRec.Value;
  fLines[LineRec.LineNo]:= s;
end;

procedure TMySqlIniFile.WriteBoolean(const Group, Option: string;
  Value: boolean);
var
  Rec: TLineRec;
begin
  if GetLineRec(Group, Option, Rec) then begin
    if not Value then
      fLines.Delete(Rec.LineNo);
  end
  else begin
    { not found }
    if Value then begin
      WriteString(Group,Option,'');
    end;
  end;
end;

procedure TMySqlIniFile.WriteString(const Group, Option, Value: string);
var
  Rec: TLineRec;
begin
  if GetLineRec(Group, Option, Rec) then begin
    Rec.Value:= Value;
    UpdateLine(Rec);
  end
  else begin
    if Rec.LineNo < 0 then begin
      { group not found so add it }
      Rec.LineNo:= fLines.Add('[' + Group + ']');
    end;

    { LineNo is pointing at group line, need to add entry after this }
    if Rec.LineNo = fLines.Count -1 then
      { last line in file so add one more }
      Rec.LineNo:= fLines.Add('')
    else begin
      { insert a new line }
      fLines.Insert(Rec.LineNo+1,'');
      Rec.LineNo:= Rec.LineNo+1;
    end;
    Rec.Value:= Value;
    UpdateLine(Rec);
  end;
end;

end.
