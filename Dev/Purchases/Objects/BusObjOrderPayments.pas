unit BusObjOrderPayments;

interface

uses
  BusObjBase, DB, Classes, XMLIntf;

type

  TOrderPrepayment = class(TMSBusObj)
  private
    function GetOrderOriginalRef: string;
    function GetOrderRef: string;
    function GetPrepayRef: string;
    procedure SetOrderOriginalRef(const Value: string);
    procedure SetOrderRef(const Value: string);
    procedure SetPrepayRef(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property OrderRef         :string      read GetOrderRef       write SetOrderRef;
    property OrderOriginalRef :string      read GetOrderOriginalRef write SetOrderOriginalRef;
    property PrepayRef        :string      read GetPrepayRef      write SetPrepayRef;
  end;


implementation

{ TOrderPrepayment }

constructor TOrderPrepayment.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'OrderPrepayment';
  fSQL := 'SELECT * FROM tblordersprepayments';
end;

destructor TOrderPrepayment.Destroy;
begin

  inherited;
end;

function TOrderPrepayment.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterPost(Sender);
end;

procedure TOrderPrepayment.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

class function TOrderPrepayment.GetBusObjectTablename: string;
begin
  Result:= 'tblordersprepayments';
end;

class function TOrderPrepayment.GetIDField: string;
begin
  Result := 'ID'
end;

function TOrderPrepayment.GetOrderOriginalRef: string;
begin
  result := GetStringField('OrderOriginalRef');
end;

function TOrderPrepayment.GetOrderRef: string;
begin
  result := GetStringField('OrderRef');
end;

function TOrderPrepayment.GetPrepayRef: string;
begin
  result := GetStringField('PrepayRef');
end;

function TOrderPrepayment.GetSQL: string;
begin
  result := inherited;
end;

procedure TOrderPrepayment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderRef');
  SetPropertyFromNode(node,'OrderOriginalRef');
  SetPropertyFromNode(node,'PrepayRef');
end;

procedure TOrderPrepayment.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TOrderPrepayment.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TOrderPrepayment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderRef', OrderRef);
  AddXMLNode(node,'OrderOriginalRef', OrderOriginalRef);
  AddXMLNode(node,'PrepayRef', PrepayRef);
end;

procedure TOrderPrepayment.SetOrderOriginalRef(const Value: string);
begin
  SetStringField('OrderOriginalRef', Value);
end;

procedure TOrderPrepayment.SetOrderRef(const Value: string);
begin
  SetStringField('OrderRef', Value);
end;

procedure TOrderPrepayment.SetPrepayRef(const Value: string);
begin
  SetStringField('PrepayRef', Value);
end;

function TOrderPrepayment.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := True;
end;

end.
