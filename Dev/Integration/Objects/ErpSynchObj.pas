unit ErpSynchObj;

interface

uses
  utBaseCoreService, BusObjSales, ERPDBComponents, JsonObject, BusObjClient,
  BusObjCommon, BusObjStock, BusObjTaxCodes, BusObjGLAccount, Classes,
  BusObjBase, BusObjExpenses, BusObjOrders, LogThreadBase, ERPEDIBase;

type
//  TErpSynch = class;
//  TErpSynchProgEvent = procedure(Sender: TErpSynch; var Continue: boolean; msg: string = '') of object;

  TErpSynch = class(TERPEDIBase)
  private
//    fCoreService: TBaseCoreService;
//    fOnSynchProgress: TErpSynchProgEvent;
//    fSynchType: string;
//    fTotalItemsToSynch: integer;
//    fCurrentSynchItemNo: integer;
//    fUserMessage: string;
//    fAPIMessage: string;
//    fReturnCode: string;
//    fCurrentSynchId: integer;
//    fOnSynchError: TNotifyEvent;
//    fActive: boolean;
//    ContinueSynch: boolean;
    fConnection: TERPConnection;
//    fCurrentSynchItemType: string;
    fAccountMustExistInRemote: boolean;
    fTaxCodeMustExistInRemote: boolean;
    fTermsMustExistInRemote: boolean;
    fTaxRateMustExistInRemote: boolean;
//    fOnLog: TOnLogStrEvent;
//    procedure DoProgress(const msg: string = '');
//    procedure DoError; overload;
//    procedure DoError(const aUserMessage: string; const aReturnCode: string = 'Error'; const aAPIMEssage: string = ''); overload;
    function GetConnection: TERPConnection;
    procedure Delay(secs: integer);

    function AddCustPaymentToERP(Data: TJsonObject): boolean;
    function AddSuppPaymentToERP(Data: TJsonObject): boolean;
    function DtToStr(aDt: TDateTime): string;
    function AddERPObject(Data: TJsonObject; VerifyExists: boolean = true): boolean;
 //   procedure Log(const msg: string; const aType: string = '');
//    Procedure AddorUpdateOrder(Data: TJsonObject);
    function CheckPONegative(const POId: integer; var PositiveLineCount: integer): boolean;
    function GetPOsLinketToQuickbooksBill(BillId: string; BillAmount: double;
      TransList: TJsonArray; var RunningBalance: double; var msg: string): boolean;
    function AddCustomerToERP(ExternalID: string): boolean;
    function AddQuickbooksCustomerToERP(ExternalID: string): boolean;
    function AddSupplierToERP(ExternalID: string): boolean;
    function AddQuickbooksSupplierToERP(ExternalID: string): boolean;

    function AddRefundSaleToERP(ExternalID: string): boolean;
    function AddQuickbooksRefundSaleToERP(ExternalID: string): boolean;
  protected
    property Connection: TERPConnection read GetConnection write fConnection;
    function SynchInvoice(Inv: TInvoice; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchInvoice(InvId: integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchCustomer(Cust: TClient; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchCustomer(CustId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchSupplier(Supplier: TSupplier; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchSupplier(SupplierId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchTerms(Terms: TTerms; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchTerms(TermsId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchProduct(Product: TProduct; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchProduct(ProductId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchTaxCode(TaxCode: TTaxCode; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchTaxCode(TaxCodeId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchSubTaxCode(SubTaxCodeId: Integer; var Id: string; Params: TJsonObject = nil): boolean;

    function SynchAccount(Account: TAccount; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchAccount(AccountId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchBill(Bill: TBill; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchBill(BillId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;

    function SynchPurchaseOrder(PurchaseOrder: TPurchaseOrder; var Id: string; Params: TJsonObject = nil): boolean; overload;
    function SynchPurchaseOrder(PurchaseOrderId: Integer; var Id: string; Params: TJsonObject = nil): boolean; overload;
    //procedure Log(const msg: string; const aType: string = '');
    Function InvoiceAddress(Const aFirstname, aMiddleNAme, aLastname, acompanyname,ajobname,aContactname ,aaddress1, aaddress2, aaddress3, acity, astate, apostcode,acountry, aextraInfo:String):String;
//    function CheckCustomer(aCustomerId: integer; aCustomerName: string; var aExternalID: string): boolean;
    function Serialise(obj: TObject): TJsonObject;

  public
    constructor Create; virtual;
    destructor Destroy; override;
//    property CoreService: TBaseCoreService read fCoreService write fCoreService;
    procedure SynchData(const aType: string);
    procedure DoSynchInvoice(aId, aRecNo, aRecCount: integer);
    procedure DoSynchBill(aId, aRecNo, aRecCount: integer);
    procedure DoSynchPurchaseOrder(aId, aRecNo, aRecCount: integer);
//    property OnSynchProgress: TErpSynchProgEvent read fOnSynchProgress write fOnSynchProgress;
//    property OnSynchError: TNotifyEvent read fOnSynchError write fOnSynchError;
//    property SynchType: string read fSynchType;
//    property TotalItemsToSynch: integer read fTotalItemsToSynch;
//    property CurrentSynchItemNo: integer read fCurrentSynchItemNo;
//    property CurrentSynchId: integer read fCurrentSynchId;
//    property CurrentSynchItemType: string read fCurrentSynchItemType;
//    property UserMessage: string read fUserMessage;
//    property APIMessage: string read fAPIMEssage;
//    property ReturnCode: string read fReturnCode;
//    property Active: boolean read fActive write fActive;
    property AccountMustExistInRemote: boolean read fAccountMustExistInRemote write fAccountMustExistInRemote;
    property TaxCodeMustExistInRemote: boolean read fTaxCodeMustExistInRemote write fTaxCodeMustExistInRemote;
    property TaxRateMustExistInRemote: boolean read fTaxRateMustExistInRemote write fTaxRateMustExistInRemote;
    property TermsMustExistInRemote: boolean read fTermsMustExistInRemote write fTermsMustExistInRemote;
//    property OnLog: TOnLogStrEvent read fOnLog write fOnLog;

    procedure SynchPaymentsFromRemote;
    procedure GetCustomersFromRemote;
    procedure GetSuppliersFromRemote;
    procedure GetRefundSalesFromRemote;

  end;


(*  Examples of Quickbooks Query

  select * from JournalEntry Where Metadata.LastUpdatedTime>'2014-09-15T00:00:00-07:00' Order By Metadata.LastUpdatedTime

  select * from Account MaxResults 1 StartPosition 2

*)

implementation

uses
  SysUtils, CommonDbLib, BusObjExternalXRef, utCoreEDIConst, DateUtils,
  ObjectSerialiser, DbSharedObjectsObj, MySQLUtils, AppEnvironment, Forms,
  DateTimeUtils, BusObjPayments, tcTypes, BusObjPayMethods, tcConst, CommonLib,
  BusObjContact, BusObjCash;

{ TErpSynch }

function TErpSynch.AddCustomerToERP(ExternalID: string): boolean;
begin
  result := true;
  try
    if SameText(CoreService.ServiceName, utCoreEDIConst.Servicename_Quickbooks) then begin
      result := AddQuickbooksCustomerToERP(ExternalID);

    end;
  except
    on e: exception do begin
      result := false;
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.AddCustPaymentToERP(Data: TJsonObject): boolean;
var
  CustomerId: integer;
  PayMethodId: integer;
  DepositAccountId: integer;
  I: Integer;
  JsonLine: TJsonObject;
  Id: integer;
  TxnType: string;
  CustPayment: TCustomerPayments;
  msg: string;
  qry: TERPQuery;
  TransFound: boolean;
begin
  result := true;
  try
    if SameText(CoreService.ServiceName, utCoreEDIConst.Servicename_Quickbooks) then begin
      if TExternalXRef.IsDone(CoreService.ServiceName,ExRef_Objtype_Payment, Data.S['Id'], 0) then
        exit;
      CustomerId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Customer, Data.O['CustomerRef'].S['value']);
      if CustomerId = 0 then begin
        result := false;
        DoError('Customer Payment, ERP Customer not found for Quickbooks Customer: "' + Data.O['CustomerRef'].S['name'] + '" Amount: ' + FloatToStr(Data.F['TotalAmt']));
        exit;
      end;
      PayMethodId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_PaymentMethod, Data.O['PaymentMethodRef'].S['value']);
      if PayMethodId = 0 then begin
        result := false;
        DoError('ERP Payment Method not found for Quickbooks Payment Method.');
        exit;
      end;
      if Data.F['UnappliedAmt'] <> 0 then begin
        result := false;
        DoError('Quickbooks Payment is not fully applied, can not add to ERP.');
        exit;
      end;
      DepositAccountId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Account, Data.O['DepositToAccountRef'].S['value']);
      if PayMethodId = 0 then begin
        result := false;
        DoError('ERP Account not found for Quickbooks Deposit Account.');
        exit;
      end;
      { make sure we have all of the linked records .. }
      for I := 0 to Data.A['Line'].Count -1 do begin
        JsonLine := Data.A['Line'][I].AsObject;
        { TxnType can be: Expense,Check,CreditCardCredit,JournalEntry,CreditMemo or Invoice }
        TxnType := JsonLine.A['LinkedTxn'][0].AsObject.S['TxnType'];
        if not SameText(TxnType,'Invoice') then begin
          result := false;
          DoError('Quickbooks Payment Line is Linked to unsupported type: ' + TxnType);
          exit;
        end;
        Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, TxnType, JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']);
        if Id = 0 then begin
          result := false;
          DoError('ERP '+TxnType+' not found for Quickbooks '+TxnType+'.');
          exit;
        end;
      end;
      { all good, now customer payment }
      if TExternalXRef.IsStarted(CoreService.ServiceName,ExRef_Objtype_Payment, Data.S['Id'], 0) then begin
        { does it exist in ERP .. }
        qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
        try
          qry.SQL.Add('select * from tbldeposits');
          qry.SQL.Add('where Customer = "T" and Deleted = "F"');
          qry.SQL.Add('and CusId = ' + IntToStr(CustomerId));
          qry.SQL.Add('and PayMethodId = ' + IntToStr(PayMethodId));
          qry.SQL.Add('and AccountId = ' + IntToStr(DepositAccountId));
          qry.SQL.Add('and ReferenceNo = ' + QuotedStr(Data.S['PaymentRefNum']));
          qry.SQL.Add('and Amount = ' + FloatToStr(Data.F['TotalAmt']));
          qry.Open;
          if not qry.IsEmpty then begin
            { just complete then exit .. }
            if not TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Payment,qry.FieldByName('PaymentID').AsInteger, Data.S['Id'], msg, RFC3339StrToDateTimeUTC(Data.O['MetaData'].S['CreateTime'])) then begin
              result := false;
              DoError(msg);
            end;
            exit;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end;
      { else .. do it }
      if not TExternalXRef.StartNew(CoreService.ServiceName, ExRef_Objtype_Payment, Data.S['Id'], msg) then begin
        result := false;
        DoError(msg);
        exit;
      end;
      CustPayment := TCustomerPayments.CreateWithNewConn(nil);
      try
        CustPayment.SilentMode := true;
        CustPayment.Connection.BeginTransaction;
        try
          CustPayment.New;
          CustPayment.PaymentDate := Data.DT['TxnDate'];
          CustPayment.EmployeeId := AppEnv.Employee.EmployeeID;
          CustPayment.AccountId := DepositAccountId;
          CustPayment.ClientID := CustomerId;
          CustPayment.PayMethodID := PayMethodId;
          CustPayment.ForeignExchangeCode := Data.O['CurrencyRef'].S['value'];
          CustPayment.ReferenceNo := Data.S['PaymentRefNum'];
          CustPayment.Amount := Data.F['TotalAmt'];

          for I := 0 to Data.A['Line'].Count -1 do begin
            JsonLine := Data.A['Line'][I].AsObject;
            { TxnType can be: Expense,Check,CreditCardCredit,JournalEntry,CreditMemo or Invoice }
            TxnType := JsonLine.A['LinkedTxn'][0].AsObject.S['TxnType'];
            Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, TxnType, JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']);
            CustPayment.GUILines.First;
            TransFound := false;
            while not CustPayment.GUILines.EOF do begin
              if SameText(TxnType, 'Invoice') and
                 SameText(CustPayment.GUILines.TransType, tcConst.InvType) and
                 (CustPayment.GUILines.TransID = ID) then begin
                TransFound := true;
                if CustPayment.GUILines.AmountOutStanding < JsonLine.F['Amount'] then begin
                  result := false;
                  DoError('Outstanding amount '+FloatToStr(CustPayment.GUILines.AmountOutStanding)+' in ERP is less than payment amount ' +
                     FloatToStr(JsonLine.F['Amount']) + ' from Quickbooks '+TxnType+' for ERP Customer ' + CustPayment.client.PrintName);
                  exit;
                end;
                CustPayment.GUILines.Applied := true;
                CustPayment.GUILines.Payment := JsonLine.F['Amount'];
                break;
              end;
              CustPayment.GUILines.Next;
            end;
            if not TransFound then begin
              result := false;
              DoError('Could not find oustanding Quickbooks transaction ' + TxnType + ' for ERP Customer ' + CustPayment.client.PrintName);
              exit;
            end;
//            CustPayment.Lines.New;
//            Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, TxnType, JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']);
//            if SameText(TxnType, 'Invoice') then begin
//              CustPayment.Lines.InvoiceId := Id;
//            end;
//            CustPayment.Lines.Payment := JsonLine.F['Amount'];
          end;

          if CustPayment.Save then begin
            CustPayment.Connection.CommitTransaction;
            DoProgress('Created new Customer Payment for: ' + CustPayment.client.PrintName);
            if not TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Payment,CustPayment.ID, Data.S['Id'], msg, RFC3339StrToDateTimeUTC(Data.O['MetaData'].S['CreateTime'])) then begin
              result := false;
              DoError(msg);
            end;
          end
          else begin
            result := false;
            CustPayment.Connection.RollbackTransaction;
            DoError(CustPayment.ResultStatus.Messages);
          end;
        except
          on e: exception do begin
            CustPayment.Connection.RollbackTransaction;
            raise;
          end;
        end;
      finally
        if CustPayment.Connection.InTransaction then
          CustPayment.Connection.RollbackTransaction;
        CustPayment.Free;
      end;
    end;
  except
    on e: exception do begin
      result := false;
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.AddERPObject(Data: TJsonObject;
  VerifyExists: boolean): boolean;
var
  aType: string;
  Id: string;
  dt: TDateTime;
  Exists: Boolean;
begin
  result := CoreService.AddERPObject(data);
  if not result then exit;
  if VerifyExists then begin
    aType := data.S['type'];
    Id := CoreService.ResultData.S['Id'];
   { check in remote system .. and wait if not there yet }
    dt := now + (OneSecond * 60);
    while now <= dt do begin
      Delay(2);
      result := CoreService.ERPObjectExists(aType,Id,Exists);
//      if not result then begin
//        exit;
//      end;
      if Exists then begin
        result := true;
        exit;
      end;
      Delay(2);
    end;
    CoreService.ResultData.S[Name_UserMessage] := 'Timed out validating ' + aType + ' has been sent to Quickbooks';
  end;
end;

function TErpSynch.AddQuickbooksCustomerToERP(ExternalID: string): boolean;
var
  ExtId: string;
  ErpID: integer;
  SynchStatus: string;
  CustJson: TJsonObject;
  s: string;
  msg: string;
  Customer: TClient;
  Contact: TContact;
  ParentID: integer;
begin
  result := true;
  ErpId := 0;
  ExtId := ExternalID;
  Contact := nil;
  if TExternalXRef.Exists(CoreService.ServiceName,ExRef_Objtype_Customer, ExtId, ErpId, SynchStatus) then begin
    { found }
    if SameText(SynchStatus, 'Done') then
      exit;
  end;
  { not found }
  CustJson := JO;
  try
    { get object from Quickbooks }
    if CoreService.GetObject('Customer', ExternalID) then begin
      CustJson.Assign(CoreService.ResultData.O['Data']);
//      if SameText(SynchStatus, 'Started') then begin
//        { do we have this customer in ERP ? }
//        ERPId := TCustomer.IDToggle(CustJson.S['DisplayName']);
//        if ERPId > 0 then begin
//          if TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Customer, ERPId, ExternalID, msg) then
//            exit
//          else begin
//            result := false;
//            DoError(msg);
//            exit;
//          end;
//
//        end;
//      end;

      { if we have a customer with same name in ERP, link to that .. }
      ERPId := TCustomer.IDToggle(CustJson.S['DisplayName']);
      if ERPId > 0 then begin
        if TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Customer, ERPId, ExternalID, msg) then
          exit
      end;

      { create customer in ERP ... }
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Customer, ExternalID, msg) then begin
        result := false;
        DoError(msg);
        exit;
      end;
      if CustJson.B['Job'] then
        Customer := TJob.CreateWithNewConn(nil)
      else
        Customer := TCustomer.CreateWithNewConn(nil);
      try
        Customer.SilentMode := true;
        Customer.Connection.BeginTransaction;
        try
          Customer.New;
          if CustJson.B['Job'] then begin
            TJob(Customer).JobName := CustJson.S['DisplayName'];
          end
          else begin
            Customer.ClientName := CustJson.S['DisplayName'];
          end;
          if CustJson.ObjectExists('ParentRef') then begin
            ParentId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, ExRef_Objtype_Customer, CustJson.O['ParentRef'].S['value']);
            if ParentID < 1 then begin
              result := false;
              DoError('Could not find parent Customer "' + CustJson.O['ParentRef'].S['name'] +
                '" in ERP, may not have been synchronized yet.' );
              exit;
            end;
            Customer.ParentClientId := ParentID;
          end;
          if CustJson.S['Title'] <> '' then
            Customer.Title := CustJson.S['Title'];
          if CustJson.S['GivenName'] <> '' then begin
            Customer.FirstName := CustJson.S['GivenName'];
          end;
          if CustJson.S['MiddleName'] <> '' then
            Customer.MiddleName := CustJson.S['MiddleName'];
          if CustJson.S['FamilyName'] <> '' then begin
            Customer.LastName := CustJson.S['FamilyName'];
          end;

          if CustJson.ObjectExists('PrimaryEmailAddr') then
            Customer.Email := CustJson.O['PrimaryEmailAddr'].S['Address'];
          if CustJson.ObjectExists('PrimaryPhone') then
            Customer.Phone := CustJson.O['PrimaryPhone'].S['FreeFormNumber'];
          if CustJson.ObjectExists('Fax') then
            Customer.Faxnumber := CustJson.O['Fax'].S['FreeFormNumber'];
          if CustJson.ObjectExists('Mobile') then
            Customer.Mobile := CustJson.O['Mobile'].S['FreeFormNumber'];
          if CustJson.ObjectExists('CurrencyRef') then
            Customer.ForeignExchangeCode := CustJson.O['CurrencyRef'].S['value'];
          if CustJson.ObjectExists('AlternatePhone') then
            Customer.AltPhone := CustJson.O['AlternatePhone'].S['FreeFormNumber'];
          if CustJson.S['Notes'] <> '' then
            Customer.Notes := CustJson.S['Notes'];
          if CustJson.ObjectExists('WebAddr') then
            Customer.URL := CustJson.O['WebAddr'].S['URI'];

          if CustJson.ObjectExists('ShipAddr') then begin
            if CustJson.O['ShipAddr'].S['Line1'] <> '' then
              Customer.Street := CustJson.O['ShipAddr'].S['Line1'];
            if CustJson.O['ShipAddr'].S['Line2'] <> '' then
              Customer.Street2 := CustJson.O['ShipAddr'].S['Line2'];
            if CustJson.O['ShipAddr'].S['Line3'] <> '' then
              Customer.Street3 := CustJson.O['ShipAddr'].S['Line3'];
            if CustJson.O['ShipAddr'].S['Line4'] <> '' then begin
              if Customer.Street3 <> '' then
                Customer.Street3 := Customer.Street3 + ' ';
              Customer.Street3 := Customer.Street3 + CustJson.O['ShipAddr'].S['Line4']
            end;
            if CustJson.O['ShipAddr'].S['Line5'] <> '' then begin
              if Customer.Street3 <> '' then
                Customer.Street3 := Customer.Street3 + ' ';
              Customer.Street3 := Customer.Street3 + CustJson.O['ShipAddr'].S['Line5']
            end;
            if CustJson.O['ShipAddr'].S['City'] <> '' then
              Customer.Suburb := CustJson.O['ShipAddr'].S['City'];
            if CustJson.O['ShipAddr'].S['CountrySubDivisionCode'] <> '' then
              Customer.State := CustJson.O['ShipAddr'].S['CountrySubDivisionCode'];
            if CustJson.O['ShipAddr'].S['Country'] <> '' then
              Customer.Country := CustJson.O['ShipAddr'].S['Country'];
          end;

          if CustJson.ObjectExists('BillAddr') then begin
            if CustJson.O['BillAddr'].S['Line1'] <> '' then
              Customer.BillStreet := CustJson.O['BillAddr'].S['Line1'];
            if CustJson.O['BillAddr'].S['Line2'] <> '' then
              Customer.BillStreet2 := CustJson.O['BillAddr'].S['Line2'];
            if CustJson.O['BillAddr'].S['Line3'] <> '' then
              Customer.BillStreet3 := CustJson.O['BillAddr'].S['Line3'];
            if CustJson.O['BillAddr'].S['Line4'] <> '' then begin
              if Customer.BillStreet3 <> '' then
                Customer.BillStreet3 := Customer.BillStreet3 + ' ';
              Customer.BillStreet3 := Customer.BillStreet3 + CustJson.O['BillAddr'].S['Line4']
            end;
            if CustJson.O['BillAddr'].S['Line5'] <> '' then begin
              if Customer.BillStreet3 <> '' then
                Customer.BillStreet3 := Customer.BillStreet3 + ' ';
              Customer.BillStreet3 := Customer.BillStreet3 + CustJson.O['BillAddr'].S['Line5']
            end;
            if CustJson.O['BillAddr'].S['City'] <> '' then
              Customer.BillSuburb := CustJson.O['BillAddr'].S['City'];
            if CustJson.O['BillAddr'].S['CountrySubDivisionCode'] <> '' then
              Customer.BillState := CustJson.O['BillAddr'].S['CountrySubDivisionCode'];
            if CustJson.O['BillAddr'].S['Country'] <> '' then
              Customer.BillCountry := CustJson.O['BillAddr'].S['Country'];
          end;

          if Customer.Save then begin
            if (Customer.FirstName <> '') or (Customer.LastName <> '') then begin
              { create customer contact ... }
              Contact := TContact.Create(nil);
              Contact.Connection := Customer.Connection;
              Contact.New;
              Contact.ClientID := Customer.ID;
//              Contact.IsPrimaryContact := true;
              if Customer.Title <> '' then
                Contact.ContactTitle := Customer.Title;
              s := '';
              if Customer.FirstName <> '' then begin
                Contact.ContactFirstName := Customer.FirstName;
                s := Customer.FirstName;
              end;
              if Customer.LastName <> '' then begin
                Contact.ContactSurName := Customer.LastName;
                if s <> '' then s := s + ' ';
                s := s + Customer.LastName;
              end;
              Contact.Company := s;
              if Customer.Phone <> '' then
                Contact.ContactPH := Customer.Phone;
              if Customer.Faxnumber <> '' then
                Contact.ContactFax := Customer.Faxnumber;
              if Customer.Mobile <> '' then
                Contact.ContactMOB := Customer.Mobile;

              if Customer.Street <> '' then
                Contact.ContactAddress := Customer.Street;
              if Customer.Street2 <> '' then
                Contact.ContactAddress2 := Customer.Street2;
              if Customer.Street3 <> '' then
                Contact.ContactAddress3 := Customer.Street3;
              if Customer.Suburb <> '' then
                Contact.ContactCity := Customer.Suburb;
              if Customer.State <> '' then
                Contact.ContactState := Customer.State;
              if Customer.Postcode <> '' then
                Contact.ContactPcode := Customer.Postcode;
              if Customer.Country <> '' then
                Contact.ContactCountry := Customer.Country;

              if Contact.Save then begin

              end
              else begin
                result := false;
                DoError('Error saving customer contact "' + Customer.ClientName + '": ' +  Contact.ResultStatus.Messages);
                exit;
              end;
            end;

            Customer.Connection.CommitTransaction;
            TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Customer, Customer.ID, ExternalID, msg);
            self.DoProgress('Added new customer to ERP: ' + Customer.ClientName);
            exit;
          end
          else begin
            result := false;
            DoError('Error saving customer "' + Customer.ClientName + '": ' +  Customer.ResultStatus.Messages);
            exit;
          end;
        finally
          if Customer.Connection.InTransaction then
            Customer.Connection.RollbackTransaction;
        end;
      finally
        Contact.Free;
        Customer.Free;
      end;
    end
    else begin
      result := false;
      s := 'Could not read Customer from Quickbooks for Id: ' + ExternalID;
      if CoreService.ResultData.S['UserMessage'] <> '' then
        s := s + ' ' + CoreService.ResultData.S['UserMessage'];
      DoError(s + '.');
      exit;
    end;
  finally
    CustJson.Free;
  end;
end;

function TErpSynch.AddQuickbooksRefundSaleToERP(ExternalID: string): boolean;
var
  ExtId: string;
  ErpID: integer;
  SynchStatus: string;
  RefundJson: TJsonObject;
  msg: string;
  Refund: TRefundSale;
begin
  result := true;
  ErpId := 0;
  ExtId := ExternalID;
  if TExternalXRef.Exists(CoreService.ServiceName,ExRef_Objtype_RefundSale, ExtId, ErpId, SynchStatus) then begin
    { found }
    if SameText(SynchStatus, 'Done') then
      exit;
  end;
  { not found }
  RefundJson := JO;
  try
    { get object from Quickbooks }
    if CoreService.GetObject('CreditMemo', ExternalID) then begin
      RefundJson.Assign(CoreService.ResultData.O['Data']);
      if SameText(SynchStatus, 'Started') then begin
        self.DoProgress('Credit Memo in Quickbooks for ' + RefundJson.O['CustomerRef'].S['name'] +
          ' Amount ' + FloatToStrF(RefundJson.F['TotalAmt'], ffCurrency, 15, CurrencyRoundPlaces) +
          ' synch is started but not complete, creatubg new REfund Sale in ERP');
      end;
      { create RefundSAle in ERP ... }
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_RefundSale, ExternalID, msg) then begin
        result := false;
        DoError(msg);
        exit;
      end;
      Refund := TREfundSale.CreateWithNewConn(nil);
      try
        Refund.SilentMode := true;
        Refund.Connection.BeginTransaction;
        try
          Refund.New;


        finally
          if Refund.Connection.InTransaction then
            Refund.Connection.RollbackTransaction;

        end;

      finally

      end;
    end;
  finally
    RefundJson.Free;

  end;
end;

function TErpSynch.AddQuickbooksSupplierToERP(ExternalID: string): boolean;
var
  ExtId: string;
  ErpID: integer;
  SynchStatus: string;
  SuppJson: TJsonObject;
  s: string;
  msg: string;
  Supplier: TClient;
  Contact: TContact;
//  ParentID: integer;
begin
  result := true;
  ErpId := 0;
  ExtId := ExternalID;
  Contact := nil;
  if TExternalXRef.Exists(CoreService.ServiceName,ExRef_Objtype_Supplier, ExtId, ErpId, SynchStatus) then begin
    { found }
    if SameText(SynchStatus, 'Done') then
      exit;
  end;
  { not found }
  SuppJson := JO;
  try
    { get object from Quickbooks }
    if CoreService.GetObject('Vendor', ExternalID) then begin
      SuppJson.Assign(CoreService.ResultData.O['Data']);
//      if SameText(SynchStatus, 'Started') then begin
//        { do we have this supplier in ERP ? }
//        ERPId := TSupplier.IDToggle(SuppJson.S['DisplayName']);
//        if ERPId > 0 then begin
//          if TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Supplier, ERPId, ExternalID, msg) then
//            exit
//          else begin
//            result := false;
//            DoError(msg);
//            exit;
//          end;
//
//        end;
//      end;

      { if exists in erp, link to this }
      { do we have this supplier in ERP ? }
      ERPId := TSupplier.IDToggle(SuppJson.S['DisplayName']);
      if ERPId > 0 then begin
        if TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Supplier, ERPId, ExternalID, msg) then
          exit
        else begin
          result := false;
          DoError(msg);
          exit;
        end;
      end;

      { create supplier in ERP ... }
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Supplier, ExternalID, msg) then begin
        result := false;
        DoError(msg);
        exit;
      end;
      Supplier := TSupplier.CreateWithNewConn(nil);
      try
        Supplier.SilentMode := true;
        Supplier.Connection.BeginTransaction;
        try
          Supplier.New;
          Supplier.ClientName := SuppJson.S['DisplayName'];
          if SuppJson.S['Title'] <> '' then
            Supplier.Title := SuppJson.S['Title'];
          if SuppJson.S['GivenName'] <> '' then begin
            Supplier.FirstName := SuppJson.S['GivenName'];
          end;
          if SuppJson.S['MiddleName'] <> '' then
            Supplier.MiddleName := SuppJson.S['MiddleName'];
          if SuppJson.S['FamilyName'] <> '' then begin
            Supplier.LastName := SuppJson.S['FamilyName'];
          end;

          if SuppJson.ObjectExists('PrimaryEmailAddr') then
            Supplier.Email := SuppJson.O['PrimaryEmailAddr'].S['Address'];
          if SuppJson.ObjectExists('PrimaryPhone') then
            Supplier.Phone := SuppJson.O['PrimaryPhone'].S['FreeFormNumber'];
          if SuppJson.ObjectExists('Fax') then
            Supplier.Faxnumber := SuppJson.O['Fax'].S['FreeFormNumber'];
          if SuppJson.ObjectExists('Mobile') then
            Supplier.Mobile := SuppJson.O['Mobile'].S['FreeFormNumber'];
          if SuppJson.ObjectExists('AlternatePhone') then
            Supplier.AltPhone := SuppJson.O['AlternatePhone'].S['FreeFormNumber'];

          if SuppJson.S['Notes'] <> '' then
            Supplier.Notes := SuppJson.S['Notes'];
          if SuppJson.ObjectExists('WebAddr') then
            Supplier.URL := SuppJson.O['WebAddr'].S['URI'];

//          if CustJson.ObjectExists('ShipAddr') then begin
//            if CustJson.O['ShipAddr'].S['Line1'] <> '' then
//              Customer.Street := CustJson.O['ShipAddr'].S['Line1'];
//            if CustJson.O['ShipAddr'].S['Line2'] <> '' then
//              Customer.Street2 := CustJson.O['ShipAddr'].S['Line2'];
//            if CustJson.O['ShipAddr'].S['Line3'] <> '' then
//              Customer.Street3 := CustJson.O['ShipAddr'].S['Line3'];
//            if CustJson.O['ShipAddr'].S['Line4'] <> '' then begin
//              if Customer.Street3 <> '' then
//                Customer.Street3 := Customer.Street3 + ' ';
//              Customer.Street3 := Customer.Street3 + CustJson.O['ShipAddr'].S['Line4']
//            end;
//            if CustJson.O['ShipAddr'].S['Line5'] <> '' then begin
//              if Customer.Street3 <> '' then
//                Customer.Street3 := Customer.Street3 + ' ';
//              Customer.Street3 := Customer.Street3 + CustJson.O['ShipAddr'].S['Line5']
//            end;
//            if CustJson.O['ShipAddr'].S['City'] <> '' then
//              Customer.Suburb := CustJson.O['ShipAddr'].S['City'];
//            if CustJson.O['ShipAddr'].S['CountrySubDivisionCode'] <> '' then
//              Customer.State := CustJson.O['ShipAddr'].S['CountrySubDivisionCode'];
//            if CustJson.O['ShipAddr'].S['Country'] <> '' then
//              Customer.Country := CustJson.O['ShipAddr'].S['Country'];
//          end;

          if SuppJson.ObjectExists('BillAddr') then begin
            if SuppJson.O['BillAddr'].S['Line1'] <> '' then
              Supplier.BillStreet := SuppJson.O['BillAddr'].S['Line1'];
            if SuppJson.O['BillAddr'].S['Line2'] <> '' then
              Supplier.BillStreet2 := SuppJson.O['BillAddr'].S['Line2'];
            if SuppJson.O['BillAddr'].S['Line3'] <> '' then
              Supplier.BillStreet3 := SuppJson.O['BillAddr'].S['Line3'];
            if SuppJson.O['BillAddr'].S['Line4'] <> '' then begin
              if Supplier.BillStreet3 <> '' then
                Supplier.BillStreet3 := Supplier.BillStreet3 + ' ';
              Supplier.BillStreet3 := Supplier.BillStreet3 + SuppJson.O['BillAddr'].S['Line4']
            end;
            if SuppJson.O['BillAddr'].S['Line5'] <> '' then begin
              if Supplier.BillStreet3 <> '' then
                Supplier.BillStreet3 := Supplier.BillStreet3 + ' ';
              Supplier.BillStreet3 := Supplier.BillStreet3 + SuppJson.O['BillAddr'].S['Line5']
            end;
            if SuppJson.O['BillAddr'].S['City'] <> '' then
              Supplier.BillSuburb := SuppJson.O['BillAddr'].S['City'];
            if SuppJson.O['BillAddr'].S['CountrySubDivisionCode'] <> '' then
              Supplier.BillState := SuppJson.O['BillAddr'].S['CountrySubDivisionCode'];
            if SuppJson.O['BillAddr'].S['Country'] <> '' then
              Supplier.BillCountry := SuppJson.O['BillAddr'].S['Country'];
          end;

          if Supplier.Save then begin
            if (Supplier.FirstName <> '') or (Supplier.LastName <> '') then begin
              { create customer contact ... }
              Contact := TContact.Create(nil);
              Contact.Connection := Supplier.Connection;
              Contact.New;
              Contact.ClientID := Supplier.ID;
//              Contact.IsPrimaryContact := true;
              if Supplier.Title <> '' then
                Contact.ContactTitle := Supplier.Title;
              s := '';
              if Supplier.FirstName <> '' then begin
                Contact.ContactFirstName := Supplier.FirstName;
                s := Supplier.FirstName;
              end;
              if Supplier.LastName <> '' then begin
                Contact.ContactSurName := Supplier.LastName;
                if s <> '' then s := s + ' ';
                s := s + Supplier.LastName;
              end;
              Contact.Company := s;
              if Supplier.Phone <> '' then
                Contact.ContactPH := Supplier.Phone;
              if Supplier.Faxnumber <> '' then
                Contact.ContactFax := Supplier.Faxnumber;
              if Supplier.Mobile <> '' then
                Contact.ContactMOB := Supplier.Mobile;

              if Supplier.Street <> '' then
                Contact.ContactAddress := Supplier.Street;
              if Supplier.Street2 <> '' then
                Contact.ContactAddress2 := Supplier.Street2;
              if Supplier.Street3 <> '' then
                Contact.ContactAddress3 := Supplier.Street3;
              if Supplier.Suburb <> '' then
                Contact.ContactCity := Supplier.Suburb;
              if Supplier.State <> '' then
                Contact.ContactState := Supplier.State;
              if Supplier.Postcode <> '' then
                Contact.ContactPcode := Supplier.Postcode;
              if Supplier.Country <> '' then
                Contact.ContactCountry := Supplier.Country;

              if Contact.Save then begin

              end
              else begin
                result := false;
                DoError('Error saving Supplier Contact "' + Supplier.ClientName + '": ' +  Contact.ResultStatus.Messages);
                exit;
              end;
            end;

            Supplier.Connection.CommitTransaction;
            TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Supplier, Supplier.ID, ExternalID, msg);
            self.DoProgress('Added new Supplier to ERP: ' + Supplier.ClientName);
            exit;
          end
          else begin
            result := false;
            DoError('Error saving Supplier "' + Supplier.ClientName + '": ' +  Supplier.ResultStatus.Messages);
            exit;
          end;
        finally
          if Supplier.Connection.InTransaction then
            Supplier.Connection.RollbackTransaction;
        end;
      finally
        Contact.Free;
        Supplier.Free;
      end;
    end
    else begin
      result := false;
      s := 'Could not read Supplier (Vendor) from Quickbooks for Id: ' + ExternalID;
      if CoreService.ResultData.S['UserMessage'] <> '' then
        s := s + ' ' + CoreService.ResultData.S['UserMessage'];
      DoError(s + '.');
      exit;
    end;
  finally
    SuppJson.Free;
  end;
end;

function TErpSynch.AddRefundSaleToERP(ExternalID: string): boolean;
begin
  result := true;
  try
    if SameText(CoreService.ServiceName, utCoreEDIConst.Servicename_Quickbooks) then begin
      result := AddQuickbooksRefundSaleToERP(ExternalID);

    end;
  except
    on e: exception do begin
      result := false;
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.AddSupplierToERP(ExternalID: string): boolean;
begin
  result := true;
  try
    if SameText(CoreService.ServiceName, utCoreEDIConst.Servicename_Quickbooks) then begin
      result := AddQuickbooksSupplierToERP(ExternalID);

    end;
  except
    on e: exception do begin
      result := false;
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.AddSuppPaymentToERP(Data: TJsonObject): boolean;
var
  SupplierId: integer;
  PayMethodId: integer;
  AccountId: integer;
  I: Integer;
  JsonLine: TJsonObject;
  Id: integer;
  TxnType: string;
  SuppPayment: TSupplierPayments;
  PymentType: string;
  msg: string;
  qry: TERPQuery;
  TransFound: boolean;
  PaymentList: TJsonArray;
  BillJson, obj: TJsonObject;
  s: string;
//  LinkedTxnIdx: integer;
//  LinkedRef: TJsonObject;
  RunningTotal: double;
//  POCount: integer;
//  TotalBalance: double;

  function UpdatePO(aPOId: integer; Conn: TMyDacDataConnection = nil): boolean;
  var
    PO: TPurchaseOrder;
  begin
    result := true;
    if Assigned(Conn) then
      PO := TPurchaseOrder.Create(nil) //WithNewConn(nil);
    else
      PO := TPurchaseOrder.CreateWithNewConn(nil);
    try
      if Assigned(Conn) then
        PO.Connection := Conn;
      PO.SilentMode := true;
      PO.Load(aPOId);
      if PO.ClientId <> SupplierID then begin
        result := false;
        s := 'Payment Client "' + Data.O['VendorRef'].S['value']+ '" does not match linked PO Client "' +
          PO.ClientPrintName + '".';
        DoError(s);
        exit;
      end;
      if PO.SupplierInvoiceNumber = '' then begin
        if not Assigned(Conn) then
          PO.Connection.BeginTransaction;
        s := Data.S['DocNumber'];
        if s <> '' then
          s := s + '-';
        s := s + IntToStr(PO.ID);
        PO.SupplierInvoiceNumber := s;
        PO.SupplierInvoiceDate := Data.DT['TxnDate'];
        PO.PostDb;
        if not Assigned(Conn) then
          PO.Connection.CommitTransaction;
      end;
    finally
      if not Assigned(Conn) then begin

        if PO.Connection.InTransaction then
          PO.Connection.RollbackTransaction;
      end;
      PO.Free;
    end;
  end;

begin
  result := true;
  try
    AccountID := 0;
    PayMethodId := 0;
    PaymentList := TJsonArray.Create;
    BillJson := JO;
    try
      if SameText(CoreService.ServiceName, 'Quickbooks') then begin
        if TExternalXRef.IsDone(CoreService.ServiceName,'BillPayment', Data.S['Id'], 0) then
          exit;
        SupplierId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,'Supplier', Data.O['VendorRef'].S['value']);
        if SupplierId = 0 then begin
          result := false;
          DoError('Supplier Payment, ERP Supplier not found for Quickbooks Vendor: "' +Data.O['VendorRef'].S['name'] + '" Amount: ' + FloatToStr(Data.F['TotalAmt']));
          exit;
        end;
        PymentType := Data.S['PayType'];
        if SameText(Data.S['PayType'], 'Check') then begin
          PayMethodId := TPaymentMethod.IDToggle('Check');
          if PayMethodId = 0 then
            PayMethodId := TPaymentMethod.IDToggle('Cheque');
          if PayMethodId = 0 then begin
            result := false;
            DoError('ERP Payment Method not found for "Check" or "Cheque".');
            exit;
          end;
          AccountID := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,'Account',Data.O['CheckPayment'].O['BankAccountRef'].S['value']);
          if AccountId = 0 then begin
            result := false;
            DoError('ERP Account not found for Quickbooks Bank Account: ' + Data.O['CheckPayment'].O['BankAccountRef'].S['name']);
            exit;
          end;
        end
        else if SameText(Data.S['PayType'], 'CreditCard') then begin
          PayMethodId := TPaymentMethod.IDToggle('Credit Card');
          if PayMethodId = 0 then begin
            result := false;
            DoError('ERP Payment Method not found for "Credit Card".');
            exit;
          end;
          AccountID := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,'Account',Data.O['CreditCardPayment'].O['CCAccountRef'].S['value']);
          if AccountId = 0 then begin
            result := false;
            DoError('ERP Account not found for Quickbooks Credit Card Account: ' + Data.O['CreditCardPayment'].O['CCAccountRef'].S['name']);
            exit;
          end;
        end;
        if PayMethodId = 0 then begin
          result := false;
          DoError('ERP Payment Method not found for Quickbooks Payment Method "' + Data.S['PayType'] + '"');
          exit;
        end;

        RunningTotal := 0;
        { make sure we have all of the linked records .. }
        for I := 0 to Data.A['Line'].Count -1 do begin

          JsonLine := Data.A['Line'][I].AsObject;
          TxnType := JsonLine.A['LinkedTxn'][0].AsObject.S['TxnType'];
          { Quickbooks TxnType can be Bill,VendorCredit or JournalEntry }
          if not (SameText(TxnType,'Bill') or SameText(TxnType,'VendorCredit')) then begin
            result := false;
            DoError('Quickbooks Payment Line is Linked to unsupported type: ' + TxnType);
            exit;
          end;
          if SameText(TxnType,'VendorCredit') then begin
            { Vendor Credits are created by negative PO's from ERP }

            Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, 'PurchaseOrder', JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']);
            if Id > 0 then begin
              obj := JO;
              obj.S['TransType'] := 'PurchaseOrder';
              obj.I['ErpId'] := Id;
              obj.S['ExternalId'] := JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId'];
              obj.F['Amount'] := JsonLine.F['Amount'] * -1;  // Vendor credit value is positive
              obj.F['TotalBalance'] := TPurchaseOrder.TransTotalBalance(Id);
              RunningTotal := RunningTotal + obj.F['Amount'];
//              if UpdatePO(TotalBalance) then begin
//
//              end
//              else
//                exit;
              PaymentList.Add(obj);
            end
            else begin
              result := false;
              s := 'Could not find Purchase Order Linked to Quickbooks Vendor Credit for Id: ' +
                JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId'];
              DoError(s + '.');
              exit;
            end;
            Continue;
          end;

          Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, TxnType, JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']);
          if Id > 0 then begin
            { a bill we allready have in erp }
            obj := JO;
            obj.S['TransType'] := 'Bill';
            obj.I['ErpId'] := Id;
            obj.S['ExternalId'] := JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId'];
            obj.F['Amount'] := JsonLine.F['Amount'];
            RunningTotal := RunningTotal + obj.F['Amount'];
            obj.F['TotalBalance'] := TPurchaseOrder.TransTotalBalance(Id);
            PaymentList.Add(obj);
          end
          else begin
            { could be a Bill created from PO's in Quickbooks }

            if CoreService.GetObject('Bill', JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId']) then begin
//              POCount := 0;
              BillJson.Assign(CoreService.ResultData.O['Data']);

              if GetPOsLinketToQuickbooksBill(BillJson.S['Id'], JsonLine.F['Amount']{ BillJson.F['TotalAmt']}, PaymentList, RunningTotal, msg) then begin

              end
              else begin
                DoError(msg);
                exit;
              end;


//              for LinkedTxnIdx := 0 to BillJson.A['LinkedTxn'].Count - 1 do begin
//                LinkedRef := BillJson.A['LinkedTxn'][LinkedTxnIdx].AsObject;
//                if SameText(LinkedRef.S['TxnType'],'PurchaseOrder') then begin
//                  { do we have the PO in ERP? .. }
//                  Id := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName, 'PurchaseOrder', LinkedRef.S['TxnId']);
//                  if Id = 0 then begin
//                    result := false;
//                    s := 'Could not find Purchase Order or Quickbooks Purchase Order not Synched to ERP for Quickbooks PO Id: ' + LinkedRef.S['TxnId'];
//                    DoError(s + '.');
//                    exit;
//                  end;
//
//                  Inc(POCount);
//                  obj := JO;
//                  obj.S['TransType'] := 'PurchaseOrder';
//                  obj.I['ErpId'] := Id;
//                  obj.S['ExternalId'] := LinkedRef.S['TxnId'];
//                  if UpdatePO(TotalBalance) then begin
////                    if (RunningTotal + TotalBalance) <= JsonLine.F['Amount'] then begin
////                      obj.F['Amount'] := TotalBalance;
////                      RunningTotal := RunningTotal + obj.F['Amount'];
////                    end
////                    else begin
////                      obj.F['Amount'] := obj.F['Amount'] - RunningTotal;
////                      RunningTotal := RunningTotal + obj.F['Amount'];
////                    end;
//                  end
//                  else
//                    exit;
//                  PaymentList.Add(obj);
//                end
//                else if SameText(LinkedRef.S['TxnType'],'Bill') then begin
//
//
//                end;
//              end;
//              if POCount = 0 then begin
//                { error .. no linked po's found }
//                result := false;
//                s := 'Payment contains linked Bill that is not linked to any Purchase Orders (Bill Id: ' + LinkedRef.S['TxnId'] + ').';
//                DoError(s);
//                exit;
//              end;
            end
            else begin
              result := false;
              s := 'Could not read Bill from Quickbooks for Id: ' + JsonLine.A['LinkedTxn'][0].AsObject.S['TxnId'];
              if CoreService.ResultData.S['UserMessage'] <> '' then
                s := s + ' ' + CoreService.ResultData.S['UserMessage'];
              DoError(s + '.');
              exit;
            end;
          end;
        end;
        if Data.F['TotalAmt'] <> RunningTotal then begin
          s := 'Total of Quickbooks Bill Payment does not equal running total of linked transactions';
          DoError(s);
          exit;
        end;

        { all good, now supplier payment }
        if TExternalXRef.IsStarted(CoreService.ServiceName,'BillPayment', Data.S['Id'], 0) then begin
          { does it exist in ERP .. }
          qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
          try
            qry.SQL.Add('select * from tblwithdrawal');
            qry.SQL.Add('where Supplier = "T" and Deleted = "F"');
            qry.SQL.Add('and SupplierId = ' + IntToStr(SupplierId));
            qry.SQL.Add('and PayMethodId = ' + IntToStr(PayMethodId));
            qry.SQL.Add('and AccountId = ' + IntToStr(AccountId));
            qry.SQL.Add('and ReferenceNo = ' + QuotedStr(Data.S['DocNumber']));
            qry.SQL.Add('and Amount = ' + FloatToStr(Data.F['TotalAmt']));
            qry.Open;
            if not qry.IsEmpty then begin
              { just complete then exit .. }
              if not TExternalXRef.Complete(CoreService.ServiceName, 'BillPayment',qry.FieldByName('PaymentID').AsInteger, Data.S['Id'], msg, RFC3339StrToDateTimeUTC(Data.O['MetaData'].S['CreateTime'])) then begin
                result := false;
                DoError(msg);
              end;
              exit;
            end;
          finally
            DbSharedObj.ReleaseObj(qry);
          end;
        end;
        { else .. do it }
        if not TExternalXRef.StartNew(CoreService.ServiceName, 'BillPayment', Data.S['Id'], msg) then begin
          result := false;
          DoError(msg);
          exit;
        end;
        for I := 0 to PaymentList.Count -1 do begin
          obj := PaymentList[I].AsObject;
          if SameText(obj.S['TransType'], 'PurchaseOrder') then begin
            if not UpdatePO(obj.I['ErpId']) then
              exit;
          end;
        end;

        SuppPayment := TSupplierPayments.CreateWithNewConn(nil);
        try
          SuppPayment.SilentMode := true;
          SuppPayment.Connection.BeginTransaction;
          try
//            for I := 0 to PaymentList.Count -1 do begin
//              //JsonLine := Data.A['Line'][I].AsObject;
//              obj := PaymentList[I].AsObject;
//              if SameText(obj.S['TransType'], 'PurchaseOrder') then begin
//                if not UpdatePO(obj.I['ErpId'], SuppPayment.Connection) then
//                  exit;
//              end;
//            end;
            SuppPayment.New;
            SuppPayment.PaymentDate := Data.DT['TxnDate'];
            SuppPayment.EmployeeId := AppEnv.Employee.EmployeeID;
            SuppPayment.AccountId := AccountId;
            SuppPayment.ClientId := SupplierId;
            SuppPayment.PayMethodId := PayMethodId;
            SuppPayment.ForeignExchangeCode := Data.O['CurrencyRef'].S['value'];
            SuppPayment.ReferenceNo := Data.S['DocNumber'];
            SuppPayment.Amount := Data.F['TotalAmt'];

            for I := 0 to PaymentList.Count -1 do begin
              //JsonLine := Data.A['Line'][I].AsObject;
              obj := PaymentList[I].AsObject;

              SuppPayment.GUILines.First;
              TransFound := false;
              while not SuppPayment.GUILines.EOF do begin
                if ((SameText(obj.S['TransType'], 'Bill') and SameText(SuppPayment.GUILines.TransType, tcConst.BillType)) or
                    (SameText(obj.S['TransType'], 'PurchaseOrder') and SameText(SuppPayment.GUILines.TransType, tcConst.POType))) and
                   (SuppPayment.GUILines.TransID = obj.I['ErpId']) then begin
                  TransFound := true;
                  if SuppPayment.GUILines.AmountOutStanding < obj.F['Amount'] then begin
                    result := false;
                    DoError('Outstanding amount '+FloatToStr(SuppPayment.GUILines.AmountOutStanding)+' in ERP is less than payment amount ' +
                       FloatToStr(obj.F['Amount']) + ' from Quickbooks '+TxnType+' for ERP Customer ' + SuppPayment.client.PrintName);
                    exit;
                  end;
                  SuppPayment.GUILines.Applied := true;
                  SuppPayment.GUILines.Payment := obj.F['Amount'];
                  break;
                end;
                SuppPayment.GUILines.Next;
              end;
              if not TransFound then begin
                result := false;
                DoError('Could not find oustanding Quickbooks transaction ' + TxnType +
                  ' for ERP Supplier ' + SuppPayment.client.PrintName + ' ERP ID: ' + IntToStr(Obj.I['ErpId']));
                exit;
              end;
            end;

            if SuppPayment.Save then begin
              SuppPayment.Connection.CommitTransaction;
              DoProgress('Created new Supplier Payment for: ' + SuppPayment.client.PrintName);
              if not TExternalXRef.Complete(CoreService.ServiceName, 'BillPayment',SuppPayment.ID, Data.S['Id'], msg, RFC3339StrToDateTimeUTC(Data.O['MetaData'].S['CreateTime'])) then begin
                result := false;
                DoError(msg);
              end;
            end
            else begin
              result := false;
              SuppPayment.Connection.RollbackTransaction;
              DoError(SuppPayment.ResultStatus.Messages);
            end;
          except
            on e: exception do begin
              SuppPayment.Connection.RollbackTransaction;
              raise;
            end;
          end;
        finally
          SuppPayment.Free;
        end;
      end;
    finally
      PaymentList.Free;
      BillJson.Free;
    end;
  except
    on e: exception do begin
      result := false;
      DoError(e.Message);
    end;
  end;
end;

//function TErpSynch.CheckCustomer(aCustomerId: integer; aCustomerName: string;
//  var aExternalID: string): boolean;
//var
//  Done: boolean;
//  ExtID: string;
//  AddToExternal: boolean;
//  Cust: TCustomer;
//  json: TJsonObject;
//begin
//  result := true;
//  AddToExternal := false;
//  try
//    if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Customer, aCustomerID, ExtID, Done) then begin
//      if ExtID <> '' then begin
//        if Done then begin
//          aExternalID := ExtID;
//          exit;
//        end
//        else begin
//          { incomplete .. }
//          { is it in external system ? }
//          if CoreService.IdForName('Customer',aCustomerName) then begin
//            if CoreService.ResultData.S['Id'] <> '' then begin
//              aExternalID := CoreService.ResultData.S['Id'];
//              TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Customer, aCustomerID, aExternalID);
//              exit;
//            end
//            else begin
//              { started in XRef table bit not in external system }
//              AddToExternal := true;
//            end;
//          end
//          else begin
//            result := false;
//            fUserMessage := CoreService.ResultData.S[Name_UserMessage];
//            fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
//            fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
//            exit;
//          end;
//
//        end;
//      end;
//    end
//    else begin
//      { not in external system .. }
//      { flag as started .. }
//      TExternalXRef.StartNew(CoreService.ServiceName, ExRef_Objtype_Customer, aCustomerID);
//      AddToExternal := true;
//    end;
//
//    if AddToExternal then begin
//      { add the customer }
//      Cust := TCustomer.CreateWithSharedConn(nil);
//      try
//        Cust.Load(aCustomerId, true);
//        json := Serialise(Cust);
//        try
//          if CoreService.AddERPObject(json) then begin
//            aExternalID := CoreService.ResultData.S['Id'];
//            TExternalXRef.Complete(CoreService.ServiceName, ExRef_Objtype_Customer, aCustomerID, aExternalID);
//            exit;
//          end
//          else begin
//            result := false;
//            fUserMessage := CoreService.ResultData.S[Name_UserMessage];
//            fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
//            fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
//            exit;
//          end;
//        finally
//          json.Free;
//        end;
//
//      finally
//        Cust.Free;
//      end;
//    end;
//
//  except
//    on e: exception do begin
//      result := false;
//      fReturnCode := Return_Code_Error;
//      fUserMessage := e.Message;
//    end;
//  end;
//end;

function TErpSynch.CheckPONegative(const POId: integer; var PositiveLineCount: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select');
    qry.SQL.Add('(SELECT COUNT(*) FROM tblpurchaselines');
    qry.SQL.Add('WHERE PurchaseOrderID = :POId and ((UnitOfMeasureQtySold * LineCostInc < 0))) AS NegativeLines,');
    qry.SQL.Add('(SELECT COUNT(*) FROM tblpurchaselines');
    qry.SQL.Add('WHERE PurchaseOrderID = :POId and ((UnitOfMeasureQtySold * LineCostInc > 0))) AS PositiveLines');
    qry.SQL.Add('FROM dual');
    qry.ParamByName('POId').AsInteger := POId;
    qry.Open;
    result := qry.FieldByName('NegativeLines').AsInteger > 0;
    PositiveLineCount := qry.FieldByName('PositiveLines').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

constructor TErpSynch.Create;
begin
  fAccountMustExistInRemote := true;
  fTaxCodeMustExistInRemote := true;
  fTermsMustExistInRemote := true;
  fTaxRateMustExistInRemote := true;
end;

procedure TErpSynch.Delay(secs: integer);
var
  dt: TDateTime;
begin
  dt := now + (OneSecond * secs);
  while now <= dt do begin
    Sleep(50);
    Application.ProcessMessages;
  end;
end;

destructor TErpSynch.Destroy;
begin

  inherited;
end;

//procedure TErpSynch.DoError;
//begin
//  if (fReturnCode = '') and (CoreService.ResultData.S['ReturnCode'] <> '') then
//    fReturnCode := CoreService.ResultData.S['ReturnCode'];
//  if (fUserMessage = '') and (CoreService.ResultData.S['UserMessage'] <> '') then
//    fUserMessage := CoreService.ResultData.S['UserMessage'];
//  fAPIMessage := CoreService.ResultData.S['APIMessage'];
//  if Assigned(fOnSynchError) then
//    fOnSynchError(self);
//end;

//procedure TErpSynch.DoError(const aUserMessage, aReturnCode, aAPIMessage: string);
//begin
//  fUserMessage := aUserMessage;
//  fReturnCode := aReturnCode;
//  fAPIMessage := aAPIMessage;
//  DoError;
//end;

//procedure TErpSynch.DoProgress(const msg: string);
//begin
//  if Assigned(fOnSynchProgress) then begin
//    if not Active then begin
//      ContinueSynch := false;
//      exit;
//    end;
//    fOnSynchProgress(self, ContinueSynch, msg);
//    if not ContinueSynch then begin
//      fReturnCode := 'Terminated';
//    end;
//  end;
//end;

procedure TErpSynch.DoSynchBill(aId, aRecNo, aRecCount: integer);
var
  IdStr: string;
begin
  Application.ProcessMessages;
  fCurrentSynchId := aId;
  fCurrentSynchItemNo := aRecNo;
  fTotalItemsToSynch := aRecCount;
  fCurrentSynchItemType := SynchItemType_Bill;
  ContinueSynch := true;
  DoProgress;
  if not ContinueSynch then
    exit;
  if not SynchBill(aId, IdStr, nil) then begin
    DoError;
    exit;
  end;
end;

procedure TErpSynch.DoSynchInvoice(aId, aRecNo, aRecCount: integer);
var
  IdStr: string;
begin
  Application.ProcessMessages;
  fCurrentSynchId := aId;
  fCurrentSynchItemNo := aRecNo;
  fTotalItemsToSynch := aRecCount;
  fCurrentSynchItemType := SynchItemType_Invoice;
  ContinueSynch := true;
  DoProgress;
  if not ContinueSynch then
    exit;
  if not SynchInvoice(aId, IdStr, nil) then begin
    DoError;
    exit;
  end;
end;

procedure TErpSynch.DoSynchPurchaseOrder(aId, aRecNo, aRecCount: integer);
var
  IdStr: string;
begin
  Application.ProcessMessages;
  fCurrentSynchId := aId;
  fCurrentSynchItemNo := aRecNo;
  fTotalItemsToSynch := aRecCount;
  fCurrentSynchItemType := SynchItemType_PurchaseOrder;
  ContinueSynch := true;
  DoProgress;
  if not ContinueSynch then
    exit;
  if not SynchPurchaseOrder(aId, IdStr, nil) then begin
    DoError;
    exit;
  end;
end;

function TErpSynch.DtToStr(aDt: TDateTime): string;
begin
  result := FormatDateTime('yyyy-mm-dd"T"hh:mm:ss', aDt) + 'Z'; //   TimezoneToStr;
end;

function TErpSynch.GetConnection: TERPConnection;
begin
  if Assigned(fConnection) then
    Result := fConnection
  else
    result := AppEnv.AppDb.Connection;
end;

procedure TErpSynch.GetCustomersFromRemote;
var
  query: string;
  MaxResults, StartPosition: integer;
  QueryResponse, json: TJsonObject;
  I: integer;
begin
  try
    fCurrentSynchItemType := 'Customer';
    if SameTExt(CoreService.ServiceName, 'Quickbooks') then begin
      { get list of all customers in Quickbooks and check we have them in ERP .. }

      StartPosition := 1;
      MaxResults := 50;
      query := 'select Id, Active, DisplayName from Customer MaxResults ' + IntToStr(MaxResults);
      QueryResponse := JO;
      try

        while True do begin
          if CoreService.GetData(query + ' StartPosition ' + IntToStr(StartPosition)) then begin
            QueryResponse.Assign(CoreService.ResultData.O['Data']);
            if QueryResponse.A['Customer'].Count > 0 then begin
              fTotalItemsToSynch := StartPosition - 1 + QueryResponse.A['Customer'].Count;
              for I := 0 to QueryResponse.A['Customer'].Count -1 do begin

                json := QueryResponse.A['Customer'][I].AsObject;
                Application.ProcessMessages;
                fCurrentSynchId := 0;
                fCurrentSynchItemNo := I + 1;
                ContinueSynch := true;
                DoProgress;
                if not ContinueSynch then
                  exit;
                if json.B['Active'] then begin
                  { process this customer .. }
                  if not AddCustomerToERP(json.S['Id']) then begin
                    // exit;
                  end;

                end;
              end;
            end
            else begin
              { nothing in list }
              exit;
            end;
          end
          else begin
            { Get data failed }
            exit;
          end;
          if QueryResponse.A['Customer'].Count < MaxResults then begin
            { no more data }
            exit;
          end;
          StartPosition := StartPosition + MaxResults;
        end;
      finally
        QueryResponse.Free;
      end;

    end;
  except
    on e: exception do begin
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.GetPOsLinketToQuickbooksBill(BillId: string; BillAmount: double;
 TransList: TJsonArray; var RunningBalance: double; var msg: string): boolean;
var
  qry: TERPQuery;
  continue: boolean;
  I: Integer;
  LocalRunningBalance: double;
  POJson, LinkedRef, Obj: TJsonObject;
  POCount: integer;
begin
  result := true;
  LocalRunningBalance := 0;
  POCount := 0;
  { get a list of unpaid PO's that have been set to quickbooks }
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  POJson := JO;
  try
    qry.SQL.Add('SELECT xref.* FROM tblexternalxref xref');
    qry.SQL.Add('INNER JOIN tblpurchaseorders po ON xref.ExternalType = "Quickbooks" AND xref.ObjectType = "PurchaseOrder"');
    qry.SQL.Add('AND xref.SynchState = "Done" AND IFNULL(xref.ExternalID,"") <> ""');
    qry.SQL.Add('AND xref.ERPID = PO.PurchaseOrderID AND PO.Paid = "F" and PO.TotalAmountInc >= 0');
    qry.Open;
    while not qry.Eof do begin
      { first make sure we have not already used this PO .. }
      continue := true;
      for I := 0 to TransList.Count -1 do begin
        if SameText(TransList[I].AsObject.S['TransType'], 'PurchaseOrder') then begin
          if TransList[I].AsObject.I['ErpId'] = qry.FieldByName('ERPID').AsInteger then begin
            continue := false;
            break
          end;
        end;
      end;
      if continue then begin
        if CoreService.GetObject('PurchaseOrder', qry.FieldByName('ExternalID').AsString) then begin
          POJson.Assign(CoreService.ResultData.O['Data']);
          if (POJson.A['LinkedTxn'].Count > 0) then begin
            LinkedRef := POJson.A['LinkedTxn'][0].AsObject;
            if SameText(LinkedRef.S['TxnType'],'Bill') and SameText(LinkedRef.S['TxnId'],BillId) then begin
              Inc(POCount);
              obj := JO;
              obj.S['TransType'] := 'PurchaseOrder';
              obj.I['ErpId'] := qry.FieldByName('ERPID').AsInteger;
              obj.S['ExternalId'] := qry.FieldByName('ExternalID').AsString;
              if BillAmount < POJson.F['TotalAmt'] then
                obj.F['Amount'] := BillAmount
              else
                obj.F['Amount'] := POJson.F['TotalAmt'];
              obj.F['TotalBalance'] := TPurchaseOrder.TransTotalBalance(qry.FieldByName('ERPID').AsInteger);
              TransList.Add(obj);
              LocalRunningBalance := LocalRunningBalance + obj.F['Amount'];
              if LocalRunningBalance = BillAmount then
                Break;  { we are done }
            end;
          end;
        end
        else begin
          { cant get data from quickbooks }
          result := false;
          msg := 'Could not read Purchase Order from Quickbooks for Id: ' + qry.FieldByName('ExternalID').AsString;
          if CoreService.ResultData.S['UserMessage'] <> '' then
            msg := msg + ' ' + CoreService.ResultData.S['UserMessage'];
          exit;
        end;
      end;
      qry.Next;
    end;
    if LocalRunningBalance <> BillAmount then begin
      result := false;
      if POCount = 0 then
        msg := 'Could not find any Purchase Orders linked to Quickbooks Bill Id: ' + BillID
      else
        msg := 'Found ' + IntToStr(POCount) + ' Purchase Orders totaling ' +
          FloatToStrF(LocalRunningBalance, FfCurrency, 15, CurrencyRoundPlaces) +
          ' which does not match Bill Amount of ' +
          FloatToStrF(BillAmount, FfCurrency, 15, CurrencyRoundPlaces);
    end
    else
      RunningBalance := RunningBalance + LocalRunningBalance;
  finally
    DbSharedObj.ReleaseObj(qry);
    POJson.Free;
  end;
end;

procedure TErpSynch.GetRefundSalesFromRemote;
var
  query: string;
  MaxResults, StartPosition: integer;
  QueryResponse, json: TJsonObject;
  I: integer;
begin
  try
    fCurrentSynchItemType := 'RefundSale';
    if SameTExt(CoreService.ServiceName, 'Quickbooks') then begin
      { get list of all RefundSales (Credit Memo) in Quickbooks and check we have them in ERP .. }

      StartPosition := 1;
      MaxResults := 50;
      query := 'select Id from CreditMemo MaxResults ' + IntToStr(MaxResults);
      QueryResponse := JO;
      try

        while True do begin
          if CoreService.GetData(query + ' StartPosition ' + IntToStr(StartPosition)) then begin
            QueryResponse.Assign(CoreService.ResultData.O['Data']);
            if QueryResponse.A['CreditMemo'].Count > 0 then begin
              fTotalItemsToSynch := StartPosition - 1 + QueryResponse.A['CreditMemo'].Count;
              for I := 0 to QueryResponse.A['CreditMemo'].Count -1 do begin

                json := QueryResponse.A['CreditMemo'][I].AsObject;
                Application.ProcessMessages;
                fCurrentSynchId := 0;
                fCurrentSynchItemNo := I + 1;
                ContinueSynch := true;
                DoProgress;
                if not ContinueSynch then
                  exit;
                { process this RefundSale .. }
                if not AddRefundSaleToERP(json.S['Id']) then begin
                  // exit;
                end;

              end;
            end
            else begin
              { nothing in list }
              exit;
            end;
          end
          else begin
            { Get data failed }
            exit;
          end;
          if QueryResponse.A['Vendor'].Count < MaxResults then begin
            { no more data }
            exit;
          end;
          StartPosition := StartPosition + MaxResults;
        end;
      finally
        QueryResponse.Free;
      end;

    end;
  except
    on e: exception do begin
      DoError(e.Message);
    end;
  end;
end;

procedure TErpSynch.GetSuppliersFromRemote;
var
  query: string;
  MaxResults, StartPosition: integer;
  QueryResponse, json: TJsonObject;
  I: integer;
begin
  try
    fCurrentSynchItemType := 'Supplier';
    if SameTExt(CoreService.ServiceName, 'Quickbooks') then begin
      { get list of all suppliers (vendors) in Quickbooks and check we have them in ERP .. }

      StartPosition := 1;
      MaxResults := 50;
      query := 'select Id, Active, DisplayName from Vendor MaxResults ' + IntToStr(MaxResults);
      QueryResponse := JO;
      try

        while True do begin
          if CoreService.GetData(query + ' StartPosition ' + IntToStr(StartPosition)) then begin
            QueryResponse.Assign(CoreService.ResultData.O['Data']);
            if QueryResponse.A['Vendor'].Count > 0 then begin
              fTotalItemsToSynch := StartPosition - 1 + QueryResponse.A['Vendor'].Count;
              for I := 0 to QueryResponse.A['Vendor'].Count -1 do begin

                json := QueryResponse.A['Vendor'][I].AsObject;
                Application.ProcessMessages;
                fCurrentSynchId := 0;
                fCurrentSynchItemNo := I + 1;
                ContinueSynch := true;
                DoProgress;
                if not ContinueSynch then
                  exit;
                if json.B['Active'] then begin
                  { process this supplier .. }
                  if not AddSupplierToERP(json.S['Id']) then begin
                    // exit;
                  end;

                end;
              end;
            end
            else begin
              { nothing in list }
              exit;
            end;
          end
          else begin
            { Get data failed }
            exit;
          end;
          if QueryResponse.A['Vendor'].Count < MaxResults then begin
            { no more data }
            exit;
          end;
          StartPosition := StartPosition + MaxResults;
        end;
      finally
        QueryResponse.Free;
      end;

    end;
  except
    on e: exception do begin
      DoError(e.Message);
    end;
  end;
end;

//procedure TErpSynch.Log(const msg, aType: string);
//begin
//  if Assigned(fOnLog) then
//    fOnLog(msg, aType)
//end;

function TErpSynch.Serialise(obj: TObject): TJsonObject;
var
  JSONSerialiser: TJSONSerialiser;
begin
  JSONSerialiser := TJSONSerialiser.Create;
  try
    result := JSONSerialiser.SerialiseObject(obj);
  finally
    JSONSerialiser.Free;
  end;
end;

function TErpSynch.SynchCustomer(Cust: TClient; var Id: string; Params: TJsonObject = nil): boolean;
var
  CustJson: TJsonObject;
  ParentID: string;
//  XRefDone: boolean;
//  dt: TDateTime;
  msg: string;
begin
  ParentID := '';
  if Cust is TJob then begin
    result := SynchCustomer(TJob(Cust).ParentClientId, ParentID, nil);
    if not result then
      exit;
    if ParentId = '' then
      raise Exception.Create('Parent client not found for job ' + TJob(Cust).ClientName);
//    TExternXRef.GetExternalRef(CoreService.ServiceName,ExRef_Objtype_Customer,TJob(Cust).ParentClientId, ParentID, XRefDone)
  end;

  CustJson := Serialise(Cust);
  try
    if ParentID <> '' then
      CustJson.O['Data'].S['ParentID'] := ParentID;
    result := AddERPObject(CustJson);
    if result then begin
      Id := CoreService.ResultData.S['Id'];
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Customer,Cust.ID,Id, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['CustomerId'] := Id;

//     { check in remote system .. and wait if not there yet }
//      dt := now + (OneSecond * 60);
//      while now <= dt do begin
//        Delay(2);
//        if CoreService.GetObject('Customer', Id) then begin
//          break;
//        end;
//        Delay(2);
//      end;

    end
    else begin
      result := false;
      fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
      fUserMessage := CoreService.ResultData.S[Name_UserMessage];
      fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
    end;
  finally
    CustJson.Free;
  end;
end;

function TErpSynch.SynchAccount(Account: TAccount; var Id: string;
  Params: TJsonObject): boolean;
var
  Json: TJsonObject;
//  XRefDone: boolean;
  ParentID, TaxCodeID: string;
  ERPParentID: integer;
  Data: TJsonObject;
  msg: string;
begin
  Data := nil;
  try
    if Assigned(Params) and Params.ObjectExists('Data') then begin
      Data := JO;
      Data.Assign(Params.O['Data']);
    end;
    if not SameText(Account.Level1, Account.AccountName) then begin
      { is a sub account }
      ERPParentID := 0;
      if (Account.Level3 <> '') and (not SameText(Account.Level3, Account.AccountName)) then
        ERPParentID := TAccount.IDToggle(Account.Level3)
      else if (Account.Level2 <> '') and (not SameText(Account.Level2, Account.AccountName)) then
        ERPParentID := TAccount.IDToggle(Account.Level2)
      else if (Account.Level1 <> '') and (not SameText(Account.Level1, Account.AccountName)) then
        ERPParentID := TAccount.IDToggle(Account.Level1);
      result := self.SynchAccount(ERPParentID,ParentID);
      if not result then exit;
      if not Assigned(Data) then Data := JO;
      Data.S['ParentID'] := ParentID;
    end;

    if Account.TaxCode <> '' then begin
      result := SynchTaxCode(TTaxCode.IDToggle(Account.TaxCode), TaxCodeID);
      if not result then exit;
      if not Assigned(Data) then Data := JO;
      Data.S['TaxCodeID'] := TaxCodeID;
    end;

    Json := Serialise(Account);
    try
      if Assigned(Data) then
        Json.O['Data'].Assign(Data);
      result := AddERPObject(Json);
      if result then begin
        Id := CoreService.ResultData.S['Id'];
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Account, Account.ID, Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['AccountId'] := Id;
      end
      else begin
        result := false;
        fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
        fUserMessage := CoreService.ResultData.S[Name_UserMessage];
        fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
      end;
    finally
      Json.Free;
    end;
  finally
    Data.Free;
  end;
end;

function TErpSynch.SynchAccount(AccountId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  Account: TAccount;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
  if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Account, AccountID, Id, XRefDone) then begin
    if Id <> '' then begin
      if XRefDone then begin
        if Assigned(Params) then
          Params.S['AccountId'] := Id;
        exit;
      end
      else begin
        { not done }
        { else continue below }
      end;
    end
    else begin
      { does it exist in external system }
      if Assigned(Params) then
        result := CoreService.IdForName('Account',TAccount.IDToggle(AccountID), Params)
      else
        result := CoreService.IdForName('Account',TAccount.IDToggle(AccountID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Account, AccountId, Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['TaxCodeId'] := Id;
        exit;
      end;
    end;
  end
  else begin
    if AccountMustExistInRemote then begin
      result := false;
      fUserMessage := 'Account (' + TAccount.IDToggle(AccountID) + ') not linked to ' + CoreService.ServiceName;
      exit;
    end;
    { flag as started .. }
    if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Account, AccountId, msg) then begin
      result := false;
      fUserMessage := msg;
      exit;
    end;
  end;

  { needs to be sent to external system .. }
  Account := TAccount.CreateWithSharedConn(nil);
  try

    Account.Load(AccountId, true);
    result := SynchAccount(Account, Id, Params);
  finally
    Account.Free;
  end;
end;

function TErpSynch.SynchBill(Bill: TBill; var Id: string;
  Params: TJsonObject): boolean;
var
  Data, Obj: TJsonObject;
  BillJson: TJsonObject;
  SupplierID, TermsID, APAccountID, SubID: string;
  msg: string;
begin
  Data := JO;
  try
    result := SynchSupplier(Bill.SupplierId, SupplierID);
    if not result then
      exit;
    Data.S['SupplierId'] := SupplierId;

    if Bill.TermsName <> '' then begin
      result := SynchTerms(Bill.Terms.ID, TermsId);
      if not result then
        exit;
      Data.S['TermsId'] := TermsID;
    end;

    result := SynchAccount(Bill.GLAccountId, APAccountID);
    if not result then
      exit;
    Data.S['APAccountID'] := APAccountID;

    if Bill.Supplier.Contractor then
      Data.B['ContractPayment'] := true;

    Bill.Lines.First;
    while not Bill.Lines.EOF do begin
      Obj := JO;
      { ProductId }
      SubID := '';
      result := self.SynchAccount(Bill.Lines.LineGLAccount.ID, SubID);
      if not result then exit;
      Obj.S['AccountId'] := SubID;

      if AppEnv.RegionalOptions.RegionType <> rUSA then begin

        {  LineTaxCode - TaxCode.ID  }
        if Bill.Lines.LineTaxCode <> '' then begin
          SubID := '';
          result := SynchTaxCode(Bill.Lines.TaxCode.ID, SubId);
          if not result then exit;
          Obj.S['TaxCodeID'] := SubID;
        end;

        Bill.Lines.PurchaseTaxCode.Lines.First;
        while not Bill.Lines.PurchaseTaxCode.Lines.EOF  do begin
          SubId:= '';
          result := SynchSubTaxCode(Bill.Lines.PurchaseTaxCode.Lines.SubTaxID,SubId);
          if not result then
            exit;
          Obj.A['SubTaxCodes'].Add(JO('{"SubTaxCodeId":"'+SubId+'"}'));
          Bill.Lines.PurchaseTaxCode.Lines.Next;
        end;
      end;

      Data.A['Lines'].Add(Obj);
      Bill.Lines.Next;
    end;

    BillJson := Serialise(Bill);
    try
      BillJson.O['Data'].Assign(Data);
      result := AddERPObject(BillJson);
      if result then begin
        Id := CoreService.ResultData.S['Id'];
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Bill,Bill.ID,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['BillId'] := Id;
      end
      else begin
        result := false;
        fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
        fUserMessage := CoreService.ResultData.S[Name_UserMessage];
        fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
      end;
    finally
      BillJson.Free;
    end;
  finally
    Data.Free;
  end;
end;

function TErpSynch.SynchBill(BillId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  Bill: TBill;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
  Bill := nil;
  try
    if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Bill, BillId, Id, XRefDone) then begin
      { found a record .. }
      if Id <> '' then begin
        if XRefDone then begin
          if Assigned(Params) then
            Params.S['InvoiceId'] := Id;
          exit;
        end
        else begin

        end;
      end
      else begin
        { started but not complete ... }
        { does it exist in external system }
        Bill := TBill.CreateWithSharedConn(nil);
        Bill.Load(BillId, true);
        { does it exist in external system }
        result := CoreService.IdForName('Bill', Bill.DocNumber);
        if not result then
          exit;
        Id := CoreService.ResultData.S['Id'];
        if Id <> '' then begin
          { yes .. so update }
          if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Bill, BillId,Id, msg) then begin
            result := false;
            fUserMessage := msg;
            exit;
          end;
          if Assigned(Params) then
            Params.S['BillId'] := Id;
          exit;
        end;
      end;
    end
    else begin
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Bill,BillId, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
    end;

  { needs to be sent to external system .. }
    if not Assigned(Bill) then
      Bill := TBill.CreateWithSharedConn(nil);
    Bill.Load(BillId, true);
    result := SynchBill(Bill, Id, Params);
  finally
    Bill.Free;
  end;
end;

function TErpSynch.SynchCustomer(CustId: Integer; var Id: string; Params: TJsonObject = nil): boolean;
var
  Cust: TClient;
  XRefDone: boolean;
  qry: TERPQuery;
  msg: string;
begin
  result := true;
  if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Customer, CustID, Id, XRefDone) then begin
    if Id <> '' then begin
      if XRefDone then begin
        if Assigned(Params) then
          Params.S['CustomerId'] := Id;
        exit;
      end
      else begin
        { not done }
        { else continue below }
      end;
    end
    else begin
      { does it exist in external system }
      result := CoreService.IdForName('Customer',TClient.IDToggle(CustID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Customer,CustId,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['CustomerId'] := Id;
        exit;
      end;
    end;
  end
  else begin
    { flag as started .. }
    if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Customer,CustId, msg) then begin
      result := false;
      fUserMessage := msg;
      exit;
    end;

    { does it exist in external system }
    result := CoreService.IdForName('Customer',TClient.IDToggle(CustID));
    if not result then
      exit;
    Id := CoreService.ResultData.S['Id'];
    if Id <> '' then begin
      { yes .. so update }
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Customer,CustId,Id, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['CustomerId'] := Id;
      exit;
    end;
  end;


  { needs to be sent to external system .. }
  Cust := nil;
  try
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Text := 'SELECT ClientId, IsJob FROM tblClients WHERE ClientID = ' +IntToStr(CustId);
      qry.Open;
      if qry.FieldByName('IsJob').AsBoolean  then
        Cust := TJob.CreateWithSharedConn(nil)
      else
        Cust := TCustomer.CreateWithSharedConn(nil)
    finally
      DbSharedObj.ReleaseObj(qry);
    end;

    Cust.Load(CustId, true);
    result := SynchCustomer(Cust, Id, Params);
  finally
    Cust.Free;
  end;
end;

procedure TErpSynch.SynchData(const aType: string);
var
  qry: TERPQuery;
  InvoicId: string;
  DatabaseName, DatabaseServer: string;
begin
  Active := true;
  fUserMessage := '';
  fAPIMessage := '';
  fReturnCode := '';
  fSynchType := aType;
  DatabaseName := CommonDbLib.GetSharedMyDacConnection.Database;
  DatabaseServer := CommonDbLib.GetSharedMyDacConnection.Server;
//  TThread.CreateAnonymousThread(
//    procedure()
//    begin

//      Connection := TERPConnection.Create(nil);
      qry := TERPQuery.Create(Nil);
      try
//        SetConnectionProps(Connection, DatabaseName, DatabaseServer);
//        Connection.Connect;
        qry.Connection := Connection;
        if SameText(aType, 'Invoice') then begin
          qry.SQL.Add('select Inv.SaleID as ObjID,');
          qry.SQL.Add('XRef.* from tblSales Inv');
          qry.SQL.Add('LEFT JOIN tblExternalXRef XRef');
          qry.SQL.Add('ON XRef.ExternalType = "'+CoreService.ServiceName+'"');
          qry.SQL.Add('AND XRef.ObjectType = "Invoice"');
          qry.SQL.Add('AND XRef.ERPID = Inv.SaleID');
          qry.SQL.Add('WHERE Inv.IsInvoice = "T"');
          qry.SQL.Add('AND Inv.Deleted = "F"');
          qry.SQL.Add('AND IfNull(XRef.SynchState,"") <> "Done"');
          qry.SQL.Add('AND (select SUM(SL.BackOrder) FROM tblSalesLines SL WHERE SL.SaleID = Inv.SaleID) = 0');
    //      BusObj := TInvoice.CreateWithSharedConn(nil);
        end;

        qry.Open;
        fTotalItemsToSynch := qry.RecordCount;
        while not qry.Eof do begin
          Application.ProcessMessages;
          fCurrentSynchId := qry.FieldByName('ObjID').AsInteger;
          fCurrentSynchItemNo := qry.RecNo;
          ContinueSynch := true;
//          TThread.Synchronize(TThread.CurrentThread, DoProgress);
          DoProgress;
          if not ContinueSynch then
            exit;

          fCurrentSynchItemType := aType;
          if SameText(aType, 'Invoice') then begin
            if not SynchInvoice(qry.FieldByName('ObjID').AsInteger, InvoicId, nil) then begin
//              TThread.Synchronize(TThread.CurrentThread, DoError);
              DoError;
              exit;
            end;
          end;

          qry.Next;
        end;

      finally
        FreeAndNil(qry);
        Active := false;
      end;
//      end
//    ).Start;

end;

function TErpSynch.SynchInvoice(InvId: integer; var Id: string; Params: TJsonObject): boolean;
var
  Inv: TInvoice;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
  Inv := nil;
  try
    if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Invoice, InvId, Id, XRefDone) then begin
      { found a record .. }
      if Id <> '' then begin
        if XRefDone then begin
          if Assigned(Params) then
            Params.S['InvoiceId'] := Id;
          exit;
        end
        else begin

        end;
      end
      else begin
        { started but not complete ... }
        { does it exist in external system }
        Inv := TInvoice.CreateWithSharedConn(nil);
        Inv.Load(InvId, true);
        { does it exist in external system }
        result := CoreService.IdForName('Invoice', Inv.DocNumber);
        if not result then
          exit;
        Id := CoreService.ResultData.S['Id'];
        if Id <> '' then begin
          { yes .. so update }
          if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Invoice, InvId,Id,msg) then begin
            result := false;
            fUserMessage := msg;
            exit;
          end;
          if Assigned(Params) then
            Params.S['InvoiceId'] := Id;
          exit;
        end;
      end;
    end
    else begin
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Invoice,InvId, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
    end;

  { needs to be sent to external system .. }
    if not Assigned(Inv) then
      Inv := TInvoice.CreateWithSharedConn(nil);
    Inv.Load(InvId, true);
    result := SynchInvoice(Inv, Id, Params);
  finally
    Inv.Free;
  end;
end;


function TErpSynch.SynchProduct(Product: TProduct; var Id: string;
  Params: TJsonObject): boolean;
var
  Json, OutParams, Data: TJsonObject;
  IdStr: string;
//  XRefDone: boolean;
  ChildID: string;
  msg: string;
begin
//  Log('SynchProduct (Product) - Start ' +  IntToStr(Product.ID) + ' ' + Product.ProductName, 'Detail');
  Data:= nil;
  try
    { Tax }
    OutParams := JO;
    try
      if AppEnv.RegionalOptions.RegionType <> rUSA then begin
        if Product.TaxCodeSales <> '' then begin
          OutParams.Clear;
          OutParams.B['IsSale'] := true;
          ChildId := '';
          result := SynchTaxCode(Product.TaxSales.ID, ChildID, OutParams);
          if not result then
            exit;
          if not Assigned(Data) then Data := JO;
          Data.S['SalesTaxCodeId'] := ChildID;
        end;
        if Product.TaxCodePurchase <> '' then begin
          OutParams.Clear;
          OutParams.B['IsPurchase'] := true;
          ChildId := '';
          result := SynchTaxCode(Product.TaxPurchase.ID, ChildId, OutParams);
          if not result then
            exit;
          if not Assigned(Data) then Data := JO;
          Data.S['PurchaseTaxCodeId'] := ChildId;
        end;
      end;

//      Log('SynchProduct (Product) - Checking accounts.', 'Detail');
      { Accounts }
      OutParams.Clear;
      OutParams.O['Data'].B['IsProduct'] := true;
      OutParams.O['Data'].B['IsInventoryProduct'] := SameText(Product.ProductType, 'INV');
      if Product.AssetAccount <> '' then begin
        ChildId := '';
        result := SynchAccount(TAccount.IDToggle(Product.AssetAccount), ChildID, OutParams);
        if not result then exit;
        if not Assigned(Data) then Data := JO;
        Data.S['AssetAccountId'] := ChildId;
      end;
      if Product.COGSAccount <> '' then begin
        ChildId := '';
        result := SynchAccount(TAccount.IDToggle(Product.COGSAccount), ChildID, OutParams);
        if not result then exit;
        if not Assigned(Data) then Data := JO;
        Data.S['COGSAccountId'] := ChildId;
      end;
      if Product.IncomeAccount <> '' then begin
        ChildId := '';
        result := SynchAccount(TAccount.IDToggle(Product.IncomeAccount), ChildID, OutParams);
        if not result then exit;
        if not Assigned(Data) then Data := JO;
        Data.S['IncomeAccountId'] := ChildId;
      end;

    finally
      OutParams.Free;
    end;

//    Log('SynchProduct (Product) - Checking Prefered Supplier.', 'Detail');
    { prefered supplier }
    if Product.PreferedSupplierName <> '' then begin
      ChildId := '';
      result := SynchSupplier(Product.PreferedSupplier.ID, ChildID);
      if not result then exit;
      if not Assigned(Data) then Data := JO;
      Data.S['PreferedSupplierId'] := ChildId;
    end;

    Json := Serialise(Product);
    try
      if Assigned(Data) then
        Json.O['Data'].Assign(Data);
//      Log('SynchProduct (Product) - Adding Product to Quickbooks.', 'Detail');
      result := AddERPObject(Json);
      if result then begin
        Id := CoreService.ResultData.S['Id'];
//        Log('SynchProduct (Product) - Completing in XRefTable.', 'Detail');
        if TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Product, Product.ID, IdStr, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['ProductId'] := IdStr;
      end
      else begin
        result := false;
        fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
        fUserMessage := CoreService.ResultData.S[Name_UserMessage];
        fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
      end;
    finally
      Json.Free;
    end;
  finally
    Data.Free;
//  Log('SynchProduct (Product) - Finished ' +  IntToStr(Product.ID) + ' ' + Product.ProductName, 'Detail');
  end;
end;

procedure TErpSynch.SynchPaymentsFromRemote;
var
  query: string;
  qry: TERPQuery;
  I: integer;
  json, QueryResponse: TJsonObject;
  fType: string;
  dt: TDateTime;
begin
  try
    fCurrentSynchItemType := SynchItemType_Payment;
    if SameTExt(CoreService.ServiceName, 'Quickbooks') then begin
      qry := TERPQuery.Create(nil);
      QueryResponse := JO;
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        { first complete any started payments ..  }
        qry.SQL.Add('select * from tblExternalXRef');
        qry.SQL.Add('where ExternalType = ' + QuotedStr(CoreService.ServiceName));
        qry.SQL.Add('and ((ObjectType = "Payment") or (ObjectType = "BillPayment"))');
        qry.SQL.Add('and SynchState = "Started"');
        qry.Open;
        fTotalItemsToSynch := qry.RecordCount;
        while not qry.Eof do begin
          fType := qry.FieldByName('ObjectType').AsString;
          fCurrentSynchItemType := fType;
          query := 'select * from '+fType+' Where Id = ' + '''' + qry.FieldByName('ExternalId').AsString + '''';
          if CoreService.GetData(query) then begin
            QueryResponse.Assign(CoreService.ResultData.O['Data']);
            if QueryResponse.A[fType].Count > 0 then begin
              json := QueryResponse.A[fType][0].AsObject;
              Application.ProcessMessages;
              fCurrentSynchId := 0;
              fCurrentSynchItemNo := qry.RecNo;
              ContinueSynch := true;
              DoProgress;
              if not ContinueSynch then
                exit;
              if SameText(fType,'Payment') then
                AddCustPaymentToERP(json)
              else
                AddSuppPaymentToERP(json);
            end;
          end;

          qry.Next;
        end;
        qry.Close;

        { now check for new payments .. }
        query := 'select * from Payment';
        qry.SQL.Clear;
        qry.SQL.Add('select Convert(Max(IfNull(ExternalTimeStamp,0)), DateTime) as ExternalTimeStamp from tblExternalXRef');
        qry.SQL.Add('where ExternalType = "Quickbooks" and ObjectType = "Payment"');
//        qry.SQL.Add('and not IsNull(ExternalTimeStamp)');
        qry.Open;
        dt := 0;
        if qry.FieldByName('ExternalTimeStamp').AsDateTime > 0 then
          dt := qry.FieldByName('ExternalTimeStamp').AsDateTime;
//          query := query + ' where Metadata.LastUpdatedTime >= ' + '''' + DtToStr(qry.FieldByName('ExternalTimeStamp').AsDateTime) + '''';
        if AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate > dt then
          dt := AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate;
        if dt > 0 then
          query := query + ' where Metadata.LastUpdatedTime >= ' + '''' + DtToStr(dt) + '''';

        query := query + ' Order By Metadata.LastUpdatedTime';

        if CoreService.GetData(query) then begin
          QueryResponse.Assign(CoreService.ResultData.O['Data']);
          if QueryResponse.A['Payment'].Count > 0 then begin
            fTotalItemsToSynch := QueryResponse.A['Payment'].Count;
            fCurrentSynchItemNo := 1;
            for I := 0 to QueryResponse.A['Payment'].Count -1 do begin
              Application.ProcessMessages;
              json := QueryResponse.A['Payment'][I].AsObject;
              if TExternalXRef.IsDone(CoreService.ServiceName,'Payment', json.S['Id'], 0) then begin
                fTotalItemsToSynch := fTotalItemsToSynch -1;
              end
              else begin
                fCurrentSynchId := 0;
                ContinueSynch := true;
                AddCustPaymentToERP(json);
                if not ContinueSynch then
                  exit;
                fCurrentSynchItemNo := fCurrentSynchItemNo + 1;
              end;
            end;
          end;
        end
        else begin
          DoError;
        end;

        { now check for new bill payments .. }
        fCurrentSynchItemType := SynchItemType_BillPayment;
        query := 'select * from BillPayment';
        qry.SQL.Clear;
        qry.SQL.Add('select Convert(Max(IfNull(ExternalTimeStamp,0)), DateTime) as ExternalTimeStamp from tblExternalXRef');
        qry.SQL.Add('where ExternalType = "Quickbooks" and ObjectType = "BillPayment"');
        qry.Open;
        if qry.FieldByName('ExternalTimeStamp').AsDateTime > 0 then
//          query := query + ' where Metadata.LastUpdatedTime >= ' + '''' + DtToStr(qry.FieldByName('ExternalTimeStamp').AsDateTime) + '''';
        if AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate > dt then
          dt := AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate;
        if dt > 0 then
          query := query + ' where Metadata.LastUpdatedTime >= ' + '''' + DtToStr(dt) + '''';

        query := query + ' Order By Metadata.LastUpdatedTime';

        if CoreService.GetData(query) then begin
          QueryResponse.Assign(CoreService.ResultData.O['Data']);
          if QueryResponse.A['BillPayment'].Count > 0 then begin
            fTotalItemsToSynch := QueryResponse.A['BillPayment'].Count;
            fCurrentSynchItemNo := 1;
            for I := 0 to QueryResponse.A['BillPayment'].Count -1 do begin
              Application.ProcessMessages;
              json := QueryResponse.A['BillPayment'][I].AsObject;
              if TExternalXRef.IsDone(CoreService.ServiceName,'BillPayment', json.S['Id'], 0) then begin
                fTotalItemsToSynch := fTotalItemsToSynch -1;
              end
              else begin
                fCurrentSynchId := 0;
                ContinueSynch := true;
                AddSuppPaymentToERP(json);
                if not ContinueSynch then
                  exit;
                fCurrentSynchItemNo := fCurrentSynchItemNo + 1;
              end;
            end;
          end;
        end
        else begin
          DoError;
        end;

      finally
        qry.Free;
        QueryResponse.Free;
      end;
    end;
  except
    on e: exception do begin
      DoError(e.Message);
    end;
  end;
end;

function TErpSynch.SynchProduct(ProductId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  Product: TProduct;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
//  Log('SynchProduct (ID) - Start ' + IntToStr(ProductId), 'Detail');
  try
    if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Product, ProductID, Id, XRefDone) then begin
//      Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' found in XRefTable', 'Detail');
      if Id <> '' then begin
//        Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' XRefTable ExternalId: ' + Id, 'Detail');
        if XRefDone then begin
//          Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' XRef Complete', 'Detail');
          if Assigned(Params) then
            Params.S['ProductId'] := Id;
          exit;
        end
        else begin
          { not done }
          { else continue below }
        end;
      end
      else begin
        { does it exist in external system }
//        Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Checking for existing Product in Quickbooks (' + TProduct.IDToggle(ProductID) + ')', 'Detail');
        result := CoreService.IdForName('Product',TProduct.IDToggle(ProductID));
        if not result then
          exit;
        Id := CoreService.ResultData.S['Id'];
        if Id <> '' then begin
//          Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Product exists in Quickbooks', 'Detail');
          { yes .. so update }
          if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Product,ProductId, Id, msg) then begin
//            Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Completing in XRefTable', 'Detail');
            result := false;
            fUserMessage := msg;
            exit;
          end;
          if Assigned(Params) then
            Params.S['ProductId'] := Id;
          exit;
        end;
      end;
    end
    else begin
      { flag as started .. }
//      Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Flagging as Started in XRefTable', 'Detail');
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Product,ProductId, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      { does it exist in external system }
//      Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Checking for existing Product in Quickbooks (' + TProduct.IDToggle(ProductID) + ')', 'Detail');
      result := CoreService.IdForName('Product',TProduct.IDToggle(ProductID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
//        Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Product exists in Quickbooks', 'Detail');
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Product,ProductId, Id, msg) then begin
//          Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Completing in XRefTable', 'Detail');
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['ProductId'] := Id;
        exit;
      end;
    end;

    { needs to be sent to external system .. }
//    Log('SynchProduct (ID): ' + IntToStr(ProductId) + ' Needs adding', 'Detail');
    Product := TProduct.CreateWithSharedConn(nil);
    try

      Product.Load(ProductId, true);
      if Product.Count = 0 then begin
        result := false;
        fUserMessage := 'Product not found for Product ID: ' + IntToStr(ProductId);
        fReturnCode := 'Data Error';
        exit;
      end;
      result := SynchProduct(Product, Id, Params);
    finally
      Product.Free;
    end;
  finally
//    Log('SynchProduct (ID) - Finished ' + IntToStr(ProductId), 'Detail');
  end;
end;

function TErpSynch.SynchPurchaseOrder(PurchaseOrder: TPurchaseOrder;
  var Id: string; Params: TJsonObject): boolean;
var
  Data, Obj: TJsonObject;
  POJson: TJsonObject;
  SupplierID, TermsID, SubID, APAccountID: string;
  msg: string;
begin
  Data := JO;
  try
    result := SynchSupplier(PurchaseOrder.SupplierID, SupplierID);
    if not result then
      exit;
    Data.S['SupplierId'] := SupplierID;
    if PurchaseOrder.Supplier.Email <> '' then
      Data.S['SupplierEmail'] := PurchaseOrder.Supplier.Email;

    if PurchaseOrder.TermsName <> '' then begin
      result := SynchTerms(PurchaseOrder.Terms.ID, TermsId);
      if not result then
        exit;
      Data.S['TermsId'] := TermsID;
    end;

    result := SynchAccount(PurchaseOrder.GLAccountId, APAccountID);
    if not result then
      exit;
    Data.S['APAccountID'] := APAccountID;

    PurchaseOrder.Lines.First;
    while not PurchaseOrder.Lines.EOF do begin
      Obj := JO;
      { ProductId }
      SubID := '';
      result := self.SynchProduct(PurchaseOrder.Lines.ProductID, SubID);
      if not result then exit;
      Obj.S['ProductId'] := SubID;

      if AppEnv.RegionalOptions.RegionType <> rUSA then begin
        {  LineTaxCode - TaxCode.ID  }
        if PurchaseOrder.Lines.LineTaxCode <> '' then begin
          SubID := '';
          result := SynchTaxCode(PurchaseOrder.Lines.TaxCode.ID, SubId);
          if not result then exit;
          Obj.S['TaxCodeID'] := SubID;
        end;

        PurchaseOrder.Lines.PurchaseTaxCode.Lines.First;
        while not PurchaseOrder.Lines.PurchaseTaxCode.Lines.EOF  do begin
          SubId:= '';
          result := SynchSubTaxCode(PurchaseOrder.Lines.PurchaseTaxCode.Lines.SubTaxID,SubId);
          if not result then
            exit;
          Obj.A['SubTaxCodes'].Add(JO('{"SubTaxCodeId":"'+SubId+'"}'));
          PurchaseOrder.Lines.PurchaseTaxCode.Lines.Next;
        end;
      end;

      if PurchaseOrder.Lines.CustomerJobID > 0 then begin
        { customer must exist in remote system }
        SubID := '';
        result := SynchCustomer(PurchaseOrder.Lines.CustomerJobID, SubId);
        if not result then exit;
        Obj.S['CustomerJobID'] := SubID;
      end;


      Data.A['Lines'].Add(Obj);
      PurchaseOrder.Lines.Next;
    end;

    POJson := Serialise(PurchaseOrder);
    try
      POJson.O['Data'].Assign(Data);
      result := AddERPObject(POJson);
      if result then begin
        Id := CoreService.ResultData.S['Id'];
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_PurchaseOrder,PurchaseOrder.ID,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['PurchaseOrderId'] := Id;
      end
      else begin
        result := false;
        fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
        fUserMessage := CoreService.ResultData.S[Name_UserMessage];
        fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
      end;
    finally
      POJson.Free;
    end;
  finally
    Data.Free;
  end;
end;

function TErpSynch.SynchPurchaseOrder(PurchaseOrderId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  PO: TPurchaseOrder;
  XRefDone: boolean;
  msg: string;
  PositiveLineCount: integer;
begin
  result := true;
  if CheckPONegative(PurchaseOrderId, PositiveLineCount) then begin
    { check for a mix of negative and posttive value lines }
    if PositiveLineCount > 0 then begin
      result := false;
      fReturnCode := Return_Code_Error;
      fUserMessage := 'Can not Synch Purchase Order as it contains a mix of negative and positive value lines, these must be seperated into 2 seperate Purchase Orders';
      fAPIMessage := '';
      exit;
    end;
  end;
  PO := nil;
  try
    if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_PurchaseOrder, PurchaseOrderId, Id, XRefDone) then begin
      { found a record .. }
      if Id <> '' then begin
        if XRefDone then begin
          if Assigned(Params) then
            Params.S['PurchaseOrderId'] := Id;
          exit;
        end
        else begin

        end;
      end
      else begin
        { started but not complete ... }
        { does it exist in external system }
        PO := TPurchaseOrder.CreateWithSharedConn(nil);
        PO.Load(PurchaseOrderId, true);
        { does it exist in external system }
        result := CoreService.IdForName('PurchaseOrder', PO.DocNumber);
        if not result then
          exit;
        Id := CoreService.ResultData.S['Id'];
        if Id <> '' then begin
          { yes .. so update }
          if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_PurchaseOrder, PurchaseOrderId,Id,msg) then begin
            result := false;
            fUserMessage := msg;
            exit;
          end;
          if Assigned(Params) then
            Params.S['PurchaseOrderId'] := Id;
          exit;
        end;
      end;
    end
    else begin
      { flag as started .. }
      if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_PurchaseOrder,PurchaseOrderId, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
    end;

    { needs to be sent to external system .. }
    if not Assigned(PO) then
      PO := TPurchaseOrder.CreateWithSharedConn(nil);
    PO.Load(PurchaseOrderId, true);
    result := SynchPurchaseOrder(PO, Id, Params);
  finally
    PO.Free;
  end;
end;

function TErpSynch.SynchSupplier(Supplier: TSupplier; var Id: string;
  Params: TJsonObject): boolean;
var
  Json: TJsonObject;
  dt: TDateTime;
  msg: string;
begin
  Json := Serialise(Supplier);
  try
    result := AddERPObject(Json);
    if result then begin
      Id := CoreService.ResultData.S['Id'];
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Supplier,Supplier.ID,Id,msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['SupplierId'] := Id;

     { check in remote system .. and wait if not there yet }
      dt := now + (OneSecond * 60);
      while now <= dt do begin
        Delay(2);
        if CoreService.GetObject('Supplier', Id) then begin
          break;
        end;
        Delay(2);
      end;

    end
    else begin
      result := false;
      fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
      fUserMessage := CoreService.ResultData.S[Name_UserMessage];
      fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
    end;
  finally
    Json.Free;
  end;
end;

function TErpSynch.SynchSubTaxCode(SubTaxCodeId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  XRefDone: boolean;
begin
  result := TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_TaxRate, SubTaxCodeId, Id, XRefDone);
  result := result and XRefDone;
  if not result then
    fUserMessage := 'Sup Tax Code (' + TSubTaxCode.IDToggle(SubTaxCodeID) + ') not linked to ' + CoreService.ServiceName;
end;

function TErpSynch.SynchSupplier(SupplierId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  Supp: TSupplier;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
  if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Supplier, SupplierID, Id, XRefDone) then begin
    if Id <> '' then begin
      if XRefDone then begin
        if Assigned(Params) then
          Params.S['SupplierId'] := Id;
        exit;
      end
      else begin
        { not done }
        { else continue below }
      end;
    end
    else begin
      { does it exist in external system }
      result := CoreService.IdForName('Supplier',TSupplier.IDToggle(SupplierID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Supplier, SupplierId,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['SupplierId'] := Id;
        exit;
      end;
    end;
  end
  else begin
    { flag as started .. }
    if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Supplier,SupplierId, msg) then begin
      result := false;
      fUserMessage := msg;
      exit;
    end;

    { does it exist in external system }
    result := CoreService.IdForName('Supplier',TSupplier.IDToggle(SupplierID));
    if not result then
      exit;
    Id := CoreService.ResultData.S['Id'];
    if Id <> '' then begin
      { yes .. so update }
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Supplier, SupplierId,Id, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['SupplierId'] := Id;
      exit;
    end;
  end;

  { needs to be sent to external system .. }
  Supp := TSupplier.CreateWithSharedConn(nil);
  try
    Supp.Load(SupplierId, true);
    result := SynchSupplier(Supp, Id, Params);
  finally
    Supp.Free;
  end;
end;

function TErpSynch.SynchTerms(Terms: TTerms; var Id: string; Params: TJsonObject): boolean;
var
  Json: TJsonObject;
  msg: string;
begin
  Json := Serialise(Terms);
  try
    result := AddERPObject(Json);
    if result then begin
      Id := CoreService.ResultData.S['Id'];
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Term, Terms.ID, Id, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['TermsId'] := Id;
    end
    else begin
      result := false;
      fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
      fUserMessage := CoreService.ResultData.S[Name_UserMessage];
      fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
    end;
  finally
    Json.Free;
  end;
end;

function TErpSynch.SynchTaxCode(TaxCode: TTaxCode; var Id: string;
  Params: TJsonObject): boolean;
var
  Json: TJsonObject;
  msg: string;
begin
  Json := Serialise(TaxCode);
  try
    if Assigned(Params) then
      Json.O['Data'].Assign(Params);
    result := AddERPObject(Json);
    if result then begin
      Id := CoreService.ResultData.S['Id'];
      if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_TaxCode, TaxCode.ID, Id, msg) then begin
        result := false;
        fUserMessage := msg;
        exit;
      end;
      if Assigned(Params) then
        Params.S['TaxCodeId'] := Id;
    end
    else begin
      result := false;
      fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
      fUserMessage := CoreService.ResultData.S[Name_UserMessage];
      fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
    end;
  finally
    Json.Free;
  end;
end;

function TErpSynch.SynchTaxCode(TaxCodeId: Integer; var Id: string;
  Params: TJsonObject): boolean;
var
  TaxCode: TTaxCode;
  XRefDone: boolean;
  msg: string;
begin
  result := true;
  if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_TaxCode, TaxCodeID, Id, XRefDone) then begin
    if Id <> '' then begin
      if XRefDone then begin
        if Assigned(Params) then
          Params.S['TaxCodeId'] := Id;
        exit;
      end
      else begin
        { not done }
        { else continue below }
      end;
    end
    else begin
      { does it exist in external system }
      result := CoreService.IdForName('TaxCode',TTaxCode.IDToggle(TaxCodeID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_TaxCode,TaxCodeId, Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['TaxCodeId'] := Id;
        exit;
      end;
    end;
  end
  else begin
    if TaxCodeMustExistInRemote then begin
      result := false;
      fUserMessage := 'Tax Code (' + TTaxCode.IDToggle(TaxCodeID) + ') not linked to ' + CoreService.ServiceName;
      exit;
    end;
    { flag as started .. }
    if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_TaxCode,TaxCodeId, msg) then begin
      result := false;
      fUserMessage := msg;
      exit;
    end;
  end;

  { needs to be sent to external system .. }
  TaxCode := TTaxCode.CreateWithSharedConn(nil);
  try

    TaxCode.Load(TaxCodeId, true);
    result := SynchTaxCode(TaxCode, Id, Params);
  finally
    TaxCode.Free;
  end;
end;

function TErpSynch.SynchTerms(TermsId: Integer; var Id: string; Params: TJsonObject): boolean;
var
  Terms: TTerms;
  XRefDone: boolean;
  msg: string;
begin

  result := true;
  if TExternalXRef.GetExternalRef(CoreService.ServiceName, ExRef_Objtype_Term, TermsID, Id, XRefDone) then begin
    if Id <> '' then begin
      if XRefDone then begin
        if Assigned(Params) then
          Params.S['TermsId'] := Id;
        exit;
      end
      else begin
        { not done }
        { else continue below }
      end;
    end
    else begin
      { does it exist in external system }
      result := CoreService.IdForName('Term',TTerms.IDToggle(TermsID));
      if not result then
        exit;
      Id := CoreService.ResultData.S['Id'];
      if Id <> '' then begin
        { yes .. so update }
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Term,TermsId,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['TermsId'] := Id;
        exit;
      end;
    end;
  end
  else begin
    if TermsMustExistInRemote then begin
      result := false;
      fUserMessage := 'Terms (' + TTerms.IDToggle(TermsID) + ') not linked to ' + CoreService.ServiceName;
      exit;
    end;
    { flag as started .. }
    if not TExternalXRef.StartNew(CoreService.ServiceName,ExRef_Objtype_Term,TermsId, msg) then begin
      result := false;
      fUserMessage := msg;
      exit;
    end;
  end;

  { needs to be sent to external system .. }
  Terms := TTerms.CreateWithSharedConn(nil);
  try

    Terms.Load(TermsId, true);
    result := SynchTerms(Terms, Id, Params);
  finally
    Terms.Free;
  end;
end;

function TErpSynch.SynchInvoice(Inv: TInvoice; var Id: string; Params: TJsonObject): boolean;
var
  Data, Obj: TJsonObject;
  InvJson: TJsonObject;
  CustomerID, TermsID, SubID: string;
  msg: string;
begin
  Data := JO;
  try
    result := SynchCustomer(Inv.CustomerID, CustomerID);
    if not result then
      exit;
    Data.S['CustomerId'] := CustomerID;
    if Inv.Customer.Email <> '' then
      Data.S['CustomerEmail'] := Inv.Customer.Email;

    if Inv.TermsName <> '' then begin
      result := SynchTerms(Inv.Terms.ID, TermsId);
      if not result then
        exit;
      Data.S['TermsId'] := TermsID;
    end;

    Inv.Lines.First;
    while not Inv.Lines.EOF do begin
      Obj := JO;
      { ProductId }
      SubID := '';
      result := self.SynchProduct(Inv.Lines.ProductID, SubID);
      if not result then exit;
      Obj.S['ProductId'] := SubID;

      {  LineTaxCode - TaxCode.ID  }
      if Inv.Lines.LineTaxCode <> '' then begin
        SubID := '';
        result := SynchTaxCode(Inv.Lines.TaxCode.ID, SubId);
        if not result then exit;
        Obj.S['TaxCodeID'] := SubID;
      end;

      Inv.Lines.SalesTaxCode.Lines.First;
      while not Inv.Lines.SalesTaxCode.Lines.EOF  do begin
        SubId:= '';
        result := SynchSubTaxCode(Inv.Lines.SalesTaxCode.Lines.SubTaxID,SubId);
        if not result then
          exit;
        Obj.A['SubTaxCodes'].Add(JO('{"SubTaxCodeId":"'+SubId+'"}'));
        Inv.Lines.SalesTaxCode.Lines.Next;
      end;

      Data.A['Lines'].Add(Obj);
      Inv.Lines.Next;
    end;

    InvJson := Serialise(Inv);
    try
      InvJson.O['Data'].Assign(Data);
      result := AddERPObject(InvJson);
      if result then begin
        Id := CoreService.ResultData.S['Id'];
        if not TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Invoice,Inv.ID,Id, msg) then begin
          result := false;
          fUserMessage := msg;
          exit;
        end;
        if Assigned(Params) then
          Params.S['InvoiceId'] := Id;
      end
      else begin
        result := false;
        fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
        fUserMessage := CoreService.ResultData.S[Name_UserMessage];
        fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
      end;
    finally
      InvJson.Free;
    end;
  finally
    Data.Free;
  end;
end;


//procedure TErpSynch.AddorUpdateOrder(Data: TJsonObject);
//var
//  amsg:String;
//  fiID:Integer;
//begin
//  if SameText(CoreService.ServiceName, Servicename_Magento) then begin
//    With TExternalXRef.NewInstance(nil) do try
//      LoadSelect('ExternalType =' +quotedstr(CoreService.ServiceName)+' and '+
//                 'ObjectType =' + quotedstr(ExRef_Objtype_SalesOrder) +' and '+
//                 'ExternalID =' + quotedstr(Data.S['increment_id']));
//      if count = 0 then begin
//        New;
//        ExternalType := CoreService.ServiceName;
//        ObjectType   := ExRef_Objtype_SalesOrder;
//        ExternalID   := Data.S['increment_id'];
//        PostDB;
//      end;
//      if ERPID =0 then begin
//         //TSalesorder
//      end;
//    finally
//      Free;
//    end;
//  end;
//end;

Function TErpSynch.InvoiceAddress(Const aFirstname, aMiddleNAme, aLastname, acompanyname,ajobname,aContactname,aaddress1, aaddress2, aaddress3, acity, astate, apostcode,acountry, aextraInfo:String):String;
var
  Posn:Integer;
begin
  if acompanyname <> '' then result := acompanyname
  else result := trim(aFirstname)+' ' +trim(amiddlename+' ')+ Trim(aLastname);

  If AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices Then Begin
    Posn               := Pos('^', result);
    If Posn > 0 Then result := Copy(result, 1, Posn - 1);
  End;

  if ajobname <> '' then result := result + #13#10 + ajobname;

  Result:= ConcatStrings([result ,
                     iif(Appenv.CompanyPrefs.IncludeContactNameInSalesBillingAddress and (aContactname<> '') and not(Sametext(result,aContactname)) , aContactname , ''),
                     ConcatStrings([aaddress1 , aaddress2  , aaddress3  ,ConcatStrings([aCity , astate ,aPostCode ], ' ') , acountry ],#13+#10)],#13+#10);
end;


end.
