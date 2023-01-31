unit frmRpcClientTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonRpcTcpClient, StdCtrls;

type
  TfmRpcClientTest = class(TForm)
    Button1: TButton;
    memLog: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    Client: TJsonRpcTcpClient;
  public
    { Public declarations }
  end;

var
  fmRpcClientTest: TfmRpcClientTest;

implementation

uses
  JsonObject;

{$R *.dfm}

procedure TfmRpcClientTest.FormCreate(Sender: TObject);
begin
  Client:= TJsonRpcTcpClient.Create;
end;

procedure TfmRpcClientTest.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;

procedure TfmRpcClientTest.Button1Click(Sender: TObject);
begin
  Client.Connected:= true;
end;

procedure TfmRpcClientTest.Button2Click(Sender: TObject);
var
  outObj, InObj: TJsonObject;
  stream: TStringStream;
  s: string;
  dt: TDateTime;
begin
  dt:= now;
  stream:= TStringStream.Create(s);
  try
    outObj:= JO('{"param1": "value1", "param2": [42, 23]}');
//    InObj:= Client.SendRequest('echo',outObj,1);
    Client.SendNotification('TestModule.test',outObj);//  SendRequest('TestModule',outObj,1);
//    if Assigned(InObj) then begin
//      InObj.SaveTo(stream,true);
//      memLog.Lines.Add(stream.DataString);
//    end
//    else
//      memLog.Lines.Add('No value returned');
  finally
    stream.Free;
  end;
  memLog.Lines.Add('Request Time: ' + FormatDateTime('hh:nn:ss-zzz',now-dt));
end;

procedure TfmRpcClientTest.Button3Click(Sender: TObject);
begin
  Client.Connected:= false;
end;

procedure TfmRpcClientTest.Button4Click(Sender: TObject);
var
  Obj: TJsonObject;
begin
  Obj:= Client.SendRequest('GetModules',nil,1);
  if Assigned(Obj) then begin
    memLog.Lines.Add(obj.AsString);
    obj.Free;
    obj:= nil;
  end  
  else
    memLog.Lines.Add('Error - nothing returned');
end;

end.
