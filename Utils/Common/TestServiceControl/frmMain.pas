unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, datSvcControlClient, datSvcControlServer, StdCtrls, AppVarsObj;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Server: TSvcControlServer;
    Client: TSvcControlClient;
    fPubProp: string;
  public
    { Public declarations }
  published
    property PubProp: string read fPubProp write fPubProp;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Server:= TSvcControlServer.Create(nil);
  Client:= TSvcControlClient.Create(nil);
  try
    Server.Port:= 9999;
    Server.Active:= true;
    Server.ObjectToControl:= self;

    Client.ServerPort:= 9999;
    Client.ServerIP:= '127.0.0.1';
    Client.Connect;
    ShowMessage(Client.RemotePropertyStr['PubProp']);

  finally
    Client.Free;
    Server.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  PubProp:= 'Hello';
  AppVars:= TAppVars.Create;
  AppVars.LoadFromFile();
  AppVars.SaveOnChange:= true;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  AppVars.Free;
end;

end.
