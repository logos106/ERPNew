{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_CS;

interface

  procedure DoEnterCS;
  procedure DoLeaveCS;

implementation

uses
  {$IFDEF MACOS}System.SyncObjs{$ELSE}Windows{$ENDIF};

var
  {$IFDEF MACOS}
  oCS: TCriticalSection;
  {$ELSE}
  oCS: TRTLCriticalSection;
  {$ENDIF}

procedure DoEnterCS;
begin
  {$IFDEF MACOS}
  oCS.Enter;
  {$ELSE}
  EnterCriticalSection(oCS);
  {$ENDIF}
end;

procedure DoLeaveCS;
begin
  {$IFDEF MACOS}
  oCS.Leave;
  {$ELSE}
  LeaveCriticalSection(oCS);
  {$ENDIF}
end;

initialization
  {$IFDEF MACOS}
  oCS := TCriticalSection.Create;
  {$ELSE}
  InitializeCriticalSection(oCS);
  {$ENDIF}

finalization
  {$IFDEF MACOS}
  if Assigned(oCS) then oCS.Free;
  {$ELSE}
  DeleteCriticalSection(oCS);
  {$ENDIF}

end.
