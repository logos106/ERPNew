unit BusobjSmartOrderRFQ;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  01/08/14  1.00.00  CE  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSmartOrderRFQ = class(TMSBusObj)
  private
    function GetGloablRef           : string    ;
    function GetSupplierID          : Integer   ;
    function GetSmartOrderID        : Integer   ;
    function GetDateEmailedOn       : TDateTime ;
    procedure SetGloablRef           (const Value: string    );
    procedure SetSupplierID          (const Value: Integer   );
    procedure SetSmartOrderID        (const Value: Integer   );
    procedure SetDateEmailedOn       (const Value: TDateTime );
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
  published
    property GloablRef            :string      read GetGloablRef          write SetGloablRef       ;
    property SupplierID           :Integer     read GetSupplierID         write SetSupplierID      ;
    property SmartOrderID         :Integer     read GetSmartOrderID       write SetSmartOrderID      ;
    property DateEmailedOn        :TDateTime   read GetDateEmailedOn      write SetDateEmailedOn   ;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjSmartOrder, SysUtils;



  {TSmartOrderRFQ}

constructor TSmartOrderRFQ.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SmartOrderRFQ';
  fSQL := 'SELECT * FROM tblsmartorderrfq';
end;


destructor TSmartOrderRFQ.Destroy;
begin
  inherited;
end;


procedure TSmartOrderRFQ.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GloablRef');
  SetPropertyFromNode(node,'SupplierID');
  SetPropertyFromNode(node,'SmartOrderID');
  SetDateTimePropertyFromNode(node,'DateEmailedOn');
end;


procedure TSmartOrderRFQ.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GloablRef' ,GloablRef);
  AddXMLNode(node,'SupplierID' ,SupplierID);
  AddXMLNode(node,'SmartOrderID' ,SmartOrderID);
  AddXMLNode(node,'DateEmailedOn' ,DateEmailedOn);
end;


function TSmartOrderRFQ.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SmartOrderID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'RFQ should be linked to a smart order' , False );
    Exit;
  end;
  if SupplierID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'RFQ should be linked to a Supplier' , False );
    Exit;
  end;
  if DateEmailedOn = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DateEmailedOn should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TSmartOrderRFQ.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSmartOrderRFQ.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSmartOrderRFQ.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSmartOrderRFQ.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSmartOrderRFQ.GetIDField: string;
begin
  Result := 'RFQID'
end;


class function TSmartOrderRFQ.GetBusObjectTablename: string;
begin
  Result:= 'tblsmartorderrfq';
end;


function TSmartOrderRFQ.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  DateEmailedOn := Now;
  if assigned(Owner) then
    if owner is TSmartOrder then
      SmartOrderId := TSmartOrder(Owner).ID;
end;

function TSmartOrderRFQ.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSmartOrderRFQ.GetGloablRef       : string    ; begin Result := GetStringField('GloablRef');end;
function  TSmartOrderRFQ.GetSupplierID      : Integer   ; begin Result := GetIntegerField('SupplierID');end;
function  TSmartOrderRFQ.GetSmartOrderID    : Integer   ; begin Result := GetIntegerField('SmartOrderID');end;
function  TSmartOrderRFQ.GetDateEmailedOn   : TDateTime ; begin Result := GetDateTimeField('DateEmailedOn');end;
procedure TSmartOrderRFQ.SetGloablRef       (const Value: string    ); begin SetStringField('GloablRef'         , Value);end;
procedure TSmartOrderRFQ.SetSupplierID      (const Value: Integer   ); begin SetIntegerField('SupplierID'       , Value);end;
procedure TSmartOrderRFQ.SetSmartOrderID    (const Value: Integer   ); begin SetIntegerField('SmartOrderID'     , Value);end;
procedure TSmartOrderRFQ.SetDateEmailedOn   (const Value: TDateTime ); begin SetDateTimeField('DateEmailedOn'   , Value);end;


initialization
  RegisterClass(TSmartOrderRFQ);


end.
