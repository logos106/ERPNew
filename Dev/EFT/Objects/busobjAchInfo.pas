unit busobjAchInfo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/07/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TACHInfo = class(TMSBusObj)
  private
    function GetImmediateOriginNumber    : string    ;
    function GetImmediateDestination_name: string    ;
    function GetImmediateOriginName      : string    ;
    function GetTaxID                    : string    ;
    function GetImmediateDestination_ID  :Integer;
    function GetRecordsExported  :Integer;
    procedure SetImmediateOriginNumber    (const Value: string    );
    procedure SetImmediateDestination_name(const Value: string    );
    procedure SetImmediateOriginName      (const Value: string    );
    procedure SetTaxID                    (const Value: string    );
    Procedure SetImmediateDestination_ID   (Const Value:Integer);
    Procedure SetRecordsExported   (Const Value:Integer);
    function getImmediateDestinationBSB: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
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
    Property ImmediateDestinationBSB :String read getImmediateDestinationBSB;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property ImmediateOriginNumber     :string      read GetImmediateOriginNumber   write SetImmediateOriginNumber;
    property ImmediateDestination_name :string      read GetImmediateDestination_name write SetImmediateDestination_name;
    property ImmediateOriginName       :string      read GetImmediateOriginName     write SetImmediateOriginName  ;
    property TaxID                     :string      read GetTaxID                   write SetTaxID                ;
    Property ImmediateDestination_ID   :Integer read getImmediateDestination_ID     write setImmediateDestination_ID;
    Property RecordsExported   :Integer read getRecordsExported     write setRecordsExported;
  end;


implementation


uses Sysutils, tcDataUtils, CommonLib, BusObjGLAccount;



  {TACHInfo}

constructor TACHInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'achInfo';
  fSQL := 'SELECT * FROM tblachInfo';
end;


destructor TACHInfo.Destroy;
begin
  inherited;
end;


procedure TACHInfo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ImmediateOriginNumber');
  SetPropertyFromNode(node,'ImmediateDestination_name');
  SetPropertyFromNode(node,'ImmediateOriginName');
  SetPropertyFromNode(node,'TaxID');
end;


procedure TACHInfo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ImmediateOriginNumber' ,ImmediateOriginNumber);
  AddXMLNode(node,'ImmediateDestination_name' ,ImmediateDestination_name);
  AddXMLNode(node,'ImmediateOriginName' ,ImmediateOriginName);
  AddXMLNode(node,'TaxID' ,TaxID);
end;


function TACHInfo.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TACHInfo.Save: Boolean ;
begin
  PostDB;
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TACHInfo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TACHInfo.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit;

  inherited;
  if Sysutils.SameText(Sender.FieldName , 'ImmediateDestination_Accountname')  then begin
    ImmediateDestination_ID := TAccount.idToggle(ImmediateDestination_name);
  end else if Sysutils.SameText(Sender.FieldName , 'ImmediateDestination_AccountID')  then begin
    ImmediateDestination_Name := TAccount.idToggle(ImmediateDestination_ID);
  end;

end;


function TACHInfo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TACHInfo.GetIDField: string;
begin
  Result := 'ID'
end;


function TACHInfo.getImmediateDestinationBSB: String;
begin
  REsult:= '';
  if ImmediateDestination_ID =0 then exit;
  With TAccount.Create(Self) do try
    connection := Self.Connection;
    Load(ImmediateDestination_ID);
    REsult:= BSB;
  finally
    Free;
  end;
end;

class function TACHInfo.GetBusObjectTablename: string;
begin
  Result:= 'tblachInfo';
end;


function TACHInfo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TACHInfo.GetImmediateOriginNumber: string    ; begin Result := GetStringField('ImmediateOriginNumber');end;
function  TACHInfo.GetImmediateDestination_name: string    ; begin Result := GetStringField('ImmediateDestination_Accountname');end;
function  TACHInfo.GetImmediateOriginName  : string    ; begin Result := GetStringField('ImmediateOriginName');end;
function  TACHInfo.GetTaxID                : string    ; begin Result := GetStringField('TaxID');end;
Function TACHInfo.GetImmediateDestination_ID:Integer; begin REsult:= GetIntegerField('ImmediateDestination_AccountID');end;
Function TACHInfo.GetRecordsExported:Integer; begin REsult:= GetIntegerField('RecordsExported');end;
procedure TACHInfo.SetImmediateOriginNumber(const Value: string    ); begin SetStringField('ImmediateOriginNumber' , Value);end;
procedure TACHInfo.SetImmediateDestination_name(const Value: string    ); begin SetStringField('ImmediateDestination_Accountname' , Value);end;
procedure TACHInfo.SetImmediateOriginName  (const Value: string    ); begin SetStringField('ImmediateOriginName'   , Value);end;
procedure TACHInfo.SetTaxID                (const Value: string    ); begin SetStringField('TaxID'                 , Value);end;
Procedure TACHInfo.SetRecordsExported(const Value :Integer); begin setIntegerField('RecordsExported',Value);end;
Procedure TACHInfo.SetImmediateDestination_ID(const Value :Integer); begin setIntegerField('ImmediateDestination_AccountID',Value);end;


initialization
  RegisterClass(TACHInfo);


end.
