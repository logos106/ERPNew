unit StreamUtils;

interface

uses
  classes, SysUtils;

  function StreamsAreEqual(stream1, stream2: TStream): boolean;

implementation

function StreamsAreEqual(stream1, stream2: TStream): boolean;
var
  buffer1, buffer2: PChar;
  readBytes: integer;
begin
  result:= false;
  if stream1.Size = stream2.Size then begin
    if (stream1 is TMemoryStream) and (stream2 is TMemoryStream) then
      result:= CompareMem( TMemoryStream(stream1).Memory, TMemoryStream(Stream2).Memory, stream1.size)
    else begin
      GetMem(buffer1,1024);
      GetMem(buffer2,1024);
      try
        result:= true;
        stream1.Seek(0,soFromBeginning);
        stream2.Seek(0,soFromBeginning);
        repeat
          readBytes:= stream1.Read(buffer1,1024);
          if readBytes > 0 then begin
            stream2.Read(buffer2,1024);
            if not CompareMem(buffer1,buffer2,readBytes) then begin
              result:= false;
              break;
            end;
          end;
        until readBytes = 0;
      finally
        FreeMem(buffer1);
        FreeMem(buffer2);
      end;
    end
  end;
end;



end.
