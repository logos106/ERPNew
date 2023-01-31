unit PayLeaveObj;

interface

uses
  Classes, DB, PayLeaveAccruedObj, PayLeaveTakenObj, PayLeaveTotalsObj;

type
  TLeaveObj = class(TObject)
  private
    foOwner: TObject;
    FLeaveAccrued: TLeaveAccrued;
    FLeaveTaken: TLeaveTaken;
    FLeaveTotals: TLeaveTotals;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    property Owner: TObject read foOwner;
    property LeaveAccrued: TLeaveAccrued read FLeaveAccrued write FLeaveAccrued;
    property LeaveTaken: TLeaveTaken read FLeaveTaken write FLeaveTaken;
    property LeaveTotals: TLeaveTotals read FLeaveTotals write FLeaveTotals;
  end;

implementation
  
uses SysUtils;

{ TLeaveObj }

constructor TLeaveObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  FLeaveAccrued := TLeaveAccrued.Create(Self.Owner);
  FLeaveTaken := TLeaveTaken.Create(Self.Owner);
  FLeaveTotals := TLeaveTotals.Create(Self.Owner);
end;

destructor TLeaveObj.Destroy;
begin
  FreeAndNil(FLeaveAccrued);
  FreeAndNil(FLeaveTaken);
  FreeAndNil(FLeaveTotals);
  inherited;
end;

procedure TLeaveObj.Recalc;
begin
  FLeaveAccrued.Recalc;
  FLeaveTotals.Recalc;
  FLeaveTaken.Recalc;  
end;

end.
