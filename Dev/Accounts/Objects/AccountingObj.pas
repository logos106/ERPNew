unit AccountingObj;
           
{ML 7/2002 - This object is used to update related transactional based accounting procedures}
{The bulk of this objects functionality relates to tblSalesLines & tblPurchaseLines, therefore
it is tightly coupled with field names from these two tables. Be careful using this object
for any accounting purposes beyond these two tables}

{Personal Note :- If the Customers/Suppliers Balance is negative, then we owe them money. If positive,
it's obviously the opposite}

interface

uses
  MyAccess, DB;

type
  TAccountingObj = class(TObject)
  private
    foMyDacConnection: TCustomMyConnection;
    fiSign: integer;
    fbSaleOrderQty: boolean;
    fbdoLog :boolean;
    procedure EstablishConnection(Const qry: TMyQuery);
    function GetChartOfAccountsByNameSQL: string;
    function GetChartOfAccountsByIDSQL: string;
    function GetClientSOBalSQL: string;
    function GetClientARBalSQL: string;
    function GetClientAPBalSQL: string;
    function GetClientBalSQL: string;
    function GetQuantityLineSQL: string;
    function GetQuantityLineOldValSQL: string;
    function GetINVBOQuantityLineSQL: string;    
    function GetSign: integer;
  protected

  public
    {Use this constructor to create the object inside a transaction. Shouldn't need to explicitly
    create this object if your class descends from TBaseInputGUI, because it is automatically
    created}
    constructor CreateWithTranControl(const TranConnection: TCustomMyConnection);

    {**Assign nil to OldValueRecords if no old values to update. Applies to all methods
    containing OldValueRecords**}

    {Update the quantitylines with the detail records only, no old values}
    procedure UpdateQuantityLines(const ClassID: integer; const DetailRecords: TDataset); overload;
    {Update the quantitylines with the detail records and provide old value support}
    procedure UpdateQuantityLines(const ClassID: integer; const OldValueRecords, DetailRecords: TDataset); overload;
    {Update the quantitylines with the specified value, can be negative or positive depending
    on your needs.}
    procedure UpdateQuantityLines(const ClassID, PartID: integer; const Qty: double); overload;
    procedure UpdateINVBOQuantityLines(const ClassID, PartID: integer; const Qty: double); overload;

    {Update the quantitylines, however, this is only for removing the salesorderqty, eg. Converting
    SO to Invoice}
    procedure RemoveSalesOrdersQuantityLines(const ClassID: integer; const DetailRecords: TDataset);

    {Updates the clients outstanding balance using Old and new balances}
    procedure UpdateClientBalance(const ClientID, OldClientID: integer; const OldValueRecords, DetailRecords: TDataset);
      overload;
    {Updates the clients ourstanding balance by ONLY providing a payment amount, no old values}
    procedure UpdateClientBalance(const ClientID: integer; const PaymentAmount: currency); overload;

    {Updates the clients Sales Order outstanding balance using Old and new balances}
    procedure UpdateClientSOBalance(const ClientID: integer; const OldValueRecords, DetailRecords: TDataset); overload;
    {Updates the clients Sales Order ourstanding balance by ONLY providing a payment amount, no old values}
    procedure UpdateClientSOBalance(const ClientID: integer; const PaymentAmount: currency); overload;

    procedure UpdateClientARBalance(const ClientID: integer; const PaymentAmount: currency);
    procedure UpdateClientAPBalance(const ClientID: integer; const PaymentAmount: currency);

    procedure UpdateWETTaxTotal(const SalesID: integer; const DetailRecords: TDataset);


    {Updates the Chart of accounts table that the master record has been associated with. Also
    updates the tax account according to the type of transaction}
    procedure UpdateMasterChartofAccounts(const MasterAccountID, OldMasterAccountID: integer;
      const TaxAccountName: string; const OldValueRecords, DetailRecords: TDataset); overload;
    procedure UpdateMasterChartofAccounts(const AccountID: integer; const DiffAmount: currency); overload;

    {returns the value of 'INV' parts}
    function GetValueofParts(const Asset: boolean; const DetailRecords: TDataset): double;

    {Updates the Chart of accounts table with relevant Detail data}
    procedure UpdateDetailChartOfAccounts(const OldValueRecords, DetailRecords: TDataset); overload;
    procedure UpdateDetailChartOfAccounts(const IsExpense: boolean; const OldValueRecords, DetailRecords: TDataset);
      overload;
    {1 = Positive, -1 = negative}
    property Sign: integer read GetSign write fiSign default 1;

    {Update the quantitylines For Salesorderqty}
    property SaleOrderQty: boolean read fbSaleOrderQty write fbSaleOrderQty;
  end;


implementation

uses
  SysUtils, Classes, Forms, CommonDbLib, DnMlib, CommonLib, FastFuncs,
  LogLib;

constructor TAccountingObj.CreateWithTranControl(const TranConnection: TCustomMyConnection);
begin
  inherited Create;
  foMyDacConnection := TranConnection;
  fbdoLog := False;
end;

procedure TAccountingObj.EstablishConnection(Const qry: TMyQuery);
begin
  If Not Assigned(qry) then Exit;
  with qry do begin
    if Assigned(foMyDacConnection) then begin
      Connection := foMyDacConnection;
    end else begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
    end;
  end;
end;

function TAccountingObj.GetChartOfAccountsByNameSQL: string;
begin
  Result := 'UPDATE tblChartofAccounts ' + 'SET Balance = Balance + :xBalance ' + 'WHERE AccountName = %s';
end;

function TAccountingObj.GetChartOfAccountsByIDSQL: string;
begin
  Result := 'UPDATE tblChartofAccounts ' + 'SET Balance = Balance + :xBalance ' + 'WHERE AccountID = %d';
end;

function TAccountingObj.GetClientBalSQL: string;
begin
  Result := 'UPDATE tblClients ' + 'SET Balance = Balance + :xBalance ' + 'WHERE ClientID = %d';
end;

function TAccountingObj.GetClientSOBalSQL: string;
begin
  Result := 'UPDATE tblClients ' + 'SET SOBalance = SOBalance + :xSOBalance ' + 'WHERE ClientID = %d';
end;

function TAccountingObj.GetQuantityLineSQL: string;
begin
  if not fbSaleOrderQty then begin
    Result := 'UPDATE tblPartQtyLines ' + 'SET InStockQty = InStockQty - %f ' + 'WHERE (ClassID = %d) AND ' +
      '(ProductID = %d)';
  end else begin
    Result := 'UPDATE tblPartQtyLines ' + 'SET SalesOrdersQty = SalesOrdersQty + %f ' +
      'WHERE (ClassID = %d) AND ' + '(ProductID = %d)';
  end;
end;

function TAccountingObj.GetINVBOQuantityLineSQL: string;
begin
  Result := 'UPDATE tblPartQtyLines ' + 'SET InvoiceBOQty = InvoiceBOQty + %f ' + 'WHERE (ClassID = %d) AND ' +
    '(ProductID = %d)';
end;

function TAccountingObj.GetQuantityLineOldValSQL: string;
begin
  Result := 'UPDATE tblPartQtyLines ' + 'SET InStockQty = InStockQty - %f, ' +
    'InvoiceBOQty = InvoiceBOQty - %f, ' + 'OnOrderQty = OnOrderQty - %f, ' + 'SalesOrdersQty = SalesOrdersQty - %f ' +
    'WHERE (ClassID = %d) AND ' + '(ProductID = %d)';
end;

procedure TAccountingObj.UpdateQuantityLines(const ClassID: integer; const DetailRecords: TDataset);
var
  qryQuantities: TMyQuery;
begin
  qryQuantities := TMyQuery.Create(Application);
  with qryQuantities do try
      EstablishConnection(qryQuantities);
      DetailRecords.DisableControls;
      try
        DetailRecords.First;
        while not DetailRecords.Eof do begin
          Sql.Clear;
          if DetailRecords.FindField('PartType') <> nil then begin {PartType is in the detail records}
            if IsInvProduct(DetailRecords.FieldByName('PartType').AsString) then begin
              Sql.Add(Format(GetQuantityLineSQL, [DetailRecords.FieldByName('Shipped').AsFloat,
                ClassID, DetailRecords.FieldByName('ProductID').AsInteger]));
              try
                Execute;
                if fbdoLog then Log(SQL.TExt);
              except
              end;
              {when the SO is invoiced, the instockqty gets updated not the BOqty }
              if DetailRecords.FindField('BackOrder') <> nil then
                UpdateINVBOQuantityLines(ClassId, DetailRecords.FieldByName('ProductID').AsInteger,
                  DetailRecords.FieldByName('BackOrder').AsFloat);
            end;
          end else begin {PartType isn't in the detail records, proceed to examine dataset}
            if IsInvProduct(DetailRecords.FieldByName('PartTyp').AsString) then begin
              if DetailRecords.FindField('Qty') <> nil then begin
                Sql.Add(Format(GetQuantityLineSQL, [Sign * DetailRecords.FieldByName('Qty').AsFloat,
                  ClassID, DetailRecords.FieldByName('ProductID').AsInteger]));
                try
                  Execute;
                  if fbdoLog then Log(SQL.TExt);
                except
                end;
                {when the SO is invoiced, the instockqty gets updated not the BOqty }
                if DetailRecords.FindField('BackOrder') <> nil then
                  UpdateINVBOQuantityLines(ClassId, DetailRecords.FieldByName('ProductID').AsInteger,
                    DetailRecords.FieldByName('BackOrder').AsFloat);
              end;
            end;
          end;
          DetailRecords.Next;
        end;
      finally
        DetailRecords.EnableControls;
      end;
    finally
      Free;
    end;
end;

procedure TAccountingObj.UpdateQuantityLines(const ClassID: integer; const OldValueRecords, DetailRecords: TDataset);
var
  qryQuantities: TMyQuery;
begin
  qryQuantities := TMyQuery.Create(Application);
  with qryQuantities do try
      EstablishConnection(qryQuantities);

      {Post the oldvalues if they've been provided}
      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.First;
        while not OldValueRecords.Eof do begin
          if IsInvProduct(OldValueRecords.FieldByName('PartType').AsString) then begin
            Sql.Clear;
            Sql.Add(Format(GetQuantityLineOldValSQL, [-OldValueRecords.FieldByName('Shipped').AsFloat,
              - OldValueRecords.FieldByName('BackOrder').AsFloat, 0.00, 0.00,
              ClassID, OldValueRecords.FieldByName('ProductID').AsInteger]));
            try
              Execute;
              if fbdoLog then Log(SQL.TExt);
            except
            end;
          end;
          OldValueRecords.Next;
        end;
      end;

      {Now post the new bigger and better values}
      DetailRecords.DisableControls;
      try
        DetailRecords.First;
        while not DetailRecords.Eof do begin
           if IsInvProduct(DetailRecords.FieldByName('PartType').AsString) then begin            
            Sql.Clear;
            Sql.Add(Format(GetQuantityLineOldValSQL, [DetailRecords.FieldByName('Shipped').AsFloat,
              DetailRecords.FieldByName('BackOrder').AsFloat, 0.00, 0.00,
              ClassID, DetailRecords.FieldByName('ProductID').AsInteger]));
            try
              Execute;
              if fbdoLog then Log(SQL.TExt);
            except
            end;
          end;
          DetailRecords.Next;
        end;
      finally
        DetailRecords.EnableControls;
      end;
    finally
      FreeandNil(qryQuantities);
    end;
end;

procedure TAccountingObj.UpdateQuantityLines(const ClassID, PartID: integer; const Qty: double);
var
  qryQuantities: TMyQuery;
begin
  qryQuantities := TMyQuery.Create(Application);
  with qryQuantities do try
      EstablishConnection(qryQuantities);
      Sql.Clear;
      Sql.Add(Format(GetQuantityLineSQL, [Qty, ClassID, PartID]));
      try
        Execute;
        if fbdoLog then Log(SQL.TExt);
      except
      end;
    finally
      FreeandNil(qryQuantities);
    end;
end;

procedure TAccountingObj.RemoveSalesOrdersQuantityLines(const ClassID: integer; const DetailRecords: TDataset);
var
  qryQuantities: TMyQuery;
begin
  qryQuantities := TMyQuery.Create(Application);
  with qryQuantities do try
      EstablishConnection(qryQuantities);

      {Post the oldvalues if they've been provided}
      if (DetailRecords <> nil) and not (DetailRecords.IsEmpty) then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
             if IsInvProduct(DetailRecords.FieldByName('PartType').AsString) then begin
              Sql.Clear;
              Sql.Add(Format(GetQuantityLineOldValSQL, [0.00, 0.00, 0.00,
                DetailRecords.FieldByName('Shipped').AsFloat,
                ClassID, DetailRecords.FieldByName('ProductID').AsInteger]));
              try
                Execute;
                if fbdoLog then Log(SQL.TExt);
              except
              end;
            end;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;
      end;
    finally
      FreeandNil(qryQuantities);
    end;
end;

procedure TAccountingObj.UpdateClientBalance(const ClientID, OldClientID: integer;
  const OldValueRecords, DetailRecords: TDataset);
var
  dOldTotalIncAmount, dNewTotalIncAmount: currency;
  qryUpdateClientBal: TMyQuery;
begin
  dOldTotalIncAmount := 0;
  dNewTotalIncAmount := 0;
  qryUpdateClientBal := TMyQuery.Create(Application);
  with qryUpdateClientBal do try
      EstablishConnection(qryUpdateClientBal);
      Sql.Add(Format(GetClientBalSQL, [OldClientID]));

      {Remove OLD values if they've been provided}
      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.DisableControls;
        try
          OldValueRecords.First;
          while not OldValueRecords.Eof do begin
            dOldTotalIncAmount := dOldTotalIncAmount + OldValueRecords.FieldByName('TotalLineAmountInc').AsFloat;
            OldValueRecords.Next;
          end;
        finally
          OldValueRecords.EnableControls;
        end;
        {If its a Sale transaction decrease the Balance, otherwise increase the balance}
        if OldValueRecords.FindField('SaleLineID') <> nil then begin  {Found SaleLineID}
          ParamByName('xBalance').AsFloat := RoundCurrency(-dOldTotalIncAmount);
        end else begin {Must be a Purchase transaction}
          ParamByName('xBalance').AsFloat := RoundCurrency(dOldTotalIncAmount);
        end;
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;

      Sql.Clear;
      Sql.Add(Format(GetClientBalSQL, [ClientID]));

      {Now post the new records}
      DetailRecords.First;
      if not DetailRecords.IsEmpty then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
            dNewTotalIncAmount := dNewTotalIncAmount + DetailRecords.FieldByName('TotalLineAmountInc').AsFloat;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;

        {If its a Sale transaction increase the Balance, otherwise decrease the balance as it's a supplier}
        if DetailRecords.FindField('SaleLineID') <> nil then begin
          ParamByName('xBalance').AsFloat := RoundCurrency(dNewTotalIncAmount);
        end else begin
          ParamByName('xBalance').AsFloat := RoundCurrency(-dNewTotalIncAmount);
        end;
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;
    finally
      FreeandNil(qryUpdateClientBal);
    end;
end;

procedure TAccountingObj.UpdateClientBalance(const ClientID: integer; const PaymentAmount: currency);
var
  qryUpdateClientBal: TMyQuery;
begin
  qryUpdateClientBal := TMyQuery.Create(Application);
  with qryUpdateClientBal do try
      EstablishConnection(qryUpdateClientBal);
      Sql.Add(Format(GetClientBalSQL, [ClientID]));
      ParamByName('xBalance').AsFloat := RoundCurrency(PaymentAmount);
      try
        Execute;
        if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
      except
      end;
    finally
      FreeandNil(qryUpdateClientBal);
    end;
end;

procedure TAccountingObj.UpdateClientSOBalance(const ClientID: integer; const OldValueRecords, DetailRecords: TDataset);
var
  dOldTotalIncAmount, dNewTotalIncAmount: currency;
  qry: TMyQuery;
begin
  dOldTotalIncAmount := 0;
  dNewTotalIncAmount := 0;
  qry := TMyQuery.Create(Application);
  with qry do try
      EstablishConnection(qry);
      Sql.Add(Format(GetClientSOBalSQL, [ClientID]));

      {Remove OLD values if they've been provided}
      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.DisableControls;
        try
          OldValueRecords.First;
          while not OldValueRecords.Eof do begin
            dOldTotalIncAmount := dOldTotalIncAmount + OldValueRecords.FieldByName('TotalLineAmountInc').AsFloat;
            OldValueRecords.Next;
          end;
        finally
          OldValueRecords.EnableControls;
        end;


        // Decrease the Balance
        ParamByName('xSOBalance').AsFloat := RoundCurrency(-dOldTotalIncAmount);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xSOBalance' , floattoStr(ParamByName('xSOBalance').AsFloat)));
        except
        end;
      end;

      {Now post the new records}
      DetailRecords.First;
      if not DetailRecords.IsEmpty then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
            dNewTotalIncAmount := dNewTotalIncAmount + DetailRecords.FieldByName('TotalLineAmountInc').AsFloat;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;

        {Increase the Balance}
        ParamByName('xSOBalance').AsFloat := RoundCurrency(dNewTotalIncAmount);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xSOBalance' , floattoStr(ParamByName('xSOBalance').AsFloat)));
        except
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TAccountingObj.UpdateClientSOBalance(const ClientID: integer; const PaymentAmount: currency);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(Application);
  with qry do try
      EstablishConnection(qry);
      Sql.Add(Format(GetClientSOBalSQL, [ClientID]));

      ParamByName('xSOBalance').AsFloat := RoundCurrency(PaymentAmount);
      try
        Execute;
        if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xSOBalance' , floattoStr(ParamByName('xSOBalance').AsFloat)));
      except
      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TAccountingObj.UpdateMasterChartofAccounts(const MasterAccountID, OldMasterAccountID: integer;
  const TaxAccountName: string; const OldValueRecords, DetailRecords: TDataset);
var
  dOldTotalIncAmount, dNewTotalIncAmount: currency;
  qryChartOfAccounts: TMyQuery;

  procedure UpdateTaxAmount;
  var
    dOldTotalTax, dNewTotalTax: double;
  begin
    dOldTotalTax := 0;
    dNewTotalTax := 0;
    with qryChartOfAccounts do begin
      Sql.Clear;
      Sql.Add(Format(GetChartOfAccountsByNameSQL, [QuotedStr(TaxAccountName)]));

      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.DisableControls;
        try
          OldValueRecords.First;
          while not OldValueRecords.Eof do begin
            if FastFuncs.SameText(TaxAccountName, 'Tax Collected') and (OldValueRecords.FindField('LineTaxCode') <> nil) and
              FastFuncs.SameText(OldValueRecords.FieldByName('LineTaxCode').AsString, 'WC') then begin
              {WEG}
              dOldTotalTax := dOldTotalTax + RoundCurrency((OldValueRecords.FieldByName('Shipped').AsFloat *
                OldValueRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WEG'));
            end else begin
              dOldTotalTax := dOldTotalTax + RoundCurrency(OldValueRecords.FieldByName('LineTax').AsFloat);
            end;
            OldValueRecords.Next;
          end;
        finally
          OldValueRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(-dOldTotalTax);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;

      if not DetailRecords.IsEmpty then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
            if FastFuncs.SameText(TaxAccountName, 'Tax Collected') and (DetailRecords.FindField('LineTaxCode') <> nil) and
              FastFuncs.SameText(DetailRecords.FieldByName('LineTaxCode').AsString, 'WC') then begin
              {WEG}
              dNewTotalTax := dNewTotalTax + RoundCurrency((DetailRecords.FieldByName('Shipped').AsFloat *
                DetailRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WEG'));
            end else begin
              dNewTotalTax := dNewTotalTax + RoundCurrency(DetailRecords.FieldByName('LineTax').AsFloat);
            end;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(dNewTotalTax);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;
    end;
  end; // UpdateTaxAmount

  procedure UpdateWET_TaxAmount;
  var
    dOldTotalTax, dNewTotalTax: double;
  begin
    dOldTotalTax := 0;
    dNewTotalTax := 0;
    with qryChartOfAccounts do begin
      Sql.Clear;
      Sql.Add(Format(GetChartOfAccountsByNameSQL, [QuotedStr('WET')]));

      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.DisableControls;
        try
          OldValueRecords.First;
          while not OldValueRecords.Eof do begin
            if FastFuncs.SameText(TaxAccountName, 'Tax Collected') and (OldValueRecords.FindField('LineTaxCode') <> nil) and
              FastFuncs.SameText(OldValueRecords.FieldByName('LineTaxCode').AsString, 'WC') then begin
              {WET}
              dOldTotalTax := dOldTotalTax + RoundCurrency((OldValueRecords.FieldByName('Shipped').AsFloat *
                OldValueRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WET'));
            end;
            OldValueRecords.Next;
          end;
        finally
          OldValueRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(-dOldTotalTax);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;

      if not DetailRecords.IsEmpty then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
            if FastFuncs.SameText(TaxAccountName, 'Tax Collected') and (DetailRecords.FindField('LineTaxCode') <> nil) and
              FastFuncs.SameText(DetailRecords.FieldByName('LineTaxCode').AsString, 'WC') then begin
              {WET}
              dNewTotalTax := dNewTotalTax + RoundCurrency((DetailRecords.FieldByName('Shipped').AsFloat *
                DetailRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WET'));
            end;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(dNewTotalTax);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;
    end;
  end; // UpdateWET_TaxAmount
begin  //---->UpdateMasterChartofAccounts
  dOldTotalIncAmount := 0;
  dNewTotalIncAmount := 0;
  qryChartOfAccounts := TMyQuery.Create(Application);
  with qryChartOfAccounts do try
      EstablishConnection(qryChartOfAccounts);
      Sql.Add(Format(GetChartOfAccountsByIDSQL, [OldMasterAccountID]));

      {Remove the old values first, if present}
      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        OldValueRecords.DisableControls;
        try
          OldValueRecords.First;
          while not OldValueRecords.Eof do begin
            dOldTotalIncAmount := dOldTotalIncAmount + OldValueRecords.FieldByName('TotalLineAmountInc').AsFloat;
            OldValueRecords.Next;
          end;
        finally
          OldValueRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(-dOldTotalIncAmount);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;

      Sql.Clear;
      Sql.Add(Format(GetChartOfAccountsByIDSQL, [MasterAccountID]));

      if not DetailRecords.IsEmpty then begin
        DetailRecords.DisableControls;
        try
          DetailRecords.First;
          while not DetailRecords.Eof do begin
            dNewTotalIncAmount := dNewTotalIncAmount + DetailRecords.FieldByName('TotalLineAmountInc').AsFloat;
            DetailRecords.Next;
          end;
        finally
          DetailRecords.EnableControls;
        end;

        ParamByName('xBalance').AsFloat := RoundCurrency(dNewTotalIncAmount);
        try
          Execute;
          if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
        except
        end;
      end;
      {Update the tax accounts with relevant data}
      UpdateTaxAmount;
      {Update the WET tax accounts with relevant data}
      UpdateWET_TaxAmount;

    finally
      FreeandNil(qryChartOfAccounts);
    end;
end;

procedure TAccountingObj.UpdateMasterChartofAccounts(const AccountID: integer; const DiffAmount: currency);
var
  qryChartOfAccounts: TMyQuery;
begin
  qryChartOfAccounts := TMyQuery.Create(Application);
  with qryChartOfAccounts do try
      EstablishConnection(qryChartOfAccounts);
      Sql.Add(Format(GetChartOfAccountsByIDSQL, [AccountID]));

      ParamByName('xBalance').AsFloat := RoundCurrency(DiffAmount);
      try
        Execute;
        if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
      except
      end;
    finally
      FreeandNil(qryChartOfAccounts);
    end;
end;

function TAccountingObj.GetValueofParts(const Asset: boolean; const DetailRecords: TDataset): double;
begin
  Result := 0;
  DetailRecords.First;
  while not DetailRecords.Eof do begin
    if ( Asset) and (IsInvProduct(DetailRecords.FieldByName('PartTyp').AsString)) then
      Result :=
        Result + RoundCurrency(DetailRecords.FieldByName('avgCost').AsFloat * DetailRecords.FieldByName('Qty').AsFloat)
    else if (not Asset) and (IsInvProduct(DetailRecords.FieldByName('PartTyp').AsString)) then
      Result := Result + RoundCurrency(DetailRecords.FieldByName('Cost1').AsFloat * DetailRecords.FieldByName('Qty').AsFloat);
    DetailRecords.Next;
  end;
end;

procedure TAccountingObj.UpdateDetailChartOfAccounts(const OldValueRecords, DetailRecords: TDataset);
var
  qryDetailChartOfAccounts: TMyQuery;

  procedure UpdateChartOfAccountValues(Const bOldVals: boolean; Const Dataset: TDataset);
  var
    dCOGS, dAsset, dIncome: currency;
    sPartType: string;
  begin
    Dataset.DisableControls;
    try
      Dataset.First;
      while not Dataset.Eof do begin
        sPartType := FastFuncs.UpperCase(Dataset.FieldByName('PartType').AsString);
        with qryDetailChartOfAccounts do begin
            {Only need to update COGS if the parttype is INV but always update the
             Income account if transaction relates to sales}
          if Dataset.FindField('SaleLineID') <> nil then begin
            {Update the first account Cost of Goods Sold}
            If IsInvProduct(sPartType) then begin
              Sql.Add(Format(GetChartOfAccountsByNameSQL,
                [QuotedStr(Dataset.FieldByName('CogsAccnt').AsString)]));
              dCOGS := Dataset.FieldByName('Shipped').AsFloat * Dataset.FieldByName('LineCost').AsFloat;
              {If OldVals, decrease COGS, otherwise increase COGS}
              if bOldVals then begin
                ParamByName('xBalance').AsFloat := RoundCurrency(-dCOGS);
              end else begin
                ParamByName('xBalance').AsFloat := RoundCurrency(dCOGS);
              end;
              try
                Execute;
                if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
              except
              end;
              Sql.Clear;
            end;

            {Update the second account, Asset Account}
            If IsInvProduct(sPartType) then begin
              Sql.Add(Format(GetChartOfAccountsByNameSQL,
                [QuotedStr(Dataset.FieldByName('AssetAccnt').AsString)]));
              dAsset := Dataset.FieldByName('Shipped').AsFloat * Dataset.FieldByName('LineCost').AsFloat;
                {If it's a Sale Tran, increase Asset Account if OldVals, otherwise
                decrease Asset Account}
              if Dataset.FindField('SaleLineID') <> nil then begin
                if bOldVals then begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(dAsset);
                end else begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(-dAsset);
                end;
              end else begin
                  {It's a Purchase Tran, decrease Asset Account if OldVals, otherwise
                  increase Asset Account}
                if bOldVals then begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(-dAsset);
                end else begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(dAsset);
                end;
              end;
              try
                Execute;
                if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
              except
              end;
              Sql.Clear;
            end;

            {Update the third account, Income Account}
            Sql.Add(Format(GetChartOfAccountsByNameSQL,
              [QuotedStr(Dataset.FieldByName('IncomeAccnt').AsString)]));
            if Dataset.FindField('LinePrice') = nil then begin
              dIncome := Dataset.FieldByName('Shipped').AsFloat * Dataset.FieldByName('LineCost').AsFloat;
            end else begin
              dIncome := Dataset.FieldByName('Shipped').AsFloat * Dataset.FieldByName('LinePrice').AsFloat;
            end;
            {If OldVals, decrease Income Acct, otherwise increase Income Acct}
            if bOldVals then begin
              ParamByName('xBalance').AsFloat := RoundCurrency(-dIncome);
            end else begin
              ParamByName('xBalance').AsFloat := RoundCurrency(dIncome);
            end;
            try
              Execute;
              if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
            except
            end;
            Sql.Clear;
          end else begin {It's a purchase related transaction, if the PartType is NonInv
              update the COGS accnt}
            if (sPartType = 'NONINV') then begin
              Sql.Add(Format(GetChartOfAccountsByNameSQL,
                [QuotedStr(Dataset.FieldByName('CogsAccnt').AsString)]));
              dCOGS := Dataset.FieldByName('COGSTotalLineAmount').AsFloat;
              {If OldVals, decrease COGS, otherwise increase COGS}
              if bOldVals then begin
                ParamByName('xBalance').AsFloat := RoundCurrency(-dCOGS);
              end else begin
                ParamByName('xBalance').AsFloat := RoundCurrency(dCOGS);
              end;
              try
                Execute;
                if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
              except
              end;
              Sql.Clear;
            end;
            {PO COGS ADJUSTMENT}
            If (IsInvProduct(sPartType)) and
              (Dataset.FieldByName('COGSTotalLineAmountInc').AsFloat <> Dataset.FieldByName('TotalLineAmount').AsFloat) then begin
              Sql.Add(Format(GetChartOfAccountsByNameSQL,
                [QuotedStr(Dataset.FieldByName('CogsAccnt').AsString)]));
              dCOGS := Dataset.FieldByName('COGSTotalLineAmount').AsFloat;
              {If OldVals, decrease COGS, otherwise increase COGS}
              if bOldVals then begin
                ParamByName('xBalance').AsFloat := RoundCurrency(-dCOGS);
              end else begin
                ParamByName('xBalance').AsFloat := RoundCurrency(dCOGS);
              end;
              try
                Execute;
                if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
              except
              end;
              Sql.Clear;
            end;

            {Update the Second account, Asset Account}
            If IsInvProduct(sPartType) then begin 
              Sql.Add(Format(GetChartOfAccountsByNameSQL,
                [QuotedStr(Dataset.FieldByName('AssetAccnt').AsString)]));
              dAsset := Dataset.FieldByName('TotalLineAmount').AsFloat - Dataset.FieldByName('COGSTotalLineAmount').AsFloat;

                {If it's a Sale Tran, increase Asset Account if OldVals, otherwise
                decrease Asset Account}
              if Dataset.FindField('SaleLineID') <> nil then begin
                if bOldVals then begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(dAsset);
                end else begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(-dAsset);
                end;
              end else begin
                  {It's a Purchase Tran, decrease Asset Account if OldVals, otherwise
                  increase Asset Account}
                if bOldVals then begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(-dAsset);
                end else begin
                  ParamByName('xBalance').AsFloat := RoundCurrency(dAsset);
                end;
              end;
              try
                Execute;
                if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
              except
              end;
              Sql.Clear;
            end;
          end;
        end;
        Dataset.Next;
      end;
    finally
      Dataset.EnableControls;
    end;
  end;
begin  //--->>UpdateDetailChartOfAccounts
  qryDetailChartOfAccounts := TMyQuery.Create(Application);
  with qryDetailChartOfAccounts do try
      EstablishConnection(qryDetailChartOfAccounts);

      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        {Update the chart of accounts with the old values first}
        UpdateChartOfAccountValues(true, OldValueRecords);
      end;
      {Now update with the new values}
      UpdateChartOfAccountValues(false, DetailRecords);
    finally
      FreeandNil(qryDetailChartOfAccounts);
    end;
end;

procedure TAccountingObj.UpdateDetailChartOfAccounts(const IsExpense: boolean;
  const OldValueRecords, DetailRecords: TDataset);
var
  qryDetailChartOfAccounts: TMyQuery;

  procedure UpdateChartOfAccountValues(Const bOldVals: boolean; Const DetailRecords: TDataset);
  var
    dBalance: currency;
  begin
    DetailRecords.DisableControls;
    try
      DetailRecords.First;
      while not DetailRecords.Eof do begin
        with qryDetailChartOfAccounts do begin
          Sql.Add(Format(GetChartOfAccountsByNameSQL,
            [QuotedStr(DetailRecords.FieldByName('AccountName').AsString)]));
          dBalance := DetailRecords.FieldByName('LineCost').AsFloat;
          {It's a Purchase Expense tran, decrease Account balance if OldVals, otherwise
          increase Account balance}
          if bOldVals then begin
            ParamByName('xBalance').AsFloat := RoundCurrency(-dBalance);
          end else begin
            ParamByName('xBalance').AsFloat := RoundCurrency(dBalance);
          end;
          try
            Execute;
            if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xBalance' , floattoStr(ParamByName('xBalance').AsFloat)));
          except
          end;
          Sql.Clear;
        end;
        DetailRecords.Next;
      end;
    finally
      DetailRecords.EnableControls;
    end;
  end;
begin  //--->>UpdateDetailChartOfAccounts
  qryDetailChartOfAccounts := TMyQuery.Create(Application);
  with qryDetailChartOfAccounts do try
      EstablishConnection(qryDetailChartOfAccounts);

      if (OldValueRecords <> nil) and not (OldValueRecords.IsEmpty) then begin
        {Update the chart of accounts with the old values first}
        UpdateChartOfAccountValues(true, OldValueRecords);
      end;
      {Now update with the new values}
      UpdateChartOfAccountValues(false, DetailRecords);
    finally
      FreeandNil(qryDetailChartOfAccounts);
    end;
end;

function TAccountingObj.GetSign: integer;
begin
  if (fiSign < -1) or (fiSign > 1) then begin
    Result := 1;
  end else begin
    Result := fiSign;
  end;
end;

procedure TAccountingObj.UpdateINVBOQuantityLines(const ClassID, PartID: integer; const Qty: double);
var
  qryQuantities: TMyQuery;
begin
  qryQuantities := TMyQuery.Create(Application);
  with qryQuantities do try
      EstablishConnection(qryQuantities);
      Sql.Clear;
      Sql.Add(Format(GetINVBOQuantityLineSQL, [Qty, ClassID, PartID]));
      try
        Execute;
        if fbdoLog then Log(SQL.TExt);
      except
      end;
    finally
      FreeandNil(qryQuantities);
    end;
end;

procedure TAccountingObj.UpdateWETTaxTotal(const SalesID: integer; const DetailRecords: TDataset);
var
  dTotalWETTax: double;
  dTotalWEGTax: double;
  qry: TMyQuery;
begin
  dTotalWETTax := 0;
  dTotalWEGTax := 0;
  if not DetailRecords.IsEmpty then begin
    DetailRecords.DisableControls;
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := TMyQuery(DetailRecords).Connection;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM tblSales WHERE SaleID = ' + FastFuncs.IntToStr(SalesID) + ';');
      qry.Open;
      DetailRecords.First;
      while not DetailRecords.Eof do begin
        if FastFuncs.SameText(DetailRecords.FieldByName('LineTaxCode').AsString, 'WC') then begin
          {WET}
          dTotalWETTax := dTotalWETTax + RoundCurrency((DetailRecords.FieldByName('Shipped').AsFloat *
            DetailRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WET'));
          {WEG}
          dTotalWEGTax := dTotalWEGTax + RoundCurrency((DetailRecords.FieldByName('Shipped').AsFloat *
            DetailRecords.FieldByName('LinePrice').AsFloat) * GetTaxRate('WEG'));
        end;
        DetailRecords.Next;
      end;
      if qry.RecordCount = 1 then begin
        qry.Edit;
        qry.FieldByName('TotalWEGTax').AsFloat := dTotalWEGTax;
        qry.FieldByName('TotalWETTax').AsFloat := dTotalWETTax;
        qry.Post;
      end;
    finally
      FreeAndNil(qry);
      DetailRecords.EnableControls;
    end;
  end;
end;

procedure TAccountingObj.UpdateClientAPBalance(const ClientID: integer; const PaymentAmount: currency);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(Application);
  with qry do try
      EstablishConnection(qry);
      Sql.Add(Format(GetClientAPBalSQL, [ClientID]));
      ParamByName('xAPBalance').AsFloat := RoundCurrency(PaymentAmount);
      try
        Execute;
        if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xAPBalance' , floattoStr(ParamByName('xAPBalance').AsFloat)));
      except
      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TAccountingObj.UpdateClientARBalance(const ClientID: integer; const PaymentAmount: currency);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(Application);
  with qry do try
      EstablishConnection(qry);
      Sql.Add(Format(GetClientARBalSQL, [ClientID]));
      ParamByName('xARBalance').AsFloat := RoundCurrency(PaymentAmount);
      try
        Execute;
        if fbdoLog then Log(ReplaceStr(SQL.TExt , ':xARBalance' , floattoStr(ParamByName('xARBalance').AsFloat)));
      except
      end;
    finally
      FreeAndNil(qry);
    end;
end;

function TAccountingObj.GetClientAPBalSQL: string;
begin
  Result := 'UPDATE tblClients ' + 'SET APBalance = APBalance + :xAPBalance ' + 'WHERE ClientID = %d';
end;

function TAccountingObj.GetClientARBalSQL: string;
begin
  Result := 'UPDATE tblClients ' + 'SET ARBalance = ARBalance + :xARBalance ' + 'WHERE ClientID = %d';
end;

end.

