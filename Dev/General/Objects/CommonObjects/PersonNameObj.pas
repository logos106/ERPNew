unit PersonNameObj;

interface

type

  TPersonName = class
  private
    FLastName: string;
    FTitle: string;
    FMiddleName: string;
    FFirstName: string;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetMiddleName(const Value: string);
    procedure SetTitle(const Value: string);
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function IsTitle(str: string): boolean;
  public
    constructor Create(aName: string = '');
    property Title: string read FTitle write SetTitle;
    property FirstName: string read FFirstName write SetFirstName;
    property MiddleName: string read FMiddleName write SetMiddleName;
    property LastName: string read FLastName write SetLastName;
    property AsString: string read GetAsString write SetAsString;
  end;

implementation

uses
  types, StrUtils, SysUtils;

{ TPersonName }

constructor TPersonName.Create(aName: string);
begin
  if aName <> '' then
    AsString := aName;
end;

function TPersonName.GetAsString: string;
begin
  result := Title;
  if FirstName <> '' then begin
    if result <> '' then result := result + ' ';
    result := result + FirstName;
  end;
  if MiddleName <> '' then begin
    if result <> '' then result := result + ' ';
    result := result + MiddleName;
  end;
  if LastName <> '' then begin
    if result <> '' then result := result + ' ';
    result := result + LastName;
  end;
end;

function TPersonName.IsTitle(str: string): boolean;
begin
  result :=
    SameText(str,'Mr') or
    SameText(str,'Mrs') or
    SameText(str,'Ms') or
    SameText(str,'Miss') or
    SameText(str,'Mx') or
    SameText(str,'Master') or
    SameText(str,'Maid') or
    SameText(str,'Madam') or
    SameText(str,'Madame') or
    SameText(str,'Dr');
end;

procedure TPersonName.SetAsString(const Value: string);
var
  arr: TStringDynArray;
  x: integer;
begin
  FLastName := '';
  FTitle := '';
  FMiddleName := '';
  FFirstName := '';
  arr := SplitString(Trim(Value), ' ');
  if High(arr) > 0 then begin
    if High(arr) > 0 then begin
      if IsTitle(arr[0]) then begin
        Title := arr[0];
        if High(arr) = 1 then begin
          LastName := arr[1];
        end
        else if High(arr) = 2 then begin
          FirstName := arr[1];
          LastName := arr[2];
        end
        else if High(arr) = 3 then begin
          FirstName := arr[1];
          MiddleName := arr[2];
          LastName := arr[3];
        end
        else begin
          FirstName := arr[1];
          MiddleName := arr[2];
          for x := 3 to High(arr) do begin
            if x > 3 then LastName := LastName + ' ';
            LastName := LastName + arr[x];
          end;
        end;
      end
      else begin
        { no title }
        if High(arr) = 1 then begin
          FirstName := arr[0];
          LastName := arr[1];
        end
        else if High(arr) = 2 then begin
          FirstName := arr[0];
          MiddleName := arr[1];
          LastName := arr[2];
        end
        else begin
          FirstName := arr[0];
          MiddleName := arr[1];
          for x := 2 to High(arr) do begin
            if x > 2 then LastName := LastName + ' ';
            LastName := LastName + arr[x];
          end;
        end;
      end;
    end
    else
      FirstNAme := arr[0];
  end;
end;

procedure TPersonName.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TPersonName.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

procedure TPersonName.SetMiddleName(const Value: string);
begin
  FMiddleName := Value;
end;

procedure TPersonName.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

end.
