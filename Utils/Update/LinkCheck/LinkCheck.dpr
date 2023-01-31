program LinkCheck;

uses
  Forms,
  GUI in 'GUI.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
