unit ImageTypeUtils;

interface

function GetImageType(FileName: String): string;

implementation

uses
  SysUtils, Classes;

var
  JPG_HEADER: array[0..2] of byte = ($FF, $D8, $FF);
  GIF_HEADER: array[0..2] of byte = ($47, $49, $46);
  BMP_HEADER: array[0..1] of byte = ($42, $4D);
  PNG_HEADER: array[0..3] of byte = ($89, $50, $4E, $47);
  TIF_HEADER: array[0..2] of byte = ($49, $49, $2A);
  TIF_HEADER2: array[0..2] of byte = (77, 77, 00);

function GetImageType(FileName: String): string;
var
  Stream: TFileStream;
  MemStr: TMemoryStream;
//  buf: integer;
//  tmp: string;
begin
  Result := 'Unknown';
  Stream := TFileStream.Create(FileName, fmOpenRead);
  MemStr := TMemoryStream.Create;
  try
  MemStr.CopyFrom(Stream, 5);
  if MemStr.Size > 4 then begin
    if CompareMem(MemStr.Memory, @JPG_HEADER, SizeOf(JPG_HEADER)) then
    Result := 'JPEG'
    else if CompareMem(MemStr.Memory, @GIF_HEADER, SizeOf(GIF_HEADER)) then
    Result := 'GIF'
    else if CompareMem(MemStr.Memory, @PNG_HEADER, SizeOf(PNG_HEADER)) then
    Result := 'PNG'
    else if CompareMem(MemStr.Memory, @BMP_HEADER, SizeOf(BMP_HEADER)) then
    Result := 'BMP'
    else if CompareMem(MemStr.Memory, @TIF_HEADER, SizeOf(TIF_HEADER)) then
    Result := 'TIF'
    else if CompareMem(MemStr.Memory, @TIF_HEADER2, SizeOf(TIF_HEADER2)) then
    Result := 'TIF';
    end;
  finally
    Stream.Free;
    MemStr.Free;
  end;
end;


end.
