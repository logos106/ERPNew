unit busobjExpenses;

interface

uses BusobjOrderbase, busobjtrans, busobjbase, db,
  BusobjABA, busObjBankDepost, tcTypes, XMLDoc, XMLIntf, classes,
  ERPdbComponents, MyAccess , BusobjGoogleAnalytic_ERPlink ,
  BusObjTransLinetotals;

type
    TExpenseLineBase = class(TOrderLineBase)
    Private
        Function  getCalcTotalEx    : Double;
        Function  getCalcPriceInc   : Double;
        Function  getCalcTotalInc   : Double;
        Function  getCalcTax        : Double;
        function GetExpenseProductID              : Integer   ;
        function GetExpenseProductName            : string    ;
        function GetExpenseProductSelected        : string    ;
        Procedure SetCalcTotalEx    (Const Value :Double);
        Procedure SetCalcPriceInc   (Const Value :Double);
        Procedure SetCalcTotalInc   (Const Value :Double);
        Procedure SetCalcTax        (Const Value :Double);
        Procedure UpdateFCAmount;
        procedure SetExpenseProductID              (const Value: Integer   );
        procedure SetExpenseProductName            (const Value: string    );
        procedure SetExpenseProductSelected        (const Value: string    );
    Protected
        procedure DoFieldOnChange       (Sender: TField);       Override;
        Function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
        Function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
        Function DoCalcFields(sender :TDatasetBusObj):Boolean;Override;
        function  GetIsPQAItem:boolean; override;
        function GetLineDesc: String ; override;
        function GetLinedescription: String;Override;
        //Function  GetIsPQAItem:Boolean; Override;
    Public
        Property CalcTotalEx    : Double read getCalcTotalEx  Write setCalcTotalEx;
        Property CalcPriceInc   : Double Read getCalcPriceInc Write setCalcPriceInc;
        Property CalcTotalInc   : Double Read getCalcTotalInc Write SetCalcTotalInc;
        Property CalcTax        : Double Read getCalcTax      Write setCalcTax;
        constructor Create(AOwner: TComponent); override;
        Function    ValidateData        : Boolean;                              Override;
        procedure   CalcLineTotals;                                     override;
        procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
        procedure    SaveToXMLNode(const node: IXMLNode);                   override;
        property ExpenseProductSelected         :string      read GetExpenseProductSelected       write SetExpenseProductSelected        ;
    Published
        property ExpenseProductID               :Integer     read GetExpenseProductID             write SetExpenseProductID          ;
        property ExpenseProductName             :string      read GetExpenseProductName           write SetExpenseProductName        ;
    end;

    TCreditLines = class(TExpenseLineBase)
    Private
        Function GetCleanAccountName :String;
    Public
        Property CleanAccountName :String read getCleanAccountName;
    Protected
        Function DoBeforePost(Sender: TDatasetBusObj): boolean;                Override;
    end;

    TBillLines = class(TExpenseLineBase)
    Private
        Function GetCleanAccountName :String;
        function getGA_ERP_Posting: TGA_ERP_Posting;
    Public
        Property CleanAccountName :String read getCleanAccountName;
        Property GA_ERP_Posting :TGA_ERP_Posting REad getGA_ERP_Posting;
    Protected
        Function DoBeforePost(Sender: TDatasetBusObj): boolean;                Override;
        function DoBeforeDelete(Sender: TDatasetBusObj): Boolean;Override;
    end;

    TChequeLines = class(TExpenseLineBase)
    Private
        Function GetCleanAccountName :String;
        Function HeaderAccountID:Integer;
    Public
        Property CleanAccountName :String read getCleanAccountName;
        procedure DoFieldOnChange       (Sender: TField);       Override;
    Protected
        Function DoBeforePost(Sender: TDatasetBusObj): boolean;                Override;
    end;

    TExpenseBase = class(TOrderBase)
    Private
        dTotTax                 : currency;
        dSubTotal               : currency;
        dTotalAmount            : currency;
        tmpTotalForeignAmount   : currency;
        fbAcctswithoutExpclaim  : Boolean;
        fsAcctsWithoutExpClaim  : String;
        Procedure   getLinestotal(Const Sender: TBusObj; var Abort: boolean);
        Procedure   searchforAcctswithoutExpclaim(Const Sender:TBusObj;var Abort:Boolean);
        function    getBankDeposit :TBankDeposit;
    function getActualTotalPayment: double;

    Protected
        Function    GetExpenseLines    : TExpenseLineBase;                      virtual;
        Function    GetLines           : TTransLineBase;                        override;
        Function    DoAfterInsert      (Sender: TDatasetBusObj): boolean;       Override;
        Function    DoAfterPost        (Sender: TDatasetBusObj): boolean;       Override;
        procedure   DoFieldOnChange   (Sender: TField);                         Override;
        procedure   CalcTotalsCallback(Const Sender:TBusObj;var Abort:Boolean); Override;
        procedure LineValidateCallbackProc(Const Sender: TBusObj; var Abort: boolean);override;
        procedure UpdateAccountTaxcode(Const Sender: TBusObj);
        function getOrderLines: TOrderLineBase;Override;
        function GetTransStatus: String;Override;
        procedure SetTransStatus(const Value: String);Override;
        Procedure ProcessDeletedLine; override;
        function getTransLinetotals: TTransLinetotals;override;
    Public
        property    Lines               : TExpenseLineBase  Read GetExpenseLines;
        Property    BankDeposit         : TBankDeposit      Read GetBankDeposit;
        Procedure   RefreshCalcs;
        procedure   CalcOrderTotals;                                            Override;
        Function    ValidateData        : Boolean;                              Override;
        Function    Save                : Boolean;                              Override;
        Property  ActualTotalPayment :double read getActualTotalPayment;
    end;

    TCredit = class(TExpenseBase)
    Private
        Function GetCreditLines         : TCreditLines;
        Function  UpdateAccounts         : Boolean; reintroduce;
        procedure LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean); reintroduce;
    Protected
      function getApprovaltype: String;override;
        Function  DoAfterInsert(Sender: TDatasetBusObj): boolean;               Override;
        procedure DoFieldOnChange       (Sender: TField);                       Override;
        Function  GetExpenseLines       : TExpenseLineBase;                     Override;
        function getOrderLines: TOrderLineBase;Override;
    Public
        Function    ValidateData        : Boolean;                              Override;
        function  Save                  : Boolean;                              Override;
        procedure PopulateMessageSubstituteList(SL: TStringList); override;
        constructor Create(aOwner: TComponent); override;
    Published
        property Lines                  : TCreditLines Read GetCreditLines;
    end;

    TBill = class(TExpenseBase)
    Private
        fdBilltotal                     : double;
        Function  GetBillLines          : TBillLines;
        Function  UpdateAccounts         : Boolean; reintroduce;
        procedure LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean); reintroduce;
    Protected
        Function DoAfterInsert(Sender: TDatasetBusObj): boolean;                Override;
        Function DoBeforePost(Sender: TDatasetBusObj): boolean;                Override;
        procedure DoFieldOnChange       (Sender: TField);                       Override;
        Function  GetExpenseLines       : TExpenseLineBase;                     Override;
        procedure OnDataIdChange (Const ChangeType: TBusObjDataChangeType);     Override;
        function getOrderLines: TOrderLineBase;Override;
        function getApprovaltype: String;override;
    Public
        Function ValidateData           : Boolean;                              Override;
        function  Save                  : Boolean;                              Override;
        function  RepairTotal(const RepairID:Integer):double;
        procedure PopulateMessageSubstituteList(SL: TStringList); override;
        constructor Create(aOwner: TComponent); override;
        Function DoRoundFix :Boolean;
    published
        property Lines                  : TBillLines        Read GetBillLines;
        Property BillTotal              : double            Read fdBilltotal    Write fdBilltotal;
    end;

    TBillEx = class(TBill)
    published
        property Attachments;
    end;

    TCheque = class(TExpenseBase)
    Private
      fbAddtoEFT                      : Boolean;
      //fABAObj                         : TABADetailRecord;
      fdChequetotal                   : Double;
      fsLockMsg                       : String;
      Function GetChequeLines         : TChequeLines;
      Function getABAObj              : TABADetailRecord;
      procedure UpdateAccounts; reintroduce;
      procedure LineBalanceCallbackProc   (Const Sender: TBusObj; var Abort: Boolean); reintroduce;
      procedure UpdateDeposits;
      procedure CreateDepositsLines(const Sender: TBusObj; var Abort: Boolean);
      Procedure ValidateAcountIDCallback(const Sender: TBusObj; var Abort: Boolean);
      procedure CreateDepositsLines4BankAccounts(const Sender: TBusObj; var Abort: Boolean);
      function  ChequeDepositStatus: TTransLockType;
      procedure UpdateLastChequeNo;
      function GetContractorPayment: boolean;
      procedure SetContractorPayment(const Value: boolean);
      function getApprovaltype: String;override;
    function getIsreconciled: Boolean;
    Public
      Property AddtoEFT        : Boolean           Read fbAddtoEFT            Write fbAddtoEFT;
      Property ABAObj          : TABADetailRecord  Read getABAObj;
      Property LockMsg         : String            Read fsLockMsg             Write fsLockMsg;
      Function ValidateData    : Boolean ;                                    Override;
      Function Save            : Boolean;                                     Override;
      Function Valid4EFT       : Boolean;
      function  Lock           : Boolean ;                                    Override;
      procedure Load(const fIsReadonly:boolean =False); override;
      constructor Create(aOwner: TComponent); override;
      class function DepositIdForPayment(const aPaymentId: integer; TransTypeList: string; Conn: TCustomMyConnection = nil): integer;
    Protected
      Function DoAfterInsert   (Sender: TDatasetBusObj): boolean;             Override;
      procedure DoFieldOnChange(Sender: TField);                              Override;
      procedure OnDataIdChange (Const ChangeType: TBusObjDataChangeType);     Override;
      Function  GetExpenseLines: TExpenseLineBase;                            Override;
      function getOrderLines: TOrderLineBase;Override;
    published
      property ContractorPayment: boolean read GetContractorPayment write SetContractorPayment;
      property Lines           : TChequeLines      Read GetChequeLines;
      Property Isreconciled: Boolean read getIsreconciled;
      Property Chequetotal     : double            Read fdChequetotal         Write fdChequetotal;
    end;

  TChequeEx = class(TCheque)
  private
  published
  published
    property Attachments;
  end;

  TCreditEx = class(TCheque)
  private
  published
  published
    property Attachments;
  end;

implementation

uses CommonLib, tcConst, sysutils, AppEnvironment, BusObjConst,
  ForeignExchangeObj, BusObjClient, tcDataUtils, BusObjGLAccount, Windows,
  Dialogs, controls,  BusObjApprovals, DNMLib, CommonDbLib, IntegerListObj, Forms,
  Math, Variants, DbSharedObjectsObj, ApprovalObj, TransLockManagementObj;
//  LogThreadLib, variants;

{TExpenseLineBase}
Function  TExpenseLineBase.getCalcTotalEx       : Double;begin   Result := GeTFloatField('CalcTotalEx');   End;
Function  TExpenseLineBase.getCalcPriceInc      : Double;begin   Result := GeTFloatField('CalcPriceInc');  End;
Function  TExpenseLineBase.getCalcTotalInc      : Double;begin   Result := GeTFloatField('CalcTotalInc');  End;
Function  TExpenseLineBase.getCalcTax           : Double;begin   Result := GeTFloatField('CalcTax');       End;
function  TExpenseLineBase.GetExpenseProductID  : Integer   ; begin Result := GetIntegerField('ExpenseProductID');end;
function  TExpenseLineBase.GetExpenseProductName: string    ; begin Result := GetStringField('ExpenseProductName');end;
function  TExpenseLineBase.GetExpenseProductSelected: string    ; begin Result := GetStringField('ExpenseProductSelected');end;
Procedure TExpenseLineBase.SetCalcTotalEx       (Const Value :Double);begin SetFloatfield('CalcTotalEx', Value);   End;
Procedure TExpenseLineBase.SetCalcPriceInc      (Const Value :Double);begin SetFloatfield('CalcPriceInc', Value);  End;
Procedure TExpenseLineBase.SetCalcTotalInc      (Const Value :Double);begin SetFloatfield('CalcTotalInc', Value);  End;
Procedure TExpenseLineBase.SetCalcTax           (Const Value :Double);begin SetFloatfield('CalcTax',Value);        End;
procedure TExpenseLineBase.SetExpenseProductID  (const Value: Integer   ); begin SetIntegerField('ExpenseProductID'           , Value);end;
procedure TExpenseLineBase.SetExpenseProductName(const Value: string    ); begin SetStringField('ExpenseProductName'         , Value);end;
procedure TExpenseLineBase.SetExpenseProductSelected(const Value: string    ); begin SetStringField('ExpenseProductSelected'         , Value);end;
//Function TExpenseLineBase.GetIsPQAItem:Boolean; begin Result := False; end;

procedure TExpenseLineBase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ExpenseProductID' ,ExpenseProductID);
  AddXMLNode(node,'ExpenseProductName' ,ExpenseProductName);
end;
Function TExpenseLineBase.DoCalcFields(sender :TDatasetBusObj):Boolean;
begin
    Result        := inherited DoCalcFields(Sender);
    if not result then Exit;
    CalcTotalEx   := LineCost;
    CalcPriceInc  := GetAmountInc(LineCost ,LineTaxRate);
    CalcTotalInc  := Round(CalcPriceInc, CurrencyRoundPlaces);
    if LineTaxRate <> 0 then
      CalcTax    := Round(CalcTotalInc - CalcTotalEx, RoundPlacesGeneral)
    else
      CalcTax    := 0;
end;
Function TExpenseLineBase.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    Result          := inherited DoAfterInsert(Sender);
    if not result then Exit;
    PurchaseOrderId := HeaderId;
    LineClassId     := AppEnv.DefaultClass.ClassID;
    //LineTaxCode     := '';
end;
Procedure TExpenseLineBase.UpdateFCAmount;
begin
    if not(Assigned(Self.Owner)) then Exit;
    if not (Self.Owner is TExpensebase) then Exit;
    ForeignTotalLineAmount := ForeignLineCost;
    ForeignExchangeRate := TExpensebase(Self.Owner).ForeignExchangeRate;
    ForeignExchangeCode:= TExpensebase(Self.Owner).ForeignExchangeCode;


end;
procedure TExpenseLineBase.DoFieldOnChange       (Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'AccountName' ) then begin
      if (Sender.AsString <> '') and (TAccount.IDToggle(Sender.AsString,self.Connection.Connection) <> 0) then begin
        PostDb;

        if AccountName <> '' then begin
          AccountNumber   := LineGLAccount.Accountnumber;
          Invoiced        := true;
          if LineGLAccount.Taxcode = '' then begin
              LineTaxCode := '';
          end else begin
              LineTaxCode := LineGLAccount.Taxcode;
          end;
          DoFieldOnChange(Dataset.findField('LineTaxCode'));
        end;
      end
      else begin
        self.AccountName := '';
      end;
    end else if Sysutils.SameText(Sender.Fieldname ,'AccountNumber') then begin
      if AccountName <> '' then begin
        Invoiced        := true;
        if LineGLAccount.Taxcode = '' then begin
            LineTaxCode := '';
        end else begin
            LineTaxCode := LineGLAccount.Taxcode;
        end;
        DoFieldOnChange(Dataset.findField('LineTaxCode'));
      end;
    end else if Sysutils.SameText(Sender.fieldname,'LineTaxCode') then begin
            LineTaxRate := TaxCode.Rate;
            if Self.Owner is TExpenseBase then
                TExpenseBase(Self.Owner).RefreshCalcs;
    end else if Sysutils.SameText(Sender.fieldname , 'ClassID') then begin
        LineClassName   := tcdatautils.GetClassName(LineClassId);
        AddEvent(BusObjEvent_Change,BusObjEventVal_Class, Id );
    end else if Sysutils.SameText(Sender.fieldName , 'LineCost') then begin
        if Self.Owner is TExpenseBase then TExpenseBase(Self.Owner).RefreshCalcs;
        //foreignLinecost:= lineCost*ForeignExchangeRate;
        foreignLinecost:= lineCost*TExpenseBase(self.owner).foreignExchangerate;
        UpdateFCAmount;
        if Assigned(Owner) and (Owner is TExpenseBase) then TExpenseBase(Owner).doCalcOrderTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'ForeignCurrencyLineCost') then begin
        //LineCost:= foreignLinecost /ForeignExchangeRate;
        LineCost:= foreignLinecost /TExpenseBase(self.owner).foreignExchangerate;
        if Self.Owner is TExpenseBase then TExpenseBase(Self.Owner).RefreshCalcs;
        UpdateFCAmount;
        if Assigned(Owner) and (Owner is TExpenseBase) then TExpenseBase(Owner).doCalcOrderTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'LineCostInc') then begin
        LineCost  := GetAmountEx(LineCostInc ,LineTaxRate);
        DoFieldOnChange(Dataset.findField('LineCost'));
    end else if Sysutils.SameText(Sender.FieldName , 'CustomerJobID') then begin
        if CustomerJobobj.DefaultClassName <> '' then begin
            LineClassName := CustomerJobobj.DefaultClassName;
            DoFieldOnChange(Dataset.findField('Class'));
        end;
    end else if Sysutils.SameText(Sender.fieldName , 'Class') then begin
        LineClassId := tcDataUtils.GetDeptID(Lineclassname);
    End;
end;

function TExpenseLineBase.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result := Inherited DoBeforePost(Sender);
end;

procedure TExpenseLineBase.CalcLineTotals;
begin
  inherited;
  TotalLineAmount   := LineCost;
  TotalLineAmountInc  := Round(LineCostInc, (*CurrencyRoundPlaces*)CurrencyRoundPlaces);
  if LineTaxRate <> 0 then
      LineTaxTotal    := Round(TotalLineAmountInc - TotalLineAmount, RoundPlacesGeneral)
  else
      LineTaxTotal    := 0;
end;

constructor TExpenseLineBase.Create(AOwner: TComponent);
begin
    inherited;

end;

function TExpenseLineBase.GetIsPQAItem: boolean;
begin
    REsult := False;
end;

function TExpenseLineBase.GetLineDesc: String;
begin
  REsult := inherited GetLineDesc;
  Result := result + NL+'Account :' + AccountName;
end;

function TExpenseLineBase.GetLinedescription: String;
begin
  REsult := Accountname ;
end;

procedure TExpenseLineBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ExpenseProductID');
  SetPropertyFromNode(node,'ExpenseProductName');
end;

function TExpenseLineBase.ValidateData: Boolean;
begin
  { don't inherit ... it checks product name }
//  result:= inherited ValidateData;
//  if not result then exit;
  result:= true;
  if self.AccountName = '' then begin
    Result:= false;
    ResultStatus.AddItem(false, rssWarning, 0,
      'Account name missing');
    exit;
  end;
end;

{TExpenseBase}
Function TExpenseBase.GetExpenseLines    :TExpenseLineBase;
begin
    Result := nil;
end;
Procedure TExpenseBase.getLinestotal(Const Sender: TBusObj; var Abort: boolean);
begin
    if not (Sender is TExpenseLineBase) then exit;
    dTotTax         := dTotTax + TExpenseLineBase(Sender).LineTaxTotal;
    dSubTotal       := dSubTotal + TExpenseLineBase(Sender).TotalLineAmount;
    dTotalAmount    := dTotalAmount + TExpenseLineBase(Sender).TotalLineAmountInc;
end;
Procedure TExpenseBase.RefreshCalcs;
begin
    {following is for just the current record - and then iterate records will calculate
    from all lines}
    if lines.FieldExists('CalcPriceInc')  then Lines.LineCostInc                   := Lines.CalcPriceInc;
    if lines.FieldExists('CalcTotalEx')   then Lines.TotalLineAmount               := Lines.CalcTotalEx;
    if lines.FieldExists('CalcTotalInc')  then Lines.TotalLineAmountInc            := Lines.CalcTotalInc;
    if lines.FieldExists('CalcTax')       then Lines.LineTaxTotal                  := Lines.CalcTax;
    Lines.Invoiced                      := True;
    Lines.PostDB;
    Lines.CalcTaxcodeTotals;
    (*{binny : The facility to disable the calculation is being removed,
    so the calculation should be done in any case}
    dTotTax                             := 0;
    dSubTotal                           := 0;
    dTotalAmount                        := 0;
    Lines.IterateRecords(getLinestotal);
    TotalTax                            := Round(dTotTax     , RoundPlacesgeneral);
    TotalAmount                         := Round(dSubTotal   , CurrencyRoundPlaces);
    TotalAmountInc                      := Round(dTotalAmount, CurrencyRoundPlaces);
    if TotalPaid<>0 then TotalBalance   := Round(dTotalAmount, CurrencyRoundPlaces) - TotalPaid
    else TotalBalance                   := Round(dTotalAmount, CurrencyRoundPlaces);*)
    DoCalcOrderTotals;
    IsPaid                              := TotalBalance = 0;
    PostDB;

end;
function TExpenseBase.getActualTotalPayment: double;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    qry.sQl.text := 'SELECT WL.POID, WL.TrnType, SUM(WL.Payment) actualpayemnt '+
                    ' FROM tblwithdrawallines WL  '+
                    ' INNER JOIN tblwithdrawal W ON W.PaymentID = WL.PaymentID  '+
                    ' AND W.Deleted="F" AND IFNULL(WL.POID, 0)=  '+inttostr(ID) +' and WL.TrnType =' + Quotedstr(Approvaltype)+
                    ' GROUP by WL.POID, WL.TrnType';
    qry.Open;
    result := qry.fieldbyname('actualpayemnt').asfloat;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

function TExpenseBase.getBankDeposit : TBankDeposit;
begin
  PostDB;
  Result := TBankDeposit(getContainerComponent(TBankDeposit, 'Details.Trnstype in("Cheque", "Cheque Deposit") AND Details.PaymentId = ' + IntToStr(ID)));
end;

Procedure TExpenseBase.searchforAcctswithoutExpclaim(Const Sender:TBusObj;var Abort:Boolean);
begin
    if not(Sender is   TExpenseLineBase) then Exit;
    if not TExpenseLineBase(Sender).LineGLAccount.AllowExpenseClaim then  begin
        fbAcctswithoutExpclaim := True;
        if fsAcctsWithoutExpclaim <> '' then fsAcctsWithoutExpclaim  := fsAcctsWithoutExpclaim + chr(13);
        fsAcctsWithoutExpclaim := fsAcctsWithoutExpclaim +#9+TExpenseLineBase(Sender).AccountName;
    end;
end;
procedure TExpenseBase.SetTransStatus(const Value: String);
begin
  inherited;
  OrderStatus := Value;
end;

Function TExpenseBase.Save: Boolean;
begin
  Result := false;
  if not validateData then Exit;
  CalcOrderTotals;
  Result := inherited Save;
end;

Function TExpenseBase.ValidateData :Boolean ;
begin
    REsult := inherited ValidateData;
    if not result then Exit;
    if (suppliername = '') or (SupplierId = 0) then begin
      ResultStatus.AddItem(false, rssWarning, 0, 'Supplier Should not be Blank.' , true);
      REsult := false;
      Exit;
    end;
    if (Self is TCredit) or (self is TBill) then begin  // not applicable for the cheque
        if ExpenseClaimEmployee <> 0 then begin
            fbAcctswithoutExpclaim := False;
            fsAcctsWithoutExpclaim := '';
            Lines.Iteraterecords(searchforAcctswithoutExpclaim);
            if fbAcctswithoutExpclaim then begin
                ResultStatus.AddItem(false, rssWarning, 0,
                    'This is an expense claim ' + Self.XMLNodeName +' record.' + chr(13) +
                    'The following accounts selected are not available for employee expense claims.' + chr(13) + chr(13) + fsAcctsWithoutExpclaim+'.');
                REsult := false;
                Exit;
            end;
        end;
    end;
    result:= Validatelines;
end;

procedure TExpenseBase.CalcOrderTotals;
begin
    Show_Status('Calculating Order totals.');
    try
      if DisableCalcOrderTotals then Exit;
      tmpTotalForeignAmount:= 0;

      (*dTotTax                             := 0;
      dSubTotal                           := 0;
      dTotalAmount                        := 0;
      Lines.IterateRecords(getLinestotal);
      TotalTax                            := Round(dTotTax     , {RoundPlacesgeneral}CurrencyRoundPlaces);
      TotalAmount                         := Round(dSubTotal   , CurrencyRoundPlaces);
      TotalAmountInc                      := Round(dTotalAmount, CurrencyRoundPlaces);
      if TotalPaid<>0 then TotalBalance   := Round(dTotalAmount, CurrencyRoundPlaces) - TotalPaid
      else TotalBalance                   := Round(dTotalAmount, CurrencyRoundPlaces);*)

      inherited; // calls CalcTotalsCallback
      if ForeignTotalAmount   <> CommonLib.Round(tmpTotalForeignAmount, CurrencyRoundPlaces) then
          ForeignTotalAmount  := CommonLib.Round(tmpTotalForeignAmount, CurrencyRoundPlaces);
      if ForeignBalanceAmount <> ForeignTotalAmount - self.ForeignPaidAmount then
          ForeignBalanceAmount:= ForeignTotalAmount - self.ForeignPaidAmount;
      postDB;
    finally
      Show_Status('');
    end;
end;
procedure TExpenseBase.CalcTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if TExpenseLineBase(Sender).Deleted then Exit;  { deleted records amount should not be added into total }
  inherited;
  tmpTotalForeignAmount := tmpTotalForeignAmount + TExpenseLineBase(Sender).ForeignTotalLineAmount;
end;


procedure TExpenseBase.DoFieldOnChange(Sender: TField);
var
    fdBuyRate, fdSellRate:Double;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldName , 'suppliername') then begin
      clientId := 0;
      if self.SupplierName <> '' then
        clientId := Supplier.ID;
      DoFieldOnChange(Dataset.findField('clientID'));
    end else if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
      if ClientId > 0 then begin
        if Supplier.TermsId <> 0 then begin
            if Supplier.Terms.Active then TermsName := Supplier.TermsName
            else TermsName := TERMS_ON_RCPT;
        end else TermsName := TERMS_ON_RCPT;
        Orderto := Supplier.ShipToAddress;
        if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then
            if Supplier.ForeignExchangeCode <> '' then
                ForeignExchangeCode := Supplier.ForeignExchangeCode;
        DoFieldOnChange(Dataset.findField('ForeignExchangeCode'));
        Area := Supplier.Area;
      end
      else begin
        //Orderto := '';
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'OrderDate') then begin
      if VarIsNull(Sender.OldValue) or (Sender.OldValue <> Sender.AsDateTime) then begin
        AddEvent(BusObjEvent_Change,BusObjEventVal_FC,Self.Id);
        if (ForeignExchangeCode <> '') and (ForeignExchangeCode <> Appenv.RegionalOptions.ForeignExDefault) then
            DoFieldOnChange(Dataset.findfield('ForeignExchangeCode')); // to recalculate the foreign rate on the date
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'ForeignExchangeCode') then begin
        With TForeignExchangeObj.Create do try
            GetForeignExchangeRatesForDate(ForeignExchangeCode, OrderDate, fdBuyRate, fdSellRate);
            ForeignExchangeRate := fdBuyRate;
        Finally
            Free;
        end;
        AddEvent(BusObjEvent_Change,BusObjEventVal_FC,Self.Id);
        DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
    end else if Sysutils.SameText(Sender.fieldName , 'ForeignExchangeRate') then begin
        DoCalcOrderTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'Account') then begin
        GLAccountID:= TAccount.IDToggle(Sender.AsString, Connection.Connection);
        DoFieldOnChange(Dataset.findField('AccountID'));
    end else if Sysutils.SameText(Sender.FieldName , 'AccountID') then begin
        GLAccountName:= TAccount.IDToggle(Sender.AsInteger, Connection.Connection);
    End;
end;
Function TExpenseBase.DoAfterPost(Sender: TDatasetBusObj): boolean;
begin
    REsult      := inherited DoAfterPost(Sender);
    if not result  then Exit;
    if DocNumber = '' then begin
        DocNumber := IntToStr(ID);
        PostDB;
    End;
end;
Function TExpenseBase.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult              := inherited DoAfterInsert(Sender);
    if not result  then Exit;
    OrderDate           := Date;
    DueDate             := Date;
    ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
    EnteredBy           := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
    EnteredAt           := TimeToStr(Now);
End;

Function TExpenseBase.GetLines: TTransLineBase;
begin
    Result := TTransLineBase(Lines);
end;
procedure TExpenseBase.LineValidateCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  inherited;
  if not TExpenseLineBase(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;

end;

procedure TExpenseBase.ProcessDeletedLine;
var
  scr: TERPScript;
begin
  inherited;
  if Lines.Deleted then begin
    if self.IsBill or self.IsCheque or self.IsCredit then begin
      scr := DbSharedObj.GetScript(self.Connection.Connection);
      try
        scr.SQL.Add('update tblexpenseclaim e, tblexpenseclaimline el');
        scr.SQL.Add('set e.Processed = "F",');
        scr.SQL.Add('el.Processed = "F",');
        scr.SQL.Add('el.ChequeId = NULL,');
        scr.SQL.Add('el.BillId = NULL');
        scr.SQL.Add('where e.expenseclaimid = el.expenseclaimid');
        scr.SQL.Add('and (IfNull(el.ChequeId,0) = ' + IntToStr(self.ID));
        scr.SQL.Add('or IfNull(el.BillId,0) = ' + IntToStr(self.ID) + ');');
        scr.Execute;

      finally
        DbSharedObj.ReleaseObj(scr);
      end;
    end;

  end;
end;

procedure TExpenseBase.UpdateAccountTaxcode(const Sender: TBusObj);
var
  strSQL:STring;
begin
  if not (sender is TExpenseLineBase) then exit;
  strSQL:= 'update  tblchartofaccounts Set Taxcode = ' + QuotedStr(TExpenseLineBase(Sender).LineTaxCode)+
                                          ' where  AccountID = ' + IntToStr(TExpenseLineBase(Sender).LineGLAccount.ID)+
                                          '  and  ifnull(Taxcode,"") = "" ';
  PostList.AddQuery(strSQL ,TExpenseLineBase(Sender).LineGLAccount.ID ,TExpenseLineBase(Sender).LineGLAccount.ClassName , True);
end;

function TExpenseBase.getOrderLines: TOrderLineBase;
begin
  REsult := nil;
end;
function TExpenseBase.getTransLinetotals: TTransLinetotals;
begin
  Result := TTransLinetotals(getContainerComponent(TTransLinetotals , 'PurchaseOrderID = ' + IntToStr(ID)));
end;

function TExpenseBase.GetTransStatus: String;
begin
  REsult:= OrderStatus;
end;

{TCredit}
Function TCredit.GetCreditLines: TCreditLines;
begin
    PostDb;
    Result := TCreditLines(getContainerComponent(TCreditLines , 'PurchaseOrderID = ' + IntToStr(ID)));
end;


Function TCredit.ValidateData :Boolean ;
begin
    result := inherited  ValidateData;
    if not result then exit;
    //ValidateApproval;
    if self.Approved then
      TApprovalCheck.Approved(self);
end;

Function  TCredit.GetExpenseLines: TExpenseLineBase;
begin
  Result := TExpenseLineBase(Lines);
end;

procedure TCredit.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        InitAPAccount;
        AddEvent(BusObjEvent_Change,BusObjEventVal_AccountID,Self.Id);
    end else if Sysutils.SameText(Sender.FieldName, 'Approved') then begin
        //ValidateApproval;
        if Approved then
          TApprovalCheck.Approved(self, Sender);
        //AddEvent(BusObjEvent_Change, BusObjEventVal_Approved, Self.ID);
    end;
    inherited;
end;

function TCredit.getApprovaltype: String;
begin
  Result := 'Credit';
end;

constructor TCredit.Create(aOwner: TComponent);
begin
  inherited;
  fSQL := 'Select * from tblPurchaseOrders where IsCredit = "T"';
  fBusObjectTypeDescription := 'Credit';
end;

Function TCredit.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult      := inherited DoAfterInsert(Sender);
    if not result  then Exit;
    IsCredit    := True;
    IsBill      := False;
    IsCheque    := False;
    InitAPAccount;
end;
function  TCredit.Save : Boolean;
begin
  if not dirty then begin
      result := true;
      Exit;
  end;
  Result := false;
  try
    if OrderDate = 0 then OrderDate := Date;
    PostDB;
    PostList.Clear;
    result := inherited Save; {does the validation}
    if not result then Exit;
    if CleanApproved <> Approved then AddToPayAuthorisations;
    UpdateAccounts;
    if not PostList.Execute then begin
        Result  := False;

        Exit;
    end;
  finally
    if result then  result :=  Validtocommit;
  end;
  if result then begin
    if DeleteFlaggedLines then    Dirty := False else result := False;
  end;
end;

Function TCredit.UpdateAccounts:Boolean;
var
  CleanSupplierID: Integer;
  CleanTotalAmountInc: Double;
  CleanNode: IXMLNode;
  CleanGlaccountid: Integer;
  TaxPaidID: Integer;
begin
    Show_Status('Update Accounts.');
    TaxPaidID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_PAID);
    CleanNode:= self.CleanXMLNode;
    if assigned(CleanNode)  then  begin
        CleanTotalAmountInc := GetXMLNodeFloatValue(CleanNode,'Totalamountinc');
        if CleanTotalAmountInc =0 then else begin
          CleanSupplierID     := GetXMLNodeIntegerValue(CleanNode,'Clientid');
          POstList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
            CleanSupplierID, -CleanTotalAmountInc );

          CleanGlaccountid:= GetXMLNodeIntegerValue(CleanNode,'Glaccountid');
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            CleanGlaccountid, -(CleanTotalAmountInc));

          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            TaxPaidID, -(GetXMLNodeFloatValue(CleanNode,'Totaltax')));
        end;
    end;


    PostList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
         SupplierID,  TotalAmountInc );

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      Glaccountid,  TotalAmountInc);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxPaidID, TotalTax);

    Lines.IterateRecords(LineBalanceCallbackProc, true);

    REsult := True;
end;
procedure TCredit.LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean);
var
  CleanNode: IXMLNode;
  cleanAccountID :Integer;
  CleanTotLineAmt :Double;
begin
  CleanNode:= TCreditLines(Sender).CleanXMLNode;
  if Assigned(CleanNode) then  begin
        cleanAccountID    := tcDatautils.GetAccountID(GetXMLNodeStringValue(CleanNode,'Accountname'));
        CleanTotLineAmt     := GetXMLNodeFloatValue(CleanNode,'Totallineamount');

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            cleanAccountID, - CleanTotLineAmt);
  end;
  if TCreditLines(Sender).Deleted = False then begin
    PostList.AddAmount(TCreditLines(Sender).LineGLAccount.ClassName,
                    TCreditLines(Sender).LineGLAccount.BusObjectTableName,
                    TCreditLines(Sender).LineGLAccount.ID,
                    TCreditLines(Sender).Totallineamount);
    UpdateAccountTaxcode(Sender);
  end;
end;
procedure TCredit.PopulateMessageSubstituteList(SL: TStringList);
var
  s: string;
begin
  s:=
    'Select p.PurchaseOrderId ,  ' +
    ' C.FirstName, ' +
    ' P.ShipTo ' +
//    ', concat(PL.Productname ,"     : " ,  PL.UnitofMeasureShipped , "  of  " ,   concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details ' +
    ' from tblpurchaseorders p ' +
    ' inner join tblpurchaselines PL on P.PurchaseOrderId = PL.PurchaseOrderId   ' +
    ' inner join tblclients c on c.clientId = p.clientID' +
    ' where ifnull(PL.UnitofMeasureShipped,0) <> 0 and P.PurchaseOrderId = ' + IntToStr(ID);
  with TERPQuery(GetNewDataset(s)) do try
    SL.Values['#CreditID#'] := IntToStr(ID);
    SL.Values['#Address#'] := Fieldbyname('ShipTo').asString;
//    SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#FirstName#'] := Fieldbyname('FirstName').asString;
  finally
    Free;
  end;
end;

function TCredit.getOrderLines: TOrderLineBase;
begin
 Result := TOrderLineBase(Lines);
end;

{TCheque}
Function TCheque.ValidateData :Boolean ;
begin
    result := inherited  ValidateData;
    if not result then Exit;
    if not Math.SameValue(Chequetotal,TotalAmountInc,0.000001) then
        if (not (assigned(ConfirmFromGUI))) then
            if Chequetotal = 0 then
               Chequetotal := TotalAmountInc;

    if not Math.SameValue(Chequetotal,TotalAmountInc,0.000001) then
         if (not (assigned(ConfirmFromGUI))) or  (fConfirmFromGUI('Cheque Total does not equal Total Amount' + chr(13) + chr(13) +
                    'Do you wish to update the Total?' , [mbYes,MbNO]) = mrno) then begin
                AddResult(false,rssWarning,0,'Cheque Total does not equal Total Amount');
                Result := False;
                Exit;
         end else begin
            if Chequetotal = 0 then
               Chequetotal := TotalAmountInc;
         end;

    if self.OrderDate  <= AppEnv.CompanyPrefs.ClosingDate then begin
      AddResult(false,rssWarning,0,'Date is before the Closing Date');
      result := false;
      exit;
    end;
    if not valid4EFT then begin
        Result := false;
        Exit;
    end;

end;
Function TCheque.Valid4EFT:Boolean;
begin
    Result := true;
    if self.ClientID < 1 then
      exit;
    if not AddtoEFT then exit;
    if not Supplier.ValidEFTSupplier then begin
        ResultStatus.AddItem(false, rssWarning, 0, 'This Supplier does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        Exit;
    end;
    if  not GLAccount.ValidEFTAccount then begin
        ResultStatus.AddItem(false, rssWarning, 0, 'The GL Bank Account ('+ GLAccount.AccountName +')  Does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        Exit;
    end;
end;
Procedure TCheque.UpdateLastChequeNo;
begin
{this is outside transaction and is ignored if cannot be locked}
        if (GLAccount.UseLastChequeNo) and (AppEnv.CompanyPrefs.UseAutoChequeNo) then
            if (SupplierInvoiceNumber <> '') and (isnumeric(SupplierInvoiceNumber)) then begin
                if userLock.Lock(GLAccount.BusObjectTableName , GLAccount.ID , Lockgroupname) then begin
                    GLAccount.NewChequeNo := StrToInt(SupplierInvoiceNumber);
                    GLAccount.PostDb;
                End else begin
                    AddResult(True,rssInfo,0,
                        StringReplace(ABAObj.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update the Last cheque no of ' +GLAccount.Accountname +'.'  , [rfReplaceAll, rfIgnoreCase]));
                end;
            end;
end;

Function TCheque.Save :Boolean ;
begin
  ResultStatus.Clear;
  if not dirty then begin
      result := true;
      Exit;
  end;
  Result := ValidateData;
  if not result then Exit;

  try

    PostList.Clear;
    result := inherited Save; {does the validation}
    if not result then Exit;
    if  AppEnv.CompanyPrefs.UseAutoChequeNo then begin
        {this updation is outside transcation }
        //if not GLAccount.Lock then begin
        if not GLAccount.userlock.Lock(GLAccount.BusobjectTableName , GLAccount.ID, LockGroupName) then begin
            ResultStatus.AddItem(false, rssWarning, 0,
                    StringReplace(GLAccount.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update LastCheque number of ' + GLAccount.Accountname+'.' , [rfReplaceAll, rfIgnoreCase]));
            result := False;
            Exit;
        end;
        try
            GLAccount.NewChequeNo :=TRunc(strValue(SupplierInvoiceNumber));
            GLAccount.PostDB;
        finally
            GLAccount.userlock.UnLock(GLAccount.busObjectTablename , GLaccount.Id, Lockgroupname);
        end;
    end;
    if AddtoEFT then begin
        if ABAObj.count = 1 then if not ABAObj.UserLock.Lock(ABAObj.BusObjectTableName, ABAObj.Id, Lockgroupname) then begin
            ResultStatus.AddItem(false, rssWarning, 0,
                    StringReplace(ABAObj.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update the E.F.T details.' , [rfReplaceAll, rfIgnoreCase]));
            result := False;
            Exit;
        end;
        if ABAObj.count = 0 then ABAObj.New;
        ABAObj.RecordType               := '1';
        ABAObj.BSB                      := Supplier.BankAccountBSB;
        ABAObj.CreditDebitAccountNumber := Supplier.BankAccountNo;
        ABAObj.Indicator                := ' ';
        ABAObj.TransactionCode          := '50';
        ABAObj.TransCodeDesc            := 'Credit Items';
        ABAObj.Amount                   := TotalAmountInc;
        ABAObj.AccountName              := Supplier.BankAccountName;
        ABAObj.LodgementReferences      := XMLNodeName + '  ' + IntToStr(ID)+ ' ' + appenv.CompanyInfo.Companyname;
        ABAObj.Apply                    := False;
        ABAObj.AccountID                := GLAccountId;
        ABAObj.TransType                := self.XMLNodeName;
        ABAObj.TransID                  := ID;
        ABAObj.NameofRemitter           := Self.ClientName;
        ABAObj.PostDB;
    end;
    UpdateAccounts;
    UpdateDeposits;
    UpdateLastChequeNo;
    //Result      := inherited Save;
    UserLock.IgnoreClassnameinLock := true;
    if not PostList.Execute then begin
        Result  := False;

        Exit;
    end;
  finally
    if result then  result :=  Validtocommit;
  end;
  if result then begin
    if DeleteFlaggedLines then    Dirty := False else result := False;
  end;

end;
procedure TCheque.SetContractorPayment(const Value: boolean);
begin
  SetBooleanField('ContractorPayment',Value);
end;

procedure TCheque.LineBalanceCallbackProc   (Const Sender: TBusObj; var Abort: Boolean);
var
  CleanNode: IXMLNode;
  cleanAccountId :Integer;
  CleanTotLineAmt :Double;
begin
  CleanNode:= TChequeLines(Sender).CleanXMLNode;
  if Assigned(CleanNode) then  begin
        cleanAccountId := tcDatautils.getAccountID(GetXMLNodeStringValue(CleanNode,'AccountName'));
        cleanTotLineAmt := GetXMLNodefloatValue(cleanNode , 'Totallineamount');
        if (cleanAccountId <> 0) and (cleanTotLineAmt <> 0) then begin
            PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
                cleanAccountId, 0-cleanTotLineAmt);
        end;
  end;
  if TChequeLines(Sender).Deleted = False then begin
    PostList.AddAmount(TChequeLines(Sender).LineGLAccount.ClassName, TChequeLines(Sender).LineGLAccount.BusObjectTableName,
                TChequeLines(Sender).LineGLAccount.ID, TChequeLines(Sender).Totallineamount);
    UpdateAccountTaxcode(Sender);
  end;
end;
procedure TCheque.UpdateAccounts;
var
    CleanTotalAmountInc   : Double;
    CleanNode             : IXMLNode;
    CleanGlaccountid      : Integer;
    TaxPaidID             : Integer;
    cleanTaxAmount        : double;
begin
    CleanNode:= self.CleanXMLNode;
    TaxPaidID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_PAID);
    if assigned(CleanNode)  then  begin
        CleanTotalAmountInc:= GetXMLNodeFloatValue(CleanNode,'Totalamountinc');
        if CleanTotalAmountInc =0 then else begin
          CleanGlaccountid   := GetXMLNodeIntegerValue(CleanNode,'Glaccountid');
          cleanTaxamount     := GetXMLNodeFloatValue(CleanNode,'Totaltax');
          if (CleanGlaccountid <> 0) and (CleanTotalAmountInc <> 0 ) then
              PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
                                  CleanGlaccountid, CleanTotalAmountInc);
          if cleanTaxAmount <> 0 then
              PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
                                  TaxPaidID, (GetXMLNodeFloatValue(CleanNode,'Totaltax')));
        end;
    end;

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      Glaccountid, 0-TotalAmountInc);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxPaidID, 0-TotalTax);

    Lines.IterateRecords(LineBalanceCallbackProc, true);

end;

procedure TCheque.UpdateDeposits;
var
  idList: TIntegerList;
  ds: TCustomMyDataset;
  script: TERPScript;
  x: integer;
begin
//    GetNewDataset('Delete  tblbankdeposit.*  FROM tblbankdeposit ' +
//         ' INNER JOIN tblbankdepositlines ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
//         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
//         ' AND tblbankdepositlines.TrnsType  in ("Cheque Deposit" , "Cheque")  ' , True);
//    GetNewDataset('Delete  tblbankdepositlines.*  FROM tblbankdepositlines ' +
//         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
//         ' AND tblbankdepositlines.TrnsType  in ("Cheque Deposit" , "Cheque")  ' , true);

    { changed here to prevent lockwait timeouts }
    if ID > 0 then begin
      idList:= TIntegerList.Create;
      ds:= GetNewDataset('select distinct tblbankdeposit.DepositID FROM tblbankdeposit ' +
        ' INNER JOIN tblbankdepositlines ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
        ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
        ' AND tblbankdepositlines.TrnsType  in ("Cheque Deposit" , "Cheque")  ' , True);
      try
        while not ds.Eof do begin
          idList.Add(ds.FieldByName('DepositID').AsInteger);
          ds.Next;
        end;
        if idList.Count > 0 then begin
          script:= TERPScript.Create(nil);
          try
            script.Connection:= self.Connection.Connection;
            for x:= 0 to idList.Count -1 do begin
              script.SQL.Add('Delete FROM tblbankdeposit where DepositID = ' + IntToStr(idList[x]) +';');
              script.SQL.Add('Delete FROM tblbankdepositlines where DepositID = ' + IntToStr(idList[x]) +';');
            end;
            script.Execute;
          finally
            script.Free;
          end;
        end;
      finally
        ds.Free;
        idList.Free;
      end;
    end;

    BankDeposit.New;
    BankDeposit.Depositdate          := OrderDate;
    BankDeposit.PostDB;
    BankDeposit.EmployeeId           := EmployeeId;
    BankDeposit.classId              := 0;
    BankDeposit.AccountId            := GLAccountId;
    BankDeposit.Notes                := Comments;
    BankDeposit.Deposit              := -(TotalAmountInc);
    BankDeposit.Deleted              := False;
    BankDeposit.PostDB;
    Lines.IterateREcords(CreateDepositsLines);
(*    ExecuteSQL('update tblbankdeposit BD ' +
                ' inner join tblbankdepositLines BDL  on BD.DepositID = BDL.depositID ' +
                ' inner join tblreconciliationwithdrawallines RWL on ' +
                ' BDL.DepositID = RWL.PaymentID ' +
                ' and BDL.CompanyName = RWL.Payee ' +
                ' and BDL.PaymentDate = RWL.DepositDate ' +
                ' and ABS(BD.Deposit)  = ABS(RWL.Amount) ' +
                ' and BDL.TrnsType = RWL.Notes ' +
                ' Set BD.Reconciled ="T" ' +
                ' where BD.DepositID = ' + inttostr(BankDeposit.ID) , true);*)
    Lines.IterateREcords(CreateDepositsLines4BankAccounts);
end;
constructor TCheque.Create(aOwner: TComponent);
begin
  inherited;
  fSQL := 'Select * from tblPurchaseOrders where IsCheque = "T"';
end;

procedure TCheque.CreateDepositsLines(const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TChequelines) then Exit;
    BankDeposit.Lines.New;
    BankDeposit.Lines.PaymentID     := ID;
    BankDeposit.Lines.TrnsType      := 'Cheque';
    BankDeposit.Lines.CusID         := clientID;
    BankDeposit.Lines.PayMethodID   := 0;
    BankDeposit.Lines.PaymentMethod := 'Cheque';
    BankDeposit.Lines.PaymentDate   := OrderDate;
    BankDeposit.Lines.CompanyName   := supplierName;
    BankDeposit.Lines.ReferenceNo   := SupplierInvoiceNumber;
    BankDeposit.Lines.ClassID       := 0;
    BankDeposit.Lines.AccountID     := TChequeLines(Sender).LineGLAccount.ID;
    BankDeposit.Lines.LineName      := '';
    BankDeposit.Lines.Amount        := -(TChequeLines(Sender).totalLineamountInc);
    BankDeposit.Lines.Notes         := TChequeLines(Sender).ProductDescription;
    BankDeposit.Lines.Customer      := False;
    BankDeposit.Lines.Supplier      := True;
    BankDeposit.Lines.Employee      := False;
    BankDeposit.Lines.Contact       := False;
    BankDeposit.Lines.Deposited     := True;
    BankDeposit.Lines.StatementNo   := 0;
    BankDeposit.Lines.PostDB;
end;
procedure TCheque.CreateDepositsLines4BankAccounts(const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TChequeLines) then Exit;
    if not (TChequeLines(Sender).LineGLAccount.IsAccountTypeBank) then Exit;
    BankDeposit.New;
    BankDeposit.Depositdate          := OrderDate;
    BankDeposit.PostDB;
    BankDeposit.EmployeeId          := EmployeeId;
    BankDeposit.classId             := 0;
    BankDeposit.AccountId           := TChequeLines(Sender).LineGLAccount.ID;
    BankDeposit.Notes               := Comments;
    BankDeposit.Deposit             := TotalAmountInc;
    BankDeposit.Deleted             := False;
    BankDeposit.PostDB;
    BankDeposit.Lines.New;
    BankDeposit.Lines.PaymentID     := ID;
    BankDeposit.Lines.TrnsType      := 'Cheque Deposit';
    BankDeposit.Lines.CusID         := clientID;
    BankDeposit.Lines.PayMethodID   := 0;
    BankDeposit.Lines.PaymentMethod := 'Cheque';
    BankDeposit.Lines.PaymentDate   := OrderDate;
    BankDeposit.Lines.CompanyName   := supplierName;
    BankDeposit.Lines.ReferenceNo   := '';
    BankDeposit.Lines.ClassID       := TChequeLines(Sender).ClassId;;
    BankDeposit.Lines.AccountID     := GLaccountID;
    BankDeposit.Lines.LineName      := '';
    BankDeposit.Lines.Amount        := TChequeLines(Sender).TotalLineamountInc;
    BankDeposit.Lines.Notes         := TChequeLines(Sender).ProductDescription;
    BankDeposit.Lines.Customer      := False;
    BankDeposit.Lines.Supplier      := True;
    BankDeposit.Lines.Employee      := False;
    BankDeposit.Lines.Contact       := False;
    BankDeposit.Lines.Deposited     := True;
    BankDeposit.Lines.StatementNo   := 0;
    BankDeposit.Lines.PostDB;
    (*ExecuteSQL('update  tblbankdeposit BD ' +
                ' inner join tblbankdepositLines BDL  on BD.DepositID = BDL.depositID ' +
                ' left join tblreconciliationdepositlines RDL on ' +
                ' BDL.DepositID = RDL.PaymentID ' +
                ' and BDL.CompanyName = RDL.Payee ' +
                ' and BDL.PaymentDate = RDL.DepositDate ' +
                ' and ABS(BDL.amount)  = ABS(RDL.Amount) ' +
                ' and BDL.TrnsType = RDL.Notes ' +
                ' Set BD.Reconciled ="T" ' +
                ' where BD.DepositID = ' + inttostr(BankDeposit.ID) , true);*)
end;

Function TCheque.GetChequeLines: TChequeLines;
begin
  PostDB;
  Result := TChequeLines(getContainerComponent(TChequeLines , 'PurchaseOrderID = ' + IntToStr(ID)));
end;

function TCheque.GetContractorPayment: boolean;
begin
  result := GetBooleanField('ContractorPayment');
end;

Function TCheque.getABAObj: TABADetailRecord;
begin
   Result := TABADetailRecord(getContainerComponent(TABADetailRecord , 'TransID = ' + IntToStr(ID) + ' and TransType = ' + QuotedStr(XMLNodename)));
end;

function TCheque.getApprovaltype: String;
begin
  Result :='Cheque';
end;

procedure TCheque.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

    inherited;
    if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        PostDB;
        InitPaymentAccount;//InitAPAccount;
        Valid4EFT;
        ContractorPayment := self.Supplier.Contractor;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountID') then begin
        if (AppEnv.CompanyPrefs.UseAutoChequeNo) then
            if SupplierInvoiceNumber = '' then SupplierInvoiceNumber := IntToStr(GLAccount.Previouschequeno+1);
        AddEvent(BusObjEvent_Change,BusObjEventVal_AccountID,Self.Id);
        Valid4EFT;
        lines.IterateRecords(ValidateAcountIDCallback)
    end;

end;

Function TCheque.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    Result      := inherited DoAfterInsert(Sender);
    if not result  then Exit;
    IsCredit    := False;
    IsBill      := False;
    IsCheque    := True;
    InitPaymentAccount;//InitAPAccount;
end;

procedure TCheque.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    inherited;
    AddtoEFT    := False;
    Chequetotal := 0;
end;

Function  TCheque.GetExpenseLines: TExpenseLineBase;
begin
    Result := TExpenseLineBase(Lines);
end;

function TCheque.Lock:Boolean;
var
    Chequestatus :TTransLockType;
    ds: TCustomMyDataset;
begin
    Chequestatus := ChequeDepositStatus;
    result := False;
    LockMsg := '';
    if Chequestatus = ltReconciled then  begin {RECONCILED}
        LockMsg := LockMsgReconciled;
        Exit;
    end else if Chequestatus = ltOnHoldRec then  begin {ON HOLD}
        LockMsg := LockMsgReconcileHold;
        Exit;
    end;
    Result := True;

    if ID > 0 then begin
      ds:= GetNewDataset('select tblbankdeposit.DepositID FROM tblbankdeposit ' +
         ' INNER JOIN tblbankdepositlines ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
         ' AND tblbankdepositlines.TrnsType  in ("Cheque Deposit" , "Cheque")  ' , True);
      try
        while not ds.Eof do begin
          result:= Userlock.Lock('tblbankdeposit', ds.FieldByName('DepositID').AsInteger, LockGroupName);
          if not result then
            break;
          ds.Next;
        end;
      finally
        ds.Free;
      end;
    end;
end;

function TCheque.ChequeDepositStatus: TTransLockType;
var
  SQLList :TStringList;
begin
    result :=ltNone;
    SQLList :=TStringList.create;
    try
        SQLList.Add('Select R.ReconciliationID,');
        SQLList.Add(' if(R.Finished<>"T" , "DepositOnHOLD", "DepositReconcile") as Status ');
        SQLList.Add('From tblpurchaseorders PO ');
        SQLList.Add('INNER JOIN tblbankdepositlines BDL ON ');
        SQLList.Add('PO.PurchaseOrderID = BDL.PaymentID AND ');
        SQLList.Add('BDL.TrnsType="Cheque Deposit" ');
        SQLList.Add('INNER JOIN tblreconciliationwithdrawallines RWL ON ');
        SQLList.Add('BDL.DepositID = RWL.PaymentID AND ');
        SQLList.Add('BDL.CompanyName = RWL.Payee AND ');
        SQLList.Add('BDL.PaymentDate = RWL.DepositDate AND ');
        SQLList.Add('ABS(BDL.Amount) = ABS(RWL.Amount) AND ');
        SQLList.Add('BDL.TrnsType = RWL.Notes ');
        SQLList.Add('INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ');
        SQLList.Add('Where PO.PurchaseOrderID=' + IntToStr(ID)) ;
        SQLList.Add('AND R.Deleted<>"T"  ');
        SQLList.Add('Group By R.ReconciliationID ');
        SQLList.Add(' union ');
        SQLList.Add('Select R.ReconciliationID,if(R.Finished <> "T","OnHOLD", "Reconciled") ');
        SQLList.Add('From tblpurchaseorders PO ');
        SQLList.Add('INNER JOIN tblbankdepositlines BDL  ');
        SQLList.Add('ON PO.PurchaseOrderID = BDL.PaymentID  ');
        SQLList.Add('AND BDL.TrnsType="Cheque" ');
        SQLList.Add('INNER JOIN tblreconciliationwithdrawallines RWL	 ');
        SQLList.Add('ON BDL.DepositID = RWL.PaymentID  ');
        SQLList.Add('AND BDL.CompanyName = RWL.Payee  ');
        SQLList.Add('AND BDL.PaymentDate = RWL.DepositDate  ');
        SQLList.Add('AND ABS(PO.TotalAmountInc) = ABS(RWL.Amount)  ');
        SQLList.Add('AND BDL.TrnsType = RWL.Notes ');
        SQLList.Add('INNER JOIN tblreconciliation R  ');
        SQLList.Add('ON RWL.ReconciliationID = R.ReconciliationID ');
        SQLList.Add('Where PO.PurchaseOrderID=' + IntToStr(ID)) ;
        SQLList.Add('AND R.Deleted<>"T" ');
        SQLList.Add('Group By R.ReconciliationID ');
        With getnewDataset(SQLList.TExt , true) do try
             if recordcount = 0 then
                result :=ltNone
             else if (Sysutils.SameText(FieldByname('Status').asString , 'DepositOnHOLD')) or
                     (Sysutils.SameText(FieldByname('Status').asString , 'OnHOLD') ) then
                result := ltOnHoldRec
             else if (Sysutils.SameText(FieldByname('Status').asString , 'DepositReconcile') ) or
                     (Sysutils.SameText(FieldByname('Status').asString , 'Reconciled')) then
                result := ltReconciled;
        finally
            if active then close;
            Free;
        end;
    finally
        FreeandNil(SQLList);
    end;
end;
procedure TCheque.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  fdChequetotal:= self.TotalAmountInc
end;

class function TCheque.DepositIdForPayment(const aPaymentId: integer;
  TransTypeList: string; Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select DepositID from tblBankDepositLines');
    qry.SQL.Add('where PaymentID = ' + IntToStr(aPaymentID));
    qry.SQL.Add('and TrnsType in (' + TransTypeList + ')');
    qry.Open;
    result:= qry.FieldByName('DepositID').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TCheque.ValidateAcountIDCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(Sender is TChequeLines) then exit;
  if TChequeLines(Sender).AccountName = tcdatautils.GetAccountName(Self.glaccountID) then begin
    TChequeLines(Sender).Accountname := '';
    TChequeLines(Sender).AccountName := '';
    TChequeLines(Sender).PostDB;
  end;
end;

function TCheque.getIsreconciled: Boolean;
var
  ftLockType: TTransLockType;
  fbPaymentLock: boolean;
  PaymentsManagement: TLockManagement;
begin
  PaymentsManagement := TLockManagement.Create;
  try
    fbPaymentLock := PaymentsManagement.IsChequeLocked(ID, ftLockType);
    REsult := (fbPaymentLock and (ftLockType in [ltOnHoldRec, ltReconciled]));
  finally
    FreeandNil(PaymentsManagement);
  end;
end;

function TCheque.getOrderLines: TOrderLineBase;
begin
 Result := TOrderLineBase(Lines);
end;

{TBill}
Function TBill.ValidateData :Boolean ;
begin
  result := inherited  ValidateData;
  if not result then Exit;
  if assigned(ConfirmFromGUI) then
    if not Math.SameValue(BillTotal, TotalAmountInc, 0.000001) then begin
         if (not (assigned(ConfirmFromGUI))) or
                (fConfirmFromGUI('Bill Total does not equal Total Amount' + chr(13) + chr(13) +
                    'Do you wish to update the Total?' , [mbYes,MbNO]) = mrno) then begin
            Result := False;
            Exit;
         end;
    end;
  if not Math.SameValue(BillTotal, TotalAmountInc, 0.000001) then begin
    AddResult(false,rssWarning,0,'Bill Total does not equal Total Amount.');
    result := false;
    exit;
  end;

//  if not ValidateApproval then
//    result := false;
  if Approved then
    result := TApprovalCheck.Approved(self);
end;

Function TBill.GetBillLines: TBillLines;
begin
  PostDB;
  Result := TBillLines(getContainerComponent(TBillLines , 'PurchaseOrderID = ' + IntToStr(ID)));
end;

Function TBill.UpdateAccounts:Boolean;
var
  CleanSupplierID: Integer;
  CleanTotalAmountInc: Double;
  CleanNode: IXMLNode;
  CleanGlaccountid: Integer;
  TaxPaidID: Integer;
begin
    Show_Status('Update Accounts.');
    TaxPaidID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_PAID);
    CleanNode:= self.CleanXMLNode;
    if assigned(CleanNode)  then  begin
        CleanTotalAmountInc := GetXMLNodeFloatValue(CleanNode,'Totalamountinc');
        if CleanTotalAmountInc =0 then else begin
          CleanSupplierID     := GetXMLNodeIntegerValue(CleanNode,'Clientid');
            POstList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
              CleanSupplierID, CleanTotalAmountInc );

          CleanGlaccountid:= GetXMLNodeIntegerValue(CleanNode,'Glaccountid');
            PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
              CleanGlaccountid, -(CleanTotalAmountInc));
            PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
              TaxPaidID, -(GetXMLNodeFloatValue(CleanNode,'Totaltax')));
        end;
    end;


    PostList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
         SupplierID,  -TotalAmountInc );

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      Glaccountid,  TotalAmountInc);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxPaidID, TotalTax);

    Lines.IterateRecords(LineBalanceCallbackProc, true);

    REsult := True;
end;
procedure TBill.LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean);
var
  CleanNode: IXMLNode;
  cleanAccountID :Integer;
  CleanTotLineAmt :Double;
begin
  CleanNode:= TBillLines(Sender).CleanXMLNode;
  if Assigned(CleanNode) then  begin
        cleanAccountID    := tcDatautils.GetAccountID(GetXMLNodeStringValue(CleanNode,'Accountname'));
        CleanTotLineAmt     := GetXMLNodeFloatValue(CleanNode,'Totallineamount');

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            cleanAccountID, - CleanTotLineAmt);
  end;
  if TBillLines(Sender).Deleted = False then begin
    PostList.AddAmount(TBillLines(Sender).LineGLAccount.ClassName,
                    TBillLines(Sender).LineGLAccount.BusObjectTableName,
                    TBillLines(Sender).LineGLAccount.ID,
                    TBillLines(Sender).Totallineamount);
    UpdateAccountTaxcode(Sender);
  end;
end;
Function  TBill.GetExpenseLines: TExpenseLineBase;
begin
    Result := TExpenseLineBase(Lines);
end;
function  TBill.Save : Boolean;
begin
  if not dirty then begin
      result := true;
      Exit;
  end;
  Result := false;
  try
    if OrderDate = 0 then OrderDate := Date;
    PostDB;
    PostList.Clear;
    result := inherited Save; {does the validation}
    if not result then Exit;
    if CleanApproved <> Approved then AddToPayAuthorisations;
    UpdateAccounts;
    if not PostList.Execute then begin
        Result  := False;

        Exit;
    end;

  finally
    if result then  result :=  Validtocommit;
  end;
  if result then begin
    if DeleteFlaggedLines then
      Dirty := False
    else
      result := False;
  end;
end;
procedure TBill.OnDataIdChange (Const ChangeType: TBusObjDataChangeType);
begin
    inherited;
    Billtotal := 0;
end;

procedure TBill.PopulateMessageSubstituteList(SL: TStringList);
var
  s: string;
begin
  s:=
    'Select p.PurchaseOrderId ,  ' +
    ' C.FirstName, ' +
    ' ifNull(P.ShipTo, "Unknown") as ShipTo, ' +
    ' ifnull(PL.UnitofMeasureShipped,0) as Shipped ' +
//    ', concat(PL.Productname ,"     : " ,  PL.UnitofMeasureShipped , "  of  " ,   concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details ' +
    ' from tblpurchaseorders p ' +
    ' inner join tblpurchaselines PL on P.PurchaseOrderId = PL.PurchaseOrderId   ' +
    ' inner join tblclients c on c.clientId = p.clientID' +
//    ' where ifnull(PL.UnitofMeasureShipped,0) <> 0 and P.PurchaseOrderId = ' + IntToStr(ID);
    ' where P.PurchaseOrderId = ' + IntToStr(ID);
  with TERPQuery(GetNewDataset(s)) do try
    SL.Values['#BillID#'] := IntToStr(ID);

      SL.Values['#Address#'] := Fieldbyname('ShipTo').asString;
//    SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
      SL.Values['#FirstName#'] := Fieldbyname('FirstName').asString;
  finally
    Free;
  end;
end;

function TBill.RepairTotal(const RepairID: Integer): double;
begin
  With getNewDataset('Select Sum(totalLineamountinc) totallineAmountinc from ' +
                      ' tblpurchaseorders PO  ' +
                      ' inner join tblpurchaselines PL on PO.purchaseOrderId = Pl.purchaseOrderId ' +
                      ' where PO.isbill ="T"  ' +
                      ' and pl.repairID = ' +inttostr(RepairID), true) do try
    Result := fieldbyname('totallineAmountinc').AsFloat;
  finally
    if active then close;
    Free;
  end;
end;

procedure TBill.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        InitAPAccount;
        AddEvent(BusObjEvent_Change,BusObjEventVal_AccountID,Self.Id);
    end else if Sysutils.SameText(Sender.fieldName , 'OrderDate') then begin
        //
    end else if Sysutils.SameText(Sender.FieldName, 'Approved') then begin
        //ValidateApproval;
        if Approved then
          TApprovalCheck.Approved(self, Sender);
        //AddEvent(BusObjEvent_Change, BusObjEventVal_Approved, Self.ID);
    end;
    inherited;
    { run these after inherited to ensure terms set first }
    if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        SetPaymentTerms(OrderDate);
    end else if Sysutils.SameText(Sender.fieldName , 'OrderDate') then begin
        SetPaymentTerms(OrderDate);
    end else if Sysutils.SameText(Sender.fieldName , 'Terms') then begin
        SetPaymentTerms(OrderDate);
    end;
end;

Function TBill.DoRoundFix:Boolean;
var
  fiFixAccountID:Integer;
  aAccessLevel:Integer;
  fd:Double;
begin
  inherited;
    Result := false;

    if abs(Round(TotalBalance,5))=0  then begin
      Exit;
    end;

    aAccessLevel :=accessmanager.accesslevel ;
    try
      Connection.beginNestedTransaction;
      try
        accessmanager.accesslevel := 1;


        fiFixAccountID:= TAccount.MakeAccount(Self, GLACCOUNT_ROUNDFIX, '', 'EXP', true);
        if fiFixAccountID =0 then begin
          MessageDlgXP_Vista('Failed to Create "Round Fix" Expense Account.  Please Create this Account and Choose This Option again', mtInformation, [mbOK], 0);
          EXit;
        end;
        Lines.New;
        Lines.AccountName :=  GLACCOUNT_ROUNDFIX;
        Lines.LineTaxRate := 0;
        fd :=0-Round(TotalBalance,5);
        Lines.Linecost          := fd;
        Lines.LineCostinc       := fd;
        Lines.TotalLineAmount   := fd;
        Lines.TotalLineAmountInc:= fd;
        Lines.PostDB;
        if not save then begin
          connection.RollbackNestedTransaction;
          Exit;
        end;
        connection.CommitNestedTransaction;
        Dirty := True;
        Result := True;
      Except
        on E:Exception do begin
          connection.RollbackNestedTransaction;
        end;
      end;
    finally
      accessmanager.accesslevel := aAccessLevel;
    end;
end;

function TBill.getApprovaltype: String;
begin
  Result := 'Bill';
end;

constructor TBill.Create(aOwner: TComponent);
begin
  inherited;
  fSQL := 'Select * from tblPurchaseOrders where IsBill = "T"';
  fBusObjectTypeDescription := 'Bill';
end;

Function TBill.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult      := inherited DoAfterInsert(Sender);
    if not result  then Exit;
    IsCredit    := False;
    IsBill      := True;
    IsCheque    := False;
    InitAPAccount;
end;
Function TBill.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoBeforePost(Sender);
    if not result then Exit;
end;
function TBill.getOrderLines: TOrderLineBase;
begin
 Result := TOrderLineBase(Lines);
end;


{TBillLines}
function TBillLines.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited  DoBeforeDelete(Sender);
  if not(result) then exit;
  GA_ERP_Posting.DeleteAll;
end;

Function TBillLines.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoBeforePost(Sender);
    if not result then Exit;

    if {(not DatasetPosting) and} (TAccount.IDToggle(AccountName,self.Connection.Connection) = 0) and (LineCost = 0) and (CustomerJobID = 0) then
        if CleanAccountName = '' then
          Deleted := True
        else
          abort;
end;

Function TBillLines.GetCleanAccountName :String;
begin
    REsult := GetXMLNodeStringValue(CleanXMLNode, 'Accountname');
end;

function TBillLines.getGA_ERP_Posting: TGA_ERP_Posting;
begin
    PostDB;
    REsult :=  TGA_ERP_Posting(getContainerComponent(TGA_ERP_Posting , 'PurchaseOrderId =' +inttostr(PurchaseOrderID) +' and PurchaseLineID =' + inttostr(ID)));
end;

{TBillLines}

Function TChequeLines.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoBeforePost(Sender);
    if not result then Exit;

    if {(not DatasetPosting) and} (TAccount.IDToggle(AccountName,self.Connection.Connection) = 0) and (LineCost = 0) and (CustomerJobID = 0) then
        if CleanAccountName = '' then
          Deleted := True
        else
          abort;
end;
procedure TChequeLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if (Sysutils.SameText(Sender.Fieldname ,'AccountName' )) or
       (Sysutils.SameText(Sender.Fieldname ,'AccountNumber')) then begin
        if tcdatautils.GetAccountid(Accountname) = HeaderAccountID then begin
            SendEvent( BusObjEvent_Change,BusObjEventVal_AccountSameAsHeader, self);
            Accountname := '';
            Accountnumber:= '';
        end;
    end;
end;

Function TChequeLines.GetCleanAccountName :String;
begin
    REsult := GetXMLNodeStringValue(CleanXMLNode, 'Accountname');
end;

{TCreditLines}
Function TCreditLines.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoBeforePost(Sender);
    if not result then Exit;

    if {(not DatasetPosting) and} (AccountName = '') and (LineCost = 0) and (CustomerJobID = 0) then
        if CleanAccountName = '' then
          Deleted := True
        else
          abort;
end;
Function TCreditLines.GetCleanAccountName :String;
begin
    REsult := GetXMLNodeStringValue(CleanXMLNode, 'Accountname');
end;
function TChequeLines.HeaderAccountID:Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TCheque then
      result := TCheque(Self.Owner).GLAccountId;
end;

initialization
  RegisterClassOnce(TCredit);
  RegisterClassOnce(TCreditLines);
  RegisterClassOnce(TBill);
  RegisterClassOnce(TBillLines);
  RegisterClassOnce(TCheque);
  RegisterClassOnce(TChequeLines);
  RegisterClassOnce(TBillEx);
  RegisterClassOnce(TChequeEx);
  RegisterClassOnce(TCreditEx);
end.

