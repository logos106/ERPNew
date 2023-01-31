unit ServerSession;

interface

type

  TServerSession = class(TObject)
  private
    fSessionId: string;
    fErpDatabase: string;
    fErpServer: string;
  published
  public
    constructor Create;
    destructor Destroy; override;
  published
    property SessionID: string read fSessionId;
    property ErpDatabase: string read fErpDatabase write fErpDatabase;
    property ErpServer: string read fErpServer write fErpServer;
  end;

implementation

uses
  RandomUtils;

{ TServerSession }

constructor TServerSession.Create;
begin
  fSessionId := MakeRandomString(10);
end;

destructor TServerSession.Destroy;
begin

  inherited;
end;

end.
