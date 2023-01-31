unit utDebug;

interface

Function Choosefilename(aCaption,aModuleFileName :String):String;
implementation

uses Dialogs, sysutils;

Function Choosefilename(aCaption,aModuleFileName :String):String;
var
  dlg: TOpenDialog;
begin
  result := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.Title := aCaption;
    dlg.InitialDir := ExtractFilePath(aModuleFileName)+'..\VS1Cloud\';
    dlg.Filter := 'All files (*.*)|*.*';
    if dlg.Execute(0) then
      result := dlg.FileName;
  finally
    dlg.Free;
  end;
end;

end.
