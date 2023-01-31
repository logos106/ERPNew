unit frmRPCServerTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonRpcBase, JsonRpcTcpServer;

type
  TfmRPCServerTest = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Server: TJsonRpcTcpServer;
  public
    { Public declarations }
  end;

var
  fmRPCServerTest: TfmRPCServerTest;

implementation

{$R *.dfm}

procedure TfmRPCServerTest.FormCreate(Sender: TObject);
begin
  Server:= TJsonRpcTcpServer.Create;
  Server.Active:= true;
end;

procedure TfmRPCServerTest.FormDestroy(Sender: TObject);
begin
  Server.Free;
end;

end.
