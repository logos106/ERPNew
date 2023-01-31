unit BusobjPayCommon;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/04/22  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSuperType = class(TMSBusObj)
  private
    function GetDescription                                : string    ;
    function GetEntitlementCode                            : string    ;
    function GetIncludeInEmployeereportableContribution    : Boolean   ;
    procedure SetDescription                                (const Value: string    );
    procedure SetEntitlementCode                            (const Value: string    );
    procedure SetIncludeInEmployeereportableContribution    (const Value: Boolean   );
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
    property Description                                 :string      read GetDescription                               write SetDescription                            ;
    property EntitlementCode                             :string      read GetEntitlementCode                           write SetEntitlementCode                        ;
    property IncludeInEmployeereportableContribution     :Boolean     read GetIncludeInEmployeereportableContribution   write SetIncludeInEmployeereportableContribution;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TSuperType}

constructor TSuperType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'supertype';
  fSQL := 'SELECT * FROM tblsupertype';
end;


destructor TSuperType.Destroy;
begin
  inherited;
end;


procedure TSuperType.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'EntitlementCode');
  SetBooleanPropertyFromNode(node,'IncludeInEmployeereportableContribution');
end;


procedure TSuperType.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'EntitlementCode' ,EntitlementCode);
  AddXMLNode(node,'IncludeInEmployeereportableContribution' ,IncludeInEmployeereportableContribution);
end;


function TSuperType.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSuperType.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSuperType.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSuperType.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSuperType.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSuperType.GetIDField: string;
begin
  Result := 'SuperTypeID'
end;


class function TSuperType.GetBusObjectTablename: string;
begin
  Result:= 'tblsupertype';
end;


function TSuperType.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSuperType.GetDescription                            : string    ; begin Result := GetStringField('Description');end;
function  TSuperType.GetEntitlementCode                        : string    ; begin Result := GetStringField('EntitlementCode');end;
function  TSuperType.GetIncludeInEmployeereportableContribution: Boolean   ; begin Result := GetBooleanField('IncludeInEmployeereportableContribution');end;
procedure TSuperType.SetDescription                            (const Value: string    ); begin SetStringField('Description'                             , Value);end;
procedure TSuperType.SetEntitlementCode                        (const Value: string    ); begin SetStringField('EntitlementCode'                         , Value);end;
procedure TSuperType.SetIncludeInEmployeereportableContribution(const Value: Boolean   ); begin SetBooleanField('IncludeInEmployeereportableContribution' , Value);end;


initialization
  RegisterClass(TSuperType);


end.
