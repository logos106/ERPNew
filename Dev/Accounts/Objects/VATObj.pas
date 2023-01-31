unit VATObj;

interface

uses
  SysUtils,   DB, Classes, MyAccess,ERPdbComponents, DBCtrls ,
  BusobjReturns , ReturnObj;

type

  TAmountType = (atTax,atEx);
  TTransType = (ttSale,ttPO);

  TVATObj = class(TReturnObj)

  private
    FilterStr: string;
    function TaxAmounts(Const AmountType:TAmountType; Const TransType: TTransType; Var SQLStr:String) : double;
  protected
  public
    procedure RefreshCalcFields;Override;
    Function Calc(Const SQLOnly:Boolean=False):String;
  end;

implementation

uses CommonLib,
    CommonDbLib, CashBasis, MySQLConst, tcDataUtils, tcConst,
  Generics.Collections, SyncReportTableObj, ReturnsBase, frmVATReturn, DNMLib,
  AppEnvironment;

{ TVATObj }



Function TVATObj.Calc(Const SQLOnly:Boolean=False):String;
var
  Amount: double;
begin
  Result:='';
  Amount := 0.00;
           if From.Name = 'VAT1' then begin    Amount := TaxAmounts(atTax,ttSale,Result);
  end else if From.Name = 'VAT2' then begin    Amount := TaxAmounts(atTax,ttPO,Result);
  end else if From.Name = 'VAT4' then begin    Amount := TaxAmounts(atTax,ttPO,Result);
  end else if From.Name = 'VAT6' then begin    Amount := TaxAmounts(atEx,ttSale,Result);
  end else if From.Name = 'VAT7' then begin    Amount := TaxAmounts(atEx,ttPO,Result);
  end else if From.Name = 'VAT8' then begin    Amount := TaxAmounts(atEx,ttSale,Result);
  end else if From.Name = 'VAT9' then begin    Amount := TaxAmounts(atEx,ttPO,Result);
  end;
  If not SQLOnly then
    AmountToField(Amount, From);
end;

procedure TVATObj.RefreshCalcFields;
begin       //used RoundCurrency as electronic return requires Net = total - reclaimed on outputs
   if Assigned(Ownerform) then begin
    if ownerForm is TfmVATReturn then begin
      TfmVATReturn(OwnerForm).VATReturn.VAT3 := RoundCurrency(TfmVATReturn(OwnerForm).VATReturn.VAT1)+ RoundCurrency(TfmVATReturn(OwnerForm).VATReturn.VAT2);
      TfmVATReturn(OwnerForm).VATReturn.VAT5 :=
        RoundCurrency(
          Abs(Abs(TfmVATReturn(OwnerForm).VATReturn.VAT3) - RoundCurrency(Abs(TfmVATReturn(OwnerForm).VATReturn.VAT4)))
        );
    end;
  end;
end;

function TVATObj.TaxAmounts(Const AmountType:TAmountType; Const TransType: TTransType; Var SQLStr:String) : double;
var
  qryTemp: TERPQuery;
  I: integer;
  Amount: double;
  SelectedStr: string;
begin
  Result := 0.00;
  FilterStr := '';
  SQLStr := '';
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if fBMList.Count <> 0 then begin
      for I := 0 to fBMList.Count-1 do begin
        qryMain.GotoBookmark(fBMList.Items[i]);
        FilterStr := FilterStr + 'TaxCode =' + #39 + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #39 + ' OR ';
        SelectedStr := SelectedStr + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #44;
      end;
      SelectedStr := Copy(SelectedStr, 0, char_length(SelectedStr) - 1);
      FilterStr := Copy(FilterStr, 0, char_length(FilterStr) - 4);
      //Run Query
      qryTemp.Sql.Clear;
      case BasisMode of
        Accrual_Basis:
          begin
            case AmountType of
              atTax : begin
                qryTemp.Sql.Add('SELECT  T.Globalref,  T.`Type` type, T.SeqNo , T.Date,'+
                                        'Round((Sum(CreditsInc)-Sum(DebitsInc)) - (Sum(CreditsEx)-Sum(DebitsEx)) ');
                if assigned(REturnsObj) then
                  qryTemp.Sql.Add(' - ifnull(' +
                                ' (Select Sum(RL.Amount) ' +
                                ' from  ' + REturnsObj.Lines.GetBusObjectTablename +
                                ' RL inner join ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                                ' on RL.VATID = R.ID and R.Active = "T" ' +
                                ' and R.Id <> ' + inttostr(REturnsObj.ID)+
                                ' and RL.' + REturnsObj.CodefieldName+' = ' +quotedstr(FromName) +
                                ' where T.globalref = RL.transglobalref and T.type = RL.transtype and T.Seqno = RL.TRansseqno ),0) ' );
                qryTemp.Sql.Add(', ' +inttostr(GeneralRoundPlaces)+') as AmountInc ');
              end;
              atEx  : begin
                qryTemp.Sql.Add('SELECT  T.Globalref,  T.`Type` type, T.SeqNo ,T.date, '+
                                        'Round(Sum(CreditsEx)-Sum(DebitsEx) ');
                if assigned(REturnsObj) then
                  qryTemp.Sql.Add(' - ifnull(' +
                                ' (Select Sum(RL.Amount) ' +
                                ' from  ' + REturnsObj.Lines.GetBusObjectTablename +
                                ' RL inner join ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                                ' on RL.VATID = R.ID and R.Active = "T" ' +
                                ' and R.Id <> ' + inttostr(REturnsObj.ID)+
                                ' and RL.' + REturnsObj.CodefieldName+' = ' +quotedstr(FromName) +
                                ' where T.globalref = RL.transglobalref and T.type = RL.transtype and T.Seqno = RL.TRansseqno ),0) ' );
                qryTemp.Sql.Add(', ' +inttostr(GeneralRoundPlaces)+') as AmountInc ');
              end;
            end;
            qryTemp.Sql.Add('FROM tbltransactions T ');
            case TransType of
              ttSale: Begin
                        //"Journal Entry" OUTPUT  FixedAssetID=99 ??
                        qryTemp.Sql.Add('WHERE (Type IN ("Cash Sale","Refund","Invoice") OR (Type ="Journal Entry" AND FixedAssetID=99)) ');
                        SQLStr := SQLStr + ' AND (Type IN ("Cash Sale","Refund","Invoice") OR (Type ="Journal Entry" AND FixedAssetID=99)) ';
                      end;
              ttPO:   Begin
                        //"Journal Entry" INPUT  FixedAssetID=98 ??
                        qryTemp.Sql.Add('WHERE (Type IN ("PO","Bill","Credit","Cheque") OR (Type ="Journal Entry" AND FixedAssetID=98)) ');
                        SQLStr := SQLStr + ' AND (Type IN ("PO","Bill","Credit","Cheque") OR (Type ="Journal Entry" AND FixedAssetID=98)) ';
                      end;
            end;

          end;
        Cash_Basis:
          begin
            //Create Temp table
            case AmountType of
              atTax : begin
                qryTemp.Sql.Add('SELECT  T.Globalref,  T.`TransType` type, T.SeqNo ,  T.Date, '+
                                        'Round((Sum(TaxableAmountInc) - Sum(TaxableAmountEx)) ');
                if assigned(REturnsObj) then
                  qryTemp.Sql.Add(' - ifnull(' +
                                ' (Select Sum(RL.Amount) ' +
                                ' from  ' + REturnsObj.Lines.GetBusObjectTablename +
                                ' RL inner join ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                                ' on RL.VATID = R.ID and R.Active = "T" ' +
                                ' and R.Id <> ' + inttostr(REturnsObj.ID)+
                                ' and RL.' + REturnsObj.CodefieldName+' = ' +quotedstr(FromName) +
                                ' where T.globalref = RL.transglobalref and T.type = RL.transtype and T.Seqno = RL.TRansseqno ),0) ' );
                qryTemp.Sql.Add(', ' +inttostr(GeneralRoundPlaces)+')  as AmountInc ');
              end;
              atEx  : begin
                qryTemp.Sql.Add('SELECT  T.Globalref,  T.`TransType` type, T.SeqNo ,T.Date,   '+
                                        'Round(Sum(TaxableAmountEx) ');
                if assigned(REturnsObj) then
                  qryTemp.Sql.Add(' - ifnull(' +
                                ' (Select Sum(RL.Amount) ' +
                                ' from  ' + REturnsObj.Lines.GetBusObjectTablename +
                                ' RL inner join ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                                ' on RL.VATID = R.ID and R.Active = "T" ' +
                                ' and R.Id <> ' + inttostr(REturnsObj.ID)+
                                ' and RL.' + REturnsObj.CodefieldName+' = ' +quotedstr(FromName) +
                                ' where T.globalref = RL.transglobalref and T.type = RL.transtype and T.Seqno = RL.TRansseqno ),0) ' );
                qryTemp.Sql.Add(', ' +inttostr(GeneralRoundPlaces)+')  as AmountInc ');
              end;
            end;
            qryTemp.Sql.Add('FROM ' + CashBasisReturnTempTableName('VAT') + ' T ');

            case TransType of
              ttSale: Begin
                        qryTemp.Sql.Add('WHERE TaxType  = "OUTPUT" ');
                        SQLStr := SQLStr + ' TaxType  = "OUTPUT" ';
                      end;
              ttPO:   Begin
                        qryTemp.Sql.Add('WHERE TaxType  = "INPUT" ');
                        SQLStr := SQLStr + ' TaxType  = "INPUT" ';
                      end;
            end;
          end;
      end;
      qryTemp.Sql.Add(' AND (' + FilterStr + ') ');
      SQLStr := SQLStr + ' AND (' + FilterStr + ') ';



      if not All then begin
        qryTemp.Sql.Add('AND tbltransactions.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
        SQLStr := SQLStr + ' AND tbltransactions.ClassID = ' + IntToStr(GetDeptID(Department)) + ' '
      end;
      if (BasisMode = Accrual_Basis) then begin
        qryTemp.Sql.Add('AND AccountType <> "OCLIAB" ');
        SQLStr := SQLStr + ' AND AccountType <> "OCLIAB" ';

        (* qryTemp.Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '" AND "' +
          FormatDateTime(MysqlDateFormat, ToDate) + '";'); *)
          qryTemp.Sql.Add('AND Date <= ' + Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      end;
      qryTemp.SQL.add('AND ifnull(T.Globalref , "")<>""');
      case BasisMode of
        Accrual_Basis:
          qryTemp.SQL.add('group by Globalref,  `Type` , SeqNo ');
        Cash_Basis:
          qryTemp.SQL.add('group by Globalref,  `TransType` , SeqNo ');
      end;


    qryTemp.SQL.add('union all');
    qryTemp.SQL.add('select  RL.transGlobalref , RL.transtype , RL.transseqno , RL.transDate,0-sum(RL.amount) Amountinc'+
                      ' from  ' + ReturnsObj.Lines.GetBusObjectTablename +' RL'+
                      ' inner join ' + ReturnsObj.GetBusObjectTablename+ ' R ' +
                      ' on RL.' + REturnsObj.HeaderIDFieldName +'= R.ID and R.Active = "T" ' +
                      ' and R.Id <> ' + inttostr(REturnsObj.ID)+
                      ' and RL.' + REturnsObj.CodefieldName+' = ' +quotedstr(FromName) +
                      ' left join tbltransactions T on T.globalref = RL.transglobalref and T.type = RL.transtype and T.Seqno = RL.TRansseqno');
    if TableExists('tbltransactionsummarydetails') then qryTemp.SQL.add('left join tbltransactionsummarydetails TD on TD.globalref = RL.transglobalref and TD.type = RL.transtype and TD.Seqno = RL.TRansseqno');
    qryTemp.SQL.add('where ifnull(T.TransID,0)=0 ');    if TableExists('tbltransactionsummarydetails') then qryTemp.SQL.add('and ifnull(TD.TransID,0)=0');
    if not All then qryTemp.Sql.Add('AND R.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
    qryTemp.Sql.Add('group by  RL.transGlobalref , RL.transtype , RL.transseqno ');
      //QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
      qryTemp.Open;

      if Assigned(ReturnsObj) then ReturnsObj.DeleteAllLines(FromName);
      Amount := 0;
      qryTemp.First;
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
      with TfmVATReturn(FindExistingComponent('TfmVATReturn')) do begin
         EditDB(VATReturn.Dataset);
         VATReturn.Dataset.FieldByName(FromName + 'Selected').AsString := SelectedStr;
      end;
      Result := Round(Amount ,Appenv.RegionalOptions.DecimalPlaces);
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

end.


