unit CashBasis;

interface

uses Controls, MyAccess,ERPdbComponents, forms;

function CashBasisReturnTempTableName(const TblType: string; IsSummary :Boolean =False): string;
procedure RemoveTempTable(const TblType: string; IsSummary:Boolean =False);
function IsCashBasisTransSummarised(Ownerform:TForm;const FromDate, ToDate: TDateTime): Boolean;
procedure PrepareCashBasisDetails(const FromDate, ToDate: TDateTime; const TblType: string;IsSummary:Boolean =False; IncludeAccountId:boolean = False);
procedure LognExecute(QryTemp:TERPQuery);
//Function ResetSummarisedDate(const SummariseDate: TDateTime;Ownerform:TForm):Boolean;

implementation

uses
   SysUtils, CommonDBLib, ProgressDialog,  Dialogs, TransactionsTable,
  AppEnvironment, {FastFuncs,} CommonLib, {dmMainGUI,} MySQLConst, {UserUtilsClientObj,}
  SyncReportTableObj,  {CommonFormLib,} EmployeeAccesses, Classes,
//  {$IFNDEF CONSOLE}
  {$IFDEF GUIAPP}
  CashBasisGUI,
  {$ENDIF}
  UtilsLib;

var
  TempFileNameList: TStringList;

//Function ResetSummarisedDate(const SummariseDate: TDateTime;Ownerform:TForm):Boolean;
//var
//  TransactionTableObj: TTransactionTableObj;
//  msg: string;
//  //fdSumDate:TDatetime;
//  function GetCurrentUserCount: integer;
//  var
//    s: string;
//  begin
//    result:= -1;
//    if AppEnv.UtilsClient.GetDatabaseUserList(s, AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true) then begin
//      dtmMainGUI.dlgCurrentUsers.Items.CommaText:= s;
//      Result := dtmMainGUI.dlgCurrentUsers.Items.Count;
//    end;
//  end;
//begin
//  Result := False;
//  if not CanChangeClosingDate then begin
//    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
//      [AppEnv.AccessLevels.GetFormDescription('FnChangeClosingDate')]), mtInformation, [mbOK], 0);
//  end else begin
//
//    if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Summarised Transactions') then begin
//      try
//        (*if CommonLib.MessageDlgXP_Vista('Changing Summarised Dates will Remain For Twenty Four Hours. '+#13+#10+#13+#10+
//                      'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year'+#13+#10+#13+#10+
//                      'This Process May Take Several Minutes.'+#13+#10+#13+#10+'Are You Sure You Wish To Proceed ?',
//                      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin*)
//        CommonLib.MessageDlgXP_Vista('Changing Summarised Dates will Remain For Twenty Four Hours. '+#13+#10+#13+#10+
//                      'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year'+#13+#10+#13+#10+
//                      'This Process May Take Several Minutes.',
//                      mtInformation, [mbok], 0) ;
//          ShowUpdateBatchHint(Ownerform );
//          try
//            TransactionTableObj := TTransactionTableObj.Create(False);
//            try
//              TransactionTableObj.InitforRefreshTrnsTable;
//              //fdSumDate :=AppEnv.CompanyPrefs.SummarisedTransDate;
//              AppEnv.CompanyPrefs.SummarisedTransDate := SummariseDate;
//              if TransactionTableObj.CleanRefreshTrnsTable(true, true) then
//                if TransactionTableObj.CreatePermanentSummaryTable then begin
//                  //AppEnv.CompanyPrefs.SummarisedTransDate:= fdSumDate;
//                  if TransactionTableObj.CleanRefreshTrnsTable(true, false, true, true) then
//                    Result := True;
//                end;
//            finally
//              FreeandNil(TransactionTableObj);
//            end;
//          finally
//            HideERPHint(Ownerform);
//          end;
//        (*end;*)
//      finally
//        AppEnv.UtilsClient.UnlockLogon;
//      end;
//    end
//    else begin
//      if msg = USERS_IN_SYSTEM_MESSAGE then begin
//        if GetCurrentUserCount > 0 then begin
//          dtmMainGUI.dlgCurrentUsers.Caption := CommonDbLib.GetSharedMyDacConnection.Database + ' Closing Date Update';
//          dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
//          dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
//          dtmMainGUI.dlgCurrentUsers.Execute;
//        end
//        else begin
//          MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
//        end;
//      end
//      else begin
//        MessageDlgXP_Vista('Unable To Summarise Dates, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
//      end;
//    end;
//  end;
//end;

function CashBasisReturnTempTableName(const TblType: string; IsSummary :Boolean =False): string;
var
  aType: string;
begin
  aType := TblType;
  if IsSummary then
    aType := aType + '_Sum';

  result := TempFileNameList.Values[aType];
  if result = '' then begin
    result := GetUserTemporaryTableName(aType);
    TempFileNameList.Values[aType] := result;
  end;

//  if Sysutils.SameText(TblType, 'TaxSummary') then begin
//    Result := GetUserTemporaryTableName('CashTaxSummaryReport');
//  end else if Sysutils.SameText(TblType, 'BAS') then begin
//    Result := GetUserTemporaryTableName('CashBAS');
//  end else if Sysutils.SameText(TblType, 'VAT') then begin
//    Result := GetUserTemporaryTableName('VAT');
//  end else if TblType <> '' then begin
//    Result := GetUserTemporaryTableName(TblType);
//  end else begin
//    Result := GetUserTemporaryTableName('CashBasis');
//  end;
//  if IsSummary then REsult := result +'_Sum';
end;

procedure RemoveTempTable(const TblType: string;IsSummary:Boolean =False);
begin
  DestroyUserTemporaryTable(CashBasisReturnTempTableName(TblType , IsSummary));
end;

function IsCashBasisTransSummarised(Ownerform: TForm; const FromDate, ToDate: TDateTime): Boolean;
Var
  qryTemp: TERPQuery;
  MinDate: TDateTime;
  usingReportTables:Boolean;
begin
  MinDate := AppEnv.CompanyPrefs.SummarisedTransDate;
  qryTemp := TERPQuery.Create(nil);
  Try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Close;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT Min(S.SaleDate) as MinDate ');
    qryTemp.Sql.Add('FROM tbltransactions T ');
    qryTemp.Sql.Add('INNER JOIN tblSales S ON  S.SaleID = T.SaleID ');
    qryTemp.Sql.Add('WHERE  T.Type ="Customer Payment" ');
    qryTemp.Sql.Add('AND T.AccountType="AR" ');
    qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
      FormatDateTime(MysqlDateFormat, ToDate) + '" ');
    QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text,usingReportTables);
    qryTemp.Open;
    if (not (qryTemp.IsEmpty)) and (qryTemp.FieldByName('MinDate').asDateTime >0) then begin
      If (qryTemp.FieldByName('MinDate').asDateTime<MinDate) then
        MinDate := qryTemp.FieldByName('MinDate').asDateTime;
    end;

    qryTemp.Close;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT date(Min(If(IsPO="T",P.InvoiceDate,P.OrderDate)))  as MinDate ');
    qryTemp.Sql.Add('FROM tbltransactions T ');
    qryTemp.Sql.Add('INNER JOIN tblpurchaseorders P ON  P.PurchaseOrderID = T.PurchaseOrderID ');
    qryTemp.Sql.Add('WHERE  T.Type ="Supplier Payment" ');
    qryTemp.Sql.Add('AND T.AccountType="AP" ');
    qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
      FormatDateTime(MysqlDateFormat, ToDate) + '" ');
    QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
    qryTemp.Open;
    if (not (qryTemp.IsEmpty)) and (qryTemp.FieldByName('MinDate').asDateTime >0) then begin
      If (not qryTemp.FieldByName('MinDate').IsNull) and (qryTemp.FieldByName('MinDate').asDateTime<MinDate) then
        MinDate := qryTemp.FieldByName('MinDate').asDateTime;
    end;

    If (MinDate < AppEnv.CompanyPrefs.SummarisedTransDate) then
      Result := True
    else
      Result := False;

//    {$IFNDEF CONSOLE}
  {$IFDEF GUIAPP}
    If Result and Assigned(OwnerForm) then begin
        CommonLib.MessageDlgXP_Vista('Required Cash Basis Transaction Are Summarised.', mtInformation, [mbok], 0) ;
        Result := Not ResetSummarisedDate(MinDate-1 , Ownerform);
    end;
    {$ENDIF}

  Finally
    FreeAndNil(qryTemp);
  end;
end;
procedure LognExecute(QryTemp:TERPQuery);
begin
  QryTemp.Execute;
end;
procedure PrepareCashBasisDetails(const FromDate, ToDate: TDateTime; const TblType: string;IsSummary:Boolean =False; IncludeAccountId:boolean = False);
const
  INSERT_INTO_String =
    'tSeqno,Seqno, Globalref, Date,TaxType,CashType,TransType, PaymentID, SaleID, PurchaseOrderID, TransDate, Taxcode, OriginalAmount, TaxableAmountEx, TaxableAmountInc, TaxAmount,ClassID';
  function FieldNames:String;
  begin
    Result :=INSERT_INTO_String;
    if IncludeAccountId then result:= result +',AccountID';
  end;
var
  ProgressDialog: TProgressDialog;
  qryTemp: TERPQuery;
  usingReportTables:Boolean;
  Tablename :String;
  ctr:Integer;
function TransactionTablename:String;
begin
  if IsSummary then result := 'tbltransactionsummarydetails' else result := 'tbltransactions';
end;
begin
  if IsGUI then
    Processingcursor(True);
  try
      qryTemp := TERPQuery.Create(nil);
      if IsGUI then
        ProgressDialog := TProgressDialog.Create(nil);
      try
        Tablename :=CashBasisReturnTempTableName(TblType, (*IsSummary*)False);
        if IsGUI then begin
          ProgressDialog.Caption  := 'Preparing ''Cash Basis'' Details';
          ProgressDialog.MinValue := 0;
          ProgressDialog.MaxValue := 12;
          ProgressDialog.Step     := 1;
          ProgressDialog.Execute;
        end;
        qryTemp.Options.FlatBuffers := True;
        qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
        //###### OUTPUT ######

        //Create Tables
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add('DROP TABLE IF EXISTS `' +Tablename + '`; ');
        LognExecute(QryTemp);
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add('CREATE TABLE `' +Tablename + '` ( ');
        qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
        qryTemp.Sql.Add('tSeqno int(1) , ');
        qryTemp.Sql.Add('Seqno int(1) , ');
        qryTemp.Sql.Add('Globalref varchar(255) , ');
        qryTemp.Sql.Add('`Date` date default NULL, ');
        qryTemp.Sql.Add('`CashType` varchar(255) default NULL, ');
        qryTemp.Sql.Add('`TaxType` varchar(255) default NULL, ');
        qryTemp.Sql.Add('`TransDate` date default NULL, ');
        qryTemp.Sql.Add('`TransType` varchar(255) default NULL, ');
        qryTemp.Sql.Add('`PaymentID` int(11) NOT NULL default "0", ');
        qryTemp.Sql.Add('`SaleID` int(11) NOT NULL default "0", ');
        qryTemp.Sql.Add('`PurchaseOrderID` int(11) NOT NULL default "0", ');
        qryTemp.Sql.Add('`Taxcode` varchar(50) default NULL, ');
        qryTemp.Sql.Add('`OriginalAmount` double NOT NULL default "0", ');
        qryTemp.Sql.Add('`TaxableAmountEx` double NOT NULL default "0", ');
        qryTemp.Sql.Add('`TaxableAmountInc` double NOT NULL default "0", ');
        qryTemp.Sql.Add('`TaxAmount` double NOT NULL default "0", ');
        qryTemp.Sql.Add('`ClassID` int(11) default "0", ');
        if IncludeAccountId then qryTemp.Sql.Add('`AccountID` int(11) default "0", ');
        qryTemp.Sql.Add('PRIMARY KEY  (`ID`), ');
        qryTemp.Sql.Add('KEY `POID` (`PurchaseOrderID`), ');
        qryTemp.Sql.Add('KEY `SaleIDIndex` (`SaleID`), ');
        qryTemp.Sql.Add('KEY `PaymentIDIndex` (`PaymentID`), ');
        qryTemp.Sql.Add('KEY `TransTypeIndex` (`TransType`)');
        qryTemp.Sql.Add(') ENGINE=MyISAM; ');
        LognExecute(QryTemp);
        if IsGUI then
          ProgressDialog.Stepit;
        for ctr:= 1 to 2 do begin
          if (ctr =1 ) or (Issummary) then begin
            //Customer Payments
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('1,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"OUTPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('T.PaymentID as PaymentID, ');
            qryTemp.Sql.Add('T.SaleID as SaleID, ');
            qryTemp.Sql.Add('0 as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as DateTrans, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('S.TotalAmountInc as OriginalAmount, ');
            qryTemp.Sql.Add('(S.TotalAmount/S.TotalAmountInc)*CreditsEx as TaxableAmountEx, ');
            qryTemp.Sql.Add('CreditsInc as TaxableAmountInc, ');
            qryTemp.Sql.Add('CreditsInc-((S.TotalAmount/S.TotalAmountInc)*CreditsEx) as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('INNER JOIN tblSales S ON  S.SaleID = T.SaleID ');
            qryTemp.Sql.Add('WHERE  T.Type ="Customer Payment" ');
            qryTemp.Sql.Add('AND T.AccountType="AR" ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +      FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;
            //Customer Payment Lines
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('2,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('A.Date as Date, ');
            qryTemp.Sql.Add('"OUTPUT" as TaxType, ');
            qryTemp.Sql.Add('A.TransType as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('A.PaymentID as PaymentID, ');
            qryTemp.Sql.Add('T.SaleID as SaleID, ');
            qryTemp.Sql.Add('0 as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('(T.CreditsInc-T.DebitsInc)  as OriginalAmount, ');
            qryTemp.Sql.Add('(A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.CreditsEx)-Sum(T.DebitsEx)) as TaxableAmountEx, ');
            qryTemp.Sql.Add('(A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.CreditsInc)-Sum(T.DebitsInc)) as TaxableAmountInc, ');
            qryTemp.Sql.Add('((A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.CreditsEx)-Sum(T.DebitsEx))) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('A.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM `' +Tablename + '` A ');
            qryTemp.Sql.Add('INNER JOIN ' +TransactionTablename +' T ON  T.SaleID = A.SaleID ');
            qryTemp.Sql.Add('INNER JOIN tblSales S ON  S.SaleID = A.SaleID ');
            qryTemp.Sql.Add('WHERE (A.SaleID <> 0) and (T.SaleID <> 0) AND (T.Type = "Refund" OR T.Type = "Invoice") ');
            qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
            qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
            qryTemp.Sql.Add('Group By T.Taxcode,T.SaleID,A.PaymentID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            qryTemp.Sql.Add('Order By PaymentID,SaleID ');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;
            //Clean Up
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('DELETE FROM `' +Tablename + '` WHERE `TransType` = "Customer Payment";');
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

            //Cash Sales
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('3,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"OUTPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('0 as PaymentID, ');
            qryTemp.Sql.Add('T.SaleID as SaleID, ');
            qryTemp.Sql.Add('0 as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('S.TotalAmountInc as OriginalAmount, ');
            qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) as TaxableAmountEx, ');
            qryTemp.Sql.Add('Sum(T.CreditsInc-T.DebitsInc) as TaxableAmountInc, ');
            qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('INNER JOIN tblSales S ON  S.SaleID = T.SaleID AND S.Account="Undeposited Funds" ');
            qryTemp.Sql.Add('WHERE (T.Type = "Cash Sale") ');
            qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
            qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            qryTemp.Sql.Add('Group By T.Taxcode,T.SaleID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

            //Cash Sale Refunds
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('4,T.Seqno, T.Globalref, ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"OUTPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('0 as PaymentID, ');
            qryTemp.Sql.Add('T.SaleID as SaleID, ');
            qryTemp.Sql.Add('0 as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('S.TotalAmountInc as OriginalAmount, ');
            qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) as TaxableAmountEx, ');
            qryTemp.Sql.Add('Sum(T.CreditsInc-T.DebitsInc) as TaxableAmountInc, ');
            qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('INNER JOIN tblSales S ON  S.SaleID = T.SaleID AND S.Account="Undeposited Funds" ');
            qryTemp.Sql.Add('WHERE (T.Type = "Refund") ');
            qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
            qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            qryTemp.Sql.Add('Group By T.Taxcode,T.SaleID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

            // Journal Entry
            if AppEnv.CompanyPrefs.IncludeJournalsInCashBAS then begin
              qryTemp.Sql.Clear;
              qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
              qryTemp.Sql.Add('SELECT ');
              qryTemp.Sql.Add('5,T.Seqno, T.Globalref,  ');
              qryTemp.Sql.Add('T.Date as Date, ');
              qryTemp.Sql.Add('"OUTPUT" as TaxType, ');
              qryTemp.Sql.Add('T.Type as CashType, ');
              qryTemp.Sql.Add('T.Type as TransType, ');
              qryTemp.Sql.Add('0 as PaymentID, ');
              qryTemp.Sql.Add('T.SaleID as SaleID, ');
              qryTemp.Sql.Add('0 as PurchaseOrderID, ');
              qryTemp.Sql.Add('T.Date as TransDate, ');
              qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
              qryTemp.Sql.Add('Sum(T.CreditsInc-T.DebitsInc) as OriginalAmount, ');
              qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) as TaxableAmountEx, ');
              qryTemp.Sql.Add('Sum(T.CreditsInc-T.DebitsInc) as TaxableAmountInc, ');
              qryTemp.Sql.Add('Sum(T.CreditsEx-T.DebitsEx) * T.TaxRate as TaxAmount, ');
              qryTemp.Sql.Add('T.ClassID as ClassID ');
              if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
              qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
              qryTemp.Sql.Add('INNER JOIN tblgeneraljournal ON (T.SaleID=GJID) ');
              qryTemp.Sql.Add('WHERE (T.Type = "Journal Entry") ');
              qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
              qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
              qryTemp.Sql.Add('AND tblgeneraljournal.TaxSelect="OUTPUT" ');
              if (Fromdate<> 0) and (ToDate<>0) then
                qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
                FormatDateTime(MysqlDateFormat, ToDate) + '" ');
              qryTemp.Sql.Add('Group By T.Taxcode,T.SaleID ');
              if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
              QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
              LognExecute(QryTemp);
              if IsGUI then
                ProgressDialog.Stepit;
            end;

            //###### INPUT ######

            //Supplier Payments
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('6,T.Seqno, T.Globalref, ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"INPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('T.PaymentID as PaymentID, ');
            qryTemp.Sql.Add('0 as SaleID, ');
            qryTemp.Sql.Add('T.PurchaseOrderID as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('P.TotalAmountInc as OriginalAmount, ');
            qryTemp.Sql.Add('ABS(P.TotalAmount/P.TotalAmountInc)*DebitsEx as TaxableAmountEx, ');
            qryTemp.Sql.Add('DebitsInc as TaxableAmountInc, ');
            qryTemp.Sql.Add('DebitsInc-(ABS(P.TotalAmount/P.TotalAmountInc)*DebitsEx) as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('INNER JOIN tblpurchaseorders P ON  P.PurchaseOrderID = T.PurchaseOrderID ');
            qryTemp.Sql.Add('WHERE  T.Type ="Supplier Payment" ');
            qryTemp.Sql.Add('AND T.AccountType="AP" ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
              FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

            //Supplier Payment Lines
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('7,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('A.Date as Date, ');
            qryTemp.Sql.Add('"INPUT" as TaxType, ');
            qryTemp.Sql.Add('A.TransType as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('A.PaymentID as PaymentID, ');
            qryTemp.Sql.Add('0 as SaleID, ');
            qryTemp.Sql.Add('T.PurchaseOrderID as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('(T.DebitsInc-T.CreditsInc)  as OriginalAmount, ');
            qryTemp.Sql.Add('ABS(A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.DebitsEx)-Sum(T.CreditsEx)) as TaxableAmountEx, ');
            qryTemp.Sql.Add('ABS(A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.DebitsInc)-Sum(T.CreditsInc)) as TaxableAmountInc, ');
            qryTemp.Sql.Add('(ABS(A.TaxableAmountInc/A.OriginalAmount)*(Sum(T.DebitsEx)-Sum(T.CreditsEx))) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM `' +Tablename + '` A ');
            qryTemp.Sql.Add('INNER JOIN ' +TransactionTablename +' T ON  T.PurchaseOrderID = A.PurchaseOrderID ');
            qryTemp.Sql.Add('INNER JOIN tblpurchaseorders P ON  P.PurchaseOrderID = A.PurchaseOrderID ');
            qryTemp.Sql.Add('WHERE (A.PurchaseOrderID <> 0) and (T.PurchaseOrderID <> 0) AND(T.Type="PO" OR T.Type="Bill" OR T.Type="Credit") ');
            qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
            qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
            qryTemp.Sql.Add('Group By T.Taxcode,T.PurchaseOrderID,A.PaymentID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            qryTemp.Sql.Add('Order By PaymentID,PurchaseOrderID ');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;
            //Clean Up
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('DELETE FROM `' +Tablename + '` WHERE `TransType` = "Supplier Payment";');
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

            // Journal Entry
            if AppEnv.CompanyPrefs.IncludeJournalsInCashBAS then begin
              qryTemp.Sql.Clear;
              qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
              qryTemp.Sql.Add('SELECT ');
              qryTemp.Sql.Add('8,T.Seqno, T.Globalref, ');
              qryTemp.Sql.Add('T.Date as Date, ');
              qryTemp.Sql.Add('"INPUT" as TaxType, ');
              qryTemp.Sql.Add('T.Type as CashType, ');
              qryTemp.Sql.Add('T.Type as TransType, ');
              qryTemp.Sql.Add('0 as PaymentID, ');
              qryTemp.Sql.Add('T.SaleID as SaleID, ');
              qryTemp.Sql.Add('0 as PurchaseOrderID, ');
              qryTemp.Sql.Add('T.Date as TransDate, ');
              qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
              qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as OriginalAmount, ');
              qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) as TaxableAmountEx, ');
              qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as TaxableAmountInc, ');
              qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) * T.TaxRate as TaxAmount, ');
              qryTemp.Sql.Add('T.ClassID as ClassID ');
              if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
              qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
              qryTemp.Sql.Add('INNER JOIN tblgeneraljournal ON (T.SaleID=GJID) ');
              qryTemp.Sql.Add('WHERE (T.Type = "Journal Entry") ');
              qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
              qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
              qryTemp.Sql.Add('AND tblgeneraljournal.TaxSelect="INPUT" ');
              if (Fromdate<> 0) and (ToDate<>0) then
                qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
                FormatDateTime(MysqlDateFormat, ToDate) + '" ');
              qryTemp.Sql.Add('Group By T.Taxcode,T.SaleID ');
              if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
              QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
              LognExecute(QryTemp);
              if IsGUI then
                ProgressDialog.Stepit;
            end;
   
            //Cheque
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('9,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"INPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('0 as PaymentID, ');
            qryTemp.Sql.Add('0 as SaleID, ');
            qryTemp.Sql.Add('T.PurchaseOrderID as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as OriginalAmount, ');
            qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) as TaxableAmountEx, ');
            qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as TaxableAmountInc, ');
            qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('INNER JOIN tblpurchaseorders P ON  P.PurchaseOrderID = T.PurchaseOrderID ');
            qryTemp.Sql.Add('WHERE (T.Type = "Cheque") ');
            qryTemp.Sql.Add('AND char_length(T.Taxcode)>0 ');
            qryTemp.Sql.Add('AND (T.AccountName<>"Tax Paid" AND T.AccountName<>"Tax Collected") ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
              FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            qryTemp.Sql.Add('Group By T.Taxcode,T.PurchaseOrderID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);
            if IsGUI then
              ProgressDialog.Stepit;

           (* //deposit Entries
            qryTemp.Sql.Clear;
            qryTemp.Sql.Add('INSERT HIGH_PRIORITY INTO `' +Tablename + '` (' + FieldNames + ') ');
            qryTemp.Sql.Add('SELECT ');
            qryTemp.Sql.Add('10,T.Seqno, T.Globalref,  ');
            qryTemp.Sql.Add('T.Date as Date, ');
            qryTemp.Sql.Add('"INPUT" as TaxType, ');
            qryTemp.Sql.Add('T.Type as CashType, ');
            qryTemp.Sql.Add('T.Type as TransType, ');
            qryTemp.Sql.Add('T.PaymentID as PaymentID, ');
            qryTemp.Sql.Add('0 as SaleID, ');
            qryTemp.Sql.Add('0 as PurchaseOrderID, ');
            qryTemp.Sql.Add('T.Date as TransDate, ');
            qryTemp.Sql.Add('T.Taxcode as Taxcode, ');
            qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as OriginalAmount, ');
            qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) as TaxableAmountEx, ');
            qryTemp.Sql.Add('Sum(T.DebitsInc-T.CreditsInc) as TaxableAmountInc, ');
            qryTemp.Sql.Add('Sum(T.DebitsEx-T.CreditsEx) * T.TaxRate as TaxAmount, ');
            qryTemp.Sql.Add('T.ClassID as ClassID ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID as AccountId ');
            qryTemp.Sql.Add('FROM ' +TransactionTablename +' T ');
            qryTemp.Sql.Add('WHERE (T.Type = "Deposit Entry") ');
            if (Fromdate<> 0) and (ToDate<>0) then
              qryTemp.Sql.Add('AND T.Date Between "' + FormatDateTime(MysqlDateFormat, FromDate) + '"  AND "' +
              FormatDateTime(MysqlDateFormat, ToDate) + '" ');
            qryTemp.Sql.Add('Group By T.PaymentID  ');
            if IncludeAccountId then qryTemp.Sql.Add(',T.AccountID');
            QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
            LognExecute(QryTemp);*)

          end;
        end;
      finally
        FreeAndNil(qryTemp);
        if IsGUI then
          FreeandNil(ProgressDialog);
      end;
    finally
      Processingcursor(False);
    end;

end;

initialization
  TempFileNameList := TStringList.Create;
  TempFileNameList.CaseSensitive := false;
finalization
  TempFileNameList.Free;

end.
