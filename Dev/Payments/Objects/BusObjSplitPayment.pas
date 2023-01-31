unit BusObjSplitPayment;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/01/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjsales, busobjsalebase;


type
  TSplitPaymentLines = class(TMSBusObj)
  private
    function GetSplitPaymentID        : Integer   ;
    function GetPayMethodID           : Integer   ;
    function GetAmount                : Double    ;
    function GetPercentage            : Double    ;
    function GetCardholdersName       : string    ;
    function GetCreditCardNumber      : string    ;
    function GetPayMethod             : string    ;
    function GetCreditCardExpDate     : TDateTime ;
    function GetDeleted               : Boolean;
    function GetForeignExchangeRate   : Double    ;
    function GetForeignExchangeCode   : string    ;
    function GetForeignCurrencyAmount : Double    ;
    function GetReferenceNo           : string    ;
    function GetBankAccountName       : string    ;
    function GetBankAccountBSB        : string    ;
    function GetBankAccountNo         : string    ;
    procedure SetSplitPaymentID        (const Value: Integer   );
    procedure SetPayMethodID           (const Value: Integer   );
    procedure SetAmount                (const Value: Double    );
    procedure SetPercentage            (const Value: Double    );
    procedure SetCardholdersName       (const Value: string    );
    procedure SetCreditCardNumber      (const Value: string    );
    procedure SetPayMethod             (const Value: string    );
    procedure SetCreditCardExpDate     (const Value: TDateTime );
    Procedure SetDeleted               (const Value: Boolean   );
    procedure SetForeignCurrencyAmount (const Value: Double    );
    procedure SetForeignExchangeRate   (const Value: Double    );
    procedure SetForeignExchangeCode   (const Value: string    );
    procedure SetReferenceNo           (const Value: string    );
    procedure SetBankAccountName       (const Value: string    );
    procedure SetBankAccountBSB        (const Value: string    );
    procedure SetBankAccountNo         (const Value: string    );
    function GetPaymentdate: TDateTime;
    function getSaleForeignExchangeCode: String;
    function getCleanPayMethod: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost  (Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforePost  (Sender:TDatasetBusObj) : Boolean;          override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CalcOrderTotals;
    procedure CalcLinePercentages;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Paymentdate            :TDateTime   read GetPaymentdate;
    Property SaleForeignExchangeCode:String      read getSaleForeignExchangeCode;
    procedure CalcPercentage;
    Property CleanPayMethod :String read getCleanPayMethod;
  published
    property SplitPaymentID         :Integer     read GetSplitPaymentID         write SetSplitPaymentID    ;
    property PayMethodID            :Integer     read GetPayMethodID            write SetPayMethodID       ;
    property Amount                 :Double      read GetAmount                 write SetAmount            ;
    property Percentage             :Double      read GetPercentage             write SetPercentage        ;
    property CardholdersName        :string      read GetCardholdersName        write SetCardholdersName   ;
    property CreditCardNumber       :string      read GetCreditCardNumber       write SetCreditCardNumber  ;
    property PayMethod              :string      read GetPayMethod              write SetPayMethod         ;
    property CreditCardExpDate      :TDateTime   read GetCreditCardExpDate      write SetCreditCardExpDate ;
    Property Deleted                :Boolean     read getDeleted                write setDeleted;
    property ForeignCurrencyAmount  :Double      read GetForeignCurrencyAmount  write SetForeignCurrencyAmount    ;
    property ForeignExchangeRate    :Double      read GetForeignExchangeRate    write SetForeignExchangeRate      ;
    property ForeignExchangeCode    :string      read GetForeignExchangeCode    write SetForeignExchangeCode      ;
    property ReferenceNo            :string      read GetReferenceNo            write SetReferenceNo              ;
    property BankAccountName        :string      read GetBankAccountName        write SetBankAccountName          ;
    property BankAccountBSB         :string      read GetBankAccountBSB         write SetBankAccountBSB           ;
    property BankAccountNo          :string      read GetBankAccountNo          write SetBankAccountNo            ;
  end;


  TSplitPayments = class(TMSBusObj)
  private
    fdTotalApplied, fdTotalUnApplied : double;
    AlllinesValid:Boolean;
    fdTotalBalance:double;
    fdTotalBalanceForeign:double;
    function GetEmployeeID                : Integer   ;
    function GetEmployee                  : Boolean   ;
    function GetEnteredAt                 : TDateTime ;
    function GetSaleID                    : Integer   ;
    function GetPaymentDate               : TDateTime ;
    function GetAmount                    : Double    ;
    function GetNotes                     : string    ;
    function GetClassID                   : Integer   ;
    function GetAccountID                 : Integer   ;
    function GetForeignVariationAccountID : Integer   ;
    function GetTotalUnApplied            : Double    ;
    function GetTotalApplied              : Double    ;
    procedure SetEmployeeID                (const Value: Integer   );
    procedure SetEmployee                  (const Value: Boolean   );
    procedure SetEnteredAt                 (const Value: TDateTime );
    procedure SetSaleID                    (const Value: Integer   );
    procedure SetPaymentDate               (const Value: TDateTime );
    procedure SetAmount                    (const Value: Double    );
    procedure SetNotes                     (const Value: string    );
    procedure SetClassID                   (const Value: Integer   );
    procedure SetAccountID                 (const Value: Integer   );
    procedure SetForeignVariationAccountID (const Value: Integer   );
    procedure SetTotalUnApplied            (const Value: Double    );
    procedure SetTotalApplied              (const Value: Double    );
    function getLines: TSplitPaymentLines;
    function getsaleObj: TSalesBase;
    Procedure CalcOrdertotals;
    procedure CalcLinePercentages;
    procedure CalcOrdertotalsCallback(const Sender: TBusObj;var Abort: boolean);
    procedure CalcLinePercentageCallback(const Sender: TBusObj;var Abort: boolean);
    function getHasPaidLine: boolean;
    procedure HasPaidLineCallback(const Sender: TBusObj;var Abort: boolean);
    procedure HasanyFCLineCallback(const Sender: TBusObj;var Abort: boolean);
    procedure MakePaymentsCallback(const Sender: TBusObj;var Abort: boolean);
    function getforeignCurrencySymbol: String;
    function getHasanyFCLine: Boolean;
    procedure ValidateLines(const Sender: TBusObj;var Abort: boolean);



  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property     saleObj :TSalesBase read getsaleObj;
    property TotalUnApplied              :Double      read GetTotalUnApplied               write SetTotalUnApplied      ;
    property TotalApplied                :Double      read GetTotalApplied                 write SetTotalApplied      ;
    Property HasPaidLine                 :boolean     read getHasPaidLine;
    Property HasanyFCLine                :Boolean     read getHasanyFCLine;
    property foreignCurrencySymbol       :String      read getforeignCurrencySymbol;
    function MakePayments                :Boolean;
  published
    property EmployeeID                     :Integer     read GetEmployeeID                 write SetEmployeeID               ;
    property Employee                       :Boolean     read GetEmployee                   write SetEmployee                 ;
    property EnteredAt                      :TDateTime   read GetEnteredAt                  write SetEnteredAt                ;
    property SaleID                         :Integer     read GetSaleID                     write SetSaleID                   ;
    property PaymentDate                    :TDateTime   read GetPaymentDate                write SetPaymentDate              ;
    property Amount                         :Double      read GetAmount                     write SetAmount                   ;
    property Notes                          :string      read GetNotes                      write SetNotes                    ;
    property ClassID                        :Integer     read GetClassID                    write SetClassID                  ;
    property AccountID                      :Integer     read GetAccountID                  write SetAccountID                ;
    property ForeignVariationAccountID      :Integer     read GetForeignVariationAccountID  write SetForeignVariationAccountID;
    Property Lines : TSplitPaymentLines read getLines;
  end;


implementation


uses tcDataUtils, CommonLib, Sysutils, AppEnvironment, BusObjConst,
  BusObjPayments, tcConst,ForeignExchangeObj, variants, DbSharedObjectsObj,
  ERPdbComponents, CommonDbLib;



  {TSplitPayments}

procedure TSplitPayments.CalcLinePercentageCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TSplitPaymentlines) then exit;
  TSplitPaymentlines(Sender).CalcPercentage;
end;

procedure TSplitPayments.CalcLinePercentages;
begin
  Lines.IterateRecords(CalcLinePercentageCallback);
end;

procedure TSplitPayments.CalcOrdertotals;
begin
  Lines.PostDB;
  fdTotalApplied          := 0;
  fdTotalUnApplied        := 0;
  Lines.IterateRecords(CalcOrdertotalsCallback);
  fdTotalUnApplied        := saleObj.TotalBalance        - fdTotalApplied;
  FlagAsUpdated;
  PostDB;
end;

procedure TSplitPayments.CalcOrdertotalsCallback(Const Sender: TBusObj; var Abort: boolean) ;
begin
  if not(Sender is TSplitPaymentlines) then exit;
  if TSplitPaymentlines(sender).Deleted then exit;
  fdTotalApplied        := fdTotalApplied        + TSplitPaymentlines(sender).Amount;
end;

constructor TSplitPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SplitPayments';
  fSQL := 'SELECT * FROM tblsplitpayments';
end;


destructor TSplitPayments.Destroy;
begin
  inherited;
end;


procedure TSplitPayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetBooleanPropertyFromNode(node,'Employee');
  SetDateTimePropertyFromNode(node,'EnteredAt');
  SetPropertyFromNode(node,'SaleID');
  SetDateTimePropertyFromNode(node,'PaymentDate');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'ForeignVariationAccountID');
end;


function TSplitPayments.MakePayments: Boolean;
begin
  AlllinesValid:=True;
  if not(HasPaidLine) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please provide amount to Pay' , True );
    Result := False;
    exit;
  end;
  fdTotalBalance := saleobj.TotalBalance;
  fdTotalBalanceforeign := saleobj.ForeignBalanceAmount;
  connection.BeginNestedTransaction;
  try
  showProgressbar(Lines.count);
  try
    Lines.IterateRecords(MakePaymentsCallback);
  finally
    HideProgressbar;
  end;
    Result := AlllinesValid;
    if result then begin
      Connection.CommitNestedTransaction;
      SendEvent(BusobjEvent_ToDo , BusObjEventVal_OnAfterSave, self);
    end else connection.RollbackNestedTransaction;

  Except
    on E:Exception do begin
      Resultstatus.AddItem(False , rssError , 0,  'Saving split Payments failed - ' +e.Message , True );
      Result := False;
    end;

  end;
end;
procedure TSplitPayments.MakePaymentsCallback(const Sender: TBusObj;var Abort: boolean);
var
  CustPayment : TCustPayments;
begin
  if not(Sender is TSplitPaymentlines) then exit;
  if TSplitPaymentlines(Sender).Amount =  0 then exit;
  if TSplitPaymentlines(sender).deleted then exit;

  StepProgressbar('Saving Payment (' + inttostr(Lines.Recno)+' of '+ inttostr(Lines.count)+') of Sale #' + inttostr(SaleID)+' for '+ FloattostrF(TSplitPaymentlines(Sender).Amount, ffCurrency, 15,2 ));
  CustPayment := TCustPayments.Create(self);
  try
    CustPayment.Connection := Self.Connection;
    CustPayment.Loadselect('SplitPaymentID =' + inttostr(ID) +' and SplitPaymentLineID = '+ inttostr(TSplitPaymentlines(Sender).ID));
    if CustPayment.count =0 then begin
      CustPayment.New;
      CustPayment.CompanyName               := saleObj.ClientName;
      CustPayment.PaymentDate               := Paymentdate;
      CustPayment.ReferenceNo               := TSplitPaymentlines(Sender).ReferenceNo;
      CustPayment.ForeignVariationAccountID := ForeignVariationAccountID;
      CustPayment.ClassID                   := classid;
      CustPayment.AccountId                 := AccountId;
      CustPayment.PayMethodName             := TSplitPaymentlines(Sender).PayMethod;
      CustPayment.notes                     := Notes;
      CustPayment.EmployeeID                := employeeId;
      CustPayment.ForeignExchangeCode       := TSplitPaymentlines(Sender).ForeignExchangeCode;
      CustPayment.ForeignExchangeRate       := TSplitPaymentlines(Sender).ForeignExchangeRate;
      CustPayment.ReferenceNo               := TSplitPaymentlines(Sender).ReferenceNo;
      CustPayment.BankAccountName           := TSplitPaymentlines(Sender).BankAccountName;
      CustPayment.BankAccountBSB            := TSplitPaymentlines(Sender).BankAccountBSB;
      CustPayment.BankAccountNo             := TSplitPaymentlines(Sender).BankAccountNo;
      CustPayment.PostDB;
      StepProgressbar('Saving Payment # ' + inttostr(CustPayment.ID)+ '('+ inttostr(Lines.Recno)+' of '+ inttostr(Lines.count)+') of Sale #' + inttostr(SaleID)+' for '+ FloattostrF(TSplitPaymentlines(Sender).Amount, ffCurrency, 15,2 ));

      if not CustPayment.guilines.locate('type;SaleId' , vararrayof(['Invoice' , saleId]) , []) then begin
            Resultstatus.AddItem(False , rssError , 0,  'Cannot locate Invoice # ' + inttostr(SaleID)+' cannot be located to pay' , True );
            allLinesValid := False;
            Abort := true;
      end;
      TGuiCustPaymentLines(CustPayment.guilines).SplitForeignExchangeCode := TSplitPaymentlines(Sender).ForeignExchangeCode;
      TGuiCustPaymentLines(CustPayment.guilines).SplitForeignExchangeRate := TSplitPaymentlines(Sender).ForeignExchangeRate;
      CustPayment.guilines.Applied             := true;
      TGuiCustPaymentLines(CustPayment.guilines).SplitForeignPayment      := TSplitPaymentlines(Sender).ForeignCurrencyAmount;
      CustPayment.guilines.PostDB;
      CustPayment.CalcTotals(true);
      CustPayment.SplitPaymentID := Id;
      CustPayment.SplitPaymentLineID :=TSplitPaymentlines(Sender).ID;
      CustPayment.Postdb;

      fdTotalBalance        := fdTotalBalance        - TSplitPaymentlines(Sender).Amount;
      fdTotalBalanceforeign := fdTotalBalanceforeign - TSplitPaymentlines(Sender).ForeignCurrencyAmount;

      if not(CustPayment.Save) then begin
        allLinesValid := False;
        Abort := true;
      end;

    end;

  finally
    Freeandnil(CustPayment);
  end;



end;
procedure TSplitPayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'Employee' ,Employee);
  AddXMLNode(node,'EnteredAt' ,EnteredAt);
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'PaymentDate' ,PaymentDate);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'ForeignVariationAccountID' ,ForeignVariationAccountID);
end;


function TSplitPayments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be blank' , True );
    Exit;
  end;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Split Payment can be created for an sale. Please choose the sale' , True );
    Exit;
  end;
  if ClassID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Appenv.DefaultClass.ClassHeading + ' should not be blank' , True );
    Exit;
  end;
  if AccountID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Bank Account should not be 0' , True );
    Exit;
  end;
  if not(HasPaidLine) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please provide amount to Pay' , True );
    exit;
  end;
  if TotalUnApplied < 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Invoice is being over paid. Please adjust the amount(s)' , True );
    exit;
  end;
  allLinesValid := TRue;
  Lines.IterateRecords(ValidateLines);
  Result := allLinesValid;
end;
procedure TSplitPayments.ValidateLines(const Sender: TBusObj;var Abort: boolean);
begin
  if not(Sender is TSplitPaymentLines) then exit;
  if not(TSplitPaymentLines(Sender).Validatedata) then begin
     allLinesValid:= False;
     Abort := True;
  end;
end;

function TSplitPayments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSplitPayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSplitPayments.DoFieldOnChange(Sender: TField);
    var
        str:String;
    Function Isamountfield:Boolean;
    begin
         Result :=  (Sysutils.SameText(Sender.FieldName , 'Amount'               )) or
                    (Sysutils.SameText(Sender.FieldName , 'Applied'              )) or
                    (Sysutils.SameText(Sender.FieldName , 'UnApplied'            )) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignapplied'       )) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignunapplied'     ));
    END;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'PaymentDate') then begin
        if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
            str := 'You have set this date before the closing date !' +
                    'the date will automatically be set to today''s date OR '+
                    'reset the Closing Date In Preferences.';
            AddResult(True, rssinfo, 0 , str);
            PaymentDate := now;
        end;
    end else if Sysutils.SameText(Sender.fieldname , 'SaleId') then begin
    if saleId <>  0 then
      if appenv.companyPrefs.DefaultCustomerClassInPayments then ClassId := CustomerDefaultClassID(SaleObj.ClientID)
      else ClassId := saleObj.SaleClassId;
    end;
end;


function TSplitPayments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSplitPayments.GetIDField: string;
begin
  Result := 'SplitPaymentID'
end;


function TSplitPayments.getsaleObj: TSalesBase;
var
  ComponentClass : TComponentClass;
begin
    ComponentClass := TSalesBase.SaleComponentClass(Self.SaleId);
    Result := TSalesBase(GetContainerComponent(ComponentClass, 'SaleId = ' + IntToStr(Self.SaleId)));
end;

function TSplitPayments.getLines: TSplitPaymentLines;
begin
    Result := TSplitPaymentLines(GetContainerComponent(TSplitPaymentLines, 'SplitPaymentID = ' + IntToStr(Self.Id)));
end;

class function TSplitPayments.GetBusObjectTablename: string;
begin
  Result:= 'tblsplitpayments';
end;


function TSplitPayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  EmployeeID := AppEnv.Employee.EmployeeID;
  EnteredAt  := Now;
  PaymentDate                 := Date;
  AccountID                   := AppEnv.CompanyPrefs.DefaultCustPaymentAccount;
  ForeignVariationAccountID   := AppEnv.CompanyPrefs.CustomerPaymentsDefaultVariationAccountID;
  totalApplied                := 0;
  totalUnApplied              := 0;
end;

function TSplitPayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSplitPayments.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoCalcFields(Sender);
  if not(result) then exit;

  if saleId =0 then exit;
  TotalApplied                  := fdTotalApplied;
  TotalUnApplied                := fdTotalUnApplied;
end;

{Property Functions}
function  TSplitPayments.GetEmployeeID                    : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TSplitPayments.GetEmployee                      : Boolean   ; begin Result := GetBooleanField('Employee');end;
function  TSplitPayments.GetEnteredAt                     : TDateTime ; begin Result := GetDateTimeField('EnteredAt');end;
function  TSplitPayments.GetSaleID                        : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSplitPayments.GetPaymentDate                   : TDateTime ; begin Result := GetDateTimeField('PaymentDate');end;
function  TSplitPayments.GetAmount                        : Double    ; begin Result := GetFloatField('Amount');end;
function  TSplitPayments.GetNotes                         : string    ; begin Result := GetStringField('Notes');end;
function  TSplitPayments.GetClassID                       : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  TSplitPayments.GetAccountID                     : Integer   ; begin Result := GetIntegerField('AccountID');end;
function TSplitPayments.getforeignCurrencySymbol: String;
var
  qry :TERPQuery;
begin
  if sametext(saleobj.ForeignExchangeCode , Appenv.RegionalOptions.ForeignExDefault) then
    result :=  Appenv.RegionalOptions.CurrencySymbol
  else begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.Active then Qry.Close;
      Qry.SQL.Text := 'select currencySymbol  from tblcurrencyconversion where code = '+quotedstr(saleobj.ForeignExchangeCode);
      Qry.Open;
      With Qry do begin
        result := fieldByname('currencySymbol').AsString;
      end;
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
  end;
end;
function  TSplitPayments.GetForeignVariationAccountID     : Integer   ; begin Result := GetIntegerField('ForeignVariationAccountID');end;
function TSplitPayments.getHasanyFCLine: Boolean;
begin
  AllLinesValid := false;
  Lines.IterateRecords(HasanyFCLineCallback);
  result := AllLinesValid;

end;

function TSplitPayments.getHasPaidLine: boolean;
begin
  AllLinesValid := false;
  Lines.IterateRecords(HasPaidLineCallback);
  result := AllLinesValid;
end;
procedure TSplitPayments.HasanyFCLineCallback(const Sender: TBusObj;var Abort: boolean);
begin
  if not(Sender is TSplitPaymentlines) then exit;
  if TSplitPaymentlines(sender).deleted then exit;

  if not (sametext(TSplitPaymentlines(sender).ForeignExchangeCode , Appenv.RegionalOptions.ForeignExDefault)) then begin
    AllLinesValid := True;
    Abort := true;
  end;

end;

procedure TSplitPayments.HasPaidLineCallback(const Sender: TBusObj;var Abort: boolean);
begin
  if not(Sender is TSplitPaymentlines) then exit;
  if TSplitPaymentlines(sender).deleted then exit;
  if TSplitPaymentlines(Sender).Amount <>  0 then begin
    AllLinesValid := True;
    Abort := true;
  end;

end;
function  TSplitPayments.GetTotalUnApplied             : Double    ; begin Result := GetFloatField('TotalUnApplied');end;
function  TSplitPayments.GetTotalApplied               : Double    ; begin Result := GetFloatField('TotalApplied');end;
procedure TSplitPayments.SetEmployeeID                  (const Value: Integer   ); begin SetIntegerField('EmployeeID'                  , Value);end;
procedure TSplitPayments.SetEmployee                    (const Value: Boolean   ); begin SetBooleanField('Employee'                    , Value);end;
procedure TSplitPayments.SetEnteredAt                   (const Value: TDateTime ); begin SetDateTimeField('EnteredAt'                  , Value);end;
procedure TSplitPayments.SetSaleID                      (const Value: Integer   ); begin SetIntegerField('SaleID'                      , Value);CalcOrderTotals;end;
procedure TSplitPayments.SetPaymentDate                 (const Value: TDateTime ); begin SetDateTimeField('PaymentDate'                , Value);end;
procedure TSplitPayments.SetAmount                      (const Value: Double    ); begin SetFloatField('Amount'                        , Value);end;
procedure TSplitPayments.SetNotes                       (const Value: string    ); begin SetStringField('Notes'                        , Value);end;
procedure TSplitPayments.SetClassID                     (const Value: Integer   ); begin SetIntegerField('ClassID'                     , Value);end;
procedure TSplitPayments.SetAccountID                   (const Value: Integer   ); begin SetIntegerField('AccountID'                   , Value);end;
procedure TSplitPayments.SetForeignVariationAccountID   (const Value: Integer   ); begin SetIntegerField('ForeignVariationAccountID'   , Value);end;
procedure TSplitPayments.SetTotalUnApplied              (const Value: Double    ); begin SetFloatField('TotalUnApplied'                , Value);end;
procedure TSplitPayments.SetTotalApplied                (const Value: Double    ); begin SetFloatField('TotalApplied'                  , Value);end;
  {TSplitPaymentLines}
procedure TSplitPaymentLines.CalcLinePercentages;
begin
  If Assigned(Owner) then
    if owner is TSplitPayments then
      TSplitPayments(Owner).CalcLinePercentages;
end;

procedure TSplitPaymentLines.CalcOrderTotals;
begin
  If Assigned(Owner) then
    if owner is TSplitPayments then
      TSplitPayments(Owner).CalcOrdertotals;
end;

procedure TSplitPaymentLines.CalcPercentage;
begin
  try
    Percentage := round(Amount * 100 /TSplitPayments(owner).saleObj.TotalAmountInc  , 5);
  Except
    // kill the exception
  end;
end;

constructor TSplitPaymentLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SplitPaymentLines';
  fSQL := 'SELECT * FROM tblsplitpaymentlines';
end;


destructor TSplitPaymentLines.Destroy;
begin
  inherited;
end;


procedure TSplitPaymentLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SplitPaymentID');
  SetPropertyFromNode(node,'PayMethodID');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Percentage');
  SetPropertyFromNode(node,'ForeignCurrencyAmount');
  SetPropertyFromNode(node,'CardholdersName');
  SetPropertyFromNode(node,'CreditCardNumber');
  SetPropertyFromNode(node,'PayMethod');
  SetDateTimePropertyFromNode(node,'CreditCardExpDate');
  SetBooleanPropertyFromNode(node, 'Deleted');
  SetPropertyFromNode(node,'ForeignExchangeRate');
  SetPropertyFromNode(node,'ForeignExchangeCode');
  SetPropertyFromNode(node,'ReferenceNo');
  SetPropertyFromNode(node,'BankAccountName');
  SetPropertyFromNode(node,'BankAccountBSB');
  SetPropertyFromNode(node,'BankAccountNo');
end;


procedure TSplitPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SplitPaymentID' ,SplitPaymentID);
  AddXMLNode(node,'PayMethodID' ,PayMethodID);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Percentage' ,Percentage);
  AddXMLNode(node,'ForeignCurrencyAmount' ,ForeignCurrencyAmount);
  AddXMLNode(node,'CardholdersName' ,CardholdersName);
  AddXMLNode(node,'CreditCardNumber' ,CreditCardNumber);
  AddXMLNode(node,'PayMethod' ,PayMethod);
  AddXMLNode(node,'CreditCardExpDate' ,CreditCardExpDate);
  AddXMLNode(node, 'Deleted', Deleted);
  AddXMLNode(node,'ForeignExchangeRate' ,ForeignExchangeRate);
  AddXMLNode(node,'ForeignExchangeCode' ,ForeignExchangeCode);
  AddXMLNode(node,'ReferenceNo' ,ReferenceNo);
  AddXMLNode(node,'BankAccountName' ,BankAccountName);
  AddXMLNode(node,'BankAccountBSB' ,BankAccountBSB);
  AddXMLNode(node,'BankAccountNo' ,BankAccountNo);
end;


function TSplitPaymentLines.ValidateData: Boolean ;
begin
  Result := False;

  if Amount =  0 then exit; // no need to validate if no amount
  if deleted then exit;     // or deleted

  if PayMethodID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PayMethod should not be blank' , True );
    Exit;
  end;
  if (foreignexchangeCode = '') or (ForeignExchangerate =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Currency Code and Rate cannot be blank' , True );
    Exit;
  end;
  Result := True;
end;


function TSplitPaymentLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSplitPaymentLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TSplitPaymentLines.DoFieldOnChange(Sender: TField);
var
  fdBuyRate, fdSellRate:Double;
  Procedure Calcamount;
  begin
      Amount :=  RoundCurrency(divzer(ForeignCurrencyAmount , ForeignExchangeRate));
      CalcOrderTotals;
      CalcLinePercentages;
  end;
  Procedure CalcForeignamount;
  begin
      ForeignCurrencyAmount := RoundCurrency(ForeignExchangeRate * Amount);
      CalcOrderTotals;
      CalcLinePercentages;
  end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'PayMethod') then begin
        PayMethodId := GetPaymentMethod(PayMethod);
        SendEvent(BusObjEvent_Change , BusObjEventVal_PayMethod, self);
    end else if Sysutils.SameText(Sender.fieldname , 'PayMethodId') then begin
        PayMethod := GetPaymentMethod(PayMethodID);
    end else if Sysutils.SameText(Sender.fieldname , 'Amount') then begin
       ForeignCurrencyAmount := RoundCurrency(ForeignExchangeRate * Amount);
       CalcOrderTotals;
       CalcLinePercentages;
    end else if Sysutils.SameText(Sender.fieldname , 'Percentage') then begin
      if Percentage =0 then begin
        amount :=  0;
      end else begin
      If Assigned(Owner) then
        if owner is TSplitPayments then
          Amount := round(TSplitPayments(owner).saleObj.TotalAmountInc * Percentage /100 , 5);
      end;
      DoFieldOnChange(dataset.findfield('Amount'));
    end else if Sysutils.SameText(Sender.fieldname , 'ForeignCurrencyAmount') then begin
       Calcamount;
    end else if Sysutils.SameText(Sender.fieldName , 'ForeignExchangeCode') then begin
      if sametext(ForeignExchangeCode , Appenv.RegionalOptions.ForeignExDefault) then
        ForeignExchangeRate :=1
      else With TForeignExchangeObj.Create do try
            GetForeignExchangeRatesForDate(ForeignExchangeCode, Paymentdate, fdBuyRate, fdSellRate);
            ForeignExchangeRate :=fdSellRate;
        Finally
            Free;
        end;
      CalcForeignamount;
    end else if Sysutils.SameText(Sender.fieldName , 'ForeignExchangeRate') then begin
      if sametext(ForeignExchangeCode , Appenv.RegionalOptions.ForeignExDefault) and (ForeignExchangeRate <> 1) then
          Sender.value := 1;
      CalcForeignamount;
    end;
end;


function TSplitPaymentLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSplitPaymentLines.GetIDField: string;
begin
  Result := 'SplitPaymentLineID'
end;


class function TSplitPaymentLines.GetBusObjectTablename: string;
begin
  Result:= 'tblsplitpaymentlines';
end;


function TSplitPaymentLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;

  if Assigned(Owner) then
    if Owner is  TSplitPayments then begin
      SplitPaymentID := TSplitPayments(Owner).ID;
      PayMethod := PAY_CASH;
      ForeignExchangeCode := TSplitPayments(Owner).Saleobj.ForeignExchangeCode;
      if TSplitPayments(Owner).TotalUnApplied >0 then Amount    := TSplitPayments(Owner).TotalUnApplied;
    end;
  deleted := False;
end;

function TSplitPaymentLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(result) then exit;

  if not(deleted) and  (ForeignExchangeCode ='') and (ForeignCurrencyAmount=0) then begin
    Deleted := TRue;
    PostDB;
    Exit;
  end;
  CalcOrderTotals;
end;


function TSplitPaymentLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not(Result) then exit;

  if sametext(ForeignExchangeCode , Appenv.RegionalOptions.ForeignExDefault) and (ForeignExchangeRate <> 1) then
    ForeignExchangeRate:= 1;

end;
function TSplitPaymentLines.getCleanPayMethod: String;
begin
  Result := GetXMLNodeStringValue(CleanXMLNode, 'Paymethod');
end;
function TSplitPaymentLines.getSaleForeignExchangeCode: String;
begin
  Result := '';
  if assigned(Owner) then
    if owner is TSplitPayments then
      result :=TSplitPayments(Owner).saleObj.ForeignExchangeCode;
end;
function TSplitPaymentLines.GetPaymentdate: TDateTime;
begin
  Result := 0;
  If Assigned(Owner) then
    if owner is TSplitPayments then
      result := TSplitPayments(Owner).Paymentdate;
end;

{Property Functions}
function  TSplitPaymentLines.GetSplitPaymentID        : Integer   ; begin Result := GetIntegerField('SplitPaymentID')     ;end;
function  TSplitPaymentLines.GetPayMethodID           : Integer   ; begin Result := GetIntegerField('PayMethodID')        ;end;
function  TSplitPaymentLines.GetAmount                : Double    ; begin Result := GetFloatField('Amount')               ;end;
function  TSplitPaymentLines.GetPercentage            : Double    ; begin Result := GetFloatField('Percentage')           ;end;
function  TSplitPaymentLines.GetCardholdersName       : string    ; begin Result := GetStringField('CardholdersName')     ;end;
function  TSplitPaymentLines.GetCreditCardNumber      : string    ; begin Result := GetStringField('CreditCardNumber')    ;end;
function  TSplitPaymentLines.GetPayMethod             : string    ; begin Result := GetStringField('PayMethod')           ;end;
function  TSplitPaymentLines.GetCreditCardExpDate     : TDateTime ; begin Result := GetDateTimeField('CreditCardExpDate') ;end;
Function  TSplitPaymentLines.GetDeleted               : Boolean   ; begin result := GetBooleanField('Deleted')            ;end;
function  TSplitPaymentLines.GetForeignCurrencyAmount : Double    ; begin Result := GetFloatField('ForeignCurrencyAmount');end;
function  TSplitPaymentlines.GetForeignExchangeRate   : Double    ; begin Result := GetFloatField('ForeignExchangeRate')  ;end;
function  TSplitPaymentlines.GetForeignExchangeCode   : string    ; begin Result := GetStringField('ForeignExchangeCode');end;
function  TSplitPaymentlines.GetReferenceNo           : string    ; begin Result := GetStringField('ReferenceNo');end;
function  TSplitPaymentlines.GetBankAccountName       : string    ; begin Result := GetStringField('BankAccountName');end;
function  TSplitPaymentlines.GetBankAccountBSB        : string    ; begin Result := GetStringField('BankAccountBSB');end;
function  TSplitPaymentlines.GetBankAccountNo         : string    ; begin Result := GetStringField('BankAccountNo');end;
procedure TSplitPaymentLines.SetSplitPaymentID        (const Value: Integer   ); begin SetIntegerField('SplitPaymentID'     , Value);end;
procedure TSplitPaymentLines.SetPayMethodID           (const Value: Integer   ); begin SetIntegerField('PayMethodID'        , Value);end;
procedure TSplitPaymentLines.SetAmount                (const Value: Double    ); begin SetFloatField('Amount'               , Value);end;
procedure TSplitPaymentLines.SetPercentage            (const Value: Double    ); begin SetFloatField('Percentage'           , Value);end;
procedure TSplitPaymentLines.SetCardholdersName       (const Value: string    ); begin SetStringField('CardholdersName'     , Value);end;
procedure TSplitPaymentLines.SetCreditCardNumber      (const Value: string    ); begin SetStringField('CreditCardNumber'    , Value);end;
procedure TSplitPaymentLines.SetPayMethod             (const Value: string    ); begin SetStringField('PayMethod'           , Value);end;
procedure TSplitPaymentLines.SetCreditCardExpDate     (const Value: TDateTime ); begin SetDateTimeField('CreditCardExpDate' , Value);end;
Procedure TSplitPaymentLines.SetDeleted               (const Value: Boolean   ); begin setBooleanfield('Deleted'            , value); end;
procedure TSplitPaymentLines.SetForeignCurrencyAmount (const Value: Double    ); begin SetFloatField('ForeignCurrencyAmount', Value);end;
procedure TSplitPaymentlines.SetForeignExchangeRate   (const Value: Double    ); begin SetFloatField('ForeignExchangeRate'  , Value);end;
procedure TSplitPaymentlines.SetForeignExchangeCode   (const Value: string    ); begin SetStringField('ForeignExchangeCode' , Value);end;
procedure TSplitPaymentlines.SetReferenceNo           (const Value: string    ); begin SetStringField('ReferenceNo'                  , Value);end;
procedure TSplitPaymentlines.SetBankAccountName       (const Value: string    ); begin SetStringField('BankAccountName'              , Value);end;
procedure TSplitPaymentlines.SetBankAccountBSB        (const Value: string    ); begin SetStringField('BankAccountBSB'               , Value);end;
procedure TSplitPaymentlines.SetBankAccountNo         (const Value: string    ); begin SetStringField('BankAccountNo'                , Value);end;

initialization
  RegisterClass(TSplitPaymentLines);
  RegisterClass(TSplitPayments);
end.
