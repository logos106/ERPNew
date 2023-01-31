unit BusObjBarcodeXRef;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/12/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TBarcodeXRefType = (btNone=0, btWorkOrder =1 );

  TBarcodeXRef = class(TMSBusObj)
  private
    function GetBarcodetype         : string    ;
    function GetBarcode             : string    ;
    function GetstrValue1              : string    ;
    function GetstrValue2              : string    ;
    function GetstrValue3              : string    ;
    function GetstrValue4              : string    ;
    function GetstrValue5              : string    ;
    function GetIntValue1              : Integer    ;
    function GetIntValue2              : Integer    ;
    function GetIntValue3              : Integer    ;
    function GetIntValue4              : Integer    ;
    function GetIntValue5              : Integer    ;
    procedure SetBarcodetype         (const Value: string    );
    procedure SetBarcode             (const Value: string    );
    procedure SetstrValue1              (const Value: string    );
    procedure SetstrValue2              (const Value: string    );
    procedure SetstrValue3              (const Value: string    );
    procedure SetstrValue4              (const Value: string    );
    procedure SetstrValue5              (const Value: string    );
    procedure SetIntValue1              (const Value: Integer    );
    procedure SetIntValue2              (const Value: Integer    );
    procedure SetIntValue3              (const Value: Integer    );
    procedure SetIntValue4              (const Value: Integer    );
    procedure SetIntValue5              (const Value: Integer    );
    function getDeleted: Boolean;
    procedure SetDeleted(const Value: Boolean);
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
    property Barcodetype          :string      read GetBarcodetype        write SetBarcodetype     ;
    property Barcode              :string      read GetBarcode            write SetBarcode         ;
    property strValue1               :string      read GetstrValue1             write SetstrValue1          ;
    property strValue2               :string      read GetstrValue2             write SetstrValue2          ;
    property strValue3               :string      read GetstrValue3             write SetstrValue3          ;
    property strValue4               :string      read GetstrValue4             write SetstrValue4          ;
    property strValue5               :string      read GetstrValue5             write SetstrValue5          ;
    property IntValue1               :Integer      read GetIntValue1             write SetIntValue1          ;
    property IntValue2               :Integer      read GetIntValue2             write SetIntValue2          ;
    property IntValue3               :Integer      read GetIntValue3             write SetIntValue3          ;
    property IntValue4               :Integer      read GetIntValue4             write SetIntValue4          ;
    property IntValue5               :Integer      read GetIntValue5             write SetIntValue5          ;
    Property Deleted                 :Boolean      read getDeleted               Write SetDeleted;
  end;
  Function BarcodeXRefTypeToStr(const Value :TBarcodeXRefType ):string;
  Function StrToBarcodeXRefType(const Value :String ):TBarcodeXRefType;

implementation


uses tcDataUtils, CommonLib, tcConst;

Function StrToBarcodeXRefType(const Value :String ):TBarcodeXRefType;
begin
  if Value = BarCodeType_WorkOrder then result := btWorkOrder
  else result := btNone;
end;

Function BarcodeXRefTypeToStr(const Value :TBarcodeXRefType ):string;
begin
  result := '';
  if Value = btWorkOrder then result := BarCodeType_WorkOrder
  else if value = btNone then Result := BarCodeType_None;

end;
  {TBarcodeXRef}

constructor TBarcodeXRef.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BarcodeXRef';
  fSQL := 'SELECT * FROM tblbarcodexref';
end;


destructor TBarcodeXRef.Destroy;
begin
  inherited;
end;


procedure TBarcodeXRef.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Barcodetype');
  SetPropertyFromNode(node,'Barcode');
  SetPropertyFromNode(node,'strValue1');
  SetPropertyFromNode(node,'strValue2');
  SetPropertyFromNode(node,'strValue3');
  SetPropertyFromNode(node,'strValue4');
  SetPropertyFromNode(node,'strValue5');
  SetPropertyFromNode(node,'IntValue1');
  SetPropertyFromNode(node,'IntValue2');
  SetPropertyFromNode(node,'IntValue3');
  SetPropertyFromNode(node,'IntValue4');
  SetPropertyFromNode(node,'IntValue5');
end;


procedure TBarcodeXRef.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Barcodetype' ,Barcodetype);
  AddXMLNode(node,'Barcode' ,Barcode);
  AddXMLNode(node,'strValue1' ,strValue1);
  AddXMLNode(node,'strValue2' ,strValue2);
  AddXMLNode(node,'strValue3' ,strValue3);
  AddXMLNode(node,'strValue4' ,strValue4);
  AddXMLNode(node,'strValue5' ,strValue5);
  AddXMLNode(node,'IntValue1' ,IntValue1);
  AddXMLNode(node,'IntValue2' ,IntValue2);
  AddXMLNode(node,'IntValue3' ,IntValue3);
  AddXMLNode(node,'IntValue4' ,IntValue4);
  AddXMLNode(node,'IntValue5' ,IntValue5);
end;


function TBarcodeXRef.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TBarcodeXRef.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBarcodeXRef.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBarcodeXRef.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBarcodeXRef.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBarcodeXRef.GetIDField: string;
begin
  Result := 'ID'
end;


class function TBarcodeXRef.GetBusObjectTablename: string;
begin
  Result:= 'tblbarcodexref';
end;
function TBarcodeXRef.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function TBarcodeXRef.getDeleted: Boolean;begin  REsult := getBooleanfield('Deleted');end;
function  TBarcodeXRef.GetBarcodetype     : string    ; begin Result := GetStringField('Barcodetype');end;
function  TBarcodeXRef.GetBarcode         : string    ; begin Result := GetStringField('Barcode');end;
function  TBarcodeXRef.GetstrValue1          : string    ; begin Result := GetStringField('strValue1');end;
function  TBarcodeXRef.GetstrValue2          : string    ; begin Result := GetStringField('strValue2');end;
function  TBarcodeXRef.GetstrValue3          : string    ; begin Result := GetStringField('strValue3');end;
function  TBarcodeXRef.GetstrValue4          : string    ; begin Result := GetStringField('strValue4');end;
function  TBarcodeXRef.GetstrValue5          : string    ; begin Result := GetStringField('strValue5');end;
function  TBarcodeXRef.GetIntValue1          : Integer    ; begin Result := GetIntegerField('IntValue1');end;
function  TBarcodeXRef.GetIntValue2          : Integer    ; begin Result := GetIntegerField('IntValue2');end;
function  TBarcodeXRef.GetIntValue3          : Integer    ; begin Result := GetIntegerField('IntValue3');end;
function  TBarcodeXRef.GetIntValue4          : Integer    ; begin Result := GetIntegerField('IntValue4');end;
function  TBarcodeXRef.GetIntValue5          : Integer    ; begin Result := GetIntegerField('IntValue5');end;
procedure TBarcodeXRef.SetBarcodetype     (const Value: string    ); begin SetStringField('Barcodetype'      , Value);end;
procedure TBarcodeXRef.SetDeleted         (const Value: Boolean   ); begin  SetBooleanField('Deleted', Value);end;
procedure TBarcodeXRef.SetBarcode         (const Value: string    ); begin SetStringField('Barcode'          , Value);end;
procedure TBarcodeXRef.SetstrValue1          (const Value: string    ); begin SetStringField('strValue1'           , Value);end;
procedure TBarcodeXRef.SetstrValue2          (const Value: string    ); begin SetStringField('strValue2'           , Value);end;
procedure TBarcodeXRef.SetstrValue3          (const Value: string    ); begin SetStringField('strValue3'           , Value);end;
procedure TBarcodeXRef.SetstrValue4          (const Value: string    ); begin SetStringField('strValue4'           , Value);end;
procedure TBarcodeXRef.SetstrValue5          (const Value: string    ); begin SetStringField('strValue5'           , Value);end;
procedure TBarcodeXRef.SetIntValue1          (const Value: Integer    ); begin SetIntegerField('IntValue1'           , Value);end;
procedure TBarcodeXRef.SetIntValue2          (const Value: Integer    ); begin SetIntegerField('IntValue2'           , Value);end;
procedure TBarcodeXRef.SetIntValue3          (const Value: Integer    ); begin SetIntegerField('IntValue3'           , Value);end;
procedure TBarcodeXRef.SetIntValue4          (const Value: Integer    ); begin SetIntegerField('IntValue4'           , Value);end;
procedure TBarcodeXRef.SetIntValue5          (const Value: Integer    ); begin SetIntegerField('IntValue5'           , Value);end;


initialization
  RegisterClass(TBarcodeXRef);


end.
