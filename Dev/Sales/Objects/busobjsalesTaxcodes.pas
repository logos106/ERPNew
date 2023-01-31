unit busobjsalesTaxcodes;

interface

uses BusobjTransTaxCodes, classes, BusObjBase;

type
  TSalesTaxCodeLines = class(TTransTaxCodeLines)
  private
  protected
    Function TransTaxCodeIDFieldname:String;Override;
(*    function GetTransTaxCodeID: Integer; override;
    procedure SetTransTaxCodeID(const Value: Integer); override;*)
    function GetCapAmount: double; override;
    procedure SetCapAmount(const Value: double); override;
  public
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TSalesTaxCode = class(TTransTaxCode)
  private
    function SalesTaxCodelines: TSalesTaxCodelines;
  protected
    function GetTransID: Integer; override;
    function GetTransLineID: Integer; override;
    procedure SetTransID(const Value: Integer); override;
    procedure SetTransLineID(const Value: Integer); override;
    function getLines: TTransTaxCodeLines; override;
    function NewLineInstance: TTransTaxCodeLines; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    property SaleID: integer read GetTransID write SetTransID;
    property SaleLineID: integer read GetTransLineID write SetTransLineID;
  end;

implementation

uses Sysutils, BusObjSaleBase;

{ TSalesTaxCodelines }

constructor TSalesTaxCodelines.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'SalesTaxCodeLines';
  fSQL := 'SELECT * FROM tblsalestaxcodelines';
end;

class function TSalesTaxCodelines.GetBusObjectTablename: string;
begin
  Result := 'tblsalestaxcodelines';
end;

(*function TSalesTaxCodelines.GetTransTaxCodeID: Integer;
begin
  Result := GetIntegerfield('SalesTaxCodeID');
end;

procedure TSalesTaxCodelines.SetTransTaxCodeID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('SalesTaxCodeID', Value);
end;*)

function TSalesTaxCodeLines.TransTaxCodeIDFieldname: String;
begin
  REsult := 'SalesTaxCodeID';
end;

function TSalesTaxCodelines.GetCapAmount: double;
begin
  result := GetFloatField('CapAmount');
end;

procedure TSalesTaxCodelines.SetCapAmount(const Value: double);
begin
  SetFloatField('CapAmount', Value);
end;

{ TSalesTaxCode }

constructor TSalesTaxCode.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'SalesTaxCodes';
  fSQL := 'SELECT * FROM tblsalestaxcodes';
end;

function TSalesTaxCode.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(sender);
  if Result and Assigned(Owner) and (Owner is TSalesLineBase) then begin
    SaleID:= TSalesLineBase(Owner).SaleId;
    SaleLineID:= TSalesLineBase(Owner).SaleLineId;
  end;
end;

class function TSalesTaxCode.GetBusObjectTablename: string;
begin
  Result := 'tblSalesTaxCodes';
end;

function TSalesTaxCode.SalesTaxCodelines: TSalesTaxCodelines;
begin
  Result := TSalesTaxCodelines(getContainerComponent(TSalesTaxCodelines, 'SalesTaxCodeID = ' + IntToStr(ID)));
end;

function TSalesTaxCode.getLines: TTransTaxCodeLines;
begin
  Result := SalesTaxCodelines;
end;

function TSalesTaxCode.GetTransID: Integer;
begin
  Result := GetIntegerfield('SaleID');
end;

function TSalesTaxCode.GetTransLineID: Integer;
begin
  Result := GetIntegerfield('SaleLineId');
end;

function TSalesTaxCode.NewLineInstance: TTransTaxCodeLines;
begin
  Result := TSalesTaxCodelines.Create(Self);
end;

procedure TSalesTaxCode.SetTransID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('SaleID', Value);
end;

procedure TSalesTaxCode.SetTransLineID(const Value: Integer);
begin
  inherited;
  SetIntegerfield('SaleLineId', Value);
end;

initialization
  RegisterClass(TSalesTaxCode);
  RegisterClass(TSalesTaxCodeLines);

end.
