{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Client_SocketIO;

interface

uses
  Classes, SysUtils, StrUtils,
  sgcWebSocket_Client;

type
  TsgcWSClient_SocketIO = class(TsgcWSClient)
  { from TsgcWSClient }
  protected
    function DoGetSessionURL: string; override;
    function DoSessionResponse(aStream: TStringStream): Boolean; override;
  { from TsgcWSClient }

  private
    FIO_CloseTimeout: Integer;
    FIO_HeartBeatTimeout: Integer;
    FIO_SessionId: String;
  protected
    procedure SetActive(const Value: Boolean); override;
  public
    property IO_CloseTimeout: Integer read FIO_CloseTimeout;
    property IO_HeartBeatTimeout: Integer read FIO_HeartBeatTimeout;
    property IO_SessionId: String read FIO_SessionId;
  end;

implementation

uses
  IdHTTP,
  sgcWebSocket_Helpers, sgcWebSocket_Const;

const
  CS_SOCKETIO_URL = '/socket.io/1';


function TsgcWSClient_SocketIO.DoGetSessionURL: string;
begin
  if TLS then
    result := 'https://'
  else
    result := 'http://';
  result := result + Host + ':' + IntToStr(Port) + CS_SOCKETIO_URL;
end;

function TsgcWSClient_SocketIO.DoSessionResponse(aStream: TStringStream):
    Boolean;
var
  oList: TsgcDelimitedStringList;
begin
  result := False;

  oList := TsgcDelimitedStringList.Create;
  Try
    oList.Delimiter := ':';
    oList.DelimitedText := aStream.DataString;
    if oList.count > 3 then
    begin
      result := sgcContainsText(oList[3], 'websocket');
      if result then
      begin
        FIO_SessionId := oList[0];
        TryStrToInt(oList[1], FIO_HeartBeatTimeOut);
        TryStrToInt(oList[2], FIO_CloseTimeOut);
      end;
    end;
  Finally
    FreeAndNil(oList);
  End;
end;

procedure TsgcWSClient_SocketIO.SetActive(const Value: Boolean);
begin
  if [csDesigning, csLoading] * ComponentState = [] then
  begin
    if Value then
    begin
      if DoGetSession then
        Options.Parameters := CS_SOCKETIO_URL + '/websocket/' + IO_SessionId
      else
        raise Exception.Create(S_UNABLE_GET_SESSION_SOCKETIO);
    end;
  end;
  inherited;
end;

end.
