unit busobjCardFast;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  30/10/07  1.00.01  bS  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf;


type
  TCardfastDetails = class(TMSBusObj)
  private
    Function GetCardHolderName    : string    ;
    Function GetTransType         : string    ;
    Function GetTxReference       : string    ;
    Function GetMerchantID        : string    ;
    Function GetTxType            : String   ;
    Function GetAmount            : Double    ;
    Function GetCardNumber        : string    ;
    Function GetExpiryDate        : string    ;
    Function GetAuthID            : string    ;
    Function GetApply             : Boolean   ;
    Function GetProcessed         : Boolean   ;
    Procedure SetCardHolderName    (const Value: string    );
    Procedure SetTransType         (const Value: string    );
    Procedure SetTxReference       (const Value: string    );
    Procedure SetMerchantID        (const Value: string    );
    Procedure SetTxType            (const Value: String    );
    Procedure SetAmount            (const Value: Double    );
    Procedure SetCardNumber        (const Value: string    );
    Procedure SetExpiryDate        (const Value: string    );
    Procedure SetAuthID            (const Value: string    );
    Procedure SetApply             (const Value: Boolean   );
    Procedure SetProcessed         (const Value: Boolean   );
  Protected
    Procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    Class Function  GetIDField: string;                                  override;
    Class Function  getBusObjectTablename :String;                       Override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
  Published
    property CardHolderName     :string      read GetCardHolderName   write SetCardHolderName;
    property TransType          :string      read GetTransType        write SetTransType     ;
    property TxReference        :string      read GetTxReference      write SetTxReference   ;
    property MerchantID         :string      read GetMerchantID       write SetMerchantID    ;
    property TxType             :String      read GetTxType           write SetTxType        ;
    property Amount             :Double      read GetAmount           write SetAmount        ;
    property CardNumber         :string      read GetCardNumber       write SetCardNumber    ;
    property ExpiryDate         :string      read GetExpiryDate       write SetExpiryDate    ;
    property AuthID             :string      read GetAuthID           write SetAuthID        ;
    property Apply              :Boolean     read GetApply            write SetApply         ;
    property Processed          :Boolean     read GetProcessed        write SetProcessed     ;
  end;


implementation






      {TCardfastDetails}

Constructor TCardfastDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Cardfast';
  fSQL := 'SELECT * FROM tblcardfast';
end;


Destructor TCardfastDetails.Destroy;
begin
  inherited;
end;


Procedure TCardfastDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CardHolderName');
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'TxReference');
  SetPropertyFromNode(node,'MerchantID');
  SetPropertyFromNode(node,'TxType');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'CardNumber');
  SetPropertyFromNode(node,'ExpiryDate');
  SetPropertyFromNode(node,'AuthID');
  SetPropertyFromNode(node,'Apply');
  SetPropertyFromNode(node,'Processed');
end;


Procedure TCardfastDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CardHolderName' ,CardHolderName);
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'TxReference' ,TxReference);
  AddXMLNode(node,'MerchantID' ,MerchantID);
  AddXMLNode(node,'TxType' ,TxType);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'CardNumber' ,CardNumber);
  AddXMLNode(node,'ExpiryDate' ,ExpiryDate);
  AddXMLNode(node,'AuthID' ,AuthID);
  AddXMLNode(node,'Apply' ,Apply);
  AddXMLNode(node,'Processed' ,Processed);
end;


Function TCardfastDetails.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TCardfastDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TCardfastDetails.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TCardfastDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TCardfastDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Class Function  TCardfastDetails.getBusObjectTablename :String;
begin
    Result := 'tblcardfast';
end;
Class Function TCardfastDetails.GetIDField: string;
begin
  Result := 'RecordingID'
end;


Function TCardfastDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  TCardfastDetails.GetCardHolderName: string    ; begin Result := GetStringField('CardHolderName')  ;end;
Function  TCardfastDetails.GetTransType     : string    ; begin Result := GetStringField('TransType')       ;end;
Function  TCardfastDetails.GetTxReference   : string    ; begin Result := GetStringField('TxReference')     ;end;
Function  TCardfastDetails.GetMerchantID    : string    ; begin Result := GetStringField('MerchantID')      ;end;
Function  TCardfastDetails.GetTxType        : string    ; begin Result := GetstringField('TxType')         ;end;
Function  TCardfastDetails.GetAmount        : Double    ; begin Result := GetFloatField('Amount')           ;end;
Function  TCardfastDetails.GetCardNumber    : string    ; begin Result := GetStringField('CardNumber')      ;end;
Function  TCardfastDetails.GetExpiryDate    : string    ; begin Result := GetStringField('ExpiryDate')      ;end;
Function  TCardfastDetails.GetAuthID        : string    ; begin Result := GetStringField('AuthID')          ;end;
Function  TCardfastDetails.GetApply         : Boolean   ; begin Result := GetBooleanField('Apply')          ;end;
Function  TCardfastDetails.GetProcessed     : Boolean   ; begin Result := GetBooleanField('Processed')      ;end;
Procedure TCardfastDetails.SetCardHolderName(const Value: string ); begin SetStringField('CardHolderName', Value);end;
Procedure TCardfastDetails.SetTransType     (const Value: string ); begin SetStringField('TransType'     , Value);end;
Procedure TCardfastDetails.SetTxReference   (const Value: string ); begin SetStringField('TxReference'   , Value);end;
Procedure TCardfastDetails.SetMerchantID    (const Value: string ); begin SetStringField('MerchantID'    , Value);end;
Procedure TCardfastDetails.SetTxType        (const Value: string ); begin SetstringField('TxType'       , Value);end;
Procedure TCardfastDetails.SetAmount        (const Value: Double ); begin SetFloatField('Amount'         , Value);end;
Procedure TCardfastDetails.SetCardNumber    (const Value: string ); begin SetStringField('CardNumber'    , Value);end;
Procedure TCardfastDetails.SetExpiryDate    (const Value: string ); begin SetStringField('ExpiryDate'    , Value);end;
Procedure TCardfastDetails.SetAuthID        (const Value: string ); begin SetStringField('AuthID'        , Value);end;
Procedure TCardfastDetails.SetApply         (const Value: Boolean); begin SetBooleanField('Apply'        , Value);end;
Procedure TCardfastDetails.SetProcessed     (const Value: Boolean); begin SetBooleanField('Processed'    , Value);end;


initialization
  RegisterClass(TCardfastDetails);


end.
