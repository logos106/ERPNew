program DLLTest;

uses
  ShareMem,
  Forms,
  frmDLLTest in 'frmDLLTest.pas' {Form1},
  BusObjConst in '..\..\..\Dev\BusinessObjects\BusObjConst.pas',
  XMLRequestConst in '..\..\..\Dev\General\Objects\CommonObjects\XMLRequestConst.pas',
  LogThreadLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogMessageTypes in '..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas';

{$R *.res}

begin
//  RegisterExpectedMemoryLeak(36, 1); // TWinHelpViewer x 1
//  RegisterExpectedMemoryLeak(20, 3); // TObjectList x 3
//  RegisterExpectedMemoryLeak(20, 3); // Unknown x 3
//  RegisterExpectedMemoryLeak(52, 1); // THelpManager x 1

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
