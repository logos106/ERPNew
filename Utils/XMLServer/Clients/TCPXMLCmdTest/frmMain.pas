unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdIOHandler, IdIOHandlerSocket,
  IdSSLOpenSSL;

type
  TfmMain = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    edtInFile: TEdit;
    btnInFile: TButton;
    memResult: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    OpenDialog: TOpenDialog;
    TCPClient: TIdTCPClient;
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocket;
    edtServer: TEdit;
    Label2: TLabel;
    memRequest: TMemo;
    Splitter1: TSplitter;
    procedure btnInFileClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtServerChange(Sender: TObject);
    procedure edtInFileChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  IdGlobal, XMLRequestConst, AppVarsObj;

{$R *.dfm}

procedure TfmMain.btnInFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    self.edtInFile.Text:= OpenDialog.FileName;
  end;
end;

procedure TfmMain.Button1Click(Sender: TObject);
var
  sl: TStringList;
//  outStr: string;
  s: string;
  StartTagFound, EndTagFound: boolean;
begin
  memResult.Clear;
  if memRequest.Lines.Text = '' then exit;
  sl:= TStringList.Create;
  try
//    sl.LoadFromFile(self.edtInFile.Text);
//    TCPClient.Host:= '192.168.63.69'; { Test Server }
//    TCPClient.Host:= '192.168.63.62';
    TCPClient.Host:= AppVars['Server'];
    TCPClient.Connect();
    try
      TCPClient.WriteLn(memRequest.Lines.Text);
      SL.Clear;
      StartTagFound:= false;
      EndTagFound:= false;
      s:= TCPClient.ReadLn(#10,5000);
      if (not StartTagFound) and (Pos(XMLNodeRoot,s) > 0) then begin
        StartTagFound:= true;
        memResult.Lines.Add('Start tag found');
      end;
      if TCPClient.ReadLnTimedOut then
        memResult.Lines.Add('Read timed out');
//      while (s <> '') or ((s = '') and (StartTagFound and (not EndTagFound))) do begin
      while not (StartTagFound and EndTagFound) do begin
        SL.Add(s);

        s:= TCPClient.ReadLn(#10,5000);
//        memResult.Lines.Add('Read = "' + s + '"');

        if TCPClient.ReadLnTimedOut then begin
//          memResult.Lines.Add('Read timed out');
          break;
        end;

        if (not StartTagFound) and (Pos(XMLNodeRoot,s) > 0) then begin
          StartTagFound:= true;
//          memResult.Lines.Add('Start tag found');
        end;

        if (not EndTagFound) and (Pos('/'+XMLNodeRoot,s) > 0) then begin
          EndTagFound:= true;
//          memResult.Lines.Add('End tag found');
        end;
      end;

//      s:= TCPClient.ReadLn();
//      while s <> '' do begin
//        SL.Add(s);
//        s:= TCPClient.ReadLn();
//      end;
    finally
      TCPClient.Disconnect;
    end;
    memResult.Lines.Add(SL.Text);
    memResult.Lines.SaveToFile('result.xml');
  finally
    sl.Free;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  AppVars:= TAppVars.Create;
  AppVars.SaveOnChange:= true;
  AppVars.LoadFromFile();
  AppVars.SetDefault('Server','127.0.0.1');
  edtServer.Text:= AppVars['Server'];
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  AppVars.Free;
  inherited;
end;

procedure TfmMain.edtServerChange(Sender: TObject);
begin
  AppVars['Server']:= edtServer.Text;
end;

procedure TfmMain.edtInFileChange(Sender: TObject);
begin
  if FileExists(edtInFile.Text) then
    memRequest.Lines.LoadFromFile(edtInFile.Text);
end;

end.
