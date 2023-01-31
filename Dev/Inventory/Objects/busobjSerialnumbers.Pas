unit busobjSerialnumbers;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/06/09  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSerialJobNumbers = class(TMSBusObj)
  private
    function GetSerialNo       : string    ;
    function GetProductID      : Integer   ;
    function GetProductname    : string    ;
    procedure SetSerialNo       (const Value: string    );
    procedure SetProductID      (const Value: Integer   );
    procedure SetProductname    (const Value: string    );
    function getDeptID: Integer;
    procedure setDeptID(const Value: Integer);
    function getDeptname: String;
    procedure setDeptName(const Value: String);
    function getActive: Boolean;
    procedure setActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeEdit(Sender:TDatasetBusObj): Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function Lock :Boolean ; override;
    class function _Schema: string; override;
  published
    property SerialNo       :string      read GetSerialNo    write SetSerialNo   ;
    property ProductId      :Integer     read GetProductID   write SetProductID  ;
    property ProductName    :string      read GetProductname write SetProductname;
    Property DeptID         :Integer     Read getDeptID      Write setDeptID;
    Property DeptName       :String      Read getDeptname    Write setDeptName;
    Property Active         :Boolean     Read getActive      Write setActive;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, AppEnvironment,
  DefaultClassObj, BusObjSchemaLib, BusObjStock;



  {TSerialJobNumbers}

constructor TSerialJobNumbers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SerialNumbers';
  fSQL := 'SELECT * FROM tblserialnumbers';
end;


destructor TSerialJobNumbers.Destroy;
begin
  inherited;
end;


procedure TSerialJobNumbers.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SerialNo');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'Productname');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSerialJobNumbers.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SerialNo' ,SerialNo);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'Productname' ,Productname);
  AddXMLNode(node,'Active' ,Active);

end;


function TSerialJobNumbers.ValidateData: Boolean ;
begin
  result := False;
  Resultstatus.Clear;
  if Serialno = '' then begin
      Resultstatus.AddItem(False, rssWarning , 0 , 'Serial Number should not be blank', False);
      Exit;
  end;
  if DeptID<> 0 then
    if Deptname = '' then
      DeptName := tcdatautils.GetClassName(DeptID);

  if (DeptId =0) or (DeptName = '') then begin
    DeptID := Appenv.DefaultClass.ClassID;
    DeptName :=Appenv.DefaultClass.DefaultClassName;
  end;

  if (DeptId =0) or (DeptName = '') then begin
      Resultstatus.AddItem(False, rssWarning , 0 , appenv.DefaultClass.ClassHeading +' should not be blank');
      Exit;
  end;
  Result := True;
end;


class function TSerialJobNumbers._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductId','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptId','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptName','DeptClassName');
end;

function TSerialJobNumbers.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSerialJobNumbers.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSerialJobNumbers.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.Fieldname , 'ProductID') then begin
        ProductName := tcDatautils.GetProduct(ProductID);
    end else if Sysutils.SameText(Sender.Fieldname , 'Productname') then begin
        ProductId := (*tcDatautils.GetProduct(ProductName)*)TProduct.IDToggle(ProductName);
    end else if Sysutils.SameText(Sender.Fieldname , 'classId') then begin
        DeptName := GetClassName(DeptID);
    end else if Sysutils.SameText(Sender.Fieldname , 'classNAME') then begin
        DeptID := tcdatautils.GetDeptID(DeptName);
    end;
end;


function TSerialJobNumbers.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSerialJobNumbers.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSerialJobNumbers.GetKeyStringField: string;
begin
  result := 'SerialNo';
end;

class function TSerialJobNumbers.GetKeyStringProperty: string;
begin
  result := 'SerialNo';
end;

class function TSerialJobNumbers.GetBusObjectTablename: string;
begin
  Result:= 'tblserialnumbers';
end;


function TSerialJobNumbers.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if not ValidateData then begin
    delete;
  end;
end;


{Property Functions}
function  TSerialJobNumbers.GetSerialNo    : string    ; begin Result := GetStringField('SerialNo');end;
function  TSerialJobNumbers.GetProductID   : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TSerialJobNumbers.GetProductname : string    ; begin Result := GetStringField('Productname');end;
function  TSerialJobNumbers.getDeptID      : Integer   ; begin Result := GetIntegerfield('ClassId'); end;
function  TSerialJobNumbers.getDeptname    : String    ; begin REsult := getStringfield('Classname');end;
function  TSerialJobNumbers.getActive      : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSerialJobNumbers.setActive     (const Value: Boolean   ); begin SetBooleanField('Active' , Value);end;
procedure TSerialJobNumbers.SetSerialNo   (const Value: string    ); begin SetStringField('SerialNo'    , Value);end;
procedure TSerialJobNumbers.SetProductID  (const Value: Integer   ); begin SetIntegerField('ProductId'   , Value);end;
procedure TSerialJobNumbers.SetProductname(const Value: string    ); begin SetStringField('Productname'   , Value);end;
procedure TSerialJobNumbers.setDeptID     (const Value: Integer   ); begin SetIntegerField('ClasSId', Value ); end;
procedure TSerialJobNumbers.setDeptName   (const Value: String    ); begin SetStringField('Classname' , Value);end;

function TSerialJobNumbers.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeEdit(Sender);
  if not result then exit;
  result := Lock;
  if not result then begin
    Abort;
    Exit;
  end;
end;

function TSerialJobNumbers.Lock: Boolean;
begin
  Result := inherited Lock(self.LockGroupName);
  if not Result then exit;

  if ProductID = 0 then exit;
  with getNewdataset('select  PQADetailID ' +
            ' from tblPQA PQA  ' +
            ' inner join tblPQAdetails PQAD on PQA.PQAID = PQAD.PQAID   ' +
            ' where PQA.ProductID =' + IntToStr(ProductID) +
            '  and PQAD.Value='+quotedStr(SerialNo), true) do try
    Result := recordcount =0;
  finally
    if active then close;
    Free;
  end;
end;

function TSerialJobNumbers.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  DeptID := Appenv.DefaultClass.ClassID;
  DeptName :=Appenv.DefaultClass.DefaultClassName;
end;

function TSerialJobNumbers.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;


initialization
  RegisterClass(TSerialJobNumbers);


end.
