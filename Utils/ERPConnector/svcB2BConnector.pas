unit svcB2BConnector;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  RosettaNetConectorObj;

type
  TERPB2BConnector = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    Connector: TRosettaNetConnector;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ERPB2BConnector: TERPB2BConnector;

implementation

uses
  Registry, LogThreadLib, LogMessageTypes;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ERPB2BConnector.Controller(CtrlCode);
end;

function TERPB2BConnector.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TERPB2BConnector.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, true) then
    begin
      Reg.WriteString('Description', 'Service to manage B2B communications with ERP.');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TERPB2BConnector.ServiceExecute(Sender: TService);
begin
  while not Terminated do begin
    self.ServiceThread.ProcessRequests(false);

    sleep(50);
  end;
end;

procedure TERPB2BConnector.ServiceStart(Sender: TService; var Started: Boolean);
begin
  TLogger.Inst.LogAllTypes;
  TLogger.Inst.Log('Starting service.', ltInfo);
  try
    Connector:= TRosettaNetConnector.Create(TLogger.Inst);
    Started := true;
  except
    on e: exception do begin
      TLogger.Inst.Log('Error starting service: ' + e.Message, ltError);
      Started := false;
    end;
  end;
end;

procedure TERPB2BConnector.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  TLogger.Inst.Log('Stopping service.', ltInfo);
  try
    Connector.Free;
  except

  end;
  Stopped := true;
end;

end.
