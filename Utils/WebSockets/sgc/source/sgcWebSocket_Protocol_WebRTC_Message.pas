{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_WebRTC_Message;

interface

uses
  Classes, SysUtils,
  sgcWebSocket_Protocol_sgc_message;

type
  TsgcWSMessageWebRTC = class(TsgcWSMessage)
  private
    FWebRTC: string;
  protected
    procedure DoJSONWebRTC;
  public
    procedure Read(const aMessage: String); override;
    function Write: string; override;
  published
    property WebRTC: string read FWebRTC write FWebRTC;
  end;

implementation

uses
  sgcWebSocket_Const;


procedure TsgcWSMessageWebRTC.Read(const aMessage: String);
begin
  DoEnterRead(aMessage);

  WebRTC := '';

  FJSON.Read(aMessage);
  if FJSON.Node['webrtc'] <> nil then
    WebRTC := String(FJSON.Node['webrtc'].JSONObject.Text);

  inherited;
end;

procedure TsgcWSMessageWebRTC.DoJSONWebRTC;
begin
  if WebRTC <> '' then
  begin
    Method := CS_SGC_WEBRTC;
    With FJSON.Add do
    begin
      Name := 'webrtc';
      JSONObject.Read(WebRTC);
    end;
  end;
end;

function TsgcWSMessageWebRTC.Write: string;
begin
  DoEnterWrite;

  DoJSONWebRTC;

  result := inherited Write;
end;

end.
