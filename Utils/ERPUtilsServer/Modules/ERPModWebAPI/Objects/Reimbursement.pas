unit Reimbursement;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Treimbursement = class(TMSBusObj)
  private
    function GetReimbursementName       : string    ;
    function GetReimbursementAccount    : string    ;
    function GetReimbursementActive     : Boolean   ;
    procedure SetReimbursementName       (const Value: string    );
    procedure SetReimbursementAccount    (const Value: string    );
    procedure SetReimbursementActive     (const Value: Boolean   );
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
    property ReimbursementName        :string      read GetReimbursementName      write SetReimbursementName   ;
    property ReimbursementAccount     :string      read GetReimbursementAccount   write SetReimbursementAccount;
    property ReimbursementActive      :Boolean     read GetReimbursementActive    write SetReimbursementActive ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Treimbursement}

constructor Treimbursement.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'reimbursement';
  fSQL := 'SELECT * FROM tblreimbursement';
end;


destructor Treimbursement.Destroy;
begin
  inherited;
end;


procedure Treimbursement.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ReimbursementName');
  SetPropertyFromNode(node,'ReimbursementAccount');
  SetBooleanPropertyFromNode(node,'ReimbursementActive');
end;


procedure Treimbursement.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ReimbursementName' ,ReimbursementName);
  AddXMLNode(node,'ReimbursementAccount' ,ReimbursementAccount);
  AddXMLNode(node,'ReimbursementActive' ,ReimbursementActive);
end;


function Treimbursement.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Treimbursement.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Treimbursement.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Treimbursement.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Treimbursement.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Treimbursement.GetIDField: string;
begin
  Result := 'ID'
end;


class function Treimbursement.GetBusObjectTablename: string;
begin
  Result:= 'tblreimbursement';
end;


function Treimbursement.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Treimbursement.GetReimbursementName   : string    ; begin Result := GetStringField('ReimbursementName');end;
function  Treimbursement.GetReimbursementAccount: string    ; begin Result := GetStringField('ReimbursementAccount');end;
function  Treimbursement.GetReimbursementActive : Boolean   ; begin Result := GetBooleanField('ReimbursementActive');end;
procedure Treimbursement.SetReimbursementName   (const Value: string    ); begin SetStringField('ReimbursementName'    , Value);end;
procedure Treimbursement.SetReimbursementAccount(const Value: string    ); begin SetStringField('ReimbursementAccount' , Value);end;
procedure Treimbursement.SetReimbursementActive (const Value: Boolean   ); begin SetBooleanField('ReimbursementActive' , Value);end;


initialization
  RegisterClass(Treimbursement);


end.
