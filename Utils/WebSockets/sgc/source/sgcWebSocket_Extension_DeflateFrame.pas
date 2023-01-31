{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Extension_DeflateFrame;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  IdZLib, IdGlobal, IdStream{$IFDEF INDY10_2},IdZLibHeaders, IdCTypes{$ENDIF},
  sgcWebSocket_Extension_Base;

type
  {$IFNDEF INDY10_5_5}
  {$IFDEF INDY10_2}
  TIdC_UINT  = Cardinal;
  {$ELSE}
  TIdC_UINT  = Integer;
  {$ENDIF}  
  PIdC_UINT  = ^TIdC_UINT;
  PtrInt = LongInt;

  RawByteString = type AnsiString;
  PRawByteString = ^RawByteString;
  _UTF8Str = UTF8String;
  _PUTF8Str = PUTF8String;
  _RawByteStr = RawByteString;
  _PRawByteStr = PRawByteString;
  {$ENDIF}

  TMemStreamAccess = class(TMemoryStream);

  TsgcWSExtension_DeflateFrame = class(TsgcWSExtension_Base)

  { from TsgcWSExtension_Base }
  public
    procedure Assign(aSource: TPersistent); override;
  public
    procedure DecodeHeader(aByte: Byte); override;
    procedure EncodeHeader(var aByte: Byte); override;
  public
    function GetName: String; override;
  { from TsgcWSExtension_Base }

  private
    FWindowBits: Integer;
    FMessageCompressed: Boolean;
    procedure SetWindowBits(const Value: Integer);

  { helpers }
  protected
    function ExpandStream(AStream: TStream; const ACapacity : Int64): Boolean;
    function DMAOfStream(AStream: TStream; out Available: TIdC_UINT): Pointer;
    function CanResizeDMAStream(AStream: TStream): boolean;
  { helpers }

  { inflate }
  private
    FInfStream: TStringStream;
  private
    function GetInfStream: TStringStream;
  protected
    property InfStream: TStringStream read GetInfStream write FInfStream;
  protected
    procedure DoInflateFrame(InStream, OutStream: TStream);
  { inflate }

  { deflate }
  private
    FDefStream: TStringStream;
  private
    function GetDefStream: TStringStream;
  protected
    property DefStream: TStringStream read GetDefStream write FDefStream;
  protected
    function IdRead(var aStrmRec: TZStreamRec; var VBuffer: TIdBytes; AOffset:
        Integer): Longint;
    function DoRead(var aStrmRec: TZStreamRec; var aBuffer): LongInt;
  protected
    procedure DoDeflateFrame(InStream, OutStream: TStream);
  { deflate }

  public
    constructor Create; virtual;
    destructor Destroy; override;

  public
    function InflateFrame(var aStream: TStream): Boolean;
    function DeflateFrame(var aStream: TStream): Boolean;
  public
    property MessageCompressed: Boolean read FMessageCompressed;
  published
    property WindowBits: Integer read FWindowBits write SetWindowBits;
  End;



implementation

uses sgcWebSocket_Const, sgcWebSocket_Helpers;


{$IFNDEF INDY10_2}
function DeflateInit2(var stream: TZStreamRec; level, method, windowBits,
  memLevel, strategy: Integer): Integer;
begin
  result := deflateInit2_(stream,level,method,windowBits,memLevel,strategy,
    ZLIB_VERSION,SizeOf(TZStreamRec));
end;


function InflateInit2(var stream: TZStreamRec; windowBits: Integer): Integer;
begin
  result := inflateInit2_(stream,windowBits,ZLIB_VERSION,SizeOf(TZStreamRec));
end;
{$ENDIF}

constructor TsgcWSExtension_DeflateFrame.Create;
begin
  WindowBits := 15;
end;

destructor TsgcWSExtension_DeflateFrame.Destroy;
begin
  FreeAndNil(FInfStream);
  FreeAndNil(FDefStream);
end;

procedure TsgcWSExtension_DeflateFrame.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSExtension_DeflateFrame then
    WindowBits := TsgcWSExtension_DeflateFrame(aSource).WindowBits;
  inherited Assign(aSource);
end;

function TsgcWSExtension_DeflateFrame.IdRead(var aStrmRec: TZStreamRec; var
    VBuffer: TIdBytes; AOffset: Integer): Longint;
begin
  aStrmRec.next_out := PAnsiChar(@VBuffer[AOffset]);
  aStrmRec.avail_out := CS_DEFLATE_BUFFER;
  aStrmRec.total_out := 0;
  while (aStrmRec.avail_out > 0) and (aStrmRec.avail_in > 0) do
  begin
    if CCheck(inflate(aStrmRec, Z_NO_FLUSH)) = Z_STREAM_END then
      Break;
  end;
  Result := CS_DEFLATE_BUFFER - aStrmRec.avail_out;
end;


function TsgcWSExtension_DeflateFrame.ExpandStream(AStream: TStream; const ACapacity : Int64): Boolean;
begin
  Result := True;
  AStream.Size := ACapacity;
  if AStream is TMemoryStream then begin
    AStream.Size := TMemStreamAccess(AStream).Capacity;
  end;
end;


function TsgcWSExtension_DeflateFrame.CanResizeDMAStream(AStream: TStream): boolean;
begin
  Result := (AStream is TCustomMemoryStream) or
            (AStream is TStringStream);
end;

procedure TsgcWSExtension_DeflateFrame.DecodeHeader(aByte: Byte);
begin
  FMessageCompressed := (aByte and $40) = $40;
end;

function TsgcWSExtension_DeflateFrame.DMAOfStream(AStream: TStream; out Available: TIdC_UINT): Pointer;
begin
  if AStream is TCustomMemoryStream then
    Result := TCustomMemoryStream(AStream).Memory
  else
    Result := nil;

  if Result <> nil then
  begin
    Available := AStream.Size - AStream.Position;
    Inc(PtrInt(Result), AStream.Position);
  end
  else
    Available := 0;
end;

procedure TsgcWSExtension_DeflateFrame.DoInflateFrame(InStream, OutStream: TStream);
var
  strm   : TZStreamRec;
  InBuf, OutBuf : PAnsiChar;
  UseInBuf, UseOutBuf : boolean;
  LastOutCount : TIdC_UINT;

  procedure WriteOut;
  begin
    if UseOutBuf then
    begin
      if LastOutCount > 0 then
        OutStream.Write(OutBuf^, LastOutCount - strm.avail_out);

      strm.avail_out := CS_DEFLATE_BUFFER;
      strm.next_out  := OutBuf;
    end else
    begin
      if strm.avail_out = 0 then
        ExpandStream(OutStream, OutStream.Size + CS_DEFLATE_BUFFER);

      OutStream.Seek(LastOutCount - strm.avail_out, soCurrent);
      strm.next_out  := DMAOfStream(OutStream, strm.avail_out);
    end;
    LastOutCount := strm.avail_out;
  end;

var
  Finished : boolean;
begin
  FillChar(strm, SizeOf(strm), 0);

  InBuf          := nil;
  OutBuf         := nil;
  LastOutCount   := 0;

  strm.next_in   := DMAOfStream(InStream, strm.avail_in);
  UseInBuf := strm.next_in = nil;

  if UseInBuf then
    GetMem(InBuf, CS_DEFLATE_BUFFER);

  try
    UseOutBuf := not CanResizeDMAStream(OutStream);
    if UseOutBuf then begin
      GetMem(OutBuf, CS_DEFLATE_BUFFER);
    end;

    try
      CCheck(deflateInit2(strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, -FWindowBits, 1, Z_DEFAULT_STRATEGY));
      if InfStream.Size > 0 then
      {$IFDEF LAZARUS}
        CCheck(deflateSetDictionary(strm, PAnsiChar(InfStream.DataString), InfStream.Size));
      {$ELSE}
        {$IFNDEF D2009}
        CCheck(deflateSetDictionary(strm, PAnsiChar(RawByteString(InfStream.DataString)), InfStream.Size));
        {$ELSE}
        CCheck(deflateSetDictionary(strm, InfStream.Memory, InfStream.Size));
        {$ENDIF}
      {$ENDIF}

      InfStream.CopyFrom(InStream, InStream.Size);
      InStream.Seek(0, soFromBeginning);
      repeat
        if strm.avail_in = 0 then
        begin
          if UseInBuf then
          begin
            strm.avail_in := InStream.Read(InBuf^, CS_DEFLATE_BUFFER);
            strm.next_in  := InBuf;
          end;
          if strm.avail_in = 0 then
            Break;
        end;

        if strm.avail_out = 0 then
          WriteOut;

        CCheck(deflate(strm, Z_SYNC_FLUSH));
      until
        False;

      repeat
        Finished := CCheck(deflate(strm, Z_FINISH)) = Z_STREAM_END;
        WriteOut;
      until Finished;

      if not UseOutBuf then
        OutStream.Size := OutStream.Position;

      if UseInBuf then
        InStream.Seek(-strm.avail_in, soCurrent)
      else
        InStream.Seek(strm.total_in, soCurrent);

      CCheck(deflateEnd(strm));
    finally
      if OutBuf <> nil then
        FreeMem(OutBuf);
    end;
  finally
    if InBuf <> nil then
      FreeMem(InBuf);
  end;

  if OutStream.Size > 6 then
    OutStream.Size := OutStream.Size - 6;
end;

function TsgcWSExtension_DeflateFrame.DeflateFrame(var aStream: TStream): Boolean;
var
  oStream: TMemoryStream;
begin
  result := False;
  Try
    aStream.WriteBuffer(CS_Deflate_Bytes, Length(CS_Deflate_Bytes));
    aStream.Seek(0, soFromBeginning);

    oStream := TMemoryStream.Create;
    Try
      DoDeflateFrame(aStream, oStream);

      aStream.Size := 0;
      oStream.Seek(0, soFromBeginning);
      aStream.CopyFrom(oStream, oStream.Size);
    Finally
      FreeAndNil(oStream);
    End;

    result := True;
  Except
    //
  End;
end;

procedure TsgcWSExtension_DeflateFrame.DoDeflateFrame(InStream, OutStream: TStream);
var
  strm   : TZStreamRec;
  i: integer;
  vBuffer: Array [0..CS_DEFLATE_BUFFER-1] of AnsiChar;
begin

  fillchar(strm, SizeOf(strm), 0);
  strm.zalloc := nil;
  strm.zfree := nil;
  strm.next_in   := nil;
  strm.avail_in  := 0;

  DCheck(inflateInit2(strm, -WindowBits));

  if DefStream.Size > 0 then
    {$IFDEF LAZARUS}
    DCheck(inflateSetDictionary(strm, PAnsiChar(DefStream.DataString), DefStream.Size));
    {$ELSE}
    {$IFNDEF D2009}
    DCheck(inflateSetDictionary(strm, PAnsiChar(RawByteString(DefStream.DataString)), DefStream.Size));
    {$ELSE}
    DCheck(inflateSetDictionary(strm, DefStream.Memory, DefStream.Size));
    {$ENDIF}
    {$ENDIF}

  InStream.Seek(0, soFromBeginning);

  while True do
  begin
    strm.avail_in := InStream.Read(vBuffer, CS_INFLATE_BUFFER);
    if strm.avail_in = 0 then
      break;
    strm.next_in  := vBuffer;

    i := DoRead(strm, vBuffer);
    if i <> 0 then
      OutStream.WriteBuffer(vBuffer, i)
    else
      Break;
  end;

  DCheck(inflateEnd(strm));

  // ... copy to buffer
  OutStream.Seek(0, soFromBeginning);
  DefStream.CopyFrom(OutStream, OutStream.Size);
end;

function TsgcWSExtension_DeflateFrame.DoRead(var aStrmRec: TZStreamRec; var
    aBuffer): LongInt;
var
  LBytes: TIdBytes;
begin
  SetLength(LBytes, CS_DEFLATE_BUFFER);
  Result := IdRead(aStrmRec, LBytes, 0);
  if Result > 0 then begin
    Move(LBytes[0], aBuffer, Result);
  end;
end;

procedure TsgcWSExtension_DeflateFrame.EncodeHeader(var aByte: Byte);
begin
  aByte := aByte or $40;
end;

function TsgcWSExtension_DeflateFrame.GetDefStream: TStringStream;
begin
  if not Assigned(FDefStream) then
    FDefStream := TStringStream.Create('')
  else if FDefStream.Size > CS_DEFLATE_BUFFER then
    ResizeStream(FDefStream, CS_DEFLATE_BUFFER);
  Result := FDefStream;
end;

function TsgcWSExtension_DeflateFrame.GetInfStream: TStringStream;
begin
  if not Assigned(FInfStream) then
    FInfStream := TStringStream.Create('')
  else if FInfStream.Size > CS_DEFLATE_BUFFER then
    ResizeStream(FInfStream, CS_DEFLATE_BUFFER);
  Result := FInfStream;
end;

function TsgcWSExtension_DeflateFrame.GetName: String;
begin
  Result := 'deflate-frame';
end;

function TsgcWSExtension_DeflateFrame.InflateFrame(var aStream: TStream): Boolean;
var
  oStream: TMemoryStream;
begin
  result := False;
  Try
    oStream := TMemoryStream.Create;
    Try
      aStream.Seek(0, soFromBeginning);
      DoInflateFrame(aStream, oStream);

      aStream.Size := 0;
      oStream.Seek(0, soFromBeginning);
      aStream.CopyFrom(oStream, oStream.Size);
      aStream.Seek(0, soFromBeginning);
    Finally
      FreeAndNil(oStream);
    End;

    result := True;
  Except
    //
  End;
end;


procedure TsgcWSExtension_DeflateFrame.SetWindowBits(const Value: Integer);
begin
  if (Value < 8) or (Value > 15) then
    raise Exception.CreateFmt(S_INVALID_WINDOWBITS, [Value]);
  FWindowBits := Value;
end;


end.
