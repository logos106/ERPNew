unit TemplateReportsLib;

interface

uses
  ERPDBComponents;

  Function invoicefooterSQL: String;
  function companyInfoSQL(const sqlname: String = ''; dateFrom: TDateTime = 0; DateTo: TDateTime = 0;
    HaveSQLName: boolean = true; extrafields: String = ''): string;
  function ColumnHeadingsSQL(const sqlname: String = ''; extrafields: String = '';
    HaveSQLName: boolean = true): string;
  function BlankColumnHeadings: string;
  Function POSTillEOPConfigSQL(const sqlname: String = ''; extrafields: String = '';
    HaveSQLName: boolean = true): string;
  function TemplateContainsSection(const aSectionName, aTemplateName: string;
    var aPosition: integer): boolean;
  Procedure AddSQLPortion(var sSQL: String; x: integer; asqlPortion: String);
  function CountSections(const aSQL: string): integer;
  Function WeightFields(const Weightfield: String; fieldname: String): String;

implementation

uses
  AppEnvironment, sysutils, CommonLib, MySQLConst, BusObjPOSTillEOPConfig,
  DbSharedObjectsObj, CommonDbLib, Types, StrUtils,
  StringUtils, tcConst, JsonObject;

Function invoicefooterSQL: String;
begin
  Result := 'Select Invoice_Footer from vinvoicefooterpref';
end;

function companyInfoSQL(const sqlname: String = ''; dateFrom: TDateTime = 0; DateTo: TDateTime = 0;
  HaveSQLName: boolean = true; extrafields: String = ''): string;
begin
  Result := iif(HaveSQLName, '{' + iif(sqlname = '', 'CompanyInfo', sqlname) + '}', '') + 'SELECT '
    + ' CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN,   '
    + 'concat("Ph: ", CO.PhoneNumber) AS Phone, concat("Fax: " , CO.FaxNumber) AS Fax, concat("Email: " , CO.email) as EmailAddress, '
    + 'CO.URL , concat("Website: " , CO.URL) as WebAddress, ' +
    'Concat (if(ifnull(CO.CompanyName,"") <> "" , concat(CO.CompanyName , "\n"), ""),' +
    'if(ifnull(CO.Address,"") <> "" , concat(CO.Address,   "\n"), ""),' +
    'if(ifnull(CO.Address2,"") <> "" , concat(CO.Address2 , "\n"), ""),' +
    'if(ifnull(CO.City,"") <> "" , concat(CO.City , "\n"), ""),' +
    'if(ifnull(CO.State,"") <> "" , concat(CO.State , "\n"), ""),' +
    'if(ifnull(CO.Postcode,"") <> "" , concat(CO.Postcode , "\n"), "")) NamenAddress,' +
    'concat_ws(", ",  nullif(CO.Address, ""),  nullif(CO.Address2, ""), nullif(CO.Address3, ""), nullif(CO.City  , ""),  nullif(concat(CO.State  , " "  , CO.postCode  ),"") , nullif(CO.country  , "") ) as CompAddress, '
    + 'concat_ws(", ",  nullif(CO.POBox  , ""),  nullif(CO.POBox2  , ""), nullif(CO.POBox3  , ""), nullif(CO.POCity, ""),  nullif(concat(CO.POState, " "  , CO.POPostcode),"") , nullif(CO.POCountry, "") ) as CompbillAddress , '
    + 'CO.email , ' + iif(dateFrom <> 0, 'convert(' + Quotedstr(formatdateTime(mySQLDatetimeFormat,
    dateFrom)) + ',dateTime)  as DateFrom,', '') +
    iif(DateTo <> 0, 'convert(' + Quotedstr(formatdateTime(mySQLDatetimeFormat, DateTo)) +
    ',dateTime)  as DateTo,', '') + Quotedstr(AppEnv.Employee.EmployeeName) + ' as LoggedInUser ,' +

    Quotedstr(AppEnv.DefaultClass.ClassHeading) + ' as ClassHeading ,' +
    Quotedstr(AppEnv.CompanyPrefs.ProductAttrib1Name) + ' as ProductAttrib1Name ,' +
    Quotedstr(AppEnv.CompanyPrefs.ProductAttrib2Name) + ' as ProductAttrib2Name ,' +
    Quotedstr(AppEnv.DefaultClass.PartColumn) + ' as PartColumn ,' +
    Quotedstr(AppEnv.DefaultClass.FirstColumn) + ' as FirstColumn ,' +
    Quotedstr(AppEnv.DefaultClass.SecondColumn) + ' as SecondColumn ,' +
    Quotedstr(AppEnv.DefaultClass.ThirdColumn) + ' as ThirdColumn, ' +
    Quotedstr(AppEnv.DefaultClass.CustomerColumnName) + ' as CustomerColumnName, ' +
    Quotedstr(AppEnv.DefaultClass.SupplierColumnName) + ' as SupplierColumnName, ' +
    Quotedstr(AppEnv.DefaultClass.ProspectColumnName) + ' as ProspectColumnName, ' +
    Quotedstr(AppEnv.CompanyPrefs.ProductPrintNameHeading) + ' as ProductPrintNameHeading, ' +
    Quotedstr(AppEnv.CompanyPrefs.ClientPrintNameHeading) + ' as ClientPrintNameHeading, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationBatchnoName) + ' as AllocationBatchnoName, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationExpiryDateName) + ' as AllocationExpiryDateName, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationTruckLoadNoName) + ' as AllocationTruckLoadNoName ,' +
    Quotedstr(AppEnv.DefaultClass.EquipmentName) + ' as EquipmentName, ' +
    Quotedstr(AppEnv.DefaultClass.HireName) + ' as HireName, ' +

    Quotedstr(iif(AppEnv.CompanyPrefs.RetailcustomerType1 = '', '<Not Selected>',
    AppEnv.CompanyPrefs.RetailcustomerType1)) + ' as RetailcustomerType1, ' +
    Quotedstr(iif(AppEnv.CompanyPrefs.WholeSaleCustomerType1 = '', '<Not Selected>',
    AppEnv.CompanyPrefs.WholeSaleCustomerType1)) + ' as WholeSaleCustomerType1, ' +
    Quotedstr(iif(AppEnv.CompanyPrefs.WholeSaleCustomerType2 = '', '<Not Selected>',
    AppEnv.CompanyPrefs.WholeSaleCustomerType2)) + ' as WholeSaleCustomerType2, ' +
    Quotedstr(iif(AppEnv.CompanyPrefs.WholeSaleCustomerType3 = '', '<Not Selected>',
    AppEnv.CompanyPrefs.WholeSaleCustomerType3)) + ' as WholeSaleCustomerType3, ' +
    Quotedstr(iif(AppEnv.CompanyPrefs.WholeSaleCustomerType4 = '', '<Not Selected>',
    AppEnv.CompanyPrefs.WholeSaleCustomerType4)) + ' as WholeSaleCustomerType4 ,  ' +

    Quotedstr(AppEnv.CompanyPrefs.PackWeightField1) + ' as PackWeightField1 , ' +
    Quotedstr(AppEnv.CompanyPrefs.PackWeightField2) + ' as PackWeightField2  ' +

    extrafields + ' FROM tblCompanyInformation AS CO';
end;

function BlankColumnHeadings: string;
begin
  Result := 'Select ' + Quotedstr('') + ' as ClassHeading ,' + Quotedstr('') +
    ' as ProductAttrib1Name ,' + Quotedstr('') + ' as ProductAttrib2Name ,' + Quotedstr('') +
    ' as PartColumn ,' + Quotedstr('') + ' as FirstColumn ,' + Quotedstr('') + ' as SecondColumn ,'
    + Quotedstr('') + ' as ThirdColumn, ' + Quotedstr('') + ' as AllocationBatchnoName, ' +
    Quotedstr('') + ' as AllocationExpiryDateName, ' + Quotedstr('') +
    ' as AllocationTruckLoadNoName ,' + Quotedstr('') + ' as Fe1Name , ' + Quotedstr('') +
    ' as Fe2Name , ' + Quotedstr('') + ' as Fe3Name , ' + Quotedstr('') + ' as Fe4Name , ' +
    Quotedstr('') + ' as Fe5Name , ' + Quotedstr('') + ' as PQADEtailsCUSTFLD1,' + Quotedstr('') +
    ' as PQADEtailsCUSTFLD4,' + Quotedstr('') + ' as EquipmentName, ' + Quotedstr('') +
    ' as HireName ' + ' from DUAL';
end;

function ColumnHeadingsSQL(const sqlname: String = ''; extrafields: String = '';
  HaveSQLName: boolean = true): string;
begin
  Result := iif(HaveSQLName, '{' + iif(sqlname = '', 'columnHeadings', sqlname) + '}', '') +
    'Select ' + Quotedstr(AppEnv.DefaultClass.ClassHeading) + ' as ClassHeading ,' +
    Quotedstr(AppEnv.CompanyPrefs.ProductAttrib1Name) + ' as ProductAttrib1Name ,' +
    Quotedstr(AppEnv.CompanyPrefs.ProductAttrib2Name) + ' as ProductAttrib2Name ,' +
    Quotedstr(AppEnv.DefaultClass.PartColumn) + ' as PartColumn ,' +
    Quotedstr(AppEnv.DefaultClass.FirstColumn) + ' as FirstColumn ,' +
    Quotedstr(AppEnv.DefaultClass.SecondColumn) + ' as SecondColumn ,' +
    Quotedstr(AppEnv.DefaultClass.ThirdColumn) + ' as ThirdColumn, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationBatchnoName) + ' as AllocationBatchnoName, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationExpiryDateName) + ' as AllocationExpiryDateName, ' +
    Quotedstr(AppEnv.DefaultClass.AllocationTruckLoadNoName) + ' as AllocationTruckLoadNoName ,' +
    Quotedstr(AppEnv.CompanyPrefs.Fe1Name) + ' as Fe1Name , ' +
    Quotedstr(AppEnv.CompanyPrefs.Fe2Name) + ' as Fe2Name , ' +
    Quotedstr(AppEnv.CompanyPrefs.Fe3Name) + ' as Fe3Name , ' +
    Quotedstr(AppEnv.CompanyPrefs.Fe4Name) + ' as Fe4Name , ' +
    Quotedstr(AppEnv.CompanyPrefs.Fe5Name) + ' as Fe5Name , ' +
    Quotedstr(AppEnv.DefaultClass.EquipmentName) + ' as EquipmentName, ' +
    Quotedstr(AppEnv.DefaultClass.HireName) + ' as HireName ,' +
    Quotedstr(AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1) + ' as PQADEtailsCUSTFLD1,' +
    Quotedstr(AppEnv.CompanyPrefs.PQADEtailsCUSTFLD4) + ' as PQADEtailsCUSTFLD4' +
    iif(extrafields <> '', ', ' + extrafields, '') + ' from DUAL';
end;

Function POSTillEOPConfigSQL(const sqlname: String = ''; extrafields: String = '';
  HaveSQLName: boolean = true): string;
var
  POSTillEOPConfig: TPOSTillEOPConfig;
begin
  POSTillEOPConfig := TPOSTillEOPConfig.CreateWithNewConn(nil);
  try
    POSTillEOPConfig.Load;
    Result := iif(HaveSQLName, '{' + iif(sqlname = '', 'POSCOnfif', sqlname) + '}', '') + 'SELECT '
      + Floattostr(POSTillEOPConfig.Multiplier1) + ' as Multiplier1, ' +
      Floattostr(POSTillEOPConfig.Multiplier2) + ' as Multiplier2, ' +
      Floattostr(POSTillEOPConfig.Multiplier3) + ' as Multiplier3, ' +
      Floattostr(POSTillEOPConfig.Multiplier4) + ' as Multiplier4, ' +
      Floattostr(POSTillEOPConfig.Multiplier5) + ' as Multiplier5, ' +
      Floattostr(POSTillEOPConfig.Multiplier6) + ' as Multiplier6, ' +
      Floattostr(POSTillEOPConfig.Multiplier7) + ' as Multiplier7, ' +
      Floattostr(POSTillEOPConfig.Multiplier8) + ' as Multiplier8, ' +
      Floattostr(POSTillEOPConfig.Multiplier9) + ' as Multiplier9, ' +
      Floattostr(POSTillEOPConfig.Multiplier10) + ' as Multiplier10, ' +
      Floattostr(POSTillEOPConfig.Multiplier11) + ' as Multiplier11, ' +
      Floattostr(POSTillEOPConfig.Multiplier12) + ' as Multiplier12, ' +
      Floattostr(POSTillEOPConfig.Multiplier13) + ' as Multiplier13, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption1) + ' as AmtCaption1, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption2) + ' as AmtCaption2, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption3) + ' as AmtCaption3, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption4) + ' as AmtCaption4, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption5) + ' as AmtCaption5, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption6) + ' as AmtCaption6, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption7) + ' as AmtCaption7, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption8) + ' as AmtCaption8, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption9) + ' as AmtCaption9, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption10) + ' as AmtCaption10, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption11) + ' as AmtCaption11, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption12) + ' as AmtCaption12, ' +
      Quotedstr(POSTillEOPConfig.AmtCaption13) + ' as AmtCaption13';

  finally
    Freeandnil(POSTillEOPConfig);
  end;

end;

Procedure AddSQLPortion(var sSQL: String; x: integer; asqlPortion: String);
begin
  if x <= 1 then
    exit;
  While StringCount('~|||~', sSQL) < x - 1 do
    sSQL := sSQL + '~|||~';
  if asqlPortion <> '' then
    sSQL := sSQL + asqlPortion;
end;

function TemplateContainsSection(const aSectionName, aTemplateName: string;
  var aPosition: integer): boolean;
var
  qry: TERPQuery;
  arr: TStringDynArray;
  sql: string;
  x: integer;
begin
  Result := false;
  aPosition := 0;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.sql.Add('select SQLString from tbltemplates where TemplName = ' + Quotedstr(aTemplateName));
    qry.sql.Add('and SQLString like "%{' + aSectionName + '}%"');
    qry.Open;
    if qry.IsEmpty then begin
      qry.close;
      qry.sql.clear;
      qry.sql.Add('select SQLString from tbltemplates where TemplateClass = ' +
        Quotedstr(aTemplateName));
      qry.sql.Add('and SQLString like "%{' + aSectionName + '}%"');
      qry.Open;
    end;
    if qry.IsEmpty then
      exit;

    Result := true;
    sql := qry.FieldByName('SQLString').AsString;
    arr := StringUtils.SplitString(sql, '~|||~');
    for x := Low(arr) to High(arr) do begin
      if Pos('{' + aSectionName + '}', arr[x]) > 0 then begin
        aPosition := x + 1;
        break;
      end;
    end;
  finally
    // qry.Free;
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function CountSections(const aSQL: string): integer;
var
  arr: TStringDynArray;
begin
  Result := 0;
  arr := StringUtils.SplitString(aSQL, '~|||~');
  if Length(arr) > 0 then
    Result := Length(arr) + 1;
end;

Function WeightFields(const Weightfield: String; fieldname: String): String;
begin
  Result := 'Round(' + Weightfield + ',' + inttostr(GeneralRoundPlaces) + ')  as ' + fieldname + ','
    + 'Round(' + Weightfield + '* ' + Floattostr(LBstoKGs) + ' ,' + inttostr(GeneralRoundPlaces) +
    ') as ' + fieldname + 'inKG,' + 'Round(' + Weightfield + '* ' + Floattostr(KGstoLBs) + ' ,' +
    inttostr(GeneralRoundPlaces) + ') as ' + fieldname + 'inlb';
end;

end.
