unit BusobjCash;

interface

uses
    BusobjSaleBase, DB , BusObjBase , BusobjTrans , Classes, XMLDoc, XMLIntf, busobjPQA ;
Type
    TSalesPayments = Class(TMSBusObj)
    Private
        Function GetSaleID	    :	integer	;
        Function GetPayMethod	:	String	;
        Function GetAmount	    :	Double	;
        Function GetRef	        :	String	;
        Function GetDeleted	    :	Boolean	;
        Procedure SetSaleID	    (Const Value :	integer	);
        Procedure SetPayMethod	(Const Value :	String	);
        Procedure SetAmount	    (Const Value :	Double	);
        Procedure SetRef	    (Const Value :	String	);
        Procedure SetDeleted	(Const Value :	Boolean	);
      function GetAmountTendered: double;
      procedure SetAmountTendered(const Value: double);
    Protected
        procedure DoFieldOnChange(Sender: TField);                  override;
        function  GetSQL:String ;                                   Override;
        function DoAfterInsert(Sender: TDatasetBusObj): boolean;    Override;
        function DoBeforePost(Sender: TDatasetBusObj): boolean;     Override;
    Public
        class function GetIDField: string; override;
        class function GetBusObjectTablename: string; Override;
        Function    Save        :   Boolean;                        Override;
        function    ValidateData:   Boolean;                        Override;
        constructor Create(AOwner: TComponent);                     override;
        Procedure   LoadFromXMLNode(Const node: IXMLNode);          override;
        Procedure   SaveToXMLNode(Const node: IXMLNode);            override;
    Published
        Property	SaleID	    :	integer	Read GetSaleID	    Write SetSaleID	;
        Property	PayMethod	  :	String	Read GetPayMethod  	Write SetPayMethod	;
        Property	Amount	    :	Double	Read GetAmount	    Write SetAmount	;
        property AmountTendered: double read GetAmountTendered write SetAmountTendered;
        Property	Ref	        :	String	Read GetRef	        Write SetRef	;
        Property	Deleted	    :	Boolean	Read GetDeleted	    Write SetDeleted	;
    end;

    TCashLineBase = class(TSaleslineBase)
    Private
        Function GetCalcPriceInc           : Double;
        Function GetCalcTotalInc           : Double;
        Function GetCalcTotalEx            : Double;
        Function GetCalcTax                : Double;
        Function GetCalcBackOrder          : Double;
        Function GetCalcLinePriceEx        : Double;
        Function GetCalcTotalIncB4Discount : Double;
        function getCalcGrossProfitPercInc : Double;

        Procedure SetCalcPriceInc           (Const Value :Double);
        Procedure SetCalcTotalInc           (Const Value :Double);
        Procedure SetCalcTotalEx            (Const Value :Double);
        Procedure SetCalcTax                (Const Value :Double);
        Procedure SetCalcBackOrder          (Const Value :Double);
        Procedure SetCalcLinePriceEx        (Const Value :Double);
        Procedure SetCalcTotalIncB4Discount (Const Value :Double);
        Procedure SetCalcGrossProfitPercInc (Const Value :Double);
        procedure CheckFordiscontinuedProduct;
    Protected
        procedure DoFieldOnChange(Sender: TField); override;
        function  GetSQL:String ;                                   Override;
        Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;   Override;
        procedure GetProductDetails;                                Override;
        procedure GetBaseLinePrice; override;
        function  DoBeforePost(Sender: TDatasetBusObj): boolean;      Override;
        Procedure CreateInstance; override;
        Function GetTransDate           :TDatetime; override;
        procedure SetTransDate      (const Value: TDatetime ); override;

    Public
        class function GetIDField: string; override;
        class function GetBusObjectTablename: string; Override;
        Procedure CalcLineTotals;                                   Override;
        Function ValidateData :boolean ; Override;
        procedure   LoadFromXMLNode(Const node: IXMLNode); override;
        procedure   SaveToXMLNode(Const node: IXMLNode); override;
        constructor Create(AOwner: TComponent); override;
        class function _Schema: string; override;
        function ISoktoShip: Boolean;
    Published
        Property CalcPriceInc           : Double Read GetCalcPriceInc           Write SetCalcPriceInc;
        Property CalcTotalInc           : Double Read GetCalcTotalInc           Write SetCalcTotalInc;
        Property CalcTotalEx            : Double Read GetCalcTotalEx            Write SetCalcTotalEx;
        Property CalcTax                : Double Read GetCalcTax                Write SetCalcTax;
        Property CalcBackOrder          : Double Read GetCalcBackOrder          Write SetCalcBackOrder;
        Property CalcLinePriceEx        : Double Read GetCalcLinePriceEx        Write SetCalcLinePriceEx;
        Property CalcTotalIncB4Discount : Double Read GetCalcTotalIncB4Discount Write SetCalcTotalIncB4Discount;
        Property CalcGrossProfitPercInc : Double Read getCalcGrossProfitPercInc Write SetCalcGrossProfitPercInc;
    End;

    TCashSaleLine = Class(TCashLineBase)
    Private
    Protected
        Function GetPQA              :TPQA; override;
        Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;Override;
        function  GetSQL:String ;                                   Override;
        function GetOrderQty         :Double;    override;
        procedure SetOrderQty(const Value: Double);override;
        function GetUOMOrderQty         :Double;    override;
        procedure SetUOMOrderQty(const Value: Double);override;
        function  DoBeforePost(Sender: TDatasetBusObj): boolean;      Override;

    Public
      constructor Create(AOwner: TComponent); override;
    End;

    TRefundSaleLine = Class(TCashLineBase)
    Private
    Protected
      Function  GetAllocType          : String;   override;
      procedure DoFieldOnChange(Sender: TField);  override;
      function  GetSQL:String ;                   Override;
      Function  GetQty                : Double;   override;
      Function  GetUOMQty             : Double;   override;
      function GetOrderQty         :Double;    override;
      procedure SetOrderQty(const Value: Double);override;
      function GetUOMOrderQty         :Double;    override;
      procedure SetUOMOrderQty(const Value: Double);override;
      procedure GetBaseLinePrice; override;
    Public
      function ValidateData:boolean; override;
      constructor Create(AOwner: TComponent); override;
    End;

    TCustomerReturnLine = Class(TRefundSaleLine)
    Private
    Protected
      Function  GetAllocType          : String;   override;
      Function  GetIsPQAItem:Boolean; Override;
      Procedure CreateInstance; override;
    End;


    TCashBase = class(TSalesBase)
    Private
        fbInvoiceRefund :Boolean;
        fdSalesPaymentsTotal :Double;
        AllLinesSavedOK :Boolean;
        (*AllLinesValid :Boolean;*)
        //fbConvertingSO :Boolean;


        Function getSalesPaymentsTotal :Double;
        Procedure CalcSalesPaymentsTotal(Const Sender: TBusObj; var Abort: boolean);
        Procedure DeletePayments(Const Sender: TBusObj; var Abort: boolean);
        Procedure SetInvoiceRefund(const Value :Boolean);
        Function ValidatePaymentData :Boolean;
        Function UpdatePaymentData :Boolean;
        procedure LineSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);

    Protected
        function  GetSQL:String ;                                   Override;
        procedure DoFieldOnChange(Sender: TField); override;
        procedure OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);Override;
        function DeleteFlaggedLines: boolean; Override;
        function UpdateAccounts: boolean;
        procedure LineBalanceCallbackProc(const Sender: TBusObj;  var Abort: boolean);
        Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;     Override;
        Function getSalesPayments :TSalesPayments; virtual;
        procedure LineValidateCallbackProc(const Sender: TBusObj; var Abort: boolean);Override;
    Public
        class function GetIDField: string; override;
        class function GetBusObjectTablename: string; Override;
        constructor Create(AOwner :TComponent); override;
        function ValidateData: boolean; override;
        Function Save :Boolean; override;
        Function ExportsubClasses(Const node: IXMLNode):Boolean; Override;
        Function ImportsubClasses(const node: IXMLNode):Boolean; Override;
        procedure LoadFromXMLNode(Const node: IXMLNode);         Override;
        Function HasAnyvoucher :Boolean;
        //Property ConvertingSO :Boolean read fbConvertingSO write fbConvertingSO;

    published
        Property SalesPayments : TSalesPayments Read getSalesPayments ;//  Write SetSalesPayments;
        Property InvoiceRefund : Boolean        Read fbInvoiceRefund    Write SetInvoiceRefund;
        Property SalesPaymentsTotal :Double     Read getSalesPaymentsTotal;
    End;

    TCashSale = Class(TCashBase)
    Private
        function GetCashSaleLines: TCashSaleLine;
    Protected
        Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;     Override;
        Procedure DoFieldOnChange(Sender :TField); Override;
        Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;     Override;
        function GetSaleLines: TSalesLineBase; Override;
        function GetLines: TTransLineBase; override;
        function GetSQL :STring; override;
    Public
        Procedure AfterCopy; override;
        function ValidateData: boolean; override;
        function Save: boolean; override;

    published
        property Lines: TCashSaleLine Read GetCashSaleLines;
    End;

    TRefundSale = Class(TCashBase)
    Private
        function GetRefundLines: TRefundSaleLine;
        function getRefundStatus: String;
        procedure setRefundStatus(const Value: String);
        function getCustomerReturnRef: String;
        procedure setCustomerReturnRef(const Value: String);
        function MakeSupp: Boolean;
        //function getRefundCheque: TCheque;
    Protected
        procedure DoFieldOnChange(Sender: TField); override;
        Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;     Override;
        function GetSaleLines: TSalesLineBase; override;
        function GetLines: TTransLineBase; override;
        function GetSQL :STring; override;
        function GetTransStatus: String;Override;
        procedure SetTransStatus(const Value: String);Override;
    Public
        function ValidateData: boolean; override;
        function Save: boolean; override;
        constructor Create(AOwner: TComponent); override;
        Procedure InitARAccount; Override;
        function MakenUpdatecheque:Boolean;
        function HAscheque: Boolean;
        //Property RefundCheque :TCheque read getRefundCheque;
    published
        property Lines: TRefundSaleLine Read GetRefundLines;
        Property RefundStatus :String read getRefundStatus write setRefundStatus;
        Property CustomerReturnRef :String read getCustomerReturnRef write setCustomerReturnRef;

    End;


    TCustomerReturn = Class(TRefundSale)
    Private
        fbConvertingToREfund :Boolean;
        function GetCustomerReturnLines: TCustomerReturnLine;
        function getConverted: Boolean;
        procedure setConverted(const Value: Boolean);
    Protected
        procedure DoFieldOnChange(Sender: TField); override;
        function GetSaleLines: TSalesLineBase; override;
        function GetLines: TTransLineBase; override;
        Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;     Override;
        Procedure CreateInstance; override;
    Public
      constructor Create(AOwner: TComponent); override;
      Function ConvertTorefund:Integer;
      Property ConvertingToREfund :Boolean read fbConvertingToREfund write fbConvertingToREfund;
    published
        property Lines: TCustomerReturnLine Read GetCustomerReturnLines;
        Property Converted :Boolean read getConverted write setConverted;
    End;


implementation

uses tcDataUtils,  BusObjStock , sysutils,
    BusObjConst, CommonLib, tcConst, Dialogs , Controls ,
  tcTypes, BusObjClient, AppEnvironment,
  BusObjPOSSale, Math, DNMLib, BusObjPaymethods, dateutils, BusObjProductClass,
  busobjExpenses  ;

{TCashBase}
Function TCashBase.getSalesPayments :TSalesPayments;
begin
    Result := TSalesPayments(getContainerComponent(TSalesPayments , 'SaleId = ' + IntToStr(ID) , Self.SilentMode));
End;
Procedure TCashBase.DeletePayments(Const Sender: TBusObj; var Abort: boolean);
begin
    TSalesPayments(Sender).Deleted := true;
    TSalesPayments(Sender).PostDB;
end;
Procedure TCashBase.CalcSalesPaymentsTotal(const Sender: TBusObj; var Abort: boolean);
begin
    if not deleted then
        fdSalesPaymentsTotal := fdSalesPaymentsTotal + TSalesPayments(Sender).Amount;
end;
Procedure TCashBase.SetInvoiceRefund(const Value :Boolean);
begin
    fbInvoiceRefund := Value;
    if Value then begin
        SalesPayments.IterateRecords(DeletePayments, True);
        if (Sysutils.SameText(GLAccountName , UNDEPOSITED_FUNDS)) or (GLAccountId = 0 ) then
            InitARAccount;//GLAccountID     := AppEnv.CompanyPrefs.DefaultSalesAccount;
        PayMethod           := '';
        (*ChequeNumber        := '';*)
    end else begin
        if (not (Sysutils.SameText(GLAccountName  , UNDEPOSITED_FUNDS)) ) or (GLAccountId = 0 ) then
            GLAccountNAme   :=  UNDEPOSITED_FUNDS;
    End;
end;

Function TCashBase.getSalesPaymentsTotal :Double;
begin
    fdSalesPaymentsTotal := 0;
    SalesPayments.IterateRecords(CalcSalesPaymentsTotal);
    Result := fdSalesPaymentsTotal;
end;
function TCashBase.DeleteFlaggedLines: boolean;
var
  IsFiltered: boolean;
begin
  Result:= inherited DeleteFlaggedLines; // don;t delete inherited, this handles the line records;
  SalesPayments.Dataset.DisableControls;
  Try
    IsFiltered := SalesPayments.Dataset.Filtered;
    SalesPayments.Dataset.Filtered := false;
    if SalesPayments.Count > 0 then begin
        SalesPayments.First;
        while not SalesPayments.Dataset.Eof do begin
            if SalesPayments.Deleted then SalesPayments.Delete
            else SalesPayments.Dataset.Next;
        end;
        SalesPayments.Dataset.Filtered := IsFiltered;
    end;
  Finally
    SalesPayments.Dataset.EnableControls;
  end;
end;
procedure TCashBase.OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);
begin
    inherited;
  ConvertingSO := False;
end;
Function TCashBase.UpdatePaymentData :Boolean;
begin
    if SalesPayments.Dataset.Recordcount = 0 then begin
        if (Self.PayMethod  <> '')  then begin
            SalesPayments.New;
            SalesPayments.SaleID    := ID;
            SalesPayments.PayMethod := Self.PayMethod;
            SalesPayments.Ref       := self.ChequeNumber;
            SalesPayments.amount    := TotalAmountInc;
            SalesPayments.PostDB;
        End;
    end else if SalesPayments.Dataset.Recordcount = 1 then begin
        SalesPayments.Dataset.first;
        if not Math.SameValue(SalesPayments.amount, TotalAmountInc, 0.0000001) then  begin
            if PayMethod    <> SalesPayments.PayMethod then
                PayMethod   := SalesPayments.PayMethod;
            if ChequeNumber <> SalesPayments.Ref then
                ChequeNumber:= SalesPayments.Ref;
            PostDB;
        End;
    end else begin
        PayMethod := PAY_SPLIT;
        ChequeNumber := '';
        PostDB;
    end;
    Result := True;
end;


Function TCashBase.ValidatePaymentData :Boolean;
begin
    Result := False;
    if not SalesPayments.Save then Exit;
    if (TotalAmountInc = 0) and (SalesPayments.Dataset.Recordcount <> 0) then begin
        SalesPayments.Iteraterecords(DeletePayments, True);
        Result := True;
        Exit;
    end;
    if not ConvertingSO then begin
        if (RoundCurrency(TotalAmountInc) <> 0) and (SalesPayments.Dataset.Recordcount = 0) then begin
            if Self.PayMethod  = '' then begin
                Result:= false;
                ResultStatus.AddItem(false, rssWarning, 0,'Payment method should not be blank');
                exit;
            end;
            if TPaymentMethod.IDToggle(PayMethod,self.Connection.Connection) < 1 then begin
                ResultStatus.AddItem(False, rssWarning , 0 , 'Unknown Payment Method "' + PayMethod + '"');
                Result := False;
                Exit;
            end;
        end else if SalesPayments.Dataset.Recordcount = 1 then begin
            if not Math.SameValue(SalesPayments.amount, TotalAmountInc, 0.0000001) then
              SalesPayments.amount := TotalAmountInc;
            if not Math.SameValue(SalesPayments.amount, TotalAmountInc, 0.0000001) then  begin
                Result:= false;
                ResultStatus.AddItem(false, rssWarning, 0, 'Total Amount Inc [' + FloatToStr(TotalAmountInc) + '] must match the payment total[' + FloatToStr(SalesPayments.amount)+'].' );
                exit;
            end;
        end else begin
            if RoundCurrency(SalesPaymentsTotal) <> RoundCurrency(TotalAmountInc) then  begin
                Result:= false;
                ResultStatus.AddItem(false, rssWarning, 0, 'Total Amount Inc [' + FloatToStr(RoundCurrency(TotalAmountInc)) + '] must match the payment total[' + FloatToStr(RoundCurrency(fdSalesPaymentsTotal))+'].' );
                exit;
            end;
            (*else if Payment <> SalesPaymentsTotal then Payment :=SalesPaymentsTotal;*)
        end;
    End;
    Result := True;
end;
constructor TCashBase.Create(AOwner :TComponent);
begin
    inherited Create(AOwner);
{for the complete list this where calsue should be applied . eg : Export to XML
  but if ID is passed into it, override the where clause with the ID. thats becuase
  the conversions opens the record in the converting class.
  eg Sales order to Invoice conversion can open the SO record in a TInvoice Object }
//    if      Self is TRefundSale then fSQLSelect := ' isRefund = "T"'
//    else if Self is TCashSale   then fSQLSelect := ' isCashSale = "T"';
    if  Self is TRefundSale then begin
      fSQL:= 'SELECT * From tblSales';
      fSQLSelect := 'IsRefund = "T"';
    end
    else if self is TPosCashSale  then begin
      fSQL:= 'SELECT * From tblSales';
      fSQLSelect := 'IsPos = "T" and (IsCashSale = "T" or IsLaybyPayment = "T" or IsLayby = "T")';
    end
    else if self is TCashSale then begin
      fSQL:= 'SELECT * From tblSales';
      fSQLSelect := 'IsCashSale = "T" and IsPos = "F"';
    end
    else
      fSQL:= 'SELECT * From tblSales';
    ConvertingSO := False;
    ExportExcludeList.Add('invoicerefund');
end;
procedure TCashBase.LineValidateCallbackProc(Const Sender: TBusObj;
  var Abort: boolean);
begin
  if not TCashLineBase(Sender).ValidateData then  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TCashBase.LineSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);
begin
  if not TCashLineBase(Sender).Save then
  begin
    AllLinesSavedOK:= false;
    Abort:= true;
  end;
end;
procedure TCashBase.LoadFromXMLNode(Const node: IXMLNode);
var
    PaymentNode : IXMLNode;
    x           : Integer;
begin
    inherited;
{lines importing is handled in the importsubclasses when importing from external file}
  if ImportingFromXMLFile then Exit;

  { delete existing lines if they exist }
  while SalesPayments.Count > 0 do SalesPayments.Delete;

  PaymentNode := node.ChildNodes.FindNode('Payments');
  if Assigned(PaymentNode) then begin
    for x := 0 to PaymentNode.ChildNodes.Count - 1 do begin
      SalesPayments.New;
      SalesPayments.LoadFromXMLNode(PaymentNode.ChildNodes[x]);
      SalesPayments.Postdb;
    end;
  end;
end;
Function    TCashBase.ImportsubClasses(const node: IXMLNode):Boolean;
var
    x:Integer;
    Singlerec :IXMLNode;
begin
    Result := inherited ImportsubClasses(node);
    if not Result then begin
        ImportFailed := True;
        exit;
    end;
    XMLPropertyName :='Payments';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            SalesPayments.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            SalesPayments.ImportFromXML(SingleRec);
            ImportFailed :=SalesPayments.ImportFailed;
            if Error then Exit;
        end;
    end;
    ImportFailed := False;
    Result := True;
end;
procedure TRefundSale.InitARAccount;
begin
  inherited;
  if not(InvoiceRefund) then begin
      GLAccountNAme   :=  UNDEPOSITED_FUNDS;
      DofieldOnchange(Dataset.FindField('Account'));
  end;
end;

function TCashBase.ExportsubClasses(Const node: IXMLNode):Boolean;
begin
    Result := inherited ExportsubClasses(node);
    self.SalesPayments.XMLPropertyNode := node.AddChild('Payments');
    self.SalesPayments.XMLPropertyName:= XMLNodeName+'Payment';
    self.SalesPayments.IterateRecords(GetPropertyXMLCallback);
end;
Function TCashBase.Save :Boolean;
begin
    Result := false;
  try
    if not convertingSO then PostList.Clear;
    if not ValidateData then Exit;
    if not SaveGUIValidate then exit;

    CalcOrderTotals;
    IsPaid := TotalBalance = 0;

    if (not InvoiceRefund) and (not(self is TPOSLayby)) then
      if (Self is TCashSale) or (Self is TPOSCashSale) or(self is TPOSSale) or (self is TPOSLaybyPayment) then begin
            IsPaid := True;
            TotalBalance := 0;
            TotalPaid := totalAmountInc;
            PostDB;
    end;

    PostDB;
    if UpdateAccounts then  begin
      Result:= inherited Save;
      if not Result then exit;

      { now validate then invoice lines }
      AllLinesSavedOK:= true;

      Lines.IterateRecords(LineSaveCallbackProc, True);

      Result:= AllLinesSavedOK;

      if Result then    begin
          if not PostList.Execute then begin
              //Result := False;
              //Exit;
              //As update batch updates the account balance of Cahrtof accounts, Save the transaction even if postlist.execute fails
              Result := true;
          end;
      end;
    end  else  begin
      Result:= false;
    end;
  finally
    if Result then  Result :=  Validtocommit;
  end;
  if Result then begin
    if DeleteFlaggedLines then    Dirty := False else Result := False;
  end;
end;
function TCashBase.ValidateData: boolean;
begin
  if Deleted or Cancelled then begin
    Result:= true;
    exit;
  end;
  Result:= inherited ValidateData;
  if not Result then
    exit;

  if clientId = 0 then begin
    Result:= false;
    if self.ClientName <> '' then
      ResultStatus.AddItem(false, rssWarning, 0,'Unknown customer "' + self.ClientName + '"')
    else
      ResultStatus.AddItem(false, rssWarning, 0,'Customer should not be blank');
    exit;
  end;
  if  (SaleClassId < 0) then  begin
    Result:= false;
    ResultStatus.AddItem(false, rssWarning, BOR_Sales_Err_InvalidDepartment,'Department should not be blank');
    exit;
  end ;

  if InvoiceRefund then begin
    if GLAccountID = 0 then InitARAccount;//GLAccountID := AppEnv.CompanyPrefs.DefaultSalesAccount;
  end else begin
      if GLAccountName = '' then GLAccountName := UNDEPOSITED_FUNDS;
      if not ((ISLayby) or ((Self is TPOSSale) and (TPOSSale(self).ISBartab )))  then
        Result := ValidatePaymentData ;
      if not Result then Exit;
  end;
  if GLAccountID = 0 then begin
    Result:= false;
    ResultStatus.AddItem(false, rssWarning, 0, 'Account should not be blank' );
    exit;
  end;
  if InvoiceRefund then begin
    if tcDatautils.getTypeofAccount(GLACcountID) <> 'AR' then begin
        Result:= false;
        ResultStatus.AddItem(false, rssWarning, 0, 'Account should be of ''Account Receivable'' Type' );
        exit;
    end;
  end else
    if not ((Self is TPOSSale) and (TPOSSale(self).ISBartab )) then
        if not Sysutils.SameText(tcDatautils.getAccountName(GLACcountID) , UNDEPOSITED_FUNDS) then begin
            Result:= false;
            ResultStatus.AddItem(false, rssWarning, 0, 'Account should be ' + UNDEPOSITED_FUNDS );
            exit;
        end;
    (*AllLinesValid:= true;
    Lines.IterateRecords(LineValidateCallbackProc);
    Result:= AllLinesValid;*)
    Result := ValidateLines;
End;
function TCashBase.UpdateAccounts: boolean;
var
  CleanNode             : IXMLNode;
  CleanCustomerID       : integer;
  CleanTotalAmountInc   : double;
  CleanGLAccountID      : integer;
  TaxCollectedID        : integer;
  WETTaxID              : integer;

  function Doupdate :boolean;
  begin
      Result := true;
      if Classnameis('TCustomerReturn') then Result:= False
      else if isPOs then
             if (paymethod<>'layby') and (islayby=False) and (islaybypayment=False) then
        else if Classnameis('TPOSLaybyPayment') then
        else if not Classnameis('TPOSLayby') then
            Result := False
        else if not Math.IsZero(TPOSLayby(Self).totalBalance, 0.000001) then
            Result := False;
  end;
begin

  //if (isPOS)  then begin
  if not Doupdate then begin
    Result := True;
    Exit;
  End;
  //BalancePostList.Clear;
  TaxCollectedID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_COLLECTED);
  WETTaxID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_WET);

  CleanNode:= self.CleanXMLNode;
  if assigned(CleanNode) then
  begin
    CleanTotalAmountInc:= GetXMLNodeFloatValue(CleanNode,'TotalAmountInc');
    if InvoiceRefund then begin
       CleanCustomerID:= GetXMLNodeIntegerValue(CleanNode,'CustomerID');
        {  we have clean (original) values so these need to be reversed }
        PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName,
        CleanCustomerID, - CleanTotalAmountInc,btAR);
    End;
    { Old GL Balance }
    CleanGLAccountID:= GetXMLNodeIntegerValue(CleanNode,'GLAccountID');
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      CleanGLAccountID, - CleanTotalAmountInc);

    { Old tax amounts}
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxCollectedID, - (GetXMLNodeFloatValue(CleanNode,'TotalTax') -
                         GetXMLNodeFloatValue(CleanNode,'TotalWETTax')));

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      WETTaxID, - GetXMLNodeFloatValue(CleanNode,'TotalWETTax'));
  end;
    { New customer balance }
  if InvoiceRefund then begin // customer balance updation only for the invoicerefund
    PostList.AddAmount(Customer.ClassName,Customer.BusObjectTableName,
        CustomerID,self.TotalAmountInc,btAR);
  End;
      { Now GL balances ... }
  if not Self.ClassnameIS('TPOSLayby') then begin // this is already done from the layby payment
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        GLAccountId, TotalAmountInc);


  {Tax amounts}
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxCollectedID, (TotalTax - TotalWETTax));

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      WETTaxID, TotalWETTax);
  end;

   {Get balance amounts from lines}
   Lines.IterateRecords(LineBalanceCallbackProc, true);

  Result := True;
end;
Function  TCashBase.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    tillid:= GetAssignedTillID(getPCName());
    Result := inherited DoAfterInsert(Sender);
    if not Result then Exit;
    GLAccountName := UNDEPOSITED_FUNDS;
    SaleDate:= Date;
    SaleDateTime:= now;
    CreationDate:= SaleDate;
end;
procedure TCashBase.LineBalanceCallbackProc(Const Sender: TBusObj;  var Abort: boolean);
var
  CleanNode: IXMLNode;
begin
  CleanNode:= Sender.CleanXMLNode;
  if Assigned(CleanNode) then
  begin
    { Reverse old values }
    { Income }
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      tcDataUtils.getAccountID(GetXMLNOdeStringValue(CleanNode,'IncomeAccount')),
      - GetXMLNodeFloatValue(CleanNode,'TotalLineAmount'));

    if isInvProduct(GetXMLNOdeStringValue(CleanNode,'ProductType')) then begin
      {COGS}
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(GetXMLNOdeStringValue(CleanNode,'CogsAccount')),
        - (GetXMLNodeFloatValue(CleanNode,'LineCost') *
           GetXMLNodeFloatValue(CleanNode,'QtyShipped')));
      {Asset}
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(GetXMLNOdeStringValue(CleanNode,'AssetAccount')),
        (GetXMLNodeFloatValue(CleanNode,'LineCost') *
         GetXMLNodeFloatValue(CleanNode,'QtyShipped')));
    end;
  end;
  { New balances }
  if TCashLineBase(Sender).Deleted = False then begin
    if self.classnameis('TPOSLayby') then begin // already done by the payments
  (*    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(TCashLineBase(Sender).IncomeAccount),
        0-(TCashLineBase(Sender).TotalLineAmount));*)
    end else begin
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(TCashLineBase(Sender).IncomeAccount),
        TCashLineBase(Sender).TotalLineAmount);
    end;

    if isInvProduct(TCashLineBase(Sender).Product.ProductType) then begin
      {COGS}
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(TCashLineBase(Sender).CogsAccount),
        (TCashLineBase(Sender).LineCost * TCashLineBase(Sender).QtyShipped));
      {Asset}
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
        tcDataUtils.getAccountID(TCashLineBase(Sender).AssetAccount),
        - (TCashLineBase(Sender).LineCost * TCashLineBase(Sender).QtyShipped));
    end;
  end;
end;
class function  TCashBase.GetIDField :String;
begin
    Result := 'SaleID';
end;
class function TCashBase.GetBusObjectTablename: string;
begin
  Result := 'tblSales';
end;
function  TCashBase.GetSQL:String ;
begin
    // binny : don't change the vlaue of fSQL here as the pos has already set it, if reauired do in the descendants
    // fSQL := 'select * from tbl_Sale';
    Result := inherited GetSQL;
end;
procedure TCashBase.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled = False then Exit;
    inherited;
    if Sysutils.SameText(Sender.fieldName ,'CustomerName') then begin
        ClientId := TClient.IDToggle(CustomerName, Connection.Connection);
        if not RawMode then begin
          if ClientID > 0 then begin
            DofieldChange := False;
            DoFieldOnChange(Dataset.Findfield('ClientID'));
          end;
        end;
    end else if Sysutils.SameText(Sender.FieldName , 'EmployeeName') then begin
      EmployeeID := tcDataUtils.GetEmployeeID(EmployeeName);
      if not RawMode then begin
        DoFieldOnChange(Dataset.findfield('EmployeeID'));
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'ClassID') then begin
        if not RawMode then begin
          if (not Assigned(fSaleClass)) or (SaleClassId <> fSaleClass.ID) then begin
            if Assigned(fSaleClass) then FreeAndNil(fSaleClass);
            SaleClassId := SaleClass.Id;
          End;
          if SaleClassName <> SaleClass.DeptClassName then
            SaleClassName := SaleClass.DeptClassName
        end;
    end  else if Sysutils.SameText(Sender.FieldName , 'Class') then begin
        if not RawMode then begin
          if (not Assigned(fSaleClass)) or (SaleClassId <> fSaleClass.ID) then begin
            if Assigned(fSaleClass) then FreeAndNil(fSaleClass);
            SaleClassId := tcdatautils.GetDeptID(SaleClassName);
          End;
        end;
    end else if Sysutils.SameText(Sender.fieldName , 'saledate') then begin
        if not RawMode then begin
          Shipdate := saledate;
          duedate  := shipDate;
        end;
    end else  if Sysutils.SameText(Sender.fieldName ,'ClientID') then begin
        if not RawMode then begin
          SaleDate        := Date;
          DueDate         := Date;
          IsCashSale      := (Self is TCashSale) or (self is TPOSCashSale);
          IsRefund        := (Self is TRefundSale) and (not(self is TCustomerReturn));
          SaleClassId     := AppEnv.DefaultClass.ClassID;
          SaleClassName   := AppEnv.DefaultClass.DefaultClassName;
          EmployeeId      := AppEnv.Employee.EmployeeID;
          EmployeeName    := AppEnv.Employee.EmployeeName;
          //InvoiceToDesc   := Customer.ShipToAddress;
          InvoiceToDesc   := ConcatStrings([Customer.ClientName ,iif(not(sametext(Customer.ClientName,contactName)), contactName,''),
                                            Customer.street,
                                            Customer.street2,
                                            Customer.street3 ,
                                            ConcatStrings([Customer.Suburb , Customer.State , Customer.Postcode], ' ')] , chr(13)+chr(10));
          ShipToDesc      := Customer.ShipToAddress;
          PostDB;
          DocNumber       := IntToStr(ID);
        end;
    end else if Sysutils.SameText(Sender.fieldName ,'InvoiceDocNumber') then begin
        if not RawMode then begin
          if docnumber = '' then begin
              PostDB; // enforce posting to generate the id
              DocNumber       := IntToStr(ID);
          end;
        end;
    end else if Sysutils.SameText(Sender.fieldName ,'Account') then begin
        GLAccountId := tcdatautils.GetAccountID(GLAccountName);
    end else if Sysutils.SameText(Sender.fieldName ,'AccountID') then begin
        GLAccountName := tcdatautils.GetAccountNAme(GLAccountID);
    end else if Sysutils.SameText(Sender.FieldName , 'Paymethod') then begin
        if not RawMode then begin
          if SalesPayments.count = 1 then
              if SalesPayments.paymethod = Sender.AsString then Exit;
          if Sender.AsString <> Pay_SPLIT then
              SalesPayments.IterateRecords(DeletePayments, True);
        end;
    end else if Sysutils.SameText(Sender.fieldName ,'Class') then begin
        SaleClassId := tcDatautils.GetDeptID(SaleClassName);
    end;
end;
{TCashLineBase}
class function  TCashLineBase.GetIDField :String;
begin
    Result := 'SaleLineID';
end;
class function TCashLineBase.GetBusObjectTablename: string;
begin
  Result := 'tblSaleslines';
end;
procedure TCashLineBase.GetProductDetails;
begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_OnProductChange, Self);
    inherited;
    (*LinePrice := Product.SellQty1Price;
    LinePriceInc:= GetAmountInc(LinePrice, LineTaxRate);*)
end;
procedure TCashLineBase.GetBaseLinePrice;
begin
  if  (LinePrice=  0) then
  else
    if (not(CalcQtyFromformula)) and (not(AddingAlternateProduct)) and Appenv.companyPrefs.ConfirmBeforesalePricechange and (not InternalQuantityChange) then
        if  ((not (Assigned(confirmFromGUI)))  or
            (fconfirmFromGUI('Sale Price '+FloatToStrF(LinePriceinc , ffCurrency , 15, CurrencyroundPlaces)+' Already Entered.' +chr(13)+
            'Changing the Quantity Will Recalculate the Price.' +chr(13) +chr(13) +
            'Do you Wish To Keep the Price?'  , [mbYes, mbNo]) = mryes)) then Exit;
    inherited;
    LinePriceInc:= GetAmountInc(LinePrice, LineTaxRate);
end;

function TCashLineBase.DoBeforePost(Sender: TDatasetBusObj): boolean;
var
  SaveDoFieldChange: boolean;
begin
    if (ProductId = 0) and ((ProductName = '') or (TProduct.IDToggle(ProductName,Connection.Connection) = 0)) then begin
      if not RawMode then begin
        SaveDoFieldChange := DoFieldChange;
        DoFieldChange := False;
        Try
            Deleted := True;
        finally
            DoFieldChange := SaveDoFieldChange;
        end;
        Result := True;
        Exit;
      end;
    end;
    Result := True;
end;
Function TCashLineBase.ValidateData :boolean ;
begin
    Result := inherited ValidateData;
    if not Result then exit;
end;
class function TCashLineBase._Schema: string;
begin
  Result := inherited;
end;

procedure   TCashLineBase.LoadFromXMLNode(Const node: IXMLNode);
begin
    Inherited;
end;
Procedure TCashLineBase.CreateInstance;
begin
    if Owner is TCashbase then
        if Assigned(TCashbase(Owner).ObjInstanceToClone) then
            ObjInstanceToClone :=TCashbase(TCashbase(Owner).ObjInstanceToClone).Lines;
End;
procedure   TCashLineBase.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
end;
constructor TCashLineBase.Create(AOwner: TComponent);
begin
    inherited;
    fSQL:= 'SELECT * From tblSaleslines';
    if Self.convertingQuote then
        FieldsnotToclone:=  ExcludeFromclone+','+
                            QuotedStr('saleID')+',' +
                            QuotedStr('Globalref')+',' +
                            QuotedStr('Shipped')+',' +
                            QuotedStr('UnitofMeasureShipped')+',' +
                            QuotedStr('BackOrder')+',' +
                            QuotedStr('UnitofMeasureBackorder')+',' +
                            QuotedStr('Invoiced');

end;
Procedure TCashLineBase.CalcLineTotals;
begin
    if self.Id = 0 then
      exit;
    Invoiced:= (not Math.IsZero(QtyShipped, 0.0000001));
    inherited;
end;
Function  TCashLineBase.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    inherited DoAfterInsert(Sender);
    Deleted := False;
    if Assigned(Self.Owner) then
        if Self.Owner is TSalesBase then begin
            TSalesBase(Self.Owner).PostDB;
            Self.SaleId := TSalesBase(Self.Owner).ID;
        end;
    Result := True;
end;
function  TCashLineBase.GetSQL:String ;
begin
    // binny : don't change the vlaue of fSQL here as the pos has already set it, if reauired do in the descendants
    //fSQL:= 'SELECT * From tblSaleslines';
    Result := inherited GetSQL;
end;
procedure TCashLineBase.CheckFordiscontinuedProduct;
var
  fdQtyAvailableForDiscontinuedProduct :Double;
begin
  if QtyShipped > 0 then {if not refunding}
    if Product.IsDiscontinued then begin
        fdQtyAvailableForDiscontinuedProduct := Round(TProductClass.AvailableQty(ProductID,ClassId) - ShippedQtyforProductInthisSale, RoundPlacesGeneral);
        if fdQtyAvailableForDiscontinuedProduct <0 then fdQtyAvailableForDiscontinuedProduct := 0;
        if QtyShipped > fdQtyAvailableForDiscontinuedProduct then begin
          QtyrequiredforAlternateProduct :=QtyShipped -fdQtyAvailableForDiscontinuedProduct;
            QtyShipped := fdQtyAvailableForDiscontinuedProduct;
          if QtyrequiredforAlternateProduct >0 then
            AddEvent(BusobjEvent_ToDo, BusobjEventVal_ChooseAlternateProduct, Self.ID);
        end;
    end;
end;
procedure TCashLineBase.DoFieldOnChange(Sender: TField);
var
    fdOldtot, fdOldtotInc :Double;
begin
    fdOldTot := totalLineamount;
    fdOldTotInc := totalLineamountInc;
    Try
        if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
            if DoFieldChangewhenDisabled = False then Exit;
        inherited;
        if Sysutils.SameText(Sender.fieldName ,'ProductID') then begin
          If self.ProductId<>0 then Begin
            ProductName:= TProduct.IDToggle(ProductID, Connection.Connection);
              if not RawMode then begin
                Product.Load(ProductID);
    //            if ProductName = '' then productName := tcdataUtils.GetProduct(ProductID);
                if SaleId = 0 then
                    if (Assigned(Self.Owner)) and (Self.Owner is TCashBase) then
                        SaleId := TCashBase(Self.Owner).ID;
                GetProductDetails;
                (*self.GetBaseLinePrice;
                CalcLineTotals;         *)
              end;
              if not RunningEventListEvents then AddEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, Self.ID);
          End;
        end else if Sysutils.SameText(Sender.fieldName ,'ProductName') then begin
          ProductID:= TProduct.IDToggle(ProductName, Connection.Connection);
          if not RawMode then begin
            if ProductId > 0 then begin
              Deleted := false;
              PostDb;
              Product.LoadSelect('PartName = ' + QuotedStr(self.ProductName));
  //            ProductID := tcDataUtils.GetProduct(ProductName);
              if ProductID = 0 then begin
                self.ProductName:= '';
              end;
              DoFieldOnChange(Dataset.findField('ProductID'));
              Exit;
            end;
          end;
        end else if Sysutils.SameText(Sender.FieldName , 'QtySold') then begin
          if not RawMode then begin
            AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'Shipped') then begin
          if not RawMode then begin
            {discontinued products - shipped qty cannot be greater than the available qty}
            CheckFordiscontinuedProduct;
            Qtysold         := QtyShipped;
            UOMQtyShipped   := Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);
            UOMQtySold      := UOMQtyShipped;
            QtyBackOrder    := 0;
            UOMQtyBackOrder := 0;
            self.GetBaseLinePrice;
            CalcLineTotals;
            AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
            AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'UnitofMeasureShipped') then begin
          if not RawMode then begin
            if not ISoktoShip then exit;
            QtyShipped      := CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral);
            PostDB;
            DofieldChange := False;
            Self.DoFieldOnChange(Dataset.FindField('shipped'));
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'LinePrice') then begin
          if not RawMode then begin
            OriginalLinePrice   := self.LinePrice;
            DiscountAmount      := 0;
            DiscountPercent     := 0;
            MarkupAmount        := 0;
            MarkupPercent       := 0;
            if not fbAddingRelatedProducts then CheckSaveSpecialPrice;
            CalcLineTotals;
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'LinePriceInc') then begin
          if not RawMode then begin
            DiscountPercent     := 0;
            LinePrice           := LinePriceInc * (1 / (1 + LineTaxRate));
            OriginalLinePrice   := LinePrice;
            if not fbAddingRelatedProducts then CheckSaveSpecialPrice;
            CalcLineTotals;
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'LineCostInc') then begin
          if not RawMode then begin
            LineCost := GetAmountEx(LineCostInc , Product.TaxPurchase.Rate);
          end;
        end else if Sysutils.SameText(Sender.fieldName ,'LineCost') then begin
          if not RawMode then begin
            LineCostInc := GetAmountEx(LineCost , Product.TaxPurchase.Rate);
          end;
        end;
    Finally
      if not RawMode then begin
        if (not Math.SameValue(fdOldTot, totalLineamount, 0.000001)) or (not MAth.SameValue(fdOldTotInc, totalLineamountInc, 0.000001)) or
              ((Sysutils.SameText(Sender.fieldName , 'Deleted' ) and Deleted ) )  then
              if Assigned(Self.Owner) then if Self.Owner is TCashbase then
                  TCashbase(Owner).DoCalcOrderTotals;
      end;
    end;
end;

function TCashLineBase.ISoktoShip: Boolean;
var
  fdAvailQty:Double;
begin
  Result := TRue;
  if not result then exit;
  if SilentMode then exit;
  if UOMQtyShipped <= CleanUOMQtyShipped then exit;
  if Product.ProductType <> 'INV' then exit;

    if appenv.CompanyPrefs.NegativeStockcheckinInvoicebasedon = 'A' then
       fdAvailQty := TProductClass.AvailableQty(ProductID,TCashBase(self.Owner).SaleClassId, connection.Connection)  (*+ cleanQty*)
  else fdAvailQty := TProductClass.ProductInStockQty(ProductID,TCashBase(self.Owner).SaleClassId, connection.Connection)  (*+ cleanQty*);
  fdAvailQty := fdAvailQty + dataset.fieldbyname('shipped').oldValue;

  if fdAvailQty < UOMQtyShipped* UOMMultiplier then begin
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowInvoiceStockToNegative') >1 then begin
      ResultStatus.AddItem(False , rssWarning, 0 , 'The Stock on Hand for product '+ProductName +' is ' +floattoStr(fdAvailQty)+'.'+
                          chr(13)+'Shipping ' +floattoStr(UOMQtyShipped) +' ' +UnitOfMeasure +' will cause a negative stock in your Product List.' +
                          chr(13) +chr(13) +'No rights to create negative stock transaction' );
      Result := False;
      PostDB;
        UOMQtyShipped := cleanUOMQtyShipped;
        QtyShipped := CleanQtyShipped;
      Exit;
    end;

    if AppEnv.CompanyPrefs.ConfirmBeforeInvoiceStockToNegative =False then exit;
    if Assigned(confirmFromGUI) then
      if fconfirmFromGUI('The Stock on Hand for product '+ProductName +' is ' +floattoStr(fdAvailQty)+'.'+
                          chr(13)+'Shipping ' +floattoStr(UOMQtyShipped) +' ' +UnitOfMeasure +' will cause a negative stock in your Product List.' +
                          chr(13)+chr(13)+'Do you wish to continue?' , [mbYes, mbNo]) = mrno then begin
        Result := False;
        PostDB;
        UOMQtyShipped := cleanUOMQtyShipped;
        QtyShipped := CleanQtyShipped;
        Exit;
      end;
  end;
end;
Function TCashLineBase.GetCalcPriceInc           : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcPriceInc') <> nil then
        Result := getFloatfield('CalcPriceInc');
end;
Function TCashLineBase.GetCalcTotalInc           : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcTotalInc') <> nil then
        Result := getFloatfield('CalcTotalInc');
end;
Function TCashLineBase.GetCalcTotalEx            : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcTotalEx') <> nil then
        Result := getFloatfield('CalcTotalEx');
end;
Function TCashLineBase.GetCalcTax                : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcTax') <> nil then
        Result := getFloatfield('CalcTax');
end;
Function TCashLineBase.GetCalcBackOrder          : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcBackOrder') <> nil then
        Result := getFloatfield('CalcBackOrder');
end;
Function TCashLineBase.GetCalcLinePriceEx        : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcLinePriceEx') <> nil then
        Result := getFloatfield('CalcLinePriceEx');
end;
Function TCashLineBase.GetCalcTotalIncB4Discount : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcTotalIncB4Discount') <> nil then
        Result := getFloatfield('CalcTotalIncB4Discount');
end;
Function TCashLineBase.getCalcGrossProfitPercInc : Double;
begin
    Result := 0;
    if Dataset.findfield('CalcGrossProfitPercentInc') <> nil then
        Result := getFloatfield('CalcGrossProfitPercentInc');
end;

Procedure TCashLineBase.SetCalcPriceInc           (Const Value :Double);
begin
    if Dataset.findfield('CalcPriceInc') <> nil then
        Setfloatfield('CalcPriceInc' , value);
end;
Procedure TCashLineBase.SetCalcTotalInc           (Const Value :Double);
begin
    if Dataset.findfield('CalcTotalInc') <> nil then
        Setfloatfield('CalcTotalInc' , value);
end;
Procedure TCashLineBase.SetCalcTotalEx            (Const Value :Double);
begin
    if Dataset.findfield('CalcTotalEx') <> nil then
        Setfloatfield('CalcTotalEx' , value);
end;
Procedure TCashLineBase.SetCalcTax                (Const Value :Double);
begin
    if Dataset.findfield('CalcTax') <> nil then
        Setfloatfield('CalcTax' , value);
end;
Procedure TCashLineBase.SetCalcBackOrder          (Const Value :Double);
begin
    if Dataset.findfield('CalcBackOrder') <> nil then
        Setfloatfield('CalcBackOrder' , value);
end;
Procedure TCashLineBase.SetCalcLinePriceEx        (Const Value :Double);
begin
    if Dataset.findfield('CalcLinePriceEx') <> nil then
        Setfloatfield('CalcLinePriceEx' , value);
end;
Procedure TCashLineBase.SetCalcTotalIncB4Discount (Const Value :Double);
begin
    if Dataset.findfield('CalcTotalIncB4Discount') <> nil then
        Setfloatfield('CalcTotalIncB4Discount' , value);
end;
Procedure TCashLineBase.SetCalcGrossProfitPercInc(Const Value :Double);
begin
    if Dataset.findfield('CalcGrossProfitPercentInc') <> nil then
        Setfloatfield('CalcGrossProfitPercentInc' , value);
end;
procedure TCashLineBase.SetTransDate(const Value: TDatetime);
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TCashBase then
            TCashBase(Self.Owner).SaleDateTime := value;
end;

function TCashLineBase.GetTransDate: TDatetime;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TCashBase then
            Result := TCashBase(Self.Owner).SaleDateTime;
end;




{TSalesPayments}
function  TSalesPayments.GetSQL:String ;
begin
    Result := inherited GetSQL;
end;
function TSalesPayments.GetAmountTendered: double;
begin
  result := GetFloatField('AmountTendered');
end;

procedure TSalesPayments.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled = False then Exit;
    inherited;
end;
class function  TSalesPayments.GetIDField :String;
begin
    Result := 'PaymentID';
end;
class function TSalesPayments.GetBusObjectTablename: string;
begin
  Result := 'tblsalespayments';
end;

Procedure   TSalesPayments.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(node,'PayMethod');
    SetPropertyFromNode(node,'Amount');
    SetPropertyFromNode(node,'Ref');
    SetBooleanPropertyFromNode(node,'Deleted');
end;
Procedure   TSalesPayments.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node , 'PayMethod',PayMethod);
    AddXMLNode(node , 'Amount',Amount);
    AddXMLNode(node , 'Ref',Ref);
    AddXMLNode(node , 'Deleted',Deleted);
end;

Constructor TSalesPayments.Create(AOwner :TComponent);
begin
    inherited Create(AOwner);
    fSQL:= 'SELECT * From tblsalespayments';
    ExportExcludeList.Add('saleid');
    fIsList:= true;
end;

function TSalesPayments.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    Result := False;
    if (not SilentMode) and (not ValidateData) then begin
        try
          abort;
        except
        end;
        Exit;
    end;
    Result := True;
end;

function TSalesPayments.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TSalesBase then
            SaleID := TSalesBase(Self.Owner).ID;
    Deleted := False;
    Result := True;
end;

function    TSalesPayments.ValidateData:   Boolean;
begin
    Result := True;
    if Dataset.Recordcount = 0 then Exit;
    if Deleted then Exit; // no need to validate deleted records as they will be physically deleted later
    if (Paymethod = '') and (amount = 0) and (Ref = '') and (Dataset.State = dsInsert) and (not RawMode) then begin
        Deleted := True;
        Exit;
    end;
    if PayMethod = '' then begin
        ResultStatus.AddItem(False, rssWarning , 0 , 'Payment method should not be blank' );
        Result := False;
        Exit;
    end;
    if TPaymentMethod.IDToggle(PayMethod,self.Connection.Connection) < 1 then begin
        ResultStatus.AddItem(False, rssWarning , 0 , 'Unknown Payment Method "' + PayMethod + '"');
        Result := False;
        Exit;
    end;
end;

Function TSalesPayments.Save :Boolean;
begin
    PostDB;
    Result := False;
    if not ValidateData then Exit;
    Result := True;
    if (not RawMode) and Assigned(Self.Owner) then
        if Self.Owner is TCashBase then
            Result  := TCashBase(Self.Owner).UpdatePaymentData;

end;
Function TSalesPayments.GetSaleID:integer	;
begin
    Result := getintegerField('SaleID');
End;
Function TSalesPayments.GetPayMethod:String	;
begin
    Result := getStringField('PayMethod');
End;
Function TSalesPayments.GetAmount:Double	;
begin
    Result := getFloatField('Amount');
End;
Function TSalesPayments.GetRef:String	;
begin
    Result := getStringField('Ref');
End;
Function TSalesPayments.GetDeleted:Boolean	;
begin
    Result := getBooleanField('Deleted');
End;

Procedure TSalesPayments.SetSaleID(Const Value :integer	);
Begin
	Setintegerfield('SaleID' , value);
End;

procedure TSalesPayments.SetAmountTendered(const Value: double);
begin
  SetFloatField('AmountTendered',Value);
end;

Procedure TSalesPayments.SetPayMethod(Const Value :String	);
Begin
	SetStringfield('PayMethod' , value);
End;
Procedure TSalesPayments.SetAmount(Const Value :Double	);
Begin
	setFloatField('Amount' , value);
End;
Procedure TSalesPayments.SetRef(Const Value :String	);
Begin
	SetStringfield('Ref' , value);
End;
Procedure TSalesPayments.SetDeleted(Const Value :Boolean	);
Begin
	SetBooleanfield('Deleted' , value);
End;

{TRefundSale}
procedure TRefundSale.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled = False then Exit;
    inherited;
    if Sysutils.SameText(Sender.fieldName ,'ClientID') then begin
      if not RawMode then begin
        InitARAccount;
        Self.TermsName :=  Customer.TermsName;
        if  not Terms.Active then Self.TermsName := TERMS_ON_RCPT;
        DoFieldOnChange(Dataset.findField('Terms'));
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'Terms') then begin
      if not RawMode then begin
        if not AppEnv.CompanyPrefs.UseShippedDateForTerms then
            SetPaymentTerms(SaleDate)
        else SetPaymentTerms(ShipDate);
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'SaleDate') then begin
      if not RawMode then begin
        if not AppEnv.CompanyPrefs.UseShippedDateForTerms then
            SetPaymentTerms(SaleDate)
        else SetPaymentTerms(ShipDate);
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'ShipDate') then begin
      if not RawMode then begin
        if not AppEnv.CompanyPrefs.UseShippedDateForTerms then
            SetPaymentTerms(SaleDate)
        else SetPaymentTerms(ShipDate);
      end;
    End;
end;
function TRefundSale.GetRefundLines: TRefundSaleLine;
begin
    Result := TRefundSaleLine(getContainerComponent(TRefundSaleLine, 'SaleID = '+ IntToStr(Self.Id)));
end;
function TRefundSale.getRefundStatus: String;
begin
  Result := getStringfield('QuoteStatus');
end;

function TRefundSale.GetSaleLines: TSalesLineBase;
begin
   Result:= self.GetREfundLines;
end;
function TRefundSale.GetSQL:STring;
begin
    Result := inherited GetSQL;
end;
function TRefundSale.GetTransStatus: String;
begin
  Result := refundstatus;
end;

function TRefundSale.GetLines: TTransLineBase;
begin
    Result:= self.GetREfundLines;
end;

(*function TRefundSale.getRefundCheque: TCheque;
begin
  Result := TCheque(getContainerComponent(TCheque , 'RefundGlobalref = ' + Quotedstr(Globalref) , Self.SilentMode ) );
end;*)
Function TRefundSale.MakeSupp:Boolean;
var
  cust : TCustomer;
begin
      REsult := True;
      cust := TCustomer.CreateWithNewConn(nil);
      try
        cust.Load(CustomerID);
        if not cust.Supplier then begin
          if cust.Lock then begin
            try
              cust.Supplier := true;
              cust.PostDb;
          finally
            cust.UnLock;
          end;
        end else begin
          REsult := False;
          MessageDlgXP_Vista('Unable to lock ' + cust.ClientName +
            ' for conversion to supplier: ' + cust.UserLock.LockMessage, mtWarning, [mbOk], 0);
          exit;
        end;
      end;
    finally
      cust.Free;
    end;
end;

Function TRefundSale.HAscheque:Boolean;
begin
  REsult := False;
  if Paymethod = CHEQUE then begin
    REsult := True;
    Exit;
  end;
  if SalesPayments.count =0 then exit;
  SalesPayments.First;
  While SalesPayments.Eof = False do begin
    if (SalesPayments.Paymethod = CHEQUE) and (SalesPayments.Amount <> 0) then begin
      REsult := True;
      Exit;
    end;
    SalesPayments.next;
  end;
end;

Function TRefundSale.MakenUpdatecheque:Boolean;
var
  ChequeObj : TCheque;
  sRef:STring;
begin
  Connection.BeginNestedTransaction;
  try
      ChequeObj := TCheque.create(nil); // Owner nil to avoid useing the forms dataset
      Try
        ChequeObj.connection := Self.Connection;
        ChequeObj.loadselect('ifnull(RefundGlobalref , "") <> "" and ifnull(RefundGlobalref, "") = ' +quotedstr(Globalref) +' and IsRefundCheque ="T"');

        {non cheque refund}
        if ChequeObj.count >0 then begin
          if  (*(Paymethod <> CHEQUE)*)not(Hascheque) or InvoiceRefund or (TotalAmountInc = 0) or (CustomerID = 0) then begin
            ChequeObj.Lines.DeleteAll;
            ChequeObj.Deleted := True;
            ChequeObj.Chequetotal :=0; // to enable saving
            ChequeObj.Save;
            Result := True;
            Exit;
          end;
        end;

        if Hascheque then begin
          if ChequeObj.count =0 then begin
              if not MakeSupp then begin
                Result := False;
                exit;
              end;
              ChequeObj.New;
              ChequeObj.SupplierId := CustomerID;
              ChequeObj.IsREfundCheque := TRue;
              ChequeObj.RefundGlobalref := GlobalRef;
              ChequeObj.Comments := 'Payment for Refund Number: ' + DocNumber;
              if self.SaleDate > AppEnv.CompanyPrefs.ClosingDate  then
                ChequeObj.OrderDate := self.SaleDate
              else
                self.SaleDate := Date;
              ChequeObj.PostDB;
          end;
          if not ChequeObj.Lines.locate( 'Product_Description' , 'Refund Number ' + DocNumber , []) then begin
              ChequeObj.Lines.New;
              ChequeObj.Lines.AccountName := GLAccountName;
              ChequeObj.Lines.LineTaxCode := AppEnv.RegionalOptions.TaxCodeNoTax;
              ChequeObj.Lines.LineCostInc := 0;
              ChequeObj.Lines.ProductDescription:= 'Refund Number ' + DocNumber;
              ChequeObj.Lines.PostDb;
              ChequeObj.Lines.LineCostInc := 0;
              ChequeObj.Lines.PostDB;
          end else begin
              ChequeObj.Lines.LineCostInc := 0;
              ChequeObj.Lines.PostDB;
          end;
          sRef:='';
          SalesPayments.First;
          While SalesPayments.Eof = False do begin
            if (SalesPayments.Paymethod = CHEQUE) and (SalesPayments.Amount <> 0) then begin
              sRef:= trim(sRef) + ' ' +SalesPayments.Ref;
              ChequeObj.Lines.LineCostInc := ChequeObj.Lines.LineCostInc + 0-SalesPayments.Amount ;
              ChequeObj.Lines.PostDB;
            end;
            SalesPayments.Next;
          end;
          if sRef<> '' then ChequeObj.RefNo := sRef;
          ChequeObj.CalcOrderTotals;
          ChequeObj.Chequetotal :=0; // to enable saving
          if not ChequeObj.Save then begin
            REsult := False;
            Connection.RollbacknestedTransaction;
            Exit;
          end;
        end;
        Connection.CommitnestedTransaction;
      Finally
        FreeandNil(ChequeObj);
      End;
      REsult := TRue;
  Except
    on E:Exception do begin
      REsult := False;
      Connection.RollbacknestedTransaction;
    end;

  end;
end;
function TRefundSale.Save: boolean;
begin
    Result := inherited Save;
    if not RawMode then ProcessPQADetailClasses;
    if Result then dirty := false;
end;
procedure TRefundSale.setRefundStatus(const Value: String);
begin
  SetStringfield('QuoteStatus' , Value);
end;
procedure TRefundSale.SetTransStatus(const Value: String);
begin
  inherited;
  Refundstatus := Value;
end;

function TRefundSale.ValidateData: boolean;
begin
  result := inherited ValidateData;
  if not result then exit;
  REsult := MakenUpdatecheque;
end;

function TRefundSale.getCustomerReturnRef: String;
begin
  Result:= getStringfield('CustomerReturnRef');
end;
procedure TRefundSale.setCustomerReturnRef(const Value: String);
begin
  SetStringfield('CustomerReturnRef' , Value);
end;
constructor TRefundSale.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * From tblSales';
  fSQLSelect := 'IsRefund = "T"'
end;

Function  TRefundSale.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    inherited DoAfterInsert(Sender);
    IsCashSale             := False;
    IsRefund               := True;
    ISCustomerReturn       := False;
    IsInvoice              := False;
    IsSalesOrder           := False;
    IsQuote                := False;
    IsPOS                  := False;
    InvoiceRefund          := True;
    InitARAccount;//GLAccountID            := AppEnv.CompanyPrefs.DefaultSalesAccount;
    Result                 := True;
    PostDB;
end;
{TRefundSaleLine}
function  TRefundSaleLine.GetSQL:String ;
begin
    Result := inherited GetSQL;
end;
constructor TRefundSaleLine.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * From tblSaleslines';
end;

procedure TRefundSaleLine.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled = False then Exit;
    inherited;
    if Sysutils.SameText(Sender.fieldName ,'RefundQty') then begin
      if not RawMode then begin
        UOMQtyShipped   := -(Sender.AsFloat);
        FormulaQtySoldValue := FormulaQtyShippedValue;
        FormulaQtySoldValue1:= FormulaQtyShippedValue1;
        FormulaQtySoldValue2 := FormulaQtyShippedValue2;
        FormulaQtySoldValue3 := FormulaQtyShippedValue3;
        FormulaQtySoldValue4 := FormulaQtyShippedValue4;
        FormulaQtySoldValue5 := FormulaQtyShippedValue5;
        QtyShipped      :=CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral);
        PostDB;
        Self.DoFieldOnChange(Dataset.findField('Shipped')); // calculate other qtys
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'Shipped') then begin
      if not RawMode then begin
        RefundQty:= -UOMQtyShipped;
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'UnitOfMeasureShipped') then begin
      if not RawMode then begin
        RefundQty:= -UOMQtyShipped;
      end;
    end else if Sysutils.SameText(Sender.fieldName ,'ProductID') then begin
    end else if Sysutils.SameText(Sender.fieldName ,'UnitofMeasureSaleLines') then begin
      if not RawMode then begin
        // inherited had updated the uomqtys, so update the refund
        RefundQty := -(UOMQtyShipped);
      end;
    End;
end;

function TRefundSaleLine.Getalloctype: String;
begin
  Result := 'IN';
end;

procedure TRefundSaleLine.GetBaseLinePrice;
begin
  if RefundedSalesLineID <> 0 then
    // if its a sales refund, the price sould not be recalculated
  else inherited;
end;

function TRefundSaleLine.GetQty: Double;
begin
  Result := CommonLib.Round(RefundQty * UOMMultiplier, self.RoundPlacesGeneral);
end;

function TRefundSaleLine.GetUOMQty: Double;
begin
  Result := RefundQty;
end;

function TRefundSaleLine.GetOrderQty: Double;
begin
  Result := -(QtyShipped);
end;

function TRefundSaleLine.GetUOMOrderQty: Double;
begin
   Result := refundQty;
end;

procedure TRefundSaleLine.SetOrderQty(const Value: Double);
begin
  Qtyshipped := -(Value);
end;

procedure TRefundSaleLine.SetUOMOrderQty(const Value: Double);
begin
 refundQty := Value;
end;

function TRefundSaleLine.ValidateData: boolean;
begin
  Result := inherited validateData;
  if not Result then exit;
        FormulaQtySoldValue := FormulaQtyShippedValue;
        FormulaQtySoldValue1:= FormulaQtyShippedValue1;
        FormulaQtySoldValue2 := FormulaQtyShippedValue2;
        FormulaQtySoldValue3 := FormulaQtyShippedValue3;
        FormulaQtySoldValue4 := FormulaQtyShippedValue4;
        FormulaQtySoldValue5 := FormulaQtyShippedValue5;
end;

{TCashSale}
function TCashSale.GetSQL:STring;
begin
  Result := inherited GetSQL;
end;

function TCashBase.HasAnyvoucher: Boolean;
begin
  With GetNewDataset('Select SaleLineId from tblsaleslines where saleId = ' +inttostr(ID) +' and ISVoucher ="T" and ifnull(voucherno,"") <> "" ' , true) do try
    Result:= recordcount >0;
  finally
    if active then close;
    Free;
  end;
end;

function TCashSale.getCashSaleLines: TCashSaleLine;
begin
    Result := TCashSaleLine(getContainerComponent(TCashSaleLine, 'SaleID = '+ IntToStr(Self.Id)));
end;

function TCashSale.GetSaleLines: TSalesLineBase;
begin
    Result:= self.getCashSaleLines;
end;

function TCashSale.GetLines: TTransLineBase;
begin
    Result:= self.getCashSaleLines;
end;

procedure TCashSale.AfterCopy;
begin
  inherited;
  if self.PayMethod = '' then begin
    if self.Customer.PaymentMethodName <> '' then
      self.PayMethod := self.Customer.PaymentMethodName
    else
      self.PayMethod := PAY_CASH;
  end;

end;

Function  TCashSale.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    inherited DoAfterInsert(Sender);
    IsCashSale             := True;
    IsRefund               := False;
    ISCustomerReturn       := False;
    IsInvoice              := False;
    IsSalesOrder           := False;
    IsQuote                := False;
    IsPOS                  := False;
    Result                 := True;
    //PayMethod              := PAY_CASH;
    postdb;
end;
Procedure TCashSale.DoFieldOnChange(Sender :TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled = False then Exit;
    inherited;
    if Sysutils.SameText(Sender.fieldName ,'ClientID') then begin
        if (not RawMode) and Customer.IsJob then if Customer.WarrantyFinishDate > 0 then
            if Customer.WarrantyFinishDate< DAte then
                ResultStatus.AddItem( True , rssWarning ,0  ,
                    'The warranty of this job is out of Date ' + NL +
                    'The warranty finish date is ' + FormatDatetime('dd/mm/yyyy' , Customer.WarrantyFinishDate));
    end;

end;
Function  TCashSale.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
    inherited DoAfterPost(Sender );
    Result          := True;
end;


function TCashSale.Save: boolean;
begin
  Result := True;
    try
      Result := inherited Save;
      if not RawMode then
        ProcessPQADetailClasses;
      if Result then dirty := false;
    finally
      if (not RawMode) and Result then begin
        RewardPoints;
        lines.IterateRecords(updateCustomerEquipQty);
      end;
    end;
end;

function TCashSale.ValidateData: boolean;
begin
    Result:= inherited ValidateData;
    if not Result then exit;
end;
{TCashSaleLine}

function  TCashSaleLine.GetSQL:String ;
begin
    Result := inherited GetSQL;
end;
function TCashSaleLine.GetOrderQty: Double;
begin
  Result := QtyShipped;
end;

function TCashSaleLine.GetUOMOrderQty: Double;
begin
  Result := UOMQtyShipped;
end;

procedure TCashSaleLine.SetOrderQty(const Value: Double);
begin
  QtyShipped := Value;

end;

procedure TCashSaleLine.SetUOMOrderQty(const Value: Double);
begin
  UOMQtyShipped := Value;

end;
constructor TCashSaleLine.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * From tblSaleslines';
end;

function TCashSaleLine.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not (Result) then exit;
end;

Function  TCashSaleLine.DoCalcFields(Sender :TDatasetBusObj):Boolean;
begin
  CalcBackOrder         := QtySold - QtyShipped;
  CalcTotalEx           := OriginalLinePrice * QtyShipped;
  CalcPriceInc          := GetAmountInc(OriginalLinePrice , LineTaxRate);
  CalcTotalInc          := GetAmountInc((QtyShipped * OriginalLinePrice) , LineTaxRate);
  CalcTotalIncB4Discount:= CalcTotalInc;
  CalcTotalInc          := CalcTotalInc + MarkupAmount - DiscountAmount;                    //Discount$ & Markup$ Calcs
  CalcTotalInc          := CalcTotalInc +(CalcTotalInc * (MarkupPercent  / 100)); //Discount% & Markup% Calcs
  CalcTotalInc          := CalcTotalInc -(CalcTotalInc * (DiscountPercent/ 100));
  CalcGrossProfitPercInc:= DivZer(LinePriceInc-LineCostInc,LinePriceInc) * 100;// Gross Profit %
  //  CalcProductLatestCost;
  CalcLinePriceEx       := DivZer(CalcTotalInc,QtyShipped)*(100/(100+(LineTaxRate*100))); //New Discounted LinePrice (Ex)
  CalcPriceInc          := CalcLinePriceEx * (1.0 + LineTaxRate);//New Discounted LineTotal (Inc)
  CalcTotalEx           := CalcLinePriceEx * QtyShipped;//New Discounted LineTotal (Ex)
  CalcTax               := CalcTotalInc - CalcTotalEx;//Tax
  Result                := inherited DoCalcFields(Sender); //True;
end;

function TCashSaleLine.GetPQA: TPQA;
begin
//    Self.PostDB;
    Result := TPQA(getContainerComponent(TPQA, 'TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") in ('+QuotedStr(Self.Classname)+',' + QuotedStr(TPOSCashSaleline.Classname) +')'));
    if (ID<> 0) and (Result.count = 0) and (ISPQAItem) then begin
        Result.New;
    end;
end;


{ TCustomerReturnLine }

procedure TCustomerReturnLine.CreateInstance;
begin
    if (Owner is TCustomerReturn) and (TCustomerReturn(Owner).ConvertingToREfund) then
        if Assigned(TCustomerReturn(Owner).ObjInstanceToClone) and (TCustomerReturn(Owner).ObjInstanceToClone is TRefundSale) then begin
            ObjInstanceToClone :=TRefundSale(TCustomerReturn(Owner).ObjInstanceToClone).Lines;
            exit;
        end;
  inherited;
end;

function TCustomerReturnLine.GetAllocType: String;
begin
  Result:= '';
end;

function TCustomerReturnLine.GetIsPQAItem: Boolean;
begin
  Result:= False;
end;

{ TCustomerReturn }

function TCustomerReturn.ConvertTorefund: Integer;
begin
  Result := 0;
  Self.ConvertingToREfund:= True;
  try
  Connection.BeginTransaction;
  try
    if CloneBusObj('saleDate',DateOf(now),False, 'SaleId') <> nil then begin
      TRefundSale(ObjInstanceToClone).Comments := 'Refund Created for customer Return #' + IntToStr(ID) ;
      TRefundSale(ObjInstanceToClone).CustomerReturnRef := Self.Globalref;
      TRefundSale(ObjInstanceToClone).IsCustomerreturn:= False;
      TRefundSale(ObjInstanceToClone).IsRefund:= True;
      TRefundSale(ObjInstanceToClone).PostDB;
      Converted := True;
      postDB;
      if TRefundSale(ObjInstanceToClone).Save then begin
        Result:= ObjInstanceToClone.ID;
        Connection.CommitTransaction;
      end else begin
        connection.RollbackTransaction;
        Result := 0;
      end;
    end;
  except
      on E:Exception do begin
          connection.RollbackTransaction;
      end;
  end;
  finally
    ConvertingToREfund:= False;
  end;
end;

constructor TCustomerReturn.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * From tblSales';
  fSQLSelect := 'ISCustomerReturn = "T" and ISRefund ="F"';
  fbConvertingToREfund:= False;

end;

procedure TCustomerReturn.CreateInstance;
begin
  if ConvertingToREfund then begin
      ObjInstanceToClone := TRefundSale.Create(nil);
      ObjInstanceToClone.connection := self.connection;
      ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
      if Assigned(DoProductallocation) then
          TRefundSale(ObjInstanceToClone).DoProductallocation := DoProductallocation;
      Exit;
  end;
  inherited;
end;

function TCustomerReturn.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then exit;
    IsCustomerReturn := True;
    IsRefund :=  False;
end;

procedure TCustomerReturn.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCustomerReturn.GetLines: TTransLineBase;
begin
   Result:= self.GetCustomerReturnLines;
end;
function TCustomerReturn.GetCustomerReturnLines: TCustomerReturnLine;
begin
      Result := TCustomerReturnLine(getContainerComponent(TCustomerReturnLine, 'SaleID = '+ IntToStr(Self.Id)));
end;
function TCustomerReturn.GetSaleLines: TSalesLineBase;
begin
   Result:= self.GetCustomerReturnLines;
end;
function TCustomerReturn.getConverted: Boolean;begin  Result:= getBooleanField('Converted');end;
procedure TCustomerReturn.setConverted(const Value: Boolean);begin  SetBooleanField('Converted' , Value);end;

initialization
  RegisterClassOnce(TSalesPayments);
  RegisterClassOnce(TCashSaleLine);
  RegisterClassOnce(TRefundSaleLine);
  RegisterClassOnce(TCashSale);
  RegisterClassOnce(TRefundSale);
  RegisterClassOnce(TCustomerReturn);
end.





