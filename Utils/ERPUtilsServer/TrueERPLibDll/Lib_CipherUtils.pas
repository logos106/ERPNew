unit Lib_CipherUtils;

interface

uses
  Classes;

procedure CipherUtils_DecryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = ''); stdcall;
procedure CipherUtils_DecryptStream(Const InStream,OutStream: TStream; CryptKey: string = ''); stdcall;
procedure CipherUtils_EncryptStream(Const InStream,OutStream: TStream; CryptKey: string = ''); stdcall;
procedure CipherUtils_EncryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = ''); stdcall;
function CipherUtils_DecryptString(const InString: string;  CryptKey: string = ''): string; stdcall;
function CipherUtils_EncryptString(const InString: string;  CryptKey: string = ''): string; stdcall;

//procedure DecryptInThread(Const InFilePath,OutFilePath: String; CryptKey: string = ''); Overload;
//procedure DecryptInThread(Const InStream,OutStream: TStream; CryptKey: string = ''); Overload;

//function MD5HashHex(s: string): string;

exports
  CipherUtils_DecryptString,
  CipherUtils_EncryptString,
  CipherUtils_DecryptFile,
  CipherUtils_DecryptStream,
  CipherUtils_EncryptStream,
  CipherUtils_EncryptFile;

implementation

uses
  CipherUtils;

procedure CipherUtils_DecryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = '');
begin
  CipherUtils.Decrypt(InFilePath,OutFilePath,CryptKey);
end;

procedure CipherUtils_DecryptStream(Const InStream,OutStream: TStream; CryptKey: string = '');
begin
  CipherUtils.Decrypt(InStream,OutStream,CryptKey);
end;

procedure CipherUtils_EncryptStream(Const InStream,OutStream: TStream; CryptKey: string = '');
begin
  CipherUtils.Encrypt(InStream,OutStream,CryptKey);
end;

procedure CipherUtils_EncryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = '');
begin
  CipherUtils.Encrypt(InFilePath,OutFilePath,CryptKey);
end;

function CipherUtils_DecryptString(const InString: string;  CryptKey: string = ''): string;
begin
  result := CipherUtils.DecryptString(InString,CryptKey);
end;

function CipherUtils_EncryptString(const InString: string;  CryptKey: string = ''): string;
begin
  result := CipherUtils.EncryptString(InString,CryptKey);
end;

end.
