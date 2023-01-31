unit BusObjGovGatewayTest;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/04/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tukgovgatewaytest = class(TMSBusObj)
  private
    Function GetGenericKeyID           : Integer   ;
    Function GetDeclarationType        : string    ;
    Function GetCurrentResponseType    : string    ;
    Function GetCorrelationID          : string    ;
    Function GetNoOfAttempts           : Integer   ;
    Function GetLastMessageRecieved    : TDateTime ;
    Function GetCurrentSentType        : string    ;
    Function GetErrorNumber            : string    ;
    Function GetErrorType              : string    ;
    Function GetLastMessageSent        : TDateTime ;
    Function GetErrorMessage           : string    ;
    Function GetResponseEndPoint       : string    ;
    Function GetPollInterval           : Integer   ;
    Function GetResponseClass          : string    ;
    Function GetProtocolState          : string    ;
    Function GetIsFinalised            : Boolean   ;
    Procedure SetGenericKeyID           (const Value: Integer   );
    Procedure SetDeclarationType        (const Value: string    );
    Procedure SetCurrentResponseType    (const Value: string    );
    Procedure SetCorrelationID          (const Value: string    );
    Procedure SetNoOfAttempts           (const Value: Integer   );
    Procedure SetLastMessageRecieved    (const Value: TDateTime );
    Procedure SetCurrentSentType        (const Value: string    );
    Procedure SetErrorNumber            (const Value: string    );
    Procedure SetErrorType              (const Value: string    );
    Procedure SetLastMessageSent        (const Value: TDateTime );
    Procedure SetErrorMessage           (const Value: string    );
    Procedure SetResponseEndPoint       (const Value: string    );
    Procedure SetPollInterval           (const Value: Integer   );
    Procedure SetResponseClass          (const Value: string    );
    Procedure SetProtocolState          (const Value: string    );
    Procedure SetIsFinalised            (const Value: Boolean   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
    property GenericKeyID            :Integer     read GetGenericKeyID          write SetGenericKeyID       ;
    property DeclarationType         :string      read GetDeclarationType       write SetDeclarationType    ;
    property CurrentResponseType     :string      read GetCurrentResponseType   write SetCurrentResponseType;
    property CorrelationID           :string      read GetCorrelationID         write SetCorrelationID      ;
    property NoOfAttempts            :Integer     read GetNoOfAttempts          write SetNoOfAttempts       ;
    property LastMessageRecieved     :TDateTime   read GetLastMessageRecieved   write SetLastMessageRecieved;
    property CurrentSentType         :string      read GetCurrentSentType       write SetCurrentSentType    ;
    property ErrorNumber             :string      read GetErrorNumber           write SetErrorNumber        ;
    property ErrorType               :string      read GetErrorType             write SetErrorType          ;
    property LastMessageSent         :TDateTime   read GetLastMessageSent       write SetLastMessageSent    ;
    property ErrorMessage            :string      read GetErrorMessage          write SetErrorMessage       ;
    property ResponseEndPoint        :string      read GetResponseEndPoint      write SetResponseEndPoint   ;
    property PollInterval            :Integer     read GetPollInterval          write SetPollInterval       ;
    property ResponseClass           :string      read GetResponseClass         write SetResponseClass      ;
    property ProtocolState           :string      read GetProtocolState         write SetProtocolState      ;
    property IsFinalised             :Boolean     read GetIsFinalised           write SetIsFinalised        ;
  end;


implementation






      {Tukgovgatewaytest}

Constructor Tukgovgatewaytest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ukgovgatewaytest';
  fSQL := 'SELECT * FROM tblukgovgatewaytest';
end;


Destructor Tukgovgatewaytest.Destroy;
begin
  inherited;
end;


Procedure Tukgovgatewaytest.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GenericKeyID');
  SetPropertyFromNode(node,'DeclarationType');
  SetPropertyFromNode(node,'CurrentResponseType');
  SetPropertyFromNode(node,'CorrelationID');
  SetPropertyFromNode(node,'NoOfAttempts');
  SetPropertyFromNode(node,'LastMessageRecieved');
  SetPropertyFromNode(node,'CurrentSentType');
  SetPropertyFromNode(node,'ErrorNumber');
  SetPropertyFromNode(node,'ErrorType');
  SetPropertyFromNode(node,'LastMessageSent');
  SetPropertyFromNode(node,'ErrorMessage');
  SetPropertyFromNode(node,'ResponseEndPoint');
  SetPropertyFromNode(node,'PollInterval');
  SetPropertyFromNode(node,'ResponseClass');
  SetPropertyFromNode(node,'ProtocolState');
  SetPropertyFromNode(node,'IsFinalised');
end;


Procedure Tukgovgatewaytest.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GenericKeyID' ,GenericKeyID);
  AddXMLNode(node,'DeclarationType' ,DeclarationType);
  AddXMLNode(node,'CurrentResponseType' ,CurrentResponseType);
  AddXMLNode(node,'CorrelationID' ,CorrelationID);
  AddXMLNode(node,'NoOfAttempts' ,NoOfAttempts);
  AddXMLNode(node,'LastMessageRecieved' ,LastMessageRecieved);
  AddXMLNode(node,'CurrentSentType' ,CurrentSentType);
  AddXMLNode(node,'ErrorNumber' ,ErrorNumber);
  AddXMLNode(node,'ErrorType' ,ErrorType);
  AddXMLNode(node,'LastMessageSent' ,LastMessageSent);
  AddXMLNode(node,'ErrorMessage' ,ErrorMessage);
  AddXMLNode(node,'ResponseEndPoint' ,ResponseEndPoint);
  AddXMLNode(node,'PollInterval' ,PollInterval);
  AddXMLNode(node,'ResponseClass' ,ResponseClass);
  AddXMLNode(node,'ProtocolState' ,ProtocolState);
  AddXMLNode(node,'IsFinalised' ,IsFinalised);
end;


Function Tukgovgatewaytest.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if GenericKeyID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'GenericKeyID should not be 0' , False );
    Exit;
  end;
  if NoOfAttempts = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'NoOfAttempts should not be 0' , False );
    Exit;
  end;
  if LastMessageRecieved = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'LastMessageRecieved should not be blank' , False );
    Exit;
  end;
  if LastMessageSent = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'LastMessageSent should not be blank' , False );
    Exit;
  end;
  if PollInterval = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PollInterval should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


Function Tukgovgatewaytest.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tukgovgatewaytest.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tukgovgatewaytest.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tukgovgatewaytest.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tukgovgatewaytest.GetIDField: string;
begin
  Result := 'DeclarationID'
end;


Class Function Tukgovgatewaytest.GetBusObjectTablename: string;
begin
  Result:= 'tblukgovgatewaytest';
end;


Function Tukgovgatewaytest.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tukgovgatewaytest.GetGenericKeyID       : Integer   ; begin Result := GetIntegerField('GenericKeyID');end;
Function  Tukgovgatewaytest.GetDeclarationType    : string    ; begin Result := GetStringField('DeclarationType');end;
Function  Tukgovgatewaytest.GetCurrentResponseType: string    ; begin Result := GetStringField('CurrentResponseType');end;
Function  Tukgovgatewaytest.GetCorrelationID      : string    ; begin Result := GetStringField('CorrelationID');end;
Function  Tukgovgatewaytest.GetNoOfAttempts       : Integer   ; begin Result := GetIntegerField('NoOfAttempts');end;
Function  Tukgovgatewaytest.GetLastMessageRecieved: TDateTime ; begin Result := GetDateTimeField('LastMessageRecieved');end;
Function  Tukgovgatewaytest.GetCurrentSentType    : string    ; begin Result := GetStringField('CurrentSentType');end;
Function  Tukgovgatewaytest.GetErrorNumber        : string    ; begin Result := GetStringField('ErrorNumber');end;
Function  Tukgovgatewaytest.GetErrorType          : string    ; begin Result := GetStringField('ErrorType');end;
Function  Tukgovgatewaytest.GetLastMessageSent    : TDateTime ; begin Result := GetDateTimeField('LastMessageSent');end;
Function  Tukgovgatewaytest.GetErrorMessage       : string    ; begin Result := GetStringField('ErrorMessage');end;
Function  Tukgovgatewaytest.GetResponseEndPoint   : string    ; begin Result := GetStringField('ResponseEndPoint');end;
Function  Tukgovgatewaytest.GetPollInterval       : Integer   ; begin Result := GetIntegerField('PollInterval');end;
Function  Tukgovgatewaytest.GetResponseClass      : string    ; begin Result := GetStringField('ResponseClass');end;
Function  Tukgovgatewaytest.GetProtocolState      : string    ; begin Result := GetStringField('ProtocolState');end;
Function  Tukgovgatewaytest.GetIsFinalised        : Boolean   ; begin Result := GetBooleanField('IsFinalised');end;
Procedure Tukgovgatewaytest.SetGenericKeyID       (const Value: Integer   ); begin SetIntegerField('GenericKeyID'        , Value);end;
Procedure Tukgovgatewaytest.SetDeclarationType    (const Value: string    ); begin SetStringField('DeclarationType'     , Value);end;
Procedure Tukgovgatewaytest.SetCurrentResponseType(const Value: string    ); begin SetStringField('CurrentResponseType'     , Value);end;
Procedure Tukgovgatewaytest.SetCorrelationID      (const Value: string    ); begin SetStringField('CorrelationID'       , Value);end;
Procedure Tukgovgatewaytest.SetNoOfAttempts       (const Value: Integer   ); begin SetIntegerField('NoOfAttempts'        , Value);end;
Procedure Tukgovgatewaytest.SetLastMessageRecieved(const Value: TDateTime ); begin SetDateTimeField('NoOfAttempts'        , Value);end;
Procedure Tukgovgatewaytest.SetCurrentSentType    (const Value: string    ); begin SetStringField('CurrentSentType'     , Value);end;
Procedure Tukgovgatewaytest.SetErrorNumber        (const Value: string    ); begin SetStringField('ErrorNumber'         , Value);end;
Procedure Tukgovgatewaytest.SetErrorType          (const Value: string    ); begin SetStringField('ErrorType'           , Value);end;
Procedure Tukgovgatewaytest.SetLastMessageSent    (const Value: TDateTime ); begin SetDateTimeField('LastMessageSent'     , Value);end;
Procedure Tukgovgatewaytest.SetErrorMessage       (const Value: string    ); begin SetStringField('ErrorMessage'        , Value);end;
Procedure Tukgovgatewaytest.SetResponseEndPoint   (const Value: string    ); begin SetStringField('ResponseEndPoint'    , Value);end;
Procedure Tukgovgatewaytest.SetPollInterval       (const Value: Integer   ); begin SetIntegerField('PollInterval'        , Value);end;
Procedure Tukgovgatewaytest.SetResponseClass      (const Value: string    ); begin SetStringField('ResponseClass'       , Value);end;
Procedure Tukgovgatewaytest.SetProtocolState      (const Value: string    ); begin SetStringField('ProtocolState'       , Value);end;
Procedure Tukgovgatewaytest.SetIsFinalised        (const Value: Boolean   ); begin SetBooleanField('IsFinalised'         , Value);end;


initialization
  RegisterClass(Tukgovgatewaytest);


end.
