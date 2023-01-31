unit BusObjAccountPostingDetail;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/06/08  1.00.00  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TAccountpostingDetail = class(TMSBusObj)
  private
    function GetAccountPostingId          : Integer   ;
    function GetSourceLineID              : Integer   ;
    function GetClassID                   : Integer   ;
    function GetProductID                 : Integer   ;
    function GetDeptClassName             : string    ;
    function GetProductname               : string    ;
    function GetParttype                  : string    ;
    function GetAccountId                 : Integer   ;
    function GetAccountName               : string    ;
    function GetAccountType               : string    ;
    function GetDebitAmount               : Double    ;
    function GetCreditAmount              : Double    ;
    function GetDescription               : string    ;
    function GetCreditDebittype           : string    ;
    procedure SetAccountPostingId          (const Value: Integer   );
    procedure SetSourceLineID              (const Value: Integer   );
    procedure setClassID                   (const Value: Integer   );
    procedure SetProductID                 (const Value: Integer   );
    procedure SetDeptClassName             (const Value: string    );
    procedure SetProductname               (const Value: string    );
    procedure SetParttype                  (const Value: string    );
    procedure SetAccountId                 (const Value: Integer   );
    procedure SetAccountName               (const Value: string    );
    procedure SetAccountType               (const Value: string    );
    procedure SetDebitAmount               (const Value: Double    );
    procedure SetCreditAmount              (const Value: Double    );
    procedure SetDescription               (const Value: string    );
    procedure SetCreditDebittype           (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    procedure InitializeNewObject; override;
    function  GetId: integer; override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure New; override;
    function LocateId(const aId: integer): boolean;
  published
    property AccountPostingId           :Integer     read GetAccountPostingId         write SetAccountPostingId      ;
    property SourceLineID               :Integer     read GetSourceLineID             write SetSourceLineID          ;
    property ClassId                    :Integer     read GetClassID                  write setClassID               ;
    property ProductID                  :Integer     read GetProductID                write SetProductID               ;
    property DeptClassName              :string      read GetDeptClassName            write SetDeptClassName         ;
    property Productname                :string      read GetProductname              write SetProductname         ;
    property Parttype                   :string      read GetParttype                 write SetParttype         ;
    property AccountId                  :Integer     read GetAccountId                write SetAccountId             ;
    property AccountName                :string      read GetAccountName              write SetAccountName           ;
    property AccountType                :string      read GetAccountType              write SetAccountType           ;
    property DebitAmount                :Double      read GetDebitAmount              write SetDebitAmount           ;
    property CreditAmount               :Double      read GetCreditAmount             write SetCreditAmount          ;
    property Description                :string      read GetDescription              write SetDescription           ;
    property CreditDebittype            :string      read GetCreditDebittype          write SetCreditDebittype       ;
  end;


implementation


uses
  Sysutils,tcDataUtils, BusObjAccountPosting, BusObjClass, BusObjGLAccount,
  MemDS;



  {TAccountpostingDetail}

constructor TAccountpostingDetail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'AccountpostingDetail';
  fSQL := 'SELECT * FROM tblaccountpostingdetail';
end;


destructor TAccountpostingDetail.Destroy;
begin
  inherited;
end;


procedure TAccountpostingDetail.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AccountPostingId');
  SetPropertyFromNode(node,'SourceLineID');
  SetPropertyFromNode(node,'ClassId');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'DeptClassName');
  SetPropertyFromNode(node,'Productname');
  SetPropertyFromNode(node,'Parttype');
  SetPropertyFromNode(node,'AccountId');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'AccountType');
  SetPropertyFromNode(node,'DebitAmount');
  SetPropertyFromNode(node,'CreditAmount');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'CreditDebittype');
end;


procedure TAccountpostingDetail.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AccountPostingId' ,AccountPostingId);
  AddXMLNode(node,'SourceLineID' ,SourceLineID);
  AddXMLNode(node,'ClassId' ,ClassId);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'DeptClassName' ,DeptClassName);
  AddXMLNode(node,'Productname' ,ProductName);
  AddXMLNode(node,'Parttype' ,Parttype);
  AddXMLNode(node,'AccountId' ,AccountId);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'AccountType' ,AccountType);
  AddXMLNode(node,'DebitAmount' ,DebitAmount);
  AddXMLNode(node,'CreditAmount' ,CreditAmount);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'CreditDebittype' ,CreditDebittype);
end;


function TAccountpostingDetail.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if AccountPostingId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'AccountPostingId should not be 0' , False );
    Exit;
  end;
  if AccountId = 0 then begin
    if self.AccountName <> '' then
      Resultstatus.AddItem(False , rssError , 0,  'AccountId not found for Account "' + AccountName + '"' , False )
    else
      Resultstatus.AddItem(False , rssError , 0,  'AccountId should not be 0' , False );
    Exit;
  end;
//  if DebitAmount = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'DebitAmount should not be 0' , False );
//    Exit;
//  end;
//  if CreditAmount = 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'CreditAmount should not be 0' , False );
//    Exit;
//  end;
  Result := True;
end;


function TAccountpostingDetail.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TAccountpostingDetail.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TAccountpostingDetail.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ClassId') then begin
    DeptClassName:= TDeptClass.IDToggle(Sender.AsInteger, self.Connection.Connection);
  end else if Sysutils.SameText(Sender.FieldName, 'ProductName') then begin
    ProductId:= GetProduct(ProductName);
    PartType:= GetProducttype(ProductID);
  end else if Sysutils.SameText(Sender.FieldName, 'ProductID') then begin
    Productname:= GetProduct(ProductID);
    PartType:= GetProducttype(ProductID);
  end  else if Sysutils.SameText(Sender.FieldName, 'DeptClassName') then begin
    ClassId:= TDeptClass.IDToggle(Sender.AsString, self.Connection.Connection);
  end  else if Sysutils.SameText(Sender.FieldName, 'AccountId') then begin
    AccountName:= TAccount.IDToggle(sender.AsInteger, self.Connection.Connection);
    AccountType:= TAccount.AccountTypeForAccount(sender.AsInteger, self.Connection.Connection);
  end  else if Sysutils.SameText(Sender.FieldName, 'AccountName') then begin
    AccountId:= TAccount.IDToggle(sender.AsString, self.Connection.Connection);
    AccountType:= TAccount.AccountTypeForAccount(sender.AsString, self.Connection.Connection);
  end  else if Sysutils.SameText(Sender.FieldName, 'AccountType') then begin

  end;
end;


function TAccountpostingDetail.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TAccountpostingDetail.GetIDField: string;
begin
  Result := 'AccountPostingDetailId'
end;


class function TAccountpostingDetail.GetBusObjectTablename: string;
begin
  Result:= 'tblaccountpostingdetail';
end;


function TAccountpostingDetail.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TAccountpostingDetail.GetAccountPostingId      : Integer   ; begin Result := GetIntegerField('AccountPostingId');end;
function  TAccountpostingDetail.GetSourceLineID          : Integer   ; begin Result := GetIntegerField('SourceLineID');end;
function  TAccountpostingDetail.GetClassID               : Integer   ; begin Result := GetIntegerField('ClassId');end;
function  TAccountpostingDetail.GetProductID             : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TAccountpostingDetail.GetDeptClassName         : string    ; begin Result := GetStringField('DeptClassName');end;
function  TAccountpostingDetail.GetProductname           : string    ; begin Result := GetStringField('Productname');end;
function  TAccountpostingDetail.GetParttype              : string    ; begin Result := GetStringField('Parttype');end;
function  TAccountpostingDetail.GetAccountId             : Integer   ; begin Result := GetIntegerField('AccountId');end;
function  TAccountpostingDetail.GetAccountName           : string    ; begin Result := GetStringField('AccountName');end;
function  TAccountpostingDetail.GetAccountType           : string    ; begin Result := GetStringField('AccountType');end;
function  TAccountpostingDetail.GetDebitAmount           : Double    ; begin Result := GetFloatField('DebitAmount');end;
function  TAccountpostingDetail.GetCreditAmount          : Double    ; begin Result := GetFloatField('CreditAmount');end;
function  TAccountpostingDetail.GetDescription           : string    ; begin Result := GetStringField('Description');end;
function  TAccountpostingDetail.GetCreditDebittype       : string    ; begin Result := GetStringField('CreditDebittype');end;
procedure TAccountpostingDetail.SetAccountPostingId      (const Value: Integer   ); begin SetIntegerField('AccountPostingId'   , Value);end;
procedure TAccountpostingDetail.SetSourceLineID          (const Value: Integer   ); begin SetIntegerField('SourceLineID'       , Value);end;
procedure TAccountpostingDetail.setClassID               (const Value: Integer   ); begin SetIntegerField('ClassId'            , Value);end;
procedure TAccountpostingDetail.SetProductID             (const Value: Integer   ); begin SetIntegerField('ProductID'            , Value);end;
procedure TAccountpostingDetail.SetDeptClassName         (const Value: string    ); begin SetStringField('DeptClassName'       , Value);end;
procedure TAccountpostingDetail.SetProductname           (const Value: string    ); begin SetStringField('Productname'         , Value);end;
procedure TAccountpostingDetail.SetParttype              (const Value: string    ); begin SetStringField('Parttype'         , Value);end;
procedure TAccountpostingDetail.SetAccountId             (const Value: Integer   ); begin SetIntegerField('AccountId'          , Value);end;
procedure TAccountpostingDetail.SetAccountName           (const Value: string    ); begin SetStringField('AccountName'         , Value);end;
procedure TAccountpostingDetail.SetAccountType           (const Value: string    ); begin SetStringField('AccountType'         , Value);end;
procedure TAccountpostingDetail.SetDebitAmount           (const Value: Double    ); begin SetFloatField('DebitAmount'          , Value);end;
procedure TAccountpostingDetail.SetCreditAmount          (const Value: Double    ); begin SetFloatField('CreditAmount'         , Value);end;
procedure TAccountpostingDetail.SetDescription           (const Value: string    ); begin SetStringField('Description'         , Value);end;
procedure TAccountpostingDetail.SetCreditDebittype       (const Value: string    ); begin SetStringField('CreditDebittype'     , Value);end;


function TAccountpostingDetail.GetId: integer;
begin
  result:= GetIntegerField('AccountPostingDetailId');
end;

procedure TAccountpostingDetail.InitializeNewObject;
begin
  inherited;
  if self.Id < 1 then begin
    if Owner is TAccountPosting then
      self.AccountPostingId:=  TAccountPosting(Owner).Id;
    self.PostDb;
  end;
end;

procedure TAccountpostingDetail.New;
begin
  inherited;
  InitializeNewObject;
end;

function TAccountpostingDetail.LocateId(const aId: integer): boolean;
begin
  result:= false;
  if Assigned(self.Dataset) and DataSet.Active then
    result:= DataSet.Locate(IDFieldName,aId,[]);
end;

initialization
  RegisterClass(TAccountpostingDetail);


end.
