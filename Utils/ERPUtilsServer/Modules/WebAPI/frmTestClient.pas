unit frmTestClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, ComCtrls, IdHeaderList, JsonObject;

type
  TfmTestClient = class(TForm)
    client: TIdHTTP;
    Panel1: TPanel;
    memOut: TMemo;
    Splitter1: TSplitter;
    memIn: TMemo;
    edtURL: TEdit;
    btnGet: TButton;
    StatusBar1: TStatusBar;
    OpenDialog: TOpenDialog;
    btnPost: TButton;
    btnPut: TButton;
    edtUser: TEdit;
    edtPass: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDatabase: TEdit;
    procedure btnGetClick(Sender: TObject);
    procedure memOutDblClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure clientHeadersAvailable(Sender: TObject; AHeaders: TIdHeaderList;
      var VContinue: Boolean);
    procedure btnPutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure memOutChange(Sender: TObject);
    procedure edtURLChange(Sender: TObject);
    procedure edtUserChange(Sender: TObject);
    procedure edtPassChange(Sender: TObject);
    procedure edtDatabaseChange(Sender: TObject);
  private
    Config: TJsonObject;
    procedure SaveResponce(res: string; code: integer);
    procedure LoadConfig;
    procedure SaveConfig;
  public
    { Public declarations }
  end;

var
  fmTestClient: TfmTestClient;

implementation

{$R *.dfm}

uses
  IdSSLOpenSSL;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

procedure TfmTestClient.btnGetClick(Sender: TObject);
var
  res: string;
begin
  memIn.Lines.Clear;
  statusbar1.Panels[0].Text:= '';
  client.Request.Username:= Config.S['UserName'];
  client.Request.Password:= Config.S['UserPassword'];
//  client.Request.CustomHeaders.AddValue('database',Config.S['Database']);
//  client.Request.RawHeaders.AddValue('database',Config.S['Database']);
  try
    res:= client.Get(edtURL.Text);
  except
    on e: exception do begin
      memIn.Lines.Add('Exception ' + e.ClassName + ' ' + e.Message);
    end;
  end;
  statusbar1.Panels[0].Text:= client.Response.ResponseText;

  SaveResponce(res,client.Response.ResponseCode);
  memIn.Lines.Add(res);
end;

procedure TfmTestClient.btnPostClick(Sender: TObject);
var
  res: string;
  stream: TMemoryStream;
begin
  stream:= TMemoryStream.Create;
  try
    memIn.Lines.Clear;
    statusbar1.Panels[0].Text:= '';
    memOut.Lines.SaveToStream(stream);
    client.Request.Username:= Config.S['UserName'];
    client.Request.Password:= Config.S['UserPassword'];
//    client.Request.CustomHeaders.AddValue('database',Config.S['Database']);
//    client.Request.RawHeaders.AddValue('database',Config.S['Database']);
    try
      res:= client.Post(edtURL.Text, stream);
    except
      on e: exception do begin
        memIn.Lines.Add('Exception ' + e.ClassName + ' ' + e.Message);
      end;
    end;
    statusbar1.Panels[0].Text:= client.Response.ResponseText;
    SaveResponce(res,client.Response.ResponseCode);
    memIn.Lines.Add(res);
  finally
    stream.Free;
  end;
end;

procedure TfmTestClient.btnPutClick(Sender: TObject);
var
  res: string;
  stream: TMemoryStream;
begin
  stream:= TMemoryStream.Create;
  try
    memIn.Lines.Clear;
    statusbar1.Panels[0].Text:= '';
    memOut.Lines.SaveToStream(stream);
    client.Request.Username:= Config.S['UserName'];
    client.Request.Password:= Config.S['UserPassword'];
//    client.Request.CustomHeaders.AddValue('database',Config.S['Database']);
//    client.Request.RawHeaders.AddValue('database',Config.S['Database']);
    try
      res:= client.PUT(edtURL.Text, stream);
    except
      on e: exception do begin
        memIn.Lines.Add('Exception ' + e.ClassName + ' ' + e.Message);
      end;
    end;
    statusbar1.Panels[0].Text:= client.Response.ResponseText;
    SaveResponce(res,client.Response.ResponseCode);
    memIn.Lines.Add(res);
  finally
    stream.Free;
  end;
end;

procedure TfmTestClient.clientHeadersAvailable(Sender: TObject;
  AHeaders: TIdHeaderList; var VContinue: Boolean);
begin
//  showmessage( AHeaders.CommaText );
  memIn.Lines.Add(AHeaders.Values['errormessage']);
  vContinue:= AHeaders.Values['errormessage'] = '';
end;

procedure TfmTestClient.edtDatabaseChange(Sender: TObject);
begin
  Config.S['Database']:= edtDatabase.Text;
end;

procedure TfmTestClient.edtPassChange(Sender: TObject);
begin
  Config.S['UserPassword']:= edtPass.Text;
end;

procedure TfmTestClient.edtURLChange(Sender: TObject);
begin
  Config.S['url']:= edtURL.Text;
end;

procedure TfmTestClient.edtUserChange(Sender: TObject);
begin
  Config.S['UserName']:= edtUser.Text;
end;

procedure TfmTestClient.FormCreate(Sender: TObject);
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  Config:= TJsonObject.Create;
  LoadConfig;
  edtUser.Text:= Config.S['UserName'];
  edtPass.Text:= Config.S['UserPassword'];
  edtDatabase.Text:= Config.S['Database'];

  client.HandleRedirects:= true;
  client.Request.Username:= Config.S['UserName'];
  client.Request.Password:= Config.S['UserPassword'];
  client.Request.CustomHeaders.AddValue('database',Config.S['Database']);
//  client.Request.RawHeaders.AddValue('database',Config.S['Database']);
  if Config.StringExists('url') then
    edtURL.Text:= Config.S['url'];
  memOut.Text:= Config.S['request'];
  if Pos('HTTPS', Uppercase(edtURL.Text)) = 1 then begin
    SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
    client.IOHandler:= SSLHandler;
    client.Request.BasicAuthentication:= true;

  end;
end;

procedure TfmTestClient.FormDestroy(Sender: TObject);
begin
  SaveConfig;
  Config.Free;
end;

procedure TfmTestClient.LoadConfig;
begin
  Config.LoadFromFile(ChangeFileExt(GetModuleNameStr,'_Config.cfg'));
end;

procedure TfmTestClient.memOutChange(Sender: TObject);
begin
  Config.S['request']:= memOut.Text;
end;

procedure TfmTestClient.memOutDblClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    memOut.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TfmTestClient.SaveConfig;
begin
  Config.SaveToFile(ChangeFileExt(GetModuleNameStr,'_Config.cfg'));
end;

procedure TfmTestClient.SaveResponce(res: string; code: integer);
var
  path: string;
begin
  path:= ExtractFilePath(Application.ExeName) + '/Messages/';
  ForceDirectories(path);
  with TStringList.Create do begin
    Text:= res;
    SaveToFile(path + 'Responce_' + IntToStr(code) + '_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz',now) + '.txt');
    free;
  end;
end;

end.
