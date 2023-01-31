unit BusobjPurchaseTaxCodes;

interface

uses BusobjTransTaxCodes, classes;

type
  TPurchaseTaxCodelines = Class(TTransTaxCodeLines)
  Private
  Protected
    Function TransTaxCodeIDFieldname:String;Override;
(*    function GetTransTaxCodeID        : Integer   ;Override;
    procedure SetTransTaxCodeID        (const Value: Integer   );Override;*)
    function GetCapAmount: double; override;
    procedure SetCapAmount(const Value: double); override;
  Public
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
  Public
  End;

  TPurchaseTaxCode = class(TTransTaxCode)
  Private
    Function PurchaseTaxCodelines :TPurchaseTaxCodelines ;
  Protected
    function GetTransID               : Integer   ;Override;
    function GetTransLineID           : Integer   ;Override;
    procedure SetTransID               (const Value: Integer   );Override;
    procedure SetTransLineID            (const Value: Integer   );Override;
    function getLines: TTransTaxCodeLines; Override;
    Function NewLineInstance : TTransTaxCodeLines; Override;
  Public
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
  end;



implementation

uses Sysutils;



{ TPurchaseTaxCodelines }

constructor TPurchaseTaxCodelines.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'PurchaseTaxCodes';
  fSQL := 'SELECT * FROM tblPurchasetaxcodelines';
end;

class function TPurchaseTaxCodelines.GetBusObjectTablename: string;
begin
  Result:= 'tblPurchasetaxcodelines';
end;

(*function TPurchaseTaxCodelines.GetTransTaxCodeID: Integer;
begin
  Result := GetIntegerfield('PurchaseTaxCodeID');
end;

procedure TPurchaseTaxCodelines.SetTransTaxCodeID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('PurchaseTaxCodeID' , Value);
end;*)

function TPurchaseTaxCodelines.GetCapAmount: double;
begin
  result := GetFloatField('CapAmount');
end;

procedure TPurchaseTaxCodelines.SetCapAmount(const Value: double);
begin
  SetFloatField('CapAmount',Value);
end;


function TPurchaseTaxCodelines.TransTaxCodeIDFieldname: String;
begin
  result := 'PurchaseTaxCodeID';
end;

{ TPurchaseTaxCode }

constructor TPurchaseTaxCode.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'PurcahseTaxCodes';
  fSQL := 'SELECT * FROM tblPurchaseTaxCodes';
end;

class function TPurchaseTaxCode.GetBusObjectTablename: string;
begin
  Result:= 'tblPurchaseTaxCodes';
end;

Function TPurchaseTaxCode.PurchaseTaxCodelines :TPurchaseTaxCodelines ;
begin
  Result := TPurchaseTaxCodelines(getContainerComponent(TPurchaseTaxCodelines, 'PurchaseTaxCodeID = ' +IntToStr(ID)));
end;
function TPurchaseTaxCode.getLines: TTransTaxCodeLines;
begin
  REsult := PurchaseTaxCodelines;
end;

function TPurchaseTaxCode.GetTransID: Integer;
begin
  REsult := GetIntegerfield('PurchaseOrderID');
end;

function TPurchaseTaxCode.GetTransLineID: Integer;
begin
  REsult := GetIntegerfield('PurchaseLineId');
end;

function TPurchaseTaxCode.NewLineInstance: TTransTaxCodeLines;
begin
  result := TPurchaseTaxCodelines.create(Self);
end;

procedure TPurchaseTaxCode.SetTransID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('PurchaseOrderID' , Value);
end;

procedure TPurchaseTaxCode.SetTransLineID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('PurchaseLineId' , Value);
end;


end.

