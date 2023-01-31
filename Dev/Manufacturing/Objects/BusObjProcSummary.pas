unit BusObjProcSummary;

interface

uses
  BusObjBase, Classes;

type

  TProcSummary = class(TBusObj)
  private
    function GetProductID: integer;
    function GetProductName: string;
    function GetProductPrintName: string;
    function GetSaleID: integer;
    function GetUOMQtyBuilt: double;
    function GetUOMQtySold: double;
    function GetSaleLineID: integer;
  protected
    function GetId: integer; override;
  Public
    Class Function GetIDField: string; override;
//    Class Function GetBusObjectTablename: string; override;
    class function GetBusObjectTablename: string; override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    Function ValidateData: Boolean; override;
    function PropertyNameToFieldName(aPropName: string): string; override;
  published
    property SaleID: integer read GetSaleID;
    property SaleLineID: integer read GetSaleLineID;
    property ProductID: integer read GetProductID;
    property ProductName: string read GetProductName;
    property ProductPrintName: string read GetProductPrintName;
    property UOMQtySold: double read GetUOMQtySold;
    property UOMQtyBuilt: double read GetUOMQtyBuilt;
  end;

implementation

uses
  SysUtils;

{ TProcSummary }

constructor TProcSummary.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'tax';
  fSQL :=
    'SELECT ' +
    'pt.ProcTreeID, ' +
    'pt.SaleLineID, ' +
    'sl.SaleID, ' +
    'sl.ProductID, ' +
    'sl.ProductName, ' +
    'sl.ProductPrintName, ' +
    'sl.UnitofMeasureQtySold AS UOMQtySold, ' +
    'SUM(pp.UOMQty) AS UOMQtyBuilt ' +
    'FROM tblProctree pt ' +
    'INNER JOIN tblProcProgress pp ON pp.ProctreeID = pt.ProctreeID ' +
    'INNER JOIN tblsaleslines sl ON sl.SaleLineID = pt.SaleLineID ';
  fSQLGroup := 'pt.SaleLineID';
end;

destructor TProcSummary.Destroy;
begin

  inherited;
end;

class function TProcSummary.GetBusObjectTablename: string;
begin
  result := '';
end;

function TProcSummary.GetId: integer;
begin
  result := GetIntegerField('SaleLineID');
end;

class function TProcSummary.GetIDField: string;
begin
  result := 'sl.SaleLineID';
end;

function TProcSummary.GetProductID: integer;
begin
  result := GetIntegerField('ProductID');
end;

function TProcSummary.GetProductName: string;
begin
  result := GetStringField('ProductName');
end;

function TProcSummary.GetProductPrintName: string;
begin
  result := GetStringField('ProductPrintName');
end;

function TProcSummary.GetSaleID: integer;
begin
  result := GetIntegerField('SaleID');
end;

function TProcSummary.GetSaleLineID: integer;
begin
  result := GetIntegerField('SaleLineID');
end;

function TProcSummary.GetUOMQtyBuilt: double;
begin
  result := GetFloatField('UOMQtyBuilt');
end;

function TProcSummary.GetUOMQtySold: double;
begin
  result := GetFloatField('UOMQtySold');
end;

function TProcSummary.PropertyNameToFieldName(aPropName: string): string;
begin
  if SameText(aPropName, 'SaleLineID') then
    result := 'sl.SaleLineID'
  else if SameText(aPropName, 'SaleID') then
    result := 'sl.SaleID'
  else
    result := inherited;
end;

function TProcSummary.ValidateData: Boolean;
begin
  resultStatus.Clear;
  result := false;
  AddResult(false,rssWarning,0,'This is a read-only object');
end;

initialization
  RegisterClass(TProcSummary);

end.
