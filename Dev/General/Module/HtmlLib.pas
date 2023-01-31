unit HtmlLib;

interface
uses
  Windows,
  Classes,
  SysUtils,
  Graphics;

// Replace < and > to ;lt and 'gt
function ReplaceSpecialSymbols(const s: string): string;
// Decode colour - returns RGB bytes
procedure DecodeColor(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
// TColor converted to HTML hex code
function ColorToHex(aColor:TColor):String;

function HTMLFont(aFont : TFont) : string;
function HTMLAlignment(Value : TAlignment) : string;
function HTMLFontStyle(const s:string;aFont:TFont):string;
function BGColor(aColor:TColor):string;


implementation

const
  csAlignStrings : array [TAlignment] of string =
  ('left', 'right', 'center');

// (fsBold, fsItalic, fsUnderline, fsStrikeOut);
  csFontStyleStart : array [TFontStyle] of string =
  ('<B>', '<I>','<U>','<STRIKE>');

  csFontStyleEnd : array [TFontStyle] of string =
  ('</B>', '</I>','</U>','</STRIKE>');

procedure DecodeColor(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
var
  WinColor: COLORREF;
begin
  WinColor := ColorToRGB(AColor);
  Reserved := ($FF000000 and WinColor) Shr 24;
  Blue := ($00FF0000 and WinColor) Shr 16;
  Green := ($0000FF00 and WinColor) Shr 8;
  Red := ($000000FF and WinColor);
end;

function ColorToHex(aColor:TColor):String;
var
  dummy,
  R,
  G,
  B:Byte;
begin
  DecodeColor(aColor,dummy,R,G,B);
  result := Format('%2.2x%2.2x%2.2x',[B,G,R]);
end;

//Set HTML Background Color.
function BGColor(aColor:TColor):string;
begin
   result := 'BGCOLOR=#'+ColorToHex(AColor);
end;

//Get HTML Alignment string.
function HTMLAlignment(Value : TAlignment) : string;
begin
  Result := csAlignSTrings[Value];
end;

//Place Font Style Format HTML tag/identifiers around passed in string.
function HTMLFontStyle(const s:string;aFont:TFont):string;
var
  idx : TFontStyle;
begin
   Result := s;
   for idx := Low(TFontStyle) to High(TFontStyle) do
     if idx in aFont.Style then
       Result := csFontStyleStart[idx] + Result + csFontStyleEnd[idx];
end;

//Build HTML Inline Style string based on Font properties.  Leave out Style as it is
//handled by SetFormatStyle.
function HTMLFont(aFont : TFont) : string;
begin
(*
   result := 'STYLE="font-family: ' + aFont.Name+ ';'+
             'font-size: ' + IntToStr(aFont.Size) +' pt;'+
             'color:#'+ ColorToHex(aFont.Color)+';"';
*)
   Result := Format('STYLE="font-family: %s; font-size: %d pt; color=#%s;"',
                    [aFont.Name, aFont.Size, ColorToHex(aFont.Color)]);
end;

function ReplaceSpecialSymbols(const s: string): string;
(*
var
  i: Integer;
  ch: Char;
  replacestr: string;
*)
begin
(*
  Result := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    case ch of
      '<': replacestr := '&lt;';
      '>': replacestr := '&gt;';
    else
      replacestr := ch
    end;
    Result := Result + replacestr
  end
  *)
  Result := StringReplace(S, '<', '&lt;', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll, rfIgnoreCase]);
end;
end.
