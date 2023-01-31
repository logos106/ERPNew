unit ForeignExchangeObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 09/05/05  1.00.01 IJB  Fixed hedging formula, added GetHedgedAmountForRate
  //                        and GetForeignExchangeRatesForDate (currencyCode).



  //------------------------------------------------------------------------------
  //  Hedging Formula
  //  This is used in Foreign Sales where there is an agreed foreign sell price
  //  (Product Foreign Sell Price), the hedge formula is used to vary this sell
  //  price if the exchange rate varies by more than an agreed percentage from
  //  a fixed reference exchange rate. The hedge formual is as follows:
  //
  //  Hedged_Foreign_Amount =
  //    ((Fixed_Rate x Foreign_Amount x Fixed_Rate_Percent) / Actual_Rate) +
  //    (Foreign_Amount x Actual_Rate_Percent)
  //
  //  Example:
  //  Foreign sell price: USD 100.00
  //  Actual exchange rate: 0.74 (banks Buy rate, see note below)
  //  Hedge Formula Settings:
  //    Variance: 3%
  //    Fixed rate: 0.70
  //    Fixed rate percent: 80%
  //    Actual rate percent: 20%
  //
  //  The 3% variance gives a range of 0.70 +/- 3% = 0.679 to 0.721
  //  The actual rate of 0.74 is outside this range so we apply the hedging
  //  formula:
  //
  //  Hedged_Foreign_Amount =
  //    ((0.70 x 100.00 x 0.80) / 0.74) +
  //    (100 x 0.20) = USD 95.68
  //
  //  So based on these figures the customers actual price is USD 95.68
  //
  //  Exchange Rate Note:
  //  In ERP we record two foreign exchange rates, a buy rate and a sell rate
  //  these are used as follows:
  //  Sell Rate - This is the rate that the bank will sell a foreign currency
  //              to us. This is used in foreign purchase orders as we have
  //              to buy the currency from the bank to pay the foreign supplier.
  //  Buy Rate -  This is the rate that the bank will buy a foreign currency
  //              from us. This is used in foreign sales as we have sell the
  //              foreign currency we have been paid in to the bank.
  //------------------------------------------------------------------------------


interface

uses
  DB, DBAccess, MyAccess,ERPdbComponents, MyClasses, SysUtils;

type
  TForeignExchangeObj = class(TObject)
  private
    foMyDACConnection: TERPConnection;
    procedure EstablishConnection(const DataSet: TCustomDASQL);
    procedure GetCurrentForeignExchangeRates(const CurrencyID: integer; var BuyRate: double; var SellRate: double);
    function PercentageDiffRate(const FixedRate, ActualRate: double): double;
    procedure GetForeignExchangeHedgingInfo(const CurrencyID: integer;
      var FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double); overload;
    procedure GetForeignExchangeHedgingInfo(const CurrencyCode: string;
      var FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double); overload;
  public
    function GetHedgingFormulaPrice(const CurrencyID: integer; const FixedPriceEx: double;
      const TransDate: TDateTime): double;
    function GetHedgedAmountForRate(const Amount: double; const CurrencyID: integer; const Rate: double): double; overload;
    function GetHedgedAmountForRate(const Amount: double; const CurrencyCode: string; const Rate: double): double; overload;
    procedure GetForeignExchangeRatesForDate(const CurrencyID: integer; const RateDate: TDateTime;
      var BuyRate: double; var SellRate: double); overload;
    procedure GetForeignExchangeRatesForDate(const CurrencyCode: string; const RateDate: TDateTime;
      var BuyRate: double; var SellRate: double); overload;
    function GetForeignExchangeCode(const CurrencyID: integer): string;
    function GetCurrencyID(const ForeignExchangeCode: string): integer;
    procedure AddForeignExchangeRateHistory(const CurrencyID: integer; const BuyRate: double;
      const SellRate: double; const ModDate: TDateTime);
    procedure UpdateForeignExchangeRateHistory(const CurrencyID: integer; const BuyRate: double;
      const SellRate: double; const ModDate: TDateTime);
    property MyDACConnection: TERPConnection read foMyDACConnection write foMyDACConnection;
  end;

implementation

uses
  CommonDbLib, DnmLib, MySQLConst;

{ TForeignExchangeObj }

procedure TForeignExchangeObj.EstablishConnection(const DataSet: TCustomDASQL);
begin
  with DataSet do begin
    if Assigned(foMyDACConnection) then begin
      Connection := foMyDACConnection;
    end else begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
    end;
  end;
end;


procedure TForeignExchangeObj.AddForeignExchangeRateHistory(const CurrencyID: integer;
  const BuyRate: double; const SellRate: double; const ModDate: TDateTime);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  with qryTemp do try
      EstablishConnection(qryTemp);
      Sql.Add('INSERT HIGH_PRIORITY INTO tblcurrencyconversionhistory (CurrencyID,Code,Date,BuyRate,SellRate) VALUES ');
      Sql.Add('(:xCurrencyID,:xCode,:xDate,:xBuyRate,:xSellRate); ');
      Params.ParamByName('xCurrencyID').AsInteger := CurrencyID;
      Params.ParamByName('xCode').AsString := GetForeignExchangeCode(CurrencyID);
      Params.ParamByName('xDate').AsDateTime := ModDate;
      Params.ParamByName('xBuyRate').AsFloat := BuyRate;
      Params.ParamByName('xSellRate').AsFloat := SellRate;
      try
        Execute;
      except
        UpdateForeignExchangeRateHistory(CurrencyID, BuyRate, SellRate, ModDate);
      end;
    finally
      FreeAndNil(qryTemp);
    end;
end;

procedure TForeignExchangeObj.UpdateForeignExchangeRateHistory(const CurrencyID: integer;
  const BuyRate, SellRate: double; const ModDate: TDateTime);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  with qryTemp do try
      EstablishConnection(qryTemp);
      Sql.Add('UPDATE tblcurrencyconversionhistory  ');
      Sql.Add('SET BuyRate =' + QuotedStr(FloatToStr(BuyRate)) + ' , SellRate =' + QuotedStr(FloatToStr(SellRate)) + ' ');
      Sql.Add('WHERE `Code` = ' + QuotedStr(GetForeignExchangeCode(CurrencyID)) + ' AND `Date` = ' +
        QuotedStr(FormatDateTime(MysqlDateFormat, ModDate)) + ';');
      try
        Execute;
      except
      end;
    finally
      FreeAndNil(qryTemp);
    end;
end;

function TForeignExchangeObj.GetForeignExchangeCode(const CurrencyID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyID, Code FROM tblcurrencyconversion WHERE CurrencyID = ' + IntToStr(CurrencyID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('Code').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TForeignExchangeObj.GetCurrencyID(const ForeignExchangeCode: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyID,Code FROM tblcurrencyconversion WHERE Code = ' + QuotedStr(ForeignExchangeCode) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('CurrencyID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TForeignExchangeObj.GetForeignExchangeRatesForDate(const CurrencyID: integer;
  const RateDate: TDateTime; var BuyRate, SellRate: double);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyHistoryID,Code,Date,BuyRate,SellRate FROM tblcurrencyconversionhistory ');
    qry.SQL.Add('WHERE Active="T" AND Code = ' + QuotedStr(GetForeignExchangeCode(CurrencyID)) + ' ');
    qry.SQL.Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, RateDate)) + ' ');
    qry.SQL.Add('Order BY Date DESC Limit 1;');
    qry.Open;
    if qry.RecordCount > 0 then begin
      qry.First;
      BuyRate := qry.FieldByName('BuyRate').AsFloat;
      SellRate := qry.FieldByName('SellRate').AsFloat;
    end else begin
      GetCurrentForeignExchangeRates(CurrencyID, BuyRate, SellRate);
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TForeignExchangeObj.GetForeignExchangeRatesForDate(const CurrencyCode: string;
  const RateDate: TDateTime; var BuyRate, SellRate: double);
var
  CurrencyId: integer;
begin
  CurrencyId := GetCurrencyId(CurrencyCode);
  GetForeignExchangeRatesForDate(CurrencyId, RateDate, BuyRate, SellRate);
end;

procedure TForeignExchangeObj.GetCurrentForeignExchangeRates(const CurrencyID: integer; var BuyRate, SellRate: double);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyID,Code,BuyRate,SellRate FROM tblcurrencyconversion WHERE CurrencyID = ' +
      IntToStr(CurrencyID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      BuyRate := qry.FieldByName('BuyRate').AsFloat;
      SellRate := qry.FieldByName('SellRate').AsFloat;
    end else begin
      BuyRate := 1.00;
      SellRate := 1.00;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TForeignExchangeObj.PercentageDiffRate(const FixedRate, ActualRate: double): double;
begin
  Result := Abs(Trunc(DivZer((FixedRate - ActualRate), FixedRate) * 100));
end;

procedure TForeignExchangeObj.GetForeignExchangeHedgingInfo(const CurrencyID: integer;
  var FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyID,FixedRate,UpperVariation,LowerVariation,TriggerPriceVariation FROM tblcurrencyconversion WHERE CurrencyID = ' +
      IntToStr(CurrencyID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      FixedRate := qry.FieldByName('FixedRate').AsFloat;
      FixedRatePercent := qry.FieldByName('UpperVariation').AsFloat;
      ActualRatePercent := qry.FieldByName('LowerVariation').AsFloat;
      TriggerPriceVariation := qry.FieldByName('TriggerPriceVariation').AsFloat;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TForeignExchangeObj.GetForeignExchangeHedgingInfo(const CurrencyCode: string;
  var FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT CurrencyID,FixedRate,UpperVariation,LowerVariation,TriggerPriceVariation FROM tblcurrencyconversion WHERE Code = ' +
      QuotedStr(CurrencyCode) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      FixedRate := qry.FieldByName('FixedRate').AsFloat;
      FixedRatePercent := qry.FieldByName('UpperVariation').AsFloat;
      ActualRatePercent := qry.FieldByName('LowerVariation').AsFloat;
      TriggerPriceVariation := qry.FieldByName('TriggerPriceVariation').AsFloat;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TForeignExchangeObj.GetHedgingFormulaPrice(const CurrencyID: integer; const FixedPriceEx: double;
  const TransDate: TDateTime): double;
var
  ActualSellRate, ActualBuyRate, FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double;
begin
  GetForeignExchangeHedgingInfo(CurrencyID, FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation);
  GetForeignExchangeRatesForDate(CurrencyID, TransDate, ActualBuyRate, ActualSellRate);
  if (PercentageDiffRate(FixedRate, ActualBuyRate) > TriggerPriceVariation) then begin
    Result := (Divzer((FixedRate * FixedPriceEx * DivZer(FixedRatePercent, 100)), ActualBuyRate)) +
      (FixedPriceEx * DivZer(ActualRatePercent, 100));
  end else begin
    Result := FixedPriceEx;
  end;
end;

function TForeignExchangeObj.GetHedgedAmountForRate(const Amount: double; const CurrencyID: integer;
  const Rate: double): double;
var
  FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation: double;
begin
  GetForeignExchangeHedgingInfo(CurrencyID, FixedRate, FixedRatePercent, ActualRatePercent, TriggerPriceVariation);
  if (PercentageDiffRate(FixedRate, Rate) > TriggerPriceVariation) then begin
    Result := (Divzer((FixedRate * Amount * DivZer(FixedRatePercent, 100)), Rate)) + (Amount * DivZer(ActualRatePercent, 100));
  end else begin
    Result := Amount;
  end;
end;

function TForeignExchangeObj.GetHedgedAmountForRate(const Amount: double; const CurrencyCode: string;
  const Rate: double): double;
var
  FixedRate, UpperVariation, LowerVariation, TriggerPriceVariation: double;
begin
  GetForeignExchangeHedgingInfo(CurrencyCode, FixedRate, UpperVariation, LowerVariation, TriggerPriceVariation);
  if (PercentageDiffRate(FixedRate, Rate) > TriggerPriceVariation) then begin
    Result := (Divzer((FixedRate * Amount * DivZer(UpperVariation, 100)), Rate)) + (Amount * DivZer(LowerVariation, 100));
  end else begin
    Result := Amount;
  end;
end;

end.

