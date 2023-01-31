unit CipherUtils;

interface

uses
  Classes; //LbCipher,LbClass;

procedure Decrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
procedure Decrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;
procedure Encrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); overload;
procedure Encrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
function DecryptString(const InString: string;  CryptKey: string = ''): string;
function EncryptString(const InString: string;  CryptKey: string = ''): string;

procedure DecryptInThread(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
procedure DecryptInThread(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;

function MD5HashHex(s: string): string;

const
  DefaultCryptKey = '~1|Ey4^|Wb7#|Pi4!|Qg0)|Yt3*|1~';


implementation

uses
  sysutils,
  uTPLb_BaseNonVisualComponent, uTPLb_Codec,
  uTPLb_CryptographicLibrary, uTPLb_Constants, uTPLb_Hash,
  {$IfDef VER220}
  Forms,
  {$Else}
  Vcl.Forms,
  {$EndIf}
  IdHashMessageDigest;

type
  TDecryptThread = class(TThread)
  protected
    procedure Execute; override;
  public
    InFilePath,
    OutFilePath,
    CryptKey: string;
    InStream,
    OutStream: TStream;
    constructor Create; overload;
  end;

procedure Decrypt(Const InFilePath, OutFilePath: String; CryptKey: string = ''); Overload;
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
begin
  If not FileExists(InFilePath) then Exit;
  Codec := TCodec.Create(nil);
  CryptoLib := TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary := CryptoLib;
    Codec.ChainModeId := CBC_ProgId;
    Codec.StreamCipherId := BlockCipher_ProgId;
    Codec.BlockCipherId := Blowfish_ProgId;
    if CryptKey <> '' then
      Codec.Password := CryptKey
    else
      Codec.Password := DefaultCryptKey;
    Codec.DecryptFile(OutFilePath,InFilePath);
  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

procedure Decrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
begin
  Codec:= TCodec.Create(nil);
  CryptoLib:= TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary:= CryptoLib;
    Codec.ChainModeId:= CBC_ProgId;
    Codec.StreamCipherId:= BlockCipher_ProgId;
    Codec.BlockCipherId:= Blowfish_ProgId;
    if CryptKey <> '' then
      Codec.Password:= CryptKey
    else
      Codec.Password:= DefaultCryptKey;
    Codec.DecryptStream(OutStream,InStream);
  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

procedure Encrypt(Const InStream,OutStream: TStream; CryptKey: string = '');
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
begin
  Codec:= TCodec.Create(nil);
  CryptoLib:= TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary:= CryptoLib;
    Codec.ChainModeId:= CBC_ProgId;
    Codec.StreamCipherId:= BlockCipher_ProgId;
    Codec.BlockCipherId:= Blowfish_ProgId;
    if CryptKey <> '' then
      Codec.Password:= CryptKey
    else
      Codec.Password:= DefaultCryptKey;
    Codec.EncryptStream(InStream,OutStream);
  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

procedure Encrypt(Const InFilePath,OutFilePath: String; CryptKey: string = '');
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
begin
  Codec:= TCodec.Create(nil);
  CryptoLib:= TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary:= CryptoLib;
    Codec.ChainModeId:= CBC_ProgId;
    Codec.StreamCipherId:= BlockCipher_ProgId;
    Codec.BlockCipherId:= Blowfish_ProgId;
    if CryptKey <> '' then
      Codec.Password:= CryptKey
    else
      Codec.Password:= DefaultCryptKey;
    Codec.EncryptFile(InFilePath,OutFilePath);
  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

function DecryptString(const InString: string;  CryptKey: string = ''): string;
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
begin
  Codec:= TCodec.Create(nil);
  CryptoLib:= TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary:= CryptoLib;
    Codec.ChainModeId:= CBC_ProgId;
    Codec.StreamCipherId:= BlockCipher_ProgId;
    Codec.BlockCipherId:= Blowfish_ProgId;
    if CryptKey <> '' then
      Codec.Password:= CryptKey
    else
      Codec.Password:= DefaultCryptKey;
    {$IfDef VER220}
    Codec.DecryptString(result,AnsiString(InString));
    {$Else}
    Codec.DecryptString(result,InString,TEncoding.Default);
    {$EndIf}

  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

function EncryptString(const InString: string;  CryptKey: string = ''): string;
var
  Codec: TCodec;
  CryptoLib: TCryptographicLibrary;
  {$IfDef VER220}
  OutString: AnsiString;
  {$Else}
  OutString: String;
  {$EndIf}
begin
  Codec:= TCodec.Create(nil);
  CryptoLib:= TCryptographicLibrary.Create(nil);
  try
    Codec.CryptoLibrary:= CryptoLib;
    Codec.ChainModeId:= CBC_ProgId;
    Codec.StreamCipherId:= BlockCipher_ProgId;
    Codec.BlockCipherId:= Blowfish_ProgId;
    {$IfDef VER220}
    if CryptKey <> '' then
      Codec.Password:= CryptKey
    else
      Codec.Password:= DefaultCryptKey;
    {$Else}
    if CryptKey <> '' then
      Codec.Password:= AnsiString(CryptKey)
    else
      Codec.Password:= AnsiString(DefaultCryptKey);
    {$EndIf}
    {$IfDef VER220}
    Codec.EncryptString(InString,OutString);
    {$Else}
    Codec.EncryptString(InString,OutString,TEncoding.Default); //   (InString,OutString,nil);
    {$EndIf}
    result:= String(OutString);
  finally
    Codec.Free;
    CryptoLib.Free;
  end;
end;

procedure DecryptInThread(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
var
  thread: TDecryptThread;
begin
  thread:= TDecryptThread.Create;
  try
    thread.InFilePath:= InFilePath;
    thread.OutFilePath:= OutFilePath;
    thread.CryptKey:= CryptKey;
    thread.Start;
    while not thread.Finished do begin
      sleep(50);
      Application.ProcessMessages;
    end;
  finally
    thread.Free;
  end;
end;

procedure DecryptInThread(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;
var
  thread: TDecryptThread;
begin
  thread:= TDecryptThread.Create;
  try
    thread.InStream:= InStream;
    thread.OutStream:= OutStream;
    thread.CryptKey:= CryptKey;
    thread.Start;
    while not thread.Finished do begin
      sleep(50);
      Application.ProcessMessages;
    end;
  finally
    thread.Free;
  end;
end;

{ TDecryptThread }

constructor TDecryptThread.Create;
begin
  { create suspended }
  inherited Create(true);
  self.FreeOnTerminate:= false;
  self.InFilePath:= '';
  self.OutFilePath:= '';
  self.CryptKey:= '';
  self.InStream:= nil;
  self.OutStream:= nil;
end;

procedure TDecryptThread.Execute;
begin
  inherited;
  if (InFilePath <> '') and (OutFilePath <> '') then begin
    Decrypt(InFilePath,OutFilePath,CryptKey);
  end
  else if (InStream <> nil) and (OutStream <> nil) then begin
    Decrypt(InStream,OutStream,CryptKey);
  end
  else
    raise Exception.Create('Invalid input parameters to ' + self.ClassName);
end;

function MD5HashHex(s: string): string;
//var
//  Hash: THash;
//  lib: TCryptographicLibrary;
//  MemStream: TMemoryStream;
//  Str: string;
begin
  with TIDHashMessageDigest5.Create do begin
    Result := HashStringAsHex(s);
    free;
  end;

//  Hash := THash.Create(nil);
//  lib := TCryptographicLibrary.Create(nil);
//  MemStream := TMemoryStream.Create;
//  try
//    Hash.CryptoLibrary := lib;
//    Hash.HashId := MD5_ProgId;
//    Hash.HashString(s);
//    MemStream.LoadFromStream(Hash.HashOutputValue);
//    SetLength(str,MemStream.Size * 2);
//    BinToHex(MemStream.Memory, PChar(str), MemStream.Size);
//    result := str;
//  finally
//    Hash.Free;
//    lib.Free;
//    MemStream.Free;
//  end;
end;

end.
