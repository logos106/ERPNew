unit ERPCombinedContactsSQL;

interface
uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj, StrUtils;

type
  TERPCombinedContacts = class(TReportWithDateRangeBase)
  Private
    fsCompany: String;
    fsEmployeeName: String;

  Protected
    fbIsVS1List: Boolean;

  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;

  published
    Property Company: String      read fsCompany        write fsCompany;
    Property EmployeeName: String read fsEmployeename   write fsEmployeename;

  end;

  TERPCombinedContactsVS1 = Class(TERPCombinedContacts)
  Public
    constructor Create; Override;
  End;


implementation

uses AppEnvironment, utVS1Const, StringUtils;

{ TERPCombinedContacts }

constructor TERPCombinedContacts.Create;
begin
  inherited;
  fbIsVS1List := False;
  Company := '';
  Employeename := '';
end;

function TERPCombinedContacts.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    if ContainsText(STemp, 'printname=') then
      STemp := ReplaceStr(STemp, 'printname=', 'C.Printname LIKE ')
    else if ContainsText(STemp, 'name=') then
      STemp := ReplaceStr(STemp, 'name=', 'C.company LIKE ');
    STemp := ReplaceStr(STemp, 'name=', 'C.company=');
    STemp := ReplaceStr(STemp, 'printname=', 'C.Printname=');

    if ContainsText(Search, 'TYPE="C"') then
      STemp := ReplaceStr(STemp, 'TYPE="C"', '1');
    if ContainsText(Search, 'TYPE="E"') then
      STemp := ReplaceStr(STemp, 'TYPE="E"', '0');

    STemp := ReplaceStr(STemp, '"', '%"');
    STemp := ReplaceStr(STemp, 'LIKE %"', 'LIKE "%');

    if ContainsText(STemp, 'ARBalance=') then
      STemp := ReplaceStr(STemp, 'ARBalance', 'C.ARBalance')
    else if ContainsText(STemp, 'APBalance=') then
      STemp := ReplaceStr(STemp, 'APBalance', 'C.APBalance')
    else if ContainsText(STemp, 'Balance=') then
      STemp := ReplaceStr(STemp, 'Balance', 'C.Balance');

    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'ID', 'C.ClientID');
    STemp := ReplaceStr(STemp, 'CreditLimit', 'C.CreditLimit');
    STemp := ReplaceStr(STemp, 'SOBalance', 'C.SOBalance');
    STemp := ReplaceStr(STemp, 'isprospect', 'C.othercontact');
    STemp := ReplaceStr(STemp, 'iscustomer', 'C.customer');
    STemp := ReplaceStr(STemp, 'issupplier', 'C.supplier');
    STemp := ReplaceStr(STemp, 'isEmployee', '"F"');

    Result := STemp;
  end;

  function ReplaceAlias2(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    if ContainsText(STemp, 'printname=') then
      STemp := ReplaceStr(STemp, 'printname=', 'employeename LIKE ')
    else if ContainsText(STemp, 'name=') then
      STemp := ReplaceStr(STemp, 'name=', 'employeename LIKE ');

    if ContainsText(Search, 'TYPE="C"') then
      STemp := ReplaceStr(STemp, 'TYPE="C"', '0');
    if ContainsText(Search, 'TYPE="E"') then
      STemp := ReplaceStr(STemp, 'TYPE="E"', '1');

    STemp := ReplaceStr(STemp, '"', '%"');
    STemp := ReplaceStr(STemp, 'LIKE %"', 'LIKE "%');

    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'isprospect', '"F"');
    STemp := ReplaceStr(STemp, 'iscustomer', '"F"');
    STemp := ReplaceStr(STemp, 'issupplier', '"F"');
    STemp := ReplaceStr(STemp, 'isEmployee', '"T"');
    STemp := ReplaceStr(STemp, 'TYPE', '"E"');

    STemp := ReplaceStr(STemp, 'ID', 'EmployeeID');
    if ContainsText(STemp, 'ARBalance=') then
      STemp := ReplaceStr(STemp, 'ARBalance', '0.0')
    else if ContainsText(STemp, 'APBalance=') then
      STemp := ReplaceStr(STemp, 'APBalance', '0.0')
    else if ContainsText(STemp, 'Balance=') then
      STemp := ReplaceStr(STemp, 'Balance', '0.0');

    STemp := ReplaceStr(STemp, 'CreditLimit', '0.0');
    STemp := ReplaceStr(STemp, 'SOBalance', '0.0');

    Result := STemp;
  end;
begin
  result := inherited;
  SQL.Clear;
  SQL.Add('SELECT ');
  SQL.Add('"C" TYPE, ');
  SQL.Add('C.ClientId      AS ID, ');
  SQL.Add('C.company       AS name, ');
  SQL.Add('C.Printname     AS printname, ');
  SQL.Add('C.othercontact  AS isprospect, ');
  SQL.Add('C.customer      AS iscustomer, ');
  SQL.Add('C.supplier      AS issupplier, ');
  SQL.Add('"F"             AS isEmployee, ');
  SQL.Add('C.phone         AS phone, ');
  SQL.Add('C.mobile        AS mobile , ');
  SQL.Add('C.altphone      AS altphone, ');
  SQL.Add('C.email         AS email, ');
  SQL.Add('C.street        AS street, ');
  SQL.Add('C.street2       AS street2, ');
  SQL.Add('C.street3       AS street3, ');
  SQL.Add('C.suburb        AS suburb, ');
  SQL.Add('C.state         AS state, ');
  SQL.Add('C.postcode      AS postcode, ');
  SQL.Add('C.ARBalance     AS ARBalance, ');
  SQL.Add('C.APBalance     AS APBalance, ');
  SQL.Add('C.CreditLimit   AS CreditLimit, ');
  SQL.Add('C.Balance       AS Balance, ');
  SQL.Add('C.SOBalance     AS SalesOrderBalance, ');
  SQL.Add('IF(' + QuotedStr(BoolToStr(AppEnv.CompanyPrefs.CreditCheckSO, True)) + '="True", C.Balance + C.SOBalance, C.Balance) AS CreditBalance, ');
  SQL.Add('Active          AS Active');
  SQL.Add('FROM tblclients C ');
  SQL.Add('WHERE C.company <> ""');
  if fbIsVS1List then SQL.Add('AND C.PublishOnVS1 = "T"');
  if Company <> '' then SQL.Add('AND C.Company = ' + QuotedStr(Company));
  if Search <> '' then SQL.Add('AND ' + ReplaceAlias(Search));

  SQL.Add('UNION ');
  SQL.Add('SELECT ');
  SQL.Add('"E"           AS TYPE, ');
  SQL.Add('EmployeeId    AS ID, ');
  SQL.Add('employeename  AS name, ');
  SQL.Add('employeename  AS Printname, ');
  SQL.Add('"F"           AS isprospect, ');
  SQL.Add('"F"           AS iscustomer, ');
  SQL.Add('"F"           AS issupplier, ');
  SQL.Add('"T"           AS isEmployee, ');
  SQL.Add('phone         AS phone, ');
  SQL.Add('mobile        AS mobile, ');
  SQL.Add('altphone      AS altphone, ');
  SQL.Add('email         AS email, ');
  SQL.Add('street        AS street, ');
  SQL.Add('street2       AS street2, ');
  SQL.Add('street3       AS street3, ');
  SQL.Add('suburb        AS suburb, ');
  SQL.Add('state         AS state, ');
  SQL.Add('postcode      AS postcode , ');
  SQL.Add('0.0           AS ARBalance,');
  SQL.Add('0.0           AS APBalance,');
  SQL.Add('0.0           AS CreditLimit,');
  SQL.Add('0.0           AS Balance,');
  SQL.Add('0.0           AS SalesOrderBalance,');
  SQL.Add('0.0           AS CreditBalance,');
  SQL.Add('Active        AS Active');
  SQL.Add('FROM tblemployees ');
  SQL.Add('WHERE Firstname <> ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName));
  if Employeename <> '' then SQL.Add('AND EmployeeName = '+ QuotedStr(Employeename));
  if Search <> '' then SQL.Add('AND ' + ReplaceAlias2(Search));

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy)
  else SQL.Add('ORDER BY name ');
end;

{ TERPCombinedContactsVS1 }
constructor TERPCombinedContactsVS1.Create;
begin
  inherited;
  fbIsVS1List := True;
end;

initialization
  RegisterClass(TERPCombinedContacts);
  RegisterClass(TERPCombinedContactsVS1);
end.
