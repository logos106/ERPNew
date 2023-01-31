unit frmMarketingRatiosGUI;
{Gets its data from tblmarketingContacts which can contain non-clients and
 clients.}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfrmMarketingRatios = class(TBaseListingGUI)
    qryMainLineDate: TDateField;
    qryMainCalls: TIntegerField;
    qryMainDMContacted: TIntegerField;
    qryMainLeads: TIntegerField;
    qryMainApproved: TIntegerField;
    qryMainNotApproved: TIntegerField;
    qryMainCallsApprovedRatio: TWideStringField;
    qryMainLeadstosalesRatio: TWideStringField;
    qryMainSales: TIntegerField;
    qryMainCallsSalesRatio: TWideStringField;
    qryMainSource: TWideStringField;
    grdManual: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryManual: TERPQuery;
    dsManual: TDataSource;
    qryManualID: TIntegerField;
    qryManualSource: TWideStringField;
    qryManualLineDate: TDateField;
    qryManualColdCalls: TIntegerField;
    qryManualContact: TIntegerField;
    qryManualFirstDemo: TIntegerField;
    qryManualSecondDemo: TIntegerField;
    qryManualQuotes: TIntegerField;
    qryManualSalesOrders: TIntegerField;
    qryManualSales: TIntegerField;
    qryManualGoogleVisitCount: TIntegerField;
    qryManualCallsSalesRatio: TWideStringField;
    qryManualBudgetToSalesRatio: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
  protected
    procedure RefreshQuery; override;
  private
    mGrid : TwwDbGrid;  // manual
    mQry : TERPQuery;
    aGrid : TwwDbGrid;  // auto
    aQry : TERPQuery;
    Tablename :String;
    TableManual : string;
    procedure CreateTempTable;
    procedure AddDataToTempTable;
    procedure AddDataToTempTableAutomatic;
    procedure AddDataToTempTableManual;
    procedure DeleteTempTable;
    procedure DeleteDataTempTable;

    function GetCalls(Const Source:String):integer; overload;
    function GetLeads(Const MediaType:String):integer;
    function GetClientTypeLeads(Const MediaType:String):integer;

    function GetDMContacted(Const ClientID:integer):integer;  overload;
    function GetDMContacted(Const Source:String):integer;     overload;
    function GetApproved(Const sSource:string):integer;       overload;
    function GetApproved(Const iClientID:integer):integer;    overload;
    function GetSales(Const Source:String):integer;
    procedure CreateTempTableManual;

  public
    { Public declarations }
  end;



implementation

{$R *.dfm}
uses
  CommonLib, CommonDbLib, MySQLConst, MarketingLeads;

procedure TfrmMarketingRatios.CreateTempTableManual;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + TableManual + '; ');
    qryTemp.Sql.Add('CREATE TABLE ' + TableManual + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`Source` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`LineDate` date default NULL, ');
    qryTemp.Sql.Add('`ColdCalls` int(11) default NULL, ');
    qryTemp.Sql.Add('`Contact` int(11) default NULL, ');
    qryTemp.Sql.Add('`FirstDemo` int(11) default NULL, ');
    qryTemp.Sql.Add('`SecondDemo` int(11) default NULL, ');
    qryTemp.Sql.Add('`Quotes` int(11) default NULL, ');
    qryTemp.Sql.Add('`SalesOrders` int(11) default NULL, ');
    qryTemp.Sql.Add('`Sales` int(11) default NULL, ');
    qryTemp.Sql.Add('`GoogleVisitCount` int(11) default NULL, ');
    qryTemp.Sql.Add('`CallsSalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`BudgetToSalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`),  KEY `Dates` (`LineDate`)) ENGINE=MyISAM; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmMarketingRatios.CreateTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + TableName + '; ');
    qryTemp.Sql.Add('CREATE TABLE ' + TableName + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`Source` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`LineDate` date default NULL, ');
    qryTemp.Sql.Add('`GlobalRef` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Calls` int(11) default NULL, ');
    qryTemp.Sql.Add('`DMContacted` int(11) default NULL, ');
    qryTemp.Sql.Add('`Leads` int(11) default NULL, ');
    qryTemp.Sql.Add('`Approved` int(11) default NULL, ');
    qryTemp.Sql.Add('`NotApproved` int(11) default NULL, ');
    qryTemp.Sql.Add('`CallsApprovedRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`LeadstosalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Sales` int(11) default NULL, '); //Sales Order or Invoice
    qryTemp.Sql.Add('`CallsSalesRatio` varchar(255) default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`),  KEY `Dates` (`LineDate`)) ENGINE=MyISAM; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure TfrmMarketingRatios.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmMarketingRatios.AddDataToTempTable;
begin
  if grpFilters.ItemIndex <= 0 then
    AddDataToTempTableAutomatic
  else
    AddDataToTempTableManual;
end;

procedure TfrmMarketingRatios.AddDataToTempTableAutomatic;
var
  InsertSQL: string;
  qry2: TERPCommand;
  qry: TERPQuery;
  sName,sCallsApprovedRatio,sLeadstosalesRatio,sCallsSalesRatio:string;
  iCalls,iDMContacted,iLeads,iApproved,iNotApproved,iSales:integer;
begin
  iSales:=0;
  DeleteDataTempTable;
  qry := CommonDbLib.TempMyQuery;
  qry2 := TERPCommand.Create(nil);
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Source,tblSource.Active FROM tblmarketingcontacts');
    qry.SQL.Add('INNER JOIN tblsource ON tblmarketingcontacts.source = tblsource.MediaType');
    qry.SQL.Add('WHERE  tblSource.Active = "T"');

    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND DateEntered Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');


    qry.SQL.Add('GROUP BY Source;');
    qry.Open;
    qry.First;

    qry2.SQL.Clear;
    qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
    InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + TableName + '(Source,Calls,DMContacted,Leads,Approved,NotApproved,CallsApprovedRatio,LeadstosalesRatio,Sales,CallsSalesRatio)';
    qry2.Sql.Clear;
    while not qry.Eof do begin   //non Clients
      if qry.fieldByName('Source').AsString = '' then begin
        qry.Next;
        Continue; //do these after loop
      end;
      iCalls := GetCalls(qry.fieldByName('Source').AsString);
      iDMContacted      := GetDMContacted(qry.fieldByName('Source').AsString);
      sName             := qry.fieldByName('Source').AsString;

      iLeads            := GetLeads(sName);
      iApproved          := GetApproved(sName);
      iNotApproved      := iLeads - iApproved;
      iSales            := GetSales(qry.fieldByName('Source').AsString);


      sCallsApprovedRatio := '   = ' + FormatFloat('#0.0',(Divzer(iApproved,iCalls) * 100)) + ' %';
      sLeadstosalesRatio := '    = ' + FormatFloat('#0.0',(Divzer(iSales,iLeads) * 100)) + ' %';
      sCallsSalesRatio    := '   = ' + FormatFloat('#0.0',(Divzer(iSales,iCalls) * 100)) + ' %';


      qry2.Sql.Add(InsertSQL);
      qry2.Sql.Add(' VALUES(' +
                      QuotedStr(sName)           + ',' +
                      IntToStr(iCalls)           +  ',' +
                      IntToStr(iDMContacted)     + ',' +
                      IntToStr(iLeads)           + ',' +
                      IntToStr(iApproved)        + ',' +
                      IntToStr(iNotApproved)     + ',' +
                      QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iApproved) + sCallsApprovedRatio)+ ',' +
                      QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iApproved) + sLeadstosalesRatio) + ',' +
                      IntToStr(iSales)           + ',' +
                      QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iSales) + sCallsSalesRatio) +');');

      qry.Next;
    end;
    if qry2.SQL.Count > 0 then
      qry2.Execute;

    // Clients (no source assigned in marketingContacts but has a ClientID: so get the source from tblClients using MedTypeID)
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ML.LeadID,ML.ClientID,MC.Source,C.MedTypeId,Count(C.MedTypeId) as SourceCount,S.MediaType,S.Active');
    qry.SQL.Add('FROM tblmarketingleads ML');
    qry.SQL.Add('INNER JOIN tblmarketingleadlines MLL ON ML.LeadID = MLL.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON  MC.Company=ML.Company');
    qry.SQL.Add('INNER JOIN tblclients C ON C.ClientId = ML.ClientID');
    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add('INNER JOIN tblsource S ON C.MedTypeId = S.MedTypeID');
    qry.SQL.Add('AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add('AND ST.Name<> "Email"');
    qry.SQL.Add('AND C.MedTypeId > 0');
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('WHERE MC.Source IS NULL ');
    qry.SQL.Add('AND S.Active = "T"');
    qry.SQL.Add('GROUP BY C.MedTypeID');
    qry.Open;
    qry.First;

    qry2.Sql.Clear;
    while not qry.Eof do begin
      iCalls := qry.FieldByName('SourceCount').AsInteger;
      sName  := qry.FieldByName('MediaType').AsString;
      if sName = '' then begin
        qry.Next;
        Continue;
      end;
      iDMContacted      := GetDMContacted(qry.fieldByName('ClientID').AsInteger);
      iLeads            := GetClientTypeLeads(sName);
      iApproved         := GetApproved(qry.fieldByName('ClientID').AsInteger);
      iNotApproved      := iLeads - iApproved;


      qry2.Sql.Add(InsertSQL);
      qry2.Sql.Add(' VALUES(' +
                    QuotedStr(sName)  + ',' +
                    IntToStr(iCalls) +  ',' +
                    IntToStr(iDMContacted) + ',' +
                    IntToStr(iLeads) + ',' +
                    IntToStr(iApproved) + ',' +
                    IntToStr(iNotApproved) +',' +
                    QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iApproved) + sCallsApprovedRatio)+ ',' +
                    QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iApproved) + sLeadstosalesRatio)  + ',' +
                    IntToStr(iSales) + ',' +
                    QuotedStr(IntToStr(iCalls) + ':' + IntToStr(iSales) + sCallsSalesRatio) + ');');

      qry.Next;
    end;
    if qry2.Sql.count >0 then qry2.Execute;
  finally
    FreeAndNil(qry);
    FreeAndNil(qry2);
  end;
end;

procedure TfrmMarketingRatios.AddDataToTempTableManual;
const
(*
  csManual = 'select'#13#10 + // 1 as details, ID, DateOfReport, DateFrom, DateTo, CreatedOn, Comments, Active, Employeename,
             'Googlevisitcount, ColdCalls, Contact, FirstDemo, SecondDemo, Quotes, SalesOrders, Sales,'#13#10 +
             '(ifnull(Sales, 0) * 100) / ifnull(ColdCalls, 1) as Ratio,'#13#10 +
             'ifnull(BudgetCost, 0) / ifnull(Sales, 1) as COS, T.Source as Source'#13#10 +
             'from ( Select'#13#10 +
             'RL.Source as Source,'#13#10 +
             'Convert(R.Googlevisitcount, signed) as Googlevisitcount,'#13#10 +
             'Convert(Sum(RL.ColdCalls),signed) as ColdCalls,'#13#10 +
             'Convert(Sum(RL.Contact),signed) as Contact ,'#13#10 +
             'Convert(Sum(RL.FirstDemo),signed) as FirstDemo,'#13#10 +
             'Convert(Sum(RL.SecondDemo), signed) as SecondDemo,'#13#10 +
             'Convert(Sum(RL.Quotes),signed) as Quotes,'#13#10 +
             'Convert(Sum(RL.SalesOrders),signed) as SalesOrders,'#13#10 +
             'Convert(Sum(RL.Sales),signed) as Sales,'#13#10 +
             'Convert(Sum(RL.BudgetCost), signed) as BudgetCost'#13#10 +
             'from tblSalesAnalysisManual R'#13#10 +
             'inner join tblSalesAnalysisManuallines RL on R.Id = RL.SalesAnalysisID'#13#10 +
             'inner join tblemployees E on R.createdby = E.employeeID';
*)
  csManual = 'select'#13#10 +
             'T.Source  as Source, T.CreatedOn as LineDate, ColdCalls, Contact,'#13#10 +
             'FirstDemo, SecondDemo, Quotes, SalesOrders, Sales, Googlevisitcount,'#13#10 +
             'concat(ifnull(Sales, 0), "/", ifnull(ColdCalls, 0), " = ", Round((ifnull(Sales, 0) * 100) / ifnull(ColdCalls, 1), 2), "%") as CallSalesRatio,'#13#10 +
             'concat(ifnull(BudgetCost,0), "/", ifnull(Sales, 0), " = ", Round(ifnull(BudgetCost, 0) / ifnull(Sales, 1),2), "%") as BudgetSalesRatio'#13#10 +
             'from ( Select'#13#10 +
             'RL.Source as Source,R.CreatedOn,'#13#10 +
             'Convert(R.Googlevisitcount, signed) as Googlevisitcount,'#13#10 +
             'Convert(Sum(RL.ColdCalls),signed) as ColdCalls,'#13#10 +
             'Convert(Sum(RL.Contact),signed) as Contact ,'#13#10 +
             'Convert(Sum(RL.FirstDemo),signed) as FirstDemo,'#13#10 +
             'Convert(Sum(RL.SecondDemo), signed) as SecondDemo,'#13#10 +
             'Convert(Sum(RL.Quotes),signed) as Quotes,'#13#10 +
             'Convert(Sum(RL.SalesOrders),signed) as SalesOrders,'#13#10 +
             'Convert(Sum(RL.Sales),signed) as Sales,'#13#10 +
             'Convert(Sum(RL.BudgetCost), signed) as BudgetCost'#13#10 +
             'from tblSalesAnalysisManual R'#13#10 +
             'inner join tblSalesAnalysisManuallines RL on R.Id = RL.SalesAnalysisID';
(*
  csManualWhere = 'Where'#13#10 +
                 '(R.DateFrom >= :dateFrom and R.DateFrom <= :DateTo) or'#13#10 +
                 '(R.Dateto >= :dateFrom and R.Dateto <= :DateTo) or'#13#10 +
                 '(R.DateFrom  <= :dateFrom and R.Dateto >= :DateTo)';
*)
 csManualWhere = 'Where'#13#10 +
                 '(R.DateFrom >= "%s" and R.DateFrom <= "%s") or'#13#10 +
                 '(R.Dateto >= "%s" and R.Dateto <= "%s") or'#13#10 +
                 '(R.DateFrom  <= "%s" and R.Dateto >= "%s")';
  csManualEnd = 'group by RL.Source) T';

var
  qry : TERPCommand;
  sFrom,
  sTo : string;
begin
//
  qry := TERPCommand.Create(nil);
  qry.SQL.Clear;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Add('DELETE FROM ' + TableManual + ';');
    qry.sql.Add('INSERT HIGH_PRIORITY INTO ' + TableManual +
      '(Source,LineDate,ColdCalls,Contact, FirstDemo, SecondDemo, Quotes, SalesOrders, Sales,GoogleVisitCount,CallsSalesRatio, BudgetToSalesRatio)');
    qry.SQL.Add(csManual);
    if not chkIgnoreDates.Checked then
    begin
      sFrom := FormatDateTime(MySQLDateFormat, dtFrom.Date);
      sTo := FormatDateTime(MySQLDateFormat, dtTo.Date);
      qry.SQL.Add(Format(csManualWhere, [sFrom, sTo, sFrom, sTo, sFrom, sTo]));
    end;
    qry.SQL.Add(csManualEnd);


    if qry.sql.Count > 0 then
      qry.Execute;
  finally
    qry.Free;
  end;
(*
// Columns
  c := grdMain.ColumnByName('Source');
  if assigned(c) then
  begin
    c.DisplayLabel := 'Employee';
  end;
*)
end;

function TfrmMarketingRatios.GetApproved(Const sSource:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;        //assume type will be "approved" only on one leadline for the lead
    qry.SQL.Add('SELECT Count(MLL.LeadID) as ApprovedCount,');
    qry.SQL.Add(' MC.Source,MLL.CreationDate');
    qry.SQL.Add(' FROM tblmarketingleadlines as MLL');
    qry.SQL.Add(' INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add('INNER JOIN tblmarketingleads ML ON MLL.LeadID=ML.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON ML.Company = MC.Company');
    qry.SQL.Add(' AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add(' AND ST.Name= "approved"');
    qry.SQL.Add(' AND MC.Source = ' + QuotedStr(sSource));
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add(' GROUP BY MLL.ActionType');
    qry.Open;
    Result := qry.FieldByName('ApprovedCount').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmMarketingRatios.GetClientTypeLeads(Const MediaType:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ML.LeadID,ML.ClientID,MC.Source,C.MedTypeId,S.MediaType');
    qry.SQL.Add('FROM tblmarketingleads ML');
    qry.SQL.Add('INNER JOIN tblmarketingleadlines MLL ON ML.LeadID = MLL.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON  MC.Company=ML.Company');
    qry.SQL.Add('INNER JOIN tblclients C ON C.ClientId = ML.ClientID');
    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add('INNER JOIN tblsource S ON C.MedTypeId = S.MedTypeID');
    qry.SQL.Add('AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add('AND ST.Name<> "Email"');
    qry.SQL.Add('AND MLL.IsLead = "T"');
    qry.SQL.Add('WHERE S.MediaType = ' + QuotedStr(MediaType));
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('Group by ML.LeadID');
    qry.Open;

    Result := qry.RecordCount;
   finally
     FreeAndNil(qry);
   end;
end;


function TfrmMarketingRatios.GetLeads(Const MediaType:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ML.LeadID,ML.ClientID,MC.Source');
    qry.SQL.Add('FROM tblmarketingleads ML');
    qry.SQL.Add('INNER JOIN tblmarketingleadlines MLL ON ML.LeadID = MLL.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON  MC.Company=ML.Company');
    qry.SQL.Add('AND MLL.IsLead = "T"');
    qry.SQL.Add('WHERE MC.Source = ' + QuotedStr(MediaType));

    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('Group by ML.LeadID');
    qry.Open;

    Result := qry.RecordCount;
   finally
     FreeAndNil(qry);
   end;
end;

function TfrmMarketingRatios.GetSales(Const Source:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    //qry.SQL.Add('SELECT Count(MLL.LeadLineID) as SalesCount,');
//    qry.SQL.Add('MLL.EmployeeID,MLL.CreationDate');
//    qry.SQL.Add('FROM tblmarketingleadlines as MLL');
//    qry.SQL.Add('INNER JOIN tblmarketingleads ML ON MLL.LeadID= ML.LeadID');
//    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON ML.Company=MC.Company');
//    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
//    qry.SQL.Add('WHERE Source = ' + QuotedStr(Source));
//    qry.SQL.Add('AND ST.TypeCode="LeadActiontype"');
//    qry.SQL.Add('AND ST.Name= "Invoice" OR ST.Name = "SalesOrder"');
//    qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
//      '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
//
//    qry.SQL.Add('GROUP BY MLL.EmployeeID');
(*  useless stuff - joining on tblSales basically count all sales done for the all clients
    that have leads
      qry.SQL.Add('SELECT MLL.ResultTypeName,MLL.LeadID,ML.Company,');
      qry.SQL.Add('tblSales.saleId, tblSales.clientID');
      qry.SQL.Add('FROM tblmarketingleadlines as MLL');
      qry.SQL.Add('inner join tblmarketingleads ML on MLL.LeadID=ML.LeadID');
      qry.SQL.Add('inner join tblSales on  tblSales.ClientID=ML.ClientID  and tblSales.Converted  <> "T"  and tblSales.IsQuote <> "T"');
      qry.SQL.Add('WHERE (MLL.ResultTypeName = "Invoice") OR (MLL.ResultTypeName = "SalesOrder")');
      if not chkIgnoreDates.Checked then
        qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
      qry.SQL.Add('AND Company = ' + quotedStr(Source));
      qry.SQL.Add('Group by  tblSales.SaleID');
*)
      qry.sql.text := 'select count(*) from tblmarketingleads ML';
      qry.SQL.Add('inner join tblmarketingleadlines MLL on MLL.Leadid=ml.leadid');
      qry.SQL.Add('inner join tblMarketingContacts MC on MC.Company=ML.Company');
      qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
      qry.SQL.Add('where MLL.ResultTypeName in ("Invoice", "SalesOrder")');
      qry.SQL.Add('AND ST.TypeCode="LeadActiontype" AND (ST.Name= "Invoice" OR ST.Name = "SalesOrder")');
      if not chkIgnoreDates.Checked then
        qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
      qry.SQL.Add(' and MC.Source=' + quotedStr(Source));

//WHERE MLL.EmployeeID= 1
    qry.Open;
//@@@    Result := qry.RecordCount;
    Result := qry.Fields[0].asInteger;
//    Result := qry.FieldByName('SalesCount').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmMarketingRatios.GetCalls(Const Source:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('Select MC.Source,MC.Company,MLL.IsLead,ML.ClientID,Count(MLL.LeadID) as CallCount');
    qry.SQL.Add('FROM tblmarketingleadlines MLL');
    qry.SQL.Add('INNER JOIN tblmarketingleads ML ON MLL.LeadID= ML.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON ML.Company=MC.Company');
    qry.SQL.Add('WHERE MLL.IsLead = "F"');
    qry.SQL.Add('AND Source = ' + QuotedStr(Source));
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');

    qry.SQL.Add('GROUP BY MC.Source');
    qry.Open;
    Result :=  qry.FieldByName('CallCount').AsInteger;
   finally
     FreeAndNil(qry);
   end;
end;


function TfrmMarketingRatios.GetDMContacted(Const Source:String):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Count(MC.Company) as DMCount,MLL.CreationDate,');
    qry.SQL.Add('MLL.LeadID,ML.LeadID,ML.Company,MC.Source');
    qry.SQL.Add('FROM tblmarketingleadlines MLL');
    qry.SQL.Add(' INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add(' AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add(' AND ST.Name= "DM Contacted"');
    qry.SQL.Add('INNER JOIN tblmarketingleads ML ON MLL.LeadID = ML.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON MC.Company=ML.Company');
    qry.SQL.Add('WHERE (MC.Source = ' + QuotedStr(Source) + ') OR (MC.Source is NULL)');
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('GROUP BY MC.Source');
    qry.Open;
    Result := qry.FieldByName('DMCount').AsInteger;
   finally
     FreeAndNil(qry);
   end;
end;

function TfrmMarketingRatios.GetDMContacted(Const ClientID:integer):integer;
var
  qry:TERPQuery;
begin
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ML.LeadID,ML.ClientID,MC.Source,C.MedTypeId,Count(C.MedTypeId) as DMCount,S.MediaType');
    qry.SQL.Add('FROM tblmarketingleads ML');
    qry.SQL.Add('INNER JOIN tblmarketingleadlines MLL ON ML.LeadID = MLL.LeadID');
    qry.SQL.Add('INNER JOIN tblmarketingcontacts MC ON  MC.Company=ML.Company');
    qry.SQL.Add('INNER JOIN tblclients C ON C.ClientId = ML.ClientID');
    qry.SQL.Add('INNER JOIN tblsimpletypes ST ON MLL.ActionType =ST.Id');
    qry.SQL.Add('INNER JOIN tblsource S ON C.MedTypeId = S.MedTypeID');
    qry.SQL.Add('AND ST.TypeCode="LeadActiontype"');
    qry.SQL.Add('AND ST.Name= "Direct Marketing"');
    qry.SQL.Add('AND C.MedTypeId > 0');
    if not chkIgnoreDates.Checked then
      qry.SQL.Add('AND MLL.CreationDate Between "' + FormatDateTime(MysqlDateFormat, dtfrom.DateTime) +
        '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime + 1) + '" ');
    qry.SQL.Add('WHERE MC.Source IS NULL ');
    qry.SQL.Add('AND ML.ClientID =  ' + IntToStr(ClientID));
    qry.SQL.Add('GROUP BY C.MedTypeID');
    qry.Open;
    Result := qry.FieldByName('DMCount').AsInteger;
   finally
     FreeAndNil(qry);
   end;
end;

function TfrmMarketingRatios.GetApproved(Const iClientID:integer):integer;
begin
  Result := 0;
end;

procedure TfrmMarketingRatios.DeleteTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + TableName + ';');
    qryTemp.SQL.Add('DROP TABLE IF EXISTS ' + TableManual + ';');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmMarketingRatios.DeleteDataTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + TableName + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmMarketingRatios.FormCreate(Sender: TObject);
begin
  inherited;
  Tablename := 'tmp_MarketingRatios_' + GetMachineIdentification(true, true, true, true);
  TableManual := 'tmp_maretingRatios_Manual_' + GetMachineIdentification(true, true, true, true);
  if not ErrorOccurred then begin
    CreateTempTable;
    CreateTempTableManual;
    Qrymain.Disablecontrols;
    try
      if qrymain.Active then Qrymain.close;
      Qrymain.SQL.clear;
      Qrymain.SQL.add('SELECT ID,Source,LineDate,GlobalRef,Calls,DMContacted,Leads,Approved,NotApproved,');
      Qrymain.SQL.add('CallsApprovedRatio,LeadstosalesRatio,Sales,CallsSalesRatio');
      Qrymain.SQL.add('FROM ' + TableName);
      RefreshOrignalSQL;
    finally
        Qrymain.EnableControls;
    end;

    qryManual.Disablecontrols;
    try
      if qryManual.Active then qryManual.close;
      qryManual.SQL.clear;
      qryManual.SQL.add('SELECT ID,Source,LineDate,ColdCalls,Contact, FirstDemo, SecondDemo, Quotes, SalesOrders,');
      qryManual.SQL.add('Sales,GoogleVisitCount,CallsSalesRatio, BudgetToSalesRatio');
      qryManual.SQL.add('FROM ' + TableManual);
//      RefreshOrignalSQL;
    finally
        qryManual.EnableControls;
    end;
  end;

  grdManual.TitleColor := Self.Color;
  grdManual.FooterColor := Self.Color;

  mQry := qryManual;
  mGrid := grdManual;
  aQry := qryMain;
  aGrid := grdMain;
end;

procedure TfrmMarketingRatios.FormShow(Sender: TObject);
begin
  inherited;  
  if not ErrorOccurred then begin
    grpFilters.ItemIndex := 0;
    AddDataToTempTable;
    RefreshQuery;
(*    Application.ShowHint := true;
    Application.HintPause := 100;
    Application.HintHidePause := 5000;*)
    grdMain.ShowHint := true;
    grdMain.Hint := 'LEGEND: Calls                 - Number of calls made for this Date Range.'    + #10#13+
                    '               DM Contacted  - Number of Decision Makers Contacted.' + #10#13+
                    '               Leads               - New Leads given for the Date Range.' + #10#13+
                    '               Approved         - Number of leads with an "Approved" line.' + #10#13+
                    '               Not Approved  - Number of leads with a "Not Approved" line.' + #10#13+
                    '               Sales                - Leads that have been converted into a Sales Order or Invoice.';

  end;
end;

procedure TfrmMarketingRatios.RefreshQuery;
var
  TotalCalls,TotalDMContacted,TotalLeads,TotalApproved,TotalNotApproved,TotalSales:integer;
begin
  DeleteDataTempTable;
  AddDataToTempTable;
  inherited;
  TotalCalls            := 0;
  TotalDMContacted      := 0;
  TotalLeads            := 0;
  TotalApproved         := 0;
  TotalNotApproved      := 0;

  if grpFilters.ItemIndex <= 0 then
  begin
    qryMain.DisableControls;
    with qryMain do begin
      First;
      TotalSales        := qryMain.FieldByName('Sales').AsInteger;
      while not Eof do begin
        TotalCalls        := TotalCalls + qryMain.FieldByName('Calls').AsInteger;
        TotalDMContacted  := TotalDMContacted + qryMain.FieldByName('DMContacted').AsInteger;
        TotalLeads        := TotalLeads + qryMain.FieldByName('Leads').AsInteger;
       TotalApproved     := TotalApproved + qryMain.FieldByName('Approved').AsInteger;
         TotalNotApproved  := TotalNotApproved + qryMain.FieldByName('NotApproved').AsInteger;
        //TotalSales        := TotalSales + qryMain.FieldByName('Sales').AsInteger;
        Next;
      end;
    end;
    qryMain.EnableControls;
    grdMain.ColumnByName('Calls').FooterValue := IntToStr(TotalCalls);
    grdMain.ColumnByName('DMContacted').FooterValue := IntToStr(TotalDMContacted);
    grdMain.ColumnByName('Leads').FooterValue := IntToStr(TotalLeads);
    grdMain.ColumnByName('Approved').FooterValue := IntToStr(TotalApproved);
    grdMain.ColumnByName('NotApproved').FooterValue := IntToStr(TotalNotApproved);
    grdMain.ColumnByName('Sales').FooterValue := IntToStr(TotalSales);
    qryMain.First;
  end
  else
  begin
    qryManual.Close;
    qryManual.Open;
  end;
end;

procedure TfrmMarketingRatios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DeleteTempTable;
  inherited;
end;

procedure TfrmMarketingRatios.grdMainDblClick(Sender: TObject);
var
  frm:TComponent;
begin
  Processingcursor(True);
  try
    if grdMain.GetActiveField.FieldName = 'Leads' then begin
      frm := GetComponentByClassName('TMarketingLeadsGUI');
      if Assigned(frm) then begin
        with TMarketingLeadsGUI(frm) do
        begin
          SourceFilter := self.qryMainSource.asString;//qryMain.FieldByName('Source').AsString;
          FilterOnSource := true;
          ShowModal;
          exit;
        end;
      end;
    end else if grdMain.GetActiveField.FieldName = 'Calls' then begin
      frm := GetComponentByClassName('TMarketingContactGUI');
      if Assigned(frm) then begin
        with TForm(frm) do begin
          ShowModal;
          exit;
        end;
      end;
    end else if grdMain.GetActiveField.FieldName = 'Source' then begin
      frm := GetComponentByClassName('TSourceListGUI');
      if Assigned(frm) then begin
        with TForm(frm) do begin
          ShowModal;
          exit;
        end;
      end;
    end;
  finally
    Processingcursor(False);
  end;
  inherited;
end;

procedure TfrmMarketingRatios.grpFiltersClick(Sender: TObject);
begin
//  inherited;
//
(*
  if grpFilters.ItemIndex <= 0 then
  begin

    grdManual.Visible := false;
    grdMain.Visible := true;
    grdMain.Align := alClient;
  end
  else
  begin
    grdMain.Visible := false;
    grdManual.Visible := true;
    grdManual.Align := alClient;
  end;
*)
  if grpFilters.ItemIndex <= 0 then
  begin
    mGrid.Visible := false;
    aGrid.Visible := true;
    aGrid.Align := alClient;
    qryMain := aQry;
    grdMain := aGrid;
    RefreshOrignalSQL;
    btnCustomize.Enabled := true;
  end
  else
  begin
    aGrid.Visible := false;
    mGrid.Visible := true;
    mGrid.Align := alClient;

    qryMain := mQry;
    grdMain := mGrid;
    RefreshOrignalSQL;
    btnCustomize.Enabled := false;
  end;

  RefreshQuery;

end;

procedure TfrmMarketingRatios.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmMarketingRatios.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmMarketingRatios.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    dlgPrint.ObjectToPrint := grdMain;
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmMarketingRatios);
end.
