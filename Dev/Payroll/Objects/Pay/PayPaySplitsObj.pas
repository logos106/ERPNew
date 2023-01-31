unit PayPaySplitsObj;

interface
uses
  Classes, DB;

type
  TPayPaySplitsObj = class(TObject)
  private
    foOwner: TObject;
    FDSPayPaySplits: TDataset;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSPayPaySplits write FDSPayPaySplits;
  end;
implementation


constructor TPayPaySplitsObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
end;

destructor TPayPaySplitsObj.Destroy;
begin
  inherited;
end;

end.
