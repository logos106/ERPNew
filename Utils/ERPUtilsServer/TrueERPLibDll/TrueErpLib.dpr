library TrueErpLib;

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
  ShareMem,
  SysUtils,
  Classes,
  Lib_CipherUtils in 'Lib_CipherUtils.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  Lib_HttpUtils in 'Lib_HttpUtils.pas',
  HTTPConst in '..\..\..\Common\HTTPConst.pas',
  SystemLib in '..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas';

{$R *.res}

begin
end.
