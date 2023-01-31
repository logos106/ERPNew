unit BusObjIntrastatLines;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  23/01/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tintrastatlines = class(TMSBusObj)
  private
    Function GetIntrastatID               : Integer   ;
    Function GetCommodityCode             : string    ;
    Function GetIntrastatType             : string    ;
    Function GetValue                     : Double    ;
    Function GetDeliveryTerms             : string    ;
    Function GetTransactionNature         : string    ;
    Function GetNetMass                   : Integer   ;
    Function GetProductID                 : Integer   ;
    Function GetSupplementaryUnit         : string    ;
    Function GetCountry                   : string    ;
    Function GetTraderRef                 : string    ;
    Function GetInvoiceOrPOLineID         : Integer   ;
    Procedure SetIntrastatID               (const Value: Integer   );
    Procedure SetCommodityCode             (const Value: string    );
    Procedure SetIntrastatType             (const Value: string    );
    Procedure SetValue                     (const Value: Double    );
    Procedure SetDeliveryTerms             (const Value: string    );
    Procedure SetTransactionNature         (const Value: string    );
    Procedure SetNetMass                   (const Value: Integer   );
    Procedure SetProductID                 (const Value: Integer   );
    Procedure SetSupplementaryUnit         (const Value: string    );
    Procedure SetCountry                   (const Value: string    );
    Procedure SetTraderRef                 (const Value: string    );
    Procedure SetInvoiceOrPoLineID         (const Value: Integer   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
  Published
    property IntrastatID                :Integer     read GetIntrastatID              write SetIntrastatID           ;
    property CommodityCode              :string      read GetCommodityCode            write SetCommodityCode         ;
    property ProductID                  :Integer     read GetProductID                write SetProductID             ;
    property IntrastatType              :string      read GetIntrastatType            write SetIntrastatType         ;
    property Value                      :Double      read GetValue                    write SetValue                 ;
    property DeliveryTerms              :string      read GetDeliveryTerms            write SetDeliveryTerms         ;
    property TransactionNature          :string      read GetTransactionNature        write SetTransactionNature     ;
    property NetMass                    :Integer     read GetNetMass                  write SetNetMass               ;
    property SupplementaryUnit          :string      read GetSupplementaryUnit        write SetSupplementaryUnit     ;
    property Country                    :string      read GetCountry                  write SetCountry               ;
    property TraderRef                  :string      read GetTraderRef                write SetTraderRef             ;
    property InvoiceOrPOLineID          :integer     read GetInvoiceOrPOLineID        write SetInvoiceOrPOLineID;
  end;


implementation


uses BusObjIntrastats, CommonLib;

      {Tintrastatlines}

Constructor Tintrastatlines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'intrastatlines';
  fSQL := 'SELECT * FROM tblintrastatlines';
end;


Destructor Tintrastatlines.Destroy;
begin
  inherited;
end;

Function  Tintrastatlines.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then exit;
    if Assigned(Self.Owner) then
        if Self.Owner is Tintrastats then
                IntrastatId := Tintrastats(Self.Owner).ID;

end;

Procedure Tintrastatlines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'IntrastatID');
  SetPropertyFromNode(node,'CommodityCode');
  SetPropertyFromNode(node,'IntrastatType');
  SetPropertyFromNode(node,'Value');
  SetPropertyFromNode(node,'DeliveryTerms');
  SetPropertyFromNode(node,'TransactionNature');
  SetPropertyFromNode(node,'NetMass');
  SetPropertyFromNode(node,'SupplementaryUnit');
  SetPropertyFromNode(node,'Country');
  SetPropertyFromNode(node,'TraderRef');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'InvoiceOrPOLineID');
end;


Procedure Tintrastatlines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'IntrastatID' ,IntrastatID);
  AddXMLNode(node,'CommodityCode' ,CommodityCode);
  AddXMLNode(node,'IntrastatType' ,IntrastatType);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'DeliveryTerms' ,DeliveryTerms);
  AddXMLNode(node,'TransactionNature' ,TransactionNature);
  AddXMLNode(node,'NetMass' ,NetMass);
  AddXMLNode(node,'SupplementaryUnit' ,SupplementaryUnit);
  AddXMLNode(node,'Country' ,Country);
  AddXMLNode(node,'TraderRef' ,TraderRef);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'InvoiceOrPOLineID' ,InvoiceOrPOLineID);
end;


Function Tintrastatlines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CommodityCode = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Commodity Code should not be blank' );
    Exit;
  end;
  if Value = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Value should not be 0'  );
    Exit;
  end;
  if DeliveryTerms = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Delivery Terms should not be blank' );
    Exit;
  end;
  if Country = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Country should not be blank' );
    Exit;
  end;

  //if NetMass = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'NetMass should not be 0' , False );
//    Exit;
//  end;
  Result := True;
end;


Function Tintrastatlines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tintrastatlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tintrastatlines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tintrastatlines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tintrastatlines.GetIDField: string;
begin
  Result := 'IntrastatLineID'
end;


Class Function Tintrastatlines.GetBusObjectTablename: string;
begin
  Result:= 'tblintrastatlines';
end;


Function Tintrastatlines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tintrastatlines.GetIntrastatID           : Integer   ; begin Result := GetIntegerField('IntrastatID');end;
Function  Tintrastatlines.GetCommodityCode         : string    ; begin Result := GetStringField('CommodityCode');end;
Function  Tintrastatlines.GetIntrastatType         : string    ; begin Result := GetStringField('IntrastatType');end;
Function  Tintrastatlines.GetValue                 : Double    ; begin Result := GetFloatField('Value');end;
Function  Tintrastatlines.GetDeliveryTerms         : string    ; begin Result := GetStringField('DeliveryTerms');end;
Function  Tintrastatlines.GetTransactionNature     : string    ; begin Result := GetStringField('TransactionNature');end;
Function  Tintrastatlines.GetNetMass               : Integer   ; begin Result := GetIntegerField('NetMass');end;
Function  Tintrastatlines.GetProductID             : Integer   ; begin Result := GetIntegerField('ProductID');end;
Function  Tintrastatlines.GetSupplementaryUnit     : string    ; begin Result := GetStringField('SupplementaryUnit');end;
Function  Tintrastatlines.GetCountry               : string    ; begin Result := GetStringField('Country');end;
Function  Tintrastatlines.GetTraderRef             : string    ; begin Result := GetStringField('TraderRef');end;
Function  Tintrastatlines.GetInvoiceOrPOLineID     : Integer   ; begin Result := GetIntegerField('InvoiceOrPOLineID');end;
Procedure Tintrastatlines.SetIntrastatID           (const Value: Integer   ); begin SetIntegerField('IntrastatID'            , Value);end;
Procedure Tintrastatlines.SetCommodityCode         (const Value: string    ); begin SetStringField('CommodityCode'          , Value);end;
Procedure Tintrastatlines.SetIntrastatType         (const Value: string    ); begin SetStringField('IntrastatType'          , Value);end;
Procedure Tintrastatlines.SetValue                 (const Value: Double    ); begin SetFloatField('Value'                  , Value);end;
Procedure Tintrastatlines.SetDeliveryTerms         (const Value: string    ); begin SetStringField('DeliveryTerms'          , Value);end;
Procedure Tintrastatlines.SetTransactionNature     (const Value: string    ); begin SetStringField('TransactionNature'      , Value);end;
Procedure Tintrastatlines.SetNetMass               (const Value: Integer   ); begin SetIntegerField('NetMass'                , Value);end;
Procedure Tintrastatlines.SetProductID             (const Value: Integer   ); begin SetIntegerField('ProductID'                , Value);end;
Procedure Tintrastatlines.SetSupplementaryUnit     (const Value: string    ); begin SetStringField('SupplementaryUnit'      , Value);end;
Procedure Tintrastatlines.SetCountry               (const Value: string    ); begin SetStringField('Country'                , Value);end;
Procedure Tintrastatlines.SetTraderRef             (const Value: string    ); begin SetStringField('TraderRef'              , Value);end;
Procedure Tintrastatlines.SetInvoiceOrPOLineID     (const Value: Integer   ); begin SetIntegerField('InvoiceOrPOLineID'     , Value);end;

initialization
  RegisterClassOnce(Tintrastatlines);


end.
