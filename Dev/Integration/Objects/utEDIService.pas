unit utEDIService;

interface

uses
  utBaseCoreService;

type
  TEDIService = class(TBaseCoreService)
  private
  protected
  public
    class function GetServiceName: string; override;
  end;

implementation

uses
  utCoreEDIConst;

{ TEDIService }

Class function TEDIService.GetServiceName: string;
begin
  Result := Servicename_EDI;
end;

end.
