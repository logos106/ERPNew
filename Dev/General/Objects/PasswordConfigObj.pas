unit PasswordConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  TPasswordConfig = class(TJsonDbPefConfig)
  private
    function GetIncludeLowercaseChar: boolean;
    function GetIncludeNumber: boolean;
    function GetIncludeSpecialChar: boolean;
    function GetIncludeUppercaseChar: boolean;
    function GetPasswordNeverExpires: boolean;
    function GetMinimumCharacters: integer;
    procedure SetIncludeLowercaseChar(const Value: boolean);
    procedure SetIncludeNumber(const Value: boolean);
    procedure SetIncludeSpecialChar(const Value: boolean);
    procedure SetIncludeUppercaseChar(const Value: boolean);
    procedure SetPasswordNeverExpires(const Value: boolean);
    procedure SetMinimumCharacters(const Value: integer);
  public
    property IncludeUppercaseChar: boolean read GetIncludeUppercaseChar write SetIncludeUppercaseChar;
    property PasswordNeverExpires: boolean read GetPasswordNeverExpires write SetPasswordNeverExpires;
    property IncludeLowercaseChar: boolean read GetIncludeLowercaseChar write SetIncludeLowercaseChar;
    property IncludeNumber: boolean read GetIncludeNumber write SetIncludeNumber;
    property IncludeSpecialChar: boolean read GetIncludeSpecialChar write SetIncludeSpecialChar;
    property MinimumCharacters: integer read GetMinimumCharacters write SetMinimumCharacters;
    function PasswordValid(const aPassword: string; var msg: string): boolean;
  end;


implementation

uses
  SysUtils, Character, Classes;

{ TPasswordConfig }

function TPasswordConfig.GetIncludeLowercaseChar: boolean;
begin
  result := B['IncludeLowercaseChar'];
end;

function TPasswordConfig.GetIncludeNumber: boolean;
begin
  result := B['IncludeNumber'];
end;

function TPasswordConfig.GetIncludeSpecialChar: boolean;
begin
  result := B['IncludeSpecialChar'];
end;

function TPasswordConfig.GetIncludeUppercaseChar: boolean;
begin
  result := B['IncludeUppercaseChar'];
end;
function TPasswordConfig.GetPasswordNeverExpires: boolean;
begin
  result := B['PasswordNeverExpires'];
end;

function TPasswordConfig.GetMinimumCharacters: integer;
begin
  result := I['MinimumCharacters'];
end;

function TPasswordConfig.PasswordValid(const aPassword: string;
  var msg: string): boolean;
var
  HasUpper,HasLower, HasNumber, HasSpecial: boolean;
  msgList: TStringList;
  y: integer;

  function CheckPass: boolean;
  var
    x: integer;
  begin
    result := true;
    if Trim(aPassword) = '' then begin
      result := false;
      msgList.Add('Password is Blank.');
      exit;
    end;
    HasUpper := false;
    HasLower := false;
    HasNumber := false;
    HasSpecial  := false;
    for x := 1 to Length(aPassword) do begin
      if aPassword[x] = ' ' then begin
        result := false;
        msgList.Add('Password can not contain spaces.');
        exit;
      end;
      if IsLetterOrDigit(aPassword[x]) then begin

        if IsUpper(aPassword[x]) then
          HasUpper := true
        else if IsLower(aPassword[x]) then
          HasLower := true
        else if IsNumber(aPassword[x]) then
          HasNumber := true;
      end
      else
        HasSpecial := true;
    end;
  end;

begin
  result := true;
  msgList := TStringList.Create;
  try
    if (self.MinimumCharacters > 0) and (Length(aPassword) < MinimumCharacters) then begin
      result := false;
      msgList.Add('Password must be at least ' + IntToStr(MinimumCharacters) + ' characters long.');
      //  exit;
    end;
    if not CheckPass then begin
      result := false;
      // exit;
    end;

    if self.IncludeUppercaseChar and (not HasUpper) then begin
      result := false;
      msgList.Add('Password must contain at least one Uppercase character.');
      // exit;
    end;
    if self.IncludeLowercaseChar and (not HasLower) then begin
      result := false;
      msgList.Add('Password must contain at least one Lowercase character.');
      // exit;
    end;
    if self.IncludeNumber and (not HasNumber) then begin
      result := false;
      msgList.Add('Password must contain at least one number.');
      // exit;
    end;
    if self.IncludeSpecialChar and (not HasSpecial) then begin
      result := false;
      msgList.Add('Password must contain at least one Special character.');
      // exit;
    end;
  finally
    if msgList.Count > 0 then begin
      for y := 0 to msgList.Count -1 do begin
        if msg <> '' then msg := msg + ' ';
        msg := msg + msgList[y];
      end;
    end;
    msgList.Free;
  end;
end;

procedure TPasswordConfig.SetIncludeLowercaseChar(const Value: boolean);
begin
  B['IncludeLowercaseChar'] := Value;
end;

procedure TPasswordConfig.SetIncludeNumber(const Value: boolean);
begin
  B['IncludeNumber'] := Value;
end;

procedure TPasswordConfig.SetIncludeSpecialChar(const Value: boolean);
begin
  B['IncludeSpecialChar'] := Value;
end;

procedure TPasswordConfig.SetIncludeUppercaseChar(const Value: boolean);
begin
  B['IncludeUppercaseChar'] := Value;
end;
procedure TPasswordConfig.SetPasswordNeverExpires(const Value: boolean);
begin
  B['PasswordNeverExpires'] := Value;
end;

procedure TPasswordConfig.SetMinimumCharacters(const Value: integer);
begin
  I['MinimumCharacters'] := Value;
end;

end.
