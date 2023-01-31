unit HTMLUtils;

interface

uses
  Classes;

type
  THTMLParser = class;
  THTMLParserOnTagEvent = procedure (Sender: THTMLParser; TagName: string) of object;

  THTMLParser = class
  private
    fStringList: TStringList;
    fOnTagStart: THTMLParserOnTagEvent;
    fTagString: string; { whole content of tag eg <img border=0 width=32 height=32 src="2.jpg"> }
    fHTMLStrings: TStrings;
    function GetAttribute(aName: string): string;
    procedure SetAttribute(aName: string; const Value: string);
    function GetHTMLStrings: TStrings;
    function GetHtmlText: string;
    procedure SetHtmlText(const Value: string);
  public
    destructor Destroy; override;
    property HTMLStrings: TStrings read GetHTMLStrings write fHTMLStrings;
    property OnTagStart: THTMLParserOnTagEvent read fOnTagStart write fOnTagStart;
    procedure Parse;
    property Attribute[aName: string]: string read GetAttribute write SetAttribute;
    property HtmlText: string read GetHtmlText write SetHtmlText;
  end;


  function IsHTMLDoc(HTMLData: TStrings): boolean;
  function HasBody(HTMLData: TStrings): boolean;
  function ExtractBody(HTMLData: TStrings): string;
//  procedure ReplaceImageSource(HTMLData: TStrings; oldSource, newSource: string);

implementation

uses
  StrUtils, SysUtils, Character;

function IsTagName(val: string; TagName: string): boolean;
var
  s, leftStr: string;
  n: integer;
begin
  result := false;
  s := Lowercase(Trim(val));
  n := Pos(Lowercase(TagName), s);
  if n = 0 then exit;
  leftStr := Trim(copy(s,1,n-1));
  if not ((leftStr = '') or (leftStr = '/')) then exit;
  if Length(s) > (n + Length(TagName)) then begin
    if s[n + Length(TagName)] <> ' ' then exit
  end;
  result := true;
end;

function IsTagStart(val: string; TagName: string): boolean;
var
  s, leftStr: string;
  n: integer;
begin
  result := false;
  s := Lowercase(Trim(val));
  n := Pos(Lowercase(TagName), s);
  if n = 0 then exit;
  leftStr := Trim(copy(s,1,n-1));
  if (not (leftStr = '')) or (leftStr = '/') then exit;
  if Length(s) > (n + Length(TagName)) then begin
    if s[n + Length(TagName)] <> ' ' then exit
  end;
  result := true;
end;

function ContainsTag(HTMLData: TStrings; TagName: string): boolean;
var
  x: integer;
  s: string;
  isTag: boolean;
begin
  result := false;
  s:= '';
  isTag := false;
  for x := 1 to Length(HTMLData.Text) do begin
    if HTMLData.Text[x] = '<' then begin
      isTag := true;
      s:= '';
    end
    else if HTMLData.Text[x] = '>' then begin
      isTag := false;
      if IsTagName(s,TagName) then begin
        result := true;
        exit;
      end;
    end
    else begin
      if isTag then
        s := s + HTMLData.Text[x];
    end;
  end;
end;

function IsHTMLDoc(HTMLData: TStrings): boolean;
begin
  result := ContainsTag(HTMLData, 'html');
end;

function HasBody(HTMLData: TStrings): boolean;
begin
  result := ContainsTag(HTMLData, 'body');
end;

function ExtractBody(HTMLData: TStrings): string;
var
  x: integer;
  s: string;
  isTag: boolean;
  ISBody: boolean;
begin
  result := '';
  s:= '';
  isTag := false;
  isBody := false;
  for x := 1 to Length(HTMLData.Text) do begin
    if HTMLData.Text[x] = '<' then begin
      isTag := true;
      s:= '';
    end
    else if HTMLData.Text[x] = '>' then begin
      isTag := false;
      if IsTagName(s,'body') then begin
        if StrUtils.ContainsText(s,'/') then
          exit;
        isBody := true;
        continue;
      end;
    end
    else begin
      if isTag then
        s := s + HTMLData.Text[x];
    end;
    if IsBody then
      result := result + HTMLData.Text[x];
  end;
end;

//procedure ReplaceImageSource(HTMLData: TStrings; oldSource, newSource: string);
//var
//  x: integer;
//  s: string;
//  isTag: boolean;
//  Data: string;
//
//  function ChangeSource(str: string): string;
//  var
//    i: integer;
//    src: string;
//    n: integer;
//    srcTagFound: boolean;
//    quoteFound: boolean;
//  begin
//    result := '';
//    srcTagFound := false;
//    quoteFound := false;
//    for i := 1 to Length(str) do begin
//      result := result + str[i];
//      if srcTagFound then begin
//        if QuoteFound then begin
//          if str[i] = '"' then begin
//            if SameText(src, oldSource) then begin
//
//
//            end
//            else
//              exit; {  }
//          end
//          else
//            src := src + str[i];
//        end
//        else begin
//          { still looking }
//          if str[i] = '"' then
//            QuoteFound := true;
//        end;
//
//
//      end
//      else begin
//        { still looking for it }
//        if SameText(RightStr(result,3),'src') then
//          srcTagFound := true;
//      end;
//
//    end;
//  end;
//
//begin
//  data := '';
//  s:= '';
//  isTag := false;
//  for x := 1 to Length(HTMLData.Text) do begin
//    if HTMLData.Text[x] = '<' then begin
//      isTag := true;
//      s:= '';
//    end
//    else if HTMLData.Text[x] = '>' then begin
//      isTag := false;
//      if IsTagStart(s,'img') then begin
//
//
//        s:= '';
//        IsTag := false;
//      end;
//    end
//    else begin
//      if isTag then
//        s := s + HTMLData.Text[x];
//    end;
//    Data := Data + HTMLData.Text[x];
//  end;
//end;

{ THTMLParser }

destructor THTMLParser.Destroy;
begin
  fStringList.Free;
  inherited;
end;

function THTMLParser.GetAttribute(aName: string): string;
var
  x: integer;
  s: string;
  attFound: boolean;
  equalFound: boolean;
  InQuote: boolean;
begin
  result := '';
  s := '';
  attFound := false;
  equalFound := true;
  InQuote := false;
  for x := 1 to Length(fTagString) do begin
    if not AttFound then begin
      if TCharacter.IsLetterOrDigit(fTagString[x]) then
        s := s + fTagString[x]
      else begin
        if SameText(s, aName) then begin
          AttFound := true;
          if fTagString[x] = '=' then begin
            equalFound := true;
          end;
        end
        else
          s := '';
      end;
    end
    else begin
      if EqualFound then begin
        if InQuote then begin
          result := result + fTagString[x];
          if fTagString[x] = '"' then
            InQuote := false;
        end
        else if fTagString[x] = '"' then begin
          result := result + fTagString[x];
          InQuote := true;
        end
        else if fTagString[x] = #13 then begin
          { ignore }
        end
        else if fTagString[x] = #10 then begin
          { ignore }
        end
        else if (fTagString[x] = ' ') or (fTagString[x] = '>') then begin
          break;
        end
        else
          result := result + fTagString[x];
      end
      else begin
        if fTagString[x] = '=' then
          equalFound := true;
      end;
    end;
  end;
  result := Trim(result);
end;

function THTMLParser.GetHTMLStrings: TStrings;
begin
  if Assigned(fHTMLStrings) then
    Result := fHTMLStrings
  else
    result := fStringList;
end;

function THTMLParser.GetHtmlText: string;
begin
  if Assigned(fHTMLStrings) then
    Result := fHTMLStrings.Text
  else
    result := fStringList.Text;
end;

procedure THTMLParser.Parse;
var
  x: integer;
  i: integer;
  s: string;
  isTag, IsTagEnd: boolean;
  Data: string;
  tagName: string;
begin
  data := '';
  s:= '';
  isTag := false;
  for x := 1 to Length(HTMLStrings.Text) do begin
    if HTMLStrings.Text[x] = '<' then begin
      isTag := true;
      { if it was a false start befor .. write out data }
      if s <> '' then Data := Data + s;
      s:= '<';
    end
    else if HTMLStrings.Text[x] = '>' then begin
      s := s + '>';
      fTagString := s;
      tagName := '';
      IsTagEnd := false;
      for i := 2 to Length(fTagString) do begin
        if fTagString[i] = '/' then IsTagEnd := true
        else if (fTagString[i] = ' ') or (fTagString[i] = '>') then begin
          if IsTagEnd then begin


          end
          else begin
            if Assigned(fOnTagStart) then
              fOnTagStart(self, tagName);
          end;
          Break;
        end
        else
          tagName := TagName + fTagString[i];
      end;

      Data := Data + fTagString;
      s:= '';
      IsTag := false;
    end
    else begin
      if isTag then
        s := s + HTMLStrings.Text[x]
      else
        Data := Data + HTMLStrings.Text[x];
    end;
  end;
  HTMLStrings.Text := Data;
end;

procedure THTMLParser.SetAttribute(aName: string; const Value: string);
var
  x: integer;
  s: string;
  attFound: boolean;
  equalFound: boolean;
  InQuote: boolean;
  PosStart: integer;
  POsEnd: integer;
begin
  s := '';
  attFound := false;
  equalFound := false;
  InQuote := false;
  PosStart := 0;
  PosEnd := 0;
  for x := 1 to Length(fTagString) do begin
    if not AttFound then begin
      if TCharacter.IsLetterOrDigit(fTagString[x]) then
        s := s + fTagString[x]
      else begin
        if SameText(s, aName) then begin
          AttFound := true;
          if fTagString[x] = '=' then begin
            equalFound := true;
            PosStart := x + 1;
          end;
        end
        else
          s := '';
      end;
    end
    else begin
      if EqualFound then begin
        if InQuote then begin
          if fTagString[x] = '"' then
            InQuote := false;
        end
        else if fTagString[x] = '"' then begin
          InQuote := true;
        end
        else if (fTagString[x] = ' ') or (fTagString[x] = '>') then begin
          PosEnd := x -1;
          break;
        end
      end
      else begin
        if fTagString[x] = '=' then begin
          equalFound := true;
          PosStart := x + 1;
        end;
      end;
    end;
  end;
  if (PosStart > 0) and (PosEnd = 0) then
    PosEnd := x;
  if PosStart > 0 then
    fTagString := Copy(fTagString,1,PosStart-1) + Value + Copy(fTagString,PosEnd+1, Length(fTagString))
  else
    fTagString := Copy(fTagString,1,Length(fTagString)-1) + ' ' + aName  + '=' + Value + '>';
end;

procedure THTMLParser.SetHtmlText(const Value: string);
begin
  if Assigned(fHTMLStrings) then
    fHTMLStrings.Text := Value
  else begin
    if not Assigned(fStringList) then
      fStringList := TStringList.Create;
    fStringList.Text := Value;
  end;
end;

end.
