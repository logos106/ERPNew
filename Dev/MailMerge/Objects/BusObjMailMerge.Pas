unit BusObjMailMerge;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/04/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tmailmerge = class(TMSBusObj)
  private    
    Function GetRecipientID     : Integer   ;
    Function GetDateSent        : TDateTime ;
    Function GetDocumentName    : string    ;
    Function GetGroup           : string    ;
    Function GetSuccess         : Boolean   ;
    Procedure SetRecipientID     (const Value: Integer   );
    Procedure SetDateSent        (const Value: TDateTime );
    Procedure SetDocumentName    (const Value: string    );
    Procedure SetGroup           (const Value: string    );
    Procedure SetSuccess         (const Value: Boolean   );
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
    property RecipientID      :Integer     read GetRecipientID    write SetRecipientID ;
    property DateSent         :TDateTime   read GetDateSent       write SetDateSent    ;
    property DocumentName     :string      read GetDocumentName   write SetDocumentName;
    property Group            :string      read GetGroup          write SetGroup;
    property Success          :Boolean     read GetSuccess        write SetSuccess     ;
  end;


implementation


uses CommonLib;



      {Tmailmerge}

Constructor Tmailmerge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'mailmerge';
  fSQL := 'SELECT * FROM tblmailmerge';
end;


Destructor Tmailmerge.Destroy;
begin
  inherited;
end;


Procedure Tmailmerge.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;           
  SetPropertyFromNode(node,'RecipientID');
  SetPropertyFromNode(node,'DateSent');
  SetPropertyFromNode(node,'DocumentName');
  SetPropertyFromNode(node,'Success');
  SetPropertyFromNode(node,'Group');
end;


Procedure Tmailmerge.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;  
  AddXMLNode(node,'RecipientID' ,RecipientID);
  AddXMLNode(node,'DateSent' ,DateSent);
  AddXMLNode(node,'DocumentName' ,DocumentName);
  AddXMLNode(node,'Success' ,Success);
  AddXMLNode(node,'Group' ,Group);
end;


Function Tmailmerge.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  
  if RecipientID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'RecipientID should not be 0' , False );
    Exit;
  end;
  if DateSent = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DateSent should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


Function Tmailmerge.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tmailmerge.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tmailmerge.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tmailmerge.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tmailmerge.GetIDField: string;
begin
  Result := 'MailMergeID';
end;


Class Function Tmailmerge.GetBusObjectTablename: string;
begin
  Result:= 'tblmailmerge';
end;


Function Tmailmerge.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tmailmerge.GetRecipientID : Integer   ; begin Result := GetIntegerField('RecipientID');end;
Function  Tmailmerge.GetDateSent    : TDateTime ; begin Result := GetDateTimeField('DateSent');end;
Function  Tmailmerge.GetDocumentName: string    ; begin Result := GetStringField('DocumentName');end;
Function  Tmailmerge.GetGroup       : string    ; begin Result := GetStringField('MMGroup');end;
Function  Tmailmerge.GetSuccess     : Boolean   ; begin Result := GetBooleanField('Success');end;  
Procedure Tmailmerge.SetRecipientID (const Value: Integer   ); begin SetIntegerField('RecipientID' , Value);end;
Procedure Tmailmerge.SetDateSent    (const Value: TDateTime ); begin SetDateTimeField('DateSent'     , Value);end;
Procedure Tmailmerge.SetDocumentName(const Value: string    ); begin SetStringField('DocumentName'     , Value);end;
Procedure Tmailmerge.SetGroup       (const Value: string    ); begin SetStringField('MMGroup'     , Value);end;
Procedure Tmailmerge.SetSuccess     (const Value: Boolean   ); begin SetBooleanField('Success'      , Value);end;


initialization
  RegisterClassOnce(Tmailmerge);


end.
