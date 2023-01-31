unit busobjdirty;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  12/02/09  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TDirty = class(TMSBusObj)
  private
    function GetauditID         : Integer   ;
    function GetsiteCode        : string    ;
    function GetSynchronised    : Boolean   ;
    function GetconflictMsg     : string    ;
    procedure SetauditID         (const Value: Integer   );
    procedure SetsiteCode        (const Value: string    );
    procedure SetSynchronised    (const Value: Boolean   );
    procedure SetconflictMsg     (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property auditID          :Integer     read GetauditID        write SetauditID     ;
    property siteCode         :string      read GetsiteCode       write SetsiteCode    ;
    property Synchronised     :Boolean     read GetSynchronised   write SetSynchronised;
    property conflictMsg      :string      read GetconflictMsg    write SetconflictMsg ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TDirty}

constructor TDirty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Dirty';
  fSQL := 'SELECT * FROM tbldirty';
end;


destructor TDirty.Destroy;
begin
  inherited;
end;


procedure TDirty.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'auditID');
  SetPropertyFromNode(node,'siteCode');
  SetBooleanPropertyFromNode(node,'Synchronised');
  SetPropertyFromNode(node,'conflictMsg');
end;


procedure TDirty.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'auditID' ,auditID);
  AddXMLNode(node,'siteCode' ,siteCode);
  AddXMLNode(node,'Synchronised' ,Synchronised);
  AddXMLNode(node,'conflictMsg' ,conflictMsg);
end;


function TDirty.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TDirty.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TDirty.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TDirty.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TDirty.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TDirty.GetIDField: string;
begin
  Result := 'ID'
end;


class function TDirty.GetBusObjectTablename: string;
begin
  Result:= 'tbldirty';
end;


function TDirty.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TDirty.GetauditID     : Integer   ; begin Result := GetIntegerField('auditID');end;
function  TDirty.GetsiteCode    : string    ; begin Result := GetStringField('siteCode');end;
function  TDirty.GetSynchronised: Boolean   ; begin Result := GetBooleanField('Synchronised');end;
function  TDirty.GetconflictMsg : string    ; begin Result := GetStringField('conflictMsg');end;
procedure TDirty.SetauditID     (const Value: Integer   ); begin SetIntegerField('auditID'      , Value);end;
procedure TDirty.SetsiteCode    (const Value: string    ); begin SetStringField('siteCode'     , Value);end;
procedure TDirty.SetSynchronised(const Value: Boolean   ); begin SetBooleanField('siteCode'     , Value);end;
procedure TDirty.SetconflictMsg (const Value: string    ); begin SetStringField('siteCode'     , Value);end;


initialization
  RegisterClass(TDirty);


end.
