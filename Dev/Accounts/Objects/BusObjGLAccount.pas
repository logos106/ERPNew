unit BusObjGLAccount;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 15/06/05  1.00.00 IJB  Initial version.


interface

uses
  BusObjBankCode, BusObjBase,DB,Classes, Contnrs, XMLDoc, XMLIntf, MyAccess,ERPdbComponents;

type

  TAccountType = class(TMSBusObj)
  private
    function GetAccountTypeId: integer;
    function GetAccountTypeName: string;
    function GetDescription: string;
    function GetOriginalDescription: string;
    function GetSortOrder: integer;
    procedure SetAccountTypeName(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetOriginalDescription(const Value: string);
    procedure SetSortOrder(const Value: integer);
  protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    function GetId: integer; override;
    function GetSQL: string; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    class function GetKeyStringField: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    property AccountTypeId: integer read GetAccountTypeId;
  Published
    property AccountTypeName: string read GetAccountTypeName write SetAccountTypeName;
    property Description: string read GetDescription write SetDescription;
    property OriginalDescription: string read GetOriginalDescription write SetOriginalDescription;
    property SortOrder: integer read GetSortOrder write SetSortOrder;
  end;

  TAccount = class(TMSBusObj)
  private
//    function GetAccountClass: string;
    function GetAccountGroup: string;
    function GetAccountId: integer;
    function GetAccountName: string;
    function GetAccountNumber: string;
    function GetAccountType: TAccountType;
    function GetAccountTypeName: string;
    function GetActive: boolean;
//    function GetAllClasses: boolean;
    function GetAPCANumber: string;
    function GeTaxCode: string;
    function GetBalance: double;
    function GetBankAccountName: string;
    function GetBankAccountNumber: string;
    function GetBankCode: string;
    function GetBankNumber: string;
    function GetBSB: string;
//    function GetClosingBalance: double;
//    function GetCredits: double;
//    function GetDebits: double;
//    function GetOpeningBalance: double;
    function GetDescription: string;
    function GetExtra: string;
    function GetIncludeBalanceRecord: boolean;
    function GetIncludeCreditTotal: boolean;
    function GetIncludeDebitTotal: boolean;
    function GetIncludeNetTotal: boolean;
    function GetLastChequeNo: integer;
    function GetUseLastChequeNo :Boolean;
    Function GetPreviouschequeno :Integer;
    function GetLevel1: string;
    function GetLevel2: string;
    function GetLevel3: string;
    function GetLevel4: string;
    function GetRequired: boolean;
    Function getAllowExpenseClaim :Boolean;
    Function getPublishOnVS1 :Boolean;

       // Wang
    Function GetCardNumber : string;
    Function GetExpiryDate : TDateTime;
    Function GetCVC : string;
    function GetReceiptCategory: string;

//    procedure SetAccountClass(const Value: string);
    procedure SetAccountGroup(const Value: string);
    procedure SetAccountId(const Value: integer);
    procedure SetAccountName(const Value: string);
    procedure SetAccountNumber(const Value: string);
    procedure SetAccountTypeName(const Value: string);
    procedure SetActive(const Value: boolean);
//    procedure SetAllClasses(const Value: boolean);
    procedure SetAPCANumber(const Value: string);
    procedure SetBankAccountName(const Value: string);
    procedure SetBankAccountNumber(const Value: string);
    procedure SetBankCode(const Value: string);
    procedure SetBankNumber(const Value: string);
    procedure SetBSB(const Value: string);
//    procedure SetClosingBalance(const Value: double);
//    procedure SetCredits(const Value: double);
//    procedure SetDebits(const Value: double);
//    procedure SetOpeningBalance(const Value: double);
    procedure SetDescription(const Value: string);
    procedure SetExtra(const Value: string);
    procedure SetIncludeBalanceRecord(const Value: boolean);
    procedure SetIncludeCreditTotal(const Value: boolean);
    procedure SetIncludeDebitTotal(const Value: boolean);
    procedure SetIncludeNetTotal(const Value: boolean);
    procedure SetLastChequeNo(const Value: integer);
    Procedure SetUseLastChequeNo(Const Value :Boolean);
    procedure SetNewChequeNo(const Value: integer);
    procedure SetLevel1(const Value: string);
    procedure SetLevel2(const Value: string);
    procedure SetLevel3(const Value: string);
    procedure SetLevel4(const Value: string);
    procedure SetRequired(const Value: boolean);
    Procedure SetAllowExpenseClaim(Const Value :Boolean);
    Procedure SetPublishOnVS1(Const Value :Boolean);
    procedure SetTaxCode(const Value: string);
    procedure SetBalance(const Value: double);

        // Wang
    procedure SetCardNumber(const Value: string);
    procedure SetExpiryDate(const Value: TDateTime);
    procedure SetCVC(const Value: string);
    procedure SetReceiptCategory(const Value: string);

    Function getIsAccountTypeBank :Boolean;
    function GetIsHeader: boolean;
    procedure SetIsHeader(const Value: boolean);
    function getBank_Code: TBankCode;
    function getBankName: String;
  protected
    fAccountType: TAccountType;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    function GetId: integer; override;
    function GetSQL: string; override;
    Function    ValidateXMLData(Const Node :IXMLNode) :Boolean ; override;
    Function  DoBeforeEdit(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveToXMLNode(Const Node: IXMLNode); override;
    procedure LoadFromXMLNode(Const Node: IXMLNode); override;
    function ValidateData :Boolean; Override;
    function ValidEFTAccount :Boolean;
    Property IsAccountTypeBank :Boolean read getIsAccountTypeBank;
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    class function GetKeyStringField: string; Override;
    Class function AccountTypeForAccount(const aAccountId: Integer; Connection: TCustomMyConnection = nil): string; overload;
    Class function AccountTypeForAccount(const aAccountName: string; Connection: TCustomMyConnection = nil): string; overload;
    class function AccountGroupIdListForAccount(const aAccountName: string; Connection: TCustomMyConnection = nil): string;
    class function AccountNameUnique(const aAccountId: Integer;
                                     const aAccountName: string;
                                     Connection: TCustomMyConnection = nil): boolean;
    class function AccountNumberUnique(const aAccountId: Integer;
                                     const aAccountNumber: string;
                                     Connection: TCustomMyConnection = nil): boolean;
    class function AccountIDForNumber(const aAccountNumber: string;
                                     Connection: TCustomMyConnection = nil): integer;
    class function AccountNameForNumber(const aAccountNumber: string;
                                     Connection: TCustomMyConnection = nil): string;
    class function AccountNumberForName(const aAccountName: string;
                                     Connection: TCustomMyConnection = nil): string;
    class function AccountNumberForID(const aAccountid: Integer;
                                     Connection: TCustomMyConnection = nil): string;
    function Save: boolean; override;
    property AccountId: integer read GetAccountId write SetAccountId;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    class function AccountInUse(const aAccountId: Integer; var TransType: string; Connection: TCustomMyConnection = nil): boolean;
    class function Inactivateallchildren(const aAccountname:String; Connection: TCustomMyConnection ; AOwner :TComponent ): boolean;
    class function ActivateallParents(const aAccountID:Integer; Connection: TCustomMyConnection ; AOwner :TComponent ): boolean;
    Property Bank_Code : TBankCode read getBank_Code;
    Property BankName:String read getBankName;
    Class Function MakeAccount(AOwner:TComponent; aCcountname,aAccountNumber,aCcounttype:String;CreateifnotExists:Boolean =False): Integer;
  Published
    property AccountName: string read GetAccountName write SetAccountName;
    property Description: string read GetDescription write SetDescription;
    property AccountTypeName: string read GetAccountTypeName write SetAccountTypeName;
    property AccountType: TAccountType read GetAccountType;
    property Balance: double read GetBalance write SetBalance;
    property AccountNumber: string read GetAccountNumber write SetAccountNumber;
    property TaxCode: string read GeTaxCode write SetTaxCode;
    property Extra: string read GetExtra write SetExtra;
    property AccountGroup: string read GetAccountGroup write SetAccountGroup;
    property Level1: string read GetLevel1 write SetLevel1;
    property Level2: string read GetLevel2 write SetLevel2;
    property Level3: string read GetLevel3 write SetLevel3;
    property Level4: string read GetLevel4 write SetLevel4;
    property BankNumber: string read GetBankNumber write SetBankNumber;
    property BSB: string read GetBSB write SetBSB;
    property BankAccountNumber: string read GetBankAccountNumber write SetBankAccountNumber;
    property BankAccountName: string read GetBankAccountName write SetBankAccountName;
    property BankCode: string read GetBankCode write SetBankCode;
    property LastChequeNo: integer read GetLastChequeNo write SetLastChequeNo;
    property UseLastChequeNo :Boolean Read getUseLastChequeNo Write setUseLastChequeNo;
    Property NewChequeNo : Integer write SetNewChequeNo; // used for the forms to update the last no
    Property PreviousChequeNo :Integer Read getPreviouschequeno;
    property APCANumber: string read GetAPCANumber write SetAPCANumber;
    property Required: boolean read GetRequired write SetRequired;
    property AllowExpenseClaim: boolean read GetAllowExpenseClaim write SetAllowExpenseClaim;
    property PublishOnVS1: boolean read GetPublishOnVS1 write SetPublishOnVS1;
    property IncludeBalanceRecord: boolean read GetIncludeBalanceRecord write SetIncludeBalanceRecord;
    property IncludeNetTotal: boolean read GetIncludeNetTotal write SetIncludeNetTotal;
    property IncludeCreditTotal: boolean read GetIncludeCreditTotal write SetIncludeCreditTotal;
    property IncludeDebitTotal: boolean read GetIncludeDebitTotal write SetIncludeDebitTotal;
    property IsHeader: boolean read GetIsHeader write SetIsHeader;
    property ReceiptCategory: string read GetReceiptCategory write SetReceiptCategory;
    property Active: boolean read GetActive write SetActive;

    {Wang}
    property CarNumber: string read GetCardNumber write SetCardNumber;
    property ExpiryDate: TDatetime read GetExpiryDate write SetExpiryDate;
    property CVC: string read GetCVC write SetCVC;

    (*  the following don't seem to be used any more
    property AccountClass: string read GetAccountClass write SetAccountClass;
    property AllClasses: boolean read GetAllClasses write SetAllClasses;
    property OpeningBalance: double read GetOpeningBalance write SetOpeningBalance;
    property Debits: double read GetDebits write SetDebits;
    property Credits: double read GetCredits write SetCredits;
    property ClosingBalance: double read GetClosingBalance write SetClosingBalance;
    *)
  end;

implementation

uses
  SysUtils, tcDataUtils,  AppEnvironment, CommonLib, CommonDbLib,
  IntegerListObj, tcConst, BusObjTaxCodes, BusObjectListObj, BusObjSchemaLib,
  DbSharedObjectsObj;

 { TAccountType }

constructor TAccountType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblAccTypeDesc';
  ExportExcludeList.Add('accounttypeid');
end;

destructor TAccountType.Destroy;
begin
  inherited;
end;

procedure TAccountType.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAccountType.GetAccountTypeId: integer;
begin
  Result := GetIntegerField('TypeId');
end;

function TAccountType.GetAccountTypeName: string;
begin
  Result := GetStringField('AccType');
end;

function TAccountType.GetDescription: string;
begin
  Result := GetStringField('AccDesc');
end;

function TAccountType.GetId: integer;
begin
  Result := AccountTypeId;
end;
class function TAccountType.GetBusObjectTablename: string;
begin
  Result := 'tblAccTypeDesc';
end;

class Function TAccountType.GetIDField :String ;
begin
    Result :='TypeId';
end;

function TAccountType.GetOriginalDescription: string;
begin
  Result := GetStringField('OriginalDesc');
end;

function TAccountType.GetSortOrder: integer;
begin
  Result := GetIntegerField('SortOrder');
end;

function TAccountType.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TAccountType.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAccountType.SetAccountTypeName(const Value: string);
begin
  SetStringField('AccType', Value);
end;

procedure TAccountType.SetDescription(const Value: string);
begin
  SetStringField('AccDesc', Value);
end;

procedure TAccountType.SetOriginalDescription(const Value: string);
begin
  SetStringField('OriginalDesc', Value);
end;

procedure TAccountType.SetSortOrder(const Value: integer);
begin
  SetIntegerField('SortOrder', Value);
end;


 class function TAccountType._Schema: string;
begin
  result:= inherited;
end;

class function TAccountType.GetKeyStringField: string;
begin
  result:= 'AccType';
end;

class function TAccountType.GetKeyStringProperty: string;
begin
  result:= 'AccountTypeName';
end;

{ TAccount }

constructor TAccount.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblChartOfAccounts';
  fAccountType := nil;
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('previouschequeno');
  //ExportExcludeList.Add('balance');
  ExportExcludeList.Add('accounttype');
end;

destructor TAccount.Destroy;
begin
  inherited;
end;

function TAccount.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  PublishOnVS1 := False;
end;

function TAccount.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
end;

function TAccount.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoBeforeInsert(Sender);
  if not result then exit;
end;

function TAccount.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
end;

procedure TAccount.DoFieldOnChange(Sender: TField);

  procedure BuildAccountGroup;
  var s: string;
  begin
    s:= '';
    if (Level1 <> '') and (Level2 <> '') then s:= Level1;
    if (Level2 <> '') and (Level3 <> '') then s:= s + '^' + Level2;
    if (Level3 <> '') and (Level4 <> '') then s:= s + '^' + Level3;
    AccountGroup:= s;
  end;

begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'AccountName') then begin
    if not RawMode then begin
      if Level1 = '' then Level1:= Sender.AsString
      else if (Level2 = '') and (Level1 <> Sender.AsString) then Level2:= Sender.AsString
      else if (Level3 = '') and (Level2 <> Sender.AsString) then Level3:= Sender.AsString
      else if (Level4 = '') and (Level3 <> Sender.AsString) then Level4:= Sender.AsString;
      BuildAccountGroup;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'Level1') then begin
    if not RawMode then begin
      BuildAccountGroup;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'Level2') then begin
    if not RawMode then begin
      BuildAccountGroup;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'Level3') then begin
    if not RawMode then begin
      BuildAccountGroup;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'Level4') then begin
    if not RawMode then begin
      BuildAccountGroup;
    end;
  end
end;

//function TAccount.GetAccountClass: string;
//begin
//  Result := GetStringField('Class');
//end;

function TAccount.GetAccountGroup: string;
begin
  Result := GetStringField('AccountGroup');
end;

function TAccount.GetAccountId: integer;
begin
  Result := GetIntegerField('AccountId');
end;

function TAccount.GetAccountName: string;
begin
  Result := GetStringField('AccountName');
end;

function TAccount.GetAccountNumber: string;
begin
  Result := GetStringField('AccountNumber');
end;

function TAccount.GetAccountType: TAccountType;
begin
  if not Assigned(fAccountType) then fAccountType := TAccountType.Create(self);
  if fAccountType.GetAccountTypeName <> AccountTypeName then
    fAccountType.LoadSelect('AccType = ' + QuotedStr(AccountTypeName));
  Result := fAccountType;
end;

function TAccount.GetAccountTypeName: string;
begin
  Result := GetStringField('AccountType');
end;

function TAccount.GetActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

//function TAccount.GetAllClasses: boolean;
//begin
//  Result := GetBooleanField('AllClasses');
//end;

function TAccount.GetAPCANumber: string;
begin
  Result := GetStringField('APCANo');
end;

function TAccount.GeTaxCode: string;
begin
  Result := GetStringField('TaxCode');
end;

function TAccount.GetBalance: double;
begin
  Result := GetFloatField('Balance');
end;

function TAccount.GetBankAccountName: string;
begin
  Result := GetStringField('BankAccountName');
end;

function TAccount.GetBankAccountNumber: string;
begin
  Result := GetStringField('BankAccountNumber');
end;

function TAccount.GetBankCode: string;
begin
  Result := GetStringField('BankCode');
end;

function TAccount.getBankName: String;
begin
  REsult:= Bank_code.BankName;
end;

function TAccount.GetBankNumber: string;
begin
  Result := GetStringField('BankNumber');
end;

function TAccount.getBank_Code: TBankCode;
begin
  Result := TBankCode(Getcontainercomponent(TBankCode ,'BankCode = ' + quotedStr(Self.BankCode) ));
end;

function TAccount.GetBSB: string;
begin
  Result := GetStringField('BSB');
end;

//function TAccount.GetClosingBalance: double;
//begin
//  Result := GetFloatField('ClosingBalance');
//end;

//function TAccount.GetCredits: double;
//begin
//  Result := GetFloatField('Credits');
//end;

//function TAccount.GetDebits: double;
//begin
//  Result := GetFloatField('Debits');
//end;

function TAccount.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TAccount.GetExtra: string;
begin
  Result := GetStringField('Extra');
end;

function TAccount.GetId: integer;
begin
  Result := AccountId;
end;
class function TAccount.GetBusObjectTablename: string;
begin
  Result := 'tblChartOfAccounts';
end;

class Function TAccount.GetIDField :String ;
begin
    Result :='AccountID';
end;

function TAccount.GetIncludeBalanceRecord: boolean;
begin
  Result := GetBooleanField('IncludeBalanceRecord');
end;

function TAccount.GetIncludeCreditTotal: boolean;
begin
  Result := GetBooleanField('IncludeCreditTotal');
end;

function TAccount.GetIncludeDebitTotal: boolean;
begin
  Result := GetBooleanField('IncludeDebitTotal');
end;

function TAccount.GetIncludeNetTotal: boolean;
begin
  Result := GetBooleanField('IncludeNetTotal');
end;
Function TAccount.GetUseLastChequeNo :Boolean ;
begin
    REsult := GetBooleanfield('UseLastChequeNo');
end;
function TAccount.GetLastChequeNo: integer;
begin
  Result := GetIntegerField('LastChequeNo');
end;
Function TAccount.GetPreviousChequeNo:Integer;
var
    //strSQL          : String;
    ChequeMax       : Integer;
    SuppPayChequeMax: Integer;
    SuppPrePayChequeMax :Integer;
    qry :TERPQuery;
    function getChequeMax: Integer;
    begin
      if Qry.Active then Qry.Close;
      Qry.SQL.text :=   ' SELECT Max(TRUNCATE(InvoiceNumber,0)) as ChequeLastNumber FROM tblpurchaseorders WHERE IsCheque="T" AND cancelled="F" AND AccountID=' + IntToStr(ID);
      Qry.Open;Result := Qry.FieldByname('ChequeLastNumber').asInteger;
    end;
    function getSuppPayChequeMax: Integer;
    begin
      if Qry.Active then Qry.Close;
      Qry.SQL.text :=   ' SELECT Max(TRUNCATE(W.ReferenceNo,0)) as ChequeLastNumber '+
                        ' FROM tblwithdrawal W  '+
                        ' inner join tblpaymentmethods PM on PM.PayMethodID = W.PayMethodID and PM.NAME ="Cheque"   '+
                        ' WHERE W.AccountID=' + IntToStr(ID);
      Qry.Open;Result := Qry.FieldByname('ChequeLastNumber').asInteger;
    End;
    function getSuppPrePayChequeMax: Integer;
    begin
      if Qry.Active then Qry.Close;
      Qry.SQL.text :=   ' SELECT Max(TRUNCATE(ReferenceNo,0)) as ChequeLastNumber  '+
                        ' FROM tblprepayments PP '+
                        ' inner join tblpaymentmethods PM on PM.PayMethodID = PP.PayMethodID and PM.NAME ="Cheque"  '+
                        ' where Supplier="T" and bankaccountId = ' + IntToStr(ID);
      Qry.Open;Result := Qry.FieldByname('ChequeLastNumber').asInteger;
    End;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    ChequeMax           := getChequeMax;
    SuppPayChequeMax    := getSuppPayChequeMax;
    SuppPrePayChequeMax := getSuppPrePayChequeMax;
    if UseLastChequeNo then
        Result := LastChequeNo
    else begin
        result := LastChequeNo;
        if result < chequemax           then Result := chequemax;
        if result < SuppPayChequeMax    then Result := SuppPayChequeMax;
        if result < SuppPrePayChequeMax then Result := SuppPrePayChequeMax;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TAccount.GetLevel1: string;
begin
  Result := GetStringField('Level1');
end;

function TAccount.GetLevel2: string;
begin
  Result := GetStringField('Level2');
end;

function TAccount.GetLevel3: string;
begin
  Result := GetStringField('Level3');
end;

function TAccount.GetLevel4: string;
begin
  Result := GetStringField('Level4');
end;

//function TAccount.GetOpeningBalance: double;
//begin
//  Result := GetFloatField('OpeningBalance');
//end;

function TAccount.GetRequired: boolean;
begin
  Result := GetBooleanField('Required');
end;
function TAccount.GetAllowExpenseClaim: boolean;
begin
  Result := GetBooleanField('AllowExpenseClaim');
end;
function TAccount.GetPublishOnVS1: boolean;
begin
  Result := GetBooleanField('PublishOnVS1');
end;

function TAccount.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TAccount.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fAccountType) then FreeAndNil(fAccountType);
//  if Assigned(fAccountclasses) then FreeAndNil(fAccountclasses);
end;

//procedure TAccount.SetAccountClass(const Value: string);
//begin
//  SetStringField('Class', Value);
//end;

procedure TAccount.SetAccountGroup(const Value: string);
begin
  SetStringField('AccountGroup', Value);
end;

procedure TAccount.SetAccountId(const Value: integer);
begin
    SetIntegerField('AccountID', Value);
end;

procedure TAccount.SetAccountName(const Value: string);
begin
    SetStringField('AccountName', Value);
end;

procedure TAccount.SetAccountNumber(const Value: string);
begin
    SetStringField('AccountNumber', Value);
end;

procedure TAccount.SetAccountTypeName(const Value: string);
begin
    SetStringField('Accounttype', Value);
end;

procedure TAccount.SetActive(const Value: boolean);
begin
    SetBooleanField('Active', Value);
end;

//procedure TAccount.SetAllClasses(const Value: boolean);
//begin
//    SetBooleanField('Allclasses', Value);
//end;

procedure TAccount.SetAPCANumber(const Value: string);
begin
    SetStringField('APCANo', Value);
end;

procedure TAccount.SetBalance(const Value: double);
begin
    SetFloatField('Balance', Value);
end;

procedure TAccount.SetBankAccountName(const Value: string);
begin
    SetStringField('BankAccountName', Value);
end;

procedure TAccount.SetBankAccountNumber(const Value: string);
begin
    SetStringField('BankAccountNumber', Value);
end;

procedure TAccount.SetBankCode(const Value: string);
begin
    SetStringField('BankCode', Value);
end;

procedure TAccount.SetBankNumber(const Value: string);
begin
    SetStringField('BankNumber', Value);
end;

procedure TAccount.SetBSB(const Value: string);
begin
    SetStringField('BSB', Value);
end;

//procedure TAccount.SetClosingBalance(const Value: double);
//begin
//    SetFloatField('ClosingBalance', Value);
//end;

//procedure TAccount.SetCredits(const Value: double);
//begin
//    SetFloatField('Credits', Value);
//end;

//procedure TAccount.SetDebits(const Value: double);
//begin
//    SetFloatField('Debits', Value);
//end;

// Wang
function TAccount.GetCardNumber: string;
begin
  Result := GetStringField('CardNumber');
end;

function TAccount.GetExpiryDate: TDateTime;
begin
  Result := GetDateTimeField('ExpiryDate');
end;

function TAccount.GetCVC: string;
begin
  Result := GetStringField('CVC');
end;

// Wang
procedure TAccount.SetCardNumber(const Value: string);
begin
  SetStringField('CardNumber', Value);
end;

procedure TAccount.SetExpiryDate(const Value: TDateTime);
begin
  SetDateTimeField('ExpiryDate', Value);
end;

procedure TAccount.SetCVC(const Value: string);
begin
  SetStringField('CVC', Value);
end;

procedure TAccount.SetDescription(const Value: string);
begin
    SetStringField('Description', Value);
end;

procedure TAccount.SetExtra(const Value: string);
begin
    SetStringField('Extra', Value);
end;

procedure TAccount.SetIncludeBalanceRecord(const Value: boolean);
begin
    SetBooleanField('IncludeBalanceRecord', Value);
end;

procedure TAccount.SetIncludeCreditTotal(const Value: boolean);
begin
    SetBooleanField('IncludeCreditTotal', Value);
end;

procedure TAccount.SetIncludeDebitTotal(const Value: boolean);
begin
    SetBooleanField('IncludeDebitTotal', Value);
end;

procedure TAccount.SetIncludeNetTotal(const Value: boolean);
begin
    SetBooleanField('IncludeNetTotal', Value);
end;
procedure TAccount.SetNewChequeNo(const Value: integer);
begin
{binny : cheque and payment forms calls this property to update the last chequeno.
this property udpates the field only if the current value is less than the new value.
LstChequeno updates the field even though its less than the current value}
    if LastChequeNo < Value then
        SetIntegerField('LastChequeNo', Value);
end;
Procedure TAccount.SetUseLastChequeNo(const Value :Boolean);
begin
    SetBooleanfield('UseLastChequeNo' , Value);
end;
procedure TAccount.SetLastChequeNo(const Value: integer);
begin
    SetIntegerField('LastChequeNo', Value);
end;

procedure TAccount.SetLevel1(const Value: string);
begin
    SetStringField('Level1', Value);
end;

procedure TAccount.SetLevel2(const Value: string);
begin
    SetStringField('Level2', Value);
end;

procedure TAccount.SetLevel3(const Value: string);
begin
    SetStringField('Level3', Value);
end;

procedure TAccount.SetLevel4(const Value: string);
begin
    SetStringField('Level4', Value);
end;

//procedure TAccount.SetOpeningBalance(const Value: double);
//begin
//    SetFloatField('OpeningBalance', Value);
//end;

procedure TAccount.SetRequired(const Value: boolean);
begin
    SetBooleanField('Required', Value);
end;
procedure TAccount.SetAllowExpenseClaim(const Value: boolean);
begin
    SetBooleanField('AllowExpenseClaim', Value);
end;
procedure TAccount.SetPublishOnVS1(const Value: boolean);
begin
    SetBooleanField('PublishOnVS1', Value);
end;

procedure TAccount.SetTaxCode(const Value: string);
begin
    SetStringField('TaxCode', Value);
end;

Function TAccount.getIsAccountTypeBank   : Boolean;
begin
  Result:= (AccountTypeName = ACCOUNT_TYPE_BANK) or (AccountTypeName = ACCOUNT_TYPE_CREDIT_CARD);
end;

Function    TAccount.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDESC := 'AccountName = ' + quotedStr( GetXMLNodeStringValue(Node, 'AccountName'));
    Result := False;
    if GetXMLNodeStringValue(Node, 'AccountTypeName') <> '' then
        if GetAccountTypeID(GetXMLNodeStringValue(Node, 'AccountTypeName')) = 0 then begin
                ErrRecordNotfound('Account Type' , GetXMLNodeStringValue(Node, 'AccountTypeName'));
                Exit;
        end;
    if GetXMLNodeStringValue(Node, 'Level3') <> '' then
        if GetXMLNodeStringValue(Node, 'Level3') <> GetXMLNodeStringValue(Node, 'AccountName') then begin
            if GetAccountHeaderID(GetXMLNodeStringValue(Node, 'AccountTypeName') , GetXMLNodeStringValue(Node, 'Level3')) = 0 then begin
                ErrRecordNotfound('Level3' , GetXMLNodeStringValue(Node, 'Level3'));
                Exit;
            end;
        end;
    if GetXMLNodeStringValue(Node, 'Level2') <> '' then
        if GetXMLNodeStringValue(Node, 'Level2') <> GetXMLNodeStringValue(Node, 'AccountName') then begin
            if GetAccountHeaderID(GetXMLNodeStringValue(Node, 'AccountTypeName') , GetXMLNodeStringValue(Node, 'Level2')) = 0 then begin
                ErrRecordNotfound('Level2' , GetXMLNodeStringValue(Node, 'Level2'));
                Exit;
            end;
        End;
    if GetXMLNodeStringValue(Node, 'Level1') <> '' then
        if GetXMLNodeStringValue(Node, 'Level1') <> GetXMLNodeStringValue(Node, 'AccountName') then begin
            if GetAccountHeaderID(GetXMLNodeStringValue(Node, 'AccountTypeName') , GetXMLNodeStringValue(Node, 'Level1')) = 0 then begin
                ErrRecordNotfound('Level1' , GetXMLNodeStringValue(Node, 'Level1'));
                Exit;
            end;
        end;
    if GetXMLNodeStringValue(Node, 'TaxCode') <> '' then
        if getTaxcodeID(GetXMLNodeStringValue(Node, 'TaxCode') ) = 0 then begin
            ErrRecordNotfound('TaxCode' , GetXMLNodeStringValue(Node, 'TaxCode'));
            Exit;
        end;
    if GetXMLNodeStringValue(Node, 'Bankcode') <> '' then
        if getBankCodeID(GetXMLNodeStringValue(Node, 'BankCode'), AppEnv.RegionalOptions.ID ) = 0 then begin
            ErrRecordNotfound('BankCode' , GetXMLNodeStringValue(Node, 'BankCode'));
            Exit;
        end;
    Result := True;
{Duplicate records}
    XMLSearchRecord := 'AccountName = ' + quotedStr( GetXMLNodeStringValue(Node, 'AccountName'));
    LocateXMLRecord;
end;

function TAccount.ValidEFTAccount :Boolean;
begin
    result := (not Empty(BankAccountName)) and
                (not Empty(BSB)) and
                (not Empty(BankAccountNumber));

end;

class function TAccount._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccountType','AccountType','AccountTypeName','AccountTypeName');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCodeObj','TaxCode','CodeName');
end;

function TAccount.ValidateData :Boolean;
var
  CleanAccountTypeName,
  CleanAccountName: string;
  AcctType: string;
begin
  result := inherited ValidateData;
  if not result then Exit;

  Result := False;
  if AccountName = '' then begin
    AddResult(false, rssWarning, 0, 'Account name should not be blank' );
    Exit;
  end;
  if AccountTypeName  = '' then begin
    AddResult(false, rssWarning, 0, 'Account type should not be blank' );
    Exit;
  end;
  if TAccountType.IDToggle(AccountTypeName,Connection.Connection) < 1 then begin
    AddResult(false, rssWarning, 0, 'Invalid Account Type "' + AccountTypeName + '"');
    Exit;
  end;
  if not self.AccountNameUnique(ID,AccountName,Connection.Connection) then begin
    AddResult(false, rssWarning, 0, 'Account Name has already been used' );
    Exit;
  end;
  if not self.AccountNumberUnique(ID,AccountName,Connection.Connection) then begin
    AddResult(false, rssWarning, 0, 'Account Number has already been used' );
    Exit;
  end;
  CleanAccountTypeName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'AccountTypeName');
  CleanAccountName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'AccountName');
  if (CleanAccountTypeName <> '') and (CleanAccountTypeName <> AccountTypeName) then begin
    AddResult(false, rssWarning, 0, 'Account Type of "' + CleanAccountTypeName +
      '" can not be changed to "' + AccountTypeName + '" for an existiong Account');
    Exit;
  end;
  if (CleanAccountName <> '') and (CleanAccountName <> AccountName) then begin
    AddResult(false, rssWarning, 0, 'Account Name "' + CleanAccountName +
      '" can not be changed to "' + AccountName + '" for an existiong record');
    Exit;
  end;

  if (Level1 <> '') and (Level2 <> '') then begin
    AcctType := AccountTypeForAccount(Level1,Connection.Connection);
    if (AcctType = '') then begin
      AddResult(false, rssWarning, 0, 'Level1 Account "' + Level1 + '" does not exist, create this before creating sup-accounts.' );
      Exit;
    end;
    if(AcctType <> self.AccountTypeName) then begin
      AddResult(false, rssWarning, 0, 'Level1 Account Type "'+AcctType+'" does not match new Account Account Type "' + AccountTypeName+ '"' );
      Exit;
    end;
  end;

  if (Level2 <> '') and (Level3 <> '') then begin
    AcctType := AccountTypeForAccount(Level2,Connection.Connection);
    if (AcctType = '') then begin
      AddResult(false, rssWarning, 0, 'Level2 Account Type "'+AcctType+'" does not match new Account Account Type "' + AccountTypeName+ '"' );
      Exit;
    end;
    if (AcctType <> self.AccountTypeName) then begin
      AddResult(false, rssWarning, 0, 'Level2 Account Type does not match selected Account Type' );
      Exit;
    end;
  end;

  if (Level3 <> '') and (Level4 <> '') then begin
    AcctType := AccountTypeForAccount(Level3,Connection.Connection);
    if (AcctType = '') then begin
      AddResult(false, rssWarning, 0, 'Level3 Account "' + Level3 + '" does not exist, create this before creating sup-accounts.' );
      Exit;
    end;
    if (AcctType <> self.AccountTypeName) then begin
      AddResult(false, rssWarning, 0, 'Level3 Account Type "'+AcctType+'" does not match new Account Account Type "' + AccountTypeName+ '"' );
      Exit;
    end;
  end;

  if IsAccountTypeBank then begin
    if (BankCode <> '') and (TBankCode.IDToggle(BankCode,Connection.Connection) < 1) then begin
      AddResult(false, rssWarning, 0, 'Bank Code is invalid');
      Exit;
    end;
  end
  else begin
    if self.BankAccountName <> '' then begin
      AddResult(false, rssWarning, 0, 'Bank Account Name specified for non-Bank type account');
      Exit;
    end;
    if (self.BankNumber <> '') and (self.BankNumber <> '0') then begin
      AddResult(false, rssWarning, 0, AppEnv.RegionalOptions.BSBName + ' specified for non-Bank type account');
      Exit;
    end;
    if self.BankAccountNumber <> '' then begin
      AddResult(false, rssWarning, 0, 'Bank Account No specified for non-Bank type account');
      Exit;
    end;
    if self.BankCode <> '' then begin
      AddResult(false, rssWarning, 0, 'Bank Code specified for non-Bank type account');
      Exit;
    end;
  end;
  if (not Active) then begin
    if Required then begin
      AddResult(false, rssWarning, 0, AccountName + ' is a "Required" account, it can not be made inactive');
      Exit;
    end
    else if self.Balance > 0 then begin
      AddResult(false, rssWarning, 0, 'This is account has a non-zero balance, it can not be made inactive');
      Exit;
    end;
  end;
  if (TaxCode <> '') and (TTaxCode.IDToggle(TaxCode,Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID)) < 1) then begin
    AddResult(false, rssWarning, 0, 'Invalid tax code "' + TaxCode + '"');
    Exit;
  end;
  if (Level2 <> '') and ((Level1 = '')) then begin
    AddResult(False, rssWarning, 0, 'Level 1 can not be blank when Level 2 has a value');
    Exit;
  end;
  if (Level3 <> '') and (Level2 = '') then begin
    AddResult(False, rssWarning, 0, 'Level 2 can not be blank when Level 3 has a value');
    Exit;
  end;
  if (Level4 <> '') and (Level3 = '') then begin
    AddResult(False, rssWarning, 0, 'Level 3 can not be blank when Level 4 has a value');
    Exit;
  end;

  result := True;
end;

procedure TAccount.LoadFromXMLNode(Const Node: IXMLNode);
begin
    Inherited;
    SetPropertyFromNode(Node, 'AccountName'        );
    SetPropertyFromNode(Node, 'Description'        );
    SetPropertyFromNode(Node, 'AccountTypeName'    );
    SetPropertyFromNode(Node, 'AccountNumber'      );
    SetPropertyFromNode(Node, 'Extra'              );
    SetPropertyFromNode(Node, 'AccountGroup'       );
    SetPropertyFromNode(Node, 'Level1'             );
    SetPropertyFromNode(Node, 'Level2'             );
    SetPropertyFromNode(Node, 'Level3'             );
    SetPropertyFromNode(Node, 'Level4'             );
    SetPropertyFromNode(Node, 'BankNumber'         );
    SetPropertyFromNode(Node, 'BSB'                );
    SetPropertyFromNode(Node, 'BankAccountNumber'  );
    SetPropertyFromNode(Node, 'BankAccountName'    );
    SetPropertyFromNode(Node, 'BankCode'           );
    SetPropertyFromNode(Node, 'APCANumber'         );
    SetPropertyFromNode(Node,  'Balance'            );
    SetPropertyFromNode(Node, 'TaxCode'            );
//    SetPropertyFromNode(Node,  'OpeningBalance'     );
//    SetPropertyFromNode(Node,  'Debits'             );
//    SetPropertyFromNode(Node,  'Credits'            );
//    SetPropertyFromNode(Node,  'ClosingBalance'     );
//    SetPropertyFromNode(Node, 'AccountClass'       );
//    SetBooleanPropertyFromNode(Node,'AllClasses'         );
    SetBooleanPropertyFromNode(Node,'Required'           );
    SetBooleanPropertyFromNode(Node,'AllowExpenseClaim'           );
    SetBooleanPropertyFromNode(Node,'PublishOnVS1'           );
    SetBooleanPropertyFromNode(Node,'IncludeBalanceRecord');
    SetBooleanPropertyFromNode(Node,'IncludeNetTotal'    );
    SetBooleanPropertyFromNode(Node,'IncludeCreditTotal' );
    SetBooleanPropertyFromNode(Node,'IncludeDebitTotal'  );
    SetBooleanPropertyFromNode(Node,'Active'             );
    SetPropertyFromNode(Node,'LastChequeNo'   );
end;
class function TAccount.MakeAccount(AOwner: TComponent; aCcountname,aAccountNumber,aCcounttype: String; CreateifnotExists: Boolean): Integer;
var
  Account :TAccount;
begin
  Result := 0;
  if aCcountname = '' then exit;
  Account:= TAccount.CreateWithNewConn(AOwner);
  try
    Account.LoadSelect('AccountName =' + Quotedstr(aCcountname));
    if Account.count =0 then begin
      Account.New;
      Account.AccountTypeName := aCcounttype;
      Account.AccountName     := aCcountname;
      Account.AccountNumber   := aAccountNumber;
      Account.active := True;
      Account.PostDB;
    end;
    Result := Account.ID;
  finally
    Freeandnil(Account);
  end;
end;

procedure TAccount.SaveToXMLNode(Const Node: IXMLNode);
begin
    Inherited;
    AddXMLNode(node , 'AccountName'         , AccountName       	);
    AddXMLNode(node , 'Description'         , Description       	);
    AddXMLNode(node , 'AccountTypeName'     , AccountTypeName   	);
    AddXMLNode(node , 'Balance'         	, Balance           	);
    AddXMLNode(node , 'AccountNumber'   	, AccountNumber     	);
    AddXMLNode(node , 'TaxCode'         	, TaxCode             	);
    AddXMLNode(node , 'Extra'           	, Extra               	);
//    AddXMLNode(node , 'AccountClass'    	, AccountClass        	);
//    AddXMLNode(node , 'AllClasses'      	, AllClasses        	);
//    AddXMLNode(node , 'OpeningBalance'  	, OpeningBalance    	);
//    AddXMLNode(node , 'Debits'          	, Debits            	);
//    AddXMLNode(node , 'Credits'         	, Credits           	);
//    AddXMLNode(node , 'ClosingBalance'  	, ClosingBalance    	);
    AddXMLNode(node , 'AccountGroup'    	, AccountGroup      	);
    AddXMLNode(node , 'Level1'          	, Level1            	);
    AddXMLNode(node , 'Level2'          	, Level2            	);
    AddXMLNode(node , 'Level3'          	, Level3            	);
    AddXMLNode(node , 'Level4'          	, Level4            	);
    AddXMLNode(node , 'BankNumber'      	, BankNumber        	);
    AddXMLNode(node , 'BSB'             	, BSB               	);
    AddXMLNode(node , 'BankAccountNumber'	, BankAccountNumber 	);
    AddXMLNode(node , 'BankAccountName' 	, BankAccountName   	);
    AddXMLNode(node , 'BankCode'        	, BankCode          	);
    AddXMLNode(node , 'LastChequeNo'	    , LastChequeNo  	);
    AddXMLNode(node , 'APCANumber'      	, APCANumber        	);
    AddXMLNode(node , 'Required'        	, Required          	);
    AddXMLNode(node , 'AllowExpenseClaim'   , AllowExpenseClaim   	);
    AddXMLNode(node , 'PublishOnVS1'   , PublishOnVS1   	);
    AddXMLNode(node , 'IncludeBalanceRecord', IncludeBalanceRecord	);
    AddXMLNode(node , 'IncludeNetTotal' 	, IncludeNetTotal   	);
    AddXMLNode(node , 'IncludeCreditTotal'	, IncludeCreditTotal	);
    AddXMLNode(node , 'IncludeDebitTotal'	, IncludeDebitTotal 	);
    AddXMLNode(node , 'Active'          	, Active            	);
    (*if not SavingXMLTofile then exit;*)
    ExportsubClasses(node);
end;
class function TAccount.GetKeyStringField: string;
begin
  Result := 'AccountName';
end;

class function TAccount.GetKeyStringProperty: string;
begin
  result:= 'AccountName';
end;

class function TAccount.AccountTypeForAccount(const aAccountId: Integer; Connection: TCustomMyConnection = nil): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select AccountType from tblChartOfAccounts where AccountId = ' + IntToStr(aAccountId);
    qry.Open;
    result:= qry.fieldByName('AccountType').AsString;
  finally
    qry.Free;
  end;
end;

class function TAccount.AccountTypeForAccount(const aAccountName: string; Connection: TCustomMyConnection = nil): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select AccountType from tblChartOfAccounts where AccountNAme = ' + QuotedStr(aAccountName);
    qry.Open;
    result:= qry.fieldByName('AccountType').AsString;
  finally
    qry.Free;
  end;
end;

class function TAccount.AccountGroupIdListForAccount(
  const aAccountName: string; Connection: TCustomMyConnection): string;
var
  qry: TMyQuery;
  aName: string;
  IdList: TIntegerList;
begin
  qry:= TMyQuery.Create(nil);
  IdList:= TIntegerList.Create;
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AccountGroup from tblChartOfAccounts');
    qry.SQL.Add('where AccountName = ' + QuotedStr(aAccountName));
    qry.Open;
    if qry.FieldByName('AccountGroup').AsString <> '' then
      aName:= qry.FieldByName('AccountGroup').AsString
    else
      aName:= aAccountName;
    qry.Close;

    qry.SQL.Clear;
    qry.SQL.Add('select AccountID from tblChartOfAccounts');
    qry.SQL.Add('where AccountName = ' + QuotedStr(aName));
    qry.SQL.Add('or AccountGroup = ' + QuotedStr(aName));
    qry.Open;
    while not qry.Eof do begin
      IdList.Add(qry.FieldByName('AccountId').AsInteger);
      qry.Next;
    end;
    result:= IdList.CommaText;
  finally
    qry.Free;
    IdList.Free;
  end;
end;

class function TAccount.AccountIDForNumber(const aAccountNumber: string;
  Connection: TCustomMyConnection): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AccountID from tblChartOfAccounts');
    qry.SQL.Add('where AccountNumber = ' + QuotedStr(aAccountNumber));
    qry.Open;
    result:= qry.FieldByName('AccountID').AsInteger;
  finally
    qry.Free;
  end;
end;
class function TAccount.ActivateallParents(const aAccountID:Integer; Connection: TCustomMyConnection ; AOwner :TComponent ): boolean;
var
  Accountobj :TAccount;
  accountnames:String;
  aAccountname:String;
  s:String;
begin
  REsult := TRue;
  Accountobj := TAccount.CreateWithNewConn(AOwner);
  Try
    Accountobj.connection.connection :=connection;
    Accountobj.Load(AAccountId);
    if Accountobj.count =0 then exit;
    aAccountname:=Accountobj.AccountName;
    Accountobj.connection.BeginNestedTransaction;
    try
      s:= '';
      if (Accountobj.Level3<>'') and (Accountobj.Level3 <> Accountobj.Accountname) then begin s:= 'Accountname = ' +quotedstr(Accountobj.Level3); end;
      if (Accountobj.Level2<>'') and (Accountobj.Level2 <> Accountobj.Accountname) then begin if s<> ''  then s:= s +' or ' ;s:= s+ 'Accountname = ' +quotedstr(Accountobj.Level2); end;
      if (Accountobj.Level1<>'') and (Accountobj.Level1 <> Accountobj.Accountname) then begin if s<> ''  then s:= s +' or ' ;s:= s+ 'Accountname = ' +quotedstr(Accountobj.Level1); end;
      if s= '' then exit;
      Accountobj.LoadSelect(s);
      if Accountobj.count =0 then exit;
      Accountobj.first;
      accountnames:= '';
      While Accountobj.eof = False do begin
        Accountobj.Active := true;
        Accountobj.PostDB;
        if accountnames <> '' then accountnames := accountnames +',';
        accountnames := accountnames + Quotedstr(Accountobj.accountname);
        Accountobj.Next;
      end;
      REsult := True;
    finally
      if not result then
        Accountobj.connection.RollbackNestedTransaction
      else begin
        if Accountnames <> '' then
          Accountobj.ResultStatus.AddItem(false,rssError,0,'Re-activating Account '+Quotedstr(aAccountname)+' will Re-activate all it''s Parent accounts '+ NL+ Accountnames , true);
        Accountobj.connection.CommitNestedTransaction;
      end;
    end;
  Finally
    Freeandnil(Accountobj);
  End;

end;
class function TAccount.Inactivateallchildren(const aAccountname:String; Connection: TCustomMyConnection ; AOwner :TComponent ): boolean;
var
  Accountobj :TAccount;
  accountnames:String;
begin
  REsult := TRue;
  Accountobj := TAccount.CreateWithNewConn(AOwner);
  Try
    Accountobj.connection.connection :=connection;
    Accountobj.LoadSelect('accountname <>  ' + quotedstr(aAccountname)+
                          '  and ((Level1 =  ' + quotedstr(aAccountname)+' )  '+
                          ' or (Level2 =  ' + quotedstr(aAccountname)+'  )  '+
                          ' or (Level3 =  ' + quotedstr(aAccountname)+'  )  '+
                          ' or (Level4 =  ' + quotedstr(aAccountname)+'  ) )');
    if Accountobj.count =0 then exit;
    Accountobj.connection.BeginNestedTransaction;
    try
      Accountobj.first;
      accountnames:= '';
      While Accountobj.eof = False do begin
        if (Accountobj.balance <>0) then begin
          result := False;
          Accountobj.ResultStatus.AddItem(false,rssError,0,'Cannot Deactivate Account '+Quotedstr(aAccountname)+' As one of It''s sub account '+ quotedstr(Accountobj.accountname) +'''s Balance Is Not Zero', true);
          Exit;
        end;
        if (Accountobj.Required ) then begin
          result := False;
          Accountobj.ResultStatus.AddItem(false,rssError,0,'Cannot Deactivate Account '+Quotedstr(aAccountname)+' As one of It''s sub account '+ quotedstr(Accountobj.accountname) +' is a "Required" account.', true);
          Exit;
        end;
        Accountobj.Active := False;
        Accountobj.PostDB;
        if accountnames <> '' then accountnames := accountnames +',';
        accountnames := accountnames + Quotedstr(Accountobj.accountname);
        Accountobj.Next;
      end;
      REsult := True;
    finally
      if not result then
        Accountobj.connection.RollbackNestedTransaction
      else begin
        if Accountnames <> '' then
          Accountobj.ResultStatus.AddItem(false,rssError,0,'Deactivating Account '+Quotedstr(aAccountname)+' will deactivate all it''s sub accounts '+ Accountnames +' as well.', true);
        Accountobj.connection.CommitNestedTransaction;
      end;
    end;

  Finally
    Freeandnil(Accountobj);
  End;
end;
class function TAccount.AccountInUse(const aAccountId: Integer;
  var TransType: string; Connection: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
  AccntName: string;
begin
  TransType := '';
  AccntName := TAccount.IDToggle(aAccountId,Connection);
  qry := TERPQuery.CReate(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    qry.SQL.Add('select "Sale" as TransType from tblSales where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Sale Line" as TransType from tblSalesLines where IncomeAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Sale Line" as TransType from tblSalesLines where AssetAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Sale Line" as TransType from tblSalesLines where COGSAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Purchase" as TransType from tblPurchaseOrders where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Purchase Line" as TransType from tblPurchaseLines where IncomeAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Purchase Line" as TransType from tblPurchaseLines where AssetAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Purchase Line" as TransType from tblPurchaseLines where COGSAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Deposit" as TransType from tblDeposits where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Withdrawal" as TransType from tblWithdrawal where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Bank Deposit" as TransType from tblBankDeposit where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Stock Movement" as TransType from tblStockMovement where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Stock Movement Line" as TransType from tblStockMovementLines where AccountId = ' + IntToStr(aAccountId));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Stock Transfer Entry" as TransType from tblStockTransferEntry where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Stock Adjust Entry" as TransType from tblStockAdjustEntry where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "General Journal Line" as TransType from tblGeneralJournalDetails where AccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Pay" as TransType from tblPaysTransactions where AccountId = ' + IntToStr(aAccountId));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Prepayment" as TransType from tblPrepayments where MasterAccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Prepayment" as TransType from tblPrepayments where BankAccountId = ' + IntToStr(aAccountId) + ' and Deleted  <> "T"');
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Fixed Asset" as TransType from tblFixedAssets where FixedAssetCostAccountId = ' + IntToStr(aAccountId));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Fixed Asset" as TransType from tblFixedAssets where ClearingAccountId = ' + IntToStr(aAccountId));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Product" as TransType from tblParts where IncomeAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Product" as TransType from tblParts where AssetAccnt = ' + QuotedStr(accntName));
    qry.SQL.Add('union all');
    qry.SQL.Add('select "Product" as TransType from tblParts where COGSAccnt = ' + QuotedStr(accntName));
    qry.Open;
    result :=  not qry.IsEmpty;
    TransType := qry.FieldByName('TransType').AsString;
  finally
    qry.Free;
  end;
end;

class function TAccount.AccountNameForNumber(const aAccountNumber: string;
  Connection: TCustomMyConnection): string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AccountName from tblChartOfAccounts');
    qry.SQL.Add('where AccountNumber = ' + QuotedStr(aAccountNumber));
    qry.Open;
    result:= qry.FieldByName('AccountName').AsString;
  finally
    qry.Free;
  end;
end;

class function TAccount.AccountNameUnique(const aAccountId: Integer;
  const aAccountName: string; Connection: TCustomMyConnection): boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblChartOfAccounts');
    qry.SQL.Add('where AccountName = ' + QuotedStr(aAccountName));
    qry.SQL.Add('and AccountID <> ' + IntToStr(aAccountID));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;
class function TAccount.AccountNumberForID(const aAccountid: Integer;
                                            Connection: TCustomMyConnection = nil): string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AccountNumber from tblChartOfAccounts');
    qry.SQL.Add('where Accountid = ' + inttostr(aAccountid));
    qry.Open;
    result:= qry.FieldByName('AccountNumber').AsString;
  finally
    qry.Free;
  end;

end;

class function TAccount.AccountNumberForName(const aAccountName: string;
  Connection: TCustomMyConnection): string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AccountNumber from tblChartOfAccounts');
    qry.SQL.Add('where AccountName = ' + QuotedStr(aAccountName));
    qry.Open;
    result:= qry.FieldByName('AccountNumber').AsString;
  finally
    qry.Free;
  end;
end;

class function TAccount.AccountNumberUnique(const aAccountId: Integer;
  const aAccountNumber: string; Connection: TCustomMyConnection): boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblChartOfAccounts');
    qry.SQL.Add('where AccountNumber = ' + QuotedStr(aAccountNumber));
    qry.SQL.Add('and AccountID <> ' + IntToStr(aAccountID));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TAccount.GetIsHeader: boolean;
begin
  result:= GetBooleanField('IsHeader');
end;

procedure TAccount.SetIsHeader(const Value: boolean);
begin
  SetBooleanField('IsHeader', Value);
end;

function TAccount.GetReceiptCategory: string;
begin
  Result:= GetStringField('ReceiptCategory');
end;

procedure TAccount.SetReceiptCategory(const Value: string);
begin
  SetStringField('ReceiptCategory', Value);
end;

function TAccount.Save: boolean;
begin
  result:= ValidateData;
  if result then
    result:= inherited Save;
end;

initialization
  RegisterClassOnce(TAccount);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Account','TAccount','TChartOfAccountsListGUI');
  RegisterClassOnce(TAccountType);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Account Type','TAccountType','TAccountTypesListGUI', [boExport]);
end.

