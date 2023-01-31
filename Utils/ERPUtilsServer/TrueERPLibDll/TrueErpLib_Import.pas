unit TrueErpLib_Import;

interface

uses
  {$IfDef VER220}
  Classes
  {$Else}
  System.Classes
  {$EndIf}
  ;

const
  libdll = 'TrueErpLib.dll';

procedure CipherUtils_DecryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = ''); external libdll;
procedure CipherUtils_DecryptStream(Const InStream,OutStream: TStream; CryptKey: string = ''); external libdll;
procedure CipherUtils_EncryptStream(Const InStream,OutStream: TStream; CryptKey: string = ''); external libdll;
procedure CipherUtils_EncryptFile(Const InFilePath,OutFilePath: String; CryptKey: string = ''); external libdll;
function CipherUtils_DecryptString(const InString: string;  CryptKey: string = ''): string;  external libdll;
function CipherUtils_EncryptString(const InString: string;  CryptKey: string = ''): string; external libdll;

implementation

end.
