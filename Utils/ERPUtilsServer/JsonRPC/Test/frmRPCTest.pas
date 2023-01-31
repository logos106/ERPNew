unit frmRPCTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JsonObject, JsonRpcBase;

type
  TfmRPCTest = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRPCTest: TfmRPCTest;

implementation

{$R *.dfm}

procedure TfmRPCTest.Button1Click(Sender: TObject);
var
  o: TJsonObject;
  client: TJsonRpcBase;
begin
  o:= TSuperObject.ParseString('12.25');
  client:= TJsonRpcBase.Create;
  try
    client.SendResult(o,12);

  finally
    client.Free;
    o.Free;
  end;
end;

end.
