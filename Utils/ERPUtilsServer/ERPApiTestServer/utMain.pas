unit utMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ApiTestServerObj;

type
  TERPApiTestService = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    TestServer: TApiTestServer;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ERPApiTestService: TERPApiTestService;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ERPApiTestService.Controller(CtrlCode);
end;

function TERPApiTestService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TERPApiTestService.ServiceExecute(Sender: TService);
begin
  while not Terminated do begin
    ServiceThread.ProcessRequests(false);
  end;
end;

procedure TERPApiTestService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  TestServer := TApiTestServer.Create;
end;

procedure TERPApiTestService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  FreeAndNil(TestServer);
end;

end.
