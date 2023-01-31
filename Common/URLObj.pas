unit URLObj;

interface

type

  TURLObj = class(TObject)
  private
    fPath: string;
    fPort: string;
    fHost: string;
    function GetURL: string;
    procedure SetURL(const Value: string);
  public
    constructor Create(const aURL: string = '');
    property URL: string read GetURL write SetURL;
    property Host: string read fHost write fHost;
    property Path: string read fPath write fPath;
    property Port: string read fPort write fPort;
  end;

implementation

{ TURLObj }

constructor TURLObj.Create(const aURL: string);
begin
  URL := aURL;
end;

function TURLObj.GetURL: string;
begin
  result := fHost;
  if fPort <> '' then
    result := result + ':' + fPort;
  if fPath <> '' then
    result := result + '/' + fPath;
end;

procedure TURLObj.SetURL(const Value: string);
var
  x: integer;
  isHost,isPort,isPath: boolean;
  ch: Char;
  s: string;
begin
  fHost := '';
  fPort := '';
  fPath := '';
  isHost := true;
  isPort := false;
  isPath := false;
  s := '';
  for x := 1 to Length(Value) do begin
    ch := Value[x];
    if isHost then begin
      if (ch = '/') or (ch = '\') then begin
        if (Value[x+1] = '/') or (Value[x+1] = '\') or (Value[x-1] = '/') or (Value[x-1] = '\')then begin
          s := s + ch;
        end
        else begin
          fHost := s;
          s := '';
          isPath := true;
          isHost := false;
        end;
      end
      else if (ch = ':') then begin
        fHost := s;
        s := '';
        isPort := true;
        isHost:= false;
      end
      else begin
        s := s + ch;
      end;
    end
    else if isPort then begin
      if (ch = '/') or (ch = '\') then begin
        fPort := s;
        s := '';
        isPath := true;
        isPort := false;
      end
      else begin
        s := s + ch;
      end;
    end
    else begin
      s:= s + ch;
    end;
  end;
  if isHost then
    fHost := s
  else if isPort then
    fPort := s
  else if isPath then
    fPath := s
end;

end.
