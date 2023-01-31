unit CSVParserObj;

interface

uses
  classes, IntegerListObj;

function ParseLine(const Line, SepChar, QuoteChar: string; List: TStrings; var msg: string; StripQuotes: boolean): boolean; overload;
function ParseLine(const Line: string; ColWidthList: TIntegerList; List: TStrings; var msg: string): boolean; overload;


implementation

uses
  sysutils;

function ParseLine(const Line, SepChar, QuoteChar: string; List: TStrings; var msg: string; StripQuotes: boolean): boolean;
var
  x, QuoteCount: integer;
  val: string;
  inString, UseQuote: boolean;

  function IsFieldEnd(posn: integer): boolean;
  var i: integer;
  begin
    result:= true;
    for i := posn to Length(Line) -1 do begin
      if Line[i] = SepChar then
        break
      else if Ord(Line[i]) > 13 then begin
        result:= false;
        break
      end;
    end;
  end;

begin
  result:= true;
  msg:= '';
  List.Clear;
  x:= 1;
  inString:= false;
  val:= '';
  UseQuote:= not (QuoteChar = '');
  QuoteCount:= 0;
  while x <= Length(Line) do begin
    if Line[x] = SepChar then begin
      if not Instring then begin
        List.Add(val);
        val:= '';
        QuoteCount:= 0;
      end
      else begin
        val:= val + Line[x];
      end;
    end
    else if UseQuote and (Line[x] = QuoteChar) then begin
      Inc(QuoteCount);
      if InString then begin
        if not Odd(QuoteCount) then begin
          { is this really the end of the quoted field ... }
          if IsFieldEnd(x+1) then
            InString:= false;
        end;
      end
      else begin
        if Trim(val) <> '' then begin
          result:= false;
          msg:= 'Invalid text format in column ' + IntToStr(List.Count + 1);
          exit;
        end;
      end;
      if QuoteCount = 1 then
        InString:= true;
      if ((QuoteCount = 1) or (not InString)) and StripQuotes then begin
        { skip adding quote char }
      end
      else
        val:= val + Line[x];
    end
    else begin
      if (*InString and *)(x < Length(Line)) then begin
        if (line[x] = '\') then begin
         { escape char }
          case Ord(line[x+1]) of
            34: begin
                  val:= val + '"';
                  Inc(x);
                end;
            92: begin
                  val:= val + '\';
                  Inc(x);
                end;
            47: begin
                  val:= val + '/';
                  Inc(x);
                end;
            98: begin                        // backspace
                  val:= val + Chr(8);
                  Inc(x);
                end;
            102: begin                       // form feed
                  val:= val + Chr(12);
                  Inc(x);
                end;
            110: begin                       // new line
                  val:= val + Chr(10);
                  Inc(x);
                end;
            114: begin                      // carriage return
                  val:= val + Chr(13);
                  Inc(x);
                end;
            116: begin                      // horizontal tab
                  val:= val + Chr(09);
                  Inc(x);
                end;
            else
              val:= val + line[x];
          end;
        end
        else
          val:= val + Line[x];
      end
      else
        val:= val + Line[x];
    end;
    Inc(x);
  end;
//  if val <> '' then
  List.Add(val);
end;

function ParseLine(const Line: string; ColWidthList: TIntegerList; List: TStrings; var msg: string): boolean;
var
  x, posn: integer;

begin
  result:= true;
  List.Clear;
  msg:= '';
  if Length(Line) <> ColWidthList.Total then begin
    result:= false;
    msg:= 'The total of all the column widths does not match the length of the line';
    exit;
  end;
  posn:= 0;
  for x := 0 to ColWidthList.Count -1  do begin
    List.Add(Copy(Line,posn,ColWidthList[x]));
    posn:= posn + ColWidthList[x];
  end;
end;



end.
