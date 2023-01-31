unit BusObjPQAList;

interface

uses
  BusObjBase, Classes;

type
  TPQADetailsList = class(TMSBusObj)
  private
    function GetActive: Boolean;
    function GetBinID: Integer;
    function GetBOQty: double;
    function GetBOUOMQty: double;
    function getCUSTFLD1: Double;
    function getCUSTFLD2: Integer;
    function getCUSTFLD3: Integer;
    function GetParentRef: string;
    function GetPQAType: string;
    function GetQty: Double;
    function GetUOMQty: Double;
    function GetProductId: integer;
    function GetProductName: string;
    function GetTransId: integer;
    function GetTransLineId: integer;
    function GetTransType: string;
    function GetUOM: string;
    function GetUOMID: integer;
    function GetPQAQty: double;
    function GetPQAUOMQty: double;
    function GetTransDate: TDateTime;
    function GetPQAId: integer;
  protected
    function GetValue: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
  published
    property Qty: Double read GetQty;
    property UOMQty: Double read GetUOMQty;
    property PQAType: string read GetPQAType;
    property BOQty: double read GetBOQty;
    property BOUOMQty: double read GetBOUOMQty;
    property ParentRef: string read GetParentRef;
    property BinID: Integer read GetBinID;
    property Active: Boolean read GetActive;
    property Value: string read GetValue;
    Property CUSTFLD1 :Double read getCUSTFLD1;
    Property CUSTFLD2 :Integer read getCUSTFLD2;
    Property CUSTFLD3 :Integer read getCUSTFLD3;
    property TransType: string read GetTransType;
    property TransId: integer read GetTransId;
    property TransLineId: integer read GetTransLineId;
    property TransDate: TDateTime read GetTransDate;
    property ProductId: integer read GetProductId;
    property ProductName: string read GetProductName;
    property UOM: string read GetUOM;
    property UOMID: integer read GetUOMID;
    property PQAId: integer read GetPQAId;
    property PQAQty: double read GetPQAQty;
    property PQAUOMQty: double read GetPQAUOMQty;
  end;

  TPQABatchList = class(TPQADetailsList)
  private
    function GetExpiryDate: TDateTime;
    function GetTruckLoadNo: string;
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BatchNo: string read GetValue;
    property ExpiryDate: TDateTime read GetExpiryDate;
    property TruckLoadNo: string read GetTruckLoadNo;
  end;

  TPQASaleBatchList = class(TPQABatchList)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TPQAPOBatchList = class(TPQABatchList)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  PQALib;

{ TPQADetailsList }

constructor TPQADetailsList.Create(AOwner: TComponent);
begin
  inherited;
  fSQL :=
    'select' +
    ' tblpqadetails.*,' +
    ' tblpqa.TransType,' +
    ' tblpqa.TransID,' +
    ' tblpqa.TransLineId,' +
    ' tblpqa.TransDate,' +
    ' tblpqa.ProductId,' +
    ' tblpqa.ProductName,' +
    ' tblpqa.UOM,' +
    ' tblpqa.UOMID,' +
    ' tblpqa.Qty as PQAQty,' +
    ' tblpqa.UOMQty as PQAUOMQty' +
    ' from tblpqadetails' +
    ' inner join tblpqa on tblpqadetails.PQAID = tblpqa.PQAID and tblPQA.Active = "T"' +
    ' where tblpqadetails.Active = "T"';
end;

destructor TPQADetailsList.Destroy;
begin

  inherited;
end;

function TPQADetailsList.GetActive: Boolean;
begin
  result := GetBooleanField('Active');
end;

function TPQADetailsList.GetBinID: Integer;
begin
  result := GetIntegerField('BinID');
end;

function TPQADetailsList.GetBOQty: double;
begin
  result := GetFloatField('BOQty');
end;

function TPQADetailsList.GetBOUOMQty: double;
begin
  result := GetFloatField('BOUOMQty');
end;

class function TPQADetailsList.GetBusObjectTablename: string;
begin
  result := '';
end;

function TPQADetailsList.getCUSTFLD1: Double;
begin
  result := GetFloatField('CUSTFLD1');
end;

function TPQADetailsList.getCUSTFLD2: Integer;
begin
  result := GetIntegerField('CUSTFLD2');
end;

function TPQADetailsList.getCUSTFLD3: Integer;
begin
  result := GetIntegerField('CUSTFLD3');
end;

class function TPQADetailsList.GetIDField: string;
begin
  result := 'PQADetailID';
end;

class function TPQADetailsList.GetKeyStringField: string;
begin
  result := inherited;
end;

function TPQADetailsList.GetParentRef: string;
begin
  result := GetStringField('ParentRef');
end;

function TPQADetailsList.GetPQAId: integer;
begin
  result := GetIntegerField('PQAId');
end;

function TPQADetailsList.GetPQAQty: double;
begin
  result := GetFloatField('PQAQty');
end;

function TPQADetailsList.GetPQAType: string;
begin
  result := GetStringField('PQAType');
end;

function TPQADetailsList.GetPQAUOMQty: double;
begin
  result := GetFloatField('PQAUOMQty');
end;

function TPQADetailsList.GetProductId: integer;
begin
  result := GetIntegerField('ProductId');
end;

function TPQADetailsList.GetProductName: string;
begin
  result := GetStringField('ProductName');
end;

function TPQADetailsList.GetQty: Double;
begin
  result := GetFloatField('Qty');
end;

function TPQADetailsList.GetTransDate: TDateTime;
begin
  result := GetDateTimeField('TransDate');
end;

function TPQADetailsList.GetTransId: integer;
begin
  result := GetIntegerField('TransId');
end;

function TPQADetailsList.GetTransLineId: integer;
begin
  result := GetIntegerField('TransLineId');
end;

function TPQADetailsList.GetTransType: string;
begin
  result := GetStringField('TransType');
end;

//function TPQADetailsList.GetSQL: string;
//begin
//  result := 'select * from tblpqadetails';
//end;

function TPQADetailsList.GetUOM: string;
begin
  result := GetStringField('UOM');
end;

function TPQADetailsList.GetUOMID: integer;
begin
  result := GetIntegerField('UOMId');
end;

function TPQADetailsList.GetUOMQty: Double;
begin
  result := GetFloatField('UOMQty');
end;

function TPQADetailsList.GetValue: string;
begin
  result := GetStringField('Value');
end;

{ TPQABatchList }

//function TPQABatchList.GetSQL: string;
//begin
//  result := inherited;
//  result := result  + ' and tblpqadetails.PQAType = "Batch"';
//end;

{ TPQABatchList }

constructor TPQABatchList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := fSQL + ' and tblpqadetails.PQAType = "Batch"';
  ExportExcludeList.Add('binid');
  ExportExcludeList.Add('value');
end;

function TPQABatchList.GetExpiryDate: TDateTime;
begin
  result := GetDateTimeField('ExpiryDate');
end;

function TPQABatchList.GetTruckLoadNo: string;
begin
  result := GetStringField('TruckLoadNo');
end;

{ TPQASaleBatchList }

constructor TPQASaleBatchList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := fSQL + ' and tblpqa.TransType in (' + PQALib.SalesTransTypes  + ')';
end;

{ TPQAPOBatchList }

constructor TPQAPOBatchList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := fSQL + ' and tblpqa.TransType in (' + PQALib.POTranstypes  + ')';
end;

initialization
  RegisterClass(TPQABatchList);
  RegisterClass(TPQASaleBatchList);
  RegisterClass(TPQAPOBatchList);

end.
