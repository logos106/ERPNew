{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}


unit sgcWebSocket_CustomClient;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  IdTCPClient, IdThread, IdException;

type

  TsgcTCPReadThread = class;
  TsgcWSCustomClient = class;

  TsgcReadThreadExceptionEvent = procedure(aException: Exception) of object;

  TsgcTCPReadThread = class(TIdThread)
  private
    FClient: TsgcWSCustomClient;
  private
    FOnReadMessage: TNotifyEvent;
    FOnReadException: TsgcReadThreadExceptionEvent;
  protected
    procedure DoOnMessage;
  protected
    procedure Run; override;
  public
    constructor Create(aClient: TsgcWSCustomClient); reintroduce;
  public
    property OnReadMessage: TNotifyEvent read FOnReadMessage write FOnReadMessage;
    property OnReadException: TsgcReadThreadExceptionEvent read FOnReadException
        write FOnReadException;
  End;

  TsgcWSCustomClient = class(TIdTCPClient)
  private
    FOnRead: TNotifyEvent;
    FOnReadException: TsgcReadThreadExceptionEvent;
    FTCPRead: TsgcTCPReadThread;
    procedure DoClearTCPRead;
  private
  protected
    procedure OnReadEvent(Sender: TObject); virtual;
    procedure OnReadExceptionEvent(aException: Exception); virtual;
  public
    property TCPRead: TsgcTCPReadThread read FTCPRead;
  public
    destructor Destroy; override;
  public
    procedure Connect; override;
    procedure Disconnect(ANotifyPeer: Boolean); override;
  published
    property OnRead: TNotifyEvent read FOnRead write FOnRead;
    property OnReadException: TsgcReadThreadExceptionEvent read FOnReadException
        write FOnReadException;
  end;

implementation

constructor TsgcTCPReadThread.Create(aClient: TsgcWSCustomClient);
begin
  FClient := aClient;
  inherited Create(False);
end;

procedure TsgcTCPReadThread.DoOnMessage;
begin
  if Assigned(FOnReadMessage) then FOnReadMessage(self);
end;

procedure TsgcTCPReadThread.Run;
begin
  Try
    Assert(FClient <> nil);
    Assert(FClient.IOHandler <> nil);

    if FClient.IOHandler.InputBufferIsEmpty then
      FClient.IOHandler.CheckForDataOnSource(10);
    if not FClient.IOHandler.InputBufferIsEmpty then
      Synchronize(DoOnMessage);
    if not Terminated then
      FClient.IOHandler.CheckForDisconnect;

  Except
    On E: EIdSilentException do
    begin
      if not Terminated then Terminate;
      if Assigned(FOnReadException) then FOnReadException(E);
      raise;
    end;
    On E: Exception do
    begin
      if not Terminated then Terminate;
      if Assigned(FOnReadException) then FOnReadException(E);
    end;
  End;
end;

destructor TsgcWSCustomClient.Destroy;
begin
  DoClearTcPRead;
  inherited;
end;

procedure TsgcWSCustomClient.Connect;
begin
  DoClearTcPRead;

  inherited Connect;
  Try
    FTCPRead := TsgcTCPReadThread.Create(Self);
    FTCPRead.OnReadMessage := OnReadEvent;
    FTCPRead.OnReadException := OnReadExceptionEvent;
  Except
    On E: Exception do
      Disconnect(True);
  End;
end;

procedure TsgcWSCustomClient.Disconnect(ANotifyPeer: Boolean);
begin
  if Assigned(FTCPRead) then
    if not FTCPRead.Terminated then
      FTCPRead.Terminate;

  Try
    inherited Disconnect(ANotifyPeer);
  Finally
    DoClearTCPRead;
  End;
end;

procedure TsgcWSCustomClient.DoClearTCPRead;
begin
  if Assigned(FTCPRead) then
    FTCPRead.WaitFor;
  FreeAndNil(FTCPRead);
end;

procedure TsgcWSCustomClient.OnReadEvent(Sender: TObject);
begin
  if Assigned(FOnRead) then FOnRead(self);
end;

procedure TsgcWSCustomClient.OnReadExceptionEvent(aException: Exception);
begin
  if Assigned(FOnReadException) then FOnReadException(aException);
end;


end.
