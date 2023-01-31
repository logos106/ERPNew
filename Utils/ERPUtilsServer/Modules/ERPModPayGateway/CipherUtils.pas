unit CipherUtils;

interface

uses
  Classes;

procedure Decrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
procedure Decrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;
procedure Encrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); overload;
procedure Encrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
function DecryptString(const InString: string;  CryptKey: string = ''): string;
function EncryptString(const InString: string;  CryptKey: string = ''): string;

implementation

uses
 TrueErpLib_Import;

procedure Decrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
begin
  CipherUtils_DecryptFile(InFilePath,OutFilePath,CryptKey);
end;

procedure Decrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;
begin
  CipherUtils_DecryptStream(InStream,OutStream,CryptKey);
end;

procedure Encrypt(Const InStream,OutStream: TStream; CryptKey: string = ''); overload;
begin
  CipherUtils_EncryptStream(InStream,OutStream,CryptKey);
end;

procedure Encrypt(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
begin
  CipherUtils_EncryptFile(InFilePath,OutFilePath,CryptKey);
end;

function DecryptString(const InString: string;  CryptKey: string = ''): string;
begin
  result := CipherUtils_DecryptString(InString,CryptKey);
end;

function EncryptString(const InString: string;  CryptKey: string = ''): string;
begin
  result := CipherUtils_EncryptString(InString,CryptKey);
end;

end.
