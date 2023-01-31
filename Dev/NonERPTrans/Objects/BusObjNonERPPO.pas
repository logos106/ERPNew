unit BusObjNonERPPO;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjstock , BusobjNonERPTrans;

type
  TNonERPPurchaseLines = class(TNonERPTransLines)
  private
    function GetClassID     : Integer   ;
    function GetClass       : string    ;
    function GetAccountID   : Integer   ;
    function GetAccountName : string    ;
    function GetCustomerName : string    ;
    function GetJobName : string    ;
    function GetJobNumber : Integer;
    procedure SetClassID    (const Value: Integer   );
    procedure SetClass      (const Value: string    );
    procedure SetAccountID  (const Value: Integer   );
    procedure SetAccountName(const Value: string    );
    procedure SetCustomerName(const Value: string    );
    procedure SetJobName(const Value: string    );
    procedure SetJobNumber(const Value: Integer);
  protected
    function GetTransID         : Integer   ;Override;
    function GetERPTransLineId  : Integer   ;Override;
    procedure SetTransID        (const Value: Integer   );Override;
    procedure SetERPTransLineId (const Value: Integer   );Override;

    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function ValidateData :Boolean ; override;
  Published
    property PurchaseClass  :string  read GetClass     write SetClass     ;
    property PurchaseClassID:Integer read GetClassID   write SetClassID   ;
    property Accountname    :string  read GetAccountName   write SetAccountName   ;
    property CustomerName    :string  read GetCustomerName   write SetCustomerName   ;
    property JobName    :string  read GetJobName   write SetJobName   ;
    property JobNumber    :Integer read GetJobNumber   write SetJobNumber   ;
    property AccountID      :Integer read GetAccountID write SetAccountID ;
  end;
  TNonERPPurchase = class(TNonERPTrans)
  private
    function GetIsPO                   : Boolean   ;
    function GetIsRA                   : Boolean   ;
    function GetIsBill                 : Boolean   ;
    function GetIsCredit               : Boolean   ;
    function GetIsCheque               : Boolean   ;
    function GetConNote                : string    ;
    function GetPurchaseOrderNumber    : string    ;
    function GetOrderTo                : string    ;
    function GetShipTo                 : string    ;
    function GetInvoiceNumber          : string    ;
    Function getInvoiceDate            : TDatetime;

    procedure SetIsPO                   (const Value: Boolean   );
    procedure SetIsRA                   (const Value: Boolean   );
    procedure SetIsBill                 (const Value: Boolean   );
    procedure SetIsCredit               (const Value: Boolean   );
    procedure SetIsCheque               (const Value: Boolean   );
    procedure SetConNote                (const Value: string    );
    procedure SetPurchaseOrderNumber    (const Value: string    );
    procedure SetOrderTo                (const Value: string    );
    procedure SetShipTo                 (const Value: string    );
    procedure SetInvoiceNumber          (const Value: string    );
    Procedure SetInvoiceDate            (Const Value: TDatetime );

  protected
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function getLines: TNonERPTransLines;Override;

    function GetTransId                : Integer   ;Override;
    procedure SetTransId                (const Value: Integer   );Override;
    function GetERPTransID               : Integer   ;Override;
    procedure SetERPTransID               (const Value: Integer   );Override;
    function GetTransDate                : TDateTime ;Override;
    procedure SetTransDate                (const Value: TDateTime );Override;
    function GetClientName            : string    ;Override;
    procedure SetClientName            (const Value: string    );Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Class Function ConvertToERPPurchase(AOwner:TComponent; aPOID:Integer):Integer;
    Class Function ConvertToERPExpense(AOwner:TComponent; aPOID:Integer):Integer;


    Function ValidERPTrans:Boolean;

  published
    property IsPO                    :Boolean     read GetIsPO                  write SetIsPO               ;
    property IsRA                    :Boolean     read GetIsRA                  write SetIsRA               ;
    property IsBill                  :Boolean     read GetIsBill                write SetIsBill             ;
    property IsCredit                :Boolean     read GetIsCredit              write SetIsCredit           ;
    property IsCheque                :Boolean     read GetIsCheque              write SetIsCheque           ;
    property ConNote                 :string      read GetConNote               write SetConNote            ;
    property PurchaseOrderNumber     :string      read GetPurchaseOrderNumber   write SetPurchaseOrderNumber;
    property OrderTo                 :string      read GetOrderTo               write SetOrderTo            ;
    property ShipTo                  :string      read GetShipTo                write SetShipTo             ;
    property InvoiceNumber           :string      read GetInvoiceNumber         write SetInvoiceNumber      ;
    Property InvoiceDate             :TDatetime   read getInvoiceDate           Write SetInvoiceDate        ;
  end;

  TNonERPPurchaseFlat = class(TNonERPTransFlat)
  Private
    fsSuppliername: string;
    fsConNote: string;
    fsPurchaseOrderNumber: string;
    fsInvoiceNumber: string;
    fdInvoiceDate :TDatetime;
    fbIsBill: Boolean;
    fsClass: string;
    fsOrderTo: string;
    fbIsCredit: Boolean;
    fsShipTo: string;
    fbIsCheque: Boolean;
    fbIsPO: Boolean;
    fbIsRA: Boolean;
    fsAccountName: string;
    fsCustomerName: string;
    fsJobName: string;
    fiJobNumber: integer;
  Protected
    function GetSQL: string; override;
    Procedure HeaderSave(NonERPTrans :TNonERPTrans);override;
    Procedure LinesSave(NonERPTranslines :TNonERPTranslines);override;
    function getTNonERPTrans: TNonERPTrans;override;
  Public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
  Published
    property Suppliername       :string  read fsSuppliername        Write fsSuppliername       ;
    property IsPO               :Boolean read fbIsPO                Write fbIsPO               ;
    property IsRA               :Boolean read fbIsRA                Write fbIsRA               ;
    property IsBill             :Boolean read fbIsBill              Write fbIsBill             ;
    property IsCredit           :Boolean read fbIsCredit            Write fbIsCredit           ;
    property IsCheque           :Boolean read fbIsCheque            Write fbIsCheque           ;
    property ConNote            :string  read fsConNote             Write fsConNote            ;
    property PurchaseOrderNumber:string  read fsPurchaseOrderNumber Write fsPurchaseOrderNumber;
    property InvoiceNumber      :string  read fsInvoiceNumber       Write fsInvoiceNumber      ;
    Property InvoiceDate        :Tdatetime read fdInvoiceDate       Write fdInvoiceDate        ;
    property OrderTo            :string  read fsOrderTo             Write fsOrderTo            ;
    property ShipTo             :string  read fsShipTo              Write fsShipTo             ;
    property PurchaseClass      :string  read fsClass               Write fsClass              ;
    property AccountName        :string  read fsAccountName         Write fsAccountName        ;
    property CustomerName       :string  read fsCustomerName        Write fsCustomerName       ;
    property JobName            :string  read fsJobName             write fsJobName            ;
    property JobNumber          :integer read fiJobNumber           write fiJobNumber          ;
  end;
implementation

uses BusObjClient , Sysutils, BusObjClass, BusObjEmployee, AppEnvironment,
  MySQLConst, CommonLib, dialogs, BusObjectListObj, busobjOrders, BusobjProduct,
  BusObjGLAccount, busobjorderbase, busobjExpenses, BusObjSimpleTypes, tcConst,
  BusObjCommon;

{ TNonERPPurchaseLines }
function  TNonERPPurchaselines.GetClassID       : Integer; begin Result := GetIntegerField('ClassID')       ;end;
function  TNonERPPurchaselines.GetClass         : string ; begin Result := GetStringField('Class')          ;end;
function  TNonERPPurchaselines.GetAccountID     : Integer; begin Result := GetIntegerField('AccountID')       ;end;
function  TNonERPPurchaselines.GetAccountName   : string ; begin Result := GetStringField('AccountName')          ;end;
function  TNonERPPurchaselines.GetCustomerName  : string ; begin Result := GetStringField('CustomerName')          ;end;
function  TNonERPPurchaselines.GetJobName       : string ; begin Result := GetStringField('JobName')          ;end;
function  TNonERPPurchaselines.GetJobNumber     : integer; begin Result := GetintegerField('JobNumber')          ;end;
function TNonERPPurchaseLines.GetERPTransLineId : Integer; begin Result := GetIntegerField('ERPPOLineID')   ;end;
function TNonERPPurchaseLines.GetTransID        : Integer; begin Result := GetIntegerField('PurchaseOrderID'); end;
procedure TNonERPPurchaseLines.SetERPTransLineId(const Value: Integer   ); begin SetIntegerField('ERPPOLineID'    , value);end;
procedure TNonERPPurchaseLines.SetTransID       (const Value: Integer   ); begin SetIntegerField('PurchaseOrderID', Value);end;
procedure TNonERPPurchaselines.SetClassID       (const Value: Integer   ); begin SetIntegerField('ClassID'        , Value);end;
procedure TNonERPPurchaselines.SetClass         (const Value: string    ); begin SetStringField('Class'           , Value);end;
procedure TNonERPPurchaselines.SetAccountID     (const Value: Integer   ); begin SetIntegerField('AccountID'      , Value);end;
procedure TNonERPPurchaselines.SetAccountName   (const Value: string    ); begin SetStringField('AccountName'     , Value);end;
procedure TNonERPPurchaselines.SetCustomerName  (const Value: string    ); begin SetStringField('CustomerName'    , Value);end;
procedure TNonERPPurchaselines.SetJobName       (const Value: string    ); begin SetStringField('JobName'         , Value);end;
procedure TNonERPPurchaselines.SetJobNumber     (const Value: integer   ); begin SetintegerField('JobNumber'      , Value);end;

function TNonERPPurchaseLines.ValidateData: Boolean;
begin
  if (iscredit or isbill or ischeque) then begin
    if (Accountname ='') then begin
      AddResult(False , rssWarning , 0,  'Account Name should not be blank');
      Exit;
    end;
  end;
  result := inherited ValidateData;
end;

constructor TNonERPPurchaseLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'nonerppurchaselines';
  fSQL := 'SELECT * FROM tblnonerppurchaselines';
  ExportExcludeList.Add('PurchaseClassID');
  ExportExcludeList.Add('AccountID');
end;

destructor TNonERPPurchaseLines.Destroy;
begin

  inherited;
end;

function TNonERPPurchaseLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

procedure TNonERPPurchaseLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'Class') then begin
    PurchaseClassId := TDeptClass.IDToggle(PurchaseClass, Connection.Connection);
  end else if Sysutils.SameText(Sender.Fieldname , 'Accountname') then begin
    AccountId := TAccount.IDToggle(Accountname, Connection.Connection);
  end;
end;

class function TNonERPPurchaseLines.GetBusObjectTablename: string;
begin
  Result:= 'tblnonerppurchaselines';
end;


class function TNonERPPurchaseLines.GetIDField: string;
begin
  Result := 'PurchaseLineID'
end;

procedure TNonERPPurchaseLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PurchaseClass');
  SetPropertyFromNode(node,'PurchaseClassID');
  SetPropertyFromNode(node,'Accountname');
  SetPropertyFromNode(node,'AccountID');
end;

procedure TNonERPPurchaseLines.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PurchaseClass' ,PurchaseClass);
  AddXMLNode(node,'PurchaseClassID' ,PurchaseClassID);
  AddXMLNode(node,'Accountname' ,Accountname);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'CustomerName' ,CustomerName);
  AddXMLNode(node,'JobName' ,JobName);
  AddXMLNode(node,'JobNumber' ,JobNumber);

end;


{ TNonERPPurchase }

constructor TNonERPPurchase.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'nonerppurchases';
  fSQL := 'SELECT * FROM tblnonerppurchases';
end;

destructor TNonERPPurchase.Destroy;
begin

  inherited;
end;

function TNonERPPurchase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  enteredBy := TEmployee.IDToggle(Appenv.Employee.EmployeeID);
  enteredat := now;
  isPO := true;
end;

function TNonERPPurchase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

procedure TNonERPPurchase.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'SupplierName') then begin
    ClientId := TClient.IDToggle(clientName, Connection.Connection);
  end else if Sysutils.SameText(Sender.Fieldname , 'ispo'     ) then begin    if ispo     then begin isbill := False; iscredit := False; ischeque:= False; isRA:= False; end;
  end else if Sysutils.SameText(Sender.Fieldname , 'isbill'   ) then begin    if isbill   then begin ispo   := False; iscredit := False; ischeque:= False; isRA:= False; end;
  end else if Sysutils.SameText(Sender.Fieldname , 'isCredit' ) then begin    if isCredit then begin isbill := False; isPO     := False; ischeque:= False; isRA:= False; end;
  end else if Sysutils.SameText(Sender.Fieldname , 'ischeque' ) then begin    if ischeque then begin isbill := False; iscredit := False; ispo    := False; isRA:= False; end;
  end else if Sysutils.SameText(Sender.Fieldname , 'isRA'     ) then begin    if isRA     then begin isbill := False; iscredit := False; ischeque:= False; isPO:= False; end;
  end;
  if not (isbill or iscredit or ischeque or isRA or ispo) then ispo := true;

end;

class function TNonERPPurchase.GetBusObjectTablename: string;
begin
  Result:= 'tblnonerppurchases';
end;

function TNonERPPurchase.GetClientName: string;begin Result := GetStringfield('SupplierName'			);end;

function TNonERPPurchase.GetERPTransID: Integer; begin Result := GetIntegerField('ERPPOID'       );end;

class function TNonERPPurchase.GetIDField: string;
begin
  Result := 'PurchaseOrderID'
end;

function TNonERPPurchase.getLines: TNonERPTransLines;
begin
  Result := TNonERPTransLines(GetContainerComponent(TNonERPPurchaseLines, 'PurchaseOrderID = ' + IntToStr(Self.Id)));
end;

function TNonERPPurchase.GetTransDate              : TDateTime ; begin Result := GetDAtetimeField('OrderDate'         );end;
function TNonERPPurchase.GetTransId                : Integer   ; begin Result := GetIntegerField('PurchaseOrderID'    );end;
function TNonERPPurchase.GetIsPO                   : Boolean   ; begin Result := GetBooleanField('IsPO'               );end;
function TNonERPPurchase.GetIsRA                   : Boolean   ; begin Result := GetBooleanField('IsRA'               );end;
function TNonERPPurchase.GetIsBill                 : Boolean   ; begin Result := GetBooleanField('IsBill'             );end;
function TNonERPPurchase.GetIsCredit               : Boolean   ; begin Result := GetBooleanField('IsCredit'           );end;
function TNonERPPurchase.GetIsCheque               : Boolean   ; begin Result := GetBooleanField('Ischeque'           );end;
function TNonERPPurchase.GetConNote                : string    ; begin Result := GetStringField('ConNote'             );end;
function TNonERPPurchase.GetPurchaseOrderNumber    : string    ; begin Result := GetStringField('PurchaseOrderNumber' );end;
function TNonERPPurchase.GetInvoiceNumber          : string    ; begin Result := GetStringField('InvoiceNumber'       );end;
Function TNonERPPurchase.GetInvoiceDate            : Tdatetime ; begin Result := GetDateTimefield('InvoiceDate'       );end;
function TNonERPPurchase.GetOrderTo                : string    ; begin Result := GetStringField('OrderTo'             );end;
function TNonERPPurchase.GetShipTo                 : string    ; begin Result := GetStringField('ShipTo'              );end;
procedure TNonERPPurchase.SetClientName             (const Value: string    );begin SetStringfield('SupplierName'         , Value);end;
procedure TNonERPPurchase.SetERPTransID             (const Value: Integer   );begin SetIntegerField('ERPPOID'             , Value);end;
procedure TNonERPPurchase.SetTransDate              (const Value: TDateTime );begin SetDatetimeField('OrderDate'          , Value);end;
procedure TNonERPPurchase.SetTransId                (const Value: Integer   );begin SetIntegerField('PurchaseOrderID'     , Value);end;

function TNonERPPurchase.ValidERPTrans: Boolean;
Function IDNote :String;
begin
  result := 'Non ERP PO # ' +inttostr(+ ID)+ '->';
end;
begin
  if ClientName ='' then begin
    REsultStatus.AddItem(False, rssWarning, 0,'Supplier Name is Blank', true);
    result := False;
    Exit;
  end;
  if TSupplier.MakeSupplier(self, ClientName, true)=0 then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Supplier '+ quotedstr(Clientname) +' Doesn''t Exists', true);
    result := False;
    Exit;
  end;

  if (Terms <> '') and (TTerms.IDToggle(Terms)=0) then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Terms '+ quotedstr(TErms) +' Doesn''t Exists', true);
    result := False;
    Exit;
  end;

  if (status<>'') then
    if (isPO      and (TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_OrderStatus     , status) =0)) Or
       (isRA      and (TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_ReturnAuthority , status) =0)) Or
       (ischeque  and (TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_cheque          , status) =0)) Or
       (isbill    and (TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_Bill            , status) =0)) Or
       (isCredit  and (TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_Credit          , status) =0)) then begin
      REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Status '+ quotedstr(status) +' Doesn''t Exists', true);
      result := False;
      Exit;
    end;

  if Lines.count =0 then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'PO #' + inttostr(ID)+' has No Line', true);
    result := False;
    Exit;
  end;
  Lines.First;
  while Lines.EOF = False do begin
    if isPO or ISRA then begin
        if Lines.Productname = '' then begin
          REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Product name is Blank', true);
          result := False;
          Exit;
        end;
        if TProductSimple.ChecknMakeProduct(Lines.Productname) =0 then begin
          REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Product ' + Quotedstr(Lines.Productname)+' Doesn''t Exist', true);
          result := False;
          Exit;
        end;
    end else begin
        if TNonERPPurchaseLines(Lines).Accountname = '' then begin
          REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Account name is Blank', true);
          result := False;
          Exit;
        end;
        if TAccount.Idtoggle(TNonERPPurchaseLines(Lines).Accountname) =0 then begin
          REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Account ' + Quotedstr(TNonERPPurchaseLines(Lines).Accountname)+' Doesn''t Exist', true);
          result := False;
          Exit;
        end;
    end;
         if (TNonERPPurchaseLines(Lines).JobName <> '') and (TJob.Idtoggle(TNonERPPurchaseLines(Lines).JobName) <>0) then
          // job exists
    else if (TNonERPPurchaseLines(Lines).JobName = '') and (TNonERPPurchaseLines(Lines).CustomerName <> '') and (TCustomer.Idtoggle(TNonERPPurchaseLines(Lines).CustomerName) <>0) then
          // customer Exits
    else if TNonERPPurchaseLines(Lines).CustomerName <> '' then begin
      if (TCustomer.Idtoggle(TNonERPPurchaseLines(Lines).CustomerName) =0) and (not(AppEnv.CompanyPrefs.DisableCusSourceTracking)) and (Source ='') then begin
        REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Customer '+ quotedstr(TNonERPPurchaseLines(Lines).CustomerName) +' Doesn''t Exists and It is Not Able Create a New Customer Without the Source Details.', true);
        result := False;
        Exit;
      end;
      if TJob.MakeJob(self, TNonERPPurchaseLines(Lines).CustomerName, TNonERPPurchaseLines(Lines).JobName, TNonERPPurchaseLines(Lines).jobnumber , true, Source) = 0 then begin
        REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Customer/job '+ quotedstr(TNonERPPurchaseLines(Lines).CustomerName) +'/'+ quotedstr(TNonERPPurchaseLines(Lines).jobname)+' Doesn''t Exists', true);
        result := False;
        Exit;
      end;
    end;
    Lines.Next;
  end;
end;

procedure TNonERPPurchase.SetIsPO                   (const Value: Boolean   );begin SetBooleanField('IsPO'                , Value);end;
procedure TNonERPPurchase.SetIsRA                   (const Value: Boolean   );begin SetBooleanField('IsRA'                , Value);end;
procedure TNonERPPurchase.SetIsBill                 (const Value: Boolean   );begin SetBooleanField('IsBill'              , Value);end;
procedure TNonERPPurchase.SetIsCredit               (const Value: Boolean   );begin SetBooleanField('IsCredit'            , Value);end;
procedure TNonERPPurchase.SetIsCheque               (const Value: Boolean   );begin SetBooleanField('IsCheque'            , Value);end;
procedure TNonERPPurchase.SetConNote                (const Value: string    );begin SetStringField ('ConNote'             , Value);end;
procedure TNonERPPurchase.SetPurchaseOrderNumber    (const Value: string    );begin SetStringField ('PurchaseOrderNumber' , Value);end;
procedure TNonERPPurchase.SetInvoiceNumber          (const Value: string    );begin SetStringField ('InvoiceNumber'       , Value);end;
Procedure TNonERPPurchase.SetInvoiceDate            (Const Value: Tdatetime );begin SetDateTimefield('InvoiceDate'        , Value);end;
procedure TNonERPPurchase.SetOrderTo                (const Value: string    );begin SetStringField ('OrderTo'             , Value);end;
procedure TNonERPPurchase.SetShipTo                 (const Value: string    );begin SetStringField ('ShipTo'              , Value);end;
class function TNonERPPurchase.ConvertToERPExpense(AOwner: TComponent;  aPOID: Integer): Integer;
var
  NonERPPurchases :TNonERPPurchase;
  ExpObj :TExpenseBase;
  Procedure MakeExpObj;
  begin
         if NonERPPurchases.isCredit then ExpObj := TCredit.Create(AOwner)
    else if NonERPPurchases.ISBill   then ExpObj := TBill.Create(AOwner)
    else ExpObj := TCheque.Create(AOwner);

    ExpObj.connection := NonERPPurchases.Connection;
    ExpObj.Load(0);
  end;
begin
  result :=0;
  NonERPPurchases :=TNonERPPurchase.CreateWithNewConn(AOwner);
  try
    NonERPPurchases.Load(aPOID);
    if (NonERPPurchases.count =0) or (NonERPPurchases.lines.Count=0) or (NonERPPurchases.ERPtransID <>0) then exit;

    if not NonERPPurchases.ValidERPTrans then exit;

    MakeExpObj;


    ExpObj.Connection.BeginTransaction;
    try

        ExpObj.New;

        ExpObj.DocNumber            := NonERPPurchases.PurchaseOrdernumber;
        ExpObj.SupplierInvoiceNumber:= NonERPPurchases.InvoiceNumber;
        ExpObj.SupplierInvoiceDate  := NonERPPurchases.InvoiceDate;
        ExpObj.SupplierName         := NonERPPurchases.ClientName;
        ExpObj.OrderDate            := NonERPPurchases.TransDate;
        ExpObj.TotalAmountInc       := NonERPPurchases.TotalAmountInc;
        ExpObj.EmployeeName         := NonERPPurchases.EmployeeName;
        ExpObj.Comments             := NonERPPurchases.Comments;
        ExpObj.ConNote              := NonERPPurchases.ConNote;
        if NonERPPurchases.Terms <> '' then ExpObj.Termsname         := NonERPPurchases.Terms;
        ExpObj.OrderStatus          := NonERPPurchases.Status;

        if NonERPPurchases.Terms <> '' then ExpObj.Termsname         := NonERPPurchases.Terms;
        ExpObj.PostDB;
        NonERPPurchases.ERPtransID :=ExpObj.ID;
        NonERPPurchases.PostDB;

        NonERPPurchases.Lines.First;
        While NonERPPurchases.Lines.Eof = False do begin
          if NonERPPurchases.Lines.ERPtranslineID = 0 then begin
            if (TNonERPPurchaseLines(NonERPPurchases.Lines).Accountname<>'') then begin
                ExpObj.Lines.New;
                     if TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass ='' then ExpObj.Lines.LineClassName :=AppEnv.DefaultClass.DefaultClassName
                else if TDeptClass.IDToggle(TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass) = 0  then ExpObj.Lines.LineClassName :=AppEnv.DefaultClass.DefaultClassName
                else ExpObj.Lines.LineClassName := TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass;

                TNonERPPurchaseLines(ExpObj.Lines).Accountname         := TNonERPPurchaseLines(NonERPPurchases.Lines).Accountname;

                if TNonERPPurchaseLines(NonERPPurchases.Lines).jobname      <> '' then
                  ExpObj.lines.CustomerJobID := TJob.FindJob(ExpObj, TNonERPPurchaseLines(NonERPPurchases.Lines).JobName ,TNonERPPurchaseLines(NonERPPurchases.Lines).jobnumber);
                if (ExpObj.lines.CustomerJobID =0) and (TNonERPPurchaseLines(NonERPPurchases.Lines).CustomerName <> '') then
                  ExpObj.lines.CustomerJob := TNonERPPurchaseLines(NonERPPurchases.Lines).CustomerName;
                ExpObj.Lines.LineCostInc  := NonERPPurchases.Lines.TotalLineAmountInc;
                ExpObj.Lines.TotalLineAmountInc  := NonERPPurchases.Lines.TotalLineAmountInc;
                ExpObj.Lines.PostDB;
                NonERPPurchases.Lines.ERPtranslineID  :=ExpObj.Lines.ID;
                NonERPPurchases.Lines.PostDB;
            end;
          end;
          NonERPPurchases.Lines.next;
        end;
        ExpObj.OrderDate      := NonERPPurchases.TransDate;
        ExpObj.PostDB;
        if ExpObj is Tbill then
          Tbill(ExpObj).BillTotal :=  ExpObj.TotalAmountInc;
        if ExpObj.lines.count =0 then begin
          ExpObj.Connection.RollbackTransaction;
          Exit;
        end;
        if not ExpObj.Save then begin
          ExpObj.Connection.RollbackTransaction;
          Exit;
        end;
        ExpObj.Connection.CommitTransaction;
        Result := ExpObj.ID;
    Except
      on E:EXception do begin
        ExpObj.REsultStatus.AddItem(False, rssWarning, 0, 'Convert To ERPPurchases Failed :' + E.Message, true);
        ExpObj.Connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(ExpObj);
    Freeandnil(NonERPPurchases);
  end;
end;
class function TNonERPPurchase.ConvertToERPPurchase(AOwner: TComponent;  aPOID: Integer): Integer;
var
  NonERPPurchases :TNonERPPurchase;
  POObj :TOrderbase;
  Procedure MakePOObj;
  begin
    if NonERPPurchases.IsRA then POObj := TReturnAuthority.Create(AOwner)
    else POObj := TPurchaseOrder.Create(AOwner);
    POObj.SilentMode := True;
    POObj.connection := NonERPPurchases.Connection;
    POObj.Load(0);
  end;
begin
  result :=0;
  NonERPPurchases :=TNonERPPurchase.CreateWithNewConn(AOwner);
  try
    NonERPPurchases.Load(aPOID);
    if (NonERPPurchases.count =0) or (NonERPPurchases.lines.Count=0) or (NonERPPurchases.ERPtransID <>0) then exit;

    if not NonERPPurchases.ValidERPTrans then exit;

    MakePOObj;


    POObj.Connection.BeginTransaction;
    try

        POObj.New;

        POObj.DocNumber             := NonERPPurchases.PurchaseOrdernumber;
        POObj.SupplierInvoiceNumber := NonERPPurchases.InvoiceNumber;
        POObj.SupplierInvoiceDate   := NonERPPurchases.InvoiceDate;
        POObj.SupplierName          := NonERPPurchases.ClientName;
        POObj.OrderDate             := NonERPPurchases.TransDate;
        POObj.TotalAmountInc        := NonERPPurchases.TotalAmountInc;
        POObj.EmployeeName          := NonERPPurchases.EmployeeName;
        POObj.Comments              := NonERPPurchases.Comments;
        POObj.ConNote               := NonERPPurchases.ConNote;
        if NonERPPurchases.Terms <> '' then POObj.Termsname         := NonERPPurchases.Terms;
        POObj.OrderStatus  := NonERPPurchases.Status;
        POObj.PostDB;
        NonERPPurchases.ERPtransID :=POObj.ID;
        NonERPPurchases.PostDB;

        NonERPPurchases.Lines.First;
        While NonERPPurchases.Lines.Eof = False do begin
          if NonERPPurchases.Lines.ERPtranslineID = 0 then begin
            if (NonERPPurchases.Lines.ProductName<>'') then begin
                POObj.Lines.New;
                     if TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass ='' then POObj.Lines.LineClassName :=AppEnv.DefaultClass.DefaultClassName
                else if TDeptClass.IDToggle(TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass) = 0  then POObj.Lines.LineClassName :=AppEnv.DefaultClass.DefaultClassName
                else POObj.Lines.LineClassName := TNonERPPurchaseLines(NonERPPurchases.Lines).PurchaseClass;

                POObj.Lines.ProductName         := NonERPPurchases.Lines.ProductName;
                POObj.Lines.ProductDescription  := NonERPPurchases.Lines.Product_Description;
                POObj.Lines.Qtysold             := NonERPPurchases.Lines.Shipped;
                if TNonERPPurchaseLines(NonERPPurchases.Lines).jobname      <> '' then
                  POObj.lines.CustomerJobID := TJob.FindJob(POObj, TNonERPPurchaseLines(NonERPPurchases.Lines).JobName ,TNonERPPurchaseLines(NonERPPurchases.Lines).jobnumber);
                if (POObj.lines.CustomerJobID =0) and (TNonERPPurchaseLines(NonERPPurchases.Lines).CustomerName <> '') then
                  POObj.lines.CustomerJob := TNonERPPurchaseLines(NonERPPurchases.Lines).CustomerName;
                if POObj.Lines.Qtysold=0 then POObj.Lines.Qtysold:= 1;
                POObj.Lines.QtyShipped          := POObj.Lines.Qtysold;
                POObj.Lines.invoiced := True;
                POObj.Lines.LineCostInc  := divzer(NonERPPurchases.Lines.TotalLineAmountInc , POObj.Lines.QtyShipped);
                POObj.Lines.TotalLineAmountInc  := NonERPPurchases.Lines.TotalLineAmountInc;
                POObj.Lines.ReceivedDate        :=  NonERPPurchases.TransDate;
                POObj.Lines.PostDB;
                NonERPPurchases.Lines.ERPtranslineID  :=POObj.Lines.ID;
                NonERPPurchases.Lines.PostDB;
            end;
          end;
          NonERPPurchases.Lines.next;
        end;
        POObj.OrderDate      := NonERPPurchases.TransDate;
        POObj.PostDB;
        if POObj.lines.count =0 then begin
          POObj.Connection.RollbackTransaction;
          Exit;
        end;
        if not POObj.Save then begin
          POObj.Connection.RollbackTransaction;
          Exit;
        end;
        POObj.Connection.CommitTransaction;
        Result := POObj.ID;
    Except
      on E:EXception do begin
        POObj.REsultStatus.AddItem(False, rssWarning, 0, 'Convert To ERPPurchases Failed :' + E.Message, true);
        POObj.Connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(POObj);
    Freeandnil(NonERPPurchases);
  end;
end;

procedure TNonERPPurchase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TNonERPPurchase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;


{ TNonERPPurchaseFlat }

class function TNonERPPurchaseFlat.GetBusObjectTablename: string;
begin
  result := 'tblnonerppurchases';
end;

class function TNonERPPurchaseFlat.GetIDField: string;
begin
  Result := 'PurchaseOrderID'

end;

function TNonERPPurchaseFlat.GetSQL: string;
begin
  Result := 'Select S.* , SL.* from tblnonerpPurchases S  inner join tblnonerpPurchaselines SL on S.PurchaseOrderId = Sl.PurchaseOrderId Limit 0';
end;

function TNonERPPurchaseFlat.getTNonERPTrans: TNonERPTrans;
begin
  Result := nil;
  try
    canceldb;
    result := TNonERPPurchase(GetContainerComponent(TNonERPPurchase ,'PurchaseOrderNumber = ' + Quotedstr(PurchaseOrderNumber)+
                                                               ' and Suppliername = ' + quotedstr(clientName)+
                                                               ' and OrderDate = ' + quotedstr(Formatdatetime(mysqlDatetimeformat , transDate)) ));
  except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TNonERPPurchaseFlat.HeaderSave(NonERPTrans: TNonERPTrans);
begin
  inherited;
  if NonERPTrans is TNonERPPurchase then begin
      TNonERPPurchase(NonERPTrans).ClientName              := Suppliername          ;
      TNonERPPurchase(NonERPTrans).IsPO                    := IsPO                  ;
      TNonERPPurchase(NonERPTrans).IsRA                    := IsRA                  ;
      TNonERPPurchase(NonERPTrans).IsBill                  := IsBill                ;
      TNonERPPurchase(NonERPTrans).IsCredit                := IsCredit              ;
      TNonERPPurchase(NonERPTrans).IsCheque                := IsCheque              ;
      TNonERPPurchase(NonERPTrans).ConNote                 := ConNote               ;
      TNonERPPurchase(NonERPTrans).PurchaseOrderNumber     := PurchaseOrderNumber   ;
      TNonERPPurchase(NonERPTrans).InvoiceNumber           := InvoiceNumber         ;
      TNonERPPurchase(NonERPTrans).InvoiceDate             := InvoiceDate           ;
      TNonERPPurchase(NonERPTrans).OrderTo                 := OrderTo               ;
      TNonERPPurchase(NonERPTrans).ShipTo                  := ShipTo                ;
  end;
end;

procedure TNonERPPurchaseFlat.LinesSave(NonERPTranslines: TNonERPTranslines);
begin
  inherited;
  if NonERPTranslines is TNonERPPurchaseLines then begin
    TNonERPPurchaseLines(NonERPTranslines).Purchaseclass := Purchaseclass;
    TNonERPPurchaseLines(NonERPTranslines).Accountname   := AccountNAme;
    TNonERPPurchaseLines(NonERPTranslines).CustomerName  := CustomerName;
    TNonERPPurchaseLines(NonERPTranslines).JobName       := JobName;
    TNonERPPurchaseLines(NonERPTranslines).JobNumber     := JobNumber;
  end;
end;
{ TNonERPExpense }


initialization
  RegisterClass(TNonERPPurchase);
  RegisterClass(TNonERPPurchaseLines);
  RegisterClass(TNonERPPurchaseFlat);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Non ERP Purchases','TNonERPPurchaseFlat','TNonERPPOListGUI');
end.

