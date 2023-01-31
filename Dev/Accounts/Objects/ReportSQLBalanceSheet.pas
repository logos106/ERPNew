unit ReportSQLBalanceSheet;

interface

uses ReportSQLBase,classes;

type
    TReportSQLBalanceSheet = Class(TReportSQLBase)
      Private
        fsDepartmentIDsString:String;
        (* function DepartmentIDsString:String;*)
        Function Allclasses :boolean;

      Protected
        function GetTemplateSQL: String;Override;
        function GetReportTypeID: integer;override;
      Public
        function PrepareForReport:Boolean; override;
        constructor Create(Aowner:TComponent);override;
        Destructor Destroy;override;
        Property DepartmentIDsString :String read fsDepartmentIDsString write fsDepartmentIDsString;
    End;


implementation

uses ERPDbComponents, Report_Balancesheet_Obj,sysutils, tcConst, TempTableUtils, myaccess, AppEnvironmentVirtual, BusObjectListObj;

{ TReportSQLBalanceSheet }

function TReportSQLBalanceSheet.Allclasses: boolean;
begin
  result:= DepartmentIDsString= '';
end;
constructor TReportSQLBalanceSheet.Create(Aowner: TComponent);
begin
  inherited;
  usingReportTables:= True;
  ReportonForeignCurrency:= true;
  BaseTemptablename := 'tblBalancesheet';
  TempTablename := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, BaseTemptablename);//commondbLib.CreateUserTemporaryTable(BaseTemptablename , '');
  ReportClassName := 'TBalanceSheetGUI';
  ReportSQLSupplied:= TRue;
  AddFCFields;
  DepartmentIDsString := GuiPrefs.Node['DepartmentIDsString'].AsString;
end;

(*function TReportSQLBalanceSheet.DepartmentIDsString: String;
begin
  Result:= GuiPrefs.Node['DepartmentIDsString'].AsString;
end;*)

destructor TReportSQLBalanceSheet.Destroy;
begin
  inherited;
end;

function TReportSQLBalanceSheet.getTemplateSQL: String;
    Function  addForeigncurrencies:string;
    begin
      result:= '';
      if ReportonForeignCurrency then begin
        FConReport.First;
        while FConReport.Eof = False do begin
          if result <> '' then result := result +',';
            result := result + 'TRUNCATE(Column2 * ' +FCOnReport.FieldByname('code').asString +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCOnReport.FieldByname('code').asString + '_Column2,';
            result := result + 'TRUNCATE(Column3 * ' +FCOnReport.FieldByname('code').asString +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCOnReport.FieldByname('code').asString + '_Column3,';
            result := result + 'TRUNCATE(Column4 * ' +FCOnReport.FieldByname('code').asString +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCOnReport.FieldByname('code').asString + '_Column4,';
            result := result + 'TRUNCATE(Column5 * ' +FCOnReport.FieldByname('code').asString +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCOnReport.FieldByname('code').asString + '_Column5';
            FConReport.Next;
        end;
      end;
    end;

    Function AddCaptions:String;
    begin
      REsult:= '';
        if not ReportonForeignCurrency then exit;

        FConReport.First;
        result := result + ',' + Quotedstr(Appenvvirt.str['RegionalOptions.ForeignExDefault'])  + ' as Defaultcurrency_Caption' ;
        While FConReport.eof = False do begin
            result := result + ',' + Quotedstr(FCOnReport.FieldByname('code').asString)  + ' as `' +  FCOnReport.FieldByname('code').asString + '_Caption`' ;
            FConReport.Next;
        end;
    end;


begin
        REsult:= '{RepHeader}SELECT ';
        if not allclasses then result := result + Quotedstr(DepartmentIDsString) +' as ClassType,' else result:= result + '"All" as ClassType, ';
        result := result + ' Concat("As of : " ,' +  QuotedStr(FormatDateTime(FormatSettings.shortdateformat,Dateto)) +   ') as  AsofDate,';
        result := result + ' CO.CompanyName,';
        result := result + ' CO.Address,';
        result := result + ' CO.Address2,';
        result := result + ' CO.City,';
        result := result + ' CO.State,';
        result := result + ' CO.Postcode,';
        result := result + ' Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,';
        result := result + ' Concat("Fax ",CO.FaxNumber) AS FaxNumber,';
        result := result + ' Concat("ABN " , CO.ABN) as ABN ';
        result := result + ' FROM tblCompanyInformation AS CO';
        result := result + ' ~|||~{RepData}';
            result := result + ' SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber, ';
            result := result + ' Column1 as Column1, TRUNCATE(Column2,0) as Column2, TRUNCATE(Column3,0) as Column3,  ';
            result := result + ' TRUNCATE(Column4,0) as Column4, TRUNCATE(Column5,0) as Column5 ';
            if FCFields <> '' then result := result +  ' ' +addForeigncurrencies;
            result := result +  ' ' +AddCaptions;
            result := result + ' FROM ' + Temptablename;
            result := result + ' WHERE AccountType <> "TOTAL LIABILITIES & EQUITY"  ';
            result := result + ' AND AccountType <> "Total Capital / Equity"  ';
            result := result + ' AND AccountType <> "TOTAL ASSETS" ';
            result := result + ' Group By Column1 ';
            result := result + ' Union ALL ';
            result := result + ' SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ';
            result := result + ' Column1, TRUNCATE(Column2,0), TRUNCATE(Column3,0),  ';
            result := result + ' TRUNCATE(Column4,0), TRUNCATE(Sum(Column5),0) as Column5 ';
            if FCFields <> '' then result := result +  ' ' +addForeigncurrencies;
            result := result +  ' ' +AddCaptions;
            result := result + ' FROM ' + Temptablename ;
            result := result + ' WHERE AccountType = "TOTAL ASSETS" ';
            result := result + ' Group By AccountType ';
            result := result + ' Union ALL ';
            result := result + ' SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ';
            result := result + ' Column1, TRUNCATE(Column2,0), TRUNCATE(Column3,0), ';
            result := result + ' TRUNCATE(Sum(Column4),0),TRUNCATE(Column5,0) ';
            if FCFields <> '' then result := result + ' ' +addForeigncurrencies;
            result := result +  ' ' +AddCaptions;
            result := result + ' FROM ' + Temptablename ;
            result := result + ' WhERE AccountType = "Total Capital / Equity" ';
            result := result + ' Group BY Column1 ';
            result := result + ' Union ALL ';
            result := result + ' SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ';
            result := result + ' Column1, TRUNCATE(Column2,0), TRUNCATE(Column3,0),  ';
            result := result + ' TRUNCATE(Column4,0), TRUNCATE(Sum(Column5),0) ';
            if FCFields <> '' then result := result + addForeigncurrencies;
            result := result + AddCaptions;
            result := result + ' FROM ' + Temptablename ;
            result := result + ' WhERE AccountType = "TOTAL LIABILITIES & EQUITY" ';
            result := result + ' Group BY SortID ';
            result := result + ' Order by ID; ';
end;
function TReportSQLBalanceSheet.GetReportTypeID: integer;
begin
  Result := 36;
end;

function TReportSQLBalanceSheet.Prepareforreport: Boolean;
var
    BalancesheetReportObj: TBalanceSheet_Report_Obj;
begin
  if not Userlock.Lock('tbltransactions' ,0) then begin
    Result:= False;
    AddError('Failed to Lock the Transaction Table');
    Exit;
  end;
  ClosenfreeFCOnReport; // will reopen the fc table if any new currency is selected
  AddFCFields; // this is to make sure if any new currecny field is selected
  try
    BalancesheetReportObj := TBalanceSheet_Report_Obj.Create(True);
    try
      BalancesheetReportObj.CleanRefreshBalanceSheetTable(allclasses, DepartmentIDsString, DateTo, TempTablename, FCFields );
      Result:= True;
    finally
      FreeandNil(BalancesheetReportObj);
    end;
  finally
    UserLock.UnLock('tbltransactions' , 0);
  end;
end;

initialization
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Balance Sheet','TReportSQLBalanceSheet','TBalanceSheetGUI');
  Classes.RegisterClass(TReportSQLBalanceSheet);
end.

