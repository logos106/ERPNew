unit busobjobjectproperties;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/10/13  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TObjectProperties = class(TMSBusObj)
  private
    function GetObjClassname        : string    ;
    function GetPropertyName        : string    ;
    function GetPropertyUserName    : string    ;
    function GetRequired            : Boolean   ;
    procedure SetObjClassname        (const Value: string    );
    procedure SetPropertyName        (const Value: string    );
    procedure SetPropertyUserName    (const Value: string    );
    procedure SetRequired            (const Value: Boolean   );
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
    property ObjClassname         :string      read GetObjClassname       write SetObjClassname    ;
    property PropertyName         :string      read GetPropertyName       write SetPropertyName    ;
    property PropertyUserName     :string      read GetPropertyUserName   write SetPropertyUserName;
    property Required             :Boolean     read GetRequired           write SetRequired        ;
  end;


implementation


uses tcDataUtils, CommonLib , Sysutils;



  {TObjectProperties}

constructor TObjectProperties.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ObjectProperties';
  fSQL := 'SELECT * FROM tblobjectproperties';
end;


destructor TObjectProperties.Destroy;
begin
  inherited;
end;


procedure TObjectProperties.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ObjClassname');
  SetPropertyFromNode(node,'PropertyName');
  SetPropertyFromNode(node,'PropertyUserName');
  SetBooleanPropertyFromNode(node,'Required');
end;


procedure TObjectProperties.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ObjClassname' ,ObjClassname);
  AddXMLNode(node,'PropertyName' ,PropertyName);
  AddXMLNode(node,'PropertyUserName' ,PropertyUserName);
  AddXMLNode(node,'Required' ,Required);
end;


function TObjectProperties.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TObjectProperties.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TObjectProperties.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TObjectProperties.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'PropertyUserName') then begin
    if PropertyUserName = '' then
      PropertyUserName := sender.OldValue;
  end;
end;


function TObjectProperties.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TObjectProperties.GetIDField: string;
begin
  Result := 'ID'
end;


class function TObjectProperties.GetBusObjectTablename: string;
begin
  Result:= 'tblobjectproperties';
end;


function TObjectProperties.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TObjectProperties.GetObjClassname    : string    ; begin Result := GetStringField('ObjClassname');end;
function  TObjectProperties.GetPropertyName    : string    ; begin Result := GetStringField('PropertyName');end;
function  TObjectProperties.GetPropertyUserName: string    ; begin Result := GetStringField('PropertyUserName');end;
function  TObjectProperties.GetRequired        : Boolean   ; begin Result := GetBooleanField('Required');end;
procedure TObjectProperties.SetObjClassname    (const Value: string    ); begin SetStringField('ObjClassname'     , Value);end;
procedure TObjectProperties.SetPropertyName    (const Value: string    ); begin SetStringField('PropertyName'     , Value);end;
procedure TObjectProperties.SetPropertyUserName(const Value: string    ); begin SetStringField('PropertyUserName' , Value);end;
procedure TObjectProperties.SetRequired        (const Value: Boolean   ); begin SetBooleanField('Required'        , Value);end;


initialization
  RegisterClass(TObjectProperties);


end.
