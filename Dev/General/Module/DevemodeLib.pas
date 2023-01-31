unit DevemodeLib;

interface

Procedure showDevhelp(const HelpDoccode:String);

implementation

uses ShellAPI, CommonLib, windows;

Procedure showDevhelp(const HelpDoccode:String);
var
  SRC:String;
begin
  if not (CommonLib.devmode) then exit;
  if HelpDoccode = 'Taxcodes in Avalara' then SRC := 'I:\ERP\avalara\Help\Product Taxcode.png'
  else exit;
  ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL);
end;
end.
