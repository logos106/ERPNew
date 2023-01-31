unit utQuickbooksCOreService;

interface

uses
  utBaseCoreService;

type
  TQuickbooksCoreService = class(TBaseCoreService)
  protected
    function GetServiceName: string; override;
  public
    procedure Process(const data: string); override;
    function ProcessAndReturn(const data: string): string; override;
  end;


implementation

{ TQuickbooksCoreService }

function TQuickbooksCoreService.GetServiceName: string;
begin
  result := 'Quickbooks';
end;

procedure TQuickbooksCoreService.Process(const data: string);
begin
  inherited;

end;

function TQuickbooksCoreService.ProcessAndReturn(const data: string): string;
begin

end;

end.
