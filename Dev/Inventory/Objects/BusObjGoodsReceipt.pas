unit BusObjGoodsReceipt;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf,
  BusObjEmployee, MyAccess;


type

  TGoodsReceiptLine = class(TMSBusObj)
  private
    function GetMasterID: integer;
    procedure SetBatchExpiryDate(const Value: TDateTime);
    procedure SetBatchNumber(const Value: string);
    procedure SetBinID(const Value: integer);
    procedure SetDeleted(const Value: boolean);
    procedure SetMasterID(const Value: integer);
    procedure SetPurchaseLineID(const Value: integer);
    procedure SetQuantityReceived(const Value: double);
    procedure SetSerialNumber(const Value: string);
    function GetBatchExpiryDate: TDateTime;
    function GetBatchNumber: string;
    function GetBinID: integer;
    function GetDeleted: boolean;
    function GetPurchaseLineID: integer;
    function GetQuantityReceived: double;
    function GetSerialNumber: string;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
//    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property MasterID: integer read GetMasterID write SetMasterID;
    property PurchaseLineID: integer read GetPurchaseLineID write SetPurchaseLineID;
    property QuantityReceived: double read GetQuantityReceived write SetQuantityReceived;
    property SerialNumber: string read GetSerialNumber write SetSerialNumber;
    property BatchNumber: string read GetBatchNumber write SetBatchNumber;
    property BatchExpiryDate: TDateTime read GetBatchExpiryDate write SetBatchExpiryDate;
    property BinID: integer read GetBinID write SetBinID;
    property Deleted: boolean read GetDeleted write SetDeleted;
  end;


  TGoodsReceipt = class(TMSBusObj)
  private
    procedure SetActive(const Value: boolean);
    procedure SetEmployeeID(const Value: integer);
    procedure SetProcessed(const Value: boolean);
    procedure SetReceiptEndTime(const Value: TDateTime);
    procedure SetReceiptStartTime(const Value: TDateTime);
    function GetActive: boolean;
    function GetEmployeeID: integer;
    function GetProcessed: boolean;
    function GetReceiptEndTime: TDateTime;
    function GetReceiptStartTime: TDateTime;
    function GetLines: TGoodsReceiptLine;
    function GetPurchaseOrderID: integer;
    procedure SetPurchaseOrderID(const Value: integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
//    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
//    class function TotalReceivedForPOLine(
//      const GoodsReceiptID, PurchaseLineID: integer; Conn: TCustomMyConnection = nil): double; overload;
//    function TotalReceivedForPOLine(const POLineID: integer): double; overload;
    function Process(var msg: string): boolean;
    procedure Load(const fIsReadonly: boolean = False); override;
//    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
//    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); override;
  published
    property EmployeeID: integer read GetEmployeeID write SetEmployeeID;
    property PurchaseOrderID: integer read GetPurchaseOrderID write SetPurchaseOrderID;
    property ReceiptStartTime: TDateTime read GetReceiptStartTime write SetReceiptStartTime;
    property ReceiptEndTime: TDateTime read GetReceiptEndTime write SetReceiptEndTime;
    property Active: boolean read GetActive write SetActive;
    property Processed: boolean read GetProcessed write SetProcessed;
    property Lines: TGoodsReceiptLine read GetLines;
  end;


implementation


uses
  SysUtils, ERPDbComponents, CommonDbLib, BusObjOrders, BusObjStock;

{ TGoodsReceiptLine }

constructor TGoodsReceiptLine.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblGoodsReceiptLines';

end;

destructor TGoodsReceiptLine.Destroy;
begin

  inherited;
end;

function TGoodsReceiptLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Owner is TGoodsReceipt then
    MasterID := TGoodsReceipt(Owner).ID;
end;

function TGoodsReceiptLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;

end;

function TGoodsReceiptLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TGoodsReceiptLine.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TGoodsReceiptLine.GetBatchExpiryDate: TDateTime;
begin
  result := GetDateTimeField('BatchExpiryDate');
end;

function TGoodsReceiptLine.GetBatchNumber: string;
begin
  result := GetStringField('BatchNumber');
end;

function TGoodsReceiptLine.GetBinID: integer;
begin
  result := GetIntegerField('BinID');
end;

class function TGoodsReceiptLine.GetBusObjectTablename: string;
begin
  result := 'tblGoodsReceiptLines';
end;

function TGoodsReceiptLine.GetDeleted: boolean;
begin
  result := GetBooleanField('Deleted');
end;

class function TGoodsReceiptLine.GetIDField: string;
begin
  result := 'ID';
end;

function TGoodsReceiptLine.GetMasterID: integer;
begin
  result := GetIntegerField('MasterID');
end;

function TGoodsReceiptLine.GetPurchaseLineID: integer;
begin
  result := GetIntegerField('PurchaseLineID');
end;

function TGoodsReceiptLine.GetQuantityReceived: double;
begin
  result := GetFloatField('QuantityReceived');
end;

function TGoodsReceiptLine.GetSerialNumber: string;
begin
  result := GetStringField('SerialNumber');
end;

procedure TGoodsReceiptLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
end;

procedure TGoodsReceiptLine.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TGoodsReceiptLine.Save: Boolean;
begin
  result := inherited;
end;

procedure TGoodsReceiptLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TGoodsReceiptLine.SetBatchExpiryDate(const Value: TDateTime);
begin
  SetDateTimeField('BatchExpiryDate', Value);
end;

procedure TGoodsReceiptLine.SetBatchNumber(const Value: string);
begin
  SetStringField('BatchNumber', Value);
end;

procedure TGoodsReceiptLine.SetBinID(const Value: integer);
begin
  SetIntegerField('BinID', Value);
end;

procedure TGoodsReceiptLine.SetDeleted(const Value: boolean);
begin
  SetBooleanField('Deleted', Value);
end;

procedure TGoodsReceiptLine.SetMasterID(const Value: integer);
begin
  SetIntegerField('MasterID', Value);
end;

procedure TGoodsReceiptLine.SetPurchaseLineID(const Value: integer);
begin
  SetIntegerField('PurchaseLineID', Value);
end;

procedure TGoodsReceiptLine.SetQuantityReceived(const Value: double);
begin
  SetFloatField('QuantityReceived', Value);
end;

procedure TGoodsReceiptLine.SetSerialNumber(const Value: string);
begin
  SetStringField('SerialNumber', Value);
end;

function TGoodsReceiptLine.ValidateData: Boolean;
begin
  result := false;
  if MasterID < 1 then begin
    AddResult(false,rssWarning,0,'Goods Receipt ID is not set');
    exit;
  end;
  if (not Deleted) and (PurchaseLineID < 1) then begin
    AddResult(false,rssWarning,0,'Purchase Order Line ID is not set');
    exit;
  end;
  result := true;
end;

{ TGoodsReceipt }

constructor TGoodsReceipt.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGoodsReceipt.Destroy;
begin

  inherited;
end;

function TGoodsReceipt.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

function TGoodsReceipt.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

function TGoodsReceipt.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TGoodsReceipt.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TGoodsReceipt.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TGoodsReceipt.GetBusObjectTablename: string;
begin
  result := 'tblGoodsReceipt';
end;

function TGoodsReceipt.GetEmployeeID: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

class function TGoodsReceipt.GetIDField: string;
begin
  result := 'ID';
end;

function TGoodsReceipt.GetLines: TGoodsReceiptLine;
begin
  result := TGoodsReceiptLine(GetContainerComponent(TGoodsReceiptLine,'MasterID = ' + IntToStr(ID)));
end;

function TGoodsReceipt.GetProcessed: boolean;
begin
  result := GetBooleanField('Processed');
end;

function TGoodsReceipt.GetReceiptEndTime: TDateTime;
begin
  result := GetDateTimeField('ReceiptEndTime');
end;

function TGoodsReceipt.GetReceiptStartTime: TDateTime;
begin
  result := GetDateTimeField('ReceiptStartTime');
end;

procedure TGoodsReceipt.Load(const fIsReadonly: boolean);
begin
  inherited;
  Container.Clear;
end;

procedure TGoodsReceipt.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TGoodsReceipt.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TGoodsReceipt.Process(var msg: string): boolean;
var
  PO: TPurchaseOrder;
  IsSN, ISBatch, IsBin: boolean;
begin
  result := true;
  Lines.PostDb;
  PostDB;
  ResultStatus.Clear;
  if not ValidateData then begin
    result := false;
    msg := ResultStatus.Messages;
    exit;
  end;
  if Lines.Count = 0 then begin
    result := false;
    msg := 'Nothing has been received yet';
    exit;
  end;
  { update the PO }
  PO := TPurchaseOrder.Create(nil);
  try
    PO.Connection := self.Connection;
    PO.SilentMode := true;
    PO.Load(self.PurchaseOrderID);
    if PO.Lock then begin
      Connection.BeginNestedTransaction;
      try
        Lines.First;
        while not Lines.EOF do begin
          if PO.Lines.Dataset.Locate('PurchaseLineID',Lines.PurchaseLineID,[]) then begin
            { update this line }
            PO.Lines.UOMQtyShipped := PO.Lines.UOMQtyShipped + Lines.QuantityReceived;
            TProduct.CheckAllocation(PO.Lines.ProductID,IsBatch,IsBin,IsSN);
            if IsBatch or IsBin then begin
              result := false;
              msg := 'Receipt of Bin or Batch enabled products is not supported.';
              Connection.RollbackNestedTransaction;
              exit;
            end
            else if IsSN then begin
              if Lines.SerialNumber <> '' then begin
                PO.Lines.PQA.PQASN.New;
                PO.Lines.PQA.PQASN.SerialNumber := Lines.SerialNumber;
                PO.Lines.PQA.PQASN.Qty := 1;
                PO.Lines.PQA.PQASN.PostDb;
              end;
            end;
          end
          else begin
            result := false;
            msg := 'Could not find Purchase Line ID ' + IntToStr(Lines.PurchaseLineID) + ', aborting processing of this Goods Receipt.';
            Connection.RollbackNestedTransaction;
            exit;
          end;

          Lines.Next;
        end;
        if not PO.Save then begin
          result := false;
          msg := PO.ResultStatus.Messages;
          Connection.RollbackNestedTransaction;
          exit;
        end
        else begin
          if ReceiptEndTime = 0 then
            ReceiptEndTime := now;
          Self.Processed := true;
          PostDb;
          Connection.CommitNestedTransaction;
        end;
      except
        on e: exception do begin
          result := false;
          msg := 'Error Processing: ' + e.Message;
          Connection.RollbackNestedTransaction;
        end;

      end;

    end
    else begin
      result := false;
      msg := PO.ResultStatus.Messages;
    end;
  finally
    PO.Free;
  end;
end;

function TGoodsReceipt.Save: Boolean;
begin

  ResultStatus.Clear;
  result := inherited;
  if not result then exit;
  result := ValidateData;


end;

procedure TGoodsReceipt.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TGoodsReceipt.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TGoodsReceipt.SetEmployeeID(const Value: integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TGoodsReceipt.SetProcessed(const Value: boolean);
begin
  SetBooleanField('Processed', Value);
end;

procedure TGoodsReceipt.SetReceiptEndTime(const Value: TDateTime);
begin
  SetDateTimeField('ReceiptEndTime', Value);
end;

procedure TGoodsReceipt.SetReceiptStartTime(const Value: TDateTime);
begin
  SetDAteTimeField('ReceiptStartTime', Value);
end;

//function TGoodsReceipt.TotalReceivedForPOLine(const POLineID: integer): double;
//begin
//  result := TGoodsReceipt.TotalReceivedForPOLine(ID, POLIneID, Connection.Connection);
//end;
//
//class function TGoodsReceipt.TotalReceivedForPOLine(const GoodsReceiptID,
//  PurchaseLineID: integer; Conn: TCustomMyConnection): double;
//var
//  qry: TERPQuery;
//begin
//  qry := TERPQuery.Create(nil);
//  try
//    if Assigned(conn) then qry.Connection := conn
//    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Add('select sum(QuantityReceived) as Qty from tblGoodsReceiptLines');
//    qry.SQL.Add('where MasterId = ' + IntToStr(GoodsReceiptID));
//    qry.SQL.Add('and PurchaseLineID = ' + IntToStr(PurchaseLineID));
//    qry.Open;
//    result := qry.FieldByName('Qty').AsFloat;
//  finally
//    qry.Free;
//  end;
//end;

function TGoodsReceipt.ValidateData: Boolean;
begin
  result := false;
  if Active then begin
    if EmployeeID < 1 then begin
      AddResult(false, rssWarning, 0, 'No Employee Selected');
      exit;
    end;
    if self.PurchaseOrderID < 1 then begin
      AddResult(false, rssWarning, 0, 'No Purchase Order Selected');
      exit;
    end;
  end;
  result := true;
end;

function TGoodsReceipt.GetPurchaseOrderID: integer;
begin
  result := GetIntegerField('PurchaseOrderID');
end;

procedure TGoodsReceipt.SetPurchaseOrderID(const Value: integer);
begin
  SetIntegerField('PurchaseOrderID', Value);
end;



end.
