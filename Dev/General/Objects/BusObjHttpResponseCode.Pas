unit BusObjHttpResponseCode;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/12/18  1.00.00  A.  Initial Version.
  }


interface


uses MyAccess ,  BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  THttpResponseCodes = class(TMSBusObj)
  private
    function GetCode           : string    ;
    function GetName           : string    ;
    function GetDescription    : string    ;
    procedure SetCode           (const Value: string    );
    procedure SetName           (const Value: string    );
    procedure SetDescription    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    class function GetKeyStringField: string; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class function HttpResponse(const HttpRescode: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): String;
  published
    property Code            :string      read GetCode          write SetCode       ;
    property Name            :string      read GetName          write SetName       ;
    property Description     :string      read GetDescription   write SetDescription;
  end;


implementation


uses sysutils,ERPdbComponents, tcDataUtils, CommonLib, DbSharedObjectsObj, CommonDbLib,
  tcConst;



  {THttpResponseCodes}

constructor THttpResponseCodes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'HttpResponseCodes';
  fSQL := 'SELECT * FROM tblhttpresponsecodes';
end;


destructor THttpResponseCodes.Destroy;
begin
  inherited;
end;


procedure THttpResponseCodes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Code');
  SetPropertyFromNode(node,'Name');
  SetPropertyFromNode(node,'Description');
end;


procedure THttpResponseCodes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Code' ,Code);
  AddXMLNode(node,'Name' ,Name);
  AddXMLNode(node,'Description' ,Description);
end;


function THttpResponseCodes.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function THttpResponseCodes.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure THttpResponseCodes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure THttpResponseCodes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function THttpResponseCodes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function THttpResponseCodes.HttpResponse(const HttpRescode: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    commondblib.closedb(qry);
    if Assigned(Connection) then
      qry.Connection := Connection
    else
      qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    qry.SQL.text := 'Select * from tblHttpResponseCodes where Code =' + quotedstr(HttpRescode);
    commondblib.opendb(qry);
    result := qry.fieldbyname('Name').asString+NL+
              qry.fieldbyname('Description').asString;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function THttpResponseCodes.GetIDField: string;
begin
  Result := 'ID'
end;


class function THttpResponseCodes.GetKeyStringField: string;
begin
  REsult := 'Code'
end;

class function THttpResponseCodes.GetBusObjectTablename: string;
begin
  Result:= 'tblhttpresponsecodes';
end;


function THttpResponseCodes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  THttpResponseCodes.GetCode       : string    ; begin Result := GetStringField('Code');end;
function  THttpResponseCodes.GetName       : string    ; begin Result := GetStringField('Name');end;
function  THttpResponseCodes.GetDescription: string    ; begin Result := GetStringField('Description');end;
procedure THttpResponseCodes.SetCode       (const Value: string    ); begin SetStringField('Code'        , Value);end;
procedure THttpResponseCodes.SetName       (const Value: string    ); begin SetStringField('Name'        , Value);end;
procedure THttpResponseCodes.SetDescription(const Value: string    ); begin SetStringField('Description' , Value);end;


initialization
  RegisterClass(THttpResponseCodes);


end.
