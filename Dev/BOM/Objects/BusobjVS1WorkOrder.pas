unit BusObjVS1WorkOrder;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/11/22  1.00.00  Wang  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjSales;

type

  TVS1WorkOrder = class(TMSBusObj)
  private
    function GetLID             : Integer;
    function GetBOMStructure    : String;
    function GetCustomer        : String;
    function GetDueDate         : TDateTime;
    function GetInProgress      : Boolean;
    function GetOrderTo         : String;
    function GetPONumber        : String;
    function GetSaleDate        : TDateTime;
    function GetSaleID          : Integer;
    function GetStartTime       : TDateTime;
    function GetEndTime         : TDateTime;
    function GetCompleted       : Boolean;
    function GetLines           : TSalesOrderLine;

    procedure SetLID            (const Value: Integer);
    procedure SetBOMStructure   (const Value: String);
    procedure SetCustomer       (const Value: String);
    procedure SetDueDate        (const Value: TDateTime);
    procedure SetInProgress     (const Value: Boolean);
    procedure SetOrderTo        (const Value: String);
    procedure SetPONumber       (const Value: String);
    procedure SetSaleDate       (const Value: TDateTime);
    procedure SetSaleID         (const Value: Integer);
    procedure SetStartTime      (const Value: TDateTime);
    procedure SetEndTime        (const Value: TDateTime);
    procedure SetCompleted      (const VAlue: Boolean);
    
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
//    Property Lines :TVS1WorkOrderLines read getLines;

  published
    property LID            : Integer         read GetLID           write SetLID;
    property BOMStructure   : String          read GetBOMStructure  write SetBOMStructure;
    property Customer       : String          read GetCustomer      write SetCustomer;
    property DueDate        : TDateTime       read GetDueDate       write SetDueDate;
    property Inprogress     : Boolean         read GetInProgress    write SetInProgress;
    property Lines          : TSalesOrderLine read GetLines;
    property OrderTo        : String          read GetOrderTo       write SetOrderTo;
    property PONumber       : String          read GetPONumber      write SetPONumber;
    property SaleDate       : TDateTime       read GetSaleDate      write SetSaleDate;
    property SaleID         : Integer         read GetSaleID        write SetSaleID;
    property StartTime      : TDateTime       read GetStartTime     write SetStartTime;
    property EndTime        : TDateTime       read GetEndTime       write SetEndTime;
    property Completed      : Boolean         read GetCompleted     write SetCompleted;

  end;


implementation

uses tcDataUtils, CommonLib, Sysutils, AppEnvironment, dateutils;

constructor TVS1WorkOrder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VS1WorkOrder';
  fSQL := 'SELECT * FROM tblvs1workorder';
end;

destructor TVS1WorkOrder.Destroy;
begin
  inherited;
end;

procedure TVS1WorkOrder.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  
  SetPropertyFromNode(node, 'LID');
  SetPropertyFromNode(node, 'BOMStructure');
  SetPropertyFromNode(node, 'Customer');
  SetDateTimePropertyFromNode(node, 'DueDate');
  SetPropertyFromNode(node, 'InProgress');
  SetPropertyFromNode(node, 'OrderTo');
  SetPropertyFromNode(node, 'PONumber');
  SetPropertyFromNode(node, 'SaleDate');
  SetPropertyFromNode(node, 'StartTime');
  SetPropertyFromNode(node, 'EndTime');
  SetPropertyFromNode(node, 'Completed');
end;


procedure TVS1WorkOrder.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'LID', LID);
  AddXMLNode(node,'BOMStructure', BOMStructure);
  AddXMLNode(node,'Customer', Customer);
  AddXMLNode(node,'DueDate', DueDate);
  AddXMLNode(node,'InProgress', InProgress);
  AddXMLNode(node,'OrderTo', OrderTo);
  AddXMLNode(node,'PONumber', PONumber);
  AddXMLNode(node,'SaleDate', SaleDate);
  AddXMLNode(node,'SaleID', SaleID);
  AddXMLNode(node,'StartTime', StartTime);
  AddXMLNode(node,'EndTime', EndTime);
  AddXMLNode(node,'Completed', Completed);
end; 

function TVS1WorkOrder.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if LID = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'LID should not be 0', False);
    Exit;
  end;

  if Customer = '' then begin
    Resultstatus.AddItem(False, rssError, 0, 'Customer should not be blank', False);
    Exit;
  end;

  Result := True;
end; 

function TVS1WorkOrder.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end; 

procedure TVS1WorkOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end; 

procedure TVS1WorkOrder.DoFieldOnChange(Sender: TField);
begin
  inherited;
end; 

function TVS1WorkOrder.GetSQL: string;
begin
  Result := inherited GetSQL;
end; 

class function TVS1WorkOrder.GetIDField: string;
begin
  Result := 'ID'
end; 

function TVS1WorkOrder.GetLines: TSalesOrderLine;
begin
  Result := TSalesOrderLine(Getcontainercomponent(TSalesOrderLine, 'SaleID = ' + IntToStr(SaleID)));
end;

class function TVS1WorkOrder.GetBusObjectTablename: string;
begin
  Result := 'tblvs1workorder';
end; 

function TVS1WorkOrder.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then Exit;
end;

function TVS1WorkOrder.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end; 

{Property Functions}
function TVS1WorkOrder.GetLID           : Integer;      begin Result := GetIntegerField('LID');         end;
function TVS1WorkOrder.GetBOMStructure  : String;       begin Result := GetStringField('BOMStructure'); end;
function TVS1WorkOrder.GetCustomer      : String;       begin Result := GetStringField('Customer');     end;
function TVS1WorkOrder.GetDueDate       : TDateTime;    begin Result := GetDateTimeField('DueDate');        end;
function TVS1WorkOrder.GetInProgress    : Boolean;      begin Result := GetBooleanField('InProgress');  end;
function TVS1WorkOrder.GetOrderTo       : String;       begin Result := GetStringField('OrderTo');      end;
function TVS1WorkOrder.GetPONumber      : String;       begin Result := GetStringField('PONumber');     end;
function TVS1WorkOrder.GetSaleDate      : TDateTime;    begin Result := GetDateTimeField('SaleDate');   end;
function TVS1WorkOrder.GetSaleID        : Integer;      begin Result := GetIntegerField('SaleID');      end;
function TVS1WorkOrder.GetStartTime     : TDateTime;    begin Result := GetDateTimeField('StartTime');  end;
function TVS1WorkOrder.GetEndTime       : TDateTime;    begin Result := GetDateTimeField('EndTime');    end;
function TVS1WorkOrder.GetCompleted     : Boolean;      begin Result := GetBooleanField('Completed');   end; 

procedure TVS1WorkOrder.SetLID          (const Value: Integer);   begin SetIntegerField('LID', Value);          end;
procedure TVS1WorkOrder.SetBOMStructure (const Value: String);    begin SetStringField('BOMStructure', Value);  end;
procedure TVS1WorkOrder.SetCustomer     (const Value: String);    begin SetStringField('Customer', Value);     end;
procedure TVS1WorkOrder.SetDueDate      (const Value: TDateTime); begin SetDateTimeField('DueDate', Value);     end;
procedure TVS1WorkOrder.SetInProgress   (const Value: Boolean);   begin SetBooleanField('InProgress', Value);   end;
procedure TVS1WorkOrder.SetOrderTo      (const Value: String);    begin SetStringField('OrderTo', Value);       end;
procedure TVS1WorkOrder.SetPONumber     (const Value: String);    begin SetStringField('PONumber', Value);     end;
procedure TVS1WorkOrder.SetSaleDate     (const Value: TDateTime); begin SetDateTimeField('SaleDate', Value);    end;
procedure TVS1WorkOrder.SetSaleID       (const Value: Integer);   begin SetIntegerField('SaleID', Value);       end;
procedure TVS1WorkOrder.SetStartTime    (const Value: TDateTime); begin SetDateTimeField('StartTime', Value);   end;
procedure TVS1WorkOrder.SetEndTime      (const Value: TDateTime); begin SetDateTimeField('EndTime', Value);     end;
procedure TVS1WorkOrder.SetCompleted    (const Value: Boolean);   begin SetBooleanField('Completed', Value);    end;
     
initialization
  RegisterClass(TVS1WorkOrder);

end.
