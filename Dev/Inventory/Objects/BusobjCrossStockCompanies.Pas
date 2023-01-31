unit BusobjCrossStockCompanies;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/10/16  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TCrossStockCompanies = class(TMSBusObj)
  private
    function GetDBName             : string    ;
    function GetLogon_Name         : string    ;
    function GetCheckOrder         : Integer   ;
    function GetActive             : Boolean   ;
    procedure SetDBName             (const Value: string    );
    procedure SetLogon_Name         (const Value: string    );
    procedure SetCheckOrder         (const Value: Integer   );
    procedure SetActive             (const Value: Boolean   );
    function NextNum: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property DBName              :string      read GetDBName            write SetDBName         ;
    property Logon_Name          :string      read GetLogon_Name        write SetLogon_Name     ;
    property CheckOrder          :Integer     read GetCheckOrder        write SetCheckOrder     ;
    property Active              :Boolean     read GetActive            write SetActive         ;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib, DbSharedObjectsObj, CommonDbLib;



  {TCrossStockCompanies}

constructor TCrossStockCompanies.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'crossstockcompanies';
  fSQL := 'SELECT * FROM tblcrossstockcompanies';
  fSQLOrder:= 'CheckOrder';
end;


destructor TCrossStockCompanies.Destroy;
begin
  inherited;
end;


procedure TCrossStockCompanies.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DBName');
  SetPropertyFromNode(node,'Logon_Name');
  SetPropertyFromNode(node,'CheckOrder');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TCrossStockCompanies.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DBName' ,DBName);
  AddXMLNode(node,'Logon_Name' ,Logon_Name);
  AddXMLNode(node,'CheckOrder' ,CheckOrder);
  AddXMLNode(node,'Active' ,Active);
end;


function TCrossStockCompanies.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CheckOrder = 0 then begin
    AddResult(False , rssWarning , 0,  'CheckOrder should not be 0' , true);
    Exit;
  end;
  if dbname= '' then begin
    AddResult(False , rssWarning , 0,  'Company should not be Blank' ,true );
    Exit;
  end;
  if Logon_Name= '' then begin
    AddResult(False , rssWarning , 0,  'User should not be Blank' , true );
    Exit;
  end;
  Result := True;
end;


function TCrossStockCompanies.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCrossStockCompanies.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCrossStockCompanies.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCrossStockCompanies.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCrossStockCompanies.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCrossStockCompanies.GetBusObjectTablename: string;
begin
  Result:= 'tblcrossstockcompanies';
end;


function TCrossStockCompanies.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  CheckOrder := NextNum;
end;
Function TCrossStockCompanies.NextNum:Integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    Qry.SQL.text := 'Select max(CheckOrder) as Num from ' + GetBusObjectTablename;
    Commondblib.Opendb(Qry);
    Result := Qry.FieldByname('Num').asInteger+1;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TCrossStockCompanies.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCrossStockCompanies.GetDBName         : string    ; begin Result := GetStringField('DBName');end;
function  TCrossStockCompanies.GetLogon_Name     : string    ; begin Result := GetStringField('Logon_Name');end;
function  TCrossStockCompanies.GetCheckOrder     : Integer   ; begin Result := GetIntegerField('CheckOrder');end;
function  TCrossStockCompanies.GetActive         : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TCrossStockCompanies.SetDBName         (const Value: string    ); begin SetStringField('DBName'          , Value);end;
procedure TCrossStockCompanies.SetLogon_Name     (const Value: string    ); begin SetStringField('Logon_Name'      , Value);end;
procedure TCrossStockCompanies.SetCheckOrder     (const Value: Integer   ); begin SetIntegerField('CheckOrder'      , Value);end;
procedure TCrossStockCompanies.SetActive         (const Value: Boolean   ); begin SetBooleanField('Active'          , Value);end;


initialization
  RegisterClass(TCrossStockCompanies);


end.
