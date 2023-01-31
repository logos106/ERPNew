unit MainformLib;

interface

uses classes;

Procedure MainformMsg(Msg:String);
function ClientFormTop :Integer;


implementation

uses MAIN ;


Procedure MainformMsg(Msg:String);
begin
  Mainform.TimerMsg(Msg);
end;
function ClientFormTop :Integer;
begin
  REsult := Mainform.MainToolBar.Height+Mainform.StatusBar.Height;
end;


end.
