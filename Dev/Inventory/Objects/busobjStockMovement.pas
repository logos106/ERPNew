unit busobjStockMovement;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/05/08  1.00.01  bS  Initial Version.
  }


interface


Uses  TypesLib, BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjPQA, BusObjGLAccount, BusObjEmployeeDetails;


type

  TGeneralIntStringProc = Procedure (const intValue:Integer; const StrValue:String) of Object;

  { Include in Site Intergration }
  TStockMovementLines = class(TProdQty)
  private
    function GetStockMovementID         : Integer;
    function GetMovementDate        : TDateTime;
    function GetDescription           : string;
    function GetDeptName              : string;
    function GetAccountID             : Integer;
    function GetAccountName           : string;
    function GetCost                  : Double;
    function GetAssetAccountID        : integer;
    function GetValue                 : Double;
    function GetAvailable             : Double;
    function GetSerials       : string;
    function GetDeleted               : Boolean;
    procedure SetStockMovementID         (const Value: Integer   );
    procedure SetMovementDate        (const Value: TDateTime );
    procedure SetDescription           (const Value: string    );
    procedure SetDeptID                (const Value: Integer   );
    procedure SetDeptName              (const Value: string    );
    procedure SetAccountID             (const Value: Integer   );
    procedure SetAccountName           (const Value: string    );
    procedure SetCost                  (const Value: Double    );
    procedure SetAssetAccountID        (const Value: Integer);
    procedure SetValue                 (const Value: Double    );
    procedure SetAvailable             (const Value: Double    );
    procedure SetDeleted               (const Value: Boolean   );
    procedure SetSerials       (const Value: string    );
    function getHEaderAccountID: Integer;
    Function  UpdateAccounts:Boolean;
    function getAccount: TAccount;
    function getHeaderDeleted: Boolean;
    function GetAssetAccountName: string;
    procedure SetAssetAccountName(const Value: string);
    function GetSMELineGlobalref: string;
    procedure SetSMELineGlobalref(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL: string;                                           override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;             override;
    function  DoAfterOpen(Sender: TDatasetBusObj): Boolean;             override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;           override;
    function GetUOMMultiplier         : Double;override;
    function GetClassID              : Integer;override;
    function GetProductID             : Integer;override;
    function GetProductName           : string;override;
    function GetQty                   : Double;override;
    function GetUOMQty                : Double;override;
    function GetUnitOfMeasure         : string;override;
    function GetUnitOfMeasureID       : Integer;override;
    function GetSerialnos             : String;override;
    Function GetAllocType             : String;override;
    Function GetActive                : Boolean;override;
    Function GetTransDate             : TDatetime; override;
    Function GetBOQty                 : Double;    override;
    Function GetBOUOMQty              : Double;    override;
    function GetCleanClassID          : Integer;   override;
    function GetcleanProductId        : Integer;   override;
    procedure SetUOMMultiplier         (const Value: Double    );override;
    procedure SetUnitOfMeasure         (const Value: string    );override;
    procedure SetUnitOfMeasureID       (const Value: Integer   );override;
    procedure SetSerialNos             (const Value: String    );override;
    procedure SetTransDate             (const Value: TDatetime); override;
    procedure SetUOMQty                (const Value: Double    );override;
    procedure SetQty                   (const Value: Double    );override;
    procedure SetProductID             (const Value: Integer   );override;
    procedure SetProductName           (const Value: string    );override;
    procedure SetActive                (const Value: Boolean   );Override;
    procedure SetBOQty                 (const Value: Double    );Override;
    procedure SetBOUOMQty              (const Value: Double    );Override;
    function GetProductType: string;override;
    procedure SetProductType(const Value: string);override;
    function GetOrderQty         :Double;    Override;
    function GetUOMOrderQty      :Double;    Override;
    procedure SetOrderQty(const Value: Double);Override;
    procedure SetUOMOrderQty(const Value: Double);Override;
    procedure SetMatrixRef(const Value: String);Override;
    function GetMatrixRef: String;Override;
    function GetMatrixDesc: String;Override;
    function GetMatrixPrice:Double;Override;
    procedure SetMatrixDesc(const Value: String);Override;
    procedure SetMatrixPrice(const Value: Double);Override;
    function QtyValid: Boolean;Override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);            override;
    procedure        SaveToXMLNode(const node: IXMLNode);              override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    function         DeleteStockMovementLines:Boolean;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    Property HEaderAccountID :Integer read getHEaderAccountID;
    Property Account        :TAccount Read getAccount;
    Property HeaderDeleted  :Boolean    REad getHeaderDeleted;
    property StockMovementID    :Integer   Read GetStockMovementID     Write SetStockMovementID;
    class function _Schema: string; override;
    function ISStockAdjustment:Boolean;
    Function ISStockTransfer:Boolean;
    procedure DoOnProductchange;
  published
    property MovementDate     :TDateTime Read GetMovementDate    Write SetMovementDate;
    property Description      :string    Read GetDescription       Write SetDescription;
    property DeptID           :Integer   Read GetClassID           Write SetDeptID;
    property DeptName         :string    Read GetDeptName          Write SetDeptName;
    property AccountID        :Integer   Read GetAccountID         Write SetAccountID;
    property AccountName      :string    Read GetAccountName       Write SetAccountName;
    property Cost             :Double    Read GetCost              Write SetCost;
    property AssetAccountID   :integer   Read GetAssetAccountID    Write SetAssetAccountID;
    property AssetAccountName: string read GetAssetAccountName write SetAssetAccountName;
    property SMELineGlobalref: string read GetSMELineGlobalref write SetSMELineGlobalref;
    property Value            :Double    Read GetValue             Write SetValue;
    property Available        :Double    Read GetAvailable         Write SetAvailable;
    property Serials  :string    Read GetSerials   Write SetSerials;
    property Deleted          :Boolean   Read GetDeleted           Write SetDeleted;
    property UOMID            :Integer   Read GetUnitOfMeasureID   Write SetUnitOfMeasureID;
  end;

  { Include in Site Intergration }
  TStockMovement = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    //fshowProgressbar: TGeneralIntStringProc;
    //fHideProgressbar: TGeneralProc;
    //fincProgressbar: TGeneralProc;
    //fincProgressbarS: TGeneralStringProc;
    fShowStatus: TGeneralStringProc;
    function GetMovementDate         : TDateTime;
    function GetCreationDate         : TDateTime;
    function GetAccountID            : Integer;
    function GetNotes                : string;
    function GetEmployeeName         : string;
    function GetSMEGlobalref         : string;
    function GetSMEType              : string;
    function GetDeleted              : Boolean;
    function getEmployeeID           : Integer;
    procedure SetMovementDate         (const Value: TDateTime );
    procedure SetCreationDate         (const Value: TDateTime );
    procedure SetAccountID            (const Value: Integer   );
    procedure SetNotes                (const Value: string    );
    procedure SetEmployeeName         (const Value: string    );
    procedure SetSMEGlobalref         (const Value: string    );
    procedure SetSMEType              (const Value: string    );
    procedure SetDeleted              (const Value: Boolean   );
    procedure SetEmployeeID           (const Value: Integer);
    function  GetLines: TStockMovementLines;
    Procedure CallbackSave(Const Sender: TBusObj; var Abort: boolean);
    Procedure CallbackDelete(Const Sender: TBusObj; var Abort: boolean);
    Procedure CallbackValidateData(Const Sender: TBusObj; var Abort: boolean);
    function getemployee: TEmployeeDetails;
    function GetAccountName: string;
    procedure SetAccountName(const Value: string);
    function GetStockAdjustEntryGlobalRef: string;
    function GetTStockTransferEntryGlobalRef: string;
    procedure SetStockAdjustEntryGlobalRef(const Value: string);
    procedure SetTStockTransferEntryGlobalRef(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);            override;
    procedure        SaveToXMLNode(const node: IXMLNode);              override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    function         DeleteStockMovement:Boolean;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    class function   TransactionID(MovementID:Integer):Integer;
    class function   TransactionType(MovementID:Integer):String;
    Property  Employee :TEmployeeDetails read getemployee;
    Property ShowStatus  : TGeneralStringProc REad fShowStatus  write fShowStatus;
    class function _Schema: string; override;
  published
    property CreationDate          :TDateTime   read GetCreationDate        write SetCreationDate;
    property MovementDate        :TDateTime     read GetMovementDate        write SetMovementDate;
    property AccountID             :Integer     read GetAccountID           write SetAccountID;
    property AccountName: string read GetAccountName write SetAccountName;
    property Notes                 :string      read GetNotes               write SetNotes;
    property EmployeeName          :string      read GetEmployeeName        write SetEmployeeName;
    Property EmployeeID            :Integer     REad getEmployeeID          Write SetEmployeeID;
    property SMEGlobalref          :string      read GetSMEGlobalref        write SetSMEGlobalref;
    property SMEType               :string      read GetSMEType             write SetSMEType;
    property StockAdjustEntryGlobalRef: string read GetStockAdjustEntryGlobalRef write SetStockAdjustEntryGlobalRef;
    property TStockTransferEntryGlobalRef: string read GetTStockTransferEntryGlobalRef write SetTStockTransferEntryGlobalRef;
    property Deleted               :Boolean     read GetDeleted             write SetDeleted;
    Property Lines: TStockMovementLines read GetLines;
  end;


implementation


uses CommonLib, tcConst,
  BusObjStock, AppEnvironment, sysutils , CommonDbLib,
  busobjstockTransferentry, BusobjStockAdjustEntry, BusObjEmployee,
  BusObjSchemaLib, BusObjClass, LogLib, tcDataUtils;



{ TStockMovement }

constructor TStockMovement.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StockMovement';
  fSQL := 'SELECT * FROM tblStockMovement';
  //fshowProgressbar:=nil;
  //fHideProgressbar:=nil;
  //fincProgressbar :=nil;
  //fincProgressbarS :=nil;
  ExportExcludeList.Add('smeglobalref');
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('employeeid');
end;

destructor TStockMovement.Destroy;
begin
  inherited;
end;


procedure TStockMovement.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: integer;
begin
  inherited;
  SetDatetimePropertyFromNode(node,'CreationDate');
  SetDatetimePropertyFromNode(node,'MovementDate');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'SMEGlobalref');
  SetPropertyFromNode(node,'SMEType');
  SetBooleanPropertyFromNode(node,'Deleted');
  PostDB;
{ delete existing lines if they exist }
  while Lines.Count > 0 do Lines.Delete;
  LinesNode := node.ChildNodes.FindNode(lowercase(Lines.XMLBranchName));
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.Count - 1 do begin

      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      Lines.Postdb;
    end;
  end;
end;


procedure TStockMovement.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'MovementDate' ,MovementDate);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'SMEGlobalref' ,SMEGlobalref);
  AddXMLNode(node,'SMEType' ,SMEType);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function TStockMovement.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  result := False;
  if SMEType = '' then begin
    AddResult(false, rssWarning, 0,'Stock Movement Entry Type (SMEType) is blank.');
    exit;
  end;
  if not (SameText(SMEType,StockAdjustEntryType) or SameText(SMEType,StockTransferEntrytype) or SameText(SMEType,StSStockMovementType) )  then begin
    AddResult(false, rssWarning, 0,'Invalid Stock Movement Entry Type (SMEType): "' + SMEType + '"');
    exit;
  end;
  if CreationDate = 0 then begin
    AddResult(false, rssWarning, 0,'Creation Date is blank.');
    exit;
  end;
  if MovementDate = 0 then begin
    AddResult(false, rssWarning, 0,'Movement Date is blank.');
    exit;
  end;
  if EmployeeID = 0 then begin
    AddResult(false, rssWarning, 0,'Employee is blank.');
    exit;
  end;
  AllLinesValid:= True;
  try
      //if assigned(fshowProgressbar) then ShowProgressbar(Lines.count, 'Validating Stock movement');
      ShowProgressbar(Lines.count);
      try
        Lines.Iteraterecords(CallbackValidateData);
      finally
        hideProgressbar;
      end;
  except
    on E:Exception do begin
      if devmode then
        stepProgressbar(MemoryStatusDetails +'-' + E.Message );
      AllLinesValid := False;
    end;
  end;
  if not AllLinesValid then begin
    Exit;
  end;
  Result := True;
end;

class function TStockMovement._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TStockAdjustEntry','StockAdjustEntryObj','StockAdjustEntryGlobalRef','GlobalRef');
  TBOSchema.AddRefType(result,'TStockTransferEntry','StockTransferEntryObj','TStockTransferEntryGlobalRef','GlobalRef');
end;

procedure TStockMovement.CallbackDelete(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (Sender is TStockMovementLines) then exit;
  if not TStockMovementLines(Sender).DeleteStockMovementLines then begin
      Abort := True;
      AllLinesValid:= False;
  end;
end;

procedure TStockMovement.CallbackSave(const Sender: TBusObj;
  var Abort: boolean);
begin
  stepProgressbar;
    if not (Sender is TStockMovementLines) then exit;
        if not TStockMovementLines(Sender).Save then begin
        Abort := True;
        AllLinesValid:= False;
    end;
end;
function TStockMovement.DeleteStockMovement: Boolean;
  Var
  StrSQL:String;
begin
  if count = 0 then begin
    result := true;
    exit;
  end;
  Deleted := True;
  PostDB;
  Lines.IterateREcords(CallbackDelete); // flag lines as deleted and update accounts
  strSQL:= 'Delete '+
              ' tblPQAdetails.* , '+
              ' tblPQa.*, '+
              ' tblStockMovementLines.* '+
              ' from tblStockMovement '+
              ' left join tblStockMovementLines on tblStockMovement.StockMovementID = tblStockMovementLines.StockMovementID '+
              ' left join tblPQa on tblPQA.TranslineId = tblStockMovementLines.StockMovementLinesID and  tblPQA.TransType =  '+ QuotedStr(TStockMovementLines.classname)+
              ' left join tblPQAdetails on tblPQAdetails.PQAID = tblPQA.PQAID '+
              ' where tblStockMovementLines.StockMovementID = ' +IntToStr(ID);
  getnewdataset(strSQL, true);
  result := true;
end;

function TStockMovement.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;

  PostDB;
  Lines.PostDB;
  AllLinesValid:= true;
  ShowProgressbar(Lines.count);
  try
    try
      Lines.IterateRecords(CallbackSave);
    finally
      hideProgressbar;
    end;
  except
    on E:Exception do begin
      if devmode then
        stepProgressbar(MemoryStatusDetails +'-' +E.Message);
        AllLinesValid := False;
    end;
  end;

  if not AllLinesValid then begin
      result := False;
      Exit;
  end;
  Result := inherited Save;
  if not result then exit;
  showProgressbar(1);
  try
  if not PostList.Execute then begin
    Result := False;
    Exit;
  end;
  finally
    hideProgressbar;
  end;
end;


procedure TStockMovement.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TStockMovement.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName , 'employeeID') then begin
    if EmployeeID > 0 then
      EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection)
    else
      EmployeeName := '';
  end
  else if Sysutils.SameText(Sender.fieldName , 'Employee') then begin
    if EmployeeName <>'' then
      EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection)
    else
      EmployeeID := 0;
  end;
end;


function TStockMovement.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TStockMovement.GetStockAdjustEntryGlobalRef: string;
begin
  if SameText(SMEType, StockAdjustEntryType) then
    result := SMEGlobalref
  else
    result := '';
end;

function TStockMovement.GetTStockTransferEntryGlobalRef: string;
begin
  if SameText(SMEType, StockTransferEntrytype) then
    result := SMEGlobalref
  else
    result := '';
end;

function TStockMovement.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

Class function TStockMovement.GetIDField: string;begin  Result := 'StockMovementID'end;
Class function TStockMovement.GetKeyStringField: string;begin  Result := ''end;
Class function TStockMovement.GetBusObjectTablename: string;begin  Result := 'tblStockMovement'end;
{Property functions}
function  TStockMovement.GetCreationDate    : TDateTime; begin Result := GetDateTimeField('CreationDate');end;
function  TStockMovement.GetMovementDate    : TDateTime; begin Result := GetDateTimeField('MovementDate');end;
function  TStockMovement.GetAccountID       : Integer;   begin Result := GetIntegerField('AccountID');end;
function TStockMovement.GetAccountName: string;
begin
  if AccountID > 0 then
    result := tcdatautils.GetAccountName(AccountID)//TAccount.IDToggle(AccountID, Connection.Connection)
  else
    result := '';
end;

function  TStockMovement.GetNotes           : string;    begin Result := GetStringField('Notes');end;
function  TStockMovement.GetEmployeeName    : string;    begin Result := GetStringField('Employee');end;
function  TStockMovement.GetSMEGlobalref    : string;    begin Result := GetStringField('StockMovementEntryglobalref');end;
function  TStockMovement.GetSMEType         : string;    begin Result := GetStringField('StockMovementEntrytype');end;
function  TStockMovement.GetDeleted         : Boolean;   begin Result := GetBooleanField('Deleted');end;
function  TStockMovement.getEmployeeID      : Integer;   begin Result := GetIntegerField('employeeID'); end;
procedure TStockMovement.SetCreationDate    (const Value: TDateTime ); begin SetDateTimeField('CreationDate'              , Value);end;
procedure TStockMovement.SetMovementDate    (const Value: TDateTime ); begin SetDateTimeField('MovementDate'              , Value);end;
procedure TStockMovement.SetAccountID       (const Value: Integer   ); begin SetIntegerField('AccountID'                  , Value);end;
procedure TStockMovement.SetAccountName(const Value: string);
begin
  if Value <> '' then
    AccountID := tcdatautils.AccountIDForName(Value)//TAccount.IDToggle(Value, Connection.Connection)
  else
    AccountID := 0;
end;

procedure TStockMovement.SetNotes           (const Value: string    ); begin SetStringField('Notes'                       , Value);end;
procedure TStockMovement.SetEmployeeName    (const Value: string    ); begin SetStringField('Employee'                    , Value);end;
procedure TStockMovement.SetSMEGlobalref    (const Value: string    ); begin SetStringField('StockMovementEntryglobalref' , Value);end;
procedure TStockMovement.SetSMEType         (const Value: string    ); begin SetStringField('StockMovementEntrytype'      , Value);end;
procedure TStockMovement.SetStockAdjustEntryGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    SMEGlobalref := Value;
    SMEType := StockAdjustEntryType ;
  end;
end;

procedure TStockMovement.SetTStockTransferEntryGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    SMEGlobalref := Value;
    SMEType := StockTransferEntrytype ;
  end;
end;

procedure TStockMovement.SetDeleted         (const Value: Boolean   ); begin SetBooleanField('Deleted'                    , Value);end;
procedure TStockMovement.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('employeeID'                 , Value); end;

function TStockMovement.GetLines: TStockMovementLines;
begin
  Result := TStockMovementLines(getContainerComponent(TStockMovementLines, 'StockMovementID = ' + IntToStr(Self.ID)));

end;



function TStockMovement.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  if Assigned(Self.Owner) then
    if Self.Owner is TBusobj then
      SMEType := TbusObj(Self.Owner).XMLNodeName;
  CreationDate := Now;
  MovementDate := Now;
  EmployeeID  := AppEnv.Employee.EmployeeID;

  if Assigned(Self.Owner) then
    if Self.Owner is TMSBusobj then
      SMEGlobalref := TMSBusobj(Self.Owner).globalref;
  Deleted := False;
end;




function TStockMovement.getemployee: TEmployeeDetails;
begin
    Result := TEmployeeDetails(getContainerComponent(TEmployeeDetails, 'EmployeeID = ' + IntToStr(Self.EmployeeID)));
end;

class function TStockMovement.TransactionID(MovementID: Integer): Integer;
var
  strSql:String;
begin
  result := 0;
  strSQL:= 'SELECT StockmovementEntryglobalref,StockmovementEntryType ' +
          ' from tblstockMovement where StockmovementId = ' +IntToStr(MovementID);
  with CommonDbLib.TempMyQuery do try
      SQL.add(strSQL);
      open;
      if Sysutils.SameText(fieldbyname('StockmovementEntryType').asString , TStockTransferEntry.XMLNodeName) then begin
        REsult := TStockTransferEntry.IDToggle(fieldbyname('StockmovementEntryglobalref').asString)
      end else if Sysutils.SameText(fieldbyname('StockmovementEntryType').asString , TStockAdjustEntry.XMLNodeName) then begin
        REsult := TStockAdjustEntry.IDToggle(fieldbyname('StockmovementEntryglobalref').asString);
      end;
  finally
      if Active then close;
      Free;
  end;
end;

class function TStockMovement.TransactionType(MovementID: Integer): String;
var
  strSql:String;
begin
  result := '';
  strSQL:= 'SELECT StockmovementEntryType ' +
          ' from tblstockMovement where StockmovementId = ' +IntToStr(MovementID);
  with CommonDbLib.TempMyQuery do try
      SQL.add(strSQL);
      open;
      if Sysutils.SameText(fieldbyname('StockmovementEntryType').asString , TStockTransferEntry.XMLNodeName) then
            REsult :=TStockTransferEntry.Transtype
      else if Sysutils.SameText(fieldbyname('StockmovementEntryType').asString , TStockAdjustEntry.XMLNodeName) then
            REsult :=   TStockAdjustEntry.Transtype
      else  result := fieldbyname('StockmovementEntryType').asString;
  finally
      if Active then close;
      Free;
  end;

end;

procedure TStockMovement.CallbackValidateData(const Sender: TBusObj;
  var Abort: boolean);
begin
  //if assigned(fincProgressbar) then incProgressbar;
  stepProgressbar;
    if not (sender is TStockMovementLines) then Exit;
    (*when used for stock transfer and stock adjustment , the validation is already done in the transfering object.
    the Qty doesn't need to match with the bin/batch allocation in these forms, so doens't need to validate stuff there*)
    if (SMEType = TStockTransferEntry.XMLNodeName) or (SMEType = TStockAdjustEntry.XMLNodeName) then exit;

    if not (TStockMovementLines(Sender).ISPQAitem) Then Exit;
    if not TStockMovementLines(Sender).PQA.ValidateAllocation then begin
      REsultStatus.AddItem(False, rssWarning, 0 , TStockMovementLines(Sender).PQA.Errmsg , true);
        AllLinesValid := False;
        Abort := True;
    end;

end;

{ TStockMovementLines }


constructor TStockMovementLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StockMovementLines';
  fSQL := 'SELECT * FROM tblStockMovementlines';
  fIsList:= true;
  ExportExcludeList.Add('uomid');
  ExportExcludeList.Add('accountid');
end;

Procedure TStockMovementLines.DoOnProductchange;
begin
      Cost := Product.AverageCost;
      if cost = 0 then Cost := Product.BuyQty1Cost;
      if UOMMultiplier =0 then UOMMultiplier:= 1;
      if Qty =0 then Qty := UOMQty*UOMMultiplier;
      Value := Qty*Cost;
end;

Class function TStockMovementLines.GetIDField: string;
begin
  Result := 'StockMovementLinesID'
end;


Class function TStockMovementLines.GetKeyStringField: string;
begin
  Result := ''
end;


Class function TStockMovementLines.GetBusObjectTablename: string;
begin
  Result := 'tblStockMovementlines'
end;


destructor TStockMovementLines.Destroy;
begin
  inherited;
end;


procedure TStockMovementLines.LoadFromXMLNode(const node: IXMLNode);
begin
  SetPropertyFromNode(node,'StockMovementID');
  SetDatetimePropertyFromNode(node,'MovementDate');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountName');
  if (AccountId = 0) and (HeaderAccountID<> 0 ) then AccountID := HeaderAccountID;
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'AssetAccountID');
  if AssetAccountID = 0 then AssetAccountID := tcdatautils.AccountIDForName(Product.AssetAccount );//TAccount.IDToggle(Product.AssetAccount , Self.Connection.connection);
  SetPropertyFromNode(node,'Value');
  SetPropertyFromNode(node,'Available');
  SetPropertyFromNode(node,'Serials');
  SetPropertyFromNode(node,'UnitOfMeasureID');
  SetPropertyFromNode(node,'UnitOfMeasure');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
  SetBooleanPropertyFromNode(node,'Deleted');
  PostDB;
  inherited;
end;


procedure TStockMovementLines.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'StockMovementID' ,StockMovementID);
  AddXMLNode(node,'MovementDate' ,MovementDate);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'AssetAccountID' ,AssetAccountID);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'Available' ,Available);
  AddXMLNode(node,'Serials' ,Serials);
  AddXMLNode(node,'UnitOfMeasureID' ,UnitOfMeasureID);
  AddXMLNode(node,'UnitOfMeasure' ,UnitOfMeasure);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function TStockMovementLines.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  result:= inherited;
  if not result then
    exit;
  result:= false;
  if AssetAccountID < 1 then
    AssetAccountID := tcdatautils.AccountIDForName(Product.AssetAccount );//TAccount.IDToggle(Product.AssetAccount , Self.Connection.connection);

  if AssetAccountID < 0 then begin
    AddResult(false, rssWarning,0, 'Asset Account not found.');
    exit;
  end;
  if AccountID < 1 then begin
    AddResult(false, rssWarning,0, 'Account ID is blank.');
    exit;
  end;
  if DeptID < 1 then begin
    AddResult(false, rssWarning,0, 'Department ID is blank.');
    exit;
  end;
  Result := True;
end;

class function TStockMovementLines._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TAccount','AssetAccountObj','AssetAccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AssetAccountObj','AssetAccountName','AccountName');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptName','DeptClassName');
end;

function TStockMovementLines.DeleteStockMovementLines: Boolean;
begin
  {as the header is deleted , updateaccounts will subtract the amount }
  UpdateAccounts;
  Deleted := True;
  PostDB;
  result := true;
end;

function TStockMovementLines.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  result := UpdateAccounts;
  if not result then Exit;
  Result := inherited Save;
end;


procedure TStockMovementLines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function TStockMovementLines.QtyValid: Boolean;
begin
  if ISStockAdjustment then result := True
  else result := inherited QtyValid;
end;

procedure TStockMovementLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldName , 'AccountID') then begin
    AccountName := tcdatautils.GetAccountName(AccountID);//TAccount.IDToggle(AccountID, Self.connection.connection);
  end else if SameText(Sender.fieldName , 'Accountname') then begin
    AccountName := tcdatautils.GetAccountName(AccountID);//TAccount.IDToggle(AccountID, Self.connection.connection);
  end else if SameText(Sender.fieldName , 'Cost') then begin
    if not RawMode then begin
      Value := Qty*cost;
    end;
  end else if SameText(Sender.fieldName , 'Qty') then begin
    if not RawMode then begin
      Value := Qty*cost;
    end;
  end else if SameText(Sender.fieldName , 'ProductID') then begin
    if not RawMode then begin
      ProductName := Product.Productname;
      Description := Product.SalesDescription;
      AssetAccountID := tcdatautils.AccountIDForName(Product.AssetAccount );//TAccount.IDToggle(Product.AssetAccount , Self.Connection.connection);
      ProductType          := Product.ProductType;
    end;
  end
  else if SameText(Sender.fieldName , 'ClassID') then begin
    if ClassID > 0 then
      DeptName :=  GetClassName(deptID)// TDeptClass.IDToggle(DeptID, Connection.Connection)
    else
      DeptName := '';
  end   else if SameText(Sender.fieldName , 'ClassName') then begin
    if DeptName <> '' then
      DeptID := tcdatautils.GetDeptID(DeptName)// TDeptClass.IDToggle(DeptName, Connection.Connection)
    else
      DeptID := 0;
  end;
end;


function TStockMovementLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TStockMovementLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TStockMovementLines.GetStockMovementID   : Integer;   begin Result := GetIntegerField('StockMovementID');end;
function  TStockMovementLines.GetMovementDate      : TDateTime; begin Result := GetDateTimeField('MovementDate');end;
function TStockMovementLines.GetOrderQty: Double;
begin
 result :=0;
end;

function  TStockMovementLines.GetProductID         : Integer;   begin Result := GetIntegerField('ProductID');end;
function  TStockMovementLines.GetProductName       : string;    begin Result := GetStringField('ProductName');end;
function  TStockMovementLines.GetDescription       : string;    begin Result := GetStringField('Description');end;
function  TStockMovementLines.GetClassID           : Integer;   begin Result := GetIntegerField('ClassID');end;
function  TStockMovementLines.GetDeptName          : string;    begin Result := GetStringField('ClassName');end;
function  TStockMovementLines.GetAccountID         : Integer;   begin Result := GetIntegerField('AccountID');end;
function  TStockMovementLines.GetAccountName       : string;    begin Result := GetStringField('AccountName');end;
function  TStockMovementLines.GetQty               : Double;    begin Result := GetFloatField('Qty');end;
function  TStockMovementLines.GetCost              : Double;    begin Result := GetFloatField('Cost');end;
function  TStockMovementLines.GetAssetAccountID    : Integer;   begin Result := GetIntegerField('AssetAccountID');end;
function TStockMovementLines.GetSMELineGlobalref: string;       begin Result := GetStringField('SMELineGlobalref');end;
function TStockMovementLines.GetAssetAccountName: string;
begin
  if AssetAccountID > 0 then
    result := tcdatautils.getAccountname(AssetAccountID)// TAccount.IDToggle(AssetAccountID, Connection.Connection)
  else
    result := '';
end;

function  TStockMovementLines.GetValue             : Double;    begin Result := GetFloatField('Value');end;
function TStockMovementLines.ISStockAdjustment: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockmovement then
     result := SameText(TStockMovement(Owner).SMEType,StockAdjustEntryType);
end;

function TStockMovementLines.ISStockTransfer: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockmovement then
     result := SameText(TStockMovement(Owner).SMEType,StockTransferEntrytype);
end;

function  TStockMovementLines.GetAvailable         : Double;    begin Result := GetFloatField('Available');end;
function  TStockMovementLines.GetSerials           : string;    begin Result := GetStringField('Serials');end;
function  TStockMovementLines.GetUnitOfMeasure     : string;    begin Result := GetStringField('UOM');end;
function  TStockMovementLines.GetUOMMultiplier     : Double;    begin Result := GetFloatField('UOMMultiplier');end;
function TStockMovementLines.GetUOMOrderQty: Double;
begin
  result :=0;
end;

function  TStockMovementLines.GetUOMQty            : Double;    begin Result := GetFloatField('UOMQty');end;
function  TStockMovementLines.GetDeleted           : Boolean;   begin Result := GetBooleanField('Deleted');end;
function  TStockMovementLines.GetUnitOfMeasureID   : Integer;   begin Result := GetIntegerField('UOMID');end;
function  TStockMovementLines.GetSerialnos         : String;    begin Result := GetStringfield('Serials');end;
function  TStockMovementLines.Getalloctype         : String;    begin REsult := 'IN';end;//if Qty>0 then Result := 'IN' else Result := 'OUT';end;
Function  TStockMovementLines.GetActive            : Boolean;   begin Result := not(Deleted);end;
function  TStockMovementLines.GetTransDate         : TDatetime; begin Result := MovementDate;end;
function  TStockMovementLines.GetBOQty             : Double;    begin Result := 0;end;
function  TStockMovementLines.GetBOUOMQty          : Double;    begin Result := 0;end;
function  TStockMovementLines.GetCleanClassID      : Integer;   begin Result := 0;end;
function  TStockMovementLines.GetcleanProductId    : Integer;   begin Result := 0;end;
procedure TStockMovementLines.SetStockMovementID   (const Value: Integer   ); begin SetIntegerField('StockMovementID', Value);end;
procedure TStockMovementLines.SetMovementDate      (const Value: TDateTime ); begin SetDateTimeField('MovementDate'  , Value);end;
procedure TStockMovementLines.SetOrderQty(const Value: Double);
begin
  inherited;
//
end;

procedure TStockMovementLines.SetProductID         (const Value: Integer   ); begin SetIntegerField('ProductID'      , Value);end;
procedure TStockMovementLines.SetProductName       (const Value: string    ); begin SetStringField('ProductName'     , Value);end;
procedure TStockMovementLines.SetDescription       (const Value: string    ); begin SetStringField('Description'     , Value);end;
procedure TStockMovementLines.SetDeptID            (const Value: Integer   ); begin SetIntegerField('ClassID'        , Value);end;
procedure TStockMovementLines.SetDeptName          (const Value: string    ); begin SetStringField('ClassName'       , Value);end;
procedure TStockMovementLines.SetAccountID         (const Value: Integer   ); begin SetIntegerField('AccountID'      , Value);end;
procedure TStockMovementLines.SetAccountName       (const Value: string    ); begin SetStringField('AccountName'     , Value);end;
procedure TStockMovementLines.SetQty               (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;
procedure TStockMovementLines.SetCost              (const Value: Double    ); begin SetFloatField('Cost'             , Value);end;
procedure TStockMovementLines.SetAssetAccountID    (const Value: Integer   ); begin SetIntegerField('AssetAccountID' , Value);end;
procedure TStockMovementLines.SetSMELineGlobalref  (const Value: string    ); begin SetStringField('SMELineGlobalref', Value);end;
procedure TStockMovementLines.SetAssetAccountName(const Value: string);
begin
  if Value <> '' then begin
    AssetAccountID := tcdatautils.accountIDforName(Value);// TAccount.IDToggle(Value, Connection.Connection);
    if AssetAccountID = 0 then
      AssetAccountID := -1;
  end
  else
    AssetAccountID := 0;
end;

procedure TStockMovementLines.SetValue             (const Value: Double    ); begin SetFloatField('Value'            , Value);end;
procedure TStockMovementLines.SetAvailable         (const Value: Double    ); begin SetFloatField('Available'        , Value);end;
procedure TStockMovementLines.SetSerials           (const Value: string    ); begin SetStringField('Serials'         , Value);end;
procedure TStockMovementLines.SetUnitOfMeasure     (const Value: string    ); begin SetStringField('UOM'             , Value);end;
procedure TStockMovementLines.SetUOMMultiplier     (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TStockMovementLines.SetUOMOrderQty(const Value: Double);
begin
  inherited;
//
end;

procedure TStockMovementLines.SetUOMQty            (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;
procedure TStockMovementLines.SetDeleted           (const Value: Boolean   ); begin SetBooleanField('Deleted'        , Value);end;
procedure TStockMovementLines.SetUnitOfMeasureID   (const Value: Integer   ); begin SetIntegerField('UOMID'          , Value);end;
procedure TStockMovementLines.SetSerialNos         (const Value: String    ); begin SetStringfield('Serials'         , Value);end;
procedure TStockMovementLines.SetTransDate         (const Value: TDatetime ); begin MovementDate := Value;end;

procedure TStockMovementLines.SetMatrixDesc(const Value: String);begin  SetStringField('MatrixDesc' , Value);end;
procedure TStockMovementLines.SetMatrixPrice(const Value: Double);begin  SetFloatfield('MatrixPrice' , Value);end;
procedure TStockMovementLines.SetMatrixRef(const Value: String);begin  SetStringField('MatrixRef' , Value);end;
function TStockMovementLines.getMatrixDesc: String;begin  Result := GetStringfield('MatrixDesc');end;
function TStockMovementLines.getMatrixPrice: Double;begin  REsult := getFloatfield('MatrixPrice');end;
function TStockMovementLines.getMatrixRef: String;begin  Result := GetStringfield('MatrixRef');end;


function TStockMovementLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockMovement then begin
      StockMovementID := TStockMovement(Self.Owner).ID;
      MovementDate:= TStockMovement(Self.Owner).MovementDate;
      AccountID     := TStockMovement(Self.Owner).AccountID;
    end;
  UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
  Qty   := 0;
  UOMQty:= 0;
end;

function TStockMovementLines.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TStockMovementLines.getHEaderAccountID: Integer;
begin
  REsult := 0;
  if Assigned(Self.Owner) then
    if self.owner is TStockMovement then
      Result := TStockMovement(Self.Owner).AccountID;
end;

function TStockMovementLines.UpdateAccounts: Boolean;
var
  CleanNode:IXMLNode;
begin
  result := true;
    if (AccountID =0) and (AssetAccountID = 0) then exit;

    CleanNode:= CleanXMLNode;
    if HeaderDeleted then begin
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,AccountID, -(Cost * Qty));{COGS}
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,AssetAccountID,  -(Cost * Qty));{Asset}
    end else begin
        if Assigned(CleanNode) then  begin
            PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,GetXMLNOdeIntegerValue(CleanNode,'AccountID'),- (GetXMLNodeFloatValue(CleanNode,'Cost') *GetXMLNodeFloatValue(CleanNode,'Qty')));{COGS}
            PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,GetXMLNOdeIntegerValue(CleanNode,'AssetAccountID'),-(GetXMLNodeFloatValue(CleanNode,'Cost') *GetXMLNodeFloatValue(CleanNode,'Qty')));{Asset}
        end;
        if AccountID <> 0 then
            PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,AccountID, +(Cost * Qty));{COGS}
        if AssetAccountID <> 0 then
            PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,AssetAccountID, + (Cost * Qty));{Asset}
    End;
    Result := True;
end;

function TStockMovementLines.getAccount: TAccount;
begin
  Result := TAccount(getContainerComponent(TAccount, 'AccountID = ' + IntToStr(Self.accountID)));
end;

function TStockMovementLines.getHeaderDeleted: Boolean;
begin
  result := False ;
  if assigned(Self.Owner) then
    if self.owner is TStockMovement then
      Result := TStockMovement(Self.Owner).DEleted;
end;



procedure TStockMovementLines.SetActive(const Value: Boolean);
begin
  Deleted := not(Value);

end;

procedure TStockMovementLines.SetBOQty(const Value: Double);
begin
  //
end;
procedure TStockMovementLines.SetBOUOMQty(const Value: Double);
begin
  //
end;




function TStockMovementLines.GetProductType: string;
begin
  Result := GetStringField('PartType');
end;

procedure TStockMovementLines.SetProductType(const Value: string);
begin
  inherited;
  SetStringField('PartType', Value);
end;

initialization
  RegisterClassOnce(TStockMovementLines);
  RegisterClassOnce(TStockMovement);
end.
