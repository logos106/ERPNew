unit PaySplitObj;     //simply has a dataset at the moment

interface
uses
  Classes, DB;
type
  TPaySplitObj = class(TObject)
  private
    foOwner: TObject;
    FDSPaySplit: TDataset;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSPaySplit write FDSPaySplit;
  end;
implementation


constructor TPaySplitObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
end;

destructor TPaySplitObj.Destroy;
begin
  inherited;
end;

end.
