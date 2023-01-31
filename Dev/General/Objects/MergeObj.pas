unit MergeObj;

  // Date     Version  Who What
  // -------- -------- --- ------------------------------------------------------
  // 26/07/05  1.00.01 IJB Modified Merge for new MyDac exceptions.

interface
 
uses
  Classes, ProgressInfoObj,
  MyAccess, ERPdbComponents, MemDS, MyClasses, DAScript, sysutils;

type
  TMergeType = (mClient, mProduct, mAccount, mUOM);

type
  TMergeFieldType = (mtID, mtName);

type
  pMergeFieldRec = ^TMergeFieldRec;
  TMergeFieldRec = record
    FieldName: string;
    FieldType: TMergeFieldType;
    IDFieldname: string;
  end;


type
  TMergeObj = class(TObject)
  private
    LstMergeField: TList;
    procedure ClearMergeFieldList;
    procedure GetMergeFieldList(MergeType: TMergeType);
    procedure MergeQtys(FromID, ToID: integer);
    procedure MergeDataFields(const MergeType: TMergeType;
      const PrincipleID: integer; const SecordaryID: integer);
    procedure DoShowProgressbar(ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = ''; IsPercenage: boolean =true);
    procedure DoStepProgressbar(const ProgressBarMessage:String = '');Overload;
    procedure DoHideProgressbar;Overload;
    function GetConnection: TCustomMyConnection;
    function GetProgressDialog: TProgressInfo;
    property Connection: TCustomMyConnection read GetConnection;
    property ProgressDialog: TProgressInfo read GetProgressDialog;
    procedure ScriptMergeUpdateOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClientBalanceVerify;Overload;
    procedure ClientBalanceVerify(ClientIDs:Array of Integer);Overload;
    procedure AccountBalanceVerify;
    //procedure Merge(const MergeType: TMergeType; const PrincipleName: string; const PrincipleID: integer; const SecordaryName: string; const SecordaryID: integer);
    procedure Merge(const MergeType: TMergeType; const PrincipleName: string; const PrincipleID: integer; const SecordaryName: string; const SecordaryID: integer;qrySchema:TERPQuery = nil; ProgressMsg :String = '');
    Function AllTablesof(const MergeType: TMergeType; onlynamefields:Boolean =False):String;
    Procedure FixUOMnameFromID;
  end;

implementation

uses DB,
  MySQLErrors,
  {tcDataUtils, }{tcConst,} UserLockObj, DBUtils,
  AppEnvironmentVirtual, Rounding, DbSharedObjectsObj;




{ TMergeObj }

procedure TMergeObj.ClearMergeFieldList;
var
  i: integer;
begin
  for i := 0 to LstMergeField.Count - 1 do Dispose(LstMergeField.Items[i]);
  LstMergeField.Clear;
end;


constructor TMergeObj.Create;
begin
  inherited;
  LstMergeField := TList.Create;
end;

destructor TMergeObj.Destroy;
begin
  ClearMergeFieldList;
  FreeAndNil(LstMergeField);
  AppEnvVirt.Obj['ProgressInfo'].Free;
  AppEnvVirt.Obj['ProgressInfo'] := nil;
  inherited;
end;

procedure TMergeObj.DoHideProgressbar;
begin
  if Assigned(ProgressDialog) then begin
    ProgressDialog.CloseDialog;
  end;
end;

procedure TMergeObj.DoShowProgressbar(ProgressCount: integer;
  ProgressBarCaption, ProgressBarMessage: string; IsPercenage: boolean);
begin
  if Assigned(ProgressDialog) then begin
    if ProgressBarCaption <> '' then
      ProgressDialog.Caption := ProgressBarCaption;
    if ProgressBarMessage <> '' then
      ProgressDialog.Message:= ProgressBarMessage;
    ProgressDialog.MaxValue := ProgressCount;
    ProgressDialog.minValue:= 0;
    ProgressDialog.Step := 1;
    ProgressDialog.ShowPercent := IsPercenage;
    ProgressDialog.Execute;
  end;
end;

procedure TMergeObj.DoStepProgressbar(const ProgressBarMessage: String);
begin
  if Assigned(ProgressDialog) then begin
    ProgressDialog.StepIt;
    if ProgressBarMessage <> '' then
      ProgressDialog.Message :=ProgressBarMessage;
  end;
end;

procedure TMergeObj.FixUOMnameFromID;
var
  dsTables: TERPQuery;
  qryMergeUpdate: TERPCommand;
  TableCount,I,MFCount:Integer;
  TableName:String;
  pMergeField: pMergeFieldRec;
begin
  GetMergeFieldList(mUOM);
  dsTables := TERPQuery.Create(nil);
  qryMergeUpdate := TERPCommand.Create(nil);
  dsTables.Connection := Connection;
  qryMergeUpdate.Connection := Connection;

    dsTables.Sql.Text       := 'Show Tables;';
    dsTables.Open;
    with dsTables do begin
      if RecordCount > 0 then begin
        TableCount := RecordCount;
        ProgressDialog.MaxValue := TableCount;
        ProgressDialog.Execute;
        First;
        for I := 0 to TableCount - 1 do begin
          TableName := dsTables.Fields[0].AsString;
          for MFCount := 0 to LstMergeField.Count - 1 do begin
            pMergeField := LstMergeField.Items[MFCount];
            if pMergeField^.FieldType= mtName then begin
                  try
                    qryMergeUpdate.Sql.Clear;
                    qryMergeUpdate.Sql.Add('UPDATE ' + TableName + ' T '+
                                              ' inner join tblunitsofmeasure UOM on UOM.UnitID = T.' +pMergeField^.IDfieldName  +
                                              ' SET T.'   + pMergeField^.FieldName + ' =UOM.UnitName;');
                    qryMergeUpdate.Execute;
                  except
                    on E: EMyError do;
                    on E: EMySqlException do;
                    else raise;
                  end;
            end;
          end;
          ProgressDialog.StepIt;
          dsTables.Next;
        end;
        ProgressDialog.CloseDialog;
      end;
    end;


  end;

function TMergeObj.GetConnection: TCustomMyConnection;
begin
  result := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;

procedure TMergeObj.GetMergeFieldList(MergeType: TMergeType);

  procedure AddTablesToList(const Field: string; const FieldType: TMergeFieldType; const IDFieldname:String='');
  var
    pMergeField: pMergeFieldRec;
  begin
    New(pMergeField);
    LstMergeField.Add(pMergeField);
    pMergeField^.FieldName := Field;
    pMergeField^.FieldType := FieldType;
    pMergeField^.IDFieldname :=IDFieldname;
  end;
begin  //=>
  ClearMergeFieldList;
  case MergeType of
    {Merge Clients}
    mUOM:
      begin
        AddTablesToList('UOM'                     , mtName , 'UOMID');
        AddTablesToList('UnitOfMeasure'           , mtName , 'UnitOfMeasureID');
        AddTablesToList('UnitofMeasureSaleLines'  , mtName , 'UnitOfMeasureID');
        AddTablesToList('UnitofMeasurePOLines'    , mtName , 'UnitOfMeasureID');
        AddTablesToList('BaseUnitName'            , mtName , 'BaseUnitID');
        AddTablesToList('TreePartUOM'             , mtName , 'TreePartUOMID');

        AddTablesToList('UOMID'           , mtID);
        AddTablesToList('UnitOfMeasureID' , mtID);
        AddTablesToList('BaseUnitID'      , mtID);
        AddTablesToList('TreePartUOMID'   , mtID);
      end;
    mClient:
      begin
        //ID's
        AddTablesToList('ClientID', mtID);
        AddTablesToList('CusID', mtID);
        AddTablesToList('SupID', mtID);
        AddTablesToList('BillCusID', mtID);
        AddTablesToList('ParentClientID', mtID);
        AddTablesToList('CustomerID', mtID);
        AddTablesToList('CustomerJobID', mtID);
        AddTablesToList('ReferredClientID', mtID);
        AddTablesToList('SupplierID', mtID);
        AddTablesToList('Customer_ID', mtID);
        //Names
        AddTablesToList('Company', mtName);
        AddTablesToList('CustomerName', mtName);
        AddTablesToList('CustomerJob', mtName);
        AddTablesToList('CusJobID', mtName);
        AddTablesToList('CompanyName', mtName);
        AddTablesToList('ClientName', mtName);
        AddTablesToList('PreferredSupp', mtName);
        AddTablesToList('SupplierName', mtName);
        AddTablesToList('Supplier', mtName);
        AddTablesToList('JobName', mtName);
        AddTablesToList('Job_Name', mtName);
        AddTablesToList('Payee', mtName);
      end;
    {Merge Products}
    mProduct: 
      begin
        //ID's
        AddTablesToList('PartsID', mtID);
        AddTablesToList('ProductID', mtID);
        AddTablesToList('PartID', mtID);
        AddTablesToList('GroupPartID', mtID);
        AddTablesToList('MasterProductID', mtID);
        //Names
        AddTablesToList('PartName', mtName);
        AddTablesToList('ProductName', mtName);
      end;
    {Merge Accounts}
    mAccount: 
      begin
        //ID's
        AddTablesToList('AccountID', mtID);
        AddTablesToList('MasterAccountID', mtID);
        AddTablesToList('BankAccountID', mtID);
        AddTablesToList('AllowanceLiabilityAccountID', mtID);
        AddTablesToList('AllowancePaidAccountID', mtID);
        AddTablesToList('ARAccountID', mtID);
        AddTablesToList('BankAccountID', mtID);
        AddTablesToList('ClearingAccountID', mtID);
        AddTablesToList('ClearingAccountID2', mtID);
        AddTablesToList('CommissionPaidAccountID', mtID);
        AddTablesToList('DeductionLiabilityAccountID', mtID);
        AddTablesToList('DeductionsPaidAccountID', mtID);
        AddTablesToList('DefaultDepositsAccount', mtID);
        AddTablesToList('DefaultPostAccountID', mtID);
        AddTablesToList('DepositsAccountID', mtID);
        AddTablesToList('ExpensesAccountID', mtID);
        AddTablesToList('FixedAssetCostAccountID', mtID);
        AddTablesToList('FixedAssetCostAccountID2', mtID);
        AddTablesToList('FixedAssetDepreciationAccountID', mtID);
        AddTablesToList('FixedAssetDepreciationAccountID2', mtID);
        AddTablesToList('FixedAssetDepreciationAssetAccountID', mtID);
        AddTablesToList('FixedAssetDepreciationAssetAccountID2', mtID);
        AddTablesToList('LabourIncomeAccountID', mtID);
        AddTablesToList('LeaveLiabilityAccountID', mtID);
        AddTablesToList('LeaveProvisionAccountID', mtID);
        AddTablesToList('LiabilityAccountID', mtID);
        AddTablesToList('MasterAccountID', mtID);
        //AddTablesToList('NoABNAccountID', mtID);
        //AddTablesToList('NoABNExpenseAccountID', mtID);
        //AddTablesToList('PAYGTaxPaidAccountID', mtID);
        AddTablesToList('PAYGTaxPayableAccountID', mtID);
        AddTablesToList('SundriesPaidAccountID', mtID);
        AddTablesToList('SuperPaidAccountID', mtID);
        AddTablesToList('SuperPayableAccountID', mtID);
        AddTablesToList('WageAccountID', mtID);
        AddTablesToList('WagesPaidAccountID', mtID);
        //Names
        AddTablesToList('AccountName', mtName);
        AddTablesToList('Account', mtName);
        AddTablesToList('INCOMEACCNT', mtName);
        AddTablesToList('ASSETACCNT', mtName);
        AddTablesToList('COGSACCNT', mtName);
      end;
  end;
end;

function TMergeObj.GetProgressDialog: TProgressInfo;
begin
  result := TProgressInfo(AppEnvVirt.Obj['ProgressInfo']);
end;

procedure TMergeObj.AccountBalanceVerify;
var
  qryCorrect, qryExisting: TERPQuery;
//  usingReportTables:Boolean;
  UserLock: TUserLock;
begin
  (*ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.MaxValue := ProgressDialog.MinValue;
  ProgressDialog.Execute;*)
  DoShowProgressbar(10, 'Updating Customer / Supplier Balances');
  //Create Queries
  qryCorrect := TERPQuery.Create(nil);
  qryExisting := TERPQuery.Create(nil);
  try
    qryCorrect.Connection  := Connection;
    qryCorrect.ParamCheck  := false;
    qryExisting.Connection := Connection;
    qryExisting.ParamCheck := false;
    qryExisting.Options.StrictUpdate := false;

    //Load Queries
    with qryCorrect do begin
      {Correct Account Balances}
      SQL.Clear;
      Sql.Add('SELECT AccountID, ');
      Sql.Add('If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC" Or AccountType = "EXINC" ');
      Sql.Add('OR AccountType = "OCLIAB",Sum(CreditsEx-DebitsEx),Sum(DebitsEx-CreditsEx)) as Balance ');
      Sql.Add('FROM tbltransactions Where not IsNull(AccountID) AND Active="T"  ');
      Sql.Add('Group By AccountID; ');
//      SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
      Open;
    end;
    (*ProgressDialog.StepIt;*)
    DoStepProgressbar('Account Balance Verify');
    //Application.ProcessMessages;
    with qryExisting do begin
      {Current Account Balances}
      SQL.Clear;
      Sql.Add('SELECT AccountID, Balance as Balance,Active ');
      Sql.Add('FROM tblchartofaccounts Where  not IsNull(AccountID); ');
      Open;
    end;
    (*ProgressDialog.StepIt;*)
    DoStepProgressbar;
    //Application.ProcessMessages;
    //Compare Queries
    (*ProgressDialog.CloseDialog;*)
    (*ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;*)
    UserLock := TUserLock.Create(nil);
    try
      with qryExisting do begin
        First;
        while not Eof do begin
          qryCorrect.Filtered := false;
          qryCorrect.Filter := 'AccountID = ' + qryExisting.FieldByName('AccountID').AsString;
          qryCorrect.Filtered := true;
          qryCorrect.Locate('AccountID', qryExisting.FieldByName('AccountID').AsInteger, [loCaseInsensitive]);
          if userlock.lock('tblchartofaccounts' ,qryExisting.FieldByName('AccountID').asInteger , 'UpdateBatch') then  try
              if not (qryExisting.FieldByName('Balance').AsCurrency = qryCorrect.FieldByName('Balance').AsCurrency) then begin
                qryExisting.Edit;
                qryExisting.FieldByName('Balance').AsCurrency := qryCorrect.FieldByName('Balance').AsCurrency;
                If (Rounding.RoundCurrency(qryExisting.FieldByName('Balance').AsCurrency)<>0.00) then qryExisting.FieldByName('Active').AsString := 'T';
                try
                  qryExisting.Post;
                except
                end;
              end else If (Rounding.RoundCurrency(qryExisting.FieldByName('Balance').AsCurrency)<>0.00) AND
                (qryExisting.FieldByName('Active').AsString <> 'T') then Begin
                qryExisting.Edit;
                qryExisting.FieldByName('Active').AsString := 'T';
                try
                  qryExisting.Post;
                except
                end;
              end;
          finally
              userlock.unlock('tblchartofaccounts' ,qryExisting.FieldByName('AccountID').asInteger , 'UpdateBatch');
          end;
          ProgressDialog.StepIt;
          //Application.ProcessMessages;     `
          Next;
        end;
      end;
    finally
       UserLock.UnlockAllCurrentInstance;
       Freeandnil(UserLock);
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
    (*ProgressDialog.CloseDialog;*)
    DoHideProgressbar;
  end;
end;

procedure TMergeObj.ClientBalanceVerify;
begin
  ClientBalanceVerify([]);
end;
procedure TMergeObj.ClientBalanceVerify(ClientIDs: array of Integer);

var
  QryCustomerBalance, QrySupplierbalance, QryClientSOCalance, qryExisting: TERPQuery;
  val: double;
//  usingReportTables:Boolean;
  UserLock: TUserLock;
  Function clientIDFilter(afieldname:String):String;
  var
    ctr:Integer;
  begin
      result := '';
      if (afieldname='') or (length(ClientIDs)=0) then exit;
      for ctr:= low(ClientIDs) to high(ClientIDs) do begin
        if result <> '' then result := result +' OR ';
        result := result + afieldname +' = ' +inttostr(ClientIDs[ctr]);
      end;
      if result <> '' then result :=  ' AND (' + REsult +')';
  end;
begin
  DoShowProgressbar(3, 'Updating Customer / Supplier Balances');
  try
    //Create Queries
    (*QryCustomerBalance := TERPQuery.Create(nil);
    QryCustomerBalance.Connection := Connection;
    QrySupplierbalance := TERPQuery.Create(nil);
    QrySupplierbalance.Connection := Connection;
    QryClientSOCalance := TERPQuery.Create(nil);
    QryClientSOCalance.Connection := Connection;
    qryExisting        := TERPQuery.Create(nil);
    qryExisting.Connection := Connection;*)
      qryExisting := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
      QrySupplierbalance:= DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
      QryClientSOCalance:= DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
      QryCustomerBalance:= DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
    try
(*      qryExisting.ParamCheck := false;
      qryExisting.Options.StrictUpdate := false;
      QrySupplierbalance.ParamCheck := false;
      QryClientSOCalance.ParamCheck := false;
      QryCustomerBalance.ParamCheck := false;*)

      //Load Queries
      with QryCustomerBalance do begin
        {Customer Balances}
        SQL.Clear;
        Sql.Add('SELECT TRANS.ClientName as CustomerName, ');
        Sql.Add('IF((TRANS.AccountType = "AR" AND TRANS.TYPE = "Customer Payment"), S.ClientID,IF(P.PrePaymentID<>0 , P.ClientID,TRANS.ClientID)) as ClientID, ');
        Sql.Add('Sum(round(DebitsInc-CreditsInc,' +inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) AS CustBalance ');
        Sql.Add('FROM tbltransactions TRANS ');
        Sql.Add('LEFT JOIN tblsales S USING(SaleID) ');
        Sql.Add('LEFT JOIN tblprepayments P ON P.PrePaymentID=TRANS.PrePaymentID ');
        Sql.Add('Where not isNull(TRANS.AccountID) ');
        Sql.Add('AND ((TRANS.AccountType = "AR" AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment")) ');
        Sql.Add('OR ((TRANS.TYPE = "'+ AppEnvVirt.Str['TcConst.CUSTOMER_PREPAYMENT'] +'" OR TRANS.TYPE = "Customer Payment") AND TRANS.AccountID=' + IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) + ')) ');
        Sql.Add('AND (DebitsEx-CreditsEx)<>0.00 ');
        //Sql.Add('AND IF((TRANS.AccountType = "AR" AND TRANS.TYPE = "Customer Payment"), S.ClientID,IF(P.PrePaymentID<>0 , P.ClientID,TRANS.ClientID)) =:ClientId');
        Sql.Add(clientIDFilter('IF((TRANS.AccountType = "AR" AND TRANS.TYPE = "Customer Payment"), S.ClientID,IF(P.PrePaymentID<>0 , P.ClientID,TRANS.ClientID))'));

        Sql.Add('Group By ClientID order by ClientID; ');
//        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        //Open;
      end;
      DoStepProgressbar('Client Balance Verify');
      with QrySupplierbalance do begin
        {Supplier Balances}
        SQL.Clear;
        Sql.Add('SELECT ');
        Sql.Add('TRANS.ClientName as SupplierName, ');
        Sql.Add('TRANS.ClientID as ClientID, ');
        Sql.Add('Sum(round(CreditsInc-DebitsInc,' +inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) AS SuppBalance ');
        Sql.Add('FROM tbltransactions TRANS ');
        Sql.Add('WHERE not isNull(TRANS.AccountID) AND  ');
        Sql.Add('((TRANS.AccountType = "AP" AND (TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment")) ');
        Sql.Add(' OR ((TRANS.TYPE = "Supplier Prepayment" OR TRANS.TYPE = "Supplier Payment") AND TRANS.AccountID=' + IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) + ')) ');
        Sql.Add('AND (DebitsEx-CreditsEx)<>0.00 ');
        //Sql.Add('AND TRANS.ClientID =:ClientID');
        Sql.Add(clientIDFilter('TRANS.ClientID'));
        Sql.Add('Group By ClientID  order by ClientID; ');
//        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        //Open;
      end;

      with QryClientSOCalance do begin
        {Sales Order Balances}
        SQL.Clear;
        SQL.add('Select ClientId, sum(ifnull(Balance,0)) Sobalance from tblSales where IsSalesOrder = "T" and converted = "F" ');
        //Sql.Add('and ClientId = :ClientId ');
        Sql.Add(clientIDFilter('ClientID'));
        Sql.Add('group by clientID  order by ClientID');
//        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        //Open;
      end;

      DoStepProgressbar;
      with qryExisting do begin
        {Current Client Balances}
        SQL.Clear;
        Sql.Add('SELECT Company,ClientID,Balance,ARBalance,APBalance,Active, SOBalance  ');
        Sql.Add('FROM tblclients ');
        Sql.Add('Where ClientID<>0');
        Sql.Add(clientIDFilter('ClientID '));
        Sql.Add('order by ClientID');
//        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        Open;
      end;
      DohideProgressbar;
      UserLock := TUserLock.Create(nil);
      try
        DoShowProgressbar(qryExisting.RecordCount + 10 , AppEnvVirt.Str['TcConst.WAITMSG']);
        qryExisting.First;

        opendb(QryCustomerBalance);
        Opendb(QrySupplierbalance);
        Opendb(QryClientSOCalance);

        while not qryExisting.Eof do begin
          QryCustomerBalance.Filtered := false;
          QryCustomerBalance.Filter := 'ClientID = ' + qryExisting.FieldByName('ClientID').AsString;
          QryCustomerBalance.Filtered := true;
          //QryCustomerBalance.Locate('ClientID', qryExisting.FieldByName('ClientID').AsInteger, [loCaseInsensitive]);
          (*closedb(QryCustomerBalance);
          QryCustomerBalance.parambyname('clientId').asInteger :=qryExisting.FieldByName('ClientID').asInteger;
          Opendb(QryCustomerBalance);*)


          QrySupplierbalance.Filtered := false;
          QrySupplierbalance.Filter := 'ClientID = ' + qryExisting.FieldByName('ClientID').AsString;
          QrySupplierbalance.Filtered := true;
          //QrySupplierbalance.Locate('ClientID', qryExisting.FieldByName('ClientID').AsInteger, [loCaseInsensitive]);
          (*closedb(QrySupplierbalance);
          QrySupplierbalance.parambyname('clientId').asInteger :=qryExisting.FieldByName('ClientID').asInteger;
          Opendb(QrySupplierbalance);*)

          val:= QryCustomerBalance.FieldByName('CustBalance').AsFloat - QrySupplierbalance.FieldByName('SuppBalance').AsFloat;
          if Abs(val) < 0.01 then val:= 0 else val:= Rounding.Round(val,AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']);
          if userlock.lock('tblclients' ,qryExisting.FieldByName('clientID').asInteger , 'UpdateBatch') then  try
                if qryExisting.FieldByName('Balance').AsCurrency <> val then begin
                  qryExisting.Edit;
                  qryExisting.FieldByName('Balance').AsCurrency := val;
                  try
                    qryExisting.Post;
                  except
                  end;
                end;

                val:= QryCustomerBalance.FieldByName('CustBalance').AsFloat;
                if Abs(val) < 0.01 then val:= 0 else val:= Rounding.Round(val,AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']);
                if qryExisting.FieldByName('ARBalance').AsCurrency <> Currency(val) then begin
                  qryExisting.Edit;
                  qryExisting.FieldByName('ARBalance').AsCurrency := val;
                  try
                    qryExisting.Post;
                  except
                  end;
                end;

                val:= QrySupplierbalance.FieldByName('SuppBalance').AsFloat;
                if Abs(val) < 0.01 then val:= 0 else val:= Rounding.Round(val,AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']);
                if qryExisting.FieldByName('APBalance').AsCurrency <> Currency(val) then begin
                  qryExisting.Edit;
                  qryExisting.FieldByName('APBalance').AsCurrency := val;
                  try
                    qryExisting.Post;
                  except
                  end;
                end;


                If ((Rounding.RoundCurrency(qryExisting.FieldByName('Balance').AsCurrency)<>0.00) OR
                    (Rounding.RoundCurrency(qryExisting.FieldByName('ARBalance').AsCurrency)<>0.00) OR
                    (Rounding.RoundCurrency(qryExisting.FieldByName('APBalance').AsCurrency)<>0.00)) AND (qryExisting.FieldByName('Active').AsString <> 'T') then Begin
                    qryExisting.Edit;
                    qryExisting.FieldByName('Active').AsString := 'T';
                    try
                      qryExisting.Post;
                    except
                    end;
                end;

                QryClientSOCalance.Filtered := false;
                QryClientSOCalance.Filter := 'ClientID = ' + qryExisting.FieldByName('ClientID').AsString;
                QryClientSOCalance.Filtered := true;
                (*closedb(QryClientSOCalance);
                QryClientSOCalance.parambyname('clientId').asInteger :=qryExisting.FieldByName('ClientID').asInteger;
                Opendb(QryClientSOCalance);*)


                if QryClientSOCalance.fieldbyname('Sobalance').asFloat <>QryExisting.FieldByname('SOBalance').asfloat then begin
                  if QryExisting.State in [dsEdit,dsInsert] then else QryExisting.Edit;
                  QryExisting.FieldByname('SOBalance').asfloat := QryClientSOCalance.fieldbyname('Sobalance').asFloat;
                  if QryExisting.State in [dsEdit,dsInsert] then QryExisting.Post;
                end;
          finally
                 userlock.unlock('tblclients' ,qryExisting.FieldByName('clientID').asInteger , 'UpdateBatch');
          end;
          DoStepProgressbar('Updating Customer / Supplier Balances : ' +inttostr(qryExisting.recno)+' of '+ inttostr(qryExisting.recordcount));
          qryExisting.Next;
        end;
      finally
        UserLock.UnlockAllCurrentInstance;
        Freeandnil(UserLock);
      end;
      QryCustomerBalance.Close;
      QrySupplierbalance.Close;
      QryClientSOCalance.Close;
      qryExisting.Close;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(QryCustomerBalance);
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(QrySupplierbalance);
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryExisting);
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(QryClientSOCalance);
    end;
  finally
    DoHideProgressbar;
  end;
end;
procedure TMergeObj.ScriptMergeUpdateOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue;
end;
(*procedure TMergeObj.Merge(const MergeType: TMergeType; const PrincipleName: string;
  const PrincipleID: integer; const SecordaryName: string; const SecordaryID: integer);
var
  MFCount, TableCount, I: integer;
  dsTables: TERPQuery;
  qryMergeUpdate: TERPCommand;
  TableName: string;
  pMergeField: pMergeFieldRec;

  function HasPrimaryContact(const clientID: Integer): Boolean;
  var
    qry: TERPQuery;
  begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection;
      qry.SQL.Text := 'Select ContactId from tblcontacts ' + ' where ClientId = ' +
        IntToStr(clientID);
      qry.Open;
      Result := qry.RecordCount <> 0;
    finally
      qry.Free;
    end;
  end;

  Procedure SetNoPrimaryContact(const clientID: Integer);
  var
    cmd: TERPCommand;
  begin
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := Connection;
      cmd.SQL.Text := 'update tblcontacts Set isprimarycontact ="F" ' +
        ' where ClientId = ' + IntToStr(clientID) +
        ' and isprimarycontact = "T"';
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;

begin
  GetMergeFieldList(MergeType);
  //############################
  //Update ID & Names In All Tables
//  ProgressDialog := TProgressDialog.Create(nil);
  dsTables := TERPQuery.Create(nil);
  qryMergeUpdate := TERPCommand.Create(nil);
  dsTables.Connection := Connection;
  qryMergeUpdate.Connection := Connection;
  try
    if MergeType =mClient then
      if HasPrimaryContact(PrincipleID) then SetNoPrimaryContact( SecordaryID);
    ProgressDialog.Caption  := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step     := 1;
    dsTables.Sql.Text       := 'Show Tables;';
    dsTables.Open;
    with dsTables do begin
      if RecordCount > 0 then begin
        TableCount := RecordCount;
        ProgressDialog.MaxValue := TableCount;
        ProgressDialog.Execute;
        First;
        for I := 0 to TableCount - 1 do begin
          TableName := dsTables.Fields[0].AsString;
          for MFCount := 0 to LstMergeField.Count - 1 do begin
            pMergeField := LstMergeField.Items[MFCount];
            case pMergeField^.FieldType of
              //ID's
              mtID:
                begin
                  try
                    qryMergeUpdate.Sql.Clear;
                    qryMergeUpdate.Sql.Add('UPDATE ' + TableName + ' SET ' + pMergeField^.FieldName +
                      ' =' + IntToStr(PrincipleID) + ' WHERE ' + pMergeField^.FieldName + ' = ' + IntToStr(SecordaryID) + ';');
                    qryMergeUpdate.Execute;
                  except
                    on E: EMyError do;
                    on E: EMySqlException do;
                    else raise;
                  end;
                end;
              //Names
              mtName:
                begin
                  try
                    qryMergeUpdate.Sql.Clear;
                    qryMergeUpdate.Sql.Add('UPDATE ' + TableName + ' SET '   + pMergeField^.FieldName + ' =' + QuotedStr(PrincipleName) +
                                                                   ' WHERE ' + pMergeField^.FieldName + ' = ' + QuotedStr(SecordaryName) );
                    if  pMergeField^.IDfieldName <> '' then qryMergeUpdate.Sql.Add(' AND ' +pMergeField^.IDfieldName  +' = ' + IntToStr(SecordaryID)) ;

                    qryMergeUpdate.Execute;
                  except
                    on E: EMyError do;
                    on E: EMySqlException do;
                    else raise;
                  end;
                end;
            end;
          end;
          ProgressDialog.Stepit;
          //Application.ProcessMessages;
          Next;
        end;
        ProgressDialog.CloseDialog;
      end;
    end;
    //############################
    //Balances Qtys Etc
//    RefreshTblTransactions;
    case MergeType of
      {Merge Clients}
      mClient:
        begin
          if not AppEnvVirt.Bool['DNMLib.IsTransTableEmpty'] then begin
            ClientBalanceVerify;
          end;
        end;
      {Merge Products}
      mProduct:
        begin
          MergeQtys(SecordaryID, PrincipleID);
        end;
      {Merge Accounts}
      mAccount:
        begin
          if not AppEnvVirt.Bool['DNMLib.IsTransTableEmpty'] then begin
            AccountBalanceVerify;
          end;
        end;
      mUOM:
        begin

        end;
    end;
    //############################
    //Remove Deactive Secondary Record
    case MergeType of
      {Merge Clients}
      mClient:
        begin
          try
            qryMergeUpdate.Sql.Clear;
            qryMergeUpdate.Sql.Add('UPDATE tblclients SET Active =' + QuotedStr('F') +
              ' WHERE ClientID = ' + IntToStr(SecordaryID) + ';');
            qryMergeUpdate.Execute;

//            qryMergeUpdate.Sql.Clear;
//            qryMergeUpdate.Sql.Add('UPDATE tblclients SET ');
//            qryMergeUpdate.Execute;
          except
            on E: EMyError do;
          end;
        end;
      {Merge Products}
      mProduct:
        begin
          try
            qryMergeUpdate.Sql.Clear;
            qryMergeUpdate.Sql.Add('UPDATE tblparts SET Active =' + QuotedStr('F') + ' WHERE PARTSID = ' +
              IntToStr(SecordaryID) + ';');
            qryMergeUpdate.Execute;
          except
            on E: EMyError do;
          end;
        end;
      {Merge Accounts}
      mAccount:
        begin
          try
            qryMergeUpdate.Sql.Clear;
            qryMergeUpdate.Sql.Add('UPDATE tblchartofaccounts SET Active =' + QuotedStr('F') +
              ' WHERE AccountID = ' + IntToStr(SecordaryID) + ';');
            qryMergeUpdate.Execute;
          except
            on E: EMyError do;
          end;
        end;
      mUOM:
        begin
          try
            qryMergeUpdate.Sql.Clear;
            qryMergeUpdate.Sql.Add('UPDATE tblunitsofmeasure SET Active =' + QuotedStr('F') +
              ' WHERE UnitID = ' + IntToStr(SecordaryID) + ';');
            qryMergeUpdate.Execute;
          except
            on E: EMyError do;
          end;
        end;
    end;
  finally
    FreeAndNil(dsTables);
//    FreeAndNil(ProgressDialog);
    FreeAndNil(qryMergeUpdate);
  end;
  MergeDataFields(MergeType,PrincipleID,SecordaryID);
end;*)
Function TMergeObj.AllTablesof(const MergeType: TMergeType; onlynamefields:Boolean =False):String;
var
  MFCount:Integer;
  pMergeField: pMergeFieldRec;
begin
  Result := '';
  GetMergeFieldList(MergeType);
  for MFCount := 0 to LstMergeField.Count - 1 do begin
          pMergeField := LstMergeField.Items[MFCount];
          if onlynamefields and (pMergeField^.FieldType = mtID) then continue;
          if Result<> '' then Result:=Result+ ' union all ';
          Result:= Result + 'SELECT table_name , column_name, ';
          if pMergeField^.FieldType = mtID then Result:= Result +'1 as FieldType,'                                          else Result:= Result +'2 as FieldType,' ;
          if pMergeField^.FieldType = mtID then Result:= Result + ' ' + quotedstr(pMergeField^.fieldname)+ ' as IDFieldName ' else Result:= Result + ' ' + quotedstr(pMergeField^.IDfieldname)+' as IDFieldName' ;
          Result:= Result + ' FROM INFORMATION_SCHEMA.COLUMNS '+
                  ' WHERE  TABLE_SCHEMA =  '+ quotedstr(AppEnvvirt.Str['CompanyPrefs.DBName'])+
                  ' and column_name LIKE  '+ quotedstr(pMergeField^.FieldName) ;
  end;
  if Result<> '' then begin
    Result:= Result +' order by table_name  ,fieldtype desc';
  end;
end;

procedure TMergeObj.Merge(const MergeType: TMergeType; const PrincipleName: string;
  const PrincipleID: integer; const SecordaryName: string; const SecordaryID: integer; qrySchema:TERPQuery = nil;ProgressMsg :String = '');
var
  MFCount: integer;
  ScriptMergeUpdate: TERPScript;
  pMergeField: pMergeFieldRec;
  s:String;
  fqrySchema: TERPQuery;

  function HasPrimaryContact(const clientID: Integer): Boolean;
  var
    qry: TERPQuery;
  begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection;
      qry.SQL.Text := 'Select ContactId from tblcontacts ' + ' where ClientId = ' +
        IntToStr(clientID);
      qry.Open;
      Result := qry.RecordCount <> 0;
    finally
      qry.Free;
    end;
  end;

  Procedure SetNoPrimaryContact(const clientID: Integer);
  var
    cmd: TERPCommand;
  begin
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := Connection;
      cmd.SQL.Text := 'update tblcontacts Set isprimarycontact ="F" ' +
        ' where ClientId = ' + IntToStr(clientID) +
        ' and isprimarycontact = "T"';
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
begin
  GetMergeFieldList(MergeType);
  ScriptMergeUpdate := TERPScript.Create(nil);
  try
    ScriptMergeUpdate.Connection := Connection;
    ScriptMergeUpdate.OnError :=ScriptMergeUpdateOnError;

    if MergeType =mClient then if HasPrimaryContact(PrincipleID) then SetNoPrimaryContact( SecordaryID);
    if ProgressMsg <> '' then ProgressDialog.Caption  := ProgressMsg else ProgressDialog.Caption  := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step     := 1;
    ProgressDialog.MaxValue := LstMergeField.Count ;
    ProgressDialog.Execute;
      s:= '';
      for MFCount := 0 to LstMergeField.Count - 1 do begin
          pMergeField := LstMergeField.Items[MFCount];
          if s<> '' then s:=s+ ' union all ';
          s:= s + 'SELECT '+
                  'table_name , column_name, ';
          if pMergeField^.FieldType = mtID then s:= s +'1 as FieldType,'                                          else s:= s +'2 as FieldType,' ;
          if pMergeField^.FieldType = mtID then s:= s + ' ' + quotedstr(pMergeField^.fieldname)+ ' as IDFieldName ' else s:= s + ' ' + quotedstr(pMergeField^.IDfieldname)+' as IDFieldName' ;
          s:= s + ' FROM INFORMATION_SCHEMA.COLUMNS '+
                  ' WHERE  TABLE_SCHEMA =  '+ quotedstr(AppEnvvirt.Str['CompanyPrefs.DBName'])+
                  ' and column_name LIKE  '+ quotedstr(pMergeField^.FieldName) ;
      end;
      if s<> '' then begin
        s:= s +' order by table_name  ,fieldtype desc';
        ScriptMergeUpdate.SQL.Clear;
        if qrySchema = nil then begin
          fqrySchema:= TERPQuery.Create(nil);
          fqrySchema.Connection := Connection ;
        end else begin
          fqrySchema := qrySchema;
        end;
        if (fqrySchema.Active = False) or (not(SameTExt(trim(fqrySchema.SQL.Text) , trim(s)))) then begin
          closedb(fqrySchema);
          fqrySchema.SQL.Clear;
          fqrySchema.SQL.Text := s;
          if s <> '' then openDB(fqrySchema);
        end;

        with fqrySchema do begin
          if recordcount >0 then begin
            First;
            While Eof = False do begin
                ProgressDialog.Stepit;
                if Fieldbyname('FieldType').AsInteger = 1 then begin
                    ScriptMergeUpdate.SQL.Add('update ' +fieldbyname('table_name').asString +'  SET ' +fieldbyname('column_name').asString +' = ' + inttostr(PrincipleID) +
                                                                                            ' WHERE ' +fieldbyname('column_name').asString +' = ' + inttostr(SecordaryID)+'; ');
                end else if fieldbyname('IDfieldname').asString  <> '' then begin
                    ScriptMergeUpdate.SQL.Add('update ' +fieldbyname('table_name').asString +'  SET ' +fieldbyname('column_name').asString +' = ' + quotedstr(PrincipleName) +
                                                                                            //' WHERE ' +fieldbyname('column_name').asString +' = ' + quotedstr(SecordaryName)+
                                                                                            '  WHERE  ' +fieldbyname('IDfieldname').asString +' = ' + inttostr(SecordaryID)+'; ');
                end else begin
                    ScriptMergeUpdate.SQL.Add('update ' +fieldbyname('table_name').asString +'  SET ' +fieldbyname('column_name').asString +' = ' + quotedstr(PrincipleName) +
                                                                                            ' WHERE ' +fieldbyname('column_name').asString +' = ' + quotedstr(SecordaryName)+'; ');
                end;
                Next;
            end;
          end;
        end;
      end;
      ScriptMergeUpdate.execute;
      ProgressDialog.Stepit;
      ScriptMergeUpdate.SQL.Clear;
    case MergeType of
      mClient: if not AppEnvVirt.Bool['DNMLib.IsTransTableEmpty'] then ClientBalanceVerify([PrincipleID,SecordaryID]) ;
      mAccount:if not AppEnvVirt.Bool['DNMLib.IsTransTableEmpty'] then AccountBalanceVerify;
      mProduct: MergeQtys(SecordaryID, PrincipleID);
      mUOM:
    end;

    ScriptMergeUpdate.Sql.Clear;
    try
      ProgressDialog.Stepit;
      case MergeType of
        mClient:{Merge client}
          begin
              ScriptMergeUpdate.Sql.Add('UPDATE tblclients SET Active =' + QuotedStr('F') +' WHERE ClientID = ' + IntToStr(SecordaryID) + ';');
              ProgressDialog.Message := 'Updating Client';
          end;
        mProduct:{Merge Products}
          begin
              ScriptMergeUpdate.Sql.Add('UPDATE tblparts SET Active =' + QuotedStr('F') + ' WHERE PARTSID = ' +
                IntToStr(SecordaryID) + ';');
              ProgressDialog.Message := 'Updating Product';
          end;
        mAccount:{Merge Accounts}
          begin
              ScriptMergeUpdate.Sql.Add('UPDATE tblchartofaccounts SET Active =' + QuotedStr('F') +
                ' WHERE AccountID = ' + IntToStr(SecordaryID) + ';');
              ProgressDialog.Message := 'Updating chart of Accounts';
          end;
        mUOM:{Merge UOM}
          begin
              ScriptMergeUpdate.Sql.Add('UPDATE tblunitsofmeasure SET Active =' + QuotedStr('F') +
                ' WHERE UnitID = ' + IntToStr(SecordaryID) + ';');
              ProgressDialog.Message := 'Updating UOM';
          end;
      end;
    finally
      if ScriptMergeUpdate.SQL.count >0 then begin
        ScriptMergeUpdate.Execute;
        ScriptMergeUpdate.SQL.Clear;
      end;
    end;
    ProgressDialog.Stepit;

  finally
    if qrySchema = nil then FreeandNil(fqrySchema);
    FreeAndNil(ScriptMergeUpdate);
  end;
  MergeDataFields(MergeType,PrincipleID,SecordaryID);
end;

procedure TMergeObj.MergeQtys(FromID, ToID: integer);
var
  qryTemp1: TERPQuery;
begin
  qryTemp1 := TERPQuery.Create(nil);
  qryTemp1.Connection := Connection;
  try
    qryTemp1.Sql.Add('insert into tblProductclasses ');
    qryTemp1.Sql.Add('(ProductID, ProductName , ProductGroup,ClassID,ClassName,ReOrderPoint,');
    qryTemp1.Sql.Add('PreferredLevel,ReOrderAmount,LastAdj,LastAdjAccount,ClassPriceVariance,');
    qryTemp1.Sql.Add('VariantPrice,NextStocktakeDate)');
    qryTemp1.Sql.Add('SELECT');
    qryTemp1.Sql.Add(intTostr(ToID)+',P.PartName,ToProduct.ProductGroup,');
    qryTemp1.Sql.Add('ToProduct.ClassID,ToProduct.ClassName,ToProduct.ReOrderPoint,');
    qryTemp1.Sql.Add('ToProduct.PreferredLevel,ToProduct.ReOrderAmount,');
    qryTemp1.Sql.Add('ToProduct.LastAdj,ToProduct.LastAdjAccount,ToProduct.ClassPriceVariance,');
    qryTemp1.Sql.Add('ToProduct.VariantPrice,ToProduct.NextStocktakeDate');
    qryTemp1.Sql.Add('from tblProductclasses ToProduct ');
    qryTemp1.Sql.Add('inner join tblParts as P on P.PartsId = ' +intTostr(ToID));
    qryTemp1.Sql.Add('where ToProduct.active = "T" and ToProduct.ProductId = ' + intTostr(FromID) );
    qryTemp1.Sql.Add(' and ClassID not in ');
    qryTemp1.Sql.Add('(Select ClassID from tblProductclasses as fromProduct ');
    qryTemp1.Sql.Add('where fromProduct.ProductID = ' + intTostr(ToID)+');');
    qryTemp1.Sql.Add('DELETE FROM tblProductClasses');
    qryTemp1.Sql.Add('WHERE ProductID  = ' + IntToStr(FromID) + ';');
    qryTemp1.Execute;
  finally
      Freeandnil(qryTemp1);
  end;
end;

procedure TMergeObj.MergeDataFields(const MergeType: TMergeType;
  const PrincipleID, SecordaryID: integer);
var
  script: TERPScript;
const
  CustStrFldList =
    'custfld1,custfld2,custfld3,custfld4,custfld5,'+
    'custfld6,custfld7,custfld8,custfld9,custfld10,' +
    'custfld11,custfld12,custfld13,custfld14,custfld15';
  CustDateFldList =
    'custdate1,custdate2,custdate3';
  ClientNameFields =
    'title,firstname,lastname,jobtitle';
  ClientInfoFields =
    'clienttypeid,phone,faxnumber,mobile,altphone,altcontact,DefaultContactMethod';
  ClientGeneralFields =
    'CreationDate,shippingid,PickingPriority,DischargeDate,DefaultInvoiceTemplateID,' +
    'DefaultDeliveryTemplateID,Area,MedTypeID,RepID,PhoneSupportTill,' +
    'InvoiceCommentPopUp,InvoiceComment,POComment,POCommentpopup,DeliveryNotes,DontContact,IncludeOnIntrastat';
  ClientPhysicalAddressFields =
    'street,street2,street3,Suburb,state,postcode,country';
  ClientBillToAddressFields =
    'billstreet,billstreet2,billstreet3,billSuburb,billstate,billpostcode,billcountry';
  ClientAddressGeneralFields =
    'Email,EmailXML,SendXMLInvoices,url,DefaultClass,SendXMLPOs,EmailPOXML';
  ClientDiscountFields =
    'Discount,SpecialDiscount';

  procedure AddFields(const FieldList, TableName, IdFieldName: string; Condition: string = '');
  var
    x: integer;
    sl: TStringList;
  begin
    sl:= TStringList.Create;
    try
      sl.CommaText:= FieldList;
      for x:= 0 to sl.Count -1 do begin
        if Condition <> '' then begin
          { updating a bunch of related fields }
          if x = 0 then begin
            script.SQL.Add('update ' + TableName + ' t1');
            script.SQL.Add('inner join ' + TableName + ' t2 on t2.' + IdFieldName + ' = ' + IntToStr(SecordaryID));
            script.SQL.Add('set');
          end;
          if x > 0 then
            script.SQL.Add(',t1.' + sl[x] + ' = t2.' + sl[x])
          else
            script.SQL.Add('t1.' + sl[x] + ' = t2.' + sl[x]);
        end
        else begin
          { indervidual filds }
          script.SQL.Add('update ' + TableName + ' t1');
          script.SQL.Add('inner join ' + TableName + ' t2 on t2.' + IdFieldName + ' = ' + IntToStr(SecordaryID));
          script.SQL.Add('set t1.' + sl[x] + ' = t2.' + sl[x]);
          script.SQL.Add('where t1.' + IdFieldName + ' = ' + IntToStr(PrincipleID));
          script.SQL.Add('and not isnull(t2.'+ sl[x] + ');');
        end;
      end;
      if Condition <> '' then begin
        script.SQL.Add('where t1.' + IdFieldName + ' = ' + IntToStr(PrincipleID));
        script.SQL.Add('and ' + condition + ';');
      end;
    finally
      sl.Free;
    end;
  end;

begin
  script:= TERPScript.Create(nil);
  try
    script.Connection:= Connection;
    case MergeType of
      mClient:
        begin
          AddFields(CustStrFldList              ,'tblclients','clientid');
          AddFields(CustDateFldList             ,'tblclients','clientid');
          AddFields(ClientNameFields            ,'tblclients','clientid', '((not isnull(t2.lastname)) or (not isnull(t2.firstname)))');
          AddFields(ClientInfoFields            ,'tblclients','clientid');
          AddFields(ClientGeneralFields         ,'tblclients','clientid');
          AddFields(ClientPhysicalAddressFields ,'tblclients','clientid','((not isnull(t2.street)) or (not isnull(t2.street2)) or (not isnull(t2.street3)))');
          AddFields(ClientBillToAddressFields   ,'tblclients','clientid', '((not isnull(t2.billstreet)) or (not isnull(t2.billstreet2)) or (not isnull(t2.billstreet3)))');
          AddFields(ClientAddressGeneralFields  ,'tblclients','clientid');
          AddFields(ClientDiscountFields        ,'tblclients','clientid');
        end;
      mProduct:
        begin
          AddFields(CustStrFldList,'tblparts','partsid');
        end;
      mAccount:
        begin
          exit; { no custom fields to merge }
        end;
      mUOM:
        begin
          exit; { no custom fields to merge }
        end;
    end;
    script.Execute;
  finally
    script.Free;
  end;
end;

end.

