unit BusObjExpenseClaim;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/06/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjAttachment, BusObjGLAccount, BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type

  TExpenseClaimLine = class;

  TExpenseClaim = class(TMSBusObj)
  private
    FForeignTotalAmount :Double;
    function GetDateTime            : TDateTime ;
    function GetDescription         : string    ;
    function GetTotalTax            : Double    ;
    function GetTotalAmountEx       : Double    ;
    function GetTotalAmountInc      : Double    ;
    function GetForeignExchangeRate : Double    ;
    function GetForeignTotalAmount  : Double    ;
    function GetEmployeeName        : string    ;
    function GetForeignExchangeCode : string    ;
    function GetEmployeeID          : Integer   ;
    function GetRefNo               : string    ;
    function GetComments            : string    ;
    function GetTripGroup           : string    ;
    function GetCategory            : string    ;
    function GetActive              : Boolean   ;
    function GetProcessed            : Boolean   ;

    procedure SetDateTime            (const Value: TDateTime );
    procedure SetDescription         (const Value: string    );
    procedure SetTotalTax            (const Value: Double    );
    procedure SetTotalAmountEx       (const Value: Double    );
    procedure SetTotalAmountInc      (const Value: Double    );
    procedure SetForeignExchangeRate (const Value: Double    );
    procedure SetForeignTotalAmount  (const Value: Double    );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetForeignExchangeCode (const Value: string    );
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetRefNo               (const Value: string    );
    procedure SetComments            (const Value: string    );
    procedure SetTripGroup           (const Value: string    );
    procedure SetCategory            (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetProcessed            (const Value: Boolean   );
    function GetLines: TExpenseClaimLine;Virtual;
    function GetRequestToEmployeeID: Integer;
    function GetRequestToEmployeeName: string;
    procedure SetRequestToEmployeeID(const Value: Integer);
    procedure SetRequestToEmployeeName(const Value: string);
    function getRequestToEmployeeEmail: string;
    procedure CalcForeignAmount;
    procedure CalcForeignAmountCallback(const Sender: TBusObj;
      var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender: TDatasetBusObj) : Boolean;          override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure CalcClaimTotals;
    procedure CheckallLinesProcessed;
  published
    property DateTime             :TDateTime  read GetDateTime               write SetDateTime        ;
    property Description          :string     read GetDescription            write SetDescription     ;
    property TotalTax             :Double     read GetTotalTax               write SetTotalTax        ;
    property TotalAmountEx        :Double     read GetTotalAmountEx          write SetTotalAmountEx   ;
    property TotalAmountInc       :Double     read GetTotalAmountInc         write SetTotalAmountInc  ;
    property ForeignExchangeRate  :Double     read GetForeignExchangeRate    write SetForeignExchangeRate;
    property ForeignTotalAmount   :Double     read GetForeignTotalAmount     write SetForeignTotalAmount;
    property EmployeeName         :string     read GetEmployeeName           write SetEmployeeName    ;
    property ForeignExchangeCode  :string     read GetForeignExchangeCode    write SetForeignExchangeCode;
    property EmployeeID           :Integer    read GetEmployeeID             write SetEmployeeID      ;
    property RequestToEmployeeName: string    read GetRequestToEmployeeName  write SetRequestToEmployeeName    ;
    property RequestToEmployeeID: Integer     read GetRequestToEmployeeID    write SetRequestToEmployeeID      ;
    property RefNo                :string     read GetRefNo                  write SetRefNo           ;
    property Comments             :string     read GetComments               write SetComments        ;
    property Active               :Boolean    read GetActive                 write SetActive          ;
    property Processed            :Boolean    read GetProcessed              write SetProcessed        ;
    property RequestToEmployeeEmail: string   read getRequestToEmployeeEmail;
    property Lines: TExpenseClaimLine read GetLines;
    property TripGroup            :string     read GetTripGroup              write SetTripGroup       ;
    property Category             :string     read GetCategory               write SetCategory        ;
  end;

  TExpenseClaimLine = class(TMSBusObj)
  private
    function GetExpenseClaimID        : Integer   ;
    function GetDateTime              : TDateTime ;
    function GetDescription           : string    ;
    function GetPayTo                 : string    ;
    function GetTax                   : Double    ;
    function GetAmountEx              : Double    ;
    function GetAmountInc             : Double    ;
    function GetAccountName           : string    ;
    function GetSupplierName          : string    ;
    function GetSupplierID            : Integer   ;
    function GetEmployeeName          : string    ;
    function GetEmployeeID            : Integer   ;
    function GetRefNo                 : string    ;
    function GetComments              : string    ;
    function GetActive                : Boolean   ;
    function GetReimbursement         : Boolean   ;
    Function getForeignTotalLineAmount: Double;
    procedure SetExpenseClaimID        (const Value: Integer   );
    procedure SetDateTime              (const Value: TDateTime );
    procedure SetDescription           (const Value: string    );
    procedure SetPayTo                 (const Value: string    );
    procedure SetTax                   (const Value: Double    );
    procedure SetAmountEx              (const Value: Double    );
    procedure SetAmountInc             (const Value: Double    );
    procedure SetAccountName           (const Value: string    );
    procedure SetSupplierName          (const Value: string    );
    procedure SetSupplierID            (const Value: Integer   );
    procedure SetEmployeeName          (const Value: string    );
    procedure SetEmployeeID            (const Value: Integer   );
    procedure SetRefNo                 (const Value: string    );
    procedure SetComments              (const Value: string    );
    procedure SetActive                (const Value: Boolean   );
    procedure SetReimbursement         (const Value: Boolean   );
    Procedure SetForeignTotalLineAmount(Const Value: double    );
    function GetTaxCode: string;
    function GetTaxCodeId: integer;
    procedure SetTaxCode(const Value: string);
    procedure SetTaxCodeId(const Value: integer);
    function GetTaxRate: double;
    procedure SetTaxRate(const Value: double);
    function GetAccountId: integer;
    procedure SetAccountId(const Value: integer);
    function GetApproval: string;
    procedure SetApproval(const Value: string);
    function GetLineProcessed: boolean;
    procedure SetLineProcessed(const Value: boolean);
    function GetApproved: boolean;
    function GetBillId: integer;
    function GetChequeId: integer;
    procedure SetBillId(const Value: integer);
    procedure SetChequeId(const Value: integer);
    function getGLaccount: TAccount;
    function GetCustomerId: integer;
    function GetCustomerName: string;
    function GetPaymethod: string;
    procedure SetCustomerId(const Value: integer);
    procedure SetCustomerName(const Value: string);
    procedure SetPaymethod(const Value: string);
    function Getattachments: TAttachment;
    procedure CalcLineForeingAmount;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender: TDatasetBusObj) : Boolean;            override;
    function  DoBeforePost(Sender: TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender: TDatasetBusObj) : Boolean;          override;
    Function  DoAfterDelete(Sender :TDatasetBusObj ):Boolean; override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function Convert: string;
    property Approved: boolean read GetApproved;
    Property GLaccount : TAccount read getGLaccount;
    property Attachments: TAttachment read Getattachments;
  published
    property ExpenseClaimID         :Integer     read GetExpenseClaimID       write SetExpenseClaimID    ;
    property DateTime               :TDateTime   read GetDateTime             write SetDateTime          ;
    property Description            :string      read GetDescription          write SetDescription       ;
    property PayTo                  :string      read GetPayTo                write SetPayTo             ;
    property Tax                    :Double      read GetTax                  write SetTax               ;
    property AmountEx               :Double      read GetAmountEx             write SetAmountEx          ;
    property AmountInc              :Double      read GetAmountInc            write SetAmountInc         ;
    property TaxCode: string read GetTaxCode write SetTaxCode;
    property TaxCodeId: integer read GetTaxCodeId write SetTaxCodeId;
    property TaxRate: double read GetTaxRate write SetTaxRate;
    property AccountName            :string      read GetAccountName          write SetAccountName       ;
    property AccountId: integer read GetAccountId write SetAccountId;
    property SupplierName           :string      read GetSupplierName         write SetSupplierName      ;
    property SupplierID             :Integer     read GetSupplierID           write SetSupplierID        ;
    property EmployeeName           :string      read GetEmployeeName         write SetEmployeeName      ;
    property EmployeeID             :Integer     read GetEmployeeID           write SetEmployeeID        ;
    property RefNo                  :string      read GetRefNo                write SetRefNo             ;
    property Comments               :string      read GetComments             write SetComments          ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property Approval: string read GetApproval write SetApproval;
    property Reimbursement          :Boolean     read GetReimbursement        write SetReimbursement     ;
    property LineProcessed: boolean read GetLineProcessed write SetLineProcessed;
    property BillId: integer read GetBillId write SetBillId;
    property ChequeId: integer read GetChequeId write SetChequeId;
    property CustomerId: integer read GetCustomerId write SetCustomerId;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    property Paymethod: string read GetPaymethod write SetPaymethod;
    Property ForeignTotalLineAmount :Double read getForeignTotalLineAmount write setForeignTotalLineAmount;
  end;
  TExpenseClaimLineEx = Class(TExpenseClaimLine)
  Published
    property Attachments;
  End;
  TExpenseClaimEx = class(TExpenseClaim)
    Private
    function getLineEx: TExpenseClaimLineEx;
    Public
    Published
      property Lines: TExpenseClaimLineEx read getLineEx;
  end;
implementation
uses
  tcDataUtils, CommonLib, SysUtils, AppEnvironment, BusObjEmployee,
  BusObjTaxCodes, BusObjClient, busobjExpenses, CommonDbLib,
  BusObjConst, ERPDbComponents, DbSharedObjectsObj, tcClasses,
  tcConst;



  {TExpenseClaim}

procedure TExpenseClaim.CalcClaimTotals;
var
  bm: TBookmark;
  totTax: double;
  totInc: double;
  totEx: double;
begin
  totTax := 0;
  totInc := 0;
  totEx := 0;

  Lines.PostDb;
  if Lines.Count > 0 then begin
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.DisableControls;
      try
        Lines.First;
        while not Lines.EOF do begin
          totTax := totTax + Lines.Tax;
          totEx := totEx + Lines.AmountEx;
          totInc := totInc + Lines.AmountInc;
          Lines.Next;
        end;
      finally
        Lines.Dataset.GotoBookmark(bm);
        Lines.Dataset.EnableControls;
      end;
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
  end;

  TotalTax := totTax;
  TotalAmountEx := totEx;
  TotalAmountInc := totInc;
end;

procedure TExpenseClaim.CheckallLinesProcessed;
var
  bm: TBookmark;
  allDone: boolean;
begin
  allDone := true;

  Lines.PostDb;
  if Lines.Count > 0 then begin
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.DisableControls;
      try
        Lines.First;
        while not Lines.EOF do begin
          if ((not Lines.LineProcessed) and SameText(Lines.Approval, 'Approved')) or
            SameText(Lines.Approval, 'Pending') then begin
            allDone := false;
            break;
          end;
          Lines.Next;
        end;
      finally
        Lines.Dataset.GotoBookmark(bm);
        Lines.Dataset.EnableControls;
      end;
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
    self.Processed := allDone;
    self.PostDb;
  end;
end;

constructor TExpenseClaim.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ExpenseClaim';
  fSQL := 'SELECT * FROM tblexpenseclaim';
end;


destructor TExpenseClaim.Destroy;
begin
  inherited;
end;


procedure TExpenseClaim.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DateTime');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'TotalTax');
  SetPropertyFromNode(node,'TotalAmountEx');
  SetPropertyFromNode(node,'TotalAmountInc');
  SetPropertyFromNode(node,'ForeignExchangeRate');
  SetPropertyFromNode(node,'ForeignTotalAmount');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'ForeignExchangeCode');
  SetPropertyFromNode(node,'RequestToEmployeeID');
  SetPropertyFromNode(node,'RequestToEmployeeName');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'RefNo');
  SetPropertyFromNode(node,'Comments');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Processed');
end;


procedure TExpenseClaim.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DateTime' ,DateTime);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'TotalTax' ,TotalTax);
  AddXMLNode(node,'TotalAmountEx' ,TotalAmountEx);
  AddXMLNode(node,'TotalAmountInc' ,TotalAmountInc);
  AddXMLNode(node,'ForeignExchangeRate' ,ForeignExchangeRate);
  AddXMLNode(node,'ForeignTotalAmount' ,ForeignTotalAmount);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'ForeignExchangeCode' ,ForeignExchangeCode);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'RequestToEmployeeName' ,RequestToEmployeeName);
  AddXMLNode(node,'RequestToEmployeeID' ,RequestToEmployeeID);
  AddXMLNode(node,'RefNo' ,RefNo);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Processed' ,Processed);
end;


function TExpenseClaim.ValidateData: Boolean ;
var
  bm: TBookmark;
begin
  Result := False;
  Resultstatus.Clear;
  if Description = '' then begin
    AddResult(false,rssWarning,0,'Description should not be blank');
    exit;
  end;
  if DateTime = 0 then begin
    AddResult(false,rssWarning,0,'Date should not be blank');
    exit;
  end;
  if (EmployeeName  = '') and (EmployeeId > 0) then DoFieldOnChange(Dataset.FindField('EmployeeId'));
  if (EmployeeName <> '') and (EmployeeId = 0) then DoFieldOnChange(Dataset.FindField('EmployeeName'));

  if (RequestToEmployeeName  = '') and (RequestToEmployeeId > 0) then  DoFieldOnChange(Dataset.FindField('RequestToEmployeeId'));
  if (RequestToEmployeeName <> '') and (RequestToEmployeeId = 0) then  DoFieldOnChange(Dataset.FindField('RequestToEmployeeName'));

  if (EmployeeId = 0) or (EmployeeName ='') then begin
    AddResult(false,rssWarning,0,'Employee should not be blank');
    exit;
  end;
  if (RequestToEmployeeId = 0) or (RequestToEmployeeName ='') then begin
    AddResult(false,rssWarning,0,'Request To Employee should not be blank');
    exit;
  end;

  { validate lines }

  Lines.PostDb;
  if Lines.Count = 0 then begin
    AddResult(false,rssWarning,0,'This claim # ' +inttostr(ID)+' is flagged as Inactive as it has no lines on it.');
    Active := False;
    PostDB;
  end;
  if Lines.Count > 0 then begin
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.DisableControls;
      try
        Lines.First;
        while not Lines.EOF do begin
          if not Lines.ValidateData then
            exit;
          Lines.Next;
        end;
        Lines.Dataset.GotoBookmark(bm);
      finally
        Lines.Dataset.EnableControls;
      end;
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
  end;
  Result := True;
end;

function TExpenseClaim.Save: Boolean ;
var
  bm: TBookmark;
begin
  Result := False;
  if not ValidateData then Exit;
  if not inherited Save then exit;

  { save lines }

  Lines.PostDb;
  if Lines.Count > 0 then begin
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.DisableControls;
      try
        Lines.First;
        while not Lines.EOF do begin
          if not Lines.Save then
            exit;
          Lines.Next;
        end;
      finally
        Lines.Dataset.GotoBookmark(bm);
        Lines.Dataset.EnableControls;
      end;
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
  end;

  result := true;
end;


procedure TExpenseClaim.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TExpenseClaim.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.fieldName, 'EmployeeID') then begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'EmployeeName') then begin
    EmployeeId := TEmployee.IDToggle(EmployeeName, Connection.Connection);
    DoFieldOnChange(Dataset.FindField('EmployeeId'));
  end else if Sysutils.SameText(Sender.fieldName, 'RequestToEmployeeID') then begin
    RequestToEmployeeName := TEmployee.IDToggle(RequestToEmployeeID, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'RequestToEmployeeName') then begin
    RequestToEmployeeId := TEmployee.IDToggle(RequestToEmployeeName, Connection.Connection);
    DoFieldOnChange(Dataset.FindField('RequestToEmployeeId'));
  End Else If Sysutils.SameText(Sender.FieldName, 'ForeignExchangeRate') Then Begin
    CalcForeignAmount;
  end
end;
procedure TExpenseClaim.CalcForeignAmount;
begin
  inherited;
  FForeignTotalAmount := 0;
  Lines.IterateREcords(CalcForeignAmountCallback);
  ForeignTotalAmount := Round(fForeignTotalAmount, CurrencyRoundPlaces);
end;
procedure TExpenseClaim.CalcForeignAmountCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  inherited;
  try
    TExpenseClaimLine(Sender).CalcLineForeingAmount;
    fForeignTotalAmount := fForeignTotalAmount + TExpenseClaimLine(Sender).ForeignTotalLineAmount;
  except
    // kill the exception
  end;
end;

function TExpenseClaim.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TExpenseClaim.GetIDField: string;
begin
  Result := 'ExpenseClaimID'
end;


function TExpenseClaim.GetLines: TExpenseClaimLine;
begin
  result := TExpenseClaimLine(GetContainerComponent(TExpenseClaimLine,'ExpenseClaimID = ' + IntToStr(Self.ID)));
end;

class function TExpenseClaim.GetBusObjectTablename: string;
begin
  Result:= 'tblexpenseclaim';
end;


function TExpenseClaim.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  EmployeeID := AppEnv.Employee.EmployeeID;
  DateTime := Trunc(Now);
  ForeignExchangeCode := Appenv.RegionalOptions.ForeignExDefault;
  ForeignExchangeRate := 1;
end;

function TExpenseClaim.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if RefNo = '' then RefNo := IntToStr(ID);

end;


{Property Functions}
function  TExpenseClaim.GetDateTime        : TDateTime ; begin Result := GetDateTimeField('DateTime');end;
function  TExpenseClaim.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  TExpenseClaim.GetTotalTax        : Double    ; begin Result := GetFloatField('TotalTax');end;
function  TExpenseClaim.GetTotalAmountEx   : Double    ; begin Result := GetFloatField('TotalAmountEx');end;
function  TExpenseClaim.GetTotalAmountInc  : Double    ; begin Result := GetFloatField('TotalAmountInc');end;
function  TExpenseClaim.GetForeignExchangeRate: Double    ; begin Result := GetFloatField('ForeignExchangeRate');end;
function  TExpenseClaim.GetForeignTotalAmount : Double    ; begin Result := GetFloatField('ForeignTotalAmount');end;
function  TExpenseClaim.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TExpenseClaim.GetForeignExchangeCode: string    ; begin Result := GetStringField('ForeignExchangeCode');end;
function  TExpenseClaim.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TExpenseClaim.GetRefNo           : string    ; begin Result := GetStringField('RefNo');end;
function TExpenseClaim.getRequestToEmployeeEmail: string;
begin
  With TEmployee.Create(Self) do try
    connection := Self.Connection;
    Load(RequestToEmployeeID);
    Result := Email;
  finally
    Free;
  end;
end;

function TExpenseClaim.GetRequestToEmployeeID: Integer;begin  result := GetIntegerField('RequestToEmployeeID');end;
function TExpenseClaim.GetRequestToEmployeeName: string;begin  result := GetStringField('RequestToEmployeeName');end;
function  TExpenseClaim.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function  TExpenseClaim.GetTripGroup       : string    ; begin Result := GetStringField('TripGroup');end;
function  TExpenseClaim.GetCategory        : string    ; begin Result := GetStringField('Category');end;
function  TExpenseClaim.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TExpenseClaim.GetProcessed        : Boolean   ; begin Result := GetBooleanField('Processed');end;
procedure TExpenseClaim.SetDateTime        (const Value: TDateTime ); begin SetDateTimeField('DateTime'         , Value);end;
procedure TExpenseClaim.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;
procedure TExpenseClaim.SetTotalTax        (const Value: Double    ); begin SetFloatField('TotalTax'         , Value);end;
procedure TExpenseClaim.SetTotalAmountEx   (const Value: Double    ); begin SetFloatField('TotalAmountEx'    , Value);end;
procedure TExpenseClaim.SetTotalAmountInc  (const Value: Double    ); begin SetFloatField('TotalAmountInc'   , Value);end;
procedure TExpenseClaim.SetForeignExchangeRate (const Value: Double    ); begin SetFloatField('ForeignExchangeRate'   , Value);end;
procedure TExpenseClaim.SetForeignTotalAmount  (const Value: Double    ); begin SetFloatField('ForeignTotalAmount'   , Value);end;
procedure TExpenseClaim.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TExpenseClaim.SetForeignExchangeCode (const Value: string    ); begin SetStringField('ForeignExchangeCode'     , Value);end;
procedure TExpenseClaim.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure TExpenseClaim.SetRefNo           (const Value: string    ); begin SetStringField('RefNo'            , Value);end;
procedure TExpenseClaim.SetRequestToEmployeeID(const Value: Integer);begin  SetIntegerField('RequestToEmployeeID', Value);end;
procedure TExpenseClaim.SetRequestToEmployeeName(const Value: string);begin  SetStringField('RequestToEmployeeName', Value);end;
procedure TExpenseClaim.SetComments        (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TExpenseClaim.SetTripGroup       (const Value: string    ); begin SetStringField('TripGroup'         , Value);end;
procedure TExpenseClaim.SetCategory        (const Value: string    ); begin SetStringField('Category'          , Value);end;
procedure TExpenseClaim.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TExpenseClaim.SetProcessed        (const Value: Boolean   ); begin SetBooleanField('Processed'         , Value);end;

  {TExpenseClaimLine}

procedure TExpenseClaimLine.CalcLineForeingAmount;
begin
  inherited;
    if (Self is TExpenseClaimLine) and (Assigned(Owner)) and (Owner is TExpenseClaim) then begin
      ForeignTotalLineAmount := LocalToForeign(AmountInc, TExpenseClaim(Owner).ForeignExchangeRate, RoundPlacesGeneral);
    end;
end;

function TExpenseClaimLine.Convert: string;
var
  cheque: TCheque;
  employee: TEmployee;
  bill: TBill;
  suppId: integer;
  Id: integer;
  CreateNew: boolean;

  function ExistingChequeId: integer;
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObj.GetQuery(Self.Connection.Connection);
    try
      qry.SQL.Add('select PurchaseOrderId as Id from tblpurchaseorders');
      qry.SQL.Add('where SupplierName = ' +QuotedStr(self.EmployeeName));
      qry.SQL.Add('and RefNo = ' + QuotedStr(TExpenseClaim(Owner).RefNo));
      qry.SQL.Add('and IsCheque = "T" and Deleted = "F" and Cancelled = "F"');
      qry.Open;
      result := qry.FieldByName('Id').AsInteger;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;

  function ExistingBillId: integer;
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObj.GetQuery(Self.Connection.Connection);
    try
      qry.SQL.Add('select PurchaseOrderId as Id from tblpurchaseorders');
      qry.SQL.Add('where ClientId = ' +IntToStr(self.SupplierId));
      qry.SQL.Add('and InvoiceNumber = ' + QuotedStr(TExpenseClaim(Owner).RefNo));
      qry.SQL.Add('and IsBill = "T" and Deleted = "F" and Cancelled = "F"');
      qry.Open;
      result := qry.FieldByName('Id').AsInteger;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;

begin
  TExpenseClaim(Owner).PostDb;
  PostDb;
  ResultStatus.Clear;
  result := '';
  if not ValidateData then
    exit;
  if not self.Approved then begin
    AddResult(false,rssWarning,0,'Line ' + NOTAPPROVEDREMINDERDESC +'');
    exit;
  end;
  if (AccountName = '') then begin
    AddResult(false,rssWarning,0,'Account should not be blank.');
    exit;
  end;
  CreateNew := true;
  if self.Reimbursement then begin
    { cheque to pay mone back to employee }
    cheque := TCheque.Create(nil);
    try
      cheque.SilentMode := true;
      cheque.Connection := self.Connection;
      Id := ExistingChequeId;
      if Id > 0 then begin
        cheque.Load(Id);
        { if we can Lock the cheque then it has not been processed or
          reconcilled etc so we can add lines to it }
        if cheque.Lock then begin
          if not UserLock.Lock(cheque.BusObjectTableName, cheque.ID) then begin
            AddResult(false,rssWarning,0,'Can not lock existing Cheque for ' + self.EmployeeName+
            ' to add lines as it is in use.');
            exit;
          end;
          CreateNew := false;
        end;
      end;

      if CreateNew then begin
        cheque.Load(0);
        cheque.New;
        cheque.SupplierName := self.EmployeeName;
        cheque.OrderDate := Trunc(now);
        cheque.RefNo := TExpenseClaim(Owner).RefNo;
        cheque.Comments := 'Created from Expense Claim Request ' + TExpenseClaim(Owner).RefNo;
        cheque.ExpenseClaimEmployee := TExpenseClaim(Owner).EmployeeID;
        cheque.ForeignExchangeCode := TExpenseClaim(Owner).ForeignExchangeCode;
        cheque.ForeignExchangeRate := TExpenseClaim(Owner).ForeignExchangeRate;
        if cheque.SupplierId = 0 then begin
          { need to create a supplier from this employee }
          employee := TEmployee.Create(nil);
          try
            employee.Connection := TMyDacDataConnection.Create(employee);
            employee.Connection.Connection := CommonDbLib.GetNewMyDacConnection(employee.Connection);
            employee.Connection.BeginTransaction;
            employee.Load(self.EmployeeID);
            suppId := employee.CopyTosupplier;
            employee.Connection.CommitTransaction;
            cheque.SupplierId := suppId;
  //          cheque.SupplierName := self.EmployeeName;
          finally
            employee.Free;
          end;
        end;
        cheque.TotalAmountInc := self.AmountInc;
        cheque.TotalAmount := self.AmountEx;
        cheque.TotalTax := self.Tax;
      end;
      cheque.Lines.New;
      cheque.Lines.AccountName := self.AccountName;
      cheque.Lines.LineTaxCode := self.TaxCode;
      cheque.Lines.LineCostInc := self.AmountInc;
      cheque.Lines.LineCost := self.AmountEx;
      cheque.Lines.ProductDescription := 'Expense Reimbursement';
      cheque.Lines.PostDb;
      cheque.CalcOrderTotals;
      cheque.Chequetotal := cheque.TotalAmountInc;

      if not cheque.Save then begin
        AddResult(false,rssWarning,0,cheque.ResultStatus.Messages);
        exit;
      end;
      TAttachment.Clone('tblExpenseClaimLine',ID,'tblPurchaseOrders',cheque.ID, self.Connection.Connection);
      result := 'Cheque=' + IntToStr(cheque.ID);
      ChequeId := cheque.ID;
    finally
      cheque.Free;
    end;
    self.LineProcessed := true;
    self.PostDb;
    TExpenseClaim(Owner).CheckallLinesProcessed;
  end
  else begin
    { bill from supplier }
    bill := TBill.Create(nil);
    try
      bill.SilentMode := true;
      bill.Connection := self.Connection;

      Id := ExistingBillId;
      if Id > 0 then begin
        bill.Load(Id);
        { if we can Lock the bill then it has not been processed or
          reconcilled etc so we can add lines to it }
        if bill.Lock then begin
          if not bill.UserLock.Lock(bill.BusObjectTableName, bill.ID, Bill.LockGroupname) then begin
            AddResult(false,rssWarning,0,'Can not lock existing Bill for ' + self.SupplierName+
            ' to add lines as it is in use.'+chr(13)+ chr(10)+chr(13)+chr(10)+ bill.UserLock.LockMessage );
            exit;
          end;
          CreateNew := false;
        end;
      end;

      if CreateNew then begin
        bill.Load(0);
        bill.New;
        bill.SupplierId := self.SupplierId;
        bill.OrderDate := Trunc(now);
        bill.SupplierInvoiceNumber := TExpenseClaim(Owner).RefNo;
        bill.Comments := 'Created from Expense Claim Request ' + TExpenseClaim(Owner).RefNo;
        bill.ForeignExchangeCode := TExpenseClaim(Owner).ForeignExchangeCode;
        bill.ForeignExchangeRate := TExpenseClaim(Owner).ForeignExchangeRate;
        bill.TotalAmountInc := self.AmountInc;
        bill.TotalAmount := self.AmountEx;
        bill.TotalTax := self.Tax;
        bill.ExpenseClaimEmployee := TExpenseClaim(Owner).EmployeeID;
      end;
      bill.Lines.New;
      bill.Lines.AccountName := self.AccountName;
      bill.Lines.LineTaxCode := self.TaxCode;
      bill.Lines.LineCostInc := self.AmountInc;
      bill.Lines.LineCost := self.AmountEx;
      bill.Lines.PostDb;
      bill.CalcOrderTotals;
      bill.Billtotal := bill.TotalAmountInc;
      if not bill.Save then begin
        AddResult(false,rssWarning,0,bill.ResultStatus.Messages);
        exit;
      end;
      TAttachment.Clone('tblExpenseClaimLine',ID,'tblPurchaseOrders',bill.ID, self.Connection.Connection);
      result := 'Bill=' + IntToStr(Bill.ID);
      BillId := bill.ID;
    finally
      bill.Free;
    end;
    self.LineProcessed := true;
    self.PostDb;
    TExpenseClaim(Owner).CheckallLinesProcessed;
  end;
end;

constructor TExpenseClaimLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ExpenseClaimLine';
  fSQL := 'SELECT * FROM tblexpenseclaimline';
  fIsList := true;
end;


destructor TExpenseClaimLine.Destroy;
begin
  inherited;
end;


procedure TExpenseClaimLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ExpenseClaimID');
  SetDateTimePropertyFromNode(node,'DateTime');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'PayTo');
  SetPropertyFromNode(node,'Tax');
  SetPropertyFromNode(node,'AmountEx');
  SetPropertyFromNode(node,'AmountInc');
  SetPropertyFromNode(node,'ForeignTotalLineAmount');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'SupplierName');
  SetPropertyFromNode(node,'SupplierID');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'RefNo');
  SetPropertyFromNode(node,'Paymethod');
  SetPropertyFromNode(node,'CustomerName');
  SetPropertyFromNode(node,'Comments');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'Approval');
  SetBooleanPropertyFromNode(node,'Reimbursement');
  SetBooleanPropertyFromNode(node,'LineProcessed');
end;


procedure TExpenseClaimLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ExpenseClaimID' ,ExpenseClaimID);
  AddXMLNode(node,'DateTime' ,DateTime);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'PayTo' ,PayTo);
  AddXMLNode(node,'Tax' ,Tax);
  AddXMLNode(node,'AmountEx' ,AmountEx);
  AddXMLNode(node,'AmountInc' ,AmountInc);
  AddXMLNode(node,'ForeignTotalLineAmount' ,ForeignTotalLineAmount);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'SupplierName' ,SupplierName);
  AddXMLNode(node,'SupplierID' ,SupplierID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'RefNo' ,RefNo);
  AddXMLNode(node,'Paymethod' ,Paymethod);
  AddXMLNode(node,'CustomerName' ,CustomerName);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Approval' ,Approval);
  AddXMLNode(node,'Reimbursement' ,Reimbursement);
  AddXMLNode(node,'LineProcessed', LineProcessed);
end;


function TExpenseClaimLine.ValidateData: Boolean ;
begin
  Result := False;

  if (Description = '') and (PayTo = '') then begin
    AddResult(false,rssWarning,0,'Line must have a Description and/ or Pay To value');
    exit;
  end;

  if (TaxCode = '') and (TaxCodeId > 0) then begin
    AddResult(false,rssWarning,0,'Tax Code is blank but line has a Tax Code Id of ' + IntToStr(TaxCodeId));
    exit;
  end;
  if (TaxCode <> '') and (TaxCodeId = 0) then begin
    AddResult(false,rssWarning,0,'Tax Code Id is blank but line has a Tax Code of ' + TaxCode);
    exit;
  end;

  if SameText(Approval, 'Approved') then begin
    if self.Reimbursement then begin
      if self.EmployeeName = '' then begin
        AddResult(false,rssWarning,0,'This line is flagged as a Reimbursement but there is no Employee selected to Reimburse to');
        exit;
      end;
    end else begin
      { not a Reimbursement }
      if (SupplierName = '') then begin
        AddResult(false,rssWarning,0,'Supplier Name should not be blank.');
        exit;
      end;
      if SupplierId =0 then DoFieldOnChange(Dataset.FindField('SupplierName'));
      if (SupplierId =0) then begin
        AddResult(false,rssWarning,0,'Supplier ' + quotedstr(suppliername) +' doesn''t exists');
        exit;
      end;
    end;
//    if (AccountName = '') then begin
//      AddResult(false,rssWarning,0,'Account should not be blank.');
//      exit;
//    end;
//    if accountID =0 then DoFieldOnChange(Dataset.FindField('AccountName'));
//    if (AccountId =0) then begin
//      AddResult(false,rssWarning,0,'Account ' + quotedstr(Accountname) +' doesn''t exists');
//      exit;
//    end;

  end;

  Result := True;
end;


function TExpenseClaimLine.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TExpenseClaimLine.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TExpenseClaimLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.fieldName, 'TaxCode') then begin
    TaxCodeId := BusObjTaxCodes.TTaxCode.IDToggle(TaxCode, Connection.Connection, 'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
    DoFieldOnChange(Dataset.FindField('TaxCodeId'));
  end else if Sysutils.SameText(Sender.fieldName, 'TaxCodeId') then begin
    TaxCode := BusObjTaxCodes.TTaxCode.IDToggle(TaxCodeId, Connection.Connection, 'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
    TaxRate := BusObjTaxCodes.TTaxCode.RateForCodeName(TaxCode);
         if AmountInc <> 0 then AmountEx  := Round(AmountInc / (1 + TaxRate), CurrencyRoundPlaces)
    else if AmountEx  <> 0 then AmountInc := Round((1 + TaxRate) * AmountEx, CurrencyRoundPlaces);
    Tax := Round(AmountInc - AmountEx, CurrencyRoundPlaces);
    TExpenseClaim(Owner).CalcClaimTotals;
  end else if Sysutils.SameText(Sender.fieldName, 'AmountEx') then begin
    AmountInc := Round((1 + TaxRate) * AmountEx, CurrencyRoundPlaces);
    DoFieldOnChange(Dataset.FindField('AmountInc'));
  end else if Sysutils.SameText(Sender.fieldName, 'AmountInc') then begin
    AmountEx := Round(AmountInc / (1 + TaxRate), CurrencyRoundPlaces);
    ForeignTotalLineAmount := LocalToForeign(AmountInc, TExpenseClaim(Owner).ForeignExchangeRate, RoundPlacesGeneral);
    Tax := Round(AmountInc - AmountEx, CurrencyRoundPlaces);
    TExpenseClaim(Owner).CalcClaimTotals;
  end else if Sysutils.SameText(Sender.fieldName, 'ForeignTotalLineAmount') then begin
    AmountInc := ForeignToLocal(ForeignTotalLineAmount, TExpenseClaim(Owner).ForeignExchangeRate, RoundPlacesGeneral);
    DoFieldOnChange(Dataset.FindField('AmountInc'));
  end else if Sysutils.SameText(Sender.fieldName, 'EmployeeName') then begin
    EmployeeId := TEmployee.IDToggle(EmployeeName, Connection.Connection);
    DoFieldOnChange(Dataset.FindField('EmployeeId'));
  end else if Sysutils.SameText(Sender.fieldName, 'EmployeeID') then begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'AccountName') then begin
    AccountId := TAccount.IDToggle(AccountName, Connection.Connection);
    DoFieldOnChange(Dataset.FindField('AccountID'));
  end else if Sysutils.SameText(Sender.fieldName, 'AccountId') then begin
    AccountName := TAccount.IDToggle(AccountId, Connection.Connection);
    TaxCode := GLaccount.taxCode;
    DoFieldOnChange(Dataset.FindField('Taxcode'));
    SendEvent(BusObjEvent_FieldChange , BusObjEventVal_AccountID);
  end else if Sysutils.SameText(Sender.fieldName, 'SupplierName') then begin
    SupplierId := TClient.IDToggle(SupplierName,Connection.Connection);
    DoFieldOnChange(Dataset.FindField('SupplierId'));
  end else if Sysutils.SameText(Sender.fieldName, 'SupplierId') then begin
    SupplierName := TClient.IDToggle(SupplierId,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'Reimbursement') then begin
    if Reimbursement then begin
      if EmployeeName = '' then begin
        EmployeeId := TExpenseClaim(Owner).EmployeeId;
        DoFieldOnChange(Dataset.FindField('EmployeeId'));
      end;
      SupplierId := 0;
      DoFieldOnChange(Dataset.FindField('SupplierId'));
    end else begin
      EmployeeId := 0;
      DoFieldOnChange(Dataset.FindField('EmployeeId'));
    end;
  end else if Sysutils.SameText(Sender.fieldName, 'CustomerName') then begin
    CustomerId := TClient.IDToggle(CustomerName,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'CustomerId') then begin
    CustomerName := TClient.IDToggle(CustomerId,Connection.Connection);
  end;
end;


function TExpenseClaimLine.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TExpenseClaimLine.GetIDField: string;
begin
  Result := 'ExpenseClaimLineID'
end;


function TExpenseClaimLine.GetBillId: integer;
begin
  result := GetIntegerField('BillId');
end;

class function TExpenseClaimLine.GetBusObjectTablename: string;
begin
  Result:= 'tblexpenseclaimline';
end;

function TExpenseClaimLine.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  TExpenseClaim(Owner).CalcClaimTotals;
end;

function TExpenseClaimLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TExpenseClaim) then begin
    self.ExpenseClaimID := TExpenseClaim(Owner).ID;
    self.DateTime := Trunc(TExpenseClaim(Owner).DateTime);
  end;
end;

function TExpenseClaimLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TExpenseClaimLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if (self.Description = '') and (AmountInc = 0) and (AmountEx = 0) and (supplierID=0) and ((DateTime =0) or (DateTime = date)) and (accountID=0) then begin
    SendEvent(BusobjEvent_Event , BusobjEvent_EmptyRecDelete);
    self.cancel;
    Abort;
  end;
end;

{Property Functions}
function  TExpenseClaimLine.GetExpenseClaimID     : Integer   ; begin Result := GetIntegerField('ExpenseClaimID') ;end;
function TExpenseClaimLine.getGLaccount: TAccount;
Var
  StrSQL: String;
Begin
  StrSQL:= 'AccountId =0';
       If (AccountId    > 0 ) Then StrSQL := 'AccountID = ' + IntToStr(AccountId)
  Else If (AccountName <> '') Then StrSQL := 'AccountName = ' + QuotedStr(AccountName);
  Result := TAccount(GetContainerComponent(TAccount, StrSQL));
end;

function  TExpenseClaimLine.GetDateTime           : TDateTime ; begin Result := GetDateTimeField('DateTime')      ;end;
function  TExpenseClaimLine.GetDescription        : string    ; begin Result := GetStringField('Description')     ;end;
function  TExpenseClaimLine.GetPayTo              : string    ; begin Result := GetStringField('PayTo')           ;end;
function TExpenseClaimLine.GetLineProcessed       : boolean   ; begin result := GetBooleanField('Processed')      ;end;
function  TExpenseClaimLine.GetTax                : Double    ; begin Result := GetFloatField('Tax')              ;end;
function TExpenseClaimLine.GetTaxCode             : string    ; begin result := GetStringField('TaxCode')         ;end;
function TExpenseClaimLine.GetTaxCodeId           : integer   ; begin result := GetIntegerField('TaxCodeId')      ;end;
function TExpenseClaimLine.GetTaxRate             : double    ; begin result := GetFloatField('TaxRate')          ;end;
function  TExpenseClaimLine.GetAmountEx           : Double    ; begin Result := GetFloatField('AmountEx')         ;end;
function  TExpenseClaimLine.GetAmountInc          : Double    ; begin Result := GetFloatField('AmountInc')        ;end;
function TExpenseClaimLine.GetAccountId           : integer   ; begin result := GetIntegerField('AccountId')      ;end;
function  TExpenseClaimLine.GetAccountName        : string    ; begin Result := GetStringField('AccountName')     ;end;
function  TExpenseClaimLine.GetSupplierName       : string    ; begin Result := GetStringField('SupplierName')    ;end;
function  TExpenseClaimLine.GetSupplierID         : Integer   ; begin Result := GetIntegerField('SupplierID')     ;end;
function  TExpenseClaimLine.GetEmployeeName       : string    ; begin Result := GetStringField('EmployeeName')    ;end;
function  TExpenseClaimLine.GetEmployeeID         : Integer   ; begin Result := GetIntegerField('EmployeeID')     ;end;
function  TExpenseClaimLine.GetRefNo              : string    ; begin Result := GetStringField('RefNo')           ;end;
function TExpenseClaimLine.GetChequeId            : integer   ; begin result := GetIntegerField('ChequeId')       ;end;
function  TExpenseClaimLine.GetComments           : string    ; begin Result := GetStringField('Comments')        ;end;
function  TExpenseClaimLine.GetForeignTotalLineAmount: Double    ; begin Result := GetFloatField('ForeignTotalLineAmount')        ;end;
function TExpenseClaimLine.GetCustomerId: integer;begin  result := GetIntegerField('CustomerId');end;
function TExpenseClaimLine.GetCustomerName: string;begin  result := GetStringField('CustomerName');end;
function TExpenseClaimLine.GetPaymethod: string;begin  result := GetStringField('Paymethod');end;
function  TExpenseClaimLine.GetActive             : Boolean   ; begin Result := GetBooleanField('Active')         ;end;
function TExpenseClaimLine.GetApproval            : string    ; begin result := GetStringField('Approval')        ;end;
function TExpenseClaimLine.GetApproved            : boolean   ; begin result := SameText(Approval,'Approved')     ;end;
function  TExpenseClaimLine.GetReimbursement      : Boolean   ; begin Result := GetBooleanField('Reimbursement')  ;end;
procedure TExpenseClaimLine.SetExpenseClaimID     (const Value: Integer   ); begin SetIntegerField('ExpenseClaimID'     , Value);end;
procedure TExpenseClaimLine.SetDateTime           (const Value: TDateTime ); begin SetDateTimeField('DateTime'          , Value);end;
procedure TExpenseClaimLine.SetDescription        (const Value: string    ); begin SetStringField('Description'         , Value);end;
procedure TExpenseClaimLine.SetPayTo              (const Value: string    ); begin SetStringField('PayTo'               , Value);end;
procedure TExpenseClaimLine.SetLineProcessed      (const Value: boolean   ); begin  SetBooleanField('Processed'         , Value);end;
procedure TExpenseClaimLine.SetTax                (const Value: Double    ); begin SetFloatField('Tax'                  , Value);end;
procedure TExpenseClaimLine.SetTaxCode            (const Value: string    ); begin  SetStringField('TaxCode'            , Value);end;
procedure TExpenseClaimLine.SetTaxCodeId          (const Value: integer   ); begin  SetIntegerField('TaxCodeId'         , Value);end;
procedure TExpenseClaimLine.SetTaxRate            (const Value: double    ); begin  SetFloatField('TaxRate'             , Value);end;
procedure TExpenseClaimLine.SetAmountEx           (const Value: Double    ); begin SetFloatField('AmountEx'             , Value);end;
procedure TExpenseClaimLine.SetAmountInc          (const Value: Double    ); begin SetFloatField('AmountInc'            , Value);end;
procedure TExpenseClaimLine.SetAccountId          (const Value: integer   ); begin  SetIntegerField('AccountId'         , Value);end;
procedure TExpenseClaimLine.SetAccountName        (const Value: string    ); begin SetStringField('AccountName'         , Value);end;
procedure TExpenseClaimLine.SetSupplierName       (const Value: string    ); begin SetStringField('SupplierName'        , Value);end;
procedure TExpenseClaimLine.SetSupplierID         (const Value: Integer   ); begin SetIntegerField('SupplierID'         , Value);end;
procedure TExpenseClaimLine.SetEmployeeName       (const Value: string    ); begin SetStringField('EmployeeName'        , Value);end;
procedure TExpenseClaimLine.SetEmployeeID         (const Value: Integer   ); begin SetIntegerField('EmployeeID'         , Value);end;
procedure TExpenseClaimLine.SetRefNo              (const Value: string    ); begin SetStringField('RefNo'               , Value);end;
procedure TExpenseClaimLine.SetChequeId           (const Value: integer   ); begin  SetIntegerField('ChequeId'          , Value);end;
procedure TExpenseClaimLine.SetComments           (const Value: string    ); begin SetStringField('Comments'            , Value);end;
procedure TExpenseClaimLine.SetForeignTotalLineAmount(const Value: Double    ); begin SetFloatField('ForeignTotalLineAmount' , Value);end;
procedure TExpenseClaimLine.SetCustomerId(const Value: integer);begin  SetIntegerField('CustomerId', Value);end;
procedure TExpenseClaimLine.SetCustomerName(const Value: string);begin  SetStringField('CustomerName', Value);end;
procedure TExpenseClaimLine.SetPaymethod(const Value: string);begin  SetStringField('Paymethod', Value);end;
procedure TExpenseClaimLine.SetActive             (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
procedure TExpenseClaimLine.SetApproval           (const Value: string    ); begin  SetStringField('Approval'           , Value);end;
procedure TExpenseClaimLine.SetBillId             (const Value: integer   ); begin  SetIntegerField('BillId'            , Value);end;
procedure TExpenseClaimLine.SetReimbursement      (const Value: Boolean   ); begin SetBooleanField('Reimbursement'      , Value);end;

function TExpenseClaimLine.Getattachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
    'Tablename = ' + Quotedstr(GetBusObjectTablename) + ' and TableID =' + IntToStr(ID)));

end;


{ TExpenseClaimEx }

function TExpenseClaimEx.getLineEx: TExpenseClaimLineEx;
begin
  result := TExpenseClaimLineEx(GetContainerComponent(TExpenseClaimLineEx,'ExpenseClaimID = ' + IntToStr(Self.ID)));
end;

initialization
  RegisterClass(TExpenseClaim);
  RegisterClass(TExpenseClaimLine);

  RegisterClass(TExpenseClaimEx);
  RegisterClass(TExpenseClaimLineEx);

end.

