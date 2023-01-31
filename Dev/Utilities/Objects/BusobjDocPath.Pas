unit BusobjDocPath;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/04/15  1.00.00  A.  Initial Version.
  }


interface


uses  BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TDocPath = class(TMSBusObj)
  private
    function GetDocumentPath        : string    ;
    function GetHelp                : Boolean   ;
    function GetPosPath             : string    ;
    procedure SetDocumentPath        (const Value: string    );
    procedure SetHelp                (const Value: Boolean   );
    procedure SetPosPath             (const Value: string    );
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
    property DocumentPath         :string      read GetDocumentPath       write SetDocumentPath    ;
    property Help                 :Boolean     read GetHelp               write SetHelp            ;
    property PosPath              :string      read GetPosPath            write SetPosPath         ;
  end;


implementation


uses tcDataUtils, CommonLib;


  {TDocPath}

constructor TDocPath.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'DocPath';
  fSQL := 'SELECT * FROM tbldocpath';
end;


destructor TDocPath.Destroy;
begin
  inherited;
end;


procedure TDocPath.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DocumentPath');
  SetBooleanPropertyFromNode(node,'Help');
  SetPropertyFromNode(node,'PosPath');
end;


procedure TDocPath.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DocumentPath' ,DocumentPath);
  AddXMLNode(node,'Help' ,Help);
  AddXMLNode(node,'PosPath' ,PosPath);
end;


function TDocPath.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TDocPath.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TDocPath.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TDocPath.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TDocPath.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TDocPath.GetIDField: string;
begin
  Result := 'DPID'
end;


class function TDocPath.GetBusObjectTablename: string;
begin
  Result:= 'tbldocpath';
end;


function TDocPath.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TDocPath.GetDocumentPath    : string    ; begin Result := GetStringField('DocumentPath');end;
function  TDocPath.GetHelp            : Boolean   ; begin Result := GetBooleanField('Help');end;
function  TDocPath.GetPosPath         : string    ; begin Result := GetStringField('PosPath');end;
procedure TDocPath.SetDocumentPath    (const Value: string    ); begin SetStringField('DocumentPath'     , Value);end;
procedure TDocPath.SetHelp            (const Value: Boolean   ); begin SetBooleanField('Help'             , Value);end;
procedure TDocPath.SetPosPath         (const Value: string    ); begin SetStringField('PosPath'          , Value);end;


initialization
  RegisterClass(TDocPath);


end.
