unit FileCipherObj;

interface

Uses Classes, LbCipher,LbClass;

type
  TFileCipherObj = class(TComponent)
  private
    Blowfish: TLbBlowfish;
  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    Procedure Decrypt(Const InFilePath,OutFilePath: String); Overload;
    Procedure Decrypt(Const InStream,OutStream: TStream); Overload;
    Procedure Encrypt(Const InStream,OutStream: TStream);
  end;

implementation

Uses SysUtils,EmailFaxServerLib, FastFuncs;

{ TFileCipherObj }

constructor TFileCipherObj.Create(AOwner: TComponent);
begin
  inherited;
  Blowfish := TLbBlowfish.Create(Self);
end;

destructor TFileCipherObj.Destroy;
begin
  FreeandNil(Blowfish);
  inherited;
end;

procedure TFileCipherObj.Decrypt(const InFilePath, OutFilePath: String);
begin
  If not FileExists(InFilePath) then Exit;
  with BlowFish do begin
    GenerateKey(CryptoKey);
    If FastFuncs.SameText(InFilePath, OutFilePath) then Exit;
    DecryptFile(InFilePath, OutFilePath);
  end;
end;

procedure TFileCipherObj.Decrypt(const InStream, OutStream: TStream);
begin
  with BlowFish do begin
    GenerateKey(CryptoKey);
    If (InStream = OutStream) then Exit;
    DecryptStream(InStream, OutStream);
  end;
end;

procedure TFileCipherObj.Encrypt(const InStream, OutStream: TStream);
begin
  with BlowFish do begin
    GenerateKey(CryptoKey);
    If (InStream = OutStream) then Exit;
    EncryptStream(InStream, OutStream);
  end;
end;


end.
 
