unit BatchInvoiceCreationObj;

interface

uses
  MyAccess, DB, Variants, AccountingObj, DnmLib;

type
  TBatchInvoiceCreationObj = class(TObject)
  private
    ftblInsert: TMyTable;
    fiClassID: integer;
    foConnection: TMyConnection;
    foAccounting: TAccountingObj;
    function GetIndexName(const tbl: TMyTable): string;
    procedure PrepareTableForInsert(const SourceTable: TDataset; const DestTable: TMyTable; const sTableName: string);
    function RetrieveDetailTransactions(const sTableName, sMasterKeyName: string; const MasterID: integer): TMyQuery;
    procedure AppendMasterValues(const MasterRecord: TDataset; const NewID: string; const TranType: TTranType);
    procedure AppendGenericMasterValues(const ds: TDataset; const TranType: TTranType; const iNewID: integer; const Globalref:STring);
    procedure UpdateAccounts(const TableName, MasterKeyName: string; const KeyID, ClientID, AccountID: integer;  const TranType: TTranType);
    procedure ChangesCustomerDetails(const ds: TDataset; const ClientID: integer);
    function GetShippingAddress(const ClientID: integer): string;
    function GetPhysicalAddress(const ClientID: integer): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateInvoice(const SalesID, ClientID: integer; const InvoiceMasterRecord, InvoiceDetailRecords: TDataset);
  end;

implementation

uses
  DNMExceptions, SysUtils, AuditObj, Controls, Dialogs, CommonDbLib, BranchObj, DefaultClassObj,
  DBLocation, Forms, AppDatabase;

constructor TBatchInvoiceCreationObj.Create;
begin
  inherited Create;
  foConnection := TMyConnection.Create(nil);
  foConnection.LoginPrompt := false;
  CommonDbLib.SetMyDacConnection(foConnection, AppDb.Database) ;
  foConnection.Connected := true;
  ftblInsert := TMyTable.Create(nil);
  ftblInsert.Connection := foConnection;
  foAccounting := TAccountingObj.CreateWithTranControl(foConnection);
end;

destructor TBatchInvoiceCreationObj.Destroy;
begin
  ftblInsert.Close;
  ftblInsert.Free;
  foConnection.Free;
  foAccounting.Free;
  inherited;
end;

procedure TBatchInvoiceCreationObj.CreateInvoice(const SalesID, ClientID: integer;
  const InvoiceMasterRecord, InvoiceDetailRecords: TDataset);
var
  iNewMasterID: integer;
  TranType: TTranType;
  sTableName, sDetailID: string;
  sForeignKey: string;
  iClientID: integer;
  iAccountID: integer;
begin
  TranType := ttInvoice;
  Application.ProcessMessages;
  with ftblInsert do try
      {First add the Master record}
      sTableName := TypeToMasterTableName(TranType);
      {Copies all fields with the same name}
      PrepareTableForInsert(InvoiceMasterRecord, ftblInsert, sTableName);
      Post;
      sForeignKey := GetIndexName(ftblInsert);
      iNewMasterID := FieldByName(sForeignKey).AsInteger;
      Edit;
      AppendMasterValues(ftblInsert, IntToStr(iNewMasterID), TranType);
      ChangesCustomerDetails(ftblInsert, ClientID);
      Post;
      iClientID := ftblInsert.FieldByName('ClientID').AsInteger;
      iAccountID := ftblInsert.FieldByName('AccountID').AsInteger;

      {Now add the detail lines}
      InvoiceDetailRecords.First;
      while not InvoiceDetailRecords.Eof do begin
        sTableName := TypeToDetailTableName(TranType);
        {Copies all fields with the same name}
        PrepareTableForInsert(InvoiceDetailRecords, ftblInsert, sTableName);
        FieldByName(sForeignKey).AsInteger := iNewMasterID;
        Post;
        sDetailID := FieldByName(GetIndexName(ftblInsert)).AsString;
        Edit;
        if FindField('GlobalRef') <> nil then begin
          FieldByName('GlobalRef').AsString := Branch.SiteCode + sDetailID;
        end;
        Post;
        InvoiceDetailRecords.Next;
      end;

      {Perform Accounting processing here}
      UpdateAccounts(TypeToDetailTableName(TranType), TypeToMasterPKName(TranType), iNewMasterID,
        iClientID, iAccountID, TranType);

    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        raise;
      end;
    end;
end;

procedure TBatchInvoiceCreationObj.AppendMasterValues(const MasterRecord: TDataset; const NewID: string;
  const TranType: TTranType);
begin
  MasterRecord.FieldByName('GlobalRef').AsString := Branch.SiteCode + NewID;
  if MasterRecord.FindField('ClassID') <> nil then begin
    fiClassID := MasterRecord.FieldByName('ClassID').AsInteger;
  end else begin
    fiClassID := DefaultClass.ClassID;
  end;
  AppendGenericMasterValues(MasterRecord, TranType, StrToInt(NewID), MasterRecord.FieldByName('GlobalRef').AsString);
end;

procedure TBatchInvoiceCreationObj.AppendGenericMasterValues(const ds: TDataset; const TranType: TTranType;
  const iNewID: integer; const Globalref:STring);
begin
  with ds do begin
    FieldByName('EditedFlag').AsString    := 'T';
    FieldByName('Paid').AsString          := 'F';
    FieldByName('Payment').AsFloat        := 0.00;
    //FieldByName('OriginalNo').AsInteger   := iNewID;
    FieldByName('OriginalNo').asString   := Globalref;
    FieldByName('Deleted').AsBoolean      := false;
    FieldByName('InvoiceDocNumber').AsInteger := iNewID;
    FieldByName('IsPOS').AsBoolean        := (TranType = ttPOS);
    FieldByName('IsRefund').AsBoolean     := (TranType = ttRefund);
    FieldByName('IsCashSale').AsBoolean   := (TranType = ttCashSale);
    FieldByName('IsInvoice').AsBoolean    := (TranType = ttInvoice);
    FieldByName('IsQuote').AsBoolean      := (TranType = ttQuote);
    FieldByName('IsSalesOrder').AsBoolean := (TranType = ttSalesOrder);
    FieldByName('IsLayby').AsBoolean      := false;
  end;
end;

procedure TBatchInvoiceCreationObj.UpdateAccounts(const TableName, MasterKeyName: string;
  const KeyID, ClientID, AccountID: integer; const TranType: TTranType);
var
  qryDetailLines: TMyQuery;
begin
  qryDetailLines := RetrieveDetailTransactions(TableName, MasterKeyName, KeyID);
  try
    foAccounting.UpdateQuantityLines(fiClassID, qryDetailLines);
    {Update the client balance if the trantype isn't a cash sale}
    if (TranType <> ttCashSale) and (TranType <> ttCheque) then begin
      foAccounting.UpdateClientBalance(ClientID, ClientID, nil, qryDetailLines);
    end;
    foAccounting.UpdateMasterChartofAccounts(AccountID, 0, 'Tax Collected', nil, qryDetailLines);
    foAccounting.UpdateDetailChartOfAccounts(nil, qryDetailLines);
  finally
    qryDetailLines.Free;
  end;
end;

function TBatchInvoiceCreationObj.RetrieveDetailTransactions(const sTableName, sMasterKeyName: string;
  const MasterID: integer): TMyQuery;
begin
  Result := TMyQuery.Create(nil);
  with Result do begin
    Connection := foConnection;
    Sql.Add(Format('SELECT * FROM %s WHERE %s = %d', [sTableName, sMasterKeyName, MasterID]));
    Open;
    if IsEmpty then begin
      raise ETranConvertError.Create('Detail transactions not found. Cannot convert this transaction.');
    end;
  end;
end;

procedure TBatchInvoiceCreationObj.PrepareTableForInsert(const SourceTable: TDataset;
  const DestTable: TMyTable; const sTableName: string);
var
  iIndex: integer;
  sKeyName: string;
begin
  with DestTable do begin
    Close;
    TableName  := sTableName;
    MaxRecords := 1;
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
            FieldByName(SourceTable.Fields[iIndex].FieldName).AsVariant := SourceTable.Fields[iIndex].AsVariant;
          end;
        end;
      end;
    end;
  end;
end;

function TBatchInvoiceCreationObj.GetIndexName(const tbl: TMyTable): string;
var
  iCnt: integer;
begin
  Result := '';
  with tbl do begin
    IndexDefs.Update;
    for iCnt := 0 to IndexDefs.Count - 1 do begin
      if UpperCase(IndexDefs[iCnt].Name) = 'PRIMARY' then begin
        Result := IndexDefs[iCnt].Fields;
      end;
    end;
  end;

  if Empty(Result) then begin
    raise Exception.Create('Primary Key not found in Dataset');
  end;
end;

procedure TBatchInvoiceCreationObj.ChangesCustomerDetails(const ds: TDataset; const ClientID: integer);
var
  sShipAddress: string;
begin
  sShipAddress := GetShippingAddress(ClientID);
  with ds do begin
    FieldByName('CustomerName').AsString := GetClientName(ClientID);
    FieldByName('ClientID').AsInteger    := ClientID;
    FieldByName('InvoiceTo').AsString    := FieldByName('CustomerName').AsString + #13 + #10 + GetPhysicalAddress(ClientID);
    if Empty(sShipAddress) then begin
      FieldByName('ShipTo').AsString := FieldByName('InvoiceTo').AsString;
    end else begin
      FieldByName('ShipTo').AsString := FieldByName('CustomerName').AsString + #13 + #10 + GetShippingAddress(ClientID);;
    end;
    FieldByName('PickupFrom').AsString := FieldByName('ShipTo').AsString;
  end;
end;

function TBatchInvoiceCreationObj.GetPhysicalAddress(const ClientID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if not (ClientID = 0) then begin
      qryTemp.Sql.Add('SELECT ClientID,Street, Street2, Suburb, State, Postcode,Country  FROM tblclients ');
      qryTemp.Sql.Add('Where ClientID=' + IntToStr(ClientID) + ';');
      qryTemp.Active := true;
    end;
    if not qryTemp.IsEmpty then begin
      Result := ReplaceStr(qryTemp.FieldByName('Street').AsString + #13 + #10 +
        qryTemp.FieldByName('Street2').AsString + #13 + #10 + qryTemp.FieldByName('Suburb').AsString +
        ' ' + qryTemp.FieldByName('State').AsString + ' ' + qryTemp.FieldByName('PostCode').AsString +
        #13 + #10 + qryTemp.FieldByName('Country').AsString, #13 + #10 + #13 + #10, #13 + #10);
    end else begin
      Result := '';
    end;
  finally
    qryTemp.Free;
  end;
end;

function TBatchInvoiceCreationObj.GetShippingAddress(const ClientID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if not (ClientID = 0) then begin
      qryTemp.Sql.Add('SELECT ClientID,BillStreet,BillStreet2,BillSuburb,BillState,BillPostCode,BillCountry FROM tblclients ');
      qryTemp.Sql.Add('Where ClientID=' + IntToStr(ClientID) + ';');
      qryTemp.Active := true;
    end;
    if not qryTemp.IsEmpty then begin
      Result := ReplaceStr(qryTemp.FieldByName('BillStreet').AsString + #13 + #10 +
        qryTemp.FieldByName('BillStreet2').AsString + #13 + #10 + qryTemp.FieldByName('BillSuburb').AsString +
        ' ' + qryTemp.FieldByName('BillState').AsString + ' ' + qryTemp.FieldByName('BillPostCode').AsString +
        #13 + #10 + qryTemp.FieldByName('BillCountry').AsString, #13 + #10 + #13 + #10, #13 + #10);
    end else begin
      Result := '';
    end;
  finally
    qryTemp.Free;
  end;
end;


end.
