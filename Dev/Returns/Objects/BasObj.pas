unit BasObj;

{$I ERP.inc}
interface

uses
  SysUtils,   DB, Classes, MyAccess,ERPdbComponents, DBCtrls,
  Generics.Collections, BusobjReturns, ReturnObj;

type


  TBASBookmarkList = class(TList<TBookmark>)
  end;

  TBASObj = class(TReturnObj)
  private

    DebitsField: string;
    CreditsField: string;
    CashField: string;
    FilterStr: string;
    function TaxAmounts: double;
    function AccountAmounts(const AccountsList:TStringList = nil): double;

    procedure RecalcItem(AccountsFieldName:string;AmountFieldName:string;BasID:integer);
    procedure RecalcTaxItem(AccountsFieldName:string;AmountFieldName:string;BasID:integer);
    function OwnerformConnection: TERPConnection;
    function DefaultSalesTaxRate: Double;
  protected
  public
    procedure RefreshCalcFields;Override;
    procedure Calc;
    procedure Initialize;Override;
    procedure RecalcAllW(BasID:integer);
    procedure RecalcAllG(BasID:integer);
    procedure RecalcPAYG(BasID:integer);

  end;

implementation

uses CommonLib, tcTypes,
    CommonDbLib, CashBasis, AppEnvironment, MySQLConst, dialogs, tcDataUtils,
  SyncReportTableObj, ReturnsBase, frmNZReturn, frmBASReturn,  DNMLib,
  FastFuncs, tcConst;

{ TBASObj }

procedure TBASObj.RecalcPAYG(BasID:integer);
begin
    RecalcItem('T1Selected','T1',BasID);
end;


procedure TBASObj.RecalcAllW(BasID:integer);
begin
    RecalcItem('W1Selected','W1',BasID);
    RecalcItem('W2Selected','W2',BasID);
    RecalcItem('W3Selected','W3',BasID);
    RecalcItem('W4Selected','W4',BasID);
    RefreshCalcFields;
end;

procedure TBASObj.RecalcAllG(BasID:integer);
begin
    RecalcTaxItem('G1Selected','G1',BasID);
    RecalcTaxItem('G2Selected','G2',BasID);
    RecalcTaxItem('G3Selected','G3',BasID);
    RecalcTaxItem('G4Selected','G4',BasID);

    RecalcTaxItem('G7Selected','G7',BasID);
    RecalcTaxItem('G10Selected','G10',BasID);
    RecalcTaxItem('G11Selected','G11',BasID);
    RecalcTaxItem('G13Selected','G13',BasID);
    RecalcTaxItem('G14Selected','G14',BasID);
    RecalcTaxItem('G15Selected','G15',BasID);
    RecalcTaxItem('G18Selected','G18',BasID);
    RefreshCalcFields;
end;

Function TBASObj.OwnerformConnection :TERPConnection;
begin
  REsult := nil;
  if assigned(OwnerForm) then
  if OwnerForm is TReturnsBaseGUI then Result := TReturnsBaseGUI(Ownerform).MyConnection;
end;

procedure TBASObj.RecalcItem(AccountsFieldName:string;AmountFieldName:string;BasID:integer);
var
  sAccounts,sOneAccount:string; {this is for silent ReCalc using existing accounts}
  AccountList : TStringList;
  Delim:string;
  qry,qryNZ:TERPQuery;
  i:integer;
begin
  Delim := ',';
  AccountList := TStringList.Create;
  qry := TempMyQuery(OwnerformConnection);
  qryNZ := TempMyQuery(OwnerformConnection);
  try

    qry.SQL.Add('SELECT * FROM tblbasreports WHERE ID = ' + IntToStr(BasID));
    qry.Open;
    qry.Edit;

    qryNZ.SQL.Add('SELECT * FROM tblnzreturns WHERE ID = ' + IntToStr(BasID));
    qryNZ.Open;
    qryNZ.Edit;

    sAccounts := qry.FieldByName(AccountsFieldName).asString;

    i := FastFuncs.PosEx(Delim, sAccounts);
    if (i = 0) and (char_length(sAccounts) > 0) then begin
      AccountList.Add(sAccounts);
    end;
    while i > 0 do begin
      sOneAccount := Copy(sAccounts,0,i - 1);
      AccountList.Add(sOneAccount);
      Delete(sAccounts, 1, char_length(sOneAccount) + 1);
      i := FastFuncs.PosEx(Delim, sAccounts);
      if i = 0 then AccountList.Add(sAccounts);
    end;

    if AccountList.Count < 1 then exit;
    Initialize;
    fBMList.Clear;  {We need this clear for AccountAmounts function }

    if not (AppEnv.RegionalOptions.RegionType = rNZ) then begin
      EditDB(Qry);
      qry.FieldByName(AmountFieldName).AsCurrency := FloatToCurr(AccountAmounts(AccountList));
      if AmountFieldName = 'W1' then qry.FieldByName(AmountFieldName).AsCurrency := -1 * qry.FieldByName(AmountFieldName).AsCurrency;
      qry.Post;
    end else begin
      EditDB(Qrynz);
      qryNZ.FieldByName(AmountFieldName).AsCurrency := FloatToCurr(AccountAmounts(AccountList));
      qryNZ.Post;
    end;
    if Assigned(OwnerForm) then
      if OwnerForm is TReturnsBaseGUI then begin
          TReturnsBaseGUI(OwnerForm).QryReturns.refresh;
      end;
  finally
    FreeAndNil(AccountList);
    FreeAndNil(qry);
    FreeAndNil(qryNZ);
  end;
end;

procedure TBASObj.Calc;
var
  Amount: Double;
begin
  Amount := 0.00;
           if Sametext(From.Name , 'G1') then begin    Amount := TaxAmounts;
  end else if Sametext(From.Name , 'G2') then begin    Amount := TaxAmounts;
  end else if Sametext(From.Name , 'G3') then begin    Amount := TaxAmounts;
  end else if Sametext(From.Name , 'G4') then begin    Amount := TaxAmounts;
  end else if Sametext(From.Name , 'G7') then begin    Amount := TaxAmounts;
  end else if Sametext(From.Name , 'G18') then begin   Amount := TaxAmounts;
  end else if Sametext(From.Name , 'W1') then begin    Amount := -AccountAmounts;
  end else if Sametext(From.Name , 'W2') then begin    Amount := -AccountAmounts;
  end else if Sametext(From.Name , 'W3') then begin    Amount := AccountAmounts;
  end else if Sametext(From.Name , 'W4') then begin    Amount := AccountAmounts;
  end else if Sametext(From.Name , 'T1') then begin    Amount := AccountAmounts;
  end else if Sametext(From.Name , '_1C') then begin   Amount := TaxAmounts;
  end else if Sametext(From.Name , '_1E') then begin   Amount := AccountAmounts;
  end else if Sametext(From.Name , '_1D') then begin   Amount := AccountAmounts;
  end else if Sametext(From.Name , '_1F') then begin   Amount := AccountAmounts;
  end else if Sametext(From.Name , '_1G') then begin   Amount := AccountAmounts;
  end else if Sametext(From.Name , '_7D') then begin   Amount := -AccountAmounts;
  end else if Sametext(From.Name , 'NZG5') then begin  Amount := TaxAmounts;
  end else if Sametext(From.Name , 'NZG6') then begin  Amount := TaxAmounts;
  end else if Sametext(From.Name , 'NZG11') then begin Amount := -TaxAmounts;
  end else if Sametext(From.Name , 'G10') then begin    case BasisMode of Accrual_Basis: Amount := -TaxAmounts;  Cash_Basis: Amount := TaxAmounts;end;
  end else if Sametext(From.Name , 'G11') then begin    case BasisMode of Accrual_Basis: Amount := -TaxAmounts;  Cash_Basis: Amount := TaxAmounts;end;
  end else if Sametext(From.Name , 'G13') then begin    case BasisMode of Accrual_Basis: Amount := -TaxAmounts;  Cash_Basis: Amount := TaxAmounts;end;
  end else if Sametext(From.Name , 'G14') then begin    case BasisMode of Accrual_Basis: Amount := -TaxAmounts;  Cash_Basis: Amount := TaxAmounts;end;
  end else if Sametext(From.Name , 'G15') then begin    case BasisMode of Accrual_Basis: Amount := -TaxAmounts;  Cash_Basis: Amount := TaxAmounts;end;
  end;
  AmountToField(Amount, From);
end;

procedure TBASObj.Initialize;
begin
  // Cash Or Accrual
  inherited;
  if not (AccountingMethod = 'Cash') then begin
    if (FromName = #95 + '1C') or (FromName = 'T1') then begin
      DebitsField := 'DebitsEx';  {Accrual Tax}
      CreditsField := 'CreditsEx';
    end else begin
      DebitsField := 'DebitsInc';  {Accrual}
      CreditsField := 'CreditsInc';
    end;
  end else begin
    if (FromName = #95 + '1C') or (FromName = #95 + '1D') or (FromName = #95 + '1E') or (FromName = #95 + '1F') or (FromName = #95 + '1G') or (FromName = #95 + '7D') then begin
      DebitsField := 'CASH_DebitsEx'; {Cash Tax}
      CreditsField := 'CASH_CreditsEx';
      CashField := 'TaxAmount';{Cash Tax}
    end else if  (FromName = 'T1') then begin
      DebitsField := 'CASH_DebitsEx'; {Cash Tax}
      CreditsField := 'CASH_CreditsEx';
      CashField := 'TaxableAmountEx';{Cash Tax}
    end else begin
      DebitsField := 'CASH_DebitsInc'; {Cash}
      CreditsField := 'CASH_CreditsInc';
      CashField := 'TaxableAmountInc'; {Cash}
    end;
  end;

  with qryMain do begin
    case ObjType of
      ftAcc:
        begin
          sql.Clear;
          sql.add('SELECT tblChartofAccounts.AccountName as "Account Name",AccDesc AS Type,tblChartofAccounts.Description as "Description",AccountID ');
          sql.add('FROM tblChartofAccounts LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType=tblChartofAccounts.AccountType ');
          sql.add('WHERE Active = "T" And (AccountName <> " ") ORDER BY tblChartofAccounts.AccountType, tblChartofAccounts.AccountName ');
          qryMain.BeforeOpen := nil;
          Active := true;
          FieldByName('Account Name').DisplayWidth := 20;
          FieldByName('Account Name').Visible := true;
          FieldByName('Account Name').Index := 0;
          FieldByName('Type').DisplayWidth := 20;
          FieldByName('Type').Visible := true;
          FieldByName('Type').Index := 1;
          FieldByName('Description').DisplayWidth := 30;
          FieldByName('Description').Visible := true;
          FieldByName('Description').Index := 2;
          FieldByName('AccountID').Visible := false;
          ReSelect;
        end;
    end;
  end;

end;

function  TBasObj.DefaultSalesTaxRate:Double;
var
  TaxCode:String;
  Rate:Double;
begin
  REsult := 1;
  TaxCode:= Appenv.CompanyPrefs.DefaultSalesTaxCode;
  if TaxCode = '' then TaxCode := 'GST';
  With TempMyquery do try
    SQL.add('Select Rate from tbltaxcodes  where name = '+quotedstr(TaxCode) +' and regionId = ' + inttostr(AppEnv.RegionalOptions.ID));
    open;
    Rate := Fieldbyname('Rate').asFloat;
  finally
    closenFree;
  end;
  if Rate =0 then Rate := 0.15;
  try
    Result := 1-(1/(1+Rate));
  Except
      on E:Exception do begin
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
      end;
  end;
end;

procedure TBASObj.RefreshCalcFields;
var
  curDifference: currency;
begin
   if Assigned(Ownerform) then begin

    if ownerForm is TfmBASReturn then begin
      TfmBASReturn(OwnerForm).BASReturn.G5 := RoundCurrency(TfmBASReturn(OwnerForm).BASReturn.G2 +
                                              TfmBASReturn(OwnerForm).BASReturn.G3 + TfmBASReturn(OwnerForm).BASReturn.G4 );
      //
      TfmBASReturn(OwnerForm).BASReturn.G6 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G1 -
                                              TfmBASReturn(OwnerForm).BASReturn.G5);
      //
      TfmBASReturn(OwnerForm).BASReturn.G8 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G6 +
                                              TfmBASReturn(OwnerForm).BASReturn.G7);
      //
      TfmBASReturn(OwnerForm).BASReturn.G9 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G8 / 11);
      //
      TfmBASReturn(OwnerForm).BASReturn.G12 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G10 +
                                              TfmBASReturn(OwnerForm).BASReturn.G11);
      //
      TfmBASReturn(OwnerForm).BASReturn.G16 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G13 +
                                              TfmBASReturn(OwnerForm).BASReturn.G14 + TfmBASReturn(OwnerForm).BASReturn.G15);
      //
      TfmBASReturn(OwnerForm).BASReturn.G17 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G12 -
                                              TfmBASReturn(OwnerForm).BASReturn.G16);
      //
      TfmBASReturn(OwnerForm).BASReturn.G19 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G17 +
                                              TfmBASReturn(OwnerForm).BASReturn.G18);
      //
      TfmBASReturn(OwnerForm).BASReturn.G20 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G19 / 11);
      //
      //TAB#3
      //
      TfmBASReturn(OwnerForm).BASReturn._1A := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G9);
      //
      TfmBASReturn(OwnerForm).BASReturn._1B := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.G20);
      //
      TfmBASReturn(OwnerForm).BASReturn._2A := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._1A +
                                              TfmBASReturn(OwnerForm).BASReturn._1C + TfmBASReturn(OwnerForm).BASReturn._1E);
      //
      TfmBASReturn(OwnerForm).BASReturn._2B := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._1B +
                                              TfmBASReturn(OwnerForm).BASReturn._1D + TfmBASReturn(OwnerForm).BASReturn._1F +
                                              TfmBASReturn(OwnerForm).BASReturn._1G);
      //
      TfmBASReturn(OwnerForm).BASReturn._3 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._2A -
                                              TfmBASReturn(OwnerForm).BASReturn._2B);
      //
      TfmBASReturn(OwnerForm).BASReturn._4 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.W2 +
                                              TfmBASReturn(OwnerForm).BASReturn.W3 + TfmBASReturn(OwnerForm).BASReturn.W4);
      //
      if TfmBASReturn(OwnerForm).BASReturn.T3 > 0.00 then begin
        TfmBASReturn(OwnerForm).BASReturn._5A := RoundCurrency(TfmBASReturn(OwnerForm).BASReturn.T1 *
                                                (TfmBASReturn(OwnerForm).BASReturn.T3 / 100));
      end else begin
        TfmBASReturn(OwnerForm).BASReturn._5A := RoundCurrency(TfmBASReturn(OwnerForm).BASReturn.T1 *
                                                (TfmBASReturn(OwnerForm).BASReturn.T2 / 100));
      end;
      //
      if TfmBASReturn(OwnerForm).BASReturn.F3 > 0.00 then begin
        TfmBASReturn(OwnerForm).BASReturn._6A := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.F3);
      end else begin
        TfmBASReturn(OwnerForm).BASReturn._6A := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn.F1);
      end;
      //
      TfmBASReturn(OwnerForm).BASReturn._8A := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._1A +
                                                TfmBASReturn(OwnerForm).BASReturn._4 + TfmBASReturn(OwnerForm).BASReturn._5A +
                                                TfmBASReturn(OwnerForm).BASReturn._7);
      //
      TfmBASReturn(OwnerForm).BASReturn._8B := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._2B +
                                                TfmBASReturn(OwnerForm).BASReturn._5B +
                                                TfmBASReturn(OwnerForm).BASReturn._6B+
                                                 TfmBASReturn(OwnerForm).BASReturn._7D);
      //
      TfmBASReturn(OwnerForm).BASReturn._9 := RoundCurrency( TfmBASReturn(OwnerForm).BASReturn._8A -
                                                TfmBASReturn(OwnerForm).BASReturn._8B);
    end else if ownerform is TfmNZReturn then begin
        if TfmNZReturn(OwnerForm).NZReturn.NZG5 < TfmNZReturn(OwnerForm).NZReturn.NZG6 then begin
          TfmNZReturn(OwnerForm).NZReturn.NZG7 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG6 - TfmNZReturn(OwnerForm).NZReturn.NZG5);
        end else begin
          TfmNZReturn(OwnerForm).NZReturn.NZG7 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG5 - TfmNZReturn(OwnerForm).NZReturn.NZG6);
        end;

        TfmNZReturn(OwnerForm).NZReturn.NZG8 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG7  * DefaultSalesTaxRate);
        TfmNZReturn(OwnerForm).NZReturn.NZG10 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG8 + TfmNZReturn(OwnerForm).NZReturn.NZG9);

        TfmNZReturn(OwnerForm).NZReturn.NZG12 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG11 * DefaultSalesTaxRate);
        TfmNZReturn(OwnerForm).NZReturn.NZG14 := RoundCurrency( TfmNZReturn(OwnerForm).NZReturn.NZG12 + TfmNZReturn(OwnerForm).NZReturn.NZG13);

        curDifference := TfmNZReturn(OwnerForm).NZReturn.NZG10 - TfmNZReturn(OwnerForm).NZReturn.NZG14;
        TfmNZReturn(OwnerForm).NZReturn.NZG15 := RoundCurrency( curDifference);
        if curDifference < 0 then curDifference := curDifference * -1;
        TfmNZReturn(OwnerForm).NZReturn.NZG16 := RoundCurrency( curDifference);

        if TfmNZReturn(OwnerForm).NZReturn.NZG10 > TfmNZReturn(OwnerForm).NZReturn.NZG14 then begin
          TfmNZReturn(OwnerForm).rgGSTPaymentStatus.ItemIndex := 1;
          TfmNZReturn(OwnerForm).Label214.Caption := 'Amount of payment';
        end else begin
          TfmNZReturn(OwnerForm).rgGSTPaymentStatus.ItemIndex := 0;
          TfmNZReturn(OwnerForm).Label214.Caption := 'Amount of Refund';
        end;
    end;
  end;
end;

procedure TBASObj.RecalcTaxItem(AccountsFieldName:string;AmountFieldName:string;BasID:integer);
var
  sAccounts,sOneAccount:string; {this is for silent ReCalc using existing accounts}
  AccountList : TStringList;
  Delim:string;
  qry,qryNZ:TERPQuery;
  i:integer;
  dAmount:double;
begin
  Delim := ',';
  AccountList := TStringList.Create;
  qry := TempMyQuery(OwnerformConnection);
  qryNZ := TempMyQuery(OwnerformConnection);
  try

    qry.SQL.Add('SELECT * FROM tblbasreports WHERE ID = ' + IntToStr(BasID));
    qry.Open;
    qry.Edit;

    qryNZ.SQL.Add('SELECT * FROM tblnzreturns WHERE ID = ' + IntToStr(BasID));
    qryNZ.Open;
    qryNZ.Edit;

    sAccounts := qry.FieldByName(AccountsFieldName).asString;

    i := FastFuncs.PosEx(Delim, sAccounts);
    if (i = 0) and (char_length(sAccounts) > 0) then begin
      AccountList.Add(sAccounts);
    end;
    while i > 0 do begin
      sOneAccount := Copy(sAccounts,0,i - 1);
      AccountList.Add(sOneAccount);
      Delete(sAccounts, 1, char_length(sOneAccount) + 1);
      i := FastFuncs.PosEx(Delim, sAccounts);
      if i = 0 then AccountList.Add(sAccounts);
    end;

    if AccountList.Count < 1 then exit;


    Initialize;
    fBMList.Clear;  {We need this clear for TaxAmounts function }

    if not (AppEnv.RegionalOptions.RegionType = rNZ) then begin
      dAmount := FloatToCurr(TaxAmounts);

      if AmountFieldName = 'G10' then begin
        case BasisMode of
          Accrual_Basis: dAmount := -TaxAmounts;
          Cash_Basis: dAmount := TaxAmounts;
        end;
      end else if AmountFieldName = 'G11' then begin
        case BasisMode of
          Accrual_Basis: dAmount := -TaxAmounts;
          Cash_Basis: dAmount := TaxAmounts;
        end;
      end else if AmountFieldName = 'G13' then begin
        case BasisMode of
          Accrual_Basis: dAmount := -TaxAmounts;
          Cash_Basis: dAmount := TaxAmounts;
        end;
      end else if AmountFieldName = 'G14' then begin
        case BasisMode of
          Accrual_Basis: dAmount := -TaxAmounts;
          Cash_Basis: dAmount := TaxAmounts;
        end;
      end else if AmountFieldName = 'G15' then begin
        case BasisMode of
          Accrual_Basis: dAmount := -TaxAmounts;
          Cash_Basis: dAmount := TaxAmounts;
        end;
      end;
      EditDB(Qry);
      qry.FieldByName(AmountFieldName).AsCurrency := FloatToCurr(dAmount);
      qry.Post;
    end else begin
      EditDb(QryNZ);
      qryNZ.FieldByName(AmountFieldName).AsCurrency := FloatToCurr(TaxAmounts);
      qryNZ.Post;
    end;
    if Assigned(OwnerForm) then
      if OwnerForm is TReturnsBaseGUI then begin
          TReturnsBaseGUI(OwnerForm).QryReturns.refresh;
      end;
  finally
    FreeAndNil(AccountList);
    FreeAndNil(qry);
    FreeAndNil(qryNZ);
  end;
end;

function TBASObj.TaxAmounts: Double;
var
  qryTemp: TERPQuery;
  I: Integer;
  Amount: Double;
  SelectedStr: String;
begin
  Amount := 0;
  FilterStr := '';
  qryTemp := TempMyQuery;
  try
    if (fBMList.Count <> 0) then begin
      for I := 0 to fBMList.Count- 1 do begin
        qryMain.GotoBookmark(fBMList.Items[i]);
        FilterStr := FilterStr + 'TaxCode =' + #39 + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #39 + ' OR ';
        SelectedStr := SelectedStr + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #44;
      end;
      SelectedStr := Copy(SelectedStr, 0, char_length(SelectedStr) - 1);
      FilterStr := Copy(FilterStr, 0, char_length(FilterStr) - 4);

      //Run Query
      qryTemp.SQL.Clear;

      case BasisMode of
        Accrual_Basis:
          begin
            qryTemp.SQL.Add('SELECT T.Globalref, T.`Type`, T.SeqNo, T.Date, ROUND(SUM(' + CreditsField + ') - SUM(' + DebitsField + ') ');
            if Assigned(ReturnsObj) then
              qryTemp.SQL.Add(' - IFNULL(' +
                            ' (SELECT SUM(RL.Amount) ' +
                            ' FROM ' + ReturnsObj.Lines.GetBusObjectTablename + ' RL ' +
                            ' INNER JOIN ' + ReturnsObj.GetBusObjectTablename + ' R ' +
                            ' ON RL.' + ReturnsObj.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                            ' AND R.Id <> ' + IntToStr(ReturnsObj.ID) +
                            ' AND RL.' + REturnsObj.CodefieldName + ' = ' + QuotedStr(FromName) +
                            ' WHERE T.GlobalRef = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
            qryTemp.SQL.Add(' , ' + IntToStr(GeneralRoundPlaces) + ') AS AmountInc ');
            qryTemp.SQL.Add('FROM tbltransactions T');
          end;
        Cash_Basis:
          begin
            qryTemp.SQL.Add('SELECT T.Globalref, T.`TransType` type, T.SeqNo, T.Date, ROUND(SUM(IF(IFNULL(TaxType, "")="INPUT" AND IFNULL(TransType, "") = "Journal Entry", 0 - ' + CashField + ', ' + CashField + '))  ');
            if Assigned(ReturnsObj) then
              qryTemp.SQL.Add(' - IFNULL(' +
                            ' (SELECT SUM(RL.Amount) ' +
                            ' FROM ' + ReturnsObj.Lines.GetBusObjectTablename + ' RL ' +
                            ' INNER JOIN ' + ReturnsObj.GetBusObjectTablename + ' R ' +
                            ' ON RL.' + ReturnsObj.HeaderIDFieldName + ' = R.ID and R.Active = "T" ' +
                            ' AND R.Id <> ' + IntToStr(ReturnsObj.ID) +
                            ' AND RL.' + REturnsObj.CodefieldName + ' = ' + QuotedStr(FromName) +
                            ' WHERE T.GlobalRef = RL.transglobalref AND T.TransType = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
            qryTemp.SQL.Add(' , ' + IntToStr(GeneralRoundPlaces) + ') AS AmountInc ');
            qryTemp.SQL.Add('FROM ' + CashBasisReturnTempTableName('BAS') + ' T ');
          end;
      end;

      qryTemp.SQL.Add('WHERE (' + FilterStr + ') ');
      if not All then begin
        qryTemp.Sql.Add('AND ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
      end;
      (*if (BasisMode = Accrual_Basis) then begin
        { qryTemp.Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '" AND "' + FormatDateTime(MysqlDateFormat, ToDate) + '"'); }
        qryTemp.Sql.Add('AND Date <= ' + Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      end;*)
      qryTemp.Sql.Add('AND Date <= ' + Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      //QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
      qryTemp.SQL.Add('AND ifnull(T.Globalref , "")<>""');
      case BasisMode of
        Accrual_Basis:
          qryTemp.SQL.Add('GROUP BY Globalref, `Type`, SeqNo ');
        Cash_Basis:
          qryTemp.SQL.Add('GROUP BY Globalref, `TransType`, SeqNo ');
      end;
      qryTemp.SQL.Add('HAVING IFNULL(amountinc, 0) <> 0');

      if (fromDate> 0) or (toDate > 0) then begin
        qryTemp.SQL.Add('UNION ALL');
        qryTemp.SQL.Add('SELECT RL.transGlobalref , RL.transtype , RL.transseqno , RL.transDate,0-sum(RL.amount) Amountinc'+
                          ' FROM  ' + ReturnsObj.Lines.GetBusObjectTablename +' RL'+
                          ' INNER JOIN ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                          ' ON RL.' + ReturnsObj.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                          ' AND R.Id <> ' + inttostr(REturnsObj.ID)+
                          ' AND RL.' + ReturnsObj.CodefieldName+' = ' + quotedstr(FromName) +
                          ' LEFT JOIN tbltransactions T ON T.globalref = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno');
        if TableExists('tbltransactionsummarydetails') then qryTemp.SQL.add('LEFT JOIN tbltransactionsummarydetails TD ON TD.globalref = RL.transglobalref AND TD.type = RL.transtype AND TD.Seqno = RL.TRansseqno');
        qryTemp.SQL.Add('WHERE IFNULL(T.TransID,0) = 0 ');    if TableExists('tbltransactionsummarydetails') then qryTemp.SQL.add('AND IFNULL(TD.TransID, 0) = 0');
          if not All then begin
            qryTemp.Sql.Add('AND R.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
          end;

          qryTemp.SQL.Add('GROUP BY RL.transGlobalref, RL.transtype, RL.transseqno ');
          qryTemp.SQL.Add('HAVING IFNULL(amountinc, 0)<>0');
      end;

      qryTemp.Open;
      if Assigned(ReturnsObj) then ReturnsObj.DeleteAllLines(FromName);
      Amount := 0;
      qryTemp.First;
      for I := 0 to qryTemp.RecordCount - 1 do begin
        Amount := Amount + qryTemp.FieldByName('AmountInc').AsFloat;
        if (Assigned(ReturnsObj)) and (qryTemp.FieldByName('AmountInc').AsFloat <> 0) then begin
          ReturnsObj.Lines.New;
          ReturnsObj.Lines.TransGlobalref:= qryTemp.FieldByName('Globalref').AsString;
          ReturnsObj.Lines.Transtype:= qryTemp.FieldByName('type').AsString;
          ReturnsObj.Lines.TransSeqno:= qryTemp.FieldByName('Seqno').AsInteger;
          ReturnsObj.Lines.TransDate := QryTemp.FieldByName('date').AsDateTime;
          ReturnsObj.Lines.ReportCode:= FromName;
          ReturnsObj.Lines.Amount:= qryTemp.FieldByName('AmountInc').AsFloat;
          ReturnsObj.Lines.PostDB;
        end;
        qryTemp.Next;
      end;
      if Assigned(OwnerForm) then
        if OwnerForm is TReturnsBaseGUI then begin
          EditDB(TReturnsBaseGUI(OwnerForm).QryReturns);
          TReturnsBaseGUI(OwnerForm).QryReturns.FieldByName(FromName + 'Selected').AsString := SelectedStr;
        end;

    end else begin
      Amount := 0;
      if Assigned(OwnerForm) then
        if OwnerForm is TReturnsBaseGUI then begin
          EditDB(TReturnsBaseGUI(OwnerForm).QryReturns);
          TReturnsBaseGUI(OwnerForm).QryReturns.FieldByName(FromName + 'Selected').AsString := '';
        end;
    end;
  finally
    Result := Round(Amount ,0);
    FreeAndNil(qryTemp);
  end;
end;

function TBASObj.AccountAmounts(const AccountsList: TStringList = nil): Double;
var
  qryTemp: TERPQuery; {if an accountslist is passed we are using the accounts already stored in the field;ie not selecting from the popup}
  I: Integer;
  Amount: Double;
  SelectedStr: string;
begin
  Amount := 0;
  FilterStr := '';
  qryTemp := TempMyQuery;
  try
    if (fBMList.Count <> 0) or (AccountsList <> nil) then begin
      if Assigned(AccountsList) then begin
        for I := 0 to AccountsList.Count - 1 do begin
          FilterStr := FilterStr + 'T.AccountName = ' + QuotedStr(AccountsList.Strings[i]) + ' OR ';
          SelectedStr := SelectedStr + AccountsList.Strings[i] + #44;
        end;
      end else begin
        for I := 0 to fBMList.Count - 1 do begin
          qryMain.GotoBookmark(fBMList.Items[i]);
          FilterStr := FilterStr + 'T.AccountName =' + #39 + Trim(Copy(qryMain.Fields[0].AsString, 0, 50)) + #39 + ' OR ';
          SelectedStr := SelectedStr + Trim(Copy(qryMain.Fields[0].AsString, 0, 50)) + #44;
        end;
      end;

      SelectedStr := Copy(SelectedStr, 0, char_length(SelectedStr) - 1);
      FilterStr := Copy(FilterStr, 0, char_length(FilterStr) - 4);

      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('SELECT T.Globalref, T.`Type`, T.SeqNo, T.Date, ROUND(SUM(' + CreditsField + '-' + DebitsField + ')  ');
      if assigned(REturnsObj) then
        qryTemp.SQL.Add(' - IFNULL(' +
                      ' (SELECT SUM(RL.Amount) ' +
                      ' FROM ' + ReturnsObj.Lines.GetBusObjectTablename +
                      ' RL INNER JOIN ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                      ' ON RL.' + REturnsObj.HeaderIDFieldName +'= R.ID AND R.Active = "T" ' +
                      ' AND R.Id <> ' + inttostr(REturnsObj.ID)+
                      ' AND RL.' + REturnsObj.CodefieldName+' = ' + quotedstr(FromName) +
                      ' WHERE T.GlobalRef = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
      qryTemp.SQL.Add(' , ' +inttostr(GeneralRoundPlaces)+') AS AmountInc ');
      qryTemp.SQL.Add('FROM tbltransactions T');
      qryTemp.SQL.Add('WHERE (' + FilterStr + ') ');
      if not All then begin
        qryTemp.Sql.Add('AND ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
      end;
      (* qryTemp.Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '" AND "' + FormatDateTime(MysqlDateFormat, ToDate) + '" '); *)
      qryTemp.SQL.Add('AND Date <= ' +Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      //QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
      qryTemp.SQL.Add('AND IFNULL(T.Globalref, "") <> ""');
      qryTemp.SQL.Add('GROUP BY Globalref, `Type` , SeqNo ');
      qryTemp.SQL.Add('HAVING IFNULL(amountinc,0)<>0');
      qryTemp.SQL.Add('UNION ALL ');
      qryTemp.SQL.Add('SELECT RL.transGlobalref, RL.transtype, RL.transseqno, RL.transDate, 0 - SUM(RL.amount) Amountinc ' +
                      ' FROM  ' + ReturnsObj.Lines.GetBusObjectTablename + ' RL'+
                      ' INNER JOIN ' + ReturnsObj.GetBusObjectTablename + ' R ' +
                      ' ON RL.' + REturnsObj.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                      ' AND R.Id <> ' + inttostr(REturnsObj.ID)+
                      ' AND RL.' + REturnsObj.CodefieldName + ' = ' + QuotedStr(FromName) +
                      ' LEFT JOIN tbltransactions T ON T.globalref = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno');
      if TableExists('tbltransactionsummarydetails') then
        qryTemp.SQL.Add('LEFT JOIN tbltransactionsummarydetails TD ON TD.globalref = RL.transglobalref AND TD.type = RL.transtype AND TD.Seqno = RL.TRansseqno');

      qryTemp.SQL.Add('WHERE IFNULL(T.TransID, 0) = 0 ');

      if TableExists('tbltransactionsummarydetails') then
        qryTemp.SQL.Add('AND IFNULL(TD.TransID, 0) = 0');

      if not All then begin
        qryTemp.SQL.Add('AND R.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
      end;

      qryTemp.SQL.Add('GROUP BY  RL.transGlobalref, RL.transtype, RL.transseqno ');
      qryTemp.SQL.add('HAVING IFNULL(amountinc, 0) <> 0');
      qryTemp.Open;

      Amount := 0;
      qryTemp.First;
      if Assigned(ReturnsObj) then ReturnsObj.DeleteAllLines(FromName);
      for I := 0 to qryTemp.RecordCount - 1 do begin
        Amount := Amount + qryTemp.FieldByName('AmountInc').AsFloat;
        if (Assigned(ReturnsObj)) and (qryTemp.FieldByName('AmountInc').asFloat <> 0) then begin
          ReturnsObj.Lines.New;
          ReturnsObj.Lines.TransGlobalref:= qryTemp.FieldByName('Globalref').asString;
          ReturnsObj.Lines.Transtype:= qryTemp.FieldByName('type').asString;
          ReturnsObj.Lines.TransSeqno:= qryTemp.FieldByName('Seqno').asInteger;
          ReturnsObj.Lines.TransDate := QryTemp.FieldByName('date').AsDateTime;
          ReturnsObj.Lines.ReportCode:= FromName;
          ReturnsObj.Lines.Amount:= qryTemp.FieldByName('AmountInc').asFloat;
          ReturnsObj.Lines.PostDB;
        end;
        qryTemp.Next;
      end;
    end;
  finally
      if Assigned(OwnerForm) then
        if OwnerForm is TReturnsBaseGUI then begin
            editdb(TReturnsBaseGUI(OwnerForm).QryReturns);
            TReturnsBaseGUI(OwnerForm).QryReturns.FieldByName(FromName + 'Selected').AsString := SelectedStr;
        end;
      Result := Round(Amount ,0);
    FreeAndNil(qryTemp);
  end;
end;

end.
