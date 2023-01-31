library IntroImagesDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Windows,
  FastFuncs in '..\..\Dev\General\Objects\CommonObjects\FastFuncs\FastFuncs.pas';

{$R *.res}
{$R IntroImages.res}

function LoadDLLImage(aFile:string; ms:TMemoryStream):Boolean;
var
   HResInfo: HRSRC;
   HGlobal: THandle;
   Buffer, GoodType : pchar;
   Ext:string;
begin
  ext:=uppercase(extractfileext(aFile));
  ext:=copy(ext,2,FastFuncs.StrLength(ext));
  if ext='HTM' then ext:='HTML';
  Goodtype:=pchar(ext);
  aFile:=changefileext(afile,'');
  HResInfo := FindResource(HInstance, pchar(aFile), GoodType);
  HGlobal := LoadResource(HInstance, HResInfo);
  if HGlobal = 0 then begin
    Result := False;
    exit;
  end;

  Buffer := LockResource(HGlobal);
  try
    ms.clear;
    ms.WriteBuffer(Buffer[0], SizeOfResource(HInstance, HResInfo));
    ms.Seek(0,0);
  finally
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
  end;
  Result := True;
end;

exports
  LoadDLLImage;

end.

