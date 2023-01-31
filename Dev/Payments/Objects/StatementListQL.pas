unit StatementListQL;

interface

uses
  classes, ReportBaseObj,ERPDbComponents;

Type
  TStatementBase = Class(TReportWithDateRangeBase)
  Private
(*    fDateTo               : TDateTime;
    fDateFrom             : TDateTime;
    fbIgnoreDates: boolean;
    function getDateTo: TDateTime;
    function getDateFrom: TDateTime;*)
  Protected
    //fbPendingPaymentsOnly : Boolean;
(*    function DateFromSQL      : string;
    function DateToSQL        : string;*)
    function StatementSQL(SQL       : TStrings;
                          aclientID : Integer;
                          fdOpeningBalance         : Double = 0;
                          fdForeignOpeningBalance  : Double = 0;
                          fdclosingBalance         : Double = 0;
                          fdForeignclosingBalance  : Double = 0):String;
  Public
    //Property PendingPaymentsOnly    : Boolean   read fbPendingPaymentsOnly write fbPendingPaymentsOnly ;
    constructor Create; Override;
    Function OpeningBalanceQry(const aClientID:Integer) :TERPQuery;
    Function closingBalanceQry(const aClientID:Integer) :TERPQuery;
  Published
(*    property DateFrom               : TDateTime read getDateFrom    write fDateFrom  ;
    property DateTo                 : TDateTime read getDateTo      write fDateTo  ;
    Property IgnoreDates            : boolean   read fbIgnoreDates  write fbIgnoreDates;*)
  End;

  TStatementList = Class(TStatementBase)
  Private
  Protected
  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  End;

  TStatementForCustomer = Class(TStatementBase)
  Private
    fiClientId :Integer;
    fsCustomername :String;
  Protected
  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
    Property ClientID :Integer read fiClientId write fiClientId;
    Property Customername : String read fsCustomername write fsCustomername;
  End;

implementation

uses AppEnvironment, Sysutils, ProductQtyLib ;

{TStatementBase}
constructor TStatementBase.Create;
begin
  inherited;
(*  fDateTo       := date;
  fDateFrom     := incday(Date,-30);
  fbIgnoreDates := False;*)
  //fbPendingPaymentsOnly := False;
end;
(*function TStatementBase.DateFromSQL: string;
begin
  REsult := DateSQL(DateFrom, 'DateFrom');
end;
function TStatementBase.DateToSQL: string;
begin
  REsult := DateSQL(DateTo, 'DateTo');
end;
function TStatementBase.getDateFrom: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMinDatetime
  else Result := dateof(fDateFrom);
end;

function TStatementBase.getDateTo: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMaxDatetime
  else Result := IncSecond(IncDay(dateof(fDateTo), 1), -1);
end;*)

Function TStatementBase.OpeningBalanceQry(const aClientID:Integer) :TERPQuery;
begin
With SharedQuery do begin
    if active then close;
    SQL.Clear;
    StatementSQL(SQL,aclientId);
    SQL.Text := 'SELECT SUM(Amount) AS amount, SUM(ForeignAmount) AS ForeignAmount FROM ( '+SQL.Text +') as MainSQL';
    Open;
  end;
  Result := SharedQuery;
end;
Function TStatementBase.closingBalanceQry(const aClientID:Integer) :TERPQuery;
begin
With SharedQuery do begin
    if active then close;
    SQL.Clear;
    StatementSQL(SQL, aClientID);
    SQL.Text := 'SELECT SUM(Amount) AS amount, SUM(ForeignAmount) AS ForeignAmount FROM ( '+SQL.Text +') as MainSQL';
    Open;
  end;
  Result := SharedQuery;
end;

function TStatementBase.StatementSQL(SQL: TStrings;
                                     aclientID:Integer;
                                     fdOpeningBalance         : Double=0;
                                     fdForeignOpeningBalance  : Double=0;
                                     fdclosingBalance         : Double=0;
                                     fdForeignclosingBalance  : Double=0):String;
var
  st:TStrings;

  Procedure ClientFields(clientAlias:String );
  begin
    clientAlias := trim(clientAlias);
    if clientAlias <> '' then clientAlias := trim(clientAlias)+'.';
    ST.Add(clientAlias +'BillStreet   as BillStreet,');
    ST.Add(clientAlias +'BillStreet2  as BillStreet2,');
    ST.Add(clientAlias +'BillSuburb   as BillSuburb,');
    ST.Add(clientAlias +'BillState    as BillState,');
    ST.Add(clientAlias +'BillCountry  as BillCountry,');
    ST.Add(clientAlias +'BillPostcode as BillPostcode,');

    ST.Add(clientAlias +'POSuburb     as POSuburb,');
    ST.Add(clientAlias +'POState      as POState,');
    ST.Add(clientAlias +'POCountry    as POCountry,');
    ST.Add(clientAlias +'POPostcode   as POPostcode,');

    ST.Add(clientAlias +'Street       as Street,');
    ST.Add(clientAlias +'Street2      as Street2,');
    ST.Add(clientAlias +'Street3      as Street3,');
    ST.Add(clientAlias +'State        as State,');
    ST.Add(clientAlias +'Postcode     as Postcode,');
    ST.Add(clientAlias +'Email        as Email,');
    ST.Add(clientAlias +'Phone        as Phone');

  end;
begin
  if SQL<> nil then ST := SQL else st:=TStrings.Create;
  try
   ST.add('SELECT');
   ST.add('1 as TranstypeNo,');
   ST.add('S.ClientID           AS ClientID,');
   ST.add('S.SaleID             AS SaleID,');
   ST.add('D.PaymentId          AS PaymentId,');
   ST.add('null                 AS PrePaymentID,');
   ST.add('S.CustomerName       AS CustomerName,');
   ST.add('"Payment"            AS Transtype,');
   ST.add('D.PaymentDate        AS transdate,');
   ST.add('PM.NAME              AS Paymethod ,');
   ST.add('D.Notes              AS Notes,');
   ST.add('D.ReferenceNo        AS Refno,');
   ST.add('0-DL.Payment         AS Amount,');
   ST.add('0-DL.ForeignPayment  AS Foreignamount,');
   ST.add('if(ifnull(D.ForeignExchangeCode,"")="", '+Quotedstr(Appenv.RegionalOptions.ForeignExDefault)+' , D.ForeignExchangeCode) AS ForeignExchangeCode,');
   ST.add('if(ifnull(D.ForeignExchangeRate,0)=0, 1, D.ForeignExchangeRate)  AS ForeignExchangeRate ,');
   ST.add(Floattostr(fdOpeningBalance         ) +' AS   OpeningBalance,');
   ST.add(Floattostr(fdForeignOpeningBalance  ) +' AS   ForeignOpeningBalance,');
   ST.add(Floattostr(fdclosingBalance         ) +' AS   closingBalance,');
   ST.add(Floattostr(fdForeignclosingBalance  ) +' AS   ForeignclosingBalance,');
   ST.add(SplitField('CL', 'Company', 1)+' as ClientName, ');
   ST.add(SplitField('CL', 'Company', 2)+' as Jobname, ');
   ST.add('Null as Duedate,');
   ST.add('Null as Paidamt,');
   ClientFields('CL');
   ST.add('From tbldeposits D');
   ST.add('inner join tblpaymentmethods PM on D.PayMethodID = PM.PayMethodID');
   ST.add('inner join tbldepositline DL on D.PaymentID = DL.PaymentID and DL.Trntype = "Invoice"');
   ST.add('inner join  tblsales AS S  on DL.saleId = S.saleID');
   ST.add('inner join tblclients CL on CL.clientId = S.ClientID');
   ST.add('Where D.PaymentDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
   if aclientID <> 0 then ST.add('AND (S.clientId ='+inttostr(aclientID)+')');

   ST.add('UNION ALL');
   ST.add('SELECT');
   ST.add('2 as TranstypeNo,');
   ST.add('S.ClientID           AS ClientID,');
   ST.add('S.saleId             AS saleId,');
   ST.add('null                 AS PaymentId,');
   ST.add('null                 AS PrePaymentID,');
   ST.add('S.customername       AS customername,');
   ST.add('"Invoice"            AS Transtype,');
   ST.add('S.saleDate           AS transdate,');
   ST.add('NULL                 AS paymentmethod,');
   ST.add('S.Comments           AS Notes,');
   ST.add('S.InvoiceDocNumber   AS Refno,');
   ST.add('S.TotalAmountInc     AS Amount,');
   ST.add('S.ForeignTotalAmount AS foreignamount,');
   ST.add('if(ifnull(S.ForeignExchangeCode,"")="", '+Quotedstr(Appenv.RegionalOptions.ForeignExDefault)+' , S.ForeignExchangeCode) AS ForeignExchangeCode,');
   ST.add('if(ifnull(S.ForeignExchangeRate,0)=0, 1, S.ForeignExchangeRate)  AS ForeignExchangeRate ,');
   ST.add(Floattostr(fdOpeningBalance         ) +' AS   OpeningBalance,');
   ST.add(Floattostr(fdForeignOpeningBalance  ) +' AS   ForeignOpeningBalance,');
   ST.add(Floattostr(fdclosingBalance         ) +' AS   closingBalance,');
   ST.add(Floattostr(fdForeignclosingBalance  ) +' AS   ForeignclosingBalance,');
   ST.add(SplitField('CL', 'Company', 1)+' as ClientName, ');
   ST.add(SplitField('CL', 'Company', 2)+' as Jobname ,');
   ST.add('S.DueDate as Duedate,');
   ST.add('S.Payment as Paidamt,');
   ClientFields('CL');
   ST.add('FROM tblsales AS S');
   ST.add('inner join tblclients CL on CL.clientId = S.ClientID');
   ST.add('WHERE (S.isinvoice ="T" OR S.IsRefund="T") AND S.TotalAmountInc <> 0');
   ST.add('AND S.SaleDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
   if aclientID <> 0 then ST.add('AND (S.clientId ='+inttostr(aclientID)+')');

   ST.add('UNION ALL');
   ST.add('SELECT');
   ST.add('3 as TranstypeNo,');
   ST.add('PP.ClientID          AS ClientID,');
   ST.add('NULL                 AS SaleID,');
   ST.add('D.PaymentId          AS PaymentId,');
   ST.add('PP.PrePaymentID      AS PrePaymentID,');
   ST.add('PP.CompanyName       AS CustomerName,');
   ST.add('"Payment"            AS Transtype,');
   ST.add('D.PaymentDate        AS transdate,');
   ST.add('PM.NAME              AS Paymethod ,');
   ST.add('D.Notes              AS Notes,');
   ST.add('D.ReferenceNo        AS Refno,');
   ST.add('0-DL.Payment         AS Amount,');
   ST.add('0-DL.ForeignPayment  AS Foreignamount,');
   ST.add('if(ifnull(D.ForeignExchangeCode,"")="", '+Quotedstr(Appenv.RegionalOptions.ForeignExDefault)+' , D.ForeignExchangeCode) AS ForeignExchangeCode,');
   ST.add('if(ifnull(D.ForeignExchangeRate,0)=0, 1, D.ForeignExchangeRate)  AS ForeignExchangeRate ,');
   ST.add(Floattostr(fdOpeningBalance         ) +' AS   OpeningBalance,');
   ST.add(Floattostr(fdForeignOpeningBalance  ) +' AS   ForeignOpeningBalance,');
   ST.add(Floattostr(fdclosingBalance         ) +' AS   closingBalance,');
   ST.add(Floattostr(fdForeignclosingBalance  ) +' AS   ForeignclosingBalance,');
   ST.add(SplitField('CL', 'Company', 1)+' as ClientName, ');
   ST.add(SplitField('CL', 'Company', 2)+' as Jobname ,');
   ST.add('Null as Duedate,');
   ST.add('Null as Paidamt,');
   ClientFields('CL');
   ST.add('From tbldeposits D');
   ST.add('inner join tblpaymentmethods PM ON D.PayMethodID = PM.PayMethodID');
   ST.add('inner join tbldepositline DL on D.PaymentID = DL.PaymentID and DL.Trntype = "Prepayment"');
   ST.add('inner join  tblprepayments AS PP  on DL.PrePaymentID = PP.PrePaymentID AND PP.customer="T"');
   ST.add('inner join tblclients CL on CL.clientId = PP.ClientID');
   ST.add('Where  D.PaymentDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
   if aclientID <> 0 then ST.add('AND (PP.ClientID ='+inttostr(aclientID)+')');

   ST.add('UNION ALL');
   ST.add('SELECT');
   ST.add('4                    AS TranstypeNo,');
   ST.add('PP.ClientID          AS ClientID,');
   ST.add('Null                 AS saleId,');
   ST.add('Null                 AS PaymentId,');
   ST.add('PP.PrePaymentID      AS PrePaymentID,');
   ST.add('PP.CompanyName       AS CustomerName,');
   ST.add('"Pre-Payment"        AS Transtype,');
   ST.add('PP.PrePaymentDate    AS transdate,');
   ST.add('NULL                 AS paymentmethod,');
   ST.add('PP.Notes             AS Notes,');
   ST.add('PP.ReferenceNo       AS Refno,');
   ST.add('0-PP.PayAmount         AS Amount,');
   ST.add('0-PP.ForeignPayAmount  AS foreignamount,');
   ST.add('if(ifnull(PP.ForeignExchangeCode,"")="", '+Quotedstr(Appenv.RegionalOptions.ForeignExDefault)+' , PP.ForeignExchangeCode) AS ForeignExchangeCode,');
   ST.add('if(ifnull(PP.ForeignExchangeRate,0)=0, 1, PP.ForeignExchangeRate)  AS ForeignExchangeRate ,');
   ST.add(Floattostr(fdOpeningBalance         ) +' AS   OpeningBalance,');
   ST.add(Floattostr(fdForeignOpeningBalance  ) +' AS   ForeignOpeningBalance,');
   ST.add(Floattostr(fdclosingBalance         ) +' AS   closingBalance,');
   ST.add(Floattostr(fdForeignclosingBalance  ) +' AS   ForeignclosingBalance,');
   ST.add(SplitField('CL', 'Company', 1)+' as ClientName, ');
   ST.add(SplitField('CL', 'Company', 2)+' as Jobname ,');
   ST.add('Null as Duedate,');
   ST.add('Null as Paidamt,');
   ClientFields('CL');
   ST.add('FROM tblprepayments AS PP');
   ST.add('inner join tblclients CL on CL.clientId = PP.clientID');
   ST.add('INNER JOIN tblpaymentmethods PM ON PM.PayMethodID = PP.PayMethodID');
   ST.add('WHERE PP.PrePaymentDate  Between ' + DateFromSQL + ' AND ' + DateToSQL);
   if aclientID <> 0 then ST.add('AND (PP.ClientID ='+inttostr(aclientID)+')');
   ST.add('ORDER BY Customername, transdate , saleID, paymentID');
  finally
    REsult := ST.CommaText;
     if SQL<> nil then else Freeandnil(st);
  end;
end;

{TStatementList}

constructor TStatementList.Create;
begin
   inherited Create;
end;
function TStatementList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  result := inherited;
  StatementSQL(SQL ,0,0,0,0,0);
  SQL.Text := 'SELECT ClientID, '+
                    ' Customername, '+
                    ' ClientName, '+
                    ' Jobname ,'+
                    ' ForeignExchangeCode, '+
                    ' BillStreet, '+
                    ' BillStreet2, '+
                    ' BillSuburb, '+
                    ' BillState, '+
                    ' BillCountry, '+
                    ' BillPostcode, '+
                    ' POSuburb, '+
                    ' POState, '+
                    ' POCountry, '+
                    ' POPostcode, '+
                    ' Street, '+
                    ' Street2, '+
                    ' Street3, '+
                    ' State, '+
                    ' Postcode, '+
                    ' Email, '+
                    ' Phone, '+
                    ' SUM(Amount) AS amount, '+
                    ' SUM(ForeignAmount) AS ForeignAmount '+
                    ' FROM ( '+SQL.Text +') as MainSQL '+
                    ' GROUP BY cLIENTiD, ForeignExchangeCode '+
                    ' ORDER BY CUSTOMERNAME';
end;

{ TStatementForCustomer }

constructor TStatementForCustomer.Create;
begin
  inherited;
  fiClientId :=0;
  fsCustomername :='';
end;

function TStatementForCustomer.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
var
  fdOpeningBalance :double;
  fdForeignOpeningBalance :double;
  fdclosingBalance :double;
  fdForeignclosingBalance :double;
  fdDate1, fdDate2:TDateTime;
begin
  SQL.Clear;
  result := inherited;
  fdDate1:= DateFrom;
  fdDate2 :=DateTo;
  try
      DateTo  := DateFrom;
      DateFrom:= MinDateTime;
      with OpeningBalanceQry(ClientID) do begin
        fdOpeningBalance        := fieldbyname('amount').AsFloat;
        fdForeignOpeningBalance := fieldbyname('foreignamount').AsFloat;
      end;
      DateFrom:= MinDateTime;
      DateTo  := fdDate2;
      with closingBalanceQry(ClientID) do begin
        fdclosingBalance        := fieldbyname('amount').AsFloat;
        fdForeignclosingBalance := fieldbyname('foreignamount').AsFloat;
      end;
  finally
    DateFrom:= fdDate1;
    DateTo  := fdDate2;
  end;
  StatementSQL(SQL ,
               ClientId,
               fdOpeningBalance ,
               fdForeignOpeningBalance ,
               fdclosingBalance ,
               fdForeignclosingBalance );
end;
initialization
  RegisterClass(TStatementList);
  RegisterClass(TStatementForCustomer);

end.

