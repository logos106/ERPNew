unit BusObjMergedSalesLines;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/10/11  1.00.00  WS  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf , busobjsalebase;


type
  TMergedSalesLines = class(TSalesLineBase)
  private
    function GetBaseno                      : string    ;
    function GetBoID                        : string    ;
    function GetSalelineRef                 : string    ;
    function GetSaleRef                     : string    ;
    function GetInvoiceRef                  : string    ;
    function GetInvoiceLineRef              : string    ;
    procedure SetBaseno                      (const Value: string    );
    procedure SetBoID                        (const Value: string    );
    procedure SetSalelineRef                 (const Value: string    );
    procedure SetSaleRef                     (const Value: string    );
    procedure SetInvoiceRef                  (const Value: string    );
    procedure SetInvoiceLineRef              (const Value: string    );
  protected
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property Baseno                       :string      read GetBaseno                     write SetBaseno                  ;
    property BoID                         :string      read GetBoID                       write SetBoID                    ;
    property SalelineRef                  :string      read GetSalelineRef                write SetSalelineRef             ;
    property SaleRef                      :string      read GetSaleRef                    write SetSaleRef                 ;
    property InvoiceRef                   :string      read GetInvoiceRef                 write SetInvoiceRef              ;
    property InvoiceLineRef               :string      read GetInvoiceLineRef             write SetInvoiceLineRef          ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TMergedSalesLines}

constructor TMergedSalesLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'MergedSalesLines';
  fSQL := 'SELECT * FROM tblmergedsaleslines';
end;


destructor TMergedSalesLines.Destroy;
begin
  inherited;
end;


procedure TMergedSalesLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Baseno');
  SetPropertyFromNode(node,'BoID');
  SetPropertyFromNode(node,'SalelineRef');
  SetPropertyFromNode(node,'SaleRef');
  SetPropertyFromNode(node,'InvoiceRef');
  SetPropertyFromNode(node,'InvoiceLineRef');

end;


procedure TMergedSalesLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Baseno' ,Baseno);
  AddXMLNode(node,'BoID' ,BoID);
  AddXMLNode(node,'SalelineRef' ,SalelineRef);
  AddXMLNode(node,'SaleRef' ,SaleRef);
  AddXMLNode(node,'InvoiceRef' ,InvoiceRef);
  AddXMLNode(node,'InvoiceLineRef' ,InvoiceLineRef);

end;


function TMergedSalesLines.ValidateData: Boolean ;
begin
  Result := True;
end;


function TMergedSalesLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TMergedSalesLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TMergedSalesLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TMergedSalesLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TMergedSalesLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TMergedSalesLines.GetBusObjectTablename: string;
begin
  Result:= 'tblmergedsaleslines';
end;


function TMergedSalesLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
 Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TMergedSalesLines.GetBaseno                  : string    ; begin Result := GetStringField('Baseno');end;
function  TMergedSalesLines.GetBoID                    : string    ; begin Result := GetStringField('BoID');end;
function  TMergedSalesLines.GetSalelineRef             : string    ; begin Result := GetStringField('SalelineRef');end;
function  TMergedSalesLines.GetSaleRef                 : string    ; begin Result := GetStringField('SaleRef');end;
function  TMergedSalesLines.GetInvoiceRef              : string    ; begin Result := GetStringField('InvoiceRef');end;
function  TMergedSalesLines.GetInvoiceLineRef          : string    ; begin Result := GetStringField('InvoiceLineRef');end;

procedure TMergedSalesLines.SetBaseno                  (const Value: string    ); begin SetStringField('Baseno'                   , Value);end;
procedure TMergedSalesLines.SetBoID                    (const Value: string    ); begin SetStringField('BoID'                     , Value);end;
procedure TMergedSalesLines.SetSalelineRef             (const Value: string    ); begin SetStringField('SalelineRef'              , Value);end;
procedure TMergedSalesLines.SetSaleRef                 (const Value: string    ); begin SetStringField('SaleRef'                  , Value);end;
procedure TMergedSalesLines.SetInvoiceRef              (const Value: string    ); begin SetStringField('InvoiceRef'               , Value);end;
procedure TMergedSalesLines.SetInvoiceLineRef          (const Value: string    ); begin SetStringField('InvoiceLineRef'           , Value);end;

initialization
  RegisterClass(TMergedSalesLines);


end.
