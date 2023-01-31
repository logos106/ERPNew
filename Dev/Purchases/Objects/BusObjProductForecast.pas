unit BusObjProductForecast;

interface

uses
  BusObjBase, DB, Classes,  MyAccess,ERPdbComponents, BusObjStock, ParserObj,
  BusObjSmartOrder, XMLDoc, XMLIntf, BusObjProductClass, Contnrs;

type

  TApplyMode = (amDailyAvg, amMonthlyAvg, amMonthlyActual);

  TProductAdjustRecord = class
  private
    FRoundPoints: boolean;
    FReorderPointPercent: boolean;
    FReorderLevelPercent: boolean;
    FReorderPointValue: double;
    FReorderLevelValue: double;
    FReorderAmountPercent: boolean;
    FReorderAmountValue: double;
    FRoundPercent: integer;
  public
    property ReorderPointValue : double read FReorderPointValue write FReorderPointValue;
    property ReorderPointPercent : boolean read FReorderPointPercent write FReorderPointPercent;
    property PreferredLevelValue : double read FReorderLevelValue write FReorderLevelValue;
    property PreferredLevelPercent : boolean read FReorderLevelPercent write FReorderLevelPercent;
    property ReorderAmountValue : double read FReorderAmountValue write FReorderAmountValue;
    property ReorderAmountPercent : boolean read FReorderAmountPercent write FReorderAmountPercent;
    property RoundPoints : boolean read FRoundPoints write FRoundPoints;
    property RoundValue : integer read FRoundPercent write FRoundPercent;
  end;

  TProductForecastFormula = class(TMSBusObj)
  private
    function GetUseReorderAmount    : Boolean   ;
//    function GetUseDateCreated      : Boolean   ;
    function GetTradingDaysPerWeek  : Integer   ;
    function GetQuotes              : Boolean   ;
    function GetSalesOrders         : Boolean   ;
    function GetInvoices            : Boolean   ;
    function GetDateFrom            : TDateTime ;
    function GetDateTo              : TDateTime ;
    function GetFormula             : string    ;
    procedure SetUseReorderAmount   (const Value: Boolean   );
//    procedure SetUseDateCreated     (const Value: Boolean   );
    procedure SetTradingDaysPerWeek (const Value: Integer   );
    procedure SetQuotes             (const Value: Boolean   );
    procedure SetSalesOrders        (const Value: Boolean   );
    procedure SetInvoices           (const Value: Boolean   );
    procedure SetDateFrom           (const Value: TDateTime );
    procedure SetDateTo             (const Value: TDateTime );
    procedure SetFormula            (const Value: string    );
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: Extended; var FieldFound: Boolean);
    function GetUseAvailQty: boolean;
    function GetUseNonERPsales: boolean;
    function GetUseFormula: boolean;
    function GetUseHistoryData: boolean;
    procedure SetUseAvailQty(const Value: boolean);
    procedure SetUseNonERPsales(const Value: boolean);
    procedure SetUseFormula(const Value: boolean);
    procedure SetUseHistoryData(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean;                                  override;
    function     ValidateFormula: Boolean;
    function     Save: Boolean;                                          override;
  published
    property UseReorderAmount   :Boolean     read GetUseReorderAmount     write SetUseReorderAmount   ;
  //  property UseDateCreated     :Boolean     read GetUseDateCreated       write SetUseDateCreated     ;
    property TradingDaysPerWeek :Integer     read GetTradingDaysPerWeek   write SetTradingDaysPerWeek ;
    property Quotes             :Boolean     read GetQuotes               write SetQuotes             ;
    property SalesOrders        :Boolean     read GetSalesOrders          write SetSalesOrders        ;
    property Invoices           :Boolean     read GetInvoices             write SetInvoices           ;
    property DateFrom           :TDateTime   read GetDateFrom             write SetDateFrom           ;
    property DateTo             :TDateTime   read GetDateTo               write SetDateTo             ;
    property Formula            :string      read GetFormula              write SetFormula            ;
    property UseFormula : boolean read GetUseFormula write SetUseFormula;
    property UseAvailQty : boolean read GetUseAvailQty write SetUseAvailQty;
    property UseNonERPsales : boolean read GetUseNonERPsales write SetUseNonERPsales;
    property UseHistoryData : boolean read GetUseHistoryData write SetUseHistoryData;
  end;

  TOnProgressBarInit = procedure (Sender: TObject; MaxValue: Integer) of object;
  TOnProgressBarSmartOrder = procedure(Sender : TObject; const aMessage : string) of object;

  TProductForecast = class(TComponent)
  private
    fSettings: TProductForecastFormula;
    fConnection: TERPConnection;
    fProduct: TProduct;
    fProductClass: TProductClass;
    fSupplier: Integer;
    fDepartment: Integer;
    fUsagePerDay: Double;
    (*fIncludeTransactions: Boolean;*)
    (*fTransactionSQLWhere: string;*)
    (*fQuoteSQLWhere: string;*)
    fQuery: TERPQuery;
    fParser: TMathParser;
    fLastDateFrom: TDateTime;
    fDateTo: TDateTime;
    fOnProgressBarInit: TOnProgressBarInit;
    fOnProgressBarStepIt: TNotifyEvent;
    fSmartOrder: TSmartOrder;
    fAdjustRecord: TProductAdjustRecord;
    fOnProgressBarSmartOrder: TOnProgressBarSmartOrder;
    FSOAmount: double;
    fSOProduct: integer;
    fSOClass: integer;
    fSOOnHand: double;
    fSOReorderPoint: double;
    function GetSettings: TProductForecastFormula;
    procedure SetSettings(const Value: TProductForecastFormula);
    function GetConnection: TERPConnection;
    procedure SetConnection(const Value: TERPConnection);

    procedure Initialise;
    procedure Finalise;
    //function GetWhereDate(const DateColumnName: string): string;
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: Extended; var FieldFound: Boolean);
    procedure DoGetSmartOrderParserVariable(Sender: TObject; const VarName: string; var Value: Extended; var FieldFound: Boolean);
    //function CalcUsagePerDay : double;
    function CalcReorderQty(const AMonth : integer = 0): Double;
//    function CalcReorderPointQty(AMonth : integer = 0) : double;
//    procedure CopyReorderPointsToProductClass(AMonth : integer; {AProducts,} aDepartments : TStringList);
    function CalcSales(AProductId, AClassId : integer) : double;
    function SalesQty(const AProductID, AClassID: Integer; ADateFrom,ADAteTo: TDateTime): Double;
    function GetWhereDateFrom: Tdatetime;
    function GetWhereDateto: TDateTime;

    // Following is used by SmartOrder and the Parser when it is called from SmartOrder
    property SOAmount : double read FSOAmount write FSOAmount;
    property SOProduct : integer read fSOProduct write fSOProduct;
    property SOClass : integer read fSOClass write fSOClass;
    property SOOnHand : double read fSOOnHand write fSOOnHand;
    property SOReorderPoint : double read fSOReorderPoint write fSOReorderPoint;
  public
    TempTableName: string;
    constructor Create(AOwner: TComponent); override;

    function CreateSmartOrder: Integer; // returns new smart order id
    function CreateSmartOrderOnSmartApply(aMonths: TSTringList; aDeptList : TStringList; AMode : TApplyMode) : integer;
    function CalcReorderPoint(const APartId, ADepartmentId : integer;
         AReorderPoint: double; aMonth : integer;
         aMode : TApplyMode;
         var aPoint : double) : boolean;
    function ReorderAmount(const aPartID: Integer; aDepartment: Integer = 1): Double;

    function CalcUsagePerDay : double;
    function CalcSalesInAMonth(AProductId, AClassId : integer; AMonthYear : TDate) : double;

    property Department: Integer read fDepartment write fDepartment; // 0 = all departments (default)
    property Supplier: Integer read fSupplier write fSupplier;       // 0 = all suppliers   (default)
    property Settings: TProductForecastFormula read GetSettings write SetSettings;
    property Connection: TERPConnection read GetConnection write SetConnection;
    property OnProgressBarInit: TOnProgressBarInit read fOnProgressBarInit write fOnProgressBarInit;
    property OnProgressBarStepIt: TNotifyEvent read fOnProgressBarStepIt write fOnProgressBarStepIt;
    property OnProgressBarSmartOrder : TOnProgressBarSmartOrder read fOnProgressBarSmartOrder write fOnProgressBarSmartOrder;
    property AdjustRecord : TProductAdjustRecord read fAdjustRecord write fAdjustRecord;
  end;

implementation

uses
  tcDataUtils, CommonLib, SysUtils, StrUtils, CommonDbLib, FastFuncs, DateUtils,
  AppEnvironment, DNMLib, Dialogs, MySQLConst, DateTimeUtils, LogLib, saleslib;

  function ListToCommas(AList : TStringList) : string;
  var
    idx : integer;
  begin
    Result := '';
    if Not assigned(AList) or (AList.Count = 0) then
      exit;
    for idx := 0 to AList.Count - 1 do
      if idx = 0  then
        Result := '(' + ALIst[idx]
      else
        Result := Result + ',' + aList[idx];
    Result := Result + ')';
  end;

{ TProductForecastFormula }

constructor TProductForecastFormula.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Product Forecast Formula';
  fSQL := 'SELECT * FROM tblproductforecastformula';
end;


destructor TProductForecastFormula.Destroy;
begin
  inherited;
end;


procedure TProductForecastFormula.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'UseReorderAmount');
  SetPropertyFromNode(node,'UseDateCreated');
  SetPropertyFromNode(node,'TradingDaysPerWeek');
  SetPropertyFromNode(node,'Quotes');
  SetPropertyFromNode(node,'SalesOrders');
  SetPropertyFromNode(node,'Invoices');
  SetPropertyFromNode(node,'DateFrom');
  SetPropertyFromNode(node,'DateTo');
  SetPropertyFromNode(node,'Formula');
end;


procedure TProductForecastFormula.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'UseReorderAmount' ,UseReorderAmount);
//  AddXMLNode(node,'UseDateCreated' ,UseDateCreated);
  AddXMLNode(node,'TradingDaysPerWeek' ,TradingDaysPerWeek);
  AddXMLNode(node,'Quotes' ,Quotes);
  AddXMLNode(node,'SalesOrders' ,SalesOrders);
  AddXMLNode(node,'Invoices' ,Invoices);
  AddXMLNode(node,'DateFrom' ,DateFrom);
  AddXMLNode(node,'DateTo' ,DateTo);
  AddXMLNode(node,'Formula' ,Formula);
end;


function TProductForecastFormula.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ValidateFormula then
    Result := True;
end;


function TProductForecastFormula.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductForecastFormula.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProductForecastFormula.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProductForecastFormula.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductForecastFormula.GetIDField: string;
begin
  Result := 'FormulaID'
end;

class function TProductForecastFormula.GetBusObjectTablename: string;
begin
  Result := 'tblproductforecastformula';
end;

function TProductForecastFormula.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

end;

function TProductForecastFormula.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function TProductForecastFormula.GetUseAvailQty: boolean;
begin
  Result := GetBooleanField('UseAvailQty');
end;
function TProductForecastFormula.GetUseNonERPsales: boolean;
begin
  Result := GetBooleanField('UseNonERPsales');
end;

function TProductForecastFormula.GetUseFormula: boolean;
begin
  Result := GetBooleanField('UseFormula');
end;

function TProductForecastFormula.GetUseHistoryData: boolean;
begin
  Result := GetBooleanField('UseHistoryData');
end;

function  TProductForecastFormula.GetUseReorderAmount   : Boolean   ; begin Result := GetBooleanField('UseReorderAmount');end;
//function  TProductForecastFormula.GetUseDateCreated     : Boolean   ; begin Result := GetBooleanField('UseDateCreated');end;
function  TProductForecastFormula.GetTradingDaysPerWeek : Integer   ; begin Result := GetIntegerField('TradingDaysPerWeek');end;
function  TProductForecastFormula.GetQuotes             : Boolean   ; begin Result := GetBooleanField('Quotes');end;
function  TProductForecastFormula.GetSalesOrders        : Boolean   ; begin Result := GetBooleanField('SalesOrders');end;
function  TProductForecastFormula.GetInvoices           : Boolean   ; begin Result := GetBooleanField('Invoices');end;
function  TProductForecastFormula.GetDateFrom           : TDateTime ;
begin
  Result := GetDateTimeField('DateFrom');
  // Always the 1st of the month
  Result := EncodeDate(YearOf(Result), MonthOf(Result), 1);
end;

function  TProductForecastFormula.GetDateTo             : TDateTime ;
var
  y, m : word;
begin
  Result := GetDateTimeField('DateTo');
  // Always the last day in the month
  y := YearOf(Result);
  m := MonthOf(Result);
//SetDateTimeField('DateTo'            , Value);
  Result := EncodeDate(y, m, DaysInAMonth(y, m));
//  Result := GetDateTimeField('DateTo');
end;

function  TProductForecastFormula.GetFormula            : string    ; begin Result := GetStringField('Formula');end;
procedure TProductForecastFormula.SetUseAvailQty(const Value: boolean);
begin
  SetBooleanField('UseAvailQty', Value);
end;
procedure TProductForecastFormula.SetUseNonERPsales(const Value: boolean);
begin
  SetBooleanField('UseNonERPsales', Value);
end;

procedure TProductForecastFormula.SetUseFormula(const Value: boolean);
begin
  SetBooleanField('UseFormula', Value);
end;

procedure TProductForecastFormula.SetUseHistoryData(const Value: boolean);
begin
  SetBooleanField('UseHistoryData', Value);
end;

procedure TProductForecastFormula.SetUseReorderAmount   (const Value: Boolean   ); begin SetBooleanField('UseReorderAmount'   , Value);end;
//procedure TProductForecastFormula.SetUseDateCreated     (const Value: Boolean   ); begin SetBooleanField('GetUseDateCreated'  , Value);end;
procedure TProductForecastFormula.SetTradingDaysPerWeek (const Value: Integer   ); begin SetIntegerField('TradingDaysPerWeek' , Value);end;
procedure TProductForecastFormula.SetQuotes             (const Value: Boolean   ); begin SetBooleanField('Quotes'             , Value);end;
procedure TProductForecastFormula.SetSalesOrders        (const Value: Boolean   ); begin SetBooleanField('SalesOrders'        , Value);end;
procedure TProductForecastFormula.SetInvoices           (const Value: Boolean   ); begin SetBooleanField('Invoices'           , Value);end;
procedure TProductForecastFormula.SetDateFrom           (const Value: TDateTime );
begin
//  SetDateTimeField('DateFrom'          , Value);
// Always 1st of the month
  SetDateTimeField('DateFrom', EncodeDate(YearOf(Value), MonthOf(Value), 1));
end;
procedure TProductForecastFormula.SetDateTo             (const Value: TDateTime );
var
  y, m : word;
begin
  // Always the last day in the month
  y := YearOf(Value);
  m := MonthOf(Value);
//SetDateTimeField('DateTo'            , Value);
  SetDateTimeField('DateTo', EncodeDate(y, m, DaysInAMonth(y, m)));
end;
procedure TProductForecastFormula.SetFormula            (const Value: string    ); begin SetStringField('Formula'             , Value);end;


function TProductForecastFormula.ValidateFormula: Boolean;
var
  Parser: TMathParser;
begin
  Result := False;
  PostDB;
  if Formula = '' then begin
//    ResultStatus.AddItem(False , rssError , 0 , 'Formula should not be blank');
    Result := true;
    Exit;
  end;

  Parser := TMathParser.Create(Self);
  Try
    Parser.OnGetVar := DoGetParserVariable;
    Parser.ParseString := Formula;
    Parser.Parse;
    if Parser.ParseError then begin
      ResultStatus.AddItem(False , rssError , 0 , Parser.ErrorMessage);
      Exit;
    end;
  finally
    FreeAndNil(Parser);
  end;
  Result := True;
end;

procedure TProductForecastFormula.DoGetParserVariable(Sender: TObject;
  const VarName: string; var Value: Extended; var FieldFound: Boolean);
begin
  FieldFound := (VarName = 'A') or (VarName = 'B') or (VarName = 'C') or (VarName = 'D') or (VarName = 'E');
end;

{ TProductForecast }

function TProductForecast.CalcReorderQty(const AMonth : integer = 0): Double;
var
  lReorderAmount: Double;
//  newMod : double;
begin
  CalcUsagePerDay;
  if (Settings.UseFormula) and (Settings.Formula <> '') then
  begin
    fParser.Parse;
    if fParser.ParseError then
      raise Exception.Create(fParser.ErrorMessage);
    Result := fParser.ParseValue;
  end
  else if AMonth = 0 then
    // Projected sales minus available
    Result := (fUsagePerDay * DaysInAMonth(YearOf(Today()), MonthOf(Today()))) - fProductClass.AvailableQuantity
  else
    Result := (fUsagePerDay * DaysInAMonth(YearOf(Today()), AMonth)) - fProductClass.AvailableQuantity;

  lReorderAmount := fProductClass.ReOrderAmount;
  if Result < 0 then
    Result := 0
  else if (Result > 0) and Settings.UseReorderAmount and (lReorderAmount <> 0) then
  begin
      if (Result < lReOrderAmount) then
        Result := lReOrderAmount
      else if Int(Result / lReorderAmount) = (Result / lReorderAmount) then
        //Result is already a multiple of lReorderAmount
      else
        Result := (Int(Result / lReorderAmount) + 1) * lReorderAmount;
  end;

end;
Function TProductForeCast.SalesQty(Const AProductID:Integer; Const AClassID:Integer ; ADateFrom :TDateTime; ADAteTo:TDateTime):Double;
var

  sSQL:String;
begin
  result := 0;
  sSQL := '';
  (*for ctr := 1 to 2 do begin
    if (ctr =1) or (Settings.UseNonERPsales) then begin
      if ctr =2 then sSQL := sSQL + 'union all ';
      sSQL := sSQL + 'SELECT ';
      //sSQL := sSQL + ' SUM(' + iif(ctr=1 , 'sl.qtysold' , 'SL.Shipped')+') AS TotalQty ';
      sSQL := sSQL + ' SUM(SL.Shipped) AS TotalQty '; //Dene

      if ctr =1 then sSQL := sSQL +' FROM tblsaleslines       sl JOIN tblsales       s ON sl.SaleID = s.SaleID '
                else sSQL := sSQL +' FROM tblnonerpsaleslines sl JOIN tblnonerpsales s ON sl.SaleID = s.SaleID ';

      sSQL := sSQL +' WHERE (ProductID = ' + IntToStr(AProductId) + ') ';
      if ctr =1 then sSQL := sSQL +'  and S.Deleted <> "T"'  ;
      if AClassId <> 0 then sSQL := sSQL +' AND s.ClassId=' + IntToStr(AClassId);
      s:= '';
      if Settings.Invoices     then addFilter('(S.IsInvoice = "T" or  S.IsCashSale ="T" or S.IsRefund ="T" or S.IsPOS ="T")');
      if Settings.SalesOrders  then addFilter('S.IsSalesOrder="T"');
      if Settings.Quotes then addFilter('S.IsQuote="T"');
      if s <> '' then s:='(' + s + ')';
      if (Settings.Invoices or Settings.SalesOrders) and (not(Settings.quotes) ) then s:='(' + s + iif(ctr =1, ' and S.converted="F"', '') +')';
      if s<> '' then sSQL := sSQL +'  AND ' + s;
      sSQL := sSQL +' AND (SaleDate >= "' + FormatDateTime(MySQLDateFormat, aDateFrom) + '")';
      if ADAteTo <> 0 then  sSQL := sSQL +' and (SaleDate <= "' + FormatDateTime(MySQLDateFormat, aDateTo) + '")';
    end;
  end;*)

      {Sales}
      sSql := SalessummarySQL(AProductId, inttostr(AClassId) ,Settings.Invoices,Settings.SalesOrders , Settings.Quotes , Settings.UseNonERPsales, Startoftheday(aDatefrom) , endoftheday(aDateTo) ,'');

  //if fQuery = nil then fQuery := TERPQuery.Create(self);
  With fQuery do try
    if active then close;
    if connection = nil then Connection := GetSharedMyDacConnection;
    clog(sSQL);
    SQL.text :=sSQL;
    open;
    if not Eof then begin
      result := 0;
      First;
      While Eof = False do begin
        Result := result + FieldByName('TotalQty').AsFloat;
        next;
      end;
    end;
  finally
    close;
  end;
end;
function TProductForecast.CalcSales(AProductId, AClassId : integer): double;
begin
  result := SalesQty(AProductId, AclassId , Settings.DateFrom, Settings.Dateto);
(*var
  s:String;

  Procedure Addfilter(Const fs:String);
  begin
      if s <> '' then s := s + ' OR ';
      s:= s+fs;
  end;

begin
  Result := 0;

  try
    fQuery.SQL.Clear;
    fQuery.SQL.Add('SELECT SUM(sl.qtysold) AS TotalQty ');
    fQuery.SQL.Add('FROM tblsaleslines sl JOIN tblsales s ON sl.SaleID = s.SaleID ');
    fQuery.SQL.Add('WHERE (ProductID = ' + IntToStr(AProductId) + ') ');
    fQuery.SQL.add(' and S.Deleted <> "T"'  );
    fQuery.SQL.Add('AND s.ClassId=' + IntToStr(AClassId));
    s:= '';
    if Settings.Invoices     then
      addFilter('S.IsInvoice = "T"');
    if Settings.SalesOrders  then
      addFilter('S.IsSalesOrder="T"');
    if Settings.Quotes then
      addFilter('S.IsQuote="T"');
    if s <> '' then
      s:='(' + s + ')';
    if (Settings.Invoices or Settings.SalesOrders) and (not(Settings.quotes) ) then
      s:='(' + s + ' and S.converted="F")';
    if s<> '' then
      fQuery.SQL.add(' AND ' + s);
//    fQuery.sql.add(AppendToWhereClause(GetWhereDate('SaleDate')));
    fQuery.SQL.Add('AND (SaleDate >= "' + FormatDateTime(MySQLDateFormat, Settings.DateFrom) + '") and (SaleDate <= "' +
                   FormatDateTime(MySQLDateFormat, Settings.DateTo) + '")');
    fQuery.Open;
    if not fQuery.Eof then
      Result := fQuery.FieldByName('TotalQty').AsFloat;
  finally
    fQuery.Close;
  end;*)
end;

function TProductForecast.CalcSalesInAMonth(AProductId, AClassId: integer;  AMonthYear: TDate): double;
var
  m, y : word;
begin
  y := YearOf(AMonthYear);
  m := MonthOf(AMonthYear);
  Initialise;
  try
    Result := SalesQty(AProductId, AclassId ,  EncodeDate(y, m, 1), EncodeDate(y, m, DaysInAMonth(y, m)));
  finally
    Finalise;
  end;
(*var
  s:String;
  m, y : word;

  fQuery : TERPQuery;

  Procedure Addfilter(Const fs:String);
  begin
      if s <> '' then s := s + ' OR ';
      s:= s+fs;
  end;

begin
  Result := 0;

  fQuery := TERPQuery.Create(nil);
  try
    fQuery.Connection := GetSharedMyDacConnection;
    fQuery.SQL.Clear;
    fQuery.SQL.Add('SELECT SUM(sl.qtysold) AS TotalQty ');
    fQuery.SQL.Add('FROM tblsaleslines sl JOIN tblsales s ON sl.SaleID = s.SaleID ');
    fQuery.SQL.Add('WHERE (ProductID = ' + IntToStr(AProductId) + ') ');
    fQuery.SQL.add(' and S.Deleted <> "T"'  );
    fQuery.SQL.Add('AND s.ClassId=' + IntToStr(AClassId));
    s:= '';
    if Settings.Invoices     then
      addFilter('S.IsInvoice = "T"');
    if Settings.SalesOrders  then
      addFilter('S.IsSalesOrder="T"');
    if Settings.Quotes then
      addFilter('S.IsQuote="T"');
    s:='(' + s + ')';
    if (Settings.Invoices or Settings.SalesOrders) and (not(Settings.quotes) ) then
      s:='(' + s + ' and S.converted="F")';
    if s<> '' then
      fQuery.SQL.add(' AND ' + s);
//    fQuery.sql.add(AppendToWhereClause(GetWhereDate('SaleDate')));
    y := YearOf(AMonthYear);
    m := MonthOf(AMonthYear);
    fQuery.SQL.Add('AND (SaleDate >= "' + FormatDateTime(MySQLDAteFormat, EncodeDate(y, m, 1)) + '") AND (SaleDate <= "' +
                   FormatDateTime(MySQLDateFormat, EncodeDate(y, m, DaysInAMonth(y, m))) + '")');

    fQuery.Open;
    if not fQuery.Eof then
      Result := fQuery.FieldByName('TotalQty').AsFloat;
  finally
//    fQuery.Close;
    fQuery.ClosenFree;
  end;*)

end;

function TProductForecast.CalcUsagePerDay : double;
var
  lDays: Double;
begin
  REsult := Salesqty(fProduct.ProductId, 0 ,  GetWhereDateFrom, GetWhereDateTo);
  if REsult <> 0 then begin
    lDays := DaysBetween(fDateTo, fLastDateFrom);
    if lDays <> 0 then fUsagePerDay := REsult / lDays;
  end;

(*var
  lQty, lDays: Double;
  var s:String;
  Procedure Addfilter(Const fs:String);
  begin
      if s <> '' then s := s + ' OR ';
      s:= s+fs;
  end;
begin
  fUsagePerDay := 0;
  lQty := 0;


    fQuery.SQL.Clear;
    fQuery.SQL.Add('SELECT SUM(sl.qtysold) AS TotalQty ');
    fQuery.SQL.Add('FROM tblsaleslines sl JOIN tblsales s ON sl.SaleID = s.SaleID ');
    fQuery.SQL.Add('WHERE (ProductID = ' + IntToStr(fProduct.ProductId) + ') ');
    fQuery.SQL.add(' and S.Deleted <> "T"'  );
    s:= '';
    if Settings.Invoices     then addFilter('S.IsInvoice = "T"');
    if Settings.SalesOrders  then addFilter('S.IsSalesOrder="T"');
    if Settings.Quotes       then addFilter('S.IsQuote="T"');
    s:='(' + s + ')';
    if (Settings.Invoices or Settings.SalesOrders) and (not(Settings.quotes) ) then  s:='(' + s + ' and S.converted="F")';
    if s<> '' then fQuery.SQL.add(' AND ' + s);
    fQuery.sql.add(AppendToWhereClause(GetWhereDate('SaleDate')));
    fQuery.Open;
    if not fQuery.Eof then
      lQty := lQty + fQuery.FieldByName('TotalQty').AsFloat;
    fQuery.Close;

  if lQty <> 0 then
  begin
    lDays := DaysBetween(fDateTo, fLastDateFrom); // fLastDateFrom is set in GetWhereDate()
    if lDays <> 0 then
      fUsagePerDay := lQty / lDays;
  end;
 Result := fUsagePerDay;*)
end;
(*
procedure TProductForecast.CopyReorderPointsToProductClass(AMonth : integer; //aProducts,
  aDepartments: TStringList);
var
  s1 : string;
  qry : TERPQuery;


begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
      s1 := ListToCommas(ADepartments);

      qry.SQL.Clear;
      qry.SQL.Add('update tblProductClasses C');
      qry.SQL.Add('inner join tblReorderPoints R on R.ClassId=C.ClassId and R.ProductId=c.ProductId');
      if TempTableName = '' then
        qry.SQL.Add('inner join tblParts T on T.PartsId=C.ProductId');
      qry.SQL.Add('set C.ReorderPoint = R.ReorderPoint, C.ReorderAmount=R.ReorderAmount, C.PreferredLevel=R.PreferredLevel');
      qry.SQL.Add('where R.OrderMonth="' + csMonths[AMonth - 1] + '"');
    if TempTableName <> '' then begin
      qry.SQL.Add('AND C.ProductId in (select PartsID as ProductId from '+TempTableName+')');
    end
    else begin
      qry.SQL.Add('AND T.AutoReorder = "T" AND T.Active="T" AND T.PartType = "INV" and ifnull(T.Discontinued, "F") = "F"');
      if Supplier > 0 then
        qry.SQL.Add(' AND T.PreferedSupp = "' + tcDataUtils.getSupplierName(Supplier) + '"');
    end;

      if s1 <> '' then
        qry.SQL.Add('and C.ClassId in ' + s1);
      qry.ExecSQL;
    finally
      qry.ClosenFree;
    end;
end;
*)
function TProductForecast.CalcReorderPoint(const APartId, ADepartmentId: integer;
  AReorderPoint: double; AMonth : integer;
  aMode : TApplyMode;
  var aPoint: double): boolean;
var
  lSales : double;
  fiDays : integer;
  fiMonths : integer;

  function CalcMonths(aDt : TDate) : integer;
  begin
    Result := 0;
    while aDt < {=} Settings.DateTo do     // ? Inclusive or exclusive?
    begin
      if aMode = amDailyAvg then
        Result := Result + DaysInAMonth(YearOf(aDt), MonthOf(aDt))
      else
        Result := Result + 1;
      aDt := IncMonth(aDt, 1);
    end;
  end;

begin
  Result := False;
  Initialise;
  fParser.OnGetVar := DoGetSmartOrderParserVariable;
  try
    if Connection <> GetSharedMyDacConnection then
      Connection.StartTransaction;
    SOProduct := APartId;
    SOClass := ADepartmentId;
    SOAmount := 0;
    fiMonths := MonthsRND(Settings.DateFrom , Settings.DateTo); if fiMonths <=0 then fiMonths := 1;
    fiDays := DaysRND(Settings.DateFrom , Settings.DateTo); if fiDays <=0 then fiDays := 1;
    lSales := CalcSales(SOProduct, SOClass);

      // Calc Required qty for this month
    if (Settings.UseFormula) and (Settings.Formula <> '') then begin
      SOReorderPoint := AReorderPoint;
      fParser.Parse;
      if fParser.ParseError then
        raise Exception.Create(fParser.ErrorMessage);
       APoint := fParser.ParseValue;
       if APoint <= 0 then
         APoint := 0;
    end else if AMode = amDailyAvg then begin
      APoint := lSales/fiDays * DaysInAMonth(YearOf(Today), AMonth);
    end else if AMode = amMonthlyAvg then begin
      APoint := lSales/fiMonths;  // Montly Avg
    end else begin   // amMonthlyActual
      APoint := lSales;
    end;
    Result := true;
    if Connection <> GetSharedMyDacConnection then
      Connection.Commit;
  finally
    if Connection.InTransaction and (Connection <> GetSharedMyDacConnection) then
    begin
      Connection.Rollback;
    end;
    Finalise;
  end;
end;
constructor TProductForecast.Create(AOwner: TComponent);
begin
  inherited;
  fDepartment := 0;
  fSupplier := 0;
  TempTableName := '';
end;

function TProductForecast.CreateSmartOrder: Integer;
var
  lWhere: string;
  fLine: TSmartOrderLine;
  lQty: Double;
begin
  Result := 0;
  fSmartOrder := TSmartOrder.Create(Self);
  Initialise;
  try
    if Connection <> GetSharedMyDacConnection then
      Connection.StartTransaction;
    fSmartOrder.Connection := TMyDacDataConnection.Create(fSmartOrder);
    fSmartOrder.Connection.MyDacConnection := Connection;
    fSmartOrder.New;
    fSmartOrder.EmployeeID := AppEnv.Employee.EmployeeID;
    fSmartOrder.CreationDate := Today;
    fSmartOrder.SmartOrderDesc := 'Auto Re-Order';
    fSmartOrder.PostDb;
    fLine := fSmartOrder.Lines;

    if TempTableName <> '' then begin
      lWhere := 'PartsID in (select PartsID from '+TempTableName+')';
    end
    else begin
      lWhere := 'AutoReorder = "T" AND Active="T" AND PartType = "INV" and ifnull(Discontinued, "F") = "F"';
      if Supplier > 0 then
        lWhere := lWhere + ' AND PreferedSupp = "' + tcDataUtils.getSupplierName(Supplier) + '"';
    end;
    fProduct.LoadSelect(lWhere);

    if Assigned(fOnProgressBarInit) then
      fOnProgressBarInit(Self, fProduct.Count);

    while not fProduct.Dataset.EOF do begin
      if Assigned(OnProgressBarStepIt) then
        OnProgressBarStepIt(Self);
      fProduct.ProductClass.Dataset.First;
      fProductClass := fProduct.ProductClass;
      while not fProductClass.Dataset.EOF do begin
        // Department=0 if the user did not select departments, or <> 0 if the user wants a specific department
        // No need to order for other departments
        if (Department = 0) or (fProductClass.DeptID = Department) then
        begin
          lQty := CalcReorderQty;
          { if TempTableName is not blank then user has selected products, so add all to smart order regardless of CalReorderQty }
          if (lQty > 0) or (TempTableName <> '') then begin // Add Smart Order Line
            fLine.Dataset.Append;
            fLine.PARTSID := fProduct.ProductId;
            //fLine.PARTSNAME := fProduct.ProductName;
            if (fProduct.BuyQty3 > 0) and (fProduct.BuyQty3Cost > 0.0) and (lQty >= fProduct.BuyQty3) then
              fLine.CostEx := fProduct.BuyQty3Cost
            else if (fProduct.BuyQty2 > 0) and (fProduct.BuyQty2Cost > 0.0) and (lQty >= fProduct.BuyQty2) then
              fLine.CostEx := fProduct.BuyQty2Cost
            else
              fLine.CostEx := fProduct.BuyQty1Cost;
            fLine.LinePrice := fLine.CostEx;
            fLine.LineTaxRate := GetTaxRate(fProduct.TaxCodePurchase);
            fLine.CostInc := GetAmountInc(fLine.CostEx, fLine.LineTaxRate);
            fLine.ToPurchaseUOMQty := lQty;
            fLine.UnitofMeasure := 'Units';
            fLine.UnitOfMeasureID := 1;
            fLine.UnitofMeasureMultiplier := 1;
            fLine.SearchFilter := fProduct.ProductName;
            fLine.PODesc := fProduct.SalesDescription;
            if fProduct.PreferedSupplierName <> '' then begin
              fLine.SupplierID := fProduct.PreferedSupplier.SupplierId;
              fLine.SupplierName := fProduct.PreferedSupplier.ClientName;
            end;
            fLine.ClassID := fProductClass.DeptId;
            fLine.ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*) := lQty;
            fLine.DeptName := GetClassName(fLine.ClassID);
            fLine.PostDb;
          end;
        end;
        fProductClass.Dataset.Next;
      end;
      fProduct.Dataset.Next;
    end;

    if (fSmartOrder.Lines.Count > 0) and fSmartOrder.Save then begin
      Result := fSmartOrder.Id;
      if Connection <> GetSharedMyDacConnection then
        Connection.Commit;
    end;
  finally
    if Connection.InTransaction and (Connection <> GetSharedMyDacConnection) then
      Connection.Rollback;
    FreeAndNil(fSmartOrder);
    Finalise;
  end;
end;

function TProductForecast.CreateSmartOrderOnSmartApply(aMonths,
  aDeptList: TStringList; AMode : TApplyMode): integer;
var
  lWhere: string;
  fLine: TSmartOrderLine;
  lQty: Double;
  idx : integer;
  s1,
  s : string;

  fiMonths : integer;  // days set by the caller
  fiDays : integer;  // days for the product
//  lDt : TDate;
  qry : TERPQuery;
  lRequiredQty,
  lSales : double;
  lCurrentMonth : TDate;

  function ShortMonthToNumber(const aMonth : string) : integer;
  var
    j : integer;
  begin
    for j := 0 to 11 do
      if SameText(csMonths[j], aMonth) then
      begin
        Result := j + 1;
        exit;
      end;
    Result := MonthOf(Today);
  end;

  procedure AddOrderLine;
  begin
    fLine.Dataset.Append;
    fLine.PARTSID := SOProduct;
    if (qry.FieldByName('BuyQty3').asFloat > 0) and
       (qry.FieldByName('BuyQty3Cost').AsFloat > 0.0) and
       (SOAmount >= qry.FieldByName('BuyQty3').asFloat) then
         fLine.CostEx := qry.FieldByName('BuyQty3Cost').asFloat
       else if (qry.FieldByName('BuyQty2').asFloat > 0) and
         (qry.FieldByName('BuyQty2Cost').asFloat > 0.0) and
         (SOAmount >= qry.FieldByName('BuyQty2').asFloat) then
              fLine.CostEx := qry.FieldByName('BuyQty2Cost').asFloat
       else
         fLine.CostEx := qry.FieldByName('BuyQty1Cost').asFloat;
       fLine.LinePrice := fLine.CostEx;
       fLine.LineTaxRate := GetTaxRate(qry.FieldByName('TaxCodePurchase').asString);
       fLine.CostInc := GetAmountInc(fLine.CostEx, fLine.LineTaxRate);
       fLine.ToPurchaseUOMQty := SOAmount;
       fLine.UnitofMeasure := 'Units';
       fLine.UnitOfMeasureID := 1;
       fLine.UnitofMeasureMultiplier := 1;
       fLine.SearchFilter := qry.FieldByName('ProductName').asString;
       fLine.PODesc := qry.FieldByName('SalesDescription').asString;
       fLine.ClassID := SOClass;
       fLine.ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*) := SOAmount;
       fLine.DeptName := GetClassName(fLine.ClassID);
       fLine.PostDb;
  end;

  function CanUseClass(AClassId : integer) : boolean;
  begin
    if not assigned(aDeptList) or (ADeptList.Count = 0) then
      Result := true
    else
      Result := ADeptList.IndexOf(IntToStr(AClassId)) >= 0;
  end;

  function CalcMonths(aDt : TDate) : integer;
  begin
    Result := 0;
    while aDt < {=} Settings.DateTo do     // ? Inclusive or exclusive?
    begin
      if aMode = amDailyAvg then
        Result := Result + DaysInAMonth(YearOf(aDt), MonthOf(aDt))
      else
        Result := Result + 1;
      aDt := IncMonth(aDt, 1);
    end;
  end;


begin
  Result := 0;
  fSmartOrder := TSmartOrder.Create(Self);
  Initialise;
  fParser.OnGetVar := DoGetSmartOrderParserVariable;
  try
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection;
    if Connection <> GetSharedMyDacConnection then
      Connection.StartTransaction;
    try
    fSmartOrder.Connection := TMyDacDataConnection.Create(fSmartOrder);
    fSmartOrder.Connection.MyDacConnection := Connection;
    fSmartOrder.New;
    fSmartOrder.EmployeeID := AppEnv.Employee.EmployeeID;
    fSmartOrder.CreationDate := Today;
    s := '';
    s1 := '';
    for idx := 0 to AMonths.Count - 1 do
    begin
      if idx = 0 then
      begin
        s := csMonths[StrToInt(AMonths[idx]) - 1];
        s1 := '"' + csMonths[StrToInt(AMonths[idx]) - 1] + '"';
      end
      else
      begin
        s := s + ',' + csMonths[StrToInt(AMonths[idx]) - 1];
        s1 := s1 + ',"' + csMonths[StrToInt(AMonths[idx]) - 1] + '"';
      end;
    end;

    fiMonths := CalcMonths(Settings.DateFrom);


    fSmartOrder.SmartOrderDesc := 'Auto Re-Order (For ' + s + ')';


    fSmartOrder.PostDb;
    fLine := fSmartOrder.Lines;

    if TempTableName <> '' then begin
      lWhere := 'PartsID in (select PartsID from '+TempTableName+')';
    end
    else begin
      lWhere := 'AutoReorder = "T" AND P.Active="T" AND C.active ="T" AND PartType = "INV" and ifnull(Discontinued, "F") = "F"';
      if Supplier > 0 then
        lWhere := lWhere + ' AND PreferedSupp = "' + tcDataUtils.getSupplierName(Supplier) + '"';
    end;

    qry.sql.Text := 'select R.ProductId, R.ClassId, R.ReorderPoint, R.PreferredLevel, R.ReorderAmount, R.OrderMonth,';
    qry.SQL.Add('P.BuyQty1, P.Cost1 as BuyQty1Cost,P.BuyQty2, P.Cost2 as BuyQty2Cost,P.BuyQty3, P.Cost3 as BuyQty3Cost,');
    qry.SQL.Add('P.PURCHTAXCODE as TaxCodePurchase,');
    qry.SQL.Add('P.PartName as ProductName, P.PartsDescription as SalesDescription,');
    qry.SQL.Add('CAST(IFNULL(P.DateCreated, "1999-01-01") as Date) as DateCreated');
    qry.SQL.Add('from tblReorderPoints R');
    qry.SQL.Add('inner join tblProductClasses C on C.ProductId=R.ProductId and C.ClassId = R.ClassId');
    qry.SQL.Add('inner join tblParts P on P.PartsId= R.ProductId where');
    qry.SQL.Add(lWhere);
    qry.SQL.Add('and R.OrderMonth in (' + s1 + ')');
    s1 := ListToCommas(ADeptList);
    if s1 <> '' then
      qry.SQL.Add('AND R.ClassId in '+s1);
    qry.SQL.Add('order by R.ProductId, R.ClassId');
    qry.Open;


    if qry.RecordCount = 0 then
      exit;

    if Assigned(fOnProgressBarInit) then
      fOnProgressBarInit(Self, qry.RecordCount);

    SOProduct := 0;
    SOClass := 0;
    lSales := 0;
    fiDays := 0;
    while Not (qry.Eof) do
    begin
      if SOProduct <> qry.FieldByName('ProductId').AsInteger then
      begin
        if SOProduct <> 0 then
        begin  // add line to the order
          AddOrderLine;
        end;

        if assigned(OnProgressBarSmartOrder) then
          OnProgressBarSmartOrder(Self, 'Processing ' + qry.FieldByName('SalesDescription').asString);

        SOProduct := qry.FieldByName('ProductId').AsInteger;
        SOAmount := 0;
        SOClass := qry.FieldByName('ClassId').AsInteger;
        lCurrentMonth := Settings.DateFrom;
        // Product days
        if Settings.DateFrom >= qry.FieldByName('DateCreated').AsDateTime  then
          fiDays := fiMonths
        else
          fiDays := CalcMonths(qry.FieldByName('DateCreated').AsDateTime);

        if not CanUseClass(SOClass) then
        begin
          SOClass := 0;
          SOProduct := 0;
          qry.Next;
          Continue;
        end;

        if AMode =  amMonthlyActual then
        begin
          lSales := CalcSalesInAMonth(SOProduct,SOClass, lCurrentMonth);
          //lCurrentMonth := IncMonth(lCurrentMonth, 1);
        end
        else
        begin
          // Sales for period
          lSales := CalcSales(SOProduct, SOClass);
          // NOTE: lDays = Days between, if mode=amDailyAvg, or Months if aMode=amMonthlyAvg
          if fiDays > 0 then
            lSales := lSales/fiDays;
          if Settings.UseAvailQty  then
            SOOnHand := TProductClass.AvailableQty(SOProduct, SOClass);
        end;
      end
      else if SOClass <> qry.FieldByName('ClassId').AsInteger then
      begin
        if (SOClass <> 0) and (SOAmount <> 0) then
          AddOrderLine;
        SOAmount := 0;
        SOClass := qry.FieldByName('ClassId').AsInteger;
        lCurrentMonth := Settings.DateFrom;
        if CanUseClass(SOClass) then
        begin
          if AMode =  amMonthlyActual then
          begin
            lSales := CalcSalesInAMonth(SOProduct,SOClass, lCurrentMonth);
            //lCurrentMonth := IncMonth(lCurrentMonth, 1);
          end
          else
          begin
            lSales := CalcSales(SOProduct, SOClass);
            if fiDays > 0 then
              lSales := lSales/fiDays;
          end;
          if Settings.UseAvailQty  then
            SOOnHand := TProductClass.AvailableQty(SOProduct, SOClass);
        end
        else
        begin
          SOClass := 0;
          SOProduct := 0;

          qry.Next;
          Continue;
        end;
      end;

      // Calc Required qty for this month
      if Settings.UseFormula and (Settings.Formula <> '') then
      begin
        SOReorderPoint := qry.FieldByName('ReorderPoint').AsFloat;
        fParser.Parse;
        if fParser.ParseError then
          raise Exception.Create(fParser.ErrorMessage);
        lQty := fParser.ParseValue;
        if lQty <= 0 then
        begin
          lRequiredQty := 0;
        end
        else
          lRequiredQty := lQty;
      end
      else
      (*
      begin
      // Projected sales minus available
        lQty := lSales * DaysInAMonth(YearOf(Today), ShortMonthToNumber(qry.FieldByName('OrderMonth').AsString));
        if SOOnHand < 0 then
          lRequiredQty := -SOOnHand + lQty
        else if lQty > SOOnHand then
          lRequiredQty := lQty - SOOnHand
        else
          lRequiredQty := 0;
      end;
      *)
      begin
        if AMode = amDailyAvg then
        begin
          lQty := lSales * DaysInAMonth(YearOf(Today), ShortMonthToNumber(qry.FieldByName('OrderMonth').AsString));
          lRequiredQty := lQty;
        end
        else if AMode = amMonthlyAvg then
        begin
          lQty := lSales;  // Montly Avg
          lRequiredQty := lSales;
        end
        else
        begin   // amMonthlyActual
          lQty := lSales;
          lRequiredQty := lSales;
        end;
        if Settings.UseAvailQty  then
        begin
          if SOOnHand < 0 then
            lRequiredQty := -SOOnHand + lQty
          else if lQty > SOOnHand then
            lRequiredQty := lQty - SOOnHand
          else
            lRequiredQty := 0;
        end;
      end;

      if (Settings.UseReorderAmount) and (lRequiredQty > 0) then
      begin
        if lRequiredQty < qry.FieldByName('ReorderAmount').asFloat then
          lRequiredQty := qry.FieldByName('ReorderAmount').asFloat
        else if Int(lRequiredQty / qry.FieldByName('ReorderAmount').asFloat) = (lRequiredQty / qry.FieldByName('ReorderAmount').asFloat) then
        //Result is already a multiple of lReorderAmount
        else
          lRequiredQty := (Int(lRequiredQty / qry.FieldByName('ReorderAmount').asFloat) + 1) * qry.FieldByName('ReorderAmount').asFloat;
      end;
      SOAmount := SOAmount + lRequiredQty;
      if Settings.UseAvailQty  then
        SOOnHand := SOOnHand + lRequiredQty - abs(lQty);
      qry.Next;
    end;

    if (SOAmount > 0) and (SOProduct > 0) and (SOClass > 0) then
      AddOrderLine;

    if (fSmartOrder.Lines.Count > 0) then
    begin
      if fSmartOrder.Save then
      begin
        Result := fSmartOrder.Id;
        if Connection <> GetSharedMyDacConnection then
          Connection.Commit;
      end
      else
        Result := 0;
    end
    else
      Result := -1;
  finally
    if Connection.InTransaction and (Connection <> GetSharedMyDacConnection) then
      Connection.Rollback;
  end;
  finally
    qry.ClosenFree;
  end;
  finally
    FreeAndNil(fSmartOrder);
    Finalise;
  end;
end;

procedure TProductForecast.DoGetParserVariable(Sender: TObject;
  const VarName: string; var Value: Extended; var FieldFound: Boolean);
begin
  FieldFound := True;
  if VarName = 'A' then
    Value := fProductClass.ReorderPoint
  else if VarName = 'B' then
    Value := TProductClass.AvailableQty(fProduct.ProductId,fProductClass.DeptID)//fProductClass.AvailableQty
  else if VarName = 'C' then
    Value := TProductClass.OnOrderQty(fProduct.ProductId,fProductClass.DeptID)//fProductClass.OnOrderQty
  else if VarName = 'D' then
    Value := fUsagePerDay
  else if VarName = 'E' then
    Value := fProduct.NormalDeliveryTime;
end;

procedure TProductForecast.DoGetSmartOrderParserVariable(Sender: TObject;
  const VarName: string; var Value: Extended; var FieldFound: Boolean);
begin
  FieldFound := True;
  if VarName = 'A' then
    Value := SOReorderPoint
  else if VarName = 'B' then
//    Value := SOOnHand//TProductClass.AvailableQty(fProduct.ProductId,fProductClass.DeptID)//fProductClass.AvailableQty
    Value := TProductClass.AvailableQty(SOProduct, SOClass)//fProductClass.AvailableQty
  else if VarName = 'C' then
    Value := TProductClass.OnOrderQty(SOProduct,SOClass)//fProductClass.OnOrderQty
  else if VarName = 'D' then
    Value := fUsagePerDay
  else if VarName = 'E' then
    Value := fProduct.NormalDeliveryTime;
end;

procedure TProductForecast.Finalise;
begin
  fProductClass := nil;
  FreeAndNil(fProduct);
  FreeAndNil(fQuery);
  FreeAndNil(fParser);
end;

function TProductForecast.GetConnection: TERPConnection;
begin
  if fConnection = nil then begin
    fConnection := TERPConnection.Create(Self);
    CommonDbLib.SetMyDacConnection(fConnection);
    fConnection.Open;
  end;
  Result := fConnection;
end;

function TProductForecast.GetSettings: TProductForecastFormula;
begin
  if fSettings = nil then
    fSettings := TProductForecastFormula.Create(Self);
  if not fSettings.DatasetActive then
    fSettings.Load;
  Result := fSettings;
end;

{function TProductForecast.GetWhereDate(const DateColumnName: string): string;
begin
(*
  if Settings.UseDateCreated and (fProduct.DateCreated > Settings.DateFrom) then
    fLastDateFrom := fProduct.DateCreated
  else
    fLastDateFrom := Settings.DateFrom;
*)
  fLastDateFrom := GetWhereDateFrom;
  if fLastDateFrom <> 0 then
    Result := '(' + DateColumnName + ' >= "' + FormatDateTime(MysqlDateFormat, fLastDateFrom) + '")';

  if GetWhereDateto <> 0 then
    Result := AppendToWhereClause(Result, '(' + DateColumnName + ' < "' + FormatDateTime(MysqlDateFormat, GetWhereDateto + 1) + '")');
end;}

function TProductForecast.GetWhereDateFrom:Tdatetime;
begin
  if (fProduct.DateCreated > Settings.DateFrom) then
    result := fProduct.DateCreated
  else
    REsult := Settings.DateFrom;
end;

function TProductForecast.GetWhereDateto:TDateTime;
begin
  result := Settings.DateTo;
end;


procedure TProductForecast.Initialise;
begin
  if not Settings.ValidateData then begin
        CommonLib.MessageDlgXP_Vista('Product Forecast Formula is not valid.' , mtWarning , [mbok] , 0);
        Exit;
  end;
    //raise Exception.Create('Product Forecast Formula is not valid.');
  fProduct := TProduct.Create(Self);
  fQuery := TERPQuery.Create(Self);
  fQuery.Options.FlatBuffers := True;
  fQuery.Connection := GetSharedMyDacConnection;
  fParser := TMathParser.Create(Self);
  fParser.OnGetVar := DoGetParserVariable;
  if Settings.UseFormula  then
    fParser.ParseString := Settings.Formula;

 (* fIncludeTransactions := (Settings.Invoices or Settings.SalesOrders);
  if fIncludeTransactions then begin
    if Settings.SalesOrders then
      fTransactionSQLWhere := '(Stock_In_Out IN ("OUT", "SO")) AND (TransType IN ("TSalesOrderLine", "TInvoiceLine"))'
    else
      fTransactionSQLWhere := '(Stock_In_Out = "OUT") AND (TransType = "TInvoiceLine")';
    fTransactionSQLWhere := '(Active = "T") AND ' + fTransactionSQLWhere;
  end; *)

  (*if Settings.Quotes then begin
    fQuoteSQLWhere := '(s.IsQuote = "T") AND (s.Deleted = "F")';
    if Settings.Invoices then
      fQuoteSQLWhere := fQuoteSQLWhere + ' AND (s.Converted = "F")';
  end;*)

  if Settings.DateTo <> 0 then
    fDateTo := Settings.DateTo + 1
  else
    fDateTo := Tomorrow;
end;

function TProductForecast.ReorderAmount(const aPartID: Integer; aDepartment: Integer): Double;
begin
  Result := 0.0;
  Initialise;
  try
    fProduct.Load(aPartID);
    if fProduct.ProductType = 'INV' then begin
      if not fProduct.ProductClass.Dataset.Locate('ClassID', aDepartment, []) then
        Exit;
      fProductClass := fProduct.ProductClass;
      Result := CalcReorderQty;
    end;
  finally
    Finalise;
  end;
end;

procedure TProductForecast.SetConnection(const Value: TERPConnection);
begin
  if Assigned(fConnection) and (Value <> fConnection) then
    FreeandNil(fConnection);
  fConnection := Value;
end;

procedure TProductForecast.SetSettings(const Value: TProductForecastFormula);
begin
  if Assigned(fSettings) and (Value <> fSettings) then
    FreeandNil(fSettings);
  fSettings := Value;
end;

initialization
  RegisterClassOnce(TProductForecastFormula);
end.


