unit TextFileObj;

interface

uses
  classes, sysutils;

type
  TTextFileMode = (tfmCreate=1,tfmOpenRead=2,tfmOpenWrite=3,tfmOpenReadWrite=4);
  TTextfile = class(TObject)
    Private
      stream: TFileStream;
      writer: TStreamWriter;
      Reader :TStreamReader;
      fsFilename :STring;
      function TFMModetoFMMode(const Value : TTextFileMode) : Word;
      function getEOF: boolean;
      Procedure RaiseWriterException;
      Procedure RaiseReaderException;
    Public
      constructor Create(const AFileName: string; Mode: TTextFileMode);
      destructor   Destroy; override;
      Function Readline:String;
      Function Peek :Integer;
      Function Read :Integer;
      Procedure WriteLine(const Value:String);
      Property EOF :boolean read getEOF;
  end;



implementation

{ TTextfile }
destructor TTextfile.Destroy;
begin
  if assigned(writer) then begin
    writer.Close;
    FreeandNil(writer);
  end;
  if assigned(Reader) then begin
      Reader.Close;
      FreeandNil(Reader);
  end;
  if assigned(stream) then begin
    FreeandNil(stream);
  end;
  inherited;
end;

function TTextfile.getEOF: boolean;
begin
  result := false;
  if assigned(REader) then begin
    result := REader.EndOfStream;
  end else begin
    RaiseReaderException;
  end;
end;

function TTextfile.Peek: Integer;
begin
  result := -1;
  if assigned(REader) then begin
    result := REader.Peek;
  end else begin
    RaiseReaderException;
  end;
end;

procedure TTextfile.RaiseReaderException;
begin
  Raise(Exception.Create(fsFileName +' is not Opened for Read'));
end;

procedure TTextfile.RaiseWriterException;
begin
  Raise(Exception.Create(fsFileName +' is not Opened for Write'));
end;

function TTextfile.Read: Integer;
begin
  result := -1;
  if assigned(REader) then begin
    result := REader.Read;
  end else begin
    RaiseReaderException;
  end;

end;

function TTextfile.Readline: String;
begin
  result := '';
  if assigned(REader) then begin
    result := REader.REadline;
  end else begin
    RaiseReaderException;
  end;
end;

function TTextfile.TFMModetoFMMode(const Value: TTextFileMode): Word;
begin
  result :=fmCreate;
         if Value = tfmCreate         then result :=fmCreate
    else if Value = tfmOpenRead       then result :=fmOpenRead
    else if Value = tfmOpenWrite      then result :=fmOpenWrite
    else if Value = tfmOpenReadWrite  then result :=fmOpenReadWrite;
end;

procedure TTextfile.WriteLine(const Value: String);
begin
  if assigned(Writer) then begin
    Writer.writeline(Value);
  end else begin
    RaiseWriterException;
  end;
end;

constructor TTextfile.Create(const AFileName: string; Mode: TTextFileMode);
begin
  inherited Create;
  writer:=nil;
  Reader:=nil;

  fsFileName := AFileName;
  stream:= TFileStream.Create(AFileName, TFMModetoFMMode(Mode));
  if mode in [tfmCreate,tfmOpenWrite,tfmOpenReadWrite] then begin
      writer:= TStreamWriter.Create(stream);
  end;
  if mode in [tfmOpenRead,tfmOpenReadWrite] then begin
      Reader:= TStreamReader.Create(stream);
  end;
end;
end.
