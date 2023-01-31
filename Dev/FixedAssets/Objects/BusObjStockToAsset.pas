unit BusObjStockToAsset;

interface

uses
  BusObjBase, Classes, DB, XMLIntf;

type

  TStockToAssetLine = class;
  TStockToAsset = class(TMSBusObj)
  private
    AllLinesValid: boolean;
    function GetActive: boolean;
    function GetCreationDate: TDateTime;
    function GetDescription: string;
    function GetEmployeeID: integer;
    function GetEmployeeName: string;
    function GetProcessDate: TDateTime;
    function GetProcessed: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetDescription(const Value: string);
    procedure SetEmployeeID(const Value: integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetProcessDate(const Value: TDateTime);
    procedure SetProcessed(const Value: boolean);
    function GetLines: TStockToAssetLine;
    procedure ValidateLines(const Sender: TBusObj; var Abort: Boolean);
    function GetStockAdjustEntryID: integer;
    procedure SetStockAdjustEntryID(const Value: integer);
    function GetPurchaseOrderId: integer;
    procedure SetPurchaseOrderId(const Value: integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property EmployeeID: integer read GetEmployeeID write SetEmployeeID;
    function CreateFixedAssets(var msg: string): boolean;
    procedure SetAllAssetTypes(const aAssetType: string);
    procedure SetAllIsHire(const aIsHire: boolean);
  published
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate;
    property ProcessDate: TDateTime read GetProcessDate write SetProcessDate;
    property Processed: boolean read GetProcessed write SetProcessed;
    property Active: boolean read GetActive write SetActive;
    property Description: string read GetDescription write SetDescription;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property PurchaseOrderId: integer read GetPurchaseOrderId write SetPurchaseOrderId;
    property StockAdjustEntryID: integer read GetStockAdjustEntryID write SetStockAdjustEntryID;
    property Lines: TStockToAssetLine read GetLines;
  end;

  TStockToAssetLine = class(TMSBusObj)
  private
    function GetAssetCode: string;
    function GetAssetName: string;
    function GetBatchExpiryDate: TDateTime;
    function GetBatchNumber: string;
    function GetIsHireAsset: boolean;
    function GetProductID: integer;
    function GetProductName: string;
    function GetProductType: string;
    function GetSerialNumber: string;
    function GetStockToFixedAssetID: integer;
    procedure SetAssetCode(const Value: string);
    procedure SetAssetName(const Value: string);
    procedure SetBatchExpiryDate(const Value: TDateTime);
    procedure SetBatchNumber(const Value: string);
    procedure SetIsHireAsset(const Value: boolean);
    procedure SetProductID(const Value: integer);
    procedure SetProductName(const Value: string);
    procedure SetProductType(const Value: string);
    procedure SetSerialNumber(const Value: string);
    procedure SetStockToFixedAssetID(const Value: integer);
    function GetIsBatch: boolean;
    function GetIsBin: boolean;
    function GetIsSerialNumber: boolean;
    procedure SetIsBatch(const Value: boolean);
    procedure SetIsBin(const Value: boolean);
    procedure SetIsSerialNumber(const Value: boolean);
    function GetBinLocation: string;
    function GetBinNumber: string;
    procedure SetBinLocation(const Value: string);
    procedure SetBinNumber(const Value: string);
    function GetAssetId: integer;
    procedure SetAssetId(const Value: integer);
    function GetDeptClassName: string;
    function GetPurchaseCost: double;
    function GetPurchaseDate: TDateTime;
    procedure SetDeptClassName(const Value: string);
    procedure SetPurchaseCost(const Value: double);
    procedure SetPurchaseDate(const Value: TDateTime);
    function GetAssetType: string;
    procedure SetAssetType(const Value: string);
    function GetAssetDescription: string;
    procedure SetAssetDescription(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property ProductID: integer read GetProductID write SetProductID;
  published
    property StockToFixedAssetID: integer read GetStockToFixedAssetID write SetStockToFixedAssetID;
    property ProductName: string read GetProductName write SetProductName;
    property ProductType: string read GetProductType write SetProductType;
    property IsBatch: boolean read GetIsBatch write SetIsBatch;
    property IsBin: boolean read GetIsBin write SetIsBin;
    property IsSerialNumber: boolean read GetIsSerialNumber write SetIsSerialNumber;
    property AssetName: string read GetAssetName write SetAssetName;
    property AssetDescription: string read GetAssetDescription write SetAssetDescription;
    property AssetCode: string read GetAssetCode write SetAssetCode;
    property IsHireAsset: boolean read GetIsHireAsset write SetIsHireAsset;
    property BinNumber: string read GetBinNumber write SetBinNumber;
    property BinLocation: string read GetBinLocation write SetBinLocation;
    property BatchNumber: string read GetBatchNumber write SetBatchNumber;
    property BatchExpiryDate: TDateTime read GetBatchExpiryDate write SetBatchExpiryDate;
    property SerialNumber: string read GetSerialNumber write SetSerialNumber;
    property AssetId: integer read GetAssetId write SetAssetId;
    property PurchaseDate: TDateTime read GetPurchaseDate write SetPurchaseDate;
    property PurchaseCost: double read GetPurchaseCost write SetPurchaseCost;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property AssetType: string read GetAssetType write SetAssetType;
  end;

implementation

uses
  BusObjEmployee, SysUtils, BusObjStock, AppEnvironment, BusObjFixedAsset,
  BusobjStockAdjustEntry, BusObjClass, BusObjConst, ERPDbComponents,
  DbSharedObjectsObj;

{ StockToAsset }

constructor TStockToAsset.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Stock To Asset';
  fSQL := 'SELECT * FROM tblStockToFixedAsset';
end;

function TStockToAsset.CreateFixedAssets(var msg: string): boolean;
var
  Asset: TFixedAssets;
  StockAdjust: TStockAdjustEntry;
  found: boolean;
begin
  result := true;
  Asset := TFixedAssets.Create(nil);
  StockAdjust := nil;
  try
    Asset.Connection := Self.Connection;
    Asset.SilentMode := true;
    Asset.Load(0);
    Lines.First;
    while not Lines.EOF do begin
      if Lines.AssetId = 0 then begin

        Asset.New;
        Asset.AssetName := Lines.AssetName;
        Asset.Description := Lines.AssetDescription;
        Asset.AssetCode := Lines.AssetCode;
        Asset.PurchDate := Lines.PurchaseDate;
        Asset.DepreciationStartDate := Asset.PurchDate;
        Asset.PurchCost := Lines.PurchaseCost;
        Asset.AssetType := Lines.AssetType;
        Asset.ClassID := TDeptClass.IDToggle(Lines.DeptClassName);
        if Lines.IsHireAsset then begin
          Asset.AssetHire.Active := true;
          Asset.AssetHire.HireIncomeAccountName := AppEnv.CompanyPrefs.DefaultHireIncomeAccount;
          Asset.AssetHire.HireProductName := AppEnv.CompanyPrefs.DefaultHireProductName;
        end;
        if Asset.Save then begin
          Lines.AssetId := Asset.ID;
        end
        else begin
          result := false;
          msg := 'Error creating Asset "' + Asset.AssetName + '"' + #13#10 +
            Asset.ResultStatus.Messages;
          exit;
        end;
        if SameText(Lines.ProductType,'INV') then begin
          { we need to adjust stock .. }

          if not Assigned(StockAdjust) then begin
            StockAdjust := TStockAdjustEntry.Create(nil);
            StockAdjust.Connection := self.Connection;
            StockAdjust.Load(0);
            StockAdjust.SilentMode := true;
            StockAdjust.New;
            StockAdjust.Employee := self.EmployeeName;
            StockAdjust.Notes := 'Stock transfer to Asset' + #13#10 + self.Description;
            StockAdjust.AdjustType := 'Gen';
            StockAdjust.AdjustmentOnInStock := true;
            StockAdjust.PostDb;
          end;

          { do we already have a stock adjustment line for this }
          found := false;
          StockAdjust.Lines.First;
          while not StockAdjust.Lines.EOF do begin
            if StockAdjust.Lines.ProductID = Lines.ProductID then begin
              if SameText(StockAdjust.Lines.DeptName, Lines.DeptClassName) then begin
                found := true;
                if Lines.IsSerialNumber and
                  (not SameText(StockAdjust.Lines.SerialNumber,Lines.SerialNumber)) then begin
                  found := false;
                  break;
                end;
                if Lines.IsBin and
                  ((not SameText(StockAdjust.Lines.BinLocation,Lines.BinLocation))
                    or (not SameText(StockAdjust.Lines.BinNumber,Lines.BinNumber))) then found := false;
                if Lines.IsBatch and
                  ((not SameText(StockAdjust.Lines.BatchNo,Lines.BatchNumber))
                    or (StockAdjust.Lines.ExpiryDate <> Lines.BatchExpiryDate)) then found := false;
                if found then begin
  //                StockAdjust.Lines.AdjustQty := StockAdjust.Lines.AdjustQty -1;
  //                StockAdjust.Lines.PostDb;
  //                if Lines.IsSerialNumber or Lines.IsBin or Lines.IsBatch then
  //                  found := false;
                  break;
                end;
              end;
            end;
            StockAdjust.Lines.Next;
          end;

          if not found then begin
            StockAdjust.Lines.New;
            StockAdjust.Lines.ProductID := Lines.ProductID;
            StockAdjust.Lines.DeptName := Lines.DeptClassName;
            if Lines.IsSerialNumber then
              StockAdjust.Lines.SerialNumber := Lines.SerialNumber;
            if Lines.IsBin then begin
              { these will set the BinId .. }
              StockAdjust.Lines.BinLocation := Lines.BinLocation;
              StockAdjust.Lines.BinNumber := Lines.BinNumber;
            end;
            if Lines.IsBatch then begin
              StockAdjust.Lines.BatchNo := Lines.BatchNumber;
              if Lines.BatchExpiryDate > 0 then
                StockAdjust.Lines.ExpiryDate := Lines.BatchExpiryDate;
            end;
          end;
          StockAdjust.Lines.AdjustQty := StockAdjust.Lines.AdjustQty -1;
          StockAdjust.Lines.PostDb;
        end;
      end;
      SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress, nil);
      Lines.Next;

    end;
    if Assigned(StockAdjust) then begin
      if not StockAdjust.Save then begin
        result := false;
        msg := 'Error creating Stock Adjustment.' + #13#10 +
          StockAdjust.ResultStatus.Messages;
        exit;
      end
      else begin
        self.StockAdjustEntryID := StockAdjust.ID;
        if not StockAdjust.Process then begin
          result := false;
          if StockAdjust.ResultStatus.Count > 0 then
            msg := StockAdjust.ResultStatus.Messages
          else
            msg := 'Error Creating Stock Adjustment';
          exit;
        end;
      end;
    end;
    Connection.BeginTransaction;
    self.Processed := true;
    self.ProcessDate := Date;
    self.PostDb;
    Connection.CommitTransaction;
  finally
    Asset.Free;
    StockAdjust.Free;
  end;
end;

destructor TStockToAsset.Destroy;
begin

  inherited;
end;

function TStockToAsset.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  CreationDate := now;
  EmployeeID := AppEnv.Employee.EmployeeID;
end;

function TStockToAsset.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TStockToAsset.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'EmployeeName')) then begin
    EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end
  else if (Sysutils.SameText(Sender.FieldName, 'EmployeeID')) then begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  end;
end;

function TStockToAsset.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TStockToAsset.GetBusObjectTablename: string;
begin
  result := 'tblStockToFixedAsset';
end;

function TStockToAsset.GetCreationDate: TDateTime;
begin
  result := GetDateTimeField('CreationDate');
end;

function TStockToAsset.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TStockToAsset.GetEmployeeID: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TStockToAsset.GetEmployeeName: string;
begin
  result := GetStringField('EmployeeName');
end;

class function TStockToAsset.GetIDField: string;
begin
  result := 'StockToFixedAssetID';
end;

function TStockToAsset.GetLines: TStockToAssetLine;
begin
  result := TStockToAssetLine(GetContainerComponent(TStockToAssetLine,'StockToFixedAssetID = ' + IntToStr(ID)));
end;

function TStockToAsset.GetProcessDate: TDateTime;
begin
  result := GetDateTimeField('ProcessedDate');
end;

function TStockToAsset.GetProcessed: boolean;
begin
  result := GetBooleanField('Processed');
end;

function TStockToAsset.GetPurchaseOrderId: integer;
begin
  result := GetIntegerField('PurchaseOrderId');
end;

function TStockToAsset.GetSQL: string;
begin
  result := inherited;
end;

function TStockToAsset.GetStockAdjustEntryID: integer;
begin
  result := GetIntegerField('StockAdjustEntryID');
end;

procedure TStockToAsset.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TStockToAsset.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TStockToAsset.Save: Boolean;
begin
  ResultStatus.Clear;
  result := ValidateData;
  if not result then exit;
  result := inherited;
end;

procedure TStockToAsset.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TStockToAsset.SetActive(const Value: boolean);
begin
  SetBooleanField('Active',Value);
end;

procedure TStockToAsset.SetAllAssetTypes(const aAssetType: string);
var
  bm: TBookmark;
begin
  bm := Lines.Dataset.GetBookmark;
  try
    Lines.First;
    while not Lines.EOF do begin
      Lines.AssetType := aAssetType;
      Lines.PostDb;
      Lines.Next;
    end;
    Lines.Dataset.GotoBookmark(bm);
  finally
    Lines.Dataset.FreeBookmark(bm);
  end;

end;

procedure TStockToAsset.SetAllIsHire(const aIsHire: boolean);
var
  bm: TBookmark;
begin
  bm := Lines.Dataset.GetBookmark;
  try
    Lines.First;
    while not Lines.EOF do begin
      Lines.IsHireAsset := aIsHire;
      Lines.PostDb;
      Lines.Next;
    end;
    Lines.Dataset.GotoBookmark(bm);
  finally
    Lines.Dataset.FreeBookmark(bm);
  end;
end;

procedure TStockToAsset.SetCreationDate(const Value: TDateTime);
begin
  SetDateTimeField('CreationDate',Value);
end;

procedure TStockToAsset.SetDescription(const Value: string);
begin
  SetStringField('Description',Value);
end;

procedure TStockToAsset.SetEmployeeID(const Value: integer);
begin
  SetIntegerField('EmployeeID',Value);
end;

procedure TStockToAsset.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName',Value);
end;

procedure TStockToAsset.SetProcessDate(const Value: TDateTime);
begin
  SetDateTimeField('ProcessDate',Value);
end;

procedure TStockToAsset.SetProcessed(const Value: boolean);
begin
  SetBooleanField('Processed',Value);
end;

procedure TStockToAsset.SetPurchaseOrderId(const Value: integer);
begin
  SetIntegerField('PurchaseOrderId', Value);
end;

procedure TStockToAsset.SetStockAdjustEntryID(const Value: integer);
begin
  SetIntegerField('StockAdjustEntryID',Value);
end;

function TStockToAsset.ValidateData: Boolean;
begin
  result := inherited;
  if not result then exit;
  result := false;
  if Description = '' then begin
    AddResult(false,rssWarning,0,'Description is blank');
    exit;
  end;
  if EmployeeName = '' then begin
    AddResult(false,rssWarning,0,'Employee Name is blank');
    exit;
  end;
  AllLinesValid := True;
  Lines.PostDb;
  Lines.IterateRecords(ValidateLines);
//  if deleted then AllLinesValid:= True; // ignore the line validations if deleted. This is to enable deleting invalid bank deposits of Electonauts - they have deposit entries with blank account ids
  if not AllLinesValid then exit;

  result := true;
end;

procedure TStockToAsset.ValidateLines(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not TStockToAssetLine(Sender).ValidateData then AllLinesValid := False;
end;

{ TStockToAssetLine }

constructor TStockToAssetLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Stock To Asset Line';
  fSQL := 'SELECT * FROM tblStockToFixedAssetLine';
end;

destructor TStockToAssetLine.Destroy;
begin

  inherited;
end;

function TStockToAssetLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TStockToAsset) then begin
    TStockToAsset(Owner).PostDb;
    self.StockToFixedAssetID := TStockToAsset(Owner).ID;
  end;
end;

function TStockToAssetLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TStockToAssetLine.DoFieldOnChange(Sender: TField);
var
  qry: TERPQuery;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'ProductName')) then begin
    qry := DbSharedObj.GetQuery(Connection.Connection);
    try
      qry.SQL.Text := 'select * from tblParts where PartName = ' + QuotedStr(ProductName);
      qry.Open;
      ProductId := qry.FieldByName('PARTSID').AsInteger;
      AssetDescription := qry.FieldByName('PARTSDESCRIPTION').AsString;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end
  else if (Sysutils.SameText(Sender.FieldName, 'ProductID')) then begin
    qry := DbSharedObj.GetQuery(Connection.Connection);
    try
      qry.SQL.Text := 'select * from tblParts where PARTSID = ' + IntToStr(ProductID);
      qry.Open;
      ProductName := qry.FieldByName('PARTNAme').AsString;
      AssetDescription := qry.FieldByName('PARTSDESCRIPTION').AsString;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;
end;

function TStockToAssetLine.GetAssetCode: string;
begin
  result := GetStringField('AssetCode');
end;

function TStockToAssetLine.GetAssetDescription: string;
begin
  result := GetStringField('AssetDescription');
end;

function TStockToAssetLine.GetAssetId: integer;
begin
  result := GetIntegerField('AssetId');
end;

function TStockToAssetLine.GetAssetName: string;
begin
  result := GetStringField('AssetName');
end;

function TStockToAssetLine.GetAssetType: string;
begin
  result := GetStringField('AssetType');
end;

function TStockToAssetLine.GetBatchExpiryDate: TDateTime;
begin
  result := GetDateTimeField('BatchExpiryDate');
end;

function TStockToAssetLine.GetBatchNumber: string;
begin
  result := GetStringField('BatchNumber');
end;

function TStockToAssetLine.GetBinLocation: string;
begin
  result := GetStringField('BinLocation');
end;

function TStockToAssetLine.GetBinNumber: string;
begin
  result := GetStringField('BinNumber');
end;

class function TStockToAssetLine.GetBusObjectTablename: string;
begin
  result := 'tblStockToFixedAssetLine';
end;

function TStockToAssetLine.GetDeptClassName: string;
begin
  result := GetStringField('DeptClassName');
end;

class function TStockToAssetLine.GetIDField: string;
begin
  result := 'StockToFixedAssetLineID';
end;

function TStockToAssetLine.GetIsBatch: boolean;
begin
  result := GetBooleanField('IsBatch');
end;

function TStockToAssetLine.GetIsBin: boolean;
begin
  result := GetBooleanField('IsBin');
end;

function TStockToAssetLine.GetIsHireAsset: boolean;
begin
  result := GetBooleanField('IsHireAsset');
end;

function TStockToAssetLine.GetIsSerialNumber: boolean;
begin
  result := GetBooleanField('IsSerialNumber');
end;

function TStockToAssetLine.GetProductID: integer;
begin
  result := GetIntegerField('ProductID');
end;

function TStockToAssetLine.GetProductName: string;
begin
  result := GetStringField('ProductName');
end;

function TStockToAssetLine.GetProductType: string;
begin
  result := GetStringField('ProductType');
end;

function TStockToAssetLine.GetPurchaseCost: double;
begin
  result := GetFloatField('PurchaseCost');
end;

function TStockToAssetLine.GetPurchaseDate: TDateTime;
begin
  result := GetDateTimeField('PurchaseDate');
end;

function TStockToAssetLine.GetSerialNumber: string;
begin
  result := GetStringField('SerialNumber');
end;

function TStockToAssetLine.GetSQL: string;
begin
  result := inherited;
end;

function TStockToAssetLine.GetStockToFixedAssetID: integer;
begin
  result := GetIntegerField('StockToFixedAssetID');
end;

procedure TStockToAssetLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TStockToAssetLine.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TStockToAssetLine.Save: Boolean;
begin
  result := inherited;
end;

procedure TStockToAssetLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TStockToAssetLine.SetAssetCode(const Value: string);
begin
  SetStringField('AssetCode', Value);
end;

procedure TStockToAssetLine.SetAssetDescription(const Value: string);
begin
  SetStringField('AssetDescription', Value);
end;

procedure TStockToAssetLine.SetAssetId(const Value: integer);
begin
  SetIntegerField('AssetId', Value);
end;

procedure TStockToAssetLine.SetAssetName(const Value: string);
begin
  SetStringField('AssetName', Value);
end;

procedure TStockToAssetLine.SetAssetType(const Value: string);
begin
  SetStringField('AssetType', Value);
end;

procedure TStockToAssetLine.SetBatchExpiryDate(const Value: TDateTime);
begin
  SetDateTimeField('BatchExpiryDate', Value);
end;

procedure TStockToAssetLine.SetBatchNumber(const Value: string);
begin
  SetStringField('BatchNumber',Value);
end;

procedure TStockToAssetLine.SetBinLocation(const Value: string);
begin
  SetStringField('BinLocation',Value);
end;

procedure TStockToAssetLine.SetBinNumber(const Value: string);
begin
  SetStringField('BinNumber',Value);
end;

procedure TStockToAssetLine.SetDeptClassName(const Value: string);
begin
  SetStringField('DeptClassName', Value);
end;

procedure TStockToAssetLine.SetIsBatch(const Value: boolean);
begin
  SetBooleanField('IsBatch',Value);
end;

procedure TStockToAssetLine.SetIsBin(const Value: boolean);
begin
  SetBooleanField('IsBin',Value);
end;

procedure TStockToAssetLine.SetIsHireAsset(const Value: boolean);
begin
  SetBooleanField('IsHireAsset',Value);
end;

procedure TStockToAssetLine.SetIsSerialNumber(const Value: boolean);
begin
  SetBooleanField('IsSerialNumber',Value);
end;

procedure TStockToAssetLine.SetProductID(const Value: integer);
begin
  SetIntegerField('ProductID',Value);
end;

procedure TStockToAssetLine.SetProductName(const Value: string);
begin
  SetStringField('ProductName',Value);
end;

procedure TStockToAssetLine.SetProductType(const Value: string);
begin
  SetStringField('ProductType',Value);
end;

procedure TStockToAssetLine.SetPurchaseCost(const Value: double);
begin
  SetFloatField('PurchaseCost', Value);
end;

procedure TStockToAssetLine.SetPurchaseDate(const Value: TDateTime);
begin
  SetDateTimeField('PurchaseDate',Value);
end;

procedure TStockToAssetLine.SetSerialNumber(const Value: string);
begin
  SetStringField('SerialNumber',Value);
end;

procedure TStockToAssetLine.SetStockToFixedAssetID(const Value: integer);
begin
  SetIntegerField('StockToFixedAssetID',Value);
end;

function TStockToAssetLine.ValidateData: Boolean;
var
  aAssetName: string;
  aAssetId: integer;
  msg: string;
begin
  result := inherited;
  if not result then exit;
  result := false;
  if ProductName = '' then begin
    msg := 'Product is blank';
    if AssetName <> '' then msg := msg + ' for Asset Name "' + AssetName + '"';
    msg := msg + '.' + #13#10 + 'Please Select a Product to Convert to a Hire Asset.';
    AddResult(false,rssWarning,0,msg);
    exit;
  end;
  if ProductType = '' then begin
    msg := 'Product Type is blank';
    if AssetName <> '' then msg := msg + ' for Asset Name "' + AssetName + '"'
    else if ProductName <> '' then msg := msg + ' for Product "' + ProductName + '"';
    msg := msg + '.' + #13#10 + 'Please Select a Product Type.';
    AddResult(false,rssWarning,0,msg);
    exit;
  end;
  if AssetName = '' then begin
    msg := 'Asset Name is blank for Product "' + ProductName + '".';
    msg := msg + '.' + #13#10 + 'Please Enter an Asset Name to use for this Asset.';
    AddResult(false,rssWarning,0,msg);
    exit;
  end;
  if AssetCode = '' then begin
    msg := 'Asset Code is blank for Product "' + ProductName + '".';
    msg := msg + '.' + #13#10 + 'Please Enter a Unique Asset Code to use for this Asset.';
    AddResult(false,rssWarning,0,msg);
    exit;
  end;
  aAssetId := TFixedAssets.AssetIdForCode(AssetCode,aAssetName,AssetId,Connection.Connection);
  if aAssetId > 0 then begin
    msg := 'The Asset Code "' + AssetCode + '" for Asset Name "' + AssetName + '" has already been used for Asset "' + aAssetName + '".';
    msg := msg + #13#10 + 'Please Enter a Unique Asset Code to use for this Asset.';
    AddResult(false,rssWarning,0,msg);
    exit;
  end;

  result := true;
end;

end.
