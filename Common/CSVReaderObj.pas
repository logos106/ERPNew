unit CSVReaderObj;

interface

uses
  Classes;

type

  TCSVReader = class(TObject)
  private
    fFirstLine: TStringList;
    fCurrentLine: TStringList;
    fCurrentLineNo: integer;
    fOnReadLine: TNotifyEvent;
    fActive: boolean;
    fFieldSeperator: string;
  public
    constructor Create;
    destructor Destroy; override;
    function Read(Reader: TTextReader): boolean;
    function ReadFromStream(stream: TStream): boolean;
    function ReadFromFile(const aFileName: string): boolean;
    procedure Clear;
    property FirstLine: TStringList read fFirstLine;
    property CurrentLine: TStringList read fCurrentLine;
    property CurrentLineNo: integer read fCurrentLineNo;
    property OnReadLine: TNotifyEvent read fOnReadLine write fOnReadLine;
    property Active: boolean read fActive write fActive;
    property FieldSeperator: string read fFieldSeperator write fFieldSeperator;
  end;


implementation

uses
  SysUtils;

{ TCSVReader }

procedure TCSVReader.Clear;
begin
  fFirstLine.Clear;
  fCurrentLine.Clear;
  fCurrentLineNo := -1;
end;

constructor TCSVReader.Create;
begin
  fFirstLine := TStringList.Create;
  fCurrentLine := TStringList.Create;
  fCurrentLineNo := -1;
  fFieldSeperator := ',';
end;

destructor TCSVReader.Destroy;
begin
  fFirstLine.Free;
  fCurrentLine.Free;
  inherited;
end;

function TCSVReader.Read(Reader: TTextReader): boolean;
var
  Ch, LastCh: Char;
  s: string;
begin
  result := true;
  fActive := true;
  Clear;
  LastCh := #0;
  while (Reader.Peek > -1) and Active do begin
    ch := Char(Reader.Read);
    if (ch = #13) or (ch = #10) then begin
      if (LastCh <> #13) and (LastCh <> #10) then begin
        fCurrentLine.Add(Trim(s));
        s := '';
        Inc(fCurrentLineNo);
        if fCurrentLineNo = 0 then
          fFirstLine.Text := fCurrentLine.Text;
        if Assigned(fOnReadLine) then
          fOnReadLine(self);
        fCurrentLine.Clear;
      end;
    end
    else if ch = FieldSeperator then begin
      fCurrentLine.Add(Trim(s));
      s := '';
    end
    else begin
      s := s + ch;
    end;
    LastCh := ch;
  end;
  fActive := false;
end;

function TCSVReader.ReadFromFile(const aFileName: string): boolean;
var
  stream: TFileStream;
begin
  result := true;
  Clear;
  if FileExists(aFileName) then begin
    stream:= TFileStream.Create(aFileName, fmOpenRead);
    try
      result := ReadFromStream(stream);
    finally
      stream.Free;
    end;
  end;
end;

function TCSVReader.ReadFromStream(stream: TStream): boolean;
var
  StreamReader: TStreamReader;
begin
  StreamReader:= TStreamReader.Create(stream);
  try
    result := Read(StreamReader);
  finally
    StreamReader.Free;
  end;
end;

end.
