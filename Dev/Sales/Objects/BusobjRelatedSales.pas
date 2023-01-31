unit BusobjRelatedSales;

interface
uses BusObjBase, XMLDoc, XMLIntf, db,classes ;

type
  TRelatedSales = class(TMSBusObj)
  private
    function GetOriginalRef    : string    ;
    function GetPreviousRef    : string    ;
    function GetTransRef       : string    ;
    function GetSeqno          : Integer   ;
    function GetOriginalSaleId : Integer   ;
    function getVariedOn    : Tdatetime;
    Function getApprovedAmount :Double;
    procedure SetOriginalRef    (const Value: string    );
    procedure SetPreviousRef    (const Value: string    );
    procedure SetTransRef       (const Value: string    );
    procedure SetSeqno          (const Value: Integer   );
    procedure SetOriginalSaleId (const Value: Integer   );
    Procedure SetVariedOn    (const Value: Tdatetime);
    Procedure SetApprovedAmount (Const Value :double);
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
    property OriginalRef     :string      read GetOriginalRef   write SetOriginalRef;
    property PreviousRef     :string      read GetPreviousRef   write SetPreviousRef;
    property TransRef        :string      read GetTransRef      write SetTransRef   ;
    property Seqno           :Integer     read GetSeqno         write SetSeqno      ;
    property OriginalSaleId  :Integer     read GetOriginalSaleId write SetOriginalSaleId      ;
    Property VariedOn     :TDateTime   read getVariedOn   write setVariedOn;
    Property ApprovedAmount :Double read getApprovedAmount write setApprovedAmount;
  end;



implementation

uses sysutils, CommonLib;





 {TRelatedSales}

constructor TRelatedSales.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'relatedsales';
  fSQL := 'SELECT * FROM tblrelatedsales';
end;


destructor TRelatedSales.Destroy;
begin
  inherited;
end;


procedure TRelatedSales.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OriginalRef');
  SetPropertyFromNode(node,'PreviousRef');
  SetPropertyFromNode(node,'TransRef');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'OriginalSaleId');
  SetDatetimePropertyFromNode(node,'VariedOn');
  SetPropertyFromNode(node , 'ApprovedAmount');

end;


procedure TRelatedSales.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OriginalRef' ,OriginalRef);
  AddXMLNode(node,'PreviousRef' ,PreviousRef);
  AddXMLNode(node,'TransRef' ,TransRef);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'OriginalSaleId' ,OriginalSaleId);
  AddXMLNode(node,'VariedOn' ,VariedOn);
  addXMLNode(node , 'ApprovedAmount' , ApprovedAmount);
end;


function TRelatedSales.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Seqno = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Seqno should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TRelatedSales.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TRelatedSales.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRelatedSales.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TRelatedSales.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TRelatedSales.GetIDField: string;
begin
  Result := 'ID'
end;


class function TRelatedSales.GetBusObjectTablename: string;
begin
  Result:= 'tblrelatedsales';
end;


function TRelatedSales.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TRelatedSales.GetOriginalRef: string    ; begin Result := GetStringField('OriginalRef');end;
function  TRelatedSales.GetPreviousRef: string    ; begin Result := GetStringField('PreviousRef');end;
function  TRelatedSales.GetTransRef   : string    ; begin Result := GetStringField('TransRef');end;
function  TRelatedSales.GetSeqno      : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TRelatedSales.GetOriginalSaleId     : Integer   ; begin Result := GetIntegerField('OriginalSaleId');end;
function  TRelatedSales.getVariedOn:Tdatetime  ; begin result := getDateTimefield('VariedOn');end;
function TRelatedSales.GetApprovedAmount :Double ; begin result := getfloatfield('ApprovedAmount'); end;
procedure TRelatedSales.SetOriginalRef(const Value: string    ); begin SetStringField('OriginalRef' , Value);end;
procedure TRelatedSales.SetPreviousRef(const Value: string    ); begin SetStringField('PreviousRef' , Value);end;
procedure TRelatedSales.SetTransRef   (const Value: string    ); begin SetStringField('TransRef'    , Value);end;
procedure TRelatedSales.SetSeqno      (const Value: Integer   ); begin SetIntegerField('Seqno'       , Value);end;
procedure TRelatedSales.SetOriginalSaleId     (const Value: Integer   ); begin SetIntegerField('OriginalSaleId'       , Value);end;
Procedure TRelatedSales.SetVariedOn(Const Value:TDateTime  ); begin setDatetimefield('VariedOn' , Value);end;
Procedure TRelatedSales.setApprovedAmount (const Value:double); begin setfloatfield('ApprovedAmount' , Value); end;


initialization
  RegisterClass(TRelatedSales);

end.
