unit salesAnalysisLib;

interface
uses ERPdbComponents;

const

  {NOTE : please dont change the sequence - the position number is hardcoded in 'StockAnalysisReport' for quantities  }
  Transtypes : Array[1..16] of String =
    ({ 1}'Quotes',
     { 2}'Sales Order',
     { 3}'Sales Order BO',
     { 4}'Future Sales Order',
     { 5}'Future Sales Order BO',
     { 6}'Non-ERP Sales',
     { 7}'Total Sales',
     { 8}'Invoice BO',
     { 9}'Used in Build',
     { 10}'On Build Raw',
     { 11}'Building',
     {12}'Stock Transfer',
     {13}'Stock Adjustments',
     {14}'Purchase Order',
     {15}'Built',
     {16}'Purchase Order BO');

const
    I_Quote       = 1;
    I_SO          = 2;
    I_SOBO        = 3;
    I_FSO         = 4;
    I_FSOBO       = 5;
    I_NERPS       = 6;
    I_INV         = 7;
    I_INVBO       = 8;
    I_USEDTOBuilD = 9;
    I_ONBUILD     = 10;
    I_BUILDING    = 11;
    I_TRANS       = 12;
    I_ADJ         = 13;
    I_PO          = 14;
    I_POBO        = 15;
    I_Built       = 16;
    I_AVAILABLE   = 17;
    I_instock     = 18;


  NodeName_Options           = 'Options';
  NodeName_grdmainOptions    = 'grdMain.Options';
  NodeName_SelectedParts     = 'SelectedParts';
  NodeName_SelectedClasses   = 'SelectedClasses';
  NodeName_AllProducts       = 'AllProducts';
  NodeName_AllClasses        = 'AllClasses';
  NodeName_ReportDuration    = 'ReportDuration';
  NodeName_IncreaseDecrease  = 'IncreaseDecrease';
  NodeName_PercentageQty     = 'PercentageQty';
  NodeName_ApplyTo           = 'ApplyTo';
  NodeName_SOQtyPeercent     = 'SOQtyPeercent';
  NodeName_Available         = 'Available';
  NodeName_instock           = 'instock';
  NodeName_TransType         = 'TransType';
  NodeName_StatenCountry     = 'StatenCountry';
  NodeName_AllStatenCountries= 'AllStatenCountries';

  Description_Available         = 'Available';
  Description_InStock           = 'In-Stock';


Function EmployeeContacts(DateFrom, DateTo:TDateTime; EmployeeID:Integer;  sourceIDs:string='';ActionIDS:string=''; DBConnection : TERPConnection = nil):String;
Function EmployeeSales(DateFrom, DateTo:TDateTime; EmployeeID:Integer;  sourceIDs:string='';ActionIDS:string=''; DBConnection : TERPConnection = nil):String;
Function ContactSQL:String;
function nodename(const value: String): String;


implementation

uses sysutils, MySQLConst, CommonDbLib, commonlib;

Function nodename(const value:String):String;
begin
  REsult := Value;
  REsult := replacestr(result, ' ' , '_');
end;

Function EmployeeSales(DateFrom, DateTo:TDateTime; EmployeeID:Integer;  sourceIDs:string='';ActionIDS:string=''; DBConnection : TERPConnection = nil):String;
var
  s:String;
begin
  result:= '';
  s:= EmployeeContacts(DateFrom,dateTo , employeeId, sourceIds, ActionIDs,DBConnection);

  if s<> '' then
    s:= ' Select distinct s.OriginalNo ' +
              'from tblmarketingcontacts MC ' +
              'inner join tblclients C on C.ClientID = MC.ClientID and C.Customer="T" ' +
              'inner join tblSales s on S.clientId = C.clientiD and (S.ISInvoice ="T"  or S.IsCashSale="T") ' +
              ' where S.deleted ="F" and S.cancelled ="F" and MC.Id in (' + s +') '+
        ' union all ' ;

  s:= s + 'Select distinct s.OriginalNo ' +
              'from tblSales s ' +
              'inner join tblclients C on S.clientId = C.clientiD and (S.ISInvoice ="T"  or S.IsCashSale="T") ' +
              'left join tblmarketingcontacts MC on C.ClientID = MC.ClientID and C.Customer="T" ' +
              'where ifnull(MC.ID,0)=0  and s.SaleDate between  ' +quotedstr(formatDateTime(MysqlDateTimeFormat , dateFrom)) +' and ' + quotedstr(formatDateTime(MysqlDateTimeFormat , dateTo));
  if EmployeeID <> 0 then s:= s +' and s.employeeId = ' + inttostr(EmployeeID);


  With TempMyQuery(DBConnection) do try
    SQL.add(s);
    open;
    s:= Groupconcat('OriginalNo', '' , false, ',' , '', '', true);
    if s<> '' then begin
      if active then close;
      SQL.clear;
      SQL.add('Select SaleId from tblsales  where OriginalNo in (' + s +')');
      open;
      result := Groupconcat('SaleID');
    end;
  finally
    ClosenFree;
  end;
end;

Function ContactSQL:String;
begin
  Result:= 'select MC.Id, MC.ClientID , MLL.Leadid,MLL.employeeId, MLL.EmployeeName, min(MLL.ActionDate) firstfollowupdate , min(if(MLL.IsLead="T" , MLL.actiondate , null)) firstLeadDate ,  MC.source , S.MedTypeID as sourceId, MLL.Actiontype FollowupAction  ' +
                ' from tblmarketingleadlines MLL ' +
                ' inner join tblmarketingleads ML on ML.LeadID = MLL.LeadID ' +
                ' inner join tblmarketingcontacts Mc on ML.MarketingContactID = MC.ID ' +
                ' Left join tblsource S on MC.source = S.MediaType ' +
                ' where ifnull(actiondate,0)<> 0 ' +
                ' group by Leadid ' +
                ' order by followupdate';

end;
Function EmployeeContacts(DateFrom, DateTo:TDateTime; EmployeeID:Integer;  sourceIDs:string='';ActionIDS:string=''; DBConnection : TERPConnection = nil):String;
var
  s:String;
begin
  s:=  ContactSQL;
  s:= 'Select * from ( ' + s +') contacts ';
  s := s + '   where ifnull(firstfollowupdate,0) between ' +quotedstr(formatDateTime(MysqlDateTimeFormat , dateFrom)) +' and ' + quotedstr(formatDateTime(MysqlDateTimeFormat , dateTo));
  if  EmployeeID  <> 0  then s := s + ' and EmployeeID      = ' + inttostr(EmployeeID);
  if  sourceIDs   <> '' then s := s + ' and sourceId        in (' + SourceIDs +')' ;
  if  ActionIds   <> '' then s := s + ' and FollowupAction  in (' + ActionIDs +')';
  With TempMyQuery(DBConnection) do try
    SQL.add(s);
    open;
    result:= Groupconcat('ID');
  finally
    ClosenFree;
  end;
end;

end.

