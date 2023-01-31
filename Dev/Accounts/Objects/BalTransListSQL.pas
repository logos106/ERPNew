unit BalTransListSQL;

interface

uses
  ReportBaseObj,classes ;

Type
  TBalTransListType = (btlAll =1, btlCogsAdjOnly = 2, btlCogsAdjEx =3);

  TBalTransListReport = class(TReportWithDateRangeBase)
  private
    (*fDateFrom             : TDateTime;
    fDateTo               : TDateTime;*)
    fsAccName             : String;
    fsTransType           : String;
    fbIsRetainedEarnings  : Boolean;
    fbIsProfitAndLoss     : Boolean;
    fsTranslistfilter     : String;
    fsSelectedDepartments : String;
    fiFilterIndex         : Integer;
    (*fbIgnoreDates: Boolean;*)
    fbIncludeOrderby: Boolean;
    (*function DateFromSQL: string;
    function DateToSQL: string;*)
    Function RetainedEarningFromSQL:String;
    Function RetainedEarningToSQL:String;
    Function PnlFromSQL:String;
    Function pnlToSQL:String;
    function BalTransListType: TBalTransListType;
    (*function getDateFrom: TDateTime;
    function getDateTo: TDateTime;*)
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
    (*property DateFrom           : TDateTime read getDateFrom            write fDateFrom;
    property DateTo             : TDateTime read getDateTo              write fDateTo;*)
    Property AccName            : String    read fsAccName              write fsAccName;
    Property TransType          : String    read fsTransType            write fsTransType;
    Property IsRetainedEarnings : Boolean   read fbIsRetainedEarnings   write fbIsRetainedEarnings;
    Property IsProfitAndLoss    : Boolean   read fbIsProfitAndLoss      write fbIsProfitAndLoss;
    Property Translistfilter    : String    read fsTranslistfilter      write fsTranslistfilter;
    Property SelectedDepartments: String    read fsSelectedDepartments  write fsSelectedDepartments;
    Property FilterIndex        : Integer   read fiFilterIndex          write fiFilterIndex;
    (*Property IgnoreDates        : Boolean   read fbIgnoreDates          write fbIgnoreDates;*)
    Property IncludeOrderby     : Boolean   read fbIncludeOrderby       write fbIncludeOrderby;
  end;

implementation

uses Sysutils, DateUtils, DateTimeUtils, AppEnvironmentVirtual, CommonLib;

{ TBalTransListReport }

function TBalTransListReport.BalTransListType: TBalTransListType;
begin
       if FilterIndex = 0 then result := btlAll
  else if FilterIndex = 1 then result := btlCogsAdjOnly
  else result := btlCogsAdjEx;

end;

constructor TBalTransListReport.Create;
begin
  inherited;
  DateFrom             := incmonth(Date,-1);
  DateTo               := Date;
  (*fbIgnoreDates         := False;*)
  fsAccName             := '';
  fsTransType           := '';
  fbIsRetainedEarnings  := False;
  fbIsProfitAndLoss     := False;
  fsTranslistfilter     := '';
  fsSelectedDepartments := '';
  FilterIndex           := 0;
  fbIncludeOrderby      := False;
end;

destructor TBalTransListReport.Destroy;
begin
  inherited;
end;

(*function TBalTransListReport.getDateFrom: TDateTime;
var
  dt: TDateTime;
begin
  if fbIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  Result := dt;
end;

function TBalTransListReport.getDateTo: TDateTime;
var
  dt: TDateTime;
begin
  if fbIgnoreDates then dt :=  MaxDateTime
  else dt := fDateTo;
  Result := dt;
end;*)

function TBalTransListReport.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
var
  st:TStringlist;
const
  AmountEx = 'If((AccountType = "AR" OR AccountType = "OASSET" OR AccountType = "BANK" OR AccountType = "OCASSET"),DebitsEx - CreditsEx,CreditsEx - DebitsEx)';
  amountinc = 'If((AccountType = "AR" OR AccountType = "OASSET" OR AccountType = "BANK" OR AccountType = "OCASSET"),DebitsInc - CreditsInc,CreditsInc - DebitsInc)';
begin
    SQL.add('SELECT');
    SQL.add('if(round(seqno)  in (11,12,25,26,27,55,71,84,87,88) , "T" , "F") as InvAssetEntry,');
    SQL.add('ProductName as ProductName,');
    SQL.add('Seqno as seqno,');
    SQL.add('TransID as TransID,');
    SQL.add('Date as Date,');
    SQL.add('Type as Type,');
    SQL.add('GlobalRef as "Global #",');
    SQL.add('ClientName as ClientName,');
    SQL.add('SaleID as SaleID,');
    SQL.add('PurchaseOrderID as PurchaseOrderID,');
    SQL.add('PaymentID as PaymentID,');
    SQL.add('PrepaymentID as PrepaymentID,');
    SQL.add('FixedAssetID as FixedAssetID,');
    SQL.add('AccountID as AccountID,');
    SQL.add('AccountName as "Account Name",');
    SQL.add('ProductDesc as ProductDesc,');
    SQL.add('AccountType as "Account Type",');
    if FilterIndex <>0 then SQL.add('GROUP_CONCAT( Distinct concat(if(round(seqno)<>seqno,"(COGS Adjustment) " , ""), ifnull(Notes,""))) as Notes,')
    else SQL.add('GROUP_CONCAT( Distinct Notes) as Notes,');
    SQL.add('sum(' + AmountEx +') as "Amount (Ex)",');
    SQL.add('sum(' + amountinc +') as "Amount (Inc)",');
    SQL.add('EmployeeID as EmployeeID');
    SQL.add('FROM tblTransactions TRANS');
    SQL.add('WHERE Trans.Seqno < 100 and TRANS.Date Between ' + DateFromSQL +'  AND ' + DateToSQL);
         if BalTransListType = btlAll         then SQL.add('and (round(seqno)= seqno or  ' + AmountEx +' <>0 or ' + amountinc +'<>0)')
    else if BalTransListType = btlCogsAdjOnly then SQL.add('and (round(seqno)<> seqno and  (' + AmountEx +' <>0 or ' + amountinc +'<>0))')
    else if BalTransListType = btlCogsAdjEx   then SQL.add('and (round(seqno)= seqno )');
    if Translistfilter <> '' then SQL.add('and ' + Translistfilter);

    if IsRetainedEarnings then SQL.add('AND Date Between  ' + RetainedEarningFromSQL +'  AND ' + RetainedEarningToSQL);
    if IsProfitAndLoss    then SQL.add('AND Date Between ' +pnlfromSQL +'             AND ' + pnlToSQL );


    if FilterIndex = 0 then
      SQL.add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname')
    else if FilterIndex = 1 then
      SQL.add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname,Seqno')
    else if FilterIndex = 2 then
      SQL.add('Group by TransID');
    SQL.add('union all');
    SQL.add('SELECT');
    SQL.add('if(round(seqno)  in (11,12,25,26,27,55,71,84,87,88) , "T" , "F") as InvAssetEntry,');
    SQL.add('ProductName as ProductName,');
    SQL.add('100+Seqno as seqno,');
    SQL.add('TransID as TransID,');
    SQL.add('Date as Date,');
    SQL.add('Type as Type,');
    SQL.add('GlobalRef as "Global #",');
    SQL.add('ClientName as ClientName,');
    SQL.add('SaleID as SaleID,');
    SQL.add('PurchaseOrderID as PurchaseOrderID,');
    SQL.add('PaymentID as PaymentID,');
    SQL.add('PrepaymentID as PrepaymentID,');
    SQL.add('FixedAssetID as FixedAssetID,');
    SQL.add('AccountID as AccountID,');
    SQL.add('AccountName as "Account Name",');
    SQL.add('ProductDesc as ProductDesc,');
    SQL.add('AccountType as "Account Type",');
    if FilterIndex <>0 then SQL.add('GROUP_CONCAT( Distinct concat(if(round(seqno)<>seqno,"(COGS Adjustment) " , ""), ifnull(Notes,""))) as Notes,')
    else SQL.add('GROUP_CONCAT( Distinct Notes) as Notes,');
    SQL.add('sum(' + AmountEx +') as "Amount (Ex)",');
    SQL.add('sum(' + amountinc +') as "Amount (Inc)",');
    SQL.add('EmployeeID as EmployeeID');
    SQL.add('FROM tbltransactionsummarydetails TRANS');
    SQL.add('WHERE type <> "Closing Date Summary" and TRANS.Date Between :txtfrom AND :txtto');
         if BalTransListType = btlAll         then SQL.add('and (round(seqno)= seqno or  ' + AmountEx +' <>0 or ' + amountinc +'<>0)')
    else if BalTransListType = btlCogsAdjOnly then SQL.add('and (round(seqno)<> seqno and  (' + AmountEx +' <>0 or ' + amountinc +'<>0))')
    else if BalTransListType = btlCogsAdjEx   then SQL.add('and (round(seqno)= seqno )');
    if Translistfilter <> '' then SQL.add('and ' + Translistfilter);

    if IsRetainedEarnings then SQL.add('AND Date Between ' + RetainedEarningFromSQL +' AND ' + RetainedEarningToSQL);
    if IsProfitAndLoss    then SQL.add('AND Date Between ' +pnlfromSQL +'             AND ' + pnlToSQL +'');


    if FilterIndex = 0 then
      SQL.add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname')
    else if FilterIndex = 1 then
      SQL.add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname,Seqno')
    else if FilterIndex = 2 then
      SQL.add('Group by TransID');
    if IncludeOrderby then SQL.add('Order by date desc, type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,0 )))) , Productname, seqno desc; ' );
end;
function TBalTransListReport.RetainedEarningFromSQL: String;
begin
  if not APIMode then begin
    result := ':RetainedEarningFrom';
    exit;
  end else begin
    Result := DateFromSQL;
  end;
end;
function TBalTransListReport.RetainedEarningToSQL: String;
begin
  if not APIMode then begin
    result := ':RetainedEarningTo';
    exit;
  end else begin
    REsult := Quotedstr(formatdatetime('yyyy-mm-dd', IncSecond(IncDay(dateof(DateTimeUtils.FiscalYearStart(Dateto, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts'])), 1), -1)));
  end;
end;
function TBalTransListReport.PnlFromSQL: String;
begin
  if not APIMode then begin
    result := ':PnlFrom';
    exit;
  end else begin
    Result := Quotedstr(formatdatetime('yyyy-mm-dd', iif(dateof(DateFrom) <=AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'] , dateFrom ,  DateTimeUtils.FiscalYearStart(Dateto, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']))));
  end;
end;

function TBalTransListReport.pnlToSQL: String;
begin
  if not APIMode then begin
    result := ':PnLTo';
    exit;
  end else begin
    Result := DatetoSQL;
  end;
end;

(*function TBalTransListReport.DateFromSQL: string;
var
  dt: TDateTime;
begin
  if not APIMode then begin
    result := ':Datefrom';
    exit;
  end
  else if fbIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;

function TBalTransListReport.DateToSQL: string;
var
  dt: TDateTime;
begin
  if not APIMode then begin
    result := ':Dateto';
    Exit;
  end else if fbIgnoreDates then dt := MaxDateTime
  else dt := fDateTo;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;*)
end.

