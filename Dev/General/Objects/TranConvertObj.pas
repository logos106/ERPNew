unit TranConvertObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/2002 - Intial  ML    This object is used to convert/copy an existing transaction
                         to a different type of transaction. eg. Quote to Invoice,
                         Quote to Cash Sale.

                         USAGE : The overloaded method ConvertTransaction should
                         be examined prior to executing. The developer will need
                         to determine which method to implement based on the following;

                         1. function ConvertTransaction(TranType: TTranType;
                            MasterTable, DetailTable: TMyTable): String; overload;

                         * This method should be used when you're converting a
                         transaction from the same tables. e.g
                         Quote to an Invoice, Sales Order to Cash Sale.

                         Parameters
                         ***********
                         TranType = The TTranType you want to convert to. e.g
                         ttInvoice  MasterTable = The TMyTable of the master
                         record   DetailTable = The TMyTable of the detail record

                        2. function ConvertTransaction(FromTranType, ToTranType: TTranType; ClientID: Integer;
                           MasterTable, DetailTable: TMyTable): String; overload;

                        * This method should be used when you're converting a
                        transaction from different tables. e.g Repair to an Invoice.
                        Parameters
                        ***********
                        FromTranType = The TTranType you're converting from. e.g.
                        ttRepair ToTranType = The TTranType you're converting to.
                        e.g. ttInvoice ClientID = The ID of the Client, needs to
                        be passed in due to the different naming conventions
                        MasterTable = The TMyTable of the master record
                        DetailTable = The TMyTable of the detail record

                        This method uses a field mapping routine, AppendMappedFields.
                        This method retrieves data from the table tblTransactionMapper.
                        This table has 5 fields;

                        1. ID = PK - AutoInc field
                        2. FromTranType - The description of the transaction you
                           want to convert from, (TTranTypeInfo)
                        3. ToTranType - The description of the transaction you
                           want to convert to, (TTranTypeInfo)
                        4. MasterMappings - A Text field used to map the fields
                           of the master table
                        5. DetailMappings - A Text field used to map the fields
                           of the detail table

                        The MasterMappings and DetailMappings fields use this logic,
                        FromTableField=ToTableField, i.e. Qty from tblRepairs maps
                        to QtySold in tblSales - Qty=QtySold.
 24/03/05  2.00.01 IJB  Changed ConvertDespatchRunToPayment to:
                        1) call funtion to calculate invoice commissions
                        2) use correct rep for invoice based on company prefs.
 31/03/05  2.00.02 IJB  Added reward points prcessing call to
                        ConvertDespatchRunToPayment.
 25/05/05  2.00.03 BJ   'Raise exception' is changed to MessageDlg for user messages
 15/06/05  2.00.04 BJ   convertTransaction function has a new param 'Conn' which
                        is defaulted to nil. When it is not nil, it is used for
                        the following database updations.
                        The reason is when the fucntion is called for the memorised cheque
                        transaction, the original record is not 'commited', so need
                        to use the same transaction.
 23/06/05  2.00.05 DSP  Added functionality to allow the use of the 'NAB CardFast' payment
                        method
 16/08/05  2.00.06 BJ   When appointment is invoiced, the hrs were displayed as the qty and the
                        hrly rate as the price. The qty should be 1 and the toatal should be
                        the price. ie. Price and invoice total will be same (+ tax) -
                        based on a preference - ShowServiceHrsInInvoiceQty
 04/01/06  2.00.07 BJ   Conversion of an appointment to invoice updates the client's
                        available free hrs and invoice charge is created based on the
                        remaining hours.
                        The appointment has a Booked Date/Time and Actual Date/Time.
                        Invoicing is done on the actual Date/Time
 10/01/06  2.00.08 BJ   ConvertAppointmentToInvoice function removed as the appointment
                        form doen't use this object any more, but using the invoice object
 24/04/06  2.00.09 DSP  Removed extra 'l' in spelling of 'UnitOfMeasureMultiplier' in
                        the ConvertRepairToSmartOrder method.                       

}




interface

uses
    DB, Windows, Messages, Classes, DNMLib, ProgressDialog, ComCtrls,AdvOfficeStatusBar,
  DateUtils, MyAccess, kbmMemTable,  dialogs, Controls;

const
  SX_CalcTotalsMsg = WM_USER + 100;

type
  TTranConvertObj = class(TObject)
  private
    fqryGeneric: TMyQuery;
    ftblInsert: TMyTable;
    fiClassID: integer;
    foConnection: TCustomMyConnection;
    fbExternalConnection :Boolean;
    foAccounting: TAccountingObj;
    fbIncludedInTransaction: boolean;

    procedure PrepareTableForInsert(const SourceTable: TDataset; const DestTable: TMyTable; const sTableName: string);
    procedure AppendGenericMasterValues(const ds: TDataset; const TranType: TTranType; const iNewID: integer);
    procedure AppendMasterValues(const MasterRecord: TDataset; const NewID: string; const TranType: TTranType); overload;

    procedure AppendMasterValues(const iNewID: integer; const TranType: TTranType; Conn: TCustomMyConnection = nil); overload;
    procedure AppendDetailValues(const iNewDetailIDs: TClonedRecords; const TranType: TTranType;
      const ForeignKeyID: integer; Conn: TCustomMyConnection = nil);
    function RetrieveDetailTransactions(const sTableName, sMasterKeyName: string; const MasterID: integer;
      Conn: TCustomMyConnection = nil): TMyQuery;
    {Update the ChartOfAccounts with the necessary accounting routines}
    procedure UpdateAccounts(const TableName, MasterKeyName: string; const KeyID, ClientID, AccountID: integer;
      const TranType: TTranType; Conn: TCustomMyConnection = nil); overload;

    procedure AddQuoteDifference(const MasterRecord: TDataset; const TranType: TTranType; const NewMasterID: integer);
    {Append the mapped fields from tblTransactionMapper}
    procedure AppendMappedFields(const SourceRecords, DestRecords: TDataset; const IsMaster: boolean;
      const FromTranType, ToTranType: TTranType);
    {Append any other related fields to the record}
    procedure AppendOtherDetailFields(const SourceRecords, DestRecords: TDataset; const sCustomer: string);
    {Append any calculations to the table}
    procedure AppendCalcFields(const DestRecords: TDataset);

    {Get any relevant part details}
    function GetPartDetails(const PartsID: integer): string;
    function GetPreferredSupplierID(const SupplierName: string): integer;
    function GetIndexName(const tbl: TMyTable): string;
    function GetCustomer(const iClientID: integer): string;
//    function GetPartCost(const ID: integer): double;
    function GetPartListCost(const ID: integer): double;

  public
    fbReportSQLSupplied: boolean;
    constructor Create;
    constructor CreateWithTranControl(const TranConnection: TCustomMyConnection);
    destructor Destroy; override;
    procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean;
      const Copies: integer; AOwner: TControl);

    {This convert method is used to Copy a Transaction from the same Table to another
    transaction in the same table, thus fields are mapped automatically}
    function ConvertTransaction(const TranType: TTranType; const MasterRecord, DetailRecords: TDataset;
      Conn: TCustomMyConnection = nil): string; overload;

    {This convert method is used to Copy a Transaction from a different table to another
    table using a mapping technique as defined below}
    function ConvertTransaction(const FromTranType, ToTranType: TTranType; const ClientID: integer;
      const MasterRecord, DetailRecords: TDataset): string; overload;


    function ConvertPhSupportToInvoice(const TranType: TTranType; const ClientID: integer;
      const MasterRecord: TDataset): string;
    function ConvertManifestToBill(const ClientID: integer; const fBillTotal, fBillTotalInc, fTaxAmount: double): integer;

  end;


implementation

uses
  SysUtils, AuditObj,   Math,
  DNMExceptions, Forms, CommonDbLib,  
  tcDataUtils, CommonLib,
  frmCustomerFrm, AppEnvironment,
  FastFuncs, ReportTemplates;

constructor TTranConvertObj.CreateWithTranControl(const TranConnection: TCustomMyConnection);
begin
  inherited Create;
  fbExternalConnection := True;
  foConnection := TranConnection;

  fqryGeneric := TMyQuery.Create(nil);
  fqryGeneric.Connection := foConnection;

  ftblInsert := TMyTable.Create(nil);
  ftblInsert.Connection := foConnection;

  foAccounting := TAccountingObj.CreateWithTranControl(foConnection);
  fbIncludedInTransaction := false;

end;
constructor TTranConvertObj.Create;
begin
  inherited; 
  fbExternalConnection := False;

  foConnection:= CommonDbLib.GetNewMyDacConnection(nil);

  fqryGeneric := TMyQuery.Create(nil);
  fqryGeneric.Connection := foConnection;

  ftblInsert := TMyTable.Create(nil);
  ftblInsert.Connection := foConnection;

  foAccounting := TAccountingObj.CreateWithTranControl(foConnection);
  fbIncludedInTransaction := false;
end;

destructor TTranConvertObj.Destroy;
begin
  // Free and close objects.
  fqryGeneric.Close;
  FreeandNil(fqryGeneric);
  ftblInsert.Close;
  FreeandNil(ftblInsert);
  if not fbExternalConnection then
    FreeandNil(foConnection);
  FreeandNil(foAccounting);
  inherited;   
end;

{Assign the values to the table ready for posting}
procedure TTranConvertObj.PrepareTableForInsert(const SourceTable: TDataset; const DestTable: TMyTable;
  const sTableName: string);
var
  iIndex: integer;
  sKeyName: string;
begin
  with DestTable do begin
    Close;
    TableName  := sTableName;
//    MaxRecords := 1;
    Open;
    Insert;
    {Get the Primary Keyname because we don't want to assign a value to it because it's an Auto#}
    sKeyName := GetIndexName(DestTable);
    {Cycle through the fields of the Source table and assign to same field in Destination table}
    for iIndex := 0 to SourceTable.Fields.Count - 1 do begin
      {If it's a calculated field ignore it coz we don't need it}
      if SourceTable.Fields[iIndex].FieldKind <> fkCalculated then begin
        {Only append the value on if the field exists in the table}
        if FindField(SourceTable.Fields[iIndex].FieldName) <> nil then begin
          {If it's the Primary Key we avoid posting a value to it}
          if FieldByName(SourceTable.Fields[iIndex].FieldName).FieldName <> sKeyName then begin
            FieldByName(SourceTable.Fields[iIndex].FieldName).AsString :=
              SourceTable.Fields[iIndex].AsString;
          end;
        end;
      end;
    end;
  end;
end;

{Get the Primary Key from the table}
function TTranConvertObj.GetIndexName(const tbl: TMyTable): string;
var
  iCnt: integer;
begin
  Result := '';
  with tbl do begin
    IndexDefs.Update;
    for iCnt := 0 to IndexDefs.Count - 1 do begin
      if FastFuncs.UpperCase(IndexDefs[iCnt].Name) = 'PRIMARY' then begin
        Result := IndexDefs[iCnt].Fields;
      end;
    end;
  end;

  if Empty(Result) then begin
    raise Exception.Create('Primary Key not found in Dataset');
  end;
end;

procedure TTranConvertObj.AppendMasterValues(const MasterRecord: TDataset; const NewID: string; const TranType: TTranType);
begin
  MasterRecord.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + NewID;
  if MasterRecord.FindField('ClassID') <> nil then begin
    fiClassID := MasterRecord.FieldByName('ClassID').AsInteger;
  end else begin
    fiClassID := AppEnv.DefaultClass.ClassID;
  end;
  AppendGenericMasterValues(MasterRecord, TranType, FastFuncs.StrToInt(NewID));
end;

procedure TTranConvertObj.AppendMasterValues(const iNewID: integer; const TranType: TTranType; Conn: TCustomMyConnection = nil);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  with qry do try
      if conn <> nil then Connection := conn
      else Connection := foConnection;

      Sql.Add(Format('Select * From ' + TypeToMasterTableName(TranType) +
        ' Where ' + TypeToMasterPKName(TranType) + ' = %d', [iNewID]));
      Open;
      Edit;
      FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + FastFuncs.IntToStr(iNewID);

      if FindField('ClassID') <> nil then begin
        fiClassID := FieldByName('ClassID').AsInteger;
      end else begin
        fiClassID := AppEnv.DefaultClass.ClassID;
      end;
      AppendGenericMasterValues(qry, TranType, iNewID);

      if TranType = ttSalesOrder then begin
        FieldByName('Deleted').AsBoolean := false;
        FieldByName('Converted').AsBoolean := false;
      end;

      if (TranType = ttInvoice) or (TranType = ttCashSale) then begin
        FieldByName('SaleDate').AsDateTime := Now;
      end;

      if TranType in [ttPurchaseOrder, ttInvoice, ttSalesOrder] then begin
        FieldByName('BOID').AsString := '';
      end;

      if (TranType = ttInvoice) then begin
        if AppEnv.CompanyPrefs.UseManifest then begin
          FieldByName('IsManifest').AsString := 'T';
        end;
      end;

      FieldByName('EditedFlag').AsString := 'T'; //Set All New Transactions To Edited For Multisite
      Post;
    finally
      Close;
      Free;
    end;
end;

procedure TTranConvertObj.AppendGenericMasterValues(const ds: TDataset; const TranType: TTranType; const iNewID: integer);
begin
  with ds do begin
    FieldByName('EditedFlag').AsString := 'T';
    if not (TranType in [ttSmartOrder, {ttRepair,} ttJournalEntry]) then begin
      //FieldByName('OriginalNo').AsInteger := iNewID;
      {Note :Gloablref for the recordshould be created before calling this function}
      FieldByName('OriginalNo').asString := FieldByname('GlobalRef').asString;
      FieldByName('Deleted').AsBoolean := false;
      {Relates to a Sale transaction, perform the Sale based data population}
      if FindField('InvoiceDocNumber') <> nil then begin
        FieldByName('InvoiceDocNumber').AsInteger := iNewID;
        FieldByName('IsPOS').AsBoolean := (TranType = ttPOS);
        FieldByName('IsRefund').AsBoolean := (TranType = ttRefund);
        FieldByName('IsCashSale').AsBoolean := (TranType = ttCashSale);
        FieldByName('IsInvoice').AsBoolean := (TranType = ttInvoice);
        FieldByName('IsQuote').AsBoolean := (TranType = ttQuote);
        FieldByName('IsSalesOrder').AsBoolean := (TranType = ttSalesOrder);
        FieldByName('IsLayby').AsBoolean := false; // should never need to convert a layby
      end else begin {Must be a purchase related transaction}
        FieldByName('PurchaseOrderNumber').AsInteger := iNewID;
        FieldByName('IsPO').AsBoolean := (TranType = ttPurchaseOrder);
        FieldByName('IsRA').AsBoolean := (TranType = ttRA);
        FieldByName('IsBill').AsBoolean := (TranType = ttBill);
        FieldByName('IsCredit').AsBoolean := (TranType = ttCredit);
        FieldByName('IsCheque').AsBoolean := (TranType = ttCheque);
      end;
    end;
  end;
end;

procedure TTranConvertObj.AddQuoteDifference(const MasterRecord: TDataset; const TranType: TTranType;
  const NewMasterID: integer);

  procedure AddNewDiscountMarkupLine(const IsDiscount: boolean; const Value: currency);
  var
    qryParts: TMyQuery;
  begin
    qryParts := TMyQuery.Create(nil);
    try
      qryParts.Connection := foConnection;
      qryParts.Sql.Add(Format('Select * From tblParts Where Upper(PartName) = %s',
        [QuotedStr('CONVERT FROM QUOTE')]));
      qryParts.Open;
      if not qryParts.IsEmpty then begin
        with TMyQuery.Create(nil) do try
            Connection := foConnection;
            Sql.Add('Select * From ' + TypeToDetailTableName(TranType) +
              ' Where ' + TypeToMasterPKName(TranType) + ' = 0');
            Open;
            Insert;

            if IsDiscount then begin
              //FieldByName('Discounts').AsCurrency := Value;
              FieldByName('TotalLineAmountInc').AsCurrency := -Value;
              FieldByName('TotalLineAmount').AsCurrency := GetAmountEx(-Value,
                GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
              FieldByName('LinePrice').AsCurrency := GetAmountEx(-Value, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
              FieldByName('LinePriceInc').AsCurrency := -Value;
              FieldByName('LineTax').AsCurrency := FieldByName('LinePriceInc').AsCurrency -
                FieldByName('LinePrice').AsCurrency;
            end else begin
              //FieldByName('Markup').AsCurrency := Value;
              FieldByName('TotalLineAmountInc').AsCurrency := Value;
              FieldByName('TotalLineAmount').AsCurrency := GetAmountEx(Value,
                GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
              FieldByName('LinePrice').AsCurrency := GetAmountEx(Value, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
              FieldByName('LinePriceInc').AsCurrency := Value;
              FieldByName('LineTax').AsCurrency := FieldByName('LinePriceInc').AsCurrency -
                FieldByName('LinePrice').AsCurrency;
            end;

            FieldByName(TypeToMasterPKName(TranType)).AsInteger := NewMasterID;
            FieldByName('PartType').AsString := qryParts.FieldByName('PartType').AsString;
            FieldByName('IncomeAccnt').AsString := qryParts.FieldByName('IncomeAccnt').AsString;
            FieldByName('AssetAccnt').AsString := qryParts.FieldByName('AssetAccnt').AsString;
            FieldByName('CogsAccnt').AsString := qryParts.FieldByName('CogsAccnt').AsString;
            FieldByName('ProductName').AsString := qryParts.FieldByName('PartName').AsString;
            FieldByName('ProductID').AsInteger := qryParts.FieldByName('PartsID').AsInteger;
            FieldByName('Product_Description').AsString := qryParts.FieldByName('PartsDescription').AsString;
            FieldByName('QtySold').AsInteger := 1;
            FieldByName('Shipped').AsInteger := 1;
            FieldByName('UnitofMeasureQtySold').AsFloat := 1;
            FieldByName('UnitofMeasureShipped').AsFloat := 1;
            FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
            FieldByName('LineTaxRate').AsFloat := GetTaxRate(qryParts.FieldByName('TaxCode').AsString);
            FieldByName('LineTaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
            Post;
          finally
            Free;
          end;
      end;
    finally
      qryParts.Close;
      FreeandNil(qryParts);
    end;
  end;
begin //====>>> TTranConvertObj.AddQuoteDifference
  with MasterRecord do begin
    if FindField('TotalQuoteAmount') <> nil then begin
      //      if not Empty(FieldByName('TotalQuoteAmount').AsString) then begin
      if (FieldByName('TotalQuoteAmount').AsFloat <> 0) then begin
        if FieldByName('TotalAmountInc').AsCurrency >
          FieldByName('TotalQuoteAmount').AsCurrency then begin
          AddNewDiscountMarkupLine(true, FieldByName('TotalAmountInc').AsCurrency -
            FieldByName('TotalQuoteAmount').AsCurrency);
        end else if FieldByName('TotalAmountInc').AsCurrency <
          FieldByName('TotalQuoteAmount').AsCurrency then begin
          AddNewDiscountMarkupLine(false, FieldByName('TotalQuoteAmount').AsCurrency -
            FieldByName('TotalAmountInc').AsCurrency);
        end;
      end;
    end;
  end;
end;

procedure TTranConvertObj.AppendDetailValues(const iNewDetailIDs: TClonedRecords; const TranType: TTranType;
  const ForeignKeyID: integer; Conn: TCustomMyConnection = nil);
var
  i: integer;
  Qry: TMyQuery;
begin
  Qry := TMyQuery.Create(nil);
  try
    with  Qry do begin
      if Conn <> nil then Connection := conn
      else if foConnection <> nil then Connection := foconnection
      else Connection := CommonDbLib.GetSharedMyDacConnection;

      for i := Low(iNewDetailIDs) to High(iNewDetailIDs) do begin
        Sql.Clear;
        Sql.Add(Format('Select * From ' + TypeToDetailTableName(TranType) +
          ' Where ' + TypeToDetailPKName(TranType) + ' = %d', [iNewDetailIDs[i]]));
        Open;
        Edit;
        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + FastFuncs.IntToStr(iNewDetailIDs[i]);
        FieldByName(TypeToMasterPKName(TranType)).AsInteger := ForeignKeyID;
        Post;
      end;
    end;
  finally
    if Qry.Active then Qry.Close;
    FreeAndNil(qry);
  end;
end;

function TTranConvertObj.RetrieveDetailTransactions(const sTableName, sMasterKeyName: string;
  const MasterID: integer; Conn: TCustomMyConnection = nil): TMyQuery;
begin
  Result := TMyQuery.Create(nil);
  with Result do begin
    if conn <> nil then Connection := conn
    else if fbIncludedInTransaction then begin
      Connection := foConnection;
    end else begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
    end;

    SQL.Add(Format('SELECT * FROM %s WHERE %s = %d', [sTableName, sMasterKeyName, MasterID]));
    Open;

    if IsEmpty then begin
      raise ETranConvertError.Create('Detail transactions not found. Cannot convert this transaction.');
    end;
  end;
end;

procedure TTranConvertObj.AppendMappedFields(const SourceRecords, DestRecords: TDataset;
  const IsMaster: boolean; const FromTranType, ToTranType: TTranType);
var
  iIndex: integer;
  qry: TMyQuery;
  lst: TStringList;
begin
  qry := TMyQuery.Create(nil);
  with qry do try
      Connection := foConnection;
      Sql.Add(Format('SELECT MasterMappings, DetailMappings FROM ' +
        'tblTransactionMapper WHERE (FromTranType = %s) and (ToTranType = %s)',
        [QuotedStr(TypeToDescription(FromTranType)),
        QuotedStr(TypeToDescription(ToTranType))]));
      Open;
      if not IsEmpty then begin
        lst := TStringList.Create;
        with lst do try
            if IsMaster then begin
              CommaText := FieldByName('MasterMappings').AsString;
            end else begin
              CommaText := FieldByName('DetailMappings').AsString;
            end;
            for iIndex := 0 to Count - 1 do begin
              DestRecords.FieldByName(ExtractStrPortion(lst.Strings[iIndex], '=', 2)).AsString :=
                SourceRecords.FieldByName(Names[iIndex]).AsString;
            end;
          finally
            Free;
          end;
      end;
    finally
      Free;
    end;
end;

procedure TTranConvertObj.AppendOtherDetailFields(const SourceRecords, DestRecords: TDataset; const sCustomer: string);
var
  sAccounts: string;
  TempSupplierID: integer;
begin
  with SourceRecords do begin
    if FindField('PartsID') <> nil then begin
      sAccounts := GetPartDetails(FieldByName('PartsID').AsInteger);
    end else if FindField('ProductID') <> nil then begin
      sAccounts := GetPartDetails(FieldByName('ProductID').AsInteger);
    end;

    if not Empty(sAccounts) then begin
      if FindField('IncomeAccnt') = nil then begin
        if DestRecords.FindField('IncomeAccnt') <> nil then begin
          DestRecords.FieldByName('IncomeAccnt').AsString := ExtractStrPortion(sAccounts, ',', 1);
        end;
      end;
      if FindField('AssetAccnt') = nil then begin
        if DestRecords.FindField('AssetAccnt') <> nil then begin
          DestRecords.FieldByName('AssetAccnt').AsString := ExtractStrPortion(sAccounts, ',', 2);
        end;
      end;
      if FindField('COGSAccnt') = nil then begin
        if DestRecords.FindField('COGSAccnt') <> nil then begin
          DestRecords.FieldByName('COGSAccnt').AsString := ExtractStrPortion(sAccounts, ',', 3);
        end;
      end;
      if FindField('PartType') = nil then begin
        if DestRecords.FindField('PartType') <> nil then begin
          DestRecords.FieldByName('PartType').AsString := ExtractStrPortion(sAccounts, ',', 4);
        end;
      end;
      if FindField('SupplierID') = nil then begin
        if DestRecords.FindField('SupplierID') <> nil then begin
          if FindField('Supplier') <> nil then begin
            TempSupplierID := GetPreferredSupplierID(FieldByName('Supplier').AsString);
            if TempSupplierID = 0 then begin
              TempSupplierID := GetPreferredSupplierID(ExtractStrPortion(sAccounts, ',', 5));
            end;
          end else begin
            TempSupplierID := GetPreferredSupplierID(ExtractStrPortion(sAccounts, ',', 5));
          end;
          DestRecords.FieldByName('SupplierID').AsInteger := TempSupplierID;
        end;
      end;
      if DestRecords.FindField('ClassID') <> nil then begin
        DestRecords.FieldByName('ClassID').AsInteger := fiClassID;
      end;
      if DestRecords.FindField('CusJobID') <> nil then begin
        DestRecords.FieldByName('CusJobID').AsString := sCustomer;
      end;
    end;
  end;
end;

procedure TTranConvertObj.AppendCalcFields(const DestRecords: TDataset);
begin
  if DestRecords.FindField('LineTax') <> nil then begin
    if DestRecords.FindField('Shipped') <> nil then begin
      DestRecords.FieldByName('LineTax').AsCurrency := (DestRecords.FieldByName('LinePriceInc').AsCurrency -
                                                        DestRecords.FieldByName('LinePrice').AsCurrency) *
                                                        DestRecords.FieldByName('Shipped').AsFloat;
    end
    else begin
      DestRecords.FieldByName('LineTax').AsCurrency := DestRecords.FieldByName('LinePriceInc').AsCurrency -
                                                       DestRecords.FieldByName('LinePrice').AsCurrency;
    end;
  end;

  if DestRecords.FindField('TotalLineAmountInc') <> nil then begin
    DestRecords.FieldByName('TotalLineAmountInc').AsCurrency :=
      DestRecords.FieldByName('TotalLineAmount').AsCurrency + DestRecords.FieldByName('LineTax').AsCurrency;
  end;
end;

procedure TTranConvertObj.UpdateAccounts(const TableName, MasterKeyName: string;
  const KeyID, ClientID, AccountID: integer; const TranType: TTranType; Conn: TCustomMyConnection = nil);
var
  qryDetailLines: TMyQuery;
begin
  if not (TranType in [ttSmartOrder, {ttRepair,} ttSalesOrder, ttJournalEntry]) then begin
    if FoConnection <> nil then if foConnection.InTransaction then fbIncludedInTransaction := true;
    { this is to force using the foconnection within the proc following}
    qryDetailLines := RetrieveDetailTransactions(TableName, MasterKeyName, KeyID, Conn);
    try
        if FormStillOpen('TfrmCustomer') then begin
            TfrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
            Application.ProcessMessages;
        end;
      foAccounting.UpdateQuantityLines(fiClassID, qryDetailLines);
      {Update the client balance if the trantype isn't a cash sale}
      if (TranType <> ttCashSale) and (TranType <> ttCheque)  then begin
        foAccounting.UpdateClientBalance(ClientID, ClientID, nil, qryDetailLines);
      end;

      foAccounting.UpdateMasterChartofAccounts(AccountID, 0, 'Tax Collected', nil, qryDetailLines);
      foAccounting.UpdateDetailChartOfAccounts(nil, qryDetailLines);
    finally
      if Assigned(qryDetailLines) then
        FreeandNil(qryDetailLines);
    end;
  end;

  if (TranType in [ttSalesOrder]) then begin //Sales Order only Need Qty's
    if FoConnection <> nil then if foConnection.InTransaction then fbIncludedInTransaction := true;
    { this is to force using the foconnection within the proc following}

    qryDetailLines := RetrieveDetailTransactions(TableName, MasterKeyName, KeyID, conn);
    foAccounting.SaleOrderQty := true;
    foAccounting.UpdateQuantityLines(fiClassID, qryDetailLines);
    foAccounting.SaleOrderQty := false;
  end;
  if foConnection.intransaction then foConnection.Commit;
end;

function TTranConvertObj.GetPartDetails(const PartsID: integer): string;
begin
  Result := '';
  with fqryGeneric do begin
    Close;
    Sql.Clear;
    Sql.Add(Format('SELECT IncomeAccnt, AssetAccnt, COGSAccnt, PartType, PreferedSupp ' +
      'FROM tblParts WHERE PartsID = %d', [PartsID]));

    Open;
    if not IsEmpty then begin
      Result := FieldByName('IncomeAccnt').AsString + ',' + FieldByName('AssetAccnt').AsString +
        ',' + FieldByName('COGSAccnt').AsString + ',' + FieldByName('PartType').AsString + ',' + FieldByName('PreferedSupp').AsString;
    end;
  end;
end;

function TTranConvertObj.GetPreferredSupplierID(const SupplierName: string): integer;
begin
  Result := 0;
  with TMyQuery.Create(nil) do try
      Connection := foConnection;
      Sql.Add(Format('SELECT ClientID FROM tblClients WHERE Company = %s', [QuotedStr(SupplierName)]));
      Open;
      if not IsEmpty then begin
        Result := FieldByName('ClientID').AsInteger;
      end;
    finally
      Free;
    end;
end;

{Use this method when converting transactions from the same tables}
function TTranConvertObj.ConvertTransaction(const TranType: TTranType; const MasterRecord, DetailRecords: TDataset;
  Conn: TCustomMyConnection = nil): string;
var
  sMasterKeyName, sKeyName: string;
  iNewMasterID: integer;
  iNewDetailIDs: TClonedRecords;
  TmpQry: TMyQuery;
begin
  try
    Application.ProcessMessages;
    Result := '';

    if not (foConnection.InTransaction) then foConnection.StartTransaction;

    sMasterKeyName := TypeToMasterPKName(TranType);
    iNewMasterID   := CloneRecord(TCustomMyDataSet(MasterRecord), sMasterKeyName);
    Result         := FastFuncs.IntToStr(iNewMasterID);

    AppendMasterValues(iNewMasterID, TranType, Conn);

    sKeyName      := TypeToDetailPKName(TranType);
    iNewDetailIDs := CloneRecords(TCustomMyDataSet(DetailRecords), sKeyName);
    AppendDetailValues(iNewDetailIDs, TranType, iNewMasterID, conn);

    if (TranType in [ttJournalEntry]) then begin
      foConnection.Commit;
    end
    else begin
      AddQuoteDifference(MasterRecord, TranType, iNewMasterID);
      UpdateAccounts(TypeToDetailTableName(TranType), sMasterKeyName, FastFuncs.StrToInt(Result),
          MasterRecord.FieldByName('ClientID').AsInteger,
          MasterRecord.FieldByName('AccountID').AsInteger, TranType, Conn);

      if TranType = ttRefund then begin
        TmpQry := TMyQuery.Create(nil);

        try
          TmpQry.Connection := TMyQuery(DetailRecords).Connection;
          TmpQry.SQL.Text := 'SELECT * FROM tblsaleslines WHERE SaleID = ' + FastFuncs.IntToStr(iNewMasterID);
          TmpQry.Open;
          TmpQry.First;

          while not TmpQry.Eof do begin
            if DetailRecords.Locate('SaleLineID', TmpQry.FieldByName('ClonedFromID').AsInteger, []) then begin
              TmpQry.Edit;
              TmpQry.FieldByName('RefundQty').AsFloat := DetailRecords.FieldByName('UnitOfMeasureShipped').AsFloat;
            end;

            TmpQry.Next;
          end;
        finally
          FreeAndNil(Tmpqry);
        end;
      end;
    end;

  except
    on e: Exception do begin
      Audit.AddEntry(e, Self);
      foConnection.Rollback;
      raise;
    end;
  end;
end;

{Use this method when converting transactions from different tables}
function TTranConvertObj.ConvertTransaction(const FromTranType, ToTranType: TTranType;
  const ClientID: integer; const MasterRecord, DetailRecords: TDataset): string;
var
  qryDetailLines: TMyQuery;
  sTableName, sDetailID: string;
  sForeignKey: string;
  sSupplier: string;
begin
  Result := '';
  fbIncludedInTransaction := true;
  Application.ProcessMessages;
  foConnection.StartTransaction;
  qryDetailLines := nil;
  with ftblInsert do try
      try
        {First add the Master record}
        sTableName := TypeToMasterTableName(ToTranType);
        {Copies all fields with the same name}
        PrepareTableForInsert(MasterRecord, ftblInsert, sTableName);
        {Now Append all mapped fields to the Table}
        AppendMappedFields(MasterRecord, ftblInsert, true, FromTranType, ToTranType);

        // Do we have an AccountID field?
        if FindField('AccountID') <> nil then begin
          // Yes, set account id.
          FieldByName('AccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSalesAccount;
        end;

        Post;

        sForeignKey := GetIndexName(ftblInsert);
        Result := FieldByName(sForeignKey).AsString;
        Edit;
        AppendMasterValues(ftblInsert, Result, ToTranType);

//        if (ToTranType = ttInvoice) and (FromTranType = ttRepair) then begin
//      {The job comletion date is no more  a mandatory field
//      When this field is blank, the invoice gets the system date defaulted}
//          if MasterRecord.FieldByName('JobDueDate').AsDateTime <> 0 then
//            FieldByName('SaleDate').AsDateTime := MasterRecord.FieldByName('JobDueDate').AsDateTime
//          else FieldByName('SaleDate').AsDateTime := Date;
//        end;

//        if (ToTranType = ttInvoice) and ((FromTranType = ttUnitHire) OR (FromTranType = ttRepair)) then begin
//          FieldByName('SaleDate').AsDateTime := Now;
//        end;

        if ToTranType in [ttPurchaseOrder, ttInvoice, ttSalesOrder] then begin
          FieldByName('BOID').AsString := '';
        end;

 //       if (FromTranType = ttRepair) and (ToTranType = ttInvoice) then begin
//          FieldByName('Class').AsString := GetClassName(MasterRecord.FieldByName('ClassID').AsInteger);
//        end;

        if (ToTranType = ttSalesOrder) and (AppEnv.CompanyPrefs.ManifestType = 'SALESORDER') then begin
          if AppEnv.CompanyPrefs.UseManifest then begin
            FieldByName('IsManifest').AsString := 'T';
          end;
        end;

        if (ToTranType = ttInvoice) and (AppEnv.CompanyPrefs.ManifestType = 'INVOICE') then begin
          if AppEnv.CompanyPrefs.UseManifest then begin
            FieldByName('IsManifest').AsString := 'T';
          end;
        end;

        Post;

        {Now add the detail lines}
        DetailRecords.First;
        while not DetailRecords.Eof do begin
          sTableName := TypeToDetailTableName(ToTranType);
          {Copies all fields with the same name}
          PrepareTableForInsert(DetailRecords, ftblInsert, sTableName);

          {Now Append all mapped fields to the Table}
          AppendMappedFields(DetailRecords, ftblInsert, false, FromTranType, ToTranType);


          if (ToTranType = ttSmartOrder) and (FromTranType in [ttQuote, ttSalesOrder]) then begin
            fiClassID := MasterRecord.FieldByName('ClassID').AsInteger;
          end;

          {Append any other relevant details and calculations}
          AppendOtherDetailFields(DetailRecords, ftblInsert, GetCustomer(ClientID));


          // Set SaleID
          FieldByName(sForeignKey).AsString := Result;

          if (((ToTranType = ttSmartOrder) and (FromTranType = ttSalesOrder)) and not (AppEnv.CompanyPrefs.CostonSalesToPO)) or
            (((ToTranType = ttSmartOrder) and (FromTranType = ttInvoice)) and not (AppEnv.CompanyPrefs.CostonSalesToPO)) or
            ((ToTranType = ttSmartOrder) and (FromTranType = ttBuildGroup)) then begin
            //ListPrice to SmartOrder
            FieldByName('LinePrice').AsFloat := GetPartListCost(FieldByName('PARTSID').AsInteger);
            if (ToTranType = ttSmartOrder) and (FromTranType = ttBuildGroup) then begin
              sSupplier := GetPreferedSupplierFromPart(FieldByName('PARTSID').AsInteger);
              FieldByName('PARTSNAME').AsString := GetPartName(FieldByName('PARTSID').AsInteger);
              FieldByName('SearchFilter').AsString := GetPartName(FieldByName('PARTSID').AsInteger);
              FieldByName('SearchFilterCopy').AsString := GetPartName(FieldByName('PARTSID').AsInteger);
              FieldByName('LineTaxRate').AsFloat := GetTaxRate(FieldByName('PARTSID').AsInteger);
              FieldByName('SupplierName').AsString := sSupplier;
              FieldByName('SupplierID').AsInteger := GetSupplierID(sSupplier);
              FieldByName('ClassName').AsString := GetClassName(MasterRecord.FieldByName('ClassID').AsInteger);
              FieldByName('ClassID').AsInteger := MasterRecord.FieldByName('ClassID').AsInteger;
              FieldByName('CostEx').AsFloat := FieldByName('LinePrice').AsFloat;
              FieldByName('CostInc').AsFloat := GetAmountInc(FieldByName('LinePrice').AsFloat,
                GetTaxRate(FieldByName('PARTSID').AsInteger));
            end;
          end;

          if ((ToTranType = ttSmartOrder) and (FromTranType = ttBuildGroup)) then begin
            FieldByName('UnitofMeasure').AsString := 'Units';
            FieldByName('UnitofMeasureID').asInteger := GetUnitOfMeasureID('Units' , FieldByName('PARTSID').AsInteger);
            FieldByName('UnitofMeasureQty').AsFloat := FieldByName('Qty').AsFloat;
            FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
          end;

          if ((ToTranType = ttSmartOrder) and (FromTranType = ttSalesOrder)) or
            ((ToTranType = ttSmartOrder) and (FromTranType = ttQuote)) then begin
            FieldByName('CustPONumber').AsString := MasterRecord.FieldByName('PONumber').AsString;
          end;

          if FindField('Invoiced') <> nil then begin
            FieldByName('Invoiced').AsBoolean := true;
          end;

//          if (FromTranType = ttUnitHire) and (ToTranType = ttInvoice) then begin
//            FieldByName('QtySold').AsFloat := 1;
//            FieldByName('Shipped').AsFloat := 1;
//            FieldByName('UnitofMeasureQtySold').AsFloat := 1;
//            FieldByName('UnitofMeasureShipped').AsFloat := 1;
//            FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
//            FieldByName('UseHedging').AsString := 'F';
//            FieldByName('ClonedFromID').AsInteger := 0;
//            FieldByName('msTimeStamp').AsDateTime := Now;
//          end;

          Post;
          sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
          Edit;

          {Append some calcs after the initial posting}
          AppendCalcFields(ftblInsert);

          if FindField('GlobalRef') <> nil then begin
            FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
          end;

//          if (FromTranType = ttRepair) and (ToTranType = ttInvoice) then begin
//            FieldByName('LineCost').AsCurrency := GetPartCost(DetailRecords.FieldByName('PartsID').AsInteger);
//            FieldByName('LineCostInc').AsCurrency := GetPartCost(DetailRecords.FieldByName('PartsID').AsInteger)
//              + (GetPartCost(DetailRecords.FieldByName('PartsID').AsInteger) * DetailRecords.FieldByName('TaxRate').AsFloat);
//
//            FieldByName('LinePrice').AsCurrency := DetailRecords.FieldByName('PriceEx').AsCurrency;
//            FieldByName('LinePriceInc').AsCurrency := DetailRecords.FieldByName('PriceInc').AsCurrency;
//            FieldByName('LineTax').AsFloat := (FieldByName('LinePrice').AsFloat * DetailRecords.FieldByName('TaxRate').AsFloat)
//              * DetailRecords.FieldByName('Qty').AsFloat;
//          end;

          Post;
          DetailRecords.Next;
        end;

        {Perform Accounting processing here}
        UpdateAccounts(sTableName, sForeignKey, FastFuncs.StrToInt(Result), ClientID,
          AppEnv.CompanyPrefs.DefaultSalesAccount, ToTranType);
      except
        on e: Exception do begin
          Audit.AddEntry(e, Self);
          foConnection.Rollback;
          raise;
        end;
      end;
    finally
      FreeandNil(qryDetailLines);
    end;
end;

function TTranConvertObj.GetPartListCost(const ID: integer): double;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT COST1 FROM tblparts WHERE PARTSID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('COST1').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

//function TTranConvertObj.GetPartCost(const ID: integer): double;
//var
//  qryTemp: TMyQuery;
//begin
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    qryTemp.Sql.Clear;
//    qryTemp.Sql.Add('SELECT AvgCost FROM tblparts WHERE PARTSID = ' + FastFuncs.IntToStr(ID) + ';');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      Result := qryTemp.FieldByName('AvgCost').AsFloat;
//    end else begin
//      Result := 0.00;
//    end;
//  finally
//    FreeAndNil(qryTemp);
//  end;
//end;

function TTranConvertObj.GetCustomer(const iClientID: integer): string;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT Company FROM tblClients ' +
        'WHERE ClientID = :xClientID');
      Params.ParamByName('xClientID').AsInteger := iClientID;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Company').AsString;
      end else begin
        //CommonLib.MessageDlgXP_Vista('Client ID does not Exist',
        //            mtWarning, [mbOK], 0);
        Result := '';
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TTranConvertObj.ConvertPhSupportToInvoice(const TranType: TTranType; const ClientID: integer;
  const MasterRecord: TDataset): string;
var
  qryParts: TMyQuery;
  sTableName: string;
  sForeignKey: string;

  procedure GetPartDetails(const PartName: string);
  begin
    with qryParts do begin
      Sql.Clear;
      Close;
      Sql.Add(Format('SELECT IncomeAccnt, AssetAccnt, COGSAccnt,PARTSID, PartName, ' +
        'PartsDescription, PartType, TaxCode,PRICE1, Rate ' +
        'FROM tblParts, tblTaxCodes WHERE (TaxCode = Name) and (PartName = %s)', [QuotedStr(PartName)]));
      Open;
      if IsEmpty then begin
        //raise ETranConvertError.Create(PartName + ' not found in tblParts. Cannot convert this transaction.');
        CommonLib.MessageDlgXP_Vista(PartName + ' not found in tblParts. Cannot convert this transaction.', mtError, [mbOK], 0);
      end;
    end;
  end;

  procedure InsertPhSupportLines;
  var
    i: integer;
    dTax, dPrice: double;
    sDetailID: string;
  const
    PhSupportParts: array[0..1] of string = ('Call Fee', 'Phone Support Fee');
  begin
    with ftblInsert do begin
      Close;
      TableName  := sTableName;
      Open;
      for i := 0 to 1 do begin
        Insert;
        GetPartDetails(PhSupportParts[i]);
        FieldByName(sForeignKey).AsString := Result;
        FieldByName('IncomeAccnt').AsString := qryParts.FieldByName('IncomeAccnt').AsString;
        FieldByName('AssetAccnt').AsString := qryParts.FieldByName('AssetAccnt').AsString;
        FieldByName('COGSAccnt').AsString := qryParts.FieldByName('COGSAccnt').AsString;
        FieldByName('PartType').AsString := qryParts.FieldByName('PartType').AsString;
        FieldByName('ProductID').AsString := qryParts.FieldByName('PARTSID').AsString;
        FieldByName('ProductName').AsString := qryParts.FieldByName('PartName').AsString;
        FieldByName('Product_Description').AsString := qryParts.FieldByName('PartsDescription').AsString;
        FieldByName('LineTaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
        FieldByName('LineTaxRate').AsFloat := qryParts.FieldByName('Rate').AsFloat;
        FieldByName('Invoiced').AsBoolean := true;
        dPrice := qryParts.FieldByName('PRICE1').AsFloat;
        FieldByName('OrgLinePrice').AsCurrency := dPrice;
        FieldByName('LinePrice').AsCurrency := dPrice;
        FieldByName('LinePriceInc').AsCurrency := RoundCurrency(GetAmountInc(dPrice,
          GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));


        if PhSupportParts[i] = 'Phone Support Fee' then begin
          FieldByName('QtySold').AsInteger := Trunc((MasterRecord.FieldByName('CallSecs').AsInteger / 60) + 1);
          FieldByName('Shipped').AsInteger := Trunc((MasterRecord.FieldByName('CallSecs').AsInteger / 60) + 1);
          FieldByName('UnitofMeasureQtySold').AsFloat := Trunc((MasterRecord.FieldByName('CallSecs').AsInteger / 60) + 1);;
          FieldByName('UnitofMeasureShipped').AsFloat := Trunc((MasterRecord.FieldByName('CallSecs').AsInteger / 60) + 1);;
          FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
          FieldByName('UnitofMeasureSaleLines').AsString := 'Units';
          FieldByName('UnitofMeasureID').asInteger := GetUnitOfMeasureID('Units' , FieldByName('ProductID').asInteger);
        end else begin
          FieldByName('QtySold').AsFloat := 1;
          FieldByName('Shipped').AsFloat := 1;
          FieldByName('UnitofMeasureQtySold').AsFloat := 1;
          FieldByName('UnitofMeasureShipped').AsFloat := 1;
          FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
          FieldByName('UnitofMeasureID').asInteger := GetUnitOfMeasureID('Units' , FieldByName('ProductID').asInteger);
          FieldByName('UnitofMeasureSaleLines').AsString := 'Units';
        end;

        FieldByName('TotalLineAmount').AsFloat := FieldByName('QtySold').AsInteger * FieldByName('LinePrice').AsFloat;
        FieldByName('TotalLineAmountInc').AsFloat := FieldByName('QtySold').AsInteger * FieldByName('LinePriceInc').AsFloat;
        dTax := FieldByName('TotalLineAmountInc').AsCurrency - FieldByName('TotalLineAmount').AsCurrency;
        FieldByName('LineTax').AsFloat := dTax;

        Post;
        sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
        Edit;
        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
        Post;
      end;
    end;
  end;
begin //--->>TTranConvertObj.ConvertPhSupportToInvoice - Yo, Yo, Yo UGLY!!!
  Result := '';
  fbIncludedInTransaction := true;
  Application.ProcessMessages;
  foConnection.StartTransaction;
  qryParts := TMyQuery.Create(nil);
  qryParts.Connection := foConnection;
  with ftblInsert do try
      try
        {First add the Master record}
        sTableName := TypeToMasterTableName(TranType);
        {Copies all fields with the same name}
        PrepareTableForInsert(MasterRecord, ftblInsert, sTableName);
        {Now Append all mapped fields to the Table}
        AppendMappedFields(MasterRecord, ftblInsert, true, ttPhSupportLog, TranType);
        FieldByName('AccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSalesAccount;
        FieldByName('SaleDate').AsDateTime := MasterRecord.FieldByName('DateCreated').AsDateTime;
        FieldByName('InvoiceTo').AsString := GetShippingAddress(ClientID);
        FieldByName('ShipTo').AsString := GetPhysicalAddress(ClientID);
        FieldByName('CustomerName').AsString := GetClientName(FieldByName('ClientID').AsInteger);
        FieldByName('ClassID').AsInteger := AppEnv.DefaultClass.ClassID;
        FieldByName('Class').AsString := GetClassName(AppEnv.DefaultClass.ClassID);
        Post;
        sForeignKey := GetIndexName(ftblInsert);
        Result := FieldByName(sForeignKey).AsString;
        Edit;
        AppendMasterValues(ftblInsert, Result, TranType);
        Post;
        sTableName := TypeToDetailTableName(TranType);
        InsertPhSupportLines;

        {Perform Accounting processing here}

        UpdateAccounts(sTableName, sForeignKey, FastFuncs.StrToInt(Result),
          MasterRecord.FieldByName('ClientID').AsInteger,
          AppEnv.CompanyPrefs.DefaultSalesAccount, TranType);

      except
        on e: Exception do begin
          Audit.AddEntry(e, Self);
          foConnection.Rollback;
          raise;
        end;
      end;
    finally
      FreeandNil(qryParts);
    end;
end;

function TTranConvertObj.ConvertManifestToBill(const ClientID: integer;
  const fBillTotal, fBillTotalInc, fTaxAmount: double): integer;
var
  adoMaster, adoDetails: TMyQuery;
  iPOID: integer;
begin
  adoDetails := nil;
  adoMaster := nil;
  try
    try
      // Set up the Bill Header.
      adoDetails := TMyQuery.Create(nil);
      adoMaster := TMyQuery.Create(nil);
      adoMaster.Connection := CommonDbLib.GetSharedMyDacConnection;
      adoDetails.Connection := CommonDbLib.GetSharedMyDacConnection;

      // Enter any ol bullcrud sql here so we get a free clear dataset.
      adoMaster.SQL.Text := 'SELECT * FROM tblpurchaseorders WHERE PurchaseOrderID = 0';
      adoDetails.SQL.Text := 'SELECT * FROM tblpurchaselines WHERE PurchaseLineID = 0';
      adoMaster.Open;
      adoDetails.Open;

      // Insert & Create BILL Header
      with adoMaster do begin
        Insert;
        FieldByName('AccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSPAAccount;
        FieldByName('Account').AsString := GetAccountName(AppEnv.CompanyPrefs.DefaultSPAAccount);
        FieldByName('ClientID').AsInteger := ClientID;
        FieldByName('SupplierName').AsString := GetClientName(ClientID);
        FieldByName('IsBill').AsString := 'T';
        FieldByName('TotalAmount').AsFloat := fBillTotal;
        FieldByName('TotalTax').AsFloat := fTaxAmount;
        FieldByName('TotalAmountInc').AsFloat := fBillTotalInc;
        FieldByName('InvoiceDate').AsDateTime := Now;
        FieldByName('OrderDate').AsDateTime := Now;
        Post;

        Edit;
        iPOID := FieldByName('PurchaseOrderID').AsInteger;
        FieldByName('PurchaseOrderNumber').AsInteger := iPOID;
        //FieldByName('OriginalNo').AsInteger := iPOID;
        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + FastFuncs.IntToStr(iPOID);
        FieldByName('OriginalNo').AsString := FieldByName('GlobalRef').AsString;
        Post;
      end;

      // Now import details into BILL form.
      with adoDetails do begin
        Insert;
        FieldByName('PurchaseOrderID').AsInteger := iPOID;

        // Use the account that the user has set in the company preferences.
        FieldByName('AccountNumber').AsInteger := AppEnv.CompanyPrefs.DefaultSPAAccount;
        FieldByName('AccountName').AsString := GetAccountName(AppEnv.CompanyPrefs.DefaultSPAAccount);
        FieldByName('Class').AsString := 'Default';
        FieldByName('ClassID').AsInteger := 1;
        FieldByName('TotalLineAmount').AsFloat := fBillTotal;
        FieldByName('TotalLineAmountInc').AsFloat := fBillTotalInc;
        FieldByName('Invoiced').AsString := 'T';
        FieldByName('LineCost').AsFloat := fBillTotal;
        FieldByName('LineTax').AsFloat := fTaxAmount;
        FieldByName('LineCostInc').AsFloat := fBillTotalInc;
        FieldByName('Product_Description').AsString := 'Sub-Contractor Payment Advice';
        Post;
        Edit;
        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + FieldByName('PurchaseLineID').AsString;
        Post;
      end;
      // Set function returncode.  Which is the Bill ID.
      Result := iPOID;
    except
      // Return 0 to indicate failure.
      Result := 0;
    end;
  finally
    // Free our used objects.
    FreeandNil(adoMaster);
    FreeandNil(adoDetails);
  end;
end;

//function TTranConvertObj.ConvertFuncBookingToSalesOrder(const TranType: TTranType; const ClientID: integer;
//  const MasterRecord, RoomRecords, MealRecords, DrinkRecords: TDataset): string;
//var
//  qryParts: TMyQuery;
//  sTableName, sDetailID: string;
//  sForeignKey: string;
//  dBookingExtras: currency;
//
//  procedure GetPartDetails(iProductID: integer);
//  begin
//    with qryParts do begin
//      Close;
//      Sql.Clear;
//      Sql.Add('SELECT IncomeAccnt, AssetAccnt, COGSAccnt,PARTSID, PartName, ' +
//        'PartsDescription, PartType, TaxCode, Rate ' + //UnitOfMeasureSales
//        'FROM tblParts, tblTaxCodes WHERE (TaxCode = Name AND tblTaxCodes.RegionID='+FastFuncs.IntToStr(AppEnv.RegionalOptions.RegionID)+') and (PartsID = ' +
//        FastFuncs.IntToStr(iProductID) + ')');
//      Open;
//      if IsEmpty then begin
//        //raise ETranConvertError.Create('Part not found in tblParts. Cannot convert this transaction.');
//        CommonLib.MessageDlgXP_Vista('Part not found in tblParts. Cannot convert this transaction.', mtError, [mbOK], 0);
//      end;
//    end;
//  end;
//
//  procedure SetFieldsFromPart(iProductID: integer);
//  begin
//    GetPartDetails(iProductID);
//    with ftblInsert do begin
//      FieldByName('IncomeAccnt').AsString := qryParts.FieldByName('IncomeAccnt').AsString;
//      FieldByName('AssetAccnt').AsString  := qryParts.FieldByName('AssetAccnt').AsString;
//      FieldByName('COGSAccnt').AsString   := qryParts.FieldByName('COGSAccnt').AsString;
//      FieldByName('PartType').AsString    := qryParts.FieldByName('PartType').AsString;
//      FieldByName('ProductID').AsString   := qryParts.FieldByName('PARTSID').AsString;
//      FieldByName('ProductName').AsString := qryParts.FieldByName('PartName').AsString;
//      FieldByName('Product_Description').AsString := qryParts.FieldByName('PartsDescription').AsString;
//      FieldByName('LineTaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
//      FieldByName('LineTaxRate').AsFloat  := qryParts.FieldByName('Rate').AsFloat;
//      FieldByName('UnitOfMeasureSaleLines').AsString := 'Units';
//    end;
//  end;
//
//
//  procedure InsertFuncBookingLines;
//  var
//    i: integer;
//    dTax, dPriceInc, dQty: double;
//    DetailRecords: array[0..1] of TDataSet;
//  const
//    PART_ROOM   = 'Room Booking';
//    PART_EXTRAS = 'Extras';
//  begin
//    DetailRecords[0] := MealRecords;
//    DetailRecords[1] := DrinkRecords;
//    with ftblInsert do begin
//      Close;
//      TableName  := 'tblSalesLines';
////      MaxRecords := 1;
//      Open;
//
//      // We go thru each of the rooms in the Room Records dataset (tblfuncroomallocations)
//      // .. and post the room booking detail record to tblsaleslines and then we post the
//      // .. meals & drinks for this room allocation.
//
//      RoomRecords.First;
//      while not RoomRecords.Eof do begin
//        // post the room booking
//        Insert;
//        FieldByName(sForeignKey).AsString := Result;
//
//        SetFieldsFromPart(GetPartID(PART_ROOM));
//        FieldByName('Product_Description').AsString :=
//          RoomRecords.FieldByName('RoomNameLookup').AsString + ' (' + RoomRecords.FieldByName('Start').AsString +
//          ' - ' + TimeToStr(RoomRecords.FieldByName('End').AsDateTime) + ')';
//        FieldByName('Invoiced').AsBoolean := true;
//        FieldByName('QtySold').AsFloat := 1;
//        FieldByName('Shipped').AsFloat := 1;
//        FieldByName('UnitofMeasureQtySold').AsFloat := 1;
//        FieldByName('UnitofMeasureShipped').AsFloat := 1;
//        FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
//
//        dPriceInc := RoundCurrency(RoomRecords.FieldByName('LinePriceInc').AsCurrency -
//          RoomRecords.FieldByName('Extras').AsCurrency);
//
//        FieldByName('OrgLinePrice').AsCurrency := GetAmountEx(dPriceInc, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
//        FieldByName('LinePrice').AsCurrency := GetAmountEx(dPriceInc, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
//        FieldByName('LinePriceInc').AsCurrency := dPriceInc;
//        dTax := FieldByName('LinePriceInc').AsCurrency - FieldByName('LinePrice').AsCurrency;
//        FieldByName('LineTax').AsFloat := dTax;
//        FieldByName('TotalLineAmount').AsFloat := FieldByName('LinePrice').AsFloat;
//        FieldByName('TotalLineAmountInc').AsFloat := dPriceInc;
//        Post;
//
//        sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
//        Edit;
//        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
//        Post;
//
//        // Post any room extras
//        if (RoomRecords.FieldByName('Extras').AsCurrency <> 0) then begin
//          Insert;
//          FieldByName(sForeignKey).AsString := Result;
//
//          SetFieldsFromPart(GetPartID(PART_EXTRAS));
//          FieldByName('Product_Description').AsString := 'Room Extras';
//          FieldByName('Invoiced').AsBoolean := true;
//          FieldByName('QtySold').AsFloat := 1;
//          FieldByName('Shipped').AsFloat := 1;
//          FieldByName('UnitofMeasureQtySold').AsFloat := 1;
//          FieldByName('UnitofMeasureShipped').AsFloat := 1;
//          FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
//
//          dPriceInc := RoomRecords.FieldByName('Extras').AsCurrency;
//
//          FieldByName('OrgLinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//            GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//          FieldByName('LinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//            GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//          FieldByName('LinePriceInc').AsCurrency := dPriceInc;
//          dTax := FieldByName('LinePriceInc').AsCurrency - FieldByName('LinePrice').AsCurrency;
//          FieldByName('LineTax').AsFloat := dTax;
//          FieldByName('TotalLineAmount').AsFloat := FieldByName('LinePrice').AsFloat;
//          FieldByName('TotalLineAmountInc').AsFloat := dPriceInc;
//          Post;
//          sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
//          Edit;
//          FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
//          Post;
//        end;
//
//        // now append meal and drink records for this room booking
//        for i := 0 to 1 do begin
//          DetailRecords[i].Filtered := false;
//          DetailRecords[i].Filter := 'RoomAllocationID = ' + QuotedStr(RoomRecords.FieldByName('RoomAllocationID').AsString);
//          DetailRecords[i].Filtered := true;
//
//          DetailRecords[i].First;
//          while not DetailRecords[i].Eof do begin
//            Insert;
//            FieldByName(sForeignKey).AsString := Result;
//            // Get the parts deatails and set appropriate fields in Sales Lines
//            SetFieldsFromPart(DetailRecords[i].FieldByName('ProductID').AsInteger);
//
//            dQty := DetailRecords[i].FieldByName('Qty').AsFloat;
//            FieldByName('QtySold').AsFloat := dQty;
//            FieldByName('Shipped').AsFloat := dQty;
//            FieldByName('Invoiced').AsBoolean := true;
//
//            FieldByName('UnitofMeasureQtySold').AsFloat := dQty;
//            FieldByName('UnitofMeasureShipped').AsFloat := dQty;
//            FieldByName('UnitOfMeasureSaleLines').AsString := 'Unit';
//            FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
//
//            dPriceInc := DivZer(DetailRecords[i].FieldByName('Price').AsCurrency, dQty);
//
//            FieldByName('OrgLinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//              GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//            FieldByName('LinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//              GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//            FieldByName('LinePriceInc').AsCurrency := dPriceInc;
//            dTax := FieldByName('LinePriceInc').AsCurrency - FieldByName('LinePrice').AsCurrency;
//            FieldByName('LineTax').AsFloat := dTax;
//            FieldByName('TotalLineAmount').AsFloat := DetailRecords[i].FieldByName('Price').AsCurrency - dTax * dQty;
//            FieldByName('TotalLineAmountInc').AsFloat := DetailRecords[i].FieldByName('Price').AsCurrency;
//
//            Post;
//            sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
//            Edit;
//            if FindField('GlobalRef') <> nil then begin
//              FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
//            end;
//
//            Post;
//            DetailRecords[i].Next;
//          end;
//          DetailRecords[i].Filtered := false;
//        end;  // for i := 0 to 1
//        RoomRecords.Next;
//      end; // while not RoomRecords.Eof
//
//      // Post any Booking extras
//      if (dBookingExtras <> 0) then begin
//        Insert;
//        FieldByName(sForeignKey).AsString := Result;
//
//        SetFieldsFromPart(GetPartID(PART_EXTRAS));
//        FieldByName('Product_Description').AsString := 'Booking Extras';
//        FieldByName('Invoiced').AsBoolean := true;
//        FieldByName('QtySold').AsFloat := 1;
//        FieldByName('Shipped').AsFloat := 1;
//        FieldByName('UnitofMeasureQtySold').AsFloat := 1;
//        FieldByName('UnitofMeasureShipped').AsFloat := 1;
//        FieldByName('UnitofMeasureMultiplier').AsFloat := 1;
//
//        dPriceInc := dBookingExtras;  // cuz i'm lazy
//
//        FieldByName('OrgLinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//          GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//        FieldByName('LinePrice').AsCurrency := RoundCurrency(GetAmountEx(dPriceInc,
//          GetTaxRate(qryParts.FieldByName('TaxCode').AsString)));
//        FieldByName('LinePriceInc').AsCurrency := dPriceInc;
//        dTax := FieldByName('LinePriceInc').AsCurrency - FieldByName('LinePrice').AsCurrency;
//        FieldByName('LineTax').AsFloat := dTax;
//        FieldByName('TotalLineAmount').AsFloat := FieldByName('LinePrice').AsFloat;
//        FieldByName('TotalLineAmountInc').AsFloat := dPriceInc;
//        Post;
//        sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
//        Edit;
//        FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + sDetailID;
//        Post;
//      end;
//    end;
//  end;
//begin //--->>TTranConvertObj.ConvertFuncBookingToSalesOrder - Yo, Yo, Yo - How Ugly?
//      // You know what a smashed roo looks like?  Well .. No where near that LOL.
//  Result := '';
//  fbIncludedInTransaction := true;
//  Application.ProcessMessages;
//  foConnection.StartTransaction;
//  qryParts := TMyQuery.Create(nil);
//  qryParts.Connection := foConnection;
//  with ftblInsert do try
//      try
//        {First add the Master record}
//        sTableName := TypeToMasterTableName(TranType);
//
//        {Copies all fields with the same name}
//        PrepareTableForInsert(MasterRecord, ftblInsert, sTableName);
//
//        {Now Append all mapped fields to the Table}
//        AppendMappedFields(MasterRecord, ftblInsert, true, ttFuncBooking, TranType);
//
//        dBookingExtras := MasterRecord.FieldByName('Extras').AsCurrency;
//        FieldByName('AccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSalesAccount;
//        FieldByName('SaleDate').AsDateTime := DateOf(MasterRecord.FieldByName('EndBooking').AsDateTime);
//        FieldByName('Class').AsString := GetClassName(MasterRecord.FieldByName('ClassID').AsInteger);
//        FieldByName('ClientID').AsInteger := ClientID;
//        FieldByName('CustomerName').AsString := GetClientName(ClientID);
//        Post;
//
//        sForeignKey := GetIndexName(ftblInsert);
//        Result := FieldByName(sForeignKey).AsString;
//
//        Edit;
//        AppendMasterValues(ftblInsert, Result, TranType);
//        Post;
//        // sTableName := TypeToDetailTableName(TranType); //lots of detail tables
//        InsertFuncBookingLines;
//
//        {Perform Accounting processing here}
//
//        UpdateAccounts('tblsaleslines', sForeignKey, FastFuncs.StrToInt(Result),
//          //MasterRecord.FieldByName('CusID').AsInteger,
//          ClientID, AppEnv.CompanyPrefs.DefaultSalesAccount, TranType);
//
//      except
//        on e: Exception do begin
//          Audit.AddEntry(e, Self);
//          foConnection.Rollback;
//          raise;
//        end;
//      end;
//    finally
//      FreeandNil(qryParts);
//    end;
//end;

procedure TTranConvertObj.PrintTemplateReport(const ReportName, SQLPortion: string;
  const DoPrint: boolean; const Copies: integer; AOwner: TControl);
var
  Templates: TReportTemplates;
begin
  if not empty(ReportName) then begin
    Templates := TReportTemplates.Create;
    with Templates do try
        with GetMyQuery(1) do begin
          Close;
          Sql.Clear;
          Sql.Add(GetSQLForReport(ReportName));

          {The calling object has supplied the entire SQL string b/c of it's complexity}
          if fbReportSQLSupplied then begin
            Sql.Clear;
          end;

          Sql.Add(SQLPortion);
          Open;
        end;

        try
          ReportStream.Position := 0;
          Report.Template.LoadFromStream(ReportStream);
          Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;
          if DoPrint then Report.DeviceType := 'Printer';

          if Copies > 1 then begin
            Report.PrinterSetup.Copies := Copies;
          end;

          if not DoPrint then Report.OnPageRequest := ReportPageRequest;

          Try
            Report.Print;
          except
            on E: Exception do begin
              If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;

        except
          CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.', mtError, [mbOK], 0);
        end;

      finally
        // Free our used objects.
        if Assigned(Templates) then
          FreeandNil(Templates);
      end;
  end;
end;


end.

