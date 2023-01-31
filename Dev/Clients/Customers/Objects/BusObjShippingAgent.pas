unit BusObjShippingAgent;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/04/10  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TShippingAgent = class(TMSBusObj)
  private
    function GetCode               : string    ;
    function GetDescription        : string    ;
//    function GetSupplierId         : Integer   ;
    function GetDefaultSizeUOMID         : Integer   ;
    function GetDefaultWeightUOMID         : Integer   ;
//    function GetSupplierName       : string    ;
    procedure SetCode               (const Value: string    );
    procedure SetDescription        (const Value: string    );
//    procedure SetSupplierId         (const Value: Integer   );
    procedure SetDefaultSizeUOMID         (const Value: Integer   );
    procedure SetDefaultWeightUOMID         (const Value: Integer   );
//    procedure SetSupplierName       (const Value: string    );
    function GetInsurance: string;
    procedure SetInsurance(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property Code                :string      read GetCode              write SetCode           ;
    property Insurance: string read GetInsurance write SetInsurance;
    property Description         :string      read GetDescription       write SetDescription    ;
//    property SupplierId          :Integer     read GetSupplierId        write SetSupplierId     ;
    property DefaultSizeUOMID          :Integer     read GetDefaultSizeUOMID        write SetDefaultSizeUOMID     ;
    property DefaultWeightUOMID          :Integer     read GetDefaultWeightUOMID        write SetDefaultWeightUOMID     ;
//    property SupplierName        :string      read GetSupplierName      write SetSupplierName   ;
  end;


implementation


uses tcDataUtils, CommonLib, tcConst, sysutils, AppEnvironmentVirtual;



  {TShippingAgent}

constructor TShippingAgent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ShippingAgent';
  fSQL := 'SELECT * FROM tblshippingagent';
end;


destructor TShippingAgent.Destroy;
begin
  inherited;
end;


procedure TShippingAgent.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Code');
  SetPropertyFromNode(node,'Insurance');
  SetPropertyFromNode(node,'Description');
//  SetPropertyFromNode(node,'SupplierId');
  SetPropertyFromNode(node,'DefaultSizeUOMID');
  SetPropertyFromNode(node,'DefaultWeightUOMID');
//  SetPropertyFromNode(node,'SupplierName');
end;


procedure TShippingAgent.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Code' ,Code);
  AddXMLNode(node,'Insurance', Insurance);
  AddXMLNode(node,'Description' ,Description);
//  AddXMLNode(node,'SupplierId' ,SupplierId);
  AddXMLNode(node,'DefaultSizeUOMID' ,DefaultSizeUOMID);
  AddXMLNode(node,'DefaultWeightUOMID' ,DefaultWeightUOMID);
//  AddXMLNode(node,'SupplierName' ,SupplierName);
end;


function TShippingAgent.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if code = '' then begin
    AddResult(False , rssError , 0,  'Code Should not be Blank.' , False );
    Exit;
  end;
//  if SupplierId = 0 then begin
//    AddResult(False , rssError , 0,  'Supplier Should not be Blank' , False );
//    Exit;
//  end;
//  if not IsUnique(Self.ID , 'Code = '+quotedstr(Code) +' and SupplierId = ' +IntToStr(SupplierId)) then begin
//    AddResult(False , rssError , 0,  code +' Already exists for '+Suppliername +'.' , False );
//    Exit;
//  end;
  Result := True;
end;


function TShippingAgent.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TShippingAgent.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TShippingAgent.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TShippingAgent.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TShippingAgent.GetIDField: string;
begin
  Result := 'ShippingAgentID'
end;


class function TShippingAgent.GetBusObjectTablename: string;
begin
  Result:= 'tblshippingagent';
end;


function TShippingAgent.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TShippingAgent.GetCode           : string    ; begin Result := GetStringField('Code');end;
function  TShippingAgent.GetDescription    : string    ; begin Result := GetStringField('Description');end;
//function  TShippingAgent.GetSupplierId     : Integer   ; begin Result := GetIntegerField('SupplierId');end;
function  TShippingAgent.GetDefaultSizeUOMID     : Integer   ; begin Result := GetIntegerField('DefaultSizeUOMID');if result = 0 then result := GetUnitOfMeasureID(AppEnvVirt.Str['DefaultClass.DefaultUOM'], 0); end;
function  TShippingAgent.GetDefaultWeightUOMID     : Integer   ; begin Result := GetIntegerField('DefaultWeightUOMID');if result = 0 then result := GetUnitOfMeasureID(AppEnvVirt.Str['DefaultClass.DefaultUOM'], 0); end;
//function  TShippingAgent.GetSupplierName   : string    ; begin Result := GetStringField('SupplierName');end;
procedure TShippingAgent.SetCode           (const Value: string    ); begin SetStringField('Code'            , Value);end;
procedure TShippingAgent.SetDescription    (const Value: string    ); begin SetStringField('Description'     , Value);end;
//procedure TShippingAgent.SetSupplierId     (const Value: Integer   ); begin SetIntegerField('SupplierId'      , Value);end;
procedure TShippingAgent.SetDefaultSizeUOMID     (const Value: Integer   ); begin SetIntegerField('DefaultSizeUOMID'      , Value);end;
procedure TShippingAgent.SetDefaultWeightUOMID     (const Value: Integer   ); begin SetIntegerField('DefaultWeightUOMID'      , Value);end;
//procedure TShippingAgent.SetSupplierName   (const Value: string    ); begin SetStringField('SupplierName'    , Value);end;


function TShippingAgent.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  DefaultSizeUOMID := GetUnitOfMeasureID(AppEnvVirt.Str['DefaultClass.DefaultUOM'],0);
  DefaultWeightUOMID := GetUnitOfMeasureID(AppEnvVirt.Str['DefaultClass.DefaultUOM'],0);
end;

function TShippingAgent.GetInsurance: string;
begin
  result:= GetStringField('Insurance');
end;

procedure TShippingAgent.SetInsurance(const Value: string);
begin
  SetStringField('Insurance',Value);
end;

class function TShippingAgent.GetKeyStringField: string;
begin
  result:= 'Code';
end;

initialization
  RegisterClass(TShippingAgent);


end.
