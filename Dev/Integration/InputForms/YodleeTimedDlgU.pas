unit YodleeTimedDlgU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  IdIOHandler, IdIOHandlerSocket, IdHeaderList, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdTCPClient, IdHTTP,  IdBaseComponent,  IdComponent, IdIPMCastBase, IdIPMCastClient, CommonLib;

type
  TYodleeTimedDlg = class(TForm)
    tmCountDown: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    btnWait: TButton;
    btnAbort: TButton;
    edSecs: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure tmCountDownTimer(Sender: TObject);
    procedure btnAbortClick(Sender: TObject);
    procedure btnWaitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FIdHTTP   : TIdHttp;
    FIOSSH    : TIdSSLIOHandlerSocketOpenSSL;
  public
    { Public declarations }
    FProcess : DWORD;
    FIterations: integer;
    FAuthToken: string;
    FResultJSON: string;
    class function Execute(AProcess: DWORD; AuthToken: string; var AResultJSON: string) : TModalResult;
    function CheckOutputfile(AuthToken: string; var AResultJSON: string): Boolean;

  end;

var
  TimedDlg: TYodleeTimedDlg;

implementation

const
  MAXITERATIONS = 30;
{$R *.dfm}


class function TYodleeTimedDlg.Execute(AProcess: DWORD; AuthToken: string; var AResultJSON: string): TModalResult;
begin
  With TYodleeTimedDlg.Create(Nil) do begin
    FProcess    := AProcess;
    FAuthToken  := AuthToken;
    FIterations := 0;
    tmCountDown.Enabled := True; // start the timer
    Result := ShowModal;
    AResultJSON := FResultJSON;
    Free;
  end;
end;

procedure TYodleeTimedDlg.FormCreate(Sender: TObject);
begin
  FIdHttp                                 := TIdHttp.Create(Nil);
  FIOSSH                                  := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  FIdHttp.IOHandler                       := FIOSSH;
  FIOSSH.SSLOptions.SSLVersions           := [sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1];
  FIdHttp.Request.ContentType             := 'application/json';
  FIdHttp.Request.Accept                  := 'application/json' ;
  FIdHttp.Request.CharSet                 := 'utf-8';
  FIdHttp.Request.UserAgent               := 'PostmanRuntime/7.28.0';
  FIdHttp.Request.CustomHeaders.FoldLines := False;
  FIdHttp.HTTPOptions                     := [hoForceEncodeParams] ;
  FIdHttp.Request.Connection              := 'close';
end;

procedure TYodleeTimedDlg.FormDestroy(Sender: TObject);
begin
  FIOSSH.Free;
  FIdHttp.Free;
end;

procedure TYodleeTimedDlg.tmCountDownTimer(Sender: TObject);
var
  AResultJSON: string;
begin
  Inc(FIterations);
  edSecs.Text := IntToStr(StrToIntDef(edSecs.Text, 300) - 10);
  Application.ProcessMessages;

  if  CheckOutputFile(FAuthToken, AResultJSON) then begin
    if Pos('SUCCESS', AResultJSON) > 0  then begin
      ModalResult := mrOK;
    end else begin
      ModalResult := mrCancel;
    end;
    FResultJSON         := AResultJSON;
    tmCountDown.Enabled := False; // stop the timer
    TerminateProcess(FProcess,0);
    CloseHandle(FProcess);
    exit;
  end;

  if FIterations < MAXITERATIONS then exit;

  tmCountDown.Enabled := False; // stop the timer
  TerminateProcess(FProcess,0);
  CloseHandle(FProcess);
  ModalResult := mrCancel;     // close the form
end;

procedure TYodleeTimedDlg.btnAbortClick(Sender: TObject);
begin
  tmCountDown.Enabled := False; // stop the timer
  TerminateProcess(FProcess,0);
  CloseHandle(FProcess);
  ModalResult := mrCancel;
end;

procedure TYodleeTimedDlg.btnWaitClick(Sender: TObject);
begin
  tmCountDown.Enabled := False;
  FIterations         := 0;
  edSecs.Text         := '300';
  tmCountDown.Enabled := True;
end;

function TYodleeTimedDlg.CheckOutputfile(AuthToken: string; var AResultJSON: string): Boolean;
var
  AURL         : string;
  ErrorMessage : string;
begin
  Result                                     := False;
  AURL                                       := 'https://yoodle.erpoz.com/' + AuthToken + '.txt';
  try
    AResultJSON                              := FIdHttp.Get(AURL);
    Result                                   := (FIdHttp.ResponseCode = 200);
    if not Result then begin
      CommonLib.MessageDlgXP_Vista('Error when linking to Yodlee.  Error was :' + FIdHttp.Response.ResponseText, mtError,[mbOk],0);
      exit;
    end;
  except
    on E: EIdHTTPProtocolException  do begin
       if  FIdHttp.ResponseCode = 404 then exit; // swallow this exception
       ErrorMessage := ErrorMessage + #13#10 + 'Error when linking to Yodlee. Error was : ' + FIdHttp.Response.ResponseText;
       CommonLib.MessageDlgXP_Vista('Error when linking to Yodlee.  Error was :' + ErrorMessage,mtError,[mbOk],0);
     end;
    on E:Exception do begin
      ErrorMessage := E.Message;
      CommonLib.MessageDlgXP_Vista('Error when linking to Yodlee.  Error was :' + ErrorMessage,mtError,[mbOk],0);
    end;
  end; {try..e}

end;

end.
