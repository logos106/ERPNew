unit busobjareacodes;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/07/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TAreaCode = class(TMSBusObj)
  private
    function getAreaCode            : string    ;
    function GetAreaName            : string    ;
    function GetDescription         : string    ;
    function GetActive              : Boolean   ;
    procedure SetAreaCode            (const Value: string    );
    procedure SetAreaName            (const Value: string    );
    procedure SetDescription         (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
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
    class function MakeNewArea(const Value :String; fconnection :TMyDacDataConnection= nil):Integer;
  published
    property Areacode             :string      read getAreaCode           write SetAreaCode        ;
    property AreaName             :string      read GetAreaName           write SetAreaName        ;
    property Description          :string      read GetDescription        write SetDescription     ;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils;



  {TAreaCode}

constructor TAreaCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'AreaCode';
  fSQL := 'SELECT * FROM tblareacodes';
end;


destructor TAreaCode.Destroy;
begin
  inherited;
end;


procedure TAreaCode.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Areacode');
  SetPropertyFromNode(node,'AreaName');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node,'Active');
end;


class function TAreaCode.MakeNewArea(const Value: String; fconnection :TMyDacDataConnection= nil): Integer;
var
  AreaCode :TAreaCode;
begin
  REsult := 0;
  if  fconnection = nil then AreaCode := TAreaCode.createwithnewconn(nil)
  else begin
    AreaCode := TAreaCode.create(nil);
    Areacode.Connection := fconnection;
  end;
  try
    Areacode.Loadselect('Areacode = ' +Quotedstr(Value));
    if Areacode.count >0 then begin
      REsult := Areacode.Id;
      Exit;
    end;
    Areacode.Connection.BeginTransaction;
    Areacode.Connection.BeginNestedTransaction;
    try
      Areacode.New;
      Areacode.AreaCode := Value;
      Areacode.PostDB;
      Areacode.Connection.commitnestedTransaction;
      Result := Areacode.Id;
    Except
      on E:Exception do begin
        Areacode.Connection.rollbacknestedTransaction;
      end;
    end;
  finally
    Freeandnil(Areacode);
  end;

end;

procedure TAreaCode.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Areacode' ,Areacode);
  AddXMLNode(node,'AreaName' ,AreaName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Active' ,Active);
end;


function TAreaCode.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if not IsUnique(ID,'areacode = ' + QuotedStr(areacode),Connection.connection) then begin
    ResultStatus.AddItem(False, rssWarning, 0, Quotedstr(Areacode)+' already exists');
    Exit;
  end;
  Result := True;
end;


function TAreaCode.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  PostDb;
  Result := inherited Save;
end;


procedure TAreaCode.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TAreaCode.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TAreaCode.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TAreaCode.GetIDField: string;
begin
  Result := 'ID'
end;


class function TAreaCode.GetBusObjectTablename: string;
begin
  Result:= 'tblareacodes';
end;


function TAreaCode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TAreaCode.getAreaCode        : string    ; begin Result := GetStringField('Areacode');end;
function  TAreaCode.GetAreaName        : string    ; begin Result := GetStringField('AreaName');end;
function  TAreaCode.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  TAreaCode.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TAreaCode.SetAreaCode        (const Value: string    ); begin SetStringField('Areacode'         , Value);end;
procedure TAreaCode.SetAreaName        (const Value: string    ); begin SetStringField('AreaName'         , Value);end;
procedure TAreaCode.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;
procedure TAreaCode.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


initialization
  RegisterClass(TAreaCode);


end.
