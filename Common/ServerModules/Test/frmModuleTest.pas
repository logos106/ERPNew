unit frmModuleTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ServerModuleObj, StdCtrls;

type
  TfmModuleTest = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    ModuleStub: TServerModuleStub;
  public
    { Public declarations }
  end;

var
  fmModuleTest: TfmModuleTest;

implementation

{$R *.dfm}

procedure TfmModuleTest.Button1Click(Sender: TObject);
begin
  ModuleStub:= TServerModuleStub.Create('Module1.exe');
end;

procedure TfmModuleTest.Button2Click(Sender: TObject);
begin
  ModuleStub.Free;
end;

procedure TfmModuleTest.Button3Click(Sender: TObject);
begin
  ModuleStub.SendMessage(0,Edit1.Text);
end;

procedure TfmModuleTest.Button4Click(Sender: TObject);
begin
  ModuleStub.SendCommandMessage('Restart');
end;

end.
