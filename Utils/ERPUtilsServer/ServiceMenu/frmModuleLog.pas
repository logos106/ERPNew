unit frmModuleLog;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, Shader, ExtCtrls, DNMPanel,
  JsonRpcBase, JsonRpcTcpClient, JsonObject;

type
  TfmModuleLog = class(TForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTitle: TLabel;
    btnClose: TDNMSpeedButton;
    memLog: TMemo;
    optLog: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure optLogClick(Sender: TObject);
  private
    Client: TJsonRpcTcpClient;
    fModuleName: string;
    fServer: String;
    fsPreviousLog:String;
    procedure SetModuleName(const Value: string);
    procedure SetServer(const Value: String);
    procedure DoOnRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
    procedure ShowLoghint;
  public
    property ModuleName: string read fModuleName write SetModuleName;
    property Server: String read fServer write SetServer;
  end;

  procedure ShowLog(aOwner: TComponent; aModuleName, aServer: string);

implementation

uses
  Character, SystemLib;

{$R *.dfm}

procedure ShowLog(aOwner: TComponent; aModuleName, aServer: string);
var
  form: TfmModuleLog;
  x: integer;
begin
  if Assigned(aOwner) then begin
    for x := 0 to aOwner.ComponentCount - 1 do begin
      if aOwner.Components[x] is TfmModuleLog then begin
        if SameText(TfmModuleLog(aOwner.Components[x]).ModuleName, aModuleName) and
           SameText(TfmModuleLog(aOwner.Components[x]).Server, aServer) then begin
          { bring existing log form to front }
          TfmModuleLog(aOwner.Components[x]).BringToFront;
          exit;
        end;
      end;
    end;
  end;

  form := TfmModuleLog.Create(aOwner);
  form.ModuleName := aModuleName;
  form.Server := aServer;
  if aOwner is TForm then begin
    if TForm(aOwner).FormStyle = fsMDIForm then begin
      form.FormStyle := fsMDIChild;
      form.BringToFront;
    end
    else
      form.Show;
  end
  else
    form.Show;
end;

procedure TfmModuleLog.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmModuleLog.DoOnRequest(Client: TJsonRpcBase; ReqJson,  ResJson: TJSONObject);
begin
  if ReqJson.ObjectExists('params') then begin
    if SameText(ReqJson.O['params'].S['eventname'], 'Log') then begin
      if Sametext(fsPreviousLog, ReqJson.O['params'].S['value']) then Exit;
      if optLog.itemindex = 1 then begin
          memLog.Lines.Add(Copy(ReqJson.O['params'].S['value'], 1, 1000));
      end else begin
        if optLog.itemindex = 2 then begin
          if memLog.Lines.Count > 1000 then begin
            memLog.Lines.Clear;
            ShowLoghint;
          end;
        end else begin
          while memLog.Lines.Count > 1000 do
            memLog.Lines.Delete(0);
        end;
        memLog.Lines.Add(ReqJson.O['params'].S['value']);
      end;
    end;
  end;
end;

procedure TfmModuleLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmModuleLog.FormCreate(Sender: TObject);
var
  j: TJsonObject;
begin
  fsPreviousLog := '';
  Client := TJsonRpcTcpClient.Create;
  Client.OnRequest := DoOnRequest;
  try
    optLog.itemindex := 0;
    if fileExists(Systemlib.exedir + 'LogOpt.json') then begin
      j := jo;
      try
        j.LoadFromfile(Systemlib.exedir + 'LogOpt.json');
        if j.exists('LogOption') then
          optLog.itemindex := j.I['LogOption'];
      finally
        j.free;
      end;
    end;
  Except
    //
  end;
end;

procedure TfmModuleLog.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;
Procedure TfmModuleLog.ShowLoghint;
begin
  if optLog.itemindex = 1 then begin
    memLog.Lines.Add('Short Log - First 1000 chars');
    memLog.Lines.Add('=====================================');
    memLog.Lines.Add('');
  end else if optLog.itemindex = 2 then begin
    memLog.Lines.Add('Clear Log when more than 1000 chars');
    memLog.Lines.Add('=====================================');
    memLog.Lines.Add('');
  end;
end;

procedure TfmModuleLog.FormShow(Sender: TObject);
var
  j: TJsonObject;
  method: string;
begin
  showLoghint;
  if not Client.Connected then begin
    method := ModuleName;

    if method <> '' then method := method + '.';
    method := method + 'RegisterForNotification';
    Client.ServerName := Server;
    Client.Connected := True;
    j := JO;
    j.S['NotificationType'] := '';
    Client.SendRequest(method, j);
  end;
end;

procedure TfmModuleLog.optLogClick(Sender: TObject);
var
  j: TJsonObject;
begin
  try
    j := jo;
    try
      j.I['LogOption'] := optLog.itemindex;
      j.SaveTofile(Systemlib.exedir+'LogOpt.json');
    finally
      J.free;
    end;
  Except
  end;
end;

procedure TfmModuleLog.SetModuleName(const Value: string);
var
  s, cap: string;
  x: integer;
begin
  fModuleName := Value;
  if fModuleName <> '' then begin
    cap := '';
    if Pos('ERPMod', Value) = 1 then
      s := Copy(Value, 7, MaxInt)
    else if Pos('ERP', Value) = 1 then
      s := Copy(Value, 4, MaxInt)
    else
      s := Value;

    x := 1;
    while x <= Length(s) do begin
      if Pos('API',s) = x then begin
        x := x + 3;
        cap := cap + ' API';
        continue;
      end;
      if (x > 1) and IsUpper(s[x]) then begin
        if (s[x-1] <> '') then begin
          cap := cap + ' ' + s[x];
        end
        else
          cap := cap + s[x];
      end
      else
        cap := cap + s[x];
      Inc(x);
    end;
    Caption := cap + ' Log';
    lblTitle.Caption := cap + ' Log';
  end
  else begin
    Caption := 'Utilities Server Log';
    lblTitle.Caption := 'Utilities Server Log';
  end;
end;

procedure TfmModuleLog.SetServer(const Value: String);
begin
  fServer := Value;
end;

end.
