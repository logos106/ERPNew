unit frmConfigBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonObject, ExtCtrls, JsonRpcTcpClient;

type

  TfmConfigBaseClass = class of TfmConfigBase;
  TfmConfigBase = class(TForm)
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fConfig: TJsonObject;
    fRpcClient: TJsonRpcTcpClient;
  public
    procedure Load; virtual;
    function Save: boolean; virtual;
    function Apply: boolean; virtual;
    property Config: TJsonObject read fConfig write fConfig;
    property RpcClient: TJsonRpcTcpClient read fRpcClient write fRpcClient;
  end;

var
  fmConfigBase: TfmConfigBase;

implementation

{$R *.dfm}

function TfmConfigBase.Apply: boolean;
begin
  result:= true;
end;

procedure TfmConfigBase.FormCreate(Sender: TObject);
begin
  fConfig:= TJsonObject.Create;
end;

procedure TfmConfigBase.FormDestroy(Sender: TObject);
begin
  fConfig.Free;
end;

procedure TfmConfigBase.Load;
begin

end;

function TfmConfigBase.Save: boolean;
begin
  result:= true;
end;

end.
