unit BusObjUKGovGateway;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/02/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, BusObjVATReturns,SHDocVw,ExtCtrls, XMLDoc, XMLIntf;


type
  Tukgovgateway = class(TMSBusObj)
  private
    fVatReturn                         : Tvatreturns;
    fXML                               : string;
   
    Function GetDeclarationID          : Integer   ;
    Function GetDeclarationType        : string    ;
    Function GetCurrentResponseType    : string    ;
    Function GetCorrelationID          : string    ;  
    Function GetNoOfAttempts           : Integer   ;
    Function GetLastMessageRecieved    : TDateTime ;
    Function GetCurrentSentType        : string    ;
    Function GetLastMessageSent        : TDateTime ;
    Function GetErrorMessage           : string    ;
    Function GetErrorType              : string    ;
    Function GetErrorNumber            : string    ;
    Function GetGenericKeyID           : integer  ;
    Function GetResponseEndPoint       : string    ;
    Function GetResponseClass          : string    ;
    Function GetPollInterval           : Integer   ;
    Function GetProtocolState          : string    ;
    Function GetIsFinalised            :Boolean   ;
    Procedure SetDeclarationID          (const Value: Integer   );
    Procedure SetDeclarationType        (const Value: string    );
    Procedure SetCurrentResponseType    (const Value: string    );
    Procedure SetCorrelationID          (const Value: string    );   
    Procedure SetNoOfAttempts           (const Value: Integer   );
    Procedure SetLastMessageRecieved    (const Value: TDateTime );
    Procedure SetCurrentSentType        (const Value: string    );
    Procedure SetLastMessageSent        (const Value: TDateTime );
    Procedure SetErrorMessage           (const Value: string    );
    Procedure SetErrorType              (const Value: string    );
    Procedure SetErrorNumber            (const Value: string    );
    Procedure SetGenericKeyID           (const Value: Integer   );
    Procedure SetResponseEndPoint       (const Value: string    );
    Procedure SetResponseClass          (const Value: string    );
    Procedure SetPollInterval           (const Value: Integer   );
    Procedure SetProtocolState          (const Value: string    );
    Procedure SetIsFinalised            (Const Value :Boolean  ); 
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
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;

  Published
    property DeclarationID           :Integer     read GetDeclarationID         write SetDeclarationID      ;
    property DeclarationType         :string      read GetDeclarationType       write SetDeclarationType    ;
    property CurrentResponseType     :string      read GetCurrentResponseType   write SetCurrentResponseType ;
    property CorrelationID           :string      read GetCorrelationID         write SetCorrelationID      ;
    property NoOfAttempts            :Integer     read GetNoOfAttempts          write SetNoOfAttempts       ;
    property LastMessageRecieved     :TDateTime   read GetLastMessageRecieved   write SetLastMessageRecieved;
    property CurrentSentType         :string      read GetCurrentSentType       write SetCurrentSentType    ;
    property LastMessageSent         :TDateTime   read GetLastMessageSent       write SetLastMessageSent    ;
    property ErrorMessage            :string      read GetErrorMessage          write SetErrorMessage       ;
    property ErrorType               :string      read GetErrorType             write SetErrorType       ;
    property ErrorNumber             :string      read GetErrorNumber           write SetErrorNumber       ;
    property GenericKeyID            :integer     read GetGenericKeyID          write SetGenericKeyID       ;
    property ResponseEndPoint        :string      read GetResponseEndPoint      write SetResponseEndPoint   ;
    property ResponseClass           :string      read GetResponseClass         write SetResponseClass   ;
    property PollInterval            :integer     read GetPollInterval          write SetPollInterval       ;
    property ProtocolState           :string      read GetProtocolState         write SetProtocolState   ;
    Property IsFinalised             :Boolean      Read GetIsFinalised          Write SetIsFinalised            ;
    property DeclarationXML          :string      read fXML;
  end;


implementation


uses CommonLib,SysUtils,OleCtrls,mshtml,Controls,Dialogs,ActiveX,
  IdHTTP,IdIOHandlerSocket,IdIOHandler,IdSSLOpenSSL;

{Tukgovgateway}



Constructor Tukgovgateway.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ukgovgateway';
  fSQL := 'SELECT * FROM tblukgovgateway';
  fVatReturn  := Tvatreturns.Create(Self);
end;


Destructor Tukgovgateway.Destroy;
begin
  inherited;
end;

procedure   Tukgovgateway.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited Load(aid,fIsReadonly);
  fVATReturn.Load(Self.GenericKeyID , fIsReadonly);
end;

Procedure Tukgovgateway.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DeclarationID');
  SetPropertyFromNode(node,'DeclarationType');
  SetPropertyFromNode(node,'CurrentResponseType');
  SetPropertyFromNode(node,'CorrelationID'); 
  SetPropertyFromNode(node,'NoOfAttempts');
  SetPropertyFromNode(node,'LastMessageRecieved');
  SetPropertyFromNode(node,'CurrentSentType');
  SetPropertyFromNode(node,'LastMessageSent');
  SetPropertyFromNode(node,'ErrorMessage');
  SetPropertyFromNode(node,'ErrorType');
  SetPropertyFromNode(node,'ErrorNumber');
  SetPropertyFromNode(node,'GenericKeyID');
  SetPropertyFromNode(node,'ResponseEndPoint');
  SetPropertyFromNode(node,'ResponseClass');
  SetPropertyFromNode(node,'PollInterval');
  SetPropertyFromNode(node,'ProtocolState');
  SetPropertyFromNode(node,'IsFinalised');
end;


Procedure Tukgovgateway.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DeclarationID' ,DeclarationID);
  AddXMLNode(node,'DeclarationType' ,DeclarationType);
  AddXMLNode(node,'CurrentResponseType' ,CurrentResponseType);
  AddXMLNode(node,'CorrelationID' ,CorrelationID);    
  AddXMLNode(node,'NoOfAttempts' ,NoOfAttempts);
  AddXMLNode(node,'LastMessageRecieved' ,LastMessageRecieved);
  AddXMLNode(node,'CurrentSentType' ,CurrentSentType);
  AddXMLNode(node,'LastMessageSent' ,LastMessageSent);
  AddXMLNode(node,'ErrorMessage' ,ErrorMessage);
  AddXMLNode(node,'ErrorType' ,ErrorType);
  AddXMLNode(node,'ErrorNumber' ,ErrorNumber);
  AddXMLNode(node,'GenericKeyID' ,GenericKeyID);
  AddXMLNode(node,'ResponsEndPoint' ,ResponseEndPoint);
  AddXMLNode(node,'ResponsEndPoint' ,ResponseClass);
  AddXMLNode(node,'PollInterval' ,PollInterval);
  AddXMLNode(node,'ProtocolState' ,ProtocolState);
  AddXMLNode(node,'IsFinalised' ,IsFinalised);
end;


Function Tukgovgateway.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DeclarationID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DeclarationID should not be 0' , False );
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
  Result := True;
end;


Function Tukgovgateway.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tukgovgateway.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tukgovgateway.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tukgovgateway.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Class Function Tukgovgateway.GetIDField: string;
begin
  Result := ''
end;

Class Function Tukgovgateway.GetBusObjectTablename: string;
begin
  Result:= 'tblukgovgateway';
end;

Function Tukgovgateway.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
Function  Tukgovgateway.GetDeclarationID      : Integer   ; begin Result := GetIntegerField('DeclarationID');end;
Function  Tukgovgateway.GetDeclarationType    : string    ; begin Result := GetStringField('DeclarationType');end;
Function  Tukgovgateway.GetCurrentResponseType : string    ; begin Result := GetStringField('CurrentResponseType');end;
Function  Tukgovgateway.GetCorrelationID      : string    ; begin Result := GetStringField('CorrelationID');end;
Function  Tukgovgateway.GetNoOfAttempts       : Integer   ; begin Result := GetIntegerField('NoOfAttempts');end;
Function  Tukgovgateway.GetLastMessageRecieved: TDateTime ; begin Result := GetDateTimeField('LastMessageRecieved');end;
Function  Tukgovgateway.GetCurrentSentType    : string    ; begin Result := GetStringField('CurrentSentType');end;
Function  Tukgovgateway.GetLastMessageSent    : TDateTime ; begin Result := GetDateTimeField('LastMessageSent');end;
Function  Tukgovgateway.GetErrorMessage       : string    ; begin Result := GetStringField('ErrorMessage');end;
Function  Tukgovgateway.GetErrorType          : string    ; begin Result := GetStringField('ErrorType');end;
Function  Tukgovgateway.GetErrorNumber        : string    ; begin Result := GetStringField('ErrorNumber');end;

Function  Tukgovgateway.GetGenericKeyID       : Integer   ; begin Result := GetIntegerField('GenericKeyID');end;
Function  Tukgovgateway.GetResponseEndPoint   : string    ; begin Result := GetStringField('ResponseEndPoint');end;
Function  Tukgovgateway.GetResponseClass      : string    ; begin Result := GetStringField('ResponseClass');end;
Function  Tukgovgateway.GetPollInterval       : Integer   ; begin Result := GetIntegerField('PollInterval');end;
Function  Tukgovgateway.GetProtocolState      : string    ; begin Result := GetStringField('ProtocolState');end;
Function  Tukgovgateway.GetIsFinalised        :Boolean   ; begin Result := GetBooleanField('IsFinalised');End;

Procedure Tukgovgateway.SetDeclarationID      (const Value: Integer   ); begin SetIntegerField('DeclarationID'       , Value);end;
Procedure Tukgovgateway.SetDeclarationType    (const Value: string    ); begin SetStringField('DeclarationType'     , Value);end;
Procedure Tukgovgateway.SetCurrentResponseType (const Value: string    ); begin SetStringField('CurrentResponseType'     , Value);end;
Procedure Tukgovgateway.SetCorrelationID      (const Value: string    ); begin SetStringField('CorrelationID'       , Value);end;
Procedure Tukgovgateway.SetNoOfAttempts       (const Value: Integer   ); begin SetIntegerField('NoOfAttempts'        , Value);end;
Procedure Tukgovgateway.SetLastMessageRecieved(const Value: TDateTime ); begin SetDateTimeField('LastMessageRecieved'        , Value);end;
Procedure Tukgovgateway.SetCurrentSentType     (const Value: string    ); begin SetStringField('CurrentSentType'        , Value);end;
Procedure Tukgovgateway.SetLastMessageSent    (const Value: TDateTime ); begin SetDateTimeField('LastMessageSent'     , Value);end;

Procedure Tukgovgateway.SetErrorType          (const Value: string    ); begin SetStringField('ErrorType'         , Value);end;
Procedure Tukgovgateway.SetErrorNumber        (const Value: string    ); begin SetStringField('ErrorNumber'         , Value);end;
Procedure Tukgovgateway.SetErrorMessage       (const Value: string    ); begin SetStringField('ErrorMessage'         , Value);end;
Procedure Tukgovgateway.SetGenericKeyID       (const Value: Integer   ); begin SetIntegerField('GenericKeyID'       , Value);end;
Procedure Tukgovgateway.SetResponseEndPoint   (const Value: string    ); begin SetStringField('ResponseEndPoint'    , Value);end;
Procedure Tukgovgateway.SetResponseClass      (const Value: string    ); begin SetStringField('ResponseClass'    , Value);end;
Procedure Tukgovgateway.SetPollInterval       (const Value: Integer   ); begin SetIntegerField('PollInterval'        , Value);end;
Procedure Tukgovgateway.SetProtocolState      (const Value: string    ); begin SetStringField('ProtocolState'    , Value);end;
Procedure Tukgovgateway.SetIsFinalised        (Const Value :Boolean   ); begin SetBooleanField('IsFinalised'     , Value);End;

initialization
  RegisterClassOnce(Tukgovgateway);


end.


