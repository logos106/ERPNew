unit CardStripeObj;

interface

type
  TCardStripe = class(TObject)
  private
    fName: string;
    fExpirationDate: string;
    fCardNumber: string;
    fDiscretionaryData: string;
    fServiceCode: string;
  public
    property CardNumber: string read fCardNumber write fCardNumber;
    property Name: string read fName write fName;
    property ExpirationDate: string read fExpirationDate write fExpirationDate; { YYMM }
    property ServiceCode: string read fServiceCode write fServiceCode;          { 3 characters }
    property DiscretionaryData: string read fDiscretionaryData write fDiscretionaryData;
    function ScanCard(const Data: string; var msg: string): boolean;
    class function IsCardStripe(const Data: string): boolean;
  end;

implementation

uses
  Types, StrUtils, SysUtils, Character;

{ TCardStripe }

// https://en.wikipedia.org/wiki/Magnetic_stripe_card

class function TCardStripe.IsCardStripe(const Data: string): boolean;
var
  s: string;
begin
  s := Trim(Data);
  result :=  (SameText(LeftStr(s,2),'%B') and (Pos('^',s) > 0)) or
    ((Pos(';',s) > 0) and (Pos('=',s) > 0));
end;

function TCardStripe.ScanCard(const Data: string; var msg: string): boolean;
var
  i: integer;
  track1, track2: string;
  arr: TStringDynArray;
  T1Part1, T1Part2, T1Part3: string;
  T2Part1, T2Part2: string;
begin
  result := true;
  CardNumber := '';
  Name := '';
  ExpirationDate := '';
  ServiceCode := '';
  DiscretionaryData := '';

  track1 := '';
  track2 := '';
  T1Part1 := '';
  T1Part2 := '';
  T1Part3 := '';
  T2Part1 := '';
  T2Part2 := '';

//  if not SameText(LeftStr(DAta,2),'%B') then begin
//    result = false;
//    msg := '
//    exit;
//  end;
  i := Pos(';',Data);
  if i = 0 then begin
    result := false;
    msg := 'Error reading card (Track 2 start character missing)';
    exit;
  end;
  arr := SplitString(Data,';');
  track1 := arr[0];
  track2 := arr[1];

  if track1 <> '' then begin
    if SameText(LeftStr(track1,2),'%B') then begin
      { probably Track 1, Format B }
      arr := SplitString(track1,'^');
      if Length(arr) >= 3 then begin
        T1Part1 := Copy(arr[0],3,Length(arr[0]));
        T1Part2 := arr[1];
        T1Part3 := arr[2];
      end;
    end;
    { else Track 1, Format A - proprietary }
  end;
  if track2 <> '' then begin
    arr := SplitString(track2,'=');
    if Length(arr) >= 2 then begin
      T2Part1 := arr[0];
      T2Part2 := arr[1];
    end;
  end;
  if (track1 <> '') or (track2 <> '') then begin
    if T1Part1 <> '' then
      CardNumber := T1Part1;
    if T2Part1 <> '' then begin
      if CardNumber = '' then
        CardNumber := T2Part1
      else if (T2Part1 <> CardNumber) then begin
        result := false;
        msg := 'Error reading card (Track 1 and Track 2 Card Numbers do not match)';
        exit;
      end;
    end;
    if T1Part2 <> '' then
      Name := T1Part2;
    if T1Part3 <> '' then begin
      ExpirationDate := Copy(T1Part3,1,4);
      ServiceCode := Copy(T1Part3,5,3);
      DiscretionaryData := Copy(T1Part3,8,Length(T1Part3));
    end
    else if T2Part2 <> '' then begin
      ExpirationDate := Copy(T2Part2,1,4);
      ServiceCode := Copy(T2Part2,5,3);
      DiscretionaryData := Copy(T2Part2,8,Length(T1Part3));
    end;
    if Length(ExpirationDate) <> 4 then begin
      result := false;
      msg := 'Error reading card (Invalid Expiration Date length)';
      exit;
    end;
    while not (TCharacter.IsNumber(DiscretionaryData[Length(DiscretionaryData)]) or (DiscretionaryData[Length(DiscretionaryData)] = '')) do
      DiscretionaryData := Copy(DiscretionaryData,1,Length(DiscretionaryData)-1);
  end
  else begin
    result := false;
    msg := 'Error reading card (No data found)';
  end;
end;

end.
